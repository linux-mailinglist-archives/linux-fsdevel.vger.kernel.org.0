Return-Path: <linux-fsdevel+bounces-75558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADSLGAYNeGl3ngEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 01:55:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9198E928
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 01:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 715C9302C309
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 00:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675071F4168;
	Tue, 27 Jan 2026 00:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="srPgl8vn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3C23B2BA;
	Tue, 27 Jan 2026 00:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769475326; cv=none; b=XkjS5+tf0Gf+1PgfWzgyKc0WnMr1Q2c2C9TCgjsO5TxDZI+RS9Ild2NtYNRYFQCGOLthRxrkImI4C6grOx5P+N+2ahINxEdLV2yPO/xB/f59S/dK38jZkVmgSHxhfEHVhtiG+fcNgQ1huM71/AreZUDQY5c1JAWo4pbRqDZJLQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769475326; c=relaxed/simple;
	bh=Quhip7AtSuOOrxOu7LPZIMpua5yU7+Z/mESCSj/4hRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVbD3pEWqhhuAxRY4R+3aucQ007/JbuUcIWiqF2NHc1a/OLpjen3IeKwZZCqB+GoLM8xR/KDFym68JO9vk4oQG8IrOkpBXGQqhb57gVAqs0soT+qlrBO/sO78vHbVK7M+c4Bnos7HR8Ltep93dr9LX7Ax6XPk9kfellMCLirk8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=srPgl8vn; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769475321; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+gX11oriZIJy4jt+JHRedxzgGFVzqefgGEdfbi0Jn7Q=;
	b=srPgl8vnr42ngnSYSp3xjyCMXuxtETgyeFOlLnYni3GauqUiJWEhgFT1M7U/flLzWYzFVp5XMVdrfdK+1lUJNRB+BP47GfWFJtW6r0zVxIZ7NegZh4Qq4RvXqt40mcJI9LQ/5ecb0Mi9m/GULkHT9wDFMUkIjMZLMWP/b97bFQU=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxzhWlt_1769475319 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Jan 2026 08:55:20 +0800
Message-ID: <44ae1d7c-8de7-47ce-a53c-c4075c39dc2a@linux.alibaba.com>
Date: Tue, 27 Jan 2026 08:55:17 +0800
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
 <aXfRUlu61nrIqCZS@casper.infradead.org>
 <CAGHCLaSA9SnM+rtURV=U=hJ4kxpqUim6t7SgvxMNnAed0XaHMg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAGHCLaSA9SnM+rtURV=U=hJ4kxpqUim6t7SgvxMNnAed0XaHMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75558-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: CF9198E928
X-Rspamd-Action: no action



On 2026/1/27 08:02, Cong Wang wrote:
> On Mon, Jan 26, 2026 at 12:40 PM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Mon, Jan 26, 2026 at 11:48:20AM -0800, Cong Wang wrote:
>>> Specifically for this scenario, struct inode is not compatible. This
>>> could rule out a lot of existing filesystems, except read-only ones.
>>
>> I don't think you understand that there's a difference between *on disk*
>> inode and *in core* inode.  Compare and contrast struct ext2_inode and
>> struct inode.
>>
>>> Now back to EROFS, it is still based on a block device, which
>>> itself can't be shared among different kernels. ramdax is actually
>>> a perfect example here, its label_area can't be shared among
>>> different kernels.
>>>
>>> Let's take one step back: even if we really could share a device
>>> with multiple kernels, it still could not share the memory footprint,
>>> with DAX + EROFS, we would still get:
>>> 1) Each kernel creates its own DAX mappings
>>> 2) And faults pages independently
>>>
>>> There is no cross-kernel page sharing accounting.
>>>
>>> I hope this makes sense.
>>
>> No, it doesn't.  I'm not suggesting that you use erofs unchanged, I'm
>> suggesting that you modify erofs to support your needs.
> 
> I just tried:
> https://github.com/multikernel/linux/commit/a6dc3351e78fc2028e4ca0ea02e781ca0bfefea3
> 
> Unfortunately, the multi-kernel derivation is still there and probably
> hard to eliminate without re-architecturing EROFS, here is why:
> 
>    DAXFS Inode (line 202-216):
> 
>    struct daxfs_base_inode {
>        __le32 ino;
>        __le32 mode;
>        ...
>        __le64 size;
>        __le64 data_offset;    /* ← INTRINSIC: stored directly in inode
> */
>        ...
>    };
> 
>   DAXFS Read Path:
>    // Pseudocode - what DAXFS does
>    void *data = base + inode->data_offset + file_offset;
>    copy_to_iter(data, len, to);
>    // DONE. No metadata parsing, no derivation.

Then? how do you handle memory-mapped cases? your
inode->data_offset still needs PAGE_SIZE aligned, no?

How it happens if an image with unaligned data offsets?

and why bother copy_to_iter in your filesystem itself
rather than using the upstream DAX infrastructure?

Also where you handle malicious `child_ino` if
sub-directories can generate a loop (from your on-disk
design?) How it deals with hardlinks btw?

> 
>   EROFS Read Path:
>    // What EROFS does (even in memory mode)
>    struct erofs_map_blocks map = { .m_la = pos };
>    erofs_map_blocks(inode, &map);  // ← DERIVES physical address
>        // Inside erofs_map_blocks():
>        //   - Check inode layout type (compact? extended?
> chunk-indexed?)
>        //   - For chunk-indexed: walk chunk table
>        //   - For plain: compute from inode
>        //   - Handle inline data, holes, compression...
>    src = base + map.m_pa;
> 
> Please let me know if I miss anything here.

Your expression above is very vague, so I don't know how
to react your words above.

I basically would like to say, your basic use case just
needs plain EROFS inodes (both compact & extended on-disk
core inode has a raw_blkaddr, and raw_blkaddr * PAGE_SIZE
is what you called `inode->data_offset`).

You could just ignore the EROFS compressed layout since
it needs to use page cache for those inodes even for
EROFS FSDAX, and your "DAXFS" doesn't deal with
compression.

Also, the expression above seems to be partially generated
by AI, but I have to write more reasonable words myself,
it seems unfair for me to reply in this thread.

> 
> Also, the speculative branching support is also harder for EROFS,
> please see my updated README here:
> https://github.com/multikernel/daxfs/blob/main/README.md
> (Skip to the Branching section.)

I also would like to discuss new use cases like
"shared-memory DAX filesystem for AI agents", but my
proposal is to redirect the whole write traffic into
another filesystem (either a tmpfs or a real disk fs) and
when agents need to snapshot, generate a new read-only
layer for memory sharing. The reason is because I really
would like to make the core EROFS format straight-forward
even for untrusted remote image usage.

Also a second quick glance of your cow approach, it just
seems nonsense from a real filesystem developer, anyway,
it's not me to prove your use cases to convince people,
it cannot be implemented with an existing fs with
enhancements.

If upstreaming is your interest, file a LSFMMBPF topic to
show your use cases to discuss, and I would like
to join the discussion.  If your interest is not
upstreaming, please ignore all my replies.

Thanks,
Gao Xiang

> 
> Thanks.
> Cong Wang


