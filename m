Return-Path: <linux-fsdevel+bounces-75466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MIRMwNod2nCfQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 14:11:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8F988A0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 14:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF23230500C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 13:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307833382F9;
	Mon, 26 Jan 2026 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UB5n4L9G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF663382E3
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432889; cv=none; b=ZrKPXwwxjV2UGG4o4PxUKgKHb203b3xqlDYohm6rakxKq0/4c9uRfP2ieIrGIS9d1hoyc8cAp/KzfCGWrhtXyz1TbBS3co+CdLAJLqKqQ+NKID0vcCgMdr1XTS0b+6/7uUkCd+2FqpY1uOP1iO5ybIfmBKF7Ja3M05RPsLTJ8us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432889; c=relaxed/simple;
	bh=tebxgPVy4f7ab1EN62FAFOss0wYi00AJSZ/6lgNQ4Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TrtBDOBizVbkJMF7xtREF1RryXnsIf7sym8Y/JGR63si6e8uNlBG++/WJwChk3cyyvhWtEpeBUWT1ATSmkAq3DQQtRocSmQ+TNbtcOoqLsatIlgPhbRrejBU1EprOlyhQDB4HVJzHut0b7n3AZw4GIaXvKQRQH+7hXaA9MAFDi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UB5n4L9G; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769432884; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tvvpVC0BKDp0INxVtqI3B7SjCmEHL0XIQNX58k14Fso=;
	b=UB5n4L9GiHzzUnuU3bBEI7RT5V2FggAvMo+t4okUdUlBW1agoT9m13wmU2iQhbO2dsYFLq7/zYrdAOuhJT1dpsheaAxLd9VOXiSnqi1V/R6K50W6i/uq7fhr1AR1GpoDbZOzgY9XXR33U4DcYxuMG5JNGtldEUfIwbGvrCTpQUI=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxuvfXz_1769432883 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 26 Jan 2026 21:08:03 +0800
Message-ID: <851f8dea-f7ae-4d39-b6c4-1188542c0bda@linux.alibaba.com>
Date: Mon, 26 Jan 2026 21:08:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fs/iomap: Describle @private in iomap_readahead()
To: Hongbo Li <lihongbo22@huawei.com>, brauner@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org
References: <20260126120020.675179-1-lihongbo22@huawei.com>
 <20260126120020.675179-2-lihongbo22@huawei.com>
 <2e960c83-ff29-4d78-927f-64c5cd84d87d@linux.alibaba.com>
 <de894823-29d7-490c-a3fc-f36c7bc27f3c@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <de894823-29d7-490c-a3fc-f36c7bc27f3c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75466-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,alibaba.com:email]
X-Rspamd-Queue-Id: 2D8F988A0E
X-Rspamd-Action: no action



On 2026/1/26 21:01, Hongbo Li wrote:
> 
> 
> On 2026/1/26 20:38, Gao Xiang wrote:
>>
>>
>> On 2026/1/26 20:00, Hongbo Li wrote:
>>> The kernel test rebot reports the kernel-doc warning:
>>>
>>> ```
>>> Warning: fs/iomap/buffered-io.c:624 function parameter 'private'
>>>   not described in 'iomap_readahead'
>>> ```
>>>
>>> The former commit in "iomap: stash iomap read ctx in the private
>>> field of iomap_iter" has added a new parameter @private to
>>> iomap_readahead(), so let's describe the parameter.
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202601261111.vIL9rhgD-lkp@intel.com/
>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>
>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>
>> btw, I don't think the cover letter is needed for
>> this single patch.
> 
> Thank you!
> 
> I would like to use this to indicate that this is a patch based on the vfs-iomap branch. Maybe another way might be possible to place this information in the hidden area after the SOB.

The best practice for a single patch is to drop those comments
after the first `---` line.

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo
> 
>>
>> Thanks,
>> Gao Xiang


