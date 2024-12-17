Return-Path: <linux-fsdevel+bounces-37634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3819F4CF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 14:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32CA7169E75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCC61F4737;
	Tue, 17 Dec 2024 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="cEnRonsj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACF7250F8;
	Tue, 17 Dec 2024 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443884; cv=none; b=e7mx6eAAOoZEzMJPFrmdoKyKo+MiyItz1OidQB3W1czKF8i90qiadubs33ammvzrMyP4A5cO6vvVjZo+s67mNqH97FxR7GGTPFVJWBGGgRMsXQy766jHLFnLi65bTIXz/x3nkqHCStwChEcmbad0byMczRhts+rFYPe9R7Q6whQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443884; c=relaxed/simple;
	bh=XbnnnWB54GCHPVqI50/h5Bxg1+5Ht10BYosJiA+usYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIHxDN8U8evNDra7teM7ShX5Cfy+vjtNlLoIgZxqCjDQAfyqEMPBRpJZ/S520p9pNrnqrbhfE9zilDgFOrVJUaP9S87God6ylhzcS49PHbiGo/HSou2hxNb8clFs4nJoEWbcvEP0BZ3vBUQjGm2l6eGd30INQE5TchwKD1VErbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=cEnRonsj; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id D4010E0005;
	Tue, 17 Dec 2024 13:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1734443873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vp5TDYPPENmQRE2Bn8G4VOZmWwgzqXmCeODjRqgYJLk=;
	b=cEnRonsj590KJHJuSz5a7nsF9hE3Dxo//7kIS6BvoFo/1y3I3qGYiTmfIvGt7mNn2JVK3v
	RiEmQSD650bx+SbfZqmcPJwzI8IcNDnqESMkNtFkc7E6CaB10lIBvKv7Ev/aYby12nr8az
	1fbdIwFst09FjKh0Z8yIklaJcFGzlsNKUgVrsCbb1vQmx2bShIVdUMKT3V3u8bEDXn2z2Q
	wxly6oQ476Qqn1GztpxynJ272bD5NsD++LZ9GdienqDOVruNSk9xA4q1M4ldtbMFZc8WjN
	UwbQB1/dbFs51URerIN+w3N8ONr6GdTwr+wzNCP+8vJ9R50LgIjUoX37icHQQA==
Message-ID: <c3e800d2-0aff-478e-906a-18f8fc6d756a@clip-os.org>
Date: Tue, 17 Dec 2024 14:57:51 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] sysctl: Fix underflow value setting risk in
 vm_table
To: Joel Granados <joel.granados@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
 Joel Granados <j.granados@samsung.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Neil Horman <nhorman@tuxdriver.com>, Lin Feng <linf@wangsu.com>,
 Theodore Ts'o <tytso@mit.edu>
References: <20241114162638.57392-1-nicolas.bouchinet@clip-os.org>
 <20241114162638.57392-3-nicolas.bouchinet@clip-os.org>
 <4ietaibtqwl4xfqluvy6ua6cr3nkymmyzzmoo3a62lf65wtltq@s6imawclrht6>
Content-Language: en-US
From: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
In-Reply-To: <4ietaibtqwl4xfqluvy6ua6cr3nkymmyzzmoo3a62lf65wtltq@s6imawclrht6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: nicolas.bouchinet@clip-os.org

Hi Joel,

I've pushed patchset version 3 :
https://lore.kernel.org/all/20241217132908.38096-1-nicolas.bouchinet@clip-os.org/.

On 11/20/24 13:53, Joel Granados wrote:
> On Thu, Nov 14, 2024 at 05:25:51PM +0100, nicolas.bouchinet@clip-os.org wrote:
>> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>>
>> Commit 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in
>> vm_table") fixes underflow value setting risk in vm_table but misses
>> vdso_enabled sysctl.
>>
>> vdso_enabled sysctl is initialized with .extra1 value as SYSCTL_ZERO to
>> avoid negative value writes but the proc_handler is proc_dointvec and not
>> proc_dointvec_minmax and thus do not uses .extra1 and .extra2.
>>
>> The following command thus works :
>>
>> `# echo -1 > /proc/sys/vm/vdso_enabled`
> It would be interesting to know what happens when you do a
> # echo (INT_MAX + 1) > /proc/sys/vm/vdso_enabled
>
> This is the reasons why I'm interested in such a test:
>
> 1. Both proc_dointvec and proc_dointvec_minmax (calls proc_dointvec) have a
>     overflow check where they will return -EINVAL if what is given by the user is
>     greater than (unsiged long)INT_MAX; this will evaluate can evaluate to true
>     or false depending on the architecture where we are running.
>
> 2. I noticed that vdso_enabled is an unsigned long. And so the expectation is
>     that the range is 0 to ULONG_MAX, which in some cases (depending on the arch)
>     would not be the case.
 From my observations, vdso_enabled is a unsigned int. If one wants to
convert to an unsigned long, proc_doulongvec_minmax should be used
instead.

IMHO, the main issues are that .data variable type can differ from the 
return
type of .proc_handler function. This can lead to undefined behaviors and
eventually vulnerabilities.

.extra1 and .extra2 can also be used with proc_handlers that do not uses 
them.
I think sysctl_check_table() could be enhanced to control this behavior.

>
> So my question is: What is the expected range for this value? Because you might
> not be getting the whole range in the cases where int is 32 bit and long is 64
> bit.
If proc_dointvec or its derivative is used, as you said, range is bounded
by checks in do_proc_dointvec_conv ((unsigned long) INT_MAX).

INT_MAX being based on the max value of an int (((int)(~0U >> 1))),
do_proc_dointvec_conv behavior is thus architecture dependent.
>
>> This patch properly sets the proc_handler to proc_dointvec_minmax.
>>
>> Fixes: 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
>> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>> ---
>>   kernel/sysctl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 79e6cb1d5c48f..37b1c1a760985 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -2194,7 +2194,7 @@ static struct ctl_table vm_table[] = {
>>   		.maxlen		= sizeof(vdso_enabled),
>>   #endif
>>   		.mode		= 0644,
>> -		.proc_handler	= proc_dointvec,
>> +		.proc_handler	= proc_dointvec_minmax,
>>   		.extra1		= SYSCTL_ZERO,
> Any reason why extra2 is not defined. I know that it was not defined before, but
> this does not mean that it will not have an upper limit. The way that I read the
> situation is that this will be bounded by the overflow check done in
> proc_dointvec and will have an upper limit of INT_MAX.

I've added an extra2 parameter to restrict vdso_enabled between 0 and 1 
in patchset v3.
https://lore.kernel.org/all/20241217132908.38096-3-nicolas.bouchinet@clip-os.org/

>
> Please correct me if I have read the situation incorrectly.
>
> Best
>
Thanks again for your review,

Best regards,

Nicolas

