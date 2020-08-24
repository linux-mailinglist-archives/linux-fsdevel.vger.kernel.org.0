Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B98250132
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 17:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgHXPcU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 11:32:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55136 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727851AbgHXPbG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598283048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O53y8SXTHe8UM7SjU5jL95IZsuNLkUIcYidxItMzlrY=;
        b=WGNp79PpIWt9ljz87XLAPG6tH+ZKNl3qdRpo/CmV1++vqCiCnKFiBxEDNX/dd8HygsyaGh
        4fvGtQaaKMgHDzhvdUyqGZ0aGWGz8kwrVZvKwEDFn/YZk3L2n0TH6bXLoxENQlGjG1YoNM
        KjcDxcv1WAUgUCdNH6aBpL6kwo6viO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-Vepn4HL3P5GapuSjSxnMkQ-1; Mon, 24 Aug 2020 11:30:42 -0400
X-MC-Unique: Vepn4HL3P5GapuSjSxnMkQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 456311019629;
        Mon, 24 Aug 2020 15:30:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B53DF7038A;
        Mon, 24 Aug 2020 15:30:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/2] Modify the pipe(2) manpage for notification queues
From:   David Howells <dhowells@redhat.com>
To:     mtk.manpages@gmail.com, me@benboeckel.net
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Aug 2020 16:30:38 +0100
Message-ID: <159828303892.330133.569968242547202064.stgit@warthog.procyon.org.uk>
In-Reply-To: <159828303137.330133.10953708050467314086.stgit@warthog.procyon.org.uk>
References: <159828303137.330133.10953708050467314086.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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


