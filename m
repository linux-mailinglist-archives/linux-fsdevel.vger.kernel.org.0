Return-Path: <linux-fsdevel+bounces-2297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BAA7E4891
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 19:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5932028144A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E23358A4;
	Tue,  7 Nov 2023 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TRXeOiad"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B8B328C8
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 18:46:10 +0000 (UTC)
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2422813A
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 10:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699382769; bh=uoorGQ5QY+Zs8n3Pa0Vo/I2tRFZD+FkbndzlTfIYGA8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=TRXeOiadxkizd+F5le2t5VVei5OWzFuO6w/vLtHYbIm4eYcIM7TrDwyEHvRSkPdlCnGWum8sPVZULWnm6/o99un5c6Iu1mJy+OtUm9P2G6Le/ueuI+HPvg5q2Tf0IDBAQfQaemh4j+WO1yDRGdRz3DiOXOVIVMJG/l9K3lJcZwyKnspI7ylye9Duzf0pYCDFoU2Kzt2GOZtm6ynKLM5qZ3m+DklWd0lFRQ4TLf6Mtp9Qi4elYQbwq9Qy0L+pG/B04DGfsqkAa86Zgfzfv42XFtN5exhbyh0V8K7psppijG6lytvhlGCUyaxG4PV4SBVNMJcLjJ3ylNkAoF+y3oPx5g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699382769; bh=ijqYBSYZ1BvPJkGH2xNAWG8OCoxKe5LSaR7gIlMHPyb=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=o8AcknyR6Ue9Be+b1BX+n76df7jIsUvuDgAj3cGpWh4e/4PEvvaD9BNe9HZfy4lel57UJYWO2m0x273UJo+tYgaQy/I1KuV+yP0cvNYMhiUY+lSxclboHHXHs2o7qywUe3Di8RqF7KsRCmT/3ZI4J3IjqDEp/wYa3HDzPt60Owit2mvigQFDojRjU6N7aL9mbI52LcmSIrb5Z0/sfwAtKSHR9O2AffVFl226XPxY1RZtkyPJOBOIXxXQ+WvRfWjiwu704I01jz5SHpKQu+i9f5dy5c/lbx34mxutvjL/x/EgPYE5yEnotjRl02AchfVg44GhszV5S+0kuxnkY/iJTg==
X-YMail-OSG: _hnDlLoVM1nuaBBKCuhcO3HDC9_bY9w.1Txv9hds6sF15Lqbe6Vgn3xZqynidy6
 300NiIndpuM8HMW_oXFGMe3DUVI7LBNV48G6qMzOCwsX66aOf3F4dKvZeYB7pht0lC.Loh7i8buB
 5qsM93ZwLA.i.8bGM4Rb37RSI_h7PuMUQcheMysJf7aKOFcNyZE4ogmfFsSXCyKGYYCzPHmM._jY
 BIViIg1AvywQ8r57OvAMLdBGSztp3ba742B3PDG62H3_k.cqhKTuUoXAfZj0ar9wJ5e7gR7qjos8
 WM0SCBjqUFMC1cncXCTQ4hLHxHX..ojkdZHUpOAC0YN2HayvL_6Ezp8a8hG1OBOiIh9efnlpEbmv
 aiX1HQy3waSr_S_yYxc4nOcniaRW.R5A9r0mQawjKYegy3aSWf8iK52LIx7C8smIShrhfTVxMW55
 _46sVnT0ak4ZpmEldIzNZFEafdhgLja5vynAj.rwJh4IeTXMHqeVJX3_r84VIDRnFqxd7wLyS4Bz
 M.VmTdrM0zDY_zrsFBnY9Qw17gexZaUIFObElEGIDB0wX2MnpkX4MIaNRB7UIk7pMqtlVTt_zebZ
 ijOhpJUBevmjjj8bRHudh9wqu.9hd02I6WvceOrsLRedw3U5kPnU4.t4QYXljUVAE65bPfYEOlRu
 yxElT.DhBZnGHjDy9Grw.Jdk_7ppquokz1uZKiVPO5HXLGNfKPUw4.E1oMBIK4s92WwgmMUaleVA
 kNrJMD4CvMcW8lt5QJ.HED616ptcifH7ini9W_Xnl2qM28MBJEOq9wxysIzML3AMC8QLu07Xbv1t
 Ox.q4fdF68zpDJCrwftoFQOM0PJILVqXUZDLhVHLWdrWB9P1iprxAu3DN4D4T4fgHaLCCmx1AMsZ
 joOh2XcDlvFgJKukVyoN7vrKVKHgya5r54PSuu_Z1iUqrMKyC9gdrsyiLhUfZaiXmOvYfX8eag3b
 AcUpXbadxECU_e2UbffsjNnQLoi98uLjbCzFUKLk5MxXoylLAAAiqO2ygnwgAiuZMni4sMf_T75V
 hy6xSCZIGcfjFF3JG4Yb02gdv5H7_3STqAhK9KvmHf87kpxbZ.y2DzqTSJY37VxjlL1nm9sD0P3X
 qb5kMNSZWF1t1JzfK8NW1GHsq4sEXc0SdezH9qs_yROyJMGZQ.Kkl4.z7N5CNvZxuTxYnuQI6Qy3
 IM7iwWwU5c8MRPiiZWX9cBDZHIN670aVVRrhVUvRz2VD4ono7nEJ2NfMdknvIWEkUVaaXV_p32VD
 uz6.6aVtKV1g5PD_RMZdQpsWu9jX4VEyAJcgwsuN3CkD8CV5eN8RibknJ1DaNTvgo2qozO0XJ.S6
 r5mzeOtzg.4R8zNekHTsn78LajUytb5M2SCupfj5mSD4H9gyswrMtuKbUMF9FSssc7UWKIc0fOVf
 _3tWcPI39N55eZCWhiqQ5Ymo.pvreHZ.JhYoN52HnON1i3mX9lUiq1uo_oXAflQms0patSFnbEya
 val9f0PxAdvCbobEF01c4ty311520kt9017awVrf2F1Gl9B.A.q1z1jaHDcDGfsRIQ0talZ8UuUz
 x.sUzvHCRWSQoUy_Fyp2YpdVvxIF3o3S_fCfPkiE482WWphbeOSAd8Sm_M8z8w5Fb8TCDyEzuBus
 w8VsQ_d_YgnrCd0DmRCzN_w3ZAYNjNMFTzN6bI2y2Dy4uBwqxCqTTl8X.2lMPlI66iski9QGwlhB
 T4dOVsOIrgQd_xXcYa_sZAX64B49eXjG3ub1cDtWzvZL7wW_6QokE.KlMzyBc.IB9WRoQD3HGvlI
 2z.0yL_HnYkCzY0TqObqfg72Jc1mKaursDNXc9l.grjluYd4QN22y.kgfBSzEX6zoFWERJi4o0oE
 .ruxYXClP3x1eiax8FKebuZJylJYzDj6tWRJksqSHGJpcQSoIWnoq0s2M2GbIuAk0DOYrfUJUZy6
 hRPTGX2kV.v_hnkNzYnnahxfcggZEspZxG4E.2ZA1g0bDDcjCfB5spWGTaQIS359skNa6QuaabfV
 hnYMtMNGMwseqvGdT9gsAo4eMd7Vlq_RBfLj4uE1M5m3vOP05WrDTed5.JZIqixNHLXZ4MN85yeQ
 115SERlG5hpogD3hbjF3XKm07VGM2paP.zR4gXLk8DLpDe.1mNdaH5UZnLjPOh8IQu32uwRCX2Fc
 yQQTYMrTEGWpuzWrmZ_HVLPcKS_GfnlOdS73yle7G2VavIGoSCzPuCPsWUshppJALxTlYPMH4bn4
 PJBfWLW4hR32wwN1ypqdqfIvKLjlfFzzHKOCtarz6OOLHpH7uyGxmYLS44xnqkpLbifqCgfr1xw-
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0540b50e-f86b-41f0-8a07-414a236c0c05
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Nov 2023 18:46:09 +0000
Received: by hermes--production-bf1-5b945b6d47-ssgx9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7d19a690bc4ae5d9d44a502fc1633056;
          Tue, 07 Nov 2023 18:46:06 +0000 (UTC)
Message-ID: <cbd2506a-a550-45dc-9198-ac4ad4b428b8@schaufler-ca.com>
Date: Tue, 7 Nov 2023 10:46:01 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 22/23] integrity: Move integrity functions to the LSM
 infrastructure
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
 <20231107134012.682009-23-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231107134012.682009-23-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/2023 5:40 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Remove hardcoded calls to integrity functions from the LSM infrastructure
> and, instead, register them in integrity_lsm_init() with the IMA or EVM
> LSM ID (the first non-NULL returned by ima_get_lsm_id() and
> evm_get_lsm_id()).
>
> Also move the global declaration of integrity_inode_get() to
> security/integrity/integrity.h, so that the function can be still called by
> IMA.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  include/linux/integrity.h      | 26 --------------------------
>  security/integrity/iint.c      | 30 +++++++++++++++++++++++++++++-
>  security/integrity/integrity.h |  7 +++++++
>  security/security.c            |  9 +--------
>  4 files changed, 37 insertions(+), 35 deletions(-)
>
> diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> index 2ea0f2f65ab6..afaae7ad26f4 100644
> --- a/include/linux/integrity.h
> +++ b/include/linux/integrity.h
> @@ -21,38 +21,12 @@ enum integrity_status {
>  
>  /* List of EVM protected security xattrs */
>  #ifdef CONFIG_INTEGRITY
> -extern struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
> -extern void integrity_inode_free(struct inode *inode);
>  extern void __init integrity_load_keys(void);
>  
>  #else
> -static inline struct integrity_iint_cache *
> -				integrity_inode_get(struct inode *inode)
> -{
> -	return NULL;
> -}
> -
> -static inline void integrity_inode_free(struct inode *inode)
> -{
> -	return;
> -}
> -
>  static inline void integrity_load_keys(void)
>  {
>  }
>  #endif /* CONFIG_INTEGRITY */
>  
> -#ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
> -
> -extern int integrity_kernel_module_request(char *kmod_name);
> -
> -#else
> -
> -static inline int integrity_kernel_module_request(char *kmod_name)
> -{
> -	return 0;
> -}
> -
> -#endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
> -
>  #endif /* _LINUX_INTEGRITY_H */
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 0b0ac71142e8..882fde2a2607 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -171,7 +171,7 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
>   *
>   * Free the integrity information(iint) associated with an inode.
>   */
> -void integrity_inode_free(struct inode *inode)
> +static void integrity_inode_free(struct inode *inode)
>  {
>  	struct integrity_iint_cache *iint;
>  
> @@ -193,11 +193,39 @@ static void iint_init_once(void *foo)
>  	memset(iint, 0, sizeof(*iint));
>  }
>  
> +static struct security_hook_list integrity_hooks[] __ro_after_init = {
> +	LSM_HOOK_INIT(inode_free_security, integrity_inode_free),
> +#ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
> +	LSM_HOOK_INIT(kernel_module_request, integrity_kernel_module_request),
> +#endif
> +};
> +
> +/*
> + * Perform the initialization of the 'integrity', 'ima' and 'evm' LSMs to
> + * ensure that the management of integrity metadata is working at the time
> + * IMA and EVM hooks are registered to the LSM infrastructure, and to keep
> + * the original ordering of IMA and EVM functions as when they were hardcoded.
> + */
>  static int __init integrity_lsm_init(void)
>  {
> +	const struct lsm_id *lsmid;
> +
>  	iint_cache =
>  	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
>  			      0, SLAB_PANIC, iint_init_once);
> +	/*
> +	 * Obtain either the IMA or EVM LSM ID to register integrity-specific
> +	 * hooks under that LSM, since there is no LSM ID assigned to the
> +	 * 'integrity' LSM.
> +	 */
> +	lsmid = ima_get_lsm_id();
> +	if (!lsmid)
> +		lsmid = evm_get_lsm_id();
> +	/* No point in continuing, since both IMA and EVM are disabled. */
> +	if (!lsmid)
> +		return 0;
> +
> +	security_add_hooks(integrity_hooks, ARRAY_SIZE(integrity_hooks), lsmid);
>  	init_ima_lsm();
>  	init_evm_lsm();
>  	return 0;
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 7534ec06324e..e4df82d6f6e7 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -180,6 +180,7 @@ struct integrity_iint_cache {
>   * integrity data associated with an inode.
>   */
>  struct integrity_iint_cache *integrity_iint_find(struct inode *inode);
> +struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
>  
>  int integrity_kernel_read(struct file *file, loff_t offset,
>  			  void *addr, unsigned long count);
> @@ -266,12 +267,18 @@ static inline int __init integrity_load_cert(const unsigned int id,
>  #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
>  int asymmetric_verify(struct key *keyring, const char *sig,
>  		      int siglen, const char *data, int datalen);
> +int integrity_kernel_module_request(char *kmod_name);
>  #else
>  static inline int asymmetric_verify(struct key *keyring, const char *sig,
>  				    int siglen, const char *data, int datalen)
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline int integrity_kernel_module_request(char *kmod_name)
> +{
> +	return 0;
> +}
>  #endif
>  
>  #ifdef CONFIG_IMA_APPRAISE_MODSIG
> diff --git a/security/security.c b/security/security.c
> index 9703549b6ddc..0d9eaa4cd260 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -19,7 +19,6 @@
>  #include <linux/kernel.h>
>  #include <linux/kernel_read_file.h>
>  #include <linux/lsm_hooks.h>
> -#include <linux/integrity.h>
>  #include <linux/fsnotify.h>
>  #include <linux/mman.h>
>  #include <linux/mount.h>
> @@ -1597,7 +1596,6 @@ static void inode_free_by_rcu(struct rcu_head *head)
>   */
>  void security_inode_free(struct inode *inode)
>  {
> -	integrity_inode_free(inode);
>  	call_void_hook(inode_free_security, inode);
>  	/*
>  	 * The inode may still be referenced in a path walk and
> @@ -3182,12 +3180,7 @@ int security_kernel_create_files_as(struct cred *new, struct inode *inode)
>   */
>  int security_kernel_module_request(char *kmod_name)
>  {
> -	int ret;
> -
> -	ret = call_int_hook(kernel_module_request, 0, kmod_name);
> -	if (ret)
> -		return ret;
> -	return integrity_kernel_module_request(kmod_name);
> +	return call_int_hook(kernel_module_request, 0, kmod_name);
>  }
>  
>  /**

