Return-Path: <linux-fsdevel+bounces-26325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7884695787A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 01:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1581C231D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 23:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F141DF692;
	Mon, 19 Aug 2024 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttEImnKv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A0015AAB8;
	Mon, 19 Aug 2024 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724109013; cv=none; b=J1Mq/753gUPc3gW5W4OkRPby/RJdY7iuIKgr37LuWNvVyCulYM05BzfDDpkHdvaLsmNbP48Djp05s7m7GrhF08GUO4T9E2TyLlARLX+zvsjm8cQAW5xx2keEHZRIuQExOfcPZf31E+N9BC+oIAlhko84ZjWRLBR0tKTqHotVVV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724109013; c=relaxed/simple;
	bh=P3IWjyVw+dmvFGebvgiBPrMkNvrsw3RRcVQ/6vhfHHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eIVeVD5j4QsZdNpaWjn0LA1aYSKEg95p2UweuAavuLSx5HYRxBQzo1BAKDOc69mmiMlrj6Bmk92XyXU971yyLKNdSdS69HXTnUYtk0SFn6cPcYUU3QX4deWljmFpSXCVs70OTdsFEt4kXVIMB22mY9lsxqxssFng0kAa+t7aCFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttEImnKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57328C32782;
	Mon, 19 Aug 2024 23:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724109013;
	bh=P3IWjyVw+dmvFGebvgiBPrMkNvrsw3RRcVQ/6vhfHHo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ttEImnKv6atPpRRokQlOJi7Y8eqMPJuc6X5sEBrZHFa+mD1t33MYGJkPrLu9nK4vM
	 pmrfkcRV9qvk77XxQ/wnTDa/WrFYaJyWePEXSOoj/cCBtA2OHni3oinih0PbbJnXJn
	 2lp8B/7cxhhTdfAd6OrvI9yGkt+CoLskvYLkwuXBU/Kx+KSoApcRkIs4NuXP8Z8jMR
	 ja0Z7USDvn+EENoDP6TQfqwxOlwVEkTxqezKE+b2MJpgHWW0pH/ldq5/DeoBp9VKBH
	 007vGUWfn1Jkm9Ob+3Hs1jEKffSPMrJ006QhsOVAoO+Ol0Y293Ji/jdp64TZGkco4N
	 796Id5pAwb1mw==
Message-ID: <a6851224-e897-476e-8225-3048d6330c1c@kernel.org>
Date: Tue, 20 Aug 2024 08:10:11 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] zonefs: add support for FS_IOC_GETFSSYSFSPATH
To: "liaochen (A)" <liaochen4@huawei.com>, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, naohiro.aota@wdc.com, jth@kernel.org
References: <20240809013627.3546649-1-liaochen4@huawei.com>
 <9b3795de-c67c-4582-9eb1-bed096b3eb67@huawei.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <9b3795de-c67c-4582-9eb1-bed096b3eb67@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/24 21:22, liaochen (A) wrote:
> On 2024/8/9 9:36, Liao Chen wrote:
>> FS_IOC_GETFSSYSFSPATH ioctl expects sysfs sub-path of a filesystem, the
>> format can be "$FSTYP/$SYSFS_IDENTIFIER" under /sys/fs, it can helps to
>> standardizes exporting sysfs datas across filesystems.
>>
>> This patch wires up FS_IOC_GETFSSYSFSPATH for zonefs, it will output
>> "zonefs/<dev>".
>>
>> Signed-off-by: Liao Chen <liaochen4@huawei.com>
>> ---
>>   fs/zonefs/super.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
>> index faf1eb87895d..e180daa39578 100644
>> --- a/fs/zonefs/super.c
>> +++ b/fs/zonefs/super.c
>> @@ -1262,6 +1262,7 @@ static int zonefs_fill_super(struct super_block *sb, struct fs_context *fc)
>>   	sb->s_maxbytes = 0;
>>   	sb->s_op = &zonefs_sops;
>>   	sb->s_time_gran	= 1;
>> +	super_set_sysfs_name_id(sb);
>>   
>>   	/*
>>   	 * The block size is set to the device zone write granularity to ensure
> Gentle ping

I replied yesterday with a comment. Did you get that email ?

See:
https://lore.kernel.org/linux-fsdevel/55ca393e-e2e9-45ef-8eb0-050d79c92987@kernel.org/

> 
> Thanks,
> Chen

-- 
Damien Le Moal
Western Digital Research


