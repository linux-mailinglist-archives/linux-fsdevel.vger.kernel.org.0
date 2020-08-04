Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CF623BB39
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 15:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgHDNgl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 09:36:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25105 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725950AbgHDNgl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596548199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IOCwdMErKnn1pYLabxDoC9kp0B6qr2CDAm+6i+5EwqY=;
        b=KgKY5E9vnlmLG+kLatT4FgOz3We4M0CZGJcjQJdccbx+SxywyqbSUBkqbIpGrguyZwV5p3
        primNbMZZWUN6M9dAOCMmE+EQ3bIeROvSUtngCQNWvzHcT/ySnDkofTGFRADFBMytXA9uu
        Ok5UTGVUpRnC8E/X0ltvfjXCi1UEGJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-fY9lu491MzGQTCeekwHRPA-1; Tue, 04 Aug 2020 09:36:35 -0400
X-MC-Unique: fY9lu491MzGQTCeekwHRPA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01A73107BA73;
        Tue,  4 Aug 2020 13:36:34 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-15.rdu2.redhat.com [10.10.116.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A352F7B909;
        Tue,  4 Aug 2020 13:36:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 208BB220406; Tue,  4 Aug 2020 09:36:33 -0400 (EDT)
Date:   Tue, 4 Aug 2020 09:36:33 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 09/24] virtio_fs: correct tags for config space fields
Message-ID: <20200804133633.GC273445@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-10-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803205814.540410-10-mst@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 03, 2020 at 04:59:13PM -0400, Michael S. Tsirkin wrote:
> Since fs is a modern-only device,
> tag config space fields as having little endian-ness.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

virtio spec does list this field as "le32".

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
>  include/uapi/linux/virtio_fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/virtio_fs.h b/include/uapi/linux/virtio_fs.h
> index b02eb2ac3d99..3056b6e9f8ce 100644
> --- a/include/uapi/linux/virtio_fs.h
> +++ b/include/uapi/linux/virtio_fs.h
> @@ -13,7 +13,7 @@ struct virtio_fs_config {
>  	__u8 tag[36];
>  
>  	/* Number of request queues */
> -	__u32 num_request_queues;
> +	__le32 num_request_queues;
>  } __attribute__((packed));
>  
>  #endif /* _UAPI_LINUX_VIRTIO_FS_H */
> -- 
> MST
> 

