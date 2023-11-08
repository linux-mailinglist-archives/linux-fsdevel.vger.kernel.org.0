Return-Path: <linux-fsdevel+bounces-2391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EC17E5863
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 15:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2013F28158F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE7C199CC;
	Wed,  8 Nov 2023 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P5VFqQdp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DC9199B1;
	Wed,  8 Nov 2023 14:11:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2EA1BFF;
	Wed,  8 Nov 2023 06:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K7XZ/PCjjaNlTSx1uvZEeWfiFmh9GzA/fiR0LPjADLE=; b=P5VFqQdpuB7VFQypF2JqJhL2Bj
	sTqD9upQ5w56kiRB30RTOOYrehaEM4agINzTZPoycJUT/DUv8B6/a8POEzPl7+L7KUejZUgE8D6SL
	AeFnEhmFmy36HkQBJM5z9OHjGs4UtUaSFHtMRUziXA6R91LxW6UKBhG8ih+5CgNGqT9BJovLDoLka
	uSAYG+8J51dVRK7rmf4upIse/NPdahDYBNhjvhHZreV/cl2SADm2DXxQlBOQNYSA/zDZ0t6otGRxs
	E2Fm8XfYIdkEYMuDVYQ9tDuV8KZiucrKkMd4HeO5ZOjxSGLnURKm5JvpGObuzNwAXNNqe0dsxPS+E
	mCpgU7Aw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0jHE-003z7o-0Q;
	Wed, 08 Nov 2023 14:11:28 +0000
Date: Wed, 8 Nov 2023 06:11:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUuXEH8TvQRp8UKv@infradead.org>
References: <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
 <ZUjcI1SE+a2t8n1v@infradead.org>
 <20231106-unser-fiskus-9d1eba9fc64c@brauner>
 <ZUker5S8sZXnsvOl@infradead.org>
 <20231106224210.GA3812457@perftesting>
 <ZUs+HuQWZvDDVC7a@infradead.org>
 <20231108110814.noepnvrxdjmab6qj@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108110814.noepnvrxdjmab6qj@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 08, 2023 at 12:08:14PM +0100, Jan Kara wrote:
> On Tue 07-11-23 23:51:58, Christoph Hellwig wrote:
> > On Mon, Nov 06, 2023 at 05:42:10PM -0500, Josef Bacik wrote:
> > > Again, this is where I'm confused, because this doesn't change anything, we're
> > > still going to report st_dev as being different, which is what you hate.
> > 
> > It's not something I hate.  It's that changing it without a mount point
> > has broken things and will probably still break things.
> 
> So let me maybe return to what has started this thread. For fanotify we
> return <fsid, fhandle> pair with events to identify object where something
> happened. The fact that fsid is not uniform for all inodes of a superblock
> on btrfs is what triggered this series because we are then faced with the
> problem that caching fsid per superblock for "superblock marks" (to save
> CPU overhead when generating events) can lead to somewhat confusing results
> on btrfs. Whether we have vfsmount in the places where inodes' st_dev /
> fsid change is irrelevant for this fanotify issue. As far as I'm following
> the discussion it seems the non-uniform fsids per superblock are going to
> stay with us on btrfs so fanotify code should better accommodate them? At
> least by making sure the behavior is somewhat consistent and documented...

I'd say if you want fanotify to work properly you must not switch st_dev
and diverge from the known behavior.  Just like your already do
for tons of other things that use sb->s_dev or identifier derived
from it as we've got plenty of those.


