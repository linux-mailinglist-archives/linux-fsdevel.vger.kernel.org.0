Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E93B4F73BA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 05:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240533AbiDGD3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 23:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240348AbiDGD3o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:29:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A942BEB;
        Wed,  6 Apr 2022 20:27:46 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236LsrRt004892;
        Thu, 7 Apr 2022 03:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=tAPmbbaCkvVZPvRGbdErqYJrUZb0QsK/3MVtxkvtM78=;
 b=U4YAcWA4jAisZZK//5B1Q0Bz/XRLUueeIrA8QtDqWbfRoJFt6ww6ZmEUob2Y/jy1sDg3
 VEi5fCC9yWTf3nvupLHm/YIzJPr7h7ZwuiJ+JTcuJZCb5CbP7NmlaLnAERPFAnOYbOYE
 +h9ql0/JQJboCoKu9y6jxoiL5yjQj1LOXIcN8Hk7tIedSgevMXYjg6UChMxtQr1PKZzU
 NtBFsW+j6C9r8V7FhFq+QTNg0BBhAXzF86OpyuXQw+KKI1flFf3QrS7/jbrHoGmM1fXm
 GO9VW1PZsX4FHp5zwhKsd0faRseJ8aBOcK7adMvInz51QRy6VmWGQG1Ss3Z2TSDrpSxd ZA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d932mqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 03:22:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2373GhBh035403;
        Thu, 7 Apr 2022 03:22:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97y72nm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 03:22:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsBwi7g0NwGQg6t1xP5oMZVKwn3MtYRePunjGc0MyZrXQX39LqrGcGdil+TbHna3HcJWZNny2OQmlqdDHk7pC2rJyQ6k4Fz8PeDcp7ZnQMrNu36Ea773LXoqIVir6Pbi0oeDDP3nBQpwnpJZVMJSjTWOfcHgAvw9dCA4kr0yFv9J7Tq/2lOfNkbvojuPVZut9KcS5VOGWZNcDE7BtbaxdXfvtnFvZK2FIqW21dkSww6RYLrY+Y3vUlDCSDGQ/5N8eKGlhs5R6M/OFtjJ0plklkTb6VgQ8UK9Du+vLtLgH9dww89omTtOZ0oaEpdX4UaumJemm0QuO+bIb+aa7xWqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAPmbbaCkvVZPvRGbdErqYJrUZb0QsK/3MVtxkvtM78=;
 b=JnBwmgC7LFwrQh4Ae93PWvlnXQ6j3VAkqIWP48hbX1N5Z+JdPEn4AqF3m+kZbw6+OjH4K1yWN+vqBbLNRRH+JPXWFPwL/nRR1kHwd6VEORJM6aEdUC1selehpRYRCnI6kzEDnj3N0u+Cdi2D+Nk/NhKeY9HzZD1iCPHHpwIDVqIAmrLHMTMXvaOsbHbg8tRAJWp1LiwWqXEpzpSaJ4oF6f2MCZOl4L92Bv2HQMnPx4vKhPLZSm+l4+1630WyoORr4Und3Ygb1/3TopZKYd/C+zh3KPvz9TsHxahRAjFHaLU5oN/ZGQWJRCPqeYKp1we0g6kRKuF6edEkgYe/p7jBUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAPmbbaCkvVZPvRGbdErqYJrUZb0QsK/3MVtxkvtM78=;
 b=MRrjdMSLg06qPTU3S1SGeGQnPR2zAejXn14jAWS/xhEBAkGh8Oc9hT6qEzuPeQitZqKnTnE8YfcgmlrYrC06UJGXooPq++fgLAPl20rNvALQPvprAiZvRAXk1/H4MNoVbfWPC+3bcuo+ndYbontOUqr7e/eHqBypLrudSwOC5Vw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA2PR10MB4748.namprd10.prod.outlook.com (2603:10b6:806:112::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 03:22:16 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 03:22:15 +0000
To:     Christoph Hellwig via Ocfs2-devel <ocfs2-devel@oss.oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        jfs-discussion@lists.sourceforge.net,
        linux-nvme@lists.infradead.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        dm-devel@redhat.com, target-devel@vger.kernel.org,
        linux-mtd@lists.infradead.org, drbd-dev@lists.linbit.com,
        linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, cluster-devel@redhat.com,
        xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org,
        linux-um@lists.infradead.org, nbd@other.debian.org,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-btrfs@vger.kernel.org
Subject: Re: [Ocfs2-devel] [PATCH 20/27] block: use bdev_discard_alignment
 in part_discard_alignment_show
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tub5h92g.fsf@ca-mkp.ca.oracle.com>
References: <20220406060516.409838-1-hch@lst.de>
        <20220406060516.409838-21-hch@lst.de>
Date:   Wed, 06 Apr 2022 23:22:13 -0400
In-Reply-To: <20220406060516.409838-21-hch@lst.de> (Christoph Hellwig via
        Ocfs2-devel's message of "Wed, 6 Apr 2022 08:05:09 +0200")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:5:80::40) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48dfe498-a030-4603-882a-08da1845d094
X-MS-TrafficTypeDiagnostic: SA2PR10MB4748:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB47487EA3A8AE47C7ED7289758EE69@SA2PR10MB4748.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ph7TJz13ybahhFzUjKzZz6hoi9EjoSE4dHQMnFWDfV18h+5KagqOADbAnIVWpAvozVEycMdYYa8zzCg252RO80zRbpNyi9T7tc+92ezusUxorrNXJ18kwYLL2sVdMfNTVGBN7kpBqAV0CvQvMwuUGSMaAfantVV3LpC90npPuGwNQTSDxEjJFIrbcAiO7eeUE/UbnOEkK0XyuNUrc/lM45zIMm+FF7KsB0oCUbZoq5uNwuKI/0usdEuC4DRkeNDzO8c5VWp4NXr9qKG0yxYMh3QyRGvQ30zCJyLsi0360gV7sb/Fx4lhM8+CCLd17P5YAGQXW5RaCpVErImRZf30K67W8cpMbjfpP49BqPyG3rMGRtVUlP8wsBobWI/A7+dI2JU0oxgJV5Vmmxd766Qv5twJNVgCsKgjOY92Yfm4U8TLhuPrE/Ut+u5+aqDvZIR07d6+kv0sjvuzm+hCvr0gabjG/QYmzAQ2zTU3czU5W+Z4PbMnec8vOSjI5xzLEYUg1eDZBGO80yfoTs5gGhELT3Wz/oPD5mPsiTazRBjnJtPnq+NArdeqSNJRAylw3IaqEhyUB7PM+mxpVEuCOp+RpV54qAlwUf1gyuObDXCCYjc1h9rL/5L6Kf4E3gf9K3BIcemjNmTWiBI5nYL1JFETX/q/OAD24cNAuJqG/lPMYMK1TU0DQYreYJPiTSc79UWqq1q1p9AqzmKgHlsUO2ayJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(38100700002)(38350700002)(508600001)(7416002)(8936002)(5660300002)(2906002)(6862004)(66556008)(4326008)(316002)(86362001)(54906003)(36916002)(52116002)(26005)(6512007)(558084003)(66946007)(66476007)(186003)(8676002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?smfdKzkzzQC5MfcTkNTRJx6MrcqktBYibTu1WZRM33ZRHVagZq6Fx6eYeOgA?=
 =?us-ascii?Q?bXhKM/v75VXxhdovlGb5kKYuZsDFnCsuzbjo1SPQqI2sJbBbNg8GrAxuF/NP?=
 =?us-ascii?Q?KBuFCvyY/eilUlZ8CYLCvM9NwInI2Lk8kbxHG0qBMc1LSgNYxyzVqYIgkjjS?=
 =?us-ascii?Q?9wZUzpuyXmw/OHBcStedtnal8ZjvXj/3wm4s/H6FFjq6ACg5F3L5U0BnTTFc?=
 =?us-ascii?Q?/QzbRcjS/COrxILp2Z+g9zeg+unT6+51ZgERIwnXfurOr5SmtKITtugPt7S+?=
 =?us-ascii?Q?p0DO6V/ZO2Dt+o9D+62WHFFgA7yNiDyvVp/6axGTkkicWOCDAzQJ3pMf7Zin?=
 =?us-ascii?Q?qQVobFt6aEFOSM0+HYW9SpnTJ73qr9nJmliGWuclbBgvKH4CEmpvvaOhenDc?=
 =?us-ascii?Q?K9Gnx5cKNJ2jqJoD3iB1apRQoMPZv3wpW4MMQPMtS5PIjpOHDWdC9pXu+fBP?=
 =?us-ascii?Q?JT5Q/9Qua+91p5DrGd0WYIoxSj/F7XY1AqEWCS+eNXIt40BG9G7kbEu6O6Wi?=
 =?us-ascii?Q?XHd8EoCPLBwM1NiHvOUgAk+zZZzpyI2jJYTS6FXl6aWaY3EH5cX7iEDtmqtU?=
 =?us-ascii?Q?2R9y1El0peGOfhITCq5E8JEYhBGObk3SEfu4I7aa/OdO9JoEfuPRmkMiyTBy?=
 =?us-ascii?Q?jdfhAF/ijlwNMUceopzBXyYZi7pVDMdLrco1QqUkIL1Osct6Jhe3StjwwsmU?=
 =?us-ascii?Q?NHNu1OU0QEp82EqTdt+ZYtheKExOPOD8UsUptsGAABNON4HF7mE77a/0U89a?=
 =?us-ascii?Q?LM2IbqhI09DwxhTllDEqqhdklhZEhWlfUSxHoPP1oFd74IVJyAY+u3MEnF74?=
 =?us-ascii?Q?KMLw458R6hnzdGcXlsJBo7p46V01v84gHfVbMmWiyiEca8+N3PoepN5Nn9kw?=
 =?us-ascii?Q?ZdDCvKCeeFVhMLVNL6axV2tmUk0iFv4m1m0dZ6FVmRX3NaNhkVHPoZrptmjr?=
 =?us-ascii?Q?VBt2+33iKm8BghK6TD1bM9N539nCQ59YjiSv9TNwGxhzMjVuW9dSFMbeffyv?=
 =?us-ascii?Q?3igRst9ERRUAQrxVHRoA9UHcf3JPUTgc1ksnDFl4JtBYfZPUpfkTvJRfAMAH?=
 =?us-ascii?Q?A5z+VnH8Dt1orSNOo+bGXRJ9n2+xJHjLLTM3m7vl9iw8br+p5zoAW45+K9X7?=
 =?us-ascii?Q?jn6GqoV66kRS2PzB1GvyqKfsPoBH5KpBgTW0UFURoch/eCByKNKprXuzWT7w?=
 =?us-ascii?Q?wS27Lysj+Hm5mBt8OHvd7tRb10WBkfvDMEjeCdx6nO4LzOV/H45v3Jf1cNp2?=
 =?us-ascii?Q?AslMP+FWldX/mh6V3bdglSLt+YcPjUWBsp7YGf6w2JPWhWZFwd7z2SZGhNJG?=
 =?us-ascii?Q?6cNzBaAj0626t36i5I7bLET9wdAubKkmiwsBsWB1/rfEd+9jv4TjUAf2bGsv?=
 =?us-ascii?Q?C7+zUgXuk/SIYFjzokPsd8rD0Cxy1/CDsI4OUdsLpJ0y7G1vHeLX3wFHl8Pl?=
 =?us-ascii?Q?6xiUhb8itUQ0jrl/eLZJYv48WUiz7Vkc0HhWr/UKedQSm+HpsfmqBu6zXPbQ?=
 =?us-ascii?Q?JWOjmtXfOD/l3OG0FERkZjIORLQGTDmMed7dEoL8U6PsQcrNeGfEvX+7S+4d?=
 =?us-ascii?Q?B9EpcQdO0FUNi8+JE3n+rkNJDvvH/DLnCRCx+5ljkK5wk35aMOUUIVk1gPVV?=
 =?us-ascii?Q?JS80ZhhdfoMiqI1rG2Llu7fUx5VR9pWFenqE3jOFUo9jr5L8BR2Gev+wYfwR?=
 =?us-ascii?Q?3KzWO19pjJGdmeCAgZMEZKABjvl2X4GzNxOk4IAwLd74ROSZenPf9AfA05Vs?=
 =?us-ascii?Q?J+jC/LDaTYy1byqBokxGIhJ4DXvKE98=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dfe498-a030-4603-882a-08da1845d094
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 03:22:15.8957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mouFQTiGIB3sqIlUkexWTCexFzQ2PEHssCgeJ4E6Wra5R4KAPVyvJyuCB6zCHxahDwRdbWgEroHmtjXA5lGtLWj+q7jaev1O8w8EMd3wEKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4748
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_13:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=920 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204070017
X-Proofpoint-ORIG-GUID: qEU8oo0GXgxRhC2NABzBkCtpoPeQvZDd
X-Proofpoint-GUID: qEU8oo0GXgxRhC2NABzBkCtpoPeQvZDd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Christoph,

> Use the bdev based alignment helper instead of open coding it.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
