Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DDC3C5CBE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 15:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhGLNAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 09:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230522AbhGLNAP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626094646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OfW+EDPD3i0ZuVRk8dA4AgPw3FcJtell4MQHZyZqUjs=;
        b=aun3HrHpLRIWO19AbGy+9z8m4/oHm0CJKmpvc0n2/FNW6OE4yx2kaqc/xePpb4BztvjYMo
        e2KtpVI0IH2lw4aglq7T3spL8X2v/k5LMMjWyRWnpe2Xge4RJqdHgVBxCbgLxeiqrWy/TB
        ks9y1RnZONxxyWHFA6umVnSRllGCIQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-1RenpcKJPPaF_RQuClAC-A-1; Mon, 12 Jul 2021 08:57:24 -0400
X-MC-Unique: 1RenpcKJPPaF_RQuClAC-A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55DCB1060DFD;
        Mon, 12 Jul 2021 12:57:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-19.rdu2.redhat.com [10.10.118.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15E931971B;
        Mon, 12 Jul 2021 12:57:11 +0000 (UTC)
Subject: [PATCH 0/3] afs: Miscellaneous fixes
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Tom Rix <trix@redhat.com>,
        "Alexey Dobriyan (SK hynix)" <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Abaci Robot <abaci@linux.alibaba.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 12 Jul 2021 13:57:11 +0100
Message-ID: <162609463116.3133237.11899334298425929820.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here are some fixes for AFS:

 (1) Fix a tracepoint that causes one of the tracing subsystem query files
     to crash if the module is loaded[1].

 (2) Fix afs_writepages() to take account of whether the storage rpc
     actually succeeded when updating the cyclic writeback counter[2].

 (3) Fix some error code propagation/handling[3].

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

David

Link: https://lore.kernel.org/r/162430903582.2896199.6098150063997983353.stgit@warthog.procyon.org.uk/ [1]
Link: https://lore.kernel.org/r/20210430155031.3287870-1-trix@redhat.com [2]
Link: https://lore.kernel.org/r/1619691492-83866-1-git-send-email-jiapeng.chong@linux.alibaba.com [3]

---
David Howells (1):
      afs: Fix tracepoint string placement with built-in AFS

Jiapeng Chong (1):
      afs: Remove redundant assignment to ret

Tom Rix (1):
      afs: check function return


 fs/afs/dir.c   | 10 ++++++----
 fs/afs/write.c |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)


