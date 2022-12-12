Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA02E64A8D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 21:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiLLUmW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 15:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiLLUmV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:42:21 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E09E1836D;
        Mon, 12 Dec 2022 12:42:20 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j4so1591921lfk.0;
        Mon, 12 Dec 2022 12:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yi/YU2j+x5BuBXWGZECLyVNnhDuHpoWKcj/4vAm5ZMM=;
        b=oOgV5/nZXIJ7z3WGB87na/XQqphJaBwH31shYnYLgVsAkqnqGP9ANCU8XxSaVepA3F
         H5X6wyIooFT+gM+QZRt1Sm3wMYug0br0sLn7OFHe7iIMjLzg+BD12k1r3o/na5erZ191
         0U66+aW0w5kiobDV5Oc29ktK46VRPYzF9EJV9v7EWzTlaNtdFmWSsNMHn0QYapxi7m2p
         D+hVIRibo7AOXbOIeHegP/A+wGZNFWMZea35DYiIfEZIarlhOoS61h68gyDvnfWY1CYe
         wA09vaJyJFG7lGRLshcP4MGm4Oa2oC7v7kYK8ubAfqf0IOel2jbtKYpaQGnEMIAcMi+H
         0Ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yi/YU2j+x5BuBXWGZECLyVNnhDuHpoWKcj/4vAm5ZMM=;
        b=iVRmgA34Cs+wFW0G5X5yVLkL9xlKKO5TJZYiM9HF578d3ow/hfJfGeFEfXMq025zFU
         RjPU/vPuWplUiacexkcZGn4PBCCnmKoihQtNl+67YvaY8MtgHcUtZhGPtqetKPgHXP6D
         OakCdOKeDLP4rVGnkgWpvfx20oqolYEV9QY5Fn0RWQeDl2D53v9vGVkkkWmcwv/VDn2P
         rEcV15dx+t2Z+C6xly21juU3yCvmEwO3lErVCq3N8lBJGd7MQ7oywJ4L6wbVznV2iFJl
         Kw48qxjXRP9F2b7I9VwbSQZylpEWMtzzM4C0fbEIjzRo5vWOwImPU8AXxUy8zuLTUg3W
         n38A==
X-Gm-Message-State: ANoB5plp8CPYs0mX0wgnmByYhXkKO9FwE0FCOuyoOxp0ry2iv9WVHvjV
        Pa6J6EpmPxJhyIR7fozKpPM=
X-Google-Smtp-Source: AA0mqf7cXS2euKC0ZOav0ITrVzUpkE7E7dSgVR8pY+Nwymn7QVy/xAXhgqPGVfX4UK1gsbQPsCEu4w==
X-Received: by 2002:a05:6512:281d:b0:4b0:38f1:1266 with SMTP id cf29-20020a056512281d00b004b038f11266mr6251017lfb.34.1670877738553;
        Mon, 12 Dec 2022 12:42:18 -0800 (PST)
Received: from grain.localdomain ([5.18.253.97])
        by smtp.gmail.com with ESMTPSA id s16-20020a05651c049000b00279ee47099dsm81671ljc.116.2022.12.12.12.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 12:42:17 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 46A275A0020; Mon, 12 Dec 2022 23:42:16 +0300 (MSK)
Date:   Mon, 12 Dec 2022 23:42:16 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zach O'Keefe <zokeefe@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list : PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list : MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Paul Gofman <pgofman@codeweavers.com>
Subject: Re: [PATCH v6 2/3] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Message-ID: <Y5eSKBJ9hTtw9cbK@grain>
References: <20221109102303.851281-1-usama.anjum@collabora.com>
 <20221109102303.851281-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109102303.851281-3-usama.anjum@collabora.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 09, 2022 at 03:23:02PM +0500, Muhammad Usama Anjum wrote:
...
> +
> +static long do_pagemap_sd_cmd(struct mm_struct *mm, struct pagemap_scan_arg *arg)
> +{
> +	struct mmu_notifier_range range;
> +	unsigned long __user start, end;
> +	struct pagemap_scan_private p;
> +	int ret;
> +
> +	start = (unsigned long)untagged_addr(arg->start);
> +	if ((!IS_ALIGNED(start, PAGE_SIZE)) || (!access_ok((void __user *)start, arg->len)))
> +		return -EINVAL;
> +
> +	if (IS_GET_OP(arg) &&
> +	    ((arg->vec_len == 0) || (!access_ok((struct page_region *)arg->vec, arg->vec_len))))
> +		return -ENOMEM;
> +
> +	if (IS_SD_OP(arg) && ((arg->required_mask & PAGEMAP_NONSD_OP_MASK) ||
> +	     (arg->anyof_mask & PAGEMAP_NONSD_OP_MASK)))
> +		return -EINVAL;
> +
> +	end = start + arg->len;
> +	p.max_pages = arg->max_pages;
> +	p.found_pages = 0;
> +	p.flags = arg->flags;
> +	p.required_mask = arg->required_mask;
> +	p.anyof_mask = arg->anyof_mask;
> +	p.excluded_mask = arg->excluded_mask;
> +	p.return_mask = arg->return_mask;
> +	p.vec_index = 0;
> +	p.vec_len = arg->vec_len;
> +
> +	if (IS_GET_OP(arg)) {
> +		p.vec = vzalloc(arg->vec_len * sizeof(struct page_region));
> +		if (!p.vec)
> +			return -ENOMEM;
> +	} else {
> +		p.vec = NULL;
> +	}

Hi Muhammad! I'm really sorry for diving in such late (unfortunatelly too busy to
step in yet). Anyway, while in general such interface looks reasonable here are
few moments which really bothers me: as far as I undertstand you don't need
vzalloc here, plain vmalloc should works as well since you copy only filled
results back to userspace. Next -- there is no restriction on vec_len parameter,
is not here a door for DoS from userspace? Say I could start a number of ioctl
on same pagemap and try to allocate very big amount of vec_len in summay causing
big pressure on kernel's memory. Or I miss something obvious here?
