Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C56C78F5C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 00:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244022AbjHaWq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 18:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242217AbjHaWqZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:46:25 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E1F133
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 15:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693521978; bh=WpChaLFyugELILUelIyJazVzshgBi0ofO7Udsy/FaLI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=GZ4ONOF8EcuPRvgmCP4yhUsErPimm0r1iBbaTEkiSjwkeJHZ4T4GAhp/I20tganuwm4Z+9Qx4IE8guS0NodPgZYIfM5oZ6ENEca3iYRaD3IUlRUD9a8crdqC663Bd7bCi/uJWFAfqw+eQNCr/fTAEgCBIvqeWtXev03ItDVPb46EbGNhuC52DyoBc/bXnhtPfHd7x7kM3qzkWFnG6zDHoUEs8xiQ1dGQGxGFVURbeNxsauEDs1i6b5f20oJUQihqW7I85ODeF3YatgVQcGDtxiTgn30BJU750ZugaSmMYfMLrPnCTxTLIefDOY1MxmL20INAwB23sEKfhT5pTNR8FA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693521978; bh=0pBdtGkzGBJ6fu9MU9omvfrcxRW5qIUzWWAtrwnYAsq=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=qh+LpOe6NDIX2tHAINAOfLAdVbyylO0zWomKU62JHOqWdYWebYFUyLtQeb/yNBoKZqVhupTPQpn9EnKgqnP0M2SC4DnFRzapk4tVOu5wDg/uxV0gfnbaTiqIFRTqDoTDl1Khgrs3LQXfVX7cxm5fzido1NGrHrNIJjPzAaOp68KAzwwnWKluvfGLZnSlixONgYDDv1my+550gRrRy+0HS0bGf35l0rylp+FOngG9t+YhTLIpDKlE5OXqNhVN+n9XG6zP1J6HLSL9eBGCE0lsu3trbRjQENWPG2xP73PcPvCkaB5ApvI5gxBZuEQQbBXIi7XRM0+hyeaExmdup2KhVg==
X-YMail-OSG: ZNKhUoMVM1ksZ8nopIZZt0v7BcdTg6xIfifzMXbMQvmoI6Bes799ZnFQ1pdjU1Z
 5_TLF7mm27jXxD6CJk07bE7OOHTccGJ0Ysko_avMNGDqxaeDiyAJLeJEhKEUmCD.gzal_2iC5kUP
 IUhC9DIv_5AyDRG45WDoNgqX0FisAhLlTkSHzG2X83Y1RMWDMe_A093v.Xxl1Tz3MqkZzUv1xlid
 1vrqvt4owk7ec8vRVxApcR7NNWv.HwJRJOx.XM_gKXPE92i6ShC6gi7s6UuCrtY.Q6Bc3THVAYPV
 E2ThT.WY5ZIk20XkIRs0p0kevI1ozwQV9pDL3_4v1Pa8ZfIdxU1og9GA2FxvMZI6xLrV1xJWdVAW
 G2PjltSAVQgwodBRDV6jZTzNXAVYcgfDm7sVXAKiXmGk3eh412WutxUkB0XgSdYQ8gxtT43t8Mw.
 KCYZ9aj1IE979oI3vq4hi3yCS4cVpBRDFHtmdqJG5bPgfCN31.y7X1VtkHZa8o7u1eytGvjv.eXR
 5DnQhFQZHQomitwKbOW5a8levq5l.5rwOIW_uwq23ZRyvUDp0nz4MiNjLcwOj6FX0ZWGdwVjV10b
 314xPAmitfH0dzDhUESwloPoMON3QezqI3ADg_STEzyL5Um5edwZKMTpmcvAFrsWrLc2NeZNcP.J
 v4UYXDOE9D.bI7dP5Rbi4DsoTE1cjN.jgYcrVKc5Gal7YChUSdAIebshh_YHsj1934iOhZtdtKPG
 Wh0wNBrWkT2AWKaqXVdeCHONy8qcBGmJe4jAnn_qF2FeRFYVwv9PxiAtj4SQ4ZJgcQtdmL.vMNkF
 iFzx3YcvJMeVmPkNowFeK9DscckReEB81NgP63ax5gEfMChd.wwcej0rMtzocT2bUUwZoarCQ2hq
 nmC_NoF0HlIwGTQNcKzco4h5tCHNB6wCGF8x5gHQ2_SS9mTq_hbNqgZdSmh_Rk.YOZ9fIf1fqmxg
 1z2pn.NYrpkx4UNV8r0umZHBJqXAquVXkgDoUh68uCMXI9Ft89OK8gZCr_Z3YTRQSuxFovT9ixSb
 qOlGMoUgH_I4h_vnnKYu_bcZ4q8gIsnaFNmkiX8TMsJ7xxnz7Bai60VM51KzBO9DJO1BWRSySuA0
 9rXfmMj0G.YECaaarrEvW70.5gDEim6zIUDQ3HHLyyXyf9NbDl1fk.Qj0XpIS2A7BZuT9njgv9zy
 kOTu6f38MutZ62s7EU8P.iaRcLMe17fRMiFf5v6Utg1TSZoHtCcAJUncMLsW3DABYGVgSCYmbZoe
 mMOmR_pryk1gGNitE1tcxT0rOpkQLYrqmCMqRI5v6c0hUIHIdTDHJoOqPvRZeehjrBOFyJrsdKg.
 qPAqjwHBU80fQHXkrvaEMhvErmmM08mYGHg12Hm9aH_j_wdsScrk2bduZDUptDaXjFTFhHA3ne4D
 EhooNmohu.dC8wpXBK6F8IBXUgFz.KAQz3O2uhqMu3JQm9.pmDOCPO_3t1NwpUdQO9Vi12PmyDq1
 roZfakVwMv6I7risCrLtQ9iV5voJKTV8bMYb051MWrR8OVqWECVW4X1xJdblvOwi.g17dLIiSrJW
 Hg15R7LACgT0bUQWNcpMOrQ9KhP9ya1CsotcsmFRowkFThb_AU6gIauGaDDxAGeU7jyxMei5kO7U
 TREINcnZceR5YTdYmX5kEG5oYe5q_8Pm_kcgmaBzLDaSG9gLm8JMgxTAPWdhx9zG2XZ5PWgPfpSd
 ijxsGauRu0py39jBUCIUTa4E1lqBo_bdUl95Yqajwdfc4N40SVWQaaatiHVHn0cQfGGzGBx6XS1j
 Voka_o5hulQ8a5lvIbGAKZurXrqUNe.bH5N17RfnLDIFD.0Zw0j67.Vkf_rfqO6kqr2wSLOTl.vb
 kwAqo16NSjeLUNyoQWn1hSiNllEYB6XObahB5cpI9s0yP7jLny27Y9M9cTrp1KEJR6SZT7AMwtq7
 NgjMb_25gtYLltjGujWg8b5.gsBzecFfy.MRB_g92VK2miZ3mHmAWxGMpkjl0L..nNNV9rubHI0M
 oiZg2z8VllLsFGfC9wmhCso7DsROKGPBzROF2oe0Zwc2uLfcMIQOboDw5KKdFIUQKQECO2OhP.PS
 RvJjq0wQc5UjlN6dPVpFvHesAmVgd3.XmzrgwtnfxOYYEowBsrpiDxJZA4MqWtJZ7yEulpvW_.EK
 _t5DcspF_FFpz2WVt_ZH46tOl8o5xFVKcj.Cx2E6nhrnRIYHtt_z3.XvRp7Bjtd2U4bBS6.1cZrx
 qQx2qAGOseT__jLzVIiCPySUEoqw3m2yzI9u8GTkLM4THuWGg.F3sH8ZBdb6qkKDzNrXfQ_7ALTi
 a5k1O
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d395b5ad-8328-4ceb-b3c8-b495f4aff211
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 31 Aug 2023 22:46:18 +0000
Received: by hermes--production-bf1-865889d799-cgv22 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4d335b7f2461e5da20621711db37ac7e;
          Thu, 31 Aug 2023 22:46:17 +0000 (UTC)
Message-ID: <c822236b-c083-32fd-63cc-5d34d045cc8e@schaufler-ca.com>
Date:   Thu, 31 Aug 2023 15:46:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 23/25] evm: Move to LSM infrastructure
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
 <20230831113803.910630-4-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230831113803.910630-4-roberto.sassu@huaweicloud.com>
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
> As for IMA, remove hardcoded EVM function calls from the LSM infrastructure
> and the VFS. Make EVM functions as static (except for
> evm_inode_init_security(), which is exported), and register them as hook
> implementations in init_evm_lsm(), called from integrity_lsm_init().
>
> Finally, switch to the LSM reservation mechanism for the EVM xattr, and
> consequently decrement by one the number of xattrs to allocate in
> security_inode_init_security().
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  fs/attr.c                         |   2 -
>  fs/posix_acl.c                    |   3 -
>  fs/xattr.c                        |   2 -
>  include/linux/evm.h               | 107 ------------------------------
>  security/integrity/evm/evm_main.c | 103 +++++++++++++++++++++++-----
>  security/integrity/iint.c         |   7 ++
>  security/integrity/integrity.h    |   9 +++
>  security/security.c               |  42 +++---------
>  8 files changed, 113 insertions(+), 162 deletions(-)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index 63fb60195409..4153f83a4a1f 100644
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
> @@ -486,7 +485,6 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (!error) {
>  		fsnotify_change(dentry, ia_valid);
>  		security_inode_post_setattr(idmap, dentry, ia_valid);
> -		evm_inode_post_setattr(idmap, dentry, ia_valid);
>  	}
>  
>  	return error;
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 2a2a2750b3e9..5cea0df45d3b 100644
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
> index 4a0280295686..4495e0b4d003 100644
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
> index 642e52483adc..cb481eccc967 100644
> --- a/include/linux/evm.h
> +++ b/include/linux/evm.h
> @@ -21,44 +21,6 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
>  					     void *xattr_value,
>  					     size_t xattr_value_len,
>  					     struct integrity_iint_cache *iint);
> -extern int evm_inode_setattr(struct mnt_idmap *idmap,
> -			     struct dentry *dentry, struct iattr *attr);
> -void evm_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> -			    int ia_valid);
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
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 2e8f6d1c9984..adbb996e681d 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -567,9 +567,9 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
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
> @@ -599,8 +599,8 @@ int evm_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
> @@ -650,9 +650,11 @@ static inline int evm_inode_set_acl_change(struct mnt_idmap *idmap,
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
> @@ -691,6 +693,24 @@ int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
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
> @@ -739,9 +759,11 @@ bool evm_revalidate_status(const char *xattr_name)
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
> @@ -757,6 +779,21 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
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
> @@ -767,7 +804,8 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
>   * No need to take the i_mutex lock here, as this function is called from
>   * vfs_removexattr() which takes the i_mutex.
>   */
> -void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
> +static void evm_inode_post_removexattr(struct dentry *dentry,
> +				       const char *xattr_name)
>  {
>  	if (!evm_revalidate_status(xattr_name))
>  		return;
> @@ -783,6 +821,22 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
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
> @@ -806,8 +860,8 @@ static int evm_attr_change(struct mnt_idmap *idmap,
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
> @@ -854,8 +908,8 @@ int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
> @@ -965,4 +1019,23 @@ static int __init init_evm(void)
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
> +void __init init_evm_lsm(void)
> +{
> +	security_add_hooks(evm_hooks, ARRAY_SIZE(evm_hooks), "integrity");
> +}
> +
>  late_initcall(init_evm);
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 32f0f3c5c4dd..dd03f978b45c 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -174,12 +174,19 @@ static int __init integrity_lsm_init(void)
>  			      0, SLAB_PANIC, init_once);
>  
>  	init_ima_lsm();
> +	init_evm_lsm();
>  	return 0;
>  }
> +
> +struct lsm_blob_sizes integrity_blob_sizes __ro_after_init = {
> +	.lbs_xattr_count = 1,
> +};
> +
>  DEFINE_LSM(integrity) = {
>  	.name = "integrity",
>  	.init = integrity_lsm_init,
>  	.order = LSM_ORDER_LAST,
> +	.blobs = &integrity_blob_sizes,
>  };
>  
>  /*
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 7adc7d6c4f9f..83a465ac9013 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -189,6 +189,7 @@ int integrity_kernel_read(struct file *file, loff_t offset,
>  #define INTEGRITY_KEYRING_MAX		4
>  
>  extern struct dentry *integrity_dir;
> +extern struct lsm_blob_sizes integrity_blob_sizes;
>  
>  struct modsig;
>  
> @@ -200,6 +201,14 @@ static inline void __init init_ima_lsm(void)
>  }
>  #endif
>  
> +#ifdef CONFIG_EVM
> +void __init init_evm_lsm(void);
> +#else
> +static inline void __init init_evm_lsm(void)
> +{
> +}
> +#endif
> +
>  #ifdef CONFIG_INTEGRITY_SIGNATURE
>  
>  int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
> diff --git a/security/security.c b/security/security.c
> index dc863210c96e..9ba36a8e5d65 100644
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
> @@ -1616,8 +1616,8 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  		return 0;
>  
>  	if (initxattrs) {
> -		/* Allocate +1 for EVM and +1 as terminator. */
> -		new_xattrs = kcalloc(blob_sizes.lbs_xattr_count + 2,
> +		/* Allocate +1 as terminator. */
> +		new_xattrs = kcalloc(blob_sizes.lbs_xattr_count + 1,
>  				     sizeof(*new_xattrs), GFP_NOFS);
>  		if (!new_xattrs)
>  			return -ENOMEM;
> @@ -1641,10 +1641,6 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
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
> @@ -2144,14 +2140,9 @@ int security_inode_permission(struct inode *inode, int mask)
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
> @@ -2216,9 +2207,7 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
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
> @@ -2237,15 +2226,10 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
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
> @@ -2298,14 +2282,9 @@ int security_inode_get_acl(struct mnt_idmap *idmap,
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
> @@ -2341,7 +2320,6 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>  		return;
>  	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
> -	evm_inode_post_setxattr(dentry, name, value, size, flags);
>  }
>  
>  /**
> @@ -2402,9 +2380,7 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
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
