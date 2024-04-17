Return-Path: <linux-fsdevel+bounces-17097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F7E8A7A5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 04:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 259ABB21BB6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 02:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0C146A4;
	Wed, 17 Apr 2024 02:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H5c9oiEG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2D23B0;
	Wed, 17 Apr 2024 02:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713319952; cv=none; b=KpDFga91/V84kPAgqf4zJUOvSDPusnCkfjyu17NcLcqv9hg19R4hY5d3LQnaEpy9xPCYqxraqv7cmsLqg2HLOi9UFrCiaTjrKYRgxQrhlxlb7r/M6XRB5SXdoxh/Jp/bfmjFP2Yo9uhuiZI8ESHo2sdDWSLcy1UHpHwJdQZeKsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713319952; c=relaxed/simple;
	bh=eY3pmLksysPe2ulTgDnUN9gqrJ4p9Xqaq5SfxhG/aBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5J11iAxBmhJFdY8Ef+kCka7xq3VTgIM7e/z3nY39qG8bOry97Pk69R0VQ58yR/wYowfHUiukjo6xsKnJ2UG4JGkUW+EOvGsrLEmkI/LA5YUlAbsc3+yFAjW73NnGrp0yyn0lDUX1XypDddeuKKB3c4RwKdSuxDG4y3Z66wfv/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H5c9oiEG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=qBPkUnoRVRpm8610v9X++R5ryrj7H1gSgqJjS0uxRvI=; b=H5c9oiEGQbV+g2uggYKJRn/NeZ
	0Qdsp/fN6UffwYRqUNuzwS6UOwNpiUdau8U1KPLRXebacSrOwWWrBj8AzA+HyYz66++a9Wayu8MlC
	9/L9NVbYJohVTzGAyGR+N3Tq4urVTBL7G41OzDzDa1hKEjfX1b52Ea4ILEyzqf0pTwlanG7SvwXf5
	gPtvtJfG93AMiZB5/ykRvBx1Rln/Ua8/gbYLR8sa6OPZWKpwKoJT0s0QIW49sK/RqhCISNvpF3tUq
	xuNWtSrW+8xbI1ZbG8bUUf1ix80WRfnlunevVyAFGtwQxZFoquQ0d7QnPR4GMsrFWQ45XPF8bKJnx
	oP3ty9Sw==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwumj-0000000ERHZ-10rU;
	Wed, 17 Apr 2024 02:12:31 +0000
Message-ID: <1027c9cf-dfb9-4893-a686-5bcc43b68770@infradead.org>
Date: Tue, 16 Apr 2024 19:12:28 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] buffer: Fix __bread and __bread_gfp kernel-doc
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20240416031754.4076917-1-willy@infradead.org>
 <20240416031754.4076917-5-willy@infradead.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240416031754.4076917-5-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/15/24 8:17 PM, Matthew Wilcox (Oracle) wrote:
> The extra indentation confused the kernel-doc parser, so remove it.
> Fix some other wording while I'm here, and advise the user they need to
> call brelse() on this buffer.
> 
> __bread_gfp() isn't used directly by filesystems, but the other wrappers
> for it don't have documentation, so document it accordingly.
> 
> Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>


Tested-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  fs/buffer.c                 | 35 ++++++++++++++++++++++-------------
>  include/linux/buffer_head.h | 22 +++++++++++++---------
>  2 files changed, 35 insertions(+), 22 deletions(-)
> 

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

