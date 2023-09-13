Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B1C79E4A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 12:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239632AbjIMKQa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 06:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239629AbjIMKQ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:16:29 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8291996
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 03:16:25 -0700 (PDT)
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4RlxDz3p7dz5Sfr
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:16:19 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4RlxDz3V0FzBRHKH
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:16:19 +0800 (CST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4RlxDq6Xn4z4xPGH;
        Wed, 13 Sep 2023 18:16:11 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4RlxDr1Ljdz4xVbt;
        Wed, 13 Sep 2023 18:16:12 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl2.zte.com.cn with SMTP id 38DAG1oD094580;
        Wed, 13 Sep 2023 18:16:01 +0800 (+08)
        (envelope-from cheng.lin130@zte.com.cn)
Received: from mapi (szxlzmapp07[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 13 Sep 2023 18:16:03 +0800 (CST)
Date:   Wed, 13 Sep 2023 18:16:03 +0800 (CST)
X-Zmail-TransId: 2b0965018be32b5-cea0c
X-Mailer: Zmail v1.0
Message-ID: <202309131816038673861@zte.com.cn>
In-Reply-To: <ZQDlXPJJvp7wctbZ@dread.disaster.area>
References: 202309111612569712762@zte.com.cn,ZQDlXPJJvp7wctbZ@dread.disaster.area
Mime-Version: 1.0
From:   <cheng.lin130@zte.com.cn>
To:     <david@fromorbit.com>, <viro@zeniv.linux.org.uk>,
        <brauner@kernel.org>
Cc:     <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jiang.yong5@zte.com.cn>,
        <wang.liang82@zte.com.cn>, <liu.dong3@zte.com.cn>,
        <linux-fsdevel@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Ml0geGZzOiBpbnRyb2R1Y2UgcHJvdGVjdGlvbiBmb3IgZHJvcCBubGluaw==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 38DAG1oD094580
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 65018BF2.000/4RlxDz3p7dz5Sfr
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Mon, Sep 11, 2023 at 04:12:56PM +0800, cheng.lin130@zte.com.cn wrote:
> > From: Cheng Lin <cheng.lin130@zte.com.cn>
> >
> > When abnormal drop_nlink are detected on the inode,
> > shutdown filesystem, to avoid corruption propagation.
> >
> > Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> > ---
> >  fs/xfs/xfs_fsops.c | 3 +++
> >  fs/xfs/xfs_inode.c | 9 +++++++++
> >  fs/xfs/xfs_mount.h | 1 +
> >  3 files changed, 13 insertions(+)
> >
> > diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
> > index 7cb75cb6b..6fc1cfe83 100644
> > --- a/fs/xfs/xfs_fsops.c
> > +++ b/fs/xfs/xfs_fsops.c
> > @@ -543,6 +543,9 @@ xfs_do_force_shutdown(
> >      } else if (flags & SHUTDOWN_CORRUPT_ONDISK) {
> >          tag = XFS_PTAG_SHUTDOWN_CORRUPT;
> >          why = "Corruption of on-disk metadata";
> > +    } else if (flags & SHUTDOWN_CORRRUPT_ABN) {
> > +        tag = XFS_PTAG_SHUTDOWN_CORRUPT;
> > +        why = "Corruption of Abnormal conditions";
> We don't need a new shutdown tag. We can consider this in-memory
> corruption because we detected it in memory before it went to disk
> (SHUTDOWN_CORRUPT_INCORE) or even on-disk corruption because the
> reference count on disk is likely wrong at this point......
> >      } else if (flags & SHUTDOWN_DEVICE_REMOVED) {
> >          tag = XFS_PTAG_SHUTDOWN_IOERROR;
> >          why = "Block device removal";
> > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > index 9e62cc500..2d41f2461 100644
> > --- a/fs/xfs/xfs_inode.c
> > +++ b/fs/xfs/xfs_inode.c
> > @@ -919,6 +919,15 @@ xfs_droplink(
> >      xfs_trans_t *tp,
> >      xfs_inode_t *ip)
> >  {
> > +
> > +    if (VFS_I(ip)->i_nlink == 0) {
> > +        xfs_alert(ip->i_mount,
> > +              "%s: Deleting inode %llu with no links.",
> > +              __func__, ip->i_ino);
> > +        xfs_force_shutdown(ip->i_mount, SHUTDOWN_CORRRUPT_ABN);
> > +        return -EFSCORRUPTED;
> > +    }
> > +
> >      xfs_trans_ichgtime(tp, ip, XFS_ICHGTIME_CHG);
> >
> >      drop_nlink(VFS_I(ip));
> I'd kind of prefer that drop_nlink() be made to return an error on
> underrun - if it's important enough to drop a warning in the log and
> potentially panic the kernel, it's important enough to tell the
> filesystem an underrun has occurred.  But that opens a whole new can
> of worms, so I think this will be fine.
In VFS, (drop\clear\set\inc)_nlink() all return void. 
Is it appropriate, if let them return an error instead of WARN_ON?
> Note that we don't actually need a call to shut the filesystem down.
> Simply returning -EFSCORRUPTED will result in the filesystem being
> shut down if the transaction is dirty when it gets cancelled due to
> the droplink error.
> Cheers,
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
