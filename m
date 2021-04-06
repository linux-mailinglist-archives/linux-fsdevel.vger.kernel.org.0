Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEDD355FDA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 02:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347310AbhDGABk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 20:01:40 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:52900 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347328AbhDGABg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 20:01:36 -0400
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Apr 2021 20:01:35 EDT
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4FFPVm2cRzz9vBsP
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Apr 2021 23:53:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pZBao7_CWp8V for <linux-fsdevel@vger.kernel.org>;
        Tue,  6 Apr 2021 18:53:36 -0500 (CDT)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4FFPVm11nQz9vBrm
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Apr 2021 18:53:36 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4FFPVm11nQz9vBrm
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4FFPVm11nQz9vBrm
Received: by mail-il1-f200.google.com with SMTP id y11so12762573ilq.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Apr 2021 16:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mpfUu7thUIxHoKtSoeYtB9AvLxQFw0ALtYzefKcsYuM=;
        b=aTmXU9Gh62tIhl9S96zDwBXdgT7sGNhAHueo9mfwzFXBETGlWWtfnvSeOxU4620x3m
         8QENm+NfSf0Rce8m+Ik1+dYJ7YJbRbHj5pEknqLg1DldPynv4A/3xbPbZQddAJgTKnnK
         XsGyO/aiOUu4RRM4NKC6hd1qps908IIT8EBH27oAVEGYWT615fL1HgTbpXCWM3g5qwVk
         +oTgFgiQK1g/hItfzLi3HrU5O1kZdpS/Ba71EsMBA+DUxPE25lhHf9HELWNg4y4Cmfm6
         5dlhJRS3jMsPUt9KkLlO/1rS1N/kznI7PXSNKFOzbBU/HE2BUD3W5pK4HF7QgX168Nek
         h5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mpfUu7thUIxHoKtSoeYtB9AvLxQFw0ALtYzefKcsYuM=;
        b=ACWONbLseFqlYGU/o+B3WIlMY8dboFtLHUogo+leQafU8UXHlSWrdK1YddpkZ4r/zA
         UCphnHW2QYja9Cf2TynuKhF2OT9bVqC9i6xghy3aIqzaGjbFtptmLt8g1uEDkkr0c5f6
         EKJ2ndPiL+fujmC4DJmEm6laPiFG3nILkq7SZdViKSJXfMjuIITIBL02rXbPIayz4hFI
         XBDD4GegUYxJC7Icv2NsicCBKsmYVsN5i91EW6ZGOgv+In79ZnfmYoZpH/2oBYWo0CmU
         khDKQFX8hLpfr5SlLZYGVt4bonp39fYk67EkQtIp70uKGGOzvW6Okj5ynLskiBQtiBd+
         pvYQ==
X-Gm-Message-State: AOAM530zpYqs6l4pWqcm3oljlzZXuBm5d1D7SO0ZGj75UEhMDUgszjjX
        z/Jl/3mvN4SU25+gGzHR1I/iV7iT65U3M9LmZBaiRBL1cAxtQEF3UDMv2EtiHv2h1+6MVf6OPxY
        m1aoe9m6M4E3LL2wUY49vXHm8GMNNGw==
X-Received: by 2002:a05:6638:371f:: with SMTP id k31mr635427jav.143.1617753215786;
        Tue, 06 Apr 2021 16:53:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxi8sJ0PLHiI3wL+/tFsMyaM/WZnC/A5jmQCDdwzuGKrEi4KumtcWbwNFHqNaX8oCGHBeh+0Q==
X-Received: by 2002:a05:6638:371f:: with SMTP id k31mr635414jav.143.1617753215614;
        Tue, 06 Apr 2021 16:53:35 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:6ecd:6512:5d03:eeb6])
        by smtp.googlemail.com with ESMTPSA id w9sm14589257iox.20.2021.04.06.16.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 16:53:35 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: Avoid potential use after free
Date:   Tue,  6 Apr 2021 18:53:32 -0500
Message-Id: <20210406235332.2206460-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In virtio_fs_get_tree, after fm is freed, it is again freed in case
s_root is NULL and virtio_fs_fill_super() returns an error. To avoid
a double free, set fm to NULL.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 fs/fuse/virtio_fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4ee6f734ba83..a7484c1539bf 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1447,6 +1447,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	if (fsc->s_fs_info) {
 		fuse_conn_put(fc);
 		kfree(fm);
+		fm = NULL;
 	}
 	if (IS_ERR(sb))
 		return PTR_ERR(sb);
-- 
2.25.1

