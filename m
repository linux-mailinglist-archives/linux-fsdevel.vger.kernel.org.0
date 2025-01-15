Return-Path: <linux-fsdevel+bounces-39289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7265FA1244F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 14:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6A11691A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 13:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9722066EB;
	Wed, 15 Jan 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="k8W651ZZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85EE8F6C;
	Wed, 15 Jan 2025 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736946062; cv=none; b=SO1BZlXTyvziSisrFMPo5Zr1okK82+VT5BvI6v1TM9ZQjhlohsHjuJUuQMC2QsdNdq87LEv4eJ/GUEUXROMvgdR9A6hPTbKEyMha5cevMloQRj+7iwBETCFB5rrHrAMDKWKbROoVXAN9w6lhkxv8DNOYIZk3OM/76LF1fIIGAVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736946062; c=relaxed/simple;
	bh=r3yr3clvxek0JbdwN8Bo6ptWCImAIyKhxhkMr+VfB08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJPU8kRkBQOfkYjJrE1PzzCRAJMuUnOa0o9qNzNVySpBMyKshi5KJnvCULDMtyaM2tp9moWrW1ROABNxmZcrAJaUd9kSUMgQFI5JSzHWKpLENMKMqA67COrt3xQ2mX6SdS+5+TkiYJupuu4rZKxUQptpDS9LBEgD5z9CGHsv0H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=k8W651ZZ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA78FC0003;
	Wed, 15 Jan 2025 13:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1736946057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ybkADqhlKK2kLMyL8nPka/wtq5FIEuIPFu+SqL01k/k=;
	b=k8W651ZZJgoqhENK8ngnW/rDsJeAy2HvjbNzvlfxlR8aNGIvvLDVK4OAW7QgkBESq5DTIy
	9mgewuf/vgok0UqxleIkxGehKjIcPB9huHHaY4B4lHz099WKtLLCxYEL2c9ZlFyCGA53EO
	kNZWXonmNDTqVOgPXnMBFIOibEHdBs07F9iZn5zUxYg4p+6S2TUfmGwarVXeNLv1Pu2dtg
	q2Y3ct0e8rWiohJfkyX5XvhVYtfVycKFbfSVrSOWfwW4GUyvVl3oZLQPSvfdKghai7c6b3
	tzFgrXo8NN55oINz6EmDX49Kf3w8RJBiacaUv6A/7PlQKqK13LFhp0nE+PogFQ==
Message-ID: <718a9264-f1f6-4157-9e95-2e170152eb8f@clip-os.org>
Date: Wed, 15 Jan 2025 14:00:55 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] sysctl: Fix underflow value setting risk in
 vm_table
To: Joel Granados <joel.granados@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
 Joel Granados <j.granados@samsung.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Neil Horman <nhorman@tuxdriver.com>, Lin Feng <linf@wangsu.com>,
 Theodore Ts'o <tytso@mit.edu>
References: <20241217132908.38096-1-nicolas.bouchinet@clip-os.org>
 <20241217132908.38096-3-nicolas.bouchinet@clip-os.org>
 <mdyg6vjy5hybv47ovw2uywlqzz4nq67bdntnpmtbaxj64pz5sz@5vx4rlsvu22a>
Content-Language: en-US
From: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
In-Reply-To: <mdyg6vjy5hybv47ovw2uywlqzz4nq67bdntnpmtbaxj64pz5sz@5vx4rlsvu22a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: nicolas.bouchinet@clip-os.org

Hi Joel,

Thank's for your reply.

On 1/15/25 11:27, Joel Granados wrote:
> On Tue, Dec 17, 2024 at 02:29:07PM +0100, nicolas.bouchinet@clip-os.org wrote:
>> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>>
>> Commit 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
>> fixes underflow value setting risk in vm_table but misses vdso_enabled
>> sysctl.
>>
>> vdso_enabled sysctl is initialized with .extra1 value as SYSCTL_ZERO to
>> avoid negative value writes but the proc_handler is proc_dointvec and
>> not proc_dointvec_minmax and thus do not uses .extra1 and .extra2.
>>
>> The following command thus works :
>>
>> `# echo -1 > /proc/sys/vm/vdso_enabled`
>>
>> This patch properly sets the proc_handler to proc_dointvec_minmax.
> Please also mention that you added a extra* arg.
ACK, will push soon.
>
>> Fixes: 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
>> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>> ---
>>   kernel/sysctl.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 79e6cb1d5c48f..6d8a4fceb79aa 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -2194,8 +2194,9 @@ static struct ctl_table vm_table[] = {
>>   		.maxlen		= sizeof(vdso_enabled),
>>   #endif
>>   		.mode		= 0644,
>> -		.proc_handler	= proc_dointvec,
>> +		.proc_handler	= proc_dointvec_minmax,
>>   		.extra1		= SYSCTL_ZERO,
>> +		.extra1		= SYSCTL_ONE,
> * What did you mean here?
>    1. To replace extra1 with SYSCTL_ONE?
>    2. To add extra2 as SYSCTL_ONE and you mistyped it as "extra1"?
Oh, my bad, it's indeed a mistype, extra1 should be set at SYSCTL_ZERO, 
extra2 to SYSCTL_ONE.
It seems you already corrected it in [3]. LGTM, thank's.
>
> * This patch conflicts with the vm_table moving out of the kernel
>    directory [1] from Kaixiong Yu <yukaixiong@huawei.com> (which is also
>    in sysctl-testing). I have fixed this conflict with [2], please scream
>    if you see that messed up.
>
> * Please send an updated version addressing these comments and taking
>    into account that your patches will go after [1]. You can use [3] as
>    your base if you prefer.


Thank's for the links, I'll reword the commit message on [3] since you 
already fixed the typo
and that [1] is already applied.

>
> Best
>
>
> [1] https://lore.kernel.org/20250111070751.2588654-14-yukaixiong@huawei.com
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/commit/?h=sysctl-testing&id=81b34e7966e84983a31c0150cbf2171605c023a3
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/commit/?h=sysctl-testing&id=2fc99f285719e0cce8df1fe21479cb9e6626c2fe
>

Best regards,

Nicolas


