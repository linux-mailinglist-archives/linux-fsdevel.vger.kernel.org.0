Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB5D78F5A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 00:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbjHaWhd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 18:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236564AbjHaWha (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:37:30 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3E610C6
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 15:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693521441; bh=yLBuUNSNN3iIXdmxIQGe/dMSrV0ctttxFgaEfrdlg1g=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=VgF7Fqk1RqRcJvP676E4H/cgQDEHPD64U2adEX9mIUMdYe6EOqp5urtPB8msYqoglAv0+zWy3Du7BAVBhM8TTQlpwPQfrD6PNfKKlN83rh6/fEo2vbC3IMBe3yxXSofwbyyD7tOUXoR5he1bGqhotjSN75zwtkKoNUziY6likd4tkiMyh4mrgjUC8vuU2vuJs9tTwhNMyYN2NMYDmmTZ/cViFcj/c/WTbweMfOwVISQuLXJIdXjPhfTGlvYgQ/le+Gsl6qsYbYB6BpgHQiSs1n+GdaK7LPeg4UkouUGyMmh/kt0nyS+JX+nXq+HVyq904MSSXPod+x82NzDNmv2zZw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693521441; bh=Pjx8O8oQ2yTAjDse/ukbuVzZy0geh/+F9TIg8OBu9d8=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=TwrW4vbDuUtIiq07VNhLhfrOMHLZ9/isJ+r+d5+CsiXF5JaPu7ek5iP19FHaX3+MOXchtPCLUJccgxmJzE3urCGfS2Ylht5d+wjBv4k2essj6A/S+fK9JljAwc0XRTilgZSUwTs8yUUEKsIvrovl07bJFr1qontR6BsTqwY2QZVnnJmxye+ITLBH+a2/q9LDPaDclvvVi6O6j4qpoSJ/fz8lB+ycKhPbl1qDeq3PKb/ZrUvE239QrWSQnSPW/tUBbg/6u5bGJRNl9X6uaiIzE/buILezCJZzin3wcL1WE3EPdyGcHqD09sQYkJzjxJYsq9Vi+eGFtm1av9GmepMSYQ==
X-YMail-OSG: H_XElv0VM1nU21Q8GuS.tfhK7l0A8vo65P.di3JFAl9ao3KcB2E0dLUMFBD2Dmj
 VuTOJFh_BTz0BMitDZvhGE_Gg.ix9scFFohTqA81xDpjKiSqGlptRNaRMmWLmgFS5AtaTcT6YBXp
 KnDJGF2gWWR0nLDuZ5gR0tWz_9uwGyvqx5UTqzluZ_dlN2bPa2zhy6c1bwjHOEkGYEQ.hNlW0D.g
 GQCLifAVTeJwRtDJE4_AMFxSLm3a0HHbWocolaqTdy7puoM6yOW53SQf2ZqIcsaBLEp1f85PGhlx
 WnUVcgD9V5LgMM5DegAVo2fxSXMueGWKtS1QzFlOWSYXxDpSQ.X2OEG3u_mMIIRUrx0GBmdB25YY
 _XYjrGmLTRSlKlbRlmep71Wg6kW42PrBpBYHY9KD0eLRfpnYPlTY0pfvJiRHAfQPlmrXW7rdyG8s
 4P0_arMXhbsD0QnN7iCX3tkdjeNbVTtkiMlezlvKE7JI55_Qw8CQp4rzBmLBKhP0mCIUBkxuFCeP
 78K55B8Ay30ZjCISdwfR_QVdoc3HOwo80lpPihl48fu7tFcDkLoUPGCkbjuzZpbOhYl8qZOJsbA2
 Ovc5E2feWOo3vtjGicRRZ236KsxZcKezVRCx8sMV.RsFmRSD8V49GehBvgu3M303IJBOjGikaTzU
 Apfil91UUpggaHUqDjsvITkM0HfsDiEhx98uGgy8mIU_Y9nLB9s4BLG8y75v7ThJtef.m7M3RcXY
 nl5K7J5jc8bdyWMMaUAJO2h6Ph16nYyTQi2Dq2bhAt1ZNIiuluYEzBbYdXCJClH8DKil4yuLOWme
 DPdiQlEeEvkadQAMCw72PEfDVLrv_vvQrnXjYlm.lPstAr0VJ1u_yRtBfuGskOR90t4kHz5Aar3t
 Awhg6qkxbKJ7DrPbGxaqvbh_Bc1V4FfpSzgLCrXL3VSsmG_LPhQvKkCsg.kixg4oocVH2.SpHXEr
 ICd6lO5NHH8Smg63KyRyRK6O6kFX_dxDRLoJksgDhWZZGtEEXGxE7JQe8RF0tq7hVFMuDhkeSD.T
 y7ORtqGLn4h8eEFKzFO7tpo7zn0zziJPLhT7VbBk5i5RGvhaPtTd6b8ZtPOu71Wb4Hnd_LnX8oTu
 CbcoRwXEQkPpdVa7_lcffFAEloBSXPAgVbFD7z7cBT.G_qq91pvoA5vCUEPXjCeTBBpbqSXpjC2J
 BPffqttp0LozRf6YA_QmllmZtVkByjhifsADxDuCU9lvui5Vvy2ROZ.98CIvVW50PHvbl9yF1W2W
 Vxpm9QUrpB30oc1OgF5s9Bt6JiZG4NS89hWrFBxvgdBpxvfaoGJoiTpodVdHMOTBpL0SCVQGcfLj
 EsdiCpYQNDWYDPSkGoYH0VwJtjn6Sbwv9SIbuF6dcwjKyCtJi.Y2UjKtd1WfOT3BjYxJYhQiAKnP
 rrrEMRBCWVK6bKpr3fCUwGrgMvsthUhsW2XEtEjJID4ZvCNWEvFvahupclcIMV97_NLxhbVPfyK3
 hFuc5bslZIjIRQgD.uEu9Gm0T1x1Ir0tlcZ6hatxWIKh9ll76YU6jIlZayU48jieOaY_IwmPFI9C
 uuQaDG.9yFYmQndKLl6d8Sp.bcBKqsMVkRxwVoZ7LzYHyTH9YFXMEaVUj4cvH0lOXnChYz4jSNKB
 el_C9M.Q6vY1Bb9y4ydyJzbseRbR8vtI92rXDjb9FBrwhV296yDJpQnfBTUPX73zuLNimMheaItw
 0NUKs2w7upzYP.cVlP3.rZl8WsYzm6LJHG5scrnrN4y0F5uUdMIPBmCn5GwbRkhzWqwkrY8fhpLU
 7QIMb4XZiShfZar2bInFYhGdI9ArUSBrDPB4_hbx2D63eiuKjI6sy.Ggq5pnWFQ.mBP78gv8w.5l
 CS7fsFfDgaVvdeX9bt54egE.yy3sfP71HBRnbEOSN74tIRnebVwgkZSqhgB9CPhLZ.BeXSZluM4S
 LyqwOeWgD7oF0z95jcnljLCee1EzlR.uujROC3e.iYMWKTfLX5OEFj2Bf8hWNumJ_bhcT1wCbsuH
 qluSou_y.7C9aL9jWJjtvZHZZ8VMnEtnYV0d.oVCkMvvFCRWDCZdT8CNgKZKPb70TW5Mv2QwMM7p
 uGtVGnEa60cMdwG_a1Varr1obQvHGzt3UGd7srZMK28RAhWaljefnzaTBa3jpuho3hrOBeh4WekF
 VJ.IfzIVGz7R2EJ8U7S25CoT3z075g1dig09y.A6kxOsja93AvZ9xkpomxYGA7KwaY7O9QFq5drO
 8YsbuRkal8jilfD.h4rfgonkhI_7ORs2PjU.g8jb0pA1FDCplpaEhnu62sXgG_AzfZ9GqDWbtw_x
 D
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 71c754a4-7434-4ec6-9cd6-6a979eda7b96
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 31 Aug 2023 22:37:21 +0000
Received: by hermes--production-bf1-865889d799-k5x9p (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0f3f6b3064bf8a8682bceefdbe087988;
          Thu, 31 Aug 2023 22:37:18 +0000 (UTC)
Message-ID: <df5b755f-7664-ebed-2082-c0e75cf1482e@schaufler-ca.com>
Date:   Thu, 31 Aug 2023 15:37:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 20/25] security: Introduce key_post_create_or_update
 hook
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
 <20230831113803.910630-1-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230831113803.910630-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21763 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/31/2023 4:37 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the key_post_create_or_update hook.

Repeat of new LSM hook general comment:
Would you please include some explanation of how an LSM would use this hook?
You might start with a description of how it is used in IMA/EVM, and why that
could be generally useful.


>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  include/linux/lsm_hook_defs.h |  3 +++
>  include/linux/security.h      | 11 +++++++++++
>  security/keys/key.c           |  7 ++++++-
>  security/security.c           | 19 +++++++++++++++++++
>  4 files changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index eedc26790a07..7512b4c46aa8 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -399,6 +399,9 @@ LSM_HOOK(void, LSM_RET_VOID, key_free, struct key *key)
>  LSM_HOOK(int, 0, key_permission, key_ref_t key_ref, const struct cred *cred,
>  	 enum key_need_perm need_perm)
>  LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **buffer)
> +LSM_HOOK(void, LSM_RET_VOID, key_post_create_or_update, struct key *keyring,
> +	 struct key *key, const void *payload, size_t payload_len,
> +	 unsigned long flags, bool create)
>  #endif /* CONFIG_KEYS */
>  
>  #ifdef CONFIG_AUDIT
> diff --git a/include/linux/security.h b/include/linux/security.h
> index e543ae80309b..f50b78481753 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1959,6 +1959,9 @@ void security_key_free(struct key *key);
>  int security_key_permission(key_ref_t key_ref, const struct cred *cred,
>  			    enum key_need_perm need_perm);
>  int security_key_getsecurity(struct key *key, char **_buffer);
> +void security_key_post_create_or_update(struct key *keyring, struct key *key,
> +					const void *payload, size_t payload_len,
> +					unsigned long flags, bool create);
>  
>  #else
>  
> @@ -1986,6 +1989,14 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
>  	return 0;
>  }
>  
> +static inline void security_key_post_create_or_update(struct key *keyring,
> +						      struct key *key,
> +						      const void *payload,
> +						      size_t payload_len,
> +						      unsigned long flags,
> +						      bool create)
> +{ }
> +
>  #endif
>  #endif /* CONFIG_KEYS */
>  
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 5c0c7df833f8..0f9c6faf3491 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -934,6 +934,8 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
>  		goto error_link_end;
>  	}
>  
> +	security_key_post_create_or_update(keyring, key, payload, plen, flags,
> +					   true);
>  	ima_post_key_create_or_update(keyring, key, payload, plen,
>  				      flags, true);
>  
> @@ -967,10 +969,13 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
>  
>  	key_ref = __key_update(key_ref, &prep);
>  
> -	if (!IS_ERR(key_ref))
> +	if (!IS_ERR(key_ref)) {
> +		security_key_post_create_or_update(keyring, key, payload, plen,
> +						   flags, false);
>  		ima_post_key_create_or_update(keyring, key,
>  					      payload, plen,
>  					      flags, false);
> +	}
>  
>  	goto error_free_prep;
>  }
> diff --git a/security/security.c b/security/security.c
> index 32c3dc34432e..e6783c2f0c65 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5169,6 +5169,25 @@ int security_key_getsecurity(struct key *key, char **buffer)
>  	*buffer = NULL;
>  	return call_int_hook(key_getsecurity, 0, key, buffer);
>  }
> +
> +/**
> + * security_key_post_create_or_update() - Notification of key create or update
> + * @keyring: keyring to which the key is linked to
> + * @key: created or updated key
> + * @payload: data used to instantiate or update the key
> + * @payload_len: length of payload
> + * @flags: key flags
> + * @create: flag indicating whether the key was created or updated
> + *
> + * Notify the caller of a key creation or update.
> + */
> +void security_key_post_create_or_update(struct key *keyring, struct key *key,
> +					const void *payload, size_t payload_len,
> +					unsigned long flags, bool create)
> +{
> +	call_void_hook(key_post_create_or_update, keyring, key, payload,
> +		       payload_len, flags, create);
> +}
>  #endif	/* CONFIG_KEYS */
>  
>  #ifdef CONFIG_AUDIT
