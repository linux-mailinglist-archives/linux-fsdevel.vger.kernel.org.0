Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70BC8382BE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 04:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfFGCeJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 22:34:09 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:35794 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726294AbfFGCeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 22:34:09 -0400
Received: from mr5.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x572Y8L3003947
        for <linux-fsdevel@vger.kernel.org>; Thu, 6 Jun 2019 22:34:08 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x572Y3Ab011931
        for <linux-fsdevel@vger.kernel.org>; Thu, 6 Jun 2019 22:34:08 -0400
Received: by mail-qk1-f197.google.com with SMTP id u128so413027qka.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2019 19:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=ZcoikDKkI7PPegWQ+6ZD26nDeLnWiH7ygdp1DcZcSDQ=;
        b=K1GAE/yte2MdfUhZQ5txdxYQowDDF9emijkrnU8Y+Fm7To+V4JtchbosQ5qJIM5GNM
         Z7wmbx5ZyZlxc4y0/dGWw6ANw4WX2KQ3UPA63rZWrUeijjnFW6JRudXvAAPfBIo31zCf
         s7fKEg2vgl+neS/zgtftwMGac3X41niX1KVs2nB7fcyKQFS+0TOhduSM9JOuQjMDswkK
         7a3PaBhhPr0FXbK/SDqzisZJ7nIBmxBivF4zFtawO6IPwhF82PcYhZJgvQwGM2a60YBQ
         12e/yPWDNZcePWFcIFoTtnn2r7ApzrZ+3CtRDg9kQ8BPOoPK4pU7c7kwcI4B7xaGnEOY
         0ZYA==
X-Gm-Message-State: APjAAAURmneGWnHpYqANguCV24tzlnY5YWyZEaDJK4FgqRetAKyOkZBU
        kNPFXxPh2zIYk9QkHqFbTR7bxtwILq21jkFy3roPkJ2qmqCAV9txA0XcYaRYHzAaj1cdbNZOyXg
        wDYgET7hHyO7yWWVjeQW3nEHacTHp8IiFlSov
X-Received: by 2002:a37:b607:: with SMTP id g7mr22692210qkf.257.1559874843108;
        Thu, 06 Jun 2019 19:34:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqztjNXbN0PknY30mS4Cf3VjkBmChOemWcioN+jA0DTDb+VS/n4xW7sdOascOmxohJ3Ngiy3Bg==
X-Received: by 2002:a37:b607:: with SMTP id g7mr22692194qkf.257.1559874842912;
        Thu, 06 Jun 2019 19:34:02 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id c7sm345534qth.53.2019.06.06.19.34.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 19:34:01 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Alexander Viro <viro@zeniv.linux.org.uk>
cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/handle.c - fix up kerneldoc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Thu, 06 Jun 2019 22:34:00 -0400
Message-ID: <29300.1559874840@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When building with W=1, gcc complains about kerneldoc issues:

  CC      fs/fhandle.o
fs/fhandle.c:259: warning: Function parameter or member 'flags' not described in 'sys_open_by_handle_at'
fs/fhandle.c:259: warning: Excess function parameter 'flag' description in 'sys_open_by_handle_at'

Fix typo in the kerneldoc

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 0ee727485615..01263ffbc4c0 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -246,7 +246,7 @@ static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
  * sys_open_by_handle_at: Open the file handle
  * @mountdirfd: directory file descriptor
  * @handle: file handle to be opened
- * @flag: open flags.
+ * @flags: open flags.
  *
  * @mountdirfd indicate the directory file descriptor
  * of the mount point. file handle is decoded relative


