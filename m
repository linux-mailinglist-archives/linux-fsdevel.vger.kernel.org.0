Return-Path: <linux-fsdevel+bounces-9635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C77B843D0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 11:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55A51F32ADE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 10:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D456A030;
	Wed, 31 Jan 2024 10:43:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03F869DF1;
	Wed, 31 Jan 2024 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706697800; cv=none; b=CMWwoy1Vd9n5eBe5MmkEzTbERBv8QD4Oks0CCqofSHVwDzDnc3bC91FFvfqC6KUBzo/zc0OoMV4PU/X5oFrt64wHHxU3dGsnNgcD3THNwJvVdjACUDm+sGaiLFGV/ymLX/UVLN5Pt/nwwNvAnkjxMuS+lzwcbOLOZUoJV0UCPvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706697800; c=relaxed/simple;
	bh=O9MHI8xAzGev75PJgfqegPIBnpq9OAblRUhbyK1sJW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxkTgG15ezuP7Teb5wsbjMBKpZpsC4gDY1BteHh+FRGWEeiYSQaXlHh9O50ZXI4q8aKsRtNbnfWifb18u0OXqsr5f+BuQkDsqVnIap3HGgMe/O/FEk4jv9jklwA4LZbL9cDd/Tj7un/CkNeKdNftftvW0pV/dxvwe807ujW7ZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 08A0C68AFE; Wed, 31 Jan 2024 11:43:08 +0100 (CET)
Date: Wed, 31 Jan 2024 11:43:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/19] writeback: simplify writeback iteration
Message-ID: <20240131104307.GA22459@lst.de>
References: <20240125085758.2393327-1-hch@lst.de> <20240125085758.2393327-20-hch@lst.de> <20240130104605.2i6mmdncuhwwwfin@quack3> <20240130141601.GA31330@lst.de> <20240130215016.npofgza5nmoxuw6m@quack3> <20240131071437.GA17336@lst.de> <20240131104045.ojke3u3t6bj4vhr7@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131104045.ojke3u3t6bj4vhr7@quack3>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 31, 2024 at 11:40:45AM +0100, Jan Kara wrote:
> Yes, this looks very good to me. Feel free to add:

Thanks!  I'd also really love to hear from Brian and Matthew before
reposting.  Or from anyone else interested..


