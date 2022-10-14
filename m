Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879BE5FF318
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 19:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJNRnL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 13:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJNRmi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:42:38 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F6C1D29AC
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 10:42:36 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i6so5366052pli.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 10:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2SZjirI6vVJY9sKNEfqT5Dc0rwPH+nmIM479xThjSRE=;
        b=lBJRxtkCK/EuZxHO3XQKMCpV1v5nQdz3iTgQtPakGL9M7lePJjXkwG8KHaYd4yyBFX
         ztK1TvSXjGjkRFE17jiS17eYmRAaLKVuGWMpGDh24rhbXTHRzKDBHuutPaG0VGUkJSzY
         Ui/RBTeBQApRjnUnrFQcwA6UrqPl15Du3+dBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SZjirI6vVJY9sKNEfqT5Dc0rwPH+nmIM479xThjSRE=;
        b=4F317gSotU9qfpREJZclx7N07AK9jWY8B5ErSNoYAxQHGdrYRBD2n8fzi4HKMvJqVD
         yQvCMTSZS3CoAlIi0gCwsBbTZs5AUd81RrIXL+V0BIdPoU3H3hSIscKcJBRu4pwDARVM
         AfRc+eMl/jfv6+FsrqRfFi8pewvskeyesnzqvCOTHB4Hw2C3+jRG5nExw0bDZJr81NwA
         7otV9NVuwbdhlMYxdPur4WXAiYN2ma9uKjBBAgKw2slv3J7U7JLZn9PyAaXe119LhDoU
         rGrRCYM3TGgxPj5enMA48t1yUIZ9N+569H5msbJglCtDcv98bBRHUxboX/l8CfScKdSa
         tNCQ==
X-Gm-Message-State: ACrzQf1PZIlSlS36qllZBXfGDrW6Q0geKlew65QjFUcj3SgvctDKZRzQ
        JV725F4Fg5ncqmRLUYCAqClfqA==
X-Google-Smtp-Source: AMsMyM6hu4kmwaALaxLHOKrZ+BvQpGrPeyRy9QzrgBkKAwnx9gDzRH3CslRjEFHCb3WjliopGPBLMw==
X-Received: by 2002:a17:90b:4a8f:b0:20d:2f93:3bb with SMTP id lp15-20020a17090b4a8f00b0020d2f9303bbmr18537027pjb.149.1665769356136;
        Fri, 14 Oct 2022 10:42:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r24-20020aa79638000000b00562eff85594sm2055790pfg.121.2022.10.14.10.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 10:42:35 -0700 (PDT)
Date:   Fri, 14 Oct 2022 10:42:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, ardb@kernel.org
Subject: Re: [PATCH V2 3/3] efi: pstore: Add module parameter for setting the
 record size
Message-ID: <202210141042.E4689636@keescook>
References: <20221013210648.137452-1-gpiccoli@igalia.com>
 <20221013210648.137452-4-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013210648.137452-4-gpiccoli@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 13, 2022 at 06:06:48PM -0300, Guilherme G. Piccoli wrote:
> By default, the efi-pstore backend hardcode the UEFI variable size
> as 1024 bytes. The historical reasons for that were discussed by
> Ard in threads [0][1]:
> 
> "there is some cargo cult from prehistoric EFI times going
> on here, it seems. Or maybe just misinterpretation of the maximum
> size for the variable *name* vs the variable itself.".
> 
> "OVMF has
> OvmfPkg/OvmfPkgX64.dsc:
> gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x2000
> OvmfPkg/OvmfPkgX64.dsc:
> gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x8400
> 
> where the first one is without secure boot and the second with secure
> boot. Interestingly, the default is
> 
> gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x400
> 
> so this is probably where this 1k number comes from."
> 
> With that, and since there is not such a limit in the UEFI spec, we
> have the confidence to hereby add a module parameter to enable advanced
> users to change the UEFI record size for efi-pstore data collection,
> this way allowing a much easier reading of the collected log, which is
> not scattered anymore among many small files.
> 
> Through empirical analysis we observed that extreme low values (like 8
> bytes) could eventually cause writing issues, so given that and the OVMF
> default discussed, we limited the minimum value to 1024 bytes, which also
> is still the default.
> 
> [0] https://lore.kernel.org/lkml/CAMj1kXF4UyRMh2Y_KakeNBHvkHhTtavASTAxXinDO1rhPe_wYg@mail.gmail.com/
> [1] https://lore.kernel.org/lkml/CAMj1kXFy-2KddGu+dgebAdU9v2sindxVoiHLWuVhqYw+R=kqng@mail.gmail.com/
> 
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

With the var length change recommended by Ard, yeah, looks good to me.
:)

Thanks!

-Kees

-- 
Kees Cook
