Return-Path: <linux-fsdevel+bounces-6227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B83A815192
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 22:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710E11C2364D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5207249F73;
	Fri, 15 Dec 2023 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ht8Sm7ng"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586B149F67
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702674338; bh=h6AWNHWJC/UC96v1b1QJxTRjmX7Dyfl7dMUYyHD71gM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Ht8Sm7ngRGuDTpCUHdn6g5M8qokPmwa1SBwMuaysjZYsBDadGj4Sud+ie280xJAxXinfLOn2X1ib8qbJBkBq15DylOYVeEoZcJh3HJlRfS/jHwYBPNqnD/Rn8D8EFQKj6tOfbTYgeUQfFSqNH9d6Cuv3ovR5GqhBsUeqB8r134exTRZTi7DTO73ezdnrpVODNanVNixQw91rgbnTYSCoMyY2AjlEA/yyKhGwb3a78cgRK8QpEcAFX0B62ZLG2TfF4Pd8dLjIan96ezogv57rEu3FpUi9MiKTcfrl3v5sbmeJKYrxQ4hDgJQ1QRJBwKRVE/0G+Q8GqoC0/+l8SJvDVg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702674338; bh=EUlOt7OQHRMUT+KZVBTz5PbUFR9CBQ+04YtOrI3iqOa=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=WjSpuUWijAhF0fDDuyvnVDWxvf2uTSrUKyfQhiw0r7x8AwDcQqoIHxGNi87OePA4hC7pu0Drj7fS3CxzlxlgBvy3jWI/l60PUt9qOH7kbAW0xdXKq0T/sz5XJCQKtV9h9lPWKHiqStUyZf5YQd2065+QBvSb8pRYTdoI7r5SZ077kO9a37sWsmN1QheuVMqGKflhLtUuIWFw5x8l9LdtBvZz0xlYpoyr/rCJWrlQ8021R/9XhVA893bvJZeIG0RnvEZXf5dfGbbN/oe3S22NG7s2lVs9vadkeNqbe+PyrLqhjJRSC4cKDvSpkQdVFN1VoujOwqe8YiDunj9cEFSRgg==
X-YMail-OSG: 4YnanhgVM1mIt78sweK4QLBPomWSnrgMyiiyMf8yn97zT5Lb_1X6Z_T9DbzQj83
 Ihcq91pwrI3Yrp7AJjzT_NS3rsPT0w_whOuzouvb0QkeFIL9chowJ9puN8vyr7KcppdyWF5ASgp3
 akkxc0d7AVB7nccM.LJkySDy3_tjoLhnw5mPYR55Hoor5rZgTBEZrzT7T7BezoZy7rR864o82zK3
 mtIVo0qZJ2fNmZ9rXK0RS49rT0BkHdbRGzirarSTh_YXsC8uYjPioL5AnK4qfJ8LsMPO5boHAo3o
 364QxyZiO6wnCwVn7kaL8IumWq58.9Z9n.SvbAkEAbo5LMB83p2EMwhZyLx9a8ri63gZHoXPnhTs
 pFYUvUQBweBW8ZV_sOMH_EEysyLV9KhqcCyR_6OoUjSmj6C1irdlUDn7qzg1HNQ74RhjBmBIP6HJ
 yWDRB0uU5rxBGkllNh3wbO9YqZfkI.PfyftBB.NmePSRA0X.U6ayoF3r1ddMhXOkJVK6NfEkVjX0
 l2r1c7XxLA3nes8bQluLafy_cZ7Njxug9CBNguubL9ylPHiebxs7KRUmmOloAPCwT5yGARufFpQR
 jrEZogQUJicAvRA1OdxkEHu_yNjPOs7GL_zuofC6h7Dt50PWRDonu8jK9oVRnWvFaWwTKQSroyNn
 _nXTQHPkRJ_DIoNOfGjkO3PnhwBYvQC.fTH2lJ0nYJd53bf3R1SthoPjjcHDw8NJDxa9mTUYuhYx
 ETXjNlmvV.zM049MOfFK8.hq21SMGfyWmYHTZaJ9bVZGex91NGvg7fQxjLg6dnZhOOChopVCnx6w
 KRhdvZcxZzrcaDh.zsxNt5rDhRN.7.HnUmkcp44mxKMW5KDrYIzGUL5AtWaCovxXYrVA0xR9.Hh3
 W_0plDNW43xXqtB927A9Rdqwl54UjaIPyX8yz5lQMImijEB1fxUw_gMOC_9WRWZ8phRU_.CNiPr2
 lsHeG28WUl6Kb2S9i0JFo3XP1elEIi1uJiQLMCOZZK35UizAFcm.W3qupGT324XOXU82MLs3eANb
 S_QEMw6I_eNX.GTgtfURkAlJFeMokjIyV6J7GTMoXch3H5Y.XpC6KHZCbDoFlwbuju5L2y5Nqgjz
 S3pMB3Q.yZ.r.PMISXONAFlPV7KrFdPvGkyLB0qDT_gBFojBGu3hO1GY1lrBBGn5P8QHXkI2lMOZ
 LeAJ.31.mnNLlvi6PYwAQa7w.CMEfF5v3oDTd6hXzwTkdXzE.UeuDDrMgYzypdWCKRhmVCWrFTTa
 gl7YQpS7Fj9OntklKU6nluP2J7ASjcpEGhT7fHy6Z3DsCbDnKF7NmDSR0cBRw2Q6NLmNHwlv9QuT
 3I.8o1J4diCKR7kcF9hyjgcaMIg4cxf3IIgjJr5XK.6Fo40q3C70.4cVRLzop8rcwjyuZ4DmQULB
 x0_SPFWM3IpwyHNiNicBbrywpCO1cg2LnVtCCQd2UNaDolLI3ItidG7ojuQB8c9HMmL5fAeJqCIK
 5OatDwWrNmNMk69YqCBrrs6V3EZF9bmCbCYr7tsbAvYG24hOqUr8xIQVY5ChysWuNgBkEheHevIp
 Qdi0ova9924WWFlvyrwmYT0X9Q3HQjGVZHWlKNRMuCZA57BC2s92DzEmmERI1okI_JKrsKnf1oG4
 Xv0WpckXDCPrd6zLqCVAinEiHhBGqYKgMmTILf_yxaF_03KhW2bk2J7IzUxydDNBrYByEl5BqgSr
 SiebyFhl1nKrljqXq5nAuQ8ZqLdVH.o1zEd7WrMjMsPQsQWJQ2Ef02owsA87pzsIahu6N.RDmTFA
 kzxokEhEKZ7DhLzncHlV1PRyC7wZ9w9_eu2pnX9Ty9oRwBoREv3VNAzNwEp7z8zIQD3xKBHLdPrF
 eftjlG.lplp6byi_pw.Cw51c8AJlDXGEwNfxvt4V.MxWRpyyY21ugIT5utaOw4_gqUZ3DVJg1uvA
 ExqWurPbfjvmWvtnH2CHRSVbXyBOLpsMyzd5N4B4f_2N_wAGDsFyeVfjDy6I24y1eavfUvaPMjea
 pMETb8blI9q1iTOdHp_OxYa0JBgJfmkxUtxQFgR_wDZnQj3E8585I1Gh68uYyGAb4d1L7kvrQHLS
 csPcKI9EUcvsLUDnG5o05dRtPSsX4RZj61iNmZHzdSnvWT2KJ5KaiBc67z1JT.i97Xvm8tEum9tR
 B_qC24IdC0oxSOBv4WGDTtbKVzwlHkPL9vDjnJ87DqiHyqKZScKSw.LEFxcI4YutS_yGwEjtCEGX
 sHIZmMqMCAHD7kif9lIWqFg9Q7Cs51VKhNcyI
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4380ada8-d70d-4e4c-b8ec-d678c5b6a69a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 21:05:38 +0000
Received: by hermes--production-gq1-6949d6d8f9-pmzmd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID de6033d21389d7246e7fe82deec412af;
          Fri, 15 Dec 2023 21:05:34 +0000 (UTC)
Message-ID: <a4493b56-503f-46c3-aa5f-400691b07367@schaufler-ca.com>
Date: Fri, 15 Dec 2023 13:05:33 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/24] security: Introduce inode_post_removexattr hook
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, dhowells@redhat.com,
 jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org,
 shuah@kernel.org, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231214170834.3324559-1-roberto.sassu@huaweicloud.com>
 <20231214170834.3324559-12-roberto.sassu@huaweicloud.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231214170834.3324559-12-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21952 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/14/2023 9:08 AM, Roberto Sassu wrote:
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

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  fs/xattr.c                    |  9 +++++----
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  5 +++++
>  security/security.c           | 14 ++++++++++++++
>  4 files changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 09d927603433..f891c260a971 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -552,11 +552,12 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
>  		goto out;
>  
>  	error = __vfs_removexattr(idmap, dentry, name);
> +	if (error)
> +		return error;
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
> index 091cddb4e6de..c3199bb69103 100644
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

