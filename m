Return-Path: <linux-fsdevel+bounces-69941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CB5C8C74B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 01:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4482C352C6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 00:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6201D243954;
	Thu, 27 Nov 2025 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gqaD3g+A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667A823F413;
	Thu, 27 Nov 2025 00:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764204239; cv=none; b=QI7pctcdoZrnuIgHeaEX/2OohunANAyMTwWt52a9oC/qm6LdtwRsVnlfNn3os88bCH7cX6pjEK8D5he6LUH1pEKl4YSU25WeHwkDBKVCfFqfE53S3UiP8urZB7DZA/jlYI+cHZjgnQbZnTZ8uzfo0jTWXzDplxGSoAZia7qi39o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764204239; c=relaxed/simple;
	bh=vGdUvrXsubHg3xS9goy7UrVKGNPe1gkqPyoN7lhMfxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aydzHq0//TSEGx/m3E0XPwpk9XCNjoyPdQyXAAx5DGEYZyHPNIZ7N2XRjqyJo2Va8bhswe/uhPF9t2dVdMhf0oRH8k3RpUxaB50t6vOzpUKBfBKnEfsuAqeh3SROkhwC+dW4CNNemM4rfg+AA1o5IQbaGZgZFo7bQEjpNuw6ILU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gqaD3g+A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=MnBaS/n03uHzBxVWg+JjhWxepC1BgFttoWuUMr8MiLQ=; b=gqaD3g+AGecuRZZzovgKltL6o6
	awtioE3a0oLMcTM0Brv0Ulo+4zSs3rCNfYKGBEkLAdBa0wuII+8YTFLW4JK+66wqEnBzSIo6JZpMs
	YqQRclL/DqcvZGJX+34RV2IQbKqSSt662MzysUM+W7tlnpofomrhjBmueCnAbzwdkXsfr5ZHcIJy6
	qjLIxgQqD2vhQ+3ajTPSKzf6cPyIay0FC9aRYyjM/o2gbcIstw2an5E93bdtXZ2ndRVjQuylqViO0
	XGNZXDOeu8fChjNIdknVVO+s/lrAWaxRa4tYPrPJLx8pVvarFxngzInLIbzHt/A8MYtLsdW32rfKn
	M7cED/qw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOQ73-0000000FoOH-3nUP;
	Thu, 27 Nov 2025 00:43:57 +0000
Message-ID: <2ea0c3d1-c2ae-400b-95fc-54f9ac5b3318@infradead.org>
Date: Wed, 26 Nov 2025 16:43:57 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] Documentation: zonefs: Separate mount options list
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux AFS <linux-afs@lists.infradead.org>,
 Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>, Jonathan Corbet <corbet@lwn.net>,
 Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Daniel Palmer <daniel.palmer@sony.com>
References: <20251126025511.25188-1-bagasdotme@gmail.com>
 <20251126025511.25188-5-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251126025511.25188-5-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/25/25 6:55 PM, Bagas Sanjaya wrote:
> Mount options list is rendered in htmldocs output as combined with
> preceding paragraph due to missing separator between them. Add it.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/filesystems/zonefs.rst | 1 +
>  1 file changed, 1 insertion(+)
> 

-- 
~Randy

