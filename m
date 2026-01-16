Return-Path: <linux-fsdevel+bounces-74246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3955D3892F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F38433011F90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 22:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB983112AD;
	Fri, 16 Jan 2026 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F7i5oKTx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F3F3101B8;
	Fri, 16 Jan 2026 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602274; cv=none; b=Fr/Tu4kP1l5ca1tT2G5vFqcETTi99d4KmJBC0FULR8nktupsFtYjSFqZCHaR00CG4rLAVdATfUT5otu9Rb94FcqHSRx2hKqOU+T0yiJoNVaHL1A0Sy4vdciZnJZYGoXsouKT4bB1/dWuTIZd+T2lrCpKF+WuVljXRLntpSSrj4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602274; c=relaxed/simple;
	bh=dEsh51BfY9Yhh/oIhDSFuw4NK5Ufis9ILjNyZwiBlsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtDtY6tLpIMxpdNJxU9sH3THtBx9eyicdJ8CGpk4uUgrqSeWELtauOimeE1JJUYrO+rpwt+Tu6AI2jKF+QlzaIieqrokMk6c2wPLeVAGPltEyYSepE5/RpjvMSBkfaPS1g1t9sC5ciTFPyS/zBdpAJNzObbjotQmX67wSMt7XxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F7i5oKTx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=2mOM9aRe8iVomi2m434XH1vvlL3fIgiMm5iAjwPqfdI=; b=F7i5oKTx/+I0A9OO0+p3FicKUw
	np8YED5hK5aqn0GyF9tbh5dZTIw6DySKeiFw+ZngYhvXqcIFdxQmAH4aGz6ba+wKliw7Y0JuEE5T/
	u4WuIkvg2U4hRsIWzWPxY6lSMts6aHc1mcbgLRmdYgZ4T4+s9Tjub22ytyg0xpqVEda25o8XNs9OX
	u5LF5d74X6cr2JZbDD1FC001qWPgpo8F4D1gpQC9zX1k+pBjkTGOUdS6aHlM2+DOzdGjfBf98QBXf
	83eseYspq2PyvFeu3+EDo/u8OvC8QCqGe79YORPAcxj5fNo26zcFbm31+zpcXjNKnemLp9o2wulMu
	qipZGOJg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgsF6-0000000EyOY-06xo;
	Fri, 16 Jan 2026 22:24:32 +0000
Message-ID: <7db41ccc-11c8-4d3c-adbf-9d4f1f70f386@infradead.org>
Date: Fri, 16 Jan 2026 14:24:31 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: filesystems: add fs/open.c to api-summary
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
References: <20260104204530.518206-1-rdunlap@infradead.org>
 <871pjpo0ya.fsf@trenco.lwn.net>
 <501f8b16-272b-4ea5-92ef-6bdb6f58f77b@infradead.org>
 <c7d47b56-2d37-4893-b8ec-1fb23f75a55e@infradead.org>
 <87wm1hmk82.fsf@trenco.lwn.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87wm1hmk82.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/16/26 11:27 AM, Jonathan Corbet wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> Seems I was confused with fs/namei.c, where I see similar warnings.
>> I don't see those warnings in fs/open.c.
>>
>> I'm using today's linux-next tree, where the latest change to
>> fs/open.c is:
>> ommit 750d2f1f7b5c
>> Author: Al Viro <viro@zeniv.linux.org.uk>
>> Date:   Sun Dec 14 03:13:59 2025 -0500
>>     chroot(2): switch to CLASS(filename)
>>
>> Do you have something later (newer) than that?
>>
>> Also, at fs/open.c lines 1147-1157, I don't see anything that would
>> cause docs warnings.
> 
> No, docs-next is older - based on -rc2.  It seems that linux-next has
> significantly thrashed thing there, and the offending function
> (dentry_create()) moved to namei.c...

2 patches have been sent for these warnings:

2025-12-19:
https://lore.kernel.org/all/20251219-dentry-inline-v2-1-c074b5bfb3a6@gmail.com/

2025-12-31:
https://lore.kernel.org/all/20251231153851.7523-1-krishnagopi487@gmail.com/


-- 
~Randy


