Return-Path: <linux-fsdevel+bounces-2287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA357E4740
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80CBBB20E2D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 17:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0223E34CC2;
	Tue,  7 Nov 2023 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LCkKieX6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36B4347D2
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 17:41:11 +0000 (UTC)
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282FF126
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 09:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699378870; bh=6tixJpzyY3SuAnaWX8VQ8oeD+TsidBDIh9s9rPPjxtA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=LCkKieX6kr8Sejkgx481/hwhExv5qCj8aoGCNIdImyawYaLakH4/j5qDLnPzpGYdqKAjfqSPHVb+yu2EVsvyBRbxa+ZF/zi9pZYL52vXZfnYQRqpo7W7GUmYW+sCSpTK1S0cRticC+YUQ5G3V7/N4EpAdTE2X7K/Fo3wnnBfeHa2vOcO5Km/z7EbDwokGtRrQ2bafA05Urq4bigi9ZC5NHI8uitTItSo4j0X2RLEaLyUbH//rfAcd1elZxGQprApYiInkGc3ha7eGlJ/51WND3b7MNMlO6jBDg1eEV5Vh6Saqc6XUDTVs7YzBubRBpiXNaDZHEw9jne8kcF0rgqaAA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699378870; bh=M+6ZowwGyGCY88XxlAz3oJTVYBgI+Il6fDU3WcVXGYw=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=lIONEy2tKec5+K0NKisa6rrCm9R8+4QgzYDRPWfJI7L168CpUCmL0sDM7vykUSIDOVsGu1XLVVi5OPJ+PL2Pabu4uYSCafJr5fSUxdengoOw52hXcDarS4AeAS9An/wBjbNTpEYUAZGgCeuFlTEnPdDASqzO0IfHzzSRDOO8x4rCpp/QzhH3yY3J+AWt2kpM4qStEFn+L74M8BENczlnJUjeaP8DV6i5uHE6BC3j4aA4fIRffD9jMEpfXoYUIvE/26LawGJsV5bUfLoYxmDCX2a0hC2C3BcfY3F/U++m4N4G4megPZXDxT0zLKJptKybjYcKf7LxwVbNrLrMr/YKWw==
X-YMail-OSG: ZQ6BRVoVM1nlzWeGMZUtu23akB8hQqkeDL_2jWKBzs2DUU1X9fZLb69C_eTe1Ki
 147cX24YhcyARbg_Dija207c8GPJmE5hzoll0SrCtIWWhTFtD36QNOXM15w9j9Br.MKFI0P50ayW
 VIrBfAaIKWOwsv.uyMTFZbA1NOpHNI86zszWYfYFQJ5hn7GF8iISUgTLxHQidCvrswGU1DgRI5_9
 mMl3PsmpZS3LpuuuSsq7PBxvg0ZnKbrDYHTRiH6z_XEP.7.WQ6kqnZiXe2PBY3.tjDz9yF2v4Bz.
 555gRgJq_DnJJBTh.E7mnOvoHSLp6Y5VQ0srLvUxLOhQgr9vOmfjWikcrSROVbydZNcROTCvLTtf
 0k2QdCciJzLawkmFxkwJ5UVrJkf.tMKq4IIDPOQS2U_TYS9yjryO9mgVeZbXvh9BtQl7.wSQfnoV
 Bv8x_RqDK9xq3ja6HOIymvm0vVgd3p96Oh3NGUxN3i8tcDgDqrefgrfxBjOE0os9kX9cjUB8s7eq
 _ewhdbzY7h0gNruO0KJ3tBbP9z8mCV6YZcylVSgURjGhqeib4TBt76LnHeNcU9YHod9cpTeJDimE
 K.9nGovSOAeWkJP4o__GfAhpESxyrwUHkWLTn0WtW4T1tZwOw9lC8hcs.s23wVEpmlOM8fm4A.h5
 RW.yj2ijHYxpdThfPd9e3nLf_Lx86hGmdHnBQFbmUfg.Xa9iO9vUAwY1iPaewlIl4VN0cm4hsZL3
 DhLBxhPKGV0TUw0cd9BihruL1WlCtzJm1pFmLrbKiekHepjGWrOzbU03U_wAftUU9E9XsuiDtV4B
 Zz1rs08H8W_L.za9x4NeYmMSw5Nx1ukqzHL1UsgCch_LPmVkB9HaPvweWxjm.BLYj7Gz9ptz232H
 yqo.R.Pl.NPtJR5IKKSHw9u4Ww3l5RzeUoYhtPkHxCtyW2uJkubNi0h4qsa6ddKULxWArJAy3S1b
 fG9h3sRylp.u2Cy4JJfskvz1uRNkPdHc_APVClPMxzkviUlWsI02DsSZeLSoy4QfDBXeOIn3DqbC
 CEfhI2wxyIv4fNCfuicURZaUsp4hylmCj.4h08MwuAVXpYknrOLtipX2V9JWexWsi2KyAl4kKYSO
 F5NaTK9mpPEIHASrCOYJ1CT20mBcr8CCoEE952qafbCk2hpWYUONf8gmEIEpBkrezw4LAiCYnKOY
 O0XT9XIo8e8DavhgwS0LDy1k2nMV707MRNDyOpYZEEWGaziAP4EBYoy6Ifv37xu4BPz2PwwygJwH
 CNPPaC3az03_M46FjFivqnNS_CNobn32SsFnnHBarHFPgAS_qd0NUMoH.e9n9pQvyHizMZeFAxBh
 QlmUUE1vihLtIUEONUdb33P8EYb1nZQgNu10An.hYPN9LVIM9Cmf_aLwyI.2ANLBCd6OVg.kWcgV
 aegp6w6MrJ3etgXLD7BgY_3_3OqROx9h7287z35R926WyYyiiofHEixKiGnMAPqvz55cHFOtLLw3
 0xjRnK7tT_gACDAGvW_8EPqUn_VPjZdyC7AOSfQoEy_YSK7Ixo6kV1mxhCs7DzWpop3DmZQ8kFns
 xXvu6lqZcpZ8tJt0gP3HPjD9bKw1OHQJdNA0udYEOEfGqcuDKaytWc8YgW5I6c3EaPXXqKHJqxd0
 g9vFKg0N_shQXYVTBf0TnUdW6QNs9cfCZagPjoiVXG4uzdqD9b097ybrs4ay2DOlYD5LANixYHK5
 lj3_9PZmkYGbjAGLnBioqrKu6Z13eJLJVIoIXH2xFTo6oCD2tegrJ7qSxjkdS.VJ8ADUDWA01ZD_
 wV6BL1L3TgfT1Vy3jjBWL5sEgaXe5OWtH7Z1VPZi3cPx4TB43EaguV0oB0U.6WSpMxeU8X7iWUQu
 TOdahW.ncEJVjm8qPm7qVsGD_gfPeLXt4QtuYxHSrz2WaZ9.0.zGfAN9NfOoHfmWE1NMvmpl3wCu
 MyhJwdSblgzJ6kO7w1hTXkW4QmddJmXXGb2MRwYGE3.S2F0Fn4M5SFOiy3SmdLThPEN4NUxz282H
 kSlpT0QkRGyxeqNZhuzSO84NIkcAntZqEmc4lschJmPsRxTsu5Q4.1sMvcBSZlaTafVSPPNyzNXO
 UvY3FCaAi_amK4dsh6yRwmfBqUTZGbcNKbIdfnqY90F_L9I_dLmqhtkin1RPwP6yr1LZWofzCeN5
 C9brjJfN5tfVgb6nHheWxG5yUX48J_Hneikom5j7YerN8tzA1zr7YqNXpNYkBppJsFVzcufm8EEQ
 vFQlX7XxcaJY1QuGO6xOIEN5Ih87gWjBOuRLI3MYD8WL8pAi1nyfiTbEn3iwHKeHII50xK2ULJcS
 PtnE-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 36100724-68d1-43d8-aaef-ee4a0d50b017
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Nov 2023 17:41:10 +0000
Received: by hermes--production-ne1-56df75844-z786t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3f90fae0e94dc78d2d0da6a674e73798;
          Tue, 07 Nov 2023 17:41:06 +0000 (UTC)
Message-ID: <123f22bd-6ae4-4677-9f5c-477337009491@schaufler-ca.com>
Date: Tue, 7 Nov 2023 09:41:06 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/23] security: Introduce path_post_mknod hook
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
 <20231107134012.682009-15-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231107134012.682009-15-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/2023 5:40 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the path_post_mknod hook.
>
> IMA-appraisal requires all existing files in policy to have a file
> hash/signature stored in security.ima. An exception is made for empty files
> created by mknod, by tagging them as new files.
>
> LSMs could also take some action after files are created.
>
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  fs/namei.c                    |  5 +++++
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  5 +++++
>  security/security.c           | 14 ++++++++++++++
>  4 files changed, 26 insertions(+)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index fb93d3e13df6..b7f433720b1e 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4047,6 +4047,11 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>  					  dentry, mode, 0);
>  			break;
>  	}
> +
> +	if (error)
> +		goto out2;
> +
> +	security_path_post_mknod(idmap, dentry);
>  out2:
>  	done_path_create(&path, dentry);
>  	if (retry_estale(error, lookup_flags)) {
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 5d0a09ead7ac..e491951399f7 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -94,6 +94,8 @@ LSM_HOOK(int, 0, path_mkdir, const struct path *dir, struct dentry *dentry,
>  LSM_HOOK(int, 0, path_rmdir, const struct path *dir, struct dentry *dentry)
>  LSM_HOOK(int, 0, path_mknod, const struct path *dir, struct dentry *dentry,
>  	 umode_t mode, unsigned int dev)
> +LSM_HOOK(void, LSM_RET_VOID, path_post_mknod, struct mnt_idmap *idmap,
> +	 struct dentry *dentry)
>  LSM_HOOK(int, 0, path_truncate, const struct path *path)
>  LSM_HOOK(int, 0, path_symlink, const struct path *dir, struct dentry *dentry,
>  	 const char *old_name)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index a570213693d9..68cbdc84506e 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1884,6 +1884,7 @@ int security_path_mkdir(const struct path *dir, struct dentry *dentry, umode_t m
>  int security_path_rmdir(const struct path *dir, struct dentry *dentry);
>  int security_path_mknod(const struct path *dir, struct dentry *dentry, umode_t mode,
>  			unsigned int dev);
> +void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry);
>  int security_path_truncate(const struct path *path);
>  int security_path_symlink(const struct path *dir, struct dentry *dentry,
>  			  const char *old_name);
> @@ -1918,6 +1919,10 @@ static inline int security_path_mknod(const struct path *dir, struct dentry *den
>  	return 0;
>  }
>  
> +static inline void security_path_post_mknod(struct mnt_idmap *idmap,
> +					    struct dentry *dentry)
> +{ }
> +
>  static inline int security_path_truncate(const struct path *path)
>  {
>  	return 0;
> diff --git a/security/security.c b/security/security.c
> index 331a3e5efb62..5eaf5f2aa5ea 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1800,6 +1800,20 @@ int security_path_mknod(const struct path *dir, struct dentry *dentry,
>  }
>  EXPORT_SYMBOL(security_path_mknod);
>  
> +/**
> + * security_path_post_mknod() - Update inode security field after file creation
> + * @idmap: idmap of the mount
> + * @dentry: new file
> + *
> + * Update inode security field after a file has been created.
> + */
> +void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;
> +	call_void_hook(path_post_mknod, idmap, dentry);
> +}
> +
>  /**
>   * security_path_mkdir() - Check if creating a new directory is allowed
>   * @dir: parent directory

