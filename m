Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836C07B302D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjI2K3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjI2K2t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:28:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB1BCC4;
        Fri, 29 Sep 2023 03:28:32 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9W2n011907;
        Fri, 29 Sep 2023 10:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=2i2V0S+XBJL3ajFOnCrlyIQZGlKfn5xCyW2+UtdJO/s=;
 b=YB6z5pyqQdqBT1qJ8DkVRSm9vokDJ1ykLBhzRxyJI0F629YvOHuh1pzK4UleKUPjC/KA
 jwQM2GjQMNqM6vb74Ffyf+Zrsa52w5PeKkn9tEwBKXc2HDg8QhyQonG/r1NUXniIT6P5
 kbauSR6MVRZbt6F6VL8uxnr3kERhOjz07RpL1mlb0A3YOzKsthBgJI/sIqdov/eKOg8G
 1inc/gnDRREvkHZayYvT5EX9QJNmPtg6PItWWmyG6qkpX1AOJm2nFEmw6Up75gYfjKwF
 6prH/sAOzd0q0JWgeb28K+tFqlzZ7/yxGp2gL9mrb50IU8ygIFx6k00wFolC9m/j9opF dw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pm2ehkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T9UgwH008228;
        Fri, 29 Sep 2023 10:28:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfb83m0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVE80oDK6zHDEPLxgkdS/wobDsuYEY4M1bYVOAYrU5c7xMscb36H8oP9/5/sYPCRQ4h/nlEGWIuXMLoXBMB7t2phjOVuhMmzILrMgA1JOKgE4HQC9qO5uKaBVRLNEwbTMvXpjfLt20d/EiGr+/jBDVddYk1MUDt4R/Kwd3UMx5J4NUMhRxu5W4Y0sh0PT5oWMHOR9EjpN0vctsYsrbURix4f5yvKU65Gy1Vd5R+nPvk4YNgyx1m0pXONX742pXRVCnk0I0Vq9ufJ7LLinQPD0wdA8d79g9R6lVWCkKRo9PyoUyL1llArcyloqXeVWg7UhbzvAGVb4eCePYmJiJ7+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2i2V0S+XBJL3ajFOnCrlyIQZGlKfn5xCyW2+UtdJO/s=;
 b=RBU8m0XnUtac8AOvAwuGw5i9hUZi9NxZuos9xfT7/63jR8Su5OBFLv6jJpqQlvsGCGRjgPtki1y1y4fAa0f18t50ZGvfHTLqLoS6jzZwdLwKEbaMp6d95VLlWKzZMpT/D68ssntnbq13oP6jH7winYgTdKOAykI7eXxy+XAmI79sjaaWjZI4OyxcOOQ2hNV3K0E/zOt2rSepxAQMtPYLBKJdPri6VJSjagIlUYWC4awVK59RKU3/q8Sl5e2POCYmASZy01lE895HnvY7t7GwLkQL1JpW/adkgpZ60IBaXMwiBoAou36cuys/cuZVcHQwJbq5D8Tsgkw8qaA0MyKX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2i2V0S+XBJL3ajFOnCrlyIQZGlKfn5xCyW2+UtdJO/s=;
 b=txF36YSk6mt6PFBDUjdIppjSBnnpPMg529tpyx71ygWWuAA4vXl1q85xNUCGSxfvEv8qFXNTW0IBZPEdcJPJ0D5AaOk4iU+jX64BnOwsAaNrJwwKqps58y52set6eAJ7OmDpeuzWMZdvR0NqOpstlOvUWCI8pMlktjmyUUjhiD4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:28:02 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:28:02 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 03/21] fs/bdev: Add atomic write support info to statx
Date:   Fri, 29 Sep 2023 10:27:08 +0000
Message-Id: <20230929102726.2985188-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: f54e208b-0856-4824-8a7f-08dbc0d6c2ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wQhJ7dIxIGvvz829fuPxtqr4O50LenedPCpZaTNKr4U/szXMYk5oO8OV8V7K6KnfNPKoSLgexPEAdywzDqAteEoBza87KdBIlyThhK6yFhgfUsqY7ICT8O+n/JG1XdD5vF1Q7cFGwFNDMKWuCttLhgsy+alQthJhPfEi7SDcTrnLoFPzaWHsi3tN40nD7XGcd4MybbnFUcGAp34liVhkls/Fc1PRtENWDZmO++0wDqfH7A8WEYyDuiX1Ku2Du8b76DMkHYTT0oFja5Bzv30WQaahBgNlEtg3XwZ1pKmk4VAU06Px91mDP9wkDLLLtncHbqFBV7qWAxHXdJUEcIsWhV0fPi0DdAMzOj98taisXZ3DjSDM22dg0XIX4JT8+/xR7v4hZmwQJ49Zsr70tqwOE0WRz1W9NABTdskkYg5aeR3xKT/t4WqaXBYFs4W7WottXe294yFaRElO2rdLK9yxMg0B2eIIy9SlrJ7PimqLdz1/qFzCldPYblMist7JTCCBGyPUMBVhTcqcebK564rYiaOIFrDJmHbC/DUdf83Xe7xWCb5uoKjR7zf02gFj7k2bqcVFdPHqxhL1bPhwcDty5s8iT3qpDD7dF3zw4ly+7VU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(6512007)(921005)(107886003)(1076003)(26005)(2616005)(8936002)(54906003)(4326008)(36756003)(103116003)(66556008)(7416002)(2906002)(5660300002)(41300700001)(66946007)(86362001)(316002)(8676002)(66476007)(478600001)(38100700002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n11AQedrkOnwmpg7xK9pz2yX3slItIk/kntpVrlP6f0I/uSidMV4RTCSj8OQ?=
 =?us-ascii?Q?4YRJqP9Uglh/w0gylLFuImQzGcmzmMhayx6w3LPmzr70kgNTUhAgy4OxmyBr?=
 =?us-ascii?Q?JhLFvkQjc6kZOczAnNCD7SoJYchjlbx2vRMO/1V6akv/H0utMmG0sZKmNQ9x?=
 =?us-ascii?Q?zNtDuOrUz9py1wS0PdfWc15/1EzVigTyV9C7BFJ2rXSwM7drEyeuHbrXLp7O?=
 =?us-ascii?Q?VTqG5ubqL1hURn1HIg82FZL1e7z7JUb8m/ZVrW86fIm9T7UH21PiNfuywquA?=
 =?us-ascii?Q?qlq7UNjGsetZJxBGgqV9f/TgQTA1ZtymL49DtPq9pLyCT5RXL6XXCfZZbRb2?=
 =?us-ascii?Q?kLmEuUHtPIZ91T2deu+R8rb5x8o/s8Mb1STKVwiauu2urXKI12Yi0ZDLlTE7?=
 =?us-ascii?Q?ybmfDVtrlFiI4yjLFTOm6g7Ah82hJ3F8Unrq1ixMyNsMer1o4ts7gcATqv4T?=
 =?us-ascii?Q?ebOTkq6TBc7jl2opKX7Nw6tr2V11Jzd9sNfB3oKQXodNKtz+S3iO9GEftSv0?=
 =?us-ascii?Q?PLyrVplv/uxQBGl44Es197paCjKo15SuWL/pL74txMaH0Vio7+Sedc93sEzl?=
 =?us-ascii?Q?eMz+qmAa8gonlKyfIsD249XNFPAg3cboLIzMfv6yZCD7XuOqyb7ykErAipj5?=
 =?us-ascii?Q?jLviFMuuvZ0N6v1zUiUay1krhwt7PmPU9yFUSYQaxowPvUVRsDDwYMgFz4UZ?=
 =?us-ascii?Q?9/kCTDIvdpwwtVKfBiRZ3LjoSIK5C6KKrQWHjja0n7R+wK8GQiD+dI3Ns1GC?=
 =?us-ascii?Q?TjXG9ilgF+bV8yto05Ich98Mioil0lmpx9j2+WREkpvUVs8YM8C0TEolH3WX?=
 =?us-ascii?Q?chp9HRYgjOJ6ppKuhMm2yZQb0D6deQqxPVyf2Wk1VEzdvVSlpjQ8QHNTO4Me?=
 =?us-ascii?Q?yZUZ8LFVYf37uqMwQI/rNkC+wF9JP0P2BPSzUW5foqvryTi6SjaN8qA95kHY?=
 =?us-ascii?Q?1TLeAFqmiA7GD5DfOQViNY60iPbW60tsqOQvL0EVkOsS/FH6zKpQFFAJW6Sj?=
 =?us-ascii?Q?lgxiM3R2TCO7CUOX55jOQab79wrd2xC+9RU+S7lpPcR6m/Fe9D45G1VTz61k?=
 =?us-ascii?Q?fBxJQ/sTo0bzZrRRaZ6uqCfHgpq5UvyhKT6FmhJuGdyUBNOQRSw3X0O2+6aM?=
 =?us-ascii?Q?czqMTpVR7hjwzM7ZT85ZOVE+y0EImNeBwwkiwbQlcGjV9jJ6K3WHxcqjtjpX?=
 =?us-ascii?Q?dBHQpXs+/mjk80eWmb1VB1UdZ+A/1hy//sloQ3bVIpkoimEuC7aG/gLVISB2?=
 =?us-ascii?Q?C2BjuBfVBJ5uvV7hOQMH9RfltB+rt0NXKMdMqyUe0a4FqvkFRl2avJtD8SuX?=
 =?us-ascii?Q?4/F+lut4bG7FTiiUqtwL2WISpiQ/1XOSTGDHZuC+R21JE/8qFUCubz27BHJY?=
 =?us-ascii?Q?viR5MWFPmOgFjhI2xR13LtcJsqgHjy21Gjrfw+EFmNt5qCNUZVvudE/cCSAC?=
 =?us-ascii?Q?2vSwmgxMxg+p0nJ3txT21nwm8s0yifCU8MQMR5QTjzoO3VHUK8n5D80NADta?=
 =?us-ascii?Q?RlYno/yUKANUmxNdnxwOB73mZHvnl7qp++wCVKo+Vb2L0/YKkAQnFORaodTF?=
 =?us-ascii?Q?CumkBnY2hNwpYqKLTx5C3N7KrAhGa8W0A3uCb4u6HMd9P6/FulCfqXNVqy0i?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?YWqutcNcxB8S3d1D+kkHlIwiTt/l8RO3YiYe+8l5OqC031fL2i2oglA2zgwK?=
 =?us-ascii?Q?v0ucB9QK5BwVwIbUJiPYL0BqqYo/aK4r29Uu+dnqLkiT/kdVfzMzIef2hFgV?=
 =?us-ascii?Q?q5WJFGCD4pR8D67rJ8oHoUIjXVbM5KvHrmgxxdpHFuwPrRwBsSTIdz3yfNfI?=
 =?us-ascii?Q?lTlXtVfx8FXdmAviQ2ny9RXaory1iuWQk1E1bC6vXKSlmOq8qtz/jkkPVMiF?=
 =?us-ascii?Q?7GdwfeBYUPNcdSsReBaJQeL191nosoYYDdmRtwrPs9/2yKLg8IsA3vPKfGfw?=
 =?us-ascii?Q?cZiGblR5tP0MiCOjIA2E6Jgc9hObO1MoF3lcz7qFzA16g2+O9ftNXtdvQMRt?=
 =?us-ascii?Q?RpHX8JapDW/u7xyQnvOavL07OOb6ACVKnJEYCBtZ0Sdttfa/+9OsX7tO/Vd7?=
 =?us-ascii?Q?Boo7ms27AfAj8trqWA8vVr9hjnF2oZ+ws/+AofOn8OE4M/Ad/dAxfiaNYMCv?=
 =?us-ascii?Q?lql+OhxfpiGYGymZvgvn78DwepmhBC3QITemC3G8IpQKgdgqFmkChY9xqG/e?=
 =?us-ascii?Q?ISTiJs3Ud6NC1AFVAGkEbv7QC0KjZZ+DXB8A9qMtzFc2A7StMLAXsOLopWr7?=
 =?us-ascii?Q?HNVyKTgbJLiYJHu8w7bjgFWeRixwy+RD7z0TTwCYD6Au7x8LH/wzeXscN3+H?=
 =?us-ascii?Q?DuRObuNU5S7/NJNsiV66eLmVsLufwkCsk86DQZtCojrAnHGc5M3p+9MfJ7lt?=
 =?us-ascii?Q?wpBXXauuUPD/3KUUduIHSOjim8e7HV2iWlIEMSlV2vExlgGqP8+TC2xQBfsv?=
 =?us-ascii?Q?x7LuMSt7eU4OKu4Pw/0Xdo2EPfS6afY6mk3lV1yTnW9UPjEt/iI8bUzdINYH?=
 =?us-ascii?Q?hKC4m+H9/nyJ3D4z+BMFGz+jxhXIBjqgBxuXgXevT/opHK5L8xH6Uh94Ezng?=
 =?us-ascii?Q?fm85gqfMcE6ouhfexTWsc4oVJgmcKobsDYwhAszBCY1m/HJVymEEQACA2yG/?=
 =?us-ascii?Q?Bk0OoMxXR2odmdFeAZp8/jszWrEurawG5myjHVw+jXtf02LFTcz32GSxU4bU?=
 =?us-ascii?Q?YZIi/5zhwmZPDuo0L4JKqR3i1ku92K8lTEIG6Th8IfYwTTtFtLdmeR4Iu4ug?=
 =?us-ascii?Q?YjmzBQBWfkS6FGfEHsIII0UZPXnMxA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54e208b-0856-4824-8a7f-08dbc0d6c2ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:28:02.6038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKAgjYLNd4dRamOsz2IoXNsy073x1VTvx9E2+gkK/j4mNrH+h0yR2PpFLdk/qQl/wTRsW/YzIWQzYpKcdfHcoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290089
X-Proofpoint-ORIG-GUID: t33RmsLwIf1CyjpbsVZHPuFbQH9jaI56
X-Proofpoint-GUID: t33RmsLwIf1CyjpbsVZHPuFbQH9jaI56
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Prasad Singamsetty <prasad.singamsetty@oracle.com>

Extend statx system call to return additional info for atomic write support
support if the specified file is a block device.

Add initial support for a block device.

Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/bdev.c              | 33 +++++++++++++++++++++++----------
 fs/stat.c                 | 15 ++++++++-------
 include/linux/blkdev.h    |  4 ++--
 include/linux/stat.h      |  2 ++
 include/uapi/linux/stat.h |  7 ++++++-
 5 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index f3b13aa1b7d4..037a3d9ecbcb 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1028,24 +1028,37 @@ void sync_bdevs(bool wait)
 	iput(old_inode);
 }
 
+#define BDEV_STATX_SUPPORTED_MSK (STATX_DIOALIGN | STATX_WRITE_ATOMIC)
+
 /*
- * Handle STATX_DIOALIGN for block devices.
- *
- * Note that the inode passed to this is the inode of a block device node file,
- * not the block device's internal inode.  Therefore it is *not* valid to use
- * I_BDEV() here; the block device has to be looked up by i_rdev instead.
+ * Handle STATX_{DIOALIGN, WRITE_ATOMIC} for block devices.
  */
-void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
+void bdev_statx(struct dentry *dentry, struct kstat *stat, u32 request_mask)
 {
 	struct block_device *bdev;
 
-	bdev = blkdev_get_no_open(inode->i_rdev);
+	if (!(request_mask & BDEV_STATX_SUPPORTED_MSK))
+		return;
+
+	bdev = blkdev_get_no_open(d_backing_inode(dentry)->i_rdev);
 	if (!bdev)
 		return;
 
-	stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
-	stat->dio_offset_align = bdev_logical_block_size(bdev);
-	stat->result_mask |= STATX_DIOALIGN;
+	if (request_mask & STATX_DIOALIGN) {
+		stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
+		stat->dio_offset_align = bdev_logical_block_size(bdev);
+		stat->result_mask |= STATX_DIOALIGN;
+	}
+
+	if (request_mask & STATX_WRITE_ATOMIC) {
+		stat->atomic_write_unit_min =
+			queue_atomic_write_unit_min_bytes(bdev->bd_queue);
+		stat->atomic_write_unit_max =
+			queue_atomic_write_unit_max_bytes(bdev->bd_queue);
+		stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
+		stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC;
+		stat->result_mask |= STATX_WRITE_ATOMIC;
+	}
 
 	blkdev_put_no_open(bdev);
 }
diff --git a/fs/stat.c b/fs/stat.c
index d43a5cc1bfa4..b840e58f41fa 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -250,13 +250,12 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
 	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
 
-	/* Handle STATX_DIOALIGN for block devices. */
-	if (request_mask & STATX_DIOALIGN) {
-		struct inode *inode = d_backing_inode(path.dentry);
-
-		if (S_ISBLK(inode->i_mode))
-			bdev_statx_dioalign(inode, stat);
-	}
+	/* If this is a block device inode, override the filesystem
+	 * attributes with the block device specific parameters
+	 * that need to be obtained from the bdev backing inode
+	 */
+	if (S_ISBLK(d_backing_inode(path.dentry)->i_mode))
+		bdev_statx(path.dentry, stat, request_mask);
 
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
@@ -649,6 +648,8 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_mnt_id = stat->mnt_id;
 	tmp.stx_dio_mem_align = stat->dio_mem_align;
 	tmp.stx_dio_offset_align = stat->dio_offset_align;
+	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
+	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c10e47bdb34f..f70988083734 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1533,7 +1533,7 @@ int sync_blockdev(struct block_device *bdev);
 int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
 int sync_blockdev_nowait(struct block_device *bdev);
 void sync_bdevs(bool wait);
-void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
+void bdev_statx(struct dentry *dentry, struct kstat *stat, u32 request_mask);
 void printk_all_partitions(void);
 int __init early_lookup_bdev(const char *pathname, dev_t *dev);
 #else
@@ -1551,7 +1551,7 @@ static inline int sync_blockdev_nowait(struct block_device *bdev)
 static inline void sync_bdevs(bool wait)
 {
 }
-static inline void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
+static inline void bdev_statx(struct dentry *dentry, struct kstat *stat, u32 request_mask)
 {
 }
 static inline void printk_all_partitions(void)
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 52150570d37a..dfa69ecfaacf 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -53,6 +53,8 @@ struct kstat {
 	u32		dio_mem_align;
 	u32		dio_offset_align;
 	u64		change_cookie;
+	u32		atomic_write_unit_max;
+	u32		atomic_write_unit_min;
 };
 
 /* These definitions are internal to the kernel for now. Mainly used by nfsd. */
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 7cab2c65d3d7..c99d7cac2aa6 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -127,7 +127,10 @@ struct statx {
 	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
 	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
 	/* 0xa0 */
-	__u64	__spare3[12];	/* Spare space for future expansion */
+	__u32	stx_atomic_write_unit_max;
+	__u32	stx_atomic_write_unit_min;
+	/* 0xb0 */
+	__u64	__spare3[11];	/* Spare space for future expansion */
 	/* 0x100 */
 };
 
@@ -154,6 +157,7 @@ struct statx {
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
 #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
 #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
+#define STATX_WRITE_ATOMIC	0x00004000U	/* Want/got atomic_write_* fields */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
@@ -189,6 +193,7 @@ struct statx {
 #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
 #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
 #define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
+#define STATX_ATTR_WRITE_ATOMIC		0x00400000 /* File supports atomic write operations */
 
 
 #endif /* _UAPI_LINUX_STAT_H */
-- 
2.31.1

