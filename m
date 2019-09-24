Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0887DBD262
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 21:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441838AbfIXTI0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 15:08:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35581 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405389AbfIXTI0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:08:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id m7so3065121lji.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2019 12:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8uj1Y9j5QWqL4P9NRMcUrWkMG7q2mqy5Dd8EdClY1dI=;
        b=KeNNjs2YCmvvqn9Okqghy7piNALz7QVTpDoyirLKb2vv3A9ZuN0VtUsI1Ci+kH11dV
         nPDKfZBN4OO7RvDf0UjlqePtCVjunFycfJIX0aRPfBS1B5KizhKrukK72fkQ+rJiQZx8
         qWou7b+Jp5S+Onyl6WMDXnD9Sw0vZRzIn4dqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8uj1Y9j5QWqL4P9NRMcUrWkMG7q2mqy5Dd8EdClY1dI=;
        b=sPyrTi3GCH0In8cOf80CR02In3V8Ui1ghikyZmJ8jW/3DYa6ve/7gxxblNVorzQTOY
         8vT06vSguVyUO7QrmDkj/O8zVKKedw/p+dsScvLDwf5kl5AGKqIPnBtj8XeGknPCrdHH
         C4hyOJ8R2QJQje7clKwDQ2BrdWS+YBClvhzWZFdrratDE7FsSnrDsfBAUQ+7YkYtcnDk
         BpGeInj54aQTDdJJTW1oz/mhGASwFyW8VUOEFSiExGLGKzm0tC3/tFuPR0IJlXY53mFP
         uDeWqV70S3+cALi3/ri/HOLNsrbaUjtwAufTfay5Qc7AviXon/GbmxUurGCMDMoXffrH
         lLWg==
X-Gm-Message-State: APjAAAWY/3bXgpb3DgCblQmcZ3kGCGtOXLWfVbM09t36xoKzGBr6QPfY
        Q7S87h2nSfz4g1c3k9HhNwz/whg+nbk=
X-Google-Smtp-Source: APXvYqx/eDthsPp6yxalhbDvNSnXqzMxIvZZPxWWq/us3rBhyx2lJuMN6aaM3+uxQH7PCtAXnb57FQ==
X-Received: by 2002:a2e:9241:: with SMTP id v1mr3091769ljg.148.1569352102920;
        Tue, 24 Sep 2019 12:08:22 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id h12sm660771ljg.24.2019.09.24.12.08.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 12:08:21 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id j19so3062045lja.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2019 12:08:21 -0700 (PDT)
X-Received: by 2002:a2e:5b9a:: with SMTP id m26mr2982371lje.90.1569352100677;
 Tue, 24 Sep 2019 12:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <156896493723.4334.13340481207144634918.stgit@buzz>
 <875f3b55-4fe1-e2c3-5bee-ca79e4668e72@yandex-team.ru> <20190923145242.GF2233839@devbig004.ftw2.facebook.com>
 <ed5d930c-88c6-c8e4-4a6c-529701caa993@yandex-team.ru> <20190924073940.GM6636@dread.disaster.area>
In-Reply-To: <20190924073940.GM6636@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Sep 2019 12:08:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whf2BQ8xqVBF8YuxRznByrP-oTgcHSY9DgDnrFTxpsrVA@mail.gmail.com>
Message-ID: <CAHk-=whf2BQ8xqVBF8YuxRznByrP-oTgcHSY9DgDnrFTxpsrVA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: implement write-behind policy for sequential file writes
To:     Dave Chinner <david@fromorbit.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 12:39 AM Dave Chinner <david@fromorbit.com> wrote:
>
> Stupid question: how is this any different to simply winding down
> our dirty writeback and throttling thresholds like so:
>
> # echo $((100 * 1000 * 1000)) > /proc/sys/vm/dirty_background_bytes

Our dirty_background stuff is very questionable, but it exists (and
has those insane defaults) because of various legacy reasons.

But it probably _shouldn't_ exist any more (except perhaps as a
last-ditch hard limit), and I don't think it really ends up being the
primary throttling any more in many cases.

It used to make sense to make it a "percentage of memory" back when we
were talking old machines with 8MB of RAM, and having an appreciable
percentage of memory dirty was "normal".

And we've kept that model and not touched it, because some benchmarks
really want enormous amounts of dirty data (particularly various dirty
shared mappings).

But out default really is fairly crazy and questionable. 10% of memory
being dirty may be ok when you have a small amount of memory, but it's
rather less sane if you have gigs and gigs of RAM.

Of course, SSD's made it work slightly better again, but our
"dirty_background" stuff really is legacy and not very good.

The whole dirty limit when seen as percentage of memory (which is our
default) is particularly questionable, but even when seen as total
bytes is bad.

If you have slow filesystems (say, FAT on a USB stick), the limit
should be very different from a fast one (eg XFS on a RAID of proper
SSDs).

So the limit really needs be per-bdi, not some global ratio or bytes.

As a result we've grown various _other_ heuristics over time, and the
simplistic dirty_background stuff is only a very small part of the
picture these days.

To the point of almost being irrelevant in many situations, I suspect.

> to start background writeback when there's 100MB of dirty pages in
> memory, and then:
>
> # echo $((200 * 1000 * 1000)) > /proc/sys/vm/dirty_bytes

The thing is, that also accounts for dirty shared mmap pages. And it
really will kill some benchmarks that people take very very seriously.

And 200MB is peanuts when you're doing a benchmark on some studly
machine that has a million iops per second, and 200MB of dirty data is
nothing.

Yet it's probably much too big when you're on a workstation that still
has rotational media.

And the whole memcg code obviously makes this even more complicated.

Anyway, the end result of all this is that we have that
balance_dirty_pages() that is pretty darn complex and I suspect very
few people understand everything that goes on in that function.

So I think that the point of any write-behind logic would be to avoid
triggering the global limits as much as humanly possible - not just
getting the simple cases to write things out more quickly, but to
remove the complex global limit questions from (one) common and fairly
simple case.

Now, whether write-behind really _does_ help that, or whether it's
just yet another tweak and complication, I can't actually say. But I
don't think 'dirty_background_bytes' is really an argument against
write-behind, it's just one knob on the very complex dirty handling we
have.

            Linus
