Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC26B7BF345
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 08:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442241AbjJJGqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 02:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442156AbjJJGqM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:46:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB83A97;
        Mon,  9 Oct 2023 23:46:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7D7641F45E;
        Tue, 10 Oct 2023 06:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696920368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/y8kLlMYlCV5svpo9yVALD4uEnUsY8oZYm1/+BvVA3Q=;
        b=rqG5U9jG9vYBLFqamcNVJxVoEtokWyP4Gjwzx/armsgwiFOgTkZCHPJXvVVa+xUM4R9hqr
        B8ilRIR5dylzWBJgz1Hr51Dx7d1TkaP9GojhpQEfA730DT9JsqzmfCdMgpkpUYOHhe2p8e
        RNfwYctosg22nHnudZiP8L5nee0Ys5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696920368;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/y8kLlMYlCV5svpo9yVALD4uEnUsY8oZYm1/+BvVA3Q=;
        b=Jm55PMk/8f0PObDJ7v9TdL7FBNKQKTbiFh51HR6OLr3uWmV83RHH5XgfOMyTNzxZtb+daY
        ozC0H3tqPC5qSzBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 573591358F;
        Tue, 10 Oct 2023 06:46:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GLCBFDDzJGUOJwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 10 Oct 2023 06:46:08 +0000
Message-ID: <52d4760a-9d4b-e3c0-d236-5eaa0eb5f96a@suse.cz>
Date:   Tue, 10 Oct 2023 08:46:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/5] mm: move vma_policy() and anon_vma_name() decls to
 mm_types.h
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <cover.1696884493.git.lstoakes@gmail.com>
 <4f1063f9c0e05ada89458083476e03434498e81e.1696884493.git.lstoakes@gmail.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <4f1063f9c0e05ada89458083476e03434498e81e.1696884493.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/9/23 22:53, Lorenzo Stoakes wrote:
> The vma_policy() define is a helper specifically for a VMA field so it
> makes sense to host it in the memory management types header.
> 
> The anon_vma_name(), anon_vma_name_alloc() and anon_vma_name_free()
> functions are a little out of place in mm_inline.h as they define external
> functions, and so it makes sense to locate them in mm_types.h.
> 
> The purpose of these relocations is to make it possible to abstract static
> inline wrappers which invoke both of these helpers.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/mempolicy.h |  4 ----
>  include/linux/mm_inline.h | 20 +-------------------
>  include/linux/mm_types.h  | 27 +++++++++++++++++++++++++++
>  3 files changed, 28 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index 3c208d4f0ee9..2801d5b0a4e9 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -89,8 +89,6 @@ static inline struct mempolicy *mpol_dup(struct mempolicy *pol)
>  	return pol;
>  }
>  
> -#define vma_policy(vma) ((vma)->vm_policy)
> -
>  static inline void mpol_get(struct mempolicy *pol)
>  {
>  	if (pol)
> @@ -222,8 +220,6 @@ static inline struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
>  	return NULL;
>  }
>  
> -#define vma_policy(vma) NULL
> -
>  static inline int
>  vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
>  {
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 8148b30a9df1..9ae7def16cb2 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/atomic.h>
>  #include <linux/huge_mm.h>
> +#include <linux/mm_types.h>
>  #include <linux/swap.h>
>  #include <linux/string.h>
>  #include <linux/userfaultfd_k.h>
> @@ -352,15 +353,6 @@ void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
>  }
>  
>  #ifdef CONFIG_ANON_VMA_NAME
> -/*
> - * mmap_lock should be read-locked when calling anon_vma_name(). Caller should
> - * either keep holding the lock while using the returned pointer or it should
> - * raise anon_vma_name refcount before releasing the lock.
> - */
> -extern struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma);
> -extern struct anon_vma_name *anon_vma_name_alloc(const char *name);
> -extern void anon_vma_name_free(struct kref *kref);
> -
>  /* mmap_lock should be read-locked */
>  static inline void anon_vma_name_get(struct anon_vma_name *anon_name)
>  {
> @@ -415,16 +407,6 @@ static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
>  }
>  
>  #else /* CONFIG_ANON_VMA_NAME */
> -static inline struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
> -{
> -	return NULL;
> -}
> -
> -static inline struct anon_vma_name *anon_vma_name_alloc(const char *name)
> -{
> -	return NULL;
> -}
> -
>  static inline void anon_vma_name_get(struct anon_vma_name *anon_name) {}
>  static inline void anon_vma_name_put(struct anon_vma_name *anon_name) {}
>  static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 36c5b43999e6..21eb56145f57 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -546,6 +546,27 @@ struct anon_vma_name {
>  	char name[];
>  };
>  
> +#ifdef CONFIG_ANON_VMA_NAME
> +/*
> + * mmap_lock should be read-locked when calling anon_vma_name(). Caller should
> + * either keep holding the lock while using the returned pointer or it should
> + * raise anon_vma_name refcount before releasing the lock.
> + */
> +struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma);
> +struct anon_vma_name *anon_vma_name_alloc(const char *name);
> +void anon_vma_name_free(struct kref *kref);
> +#else /* CONFIG_ANON_VMA_NAME */
> +static inline struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
> +{
> +	return NULL;
> +}
> +
> +static inline struct anon_vma_name *anon_vma_name_alloc(const char *name)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  struct vma_lock {
>  	struct rw_semaphore lock;
>  };
> @@ -662,6 +683,12 @@ struct vm_area_struct {
>  	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
>  } __randomize_layout;
>  
> +#ifdef CONFIG_NUMA
> +#define vma_policy(vma) ((vma)->vm_policy)
> +#else
> +#define vma_policy(vma) NULL
> +#endif
> +
>  #ifdef CONFIG_SCHED_MM_CID
>  struct mm_cid {
>  	u64 time;

