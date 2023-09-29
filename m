Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936B87B3045
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjI2KaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjI2K3d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:29:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605D8CD0;
        Fri, 29 Sep 2023 03:29:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T1C5Xk018309;
        Fri, 29 Sep 2023 10:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=9b6c13tAVvtzoHZgCJ6dVum0FdVhaxRpl1nF8MNGk0I=;
 b=mI2s4dSQf/pyE/4niR0TSWn72bcyYI69IjURsoVDuj+j2rnbMVfWyOWcdXqAIdWRIhNK
 wq/hs2/l+rToJSMOKYkPz6A02pjMphUxR+KLr/cNziF4HaHZ6PWwmlnl+mHRITpTJVWR
 UlGUVjxH8m9IKv8nD7QAdm7C72KDNm764qv80NBOI9OAVN4mNOF2FPxXftU+eCM1tc5T
 aPBKUYyUIvuDDQJHWxuEtAuWzwoAQ5WoCv6wzCIGjTC+AA8QEpHainxri8sSVOoWeY1R
 UW7uRK2xlgFgzxz17iEPEtAQLHzcXKQwjsiXkEAuih4II0u7U6/litcMAhjESPZoawxH dA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qmupe0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T9iSOL015821;
        Fri, 29 Sep 2023 10:28:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfh4vtc-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izS1bUDazAXyv51Cka9AF+2hs5rZrWqu/hwYB4TUFwdPrJ5rffkGr0yLb5QwziDqer0E06DUHvJUHd9dM8mwFSokiTTSRpxfoW4DKo8hlc8xqLWPF37Wg68nnPjnxHY2LHImIZZgZp4V/BOHsI1ZBnS1i2w+ddy/td9no+Dh805bFw3AA6TbrTfBA3dS/O51WRsnPsvH1fogK7T8M8tVcZS1db3UDSntnkf31ddBPb/GdC8gWZFv0TJXQ0II8KxafFpT2sXqcBLuSiH7O1cTD4AlM7O9UixNY89MeHFASq/TweuIzB+ov2TJpClwjhDqj9/E6cB/KqPl7bNVIv1XxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9b6c13tAVvtzoHZgCJ6dVum0FdVhaxRpl1nF8MNGk0I=;
 b=iTDkk9WmNL0bwBrFCsTzqoUfuglnFTmgCodtvJTUiTMFub00Hz6SfJbm9x1AtJ6O1aJUPwpGv4A4pGD39XTcm4a9eJaeTHwdVR0+/9FhautImObeFqX8hWOrAdug3XTUsXckpX2Ofrn5/+kmJ1Sh/Yj5CtxPGqijr1H3q4o8vUsX/SJNfQi1uw5Xiflw3AhVmqgEtLp8LEjkIjeokLduMZwkh4kkRWRL55HDcCl4J+ynRiwSLtCPd+Rx3bLUWVu9XpJ8vJjclBQ70z7nxY/Ii14RZ20tSFK5uE5n8v6Gsjzssg/ZcuC/3AyoEKP8ec6gwEX9AY4R8Og+65hMu1GLfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b6c13tAVvtzoHZgCJ6dVum0FdVhaxRpl1nF8MNGk0I=;
 b=UyRDeGhe0q0/83XHac4FZpPcJKU2TtUabgNxh6QK7JT9UfHpVy6yqjpIqlLoQnOSlqT68G2ccJR00gigTqH/UfAgbjwY47C0hq3bk+aJch3ksWtPVSkRHmeErRExhygwEy4nEGO+iPueK9ERGXJjdKxzoChxYtC0a94SwNsX1DM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:28:34 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:28:34 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 17/21] fs: xfs: iomap atomic write support
Date:   Fri, 29 Sep 2023 10:27:22 +0000
Message-Id: <20230929102726.2985188-18-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:208:160::47) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: d8497fe7-4294-4c72-a6ad-08dbc0d6d569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKy9qvKGSWBDCNx4BarVUvpD9SzsjuA7RjZSMOA7sXI2dcx+hepyOxq0K+hrO4YrRBqFhoB2ISIEJL5+oOvD0QY3+1NYRK1PtnGLMA8xo6fahWSZjzsi7PhwzNCZTSNeTU3ZWQxJ2+lxAK0kyt5QNJVfrOdge2R8+llzbImFz0lHe0nhKi0ZZJK/pI6tXsViKatcqaQBeQo1bpiuQ0txIY9SNML31cz+RbI+86u9TMVdJ34yvY6fEhe3v1y6eDVbFA8cqwI7VhebaTjW9cA9A02xJVyeD+FNzHjPGNaxxlpVZ8StPs23As3w85NMawuC85tRR3TORfvuek3jLo1j/A+k7ZBZ3UBGMi8hVmwxCYn/suzpoi8PDZvBNKara+2J4aN6Tu5VcdUhT82eX2XOLN+6f20v1JyxRO8pS7yiNKiGXyY5X8s3FFR4AACvj3NowGPW07OqTju3OYDOHPbKKsD6i7vhXQLuf50aVqjo70RRQbCZL3hPEuUO3ax7xeY+W425NkDwwvaZ9HmKfj7USrz/hF2dGejmRYzXAq+fQQbPO/Vy+Aa1i+OYGyJnybYb6VqaXXQNCq+s4t/Ew47XBga/fge/w+79M4354DxkTKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(6512007)(921005)(107886003)(1076003)(26005)(2616005)(8936002)(4326008)(36756003)(103116003)(66556008)(7416002)(2906002)(5660300002)(41300700001)(66946007)(86362001)(316002)(8676002)(66476007)(6666004)(478600001)(38100700002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y8Ze9QeWGFkIJU4JlDjmSCRv86n52LqQOCBgjJv3Efrok5GZZJWBdilcRXT6?=
 =?us-ascii?Q?TJyL86I4qYXnAo+ubSsf1uMu9Mc7VpmC71AM78AoCGkEiAIqvvG/eQzaxFzx?=
 =?us-ascii?Q?86OZPxsru9RYU3+d3rdx7TXw0rRVoXI9XMoGFrn0VVr/gcA2Wba1VIQumcKq?=
 =?us-ascii?Q?vK7EkRQkLrottCHD57LNagZ9ijchZVevA8tHqVuMlRMGK1hQt782DO7Y2huJ?=
 =?us-ascii?Q?4ZVK7lsMQ1SJBFZTYu1cwxtAZgKkbrsxTZKsxiwW8OX8xoAmgh5akz6bGEMV?=
 =?us-ascii?Q?H3FKAhmJz6nUnU5P99rhEHGbIoJ5rMnrpf0wiijxdQO66DLzPigMfnsnCwRJ?=
 =?us-ascii?Q?lVQozkpSuJ0iZ8oBN/K8FOivev4zQ24k3tn/rawGJTCOuayklD12goZT9jFM?=
 =?us-ascii?Q?SmYqpROoMouCG//nM+YY09dBSgLJIs+ajg+oyuUR8JP6AWBEn0eNvnznu39Z?=
 =?us-ascii?Q?ZXVIQsicCsRZxj+MgLEGk6EyNDtG9Ov9ykumowRWvn1IwmmlU4zLPwoflUY9?=
 =?us-ascii?Q?MMCyKcl4VZNJGD6uh+r3hV8CRs6+BgZkjJGDDHPMWC1pRE/bXowdZbbXNQNS?=
 =?us-ascii?Q?tjWd+qB0gbkGKvInWpBKocVBty5OmFYhr1w3Q2Rtb0+n7Lfl0HPp3qTNeWlg?=
 =?us-ascii?Q?+jmbgTJ8A0it0/S/LzuMhIQGcu10vovIO0TPu5UrwQHOASg0gHmOe3lYp75k?=
 =?us-ascii?Q?ZEaHoAFxSm/LlzR2aFzS3xenhvEEiiFnXfcfzRamOV1Cl0tZlppc60dDNOHr?=
 =?us-ascii?Q?2TQcim72iurJmjPPSe+KXmQasxUdlKCrJe4FrHVWfcyPRvvBPewYoYZH7G5P?=
 =?us-ascii?Q?Tm7MRk8EVYZvxHcMqzFeID1LooJGczGrz2Wyqmjd0b2NiXae2/BvLSD9QT7j?=
 =?us-ascii?Q?F5ei67GYt9RTxHRX754r8KceQ/yeSlJd7/n9kjzQwFZiDKa859NHlAMtHcIK?=
 =?us-ascii?Q?9Zgbfmdu4aMZkZ+8sEzsFCgWeSiUo0M9kVXy0BrkTfwodQR5vSmefRiEOHJf?=
 =?us-ascii?Q?CrcNZuxxgjGWT1DF8qYZd3Pv2efnkq5P6xw59IUmzGaBw1WQBxdNdmFg4106?=
 =?us-ascii?Q?7dqNDqKBdCb2I9Pey7WFQOKCftT21/uwo2s2DINHx64QPYerHma9StPTjLS2?=
 =?us-ascii?Q?UtUsFMPRNvZeB8sUKZ2MkbQpZrnKQHcYsTvl8hy39Q+T5hMeAxSRnKltYknT?=
 =?us-ascii?Q?hUAihTVBm/gEvRgw221DnraQJQHAG1DTr5oCxlHCsvT4mJW0mqUcb8ag14Q/?=
 =?us-ascii?Q?aah3Zh6moQsmbhWJmN3+oS/LMjk8sx2e4ppcYdW6/ksfiU48bJ4HGUd00qcP?=
 =?us-ascii?Q?s8STgtH9VCUs9dy6PI4IsgP/YkssST9xoe6D/SsEvwBlpTJZeTdX21TPTxC8?=
 =?us-ascii?Q?M2rie9cIPgStJGFe8V/hwoW3vYUH3pcMianrQH+NhdHPV8aW2MulCeXYKuyC?=
 =?us-ascii?Q?gK8bzaffvI8pljDGfOKjPejh+DzUZ9wJr8pW42bOegC1ppAe5wUoH2YVqkwe?=
 =?us-ascii?Q?aOXBGX12VU1UOHdGJGx7p64Ad8Jk1EZnlONm2QEnLEVf+e59+OplJ4RcPH5y?=
 =?us-ascii?Q?/jBadqPv4uSAA5JOIJ+7IClRlcqnLxGMUzHHV2Jm4hdjZ+KqGFSBgE2dsejL?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?TpIdIMvPJKn3oF4RDxjWFhAcvNTxRG82iR2Bso7tmmIbt/iS1supHRa0OzR6?=
 =?us-ascii?Q?J/GCTqDFUfTDmYb5ebPW8Fp8s5fWtXzBJVDL19jwTJmtWDKHH0LZ8t7LLoQt?=
 =?us-ascii?Q?YBfsRPTYl7yo3v5f7AWl1QbCZ28R1Rk4CQAlsmMi2RO7WAt65NGYovkfYRBf?=
 =?us-ascii?Q?WgI/hpYKXkdEC3HgmBJfwE+lMPJDH/rMTux2p80rYEiKN6wdlFpa96cl3VMv?=
 =?us-ascii?Q?qN876BXEGSvwek+Xbkg7BK3UxdHyAtHMIaQTaN/JCgROPf/1fwiO07kC7bRr?=
 =?us-ascii?Q?3gnkixpHHKJV9igdNzugrD4FY+gLUGWvz/4Lak1ibMfPqz8cBZzcFs/t1wZ8?=
 =?us-ascii?Q?K+/4iN9tU6dNHvbHHsqDTdG27Om99pMQbs1bMHsbJlrmKBpEJiCCgiSz400l?=
 =?us-ascii?Q?ft1cbh6KT3uTmE/5+dL3gwQGegjLXTouICpd/dXNmQXI909HcEpAGpBdOXSI?=
 =?us-ascii?Q?FTybAFAeAaUy+cIXoRnMeUVEntHoJV9zb5MMHlwuSxcg2hcQ7U8bIrFO7VZs?=
 =?us-ascii?Q?9Xycp8YJrMISYXH5dtKwV21Geo82wTZax2ukjFGYf49rimd5idA23K51tCKS?=
 =?us-ascii?Q?np5u1FneG/IP6f031EZsl6Fo51OTbIOQKj7ch0OUKUbdariguQEeCJxMQS+p?=
 =?us-ascii?Q?imT4P6+CeJWk3M81euc6eWwHA7/mfh59xxoDPFE8jwU//0XWZT3FE6efuxU5?=
 =?us-ascii?Q?GPrN7R111G2Ry4ESIjKvacRXAs3lObvg70BBjsx7IaEExNmVFa4ySQ0m9DMz?=
 =?us-ascii?Q?WGExD7P6/Y0u2aT4QMpPKrQ/Fi2oPwrWeXxUFnNGhbaq9Xijj7xhgRX95UXQ?=
 =?us-ascii?Q?RbrX0blakCdtTZLJNcRCoaatx/mdKwoSNEdAoqz+woo0bMeQKpR5vLxW6nQe?=
 =?us-ascii?Q?/1P519lPtE0FbOQ/CGXfMUn38ighOAM9me40GpJG7r035oXnFx1dQ1x/+3QM?=
 =?us-ascii?Q?PmrKlPkOmATDbUjNOiv/kJKn91/4phS/KTrLuXdwef+0A4T5A9PQpeq2e1VI?=
 =?us-ascii?Q?tIES7VHMnZH/FuWzGlHVJmzooR9VaOujYtWEyKQ76KVE0WHdGM0pu9MprCB6?=
 =?us-ascii?Q?mWYElKjiGY+GoJbhp3eFIurYdsUjkQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8497fe7-4294-4c72-a6ad-08dbc0d6d569
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:28:34.0346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esquxsa4veJJfdniqEOXoAaSAXtbupiu8ukks5j5MnAobazRj3tKwthK3q2swuPJFfkC6zwY0f1u4KE7MsKWpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290090
X-Proofpoint-GUID: NrC-vvlxbzBnVYD5evesSzlbbMJJVpsS
X-Proofpoint-ORIG-GUID: NrC-vvlxbzBnVYD5evesSzlbbMJJVpsS
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ensure that when creating a mapping that we adhere to all the atomic
write rules.

We check that the mapping covers the complete range of the write to ensure
that we'll be just creating a single mapping.

Currently minimum granularity is the FS block size, but it should be
possibly to support lower in future.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iomap.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 70fe873951f3..3424fcfc04f5 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -783,6 +783,7 @@ xfs_direct_write_iomap_begin(
 {
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_sb		*m_sb = &mp->m_sb;
 	struct xfs_bmbt_irec	imap, cmap;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
@@ -814,6 +815,41 @@ xfs_direct_write_iomap_begin(
 	if (error)
 		goto out_unlock;
 
+	if (flags & IOMAP_ATOMIC_WRITE) {
+		xfs_filblks_t unit_min_fsb, unit_max_fsb;
+
+		xfs_ip_atomic_write_attr(ip, &unit_min_fsb, &unit_max_fsb);
+
+		if (!imap_spans_range(&imap, offset_fsb, end_fsb)) {
+			error = -EIO;
+			goto out_unlock;
+		}
+
+		if (offset % m_sb->sb_blocksize ||
+		    length % m_sb->sb_blocksize) {
+			error = -EIO;
+			goto out_unlock;
+		}
+
+		if (imap.br_blockcount == unit_min_fsb ||
+		    imap.br_blockcount == unit_max_fsb) {
+			/* min and max must be a power-of-2 */
+		} else if (imap.br_blockcount < unit_min_fsb ||
+			   imap.br_blockcount > unit_max_fsb) {
+			error = -EIO;
+			goto out_unlock;
+		} else if (!is_power_of_2(imap.br_blockcount)) {
+			error = -EIO;
+			goto out_unlock;
+		}
+
+		if (imap.br_startoff &&
+		    imap.br_startoff % imap.br_blockcount) {
+			error =  -EIO;
+			goto out_unlock;
+		}
+	}
+
 	if (imap_needs_cow(ip, flags, &imap, nimaps)) {
 		error = -EAGAIN;
 		if (flags & IOMAP_NOWAIT)
-- 
2.31.1

