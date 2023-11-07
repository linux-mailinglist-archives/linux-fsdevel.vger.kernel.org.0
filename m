Return-Path: <linux-fsdevel+bounces-2295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196247E4881
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 19:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F071CB21049
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849B6358A4;
	Tue,  7 Nov 2023 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cW1VLrmH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3C8328C8
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 18:44:04 +0000 (UTC)
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EB3183
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 10:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699382643; bh=OJOi4iItoWsAThZmEXT+v+/nfoU8OY/Frl16sOjwMsU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=cW1VLrmHhlt4+37s9jl82kSyeniIfxadiDU4s1+JINA7zaACN6DCB6xyltfSehWbAvD8/PmDEY+Av+Vycs72H7xOO1AZYFIx2yR1Bej9vr4wPLi62Uzi/JGh5NHMJg+t/FyY3VoadFYi1ovzZribRc/vonUVK/1sx94XiCmYWAf9MK0hKnYNPLAJfcVoWrilhptOPdWCgoMKcSjjm6K2AVr47Qm4so9EL55XSCuARyV/YLlnJQ8Z68/RIfc257LQXPc2euAUnb6UG+5YyvsaBnlyvxklI8UxGTWVbhFpnZTRre7qQUeFssw3EssNXtdbBr7hoC4iT7YH1jFX/+JTAw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699382643; bh=WdezkqfcaQ9zdWJH2KBZNUsjqI6R3dPDmPDTC/Tkwyp=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=RLR9eqqnBq8V+ObEDL+Hlmefrc8R7exTwYRqgHbEPTAZHUKtcxU+msNU12NVylQhBBTF6+SnySnYynU9yxirju3rGuu6ZTuEv+ukcfqDijDwQgeXovtbA6f4Lt0I6+/zilndyCxml+itY85+fMnr5kH8X6js11WmukC7Wnbw3fpYE6XG2TdWmIg7D1RaS4X85KNQ0nwcSivV+EzHgTNf+I2h22o6KYyuPTFST1el44HxF6oMZ3ucg43bbCypo+MY/lKeaeF6Zr1oFSNxACMLz3lDd8VeSU1kJgCKI0F1K3VkoV82VtezwzwexYW7s6H/02Q/5BQO9NPkt9YuXQOPHA==
X-YMail-OSG: 5Lo_j2EVM1mZWA.tAkZwinBUMfS_Sq4PfUg3E04IQArCLUwCkU8kV4RzrCJaCtk
 wqW6Omg8xHq3W1Ir._0JLmFIcAsYvO.IjqvBW0BHjEbU2kHE__eeQJf5CT9T9krKSE6XtzI4S0WG
 gRwN1dDeiC__Eip1OZYrG.vq9IkiUxJEmPxBrrMKWgsMX5FfKVe.h.GBkatBCFKMPiYTd6K7S_dI
 O7NBML5Xfc7TuYAQyw3jxVdE11hwSTHBI.PrahLFWWeBMJXMoY3aDr7OORIISWQ9UPJPn1ft3tdm
 hVAOpe31M9V84231c6xetJm3d9xr29UrvRJ3ccZFNOS7bM6C831xC1zibw0qJ1SCmBkQb9dia91v
 smL5gopbs8XmFyhoUQUhKsYPr7Ax9VpzPWMgXAHjLI3WlWMx5N9tup3RDBDHRQo7yRTzmCeDNfm8
 o62R_jR7qajUU4LqJcxGjztXC1m4dgzhaBV0uZqC090jjWZ34ieQFASe2Gc6jWxZYIr9BSk5qp3R
 bk3ofVu9RNfHz3Op6UQVLY6aBAyHc5C3sUmxEn8XKxRKuKxK_9BI_EYGVA1gh6E4rtchMoOpz6VT
 6Hz68hb9MjVRm8jnORr4n5Lejr3GqquKp1y84c7VyGF5dtIAz_Ncwh_a_CvXw6Gs1aLUMds9HYkS
 z5aH3GaF2E6Evhoz7yMMdFgaxhfTrV63c6Yr56HD..4to5SJkMTnnUEAKkROuZC535PJ5AMcOJiy
 1AnYirI7eaBT7Ofs4x2mZc_f2GmtJ.M.h4Jni35IgBR0UYi29SXvsC.7ZpEcusm4gorwiRdSy7Oj
 62cvZvrdUeqQz.afDI3bsL4jAcui7pBWrxLGB61wrHQae8tawtp6zacEIkcBd13OYv6svPjBoLQB
 KxXhLoPQNlXyerdYawnstWf6wt4YiE2lD.nebetA47.AtcbqNMbbmoB6jEFBGps9A_tOYDoZIuaV
 QFapJLhzVV03XDTqWRPYLdi4Pa2yWxQoG4s0d8f1W5sO237R2JNFDmKd2CXdFfRHXTX1VqJZtA_m
 .mC4EEWkMjcEJcDCLHX6S2Z8TYRsBtf0eCmwfiO4TQJRMPQ9zFqe3FayyPKotlEWpCntQ._3PUtZ
 rJ7ACgI3L0Uc0sZ6E18fiDJTveILeVeSH8FRkQ4k1yYQBG1Wtjc4h6PU110PlyCLTsUGbZItan2i
 dcnxw0Q2pXJxn_m2W6.rT1Ed5VZhN4H3QIjT.HQ_WcxqEFksLFxwUyju8y2Pi.wAL.5DIhxDw96E
 dy75uqLd9CC0MmMwONQaud4FBV9Hixq7xkCZ_9HW3rcQzd7Uu2WT5VNN3xyKIO2.Oxa7_wWp0CmC
 q2leoocbgohkuV6rctXbBXbxsmPkF.USBYQ54XkKjqInbLxyO_vv34pEPseU2YBZNcwAkZNmzR8d
 Wso6OJV3Q20Kq3Iy7Y15t8VPtIFLtLhA5kLn9Bz0ZcZ61BTg19VQtWf9E0SxxCGzBAY9V.I3JAQL
 PNBCfizZCYvOcEDO1pGK5XMNX7vE_.U0nil8oRAATRm0qLZDnqk892FPo_uXerDE0V6ZzCQ8rqSz
 DFJUM6APR20iE2us9atf3CeQydCdyrjLwod5.AJ0c0NuNvyP9EfRI9A_etWupH6PHvYbfEPJO80y
 .3wNQRVOgByWYRwA.1YVQole.A2mh.ZZxttQPEENIBUHQ3uMIEvkH0HCgXXfBQFG1myr0K0pT2Cl
 _YfSfjkXcqBMRE.KjpNGOebE6Tu9iGCi2d_i6QnlUgpsz5Ti7bhwLsjG_4IgwXr9995.mkN4dmeJ
 SEKkcGEAkJPsVXVBg5J8Q72oiryrr2dDyRDb2ncKyvT1PeU2RAMs1LipNGbMgrAdFiHB0MUORGEY
 TrUmk217FGF64q1uv.PU00RfPsEUUumxcBHC9dhq_5vfW7k8nVzInb6hQ7F.BmY0v3fhoH4OEqbp
 Ms4mG2FOWw.tAAlmdDoh4buVqMFjTxiRDwhg4Zn3ES8Ej0aPbVJBjEPtqgsYY_E7JGHdjgZziVSN
 NccxX5GMrpcKWvOT8NdP.T3RDY1KMUOUtWufkywUpLgwbyREygmnWV.SwUwxFqh.7kriYUclOK5l
 mPX86kBDktGRJP8qrvbHQ2xtZcWfg0w0zgoYgxG.B4OJX7HJlxpK4NUZgXttRFIHjSWveC._emAP
 oXXrfM9yhopvCLdXBRjhR261_dlCsmbhZqmmp6Ga4UUOTPkUvwhLLNRo2EfT.ht6dJQkfpxRFWa.
 EAtQm89IOldwJUi4pl.1n9nYKHkzbBitn38Dv7FuJPTuuylERdlHSGZiaiBYIjiijY13HIl_xsr_
 8i04-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 77fd18a1-01b2-44d8-8c9a-474d7cbed84b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Nov 2023 18:44:03 +0000
Received: by hermes--production-bf1-5b945b6d47-6s4m5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d0eed0c4a5cdcddaae759b33e2e69648;
          Tue, 07 Nov 2023 18:43:58 +0000 (UTC)
Message-ID: <e5d0b34a-1e9a-47df-bb6e-67b53c878e4f@schaufler-ca.com>
Date: Tue, 7 Nov 2023 10:43:54 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/23] ima: Move IMA-Appraisal to LSM infrastructure
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
 Stefan Berger <stefanb@linux.ibm.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
 <20231107134012.682009-21-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231107134012.682009-21-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/2023 5:40 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Do the registration of IMA-Appraisal only functions separately from the
> rest of IMA functions, as appraisal is a separate feature not necessarily
> enabled in the kernel configuration.
>
> Reuse the same approach as for other IMA functions, move hardcoded calls
> from various places in the kernel to the LSM infrastructure. Declare the
> functions as static and register them as hook implementations in
> init_ima_appraise_lsm(), called by init_ima_lsm().
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Ackeded-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  fs/attr.c                             |  2 -
>  include/linux/ima.h                   | 55 ---------------------------
>  security/integrity/ima/ima.h          |  5 +++
>  security/integrity/ima/ima_appraise.c | 38 +++++++++++++-----
>  security/integrity/ima/ima_main.c     |  1 +
>  security/security.c                   | 13 -------
>  6 files changed, 35 insertions(+), 79 deletions(-)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index 221d2bb0a906..38841f3ebbcb 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -17,7 +17,6 @@
>  #include <linux/filelock.h>
>  #include <linux/security.h>
>  #include <linux/evm.h>
> -#include <linux/ima.h>
>  
>  #include "internal.h"
>  
> @@ -503,7 +502,6 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (!error) {
>  		fsnotify_change(dentry, ia_valid);
>  		security_inode_post_setattr(idmap, dentry, ia_valid);
> -		ima_inode_post_setattr(idmap, dentry, ia_valid);
>  		evm_inode_post_setattr(idmap, dentry, ia_valid);
>  	}
>  
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 23ae24b60ecf..0bae61a15b60 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -92,66 +92,11 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
>  
>  #ifdef CONFIG_IMA_APPRAISE
>  extern bool is_ima_appraise_enabled(void);
> -extern void ima_inode_post_setattr(struct mnt_idmap *idmap,
> -				   struct dentry *dentry, int ia_valid);
> -extern int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
> -			      const char *xattr_name, const void *xattr_value,
> -			      size_t xattr_value_len, int flags);
> -extern int ima_inode_set_acl(struct mnt_idmap *idmap,
> -			     struct dentry *dentry, const char *acl_name,
> -			     struct posix_acl *kacl);
> -static inline int ima_inode_remove_acl(struct mnt_idmap *idmap,
> -				       struct dentry *dentry,
> -				       const char *acl_name)
> -{
> -	return ima_inode_set_acl(idmap, dentry, acl_name, NULL);
> -}
> -
> -extern int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
> -				 const char *xattr_name);
>  #else
>  static inline bool is_ima_appraise_enabled(void)
>  {
>  	return 0;
>  }
> -
> -static inline void ima_inode_post_setattr(struct mnt_idmap *idmap,
> -					  struct dentry *dentry, int ia_valid)
> -{
> -	return;
> -}
> -
> -static inline int ima_inode_setxattr(struct mnt_idmap *idmap,
> -				     struct dentry *dentry,
> -				     const char *xattr_name,
> -				     const void *xattr_value,
> -				     size_t xattr_value_len,
> -				     int flags)
> -{
> -	return 0;
> -}
> -
> -static inline int ima_inode_set_acl(struct mnt_idmap *idmap,
> -				    struct dentry *dentry, const char *acl_name,
> -				    struct posix_acl *kacl)
> -{
> -
> -	return 0;
> -}
> -
> -static inline int ima_inode_removexattr(struct mnt_idmap *idmap,
> -					struct dentry *dentry,
> -					const char *xattr_name)
> -{
> -	return 0;
> -}
> -
> -static inline int ima_inode_remove_acl(struct mnt_idmap *idmap,
> -				       struct dentry *dentry,
> -				       const char *acl_name)
> -{
> -	return 0;
> -}
>  #endif /* CONFIG_IMA_APPRAISE */
>  
>  #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index c0412100023e..a27fc10f84f7 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -334,6 +334,7 @@ enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
>  				 int xattr_len);
>  int ima_read_xattr(struct dentry *dentry,
>  		   struct evm_ima_xattr_data **xattr_value, int xattr_len);
> +void __init init_ima_appraise_lsm(const struct lsm_id *lsmid);
>  
>  #else
>  static inline int ima_check_blacklist(struct integrity_iint_cache *iint,
> @@ -385,6 +386,10 @@ static inline int ima_read_xattr(struct dentry *dentry,
>  	return 0;
>  }
>  
> +static inline void __init init_ima_appraise_lsm(const struct lsm_id *lsmid)
> +{
> +}
> +
>  #endif /* CONFIG_IMA_APPRAISE */
>  
>  #ifdef CONFIG_IMA_APPRAISE_MODSIG
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 36abc84ba299..076451109637 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -636,8 +636,8 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
>   * This function is called from notify_change(), which expects the caller
>   * to lock the inode's i_mutex.
>   */
> -void ima_inode_post_setattr(struct mnt_idmap *idmap,
> -			    struct dentry *dentry, int ia_valid)
> +static void ima_inode_post_setattr(struct mnt_idmap *idmap,
> +				   struct dentry *dentry, int ia_valid)
>  {
>  	struct inode *inode = d_backing_inode(dentry);
>  	struct integrity_iint_cache *iint;
> @@ -750,9 +750,9 @@ static int validate_hash_algo(struct dentry *dentry,
>  	return -EACCES;
>  }
>  
> -int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
> -		       const char *xattr_name, const void *xattr_value,
> -		       size_t xattr_value_len, int flags)
> +static int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +			      const char *xattr_name, const void *xattr_value,
> +			      size_t xattr_value_len, int flags)
>  {
>  	const struct evm_ima_xattr_data *xvalue = xattr_value;
>  	int digsig = 0;
> @@ -781,8 +781,8 @@ int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	return result;
>  }
>  
> -int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> -		      const char *acl_name, struct posix_acl *kacl)
> +static int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> +			     const char *acl_name, struct posix_acl *kacl)
>  {
>  	if (evm_revalidate_status(acl_name))
>  		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
> @@ -790,8 +790,8 @@ int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  	return 0;
>  }
>  
> -int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
> -			  const char *xattr_name)
> +static int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +				 const char *xattr_name)
>  {
>  	int result;
>  
> @@ -803,3 +803,23 @@ int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	}
>  	return result;
>  }
> +
> +static int ima_inode_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> +				const char *acl_name)
> +{
> +	return ima_inode_set_acl(idmap, dentry, acl_name, NULL);
> +}
> +
> +static struct security_hook_list ima_appraise_hooks[] __ro_after_init = {
> +	LSM_HOOK_INIT(inode_post_setattr, ima_inode_post_setattr),
> +	LSM_HOOK_INIT(inode_setxattr, ima_inode_setxattr),
> +	LSM_HOOK_INIT(inode_set_acl, ima_inode_set_acl),
> +	LSM_HOOK_INIT(inode_removexattr, ima_inode_removexattr),
> +	LSM_HOOK_INIT(inode_remove_acl, ima_inode_remove_acl),
> +};
> +
> +void __init init_ima_appraise_lsm(const struct lsm_id *lsmid)
> +{
> +	security_add_hooks(ima_appraise_hooks, ARRAY_SIZE(ima_appraise_hooks),
> +			   lsmid);
> +}
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index f923ff5c6524..9aabbc37916c 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1161,6 +1161,7 @@ const struct lsm_id *ima_get_lsm_id(void)
>  void __init init_ima_lsm(void)
>  {
>  	security_add_hooks(ima_hooks, ARRAY_SIZE(ima_hooks), &ima_lsmid);
> +	init_ima_appraise_lsm(&ima_lsmid);
>  }
>  
>  /* Introduce a dummy function as 'ima' init method (it cannot be NULL). */
> diff --git a/security/security.c b/security/security.c
> index b2fdcbaa4b30..456f3fe74116 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -20,7 +20,6 @@
>  #include <linux/kernel_read_file.h>
>  #include <linux/lsm_hooks.h>
>  #include <linux/integrity.h>
> -#include <linux/ima.h>
>  #include <linux/evm.h>
>  #include <linux/fsnotify.h>
>  #include <linux/mman.h>
> @@ -2308,9 +2307,6 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
>  
>  	if (ret == 1)
>  		ret = cap_inode_setxattr(dentry, name, value, size, flags);
> -	if (ret)
> -		return ret;
> -	ret = ima_inode_setxattr(idmap, dentry, name, value, size, flags);
>  	if (ret)
>  		return ret;
>  	return evm_inode_setxattr(idmap, dentry, name, value, size, flags);
> @@ -2338,9 +2334,6 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
>  		return 0;
>  	ret = call_int_hook(inode_set_acl, 0, idmap, dentry, acl_name,
>  			    kacl);
> -	if (ret)
> -		return ret;
> -	ret = ima_inode_set_acl(idmap, dentry, acl_name, kacl);
>  	if (ret)
>  		return ret;
>  	return evm_inode_set_acl(idmap, dentry, acl_name, kacl);
> @@ -2401,9 +2394,6 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>  		return 0;
>  	ret = call_int_hook(inode_remove_acl, 0, idmap, dentry, acl_name);
> -	if (ret)
> -		return ret;
> -	ret = ima_inode_remove_acl(idmap, dentry, acl_name);
>  	if (ret)
>  		return ret;
>  	return evm_inode_remove_acl(idmap, dentry, acl_name);
> @@ -2503,9 +2493,6 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
>  	ret = call_int_hook(inode_removexattr, 1, idmap, dentry, name);
>  	if (ret == 1)
>  		ret = cap_inode_removexattr(idmap, dentry, name);
> -	if (ret)
> -		return ret;
> -	ret = ima_inode_removexattr(idmap, dentry, name);
>  	if (ret)
>  		return ret;
>  	return evm_inode_removexattr(idmap, dentry, name);

