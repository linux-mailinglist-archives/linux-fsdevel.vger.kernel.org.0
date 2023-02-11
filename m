Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E705E69331F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Feb 2023 19:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBKS53 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Feb 2023 13:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBKS52 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Feb 2023 13:57:28 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F1E199E0
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Feb 2023 10:57:27 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id m2so23110325ejb.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Feb 2023 10:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3PcKjkZEscdfAV5ya0phdN14wwNaXoRb40kNT9Dczeo=;
        b=YHVu5kUXNJwub6fL2bFRhFub6fqpPJshyUtgnUVxZxBIopwouTR/KgSkKN4JSR5uve
         Wkfn8LbbiLtb+QLkrXegG9Ji77YU2cy+xueHjxfB9bGAjhzAGT4k9x0ToEiwbgOMILfW
         LyuiuxNGORWZQC9nxgiaZUsmJDUDBv4eCG8b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PcKjkZEscdfAV5ya0phdN14wwNaXoRb40kNT9Dczeo=;
        b=CEYPa33U+0wCHpRIhJO2A5JeLJ7Aosp1NJSr0XQT6T7lXuUXJWgZXW+ICGh4O5WXgv
         elXqSPgdmWlRce67Llwie5dHab1TRNpAFueRvTySBb29uGA9nVVCX0apiaHjUybUe/gq
         rehWY14efpwNCitxXJihKFYHVoJDqQSmlLZ+PBAFV8WUhaP8O7hcZHQeM+EuHplIbKTB
         y4l+xXRzl4ibOnUToB2CEa56mkMy7HcvjZMh2kU0Gc0a4Ae5v1Zq4NxCEafcYMC/qtb7
         vSqz88NOb3Dwoh5hRFe3UvAsF1bk4uc6h4u1XhMJ244P9ZIJU2DxVVNUbtbh8zRC6GG7
         AvtQ==
X-Gm-Message-State: AO0yUKV46AdWbYCvUDELeOk3otadlYshk4uyjGKFaY2IkeIAqQx6Pd3p
        TTpL0lJxYaB8ipXoHUP3STibGsARfliRZ/P4u6c=
X-Google-Smtp-Source: AK7set/7J/j2Z5UsNuYvm2PmRC5MlraFKVCvb4tD8uQv/yq4ejM5f5RmoH6nUr1+JO0tv5fIJcWZnA==
X-Received: by 2002:a17:906:8a69:b0:87b:dac1:bbe6 with SMTP id hy9-20020a1709068a6900b0087bdac1bbe6mr18211322ejc.36.1676141845969;
        Sat, 11 Feb 2023 10:57:25 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709060ec900b008aac35b1c2esm4240485eji.173.2023.02.11.10.57.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 10:57:25 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id fj20so8203967edb.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Feb 2023 10:57:24 -0800 (PST)
X-Received: by 2002:a50:c353:0:b0:4ac:b616:4ba9 with SMTP id
 q19-20020a50c353000000b004acb6164ba9mr1152399edb.5.1676141844693; Sat, 11 Feb
 2023 10:57:24 -0800 (PST)
MIME-Version: 1.0
References: <20230210153212.733006-1-ming.lei@redhat.com> <20230210153212.733006-2-ming.lei@redhat.com>
 <Y+e3b+Myg/30hlYk@T590>
In-Reply-To: <Y+e3b+Myg/30hlYk@T590>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Feb 2023 10:57:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgTzLjvhzx-XGkgEQmXH6t=8OTFdQyhDgafGdC2n5gOfg@mail.gmail.com>
Message-ID: <CAHk-=wgTzLjvhzx-XGkgEQmXH6t=8OTFdQyhDgafGdC2n5gOfg@mail.gmail.com>
Subject: Re: [PATCH 1/4] fs/splice: enhance direct pipe & splice for moving
 pages in kernel
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 11, 2023 at 7:42 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> +/*
> + * Used by source/sink end only, don't touch them in generic
> + * splice/pipe code. Set in source side, and check in sink
> + * side
> + */
> +#define PIPE_BUF_PRIV_FLAG_MAY_READ    0x1000 /* sink can read from page */
> +#define PIPE_BUF_PRIV_FLAG_MAY_WRITE   0x2000 /* sink can write to page */
> +

So this sounds much more sane and understandable, but I have two worries:

 (a) what's the point of MAY_READ? A non-readable page sounds insane
and wrong. All sinks expect to be able to read.

 (b) what about 'tee()' which duplicates a pipe buffer that has
MAY_WRITE? Particularly one that may already have been *partially*
given to something that thinks it can write to it?

So at a minimum I think the tee code then needs to clear that flag.
And I think MAY_READ is nonsense.

          Linus
