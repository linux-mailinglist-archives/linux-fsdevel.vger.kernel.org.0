Return-Path: <linux-fsdevel+bounces-2278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FEC7E46C9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465D31C209CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 17:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510AD347B7;
	Tue,  7 Nov 2023 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rdj2ZjzC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C651328DD
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 17:24:14 +0000 (UTC)
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70B1113
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 09:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699377853; bh=uXmPHTvUbz6sszab9fn8DlTvb1KVw2BghtMCHwCGtWU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=rdj2ZjzCy+4Zb2fgRRNob/3Rqv9Ut3G+lUydRPSlWRHHxOQ8cS/VGuavVxdNqC0Bz/C2rFjoWkHmjJQDrPRwzFpg4L3MVMvOU1VGpWYbEW4Acgp4gPBcknH9LWlGs7TlWtRslsu/5z4/zGemhPPK9cZjERMvhIBPxYcbdbaHUtejDD886Azrws3YXA0hu6C8RfwJaulDHWgrg2S9ZTMXElQ36ucLmS46dU6HpiM2XQEkwivlVrwNSR04UxMP61DZ2yo97L/TYjOs2RXqRWMg35wSFE+VIM3T0PhQFY7qvZdKrNDg4nJaUAMLfuJVYUbDQyVqNGKS2sGrjKHWMnLcCw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699377853; bh=fp6XSCWINzeezmYTFlRDZr4slFSGndpvixsrdNhlYKR=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=TcDF3mWXhmx535gAwt+M3pCVK3AhhoRfIYSNkZlrmNvPReTYFrOykuWIRQ+o9/ShdO26KF1rO1uqrIMbTGxWmysi14FdhzE3pog+VYvFwB3DV9YJaRqPMsXEVgMyw/ecbpi6CnPfgY7koLlbgsEdt0aXxHUFvC4nsmVn/GfmIfuKJwSfTDXb2X8IsKfBAOGVV1bC80rKiOJ5mjZ+pHn5X6QxtHuDz/H+XGCcTR/ntVlo4kvdocI+suvleGkmm2EFuknBev/ZZcDmmv9e+gAKJX9FMLpOHI5B9ks9hR0TCsOZr5Rx/W8q4DbZmFdc/uVsgTEp4PC4IbCBTGrpyX20rw==
X-YMail-OSG: Sg1wd5UVM1lNSJPlB8W8XNn96fahcVxYlGiJWBmOWkDs4Yak38tuI0gRgOLxX.Z
 aTzoiLd02TXjWqlsjgFAtdZMzIZTqTbIyasVsr8Gi.qphSO9WOa03BqAxrUKZk.dWRy5wR7O_nRq
 QyYTM3ScupulMBkWG8fwXOWIWkcu4TU539sRm9At.lR1lzjATJ_cxF41CztWqdbUU3_KpiOyZOf6
 5KG8m5NCE0RTgMfR85Z6xZ.Q3IZSnq0yyb97yhRC4jFDCF3O6EIvgvL_U0rXoLvvxleHC3eV7DvC
 GkPfkhd9Lxx2kn4nRVSL7egjHfAzHKVAHH.lQRkeok_flymKjgHrQZoEoY3xmSmR4kBxzYX2dqwC
 A3Q8YSNsrC1qhBpib_nChWbJ.iytYLhEJZKuDXnfwOevykZuHSeHlH1QYtHtIhT_pMc5W7HKpAvH
 3hX8ikaEs10lrfbt8zMswce6C1GnZ.C6zYrGnNTTIlROPo0k9G8lOwPttgmtpY5FkSRZEkzpZw.3
 IUv3iZWM5n2ryKk0AIcvDRhELqITAXtdR.hvrtN6VMiz0D_LqR4rjCvl728v4PoWH9GGv6DIVyME
 LOoeBpEKYDSJF2ofXCT3_MOFKqxlYuY.b8lkA4AE79BhJWtw7Ue3LpNqU.iGnFrqU9bsbsE2CoGZ
 5NbOYdXjNxTArBjS9SZWksfAifJfp9BMNJDuSC6q2KYX9bqzGjRpxTi64Hk6W0psn7JHOMsxNG5Q
 5U3.PMb92tN4vIxKOtPoJLhlpz_JeAh7h3ZVgj286lgmGeTC99u1XyK8zSRTMmEarxXKTYnZRQ0H
 AE8BXcI5QM2zNNsXaLm7UCb1UsU.L7VyR.acilH2dsMbNLFZHvkFmG.KC5ALQoVMEdjPuG297ceh
 A9ABJNnKUZ5ejle9gqmFG6ohspCFiPH22bIh_SxtZmLR07dmL.XW8bnxdBEhMwGmEOK2.Uu0KUZM
 uPfMV3RZojt354BrcrBPnqxHtju77AZ9Sas3DqID1c_OhA.srDE1xRLc9FB9RsgrabwW9Mz7xc50
 mnKvkqVi0A4ewxg9xu6gbRnZDV4SQNr7_FnWvBwfPta71j4eXg1Zi8r_odiuthlIpEWGuqmHO3jA
 TlZay.uNf0BHKR4bddYLuwLS01AzlkoIF9Vv_.AxvL1ZhsriGOm12g87N9rgzToZjFpuQ6v4VvKf
 i0f1T5_tBUi8Z82CTiJo35yUWlFI_rkn0WDPHWwrGYrMyCqZHBZaNBLQwTLfnCuES9jBymxJq9g2
 TLK825Lr8q.wIS01BdOvGYIhhTCxzqxs7hkCe8weYMgNyZQ1ncfqQ8zU55RS.GogtD7Uj72lssQ9
 0Z.4IIx7chyrrUtrfluXszoisGEZ6yHFkyBPJHkNFGnmilYlC4.JNyIVsHEiiQo3fSYK9h7ICAcn
 3Xlr7gqThCBDIAUSEqxWGzVg8R1FzUK9vaLSuJU7Lpsn1m.kIH0DtTgWZYIiy4fMUFqWEnlQqLxe
 IQtMblrSSd4DtUB6LtXn9m692w9oCh5FQY4BBNQTOOIoAcrvyl9TqGeBCV2pNrm.Xd9r5hEdl20G
 _p5nKKop0M1lAW0R6gS5MxSwaF8FRQQATfcAn.lemvKrZNS2Bxtm.ozWyaUwIHnu7Ca7ukIq1orV
 sZGJOX3T4S95bgGK63.JrV76iRMuvVYCydmYWt4I3jXsgbfHsqm0BHgJCUmMK_6G59VhoRJ4NXmu
 jYa6t7g_dDTO.ULQT.CkUof912a_ySk8iDuc6s9DcTfEkteCOnW23qoDHg_0cnMDPC33xgVGYZl.
 NyTUMIZq.yrS6.MPa6SB7dBm10XXp1IMaruEuW6HkSNFewFfQYNnuzbUyBCZl_Msr_8iqX5FCsNE
 I0h6EPfr8CJFmH6h36bduPeP_pQUUMmxywgtFFpnZPQ7llZ7UpgGGkRtEemRXp4SdfbC0xs_iSAU
 AEb0gqKjJBHsN3ujyCr3Q5zqkxxgjlunobZLMg6Jgc8rX6cK_mAZKcDWrgcGUkq9K8rfaBsb.SxM
 PSkAvqcwakuyshCEAxz.FzJSRRUB1w6gqE0cPyY4dom48f5c_e8ZXEkmh4pk17NX4u6T4kgRR.98
 qyaMXxU9qn4JFXMKupHR7xDs5OnnwvNFDyONIeoTooD2O3ESdPlfud3ytIyBZtrtUStk3mmWGoaF
 irhX6d1PyWr6SgCj9rKZuKSfjip9bAz2ESRHWMXuNBCII.E2iRxSLK41lgGTvfzkt8q5YGEcmQsw
 TNGlL3mM6QhbEiITyJjZdPkPLCHqM6YbT5Ibm8epuR9da89o16P.qhMUlkV_HFB9V9tggJQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c4cf64ea-9951-47ca-9f25-75b530ee50e7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Nov 2023 17:24:13 +0000
Received: by hermes--production-ne1-56df75844-vlcrv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f65706eb2f505f823b3ecf99fabcb059;
          Tue, 07 Nov 2023 17:24:12 +0000 (UTC)
Message-ID: <38ef6320-76c4-4e5a-b930-151aeba6c739@schaufler-ca.com>
Date: Tue, 7 Nov 2023 09:24:11 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/23] ima: Align ima_inode_removexattr() definition
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
 <20231107134012.682009-5-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231107134012.682009-5-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/2023 5:39 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Change ima_inode_removexattr() definition, so that it can be registered as
> implementation of the inode_removexattr hook.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  include/linux/ima.h                   | 7 +++++--
>  security/integrity/ima/ima_appraise.c | 3 ++-
>  security/security.c                   | 2 +-
>  3 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 077324309c11..678a03fddd7e 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -200,7 +200,9 @@ static inline int ima_inode_remove_acl(struct mnt_idmap *idmap,
>  {
>  	return ima_inode_set_acl(idmap, dentry, acl_name, NULL);
>  }
> -extern int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name);
> +
> +extern int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +				 const char *xattr_name);
>  #else
>  static inline bool is_ima_appraise_enabled(void)
>  {
> @@ -231,7 +233,8 @@ static inline int ima_inode_set_acl(struct mnt_idmap *idmap,
>  	return 0;
>  }
>  
> -static inline int ima_inode_removexattr(struct dentry *dentry,
> +static inline int ima_inode_removexattr(struct mnt_idmap *idmap,
> +					struct dentry *dentry,
>  					const char *xattr_name)
>  {
>  	return 0;
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index cb2d0d11aa77..36abc84ba299 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -790,7 +790,8 @@ int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  	return 0;
>  }
>  
> -int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name)
> +int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +			  const char *xattr_name)
>  {
>  	int result;
>  
> diff --git a/security/security.c b/security/security.c
> index ec5c8065ea36..358ec01a5492 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2430,7 +2430,7 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
>  		ret = cap_inode_removexattr(idmap, dentry, name);
>  	if (ret)
>  		return ret;
> -	ret = ima_inode_removexattr(dentry, name);
> +	ret = ima_inode_removexattr(idmap, dentry, name);
>  	if (ret)
>  		return ret;
>  	return evm_inode_removexattr(idmap, dentry, name);

