Return-Path: <linux-fsdevel+bounces-78681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL1iLjBAoWnsrQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 07:56:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 260E81B38F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 07:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82D823038529
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 06:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467FB38A71C;
	Fri, 27 Feb 2026 06:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="umbhtIzr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5074A334C14
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 06:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772175345; cv=none; b=RWtA7ppPc3Tb1ZiT7jgurk8HC5Gl0jz1ZF6TCrWUqonPnKfWVWIbqyPjZvvWt7QZ1jOq3O0JCp2OojHP0GncgRIDGElByqyQ2Ruo2vcopWYglFMIKIAia6SeBN2weM3giHHpAPdh67nRh45vZKTuj1kmT3BtI22SJLbmMEIaYaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772175345; c=relaxed/simple;
	bh=Q9KKBEi3HMBv81QRJwnFBc3mDTrDVNg3krHfR0Iakbo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=t3nBEPC2gDa70wgG1RRe/DM4jLPmg3QwIzM+HN8ZRxuYuyh7jo7KTdPUcEtf3qWRQOXMCJem/38A2rnjh8kCj1D7Bv1KV2Map0CQKebrZVwQqvy/FZieXYUTkHq1GF9T2WN3jUsxQUGUNZ6iahPtjpAD454AYbrkCId/KvSqU4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=umbhtIzr; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772175342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=59f9kZ4QTS/rAqlXMkEZDqhsSG127NPeC7GDWClZ9lc=;
	b=umbhtIzrqzO7voFpO99rC7TZTKDMQ2AjLNp/A5tCHMjlqOKxEVNsEDdUf/pVDTCrWC4eK0
	sNIgAUfCWrCpngy3O2HHd4QccUW5F01xyPDLzq6LyUjQxXvvcOlbsiSAYMHjnSPfyYsjj7
	8pkguaygaF/K20DTI7g6sP5oIqUT784=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v3 0/3] add support for drop_caches for individual
 filesystem
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <69A13C1A.9020002@huawei.com>
Date: Fri, 27 Feb 2026 14:55:04 +0800
Cc: Ye Bin <yebin@huaweicloud.com>,
 viro@zeniv.linux.org.uk,
 brauner@kernel.org,
 jack@suse.cz,
 linux-fsdevel@vger.kernel.org,
 akpm@linux-foundation.org,
 david@fromorbit.com,
 zhengqi.arch@bytedance.com,
 roman.gushchin@linux.dev,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <959B7A5C-8C1A-417C-A1D3-6500E506DEE6@linux.dev>
References: <20260227025548.2252380-1-yebin@huaweicloud.com>
 <4FDE845E-BDD6-45FE-98FA-40ABAF62608B@linux.dev>
 <69A13C1A.9020002@huawei.com>
To: "yebin (H)" <yebin10@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78681-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,scenarios.at:url,huawei.com:email,linux.dev:mid,linux.dev:dkim,huaweicloud.com:email]
X-Rspamd-Queue-Id: 260E81B38F4
X-Rspamd-Action: no action



> On Feb 27, 2026, at 14:39, yebin (H) <yebin10@huawei.com> wrote:
>=20
>=20
>=20
> On 2026/2/27 11:31, Muchun Song wrote:
>>=20
>>=20
>>> On Feb 27, 2026, at 10:55, Ye Bin <yebin@huaweicloud.com> wrote:
>>>=20
>>> From: Ye Bin <yebin10@huawei.com>
>>>=20
>>> In order to better analyze the issue of file system uninstallation =
caused
>>> by kernel module opening files, it is necessary to perform dentry =
recycling
>>> on a single file system. But now, apart from global dentry =
recycling, it is
>>> not supported to do dentry recycling on a single file system =
separately.
>>=20
>> Would shrinker-debugfs satisfy your needs (See =
Documentation/admin-guide/mm/shrinker_debugfs.rst)?
>>=20
>> Thanks,
>> Muchun
>>=20
> Thank you for the reminder. The reclamation of dentries and nodes can =
meet my needs. However, the reclamation of the page cache alone does not =
satisfy my requirements. I have reviewed the code of =
shrinker_debugfs_scan_write() and found that it does not support batch =
deletion of all dentries/inode for all nodes/memcgs,instead, users need =
to traverse through them one by one, which is not very convenient. Based =
on my previous experience, I have always performed dentry/inode =
reclamation at the file system level.

I don't really like that you're implementing another mechanism with =
duplicate
functionality. If you'd like, you could write a script to iterate =
through them
and execute it that way=E2=80=94I don't think that would be particularly =
inconvenient,
would it? If the iteration operation of memcg is indeed quite =
cumbersome, I
think extending the shrinker debugfs functionality would be more =
appropriate.

>=20
> Thanks,
> Ye Bin
>>> This feature has usage scenarios in problem localization =
scenarios.At the
>>> same time, it also provides users with a slightly fine-grained
>>> pagecache/entry recycling mechanism.
>>> This patchset supports the recycling of pagecache/entry for =
individual file
>>> systems.
>>>=20
>>> Diff v3 vs v2
>>> 1. Introduce introduce drop_sb_dentry_inode() helper instead of
>>> reclaim_dcache_sb()/reclaim_icache_sb() helper for reclaim =
dentry/inode.
>>> 2. Fixing compilation issues in specific architectures and =
configurations.
>>>=20
>>> Diff v2 vs v1:
>>> 1. Fix possible live lock for shrink_icache_sb().
>>> 2. Introduce reclaim_dcache_sb() for reclaim dentry.
>>> 3. Fix potential deadlocks as follows:
>>> =
https://lore.kernel.org/linux-fsdevel/00000000000098f75506153551a1@google.=
com/
>>> After some consideration, it was decided that this feature would =
primarily
>>> be used for debugging purposes. Instead of adding a new IOCTL =
command, the
>>> task_work mechanism was employed to address potential deadlock =
issues.
>>>=20
>>> Ye Bin (3):
>>>  mm/vmscan: introduce drop_sb_dentry_inode() helper
>>>  sysctl: add support for drop_caches for individual filesystem
>>>  Documentation: add instructions for using 'drop_fs_caches sysctl'
>>>    sysctl
>>>=20
>>> Documentation/admin-guide/sysctl/vm.rst |  44 +++++++++
>>> fs/drop_caches.c                        | 125 =
++++++++++++++++++++++++
>>> include/linux/mm.h                      |   1 +
>>> mm/internal.h                           |   3 +
>>> mm/shrinker.c                           |   4 +-
>>> mm/vmscan.c                             |  50 ++++++++++
>>> 6 files changed, 225 insertions(+), 2 deletions(-)
>>>=20
>>> --
>>> 2.34.1
>>>=20
>>=20
>> .
>>=20


