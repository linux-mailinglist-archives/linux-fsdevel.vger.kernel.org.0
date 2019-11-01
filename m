Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 499C3EC7A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 18:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfKAReT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 13:34:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57239 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729551AbfKAReS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572629658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ofVwMOE/ATx0q/xqI7IgeNPgnC6+tkVYzw7GkmuoBw=;
        b=iEwwvhCEEoULt6sefCHQjdii2rErNmYN5oEImcCII6djjFE4lCHRxRU14xlKPou+y7lHEs
        cLFyBSrKtohBt36jYJCmfnLMGO7kKT2hGGE2Top8W2a3eja2ENrpGUZHZUFfYSBB9Ung/J
        6TNSzkmSJVa57Mve3zhlzZbws8dwJkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-p20JZCVjPPSL27BybuU1jg-1; Fri, 01 Nov 2019 13:34:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA84C800D49;
        Fri,  1 Nov 2019 17:34:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD54F5C290;
        Fri,  1 Nov 2019 17:34:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 01/11] pipe: Reduce #inclusion of pipe_fs_i.h [ver #3]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 01 Nov 2019 17:34:09 +0000
Message-ID: <157262964898.13142.10761929870592354381.stgit@warthog.procyon.org.uk>
In-Reply-To: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
References: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: p20JZCVjPPSL27BybuU1jg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

