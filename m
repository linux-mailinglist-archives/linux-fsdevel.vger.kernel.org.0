Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88CA7103E61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 16:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfKTP2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 10:28:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36523 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbfKTP2D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574263682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/6jgcHdEdKgS4+aAeKKo6S0l6xP5rAtWK4XeM9Bqug=;
        b=DCSy8DbMtwom1gYme+a7tsyWUOMMil9glBqOf/SI6h1AZtqQOTCUS2tVaCTFiRmA3R9dVj
        2/6vWOh+No8XCUJH94VTXh75aB7hF3jRsmmSOffPBkt47GjmGdfzfcwCImgqYj6jVsyFWN
        0VpFD16pw0aqlYCxCZMiLJ0KIQJFBWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-sf8VdU13Nlunt_LKR_vcBA-1; Wed, 20 Nov 2019 10:27:59 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AF3018B5F6B;
        Wed, 20 Nov 2019 15:27:57 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2849F2AA8A;
        Wed, 20 Nov 2019 15:27:57 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 7AEA920A01; Wed, 20 Nov 2019 10:27:50 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 17/27] NFS: Constify mount argument match tables
Date:   Wed, 20 Nov 2019 10:27:40 -0500
Message-Id: <20191120152750.6880-18-smayhew@redhat.com>
In-Reply-To: <20191120152750.6880-1-smayhew@redhat.com>
References: <20191120152750.6880-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: sf8VdU13Nlunt_LKR_vcBA-1
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
index 3a34c8437917..de852177eca4 100644
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

