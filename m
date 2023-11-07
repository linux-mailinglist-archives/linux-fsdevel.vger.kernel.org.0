Return-Path: <linux-fsdevel+bounces-2293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C9B7E479C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 733D6B20E1D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 17:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B107C34CEB;
	Tue,  7 Nov 2023 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fehCz+0z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEF2321B3
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 17:52:18 +0000 (UTC)
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13A2126
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 09:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699379537; bh=Imdu+uxqwSQtMIpRySHU7p+IhDUK/VxMwQOY0mw1uRI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=fehCz+0z87nT6BEaf6BtyFtxsvu5EjMM0I3hhwMj5EZY9Mg+1iDo0eeQbs0aVXvGt2/e3vJR5JlZdcAV0qp6iN6ct92n3FjvIEVrxRpO8LD0tIUO0wUwCxWI/XCensXnUXe+nyUca59Q+DXPbYARKxm9YTJX3ko2ERB6ovrpRrv3g+HpQiAm/JlhuLh+1eViEySgVHyPiBwfowEn+qw3a7/DA1a8erXn64ogyd19NIJ3nJRUye4/iUysNOOPuXsAcUa6Chl9aqRflS6wXedsk1nIYqMMUXoKnw+8ZxWrOlOx1gMGp2CJJaLYYk9OiZVfbiEdsjxtX6xZ2dU8eWM66w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699379537; bh=K43xRUeG2aToI3qvbEFnNnY19GnNRU2kFumyLjN6Gou=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=THWyKv3UHVB7aCatVACXcu4DUyXthW7VXAtjNM45du28F7nb+S5NqV7mAVUf9Aq3QwUVJz+lUor4hFoVcw56NQUTR5Lo6/5hYTt3NNa5AGfj8MJHd26VtPRQOAbrBemrqcrWOsnN/xQLdkj3G6B4OjkviN00WoXBf9noh/cJecMKP1Kcf430fHJLyiTyJ8CWiWuZwUJWB2CAdoX6zf2iPrGUZ4Q+zeB2n8+kQ9TX3CJajxLFvpGK2QlspZ2lWO4IbzWksFSNDYIzbb4nt+a2qVV3Euficdo4r2yIZaGqphH12zVeFa7pq3tlP/dE3L/8JOYY8OVEv/nY35GjmJYaTQ==
X-YMail-OSG: 3di4yL8VM1kGK_xFMVyg2u1E4GxnFIgBY2cQz3rwKK1rawNoFIrNLFXPMbuWj.j
 RueavbWOFvi648FvBCpztyiX5xuX61iJYi.e6VsgFwWXF5e6ggmzKH5bthBbztlZSC2O0uEXn.Sh
 1rTr.uqdgL2jvGCN66CS6Ju18NpdJddd_E4.7l0azFdimOLHDZbqDmHBmFJ7_ah.J8l3.Y3rIpvu
 JfnrpCq3A3azeDk5dfFXpB9jY3opY4yntmQGb8wscMheVVZwk_Y698mGxmGpwBzAGRuQ6HYNVt49
 IjJAXX3jFO089Sp0SyXGzPQ4UXSQtaNBulUepsUxk96aBGLwn4MPTReiX8inaNN6.6PrHoO7ZOXu
 3dQNiWfKYgLAzPeo9A5BLK7.bzyQlZtgy5FqQjG1Envu5rPegAOPyYoXwV4db_utVX3ZlHYvkJAp
 f7VXY_NDegeMtcBpqw5g_aYOFlB_u2zQGZi7QOXTJEXlZkbfmQcnqO6TTz.ZRpXLzoBfC1ZGZzDe
 xrGZVq67nW0SbiJtNC1A0ywLOjL2jWTSV117iHWpdCHFnpxsseE0wFFBnTtz8BO3ACpDUds.fxHi
 zVwfLdkLYUs7UgsmzSfkKbuat8NmpCwxUMTqtBYdMpYh5OiraUom6e.YgekxV2Zt8ipjw5rg68AD
 3gF1ClY5DaNpggEffmH6dWrwrSfslMVjUU7rZI.3HDDZ1aMBCIpD9rRGTVJFSKw8km8K1abLw1pC
 WAUyj85rzxDSqefot.CjTaq73jScv7Rwh5U0.rCWxbxB9X.0fTIlxPlNjSwoYiS0vWtwPCKiSnWq
 ALyeUPDTECnrFwTomjHXQ9y7qN1LzvbR4VxISHWJbTCKt5xC12QhErf31cdmYyC7xTXTnMleO3US
 T7wDANcCSg1PXVwBC3yVjx4DSjyY6ILXnEt7x_VWmA8GKzHy6BYysJ8bdQHYTIlxkKVaCZucwpaZ
 UHil7ZqDVsRIGeFXLAS2xdqRrXHgGtM0tmCnad36xaXsN3P86B5mf6YnzXelvIdXNgggx6wS6FyP
 WoGGfFRvLgRFxPhRvIqVx6Pix3zRsFhwZyCsI1A5T1iMaHz9rh7DBIA9fIL9vnZCrlMeQMndDqsm
 atY.H1Sd0WJyPP.RkmIB33Hl3MiFDWJjZoz887qXWQsgw9Oee4gKRddPb25y0dcA9bV8SxkWOtOC
 _AmHiHf_vKHsFYqLM7SQI2IDVmifLr8XQH2piTPWlvU.gNc4Zrjtl4pQD6iw1vLcng_1A7MWFYrB
 x8.2gAq3C1UtsSOSp4LbCJeXHpXZnBTJu594S71AuEA3QSud8Pmelv8oTLAOiDk_JDQTtJuvYKex
 ScVAjNniEBdMXwbO6HzQeXQjN6vKmNcFWQ06IfCe0gNGaZ9AnWSHylPOwtzuWbHVDYb6Z5ZxTMpz
 Yyw7zsrMfdukaxs8tMv_vaLaQRN.k39oGFsmlIC0GdIpnYuXo.hOGV9UiaMD2DidDsKkST0Sl6KM
 1dPhv8MEmK9bQX.Kd2i7VWL9MESpZULPq20OfXSsTNRF5dpCoyLnD82Dk1u5VAOclhlFZ90lDoSj
 Lt0cYZJnsVsGwP6LpOZCBIXT7K.FYyTatEF9qms07MCz6oRqQ6umKVJKm9NLfSJ3M0jj4PiCnESb
 9vhuj4UNTPYIKBxjPGqgpRAcaQGumCnouGdyBn3VCw2M1OkfDs1bKVZxWUCQ.IKlfcP.RjtRE4iH
 TbO_7mI5a3UgzlLsk.wYGBKseaMz5Vu.YHVWYpZ21v4aMLE0Rqt1VAi7sWQfeglnLqNEV13apcR5
 VO0Ev2cbPtsJVXDfZ0T57ic08gnZGN4tM7V5IvQEgl3St843iaFJoJphaQVWc7QJB1I3CXCqd7NQ
 Mwqhtwu6ysEJkQB8vV_HRdbrCgIoJcMRADJDWXuJkmYNOrC7xEDUhrAcujSZ1Vz1vIPx9OL6N3uD
 B6TRgYYbO7pqygHXAjOpUvm30jT_ykpkAf83BytJRIxbpogblP5Q7Hc2jVkQ7G.2k0ReCrqA.Di1
 VIPYaZYEjSG15TDWasCf0Bqj5I4L85iOgPfo0xKkt93KS.K1xTroaD4mtlUdOEojphBPWAM7fISr
 GgX.gjGPKTAS4UKB_kUrMO47hv4d7qFgq15bsjteqzbAeSUZ06qyVvUf9xMz9t5Al8JYogT5jLcA
 u7lC0gq7DDMsrhbh.MymthBFl59n_Pai9yPc_i.hoC21f9s2Pc0QSepMmtcWQp6lp1oGj.vAWBwi
 AUif3GxzkdJNTF3g1c7vfn0xf1Q2vrBQ8yWrTFv.wZ1ypGlrHz2HmcpjA10VLtnundym5u70mV8l
 Shq0-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 575956bc-f701-4e3e-9607-1b7f32739e94
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Nov 2023 17:52:17 +0000
Received: by hermes--production-ne1-56df75844-8k4lp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5e61d1e76d8bfbad6541a9ce290869b4;
          Tue, 07 Nov 2023 17:52:15 +0000 (UTC)
Message-ID: <64e8c649-c8b8-4e17-bab4-24f2e3f62137@schaufler-ca.com>
Date: Tue, 7 Nov 2023 09:52:14 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/23] ima: Move to LSM infrastructure
Content-Language: en-US
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, dhowells@redhat.com,
 jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org,
 mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
 <20231107134012.682009-20-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231107134012.682009-20-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/2023 5:40 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Move hardcoded IMA function calls (not appraisal-specific functions) from
> various places in the kernel to the LSM infrastructure, by introducing a
> new LSM named 'ima' (at the end of the LSM list and always enabled like
> 'integrity').
>
> Make moved functions as static (except ima_post_key_create_or_update(),
> which is not in ima_main.c), and register them as implementation of the
> respective hooks in the new function init_ima_lsm(). Conditionally register
> ima_post_path_mknod() if CONFIG_SECURITY_PATH is enabled, otherwise the
> path_post_mknod hook won't be available.
>
> Call init_ima_lsm() from integrity_lsm_init() (renamed from
> integrity_iintcache_init()), the init method of the 'integrity' LSM, to
> make sure that the integrity subsystem is ready at the time IMA hooks are
> registered, and to keep the original ordering of IMA and EVM functions as
> when they were hardcoded.
>
> Finally, introduce ima_get_lsm_id() to pass the IMA LSM ID back to the
> 'integrity' LSM for registration of the integrity-specific hooks.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  fs/file_table.c                   |  2 -
>  fs/namei.c                        |  6 --
>  fs/nfsd/vfs.c                     |  7 ---
>  fs/open.c                         |  1 -
>  include/linux/ima.h               | 94 -------------------------------
>  include/uapi/linux/lsm.h          |  1 +
>  security/integrity/iint.c         | 11 +++-
>  security/integrity/ima/ima.h      |  6 ++
>  security/integrity/ima/ima_main.c | 93 +++++++++++++++++++++++-------
>  security/integrity/integrity.h    | 16 ++++++
>  security/keys/key.c               |  9 +--
>  security/security.c               | 56 ++++--------------
>  12 files changed, 116 insertions(+), 186 deletions(-)
>
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 64ed74555e64..e64b0057fa72 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -26,7 +26,6 @@
>  #include <linux/percpu_counter.h>
>  #include <linux/percpu.h>
>  #include <linux/task_work.h>
> -#include <linux/ima.h>
>  #include <linux/swap.h>
>  #include <linux/kmemleak.h>
>  
> @@ -386,7 +385,6 @@ static void __fput(struct file *file)
>  	locks_remove_file(file);
>  
>  	security_file_pre_free(file);
> -	ima_file_free(file);
>  	if (unlikely(file->f_flags & FASYNC)) {
>  		if (file->f_op->fasync)
>  			file->f_op->fasync(-1, file, 0);
> diff --git a/fs/namei.c b/fs/namei.c
> index adb3ab27951a..37cc0988308f 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -27,7 +27,6 @@
>  #include <linux/fsnotify.h>
>  #include <linux/personality.h>
>  #include <linux/security.h>
> -#include <linux/ima.h>
>  #include <linux/syscalls.h>
>  #include <linux/mount.h>
>  #include <linux/audit.h>
> @@ -3622,8 +3621,6 @@ static int do_open(struct nameidata *nd,
>  		error = vfs_open(&nd->path, file);
>  	if (!error)
>  		error = security_file_post_open(file, op->acc_mode);
> -	if (!error)
> -		error = ima_file_check(file, op->acc_mode);
>  	if (!error && do_truncate)
>  		error = handle_truncate(idmap, file);
>  	if (unlikely(error > 0)) {
> @@ -3687,7 +3684,6 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
>  		spin_unlock(&inode->i_lock);
>  	}
>  	security_inode_post_create_tmpfile(idmap, inode);
> -	ima_post_create_tmpfile(idmap, inode);
>  	return 0;
>  }
>  
> @@ -4036,8 +4032,6 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>  		case 0: case S_IFREG:
>  			error = vfs_create(idmap, path.dentry->d_inode,
>  					   dentry, mode, true);
> -			if (!error)
> -				ima_post_path_mknod(idmap, dentry);
>  			break;
>  		case S_IFCHR: case S_IFBLK:
>  			error = vfs_mknod(idmap, path.dentry->d_inode,
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index b0c3f07a8bba..e491392a1243 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -25,7 +25,6 @@
>  #include <linux/posix_acl_xattr.h>
>  #include <linux/xattr.h>
>  #include <linux/jhash.h>
> -#include <linux/ima.h>
>  #include <linux/pagemap.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> @@ -883,12 +882,6 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
>  		goto out;
>  	}
>  
> -	host_err = ima_file_check(file, may_flags);
> -	if (host_err) {
> -		fput(file);
> -		goto out;
> -	}
> -
>  	if (may_flags & NFSD_MAY_64BIT_COOKIE)
>  		file->f_mode |= FMODE_64BITHASH;
>  	else
> diff --git a/fs/open.c b/fs/open.c
> index 02dc608d40d8..c8bb9bd5259f 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -29,7 +29,6 @@
>  #include <linux/audit.h>
>  #include <linux/falloc.h>
>  #include <linux/fs_struct.h>
> -#include <linux/ima.h>
>  #include <linux/dnotify.h>
>  #include <linux/compat.h>
>  #include <linux/mnt_idmapping.h>
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 31ef6c3c3207..23ae24b60ecf 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -16,24 +16,6 @@ struct linux_binprm;
>  
>  #ifdef CONFIG_IMA
>  extern enum hash_algo ima_get_current_hash_algo(void);
> -extern int ima_bprm_check(struct linux_binprm *bprm);
> -extern int ima_file_check(struct file *file, int mask);
> -extern void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> -				    struct inode *inode);
> -extern void ima_file_free(struct file *file);
> -extern int ima_file_mmap(struct file *file, unsigned long reqprot,
> -			 unsigned long prot, unsigned long flags);
> -extern int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
> -			     unsigned long prot);
> -extern int ima_load_data(enum kernel_load_data_id id, bool contents);
> -extern int ima_post_load_data(char *buf, loff_t size,
> -			      enum kernel_load_data_id id, char *description);
> -extern int ima_read_file(struct file *file, enum kernel_read_file_id id,
> -			 bool contents);
> -extern int ima_post_read_file(struct file *file, char *buf, loff_t size,
> -			      enum kernel_read_file_id id);
> -extern void ima_post_path_mknod(struct mnt_idmap *idmap,
> -				struct dentry *dentry);
>  extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
>  extern int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size);
>  extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
> @@ -58,68 +40,6 @@ static inline enum hash_algo ima_get_current_hash_algo(void)
>  	return HASH_ALGO__LAST;
>  }
>  
> -static inline int ima_bprm_check(struct linux_binprm *bprm)
> -{
> -	return 0;
> -}
> -
> -static inline int ima_file_check(struct file *file, int mask)
> -{
> -	return 0;
> -}
> -
> -static inline void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> -					   struct inode *inode)
> -{
> -}
> -
> -static inline void ima_file_free(struct file *file)
> -{
> -	return;
> -}
> -
> -static inline int ima_file_mmap(struct file *file, unsigned long reqprot,
> -				unsigned long prot, unsigned long flags)
> -{
> -	return 0;
> -}
> -
> -static inline int ima_file_mprotect(struct vm_area_struct *vma,
> -				    unsigned long reqprot, unsigned long prot)
> -{
> -	return 0;
> -}
> -
> -static inline int ima_load_data(enum kernel_load_data_id id, bool contents)
> -{
> -	return 0;
> -}
> -
> -static inline int ima_post_load_data(char *buf, loff_t size,
> -				     enum kernel_load_data_id id,
> -				     char *description)
> -{
> -	return 0;
> -}
> -
> -static inline int ima_read_file(struct file *file, enum kernel_read_file_id id,
> -				bool contents)
> -{
> -	return 0;
> -}
> -
> -static inline int ima_post_read_file(struct file *file, char *buf, loff_t size,
> -				     enum kernel_read_file_id id)
> -{
> -	return 0;
> -}
> -
> -static inline void ima_post_path_mknod(struct mnt_idmap *idmap,
> -				       struct dentry *dentry)
> -{
> -	return;
> -}
> -
>  static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
>  {
>  	return -EOPNOTSUPP;
> @@ -170,20 +90,6 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
>  {}
>  #endif
>  
> -#ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
> -extern void ima_post_key_create_or_update(struct key *keyring,
> -					  struct key *key,
> -					  const void *payload, size_t plen,
> -					  unsigned long flags, bool create);
> -#else
> -static inline void ima_post_key_create_or_update(struct key *keyring,
> -						 struct key *key,
> -						 const void *payload,
> -						 size_t plen,
> -						 unsigned long flags,
> -						 bool create) {}
> -#endif  /* CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS */
> -
>  #ifdef CONFIG_IMA_APPRAISE
>  extern bool is_ima_appraise_enabled(void);
>  extern void ima_inode_post_setattr(struct mnt_idmap *idmap,
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index f0386880a78e..ee7d034255a9 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -61,6 +61,7 @@ struct lsm_ctx {
>  #define LSM_ID_LOCKDOWN		108
>  #define LSM_ID_BPF		109
>  #define LSM_ID_LANDLOCK		110
> +#define LSM_ID_IMA		111
>  
>  /*
>   * LSM_ATTR_XXX definitions identify different LSM attributes
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index d4419a2a1e24..87f2c0d69f78 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -193,20 +193,25 @@ static void iint_init_once(void *foo)
>  	memset(iint, 0, sizeof(*iint));
>  }
>  
> -static int __init integrity_iintcache_init(void)
> +static int __init integrity_lsm_init(void)
>  {
>  	iint_cache =
>  	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
>  			      0, SLAB_PANIC, iint_init_once);
> +	init_ima_lsm();
>  	return 0;
>  }
> +
> +/*
> + * Keep it until IMA and EVM can use disjoint integrity metadata, and their
> + * initialization order can be swapped without change in their behavior.
> + */
>  DEFINE_LSM(integrity) = {
>  	.name = "integrity",
> -	.init = integrity_iintcache_init,
> +	.init = integrity_lsm_init,
>  	.order = LSM_ORDER_LAST,
>  };
>  
> -
>  /*
>   * integrity_kernel_read - read data from the file
>   *
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index c29db699c996..c0412100023e 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -127,6 +127,12 @@ void ima_load_kexec_buffer(void);
>  static inline void ima_load_kexec_buffer(void) {}
>  #endif /* CONFIG_HAVE_IMA_KEXEC */
>  
> +#ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
> +void ima_post_key_create_or_update(struct key *keyring, struct key *key,
> +				   const void *payload, size_t plen,
> +				   unsigned long flags, bool create);
> +#endif
> +
>  /*
>   * The default binary_runtime_measurements list format is defined as the
>   * platform native format.  The canonical format is defined as little-endian.
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 02021ee467d3..f923ff5c6524 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -189,7 +189,7 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
>   *
>   * Flag files that changed, based on i_version
>   */
> -void ima_file_free(struct file *file)
> +static void ima_file_free(struct file *file)
>  {
>  	struct inode *inode = file_inode(file);
>  	struct integrity_iint_cache *iint;
> @@ -427,8 +427,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
>   * On success return 0.  On integrity appraisal error, assuming the file
>   * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
>   */
> -int ima_file_mmap(struct file *file, unsigned long reqprot,
> -		  unsigned long prot, unsigned long flags)
> +static int ima_file_mmap(struct file *file, unsigned long reqprot,
> +			 unsigned long prot, unsigned long flags)
>  {
>  	u32 secid;
>  	int ret;
> @@ -466,8 +466,8 @@ int ima_file_mmap(struct file *file, unsigned long reqprot,
>   *
>   * On mprotect change success, return 0.  On failure, return -EACESS.
>   */
> -int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
> -		      unsigned long prot)
> +static int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
> +			     unsigned long prot)
>  {
>  	struct ima_template_desc *template = NULL;
>  	struct file *file;
> @@ -525,7 +525,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
>   * On success return 0.  On integrity appraisal error, assuming the file
>   * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
>   */
> -int ima_bprm_check(struct linux_binprm *bprm)
> +static int ima_bprm_check(struct linux_binprm *bprm)
>  {
>  	int ret;
>  	u32 secid;
> @@ -551,7 +551,7 @@ int ima_bprm_check(struct linux_binprm *bprm)
>   * On success return 0.  On integrity appraisal error, assuming the file
>   * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
>   */
> -int ima_file_check(struct file *file, int mask)
> +static int ima_file_check(struct file *file, int mask)
>  {
>  	u32 secid;
>  
> @@ -560,7 +560,6 @@ int ima_file_check(struct file *file, int mask)
>  				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
>  					   MAY_APPEND), FILE_CHECK);
>  }
> -EXPORT_SYMBOL_GPL(ima_file_check);
>  
>  static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
>  			    size_t buf_size)
> @@ -685,8 +684,9 @@ EXPORT_SYMBOL_GPL(ima_inode_hash);
>   * Skip calling process_measurement(), but indicate which newly, created
>   * tmpfiles are in policy.
>   */
> -void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> -			     struct inode *inode)
> +static void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> +				    struct inode *inode)
> +
>  {
>  	struct integrity_iint_cache *iint;
>  	int must_appraise;
> @@ -717,8 +717,8 @@ void ima_post_create_tmpfile(struct mnt_idmap *idmap,
>   * Mark files created via the mknodat syscall as new, so that the
>   * file data can be written later.
>   */
> -void ima_post_path_mknod(struct mnt_idmap *idmap,
> -			 struct dentry *dentry)
> +static void __maybe_unused
> +ima_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
>  {
>  	struct integrity_iint_cache *iint;
>  	struct inode *inode = dentry->d_inode;
> @@ -753,8 +753,8 @@ void ima_post_path_mknod(struct mnt_idmap *idmap,
>   *
>   * For permission return 0, otherwise return -EACCES.
>   */
> -int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
> -		  bool contents)
> +static int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
> +			 bool contents)
>  {
>  	enum ima_hooks func;
>  	u32 secid;
> @@ -803,8 +803,8 @@ const int read_idmap[READING_MAX_ID] = {
>   * On success return 0.  On integrity appraisal error, assuming the file
>   * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
>   */
> -int ima_post_read_file(struct file *file, char *buf, loff_t size,
> -		       enum kernel_read_file_id read_id)
> +static int ima_post_read_file(struct file *file, char *buf, loff_t size,
> +			      enum kernel_read_file_id read_id)
>  {
>  	enum ima_hooks func;
>  	u32 secid;
> @@ -837,7 +837,7 @@ int ima_post_read_file(struct file *file, char *buf, loff_t size,
>   *
>   * For permission return 0, otherwise return -EACCES.
>   */
> -int ima_load_data(enum kernel_load_data_id id, bool contents)
> +static int ima_load_data(enum kernel_load_data_id id, bool contents)
>  {
>  	bool ima_enforce, sig_enforce;
>  
> @@ -891,9 +891,9 @@ int ima_load_data(enum kernel_load_data_id id, bool contents)
>   * On success return 0.  On integrity appraisal error, assuming the file
>   * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
>   */
> -int ima_post_load_data(char *buf, loff_t size,
> -		       enum kernel_load_data_id load_id,
> -		       char *description)
> +static int ima_post_load_data(char *buf, loff_t size,
> +			      enum kernel_load_data_id load_id,
> +			      char *description)
>  {
>  	if (load_id == LOADING_FIRMWARE) {
>  		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
> @@ -1122,4 +1122,57 @@ static int __init init_ima(void)
>  	return error;
>  }
>  
> +static struct security_hook_list ima_hooks[] __ro_after_init = {
> +	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
> +	LSM_HOOK_INIT(file_post_open, ima_file_check),
> +	LSM_HOOK_INIT(inode_post_create_tmpfile, ima_post_create_tmpfile),
> +	LSM_HOOK_INIT(file_pre_free_security, ima_file_free),
> +	LSM_HOOK_INIT(mmap_file, ima_file_mmap),
> +	LSM_HOOK_INIT(file_mprotect, ima_file_mprotect),
> +	LSM_HOOK_INIT(kernel_load_data, ima_load_data),
> +	LSM_HOOK_INIT(kernel_post_load_data, ima_post_load_data),
> +	LSM_HOOK_INIT(kernel_read_file, ima_read_file),
> +	LSM_HOOK_INIT(kernel_post_read_file, ima_post_read_file),
> +#ifdef CONFIG_SECURITY_PATH
> +	LSM_HOOK_INIT(path_post_mknod, ima_post_path_mknod),
> +#endif
> +#ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
> +	LSM_HOOK_INIT(key_post_create_or_update, ima_post_key_create_or_update),
> +#endif
> +};
> +
> +static const struct lsm_id ima_lsmid = {
> +	.name = "ima",
> +	.id = LSM_ID_IMA,
> +};
> +
> +/* Return the IMA LSM ID, if IMA is enabled or NULL if not. */
> +const struct lsm_id *ima_get_lsm_id(void)
> +{
> +	return &ima_lsmid;
> +}
> +
> +/*
> + * Since with the LSM_ORDER_LAST there is no guarantee about the ordering
> + * within the .lsm_info.init section, ensure that IMA hooks are before EVM
> + * ones, by letting the 'integrity' LSM call init_ima_lsm() to initialize the
> + * 'ima' and 'evm' LSMs in this sequence.
> + */
> +void __init init_ima_lsm(void)
> +{
> +	security_add_hooks(ima_hooks, ARRAY_SIZE(ima_hooks), &ima_lsmid);
> +}
> +
> +/* Introduce a dummy function as 'ima' init method (it cannot be NULL). */
> +static int __init dummy_init_ima_lsm(void)
> +{
> +	return 0;
> +}
> +
> +DEFINE_LSM(ima) = {
> +	.name = "ima",
> +	.init = dummy_init_ima_lsm,
> +	.order = LSM_ORDER_LAST,
> +};
> +
>  late_initcall(init_ima);	/* Start IMA after the TPM is available */
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 9561db7cf6b4..3098cae1c27c 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -18,6 +18,7 @@
>  #include <crypto/hash.h>
>  #include <linux/key.h>
>  #include <linux/audit.h>
> +#include <linux/lsm_hooks.h>
>  
>  /* iint action cache flags */
>  #define IMA_MEASURE		0x00000001
> @@ -193,6 +194,21 @@ extern struct dentry *integrity_dir;
>  
>  struct modsig;
>  
> +#ifdef CONFIG_IMA
> +const struct lsm_id *ima_get_lsm_id(void);
> +void __init init_ima_lsm(void);
> +#else
> +static inline const struct lsm_id *ima_get_lsm_id(void)
> +{
> +	return NULL;
> +}
> +
> +static inline void __init init_ima_lsm(void)
> +{
> +}
> +
> +#endif
> +
>  #ifdef CONFIG_INTEGRITY_SIGNATURE
>  
>  int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
> diff --git a/security/keys/key.c b/security/keys/key.c
> index f75fe66c2f03..80fc2f203a0c 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -13,7 +13,6 @@
>  #include <linux/security.h>
>  #include <linux/workqueue.h>
>  #include <linux/random.h>
> -#include <linux/ima.h>
>  #include <linux/err.h>
>  #include "internal.h"
>  
> @@ -937,8 +936,6 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
>  
>  	security_key_post_create_or_update(keyring, key, payload, plen, flags,
>  					   true);
> -	ima_post_key_create_or_update(keyring, key, payload, plen,
> -				      flags, true);
>  
>  	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
>  
> @@ -970,13 +967,9 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
>  
>  	key_ref = __key_update(key_ref, &prep);
>  
> -	if (!IS_ERR(key_ref)) {
> +	if (!IS_ERR(key_ref))
>  		security_key_post_create_or_update(keyring, key, payload, plen,
>  						   flags, false);
> -		ima_post_key_create_or_update(keyring, key,
> -					      payload, plen,
> -					      flags, false);
> -	}
>  
>  	goto error_free_prep;
>  }
> diff --git a/security/security.c b/security/security.c
> index 859189722ab8..b2fdcbaa4b30 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -50,7 +50,8 @@
>  	(IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
>  	(IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM) ? 1 : 0) + \
>  	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
> -	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
> +	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_IMA) ? 1 : 0))
>  
>  /*
>   * These are descriptions of the reasons that can be passed to the
> @@ -1182,12 +1183,7 @@ int security_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *
>   */
>  int security_bprm_check(struct linux_binprm *bprm)
>  {
> -	int ret;
> -
> -	ret = call_int_hook(bprm_check_security, 0, bprm);
> -	if (ret)
> -		return ret;
> -	return ima_bprm_check(bprm);
> +	return call_int_hook(bprm_check_security, 0, bprm);
>  }
>  
>  /**
> @@ -2883,13 +2879,8 @@ static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
>  int security_mmap_file(struct file *file, unsigned long prot,
>  		       unsigned long flags)
>  {
> -	unsigned long prot_adj = mmap_prot(file, prot);
> -	int ret;
> -
> -	ret = call_int_hook(mmap_file, 0, file, prot, prot_adj, flags);
> -	if (ret)
> -		return ret;
> -	return ima_file_mmap(file, prot, prot_adj, flags);
> +	return call_int_hook(mmap_file, 0, file, prot, mmap_prot(file, prot),
> +			     flags);
>  }
>  
>  /**
> @@ -2918,12 +2909,7 @@ int security_mmap_addr(unsigned long addr)
>  int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
>  			   unsigned long prot)
>  {
> -	int ret;
> -
> -	ret = call_int_hook(file_mprotect, 0, vma, reqprot, prot);
> -	if (ret)
> -		return ret;
> -	return ima_file_mprotect(vma, reqprot, prot);
> +	return call_int_hook(file_mprotect, 0, vma, reqprot, prot);
>  }
>  
>  /**
> @@ -3253,12 +3239,7 @@ int security_kernel_module_request(char *kmod_name)
>  int security_kernel_read_file(struct file *file, enum kernel_read_file_id id,
>  			      bool contents)
>  {
> -	int ret;
> -
> -	ret = call_int_hook(kernel_read_file, 0, file, id, contents);
> -	if (ret)
> -		return ret;
> -	return ima_read_file(file, id, contents);
> +	return call_int_hook(kernel_read_file, 0, file, id, contents);
>  }
>  EXPORT_SYMBOL_GPL(security_kernel_read_file);
>  
> @@ -3278,12 +3259,7 @@ EXPORT_SYMBOL_GPL(security_kernel_read_file);
>  int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
>  				   enum kernel_read_file_id id)
>  {
> -	int ret;
> -
> -	ret = call_int_hook(kernel_post_read_file, 0, file, buf, size, id);
> -	if (ret)
> -		return ret;
> -	return ima_post_read_file(file, buf, size, id);
> +	return call_int_hook(kernel_post_read_file, 0, file, buf, size, id);
>  }
>  EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
>  
> @@ -3298,12 +3274,7 @@ EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
>   */
>  int security_kernel_load_data(enum kernel_load_data_id id, bool contents)
>  {
> -	int ret;
> -
> -	ret = call_int_hook(kernel_load_data, 0, id, contents);
> -	if (ret)
> -		return ret;
> -	return ima_load_data(id, contents);
> +	return call_int_hook(kernel_load_data, 0, id, contents);
>  }
>  EXPORT_SYMBOL_GPL(security_kernel_load_data);
>  
> @@ -3325,13 +3296,8 @@ int security_kernel_post_load_data(char *buf, loff_t size,
>  				   enum kernel_load_data_id id,
>  				   char *description)
>  {
> -	int ret;
> -
> -	ret = call_int_hook(kernel_post_load_data, 0, buf, size, id,
> -			    description);
> -	if (ret)
> -		return ret;
> -	return ima_post_load_data(buf, size, id, description);
> +	return call_int_hook(kernel_post_load_data, 0, buf, size, id,
> +			     description);
>  }
>  EXPORT_SYMBOL_GPL(security_kernel_post_load_data);
>  

