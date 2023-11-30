Return-Path: <linux-fsdevel+bounces-4473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D257FF9DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD52128198F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762CD5A0ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="by5Y89tD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3F310DE
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 10:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701367219; bh=DSg1NxEM2n+CAI10u/yx8Cgxalp7fpQDlDYAZ4VZFzY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=by5Y89tDMEtDfxKvLeSqAi5L17oHKrEp9JEWm3a5OLURJbRVs7f2XDRPYStIE9X1/c4GzqxfQ/Qqgv8vRzt4jUFKLMlk4oLq9a06NsMAmHhWTXs+VIpn0MOc87ALm9ue2i/3wB6O1nMnCt6Do8GRujPrmDOXGZs9Mn2CYpZ4CX3cFE/JA5SBYrs6urKY/h0mA58p0yzMpbh/Oe5wWfHNfSYhS0mXcd8TN8FzLa70gOmXjPFwG+7+SKlgWcQJuuezb3KDJKMyvO8aOlwL5bdo3rzvGahEORGnlmhaD6+AWZhieo5WrOWwCCDrN6ERppIFmXEYVI1E0JTuW5ZHFdijPQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701367219; bh=NN2NjO+Dx6RqiVh3FpUX2eKYU8uToBsABuPOCiEhDVs=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ixZaiSg/Tzr5XYRVQWmHfzON08FdZ3UHgZR72Cx1NFIqpGMgqqOpT8jlbLm8ZqoOIzr3EPIeCaFFBliLVZYBjfjyADvoorRtlPMbmo+FQ9FQZOS+5mkuVqS961oV/z+/02E87M5uB52mAjq+X1MpAR3rub6k2e3I5QtbNqfFBArrjNDapmhioc4ZnvwRmOqFO6/jH582eVPKlwSzr6SxvPgd9EC2smPuHUehdCt+dXYVUI3eKlCVFYFL2phTRlCV+qL78zjqHfQ2LrU+GJgSdHWpDdHHmYbie9eCrCGn4ow52KBnxFUOlUx8tDK7RMZcjtObhfsgJ1LJeaQNP5pRrg==
X-YMail-OSG: PV1rvNwVM1nrTzdIDJZmFGt7_Oug6LYTSSh6Lil8n45vR77xUFB8z5iRZnf98yZ
 U7zLH04RtBZDAh8RiVZBanF0q74zsjkFR6Srv0loBw103AbuX8iR9Y1zUQX0zSAxGcIpQi3gmf5d
 nhaF8aMzUQovtvQ1bhyia2Apd_kZb0Ab920YaHTmlylWNHrMiIf3_kBq5UZy4m0f4ZQDOSxDQZo1
 lPVhKizKHQlOVDFVxJK0rOmjAbVnAZLMtJdOn.8cLGaic.LEGdMXFSqb9a90RSR5Fzm_3Tvq6J6M
 5iLPnRtCPF5GDXsdCLHHO4UjY.BSY73kB844b8xS0Wuh9pSSeXDM_C13_z6mWTfZacCN0DHZlq7a
 GFoHrCXFAe6N54vaEOQ4NRDWlDZlygt6j9o14BUXBzseY.pUKJBKjrRmG28lUnufy1t4.0ncIm0Z
 R97jJTj8x1UxmfJ62E1t62GIT9o31WfMhlC3EZtKQFpFiJhlWNCi0t2K1yI2Phbq5uPum4BCUSuy
 IHXnr1hSfPDUKOCtAhSmCZMUeqaRmBCHwKd6T018I6fwOKPhzSrBHS0BE2zoZYRBZR47rxn9Qbj6
 lqG9hEpjAJNQPhtN8KLLtbPC0vYHHaid2pBbONlf0BKD3qMmAw.rchTZj0FQeGRZCk1I26ngchaP
 hxBl.X5wjhQBqTrPfyv3rsXWYZYGH6yQ.QFrhPUddXRHkh_8NYpb9VukBXnjEqUu9fq19_Hn5nxt
 fEOwVFC0l.K4_S4LGoOQ8lJ.ntSKuQuvob91NLaIx67dXeFOgErdT.sbyFvvSPhFEzAR6Ms628Pd
 faiiPy99sGP.eSdnaEaxvSF2M7YMoRMCijY1QrKJs4TxxpMj1X6pzNPQKqKZ9tBic_33IkJN5SP5
 scbXVZQ4OKwskJjzm7PfujyTU.CtUDlEqtq2saK_.8P5CKSzJAH3xzRgRm5pE5e8UwKliy0aLXUK
 .CIekcUz6aBjCob7P2a8nIE9JdWJBeNqCJhhhRnxHLrWvOgCzohnh7FGmvPNu3vuAixVbZ6JS7jH
 g1S02iKbVLdCTNqXBw1Jo904zk.z6.UtY6OnqpJghbLZDYBuezs6cce9wz4.xX2peiM2megh0_Cz
 28PzhRntqaaNogYcXzch.wPjVQB.m6LGAig6dQhU4qRIMSD_LQYJ8I4rQPAmBXyajlwETcoFeKVE
 MlvGNGORjY.KpVHxahlxztxiv06MbUgQw50hQObIJxmDlWfnduOpC.wa8msI7j7Yert3hnYrZSoz
 sSzqSuLs0lYkkfbHWtEHphUjy3VZUI8vnuzw7z.bPVPFGxhYNqMhGi9aHXuWK7uHrr8O4gE0guMJ
 odfXAACL.sAwr0c4twBMfOzDgI9kbd3gPeJ5wcbEWgcYmUFxnR5xYCPW.s2UhleCMJF7Ok72L7kW
 l27FGEVpdbI.Adq6jMQUVZmMp1itJzTpqWBDN0MULwKBOBMkRJbUVpGJcM4nmiVgMb0PIF7vy.RD
 ZwS2SfAyo0uxCroIWsp20LOREjNCV60.PsRjKAW6pTYqPRQ9xpUQiKrXXecUJsUkMSw889WfU_Pi
 SOfkEXjAPBayOA6kXEbV6VbKGbwEPEQAkfRI9xlUPPcONz8KXhmHRpOG4sTliupo.xMTDh6Zr5I4
 _Zxk0Z2je81G.APkVIsU5X1zsW.Af.eVqoNLTEO6It4xgY_3Ilf9IGj9byPoKPQZ5lsvVhRB4cd6
 ahiMYBIdXkXIOOzGxmnyBNFOOs.qbRWUUfnRENvB0LOlDayM8UHHYuZoXkRh2khAaOtShEK054e5
 AU5V3l6J_ioPOpZSGt_HVKTYW2P1N4JxE.995F8PYhD5bPZpQIL5BuV1ZanQ7KiSdp8L4ZCW_3JG
 GjXjyzRmxe8C.IxsnCVKqpnD.OXyAVNxhFQK0nlrAiWxxQpleRgiro6ZDAnDq_nIt9hE_PLiwyxG
 HBgqRCwPpY6ybtp57AmU88mUJdsGw3V2W9rnHOR3x5L6LJDYrUnFzVsMR.cALjBrqFwB4QtdC9sp
 _fjMdGNCogPr8mC0C5O7oSS4j_cRUytOUhzKsGYovNaLoOTDC3f_KQ7mBrI1vO89MXqyJ733Vm_2
 c21CtzvbJOvvciqj8nEXZNE.qbmzq1JBY1ZL1zLOQX3PW69sgf2MTM89FDWNYc6hvOloD01CFNIa
 .HRGtPXdiM2O9I_bvYVe0mk9wODTSBbGHtST6JBRzMMQL1WFDo1jfbklFW2wBPg_c..Vc0HOAqHr
 zRkfnlMPoeXW7gpIQ68TSfeN4w9Tmzohy0.4FWGhpvfOcyilS7WAxYjZuOpvuJNF8Pwv0dJPgM1b
 pDurm
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e4ac1fd0-2adf-4088-ac3c-e2823732e230
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Thu, 30 Nov 2023 18:00:19 +0000
Received: by hermes--production-gq1-5cf8f76c44-zkczr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a5590466b97aa00ff524a0c12627f86e;
          Thu, 30 Nov 2023 18:00:15 +0000 (UTC)
Message-ID: <41edd3ad-10cf-41bd-b44a-e72bdd0837a3@schaufler-ca.com>
Date: Thu, 30 Nov 2023 10:00:13 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] proc: Update inode upon changing task security attribute
Content-Language: en-US
To: Munehisa Kamata <kamatam@amazon.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <6f02ce82-3697-4e76-aae6-13440e1bfbad@schaufler-ca.com>
 <20231130030721.780557-1-kamatam@amazon.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231130030721.780557-1-kamatam@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/29/2023 7:07 PM, Munehisa Kamata wrote:
> Hi Casey,
>
> On Wed, 2023-11-29 18:28:55 -0800, Casey Schaufler wrote:
>> On 11/29/2023 4:37 PM, Munehisa Kamata wrote:
>>> I'm not clear whether VFS is a better (or worse) place[1] to fix the
>>> problem described below and would like to hear opinion.
>> Please To: or at least Cc: me on all Smack related issues.
> Will do that next.
>
>>> If the /proc/[pid] directory is bind-mounted on a system with Smack
>>> enabled, and if the task updates its current security attribute, the task
>>> may lose access to files in its own /proc/[pid] through the mountpoint.
>>>
>>>  $ sudo capsh --drop=cap_mac_override --
>>>  # mkdir -p dir
>>>  # mount --bind /proc/$$ dir
>>>  # echo AAA > /proc/$$/task/current		# assuming built-in echo
>> I don't see "current" in /proc/$$/task. Did you mean /proc/$$/attr?
> Ahh, yes, I meant /proc/$$/attr/current. Sorry about that...
>
>>>  # cat /proc/$$/task/current			# revalidate
>>>  AAA
>>>  # echo BBB > dir/attr/current
>>>  # cat dir/attr/current
>>>  cat: dir/attr/current: Permission denied
>>>  # ls dir/
>>>  ls: cannot access dir/: Permission denied

I don't see this behavior. What kernel version are you using?
I have a 6.5 kernel.

>>>  # cat /proc/$$/attr/current			# revalidate
>>>  BBB
>>>  # cat dir/attr/current
>>>  BBB
>>>  # echo CCC > /proc/$$/attr/current
>>>  # cat dir/attr/current
>>>  cat: dir/attr/current: Permission denied
>>>
>>> This happens because path lookup doesn't revalidate the dentry of the
>>> /proc/[pid] when traversing the filesystem boundary, so the inode security
>>> blob of the /proc/[pid] doesn't get updated with the new task security
>>> attribute. Then, this may lead security modules to deny an access to the
>>> directory. Looking at the code[2] and the /proc/pid/attr/current entry in
>>> proc man page, seems like the same could happen with SELinux. Though, I
>>> didn't find relevant reports.
>>>
>>> The steps above are quite artificial. I actually encountered such an
>>> unexpected denial of access with an in-house application sandbox
>>> framework; each app has its own dedicated filesystem tree where the
>>> process's /proc/[pid] is bind-mounted to and the app enters into via
>>> chroot.
>>>
>>> With this patch, writing to /proc/[pid]/attr/current (and its per-security
>>> module variant) updates the inode security blob of /proc/[pid] or
>>> /proc/[pid]/task/[tid] (when pid != tid) with the new attribute.
>>>
>>> [1] https://lkml.kernel.org/linux-fsdevel/4A2D15AF.8090000@sun.com/
>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/selinux/hooks.c#n4220
>>>
>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>> Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
>>> ---
>>>  fs/proc/base.c | 23 ++++++++++++++++++++---
>>>  1 file changed, 20 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>>> index dd31e3b6bf77..bdb7bea53475 100644
>>> --- a/fs/proc/base.c
>>> +++ b/fs/proc/base.c
>>> @@ -2741,6 +2741,7 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>>>  {
>>>  	struct inode * inode = file_inode(file);
>>>  	struct task_struct *task;
>>> +	const char *name = file->f_path.dentry->d_name.name;
>>>  	void *page;
>>>  	int rv;
>>>  
>>> @@ -2784,10 +2785,26 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>>>  	if (rv < 0)
>>>  		goto out_free;
>>>  
>>> -	rv = security_setprocattr(PROC_I(inode)->op.lsm,
>>> -				  file->f_path.dentry->d_name.name, page,
>>> -				  count);
>>> +	rv = security_setprocattr(PROC_I(inode)->op.lsm, name, page, count);
>>>  	mutex_unlock(&current->signal->cred_guard_mutex);
>>> +
>>> +	/*
>>> +	 *  Update the inode security blob in advance if the task's security
>>> +	 *  attribute was updated
>>> +	 */
>>> +	if (rv > 0 && !strcmp(name, "current")) {
>>> +		struct pid *pid;
>>> +		struct proc_inode *cur, *ei;
>>> +
>>> +		rcu_read_lock();
>>> +		pid = get_task_pid(current, PIDTYPE_PID);
>>> +		hlist_for_each_entry(cur, &pid->inodes, sibling_inodes)
>>> +			ei = cur;
>>> +		put_pid(pid);
>>> +		pid_update_inode(current, &ei->vfs_inode);
>>> +		rcu_read_unlock();
>>> +	}
>>> +
>>>  out_free:
>>>  	kfree(page);
>>>  out:

