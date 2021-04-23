Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0E5369239
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 14:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhDWMhQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 08:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229479AbhDWMhP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 08:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619181398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pJej3FjQqwZF0nD961n5CgItaSNCHtrniaFd0P+tb6A=;
        b=fijOflAkQVKUVZDZ9WzzpRN/FvGvZ5b8JxHsCclcbYUIN7kj8Q6AzvT5598xJUX08Q2QD4
        W7nv4IoAd7NmbW4L6+uB5kvN0UKK5NpdG2cjUpVL2lY7tAGVWTfD7e2+iEw75GitayZ3J9
        32EJlGd054GUPoNEnQr8vcd2EwkbGos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-XK7KpkO3N6ymzlWj-BKBTA-1; Fri, 23 Apr 2021 08:36:35 -0400
X-MC-Unique: XK7KpkO3N6ymzlWj-BKBTA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7892E107ACE3;
        Fri, 23 Apr 2021 12:36:33 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA3F75D9E3;
        Fri, 23 Apr 2021 12:36:28 +0000 (UTC)
Date:   Fri, 23 Apr 2021 08:36:26 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 1/3] fcntl: remove unused VALID_UPGRADE_FLAGS
Message-ID: <20210423123626.GL3141668@madcap2.tricolour.ca>
References: <20210423111037.3590242-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423111037.3590242-1-brauner@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-04-23 13:10, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> We currently do not maky use of this feature and should we implement
> something like this in the future it's trivial to add it back.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Suggested-by: Richard Guy Briggs <rgb@redhat.com>
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

> ---
>  include/linux/fcntl.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> index 766fcd973beb..a332e79b3207 100644
> --- a/include/linux/fcntl.h
> +++ b/include/linux/fcntl.h
> @@ -12,10 +12,6 @@
>  	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
>  	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
>  
> -/* List of all valid flags for the how->upgrade_mask argument: */
> -#define VALID_UPGRADE_FLAGS \
> -	(UPGRADE_NOWRITE | UPGRADE_NOREAD)
> -
>  /* List of all valid flags for the how->resolve argument: */
>  #define VALID_RESOLVE_FLAGS \
>  	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
> 
> base-commit: d434405aaab7d0ebc516b68a8fc4100922d7f5ef
> -- 
> 2.27.0
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

