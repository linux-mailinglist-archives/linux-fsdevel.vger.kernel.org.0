Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F88B4B6B63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 12:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbiBOLqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 06:46:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237361AbiBOLqr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:46:47 -0500
X-Greylist: delayed 124118 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 03:46:33 PST
Received: from smtpbg501.qq.com (smtpbg501.qq.com [203.205.250.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79206006C
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 03:46:33 -0800 (PST)
X-QQ-mid: bizesmtp42t1644925577t9a74mhx
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Feb 2022 19:46:12 +0800 (CST)
X-QQ-SSF: 0140000000200030C000B00A0000000
X-QQ-FEAT: iCx1gO6ZefsCbpjuwgyXD4WWWpXLXLVWfSt2QNnpeapYPSsU2j8ffQLtlCHs2
        1u0PvUVuzHac6r17+T8qcLy6ept5P7fFKhnYaJcjNIf/RkA0NKJ6eFOmQVkw2rE0BTqB6Ij
        LzTfxdbEZhauLqK8rr9Nv9V674cxlaa2OVIElHEMNDKWLgy7R/5JZLrCTSmDszDylMMFPoy
        +fKKztpZ7y1EztvRlPYHAXONaVMbnMsKDrc/qZ0xL1ier9ezwqAlx4zTQ3n8KZpQR4H+CVB
        NQmzS64apdCcXlw0LoGQlEyfIaJzd2R3dhHv7mMQD/8pI3Ae7BSLjx7avbWafWfh5bqM0Af
        894lxKZGfna9Qw2uuSEFwYwneQjpBHZisflpa0I
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mcgrof@kernel.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH v3 0/8] sched: Move a series of sysctls starting with sys/kernel/sched_*
Date:   Tue, 15 Feb 2022 19:45:56 +0800
Message-Id: <20220215114604.25772-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

move a series of sysctls starting with sys/kernel/sched_* and use the
new register_sysctl_init() to register the sysctl interface.

Zhen Ni (8):
  sched: Move child_runs_first sysctls to fair.c
  sched: Move schedstats sysctls to core.c
  sched: Move rt_period/runtime sysctls to rt.c
  sched: Move deadline_period sysctls to deadline.c
  sched: Move rr_timeslice sysctls to rt.c
  sched: Move uclamp_util sysctls to core.c
  sched: Move cfs_bandwidth_slice sysctls to fair.c
  sched: Move energy_aware sysctls to topology.c

 include/linux/sched/sysctl.h | 41 ---------------
 kernel/rcu/rcu.h             |  2 +
 kernel/sched/core.c          | 69 ++++++++++++++++++-------
 kernel/sched/deadline.c      | 42 +++++++++++++---
 kernel/sched/fair.c          | 32 +++++++++++-
 kernel/sched/rt.c            | 56 +++++++++++++++++++--
 kernel/sched/sched.h         |  7 +++
 kernel/sched/topology.c      | 25 +++++++++-
 kernel/sysctl.c              | 97 ------------------------------------
 9 files changed, 201 insertions(+), 170 deletions(-)

-- 
2.20.1



