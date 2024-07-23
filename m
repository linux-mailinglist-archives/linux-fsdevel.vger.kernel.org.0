Return-Path: <linux-fsdevel+bounces-24119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8AC939E76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 12:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2193281DF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 10:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF36E14D6FF;
	Tue, 23 Jul 2024 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stuba.sk header.i=@stuba.sk header.b="OWzikim1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out.cvt.stuba.sk (smtp-out.cvt.stuba.sk [147.175.1.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CFF28373;
	Tue, 23 Jul 2024 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.175.1.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721728908; cv=none; b=W7HWymbkB8VYJ8PhxB5KnobYGcTZYNLuRwX/AbItIH86vk3TkOF1CU03KqYZWE5nc04uYMXiEGlFTPLqLHqzGtPgm6OuBOGbKgfsPf7sM1Lp75QtaCCYPDYdAHvmi5hmVwkVQPT9WA3eSkbgYUUcX4QK5Ym/m2/xYmTAxFxWw48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721728908; c=relaxed/simple;
	bh=UR81pycbsfjNkTWPBFNPKbEatk5vZR5/kJfi5HOC1jQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHTCKc9xO7OFokK1xsxaJotToOXbX86lc4IP1GujyZ1bcEQVmLgb8CkgtrzhBTHa7PXAhBkp8Ivp6+HgTHVi1VyWBu/mC7R0ihHs47VM8a4kYBHeBqzSTf1Pet7K5EJTJs7LWApqrTUVI1I5BNK8kDUyFEiFZ5FWsntxkbb8Vho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stuba.sk; spf=pass smtp.mailfrom=stuba.sk; dkim=pass (2048-bit key) header.d=stuba.sk header.i=@stuba.sk header.b=OWzikim1; arc=none smtp.client-ip=147.175.1.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stuba.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stuba.sk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=stuba.sk;
	s=20180406; h=Content-Transfer-Encoding:Content-Type:From:To:Subject:
	MIME-Version:Date:Message-ID; bh=zYWTglprKuEEbjtStrFcNuP4ZeE7OybL2CijXrcDuXI=
	; t=1721728905; x=1722160905; b=OWzikim1wivrdiUVIF8NCFPPlqNqBzyUJX7g59nFvR+ui
	LDRclpL5O+LgsPCZLgSL1TDrSuIkvpvwKaeDRhnkrMg4pFWBKm4XVBWv21TR9osULDQZLQdGXRaAx
	/GTcwRoygIuHGQvxsYHJzWBe/BnvrZYEaEuKGLfU3DHOlTGSCgGfZzHd+PUqpzTt0B6od4ldAEyVa
	olNR/MxUsrQXptBxXeA/9EiaZVhtJ5fgdWAlIpxVWtOxwZpRET4O0hOFJFIsGwzKqMPxk77wZbnkP
	F78vYOzQ5x3XGJIGhP3dWQYFEzfhgqnHuLDhXJePiv7G9igZJ3TUjubPNzfF8WQdlA==;
X-STU-Diag: da6aee320b3da66d (auth)
Received: from ellyah.uim.fei.stuba.sk ([147.175.106.89])
	by mx1.stuba.sk (Exim4) with esmtpsa (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(envelope-from <matus.jokay@stuba.sk>)
	id 1sWCL0-000000004fT-2DLw;
	Tue, 23 Jul 2024 12:01:42 +0200
Message-ID: <19c91a22-f30a-4faa-ac9e-665ce79bb93e@stuba.sk>
Date: Tue, 23 Jul 2024 12:01:42 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
To: Dave Chinner <david@fromorbit.com>, Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
References: <20240710024029.669314-2-paul@paul-moore.com>
 <20240710.peiDu2aiD1su@digikod.net>
 <ad6c7b2a-219e-4518-ab2d-bd798c720943@stuba.sk>
 <CAHC9VhRsZBjs2MWXUUotmX_vWTUbboyLT6sR4WbzmqndKEVe8Q@mail.gmail.com>
 <Zp8k1H/qeaVZOXF5@dread.disaster.area>
Content-Language: en-US
From: Matus Jokay <matus.jokay@stuba.sk>
In-Reply-To: <Zp8k1H/qeaVZOXF5@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23. 7. 2024 5:34, Dave Chinner wrote:
> On Mon, Jul 22, 2024 at 03:46:36PM -0400, Paul Moore wrote:
>> On Mon, Jul 22, 2024 at 8:30 AM Matus Jokay <matus.jokay@stuba.sk> wrote:
>>> On 10. 7. 2024 12:40, Mickaël Salaün wrote:
>>>> On Tue, Jul 09, 2024 at 10:40:30PM -0400, Paul Moore wrote:
>>>>> The LSM framework has an existing inode_free_security() hook which
>>>>> is used by LSMs that manage state associated with an inode, but
>>>>> due to the use of RCU to protect the inode, special care must be
>>>>> taken to ensure that the LSMs do not fully release the inode state
>>>>> until it is safe from a RCU perspective.
>>>>>
>>>>> This patch implements a new inode_free_security_rcu() implementation
>>>>> hook which is called when it is safe to free the LSM's internal inode
>>>>> state.  Unfortunately, this new hook does not have access to the inode
>>>>> itself as it may already be released, so the existing
>>>>> inode_free_security() hook is retained for those LSMs which require
>>>>> access to the inode.
>>>>>
>>>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>>>
>>>> I like this new hook.  It is definitely safer than the current approach.
>>>>
>>>> To make it more consistent, I think we should also rename
>>>> security_inode_free() to security_inode_put() to highlight the fact that
>>>> LSM implementations should not free potential pointers in this blob
>>>> because they could still be dereferenced in a path walk.
>>>>
>>>>> ---
>>>>>  include/linux/lsm_hook_defs.h     |  1 +
>>>>>  security/integrity/ima/ima.h      |  2 +-
>>>>>  security/integrity/ima/ima_iint.c | 20 ++++++++------------
>>>>>  security/integrity/ima/ima_main.c |  2 +-
>>>>>  security/landlock/fs.c            |  9 ++++++---
>>>>>  security/security.c               | 26 +++++++++++++-------------
>>>>>  6 files changed, 30 insertions(+), 30 deletions(-)
>>
>> ...
>>
>>> Sorry for the questions, but for several weeks I can't find answers to two things related to this RFC:
>>>
>>> 1) How does this patch close [1]?
>>>    As Mickaël pointed in [2], "It looks like security_inode_free() is called two times on the same inode."
>>>    Indeed, it does not seem from the backtrace that it is a case of race between destroy_inode and inode_permission,
>>>    i.e. referencing the inode in a VFS path walk while destroying it...
>>>    Please, can anyone tell me how this situation could have happened? Maybe folks from VFS... I added them to the copy.
>>
>> The VFS folks can likely provide a better, or perhaps a more correct
>> answer, but my understanding is that during the path walk the inode is
>> protected by a RCU lock which allows for multiple threads to access
>> the inode simultaneously; this could result in some cases where one
>> thread is destroying the inode while another is accessing it.
> 
> Shouldn't may_lookup() be checking the inode for (I_NEW |
> I_WILLFREE | I_FREE) so that it doesn't access an inode either not
> completely initialised or being evicted during the RCU path walk?
> All accesses to the VFS inode that don't have explicit reference
> counts have to do these checks...
> 
> IIUC, at the may_lookup() point, the RCU pathwalk doesn't have a
> fully validate reference count to the dentry or the inode at this
> point, so it seems accessing random objects attached to an inode
> that can be anywhere in the setup or teardown process isn't at all
> safe...
> 
> -Dave.

Indeed, but maybe only VFS maintainers can give us the answer to why may_lookup()
does not need at some point check for (I_NEW | I_WILL_FREE | I_FREEING).

Thanks,
mY

