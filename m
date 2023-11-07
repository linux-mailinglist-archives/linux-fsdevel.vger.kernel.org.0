Return-Path: <linux-fsdevel+bounces-2277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2230D7E46C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F5D1C20A4E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDBB347B8;
	Tue,  7 Nov 2023 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bW8wiejz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96137347A2
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 17:23:24 +0000 (UTC)
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D443116
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 09:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699377803; bh=7nFaiIIvCZwjUaCZj9MQcQ/3EbMaTe2FoeMnVbrkG8I=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=bW8wiejzU3rx2wW/sDmlgoraHnI5O4aoOHMq+hhYHJrKY5RxdRyP5z6XZqQTGjpgaJaxEyUO3hVlSfbnCnj1T8DDDow8mw8Hpjyb9Y1ojCf+BhwbXFS8HPrEEf+Y6LTzFDkIjrOEqCxI/9+wf/HkwKOoAQiGP5EDlaIUguIsg6Nr/uZBCU+I3vVEJxVwf4HcYq9dg1D5cioXDMvfnlGUiHrWjoibG+L3DDRiruF9hcM7oFn+0NFytesq79CTwibZRkYxKiTdqITvibJIRqKOIzlI7w7qDDDqucjDpRYSTX+Z+4EONlqBFblguClP0XszrxgYSTFd6AG967pIZOW0Ug==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699377803; bh=ZjE1iLA7gIV1pQwwOb3xHlBSnKFL6Qu7B5W3jPBvR+Q=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=DpkRH25tcuhPI+wx+I3D5q1Xk3sIWDhWCitqV8jGv8rd72LDK2FmZde7MHeQQ1nbfCNxhqny6LRdF6x6H3Biz9zJdK8kKtRZtBPHVvc/vs66PHHzKxGrHrCUDOU4q6vWHR4HDNSV6BvFb3j9kSdqVyPiNlvui5ifGk5lLcHdADnLO1Sc2tOqHI2E2BvV8H9fTC0zdZ/Hrx9joIWo/IHRJTckgDiYB4ito+KCtav+RMLrr3zbzohVFzSPcf5Cl5etIJmOMFFiMyF+Ui0XG+ULFr5hVLP0hb91/ZmMomOvm0loS6EIxIpbzfPRZjWxc/AM3000MJRsPUf0elcCgn7VEg==
X-YMail-OSG: wktKID4VM1k7CiY.ZvlOmZ9Q1RKrLNlU9eLBcUulfhjP2joXtWs4OKXLSi3rRV4
 2C7Jd8eQn4tlrhZ2LilJNxnOL6HDKvH_J.zmBCbYpRSp_kmFPKo7emHCIIYVPmqXFjJWEVkMC9HV
 s4GcWBtKvmkNzBVORQN4obtfP.uyb_llCfY4h607vHkkul0TwIPQnrXDq5ZiZf6613bjNmbgz7pr
 NdG6336EYs8Xbj_VJlM2WGx_P6KwbHXGfPAbqU7YLPU95JQ1nNp87nLvrwEMCKX3TgPDKwJcgOhE
 ATtXhhSwis1rgrDzk2rBucMe_8E8zNB1O2H7jzuPWm7OJdjsgIGtNliw_NX.ovalBMPDgBZFNziZ
 XFS_f4ppNERvBNSN_u4xHmxFPBp1x2fDGmrnmImLz8aLxU_6ngvybt1eEltdvTavwZPflWmvbHh4
 3j1ehT7KARumDJOmla53tNwBix0sIOyeonw8OdMKtQ5fRx8oYAAtYmpmb3IVjiFMygzZKgfUJU5p
 QJRxned3Dh3339sV_G_N5ELs71JhmU6t_4Pz1Yk_dts8HE7BxLtU1PwBC.xAQwKxub2tX3rmD7kU
 87OPiy_fZoOr3EZQJbI9ngkti_2w28uZzEPEjhZyu8AxNVDjEW2OfmGnG1Nz4VifOzXILkOtmqrb
 uUmvbg43KSs1owSSwrtVWx9VhQSb0QISdtPV6oNrhJ4eoHBBweBwC0IsYz1hxT7lf5DP9jlyptob
 _TRyQZo29HTZRUIEp8DK7PcULpJ2nhISdE8aNt0YgQ5EOnkZ19259rnlg7CA6QGWmDYaSBU7kyC7
 vj4XY_utDVXR3c.WEMALICs0FKWdO8hqxLAIswMtJOO1IvxRYi9H0cdEXMqdvhLVJ9ANC.lrS6Tp
 TkActhqJ8UdXFDRga7iZ7B4emYi5pbxA7XiAF64wXo.KudaYoyU4STQJibfejhFyL.831Gf2wR87
 NvohlBdrHngBLF3uC6EcjIf5RE4PYreC51Zg.n9wA9RXdkGE8HPW4fjNfQul1HxSoo1OYq1ER4gn
 8RP3AXWO0rGDex4AYiPkW_XOpk1YAND38.g8vniqKu.Lo5cHtcYR5gEl9zPYpe8ZGhLGxgvCoaFX
 JDbKytF._PWOJJgwfZwmMoNhPFUxXF9om4I4l8jLPgaa_JVaz0GoZnljkweNDcLx2VRu8D6lxqEF
 l7ycssXcTrIiFPM0H.ufb0MkZWIzE_3vWGG6HJQD9Is32iLpfVioXn4f0At_QmtR.ATfpGWAOBX7
 8VMWTaNY0F0Ovho6yot2dzroQ787.BQPL7bxGr_tTqiC57rTOgaCsgH4zaDPC1PxHWdFDs3YK5jt
 2uAlqEjqyxe.sDOArpbBXBwGlGxwrZKVyrgMTbLhVqCqHn1DKhMwV_IjlmOkx_TPzFXgOXq3cqnF
 Aa.2rRCAeS_J_tgE9hjO9N4vxRvhXUsauGRy_RbYhJqXqpjtVE7m9549lf1B94sF1VGizORyDOZP
 7zl0wP9gOgHAnmMbzvGVHUGpTkcru4DSJheCzurcq8Wi2Wnw7Hd_1KSrozDOJkgDyQhLq5vUG4Yu
 J65PseZ1R2ympXHg6.hfVpLYF2Z1SUXX90A2wtgywXlhaySrK0iwFXVnId2rLNqCza.YvJQsbvWO
 oo634jxleyr5_IAF.qhdcHheAxn_4ZcJNvG0bbh7wot2B5DFOfUI0fT2.h5h2mRlqya_Or9z1I8k
 yI3_0P.SY9V.WnWdmlrgRqVuv0.47i.7sEDas2.1FU.Yru7a634iWtSRbJ1__B2yWEM3kd_Aax.W
 0YhPnG2UFTBG00zKiEb5DaoGSsj9s5zud6Z5vMH2kj2fRBkt_pcQRIAtGksP8VvD8SrdbldkPuHX
 XmBmV9xhzT8upmQvPYnAF8xMY9BYwEDQUecptjrfahX2iHcWUejPFjS_QWTLrB6LkuVfg7rON61N
 elpls8uGQ4U7JmxlpX_BaITPR7jQBSUeex2QWksEELjqm_4oJnAKQJnaq.bo5gbKpCMF2B5PrE.E
 K70yUXttcPqKHN1nF4noT6BKcm939Cp8uJvk2sddPdFrPLKytxIApQlGCBifKCOEBnUSidBJtlHz
 AVhXkDLnQfQLgK9NsAuhH7871u_rg6kLLRNm.qVZqvwfr.DUzqXmIrnwe0DNr.EqAqW1N_BKGQsC
 Vmw2opZVwiWRBYfH1GWAxXGrY27eN4v2Ci9iJBtaK3DyhFTmmKx5Cf5760vdGzcvR1bB3w4Cbxz4
 KfGHsNrqsAAdCLtjdKjb2gN_gif0XH0G9xoiZrS26nwn15Amms0S56PnfJ9DvwA9Ch2mP
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0d2e3d61-9f18-495e-b333-d4fbd9f4b9ad
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Nov 2023 17:23:23 +0000
Received: by hermes--production-ne1-56df75844-pr5zc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d6861bf05a6dc0512095da46cc300843;
          Tue, 07 Nov 2023 17:23:18 +0000 (UTC)
Message-ID: <95ca614e-d50b-4621-9ff3-693264b463e7@schaufler-ca.com>
Date: Tue, 7 Nov 2023 09:23:16 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/23] ima: Align ima_inode_setxattr() definition with
 LSM infrastructure
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
 <20231107134012.682009-4-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231107134012.682009-4-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/2023 5:39 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Change ima_inode_setxattr() definition, so that it can be registered as
> implementation of the inode_setxattr hook.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  include/linux/ima.h                   | 11 +++++++----
>  security/integrity/ima/ima_appraise.c |  5 +++--
>  security/security.c                   |  2 +-
>  3 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index b66353f679e8..077324309c11 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -188,8 +188,9 @@ static inline void ima_post_key_create_or_update(struct key *keyring,
>  extern bool is_ima_appraise_enabled(void);
>  extern void ima_inode_post_setattr(struct mnt_idmap *idmap,
>  				   struct dentry *dentry, int ia_valid);
> -extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
> -		       const void *xattr_value, size_t xattr_value_len);
> +extern int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +			      const char *xattr_name, const void *xattr_value,
> +			      size_t xattr_value_len, int flags);
>  extern int ima_inode_set_acl(struct mnt_idmap *idmap,
>  			     struct dentry *dentry, const char *acl_name,
>  			     struct posix_acl *kacl);
> @@ -212,10 +213,12 @@ static inline void ima_inode_post_setattr(struct mnt_idmap *idmap,
>  	return;
>  }
>  
> -static inline int ima_inode_setxattr(struct dentry *dentry,
> +static inline int ima_inode_setxattr(struct mnt_idmap *idmap,
> +				     struct dentry *dentry,
>  				     const char *xattr_name,
>  				     const void *xattr_value,
> -				     size_t xattr_value_len)
> +				     size_t xattr_value_len,
> +				     int flags)
>  {
>  	return 0;
>  }
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 36c2938a5c69..cb2d0d11aa77 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -750,8 +750,9 @@ static int validate_hash_algo(struct dentry *dentry,
>  	return -EACCES;
>  }
>  
> -int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
> -		       const void *xattr_value, size_t xattr_value_len)
> +int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +		       const char *xattr_name, const void *xattr_value,
> +		       size_t xattr_value_len, int flags)
>  {
>  	const struct evm_ima_xattr_data *xvalue = xattr_value;
>  	int digsig = 0;
> diff --git a/security/security.c b/security/security.c
> index c87ba1bbd7dc..ec5c8065ea36 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2269,7 +2269,7 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
>  		ret = cap_inode_setxattr(dentry, name, value, size, flags);
>  	if (ret)
>  		return ret;
> -	ret = ima_inode_setxattr(dentry, name, value, size);
> +	ret = ima_inode_setxattr(idmap, dentry, name, value, size, flags);
>  	if (ret)
>  		return ret;
>  	return evm_inode_setxattr(idmap, dentry, name, value, size);

