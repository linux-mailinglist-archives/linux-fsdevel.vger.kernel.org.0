Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA017AEB39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 13:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjIZLQk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 07:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIZLQj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:16:39 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34090E9;
        Tue, 26 Sep 2023 04:16:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rvxgx3Gbvz9xHvZ;
        Tue, 26 Sep 2023 19:03:57 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwB3z5BmvRJl0dQRAQ--.20692S2;
        Tue, 26 Sep 2023 12:16:03 +0100 (CET)
Message-ID: <41711c1e42c1a248a0143b8aa9cefcc1004900a9.camel@huaweicloud.com>
Subject: Re: [PATCH v3 20/25] security: Introduce key_post_create_or_update
 hook
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 26 Sep 2023 13:15:48 +0200
In-Reply-To: <20230904134049.1802006-1-roberto.sassu@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
         <20230904134049.1802006-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwB3z5BmvRJl0dQRAQ--.20692S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4fXFyUCr4DZF48Kw48JFb_yoWrtr4kpa
        yjk3WrK3yftFyaqrZ3AF12gayFy3y8K347G39xWr1UJFnavw1xur42kr4DurW3XryrGry0
        qw42vFW3Gr1q9rJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcV
        CF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrfOzDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBF1jj5BT2AAAsg
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-09-04 at 15:40 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the key_post_create_or_update hook.
> 
> It is useful for IMA to measure the key content after creation or update,
> so that remote verifiers are aware of the operation.
> 
> LSMs can benefit from this hook to make their decision on the new or
> successfully updated key content. The new hook cannot return an error and
> cannot cause the operation to be reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/lsm_hook_defs.h |  3 +++
>  include/linux/security.h      | 11 +++++++++++
>  security/keys/key.c           |  7 ++++++-

Hi David, Jarkko

could you please review and ack this patch?

Thanks a lot!

Roberto

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
> index 554f4925323d..957e53ba904f 100644
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

