Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD073FEAE6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 10:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244636AbhIBI7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 04:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbhIBI7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 04:59:17 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF192C061575
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Sep 2021 01:58:18 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id d16so2218888ljq.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Sep 2021 01:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ynTKgypk1VDDD44vk6yO0HLlnLIx2rE/TpINeDq8d/U=;
        b=oNUaRGDQsef93qfATq1ySQvFejDk5BZQupSNtWTF4ZiymdLFa1onfi9dJeSrgzkGPR
         d0yVewm6WAw1Ep548mUQaqrdhikWlsqXBq2iGUhPRyc/vwy2b8Y47GCOhQq6ZUBXZTF4
         GhwLtqdbIM7+10SJ0Hm68BU+TUjWIrpstboVGfbcjudazfJvbX3nCgPAETjBrh6JkgEg
         EKUwg1fr0Q4eKiNSQdsCpRluY1Wziq8/SNjZaTJog6p0Z7FEolxrAlLDffqcAcUJ5QkX
         yQSkKEnxZMLHAyLzx/cYiivG4GXeviI//C1SxST3O+RAab4Zx2u2/Ugbg9LNTvC8q/nt
         WAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ynTKgypk1VDDD44vk6yO0HLlnLIx2rE/TpINeDq8d/U=;
        b=fL1p5qELf/uAAsFtDvhuoWfMXZLPdfcQxHp1oO6MM49Xqc0BLs29vgNp4juXNTgMf3
         QjOGJBlRzaZ8P6KIz8CZsC3Y1P/GEuq4W0hhR3sa/mCuEzJ4WeDNlLnK0ZyizVvpk9vj
         +85+dhCQkRP3RpbRZ8PmvVM4yeWhcsp+15RVa6UKz4gwHiWO0nu3mv8a826iT/Wt/VQS
         ga+YBbvXzpUSqXtryUZgVhB+cVBEHjGoMCe+YpkH3ALTR8feCTawjU6t6AXMH0FRziaA
         cLc+Y5P7ReGWLuDzn9aLxOXqpQYGnKUQ+Wcl5QGPzpDqDdKT6MDXQtWBmdFFiC4LCrqr
         yfNw==
X-Gm-Message-State: AOAM531dcVyeIgXsPQFc6RlU0qmKzy0xMa8jml6nDcD1x4xwUnggRv9/
        VClup7VF1RSpT8O0NOKZy3Y=
X-Google-Smtp-Source: ABdhPJy3ew7WJCyi/bCvuSIo4ufaSxmSDgdYjwjHew1OxuaXVnxqQGb0EJb0DdQ98caX8jrj32pYbw==
X-Received: by 2002:a2e:4949:: with SMTP id b9mr1682613ljd.159.1630573097321;
        Thu, 02 Sep 2021 01:58:17 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id w16sm138162lfn.83.2021.09.02.01.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 01:58:16 -0700 (PDT)
Date:   Thu, 2 Sep 2021 11:58:14 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jean-Pierre =?utf-8?B?QW5kcsOp?= <jean-pierre.andre@wanadoo.fr>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        ntfs-3g-devel <ntfs-3g-devel@lists.sourceforge.net>,
        ntfs-3g-news <ntfs-3g-news@lists.sourceforge.net>
Subject: Re: Stable NTFS-3G + NTFSPROGS 2021.8.22 Released
Message-ID: <20210902085814.6a4ohjttgzemihe5@kari-VirtualBox>
References: <d343b1d7-6587-06a5-4b60-e4c59a585498@wanadoo.fr>
 <YS0s8oEjE6gRN6XT@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YS0s8oEjE6gRN6XT@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 30, 2021 at 08:09:38PM +0100, Matthew Wilcox wrote:
> On Mon, Aug 30, 2021 at 07:59:17PM +0200, Jean-Pierre André wrote:
> > The NTFS-3G project globally aims at providing a stable NTFS driver. The
> > project's advanced branch has specifically aimed at developing, maturing,
> > and releasing features for user feedback prior to feature integration into
> > the project's main branch.
> 
> So do I understand correctly ...
> 
>  - We have an NTFS filesystem from Anton Altaparmakov in fs/ntfs which was
>    merged in 1997 and is read only.
>  - We have Paragon's NTFS3 in the process of being merged
>  - We have Tuxera's NTFS-3G hosted externally on Github that uses FUSE
> 
> Any other implementations of NTFS for Linux that we should know about?
> Is there any chance that the various developers involved can agree to
> cooperate on a single implementation?

I would also like to here about this from ntfs-3g guys. What do you even
think about this whole ntfs3 kernel driver? My own opionion is that
kernel really needs ntfs driver at it's own because it will greatly
benefit growing iot device market and also maybe it will be in Android
in same day. Also great performance boost with ntfs3 compared to
ntfs-3g.

It will be strange situation that we continue development from both
sides.  ntfs-3g guys have only open source NTFSPROGS tools what is
available. I like to note, that Paragon has sayd that they will open
source their mkfs and fschk, but I will not count on that. That means
that then there will be two tool set also. This is not good for users.

After ntfs3 is merged to mainline we are three driver situation.
Hopefully kernel ntfs driver can be dropper in year or two.

One thing what we should at least share is testing. There is work that
has been done for xfstests that ntfs3 and ntfs-3g will be supported:
lore.kernel.org/fstests/YQoVXWRFGeY19onQ@mit.edu/

Xfstests will support also other fuse base drivers.
lore.kernel.org/fstests/20210812045950.3190-1-bhumit.attarde01@gmail.com/

There is already support for ntfs3 and ntfs-3g for kvm-xfstests. This
was done so that we know how these compare to each other. And can help
decissions that is ntfs3 ready for mainline.
github.com/tytso/xfstests-bld/commit/fa6410d922d38735a5f69345221f8eacb3ae1af

I do think that if ntfs3 will be solid and some remaining bugs will be
solved it would make no sense to use ntfs-3g. So what do you think about
all of this?

Best regards
Kari Argillander

