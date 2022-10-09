Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535D85F8BE0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Oct 2022 17:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJIPMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Oct 2022 11:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiJIPMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Oct 2022 11:12:14 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4883027B16
        for <linux-fsdevel@vger.kernel.org>; Sun,  9 Oct 2022 08:12:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f23so8431515plr.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Oct 2022 08:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2hBQdaFyitVR4o7VAQhi1z5vf0SoViuC4mH8i4th+A=;
        b=JToBOpJUcGPwEp0K/SG/cfexHuQEzvqjNItWRsyrhrfn0i9LV+adrin+Tz9xESErUK
         5+fnkZWHpewPVUp4rz54yojsMWsOxmncmUhd6noH5Dgc9B5sJ2KK3BZmGZIlAW1KNhiX
         4JTXBxMb2p8kDI87YFLMY7Vs7/rYyWcHrBXBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2hBQdaFyitVR4o7VAQhi1z5vf0SoViuC4mH8i4th+A=;
        b=L7doZTXshnGcLf7AVYSaYGTqXp0+KirLf8DHmUi1X5cygKV4ydqjTULOE9URh1nABa
         EkMwPLrp18vO+trxt+6zk1XH0mXqkSAqcia0RhqCvL9GhPbNYvNE5N4yGXITfu/xOGun
         qBrpDAaO8LA3VSGSp1AHLhjU+JmHwzH3+shMgTUi8ATuQGlaWLCbGi3YYiaX7QZO3hjN
         LXR1cPoQXme6CInhPx2Tiwt+WhsOhYVaxPT24J4k7pn0I+BRK1e7vuGdiTETfVdinrik
         7772ARrTgQ0o8ZlfY8ZvCzn4xKN030hIKnZnIFWwJulgN4Jwa89nwveYbqqGJ9fEMBbF
         D58Q==
X-Gm-Message-State: ACrzQf1/zfQV2/UKzdPoCA5W+YbuuKk7fbazoY12DdgonG7yY6gtOjDp
        5AmscN8e+VnwLFRVX0NhBfK+xQ==
X-Google-Smtp-Source: AMsMyM59yi9b9fPwsKMyrqyI+LdLnFv6GH5a1TuUrCzG1uUibfL64xbFDmAt64nP0dHQaIogGkxA8Q==
X-Received: by 2002:a17:902:f602:b0:178:9818:48a4 with SMTP id n2-20020a170902f60200b00178981848a4mr14430380plg.148.1665328332721;
        Sun, 09 Oct 2022 08:12:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902ea0f00b0016d72804664sm4853779plg.205.2022.10.09.08.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 08:12:12 -0700 (PDT)
Date:   Sun, 9 Oct 2022 08:12:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Li zeming <zeming@nfschina.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: Remove =?utf-8?Q?unneces?=
 =?utf-8?B?c2FyeSDigJhOVUxM4oCZ?= and '0' values
Message-ID: <202210090811.3C43AC2BF@keescook>
References: <20221008093026.4952-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221008093026.4952-1-zeming@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 08, 2022 at 05:30:26PM +0800, Li zeming wrote:
> Remove unnecessary initialization assignments, which are used after the
> assignment.

They don't hurt anything, and in fact show the intent of the initial
variable state. Additionally, the compiler will drop it once it finds
the later assignment.

-Kees

-- 
Kees Cook
