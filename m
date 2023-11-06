Return-Path: <linux-fsdevel+bounces-2097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001917E2651
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 15:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F655B20DD8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 14:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC95A2747D;
	Mon,  6 Nov 2023 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vppqxvf/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB1827474
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792AFC433C8;
	Mon,  6 Nov 2023 14:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699279859;
	bh=BxoSTuO4u/SJYd+0Xpj36hQ/yzIzZbV94ASNVv0iXmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vppqxvf/F40r2NuRJ/oMlzB7p/Zfi5YXI6pHjuVmSzDDrDCLwtYbKf0W6NbL8xJF9
	 JN3jgMob8ThPeXY0iQxaJnXHW+RKFEF7KKcXfK+EWJY7KTE8c1r8fAYrKoIdxopP36
	 /LFm+qwUJUGbG6zsfuXh/WAcEly3AxHpjPchuzPgR+nsABAyy2o08x65woToQ3Xxul
	 yubdUx41dCZoR+vZ3IDYzMP9ji6j1chQ7NaHTMtQ4iKfdkzWbAHBYIIEUx/6fuWDM3
	 R7zKgPlzmLqbuGf4zYDgg90eDyn5uMb/aSNE9CBkHzutFjKED8KE2Uvuut5tt+S95N
	 5kf4a5vJVlLkw==
Date: Mon, 6 Nov 2023 15:10:53 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Kees Cook <keescook@google.com>,
	syzkaller <syzkaller@googlegroups.com>,
	Alexander Popov <alex.popov@linux.com>, linux-xfs@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/7] block: Remove blkdev_get_by_*() functions
Message-ID: <20231106-rentabel-beurlauben-468c636d268e@brauner>
References: <20231101173542.23597-1-jack@suse.cz>
 <20231101174325.10596-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231101174325.10596-2-jack@suse.cz>

On Wed, Nov 01, 2023 at 06:43:07PM +0100, Jan Kara wrote:
> blkdev_get_by_*() and blkdev_put() functions are now unused. Remove
> them.
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Yes, very nice!
Reviewed-by: Christian Brauner <brauner@kernel.org>

