Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1D5818D7B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 17:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfEIP6W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 11:58:22 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42127 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfEIP6W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 11:58:22 -0400
Received: by mail-oi1-f196.google.com with SMTP id k9so2269843oig.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2019 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZmKRJy8bC2jPsRjYBZQf1PbasWAtkAkyGHPp3zfhImo=;
        b=GnlrwmwARyBEF6G6qHphDC4m2FLkpdJONbDPZPNo4W88PsQX3G+He/25U8fUl+rUP5
         /8B4kBafrdJtFWJnMt8343eoZDa1mgw8iWHZwG8VeJTn4chJSKb65SrH1DyP/NuKac1o
         nUdZDZRMi84VtCE6YM5mTAc2kT42k34wrv4ZFiFrRTcXLP4bp+vGGQfHNZXhMVcSK72u
         ATzkw94k3UFwYQcv9exWIUqg0/mkXQyvI6EvDYV/XXJ9bS3QNlTuELUEFKraSck7QZ8K
         Ezb4ZOtzUlyieBTulqMqBTgNgERWfOzxVeIQG5vc14T1yFkPg4jCR+WEl86/DO3F/lbT
         tt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZmKRJy8bC2jPsRjYBZQf1PbasWAtkAkyGHPp3zfhImo=;
        b=ZpPzTsSmjYvcq8gi14nv44pux1hAr2coWPfbJfKyOWLK9mQx1z2kYKeEcD4lWplbXp
         ruDUGH7nTa6iBR5lEW2h/fdg/NdUnmUHf6R9Q0fAuOj5ny8JYKZ4+T5VzxiqJUDr2PGB
         Z+05lu0uwNVfNTxQ/NfDBb9i8ulvnhYe9VgBDrg/P4ndGWT5MtEQYv6iLQ7niW+grOO5
         bc6HoAXBmI2AwfYx7bOBLZxqsPQPkWY3L6y7uYP5h6NGie8YP3H5W7bBX8+Ipdm0JOBC
         twHlmZf8KY4NILp+haIWLzu0Mwkqqgw5ItErboExwnyWxrJaMtkOvSrMNHOZdjN+SB8M
         jdvQ==
X-Gm-Message-State: APjAAAU0tE6mGJbN8N5R54vBkesceNn6+JLnkXOi/DovyXGnnCQrND93
        f5zBkUSo2dZrFaZ642lYuQk1Rg==
X-Google-Smtp-Source: APXvYqwYnD6vM2zMcpu4GRsgCzizgCDDXYfnG+yegSVX9V6MBfMj4Qg46A6eglTOpbbg5LCNqczj3w==
X-Received: by 2002:aca:ec89:: with SMTP id k131mr2039971oih.86.1557417501425;
        Thu, 09 May 2019 08:58:21 -0700 (PDT)
Received: from localhost.localdomain ([172.56.6.91])
        by smtp.gmail.com with ESMTPSA id a1sm1130991oiy.38.2019.05.09.08.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 08:58:20 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 2/2] fsopen: use square brackets around "fscontext"
Date:   Thu,  9 May 2019 17:58:01 +0200
Message-Id: <20190509155801.8369-2-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509155801.8369-1-christian@brauner.io>
References: <20190509155801.8369-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make the name of the anon inode fd "[fscontext]" instead of "fscontext".
This is minor but most core-kernel anon inode fds already carry square
brackets around their name:

[eventfd]
[eventpoll]
[fanotify]
[io_uring]
[pidfd]
[signalfd]
[timerfd]
[userfaultfd]

For the sake of consistency lets do the same for the fscontext anon inode
fd that comes with the new mount api.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v1: patch not present
v2:
- David Howells <dhowells@redhat.com>:
  - remove unneeded reference from commit message and split paragraph to
    place list of anon inode fds in between
---
 fs/fsopen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index a38fa8c616cf..83d0d2001bb2 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -92,7 +92,7 @@ static int fscontext_create_fd(struct fs_context *fc)
 {
 	int fd;
 
-	fd = anon_inode_getfd("fscontext", &fscontext_fops, fc,
+	fd = anon_inode_getfd("[fscontext]", &fscontext_fops, fc,
 			      O_RDWR | O_CLOEXEC);
 	if (fd < 0)
 		put_fs_context(fc);
-- 
2.21.0

