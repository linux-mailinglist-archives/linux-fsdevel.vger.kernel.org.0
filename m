Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C03778F5CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 00:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjHaWtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 18:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbjHaWtQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:49:16 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FB6110
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 15:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693522152; bh=WF8YeyvynuSPrRqM7j1wbMlf3R8d7xgYQod5fDu9ClE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qctcoRlSMUZQ+5YSDTvDu1ISZ9h36pUQ2eNJZTFWqiyqcM5Y5zrUzTJCzS0a9p3CGnAZpcQaAtNff9uHWV7ZmU0s1uE+vkn5m/NMf0fxM5LMgX+FWPLG1EisvIiGpOEs9knoTmQWgKEgnLHVpTvsdlcvaaYyRhOH0DLl4cBstfx87qepSSlOciDZ+98Mhf3ppZRXx3755aS5xPOY2XM2/ht1Zvunq0tvXGao1b4bEadaNI/8atrst4zNnV2cuq6JVnMYkzpNibWcxf+wI6+yBzFnxjMlbQfsdSqyb8QgxX0l2AL0gOeUJG80A2OqgI0QIlDxsu6JwQZTyQ9rYkIshw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693522152; bh=OihosPqitTU1YDEAGZ/7AosFwNh/kOPR7gdLOJTiBzZ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=GivFF03IHdm5fyCoS65xGvDOr63h0mJ8nt8Jh+uCCkVIljuH1MOhwlBWZ7WkC3FLNUmWctINRz/DkTsXYAHklP3K+gxbKN1rrGnTvL5pEOFBBoa/LcatXs+HHPtpHjT1E7otICE7fehbmmDqMvlmyL52y84RRjLIDWS/2Dp4TuVeC00wuICsPAT5bA3uixVlm2vwc9oMwHt90lstEW4BJOhfy1ze3EIhKCfCX0A5x/oMlai8fmElfZumVcDPJ27j6lZojwd/UMTpfmPRFXVIn99PGQM1njHXHPDcb4FSeKIBct724mgbmQD37Mk8I8IKErUrcXFt3Z+CJHhHwDhx0Q==
X-YMail-OSG: wBZLDDEVM1k4.2qgKXvSXXq_ZnLVsegtP49ba_cUVn2KJJYS3pDhoQpP0Iyrt8f
 HCke1VBdeKzFaMwrgeM8qRIafC_hnGJRNXQoEqfMmT3GYPprmVzF63gMakBntXBBfU_OIO049rQ0
 oRV6PO5NzKNDTvIVh6b62s8.OfWGIULb_WGGtTj4foX6aTbbDSV8KFFvsy1g4mLX6qXacJhXlYTX
 kRCiw9ULNPQGRNUEsdSjImRkbUtsA3tR3G6wLG_IhPT4B.LWk76jmzJvLVS_pQKrB3Py9okOv9Kp
 1tiwMPmre8fwolSqrhnBtd0U1tTJW3T7xqUslGaG20puZRaq_M5CFvx7cQuROb9mfvkcO2DFulek
 MYbOF2eKjtkdR7dyj7PBSXpj1Bm.YlscaUG4ahd9FmYCzp3sLyvCkbzDM4D_CHv9C1EqTLcht8vM
 TKUZEkFsuIPoTccm826nnYOUQW4W6tp4v2H41eVDuduB2WFcqp9Pr4cpZGgpFSzcMDPYONOcK7Yg
 1Z0g8jh_wjHOqXgQvmnoboiMb7PJAeluT1Glyz04fGUh.rZdPj_nn7NB0mlet_JIXHpI9ET31MUR
 smSDz6GrDKRgJAInqi82EhujHLX6ZtOHTbnk7w_SFeoAtavuPbrP6nLfbPYJbR_q8yifdMeEBYSC
 aXGEEyUOwv6DUFj_iDuli6_Wo.87NatEAIk9kalV8Rae9mUwmUy9Lbkivs5.Go.N1gHh.uIxdMf.
 U98hwgm2LVydzTRBNdHaCuE3RREK7WcJ9P9pQl5nROFPmfgXWurkl_f1VqoufBoEp9OTSB8NdDfp
 g9yDselRZm0tt_7Gn1dlmljZQeHRyA6QwHlFuBNXuu0IN85DVz3x0rW8wsDaeDoQAkPo7ExYtRgq
 w3X40.WcpgqwHTLMQPrja4l9BKDcKtYW5Zvc3NYP14G48bWbAMIzllKuY5Ch6LmuyCgU5HaQkEdA
 yIoDSqmZFghM72EZ00IKCg3QlJy8WF7khqs4C_Fib1.cvjpO0reGhARcMB_OaPsNZrqbLJevSS2l
 qgyfo00uTR33hHQsHOUfTQW4IPYBiZ0YcGL_lK1VVlFf8cf4wBYJfFgxh_fI0hPCPfWNA9aVmkiz
 TEUsv84ipzAPU1qfT39nzZ9Zycg7AbhzuJDVRKtSKArjYiA1Uk0EBSNE7.tdSxImFc6asmjBkk8T
 i0Dq3XJPmvxr0WVjvFM32W2YRSrEhZsb6DrGYyXySnF2GTjXDKZvoPrObeU70il6_yx6snBArynj
 It.nH5xhGSTDsWmMKNauGxeObFATN1qGtcNJF0X4rbk_LFYvmfUWnk1b.a5y1k_hubE310PdT8A1
 _gUBO05UPhFTD.1FZjRDpYVKAMjfVYm3kvT6Zzjwp0zKryP6WxR9sHAypcYcwcfcdnB7mk1m6vpd
 lZakF1f1FYxvxS0oqaKG1vq6f25MsgODEWIfzraL7PsP0sZ.IboIaMLiVhgMnotXEGNgscuArMdE
 sPsHK0oM15JsKuFjJ.mxtUJ89jS_JFthIKEsJB6LLf4XvCUYxtXzliFVZISt18lRo0Qkdw0qcmYF
 wRM_8yjaM8Z8u7.uMhYKVXzvK4RWOHEGrGlj5YcGroKrpboz4G3UmeoGwnbd6H6i57gONFr27Okl
 agQ99BHbNUgs9j_uKpMJ2LbuzIP96eIY9N2cdeqjirFty7KacPxa0CamsVyjB0tlfSBmqGNegiYk
 qLy3ZqdoPFdJrVAFEq8ftzA4Ll1lw0l2Rey0lwEspQm.sCx0bsi6U2WIoCWckMW95Jp5.C5bV.9M
 4OuD92Q1o_Ev8cW0MIwRhu9.Ogzj4oVWJ_yKsTEG5lWzOvnWnA86I2jVPwobjFHHImof2phjztdx
 IDoZu0OLj75JfMNGcvRqna40JF0mN0CkvNVzsQIR_nDD8Ljvd4fnreRmnE4bPsxUqtEYnsUVxLHO
 _L76OzGJg4ckieOw79cGKh8yJY20jhbw5utJccS1UPWKlbr8Y3CqeYLYqbfw77F9lhcL8twnrJBT
 CwK5Xf_PFkpK7oio0U2GNs.uu5JS64ViwVtLL.IhkXpEQpTdtEdROgPSJkUmZb1k1cw1bYZQbCJs
 rEFn2l3hXFXvvAyO4nxcaApPAGZ5PIfYYMet.OR08i_C2U4BqdJ5drlb47KMrfQTKH_fhJVvODKF
 eJehODjeGNX5vk0pxC7QM8YvP6qN1kTgkAx7pgeTiuXRWoojWXrRN_h18QL9VoOPAInmG11pw.fm
 4IM_o3rdI1k71mTZb7cIHrLJizHGr6b4PrLhWGpnAIJ4t3JSoB5HOdNcdX0Ww3_Le4m6k30MK_ou
 3ZuY-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4d2097d2-56b0-4f94-903c-2d71e82e9389
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 31 Aug 2023 22:49:12 +0000
Received: by hermes--production-bf1-865889d799-7x4p2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 14ec4913dc0e240f096c223b6cb58e7e;
          Thu, 31 Aug 2023 22:49:07 +0000 (UTC)
Message-ID: <4a3d17c1-40ca-6db6-2106-509f1ca28d16@schaufler-ca.com>
Date:   Thu, 31 Aug 2023 15:49:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 24/25] integrity: Move integrity functions to the LSM
 infrastructure
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
 <20230831113803.910630-5-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230831113803.910630-5-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21763 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/31/2023 4:38 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Remove hardcoded calls to integrity functions from the LSM infrastructure.
> Also move the global declaration of integrity_inode_get() to
> security/integrity/integrity.h, so that the function can be still called by
> IMA.
>
> Register integrity functions as hook implementations in
> integrity_lsm_init().
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/integrity.h      | 26 --------------------------
>  security/integrity/iint.c      | 11 ++++++++++-
>  security/integrity/integrity.h |  7 +++++++
>  security/security.c            |  9 +--------
>  4 files changed, 18 insertions(+), 35 deletions(-)
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
> index dd03f978b45c..70ee803a33ea 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -138,7 +138,7 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
>   *
>   * Free the integrity information(iint) associated with an inode.
>   */
> -void integrity_inode_free(struct inode *inode)
> +static void integrity_inode_free(struct inode *inode)
>  {
>  	struct integrity_iint_cache *iint;
>  
> @@ -167,12 +167,21 @@ static void init_once(void *foo)
>  	mutex_init(&iint->mutex);
>  }
>  
> +static struct security_hook_list integrity_hooks[] __ro_after_init = {
> +	LSM_HOOK_INIT(inode_free_security, integrity_inode_free),
> +#ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
> +	LSM_HOOK_INIT(kernel_module_request, integrity_kernel_module_request),
> +#endif
> +};
> +
>  static int __init integrity_lsm_init(void)
>  {
>  	iint_cache =
>  	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
>  			      0, SLAB_PANIC, init_once);
>  
> +	security_add_hooks(integrity_hooks, ARRAY_SIZE(integrity_hooks),
> +			   "integrity");
>  	init_ima_lsm();
>  	init_evm_lsm();
>  	return 0;
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 83a465ac9013..e020c365997b 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -178,6 +178,7 @@ struct integrity_iint_cache {
>   * integrity data associated with an inode.
>   */
>  struct integrity_iint_cache *integrity_iint_find(struct inode *inode);
> +struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
>  
>  int integrity_kernel_read(struct file *file, loff_t offset,
>  			  void *addr, unsigned long count);
> @@ -251,12 +252,18 @@ static inline int __init integrity_load_cert(const unsigned int id,
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
> index 9ba36a8e5d65..e9275335aaa7 100644
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
> @@ -1497,7 +1496,6 @@ static void inode_free_by_rcu(struct rcu_head *head)
>   */
>  void security_inode_free(struct inode *inode)
>  {
> -	integrity_inode_free(inode);
>  	call_void_hook(inode_free_security, inode);
>  	/*
>  	 * The inode may still be referenced in a path walk and
> @@ -3090,12 +3088,7 @@ int security_kernel_create_files_as(struct cred *new, struct inode *inode)
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
