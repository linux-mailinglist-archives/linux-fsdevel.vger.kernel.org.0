Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A2726CF45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 01:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgIPXMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 19:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgIPXMK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 19:12:10 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE4DC06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2020 16:12:10 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIgaq-00039C-4W; Wed, 16 Sep 2020 23:12:04 +0000
Date:   Thu, 17 Sep 2020 00:12:04 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: fix cast in fsparam_u32hex() macro
Message-ID: <20200916231204.GM3421308@ZenIV.linux.org.uk>
References: <20200916201843.GA802551@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916201843.GA802551@localhost.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 11:18:43PM +0300, Alexey Dobriyan wrote:
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  include/linux/fs_parser.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/include/linux/fs_parser.h
> +++ b/include/linux/fs_parser.h
> @@ -120,7 +120,7 @@ static inline bool fs_validate_description(const char *name,
>  #define fsparam_u32oct(NAME, OPT) \
>  			__fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)8)
>  #define fsparam_u32hex(NAME, OPT) \
> -			__fsparam(fs_param_is_u32_hex, NAME, OPT, 0, (void *16))
> +			__fsparam(fs_param_is_u32_hex, NAME, OPT, 0, (void *)16)
>  #define fsparam_s32(NAME, OPT)	__fsparam(fs_param_is_s32, NAME, OPT, 0, NULL)
>  #define fsparam_u64(NAME, OPT)	__fsparam(fs_param_is_u64, NAME, OPT, 0, NULL)
>  #define fsparam_enum(NAME, OPT, array)	__fsparam(fs_param_is_enum, NAME, OPT, 0, array)

Nice catch; applied.
