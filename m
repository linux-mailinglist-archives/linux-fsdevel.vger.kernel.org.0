Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1C67666E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 10:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbjG1IWT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 04:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjG1IVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875211BF4
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 01:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690532412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NLSkFu1+A4B2qEl4uWLWn7fu2Ya9+djJ2h/pmkBMuP8=;
        b=Vo+YZjIxulu7S5mZBCf28FriSwHRrlSZcHdGOeNeoIWHOr6D/HD5KA1xXxydJHYNhvtZu3
        sMBXqDqsCbobKCOtYWMxJc32H8lo+hw8fmJYJU6oxVMKo1nkmfeFlsDzyFulxRVHOXEcxu
        6rh7zBYa/B1piCR+BOzjcuLamPaS67o=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-XhVk2cZrOoK3GDarM8I35Q-1; Fri, 28 Jul 2023 04:20:11 -0400
X-MC-Unique: XhVk2cZrOoK3GDarM8I35Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6CFF3C0BE3B;
        Fri, 28 Jul 2023 08:20:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87B18492C13;
        Fri, 28 Jul 2023 08:20:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <00000000000045a44b0601802056@google.com>
References: <00000000000045a44b0601802056@google.com>
To:     syzbot <syzbot+607aa822c60b2e75b269@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, agruenba@redhat.com, arnd@arndb.de,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [gfs2?] kernel panic: hung_task: blocked tasks (2)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <200477.1690532408.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 28 Jul 2023 09:20:08 +0100
Message-ID: <200478.1690532408@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot <syzbot+607aa822c60b2e75b269@syzkaller.appspotmail.com> wrote:

> Fixes: 9c8ad7a2ff0b ("uapi, x86: Fix the syscall numbering of the mount =
API syscalls [ver #2]")

This would seem unlikely to be the culprit.  It just changes the numbering=
 on
the fsconfig-related syscalls.

Running the test program on v6.5-rc3, however, I end up with the test proc=
ess
stuck in the D state:

INFO: task repro-17687f1aa:5551 blocked for more than 120 seconds.
      Not tainted 6.5.0-rc3-build3+ #1448
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:repro-17687f1aa state:D stack:0     pid:5551  ppid:5516   flags:0x000=
04002
Call Trace:
 <TASK>
 __schedule+0x4a7/0x4f1
 schedule+0x66/0xa1
 schedule_timeout+0x9d/0xd7
 ? __next_timer_interrupt+0xf6/0xf6
 gfs2_gl_hash_clear+0xa0/0xdc
 ? sugov_irq_work+0x15/0x15
 gfs2_put_super+0x19f/0x1d3
 generic_shutdown_super+0x78/0x187
 kill_block_super+0x1c/0x32
 deactivate_locked_super+0x2f/0x61
 cleanup_mnt+0xab/0xcc
 task_work_run+0x6b/0x80
 exit_to_user_mode_prepare+0x76/0xfd
 syscall_exit_to_user_mode+0x14/0x31
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f89aac31dab
RSP: 002b:00007fff43d9b878 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fff43d9cad8 RCX: 00007f89aac31dab
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007fff43d9b920
RBP: 00007fff43d9c960 R08: 0000000000000000 R09: 0000000000000073
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 00007fff43d9cae8 R14: 0000000000417e18 R15: 00007f89aad51000
 </TASK>

David

