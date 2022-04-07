Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB42D4F7424
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 05:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiDGDiZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 23:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbiDGDiW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:38:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483722414E6;
        Wed,  6 Apr 2022 20:36:24 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2373LlwI012558;
        Thu, 7 Apr 2022 03:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=mYq6byqIyiFjHV8Jr0Ype4Fjz5k3Y7rfnHXOHjRgy9A=;
 b=UoLG9f3rZI3Wt+K09rjVRxZ9B08Rhn+8Grv4X1PNpsDZE/RDxHcFxHCQUgwuEjjZ6rJq
 wNuNdlyjT8obYSvTpy3fP8BF876Zs+hqOsSrpBucEgo+EGYJuY95NOIj/xV4vE8YbjAM
 Vagf4r2oIzDGXZGT1bdnYp5qbnHGYW7ZJYGyzEiZs3s6Ry00lGPuyfSwiiKyo3rmS6Xs
 jIimKiYXYc+jcfhgOe5RxG0KhocTvE23Yl2MlbRB7vMxhf8ntKaiSqTtKKykNy2isH9t
 U+pUa7b3DleXFwYe6m9t9XKqagf5GTTGyB+OMYYemMPa9DZQE+veiYorobvoHI2Ri9I9 vg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcjat8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 03:30:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2373FaXk003994;
        Thu, 7 Apr 2022 03:30:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97tsu2tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 03:30:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZREMpp6H5+VPMk9i2bRpb3y7S8qDajb0lIZ1QGaczRwc0mi/PK39l7MJBAUSRl5P+pACWwAEnZUNIln8sTVXnUBo+4GQitsaV1H8bnnMOFOkWVDowIHrx94bwa7+AeGDQCPA3vQYQGu6zzA7Jiyx1IXzj0YzihvwAELEmtxsPzjQUQY2Rh+2m0HQBxlc0rJkXgC9p9YVyRDpVgO/vIxbw8CMZ+f89VfeOfMvHY5aJODzlqCpSeYHdO+JrbH4jwSJoXeNwaO0XWvSU2AajIf29qu0m4Ug1nbAlqQWC3cO0RbwWyD2aAz1jeYjJ6oPDJBSOl41RjVyi6kZSlPN6rJDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYq6byqIyiFjHV8Jr0Ype4Fjz5k3Y7rfnHXOHjRgy9A=;
 b=nSyNgauYv2h5VXaSrOWCSBqeiU+09xRdINopgU01a3b83Eu0h0BNFXVyealu1LLMQOE6sVYw2/g7D/m7USv0atSRM6Qu6sb5Z55Wv6P4rOX3VdWwJ7bXMmS/h5tTp80hywx3mBz94nc73Nz0yndnWY75E1aAnYORpsHx73NyAppFTdJVB9wjxN8qS/e1atQy4ijscqEdyOWLQWQTvM19Mik4GRzhH3ZKiGX76FWMK9myCgW1KSNLwWjaRE8HOYgYigCJTys8K1GdXjkulGFH3tcOGDRQsbYKr63UQdFUaBE1fAPi3OgztJn20kUwj5Wpf4h8EZDqNmXkz8Ih7SOlzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYq6byqIyiFjHV8Jr0Ype4Fjz5k3Y7rfnHXOHjRgy9A=;
 b=Eq21Wo+j1JF7OTWA82B9borMkMphwY8igrWHR4LUBmyqVvlgcx8FVIJUwbmKdh+L5EQ9Jv9PuMecfsquNzJY+mcwWkiVOlR6FgCJX0GNs3UISUzrsOhNNFWZSMcdkqsDwJX8uKCIJCU4bK3t5lY/Fsw3+RryaRh/fdY/cELhbQs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN6PR10MB1618.namprd10.prod.outlook.com (2603:10b6:405:3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 03:30:54 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 03:30:54 +0000
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
Subject: Re: [Ocfs2-devel] [PATCH 23/27] block: add a
 bdev_max_discard_sectors helper
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18rshh8o7.fsf@ca-mkp.ca.oracle.com>
References: <20220406060516.409838-1-hch@lst.de>
        <20220406060516.409838-24-hch@lst.de>
Date:   Wed, 06 Apr 2022 23:30:51 -0400
In-Reply-To: <20220406060516.409838-24-hch@lst.de> (Christoph Hellwig via
        Ocfs2-devel's message of "Wed, 6 Apr 2022 08:05:12 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0105.namprd12.prod.outlook.com
 (2603:10b6:802:21::40) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1be5c088-2287-49ae-6394-08da18470588
X-MS-TrafficTypeDiagnostic: BN6PR10MB1618:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1618E32487955B9F9B5D96918EE69@BN6PR10MB1618.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8gxwN1qd766/FEvTxZsvps09fsNZz2Blg4R07kgI9m9KSHnl0dLCc5qCOHdyDxKnJMTlLhipMc6ID3ADVW6mLW8YWr4aDKYjz1h4KSFybqlMxpb/2tKUo23Y/adTdXMem7XT/fUObner72zcjRSg9AZsmvCkSc4GkR/XUqZN/tws0pXNieSzyPkrRkDl/HbLNN4lUZYwxMbsn5ThClVT/AwTw9laykF7s/6rWzhc0PmPp5luCM4bEN5e13q2Bbbs44WqzYvvwoCG3rRRMhRDKZ46DBp0kDB+2rRhYaQ6YZ03QhfIzOV3PI6eM5qkyquBKVNW1nWJvk1Zf2Hg175UcZLAjPMw7F7jYvcP+l2YeA7GLNiho45HDNKIRtnyr80hV25BKUKMD/e8nQwn7Wtc/rbZrz3Q54VW70zH3epBZ4Tlpt0RNp89LnvKYkO9gqkqDVvgvDD4qniH8WKJLShlrTETisSnC8GCfHLB5SAg2uGGxoV3D8caapwIEImkU5R0mR+7bHgZpp5bfynlIY3iTbZBMTFeNoRjZ8Q/hzb7qpUuwKtXjyNo4oKY6edsDD6O9ruwMsBk9t3EFSfgORHTFLMTJpj0B4joVjWC8geFsavcrJTmBtGj+jTFKdq8SCTPNrSLiNDJ87mHeErrwzYXnk3/Ke9fAuZHJ6zhbOuL7p3LsssEMTZUQXuxoEqbWhtMa0KFiBBxrkYGHhNF6WGX1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(7416002)(38350700002)(38100700002)(2906002)(6862004)(4326008)(8936002)(66946007)(66476007)(66556008)(6666004)(52116002)(36916002)(5660300002)(54906003)(86362001)(6486002)(83380400001)(316002)(8676002)(26005)(186003)(508600001)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ihvR7bczvaIQG7216CB5ol7nO55w+ON2inWn385F6dh/MzMWSfxomVyaGD77?=
 =?us-ascii?Q?pW8D0hyTx7T7mV7k796CjeXFDR/6kzd3SKmnRnGOYRBe/i42T+KfII+CTx0c?=
 =?us-ascii?Q?m8pdY1ElIYOYf2JoQHxnANYxDi2UKRlWIHQfxRaU4df4+P9mkUnX37GG8J9P?=
 =?us-ascii?Q?nBryl26ZzROotKfi+iQHT5maY8Y3viYToEXME2P5XZBCO/miHuhySS63mZAR?=
 =?us-ascii?Q?fMr3JT9qm6osYO8dpXLa3WEroi+gaUOpd900IdcvdU+llj3jnjCpQLd8uFMl?=
 =?us-ascii?Q?qNHavVkYIe2a4GVuafKp4g82wPBzMpQrKE1kOjGgIFwLF2fXbWI/eZeizGWv?=
 =?us-ascii?Q?TQwE880JqTrbdCbSYHjGGbs5Q5eeRxvarjqzsnbACAd+sR9HsTDpJJxA26vu?=
 =?us-ascii?Q?CfGIHH05IgvFMX901w6+gjBnErff2m/+tw/eDynQdNf7Deqjp2vBjxC3xAgf?=
 =?us-ascii?Q?pT8ddmtP1XEjife3m+TAhoH5RKgtWqy0JCd6uymKBI0Ni77JqOAk8rBnqU8Q?=
 =?us-ascii?Q?Su7UklOI7XCxWw6I0ktsadRj6yOqvBqwLq1oZVcJQ2XNTafCNXO4uNF6DvRb?=
 =?us-ascii?Q?fiEQf1G0NDJbjkSfLRYHyiQdJQ5L0t5X0cr3bzCo4deMeELbapEGI5cDPo7e?=
 =?us-ascii?Q?I4pTCP7o8mZe2wm7Rgv5hS338Xz27geN6vruuXlgSEejOkAZUoFIKXBR2IB7?=
 =?us-ascii?Q?/8+pTmu2kJqldFYVou8PaPL2w8RxFF5hU6zJXk9xuOh/DDwrd7X4dS0/+v9x?=
 =?us-ascii?Q?AzL+AvAOI12o8KyrGCISq//Kyepv0JFq8D6ZbKMigU1Gzbwc7IxQIEOIq5aI?=
 =?us-ascii?Q?fvT4D6CU7Ns3AMoJPRDHoK2O7s89XEk0nzqYgV8EOOAonVQRlV/WcL4+CPH0?=
 =?us-ascii?Q?y7aQVIE9nilKoI+qkImwkxdtwBwFB1ukxPmjbLO8iyAAeTwFH1E6BHf/xgbV?=
 =?us-ascii?Q?swFGmP5HI0idJPLHNlIkaLaYrdeAiSZv6ywVAhiwsMJ8ky0o/7qQlO+ycaSA?=
 =?us-ascii?Q?XvHvuki8VDF64H5Ipj1dzhjS8TQojQ84NBKOGqv67kWHXN2AERiW3gxM5u5U?=
 =?us-ascii?Q?MguLFXcDY/ytuOK5mbl3zOzdWW+2VUFdfBHuv6IKXAeyv+05G9zLy84ACG2/?=
 =?us-ascii?Q?2oK4tPYgouzSGTwfeggOmxM4lqXmZfu8PECYwEzIUATZzbUk2LXUqyOId9Ww?=
 =?us-ascii?Q?yxImetNs+yiutTXJSBFpwwnaUwfPQUQ0+qh7K2h+gABqTZANE7EDpoMe6iNd?=
 =?us-ascii?Q?c9546r57vTNquOACsA6+pt1IpTonnQDCFKHWw8FX4GvyxavbDhry3A0ymwjp?=
 =?us-ascii?Q?1VX7GvNpu1Ybfq1K/Ofwey6M2gwcksu0I0bqfrKU3BtLki2st3g+Xjfrjuda?=
 =?us-ascii?Q?fBdoZj5TwY8RN+0TFsN4oEQgrZ9UwyADY8zu4Ct6JIrjFIulqVB+IlaxXlhM?=
 =?us-ascii?Q?EFn9F/zsWNkXYQC/WXVI6hmKeIuzB+UJayXXwJvSAry1w1895YcQx+/gIdrg?=
 =?us-ascii?Q?EjdxHGTjc6+NfWqwp1siJQE+tUmvy+3cPWpo9EMItkn/ZLvdrzWKP2XnJ1MA?=
 =?us-ascii?Q?5+SsSLBXqr5jKW9B+1RYmID9CwCDV1D04zmqavLc9iVEmYO9YqExX2RJQ9oy?=
 =?us-ascii?Q?9GWgc/r92xStyJx0I3lvVeHgUraywUOK3T469OLkd7rpJVtPR01OUbnc9V+5?=
 =?us-ascii?Q?DW2LqW5EvmlKR3SYyggM6qOiF9bVeTV6+QkQJ5Xh/aEOy7NjqZTPCn6LTKyW?=
 =?us-ascii?Q?Ht/8ijb3KU0pi0uuR7R4ZsXzy+B3izE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be5c088-2287-49ae-6394-08da18470588
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 03:30:54.2477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZsxFmvQzbP4r8yjJO40wi4P7IVmH9WINqip+vYPN9usm3gvSP/VHIESPlyRfsIAkdL64OGdqNNYNpMQLS7mVX4jP/XZqTlg8HmQkUT1qUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1618
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_13:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070017
X-Proofpoint-ORIG-GUID: UEFFmcnOQOZkMAhFK4yUzrohDzy5qqTT
X-Proofpoint-GUID: UEFFmcnOQOZkMAhFK4yUzrohDzy5qqTT
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

> Add a helper to query the number of sectors support per each discard
> bio based on the block device and use this helper to stop various
> places from poking into the request_queue to see if discard is
> supported and if so how much.  This mirrors what is done e.g. for
> write zeroes as well.

Nicer!

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
