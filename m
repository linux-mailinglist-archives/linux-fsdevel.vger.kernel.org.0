Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CA91CE218
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 19:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbgEKR6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 13:58:40 -0400
Received: from mailrelay107.isp.belgacom.be ([195.238.20.134]:58228 "EHLO
        mailrelay107.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727051AbgEKR6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 13:58:39 -0400
IronPort-SDR: 0Av8QGXKfZtguUfz64MS58kRssI1YyQjMz3yJRf5Dlu/KqSPOCMaqlj11ygHsyiBgb+PRnrD/f
 3dfDzlq1LsQJlbyFCAI2WISpPUWY6EUr8nxRk4j3Ui0lHadjyds6V1nrcT5zIuXEPEyVYv60XN
 kHjnbqCUxmmcexMzHgL9h3eFARfrSP3YJ52R7i4HKQbHgz/E4aaZPxGeMADAhAxJf7xZYtXUia
 gCzIgQ+LXvLxDFMfOm32lXHozQqtRl2D80UicD/B/IMG0jrbLTeoTTmEAXS3++JqE56+dZ242q
 uaM=
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3AGkl91RzOBOkotXrXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2u4eIJqq85mqBkHD//Il1AaPAdyGraMcwLOP6ejJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVhDexe7d/IAm5oQnMq8Uan5ZpJ7osxB?=
 =?us-ascii?q?fOvnZGYfldy3lyJVKUkRb858Ow84Bm/i9Npf8v9NNOXLvjcaggQrNWEDopM2?=
 =?us-ascii?q?Yu5M32rhbDVheA5mEdUmoNjBVFBRXO4QzgUZfwtiv6sfd92DWfMMbrQ704RS?=
 =?us-ascii?q?iu4qF2QxLulSwJNSM28HvPh8JwkqxVvRyvqR94zYHbb4+YL+Zyc6DHcN8GX2?=
 =?us-ascii?q?dNQtpdWipcCY28dYsPCO8BMP5YoYbnvFQOrAGxBQ+xD+3v0D9HmGL50rMg0+?=
 =?us-ascii?q?QgDQ7G3xErEtUAsHvOt9r1OrwfUfu2zKjIyzXMce9W1S3m54fWax0sp+yHUr?=
 =?us-ascii?q?1sf8TL00YvCx/FgUuKqYzjJz6b2OcAvmyb4edhVe+jlWAqpQFsrzSz28sglo?=
 =?us-ascii?q?jEiI0axF3Z+yh03ps4KN26RUNlbtCoDJVeuS6eOoV2Qs0uXWVltSAnwbMFoZ?=
 =?us-ascii?q?62ZCwHxIk9yxLCaPGLbZKE7g/iWeuROzt0mXNodbSijBio60eg0PfzVsys3V?=
 =?us-ascii?q?ZPqSpKj8fDu2gW1xzW9siHUvx9/lq92TqX1wDc9OVEIUcsmKXAKp4hzbEwlo?=
 =?us-ascii?q?cIsUTYGS/2nFj2jLSMekUk/eio7vrobq3npp+aKYB0lhnzP6AzlsClHOg1MR?=
 =?us-ascii?q?YCU3KG9em91LDv51D1TbRSgv0ziKbZsZTaJcoBpq6+Bg9Yyogj5AykADeoy9?=
 =?us-ascii?q?kYhnoHLVJDeB2Zk4jlIUrBL+7gAfeln1usiCtrx+zBPrD5AJXCNGTMkLT6cL?=
 =?us-ascii?q?Zm9k5c0xQ8wcpD6JNVErsBOu78WlfttNzECR80Kxa7w+PmCNVn1I4TV2OPAq?=
 =?us-ascii?q?uCPaPdtF+H/OMvI+2WaIAJvzb9LuAv5+Tygn8hhV8dYa6p0IMTaHC5GPRmPk?=
 =?us-ascii?q?qYbWPigtcaDGgFoBQ+Q/LuiFCZTz5TaGi9X7gm6jE4Fo2mF4HDSZ6pgLCb2y?=
 =?us-ascii?q?e7BJJWbHhcCl+QCXfoa5mEW/AUZSKcOMBuiTIEWKO6S48i1RCushH1y6Z9Iu?=
 =?us-ascii?q?XP5CJL/a7kgdp87O77jgwp+Hp/HYDV2mSMVT4vn2cgSDo/3aQ5qkt4mXmZ1q?=
 =?us-ascii?q?0trfVSFNVVr91TXws3L5/XzKQuBdn4VCrafcaPRUrgSNjwUmJ5dc4439JbOx?=
 =?us-ascii?q?U1IN6llB2Whyc=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ClBAACkrle/xCltltmglCCKoFkEo1?=
 =?us-ascii?q?RhXqMGI9dgXsLAQEBAQEBAQEBNAECBAEBhESCDSc0CQ4CAwEBAQMCBQEBBgE?=
 =?us-ascii?q?BAQEBAQQEAWwEAQEHCgIBhE4hAQMBAQUKAUOCOyKDTQEjI09wgziCWCmwdIV?=
 =?us-ascii?q?Rg1aBQIE4h12FAYFBP4RfikIEjkakJYJUgnGVKwwdnTqQHZ8kOYFWTSAYgyV?=
 =?us-ascii?q?PGA2fCkJnAgYIAQEDCVcBIgGOCAEB?=
X-IPAS-Result: =?us-ascii?q?A2ClBAACkrle/xCltltmglCCKoFkEo1RhXqMGI9dgXsLA?=
 =?us-ascii?q?QEBAQEBAQEBNAECBAEBhESCDSc0CQ4CAwEBAQMCBQEBBgEBAQEBAQQEAWwEA?=
 =?us-ascii?q?QEHCgIBhE4hAQMBAQUKAUOCOyKDTQEjI09wgziCWCmwdIVRg1aBQIE4h12FA?=
 =?us-ascii?q?YFBP4RfikIEjkakJYJUgnGVKwwdnTqQHZ8kOYFWTSAYgyVPGA2fCkJnAgYIA?=
 =?us-ascii?q?QEDCVcBIgGOCAEB?=
Received: from 16.165-182-91.adsl-dyn.isp.belgacom.be (HELO biggussolus.home) ([91.182.165.16])
  by relay.skynet.be with ESMTP; 11 May 2020 19:58:16 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 0/9 linux-next] fs/notify: cleanup
Date:   Mon, 11 May 2020 19:58:05 +0200
Message-Id: <20200511175805.214786-1-fabf@skynet.be>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This small patchset does some cleanup in fs/notify branch
especially in fanotify.

Fabian Frederick (9):
  fanotify: prefix should_merge()
  fanotify: fanotify_encode_fid(): variable init
  notify: explicit shutdown initialization
  notify: add mutex destroy
  fanotify: remove reference to fill_event_metadata()
  fsnotify/fdinfo: remove proc_fs.h inclusion
  fanotify: don't write with zero size
  fanotify: clarify mark type extraction
  fsnotify: fsnotify_clear_marks_by_group() massage

 fs/notify/fanotify/fanotify.c      | 11 ++++-----
 fs/notify/fanotify/fanotify_user.c |  5 +++-
 fs/notify/fdinfo.c                 |  1 -
 fs/notify/group.c                  |  2 ++
 fs/notify/mark.c                   | 37 +++++++++++++++---------------
 include/uapi/linux/fanotify.h      |  7 +++++-
 6 files changed, 35 insertions(+), 28 deletions(-)

-- 
2.26.2

