Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B845DD8272
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 23:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbfJOVsD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 17:48:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730483AbfJOVsC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:48:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5FB980166F;
        Tue, 15 Oct 2019 21:48:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C9235C1B5;
        Tue, 15 Oct 2019 21:47:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 01/21] pipe: Reduce #inclusion of pipe_fs_i.h
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 15 Oct 2019 22:47:58 +0100
Message-ID: <157117607843.15019.8325197788819637475.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Tue, 15 Oct 2019 21:48:02 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove some #inclusions of linux/pipe_fs_i.h that don't seem to be
necessary any more.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/exec.c                  |    1 -
 fs/ocfs2/aops.c            |    1 -
 security/smack/smack_lsm.c |    1 -
 3 files changed, 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 555e93c7dec8..57bc7ef8d31b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -59,7 +59,6 @@
 #include <linux/kmod.h>
 #include <linux/fsnotify.h>
 #include <linux/fs_struct.h>
-#include <linux/pipe_fs_i.h>
 #include <linux/oom.h>
 #include <linux/compat.h>
 #include <linux/vmalloc.h>
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 8de1c9d644f6..c50ac6b7415b 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -11,7 +11,6 @@
 #include <linux/pagemap.h>
 #include <asm/byteorder.h>
 #include <linux/swap.h>
-#include <linux/pipe_fs_i.h>
 #include <linux/mpage.h>
 #include <linux/quotaops.h>
 #include <linux/blkdev.h>
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index abeb09c30633..ecea41ce919b 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -28,7 +28,6 @@
 #include <linux/icmpv6.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
-#include <linux/pipe_fs_i.h>
 #include <net/cipso_ipv4.h>
 #include <net/ip.h>
 #include <net/ipv6.h>

