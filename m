Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBEA3B9410
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 17:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhGAPkR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jul 2021 11:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhGAPkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jul 2021 11:40:16 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14259C061762;
        Thu,  1 Jul 2021 08:37:46 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o33-20020a05600c5121b02901e360c98c08so7106813wms.5;
        Thu, 01 Jul 2021 08:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4AawkGCXS8076zqa2ceQS9Q+T6ktDkZLlSiDG0RFEDc=;
        b=MJKdeO/ZRwo92yK/m4HDNEVwfcJnNgUjgPXa0GIXoXtxhcFf2eduSinBeG2lfRf7N8
         arfHhzmKJc6OjgZ3u80Wnav/tMMO/PvDQ64/1bltYZ4fbwjhOruxijD9bekyyEMA5k2+
         VHEDfg3BaTZO7tHm6DhTfiALkkBlE7c1wphVoiYiNW/EtgTYQjOBynRZRb3eygsNhTYz
         /fzYMkpljjvNMTswP5ouLQ4uY6vi1GEuPlUHb8mIRzwqEYvfGm160rmdE/pBHP5fTeG+
         FO+LVWd6kmajhXkRpUmPxx+F4Ff7lAoKkynlmf7lVimZAJtUlm06XjxAXqsieNzldK9C
         hn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4AawkGCXS8076zqa2ceQS9Q+T6ktDkZLlSiDG0RFEDc=;
        b=NEPyQj12qRdnvQBhqfJFaGXzjUl1yLc/90KdBWik6o+ToTsNsLw/4Iwuzl5azSjlb1
         QP4PN3vZ1L48Ic4jRJlZPzauYyaZ4hJ/1SZaX35cWohrfxd3RjNT1WeyEqSxB8WLjavk
         2f5+x07Hd6clUb3cUCvzH9O04IE95RLXTBNTrUqagyj63LsZxExBAer9IkOkifBazjXa
         ZaI2ZCrua0AHq2bZvmCasEAJa88WfsXn8xXNN4vbE8G7a9uwxRauRxm2ziQ+jdbMr7jt
         AdewF5OoO+PGRlDpHPnl/Ut5RGpthH9FP/HC2MXv6+yjsInd8paDch6crDm+ru5A6kqN
         Kf3A==
X-Gm-Message-State: AOAM531Fy445228CEZfCDf/Qdpt6PnhTzBh+u4wLyGKN6/J8/mOcoQlp
        2CefJ+YPznC5/jDFDD/HgRhbbkW1EuNayec/y4oS/i9lcG0w6iz7
X-Google-Smtp-Source: ABdhPJw83WgbDLafRLinqmNHcEfgEMwgPJTNgx2lfoPjuMO6IZwQYVdVB2s5O0sbbb4w6nVh2gP6BADr/5Fvpd4lOgU=
X-Received: by 2002:a05:600c:21c8:: with SMTP id x8mr11345208wmj.167.1625153864584;
 Thu, 01 Jul 2021 08:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210628123801.3511-1-wangshilong1991@gmail.com> <20210628223403.GE664593@dread.disaster.area>
In-Reply-To: <20210628223403.GE664593@dread.disaster.area>
From:   Wang Shilong <wangshilong1991@gmail.com>
Date:   Thu, 1 Jul 2021 23:37:33 +0800
Message-ID: <CAP9B-QnCjz4UTALx0W4QA=7qTcEHTVOVid+kJW8Te-dgJoobHg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: forbid invalid project ID
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 29, 2021 at 6:34 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Jun 28, 2021 at 08:38:01AM -0400, Wang Shilong wrote:
> > fileattr_set_prepare() should check if project ID
> > is valid, otherwise dqget() will return NULL for
> > such project ID quota.
> >
> > Signed-off-by: Wang Shilong <wshilong@ddn.com>
> > ---
> > v1->v2: try to fix in the VFS
> > ---
> >  fs/ioctl.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > index 1e2204fa9963..5db5b218637b 100644
> > --- a/fs/ioctl.c
> > +++ b/fs/ioctl.c
> > @@ -845,6 +845,9 @@ static int fileattr_set_prepare(struct inode *inode,
> >       if (fa->fsx_cowextsize == 0)
> >               fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
> >
> > +     if (!projid_valid(KPROJIDT_INIT(fa->fsx_projid)))
> > +             return -EINVAL;
>
> This needs to go further up in this function in the section where
> project IDs passed into this function are validated. Projids are
> only allowed to be changed when current_user_ns() == &init_user_ns,
> so this needs to be associated with that verification context.
>
> This check should also use make_kprojid(), please, not open code
> KPROJIDT_INIT.

You are right, let me send a V3

>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
