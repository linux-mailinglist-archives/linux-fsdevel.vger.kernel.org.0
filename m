Return-Path: <linux-fsdevel+bounces-2292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3AE7E4777
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027E5281241
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3628B34CDB;
	Tue,  7 Nov 2023 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Qjdg3WuH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B6D31584
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 17:47:25 +0000 (UTC)
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9917DD43
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 09:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699379244; bh=38RfSpPHsNTdkGAJZ1Cpe3eRvw1Uu1WMAb9d+ryxzFI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Qjdg3WuHNP4790kkeN66Nha6ibeLxdjPYB+xdZ+3YFV+0hIxzbZaVCXv+NCH1o0+S8ekhkFDdwjeM3oipxuPhJXi8WYtQTqdbcnt6pD+KWW6Ge5emLGns7+y2UAbdKsTRDH4wzxrXEy8/wtIB2u4ptzDBVxlZtwD9Y19HXtgFXVfwVdA3NyXtilJeXVfD5TjSkdRZ0SZ7d08RnLtU3qVmclicC1pfsd+T1lcZFBpIfi1VYnqagoBPZxKQDTaZkbYA3HEFktOHbksYy62Bx+B6U7/OVoky0vvfYlW6pDjkN02pZRtt1qPYRUaIsY+81egKIbAocE/DnnfZ3ynoxZO4A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699379244; bh=A36urbN7+ml2fIfPSunkiEEopRcWqP2695GNmlQ/FJ3=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Axq8d0BSrnFiRTX8V8LBMNmVJKHbDpu7yPtdp1pO9eXJJ1W63dlf8jqKez2AOOwXA9xwfZqWhzPXzvxYVNWyN5KSsmD0rcAHMs3Y1Z1p4y3X2q2+4VFhrq0D+YRha1NXkDYXxzOFbR6b+RvnahSdzeKZotPSUL+ctasORDRLEzVA1H0/sGfg3sgUPB6iQAqpzxq3FCuzivg0AW3rMM7M9E7GFNVLqvBzl/tqWR8O8TvQNXDYXznhSuN8e8guVA8rKkyBH6q5Z/C58XoMj4eqB3fw0VqamNqYsNKXwrrEia6y9/5MPO9cHsbrqUoRiEjsjBenpKUrouNtl2nLdf1xzg==
X-YMail-OSG: tdq7hlQVM1nowFRoqEGdYpI8CfTEE1V.S0WsleKnI6h8rWXgFLVh7JOyxpUQ70D
 X1TUr3.Dg3io0vtPMtwidF4ohmDhpq.gilEHRrzQCMuaHoFACSwX3xuHt1mLdqbCZ_H2tv4Zk.aq
 7iQhIoS5Me7jjNt9xo9xGCJVhZu5bggePbfX0pgyyBeMu3p1ulONeE8JjR_Eg2mipcC4cyi2noCu
 qJ2WBjueS046aRTgkhpbakV_g1MeUigLEGJvPM8gCVOcXc8OJH1JP5gJtySzrwftOkyBqAVXMtO6
 m1nElJT5IJ7qWGa28oKByuhO0ftXJdaSla8yuALzJisP1iCpoScLN2miM.7MTFIwxwgRRtHA7qgO
 9l9oRT6QQ5hJagmia6DVx__JOG0086Um5Sc6x4jOrCrD7iiSuDFwNnd2AEW1SWeI5.mVY7e7vwJh
 qBA5ypIbO8QVdC1WxI3CWWyuUzJk3Hx8fU3XdsllqPRaVCsOzU_y5iQUrkI5rDihDXGakqOCizjP
 j5Pyafbk0iGKQsDrOpT07qkYPvhEHx1LIDPLF17LiC.QfmhZwIzvnRpC1k56LoNf6RlVJe118ynt
 vyPB_LNaz2JMHp2P3v6t5FSztWZx0FgzNwS7q1qJtmAwumaZegBwGXLOEkIxZm9OOiHUjqm6j7SS
 x5wF5s7dVbq3QfZf6eIroWJ2MTVZc12L_6edbuBDq4C8G8I9RxQ2bJlCSXnnT5ZMpOjFGPz_kgAL
 Z6gKbjRJvEVN.uz8GH_Qrbz6j5bMS4hj0utyZW721G9aFTyNfHVi3aUOarZNJtMhBhpWgJeYw2Tf
 LN3kq.GTr__bv8DT3Mu.MNpkxN1X5UwliVh3g1Jfvd4uqCu2yyDXiUWgaBAZEaVLIrsXBlLGVHwy
 4K8W7Yk6HrWPbWsPcDdQ5G53BBQVdr._gC3hBlUCul2I_ZFdXeReXM_mPwXl25ApT4u.ruoSU0AQ
 69OIY8hmhEa5Ct5MJsMdZqHUUYdv6kVeitLxZ_v9lbx7ZbBfTLOSVt0mNxB21uHcUsUGvGXRcKct
 CqAVOlu5JpFk1CfcBUzdbvl8W22YSeDi_tEAqUcdbufg2tV1RKTPfyO1Q8fOojQZeBL9i8qODW1X
 1lh50_BXc3lvV893qa8MWvDPZP9Wi0ZruQXYd.6w8PeJ0bEVeUFwmQv.ijUH.lvO4Gimyf6ud9pB
 V2rtas7qOel.jxHSjydxBAdFfayw1APtgrcPVQFoDXtG.DMyPWmL48kOhF1yJJ4jvNf_tRTQXR6u
 G52_NPoIt8orPdi3x5w2yPgq_747sYgb.atEISGrg2uaDIX.0rETX_cE5.fHqPYZvVW8ciaKO7wo
 bNIMbP2UxXf6rJC926Y09KKtg8O766phO8Lx1S.vgjMM8CwJzLGDXX24KthJxYtBijBuPdDi2.V4
 Rwt05FMo5eiesrt8..xryhDdSyJHlLlaIMC9e0a020Bv0HcEDPkO3S2y7oAToWrrIT0XWV_buy_Z
 lNoakfWRdlaec1N1LQ7kA_lIEdOjT0CJOdkowEnrlQLCbbUZRO6cklyKsc7IDCS3oEgBf6NR.d0L
 CZxPItzHP2wIKw76loeUkE3eMSmY7YMN7pyZSXc1cOwEYenWalqyG_Jby_RVGVaiutowxvdRYsCI
 7KMrVGXvP313dz2b9ns7R.pOxCoPbYVEpBKeJMCUa0Rc3MMHwyTdJ.HzyhkZ1ssB.pOGsNxTW2ae
 EbQrVWAsCDBnz3bpMyTAmBic2DtDoCP4_3H77sGLsg7xaClxvMf5.G2mW.lnaripAundNTiTxD28
 9zZeElU5vZU1zKNvrAYSbd5GzBc9ifwhL0qPnDM5R7VqS03QDUNtfu4vqA1imY.tPar0WlNv_QY7
 7RSSXQ8kG7Jk5xbxGtrX467ZI8PBDs535G2k4OlkfvbSUV2viA.37Fk9AyKvnpSwx6dffvlZlVnF
 8m7JUrWurgl0qpqRPZss1IGmaEOopcgfRBN6YFVOCMXoADJc_xl_5QCfHk__OXkI.hgbsfLo2Ty_
 u1yC0iYYLrtm0N7Pq8pnQnjlZzd98l0qmwjhraRfFYYlF6nITbxeLaU8SkI_b488c8LYj3nf_gvZ
 5XGaTissOuS.vXLL7mCgCvgBpEwfzw7ktMCNjDWTsZn2IzN2NL6xvWhfpDQiB2tB0aJ3Kw1ahtEX
 oKa3N3sOtYGHHArgE9VqZVjSVqFoNl9vrVyIOoyFcbo6S55tTYgVzXI3QKDZOkXeBGbRmpcod7wi
 Cz1RAtLMVINxTiN22jla0IpIgaY00uv.RRsIWCV7wiiv4aU4wbnk0_2ZLf8S7bwM8XsnoF831JyJ
 Sd4l_
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fcf060aa-773d-4602-aaf2-19925cb0ef88
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Nov 2023 17:47:24 +0000
Received: by hermes--production-ne1-56df75844-jh4w4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5935d0c12330d2dd3580b3918d117964;
          Tue, 07 Nov 2023 17:47:23 +0000 (UTC)
Message-ID: <d32add2c-26ed-4988-990b-3014d7727645@schaufler-ca.com>
Date: Tue, 7 Nov 2023 09:47:22 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/23] security: Introduce key_post_create_or_update
 hook
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
 <20231107134012.682009-19-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231107134012.682009-19-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/2023 5:40 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the key_post_create_or_update hook.
>
> Depending on policy, IMA measures the key content after creation or update,
> so that remote verifiers are aware of the operation.
>
> Other LSMs could similarly take some action after successful key creation
> or update.
>
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/lsm_hook_defs.h |  3 +++
>  include/linux/security.h      | 11 +++++++++++
>  security/keys/key.c           |  7 ++++++-
>  security/security.c           | 19 +++++++++++++++++++
>  4 files changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 2bf128f7cbae..ec5d160c32ba 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -403,6 +403,9 @@ LSM_HOOK(void, LSM_RET_VOID, key_free, struct key *key)
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
> index 7cd7126f6545..1cd84970ab4c 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1995,6 +1995,9 @@ void security_key_free(struct key *key);
>  int security_key_permission(key_ref_t key_ref, const struct cred *cred,
>  			    enum key_need_perm need_perm);
>  int security_key_getsecurity(struct key *key, char **_buffer);
> +void security_key_post_create_or_update(struct key *keyring, struct key *key,
> +					const void *payload, size_t payload_len,
> +					unsigned long flags, bool create);
>  
>  #else
>  
> @@ -2022,6 +2025,14 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
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
> index 0260a1902922..f75fe66c2f03 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -935,6 +935,8 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
>  		goto error_link_end;
>  	}
>  
> +	security_key_post_create_or_update(keyring, key, payload, plen, flags,
> +					   true);
>  	ima_post_key_create_or_update(keyring, key, payload, plen,
>  				      flags, true);
>  
> @@ -968,10 +970,13 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
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
> index 6eb7c9cff1e5..859189722ab8 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5406,6 +5406,25 @@ int security_key_getsecurity(struct key *key, char **buffer)
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

