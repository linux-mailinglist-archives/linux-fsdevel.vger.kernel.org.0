Return-Path: <linux-fsdevel+bounces-7005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F354581F8CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 14:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE511F24292
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 13:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDACD8495;
	Thu, 28 Dec 2023 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hxvOFu0r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219968465;
	Thu, 28 Dec 2023 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=SKnhnxQ3SKksZObvbGWia/kMA4sV8PCdLCik9kiibwc=; b=hxvOFu0rb3hufv/+M4NNENJZEp
	IXHxqrpv/kghs1Fzqtv08DpFbNljJcInJl1mGDA6avysjr1SrNNv9Vwsv4TUicL3JQikdSSpXHH9Y
	upyFLNrDcoETSRKokwRvqHSY3/WLm1n5b1grLP6UvoMzqzgGylLvp0UNWtRRURltk/OnPnUE52zU3
	svyFeOhX3CVlI7F/K5p9HdzSqpMw5RLBv6OtIei/N9Vya/QMf3CPmFEjrIESseAX4lKnuXUcex90X
	q025HzhYg6QV8WqQJ8m1rGaHT+cXOITAGt1vSdfr4Pl/I3JIiP3eLiX16mS1gu4rn+sxtJvk+umfP
	+EDb5eVg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rIqLg-00Gvfy-09;
	Thu, 28 Dec 2023 13:22:56 +0000
Date: Thu, 28 Dec 2023 05:22:56 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] sysctl: treewide: constify ctl_table_root::set_ownership
Message-ID: <ZY12sLZYlQ09zU6D@bombadil.infradead.org>
References: <20231226-sysctl-const-ownership-v1-1-d78fdd744ba1@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231226-sysctl-const-ownership-v1-1-d78fdd744ba1@weissschuh.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Dec 26, 2023 at 01:32:42PM +0100, Thomas Weißschuh wrote:
> The set_ownership callback is not supposed to modify the ctl_table.
> Enforce this expectation via the typesystem.
> 
> The patch was created with the following coccinelle script:
> 
>   virtual patch
>   virtual context
>   virtual report

If you remove this virtual stuff and mention how we verify manually
through the build how users do not exits which rely on modifying the the
table I thinkt these two patches are ready, thanks for doing this in
Coccinelle it helps me review this faster!

  Luis

