Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3F2494842
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 08:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358970AbiATH3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 02:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiATH3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:29:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231F0C061574;
        Wed, 19 Jan 2022 23:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s1nl8qU6w4oIoXu6c60OoOpigmy5AIMsRTBYeiw0rO4=; b=xaMgCKIzgvs00otMpCOciROt+Q
        YfQDr9G8vEdtkQzNrsg/SBIQrJgay+TsEg2u6zEgQphK/agoxbGWCJb9heuXC3FRDZx+dQJE8fg2L
        u2XlskzFYyapoJM7E0qwOItsm28zJHkevhSxO23dddxZ2rSkBCNUPxxM/MCUGcNrGj9+euUG9Wi9+
        83Vz9BJfc5RmdRoegJ6e0JinuMXiZpaL8LH4RPVj7U3VYaiED6INFW3gctNmRJ9A5jGKKoGFvJouq
        8nowrZWcOjz0ofOpUzc8SbIx6Q3zmOUGl32cA5tJ2VlYrWz4L6CHqAf/J7PKbRkvjG5iswTAdTTXf
        pX9E1uiw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nARt3-009LVL-Ok; Thu, 20 Jan 2022 07:29:37 +0000
Date:   Wed, 19 Jan 2022 23:29:37 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devtmpfs: drop redundant fs parameters from internal fs
Message-ID: <YekPYSM981yo/JYL@infradead.org>
References: <20220119220248.32225-1-ailiop@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119220248.32225-1-ailiop@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 19, 2022 at 11:02:48PM +0100, Anthony Iliopoulos wrote:
> The internal_fs_type is mounted via vfs_kernel_mount() and is never
> registered as a filesystem, thus specifying the parameters is redundant
> as those params will not be validated by fs_validate_description().
> 
> Both {shmem,ramfs}_fs_parameters are anyway validated when those
> respective filesystems are first registered, so there is no reason to
> pass them to devtmpfs too, drop them.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
