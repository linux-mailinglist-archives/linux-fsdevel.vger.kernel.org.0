Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D3C3649AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 20:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbhDSSPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 14:15:48 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:42877 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbhDSSPr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 14:15:47 -0400
Received: by mail-pj1-f53.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so19010275pjv.1;
        Mon, 19 Apr 2021 11:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E3rIMclvEym376ZNjO3GoUMJO/w6CLT2wQYLHWQpxtQ=;
        b=K778rGWdQ3gPgMD4ABSxmlT+rOJ+X2qVsp2LOGfwRmPnpyJxv9jSPov3897Ndx8NHI
         3D1EZBf5/ouSNlouZO+1Tah2D1D2QIsYDEil97WJOMqNVpGvfZJ06XHvEbyBdMy+Gk0X
         rWqcrqrIS3TmZYlGGmypapbkr5A2NKT3jX+bTAjrRvocC+BwpwF18IVG1FQGhhHvso84
         q6CkrKhwfAC3lCqnT7VOaZHL2sB6UhmURXH+fa1wuKN5xP0phF121csm9oSugt8IZ0vz
         qW+ZSGcVrKX5wzlH5uIkIqc8MA4+/hhwwL1f/3EiXokKeCmHagqsKhKHZRujgMTheoG0
         ceSw==
X-Gm-Message-State: AOAM530JfxYEm+HiPH3/RIYM6IHM+jL8nKusSfyHWauIoyFVZuMIdxZ9
        M7Ldo3jh+feDuVjYze7bsRI=
X-Google-Smtp-Source: ABdhPJyKDzN/Cja3VJihuO6HHMkxLGcRebao2eSuVNaSaOmFppZd/gb1Ap7nadpk3RwDUWcEmJ5Vdg==
X-Received: by 2002:a17:90a:e00a:: with SMTP id u10mr350108pjy.137.1618856116435;
        Mon, 19 Apr 2021 11:15:16 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id ck5sm146841pjb.1.2021.04.19.11.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 11:15:15 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 057C7403DC; Mon, 19 Apr 2021 18:15:15 +0000 (UTC)
Date:   Mon, 19 Apr 2021 18:15:14 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        jeyu@kernel.org, ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs/kernel_read_file: use
 usermodehelper_read_trylock() as a stop gap
Message-ID: <20210419181514.GM4332@42.do-not-panic.com>
References: <20210416235850.23690-1-mcgrof@kernel.org>
 <20210416235850.23690-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416235850.23690-3-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 11:58:50PM +0000, Luis Chamberlain wrote:
> The endless wait for the read which the piece of hardware never got
> stalls resume as sync calls are all asynchronous.

Sorry, this should read:

The endless wait for the read, which the piece of hardware never got,
stalls resume as all pm resume calls are serialized and synchronous.

  Luis
