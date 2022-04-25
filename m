Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E3A50D88D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 06:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241126AbiDYFCR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 01:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiDYFCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 01:02:16 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4956978FF9;
        Sun, 24 Apr 2022 21:59:13 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id q75so10021902qke.6;
        Sun, 24 Apr 2022 21:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pSukWVNGPbvvDWRYYpnXyrBGvwe1aXrP5QQgJkPMdVI=;
        b=S+lSy7A3THos14AgWwYUhUbTtHHIhcf4GWI0EjMIVJqfj+HMA1PSWkZsxEE6DRORPK
         OFwk1d83zus7ZFDg7zpgA6HYDiTKf2wu32GYcgY8KYtZP0vjGptOWxXFYPTrvG1AxVKL
         hh3QWRUY4uMPm3dpjm00+fGF5IPZo7TYfKnm5ZZWwH+w8d0+ghqiDBnbv13d1qM4gID/
         XeW52sl1UZeuJelhlIGM9GSHxAi4UfGUHXPMnpEEkBQmIyycZRFOJ1TpS7qnx6r55bgj
         RbKNEvNb9EVGfR2nFUNDlUv4+csSMheFroBGfuVH2zUtJoo2O0k4f29LJ0csQYIyGWiU
         7Vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pSukWVNGPbvvDWRYYpnXyrBGvwe1aXrP5QQgJkPMdVI=;
        b=L5PMSJd/NXC0CreoC5ttvv70LWehrBSWjbjKSkzwUyLuvF7S9+LiuLVkeHJSJNojO+
         l3PAykh3yo+JsmRCMMpdqtb8C89K2bzl4LapphZxcWj1R2OnkYCRCOp/wk3zYT/lBQP2
         C/yer42hvtmfyYw+DFkUG1WV/AW6Zd87E3l+1PfVe2ASoc1i7kEiywFMrkwO/O23Yd20
         TFvhCwkwVtukWEortv4qHSYu3TqlCnn0IUiH31HCG1t0c2SvvrbqRq540hep94V+VgFe
         +EtBtzEBiKk3m7ORUeoqSUjqfPw8M/zhARMOZmY0VSbP5zoQZ27L3uBlpA58ALNe9Mpn
         Ee6w==
X-Gm-Message-State: AOAM5338enxww7yLMJ+XdClDNwcOTS9ncevY1/pKCGhhwYXn7VYQMd2R
        ZLl5sNIcF/DUERoRD9VcyA==
X-Google-Smtp-Source: ABdhPJz499iKvGAO1H+puguUs+FjSsq3HVaZw0VTq9jfiHVoze5DHdtt1PeDom1pLChe+x0pWUpMog==
X-Received: by 2002:a05:620a:170d:b0:69e:d1bf:429d with SMTP id az13-20020a05620a170d00b0069ed1bf429dmr9155100qkb.750.1650862752099;
        Sun, 24 Apr 2022 21:59:12 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id b84-20020ae9eb57000000b0069c8ca73b94sm4466922qkg.115.2022.04.24.21.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 21:59:11 -0700 (PDT)
Date:   Mon, 25 Apr 2022 00:59:09 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
Message-ID: <20220425045909.rhot6b4xrd4tv6h6@moria.home.lan>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-7-kent.overstreet@gmail.com>
 <fcaf18ed6efaafa6ca7df79712d9d317645215f8.camel@perches.com>
 <YmYLEovwj9BqeZQA@casper.infradead.org>
 <20220425041909.hcyirjphrkhxz6hx@moria.home.lan>
 <9ab6601364a16c782ca36ab22a2c67face0785a7.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ab6601364a16c782ca36ab22a2c67face0785a7.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 24, 2022 at 09:48:58PM -0700, Joe Perches wrote:
> On Mon, 2022-04-25 at 00:19 -0400, Kent Overstreet wrote:
> > On Mon, Apr 25, 2022 at 03:44:34AM +0100, Matthew Wilcox wrote:
> > > On Sun, Apr 24, 2022 at 04:46:03PM -0700, Joe Perches wrote:
> > > > > + * pr_human_readable_u64, pr_human_readable_s64: Print an integer with human
> > > > > + * readable units.
> > > > 
> > > > Why not extend vsprintf for this using something like %pH[8|16|32|64] 
> > > > or %pH[c|s|l|ll|uc|us|ul|ull] ?
> > > 
> > > The %pX extension we have is _cute_, but ultimately a bad idea.  It
> > > centralises all kinds of unrelated things in vsprintf.c, eg bdev_name()
> > > and clock() and ip_addr_string().
> > 
> > And it's not remotely discoverable. I didn't realize we had bdev_name()
> > available as a format string until just now or I would've been using it!
> 
> Documentation/core-api/printk-formats.rst

Who has time for docs?
