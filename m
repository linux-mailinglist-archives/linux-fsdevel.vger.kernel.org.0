Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6157B34C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 21:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388142AbfG3T2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 15:28:34 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:36231 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388077AbfG3T23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:28:29 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MmDVA-1iaRGm0ZTE-00iDU7; Tue, 30 Jul 2019 21:28:28 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 08/29] compat_ioctl: drop FIOQSIZE table entry
Date:   Tue, 30 Jul 2019 21:25:19 +0200
Message-Id: <20190730192552.4014288-9-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190730192552.4014288-1-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tUvdG1WMQobt5AAVoouIKZHvzqLCLOJu7/p0P8VqNr8Q4WdBz3u
 x9m3YoSJEYiv52BuOBkOjncNMevqvr5QDHiEg+Df3/e4bpAEqHnD52lNtIU3YJS1F9YSnLT
 2letDyNZOrAvdVibRaIkUy3PYV/m+exEWX2s/m1LGQ3NQ00oYwmTCMlMrynAwcw0vYgTVg/
 mj6s2uRwwrGmSNOTOyofg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BJlrIcF/JbQ=:Efes81chANaDychKC03WyL
 ShjLXXDKvBA8H6L5bJ0EH6teIdPt8ChiZNoUa1R+EntI/VyGW56jGeFu6HXsze7vGiSJkwZW9
 JnPZnqcPzet59EfIQbkS1AAliGssb7Jbf8Spk2ZmDQ1YMBQUMxE/+MIfpK5S7FihYCQIwazIE
 v2toAc5AxmKeo/ASieJaOzF/0GGYh4Eq9jypevX/k6jENzvpADkDnf/pv1znOIHaijUxumlcV
 asUF19W0vl/W0t04DITeX5l5SSaoQQvZepXhjpssBHO7Wk8sasVodJHN6GxpN11qA41tVsY/M
 SV0kTB355qQzSXxijtv3wM4SZVPLe0IcPCkPL3ej4ehVbRA4C6A8tkXp3UcfF4czGN3HI2Mdz
 a7Ic3v79wdTYcuoCxo0hkEjL13ZxxUB6EkGt66Be5XhrbyU/qF/bjELurRN/2jXF8t6/7nUCS
 llnQKs5Jd3kg3j7drVCXTafuFxKK6TvO2mHER0fDi0oaclbMQ2PYeFw6H718SCricQY9N6ueK
 EFkS7fMTxsPW4xPqukqtvir2qhL992LUdW1GghMZ3K2W80yjNonvxaVMJj8ueoiOTcvvRINNP
 r604w3hfil1lDcnN3v6wqsX/8md13Q0wQaazfw8qv7F3clX6MGT+SRuk0irxfvJLczfySFtcR
 ysoRf6EVn2VQHRUAWvZfbk2vNOec57v9FaDBBKRdMT0u6Esipw7HqYFYGyvAworL/PAYlDXrT
 2i3lqWbF3CzGmiyk7XZ4EJAbdJNYm7NfHVp+AA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is already handled by the compat_ioctl() function itself.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 399287b277dd..9ea1c4981332 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -528,8 +528,6 @@ COMPATIBLE_IOCTL(_IOR('p', 20, int[7])) /* RTCGET */
 COMPATIBLE_IOCTL(_IOW('p', 21, int[7])) /* RTCSET */
 /* Little m */
 COMPATIBLE_IOCTL(MTIOCTOP)
-/* Socket level stuff */
-COMPATIBLE_IOCTL(FIOQSIZE)
 #ifdef CONFIG_BLOCK
 /* md calls this on random blockdevs */
 IGNORE_IOCTL(RAID_VERSION)
-- 
2.20.0

