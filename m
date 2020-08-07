Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA3723EFCA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 17:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgHGPGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 11:06:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726542AbgHGPGb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 11:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596812789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O53y8SXTHe8UM7SjU5jL95IZsuNLkUIcYidxItMzlrY=;
        b=G+Lf+MjijdMIJx+Fl+7pJ5hRIaLsN3B7fqHP8coErL2Fzw7u9qiZbucAD3L7IeoiiGluT6
        cpzNeEFqdmCLMvr2QQzj/1hq99bRRc/afwtxod9FImdm0oYViqTp1QF2Ev/drdZeq+pMSy
        QxZtPpDXawJWvs/Lv7Z4qm9nZpNIueI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-CIFLLUNGM1azCEZB4JLG0g-1; Fri, 07 Aug 2020 11:06:27 -0400
X-MC-Unique: CIFLLUNGM1azCEZB4JLG0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19D4579EC0;
        Fri,  7 Aug 2020 15:06:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-69.rdu2.redhat.com [10.10.113.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9C3760CD0;
        Fri,  7 Aug 2020 15:06:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/2] Modify the pipe(2) manpage for notification queues
From:   David Howells <dhowells@redhat.com>
To:     mtk.manpages@gmail.com
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 07 Aug 2020 16:06:23 +0100
Message-ID: <159681278389.35436.15823690384983762521.stgit@warthog.procyon.org.uk>
In-Reply-To: <159681277616.35436.11229310534842613599.stgit@warthog.procyon.org.uk>
References: <159681277616.35436.11229310534842613599.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Modify the pipe(2) manual page to cover support for notification queues

Signed-off-by: David Howells <dhowells@redhat.com>
---

 man2/pipe.2 |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/man2/pipe.2 b/man2/pipe.2
index 117f8950c..c50b38530 100644
--- a/man2/pipe.2
+++ b/man2/pipe.2
@@ -146,6 +146,13 @@ referred to by the new file descriptors.
 Using this flag saves extra calls to
 .BR fcntl (2)
 to achieve the same result.
+.TP
+.B O_NOTIFICATION_PIPE
+This enables use of the pipe as a notification transport (see
+.BR watch_queue (7)
+for more information).  When a pipe is in this mode, it may not be spliced as
+the insertion of notification messages into the pipe buffer can happen
+asynchronously and may cause splice to malfunction.
 .SH RETURN VALUE
 On success, zero is returned.
 On error, \-1 is returned,
@@ -292,4 +299,5 @@ main(int argc, char *argv[])
 .BR vmsplice (2),
 .BR write (2),
 .BR popen (3),
-.BR pipe (7)
+.BR pipe (7),
+.BR watch_queue (7)


