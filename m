Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FB41F406D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 18:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbgFIQNv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 12:13:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47911 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731204AbgFIQNp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591719224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=02HV0hM+jmbbf5rG+ZCbj7NGvXL6ZgpcGKGqVPTuOyw=;
        b=QZ9h97J5NXltK1bQddEIu0i+DZi2CBqtSVmxks8jG2zn61WjBoeDJnx+gqQf9FqJGz1KID
        o8IDy4JUyhfQIMak3fpyDEd1p4WngYuBT8i16fUc5mLPzPQy6JT0xSCYw4VNWlAi+3vzVA
        FQpUuhJGLrqlMQQhLmTBHxqGFAAeQM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-mnQqfp6RODWz1HP_KNm4Zg-1; Tue, 09 Jun 2020 12:13:43 -0400
X-MC-Unique: mnQqfp6RODWz1HP_KNm4Zg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 078E5107ACCA;
        Tue,  9 Jun 2020 16:13:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C4B35D9E4;
        Tue,  9 Jun 2020 16:13:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/6] afs: Remove afs_zero_fid as it's not used
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 09 Jun 2020 17:13:40 +0100
Message-ID: <159171922045.3038039.11643205985887320787.stgit@warthog.procyon.org.uk>
In-Reply-To: <159171918506.3038039.10915051218779105094.stgit@warthog.procyon.org.uk>
References: <159171918506.3038039.10915051218779105094.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove afs_zero_fid as it's not used.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/yfsclient.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index b0a6e40b4da3..52d5af5fcd44 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -15,8 +15,6 @@
 #include "xdr_fs.h"
 #include "protocol_yfs.h"
 
-static const struct afs_fid afs_zero_fid;
-
 #define xdr_size(x) (sizeof(*x) / sizeof(__be32))
 
 static void xdr_decode_YFSFid(const __be32 **_bp, struct afs_fid *fid)


