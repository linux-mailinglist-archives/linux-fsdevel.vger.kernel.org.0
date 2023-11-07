Return-Path: <linux-fsdevel+bounces-2280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F717E46E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AF81C20A68
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 17:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D4F347BB;
	Tue,  7 Nov 2023 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Krbf4stk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FD5328D4
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 17:26:04 +0000 (UTC)
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D17A121
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 09:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699377963; bh=qO4NEDUtnx/yjPD7AaF/5TOOtuISQMQiUsBsGQRYEZ4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Krbf4stkcKfj8KHMh4FkNnwnCaXQuw6Xa5gwR/5/oSFa8IeaH1z9kpYVGtXFflL3qrPhrMnd0Sd3cL3U4H+9YOS6/lZYkgTYcKDliTNYDOTCalzTUgqY3jwy+6Anw5dfyO/yUg7ebOvyc4Arx+0pt6TQqWLbOLjEXlbZhDFOR8Zu/aA52axFXsrqtPGoA8uvoobFwWo0zLr/YQKTYjUsb8xPZdKKROaqt2BydEnbOUWFgnlMY16xyLvWianNjGHx65bWJDUJWhlWEBkGJn6hy0EXL/TuDH5Q0ldxbSCRZ371ypcgPV8Ro+7CUAVk+LnDf4suQt6oEt51Gf+V730vqA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699377963; bh=hMcHEXnMA105vSkQfNfMQ43caYxZPHAKELFtgvHNs5A=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Mi/caqnggXKn8uOPS9zpxFB24aCjV8VIBNiMQdTCAkE2a7YQVpMOG644YjfNHTBeeLAxMD4w3ffDsf9mAKoAx4XIQnRbBKvimz8Nfwp97DSzSvNpRbLkZqGg3t0rYw/IP9K77QVc1yuBPKhZ3dXLwkJ5VgoxwbCnt4/Oz7EZMlD2wLA+iUbHqHJlPNBe7omNCTpynfPYmhTXtwcAYOeaHcMuNKRkOz/jUMGU6cmSspESG7iR8OM/aBU4m+Ridyzm2hlS6DkzSCwc6iULMfDcd8SFAgy99WxAoccnSpqBZIYnkikrfFdtpkLFNpuHe44KoE/fTDtpSgw31InAxKW6Sg==
X-YMail-OSG: WI_4YOkVM1lmwqv7gxEz3HfzLtwSRuWKojtBNXnmYWnLRFS7je9lzJVC3lEhhbD
 CqYLywfNhmJ4RGe4VyDKPkaz5rO4czXuW_X5E7EEvqr705jmY.C5RM1BrTn9fbXCFy4_CcJ52Ha8
 uDZHNQeVEMz1jecZEfRLWsYAk9D9dd3SLcUKkK8DE8AnbXMA5SZF9GUUjUvyFjp4gqi_JlDITAs.
 YWAjLwFHXQ0T.mKXSdhnPdYDVmz1dsQ5BsDhxQLyrN6Rq3TD_7TovXmhvlSu58liQIpuGKL53iTm
 5OMfFWHj2o8FxwifBX1VwCJC8KZruwdKq7ootBMc5y_SgzHSz612aubNck_Irm8GQ9daoHP0he6v
 vUzFAA28qsczG6LDMs7AYyQeI.M6b1kuszm3IrAEFSKLtuzFKvhl2kKV_dzPJyEn967kPPz1T9J1
 4UK1X8HLOvTnj.qkrpR6X9O1YjCC8xJokpH13NDFVls0HO1ze7EZLffEoJ5TiN63cBSMb_FDgSL6
 SjpGPv_40ZbU3cASRWP28RQBh97LaXWX9QhQacmMOHC5IktjQLbL9KQNMYZ12Si6iioAe7jeZ6mf
 Lnl.aCjzyQ6KDc1jRxH8XMvV9Xy6dI9g4muRqPbwLiSF.kD_0ZpwYtCInqnyGbovHmIJymKJITF4
 cZfoi4A1Pkrrw1Y2yQP0wtKKt_w5C6tEeEk8QKaSyP8UorwykGSHOCkJOxXXGsJO9cY.4Y1lfdF6
 o_ExYh6Waoy2BIAAAPb8dACSw.15C8CY.IVHkhqi.xIs27NKFXu57OsuYv50u5JzE4o84R2o6cf4
 0BTCB2l_MgRxxo6rqz0bPtgw7pfdyFhvKf7SrSjVjMnDQN3EX0YRxOcdwqr_9QwWZ1JS3wJBC1iH
 xG7thx71JIVbSVV8oTaaXAUUXKJ71emo96jFk03HpQxckgQKCJ6d6PudLGOLESIynDyJSvfdC6kL
 5euoGw1jBNxmlV5EPkqgRR5Xr3pb_4YvUbFmc45OWzw7gPsmYpW8Lv.LOPLvhVGsgeL2IWloiGUC
 ZY76sX5bhpr8rlAry3fKNWRQwMetYAQM4VjvaiTGUqnLn_odvYM6lQoxD2uYpLqkVvEX8aAJmjVr
 5yEcLvpaZh2Wlil3ALipg6s.dvFn3TMN._3BfneJhyXGPfyDbyJM._lN3XMc4zVoUcnHdTJoA.nU
 cpQr4KePDjHs3P43yXsPGcmJWbYmlO5aycW6EqDzGSOs3EODidzMExzC0hbm5bR2dmNBJZqCmBr7
 95qRFzIh.f77HPVk2NrFoxd.efeNCEU1EovBaQREXqQDwBEucZky4u7vtn.G9Y33Xd5WcBglM_jh
 Tv.gNYkB8Ttm9ibR9AiuIt99cX4B6YM8vbbKUfidbBVQwoZ1rK4VNXzeNo.Ir4Wr3PLqh9zaYsqo
 xyQfRMAR09OwS6xUnMLav5cB9H4yIBxTT2E0FNOm6hreO1.1nydsmBzLlqJ54cCMThZbFC7VAOEO
 6kh6c0WGOkfVsuohPF7b_Qm6Pbd86OjCsrRq5n4DZRrYwxsuCGGfHdYPyK7fxTJXhY3KpWN5BUV_
 xTdJrFynipbz7WULDsVo1DUWnfx8jbtNSbJLrulX992.jhAxnWYXHxMmsQTHAtzI2lzRJ4xpNoFr
 y7pOd_rN8857wPJvhE9fdvfuoQATp2PsKWCJZ2FbJGIs43xOKT8NY16kjI2Mt7Ud.sN2Pe.PvwNu
 M.jFU7kUnkDrXpThrHFLibOjS_Ga57Bhch72CIq.5aTTv.jz.85BHET6liVbN63NHNdFYp0xPPQF
 PeqrpNuznrG2I58vEFj.qxphaNsI.f_VkbwAjqTtwumd4ThUHKq11nExqcvOnUjlJTj1IpYhdzHR
 SMTMRMUBV1RIsr.pPVId_mq.LUOie5RUbN7T.Sbb5BMx.6CyHb55qWE6LTeRNuFAXPtljU.nS_5W
 sODSjuBTnScNCYP.zMEoCIwH4LeB2rRt2l7RhUOu4naKF9GDCobgbA9OgBpGHLFPGaAPnBJRQgpl
 jCIpVoQsSBHvKOvkWaFe7AQSPszLalviIvLcH21I5bx6BW1BERPhJKRXudOb32KljIGleCw3WsKe
 u6Tefe59rlBUmkIkk22ps56ISR_N6UWmDOtHEThlJfkgl.Nb1.xsrAeq3YNKmKsQI9_rOkrFWPvD
 JwYOLlZIWWUvMQ7XXVkR0q3kD2siwUy7lfG.mCABP9y5YAUvHizSYHJwkDtfX8637hUT6tLuD750
 jnWEdc0p7pC14BhtIRYf41TFZH5UoXdyA2VFzWDLE.vY3Yg7aDYJd0S8TDwuBKeXwl9KDiew-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 24599b41-3e06-454a-9983-5f3fa9fdee5b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Nov 2023 17:26:03 +0000
Received: by hermes--production-ne1-56df75844-79fgv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 521851d72cce979ed62dc1adf02bfced;
          Tue, 07 Nov 2023 17:26:02 +0000 (UTC)
Message-ID: <4788b9a4-4d95-4e10-84d6-bf947f72b6df@schaufler-ca.com>
Date: Tue, 7 Nov 2023 09:26:01 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/23] evm: Align evm_inode_post_setattr() definition
 with LSM infrastructure
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
 <20231107134012.682009-7-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231107134012.682009-7-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/2023 5:39 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Change evm_inode_post_setattr() definition, so that it can be registered as
> implementation of the inode_post_setattr hook (to be introduced).
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  fs/attr.c                         | 2 +-
>  include/linux/evm.h               | 6 ++++--
>  security/integrity/evm/evm_main.c | 4 +++-
>  3 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index 9bddc0a6352c..498e673bdf06 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -503,7 +503,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (!error) {
>  		fsnotify_change(dentry, ia_valid);
>  		ima_inode_post_setattr(idmap, dentry, ia_valid);
> -		evm_inode_post_setattr(dentry, ia_valid);
> +		evm_inode_post_setattr(idmap, dentry, ia_valid);
>  	}
>  
>  	return error;
> diff --git a/include/linux/evm.h b/include/linux/evm.h
> index 01fc495a83e2..cf976d8dbd7a 100644
> --- a/include/linux/evm.h
> +++ b/include/linux/evm.h
> @@ -23,7 +23,8 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
>  					     struct integrity_iint_cache *iint);
>  extern int evm_inode_setattr(struct mnt_idmap *idmap,
>  			     struct dentry *dentry, struct iattr *attr);
> -extern void evm_inode_post_setattr(struct dentry *dentry, int ia_valid);
> +extern void evm_inode_post_setattr(struct mnt_idmap *idmap,
> +				   struct dentry *dentry, int ia_valid);
>  extern int evm_inode_setxattr(struct mnt_idmap *idmap,
>  			      struct dentry *dentry, const char *name,
>  			      const void *value, size_t size);
> @@ -97,7 +98,8 @@ static inline int evm_inode_setattr(struct mnt_idmap *idmap,
>  	return 0;
>  }
>  
> -static inline void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
> +static inline void evm_inode_post_setattr(struct mnt_idmap *idmap,
> +					  struct dentry *dentry, int ia_valid)
>  {
>  	return;
>  }
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 894570fe39bc..d452d469c503 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -840,6 +840,7 @@ int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  
>  /**
>   * evm_inode_post_setattr - update 'security.evm' after modifying metadata
> + * @idmap: idmap of the idmapped mount
>   * @dentry: pointer to the affected dentry
>   * @ia_valid: for the UID and GID status
>   *
> @@ -849,7 +850,8 @@ int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   * This function is called from notify_change(), which expects the caller
>   * to lock the inode's i_mutex.
>   */
> -void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
> +void evm_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +			    int ia_valid)
>  {
>  	if (!evm_revalidate_status(NULL))
>  		return;

