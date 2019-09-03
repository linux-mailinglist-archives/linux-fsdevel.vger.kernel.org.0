Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C930A6D3C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 17:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfICPtN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 11:49:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39724 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfICPtN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:49:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id t16so18060025wra.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 08:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMrvGG+6F24s5MC7Y6IaVq8vPUJTYFOsulQL5TO7Nqk=;
        b=W5Fu6uYZZO+WduaX+O8aGUyvxrCbbRzcS4ahAS8IU6Gyw7Nf9+iTO97dFzlY4Yl1LW
         Nx0JlQXGgpMlk4nwHJHAowYo7tY2Y10Fr3U2Upx8tWVhgtnNbdj7KUPp7xNRPjMqSy9C
         LETM4kUAYpOWdm6oxcPunqHERPtaAxIugnY/15he9PE1t6aurBTj19DonY81W2MBA7dn
         DmnWKQMb4wAD2cD3yULH3wcYIcelNwJrGav+xR7o7f1uGD/aDnubSOltk6yrYD+BRx0e
         GIT7jxXAkO9wefk2XBKcW05k+gVaxQ59ZPVgpvLxUH8tZAf05aMykR4rEGMlSmQnHQO+
         V02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMrvGG+6F24s5MC7Y6IaVq8vPUJTYFOsulQL5TO7Nqk=;
        b=lyY4AEwFk2QFBmj4fi0DaqhzCucQEWp6qYCetUSw7KjjQGVcYbsAqzb8RnYIaeFV6H
         XV81kc+bavP1tKxS9nnTJEFMYPhEM5yRi9N0P7iKCH17zyhc+M6Es0mu5Zfb31NN1pnz
         RmvaFc+G12drKgKZgIHNP3A19xC2Ai8mF3DO4/A6/7BINsvU4r27F0olSVW0ddcdGsPH
         1VHwIrobeZdX5CJF+VPJORSqaoRKkfOS5olITyAXeUyi4k39unMOXNWQ2Ln5CPH32yO3
         tvhWKbHllE4hJTjnjopxWvau1fqJll2Q+rdDmEgFd4A1B4NCExXjNfl/gU79Spi2RptV
         3jig==
X-Gm-Message-State: APjAAAXUtINdhG/LfaPMGWP8gsBOi92ox1KSdlP2XAtclddxIYSXZxT7
        F2llXDbDgWQzYYXb9omIrbbB4g==
X-Google-Smtp-Source: APXvYqwlH3Sd7NdJ7XNxdAeQ39tZTraTn+v19KlesBg1LQ0Sq1H877gVVSvaAxc91mJw1yGhA7W2YA==
X-Received: by 2002:adf:e947:: with SMTP id m7mr30125985wrn.178.1567525750995;
        Tue, 03 Sep 2019 08:49:10 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:e751:37a0:1e95:e65d])
        by smtp.gmail.com with ESMTPSA id f143sm11634889wme.40.2019.09.03.08.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 08:49:10 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@android.com,
        Alessio Balsini <balsini@android.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] sysctl: Inline braces for ctl_table and ctl_table_header
Date:   Tue,  3 Sep 2019 16:49:06 +0100
Message-Id: <20190903154906.188651-1-balsini@android.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix coding style of "struct ctl_table" and "struct ctl_table_header" to
have inline brances.
Before:

struct ctl_table
{
	...

After:

struct ctl_table {
	...

Besides the wide use of this proposed cose style, this change helps to
find at a glance the struct definition when navigating the code.

Signed-off-by: Alessio Balsini <balsini@android.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
---
 include/linux/sysctl.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 6df477329b76e..02fa84493f237 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -120,8 +120,7 @@ static inline void *proc_sys_poll_event(struct ctl_table_poll *poll)
 	struct ctl_table_poll name = __CTL_TABLE_POLL_INITIALIZER(name)
 
 /* A sysctl table is an array of struct ctl_table: */
-struct ctl_table 
-{
+struct ctl_table {
 	const char *procname;		/* Text ID for /proc/sys, or zero */
 	void *data;
 	int maxlen;
@@ -140,8 +139,7 @@ struct ctl_node {
 
 /* struct ctl_table_header is used to maintain dynamic lists of
    struct ctl_table trees. */
-struct ctl_table_header
-{
+struct ctl_table_header {
 	union {
 		struct {
 			struct ctl_table *ctl_table;
-- 
2.23.0.187.g17f5b7556c-goog

