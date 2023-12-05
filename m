Return-Path: <linux-fsdevel+bounces-4907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 577348061E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 23:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B695282137
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 22:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2BF3FB18
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ETQLi58W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D3C1A5
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 14:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701815527; bh=XhsIfB1syxa6PM3j3PvDpSoB8J8/0UqgOB0nBoiXEoY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ETQLi58WDZ4kd8rl8HdbzCtuNnvQzFROLstfBhAHVKkXJFBtCpQQbzQV6RjRvepz357ZmneW+P/6qqLk0mJnknsETkWuiT/No1LYlFvCX0tjMVMfn7o9NCgGI75VZXxin1fJtAq+6Ox22b7GThgX1MTypWqK6vMiIennOFTKoTijerJ16J5FpmAQtKCXT7RZ131AoCA59R1XxAmN1hXpOAXRUxMB1kqi4z9Ymdon+1xO5ay8j9mTERU725nCq98E+mcsJ53AytwJ/39udaXSNjNHDFblr1LsgwLRaoJGrizwmmh0MeE4Vbu9n2xxWKejLMnP77KIEKZMS0/1lmRZGQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701815527; bh=U14nZyyRsvQPXBuc8aqLVh+tpfrcdXDtBFsJFKkQzNC=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=chv3ZWLtt9GkhazRytTQN9wZEJ8tcpSAbM/CnW1OSJsYkOtsDS8WwtB0GEHlifOxp1wPscht3P7RH13QVsK37ZhmHsZpBZXM2PiT4Y8r0M8Qy1CovmvgdrWz5hZRE3ZkJhW50132827LucqzLl9F3K6fXLAILpPhViboKlsIagXJB64WbhEsOJbUElvOrNnMV2/HngUgCZF58Fd51iB8j0NI0GPIDtZ7xUBPcmB1dv9Nwz0g8buiJiIpwOC3yYmn5zEMp4Lg8lLQ+25P7UUTzu6FFtpzh9YYH325+SBw8zZd8efhzduEYmSVR0FeK5WIWQf0s6ywQFIC1dByXZaYYg==
X-YMail-OSG: 7w.fOQoVM1n15WecGNKV.T8H7x76FCH8dWCyop1OgbQhzPoOgxdZH6LNQZ.qT6Z
 GH5lOVmtwu8FhfOcUJbZgF8auqSGZdC1LjE42IsjimcRfnG8kGZ0uJ8CWcXUgGaPFDrw4nS2InGf
 gE.oHvdLl_yOV.TYdB7MycOKjX0crN0DpdEpe9XV8ZscI2sIitrwDnl5R4semiGisKH8BUxZmxxz
 ZDyEDsK54km5gPgz3bYoLqiHIZ9zfCZ9v_aexa.v2v0eiwD1WztygXD7wYPDyi41Ed6P.n7nqrBv
 JVRatP5adQ.cNVYW0q3S7omlROU484NEymp80S6.93fVXoPxuq3DyfbyPuogydohHBpRFa0gyIYS
 corea_fJWn1Z1TaYGw66wkxZ92Ys0WBNi62QT5Y8MALMr0YZRb5h5p6mPOHgl9mbXo02pe_jJsqu
 _gIRU.3dkN6LYqW4DY2VkPPQZdgT52BYs7l4kmHhnM33ZxijcFOL6AoFNvlPQsS6qdZtDo3aUnvR
 3_9qVp7xyvRxGJ7EhFayJNa0hzpN4kVT8wP3vhtOqAxnaEEF_UeNdUcFd.ZziLt2nj6Vi_AMSOG1
 rZ206WcDAOLTqfgsUVmVG10hnERj1c3wt48mZ2pXPTLBMFM5kaAx_Ky88LGd1qV5t1XZrHfm1Z7b
 v4YaeLdr_hAYb5I2I5FNl7Nfw_jIGwgLw.NV95IIkrcSXerhor7rrcezf7ocKqC3grp.GNTTUJhL
 6FPhs9CMWBun7R8d3aU3TpTCbh97TdyCqSoVCxXbdWLWT7WQAYyosxCkmek_h5GvzpNUe3b__6mQ
 6R_VYyuRguqf1juTnD277x3Fvey.7kTW.LRpq_jvxxwAWDc8WA4QO7PcFfsQnmbpVz8D10rDH5E9
 s6aA719fk8WlvJXewoMwZEHw0ca0aaJ1vWF1XPy8j_x6yeag0OCKrG9JyFJhAQ9D_CmYkqITXyMj
 WfYhhZxmrisP6o6CzkhuEh_s7vzS871yXgwkceZEfjos0HALwlGqejCytTlZ9HqlUfmWLY7_FmS7
 zFx6ky4lYGlPbhaul4CyrZcaIoMLOBliEKP2LMRLslJpLK3HsqH4x9t.Q.Aj2cuqCkY9Pykl7bpZ
 Z6yWMU7EwL33RLzNacFcNgUmxwDmqwmypVgqRz0UXxr52v4ehc76uhF0RtaFqW0LUc.Y.yXaONys
 EdW0VUgHeusNbu1tC8dYdXxcoSRzOCyVYpguDc20haeVv4zPZ9G8oPjRPDmUNHgRhnkfC1zgMUI9
 xrqAVEGUfKTXuT17xleVoeXJFS5z95haNZ_LkV02jt7OCEnpyP.SH5qbIFA4.CL8184Sij68JHQc
 8HyDKmeZ2227ZEHCOZJ09aedHeAnxqMzI1dRRWhsV5asaZfrz8PcmGLv6E2FnZ8wP_qGEEE9wxaS
 OmiKUvGMxBB_6O5t2.sBRg5QQhCHR0Zkauf9iU5dWZU9Y9VrwuYDLYaOjBFI1z6WLNgIK8HI4BsB
 pYKBFnO5FwNcR3GOudS8XfRiCLUeypRize0Lh.OMDnR7s5VXQwOc.VEz0oF_hXIbpFs8sZSbFwcI
 U7cKNuSpkxxoJPQEGgJ9FowZZWaVevX1xid3j0HrJ3V489uBADOTdNw1ohKCkLdM9TnGr5v7DQop
 dWaGAvxlUMLcK0lUX4lsa6qRoiyFqxrpG9OKrHB_GjMSmrqoLa9.F9kId2o.fsp6017UJ6ieN644
 xKzvTws63qnfPYExQRYjhmuZgpVn8mFICLi58YoAyCv97sQyLYwCbMNXlgOpfn5zMoWQhTUvTxBl
 YoVVKMLtjSFwbY1SteRRyF_vBhiePjLl2L7Q4VZ_dm9ROYcEavq_g68dHRcxvI2GxbmnIjNyFLvB
 iU1h0rzCooJWmibM4RxdixSCeIguJRpGXPCT5FTtaFD0usUXdRs1Hpmqa3JBkOAU9qG8ajS3P9AA
 IFikdTPIkrXnJPrB4SLRUQA6fqHO1_J_Em78Agi8XHEx7Th4i_Bax.YVHfUvfc98pYGj3qMjumQz
 eQCqK8yFrE3xc2o20TPvLIuTLmhkChM.j8kgFdWgiJn.5NzRZYUIHS_1MmWDEdvh2jRrR73L0PJ2
 tz.NOyd0R_BWwi_LEx6_gCydCW7SpsPImezqcTykNWAV60M61ZRO6UegMWB6pvipYf9vg9rYep2v
 tTTsi.2XsLx0H_QrH7_VHE_CpBbyUSOIDM7PVMeiJwzAlIaCpq3x7ttCrvSsEFR9gdkcu_NZQ8rm
 WBdfj1wgXwHeIausfyecFJQxo0l7aFFHqJCxh.SrHMUbWrzbQahi7L8LLg29GH3gEGs7UuN8fM8z
 mxBFRZQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b737f352-c4b9-4bfa-9ab9-25385c038a20
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Tue, 5 Dec 2023 22:32:07 +0000
Received: by hermes--production-gq1-64499dfdcc-m6m9b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4145692701c3bdb59d62294ad06b16f1;
          Tue, 05 Dec 2023 22:32:01 +0000 (UTC)
Message-ID: <fa0b7051-6eee-4b4a-8e0d-ce0160ef4e5a@schaufler-ca.com>
Date: Tue, 5 Dec 2023 14:31:59 -0800
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
To: Paul Moore <paul@paul-moore.com>, Munehisa Kamata <kamatam@amazon.com>
Cc: adobriyan@gmail.com, akpm@linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <5f8b18b0-0744-4cf5-9ec5-b0bb0451dd18@p183>
 <20231201205940.23095-1-kamatam@amazon.com>
 <CAHC9VhSyaFE7-u470TrnHP7o2hT8600zC+Od=M0KkrP46j7-Qw@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhSyaFE7-u470TrnHP7o2hT8600zC+Od=M0KkrP46j7-Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/5/2023 2:21 PM, Paul Moore wrote:
> On Fri, Dec 1, 2023 at 4:00 PM Munehisa Kamata <kamatam@amazon.com> wrote:
>> On Fri, 2023-12-01 09:30:00 +0000, Alexey Dobriyan wrote:
>>> On Wed, Nov 29, 2023 at 05:11:22PM -0800, Andrew Morton wrote:
>>>> fyi...
>>>>
>>>> (yuk!)
>>>>
>>>> Begin forwarded message:
>>>> Date: Thu, 30 Nov 2023 00:37:04 +0000
>>>> From: Munehisa Kamata <kamatam@amazon.com>
>>>> Subject: [PATCH] proc: Update inode upon changing task security attribute
>>>>
>>>> I'm not clear whether VFS is a better (or worse) place[1] to fix the
>>>> problem described below and would like to hear opinion.
>>>>
>>>> If the /proc/[pid] directory is bind-mounted on a system with Smack
>>>> enabled, and if the task updates its current security attribute, the task
>>>> may lose access to files in its own /proc/[pid] through the mountpoint.
>>>>
>>>>  $ sudo capsh --drop=cap_mac_override --
>>>>  # mkdir -p dir
>>>>  # mount --bind /proc/$$ dir
>>>>  # echo AAA > /proc/$$/task/current         # assuming built-in echo
>>>>  # cat /proc/$$/task/current                        # revalidate
>>>>  AAA
>>>>  # echo BBB > dir/attr/current
>>>>  # cat dir/attr/current
>>>>  cat: dir/attr/current: Permission denied
>>>>  # ls dir/
>>>>  ls: cannot access dir/: Permission denied
>>>>  # cat /proc/$$/attr/current                        # revalidate
>>>>  BBB
>>>>  # cat dir/attr/current
>>>>  BBB
>>>>  # echo CCC > /proc/$$/attr/current
>>>>  # cat dir/attr/current
>>>>  cat: dir/attr/current: Permission denied
>>>>
>>>> This happens because path lookup doesn't revalidate the dentry of the
>>>> /proc/[pid] when traversing the filesystem boundary, so the inode security
>>>> blob of the /proc/[pid] doesn't get updated with the new task security
>>>> attribute. Then, this may lead security modules to deny an access to the
>>>> directory. Looking at the code[2] and the /proc/pid/attr/current entry in
>>>> proc man page, seems like the same could happen with SELinux. Though, I
>>>> didn't find relevant reports.
>>>>
>>>> The steps above are quite artificial. I actually encountered such an
>>>> unexpected denial of access with an in-house application sandbox
>>>> framework; each app has its own dedicated filesystem tree where the
>>>> process's /proc/[pid] is bind-mounted to and the app enters into via
>>>> chroot.
>>>>
>>>> With this patch, writing to /proc/[pid]/attr/current (and its per-security
>>>> module variant) updates the inode security blob of /proc/[pid] or
>>>> /proc/[pid]/task/[tid] (when pid != tid) with the new attribute.
>>>>
>>>> [1] https://lkml.kernel.org/linux-fsdevel/4A2D15AF.8090000@sun.com/
>>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/selinux/hooks.c#n4220
>>>>
>>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>>> Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
>>>> ---
>>>>  fs/proc/base.c | 23 ++++++++++++++++++++---
>>>>  1 file changed, 20 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>>>> index dd31e3b6bf77..bdb7bea53475 100644
>>>> --- a/fs/proc/base.c
>>>> +++ b/fs/proc/base.c
>>>> @@ -2741,6 +2741,7 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>>>>  {
>>>>     struct inode * inode = file_inode(file);
>>>>     struct task_struct *task;
>>>> +   const char *name = file->f_path.dentry->d_name.name;
>>>>     void *page;
>>>>     int rv;
>>>>
>>>> @@ -2784,10 +2785,26 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>>>>     if (rv < 0)
>>>>             goto out_free;
>>>>
>>>> -   rv = security_setprocattr(PROC_I(inode)->op.lsm,
>>>> -                             file->f_path.dentry->d_name.name, page,
>>>> -                             count);
>>>> +   rv = security_setprocattr(PROC_I(inode)->op.lsm, name, page, count);
>>>>     mutex_unlock(&current->signal->cred_guard_mutex);
>>>> +
>>>> +   /*
>>>> +    *  Update the inode security blob in advance if the task's security
>>>> +    *  attribute was updated
>>>> +    */
>>>> +   if (rv > 0 && !strcmp(name, "current")) {
>>>> +           struct pid *pid;
>>>> +           struct proc_inode *cur, *ei;
>>>> +
>>>> +           rcu_read_lock();
>>>> +           pid = get_task_pid(current, PIDTYPE_PID);
>>>> +           hlist_for_each_entry(cur, &pid->inodes, sibling_inodes)
>>>> +                   ei = cur;
>>> Should this "break;"? Why is only the last inode in the list updated?
>>> Should it be the first? All of them?
>> If it picks up the first node, it may end up updating /proc/[pid]/task/[tid]
>> rather than /proc/[pid] (when pid == tid) and the task may be denied access
>> to its own /proc/[pid] afterward.
>>
>> I think updating all of them won't hurt. But, as long as /proc/[pid] is
>> accessible, the rest of the inodes should be updated upon path lookup via
>> revalidation as usual.
>>
>> When pid != tid, it only updates /proc/[pid]/task/[tid] and the thread may
>> lose an access to /proc/[pid], but I think it's okay as it's a matter of
>> security policy enforced by security modules. Casey, do you have any
>> comments here?
>>
>>>> +           put_pid(pid);
>>>> +           pid_update_inode(current, &ei->vfs_inode);
>>>> +           rcu_read_unlock();
>>>> +   }
> I think my thoughts are neatly summarized by Andrew's "yuk!" comment
> at the top.  However, before we go too much further on this, can we
> get clarification that Casey was able to reproduce this on a stock
> upstream kernel?  Last I read in the other thread Casey wasn't seeing
> this problem on Linux v6.5.

I was able to recreate the problem once given corrected instructions,
which have to be followed exactly. 

> However, for the moment I'm going to assume this is a real problem, is
> there some reason why the existing pid_revalidate() code is not being
> called in the bind mount case?  From what I can see in the original
> problem report, the path walk seems to work okay when the file is
> accessed directly from /proc, but fails when done on the bind mount.
> Is there some problem with revalidating dentrys on bind mounts?
>

