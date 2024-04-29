Return-Path: <linux-fsdevel+bounces-18036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B018B4FA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 05:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3061F217E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 03:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41888BEE;
	Mon, 29 Apr 2024 03:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JGvtSPpt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D67C79F5;
	Mon, 29 Apr 2024 03:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714359688; cv=none; b=LPfPp+UBybNU/PpeHamSQRQpdk4pQiU5V4OuoCpYn1Yjjd3iN0/VD0qNkqBFiQUH4q1Esez0Oz5v4u3FIPgfGdL6TzRY9Dc8zKgHS8aYPjlpvUT4EPQ8EGMr76LW3bKzA8St4LNFGVQBU0vP6OKuGOQZEzoRmLBseYUUKlp/W9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714359688; c=relaxed/simple;
	bh=Om4I/ddcBKtjXeCB4O0CkCyrpfy1KC0wRd40jXB89Nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/2QiyyKypcIzA00eQkQ0lwOIqtClASYcV15QkijR9SXfqgDYDONZIMGbLIJTqdkVMtJ5NRJVwx4Q7KU3uvUtosKMqGwiXnLYgezyvsQ95gToPzX0mRVe9DYMa94GoaoXR0uDWmK5wf9q5rzLmNaBmYI77ZQehWMdol6O8IDBHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JGvtSPpt; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714359676; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0cGVc4X7wtyvX65FX7xrT2nImMns/KBN1rZueOkcsYk=;
	b=JGvtSPpt1dk0FTDPUsvLgFq6B2WX7I+3Bg7IBBhJG9AH1uLHJFVxXhIdtnCYeR746kJPqs6RhY3KqcPfmYdCbxU7t0hIU3Nhha2WEEQLZQSz96x9lhjaNZFIjogCSRQ1PAvpAdsDjEdEFjU4ehtmXXbKawgeQ7FY+uYxsJ2rap4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W5PX2HT_1714359673;
Received: from 30.221.131.66(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5PX2HT_1714359673)
          by smtp.aliyun-inc.com;
          Mon, 29 Apr 2024 11:01:15 +0800
Message-ID: <bac49702-e90a-4700-ad1a-94c992a84c31@linux.alibaba.com>
Date: Mon, 29 Apr 2024 11:01:12 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] erofs: switch erofs_bread() to passing offset instead
 of block number
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
 brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 yukuai3@huawei.com
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-9-yukuai1@huaweicloud.com>
 <20240407040531.GA1791215@ZenIV>
 <a660a238-2b7e-423f-b5aa-6f5777259f4d@linux.alibaba.com>
 <20240425195641.GJ2118490@ZenIV> <20240425195749.GA1031757@ZenIV>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240425195749.GA1031757@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/26 03:57, Al Viro wrote:
> Callers are happier that way, especially since we no longer need to
> play with splitting offset into block number and offset within block,
> passing the former to erofs_bread(), then adding the latter...
> 
> erofs_bread() always reads entire pages, anyway.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

