Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6F078F594
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 00:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347732AbjHaWg0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 18:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242308AbjHaWgZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:36:25 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC7410D0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 15:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693521371; bh=bk9yXQ/KcBHq32uN5j8gHXdS7ohUg4yI6/GyhFrx53o=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=U61ubqTGMedZt160N5a8IgobfZR/yeGf/ETDdQC0TqQTtx4RKB6rPoVEPfNx1B0QRgpkdixN52d0jevVWZA8aYIYarztlxZ0hrAwRuUZWdxEgV27hpI2aJC7Nw8/Fi0KDdeQ+4aI8p4pl8PkCxowQ5hpbff/1Ca7q8vSKNIDppN4s0c97z9e5ZVgOhT7caAiFKhVeoSk28QevDlXMIOAJ2xO1krt6A2xioMeogOGvLdNOm2LjThq4YbJykFyQq0ZIw6HP4JgCv6YIg+kTCzWBpz/pTmBaaseliB6ZIAZi0ffPtYnS957fgiXQ6/IAGPgrTqc5gf2GWd8mtP9uk2eCw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693521371; bh=t56ANimtrzMmjUWCO6FcjvUxWWY/CJ+VKB/Q5plRHNA=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=VGUMgmMUz3JbzBP5j7iSSZS/3/HRsRcuWg6syeFJO7MM4UvsSV9a4NNqsnUqXX1M5Tw/zCdWnNchykGXGmHxidFutGA025SotIRGCGcAzQzGwWMvAV/lEoGBKhvxe22VrLOvD3235wQ5tV4LGO8VJK//n94gu4YvG4rSxAZO3Fasds96nmMJm2PruoyRnLrIATwcmiaQvVdu1iCmrEIjBhUZ/v3X9e9A5BZWVcLr+dzugZKe4prBsebVeY9OqpJK3iPwb10W1bbXRhCOGcnTBIGMaYJCw40ca6fW+5nYmJljadbdu1Lr037hgfuA0Mg+wSD5kZftVlm6IpSQtP3l6A==
X-YMail-OSG: aE7jCPcVM1nuoQfP9rIL3jLSrZbUZOtB3s8VNuhhG0wsDXoyDBnsDi5tYtEGjKL
 atVXe3xYJm.H.cYqNE.5B7c.59F57inxxDHyTvVWscQwfBp8_zKqcHJVnfu79ukBIh7VTQwpZhOY
 8WddrOuL2h4pEDimsfJihvmOUXdwSy.iX8PJJ62tcvKaNpmRS0jcNthSqbBMJA9SxIsXBydgOLIb
 H0Aes0ohPCICCfcvcYbJmmuJf4caLPCtXOcG6OivhgFEKmpuPew346XIdui6JuG1E7rvjJ3cKJLc
 CeqlDmQ40iMVrJP8ML2cybwuPJK_Va1ZNiAkykv5r5MpFayH.54hnrudVdGjnM9ga4hk2J9CMoNz
 YF3DlipIghPBgFCVOnvj4HSRR8LGTwGxtmWW9pVD5v0oyJb2ThNGb1r5cNNxtw1_lBbh2NkVgaHL
 zVoZixemtXg_xOBT_eBMGIMCrAoOXKW1H5tVBb0E6WUnnR8r8kmg1iUDuGFtLbJZ85F2SjHgvDt_
 qb9s_2MQinIL2VifsvGRXbEV8xzyZl65lpaWTkPJodhbkxtNDHfOz9k74XZVMXKEGwWJ4PGA0401
 uaX3NklszPbcsGfPspiY_WWksvnSi6O5kZkH3T38Uth2lnRtwPphsb3FnwFayR9junstvSuxf8Ae
 NSGzRXDEMiTP4cQp.eQE.UiO_jgvdeh7BiCc5IJu4agiXsLVJnTOO.owY9BiPODUNzh19KkC8gb0
 XHh6fvcsEDlX9DxayF.4maJ4a8xA219kMXOAY7YdfK9kqD21Jaj7q8h.66tUdaGF2Zx48ALpmgOf
 tqOHGiK3qIUBvLD_a2B1_2Lf5jofTd_kPh3jljY6k.BTDuotTV8mFJJnqu9eBnO8THVvXtqrcFlm
 2rEc4DXdQvnKxL9JU9BDzE2oxtL4ZhYo0npL4QONX_wcH2VX4PptKowOABNGw5u9mc12YCyBCduC
 Xs17x0R_Hzj8NWpDcaSzFWFzuSevVULTDb5QLdhHAvvuzk1PrDTNIBmPGzBes9UhnKmCpeax0zP0
 ZAy.iVdcFlejvqiBL5PSJKvTgBoUKysvbuswbMp5h6XHcXloPnv.51LCeBYfd9dX.7WQMkzOXaA6
 YYrJfr7O6QmmW5cQlIlNzlJhajfU1ILrTqiUxYZjprJxtudk4Aa0yp6kMUf9BEhQ7DDSDECpn4fo
 FSozn20.r2sytZDWxgBveLISGH9lvLE2IuFDJwoLKxYoS6K_xz2tZ7bQuheIoQUFgAXsbDPqOWQI
 e6lYZBJ4faEmkT3BuAArPO0jco86flQUVndiF0MCtB2P5dcMcXblCilx_IqWbm298rye.rkNt4Sq
 X972auTQ9pfOB7J_ClliOBRvuuYdHVyDvpEekk20HP8KrKPuXTOdb5Hs2XJCopPWkW.5keo7qbSQ
 FmnO9CV4b7aT8FQLJBEMvOWbgbZT3Ngu2oOvmumjNWwPNyGICoq7lSTo43WiYYzUPhaF8q_iL0ES
 obM9sKrXQc8LyeMoaq4APJlXsFGzJAHUekhos3anca9ph4LQcBDynbzD2dD.3ewc2DCtS8CgmVSD
 fMicil6qmXuaqCuG0uSClVI8_4QpHUqG9qdRZFGuQ7RAtLTf20YehodWiwK41JxkNiaETaLWBfm1
 HszLXltmORjW5wnDFglNHwJNDinjclg6UXovPKRI_kmpt4Lg89csczEQECqO0JlPL3smdYdMC0Gz
 25xaNyXthJYNpIlA6ZINVsmmkG0qp.5Tt0fMKO0kEAFkBrA7667R__eXrKGthjBxWLjUz8BTlFD6
 PTQeyKYhHo7vpjz2PSj2dhhoonQDmKbm7.4z5LzDsOA4Y8_qFZDqrHMC4gyqpMMFrMGW71lhjIzO
 OfR8YlOyZ3CpUQUOYXRcbXW6SkGecBubATcfDLI6t4MzIp5deMzo4bAgHj8HpkIQ6kivSEGfprg8
 sukHMyPytMuprdnxiNbKixRF1Y6FaOmrekM8LLC8.a3DT73flbJnekg8dRAGQDIce4KL5GUQEXco
 Ui2a5KlhbENV9vjsX3rtUlhSMdIiYT3zksDTFd58oNekW0ZovVb5CHCc6V0THgNB45M0KTYPeXMs
 a9Rc1rEOILCRZNKGQnOG2Oj.VtW7vhJvk79uYLrsx9ChIAgZCSyBPfpHfm18j2FsjTmpJPTS18Vk
 idfFGDpoDUfj01sXOsctZGgyKtzQiX6rfUbMKrO857t4Ax_yPA4MhnUNEPZo9tl8GhcqioMpyJn7
 Mo91HQXwgJ1YCVUmg1XxHcpzhD4SLg9hfbe.eFE8QqzmizSZINhklnTILXHTV8eL9fh6izIs_IZp
 Z
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 608a7783-6f11-4802-8b02-5ad0b18070d0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 31 Aug 2023 22:36:11 +0000
Received: by hermes--production-bf1-865889d799-k5x9p (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5541ff03f96d20f128753c942c5668d0;
          Thu, 31 Aug 2023 22:36:06 +0000 (UTC)
Message-ID: <f2f711e1-1c4d-888d-0dc7-5eb87ecbf5eb@schaufler-ca.com>
Date:   Thu, 31 Aug 2023 15:36:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 18/25] security: Introduce inode_post_set_acl hook
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
        Stefan Berger <stefanb@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
 <20230831104136.903180-19-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230831104136.903180-19-roberto.sassu@huaweicloud.com>
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

On 8/31/2023 3:41 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_set_acl hook.

Repeat of new LSM hook general comment:
Would you please include some explanation of how an LSM would use this hook?
You might start with a description of how it is used in IMA/EVM, and why that
could be generally useful.


>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  fs/posix_acl.c                |  1 +
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  7 +++++++
>  security/security.c           | 17 +++++++++++++++++
>  4 files changed, 27 insertions(+)
>
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 7fa1b738bbab..3b7dbea5c3ff 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -1137,6 +1137,7 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  		error = -EIO;
>  	if (!error) {
>  		fsnotify_xattr(dentry);
> +		security_inode_post_set_acl(dentry, acl_name, kacl);
>  		evm_inode_post_set_acl(dentry, acl_name, kacl);
>  	}
>  
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 9ae573b83737..bba1fbd97207 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -157,6 +157,8 @@ LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
>  	 const char *name)
>  LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_set_acl, struct dentry *dentry,
> +	 const char *acl_name, struct posix_acl *kacl)
>  LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *acl_name)
>  LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 5f296761883f..556d019ebe5c 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -367,6 +367,8 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
>  int security_inode_set_acl(struct mnt_idmap *idmap,
>  			   struct dentry *dentry, const char *acl_name,
>  			   struct posix_acl *kacl);
> +void security_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
> +				 struct posix_acl *kacl);
>  int security_inode_get_acl(struct mnt_idmap *idmap,
>  			   struct dentry *dentry, const char *acl_name);
>  int security_inode_remove_acl(struct mnt_idmap *idmap,
> @@ -894,6 +896,11 @@ static inline int security_inode_set_acl(struct mnt_idmap *idmap,
>  	return 0;
>  }
>  
> +static inline void security_inode_post_set_acl(struct dentry *dentry,
> +					       const char *acl_name,
> +					       struct posix_acl *kacl)
> +{ }
> +
>  static inline int security_inode_get_acl(struct mnt_idmap *idmap,
>  					 struct dentry *dentry,
>  					 const char *acl_name)
> diff --git a/security/security.c b/security/security.c
> index e5acb11f6ebd..4392fd878d58 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2260,6 +2260,23 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
>  	return evm_inode_set_acl(idmap, dentry, acl_name, kacl);
>  }
>  
> +/**
> + * security_inode_post_set_acl() - Update inode security after set_acl()
> + * @dentry: file
> + * @acl_name: acl name
> + * @kacl: acl struct
> + *
> + * Update inode security field after successful set_acl operation on @dentry.
> + * The posix acls in @kacl are identified by @acl_name.
> + */
> +void security_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
> +				 struct posix_acl *kacl)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;
> +	call_void_hook(inode_post_set_acl, dentry, acl_name, kacl);
> +}
> +
>  /**
>   * security_inode_get_acl() - Check if reading posix acls is allowed
>   * @idmap: idmap of the mount
