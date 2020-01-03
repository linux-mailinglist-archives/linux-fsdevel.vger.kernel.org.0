Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45F1712FB13
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 18:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgACRC4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 12:02:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbgACRCz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:02:55 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D883206DB;
        Fri,  3 Jan 2020 17:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578070975;
        bh=aDA7AeEiGNoPBRANxPTy+BfhdhRrl0XqxQaxvqy/SEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GGD1csfZIP5FXGiU+rE8+9nImTjyFqNAxqDezA+NTrzO1WCu3riD/OWZ1QVKojW3f
         0Y1eMwRLHcQiSGhrcZXKN63noBknksOwpCeHQOcucTFITYN34Tx2u+rvx9TKEG6aJl
         s3PU+bcrDoU23pVMcb9HMh31bNazarx0nHq5XJr4=
Date:   Fri, 3 Jan 2020 09:02:53 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fscrypt: include <linux/ioctl.h> in UAPI header
Message-ID: <20200103170253.GK19521@gmail.com>
References: <20191219185624.21251-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219185624.21251-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 19, 2019 at 10:56:24AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> <linux/fscrypt.h> defines ioctl numbers using the macros like _IORW()
> which are defined in <linux/ioctl.h>, so <linux/ioctl.h> should be
> included as a prerequisite, like it is in many other kernel headers.
> 
> In practice this doesn't really matter since anyone referencing these
> ioctl numbers will almost certainly include <sys/ioctl.h> too in order
> to actually call ioctl().  But we might as well fix this.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  include/uapi/linux/fscrypt.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/fscrypt.h b/include/uapi/linux/fscrypt.h
> index d5112a24e8b9f..0d8a6f47711c3 100644
> --- a/include/uapi/linux/fscrypt.h
> +++ b/include/uapi/linux/fscrypt.h
> @@ -8,6 +8,7 @@
>  #ifndef _UAPI_LINUX_FSCRYPT_H
>  #define _UAPI_LINUX_FSCRYPT_H
>  
> +#include <linux/ioctl.h>
>  #include <linux/types.h>
>  
>  /* Encryption policy flags */
> -- 
> 2.24.1.735.g03f4e72817-goog
> 

Applied to fscrypt.git#master for 5.6.

(Fixed a typo in the commit message -- "_IORW()" should be "_IOWR()".)

- Eric
