Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60965028F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 13:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352739AbiDOL4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 07:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbiDOL42 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:56:28 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2076.outbound.protection.outlook.com [40.107.96.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CB9A27C0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Apr 2022 04:54:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YW/O6caCECI/V+eyDYNM7pUyLXkC6XyKlWsIZAEMrjEp2rB7x+VpMQIDpALfwZe5b0KAJm1+czVjo6zeh4DRnHWVh4rQCHww4hbzsECNNVoL+fqmBBHdOtLRjuO7kcNBBZ5ybgazDZ24V1Pz87odo89isFnMACIIZ3mjAWRjBjhqaAkbS3PG9fTsySjJFUmRqMIjGN17oNKwuLF5xdAH8kcpmniHKqAPZMR87oNs3BLabb/jPBxjSOp4yOrtrZWUSoXcH7VtELRRJ+/XxwuTk7YsPPk4GfKJf619+EUyqbIrQSNpOJs7mO3Onin1FTidI2y3WmhG2RDQTJe6MP9Vig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygdQevocBSy3JuJzecQBqeCgLwaGpjgCUpeUlwHU8Mc=;
 b=O84Ca9wdtEhtZrKNyM4bTihrmulI1PVtsdVmFyDHcXIqrtNEjkppQcUokHt2ZOPhWiJj1srp1oOGV9Fh6xNxI4QnUGmF1NI1OC7a273qWGoDEAMK25s3H0/RsHxTRSIKh6x7fCg/lAklUNzsfrvz/YhURmVngZeGPJzyguks6ukembCo2mUoYVDoaVSVBl2f9MpiTJJ8bSjQv9G2cMz07mvIYMj8it6hgrnEFczZhrkkQWceTq7XBVqmXG5hht+4TsFVSYzNkINd7xExNEPAHIlUxTiZ31+qWtt98pxwUXrXE5Ff4u+GSCedFZt8/fGknBz6adPH9hiwxX5jvGqM2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=none pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygdQevocBSy3JuJzecQBqeCgLwaGpjgCUpeUlwHU8Mc=;
 b=DBTqGpfFVQvxO8ip+GbslC11IW+C0NY5+cCsz9nWtkWqFny3+nDe8+XftrFrjWOhCm94S2xqKXuP0tYSM/10LeUCCTtWUee/qLc2kg8jPmxEPJZGpJlkJHvwPODyB4TGN6mdMe5h0b5h9X9gGONojR67bMJoMCI94J0Ib44fLyo=
Received: from MW4PR04CA0100.namprd04.prod.outlook.com (2603:10b6:303:83::15)
 by BY5PR19MB3444.namprd19.prod.outlook.com (2603:10b6:a03:1cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Fri, 15 Apr
 2022 11:53:57 +0000
Received: from MW2NAM04FT034.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::2c) by MW4PR04CA0100.outlook.office365.com
 (2603:10b6:303:83::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Fri, 15 Apr 2022 11:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com;
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT034.mail.protection.outlook.com (10.13.31.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.19 via Frontend Transport; Fri, 15 Apr 2022 11:53:57 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 38BFD20C6847;
        Fri, 15 Apr 2022 05:54:33 -0600 (MDT)
Subject: [PATCH] fuse: Apply flags2 only when userspace set the FUSE_INIT_EXT
 flag
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, jefflexu@linux.alibaba.com, dsingh@ddn.com
Date:   Fri, 15 Apr 2022 13:53:56 +0200
Message-ID: <165002363635.1457422.5930635235733982079.stgit@localhost>
User-Agent: StGit/1.4.dev34+g8254ffb
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c951379-b346-4484-c8d0-08da1ed69fa2
X-MS-TrafficTypeDiagnostic: BY5PR19MB3444:EE_
X-Microsoft-Antispam-PRVS: <BY5PR19MB3444B1270DBD42D09DABB96AB5EE9@BY5PR19MB3444.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQUZvriMgoRq6giWi/GhWwMarUe3o1OMBiAXMHfzVl6UY3lTwYU4oU9bwnchk07OCCJEJcpQWmm/9tIBD6167OkWRGWb0MA/djscjRr+4t6ObRtOpRIxzfnRm42T2sbRfZoLzPQleKDuOyJaNJraHtAqDhOt/oKXu1FeZgVUlf/ittZT9sg9i8qkhGg5jAMYx8zSyqA4OTglgmBsH2i8LMhlEb8srnJTHYJgjJEjsMxNmle4ahjoNCVU3qYupDubzDK5WCPGPcNzLU+xZZq6qfzuVpH7bSBxxhvjDl66kDroEWEFMJxUd5ZNQLSj+zgqWYezuWQGMAhF67d55EReNoPHJg7XSp4V6vsfNAsjTHAX749h2NY2Nxi8IdhfbUgeXsBZZW0mdXrTUK8wQN5WN6H0g3sJg9id0ohT8urfXsFMq2T0nfnpVZ4fItLv0XykvdzV3V/kd2ogGb42iq576RcTGiCdRPUs8r9UDNG54etwEGwN2DOq7VTvSarz75kJxtBmhEfScJHfiSoAnPKCcOUsF/zscgh5JN7LgGT/qOpzysKuBrwweYiRtD7m3BWuzq7lFDkZwx8ng8NyIB7sXZUCEioU7FxexWojbUXM1xFODU0F2SdkrHYBgewBlK1233FUjdb9wqMH5RtGPXD1Ia3d/hmt9q0AhfU4fk3/H/uEBeofas/OcUjayvMpwd/HRi5ddLXG0oxcFHnH5N7+sAFYDwUq0JolVbsl7N95tN9plki2lyajGD/n6Qk9kErL
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(2906002)(508600001)(86362001)(70586007)(4326008)(70206006)(36860700001)(83380400001)(9576002)(8936002)(6266002)(9686003)(966005)(5660300002)(8676002)(55016003)(356005)(336012)(81166007)(47076005)(33716001)(82310400005)(316002)(6666004)(103116003)(26005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 11:53:57.5489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c951379-b346-4484-c8d0-08da1ed69fa2
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT034.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3444
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is just a safety precaution to avoid checking flags
on memory that was initialized on the user space side.
libfuse zeroes struct fuse_init_out outarg, but this is not
guranteed to be done in all implementations. Better is to
act on flags and to only apply flags2 when FUSE_INIT_EXT
is set.

There is a risk with this change, though - it might break existing
user space libraries, which are already using flags2 without
setting FUSE_INIT_EXT.

The corresponding libfuse patch is here
https://github.com/libfuse/libfuse/pull/662


Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/inode.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 9ee36aa73251..8115a06d5fbb 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1115,7 +1115,10 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 		process_init_limits(fc, arg);
 
 		if (arg->minor >= 6) {
-			u64 flags = arg->flags | (u64) arg->flags2 << 32;
+			u64 flags = arg->flags;
+
+			if (flags & FUSE_INIT_EXT)
+				flags |= (u64) arg->flags2 << 32;
 
 			ra_pages = arg->max_readahead / PAGE_SIZE;
 			if (flags & FUSE_ASYNC_READ)

