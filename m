Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F356AACB3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 22:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjCDVgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 16:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDVgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 16:36:09 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC59F1ABCA
        for <linux-fsdevel@vger.kernel.org>; Sat,  4 Mar 2023 13:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677965764; bh=aKkkdnA43LEawzZ5o4QEfQIz3Rc+PkziP9cxIzqUdoI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=e3uHmklSypl3ZOW30waUtR4ae6+Hl+MxEYGBbQgmaj5T931wvWSCLtCYFgP9pD6ml+Kv3ZjK4n6+R8aQoXMzlyXSciHofTt9VtHoZDSt6W6RoOkfKQJayiz4HeZ1GUrZprgSCMgQK9o9JLOraITIpyV2AckWqoEjbNsM3OADi/lIy+K5VIvp3/aQJ9/g9VLSyLcJH52oZOGkyZ92x3MjnM9PxqJ1gvmC9a3b4l91Mfntmjm7srm6A/E1kpNZFzv5qMWGsjTV5qS+O5fETb5OkmgoPuGZxxf7YWqWuiY4nqgxkcPpRVEVgcPDzieLZ7vRQswrTrqzZ9WuGU+p4VpaSA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677965764; bh=Eb4t0nMJmhgpjoDrQtojiDIfcuEarzu1b+k9RW43ppJ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=dR/IKL0ormvqw8C1SG/5e+byZoogxz5RqgZm6VoqF4gCLCfuv+b6ooycTsXhlSPmSs7jAMuWenxlwMLi7RmAlnknL7pXcCf8NvJ2HQqKpUGNAA7S1tUSHVvmVPtoEt/XcsuRxhuKQowRspoM2F71C31qNmrdchDfnReCZDts7nEittfk1JNs1jnIAP4an9VfFURf31W+0+0yqP4JG3Q9V6OR89q4QJWrhW7MpDRpegHAFT8brFX/uRSjyS/s0m82Nd8kbEVjge6A87lH9HbJRi0pi5MbY7PzJ6g+bYyMWproAf3iphh+ZaOH4RAKXQguWyAKwvNCI6IA8DXNw+Hi9g==
X-YMail-OSG: KGlSkN8VM1mXP4k3oKLNRe7hyHRUpoU8rHmtx3TvFsxzuAECkdl6bIDOg9lMw5X
 B1o7DQjSMMOd_t3Z.aOM8ARLWmy8xNDLuycFvETdLlkG80KiCKdsUqs2x2.8HZZobMPjZ4k0mqkV
 U6Iogof8FBEzCT8yV8RykWQEQHKdhQ29F2MEGmi2q.IUPu45uYGi94M8dRdvmIiykO6m3SioJiyI
 zfAVfmvNRQ9G7gfiV.aNhXzhSxSK.cY_2IGYIyalbfZS5CgVEFm8sj.Et4fC2NaOyS5ijdM0cY8A
 UvfgdpZ41l0sAI7Ns.9g8CImTpp6YlFtuPVGLCOtv3ZzAcSUdoAQ6SMU.b.J4R1VGvtKoFpU9PxO
 LjGCNEC4JbQwbD3bG0zm2SSh8gcwOI.H9W7cJkDRZ4edJYY759vT0Abfmq4n2r4j7zZQ9VJH17th
 cZ_2bG8iD6K1DwxPtbz6w5q4fLG_mQMRddorNnVzQhrdU_CfljTD4.8oCzp_nJtsh8s9KHJpzF1V
 l1G_ClQNCupvgB4hkr90iwYBdPPVcduGAaH8jV3gmDcVNojvP7sXcfTbyyBnHD5Gon_pSfvduhEw
 Y1E7wjIMdo__upJ3VV9o3hBTHXqjFUnYE1IEFogGaFBK.vm8iPgQFcWtZGYurxFaBdBtXZ1Rg3Js
 dK__yfTIsA5j4tg5nKU9Id8G6NQukhjIx8RrfmL8Qn13hjLcRsDVG98pdEI111pL4S.CpKWcaHoh
 FwG9.0IIWZLd3juP9zzT8SnDOiJQWJssnOHg6R5AzlNwjDg4SSBdOoT.ajEE8m97iMyVogmUTFeO
 jviCN8McBA_iU_CHKY2QiUUycnmxqqKOMSRCYqdU98qrK0gPspkgdQOR73V4G2Ns9RfpGMZKsRWt
 z5cdoON_Xj0_jlS88P2EG3wxwYbp27LCCRNpetiXe.GbDYytoGn8A.LLJH9gucYagjP.SaF8jEw6
 2EY9NDlV9XVHxMtW.vUfmpjPhrh6crNGw83kUQeuSujj7G2T5UcLZucWdyPzioDFFY8WkELeAznM
 3IwqUWVlnat.orrGTXzegxhdupSp8SM6QXZsIMXBwF_FFMQ5k70OTuquitc0dIYg16zlN4ZsLx1i
 H2A2VPavEwBsc8.P0PQ0cVliN7nwCSVE0M9UodgxIvK4luE93UVETN2TmbHrMLYNJ3TOAzD.TGdL
 eGJ9tQlDz1M6gvuLnuaLndsZf4j.SLgl1uBstLeuyHiKPdLwbg09I7Q5ybifUvwqwiy0rnGJ.wAP
 uR9Od3YVg1DrkHqgHfnGDQM9s91ij.ZukqswpBjCn3EeTNw0TvWwGfXgq.KI3eJf_8EuhFe1tWD0
 WEdi4IPSadNZMTYq_zRdmWRCSmWiYJMtIEECWuryUPOTHhId8nV.et7Kx4fg9mNJ0pALlCzhExPL
 N6tQ29LBVtcQYh37Bfxj.ATp388RrkrfdIPBsQhPIvcJUbShFD09FmYz3T9b6_YzILlFKsCj7LVh
 kCa0kYPsVN7rd94YlXmYBXCrvHcI0G5ubvTXS_62uX9N7.M.9TavTu1nqkYkjds3awwNGI7ynsIz
 vxUd6U7mozRCsEOqbC3Nn5SVuTgB22sI4S9kZCpZhhxjfg6PhTsv_qwsqNNUfMa7kOoz1I9GqOXH
 gJYebxRZnf1c8I8LPCWDNFFqWS7tkxBI4ifmAxkEseI_.407jkAoApgF4fHlseTQj9F_Fmm4Z2Wt
 ypHAtgaaN80SWi9yNMJOJ7DlcqtoAGdswtyKUCqeAojJtYOcCZhGXEd7KI1DEoXw6pZsmhXT88oU
 JVjmzygMavMCID2ft.NdIl7kMLZrAL2nGSx5FIelNEG2hk71BPfPBjuMx3waPrNYqlaba8il1F6T
 j0sBYhTSN_smSaxuy9QAvQf5ocj.1x2a.6YzKF8kpM9nY4QRmi7enCVfQ7qFQNwq015sywFCCsuh
 DN_kySqmG4_n8zcFA75LjbuexoBzqYdWNUBEl38IA79FsNjU7_9Opc9.nooC6PJizCalGk4NqFmW
 Zhm55WIHaFFm7PWGs.pdkaqlzgQZOK2Gz8Vj8n5Njuc1wlEVK9trVkme9.rhQb7qidi3It5E9tSt
 hLC5zs7_P_2ZSU9vKwPBkrAZy6c13dY1agKi8a4RKdKdzcP_uWXv2YEwmeevs0b5wrbfzJD1B_Ck
 HwtfPIdgXRAWLwNsgis1EGGvCrG4CidY2Fy7azgtepAeQEgxNdREERg0y3Mpy6sXGIfUNrbQ_U3K
 S1_CwHpEKs7BoEXMRbWwjFxNj4u4I_53Vrh2oTObULKeATDVDJqeaodxwKzoB6BK59i9J
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Sat, 4 Mar 2023 21:36:04 +0000
Received: by hermes--production-ne1-7688d778d7-l5k5m (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 79510ae034d508ef814647b4d9a5d909;
          Sat, 04 Mar 2023 21:36:01 +0000 (UTC)
Message-ID: <688527a9-c164-581e-ae60-f82bd8ccccad@schaufler-ca.com>
Date:   Sat, 4 Mar 2023 13:36:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 26/28] evm: Move to LSM infrastructure
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, chuck.lever@oracle.com,
        jlayton@kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>,
        casey@schaufler-ca.com
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
 <20230303182602.1088032-4-roberto.sassu@huaweicloud.com>
Content-Language: en-US
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230303182602.1088032-4-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21221 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/3/2023 10:26 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> As for IMA, remove hardcoded EVM function calls from the LSM infrastructure
> and the VFS. Make EVM functions as static (except for
> evm_inode_init_security(), which is exported), and register them as hook
> implementations in init_evm_lsm(), called from integrity_lsm_init().
>
> Finally, switch to the LSM reservation mechanism for the EVM xattr, by
> setting the lbs_xattr field of the lsm_blob_sizes structure, and
> consequently decrement the number of xattrs to allocate in
> security_inode_init_security().
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/attr.c                         |   2 -
>  fs/posix_acl.c                    |   3 -
>  fs/xattr.c                        |   2 -
>  include/linux/evm.h               | 116 ------------------------------
>  security/integrity/evm/evm_main.c | 106 ++++++++++++++++++++++-----
>  security/integrity/iint.c         |   7 ++
>  security/integrity/integrity.h    |   9 +++
>  security/security.c               |  41 +++--------
>  8 files changed, 115 insertions(+), 171 deletions(-)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index 406d782dfab..1b911a627fe 100644
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
> @@ -485,7 +484,6 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (!error) {
>  		fsnotify_change(dentry, ia_valid);
>  		security_inode_post_setattr(idmap, dentry, ia_valid);
> -		evm_inode_post_setattr(idmap, dentry, ia_valid);
>  	}
>  
>  	return error;
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 5b8c92fce0c..608cb0a9f84 100644
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
> @@ -1103,7 +1102,6 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (!error) {
>  		fsnotify_xattr(dentry);
>  		security_inode_post_set_acl(dentry, acl_name, kacl);
> -		evm_inode_post_set_acl(dentry, acl_name, kacl);
>  	}
>  
>  out_inode_unlock:
> @@ -1214,7 +1212,6 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (!error) {
>  		fsnotify_xattr(dentry);
>  		security_inode_post_remove_acl(idmap, dentry, acl_name);
> -		evm_inode_post_remove_acl(idmap, dentry, acl_name);
>  	}
>  
>  out_inode_unlock:
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 10c959d9fc6..7708ffdacca 100644
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
> @@ -535,7 +534,6 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
>  	if (!error) {
>  		fsnotify_xattr(dentry);
>  		security_inode_post_removexattr(dentry, name);
> -		evm_inode_post_removexattr(dentry, name);
>  	}
>  
>  out:
> diff --git a/include/linux/evm.h b/include/linux/evm.h
> index 8c043273552..61794299f09 100644
> --- a/include/linux/evm.h
> +++ b/include/linux/evm.h
> @@ -21,46 +21,6 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
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
> -extern int evm_inode_init_security(struct inode *inode, struct inode *dir,
> -				   const struct qstr *qstr,
> -				   struct xattr *xattrs);
>  extern bool evm_revalidate_status(const char *xattr_name);
>  extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
>  extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
> @@ -92,82 +52,6 @@ static inline enum integrity_status evm_verifyxattr(struct dentry *dentry,
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
> -static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
> -					  const struct qstr *qstr,
> -					  struct xattr *xattrs)
> -{
> -	return 0;
> -}
> -
>  static inline bool evm_revalidate_status(const char *xattr_name)
>  {
>  	return false;
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 8b5c472f78b..c45bc97277c 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -19,6 +19,7 @@
>  #include <linux/xattr.h>
>  #include <linux/integrity.h>
>  #include <linux/evm.h>
> +#include <linux/lsm_hooks.h>
>  #include <linux/magic.h>
>  #include <linux/posix_acl_xattr.h>
>  
> @@ -566,9 +567,9 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
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
> @@ -598,8 +599,8 @@ int evm_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
> @@ -649,9 +650,11 @@ static inline int evm_inode_set_acl_change(struct mnt_idmap *idmap,
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
> @@ -690,6 +693,24 @@ int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
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
> @@ -738,9 +759,11 @@ bool evm_revalidate_status(const char *xattr_name)
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
> @@ -756,6 +779,21 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
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
> @@ -766,7 +804,8 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
>   * No need to take the i_mutex lock here, as this function is called from
>   * vfs_removexattr() which takes the i_mutex.
>   */
> -void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
> +static void evm_inode_post_removexattr(struct dentry *dentry,
> +				       const char *xattr_name)
>  {
>  	if (!evm_revalidate_status(xattr_name))
>  		return;
> @@ -782,6 +821,22 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
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
> @@ -805,8 +860,8 @@ static int evm_attr_change(struct mnt_idmap *idmap,
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
> @@ -853,8 +908,8 @@ int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
> @@ -892,7 +947,7 @@ int evm_inode_init_security(struct inode *inode, struct inode *dir,
>  	if (!evm_protected_xattrs)
>  		return -EOPNOTSUPP;
>  
> -	evm_xattr = xattr;
> +	evm_xattr = xattrs + integrity_blob_sizes.lbs_xattr;

Please don't do this inline. Convention is to use a function,
intergrity_xattrs() for this.

>  
>  	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
>  	if (!xattr_data)
> @@ -952,4 +1007,23 @@ static int __init init_evm(void)
>  	return error;
>  }
>  
> +static struct security_hook_list evm_hooks[] __lsm_ro_after_init = {
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
> index bbadf974b31..952d5ea4e18 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -179,12 +179,19 @@ static int __init integrity_lsm_init(void)
>  			      0, SLAB_PANIC, init_once);
>  
>  	init_ima_lsm();
> +	init_evm_lsm();
>  	return 0;
>  }
> +
> +struct lsm_blob_sizes integrity_blob_sizes __lsm_ro_after_init = {
> +	.lbs_xattr = 1,

Really? 1 byte? Don't even think of storing number of elements in lbs_xattr.
The linux_blob_size structure contains sizes of blobs, not number of elements.

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
> index c72d375a356..76e7eda6651 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -188,6 +188,7 @@ int integrity_kernel_read(struct file *file, loff_t offset,
>  #define INTEGRITY_KEYRING_MAX		4
>  
>  extern struct dentry *integrity_dir;
> +extern struct lsm_blob_sizes integrity_blob_sizes;
>  
>  struct modsig;
>  
> @@ -199,6 +200,14 @@ static inline void __init init_ima_lsm(void)
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
> index 9bc6a4ef758..74abf04feef 100644
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
> @@ -1662,8 +1662,8 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  	if (!initxattrs)
>  		return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
>  				    dir, qstr, NULL);
> -	/* Allocate +1 for EVM and +1 as terminator. */
> -	new_xattrs = kcalloc(blob_sizes.lbs_xattr + 2, sizeof(*new_xattrs),
> +	/* Allocate +1 for terminator. */
> +	new_xattrs = kcalloc(blob_sizes.lbs_xattr + 1, sizeof(*new_xattrs),
>  			     GFP_NOFS);
>  	if (!new_xattrs)
>  		return -ENOMEM;
> @@ -1699,9 +1699,6 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  	if (!num_filled_xattrs)
>  		goto out;
>  
> -	ret = evm_inode_init_security(inode, dir, qstr, new_xattrs);
> -	if (ret && ret != -EOPNOTSUPP)
> -		goto out;
>  	ret = initxattrs(inode, new_xattrs, fs_data);
>  out:
>  	for (xattr = new_xattrs; xattr->value != NULL; xattr++)
> @@ -2201,14 +2198,9 @@ int security_inode_permission(struct inode *inode, int mask)
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
> @@ -2272,9 +2264,7 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
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
> @@ -2293,15 +2283,10 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
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
> @@ -2354,14 +2339,9 @@ int security_inode_get_acl(struct mnt_idmap *idmap,
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
> @@ -2397,7 +2377,6 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>  		return;
>  	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
> -	evm_inode_post_setxattr(dentry, name, value, size, flags);
>  }
>  
>  /**
> @@ -2458,9 +2437,7 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
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
