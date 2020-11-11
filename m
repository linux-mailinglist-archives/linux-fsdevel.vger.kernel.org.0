Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2AE2AFB1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 23:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgKKWJ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 17:09:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52445 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbgKKWJ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 17:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605132596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NNT6Y3XAEtQP7E6raROQBlth0CgSqTiy+VetRwWd9MQ=;
        b=J4CUHzqbXoU2o4CkyUPLwElvarQ/dBZvkjue1nY3sWrGy+af4wobw5g54fCjRpZ1SxW1Op
        SGh7P1rlrQezYO70ECeWp60w2zjbiXXIsCuypioUvXGPaeanbwX44fBdDK2uyWH/zOZEnY
        7T04NEH8Q88MohMDaitOgNwVG3pbIo0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-HCJXeB7oPKmXp8IQc5GOZg-1; Wed, 11 Nov 2020 17:09:54 -0500
X-MC-Unique: HCJXeB7oPKmXp8IQc5GOZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C73C64088;
        Wed, 11 Nov 2020 22:09:53 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-158.rdu2.redhat.com [10.10.115.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20A845DA79;
        Wed, 11 Nov 2020 22:09:50 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8F8E1220203; Wed, 11 Nov 2020 17:09:49 -0500 (EST)
Date:   Wed, 11 Nov 2020 17:09:49 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Subject: Re: [PATCH v3 3/6] fuse: setattr should set FATTR_KILL_PRIV upon
 size change
Message-ID: <20201111220949.GB1577294@redhat.com>
References: <20201009181512.65496-1-vgoyal@redhat.com>
 <20201009181512.65496-4-vgoyal@redhat.com>
 <CAJfpegu=ooDmc3hT9cOe2WEUHQN=twX01xbV+YfPQPJUHFMs-g@mail.gmail.com>
 <20201106171843.GA1445528@redhat.com>
 <CAJfpegvvGL=GJX0a+cDUVhX754NibudTvHvtrBrCnk-FEnfQ6A@mail.gmail.com>
 <CAJfpegvoqBS-uXnPFkxViYanJUCi_s29bajyn1z7Vcd7owJVpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvoqBS-uXnPFkxViYanJUCi_s29bajyn1z7Vcd7owJVpg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 11, 2020 at 05:24:22PM +0100, Miklos Szeredi wrote:
> On Wed, Nov 11, 2020 at 2:54 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> > How about FUSE_*KILL_SUIDGID (FUSE_WRITE_KILL_SUIDGID being an alias
> > for FUSE_WRITE_KILL_PRIV)?
> 
> Series pushed to #for-next with these changes.  Please take a look and test.

Thanks Miklos. I looked at the patches quickly and they look good. I am
now fixing qemu virtiofsd side and will test.

Thanks
Vivek

