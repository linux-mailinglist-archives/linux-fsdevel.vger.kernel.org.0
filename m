Return-Path: <linux-fsdevel+bounces-75844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OLTMsQme2nXBgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 10:22:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DF8AE158
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 10:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9271C300343E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 09:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E496F37BE9A;
	Thu, 29 Jan 2026 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MAmopZT9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048EA37BE71
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678527; cv=none; b=YAg4gUNLP2+OfVHdrNc9QMtH+Tm+PCtjFmSPKDg5Na5h5x2g6eIhNhHa2H+fGwzRot5b1K92m4SJqhj4EmT4fKo0AeWdmUDVay4K6uL/dBtpo8g7OQO9rEIjMudaZf0ZgO0D73r+M3e6xfk5a7X+tXzn1g1RBBKeXBAlP0oQcSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678527; c=relaxed/simple;
	bh=t/kbRXCBwYgVNjvjwowHSWRsY+nKJNPEbjD9l/i+ONw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqhCdjYve8710ei8tJvU9sHBy2Dc4kED25O7WutA4itBPewSmVH4J2+AULKbbzhdAFdZxHXWUGDjV8nIob47i5Y62ydMdMY7zBAFO+SeQ8Sv1cRlvOJXZZuKipMwvsTOs8bNuxswDbZNmrzOO4bOGHgoVggSOjUdpCFBqfmECHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MAmopZT9; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769678516; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dvYhqz/D1UEmV1UCtNYMkzkgB8fONkP/7WnRfF0jNcI=;
	b=MAmopZT9f/BoZp7oHJM4TX7KQea1HD0XQlTsjUumX+6bgU7c+1hfEWkVePniJ6ADLdqk41qA0DpjFMpDBWzKGf99DAcE5WwHqolrxoxCbl5/3Lb1AIQO8noR4FZhLoQfPZDPAUXDIlI9ruixYdfxlhD5zvtp4YQ4CRlauUdcsrw=
Received: from 30.221.130.123(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wy6wbrK_1769678515 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Jan 2026 17:21:55 +0800
Message-ID: <4dd236c2-2ada-4d2b-a565-5c94904dcc23@linux.alibaba.com>
Date: Thu, 29 Jan 2026 17:21:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fs/iomap: Describle @private in iomap_readahead()
To: brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, Hongbo Li <lihongbo22@huawei.com>,
 "Darrick J. Wong" <djwong@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-75844-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 36DF8AE158
X-Rspamd-Action: no action

Hi Christian,

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

Could you apply this single patch kernel-doc fix directly?

Thanks,
Gao Xiang

