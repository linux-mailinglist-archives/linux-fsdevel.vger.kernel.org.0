Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6574E37963C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 19:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhEJRnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 13:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbhEJRnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 13:43:24 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B5EC061761
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 10:42:19 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id f29so3905725qka.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:to:cc:subject;
        bh=n5gxQcJcWf8uN8nViJiC2oY2o4qpc3D4xM0tKR6YYWA=;
        b=IWPeC1KeCJWcRYiMi/iOkteNjl3MP0cQx6RWg3IG/lTEXG+OBFqZJ84ZKty0x0V1hA
         wWO4vZplz7tfGCQg2OV6cRT9D03LcQnDGInItUJ4R/NYr5RJY0QI0bdszTf6qKkkqmOd
         1FQRKCKPAl8QMuzpFRSg48xlfhpQZpTIn6LIuK5Aq4lKpQwysWDGQ0/UmFsPQY7/dhZ3
         5CpfDXUDx7eDnAHO3sKNFZJ/xSRpZSVO6nWf0LwZ1DH9rk2V9jdLBAm1mbcl9qMeLeGP
         3OhD1lZ8+lKsbnJZjS62/KlPRlCzHUt/lHTnk/S4rjJQjyFjLwdIYFrLUFpmLfO/tthm
         WHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject;
        bh=n5gxQcJcWf8uN8nViJiC2oY2o4qpc3D4xM0tKR6YYWA=;
        b=XeBTckmlfgUSbDNvUQBSil0qzjdA6HjiDwr4/OVGXyU2jQ0iiOCPfcJkRwDIjqbtIc
         DIDxtoicluuvZC/Z8qqiY1NH0dd82VaLsYBnRSENLrf/b6Y2YMreRID6UQKjceTaNgV6
         BVm/Opv/uMXwy/Apg0mcOSLNEKVOsgAexAWwXdAhjayjISmTCGpe41D5xrZUDdOyc4oA
         gXhHWAc9/is4ZM3jLyHMXhFNn/D5k1PgWWXRUY3kgz2d/w/8ww8E6Ft5qbrhmYAsC4/V
         IEKogomh375xMIU8/M5OKKu7CrSX9FgwEHrKXyfD8ZON+zNwCj/cuwSfR+xdUEjVdG3e
         W9DQ==
X-Gm-Message-State: AOAM530mKuI5pxxUr6XDH2awUhlTBYfwltrFXNNE/rdmz7HJbk3nMbVk
        //N3sgTomNTfaEEiwWWW2i+OUg==
X-Google-Smtp-Source: ABdhPJxQFETD6GAmxPhza4gO2s5UxBFf1tocdyjImVzCAogXWQ07nVOtv38yIho+4lIEBuKwJZC63w==
X-Received: by 2002:a37:a2d5:: with SMTP id l204mr22524422qke.331.1620668538377;
        Mon, 10 May 2021 10:42:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z30sm12740561qtm.11.2021.05.10.10.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:42:17 -0700 (PDT)
Message-ID: <60997079.1c69fb81.77f3f.a045@mx.google.com>
Date:   Mon, 10 May 2021 13:42:16 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     lsf-pc@lists.linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND] LSF/MM/BPF: 2021: Call for Proposals
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[apologies, 2021 and email is still my nemesis]

The annual Linux Storage, Filesystem, Memory Management, and BPF
(LSF/MM/BPF) Summit for 2021 will be held from December 6 to December 8
at The Margaritaville Resort Palm Springs in Palm Springs, California.
LSF/MM/BPF is an invitation-only technical workshop to map out
improvements to the Linux storage, filesystem, BPF, and memory
management subsystems that will make their way into the mainline kernel
within the coming years.

COVID is at the front of our minds as we attempt to put together the
best and safest conference we can arrange.  The logistics of how to hold
an in person event will change and evolve as we get closer to the actual
date, but rest assured we will do everything recommended by public
health officials.

LSF/MM/BPF 2021 will be a three day, stand-alone conference with four
subsystem-specific tracks, cross-track discussions, as well as BoF and
hacking sessions.

On behalf of the committee I am issuing a call for agenda proposals
that are suitable for cross-track discussion as well as technical
subjects for the breakout sessions.

If advance notice is required for visa applications then please point
that out in your proposal or request to attend, and submit the topic as
soon as possible.

This years instructions are similar to our 2020 attempt.  We're asking
that you please let us know you want to be invited by June 15th, 2021.
We realize that travel is an ever changing target, but it helps us get
an idea of possible attendance numbers.  Clearly things can and will, so
consider the request to attend deadline more about planning and less
about concrete plans.

1) Fill out the following Google form to request attendance and
suggest any topics

	https://forms.gle/Dms7xYPXLrriFkcXA

In previous years we have accidentally missed people's attendance
requests because they either didn't cc lsf-pc@ or we simply missed them
in the flurry of emails we get.  Our community is large and our
volunteers are busy, filling this out will help us make sure we don't
miss anybody.

2) Proposals for agenda topics should still be sent to the following
lists to allow for discussion among your peers.  This will help us
figure out which topics are important for the agenda.

        lsf-pc@lists.linux-foundation.org

and CC the mailing lists that are relevant for the topic in question:

        FS:     linux-fsdevel@vger.kernel.org
        MM:     linux-mm@kvack.org
        Block:  linux-block@vger.kernel.org
        ATA:    linux-ide@vger.kernel.org
        SCSI:   linux-scsi@vger.kernel.org
        NVMe:   linux-nvme@lists.infradead.org
        BPF:    bpf@vger.kernel.org

Please tag your proposal with [LSF/MM/BPF TOPIC] to make it easier to
track. In addition, please make sure to start a new thread for each
topic rather than following up to an existing one. Agenda topics and
attendees will be selected by the program committee, but the final
agenda will be formed by consensus of the attendees on the day.

We will try to cap attendance at around 25-30 per track to facilitate
discussions although the final numbers will depend on the room sizes
at the venue.

For discussion leaders, slides and visualizations are encouraged to
outline the subject matter and focus the discussions. Please refrain
from lengthy presentations and talks; the sessions are supposed to be
interactive, inclusive discussions.

There will be no recording or audio bridge. However, we expect that
written minutes will be published as we did in previous years:

2019: https://lwn.net/Articles/lsfmm2019/

2018: https://lwn.net/Articles/lsfmm2018/

2017: https://lwn.net/Articles/lsfmm2017/

2016: https://lwn.net/Articles/lsfmm2016/

2015: https://lwn.net/Articles/lsfmm2015/

2014: http://lwn.net/Articles/LSFMM2014/

3) If you have feedback on last year's meeting that we can use to
improve this year's, please also send that to:

        lsf-pc@lists.linux-foundation.org

Thank you on behalf of the program committee:

        Josef Bacik (Filesystems)
        Amir Goldstein (Filesystems)
        Martin K. Petersen (Storage)
        Omar Sandoval (Storage)
        Michal Hocko (MM)
        Dan Williams (MM)
        Alexei Starovoitov (BPF)
        Daniel Borkmann (BPF)
