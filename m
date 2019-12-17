Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 708A2123941
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfLQWRn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:17:43 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:49705 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfLQWRk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:17:40 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MFba4-1iTcQl3JfS-00H5hY; Tue, 17 Dec 2019 23:17:25 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-doc@vger.kernel.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 06/27] compat: ARM64: always include asm-generic/compat.h
Date:   Tue, 17 Dec 2019 23:16:47 +0100
Message-Id: <20191217221708.3730997-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191217221708.3730997-1-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KL1ro4KGbRgth3ZyPB/rUAk9SI9caDwc2wmp7lID3j5UJuG/6zE
 jjRLuKXhvnIFa8qaMfReNfEXctttFgrIVqB/F8fk6VYQq40G8/4HFBUMSIUgljh/CHDrt8Q
 69toNQfZopjNWJs7hsjfa6yd254sA/h57NFTXYoc3PkHXFksuk6NUBA9BahejYNLdG0/ZsG
 N/KriVo2wRDf+NrqqW4hg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QObuhZbO9AY=:n0QH6H90N+kFOplb/DnWZ7
 AlmmIj0UejnAga/WbAExgs2nDVyWB/XfJ7GAn2Q1LEIaRzeMt+5oc3DltGf1LAybWfMe+LsWq
 qRT0IBjoptB0bN/M4aR7pGKQY9o275avtkdPO4ix1KuMR6QAf7CihdPYXkrrEWtF6y6HbQjGn
 +j7YNZ4ske8uUFEkTuPGN9vtjsXUD/g++1sMeTvNA0pysgKnDz1AcBec0pa6U2mC56CYbzz2O
 FAGnT6Rqnp7h8cluJ5tY52HItYlR8nB0dLN3UCUNFh9LKryA1hcvslQubQq5btgxFZ5ufDTtt
 aF4gllxZynPOzLuJ6cAgQU4GIEsPUXY7UKLnuvQmmrPh425Jxsg8lvAgtx9SBxdBK6Oe+Kgh0
 JtarlkrG8OBIigoaX0oxhJDADSiQhBBrun0in9FXXqCqYjv9Q+5TOn6Sgv8bFVs3gmik7UpS9
 YpU9Af5Fo18iTuNJYU7DsfcvLLKsd3Dig4yL8fNgjsWED2ZtnqCrtp8PAapztEhl18QRjRmf2
 ZgwhrhZLP9qUXMW0EqH5thD1lHVAgMk4h6T7N7lAdvpdXxQ3dLpHb4QYh2d3YdPOZ8aU648pX
 zpj0K2wvorwOq6gIzurxnQu7AEgQ2rSPqauCjyu4gwNwYXNnsXHoWZtn9HhC4RCP3vcV8Ahq1
 sY3YxVYa9uKMpx9ESnHjo0R6GMvaMBdYyb4e0JIsoY27AcD+gO56rXtfn5LzpdRpAuxxUQptk
 DVbjSB82MpSC8bXKr2ErxNXQ6NDIbDkAA8XwMFByKjYLaRu/w3DUnx9iiq6UBFIIGOIdgjMbw
 sNM/QJbtJxuaa5VyyvbYnk9ng7001Wn0sqVDJTkJ8VQkBltfwzmRa5Q0WYKHP5MJkQ2WoSspl
 VXUq4MYIhhGNm4ZWEO0w==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to use compat_* type defininitions in device drivers
outside of CONFIG_COMPAT, move the inclusion of asm-generic/compat.h
ahead of the #ifdef.

All other architectures already do this.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/compat.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index b0d53a265f1d..7b4172ce497c 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -4,6 +4,9 @@
  */
 #ifndef __ASM_COMPAT_H
 #define __ASM_COMPAT_H
+
+#include <asm-generic/compat.h>
+
 #ifdef CONFIG_COMPAT
 
 /*
@@ -13,8 +16,6 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 
-#include <asm-generic/compat.h>
-
 #define COMPAT_USER_HZ		100
 #ifdef __AARCH64EB__
 #define COMPAT_UTS_MACHINE	"armv8b\0\0"
-- 
2.20.0

