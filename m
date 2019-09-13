Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBE1B1D87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 14:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388364AbfIMMTt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 08:19:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729673AbfIMMRu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:17:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45E6B87521A;
        Fri, 13 Sep 2019 12:17:50 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-52.rdu2.redhat.com [10.10.122.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 268296061E;
        Fri, 13 Sep 2019 12:17:50 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 03C3420D46; Fri, 13 Sep 2019 08:17:49 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 17/26] NFS: Constify mount argument match tables
Date:   Fri, 13 Sep 2019 08:17:39 -0400
Message-Id: <20190913121748.25391-18-smayhew@redhat.com>
In-Reply-To: <20190913121748.25391-1-smayhew@redhat.com>
References: <20190913121748.25391-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Fri, 13 Sep 2019 12:17:50 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

The mount argument match tables should never be altered so constify them.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/fs_context.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 3a34c8437917..de852177eca4 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -199,7 +199,7 @@ enum {
 	Opt_lookupcache_err
 };
 
-static match_table_t nfs_lookupcache_tokens = {
+static const match_table_t nfs_lookupcache_tokens = {
 	{ Opt_lookupcache_all, "all" },
 	{ Opt_lookupcache_positive, "pos" },
 	{ Opt_lookupcache_positive, "positive" },
@@ -215,7 +215,7 @@ enum {
 	Opt_local_lock_err
 };
 
-static match_table_t nfs_local_lock_tokens = {
+static const match_table_t nfs_local_lock_tokens = {
 	{ Opt_local_lock_all, "all" },
 	{ Opt_local_lock_flock, "flock" },
 	{ Opt_local_lock_posix, "posix" },
@@ -231,7 +231,7 @@ enum {
 	Opt_vers_err
 };
 
-static match_table_t nfs_vers_tokens = {
+static const match_table_t nfs_vers_tokens = {
 	{ Opt_vers_2, "2" },
 	{ Opt_vers_3, "3" },
 	{ Opt_vers_4, "4" },
-- 
2.17.2

