Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4714D78C96B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 18:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjH2QOC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 12:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237413AbjH2QNh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:13:37 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE611AE
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 09:13:25 -0700 (PDT)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106]) by mx-outbound10-135.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 29 Aug 2023 16:13:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEwE0gGgH0QYYzgRQZP1s0GZVh2wjQqIGX9jq1ANjJnS6vDI8St3Rl9p8d4rxHUCoYdnnW6CRsFNupGa9ROSIc8+H7NQHKQKomu7SsxDAe8gJD23ERjAtR3YhO5j5ao94WVtv8+6dwUpEelvFTDCbUZ+0upTRiio/qo2SDrYZzeVM3fJ8EwJrFjbVmydb3CbEmIPd1yR3xmoP7xW0pdvbmcNRNQJG9Xovtu7CFqhvKw/5w1Nu7K96NEVnQcVAYr39/Ds4RhKEkzajMDl57nrBevdS2hOyKw57Z7P0+4agml9H5BWGKRddl3ls1E/WXjxbO7rXx8M/WzFJfs5s9K0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnFnqblQNb6xaJe6S57L+6vKMeHDy13WBB0V8qVycpM=;
 b=KSROWHip7OI4gQwe7Z+K4M5hBLqubeLjFrjbUskhOG1eyBB8VYmS8YBGjcDgsUSGHix9TySbX2BOv4AScm/Lnx+PTLY4YBoc4QG/a+6FcjqsC9AJHPqv4gtjGCJx6EwVkw7eZxGht+VIhyriujLwDyq2OWPQ2LUEkIZsdR1+7iiMmRt94AE/prGk6zw+6ZdDacy7m2GkvAkO9bQx9YlXD+MxSnW+rYMW2zVRrpkguIYT/irX25tAedORvQzGMdQ6+kwCzpKgU2ROdur4qVzeg0hrFiLZx13s6EFfqBp2rb+vd/8vY970NCAQZbYt5iljJqG4ABQYLqzJ06uJEWzbvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnFnqblQNb6xaJe6S57L+6vKMeHDy13WBB0V8qVycpM=;
 b=v0Cold77loY3wVypYm6KIiY0mLyb095KTyBdivj40l2y5iC7aBhLZXHbLjFF2ZfXtFLZgfiGQRPna0F6uP3cB6pkbcNg2XmaZ+cARZ9swlAEamqbT5lADziaVmC6KHlCb3nj4/XnIlwrZ+SuJ0MzTuPy0gpvW1h7r3qmI4MdHxg=
Received: from BN0PR07CA0026.namprd07.prod.outlook.com (2603:10b6:408:141::26)
 by DM6PR19MB4214.namprd19.prod.outlook.com (2603:10b6:5:2b9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 16:11:28 +0000
Received: from BN8NAM04FT064.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::54) by BN0PR07CA0026.outlook.office365.com
 (2603:10b6:408:141::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36 via Frontend
 Transport; Tue, 29 Aug 2023 16:11:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT064.mail.protection.outlook.com (10.13.160.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.16 via Frontend Transport; Tue, 29 Aug 2023 16:11:27 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 4453320C684B;
        Tue, 29 Aug 2023 10:12:33 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 6/6] fuse: Remove page flush/invaliation in fuse_direct_io
Date:   Tue, 29 Aug 2023 18:11:16 +0200
Message-Id: <20230829161116.2914040-7-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829161116.2914040-1-bschubert@ddn.com>
References: <20230829161116.2914040-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT064:EE_|DM6PR19MB4214:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e429ebcf-db7e-42c3-8982-08dba8aa99b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUFUvcASuWYQb+dHxk06peeGq4QMOk4E+TxqAHcLd4y+yaQsYwJ3Zcudhox9s7Qy7S1ca7/1URTo41VvKRTcIDrw7FYKSNT8A7AFwCM8/v50/tOHqgocGTumBwED031DKd2nxojMNBGmAP2FhebXe4XdUBT7KbXS2pwIIOCcTDZCg+pJg/ti9wY25YVgqMY4Qd+iCTFM7v9U+kSbuYRlvMXSXch6t+1GbHLckzAhI6KBsG7BM7W0arJP+bXGQChdwaDWIpzW6KHiWmafDER8kIV6jeBTq9FU1Gi5OE6fWQkE88vmDbKu/DQ9xObSohLiSUmS74DxQnY3YIAN9V0FwqwyfYbeC38TsHXkz1bzTg2hA4ZMCDUZH792vkZA3rWqzGst+fAxJT3DEQPbGfW67TbctxeBP6UPCGRI1L3c2PtB+/0d3vw+o7DTqLWRskAe7B+E6oBlphn6LjLuHYwbykGVXb/12PuTS+E/zHT5HM+7S1REqCZ2FhXWElzVI6zDERogKm2wcOWEr1nZPtxVigUZ+D2G+nQjH1dcWAS8zkVTJMNOcxEIBruokTQ0gJvsTBEnXhex6MC6pAHJ1ebaj2UXHtNIS1cH1B0kajemA+T3qdrjIZbrgf9/S/visT9zz0YIIzAcJn6T4QzB3nug04T3qrUQ/iC/cG0k4u7mBB2TzjLERFH7NgmwrsFJ1utuzQgHVcobqBx1ChS8nIYwWp8PLAjkHVMMFpAzGosQcoDGecrUVsRrQGC3ObbYqyQv
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39850400004)(396003)(82310400011)(1800799009)(451199024)(186009)(46966006)(36840700001)(316002)(6916009)(41300700001)(4326008)(6266002)(336012)(2906002)(83380400001)(47076005)(86362001)(2616005)(36756003)(26005)(5660300002)(1076003)(8676002)(40480700001)(36860700001)(8936002)(6666004)(81166007)(356005)(82740400003)(54906003)(70206006)(70586007)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oMPSj5LLy6ovBq8R+B0EUhfFJML0zhiPWU+1ravAJAn72hlAA5pmzW85i32V+9rvn7CB4SMbFlnN3LMy88tnUOIoy/c4u1vl8SPwdfdncp/3J0mvQ+UdzIu4zhd3R1GuwReRpmBCa0lH7yb3X7Yx+nI/B7saYBE6EzuQvhK6OvgBJp1I0MjnSB9Y3JsQfiZQn418G4fjsr4mmjYGUzDJGOL9X4b209nrDJEd6ef9X2rixi3tq5F5l83KkcbvaQDjt65jZ2x5P9NBApTjoReM5yPSuCIiHPBNAIJhQUEfzsEj6TANkwvcAWWWp+sxEywclHvpeAdKcOOu5/cGOp3QbieFl219W9oXGCppmkOsL7VI8ln4LzDFcZQrttPYBFzv2DgiaT/BoWT29UEvgPE2g5H38fj1Y12JxhhvsYa3tPrt1EvH4jY4wKNIZUfKFBVyOr8n5bZ9+qI7YxC8xKGn+Opzt0nxtAgBSoUHTHiQmurLufDKQeqxTNJ0iAwAyEP7bHZsApn5HU3OoOBPkBLLyI4btKyo21VRk/xGzg31a8+7n4fgL4aFwTwurXrPHnH6+IEvh2amk7FZPMkWM2sT4ZatLJlVXwx3h1tBVLTQMOuYPTvrmc71+0Y7Y4g3aqnTZZIEvj6v7Dimw77XK1L6KgWZfzs/zDgvDhOTDDtMN1ZivTUofrxQQ/Tj5NeKurwvGXfWRMVeDOr/+LX9Prb6CzDfSMd9wHzrEgu15xjfK/dR1bJS8HVMEUu7WxHHjemXX7SY3pXT6f3ItzJ1I7ic24G2mRnNwh1dcC54XvXyUBxIC2eE2eRyjGX7Nr0ll8HMVa+xmtEeqgw0QQNeM5hnWdDWNhvRSbvHUGCHdU5065lR3SI875gVCP3jAiuP9Ufenvix4VI0CwgvMOH6wNlzX/I+TYc08daepu9G9QsMUAE=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 16:11:27.8147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e429ebcf-db7e-42c3-8982-08dba8aa99b4
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT064.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4214
X-BESS-ID: 1693325583-102695-20224-1223-1
X-BESS-VER: 2019.1_20230822.1529
X-BESS-Apparent-Source-IP: 104.47.70.106
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZmJsZAVgZQ0CjNxNAiMTE5MT
        nN0NTMPMnAyDwxzcTMzDzRwMAs2SxNqTYWAGuKARVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250471 [from 
        cloudscan12-78.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Page flush and invalidation in fuse_direct_io can when FOPEN_DIRECT_IO
is set can be removed, as the code path is now always via
generic_file_direct_write, which already does it.

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/file.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 0b3363eec435..eaafa3fb0e0c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1486,20 +1486,11 @@ ssize_t fuse_send_dio(struct fuse_io_priv *io, struct iov_iter *iter,
 	int err = 0;
 	struct fuse_io_args *ia;
 	unsigned int max_pages;
-	bool fopen_direct_io = ff->open_flags & FOPEN_DIRECT_IO;
-
 	max_pages = iov_iter_npages(iter, fc->max_pages);
 	ia = fuse_io_alloc(io, max_pages);
 	if (!ia)
 		return -ENOMEM;
 
-	if (fopen_direct_io && fc->direct_io_relax) {
-		res = filemap_write_and_wait_range(mapping, pos, pos + count - 1);
-		if (res) {
-			fuse_io_free(ia);
-			return res;
-		}
-	}
 	if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
 		if (!write)
 			inode_lock(inode);
@@ -1508,14 +1499,6 @@ ssize_t fuse_send_dio(struct fuse_io_priv *io, struct iov_iter *iter,
 			inode_unlock(inode);
 	}
 
-	if (fopen_direct_io && write) {
-		res = invalidate_inode_pages2_range(mapping, idx_from, idx_to);
-		if (res) {
-			fuse_io_free(ia);
-			return res;
-		}
-	}
-
 	io->should_dirty = !write && user_backed_iter(iter);
 	while (count) {
 		ssize_t nres;
-- 
2.39.2

