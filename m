Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B76257FF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 19:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgHaRy3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 13:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgHaRy2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:54:28 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265D2C061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 10:54:28 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id m7so6914043qki.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bapkg9FgG5JYNxKH4CJjimocVeSkhXssVsVBKxihI6E=;
        b=o/45t+Ji32iDWSg+W2R02QhmYw9KhmMEdx89k2GANzq7NZz/em/YlOxmewbbgcInpw
         Z4RmPYpAwXrmpBX2zOreRB97jTsrkmH5CLW4B9egP73qsygSZk2TzFiGAHckLEDjf2XL
         3xuDrVvfz3Er5AhLyHvNbhdyeiPp3gKt5PA7/oyUCYas4OoMM8niVn9PdefFg6Mvz9FX
         9om/ug5InR8ivbaFxzZ8rIt07wcr8xzSe4IxfSL8qWhNDDx11mGqRo52QgWM0j312ltj
         faLaMYV1sviwen1zebkm++KvpWTCHSPYKsGF+OU+E6/ZMjSm7kk/J4vJAJo1zT3jblOd
         7SUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bapkg9FgG5JYNxKH4CJjimocVeSkhXssVsVBKxihI6E=;
        b=o9cTvqQFe9WedBXEyvA27CR69wFVEUm0je7825sMyIpUI2uhFMYJHbNJNkICuJRBZ/
         CDgBlaijRg0lC3mDtFFe9zbzo/Gjl0QOxXnRt/vod8PbiYzztdPQbqq2YsxMwfuCJazv
         9y3YuTR2K/+4eaH2iSoRLxP9ZZD0dMnkirSBx2w/ZMv7trNOQnH2jt7FeCVPNagdoRUX
         V5yWktfb+HwVfrueECxiVfa09WvHYtBqdtDRF+cGjVHfniZ1xVgpTruYn1yIseIAj5TZ
         4PtUXGyneQ7leKByDbQgeXTZNGU0X9I6ZRqE0wx1xGOspBte7KErGASk+7lK91E2Yy7u
         esow==
X-Gm-Message-State: AOAM532n28yUSQDqAoNdKyO+2RQrj2zHtZCBu+WN0gfvapfp+X0Q9MnM
        t/rFMHoW4+vei0Gp0uFA43EwFGeygYU=
X-Google-Smtp-Source: ABdhPJxWdpMDeVJL5UYpzGRJs5ex7flOyYNN2+xszmPx1ffL5MrzN/ondns7Zm+1kl4kBLNoVT/hrQ==
X-Received: by 2002:a05:620a:53a:: with SMTP id h26mr2596947qkh.232.1598896466884;
        Mon, 31 Aug 2020 10:54:26 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p189sm10123881qkb.61.2020.08.31.10.54.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 10:54:25 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 07VHsOi9010337;
        Mon, 31 Aug 2020 17:54:24 GMT
Subject: [PATCH] locks: Remove extra "0x" in tracepoint format specifier
From:   Chuck Lever <chuck.lever@oracle.com>
To:     jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org
Date:   Mon, 31 Aug 2020 13:54:24 -0400
Message-ID: <159889642439.7305.8036885243386192344.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Clean up: %p adds its own 0x already.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/filelock.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index c705e4944a50..1646dadd7f37 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -92,7 +92,7 @@ DECLARE_EVENT_CLASS(filelock_lock,
 		__entry->ret = ret;
 	),
 
-	TP_printk("fl=0x%p dev=0x%x:0x%x ino=0x%lx fl_blocker=0x%p fl_owner=0x%p fl_pid=%u fl_flags=%s fl_type=%s fl_start=%lld fl_end=%lld ret=%d",
+	TP_printk("fl=%p dev=0x%x:0x%x ino=0x%lx fl_blocker=%p fl_owner=%p fl_pid=%u fl_flags=%s fl_type=%s fl_start=%lld fl_end=%lld ret=%d",
 		__entry->fl, MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
 		__entry->i_ino, __entry->fl_blocker, __entry->fl_owner,
 		__entry->fl_pid, show_fl_flags(__entry->fl_flags),
@@ -145,7 +145,7 @@ DECLARE_EVENT_CLASS(filelock_lease,
 		__entry->fl_downgrade_time = fl ? fl->fl_downgrade_time : 0;
 	),
 
-	TP_printk("fl=0x%p dev=0x%x:0x%x ino=0x%lx fl_blocker=0x%p fl_owner=0x%p fl_flags=%s fl_type=%s fl_break_time=%lu fl_downgrade_time=%lu",
+	TP_printk("fl=%p dev=0x%x:0x%x ino=0x%lx fl_blocker=%p fl_owner=%p fl_flags=%s fl_type=%s fl_break_time=%lu fl_downgrade_time=%lu",
 		__entry->fl, MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
 		__entry->i_ino, __entry->fl_blocker, __entry->fl_owner,
 		show_fl_flags(__entry->fl_flags),
@@ -195,7 +195,7 @@ TRACE_EVENT(generic_add_lease,
 		__entry->fl_type = fl->fl_type;
 	),
 
-	TP_printk("dev=0x%x:0x%x ino=0x%lx wcount=%d rcount=%d icount=%d fl_owner=0x%p fl_flags=%s fl_type=%s",
+	TP_printk("dev=0x%x:0x%x ino=0x%lx wcount=%d rcount=%d icount=%d fl_owner=%p fl_flags=%s fl_type=%s",
 		MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
 		__entry->i_ino, __entry->wcount, __entry->rcount,
 		__entry->icount, __entry->fl_owner,
@@ -228,7 +228,7 @@ TRACE_EVENT(leases_conflict,
 		__entry->conflict = conflict;
 	),
 
-	TP_printk("conflict %d: lease=0x%p fl_flags=%s fl_type=%s; breaker=0x%p fl_flags=%s fl_type=%s",
+	TP_printk("conflict %d: lease=%p fl_flags=%s fl_type=%s; breaker=%p fl_flags=%s fl_type=%s",
 		__entry->conflict,
 		__entry->lease,
 		show_fl_flags(__entry->l_fl_flags),


