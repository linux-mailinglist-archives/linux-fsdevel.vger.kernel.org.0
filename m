Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1C0343787
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 04:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhCVDij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Mar 2021 23:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCVDia (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Mar 2021 23:38:30 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B195C061574;
        Sun, 21 Mar 2021 20:38:28 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id m12so19020202lfq.10;
        Sun, 21 Mar 2021 20:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3wXc5jRrUu9u3HZ5+tk1V3ALuglr5fGikTg7kiPcehE=;
        b=qnt+Uflcc+G7ecxk7Qzu4NhiKyumHRI47DOYzqKyiDiCPBjOrJ1BeTb4rXBsvOxlaa
         CYQNOYCicZX5AiNVrgXMT2PLRdVHiQQsThW8xWmIz29Mm4FKDJ+MXe91Idg9sQQuGmAr
         +/5NLo+2ffH+lLClrMg11Hd/TlFThZgIuGCLYgwqGR7pDno/ux4BpqtuAg0TP96ruTty
         HXGQZauI/HSntSVNeGiyuGERC+cM8hhhmbvXVAmiq5mpq0n7Dt0lU6bivaLTDbN8ZBll
         C2TFvbAH/OktXgJCtoenD7q8n8QztKeFnStTKIl3WEh1iJEWVwRoXcZe2LTZPxYjqDbX
         +HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wXc5jRrUu9u3HZ5+tk1V3ALuglr5fGikTg7kiPcehE=;
        b=eWIyu1JDQhCv0phcYeAgIrz+oDHXNf0QZX181oo2hGYiMAsHMNkK15Mw6Fsadb/vpm
         cNbZzAhWvC/wAe18RBtBlYsRDilAVarh/A7WZvOq61js3pKFPHAhvS6n8rcSerGYxRL2
         POwwZ8Y9LTsjYwsPqqkuhkC1pCWi0+g9cz3mq1k0KXmo+43lrWaWceYaW7jlOGk6IiTk
         ENv3aB81M6OoFJhoQ54oyj2iS3HNteD/CRQEZOhfVQvwCgSmLMThHSriG0opNzSXDQh+
         t0ibyI3/FLWC4T7J1EcaThd60jGvLExuFpNO2vYhO9XGQSepYKqbeLDmjmZvD3vGq7TS
         bdEw==
X-Gm-Message-State: AOAM530I5QdcbxUjnTO4oDJcZ3LiCDqQUibu2iCDoEpPwuH5hmD5fheE
        KBclZUFOTRENEMjbPSJiaacSHkru7fXaKSYv178yE+35cS4=
X-Google-Smtp-Source: ABdhPJx6LiR+l+6YjnRfOhPFv2eijHPbverWTKlJgIXmItkLaYK+4UH+eIvRW198T2OK2HQaI660fhnltRo41v9Qaqw=
X-Received: by 2002:a19:3f04:: with SMTP id m4mr7598216lfa.395.1616384306543;
 Sun, 21 Mar 2021 20:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <YFV6iexd6YQTybPr@zeniv-ca.linux.org.uk> <CAH2r5mvA0WeeV1ZSW4HPvksvs+=GmkiV5nDHqCRddfxkgPNfXA@mail.gmail.com>
 <CAH2r5msWJn5a7JCUdoyJ7nfyeafRS8TvtgF+mZCY08LBf=9LAQ@mail.gmail.com>
 <YFgDH6wzFZ6FIs3R@zeniv-ca.linux.org.uk> <CAH2r5mv7NFYiPYvCoDJZ50nnoSgytEB4CKYNfg0RTNSPjox2fw@mail.gmail.com>
In-Reply-To: <CAH2r5mv7NFYiPYvCoDJZ50nnoSgytEB4CKYNfg0RTNSPjox2fw@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 21 Mar 2021 22:38:15 -0500
Message-ID: <CAH2r5mvazL5gpWfNXX1t+bf_h6AuvGEboN9uLbq=n08PTiLZLw@mail.gmail.com>
Subject: Re: [RFC][PATCHSET] hopefully saner handling of pathnames in cifs
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some additional context - currently because of the way cifs.ko handles
conversion of '/' we can't handle a filename with '\' in the filename
(although the protocol would support that via remapping into the UCS-2
remap range if we made a change to move slash conversion later).

On Sun, Mar 21, 2021 at 10:36 PM Steve French <smfrench@gmail.com> wrote:
>
> FYI - on a loosely related point  about / to \ conversion, I had been
> experimenting with moving the conversion of '/' to '\' later depending
> on connection type (see attached WIP patch for example).
>
>
> On Sun, Mar 21, 2021 at 9:40 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Sun, Mar 21, 2021 at 09:19:53PM -0500, Steve French wrote:
> > > automated tests failed so will need to dig in a little more and see
> > > what is going on
> > >
> > > http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/533
> >
> > <looks>
> >
> > Oh, bugger...  I think I see a braino that might be responsible for that;
> > whether it's all that's going on or not, that's an obvious bug.  Incremental
> > for that one would be
> >
> > diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
> > index 3febf667d119..ed16f75ac0fa 100644
> > --- a/fs/cifs/dir.c
> > +++ b/fs/cifs/dir.c
> > @@ -132,7 +132,7 @@ build_path_from_dentry_optional_prefix(struct dentry *direntry, void *page,
> >         }
> >         if (dfsplen) {
> >                 s -= dfsplen;
> > -               memcpy(page, tcon->treeName, dfsplen);
> > +               memcpy(s, tcon->treeName, dfsplen);
> >                 if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_POSIX_PATHS) {
> >                         int i;
> >                         for (i = 0; i < dfsplen; i++) {
> >
> >
> > Folded and force-pushed (same branch).  My apologies...
>
>
>
> --
> Thanks,
>
> Steve



-- 
Thanks,

Steve
