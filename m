Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5140370F19
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 May 2021 22:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhEBUqZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 May 2021 16:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbhEBUqY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 May 2021 16:46:24 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DE9C06174A
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 May 2021 13:45:31 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso3415517otl.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 May 2021 13:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZAWR/AtSG5ik0bvSTyxjIBnXL5mpDrCsqNQ6/Q5sDqU=;
        b=MWDCeEbZlUSc6ckBq31gHlbkRfVlEuN48p7cI1VNGLjxHQmGQinWhcHOxLs13wnu50
         fqkt/y7X2SJJlAETGO9ZlKV5xJSkdDR3nPNUQoulFAXQXLH3PsGNcsG2OvBWgJZcqlLA
         JSPpch8gBXAS83ERr7CiMqsXyrlrg4ySMvO+HUEKxD0/JARM9ZlyXiiKSZCokdyL4IOL
         0VK3TUA0WPJ7tVyoBHuW+okO3QOd3fUuA6GJaWTzrqybjhDal5zZb5umf4/4Jcm2fceT
         OA/bfmYKYZj3e+/Lnt8srgSGOxJtkDArnPSGsUYJsPrvBYudrRGxzxueQBlaUAG1QgTK
         kFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZAWR/AtSG5ik0bvSTyxjIBnXL5mpDrCsqNQ6/Q5sDqU=;
        b=PrZP2npnHiVh74ABFVbvUjfWmAz1RFP4UhaVnHOvApLPpOJ0g/ar9qxzZ8CNRmbNWN
         Nrs0u11fwMEBSwn8l4SHAPJlEFNhhejBDh3f6f9Nk7HkXOj09fiG9CIfQIxQ4YNtM88q
         ++C6WXUMvc40nKnr00bm9C++iMqTFQ0gUHNIlL4jjhWoendJQDQ3zcKHzepoBCMSfRuj
         hhzpJ7ZckPY/tVxccqzcSDNkxN4l9iFW3vmTt14zG3Gt/Fydr39NOHS6xJLeGT9BxJH+
         mcGyhBtQINngW9ciBwJxYHmYmoRDMIvQsk+kEWnk9oR7HL2XnD+5cYLxBObUMduSi4ba
         APmA==
X-Gm-Message-State: AOAM531772PnX1BU+qrfsqV7sSjps4YB1+9iU7FLN4l1d6t3KTeDYsQk
        0ybcf4EufOc6sx8mAEhuwK6tJq9ERdaQUPT6jlp6kA==
X-Google-Smtp-Source: ABdhPJyjf5NKx40kBiBU+rhK690IjTeW4GnXNRPbvo09VMknwbYsDFmpJYe+BHH+uX0Mj6hhKrfchu7BkNuIqAzwgJg=
X-Received: by 2002:a05:6830:3495:: with SMTP id c21mr10465240otu.53.1619988330925;
 Sun, 02 May 2021 13:45:30 -0700 (PDT)
MIME-Version: 1.0
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Sun, 2 May 2021 16:45:19 -0400
Message-ID: <CAOg9mSQ-p8vJ6LbSeTeNUCfu-PsT2=iS2+Kab-LYCu9h6MUu2A@mail.gmail.com>
Subject: [GIT PULL] orangefs pull request for 5.13
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Mike Marshall <hubcapsc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit acd3d28594536e9096c1ea76c5867d8a68babef6:

  Merge tag 'fixes-v5.13' of
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
(2021-04-27 19:32:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-5.13-ofs-1

for you to fetch changes up to 211f9f2e0503efa4023a46920e7ad07377b4ec58:

  orangefs: leave files in the page cache for a few micro seconds at
least (2021-04-29 08:06:05 -0400)

----------------------------------------------------------------
orangefs: implement orangefs_readahead

mm/readahead.c/read_pages was quite a bit different back
when I put my open-coded readahead logic into orangefs_readpage.
It seemed to work as designed then, it is a trainwreck now.

This patch implements orangefs_readahead using new xarray
and readahead_expand features that have just been pulled and
removes all my open-coded readahead logic.

This patch results in an extreme read performance improvement,
these sample numbers are from my test VM:

Here's an example of what's upstream in
5.11.8-200.fc33.x86_64:

30+0 records in
30+0 records out
125829120 bytes (126 MB, 120 MiB) copied, 5.77943 s, 21.8 MB/s

And here's this version of orangefs_readahead on top of
5.12.0-rc4:

30+0 records in
30+0 records out
125829120 bytes (126 MB, 120 MiB) copied, 0.325919 s, 386 MB/s

There are four xfstest regressions with this patch. David Howells
and Matthew Wilcox have been helping me work with this code. One
of the regressions has gone away with the most recent version of
their code that I'm using. I hope this patch can be
pulled even though there are still a few regressions, and that
we can try to get them resolved during the RC period.

----------------------------------------------------------------
Mike Marshall (2):
      Orangef: implement orangefs_readahead.
      orangefs: leave files in the page cache for a few micro seconds at least

 fs/orangefs/file.c         |  34 +++----------
 fs/orangefs/inode.c        | 122 +++++++++++++++++----------------------------
 fs/orangefs/orangefs-mod.c |   2 +-
 3 files changed, 54 insertions(+), 104 deletions(-)
