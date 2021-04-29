Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D087236E73A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 10:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbhD2IpM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 04:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhD2IpL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:45:11 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DA9C06138B;
        Thu, 29 Apr 2021 01:44:25 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 5A81FC020; Thu, 29 Apr 2021 10:44:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1619685860; bh=Ta+e5qgCriDVz0KVpMfvq2yUJdYOeqYDGVPg9WVPxEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xnt2qP0Aev2VQ53LDqXe8hS1/ofGYUWumNPtWzEV+AemHy1wfpKgCe3wYLxY6SYtD
         W1WThGpVW4o+VDDqd6kl0eVKzvjRVUMzDdp46yhvAPqDGB6TAoHfBNUp9YEWSrTKZZ
         u0y0g0ikYbgVVXfFf3CXQkMkAzEgXecMxecmHIF9GAIg8POQkE1YL8gzBaT2xIZFCV
         b8Q/GyWTTMFgyG3sq77n6vteWZv/MkzuB/mgKuNthx2S5EaUhuC2tLFx8Qpoyq+Ize
         XWOPbWgKLWUUC5iZHcKTZB+oq8YXPmmbGuh9meZZrwZU4A9eaFp8DbGbo9D81mui7P
         yLlzRnYuqCmmQ==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 47670C009;
        Thu, 29 Apr 2021 10:44:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1619685859; bh=Ta+e5qgCriDVz0KVpMfvq2yUJdYOeqYDGVPg9WVPxEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OmFgSaM5EuXGKJgVZUjXqFJS9RjdBGgXXjptx35RT4BOaJCfWOh5nkn65YCDHedMK
         LJQnUKabMDp66NU5y67zzyf7TvJlf0tS3ZjY8GHqy1y6sIdtVMX8gkRlYAJYffBMtO
         xeYBjhV4Z8inqSVtUc35TS0rsWctMI4epzEUE3QqfVM6vhkc7voeu4Q9WLmz4tGCBM
         w1ckRg8+acffFw9Fz1uQy49fBWfQuyiUUkyHoy+6N2d1HRsFXV9o64ws4w1p6qqwDH
         5ePfhjaZX1x3g5zC6nJ5gDzcoJuxfGDC0fw/BpSczV5ksxUBzQEfeOAqKcVOYFIHIq
         DIl7unNecqpag==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id faf44a92;
        Thu, 29 Apr 2021 08:44:09 +0000 (UTC)
Date:   Thu, 29 Apr 2021 17:43:54 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Linux MM <linux-mm@kvack.org>, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-cifs@vger.kernel.org,
        ceph-devel <ceph-devel@vger.kernel.org>,
        V9FS Developers <v9fs-developer@lists.sourceforge.net>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 07/31] netfs: Make a netfs helper module
Message-ID: <YIpxyi8l4LX/oTSJ@codewreck.org>
References: <CAMuHMdXJZ7iNQE964CdBOU=vRKVMFzo=YF_eiwsGgqzuvZ+TuA@mail.gmail.com>
 <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
 <161918455721.3145707.4063925145568978308.stgit@warthog.procyon.org.uk>
 <442393.1619685697@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <442393.1619685697@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells wrote on Thu, Apr 29, 2021 at 09:41:37AM +0100:
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > I see later patches make AFS and FSCACHE select NETFS_SUPPORT.  If this
> > is just a library of functions, to be selected by its users, then please
> > make the symbol invisible.
> 
> Ideally, yes, it would be an invisible symbol enabled by select from the
> network filesystems that use it - but doing that means that you can't choose
> whether to build it in or build it as a module.

Afaik such dependencies are then built as a module if everything it
depends on are modules, and built-in if any of these are built-in.

I think most users would be fine with that -- there's little reason to
have netfs built-in if AFS ceph etc all are modules?

-- 
Dominique
