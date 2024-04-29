Return-Path: <linux-fsdevel+bounces-18037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1AC8B4FA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 05:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B9DEB213EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 03:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAFD8C09;
	Mon, 29 Apr 2024 03:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RKgK5/0D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3868179F6;
	Mon, 29 Apr 2024 03:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714359710; cv=none; b=oPGPbnUlKKccKOfgNgWRn0E1zNBTeiHjbVnkncuu3P5kXVhP4pIxHP4afzTbATaJYmwIOvwx+r+dg0DUmLRmbI71VtPmut4W+GA58SDwsLscgv4gi9m0/3LZ/XlCoY8a3VoL1GXkxTde5pCIwUwcMZmNn2xGrWrT++qgYvKfWHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714359710; c=relaxed/simple;
	bh=vdRuPv10k5foswKA4rZK9SrDJt82M5Jps1ajawPlsYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5w1qSeo9H2PSymReI9tJ49iHtVIp2e6YlQKTXQ2rn84PYxH9FHS2/0QisgWS2U4IeCA0nIBAybjqxsiZDat6G8KbuW23PfzskaPx/vqOhneInGM9QYW0mQ7bXUlshhBCFFlOGBoKHGoLcrkep3dbYx3lzXuEEzG1e92l9+ba+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RKgK5/0D; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714359705; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hWd1NQCL/A4q9FVMRQR+Y+pkCjmxL+4NuILY0swZzgo=;
	b=RKgK5/0DVbcj8ghGk6Yk8DqfTsYB6zd3OZ19vFpVJK1Vhrw36ouRTgfMEaznmmM/rpLGs0BNoMKHhs6i2VtuQJ2evuHm/v+MPh1sNAjYvI4JMhYoNxjlvFMtEBQOmtlBo7CgkoRujPX+j1PVZO6lYA3pH5b26MI79q6XgAYGb5k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W5PX2Q-_1714359702;
Received: from 30.221.131.66(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5PX2Q-_1714359702)
          by smtp.aliyun-inc.com;
          Mon, 29 Apr 2024 11:01:44 +0800
Message-ID: <b52ef730-f229-4235-b2cd-bc5404cb9f69@linux.alibaba.com>
Date: Mon, 29 Apr 2024 11:01:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] erofs_buf: store address_space instead of inode
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
 brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 yukuai3@huawei.com
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-9-yukuai1@huaweicloud.com>
 <20240407040531.GA1791215@ZenIV>
 <a660a238-2b7e-423f-b5aa-6f5777259f4d@linux.alibaba.com>
 <20240425195641.GJ2118490@ZenIV> <20240425195820.GB1031757@ZenIV>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240425195820.GB1031757@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/26 03:58, Al Viro wrote:
> ... seeing that ->i_mapping is the only thing we want from the inode.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

