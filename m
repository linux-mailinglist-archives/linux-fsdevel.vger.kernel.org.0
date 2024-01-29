Return-Path: <linux-fsdevel+bounces-9412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9BB840B27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 17:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30E09B22DD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10938156964;
	Mon, 29 Jan 2024 16:19:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A56154439;
	Mon, 29 Jan 2024 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545177; cv=none; b=fXAvK599JvKrmng66+dr1+BsgM2vN4MnZ0laUROu5M19sAhRGOPAOtPRId2GA5bETF2fBjJ4ugPnUW40VBVxbVDUhOzEBQ3NfErRc4c02AmR/LXMfUFGR8rmL4tw7JswDAJIb0nEti+hfM0Rgd2rYlLbR0esoHf0YncagSwr+cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545177; c=relaxed/simple;
	bh=Ji7XkAedxR/vTHzAswTeM1hI+VxoQwBnN/vbCg57Vv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQmiO0ac3ZkV/VqEvDGUsNZOr+ltN6QCu4vO5I6knGC5STvjR2A7GaL/cxuc2xwytJqK7v1GdwIiFpvPlIVi/gQQWUwOdHbPlxtr5qIvZiUmrIPb0eg0yYxUW+wTgMfPakwbKSO47z+rqYhfIXYT1YDK6YKOzqC8Gc62ToX8p1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 72B3468C4E; Mon, 29 Jan 2024 17:19:33 +0100 (CET)
Date: Mon, 29 Jan 2024 17:19:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 28/34] bdev: make bdev_release() private to block
 layer
Message-ID: <20240129161933.GH3416@lst.de>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org> <20240123-vfs-bdev-file-v2-28-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-28-adbd023e19cc@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 23, 2024 at 02:26:45PM +0100, Christian Brauner wrote:
> and move both of them to the private block header. There's no caller in
> the tree anymore that uses them directly.

the subject only takes about a single helper, but then the commit
message mentions "both".  Seems like the subject is missing a
"bdev_open_by_dev and".

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

