Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7379E2175FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 20:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgGGSKL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 14:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728036AbgGGSKK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 14:10:10 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6656420708;
        Tue,  7 Jul 2020 18:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594145409;
        bh=rvnU/JSMgTQ4ezgAJ8wlMxfyHZRX9bjgixDnhUVnFuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f0bR1Iq6mutvhR5+xI2ajkl+iuZwNxvp8VjIWUA7BC2h0bwliZ6P1/89CTaxsVOFI
         IiiWWUHDcqqvH1GLqSyBVD38E9ETG70IpKSWfdhuvgJm5SEMFF16ghslfpKiXeRX/l
         9TjgqN/cJDaq9wvjltU+DZmzK4ZiN8TuMNVpzE44=
Date:   Tue, 7 Jul 2020 11:10:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Ian Kent <raven@themaw.net>,
        autofs@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-cachefs@redhat.com, Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>,
        linux-fscrypt@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 05/10] Documentation: filesystems: fsverity: drop doubled
 word
Message-ID: <20200707181008.GC839@sol.localdomain>
References: <20200703214325.31036-1-rdunlap@infradead.org>
 <20200703214325.31036-6-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703214325.31036-6-rdunlap@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 03, 2020 at 02:43:20PM -0700, Randy Dunlap wrote:
> Drop the doubled word "the".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Theodore Y. Ts'o <tytso@mit.edu>
> Cc: linux-fscrypt@vger.kernel.org
> ---
>  Documentation/filesystems/fsverity.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200701.orig/Documentation/filesystems/fsverity.rst
> +++ linux-next-20200701/Documentation/filesystems/fsverity.rst
> @@ -659,7 +659,7 @@ weren't already directly answered in oth
>        retrofit existing filesystems with new consistency mechanisms.
>        Data journalling is available on ext4, but is very slow.
>  
> -    - Rebuilding the the Merkle tree after every write, which would be
> +    - Rebuilding the Merkle tree after every write, which would be
>        extremely inefficient.  Alternatively, a different authenticated
>        dictionary structure such as an "authenticated skiplist" could
>        be used.  However, this would be far more complex.

Acked-by: Eric Biggers <ebiggers@google.com>
