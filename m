Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADFE6F5E68
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjECSpc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjECSpK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:45:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2EF868B;
        Wed,  3 May 2023 11:44:05 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HpE0o003856;
        Wed, 3 May 2023 18:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=4DYb5f4tfGMfn/L//pFMHs/h/jLe1B1NA9TqsvJerZI=;
 b=oSz20PMsOGTOgfl8CLBizYxBG8/Jc7DyAHlmt0PbyF4Wo1GcMjZ41zkwX+0Vv/P5Q1cO
 juZyOX+aHjWBcC3FpDnXzWTjRr3M5zn1sW47JkRgepFCWsvLkONI+yrzB3lc2du4cQ4K
 7uA4n0exMnRKRElj1ic/CTrnl8SM8gfcPaagilwi8AVQKW+agKSOtP8yfdeNC0sAtVha
 Rd3FOm65ATGheE4vkrD57YrMZQOfwIKlvIEFspn0MZsEVu4icRxJiK5aaLYdBylOKHGZ
 Ps/eGJF7RZEZFUJGqcAnZdoqXLG4yrpYOMNHdObo8KRgYGRrqqyRxQnPQH8xqYUoY7V2 FA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9d07ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343HXUgr027022;
        Wed, 3 May 2023 18:39:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spdscfj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeBzmUxZcisHFXcDhrYcQ9oQpVqret+L8MHTWX6Ovp05lsAN+Ovr5YN2puW7nYUiSH+eQ3NkRbxxU8QSajEW+qqbOq8wz33hEO0zat97FfYJhgxBVZ1rIF9C8hDKJ67XKIobjWz/nDkRNywchD5kmrHjzALBox54zDVdrI+Gt6uOl9rIcc4zLS1EnU2BZfbpgAlJoMf/qKvRIxfTwMb7jrGlUA4iMn8Sbv2xjtdBjGT1OzvBbJgWYeweYT14wI0Mnmgs8tRJ3FlJrJ43tv0Nx8U3GyzKNtTxql/nPvKkU7VUfVZXQIcPAJL8t6vT0K7qYGzN1FU7ACFGfkRFYNqQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DYb5f4tfGMfn/L//pFMHs/h/jLe1B1NA9TqsvJerZI=;
 b=NHvPcUySNqnXVQh0wk5KzmmwQTwX/KEK6SCeeRIVJCbRhF8JV+iT/+h1htd62JvuO4GMg2e3DAr2pVdNYk2SHIAqXhgtg/OMjsgPMHdIGoRfrHYCdYqe2C4nDZpbnwkO4L4JOwJmPgaxS7Zw9JQnVQd+rr7pJV5u/NDd3gCkgLf5oqvbj+2aKpRO7DGUbk6wzzWvBVgEYHYYYWvhH3AGbMXQQIetOX4xZ9EO/61zW1gKnimHf3FPYVlVqr3E6mHxKRixBmSjeaxyxVcjju76WlZcb3RrTkhYuKfsPd5Cnd/ZboZA4SrGp5xFBB7QPmIGGnWVEE60dPeX5iNiNZA5Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DYb5f4tfGMfn/L//pFMHs/h/jLe1B1NA9TqsvJerZI=;
 b=iXYN+sGd9ZrG4SKYOD8UCcM4vknKdbmLtBdCbCDz2zSxoSTaLHA+S4NOnM/4IOvNktbu9XVzM7zH3uLhMOTNjUco0p/6mGceG9bV9vd5gHdtNFqBDjgC8zPS0ctJdbu+xNjJ8UVkpkThvCClTB8xTPz2z3RN1MJVDj0Qluj5L5c=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6171.namprd10.prod.outlook.com (2603:10b6:208:3a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 18:39:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 18:39:33 +0000
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
        Prasad Singamsetty <prasad.singamsetty@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 04/16] fs: Add RWF_ATOMIC and IOCB_ATOMIC flags for atomic write support
Date:   Wed,  3 May 2023 18:38:09 +0000
Message-Id: <20230503183821.1473305-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503183821.1473305-1-john.g.garry@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR06CA0031.namprd06.prod.outlook.com
 (2603:10b6:5:120::44) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: be985954-fff4-4aa4-4b8a-08db4c05bcfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f2p3GElFhzlzkAXc/lG/jY3F1+9W2o0JlFVOdeHYKF+eXyrtm66YUrIIvUOShZdJR5sFZ2SmaJSB1fnks8qQ/vmlxS2aFFXv/YU2iO7+mFmGAhhRU5s2XWNlLIEKsaWNWgVlovhrH0jS5swKrSXeSzp1kUIK1dAgbJxgx9TVvkKUPOMGd/CGXjZHiCpVbM/qzPgMFB/Qb20u4yOvKfvkLxyHZg6JfdGKaQzFGtEtUoqQ1vZ1fyZfbTSjyvKvECCThX2qSFyBVHnFMC99dIbIoDx2CmWRD0l5huNj0CTO+zxssMhFEsVmYXAvd/cdVNUu2VGIgbBqNdDp/ZqdF9oUrkZSjNNU3pD9T/hO2xgXa0L5esWuO5bkUgr25Py7FbM75lN8S3M0TuJwercbVVIzdfVobPXoW3sl2rHT48IHgD0a2uScAQTPwTnogU0FYe+fJ/AuTlCnwnMUmuh3rCVmYCZwxCNE0A4gswfF4tPqIXznSBBvk0IG/h8BSvDiCjARw4bwejkM1xOMPn5xh9PtYV1m3uMK7dLxbftZbSp+nkD8CKsCNad176IF5OQ2EAIbciso1PdUDTc/K3xgCQIE34dcfHDmCXURWgkFm5E9Qz4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(2616005)(186003)(4326008)(103116003)(921005)(36756003)(38100700002)(83380400001)(66556008)(7416002)(66476007)(86362001)(41300700001)(8676002)(2906002)(107886003)(54906003)(5660300002)(6666004)(478600001)(8936002)(6486002)(6506007)(316002)(26005)(6512007)(1076003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5j7PKchICnuvK0ligDia+eqkpzmpBWRmj52fHS4k1LPg/3p9ja7OwhyUF5ZA?=
 =?us-ascii?Q?xAV+XWIo6Nrm5xTYD1YaCzDSDyzJb+i6oNfLeISjDogSJ0ex+ILXLksdtOFl?=
 =?us-ascii?Q?NfqiquxG+C6wtOpfM1VkAn9XuGVWrsoJY0XhZZUFDB3EgbBUNmFy85n8MJs4?=
 =?us-ascii?Q?P4KdpoVhV59PImhDk3f89hZpmtDDVD7IQrfzTb8RLIbmjvC0s1Sxnlefa0Vg?=
 =?us-ascii?Q?T10zv0uwyU732FVNj/HK796ghL0yqLz530fGmFfJfR7qt+ftSl0EmvAcvNBt?=
 =?us-ascii?Q?N9c8J+hc7nsUco6vGqmINjYt6Zo5D2rWDxFnCL+/Y0Zsy/vi0TvCwukDT3WI?=
 =?us-ascii?Q?Nbxvv9knepSYZ+h/CetOfxGNaepXKESj/j2iA+SCMDn6Cx63T+7Dz4b/pk/s?=
 =?us-ascii?Q?235/HWTvc6SmTg8JyQlMa4tugqOKmDHq/BGv8U5/HhGFTa/RQLo8jArtRtiT?=
 =?us-ascii?Q?zSA1E9gA9OkMKbcxIlvVLaEdRB+aa9SFIufMEMPVUm/Jk+6i4KfAFFmc5c5h?=
 =?us-ascii?Q?BCr0IcNDLE7ZcVlv6wbm4xMktJeOy12FRTAXWh8FoDhqj0Wm0Yuwk+6eSdQB?=
 =?us-ascii?Q?skbdX1MCkFRqGPiKZ7Hav0QPHyYsL4Z5r8h/wsQ0tbyBjsyQiRhwvSOek9Tq?=
 =?us-ascii?Q?YxJ59CJATzKHblt7hF1YxDsAYI3OkoLCGTfqt91ITTz3OOZiI1gyzlQzU46s?=
 =?us-ascii?Q?WB5PRE8uO8iwGsBjTYRsY+uBCzPvrIhJQ1lYj5HOkjjRZo7G1pDSErSXIHMU?=
 =?us-ascii?Q?r1ICc8T1+Is/fzJkUMQ4pd1nEevCD3qblt2xjp3sjDMJSQLy+kCj3+hgsKMX?=
 =?us-ascii?Q?Br6u4f930Riw1m8GPUvHJbDImt4Yd8oiuZ2LElVS8j2uyRZJB/r2NO1a130U?=
 =?us-ascii?Q?AWNS516XwhOWZ3SgmHrOAIaU23RfuuqGlAHZPRtGd3Vp4karIKXiQvrZyyjH?=
 =?us-ascii?Q?Vly7i7SlcTKc09yqkdOgV5XvnwQFT8urr0YeiFK6pgDZQt9GbogrjKD1wV53?=
 =?us-ascii?Q?ZU+dlaOhg8Gmibk3ReeJYySxZt+gm3Jf88LoCjeR6034aJY5li9yqHeNuIc+?=
 =?us-ascii?Q?JvmV9R0Fc8j7Y1RoTuOOtzJWcTcbIrVdZiCkPaVcOIKbRNKnp8Do0aL6i4Gc?=
 =?us-ascii?Q?/8dA0fH46Rxg+PGjaAB/dwObVdk7fGDRqkWpysO7v+E/2qctd3Yv0nOfZz4R?=
 =?us-ascii?Q?3P7/jg565BYkJhiZZTNWcRcIx1Y7rbdSbu1LV8GgMMvZGfMePUoYvM/6BvL+?=
 =?us-ascii?Q?3PBvrENnCJR7hfXJjO1MQuw1IT6CM5ZHw3eH+jkzCXY0w8cDnIIkqU5rNiRq?=
 =?us-ascii?Q?6qgUf340S0AQISgxbH51aTz63FEtTpi96LynEmFQqbPql7dmDK3rgLbGYOAe?=
 =?us-ascii?Q?jxjjE2EhLsl9ZKSfayvd8IrlK+/UIkJGhj4wLKmyCFKjfHK2fYyEQ+97zCFE?=
 =?us-ascii?Q?G36FEipB5tkw3+e/DNgs1N0nvYUAQuCqtPWa4mRzN5ldIJwyOG4XCHfPoldN?=
 =?us-ascii?Q?r0Yth2Y0ZXSLruoWjbY79B+G7KuRWGw6A9s/rvAtmv5Hytr7+VVWNg+R/y22?=
 =?us-ascii?Q?FKoexMatg827yKQ5mPFhBIznLH88MHqjJbK4PGZVhH2pji29x8CYVsfNIZXb?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?C/E2k09CFw9iJMU4fGdexw/cmqyN5G56wbgHT9H0WAJ1HPcABTkvhkTPfA5I?=
 =?us-ascii?Q?LlaeO2uInm/sJVqm5Tx9eXHB/Lj/71V+GiQS4kXWBpy6RUqMd+cXbUaY4NQE?=
 =?us-ascii?Q?VqdXlzJCO6SxkMJdVpAomXLDTU2Li3SQ8Sa1NwEVLImO6iIfc29dtc0nnAL+?=
 =?us-ascii?Q?fJsfqbfqK5BLqrZQZPdANiBRLYusqrLkpNABsOby+nc3bsSx2szv2qoGqgPr?=
 =?us-ascii?Q?Aqu38n4eMpjCF3iD5FY2ETkY4ZcZjaZ+WWoIlM59Ua+HLTqt3Urv/oVQaUmY?=
 =?us-ascii?Q?g3nADZtTd29EPUkCvhBNpmK41tgTC76hA2m/dDcZQJmsQn64dDJebVuaZHQz?=
 =?us-ascii?Q?XeYhgSfbm/FyTA/zYZOBMeL9VZ4MrJ9+8zCXg13sdZcf2LlvmmBTUTa309Gk?=
 =?us-ascii?Q?i2W6fnuHW2VZ8tiaW/5s2Ve1nD+8DTuFx+cXaFuhUGp9q27hgPOVXBIoHPcO?=
 =?us-ascii?Q?rsML9ydXRDmKOMblDGrFS6vfrBg9V3qbAhC2+rnsqT38gCC+cRYeT2v55Tu8?=
 =?us-ascii?Q?6yj8p5Y2NQAR1Bq7O5fp3/GxXnXrV2UNX0Q+ab7YDvqtPKbhZLDY+mkShRwP?=
 =?us-ascii?Q?kpKME83J850JdYKxQ4vhbFXjGwQYZTB36b/fQVudn6hUW4y2/HND8Z3DBNz1?=
 =?us-ascii?Q?eR1rTd6DJPo/KC9xKOVf/4mc4Cf/6v7biFAbeuGO6ifvuvD3JHKLOXnibg53?=
 =?us-ascii?Q?hhe6EROi/rczujtpk1Csz4qX14Bu7EJsx5rdedBcRLleVOeLDlNNRuVWGJhf?=
 =?us-ascii?Q?4xJpinjHv/FPOKBMQiiFxF61GNrbaUj/+9wqdVU0Lua20fixNMGfFhFBRmmW?=
 =?us-ascii?Q?G3tlqh16Oh5zD1Zm7qzZWqxmDupB0+PKOa5IedlgW9fxJbvhN32UcPgZqz3t?=
 =?us-ascii?Q?mpBxngNE5oKFx1Pes6BEz3mIb4oG/uuF6wBTWonuZ61hX/579/tOURDDg2tp?=
 =?us-ascii?Q?qlV2qNI1hlWl4wL8TN+gjqgypG2DATc6dnKM/0MYml4xdfPaUBY+B1xHKOAj?=
 =?us-ascii?Q?0XO2ZtUeGZvH5IKoUW+sLv1tpF7nTso6S7b0ZITDK8625+juOxPN5+cya+dL?=
 =?us-ascii?Q?1C4q1lcJuxXKrD475q3/Q4xIr6BQe4fX8YoZ70/dL/s1dlYs5CcEDzwmUAGM?=
 =?us-ascii?Q?4e+jMROw0GfW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be985954-fff4-4aa4-4b8a-08db4c05bcfd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:39:33.3991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCHkaZgSZZeV54ASjledjUovjpeCs32Cl9+YR+g8aHz+95YjwRNdtTxmMGC9ck65No/HPNwLvDCnfKEC66MjqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_13,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030160
X-Proofpoint-GUID: foCq1xZxgWAl753UefztYKakycNPUUAJ
X-Proofpoint-ORIG-GUID: foCq1xZxgWAl753UefztYKakycNPUUAJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Prasad Singamsetty <prasad.singamsetty@oracle.com>

Userspace may add flag RWF_ATOMIC to pwritev2() to indicate that the
write is to be issued atomically, according to special alignment and
length rules.

For any syscall interface utilizing struct iocb, add IOCB_ATOMIC for
iocb->ki_flags field to indicate the same.

A call to statx will give the relevant atomic write info:
- atomic_write_unit_min
- atomic_write_unit_max

Both values are a power-of-2.

Applications can avail of atomic write feature by ensuring that its data
blocks are a power-of-2 in size and also sized between
atomic_write_unit_min and atomic_write_unit_max, inclusive. Applications
must ensure that data blocks are naturally aligned also. If these rules
are followed then the kernel will guarantee to write each data block
atomically.

Not following these rules mean that there is no guarantee that data
will be written atomically.

Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/fs.h            | 1 +
 include/uapi/linux/fs.h       | 5 ++++-
 tools/include/uapi/linux/fs.h | 5 ++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c85916e9f7db..5bace817c041 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -329,6 +329,7 @@ enum rw_hint {
 #define IOCB_SYNC		(__force int) RWF_SYNC
 #define IOCB_NOWAIT		(__force int) RWF_NOWAIT
 #define IOCB_APPEND		(__force int) RWF_APPEND
+#define IOCB_ATOMIC		(__force int) RWF_ATOMIC
 
 /* non-RWF related bits - start at 16 */
 #define IOCB_EVENTFD		(1 << 16)
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index b7b56871029c..e3b4f5bc6860 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -301,8 +301,11 @@ typedef int __bitwise __kernel_rwf_t;
 /* per-IO O_APPEND */
 #define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
 
+/* Atomic Write */
+#define RWF_ATOMIC	((__force __kernel_rwf_t)0x00000020)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND)
+			 RWF_APPEND | RWF_ATOMIC)
 
 #endif /* _UAPI_LINUX_FS_H */
diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index b7b56871029c..e3b4f5bc6860 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -301,8 +301,11 @@ typedef int __bitwise __kernel_rwf_t;
 /* per-IO O_APPEND */
 #define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
 
+/* Atomic Write */
+#define RWF_ATOMIC	((__force __kernel_rwf_t)0x00000020)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND)
+			 RWF_APPEND | RWF_ATOMIC)
 
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.31.1

