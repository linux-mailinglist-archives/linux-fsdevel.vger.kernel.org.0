Return-Path: <linux-fsdevel+bounces-2283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D43107E4707
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027101C20953
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 17:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53954347BF;
	Tue,  7 Nov 2023 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="B0TOtAe3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FD931584
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 17:30:35 +0000 (UTC)
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F1E120
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 09:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699378233; bh=4mvUGte+rxd4kGjxEynZpmzerpq4vpQ9zAaJBYqTdQM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=B0TOtAe3ba2APBGID9YzN0oL/S+GU+/I9Agjs7YK+5XHepKJiF8/jJXubosotrqXCNtdtzCxCkbJsZ8xxw3f1oyryL4oSMMKufOjGJyX2uBEEg7o2zyat0d8soO4X7E7Jx20134IZJNQ8gRQs+8ioGE556VepFrbiRCVmOC4EIAJsxtDT2NxLYmINBg2159dD+p+iOuuwhzzQ1HB+Lb/KkpU5Bt75tl1trEKkpW2nga0n1TKkyiNcykKE+Xz+R5QrsXv6lY1TXx59uNDoL2SroEfvrveT6dR4nzIz7DA30VFB410DaLs2QyRDoHuqEOT2Q0GK4ojqZTh3hVVS4wgcw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699378233; bh=G0kC7jl2nDUM3B4WWtR1x++FS9fDBlSo6E7q8SFJkz4=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=HEr1cFQiM5QdbAUCPCZeQGRJHSffUVOhDOeK26TWdp0QOZ0mJabvx+VtbFHKcxy3r1jC9g6ByIWjxu0PUYXgHkhgVqySeug6BBNU875E7dI0onexoQP7RLZ1qw3v2duevH0HMZdXJxYAG6ZAdbiSeZWd8M4eSz71YxWbPDmHHWLNs0E07vITxbESd4dHVir7ZQZLF4XxDiN/DA1vKXK2V/tyPfcaDwVIpkiZIEAwD9wPBqQT57G7ztVfZr0V6rDxURYlNU99ivOtKNj+eWoU3RIscSEwFjtrx/ApgIcMtYhzU5j2/fAeAA3rCnYgtmcrOH1+2PVspLmAxbchWJJ84g==
X-YMail-OSG: 7ADUdQEVM1mer9GPy8o1ZT1uSFP.HR1emroCTqRxYAwx.Ox3CmPuHK0IgDzmkPG
 HOzxepBBX_ETwJpZCR4rQOxgCpjkteGKdy4HomHeN1eMgpdJviKfBrxE_Y2XMIswjVbZ9pLiQwMJ
 2x15FOIu_qRFWRLLWZdefoMP5R_RxSzaRQnsEPlrd.bSZyM_nS5KYmC8XlggomkfBvnixlXQlDta
 22WDnjNMGFOQ0KBUvh7ShAGBg9c2yL7aCxL2mnNnQEl2Szhv5ImEKvel1tQI8YtDLtdr.xYy1eag
 f8sifKCePj.VZvI5Kzqo4W0BEmlMZUR_yG4jcG6gDhPQPMZX.Xk6H4FiVCoXpoO7IzoGisR62ki.
 0NKGl22PoYvSG91Mui7CPyIz_HkV0gmuPfy17Bjw4WGXXPP9WPq9gIP7l.qQX.EGs3N4Qz2XOYkD
 jBP4em.0ZJfVDxTYG3DOlHYK4EHd2X9MJKcyzM8A68yhF.X4eCfd3vcMQzbcnOF7V57QdZ_cNRCi
 DMHg92Xw6ZxjSd.oRCAlY3xVRCexMVA1sBKpcoP9aU0u9pYyEKSbzjNirNlVkiUCCaxh2LcAPcsg
 WDHzf43Zza3UI5dtoYNyYqA5Xg3vxGjIHM9dFkiDarybfL2704e60AgQ3zgW8pjQdzWqAs1wDtHb
 iKl5L7DtxsihwflbAH2vPTqpCIehqgu8N5wmbm68kPAdNVSKAnatf1179_ZA6l7YUmLQTJadLMDt
 AA97FSazQ6Bm6LXBFWv.N5sdN7ZQt1S3fVuWAZDD9fD74wmW6zHtz_3ZIyOwnaeQHJWeul3q0pZ8
 sO8sbgOluOJlFB5M09hTSCg9mH0iJaqBr0v8oVWxFC_FiTDPlAFy7dmbuTmpmAFW5.J2e31ay2oE
 Lz4m4NJ_bR4jBFWp2MnZbGVtBpeke_ceyhPju.hs3nvjZQxnDjmN9fb2A008i6W2AaVUcctxNb85
 PAim6UHlcdmo81bEKSJ27JscqpSoeThORZf3EldG7Tzn9ScV9NyfSYvYULZbs7ZM_kAKKbv7KWTM
 mGrAVCTs2VxbS_TIMBTT78_srNgrWXVxj9QIVRD_kzV.IV6icS9eO4VAyZjEb3dAA8GqpHcDiKyS
 LZg7jbbE5gkcK_fvzF.JCXMZgP9Od_Ntz5c4IEoqdM1O7DRgXqxa6MntXvOykMYKdFOj9DlQ1VDV
 JKg_.45qmlpNsUaW2fjCOdnx4ZqqiF43hCLdtOHHezAw7tMkks_nQm7chwbp_Wa5a7YFOxgJpw7w
 btSQ3RMysILagkeFH0V.gmayDi8HS.oe5fVy0d66B.de4EdiYC13Y0Ts351pV1eH5oqaMfb7rVTY
 Q4pVofElnaaZacnFahWkYTHgxiOWEebyozwuWXjX2gJS3uHXjaXx._0AwQVXuVfirEqpA.iM.roP
 5hD7xiRxEXlKi9rv789qmLYXgNMfQ_Y7TXBuBVjQq3GrZKU16_31tJ8vQh3W6LtGgFmM39LOfAzn
 _O7kOJLCRrBNyu4O0BgKmqP1cnGIR9euuXq0OcooGZtmzzOfQWbOn3OQbyN8.8EbskOL7RsXv0MN
 GJZzydU.DMbYM9h.7NCmrPYpg1ziCIudJZD8q_SjAfpbcO5Nhgu.jIVqmcxUM8QIhtxv0LwLqMYf
 6eg1Pm0zTpFi4JVEXqOBzQfW5ArepxYWdUG.0Kf_9mUqLE1b8hxV4ly3ZX4_WdVzgJZTwfvCwp4E
 .1gCqPO3bRiOxttYLmKBvmJWet81MVgU8n1XckJhL1bqaJAu8u.6eEPj8nk3tVGhC26Fh46cvJjx
 R4LjTmNQo7wGdaFvbuCUeh626QiUBTin7gMMslWWkrlUgAlAU0FD0WbHh.5mCV94gYaudVI2a20j
 f_TRMcMJn1g0eg53G5JWaoTY6zl4yKfSpohyOhp2ZHJZAzTeT_gw8iRYpscTAL4TtDXLM9BErMIS
 qrwIlVB29Uz0fqhi0iF.7HYFS9UV5s59t75LPhSlkReJ5MryMlsLg8yX6cNoPrFRANMFz7fc0SbB
 I.kEFEncwTghjk8Ey1u.GB.3O9OzJ35G1yoi9.1oT2I6EEEYnp7aoSJmls7ERtMynWN9tAgmBXfU
 XX.Bxwhk1_h4yin9PWFrt2I2p68KIBckOs0hKrQVV2qcfLBMdLYO2Abw8SGDMrf.nyWgTwsxf5NC
 SGVn_G7zFwmxpJOTqaBjY6FeJrcR8HeNb0vNknNoH_6W56EnuwLvHOFmqIIeFCwY5AbDGK_XhZco
 SE_bg45ldCp16R7op.jf6JOslf_UfrXU5fdz0SerV43ehhq3Ces.eg_DQIhoHZrzW_CtJF3c69TI
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 414a813d-6343-4b1d-9c76-f2cca3a2c443
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Nov 2023 17:30:33 +0000
Received: by hermes--production-ne1-56df75844-w2gpf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c16450e0bd5ce2538dd9ae9fdcb6159f;
          Tue, 07 Nov 2023 17:30:30 +0000 (UTC)
Message-ID: <fde34f87-70ac-422c-83f8-a822e326fa22@schaufler-ca.com>
Date: Tue, 7 Nov 2023 09:30:29 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/23] security: Introduce inode_post_setattr hook
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
 <20231107134012.682009-11-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231107134012.682009-11-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/2023 5:39 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_setattr hook.
>
> At inode_setattr hook, EVM verifies the file's existing HMAC value. At
> inode_post_setattr, EVM re-calculates the file's HMAC based on the modified
> file attributes and other file metadata.
>
> Other LSMs could similarly take some action after successful file attribute
> change.
>
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  fs/attr.c                     |  1 +
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  7 +++++++
>  security/security.c           | 16 ++++++++++++++++
>  4 files changed, 26 insertions(+)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index 498e673bdf06..221d2bb0a906 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -502,6 +502,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
>  
>  	if (!error) {
>  		fsnotify_change(dentry, ia_valid);
> +		security_inode_post_setattr(idmap, dentry, ia_valid);
>  		ima_inode_post_setattr(idmap, dentry, ia_valid);
>  		evm_inode_post_setattr(idmap, dentry, ia_valid);
>  	}
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index f5db5e993cd8..67410e085205 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -137,6 +137,8 @@ LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inode *inode,
>  LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
>  LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idmap, struct dentry *dentry,
>  	 struct iattr *attr)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, struct mnt_idmap *idmap,
> +	 struct dentry *dentry, int ia_valid)
>  LSM_HOOK(int, 0, inode_getattr, const struct path *path)
>  LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *name, const void *value,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 750130a7b9dd..664df46b22a9 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -361,6 +361,8 @@ int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
>  int security_inode_permission(struct inode *inode, int mask);
>  int security_inode_setattr(struct mnt_idmap *idmap,
>  			   struct dentry *dentry, struct iattr *attr);
> +void security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +				 int ia_valid);
>  int security_inode_getattr(const struct path *path);
>  int security_inode_setxattr(struct mnt_idmap *idmap,
>  			    struct dentry *dentry, const char *name,
> @@ -877,6 +879,11 @@ static inline int security_inode_setattr(struct mnt_idmap *idmap,
>  	return 0;
>  }
>  
> +static inline void
> +security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +			    int ia_valid)
> +{ }
> +
>  static inline int security_inode_getattr(const struct path *path)
>  {
>  	return 0;
> diff --git a/security/security.c b/security/security.c
> index 7935d11d58b5..ce3bc7642e18 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2222,6 +2222,22 @@ int security_inode_setattr(struct mnt_idmap *idmap,
>  }
>  EXPORT_SYMBOL_GPL(security_inode_setattr);
>  
> +/**
> + * security_inode_post_setattr() - Update the inode after a setattr operation
> + * @idmap: idmap of the mount
> + * @dentry: file
> + * @ia_valid: file attributes set
> + *
> + * Update inode security field after successful setting file attributes.
> + */
> +void security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +				 int ia_valid)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;
> +	call_void_hook(inode_post_setattr, idmap, dentry, ia_valid);
> +}
> +
>  /**
>   * security_inode_getattr() - Check if getting file attributes is allowed
>   * @path: file

