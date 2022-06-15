Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECEF54D080
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 19:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349551AbiFOR5i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 13:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350133AbiFOR5f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:57:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02E8C544E4
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 10:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655315844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IsV319NZNgDzu9DPo6i72lisoqYXO+k9cCPYQoqn8LA=;
        b=i+pYetlEPMk9wry5TGcEZZ6VzjKFEwX5p2Hbj0QQ4FdRBOA5VcspOiXw48n3zNLhVX3Nww
        Q5TV/0Mv+uAg9fQd8A2X1OwtQ2IX+lWT1rAdC4TEToW6D4zLUyrwCVC+oETRfse90+vi7I
        M3PeCPFnoVJEABatZFlxgaPnhMpHnXs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-c2Q-mJ0zPsyh09IqDQBOCw-1; Wed, 15 Jun 2022 13:57:20 -0400
X-MC-Unique: c2Q-mJ0zPsyh09IqDQBOCw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 511AC800971;
        Wed, 15 Jun 2022 17:57:20 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38C9F18EA9;
        Wed, 15 Jun 2022 17:57:20 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E9F252209F9; Wed, 15 Jun 2022 13:57:19 -0400 (EDT)
Date:   Wed, 15 Jun 2022 13:57:19 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtiofs: delete unused parameter for
 virtio_fs_cleanup_vqs
Message-ID: <YqodfwS3KSVIaqKD@redhat.com>
References: <20220610020838.1543-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610020838.1543-1-wangdeming@inspur.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 09, 2022 at 10:08:38PM -0400, Deming Wang wrote:
> fs parameter not used. So, it needs to be deleted.
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>

Thanks Deming Wang for the patch. Good cleanup.

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

> ---
>  fs/fuse/virtio_fs.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 8db53fa67359..0991199d19c1 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -741,8 +741,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
>  }
>  
>  /* Free virtqueues (device must already be reset) */
> -static void virtio_fs_cleanup_vqs(struct virtio_device *vdev,
> -				  struct virtio_fs *fs)
> +static void virtio_fs_cleanup_vqs(struct virtio_device *vdev)
>  {
>  	vdev->config->del_vqs(vdev);
>  }
> @@ -895,7 +894,7 @@ static int virtio_fs_probe(struct virtio_device *vdev)
>  
>  out_vqs:
>  	virtio_reset_device(vdev);
> -	virtio_fs_cleanup_vqs(vdev, fs);
> +	virtio_fs_cleanup_vqs(vdev);
>  	kfree(fs->vqs);
>  
>  out:
> @@ -927,7 +926,7 @@ static void virtio_fs_remove(struct virtio_device *vdev)
>  	virtio_fs_stop_all_queues(fs);
>  	virtio_fs_drain_all_queues_locked(fs);
>  	virtio_reset_device(vdev);
> -	virtio_fs_cleanup_vqs(vdev, fs);
> +	virtio_fs_cleanup_vqs(vdev);
>  
>  	vdev->priv = NULL;
>  	/* Put device reference on virtio_fs object */
> -- 
> 2.27.0
> 

