Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C18138C566
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 13:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhEULJD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 07:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230232AbhEULJA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 07:09:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D606D611AE;
        Fri, 21 May 2021 11:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621595257;
        bh=RnjQsR1H5aqN6tCZnJoqqA4p4twRvCmpeee1SK0l2VY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VxAaSAE6jScbTw66SXo4juzgz19Ws8GeJS8r9B1vMa1zpZl934q+jJ1y6z7j/DXu0
         cbln/2/wj7l9uEQ6OpbXEbeIjUu/CYBNSy/slPzkUN2RIqTSanQcvrJi3kiii+mM7N
         ao4Dd7JesIYGYjr++p2H63byqOKKbj3QcSvUpdSI=
Date:   Fri, 21 May 2021 13:07:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aviral Gupta <shiv14112001@gmail.com>
Cc:     viro@zeniv.linux.org.uk, shuah@kernal.org,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] This commit fixes the error generated due to the wrong
 indentation which does not follow the codding style norms set by
 Linux-kernel and space- bar is used in place of tab to give space which
 causes a visual error for some compilers
Message-ID: <YKeUd/X5tuN54o1H@kroah.com>
References: <20210521105654.4046-1-shiv14112001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521105654.4046-1-shiv14112001@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 04:26:54PM +0530, Aviral Gupta wrote:
> ERROR: switch and case should be at the same indent
> +	switch (whence) {
> +		case 1:
> [...]
> +		case 0:
> [...]
> +		default:
> ERROR: code indent should use tabs where possible
> +                              void (*callback)(struct dentry *))$
> 
> Signed-off-by: Aviral Gupta <shiv14112001@gmail.com>
> ---
>  fs/libfs.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Your subject line is very odd.

And why are you trying to change coding style issues in core kernel
code?

Please start this type of work in drivers/staging/ where it is wanted,
not in other areas of the kernel where it is not good to try to learn
the process.

good luck!

greg k-h
