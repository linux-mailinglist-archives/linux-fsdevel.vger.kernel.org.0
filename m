Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9371CE22F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 20:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbgEKSCy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 14:02:54 -0400
Received: from mailrelay107.isp.belgacom.be ([195.238.20.134]:58645 "EHLO
        mailrelay107.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbgEKSCy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 14:02:54 -0400
IronPort-SDR: XGyN8aMpHJVF20AUpYqThvCEM0iidIWZczC07DEU8iDQKeZjEXAoCBe6IiOtV5lb7zT2vaYWkw
 SehvkoEODHErDt9cE+sGenJ7FPJfOJh0sltc0kuYpYIN1gzz3toHX//VVOfvUMJ/VQ+HkjxdW3
 p+VYzIhF/qK5hx9VM1J5D4SpXnKQAn5V/L5a0NfJ/wlEJMVEe48HdaqS1aSf//Z+rhEEIf8HkU
 8gATlECFt2b+uJqZrhVs7gL4nWRZaKoZN4Hyq4YTxwybw6ZVCf+icOq1KDBkt+iGNv8fX5AQYw
 Iug=
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3Aj7291x9jCe1CT/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B21+IcTK2v8tzYMVDF4r011RmVBNiduqoP0rOM+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhIiTanZb5+MBq6oRjMusUInIBvNrs/xh?=
 =?us-ascii?q?zVr3VSZu9Y33loJVWdnxb94se/4ptu+DlOtvwi6sBNT7z0c7w3QrJEAjsmNX?=
 =?us-ascii?q?s15NDwuhnYUQSP/HocXX4InRdOHgPI8Qv1Xpb1siv9q+p9xCyXNtD4QLwoRT?=
 =?us-ascii?q?iv6bpgRRn1gykFKjE56nnahMxugqxGrhyvpBtxzIHbboyOKPZzfbnQcc8ASG?=
 =?us-ascii?q?ZdQspcUTFKDIOmb4sICuoMJeZWoJPmqFsPtxS+AxSnCuP1yjBWm3D5w7c60+?=
 =?us-ascii?q?U9HgHFwQctGNwOv27Po9X7L6oSSuO1zanOzTrdc/Nawyzy55bRfx0nvPqDUq?=
 =?us-ascii?q?5+f9DLxkkzCwPKkE+QqYr9Mj2b1ekAt2iV4utgWO6xhWMpqxx8riSyysswi4?=
 =?us-ascii?q?THiY0bx03K+Chn3Ys4Jd+1RVB0b9K4HpVeuCWXOYt2TM88R2xlvjsxxL4euZ?=
 =?us-ascii?q?OjeCUG1Y4rywPcZvCZaYSE/xPuWeaLLTtlhX9ofq+0iQyo/ki60OL8U9G50F?=
 =?us-ascii?q?NNriVYjNbBrmsN1xnP6sifTft941uh1S6P1w/N7uFEJlg5mrHaK54uzb4wi4?=
 =?us-ascii?q?ETsV/EHi/yhUX2l7WadkUj+uit9evrerTmppmCOI9okgzzNrkiltaiDek7LA?=
 =?us-ascii?q?QCRXWX9OW82bH54EH0Qa1GjvgsnanYtJDaK94bpqm8AwJN3IYs8Q2wDzm93d?=
 =?us-ascii?q?QDnnkGLFRFdwybj4TzIF7BPuj0De2jjFS0jDdr2/fGM6XjAprXMnfDk6zsfa?=
 =?us-ascii?q?1g605H1gU/18xQ5pNMALEbPP3zQlPxtMDfDhIhKQO0xufnCM9/244QWGKPBr?=
 =?us-ascii?q?SUMKzXsVCS5+IvJ/OAa5MSuDb4M/Il/eLhjWclmV8BeqmkxZ8XaHG+HvR7LE?=
 =?us-ascii?q?SVeHTsgswcHmgUoAoxUujqhUacUT5ceXmyRbgw5jIlB4K8C4fMWIStjKaG3C?=
 =?us-ascii?q?ehEZ1cfnpGBUyUEXf0a4WEXO8BaCyILcB6nDwJTqOhS4wh1BGoqgD616BrIf?=
 =?us-ascii?q?HK9X5QiZW21tF+5MXIiAo/szdmS4yU1mCXEDp1mksHQjY32OZ0pkku5E2E1P?=
 =?us-ascii?q?1WivZZHNobyelEXgogNJXfh7h0Atr8chnCb9GEVBCsT4P1UnkKUtstzopWMA?=
 =?us-ascii?q?5GENK4g0Wb0g=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CcDAACkrle/xCltltmHQEBPAEFBQE?=
 =?us-ascii?q?CAQkBgV6CKIFkEiyNJYV6jBiRWAsBAQEBAQEBAQE0AQIEAQGERIINJzgTAgM?=
 =?us-ascii?q?BAQEDAgUBAQYBAQEBAQEEBAFsBAEBBwoCAYROIQEDAQEFCgFDgjsig00BIyN?=
 =?us-ascii?q?PcBKDJoJYKbB0hVGDVoFAgTgBh1yFAYFBP4RfhBWGLQSya4JUgnGVKwwdnTq?=
 =?us-ascii?q?QHZ87IoFWTSAYgyRQGA2fCkIwNwIGCAEBAwlXASIBi0OCRQEB?=
X-IPAS-Result: =?us-ascii?q?A2CcDAACkrle/xCltltmHQEBPAEFBQECAQkBgV6CKIFkE?=
 =?us-ascii?q?iyNJYV6jBiRWAsBAQEBAQEBAQE0AQIEAQGERIINJzgTAgMBAQEDAgUBAQYBA?=
 =?us-ascii?q?QEBAQEEBAFsBAEBBwoCAYROIQEDAQEFCgFDgjsig00BIyNPcBKDJoJYKbB0h?=
 =?us-ascii?q?VGDVoFAgTgBh1yFAYFBP4RfhBWGLQSya4JUgnGVKwwdnTqQHZ87IoFWTSAYg?=
 =?us-ascii?q?yRQGA2fCkIwNwIGCAEBAwlXASIBi0OCRQEB?=
Received: from 16.165-182-91.adsl-dyn.isp.belgacom.be (HELO biggussolus.home) ([91.182.165.16])
  by relay.skynet.be with ESMTP; 11 May 2020 20:02:51 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 8/9 linux-next] fanotify: clarify mark type extraction
Date:   Mon, 11 May 2020 20:02:45 +0200
Message-Id: <20200511180245.215198-1-fabf@skynet.be>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

mark type is resolved from flags but is not itself bitwise.
That means user could send a combination and never note
only one value was taken in consideration. This patch clarifies
that fact in bit definitions.

Thanks to Amir for explanations.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 include/uapi/linux/fanotify.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index a88c7c6d0692..675bf6bbbe50 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -71,7 +71,12 @@
 #define FAN_MARK_FLUSH		0x00000080
 /* FAN_MARK_FILESYSTEM is	0x00000100 */
 
-/* These are NOT bitwise flags.  Both bits can be used togther.  */
+/*
+ * These are NOT bitwise flags.  Both bits can be used together.
+ * IOW if someone does FAN_MARK_INODE | FAN_MARK_FILESYSTEM
+ * it will be considered FAN_MARK_FILESYSTEM and user won't be
+ * notified.
+ */
 #define FAN_MARK_INODE		0x00000000
 #define FAN_MARK_MOUNT		0x00000010
 #define FAN_MARK_FILESYSTEM	0x00000100
-- 
2.26.2

