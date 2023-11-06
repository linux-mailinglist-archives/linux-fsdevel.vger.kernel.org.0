Return-Path: <linux-fsdevel+bounces-2085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D50C7E2152
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 13:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86153B20FCC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 12:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834EF200A6;
	Mon,  6 Nov 2023 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="puA6n0Pg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FE41EB36
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 12:25:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D443CA4;
	Mon,  6 Nov 2023 04:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L5cl+RDGvEZz/eLwTMy1ZuCPzEPX60KHCPNo+ErIHy4=; b=puA6n0PgFkK0VPgWd7sgpG2sKf
	OmzKe1XT0YAyimc52KRiAoNH3O7Fhq11tS78bssrVpQO0kvL6mwWtq/FRod5W7JUC08ERJOBDokh+
	MGzUkO+0pGktqi7q27y5BrHpvOu9tR6YqvXhowUaDtSyN2QKyY2LKR6R/L7bVW4o+sn7pfzf2c11+
	3n4D480mji01XbaZ0xulBr9wfUPqoIPCZEWPY5yBnYWeAbOhX3LrtloYWcbZsWaPi/ZoIaNmmbcdv
	/UqFj568ILBgUbruYDaQs+rjPuAB3sqX5rtvGqU5Wrc/mkdXnCLsXrN0Zc3xYxYJuArzoeFfAYDP6
	OfTe6/lA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qzyfc-00GdBF-0X;
	Mon, 06 Nov 2023 12:25:32 +0000
Date: Mon, 6 Nov 2023 04:25:32 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUjbPK0oizILoUDl@infradead.org>
References: <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <1d08a205-b2c5-4276-b271-088facc142ea@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d08a205-b2c5-4276-b271-088facc142ea@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 06, 2023 at 06:48:11PM +1030, Qu Wenruo wrote:
> > st_dev has only been very historically about treating something as
> > a device.  For userspae the most important part is that it designates
> > a separate domain for inode numbers.  And that's something that's simply
> > broken in btrfs.
> 
> In fact, I'm not sure if the "treating something as a device" thing is even
> correct long before btrfs.

It never really has been.  There's just two APIs that ever did this,
ustat and the old quotactl.  Both have been deprecated a long time ago
and never hid wide use.

> For example, for an EXT4 fs with external log device. Thankfully it's still
> more or less obvious we would use the device number of the main fs, not the
> log device, but we already had such examples.

More relevant (as the log device never has persistent data) is the XFS
realtime device.


