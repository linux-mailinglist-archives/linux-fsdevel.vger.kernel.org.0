Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F54E403E62
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 19:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352458AbhIHRco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 13:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243885AbhIHRco (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:32:44 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209A8C061575
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Sep 2021 10:31:36 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b10so4292649ioq.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Sep 2021 10:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=duZ5E3NZsgihRwUYX80opx0vLIiLAbQLZee2e474/Hg=;
        b=kgasMJ6uDyvDFhbbfAbqGk4s2fOpi819c3KZLDepTVhJ9b3wqghPreR5wp/0lcBvCn
         qs8zyOxpuUXUKjvP4y7X7BFH82dvEYFnob0E5/6yf5dsRK09K55H1KfUhhr9EPqgjiM7
         j87UMXX/rBfOdBYGYMKzKjQMHynrNphSUE6w2E8RMiofke+X46/FQl0CNvblUQi8FZZa
         KT+tIPruQlgLURwg7dmrluTOX918Lg6rw2q/41GYThvSJdceiYYLpceUDnEQeyWkZ/ni
         sRMRzFOOGMgM1Isunuttx5/H3H9sON9DGuf9bhn4EiTupbfoHejgqAF4Oj/V7UrQN2uu
         +YkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=duZ5E3NZsgihRwUYX80opx0vLIiLAbQLZee2e474/Hg=;
        b=0RXin90ZwJ9hEj7NlCBIRMQaET0r953u2va9vl0xki2adyM9kYBpAp6cHn9Uf5VxaY
         6sHmN442xy95+HZdQiV3Bd6hpWN74ISpi8sY/CB+FYSq5YSocn38et7xbkMoY9ieLklQ
         czfyjAef0PdLKcEI/f//Aic3r4iiCVRWkBxW5GyA2P2n0eeNLTlbtXWhfaZVn0VKbvzR
         Sn1ZaU8Iezp37/vSYea+lGTIQCuyBbS2eBwPAx2cjKgt3lZfA68RB4HVmZf1n43uvTaZ
         h3r44A2qT5YEj5yYddNR0Kqcr5U05wgndoimsfyzUHAQ4I3BJ7KswnB9mwls3PpbD81o
         uA8Q==
X-Gm-Message-State: AOAM530d2l421fWGtmILTXS/s8PQwr8K1NXnfr6pURiGjce/oEoHjcXu
        8IR+6Sapwnz/iHO6VmdkSggCWN/pms4Mh32Ba+4SvBCDuRU=
X-Google-Smtp-Source: ABdhPJxts4E0M8SZIPAgEvqHESBMbANh1Qk3Tt+UY6mo21rd0IWrqTHXHEkCR2Q9KMCUN+laXYA/5yYOeBP+unIGuoo=
X-Received: by 2002:a6b:f007:: with SMTP id w7mr863792ioc.112.1631122295566;
 Wed, 08 Sep 2021 10:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <3bffa6b2-981f-9a64-9fed-f211bfe501cd@oracle.com>
In-Reply-To: <3bffa6b2-981f-9a64-9fed-f211bfe501cd@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 8 Sep 2021 20:31:24 +0300
Message-ID: <CAOQ4uxhAdLBFRXjJOA8G_7KYGv=mm5dWOpYX7-=TdahUwya26A@mail.gmail.com>
Subject: Re: [TOPIC LPC] Filesystem Shrink
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 8, 2021 at 10:51 AM Allison Henderson
<allison.henderson@oracle.com> wrote:
>
> Hi All,
>
> Earlier this month I had sent out a lpc micro conference proposal for
> file system shrink.  It sounds like the talk is of interest, but folks
> recommended I forward the discussion to fsdevel for more feed back.
> Below is the abstract for the talk:
>
>
> File system shrink allows a file system to be reduced in size by some
> specified size blocks as long as the file system has enough unallocated
> space to do so.  This operation is currently unsupported in xfs.  Though
> a file system can be backed up and recreated in smaller sizes, this is
> not functionally the same as an in place resize.  Implementing this
> feature is costly in terms of developer time and resources, so it is
> important to consider the motivations to implement this feature.  This
> talk would aim to discuss any user stories for this feature.  What are
> the possible cases for a user needing to shrink the file system after
> creation, and by how much?  Can these requirements be satisfied with a
> simpler mkfs option to backup an existing file system into a new but
> smaller filesystem?  In the cases of creating a rootfs, will a protofile
> suffice?  If the shrink feature is needed, we should further discuss the
> APIs that users would need.
>
> Beyond the user stories, it is also worth discussing implementation
> challenges.  Reflink and parent pointers can assist in facilitating
> shrink operations, but is it reasonable to make them requirements for
> shrink?  Gathering feedback and addressing these challenges will help
> guide future development efforts for this feature.
>
>
> Comments and feedback are appreciated!
> Thanks!
>

Hi Allison,

That sounds like an interesting topic for discussion.
It reminds me of a cool proposal that Dave posted a while back [1]
about limiting the thin provisioned disk usage of xfs.

I imagine that online shrinking would involve limiting new block
allocations to a certain blockdev offset (or AG) am I right?
I wonder, how is statfs() going to present the available/free blocks
information in that state?

If high blocks are presented as free then users may encounter
surprising ENOSPC.
If all high blocks are presented as used, then removing files
in high space, won't free up available disk space.
There is an option to reduce total size and present the high blocks
as over committed disk usage, but that is going to be weird...

Have you spent any time considering these user visible
implications?

Thanks,
Amir.

[1] https://lore.kernel.org/linux-xfs/20171026083322.20428-1-david@fromorbit.com/
