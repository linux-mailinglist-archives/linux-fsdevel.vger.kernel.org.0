Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D32361614
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 01:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbhDOXWq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 19:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236917AbhDOXWq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 19:22:46 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67943C061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 16:22:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d8so12958175plh.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 16:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hZqD6ltCvrJgsL2u8AfIw1rh2NQf1pSi6cfmsTeRz+I=;
        b=gS6CFi1ja7RLx5Fem8T6NecDqP2E1wbyFfkdlcMNgv8RtD7AYbUi8QIQ1PQqdRfPl7
         SWxzZEN0aTZjCVHLrlqt3QOe5FwApUj/Rqaxpo0hJTlXlBjx8Aznaq8OYrA6Fenmqy6W
         EGq1xkRM0YRRBBVpMFRlyQlrHDlsw7sUVs/3Ij/tgtQQN7Bjh/jLh3SvTnOKlp44JEv2
         7KFG7Xprpg59vsychKsWzfiyWZAzAqc6LDsF90wNDAmMy5oMh/tYwmmCTsF9SAuaCftk
         B5Gjkm5mgpdkRfNXGx57UxBYLiB9Iv6gXpL+UDf1TfnHfCCz6uEJbmUI85XBtJp5to5h
         qmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hZqD6ltCvrJgsL2u8AfIw1rh2NQf1pSi6cfmsTeRz+I=;
        b=VqSf9u5eAfMOoXAMU2Zeql9D6axMBtXD31NIS6NGlpWYO1idGJJpbqcJSU+4WiFE1X
         SSzyAINrYZUjez9Sp1xxl7bt7p1R9RF4x4RBp6kswmIYlqcuuBuZHejyFw6EXJbk/kZp
         FH45fclMIPRGlfv/Pq7W1BU2pcwlczbWWcD0PniJNS6T9dlm7j6EIUXf+S5h8S/1yjYF
         FpnrfHXvlIfLM5TPe+5JOXU9SSEeg6U0fkxjUdOt5SydgZi0Rb8hOyQH6Bd0csf7b8yB
         Vo+RsVhvDBj0InyOYjVZbOdMUDDnFacM33RRf1NNmOZUCjqrKcl0hflUHHUGmjFV4Lkr
         AIJg==
X-Gm-Message-State: AOAM531KS3Y+hEIPB8vZzJWg7XKrl860Ohk9f5KZfPrNEobfyu0ORvqu
        z91LH6NK7pWumqLJ9joCqrX6GA==
X-Google-Smtp-Source: ABdhPJyDumUoYyNQGOsslWciEvA79i8Ns71fv9PWfMVnV2vlXgqm+butPtawu6LVUfnpxBaNnryLxQ==
X-Received: by 2002:a17:90a:e296:: with SMTP id d22mr6233078pjz.31.1618528941855;
        Thu, 15 Apr 2021 16:22:21 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:3d18:8baf:8ab:7dd5])
        by smtp.gmail.com with ESMTPSA id v6sm2959810pfb.130.2021.04.15.16.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 16:22:21 -0700 (PDT)
Date:   Fri, 16 Apr 2021 09:22:09 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] pidfd_create(): remove static qualifier and declare
 pidfd_create() in linux/pid.h
Message-ID: <14a09477f0b2d62a424b44e0a1f12f32ae3409bb.1618527437.git.repnop@google.com>
References: <cover.1618527437.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618527437.git.repnop@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With the idea to have fanotify(7) return pidfds within a `struct
fanotify_event_metadata`, pidfd_create()'s scope is to increased so
that it can be called from other subsystems within the Linux
kernel. The current `static` qualifier from its definition is to be
removed and a new function declaration for pidfd_create() is to be
added to the linux/pid.h header file.

Signed-off-by: Matthew Bobrowski <repnop@google.com>
---
 include/linux/pid.h | 1 +
 kernel/pid.c        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index fa10acb8d6a4..af308e15f174 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -78,6 +78,7 @@ struct file;
 
 extern struct pid *pidfd_pid(const struct file *file);
 struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
+int pidfd_create(struct pid *pid, unsigned int flags);
 
 static inline struct pid *get_pid(struct pid *pid)
 {
diff --git a/kernel/pid.c b/kernel/pid.c
index ebdf9c60cd0b..91c4b6891c15 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -553,7 +553,7 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
  * Return: On success, a cloexec pidfd is returned.
  *         On error, a negative errno number will be returned.
  */
-static int pidfd_create(struct pid *pid, unsigned int flags)
+int pidfd_create(struct pid *pid, unsigned int flags)
 {
 	int fd;
 
-- 
2.31.1.368.gbe11c130af-goog

/M
