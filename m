Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06476CABCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 19:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjC0RWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 13:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjC0RWu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:22:50 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9485D35A9;
        Mon, 27 Mar 2023 10:22:49 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id br6so12397281lfb.11;
        Mon, 27 Mar 2023 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679937768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rHju53b2YFAyWLW5vNBV99C5hB8dZBFF+JUu3+CsONY=;
        b=lgPQCIE3X/lgtitmcxAZca2F3Ae4VDPc6hwp14djRmPJjzHhoUy4uldz/5e74t3DF6
         newoI0Isg6S2uqGvw+xdoC4dC3giRxFe+T/PooJNdEs5Y30k2pIy1QYG1NAtK6S8FZbo
         smkHYowvjvhC5/vsTP47gg6V1ceDnq4OZdC5ZkVU3I6EG3wFcow3jpbHS6FIDpqBVgZG
         yJWczY9IzAjwwl37G6oHPMr0KPRhq6bLQaklETJaWxCwq3WDSLtiSFMX1mKP7Z1SOXnP
         Dt60YANMqakluNQ2HrVGGLj+xZTlCO7CrzdvnMGnDonBh/TIKfCbkuWM3svYKhvxUUsN
         9XDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679937768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHju53b2YFAyWLW5vNBV99C5hB8dZBFF+JUu3+CsONY=;
        b=n2Tqc0uM7LrNpL68//UHZ3hb3GZnEEaBAGuZ1lQZIuQ6vEm468oPomG1k9ThdOutga
         R9SAtwtTRmc0HSxdraeSTqA6+K6zfLXZCO2U+7dmXpw1bJveIKFzXYvSmwqJlBhOiZ8p
         0Phe2+vgoyO37trmW8+iixz+eMtR5m5V8GXhOmKLzSZc2Obf6W/VBybB8RW23KZWb/6M
         UJSKfkLzNHb6w9rUwzJbSFmB5PBq+F2M7KLCUllfgSCwG6HUDLdJcFtD2OtZo3+qE+gF
         svGDN/musAZMjJ1aGTQQyFRnGAzjQ56jB8VpoyRB/ltVChUoWvw/WmHKUl3AHyF5uyBi
         Z83Q==
X-Gm-Message-State: AAQBX9e5swxXzW+LSslvWkYI2yxTM30BHgoZJLap2qf8GHSiWy7H1lyA
        kn5TJyp8fqIOyzZC3tH2ddw=
X-Google-Smtp-Source: AKy350bJtYdDkKQgM+BgtZ6EUjc0bh2kv+QJJ+aaydsUG1eZ9U4cTZw+AfVEV0oTI97tV/dx916Rww==
X-Received: by 2002:ac2:5961:0:b0:4ea:f60c:4e29 with SMTP id h1-20020ac25961000000b004eaf60c4e29mr3607469lfp.20.1679937767559;
        Mon, 27 Mar 2023 10:22:47 -0700 (PDT)
Received: from pc636 (host-90-233-209-50.mobileonline.telia.com. [90.233.209.50])
        by smtp.gmail.com with ESMTPSA id d3-20020ac25ec3000000b004d575f56227sm4695127lfq.114.2023.03.27.10.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:22:47 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 27 Mar 2023 19:22:44 +0200
To:     Dave Chinner <david@fromorbit.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <ZCHQ5Pdr203+2LMI@pc636>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
 <ZBkDuLKLhsOHNUeG@destitution>
 <ZBsAG5cpOFhFZZG6@pc636>
 <ZB00U2S4g+VqzDPL@destitution>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB00U2S4g+VqzDPL@destitution>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>     So, this patch open codes the kvmalloc() in the commit path to have
>     the above described behaviour. The result is we more than halve the
>     CPU time spend doing kvmalloc() in this path and transaction commits
>     with 64kB objects in them more than doubles. i.e. we get ~5x
>     reduction in CPU usage per costly-sized kvmalloc() invocation and
>     the profile looks like this:
>     
>       - 37.60% xlog_cil_commit
>             16.01% memcpy_erms
>           - 8.45% __kmalloc
>              - 8.04% kmalloc_order_trace
>                 - 8.03% kmalloc_order
>                    - 7.93% alloc_pages
>                       - 7.90% __alloc_pages
>                          - 4.05% __alloc_pages_slowpath.constprop.0
>                             - 2.18% get_page_from_freelist
>                             - 1.77% wake_all_kswapds
>     ....
>                                         - __wake_up_common_lock
>                                            - 0.94% _raw_spin_lock_irqsave
>                          - 3.72% get_page_from_freelist
>                             - 2.43% _raw_spin_lock_irqsave
>           - 5.72% vmalloc
>              - 5.72% __vmalloc_node_range
>                 - 4.81% __get_vm_area_node.constprop.0
>                    - 3.26% alloc_vmap_area
>                       - 2.52% _raw_spin_lock
>                    - 1.46% _raw_spin_lock
>                   0.56% __alloc_pages_bulk
>           - 4.66% kvfree
>              - 3.25% vfree
OK, i see. I tried to use the fs_mark in different configurations. For
example:

<snip>
time fs_mark -D 10000 -S0 -n 100000 -s 0 -L 32 -d ./scratch/0 -d ./scratch/1 -d ./scratch/2  \
-d ./scratch/3 -d ./scratch/4 -d ./scratch/5 -d ./scratch/6 -d ./scratch/7 -d ./scratch/8 \
-d ./scratch/9 -d ./scratch/10 -d ./scratch/11 -d ./scratch/12 -d ./scratch/13 \
-d ./scratch/14 -d ./scratch/15 -t 64 -F
<snip>

But i did not manage to trigger xlog_cil_commit() to fallback to vmalloc
code. I think i should reduce an amount of memory on my kvm-pc and
repeat the tests!

--
Uladzislau Rezki
