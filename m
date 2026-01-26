Return-Path: <linux-fsdevel+bounces-75527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKrHCP7Kd2lylAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:13:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C4B8CF0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCD783018288
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAF52C11C9;
	Mon, 26 Jan 2026 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PuU+KAGZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D521C29B204;
	Mon, 26 Jan 2026 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769458423; cv=none; b=VSyogslEz23wUviCRRr89JyVoIuDUhxCh3ZLG5UZVUoKD2J6LBhql/0uWhLU02ggSKiTi6/SxQYEbtuo5xFXYijiyGTPDTXyQJAu03ppr4tgDndMwOfcXeUU4O9I9VX1+T9OoK7Klc31BmhVIpULb6PZYFGbeTQiet0GKsWbY9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769458423; c=relaxed/simple;
	bh=YcrML87ShYkGKB6ZyS7KSUrjevy8i/2PiiASIF3Ueu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ryap/UF+8prJaRY5wy5hIDoq4RXFba846NTdi89TmdA/ZkHjX2ODNZFc2zgGXOYJIZMDQj3A+LKyNpKf872wLb7PzZMgo5oSxrWFGVSS/Ou37b6hsFBni2MDpCLhERR9L8ThPfgNr7KddCuf8G8KArLKaSjmTb4cDs7EsujpIEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PuU+KAGZ; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769458413; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gu7IeuPqkTXcHbpTJTB+5i/GAquRe193dCB4L9W0mjA=;
	b=PuU+KAGZiM0Q4g+7X1BfwSEwlMZ3IPRliM9m7w1PoQvO0QL8uK+IDa2grm+bC9LGfZ2t5M9VAQogO2gNFWCJjteNVuW2G1HHJ+nhdA7JhhxB7Gn0ZLLjOig/kuu1bQ+mapf3bPJ+OQ/91wFI03G+3CtgFfGGhsm21R1OVVPl+KU=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxzDUWW_1769458411 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Jan 2026 04:13:32 +0800
Message-ID: <fed3341a-365f-4099-b58d-8687732d193f@linux.alibaba.com>
Date: Tue, 27 Jan 2026 04:13:31 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] DAXFS: A zero-copy, dmabuf-friendly filesystem for
 shared memory
To: Cong Wang <cwang@multikernel.io>, Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Cong Wang <xiyou.wangcong@gmail.com>, multikernel@lists.linux.dev
References: <CAGHCLaREA4xzP7CkJrpqu4C=PKw_3GppOUPWZKn0Fxom_3Z9Qw@mail.gmail.com>
 <55e3d9f6-50d2-48c0-b7e3-fb1c144cf3e8@linux.alibaba.com>
 <CAGHCLaQbr2Q1KwEJhsZGuaFV=m6WEkxsgurg30+pjSQ4dHQ_1Q@mail.gmail.com>
 <aXe9nhAsK2lzOoxY@casper.infradead.org>
 <CAGHCLaSe8g+BQ5OtRv0_Ft3o-G0gR4oVSOW0DtdsQJdwuJsDCA@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAGHCLaSe8g+BQ5OtRv0_Ft3o-G0gR4oVSOW0DtdsQJdwuJsDCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75527-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 71C4B8CF0B
X-Rspamd-Action: no action



On 2026/1/27 03:48, Cong Wang wrote:
> On Mon, Jan 26, 2026 at 11:16 AM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Mon, Jan 26, 2026 at 09:38:23AM -0800, Cong Wang wrote:
>>> If you are interested in adding multikernel support to EROFS, here is
>>> the codebase you could start with:
>>> https://github.com/multikernel/linux. PR is always welcome.
>>
>> I think the onus is rather the other way around.  Adding a new filesystem
>> to Linux has a high bar to clear because it becomes a maintenance burden
>> to the rest of us.  Convince us that what you're doing here *can't*
>> be done better by modifying erofs.
>>
>> Before I saw the email from Gao Xiang, I was also going to suggest that
>> using erofs would be a better idea than supporting your own filesystem.
>> Writing a new filesystem is a lot of fun.  Supporting a new filesystem
>> and making it production-quality is a whole lot of pain.  It's much
>> better if you can leverage other people's work.  That's why DAX is a
>> support layer for filesystems rather than its own filesystem.
> 
> Great question.
> 
> The core reason is multikernel assumes little to none compatibility.
> 
> Specifically for this scenario, struct inode is not compatible. This
> could rule out a lot of existing filesystems, except read-only ones.

I don't quite get the point here, assuming you know filesystems.

> 
> Now back to EROFS, it is still based on a block device, which
> itself can't be shared among different kernels. ramdax is actually
> a perfect example here, its label_area can't be shared among
> different kernels.
> 
> Let's take one step back: even if we really could share a device
> with multiple kernels, it still could not share the memory footprint,
> with DAX + EROFS, we would still get:
> 1) Each kernel creates its own DAX mappings
> 2) And faults pages independently
> 
> There is no cross-kernel page sharing accounting.
> 
> I hope this makes sense.

No, EROFS on-disk format designs for any backend, so you could
use this format backed by:
  1) raw block device
  2) file
  3) a pure ramdaxfs (it's still WIP)

Why not? because an ordinary container image user doesn't assume
a fs especially for a particular type of device, especially for
golden image usage.

You cannot say, oh, I build an image, maybe, you have to use it
just for ramdax usage, oh, you backed by a file on the block
device, you have to convert to another format to use:

  EROFS on-disk format should allow for _all the device backend_.

At a quick glance of your code, it seems it's much premature
and ineffective because subdirectories just like a link chain,
and maybe it is only somewhat reasonable for ramdax usage,
but it's still _not_ cache-friendly.

The reason why it doesn't work for you because _multikernel_
isn't an offical upsteam requirement, all upstream virtualization
users directly use virtio-pmem now.

I think for the upstream kernels, you'd like to make multikernel
an offical upstream requirement first, then there will be drivers
for you to do multikernel ramdax, rather than the raw usage of
  1) memremap
  2) vmf_insert_mixed

in the filesystem drivers, I do think they are _red line_ for
any new filesytem drivers (instead of legacy cramfs MTD XIP
old code).

Anyway, I really think your current use cases are already
covered by EROFS for many years.

Thanks,
Gao Xiang

> 
> Regards,
> Cong


