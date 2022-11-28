Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BDA63A953
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 14:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiK1NUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 08:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiK1NTu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:19:50 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B95F1F9DA
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 05:18:04 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id td2so11593456ejc.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 05:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CzsKmQ/JNcqP1IAM5kkjrzrabag01L0YrvSh7VIxqOg=;
        b=GvpNIdrtSxAMpdYe4bLJQOWncgZFUNJlbduQFYQ1WkSkKbMURP2Ga/73TuaojMWaQq
         zrbO05nHC7kVlCnsh+o+3G4+nhSEEpJsestHCQgtJrJXllOyX3ieU6HZHxONrSW1Sdll
         Oh/XXDOJ9wv8ZZEjRNbExmcd1Hsy73/o50aq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzsKmQ/JNcqP1IAM5kkjrzrabag01L0YrvSh7VIxqOg=;
        b=1Lq3MUYwGsc6PoMBMWfAyn8pOIy4MH4puM55196tPAaA3nOUXnKWcn4/p+QPqUKKHR
         XXTN0yyhwdmXwGuQvgzKfmtV9wrvstlweWgNbR9EvtTot4L4LZbzUTxqnKvxWVtFrAYB
         UgbV5m8BPTKq5eD8aBn8A1a26XL3gfq+AJgnL9Q3XJHvhRV1huXlTD8WkXSUETiYJ8x4
         0EwskVzgT03Bjc03ggK/Sd3AL/4lzXgpbQs6VvLK2A1FGgQQhiK5fGP0uMNtndoykSf3
         hR45O6G8nl44CLTnmWQZ1rS/bzJqCylpIucFIhTwVvaF2GlHreweNXKT7aPaMvKM/M2A
         fTIQ==
X-Gm-Message-State: ANoB5pkkqlCUxOpc6Lw0yH5d8l8RZFSh0dBa4767W3dAEUeqWZX1VmTG
        SaIZu3z1wW3F6cxONgaz/oLK7w==
X-Google-Smtp-Source: AA0mqf4ZMthsJUb+2jIiRdscWm5XMBnxT9GhgyF+d8Q1b4p6XDKsRp5D3c3DqVPKFIPsXdL2P35QuQ==
X-Received: by 2002:a17:907:76b7:b0:7bc:aea6:e89a with SMTP id jw23-20020a17090776b700b007bcaea6e89amr13615806ejc.671.1669641483214;
        Mon, 28 Nov 2022 05:18:03 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (91-82-180-126.pool.digikabel.hu. [91.82.180.126])
        by smtp.gmail.com with ESMTPSA id la18-20020a170907781200b007b2b98e1f2dsm4903072ejc.122.2022.11.28.05.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 05:18:02 -0800 (PST)
Date:   Mon, 28 Nov 2022 14:18:00 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 6.1-rc8
Message-ID: <Y4S1CNZ6Zk6k1SVn@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-6.1-rc8

Fix a regression introduced in -rc4.

Thanks,
Miklos

----------------------------------------------------------------
Miklos Szeredi (1):
      fuse: lock inode unconditionally in fuse_fallocate()

---
 fs/fuse/file.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)
