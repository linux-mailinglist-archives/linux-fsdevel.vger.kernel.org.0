Return-Path: <linux-fsdevel+bounces-75115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oP3oLYNacmkpiwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:12:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6636AE9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01A8430157EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE9F3D9F25;
	Thu, 22 Jan 2026 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qILSA5H8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171BE36EA96;
	Thu, 22 Jan 2026 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099888; cv=none; b=oxX4YFhUVE3yYGuM5YxyXrpd+qraJEMAMu3WWlVpuoZNzlvA1/JorrSgBdlmlHAe0d8CcbGach93SGQXbD94MXUUBPpoCWZilcxB1A4xiaeRgomMSYgUor5t4K+NAkxhfEhvswTyg4QpW+GKkn0EDnRjQTCT6GaOfuiZCkQD90g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099888; c=relaxed/simple;
	bh=LXf2sKX1FBNyjxOCtHZ3N3fIjLjX2w8fUDA1/PZlROs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A30hsAlUL9g4CcO4BLDMs0MYky5s+wDUajeLezwQ5giyaCQBFa+SnTRJK75hNjlIdnJ/ouAjbKJzV2a9u1X2YoVDWcl5nJNV2l3lq0BQX7oyxBPzj4MoH1dd30Unbf1n20PTgPR1pOksRhffR04ug9OpqJsoTEOmTmzS5WtzIVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qILSA5H8; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769099870; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Lwld6vAnJB2NFeizg3t/vAsO9VfqN5FwLF5cCvhERHo=;
	b=qILSA5H8zNAYVQ94dKL821X8jG6gwrWSPGW7nmiAdq7LjPVaL6/tqDWeXyeH1J24yVocMHPUThI2SSb6pLIQTKd4xJsSzbsNAEKoT9AVpz0uKvfCsdQoIpfmzcFcO8/yXG8GJbiLPTuIiDw3ELiIvpLj8qbqK3ExXh9x9R57bqI=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wxcwr5W_1769099868 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 00:37:49 +0800
Message-ID: <b8329bf7-6686-4a35-bc99-25befc350e4d@linux.alibaba.com>
Date: Fri, 23 Jan 2026 00:37:48 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 07/10] erofs: pass inode to trace_erofs_read_folio
To: Hongbo Li <lihongbo22@huawei.com>
Cc: hch@lst.de, djwong@kernel.org, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, brauner@kernel.org, chao@kernel.org
References: <20260122153406.660073-1-lihongbo22@huawei.com>
 <20260122153406.660073-8-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260122153406.660073-8-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75115-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 4B6636AE9A
X-Rspamd-Action: no action



On 2026/1/22 23:34, Hongbo Li wrote:
> The trace_erofs_read_folio accesses inode information through folio,
> but this method fails if the real inode is not associated with the
> folio(such as for the uncomping page cache sharing case). Therefore,

                 ^ in the upcoming

> we pass the real inode to it so that the inode information can be
> printed out in that case.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

