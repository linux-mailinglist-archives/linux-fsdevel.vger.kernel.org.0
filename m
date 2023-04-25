Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6EB6EE5B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 18:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjDYQ3R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 12:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbjDYQ3Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:29:16 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97269022
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 09:29:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-504eac2f0b2so10359224a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 09:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682440153; x=1685032153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXJ9yzP7r10T1ZjT07mC8uDa4HlfNL4ir5xqCtJ+4tY=;
        b=YRZuBoR9HymRaxJ/xpYsZre4rPO61gav+O/ySlKfsepC5WElLCw00E41w0VjKzb9IN
         FmkLX8a43VacQfFDVPsACCwZxiaoqMONlzntdcMQ9INnrhJ9smAX14HX2e5W4sqdswrr
         YkHsCNuIdEgRwUJHGzEm0w4HWDMQKz0PpLFSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682440153; x=1685032153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXJ9yzP7r10T1ZjT07mC8uDa4HlfNL4ir5xqCtJ+4tY=;
        b=P9fC1Kv6v9PNzKSv13oqXUv6D3vLHZluXuY2AKkT5Vy2t3QvScS3k7zQ37CUsSKTVs
         w2ss9PAdzMYsMom1bob7etZquqRVD877rRcHq6faA5LcEWCxJWsATp/gUcry0FmUy5/Q
         aX2F8IDiLBsnnC8YaiY8rBRprrGYxuYmoc37mjuYBW4h35NL2Pyz5lZZF/n8wMSfPCJa
         1Kcx/+cagBY3u02vms+tE5GOsz8oz82F68HYmoV/jPpbWW7MHdhcSExrxP+6fYkfppP7
         HjDRHvurQuNkLVuLHR10/cuTLXlChzqm46lPB3fO/WsgzFTyrn98v9cEMnCtmTXsbhOa
         4lDA==
X-Gm-Message-State: AAQBX9ccgSMnVkGN2pJkLO/sMDX/wFuOjxYtpUccVgOiLq2uqRciQYxC
        kSzIEys4vjEIj4bqU5mnrWCySt3X1dg0Qo1HOwKOw1t+
X-Google-Smtp-Source: AKy350ZUeWp3skpNWzX9AvPQutCtvaFks+9EAcoR1NDTmpcW5abhecaqgTvQ9Za2FImGgaatzn65qg==
X-Received: by 2002:aa7:c0c4:0:b0:504:71a7:1c69 with SMTP id j4-20020aa7c0c4000000b0050471a71c69mr15144887edp.26.1682440152826;
        Tue, 25 Apr 2023 09:29:12 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id by14-20020a0564021b0e00b0050844e1c98fsm5849971edb.82.2023.04.25.09.29.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 09:29:12 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5067736607fso10390023a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 09:29:12 -0700 (PDT)
X-Received: by 2002:a05:6402:327:b0:506:73a7:ce12 with SMTP id
 q7-20020a056402032700b0050673a7ce12mr14926793edw.36.1682440151945; Tue, 25
 Apr 2023 09:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
 <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
 <20230425060427.GP3390869@ZenIV> <20230425-sturheit-jungautor-97d92d7861e2@brauner>
In-Reply-To: <20230425-sturheit-jungautor-97d92d7861e2@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Apr 2023 09:28:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjpBq2D97ih_AA0D7+KJ8ihT6WW_cn1BQc43wVgUioH2w@mail.gmail.com>
Message-ID: <CAHk-=wjpBq2D97ih_AA0D7+KJ8ihT6WW_cn1BQc43wVgUioH2w@mail.gmail.com>
Subject: Re: [GIT PULL] pidfd updates
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 25, 2023 at 5:34=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Hell, you could even extend that proposal below to wrap the
> put_user()...
>
> struct fd_file {
>         struct file *file;
>         int fd;
>         int __user *fd_user;
> };

So I don't like this extended version, but your proposal patch below
looks good to me.

Why? Simply because the "two-word struct" is actually a good way to
return two values. But a three-word one would be passed on the stack.

Both gcc and clang return small structs (where "small" is literally
just two words) in registers, and it's part of most (all?) ABIs and
we've relied on that before.

It's kind of the same thing as returning a "long long" in two
registers, except it works with structs too.

We've relied on that for ages, with things like 'struct pte' often
being that kind of two-word struct (going back a *loong* time to the
bad old days of 32-bit x86 and PAE).

And in the vfs layer we actually also do it for 'struct fd', which is
a very similar construct.

So yes, doing something like this:

> +struct fd_file {
> +       struct file *file;
> +       int fd;
> +};

would make me happy, and still return just "one" value, it's just that
the value now is both of those things we need.

And then your helpers:

> +static inline void fd_publish(struct fd_file *fdf)
> +static inline void fd_discard(struct fd_file *fdf)

solves my other issue, except I'd literally make it pass those structs
by value, exactly like fdget/fdput does.

Now, since they are inline functions, the code generation doesn't
really change (compilers are smart enough to not actually generate any
pointer stuff), but I prefer to make things like that expliict, and
have source code that matches the code generation.

(Which is also why I do *not* endorse passing bigger structs by value,
because then the compiler will just pass it as a "pointer to a copy"
instead, again violating the whole concept of "source matches what
happens in reality")

I think the above helper could be improved further with Al's
suggestion to make 'fd_publish()' return an error code, and allow the
file pointer (and maybe even the fd index) to be an error pointer (and
error number), so that you could often unify the error/success paths.

IOW, I like this, and I think it's superior to my stupid original suggestio=
n.

                  Linus
