Return-Path: <linux-fsdevel+bounces-74233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A2FD385C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D11C33005301
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DA834DCD7;
	Fri, 16 Jan 2026 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1wrTyrBQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203B534B40E;
	Fri, 16 Jan 2026 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768591411; cv=none; b=svWowVDLFuv0YvbG2501lUC1vYgyLQf90XBpsQh1zoZZUzBMt9gXJiSOJmNS0MGbw2WyIxX3kQbwbKwoSNGOS9sPQJZ8ZqKUvEYghY1wtRoqr3hByATVAcx/CCIevi4vjFr/SsUiTk/nSzUeKqqlMpSs80i3PiWYxKpzfSbvWQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768591411; c=relaxed/simple;
	bh=3BjVDVTlVUU4fI5lPGE9loNEXKBPuM3zKYeRYkLXH9g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jjRIgtBeiOeAK1HpbetprYdMbkzEtnZCTAYph5Ssei7YkKF9ZbMh5BkxY5oP6APsu23n3MrhCaxoVtzKAg/YPUSEPkyv3iWYBtrX8/v+a9llncJFHemBry1e3B+RFy/VP/QbJp5YdzjLNIhMtowUm9Nwzjw4aYClnfHTB1zKu6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1wrTyrBQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=3sA+p1N9b66WR+TKvhOTqHe83FAD9YPoWBp9jPBxBD8=; b=1wrTyrBQt4osn9As4Awxe41la3
	VvWQ39pQs6OsDVEJ8astk2NGm2Yf1HofE3vD8innL1e+ucCpZmgC7ijl9fMZphPCeeRZoPyrWhluq
	DKUPdo4zOY/3ACw8M5fifMlwEXrbhaoYXxlkYUuxLxMRBtgVh4FF5WCX3UDrWLyM8mgfitMDFhwgs
	OL92FpOotjMZ7kV9ekeSj75c/BtrxlmaHvisLvciVWsGiqhnevus1mrN6hrgTt7tX8WBXSEOiR95u
	hwtMX0Wwfb3ZuNNTRByO8V2eexgmuxOFodr4LeC9KIREYA9y+NdTqIIq4PwwBZhkSQnlXF8q+t+0F
	gU1xxS4A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgpPt-0000000Egng-1BV1;
	Fri, 16 Jan 2026 19:23:29 +0000
Message-ID: <c7d47b56-2d37-4893-b8ec-1fb23f75a55e@infradead.org>
Date: Fri, 16 Jan 2026 11:23:28 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: filesystems: add fs/open.c to api-summary
From: Randy Dunlap <rdunlap@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
References: <20260104204530.518206-1-rdunlap@infradead.org>
 <871pjpo0ya.fsf@trenco.lwn.net>
 <501f8b16-272b-4ea5-92ef-6bdb6f58f77b@infradead.org>
Content-Language: en-US
In-Reply-To: <501f8b16-272b-4ea5-92ef-6bdb6f58f77b@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/16/26 10:46 AM, Randy Dunlap wrote:
> 
> 
> On 1/16/26 10:40 AM, Jonathan Corbet wrote:
>> Randy Dunlap <rdunlap@infradead.org> writes:
>>
>>> Include fs/open.c in filesystems/api-summary.rst to provide its
>>> exported APIs.
>>>
>>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> ---
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>>> Cc: Christian Brauner <brauner@kernel.org>
>>> Cc: linux-fsdevel@vger.kernel.org
>>>
>>>  Documentation/filesystems/api-summary.rst |    3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> --- linux-next-20251219.orig/Documentation/filesystems/api-summary.rst
>>> +++ linux-next-20251219/Documentation/filesystems/api-summary.rst
>>> @@ -56,6 +56,9 @@ Other Functions
>>>  .. kernel-doc:: fs/namei.c
>>>     :export:
>>>  
>>> +.. kernel-doc:: fs/open.c
>>> +   :export:
>>> +
>>
>> So I've applied this, but it does add a couple of new warnings:
>>
>>   Documentation/filesystems/api-summary:59: ./fs/open.c:1157: WARNING: Inline emphasis start-string without end-string. [docutils]
>>   Documentation/filesystems/api-summary:59: ./fs/open.c:1147: ERROR: Unknown target name: "o". [docutils]
>>
>> It would be nice to get those fixed up.
> 
> Will do. Seems like I tweaked those already. I'll check.
> 
> thanks.

Seems I was confused with fs/namei.c, where I see similar warnings.
I don't see those warnings in fs/open.c.

I'm using today's linux-next tree, where the latest change to
fs/open.c is:
ommit 750d2f1f7b5c
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun Dec 14 03:13:59 2025 -0500
    chroot(2): switch to CLASS(filename)

Do you have something later (newer) than that?

Also, at fs/open.c lines 1147-1157, I don't see anything that would
cause docs warnings.

Ideas?

thanks.
-- 
~Randy


