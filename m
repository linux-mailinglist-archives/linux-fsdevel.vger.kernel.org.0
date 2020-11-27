Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA9A2C6BDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 20:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbgK0TI3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 14:08:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730224AbgK0TH4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606504035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=I6Zs1ppjgvsb9FmTfYHegzS9VUFA58Y2RT71kFALmk0=;
        b=VBH9ASjJElAT9K/uFs6cuitbwv5K/cEyKjlvgkhrjxnQsqZLv2JA8ljIyAB5rc1nPMAOH5
        m8WL9wsemYQ1OFnKXP5aTh0K+E9+XBajd7haIt8fQ8UQOpx9cN7FdqJfrcL4dQo0SYZQHp
        8rWM2BUhHkEBmGCjIV0tm1L+q6fyDLA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-yCk9lpwXNxmwLNYBo7zgCQ-1; Fri, 27 Nov 2020 14:07:13 -0500
X-MC-Unique: yCk9lpwXNxmwLNYBo7zgCQ-1
Received: by mail-qv1-f72.google.com with SMTP id p3so3543430qvn.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2020 11:07:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I6Zs1ppjgvsb9FmTfYHegzS9VUFA58Y2RT71kFALmk0=;
        b=TNJ5GFA08TFmdVUEH87igX+A11fQ82wBQ4bmR2C7yNvBswJs6L/+zR6KnzBVeANr5F
         ll1WSRfNsmIqc6BhLMfNxfBrrDQdUXFM84c0qPItSrFQHfcInT+vnRblawZlouwPYulO
         qNeAfldAxYXIUVg5mbHW9CtZ10yVTpVbXHFpnVT73jlb+tTLN40Ne8x4C83XvW35sGVb
         nmw0J4C2ve/eSOLMNNzHFNLM9plIAWlTIL2/sFCWn9MQQ8CEzuTnOfwwWSXKdlerw0RF
         VWbXI/Kkp8rvUD/cbH2NCEQMXkdCkkK3k9/Aai2cjwB/bFKfUgE2v4RXo8/MifyP3C72
         eaYw==
X-Gm-Message-State: AOAM530dKbla0KeG0fL8eOur7o2N8enXQAN/cHIuHDIwWP4aiS/40xbl
        5wSDDwo3yBvrbgUhlPgvao6IHBZvpmdWrBCwbfvnPjghCRrKu5j4xdaPuoAwxucZYS7MUQrAtlo
        rxW4Pd7rjckLcVjfpyQITfQL9vA==
X-Received: by 2002:a05:620a:b0e:: with SMTP id t14mr9965068qkg.484.1606504033305;
        Fri, 27 Nov 2020 11:07:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvj5eobwkEJNyqoVShHJCJxrseRSWu+CqEGkPc1azciUrLyazjZjBInigD5gj1nmHkBnKw5w==
X-Received: by 2002:a05:620a:b0e:: with SMTP id t14mr9965049qkg.484.1606504033139;
        Fri, 27 Nov 2020 11:07:13 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l10sm7065821qti.37.2020.11.27.11.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:07:12 -0800 (PST)
From:   trix@redhat.com
To:     jlayton@kernel.org, bfields@fieldses.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] locks: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 11:07:07 -0800
Message-Id: <20201127190707.2844580-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/fcntl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 05b36b28f2e8..96a65758c498 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -526,7 +526,7 @@ SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
 	(dst)->l_whence = (src)->l_whence;	\
 	(dst)->l_start = (src)->l_start;	\
 	(dst)->l_len = (src)->l_len;		\
-	(dst)->l_pid = (src)->l_pid;
+	(dst)->l_pid = (src)->l_pid
 
 static int get_compat_flock(struct flock *kfl, const struct compat_flock __user *ufl)
 {
-- 
2.18.4

