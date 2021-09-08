Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5784031BA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 02:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245758AbhIHAFX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 20:05:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49494 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231519AbhIHAFW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 20:05:22 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187LTZC6015703;
        Wed, 8 Sep 2021 00:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=rzov53mwiODfMJX82QFfdIgX3qtcV7VLVotfGSfXnno=;
 b=t6Is/8MzS5EFUFXZSfqKH3RcpFHFopyBChja/VIdZQ4fK8nVTTqxcmFJ1wr6CHU5ON6x
 TRhOttgdlqZ4wnE1OXdVmkIPxTImfKimIk+LPApgMGGmIngyasQrXAsZvLraR0QmENMF
 yRk2RYrjHmoYeJNdb8+Z+b9pwjZgQrqIoVkKHEkcnlKWK+ri8B7ury9aBrHjQNcVX4TC
 qcFDJvSVYI0CLfJUyr89jRNQMqS07KeKnEpM/L+OW3aubvTOcCvGv8mBXBC0U/GLwSpq
 dG3QhVa8dCcTbFfst3ODgWNZxpil1dDFrGWhj3QuCxXbgeGJ6cLIe8jM4006QGOB+cnL pw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=rzov53mwiODfMJX82QFfdIgX3qtcV7VLVotfGSfXnno=;
 b=ZDVRb1CZ38j0+OB3LTxKLlBbn4uuvdtNwRuavsQtvFzIcDcEC2eWe+bVsC5AN+CLiM/T
 yvNQofCj5ywFus1OhHaV3II24/3ekTwHaIWR7rIcu/eBI+fzUjKoXrogVWrrgNSVqGfT
 P3Xk4yr5q9/JwcCewduO8fj5y/q98te3BEVz3kPn/uGqJgCMwzaZyJURpt9TRoLBQ3sx
 3pi31kMqTuSFlG49n7EUw4zbBlYyt/ZXy10E4Ov7cUAcm6JVR1I3yjR2hy5p2oM13bJw
 chVoFJdZyin2lVFKhoN6WcjILMAecPsy0btX3AOz0GI6sy/XMYQgkt5kqykP9jvw2Dsk ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcuq8t6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 00:04:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18800ngB029240;
        Wed, 8 Sep 2021 00:04:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by userp3030.oracle.com with ESMTP id 3axcq0g278-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 00:04:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpbKKM8kgRJmUdtGBtaA4lEvJ0cBsAucSzpTFCy6s005vxDv9JH7TiTEouaqQ9qM2UakV8ZuyPHupwmXz5EBSqnIvipxbDyn/jskVvgCiuT/kPEZ9WmHdkuMvOpwy01pgSksYIjRpXqnCdy4YMjgyKd9YJan9b9clsOV9GDj+/mOfd9RYLGxztgNF/EDrUF2yZGNZlbnwVCNxnwLYLyNANH/PJGxXhyS4epi8Z/S+gIrDXFIMbFH1ameZ8p/hukWEphS2mYyo6isA/s5l0tjA06+pdD70FU98pYePb0pRJiO2KY7VSioR1eFnK1SGnkfkOVR12GyKDv2pE3+e1JmFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rzov53mwiODfMJX82QFfdIgX3qtcV7VLVotfGSfXnno=;
 b=KoBtCSoTNFeECFPy1lUv5PGpb5CxlF3djwTYkRAuegYRkcG8naiKKJH9QVKI5jIm4dHeU6X7nqhuP+0AYWvn2vNb7FflYwA9b4AkfasS8EalQIdH6t8W5/lUsBpYZLd7dH/defwXduS9bGG7/VP2PIAOg52lo1jC90QW1/1Pten8f74fMZdJi1ZJn8QCtXY3FX/6UNYge7SpcgjqrowpSA0S3z1marqvy70YY9ClM7bPGLLd99O8+ZTDvoAXaU8BPG6VZlbiP8c5FKzGWsLDSWw4G1I0sEwchcfrXFgQNZjEprxgxE4tnwaf3oYz77eBi1lBBP31ara35i7iw3Rn1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzov53mwiODfMJX82QFfdIgX3qtcV7VLVotfGSfXnno=;
 b=cSjmRCXWpEJJtnkdX0FpGO3kWJ+ID3Kw154xo2u189PNdixXmgZDr2k44PcP4NVYGwZUerOF2pMg7BgrbA8/STgmUBfn7Au1q2yUHPCPsea55i2QXUwAoOwH4VdeyshYoCe9AigX0KyXHqC1BrKHRg/evzIhUdn6I0LnQYfkpYk=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB5147.namprd10.prod.outlook.com (2603:10b6:610:c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 00:04:11 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%9]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 00:04:11 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH v3 0/4] namei: fix use-after-free and adjust calling conventions
Date:   Tue,  7 Sep 2021 17:04:09 -0700
Message-Id: <20210908000413.42264-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0018.namprd04.prod.outlook.com
 (2603:10b6:803:21::28) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
Received: from localhost (148.87.23.7) by SN4PR0401CA0018.namprd04.prod.outlook.com (2603:10b6:803:21::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 00:04:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57055d9d-d997-40cb-6c31-08d9725c2fb9
X-MS-TrafficTypeDiagnostic: CH0PR10MB5147:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5147858321D1B4F0601D27F4DBD49@CH0PR10MB5147.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BuHnwIFZQ7D1hjkq+vHvNYkaK8tUYvufTVRQJRctTqpSNzaHhzlcg/Ye3sma?=
 =?us-ascii?Q?B3t/JqFy7B4hCVPFRQHchcrfoZBgnPVbiMq5FSRSvJIVys7mqvpQg3dWxMF2?=
 =?us-ascii?Q?YIx+Zf2z2R0JvJObFqn0LOhg8982YPwtfKGob0adLsSevvM2RADK+x6/ZxLn?=
 =?us-ascii?Q?x3EzJ2VvjafwVBo0Ku+hvpY09tp7euGz/njCtl+TEvITyNAes4S+joGXhnzv?=
 =?us-ascii?Q?kpEUegbHABHFmzG7p5C1YeFWMIhNcd9Q/dfcPlPizCpv+in8mef6RBpapTGu?=
 =?us-ascii?Q?fPm5iQR/cd/5Sslzg5HQgLjV6t7pu/li4Joa0WHaCMqjvefOTgOxS+cR2utp?=
 =?us-ascii?Q?kwtb+uM+UZjAkB1c4tcDxwS7XhZh8lIo45oFHsveCD3QA4Vg/w9i9MrUbf+S?=
 =?us-ascii?Q?EbfsMkewc5ZW8ala5AhatwLjFfnRPkjOUeoZDrxcsdBZbN2cLJnK7xKZWL0T?=
 =?us-ascii?Q?DBssXccJrLGCUknM0eR2k5ZYA1QXX7qP0VlMY39i7N299cWjqK9hSpOAeLLe?=
 =?us-ascii?Q?dd5UoW7ctvdOBU4mEuMreAd+MfewnRtre/SsL63iptM6sKuij7I4X8Yj1LMo?=
 =?us-ascii?Q?M0Snb+zdDKR6UqVOpKYrsiOYep3mjwoWnqHpwYy2eT8xSJF8rKPa6W/8jhGV?=
 =?us-ascii?Q?k1LUCKmA4yXuY38jAfHfwIoFCdeHFj54560yeyWfy3e8KEQDnljinqKgT0AS?=
 =?us-ascii?Q?my5gJ0ucXmIWVrCkW10OjAqG38l3p8jCGBTVQ5Go7C8qxhn3zbVseA0yTPzC?=
 =?us-ascii?Q?tqeLu7x1CdD2+Eghhd7siiev2ZIys7BYhuz5HQzuyoCvmi4sCfAHoBzVgyVI?=
 =?us-ascii?Q?hpDP0POMlcwMTt6rlnvr+PCaHEnDJNJeWO1NsXQTUSRnSbNclrOPlBjqDJrJ?=
 =?us-ascii?Q?frXMF4VUzOPz9wRqsrno80YNzrrJI1ukOvLpTD8+JztwHUDyuK53LcoIATQg?=
 =?us-ascii?Q?CYsPR9LCsFrMXlu86akqd/XiFca9MARojSQKZXHwq1ry5q0fSEjMv4ENkVTK?=
 =?us-ascii?Q?eOkGOY0SfY33RJmRE9QQLtyhCkJFURzIMu8VpppZzllPGTQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(136003)(396003)(346002)(376002)(366004)(39860400002)(8676002)(2906002)(8936002)(103116003)(478600001)(66476007)(52116002)(107886003)(956004)(316002)(66556008)(38350700002)(38100700002)(36756003)(6486002)(6496006)(86362001)(2616005)(1076003)(26005)(4326008)(6916009)(186003)(83380400001)(5660300002)(66946007)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bsqCAodkny92Zqk6CvTFin3OI6ogKbxmpS3/I0DqQty8midT8eaFuLPEcy/k?=
 =?us-ascii?Q?337Fc1nx7QoYJWsspX732D0BaiqJduzDTOhnMSmQ2EMqbWIzzL2Ll12CEvCy?=
 =?us-ascii?Q?Fri1vsE0vSgHAdUOqbI28EUYQ9RRcOIB+xHjgrEmVOY7H6RAFxfSt49vaJ8S?=
 =?us-ascii?Q?5+ZyW+OnqHVTciPWWOxC3CbFn/Q1iIwDrShLoVGsnNAEeCxGHagZwPcEw3Zc?=
 =?us-ascii?Q?jxdjQ3I8b/h457pPFThLQ2UdcS0Wvy5voD4XZui3e9FdwN2xRmWyH+EJMQQF?=
 =?us-ascii?Q?ZGuq6FTZG1tf8wpSuU09odHo+qE86WrqjEnwsWdwfU8cLZnNz6HjhKZYZY4s?=
 =?us-ascii?Q?AY+gJjnQXGFSzyRYpUlgz81H7Xky26oBLdH1bpAZmDh6WbfxfllgCmTOLwUN?=
 =?us-ascii?Q?JTvvlAY1r5JYbpncftbZ+5wjIF3xtVUCpq/BCQafa/jcG9PDiYhpoC/D/2mO?=
 =?us-ascii?Q?Jou0NCNE29iP/Cb6vQ+/mJt67jXtzl8TGzqBGwP8X8x/sJW54n8HRzDIwcaF?=
 =?us-ascii?Q?MB2n2bvhPeHMA/uW/WJl66Oucn2Zo3F/CtnaFIidXYxz8LKSv+g2ViWvn6Qq?=
 =?us-ascii?Q?23oku/E6UjFOzFeZ7tniyv/jFcYx2EiGyYEmEfgvEBpLlm+T1GnZeLiTdm7r?=
 =?us-ascii?Q?Kz1CopbMrvdStlbhEN138M2DkBvj08JACdaw4lHF59WGd5KiNvXf2GvaJgyT?=
 =?us-ascii?Q?P7orQw+6y0GJgd/v2QZU4kRoXNIg3fjpCTyZNRViswfTWMJMqI8nJ/Qx9f4B?=
 =?us-ascii?Q?YUmUl7xcWo4WYw4X7G9xyeUxLaq+uffnBxs08Jx6omY5uVhsyUUHZ9GCq/Wp?=
 =?us-ascii?Q?ugwEPPm9vdIxSwKsmNnAj4eOUVcug8YacQU0lyR9VA5aKZSn0DxRcahzU71H?=
 =?us-ascii?Q?ak5vxuSfVbzPNtlzlQMAynblGfHTAcknrXSVSGvZGDs4opYMcdcUJnS6sI89?=
 =?us-ascii?Q?/86LzLvDVwt06VnFiIwieMo9Rx4JCsL2CH+AoGCEFUTIevu+4CDLpmu9iBZ1?=
 =?us-ascii?Q?safgKxTAdu5TP4KKiyrarnvQbopa5DK5rMmLd/K7YyN6vM+j/pCHzHG3Ou+g?=
 =?us-ascii?Q?EXrYYAhX7mxZI8F1I0hoewjM+46vHDmOjq+BzM89AWlZeqHrj57yeY+m2GYH?=
 =?us-ascii?Q?S1r4QPg4yQYQzT1uXjP2uyf3gu9JALMb3L5MG6EDGY5RZrkNiBqTTFgDW0/O?=
 =?us-ascii?Q?afztSSjQsZ9MD8J2RSHKQOTI5EqWR1T+FUuwg5cHCHYSiC08+s9ltjsoG36u?=
 =?us-ascii?Q?P5yV3bT7CRAdb2IDQxHQOdWL8ZtHtfnlyRVKGRcbVM8IvPy4bmI3Mu8J6fsF?=
 =?us-ascii?Q?o1A68IPec2COKc7W/kW1OZUn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57055d9d-d997-40cb-6c31-08d9725c2fb9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 00:04:11.4686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYYa3+KQr5brmJUPOvROvQWayX1HqMcoQjcWjPPzZufYl5vjKi2PxgklN1WizjWellXtEstaFVf8G7Wwn7KnbOvciWJCPL66C5YF2crywWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5147
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=903
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070152
X-Proofpoint-ORIG-GUID: ogW6ScaEbD7Ep6faQ2785J3eGIG3wITH
X-Proofpoint-GUID: ogW6ScaEbD7Ep6faQ2785J3eGIG3wITH
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently filename_parentat() is inherently buggy, and results in a
use after free bug. But removing it and renaming __filename_parentat()
destroys its symmetry with the other functions:

   __filename_create   filename_create()
   __filename_lookup   filename_lookup()

The ones with leading double-underscores do not free their struct
filename arguments, while the ones without double-underscores always do.

I looked at the callers of filename_create and filename_lookup. All are
small functions which are trivial to modify to include a putname(). It
seems to me that adding a few more lines to these functions is a good
traedoff for better clarity on lifetimes (as it's uncommon for functions
to drop references to their parameters) and better consistency.

This small series fixes the UAF and makes it so all three families of
functions have just one variation, which does *not* free its pathname
arguments.

v3: Split patch 1 into a fix and a rename
v2: Fix double getname in user_path_create()

Stephen Brennan (4):
  namei: Fix use after free in kern_path_locked
  namei: Rename __filename_parentat()
  namei: Standardize callers of filename_lookup()
  namei: Standardize callers of filename_create()

 fs/fs_parser.c |   1 -
 fs/namei.c     | 125 ++++++++++++++++++++++++++-----------------------
 2 files changed, 67 insertions(+), 59 deletions(-)

-- 
2.30.2

