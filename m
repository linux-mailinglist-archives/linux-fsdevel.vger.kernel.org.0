Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9631A886C5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 01:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfHIXDx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 19:03:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37814 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfHIXDx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 19:03:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id b3so7204520wro.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2019 16:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AA45q6IMPxeio0FSS0wDQ5w5I6FSh5bk8IxEXeZUP0E=;
        b=Hgx4J6XnzbPi/G6IzDkRvXBDXp3Xw1iLGFI/8Hl4XZuiFH/pUvEk+HOHKKjP76/hQX
         mWBD6zQ+rQEL/nOuq0/6OmDbIxxGtFO6mY0LVFTTsqFrIlaZRSb6M8aKKowHzhH3DQTm
         2V+ddlS0fA173GTaNiMA1v1CE+VrS8SelYzm2zJvLS4DQ8ADl33KFGIwXY+3yOoWJZOf
         43vCBcpxoWOuxjX+XDan+MgqKv25HMcRzB9Sdy38s8MR02Rff0hzlNnG2pYSL2LO5aSF
         Ub94moH3Leka0deP3ghd/pfu+DURzPTrsZXYAaf5nPRADSxRxH4ONydFG4lxIGtrLsfa
         iSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AA45q6IMPxeio0FSS0wDQ5w5I6FSh5bk8IxEXeZUP0E=;
        b=GzmtzjCSb8g8QeKzl/nPYcyGcJePbPOeaw/CN4kiK3GIZElipJAGS227lWFyz316sp
         QRLu178YHK3dDmEwcbn3mdFsiJ6XxYhsH0l+swH0vovXLaygj/2DoxOW36zIy6EUjqll
         pSgESdSYzAsoD3Ej7+kI9DKpZbqfnq9uytT23WiXANoc3cqwyB9gkM4alyxYKjz0liQo
         +q1EJUcgFlkys4Jzk33Vhvib/0SvdFLtCuwqXAFmAH15thDmsXnqEgNcL4KNf8HHG6T3
         OkFxGiusffbCPz81Ngd2ulz0rt2rTi58ZtXg8UOeiXZerW6iiPaTwD8uGS/DgFWPDJXj
         WyHg==
X-Gm-Message-State: APjAAAVUnI9TaABu6f9JHAV9+s/FsTTMqA23kMbstgTLW4RgTHY/G896
        frSuL54I3+7rPgGG+OHWqGq+EdGdCXNubmIU0O4iGg==
X-Google-Smtp-Source: APXvYqxNIFUtq0mvXkjapWy5+xX1d0Xp8TP4K9kMBJ6lZAuc7uPuLpfox+P3pZ3dVwbona9mq6bzyo+H3lZPiB9qFJI=
X-Received: by 2002:adf:ce88:: with SMTP id r8mr28161681wrn.42.1565391830743;
 Fri, 09 Aug 2019 16:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190808190300.GA9067@cmpxchg.org>
In-Reply-To: <20190808190300.GA9067@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Aug 2019 16:03:39 -0700
Message-ID: <CAJuCfpFQdCmhdCQQGxmWuwjYRdMCL8-xtkuUiqYE03ut+uvW6g@mail.gmail.com>
Subject: Re: [PATCH RESEND] block: annotate refault stalls from IO submission
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 8, 2019 at 12:03 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> psi tracks the time tasks wait for refaulting pages to become
> uptodate, but it does not track the time spent submitting the IO. The
> submission part can be significant if backing storage is contended or
> when cgroup throttling (io.latency) is in effect - a lot of time is
> spent in submit_bio(). In that case, we underreport memory pressure.
>
> Annotate submit_bio() to account submission time as memory stall when
> the bio is reading userspace workingset pages.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  block/bio.c               |  3 +++
>  block/blk-core.c          | 23 ++++++++++++++++++++++-
>  include/linux/blk_types.h |  1 +
>  3 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index 299a0e7651ec..4196865dd300 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -806,6 +806,9 @@ void __bio_add_page(struct bio *bio, struct page *page,
>
>         bio->bi_iter.bi_size += len;
>         bio->bi_vcnt++;
> +
> +       if (!bio_flagged(bio, BIO_WORKINGSET) && unlikely(PageWorkingset(page)))
> +               bio_set_flag(bio, BIO_WORKINGSET);
>  }
>  EXPORT_SYMBOL_GPL(__bio_add_page);
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d0cc6e14d2f0..1b1705b7dde7 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -36,6 +36,7 @@
>  #include <linux/blk-cgroup.h>
>  #include <linux/debugfs.h>
>  #include <linux/bpf.h>
> +#include <linux/psi.h>
>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/block.h>
> @@ -1128,6 +1129,10 @@ EXPORT_SYMBOL_GPL(direct_make_request);
>   */
>  blk_qc_t submit_bio(struct bio *bio)
>  {
> +       bool workingset_read = false;
> +       unsigned long pflags;
> +       blk_qc_t ret;
> +
>         if (blkcg_punt_bio_submit(bio))
>                 return BLK_QC_T_NONE;
>
> @@ -1146,6 +1151,8 @@ blk_qc_t submit_bio(struct bio *bio)
>                 if (op_is_write(bio_op(bio))) {
>                         count_vm_events(PGPGOUT, count);
>                 } else {
> +                       if (bio_flagged(bio, BIO_WORKINGSET))
> +                               workingset_read = true;
>                         task_io_account_read(bio->bi_iter.bi_size);
>                         count_vm_events(PGPGIN, count);
>                 }
> @@ -1160,7 +1167,21 @@ blk_qc_t submit_bio(struct bio *bio)
>                 }
>         }
>
> -       return generic_make_request(bio);
> +       /*
> +        * If we're reading data that is part of the userspace
> +        * workingset, count submission time as memory stall. When the
> +        * device is congested, or the submitting cgroup IO-throttled,
> +        * submission can be a significant part of overall IO time.
> +        */
> +       if (workingset_read)
> +               psi_memstall_enter(&pflags);
> +
> +       ret = generic_make_request(bio);
> +
> +       if (workingset_read)
> +               psi_memstall_leave(&pflags);
> +
> +       return ret;
>  }
>  EXPORT_SYMBOL(submit_bio);
>
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 1b1fa1557e68..a9dadfc16a92 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -209,6 +209,7 @@ enum {
>         BIO_BOUNCED,            /* bio is a bounce bio */
>         BIO_USER_MAPPED,        /* contains user pages */
>         BIO_NULL_MAPPED,        /* contains invalid user pages */
> +       BIO_WORKINGSET,         /* contains userspace workingset pages */
>         BIO_QUIET,              /* Make BIO Quiet */
>         BIO_CHAIN,              /* chained bio, ->bi_remaining in effect */
>         BIO_REFFED,             /* bio has elevated ->bi_cnt */
> --
> 2.22.0
>

The change contributes to the amount of recorded stall while running
memory stress test with and without the patch. Did not notice any
performance regressions so far. Thanks!

Tested-by: Suren Baghdasaryan <surenb@google.com>
