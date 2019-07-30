Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93F067B3FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 22:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfG3UDw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 16:03:52 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:47489 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfG3UDw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:03:52 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MFK8N-1i8DfT26g5-00FkfH; Tue, 30 Jul 2019 22:03:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 29/29] compat_ioctl: remove unused convert_in_user macro
Date:   Tue, 30 Jul 2019 22:01:34 +0200
Message-Id: <20190730200145.1081541-10-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190730200145.1081541-1-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
 <20190730200145.1081541-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UPHnmaxQO2Y5UPjFxToRbWqVgMBmWu69lOVcBLM59CbYK+TCCtk
 iXAL+WGyqVxND7dGZvj3prqCvzu+zKPkck1Y19QGgPFfYZKw/1a19odfItMh+3Xs7fk20ih
 KmzNO5tvoX1a2eonX0BqH09rjq6NlGlMujBwXAL6X862s+Rf1an9ITfEdxlm4gfufZMGn+w
 8Qs8oUnx83kAYmE6uccPg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8BsgjV30L1s=:7g7Z6TZ7orqgEjViPiUUIW
 pQ+vmo7sdb3mi3EDA8aGDQkEkx1UheLDituizs76GJw+v/VWNY9Lg8/pL/ca+AsxcHYCKDLJ5
 7oK6vWEPjf7aqoEpbKKKfHR7uJeJ4pGHMIcN1f7h2veYqD2aZPC3V8N+DnOZiQjgZp8JYecTK
 MCUXDF3GzFJblnKEWQfr0ckbWQh2LyK4gvl01WmmWfMp4e3YueaT6bWWvzeeiDgDV7alEmv6G
 lTeI1OMwweQetjIry0nKLkVOLT0lcrWjnp2g+hrThGrQkBtPrgQF1A7VRMhlWeyKDgyY129na
 LemT5BUDGA+fp1Q084pdR5yDHpqPFqHZH+fqAsJ4RW3NvaqiX9VY8gs4rKPpJ16p+v4UN9jRd
 vhESgtItrUDm1+1F/Rp7hB6NR1KmaZJ3/k8U4VXfqofaGL1+QDS9987yYOoRK9Rnm3ODdU5b6
 FJHOLPALtXHpWhnEsiVu6c/BXRuSMNK21tU6oI7mE7cH3zZe+58oHQs2O53w7z77kayiYH/Eo
 fonUwuIO8hjF56fze0YkgUEV4GPW4bG0+uIySxFSbqS6t2YnQJKVX7zItCTv7NzcmgR0imOJy
 M1J5T3p/bcywTehZizolm1PwPSo8rKuUiKIogMbJMEskSt9/H3kRtTYGNVkuayI4NS28MeQXh
 vVui0n2TB6SDM2zUTVQdbbxEhOoW8QlKGLXR6LvFZnyUZQavfcUeLwpJ2IQ7Qb8W4oD5N6JOG
 +b9uwCsZ8qG8eJ6IQAUi2y4lYGkHUw/05idSiA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The last users are all gone, so let's remove the macro as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 1ed32cca2176..1e740f4406d3 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -52,13 +52,6 @@
 
 #include <linux/sort.h>
 
-#define convert_in_user(srcptr, dstptr)			\
-({							\
-	typeof(*srcptr) val;				\
-							\
-	get_user(val, srcptr) || put_user(val, dstptr);	\
-})
-
 static int do_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	int err;
-- 
2.20.0

