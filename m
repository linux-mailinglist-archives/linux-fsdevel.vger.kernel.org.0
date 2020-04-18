Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AED1AF5B0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 00:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgDRWv3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 18:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgDRWv3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 18:51:29 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C459BC061A0C
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 15:51:28 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id re23so4643727ejb.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 15:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MrBEd3dkHFEdlbi6XfyOP0Wv2/DWk7JSL30NWJbN9jQ=;
        b=bBv5SM/ALhhduZyC+RAOk3ae8HjjAsA7g/bRHks9bYOfCc2koQReSMrIWOZk1fO+vP
         zB262xqwDRBFE7ZDWOkDPMgdlJqqq6hmVCqqt0wlumjxF+6mlzImhciw1s/Td5T1ft0I
         GNJdO5TALcWVMgYnbetmIVkLqu4HRF8xthcEgUbIXoh3m/ycBPFPzcNVeoH9wL4Y6p4u
         gdp72Uk1L+NSDz2kSgFt3jmacLsixHftkhrcorQ5KP/ee0bRngnOYTOur24ghXyYSfqM
         rBT+YkdK3GtUrSQmMc4GChMs52262SRhILLUQomc+O+BjT+N/kQOO/8zo1evgHpC9k4p
         WJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MrBEd3dkHFEdlbi6XfyOP0Wv2/DWk7JSL30NWJbN9jQ=;
        b=Ss0H5nPywpn20RYr0IriCN24khi1chxrG3viIhA/BZCHIcpJwfY6JZuCfS6IZi1GJ3
         xdKNDKsy6FnecndC+A8gAh/zsYCbG3/C2Ia+Ard9sFU4MiCUqnitLNS50fcHqp+a7g6J
         U9yxytXBzZYV5AeCgZa5ykGVl0o8aKxxIoVot7xsR9v5R6abKRA36i/rfMFLJwZBkOVT
         6jaNQQ7vVpw0BPyKp2OUQ7Nko9lm1cxSlpgfn7qJ1iGpq1jfZOPgBto5qO7DA0LR0JuP
         i4PFBf4Zmw06risuOHi8chgJaf25P7kqsCZFE5SRcgsUYHak+jo2ebAVHbitjUhPh9Qg
         1quw==
X-Gm-Message-State: AGi0PuZLvEak/GySmxk+d8/z5b9umAcIsYErJvfDOzhE9xq1aNezItyx
        mTDbGNSZuVFWVAd4oAdOcxvi5bX/yCUMNg==
X-Google-Smtp-Source: APiQypIjB8Kqr0hIJYwgIQ+g8RX+dqikaN44pMdYtdcqHBvHVp7+hI89j9k4n2k6vTyrFmwXo9hO3A==
X-Received: by 2002:a17:906:168f:: with SMTP id s15mr9839887ejd.17.1587250287386;
        Sat, 18 Apr 2020 15:51:27 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:6c58:b8bc:cdc6:2e2d])
        by smtp.gmail.com with ESMTPSA id g21sm2616767ejm.79.2020.04.18.15.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 15:51:26 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 0/5] export __clear_page_buffers to cleanup code
Date:   Sun, 19 Apr 2020 00:51:18 +0200
Message-Id: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

When reading md code, I find md-bitmap.c copies __clear_page_buffers from
buffer.c, and after more search, seems there are some places in fs could
use this function directly. So this patchset tries to export the function
and use it to cleanup code.

Thanks,
Guoqing

Guoqing Jiang (5):
  fs/buffer: export __clear_page_buffers
  btrfs: call __clear_page_buffers to simplify code
  iomap: call __clear_page_buffers in iomap_page_release
  orangefs: call __clear_page_buffers to simplify code
  md-bitmap: don't duplicate code for __clear_page_buffers

 drivers/md/md-bitmap.c      |  8 --------
 fs/btrfs/disk-io.c          |  5 ++---
 fs/btrfs/extent_io.c        |  6 ++----
 fs/btrfs/inode.c            | 14 ++++----------
 fs/buffer.c                 |  4 ++--
 fs/iomap/buffered-io.c      |  4 +---
 fs/orangefs/inode.c         | 17 +++++------------
 include/linux/buffer_head.h |  1 +
 8 files changed, 17 insertions(+), 42 deletions(-)

-- 
2.17.1

