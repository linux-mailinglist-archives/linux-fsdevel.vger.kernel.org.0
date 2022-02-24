Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F39A4C30B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 17:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiBXQAQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 11:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiBXQAO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:00:14 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC3B1795D1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 07:59:31 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id ba20so4363529qvb.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 07:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=gqOgm8FvfYxrPnxT+G4DW2qNZzJhArG622fIixWhtpg=;
        b=h5ZN26X5NAmhxjI2cNyZTmm5+2BZQaB4PhQXbBOhwml31PknsRkSxpnie5Pk4e0n8N
         ucMddJt/VKcrD9FCGE1zCONNj+58mibz9qaTly7ZSs8IOPNpfWSdXIk9bJOyY3v2osKR
         fbaKNoDJ5JuvmWbPO700vsU0BSR38IoUkcctt81R1wocDgUthuwF+/lFAHdfS3zgLGgC
         LpHaI3b7NWCQPs6HVwySmgr9xSeRIEpx6+ByISYyqPZ7GlchosjA+y3B47saPKpwOWcA
         QUFvAm0akg5UlWQlGCmRw+5HXyDvIck88WNhoeWOXMTwVNMR3907iZEJ4Rb23hd08jHx
         Am1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=gqOgm8FvfYxrPnxT+G4DW2qNZzJhArG622fIixWhtpg=;
        b=6X57g0wgGbT9mXDcYkfO6048w2doS+T3K27sA9TYoXYyF4NES5fJGL3iYk91H+Msqk
         Em4W4ljEkpz7ImNCel3xIPPJ2J6HS0VJBAyI59OCxqlT6UJLPOLW8TFvDe5JvMb1GaCp
         V5RLSi6aURh7nXVGwqE98oTVlesAVvgm4fRkowG4rcFMkCP0Iwz6OdUbVmOJxijR5TlP
         LsG70fGA3HFgo+ovRAKPeKUb8TXFdc8L65ChDp4bCAui5V6zn3O/DeqCqIKgLeDsOnBT
         xZxvILvRl2PUt/Zfw5qFKMgtZUa6MQr7Jy4I6JdBcDZadH9z6coqfvlyUQf/GDP2ciRS
         XGWA==
X-Gm-Message-State: AOAM531+wTm0HIIHqymVjLYSgCXh2TbZoLTn+ep4md00xsAR0iM8Yh6e
        NYG5c7FUhk7qFZCW/94K7h8tMg==
X-Google-Smtp-Source: ABdhPJyLQ1BrprrPj7Z/ncbZLKkWpbFJ6QCGUwxS4i7cOHcc1fXc5hBuljJyNTFV6nRd3+MQsFxngQ==
X-Received: by 2002:ac8:578c:0:b0:2de:7281:6234 with SMTP id v12-20020ac8578c000000b002de72816234mr2991255qta.359.1645718365211;
        Thu, 24 Feb 2022 07:59:25 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z14sm1739862qtw.56.2022.02.24.07.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:59:24 -0800 (PST)
Date:   Thu, 24 Feb 2022 10:59:23 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     lsf-pc@lists.linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [REMINDER] LSF/MM/BPF: 2022: Call for Proposals
Message-ID: <YherWymi1E/hP/sS@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A few updates

- The COVID related restrictions can be found here 

	https://events.linuxfoundation.org/lsfmm/attend/health-and-safety/

- We are working on a virtual component, however it will likely not be
  interactive, likely just a live stream and then an IRC channel to ask
  questions through.

--- Original email ---

The annual Linux Storage, Filesystem, Memory Management, and BPF
(LSF/MM/BPF) Summit for 2022 will be held from May 2 to May 4 at The
Margaritaville Resort Palm Springs in Palm Springs, California.
LSF/MM/BPF is an invitation-only technical workshop to map out
improvements to the Linux storage, filesystem, BPF, and memory
management subsystems that will make their way into the mainline kernel
within the coming years.

COVID is at the front of our minds as we attempt to put together the
best and safest conference we can arrange.  The logistics of how to hold
an in person event will change and evolve as we get closer to the actual
date, but rest assured we will do everything recommended by public
health officials.

LSF/MM/BPF 2022 will be a three day, stand-alone conference with four
subsystem-specific tracks, cross-track discussions, as well as BoF and
hacking sessions.

On behalf of the committee I am issuing a call for agenda proposals
that are suitable for cross-track discussion as well as technical
subjects for the breakout sessions.

If advance notice is required for visa applications then please point
that out in your proposal or request to attend, and submit the topic as
soon as possible.

This years instructions are similar to our previous attempts.  We're
asking that you please let us know you want to be invited by March 1,
2022.  We realize that travel is an ever changing target, but it helps
us get an idea of possible attendance numbers.  Clearly things can and
will change, so consider the request to attend deadline more about
planning and less about concrete plans.

1) Fill out the following Google form to request attendance and
suggest any topics

	https://forms.gle/uD5tbZYGpaRXPnE19

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
