Return-Path: <linux-fsdevel+bounces-69332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A766C76A49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 00:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 26AFA28B10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5213002CA;
	Thu, 20 Nov 2025 23:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ePMfY4jR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926A12D9ECF;
	Thu, 20 Nov 2025 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763682273; cv=none; b=khYF3qqrZ/hltGF78hsG1JWaNog5C/HnnG+uSrFxYLEkQ1u/T/ocl9wcJTWk+A5mt/T3g0oPfwsu9XPfR2+6gsMxgCabDwM4GJEpJhR18UO7wWn1CHubm9OMe7rFRekihCMhX2JhRpOktOlG2WIk+9DpT/e6zlLarZHqT4nXO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763682273; c=relaxed/simple;
	bh=4L45HTjGHrfEl6i1ILnnDzqWPjChLXdsXz8M9gQYW4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4tSaDM7Hv8UW1FhNpBN7VOd5tnH2E/lMMgkTobY78UguvIyJMD1WBwumjsUuC9TSl22L9hLFo3KpYRGobp+t9BxcU/C7WTq0wG/cb75/Uaiyjp6lNhcNkF6DJZxIjcjEdK2WTnZnOFfeVGojnXFopZo95OVc2PXMQkxslByLIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ePMfY4jR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=30SBch2rBM61MOy0/thJ71GnBVIcmzjKN0wPaFWE0Ts=; b=ePMfY4jRRP6nkfuZgr/ljc8yzz
	m//rNXmWwXad1uRggB0KRx9WsnFl0/cqCalj/16lHerWSLcK1q52cEtl7s48HmBGWUVpoDTJdVuh0
	go/eTdGZ6OZSVjHpj9g6SfuiPB7rmYSQohKpv//KpmZvgkgMSLxk9x2EvOOPo+nWPF4/LhAodcvz1
	KTC7N3nsyWBu60Z1URVS08mvMyWKrWd+js2pwwi9Yw69ib2yA1KwgzT2EjRP0dyyphnLct+6wI56d
	JJNHUaeE23/sQSLbMq+E2u5cwCN8htwtU4WWXAL54p54xbl3/agd3JXHDKjLUfy6dxGc+dKJEw/2k
	Z8fYCpGg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMEK8-00000007aBg-1VuK;
	Thu, 20 Nov 2025 23:44:24 +0000
Message-ID: <5c3c4233-3572-4842-850e-0a88ce16eee3@infradead.org>
Date: Thu, 20 Nov 2025 15:44:23 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] init: remove deprecated "load_ramdisk" and
 "prompt_ramdisk" command line parameters
To: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Aleksa Sarai <cyphar@cyphar.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Julian Stecklina <julian.stecklina@cyberus-technology.de>,
 Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>,
 Rob Landley <rob@landley.net>, Lennart Poettering <mzxreary@0pointer.de>,
 linux-arch@vger.kernel.org, linux-block@vger.kernel.org,
 initramfs@vger.kernel.org, linux-api@vger.kernel.org,
 linux-doc@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
 Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>,
 Arnd Bergmann <arnd@arndb.de>, Dave Young <dyoung@redhat.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Krzysztof Kozlowski <krzk@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Jessica Clarke <jrtc27@jrtc27.com>, Nicolas Schichan <nschichan@freebox.fr>,
 David Disseldorp <ddiss@suse.de>, patches@lists.linux.dev
References: <20251119222407.3333257-1-safinaskar@gmail.com>
 <20251119222407.3333257-2-safinaskar@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251119222407.3333257-2-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/19/25 2:24 PM, Askar Safin wrote:
> ...which do nothing. They were deprecated (in documentation) in
> 6b99e6e6aa62 ("Documentation/admin-guide: blockdev/ramdisk: remove use of
> "rdev"") in 2020 and in kernel messages in c8376994c86c ("initrd: remove
> support for multiple floppies") in 2020.
> 
> Signed-off-by: Askar Safin <safinaskar@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 4 ----
>  arch/arm/configs/neponset_defconfig             | 2 +-
>  init/do_mounts.c                                | 7 -------
>  init/do_mounts_rd.c                             | 7 -------
>  4 files changed, 1 insertion(+), 19 deletions(-)


-- 
~Randy

