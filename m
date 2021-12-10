Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76454701CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 14:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242268AbhLJNkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 08:40:10 -0500
Received: from mail.loongson.cn ([114.242.206.163]:59974 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242105AbhLJNjv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:39:51 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxusjBV7Nh3OEFAA--.12281S2;
        Fri, 10 Dec 2021 21:36:02 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        x86@kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] kdump: simplify code
Date:   Fri, 10 Dec 2021 21:35:59 +0800
Message-Id: <1639143361-17773-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9AxusjBV7Nh3OEFAA--.12281S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFyDGrW7KF1UCF45GFW7Jwb_yoW3Grb_XF
        WIgas5Gry0va4FyFy7K3W3urWDJr4vvFnYvw1ktrW5ta9xJFyrJw48JF4jgrn8XrWkJrZr
        ArWDGas2vr1FqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbs8YjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z2
        80aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
        zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx
        8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
        MxkIecxEwVAFwVW5GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7IU0nID7UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tiezhu Yang (2):
  kdump: vmcore: move copy_to() from vmcore.c to uaccess.h
  kdump: crashdump: use copy_to() to simplify the related code

 arch/arm/kernel/crash_dump.c     | 10 ++--------
 arch/arm64/kernel/crash_dump.c   | 10 ++--------
 arch/ia64/kernel/crash_dump.c    | 10 ++++------
 arch/mips/kernel/crash_dump.c    |  9 ++-------
 arch/powerpc/kernel/crash_dump.c |  7 ++-----
 arch/riscv/kernel/crash_dump.c   |  9 ++-------
 arch/sh/kernel/crash_dump.c      |  9 ++-------
 arch/x86/kernel/crash_dump_32.c  |  9 ++-------
 arch/x86/kernel/crash_dump_64.c  |  9 ++-------
 fs/proc/vmcore.c                 | 14 --------------
 include/linux/uaccess.h          | 14 ++++++++++++++
 11 files changed, 34 insertions(+), 76 deletions(-)

-- 
2.1.0

