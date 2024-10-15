Return-Path: <linux-fsdevel+bounces-31992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF3B99EE12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044E62880C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C301DD0CE;
	Tue, 15 Oct 2024 13:40:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F414A1C07CC;
	Tue, 15 Oct 2024 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999642; cv=none; b=GV7j6OJoXKJR4TxP0nC7Hzd8Eno3Lx4eJRSmPDv4vgUY8eJJdF5XAOOp4ievQ6yqqZq72hgGg7VQKZ9EkGtlJSEecKb6nLpFTuGxL6OTE3Sesde41EuuoLbL3HPZ2LEWu6NZ1jSUOFg9aWkY38+EBzR/eIOmzfPwV427uDUIKW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999642; c=relaxed/simple;
	bh=BzYWAhoI0axCue+kv6wY0di0ivbwBcXcR4ZVqGGktH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQBGnqEioRNj1p+eMYpQYahuoRX+aNiVd1LBo4Iz3u7yaWvgvd1UrxegkmGsqq5b2RDxBYL3uFNUf0pKexgg1+VEN4MLMfmwOw21DZiHRN6vQAyhmNN7iSLqDvtV0Lw1Dd1MdwzHRyLcHAi0AbZhh4Ux6i11NzdUVlnj+DfvOl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrAB3fc3DcA5n9f4QAQ--.8912S2;
	Tue, 15 Oct 2024 21:40:19 +0800 (CST)
Received: from [10.12.164.29] (unknown [10.12.164.29])
	by gateway (Coremail) with SMTP id _____wAHckLBcA5nX5dIAA--.51398S2;
	Tue, 15 Oct 2024 21:40:18 +0800 (CST)
Message-ID: <769f0267-f09d-46e8-854f-52f6c65996f8@hust.edu.cn>
Date: Tue, 15 Oct 2024 21:40:17 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: fix a reference of a removed file
To: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>,
 Jeff Layton <jlayton@kernel.org>
Cc: hust-os-kernel-patches@googlegroups.com, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241015092356.1526387-1-dzm91@hust.edu.cn>
 <87jze9qyha.fsf@trenco.lwn.net>
Content-Language: en-US
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <87jze9qyha.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:HwEQrAB3fc3DcA5n9f4QAQ--.8912S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWDJF48tw48ur43Zr1xAFb_yoWDJFb_JF
	97AFs3ZryDArs7AF18KFn8WF13A3WxCry8Xw1fAws3ta4UJ395CF93J3sYyr43Wrs29rn5
	JFWkZr9xXFy2gjkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbPAYjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26F
	4j6r4UJwAv7VCjz48v1sIEY20_GFW3Jr1UJwAv7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82
	IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1ec_3UUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 10/15/24 21:36, Jonathan Corbet wrote:
> Dongliang Mu <dzm91@hust.edu.cn> writes:
>
>> Since 86b374d061ee ("netfs: Remove fs/netfs/io.c") removed
>> fs/netfs/io.c, we need to delete its reference in the documentation.
>>
>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>> ---
>>   Documentation/filesystems/netfs_library.rst | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
>> index f0d2cb257bb8..73f0bfd7e903 100644
>> --- a/Documentation/filesystems/netfs_library.rst
>> +++ b/Documentation/filesystems/netfs_library.rst
>> @@ -592,4 +592,3 @@ API Function Reference
>>   
>>   .. kernel-doc:: include/linux/netfs.h
>>   .. kernel-doc:: fs/netfs/buffered_read.c
>> -.. kernel-doc:: fs/netfs/io.c
> Already fixed by 368196e50194 in linux-next.

Okay, I see. Thanks for the reminder.

Dongliang Mu

>
> Thanks,
>
> jon


