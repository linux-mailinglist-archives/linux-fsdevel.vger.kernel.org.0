Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C21B44C5C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 18:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhKJRR4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 12:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhKJRRz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 12:17:55 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48E8C061764;
        Wed, 10 Nov 2021 09:15:07 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id y26so7600659lfa.11;
        Wed, 10 Nov 2021 09:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ICN5EUJl3qzLlvbPtdDk5gm45qpkE02POcqWSzEhT0=;
        b=NdRV/Yx9dSY5ehbaO11CVvF8PuvDGahp8ZdTentGHBY/4+RzfJ74b2fTgG2gE9+m2U
         2GPX/FZxrMoH4dSl0+7qCgNHM1QOQQwcvlEif9CbcXyeyVb6nfduZVUgdKGwlDl6aCKT
         Yk8hwHklspUSpjqsbPT8MhTJdnWE3idhBhD3yLEgJVRmR8oEYBbUfw4ohTFYN5NZJEfQ
         qqQjHU+Olo55VDYktBC10o+ra8y/D8nxB9fEUQt8WlKICaNcsqQVBraRlp18koexEljL
         khZaDtkt2b+Cd7w98lxxHtILmuyKixnTot0D/Ls2edDLm62E+VUmgKXkkLcgLQiQwuTC
         y99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ICN5EUJl3qzLlvbPtdDk5gm45qpkE02POcqWSzEhT0=;
        b=cfKAJZSplPWTUIBQT6xVD3XztB0aje+OFvQyi2nlxoBL/F/gx6nmF3OoCYpsapXyb7
         5zfA6+014nBHwEdBuejZWdXv48Ze6VKfxDG9QHyTyRQ0smh64WMvdvINN8aQMXBRxLnY
         xFus6PL5ceTYYS1zD+LY1gAJ61I4vy4P9XS0IHW+7dZFw9LW2LSfQCROCR3n2tAGSIhQ
         gbQQohEAKd42YSFkNlT7fcJb7VaLfVETF32xaihhX5iSzYa4I7CIVJFt5wSqMuVzXoOk
         Oi7nR174ITlcNuIYxyoWtmGWW/arq8LVQ7aqmj8e9a41/BAfSt7mI0HnuQcdO2I+qbr2
         tXOA==
X-Gm-Message-State: AOAM5304wGx0+h3x3YfYbIRY/cCFpKbnoK/vsVBvdXk4qzifDWHhu63m
        gElxl/uQMcViLnfzeN62e5qDEdrhpCX37X79xHZnNRFy/ro=
X-Google-Smtp-Source: ABdhPJwUCjf6ysJZS9EzmRC3u5KL/JM9LgMY0mbw9VR9qgcMEgMpTxN6eK6lFAtW/CrkMr7dPRU86XokcT1cL9dOD6E=
X-Received: by 2002:ac2:5ddb:: with SMTP id x27mr589034lfq.595.1636564505918;
 Wed, 10 Nov 2021 09:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20211109232420.5X7KNcoQd%akpm@linux-foundation.org>
In-Reply-To: <20211109232420.5X7KNcoQd%akpm@linux-foundation.org>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 10 Nov 2021 11:14:55 -0600
Message-ID: <CAH2r5mugTNmhPnnjhLLeKySe1FuZ9u1J1EVNxyJLnzdzEudVnA@mail.gmail.com>
Subject: Fwd: + hitting-bug_on-trap-in-read_pages-mm-optimise-put_pages_list.patch
 added to -mm tree
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

You can add my reviewed-by and tested-by to this patch if desired.

Tested-by: Steve French <stfrench@microsoft.com>

http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/8/builds/93

---------- Forwarded message ---------
From: <akpm@linux-foundation.org>
Date: Tue, Nov 9, 2021 at 5:24 PM
Subject: + hitting-bug_on-trap-in-read_pages-mm-optimise-put_pages_list.patch
added to -mm tree
To: <hyc.lee@gmail.com>, <linkinjeon@kernel.org>,
<mm-commits@vger.kernel.org>, <smfrench@gmail.com>,
<willy@infradead.org>



The patch titled
     Subject: ipc/ipc_sysctl.c:put_pages_list(): reinitialise the page list
has been added to the -mm tree.  Its filename is
     hitting-bug_on-trap-in-read_pages-mm-optimise-put_pages_list.patch

This patch should soon appear at
    https://ozlabs.org/~akpm/mmots/broken-out/hitting-bug_on-trap-in-read_pages-mm-optimise-put_pages_list.patch
and later at
    https://ozlabs.org/~akpm/mmotm/broken-out/hitting-bug_on-trap-in-read_pages-mm-optimise-put_pages_list.patch

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when
testing your code ***

The -mm tree is included into linux-next and is updated
there every 3-4 working days

------------------------------------------------------
From: Matthew Wilcox <willy@infradead.org>
Subject: ipc/ipc_sysctl.c:put_pages_list(): reinitialise the page list


While free_unref_page_list() puts pages onto the CPU local LRU list, it
does not remove them from the list they were passed in on.  That makes the
list_head appear to be non-empty, and would lead to various corruption
problems if we didn't have an assertion that the list was empty.

Reinitialise the list after calling free_unref_page_list() to avoid this
problem.

Link: https://lkml.kernel.org/r/YYp40A2lNrxaZji8@casper.infradead.org
Fixes: 988c69f1bc23 ("mm: optimise put_pages_list()")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reported-by: Namjae Jeon <linkinjeon@kernel.org>
Tested-by: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <smfrench@gmail.com>
Cc: Hyeoncheol Lee <hyc.lee@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/swap.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/swap.c~hitting-bug_on-trap-in-read_pages-mm-optimise-put_pages_list
+++ a/mm/swap.c
@@ -155,6 +155,7 @@ void put_pages_list(struct list_head *pa
        }

        free_unref_page_list(pages);
+       INIT_LIST_HEAD(pages);
 }
 EXPORT_SYMBOL(put_pages_list);

_

Patches currently in -mm which might be from willy@infradead.org are

mm-move-kvmalloc-related-functions-to-slabh.patch
kasan-fix-tag-for-large-allocations-when-using-config_slab.patch
mm-remove-bogus-vm_bug_on.patch
mm-optimise-put_pages_list.patch
hitting-bug_on-trap-in-read_pages-mm-optimise-put_pages_list.patch



-- 
Thanks,

Steve
