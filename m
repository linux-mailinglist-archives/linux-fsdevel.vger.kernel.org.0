Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CDE3A9E6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 17:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhFPPEO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 11:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbhFPPEM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:04:12 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582EBC061767
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 08:02:06 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id x6so1702716qvx.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 08:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:to:cc:subject;
        bh=VCvQSABjEdEuwxE7dUwxvVJle5680VQCMhFOlxSQ0RU=;
        b=1JHFKXXWxomTbkugVQMZnpalACfTC8IlhOqgFvXblCYSIV7KNdgtakEsiLHcEej6RT
         JMoGmH/y0ghKIyrRakbnD9xBFw8SxlZryrGCRT8fl0oiHQetebcqzmfoUogSF9v0kAIW
         eDJreJOM1uKAxARBQLgDGsmB8eZZl1YTybntm+qGmc+RuZMpi4gM4BhV1qDurg6d0kDD
         2T97LEdmKUz4vZZ3ssL+4B2CMbb4CCvfPD40tcjIGGkpP0vlqoEis5WjiBG1xhdz25EG
         n0B94JW6T5shp64W3FCHZibHWYySzxnd9yvc4aK2zyBH0mnbxKxxYVV79CGpyznCfnJq
         RY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject;
        bh=VCvQSABjEdEuwxE7dUwxvVJle5680VQCMhFOlxSQ0RU=;
        b=UxVaU0Ffxjcu2LRRIyN9jp2YXZ/9V/7Y2/yQJgygX/5Q3Vyx94oiIeq4Y4aClobmF8
         y9sQ2zhGXrAMm7pdYJR6e6j/TL6zQpHP8i+eLmxSqISnvf3AMnGObpZpR4wOReQCerUk
         MDsTS3uTTJxZYEdCBgHtdmFFQuYdZM/qrH7HbU0yiHZG2ffV2GkYa39Hc0vesRpIXieT
         3pEa1uvuwumuTFmjJjqsSnJ1Dvko6VIbOHVH+QqZgNHSw58Q29s2ldgv+5ar7pfNMB/z
         D5FFYD5+mY5UUhQoXa+0YpnhsM1T682nArzmAqz9bE7K9ySnLqeOB0eHhnL6YoQ3M+Mo
         UQFQ==
X-Gm-Message-State: AOAM53254L0EUHFmnimZ1jdnm7D9Ho0uw7+O383HOu7ltYaLBpm4uk7i
        9y7Bt19VqZTa8wLxRQG+z5aPNA==
X-Google-Smtp-Source: ABdhPJytC9l/wfvfg7sP8rjAGewkfuTAUH85RNI3r+SM2Ul/Q9EdT8cKP9pkjx6l7tAtOlLX0/G9Rw==
X-Received: by 2002:a0c:ed46:: with SMTP id v6mr465673qvq.46.1623855724103;
        Wed, 16 Jun 2021 08:02:04 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y20sm1390690qtv.64.2021.06.16.08.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 08:02:03 -0700 (PDT)
Message-ID: <60ca126b.1c69fb81.90af4.93a7@mx.google.com>
Date:   Wed, 16 Jun 2021 11:02:02 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     lsf-pc@lists.linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [REMINDER] LSF/MM/BPF: 2021: Call for Proposals
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thisi is just a reminder that we're still going ahead with an in person
LSF/MM/BPF this year.  The Linux Foundation is working out the safety
guidelines and will update the landing page when that is nailed down.
In the meantime there is plenty of time to register your interest in
attending.  Thanks,

Josef

---- Original CFP ----

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
