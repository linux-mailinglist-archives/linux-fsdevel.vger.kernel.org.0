Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBFC357204
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 18:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354264AbhDGQSD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 12:18:03 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:35034
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235267AbhDGQSA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617812271; bh=RH/C0ZGU8QznM93ZdyakEPJ0j/C5GrpkDA/zRQquAqk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=h+xVTT3ruiDxeZtjyi6NrzCnT/q8Vw5sUeKMhir4Tu4Hj2rM2lAHzl7OLLIfjaHxY0SlorTWwhM4deaSQh1H3Iq4DCqb4W6eJ2og/HEtl+4gts2qduGTArMPFGU5PnQkRTUoU7qAJpGwNLPVI01qnLAzuLSRzj3RV0QNSdvubpqYjoD4/CHPvly5B7G0QeF0UZ+zGoNwu1i6hm9BMwXUONd2OTC+z3R3Nkcs1wZYpobqoQl2Vhdt3wUfKugyqU5Hy/GHA6Kxz6gVoVVQrYM9LrOe1BW8oMQRuMbuT4+SnQrqbtYYjWfcm/+kFEuYaM3OBera9qAUSt9CP5i/VUoGNA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617812271; bh=VWRICCPO34F7rSYE8q2DL4GzJVX1SvRKP0ggb/XpOcQ=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=smCHH40f9Z0uLRYh9DIEZc94pHcZCvPBUgiq9Znfpny6kZCNrxFdlLBnmkbR6yrEYKGgKVWiOtjc5zmCYkGGmCmef/9o5dLHs00LHnW4sPlx2gatgJWvsphlMqp6SEm/X1Io1ZU1/h0IRGSm3shIwsa5KQxeCTzctrI+KTprzyXS16mEeQYAxYvwEJ9A0WcsdWe3723o1QIeaTjZKn/EXGonjewxT1/ldhwiVopMNPPiWThhcrD0kSNT3hjSFeY+zhVAv5sQy926fwo/QlKpAdtIJ5w/XHiKPz7gIbOA0AadwiTPItd0ysTKhRRvkWxZwtTcY5q8xzNqUkfu1dgZAg==
X-YMail-OSG: MU9vp.YVM1lbjl7qKU3pn2HnS0.c3_7LLsv1D9xjA4k9qTtDjtxHiiYxwDXNaTJ
 kV2JfEI1JaB2coh8DVZF9lRV2z2rJw7AguQYHPC_LbESjlAu5Jfv9uUl9j6bkXgEANjJsKF0AS3n
 lb9B08p7DJfht_zeuS_4glDV1Dg4RM.WbY_A1DjvhWAjhGJJFAJV2InXfXeQNVyyfpbYiJrBQj0W
 2MbfqyQk3iblUm1HXz9TNxjr3IvvuSFl7lUJUby.snclVkguxEIyvu5lKa09tUvuKq1RLHL_CIZA
 WETPOarv4_J.0dsweyfaDV9dClZhDM7K7fKuQwTq9LYrYHFOmnq233J6LNwd95ljtPw7On5dn1cD
 CniaY5ZqlEX7LA2ysm7DTOWEgELTYBoZb7OdG_2RQeJAtyQl7oZbMJ6_VxzVQ447BNs7Q2k0ban9
 _3_vbtd34a.UmpOzHTuGcvzD2.xG_FkICDczrrWj8HNcRpb_VsfxezQjPNpbqapLoCQ0s1K3tjP3
 FvFteV8LgV3A4R9wg4j8ezpiz2LuGlaU58IQQtXYKowt2i7J3_.7XPXVFHKUm7qT1I.uZWj5vmdI
 HMSOWqKs0JlpybC8Q1ywUMXwhI7_PFmesyDmz3kaNPZrtUWnQ6JHUUdyxp.OTBe748dcHk4ZPZa6
 1EgqTqiuaP4R8LlivTrS6S_rLvlrtyTEoPY8An5Cym62zJ4eIR_KV3w7ru4J6IFbw.h.B2Ad6JrF
 dUW9NPVRNlbdarKL1ftywe6z5V3b7lVw9YdrwrfrKuR7OI7H20NVtcWtAUwrDkJP8mPlqu8D.7ll
 yWW.3juLRGBxNorafC2WXIegC153xG2tkXjGiPXMweIhxDqctTlpfnDLtO19QLEATVCsnS6RGa7h
 ySvIN0fPb3rH.ZwCoDE8aT_n7L0_VMJoHFnhf4yzyoe_kfUP8SIWRM_7lRBcUQPrNc67KZGrFbb3
 ELtxVMmtyjgZvO2EptnqwBd7k88q8rUkyov0O4GToc6ycf9GWbMeMp4Qf9DR8XfoE3bqeK2TtmU1
 spoiihoiHxZgZnwj9GPHGeM_MROOFGOM1jM_FngNZ_Ic2o_BpVo2wPFAz.964t4oin6jMyNO.w8J
 HoaD6IXlsd1vw43X3OTCvq_B2Kcyyh_m2tkH7WWj1IU4Iu0PjYG5QPYiN_tpd_TQOTiFBaimyipP
 KuVTNHE4zUGrRLZeJouWtr_OkxsavVZjmum4aeH3umhmTnOlLTokpwQ8y4.y73w3No4KO36ybMmT
 72URILrTIKGuihYEYszZGumlomKOLpv2UcTa4.sUYqLrGzlTsoXwNfO62__vFF.p.p8MwKUzdbKn
 BBYSnZjIvrd0F5RzSDfw4MUkpCOat5tcF1byK2ovg1TEtxyZ1EyFerBIBZvsJgUfqZnkTvG2qwY8
 8.5go4bHR1wnmkzBMS6NE76XJgK913d6PHlu2aA0yTFcYkwS7UfPunGldgH6MD2sRoWm_Ang0sHV
 PLrC7m9W7Kmz7medFiAjeqz6w1g8oyNyvP_EUSEsLEpdIcJFuiD88cs56LBjdRxZp0oSq1xT9d21
 Dnl2GUHb9gf0s8ryo4JpBxbs0V4YDw7VSE6SNTopUXsyEnEefVcNGoqBKFzSL8bHT2YukilYhCPu
 kw_m9QwHaquoa5v0VhCw3T0CPWKuIumGQUZivSgav4.4fofTyCGP3IWiXosqhvYeLUTtGGzyKolW
 oHvc7vi72_kHX6G8MGv2yw5f9E6Gr6z4N9xOpohIcUKoWu80DE7asKMyat2HYsLZQ3XEV80W7rXR
 KY4qutquPZ4ND3f6Q4htp.4zuvcx4xFHoGLVdX4jpxcbtCKbVjKLgU6iKkgsJs.Rk1rZEibJzFe.
 ip65zT4BkgDKdemMQLLG7sCil_RbDsPKRtGBTaRpuswKk7v4nHu4lwJg3k6ugvjZ2dPW.XvZSNKT
 lHXENXpbXj9PpB9uxVRvC8FtB389lw5FFK2w4gbaB2rQai6.k33K4gw_Gd1Jx5eppE3sowRwlZ8e
 7OskrPZfeuJyId6m6H6STTgVAGwpU2yHTCbLP_VEnk1Y9mj7_L.7fhe_PF6WAYppTtMPA6_o.ol.
 Mo7JnrwM1FZeJS1V0kEF9H.aJoR7FvUEsPQUqLQ4rbFa.T74Gvs4cbKsCGtyxKgjUdUdyKbwFOXw
 kBOrTLNc9WhSsBJQvhaXYnAAV4NCpLdW8NnGCRiDYqtmOOasTJNz.bISYyLNxj6IFDEHo_xH8A5q
 sYn69YwLZCd3Nuy3Zuq1LCfSMdkc49iCbFIGJxGdIqJDNwlRW3F.o9DfoTyVDBFr8Vu.fv5p5.8L
 Hg7UTWc2an42e5MWSoon8YLBf.FyTf85g1f.L8vR48p1D00miTsSYbio6uEvkMsSKn5_K5kjDXvS
 Zu8k._UoKPYxfvTNC8B8nKkvnmrmv.giszr63tjuGWcQQFt.pq46I2b2iwUxtD_ZNyUMgO2AX1cH
 AGHNbShzsVu7OrSVg9oKBSeIT9F_blNVjptkrCNmA20aA1UDQpQJrExutOoJa03gCqmyOrYUwavY
 5Kujg5YuscHYBuNtuixxPqsnRTr_pkeVaJRafdqrM0BgSUX.AV1MbfTyhhblLwpy4T10d.I5qtO0
 EqTaZkAWoYx_HLEhQ2SFmA1xRLRkQ0fmJmgPe8p9ikKExEJ.el6a3grffmu8L0xWyfTbBvoX5Jap
 4gkqAKPptBkIS68WMGxSpg86C_y9KPjEgFyq97avW93286eMJDbqyvZAbsRA4c_E8dYwYFtfd9V4
 vEahYHn_BdEPsCxrd1SlF.IMNXQwmRto2m.53pDiq6BOrn.L.jFLdPNZQZR_XHhppdMgvDLyVgQ4
 OpHRX3pbnhc6dPjJQH7nRPPVtXs2xf33KQoSZwnqSmf_o6ptL4F4qMY03f1m0Z9Mw2PW5.Yl3h6m
 cPIv6bkKfFkECAiQzr8LJLFqeIWeKiqmf7pgny7HGnoIFrlUuxtkrXFf6F2kMU7Lpka7827QE_yv
 a5V6LFIrW5j3JIr_Og3Ng8hIE_SZQC3JTGobqNNlNCQYCcdLbji7ZLF4.n4wbJg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Apr 2021 16:17:51 +0000
Received: by kubenode505.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 63d65623a32099db06d7d78867dda892;
          Wed, 07 Apr 2021 16:17:48 +0000 (UTC)
Subject: Re: [PATCH v5 04/12] ima: Move ima_reset_appraise_flags() call to
 post hooks
To:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com,
        mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
 <20210407105252.30721-5-roberto.sassu@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <d4aba724-2935-467b-e57c-cd961112190b@schaufler-ca.com>
Date:   Wed, 7 Apr 2021 09:17:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210407105252.30721-5-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17936 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/7/2021 3:52 AM, Roberto Sassu wrote:
> ima_inode_setxattr() and ima_inode_removexattr() hooks are called befor=
e an
> operation is performed. Thus, ima_reset_appraise_flags() should not be
> called there, as flags might be unnecessarily reset if the operation is=

> denied.
>
> This patch introduces the post hooks ima_inode_post_setxattr() and
> ima_inode_post_removexattr(), and adds the call to
> ima_reset_appraise_flags() in the new functions.
>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/xattr.c                            |  2 ++
>  include/linux/ima.h                   | 18 ++++++++++++++++++
>  security/integrity/ima/ima_appraise.c | 25 ++++++++++++++++++++++---
>  security/security.c                   |  1 +
>  4 files changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/fs/xattr.c b/fs/xattr.c
> index b3444e06cded..81847f132d26 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -16,6 +16,7 @@
>  #include <linux/namei.h>
>  #include <linux/security.h>
>  #include <linux/evm.h>
> +#include <linux/ima.h>
>  #include <linux/syscalls.h>
>  #include <linux/export.h>
>  #include <linux/fsnotify.h>
> @@ -502,6 +503,7 @@ __vfs_removexattr_locked(struct user_namespace *mnt=
_userns,
> =20
>  	if (!error) {
>  		fsnotify_xattr(dentry);
> +		ima_inode_post_removexattr(dentry, name);
>  		evm_inode_post_removexattr(dentry, name);
>  	}
> =20
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 61d5723ec303..5e059da43857 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -171,7 +171,13 @@ extern void ima_inode_post_setattr(struct user_nam=
espace *mnt_userns,
>  				   struct dentry *dentry);
>  extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr=
_name,
>  		       const void *xattr_value, size_t xattr_value_len);
> +extern void ima_inode_post_setxattr(struct dentry *dentry,
> +				    const char *xattr_name,
> +				    const void *xattr_value,
> +				    size_t xattr_value_len);
>  extern int ima_inode_removexattr(struct dentry *dentry, const char *xa=
ttr_name);
> +extern void ima_inode_post_removexattr(struct dentry *dentry,
> +				       const char *xattr_name);
>  #else
>  static inline bool is_ima_appraise_enabled(void)
>  {
> @@ -192,11 +198,23 @@ static inline int ima_inode_setxattr(struct dentr=
y *dentry,
>  	return 0;
>  }
> =20
> +static inline void ima_inode_post_setxattr(struct dentry *dentry,
> +					   const char *xattr_name,
> +					   const void *xattr_value,
> +					   size_t xattr_value_len)
> +{
> +}
> +
>  static inline int ima_inode_removexattr(struct dentry *dentry,
>  					const char *xattr_name)
>  {
>  	return 0;
>  }
> +
> +static inline void ima_inode_post_removexattr(struct dentry *dentry,
> +					      const char *xattr_name)
> +{
> +}
>  #endif /* CONFIG_IMA_APPRAISE */
> =20
>  #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_K=
EYRING)
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity=
/ima/ima_appraise.c
> index 565e33ff19d0..1f029e4c8d7f 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -577,21 +577,40 @@ int ima_inode_setxattr(struct dentry *dentry, con=
st char *xattr_name,
>  	if (result =3D=3D 1) {
>  		if (!xattr_value_len || (xvalue->type >=3D IMA_XATTR_LAST))
>  			return -EINVAL;
> -		ima_reset_appraise_flags(d_backing_inode(dentry),
> -			xvalue->type =3D=3D EVM_IMA_XATTR_DIGSIG);
>  		result =3D 0;
>  	}
>  	return result;
>  }
> =20
> +void ima_inode_post_setxattr(struct dentry *dentry, const char *xattr_=
name,
> +			     const void *xattr_value, size_t xattr_value_len)
> +{
> +	const struct evm_ima_xattr_data *xvalue =3D xattr_value;
> +	int result;
> +
> +	result =3D ima_protect_xattr(dentry, xattr_name, xattr_value,
> +				   xattr_value_len);
> +	if (result =3D=3D 1)
> +		ima_reset_appraise_flags(d_backing_inode(dentry),
> +			xvalue->type =3D=3D EVM_IMA_XATTR_DIGSIG);
> +}
> +

Now you're calling ima_protect_xattr() twice for each setxattr.
Is that safe? Is it performant? Does it matter?

>  int ima_inode_removexattr(struct dentry *dentry, const char *xattr_nam=
e)
>  {
>  	int result;
> =20
>  	result =3D ima_protect_xattr(dentry, xattr_name, NULL, 0);
>  	if (result =3D=3D 1) {
> -		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
>  		result =3D 0;
>  	}
>  	return result;
>  }
> +
> +void ima_inode_post_removexattr(struct dentry *dentry, const char *xat=
tr_name)
> +{
> +	int result;
> +
> +	result =3D ima_protect_xattr(dentry, xattr_name, NULL, 0);
> +	if (result =3D=3D 1)
> +		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
> +}

Now you're calling ima_protect_xattr() twice for each removexattr.
Is that safe? Is it performant? Does it matter?

> diff --git a/security/security.c b/security/security.c
> index 5ac96b16f8fa..efb1f874dc41 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1319,6 +1319,7 @@ void security_inode_post_setxattr(struct dentry *=
dentry, const char *name,
>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>  		return;
>  	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags)=
;
> +	ima_inode_post_setxattr(dentry, name, value, size);
>  	evm_inode_post_setxattr(dentry, name, value, size);
>  }
> =20

