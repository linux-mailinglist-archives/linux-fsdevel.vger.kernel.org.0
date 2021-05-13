Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1207537F5E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 12:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhEMKvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 06:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232051AbhEMKvB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 06:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620902990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZS4a0+Jk376Mr3TJs35RHyvhDzgETMPw7mZbIknYFVM=;
        b=NJ4Psim979v8axo3qlq8ymBipXbGiXjkFGDuKKcj1omrSTNjCpASvRlotPQaWTiFcQ1UJg
        074mP3/lWhTYvlyDsqDKqUVRkBu4x6RMlYUTxsZXleKLJeUbtMYjBiXeI3Jbiz4orhxOPa
        PpQfZex/XPIDearrdBdwujtO43lnhGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-vHRUTM0TNbSjfnRG3vysog-1; Thu, 13 May 2021 06:49:48 -0400
X-MC-Unique: vHRUTM0TNbSjfnRG3vysog-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66DD3100945F;
        Thu, 13 May 2021 10:49:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2374B1B058;
        Thu, 13 May 2021 10:49:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] netfs: Make CONFIG_NETFS_SUPPORT auto-selected rather than
 manual
From:   David Howells <dhowells@redhat.com>
To:     geert@linux-m68k.org
Cc:     linux-mm@kvack.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com
Date:   Thu, 13 May 2021 11:49:41 +0100
Message-ID: <162090298141.3166007.2971118149366779916.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make the netfs helper library selected automatically by the things that use
it rather than being manually configured, even though it's required.

Fixes: 3a5829fefd3b ("netfs: Make a netfs helper module")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-mm@kvack.org
cc: linux-cachefs@redhat.com
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: ceph-devel@vger.kernel.org
cc: v9fs-developer@lists.sourceforge.net
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/CAMuHMdXJZ7iNQE964CdBOU=vRKVMFzo=YF_eiwsGgqzuvZ+TuA@mail.gmail.com
---

 fs/netfs/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/Kconfig b/fs/netfs/Kconfig
index 578112713703..b4db21022cb4 100644
--- a/fs/netfs/Kconfig
+++ b/fs/netfs/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 config NETFS_SUPPORT
-	tristate "Support for network filesystem high-level I/O"
+	tristate
 	help
 	  This option enables support for network filesystems, including
 	  helpers for high-level buffered I/O, abstracting out read


