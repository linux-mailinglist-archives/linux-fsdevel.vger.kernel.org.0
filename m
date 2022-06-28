Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD23A55CA76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344091AbiF1JOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 05:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344088AbiF1JOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:14:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B681012753;
        Tue, 28 Jun 2022 02:14:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 76EE81FD97;
        Tue, 28 Jun 2022 09:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656407678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I+0O8HnYFQ+0srMj3qEXXKoZe+51/MPXdOD8Y/ZAXzU=;
        b=WNKMxbzz2eUjURm2p5JyXi/651ojJ6A5qoWjC5HoFCK8WEyeyyux/SKEdl2sbjC+2ofl7E
        zZCuajw+6zlCWCzbNcI9AQsNfvQMqoc60oCzOLyzmtEDTxbDVkcxSWBGS8JWe7eKrgBJtD
        X/syFm2Taxx7d/XheRvlYltzUQU7ejg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656407678;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I+0O8HnYFQ+0srMj3qEXXKoZe+51/MPXdOD8Y/ZAXzU=;
        b=Tj/RyJX/Wz7KkXEs13eSlksPVc693uTXzL7SOLbiFbgdCLeVRWhU0bvm8DmUybz5cjNtAM
        fh6HZYnhQNPN5JDQ==
Received: from quack3.suse.cz (dhcp194.suse.cz [10.100.51.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 56B082C141;
        Tue, 28 Jun 2022 09:14:38 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3277AA062F; Tue, 28 Jun 2022 11:14:38 +0200 (CEST)
Date:   Tue, 28 Jun 2022 11:14:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Guowei Du <duguoweisz@gmail.com>
Cc:     jack@suse.cz, amir73il@gmail.com, repnop@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        duguowei <duguowei@xiaomi.com>
Subject: Re: [PATCH 5/5] fanotify: add inline modifier
Message-ID: <20220628091438.llx3qvwvjxmb57vu@quack3>
References: <20220628081731.22411-1-duguoweisz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628081731.22411-1-duguoweisz@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 28-06-22 16:17:31, Guowei Du wrote:
> From: duguowei <duguowei@xiaomi.com>
> 
> No functional change.
> This patch only makes a little change for compiling.
> 
> Signed-off-by: duguowei <duguowei@xiaomi.com>

Thanks for the patch but I'm sorry I don't see a benefit of these changes.
For static functions 'inline' is not really useful because the compiler
decides about inlining of static functions on its own.

Also the change to fanotify_fh_equal() makes the code less readable, not
more...

								Honza

> ---
>  fs/notify/fanotify/fanotify.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 4f897e109547..a32752350e0e 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -18,12 +18,12 @@
>  
>  #include "fanotify.h"
>  
> -static bool fanotify_path_equal(struct path *p1, struct path *p2)
> +static inline bool fanotify_path_equal(struct path *p1, struct path *p2)
>  {
>  	return p1->mnt == p2->mnt && p1->dentry == p2->dentry;
>  }
>  
> -static unsigned int fanotify_hash_path(const struct path *path)
> +static inline unsigned int fanotify_hash_path(const struct path *path)
>  {
>  	return hash_ptr(path->dentry, FANOTIFY_EVENT_HASH_BITS) ^
>  		hash_ptr(path->mnt, FANOTIFY_EVENT_HASH_BITS);
> @@ -35,20 +35,18 @@ static inline bool fanotify_fsid_equal(__kernel_fsid_t *fsid1,
>  	return fsid1->val[0] == fsid2->val[0] && fsid1->val[1] == fsid2->val[1];
>  }
>  
> -static unsigned int fanotify_hash_fsid(__kernel_fsid_t *fsid)
> +static inline unsigned int fanotify_hash_fsid(__kernel_fsid_t *fsid)
>  {
>  	return hash_32(fsid->val[0], FANOTIFY_EVENT_HASH_BITS) ^
>  		hash_32(fsid->val[1], FANOTIFY_EVENT_HASH_BITS);
>  }
>  
> -static bool fanotify_fh_equal(struct fanotify_fh *fh1,
> +static inline bool fanotify_fh_equal(struct fanotify_fh *fh1,
>  			      struct fanotify_fh *fh2)
>  {
> -	if (fh1->type != fh2->type || fh1->len != fh2->len)
> -		return false;
> -
> -	return !fh1->len ||
> -		!memcmp(fanotify_fh_buf(fh1), fanotify_fh_buf(fh2), fh1->len);
> +	return fh1->type == fh2->type && fh1->len == fh2->len &&
> +		(!fh1->len ||
> +		 !memcmp(fanotify_fh_buf(fh1), fanotify_fh_buf(fh2), fh1->len));
>  }
>  
>  static unsigned int fanotify_hash_fh(struct fanotify_fh *fh)
> -- 
> 2.36.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
