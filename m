Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDF82D7AE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 17:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395078AbgLKQ1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 11:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389903AbgLKQ1U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 11:27:20 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5422BC0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 08:26:40 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id j20so4225102otq.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 08:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=wEY5iQcs/Fj6h99+G9QeWnKZkH/sJkXYKVIMx/B5PtE=;
        b=RI5zPRqssSxSKTNuS0Co+JAzDkMOOzOTLJA0hTfPnvxcDSgo3R74h3yQwlaeGbQ1re
         ZYmbjHVIL9S5is5Sfe8FavfbIV6ivuDYppKgaTA3FHbEk2ah3X+1h0XwpACSjNK87cwy
         CEjcpST11bOHI6JYIfjz5iv37qjN2F06aEfhJeQPsMp3RA+xahyaO6xM9zrOMM4LD5p9
         via/3OoemkbhF9dAemz22AQxJOzaxHuL9JWdnGRrrqb1XSqmR+t4gI/vXBjZR0n94fBv
         5nZNFBRgm0y+Bic0g8J3GcuKG62R63CyvNLOo+srtje+cXfjvaEN2GYdBmm4y47XERKv
         n7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wEY5iQcs/Fj6h99+G9QeWnKZkH/sJkXYKVIMx/B5PtE=;
        b=o/qQzFY+YUj1F1ZLXKNOrqz+SPr4qOTPOkcV9Upd3DAyJFrdmbOWTwCgcKQjYQTZyP
         Ra7rDqMoUNIZ0oZrW/qqEqX/H7hkSv8AocvfIRaV+4V1i2EeWNrIo4cbYyJV0BTN8w/z
         mPJM+/J9s/61uWnE3Iflwf0b6euX/VTxk0zt07YM5byYh6cNhkuyppFIe0qvj8VmRpOT
         u2pg1Yy2OE2P/hyw5bt+MjgiHQUec/uX1FwGdvQBJzEMM8G5mfjYQdpnT5NtNF9KYcug
         KQ6XYHitBXFn7B/O4mpQA1c3oKHqU0MRgqwbvY9UBO74g6geBuRi9OONcCKl8PEW6868
         Guvg==
X-Gm-Message-State: AOAM530ABCTZF6rh0x5tdbNOx5F9m6Np7oy5aRMWCsyPErHwpPOJW+fb
        9isJDnfRE1nZ/aK740zhqp/e/4Fe/0plgD30LRGO3nj24pP+Zq9u
X-Google-Smtp-Source: ABdhPJxOkLZmH8l+KXfEZSm9D296byfO8XJFQeKyHJUuSZaXKM6BjjtCwfra5YoKkS6AYYRll3K6WX33a0dF7w2ml+U=
X-Received: by 2002:a05:6830:1411:: with SMTP id v17mr6919201otp.352.1607703999357;
 Fri, 11 Dec 2020 08:26:39 -0800 (PST)
MIME-Version: 1.0
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Fri, 11 Dec 2020 11:26:28 -0500
Message-ID: <CAOg9mSSCsPPYpHGAWVHoY5bO8DozzFNWXTi39XBc+GhDmWcRTA@mail.gmail.com>
Subject: "do_copy_range:: Invalid argument"
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcapsc@gmail.com>,
        Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greetings everyone...

Omnibond has sent me off doing some testing chores lately.
I made no Orangefs patches for 5.9 or 5.10 and none were sent,
but I thought I should at least run through xfstests.

There are tests that fail on 5.10-rc6 that didn't fail
on 5.8-rc7, and I've done enough looking to see that the
failure reasons all seem related.

I will, of course, keep looking to try and understand these
failures. Bisection might lead me somewhere. In case the
notes I've taken so far trigger any of y'all to give me
any (constructive :-) ) suggestions, I've included them below.

-Mike

---------------------------------------------------------------------

generic/075
  58rc7: ? (check.log says it ran, results file missing)
  510rc6: failed, "do_copy_range:: Invalid argument"
          read the tests/generic/075 commit message for "detect
          preallocation support for fsx tests"

generic/091
  58rc7: passed, but skipped fallocate parts "filesystem does not support"
  510rc6: failed, "do_copy_range:: Invalid argument"

generic/112
  58rc7: ? (check.log says it ran, results file missing)
  510rc6: failed, "do_copy_range:: Invalid argument"

generic/127
  58rc7: ? (check.log says it ran, results file missing)
  510rc6: failed, "do_copy_range:: Invalid argument"

generic/249
  58rc7: passed
  510rc6: failed, "sendfile: Invalid argument"
          man 2 sendfile -> "SEE ALSO copy_file_range(2)"

generic/263
  58rc7: passed
  510rc6: failed, "do_copy_range:: Invalid argument"

generic/434
  58rc7: failed "copy_range: Bad file descriptor"
  510rc6: not run "xfs_io copy_range failed (old kernel/wrong fs/bad args?)"
