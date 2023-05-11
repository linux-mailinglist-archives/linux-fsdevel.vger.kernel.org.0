Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828F66FF153
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 14:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbjEKMPC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 08:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjEKMOp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 08:14:45 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A241118;
        Thu, 11 May 2023 05:14:19 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 7049758821597; Thu, 11 May 2023 14:14:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 6F7FA60D34383;
        Thu, 11 May 2023 14:14:08 +0200 (CEST)
Date:   Thu, 11 May 2023 14:14:08 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Kent Overstreet <kent.overstreet@linux.dev>
cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 04/32] locking: SIX locks (shared/intent/exclusive)
In-Reply-To: <20230509165657.1735798-5-kent.overstreet@linux.dev>
Message-ID: <7233p553-861o-9772-n4nr-rr5424prq1r@vanv.qr>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev> <20230509165657.1735798-5-kent.overstreet@linux.dev>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Tuesday 2023-05-09 18:56, Kent Overstreet wrote:
>--- /dev/null
>+++ b/include/linux/six.h
>@@ -0,0 +1,210 @@
>+ * There are also operations that take the lock type as a parameter, where the
>+ * type is one of SIX_LOCK_read, SIX_LOCK_intent, or SIX_LOCK_write:
>+ *
>+ *   six_lock_type(lock, type)
>+ *   six_unlock_type(lock, type)
>+ *   six_relock(lock, type, seq)
>+ *   six_trylock_type(lock, type)
>+ *   six_trylock_convert(lock, from, to)
>+ *
>+ * A lock may be held multiple types by the same thread (for read or intent,

"multiple times"

>+// SPDX-License-Identifier: GPL-2.0

The currently SPDX list only knows "GPL-2.0-only" or "GPL-2.0-or-later",
please edit.
