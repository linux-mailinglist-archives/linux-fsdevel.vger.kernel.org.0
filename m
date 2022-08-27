Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEB95A35DF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 10:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345420AbiH0Ig0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 04:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiH0IgT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 04:36:19 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C68B2CF9;
        Sat, 27 Aug 2022 01:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aq1SB9kOoIW//0eCYGLBPOABZzMIgXHFhJj0ycsWvgjkFf7kgK2QQFsBKhPnQSeKZ8FE9L8dq8JeH0+kuQbzpT+HWbA7UGES6dlCAW111VAZ+U+2pEkTQpBC1Egs8Qc9phnjofV4i5lK+Kn4mXmHWG2gyLJb3d6JD+SR0kSSlG03M5HYeS3oBq9+hUacNWrbPVcRUWc1Tv8O5wqJPxn/nIs0ImDTeQ2av6d7vknqauym8xhl3G+3VYSJzVrYjTb+bhE9OSFLnbF+v3ktpW//5j1pElA3Z+uWdjcOmKuEr1x7LDDvZ6v5LModB88zrS3j+nMLaXhKga1LvTQp4LRxSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfIL0jXgrvOPCyjkp5JlggFG1SPCX6jxWWADi84iVzQ=;
 b=GKM9jsxmyxllR4Ato6BBOftpZ1De/lu5bRSSIFnnNDqHDCCxFFFLEH8zomiyzLyDQ6ldBFDilOndaJdnVro2PbZxhuACkK/WOEh2wmRhGn60zexqJmTufMsV2DtHX9nIn1R3GsxoNZ+4VE01m1S978o93+yKF5BXYeIx3yWj44LR70WetBvsfmQACQYCI8op+lH7jnVwI8XnBYCAsVgbNfBi+RYyu+smW/O7GD6UL32zHU8EYiw/Nw6eHKdUzrulLklbXWE+kDJ5EuF6cP3p4L+17+wBZnP0Q3Gdrx9+pnOFskuHIkYmDvyKvLGVUzCRgK7Hn5YOGNHAvQCLmFe1+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfIL0jXgrvOPCyjkp5JlggFG1SPCX6jxWWADi84iVzQ=;
 b=uBStkrMhYcnrTQExiLeEZQgikXEmaYjr3EkoW36DmEsYgTWxBSsQOQbU9yNX4YkLpR9bRN17vZoa8LWqGBfGamLRdjF15vMnQg2vIdMvUZLiO1U9heQYEVo8xVGgnGZIqgmfvEsi3Hs9xd+lmaq0X8QPPlytYje1cr2DW3VgNfL5Wok+pKxkll5BXNxQihhm7BNvZdfMZhD0hThtF1DAUvDzGqOZsVnu3qUP2lXFZxf3UKhy6VsubRXjUP1tJCywSi/GrqY8a7VY7WitDqSn4n7T1a3gdcYSFn0/3zMQi7W/O91zENOF7Afz0gcNqrQQAkZJraaVPRlsQSn0nEHIiA==
Received: from BN0PR04CA0090.namprd04.prod.outlook.com (2603:10b6:408:ea::35)
 by MW2PR12MB4665.namprd12.prod.outlook.com (2603:10b6:302:2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Sat, 27 Aug
 2022 08:36:13 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::70) by BN0PR04CA0090.outlook.office365.com
 (2603:10b6:408:ea::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 08:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 08:36:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Sat, 27 Aug 2022 08:36:10 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sat, 27 Aug 2022 01:36:09 -0700
Received: from sandstorm.attlocal.net (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Sat, 27 Aug 2022 01:36:09 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/6] convert most filesystems to pin_user_pages_fast()
Date:   Sat, 27 Aug 2022 01:36:01 -0700
Message-ID: <20220827083607.2345453-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d888483f-4379-4e5b-67db-08da880731fc
X-MS-TrafficTypeDiagnostic: MW2PR12MB4665:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XkPcUDmaOJBxXoa2ShOSbTkUrp9Y5LLlzaqsnV3VWgg27Kc4OI18+8NgJFEeRpN54OHBuYxQa+8EAItSysjQMt5XyRWDuphJj/5jzkZ/355qba2Lzf7CvQQuxjxEeAFhgFNwzpl/zGesp1VbVkK7+nzSmImBKIbCmnmYMeju64wg+QC27Ry60+ykoZn0uj09hi3dsDq5o/xAKwl/FP4WuNl2xBPPDUOCMT3SHYcIGIJPhuq/5w/qhlzWRPR5XqWazFO1C9OqhnCaqhQ9cnTxpoPKauUYBZHGzYrSInyTsMVEA/8WxfpI/k/aoI6QbEcyS6RXR2PiDMiejSHGigdH/xLJRkgfme0QFhmNu834oDhtTQPQZpiTN4bwMPTfPC0K4IvKxqH+eFX6oGKFtPnTatAocpaBClwHT8R5ckJH2Bwg/Jm7hR7rQe2AdhU4vKtbd7C6G1W/mvRfTaUvv7K3RTyJTBIObEsVSmx1GGEycd/9WnLPmtAsjMzzHB2kioVHI9JtSZ8g+RmVxy0nNtpv0XDjwGW9ttiYof2m/rIhAZGplTFcB0IkryPCx713eBOp4x8Qe5JsVagI+38xZLJmCX4AIQatD1g23irHGvPPAzbYuyw/dM0t/9kwYLjkzQtFTX+eQvX5kRy4MFArABsXbMdGRc9ja3WFE+3YhTKqjl1OjEIuvdVC2ICqJykzRbSyqGmhv//mkUD2H/m2g7cYHof6D0B4ETO2f+zVEyjasdLb/hB9mlemvsXagBZN0ScrZoghaMHNOxf3BzGC3MeZzeBiJB7XJmsR2hm58Ya283o=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(346002)(40470700004)(46966006)(36840700001)(40460700003)(8936002)(47076005)(70206006)(81166007)(8676002)(107886003)(70586007)(7416002)(356005)(83380400001)(5660300002)(426003)(41300700001)(4326008)(316002)(478600001)(6916009)(40480700001)(36756003)(82310400005)(336012)(2906002)(82740400003)(186003)(2616005)(6666004)(86362001)(1076003)(26005)(36860700001)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 08:36:10.9245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d888483f-4379-4e5b-67db-08da880731fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4665
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This converts the iomap core and bio_release_pages() to
pin_user_pages_fast(), also referred to as FOLL_PIN here.

The conversion is temporarily guarded by
CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO. In the future (not part of this
series), when we are certain that all filesystems have converted their
Direct IO paths to FOLL_PIN, then we can do the final step, which is to
get rid of CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO and search-and-replace
the dio_w_*() functions with their final names (see bvec.h changes).

I'd like to get this part committed at some point, because it seems to
work well already. And this will help get the remaining items, below,
converted.

Status: although many filesystems have been converted, some remain to be
investigated. These include (you can recreate this list by grepping for
iov_iter_get_pages):

	cephfs
	cifs
	9P
	RDS
	net/core: datagram.c, skmsg.c
	net/tls
	fs/splice.c

Testing: this passes some light LTP and xfstest runs and fio and a few
other things like that, on my local x86_64 test machine, both with and
without CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO being set.

Conflicts: Logan, the iov_iter parts of this will conflict with your
[PATCH v9 2/8] iov_iter: introduce iov_iter_get_pages_[alloc_]flags(),
but I think it's easy to resolve.

John Hubbard (6):
  mm/gup: introduce pin_user_page()
  block: add dio_w_*() wrappers for pin, unpin user pages
  iov_iter: new iov_iter_pin_pages*() routines
  block, bio, fs: convert most filesystems to pin_user_pages_fast()
  NFS: direct-io: convert to FOLL_PIN pages
  fuse: convert direct IO paths to use FOLL_PIN

 block/Kconfig        | 24 ++++++++++++++
 block/bio.c          | 27 ++++++++--------
 block/blk-map.c      |  7 +++--
 fs/direct-io.c       | 40 ++++++++++++------------
 fs/fuse/dev.c        |  8 +++--
 fs/fuse/file.c       | 31 ++++++++++++-------
 fs/fuse/fuse_i.h     |  1 +
 fs/iomap/direct-io.c |  2 +-
 fs/nfs/direct.c      | 19 ++++--------
 include/linux/bvec.h | 40 ++++++++++++++++++++++++
 include/linux/mm.h   |  1 +
 include/linux/uio.h  |  4 +++
 lib/iov_iter.c       | 74 +++++++++++++++++++++++++++++++++++++++++---
 mm/gup.c             | 33 ++++++++++++++++++++
 14 files changed, 244 insertions(+), 67 deletions(-)


base-commit: e022620b5d056e822e42eb9bc0f24fcb97389d86
--
2.37.2

