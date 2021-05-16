Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA2C381F24
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 May 2021 15:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbhEPNz6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 May 2021 09:55:58 -0400
Received: from out20-26.mail.aliyun.com ([115.124.20.26]:39061 "EHLO
        out20-26.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbhEPNz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 May 2021 09:55:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08295409|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.199057-0.0256767-0.775266;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=guan@eryu.me;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.KED8zEg_1621173280;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.KED8zEg_1621173280)
          by smtp.aliyun-inc.com(10.147.40.2);
          Sun, 16 May 2021 21:54:40 +0800
Date:   Sun, 16 May 2021 21:54:39 +0800
From:   Eryu Guan <guan@eryu.me>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH 0/3] bcachefs support
Message-ID: <YKEkH/a4GdKrq4fU@desktop>
References: <20210427164419.3729180-1-kent.overstreet@gmail.com>
 <YJfvtvBCqA4zU0xf@desktop>
 <20210510231446.GO1872259@dread.disaster.area>
 <20210511012645.GD8558@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511012645.GD8558@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 10, 2021 at 06:26:45PM -0700, Darrick J. Wong wrote:
> On Tue, May 11, 2021 at 09:14:46AM +1000, Dave Chinner wrote:
> > On Sun, May 09, 2021 at 10:20:38PM +0800, Eryu Guan wrote:
> > > On Tue, Apr 27, 2021 at 12:44:16PM -0400, Kent Overstreet wrote:
> > > > A small patch adding bcachefs support, and two other patches for consideration:
> > > 
> > > As bcachefs is not upstream yet, I think we should re-visit bcachefs
> > > support after it's in upstream.
> > 
> > I disagree completely. I've been waiting for this to land for some
> > time so I can actually run fstests against bcachefs easily to
> > evaluate it's current state of stability and support.  The plans are
> > to get bcachefs merged upstream, and so having support already in
> > fstests makes it much easier for reviewers and developers to
> > actually run tests and find problems prior to merging.
> > 
> > As an upstream developer and someone who will be reviewing bcachefs
> > when it is next proposed for merge,  I would much prefer to see
> > extensive and long term fstests coverage *before* the code is even
> > merged upstream. Given that filesystems take years to develop to the
> > point where they are stable and ready for merge, saying "can't
> > enable the test environment until it is merged upstream" is not very
> > helpful.
> > 
> > As a general principle, we want developers of new filesystems to
> > start using fstests early in the development process of their
> > filesystem. We should be encouraging new filesystems to be added to
> > fstests, not saying "we only support upstream filesystems". If the
> > filesystem plans to be merged upstream, then fstests support for
> > that filesystem should be there long before the filesytsem is even
> > proposed for merge.  We need to help people get new filesystems
> > upstream, not place arbitrary "not upstream so not supported"
> > catch-22s in their way...

OK, that makes sense. Actually, I should have made my "upstream first"
more clear. I'd love to merge non-upstream features/new fs supports if
the proposed new feature/new filesystem has been developmented actively
and the community has generally made the agreement that will merge the
new feature/filesystem when it's in a good shape. IOW, it's not some
random new features/filesystems, which are very likely to be dropped in
the half way.

And providing such info in the patch is very helpful to reviewers.

> > 
> > Hence I ask that you merge bcachefs support to help the process of
> > getting bcachefs suport upstream.

Sure, bcachefs looks promising to me now :)

> 
> /me notes that both Eryu and Dave have been willing to merge
> surprisingly large quantities of code for XFS reflink and online fsck
> long before either of those features landed in mainline, so I think it's

Because I know you and the xfs commnity will work on it continuously and
very unlikely make the new tests dead code :)

Thanks,
Eryu

> perfectly fine to merge Kent's relatively small changes to enable
> 'FSTYP=bcachefs'.
> 
> (With all of Eryu's review comments fixed, obviously...)
> 
> --D
> 
> > Cheers,
> > 
> > Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com
