Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77C634B416
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Mar 2021 04:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhC0Dr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 23:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230152AbhC0DrO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 23:47:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F77A619FF;
        Sat, 27 Mar 2021 03:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616816823;
        bh=yA8kD8ypT3ufo7csW1XItLYaTujjqa7SDCX8CvpPF7k=;
        h=Date:From:To:Subject:From;
        b=gPcMou40HgHH3cA6xOgTkmsHVH/ZbPNFiyomnDl70lzHB205rGzXWSBxj8RI6tG3M
         S6erRCJjwnHu76PVov3oPaPiCXzr3PZQzRIrGdENOyQNg0b0qiH6jLtl7BuExt9AWf
         18mlb4pmjrQS6UXmzhMbLQVNv1gsTp3dC1UOv6YlfWpUC+MYKOwDcxLNUgCyw4fHbS
         apxi24ogXXyyJiSHRKOc66LFP74Vv8FHpZU/aTTOtmpLCaeVpkk7UQMWi6lW1sbc9P
         07wF+OhMvy5y4Ekwt/hL213yYrSZelaHPItKQzJjQn4OcudBi7IGZ5LpDIaZMATSRv
         WX2t17y5OfFFQ==
Date:   Fri, 26 Mar 2021 20:46:59 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to ad89b66cbad1
Message-ID: <20210327034659.GB4090233@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-for-next branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the iomap-for-next branch is commit:

ad89b66cbad1 iomap: improve the warnings from iomap_swapfile_activate

New Commits:

Christoph Hellwig (1):
      [ad89b66cbad1] iomap: improve the warnings from iomap_swapfile_activate


Code Diffstat:

 fs/iomap/swapfile.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)
