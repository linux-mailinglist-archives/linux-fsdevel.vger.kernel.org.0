Return-Path: <linux-fsdevel+bounces-4530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A53280004F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 01:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E11D4B20E48
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FF71CA8C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NsADXAJl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D29A10DF
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 16:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701390678; bh=evWlZxpHNTaBDCxhQhresEPLDebJ37W+71aXPsBHMEo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=NsADXAJlwMQk7q6wuP6Ekka2WU2VEGXhFjkvKOiMPYpPv9qF0BemOVjgO+PDsFPOxJtM6agI99Pa+bTIPb+rn7+1Ts/BHcjKkLwMCcKAIMFbSaYJmQjtbUqQTEz37DzdzrQdjhKJdDdyULJlvwP6Xfk0gRitBf3/LGti1n5KnHNeWMR3Pn7Jh8f5j9REWwiZpLdAMc5CN6wq+U0MzejUiA8Pazsg3D7/yslUmrCa9Fl9tpRbHi2290TKLOaDrLuVClhbJ5w8hAIIieugMvqadw0Cux5TYF27BiPj4VnjsPjBJqtLT6ubSWUnk/c/1fodD4gNxNSaTwsZF8ee62fI0A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701390678; bh=wc7UlPuOUeuE9x7hkaJbAIzJZiE8LNtZMOm37ZvOEra=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=PX1thlVaRkC6Z4KK/4yamJolOS/FVvN7LpZv02DnIiSUlXWDe6yq1I/DpzgjS/auDiIiOG6fM9eK7qrFsSL4ItHiEjmgOZwTCjkTF5N8b+fjPdHwxLiEG8BKOgSC+egtE/G0vOvVTfeX6xl/d+a0x2Tc5RBOEca8AH4OLJsO91nG6X3csM4wsCgyUvowzPEfaCu8M0Vna1CFdY+8uD3hUNeVtqK8cjfSBte+hM9LbRb9zrBU91rjZrtDsE0i4xSDTMFv7cW2LDv0wDYjlvnzPgL3nDxElI5OlJ37Hzccsm4Edd8TORmcllxXXugh1PA7mTpIkfgNrUK0kNdNR8Lf/Q==
X-YMail-OSG: IlNJLmAVM1mTTGIVGG6UFMpt20m8HhJheSocOEPqyBUAYARtw_Z8WnTEjHmj85k
 PeE8N9nhWqejcDofKSmHRCvwj0KR_NQ13oLz7r92xApz40ZPlXd_lqEpI1gB8RjkqpIUbtQ5Anjr
 YPQelzbQLQtaJfg7mJ1KfuXIp9UeoZImTWUsxajGukCWnTC9YR4BtZGL0Du4Um8aAqEozmTHiQNe
 hyrmmMSu2RGjVZZyLFjfhn7rJambJ2Ol6bc8w25GfbBEc6IgOQGpyfioqfjGhPRkmIL2J2FnNJqt
 0Wo5dKOsQwmZpSW6YzBpHmJby.IhgmUi5oxQaqydK_hjB5DlQx4cqAwak7z6FfcfLwZ4zF7YBll0
 daifUd.IAuOwEIYQuBxr537fp6ekqL9PAno63bgEvEHzN95GHXBdy_FdQPJnRzC1dfv31GbLME0I
 1ye_xS6risgwWxXOhiiYAl.o4hzdWfLmgpyS3oKUKcOZTFpQPY6NNkZTuV.rC5_0pKb2hGoWTawW
 8j1V7ZMQdAH8Fv1LtgONvGtnjg4m.PTsBOcOBhawS3iXDz3srStmrofhpUG24.CPEq4E_Jz3Blh1
 dx.EogpYCxO2C6WP8JlBJk9oUlo4y52JduvmHg85x0_2OU_F1aKxPMcZ.ijbjc_HGPrkU1YD8cS8
 RKs1T3XrFLuE.1uHsUwDzwdtU2uAG1QkyKeQ.fhr1cCESxOKA1BqowOOOV5fNyWhQOFfGYbDDktf
 QQXPIw984RL0Y8A_NSCUSpzI5ea7O4QT_VQHCQ6CtTYNtEMCQb_6QxiZap00tsGvwOgpmCN3VO0F
 qdZIhZlD78.CahiggKnH3FVnrMbhZoOrMxc7vmDFXHgtpEdRlhT6hr3y_2y7d8hWesXvBwzoJYle
 f7Ad.C9ct97PA1icS1FvprYgCG5rbrLLFQdRCKg6G7tkMiGuLk08krKWjyljvziw7DFblTTehc_d
 Z9qN6eiGUpiAHxaY44snlP0u0ngLuTD53JfTckwl3QVCwmf5wZe7JY3mb6PNosodTEyCV4CsXlTW
 jAwCzt3NfQdV7xZpzSWHiPgGRnR6LA.tAululmJfDdkIbOd9KAxMKGZZMNfFu67tu9h3Zu2ziLMe
 50CRD63pqcXl9liZRdF6kHwAPx7lTCC4nPp.JFO7qO34Y6VC3SzSjfpNteXe9f.lVGdQ5S6yIC59
 JoaY1YSy7M.sYRXtjBhsuA3yBLHW762ICoBTZhslgY9UMU3wEJt_RChAS9Ij7jxJ48Awh2JxXkwi
 iDJbE4b5xFksGQfhlQyiqX7uDl0IczT9coQXmGNvheHqGvAiK5JZCMaWFny4xVuHb5sCpv3Oz2r1
 YIeUf.QpCMiyBXX_3rQ14X6l84OChOvvmdFlYNT791Z3XdIWsNovfN6.PH7EDz.bNdiAZchK3DlN
 HXlb2rIYgkYwlOdAHNlnNBaEDwNVgiX2vVrhYnTUjCUmg.SPzZJmn4iRLa9RSVmroa5XjstPjyVa
 XIGl5ZqI5lzStIV27ZxPPi5em7FNqFfqwl8H9QZmUDUEt_VqdDj_9Q8UB1pLrX8ernJCHhFGqAHd
 mzTf0GSLJzyEEX7H2GuFLm5NyPaTJX7qRYc80O8yrsYv4_vbYlJioEsYmA2jEWt08igYOQledL3R
 TM56jUGLP7KeBE9hRKn4mhoEWeWPi3ZqOBn23vAFjUJJ0T.bKgYI08VAuMHASpBT0yLNMVYLYomH
 zBUsk_VUhdqtgY24WRXm.3UTrOaYNeE3VkvASP08fbbGz8Mv5Klq5XbDEjGSIlaUT7ZmYyAty1eE
 Sjn17BTTv8BQ.XLgiWxyZ5PhxRPcu0NQdD4CPJuXm43gFC8Eul_juO2XEf376tpjTxkhRmG0zjnd
 BZStIR_iM46NLL4tzAgJGylAo.iPlMYiPDF5T8rN_EWjrFsG7wJk8I4tsK83w2D6zjpBs9E9F5WU
 d4Y640xHQDYcwu0Hn8qGudDIafhseqnHvV5I5X0pOMlcyNU3rkEsx5RCiY74PNhuohjauvNrSopu
 L_Vy6Et0qgH227KuDX.IobrdVKnrKgyqyJHWpbcULVO39kf4GMMRHSnuIbSSu.icenmugOu12HrD
 xJD_cGFmDE5CYTAfYHmJVxS8PfFoBq15Ni9oPY59QrXIcX74siMpIInbxn7KJb7th6zORO5ewsew
 KtceRGeTUeVu9F0OKS5F70WEU6dw6PKF4lN0v_jfrb_RWYUtT.WTB999GA48DElY_BoMQM81s.ME
 .uXTiUmuWW1I1DCEVZob4GKIS6LI-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c029d778-1faf-47b4-b788-60401d17106d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 1 Dec 2023 00:31:18 +0000
Received: by hermes--production-gq1-5cf8f76c44-dpjqf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c77969a11be0e90d0ca3d29716055688;
          Fri, 01 Dec 2023 00:31:13 +0000 (UTC)
Message-ID: <0cffc85b-c378-421f-baa1-fe52a193b2a1@schaufler-ca.com>
Date: Thu, 30 Nov 2023 16:31:11 -0800
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
 linux-kernel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <41edd3ad-10cf-41bd-b44a-e72bdd0837a3@schaufler-ca.com>
 <20231130203549.5549-1-kamatam@amazon.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231130203549.5549-1-kamatam@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/30/2023 12:35 PM, Munehisa Kamata wrote:
> On Thu, 2023-11-30 18:00:13 +0000, Casey Schaufler wrote:
>> On 11/29/2023 7:07 PM, Munehisa Kamata wrote:
>>> Hi Casey,
>>>
>>> On Wed, 2023-11-29 18:28:55 -0800, Casey Schaufler wrote:
>>>> On 11/29/2023 4:37 PM, Munehisa Kamata wrote:
>>>>> I'm not clear whether VFS is a better (or worse) place[1] to fix the
>>>>> problem described below and would like to hear opinion.
>>>> Please To: or at least Cc: me on all Smack related issues.
>>> Will do that next.
>>>
>>>>> If the /proc/[pid] directory is bind-mounted on a system with Smack
>>>>> enabled, and if the task updates its current security attribute, the task
>>>>> may lose access to files in its own /proc/[pid] through the mountpoint.
>>>>>
>>>>>  $ sudo capsh --drop=cap_mac_override --
>>>>>  # mkdir -p dir
>>>>>  # mount --bind /proc/$$ dir
>>>>>  # echo AAA > /proc/$$/task/current		# assuming built-in echo
>>>> I don't see "current" in /proc/$$/task. Did you mean /proc/$$/attr?
>>> Ahh, yes, I meant /proc/$$/attr/current. Sorry about that...
>>>
>>>>>  # cat /proc/$$/task/current			# revalidate
>>>>>  AAA
>>>>>  # echo BBB > dir/attr/current
>>>>>  # cat dir/attr/current
>>>>>  cat: dir/attr/current: Permission denied
>>>>>  # ls dir/
>>>>>  ls: cannot access dir/: Permission denied
>> I don't see this behavior. What kernel version are you using?
>> I have a 6.5 kernel.
> I verified the behavior with 6.7-rc3. 
>
> Here is more "raw" log from my machine:
>
>  [ec2-user@ip-10-0-32-198 ~]$ uname -r
>  6.7.0-rc3-proc-fix+
>  [ec2-user@ip-10-0-32-198 ~]$ sudo capsh --drop=cap_mac_override --
>  [root@ip-10-0-32-198 ec2-user]# mount --bind /proc/$$ dir
>  [root@ip-10-0-32-198 ec2-user]# echo AAA > /proc/$$/attr/current
>  [root@ip-10-0-32-198 ec2-user]# cat /proc/$$/attr/current; echo
>  AAA
>  [root@ip-10-0-32-198 ec2-user]# echo BBB > dir/attr/current
>  [root@ip-10-0-32-198 ec2-user]# cat dir/attr/current
>  cat: dir/attr/current: Permission denied
>
> If something frequently scans /proc, such as ps, top or whatever, on your
> machine, the inode may get updated quickly (i.e. revalidated during path
> lookup) and then you may only have a short window to observe the behavior. 

I was able to reproduce the issue with a 6.5 kernel. The window seems
to be really short.

Would it be completely unreasonable for your sandboxing application to
call syncfs(2) after writing to current?

>
>>>>>  # cat /proc/$$/attr/current			# revalidate
>>>>>  BBB
>>>>>  # cat dir/attr/current
>>>>>  BBB
>>>>>  # echo CCC > /proc/$$/attr/current
>>>>>  # cat dir/attr/current
>>>>>  cat: dir/attr/current: Permission denied
>>>>>
>>>>> This happens because path lookup doesn't revalidate the dentry of the
>>>>> /proc/[pid] when traversing the filesystem boundary, so the inode security
>>>>> blob of the /proc/[pid] doesn't get updated with the new task security
>>>>> attribute. Then, this may lead security modules to deny an access to the
>>>>> directory. Looking at the code[2] and the /proc/pid/attr/current entry in
>>>>> proc man page, seems like the same could happen with SELinux. Though, I
>>>>> didn't find relevant reports.
>>>>>
>>>>> The steps above are quite artificial. I actually encountered such an
>>>>> unexpected denial of access with an in-house application sandbox
>>>>> framework; each app has its own dedicated filesystem tree where the
>>>>> process's /proc/[pid] is bind-mounted to and the app enters into via
>>>>> chroot.
>>>>>
>>>>> With this patch, writing to /proc/[pid]/attr/current (and its per-security
>>>>> module variant) updates the inode security blob of /proc/[pid] or
>>>>> /proc/[pid]/task/[tid] (when pid != tid) with the new attribute.
>>>>>
>>>>> [1] https://lkml.kernel.org/linux-fsdevel/4A2D15AF.8090000@sun.com/
>>>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/selinux/hooks.c#n4220
>>>>>
>>>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>>>> Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
>>>>> ---
>>>>>  fs/proc/base.c | 23 ++++++++++++++++++++---
>>>>>  1 file changed, 20 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>>>>> index dd31e3b6bf77..bdb7bea53475 100644
>>>>> --- a/fs/proc/base.c
>>>>> +++ b/fs/proc/base.c
>>>>> @@ -2741,6 +2741,7 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>>>>>  {
>>>>>  	struct inode * inode = file_inode(file);
>>>>>  	struct task_struct *task;
>>>>> +	const char *name = file->f_path.dentry->d_name.name;
>>>>>  	void *page;
>>>>>  	int rv;
>>>>>  
>>>>> @@ -2784,10 +2785,26 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>>>>>  	if (rv < 0)
>>>>>  		goto out_free;
>>>>>  
>>>>> -	rv = security_setprocattr(PROC_I(inode)->op.lsm,
>>>>> -				  file->f_path.dentry->d_name.name, page,
>>>>> -				  count);
>>>>> +	rv = security_setprocattr(PROC_I(inode)->op.lsm, name, page, count);
>>>>>  	mutex_unlock(&current->signal->cred_guard_mutex);
>>>>> +
>>>>> +	/*
>>>>> +	 *  Update the inode security blob in advance if the task's security
>>>>> +	 *  attribute was updated
>>>>> +	 */
>>>>> +	if (rv > 0 && !strcmp(name, "current")) {
>>>>> +		struct pid *pid;
>>>>> +		struct proc_inode *cur, *ei;
>>>>> +
>>>>> +		rcu_read_lock();
>>>>> +		pid = get_task_pid(current, PIDTYPE_PID);
>>>>> +		hlist_for_each_entry(cur, &pid->inodes, sibling_inodes)
>>>>> +			ei = cur;
>>>>> +		put_pid(pid);
>>>>> +		pid_update_inode(current, &ei->vfs_inode);
>>>>> +		rcu_read_unlock();
>>>>> +	}
>>>>> +
>>>>>  out_free:
>>>>>  	kfree(page);
>>>>>  out:

