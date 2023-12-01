Return-Path: <linux-fsdevel+bounces-4617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A35C801674
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02D21F20C95
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610373F8C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aUPQnb3x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE44310D0
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 13:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701466963; bh=ZLkjqmVhdO5Cg0IsMDIVtCQlW2qVvQloo+ShABLQ+KM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=aUPQnb3xnUemWAJItZvgPzgKOKZfdj0UlmSjlnADV+md+T125X0G5SWMF3QGCfKdJCWyOCfq1rf1RdoA5es44NenYCySE0gJ3ct/4rFlL03NO9E4qyu0wY//6OjhWzE1QI6A/OYFAf6SofTTOLdKac3TknYSbG+5tJEMWtdZmFe7F9f/0Avk0gSm91LonDl0N9ieWX7GnylJNyDAKoTrvVJQmWo04kUwqN9/1wNWk+/KXQUsi8e7/QPLtDd4PLqS0VMGt+Bl45YEIdTPZwJVnUjzqymth5Rjob3PdJETHv/SXjdEqTbehjM44XlYxuqsMWVmdUEXIZ0o6c8SZhAavg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701466963; bh=Ns45J0CgHMthmJs3WjRgUMqSLeHGAZjpR6rcxpR8Q8l=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=NwUpUA2tZTjfzb5h2J7hknjM9btHiRcWoq4Uu0S/ytfe/Codn+57JUqhyEXwwaHz+3AB7QnHs7TRlIVnaEyfBCrKFVK1qALFEob8CEHqRUnvIT3clquQityEXkuXpGcZq5uJuK5x8rb8qwQWlAuzA0oLxpQPeJ5dcoLd7pvmefFVK81ZWVcDdxhMwv3w65pnHNenCrPgsfXU7J0A+K8agXuiata1MuGqLErvoJiJuswF48ANKVnB2qkpc0NAu5ZNgYOv3j/WGddJJtJoQFsXAeb3SaFmAP37V2SDP7GCkt+YNOa6rawduynX9/LR8ejAfZDIaCu/txfWORUCougBXw==
X-YMail-OSG: ClAPQioVM1lLSr2zj4_ga4wHfUXJBMw5jbkOCVWS3mKr8FGyy9NbsR.4O8Pzpwk
 YhvzNSCq2qiObz8ER5I5AZ0P3a2CWSFAVzYmF0DHiI7k7oCzLUyHutqtfGKSwj5WQGmQhIxijfQj
 wwaZDQECUpw6ZjqAps3JwPOKFQT8HFRE4sr8Z6WAKClLDlhwgGzsBYgsTlINj4CsULhhOdiR0kpj
 qmXlwzghZ4dbDtVo3LikCBeBdtYO50vtYAs6B9HXA7I3Nus8Hw1eyt3yHs_3DqlFlI.PUhdx71wt
 och.J_Xk5MQmpMpTYBq0O3DDOLyQl7W7q80oLiS100hTWCKUd8sLwFkhHaZGiSU1hk95R.dt0Ci_
 1PQoV2MSOSnhrJUvREkEwwJb5o0eZ2jCRcAUbxdRqxsusPm4TdMc_MeYb0QNii0B_iFqri9CF9op
 JOmiu6M.s7JNaeYKb2u.md7MFtebg_5s69Fh6C8eB_ufe890hW4LHNa7_QGjyPTQ9T_Mcfh.ZPv8
 xcMgR2cc3oR.hE02hiSZ85Mwol2.BlLDRARdM5RsFks3ijKCyi.8W3cidMyiZtLEABxAjSg3R1Fr
 LS.MDQpZ7iYmAx3CDdCqi_Sv.mAku4ATFnk7vo_XM48tL4vGP9naBBudkh1NBADq.zjUn7umfVq6
 UDH3FfEsLt6ANFc4LbF1MvBEy.K1ubpkfNkama5gmp9YmS1.b9NHqQUKIQGqezLiYxxLiRH3MHlj
 07cs6IubMVhuHOY3KnnM2Vnk3Ew_PI44hqNTsFXT5MVY0aikx7Ru6BQXAXPgPkpON7obyvKA5IFr
 ri1ShuvPKnw4W2cZlID7rnqvwSmOXTLChSibAVgpakOeT6OPcjhHBZQDvPWd6wJE3Qtxq5ylaoLr
 6FWqgQr59SOy65xMWdUwZOTfHRB5PUUHYtGrb89uTnwfu9J0poZitlO.fJKReYkpH18XhXz8YsXE
 pD.vnbqrpJuVR4cgzHsOq0QJSEcMFrA49geaYIkgmn9U._NaOoptI3feOaZWkmIpOXOc5UhuwpG4
 P2MT7Yc8GRlRNU5d7gYHp6HBdVdz.E4aPZhRsWpwivf9Q6v22J9sPjGh0SOVxiS_97HC0xYyoky_
 qzya7s5ShU_acSqQnwUXl4lPxv_WptoawgCukj0JjPg7jWd4KUYfmzFjzFSPoj9hVB37V7kMm4d9
 ZgzhgLjecEK7g25s8c5np5LnXPyX2lJcLTGaMa951VH1kiW.7EewUggPcAwlh1BEdQr6NH2.V.V6
 Tx5vcLAI.cK1yPN7l0VOuWfYxur1FjC3OavrHfb0sACsDPdngkpyGf_HUJU8rjhsQRBdeGFfmxoE
 vgqQ._dUKaW4ckzupoq4ghgKfx7NXDGOEC60CYaxiL9TJy4ahk5ZoHYU1lJ6WTNHpUK0i_FesGiI
 DIl1defuGtMpPpm9.dOHuC3XQjHZN4Rj7B1NzIkXh1DkpdO06jACKfRDkWVPeVFVxWjQL78knFPa
 iJRE6PEAC0meAE_xiY7y_xCPzsuMfHRpwyggWdtUFnDzpZTaIQbqCTmA7sadrrXkwNt2lOM5ZpxN
 Ed8UGfKDD8SmledFMx1s9wid14rbcyksKoJDQRT2APoK7.kwDixowTNmJw1pYXO4bgCacuUhDf9_
 jIMDdVHL.venxuGNXkIzlk0Bjf0NhjWDW6v_HxgFCq7Qv4D47UECVvRPdDaaCgSip71La1j8XtuG
 QKB__SBOQcCEVhwIiggLDDhqueIqcneSG2.CbBiYZ.Hnn_U1DrWHFBJ5Rmqq8uMNTXGrcv_Ein77
 VEcMBzHUr2yOONvZHiKpgGLt37zxmJQfc564Vwl_i_ZefMENZxcsz3pGT8b4fjMMo5t6L7AFwbpI
 04h43whJCSZZ2HEVZA13uApufFs6lya.KoYZjgspxeYp_83DifdlCsRtoHG.KAYldhVBGHEUVtMP
 ILnMV.p.P89Wgljwli3hPnUk850_oX2X.EGPq7qxRzudlbx1mCDTzJIhu6NVSm5IjwMj2XvdjiCu
 Ib87f4D_GHOhIeOrL4mRJavj6CEv_KET9CC_XxrQ0myHBC4QUuL9Q8N5Yh3MHT9q5j6aUyGu2elw
 q4LuExRp_.zQElGQYEOuu7wzpr7J3Kf5ACHhWdsmNZv8bma8Oh7tto.ru4vg6_h9AkHsrZ7aZjrX
 Asp.zfIIwkhlz_q882iFPRN3xj73688alEN_S21gtWNCklsyivj9bAXOyLf9F5M7_IQ29yEa.E3S
 Vtt7nvUzZmPZBGp.pYzHZKxnFOWpV7L20.gxjZSqmH.BPd2g9f_fy_15LGo4WnapwcMkyZ2EDo91
 2cf5PxDcE3ABXm64-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4b09c470-a981-4550-be61-6815eaa4f41b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 1 Dec 2023 21:42:43 +0000
Received: by hermes--production-gq1-5cf8f76c44-ghgt9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 40dfce3d67f8b553f0416cb733b4b4d5;
          Fri, 01 Dec 2023 21:42:39 +0000 (UTC)
Message-ID: <e12eddba-6ae4-4942-a705-b33dbe724884@schaufler-ca.com>
Date: Fri, 1 Dec 2023 13:42:36 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fw: [PATCH] proc: Update inode upon changing task security
 attribute
Content-Language: en-US
To: Munehisa Kamata <kamatam@amazon.com>, adobriyan@gmail.com
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <5f8b18b0-0744-4cf5-9ec5-b0bb0451dd18@p183>
 <20231201205940.23095-1-kamatam@amazon.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231201205940.23095-1-kamatam@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/1/2023 12:59 PM, Munehisa Kamata wrote:
> Hi Alexey,
>
> On Fri, 2023-12-01 09:30:00 +0000, Alexey Dobriyan wrote:
>> On Wed, Nov 29, 2023 at 05:11:22PM -0800, Andrew Morton wrote:
>>> fyi...
>>>
>>> (yuk!)
>>>
>>>
>>>
>>> Begin forwarded message:
>>>
>>> Date: Thu, 30 Nov 2023 00:37:04 +0000
>>> From: Munehisa Kamata <kamatam@amazon.com>
>>> To: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
>>> Cc: <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>, "Munehisa Kamata" <kamatam@amazon.com>
>>> Subject: [PATCH] proc: Update inode upon changing task security attribute
>>>
>>>
>>> I'm not clear whether VFS is a better (or worse) place[1] to fix the
>>> problem described below and would like to hear opinion.
>>>
>>> If the /proc/[pid] directory is bind-mounted on a system with Smack
>>> enabled, and if the task updates its current security attribute, the task
>>> may lose access to files in its own /proc/[pid] through the mountpoint.
>>>
>>>  $ sudo capsh --drop=cap_mac_override --
>>>  # mkdir -p dir
>>>  # mount --bind /proc/$$ dir
>>>  # echo AAA > /proc/$$/task/current		# assuming built-in echo
>>>  # cat /proc/$$/task/current			# revalidate
>>>  AAA
>>>  # echo BBB > dir/attr/current
>>>  # cat dir/attr/current
>>>  cat: dir/attr/current: Permission denied
>>>  # ls dir/
>>>  ls: cannot access dir/: Permission denied
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
>> Should this "break;"? Why is only the last inode in the list updated?
>> Should it be the first? All of them?
> If it picks up the first node, it may end up updating /proc/[pid]/task/[tid]
> rather than /proc/[pid] (when pid == tid) and the task may be denied access
> to its own /proc/[pid] afterward.
>
> I think updating all of them won't hurt. But, as long as /proc/[pid] is
> accessible, the rest of the inodes should be updated upon path lookup via
> revalidation as usual.
>
> When pid != tid, it only updates /proc/[pid]/task/[tid] and the thread may
> lose an access to /proc/[pid], but I think it's okay as it's a matter of
> security policy enforced by security modules. Casey, do you have any
> comments here?

I do not.

>
>
> Regards,
> Munehisa
>
>  
>>> +		put_pid(pid);
>>> +		pid_update_inode(current, &ei->vfs_inode);
>>> +		rcu_read_unlock();
>>> +	}

