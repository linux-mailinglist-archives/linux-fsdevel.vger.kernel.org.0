Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7742423BC4F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 16:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgHDOgg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 10:36:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31182 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727838AbgHDOfF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596551704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xVEmdXu1Elr4lJnyU+c+Iz3v9D/K611e6GoM3Q486ac=;
        b=AwmtTDRO9mR/d7pFdmZKN7Kh/r5L3q5QndooWg600XRjwvnedVhSsmcPuKAcCQSoOn75RP
        /GD/K4Jx3JMuAeEtrJf/KIVT9Ezs8GrsIkrVFdaaklETzlz0OYBuUl6XyOI4IvGXXJZJEE
        5gewZ7F5on+07jZIWFOCFvm51Z1LAik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-koWCRCDfOnCMZn-FTt1fIA-1; Tue, 04 Aug 2020 10:33:33 -0400
X-MC-Unique: koWCRCDfOnCMZn-FTt1fIA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B368102CC38;
        Tue,  4 Aug 2020 14:33:32 +0000 (UTC)
Received: from gondolin (ovpn-112-169.ams2.redhat.com [10.36.112.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4A3172E48;
        Tue,  4 Aug 2020 14:33:24 +0000 (UTC)
Date:   Tue, 4 Aug 2020 16:33:22 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 09/24] virtio_fs: correct tags for config space
 fields
Message-ID: <20200804163322.4799a29a.cohuck@redhat.com>
In-Reply-To: <20200803205814.540410-10-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
        <20200803205814.540410-10-mst@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 3 Aug 2020 16:59:13 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Since fs is a modern-only device,
> tag config space fields as having little endian-ness.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/uapi/linux/virtio_fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

