Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EE1342E97
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 18:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhCTRU2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 13:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhCTRUN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 13:20:13 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0001C061574;
        Sat, 20 Mar 2021 10:20:12 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x26so8089305pfn.0;
        Sat, 20 Mar 2021 10:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pn3EpVCjCb+QJM6LLjzL2zV3hlQHkLh8MmLlzXPa6ew=;
        b=mjElOV/tUoZZfqlxr5PYrlUHtBGYtmEFe3uTjgOEey8Lh6EDt3FV/hnm/l2v9znfl/
         zN331omIg4XDf8rqu0WDCZ4nwuZS1AFGGTLschgJji3EXekslsB+ZE8AYABAJBILSFAc
         U8zJxgHEI0GmJKzxWI4PjnaMAZCBShAvkasY39yG/FKTWzzwwIsvUFb79RKpe08YnbZc
         QapQnBQWV73f3RWsYy73bqmEMMFAh0EjUSo334ii9eU4q1qItRykw1Tf5qHidGZdabh2
         jFg2dr/dY2bFZXmGNW0lHu8lYZG2NTMOA1XgjMeph+FEejppx8cFn7K+9xHgOocU9PNT
         TU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Pn3EpVCjCb+QJM6LLjzL2zV3hlQHkLh8MmLlzXPa6ew=;
        b=OTBSisE22i3ZlxMVgzhbG6ujFY7E0BB6ZTVFzZW1dUZoyab207J5tDr54W4oTA8EZu
         VdA5BpZe24WywDHFvSLVtZLXxuAHl05zCQSQ0DVXXieX1TaNzKOvqKtfXiHs2/m8phQS
         fy/GF56On90anpNq7hUcSUHeg4pTXC+6cQ/7B/kVn0iEJxfVEYM6xNTBI4V++7I1oFH6
         NhZeqcP6CXyOIHj4AjSxt0aAKkDmZQM+kkAy5n7Ez2/MorYb9TxKLgySQjZrUH65ZU9K
         0rwV3QTvJD8nLGvnznRJ5v7JVbwrVLNhfqz4e+ExR8d1HwIiUxHMtzzXmVvA3B7A40ie
         fTwQ==
X-Gm-Message-State: AOAM533r0BXZ+kOP/NUaebpWC4pNI4ZMjja8fpm9OeVEIiJmpnzebNgL
        0an1M1myO2vDCASJKVZUrnI=
X-Google-Smtp-Source: ABdhPJyUUWqoUJc47c0gBiHuNFkAur1+tX3M47krLs4Zje9ipb18DmxknFlh0flPhAISUtcMF3Q3EQ==
X-Received: by 2002:aa7:9521:0:b029:1f1:b27f:1a43 with SMTP id c1-20020aa795210000b02901f1b27f1a43mr14596473pfp.4.1616260812393;
        Sat, 20 Mar 2021 10:20:12 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:2033:9813:e1ed:7060])
        by smtp.gmail.com with ESMTPSA id cv3sm9238575pjb.9.2021.03.20.10.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 10:20:11 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Sat, 20 Mar 2021 10:20:09 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, surenb@google.com, cgoldswo@codeaurora.org,
        willy@infradead.org, mhocko@suse.com, david@redhat.com,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org,
        oliver.sang@intel.com
Subject: Re: [PATCH v4 3/3] mm: fs: Invalidate BH LRU during page migration
Message-ID: <YFYuyS51hpE2gp+f@google.com>
References: <20210319175127.886124-1-minchan@kernel.org>
 <20210319175127.886124-3-minchan@kernel.org>
 <20210320093249.2df740cd139449312211c452@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320093249.2df740cd139449312211c452@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 20, 2021 at 09:32:49AM -0700, Andrew Morton wrote:
> On Fri, 19 Mar 2021 10:51:27 -0700 Minchan Kim <minchan@kernel.org> wrote:
> 
> > Pages containing buffer_heads that are in one of the per-CPU
> > buffer_head LRU caches will be pinned and thus cannot be migrated.
> > This can prevent CMA allocations from succeeding, which are often used
> > on platforms with co-processors (such as a DSP) that can only use
> > physically contiguous memory. It can also prevent memory
> > hot-unplugging from succeeding, which involves migrating at least
> > MIN_MEMORY_BLOCK_SIZE bytes of memory, which ranges from 8 MiB to 1
> > GiB based on the architecture in use.
> > 
> > Correspondingly, invalidate the BH LRU caches before a migration
> > starts and stop any buffer_head from being cached in the LRU caches,
> > until migration has finished.
> > 
> > Tested-by: Oliver Sang <oliver.sang@intel.com>
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> 
> The signoff chain ordering might mean that Chris was the primary author, but
> there is no From:him.  Please clarify?

He tried first version but was diffrent implementation since I
changed a lot. That's why I added his SoB even though current
implementaion is much different. So, maybe I am primary author?


