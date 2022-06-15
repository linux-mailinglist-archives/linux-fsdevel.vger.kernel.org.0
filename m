Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C95554D222
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 21:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350424AbiFOT4g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 15:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244636AbiFOT4d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C78382F027
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 12:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655322991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xqOAqAfVo6ZqE+Onf7A4WZQ8MUXyjM3cOFODgGTtWdE=;
        b=JAT4zLSD19PMK97tKB4cd2Vkyl8L42N4alKWIPN868OKsKEKv89EGtBtvmgJXJvnJMnkRS
        5SSzEG6cNk6vvGehe4Th8XUMTzBNf/yWqwRDXnphiH/R2BBLi6A0S8cBUCTpF84MIwNxei
        m7iOIOR11mwSLphjaW3hlPlmPB+e9gU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-BT-X8-u-OGydkdp13PjrIg-1; Wed, 15 Jun 2022 15:56:26 -0400
X-MC-Unique: BT-X8-u-OGydkdp13PjrIg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FB8A29AB3F3;
        Wed, 15 Jun 2022 19:56:26 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.19.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06ADE492CA5;
        Wed, 15 Jun 2022 19:56:25 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 74D942209F9; Wed, 15 Jun 2022 15:56:25 -0400 (EDT)
Date:   Wed, 15 Jun 2022 15:56:25 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     miklos@szeredi.hu, stefanha@redhat.com,
        zhangjiachen.jaycee@bytedance.com, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 1/2] fuse: Remove unused "no_control" related code
Message-ID: <Yqo5aaKITxivWsdV@redhat.com>
References: <20220615055755.197-1-xieyongji@bytedance.com>
 <20220615055755.197-2-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615055755.197-2-xieyongji@bytedance.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 15, 2022 at 01:57:54PM +0800, Xie Yongji wrote:
> This gets rid of "no_control" related code since
> nobody uses it.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Good to get rid of this knob. Nobody is using it.

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
>  fs/fuse/fuse_i.h    | 4 ----
>  fs/fuse/inode.c     | 1 -
>  fs/fuse/virtio_fs.c | 1 -
>  3 files changed, 6 deletions(-)
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 488b460e046f..a47f14d0ee3f 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -507,7 +507,6 @@ struct fuse_fs_context {
>  	bool default_permissions:1;
>  	bool allow_other:1;
>  	bool destroy:1;
> -	bool no_control:1;
>  	bool no_force_umount:1;
>  	bool legacy_opts_show:1;
>  	enum fuse_dax_mode dax_mode;
> @@ -766,9 +765,6 @@ struct fuse_conn {
>  	/* Delete dentries that have gone stale */
>  	unsigned int delete_stale:1;
>  
> -	/** Do not create entry in fusectl fs */
> -	unsigned int no_control:1;
> -
>  	/** Do not allow MNT_FORCE umount */
>  	unsigned int no_force_umount:1;
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 8c0665c5dff8..4059c6898e08 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1564,7 +1564,6 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  	fc->legacy_opts_show = ctx->legacy_opts_show;
>  	fc->max_read = max_t(unsigned int, 4096, ctx->max_read);
>  	fc->destroy = ctx->destroy;
> -	fc->no_control = ctx->no_control;
>  	fc->no_force_umount = ctx->no_force_umount;
>  
>  	err = -ENOMEM;
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 8db53fa67359..24bcf4dbca2a 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1287,7 +1287,6 @@ static inline void virtio_fs_ctx_set_defaults(struct fuse_fs_context *ctx)
>  	ctx->max_read = UINT_MAX;
>  	ctx->blksize = 512;
>  	ctx->destroy = true;
> -	ctx->no_control = true;
>  	ctx->no_force_umount = true;
>  }
>  
> -- 
> 2.20.1
> 

