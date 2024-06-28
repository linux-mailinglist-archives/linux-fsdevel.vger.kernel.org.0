Return-Path: <linux-fsdevel+bounces-22739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA6B91B82D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 09:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 817B1B2261D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 07:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C301420C9;
	Fri, 28 Jun 2024 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K7Lk1RkA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C0E1F934;
	Fri, 28 Jun 2024 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719559312; cv=none; b=Ad6BsHrnYpFuZRXLGIu/VR1LBnBpwz9eQoO5w7c7Nm+mh12vqwcn1w9RZ2TOgWGm6wsWreeR8FkRSzB8C5UL4s5XEsTliow+Ak1TQUPkHfqislUVwGlA8HuSmvPCAnnjToA8sKG4m7/NK94AbliavmuWPg+R77BOn5gzf/1pyLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719559312; c=relaxed/simple;
	bh=jstsD5F1mmwI3IOn9+JB22BT5GB52pFJXcbAWZgx4oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QuKwxhOoHwsr6jAgWk3lT/NX4tKY/k10/dw+ri7kDaNOP7UYHPg5GIgJxDG81B0ziDZSrn0dXhm1hucSgOEZWa8vWzwtQhma4pBfceTtSy2c3ngzlH57azjiz5JGzb5nLBfvNKN+TsXTP3RvTy+oU1Nhbp7uLoAqaIgH+dq2UeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K7Lk1RkA; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719559301; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AGBFJbCTt8aNt0KeD+i2UNzEgqWHOy1kpHd3ZOzb0Vs=;
	b=K7Lk1RkAWefcOcxcFo9LbVTusfdQGA3JxL++v1epjKlMMTFCEoCiAIhtI9LvhCYRrlP1reiEKvZtqvWiNPRwtJ/uolbCwKIm79qettFr2OGOwUBANJAqZXcVFFDntEYSw/77BMXK8SGOMd92EP5skSo58/zFncZr73GefrV3atk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W9PYzHJ_1719559299;
Received: from 30.97.48.160(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9PYzHJ_1719559299)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 15:21:40 +0800
Message-ID: <860fd191-eecf-4044-8057-18fca747cceb@linux.alibaba.com>
Date: Fri, 28 Jun 2024 15:21:39 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] cachefiles: cancel all requests for the object
 that is being dropped
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
Cc: jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
 wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
 <20240628062930.2467993-7-libaokun@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240628062930.2467993-7-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/28 14:29, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Because after an object is dropped, requests for that object are useless,
> cancel them to avoid causing other problems.
> 
> This prepares for the later addition of cancel_work_sync(). After the
> reopen requests is generated, cancel it to avoid cancel_work_sync()
> blocking by waiting for daemon to complete the reopen requests.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

