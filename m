Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B926AE79A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 17:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjCGQ7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 11:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjCGQ6M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:58:12 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E7094758
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 08:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678208086; bh=e09rthYJIwYdSXWRI5OVgTvc5Dgr/3J4cmUnkCZ9DOI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZNVLmbO0Y6GnFbnVg1EXAsQ325ZSVlpwfVulyrjjcVh2YUHtg8hqamAZbMp5yEuNfLu7RSq+7Ay9x0EzItKovXEItJhaBIQwCGmqWMNJxvDvOF/AWLSAQjZDaw7BcQYpE0TTTlZSnSV20u7S5/pZFYU1HdiVSTD4WDUDR7k2xU+4d5KFx8niVsmY6n/GLxlUdqITqTGUloN9RiBs07u5p29CSdi4W3HU5rzYO46vwaw6lIJl48m0vPYR3PGA2HjokxAy92/uI6HTDshc0xQKNwBGZqZurEiM2G9IiVOFXZ8cf91BuVsUNnzdZtq//pLjb6hFKFgRHEJ9M4zu6HU76w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678208086; bh=Jy0TQ2g/dLg/klSoUzexr70vgvuVrBMyD8O3cfH2nud=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=aKToDeA1dzBhJwO4XwxQWyi1RM8sksLiIEu2kvV3OGb1p5PeRwMLs3ZjLy98tspg5QQvKGZInOVt0ghIHFd15cjbZQ2efdFGuqld7ZlThqrl0ACc5nkfwvI0gfrJPH4WDKB4MwmwSYoYl3muKJjBMuQt9OJo0dCMMdhk6iaH+zkX5NcKciLqflICBK3X6l+fh6hImbBYHM6pCQ7zvwCx7uimAVN+iEwZfJ73Wa9SZhXSEzwExJbfOkTb7fGxizuCrGApS/IFTtbyjYXVyBZEVrJW9rqBereqnBScQJz6RIEyGHpLps/je13oYZ31HCjvGuJ1MrU7GroAdmoJMGt04w==
X-YMail-OSG: t9O3mF0VM1l1jJVWc4_YiQ00ORjNJsWXIgQKG43BKrYfXB2P2NqlSFE9fiy2i_T
 Dyk75n5nM8N83M1y4SofPZFEo1_NBCmT6LWtGmxh1n08.dWL9nPE4OqmXKfDbrBQRnFaHXVz6HYI
 wcXpnuDPhptOWeEdvvLDSgYzlYS8EOqAxB7Un2gZs3AfUCA5dxEd4OdoghoYpq91hGi4c1qc.yzi
 5uOQmM4UQSdIBpgxeBfu5kNc5rJ2AdAgB56lLRKjKXAdgE1NzZ5voV6HAz1O5NpDoqUapC403Bkp
 cHcx1JVi6Ft0.LpOTllIJzBfTV.0p4YBaJa0e0fc0aS2LzVabsxpVAJxC5go0dg3zB7FcKZZBzD6
 9PJ6BQm3dO62A1UbEvFp.Rn4oO9WS8Jkd5vLYiSSi6BNjnlprca3bq7mA_OHxGAe5ELDVggI6wp7
 t68.OYSvyVkn4lXytLt_HZjB1E_XN58kdq1alHmE0er5m6PwDeXSaB.5jZBJywDzYFQTUPjeo.gR
 AhPs5NaiW7fUOm6tJlkELCfCYx4ZOQ5XbpAOWiJfkCs0clCgnyJeZhd9UV16j3mTjyb.TogV4Sz2
 BvrUnm4XUVOJrJPkZ0cKTCR9njuPRiMkK0z7eIkyCawc2NGPEvyN5gjl8fOXu1yawrtecO.VMWvB
 prDZb9Ewp4CeyTG2wfn0o49oT0id98agvDyjsgR6iHf0pQP5x6ceqV5dXzaBq65NV519t0ut0R.Y
 8ls0L_4P4FkyowAlk.ZBJNw6HeZ41mI.08w_RR8IFC7Q36K5yM0jRjwZVVHICIkuzeaYZLHPl6jH
 AUYkBrG73dhpDnlOLTM4zdRrBlIqaA1V4coggamFBPvW2p4ZulHVJ.UJrSA6vGU5bPCocVtQ2B9n
 azCSpZH18zphKd5c7UNY9gD6XE802f6hf0IG58544rFFQvFSKrEwVchRXx9Na4cUgewWPxpqQaef
 4cXGaMfDrWRICYFQjY6_tckuEBZArB25D48igrazQDQJA5vaGJXWOhA5fTR9k2rVZ8vDbOlC1UwN
 FDFdKD5RbpFKzrVy7Ho2gHp0xiYx3T0QRNaLbPq4CscFaNNarDsRLlAOk3nr.XJGZaOaQ8vifjKj
 .4IMS_HakGpgwd_zdt6w2IJeqgm5pUxUqyIIHLnCfNvEMpmP8Fr4xciGVHLmqQJgmd97f6CYHmE1
 Wultc9V28_Nl4RUraslhPHmoPSenKTrO84usPP.FkTZIss.InJql6Whx1QBM_tb1fwRSdoEkMLES
 o7zO6pPPHvmb.v0UHPwIkDkJBT0mlOG1ZonY24oDGItiHwlAK2pJPyGQtq_RVBiHknBlQ7CqVRoF
 u_3B_xXHzd0viw9uL4ERHD9HQ7dVOwHiXbNTOsg_R6AT4kGgkK23ZoBAVE3y_XtZW3ZV6nk6lRUU
 8C0y_2GRd20FYdD8sFz55qjgp62T4VF6MG_UXEQm8nvBCQTO_oZECPq43P_QohkQqHcoivDhfU6n
 NAz67HRIn4fpu3jiBdTr22davL3T2jkyn_4yvxMpVLeEfiGwOPY6lCue4SwKH7ijq1Bjx6ajb4av
 rdLhiIKUk8aXZ6uC_kLqSHHMRft_oQxWhwCB7.ClXSVj.IVn3sZWaqeTd3FMl6gv0I._qCoWwBkW
 jh2sIbPGxYx0rfbtvaf_kcFjIqWIgn7CUVCvGk14qh6u.MDsg07rr0bFpugQ2Cl7nCfr4b4CPYpM
 4lj4FYD9DakBXlF.fgq1fVbPhQeJoCraTcLy13Udlf7U7N8T1BHS0WEzsDGWuVoURGSPKGuQpRJj
 IUx5TEa3vyGm.tBbgsl42AKbVBM0Tm8I0pC2Si0QdiOtIK9bBbYXvzegWUzPSwLAOKUBWl8Ng40b
 wjBVJgthud9pJ.4p8TCIC5d8SOxJgAx69Cek0jQYi0mVg3pgPqFOW5lh3KoQ3qRC_cNQCktkjuzj
 rXAk7lsbPpje.KaeKZiM8hrg8RRcNTU1z5k9DBUKCfkChMl1g3wDCrvaRrpvgzxG8.nNs9o78Z9w
 Pnh3s5_ho97w5gbLumDBDmAM9LmLTPWghOVtiY0Tjt.qA63w1aYOsMVv06nH5iTH23JwvXQwWULH
 _hS3eDMqunwHkW3atUC.Q7X47IgbMY91icCq9z2QvGAylskhVrcsZt8GmenwqWilPohMcnS2PqBY
 nVhCJHUHAvhhqKgTKiFaAJkhuwaMRRRRfkgJ3yh7cBPTSBXkmUR9WZEAVl56ypOJxrDFqgZ8uU0d
 z7IqBfFFK3qGb4Rtn2nDZKTN7oEtep0jvbR3n
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Mar 2023 16:54:46 +0000
Received: by hermes--production-ne1-7688d778d7-vzmh7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a7264be0cae17bd731fec4e0cbd509f9;
          Tue, 07 Mar 2023 16:54:40 +0000 (UTC)
Message-ID: <cfbf35c1-deb8-08d0-ecf7-958a56d6c3b6@schaufler-ca.com>
Date:   Tue, 7 Mar 2023 08:54:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 26/28] evm: Move to LSM infrastructure
Content-Language: en-US
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
 <688527a9-c164-581e-ae60-f82bd8ccccad@schaufler-ca.com>
 <dc3f43e0f445b0339aac510ecd4a74accc83dd6a.camel@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <dc3f43e0f445b0339aac510ecd4a74accc83dd6a.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21284 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/6/2023 1:21 AM, Roberto Sassu wrote:
> On Sat, 2023-03-04 at 13:36 -0800, Casey Schaufler wrote:
>> On 3/3/2023 10:26 AM, Roberto Sassu wrote:
>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>
>>> As for IMA, remove hardcoded EVM function calls from the LSM infrastructure
>>> and the VFS. Make EVM functions as static (except for
>>> evm_inode_init_security(), which is exported), and register them as hook
>>> implementations in init_evm_lsm(), called from integrity_lsm_init().
>>>
>>> Finally, switch to the LSM reservation mechanism for the EVM xattr, by
>>> setting the lbs_xattr field of the lsm_blob_sizes structure, and
>>> consequently decrement the number of xattrs to allocate in
>>> security_inode_init_security().
>>>
>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>> ---
>>>  fs/attr.c                         |   2 -
>>>  fs/posix_acl.c                    |   3 -
>>>  fs/xattr.c                        |   2 -
>>>  include/linux/evm.h               | 116 ------------------------------
>>>  security/integrity/evm/evm_main.c | 106 ++++++++++++++++++++++-----
>>>  security/integrity/iint.c         |   7 ++
>>>  security/integrity/integrity.h    |   9 +++
>>>  security/security.c               |  41 +++--------
>>>  8 files changed, 115 insertions(+), 171 deletions(-)
>>>
>>> diff --git a/fs/attr.c b/fs/attr.c
>>> index 406d782dfab..1b911a627fe 100644
>>> --- a/fs/attr.c
>>> +++ b/fs/attr.c
>>> @@ -16,7 +16,6 @@
>>>  #include <linux/fcntl.h>
>>>  #include <linux/filelock.h>
>>>  #include <linux/security.h>
>>> -#include <linux/evm.h>
>>>  
>>>  #include "internal.h"
>>>  
>>> @@ -485,7 +484,6 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
>>>  	if (!error) {
>>>  		fsnotify_change(dentry, ia_valid);
>>>  		security_inode_post_setattr(idmap, dentry, ia_valid);
>>> -		evm_inode_post_setattr(idmap, dentry, ia_valid);
>>>  	}
>>>  
>>>  	return error;
>>> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
>>> index 5b8c92fce0c..608cb0a9f84 100644
>>> --- a/fs/posix_acl.c
>>> +++ b/fs/posix_acl.c
>>> @@ -26,7 +26,6 @@
>>>  #include <linux/mnt_idmapping.h>
>>>  #include <linux/iversion.h>
>>>  #include <linux/security.h>
>>> -#include <linux/evm.h>
>>>  #include <linux/fsnotify.h>
>>>  #include <linux/filelock.h>
>>>  
>>> @@ -1103,7 +1102,6 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>>>  	if (!error) {
>>>  		fsnotify_xattr(dentry);
>>>  		security_inode_post_set_acl(dentry, acl_name, kacl);
>>> -		evm_inode_post_set_acl(dentry, acl_name, kacl);
>>>  	}
>>>  
>>>  out_inode_unlock:
>>> @@ -1214,7 +1212,6 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>>>  	if (!error) {
>>>  		fsnotify_xattr(dentry);
>>>  		security_inode_post_remove_acl(idmap, dentry, acl_name);
>>> -		evm_inode_post_remove_acl(idmap, dentry, acl_name);
>>>  	}
>>>  
>>>  out_inode_unlock:
>>> diff --git a/fs/xattr.c b/fs/xattr.c
>>> index 10c959d9fc6..7708ffdacca 100644
>>> --- a/fs/xattr.c
>>> +++ b/fs/xattr.c
>>> @@ -16,7 +16,6 @@
>>>  #include <linux/mount.h>
>>>  #include <linux/namei.h>
>>>  #include <linux/security.h>
>>> -#include <linux/evm.h>
>>>  #include <linux/syscalls.h>
>>>  #include <linux/export.h>
>>>  #include <linux/fsnotify.h>
>>> @@ -535,7 +534,6 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
>>>  	if (!error) {
>>>  		fsnotify_xattr(dentry);
>>>  		security_inode_post_removexattr(dentry, name);
>>> -		evm_inode_post_removexattr(dentry, name);
>>>  	}
>>>  
>>>  out:
>>> diff --git a/include/linux/evm.h b/include/linux/evm.h
>>> index 8c043273552..61794299f09 100644
>>> --- a/include/linux/evm.h
>>> +++ b/include/linux/evm.h
>>> @@ -21,46 +21,6 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
>>>  					     void *xattr_value,
>>>  					     size_t xattr_value_len,
>>>  					     struct integrity_iint_cache *iint);
>>> -extern int evm_inode_setattr(struct mnt_idmap *idmap,
>>> -			     struct dentry *dentry, struct iattr *attr);
>>> -extern void evm_inode_post_setattr(struct mnt_idmap *idmap,
>>> -				   struct dentry *dentry, int ia_valid);
>>> -extern int evm_inode_setxattr(struct mnt_idmap *idmap,
>>> -			      struct dentry *dentry, const char *name,
>>> -			      const void *value, size_t size, int flags);
>>> -extern void evm_inode_post_setxattr(struct dentry *dentry,
>>> -				    const char *xattr_name,
>>> -				    const void *xattr_value,
>>> -				    size_t xattr_value_len,
>>> -				    int flags);
>>> -extern int evm_inode_removexattr(struct mnt_idmap *idmap,
>>> -				 struct dentry *dentry, const char *xattr_name);
>>> -extern void evm_inode_post_removexattr(struct dentry *dentry,
>>> -				       const char *xattr_name);
>>> -static inline void evm_inode_post_remove_acl(struct mnt_idmap *idmap,
>>> -					     struct dentry *dentry,
>>> -					     const char *acl_name)
>>> -{
>>> -	evm_inode_post_removexattr(dentry, acl_name);
>>> -}
>>> -extern int evm_inode_set_acl(struct mnt_idmap *idmap,
>>> -			     struct dentry *dentry, const char *acl_name,
>>> -			     struct posix_acl *kacl);
>>> -static inline int evm_inode_remove_acl(struct mnt_idmap *idmap,
>>> -				       struct dentry *dentry,
>>> -				       const char *acl_name)
>>> -{
>>> -	return evm_inode_set_acl(idmap, dentry, acl_name, NULL);
>>> -}
>>> -static inline void evm_inode_post_set_acl(struct dentry *dentry,
>>> -					  const char *acl_name,
>>> -					  struct posix_acl *kacl)
>>> -{
>>> -	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0, 0);
>>> -}
>>> -extern int evm_inode_init_security(struct inode *inode, struct inode *dir,
>>> -				   const struct qstr *qstr,
>>> -				   struct xattr *xattrs);
>>>  extern bool evm_revalidate_status(const char *xattr_name);
>>>  extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
>>>  extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
>>> @@ -92,82 +52,6 @@ static inline enum integrity_status evm_verifyxattr(struct dentry *dentry,
>>>  }
>>>  #endif
>>>  
>>> -static inline int evm_inode_setattr(struct mnt_idmap *idmap,
>>> -				    struct dentry *dentry, struct iattr *attr)
>>> -{
>>> -	return 0;
>>> -}
>>> -
>>> -static inline void evm_inode_post_setattr(struct mnt_idmap *idmap,
>>> -					  struct dentry *dentry, int ia_valid)
>>> -{
>>> -	return;
>>> -}
>>> -
>>> -static inline int evm_inode_setxattr(struct mnt_idmap *idmap,
>>> -				     struct dentry *dentry, const char *name,
>>> -				     const void *value, size_t size, int flags)
>>> -{
>>> -	return 0;
>>> -}
>>> -
>>> -static inline void evm_inode_post_setxattr(struct dentry *dentry,
>>> -					   const char *xattr_name,
>>> -					   const void *xattr_value,
>>> -					   size_t xattr_value_len,
>>> -					   int flags)
>>> -{
>>> -	return;
>>> -}
>>> -
>>> -static inline int evm_inode_removexattr(struct mnt_idmap *idmap,
>>> -					struct dentry *dentry,
>>> -					const char *xattr_name)
>>> -{
>>> -	return 0;
>>> -}
>>> -
>>> -static inline void evm_inode_post_removexattr(struct dentry *dentry,
>>> -					      const char *xattr_name)
>>> -{
>>> -	return;
>>> -}
>>> -
>>> -static inline void evm_inode_post_remove_acl(struct mnt_idmap *idmap,
>>> -					     struct dentry *dentry,
>>> -					     const char *acl_name)
>>> -{
>>> -	return;
>>> -}
>>> -
>>> -static inline int evm_inode_set_acl(struct mnt_idmap *idmap,
>>> -				    struct dentry *dentry, const char *acl_name,
>>> -				    struct posix_acl *kacl)
>>> -{
>>> -	return 0;
>>> -}
>>> -
>>> -static inline int evm_inode_remove_acl(struct mnt_idmap *idmap,
>>> -				       struct dentry *dentry,
>>> -				       const char *acl_name)
>>> -{
>>> -	return 0;
>>> -}
>>> -
>>> -static inline void evm_inode_post_set_acl(struct dentry *dentry,
>>> -					  const char *acl_name,
>>> -					  struct posix_acl *kacl)
>>> -{
>>> -	return;
>>> -}
>>> -
>>> -static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
>>> -					  const struct qstr *qstr,
>>> -					  struct xattr *xattrs)
>>> -{
>>> -	return 0;
>>> -}
>>> -
>>>  static inline bool evm_revalidate_status(const char *xattr_name)
>>>  {
>>>  	return false;
>>> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
>>> index 8b5c472f78b..c45bc97277c 100644
>>> --- a/security/integrity/evm/evm_main.c
>>> +++ b/security/integrity/evm/evm_main.c
>>> @@ -19,6 +19,7 @@
>>>  #include <linux/xattr.h>
>>>  #include <linux/integrity.h>
>>>  #include <linux/evm.h>
>>> +#include <linux/lsm_hooks.h>
>>>  #include <linux/magic.h>
>>>  #include <linux/posix_acl_xattr.h>
>>>  
>>> @@ -566,9 +567,9 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
>>>   * userspace from writing HMAC value.  Writing 'security.evm' requires
>>>   * requires CAP_SYS_ADMIN privileges.
>>>   */
>>> -int evm_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
>>> -		       const char *xattr_name, const void *xattr_value,
>>> -		       size_t xattr_value_len, int flags)
>>> +static int evm_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
>>> +			      const char *xattr_name, const void *xattr_value,
>>> +			      size_t xattr_value_len, int flags)
>>>  {
>>>  	const struct evm_ima_xattr_data *xattr_data = xattr_value;
>>>  
>>> @@ -598,8 +599,8 @@ int evm_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
>>>   * Removing 'security.evm' requires CAP_SYS_ADMIN privileges and that
>>>   * the current value is valid.
>>>   */
>>> -int evm_inode_removexattr(struct mnt_idmap *idmap,
>>> -			  struct dentry *dentry, const char *xattr_name)
>>> +static int evm_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
>>> +				 const char *xattr_name)
>>>  {
>>>  	/* Policy permits modification of the protected xattrs even though
>>>  	 * there's no HMAC key loaded
>>> @@ -649,9 +650,11 @@ static inline int evm_inode_set_acl_change(struct mnt_idmap *idmap,
>>>   * Prevent modifying posix acls causing the EVM HMAC to be re-calculated
>>>   * and 'security.evm' xattr updated, unless the existing 'security.evm' is
>>>   * valid.
>>> + *
>>> + * Return: zero on success, -EPERM on failure.
>>>   */
>>> -int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>>> -		      const char *acl_name, struct posix_acl *kacl)
>>> +static int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>>> +			     const char *acl_name, struct posix_acl *kacl)
>>>  {
>>>  	enum integrity_status evm_status;
>>>  
>>> @@ -690,6 +693,24 @@ int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>>>  	return -EPERM;
>>>  }
>>>  
>>> +/**
>>> + * evm_inode_remove_acl - Protect the EVM extended attribute from posix acls
>>> + * @idmap: idmap of the mount
>>> + * @dentry: pointer to the affected dentry
>>> + * @acl_name: name of the posix acl
>>> + *
>>> + * Prevent removing posix acls causing the EVM HMAC to be re-calculated
>>> + * and 'security.evm' xattr updated, unless the existing 'security.evm' is
>>> + * valid.
>>> + *
>>> + * Return: zero on success, -EPERM on failure.
>>> + */
>>> +static int evm_inode_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>>> +				const char *acl_name)
>>> +{
>>> +	return evm_inode_set_acl(idmap, dentry, acl_name, NULL);
>>> +}
>>> +
>>>  static void evm_reset_status(struct inode *inode)
>>>  {
>>>  	struct integrity_iint_cache *iint;
>>> @@ -738,9 +759,11 @@ bool evm_revalidate_status(const char *xattr_name)
>>>   * __vfs_setxattr_noperm().  The caller of which has taken the inode's
>>>   * i_mutex lock.
>>>   */
>>> -void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
>>> -			     const void *xattr_value, size_t xattr_value_len,
>>> -			     int flags)
>>> +static void evm_inode_post_setxattr(struct dentry *dentry,
>>> +				    const char *xattr_name,
>>> +				    const void *xattr_value,
>>> +				    size_t xattr_value_len,
>>> +				    int flags)
>>>  {
>>>  	if (!evm_revalidate_status(xattr_name))
>>>  		return;
>>> @@ -756,6 +779,21 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
>>>  	evm_update_evmxattr(dentry, xattr_name, xattr_value, xattr_value_len);
>>>  }
>>>  
>>> +/**
>>> + * evm_inode_post_set_acl - Update the EVM extended attribute from posix acls
>>> + * @dentry: pointer to the affected dentry
>>> + * @acl_name: name of the posix acl
>>> + * @kacl: pointer to the posix acls
>>> + *
>>> + * Update the 'security.evm' xattr with the EVM HMAC re-calculated after setting
>>> + * posix acls.
>>> + */
>>> +static void evm_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
>>> +				   struct posix_acl *kacl)
>>> +{
>>> +	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0, 0);
>>> +}
>>> +
>>>  /**
>>>   * evm_inode_post_removexattr - update 'security.evm' after removing the xattr
>>>   * @dentry: pointer to the affected dentry
>>> @@ -766,7 +804,8 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
>>>   * No need to take the i_mutex lock here, as this function is called from
>>>   * vfs_removexattr() which takes the i_mutex.
>>>   */
>>> -void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
>>> +static void evm_inode_post_removexattr(struct dentry *dentry,
>>> +				       const char *xattr_name)
>>>  {
>>>  	if (!evm_revalidate_status(xattr_name))
>>>  		return;
>>> @@ -782,6 +821,22 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
>>>  	evm_update_evmxattr(dentry, xattr_name, NULL, 0);
>>>  }
>>>  
>>> +/**
>>> + * evm_inode_post_remove_acl - Update the EVM extended attribute from posix acls
>>> + * @idmap: idmap of the mount
>>> + * @dentry: pointer to the affected dentry
>>> + * @acl_name: name of the posix acl
>>> + *
>>> + * Update the 'security.evm' xattr with the EVM HMAC re-calculated after
>>> + * removing posix acls.
>>> + */
>>> +static inline void evm_inode_post_remove_acl(struct mnt_idmap *idmap,
>>> +					     struct dentry *dentry,
>>> +					     const char *acl_name)
>>> +{
>>> +	evm_inode_post_removexattr(dentry, acl_name);
>>> +}
>>> +
>>>  static int evm_attr_change(struct mnt_idmap *idmap,
>>>  			   struct dentry *dentry, struct iattr *attr)
>>>  {
>>> @@ -805,8 +860,8 @@ static int evm_attr_change(struct mnt_idmap *idmap,
>>>   * Permit update of file attributes when files have a valid EVM signature,
>>>   * except in the case of them having an immutable portable signature.
>>>   */
>>> -int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>>> -		      struct iattr *attr)
>>> +static int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>>> +			     struct iattr *attr)
>>>  {
>>>  	unsigned int ia_valid = attr->ia_valid;
>>>  	enum integrity_status evm_status;
>>> @@ -853,8 +908,8 @@ int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>>>   * This function is called from notify_change(), which expects the caller
>>>   * to lock the inode's i_mutex.
>>>   */
>>> -void evm_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>>> -			    int ia_valid)
>>> +static void evm_inode_post_setattr(struct mnt_idmap *idmap,
>>> +				   struct dentry *dentry, int ia_valid)
>>>  {
>>>  	if (!evm_revalidate_status(NULL))
>>>  		return;
>>> @@ -892,7 +947,7 @@ int evm_inode_init_security(struct inode *inode, struct inode *dir,
>>>  	if (!evm_protected_xattrs)
>>>  		return -EOPNOTSUPP;
>>>  
>>> -	evm_xattr = xattr;
>>> +	evm_xattr = xattrs + integrity_blob_sizes.lbs_xattr;
>> Please don't do this inline. Convention is to use a function,
>> intergrity_xattrs() for this.
> Ok.
>
>>>  
>>>  	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
>>>  	if (!xattr_data)
>>> @@ -952,4 +1007,23 @@ static int __init init_evm(void)
>>>  	return error;
>>>  }
>>>  
>>> +static struct security_hook_list evm_hooks[] __lsm_ro_after_init = {
>>> +	LSM_HOOK_INIT(inode_setattr, evm_inode_setattr),
>>> +	LSM_HOOK_INIT(inode_post_setattr, evm_inode_post_setattr),
>>> +	LSM_HOOK_INIT(inode_setxattr, evm_inode_setxattr),
>>> +	LSM_HOOK_INIT(inode_set_acl, evm_inode_set_acl),
>>> +	LSM_HOOK_INIT(inode_post_set_acl, evm_inode_post_set_acl),
>>> +	LSM_HOOK_INIT(inode_remove_acl, evm_inode_remove_acl),
>>> +	LSM_HOOK_INIT(inode_post_remove_acl, evm_inode_post_remove_acl),
>>> +	LSM_HOOK_INIT(inode_post_setxattr, evm_inode_post_setxattr),
>>> +	LSM_HOOK_INIT(inode_removexattr, evm_inode_removexattr),
>>> +	LSM_HOOK_INIT(inode_post_removexattr, evm_inode_post_removexattr),
>>> +	LSM_HOOK_INIT(inode_init_security, evm_inode_init_security),
>>> +};
>>> +
>>> +void __init init_evm_lsm(void)
>>> +{
>>> +	security_add_hooks(evm_hooks, ARRAY_SIZE(evm_hooks), "integrity");
>>> +}
>>> +
>>>  late_initcall(init_evm);
>>> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
>>> index bbadf974b31..952d5ea4e18 100644
>>> --- a/security/integrity/iint.c
>>> +++ b/security/integrity/iint.c
>>> @@ -179,12 +179,19 @@ static int __init integrity_lsm_init(void)
>>>  			      0, SLAB_PANIC, init_once);
>>>  
>>>  	init_ima_lsm();
>>> +	init_evm_lsm();
>>>  	return 0;
>>>  }
>>> +
>>> +struct lsm_blob_sizes integrity_blob_sizes __lsm_ro_after_init = {
>>> +	.lbs_xattr = 1,
>> Really? 1 byte? Don't even think of storing number of elements in lbs_xattr.
>> The linux_blob_size structure contains sizes of blobs, not number of elements.
> Oh, I see it can be confusing.
>
> However, lbs_xattr does not help to position in the security blob but
> in the new_xattrs array, allocated in security_inode_init_security()
> (see below). Any suggestion on how to make this part better?

On further review, your current use is perfectly reasonable.
The patch that introduces lbs_xattr (not in this set, I see)
needs to document the use so other LSMs can use is correctly.

>
> Thanks
>
> Roberto
>
>>> +};
>>> +
>>>  DEFINE_LSM(integrity) = {
>>>  	.name = "integrity",
>>>  	.init = integrity_lsm_init,
>>>  	.order = LSM_ORDER_LAST,
>>> +	.blobs = &integrity_blob_sizes,
>>>  };
>>>  
>>>  /*
>>> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
>>> index c72d375a356..76e7eda6651 100644
>>> --- a/security/integrity/integrity.h
>>> +++ b/security/integrity/integrity.h
>>> @@ -188,6 +188,7 @@ int integrity_kernel_read(struct file *file, loff_t offset,
>>>  #define INTEGRITY_KEYRING_MAX		4
>>>  
>>>  extern struct dentry *integrity_dir;
>>> +extern struct lsm_blob_sizes integrity_blob_sizes;
>>>  
>>>  struct modsig;
>>>  
>>> @@ -199,6 +200,14 @@ static inline void __init init_ima_lsm(void)
>>>  }
>>>  #endif
>>>  
>>> +#ifdef CONFIG_EVM
>>> +void __init init_evm_lsm(void);
>>> +#else
>>> +static inline void __init init_evm_lsm(void)
>>> +{
>>> +}
>>> +#endif
>>> +
>>>  #ifdef CONFIG_INTEGRITY_SIGNATURE
>>>  
>>>  int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
>>> diff --git a/security/security.c b/security/security.c
>>> index 9bc6a4ef758..74abf04feef 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -20,13 +20,13 @@
>>>  #include <linux/kernel_read_file.h>
>>>  #include <linux/lsm_hooks.h>
>>>  #include <linux/integrity.h>
>>> -#include <linux/evm.h>
>>>  #include <linux/fsnotify.h>
>>>  #include <linux/mman.h>
>>>  #include <linux/mount.h>
>>>  #include <linux/personality.h>
>>>  #include <linux/backing-dev.h>
>>>  #include <linux/string.h>
>>> +#include <linux/xattr.h>
>>>  #include <linux/msg.h>
>>>  #include <net/flow.h>
>>>  
>>> @@ -1662,8 +1662,8 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>>>  	if (!initxattrs)
>>>  		return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
>>>  				    dir, qstr, NULL);
>>> -	/* Allocate +1 for EVM and +1 as terminator. */
>>> -	new_xattrs = kcalloc(blob_sizes.lbs_xattr + 2, sizeof(*new_xattrs),
>>> +	/* Allocate +1 for terminator. */
>>> +	new_xattrs = kcalloc(blob_sizes.lbs_xattr + 1, sizeof(*new_xattrs),
>>>  			     GFP_NOFS);
>>>  	if (!new_xattrs)
>>>  		return -ENOMEM;
>>> @@ -1699,9 +1699,6 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>>>  	if (!num_filled_xattrs)
>>>  		goto out;
>>>  
>>> -	ret = evm_inode_init_security(inode, dir, qstr, new_xattrs);
>>> -	if (ret && ret != -EOPNOTSUPP)
>>> -		goto out;
>>>  	ret = initxattrs(inode, new_xattrs, fs_data);
>>>  out:
>>>  	for (xattr = new_xattrs; xattr->value != NULL; xattr++)
>>> @@ -2201,14 +2198,9 @@ int security_inode_permission(struct inode *inode, int mask)
>>>  int security_inode_setattr(struct mnt_idmap *idmap,
>>>  			   struct dentry *dentry, struct iattr *attr)
>>>  {
>>> -	int ret;
>>> -
>>>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>>>  		return 0;
>>> -	ret = call_int_hook(inode_setattr, 0, idmap, dentry, attr);
>>> -	if (ret)
>>> -		return ret;
>>> -	return evm_inode_setattr(idmap, dentry, attr);
>>> +	return call_int_hook(inode_setattr, 0, idmap, dentry, attr);
>>>  }
>>>  EXPORT_SYMBOL_GPL(security_inode_setattr);
>>>  
>>> @@ -2272,9 +2264,7 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
>>>  
>>>  	if (ret == 1)
>>>  		ret = cap_inode_setxattr(dentry, name, value, size, flags);
>>> -	if (ret)
>>> -		return ret;
>>> -	return evm_inode_setxattr(idmap, dentry, name, value, size, flags);
>>> +	return ret;
>>>  }
>>>  
>>>  /**
>>> @@ -2293,15 +2283,10 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
>>>  			   struct dentry *dentry, const char *acl_name,
>>>  			   struct posix_acl *kacl)
>>>  {
>>> -	int ret;
>>> -
>>>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>>>  		return 0;
>>> -	ret = call_int_hook(inode_set_acl, 0, idmap, dentry, acl_name,
>>> -			    kacl);
>>> -	if (ret)
>>> -		return ret;
>>> -	return evm_inode_set_acl(idmap, dentry, acl_name, kacl);
>>> +	return call_int_hook(inode_set_acl, 0, idmap, dentry, acl_name,
>>> +			     kacl);
>>>  }
>>>  
>>>  /**
>>> @@ -2354,14 +2339,9 @@ int security_inode_get_acl(struct mnt_idmap *idmap,
>>>  int security_inode_remove_acl(struct mnt_idmap *idmap,
>>>  			      struct dentry *dentry, const char *acl_name)
>>>  {
>>> -	int ret;
>>> -
>>>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>>>  		return 0;
>>> -	ret = call_int_hook(inode_remove_acl, 0, idmap, dentry, acl_name);
>>> -	if (ret)
>>> -		return ret;
>>> -	return evm_inode_remove_acl(idmap, dentry, acl_name);
>>> +	return call_int_hook(inode_remove_acl, 0, idmap, dentry, acl_name);
>>>  }
>>>  
>>>  /**
>>> @@ -2397,7 +2377,6 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
>>>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>>>  		return;
>>>  	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
>>> -	evm_inode_post_setxattr(dentry, name, value, size, flags);
>>>  }
>>>  
>>>  /**
>>> @@ -2458,9 +2437,7 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
>>>  	ret = call_int_hook(inode_removexattr, 1, idmap, dentry, name);
>>>  	if (ret == 1)
>>>  		ret = cap_inode_removexattr(idmap, dentry, name);
>>> -	if (ret)
>>> -		return ret;
>>> -	return evm_inode_removexattr(idmap, dentry, name);
>>> +	return ret;
>>>  }
>>>  
>>>  /**
