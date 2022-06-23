Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E5B557AA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 14:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiFWMsU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 08:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiFWMsJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:48:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73AC644A11
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jun 2022 05:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655988486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RrgA3QRhrviuqlVZS1DqYvEOCwDo7gxdsScFtfx3ONI=;
        b=G+ZkZNsQIZZ2FA7WSyB/sdjb/j8ae7u5vZ4gwUwSWutNfngASI/2HCvf8NVPJO167+e/Pk
        ZcMbyezw6EHTGlctz4XmvjAcvTNYWjReMVZG0mU5z4wYTYWMGBBVZKJKHFp5GgVY0nkiTQ
        jYPhwrQnv9G/NHMNvAPdEutpcD391qk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-pmhPhQ4JNM-M5mO90PjKCQ-1; Thu, 23 Jun 2022 08:48:02 -0400
X-MC-Unique: pmhPhQ4JNM-M5mO90PjKCQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D7E5811E76;
        Thu, 23 Jun 2022 12:48:02 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0D19C28115;
        Thu, 23 Jun 2022 12:48:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 5DF042209F9; Thu, 23 Jun 2022 08:48:01 -0400 (EDT)
Date:   Thu, 23 Jun 2022 08:48:01 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_fs: Modify format for virtio_fs_direct_access
Message-ID: <YrRhAZA1Enez0WRA@redhat.com>
References: <20220622211758.4728-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622211758.4728-1-wangdeming@inspur.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 22, 2022 at 05:17:58PM -0400, Deming Wang wrote:
> We should isolate operators with spaces.
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>

Looks good to me.

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
>  fs/fuse/virtio_fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 8db53fa67359..e962c29967eb 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -757,7 +757,7 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
>  {
>  	struct virtio_fs *fs = dax_get_private(dax_dev);
>  	phys_addr_t offset = PFN_PHYS(pgoff);
> -	size_t max_nr_pages = fs->window_len/PAGE_SIZE - pgoff;
> +	size_t max_nr_pages = fs->window_len / PAGE_SIZE - pgoff;
>  
>  	if (kaddr)
>  		*kaddr = fs->window_kaddr + offset;
> -- 
> 2.27.0
> 

