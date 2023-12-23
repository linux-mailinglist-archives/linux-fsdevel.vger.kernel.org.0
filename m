Return-Path: <linux-fsdevel+bounces-6854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3223781D5C2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 19:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560201C2102D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 18:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D1D12E60;
	Sat, 23 Dec 2023 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nn/AMTzb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BE712E4C;
	Sat, 23 Dec 2023 18:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=2jvNDXBO9ivO7Sbb6M9wuLWRhd9V7Vh386CcaKq/gbA=; b=Nn/AMTzbqY49PyYek9j2d26g+H
	yQ+KCwJaG7makEqJX6BjgyDrtCykhSX9c95HVI/8xEAiMufewHZhxOXqxLvXpq06iUop/qzIvQ+Y4
	KZHVXcT/Be05KciZ+nSXztbKE/HB5qlmalVx+sE5NpxRMZCAmIjQ2k/LM4l7zJ4CoUMN7Yl4X0rBg
	MSCl3pUJbRrQdv8BV6O/DZzVqtoBDCa9xXk/1JlFCpAYIbNhWzVCSuSni/rj+VRxRm35wgr0wXPqh
	EXI8x2qOMublIiNP5rxvyYr0oDgx8Mhxnw/babgISXyoSxT3xJMX9WFemA33SGopEDphB9GxsM2Ix
	Sb8vT71Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rH6gv-008I1E-0j;
	Sat, 23 Dec 2023 18:25:41 +0000
Date: Sat, 23 Dec 2023 10:25:41 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: delete unused define SYSCTL_PERM_EMPTY_DIR
Message-ID: <ZYcmJTsgDdptxBHS@bombadil.infradead.org>
References: <20231223-sysctl-perm-empty-dir-v1-1-194edd9b09dd@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231223-sysctl-perm-empty-dir-v1-1-194edd9b09dd@weissschuh.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Sat, Dec 23, 2023 at 02:53:47PM +0100, Thomas Weißschuh wrote:
> It seems it was never used.
> 
> Fixes: 2f2665c13af4 ("sysctl: replace child with an enumeration")
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> This was originally part of the sysctl-const series [0], but it doesn't
> really belong in there.
> To slim down that series as much as possible, submit this patch on its
> own.
> 
> [0] https://lore.kernel.org/lkml/20231204-const-sysctl-v2-2-7a5060b11447@weissschuh.net/

Applied, and pushed! BTW:

$ b4 am -s
20231223-sysctl-perm-empty-dir-v1-1-194edd9b09dd@weissschuh.net
Grabbing thread from
lore.kernel.org/all/20231223-sysctl-perm-empty-dir-v1-1-194edd9b09dd@weissschuh.net/t.mbox.gz
Analyzing 1 messages in the thread
Checking attestation on all messages, may take a moment...
---
✓ [PATCH] sysctl: delete unused define SYSCTL_PERM_EMPTY_DIR
+ Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
✗ No key: ed25519/linux@weissschuh.net
✓ Signed: DKIM/weissschuh.net

 Luis


