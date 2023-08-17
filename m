Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBC677F784
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 15:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350893AbjHQNSl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 09:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351298AbjHQNSW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:18:22 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC71A1FF3
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 06:18:20 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-56c711a889dso5192917eaf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 06:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692278300; x=1692883100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33iebB+xSbYi7hRrLeihWN98+HaTOzHJFDGyUc/boG8=;
        b=AQvUgPT6c/TC6D28MdhpIx/iYluJXgN6ZUg6MSuVaC4RgHMK4wSvWJ0lbhrbnBpd49
         JwqkjHg+ErNEJz5TSsVtbMCxxlJpcgy+ZnIib9LWfpelL4pB8edvDf/N6yazhq7sQlq+
         uzBIvexsbACKsOxPoEemfZO1JhEn/4DeXuoZTbsvfzsLDqlbZZdezHwOpbGNEf4fgDit
         KGayuSdFKvMqrKT8EfBFtoP1w6LvmFS2Slzft/rUd43HXPPJl5OyL+x9JjpS7/iuWfuF
         tEu/cXbKsB0E7VcK5agIh3cByT1VLjsphVDBU1wgyW6gPvi2JOrM/5Pb/yCoL92MDGv5
         Qsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692278300; x=1692883100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33iebB+xSbYi7hRrLeihWN98+HaTOzHJFDGyUc/boG8=;
        b=kEGgsMavBYpfytyYGByUaZM6nbI1GTogWb72a6hXFQUXtKWrJ8rT6JVFIv+n7lGgOn
         QeZlYCaWJr+lNz3wboawHfzzL7maXmqIStmj6l/FZ4uid9Lej76JNPhQnHUPZctBqnTJ
         EXdMihAMxE3WcqyPiQUVtcJ+fHV/pUIlKwLMkl/9sVJbkdCnLk43yfslf4JBwpqDIoIX
         uSdCCuQjie/8SZcYN4zy7cbzo6FyarIrSiRBlEBK8XLD2q6BY8gANzcOs2yKyQDxC96u
         TsrzHEzUEpK3T59VUSg89Z8XA/ZCQZXllAP5OIbDH6P5F1NMF2tY9FrHsREd+2z69eck
         wTPQ==
X-Gm-Message-State: AOJu0YwdglujLTInZJzPj6Bo0hsp5yy0uVO+GACWlV1OZnyPD/cvD3dv
        QeG+Zuw+QcInRd5QROX+TVMDGOUyPauc1Rse5ww=
X-Google-Smtp-Source: AGHT+IEjdIeI2TORzkl4tuvMMrAYGTWGiVgHm8b5i4B6iX+XhKxpFHdVBbFfJLGOrxs+7NMJccqZBTgDz3/aMe34rd8=
X-Received: by 2002:a05:6358:8a6:b0:139:d5b9:87d3 with SMTP id
 m38-20020a05635808a600b00139d5b987d3mr5948096rwj.5.1692278299807; Thu, 17 Aug
 2023 06:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230816085439.894112-1-amir73il@gmail.com> <7725feff-8d9d-4b54-9910-951b79f67596@kernel.dk>
 <CAOQ4uxggGRdhyRL15b_nVuf9PHejfXmF+auxY7HPkhJVYmsnCg@mail.gmail.com> <e6948836-1d9d-4219-9a21-a2ab442a9a34@kernel.dk>
In-Reply-To: <e6948836-1d9d-4219-9a21-a2ab442a9a34@kernel.dk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 17 Aug 2023 16:18:08 +0300
Message-ID: <CAOQ4uxh4NEFH2O0twGaLrEbR8zFmKx0=Ve_3bXiTrx3LSaPefw@mail.gmail.com>
Subject: Re: [PATCH v2] fs: create kiocb_{start,end}_write() helpers
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 16, 2023 at 10:13=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 8/16/23 12:58 PM, Amir Goldstein wrote:
> >>> diff --git a/fs/aio.c b/fs/aio.c
> >>> index 77e33619de40..16fb3ac2093b 100644
> >>> --- a/fs/aio.c
> >>> +++ b/fs/aio.c
> >>> @@ -1444,17 +1444,8 @@ static void aio_complete_rw(struct kiocb *kioc=
b, long res)
> >>>       if (!list_empty_careful(&iocb->ki_list))
> >>>               aio_remove_iocb(iocb);
> >>>
> >>> -     if (kiocb->ki_flags & IOCB_WRITE) {
> >>> -             struct inode *inode =3D file_inode(kiocb->ki_filp);
> >>> -
> >>> -             /*
> >>> -              * Tell lockdep we inherited freeze protection from sub=
mission
> >>> -              * thread.
> >>> -              */
> >>> -             if (S_ISREG(inode->i_mode))
> >>> -                     __sb_writers_acquired(inode->i_sb, SB_FREEZE_WR=
ITE);
> >>> -             file_end_write(kiocb->ki_filp);
> >>> -     }
> >>> +     if (kiocb->ki_flags & IOCB_WRITE)
> >>> +             kiocb_end_write(kiocb);
> >>
> >> Can't we just call kiocb_end_write() here, it checks WRITE_STARTED
> >> anyway? Not a big deal, and honestly I'd rather just get rid of
> >> WRITE_STARTED if we're not using it like that. It doesn't serve much o=
f
> >> a purpose, if we're gating this one IOCB_WRITE anyway (which I do like
> >> better than WRITE_STARTED). And it avoids writing to the kiocb at the
> >> end too, which is a nice win.
> >>
> >
> > What I don't like about it is that kiocb_{start,end}_write() calls will
> > not be balanced, so it is harder for a code reviewer to realize that th=
e
> > code is correct (as opposed to have excess end_write calls).
> > That's the reason I had ISREG check inside the helpers in v1, so like
> > file_{start,end}_write(), the calls will be balanced and easy to review=
.
>
> If you just gate it on IOCB_WRITE and local IS_REG test, then it should
> be balanced.
>
> > I am not sure, but I think that getting rid of WRITE_STARTED will
> > make the code more subtle, because right now, IOCB_WRITE is
> > not set by kiocb_start_write() and many times it is set much sooner.
> > So I'd rather keep the WRITE_STARTED flag for a more roust code
> > if that's ok with you.
>
> Adding random flags to protect against that is not a good idea imho. It
> adds overhead and while it may seem like it's hardening, it's also then
> just making it easier to misuse.
>
> I would start with just adding the helpers, and having the callers gate
> them with IOCB_WRITE && IS_REG like they do now.
>

All right.

> >> index b2adee67f9b2..8e5d410a1be5 100644
> >>> --- a/include/linux/fs.h
> >>> +++ b/include/linux/fs.h
> >>> @@ -338,6 +338,8 @@ enum rw_hint {
> >>>  #define IOCB_NOIO            (1 << 20)
> >>>  /* can use bio alloc cache */
> >>>  #define IOCB_ALLOC_CACHE     (1 << 21)
> >>> +/* file_start_write() was called */
> >>> +#define IOCB_WRITE_STARTED   (1 << 22)
> >>>
> >>>  /* for use in trace events */
> >>>  #define TRACE_IOCB_STRINGS \
> >>> @@ -351,7 +353,8 @@ enum rw_hint {
> >>>       { IOCB_WRITE,           "WRITE" }, \
> >>>       { IOCB_WAITQ,           "WAITQ" }, \
> >>>       { IOCB_NOIO,            "NOIO" }, \
> >>> -     { IOCB_ALLOC_CACHE,     "ALLOC_CACHE" }
> >>> +     { IOCB_ALLOC_CACHE,     "ALLOC_CACHE" }, \
> >>> +     { IOCB_WRITE_STARTED,   "WRITE_STARTED" }
> >>>
> >>>  struct kiocb {
> >>>       struct file             *ki_filp;
> >>
> >> These changes will conflict with other changes in linux-next that are
> >> going upstream. I'd prefer to stage this one after those changes, once
> >> we get to a version that looks good to everybody.
> >
> > Changes coming to linux-next from your tree?
> > I was basing my patches on Christian's vfs.all branch.
> > Do you mean that you would like to stage this cleanup?
> > It's fine by me.
>
> From the xfs tree, if you look at linux-next you should see them. I
> don't care who stages it, but I don't want to create needless merge
> conflicts because people weren't aware of these conflicts.
>

Ok. I got rid of IOCB_WRITE_STARTED, so there is no conflict now.

Thanks,
Amir.
