Return-Path: <linux-fsdevel+bounces-4314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 283697FE71B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 03:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D257128229F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D74134C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="e++ZB8cU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF9399
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 18:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701311343; bh=gL39ykAlNyN8xh3lAJOTUdf6ZI7rQ4ZW3xpbCJm57z8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=e++ZB8cU4B5RZlZWTWETzbfIBevyxqWN+0PnSQXZ4iR522FAU1IH1SWWh17ERaiUW2xx/Ssg4mICkGkYU578qCkNoWwZkpHiuCTPbCWWj0RrJ7YVyaIfIUjoHbLy+I+kCrOfTMJy2ZQK8zyNTmmTQeYhEKKfB289zmULWCxELnhSi+rkPnB+7gYmSbIfM7hpMSXLxP9R3EiQIXpS/0+F2Rcd1NoAIA5LMGm6SjQ/NlUyEtF7Y/tvmAAq/H/T0TF2qlDG0gb1Uckbh6oABzqeyaQYaLbhq37FzZhfHfJ4Unh3yrnhG0HDPvOGnkqj4enOUvagixGTh0zS1fzjKdA9Kg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701311343; bh=JN4VtfytD/T9E5h1Ka6FxbjJ1okDdhGyGQa4AZq6vWT=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ClFlSuFGReZ8IZyVNIM2eXSHBnFXuy03eUi81jkhIhHhgt0tZjg5sY3dNRbS9k38Q0BeHJAz22peMCvISijADp78v5zVgM8o8cXt85Y0908hfOq+9G4AU1vXf7/bu2awZDBzMrP8MkGT+DUb9CPprTO5TbnFkQ6MjfAbC9zhSErtBwxiW6eTjjWXRDMCw826KxJjIvXlSeFDzQ8nS7Lsx82M+GIsiC7K57GExNN1gYvWUX2CfxPGOxan8M9c1Uc0tLPeODlS1ueLXcjxtStHY5o4FYzUXDv6Hw7aO6W8McNrq4pb930MBZPYxaoBwwYR+nMXzm0PfDDct7BSrYjm/g==
X-YMail-OSG: CU67EQIVM1mB1q7UJBU_r3mPSoIr0be7xK6bLcUYQro1Kh6eZu4dF3oA4r4RAyQ
 7QzAq.ecYm0.Q6M4vl2pEnbUJp5yEf3G2WtOEWo9bbIjsfAR9MkDmKBs6Z22J._YSDHHC0jeWIgz
 YYwK6sy36DcUenmeQVsH0B6Do0gKATrsE4kpU5Xu9VUWftRqEd_hb.W2Pv_KVyvVyksX1RHpxFc1
 KsJjsIpyxILm_zrhD0zOuGfGcdc8WxRXLhci6XavaW14ryv4Sk38MapnptB3pxqc39aRnrDwXFcP
 nMRRJYAfcCCgyr7V_xxKtxiOG8ERzhHiXjIdXHV0BJAXV.McnuBD6V_GHE9hzJfhlP2pNWV3IDtF
 SjpmjlAiRbCvPph97KlpwQ5zYpz6VxSKAjr6VrQW_An4ZsWRQasgDMTW57QxpZm2rpfL426D0geF
 D0V7cnOyT3y3ep80EKJhn9JIHSwPpsdTaNGrHI19BrBz306LFN7wcwFcMJGQZ2ql9.YM3izqDU43
 loqWG7g_UDe5Ck8LysBTMukTYSN6dcz6noGOunQrYrk3QrwRbCKBzmneOCLaNmHZSUotL7kou8r7
 AoRZKLBov_a7Rnifo6t6E8T4wzt9LmcPBPemXVZaELXWmiWAFGd55avwzOITdJvXo9JiN29wpcfv
 NgR7S0rDNnS7IaIL0ea5PztFMTeJ9X4seuInNHr3PktNjGl6gkwf9GLiu4TWbtMCtWFfVZa6ZqCN
 1o4hWxAGcXVNuCY.FQlzQDLjvDI5gFSNA2Bk8bt6fbvyl9yferhzy0GyxhGIc.NYL1pkaERrhRED
 D0CXh7NFOou_FDsanowA6Q1PIsQ7kVzbpRzSs66vBcW6mUNaw8RMwTrfEIsBVKBWm4Q6nq7O.BLf
 N2.EGHApXcWTvx6wydf1Gchn5XODst7_wEh0v1uDVBuPM9VkiFt.5gCj37.mwVg1Nh_ahyI4ggX8
 ..vP.ysgEXV8UpBgAp2PYWLUVhoO0Zyum2ln6O_ZKTV1heIafcbfPGTAHuQahUgf0Uen06fuAdDF
 LkPVdngi7X2LeTNuoLfkivaouUBVNcUjEbMTXRurMcnbRk2pwhzldE0MFRQwQL5QQ.1n0mtfonMN
 RkngSlLWneXtiCFbrN7C9pMUn6kdvYmRW.5fOQK1FiHvwSxmrb0HpfXhWb5vClH3qeaUSEZavgis
 nw9K992Vb5uLDGd3RVwgMhyc25kjk2MsMmYI47uZwhApdu7sMOpE2W62u43ndRKUI5hnnVLkmobL
 dUYCcyP8Q2jXD5vDIPEDJkvIb1uOglahAtJj2gXXAl_3LS1Z95kMWM9qQ76yoBNuJkvDZTf1MHHH
 TsogXuup5.5IAU.VrL3gsmEPgTuBkmpXe00bv_1dFg6y4dwmbAWsW1dxTXD_4H_ux30.YolTocat
 sHdn3yQbSnURSuwssACBrAP0uztxy.tVeSuDTDhzQCM73wWm9ruUavcdPYkMbawIARB84z6psyaL
 ZYBOKrtICETCTqa2rQqzCJzHgBbrCOIUajUWgNPsMIy_._BbYzuMDq9AQkg8ElEANJ8MCiWx0QLP
 ..NhmkVpiAg_s1xxL.6_HG9zwKrQxQUGYWPrxUE8eRF3S9BP7auiln2ixajVrVevZRZFYDL8SYDE
 8uQ8MEfSSJWeBA59StJcTcgBRJ00lmSBioCUaJPsGzhtURHxxnbucZqIjp2fHSY1iweK5HT6v64N
 al4Ne5aSQYJzjGRPw9FqJZrWfvTf10FGgCJb9zpu_jAX.p_6xWBPAtCXt0jHK5hlvi8ZVRSICcgg
 tL58Lx5tkKmxghVfQ3nLOlZHRwWFtBz.yIRF7FJalZi9xD1yQ2PivzrfNhj7P3BSY0aYo9gsPlpN
 Am9uJgDBmrpuljdsV_ig3vf.H_yb4C1t09RKxJVu3IpvPH1_KxM6r7GzI5THun374GnU8_1waZqo
 ne6_iAohJA4M_y_lmAMl0QpdidvnQsm_2m.C4e4ccqofi1Qnnz7zrVADL9y57ply.skQdY18Le5w
 yoL0bk7nymaLT0SIjGWRlGl_ECojwp8fHrjPu81vgKc_imMRx.hzHBSV7GoM1xOg7rkxotjyLpkp
 BwmJ2.3xdg0lF_3VdA12De8u3e_NLZxlVkwLkzQOJUdyY0k.LxHtmhkMkhao4VBdbyuHnfLpND4I
 YDrZZw0MeeWgdnUWRTjhxjslDZ25G5a1659q0TGXyudeaZ.lj9tQjPoQVMVWYth4R_4d7iSrW9xX
 F_rx7SAgb.fznygkLGjQTHZ6QMfx8YXyYn7dEzsIpOUxVqa_GkpHdHCsygjVaEIiPyy1c6Fxim0L
 Zk4xXYcDZdA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 589800e8-cdf7-4ba8-aaee-54fb512f8a17
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 30 Nov 2023 02:29:03 +0000
Received: by hermes--production-gq1-5cf8f76c44-42dfr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d2206d053838777dcceb9a944e79273b;
          Thu, 30 Nov 2023 02:28:57 +0000 (UTC)
Message-ID: <6f02ce82-3697-4e76-aae6-13440e1bfbad@schaufler-ca.com>
Date: Wed, 29 Nov 2023 18:28:55 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] proc: Update inode upon changing task security attribute
Content-Language: en-US
To: Munehisa Kamata <kamatam@amazon.com>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231130003704.31928-1-kamatam@amazon.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231130003704.31928-1-kamatam@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/29/2023 4:37 PM, Munehisa Kamata wrote:
> I'm not clear whether VFS is a better (or worse) place[1] to fix the
> problem described below and would like to hear opinion.

Please To: or at least Cc: me on all Smack related issues.

>
> If the /proc/[pid] directory is bind-mounted on a system with Smack
> enabled, and if the task updates its current security attribute, the task
> may lose access to files in its own /proc/[pid] through the mountpoint.
>
>  $ sudo capsh --drop=cap_mac_override --
>  # mkdir -p dir
>  # mount --bind /proc/$$ dir
>  # echo AAA > /proc/$$/task/current		# assuming built-in echo

I don't see "current" in /proc/$$/task. Did you mean /proc/$$/attr?

>  # cat /proc/$$/task/current			# revalidate
>  AAA
>  # echo BBB > dir/attr/current
>  # cat dir/attr/current
>  cat: dir/attr/current: Permission denied
>  # ls dir/
>  ls: cannot access dir/: Permission denied
>  # cat /proc/$$/attr/current			# revalidate
>  BBB
>  # cat dir/attr/current
>  BBB
>  # echo CCC > /proc/$$/attr/current
>  # cat dir/attr/current
>  cat: dir/attr/current: Permission denied
>
> This happens because path lookup doesn't revalidate the dentry of the
> /proc/[pid] when traversing the filesystem boundary, so the inode security
> blob of the /proc/[pid] doesn't get updated with the new task security
> attribute. Then, this may lead security modules to deny an access to the
> directory. Looking at the code[2] and the /proc/pid/attr/current entry in
> proc man page, seems like the same could happen with SELinux. Though, I
> didn't find relevant reports.
>
> The steps above are quite artificial. I actually encountered such an
> unexpected denial of access with an in-house application sandbox
> framework; each app has its own dedicated filesystem tree where the
> process's /proc/[pid] is bind-mounted to and the app enters into via
> chroot.
>
> With this patch, writing to /proc/[pid]/attr/current (and its per-security
> module variant) updates the inode security blob of /proc/[pid] or
> /proc/[pid]/task/[tid] (when pid != tid) with the new attribute.
>
> [1] https://lkml.kernel.org/linux-fsdevel/4A2D15AF.8090000@sun.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/selinux/hooks.c#n4220
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
> ---
>  fs/proc/base.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index dd31e3b6bf77..bdb7bea53475 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2741,6 +2741,7 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>  {
>  	struct inode * inode = file_inode(file);
>  	struct task_struct *task;
> +	const char *name = file->f_path.dentry->d_name.name;
>  	void *page;
>  	int rv;
>  
> @@ -2784,10 +2785,26 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>  	if (rv < 0)
>  		goto out_free;
>  
> -	rv = security_setprocattr(PROC_I(inode)->op.lsm,
> -				  file->f_path.dentry->d_name.name, page,
> -				  count);
> +	rv = security_setprocattr(PROC_I(inode)->op.lsm, name, page, count);
>  	mutex_unlock(&current->signal->cred_guard_mutex);
> +
> +	/*
> +	 *  Update the inode security blob in advance if the task's security
> +	 *  attribute was updated
> +	 */
> +	if (rv > 0 && !strcmp(name, "current")) {
> +		struct pid *pid;
> +		struct proc_inode *cur, *ei;
> +
> +		rcu_read_lock();
> +		pid = get_task_pid(current, PIDTYPE_PID);
> +		hlist_for_each_entry(cur, &pid->inodes, sibling_inodes)
> +			ei = cur;
> +		put_pid(pid);
> +		pid_update_inode(current, &ei->vfs_inode);
> +		rcu_read_unlock();
> +	}
> +
>  out_free:
>  	kfree(page);
>  out:

