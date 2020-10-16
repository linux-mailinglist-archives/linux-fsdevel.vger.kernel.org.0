Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F0428FCEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 05:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394234AbgJPDh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 23:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394231AbgJPDh7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 23:37:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BCCC061755;
        Thu, 15 Oct 2020 20:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=lmMJZPVnctvP1IeolKeWWhf8ROFToQ7YtsTqWupL42Q=; b=VNxAMvbkrpxVroXCQY5f+gNHrV
        B7kFNgnAXUstE9doiB1sXzbGI8fmNo+KAFaJaGOlNWevK1AQ/R+M1QtbR6gWxmXl6uah7tI2UEMnT
        OPO6DNLjnnTgd/xanppHivlmS7ealD6ErRh8iIWwIqV8H+GcSFze11yAmpnC9o/FweOj90lLtH3qN
        Otz8ImDwXDmRAnnb41hDFJlEaa/RQ4Aozie3KpEMDNuEAVyLuakb+eWR5TAFyQHrAm9RoCkPhoB5h
        1DyZpSUHxsJmW/bhcmVbgFldASl38TxSbydXB72N8JHmSd1WIN6lQkWI2IH3SxLRgmbS7KDEwqJ0b
        LaC2EwaA==;
Received: from [2601:1c0:6280:3f0::507c] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTGZ2-0007ZV-4q; Fri, 16 Oct 2020 03:37:56 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/2] fs/eventpoll.c: fix Returns: kernel-doc notation
Date:   Thu, 15 Oct 2020 20:37:51 -0700
Message-Id: <20201016033751.13733-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix some kernel-doc formatting in fs/eventpoll.c for "Returns:":

- use "Returns:" without another "Returns" after it;
- make multi-line Returns: indentation consistent;
- add a ':' after "Returns" in a few places;


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- linux-next-20201013.orig/fs/eventpoll.c
+++ linux-next-20201013/fs/eventpoll.c
@@ -369,7 +369,7 @@ static void ep_nested_calls_init(struct
  *
  * @ep: Pointer to the eventpoll context.
  *
- * Returns: Returns a value different than zero if ready events are available,
+ * Returns: a value different than zero if ready events are available,
  *          or zero otherwise.
  */
 static inline int ep_events_available(struct eventpoll *ep)
@@ -470,7 +470,7 @@ static inline void ep_set_busy_poll_napi
  * @cookie: Cookie to be used to identify this nested call.
  * @ctx: This instance context.
  *
- * Returns: Returns the code returned by the @nproc callback, or -1 if
+ * Returns: the code returned by the @nproc callback, or -1 if
  *          the maximum recursion limit has been exceeded.
  */
 static int ep_call_nested(struct nested_calls *ncalls,
@@ -1121,8 +1121,8 @@ struct file *get_epoll_tfile_raw_ptr(str
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
@@ -1163,7 +1163,7 @@ static inline bool list_add_tail_lockles
  * Chains a new epi entry to the tail of the ep->ovflist in a lockless way,
  * i.e. multiple CPUs are allowed to call this function concurrently.
  *
- * Returns %false if epi element has been already chained, %true otherwise.
+ * Returns: %false if epi element has been already chained, %true otherwise.
  */
 static inline bool chain_epi_lockless(struct epitem *epi)
 {
@@ -1426,7 +1426,7 @@ static int reverse_path_check_proc(void
  *                      paths such that we will spend all our time waking up
  *                      eventpoll objects.
  *
- * Returns: Returns zero if the proposed links don't create too many paths,
+ * Returns: zero if the proposed links don't create too many paths,
  *	    -1 otherwise.
  */
 static int reverse_path_check(void)
@@ -1812,7 +1812,7 @@ static inline struct timespec64 ep_set_m
  *           until at least one event has been retrieved (or an error
  *           occurred).
  *
- * Returns: Returns the number of ready events which have been fetched, or an
+ * Returns: the number of ready events which have been fetched, or an
  *          error code, in case of error.
  */
 static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
@@ -1957,7 +1957,7 @@ send_events:
  *          data structure pointer.
  * @call_nests: Current dept of the @ep_call_nested() call stack.
  *
- * Returns: Returns zero if adding the epoll @file inside current epoll
+ * Returns: zero if adding the epoll @file inside current epoll
  *          structure @ep does not violate the constraints, or -1 otherwise.
  */
 static int ep_loop_check_proc(void *priv, void *cookie, int call_nests)
@@ -2011,7 +2011,7 @@ static int ep_loop_check_proc(void *priv
  * @ep: Pointer to the epoll private data structure.
  * @file: Pointer to the epoll file to be checked.
  *
- * Returns: Returns zero if adding the epoll @file inside current epoll
+ * Returns: zero if adding the epoll @file inside current epoll
  *          structure @ep does not violate the constraints, or -1 otherwise.
  */
 static int ep_loop_check(struct eventpoll *ep, struct file *file)
