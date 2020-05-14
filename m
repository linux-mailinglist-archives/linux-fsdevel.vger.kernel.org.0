Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387B81D308A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 15:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgENNBd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 09:01:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60169 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgENNBc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 09:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589461291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RPUoVQhPIe2yM06OVwXPGrLVKPBJs8B5xCOPXjBDKHc=;
        b=faWN9SShQj2SRWt2ZnwB8kf1hfEb8GxkhAplE/zVlRaKTf+mme3txR0lvPnkaVKz0bwPyT
        8yjt3VIQgOlP5XJz60jqzdULscnYMrycNMuE8Vlbp9Tiv/rsPbUlfAnVRLB1fLnOCnetbu
        VG0xUzxe3K2v0/ovLV2FIq+63bB15Jw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-k0D4IUgaMlCd7BfaQGvCYw-1; Thu, 14 May 2020 09:01:30 -0400
X-MC-Unique: k0D4IUgaMlCd7BfaQGvCYw-1
Received: by mail-qt1-f199.google.com with SMTP id v18so3371940qtq.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2020 06:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RPUoVQhPIe2yM06OVwXPGrLVKPBJs8B5xCOPXjBDKHc=;
        b=oXP2pJJv+g296+wZi0+jigEj5yPlWSyyWAPQWg1U1G+s6u+z/fa4FH5SMCCDRpBPNL
         Qr0BPLvoQ0jIMxBl0T58GuAEhs4wEmFCgdc6HDMGH2d9J/vMtokMWGoZb9MHRAkIjsc0
         aebGGINGysqk0h7Rp08F9d/yBfKTR5qcwvgyqeD4fs6yTlvUZ3aXnrLbgcGkvFm0ZpJG
         QvOXqr8xZUtWqc4uOaFqkW7wTL+MVSDva674FAprCEMdkZ6gojai6vF3ntcz5T+OGZPz
         VMQsH6u/wvklmyrtynx7qETXtgJo0k1kj/rdit6fGUpbxo/C6TSpRCtVL/h6cPWju9sY
         cskg==
X-Gm-Message-State: AOAM532VeHHtImZOmZplV5CbnbCRg7IU7mHTNmdXSfz2aLLX9Ow9ucJt
        JW8w2oPc1r2Vg74DFY1G+s3Ow9hj3sxbaSloAT0l7pJxyl5T043D7UvNmupS5Pl1DWe+KZh8jdK
        dzbX5QVGF+jDQcBE+aUU6ebWy4ngoAFCKyWEBpz0jOA==
X-Received: by 2002:ac8:60d4:: with SMTP id i20mr4249008qtm.324.1589461285370;
        Thu, 14 May 2020 06:01:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2pGkMmrvk4NwbKD1e7NVk4MsM30jYPz4g8rvzp4ik5zEpxXqHkBU6VN4gTNwSkFtwOQij9VpR+N1uXI3vTBI=
X-Received: by 2002:ac8:60d4:: with SMTP id i20mr4248970qtm.324.1589461284935;
 Thu, 14 May 2020 06:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200505095915.11275-1-mszeredi@redhat.com> <20200505095915.11275-6-mszeredi@redhat.com>
 <20200513100432.GC7720@infradead.org> <CAJfpeguPhJApOQgw02-yCPJZ5Tx_Zy2ZFh+De5DC560FNqdFSA@mail.gmail.com>
In-Reply-To: <CAJfpeguPhJApOQgw02-yCPJZ5Tx_Zy2ZFh+De5DC560FNqdFSA@mail.gmail.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Thu, 14 May 2020 15:01:13 +0200
Message-ID: <CAOssrKeV7g0wPg4ozspG4R7a+5qARqWdG+GxWtXB-MCfbVM=9A@mail.gmail.com>
Subject: Re: [PATCH 05/12] f*xattr: allow O_PATH descriptors
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 14, 2020 at 10:02 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, May 13, 2020 at 12:04 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Needs a Cc to linux-api and linux-man.
> >
> > On Tue, May 05, 2020 at 11:59:08AM +0200, Miklos Szeredi wrote:
> > > This allows xattr ops on symlink/special files referenced by an O_PATH
> > > descriptor without having to play games with /proc/self/fd/NN (which
> > > doesn't work for symlinks anyway).
> >
> > Do we even intent to support xattrs on say links?  They never wire up
> > ->listxattr and would only get them through s_xattr.  I'm defintively
> > worried that this could break things without a very careful audit.
>
> Why do you think listxattr is not wired up for symlinks?
>
> Xfs and ext4 definitely do have it, and it seems most others too:
>
> $ git grep -A10  "struct inode_operations.*symlink" | grep listxattr | wc -l
> 29

In any case, I'm dropping this patch for now.   The comment about
/proc/self/fd/NN not working is actually wrong; it does work despite
the target being a symlink: LOOKUP_FOLLOW only follows the magic
symlink in this case, not the symlink that is the target.  So it's
possible to get (set, remove, list) the xattr on an O_PATH descriptor
using

sprintf("/proc/self/fd/%i", procpath, sizeof(procpath));
getxattr(procpath, ...);

Thanks,
Miklos

