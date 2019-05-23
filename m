Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB37282A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 18:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbfEWQSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 12:18:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730951AbfEWQSV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 12:18:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D596220276;
        Thu, 23 May 2019 16:18:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-142.rdu2.redhat.com [10.10.121.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 853FC10027C6;
        Thu, 23 May 2019 16:18:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 17/23] NFS: Constify mount argument match tables
From:   David Howells <dhowells@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 May 2019 17:18:18 +0100
Message-ID: <155862829878.26654.11973311261680429646.stgit@warthog.procyon.org.uk>
In-Reply-To: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
References: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 23 May 2019 16:18:20 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mount argument match tables should never be altered so constify them.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/nfs/fs_context.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 9711a2c7b479..265c22b3367f 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -198,7 +198,7 @@ enum {
 	Opt_lookupcache_err
 };
 
-static match_table_t nfs_lookupcache_tokens = {
+static const match_table_t nfs_lookupcache_tokens = {
 	{ Opt_lookupcache_all, "all" },
 	{ Opt_lookupcache_positive, "pos" },
 	{ Opt_lookupcache_positive, "positive" },
@@ -214,7 +214,7 @@ enum {
 	Opt_local_lock_err
 };
 
-static match_table_t nfs_local_lock_tokens = {
+static const match_table_t nfs_local_lock_tokens = {
 	{ Opt_local_lock_all, "all" },
 	{ Opt_local_lock_flock, "flock" },
 	{ Opt_local_lock_posix, "posix" },
@@ -230,7 +230,7 @@ enum {
 	Opt_vers_err
 };
 
-static match_table_t nfs_vers_tokens = {
+static const match_table_t nfs_vers_tokens = {
 	{ Opt_vers_2, "2" },
 	{ Opt_vers_3, "3" },
 	{ Opt_vers_4, "4" },

