Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E7A259072
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 16:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgIAOat (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 10:30:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20920 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728411AbgIAO05 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598970416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VPuXamkfpYPykxGy/mGh7mgj6Sh2KL2J1/L4g+o9h6Y=;
        b=hxrNhyCh6P0BwqQSFUtoKAiwxF1vli6cQYycBhJkx2Im/cN09MMsaaOw4a/6iRuuPea4/Y
        KaMukINwLd/uIaje5xgvoaFTJBlYpSA7rt0zL7dkrVbK/2/nPu5Fw25V36nNCOWcPXGmzr
        155N3gywawBC9X+0qKvP0wKM9p9dprw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-uK-DVIP0M-qu76UK8qSnJg-1; Tue, 01 Sep 2020 10:26:55 -0400
X-MC-Unique: uK-DVIP0M-qu76UK8qSnJg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3389D51B2;
        Tue,  1 Sep 2020 14:26:54 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-208.rdu2.redhat.com [10.10.116.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83CDF1002D5B;
        Tue,  1 Sep 2020 14:26:46 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id F306B2254FA; Tue,  1 Sep 2020 10:26:45 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com
Subject: [PATCH 1/2] fuse, dax: Use correct config option CONFIG_FUSE_DAX
Date:   Tue,  1 Sep 2020 10:26:33 -0400
Message-Id: <20200901142634.1227109-2-vgoyal@redhat.com>
In-Reply-To: <20200901142634.1227109-1-vgoyal@redhat.com>
References: <20200901142634.1227109-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Correct config option to use is CONFIG_FUSE_DAX and not CONFIG_VIRTIO_FS_DAX.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7b53ae43860c..380577159c6e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3480,6 +3480,6 @@ void fuse_init_file_inode(struct inode *inode)
 	init_waitqueue_head(&fi->page_waitq);
 	fi->writepages = RB_ROOT;
 
-	if (IS_ENABLED(CONFIG_VIRTIO_FS_DAX))
+	if (IS_ENABLED(CONFIG_FUSE_DAX))
 		fuse_dax_inode_init(inode);
 }
-- 
2.25.4

