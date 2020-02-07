Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 125761554FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 10:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgBGJqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 04:46:51 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39504 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgBGJqv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:46:51 -0500
Received: by mail-pg1-f194.google.com with SMTP id j15so853835pgm.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2020 01:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MCWG8R9hWDU9xx10VsmvZMYnvw0WNin8rkugXJrWgvI=;
        b=i3p6iJaGn95uL7UghyJMGfKml52hkcNV/u8wwFQpx/HPFsUP66mL+KWpHiDWHsFjKm
         zdWEr2hP+vuPT2A2g+x0qGS/d9S5ZUcUhxKHp7uZxP4aSbRGbP9xHMokA5wBB6LGNJXU
         VOp//Ty60qN/zLTAttlVLszEcD/eskE3OLa+zxOg0QqZ8D5TRFf9eishHHlOs3Jx2ian
         DQXs7FZKahBtMkmBsYahHpVc5FeeLMgLUL/vseKhu+/MhABHqVupnTu8LN8uiccZjsvZ
         WxlyLGLnfc/pWZpJ7Pab6KRyAfixu0ujS7BGujbtd3umwMamDOsg3L8pTJRXYLQRgjNu
         zMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MCWG8R9hWDU9xx10VsmvZMYnvw0WNin8rkugXJrWgvI=;
        b=HP0J4Ie/eAUr1wOT76W6sLLHLzjzIk1FAt/0OOekwmK5PAJpAleTCLxJpvWhd5JTH0
         8dfWrm2ZV6lmN0HhhLn7Afja4Yz0y5UhOX03EWtCZy6gBjWk66TYR06MiDAO70un9LtN
         REIFtk9YKYnv3YbcTeOqN0TEw8S7IUJMxGqK7TAe5xQdllk2ZdyphNQe3JsbgHMsZDig
         PR/MlJzZ/Al9SBuq3S6MWaHDY9xmmUHaMtEJDtCrh7miHFjLy6oGwFbjrYjWpya7twEr
         nCzCB6egedSKduLguiPzh/jLUZ1u81fyIActrzPWhO6l2JcdOUpquVU+CGGCpzg8iabk
         Dxqg==
X-Gm-Message-State: APjAAAXu1HqcwF4praSPseMvDTMnZPVG5dQoYJMsHljonjsg/GTPZ/L0
        NIo3Dc50fMVhmIFdDdjlOxYFzbLX
X-Google-Smtp-Source: APXvYqwKDelEcSf9fYVhi9cj9GHop3Lcb3dgJnQeUktg2kvDxlFYNdOviZlL2nem6jrRBpi72T67ZQ==
X-Received: by 2002:a62:5296:: with SMTP id g144mr3651282pfb.29.1581068810673;
        Fri, 07 Feb 2020 01:46:50 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id d3sm1953440pjx.10.2020.02.07.01.46.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 07 Feb 2020 01:46:50 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Cc:     linux-fsdevel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH 2/2] pstore/ram: remove unnecessary ramoops_unregister_dummy()
Date:   Fri,  7 Feb 2020 17:46:40 +0800
Message-Id: <1581068800-13817-2-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1581068800-13817-1-git-send-email-qiwuchen55@gmail.com>
References: <1581068800-13817-1-git-send-email-qiwuchen55@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

Remove unnecessary ramoops_unregister_dummy() if ramoops
platform device register failed.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 fs/pstore/ram.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 013486b..7956221 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -963,7 +963,6 @@ static void __init ramoops_register_dummy(void)
 		pr_info("could not create platform device: %ld\n",
 			PTR_ERR(dummy));
 		dummy = NULL;
-		ramoops_unregister_dummy();
 	}
 }
 
-- 
1.9.1

