Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F8764CFF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 20:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbiLNTQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Dec 2022 14:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238809AbiLNTQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Dec 2022 14:16:02 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C03160EA
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Dec 2022 11:15:54 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id h10so414975qvq.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Dec 2022 11:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8hfd8zAToSdzoK0fgf7KAIEFt+FxnQhco6jJDWQ8kcw=;
        b=dR+feQN0VFxYmzmPqpClZWVGlfFTTob0isDNrP7epY7UpEsSnly93dg8s/XEKllovj
         tETGg8V/bNsv0TetZPWH1+eCm6rHOmwe3F+EAfyYLaszin7VR7QSwJnJAZcvsIaBFtUI
         WBqlHvNzR4ocrWP6HRv+JEJtTwI9hQIahHkaxOfJTdLt+T25MneMN2G1Uh8W63IZDQIc
         wLNBxrX1SXS6dSekF2cYwHujD4bqfPKmPAfHKchzmI1jkW4le4Y4ZVkBzbnlzqCZQCvl
         u4NpGyM8aM2Lp3XbyfCMgbbjPQBYlb4D3hpSfglotEhvTbJDcB+hcZ09QNfTKr/h11tM
         s0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8hfd8zAToSdzoK0fgf7KAIEFt+FxnQhco6jJDWQ8kcw=;
        b=eFH8rNCSopyxRw+rWj/IWNPSUQvsWkgfcIZD1ju2brRMxIgzAa6lBRpzFjssL4nOob
         XaxkThmMASSzMTAiPI7ulCHYK6bSrFbIpTOY6YqNoKgccNoOlNKkY5zncFAsDWXBWHPZ
         oV3PnSL2jHn5ipdJZmEDO1OO/kF+SPl5AKops2UsxBQ7rdzgfr8bN3HPgSU5gEwJweWy
         gEv4G5PReh7ULUNUL7j/chghfsWQQ2fVpCwa3JCXXiDefk8EzwsfC3/4Qni3/a1wo9Hq
         fqgX+dLXVw+ls798Cd3WUuWGu5CzX/QBRFxQs3kjyMm3ZJm4/mdiOnmZxLvpgqSip+Kn
         2uUw==
X-Gm-Message-State: ANoB5pl7OqXEjWT+fGK0KZT8jhAkScw/3uaT1N/xG0HCX/MG4dDZ6Z8i
        p6uXxo1fkCq32ySgD1JDWzRcXhdELHcC9bXUzSmItV3PeWt7/oY2
X-Google-Smtp-Source: AA0mqf53mDWZFIYq5wZXD6e8D8URM20PslKERiFkl3uLqhw2khmXGyf37Rj510P8fAs0dRrRGp1Fi8yrK36O3OCTlMM=
X-Received: by 2002:a0c:90c3:0:b0:4c7:e13:6459 with SMTP id
 p61-20020a0c90c3000000b004c70e136459mr36460242qvp.11.1671045353367; Wed, 14
 Dec 2022 11:15:53 -0800 (PST)
MIME-Version: 1.0
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Wed, 14 Dec 2022 14:15:42 -0500
Message-ID: <CAOg9mSR0m_Tb_1uKHMXseJ2AEUpvN3siaJd9rC-Fykx4QEXMXA@mail.gmail.com>
Subject: [GIT PULL] orangefs pull request for 6.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     devel@lists.orangefs.org, Mike Marshall <hubcap@omnibond.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit b7b275e60bcd5f89771e865a8239325f86d9927d:

  Linux 6.1-rc7 (2022-11-27 13:31:48 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git/
tags/for-linus-6.2-ofs1

for you to fetch changes up to 31720a2b109b3080eb77e97b8f6f50a27b4ae599:

  orangefs: Fix kmemleak in orangefs_{kernel,client}_debug_init()
(2022-12-07 15:18:30 -0500)

----------------------------------------------------------------
orangefs: four fixes from Zhang Xiaoxu and two from Colin Ian King

Zhang: fixed problems with memory leaks on exit in sysfs and debufs.
fs/orangefs/orangefs-debugfs.c
fs/orangefs/orangefs-sysfs.c
fs/orangefs/orangefs-debugfs.c
fs/orangefs/orangefs-mod.c

Colin: removed an unused variable and an unneeded assignment.
fs/orangefs/file.c
fs/orangefs/inode.c

----------------------------------------------------------------
Colin Ian King (2):
      orangefs: remove variable i
      orangefs: remove redundant assignment to variable buffer_index

Zhang Xiaoxu (4):
      orangefs: Fix sysfs not cleanup when dev init failed
      orangefs: Fix kmemleak in orangefs_prepare_debugfs_help_string()
      orangefs: Fix kmemleak in orangefs_sysfs_init()
      orangefs: Fix kmemleak in orangefs_{kernel,client}_debug_init()

 fs/orangefs/file.c             |  1 -
 fs/orangefs/inode.c            |  2 --
 fs/orangefs/orangefs-debugfs.c | 29 ++++-------------
 fs/orangefs/orangefs-mod.c     |  8 ++---
 fs/orangefs/orangefs-sysfs.c   | 71 +++++++++++++++++++++++++++++++++++++-----
 5 files changed, 73 insertions(+), 38 deletions(-)
