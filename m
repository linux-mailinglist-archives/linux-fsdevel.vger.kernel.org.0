Return-Path: <linux-fsdevel+bounces-48439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8A3AAF1AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 05:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4A31890890
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 03:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924CC1FCFDB;
	Thu,  8 May 2025 03:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DW1mx9dD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35C91FC0ED
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746675003; cv=none; b=bJUeVV80KkiyGJbLknK+ACD2jRkBqwG2IO0S3EkfPYMZuDxim1J3LqdrYaqwAxeYu8fIvQEyhnBogxwvGZEh5AEVFeYBclRHM7S0FjMltL0c06yJTX+q26cJpLgqys0X9TMAs81KaF8nYSeNUBvJu3en786kLi+BKW2jXrXHxV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746675003; c=relaxed/simple;
	bh=ureZrEOffcX97F83itECAlb3mQ56ekqgCoH3GejuvNw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bifgMHB4eM4KcV3e4TZd5GNtiVmCYKGkngWXqJqpeISDk5S1wme6c3KYreFt+QIjb93jHZnE1OQj16hh/ddRe1v2iFTrLV4L9dWXIAVWBPC1XcP5euR2aRYw89C231S/MCCNk1fXUaRSC1CQdvlm64IUmKyGmwqHZ2YzTtKfaKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DW1mx9dD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64331C4CEEB;
	Thu,  8 May 2025 03:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746675002;
	bh=ureZrEOffcX97F83itECAlb3mQ56ekqgCoH3GejuvNw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=DW1mx9dDEERMx8jKuxTKpzZCGkNnnVIxWWX9PrTrzjC679mU6Ah4kBKYlb4qo2s8Z
	 vwhFe6/XpvblnWma8D9oyQRMI6X0VbfaOs+rdddV6rV1HI1KcNF6HIk/O/46vHvTOL
	 zQKYDBba0x/quavdXq/9sunjo9RWiqchSvD903kwOVrc9roA9Q/fgZ1skHMgKuJH+7
	 /QSIyIgBErdmXwzX+e0XQhxJijXJAbSRQqJd3TaSEkEr37jv0BowsW7k5FukeZBq1t
	 wFyD4/rQqXtMh3j3QQt5FTcw946dvu0PHav4sm3PQuoK9Aen2qs2An2l1rTuNbQKZO
	 B2+y4Yb7bv+5g==
Message-ID: <9af8ef92-f219-4dcd-ac10-81d0f5a8ed06@kernel.org>
Date: Thu, 8 May 2025 11:29:59 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, lihongbo22@huawei.com
Subject: Re: [PATCH 2/7] f2fs: move the option parser into handle_mount_opt
To: Jaegeuk Kim <jaegeuk@kernel.org>, Eric Sandeen <sandeen@redhat.com>
References: <20250420154647.1233033-1-sandeen@redhat.com>
 <20250420154647.1233033-3-sandeen@redhat.com>
 <2e354373-9f00-4499-8812-bcb7f00a6dbc@kernel.org>
 <db0c33f2-9fa0-4ee7-b5c9-e055fcc4d538@redhat.com>
 <aBt2CVnq8LnrbMzn@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <aBt2CVnq8LnrbMzn@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 23:02, Jaegeuk Kim wrote:
> On 05/07, Eric Sandeen wrote:
>> On 5/7/25 6:26 AM, Chao Yu wrote:
>>> On 4/20/25 23:25, Eric Sandeen wrote:
>>>> From: Hongbo Li <lihongbo22@huawei.com>
>>>>
>>>> In handle_mount_opt, we use fs_parameter to parse each option.
>>>> However we're still using the old API to get the options string.
>>>> Using fsparams parse_options allows us to remove many of the Opt_
>>>> enums, so remove them.
>>>>
>>>> The checkpoint disable cap (or percent) involves rather complex
>>>> parsing; we retain the old match_table mechanism for this, which
>>>> handles it well.
>>>>
>>>> There are some changes about parsing options:
>>>>   1. For `active_logs`, `inline_xattr_size` and `fault_injection`,
>>>>      we use s32 type according the internal structure to record the
>>>>      option's value.
>>>
>>> We'd better to use u32 type for these options, as they should never
>>> be negative.
>>>
>>> Can you please update based on below patch?
>>>
>>> https://lore.kernel.org/linux-f2fs-devel/20250507112425.939246-1-chao@kernel.org
>>
>> Hi Chao - I agree that that patch makes sense, but maybe there is a timing
>> issue now? At the moment, there is a mix of signed and unsigned handling
>> for these options. I agree that the conversion series probably should have
>> left the parsing type as unsigned, but it was a mix internally, so it was
>> difficult to know for sure.
>>
>> For your patch above, if it is to stand alone or be merged first, it 
>> should probably also change the current parsing to match_uint. (this would
>> also make it backportable to -stable kernels, if you want to).
>>
>> Otherwise, I would suggest that if it is merged after the mount API series,
>> then your patch to clean up internal types could fix the (new mount API)
>> parsing from %s to %u at the same time?
> 
> Yeah, agreed we'd better applying the type change later, once mount API is
> successfully landed. Chao, let's keep checking any missing cases. :)

Sure, let me check left patches today. :)

Thanks,

> 
>>
>> Happy to do it either way but your patch should probably be internally
>> consistent, changing the parsing types at the same time.
>>
>> (I suppose we could incorporate your patch into the mount API series too,
>> though it'd be a little strange to have a minor bugfix like this buried
>> in the series.)
>>
>> Thanks,
>> -Eric


