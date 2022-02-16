Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFF14B81F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 08:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiBPHpG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 02:45:06 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiBPHpE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:45:04 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634F019FB1C;
        Tue, 15 Feb 2022 23:44:48 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id f19so1397421qvb.6;
        Tue, 15 Feb 2022 23:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=UWEGrk+MNpARhvbHzf+0g0kbbtIVAtwr34HOg+Y5lQ8=;
        b=C+OB9n0G4yzpDcvquHEP75OsJsd5/Q+aKf3O2aGNS0GlZ97qy1HxD1ckACWlyc3FiA
         Lbezk2QubuMq2BNnYZrR2Z8ADcD/4bDIO/LwjCTqFfPR47svSBnASq2GWjFwuSnuy0Bq
         cveZvmB6FJEsIjpAXOY85UfCMsm2/EYzL+aq9wmKJcMZrYxZKqjO/sxT/DanTJHrFlov
         K05/jvbD8IwKK9xRcpAPqr5tfjlA37IQfnK4K01hzjS8mR+6pRuJAUDZYF8jjLxwDUjc
         2iLydAyhPf1B39aGhsQkldKZV1buNO8KifSBpvB2+o+2bFSJhf0I2jpQvGjvlTYPQflo
         vUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=UWEGrk+MNpARhvbHzf+0g0kbbtIVAtwr34HOg+Y5lQ8=;
        b=yvZr3naBitOupErgThEpMYq6qloqV2rvmtae5WKiT0mnq3zfPabRTJHS/cvGofikBU
         WEvhsiK4bfhB26WQonh9U20QaxkPhNKPT65dRNGW1Bd/YAllomG/dkE7auaOg/vdNpuj
         4ZupyKDAxf2DcbaNYTDBp1lO+yJTYDZ9ftFPkrC2pXWVhieLcnCZgwoPxa9FI3MgIHaJ
         823ZUclplNYUjYl+wHXvfq3KFdE+1FeAaLFLeD9NQdRnClIIrSeaYeod0kyZDQ/NwXWr
         nrc4IE4sMXDgb9wCFH4cj92jhpR5Zns+VR9/fVhBaGQpnblVICWmRhYDsSqRWCZUwAP9
         dLYw==
X-Gm-Message-State: AOAM5305XDuFRKqxfpFHCXQdFnqCfaAQHOJ43BZOyUS5y/qtYEDcInRk
        7ByoHRHrJrErkEaaDYtB+XJVVKmFYA==
X-Google-Smtp-Source: ABdhPJxsbDjRuJvF5LEmbr3ifWA1U3ttEPmd/+1OwW5iNVilh29ICip3BeCVK7EhOlE8lF4p+wS6Pw==
X-Received: by 2002:ad4:4f83:0:b0:42f:5997:d3de with SMTP id em3-20020ad44f83000000b0042f5997d3demr1034511qvb.82.1644997478729;
        Tue, 15 Feb 2022 23:44:38 -0800 (PST)
Received: from zaphod.evilpiepirate.org (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id 22sm22037811qtw.75.2022.02.15.23.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 23:44:37 -0800 (PST)
Date:   Wed, 16 Feb 2022 02:44:33 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org
Subject: [LSF/MM/BPF TOPIC] bcachefs
Message-ID: <20220216074433.u726dkh2q2wdtwne@zaphod.evilpiepirate.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, I'd like to come give an update on bcachefs.

It's been a long road going from bcache, and starting with what was essentially
a prototype for a new filesystem, and turning it into a real (scalable, robust,
full featured) filesystem.

Over the past few years, we've added reflink, subvolumes and snapshots. I'm
particularly proud of how snapshots turned out - it's roughly a versioned btree
approach, and it's scalable and fast, even fsck is O(number of keys of
metadata), not O(number of snapshots). I've got it up to a million snapshots in
a test VM.

The bigger thing though is that the core fundamentals are pretty close to done -
replacing all the "periodically walk the world" algorigthms with real persistent
data structures that scale. A big allocator rewrite is about to land, and after
that will be backpointers - to fix copygc scanning.

Things are in flux lately with all the allocator work, but I'm hoping once that
settles down and I've worked through the backlog of bug reports and performance
regressions, we might be ready for upstreaming sometime this year...
