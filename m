Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2491C40CC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgEDRHh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:07:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36914 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729932AbgEDRHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0zbaY5aCZkhnyOx8006Ksv6GYkB1XDRbS6vVZoSyWsQ=;
        b=dt6PIvHhFSuDjA4RAU7719/HsaojRFdbINP4+54LQQidYQrWxxnIDSAX2aGJwROiYU3O4H
        d4qm0l543WV1IBx6sWBeSMLHHcBHc4/HIKIwNEnQP84xwcHbPINow9dQ6BBXxCien1kjNW
        AOCt0svwRoUD49iPoJeocz4wMMgC8YM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-llX5EtH4Mji7MqgIXODwbg-1; Mon, 04 May 2020 13:07:34 -0400
X-MC-Unique: llX5EtH4Mji7MqgIXODwbg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31AC8107ACCD;
        Mon,  4 May 2020 17:07:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAB3C5D9E8;
        Mon,  4 May 2020 17:07:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 01/61] afs: Make afs_zap_data() static
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 18:07:26 +0100
Message-ID: <158861204690.340223.9682983562368438550.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make afs_zap_data() static as it's only used in the file in which it is
defined.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/inode.c    |    2 +-
 fs/afs/internal.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 281470fe1183..67ccfbab683c 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -568,7 +568,7 @@ struct inode *afs_iget(struct super_block *sb, struct key *key,
  * mark the data attached to an inode as obsolete due to a write on the server
  * - might also want to ditch all the outstanding writes and dirty pages
  */
-void afs_zap_data(struct afs_vnode *vnode)
+static void afs_zap_data(struct afs_vnode *vnode)
 {
 	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 80255513e230..03487f1bef07 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1017,7 +1017,6 @@ extern struct inode *afs_iget(struct super_block *, struct key *,
 			      struct afs_iget_data *, struct afs_status_cb *,
 			      struct afs_cb_interest *,
 			      struct afs_vnode *);
-extern void afs_zap_data(struct afs_vnode *);
 extern bool afs_check_validity(struct afs_vnode *);
 extern int afs_validate(struct afs_vnode *, struct key *);
 extern int afs_getattr(const struct path *, struct kstat *, u32, unsigned int);


