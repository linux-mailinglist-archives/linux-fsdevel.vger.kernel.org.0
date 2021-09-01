Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD1F3FE175
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 19:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhIARws (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 13:52:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13784 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232026AbhIARwq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:52:46 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181HORnV012672;
        Wed, 1 Sep 2021 17:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=AyDFYLThb3UjJuDd/4bmYV44RUbnmngo5PrJcOiYfSU=;
 b=lj25YgBQRb6Ue63+FPPB+qABVB4zGGIylZI+yXTKJ+ZO02BzXYdcnTUqtVyxYQ+t7Ych
 eIDolpKqSkST84hb0RyXh2jtpt8u1uaEyKNjcnHBihEHdPZImmaRQRNOah9OjDC5QeQe
 qdI5rzkGUClLsWeMQGfkOdjobj1DguLGQCNk+1NSfx4CbTcZ53Vbrp8pZNN3SK6wJXky
 +xaTz/Q6JgxkAzyJJXGAcoAkITcpUGg9TB26CvMbHotbmAC1bMsvfvlleOLwWsr6h1/Y
 GCo7Hna6+YhrtHpba/hSmRxaR+gktZ7v75cTO+fpJY11Qul13I0rhwCZDbG9k9ED+xZa 5Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=AyDFYLThb3UjJuDd/4bmYV44RUbnmngo5PrJcOiYfSU=;
 b=X45EiCGyVpJaaELnovNkoqpO+/6DlU4BZGRV2TZXGrmWs+YuZgNwz7suXLqmZKbavccK
 CDY9rB2Gr5K3JFXNQauRkyL2kPE5sdhUEYXxzCs3vQ94O3P5sxNP0l2i4NW6le3yZlKU
 I3MmY32fRI6RYhQz15KILZ3EUcTXICgSKJIpS9DLaScmy/+7cF4TsbqTotiWZOIe60XJ
 GossbIuqI16ldOUaJ4udCRHnJVDA7jCZxG0Rnih6BPbNasLJt4lxIvcK6ZUaxEHL/hZj
 5b9c/5GePCH0rbqcruyZPIgS/NuZtVMzGtSKMwgzealoLF+TKGPWodZ7Uvr7k7tlpV/l qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw182ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 17:51:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 181HnkDh128239;
        Wed, 1 Sep 2021 17:51:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3030.oracle.com with ESMTP id 3atdyvrtrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 17:51:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJJ5e+SEh73pFq+jHWp4oNN1bf1r2OEsKQxPgDM6O+pGoldU8M7Ceb19U2ceb7W1AC2uRx7N7o5f1sWzoi2VDbxBZQIqFQyn5inxs1yJ5gFSoZ29eBeKZvfTDV2VTSEbJhki24IUNfr4X3cJV+NQibmMEYLCHWZWYsf8heC7deLA2JF0W4UcSwtg3Wm3cwycB7Koe1f1shk5Zku9l/l3Yo/qlPssUIPPs2kzeAtnfNkeATOg7TPof63E6SmPN0I2y3R7TxjYFqJs/FOScQ3yaJvJVcJIoMziP/+H66n5wzhlTRqG/cuju3BaN4OwdXUem2WSWmG5C/8Td3127Z7jYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AyDFYLThb3UjJuDd/4bmYV44RUbnmngo5PrJcOiYfSU=;
 b=QZdLNXGGANX8AH4a/exdPnY1S454LvhAiArV+PTw+z0cCNJcu6aj1NKJ1k1hi9y1uxcUlMyOmIxdvDxgPY5ObR2M49bapDWT1LMfXDp4kA51I1su64zQFnyVjvibiMYtMu4tNKQim8XwSDCn8Wo9rR58NgTNpkdvNkljlAP3Uviu9hBfXcH39x4vEu+lrCLx9wloIos1MQx5tu6AnyPoY3bLsMZiYH0Xa1HxofWoMCsTb5hu31J2cTvhLIGuUjWxWeNfa4sDaxCuAijddJafwYPjnuBTS7oB9lHD4kCmykF3PfuDV24rrd88Rg4usM4YZITVX4KDpYuHqBmZrK2URg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyDFYLThb3UjJuDd/4bmYV44RUbnmngo5PrJcOiYfSU=;
 b=u/O95IN9Ihm5NygwU+Xdtj1KnA7+CFm7q5B9cNKKtyhcSG0rzx01J/GIB8nhUXQba5Idwan4mn5Gn93cNWRZ9puC7GlIKuP+BezHID9vlf8Fxr2F3oQnGFQTKwt6KX+jr990xR1KmM3Mb9azdZFs4Ep2ZSnNOFMDCwyntX46c0c=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB5323.namprd10.prod.outlook.com (2603:10b6:610:c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 17:51:45 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%7]) with mapi id 15.20.4457.025; Wed, 1 Sep 2021
 17:51:45 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] namei: fix use-after-free and adjust calling conventions
Date:   Wed,  1 Sep 2021 10:51:40 -0700
Message-Id: <20210901175144.121048-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::23) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (148.87.23.10) by SJ0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:a03:33a::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Wed, 1 Sep 2021 17:51:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b987858-22a6-48a0-ae70-08d96d7129f2
X-MS-TrafficTypeDiagnostic: CH0PR10MB5323:
X-Microsoft-Antispam-PRVS: <CH0PR10MB53235637FD589FDDA38AE5F3DBCD9@CH0PR10MB5323.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sczssF58XH9808OyNuHSHi8ZMKZlgn8Zd//GImpyKEbQ3Ydzr+Jwt8FXZuqR?=
 =?us-ascii?Q?s5uUQBC67dECcn6VG4yDXHyBX0HFNIy7RnHC/OGyv1Wyu0MMowRpYUxR+RnB?=
 =?us-ascii?Q?ycMyPEmTX3AuzkuiVYvu8hjCImqgTWo2bhOi7z0lVfEbyyZr3JZZfJA1DRlh?=
 =?us-ascii?Q?Do5jP7kMtVtFt+JkQ6ZAwyTpaEVd/ThECUk6XThqDMTIEORda+UE0rM3DRWa?=
 =?us-ascii?Q?Dr9zl0d2KofPpBrRL5TjNG1T1aOzy0s7BgQrXoJMDH0rt0dezd5/6fdve9Ap?=
 =?us-ascii?Q?O188INNgH2oj9vvZcSu7KUFIyn/VQ/2FDTgiNgpUTUas4ko3VDAfwXwT98tv?=
 =?us-ascii?Q?FUfd3CrCLaQMhM2ngepSmk+qwumHjPivS3PHOoi8anNXx/NDkGoSzCwLg6U1?=
 =?us-ascii?Q?LQYnQ18Y6Rki3e4ifTN5VT3+5hfQopMUdUpumt95I8ccTXWelvvCZBkIDyud?=
 =?us-ascii?Q?MaP2MG1TThZkMFszN1ahzRno6+8tnoDRHpEpARuh0qBWtnOFKSebU3ol+mhI?=
 =?us-ascii?Q?EhWIXfuz4Szr4RNe3fDsfE31QvRgaE901jxatmCY+5VNJEO5bRsBbKhwdnZO?=
 =?us-ascii?Q?RqIEzCxEY0fRPt9MdGGEeEyROfXtYEa+2llf8xpsDy3mGuB5UM7ewWsy7tdb?=
 =?us-ascii?Q?UDJui2Ne+10IlKIFs7Qe02AEaBNey/LKuHobYN2FOF5pXSl6m7lPyAAwNfHG?=
 =?us-ascii?Q?NXceew+11m7geJl/z5MJUNiyGzOBhotQA0TJi4DHhP6AZrVBWDZzKptRAjMl?=
 =?us-ascii?Q?W+dAQwuC7CGyWVdAIw3ZaGcG+oTPGccZxP/U1upCPzl630Ndw4bTMnvBBlHU?=
 =?us-ascii?Q?nomIsqTBzYxN2MjzLTQlkKr7s39FFq+HMk+bFcuSSOzv+9GYS3x3WwG6gXcx?=
 =?us-ascii?Q?EtLDfMYZx6ZxEOdlzv7QCcw+CZJIZMkoYxVsTHEaa0LxTp+ze/fcmNPyR05m?=
 =?us-ascii?Q?r5G0k1gaMl0NAymryeWkKuO0FvpeijcLlOklD7Awi0rOmlw0lZ0/FmQus48G?=
 =?us-ascii?Q?Z5dc94sCKqvMAN3Njy9TDn3GIaNo69LVT4b7E552Q60qi+A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(136003)(39860400002)(366004)(346002)(376002)(396003)(1076003)(2616005)(956004)(38350700002)(86362001)(316002)(8936002)(186003)(36756003)(38100700002)(8676002)(52116002)(5660300002)(6486002)(2906002)(83380400001)(6496006)(6666004)(103116003)(66946007)(66556008)(66476007)(6916009)(478600001)(26005)(4326008)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s/3x00ScdIYdrfZ+zPx1jjeRhTAleY87zx0LXa5ea1uwjOwgK4PiyZ6tcQAz?=
 =?us-ascii?Q?6wZaj8V7usD+Ak/JJONYZhDKkrWli4aDtL3PmhdzCVgc/Dp2QjVzqPxUDMd3?=
 =?us-ascii?Q?vEOxISCBpnbwp9KtljCI8XbO93oaYs9F+P8C3xVJmxUJ3a6CIro+rVssJ3HL?=
 =?us-ascii?Q?GRQsKtjvQCPbuerU6vS1CfH+5pHIxWu2TZS1pvp4d9PWvWApbAFa5Y5aU9aR?=
 =?us-ascii?Q?lI69ReL2FDJxc0YgW42fRbIQrMsgOnOo8iGyM9LJ+PAhMCmqIcz8Mtxuq1vN?=
 =?us-ascii?Q?RitZBT/pEPa+oNdA79TDFOJoOYn8BrGj3h/CPOBWKTin6HgH74PG8T/Gs4Fh?=
 =?us-ascii?Q?ry0ckpVE5Pf2MvJEMn13VMJjSn5lg8sa1zkZ2F0lJo75sEeAz03lIrRZrlMI?=
 =?us-ascii?Q?/Q+1oDQFrAWWK5XcXLTFA6bQjts2UsEWll6IXeu4rzLhqV+g/4xpIWI5CS10?=
 =?us-ascii?Q?iV8LStu9Qs9IOD8X91xbjQRd1/Wwk60Npv3mcRYxc5Wx1H6xfn6/zCsKYPw6?=
 =?us-ascii?Q?UQEXtssx1DurgNKET2+gfhVJMuL9587vAb2rEveV0g8NmUyDbPD5RrYPrksR?=
 =?us-ascii?Q?7luZBMjyYAu5oKFFhwGn3mFChDI4qeYP2WiXs3lK+nUge+Ju2tfDnSjQtYSZ?=
 =?us-ascii?Q?TI55ZSAylCUHkpmuZBVfZaeGO30ZLqbwhSFscwq4U2NbWHUFwvC0bZdlPVXb?=
 =?us-ascii?Q?POQ5fu6kSSKs3X5Nc+R4+UiDUF3g4hREvnanFsBSQm2wpPXbM8NMzVESa3pC?=
 =?us-ascii?Q?7KpFP6EtwvCBlQC7IIapdg6MsouhOpcaQbiKikpskQu8BMsF56Mch+G8VpZ6?=
 =?us-ascii?Q?Y87tXU6OQ/iprEsKhnSJk8QzRTHaUYVGM0Wt+yo0p/vNhA44aQuFr0MnJRhC?=
 =?us-ascii?Q?M9eSu1dv13RUpZY1whJfLxgypx8QHf8dpv0dCmb3vCInQ+5DleVM2iSg54hZ?=
 =?us-ascii?Q?dz4ytbusoWHl0BvS9FeMfmBBymoxwPEoKPS+jUGRkne1h4At+Y6mIlF83XCZ?=
 =?us-ascii?Q?16qGlLi6eGqJAjBUTLhlRacFgMhuKHjKnvUa6G26cauhjglSBqMmGCzsYFgm?=
 =?us-ascii?Q?UW1EiDjZRSGC7n+AK3qSKV+6ft2Ym2gokaz+ScuD+P69OMrF+r6J5Js+OgzT?=
 =?us-ascii?Q?LhPLTYJqqfNEodNT23gBU0nswYaNiQtStEPZ47zfBtcQRcdasuPYB0oIlSLI?=
 =?us-ascii?Q?cDe5sdAHjYk4cyJfteZ+DxCVDG69+nEU87a120AxSLcLYKHTq5kEVl40T9Ty?=
 =?us-ascii?Q?Ve9PHwSbnF0LhVjaP7gPAxRgZrkLB5x8L6wjcqpO3F2KV5syHNv1l4vQzAXP?=
 =?us-ascii?Q?OAOxLq5opdPVzWRWcI+CesHx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b987858-22a6-48a0-ae70-08d96d7129f2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 17:51:45.4278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCTuQaGvo3LjzSMowt6mTYs2a8eFec9DBDuNjEOHp2UoFmx67KElqpkB+mD0nTVnXjj5vAnGNbYhIeuT52hLjEn9ybuJspT8dT9kXOnvOTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5323
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=708 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109010102
X-Proofpoint-GUID: wMi7hjVMEPlxsg7YUs2gKatEjvbGom5Q
X-Proofpoint-ORIG-GUID: wMi7hjVMEPlxsg7YUs2gKatEjvbGom5Q
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Drawing from the comments on the last two patches from me and Dmitry,
the concensus is that __filename_parentat() is inherently buggy, and
should be removed. But there's some nice consistency to the way that
the other functions (filename_create, filename_lookup) are named which
would get broken.

I looked at the callers of filename_create and filename_lookup. All are
small functions which are trivial to modify to include a putname(). It
seems to me that adding a few more lines to these functions is a good
traedoff for better clarity on lifetimes (as it's uncommon for functions
to drop references to their parameters) and better consistency.

This small series combines the UAF fix from me, and the removal of
__filename_parentat() from Dmitry as patch 1. Then I standardize
filename_create() and filename_lookup() and their callers.

Stephen Brennan (3):
  namei: Fix use after free in kern_path_locked
  namei: Standardize callers of filename_lookup()
  namei: Standardize callers of filename_create()

 fs/fs_parser.c |   1 -
 fs/namei.c     | 126 ++++++++++++++++++++++++++-----------------------
 2 files changed, 66 insertions(+), 61 deletions(-)

-- 
2.30.2

