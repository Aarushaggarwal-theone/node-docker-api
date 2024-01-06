# syntax=docker/dockerfile:1


ARG NODE_VERSION=21.5.0

FROM node:${NODE_VERSION}-alpine


ENV NODE_ENV production


WORKDIR /usr/src/app


RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci --omit=dev


USER node


COPY . .


EXPOSE 2101


CMD node server.js