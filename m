Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9290D58B506
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Aug 2022 12:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbiHFKZL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Aug 2022 06:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiHFKZK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Aug 2022 06:25:10 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9463213D58;
        Sat,  6 Aug 2022 03:25:08 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 11B3541247;
        Sat,  6 Aug 2022 10:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:message-id:subject:subject:from:from:date:date
        :received:received:received:received; s=mta-01; t=1659781505; x=
        1661595906; bh=Q4UWjyW+pixLaTW0W0cgN8BYm6mgWJyHbqebGfcoTtI=; b=t
        Ny1n/wsWp0odKmQJc24E0YNR0AY2kmaYsYwsoi8zA5TorIaOo77F0gw+ItkH8+mk
        5h2wKlEyPR70B+hD+wjB1E/a53ItEm/vgwBJrbY0yMElplIf4XqpGofTjofLCVUk
        O8WZ0nB6+XPhnnD0deUMlAWvAx//Po/EUwBItKK9ZE=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zOgZf4FZOzVM; Sat,  6 Aug 2022 13:25:05 +0300 (MSK)
Received: from T-EXCH-01.corp.yadro.com (t-exch-01.corp.yadro.com [172.17.10.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id AAA4541246;
        Sat,  6 Aug 2022 13:25:01 +0300 (MSK)
Received: from T-EXCH-09.corp.yadro.com (172.17.11.59) by
 T-EXCH-01.corp.yadro.com (172.17.10.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Sat, 6 Aug 2022 13:25:01 +0300
Received: from yadro.com (10.178.119.167) by T-EXCH-09.corp.yadro.com
 (172.17.11.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Sat, 6 Aug 2022
 13:24:59 +0300
Date:   Sat, 6 Aug 2022 13:24:59 +0300
From:   Konstantin Shelekhin <k.shelekhin@yadro.com>
To:     <ojeda@kernel.org>
CC:     <alex.gaynor@gmail.com>, <ark.email@gmail.com>,
        <bjorn3_gh@protonmail.com>, <bobo1239@web.de>,
        <bonifaido@gmail.com>, <boqun.feng@gmail.com>,
        <davidgow@google.com>, <dev@niklasmohrin.de>,
        <dsosnowski@dsosnowski.pl>, <foxhlchen@gmail.com>,
        <gary@garyguo.net>, <geofft@ldpreload.com>,
        <gregkh@linuxfoundation.org>, <jarkko@kernel.org>,
        <john.m.baublitz@gmail.com>, <leseulartichaut@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <m.falkowski@samsung.com>, <me@kloenk.de>, <milan@mdaverde.com>,
        <mjmouse9999@gmail.com>, <patches@lists.linux.dev>,
        <rust-for-linux@vger.kernel.org>, <thesven73@gmail.com>,
        <torvalds@linux-foundation.org>, <viktor@v-gar.de>,
        <wedsonaf@google.com>
Subject: Re: [PATCH v9 12/27] rust: add `kernel` crate
Message-ID: <Yu5Bex9zU6KJpcEm@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220805154231.31257-13-ojeda@kernel.org>
X-Originating-IP: [10.178.119.167]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +unsafe impl GlobalAlloc for KernelAllocator {
> +    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
> +        // `krealloc()` is used instead of `kmalloc()` because the latter is
> +        // an inline function and cannot be bound to as a result.
> +        unsafe { bindings::krealloc(ptr::null(), layout.size(), bindings::GFP_KERNEL) as *mut u8 }
> +    }
> +
> +    unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
> +        unsafe {
> +            bindings::kfree(ptr as *const core::ffi::c_void);
> +        }
> +    }
> +}

I sense possible problems here. It's common for a kernel code to pass
flags during memory allocations.

For example:

  struct bio *bio;

  for (...) {
        bio = bio_alloc_bioset(bdev, nr_vecs, opf, GFP_NOIO, bs);
        if (!bio)
        	return -ENOMEM;
  }

Without GFP_NOIO we can run into a deadlock, because the kernel will try
give us free memory by flushing the dirty pages and we need the memory
to actually do it and boom, deadlock.

Or we can be allocating some structs under spinlock (yeah, that happens too):

  struct efc_vport *vport;

  spin_lock_irqsave(...);
  vport = kzalloc(sizeof(*vport), GFP_ATOMIC);
  if (!vport) {
  	spin_unlock_irqrestore(...);
  	return NULL;
  }
  spin_unlock(...);

Same can (and probably will) happen to e.g. Vec elements. So some form
of flags passing should be supported in try_* variants:

  let mut vec = Vec::try_new(GFP_ATOMIC)?;

  vec.try_push(GFP_ATOMIC, 1)?;
  vec.try_push(GFP_ATOMIC, 2)?;
  vec.try_push(GFP_ATOMIC, 3)?;
