Return-Path: <linux-fsdevel+bounces-75464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CSlE+1ld2nCfQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 14:02:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BDA888C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 14:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF9B1301FA43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 13:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6376F334681;
	Mon, 26 Jan 2026 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KKRZxHQK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962A533343E
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432496; cv=none; b=TiNpVXRl6kDBxgHCuXfg9A7mXhhEEMjzYs+WB76X/JITBZoju8A2VZIpO2EpbdhKmrXnGuVFd5OEXOozvHz4J6q7vzDc5+tFHEnUEwK/qZXnnnzpT6iRkPcm4/kIQdrf9yWJi8qCB/t9SrS6j1dF6Ziz/20e7rBKwBt1rpfM0hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432496; c=relaxed/simple;
	bh=2qHYm78OnNAR28jmTL9Bj+Ex1VJK0Ac3TsNK0Em1Zfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fe3NQ6S/Ho5IPtUwVkZc4YXxZtgxC1jN9XV4OXH5IgnkHB2V8tWnhK6eyJew7513GwbWW1k+MmIgKbxaefGwuDXGla1C3qg5qhryjPPCJ33Wr+QQEDXjYkiVmg0gU9CHPF1aPZM1VAYkPWqizm9VQs0s/lyKFvEmCumfrdF2nLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KKRZxHQK; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dasSP2u3xvClmLE5TscgEovdmrbp5k6kku2clZwPnuA=;
	b=KKRZxHQKWat4nyx1wyADf/+S8BNhKQ0Bb9zQsv04l1hJD7stjNlPj+ATl48VCMi3hU2SB/QWW
	vMR33ZmxIZLeng+ZjvHUk20HXMsf0eBdUe9ns+Y2dco4cdbyIP9Q5Onu+0TfdyLfS3DfaB8C3vV
	BXp+u6lYMpRRgJRBNRUk8Hg=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4f07qt42BxzRhqk;
	Mon, 26 Jan 2026 20:58:02 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D67D40567;
	Mon, 26 Jan 2026 21:01:29 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 Jan 2026 21:01:29 +0800
Message-ID: <de894823-29d7-490c-a3fc-f36c7bc27f3c@huawei.com>
Date: Mon, 26 Jan 2026 21:01:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fs/iomap: Describle @private in iomap_readahead()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <brauner@kernel.org>,
	<djwong@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>
References: <20260126120020.675179-1-lihongbo22@huawei.com>
 <20260126120020.675179-2-lihongbo22@huawei.com>
 <2e960c83-ff29-4d78-927f-64c5cd84d87d@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <2e960c83-ff29-4d78-927f-64c5cd84d87d@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75464-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,huawei.com:mid,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 91BDA888C3
X-Rspamd-Action: no action



On 2026/1/26 20:38, Gao Xiang wrote:
> 
> 
> On 2026/1/26 20:00, Hongbo Li wrote:
>> The kernel test rebot reports the kernel-doc warning:
>>
>> ```
>> Warning: fs/iomap/buffered-io.c:624 function parameter 'private'
>>   not described in 'iomap_readahead'
>> ```
>>
>> The former commit in "iomap: stash iomap read ctx in the private
>> field of iomap_iter" has added a new parameter @private to
>> iomap_readahead(), so let's describe the parameter.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: 
>> https://lore.kernel.org/oe-kbuild-all/202601261111.vIL9rhgD-lkp@intel.com/
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> btw, I don't think the cover letter is needed for
> this single patch.

Thank you!

I would like to use this to indicate that this is a patch based on the 
vfs-iomap branch. Maybe another way might be possible to place this 
information in the hidden area after the SOB.

Thanks,
Hongbo

> 
> Thanks,
> Gao Xiang

