Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 571C0F3921
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 21:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfKGUDv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 15:03:51 -0500
Received: from ms.lwn.net ([45.79.88.28]:39410 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbfKGUDv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:03:51 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 955826EC;
        Thu,  7 Nov 2019 20:03:50 +0000 (UTC)
Date:   Thu, 7 Nov 2019 13:03:49 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: atomic_open called with shared lock on
 non-O_CREAT open
Message-ID: <20191107130349.5b590947@lwn.net>
In-Reply-To: <20191030104654.6315-1-jlayton@kernel.org>
References: <20191030104654.6315-1-jlayton@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 30 Oct 2019 06:46:54 -0400
Jeff Layton <jlayton@kernel.org> wrote:

> The exclusive lock is only held when O_CREAT is set.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  Documentation/filesystems/locking.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index fc3a0704553c..5057e4d9dcd1 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -105,7 +105,7 @@ getattr:	no
>  listxattr:	no
>  fiemap:		no
>  update_time:	no
> -atomic_open:	exclusive
> +atomic_open:	shared (exclusive if O_CREAT is set in open flags)
>  tmpfile:	no
>  ============	=============================================

Applied, thanks.

jon
