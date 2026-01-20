Return-Path: <linux-fsdevel+bounces-74650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PTaHv+3b2kBMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:14:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E04B3485DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E73749465BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 14:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728BE43636E;
	Tue, 20 Jan 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="L4iMTokk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B75A42DFEB;
	Tue, 20 Jan 2026 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768918285; cv=none; b=gteH6D8WtHNEI/6sc4+9w5IC3O2ksYBxftt78C/zhS0c14w0PcZLFFbJedyyHz/GaHsIOcl4GpnAnwGiYTFiqK/nTAH3Thwal/33MsA0y0Infl/rGfaYn7eE6uD6s7OplXbd314HPKj3Y3hcHSoy2AUD8JgnMgIQIa6EuTJVxS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768918285; c=relaxed/simple;
	bh=A3mcmkq1kiF93N1w5Wj6kWoL+UE6WOy8SceE10C2Z/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hETjbk941E+XN6p3bJFmnGK+Xl/cV9at08pfWel/zLXaMePt2MchhQGTcwAst5DPin9L0sOwdPlGqX7hKmBACNK7U2cskJ0TQSxV+f2VypyTZ8AIjDGhOqqKuKETENkfhlP8+ZUoELvbDCHflsboIP/p0Oy9NEIyM7JDvYjsZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=L4iMTokk; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768918272; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=23an09Q0biO5z22AKKKB/TBPcY7M6X9cJ2eW+LaU65A=;
	b=L4iMTokkPJvXYERROr6TJndXGqiGUghSIfo7QAZPDhll40aEzS9wSKocgBFYVRhsbKv06XwZIiwIvnKl6CAlx6CdMVfDJ8Lo0xeVhh316EfY0/qJMdcOXUbs8QoAbtHnzEnBBNGz6qFJ5D1Tpt1u5ID8FYcLAo4TxAv86OpUwas=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxUigVY_1768918271 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 20 Jan 2026 22:11:12 +0800
Message-ID: <1e9134c2-d984-41a3-b294-166b7e3e6bcf@linux.alibaba.com>
Date: Tue, 20 Jan 2026 22:11:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
To: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, djwong@kernel.org,
 amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, oliver.yang@linux.alibaba.com
References: <20260116154623.GC21174@lst.de>
 <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com>
 <20260119072932.GB2562@lst.de>
 <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
 <20260119083251.GA5257@lst.de>
 <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com>
 <20260119092220.GA9140@lst.de>
 <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com>
 <50db56b8-4cf9-4d62-b242-c982a260a330@linux.alibaba.com>
 <20260120065242.GA3436@lst.de>
 <20260120-neuland-rastplatz-31cc7d61a196@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260120-neuland-rastplatz-31cc7d61a196@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-8.96 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[huawei.com,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org,linux-foundation.org,linux.alibaba.com];
	TAGGED_FROM(0.00)[bounces-74650-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.alibaba.com,none];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: E04B3485DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Christian,

On 2026/1/20 21:40, Christian Brauner wrote:
> On Tue, Jan 20, 2026 at 07:52:42AM +0100, Christoph Hellwig wrote:
>> On Tue, Jan 20, 2026 at 11:07:48AM +0800, Gao Xiang wrote:
>>>
>>> Hi Christoph,
>>>
>>> Sorry I didn't phrase things clearly earlier, but I'd still
>>> like to explain the whole idea, as this feature is clearly
>>> useful for containerization. I hope we can reach agreement
>>> on the page cache sharing feature: Christian agreed on this
>>> feature (and I hope still):
>>>
>>> https://lore.kernel.org/linux-fsdevel/20260112-begreifbar-hasten-da396ac2759b@brauner
>>
>> He has to ultimatively decide.  I do have an uneasy feeling about this.
>> It's not super informed as I can keep up, and I'm not the one in charge,
>> but I hope it is helpful to share my perspective.
> 
> It always is helpful, Christoph! I appreciate your input.

Thanks, I will raise some extra comments for Hongbo
to change to make this feature more safer.

> 
> I'm fine with this feature. But as I've said in person: I still oppose
> making any block-based filesystem mountable in unprivileged containers
> without any sort of trust mechanism.

Nevertheless, since Christoph put this topic on the
community list, I had to repeat my own latest
thoughts of this on the list for reference.

Anyway, some people would just be nitpicky to the words
above as a policy: they will re-invent new
non-block-based trick filesystems (but with much odd
kernel-parsed metadata design) for the kernel community.

Honestly, my own idea is that we should find real
threats instead of arbitary assumptions against different
types of filesystems.  The original question is still
that what provents _kernel filesystems with kernel-parsed
metadata_ from mountable in unprivileged containers.

On my own perspective (in public, without any policy
involved), I think it would be better to get some fair
technical points & concerns, so that either we either fully
get in agreement as the real dead end or really overcome
some barriers since this feature is indeed useful.

I will not repeat my thoughts again to annoy folks even
further for this topic, but document here for reference.

> 
> I am however open in the future for block devices protected by dm-verity
> with the root hash signed by a sufficiently trusted key to be mountable
> in unprivileged containers.

Signed images will be a good start, I fully agree.

No one really argues that, and I believe I've told the
signed image ideas in person to Christoph and Darrick too.

Thanks,
Gao Xiang

