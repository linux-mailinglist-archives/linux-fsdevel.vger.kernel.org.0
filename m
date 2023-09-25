Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF5F7AD497
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 11:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjIYJf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 05:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjIYJfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:35:25 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC17A10E
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 02:35:17 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b9c82f64b7so10528030a34.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 02:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695634517; x=1696239317;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXYTV27b/N8e9iQla3A3UJA2EkuMETgjqWyl7SSeebs=;
        b=s0qzr0QMdTRHZaCdCNMLCgQTnPvtb/3CKQ0MlI7kTAmLzC+mNZuo/w+MHOvj4eT7pe
         OuitX0E4s0y24s5eo7JbDf7isW3B2NWwqv+R6vEBq8YwtugPwyA21IonNQS0k616kd+y
         SZjWjK0QfUUZWRNVJrAEGhOksWwf12Y8pPzqaz4JUlLPRepRcSsVw4gQlD6UFTDU1lNT
         3aFEpM2HzBOOUjOwHtvHiDzwgMC/sZ0PEGVs5WGPgJGsRnq3vgSNNJqnjc6MHEZkAuld
         42GAnZt5PQMdSHFsqQ7lQqIZLjb5lCzfXayZcZD5E+phCNJstfIU8TeCGXPRrW6hgJqn
         gpXw==
X-Gm-Message-State: AOJu0YzzznIOO9HKxqbmquexL5mEpl6X5CPxQATey8YXz8w23qcSSV75
        zGclW1R1G8ZAlZ+FX30IS/B2YrXyKpIRIntNDowqssZJRVIk
X-Google-Smtp-Source: AGHT+IHDz9RoPAb2qZE9UPgDO/asesN/srR+GdA9z0sEGZ2bsprnsSEAzagQU+tQqe+y6Xo3Qy7f0U9VW6CgE3VRMxffklSI5wt0
MIME-Version: 1.0
X-Received: by 2002:a05:6830:3147:b0:6c4:e41c:6e6a with SMTP id
 c7-20020a056830314700b006c4e41c6e6amr1087261ots.4.1695634517333; Mon, 25 Sep
 2023 02:35:17 -0700 (PDT)
Date:   Mon, 25 Sep 2023 02:35:17 -0700
In-Reply-To: <ZRFOI/TUQwJEw5/s@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000131d7c06062bad29@google.com>
Subject: Re: [syzbot] [block] INFO: task hung in clean_bdev_aliases
From:   syzbot <syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, brauner@kernel.org, david@fromorbit.com,
        djwong@kernel.org, hare@suse.de, hch@infradead.org, hch@lst.de,
        johannes.thumshirn@wdc.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, mcgrof@kernel.org, nogikh@google.com,
        p.raghav@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com

Tested on:

commit:         ca5e3ec4 iomap: add a workaround for racy i_size updat..
git tree:       git://git.infradead.org/users/hch/misc.git bdev-iomap-fix
console output: https://syzkaller.appspot.com/x/log.txt?x=16d98efa680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=710dc49bece494df
dashboard link: https://syzkaller.appspot.com/bug?extid=1fa947e7f09e136925b8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
