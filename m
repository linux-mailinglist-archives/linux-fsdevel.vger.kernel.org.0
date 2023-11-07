Return-Path: <linux-fsdevel+bounces-2296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934D57E4887
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 19:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA805B21010
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC7E358A4;
	Tue,  7 Nov 2023 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="P0ZmpQjQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BCB328C8
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 18:45:20 +0000 (UTC)
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081DE13A
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 10:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699382719; bh=Nmjg5JWgm1+G0z8hqNLRxnHgBQ6MbKKqMDe55oWqjqU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=P0ZmpQjQTA/JhtG4TTO7Mfs6X1IwTQd+GDaHYOBedZd5EWCkpY4YTQ3CO79oQFXjz7+oVAu6y+4C9fgdwDaFJsOz47gi8TsHdtGz+G6gzAbEVkvCGmodH2LucazM2ovpmFYJaTMjMCLMon+QUHd6REZKE6n3fTQMb0jA5U9l1jtupn3jdS4JQ2bBrfuR8AuNfjnKOMFcpZXzCBIOztpsXqs0i1rQFSaeHAI2ENRQitDfDC8xC+HIPr5h3sT4TRWdv3yRSc3WuyTqfSfyl4hVKt0PAMq0+C74+pTJxdeVDC8fVO7qHHw8XZkdnQ4JqiiQoSzekIaRKziyJNMSCa0/Qw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699382719; bh=YPYY2VHtmXidyJZ41RHpsfd5uKUMV8Iub90pRktsVAs=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=KWfO1U1CtjK70YoRLGWIRKneD8ZtXl7mn9UUeQzf4co0g17NGwsnCWfnXNTolyvumy7DEGVdj9sbzdHn+p+IhU0M31fUT3bDHz+Di3M7jYECojtOLuAwFnDr1HPBwxJAt9fK+HiuaGVsuD1qXXwySMEXOAmB6BLx0KvpcPiTH5NiMuBbQC7FVsCOmKWwCj+SVv6qke6K0NMEasruYrkxO7YhtSDhQHelLXs1j7lhs+hK7tvnrM20cLvjc9OmrpPUcgjC2FWTNxM4BzN0sE4KKQFdzALkkHCpKCHslUPBTSP6pWfnTA9cjwd7kJqxQz0zW1/S+fwKoMdcRpqKskDuyQ==
X-YMail-OSG: QB0yc6oVM1nJRFH_aXmu6llinLjsYqJWQkuKfglT1AAkwtGdf253L0_RdStYpVR
 P8M1DMQkVnfOqQbC70P4gF3zAJXucmOENiTdHs7PTdy7c2oVTFryLiqe.g.3VfadsrorqPziiG3H
 sCG7lF3n8psUBT0jV4nQ.C20y1fbsRU5eu4cw4dG8D3DanezDrq2wSa9Cqkn8jPKUv1hZC7nMuwy
 Qjk2O64nlaqH0umluypIzxaaizpw9vnPzqr1FiEdYf9SAJto4yZfK8nAsWCIpFFEcOCaChnAYyHE
 BVQCbbyd906T8m_SErDog5IpDHd3SZ.uW7.0ZGZw2vYW1N6435s4GZNBwTV8AH6lY2VbXwMKBSYU
 BaON5gvIEbtzT1QGEIx9hSCWO0mlXTQe_O1hd52suDbV9i2d_bl6jlJf3dm.5Rbe5eKf2TiovXAk
 BQ2WRUgOFW9_HdujDCvSjY9_KjabTdlvCT4ZaoapcYV0qeWbdhkbUkraYtUs_EpKD5BHlyAh1OT.
 53Vww88ePZ3bK8lkDE9WPmSNdLzNb7hjNpYD2x7UvuSlGCtGrqvC.KnmIt7QCmCy2ByoOCk7sdus
 RS6tEzrFuQSUNBfZub8687BjyFXLeUQFlsw6.L4JW4suOgpVrFRw2v26BlTOkS_UADIBPRWsszie
 PWInZEWuHX0X9p2KseW7y.wAxv0y4gDbU.COWzDbPxOFk_iAV.Zye9t_0ZAVEa4MopO.p8oKklBC
 yt3Dfw3IfaIAV48Rbs26fNbsbM6dRkVhoT4wSaLEd5jBPH_oe6DuSgQa9alyi84PfHSjXLKugvYt
 Y966ceLE.tU_bT_VldMtcyIGj7.4aa9i4emIPwETSl4uGmrq8v9GISQLC0XqVuicTQJQ8nByxbuJ
 NYGQu15CzGay3GiYBdEPD7WhKF8B1qKRr_GQBUUzohc3fAwQvF5rdDmxeFxLzgjSk_.7ufPJ08.4
 HrTy6db0eC924XDYyaeW98t.2vrLUiSI_39RX7wj_4sE4xbHH50fSQ9aiHMxxptfIroOJTlzrVeg
 9I6EXpQpBx56HeDc5KTkjrMXwce8k.IiAkw8xKizQPLz7GKaMfoMEjZGuef2cKubpC15y8RiwmtE
 mk2rYxkGSXQ8_UnI_vWmd5C2eX8t8V27qZAhC8Y1CgOmXQUtKXOWczwd.fNwewuAiDedDqdtI7T6
 d79Ad23knDA4ApxAn7YQC1NW98FbTOuSbY1Mcywf4UwXJo6CADBDeuAf_wlQ.YPXkdPH526so.G_
 9dMdLc0OkWGP7iHT45.eQOZQ0U2NdS9aK3c6pZVcNOu7HRY5mk.4krAa3O9bYqpQ8SwidCqSuWZP
 9upaatCPaJKOKoONUaHV_XPxtKC3wf9qBHmjdz2OZeEawgs8I9mS3Duu_j_lgDnAgFLfDkleiWpt
 BReO66JZR8x.KT3JOfUiHxTfdvcfc2HE29OZoGeeMpfrmNq_STDkh_z9KFcXviTBazGWq0uP8b37
 6H0khUAbCjT4oaugzYV5W5iW7rzpK0etNjLrGiZdbz1yD.km4Z3V7NFnQAvlt4hvUWncVxvTUx5l
 dHK0wUyb2XF8aYn850ToQVWTE4s8la0bVJJiusczQhUyK9tYxpDNOywOYA9By2UrP4OAHXoQ_tEQ
 1sXU.U0TsxyneGugyKFmNrIfBaMtKjrAb3d5.H81p0Kv3FOgxo4_KM5avPqRfcF6zLQwPS_58Qrs
 8Zlno96SyPS2ERdipNoUAtu.5gzLEB6WTXPkK580CpFWP.Rx3KXWNpbx9__GAEEXOk_MDGecfsve
 f0.IF2VNP6lq3f5_m8lwRpWkap1XVa7vT7Uc6YJsn6Xtaee0XApUSKZU6IsIxaHW1Uy3mYPOj4xj
 KpAel.2CM4m9aBqCK_GhG78z_613rUPJBV9TW9Bfn58_lTwBeC4qM7BO1BjOamY_BKjTi27wy7cf
 p_Wei65XjyggT3yxvvTCfKptYzg83YDEkThcyvelWnkoSMGAlSKIB5kico97M7CubuL51K950L3i
 fJfiPTRJ.fR4tVrmNId28k1tPu5eVnH9022fRwt8hL1raGoaDQv_B3POfjP2WdREFXF9qxZLKMLl
 uQ_ZbY8UxMkouF2XasI1FQ.9FMPtoIk4xdszHI29d9g46b7cuM96ZMyYyf2p5ilc5O3c1xIVo3Oa
 RAypBkAmXWY77PWAyl0EZoXabpvQkTrXXfT99xsgL7sqGjNJKtdxXHN.wCS988Sdd1g_Y3i84AB6
 9nHxvLCuFE9Asj9Kem3V1iQ79FZ74OPtWIrdLKmDSYxwh3SuCkT0tMEkgIKQKnEjkdzyqgzcgUte
 W
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1d6cd941-b0d2-4e13-9323-43fceceb2ed7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Nov 2023 18:45:19 +0000
Received: by hermes--production-bf1-5b945b6d47-tqjmf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1e955340508715f316fcd0cabcaf21d9;
          Tue, 07 Nov 2023 18:45:14 +0000 (UTC)
Message-ID: <d8d1a583-a6e7-486b-bd5a-6998ba64f855@schaufler-ca.com>
Date: Tue, 7 Nov 2023 10:45:10 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/23] evm: Move to LSM infrastructure
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
 <20231107134012.682009-22-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231107134012.682009-22-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/2023 5:40 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> As for IMA, move hardcoded EVM function calls from various places in the
> kernel to the LSM infrastructure, by introducing a new LSM named 'evm'
> (at the end of the LSM list and always enabled, like 'ima' and
> 'integrity').
>
> Make EVM functions as static (except for evm_inode_init_security(), which
> is exported), and register them as hook implementations in init_evm_lsm(),
> called by integrity_lsm_init() to keep the original ordering of IMA and EVM
> functions.
>
> Introduce evm_get_lsm_id() to pass the EVM LSM ID back to the 'integrity'
> LSM for registration of the integrity-specific hooks.
>
> Finally, switch to the LSM reservation mechanism for the EVM xattr, and
> consequently decrement by one the number of xattrs to allocate in
> security_inode_init_security().
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  fs/attr.c                         |   2 -
>  fs/posix_acl.c                    |   3 -
>  fs/xattr.c                        |   2 -
>  include/linux/evm.h               | 107 -----------------------
>  include/uapi/linux/lsm.h          |   1 +
>  security/integrity/evm/evm_main.c | 137 ++++++++++++++++++++++++++----
>  security/integrity/iint.c         |   1 +
>  security/integrity/integrity.h    |  15 ++++
>  security/security.c               |  45 +++-------
>  9 files changed, 150 insertions(+), 163 deletions(-)
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
> index 84a4aa566c02..2660bc7effdc 100644
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
> index ea84a6f835ff..21560874e5fc 100644
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
> @@ -964,4 +1018,57 @@ static int __init init_evm(void)
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
> +/* Return the EVM LSM ID, if EVM is enabled or NULL if not. */
> +const struct lsm_id *evm_get_lsm_id(void)
> +{
> +	return &evm_lsmid;
> +}
> +
> +/*
> + * Since with the LSM_ORDER_LAST there is no guarantee about the ordering
> + * within the .lsm_info.init section, ensure that IMA hooks are before EVM
> + * ones, by letting the 'integrity' LSM call init_evm_lsm() to initialize the
> + * 'ima' and 'evm' LSMs in this sequence.
> + */
> +void __init init_evm_lsm(void)
> +{
> +	security_add_hooks(evm_hooks, ARRAY_SIZE(evm_hooks), &evm_lsmid);
> +}
> +
> +static struct lsm_blob_sizes evm_blob_sizes __ro_after_init = {
> +	.lbs_xattr_count = 1,
> +};
> +
> +/* Introduce a dummy function as 'evm' init method (it cannot be NULL). */
> +static int __init dummy_init_evm_lsm(void)
> +{
> +	return 0;
> +}
> +
> +DEFINE_LSM(evm) = {
> +	.name = "evm",
> +	.init = dummy_init_evm_lsm,
> +	.order = LSM_ORDER_LAST,
> +	.blobs = &evm_blob_sizes,
> +};
> +
>  late_initcall(init_evm);
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 87f2c0d69f78..0b0ac71142e8 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -199,6 +199,7 @@ static int __init integrity_lsm_init(void)
>  	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
>  			      0, SLAB_PANIC, iint_init_once);
>  	init_ima_lsm();
> +	init_evm_lsm();
>  	return 0;
>  }
>  
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 3098cae1c27c..7534ec06324e 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -209,6 +209,21 @@ static inline void __init init_ima_lsm(void)
>  
>  #endif
>  
> +#ifdef CONFIG_EVM
> +const struct lsm_id *evm_get_lsm_id(void);
> +void __init init_evm_lsm(void);
> +#else
> +static inline const struct lsm_id *evm_get_lsm_id(void)
> +{
> +	return NULL;
> +}
> +
> +static inline void __init init_evm_lsm(void)
> +{
> +}
> +
> +#endif
> +
>  #ifdef CONFIG_INTEGRITY_SIGNATURE
>  
>  int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
> diff --git a/security/security.c b/security/security.c
> index 456f3fe74116..9703549b6ddc 100644
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
> @@ -1715,8 +1716,8 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
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

