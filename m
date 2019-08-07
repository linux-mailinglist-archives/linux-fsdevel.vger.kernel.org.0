Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 865748566A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 01:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfHGXWr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 19:22:47 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:54884 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729938AbfHGXWn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:22:43 -0400
Received: from mr2.cc.vt.edu (mr2.cc.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x77NMgdI017926
        for <linux-fsdevel@vger.kernel.org>; Wed, 7 Aug 2019 19:22:42 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x77NMbD2015078
        for <linux-fsdevel@vger.kernel.org>; Wed, 7 Aug 2019 19:22:42 -0400
Received: by mail-qk1-f199.google.com with SMTP id g4so7356422qkk.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2019 16:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=UNk1qvGbMsnH36vrlaPqG20pRJ089hDQPxCQ+ADKkjk=;
        b=L/hmoc2vOB0qm0bG9bHBD6vu1LfvLfu2W5vtWpM42YO84KhmrTAixVyVn0YmvB+RWZ
         9KjB4JDc+0/+GWYI9pK+zbIvicVmjYas5GQ7ufiaBjV1B1GxAJ0O7tzLdLRx/xjk5HVy
         4lcA/BYWlYH4fhP5ojqJ7TEE3aDT6vcyIVxCQSSI7U3zt/5ODUJrDH7ftcGw9TASqD1T
         ZcGjl2fRVkgR99R/2w/LyxiS2prhNpu3yJyQMsdL+/dS/1cRf8jZGx94ekvFj3no4jaU
         Qjuy7gzqLQQIr1nt1DpKuQgVCHNTTFO46nZYWK03csIUPi/rq8EoFr5FWSwKhBea/lHP
         j73g==
X-Gm-Message-State: APjAAAV8g5u4rl/MHqbPDisMrqYQtT9U6AuD4fndml7WwXOmHzc7jDe9
        bvchTXzihwM0QLnwmX4Nj1R7E3fdvvyw+LDX8QHjRQ7UOE1mkJnQbjoizjRsILCEPcp+pre3yOb
        g9cId3PGjjgCsRmunyHOliS2guBB3AtopmPjJ
X-Received: by 2002:ac8:32c8:: with SMTP id a8mr10283611qtb.47.1565220157035;
        Wed, 07 Aug 2019 16:22:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwaJHDNqmO8W/CMRvdYfu7239KdzjjQ6RdavRjM7SbTfbvj2lIv9ZkKmE9q8G44QWAGA8kpMA==
X-Received: by 2002:ac8:32c8:: with SMTP id a8mr10283601qtb.47.1565220156822;
        Wed, 07 Aug 2019 16:22:36 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id z4sm44729993qtd.60.2019.08.07.16.22.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 16:22:35 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Alexander Viro <viro@zeniv.linux.org.uk>
cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH resend] fs/handle.c - fix up kerneldoc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 07 Aug 2019 19:22:34 -0400
Message-ID: <8606.1565220154@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When building with W=1, we get some kerneldoc warnings:

  CC      fs/fhandle.o
fs/fhandle.c:259: warning: Function parameter or member 'flags' not described in 'sys_open_by_handle_at'
fs/fhandle.c:259: warning: Excess function parameter 'flag' description in 'sys_open_by_handle_at'

Fix the typo that caused it.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 0ee727485615..01263ffbc4c0 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -246,7 +246,7 @@ static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
  * sys_open_by_handle_at: Open the file handle
  * @mountdirfd: directory file descriptor
  * @handle: file handle to be opened
- * @flag: open flags.
+ * @flags: open flags.
  *
  * @mountdirfd indicate the directory file descriptor
  * of the mount point. file handle is decoded relative


