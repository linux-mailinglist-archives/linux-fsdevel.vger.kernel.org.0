Return-Path: <linux-fsdevel+bounces-74203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 704EBD384B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B9B43106A1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 18:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BA034D4E9;
	Fri, 16 Jan 2026 18:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iz47OmGc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF4D26CE3F;
	Fri, 16 Jan 2026 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589203; cv=none; b=itevq/47TJK2dPT/WpyL54jPSsJr3JqC9n+MtuQVD4XY38ykVpYSHM71tNejlv7oodxMJSyg55HNAYM9dZaa0FpL1gEhjJvdcNb7904yA+d1xFL4VXiA6CSTxYekM16nEt2wIY+ztKPjQnxMZ4j3Ir7MYwV6tOJzNpfKOZEJbOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589203; c=relaxed/simple;
	bh=Hg0xsJd2xlHtEnV074HJlo+cfsyUYIw5tEsoNG6BoH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7wzj0ymA9xYngXEkR2oo9x3S6vxT7TZreq04SbsqMxPlgotQetrgcGo3LjaNLTbVUy/EzGDA6VVQfhE0bGQNn6Pq0Mz9cI32gO9Axv2OeLK1yCc/51b8Gvp3MMuTSyLQ990NhU+ko1+WIMO7of/pZZkH0dRs4q/Aq3QpJmZ8M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Iz47OmGc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=MHrE0rWzG0dpS7dJqfZQrywda36bki4qaWtyeRwR/x4=; b=Iz47OmGcFNPw5UJ/i86Or+PdZb
	QttBOJa0DIHx0GMfQ5rcLIosQJUzKgvRqzbbymCDMMqBl3aaTsMDWhqMKmNxLs0rSEkugeoNsesSK
	d6i67oDSGQS1Tza36KJbx4ZIRn8qktBOEmyg1nJlmXkuKSQZ01UPWJSV24NwtJyBvL17pgk798+oN
	+rHd6IUQb/27FyYj1+hgqS/eAE/3RTy2x/bWci6Y8ZkGg7zZuixHjKLC1Dtn9JKiOVBW1sm8ziHUF
	MLrQHpgXm/TxeB0Opru+5exD41H6obK4CbJxCMm9K9lT+TQkttz+13yGwg2kMmhQCmqlgeer+Uwci
	D/swX0uA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgoq8-0000000Eea2-1Yxl;
	Fri, 16 Jan 2026 18:46:32 +0000
Message-ID: <501f8b16-272b-4ea5-92ef-6bdb6f58f77b@infradead.org>
Date: Fri, 16 Jan 2026 10:46:31 -0800
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
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <871pjpo0ya.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/16/26 10:40 AM, Jonathan Corbet wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> Include fs/open.c in filesystems/api-summary.rst to provide its
>> exported APIs.
>>
>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: linux-fsdevel@vger.kernel.org
>>
>>  Documentation/filesystems/api-summary.rst |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>> --- linux-next-20251219.orig/Documentation/filesystems/api-summary.rst
>> +++ linux-next-20251219/Documentation/filesystems/api-summary.rst
>> @@ -56,6 +56,9 @@ Other Functions
>>  .. kernel-doc:: fs/namei.c
>>     :export:
>>  
>> +.. kernel-doc:: fs/open.c
>> +   :export:
>> +
> 
> So I've applied this, but it does add a couple of new warnings:
> 
>   Documentation/filesystems/api-summary:59: ./fs/open.c:1157: WARNING: Inline emphasis start-string without end-string. [docutils]
>   Documentation/filesystems/api-summary:59: ./fs/open.c:1147: ERROR: Unknown target name: "o". [docutils]
> 
> It would be nice to get those fixed up.

Will do. Seems like I tweaked those already. I'll check.

thanks.
-- 
~Randy


