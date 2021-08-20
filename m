Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA473F2AC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 13:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbhHTLMV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 07:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhHTLMU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:12:20 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3682C061575;
        Fri, 20 Aug 2021 04:11:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v10so2467864wrd.4;
        Fri, 20 Aug 2021 04:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XTV41ORucx8ryF7oB1eYwysBWiCN8gKMFeTRn1Zj7AM=;
        b=MYvcDMXR87iOi7JK63t8cj54EEq9i8ZzrMq9tTqiUnWhDTDpZ+z4a4GCYAjq653LTa
         I0zDS4sQg1eW6rUqQCv1JNBNE6zrArt6rTFvGCFeg0Dbin816j8YZy9tgx6PsYbcoTGo
         pRvXznFW67AYmCqrOL/h4QHkXw0BeMbcThfam8AJkm+2c4RjnYPossT/rYuEPniF4uUP
         lgU4P6t/RauHcpJ985qi72+0T/B06GHTCsAkiEiv0WJP3v8HUf+Y+HDJVlu8p0kLKiGO
         1NAaZJYEaqA0vmmOG6yNGc7LwnVlknJMuXwP7kGJLpVCuwHngy0M5vjxVKd3AAzIoPHD
         6J+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XTV41ORucx8ryF7oB1eYwysBWiCN8gKMFeTRn1Zj7AM=;
        b=din9tUTwECWjTuz3y/YTtyHp2IxJbKlUz8bB6sS8JQQ1loaKMKTPghsBtE97uos58y
         yL1urZRYERvN4qKmkUhMDk2n7GgzFOhu7LIOuLplipLY40CJwhX2fKSZRK/4hS/Y+b6W
         4GpsfFwU0AA4AtQLSXDJypXh92gsuWIGMbki2wZMdnZlNjML9XvIwrPeKBryVnfY8iZY
         65Rhzc5dPVkZuAEnNnEjlx9mmV8TyjGbccyLwNWKvCCwYtPRyg31m21W/vPaUWk2I6V7
         mAp6uJQCU+Y4xGCrlpGBGPcT0mgkV2aA+96Bp2rEs9qXXZkctz2uykBSxQutU3VFla/e
         keZA==
X-Gm-Message-State: AOAM531+MiQjj00idO+VkZLpQm32GnH/T9ciNvbdF1jD/+kfZ0/8iPWH
        yTcMriFCGs5XYtaFESxy1YzzmCClX9cOgHDgWdo=
X-Google-Smtp-Source: ABdhPJyHLBn4cAqZhoblha8bwzOCJdvxUWt4EpC0AJmYcZ2sxKZSuvBjXl3YiZg/qrMlyWLl4b6/2Ts3GXLe812W024=
X-Received: by 2002:a5d:6991:: with SMTP id g17mr9619476wru.253.1629457901314;
 Fri, 20 Aug 2021 04:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101758epcas5p1ec353b3838d64654e69488229256d9eb@epcas5p1.samsung.com>
 <20210817101423.12367-4-selvakuma.s1@samsung.com> <yq1sfz6loh9.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1sfz6loh9.fsf@ca-mkp.ca.oracle.com>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Fri, 20 Aug 2021 16:41:15 +0530
Message-ID: <CA+1E3rKmS6LSPDb9C8S7Ap-b40TB9dfogC-PYm7ehLeBTn+Ukw@mail.gmail.com>
Subject: Re: [PATCH 3/7] block: copy offload support infrastructure
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
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
        mpatocka@redhat.com, bvanassche@acm.org, djwong@kernel.org,
        snitzer@redhat.com, agk@redhat.com,
        Selva Jove <selvajove@gmail.com>,
        Nitesh Shetty <nj.shetty@samsung.com>, nitheshshetty@gmail.com,
        KANCHAN JOSHI <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 19, 2021 at 12:05 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> > Native copy offload is not supported for stacked devices.
>
> One of the main reasons that the historic attempts at supporting copy
> offload did not get merged was that the ubiquitous deployment scenario,
> stacked block devices, was not handled well.
>
> Pitfalls surrounding stacking has been brought up several times in
> response to your series. It is critically important that both kernel
> plumbing and user-facing interfaces are defined in a way that works for
> the most common use cases. This includes copying between block devices
> and handling block device stacking. Stacking being one of the most
> fundamental operating principles of the Linux block layer!
>
> Proposing a brand new interface that out of the gate is incompatible
> with both stacking and the copy offload capability widely implemented in
> shipping hardware makes little sense. While NVMe currently only supports
> copy operations inside a single namespace, it is surely only a matter of
> time before that restriction is lifted.
>
> Changing existing interfaces is painful, especially when these are
> exposed to userland. We obviously can't predict every field or feature
> that may be needed in the future. But we should at the very least build
> the infrastructure around what already exists. And that's where the
> proposed design falls short...
>
Certainly, on user-space interface. We've got few cracks to be filled
there, missing the future viability.
But on stacking, can that be additive. Could you please take a look at
the other response (comment from Bart) for the trade-offs.


-- 
Joshi
