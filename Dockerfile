FROM ruby:2.7.2

ENV NODEJS_VERSION=v14.15.5
ENV YARN_VERSION=1.12.3

WORKDIR /app

# Install packages for building gems
RUN apt update && \
    apt install -y build-essential tzdata curl libxml2-dev libpq-dev libxslt1-dev

# Instal Node.js
RUN curl -LO https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}-linux-x64.tar.xz && \
    tar xvf node-${NODEJS_VERSION}-linux-x64.tar.xz && \
    mv node-${NODEJS_VERSION}-linux-x64 /root/node
ENV PATH /root/node/bin:$PATH

# Install Yarn
RUN curl -L https://yarnpkg.com/install.sh | bash -v -s -- --version 1.12.3
ENV PATH /root/.yarn/bin:/root/.config/yarn/global/node_modules/.bin:$PATH

# Install gems
RUN gem install bundler
COPY Gemfile* ./
RUN bundle install

# Install node packages
COPY package.json .
COPY yarn.lock .
RUN yarn install

COPY . .
RUN bin/rails assets:precompile

EXPOSE 3000

ENTRYPOINT [ "./scripts/entrypoint.sh" ]

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
