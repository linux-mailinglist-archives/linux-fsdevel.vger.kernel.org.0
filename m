Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFC0615D74
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 09:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiKBIQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 04:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiKBIQA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:16:00 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A491FCD9;
        Wed,  2 Nov 2022 01:15:56 -0700 (PDT)
X-QQ-mid: bizesmtp65t1667376944t1aaelus
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Nov 2022 16:15:43 +0800 (CST)
X-QQ-SSF: 01400000000000B0E000000A0000020
X-QQ-FEAT: +ynUkgUhZJnFi+nBwbjX5Y6S1DXktWOdmidqSUs8sMgNyFzkIDG30PQjjlYry
        uKGj47UpcJ25qQSY87LcC8fEFDed43t65dtRZsDFV7hFlax4ZIsd7Lw0Sxwa8Vmd3eEHp07
        OpRLotAh/nYXqXuoF0iFxfM6VRj3zgxhPnQcJ34cud2dbT4LKLoDs9gVnA1r10kJZ9avufC
        7vWvpqJL/VuLzDM1rf0Q9AZRM/cmFwwWLJmEUl1XYxzYxMm6JDZI9pjLti43molP2mHgTyO
        04AnLrIscXwn4FeIocgQt4/m2XRwSFyHXm/x5TJG4gbrACLz1O8sFs4MvP5V626vBYFFb/g
        U1+6JgVdOWWsxgU2tnR9wImzlVkJa89N0C6dUMXrXbhT7w4avx4zU5+6a0EtvJeGEcSweVH
X-QQ-GoodBg: 1
From:   Chen Linxuan <chenlinxuan@uniontech.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Chen Linxuan <chenlinxuan@uniontech.com>,
        Yuan Haisheng <heysion@deepin.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: update the description of TracerPid in procfs.rst
Date:   Wed,  2 Nov 2022 16:15:17 +0800
Message-Id: <20221102081517.19770-1-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the tracer of process is outside of current pid namespace, field
`TracerPid` in /proc/<pid>/status will be 0, too, just like this process
not have been traced.

This is because that function `task_pid_nr_ns` used to get the pid of
tracer will return 0 in this situation.

Co-authored-by: Yuan Haisheng <heysion@deepin.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 Documentation/filesystems/proc.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 898c99eae8e4..e98e0277f05e 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -245,7 +245,8 @@ It's slow but very precise.
  Ngid                        NUMA group ID (0 if none)
  Pid                         process id
  PPid                        process id of the parent process
- TracerPid                   PID of process tracing this process (0 if not)
+ TracerPid                   PID of process tracing this process (0 if not, or
+                             the tracer is outside of the current pid namespace)
  Uid                         Real, effective, saved set, and  file system UIDs
  Gid                         Real, effective, saved set, and  file system GIDs
  FDSize                      number of file descriptor slots currently allocated
-- 
2.38.1

