Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B254616AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 14:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbhK2NjI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 08:39:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50871 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377867AbhK2NhI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638192829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p/Ma4OjV1QAHTKX0nrgFV6x1HeF1oMP1qvIIB/p5juI=;
        b=D2ACO6owKAWvXXIxSNuocdnboUlCIp3OncZguWHEOP/0Bybde9jnwYB4oBimROyC21djvC
        pT2eFgAXGI+S8elTxQ6WnXtlDA5E2A20nen/+lR8dvt7K6EOJugx3tTSJctcUbTOKAEACD
        Hrt7voc7v3ZJFQGJg0zq4U/1KWJdUS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-i8s6QBecPMqroT3LKu8W_w-1; Mon, 29 Nov 2021 08:33:46 -0500
X-MC-Unique: i8s6QBecPMqroT3LKu8W_w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 748721927800;
        Mon, 29 Nov 2021 13:33:45 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9356A10013D6;
        Mon, 29 Nov 2021 13:33:42 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1D5B1225EC1; Mon, 29 Nov 2021 08:33:42 -0500 (EST)
Date:   Mon, 29 Nov 2021 08:33:42 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2] fuse: rename some files and clean up Makefile
Message-ID: <YaTWtgSrtSDCU1ti@redhat.com>
References: <1638008002-3037-1-git-send-email-yangtiezhu@loongson.cn>
 <YaSpRwMlMvcIIMZo@stefanha-x1.localdomain>
 <7277c1ee-6f7b-611d-180d-866db37b2bd7@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7277c1ee-6f7b-611d-180d-866db37b2bd7@loongson.cn>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 29, 2021 at 09:27:17PM +0800, Tiezhu Yang wrote:
> On 11/29/2021 06:19 PM, Stefan Hajnoczi wrote:
> > On Sat, Nov 27, 2021 at 06:13:22PM +0800, Tiezhu Yang wrote:
> > > No need to generate virtio_fs.o first and then link to virtiofs.o, just
> > > rename virtio_fs.c to virtiofs.c and remove "virtiofs-y := virtio_fs.o"
> > > in Makefile, also update MAINTAINERS. Additionally, rename the private
> > > header file fuse_i.h to fuse.h, like ext4.h in fs/ext4, xfs.h in fs/xfs
> > > and f2fs.h in fs/f2fs.
> > 
> > There are two separate changes in this patch (virtio_fs.c -> virtiofs.c
> > and fuse_i.h -> fuse.h). A patch series with two patches would be easier
> > to review and cleaner to backport.
> > 
> > I'm happy with renaming virtio_fs.c to virtiofs.c:
> > 
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> 
> Hi Stefan and Miklos,
> 
> Thanks for your reply, what should I do now?
> 
> (1) split this patch into two separate patches to send v3;
> (2) just ignore this patch because
> "This will make backport of bugfixes harder for no good reason."
> said by Miklos.

I agree with Miklos that there does not seem to be a very strong reason
to rename. It probably falls in the category of nice to have cleanup. But
it will also make backports harder. So I also like the idea of not making
this change.

Vivek

