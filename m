Return-Path: <linux-fsdevel+bounces-6862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9C781D8BF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 11:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5181C2178D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 10:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785333D6B;
	Sun, 24 Dec 2023 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="r5nbBjjQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1002565;
	Sun, 24 Dec 2023 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1703414559;
	bh=CvQyVonapKKk7Y2udUySpLUKu8fg/y974JE5CTZbnLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5nbBjjQBCmoBku/WyLKJHrLXLY047GLxht3tv8tE5DnKboMF0v2MBN/yGPLbdQB5
	 2tXQQ/z9c0qr/zoJlI2IdXT22wQKF7NdrG+isjbH8jekau20F+y4puZdJLdGIvFlmL
	 +6tD93OTt/y4Xzw9ZK7joTNAepbkMY3xdIEG9K2I=
Date: Sun, 24 Dec 2023 11:42:38 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, 
	Joel Granados <j.granados@samsung.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: delete unused define SYSCTL_PERM_EMPTY_DIR
Message-ID: <966d0fd3-9a01-48d3-a146-4ce18c7a21ad@t-8ch.de>
References: <20231223-sysctl-perm-empty-dir-v1-1-194edd9b09dd@weissschuh.net>
 <ZYcmJTsgDdptxBHS@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZYcmJTsgDdptxBHS@bombadil.infradead.org>

On 2023-12-23 10:25:41-0800, Luis Chamberlain wrote:
> On Sat, Dec 23, 2023 at 02:53:47PM +0100, Thomas Weißschuh wrote:
> > It seems it was never used.
> > 
> > Fixes: 2f2665c13af4 ("sysctl: replace child with an enumeration")
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > This was originally part of the sysctl-const series [0], but it doesn't
> > really belong in there.
> > To slim down that series as much as possible, submit this patch on its
> > own.
> > 
> > [0] https://lore.kernel.org/lkml/20231204-const-sysctl-v2-2-7a5060b11447@weissschuh.net/
> 
> Applied, and pushed! BTW:

Thanks!

> $ b4 am -s 20231223-sysctl-perm-empty-dir-v1-1-194edd9b09dd@weissschuh.net
> Grabbing thread from
> lore.kernel.org/all/20231223-sysctl-perm-empty-dir-v1-1-194edd9b09dd@weissschuh.net/t.mbox.gz
> Analyzing 1 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
> ✓ [PATCH] sysctl: delete unused define SYSCTL_PERM_EMPTY_DIR
> + Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> ✗ No key: ed25519/linux@weissschuh.net
> ✓ Signed: DKIM/weissschuh.net

b4 needs a manual import of contributor keys for it to validate them:

https://b4.docs.kernel.org/en/latest/maintainer/kr.html


Thomas

