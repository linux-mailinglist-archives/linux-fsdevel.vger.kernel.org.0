Return-Path: <linux-fsdevel+bounces-1683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A800E7DDA64
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 01:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF6F281823
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 00:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A207E9;
	Wed,  1 Nov 2023 00:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE61A36B
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 00:52:31 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60998110
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 17:52:29 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VvIhs-h_1698799944;
Received: from 192.168.33.9(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VvIhs-h_1698799944)
          by smtp.aliyun-inc.com;
          Wed, 01 Nov 2023 08:52:26 +0800
Message-ID: <a2cfba03-ad3c-c8b6-0ac8-6801fcee6bf8@linux.alibaba.com>
Date: Wed, 1 Nov 2023 08:52:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v[n] 2/2] fuse: Introduce sysfs API for resend pending
 requests
To: =?UTF-8?B?6LW15pmo?= <winters.zc@antgroup.com>,
 linux-fsdevel@vger.kernel.org
Cc: miklos@szeredi.hu, Peng Tao <tao.peng@linux.alibaba.com>,
 Liu Bo <bo.liu@linux.alibaba.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20231031144043.68534-1-winters.zc@antgroup.com>
 <20231031144043.68534-3-winters.zc@antgroup.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231031144043.68534-3-winters.zc@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2023/10/31 22:40, 赵晨 wrote:
> From: Peng Tao <tao.peng@linux.alibaba.com>
> 
> When a FUSE daemon panics and fails over, we want to reuse the existing
> FUSE connection and avoid affecting applications as little as possible.
> During FUSE daemon failover, the FUSE processing queue requests are
> waiting forreplies from user space daemon that never come back and
> applications would stuck forever.
> 
> Besides flushing the processing queue requests like being done in
> fuse_flush_pq(), we can also resend these requests to user space daemon
> so that they can be processed properly again. Such strategy can only be
> done for idempotent requests or if the user space daemon takes good care
> to record and avoid processing duplicated non-idempotent requests,
> otherwise there can be consistency issues. We trust users to know what
> they are doing by calling writing to this interface.
> 
> Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
> Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Sorry, please don't add my internal ack for downstream kernels to
the community mailing lists.

Thanks,
Gao Xiang

