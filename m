Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F10816B12B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 21:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgBXUuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 15:50:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbgBXUux (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 15:50:53 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FAF220726;
        Mon, 24 Feb 2020 20:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582577453;
        bh=3ws2XCyy6ILZso2oH4i/yzvd9uzvxwvQWJJv4TRuz70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9K9/4BBR6t94BgsvQWvL0MElmPNMiRWdsQHvAkOcAoRolDDWAYFaRQbGHAX/th9Y
         RfGNU35wJz/tbi+gRRQcx+ddhCAfCvP4LZS2XAnCxT4tDvB3hZsUZzmiW3hP0rlS1M
         0H4NWqJWja70WOgXrjABzy9YWTQImgBaVYFeNivo=
Date:   Mon, 24 Feb 2020 12:50:51 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Subject: Re: [man-pages PATCH v2] statx.2: document STATX_ATTR_VERITY
Message-ID: <20200224205051.GE109047@gmail.com>
References: <20200128192449.260550-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128192449.260550-1-ebiggers@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 28, 2020 at 11:24:49AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Document the verity attribute for statx(), which was added in
> Linux 5.5.
> 
> For more context, see the fs-verity documentation:
> https://www.kernel.org/doc/html/latest/filesystems/fsverity.html
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  man2/statx.2 | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/man2/statx.2 b/man2/statx.2
> index d2f1b07b8..d015ee73d 100644
> --- a/man2/statx.2
> +++ b/man2/statx.2
> @@ -461,6 +461,11 @@ See
>  .TP
>  .B STATX_ATTR_ENCRYPTED
>  A key is required for the file to be encrypted by the filesystem.
> +.TP
> +.B STATX_ATTR_VERITY
> +Since Linux 5.5: the file has fs-verity enabled.  It cannot be written to, and
> +all reads from it will be verified against a cryptographic hash that covers the
> +entire file, e.g. via a Merkle tree.
>  .SH RETURN VALUE
>  On success, zero is returned.
>  On error, \-1 is returned, and
> -- 
> 2.25.0.341.g760bfbb309-goog
> 

Ping?  Michael, can you apply this man-pages patch?

- Eric
