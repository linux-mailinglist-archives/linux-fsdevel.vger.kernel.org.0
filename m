Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA87F6F5E26
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjECSkf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjECSk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:40:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C43C7693;
        Wed,  3 May 2023 11:40:14 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HpiBi015206;
        Wed, 3 May 2023 18:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=JD8hDPJ5N3T9bs5alGxEwJJ3mTs1CCPcdSsiBHkOmXo=;
 b=usIYbrPJbpCO9YdkaJukaG4dhB5S3aI+ws7mWwGLAUNaEQ8tc+utGSmyAKntZi+ZT5Cr
 TUWmEsK7tE6VkFMHaeWJQPpqgl3sVCyilj5QWHH2VA8OPTEcZUohGA6Fn6iMk5PtZWlG
 ZLY4J/uh+sLXfcnzMffij1fzNWJpX+3t6uylxhZa92uOTxOoieMp2OeXTdWE/6jwd+Be
 21Vu7OEMtYLX8yC3wFJJOmlOt6F5G5xW8+Oh4Ns86bEz6yuS3/0Xl1thcLLmAXa0g5uZ
 /GYqyvjkQnXukRUYaZB18mVcnp+I9NW8bWnhS2ZYlX34Dfsa+Y70EfPrQCJarQlowR/x Yw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t14063p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343IP8PL026971;
        Wed, 3 May 2023 18:39:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spdschs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eks9BUPPSyjIYxlJz/T5Oi6004AsEhajxbVDJTEUQ3aWgXWTVO21dpn0O74ZW0jgVyh9WBz9UbOC+9Tab74OYjFN2rKuto2xD8FqAt4RfS9Nf165ZYzKRHAFqhIZqmFjvAItVWKzSxLxGtFAe0rH2Kn8kKMRqo+wiqAAXV4sKb6QuY60Gxsi1LN2q7/K/i5mGWScMO6fT5NwiZRKSHBeLtk6HvB44A31r1RtX1PkPwSFVg6RE8BYdlrPYnWChmQbsTrwxqANGhU2paiVMu8rq2VWA2FsdNsHOespSAlC3ad3XidQa4mdYFWzAactmgVklcrWCEPFrVnfk/PH0Z3gzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JD8hDPJ5N3T9bs5alGxEwJJ3mTs1CCPcdSsiBHkOmXo=;
 b=RY7T7UbxJc6UkMDr6z1GuETS5gUEcVfEHR3Ovxr4erJ7hiQPpOSF9qzn/3G6UE81QWsDXgVyR0ZdgmHnQ4IgrDvNpXKSAhSw4gRbeh3kKmOA1kBJIPxYOQaoWJhnXmbSkP4+hK4gpnlLC7a4NyjYNUr4vgq/t6mQ3fleH2wAQRw0j753smWMZayfp1PfZEusURZnum0Ko98RtrGXSodZrsytI8k78tXkitGvSR3YJ6UuJbNnH/JZg2LMwoLPZ6I6yjxi5wICDkK3moXo3gd+5uuafILkpoNQzS9YAjgVAYzqge92sBIusnWtuhcTHfBkcZYy+9J8FH0AzJKXal+jgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JD8hDPJ5N3T9bs5alGxEwJJ3mTs1CCPcdSsiBHkOmXo=;
 b=Uw4B707ApRW9cAL13GZ88jyLy1lP86+cxWcqTBrRkMymM6guo+ayCCYdRA+ExZHkY9tp4GlZxmLLwZmBawD5RYWUOaqdLZto9llwPKxEznMblpGnDqPrKy48P52ZttZjcQBzs7HsM7weNprKAJAD+aLmjA8kSlj7mykhrerUBtU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6171.namprd10.prod.outlook.com (2603:10b6:208:3a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 18:39:34 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 18:39:34 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 05/16] block: Add REQ_ATOMIC flag
Date:   Wed,  3 May 2023 18:38:10 +0000
Message-Id: <20230503183821.1473305-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503183821.1473305-1-john.g.garry@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:5:333::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da3b65e-784f-41b9-ee34-08db4c05bdc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VOLOwMw6o9syHDWiwV5piKeQQ6uGaYg0pptleuH/ahMYK2PHkcyJASF6JVV327sVSB6v7q2B2tqWmq7qmmhYQR9yadvbA49zW0AZGkP58GXcyVVsT/Y1+OG6oeYHJ08isJeVDuK0p4vSw5frdqxPy3TSQvMCPS9/Lqp18/OMViy1xeK8lC7fh/j1mveMCk/IrQfzwEiPITdkBwpLegWrwsqZ+gN9kYGBaxR0wWLzTtt+PnoegXw9AR9a1Yq//uazQ5RWfB15gMJZhulVsNJYkVsEOxd+pJCD/BVyc24FVPEcYvPDCTwZMrMryAarkV7uSl0K7/rU71LeI1teY3+W2MyZcaaIRpMgQNyILFxo6IVr+RpqCri5hPI4tCisZUaRZJuKb69m0lDw5kImgQHF5G/dtpjkhEifWskDG31E5rkLdy/9EDaS+Zr0aPcklbFyxhgUSiZGHMMpcHsvBDOfvf/ZpL0iMWJyUGRmA0f5iyeaSKLdF9ApNaZMNIjTkXy+k33HG5dGz4BRZKthOQSIHx4icY9ZBEyyrnTiZc71Cma6a5ozDF+RaglidM/8JcvwWpN7XR8edq0xMuaEqL1ksDlahZU907vHic+95nPkCIY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(2616005)(186003)(4326008)(103116003)(921005)(36756003)(38100700002)(83380400001)(66556008)(7416002)(66476007)(86362001)(41300700001)(8676002)(2906002)(107886003)(54906003)(5660300002)(6666004)(478600001)(8936002)(6486002)(6506007)(316002)(26005)(6512007)(1076003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P2SOJHUSoc7NncY3s5kHAk24mrVYgtWKQ8UiMEmZfHRdJ7GPTKwjPgJ01DHe?=
 =?us-ascii?Q?y/nYNGrPE8xXqEk40z4Lik8CYIhETMDrg8yg+857fSGfz97Jvi2t27EXKsQw?=
 =?us-ascii?Q?A/Le9znagywJifhQmpH0iYK3CBTc7BHdgOkluUpgiftaturYKSQ86+ZiZyKP?=
 =?us-ascii?Q?0Nie3vlJv52xaZCBYmn2DhLUJms4bAD9iRwgOtMqGOjlPEsy2HUv+PjUJnqt?=
 =?us-ascii?Q?lP2o9sMDn8txNz2qMQcQsBYa9pqIbFuKEoSxFMmcPiN9geN5yzSfT9FHUEWu?=
 =?us-ascii?Q?w6V0EoSQ/hLg9fQzpJd9eV1cLGOl4lgbA1X3R+bL5PSH3EOqrDe3iKt52al0?=
 =?us-ascii?Q?URU11TJ+oEfylbLELJtTztqqzlXwZPjo2Jhif8K05C43G+OwZhfS7FSwkXyD?=
 =?us-ascii?Q?g9DKatx2IIqVIH2RRupqu5hjFE8sQXd2XdOrX9EnLLC3vD7WcMMRRvqayPpp?=
 =?us-ascii?Q?yX+wvQ797snZ+6HPrnRkTRJmYfAUZBWp1JSVhGoMpWsvPn9N0nEi00aGuSiF?=
 =?us-ascii?Q?zA/dW0X8mIzms0IDIg9qhLg+URw5STrCuOlCZxqLkn7W9vvGyqWu4727IGGl?=
 =?us-ascii?Q?1QxgtWHp5Upq7yDQMXAtT+029VIwTP7LsuBEHrwqYMvMaeaq0QWPHwNQiipr?=
 =?us-ascii?Q?C8zFyrORHy3Em4OAVGAoQeHqul4dazHugXhCD1jtCd0EHhfoJp68+barWC01?=
 =?us-ascii?Q?MIASfdqPx0rd5cr6vZTIDrL34IffKYTKhmQ0DBFPgxf8ds9SQyVx4pc0VUQ1?=
 =?us-ascii?Q?t8lKGNAa4M5Q2rOlJqq4gLJArmnnAjUCQHX1+SwvpYHN8ce95WjkDqvZI6HE?=
 =?us-ascii?Q?qBjQXCsESD/6Nskb05lMVomnoEHRfEmDGCMi6hiT1LE+1atxOGflkptfkSWd?=
 =?us-ascii?Q?SEZY0oOta41ZTUnyrc3OlfrSbPnDYXSwBeOgabrZnPli2fqrpel5X0psEkY/?=
 =?us-ascii?Q?9hRhfjW3Z4OLUwMjWVIEDC5Q2jfpY9B7dZNgbwCCUM+nAN68T4rNXp7u9peq?=
 =?us-ascii?Q?1VAJJ2OdoGjantiS8aSS7HXMF3dj4crlB9zRoPH77jwunuqnicN7SLrjkMd3?=
 =?us-ascii?Q?HHf57czOulFS5WrywfwvLWQ86sYqH05OEw46U77nTN1WXEoE0frVbKSyN0lR?=
 =?us-ascii?Q?3bDklgvVTOleYrXDz+PLDOeTF3SQBGRAGhJk7s/nNN4sEUbc567HK5RLj3Cw?=
 =?us-ascii?Q?vITAtkMXwgYDaSd4qurf7x1N4/jJRlqPpUhnESGg1GMCp8brZjdtP/2z/VOM?=
 =?us-ascii?Q?7KQk6y8HiPasgFumMmo6cW7WXn/of/7XxTsDMiTWrSz9DXOcESLdmpiuOwOc?=
 =?us-ascii?Q?Mx2VRwg6/9XRm6vgEgJ9Qa5xynh7QM1fvf17OgqvOQGh2WKnDXG+bFFlHqMt?=
 =?us-ascii?Q?By0VTZZqcE16VG4O0+37ABtjiCBJBl4zaIg1tNOjLj6s5giqHg8/eU+TI7Kq?=
 =?us-ascii?Q?JBMcG50hnLMxN27okp8vXzkWn92gqD5CxIyBKJ0L03zVf4p14hmd32vqM280?=
 =?us-ascii?Q?9Sv+Sh2QplTYP4TOVIVDuE925UtqbHZGfNCnD3YJpZAzv8gHFHP6gHVDyaC2?=
 =?us-ascii?Q?DP+Q6UQMMOFHpvTU1ufLZOTlf0W/lAl4JuL1dss5CPwKFavU1WwBC5EaFPkb?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?cLBdjBw0JV45UMy7wJQVOlAhBorqlx/8wjRQHj2e0g4K7RQ4kl2rGhDd+e0I?=
 =?us-ascii?Q?k4bsrTsUBL8ogyhLPEdWQbc64RPmF4KhYWM4Jk1luLnRZRUNCKJflmlzk67N?=
 =?us-ascii?Q?dv5gX7IMqbM1rVdWgHHyWSnSowehtWBgGFBCj3PwEh4Pgf0osLI8XDmpZ6i6?=
 =?us-ascii?Q?1F1My4wayACjoidA7uNTewPGpZJOZk57hNAGRI7jtapHQ4nNaWW0n+C048YB?=
 =?us-ascii?Q?8hrixnKDYRypTGlrOKHW+UfJgXrrc8wtKvpSVcVkQhWr7Qt5nNsfPGr5ePQB?=
 =?us-ascii?Q?n7eQgZO4bwPqX4dR0zAx4T4dCtBsBRAcQ7vv2oGlq33VK72j9PLq26orI7l+?=
 =?us-ascii?Q?wUM8DCg82B7zK8H/DcswClXq2n3TXKLJqQ/OnBBbAwkRWjlJv1tC/lFYzdYJ?=
 =?us-ascii?Q?aXA2r0h3UOySyMCwbRUY7vVzBuJruaKYT0ZbvFyfVHHIR5bogAMYl0At7IN7?=
 =?us-ascii?Q?TvKVRJh5zRmrlxE2IAEThfOuEV+I95Oj/WwDAgoompaWjf8BkKQhaTEY/HDZ?=
 =?us-ascii?Q?EWOIPeAcSDOIvqyJ0VPHntsjvZuyB/pkPpm942fQuuMrNkLos6nzUpS315hd?=
 =?us-ascii?Q?Wsvc6RhSm0CDTYbHUx4wFsQqag3kCef6iOudyHUVgsyKwQPjM/GC+BqPat9z?=
 =?us-ascii?Q?FOnFmmsKWv0aWUBLkfmQsw0rMi5pdqTm0MJHDQMIzQQTf/XubEAT+vt0r+0I?=
 =?us-ascii?Q?2Nax7UDJ/zifQSbkqWt8LLkNJiVTRpBTBP29t+Bm3oi8375hKIy4Q3BAmuUA?=
 =?us-ascii?Q?6Z+xfe3maW79bZdsWERGtF1ldnnrbZW1OKV+raGMEhLzXzYD860h2yEn7cxY?=
 =?us-ascii?Q?kLRhKvP7ZZVImPIe1J0ZotuxyhKP83x7R6i6zxMQWaI8jPi0SByFoo2pJnTN?=
 =?us-ascii?Q?MUY+rLitVmZ+W2tU/C5S720BefMB2lIwD8UNWIX53OS1gkqREI1UVDP8IR5i?=
 =?us-ascii?Q?B/dJbzYbNA3lYKK71mRxqH8Kqj3gJPpREdQySrYAwtrE9G26JMWGW7VBWixB?=
 =?us-ascii?Q?hrs5byt3tvotUxnqqhjYBNZtqtBWOXuO4+u1tZUYldjrll85NyYEns56788c?=
 =?us-ascii?Q?hJQdK+4IkKgyevDvZwRj10Z6IeLr2sPBNGikLf5IDsL2WfsKtiqBB8aVJW4e?=
 =?us-ascii?Q?TAegG0Dqq6ar?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da3b65e-784f-41b9-ee34-08db4c05bdc7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:39:34.7152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AG3T+SVADAE06zQS65hG7BjpRs+fSk4muUft8owmd6MgbTIjUYuEXa73FV6Qsiz0g7DGankoIdbQDXrOjpSPMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_13,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030160
X-Proofpoint-GUID: UNqPpLQl5I0zLaHqhDDJJW4stVOGM4AZ
X-Proofpoint-ORIG-GUID: UNqPpLQl5I0zLaHqhDDJJW4stVOGM4AZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Himanshu Madhani <himanshu.madhani@oracle.com>

Add flag REQ_ATOMIC, meaning an atomic operation. This should only be
used in conjunction with REQ_OP_WRITE.

We will not add a special "request atomic write" operation, as to try to
avoid maintenance effort for an operation which is almost the same as
REQ_OP_WRITE.

This flag was originally proposed by Chris Mason for an atomic writes
proposal some time ago.

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/blk_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 99be590f952f..347b52e00322 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -417,6 +417,7 @@ enum req_flag_bits {
 	__REQ_SWAP,		/* swap I/O */
 	__REQ_DRV,		/* for driver use */
 
+	__REQ_ATOMIC,		/* for atomic write operations */
 	/*
 	 * Command specific flags, keep last:
 	 */
@@ -444,6 +445,7 @@ enum req_flag_bits {
 #define REQ_BACKGROUND	(__force blk_opf_t)(1ULL << __REQ_BACKGROUND)
 #define REQ_NOWAIT	(__force blk_opf_t)(1ULL << __REQ_NOWAIT)
 #define REQ_CGROUP_PUNT	(__force blk_opf_t)(1ULL << __REQ_CGROUP_PUNT)
+#define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
 
 #define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
 #define REQ_POLLED	(__force blk_opf_t)(1ULL << __REQ_POLLED)
-- 
2.31.1

