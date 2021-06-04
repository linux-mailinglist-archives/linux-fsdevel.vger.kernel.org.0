Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C744D39B754
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 12:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhFDKrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 06:47:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31528 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229690AbhFDKrT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 06:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622803532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=P12DHTvROaKPzooVSFg2eC6cY1TPe7SDCVWufI7SqWQ=;
        b=Y6+Xxrg4mtlKbYGQr7D3UbsD/oRByPFM1+2t0CcpEcu6QEbjJvidUQcEPh1qh0STNdrgmA
        rw7qomPMfb/J0pGfO/cLvNfYBTcmBUnEHIPNhnI2i72dwYAvLY+Bod25L4YOd/gY2GY97X
        3qWmgbcn1nVaaql6Y7y7RA+2Siwcbs0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-5gyMFkNiPAiMng4te9P4wA-1; Fri, 04 Jun 2021 06:45:31 -0400
X-MC-Unique: 5gyMFkNiPAiMng4te9P4wA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 755F7501E0;
        Fri,  4 Jun 2021 10:45:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A970F60C17;
        Fri,  4 Jun 2021 10:45:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] fscache: Select netfs stats if fscache stats are enabled
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 04 Jun 2021 11:45:25 +0100
Message-ID: <162280352566.3319242.10615341893991206961.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unconditionally select the stats produced by the netfs lib if fscache stats
are enabled as the former are displayed in the latter's procfile.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/fscache/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fscache/Kconfig b/fs/fscache/Kconfig
index 427efa73b9bd..92c87d8e0913 100644
--- a/fs/fscache/Kconfig
+++ b/fs/fscache/Kconfig
@@ -14,6 +14,7 @@ config FSCACHE
 config FSCACHE_STATS
 	bool "Gather statistical information on local caching"
 	depends on FSCACHE && PROC_FS
+	select NETFS_STATS
 	help
 	  This option causes statistical information to be gathered on local
 	  caching and exported through file:


