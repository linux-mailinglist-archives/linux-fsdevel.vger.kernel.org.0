Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1928F3F2A33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 12:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbhHTKkV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 06:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbhHTKkT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:40:19 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1137CC061575;
        Fri, 20 Aug 2021 03:39:42 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u1so5677007wmm.0;
        Fri, 20 Aug 2021 03:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2l4f87jQ5BCVnW/LtVQs/ujfdv1Edqo9vK1XTZNmj64=;
        b=ZKKKORCLDq/VeWLjAhd2HF4b6J9R+CkAnEfTsRsXC2JpHBz3EFmWxVCXTcZRliZzQR
         6csaOtqJCaGtnor4OR+v0r3M9n4Hqwku+6mczvhp/kb7Xq81d62hdrqDppClM0C9fJW7
         jedZswfJPGrcD+k+k/useJ/R6zKptTamgma6736L4OuPpV3mmKK461sGuAteKDuHTs1F
         oBTxGt12BAtPC208K4MrtaKBOwhQ/Eo3OiQIKcjO5+99rzhSGMfoi7ElNn/+p39I/l+u
         uqNc8v1njX0kTwoFUmaRK2oZYXUT4RlZ44L3WYVQ+XTo0puEMXes5atR/VHN8zs0yxtt
         jzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2l4f87jQ5BCVnW/LtVQs/ujfdv1Edqo9vK1XTZNmj64=;
        b=rXgLe5OMb+jF5G+ra73356QdYTLZKEIWqasfounb5qPhrP/FWaBlpj8RxVev9WILjq
         uU16DiaZrWedua/BAkJfmQ3JdA3zAV7ggaMihW//o0Qfz/lADlcnXOivwMNkaNDO7WDz
         j0dacV7Asc7l5EQdCQxvWfgk/v3T+SQ641lmo00QpJyfXt/mDeEk4v/qz44GOTAP00vB
         iXb06lfviytconnqw7ilrfjJqVm8N5eegy2QgLwMyJouPseQdjyiQEO6hBhZcmxDjfoP
         2pp4svZAE4cUWaGbSckwUfjPdt3FXAIrYOUwKf7+5Iz2oOqa20w7oRTdI5TEuhg9E19Q
         52EA==
X-Gm-Message-State: AOAM532ApVCGYR0oL6HPqQV9ECJn+5MDNqKfDWcGHF5AasAYW/IBc0pm
        2NZMZHPcruCqlEYxrNR6JUUq/VYvpSu2LZLwXNI=
X-Google-Smtp-Source: ABdhPJwvvbvC7oT0EDMBScqPKbmq4ABDQwLkxNDJHv+ZwVgPws6KmaaRL0F7/tnmz8XSY+QaosFzbLsSI9/h7hXg+gc=
X-Received: by 2002:a05:600c:1c08:: with SMTP id j8mr3147766wms.138.1629455980524;
 Fri, 20 Aug 2021 03:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101758epcas5p1ec353b3838d64654e69488229256d9eb@epcas5p1.samsung.com>
 <20210817101423.12367-4-selvakuma.s1@samsung.com> <ad3561b9-775d-dd4d-0d92-6343440b1f8f@acm.org>
In-Reply-To: <ad3561b9-775d-dd4d-0d92-6343440b1f8f@acm.org>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Fri, 20 Aug 2021 16:09:14 +0530
Message-ID: <CA+1E3rK2ULVajQRkNTZJdwKoqBeGvkfoVYNF=WyK6Net85YkhA@mail.gmail.com>
Subject: Re: [PATCH 3/7] block: copy offload support infrastructure
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     SelvaKumar S <selvakuma.s1@samsung.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>, kch@kernel.org,
        mpatocka@redhat.com, djwong@kernel.org, agk@redhat.com,
        Selva Jove <selvajove@gmail.com>,
        Nitesh Shetty <nj.shetty@samsung.com>, nitheshshetty@gmail.com,
        KANCHAN JOSHI <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Bart, Mikulas

On Tue, Aug 17, 2021 at 10:44 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 8/17/21 3:14 AM, SelvaKumar S wrote:
> > Introduce REQ_OP_COPY, a no-merge copy offload operation. Create
> > bio with control information as payload and submit to the device.
> > Larger copy operation may be divided if necessary by looking at device
> > limits. REQ_OP_COPY(19) is a write op and takes zone_write_lock when
> > submitted to zoned device.
> > Native copy offload is not supported for stacked devices.
>
> Using a single operation for copy-offloading instead of separate
> operations for reading and writing is fundamentally incompatible with
> the device mapper. I think we need a copy-offloading implementation that
> is compatible with the device mapper.
>

While each read/write command is for a single contiguous range of
device, with simple-copy we get to operate on multiple discontiguous
ranges, with a single command.
That seemed like a good opportunity to reduce control-plane traffic
(compared to read/write operations) as well.

With a separate read-and-write bio approach, each source-range will
spawn at least one read, one write and eventually one SCC command. And
it only gets worse as there could be many such discontiguous ranges (for
GC use-case at least) coming from user-space in a single payload.
Overall sequence will be
- Receive a payload from user-space
- Disassemble into many read-write pair bios at block-layer
- Assemble those (somehow) in NVMe to reduce simple-copy commands
- Send commands to device

We thought payload could be a good way to reduce the
disassembly/assembly work and traffic between block-layer to nvme.
How do you see this tradeoff?  What seems necessary for device-mapper
usecase, appears to be a cost when device-mapper isn't used.
Especially for SCC (since copy is within single ns), device-mappers
may not be too compelling anyway.

Must device-mapper support be a requirement for the initial support atop SCC?
Or do you think it will still be a progress if we finalize the
user-space interface to cover all that is foreseeable.And for
device-mapper compatible transport between block-layer and NVMe - we
do it in the later stage when NVMe too comes up with better copy
capabilities?


-- 
Joshi
