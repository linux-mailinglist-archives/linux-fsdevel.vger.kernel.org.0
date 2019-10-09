Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 053BFD188C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbfJITLI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:11:08 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:55707 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731155AbfJITLH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:07 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M4K2r-1iIYTh2itF-000NJG; Wed, 09 Oct 2019 21:11:04 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v6 02/43] FIGETBSZ: fix compat
Date:   Wed,  9 Oct 2019 21:10:02 +0200
Message-Id: <20191009191044.308087-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xOPUUgwb9odFpHq6jGq9oq7v32LjQ90BrUA6zWbYbOD03AWqQJR
 rl8MvyzLu43RhF+zfWpAouPgWEloxlsGy99hCAszmYskH+sMhQrx3QtR+M33G0MMl/bXkDX
 V6za0ZZG5lHTKQQoOkYn2caznumYN/cCXlG/AA8MlY5dfCyFMtM0UZoDqCnrNhn1cy2rgFH
 fg8hZ/r6OR7oHL0PRhClg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7//ZRsP+fYE=:uY2u92yNBevu7F/X2nNVWk
 HgMtI6F3GByFsCBoej+0oUWOABnYqLsYPpwRTfIek+2WQ3MN+KUiPmOicwR+YS0Lx+3jpRa7D
 No0mCTOwFH0mbw73vzx7+KTXFPy0XTD6r8nHdRwRti5iKhlngaRblQn3bq+NAUOT5nSsAZclb
 tjNZp0WUPs6HslmvrXqpU7E8m8a8xgux2OpuLYhvltHWlw7yKDQlO8slNdDwhLwOmXGtnwaHy
 KyjrpXhntNaCkbTued3EgSdZhj27ujnbljNAknzLZhFeWwDk8UdEJNL6fWDK0L/XCDIn0Xy+G
 1BNOu3Ipx/I1a5Hk2RKXb0Z8u21fjEHh/1VplV8BrYcY2Ky1XzsctT4RMRYGfNajO+nTl1f1G
 tceLvrDZCk2VMIXs3IsyYKnJQykxrvHbQ5OQ37HM6aX2VZ73gI94fAgfX8XQwz+7m1/U+/wxR
 grGAl6I/Kg30KXIz98hqN18SJppOJdBKPHBYxBSHCJj5zAncZlHI8BUj+60YTFd6nnaTpdwMO
 lBD9BGalGkUp73qu5CZ5Jpitz1aTGqAaQoFmT9rzHwqoPWLw3Tkrym9h+JhIVwRnn83biTNX2
 1OKPdg8m1J/JM7Wt5rxEj6zBFnwPo/ug/RuGgunE4gPd4hlBqpA794uVt7hq2TKBmdq6Ohpx+
 6Me5MW57a4BXb1+pXtwK6Mv6NqO22+gYBIOH4V6JLaHWDVaGE9CFx6fZbZY5HV7bB36rr+cC2
 nPw/jiHyHmGIRf9arRZ77cWUPiJfSB1CGPnUUvGcb8/4i//Lzg0rPLr6C88W1LLxp+xulOyIC
 EjGPxmgKLmNTTC0ju9icyAc04pGJ5Cg5uUfAxb3wJ970h8vXuCSQo6Y+AEna5ulbIRUYeb7ZB
 GuDNgbPM9ctel9zpDW+Q==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

it takes a pointer argument, regular file or no regular file

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index e0226b2138d6..a979b7d1ed90 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -1036,10 +1036,10 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 	case FICLONERANGE:
 	case FIDEDUPERANGE:
 	case FS_IOC_FIEMAP:
+	case FIGETBSZ:
 		goto found_handler;
 
 	case FIBMAP:
-	case FIGETBSZ:
 	case FIONREAD:
 		if (S_ISREG(file_inode(f.file)->i_mode))
 			break;
-- 
2.20.0

