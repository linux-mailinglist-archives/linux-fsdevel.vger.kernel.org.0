Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE4678F5AE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 00:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347865AbjHaWmo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 18:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjHaWmn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:42:43 -0400
Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D86E5F
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 15:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693521757; bh=gdVw/zd5XF76ZRfUz9v8zoKVTwHDpPkthJtAyuOiYKo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=oIUh00biFUS44NUZvYK76pjB31JnYhsaVkCbcusA6GZmmBIaCGed0leFsLKrmNkwtSU0bl3fT3sxCe+tahxm0FWt6X7ZUhRrwEuAzWJjUE+nHxCc9wuyOQM0TJ0JXOG6l/9IyF+vb11vvFwnhvAbJn7AhZ/+n83iW7mRpLyVW8UNTwmSquGFtKTNx/0oa2Se53dA7blI7bxGJ480FzgMCB1Ea7tDjHLKfan1N/x8FtOBOThFvx0qjtTaFHH+eypw4xc5dSjNKdshpLT+3nsfsD4yAIDqHOFx0INtDiK7Sc8hJ+A4tNIVYDSnHhkBEIct/LBcJyA818hR3TA3NSyIgA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693521757; bh=877XmXHaP4ayDZQz+cHj8er5Tty23PDK41g411OCuqb=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ouHVo8JEXMODiIdL5vhjHlRSy0BrOVALg4poXwcksaHb+dHcFiUp0H6yw0ONlF9LsAmbYOMzUeczsl/xPERWoa4E2/tV5x0g/QZYLXCYqwbG8vsJ1R5+R0ZGRNH9Ufzehd+bfL2EK6Kmn5NIVMrz3VxNyynJhtyLGUD2ZUxjgqO37oymhulaAWcnpBmokorzFKWpf98R7OI5xd0Htonpo9FNHFGY0EjJ/Dqb0NalX5olV/TrHmpUberUcqM49oEcTKS1BlxGWdzbBpqkZgvEwVQ7NyVUpTlO2Su78w1d7BIpgdz5ZsmomNm2nkGefMOlY2gMgRRRIZtYbCOzkJ/bAg==
X-YMail-OSG: Nn_j1eAVM1nuL1LGd_17wFlpFzqaB.mBUcKI7IdkAiFhyzLPWxox0TF5XZWGs5q
 lHoHDMxBDCqlQPqDad_y.5wDh_rVh0Q.C0xuijS7BN65u59PxBXRtzZQTNjBaNKYAoQ_rb28vUH5
 .QJRWieZwuCAnSlZ1Ge0oKCVEieVgYVMxkucFLj5nldoXgdKsJFbwiZI1.Je_SLiaWoz7j0_yKIU
 8hsPTPfO5QriIVXS48HvyDC972juGDK1588pUrfWnqayuqmoPoQ3hqx5DPyd7gKREUD8rapZvOky
 UWuLaSpY9N6j1j1zSzQl._61vDCLWvGB.tnphV95sOswFDeoMU_FHl35mx3H4k_7w8pO8pvRgfTj
 gOFGyLmmXhAgTA7XHw.UoSwMsGKm_uO6MTWiZywHFQNoduNNTw0tsuL9AaS9ey0befsl.LnCwHUi
 WMRAozui8WYE9BBjg6Mu9nVNwqYEPeZYSPi7GwLLTUR.MwxGQOPBsBZwbndymBBbgheHz_OD_f.k
 lngURUnrMkTtzwmKvTqrTryrX4dN89anR0.DLFw0XYF_UhFDxHs6usPwL86l_eOyVx_07VLDdfQ3
 SDNs6lD_Um3Ku3K3niJDjkEcQuobKiJrJo4YfAO_F5PYmivoLoeO7RhgwxKsQ7opFZ0g7zRtr102
 _GirA_wRZnzLsNVP7JOSn4K.kUCywTYvr3O8yoMCVkSB3DNjvHv_V_0flD9.UIYrMU7mUKKKoCs6
 aD5FsdghTErOIpXxlOos0fbZRJIwVX5Koe21PewYeIQ6Ep5_Hq_FhcBFUz26_IyJrerK9cQyX3T_
 2AxL9P3HKSgMJq5ynCrG5JiKe3PysF6t8DdhfQU.NYKp7PeqcUaJqP5xvhwiMOkq5D_CPePM4pgY
 hfMDxwmt3GcJRhV796DTuked5De0Nea10aYD2h.0adOBKDeAx82MNUaLMocTCTULMzDJAhjCVOXC
 RPfumolgH07Eeqy6_bON2KIEDXM0mHatnbtIUhHdGLLaJAdnXTLxxkE_6xOoAmZopXcHhHZ3WI6_
 MtVaiW8H7Cq3lRoQVnHt9STUZ.0ozbARYEyvfG8Pn_tCOo3YatngQux9dkIq6LsFms48auoVqj8.
 ONNuPiKYZfV9Sx1Lptq8Nw.2vQBU400mENEn9YR5T.MprKRwk_HAsxeuS0Rff2PPZmU4BYPdPN_V
 KzXkTy8juJTaGK4CB2fgZ7Qi4x3bRlJVKMHdji8p7U8OvEbztzP0EF7yUx2pcWJXLAhlbR4ypSkv
 fsetkZrEO1U7TdOqDSJYojx2RxH5q3tajuzbe9hiP7lSumy6JoOr2PlCNqXBUt6RCDwWZ_SOmJLr
 GhUZRn1ZADO8DjWbBWKf6w8UQ21fJPrQvQmSAVr4CJtV7pWalPgsxivyQxIB7nax3Z1WliuHfrI5
 2k4H9qjhh3_KiamduoZn42GAymLA0miEIbWAplgoEHQZWVCtXe0Qnxe5D7LEktIi0ZIarbKTjtEB
 SxA4JAbhfGLkRwDelxWDfXt4N30Qvo2qV9Oh.0BHS9VjT_GVeMElNnQ8IstHvEHWnfOmBpx78HFY
 Vx4oQWbCNEnwFVzwO2m9LKNRmJgswYh7x35_Hn7NI8PZSQGVoC7UdsYOjeBzAEmTzfBp7Aeue8Df
 brqF3trbo8Dc_SgY0qTS1x.1ull.R_U.H.xeQ50N18dwaoGxpKOnIMWwjYlR0iwppqV6Kh26MUq_
 T6SqsqzTL2CIuV1_HVbumDASyYlNQbU6JDIGAt7WwGd0WYAuF9.AhG04fCqB7Ff1Pv40RldolPTD
 GKjUyOCiCkFOW2Wvp7jbOUjlm3PNmn.dHPczKenTXPw._Y9v8itbc0qHpnQ4YvtDy6AbBx1tE4IF
 LAdFOqHPVVrSVR8Ow1akJUA6li4AyufG1IHhD5cEBxH_6ZjYHwuvqKuJNZ4H9dNQ2jEkLr9bvS4r
 Y_2aLG2.lAjxq8CGheBo4xcJ0kFTsVHVCngXtbYmGUGzvzGUaHzxrGV5tC6W7KqASVawmeAj.e0.
 ZhniCZhQXXu5hM7AEqFbe7P5DZtbmx1gmUSIOL08k_EACv910H1jaauHXSt.N8GKKqpLzuIRLXid
 YBnwN0I3bP7Yvp4MowCDtyjnGJ2B8Gt3pAvvlaSvweoh7886amnIdDnz1hH60Cy_P6_Pwbxk8liF
 eBIG3_M31pnsn0it3rm1NCc107dUTbcekvn6UB_OsNHGuIro2GSZrBmlVFi1hpPMNpa1fZKPrAuB
 Tc1g31eXFJpzZ5aZe2veMM7gvZgS9j9.itdMJDud5hZeHAFTofkkvPHqggUMWRQSdw0TtHyYIXMw
 D
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: bf38b2b0-ebf6-4735-b1f6-63f89ab3f714
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 31 Aug 2023 22:42:37 +0000
Received: by hermes--production-bf1-865889d799-r6v2w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9c93a46928ea8b3d9cc7c9897f825cab;
          Thu, 31 Aug 2023 22:42:32 +0000 (UTC)
Message-ID: <c28b2071-2f86-1465-708d-bb7a9c46dccf@schaufler-ca.com>
Date:   Thu, 31 Aug 2023 15:42:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 21/25] ima: Move to LSM infrastructure
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
 <20230831113803.910630-2-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230831113803.910630-2-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21763 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/31/2023 4:37 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Remove hardcoded IMA function calls (not for appraisal) from the LSM
> infrastructure, the VFS, NFS and the key subsystem.
>
> Make those functions as static (except for ima_file_check() which is
> exported, and ima_post_key_create_or_update(), which is not in ima_main.c),
> and register them as implementation of the respective hooks in the new
> function init_ima_lsm().
>
> Call init_ima_lsm() from integrity_lsm_init() (renamed from
> integrity_iintcache_init()), to make sure that the integrity subsystem is
> ready at the time IMA hooks are registered. The same will be done for EVM,
> by calling init_evm_lsm() just after init_ima_lsm().
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

It's always nice to see special cases go away.

> ---
>  fs/file_table.c                   |  2 -
>  fs/namei.c                        |  7 ---
>  fs/nfsd/vfs.c                     |  7 ---
>  fs/open.c                         |  1 -
>  include/linux/ima.h               | 94 -------------------------------
>  security/integrity/iint.c         |  7 ++-
>  security/integrity/ima/ima.h      |  6 ++
>  security/integrity/ima/ima_main.c | 63 ++++++++++++++-------
>  security/integrity/integrity.h    |  9 +++
>  security/keys/key.c               |  9 +--
>  security/security.c               | 53 +++--------------
>  11 files changed, 72 insertions(+), 186 deletions(-)
>
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 964e24120684..7b9c756a42df 100644
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
> @@ -376,7 +375,6 @@ static void __fput(struct file *file)
>  	locks_remove_file(file);
>  
>  	security_file_pre_free(file);
> -	ima_file_free(file);
>  	if (unlikely(file->f_flags & FASYNC)) {
>  		if (file->f_op->fasync)
>  			file->f_op->fasync(-1, file, 0);
> diff --git a/fs/namei.c b/fs/namei.c
> index efed0e1e93f5..a200021209c3 100644
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
> @@ -3636,8 +3635,6 @@ static int do_open(struct nameidata *nd,
>  		error = vfs_open(&nd->path, file);
>  	if (!error)
>  		error = security_file_post_open(file, op->acc_mode);
> -	if (!error)
> -		error = ima_file_check(file, op->acc_mode);
>  	if (!error && do_truncate)
>  		error = handle_truncate(idmap, file);
>  	if (unlikely(error > 0)) {
> @@ -3701,7 +3698,6 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
>  		spin_unlock(&inode->i_lock);
>  	}
>  	security_inode_post_create_tmpfile(idmap, dir, file, mode);
> -	ima_post_create_tmpfile(idmap, dir, file, mode);
>  	return 0;
>  }
>  
> @@ -4049,9 +4045,6 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>  		case 0: case S_IFREG:
>  			error = vfs_create(idmap, path.dentry->d_inode,
>  					   dentry, mode, true);
> -			if (!error)
> -				ima_post_path_mknod(idmap, &path, dentry,
> -						    mode_stripped, dev);
>  			break;
>  		case S_IFCHR: case S_IFBLK:
>  			error = vfs_mknod(idmap, path.dentry->d_inode,
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 3450bb1c8a18..94bbd7ac8b68 100644
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
> @@ -868,12 +867,6 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
>  		goto out_nfserr;
>  	}
>  
> -	host_err = ima_file_check(file, may_flags);
> -	if (host_err) {
> -		fput(file);
> -		goto out_nfserr;
> -	}
> -
>  	if (may_flags & NFSD_MAY_64BIT_COOKIE)
>  		file->f_mode |= FMODE_64BITHASH;
>  	else
> diff --git a/fs/open.c b/fs/open.c
> index 0c55c8e7f837..6825ac1d07a9 100644
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
> index 6e4d060ff378..58591b5cbdb4 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -16,26 +16,7 @@ struct linux_binprm;
>  
>  #ifdef CONFIG_IMA
>  extern enum hash_algo ima_get_current_hash_algo(void);
> -extern int ima_bprm_check(struct linux_binprm *bprm);
>  extern int ima_file_check(struct file *file, int mask);
> -extern void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> -				    struct inode *dir, struct file *file,
> -				    umode_t mode);
> -extern void ima_file_free(struct file *file);
> -extern int ima_file_mmap(struct file *file, unsigned long reqprot,
> -			 unsigned long prot, unsigned long flags);
> -int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
> -		      unsigned long prot);
> -extern int ima_load_data(enum kernel_load_data_id id, bool contents);
> -extern int ima_post_load_data(char *buf, loff_t size,
> -			      enum kernel_load_data_id id, char *description);
> -extern int ima_read_file(struct file *file, enum kernel_read_file_id id,
> -			 bool contents);
> -int ima_post_read_file(struct file *file, char *buf, loff_t size,
> -		       enum kernel_read_file_id id);
> -extern void ima_post_path_mknod(struct mnt_idmap *idmap,
> -				const struct path *dir, struct dentry *dentry,
> -				umode_t mode, unsigned int dev);
>  extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
>  extern int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size);
>  extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
> @@ -60,72 +41,11 @@ static inline enum hash_algo ima_get_current_hash_algo(void)
>  	return HASH_ALGO__LAST;
>  }
>  
> -static inline int ima_bprm_check(struct linux_binprm *bprm)
> -{
> -	return 0;
> -}
> -
>  static inline int ima_file_check(struct file *file, int mask)
>  {
>  	return 0;
>  }
>  
> -static inline void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> -					   struct inode *dir,
> -					   struct file *file,
> -					   umode_t mode)
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
> -				       const struct path *dir,
> -				       struct dentry *dentry,
> -				       umode_t mode, unsigned int dev)
> -{
> -	return;
> -}
> -
>  static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
>  {
>  	return -EOPNOTSUPP;
> @@ -176,20 +96,6 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
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
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index a462df827de2..32f0f3c5c4dd 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -167,20 +167,21 @@ static void init_once(void *foo)
>  	mutex_init(&iint->mutex);
>  }
>  
> -static int __init integrity_iintcache_init(void)
> +static int __init integrity_lsm_init(void)
>  {
>  	iint_cache =
>  	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
>  			      0, SLAB_PANIC, init_once);
> +
> +	init_ima_lsm();
>  	return 0;
>  }
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
> index f8581032e62c..0e4f882fcdce 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -188,7 +188,7 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
>   *
>   * Flag files that changed, based on i_version
>   */
> -void ima_file_free(struct file *file)
> +static void ima_file_free(struct file *file)
>  {
>  	struct inode *inode = file_inode(file);
>  	struct integrity_iint_cache *iint;
> @@ -413,8 +413,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
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
> @@ -452,8 +452,8 @@ int ima_file_mmap(struct file *file, unsigned long reqprot,
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
> @@ -511,7 +511,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
>   * On success return 0.  On integrity appraisal error, assuming the file
>   * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
>   */
> -int ima_bprm_check(struct linux_binprm *bprm)
> +static int ima_bprm_check(struct linux_binprm *bprm)
>  {
>  	int ret;
>  	u32 secid;
> @@ -673,9 +673,8 @@ EXPORT_SYMBOL_GPL(ima_inode_hash);
>   * Skip calling process_measurement(), but indicate which newly, created
>   * tmpfiles are in policy.
>   */
> -void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> -			     struct inode *dir, struct file *file,
> -			     umode_t mode)
> +static void ima_post_create_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
> +				    struct file *file, umode_t mode)
>  {
>  	struct integrity_iint_cache *iint;
>  	struct inode *inode = file_inode(file);
> @@ -710,9 +709,9 @@ void ima_post_create_tmpfile(struct mnt_idmap *idmap,
>   * Mark files created via the mknodat syscall as new, so that the
>   * file data can be written later.
>   */
> -void ima_post_path_mknod(struct mnt_idmap *idmap,
> -			 const struct path *dir, struct dentry *dentry,
> -			 umode_t mode, unsigned int dev)
> +static void __maybe_unused
> +ima_post_path_mknod(struct mnt_idmap *idmap, const struct path *dir,
> +		    struct dentry *dentry, umode_t mode, unsigned int dev)
>  {
>  	struct integrity_iint_cache *iint;
>  	struct inode *inode = dentry->d_inode;
> @@ -751,8 +750,8 @@ void ima_post_path_mknod(struct mnt_idmap *idmap,
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
> @@ -801,8 +800,8 @@ const int read_idmap[READING_MAX_ID] = {
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
> @@ -835,7 +834,7 @@ int ima_post_read_file(struct file *file, char *buf, loff_t size,
>   *
>   * For permission return 0, otherwise return -EACCES.
>   */
> -int ima_load_data(enum kernel_load_data_id id, bool contents)
> +static int ima_load_data(enum kernel_load_data_id id, bool contents)
>  {
>  	bool ima_enforce, sig_enforce;
>  
> @@ -889,9 +888,9 @@ int ima_load_data(enum kernel_load_data_id id, bool contents)
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
> @@ -1120,4 +1119,28 @@ static int __init init_ima(void)
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
> +void __init init_ima_lsm(void)
> +{
> +	security_add_hooks(ima_hooks, ARRAY_SIZE(ima_hooks), "integrity");
> +}
> +
>  late_initcall(init_ima);	/* Start IMA after the TPM is available */
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 7167a6e99bdc..7adc7d6c4f9f 100644
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
> @@ -191,6 +192,14 @@ extern struct dentry *integrity_dir;
>  
>  struct modsig;
>  
> +#ifdef CONFIG_IMA
> +void __init init_ima_lsm(void);
> +#else
> +static inline void __init init_ima_lsm(void)
> +{
> +}
> +#endif
> +
>  #ifdef CONFIG_INTEGRITY_SIGNATURE
>  
>  int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 0f9c6faf3491..2acf9fa80735 100644
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
> @@ -936,8 +935,6 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
>  
>  	security_key_post_create_or_update(keyring, key, payload, plen, flags,
>  					   true);
> -	ima_post_key_create_or_update(keyring, key, payload, plen,
> -				      flags, true);
>  
>  	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
>  
> @@ -969,13 +966,9 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
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
> index e6783c2f0c65..8c5b8ffeef92 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1098,12 +1098,7 @@ int security_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file)
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
> @@ -2793,13 +2788,8 @@ static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
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
> @@ -2828,12 +2818,7 @@ int security_mmap_addr(unsigned long addr)
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
> @@ -3163,12 +3148,7 @@ int security_kernel_module_request(char *kmod_name)
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
> @@ -3188,12 +3168,7 @@ EXPORT_SYMBOL_GPL(security_kernel_read_file);
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
> @@ -3208,12 +3183,7 @@ EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
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
> @@ -3235,13 +3205,8 @@ int security_kernel_post_load_data(char *buf, loff_t size,
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
