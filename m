Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0001CE222
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 20:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbgEKSBb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 14:01:31 -0400
Received: from mailrelay107.isp.belgacom.be ([195.238.20.134]:58510 "EHLO
        mailrelay107.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726310AbgEKSBa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 14:01:30 -0400
IronPort-SDR: ivXJ1JMA1nfFgULfRsKz2UDhjNCU3uyqkaizu6j/Dud6U44KbPgH5dItYcuuVW9nQi9ga843Ds
 /vM3PEetQnibyBjQxWlZt/t3U7mWKIPF6p2+XZ0V3h/OaO6SVxoiXunut5rSpqv5Y5JVXT0Efn
 8vkyL16pY+RsO0+k16Ky3WRwKbCM8fquoXSOztSqpr1VsWdBGdpEf6CTP7rxz/BhADvCX6YjGK
 qO2STqSH+jrNHTag2cfZ0xNl/D8p6KYu1BnaIEK3e3nk8KbIsDqdSgKMeIvVeL9EX7K2SHbOeJ
 xeM=
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3ArdYc6hKeW7AbVUPih9mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfLvTxwZ3uMQTl6Ol3ixeRBMOHsq8C2rKd6vm6EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCe9bL9oKBi6sQrdutQLjYd8N6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhSEaPDA77W7XkNR9gqJFrhy8qRJxwInab46aOvdlYq/QfskXSX?=
 =?us-ascii?q?ZbU8pNSyBMBJ63YYsVD+oGOOZVt4nzqEEVohu/HwasAv7kxD9ShnDowKI1zf?=
 =?us-ascii?q?4hEQDa0wwjAtkDt3rUo8/uO6ccSu2116rIzDXFb/xIxTfx8pPHfQ44rPyKQL?=
 =?us-ascii?q?l/ftbfx1M1GAPZklWft5blPzWN2+oDsGWW6+puWOOvhmI5pQx/oiWiytsxho?=
 =?us-ascii?q?XVh48bxV/K+Dh3zYsrONC1SEx2bMCrHpdMuS+UOI97TMMiTW12vCs3zKANt5?=
 =?us-ascii?q?2jfCUSzJkr2gTTZ+GEfoSW+B7vSeecLDdiiH54eb+ygQu5/1K6xe3mTMa01U?=
 =?us-ascii?q?5Hri9CktbRqH8AzwfT6s2bSvtl+UehxCqP2xjT6u5aJUA0krLWJIUgwr4/mZ?=
 =?us-ascii?q?oTrF/DHjTxmEXyka+WbV8o+uiv6+TifLrqvp6cN4lqhQHiKqkjntGzDf4lPg?=
 =?us-ascii?q?UNQWSX4/mw2bzj8EHjXblHj+U6kqzDv5DbIcQbqLS5AwhQ0os75RawFSyp0N?=
 =?us-ascii?q?oDkHkcL1JEeBSHgJb1O13UO//3E++zg06wnzdz2/DGIrrhD43PLnfZjLjhfq?=
 =?us-ascii?q?1w61VByAoo099T/Y5bC7AZKvLpRkDxrMDYDgM+MwGs2ennDdR91pkcVG+BA6?=
 =?us-ascii?q?+ZNLjfsVCN5u01IumMYJUZtyr6K/gg//Tul2M2mUcBfam12psacHS4HvVgI0?=
 =?us-ascii?q?WEbnvgm9kBEXwXsQUgUuzlllmCXCVNZ3a9Qa08/Cs3CIG4AofZQICinriB0D?=
 =?us-ascii?q?28Hp1MaWBMEkqMHmvwd4WYR/cMbzqfIsF7nTMfW7isUJQh1RKutQ/81bVnMv?=
 =?us-ascii?q?DY9TYGusGr6N8g5eTYljkp6Cd5Sc+PlymESmBuwTgJQxc52al+pQp2zVLQ/7?=
 =?us-ascii?q?J/hql2HNZS7vUBfB03OZPGzud5Q4T8UwjPVsyKWVCrXpOsDGdiHZoK39YSbh?=
 =?us-ascii?q?MlSJ2ZhRfZ0n/yDg=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ChDAACkrle/xCltltmHQEBPAEFBQE?=
 =?us-ascii?q?CAQkBgV6CKIFkEiyNJYV6jBiKMoU/gWcLAQEBAQEBAQEBNAECBAEBhESCDSc?=
 =?us-ascii?q?4EwIDAQEBAwIFAQEGAQEBAQEBBAQBbAQBAQcKAgGETiEBAwEBBQoBQ4I7IoN?=
 =?us-ascii?q?NASMjT3ASgyaCWCmwdIVRg1aBQIE4AYdchQGBQT+EX4QVH4YOBLJrglSCcZU?=
 =?us-ascii?q?rDB2dOi2PcJ87IoFWTSAYgyRQGA2fCkIwNwIGCAEBAwlXASIBi0OCRQEB?=
X-IPAS-Result: =?us-ascii?q?A2ChDAACkrle/xCltltmHQEBPAEFBQECAQkBgV6CKIFkE?=
 =?us-ascii?q?iyNJYV6jBiKMoU/gWcLAQEBAQEBAQEBNAECBAEBhESCDSc4EwIDAQEBAwIFA?=
 =?us-ascii?q?QEGAQEBAQEBBAQBbAQBAQcKAgGETiEBAwEBBQoBQ4I7IoNNASMjT3ASgyaCW?=
 =?us-ascii?q?CmwdIVRg1aBQIE4AYdchQGBQT+EX4QVH4YOBLJrglSCcZUrDB2dOi2PcJ87I?=
 =?us-ascii?q?oFWTSAYgyRQGA2fCkIwNwIGCAEBAwlXASIBi0OCRQEB?=
Received: from 16.165-182-91.adsl-dyn.isp.belgacom.be (HELO biggussolus.home) ([91.182.165.16])
  by relay.skynet.be with ESMTP; 11 May 2020 20:01:29 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 5/9 linux-next] fanotify: remove reference to fill_event_metadata()
Date:   Mon, 11 May 2020 20:01:25 +0200
Message-Id: <20200511180125.215048-1-fabf@skynet.be>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fill_event_metadata() was removed in commit bb2f7b4542c7
("fanotify: open code fill_event_metadata()")

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/notify/fanotify/fanotify_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 42cb794c62ac..02a314acc757 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -328,7 +328,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	ret = -EFAULT;
 	/*
 	 * Sanity check copy size in case get_one_event() and
-	 * fill_event_metadata() event_len sizes ever get out of sync.
+	 * event_len sizes ever get out of sync.
 	 */
 	if (WARN_ON_ONCE(metadata.event_len > count))
 		goto out_close_fd;
-- 
2.26.2

