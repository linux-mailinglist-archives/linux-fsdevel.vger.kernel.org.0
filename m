Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0462378F59C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 00:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243209AbjHaWhG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 18:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbjHaWhF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:37:05 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F27E77
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 15:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693521414; bh=Er64qStO2lJVsiwieYOsZBq2EwIxE/6LnXP/O9CvQ+s=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=g7zRMOfcyogstX/max7aUs0hwovrfKERJGNK0ZJTlX220cjwPUnLI0+FZeK3aMKAF/e8N/VsYoH1tHYcDEMoRaqpS7fbBG9LvptVMgGupU5FVYmiEHPg76kBt5rqFgLmBOfbWOpinvNk585OhQ4eRdSTCoFeBfnJa0yK3RN+Kh96529eIAuy3SnDWPJfuB9o05SHCWJWLTIGHRsKmfR9tUGrrMUJMg2Da9L9ChFd2sv+NlWVvUx0aHpsm8KsgAzRj/Za7vkMG8hr8QyTOGe5XOw5j1YVoAkwSSXIRcRjITQ0z5XQRWJebKwZL+XkOaeNuRVAVWl+JRJ8YjixxkLjXA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693521414; bh=pot0tdvyWJxXBhPrD8pZbuUceKNyRNMvWSAGwWyeFYB=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=krMQIg+9hBCai2S4cJ+9stoRrDp1weRqzPEpHFxfKVC3xQWRQ/hvATvN6JTx+YhAaoqMrzzqX4LU3XbTeWeElPtb7VEhzeho5+/G/fdLK+p2J2isgzNdSQEAcJyTIK+Dq2BZwUM1XjZjPl0SBlgHDqmiTci3idxG2PntDRS1xKRsvbwWCG2d8IFaXw20R/geExZbzA9UEG2KK6DP5Bd7MN0d30ly194qoimCK4pOa0FxmHUniRFOynZLnumGVP5rK38sjI88r3hnW5/Hl3W6nuAnOUpZPSwhs21geebMWv2LbBqreGpvHQbgqJfuVNPNEn2thDjsYzxgWtyPKl0QMg==
X-YMail-OSG: rQHRDIQVM1ktUCZEen_SPKGIPSqyUD9RIR1PkP5yx88dCJ4AifTIeu9MOH3b3Q2
 oMpb5rGt3CZuGVbYsNezW6cdGxKEb35Wu.fWWiEc8EoOZGL5r9hf8kVGjHpW.2AgnhI25SsjrquL
 DukWaKInO_376NKYHsUV.f7A_zGgeVlEf5E6rPJSQDkWQrlBSbzsHn1k_FbdFRTMFCEW8Hv5klGr
 SyoSnS4HHHmmGIAh14GAzwXDx5cIC_rPF26UNXqgd6GyhzUGDHix8BbUM2G7XKrJhHYCutIXPTWJ
 1TxvGj0f6tmbOAparCA1KNZQ_r2QiPP_4U5gyY3J3NF1sUlp2TT4C0cf5619UmjUL1LLjTkonXzK
 Zhg_nUtyb4FC5zDFuuNIVAnSt.rgr5WnsFlL5SGmhhL.9K0qEnjJ7VJmpvKyvZAPLoIc4F3lWOZS
 MpZrjBl9NIYw6nMnLP_CWq1wZNLBKSJ6pbYf8ZwaV5nEjOh7ZomQJCbQc.NLH1D_PnXweVCVUCEI
 08Dh1j9ZlaPyx_WbDOSSS.ufhCgqux628NfvciNUJcyY.ObX6EFwMUfQmzQaC0lcYvkoQbt8MlEq
 .LyImpK1nC_LO5ZD9WrqaBXk3PjyEU7hvB93svyQAX6hquswareEMFCBITb1nUdhJh0LbTZj1t94
 SCpA7c7b74Onm4_n7CXbHJRJaJ4ljzrSFNka54KWxjYaAMh_SN3Wepf4uVdPaAJ7nT8tJVqCd5N7
 l8oHFewA3dZXjC4rDkF8YONqBuO5mxqY9RDnA8eDGrv7z09az1p4vMysB89StdOcrCj7Ynoq0Nxz
 zgR48GyobdfpA5DK0NB_52M9YMs8eBGi4CpnDC4yVa5HFYUglmeLmI2r5W7pqc7X0JpuVh8A.tdv
 WoJ1f918jqypRPM2J7FZYdMLQxEzpngza60dhhMgOvOacvIjzURTp_in9pHt9Ekewy7YV8PMnpI5
 BaLL.0tQmvgRwcZ4wcuGCy.QhuazVtUcvNQ_7lxRkeWacYjiE7i2o9hSaW458gkDfExubx7HcWze
 yAQ02Z6pMqIZeU6u1VG6nn_hrOWY91RLG1KxE1OG1ZQwe3e73H92pyAgG2_y_JXO5rDmhPaVV8Oz
 At_E8lGby3KBLM8.aiXjl8YG55xuKvfs_0TNUcNfsYpLeV9SLR8WMtN4soAb8_uZiDnzOeSuAxJQ
 3un5tBKWlnoAldiobKS2UKvDwdLrDdzuz0eLMPzZOkMl39kmlTcKOxKczYhoNxlLhsrc7BxTORJr
 7xKz6QSfMyDU5vpoDWbfc8QnNt18olD27jBQyKwF2vsD7CV7GyVmya.AHTeBddIOE3IuuWEKucZE
 oi0PYTJSP8TtrHwkN0nC7Tfr_yhpkbnNRJiHcDnjNxI3GQicxMRub9U3h8PKhIfSNlVdWgK16uIc
 8rj_9w9TnA37qpApS8GobQmQLPftLo9DN0p5ZwdqLXTjbEsDb4RqQ6FWZEW4lz4f79Q.TF7O9Eab
 rc2m2L1rPYtHezQOkKRkFBBv8prcN5PdfHGp6gPVOa3O6mLfvgKg0ctVix_bb1ahDakQqwDTXRub
 p_l_y2g3W_Tg9gJ6zEgIOpMVmdSAo5t_SEZ7Jdva2lEuM9AnPqe1cX.72RZE53VzYl3H328DjjGT
 qtn5V9zxp5J09lSU0K2aTRr30kfNeqYHaunVqTnQdq1HoQ1m2wL7tikjE77eTFGQzDSFPOd6qhoK
 rm6xiTMwOocRbFquuRuZD2VtA42Cr3L28mJI3euSHbAPpIZueGx_AupWpSyDhMeAzx.a7VjAocIg
 WxQZ2UO__d1uGTsbGSSzpuZovSYxQLKxqFHuqz48QeqTAcI1UUIZGX0.BuL4jKBWsxSWV2Eg7tmi
 4Pdc7DrLGWrNZsjrgOBNxIIY.NUGWdenQhoz2Adu_P56Lor2PBeSrYZQ1aym1DdEXPKE2UABx9jL
 kzr_6uFGlc3UAhkxidgboNS7WRAYIVleqY1_l7COoEFU30eSL08tP.aQxLxU9DTu_LlX_Yqpw1dV
 zdyl6RUHiRqgudNxqLNvOib5.8LV8z8mNVfDo37BiBpca1NjcHgO9tHgJW3aySmFeF0xiJdIPpIU
 f956SnyrUSYMGfN7bmv7wi9WNrWFcFjvfQSUfNpwZqsSu2on01B_YVvxWc6NJ59dealIfq15iyGe
 R3uYPXYfBtcR8qiw2oQi67r.wfMMFrpGEludATUp7EF2BIVr7BokqHyArG.ezjEz6hFX3AGsisEA
 TkkmUcqWO0y66tRiaVE321.zBHuxlEaio0TxLfmsr114w0MXpuV54EDfnKEpGRs17dAGwD4r3hw-
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a4e3ead2-7f97-4b7c-a330-9fd0d0bac659
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 31 Aug 2023 22:36:54 +0000
Received: by hermes--production-bf1-865889d799-jmdc5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 25ce11297d4690952b748067b5435b7f;
          Thu, 31 Aug 2023 22:36:50 +0000 (UTC)
Message-ID: <040eaca2-ce98-e826-cf48-30b298fc66a1@schaufler-ca.com>
Date:   Thu, 31 Aug 2023 15:36:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 19/25] security: Introduce inode_post_remove_acl hook
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
 <20230831104136.903180-20-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230831104136.903180-20-roberto.sassu@huaweicloud.com>
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
> the inode_post_remove_acl hook.

Repeat of new LSM hook general comment:
Would you please include some explanation of how an LSM would use this hook?
You might start with a description of how it is used in IMA/EVM, and why that
could be generally useful.


>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/posix_acl.c                |  1 +
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  8 ++++++++
>  security/security.c           | 17 +++++++++++++++++
>  4 files changed, 28 insertions(+)
>
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 3b7dbea5c3ff..2a2a2750b3e9 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -1246,6 +1246,7 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  		error = -EIO;
>  	if (!error) {
>  		fsnotify_xattr(dentry);
> +		security_inode_post_remove_acl(idmap, dentry, acl_name);
>  		evm_inode_post_remove_acl(idmap, dentry, acl_name);
>  	}
>  
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index bba1fbd97207..eedc26790a07 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -163,6 +163,8 @@ LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *acl_name)
>  LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *acl_name)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_remove_acl, struct mnt_idmap *idmap,
> +	 struct dentry *dentry, const char *acl_name)
>  LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
>  LSM_HOOK(int, 0, inode_killpriv, struct mnt_idmap *idmap,
>  	 struct dentry *dentry)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 556d019ebe5c..e543ae80309b 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -373,6 +373,9 @@ int security_inode_get_acl(struct mnt_idmap *idmap,
>  			   struct dentry *dentry, const char *acl_name);
>  int security_inode_remove_acl(struct mnt_idmap *idmap,
>  			      struct dentry *dentry, const char *acl_name);
> +void security_inode_post_remove_acl(struct mnt_idmap *idmap,
> +				    struct dentry *dentry,
> +				    const char *acl_name);
>  void security_inode_post_setxattr(struct dentry *dentry, const char *name,
>  				  const void *value, size_t size, int flags);
>  int security_inode_getxattr(struct dentry *dentry, const char *name);
> @@ -915,6 +918,11 @@ static inline int security_inode_remove_acl(struct mnt_idmap *idmap,
>  	return 0;
>  }
>  
> +static inline void security_inode_post_remove_acl(struct mnt_idmap *idmap,
> +						  struct dentry *dentry,
> +						  const char *acl_name)
> +{ }
> +
>  static inline void security_inode_post_setxattr(struct dentry *dentry,
>  		const char *name, const void *value, size_t size, int flags)
>  { }
> diff --git a/security/security.c b/security/security.c
> index 4392fd878d58..32c3dc34432e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2323,6 +2323,23 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
>  	return evm_inode_remove_acl(idmap, dentry, acl_name);
>  }
>  
> +/**
> + * security_inode_post_remove_acl() - Update inode sec after remove_acl op
> + * @idmap: idmap of the mount
> + * @dentry: file
> + * @acl_name: acl name
> + *
> + * Update inode security field after successful remove_acl operation on @dentry
> + * in @idmap. The posix acls are identified by @acl_name.
> + */
> +void security_inode_post_remove_acl(struct mnt_idmap *idmap,
> +				    struct dentry *dentry, const char *acl_name)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;
> +	call_void_hook(inode_post_remove_acl, idmap, dentry, acl_name);
> +}
> +
>  /**
>   * security_inode_post_setxattr() - Update the inode after a setxattr operation
>   * @dentry: file
