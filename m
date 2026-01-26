Return-Path: <linux-fsdevel+bounces-75461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H3DD0Rgd2n8eQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 13:38:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9081C885E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 13:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C414301475D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 12:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D6B3321DE;
	Mon, 26 Jan 2026 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fdzuZNgL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E320E2FBDE6
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769431104; cv=none; b=TersjnIzsgOygiyQc6ji1ADEKNUXPqGf8eSNJ93KpOSejOTmM4GS+OBHqoHOws1sUtjSr639DvusotVo6I60HKKzv7UrizdXocqHtGmV7TQ0wFeWOYrs+mkmxfwD3Mjg0c/hUA7f4VJVbOdlAJYFPttIng4Kf5pOdAKJAfJpAp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769431104; c=relaxed/simple;
	bh=0d/Cu/2q7wc3QylH0INDXyNloVdb9TSszzfwPWxIxWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cvxoy3XqGxFhRhIYzifjxfoLLh9O3whwRQs3qQ/wVbaP9R/Y4Xqv5ixVLQsY0bjZq7MGmB83ck9gU/zymyzWzrDtl0VL6NJVXSluydntF/8OnRo8m0NaURsGEXJrs+oOpQU77K6J0hGqCWGLIKFrLWp9DTsV/YrostH20QoYkvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fdzuZNgL; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769431099; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nuNm2lD0FJP33nhDfi9FOji04jm+bT/z4Fy5gPDzEIc=;
	b=fdzuZNgL1Ur9w1YZLadJv6evFZYV/yqlxAcuu+rIdfthy13yGexaoe7iHgdWiA94ko0kQT8H55GxcIv3u/ChfZP9hf+8FRd1kep3rWPUYyq99SWnVa9QIo/H4DIsejNqU+MFP+6X/lk/F8O9wqJfOsX3EEBoVTOTvMMSKdVFXF0=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxuSo4c_1769431098 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 26 Jan 2026 20:38:19 +0800
Message-ID: <2e960c83-ff29-4d78-927f-64c5cd84d87d@linux.alibaba.com>
Date: Mon, 26 Jan 2026 20:38:18 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260126120020.675179-2-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75461-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,intel.com:email,alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 9081C885E0
X-Rspamd-Action: no action



On 2026/1/26 20:00, Hongbo Li wrote:
> The kernel test rebot reports the kernel-doc warning:
> 
> ```
> Warning: fs/iomap/buffered-io.c:624 function parameter 'private'
>   not described in 'iomap_readahead'
> ```
> 
> The former commit in "iomap: stash iomap read ctx in the private
> field of iomap_iter" has added a new parameter @private to
> iomap_readahead(), so let's describe the parameter.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202601261111.vIL9rhgD-lkp@intel.com/
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

btw, I don't think the cover letter is needed for
this single patch.

Thanks,
Gao Xiang

