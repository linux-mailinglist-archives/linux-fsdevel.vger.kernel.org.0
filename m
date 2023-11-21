Return-Path: <linux-fsdevel+bounces-3272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8561C7F2286
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 01:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077AB1F25F02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 00:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF1D1842;
	Tue, 21 Nov 2023 00:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gE696MN7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA2DCA
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 16:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1700527863; bh=X6NNrh2o9TkByhBWiubp9qwlQAP2OzbbUw3CuaiiYt4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=gE696MN7CmATorwHr2JjXJaoQNL40hRgJ+cYESBnbzVDtVPmqT3VJc9V2qrJlzMI4lp7zBAPQ5PBVe/UAYPz4HqXD6khLzSwEwLx5eMXMNBUpIGJoWKiznMiTzu7C+UZIgI0CEOqp3HQOhXMnydGk5GmjBfNK+XyGvSUIsNQfOWYdO28Je6bttyedLshlF+6o3qfh8IflG+l6elX5or3Mue5rqMWugAKQBA0RyBtL6St/tV0XTgzEjcy2FRzWhHbD+AAgpkEjiRMo0FR5eFZCYxa7Ve71L+uwLRV31RWgutMHcVWg87MmzfOwrX6Rq+PfsLntxI5RNtF6lu3TxX7gA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1700527863; bh=kmDhWoqSbEAqPNzl2xg7xH/nF3Vp1fYXhkvFIclEdTW=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=gKB5VX19b9sjmgbIYKG13TCGWgcBtI/3SjHk4aGtPuetlKBKyT0qrhsUTA/daOmb5UpBtYklivT6DyKd78c7Ndgdp9S8wu7vLN+poEOcw1gZ4vV9JmyVV0gQf7w/Npi0MLLoU4UrQ7MBnRIPyyHGOIpmGbZ7jPZhdkP3RZldcBGU/p5YpkI+BVdGZZ1K3hPz272zNp/d7+4i6n41pb+7UaqHGJt2zkZE1jbv+++Lcq2mFn51phJ5S2fbrczTWHfaMSq2FHfWCGZRfXdMINfzdu4GeTggcEu3PkAvZNbOsY999JmUwI0UfepDQkI4jkCSONSK+ZrwwgjDkvzFnbR+wg==
X-YMail-OSG: ylTlCfAVM1mNJDd8QjJ0ZLL.iLXAIZPAxbCtvzHeK8uGpJxFlIS4KnTw4dErzhw
 fqwYAvTC2PxROLx4IPUjI.lG_3ni32g5.kRQXWgD28KXfH0lxU4PNQySgyZywT9RtshfuWR3HFRP
 YWCfqhF2lO22bB4buWxosIa3.RJV18t9EyF3kC3b4R5lZYdgAHwqWDhoKzZ_iyUxV09ZjApUuFMG
 DzNb8mb5_vxaSiyZfJT4.62rHnfMVPjaK82kUNEthikwKQ_lLzGiuoC6p3TXNf6LhVHqlb1tX70A
 GA7gRZxJ08.sjsA79C5PQK2fPRX8vTejKAwkJdAEgwu6chRf03aOAS9LuPtf8WY9kVD9CChGKSyv
 lwCDRt2wK.3BzElbggPPGp8jVBMmEYOGlmTjzP7n9YvVCJtKxB3bjmugxkSmJfNIY5l0w8gyWxxt
 iycZSgqieeQwWd00tLd8m8K0ISiqys_DXcRubnHOVCJT2mPtOfMBl_uI6wwFra9tGPHv9BpW2eZw
 Ja1TghgzisgEx5sCxwM7O990YaaY0IOKWTPWj9y_mgJGCNzCWxoEaMXhwht4oQ.dxbRFkfansHOk
 FMiFv2GzRvzj0rW55PKVKGgrQVUk3tLQnSjNXZ74shCGHmLBg6_58K1B9YkQJKg538__08pC9nBs
 cbMW_k0ZBilAzNjfqcG0mfywGZany6RT8L_R5h99Po4yj4vYTAiGLyeFnej8.J_xECkXaYxkMQgG
 NM.B3jbJxk9UP7ZCwbKmxF.XVj7QSYVfRDQIQmOyaB2GUqKvrj99uM6ztjsyzmj61ngKDKfswbDl
 eoniJYtrGwVubTE_HlyenAiks5V2EQio._WN2YNW89824ceg7nMRXz6MOrAFJ.hA7SH2NdjmdX0B
 PKiOKPrhe7duwWa42yKcwKlVSpuY56jcIQ79R_vvgKYND9FGFnfMsbLJBI_f5rTyL7t3m0B6sY.q
 DtKSbLRM4ZcpOM9CpvmQP9Am3BgYm4kQYXAOY5NZL3P42Is8r1aEQXI7Wi35GuJck5bUo6uYB4Wf
 SsL1_.ZX5BkpciZZCAF.LfpFm.xmDRo9T.Ywmjpl57YQllo201amuihrxGHPvxNcX32uu8Cy2A47
 mR4FaHMNjL8Gf8S0YFXIXa64_fmk4w9IJrMpkVMyW96vffn1s2xTia.uf.XDSxEDEbVCpsO5s8_6
 4c.yejFWarQ8Ga3kdYP_8ksYFuEl2THKuE7GEzQydMlBc4vxtZwIfADIqMcWyIENCj0vPJWV6Frx
 PdaHBsnwzlhjfE12thBW7GT1xUYLq0r3xz0rvyVSQw5fuyjI2jvbErd6sJ8iry2jxpzQ2Q.pgW1I
 fix5Y2CAAHQjUVBvoTDqHl90oj2mHj36sFL6n.mJue1_yDegNZs452ptcwSowzZEygAs2k9xXiP7
 .5ufFmeOzMMo2A54yz3wKMHSMEgS82WSNs6AbAvLu2A_WY23BjZ.0UP_rbEOQqRQDpL7VB3UpAxX
 pwdLS3vLCrjN8cCzG5bT_jgEV3_QJkZtv_bkXnyTzHiMsUskqkeE2XZ6woPjvgfqlg1hWb7ln1p5
 j2GUVmQ_Gx6XlmuwEXLQsf7AMF73_Ok57brHY3Xt6cOdswIAhSus3OmxEEDGnYL7m9Jo2hSerSk4
 Epg5WiRmr0HW8znp70EVs3bSazyo1umQQL0XYKjlZO20oXov4NbzcXu3WANxKd8XKpvJ3kjwIRxN
 tbffOz2PAWhFHfUCLzAP6bEt2p5eRHIyl4AMZiBTpwkSrkH4FXRsh7JYeNa.lUz0is.NEuDCvwGT
 rWEmyTBz.QuX4zfcb3of9K3MqxtFxnFkhRypxRtIVceGZ.90e2EjhKYAB7NKo2NgTwRCU3CtsdWy
 VoxOkCKsQmuRVPB2bA_pR0q.uQ0irqnqVaSglF34Rr9gqt6BRG9yfGuGxYgaWi5IOoA_HczUUju3
 Oic.VSBN6XOTK6i8t64CD4QDJ9NySXsSiigtd7Kup159H_fEpURwt5YWTSr2TlpPaTXm_N4tuKQF
 CSGbhm2b3MltMqC6NH24K1Uq6oQuWo4RUUTv8IQdh0eT2v2SuDHoU2z6xT84PuYN6go.8Iy0Lqso
 Sz6z50fJkrFL2Qr4BiwS.wjMRLegBLOMn0k7alzJ42FNFQLQKFiBnvVD0HYJzu6hxV6eRYV5D60T
 JI6GQcFKuBff9M2of1AmMnF.04IM6QepkjvrV32hzYu_lYhPgey35wRsgGs0qJAGR21OLjpC861w
 e.TyXO5Z1JN5t98T65VHw3ooV.unQIe.7JCc1He.U_MqFzcAoTS94yyvsV2sNMLduwEM-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8d70e5ed-64ab-4e7f-8a95-7b16a6fffe37
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 21 Nov 2023 00:51:03 +0000
Received: by hermes--production-gq1-6775bfb8fc-ljztx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4e636f04e136106655e334c750e19110;
          Tue, 21 Nov 2023 00:50:58 +0000 (UTC)
Message-ID: <24a9f95d-6a28-47d3-a0cf-48e1698e2445@schaufler-ca.com>
Date: Mon, 20 Nov 2023 16:50:56 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 25/25] security: Enforce ordering of 'ima' and 'evm'
 LSMs
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
References: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
 <20231120173318.1132868-26-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231120173318.1132868-26-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/20/2023 9:33 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> The ordering of LSM_ORDER_LAST LSMs depends on how they are placed in the
> .lsm_info.init section of the kernel image.
>
> Without making any assumption on the LSM ordering based on how they are
> compiled, enforce that ordering at LSM infrastructure level.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/security.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/security/security.c b/security/security.c
> index 351a124b771c..b98db79ca500 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -263,6 +263,18 @@ static void __init initialize_lsm(struct lsm_info *lsm)
>  	}
>  }
>  
> +/* Find an LSM with a given name. */
> +static struct lsm_info __init *find_lsm(const char *name)
> +{
> +	struct lsm_info *lsm;
> +
> +	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++)
> +		if (!strcmp(lsm->name, name))
> +			return lsm;
> +
> +	return NULL;
> +}
> +
>  /*
>   * Current index to use while initializing the lsm id list.
>   */
> @@ -333,10 +345,23 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  
>  	/* LSM_ORDER_LAST is always last. */
>  	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		/* Do it later, to enforce the expected ordering. */
> +		if (!strcmp(lsm->name, "ima") || !strcmp(lsm->name, "evm"))
> +			continue;
> +

Hard coding the ordering of LSMs is incredibly ugly and unlikely to scale.
Not to mention perplexing the next time someone creates an LSM that "has to be last".

Why isn't LSM_ORDER_LAST sufficient? If it really isn't, how about adding
and using LSM_ORDER_LAST_I_REALLY_MEAN_IT* ?

Alternatively, a declaration of ordering requirements with regard to other
LSMs in lsm_info. You probably don't care where ima is relative to Yama,
but you need to be after SELinux and before evm. lsm_info could have 
must_precede and must_follow lists. Maybe a must_not_combine list, too,
although I'm hoping to make that unnecessary. 

And you should be using LSM_ID values instead of LSM names.

---
* Naming subject to Paul's sensibilities, of course.

>  		if (lsm->order == LSM_ORDER_LAST)
>  			append_ordered_lsm(lsm, "   last");
>  	}
>  
> +	/* Ensure that the 'ima' and 'evm' LSMs are last and in this order. */
> +	lsm = find_lsm("ima");
> +	if (lsm)
> +		append_ordered_lsm(lsm, "   last");
> +
> +	lsm = find_lsm("evm");
> +	if (lsm)
> +		append_ordered_lsm(lsm, "   last");
> +
>  	/* Disable all LSMs not in the ordered list. */
>  	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
>  		if (exists_ordered_lsm(lsm))

