Return-Path: <linux-fsdevel+bounces-78695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK6jCfVVoWk+sQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 09:29:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F53B1B48F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 09:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83DED30C7334
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 08:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F5E38A72D;
	Fri, 27 Feb 2026 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oXsvCypf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D2A155A5D
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180880; cv=none; b=FR7QjNbxwjUG74S3dcVy3VPjA1/evLKRqPpPAW94MVLJzX7+kqC9GoVU+Km9JOK1tdEE05tm8/WmiZaWbQwcVbZqiFX6pLN60hcxvy43niSddhKVBkfPySTvKDF8xBhF9tXWkvxBjSIYPaB53OfEVCysOGn32OL09RKNqmvBTns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180880; c=relaxed/simple;
	bh=ze4mZBVSpli5+/89vsqJziWXLM4gEym9yWCgDcMxB2w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dFV8LS/XTp7gxCl3iVrHU98UvsesTjcCBASaipMZAq6jrw6O2j2d/pf1AtQrtB2zv3wGRDuPGXa+gpYhfcg408vjaDLTGw1GQ+tmzx/s/JRigF1aXWfS+CYWTCMp19p+Eilkgg9G51zbZXXHb37WTLe4Wj8GcKVwNXg1517/YQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oXsvCypf; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772180876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYGSEvnS8api4yyTvRackPp/95vnLHXx6MYWXk9I9+4=;
	b=oXsvCypfA2YDihEQXRbhd4EXgO9FbAFl0EcjFZIH18y7qokq6WbbDvWGmwSAWO9V/pB90X
	Lb87p545rrUn7pO2cC0nkmhKx2M11/iPtWhoIOzqRwgwIxXk8A9u0YANDiEXfjweDRMLPP
	XjykPCSkdtSsBYacoa5N6O9M3U0rlRw=
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
In-Reply-To: <69A15314.3080602@huawei.com>
Date: Fri, 27 Feb 2026 16:27:13 +0800
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
Message-Id: <57055A1C-0684-4B77-80ED-4A641F262792@linux.dev>
References: <20260227025548.2252380-1-yebin@huaweicloud.com>
 <4FDE845E-BDD6-45FE-98FA-40ABAF62608B@linux.dev>
 <69A13C1A.9020002@huawei.com>
 <959B7A5C-8C1A-417C-A1D3-6500E506DEE6@linux.dev>
 <69A14882.4030609@huawei.com>
 <C63DBC11-B4CD-4D8D-9C09-E6A9F690FB21@linux.dev>
 <69A15314.3080602@huawei.com>
To: "yebin (H)" <yebin10@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-78695-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7F53B1B48F9
X-Rspamd-Action: no action



> On Feb 27, 2026, at 16:17, yebin (H) <yebin10@huawei.com> wrote:
>=20
>=20
>=20
> On 2026/2/27 15:45, Muchun Song wrote:
>>=20
>>=20
>>> On Feb 27, 2026, at 15:32, yebin (H) <yebin10@huawei.com> wrote:
>>>=20
>>>=20
>>>=20
>>> On 2026/2/27 14:55, Muchun Song wrote:
>>>>=20
>>>>=20
>>>>> On Feb 27, 2026, at 14:39, yebin (H) <yebin10@huawei.com> wrote:
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> On 2026/2/27 11:31, Muchun Song wrote:
>>>>>>=20
>>>>>>=20
>>>>>>> On Feb 27, 2026, at 10:55, Ye Bin <yebin@huaweicloud.com> wrote:
>>>>>>>=20
>>>>>>> From: Ye Bin <yebin10@huawei.com>
>>>>>>>=20
>>>>>>> In order to better analyze the issue of file system =
uninstallation caused
>>>>>>> by kernel module opening files, it is necessary to perform =
dentry recycling
>>>>>>> on a single file system. But now, apart from global dentry =
recycling, it is
>>>>>>> not supported to do dentry recycling on a single file system =
separately.
>>>>>>=20
>>>>>> Would shrinker-debugfs satisfy your needs (See =
Documentation/admin-guide/mm/shrinker_debugfs.rst)?
>>>>>>=20
>>>>>> Thanks,
>>>>>> Muchun
>>>>>>=20
>>>>> Thank you for the reminder. The reclamation of dentries and nodes =
can meet my needs. However, the reclamation of the page cache alone does =
not satisfy my requirements. I have reviewed the code of =
shrinker_debugfs_scan_write() and found that it does not support batch =
deletion of all dentries/inode for all nodes/memcgs,instead, users need =
to traverse through them one by one, which is not very convenient. Based =
on my previous experience, I have always performed dentry/inode =
reclamation at the file system level.
>>>>=20
>>>> I don't really like that you're implementing another mechanism with =
duplicate
>>>> functionality. If you'd like, you could write a script to iterate =
through them
>>>> and execute it that way=E2=80=94I don't think that would be =
particularly inconvenient,
>>>> would it? If the iteration operation of memcg is indeed quite =
cumbersome, I
>>>> think extending the shrinker debugfs functionality would be more =
appropriate.
>>>>=20
>>> The shrinker_debugfs can be extended to support node/memcg/fs =
granularity reclamation, similar to the extended function of echo " 0 - =
X" > count /echo " - 0 X" > count /echo " - - X" > count. This only =
solves the problem of reclaiming dentries/inode based on a single file =
system. However, the page cache reclamation based on a single file =
system cannot be implemented by using shrinker_debugfs. If the extended =
function is implemented by shrinker_debugfs, drop_fs_caches can reuse =
the same interface and maintain the same semantics as drop_caches.
>>=20
>> If the inode is evicted, the page cache is evicted as well. It cannot =
evict page
>> cache alone. Why you want to evict cache alone?
>>=20
> The condition for dentry/inode to be reclaimed is that there are no
> references to them. Therefore, relying on inode reclamation for page
> cache reclamation has limitations. Additionally, there is currently no

What limit?

> usage statistics for the page cache based on a single file system. By
> comparing the page cache usage before and after reclamation, we can
> roughly estimate the amount of page cache used by a file system.

I'm curious why dropping inodes doesn't show a noticeable difference
in page cache usage before and after?

>=20
>>>>>=20
>>>>> Thanks,
>>>>> Ye Bin
>>>>>>> This feature has usage scenarios in problem localization =
scenarios.At the
>>>>>>> same time, it also provides users with a slightly fine-grained
>>>>>>> pagecache/entry recycling mechanism.
>>>>>>> This patchset supports the recycling of pagecache/entry for =
individual file
>>>>>>> systems.
>>>>>>>=20
>>>>>>> Diff v3 vs v2
>>>>>>> 1. Introduce introduce drop_sb_dentry_inode() helper instead of
>>>>>>> reclaim_dcache_sb()/reclaim_icache_sb() helper for reclaim =
dentry/inode.
>>>>>>> 2. Fixing compilation issues in specific architectures and =
configurations.
>>>>>>>=20
>>>>>>> Diff v2 vs v1:
>>>>>>> 1. Fix possible live lock for shrink_icache_sb().
>>>>>>> 2. Introduce reclaim_dcache_sb() for reclaim dentry.
>>>>>>> 3. Fix potential deadlocks as follows:
>>>>>>> =
https://lore.kernel.org/linux-fsdevel/00000000000098f75506153551a1@google.=
com/
>>>>>>> After some consideration, it was decided that this feature would =
primarily
>>>>>>> be used for debugging purposes. Instead of adding a new IOCTL =
command, the
>>>>>>> task_work mechanism was employed to address potential deadlock =
issues.
>>>>>>>=20
>>>>>>> Ye Bin (3):
>>>>>>>  mm/vmscan: introduce drop_sb_dentry_inode() helper
>>>>>>>  sysctl: add support for drop_caches for individual filesystem
>>>>>>>  Documentation: add instructions for using 'drop_fs_caches =
sysctl'
>>>>>>>    sysctl
>>>>>>>=20
>>>>>>> Documentation/admin-guide/sysctl/vm.rst |  44 +++++++++
>>>>>>> fs/drop_caches.c                        | 125 =
++++++++++++++++++++++++
>>>>>>> include/linux/mm.h                      |   1 +
>>>>>>> mm/internal.h                           |   3 +
>>>>>>> mm/shrinker.c                           |   4 +-
>>>>>>> mm/vmscan.c                             |  50 ++++++++++
>>>>>>> 6 files changed, 225 insertions(+), 2 deletions(-)
>>>>>>>=20
>>>>>>> --
>>>>>>> 2.34.1
>>>>>>>=20
>>>>>>=20
>>>>>> .
>>>>>>=20
>>>>=20
>>>> .
>>=20
>>=20
>>=20
>>=20
>> .



