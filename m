Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA7F4B6261
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 06:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiBOFWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 00:22:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbiBOFWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:22:44 -0500
Received: from smtpproxy21.qq.com (smtpbg703.qq.com [203.205.195.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D61B189F
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 21:22:35 -0800 (PST)
X-QQ-mid: bizesmtp5t1644902542t0cil5uxq
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Feb 2022 13:22:17 +0800 (CST)
X-QQ-SSF: 0140000000200020C000000A0000000
X-QQ-FEAT: ec8fk5hwdl4XL2PKi4NeZA8e8mJaxf1e15SxFm5o9hCXKfpbM8i7eiB8k+dc9
        jD7JJYp/lJls1Yi2RVEsyozgvD+BQpsbT1VKRUKit87Jz2sW+7BvKJXxoNlTjnod6nwWrSg
        YvpJSi+XPkXsk64a7ENg8deZUGguypXjhOPwOCChoaJymEpa4/gQCaQW2GPF2d0fI88obff
        +fN9Fl2/GPoGZMc9IM64rXQ9zy/FMned8pRkgYL7qybxFiKEuHGxJnwhB8GpN4XQ8L/hCTP
        eRn4bdbCpZjU/58If5/XKzVytFv79o0FqSYNJ5VddVDcpVrrrJXMPw/EnaLOu0+ZVg/dR2y
        IY8Rfr5WCznNuIEp1cioyGlaZ/Ptw==
X-QQ-GoodBg: 1
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mcgrof@kernel.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH 0/8] sched: Move a series of sysctls starting with sys/kernel/sched_*
Date:   Tue, 15 Feb 2022 13:22:06 +0800
Message-Id: <20220215052214.5286-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

*** BLURB HERE ***

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
 kernel/sched/core.c          | 69 ++++++++++++++++++-------
 kernel/sched/deadline.c      | 42 +++++++++++++---
 kernel/sched/fair.c          | 32 +++++++++++-
 kernel/sched/rt.c            | 56 +++++++++++++++++++--
 kernel/sched/sched.h         |  7 +++
 kernel/sched/topology.c      | 25 +++++++++-
 kernel/sysctl.c              | 97 ------------------------------------
 8 files changed, 199 insertions(+), 170 deletions(-)

-- 
2.20.1



