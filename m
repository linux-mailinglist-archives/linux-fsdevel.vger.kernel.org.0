Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A62D5F71B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 01:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiJFXWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 19:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbiJFXWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:22:47 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3F21142F0
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Oct 2022 16:22:37 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id h13so1992286pfr.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Oct 2022 16:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=g1tveFZfedJRKmUheQznerf6Pskn8Ec+0pnE+anIJb8=;
        b=L5aOrBkh3+n78eFegRtnQszamcjMZTp6MGvT0xj75b470QLF5yb8JjX70mGd0C9kMI
         MHhR9YfmJgb/anrjXOZMO9EEfazJCQN96mvwASCZ/7Vyq9yusZQ2icwehtL+m4GUX1EI
         3IZ6+hDnvCnsw8MW42rJ1Vnd0kzTKi6D9MYAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=g1tveFZfedJRKmUheQznerf6Pskn8Ec+0pnE+anIJb8=;
        b=FPA4jEe1hMM3sHRt2WFNWumqa3UFrgo0ycSxHrSM2ttxG8zhGrQ5UVk9ljaMUOAFU1
         OKUNfHS6LU5BR2r7VG8h9zzIDxL4gJ2m2z6Q/KxCrmRl/FDIot0gzAznDrYaSf869dHH
         5cvVPe0SUHpBAHXjAX86e+gIuVYwmC4lkVKjBOl7CmYbRSjDDjJ28ZmKTnXOaWKuXFTo
         dLESGVfsJYvfeWm5je/2kMAeKyU4morUEVObEV3BmxXKuWPF6QkzlRASxiazBYdFqAdg
         TBROx+h+qkeseUX8oM/+XYa0qaKfmk2237Jx+IhxrdyNVoxq2B/3b05fuWSzsVl95ZjH
         Zjfg==
X-Gm-Message-State: ACrzQf1g9x/hZ0CIzvBSI1tLRR0lqcw4WSTaAWC7jEgWgS7FuCFqKn00
        iv/Qb1GmRLGAaEO58otQ8CYCRw==
X-Google-Smtp-Source: AMsMyM5a7y/jhN2vpXPAWyI6GZtQSDq0nR3g1ZDrPQ/0H5gg9UL62eXOV0Ig9dE52/kftMddeQ9O2A==
X-Received: by 2002:a05:6a00:a83:b0:54a:e52e:9472 with SMTP id b3-20020a056a000a8300b0054ae52e9472mr1866458pfl.50.1665098556918;
        Thu, 06 Oct 2022 16:22:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id om3-20020a17090b3a8300b00200b12f2bf5sm7387273pjb.1.2022.10.06.16.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:22:36 -0700 (PDT)
Date:   Thu, 6 Oct 2022 16:22:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net
Subject: Re: [PATCH 6/8] MAINTAINERS: Add a mailing-list for the pstore
 infrastructure
Message-ID: <202210061616.9C5054674A@keescook>
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-7-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006224212.569555-7-gpiccoli@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 06, 2022 at 07:42:10PM -0300, Guilherme G. Piccoli wrote:
> Currently, this entry contains only the maintainers name. Add hereby

This likely need a general refresh, too.

Colin, you haven't sent anything pstore related since 2016. Please let
me know if you'd like to stay listed here.

Anton, same question for you (last I see is 2015).

Tony, I see your recent responses, but if you'd rather not be bothered
by pstore stuff any more, please let me know. :)

> a mailing-list as well, for archiving purposes.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> 
> Hi Kees / all, not sure if up to me doing that (apologies if not) and
> maybe fsdevel is not the proper list, but I think worth having at least
> one list explicitely mentioned in MAINTAINERS in order people use that
> as a pstore archive of patches. If you prefer other list, lemme know.

I think that's a reasonable guess! :) Thanks for reminding me about
this. I think I'd rather use linux-hardening@vger.kernel.org, since
we've got a patchwork configured. It's not a _totally_ unreasonable
topic to have there. ;)

-- 
Kees Cook
