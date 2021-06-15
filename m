Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3733A8656
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 18:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFOQZu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 12:25:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230246AbhFOQZs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:25:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2F72616E9;
        Tue, 15 Jun 2021 16:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623774223;
        bh=b5z+9n+SQFtB1r1+Kvl47vN1hPmjk9XqUBLNxUuYBI8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tscl1e10bMwK+/E1N5I5r6PT5IGP4BQhW2FDVfFcuJOYRKKX8DiUpflOYISKa+5VV
         /21/AFOhhHa6xqTQ7emAyXlfbblaLFGSaLGPixt+IhUWRAgSmec0oGY1lEgi1ghGQt
         AyQJqClFcb7XD0Y5Ib1ALBmyd2AGVazaGG6LVWVZfD+C22+zN9+hd4pOEKt5Ov6y97
         Ec2Y29SmuzWDD9r5BcC1lhE5lNGGQuHCdgid4YsE2CQj51hpFfsjJMAnlD7wszRPmc
         6Lkooom0EXE0W3xLQpdFx2EzGVTLgo+VDvBeiSBJ1dWrrJERSQGJ68E/DAnm3fDu8K
         eg7Xzl9nh010g==
Message-ID: <46e23dac5a459ece61250d36d3ac1cedb17f9433.camel@kernel.org>
Subject: Re: [PATCH] netfs: Add MAINTAINERS record
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 15 Jun 2021 12:23:41 -0400
In-Reply-To: <162377165897.729347.292567369593752239.stgit@warthog.procyon.org.uk>
References: <162377165897.729347.292567369593752239.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-06-15 at 16:40 +0100, David Howells wrote:
> Add a MAINTAINERS record for the new netfs helper library.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> cc: linux-mm@kvack.org
> cc: linux-cachefs@redhat.com
> cc: linux-afs@lists.infradead.org
> cc: linux-nfs@vger.kernel.org
> cc: linux-cifs@vger.kernel.org
> cc: ceph-devel@vger.kernel.org
> cc: v9fs-developer@lists.sourceforge.net
> cc: linux-fsdevel@vger.kernel.org
> ---
> 
>  MAINTAINERS |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bc0ceef87b73..364465f20e81 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12878,6 +12878,15 @@ NETWORKING [WIRELESS]
>  L:	linux-wireless@vger.kernel.org
>  Q:	http://patchwork.kernel.org/project/linux-wireless/list/
>  
> +NETWORK FILESYSTEM HELPER LIBRARY
> +M:	David Howells <dhowells@redhat.com>
> +M:	Jeff Layton <jlayton@kernel.org>
> +L:	linux-cachefs@redhat.com (moderated for non-subscribers)
> +S:	Supported
> +F:	Documentation/filesystems/netfs_library.rst
> +F:	fs/netfs/
> +F:	include/linux/netfs.h
> +
>  NETXEN (1/10) GbE SUPPORT
>  M:	Manish Chopra <manishc@marvell.com>
>  M:	Rahul Verma <rahulv@marvell.com>
> 
> 

Acked-by: Jeff Layton <jlayton@kernel.org>

