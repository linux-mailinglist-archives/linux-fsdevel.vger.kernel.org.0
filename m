Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DBF340740
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 14:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhCRNwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 09:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44919 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231362AbhCRNwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616075549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K3FmGDDjg4x6Qh11aJHy8AEuyBdl8B9I2jc7mXW+DQQ=;
        b=S41Vdb4CeRV8LEe6yIHRIDDMmlsaB74Q+pk5VJaeWi3XBDjNtLJWtMuJkAxbxPBvL0z0w5
        OK2XdISxCmy3qo79Z4bJWoEmIJMM5ze/1F8JNsLPBK7+0eWh0JZksiaong5D8XRLFAcdOx
        I4DEinjW3aA8cgvW0HTb/VexqhI6wrs=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-u2e4MBBLNBKTPn7UaS8f8A-1; Thu, 18 Mar 2021 09:52:28 -0400
X-MC-Unique: u2e4MBBLNBKTPn7UaS8f8A-1
Received: by mail-oi1-f200.google.com with SMTP id n15so7279781oie.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Mar 2021 06:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K3FmGDDjg4x6Qh11aJHy8AEuyBdl8B9I2jc7mXW+DQQ=;
        b=pWhQwaSoctzLC2bQAGJ59ngVNOreUV0t/f/V8Q29BaWhNVHVnYElcpEijptk4kuQb2
         TompcB//6b2PjCPcKR0HWfPjF8kAvyNA410ung+v65zjv8hDeBGFHoVlAyTscSaSLiOH
         xfB3tjI96SMpARotTqEz2xyVt2GORQfMasy82Gfa4+SFRnnbqNyE88fIxWOut/nsXPh0
         bkB93JwGYd+HFtGCK4ezKWyYllw8TxAV8G7A9PiBOueuBtnPiVRJkmybbFABZfUFyhNz
         NZOFBhkRfljaxRHXy8i5SomWC1/6R1e8LrwpXYP+WvnYNrjLbExxUFapDiQrnSjFBmTG
         yW/Q==
X-Gm-Message-State: AOAM533ZjRKw+mYTGE8cC70vOqJzJVK+mXNne/1tDU/WkiuxWBwJqGjv
        4rMywc+NabtqnChVkwA5hCCzJG1i08i48V6ni7qq6oF02Sq+g++5loo5JPfCJ8srODIfhFEU3e+
        ygkKiVK5rI4F4txLlwXYgm3PwUg==
X-Received: by 2002:a9d:62d1:: with SMTP id z17mr7347736otk.118.1616075547691;
        Thu, 18 Mar 2021 06:52:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUVm8g2gqvSzP7zKMkWvD+pr2sw5M/w6HMmQg74ODAc1kSZtztAuf92THPXJ0Aw5kJfl5jAw==
X-Received: by 2002:a9d:62d1:: with SMTP id z17mr7347719otk.118.1616075547545;
        Thu, 18 Mar 2021 06:52:27 -0700 (PDT)
Received: from redhat.redhat.com (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id i11sm465342otp.76.2021.03.18.06.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 06:52:27 -0700 (PDT)
From:   Connor Kuehl <ckuehl@redhat.com>
To:     virtio-fs@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        vgoyal@redhat.com, miklos@szeredi.hu, jasowang@redhat.com,
        mst@redhat.com
Subject: [PATCH 3/3] fuse: fix typo for fuse_conn.max_pages comment
Date:   Thu, 18 Mar 2021 08:52:23 -0500
Message-Id: <20210318135223.1342795-4-ckuehl@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318135223.1342795-1-ckuehl@redhat.com>
References: <20210318135223.1342795-1-ckuehl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

'Maxmum' -> 'Maximum'

Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
---
 fs/fuse/fuse_i.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f0e4ee906464..8bdee79ba593 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -552,7 +552,7 @@ struct fuse_conn {
 	/** Maximum write size */
 	unsigned max_write;
 
-	/** Maxmum number of pages that can be used in a single request */
+	/** Maximum number of pages that can be used in a single request */
 	unsigned int max_pages;
 
 #if IS_ENABLED(CONFIG_VIRTIO_FS)
-- 
2.30.2

