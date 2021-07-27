Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360673D7DA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 20:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhG0S3t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 14:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230143AbhG0S3s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 14:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627410588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6sBKpIHNRZeimmd/He7f5ljIel5Vq9B+zrMnU0hHa2g=;
        b=AEKywqjdV8dThzuwNIg3iR1JKdSTsT9ht0ySKw0FYsTrqtlhHSyISLg0t7ZcHFQ+DUJkFP
        CGbRDU65P/gELZx2JVSsYp+FU3+9e/0TGs1Tl9tyzbmELqh8WmhX6C6VMQZq21dzQqEkTS
        CtYY6qxpjrekgeQd5HksRbMxUj4HE+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-qAq-TvmDOOeU7tGrk7_3kw-1; Tue, 27 Jul 2021 14:29:41 -0400
X-MC-Unique: qAq-TvmDOOeU7tGrk7_3kw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96D7194EE1;
        Tue, 27 Jul 2021 18:29:40 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.19.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 836F860862;
        Tue, 27 Jul 2021 18:29:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 14B85224201; Tue, 27 Jul 2021 14:29:33 -0400 (EDT)
Date:   Tue, 27 Jul 2021 14:29:33 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, virtio-fs@redhat.com,
        v9fs-developer@lists.sourceforge.net, stefanha@redhat.com,
        miklos@szeredi.hu
Subject: Re: [PATCH v3 0/3] support booting of arbitrary non-blockdevice file
 systems
Message-ID: <YQBQje2SBNw9hqO0@redhat.com>
References: <20210714202321.59729-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714202321.59729-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 04:23:18PM -0400, Vivek Goyal wrote:
> Hi,
> 
> This is V3 of patches. Christoph had posted V2 here.

Hi,

Ping?

Vivek

> 
> https://lore.kernel.org/linux-fsdevel/20210621062657.3641879-1-hch@lst.de/
> 
> There was a small issue in last patch series that list_bdev_fs_names()
> did not put an extra '\0' at the end as current callers were expecting.
> 
> To fix this, I have modified list_bdev_fs_names() and split_fs_names()
> to return number of null terminated strings they have parsed. And
> modified callers to use that to loop through strings (instead of
> relying on an extra null at the end).
> 
> Christoph was finding it hard to find time so I took his patches, 
> added my changes in patch3 and reposting the patch series.
> 
> I have tested it with 9p, virtiofs and ext4 filesystems as rootfs
> and it works for me.
> 
> Thanks
> Vivek
> 
> Christoph Hellwig (3):
>   init: split get_fs_names
>   init: allow mounting arbitrary non-blockdevice filesystems as root
>   fs: simplify get_filesystem_list / get_all_fs_names
> 
>  fs/filesystems.c   | 27 ++++++++------
>  include/linux/fs.h |  2 +-
>  init/do_mounts.c   | 90 +++++++++++++++++++++++++++++++++-------------
>  3 files changed, 83 insertions(+), 36 deletions(-)
> 
> -- 
> 2.31.1
> 

