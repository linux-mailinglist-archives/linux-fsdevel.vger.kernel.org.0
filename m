Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4EF466943
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 18:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376397AbhLBRmt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 12:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbhLBRmq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:42:46 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF45C06174A
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Dec 2021 09:39:23 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so559691oto.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Dec 2021 09:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=leSK0mXP1Ba2lwQk9OUAwqfeQuLDnxR2QNNDFulbrHk=;
        b=KuWCtxzigeT52bWodLB/YvRCSFTUXXw0lq3Q+oH6TvSsc7RXf4D++fffK85OheTNAD
         xMlwgGGgpdmwtP2KVz9ILrrsanfSEbBAHtnbQNpR1ioaqdzaaBEHZY+yei/XkDXeva5F
         Y0/RuDSPd3J8Kekj3u0oiR+g001rXhgkReCvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=leSK0mXP1Ba2lwQk9OUAwqfeQuLDnxR2QNNDFulbrHk=;
        b=qX7Ht6OCQL5n0PHEVdPRNDz/Uz+laYWaiIlv2uTPGL7kuWWrPJAxnnRBMk0Tn7hChx
         6dCUQyj6kCaaNv/qLN9KdPQxi9An6rKG58XzyMnrQ0F0b7ZalfHZErUoVPnLK8NX11rF
         T74Ed4cM8YOvkH0iJXTMOJOXRRbTd3zVD2Dq9+4KB+Ad1HjKJAQ+WPmEOrhiN5L4wsEx
         JpRw2PERgcLXOOaUfT6flLw5a97gIzU+6+YipUnOF927ZNPObbv29XiMVzSV9gN78Ktp
         CFZ9pblM+w0rsAfI+mWm8yxpqDN2np9EkW2DvpeSqS4tHcASYry/yngsOh4hhbSsQBg5
         pn1g==
X-Gm-Message-State: AOAM532iEKBpQdlt2UnV8P47GeTOcusaJFUjcVjwA7fNKLGF4YZHOwn5
        SFn8DFR5CTz3XE05L8nwBxeVqg==
X-Google-Smtp-Source: ABdhPJzSKarXK+w7W1/8ufNH/e6iggP4G5QPKfKx4vsBwQiEEKvHlCfJS2IFwrTkIjNKU+nPulheKg==
X-Received: by 2002:a05:6830:410a:: with SMTP id w10mr12394482ott.55.1638466762818;
        Thu, 02 Dec 2021 09:39:22 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:49aa:e3a:9f96:cf34])
        by smtp.gmail.com with ESMTPSA id h14sm152653ots.22.2021.12.02.09.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 09:39:22 -0800 (PST)
Date:   Thu, 2 Dec 2021 11:39:21 -0600
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 07/10] fs: remove unused low-level mapping helpers
Message-ID: <YakEyVltw2CHxzLT@do-x1extreme>
References: <20211130121032.3753852-1-brauner@kernel.org>
 <20211130121032.3753852-8-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130121032.3753852-8-brauner@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 30, 2021 at 01:10:29PM +0100, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Now that we ported all places to use the new low-level mapping helpers
> that are able to support filesystems mounted with an idmapping we can
> remove the old low-level mapping helpers. With the removal of these old
> helpers we also conclude the renaming of the mapping helpers we started
> in [1].
> 
> [1]: commit a65e58e791a1 ("fs: document and rename fsid helpers")
> 
> Link: https://lore.kernel.org/r/20211123114227.3124056-8-brauner@kernel.org (v1)
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> CC: linux-fsdevel@vger.kernel.org
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Seth Forshee <sforshee@digitalocean.com>

> ---
> /* v2 */
> unchanged
> ---
>  include/linux/mnt_idmapping.h | 56 -----------------------------------
>  1 file changed, 56 deletions(-)
> 
> diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
> index 1c75d4e0b123..c4b604a0c256 100644
> --- a/include/linux/mnt_idmapping.h
> +++ b/include/linux/mnt_idmapping.h
> @@ -13,62 +13,6 @@ struct user_namespace;
>   */
>  extern struct user_namespace init_user_ns;
>  
> -/**
> - * kuid_into_mnt - map a kuid down into a mnt_userns
> - * @mnt_userns: user namespace of the relevant mount
> - * @kuid: kuid to be mapped
> - *
> - * Return: @kuid mapped according to @mnt_userns.
> - * If @kuid has no mapping INVALID_UID is returned.
> - */
> -static inline kuid_t kuid_into_mnt(struct user_namespace *mnt_userns,
> -				   kuid_t kuid)
> -{
> -	return make_kuid(mnt_userns, __kuid_val(kuid));
> -}
> -
> -/**
> - * kgid_into_mnt - map a kgid down into a mnt_userns
> - * @mnt_userns: user namespace of the relevant mount
> - * @kgid: kgid to be mapped
> - *
> - * Return: @kgid mapped according to @mnt_userns.
> - * If @kgid has no mapping INVALID_GID is returned.
> - */
> -static inline kgid_t kgid_into_mnt(struct user_namespace *mnt_userns,
> -				   kgid_t kgid)
> -{
> -	return make_kgid(mnt_userns, __kgid_val(kgid));
> -}
> -
> -/**
> - * kuid_from_mnt - map a kuid up into a mnt_userns
> - * @mnt_userns: user namespace of the relevant mount
> - * @kuid: kuid to be mapped
> - *
> - * Return: @kuid mapped up according to @mnt_userns.
> - * If @kuid has no mapping INVALID_UID is returned.
> - */
> -static inline kuid_t kuid_from_mnt(struct user_namespace *mnt_userns,
> -				   kuid_t kuid)
> -{
> -	return KUIDT_INIT(from_kuid(mnt_userns, kuid));
> -}
> -
> -/**
> - * kgid_from_mnt - map a kgid up into a mnt_userns
> - * @mnt_userns: user namespace of the relevant mount
> - * @kgid: kgid to be mapped
> - *
> - * Return: @kgid mapped up according to @mnt_userns.
> - * If @kgid has no mapping INVALID_GID is returned.
> - */
> -static inline kgid_t kgid_from_mnt(struct user_namespace *mnt_userns,
> -				   kgid_t kgid)
> -{
> -	return KGIDT_INIT(from_kgid(mnt_userns, kgid));
> -}
> -
>  /**
>   * initial_mapping - check whether this is the initial mapping
>   * @ns: idmapping to check
> -- 
> 2.30.2
> 
