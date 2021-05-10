Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC2337931E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 17:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhEJPyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 11:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbhEJPyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 11:54:01 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DDFC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 08:52:55 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 76so15765774qkn.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 08:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:subject;
        bh=NYc/MZlBlwt5YgNQkkROXA//MB1afSMHWoiK5K7m2hY=;
        b=J4W070uW9JkndTf7txYxLYi9FZsIaQ1IFg+rqbFyf7654TnBq2HEXAn6Zny3qY1O4C
         WD0oGmdMJFQwcF+DY4mM+PGvaBvyPVHJEbr73g6Hp24q2mjAoCe+gy0ebSQIoCNawwQf
         /is5s+wKr8R1Q5QnfyzjF3m6EtcGZO8mnmdSzJbbfCNPcxSbCVF9lXB9jJKLDPPrKz6f
         ztAhCOCezjumz5Ahheuaq/V2AtbhxeCpJzQt96+bBiXaYbhu4BImFEJV0lbFhYfGRIzK
         8aroHfzwS/3SVQx0dFx8bcEDwiHHh8H3RjYcg2Y2eVuayvngdZ7iAoXgZEO1i70Ib6wL
         5NCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject;
        bh=NYc/MZlBlwt5YgNQkkROXA//MB1afSMHWoiK5K7m2hY=;
        b=q8bdFizOJnM/G3yHvRIMaPH6Zdfz4PsZNo6A8Eu3L7aqbZ14W1KtDb6lWNO7sOAZZv
         zwTVpUnppIyPFLPd70XFnvVEWaPDBGJ/LL1Uq8gfkx53qRug4CX8iBbV2MdjRkMMWHHM
         0doVcsjFFgEagyhZgHCDORc0xyPCa2nUm9HeGN2HM+2ihO3VB7lfmMRwwc5BVnv67ycc
         GU+KlZd8F3g2Uiq0ZJRsEFlac3NmgbzjAidDliYsQfNn0YshWXlpZO5YFS5zwUlAOPE5
         H5+Go2F7tlO9OmD5hAE48rNnwGBFR/YgG0auMqY7vwvOaT3pvptbWLOUicS0USAzONLR
         2X4Q==
X-Gm-Message-State: AOAM531qIqeTKt7xr6J1cszBm0sNU6g9KY7g4ZJ59jrZjGf9LQWw+k8W
        v9dhco2aXXOmBSerD5DU39x3/A==
X-Google-Smtp-Source: ABdhPJxC6gQVkPwzSWD5MfvNquR7Yv7Zt6rZ1PhjOm6M6tjviv/fH8SGjHWCdN94LOptT0LD/21LVg==
X-Received: by 2002:a05:620a:1678:: with SMTP id d24mr22024622qko.317.1620661974254;
        Mon, 10 May 2021 08:52:54 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z4sm11717198qtv.7.2021.05.10.08.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 08:52:53 -0700 (PDT)
Message-ID: <609956d5.1c69fb81.66457.441a@mx.google.com>
Date:   Mon, 10 May 2021 11:52:52 -0400
From:   Josef Bacik <josef@toxicpanda.com>
Subject: LSF/MM/BPF: 2021: Call for Proposals
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
