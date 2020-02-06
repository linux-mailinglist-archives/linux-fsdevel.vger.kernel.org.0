Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC67154F05
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 23:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgBFWlK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 17:41:10 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38577 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgBFWlK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 17:41:10 -0500
Received: by mail-vs1-f65.google.com with SMTP id r18so10052vso.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 14:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=W+qTMbfn4QUtv7a6hFfeYubmWeE151RiueufqBqh4U8=;
        b=EpzM6UG+L/eGBoZFzHhHAkm2l4NIPEzufrXCNiS6/ppOc0QUsQPiUxdnlv6rCVbvp0
         /gTFBIX1akoj/hRSFJSqb1oodhS1w2Xii6S8TLNhY21hTVbIGyNvC/bnh2lf2P8f02Tj
         FF86Xw5pmlYbFni2mPWuJxW7USUst2J9q6IsXt8pqvV/H4GUHOw+P9dgnu/aF88+UkNG
         H116uWGQ5LOS03SfqVJRQ1uRGEOVH9nRdC46O6ZhKPmkTz3ES9Pj3c2ioVkawyN52Wvm
         iaiDwYAmnoJdJnEE24VF7dhdbkJbnX56JcNuWzdc7MNMWEQjHcAN9TFxRzYCIPGwr/tw
         lKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=W+qTMbfn4QUtv7a6hFfeYubmWeE151RiueufqBqh4U8=;
        b=GIJ1b4DNg7Bou6kjOXGham///wqnlRquJVwfWruIfCpzFr2ggjb/RArQaJzC7POc8x
         ICTyO40jcyYXLlLiMQiTPXQ0PElyaMINiQxuTjyMmvAx2rbpLvWaRfcSFScyfNuJvB/c
         6DK4tTrEhOxgyntpJ+CHNLdMHnpJIOEKw6wKiBbYcdVLoFnFhKVUGuekDmK4zmCa4kqf
         Mr+ysV3xqtwoeLPsT/WWf5TNKW4BCg5p6WJf10K+A8uppAiqSnKBYTKRV6qKIus+Sf8q
         xBHO93QR27UZYL4zJKiNCBvdf29xrzCHLBDXoxIsJTzCIdwSrLDU7aaQUXwC4d+bCMd9
         0Vhg==
X-Gm-Message-State: APjAAAX47cLhAh23renmyuY6iJ+H3JaME0ax4ixMJXlmwO+8p4J+NSxt
        StTIKdrLdrQ2jYExILho7j0eGliqGOSTsKreC2ky0j5Ctg6wYw==
X-Google-Smtp-Source: APXvYqwBAKpeAJxjxMcNSPH4tBVC9bvP9+aIIKsk8OsmeqCgEDzSGsdatw03DjjC0x5ALuMft9Nmslnmfh20bI3xRSY=
X-Received: by 2002:a67:f253:: with SMTP id y19mr3203509vsm.158.1581028868913;
 Thu, 06 Feb 2020 14:41:08 -0800 (PST)
MIME-Version: 1.0
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Thu, 6 Feb 2020 17:40:57 -0500
Message-ID: <CAOg9mST_fo957rXFxC3-K_LnOMxuQgBvaEj1LO8gyCFnNGV+PQ@mail.gmail.com>
Subject: [GIT PULL] orangefs fix for 5.6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit d5226fa6dbae0569ee43ecfc08bdcd6770fc4755:

  Linux 5.5 (2020-01-26 16:23:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-5.6-ofs1

for you to fetch changes up to 9f198a2ac543eaaf47be275531ad5cbd50db3edf:

  help_next should increase position index (2020-02-04 15:22:04 -0500)

----------------------------------------------------------------
orangefs: a debugfs fix

Vasliy Averin noticed that "if seq_file .next function does not change
position index, read after some lseek can generate unexpected output."
and sent in this fix.

----------------------------------------------------------------
Vasily Averin (1):
      help_next should increase position index

 fs/orangefs/orangefs-debugfs.c | 1 +
 1 file changed, 1 insertion(+)
