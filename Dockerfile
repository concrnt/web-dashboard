FROM node:18 AS webbuilder
WORKDIR /work

COPY . .
RUN npm i -g pnpm \
 && pnpm i && pnpm build

FROM nginx
ARG VERSION

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=webbuilder /work/dist /usr/share/nginx/html
RUN echo "{\"name\": \"github.com/concrnt/web-dashboard\", \"version\": \"${VERSION:-unknown}\"}" > /cc-info

