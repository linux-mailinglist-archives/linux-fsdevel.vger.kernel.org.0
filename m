Return-Path: <linux-fsdevel+bounces-1926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A0D7E04A8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 15:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9277C1C20F32
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 14:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92171A284;
	Fri,  3 Nov 2023 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vFUGkf0o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD224168AB
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 14:28:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA27D4B;
	Fri,  3 Nov 2023 07:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NIf8zlY6PjIaojz132l2Pfk7Nfa0H/Q3a4IA6INoOig=; b=vFUGkf0orV5GzxqUi8y84O4ou3
	dLF1f+JLzI0EM+b/JaOQ8+TqPl+VsRmuZZcfcCcF6WnhYHjfCxfIYtaM5hF7vOYo+ao3o7ZNDgHL3
	9y7iou5jte1/RwwuFOw63r2/g2YpnVSbBTl8Z999utnDQXJgMbgxRLGH4+4HSBh7MjSsHrfBkHHhY
	Ok9mTJuerLlHRUtwRzRgwoN1lINxhdZ2D8PAUsBYzQzVvYofHBeO3S6N/aRAeZlyF5dPfObPQTrb/
	VSer0a24by8WqOL4AOskdnPWU+kvJTPW6lDC6JQHU2VU2V4miUdBIoGCFb+a58WIgHtPC68CjVHGC
	xhCgMIrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qyvAA-00BZmd-0p;
	Fri, 03 Nov 2023 14:28:42 +0000
Date: Fri, 3 Nov 2023 07:28:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@infradead.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUUDmu8fTB0hyCQR@infradead.org>
References: <ZT+uxSEh+nTZ2DEY@infradead.org>
 <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
 <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102-schafsfell-denkzettel-08da41113e24@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 02, 2023 at 12:07:47PM +0100, Christian Brauner wrote:
> But at that point we really need to ask if it makes sense to use
> vfsmounts per subvolume in the first place:
> 
> (1) We pollute /proc/<pid>/mountinfo with a lot of mounts.
> (2) By calling ->getattr() from show_mountinfo() we open the whole
>     system up to deadlocks.
> (3) We change btrfs semantics drastically to the point where they need a
>     new mount, module, or Kconfig option.
> (4) We make (initial) lookup on btrfs subvolumes more heavyweight
>     because you need to create a mount for the subvolume.
> 
> So right now, I don't see how we can make this work even if the concept
> doesn't seem necessarily wrong.

How else do you want to solve it?  Crossing a mount point is the
only legitimate boundary for changing st_dev and having a new inode
number space.  And we can't fix that retroactively.


