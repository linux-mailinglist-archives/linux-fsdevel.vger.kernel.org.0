Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA193CCDB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 07:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhGSF7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 01:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhGSF7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 01:59:47 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80347C061762
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jul 2021 22:56:47 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id nd37so26649141ejc.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jul 2021 22:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TOp1Ku8gOd7uaD1v2W+HlDRwm/aTPQ5TXLmP/t7of6E=;
        b=WCv6CFd1SMLf3y6ytV+KUsn+wkbYMO8O7Rg2MmWRTX95gIUxh/lDKSf1gjGL03TolG
         FNDPjRh1dd2XqTCKT1d0hem6XaMxcqhhKu9A11edn96Fwn0rR1e2W6wwSE0AUFYsyxhU
         MQ7SwyXtUQhioB+SMQip01mruQ2owko+0ajn3Bs5l2F3ig4SSuogQtLG/V9tGICIlF9v
         oV/LhgDEVT0sbeQZ7fdHtYVKq0N+FzfeiU/p24/y9QrCfacZd8Ec0/zcquIeu/ewLRkR
         d2hCb5H//13ZMgC/LN6jS38xukifbRbSIQfAH4LT+gpeVj9eF/TjtXpDBtlEEqxqzEOa
         sG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TOp1Ku8gOd7uaD1v2W+HlDRwm/aTPQ5TXLmP/t7of6E=;
        b=WadGLtd7AWRh3uDK2CKng2jP14nTewbdD1StSUQgpqAmbdqBCD8ketAlWEkgmfdKoi
         hYj4zibup7xeGuXmRObRTgGIKcRCNiLmO1ZRheU+T9YdPQz9HQkxi+5GytHNT+82j5hO
         uZbcCz4x2gldINXJBPqK5LsnUUWa18l3dEr9zBL8f9WPwJcjqb3xfV7IT5AALpaWsUfX
         3h5LiUwxYM98f1puAeeWfc497vqvztW4JYiCGpPD41IgjJU/ca0XlJe2bajSPhXlfVM2
         uHB5UL6nBU8ARVDnKFUOYU/543EdxVxX/p5ZpuaVPXmn+tuWrxdmfTr1xUsbIBRnaigZ
         fx4g==
X-Gm-Message-State: AOAM531bOCwi68hGelbCowaUdtFYgjW/KSMnaK55L6VtIx8VLOSuV04q
        LeEIHShRoQKf1Gz4wZn9GVo77YHLD7zgB4Jd/O0=
X-Google-Smtp-Source: ABdhPJyCrHxSM/T/Ax6N2f+XnFm9cYmDdKvVzp6+2sTUCAl0g3R6nvPukTe5qd6vt6PcuoMZZuzXSWIADyEI4VwFrJA=
X-Received: by 2002:a17:906:718c:: with SMTP id h12mr24875160ejk.6.1626674206125;
 Sun, 18 Jul 2021 22:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <CADJHv_uitWbPquubkFJGwiFi8Vx7V0ZxhYUSiEOd1_vMhHOonA@mail.gmail.com>
 <YPBdG2pe94hRdCMC@carbon.dhcp.thefacebook.com> <CADJHv_sij245-dtvhSac_cwkYQLrSFBgjoXnja_-OYaZk6Cfdg@mail.gmail.com>
 <YPHoUQyWW0/02l1X@carbon.dhcp.thefacebook.com> <20210717171713.GB22357@magnolia>
 <YPNU3BAfe97WrkMq@carbon.lan>
In-Reply-To: <YPNU3BAfe97WrkMq@carbon.lan>
From:   Murphy Zhou <jencce.kernel@gmail.com>
Date:   Mon, 19 Jul 2021 13:56:34 +0800
Message-ID: <CADJHv_sCOt1NGan5bcUKTwOfg+4rQb_O26rr9Qr+RdZEtzSJHw@mail.gmail.com>
Subject: Re: [fsdax xfs] Regression panic at inode_switch_wbs_work_fn
To:     Roman Gushchin <guro@fb.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 18, 2021 at 6:08 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Sat, Jul 17, 2021 at 10:17:13AM -0700, Darrick J. Wong wrote:
> > On Fri, Jul 16, 2021 at 01:13:05PM -0700, Roman Gushchin wrote:
> > > On Fri, Jul 16, 2021 at 01:57:55PM +0800, Murphy Zhou wrote:
> > > > Hi,
> > > >
> > > > On Fri, Jul 16, 2021 at 12:07 AM Roman Gushchin <guro@fb.com> wrote:
> > > > >
> > > > > On Thu, Jul 15, 2021 at 06:10:22PM +0800, Murphy Zhou wrote:
> > > > > > Hi,
> > > > > >
> > > > > > #Looping generic/270 of xfstests[1] on pmem ramdisk with
> > > > > > mount option:  -o dax=always
> > > > > > mkfs.xfs option: -f -b size=4096 -m reflink=0
> > > > > > can hit this panic now.
> > > > > >
> > > > > > #It's not reproducible on ext4.
> > > > > > #It's not reproducible without dax=always.
> > > > >
> > > > > Hi Murphy!
> > > > >
> > > > > Thank you for the report!
> > > > >
> > > > > Can you, please, check if the following patch fixes the problem?
> > > >
> > > > No. Still the same panic.
> > >
> > > Hm, can you, please, double check this? It seems that the patch fixes the
> > > problem for others (of course, it can be a different problem).
> > > CCed you on the proper patch, just sent to the list.
> > >
> > > Otherwise, can you, please, say on which line of code the panic happens?
> > > (using addr2line utility, for example)
> >
> > I experience the same problem that Murphy does, and I tracked it down
> > to this chunk of inode_do_switch_wbs:
> >
> >       /*
> >        * Count and transfer stats.  Note that PAGECACHE_TAG_DIRTY points
> >        * to possibly dirty pages while PAGECACHE_TAG_WRITEBACK points to
> >        * pages actually under writeback.
> >        */
> >       xas_for_each_marked(&xas, page, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
> > here >>>>>>>>>> if (PageDirty(page)) {
> >                       dec_wb_stat(old_wb, WB_RECLAIMABLE);
> >                       inc_wb_stat(new_wb, WB_RECLAIMABLE);
> >               }
> >       }
> >
> > I suspect that "page" is really a pfn to a pmem mapping and not a real
> > struct page.
>
> Good catch! Now it's clear that it's a different issue.
>
> I think as now the best option is to ignore dax inodes completely.
> Can you, please, confirm, that the following patch solves the problem?

This one works for me. Thanks.


>
> Thanks!
>
> --
>
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 06d04a74ab6c..4c3370548982 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -521,6 +521,9 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
>          */
>         smp_mb();
>
> +       if (IS_DAX(inode))
> +               return false;
> +
>         /* while holding I_WB_SWITCH, no one else can update the association */
>         spin_lock(&inode->i_lock);
>         if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
