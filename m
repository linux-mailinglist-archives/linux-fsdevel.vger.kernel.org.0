Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39AC6C0C2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 09:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCTIZi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 04:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjCTIZh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:25:37 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67B1188;
        Mon, 20 Mar 2023 01:25:35 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id iw17so1530118wmb.0;
        Mon, 20 Mar 2023 01:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679300734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lq9ByukcLzCd4kriwtF9/gxGSEg8VeFv6cJLw8F5Cs4=;
        b=IJmshY7kOIZtz1stoAYNuTVmks50/4vFpi2fEKWTDNiLoLxZln6eaWVvG85lkMB1cd
         BcctcQI/JMb5ucLC+flnHuqr2J/myPMRO3gku/oPtKxcib56yqqEOq4pf2Di6SHMZgtB
         xG0bGt8navy8lZgLydyRUHr+pbEuM3glHWc5dcWGBymboc1pXuunrTiI1gnw8a2zGjwP
         N5kUALa0fFEuUrpCBXFHEujlcu7waD6BfOoMSiblLwrLTjvueQ+5fTDUXA1OeDuleYtt
         vC2kRV+BiUyX+UFXSSk4IqW05Op78qlCaP2LE55QFqEjnqVLY1FcjIO4/cxIFHwf/P1p
         U9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679300734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lq9ByukcLzCd4kriwtF9/gxGSEg8VeFv6cJLw8F5Cs4=;
        b=b4FtJaCSAOWG/C+h1MmQubUmW+1w6bXjUkrz4cgKDRZlJgkNoGT6A1cs+5FW5OG4DZ
         x53k3kXPuZNb0oVxp56crvjdCQ+6m7UcJlMNSXnKTleJDKHcgXLa+UJGuSScUPTf2BiQ
         YUp7h1VXuvfta9ky4C4Gsvi6cc2Pa4BLG6TNRXBRq60IusDtjt1ZXEk/KggQKBuUi1Rv
         1YClKml0Qj+96l9dM7z35tlNIE+V0HMICSryydw4xTgyFyFF0Gzl2HzmpelIqPECRc4p
         x3r0utlGAxje3ai+Lgs1QmYuS4tO3yiLRZfC68TQzUyc3CIDJF5rjLxvmm9An5aRywto
         seog==
X-Gm-Message-State: AO0yUKWtzNLi9eD1SQK1Qjbgy11+AW5/qNlnLF9+BrSCa/OdkvHM08XG
        9nEVaP5L58iCE0hHEPOlFgo=
X-Google-Smtp-Source: AK7set/KjExHxU/VRUundBhJwbAOn8f1vO3ZgnzhGHZgLDRty1RmkvUexWYNUQs9Tt5IKcmL51/a/A==
X-Received: by 2002:a7b:c40b:0:b0:3ee:1084:aa79 with SMTP id k11-20020a7bc40b000000b003ee1084aa79mr359148wmi.20.1679300734123;
        Mon, 20 Mar 2023 01:25:34 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id p17-20020adfcc91000000b002c71dd1109fsm8327072wrj.47.2023.03.20.01.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 01:25:33 -0700 (PDT)
Date:   Mon, 20 Mar 2023 08:25:32 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <413e0dfe-5a68-4cd9-9036-bed741e4cd22@lucifer.local>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
 <ZBgROQ0uAfZCbScg@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBgROQ0uAfZCbScg@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 20, 2023 at 08:54:33AM +0100, Uladzislau Rezki wrote:
> > vmalloc() is, by design, not permitted to be used in atomic context and
> > already contains components which may sleep, so avoiding spin locks is not
> > a problem from the perspective of atomic context.
> >
> > The global vmap_area_lock is held when the red/black tree rooted in
> > vmap_are_root is accessed and thus is rather long-held and under
> > potentially high contention. It is likely to be under contention for reads
> > rather than write, so replace it with a rwsem.
> >
> > Each individual vmap_block->lock is likely to be held for less time but
> > under low contention, so a mutex is not an outrageous choice here.
> >
> > A subset of test_vmalloc.sh performance results:-
> >
> > fix_size_alloc_test             0.40%
> > full_fit_alloc_test		2.08%
> > long_busy_list_alloc_test	0.34%
> > random_size_alloc_test		-0.25%
> > random_size_align_alloc_test	0.06%
> > ...
> > all tests cycles                0.2%
> >
> > This represents a tiny reduction in performance that sits barely above
> > noise.
> >
> How important to have many simultaneous users of vread()? I do not see a
> big reason to switch into mutexes due to performance impact and making it
> less atomic.

It's less about simultaneous users of vread() and more about being able to write
direct to user memory rather than via a bounce buffer and not hold a spinlock
over possible page faults.

The performance impact is barely above noise (I got fairly widely varying
results), so I don't think it's really much of a cost at all. I can't imagine
there are many users critically dependent on a sub-single digit % reduction in
speed in vmalloc() allocation.

As I was saying to Willy, the code is already not atomic, or rather needs rework
to become atomic-safe (there are a smattering of might_sleep()'s throughout)

However, given your objection alongside Willy's, let me examine Willy's
suggestion that we instead of doing this, prefault the user memory in advance of
the vread call.

>
> So, how important for you to have this change?
>

Personally, always very important :)

> --
> Uladzislau Rezki
