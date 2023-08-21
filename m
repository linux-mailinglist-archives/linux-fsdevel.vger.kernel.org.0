Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AC9782FA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 19:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbjHURsl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 13:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjHURsk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:48:40 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B0B110
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 10:48:38 -0700 (PDT)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106]) by mx-outbound19-99.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 21 Aug 2023 17:48:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOieqm1NDVcqOC0yzd3c1zHNSw8UyaZpQbGDPN/fxFpTOh13AoEXdYSuo+GpRpaXej+xZCEjHB0zDbNU2SeZjj2jaQ2JkUCCPmPqtkykaJzYwJG5u5S52rot163EzMcREjPHKFrQTfQ9tWYXmUUTfdkBEkfkZgHTPTZIae9sGcKK+5menucDQNIq5KNFTS2iP+Nzb5/xQ0Ub1pP2B/3rqvFohi1hCZv3MNQD2YSJCtUVN1nrnO82T3MTTNROdIgTBBXKrezbGHnjIMpeDGsj7nZMcDgBK6u5JvD9kUBry2U/s2XvIwcELWUBGeV7db+77OIP+3IQsGCdI6CZp5RLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3vr6N5sRc7j4j1WYF99bko6vc21knDMjLZgO6Xe7lk=;
 b=CV1oOpFCSU4kQtnd8v61GvJ+e6yNHyhQGSMXX4WxpGRBYYuc0BkP4AgU2yHlJnP3h7bga1uf4QMzbh7fSUAshYocxqJga0jepCr+5mT+o/w01UAGruXoBJ9QKGlgUlKrEHq6N5KHGcV2bB/ydnB5zsxIjti01jVPEC2DQXY7gI/sCiQw9IpOn1qukMxO9nhnnQbhQyy/jAZx7aAcjc6cUUyrY1V1/Rmr6Kq5ywoENd5BAusoeQWquFMDreQ1orZqsOb5Je5fA8TByP/OQs4bbC2B+kG3YLAlaAroK+tIJ6a3KKIM1Zw3zAJScA5noSAOPzSimX6lgBHkwSrONxYPHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3vr6N5sRc7j4j1WYF99bko6vc21knDMjLZgO6Xe7lk=;
 b=QFZJO+j/ZYqSrIAYli+dh/gCPi0h1Pb6bUfLcdk3Jh5LsY1PsgG0uq2vbu4WYVEkftZ5tddBNsqYT9YMcBnLAzgouMlZli4omtsZKkXOF8DozVXu6YVo2WwDuWOTYN+72mP03wHJYFf7EtFYTeg7NUTok3CWobGYcOUX5HVxdBQ=
Received: from BN0PR04CA0192.namprd04.prod.outlook.com (2603:10b6:408:e9::17)
 by CH3PR19MB7984.namprd19.prod.outlook.com (2603:10b6:610:166::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 17:47:57 +0000
Received: from BN8NAM04FT013.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::ef) by BN0PR04CA0192.outlook.office365.com
 (2603:10b6:408:e9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 17:47:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT013.mail.protection.outlook.com (10.13.160.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.15 via Frontend Transport; Mon, 21 Aug 2023 17:47:57 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id B3CCC20C684B;
        Mon, 21 Aug 2023 11:49:02 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, fuse-devel@lists.sourceforge.net,
        Bernd Schubert <bschubert@ddn.com>,
        Hao Xu <howeyxu@tencent.com>,
        Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Dharmendra Singh <dsingh@ddn.com>
Subject: [PATCH RFC -next 0/2] fuse: Parallel DIO writes with O_DIRECT
Date:   Mon, 21 Aug 2023 19:47:51 +0200
Message-Id: <20230821174753.2736850-1-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT013:EE_|CH3PR19MB7984:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c2b5e042-6e79-4449-8c0d-08dba26ec104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOz+NscJMeuiVYFSNr5VNcC5JRFLLWS/fT3skQFN4wZpDGJNuCGQnd2HwZBJJWIUq0C5NFqQnkSK1tUqhrMX4lcBVxGxxieh6Lur4dLeZWYebts1QwnrGooot48EIB75Z77yoMh3wKkgO4kyI9DvYqeGtCCPGlVuaaFmAhC420SAyzGgJkO0naThOTbxH7aQbue20EfxnRAKbKMqMYKmpW4ibzt1n4abgkyEfINvMgzvHtQs+Jf0ftahqZy0a4lp/4DwobzEzMKbNXiRYZ3Ev7MBimIkMiN6l06gnH4F0xPBmjr8GjFkwJEnj/mFE4ppFhiv/PwyEZaeYyCgzbeSogNv88A/6vEYhCWJN/EThADWX2BQDC/VsH7CFeJZX9bHFXCd6+TWjpI66kySI5kJSNc5hZ4C6MLyGbofg1DZA+v3nxC0uA54b+HGJGEQppKkmNuyTXCMhLfFISNaCQMM+eOudgN67gYdpIWi4PVHsGka1CesNddjs1/e9CTL67bq66Ui1nFgDEx5XnmGOC6WO0wpcBgslJdxf0scZ4hpYUsAhxhe6e2DdE7cMRy1qz0ORG/peY22TWKRjvDxZhZOB3HXZj6/Qw5pbn0DKRvm1UArdWplupgAGGtfBU9WIGpGTpzL1pdSw8fR9DyBexSarkN+cCTsWbIwUldtYigW9LLM3EIuwBpNeYVZBhb/iZROuoc+FsEadtrcKWdreLEZKGBGZ9KuMoJf+MHwvZldgems3GizTB7oTmAzh01/1/ym
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39850400004)(346002)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(54906003)(6916009)(70586007)(70206006)(316002)(8676002)(8936002)(2616005)(4326008)(1076003)(36756003)(41300700001)(356005)(82740400003)(81166007)(478600001)(6666004)(40480700001)(83380400001)(4744005)(2906002)(86362001)(47076005)(36860700001)(336012)(5660300002)(6266002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?309bWzPT0WJhTaonfIGRjFxUKN2tXOK6+Ta0VePhZ5hnjhuGKmVwHkpLFG4A?=
 =?us-ascii?Q?J1X2mjKKoSu5KEOHojEHHq+NMsE6MLMXOPTP5pJK1BNudYfWZkorf+GOkuj2?=
 =?us-ascii?Q?eCGv6kpIbcXktajRfgVy595mmsgOFs7TLEt/2ENOhW8DKcGRgplgpGCVIan1?=
 =?us-ascii?Q?4L9qx0wDee5k0bFDFThNH480QsMuUn5OavYVduHh9I4UIPpQT5GMjfWDMnJt?=
 =?us-ascii?Q?lICASg5xRokacDeOkyJRBYc7zdycP/uqHzg9V6h39mEFgTrkOeCEPybShc8z?=
 =?us-ascii?Q?HXrxa3XTeKVneBgm3xh4rm+m4tNxJcT2+BMSx7T9Y5O5pDLtUFn6mjdOIO1t?=
 =?us-ascii?Q?Q7nmzjyLGHnzmv+RtLXM9kJLN6jiyiZ6+WhrRZ3Eg4AnTN3HbX+Yev4Qnoez?=
 =?us-ascii?Q?8zkbq8TqKLHHqE7k+z6+MBkaY9luWwuxAzcikRqoxmWXJ5PLro0Ph2MEylw+?=
 =?us-ascii?Q?1Sj5Ou9AEcIAneT1PAxY0WW7zcyN4F+gccqQRJ3oQ0PSAkv0aQgTitk+/Y0+?=
 =?us-ascii?Q?oHiNGgi4SqKtO1yN1bTvyFHaDnkmHh6gg7tLE9wLo/wvdM/rr/pDkqyR0Cfw?=
 =?us-ascii?Q?DEl/cs3J4sNadwGFQF79o+OT6dIHdSaxyCNx5KxJ501tocEVPrrssbkAG0aL?=
 =?us-ascii?Q?QXG5sNFTg8pVYN0+l/bVoIG6Y/L6H0H6j8BENxdAudJxI6/O8yMNjR9BraLk?=
 =?us-ascii?Q?yLTA5QVsZz9C/ddqW+enael/32pFysLWq/Bfxr17uQV473SHuBpvY/5WpzJW?=
 =?us-ascii?Q?gqx7W2Y/e9G4yyEazEt47gkEwDifZnviY2jadhpe4BFwIwCOap2hhxHX3XF4?=
 =?us-ascii?Q?4UyvHfLq91dsbBWxTxHwuDItwVst/riB7fKkJBeojdbuL+1rGTGZkwgctSfw?=
 =?us-ascii?Q?lc4e7dSyXqCgvUeVqg9lS3bYz7/4rzRmfUB4iAEwO3yFldxdTmBTKRDzDGrW?=
 =?us-ascii?Q?0uCCUKkzI6Xxjh220ItfQErH1dKysf5Mv03JLhftE/g=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 17:47:57.0053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b5e042-6e79-4449-8c0d-08dba26ec104
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT013.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB7984
X-BESS-ID: 1692640081-104963-12415-6122-1
X-BESS-VER: 2019.1_20230821.1520
X-BESS-Apparent-Source-IP: 104.47.58.106
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpaWhkBGBlDMwjA12SApMcXCwt
        w8xSgt1dTAKMXUyDjR2MDIKM3M0lKpNhYA1xHo6EAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250295 [from 
        cloudscan22-126.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In commit 153524053bbb fuse gained the possibility to do parallel
DIO writes, when FOPEN_DIRECT_IO and FOPEN_PARALLEL_DIRECT_WRITES
are set. If server side only sets FOPEN_PARALLEL_DIRECT_WRITES,
but does not set FOPEN_DIRECT_IO, O_DIRECT from the application
is still serialized.
fuse-next has changes in commits b5a2a3a0b776/80e4f25262f9, which
allow to take the optimized (in respect to parallel DIO) code path,
dirty page flush and page invalidation have to be done unconditionally,
though.

v2:
Rebase to 6.5/6.6-fuse-next

Bernd Schubert (2):
  [RFC for fuse-next ] fuse: DIO writes always use the same code path
  libfs: Remove export of direct_write_fallback

 fs/fuse/file.c | 27 +++++++++------------------
 fs/libfs.c     |  1 -
 2 files changed, 9 insertions(+), 19 deletions(-)

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org

-- 
2.39.2

