Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E67034378D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 04:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhCVDni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Mar 2021 23:43:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229692AbhCVDnO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Mar 2021 23:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616384588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9aeaOu4BBMArdsItvL2pkshodWNoERpCDLkQgAkiDQ=;
        b=a9EKVYkjrbLE6JVcb2aXY0hjGMdWLi0BCERrJllvDYovg2brwGXMEIpFHNP+iUBgT7/77h
        OUwgV+AkebsFGR8wJtDm4Nyj62taC9sm+lkGEpJlwVD/K043SxzDq2dZJtU7MUYDnrIkQo
        BI+Y3MuIkCbDThVjb7B9WFkwTwsnSOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-mj6K3magMeiHqJy22sSI8w-1; Sun, 21 Mar 2021 23:43:03 -0400
X-MC-Unique: mj6K3magMeiHqJy22sSI8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8DD080006E;
        Mon, 22 Mar 2021 03:43:02 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-188.pek2.redhat.com [10.72.13.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0CE462A23;
        Mon, 22 Mar 2021 03:42:47 +0000 (UTC)
Subject: Re: [PATCH 3/3] fuse: fix typo for fuse_conn.max_pages comment
To:     Connor Kuehl <ckuehl@redhat.com>, virtio-fs@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        vgoyal@redhat.com, miklos@szeredi.hu, mst@redhat.com
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-4-ckuehl@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <71b3495d-655e-2258-969d-076c48d9f265@redhat.com>
Date:   Mon, 22 Mar 2021 11:42:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210318135223.1342795-4-ckuehl@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


ÔÚ 2021/3/18 ÏÂÎç9:52, Connor Kuehl Ð´µÀ:
> 'Maxmum' -> 'Maximum'


Need a better log here.

With the commit log fixed.

Acked-by: Jason Wang <jasowang@redhat.com>


>
> Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
> ---
>   fs/fuse/fuse_i.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index f0e4ee906464..8bdee79ba593 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -552,7 +552,7 @@ struct fuse_conn {
>   	/** Maximum write size */
>   	unsigned max_write;
>   
> -	/** Maxmum number of pages that can be used in a single request */
> +	/** Maximum number of pages that can be used in a single request */
>   	unsigned int max_pages;
>   
>   #if IS_ENABLED(CONFIG_VIRTIO_FS)

