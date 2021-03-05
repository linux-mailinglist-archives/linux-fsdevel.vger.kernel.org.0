Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6022B32F13D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 18:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCERba (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Mar 2021 12:31:30 -0500
Received: from sonic314-26.consmr.mail.ne1.yahoo.com ([66.163.189.152]:40746
        "EHLO sonic314-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229898AbhCERbF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614965456; bh=xDHJeniJVXoxl0xE3ojP+1HxnFlm4O2iTakPSPTvHys=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=a5yQqPo8Q7jbDO/9AssQVHIkJIxiI4vlnP8CCmbxTIVRsdfzhMedeEAttWn5T4zUxKMkcfLFv/kbP6PZIVsFGblhdKCA6ki6WM2SNE0QkwjFIzx9GjFIPgS+lPa5Fv6itvk3yNJvvy69Egb8XogDW+o+fZyOZyQgt227HR4H7skQOhZEdMQT58v7PrsOfCLyGFT3cU9pw2GjdgAV4+ChwoNaSIxUmBIliopt37Y48Gd3d0WUpLf9CHs4y8L393nhRFBwDupfB1EBhLkMphoetnf9wwrxfHhUKefapH/VpL3xmDqq4bzYNXzQmrkCEpoZk74/wHLLstenmw6mAM9MTg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614965456; bh=0dBi7FWX2OkkOc35Ghg4RC8ZDEFVywE8hwXyvk+vKBC=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=dD7t8FsMeMJg0FkdXZ5Y9CHGzsLE2zA2d4b5IrMVSI2DQxPTsbMbFxe8eMeZ09XWAYKRI/RUdLub04HGNUneBhq1L7/x1N7OVeATFXCDFIuQbm6LEWdLmJditLTkd1OFCviOpBLKZRhfQg/s4Jigo3Lu4OCDIUqXWDcJ+V4JLhURKw31X5lODAJMNwODRQc5yexNthA98wzPrLn5qkd26h47ph9mSi2afDMQ3r/Xb/3ShsTaZ4ibkt8E6a/IJ24kF6xfgKNuOUBEbzS/k9OmAtXn48o3fV5pB98dEy8FjpisDLfHzpWrHGyU2ZHOFQNtccmDD2X60RHWRwO6m49sUg==
X-YMail-OSG: c.JeB4MVM1nuDZkSXTX3sdx4zQBwqejEF2HnCVcsy4s4Kq3NlUSYIIYgqd4zmJB
 qm8Y1aWJdIbo1Q1ymtOzXpQQJg3nU3b3cGTgRMZcTGAUBkUisXkWQ1uLxobr5buNtqKtDXNLU.7O
 45gakF7CzvKO4sW3BKHv5yTXtUcBjppCkl_Q4gTLW7v8ttj9b7IYimirBNU3Blux1lmwF3wppSxZ
 UcvyTbNB2eRVavTJYRLNPf5Tk3mKVUpazL3fDMVKOkE4U9Kkf7XLJlQ.Blc1tZGHYycj9O9wRpM8
 XHf_DVrvUQlEewwlyuOWQauDB1bxi2bTbRyv0mXDRS.H3wuSCn62retqDS7oa5lzM_uf8MbEzZno
 XogKqsZ0J1PbOdX9MhDzIHFSITVhhYZnosMXWQZTIkc_Xms_iCbQISX7yGz6kPqS2Kc5VV4ZskD0
 AQj0m8HGR7skNrXHWKCFUn_lQ74xsOYBnPb1H4F4pWYwNBk8cLVwQXxtD4EIbp9ASgO0supvVscd
 mueCpV5aJ_tdgj054QiNatH0SAxRZozj_ZWduHQgVhIkrD67964S7NBxfY0bmSlTduhisK_mrJbn
 EbGe_f40CE7R1.33jVbH9vumbsIFN.PABVUvbRZPD0FqENcJqFZI5kN_MH5WSuIgiNTElRzcLsD5
 Q9q9MI2rqws6j6gaP2dIfVintHUmgVJiPU_E4kqp6KYv2KN.LyJ2bHfzms7r88pJN3nxPBKv_fmb
 T3RFFm3Wbbqo1jyQrtDKXMI4IFvHfymcz.QMA96L8mkeCQfpzQJIdbF.X9REIbXtMKM1HpM8eMU3
 Fo55L41j6CV9shpRwXFqXV6EST9V.kbxZAWhi6gRgw_55T.P0ftHbF6fHbC..HxFmxrRWbRcJR9d
 aSvFX4W0OX3oXCdbgoJ_My.XwgQJCAhcYikxXwodPUvKyDyPtFc9HaW3LO3AgGKscNqZdSlAMnvI
 TyFzVYizaKjEqnWJjbZh4DtxQXwe1Q6c4jPa1d_jsPGtvEghaoVG5svH5eGVcI5xifW3oMbgAW6e
 YO0OEN9ub_pCoggE9Do27vBB_6p80.6GRKypZoi2PdEB5NoJSrUaFbjUKNQr0yULTqjqw0HFDxob
 7AOhPkwmBM0MIjxOwauV2LVShUAl_qgtVHAy8.LiIeH1H7qt8C32vJNOjxpjHGsSyjZEtilDdJqH
 qsYqFSPxVjFi74FBCqypnFFN5QQN8FDrGxrH7yFIW7vzCyEkf15nDSvfn6ALf1bA6Kijjq5rPp6z
 vYluwLSei56s2XjKQ99DNCpA2jVPvapE40QZohAIvl0E8sjhl.ZDAFP.njUNLzWYdRWEPzMQ44PB
 gBkeFuVxLR1wJx70RVaq.zhVl6rBRB7n3aXS2FOFl876d4LmwQaPNo2uWYfUrRDbhEwKG6ZLTHEI
 T0t4CEfsRBaWmNeVr3zGuqJ55JINvXxMW3r0DqswBjGmDbZeDCdioQTwdQ0.Z9MlKucytHHYQWha
 cb95GIW8lnjg6oSFXTEVR1mY8rldMc6N1sFILWgUez7QXGHHlSCzGlJTr9veoutGvmtDjbVw2ISu
 HLCQwdfoaSh_wGDyb7Av0f1sD46tjeTjNzkoMXzmjKDNmTxgwXUQ3_0LcoRuthvUL.5gK9MY12hG
 m.e7SbJlpsAap9tNvLy9f7Dr0mAtsB0IgETy_TPhJliOM2EdoB7dBJsx6RMUnZzS_pkJreneblTD
 R.VQZbD2ze9hsC4XKpKWJfeaVJ9OHevmx3_PTqXw2XFoEPWtqyETlRkV2weTunNThEQY6Rd4s612
 4Q07RcgKPfj1.s2fU2dz5bbCsSC6dVILLLJ2dR99DWIFKYqf07FbKwp69nUpp_ncbCubC9PisoWw
 2h7MNtYzFf1DzJ26l9You1BALDK7DkH5Eu12XOm70aWxYYz4IT0PPGgV9EQkWQ6hxcNMdCrIxgH5
 KoWH5pxRcTxuJt7o6PRXkle.rgRdHVimGAZ8kdemKf07H78cj3gBfx6wlmP9pcGzAVGEukY2XHFG
 2E.WSoXdhAU3gUqo48CxnAGNpuSLaINpGuPq1Qa7xLe8gYANAgRLeo1oe0uTXFBpAXv6_4jcjaee
 fSaLqSqV1HVPztVLGBx2jfySH7rdpuWOpcTB4Sw3qaaR5BN4jUdVZTeUEcF6VkKSfJfL2t6JB9de
 peP6IBsG.fgS7v48fRJ0SaPOSTRosnG2t6cqGG7fM82RN8bc4BH_cHzQJUlYsv27N7jFGdHYuuVD
 lYW0vJLiwi6anFpVN4PsaOUtwMLiQjG4C1ZXa7_G0gZx_6bgy5z_MjJfkinT0Zaifu9fnstD354N
 KDqoIdEamawIX8M3W58BROEjz7nlC6_9ZwVFTFfd_5aqnjgBVN1eZxbL5eeTGxkBvzSjiKDWIb6f
 mrNqlZTfmBZgjwNUGXytuqXup6u2YCZ0aICGYirIM.ZyQlX40jF0VVygQ95QFkQ9Sezx8ku_KlFa
 Hgd2m8554sSKahzeUFuAfR.4GziODgx0MV9q885p3zVHdXJsVNWkK06NAUV.SRUAJz5IgU8HWZaj
 OZo4cxclk2fWRRuXw9dzXSGwEqp0Gu0EHj7Va0o6Dx37qs53ts2nuSIeA_TkKtI70xSepfrupLTa
 iidvjiNHx9ptKgHQUxHCP60QureivqXarKKjQvfv0Qy47iKPEoTlZhYyZUIuorsDNlLPyoM.hrhv
 Br29mNwi7UNiPI2Lfl2ajUbMh26rKESe42ECLoRL1Dut4UXvOcvQpk4f57SwZQzGIlolPtKymADm
 S6g.golYe7BJblTLMmjRGfvoPbuD5tlsVC0HBQA0HhNSzKvXOJ6SsV5gX7MVXcL.GIafRr_D.JI4
 YCvrdxTFdRVmZIhdQt8o.YQmqhzUUmTJycrtB_1DXRlWUwiH64yRgya8pdQuR5RVESRLse9PLWyU
 FOivoCilKZSeAlWT6GPGplQ8w.G_npgA-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 5 Mar 2021 17:30:56 +0000
Received: by kubenode553.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b5277aefe63545e3725ff8aaef235e24;
          Fri, 05 Mar 2021 17:30:53 +0000 (UTC)
Subject: Re: [PATCH v4 04/11] ima: Move ima_reset_appraise_flags() call to
 post hooks
To:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com,
        mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210305151923.29039-1-roberto.sassu@huawei.com>
 <20210305151923.29039-5-roberto.sassu@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <c3bb1069-c732-d3cf-0dde-7a83b3f31871@schaufler-ca.com>
Date:   Fri, 5 Mar 2021 09:30:51 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210305151923.29039-5-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17872 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/5/2021 7:19 AM, Roberto Sassu wrote:
> ima_inode_setxattr() and ima_inode_removexattr() hooks are called befor=
e an
> operation is performed. Thus, ima_reset_appraise_flags() should not be
> called there, as flags might be unnecessarily reset if the operation is=

> denied.
>
> This patch introduces the post hooks ima_inode_post_setxattr() and
> ima_inode_post_removexattr(), and adds the call to
> ima_reset_appraise_flags() in the new functions.

I don't see anything wrong with this patch in light of the way
IMA and EVM have been treated to date.

However ...

The special casing of IMA and EVM in security.c is getting out of
hand, and appears to be unnecessary. By my count there are 9 IMA
hooks and 5 EVM hooks that have been hard coded. Adding this IMA
hook makes 10. It would be really easy to register IMA and EVM as
security modules. That would remove the dependency they currently
have on security sub-system approval for changes like this one.
I know there has been resistance to "IMA as an LSM" in the past,
but it's pretty hard to see how it wouldn't be a win.

Short of that ...

Many of the places where IMA is invoked immediately invoke EVM
as well. Instead of:

	ima_do_stuff(x, y, z);
	evm_do_stuff(x, y, z);

how about

	integrity_do_stuff(x, y, z);


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

