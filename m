Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCD850D660
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 02:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbiDYAtJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Apr 2022 20:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240032AbiDYAtF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Apr 2022 20:49:05 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E371C903;
        Sun, 24 Apr 2022 17:46:00 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id v2so2727496qto.6;
        Sun, 24 Apr 2022 17:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lUfRNFCLBP3uFMSuVP2gohDe8N80eyAcPJ7OERj4nyU=;
        b=Zhlu1wPjtycgm4h/SbFthtBn6M7XP5HH9QzvnlBs8/gkCnV1FfpIpmYLGTTiXqmfaZ
         b/XOB9GBUX7NsJJvw3DYcjZemRe4zK2AVq7vICdzvDbsG4y1qf6fcfsQThlXZJ+ZLhug
         Zgrjq3EiuyKsZKBr1Lqd5H7GfgD+LkCsu/E4fXYKQoQp+nOVDfl2TZdq1kSQlXYE+spq
         vKG9RSg8ClFj2el1cExDAPn9vMq3/2p9IbMttzTeQPZu/p7ZamPuJAVwpZWjuR9dJ7D2
         HrQvJZRxTSYMsO5a8HNmVB5VBZjns/lk1r/oV+p3m+ywT27uFdWXc9pL9M59NhtpuXbW
         hmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lUfRNFCLBP3uFMSuVP2gohDe8N80eyAcPJ7OERj4nyU=;
        b=UnsNH8S9kJlwQ19wAT2wuKjzwMImALqtRz3IDxGlz8rH5utNy6C4GfRCJ68nmATrO4
         n1HzryiSDDF3bGMte/LStQReZF77jE2OZU7Zh3NG4IF83ChHyRHFW5+6iiNZQ96MwW2e
         wqakNfzj7FFhRAUF3sjsRvtetAHDnky72UyutXSaEsQkhTsbWk6TkxBOiIoVfWoU4xYc
         F1pcX0cypwqBCBLCcnMBiNE+hWHzO+4Gw8lFXac1KDMCTctEnZDfFkeqVA2Nla3AeCfj
         o8Rm08D627OSbBpRuTmBjLuaZ5Pq+1eSEFQ+m5xNrEXzT2+ZHMwbHFb/99uJcnsRhqDy
         wfnQ==
X-Gm-Message-State: AOAM5326YgZUKi6PRCAjea7keeBeWAFTKuMS2bJP3b89MutP7iyA0H9d
        t0t74lLuCjnLmYb4RsrlkQ==
X-Google-Smtp-Source: ABdhPJyI5g4R5aAGDCwE3uoQfWTCQnIEklx2JnXGiFsOoOFU+YQFmrGStZwOa52FAmkfmSaAOohC8Q==
X-Received: by 2002:ac8:7d08:0:b0:2f1:e349:adb7 with SMTP id g8-20020ac87d08000000b002f1e349adb7mr10338487qtb.616.1650847559580;
        Sun, 24 Apr 2022 17:45:59 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id p13-20020a05622a048d00b002e1ce0c627csm5625644qtx.58.2022.04.24.17.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 17:45:58 -0700 (PDT)
Date:   Sun, 24 Apr 2022 20:45:56 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, hch@lst.de, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-input@vger.kernel.org,
        roman.gushchin@linux.dev
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
Message-ID: <20220425004556.psqcz3vxfhetuuak@moria.home.lan>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-7-kent.overstreet@gmail.com>
 <fcaf18ed6efaafa6ca7df79712d9d317645215f8.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcaf18ed6efaafa6ca7df79712d9d317645215f8.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 24, 2022 at 04:46:03PM -0700, Joe Perches wrote:
> On Thu, 2022-04-21 at 19:48 -0400, Kent Overstreet wrote:
> > This adds printbufs: simple heap-allocated strings meant for building up
> > structured messages, for logging/procfs/sysfs and elsewhere. They've
> > been heavily used in bcachefs for writing .to_text() functions/methods -
> > pretty printers, which has in turn greatly improved the overall quality
> > of error messages.
> > 
> > Basic usage is documented in include/linux/printbuf.h.
> 
> Given the maximum printk output is less than 1024 bytes, why should
> this be allowed to be larger than that or larger than PAGE_SIZE?

It's not just used there - in bcachefs I use it for sysfs & debugfs, as well as
userspace code for e.g. printing out the superblock (which gets pretty big when
including all the variable length sections).

> > + * pr_human_readable_u64, pr_human_readable_s64: Print an integer with human
> > + * readable units.
> 
> Why not extend vsprintf for this using something like %pH[8|16|32|64] 
> or %pH[c|s|l|ll|uc|us|ul|ull] ?

It'd be incompatible with userspace printf. I do like the way we extend printf
is the kernel, but I'm trying to make sure the code I write now is by default
portable between both kernel space and userspace. Glibc has its own mechanism
for extending printf, I've been meaning to look at that more and see if it'd be
possible to do something more generic and extensible that works for both.
