Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7E41CE22C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 20:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgEKSCf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 14:02:35 -0400
Received: from mailrelay107.isp.belgacom.be ([195.238.20.134]:58610 "EHLO
        mailrelay107.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbgEKSCe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 14:02:34 -0400
IronPort-SDR: rxp6Kn8uyDJ/BhICncl+TvFI3dOyE/RusIYuDHVw45Pa9xbWxGKlPoaqjIIVMeJgNy+3djqyyb
 MPSOFUbbU16ilEHxf6SG/d1UHZZ4qWqpK16ermUjExGJRNFl2/uGU+77Oogbt/u4SWkySrcU4s
 eKCSugjcuK1gOxr1zDywT3kPQt/mEcdPC7Oxbc9M6fhHfEjMR3KB9CJxtHg8XMKNmNt0iVcfWc
 d8I9HWfpUh+IBXq15yl38nVyDr2fHFgEMR+Yarnqb6ruXus8t54J0WjtfO3pWIPCkuZi4kh4l6
 Vq0=
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3Apui0rh18VPP31ifIsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMSIvad9pjvdHbS+e9qxAeQG9mCtrQV06GP6vqocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTqwbal2IRmqogndq9QajZV/Iast1x?=
 =?us-ascii?q?XFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0VbNXAigoPG?=
 =?us-ascii?q?Az/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VS?=
 =?us-ascii?q?i+46ptVRTljjoMOTwk/2HNksF+jLxVrg+vqRJ8xIDbb46bOeFicq7eZ94WWX?=
 =?us-ascii?q?BMUtpNWyFHH4iyb5EPD+0EPetAr4fyvUABrRqkCgmqGejhyiVIiWHr0qIkye?=
 =?us-ascii?q?QhEB3J3A89FN8JvnTbts76NKkJXOCuz6nJzTPDYO1K2Tvn84fHbAksrPeRVr?=
 =?us-ascii?q?1/bcTf01MgFx/ZjlqOs4zlOSuY2OoOvmWf7+RtVOKih3Appg9xvzWj2toghp?=
 =?us-ascii?q?XIi4waxV7J6Ct0zZgoKNC4SkN2f9GqHIdeuS+VM4Z4QsMsT39stSs817YIuo?=
 =?us-ascii?q?a7cTAOxZg63RLTdv+Kf5aS7h7+VeucIS10iG9kdb+5mh2861KvyvfmWcmxyF?=
 =?us-ascii?q?tKqy1FncTSuX0VzBzT79SHSuN6/ke8xTaDzwDT5f9AIUAzjafUMJ8hwrE/lp?=
 =?us-ascii?q?oOqkTDBSj2mEHrjK+NbEkk+u+o6+H5bbn+p5+cMZF7ih3mP6kqh8CzG/k0Pw?=
 =?us-ascii?q?sQU2SB5Oix1b3u8VfkTLhLlvE2l7PWsJHeJcQVvK65BApV354t6xmlFDim3s?=
 =?us-ascii?q?8VnWIELFNFfhKIkZTpN0vVL//mFfu/mUijkC93x/DaOb3sGpfNIWLfn7fiZr?=
 =?us-ascii?q?t98FNcyBEtwtxF+51VC6kLIOjvVU/pqNzYEhg5PhSuzObiCdV9zIETVGyOAq?=
 =?us-ascii?q?+dK67SvlqI6fguI+mIfoMapDH9K/097f70kXA5gUMdfbWu3ZYPbHC4H/JmI1?=
 =?us-ascii?q?iWYHb1jNcBCnoFsRQgTOP0jF2PSiBTZ3msUKIm/D07C5ypDZ3FRo+zhLyNxi?=
 =?us-ascii?q?C7HodZZmpeEFCDDW/od5mYW/cLcC+SLNVunScKVbW6UI8h1hGvtAnkxLp7NO?=
 =?us-ascii?q?bb4TMX5trf04137ubQvQov7jEyBNbZm2iITnsrxWIMbzAz1aF750d6zwSty6?=
 =?us-ascii?q?991tJRH91a4btnSAo2OITdxO8yX977UAzpZdSYTlu6BN+rV2JiBuktysMDNh?=
 =?us-ascii?q?4uU+6piQrOinKn?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CoBAACkrle/xCltltmglCCKoFkEiy?=
 =?us-ascii?q?NJYV6jBiPXYF7CwEBAQEBAQEBATQBAgQBAYREgg0nNAkOAgMBAQEDAgUBAQY?=
 =?us-ascii?q?BAQEBAQEEBAFsBAEBBwoCAYROIQEDAQEFCgFDgjsig0ILASMjT3ASgyaCWCm?=
 =?us-ascii?q?wQTOFUYNWgUCBOIddhQGBQT+EX4pCBLJrglSCcZUrDB2dOpAdnyQ5gVZNIBi?=
 =?us-ascii?q?DJFAYDZ8KQjA3AgYIAQEDCVcBIgGOCAEB?=
X-IPAS-Result: =?us-ascii?q?A2CoBAACkrle/xCltltmglCCKoFkEiyNJYV6jBiPXYF7C?=
 =?us-ascii?q?wEBAQEBAQEBATQBAgQBAYREgg0nNAkOAgMBAQEDAgUBAQYBAQEBAQEEBAFsB?=
 =?us-ascii?q?AEBBwoCAYROIQEDAQEFCgFDgjsig0ILASMjT3ASgyaCWCmwQTOFUYNWgUCBO?=
 =?us-ascii?q?IddhQGBQT+EX4pCBLJrglSCcZUrDB2dOpAdnyQ5gVZNIBiDJFAYDZ8KQjA3A?=
 =?us-ascii?q?gYIAQEDCVcBIgGOCAEB?=
Received: from 16.165-182-91.adsl-dyn.isp.belgacom.be (HELO biggussolus.home) ([91.182.165.16])
  by relay.skynet.be with ESMTP; 11 May 2020 20:02:31 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 7/9 linux-next] fanotify: don't write with zero size
Date:   Mon, 11 May 2020 20:02:27 +0200
Message-Id: <20200511180227.215152-1-fabf@skynet.be>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

check count in fanotify_write() and return -EINVAL when 0

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/notify/fanotify/fanotify_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 02a314acc757..6e19dacb2475 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -485,6 +485,9 @@ static ssize_t fanotify_write(struct file *file, const char __user *buf, size_t
 	if (!IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
 		return -EINVAL;
 
+	if (!count)
+		return -EINVAL;
+
 	group = file->private_data;
 
 	if (count > sizeof(response))
-- 
2.26.2

