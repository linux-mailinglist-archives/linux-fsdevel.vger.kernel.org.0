Return-Path: <linux-fsdevel+bounces-71124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F816CB6370
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 15:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1F9C30424BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFF527B349;
	Thu, 11 Dec 2025 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="deVkwedF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F0D247291;
	Thu, 11 Dec 2025 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765463622; cv=none; b=Sdxsx1vYN+C1/D+8pumT18XnDTfd5f0bgj3I2ap59cuveVJXOMWJ8GmuiJmIuQ9aYKgi2Bqem3CxPTttM51tBSsPLCPUCcRTGnolQh+Y19Z2J58ZZT0j+k6t0SMxSNYdnbj8UwdU1RT35xLxDEVmBEsi6FWuIbIH9Po4q/cHses=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765463622; c=relaxed/simple;
	bh=rvDjFW4GaFo07t7gqXPYNbzL1BeM0u3yqdOTC4ap/y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p3DBwSt0TJ7SwWVTdkMKZqepVA2o3flpFYoAIxq4TOr0NJqlCARyDF5qNJu07NNlCx1S6LeiU5wWeEArTVbW690ncmb9fWOY8ALZywGEtmk9+AgUMX8o0AzrGkZ76aQDwP3Y9dRxzUdAP2k47sXbcQZkopf3ADHBWIr5C11oA30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=deVkwedF; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id BC89D1D77;
	Thu, 11 Dec 2025 14:30:07 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=deVkwedF;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id AA0E1265E;
	Thu, 11 Dec 2025 14:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1765463617;
	bh=RbA9truD+2eHkLW1DfeCZXyaRLwcOI+bgeblYyY8dw0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=deVkwedFMPK+2NFr1zW54kWO38394GkSRD6nwnJyjOis4XZhEvyVdBewTO+z6W6we
	 tHdvVqreOHO5egfkpN5/jHZCcCCqETlrx5AFEb4Wfo2Ua2KAsp6aCaTcg2nwAy6lGD
	 osrkx8uCTVD2Gq/YmsrIAVt4H+SCoD+2luMj4Vas=
Received: from [192.168.95.128] (172.30.20.154) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 11 Dec 2025 17:33:36 +0300
Message-ID: <502bfbc8-9bbe-47f7-b4a3-723f51a61700@paragon-software.com>
Date: Thu, 11 Dec 2025 15:33:33 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ntfs3: fix memory leak in ntfs_fill_super()
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <20251211135126.13965-1-almaz.alexandrovich@paragon-software.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20251211135126.13965-1-almaz.alexandrovich@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 12/11/25 14:51, Konstantin Komarov wrote:

> ntfs_fill_super() assigns fc->fs_private to a newly allocated options
> structure earlier in the mount path. At the end of a successful mount, the
> code set fc->fs_private = NULL, which prevented the vfs from freeing this
> memory during mount context cleanup. As a result, the options structure
> was leaked.
>
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>   fs/ntfs3/super.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index a641d474c782..38d82e46171a 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -1252,7 +1252,6 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>   		}
>   	}
>   	sbi->options = options;
> -	fc->fs_private = NULL;
>   	sb->s_flags |= SB_NODIRATIME;
>   	sb->s_magic = 0x7366746e; // "ntfs"
>   	sb->s_op = &ntfs_sops;

Please withdraw this patch.

I realized after sending it that an equivalent patch was already submitted
earlier by Baokun Li<libaokun1@huawei.com>. My version is redundant, so I
will drop it and proceed with reviewing/merging the earlier contribution.

Apologies for the duplication.

Regards,
Konstantin


