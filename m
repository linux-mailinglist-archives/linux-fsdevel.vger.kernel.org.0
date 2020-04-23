Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F074B1B5333
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 05:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgDWDmF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 23:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726002AbgDWDmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 23:42:05 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A767C03C1AA;
        Wed, 22 Apr 2020 20:42:05 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e6so1889303pjt.4;
        Wed, 22 Apr 2020 20:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6dQMHfeBacBwJMLmSY5DUMnEsFdGOS3CmUiYfT4KgF0=;
        b=JGmM6JKDbTONFrJRe9See27RegDlwxrdEZuIMaIPzy1PY3qv4rRy3fWUXW3vLHcii3
         5ycJdOxJpZR9aLc0u0M9lBYAYHuMWNL+w8NP8kMfpMZhbY93Y+4XCJpSt1/oab/oJOMS
         93xd0lC8U+q8ubqR3f8tacuaqnU/G/HWvMN/2mtztiRc4AOPSkF63s/kkOtykAvfdds9
         AxcGbHF5A5uRpNjxD8++/FmAROIoqYUuQ3YKkS3hHN2XpRVcf9annuvvrcHKijviAs8n
         xje51oP4NyzETyK8hZkmEoPfhhPqJoq+shcaWMGrl0Tqa+BAC0cTeyh1bDSe2GfsK8Ux
         +oLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6dQMHfeBacBwJMLmSY5DUMnEsFdGOS3CmUiYfT4KgF0=;
        b=pg+7TDNwqNlRNnHdCw5hirUtdCtVd7PVs1UJCizsJQc++rBfTSGtn5taXzBIhjGWJk
         TH5kq2UCyNfanKmawcxzMN0mIjSj93UIeLMxfb840Ma3vVMEqAOeWoVVWvepPgTl10o/
         Dec/JoJuJ8nRUwyb4xUKK+52NnpvIzL7AO9LmzvI9hJ4HurIzDS2XhX++TPkPuNaHLdz
         HKapeQuOD2ULyZXR2brgR6c1iTS7NUB8bUhAHtqdK5RU5XejbzH9ePZzs518tyWV4eUg
         uSb2luPN2t+gQSJdcxupTI8eZnDsj8YspGsbU5yOUu5pcJS60vMBtvnWGMz2tnOSIw4j
         rspg==
X-Gm-Message-State: AGi0PubR4kr8913Eqx3UpEqpGcgEI4ym+QhcQqVTciDD07YuZ+OjggWT
        5xLo6emCbHMIUfHJgRmfwVchlYC/
X-Google-Smtp-Source: APiQypLbHSJekuXcR7QyZDnfGmSetVxhk0+1wwtWC6xR8Xktz7g1M0GF3+ne/iSuxAlUDij07qHkwg==
X-Received: by 2002:a17:90a:ba09:: with SMTP id s9mr2133288pjr.20.1587613324188;
        Wed, 22 Apr 2020 20:42:04 -0700 (PDT)
Received: from localhost (146.85.30.125.dy.iij4u.or.jp. [125.30.85.146])
        by smtp.gmail.com with ESMTPSA id w16sm674566pgf.94.2020.04.22.20.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 20:42:03 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 23 Apr 2020 12:42:01 +0900
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk
Subject: Re: [PATCH 03/15] print_integer: new and improved way of printing
 integers
Message-ID: <20200423034201.GF246741@jagdpanzerIV.localdomain>
References: <20200420205743.19964-1-adobriyan@gmail.com>
 <20200420205743.19964-3-adobriyan@gmail.com>
 <20200420211911.GC185537@smile.fi.intel.com>
 <20200420212723.GE185537@smile.fi.intel.com>
 <20200420215417.6e2753ee@oasis.local.home>
 <20200421164924.GB8735@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421164924.GB8735@avx2>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On (20/04/21 19:49), Alexey Dobriyan wrote:
> 
> I did the benchmarks (without stack protector though), everything except
> /proc/cpuinfo and /proc/meminfo became faster.
> 

Why does /proc/cpuinfo and /proc/meminfo performance matter?

	-ss
