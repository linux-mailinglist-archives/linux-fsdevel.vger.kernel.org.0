Return-Path: <linux-fsdevel+bounces-6240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C8681532A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 23:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D231C23E89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 22:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22AA563A4;
	Fri, 15 Dec 2023 21:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZrmDA3tU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6BD563A7
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702677297; bh=ZDBaVqEmMMmd+UePX4elRzvHyFvY3QWYqChvMKrk0h4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZrmDA3tU8L9XT6EepLIetNCdF0X5PLWvR9UIuyXzQlY0IptzZECGCfjKDPUy61aJj+E76YjS2uokNunXqlodRBAbvLi9RgjyHuPRLff6CtYXQlQWmuaW9eLoFBUoi3zK8/NGWw1a03VR27QymIQRfMUSvAQlJht8Zo9HvrGSQX/KdUDkvq3N/jVT/la2W4RgC+brW5K2Oq6M/fGkaIfWul8QoOf+1ToKGG+J2oGU0ap5wC58AFVCVn8ZOPgcjEXIa3VZvUDrKY9XQEJ9C5LdY9/iEOLj2dCi3g5iNGjoqtJ2XLfanNsr3MdPz01JPzI/AYFeGtPRwlWurFvF6NZiqA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702677297; bh=c6V0tfmgj8IhN2M2KiM2CKM9dV14JG2Oxhsfem/UAMp=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=WD9lXj0+54jh9LXcQGNDRFml7MetNfCK+5KtqKQVVvQml6DFMC9M8eg1bUqsHwXXna+guZSpDWkpVMTXdtDyzjCzhsuJXDBDqk3Ihen7jqEN5xGaP1l76MhsUcfnit4eISQhE6f61/Q5ochpc9/QBssr4U1nWTlvxtrn3rNjVe5csISfbeFuOhvMdk+anB2NxjvuYj2hS2fZtASpWA69GjmbwOohiAdayTp6cxpCrSH8wFF9PcRIbiWgiru7YfLGw/YvLlDbn3ZW3+QwB9cv66J6eiTooY32rnSJ5mGPlqTDp5XS1alNqAuUeP8mM2hy5XFjz1NHft0LaWFsoDbTmQ==
X-YMail-OSG: OuJJ018VM1nIBTNa98RagZ0KjHV3CZqxbR3AKXtCbHuvDK86zGUQLOlcCuCAsMf
 62W1aBa4PwmNErLCfZMY3DVzvwET6UC7D7OqOF99NanpBOtTC3xGIXShcqKAQvN14ZzlP0.gUtiK
 OaBC9v39Sq1ZWACVBnNuUq1fSrReJL27PZmg7UV7icZlT7jotD_ie7ryzI9zvmLuF43jC6LtcaEm
 chp5LuHwRWNpGM7m7JBpT6R1HXMIq79vWGHxd6sdAeGnc7MDg5SD1bK2_TpBjzbyL450QGP8GLrn
 j_ZOOSEpABIYnfoHct7F35Eor3vuqpLTlKjaszi_BwqxajmIrL5QodXvrsWFeXQDhqgNfvHQDBUS
 YECWrnmIClm7R_iLuMfRR9MPYr8D.e2TY4e6ewySgyJN_9y5B.Q7A4O7XketYaH.p6rah0IuSxGI
 unpVzrYq_1L2tJPNm1DZR1FakWOQt35kQMQuJbCp8WCveqV3PyCC43hZDDBa59WSTg5YSxEHlnwS
 7VEbkekKxM96uB3.s7gHYwBe3ktpBdr1QxFzaZVqIFQKkBX7z3PmPggtGnFohnEdVjHLhYnrKqZ9
 t1sh20PcuipTjHiA78rwXFSntOtrf8RCiokNoA7ff7QRy_fUdA3Oz9bI5A7maDdx2._e1UX7ZO59
 QNBbk23hNYeUEd.MBL8nEPV44wIqWd81dEMKxLB2IJWtUypaNVSpulGzDfysplLuBkDdxzEr_aOH
 Vt.XW35jvIZlrZ5jDUXgyjD_f8oH1Qym3WwUK_Y61CeOd_6DkbENmsvRNdz5TqkJ3nxGGrX5LDOB
 9CzwJQKYBApaqEINqlr_P6mgRGf4n7s7l03RckfcPVZ3ceiBQixkEdSaozPgIfUuI13fRSkzAmn4
 dEOYWcXNHNEXYlvH0ttlx0swQOKBxkAl7OYrhMxJgU3yLabGViJyeT3Ayr_L9GVHNq9Hv8.RLCX8
 InuH_Hd.fBxcQayRUrr4pPOhpvHpPn8GvslUF0a0EY_ZyLSCeDg_fpWEWdZuUQnHj5vaY5oyua.C
 CMcxEZVXlNYxMMWf1tnwRc5ZTgNW_hnZCdUdM0QzqhloxF2bf8VDX3B0MtgPBNfO0L2Hebio0nae
 aTH2N2pFXdN3WlUrxwCEzE9NZbMVTwCloWmVKC_u.GfJD8bO9hzMpV6MoqUBpYfou6bsOAjvLO53
 1CXGPPhMrcfARNQvkQx8GkKr_xAKrAyTjNuXW2ZmWsDqBjyAL5hlSWDz1tNXUQdVa_Gb0I.QvV_m
 2Fxk8F5CRze6Wv9uSKe6Z4LwPwN8xFV1x7FYjU5yOGUzYLuojsBZ8khZcWLJ32sBemR37ATDec8X
 dGT.SEWpIHwPSHDRuOAPtsXNIAuxQY4coy3PsiZ1UhV1XO1264mJtIG8DNWQlwADsz_VFQbCbvfc
 HStKxoR_0MU_mOLyt3nV8XjF6.aCMCRSKs37SBHNbzccaovk_tIK76G5MFxDWOYzu3w7DBVdAnpP
 Hq04QN0F_GOCwqL7SkBZP7OAYXUh8IEnO2.jsYI1CF1fqCouhlWCkO8FlERd0Iilpgm24RY7NIvX
 IesvP2eZqN_SIdqRc2hw_msxUxBGSzsIYGblH63jUEG4WStSqmetAK2DwwV4wr9QDQ1FM6MCV7lI
 doFRsmr3OEysLyPit6vZomNI5QiMmgvfWUjNOzSiVqPbLtVoyu091o001KJBNTT0W9HYRqcJn6Uu
 8pv.5LW4W65DrFNifytGsEzSUkwiLbCJ_U7Hjk.rhY7.pCtuTRk.MeeEVORVdVMcw264BoCN.beW
 tC2c3SVZG8T1i696_P7Nl.a0aB0tEhWcva5oMq346yVyLmolxYpKaHvuQGjSixwli9D9f5ZRquAP
 mp.whJg8YPGiKG5CLSKTPIwvh94FkYs6xy9tI7NRRalrBiEa1vNKZaajZ.mozaWjaVtw3sMJVcS.
 npq_R7O.yT2xrKK3h8FxCqX852flV5W38fy0AigCroWbrtKAkxxMlOYi8xNrxsi.KiGOXP9eQBSa
 WkFhlIm9WvsbcmjKnOpguOLHWEXq2vtl2fIZEW_mlYZcYDc96YyCsx.1e0TtXNZGDI6w9uo9hMLr
 AHsJWIpUgiCj1QXb5vwZXltxhE.uQybS2N72yps16Pm0GYQjxcWQySVfmFKiJIPdRr_Kz_oKwjPz
 8yrUnLi69z.RMQAI_o1zMeJTfd9SSlRs4Rmebnup8kW0iElDdAlKMl0ewfsTN1AdRdxqzLfTRZQe
 WK09iq2i795Eo7DO.Pia5Qcq6Vzb.OfXn6b_pFCfaLvdUSy4FXvtCaOR6NB091YLpR4fr
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3dff4b64-0b75-4d7a-bd1e-048eef27f32b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 21:54:57 +0000
Received: by hermes--production-gq1-6949d6d8f9-nsbdm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 06296db93d4f494494b6d1b8f668b838;
          Fri, 15 Dec 2023 21:54:52 +0000 (UTC)
Message-ID: <5b72f32b-fdf7-4cb5-8bc4-f51940c9bf41@schaufler-ca.com>
Date: Fri, 15 Dec 2023 13:54:51 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 21/24] evm: Move to LSM infrastructure
Content-Language: en-US
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, dhowells@redhat.com,
 jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org,
 shuah@kernel.org, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231214170834.3324559-1-roberto.sassu@huaweicloud.com>
 <20231214170834.3324559-22-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231214170834.3324559-22-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21952 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/14/2023 9:08 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> As for IMA, move hardcoded EVM function calls from various places in the
> kernel to the LSM infrastructure, by introducing a new LSM named 'evm'
> (last and always enabled like 'ima'). The order in the Makefile ensures
> that 'evm' hooks are executed after 'ima' ones.
>
> Make EVM functions as static (except for evm_inode_init_security(), which
> is exported), and register them as hook implementations in init_evm_lsm().
>
> Unlike before (see commit to move IMA to the LSM infrastructure),
> evm_inode_post_setattr(), evm_inode_post_set_acl(),
> evm_inode_post_remove_acl(), and evm_inode_post_removexattr() are not
> executed for private inodes.
>
> Finally, add the LSM_ID_EVM case in lsm_list_modules_test.c
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  fs/attr.c                                     |   2 -
>  fs/posix_acl.c                                |   3 -
>  fs/xattr.c                                    |   2 -
>  include/linux/evm.h                           | 107 ----------------
>  include/uapi/linux/lsm.h                      |   1 +
>  security/integrity/evm/evm_main.c             | 115 +++++++++++++++---
>  security/security.c                           |  41 ++-----
>  .../selftests/lsm/lsm_list_modules_test.c     |   3 +
>  8 files changed, 113 insertions(+), 161 deletions(-)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index 38841f3ebbcb..b51bd7c9b4a7 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -16,7 +16,6 @@
>  #include <linux/fcntl.h>
>  #include <linux/filelock.h>
>  #include <linux/security.h>
> -#include <linux/evm.h>
>  
>  #include "internal.h"
>  
> @@ -502,7 +501,6 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (!error) {
>  		fsnotify_change(dentry, ia_valid);
>  		security_inode_post_setattr(idmap, dentry, ia_valid);
> -		evm_inode_post_setattr(idmap, dentry, ia_valid);
>  	}
>  
>  	return error;
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index e3fbe1a9f3f5..ae67479cd2b6 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -26,7 +26,6 @@
>  #include <linux/mnt_idmapping.h>
>  #include <linux/iversion.h>
>  #include <linux/security.h>
> -#include <linux/evm.h>
>  #include <linux/fsnotify.h>
>  #include <linux/filelock.h>
>  
> @@ -1138,7 +1137,6 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (!error) {
>  		fsnotify_xattr(dentry);
>  		security_inode_post_set_acl(dentry, acl_name, kacl);
> -		evm_inode_post_set_acl(dentry, acl_name, kacl);
>  	}
>  
>  out_inode_unlock:
> @@ -1247,7 +1245,6 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (!error) {
>  		fsnotify_xattr(dentry);
>  		security_inode_post_remove_acl(idmap, dentry, acl_name);
> -		evm_inode_post_remove_acl(idmap, dentry, acl_name);
>  	}
>  
>  out_inode_unlock:
> diff --git a/fs/xattr.c b/fs/xattr.c
> index f891c260a971..f8b643f91a98 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -16,7 +16,6 @@
>  #include <linux/mount.h>
>  #include <linux/namei.h>
>  #include <linux/security.h>
> -#include <linux/evm.h>
>  #include <linux/syscalls.h>
>  #include <linux/export.h>
>  #include <linux/fsnotify.h>
> @@ -557,7 +556,6 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
>  
>  	fsnotify_xattr(dentry);
>  	security_inode_post_removexattr(dentry, name);
> -	evm_inode_post_removexattr(dentry, name);
>  
>  out:
>  	return error;
> diff --git a/include/linux/evm.h b/include/linux/evm.h
> index 437d4076a3b3..cb481eccc967 100644
> --- a/include/linux/evm.h
> +++ b/include/linux/evm.h
> @@ -21,44 +21,6 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
>  					     void *xattr_value,
>  					     size_t xattr_value_len,
>  					     struct integrity_iint_cache *iint);
> -extern int evm_inode_setattr(struct mnt_idmap *idmap,
> -			     struct dentry *dentry, struct iattr *attr);
> -extern void evm_inode_post_setattr(struct mnt_idmap *idmap,
> -				   struct dentry *dentry, int ia_valid);
> -extern int evm_inode_setxattr(struct mnt_idmap *idmap,
> -			      struct dentry *dentry, const char *name,
> -			      const void *value, size_t size, int flags);
> -extern void evm_inode_post_setxattr(struct dentry *dentry,
> -				    const char *xattr_name,
> -				    const void *xattr_value,
> -				    size_t xattr_value_len,
> -				    int flags);
> -extern int evm_inode_removexattr(struct mnt_idmap *idmap,
> -				 struct dentry *dentry, const char *xattr_name);
> -extern void evm_inode_post_removexattr(struct dentry *dentry,
> -				       const char *xattr_name);
> -static inline void evm_inode_post_remove_acl(struct mnt_idmap *idmap,
> -					     struct dentry *dentry,
> -					     const char *acl_name)
> -{
> -	evm_inode_post_removexattr(dentry, acl_name);
> -}
> -extern int evm_inode_set_acl(struct mnt_idmap *idmap,
> -			     struct dentry *dentry, const char *acl_name,
> -			     struct posix_acl *kacl);
> -static inline int evm_inode_remove_acl(struct mnt_idmap *idmap,
> -				       struct dentry *dentry,
> -				       const char *acl_name)
> -{
> -	return evm_inode_set_acl(idmap, dentry, acl_name, NULL);
> -}
> -static inline void evm_inode_post_set_acl(struct dentry *dentry,
> -					  const char *acl_name,
> -					  struct posix_acl *kacl)
> -{
> -	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0, 0);
> -}
> -
>  int evm_inode_init_security(struct inode *inode, struct inode *dir,
>  			    const struct qstr *qstr, struct xattr *xattrs,
>  			    int *xattr_count);
> @@ -93,75 +55,6 @@ static inline enum integrity_status evm_verifyxattr(struct dentry *dentry,
>  }
>  #endif
>  
> -static inline int evm_inode_setattr(struct mnt_idmap *idmap,
> -				    struct dentry *dentry, struct iattr *attr)
> -{
> -	return 0;
> -}
> -
> -static inline void evm_inode_post_setattr(struct mnt_idmap *idmap,
> -					  struct dentry *dentry, int ia_valid)
> -{
> -	return;
> -}
> -
> -static inline int evm_inode_setxattr(struct mnt_idmap *idmap,
> -				     struct dentry *dentry, const char *name,
> -				     const void *value, size_t size, int flags)
> -{
> -	return 0;
> -}
> -
> -static inline void evm_inode_post_setxattr(struct dentry *dentry,
> -					   const char *xattr_name,
> -					   const void *xattr_value,
> -					   size_t xattr_value_len,
> -					   int flags)
> -{
> -	return;
> -}
> -
> -static inline int evm_inode_removexattr(struct mnt_idmap *idmap,
> -					struct dentry *dentry,
> -					const char *xattr_name)
> -{
> -	return 0;
> -}
> -
> -static inline void evm_inode_post_removexattr(struct dentry *dentry,
> -					      const char *xattr_name)
> -{
> -	return;
> -}
> -
> -static inline void evm_inode_post_remove_acl(struct mnt_idmap *idmap,
> -					     struct dentry *dentry,
> -					     const char *acl_name)
> -{
> -	return;
> -}
> -
> -static inline int evm_inode_set_acl(struct mnt_idmap *idmap,
> -				    struct dentry *dentry, const char *acl_name,
> -				    struct posix_acl *kacl)
> -{
> -	return 0;
> -}
> -
> -static inline int evm_inode_remove_acl(struct mnt_idmap *idmap,
> -				       struct dentry *dentry,
> -				       const char *acl_name)
> -{
> -	return 0;
> -}
> -
> -static inline void evm_inode_post_set_acl(struct dentry *dentry,
> -					  const char *acl_name,
> -					  struct posix_acl *kacl)
> -{
> -	return;
> -}
> -
>  static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
>  					  const struct qstr *qstr,
>  					  struct xattr *xattrs,
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index ee7d034255a9..825339bcd580 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -62,6 +62,7 @@ struct lsm_ctx {
>  #define LSM_ID_BPF		109
>  #define LSM_ID_LANDLOCK		110
>  #define LSM_ID_IMA		111
> +#define LSM_ID_EVM		112
>  
>  /*
>   * LSM_ATTR_XXX definitions identify different LSM attributes
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index ea84a6f835ff..0cd014bfc093 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -566,9 +566,9 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
>   * userspace from writing HMAC value.  Writing 'security.evm' requires
>   * requires CAP_SYS_ADMIN privileges.
>   */
> -int evm_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
> -		       const char *xattr_name, const void *xattr_value,
> -		       size_t xattr_value_len, int flags)
> +static int evm_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +			      const char *xattr_name, const void *xattr_value,
> +			      size_t xattr_value_len, int flags)
>  {
>  	const struct evm_ima_xattr_data *xattr_data = xattr_value;
>  
> @@ -598,8 +598,8 @@ int evm_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   * Removing 'security.evm' requires CAP_SYS_ADMIN privileges and that
>   * the current value is valid.
>   */
> -int evm_inode_removexattr(struct mnt_idmap *idmap,
> -			  struct dentry *dentry, const char *xattr_name)
> +static int evm_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +				 const char *xattr_name)
>  {
>  	/* Policy permits modification of the protected xattrs even though
>  	 * there's no HMAC key loaded
> @@ -649,9 +649,11 @@ static inline int evm_inode_set_acl_change(struct mnt_idmap *idmap,
>   * Prevent modifying posix acls causing the EVM HMAC to be re-calculated
>   * and 'security.evm' xattr updated, unless the existing 'security.evm' is
>   * valid.
> + *
> + * Return: zero on success, -EPERM on failure.
>   */
> -int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> -		      const char *acl_name, struct posix_acl *kacl)
> +static int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> +			     const char *acl_name, struct posix_acl *kacl)
>  {
>  	enum integrity_status evm_status;
>  
> @@ -690,6 +692,24 @@ int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  	return -EPERM;
>  }
>  
> +/**
> + * evm_inode_remove_acl - Protect the EVM extended attribute from posix acls
> + * @idmap: idmap of the mount
> + * @dentry: pointer to the affected dentry
> + * @acl_name: name of the posix acl
> + *
> + * Prevent removing posix acls causing the EVM HMAC to be re-calculated
> + * and 'security.evm' xattr updated, unless the existing 'security.evm' is
> + * valid.
> + *
> + * Return: zero on success, -EPERM on failure.
> + */
> +static int evm_inode_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> +				const char *acl_name)
> +{
> +	return evm_inode_set_acl(idmap, dentry, acl_name, NULL);
> +}
> +
>  static void evm_reset_status(struct inode *inode)
>  {
>  	struct integrity_iint_cache *iint;
> @@ -738,9 +758,11 @@ bool evm_revalidate_status(const char *xattr_name)
>   * __vfs_setxattr_noperm().  The caller of which has taken the inode's
>   * i_mutex lock.
>   */
> -void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
> -			     const void *xattr_value, size_t xattr_value_len,
> -			     int flags)
> +static void evm_inode_post_setxattr(struct dentry *dentry,
> +				    const char *xattr_name,
> +				    const void *xattr_value,
> +				    size_t xattr_value_len,
> +				    int flags)
>  {
>  	if (!evm_revalidate_status(xattr_name))
>  		return;
> @@ -756,6 +778,21 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
>  	evm_update_evmxattr(dentry, xattr_name, xattr_value, xattr_value_len);
>  }
>  
> +/**
> + * evm_inode_post_set_acl - Update the EVM extended attribute from posix acls
> + * @dentry: pointer to the affected dentry
> + * @acl_name: name of the posix acl
> + * @kacl: pointer to the posix acls
> + *
> + * Update the 'security.evm' xattr with the EVM HMAC re-calculated after setting
> + * posix acls.
> + */
> +static void evm_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
> +				   struct posix_acl *kacl)
> +{
> +	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0, 0);
> +}
> +
>  /**
>   * evm_inode_post_removexattr - update 'security.evm' after removing the xattr
>   * @dentry: pointer to the affected dentry
> @@ -766,7 +803,8 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
>   * No need to take the i_mutex lock here, as this function is called from
>   * vfs_removexattr() which takes the i_mutex.
>   */
> -void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
> +static void evm_inode_post_removexattr(struct dentry *dentry,
> +				       const char *xattr_name)
>  {
>  	if (!evm_revalidate_status(xattr_name))
>  		return;
> @@ -782,6 +820,22 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
>  	evm_update_evmxattr(dentry, xattr_name, NULL, 0);
>  }
>  
> +/**
> + * evm_inode_post_remove_acl - Update the EVM extended attribute from posix acls
> + * @idmap: idmap of the mount
> + * @dentry: pointer to the affected dentry
> + * @acl_name: name of the posix acl
> + *
> + * Update the 'security.evm' xattr with the EVM HMAC re-calculated after
> + * removing posix acls.
> + */
> +static inline void evm_inode_post_remove_acl(struct mnt_idmap *idmap,
> +					     struct dentry *dentry,
> +					     const char *acl_name)
> +{
> +	evm_inode_post_removexattr(dentry, acl_name);
> +}
> +
>  static int evm_attr_change(struct mnt_idmap *idmap,
>  			   struct dentry *dentry, struct iattr *attr)
>  {
> @@ -805,8 +859,8 @@ static int evm_attr_change(struct mnt_idmap *idmap,
>   * Permit update of file attributes when files have a valid EVM signature,
>   * except in the case of them having an immutable portable signature.
>   */
> -int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> -		      struct iattr *attr)
> +static int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +			     struct iattr *attr)
>  {
>  	unsigned int ia_valid = attr->ia_valid;
>  	enum integrity_status evm_status;
> @@ -853,8 +907,8 @@ int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   * This function is called from notify_change(), which expects the caller
>   * to lock the inode's i_mutex.
>   */
> -void evm_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> -			    int ia_valid)
> +static void evm_inode_post_setattr(struct mnt_idmap *idmap,
> +				   struct dentry *dentry, int ia_valid)
>  {
>  	if (!evm_revalidate_status(NULL))
>  		return;
> @@ -964,4 +1018,35 @@ static int __init init_evm(void)
>  	return error;
>  }
>  
> +static struct security_hook_list evm_hooks[] __ro_after_init = {
> +	LSM_HOOK_INIT(inode_setattr, evm_inode_setattr),
> +	LSM_HOOK_INIT(inode_post_setattr, evm_inode_post_setattr),
> +	LSM_HOOK_INIT(inode_setxattr, evm_inode_setxattr),
> +	LSM_HOOK_INIT(inode_set_acl, evm_inode_set_acl),
> +	LSM_HOOK_INIT(inode_post_set_acl, evm_inode_post_set_acl),
> +	LSM_HOOK_INIT(inode_remove_acl, evm_inode_remove_acl),
> +	LSM_HOOK_INIT(inode_post_remove_acl, evm_inode_post_remove_acl),
> +	LSM_HOOK_INIT(inode_post_setxattr, evm_inode_post_setxattr),
> +	LSM_HOOK_INIT(inode_removexattr, evm_inode_removexattr),
> +	LSM_HOOK_INIT(inode_post_removexattr, evm_inode_post_removexattr),
> +	LSM_HOOK_INIT(inode_init_security, evm_inode_init_security),
> +};
> +
> +static const struct lsm_id evm_lsmid = {
> +	.name = "evm",
> +	.id = LSM_ID_EVM,
> +};
> +
> +static int __init init_evm_lsm(void)
> +{
> +	security_add_hooks(evm_hooks, ARRAY_SIZE(evm_hooks), &evm_lsmid);
> +	return 0;
> +}
> +
> +DEFINE_LSM(evm) = {
> +	.name = "evm",
> +	.init = init_evm_lsm,
> +	.order = LSM_ORDER_LAST,
> +};
> +
>  late_initcall(init_evm);
> diff --git a/security/security.c b/security/security.c
> index d4ead59fb91f..18a70aa707ad 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -20,13 +20,13 @@
>  #include <linux/kernel_read_file.h>
>  #include <linux/lsm_hooks.h>
>  #include <linux/integrity.h>
> -#include <linux/evm.h>
>  #include <linux/fsnotify.h>
>  #include <linux/mman.h>
>  #include <linux/mount.h>
>  #include <linux/personality.h>
>  #include <linux/backing-dev.h>
>  #include <linux/string.h>
> +#include <linux/xattr.h>
>  #include <linux/msg.h>
>  #include <net/flow.h>
>  
> @@ -50,7 +50,8 @@
>  	(IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM) ? 1 : 0) + \
>  	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
>  	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0) + \
> -	(IS_ENABLED(CONFIG_IMA) ? 1 : 0))
> +	(IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_EVM) ? 1 : 0))
>  
>  /*
>   * These are descriptions of the reasons that can be passed to the
> @@ -1740,10 +1741,6 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  	if (!xattr_count)
>  		goto out;
>  
> -	ret = evm_inode_init_security(inode, dir, qstr, new_xattrs,
> -				      &xattr_count);
> -	if (ret)
> -		goto out;
>  	ret = initxattrs(inode, new_xattrs, fs_data);
>  out:
>  	for (; xattr_count > 0; xattr_count--)
> @@ -2235,14 +2232,9 @@ int security_inode_permission(struct inode *inode, int mask)
>  int security_inode_setattr(struct mnt_idmap *idmap,
>  			   struct dentry *dentry, struct iattr *attr)
>  {
> -	int ret;
> -
>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>  		return 0;
> -	ret = call_int_hook(inode_setattr, 0, idmap, dentry, attr);
> -	if (ret)
> -		return ret;
> -	return evm_inode_setattr(idmap, dentry, attr);
> +	return call_int_hook(inode_setattr, 0, idmap, dentry, attr);
>  }
>  EXPORT_SYMBOL_GPL(security_inode_setattr);
>  
> @@ -2307,9 +2299,7 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
>  
>  	if (ret == 1)
>  		ret = cap_inode_setxattr(dentry, name, value, size, flags);
> -	if (ret)
> -		return ret;
> -	return evm_inode_setxattr(idmap, dentry, name, value, size, flags);
> +	return ret;
>  }
>  
>  /**
> @@ -2328,15 +2318,10 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
>  			   struct dentry *dentry, const char *acl_name,
>  			   struct posix_acl *kacl)
>  {
> -	int ret;
> -
>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>  		return 0;
> -	ret = call_int_hook(inode_set_acl, 0, idmap, dentry, acl_name,
> -			    kacl);
> -	if (ret)
> -		return ret;
> -	return evm_inode_set_acl(idmap, dentry, acl_name, kacl);
> +	return call_int_hook(inode_set_acl, 0, idmap, dentry, acl_name,
> +			     kacl);
>  }
>  
>  /**
> @@ -2389,14 +2374,9 @@ int security_inode_get_acl(struct mnt_idmap *idmap,
>  int security_inode_remove_acl(struct mnt_idmap *idmap,
>  			      struct dentry *dentry, const char *acl_name)
>  {
> -	int ret;
> -
>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>  		return 0;
> -	ret = call_int_hook(inode_remove_acl, 0, idmap, dentry, acl_name);
> -	if (ret)
> -		return ret;
> -	return evm_inode_remove_acl(idmap, dentry, acl_name);
> +	return call_int_hook(inode_remove_acl, 0, idmap, dentry, acl_name);
>  }
>  
>  /**
> @@ -2432,7 +2412,6 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>  		return;
>  	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
> -	evm_inode_post_setxattr(dentry, name, value, size, flags);
>  }
>  
>  /**
> @@ -2493,9 +2472,7 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
>  	ret = call_int_hook(inode_removexattr, 1, idmap, dentry, name);
>  	if (ret == 1)
>  		ret = cap_inode_removexattr(idmap, dentry, name);
> -	if (ret)
> -		return ret;
> -	return evm_inode_removexattr(idmap, dentry, name);
> +	return ret;
>  }
>  
>  /**
> diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/testing/selftests/lsm/lsm_list_modules_test.c
> index 17333787cb2f..4d5d4cee2586 100644
> --- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
> +++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
> @@ -125,6 +125,9 @@ TEST(correct_lsm_list_modules)
>  		case LSM_ID_IMA:
>  			name = "ima";
>  			break;
> +		case LSM_ID_EVM:
> +			name = "evm";
> +			break;
>  		default:
>  			name = "INVALID";
>  			break;

