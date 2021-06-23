Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80293B1906
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 13:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhFWLfs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 07:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhFWLfq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:35:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847E2C061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jun 2021 04:33:27 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j2so2222664wrs.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jun 2021 04:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thinkparq-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bj747uplRrTs64it4budPydOYdAWYjcoNovrzue1pxI=;
        b=h97WCtGx9WLESuhTBSrx9yV7D6lSHMa2rb2NSCr5bLABZjsaXqUCYLGhWq+l1FxAnx
         uHrUkliAemtw6lXCODJbW3Nyd9VgP5ctsJaQlFxlADvXEtT6UtlQfkI0QFoilDsz+mb/
         eWdp/9RnMbkkheIBFnCk7g19nNWf1pM1Zu65KETRZCpyaTSNQChLYnjXT0Y7CAONCKQQ
         ab36RjK425cezI8acrpAwW+bKjICzS9jZeTuD3b6ZXqk3RzWaNlJIUdUxCzqCxohaJwi
         CX1SYiR68VROy056XKdx852XqgJ4B7u1YKAALucS6pb0qkFCoYBdm2DGo6zoN17A53Dd
         GgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bj747uplRrTs64it4budPydOYdAWYjcoNovrzue1pxI=;
        b=fJAqZxvNAC9k2J0qC03zumkPrYHwGvcXVe1OoXepaIucOUcavZHYLwCxW0iu/nJkNd
         j2n4kIsM0xMnUCTfYK5PcVSRcccLJBuQyGg2wVLTXATnu0Nn+51PmybdCVY6gpGkwVhM
         Nvqx5smWaIV2pCZ1Rq/4CtRHMqfDMm2a0wmybZ+qVhl6bi/34OjeJxeH/HPjU3ozH60P
         p+vkvfR5QSSERreqDU2nxPG1+Snj5O1bBlzbMvmkbUlsQJvziTg45+gXzLJ/tT6/FrdS
         kZBVh9izwEcXaE0x6SdCo2K7KUWFQagXOKFz2zc7rXtGOcpMXBiYBbWsrvriu59+vYzF
         HQKA==
X-Gm-Message-State: AOAM532lXFQLpPl78mofJoCjL5ofLUDsteSIwhVOLBFGtQamg4ttA2HQ
        xhUrRMpo0vFK67l2aYfZ5Z4sYBZADkILa7R1
X-Google-Smtp-Source: ABdhPJztDb5/9mH+N9870Cr5gld/asfcOyFubg5m9FJABLQJ59nTtcDY8KP4+Aai/YLfZidOpLvCLA==
X-Received: by 2002:adf:e502:: with SMTP id j2mr10598667wrm.275.1624448005901;
        Wed, 23 Jun 2021 04:33:25 -0700 (PDT)
Received: from xps13 (HSI-KBW-095-208-248-029.hsi5.kabel-badenwuerttemberg.de. [95.208.248.29])
        by smtp.gmail.com with ESMTPSA id x1sm5287000wmc.31.2021.06.23.04.33.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 04:33:25 -0700 (PDT)
Date:   Wed, 23 Jun 2021 13:33:23 +0200
From:   Philipp Falk <philipp.falk@thinkparq.com>
To:     linux-fsdevel@vger.kernel.org
Subject: Re: Throughput drop and high CPU load on fast NVMe drives
Message-ID: <YNMcA2YsOGO7CaiP@xps13>
References: <YNIaztBNK+I5w44w@xps13>
 <YNIfq8dCLEu/Wkc0@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNIfq8dCLEu/Wkc0@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Matthew Wilcox <willy@infradead.org> [210622 19:37]:
> Yes, this is a known issue.  Here's what's happening:
>
>  - The machine hits its low memory watermarks and starts trying to
>    reclaim.  There's one kswapd per node, so both nodes go to work
>    trying to reclaim memory (each kswapd tries to handle the memory
>    attached to its node)
>  - But all the memory is allocated to the same file, so both kswapd
>    instances try to remove the pages from the same file, and necessarily
>    contend on the same spinlock.
>  - The process trying to stream the file is also trying to acquire this
>    spinlock in order to add its newly-allocated pages to the file.
>

Thank you for the detailed explanation. In this benchmark scenario, every
thread (4 per NVMe drive) uses its own file, so there are reads from 64
files in flight at the same time. The individual files are only 20GiB in
size so the kswapd instances must handle memory allocated to multiple files
at once, right?

But both kswapd instances are probably contending for the same spinlocks on
multiple of those files then.

> What you can do is force the page cache to only allocate memory from the
> local node.  That means this workload will only use half the memory in
> the machine, but it's a streaming workload, so that shouldn't matter?
>
> The only problem is, I'm not sure what the user interface is to make
> that happen.  Here's what it looks like inside the kernel:

I repeated the benchmark and bound the fio threads to the numa nodes their
specific disks are connected to. I also forced the memory allocation to be
local to those numa zones and confirmed that cache allocation really only
happens on half of the memory when only the threads on one numa zone run.
Not sure if that is enough to achieve that only one kswapd will be actively
trying to remove pages.

In both cases (only threads on one numa zone running and numa bound threads
on both numa zones running) the throughput drop occured when half/all of
the memory was exhausted.

Does that mean that it isn't the two kswapd threads contending for the
locks but the process itself and the local kswapd? Is there anything else
we could do to improve that situation?

- Philipp
