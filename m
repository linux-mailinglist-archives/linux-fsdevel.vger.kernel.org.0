Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859F4311645
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Feb 2021 00:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhBEW7v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 17:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhBEMV2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:21:28 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D448EC061786;
        Fri,  5 Feb 2021 04:20:46 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id a19so6645787qka.2;
        Fri, 05 Feb 2021 04:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RrxNJC+G65J+/Co9EWPzgkz6H64Dt1+RXsd7P6/3CKk=;
        b=sSaoalcTy3cKHlwNIvGtLaD9xfZR9N1BBueZTUkC3CBdeJ6qXPggq+cHZ6B8ZRs2az
         xbTC7haZs47r6LHF/xXB3YRygJ0cLvvO0XcMyiDhZAcmeuLRTqNW0Z2XxSlvU+19TCSC
         kH9sl3U0VcPOlfWg3K86JLDTtiqeL5gbVyavMyPKMDTuV23xvqkTxTvWM8dISOxninNw
         2CGeevOEciuB5FVMv412PYCpBibmeATHEG614l0GvDXOedjEc4WV2/D8KcyJzZazR058
         MINos7P+paGxwq8fichwhJTltAtf9JhcmtqU5jgvZ9r6WpmIJyRpyWOpak+CvVf4s1iL
         VysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RrxNJC+G65J+/Co9EWPzgkz6H64Dt1+RXsd7P6/3CKk=;
        b=tA5Ch0iHC+8fjvvc61m4VXwinC8/NwgqghTIu9o1deF8Ql9WKsQqSPzhEk6UxK2Le/
         iFUDn6madWbHWlXC7CmnJt2peTs0QfdEem63s2PKuil2RvQEMbHMFgsCr76eK7nnzP1C
         QkzrEXS6zOjQ9UKpq9E7HDFpeq44TODoiYNs18b+gdqjOXq1obwtF8cz3PBgdzwOTk+4
         1RzSvExc4p5/MJ3PWLNymkOHrYDM9ZvPQ56AOBSfmMbQDucrYwEzPsEZvqFF7bMlYSJo
         wMGnzB7yzt+xA/lBXoyoEdK0oExOR1tLRvezDlxBOYyp0cvbTdYdESvS8UGYiFfEgabB
         HgPA==
X-Gm-Message-State: AOAM530EzLaXKBFp6PQykd2ukzwEPdWYZpB+fhJGRkNj/q/rQEoHk+lv
        35B4J+wp4ucm8ium2EMpGu0=
X-Google-Smtp-Source: ABdhPJycIY87jKEPdLIrkcqSFnjnCoCNPU+3dyWU5PYmy4tBpFW4lWHV3EdRWLY/tKpgj+aP8HfTRw==
X-Received: by 2002:a05:620a:410:: with SMTP id 16mr3878858qkp.270.1612527646169;
        Fri, 05 Feb 2021 04:20:46 -0800 (PST)
Received: from localhost.localdomain ([138.199.10.106])
        by smtp.gmail.com with ESMTPSA id q25sm8793868qkq.32.2021.02.05.04.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 04:20:44 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] fs: notify: inotify: Replace a common bad word with better common word
Date:   Fri,  5 Feb 2021 17:50:33 +0530
Message-Id: <20210205122033.1345204-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



s/fucked/messed/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/notify/inotify/inotify_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 59c177011a0f..0a9d1a81edf0 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -455,7 +455,7 @@ static void inotify_remove_from_idr(struct fsnotify_group *group,
 	/*
 	 * We found an mark in the idr at the right wd, but it's
 	 * not the mark we were told to remove.  eparis seriously
-	 * fucked up somewhere.
+	 * messed up somewhere.
 	 */
 	if (unlikely(found_i_mark != i_mark)) {
 		WARN_ONCE(1, "%s: i_mark=%p i_mark->wd=%d i_mark->group=%p "
--
2.30.0

