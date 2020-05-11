Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406C51CE21F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 20:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgEKSBF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 14:01:05 -0400
Received: from mailrelay107.isp.belgacom.be ([195.238.20.134]:58467 "EHLO
        mailrelay107.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726310AbgEKSBF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 14:01:05 -0400
IronPort-SDR: aUaxfGE8BlacwG/G0pIlSUrEd+suneAgK2yiBLlT0mhN7NN3z4lsrO3u8XAxDcRBGVcDm9tC58
 /E36Fb4sCdcmJ9Z5T6WgXhGWj1fHTFYwoTXpLN6xqSAGC+SX91n3VoHrnYvNyHMRLQ12xCacjZ
 HOTDNqse1w11U5nYn/A3NwwYbBhnxEo1qWhAhDgetqEyNruvjWbIXcmMyoydp3x95OjI0kwAJ0
 kTzYlhOPPlpZBeYA+FO30Hurb/QJcXsHekrQkADpB1dRwW2RprEhyIwwIwQHZFqrYR591Ihyn5
 frQ=
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3AoW86ABKzpNanoYpLoNmcpTZWNBhigK39O0sv0r?=
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
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BKBwACkrle/xCltltmhHqBZBIsjSW?=
 =?us-ascii?q?FeowYkVgLAQEBAQEBAQEBNAECBAEBhESCDSc4EwIDAQEBAwIFAQEGAQEBAQE?=
 =?us-ascii?q?BBAQBbAQBAQcKAgGETiEBAwEBBQoBQ4I7IoNCCwEjI09wEoMmglgpsEEzhVG?=
 =?us-ascii?q?DVoFAgTiHXYUBgUE/hF+KQgSya4JUgnGVKwwdgkuab5AdnzsigVZNIBiDJFA?=
 =?us-ascii?q?YDZBMF44nQjA3AgYIAQEDCVcBIgGOCAEB?=
X-IPAS-Result: =?us-ascii?q?A2BKBwACkrle/xCltltmhHqBZBIsjSWFeowYkVgLAQEBA?=
 =?us-ascii?q?QEBAQEBNAECBAEBhESCDSc4EwIDAQEBAwIFAQEGAQEBAQEBBAQBbAQBAQcKA?=
 =?us-ascii?q?gGETiEBAwEBBQoBQ4I7IoNCCwEjI09wEoMmglgpsEEzhVGDVoFAgTiHXYUBg?=
 =?us-ascii?q?UE/hF+KQgSya4JUgnGVKwwdgkuab5AdnzsigVZNIBiDJFAYDZBMF44nQjA3A?=
 =?us-ascii?q?gYIAQEDCVcBIgGOCAEB?=
Received: from 16.165-182-91.adsl-dyn.isp.belgacom.be (HELO biggussolus.home) ([91.182.165.16])
  by relay.skynet.be with ESMTP; 11 May 2020 20:01:03 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 4/9 linux-next] notify: add mutex destroy
Date:   Mon, 11 May 2020 20:00:59 +0200
Message-Id: <20200511180059.215002-1-fabf@skynet.be>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

destroy mutex before group kfree

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/notify/group.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/notify/group.c b/fs/notify/group.c
index f2cba2265061..0a2dc03d13eb 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -25,6 +25,7 @@ static void fsnotify_final_destroy_group(struct fsnotify_group *group)
 		group->ops->free_group_priv(group);
 
 	mem_cgroup_put(group->memcg);
+	mutex_destroy(&group->mark_mutex);
 
 	kfree(group);
 }
-- 
2.26.2

