Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113381FDF0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 03:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732822AbgFRBi0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 21:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732547AbgFRBab (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:30:31 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056DAC061755;
        Wed, 17 Jun 2020 18:30:30 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b27so4094827qka.4;
        Wed, 17 Jun 2020 18:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BgQL6jr7f4Pok+oRfrdP837PZf1178oPJYqZuFJeOOM=;
        b=PsoyNROs97j1k2IGHTBbgdA1UmsBzqoIU4M9fAiqotRAMt2bltVbCKEquho2syZZ8a
         hBoONSygFB18Ey8vU3Y3DQic30cQ34dLKddxAqW74b0hN7xln8EFfDmJL+yPMf/RCQNH
         +8UC8geUs0OFu6oPvSUOl+BjoSKT73x8hLu8Si+8xsOkIMmw8utndSm2YFEl1d+2y3Vy
         SIETCtxkGsv/mNz/kre1pCMonY3xKajSxgHkH/I7UvrRTq7w9Pzn1JyiTVainKp1tjST
         nk6zyaFXLinCbFwP//4BjNJKz5i+UuVUcENob2yJ9qKKHk2e/d5ZQGjn3BcUUjMDc3I8
         A+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BgQL6jr7f4Pok+oRfrdP837PZf1178oPJYqZuFJeOOM=;
        b=r8T9rzT07whmPCoah12mDClWmTH/na8nIVIvMrjfUYkn0O+MKzWTepn6IS8xL3s3up
         aFONMUT4MysG2B/u5/smkzvgSAP4F1X9gfALpfSHxQlW8XAxaHYOTDZ55gS6PVe6FuS6
         NWUESj7yFFXCjc8M3lC2n1iaByG+Dm9ZfHCGWPITxdxYMOxAGr20rnRJPC6Q7hSBvrsK
         cDfDNIW3cRE4i16a0eBc+cRM79m6PnbXHgjZOwJZ6chWN9ym1Z8OfHSrWZZQP6DD1bRW
         E0/qCHrpCK39MVTtMAKrbY0bwE+8BtRqxK4qgjfA6R9sAkEY9gr4tmqlfoCn7sSE7DKf
         s/Zw==
X-Gm-Message-State: AOAM530qwgOtAZjmUwycuYwlCiXs8mciam2q7i4TEstW7jSAnNbfHQQB
        mxrhFM5Fj7npDyvxFigNTg==
X-Google-Smtp-Source: ABdhPJwmfKV/RiX9rrG5aWDGqFvBQuR28QYYzJpTADtHrTUuB7rzV/CkW5/nnvBH2d+2wQJphU09nA==
X-Received: by 2002:a37:63c2:: with SMTP id x185mr1621171qkb.82.1592443829168;
        Wed, 17 Jun 2020 18:30:29 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id d78sm1642255qkg.106.2020.06.17.18.30.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jun 2020 18:30:28 -0700 (PDT)
Date:   Wed, 17 Jun 2020 21:30:26 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] fs: i_version mntopt gets visible through /proc/mounts
Message-ID: <20200618013026.ewnhvf64nb62k2yx@gabell>
References: <20200616202123.12656-1-msys.mizuma@gmail.com>
 <20200617080314.GA7147@infradead.org>
 <20200617155836.GD13815@fieldses.org>
 <24692989-2ee0-3dcc-16d8-aa436114f5fb@sandeen.net>
 <20200617172456.GP11245@magnolia>
 <8f0df756-4f71-9d96-7a52-45bf51482556@sandeen.net>
 <20200617181816.GA18315@fieldses.org>
 <4cbb5cbe-feb4-2166-0634-29041a41a8dc@sandeen.net>
 <20200617184507.GB18315@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617184507.GB18315@fieldses.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 17, 2020 at 02:45:07PM -0400, J. Bruce Fields wrote:
> On Wed, Jun 17, 2020 at 01:28:11PM -0500, Eric Sandeen wrote:
> > but mount(8) has already exposed this interface:
> > 
> >        iversion
> >               Every time the inode is modified, the i_version field will be incremented.
> > 
> >        noiversion
> >               Do not increment the i_version inode field.
> > 
> > so now what?
> 
> It's not like anyone's actually depending on i_version *not* being
> incremented.  (Can you even observe it from userspace other than over
> NFS?)
> 
> So, just silently turn on the "iversion" behavior and ignore noiversion,
> and I doubt you're going to break any real application.

I suppose it's probably good to remain the options for user compatibility,
however, it seems that iversion and noiversiont are useful for
only ext4.
How about moving iversion and noiversion description on mount(8)
to ext4 specific option?

And fixing the remount issue for XFS (maybe btrfs has the same
issue as well)?
For XFS like as:

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 379cbff438bc..2ddd634cfb0b 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1748,6 +1748,9 @@ xfs_fc_reconfigure(
                        return error;
        }

+       if (XFS_SB_VERSION_NUM(&mp->m_sb) == XFS_SB_VERSION_5)
+               mp->m_super->s_flags |= SB_I_VERSION;
+
        return 0;
 }

Thanks,
Masa
