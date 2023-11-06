Return-Path: <linux-fsdevel+bounces-2045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A04AB7E1B85
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 08:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85BC1C20AAE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 07:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6CFF9D6;
	Mon,  6 Nov 2023 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IBLSX7Qp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D9ABA49
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 07:53:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD5BB3;
	Sun,  5 Nov 2023 23:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YM4MsMFJ6bT2wXXzMvFgAHevmPY5/9JeSlZIQ1ihbtQ=; b=IBLSX7QpsVTrHC8uvWK0DYgMkE
	38J9DF/2kzWoMnWODTD1xmu2x8ko2Bb4sjDpqRJfiABsv5iePauVAY8Qr7TyFRdBx7NjmIA6yehqc
	1jrTRWshDsfECCHHMkVwTzfxPHTJ6dGCAiHeb4KfIHBpCQJfERxB5uRvHOWWXiVFeGa2/hZ0q0pxl
	t8ToArDRbI99QIUZkyNw4yZzxOxqaF9kex1tIWFakQk/4maJowz+5dUer6bOM/J6UM1sVCLN5mNU4
	mxTqaMJh1eaAFQ/kLSPOsZK+7V5qHRlmAEVyN+i1Ku/1Gaqn5OO35C5HMk2ppzPImgVqetij6kafn
	m3TJWt1g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qzuQ2-00G27L-2Q;
	Mon, 06 Nov 2023 07:53:10 +0000
Date: Sun, 5 Nov 2023 23:53:10 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUibZgoQa9eNRsk4@infradead.org>
References: <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Nov 03, 2023 at 04:47:02PM +0100, Christian Brauner wrote:
> I think the idea of using vfsmounts for this makes some sense if the
> goal is to retroactively justify and accommodate the idea that a
> subvolume is to be treated as equivalent to a separate device.

st_dev has only been very historically about treating something as
a device.  For userspae the most important part is that it designates
a separate domain for inode numbers.  And that's something that's simply
broken in btrfs.

> I question that premise though. I think marking them with separate
> device numbers is bringing us nothing but pain at this point and this
> solution is basically bending the vfs to make that work somehow.

Well, the only other theoretical option would be to use a simple
inode number space across subvolumes in btrfs, but I don't really
see how that could be retrofitted in any sensible way.

> I would feel much more comfortable if the two filesystems that expose
> these objects give us something like STATX_SUBVOLUME that userspace can
> raise in the request mask of statx().

Except that this doesn't fix any existing code.

> If userspace requests STATX_SUBVOLUME in the request mask, the two
> filesystems raise STATX_SUBVOLUME in the statx result mask and then also
> return the _real_ device number of the superblock and stop exposing that
> made up device number.

What is a "real" device number?

