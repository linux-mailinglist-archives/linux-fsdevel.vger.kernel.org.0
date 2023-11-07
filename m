Return-Path: <linux-fsdevel+bounces-2275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B8B7E46B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36ED3B20E13
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 17:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80419347AC;
	Tue,  7 Nov 2023 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="esTqaRxW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057C0328DD
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 17:21:16 +0000 (UTC)
Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888F7F7
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 09:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699377675; bh=CXHZIHWdNJZXYMl10DVOLUHbXZecyt6CAnXGFaZunZs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=esTqaRxWxDnW3Rl5m/M8J0UIboibBiWjJw9ZniKeogjgqOHpHQDi1NbrOV5T3hOB35Qy6EFLiBi0WFNJ63CnaelLBtaGETpqn+poKfTZZzsqLs4vasZ8hyIvRi2VBM0KuXN6JH5vv6TEX2bON90TxQnOWmM6vhyZVUNNSfnIM/Nkl5Ehiuj/PvgLfqmqvcIb9PcSZzjq1SN2WwwchS+Qg7ytId1o0esO5tI/XrJF7poq/5RSkXLzAS0cTbnZhE47suc8O8xv3eCPYSKdLkrxAGE8PXMzXdNl76vDWHzomTC18CXRxrz4l3R3ZqQTDzfbnNinCDy25U96ovqPCchP4w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699377675; bh=YetT6LjqfgNnM6/JTaxIqoj7XtEGdAvyP+MYQXhLTpv=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=TeQY0y7L6REcid8+qdZvetg0MMJB3ZF5/N7JO85jHUtLpdzRGfTCB9KeyL/iyuFLc8VeeHI/Fa3ycdo9TpALcnIbcSp1lIjMz4UqYN/Vx4xTMv9nWzfu8ik8mrmSo7IVZMrqChgH0X4kQC/4z+Nryq68OaYdo1SkV0irImBOuSDF+AKRtnzk8W2VtMGYz5DN7jcrjmNlzBA0pjs2BCd1pRgPuudtDw/EChCHx05ho/pQoUdaNBu0t++T0mTu+Acm/4mZtwnukss+ZbolWJY51Q6CXnxn1lBDFd+4YlrQMuv0ovOkfS/553uu/XJ3347xCR+WzH1fdbKWh38rUo0aiA==
X-YMail-OSG: PD8nixQVM1ngEQDjHe9kRBTVUL9k8gOFV5Y5SVY3UYLz8DScCfJMbrwrjkMyAng
 4cz3JgZOmMsXAY2XN_nFMHjz_wWYjUGgR_U9MoVmAHMb5mMdNMTyzF_1sMp7RLoIfTOHYQHgkYyg
 jicdKyhVKSvrgv_Xqhjh3y.ufGjgSexPyD7BPtLAfwYiNgZPBqt2m8KGsu_qPNz7Xgqemdj2_4lL
 JFfTVB5O55RnkWC3NcNrcUoxZ_xviAfYiiERvpQkQnmNGuAt2aPnkeFnpL5gqJe0xiy8ctH5f7T_
 5dzLggIqqgp556S1SazZpHKEg8bQ22VGq7Y3aqoQ.NQnRY38EHBx.cFR8afOb3HQAnM0dgLJGpiS
 2VHAry64i_Z4WP7amwPgO_8is7oOBpdxI_F83Go28t54q4FmhvPDffIcLdi2vHgZzwIEUsGFzOtX
 KEI7lR7Dc5kyn2PHpPB9LBLTBgNgduNk6Ugi3BsCRBxUd8.DtB0Lr807zOc1UWhJILduLWRQ2Rpi
 y2U_c8XCFQyX4SNHsaB_BhqQDD70whdxTqSlEeVRVPI7r3Ea24jh25r.AAUeYHF8MegVFLR_eAFb
 h_fVGgYX3N.WkF4edlZtkTmpepXftSOL6AA83BTzIeTpx4e3HBG_In4jqGgT2Wi8B5j8hq7Y20zD
 7bPOh9Nuqq407zcVa8wBHoGdvRT3Db9_RZIOkDYBxuZH4zCHCPuIteTTYHiRkhIuHdlXArK6Dueg
 Vm.K0qxiBLTmTKMJ0ahvgrXsMUT4znMl3z3i4Qow5jJnT1cq2QCIlBAqKz6CXMiRtzDdu3Afa.Xq
 erRbihM1CagXXni51Ns_H6._Ph5pEHQ2SwqwZVxthN0v6.LNxERHXl5eiPqroITnxviQfIbAbP54
 bdxdCDucxsHiRZI5dVJhB4z7NPTp1L00PjD815VVBA2OC_uCZgczEeRM2j.kGx33mQVbWfM3GIeJ
 EenALfKqZzG.y9id0_57ZuieVJVO1nr00GWlghRlZ0wm3BmlsoWDGucw0OEkQXuCMYaPvNeRRnuq
 xODE4ah6MtZaDWoTNHBQdPqjPTYH7SloRRqKxokMesRy4LTp738HnKjsGF5VasOy2iTgQmg1kVzh
 lg2F.mNaeknf_9EnGmgQFp3uqg9Y7fV8eZJubajColvAggHNhQKF34oUThFNjE42qETRp3GkgWTB
 UmziDhSI8SIL08e6BloE5RKE9.ITkD_wC43c8_UtZ_O3m9MkeqZDZsgMvzSKn.QEs0unzGPId9Zi
 0uQSvvccjX1Ent7FqanlRfauw32mTsfSpoUndflerrEGVMRwx5IO_L8XU5EOrP79OhOiNEAlRjT5
 RWoR2MN9dth2nUC32fX5MUHkGRRK6iTMgEoHlPUp7_lgY3iJjI4XsW9AC94yEhJQNSLALG170Xsq
 VVpvbEVvwCHkkWITeiBgm01NTx_kZ4HqsGWhDg63FV.rfebjlW7AxXrcKRGtYeepUTQrqMb.EjfL
 xUCB4kW5MmDYRz37_LH8Wm1qEoKkUZ0XUQczc_mzkNb2HTgbALrAk6ThKLHQRVOPUCXMUZp9rITK
 Uz3_d5E_a6KlUAUm6NSxknYqu1SdOZ4X4XllV6imv.fJCxFMSMS0Ogrpr85b7X2BMyNJG_cCkV3S
 PRSp9wpjIinn8xEIDA3aiMKAiFV6hKs80cOzTotXJuU7e4ZINvgokxuBWhOVi.SOrczkqMn4_bJK
 F3IoObOIcCKZd69uuCEQzk8tpxPmpLMI.pr8rE6lfWt2UL6RiXepM1Xk38OwFDsYoJdw2rKc2s6Q
 ce4_iJuONjG7h9PNRUSrhKEXjBWUIhHqemhKeOrHnl4rtmzCVGbTPHRPFlmUMYZF_PLl6RSRl4C5
 23nS.SjYlpMeiJ8hOar_kNnsY5NjqEBKO3J5Crqksce72sCG0Y3bKPQCMUJ1NUqSCuQqUBF28lMO
 _8PeLQlDRsLySU6qAUTSqRMOLWwz.dGGkCNfKZhLcmvvxcfXu6ShwP7sdESCzFdS2D1umarWjINb
 B6mImHBOcbdzNZ4peRYTA9ncGIIjPorfub_RmUpRtXYSGUCWG6BfSPUHO08jGsGjRJ7HmMrOF92p
 gBaI3dPZFkcBD6yWcFvq0iuWMu1Np5CvgCa8eU_633zWLZms0FkU3HTFpFMFu_QEuviKCVDSF6Lc
 XuzIlTERpcZuKb2GwtaTaAzfBvmxLg_M4syduchXVsnnxWxY1ZDRHjJhAd0qfi79Y4KbyvfZyrce
 RGbmk6AqZnJanIP06I8GFpeebOeAJOkWIy0lF7vB4tHR7HaV8Xbq2yEE-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8631e5e9-50ce-4889-82e7-b4815c2fd28e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Nov 2023 17:21:15 +0000
Received: by hermes--production-ne1-56df75844-jh4w4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ff49ad4e0dbb34301238ed939325073f;
          Tue, 07 Nov 2023 17:21:10 +0000 (UTC)
Message-ID: <765e5d26-973a-442b-86ed-81b5088237f9@schaufler-ca.com>
Date: Tue, 7 Nov 2023 09:21:09 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/23] ima: Align ima_inode_post_setattr() definition
 with LSM infrastructure
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
 <20231107134012.682009-2-roberto.sassu@huaweicloud.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231107134012.682009-2-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/2023 5:39 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Change ima_inode_post_setattr() definition, so that it can be registered as
> implementation of the inode_post_setattr hook (to be introduced).
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  fs/attr.c                             | 2 +-
>  include/linux/ima.h                   | 4 ++--
>  security/integrity/ima/ima_appraise.c | 3 ++-
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index bdf5deb06ea9..9bddc0a6352c 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -502,7 +502,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
>  
>  	if (!error) {
>  		fsnotify_change(dentry, ia_valid);
> -		ima_inode_post_setattr(idmap, dentry);
> +		ima_inode_post_setattr(idmap, dentry, ia_valid);
>  		evm_inode_post_setattr(dentry, ia_valid);
>  	}
>  
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 86b57757c7b1..910a2f11a906 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -186,7 +186,7 @@ static inline void ima_post_key_create_or_update(struct key *keyring,
>  #ifdef CONFIG_IMA_APPRAISE
>  extern bool is_ima_appraise_enabled(void);
>  extern void ima_inode_post_setattr(struct mnt_idmap *idmap,
> -				   struct dentry *dentry);
> +				   struct dentry *dentry, int ia_valid);
>  extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>  		       const void *xattr_value, size_t xattr_value_len);
>  extern int ima_inode_set_acl(struct mnt_idmap *idmap,
> @@ -206,7 +206,7 @@ static inline bool is_ima_appraise_enabled(void)
>  }
>  
>  static inline void ima_inode_post_setattr(struct mnt_idmap *idmap,
> -					  struct dentry *dentry)
> +					  struct dentry *dentry, int ia_valid)
>  {
>  	return;
>  }
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 870dde67707b..36c2938a5c69 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -629,6 +629,7 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
>   * ima_inode_post_setattr - reflect file metadata changes
>   * @idmap:  idmap of the mount the inode was found from
>   * @dentry: pointer to the affected dentry
> + * @ia_valid: for the UID and GID status
>   *
>   * Changes to a dentry's metadata might result in needing to appraise.
>   *
> @@ -636,7 +637,7 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
>   * to lock the inode's i_mutex.
>   */
>  void ima_inode_post_setattr(struct mnt_idmap *idmap,
> -			    struct dentry *dentry)
> +			    struct dentry *dentry, int ia_valid)
>  {
>  	struct inode *inode = d_backing_inode(dentry);
>  	struct integrity_iint_cache *iint;

