Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35C241A3833
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 18:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgDIQoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 12:44:38 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:37693 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgDIQoh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:44:37 -0400
Received: by mail-wr1-f42.google.com with SMTP id w10so12692439wrm.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2020 09:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=qV055bCgmfit5wiYx2SC82eajEpkcvOWWhE4IPCd6o4=;
        b=fMgxvS3c0OmcU+BMetdx+SqjcFvccR7aDLcvATrkJi+vqLBtegSxo4sR6sUDq7uNlE
         IwgYwUtP12HMYNYZe0LCclgJsIiJzZqp5uqFhfsVTnjf/Q1t3VbOih1sEy4EWC1/UT8w
         CUsFChoPGvLx+zwtxWRmBZ3oRXJzzih+8gx5N55JEwfM9n+FMmpcc4MK4jOvAXDMafzP
         kxkJhctJGN7qTdeXgOD9+aT/eO7DnOWnM9b16/zvWRqZgjH1h1gQpK5u/8gMPSgIrNqo
         heDWLY76PcRugFiey1XfblQNL7XeYhORvw5sfi416q6O2gUf4+d6842FsnrofmAoaO90
         X9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qV055bCgmfit5wiYx2SC82eajEpkcvOWWhE4IPCd6o4=;
        b=MEkKvyZVm7uQ3UEDCeJRWx29DRYC/jylxgdSpHa8QL7ZfsRn1YF6+6BIYRV1Fui7I1
         UpgzkEVlSV0Lc1xGFfOrwIt4RnUbJS5M5jx+qPIwrIRga6cz1ugjCoI7657rxTuJU4u/
         eHcbx9IOWJeWG951D3ZNes/T+mtbiogk9GaYFIIpqRyGeQ1D8E2cscMeWSir+ZK7zgoX
         6zeQZdCTNxsXr8mp88yzE+3mCDstdv5dJ+FVlhvWB7+Z1eF1sdF5eTIQEjHQs+ucGKOe
         iJqdOTovWnS0xpRDGw8wbQpZkReIAZ+WIUR0ksBDOkuGfLftLGe4gAT64mMYiUdU2nTe
         owfA==
X-Gm-Message-State: AGi0PuZDzfAM3oE6l266J7swYFto4clI1cn7sMYLwGCn3k1C0sj4wRTG
        ZqCzeRY8UorzbnWOxRKI9/UPCZ9CJRP6qwRwrJQkbwbd
X-Google-Smtp-Source: APiQypLF6l4T9A57K7UtYfFI4yScs5m46uZBbMj/OdtILAKhbEP4nMdzQAfzKa57eFReO8cK3Q6iD+GwCT51AM0iUMA=
X-Received: by 2002:adf:e54e:: with SMTP id z14mr46348wrm.328.1586450676146;
 Thu, 09 Apr 2020 09:44:36 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 9 Apr 2020 12:44:25 -0400
Message-ID: <CAN-5tyF9JX1VaevFcvDKAcHa1XTgYznOMwW+LMigA-awqn_m7w@mail.gmail.com>
Subject: is this hang in a rename syscall is known?
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

Getting this hang on a 5.5 kernel, is this a known issue? Thank you.

Apr  7 13:34:53 scspr1865142002 kernel:      Not tainted 5.5.7 #1
Apr  7 13:34:53 scspr1865142002 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr  7 13:34:53 scspr1865142002 kernel: dt              D    0 24788
24323 0x00000080
Apr  7 13:34:53 scspr1865142002 kernel: Call Trace:
Apr  7 13:34:53 scspr1865142002 kernel: ? __schedule+0x2ca/0x6e0
Apr  7 13:34:53 scspr1865142002 kernel: schedule+0x4a/0xb0
Apr  7 13:34:53 scspr1865142002 kernel: schedule_preempt_disabled+0xa/0x10
Apr  7 13:34:53 scspr1865142002 kernel: __mutex_lock.isra.11+0x233/0x4e0
Apr  7 13:34:53 scspr1865142002 kernel: ? strncpy_from_user+0x47/0x160
Apr  7 13:34:53 scspr1865142002 kernel: lock_rename+0x28/0xd0
Apr  7 13:34:53 scspr1865142002 kernel: do_renameat2+0x1e7/0x4f0
Apr  7 13:34:53 scspr1865142002 kernel: __x64_sys_rename+0x1c/0x20
Apr  7 13:34:53 scspr1865142002 kernel: do_syscall_64+0x5b/0x200
Apr  7 13:34:53 scspr1865142002 kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
Apr  7 13:34:53 scspr1865142002 kernel: RIP: 0033:0x7f747a10ac77
Apr  7 13:34:53 scspr1865142002 kernel: Code: Bad RIP value.
Apr  7 13:34:53 scspr1865142002 kernel: RSP: 002b:00007f7479f92948
EFLAGS: 00000206 ORIG_RAX: 0000000000000052
Apr  7 13:34:53 scspr1865142002 kernel: RAX: ffffffffffffffda RBX:
00000000023604c0 RCX: 00007f747a10ac77
Apr  7 13:34:53 scspr1865142002 kernel: RDX: 0000000000000000 RSI:
00007f7479f94a80 RDI: 00007f7479f96b80
Apr  7 13:34:53 scspr1865142002 kernel: RBP: 0000000000000005 R08:
00007f7479f9d700 R09: 00007f7479f9d700
Apr  7 13:34:53 scspr1865142002 kernel: R10: 645f72656464616c R11:
0000000000000206 R12: 0000000000000001
Apr  7 13:34:53 scspr1865142002 kernel: R13: 00007f7479f98c80 R14:
00007f7479f9ad80 R15: 00007f7479f94a80
