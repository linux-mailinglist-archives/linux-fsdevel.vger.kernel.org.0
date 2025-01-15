Return-Path: <linux-fsdevel+bounces-39290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 965FFA1247E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 14:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3641671BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 13:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DDC2416B4;
	Wed, 15 Jan 2025 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="ThGHAjeZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0FD2459A8;
	Wed, 15 Jan 2025 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736946804; cv=none; b=cZ+lPvCIPsRb/Mw5Q2oHsAewOVwt/b6keRRCSGyNQBDpzSWAFbGMQ9Ft7ZVL1o/V/JTgeVWYM62tNFuIbc8bruKs0ljw9tfiDxo2ZTSHUJbL907Xkp17ZVI59hAro2fVmLXGViuwYaVFE078q2XlMf+rGT/deQIaAoBQk3iY2cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736946804; c=relaxed/simple;
	bh=ITMq/WFn+XXw/gmRSnpcR1okxP3am/IRL0bBQEpXKxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RAKEhp0lhyn6glYxhvIeUiQ08HdRx/YR7xnofd4fpuZSeAbbC40g7tPYs/kLkG3Ee/8lBSIeewiChbaZlck/oqotRo4WSPStYTAqSV5iAvglpVTkClbE0+xuw2bz7DQlRKGynKjy8hmYaRrLKS8NJ6yooluHHJpH1NxPIqvC1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=ThGHAjeZ; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id E140E2000F;
	Wed, 15 Jan 2025 13:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1736946793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oi1+f9JJ1Q/PrcOFWJNIFlSVEAkDNgeD327FuM3wz5c=;
	b=ThGHAjeZpVJojhgp5X1TSwJCAdVf2FoOkye8n5MEZcmpaYi8jl/DHhiGOzuIdVZ/UGSZQN
	unftFUchZfpAxTLQxiHMKLjB5UMAD43tqyWp+79Y/hy9ECC1SmkgWWehHYeuzYGLBvw/Df
	svIvAd5BsbbTxJVcVRDFK0/RSgZDCZjeWaIZ6eddLtTxmhKwjR2NynmuvFuGIZKN6cqmeg
	nrXpzZr0GeQjWGi+wEVGl2WlMJ44gVvM2ZCyXjHPjsuD5KhVVkQMmsxfhhzNB0bVuhsqzo
	XaJLo+hK9zYGR14hCzurGl2K0+OvQjkf1EwgnAYUVkoIG5nQ17vQCDJ7Ch7mnQ==
Message-ID: <da2b6a5c-72d6-4e65-a5ad-2cb27fedec29@clip-os.org>
Date: Wed, 15 Jan 2025 14:13:10 +0100
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
 <2d5447b7-c185-4ce9-852e-b56a28b0306a@clip-os.org>
 <lfdhvbnqhzrnu4efozlr3qydmrzbykvya3cb4lfpkdyacfkvac@j7eij7pvqhlu>
Content-Language: en-US
From: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
In-Reply-To: <lfdhvbnqhzrnu4efozlr3qydmrzbykvya3cb4lfpkdyacfkvac@j7eij7pvqhlu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: nicolas.bouchinet@clip-os.org


On 12/18/24 14:21, Joel Granados wrote:
> On Tue, Dec 10, 2024 at 03:58:41PM +0100, Nicolas Bouchinet wrote:
>> Hi Joel,
>>
>>
>> Thank's for your reply.
>>
>> I apologize for the reply delay, I wasn't available late weeks.
>>
>> On 11/20/24 1:53 PM, Joel Granados wrote:
>>> On Thu, Nov 14, 2024 at 05:25:51PM +0100, nicolas.bouchinet@clip-os.org wrote:
>>>> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>>>>
>>>> Commit 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in
>>>> vm_table") fixes underflow value setting risk in vm_table but misses
>>>> vdso_enabled sysctl.
>>>>
>>>> vdso_enabled sysctl is initialized with .extra1 value as SYSCTL_ZERO to
>>>> avoid negative value writes but the proc_handler is proc_dointvec and not
>>>> proc_dointvec_minmax and thus do not uses .extra1 and .extra2.
>>>>
>>>> The following command thus works :
>>>>
>>>> `# echo -1 > /proc/sys/vm/vdso_enabled`
>>> It would be interesting to know what happens when you do a
>>> # echo (INT_MAX + 1) > /proc/sys/vm/vdso_enabled
>> Great question, I'll check that.
>>
>>> This is the reasons why I'm interested in such a test:
>>>
>>> 1. Both proc_dointvec and proc_dointvec_minmax (calls proc_dointvec) have a
>>>      overflow check where they will return -EINVAL if what is given by the user is
>>>      greater than (unsiged long)INT_MAX; this will evaluate can evaluate to true
>>>      or false depending on the architecture where we are running.
>> Indeed, I'll run tests to avouch behaviors of proc handlers bound checks
>> with
>> different architectures.
>>
>>> 2. I noticed that vdso_enabled is an unsigned long. And so the expectation is
>>>      that the range is 0 to ULONG_MAX, which in some cases (depending on the arch)
>>>      would not be the case.
>> Yep, it is. As I've tried to explain in the cover letter
>> (https://lore.kernel.org/all/20241112131357.49582-1-nicolas.bouchinet@clip-os.org/),
>> there are numerous places where sysctl data type differs from the proc
>> handler
>> return type.
>>
>> AFAIK, for proc_dointvec there is more than 10 different sysctl where it
>> happens. The three I've patched represents three common mistakes using
>> proc_handlers.
> It would be useful to analyze the others. Do you have more outstanding
> patches for these?

I've started to analyze them more in depth it this monday, will send a 
patchset when
it seems ok.
I'm focusing on proc_dointvec for now.

>
>>> So my question is: What is the expected range for this value? Because you might
>>> not be getting the whole range in the cases where int is 32 bit and long is 64
>>> bit.
>>>
>>>> This patch properly sets the proc_handler to proc_dointvec_minmax.
>>>>
>>>> Fixes: 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
>>>> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>>>> ---
>>>>    kernel/sysctl.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>>>> index 79e6cb1d5c48f..37b1c1a760985 100644
>>>> --- a/kernel/sysctl.c
>>>> +++ b/kernel/sysctl.c
>>>> @@ -2194,7 +2194,7 @@ static struct ctl_table vm_table[] = {
>>>>    		.maxlen		= sizeof(vdso_enabled),
>>>>    #endif
>>>>    		.mode		= 0644,
>>>> -		.proc_handler	= proc_dointvec,
>>>> +		.proc_handler	= proc_dointvec_minmax,
>>>>    		.extra1		= SYSCTL_ZERO,
>>> Any reason why extra2 is not defined. I know that it was not defined before, but
>>> this does not mean that it will not have an upper limit. The way that I read the
>>> situation is that this will be bounded by the overflow check done in
>>> proc_dointvec and will have an upper limit of INT_MAX.
>> Yes, it is bounded by the overflow checks done in proc_dointvec, I've not
>> changed the current sysctl behavior but we should bound it between 0
>> and 1 since it seems vdso compat is not supported anymore since
>> Commit b0b49f2673f011cad ("x86, vdso: Remove compat vdso support").
> I think you have already done this in your V3
>
>> This is the behavior of vdso32_enabled exposed under the abi sysctl
>> node.
>>
>>> Please correct me if I have read the situation incorrectly.
>> You perfectly understood the problematic of it, thanks a lot for your
>> review.
>>
>> I'll reply to above questions after I've run more tests.
>>
>> I saw GKH already merged the third commit of this patchset and
>> backported it to stable branches.
>> Should I evict it from future version of this patchset ?
> Yes. You should remove what has already been merged into main
> line. thx.
>
> Best
>

