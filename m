Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AA53D085E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 07:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhGUE4z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 00:56:55 -0400
Received: from verein.lst.de ([213.95.11.211]:57346 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhGUE4n (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 00:56:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4919F6736F; Wed, 21 Jul 2021 07:37:18 +0200 (CEST)
Date:   Wed, 21 Jul 2021 07:37:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mikulas Patocka <mikulas@twibright.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.com>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: remove generic_block_fiemap
Message-ID: <20210721053717.GA8625@lst.de>
References: <20210720133341.405438-1-hch@lst.de> <alpine.DEB.2.21.2107201857100.27763@leontynka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2107201857100.27763@leontynka>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 07:02:10PM +0200, Mikulas Patocka wrote:
> You can download a test HPFS partition here:
> http://artax.karlin.mff.cuni.cz/~mikulas/vyplody/hpfs/test-hpfs-partition.gz

looks like xfstests doesn't generally work on hpfs, and even if I tried
i would be rather slow due to the lack of sparse files.

So I tested fiemp against a few simple copied over files and it still
works.

There are some cases where the old code reported contiguous ranges
as two extents while the new one doesn't, for rasons that are not
quite clear to me:

--- fiemap.old	2021-07-21 05:00:29.000000000 +0000
+++ fiemap.iomap	2021-07-21 04:57:20.000000000 +0000
@@ -1,3 +1,2 @@
 dmesg:
-	0: [0..66]: 133817..133883
-	1: [67..67]: 133884..133884
+	0: [0..67]: 133817..133884


