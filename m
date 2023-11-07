Return-Path: <linux-fsdevel+bounces-2284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBD07E4711
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B618A281278
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 17:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EE7347D1;
	Tue,  7 Nov 2023 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eZFMu3Gn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F638A
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 17:33:15 +0000 (UTC)
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCC8121
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 09:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699378394; bh=zf97E5fQOmwEUZTrOUJfjV16ap+E6HRN8Abl+Fs21hM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=eZFMu3GnAaEb4Kw9MnRmjheYeGx27hVxuWWZBZMGMgRaibWKAWvJQWNCt+rtn2V0HKIKmNGxFda8pQUMATV8caXGOseOvUaPziQauOF3qaMk9+M4Brjxsk3Jl5h0I08N6tpmx+Wq7z12cSq/D+ouWjb/Uin/tNDf2Hg+IilUGYkhfbErg7JHE2M3fILKzZHcjZWWAX3Lpr9mhl5mi7DUwSO0ntnHvI8NvChjqmazPQouXoXIq2vYR3foH9FRznpbOZhdljZ7kH0IQJkTAY/uYM8gTK5zeNsZHjBpbZifDyi9ES4hS9tbkWnFpAqHyxGiF5O+kv0N+A3J8BB/oL6Rew==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699378394; bh=NsJfhS+KEbs5rxVz2I3p4EDDzoP0yv5oslo+77mUmrr=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=b4Ao3T3ryUcIOOBKzZBFeC7JpiOBqgoGWKhgw7qFxry/FcskDPE53qk1orq9ltLqrJkPi8eU5IeKPlGrAGQHRTg26Q5iOmHQbGSXYeJEEALD7t1E72Tq9CsGh5oQAFOKw7S7XBu9V8OwhMlm5c9zChQeIvFoknsYkr7B2dYKpFyLpwKRvVDTwJntcQeFplLMXgFVGgsjVq+ihEk419lE5bSTzt12ZBn161i4oxa55bxv747LarjnIJQMcrnt1Bh2ATrfENQfJ1VgqGUO9kuFzYeyn8tjf5Fjj6ECdAnE+czTvRmFgGHluN3r9MLtx6s12vg8njePnZKBSvq26Ckepw==
X-YMail-OSG: PmIMdWoVM1lXZ4El1XXfyk3G42zuMyE0ViGlq2R9pQUJOt744bNpRcP2.GNI32P
 64nUNEM9rZSY9BOpC0PBd0tT2aqwamNssRy9XUwfTEt5aEWVvnF6PLwfiZdUdSqJ4uLtpFbhQ0ZP
 ms0qzi8sZi.mb2Zsy2Oi6DMO8PuqvNWWlwzE.gaROvz83ICcR7oUGeiZme8WSobTnJr1zmG1u4yv
 9L__yvI1PNopoDUUqROojmQVg64cYkMi4htJIG72Tw3.WD0iQdqQQNOwhnbFg4Avj5Nt55B2RWVY
 ifcqjoJgAH1yVCBeijZmf77OwSLRERqGw5dV4OJ.kr5pBWjwvMuCj3inNG8AV4Quv9WLrk_pd0gQ
 XmN6jbOpfaYVnKHZSW5rsE5Bxiylqj7mLUjMMLKi6JVlkd8eWbyMeUcnLYrtJwNhJjyOGlRNE74Y
 fFXSpEhMXAj9BocNMkG8MqvuU_J.nXokO4pj07UEZxEZ2_p7TzyqXO8_.jLCh42J5Y8q6SKPD9k.
 Tb0HNYRmDcovOyjWaFekvc_9PYbzt2yFD0iG.HXn0Q41yzHa_y3QuV5ZPQcy3CRVwAGqmnCSlBAu
 wwk4kJTkBV3NJZYUJ_CfQQajejrsGngbaVk549kUtbonDErU0aolA8DltjdiTQCO4SFLBLdep77I
 tj91ua.O.01Vly604QmwRHBwUtmMyoiG9ocVPVvUcHpPb0PCt6mZbrjLlWbcxdoT_rpqZtW08jbb
 nOtfx92ZMe5Fd6vaTVt.hLiK6Lhs4aH0gY2JyVtCGnbGarHPbONW1KNSJx2et65_INvK4jOiBFLD
 XUvnvcnJQjL_uU9M40Bja3ozAK9fsJKPwD7paxCh3rWBgtbUOdeK9a1M54qaMfARJ_cn5BKZ3QXG
 4Wp5Y31uMKh5PzJLKGqwWph63vZbdJH6gyUQymerjvFAMFuqS7n7er.eeidckb06mN..CUdvLq.N
 MPBSYtJdkZRpDDE4G2OVLYIT6ojj39C2HIewaZQ0s_s5K0UxOBNYhaHS0Hu3cBP5ohaaejI_TSYM
 hBluSux1vwSvFGDd0brGunOyCrMVCXG6ctKwoQVoiPChyDFkXJmtWZ49Pn3R2JbU5pdhbLik2Te5
 FHdGOq0N3Ub1kTGDuzghzLhnVNr3dRL3A_mv4U_xfry6IGz79mqNT7kUEJHKL1WtsVhy8fbfQnvO
 R.ducvZA_sUgDGGzKGzFMIPP.G98CVpIzv474XTx.G55GUaJTbrIQoypUnrhqqHJa.5sWCHDP3Jr
 yF4KE4vvYMqZV0ygoqAnFE0n2q1lLkOSdPs0ymRSC8MRQ1U8WRJWA2.PO1jMuqoMjhoi3JzwysLd
 uKNKL9Re0HjPAtB9lyBVL5pzzA6eI7HF.5seJLZDU8aLGoBnpRbMBCYKnfKmIhH2IN1iU0vrS0UM
 E2wHYVjwKtVTRSAXYx3Pnpt.2mExVMg2YZmg2MThbFVUWpaR7Z_zOettjPEaIlLMY6ubdaQloRj3
 8IhYzI5yZq.LlaP3a5vyIzwnoWv.ZU3kzHBhHRhKIJUi6wR9s16nVbpYIIwi6KqgVi61uZdnIggR
 s4W1U6Nhf_eYW6nXGn2GwxWJrq6htoGoG45nv7cZSP_Z79eggaPuibmtIUoHgWEkSImoqTyk12AK
 5IgBMNyjl8P80aJFtqlJ9UtPDSstmRaivt6dmqytb91j3eVzdTlrgebry0oBulMUh00B.PyjV84J
 FGNlLJB_Gkw3xlCdIu4zWoQl_4k3IMxZ1_c89Hnpa7vJ05tx.aAxxppOaiVcL3isMqyLCqJOpSFm
 m.gz1MKBww3gm63gthrYUH68CKD_dptj8CDCWrIiJr8.lTuVmFg.CYdlEqPnpomifa6UXuzV17J_
 fUcvmljAQ47RuoVGiq63kosB22cUnPDuk86grOCIGOwWqr1xPmlZfps.5Hw5akVq6kJLI8BjTw9e
 2RG4S67EHlE83TAgKL2va0LplK7lJw_88bKqazMlq_71rD7T0zFNxtUWRw3WxH_yXEkV9iwimddp
 ymSIxyy0Xwr2a4oRuNCZEmBZ73qllBXyBfBR91s.zkpFCV_4gdX3KP_hf01t6z_5_ig9SRfCb692
 _PbNBsQaasJV.6WibdYfouQ23He3wADzRuWO30Z_O.BfvRo8PVZNGEzUMAi6Ma5Vc8mUqW6U.NrQ
 Ozgss3HPrrJS9M8bh5pQOWP0xWeYdtP0eTk7KIc22tOGwjKYrE4owQ7zrO28FSojlhorMP3px.Qo
 zTT0905oZQfGjg7sDk8aKjJb.N6NMliLvjpQW6xY0fynv1tlny8YBaqUrKzMrAkTwjTm1yTb4WA-
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8e63990f-d533-487d-b7d8-781657d7c531
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Nov 2023 17:33:14 +0000
Received: by hermes--production-ne1-56df75844-cxbg7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f641fa0ff48ff61f6110a4d1d3fc6d2b;
          Tue, 07 Nov 2023 17:33:12 +0000 (UTC)
Message-ID: <85c5dda2-5a2f-4c73-82ae-8a333b69b4a7@schaufler-ca.com>
Date: Tue, 7 Nov 2023 09:33:10 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/23] security: Introduce inode_post_removexattr hook
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
 <20231107134012.682009-12-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231107134012.682009-12-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/2023 5:40 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_removexattr hook.
>
> At inode_removexattr hook, EVM verifies the file's existing HMAC value. At
> inode_post_removexattr, EVM re-calculates the file's HMAC with the passed
> xattr removed and other file metadata.
>
> Other LSMs could similarly take some action after successful xattr removal.
>
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/xattr.c                    |  9 +++++----
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  5 +++++
>  security/security.c           | 14 ++++++++++++++
>  4 files changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 09d927603433..84a4aa566c02 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -552,11 +552,12 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
>  		goto out;
>  
>  	error = __vfs_removexattr(idmap, dentry, name);
> +	if (error)
> +		goto out;

Shouldn't this be simply "return error" rather than a goto to nothing
but "return error"?

>  
> -	if (!error) {
> -		fsnotify_xattr(dentry);
> -		evm_inode_post_removexattr(dentry, name);
> -	}
> +	fsnotify_xattr(dentry);
> +	security_inode_post_removexattr(dentry, name);
> +	evm_inode_post_removexattr(dentry, name);
>  
>  out:
>  	return error;
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 67410e085205..88452e45025c 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -149,6 +149,8 @@ LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
>  LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
>  LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *name)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
> +	 const char *name)
>  LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
>  LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 664df46b22a9..922ea7709bae 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -380,6 +380,7 @@ int security_inode_getxattr(struct dentry *dentry, const char *name);
>  int security_inode_listxattr(struct dentry *dentry);
>  int security_inode_removexattr(struct mnt_idmap *idmap,
>  			       struct dentry *dentry, const char *name);
> +void security_inode_post_removexattr(struct dentry *dentry, const char *name);
>  int security_inode_need_killpriv(struct dentry *dentry);
>  int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
>  int security_inode_getsecurity(struct mnt_idmap *idmap,
> @@ -940,6 +941,10 @@ static inline int security_inode_removexattr(struct mnt_idmap *idmap,
>  	return cap_inode_removexattr(idmap, dentry, name);
>  }
>  
> +static inline void security_inode_post_removexattr(struct dentry *dentry,
> +						   const char *name)
> +{ }
> +
>  static inline int security_inode_need_killpriv(struct dentry *dentry)
>  {
>  	return cap_inode_need_killpriv(dentry);
> diff --git a/security/security.c b/security/security.c
> index ce3bc7642e18..8aa6e9f316dd 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2452,6 +2452,20 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
>  	return evm_inode_removexattr(idmap, dentry, name);
>  }
>  
> +/**
> + * security_inode_post_removexattr() - Update the inode after a removexattr op
> + * @dentry: file
> + * @name: xattr name
> + *
> + * Update the inode after a successful removexattr operation.
> + */
> +void security_inode_post_removexattr(struct dentry *dentry, const char *name)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;
> +	call_void_hook(inode_post_removexattr, dentry, name);
> +}
> +
>  /**
>   * security_inode_need_killpriv() - Check if security_inode_killpriv() required
>   * @dentry: associated dentry

