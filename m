Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7A948C9F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 18:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350093AbiALRjI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 12:39:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38100 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355758AbiALRjA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:39:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD8C761912;
        Wed, 12 Jan 2022 17:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F64CC36AEA;
        Wed, 12 Jan 2022 17:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642009139;
        bh=WgSDsvFQ7gn+YpLk25HuiZ2Pi3djY+iPCKxFKlfE+FI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1AJQlcSu1Df3SWiSAeIOVcUqPJ05eu/1DK8VMn5pDVNjC04TcHZWMnSlZBE71LPjz
         /0HeXOLwGJB5O87PmZpUY4wKUCfYwe3se5kaIV3RDLWjNChwh2tlBHJ86++Ukc8Aye
         hWUKXsanImo0eBLrIHig+iseWztsd3kvvqnPaC00=
Date:   Wed, 12 Jan 2022 18:38:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     bp@suse.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] firmware_loader: simplfy builtin or module check
Message-ID: <Yd8SL0WmIQhunU/F@kroah.com>
References: <20220112160053.723795-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112160053.723795-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 12, 2022 at 08:00:53AM -0800, Luis Chamberlain wrote:
> The existing check is outdated and confuses developers. Use the
> already existing IS_REACHABLE() defined on kconfig.h which makes
> the intention much clearer.
> 
> Reported-by: Borislav Petkov <bp@alien8.de>
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  include/linux/firmware.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/firmware.h b/include/linux/firmware.h
> index 3b057dfc8284..ec2ccfebef65 100644
> --- a/include/linux/firmware.h
> +++ b/include/linux/firmware.h
> @@ -34,7 +34,7 @@ static inline bool firmware_request_builtin(struct firmware *fw,
>  }
>  #endif
>  
> -#if defined(CONFIG_FW_LOADER) || (defined(CONFIG_FW_LOADER_MODULE) && defined(MODULE))
> +#if IS_REACHABLE(CONFIG_FW_LOADER)
>  int request_firmware(const struct firmware **fw, const char *name,
>  		     struct device *device);
>  int firmware_request_nowarn(const struct firmware **fw, const char *name,
> -- 
> 2.34.1
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
