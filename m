Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C14E26F1B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 04:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgIRCx2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 22:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbgIRCxU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 22:53:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90179C06174A;
        Thu, 17 Sep 2020 19:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=S3/Z7/x6FQqQyTB2gJXO/B/sEOpSZljXP0R2mH4sHsc=; b=RiwR/i03CBwdiaqObxjh7F8aUr
        BI6OVET1ILTLzF3YjvCZPHg9h1vBbXIUi8bPwXUpH2s0qy3wrMvBSxI45RE4LAv28xeaT+RZmW6js
        XjlxukU/QUGo2cWtq5w2LO5G7kRZvZMafkO9PAhP6fP6NifotnAuONaXVzwXaChdHToN6FX2ePBbD
        F17wo3XY4S01yfIPEHDA6XP3MtedUN+Oas1PCdTJiw14ompEJ8oKzEY3Sb/Ybc4FnSQkkoWqBcfag
        TN+56ZMbGCvAxEpWFjguANID71IHWt6MecjXIPNyiRAui7+Oyz6uTm4P9iyRdEN4hOauGS1Qxkcoa
        PdRiWuag==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJ6WS-0005Yv-Mv; Fri, 18 Sep 2020 02:53:18 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH TRIVIAL] fs/eventpoll.c: fix "Returns" kernel-doc formatting
Message-ID: <12a6fd7c-87f4-7773-9e03-9677986a76d4@infradead.org>
Date:   Thu, 17 Sep 2020 19:53:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix some kernel-doc formatting in fs/eventpoll.c for "Returns:":

- use "Returns:" without another "Returns" after it;
- make multi-line Returns: indentation consistent;
- add a ':' after "Returns" in a few places;


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Jiri Kosina <trivial@kernel.org>
---
 fs/eventpoll.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- linux-next-20200917.orig/fs/eventpoll.c
+++ linux-next-20200917/fs/eventpoll.c
@@ -371,7 +371,7 @@ static void ep_nested_calls_init(struct
  *
  * @ep: Pointer to the eventpoll context.
  *
- * Returns: Returns a value different than zero if ready events are available,
+ * Returns: a value different than zero if ready events are available,
  *          or zero otherwise.
  */
 static inline int ep_events_available(struct eventpoll *ep)
@@ -472,7 +472,7 @@ static inline void ep_set_busy_poll_napi
  * @cookie: Cookie to be used to identify this nested call.
  * @ctx: This instance context.
  *
- * Returns: Returns the code returned by the @nproc callback, or -1 if
+ * Returns: the code returned by the @nproc callback, or -1 if
  *          the maximum recursion limit has been exceeded.
  */
 static int ep_call_nested(struct nested_calls *ncalls,
@@ -1123,8 +1123,8 @@ struct file *get_epoll_tfile_raw_ptr(str
  *        direction i.e. either to the tail either to the head, otherwise
  *        concurrent access will corrupt the list.
  *
- * Returns %false if element has been already added to the list, %true
- * otherwise.
+ * Returns: %false if element has been already added to the list, %true
+ *          otherwise.
  */
 static inline bool list_add_tail_lockless(struct list_head *new,
 					  struct list_head *head)
@@ -1165,7 +1165,7 @@ static inline bool list_add_tail_lockles
  * Chains a new epi entry to the tail of the ep->ovflist in a lockless way,
  * i.e. multiple CPUs are allowed to call this function concurrently.
  *
- * Returns %false if epi element has been already chained, %true otherwise.
+ * Returns: %false if epi element has been already chained, %true otherwise.
  */
 static inline bool chain_epi_lockless(struct epitem *epi)
 {
@@ -1428,7 +1428,7 @@ static int reverse_path_check_proc(void
  *                      paths such that we will spend all our time waking up
  *                      eventpoll objects.
  *
- * Returns: Returns zero if the proposed links don't create too many paths,
+ * Returns: zero if the proposed links don't create too many paths,
  *	    -1 otherwise.
  */
 static int reverse_path_check(void)
@@ -1814,7 +1814,7 @@ static inline struct timespec64 ep_set_m
  *           until at least one event has been retrieved (or an error
  *           occurred).
  *
- * Returns: Returns the number of ready events which have been fetched, or an
+ * Returns: the number of ready events which have been fetched, or an
  *          error code, in case of error.
  */
 static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
@@ -1959,7 +1959,7 @@ send_events:
  *          data structure pointer.
  * @call_nests: Current dept of the @ep_call_nested() call stack.
  *
- * Returns: Returns zero if adding the epoll @file inside current epoll
+ * Returns: zero if adding the epoll @file inside current epoll
  *          structure @ep does not violate the constraints, or -1 otherwise.
  */
 static int ep_loop_check_proc(void *priv, void *cookie, int call_nests)
@@ -2014,7 +2014,7 @@ static int ep_loop_check_proc(void *priv
  * @ep: Pointer to the epoll private data structure.
  * @file: Pointer to the epoll file to be checked.
  *
- * Returns: Returns zero if adding the epoll @file inside current epoll
+ * Returns: zero if adding the epoll @file inside current epoll
  *          structure @ep does not violate the constraints, or -1 otherwise.
  */
 static int ep_loop_check(struct eventpoll *ep, struct file *file)

