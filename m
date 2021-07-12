Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0713C5E45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 16:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbhGLOXt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 10:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbhGLOXs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 10:23:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BADC0613DD;
        Mon, 12 Jul 2021 07:20:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v5so25878354wrt.3;
        Mon, 12 Jul 2021 07:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=McfcRUwTJvvEYnGyx2zdV84R9Ua8X5MJL0mSzDDl3X4=;
        b=CWROun1CdjvGboSFTQkv6sAppvuuPS7f/l3PB0E3owikaOeqb3QUYdUA8EKGraNI40
         sGpwFUAQad1jcHO8OpB04og6pmdgnkYlGL9JvgR5MXlLbjNXFOi2U1p+EtMfBCKoh6SU
         bWYI8AH/ki/7khGQD1zCeWfVwMoghgNmaOOHyTki8ALhdPtYuWiKGK8zK+pFoqN8OFop
         yHWyshAjGPkFswLS1uYoO29xmFNEDepggh1QBrEw/Azz283rLG7S0H6RCDeuIDrPjs07
         KZ2y9ISe4n+tRS4jlsiDQWyzhiCt7ZgyO+2AZ08obLfQ8e2iSTEp7XhS51tX6XGclKa/
         1ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=McfcRUwTJvvEYnGyx2zdV84R9Ua8X5MJL0mSzDDl3X4=;
        b=GKooTqY4zj/YN03ZPbcDdzQ8XpcjLZN5QQLJ5xuTPA20zXabMZbbhg84aWih1q1wPz
         +k7Q6x2aqEb//v6f0BrIGnPiaSndQUb4HIyo8u1LAnJ073K7RPa/boWkLga2CaeRoiKB
         rr5dMz8Ke4urjOltiaXQiypFl6Nyj2HAmwghXJC7P/PhU33I3zrZ1sNH5WK3/mozPiay
         8wea57+K8Z7RnpFFBZ9bU/TvkCBw6l2TUb1o9Nxrexo7bm8KFabY2H5XtwkNJwAjCldO
         RHbTSN4PUJkaSowWBrb6Cq4N3ddWZXYSULKjC2l0bdWFpoSKhdGpDBL3tHqoGOFkawXJ
         Uynw==
X-Gm-Message-State: AOAM532B+Ozujqcla8om1Vgxv2ulQqVZ1gCQ3XllaZZ/lgc4mo0LLyik
        TdYqGDI1f9tfBb4TrF8bhXvqyvRvAp1IgSC3Qrw=
X-Google-Smtp-Source: ABdhPJyYd9ZGZO8Zy9KQ4TQfI1VbC3hvQCkAR0yvDXiUTY27zHOidGVlcOMRfd35ZqGKgtbYnT8ZTmVl+s+zu16wlMc=
X-Received: by 2002:a5d:420b:: with SMTP id n11mr15661968wrq.395.1626099657917;
 Mon, 12 Jul 2021 07:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <162609463116.3133237.11899334298425929820.stgit@warthog.procyon.org.uk>
 <162609464716.3133237.10354897554363093252.stgit@warthog.procyon.org.uk>
In-Reply-To: <162609464716.3133237.10354897554363093252.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Mon, 12 Jul 2021 11:20:47 -0300
Message-ID: <CAB9dFdvHsLsw7CMnB+4cgciWDSqVjuij4mH3TaXnHQB8sz5rHw@mail.gmail.com>
Subject: Re: [PATCH 2/3] afs: check function return
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, Tom Rix <trix@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 9:57 AM David Howells <dhowells@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Static analysis reports this problem
>
> write.c:773:29: warning: Assigned value is garbage or undefined
>   mapping->writeback_index = next;
>                            ^ ~~~~
> The call to afs_writepages_region() can return without setting
> next.  So check the function return before using next.
>
> Fixes: e87b03f5830e ("afs: Prepare for use of THPs")
> Signed-off-by: Tom Rix <trix@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Link: https://lore.kernel.org/r/20210430155031.3287870-1-trix@redhat.com
> ---
>
>  fs/afs/write.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/afs/write.c b/fs/afs/write.c
> index 3104b62c2082..2794147f82ff 100644
> --- a/fs/afs/write.c
> +++ b/fs/afs/write.c
> @@ -777,7 +777,7 @@ int afs_writepages(struct address_space *mapping,
>                 mapping->writeback_index = next / PAGE_SIZE;

Isn't there the same issue with the use of next here.

>         } else if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX) {
>                 ret = afs_writepages_region(mapping, wbc, 0, LLONG_MAX, &next);
> -               if (wbc->nr_to_write > 0)
> +               if (wbc->nr_to_write > 0 && ret == 0)
>                         mapping->writeback_index = next;

Unrelated to this patch, but since next is a byte offset, should this
also divide by PAGE_SIZE as above.

>         } else {
>                 ret = afs_writepages_region(mapping, wbc,
>
>

Marc
