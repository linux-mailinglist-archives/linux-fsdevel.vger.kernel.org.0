Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06879525B0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 07:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344013AbiEMFjX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 01:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiEMFjW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 01:39:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C56C266E02;
        Thu, 12 May 2022 22:39:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB0BE61BE7;
        Fri, 13 May 2022 05:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F45C34100;
        Fri, 13 May 2022 05:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652420359;
        bh=/dppBu7DR0zCui1WL9hR5i1Q+6lNJXK+VFjPXzUzIx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h9e7kQ1i0vlNPgtrUHOvXqpj9N7esOHJIsh3lRiD3e/TbCBrUbH1K4Yt3qT/mZ+kO
         85yFz55cOkdgNS8O6+l24R3reZg1mzLx930qjpf5cYSACSiKPm8QnaaP57f89/AhDx
         lEA4SJrJpPKIEQkqhyfzd1BuwFLLOcLGNkv6F3eA=
Date:   Fri, 13 May 2022 07:39:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     russell.h.weight@intel.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add Russ Weight as a firmware loader
 maintainer
Message-ID: <Yn3vA+jN4B8C8g0T@kroah.com>
References: <20220512185529.3138310-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512185529.3138310-1-mcgrof@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 12, 2022 at 11:55:29AM -0700, Luis Chamberlain wrote:
> Russ has done extensive rework on the usermode helper interface for
> the firmware loader. He's also exressed recent interest with maintenance
> and has kindly agreed to help review generic patches for the firmware
> loader. So add him as a new maintainer!
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 452f3662e5ac..50e89928d399 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7664,6 +7664,7 @@ F:	include/linux/arm_ffa.h
>  
>  FIRMWARE LOADER (request_firmware)
>  M:	Luis Chamberlain <mcgrof@kernel.org>
> +M:	Russ Weight <russell.h.weight@intel.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/firmware_class/
> -- 
> 2.35.1
> 

For obvious reasons, I need an ack from Russ before I can take this.

thanks,

greg k-h
