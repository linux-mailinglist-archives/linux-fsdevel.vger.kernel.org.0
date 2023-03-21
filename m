Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CAC6C3862
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 18:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCURhw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 13:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjCURhv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:37:51 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C119813DE2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 10:37:03 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ek18so62801956edb.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 10:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679420165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hy3AwSsMA87i05lUHsoXtMd3VNig+4S9hQg//IlQ/pQ=;
        b=V2SnLsA77wc1oHbJd58PdEVJ3CAjhGtFKXMJ6zNcmwe05R8KdVUM0oBJhUOR90Jvuh
         k0+wAKe638/okzulT4+xAIbRBKPbGHxGu5O5ietgeyWou4Tmg7tRwb0igf1JzMycY+Qn
         0DaRf08N6aUwbw5IW/Z0RuoRJYFGsPr6vRKpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679420165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hy3AwSsMA87i05lUHsoXtMd3VNig+4S9hQg//IlQ/pQ=;
        b=dwqc4/txjjtbX63JppMsGtuydqkt8rth1L112i1AambyYR/sAyggMd5ImyqEVZuFqa
         qFyqpgVHvWOFwWs3PlH/ZyvjJwdmPQMZwFgsv+fyhpn7nQublNQ4ZCvne7OH1ZQXTN1L
         6Hk3wVgHGs4onpJxKF9lcBaH0JUQOu05HFYnNRBVdSRp0C7x9K53CG0bEIKvoDKEHK7y
         JOq3JcguH+pKXfc/ri/gxpfKXzXkdxVmX1hcFpTdU+edjLNeAmww8U7QLZjH9silyE2y
         DFMsedZreR8Qpgt6SpZrP33GrUYAiNpS1Rq2lKHGFvvGhOBoPy8yA1zM0PnmvLGuUZ1v
         u6VA==
X-Gm-Message-State: AO0yUKWpLZjpt1SztcfLQH2HqWGJ8vTO+FdSziMzLcVYVUme6IZ6Kbl/
        nRcC6nGx9fe1YXFXJ9QeGI03+/HYtVukIVtErcy2Vw==
X-Google-Smtp-Source: AK7set83XnNjRYxemELu9Sg3reboGqXFb5g8ef9oepU3sZb/N/SsQIzWUJtfZFQIcUmXxPyxMB8Swg==
X-Received: by 2002:aa7:db4f:0:b0:500:50f6:dd30 with SMTP id n15-20020aa7db4f000000b0050050f6dd30mr4280463edt.15.1679420165178;
        Tue, 21 Mar 2023 10:36:05 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090668cc00b008d044ede804sm4026251ejr.163.2023.03.21.10.36.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 10:36:04 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id i5so15884014eda.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 10:36:04 -0700 (PDT)
X-Received: by 2002:a50:c343:0:b0:4fa:cef4:a27f with SMTP id
 q3-20020a50c343000000b004facef4a27fmr2107141edb.2.1679420164105; Tue, 21 Mar
 2023 10:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230320071442.172228-1-pedro.falcato@gmail.com>
 <20230320115153.7n5cq4wl2hmcbndf@wittgenstein> <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
 <CAKbZUD2Y2F=3+jf+0dRvenNKk=SsYPxKwLuPty_5-ppBPsoUeQ@mail.gmail.com>
 <CAHk-=wgc9qYOtuyW_Tik0AqMrQJK00n-LKWvcBifLyNFUdohDw@mail.gmail.com>
 <20230321142413.6mlowi5u6ewecodx@wittgenstein> <20230321161736.njmtnkvjf5rf7x5p@wittgenstein>
In-Reply-To: <20230321161736.njmtnkvjf5rf7x5p@wittgenstein>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Mar 2023 10:35:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2mLKn6U7_aXMtP46TVSY6MTHv+ff-+xVFJbO914o65A@mail.gmail.com>
Message-ID: <CAHk-=wi2mLKn6U7_aXMtP46TVSY6MTHv+ff-+xVFJbO914o65A@mail.gmail.com>
Subject: Re: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
To:     Christian Brauner <brauner@kernel.org>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 21, 2023 at 9:17=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
>  #define WILL_CREATE(flags)     (flags & (O_CREAT | __O_TMPFILE))
> +#define INVALID_CREATE(flags) \
> +       ((flags & (O_DIRECTORY | O_CREAT)) =3D=3D (O_DIRECTORY | O_CREAT)=
)
>  #define O_PATH_FLAGS           (O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CL=
OEXEC)
>
>  inline struct open_how build_open_how(int flags, umode_t mode)
> @@ -1207,6 +1209,10 @@ inline int build_open_flags(const struct open_how =
*how, struct open_flags *op)
>                 if (!(acc_mode & MAY_WRITE))
>                         return -EINVAL;
>         }
> +
> +       if (INVALID_CREATE(flags))
> +               return -EINVAL;
> +
>         if (flags & O_PATH) {
>                 /* O_PATH only permits certain other flags to be set. */
>                 if (flags & ~O_PATH_FLAGS)

So the patch looks simple enough, but

 (a) I'm not entirely sure I like the extra indirection through
another #define. This impenetrable thicket of different macros makes
it a bit hard to see what is going on. I'm not blaming you for it, it
predates this patch, but..

 (b) this seems to make that O_TMPFILE_MASK macro pointless.

I think (b) kind of re-inforces the point of (a) here.

The only reason for O_TMPFILE_MASK is literally that old historical
"make sure old kernels return errors when they don't support
O_TEMPFILE", and thus the magic re-use of old bit patterns.

But now that we do that "return error if both O_DIRECTORY and O_CREAT
are set", the O_TMPFILE_MASK check is basically dead, because it ends
up checking for that same bit pattern except also __O_TMPFILE.

And that is *not* obvious from the code, exactly because of that
thicket of different macros.

In fact, since that whole

        if ((flags & O_TMPFILE_MASK) !=3D O_TMPFILE)
                return -EINVAL;

is done inside an "if (flags & __O_TMPFILE)", the compiler might as
well reduce it *exactly* down to that exact same test as
INVALID_CREATE() now is.

So I really get the feeling that the macros actually hide what is
going on, and are the exact opposite of being helpful. Case in point:
with your patch, you now have the exact same test twice in a row,
except it *looks* like two different tests and one of them is
conditional on __O_TMPFILE.

For all I know, the compiler may actually notice the redundancy and
remove one of them, but we shouldn't write bad code with the
expectation that "the compiler will fix it up". Particularly when it
just makes it harder for people to understand too.

                     Linus
