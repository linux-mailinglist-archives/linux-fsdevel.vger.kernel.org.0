Return-Path: <linux-fsdevel+bounces-5064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 266F7807B81
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 23:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE211282475
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854A34B140
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF6pg9A0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97473D1;
	Wed,  6 Dec 2023 13:41:15 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1fb38f3cb57so180225fac.3;
        Wed, 06 Dec 2023 13:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701898875; x=1702503675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mfnhnm+K+WfBVmcqTgAuQV0NSjrZcnpNlLxst6calO8=;
        b=VF6pg9A0LQaS/2cV9yeAHqutF9mTMyveou9ikbgn+6X24ymWKuZut+BUQvqVk451UE
         1SbFO0h2eedJ0mD63qg7UPSwIwMqaBLG7t97YykxGp4vpNuMOUOyXfmiSnkWgWq+ksZL
         N3bcZ3cdBwjArL9gmvTDoxYOBbmfVqA9CkCD1wgR6S1KlC8YrtLcp5chzXGe+LppleIi
         piY71q0J+jStpXjs6bHKBON/pPMpWGasEDmxNQpfPCKKOJ6oDjgGRcX8zc8oa/Nczqtu
         AuCZ48HHJRaYjvPxxuen8BqAK83amChoEfUv/rn5Z2YbX30v87Z/vto1PF2CsG6ahqxS
         8djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701898875; x=1702503675;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfnhnm+K+WfBVmcqTgAuQV0NSjrZcnpNlLxst6calO8=;
        b=q4fsMoFEggkcBFrTTOOrerI9xJN0UHGNqKe6wOOfPZ5IUV7cikhUajsnhMG6bztI67
         pIXqKdGPBIgTHwZKKQodU+mUFUqRPOJn5Wh2+x04OgxiyQMBaEisdxHLTiCnZ90JFtsg
         Akqa55yV9IK1l+cb7cByJGwc/PETPXVeK+4AhuuRH04ow9vtDnam6Ml5ffaeqhebz5NR
         Aylb79qIERK32U6wzCw8/EqxlpLhpbWDh9CbNyFMkN47bjnmfv7WsRaA0T8d3dxObq0p
         jUE/pTSm0jbFfZqk8uy0bOu/tCocRyBpV9c4zT1mz6BN5CE3cLu/It9ZJa/QDCdErBRl
         qt1Q==
X-Gm-Message-State: AOJu0YzcYvzgU+S+PjGt4jrpMXcv8Q1Lq6aOAxR/at1KQXj9O/WCEK9P
	BJVUqBTsLnlCA37cSPjgzOWNhb6/NqMjmRP0hINTsGVRhJtrdQ==
X-Google-Smtp-Source: AGHT+IElf2YuV8FXY+BYJSUIffpB+QBj7dWIdxNFq930+JhxMEU5kQWYsBrWtHz2WdmCyZ8rpYUadLdrJlCb12e3P/w=
X-Received: by 2002:a05:6870:9d14:b0:1fb:75a:c444 with SMTP id
 pp20-20020a0568709d1400b001fb075ac444mr1386013oab.109.1701898874700; Wed, 06
 Dec 2023 13:41:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a05:6802:30f:b0:50c:13ee:b03d with HTTP; Wed, 6 Dec 2023
 13:41:14 -0800 (PST)
In-Reply-To: <20231206210718.GQ1674809@ZenIV>
References: <ZW3WKV9ut7aFteKS@xsang-OptiPlex-9020> <20231204195321.GA1674809@ZenIV>
 <ZW/fDxjXbU9CU0uz@xsang-OptiPlex-9020> <20231206054946.GM1674809@ZenIV>
 <ZXCLgJLy2b5LvfvS@xsang-OptiPlex-9020> <20231206161509.GN1674809@ZenIV>
 <20231206163010.445vjwmfwwvv65su@f> <CAGudoHF-eXYYYStBWEGzgP8RGXG2+ER4ogdtndkgLWSaboQQwA@mail.gmail.com>
 <20231206170958.GP1674809@ZenIV> <CAGudoHErh41OB6JDWHd2Mxzh5rFOGrV6PKC7Xh8JvTn0ws3L_A@mail.gmail.com>
 <20231206210718.GQ1674809@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 6 Dec 2023 22:41:14 +0100
Message-ID: <CAGudoHFf8VNt1HL-6UwpoY0jjHu75dCQY8Hp9sSuzrkp=jW=5Q@mail.gmail.com>
Subject: Re: [viro-vfs:work.dcache2] [__dentry_kill()] 1b738f196e:
 stress-ng.sysinfo.ops_per_sec -27.2% regression
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-doc@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com, 
	fengwei.yin@intel.com, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On 12/6/23, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Wed, Dec 06, 2023 at 06:24:29PM +0100, Mateusz Guzik wrote:
>> On 12/6/23, Al Viro <viro@zeniv.linux.org.uk> wrote:
>> > On Wed, Dec 06, 2023 at 05:42:34PM +0100, Mateusz Guzik wrote:
>> >
>> >> That is to say your patchset is probably an improvement, but this
>> >> benchmark uses kernfs which is a total crapper, with code like this in
>> >> kernfs_iop_permission:
>> >>
>> >>         root = kernfs_root(kn);
>> >>
>> >>         down_read(&root->kernfs_iattr_rwsem);
>> >>         kernfs_refresh_inode(kn, inode);
>> >>         ret = generic_permission(&nop_mnt_idmap, inode, mask);
>> >>         up_read(&root->kernfs_iattr_rwsem);
>> >>
>> >>
>> >> Maybe there is an easy way to dodge this, off hand I don't see one.
>> >
>> > At a guess - seqcount on kernfs nodes, bumped on metadata changes
>> > and a seqretry loop, not that this was the only problem with kernfs
>> > scalability.
>> >
>>
>> I assumed you can't have possibly changing inode fields around
>> generic_permission.
>
> That's not the problem; kernfs_refresh_inode(), OTOH, is.
> Locking in kernfs is really atrocious ;-/
>
> I would prefer to make that thing per-node (and not an rwsem, obviously,
> seqloct_t would suffice), but let's see what the minimal change would do
> - turn that into a mutex + seqcount and keep them in the same place.
>

So I checked what this strenng test is doing to begin with and I don't
think it is worth spending much time on.

most important bit:
[snip]
57566 newfstatat(AT_FDCWD, "/sys", {st_mode=S_IFDIR|0555, st_size=0,
...}, 0) = 0
57566 ustat(makedev(0, 0x15), 0x7ffc47378270) = 0
57566 newfstatat(AT_FDCWD, "/proc", {st_mode=S_IFDIR|0555, st_size=0,
...}, 0) = 0
57566 ustat(makedev(0, 0x16), 0x7ffc47378270) = 0
57566 newfstatat(AT_FDCWD, "/dev", {st_mode=S_IFDIR|0755,
st_size=3180, ...}, 0) = 0
57566 ustat(makedev(0, 0x5), 0x7ffc47378270) = 0
57566 newfstatat(AT_FDCWD, "/dev/pts", {st_mode=S_IFDIR|0755,
st_size=0, ...}, 0) = 0
57566 ustat(makedev(0, 0x17), 0x7ffc47378270) = 0
57566 newfstatat(AT_FDCWD, "/run", {st_mode=S_IFDIR|0755, st_size=540,
...}, 0) = 0
57566 ustat(makedev(0, 0x18), 0x7ffc47378270) = 0
57566 newfstatat(AT_FDCWD, "/", {st_mode=S_IFDIR|0755, st_size=4096,
...}, 0) = 0
57566 ustat(makedev(0xfe, 0x1), 0x7ffc47378270) = 0
57566 newfstatat(AT_FDCWD, "/sys/kernel/security",
{st_mode=S_IFDIR|0755, st_size=0, ...}, 0) = 0
57566 ustat(makedev(0, 0x6), 0x7ffc47378270) = 0
57566 newfstatat(AT_FDCWD, "/sys/fs/selinux", {st_mode=S_IFDIR|0755,
st_size=0, ...}, 0) = 0
57566 ustat(makedev(0, 0x14), 0x7ffc47378270) = 0
[/snip]

This is part of a loop which also does a bunch of statfs of similar sort.

Bottom line though is that it keeps microbenchmarking *all* mounted
filesystems, most of which are never subjected to this kind of work in
the real world.

I got lock stat from your work.dcache2 branch before you sent the
patch. It had kernfs on it, but it was not standing out compared to
other filesystems. Rerunning this now (again without the patch you
just sent) only gives read locks, I don't know why. Anyhow majority of
lock_stat output is pasted at the end.

Top of the profile is dentry->d_lock in common codepaths, presumably
one does not need stressng to run into that.

After that sb_lock in user_get_super and drop_super. I think it is
unsound that lookup by dev number callable by userspace is done in
O(n), I would suggest a RB tree keyed on dev here. Regardless of that
refcount could be changed with atomics and dropped with
atomic_dec_unless (or whatever the name), then drop_super would avoid
taking the lock in the common case. I can hack it up if it sounds
reasonable.

The rest is contention within filesystems which did not expect to be
running into it and which imo is not worth poking at.

That is to say the real regression to investigate imo is that
unixbench drop by 11%. I did not find instructions how to reproduce
it, but sent an e-mail asking about it. Will look into it after I get
a response.

lock_stat version 0.4
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                              class name    con-bounces    contentions
  waittime-min   waittime-max waittime-total   waittime-avg
acq-bounces   acquisitions   holdtime-min   holdtime-max
holdtime-total   holdtime-avg
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                         &dentry->d_lock:      24924207       24987328
          0.05        2306.93     9523158.78           0.38
225395365      405715020           0.04        2179.42    50129873.85
         0.12
                         ---------------
                         &dentry->d_lock       12359237
[<00000000dd9f6f18>] dput+0xf0/0x240
                         &dentry->d_lock       10061783
[<00000000834ba9a3>] lockref_get_not_dead+0xc/0x30
                         &dentry->d_lock        1233395
[<000000004eae9c7d>] __d_lookup+0x80/0x100
                         &dentry->d_lock        1147006
[<00000000d3f25dc0>] lockref_get+0x9/0x20
                         ---------------
                         &dentry->d_lock        1232931
[<00000000d3f25dc0>] lockref_get+0x9/0x20
                         &dentry->d_lock       11326396
[<00000000dd9f6f18>] dput+0xf0/0x240
                         &dentry->d_lock       10462141
[<00000000834ba9a3>] lockref_get_not_dead+0xc/0x30
                         &dentry->d_lock        1512612
[<000000004eae9c7d>] __d_lookup+0x80/0x100

.............................................................................................................................................................................................................................

                                 sb_lock:       3751297        3785255
          0.06         333.93     2084502.27           0.55
14120549       29289318           0.04         483.38     6902926.62
        0.24
                                 -------
                                 sb_lock        1679258
[<00000000cebb0a72>] user_get_super+0x1a/0xc0
                                 sb_lock        2105997
[<00000000794955d0>] drop_super+0x1e/0x40
                                 -------
                                 sb_lock        2990448
[<00000000cebb0a72>] user_get_super+0x1a/0xc0
                                 sb_lock         794807
[<00000000794955d0>] drop_super+0x1e/0x40

.............................................................................................................................................................................................................................

                             sysctl_lock:        798762         959533
          0.06         564.08      428809.34           0.45
5390215       21301415           0.04         704.25     1883405.47
       0.09
                             -----------
                             sysctl_lock         504903
[<000000003894310e>] proc_sys_permission+0x88/0xe0
                             sysctl_lock         288674
[<00000000824e71e4>] proc_sys_permission+0x43/0xe0
                             sysctl_lock         165956
[<0000000097dd1ac9>] proc_sys_compare+0x5a/0xc0
                             -----------
                             sysctl_lock         612689
[<00000000824e71e4>] proc_sys_permission+0x43/0xe0
                             sysctl_lock         229185
[<000000003894310e>] proc_sys_permission+0x88/0xe0
                             sysctl_lock         117659
[<0000000097dd1ac9>] proc_sys_compare+0x5a/0xc0

.............................................................................................................................................................................................................................

                                   key#9:        129050         129076
          0.06          24.89       46463.88           0.36
8406664       10650710           0.17         243.33     3314905.24
       0.31
                                   -----
                                   key#9         129076
[<000000003d1d6559>] __percpu_counter_sum+0xc/0x70
                                   -----
                                   key#9         129076
[<000000003d1d6559>] __percpu_counter_sum+0xc/0x70

.............................................................................................................................................................................................................................

                           &sbi->fs_lock:         84490          84572
          0.07         105.87       30626.76           0.36
3679250        4260272           0.22         262.79     1380049.79
       0.32
                           -------------
                           &sbi->fs_lock          84572
[<00000000892170e2>] autofs_d_manage+0x131/0x180 [autofs4]
                           -------------
                           &sbi->fs_lock          84572
[<00000000892170e2>] autofs_d_manage+0x131/0x180 [autofs4]

.............................................................................................................................................................................................................................

                           &sbi->fs_lock:         84490          84572
          0.07         105.87       30626.76           0.36
3679250        4260272           0.22         262.79     1380049.79
       0.32
                           -------------
                           &sbi->fs_lock          84572
[<00000000892170e2>] autofs_d_manage+0x131/0x180 [autofs4]
                           -------------
                           &sbi->fs_lock          84572
[<00000000892170e2>] autofs_d_manage+0x131/0x180 [autofs4]

.............................................................................................................................................................................................................................

                                   key#1:         20226          20253
          0.13           6.05       11867.42           0.59
290374         444723           0.04           8.89       54524.68
      0.12
                                   key#1:         13800          13807
          0.06          17.65        3355.74           0.24
1706485        2133314           0.13          41.81      582531.55
       0.27
                                   -----
                                   key#1          13807
[<000000003d1d6559>] __percpu_counter_sum+0xc/0x70
                                   -----
                                   key#1          13807
[<000000003d1d6559>] __percpu_counter_sum+0xc/0x70

.............................................................................................................................................................................................................................

                                   key#1:         10807          10810
          0.06          29.43        2734.23           0.25
1706470        2130177           0.16          60.15      509922.56
       0.24
                                   -----
                                   key#1          10810
[<000000003d1d6559>] __percpu_counter_sum+0xc/0x70
                                   -----
                                   key#1          10810
[<000000003d1d6559>] __percpu_counter_sum+0xc/0x70

.............................................................................................................................................................................................................................

                                   key#1:         10070          10072
          0.05          12.74        2451.46           0.24
1706475        2130411           0.13          18.58      600087.26
       0.28
                                   -----
                                   key#1          10072
[<000000003d1d6559>] __percpu_counter_sum+0xc/0x70
                                   -----
                                   key#1          10072
[<000000003d1d6559>] __percpu_counter_sum+0xc/0x70

.............................................................................................................................................................................................................................

              &sb->s_type->i_mutex_key#1:          9330           9357
          0.08         674.82       10029.38           1.07
565340        1065074           0.17         468.85      546956.77
      0.51
              --------------------------
              &sb->s_type->i_mutex_key#1           4052
[<0000000054b2779b>] configfs_dir_close+0x25/0xb0 [configfs]
              &sb->s_type->i_mutex_key#1           5305
[<00000000277d0929>] configfs_dir_open+0x2e/0xa0 [configfs]
              --------------------------
              &sb->s_type->i_mutex_key#1           8218
[<00000000277d0929>] configfs_dir_open+0x2e/0xa0 [configfs]
              &sb->s_type->i_mutex_key#1           1139
[<0000000054b2779b>] configfs_dir_close+0x25/0xb0 [configfs]

.............................................................................................................................................................................................................................

                    &sbinfo->stat_lock#2:          9099           9105
          0.06          73.97        2843.24           0.31
1694004        2130138           0.04          79.57      172592.98
       0.08
                    --------------------
                    &sbinfo->stat_lock#2           9105
[<0000000063446d75>] hugetlbfs_statfs+0x7f/0xf0
                    --------------------
                    &sbinfo->stat_lock#2           9105
[<0000000063446d75>] hugetlbfs_statfs+0x7f/0xf0





> Below is completely untested, just to see if it would affect the sysinfo
> side of things (both with and without dcache series - it's independent
> from that):
>
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 8b2bd65d70e7..2784ac117a1f 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -383,11 +383,13 @@ static int kernfs_link_sibling(struct kernfs_node
> *kn)
>  	rb_insert_color(&kn->rb, &kn->parent->dir.children);
>
>  	/* successfully added, account subdir number */
> -	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
> +	mutex_lock(&kernfs_root(kn)->kernfs_iattr_lock);
> +	write_seqcount_begin(&kernfs_root(kn)->kernfs_iattr_seq);
>  	if (kernfs_type(kn) == KERNFS_DIR)
>  		kn->parent->dir.subdirs++;
>  	kernfs_inc_rev(kn->parent);
> -	up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
> +	write_seqcount_end(&kernfs_root(kn)->kernfs_iattr_seq);
> +	mutex_unlock(&kernfs_root(kn)->kernfs_iattr_lock);
>
>  	return 0;
>  }
> @@ -410,11 +412,12 @@ static bool kernfs_unlink_sibling(struct kernfs_node
> *kn)
>  	if (RB_EMPTY_NODE(&kn->rb))
>  		return false;
>
> -	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
> +	mutex_lock(&kernfs_root(kn)->kernfs_iattr_lock);
> +	write_seqcount_begin(&kernfs_root(kn)->kernfs_iattr_seq);
>  	if (kernfs_type(kn) == KERNFS_DIR)
>  		kn->parent->dir.subdirs--;
> -	kernfs_inc_rev(kn->parent);
> -	up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
> +	write_seqcount_end(&kernfs_root(kn)->kernfs_iattr_seq);
> +	mutex_unlock(&kernfs_root(kn)->kernfs_iattr_lock);
>
>  	rb_erase(&kn->rb, &kn->parent->dir.children);
>  	RB_CLEAR_NODE(&kn->rb);
> @@ -639,15 +642,11 @@ static struct kernfs_node *__kernfs_new_node(struct
> kernfs_root *root,
>  	kn->flags = flags;
>
>  	if (!uid_eq(uid, GLOBAL_ROOT_UID) || !gid_eq(gid, GLOBAL_ROOT_GID)) {
> -		struct iattr iattr = {
> -			.ia_valid = ATTR_UID | ATTR_GID,
> -			.ia_uid = uid,
> -			.ia_gid = gid,
> -		};
> -
> -		ret = __kernfs_setattr(kn, &iattr);
> -		if (ret < 0)
> +		kn->iattr = kernfs_alloc_iattrs(uid, gid);
> +		if (!kn->iattr) {
> +			ret = -ENOMEM;
>  			goto err_out3;
> +		}
>  	}
>
>  	if (parent) {
> @@ -776,7 +775,8 @@ int kernfs_add_one(struct kernfs_node *kn)
>  		goto out_unlock;
>
>  	/* Update timestamps on the parent */
> -	down_write(&root->kernfs_iattr_rwsem);
> +	mutex_lock(&root->kernfs_iattr_lock);
> +	write_seqcount_begin(&root->kernfs_iattr_seq);
>
>  	ps_iattr = parent->iattr;
>  	if (ps_iattr) {
> @@ -784,7 +784,8 @@ int kernfs_add_one(struct kernfs_node *kn)
>  		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
>  	}
>
> -	up_write(&root->kernfs_iattr_rwsem);
> +	write_seqcount_end(&root->kernfs_iattr_seq);
> +	mutex_unlock(&root->kernfs_iattr_lock);
>  	up_write(&root->kernfs_rwsem);
>
>  	/*
> @@ -949,7 +950,8 @@ struct kernfs_root *kernfs_create_root(struct
> kernfs_syscall_ops *scops,
>
>  	idr_init(&root->ino_idr);
>  	init_rwsem(&root->kernfs_rwsem);
> -	init_rwsem(&root->kernfs_iattr_rwsem);
> +	mutex_init(&root->kernfs_iattr_lock);
> +	seqcount_mutex_init(&root->kernfs_iattr_seq, &root->kernfs_iattr_lock);
>  	init_rwsem(&root->kernfs_supers_rwsem);
>  	INIT_LIST_HEAD(&root->supers);
>
> @@ -1473,14 +1475,16 @@ static void __kernfs_remove(struct kernfs_node *kn)
>  				pos->parent ? pos->parent->iattr : NULL;
>
>  			/* update timestamps on the parent */
> -			down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
> +			mutex_lock(&kernfs_root(kn)->kernfs_iattr_lock);
> +			write_seqcount_begin(&kernfs_root(kn)->kernfs_iattr_seq);
>
>  			if (ps_iattr) {
>  				ktime_get_real_ts64(&ps_iattr->ia_ctime);
>  				ps_iattr->ia_mtime = ps_iattr->ia_ctime;
>  			}
>
> -			up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
> +			write_seqcount_end(&kernfs_root(kn)->kernfs_iattr_seq);
> +			mutex_unlock(&kernfs_root(kn)->kernfs_iattr_lock);
>  			kernfs_put(pos);
>  		}
>
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index b83054da68b3..4b77931c814d 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -24,56 +24,49 @@ static const struct inode_operations kernfs_iops = {
>  	.listxattr	= kernfs_iop_listxattr,
>  };
>
> -static struct kernfs_iattrs *__kernfs_iattrs(struct kernfs_node *kn, int
> alloc)
> +struct kernfs_iattrs *kernfs_alloc_iattrs(kuid_t uid, kgid_t gid)
>  {
> -	static DEFINE_MUTEX(iattr_mutex);
> -	struct kernfs_iattrs *ret;
> +	struct kernfs_iattrs *ret = kmem_cache_zalloc(kernfs_iattrs_cache,
> GFP_KERNEL);
>
> -	mutex_lock(&iattr_mutex);
> +	if (ret) {
> +		ret->ia_uid = uid;
> +		ret->ia_gid = gid;
>
> -	if (kn->iattr || !alloc)
> -		goto out_unlock;
> +		ktime_get_real_ts64(&ret->ia_atime);
> +		ret->ia_ctime = ret->ia_mtime = ret->ia_atime;
>
> -	kn->iattr = kmem_cache_zalloc(kernfs_iattrs_cache, GFP_KERNEL);
> -	if (!kn->iattr)
> -		goto out_unlock;
> -
> -	/* assign default attributes */
> -	kn->iattr->ia_uid = GLOBAL_ROOT_UID;
> -	kn->iattr->ia_gid = GLOBAL_ROOT_GID;
> -
> -	ktime_get_real_ts64(&kn->iattr->ia_atime);
> -	kn->iattr->ia_mtime = kn->iattr->ia_atime;
> -	kn->iattr->ia_ctime = kn->iattr->ia_atime;
> -
> -	simple_xattrs_init(&kn->iattr->xattrs);
> -	atomic_set(&kn->iattr->nr_user_xattrs, 0);
> -	atomic_set(&kn->iattr->user_xattr_size, 0);
> -out_unlock:
> -	ret = kn->iattr;
> -	mutex_unlock(&iattr_mutex);
> +		simple_xattrs_init(&ret->xattrs);
> +		atomic_set(&ret->nr_user_xattrs, 0);
> +		atomic_set(&ret->user_xattr_size, 0);
> +	}
>  	return ret;
>  }
>
>  static struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
>  {
> -	return __kernfs_iattrs(kn, 1);
> +	struct kernfs_iattrs *ret = READ_ONCE(kn->iattr);
> +
> +	if (!ret) {
> +		struct kernfs_iattrs *new;
> +		new = kernfs_alloc_iattrs(GLOBAL_ROOT_UID, GLOBAL_ROOT_GID);
> +		ret = cmpxchg(&kn->iattr, NULL, new);
> +		if (likely(!ret))
> +			return new;
> +		kfree(new);
> +	}
> +	return ret;
>  }
>
>  static struct kernfs_iattrs *kernfs_iattrs_noalloc(struct kernfs_node *kn)
>  {
> -	return __kernfs_iattrs(kn, 0);
> +	return READ_ONCE(kn->iattr);
>  }
>
> -int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
> +static void __kernfs_setattr(struct kernfs_node *kn, const struct iattr
> *iattr)
>  {
> -	struct kernfs_iattrs *attrs;
> +	struct kernfs_iattrs *attrs = kernfs_iattrs_noalloc(kn);
>  	unsigned int ia_valid = iattr->ia_valid;
>
> -	attrs = kernfs_iattrs(kn);
> -	if (!attrs)
> -		return -ENOMEM;
> -
>  	if (ia_valid & ATTR_UID)
>  		attrs->ia_uid = iattr->ia_uid;
>  	if (ia_valid & ATTR_GID)
> @@ -86,7 +79,6 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct
> iattr *iattr)
>  		attrs->ia_ctime = iattr->ia_ctime;
>  	if (ia_valid & ATTR_MODE)
>  		kn->mode = iattr->ia_mode;
> -	return 0;
>  }
>
>  /**
> @@ -98,13 +90,17 @@ int __kernfs_setattr(struct kernfs_node *kn, const
> struct iattr *iattr)
>   */
>  int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
>  {
> -	int ret;
>  	struct kernfs_root *root = kernfs_root(kn);
>
> -	down_write(&root->kernfs_iattr_rwsem);
> -	ret = __kernfs_setattr(kn, iattr);
> -	up_write(&root->kernfs_iattr_rwsem);
> -	return ret;
> +	if (!kernfs_iattrs(kn))
> +		return -ENOMEM;
> +
> +	mutex_lock(&root->kernfs_iattr_lock);
> +	write_seqcount_begin(&root->kernfs_iattr_seq);
> +	__kernfs_setattr(kn, iattr);
> +	write_seqcount_end(&root->kernfs_iattr_seq);
> +	mutex_unlock(&root->kernfs_iattr_lock);
> +	return 0;
>  }
>
>  int kernfs_iop_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> @@ -117,22 +113,23 @@ int kernfs_iop_setattr(struct mnt_idmap *idmap, struct
> dentry *dentry,
>
>  	if (!kn)
>  		return -EINVAL;
> +	if (!kernfs_iattrs(kn))
> +		return -ENOMEM;
>
>  	root = kernfs_root(kn);
> -	down_write(&root->kernfs_iattr_rwsem);
> +	mutex_lock(&root->kernfs_iattr_lock);
> +	write_seqcount_begin(&root->kernfs_iattr_seq);
>  	error = setattr_prepare(&nop_mnt_idmap, dentry, iattr);
>  	if (error)
>  		goto out;
>
> -	error = __kernfs_setattr(kn, iattr);
> -	if (error)
> -		goto out;
> -
> +	__kernfs_setattr(kn, iattr);
>  	/* this ignores size changes */
>  	setattr_copy(&nop_mnt_idmap, inode, iattr);
>
>  out:
> -	up_write(&root->kernfs_iattr_rwsem);
> +	write_seqcount_end(&root->kernfs_iattr_seq);
> +	mutex_unlock(&root->kernfs_iattr_lock);
>  	return error;
>  }
>
> @@ -187,11 +184,13 @@ int kernfs_iop_getattr(struct mnt_idmap *idmap,
>  	struct inode *inode = d_inode(path->dentry);
>  	struct kernfs_node *kn = inode->i_private;
>  	struct kernfs_root *root = kernfs_root(kn);
> +	unsigned seq;
>
> -	down_read(&root->kernfs_iattr_rwsem);
> -	kernfs_refresh_inode(kn, inode);
> -	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
> -	up_read(&root->kernfs_iattr_rwsem);
> +	do {
> +		seq = read_seqcount_begin(&root->kernfs_iattr_seq);
> +		kernfs_refresh_inode(kn, inode);
> +		generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
> +	} while (read_seqcount_retry(&root->kernfs_iattr_seq, seq));
>
>  	return 0;
>  }
> @@ -276,7 +275,7 @@ int kernfs_iop_permission(struct mnt_idmap *idmap,
>  {
>  	struct kernfs_node *kn;
>  	struct kernfs_root *root;
> -	int ret;
> +	unsigned seq;
>
>  	if (mask & MAY_NOT_BLOCK)
>  		return -ECHILD;
> @@ -284,12 +283,11 @@ int kernfs_iop_permission(struct mnt_idmap *idmap,
>  	kn = inode->i_private;
>  	root = kernfs_root(kn);
>
> -	down_read(&root->kernfs_iattr_rwsem);
> -	kernfs_refresh_inode(kn, inode);
> -	ret = generic_permission(&nop_mnt_idmap, inode, mask);
> -	up_read(&root->kernfs_iattr_rwsem);
> -
> -	return ret;
> +	do {
> +		seq = read_seqcount_begin(&root->kernfs_iattr_seq);
> +		kernfs_refresh_inode(kn, inode);
> +	} while (read_seqcount_retry(&root->kernfs_iattr_seq, seq));
> +	return generic_permission(&nop_mnt_idmap, inode, mask);
>  }
>
>  int kernfs_xattr_get(struct kernfs_node *kn, const char *name,
> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> index 237f2764b941..0aea5151ed1a 100644
> --- a/fs/kernfs/kernfs-internal.h
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -47,7 +47,8 @@ struct kernfs_root {
>
>  	wait_queue_head_t	deactivate_waitq;
>  	struct rw_semaphore	kernfs_rwsem;
> -	struct rw_semaphore	kernfs_iattr_rwsem;
> +	struct mutex		kernfs_iattr_lock;
> +	seqcount_mutex_t	kernfs_iattr_seq;
>  	struct rw_semaphore	kernfs_supers_rwsem;
>  };
>
> @@ -137,7 +138,7 @@ int kernfs_iop_getattr(struct mnt_idmap *idmap,
>  		       const struct path *path, struct kstat *stat,
>  		       u32 request_mask, unsigned int query_flags);
>  ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t
> size);
> -int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);
> +struct kernfs_iattrs *kernfs_alloc_iattrs(kuid_t uid, kgid_t gid);
>
>  /*
>   * dir.c
>


-- 
Mateusz Guzik <mjguzik gmail.com>

