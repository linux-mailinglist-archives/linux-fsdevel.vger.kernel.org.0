Return-Path: <linux-fsdevel+bounces-17082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E12708A77D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 00:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80CE91F23206
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 22:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79191132803;
	Tue, 16 Apr 2024 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ctM1BE2A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78065B201;
	Tue, 16 Apr 2024 22:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307117; cv=none; b=DjYHVf1M5b+9R1YNdJ/fEqqMWk/nfu1q+f2Hcyp61qFPqdjT3JmYr9DlLl16dV+NiY1ltXiz9HtZBgYCdMjSPf2a/O25N6puuEjzIbQxJowrLzT9JPG0+lqPAtUOC/8yASlmHM8mYv53qvQSQW+ZzxPSw0fN/3lEE77qPRgnPHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307117; c=relaxed/simple;
	bh=S7sE9brjfV8uQBeIEy6QZVeO3w3xji1TwLL3sVqLSxE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=X8aCsGOmXdkSlvmzn6L/5C8wIOd0IeaLHbcbT6iKPhvdGuag2jo+4/Xbp3bEeJoJLpWavdjDeGEmtiaj7F1dmXzYh/gaJ55sl2ZirQaE1M0ZqFI/60v8F6ZNFzWvMd35BDZVW+Ked0VVNvuuDNu2pc/+bGxjVdXSrRuoZQdGiPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ctM1BE2A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=KfsmsJ6C4WEujGSKO21oMe1mj3YNpyS/QO6bqt4zXM4=; b=ctM1BE2AsNOAM4hw0CuLWaoeqJ
	1lQQ/eJqSuSmtDvrIK6JvP6N326ZnkSIniIE7hWafNbp3FCL0iFtyb5m+KQUzaKzU9xR8UuU8Bbz/
	YYjBAsqlQrPDt6bCiismzxsUJuKtEsST/I6YNAD15wJHsxMcU3+t15NaksL1kD/ybGoNqFfOicP8Q
	UstMTYx8BJBzwlvivnWN+0O3oxXOAUt9HfqCt1hZNCjxaoLlSrMHuN8iMvBaeAcEQdO1uDtQ8kitb
	YPV0jQhZ4vwz9c2Lt6szcDymRH996jDHZt11O1Wyrl1V9GIheMkedSFOz/zxn7iPB44TUAhGbJIbA
	uAKSGJ6g==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwrRi-0000000E4dT-3GT1;
	Tue, 16 Apr 2024 22:38:34 +0000
Message-ID: <ae28ae0f-c1ca-4afe-89e4-cc5d66b998b2@infradead.org>
Date: Tue, 16 Apr 2024 15:38:33 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] doc: Split buffer.rst out of api-summary.rst
From: Randy Dunlap <rdunlap@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240416031754.4076917-1-willy@infradead.org>
 <20240416031754.4076917-9-willy@infradead.org>
 <5b1938bc-e675-4f1c-810b-dd91f6915f1d@infradead.org>
Content-Language: en-US
In-Reply-To: <5b1938bc-e675-4f1c-810b-dd91f6915f1d@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/16/24 3:18 PM, Randy Dunlap wrote:
> 
> 
> On 4/15/24 8:17 PM, Matthew Wilcox (Oracle) wrote:
>> Buffer heads are no longer a generic filesystem API but an optional
>> filesystem support library.  Make the documentation structure reflect
>> that, and include the fine documentation kept in buffer_head.h.
>> We could give a better overview of what buffer heads are all about,
>> but my enthusiasm for documenting it is limited.
>>
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> ---
>>  Documentation/filesystems/api-summary.rst | 3 ---
>>  Documentation/filesystems/index.rst       | 1 +
>>  2 files changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/Documentation/filesystems/api-summary.rst b/Documentation/filesystems/api-summary.rst
>> index 98db2ea5fa12..cc5cc7f3fbd8 100644
>> --- a/Documentation/filesystems/api-summary.rst
>> +++ b/Documentation/filesystems/api-summary.rst
>> @@ -56,9 +56,6 @@ Other Functions
>>  .. kernel-doc:: fs/namei.c
>>     :export:
>>  
>> -.. kernel-doc:: fs/buffer.c
>> -   :export:
>> -
>>  .. kernel-doc:: block/bio.c
>>     :export:
>>  
>> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
>> index 1f9b4c905a6a..8f5c1ee02e2f 100644
>> --- a/Documentation/filesystems/index.rst
>> +++ b/Documentation/filesystems/index.rst
>> @@ -50,6 +50,7 @@ filesystem implementations.
>>  .. toctree::
>>     :maxdepth: 2
>>  
>> +   buffer
> 
> This causes:
> 
> Documentation/filesystems/index.rst:50: WARNING: toctree contains reference to nonexisting document 'filesystems/buffer'

I added a simple/minimal new buffer.rst file for testing:
(needs an SPDX line)



---
 Documentation/filesystems/buffer.rst |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff -- /dev/null b/Documentation/filesystems/buffer.rst
--- /dev/null
+++ b/Documentation/filesystems/buffer.rst
@@ -0,0 +1,11 @@
+
+===========================
+Filesystem buffer head APIs
+===========================
+
+.. kernel-doc:: include/linux/buffer_head.h
+   :internal:
+
+.. kernel-doc:: fs/buffer.c
+   :export:
+

