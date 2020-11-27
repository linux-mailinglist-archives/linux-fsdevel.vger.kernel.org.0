Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9CB2C618A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 10:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgK0JVK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 04:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgK0JVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:21:10 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DAFC0613D1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2020 01:21:10 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id y7so3991442pfq.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2020 01:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N3znUkPKtqbryPODPnE7qItfA1c9fsYLlSw8ARlE2iU=;
        b=XCbkKPcW90nk8ZdKWXtOH5i9ZE+g53qlXZ8cLPT4L1dCcgEvMy8gG5O6KOjkCiRTS6
         T1sT0tOswqbzJT3gDHM0Pr4X0oa1KJkNX6xjd2KuxpINgXtXWLgF9ffxKbDKP1rjpMFz
         nxxOy0yG5pnW+FbC2hlo0yE1i2S7eA9V7xfbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N3znUkPKtqbryPODPnE7qItfA1c9fsYLlSw8ARlE2iU=;
        b=Jm4P3++k1+037349M/tFc2MWDHZH6svXZ9qUD3b/ZrRDnSZytB0tt78j1EnqzMeG58
         A0yPyPOWVl6Lo9TmKYHW9QFef10bS8ojTQU6hxMN8KJ19dvohJVxrBH6VZ8uIiX3ofNF
         hQYU5Qd0LXL9j62exRUba2AGocu5Rcz5rH38kIoC0wituPxXISc9UC+UdmAd7vIo7sYp
         DIliVBAvBKlXxwrwTPYKT8Ert5aPX04FuOL/BuUrBgo8zbUJVNgjdneyD91wLmYaZCQP
         EmLk0OlwB88QwBERi7yl7szR3ZyTHbo/f82ahv5Pk71OQrBlZHtYp4PrdlXegHt8f87X
         ksuA==
X-Gm-Message-State: AOAM5329LwOURXjZjCX4K9gwYgyx5MgpddrDpGqLWmkqHLM9RPx5ou3c
        M/IxnUaNllQMF7do/XFmxDWFMw==
X-Google-Smtp-Source: ABdhPJy+Nm0BqxYRvhxozEhyB0RB1iAA9/rcKtYRc0oHpzl11BL3ij3EUW9jZDE3KklG4mSjjnCSJA==
X-Received: by 2002:a17:90a:2a83:: with SMTP id j3mr9035135pjd.84.1606468869856;
        Fri, 27 Nov 2020 01:21:09 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id t9sm9938944pjq.46.2020.11.27.01.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 01:21:09 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH v2 2/4] overlay: Document current outstanding shortcoming of volatile
Date:   Fri, 27 Nov 2020 01:20:56 -0800
Message-Id: <20201127092058.15117-3-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127092058.15117-1-sargun@sargun.me>
References: <20201127092058.15117-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This documents behaviour that was discussed in a thread about the volatile
feature. Specifically, how failures can go hidden from asynchronous writes
(such as from mmap, or writes that are not immediately flushed to the
filesystem). Although we pass through calls like msync, fallocate, and
write, and will still return errors on those, it doesn't guarantee all
kinds of errors will happen at those times, and thus may hide errors.

In the future, we can add error checking to all interactions with the
upperdir, and pass through errseq_t from the upperdir on mappings,
and other interactions with the filesystem[1].

[1]: https://lore.kernel.org/linux-unionfs/20201116045758.21774-1-sargun@sargun.me/T/#m7d501f375e031056efad626e471a1392dd3aad33

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
---
 Documentation/filesystems/overlayfs.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index 580ab9a0fe31..c6e30c1bc2f2 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -570,7 +570,11 @@ Volatile mount
 This is enabled with the "volatile" mount option.  Volatile mounts are not
 guaranteed to survive a crash.  It is strongly recommended that volatile
 mounts are only used if data written to the overlay can be recreated
-without significant effort.
+without significant effort.  In addition to this, the sync family of syscalls
+are not sufficient to determine whether a write failed as sync calls are
+omitted.  For this reason, it is important that the filesystem used by the
+upperdir handles failure in a fashion that's suitable for the user.  For
+example, upon detecting a fault, ext4 can be configured to panic.
 
 The advantage of mounting with the "volatile" option is that all forms of
 sync calls to the upper filesystem are omitted.
-- 
2.25.1

