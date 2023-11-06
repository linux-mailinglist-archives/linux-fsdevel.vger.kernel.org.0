Return-Path: <linux-fsdevel+bounces-2087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5E97E218F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 13:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344D81C20BAF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 12:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FC92510F;
	Mon,  6 Nov 2023 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kIQyV9UP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161D250EB
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 12:31:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48176AB;
	Mon,  6 Nov 2023 04:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5gv7Tk/V+i9O7re/VgIDi+SyhOAoqKetvsihXPjDjuM=; b=kIQyV9UPD9Z2gRNQ9DdLsMa516
	11JEIt871RSE5VapfffmDaIQE18UvpTZ4j/x2xZjRoqxSTvd1ZI1x++TCZcwnrNEpVfddGRyqPbht
	2lF7zIsOI1P69mLCV9sOHA30rjf5wz0m3/EWT9Pe1r55oMEwhAGOQgmR1kpdTWCk4BrfmixXikuW6
	qzkwgnCoyNgymGeuJLRQljvZMjgHdcnQLL/T9J1DN1RtlDfNfBfZ2q/yumGYnFbfa8+m2aj41UY61
	vaNRtQwKZJQD5Z6UAOugCrIBFtC9AFOo49P1CxiXBy+irmO9YUh/uWk8AwoUO4iQCfMdKIPGYo1P2
	Y613mviw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qzykr-00Gddv-0x;
	Mon, 06 Nov 2023 12:30:57 +0000
Date: Mon, 6 Nov 2023 04:30:57 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Christoph Hellwig <hch@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUjcgU9ItPg/foNB@infradead.org>
References: <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
 <49454bf2-af6e-4dcf-b9a1-22acbfdc756d@gmx.com>
 <20231106-postfach-erhoffen-9a247559e10d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106-postfach-erhoffen-9a247559e10d@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 06, 2023 at 11:59:22AM +0100, Christian Brauner wrote:
> > > They
> > > all know that btrfs subvolumes are special. They will need to know that
> > > btrfs subvolumes are special in the future even if they were vfsmounts.
> > > They would likely end up with another kind of confusion because suddenly
> > > vfsmounts have device numbers that aren't associated with the superblock
> > > that vfsmount belongs to.
> > 
> > This looks like you are asking user space programs (especially legacy
> > ones) to do special handling for btrfs, which I don't believe is the
> > standard way.
> 
> I think spending time engaging this claim isn't worth it. This is just
> easily falsifiable via a simple grep for btrfs in systemd, lxc, runc,
> util-linux.

Myabe you need to get our of your little bubble.  There is plenty of
code outside the fast moving Linux Desktop and containers bubbles that
takes decades to adopt to new file systems, and then it'll take time
again to find bugs exposed by such odd behavior.

