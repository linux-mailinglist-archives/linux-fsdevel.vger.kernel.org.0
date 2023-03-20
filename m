Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05F86C0BA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 08:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCTHyj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 03:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjCTHyi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 03:54:38 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803F2EFBF;
        Mon, 20 Mar 2023 00:54:37 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w9so43131299edc.3;
        Mon, 20 Mar 2023 00:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679298876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sJhXx7lj7mAAtSwPkvLZgq1i7eNqPIJmhsmajQCNEm4=;
        b=hkoNYTiLyaTIj7SjwTxPI5ljv/x+C6NtABncspBn1xbdN02xJPMdeQ/M1tk7WKiitT
         j5PxnGW+9a1kr2HO+aOFw7fadx2HpIkqvv8WrVpfC4DE6Bw0UsfvOrJFLPs9Vu0o4Lpu
         hCp/NWl6zhxlqSW3kpuhQhM1cv3CRU/HFzym9UvvLDdimohwB39oSrdA+MYmuwCIkazi
         SzuDuHlTfypjB9I48JyeRzX23J010krZ6W7p2vdi4dULMLSryeyHd24BbPFWcUTATCUI
         F8UI2/pW8W/yCc3XygZbUGrpQjDeFztiHmRrKxX8jWkWSI3ZXD5M4ADAlee9272RNyOt
         KTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679298876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJhXx7lj7mAAtSwPkvLZgq1i7eNqPIJmhsmajQCNEm4=;
        b=TMqKxdl7qXLz5NWIjFbNVpSx74WBfygkN1Et7wCcXDplx4yhfoKb9efQHXpUvbDw/h
         ZOrA+RGJKdUg/YY4X6nvN4A3F/QtuzDCFlyu8/S+vFaIVY/GZnlDVw4GbChbU6KFTV7G
         +w3gUCPuQz8sLRk/YdydCCPgdW9xb27Hxt5tCuuQAu4V9t4a6RJ6UTawhADXRE2Ar/rl
         pRSCh/SSu0hgXbDx/1/QUP+F7qVtcf/ctEqQZimkpiaLwFMXsmMEvrlTT7aWqy3zEHBE
         9vs5j/ffKS+o6Bue1Ayyis1EIHGEoetVuDfklycVVIb0C2zV0Shqfin9CRslsDKF1lxI
         62iw==
X-Gm-Message-State: AO0yUKUfjr7BPf6bfkM6pzXAf516Ld2X4kI32nNTh6iX9DZZqHWO0H30
        +eLr65xpHTypV6gtmOQn6Z8=
X-Google-Smtp-Source: AK7set90bpWlECEvYqSWD9RwblEcLnieM+VDvmNnJ6yRVFGuyX44/qn4BTG7Mkh4zUoORvDkKCjCBw==
X-Received: by 2002:a17:907:7718:b0:931:e5de:d28d with SMTP id kw24-20020a170907771800b00931e5ded28dmr7578399ejc.33.1679298875853;
        Mon, 20 Mar 2023 00:54:35 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id v15-20020a170906858f00b0093229e527cdsm3635761ejx.42.2023.03.20.00.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 00:54:35 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 20 Mar 2023 08:54:33 +0100
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <ZBgROQ0uAfZCbScg@pc636>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> vmalloc() is, by design, not permitted to be used in atomic context and
> already contains components which may sleep, so avoiding spin locks is not
> a problem from the perspective of atomic context.
> 
> The global vmap_area_lock is held when the red/black tree rooted in
> vmap_are_root is accessed and thus is rather long-held and under
> potentially high contention. It is likely to be under contention for reads
> rather than write, so replace it with a rwsem.
> 
> Each individual vmap_block->lock is likely to be held for less time but
> under low contention, so a mutex is not an outrageous choice here.
> 
> A subset of test_vmalloc.sh performance results:-
> 
> fix_size_alloc_test             0.40%
> full_fit_alloc_test		2.08%
> long_busy_list_alloc_test	0.34%
> random_size_alloc_test		-0.25%
> random_size_align_alloc_test	0.06%
> ...
> all tests cycles                0.2%
> 
> This represents a tiny reduction in performance that sits barely above
> noise.
> 
How important to have many simultaneous users of vread()? I do not see a
big reason to switch into mutexes due to performance impact and making it
less atomic.

So, how important for you to have this change?

--
Uladzislau Rezki
