Return-Path: <linux-fsdevel+bounces-2281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A57D7E46E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A322B20E66
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 17:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93D2347BB;
	Tue,  7 Nov 2023 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="c0p0EafK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD5E347A0
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 17:27:10 +0000 (UTC)
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22D2101
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 09:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699378029; bh=6q0cWNpiI24bxTkhdHgeBp7Vw++Z68dhLPZ7Hg4uKl0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=c0p0EafKosFMT5TfbeHHbeVsHl3PPvJJYNbtsYn6BUQqw7pH5Jr8GGfvul+q3PaDvQ+PeqLPjyibYqrvZLkdqBO5uiXgbTnsz2hwpiRedZbsX8ruVzVeoDGTwp4TVP0j5WR3OL6cWRQR73FVci2TYqZak1o95Q3DlnvjLcxTmv7N7Xbt3oQUfw5bLoulpTLUPTlQVlzmylE1+mcUdchRzXZLTkqTFIV5KOc4+zgnzfwYyFx4iWo9McpdgRgZV2G0bnbdP822xP3VouHhWrMdTGbrjAxu0fL9EJsZwf8icTBSRSIvmMqbgEBarcLBH0EO9ZnDfPLptUY7lKZvXHaNXg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699378029; bh=ZC7+KihxtgbNsPip57C2uUGv48dOj4ZEzyPEmNPmX//=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=sfdxJBwbxD0sgdjbzSImTKu9GRRVEDZGQoO785lWKczfFeEj5afpXos2ijHFDDMuNQqetxb4zMyHverpgR8hlZ7gP5364mX/79vUFvofwLCk2HU98uqJkbTpEOaB/iOLO1imkm+xs4GoDghrZrhnTwv/xrWbtz/Z5uY8IWTgk1LaMNQU01a6MbNTpHIahczDLH/NkqVj28K9QPfggav/IScp4EnW+idLjjlsMarBatN1ISaHkgc0P3Iy9rZkssu5I7tSQ28oIN8Al3QlYYhDzQ7k0iBd2hi60Fo9MWkXFxQ2MSEgtMYnm8g41j+uesgGWMTofLfQCbHd3+3DP+kcQA==
X-YMail-OSG: 2ZRxZEEVM1kqlg7kxupQjl7rLLlyDa5CV91MLQcVFr6qWnYSVtcnZSdcdVYchvF
 1J6Kav6jXA8BmBQHq5xtGiPF28VWRvCvnYkZbRE_Arc.DoDzjry8ZcYm7_zFy2iEHAP5edgeCDxG
 p2NTiTspELaKH0Wd7iHGSxnfWzSiR3NKGtPrQ9K.WQJ.AMigUDOyVJ8LnecLXliojxs3gg0ZMdxV
 gzTReu2C_dtMXLHf5ICzTUb6vmJ8A_3K6YWjtxOymJqSM56uYvspHm6SGCUovdvH2MtYfAPmNcDE
 DHJRNog9xIXsHRsOkABhfbPJ6ctnPm344.d7i_N.VsmTPCyNR8JD_rQGiWHbjMkm3.hZmI7BQgB5
 B0mccNppsBc9zRihkazw9w0cai_2TKBWd88_U6c.HoEaHUHFgJHmPJFMJPURsXuFV_mI5wqYyaxw
 veSekkuM101HvdZKCwOT1P3bktNawvrWJhBsC4CzEQehXSzO6CQ7ERGd8PJTi.EalauGbAjeA95g
 xilj9kHYPOheZ5gSBQWBA4JY_A.ci5uV1p_OCZZRall8KuPM9eFP69XIQ.xaz12qHuAqHrwHBiBH
 Xhs0z46.X61H0uk7mcIq1wSUupjel_SNJrUkKlUGaMUiC7GAM0c79p1P5lGyDfnxzybzWPIIkSQj
 bjbBVLhub3c3_D9tQH42tQSvAWd5yfqJBmCpbiDkPNeNiiR06C1ojHiMwURDUh3rWw2bhYYkabeZ
 EIJRVaA1utxaX8d4esGHGERmG3eRpTVYV8BoNV_8o7C_.Xlg_st1mrcqJQGS5cp61gSacCnU74Ph
 0ewerl7sgrmQAccPEdb5I7MogCZ44Jna6ZaZDcBlHdyND2oA6B9bXCjlblCjga_DasUI40N4yxan
 gbe8sSG4_MonmUkM7TWnSK36JpU5FGncTm68Pi7yKuG87Rwzb3G43kvMh3yOVyjf8ZwM2YHVMJg_
 oC42_F96vvs4xF8AqkdDhbsVKfgFHZOADWilyo_xFknyPPATYvGK1h7RiWifYsTghr1V5KoXDgzK
 9ZlDGytaoBfKdvPlmCd1D4rA.8UDNGIrbRR.uxOi2DCadoDOnUpfZ.lTW98ZC5UAZZTaEglzwp_k
 etK7LRrPbitDLB64r3Un5MFouRzp0eHL4pITfZPkhOAMLO86VKgn21iQmHKyNXU7SPJvNqx0pulE
 db3ayser1YyriCfvZrXM2GIWoxDDGnvoMbaBtm8Bn7r8_4XQQ3gjp.ylqYA5Jo2U7DjT6VkDc3c0
 bvGn2edkZaZbjV44G.yO9L4NHtEB6EIFNT8ARpDPbsk5q0dcm0rWsyqzBFMc.zaSK_2rWKuhI.ak
 J8xbHkhQl2kpWkTK87plr1yMAMm88hwzo5Q.oBlDImGL9j.VFMAloNmZuveBVg5CxNIeqDjRS7BI
 7k8RK3xh4asckd4MPRSxMEQCRJNouCwiT25.OHid2ymZLp1_tDsVQNBWu30nblQmJOH0T_k3Byd0
 7YAbMVM8QyJMP3Gy4kA8mDn_vU5nwtcyXGdutyrC49j9UImXsV0NRzzXKjXkgPH3oNnK2i6EX7kD
 cubgGR5F9VKaOm0z4Bsep1Vqafpe2375PZkLlciENlvYy6uBEyPsVcs8W6733k_kSBKhooNJPjDV
 9ZWmHsnWGNEcy17wpXNlmsa4b1JYen.TUpMOaBlT3ib.WCHnpy2yeuaI3I6hYnzgEsOmLKHcxI09
 tMcNPP8LuNhAaCw_neZs2TDHhblqQL0iZVr8XvyiIBw_.moxct8fqmXGjekDw9Vdb0ngUFo0wBKN
 pWYj2C0TKQpNLVaEd2p_Oo7t6a1q7DbAQdvEJU8NkUSRWvaFHc2hjha29zYaQn3zXCVC_4wFxMD0
 lkXe6jBihJc.vhTPZkC_.73WSNEJzZXBCLiU_tJYKmu2.vajnw_2WpaX_Df7fO_EJIJcLpz_dPpu
 ciZCy519kfyk485xtvW_ja9TKqL.C_qe5r9jQygMa.w.lhoSmNCOo.hYf5Ha9g6O3N_BDUHe.DoZ
 lAeBCMY2lOdHkQ1R9KZPbykS0H8WgZSXbpZvtU6GAJ4FzuUVmFWqYx8qzoiW3D7flTedAnker4nj
 ePSyWkaoRJ.tTvT7YU._zn6LYhSmDGtRrHczTbeS5mJXv0QxhonWgW442uMkvxDPpJRrwvWIrMSD
 ZFajOrCWruMaoSf9F4ZQ69kWhrJ1ZchYDteHmWr_4poS8oWTn_U1B6mwjJgO5uRww1hBitsimzDE
 PnIuj_8wifXXvKdI4UMkinL5A0oj1w06QvuNfcHuh0FJ2C3jHfKueX.Fhgy7CFYNg4JtJpYI-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 757de431-ef3b-4289-bc0c-fb2e05a72139
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Nov 2023 17:27:09 +0000
Received: by hermes--production-ne1-56df75844-sgvl5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dd1678dbc22e7c871f89610e29169f07;
          Tue, 07 Nov 2023 17:27:06 +0000 (UTC)
Message-ID: <d8094860-f0a3-48f1-a38c-3829d501a6bc@schaufler-ca.com>
Date: Tue, 7 Nov 2023 09:27:05 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/23] evm: Align evm_inode_setxattr() definition with
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
 <20231107134012.682009-8-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231107134012.682009-8-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/2023 5:39 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Change evm_inode_setxattr() definition, so that it can be registered as
> implementation of the inode_setxattr hook.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  include/linux/evm.h               | 4 ++--
>  security/integrity/evm/evm_main.c | 3 ++-
>  security/security.c               | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/evm.h b/include/linux/evm.h
> index cf976d8dbd7a..7c6a74dbc093 100644
> --- a/include/linux/evm.h
> +++ b/include/linux/evm.h
> @@ -27,7 +27,7 @@ extern void evm_inode_post_setattr(struct mnt_idmap *idmap,
>  				   struct dentry *dentry, int ia_valid);
>  extern int evm_inode_setxattr(struct mnt_idmap *idmap,
>  			      struct dentry *dentry, const char *name,
> -			      const void *value, size_t size);
> +			      const void *value, size_t size, int flags);
>  extern void evm_inode_post_setxattr(struct dentry *dentry,
>  				    const char *xattr_name,
>  				    const void *xattr_value,
> @@ -106,7 +106,7 @@ static inline void evm_inode_post_setattr(struct mnt_idmap *idmap,
>  
>  static inline int evm_inode_setxattr(struct mnt_idmap *idmap,
>  				     struct dentry *dentry, const char *name,
> -				     const void *value, size_t size)
> +				     const void *value, size_t size, int flags)
>  {
>  	return 0;
>  }
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index d452d469c503..7fc083d53fdf 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -558,6 +558,7 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
>   * @xattr_name: pointer to the affected extended attribute name
>   * @xattr_value: pointer to the new extended attribute value
>   * @xattr_value_len: pointer to the new extended attribute value length
> + * @flags: flags to pass into filesystem operations
>   *
>   * Before allowing the 'security.evm' protected xattr to be updated,
>   * verify the existing value is valid.  As only the kernel should have
> @@ -567,7 +568,7 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
>   */
>  int evm_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  		       const char *xattr_name, const void *xattr_value,
> -		       size_t xattr_value_len)
> +		       size_t xattr_value_len, int flags)
>  {
>  	const struct evm_ima_xattr_data *xattr_data = xattr_value;
>  
> diff --git a/security/security.c b/security/security.c
> index 358ec01a5492..ae3625198c9f 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2272,7 +2272,7 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
>  	ret = ima_inode_setxattr(idmap, dentry, name, value, size, flags);
>  	if (ret)
>  		return ret;
> -	return evm_inode_setxattr(idmap, dentry, name, value, size);
> +	return evm_inode_setxattr(idmap, dentry, name, value, size, flags);
>  }
>  
>  /**

