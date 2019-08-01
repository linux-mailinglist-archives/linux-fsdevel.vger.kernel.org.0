Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C52D87D2BA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 03:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfHABRD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 21:17:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33583 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbfHABRC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 21:17:02 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hszhI-0002ID-DM; Thu, 01 Aug 2019 03:16:00 +0200
Message-Id: <20190801010944.268628059@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 01 Aug 2019 03:01:30 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, linux-ext4@vger.kernel.org,
        "Theodore Tso" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>
Subject: [patch V2 4/7] fs/jbd2: Remove jbd_trylock_bh_state()
References: <20190801010126.245731659@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-ext4@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.com>
---
 include/linux/jbd2.h |    5 -----
 1 file changed, 5 deletions(-)

--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -347,11 +347,6 @@ static inline void jbd_lock_bh_state(str
 	bit_spin_lock(BH_State, &bh->b_state);
 }
 
-static inline int jbd_trylock_bh_state(struct buffer_head *bh)
-{
-	return bit_spin_trylock(BH_State, &bh->b_state);
-}
-
 static inline int jbd_is_locked_bh_state(struct buffer_head *bh)
 {
 	return bit_spin_is_locked(BH_State, &bh->b_state);


