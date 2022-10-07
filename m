Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8905F7DFE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 21:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJGTci (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 15:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGTch (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:32:37 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8832B27E
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Oct 2022 12:32:36 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id bh13so5494238pgb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Oct 2022 12:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWIDooZIJ21SaT4AaqXCKaAk3JRTLPG/RdiaYdE09z4=;
        b=nk0Tk/QQ8LsMSXY4egtXKpDJkrjrsNQTmEQ/ZfXiJaiybsz4nAiGpOPR1C9VlTXXEt
         lHrnJrqLxWHOIeEz2rIH9+ZlMj0lDCMoaSyrLqdtMox25q2ra6VHiwIDbhqbq/RhAseb
         wvOUzyqGhNBWllIJOgsM6OoVunnb/vvbUIeTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWIDooZIJ21SaT4AaqXCKaAk3JRTLPG/RdiaYdE09z4=;
        b=KW4vceg36vklKaoA3AlZvmjkjWxmcTkxCxMzG2hy83//n3fj2KB3pjbrHc4mI2wGfc
         hfY/ltKyDy4tLnY4qbrNv+kolK1xjCxmkt686O9V92sb8vo9byIUYkg6GrwqpWcgA4Zd
         IJd0GR36uN2SwqcKvqa2Nr55br/fbHMpPlLLEZD5D6mY6zyNE6HoyCWXl+JoR/JU+nnO
         TZakPyN8fEKzdgiMyzNYCWYGd+ghuZTW7/7qQ2JnNuWThzyj2xGwRcPatM6ENXNZyGDC
         mfyCasxR7Kwm82pGUCOMxY89O8exKj+WT13zF++ZnewUI4/pI5xy+VVecCPan48HzSjO
         J8zQ==
X-Gm-Message-State: ACrzQf2zVOMtnNZ61NqlL1G9WQkX0pFscxbhwZ0sBmTTucVigffHX0pW
        f0U+DDQGw/80hDl99dVJ6XqU9A==
X-Google-Smtp-Source: AMsMyM5QxZLYI3xdVdaU5MDoEnFyFHpC35HOwHxRuSbTrqtqKdU+tM5qMxxnNfuMWHrjs5R+580dXg==
X-Received: by 2002:a63:145d:0:b0:44b:f115:f90f with SMTP id 29-20020a63145d000000b0044bf115f90fmr6036831pgu.157.1665171155674;
        Fri, 07 Oct 2022 12:32:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e6-20020a656886000000b0043b565cb57csm2064059pgt.73.2022.10.07.12.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 12:32:35 -0700 (PDT)
Date:   Fri, 7 Oct 2022 12:32:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, linux-efi@vger.kernel.org
Subject: Re: [PATCH 8/8] efi: pstore: Add module parameter for setting the
 record size
Message-ID: <202210071230.63CF832@keescook>
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-9-gpiccoli@igalia.com>
 <202210061614.8AA746094A@keescook>
 <CAMj1kXF4UyRMh2Y_KakeNBHvkHhTtavASTAxXinDO1rhPe_wYg@mail.gmail.com>
 <f857b97c-9fb5-8ef6-d1cb-3b8a02d0e655@igalia.com>
 <CAMj1kXFy-2KddGu+dgebAdU9v2sindxVoiHLWuVhqYw+R=kqng@mail.gmail.com>
 <2a341c4d-763e-cfa4-0537-93451d8614fa@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a341c4d-763e-cfa4-0537-93451d8614fa@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 07, 2022 at 10:45:33AM -0300, Guilherme G. Piccoli wrote:
> On 07/10/2022 10:19, Ard Biesheuvel wrote:
> > [...]
> > 
> > OVMF has
> > 
> > OvmfPkg/OvmfPkgX64.dsc:
> > gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x2000
> > OvmfPkg/OvmfPkgX64.dsc:
> > gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x8400
> > 
> > where the first one is without secure boot and the second with secure boot.
> > 
> > Interestingly, the default is
> > 
> > gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x400
> > 
> > so this is probably where this 1k number comes from. So perhaps it is
> > better to leave it at 1k after all :-(
> > 
> 
> Oh darn...
> 
> So, let's stick with 1024 then? If so, no need for re-submitting right?

Given OVMF showing this as a max, it doesn't seem right to also make
this a minimum? Perhaps choose a different minimum to be enforced.

Also, can you update the commit log with Ard's archeology on
gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize ?

-- 
Kees Cook
