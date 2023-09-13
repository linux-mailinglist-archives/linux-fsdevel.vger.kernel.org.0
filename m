Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB4079F4BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 00:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjIMWJl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 18:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjIMWJk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 18:09:40 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7801173A
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 15:09:35 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4135f97435eso1473141cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 15:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694642975; x=1695247775; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYRxBFgVFD3g7dMotvqFon+/Ds8u8KlVSqggHQwswao=;
        b=Pa2un/WC1bOm0UN0Z3XNjiAr8HUGxknCiskMXKrD8bx4A7lZUuyX88+FLfdcBHg+if
         nb4NZBhsKuw7pw1HC9rUq8eNoRxSdhruL/P5lGU+zSlGHKlK3a5ppAM96uVkj4JIZe4g
         +ilUrL1Jdhi8UD0aBb5o5wMLmJ1YwxkUrB2JHN38nL6jr6rGTXRfvc/ZYO/v8uNGtmG9
         NyzP4iGSkre/+8S/8bm6z5lWGmP/zL0da17ylHKxV3qU2Vq/UFcuHyLzfuASn9bxbLaT
         SWrPeryeIkiTQu205Bn6A9mHNQR36277Yy03vx5tFBYavEWdhDVY9WdAD1t/gQEDTxVZ
         BlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694642975; x=1695247775;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYRxBFgVFD3g7dMotvqFon+/Ds8u8KlVSqggHQwswao=;
        b=wb7/eqSHu3Rc0c2cz1L973Rf4Anf5PAJOHwdnu+rIaMXZcEBZjCGXlEyzgmmd1cB3x
         msYkrsS/DiwmCOnyDqhmiCXK08svTlEi2ci4+XDAwLzhd8PKrg2fmkNd2/rWnxPcn2pH
         L7pGsiWXEB29Za0P/dYLTHVTQrBX6vZccOXLeu6vA+rlwfwpWn0Ec0wMPXUobt617kS6
         +CCk4MTQcWLJmNJlN9CqoRoApVlo6xmuPa5Rf4wgHAtqzat1CZlt6eRAijUmwBW8F1cl
         gVeIjWqmJTClxTtUJYG+aRsomMuCdvfJBzcTZLzpxD8LPM3pM/16zb5e4KcsmD6W3u/C
         rfpg==
X-Gm-Message-State: AOJu0YxqJEV6o43YEXlwbXewrHDwXywvlPJp+/9Z0Einqs2l9/1oAYXo
        sFlTSQzbOogjHd1f9Y0R9qai
X-Google-Smtp-Source: AGHT+IFfuUvflJnphRC6dw5Z435IV8TEDBTv8LxO/Jl0qaQJY71C0u+HDCAIS7pUDDTh0TOR1XAMdg==
X-Received: by 2002:a05:622a:50b:b0:403:b645:86fa with SMTP id l11-20020a05622a050b00b00403b64586famr4449573qtx.24.1694642974893;
        Wed, 13 Sep 2023 15:09:34 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id iw10-20020a05622a6f8a00b004033c3948f9sm68689qtb.42.2023.09.13.15.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 15:09:34 -0700 (PDT)
Date:   Wed, 13 Sep 2023 18:09:33 -0400
Message-ID: <4a94978e8cc264e51af6ed6c798407a3.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, ztarkhani@microsoft.com,
        alison.schofield@intel.com
Subject: Re: [PATCH] lsm: constify 'file' parameter in  security_bprm_creds_from_file()
References: <ZOWyiUTHCmKvsoX8@gmail.com>
In-Reply-To: <ZOWyiUTHCmKvsoX8@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Aug 23, 2023 Khadija Kamran <kamrankhadijadj@gmail.com> wrote:
> 
> The 'bprm_creds_from_file' hook has implementation registered in
> commoncap. Looking at the function implementation we observe that the
> 'file' parameter is not changing.
> 
> Mark the 'file' parameter of LSM hook security_bprm_creds_from_file() as
> 'const' since it will not be changing in the LSM hook.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  include/linux/fs.h            | 2 +-
>  include/linux/lsm_hook_defs.h | 2 +-
>  include/linux/security.h      | 6 +++---
>  security/commoncap.c          | 4 ++--
>  security/security.c           | 2 +-
>  5 files changed, 8 insertions(+), 8 deletions(-)

Merged into lsm/next, thanks!

--
paul-moore.com
