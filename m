Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964D11CE21C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 19:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgEKR7v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 13:59:51 -0400
Received: from mailrelay107.isp.belgacom.be ([195.238.20.134]:58343 "EHLO
        mailrelay107.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727051AbgEKR7v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 13:59:51 -0400
IronPort-SDR: 31ird6Ax8XZ7HyF9kPh/xpx0zjEl95eD76PWytPRtKINJA8whTVyfEQ0S8Af5wIltTm82yh6WL
 Y0oOrNo7XHwhDIHCnCsaGatBqZMwNhDJQBSCMGay8hR+c+FQgK7ReB/TaYcvWdV8KtovEFSsTM
 0OLgW0o+vX5bGCLg3fWlUCbr1YTKqXVaqqcgwsGoQ5qbIRnpnovSbI/8vrpcdibDll6hDjv794
 qzV49Jd/pw0Jrz3PlfTZ5j8iUZQoQNRcwirCJAUlNmyHhELcemrltY37PRXZFSWNsZcjxErrvD
 VMc=
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3AHH+IXB+wt25L6P9uRHKM819IXTAuvvDOBiVQ1K?=
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
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AaBgACkrle/xCltltmglCCKoFkEiy?=
 =?us-ascii?q?NJYV6jBiKMoUrgXsLAQEBAQEBAQEBNAECBAEBhESCDSc2Bw4CAwEBAQMCBQE?=
 =?us-ascii?q?BBgEBAQEBAQQEAWwEAQEHCgIBhE4hAQMBAQUKAUOCOyKDQgsBIyNPcBKDJoJ?=
 =?us-ascii?q?YKbBBM4VRg1aBQIE4h12FAYFBP4ERg06KQgSya4JUgnGVKwwdnTotj3CfKwI?=
 =?us-ascii?q?wgVZNIBiDJFAYDZBJAxeOJ0IwNwIGCAEBAwlXASIBjggBAQ?=
X-IPAS-Result: =?us-ascii?q?A2AaBgACkrle/xCltltmglCCKoFkEiyNJYV6jBiKMoUrg?=
 =?us-ascii?q?XsLAQEBAQEBAQEBNAECBAEBhESCDSc2Bw4CAwEBAQMCBQEBBgEBAQEBAQQEA?=
 =?us-ascii?q?WwEAQEHCgIBhE4hAQMBAQUKAUOCOyKDQgsBIyNPcBKDJoJYKbBBM4VRg1aBQ?=
 =?us-ascii?q?IE4h12FAYFBP4ERg06KQgSya4JUgnGVKwwdnTotj3CfKwIwgVZNIBiDJFAYD?=
 =?us-ascii?q?ZBJAxeOJ0IwNwIGCAEBAwlXASIBjggBAQ?=
Received: from 16.165-182-91.adsl-dyn.isp.belgacom.be (HELO biggussolus.home) ([91.182.165.16])
  by relay.skynet.be with ESMTP; 11 May 2020 19:59:49 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 2/9 linux-next] fanotify: fanotify_encode_fid(): variable init
Date:   Mon, 11 May 2020 19:59:34 +0200
Message-Id: <20200511175934.214881-1-fabf@skynet.be>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Initialize variables at declaration.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/notify/fanotify/fanotify.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 95480d3dcff7..5c6f29d2d8f9 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -277,16 +277,15 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 static void fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 			       gfp_t gfp)
 {
-	int dwords, type, bytes = 0;
+	int dwords = 0, bytes = 0;
+	int err = -ENOENT;
+	int type;
 	char *ext_buf = NULL;
 	void *buf = fh->buf;
-	int err;
 
 	if (!inode)
 		goto out;
 
-	dwords = 0;
-	err = -ENOENT;
 	type = exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
 	if (!dwords)
 		goto out_err;
-- 
2.26.2

