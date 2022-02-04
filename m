Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB85A4A9B64
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 15:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbiBDOuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 09:50:20 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:63000 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiBDOuT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:50:19 -0500
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 214EoBeY028271;
        Fri, 4 Feb 2022 23:50:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Fri, 04 Feb 2022 23:50:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 214EoBw1028265
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 4 Feb 2022 23:50:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8655db93-8700-686e-cf03-68738c3f66f4@I-love.SAKURA.ne.jp>
Date:   Fri, 4 Feb 2022 23:50:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: proc.5: Update /proc/[pid]/task/[tid]/ example file
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since all of the /proc/[pid]/task/[tid]/cwd files are allowed to have
different values (so that threads can use relative pathnames), using
cwd file as an example of "have the same value" is not appropriate.

Since threads in a multithreaded process are created using CLONE_VM
flag, all of the /proc/[pid]/task/[tid]/maps files must have the same
value. Therefore, let's use maps file as an example.
---
Should I use [PATCH] and S-o-b for changes not in kernel tree?
I didn't use them in order not to be caught by testing bot process.

 man5/proc.5 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/man5/proc.5 b/man5/proc.5
index c6684620e..ea952b10f 100644
--- a/man5/proc.5
+++ b/man5/proc.5
@@ -2830,11 +2830,11 @@ file in the parent
 .I /proc/[pid]
 directory
 (e.g., in a multithreaded process, all of the
-.I task/[tid]/cwd
+.I task/[tid]/maps
 files will have the same value as the
-.I /proc/[pid]/cwd
+.I /proc/[pid]/maps
 file in the parent directory, since all of the threads in a process
-share a working directory).
+share the same memory space).
 For attributes that are distinct for each thread,
 the corresponding files under
 .I task/[tid]
-- 
2.18.4
