Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBD370B41E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 06:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjEVEdU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 00:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjEVEdT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 00:33:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2104F1;
        Sun, 21 May 2023 21:33:13 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-25372604818so2391028a91.2;
        Sun, 21 May 2023 21:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684729993; x=1687321993;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JJHKyiBy2KSAEY77H+aXQnODU6HMsiDN6SB4TfTKB6c=;
        b=LZu8+u5JcD4cLBiqUbNQWMIai0b5pIsby+ATqBfaj55TOX61VmAQWxckczv1rdIabG
         zgKKNYNwG0tx9ajf51NjOT+gQTHYpyUiR0N7PXEORTMHEiBfBgecnZ3jjNmvb3Rt7+4T
         lKa8MmzQhJPp/1Ep8n55/i0GzKRqQyYZ9yLqXuZ/iTSrVgfVvOnMeie2Hp2yxaZ1MfFq
         vkNPK+8PYpji1/3kg6nRpOoNa3faRsPTYir1oxFBjqgkyrO/wDeiTq7NnFWlokdYk5er
         tJYbnygAuLTTqXtctbiyiehXHWUjrSuyRbrYy1GRrgcbODFz+B09AV6NyQ7HAhuwPISK
         9klQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684729993; x=1687321993;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJHKyiBy2KSAEY77H+aXQnODU6HMsiDN6SB4TfTKB6c=;
        b=bYKS8BEJsVdJMrZDkLDnZsCcKe19LABKv5IIJBK85Dlkr0LDt5sZ3E8NPkLfb1Rnfz
         o4QMR5G5C/U3KzrlpxfpwI/87Ab9n3DTjseOiTR4PB8dxkSY7Y/06wjNSYlYKV4JxDeZ
         sKonaPBTwepZGUjXDqZ6wBfj56Xg2jrRNOfGY5EnKGfUJ8eWd79eK/MCpesgOTz4lSj1
         x8iSuNZekAGpXs8hGytMzsKw2ntds8lw3/7Jd/PWBtISdpe1YXK0yBXSIwyOQj+SHVlz
         g2AGDhYggnqsDjyAy9Z0QHFSCbmZSv12q+n8Y8wviElP+L6UgaW12f91QmJF2XdTYOdt
         pEGg==
X-Gm-Message-State: AC+VfDzya2Dy2p+4ab3peYHjXUk645fFzXtHHGiuHyslMFhLSE66AUE9
        PkJwgUCOPbPj2Vg6oPnFRPg=
X-Google-Smtp-Source: ACHHUZ57LttVfyQd4YRZUB9NB98Ghjh4R7N8stZgve7ksnPhJd3/Iq3DPacIEp3/v4OxdNAzNxk3gw==
X-Received: by 2002:a17:90a:f488:b0:253:772b:a8a6 with SMTP id bx8-20020a17090af48800b00253772ba8a6mr9462238pjb.4.1684729993230;
        Sun, 21 May 2023 21:33:13 -0700 (PDT)
Received: from rh-tp ([129.41.58.16])
        by smtp.gmail.com with ESMTPSA id ha11-20020a17090af3cb00b0025368c90773sm4977684pjb.34.2023.05.21.21.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 21:33:12 -0700 (PDT)
Date:   Mon, 22 May 2023 10:03:05 +0530
Message-Id: <87ttw5ugse.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv5 5/5] iomap: Add per-block dirty state tracking to improve performance
In-Reply-To: <ZGZPJWOybo+hQVLy@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Thu, May 18, 2023 at 06:23:44AM -0700, Christoph Hellwig wrote:
>> On Wed, May 17, 2023 at 02:48:12PM -0400, Brian Foster wrote:
>> > But I also wonder.. if we can skip the iop alloc on full folio buffered
>> > overwrites, isn't that also true of mapped writes to folios that don't
>> > already have an iop?
>>
>> Yes.
>
> Hm, well, maybe?  If somebody stores to a page, we obviously set the
> dirty flag on the folio, but depending on the architecture, we may
> or may not have independent dirty bits on the PTEs (eg if it's a PMD,
> we have one dirty bit for the entire folio; similarly if ARM uses the
> contiguous PTE bit).  If we do have independent dirty bits, we could
> dirty only the blocks corresponding to a single page at a time.
>
> This has potential for causing some nasty bugs, so I'm inclined to
> rule that if a folio is mmaped, then it's all dirty from any writable
> page fault.  The fact is that applications generally do not perform
> writes through mmap because the error handling story is so poor.
>
> There may be a different answer for anonymous memory, but that doesn't
> feel like my problem and shouldn't feel like any FS developer's problem.

Although I am skeptical too to do the changes which Brian is suggesting
here. i.e. not making all the blocks of the folio dirty when we are
going to call ->dirty_folio -> filemap_dirty_folio() (mmaped writes).

However, I am sorry but I coudn't completely follow your reasoning
above. I think what Brian is suggesting here is that
filemap_dirty_folio() should be similar to complete buffered overwrite
case where we do not allocate the iop at the ->write_begin() time.
Then at the writeback time we allocate an iop and mark all blocks dirty.

In a way it is also the similar case as for mmapped writes too but my
only worry is the way mmaped writes work and it makes more
sense to keep the dirty state of folio and per-block within iop in sync.
For that matter, we can even just make sure we always allocate an iop in
the complete overwrites case as well. I didn't change that code because
it was kept that way for uptodate state as well and based on one of your
inputs for complete overwrite case.

Though I agree that we should ideally be allocatting & marking all
blocks in iop as dirty in the call to ->dirty_folio(), I just wanted to
understand your reasoning better.

Thanks!
-ritesh
