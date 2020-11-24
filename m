Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6C42C1E49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 07:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgKXGdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 01:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgKXGdn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:33:43 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76EFC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 22:33:43 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id x15so10185190pll.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 22:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RnuaPlkufKE3bJ/+cfsWhjGgUTnQEoo85iF+YTP34+g=;
        b=mpe/jYOxFHJV9jweJ8TUUczl8ZsmbzIIZDKC/OCi20wPsgN6d23oekxFXcgQ5s2r2u
         O5p3EvsA3J9QbF8gmTQvJihaJcGm8J3ZK6yi+MlDOQ6TsUs9EY6qYGEKNnkuHovcWAjH
         reCXkmbln0Hg57q8fRJsUtXbTTCpFQzN/LhOSgp3rX2ed1uzPsQH3WNrfogj1zMZaKKL
         QW14n23t6ljjqviztUURcng8G8+P1DCs9aydIeVHwfipqN5toylQd2Z8t1KKqIteylrU
         F4MJqbXq0qd1UcVkbtgC3TJDW+fjAeWdOiMOjTY1n0KFjmRXS8aBDmVcOHkUlgCzI/2w
         kazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RnuaPlkufKE3bJ/+cfsWhjGgUTnQEoo85iF+YTP34+g=;
        b=ebdEn8Cm1w3wpATj6KVMss8i9yQ/4rpm2dPqhII1SDQiGGWwPt6kSQOv/cRe3wUK0N
         tSuQjKzekMi9OGStA3X0IhSAXPtrPfQ4iConEFWWQBdYYgmqfN0xkWbhueSa7rwkWIyj
         25WLxBZefVf98zoDom/H93cuotl3bWCsVUZnOiRYbzAXRjJmxIwsPd9UplI9oP3KheZS
         xWSOASMLNFp0kULEYvQWhwM5E7LTYyPqpFvK9z71whWlEvuSuyWQ8j5QO7pBxBaJanGb
         IP7jzW63H5sJpML5pO0fYtKyHqE2njR+WUT2J96iAGsoXJ0dE9XEmRb8qJiSCz9eO//n
         UTMw==
X-Gm-Message-State: AOAM531AjEHE1e9//WyZD2NyFjkEZS+lFXLydikCd9ODecPAtNE2MmM9
        OG26V8n/ot7X8k1m8kXiva3Vqw==
X-Google-Smtp-Source: ABdhPJz+1PCmKeOfD3/EDQ8KaHO6w4120PT6JVez8E9GzD+4FU2l8IgSvqj1A3IcUoylTtsiBPw0tw==
X-Received: by 2002:a17:902:ec01:b029:da:13f5:1aaa with SMTP id l1-20020a170902ec01b02900da13f51aaamr2787834pld.0.1606199623356;
        Mon, 23 Nov 2020 22:33:43 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id 14sm4916811pfz.54.2020.11.23.22.33.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 22:33:42 -0800 (PST)
Date:   Tue, 24 Nov 2020 12:03:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        anmar.oueja@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcookies: Make dcookies depend on CONFIG_OPROFILE
Message-ID: <20201124063340.2dvb6ou63hf5ecn3@vireshk-i7>
References: <51a9a594a38ae6e0982e78976cf046fb55b63a8e.1603191669.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51a9a594a38ae6e0982e78976cf046fb55b63a8e.1603191669.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20-10-20, 16:31, Viresh Kumar wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The dcookies stuff is used only with OPROFILE and there is no need to
> build it if CONFIG_OPROFILE isn't enabled. Build it depending on
> CONFIG_OPROFILE instead of CONFIG_PROFILING.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [ Viresh: Update the name in #endif part ]
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  fs/Makefile              | 2 +-
>  include/linux/dcookies.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Alexander,

Ping for picking up this patch for 5.11. Thanks.

-- 
viresh
