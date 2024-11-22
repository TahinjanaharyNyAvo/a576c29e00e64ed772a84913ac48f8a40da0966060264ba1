FROM node:20-alpine as base

RUN apk add --no-cache libc6-compat

WORKDIR /base 

COPY package.json yarn.lock ./

RUN yarn

FROM node:20-alpine as builder

ENV NODE_ENV=production

WORKDIR /build

COPY --from=base /base/node_modules ./node_modules
COPY src ./src
COPY public ./public
COPY package.json yarn.lock ./

RUN echo -e '/** @type {import("next").NextConfig} */\nconst nextConfig = {\n  output: "standalone",\n};\n\nexport default nextConfig;' > ./next.config.mjs

RUN yarn build

FROM node:20-alpine AS runner

ENV NODE_ENV=production
ENV PORT=3000

EXPOSE 3000

WORKDIR /app

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder /build/public ./public
COPY --from=builder --chown=nextjs:nodejs /build/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /build/.next/static ./.next/static

USER nextjs

CMD ["node", "server.js"]