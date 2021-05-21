Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C4938BFFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 08:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhEUGuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 02:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:32882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231627AbhEUGuW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 02:50:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 082B660724;
        Fri, 21 May 2021 06:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621579739;
        bh=wdYmfwdm4nzmPrxFS2YNbnS85Aq+b2coK+5qodudhVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8k5NsQjBtZEB1VUmQrF9eBLUNFT+5AhYaJBK9tXorNi1FFT/CSZDXcaYFCT4SfVW
         lSs9KoWtwF2oFXL1Nmqq8vy/3B0mOLhGdmj2YuVNEXX87ofG2B/bbroESp82R7yBxa
         1k0fI7JTRdl7WZjke/bfPQ5axrfBEF/sWKsVD4wQ=
Date:   Fri, 21 May 2021 08:48:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     aviral14112001 <shiv14112001@gmail.com>
Cc:     viro@zeniv.linux.org.uk, shuah@kernal.org,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] This commit fixes the following checkpatch.pl errors and
 warnings : >>ERROR: switch and case should be at the same indent + switch
 (whence) { +           case 1: [...] +         case 0: [...] + default:
Message-ID: <YKdX2FEsuyBkmqki@kroah.com>
References: <20210521054857.7784-1-shiv14112001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521054857.7784-1-shiv14112001@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 11:18:57AM +0530, aviral14112001 wrote:
> >>ERROR: code indent should use tabs where possible
> +                              void (*callback)(struct dentry *))$
> 
> >>WARNING: Prefer [subsystem eg: netdev]_warn([subsystem]dev, ... then dev_warn(dev, ... then pr_warn(...  to printk(KERN_WARNING ...
> +			printk(KERN_WARNING "%s: %s passed in a files array"
> 
> >>WARNING: break quoted strings at a space character
> +			printk(KERN_WARNING "%s: %s passed in a files array"
> +				"with an index of 1!\n", __func__,
> 
> >>WARNING: Symbolic permissions 'S_IRUSR | S_IWUSR' are not preferred. Consider using octal permissions '0600'.
> +	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
> 
> >>WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> +			loff_t pos, unsigned len, unsigned flags,
> 
> >>WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> +			loff_t pos, unsigned len, unsigned flags,
> 
> >>WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> +		unsigned from = pos & (PAGE_SIZE - 1);
> 
> >>WARNING: Block comments use a trailing */ on a separate line
> + * to set the attribute specific access operations. */
> 
> >>WARNING: Symbolic permissions 'S_IRUGO | S_IXUGO' are not preferred. Consider using octal permissions '0555'.
> +	inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO;
> 
> >>Several other warnings (WARNING: Missing a blank line after declarations)
> 
> Signed-off-by: aviral14112001 <shiv14112001@gmail.com>
> ---
>  fs/libfs.c | 66 ++++++++++++++++++++++++++++++------------------------
>  1 file changed, 37 insertions(+), 29 deletions(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
