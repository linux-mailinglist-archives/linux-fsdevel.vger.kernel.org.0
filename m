Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A7B40BC3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 01:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbhINXdx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 19:33:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4872 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235947AbhINXds (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 19:33:48 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EKxO5Z017546;
        Tue, 14 Sep 2021 23:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=80MAg8L66JzOnOeDAvbnTS0pCogozFh2GEI3z+1X84E=;
 b=ydABs0LKRDLIKWdMB75Dm3RJRLyLYxd7iKbr6Fq5i7aRpOjuW7WQgwt6Q3SIQ6XYodm3
 WcjrbauJI12kdTQY9dUIi75mw0DCt9eWuiHpIxswENpM1YZ5q+RlRhE6/pE2PxJwLG/C
 yAsOpYQ/1H4yILzDdNFvM44kyyCx+RanGQ+JyTVlGSkfuL21lYaQ5UR8awc8LMIuy/yg
 yb1edIWLId0TNMxomK1kMVqBod6ti1cj5K/FhtTI0x2cCCRB3r6We7tXnkcSkry71FNE
 7xbP18fRzt4kTIR8ZnGtfImUtaNT/O0LK4OCJuE07vpU1pPaRpFVtgBdPZkTh2CK6jMU OA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=80MAg8L66JzOnOeDAvbnTS0pCogozFh2GEI3z+1X84E=;
 b=dsPzYAskcFA98FjoOPvOQsSP2H1i6XlRKJ8kZ94cZqrJyc4kOP1xl8czceNiXS8ktLpl
 tkbrwO9VrSmNmlqQQ76ozqJ15M1/rtUY1KiRd2ok7M+q0J94SEG7TWBTFvDv7n6LZmD+
 5vCnJCSB2Ws3jOBCQVHlSCybsqbJfm0otGyIKRFeBqCxz7L+bh+g+yuJ+sRyb13/x1/m
 RTYsCJTq/RpGSWcDGhjNFZJcbv90Za8QguvXiDFlekXImeCVnqjd6dtb7K6u++6MDsgs
 46ZXC+ADDiA+WRQ0OrBOwMJWfdB6aEUz9WURzq7LvS9IrdSEOLK3NkswLpuO+5TKzb79 VQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p8tb5hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 23:31:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ENUh5G075975;
        Tue, 14 Sep 2021 23:31:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3020.oracle.com with ESMTP id 3b0m970nqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 23:31:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QghBUs2QiEGqzYNf0bCTXrkY/mlAR1dW/6h4dJSBf9JigVJz3GKmxVZjIkPl5iaMMqLmuJB7lnv4v9DElVixu8YNz3NscPgcO1cqbwr2ZJrn+pULyjxNZBA7y2QMKVi8Gu5hWyCxhkng0ERC7/w2/gkFo4c7tHVkQj/pj8fuamrPKZipj26belL0LULtKG0CSg6DMuXoR9KXsx8dqWxhEPLjvVOuHTKiWqMtCmPhJOt+q6VxuNVKT3X8KVytz54xEgEAMJJm4Ck9BO4+Lohiy0mmRInZ2EKGUOpOqKyidn8+wZRD/1+PIH70ccPdd14sepARTbxLlY07GXzsqT8zaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=80MAg8L66JzOnOeDAvbnTS0pCogozFh2GEI3z+1X84E=;
 b=jalqvvxAciVmC34LT7DKj4oieMhDDpuoXB7KqtO6bbkqP3Iw9zmGw/Lf8HAJMV1WH3OtNpX/VGblRFTTpfxzfEMk8kPsRQ2KT7y4Myr9q/JH9+dA2Vu5JextKWAjO5JLr3h5Ta7O1uvCNE4YkBpVkCF7ZfDaglgCUAMDzbZTD6ioaOfOmpRzS6svx3vICZpGm6avwcUZBgLD9KIgaNS1mBZO5qCqfG31H04A9BCuKqDoLGLD7ImV5iA8kCF1s84jZYQDCknpFb30aZo9vzxhtBeYCi/FiLA29bSOl0ivW5p70tNx7WiO3S3CzlULVd53LoWwWX7BlNYi3/G1f2LQDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80MAg8L66JzOnOeDAvbnTS0pCogozFh2GEI3z+1X84E=;
 b=OZloXd/gd1WRW2GPx3uzvorjFjKjg/VFha0xzVx0w10g7bf5n2HNspmoucnuVO50rgfED0UI+ewY4Z5a94ApRFGD05BKE8MxHYS3UHU+YGxWFiUx9BWNZEgAgqBILoXXqpdsSK1wDU//J7zVoGOev2t/8Juky9AbXPoPWrX9DTo=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BY5PR10MB4035.namprd10.prod.outlook.com (2603:10b6:a03:1f8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 23:31:52 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%5]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 23:31:52 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, viro@zeniv.linux.org.uk,
        willy@infradead.org, jack@suse.cz, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/3] dax: clear poison on the fly along pwrite
Date:   Tue, 14 Sep 2021 17:31:28 -0600
Message-Id: <20210914233132.3680546-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0601CA0008.namprd06.prod.outlook.com
 (2603:10b6:803:2f::18) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
Received: from brm-x62-16.us.oracle.com (2606:b400:8004:44::1b) by SN4PR0601CA0008.namprd06.prod.outlook.com (2603:10b6:803:2f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend Transport; Tue, 14 Sep 2021 23:31:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22ee5114-2327-409f-7051-08d977d7d506
X-MS-TrafficTypeDiagnostic: BY5PR10MB4035:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4035737202E06004F570C06AF3DA9@BY5PR10MB4035.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KWiNMoHTBVP0LgNerEviq6uif9Z6onHAKP4QqHllEPPm3KtpYgk6DrgORLjAphlzBndnvLuDetRFsK6knfvhe7VVcIMuee+Hlntbh+KXkzSt2ctpA8SOwNnb/Op4iIEEllzHHS6FuZX64EObQVfOA10RjjwC73EEU27wpMeIpaBXuWAtDibxhECewoPa9EjYcJirSMnLf1QnVk4znrH/6mRRHja8DHXMdmijdIf7kgUCzX09rFsrlrej3cRPwBUr92zU52GN/Wc9Y6Bif6Pq0QWku9REKF0/zNrodUVEmEPqsc08z8IMceOmfLFQSoKaxWynOm/5F+HxrHTp9UwlSOUPKGHJWv8sGUyKeZ2RWCVNkExtkWmJgQEmVjeQa6waL6eQCo2YY+7xZtbeda3gerYfyve707KThD8imTVd57mvD1en4c3Bl1O6SIFQqFq6R6P6nTcrPMXzTkezukSSrDVvTRe5eNOROgYithRZOJiPaJWapLfX8P/VZ+ETapXNJjuevHzwFPcugNIy4kkE+Ci5In7YPQa90axAF2I/sBwXpnvAJr0A3QtczzIHRzzeNazhGSkEQazNaz74x1QYmOiLLhge6+ZR5ljQAecVPUlvFhR+yc4nA+FpBDojBJl2Un2D7UnkpvgdWbkwKOj2TKFIab5n1eNQCWDEw2i+wxE9ebMOsWnBLI0WiPgZWDzk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(136003)(39850400004)(346002)(66946007)(66476007)(921005)(1076003)(7416002)(66556008)(52116002)(7696005)(36756003)(316002)(5660300002)(186003)(8676002)(38100700002)(8936002)(2906002)(83380400001)(2616005)(6666004)(44832011)(478600001)(4744005)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wnlmcZJ7ZFkrYhCnNdRlUf8OcfEMhvFGPTaV0Jc6zF7K3gNFhW2Bv95+L2jO?=
 =?us-ascii?Q?wD4WTQVO8WpL225e0ZMboPYVuHM5MJv9Iy9LZzh0iGPVdXa5DkgkpJCw0ec+?=
 =?us-ascii?Q?zCUp56E4QrtArCT3kChUEWDFBwIYFEDHtC0t3teE3pU09dzlBxZV3oHc3VJ5?=
 =?us-ascii?Q?l92/VugMSAXXW6KVLLRxAIQKPNLXQ824yW8ESnYIgeSBhtqYNi5Mm3SPGfMk?=
 =?us-ascii?Q?g+pmud5CWOwSGp+3zTMmhnE2bOdUaBDdhvjnVC2rTmKJ3nJhpM4swLDDFv9m?=
 =?us-ascii?Q?wwPaLauXt2VMu6lY2WqE5stvmqILGS2iFfmmySPDsHDOkoXdV+GWW01wzyJO?=
 =?us-ascii?Q?mCqk5tekU6T7Sitzs5EFGYIiTaXZOBdXfLKBB0Oikf4pZvCWbhKRw/vHmB2J?=
 =?us-ascii?Q?OeuScLjJYktR9AOB6oSxyqC49mmULMCJyYArwBLaoAXrB7tvNp3gQ5xwuPeN?=
 =?us-ascii?Q?WqiyyQGbz2/p1WPvcRkmXoDbPRTcGnHfh2LtkKYvQ1bHExtpmD5pfk8ulM3Y?=
 =?us-ascii?Q?GNlRzhv3IJxa8TG29wesfLBVmrjAi04dbSbeSTBRlvgc3qFnzqJHt038HFYe?=
 =?us-ascii?Q?wQzN+v2EcKaxlz7ulF00fth4pOIkNmCt4DyRpbcTQW8oV9Q7cj1vvEK7GYdh?=
 =?us-ascii?Q?RFd31K49ujpEuJncrrdrG2wSkikACKBqfvjHkOaSFRoQhXZi/NavFL/g/dg8?=
 =?us-ascii?Q?f9EE1WhsWqQN3s7J7XDYGaq4tMFK8Yb5NNnff7AE7zN81jSivmlB6aWH8dBR?=
 =?us-ascii?Q?vbyzd2Klb1J+iaMaCI89kLm8rIqhbibGPbyjd8GBXBpxaeHFTAwJv6Jya6MD?=
 =?us-ascii?Q?FsmdHscBstY2QAP+wybHRDF6yt7p4F23rNmoEbDYdG+MUnYq3DC8d++Vk7zu?=
 =?us-ascii?Q?ieZmWt6eJpZXKzZT3ZN7pQPoQSP2w3fc7XpMvbclO/VwvzeyrFuw2ACW8Jxx?=
 =?us-ascii?Q?i1IMgUDJLgYxTBoHnkrV6ATFM48b2JFSe1hv1tZ5dBlqB8JTSmWcihvPapz9?=
 =?us-ascii?Q?sDoHlDrB9cM99SSglRrIP7OyLHqq6+qiQObcM9lEGcHz1Q15cQEB5VnyG+ts?=
 =?us-ascii?Q?Sa9CNH5jqWze6BdaC3u3OjtyK6EheSzCFaVsXeb1PjAOFT+qZfMB69czFvTI?=
 =?us-ascii?Q?YKYrrvW+/mHo+PagfrZNhjOgSLJdgn5RQWQzDyujC/n8r9pwzHYe21HxD1vi?=
 =?us-ascii?Q?huzOolPJfu9IsCmDvlA5qsatnnEHaPg/GIVmNP4y3T2kyR1EVAvvJu4l7EGM?=
 =?us-ascii?Q?lV6+tYeJsS7Gxrnegk+ks4sI3QsLcMFVL5zdyaMQvyovQOGlYD/XU0CBXStM?=
 =?us-ascii?Q?ez019J+dC/3R0oRejXahoPKBaMEXGlicRTKnKrfFS7R7+w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ee5114-2327-409f-7051-08d977d7d506
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 23:31:52.7170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdkX3hkbU/qlByG4/QGwp7kpFUpNt/rjmkjSw6D7Yw8ySPNSATBZ8/XfMFSWpZiOqPbslFIq0DVDWgfaqyBlBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4035
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140134
X-Proofpoint-GUID: YEQ1b0TxBYjfL_zVfTXUs2z9-RHv9yI4
X-Proofpoint-ORIG-GUID: YEQ1b0TxBYjfL_zVfTXUs2z9-RHv9yI4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If pwrite(2) encounters poison in a pmem range, it fails with EIO.
This is unecessary if hardware is capable of clearing the poison.

Though not all dax backend hardware has the capability of clearing
poison on the fly, but dax backed by Intel DCPMEM has such capability,
and it's desirable to, first, speed up repairing by means of it;
second, maintain backend continuity instead of fragmenting it in
search for clean blocks.

Jane Chu (3):
  dax: introduce dax_operation dax_clear_poison
  dax: introduce dax_clear_poison to dax pwrite operation
  libnvdimm/pmem: Provide pmem_dax_clear_poison for dax operation

 drivers/dax/super.c   | 13 +++++++++++++
 drivers/nvdimm/pmem.c | 17 +++++++++++++++++
 fs/dax.c              |  9 +++++++++
 include/linux/dax.h   |  6 ++++++
 4 files changed, 45 insertions(+)

-- 
2.18.4

