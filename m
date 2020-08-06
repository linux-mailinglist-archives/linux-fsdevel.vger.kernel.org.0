Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC3523DEC3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Aug 2020 19:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgHFR3b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 13:29:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22171 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729950AbgHFR31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596734965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MwHd6CcJYEmEuf+YoO55dE8m5E0R87S7YH74U/aXf1A=;
        b=c+p2GS8REHBTha1O1fRJlO1jUL7HaIZiALXfZ1UvVvW0U2TtTklcDDV1A6SiaPO1k/CnnN
        8YwelaABwc1L5TjMZrMaG42yRYyWCqc8qtJMdAWmvzEBdMIOdMobzpwqFQk0wSRxTYMV7J
        G3pBLEeo02leTJnqQ65NXAHaXZfjs3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-yw4yRZZJNTKvU8TjJjHtNg-1; Thu, 06 Aug 2020 13:28:10 -0400
X-MC-Unique: yw4yRZZJNTKvU8TjJjHtNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34FF6106F8C4;
        Thu,  6 Aug 2020 17:28:09 +0000 (UTC)
Received: from horse.redhat.com (ovpn-112-23.rdu2.redhat.com [10.10.112.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D74767C0E5;
        Thu,  6 Aug 2020 17:28:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 47886220441; Thu,  6 Aug 2020 13:28:02 -0400 (EDT)
Date:   Thu, 6 Aug 2020 13:28:02 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 31/38] virtio_fs: convert to LE accessors
Message-ID: <20200806172802.GD367847@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
 <20200805134226.1106164-32-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-32-mst@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 05, 2020 at 09:44:39AM -0400, Michael S. Tsirkin wrote:
> Virtio fs is modern-only. Use LE accessors for config space.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
>  fs/fuse/virtio_fs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 4c4ef5d69298..104f35de5270 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -606,8 +606,8 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
>  	unsigned int i;
>  	int ret = 0;
>  
> -	virtio_cread(vdev, struct virtio_fs_config, num_request_queues,
> -		     &fs->num_request_queues);
> +	virtio_cread_le(vdev, struct virtio_fs_config, num_request_queues,
> +			&fs->num_request_queues);
>  	if (fs->num_request_queues == 0)
>  		return -EINVAL;
>  
> -- 
> MST
> 

