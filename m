Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9F8118845
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 13:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfLJMcT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 07:32:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40102 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727592AbfLJMbZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575981084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6FM6XYBQ1hKH0GC/JZnzY8+SSWAtUZ4+Dcf/j3t4Ako=;
        b=aM3Hd+D8rUeviKserZSfBUicSWgZrqg2ux2gDhwix+wFU7PV1h1n9z29pTba2R7GxPOwz8
        mQic/Xitr94K9oB8nCzr30EVUlC81ZaCO+ecfdd8KKO50PobYqoKmuVOzmqwiic6TWFRj0
        Mk7QKBJudcU+Is6Q3/c//utgfnO7c4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-PcFr5xbYOlSSLBTEwHib9w-1; Tue, 10 Dec 2019 07:31:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EED7100551C;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CA996F964;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id E0C2020C2D; Tue, 10 Dec 2019 07:31:15 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v6 17/27] NFS: Constify mount argument match tables
Date:   Tue, 10 Dec 2019 07:31:05 -0500
Message-Id: <20191210123115.1655-18-smayhew@redhat.com>
In-Reply-To: <20191210123115.1655-1-smayhew@redhat.com>
References: <20191210123115.1655-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: PcFr5xbYOlSSLBTEwHib9w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
index c8f99a3c7264..8fbfd526d6b8 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -199,7 +199,7 @@ enum {
 =09Opt_lookupcache_err
 };
=20
-static match_table_t nfs_lookupcache_tokens =3D {
+static const match_table_t nfs_lookupcache_tokens =3D {
 =09{ Opt_lookupcache_all, "all" },
 =09{ Opt_lookupcache_positive, "pos" },
 =09{ Opt_lookupcache_positive, "positive" },
@@ -215,7 +215,7 @@ enum {
 =09Opt_local_lock_err
 };
=20
-static match_table_t nfs_local_lock_tokens =3D {
+static const match_table_t nfs_local_lock_tokens =3D {
 =09{ Opt_local_lock_all, "all" },
 =09{ Opt_local_lock_flock, "flock" },
 =09{ Opt_local_lock_posix, "posix" },
@@ -231,7 +231,7 @@ enum {
 =09Opt_vers_err
 };
=20
-static match_table_t nfs_vers_tokens =3D {
+static const match_table_t nfs_vers_tokens =3D {
 =09{ Opt_vers_2, "2" },
 =09{ Opt_vers_3, "3" },
 =09{ Opt_vers_4, "4" },
--=20
2.17.2

