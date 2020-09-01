Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4548F25905C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 16:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgIAO1j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 10:27:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728412AbgIAO05 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598970416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ah3deyvmj3nGCTmHy2ZGM5wcru3R0bhnNraZ59wOV5U=;
        b=aucKYAbWYVVhDo6a/N/w6piJmjng3Vp/vgwXMWD1PVJ+BI4lPlEkiSUul+fl3K9rVhdCkH
        1u/1sv2my0f/DkA3hs/ePn0Wdmou5n7XqaPxA0fQH0cJOHaFHwjEzR9ZF6t0D+z7USVvWI
        vsZC4hBB2dupRbQw4ZXhhqdhJH+t2xY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-18lXufBeOQ2b_bF2GS_Xhw-1; Tue, 01 Sep 2020 10:26:55 -0400
X-MC-Unique: 18lXufBeOQ2b_bF2GS_Xhw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21F7E801A9D;
        Tue,  1 Sep 2020 14:26:54 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-208.rdu2.redhat.com [10.10.116.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 778F519C4F;
        Tue,  1 Sep 2020 14:26:46 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id EE73F22053E; Tue,  1 Sep 2020 10:26:45 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com
Subject: [PATCH 0/2] fuse, dax: Couple of fixes for fuse dax support
Date:   Tue,  1 Sep 2020 10:26:32 -0400
Message-Id: <20200901142634.1227109-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos,

I am testing fuse dax branch now. To begin with here are couple of
simple fixes to make sure I/O is going through dax path.

Either you can roll these fixes into existing patches or apply on
top.

I ran blogbench workload and some fio mmap jobs and these seem to be
running fine after these fixes.

Thanks
Vivek


Vivek Goyal (2):
  fuse, dax: Use correct config option CONFIG_FUSE_DAX
  fuse, dax: Save dax device in fuse_conn_dax

 fs/fuse/dax.c  | 1 +
 fs/fuse/file.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.25.4

