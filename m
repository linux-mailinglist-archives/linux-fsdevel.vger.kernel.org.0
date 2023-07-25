Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7874E76216B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 20:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjGYSdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 14:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGYScv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:32:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C57E7E;
        Tue, 25 Jul 2023 11:32:41 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PFsLJJ021583;
        Tue, 25 Jul 2023 18:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=kaImxyG8aN7MdurwLcOttvFHNydHLkSSrAbreEB2QT8=;
 b=p+Wg51JjLahaaZ9jK6l5d1QecazQhSfsbHcEG6pzb59EZcck5Phiic1OK1w4hfbd7Moy
 N2IdRkzpIb+x3KNw0/cr9CiB2ZuQ79bQ3La4pqG6+G0tKrl/RC3USLV2D47aswICSlFE
 CdmnyQpSrTiBzulVQnuZsy/uWlkQ223YzCLQ2NfNuDuCsFGU0h7VVLtGXUV/2IVZKKGP
 fhdVHAoxY3XVwEWotk7iT2YNG00lp/EzgPrhQfXvaRFIzjDCXVqBvYZZeKVfV7aCI0ln
 Ap9MMjg2R+jrPmR2yHEKklco2l8pQttAcF99X8+pijU+mwoaQUZ/KHQeleSmkApGZQGm HA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s061c5tya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 18:31:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36PHqWMm033462;
        Tue, 25 Jul 2023 18:31:49 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jbeq9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 18:31:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkU8K3rQcQfues2h5k3mwgr7rjazqSSMrQlgL6moYQk0IlGApCSUE2+E7ywM4M+Uvi+HNBpyBu3X3X6FY7zfbjo9tb5NOhIWk/b0O6NJOppJaIlgI27xANGkfcr2GmpsGLtLJ966y5uoQWmvMNVMccaW+5uKKnUOEZ0vaJ7ITI2kFAJ+B6etdy/AXxr2RdB/3U9nx3+NW+L+i8cj014tZp4dJVOmcoqcKMNdKR+y0QHxNjKylX0Qxd3B07HAoZUk0Ccbh3JMTcf0OJxFyMJjvTbU2vDySLASibx1pL/wVZacHgWcRUvA4Al+S81woqq9ThxYWJWgzhCjSH047GAneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaImxyG8aN7MdurwLcOttvFHNydHLkSSrAbreEB2QT8=;
 b=XC33zfFYoq7/Vqh1R/9jqKtJN6yrDOi6ioLqKom3HgDzmUIigVHP8B8C7oYEOXLD2bnI+a9L1Sc15naVSJ677fHaPexqjYumFt4kcQsqIW2Y2b2YweIGJoxtRBfR1lin13YG+UWmFk4VY0bd+MEnh40fysnHyrVa7VZiymBoE74Y4tzzmUisCqv1S1D5HSXj8BRTS1Q1wg+IdUBrgKeHLtZpUVuSpMxe0zDiygIEz+HQw70owT7nLRqwj2/LMjG2QZmPgn8V14xtVqwglm0gG0li/JOf2FglE7MmRCiB7TZkzQimR3KNvliHrcOIQ2dj80hJp3WsyS5/SqWR7RNSNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaImxyG8aN7MdurwLcOttvFHNydHLkSSrAbreEB2QT8=;
 b=TZ94phYE8v50YZdpQyMzbSokKOOqIQfNbOwfCG9yD/zGt25ictlAY+VYCphUH0CBwi+cpDUOz44+kBhfZbk04ORvANf5iQDcF9P8Og3qkQlqc0wPQM0gISiWYUd1e/bix0mbqqqvb8iqvhqnjQhL0ZcH2c+pkW3Cc614pBOiyE4=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by IA1PR10MB7418.namprd10.prod.outlook.com (2603:10b6:208:445::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 18:31:46 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 18:31:46 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        kernel test robot <oliver.sang@intel.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        stable@vger.kernel.org, Thomas Backlund <tmb@tmb.nu>,
        Ackerley Tng <ackerleytng@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] Revert "page cache: fix page_cache_next/prev_miss off by one"
Date:   Tue, 25 Jul 2023 11:31:29 -0700
Message-ID: <20230725183129.222692-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::28) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|IA1PR10MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ce16be-45c0-4d5b-ba30-08db8d3d66d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s6jNUEXWlAeG/bxeijJ8X7lCQXTjpUrxew+pTt+Z5sMDTUJUq1aRWk3MbPUwUIQPpLFql3gwrNgOEw7i2jY906j74oqgXa7feBjI40FCTP5/lXAqxfY5CQBCrzpL2LMIx7GKmDtXLVZ5wWnU4cBIaDIponixbBU3KlVN81xBVqBahS1ytUNnitOmNlNbBSB+R4qb5YOMuXproaSFsDVM/s8RyW/PyU2ZVPeYkFTiSa6V5lztHgdCftVSH40ece3uoc6H+285+dY0cTUhFErSnBjWG2dDhy8cR8iVEY2ImgIjrl/VlzDLTjjQVGz21AtQE0BMNR61Jv9LkGz91NX/r/dvrm1bpk9ZsMJ59V53HEiOTNv3VwkefTCt7uWPGG2Dtryef9ipknYqUP4nH9/O5uf7zLiG3zxGUbOXLwc0xRoVM+VKYBWdRqaXTk8N75vQscqFd79K7C4xDNc+dlM+mYffoX5Kc2/Qw/7pMb4epuubijiq4F4neNawHcmRJlEB3vcgSMy71LAnNsWKgIP+fle+1zI8bQDvQUOMil2pemY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199021)(5660300002)(8936002)(8676002)(7416002)(44832011)(316002)(41300700001)(478600001)(54906003)(2906002)(966005)(6666004)(6486002)(186003)(6512007)(1076003)(6506007)(2616005)(4326008)(66476007)(66946007)(66556008)(38100700002)(83380400001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qQyipF6A4RpnsTP/nx+nsK2W8pFlnJgYQStQebTpajU5aJ+toPuDqy68DM5G?=
 =?us-ascii?Q?+4v3KtlYKKRg9bRECNU64POQe5uTQRSYc+mpDmneKKCuM0xU42at6tg9GZJb?=
 =?us-ascii?Q?snxMn0h/BX7Ox6vPMqkM1qmZFZKVSz6l7hK1srpeB13LtJbK5PuWh2AUBKJ1?=
 =?us-ascii?Q?4gLPfp5SpucbhhbIgMgc85neWq/j48C6y7IkGT7Fu3m2iC/QV+ghcsxTBY3R?=
 =?us-ascii?Q?oi3AcUTeiHnn3wmTmqMMIs9Y+i8jIESHvbKh3gpP30SfJDC/2mUnt9cwWPRt?=
 =?us-ascii?Q?vSEQkD9cmzczymQLRZ6Tx6erYa4DvClkwmZXQFHg0WEPRuXNKhZVVL9hmdg+?=
 =?us-ascii?Q?xJvhVHG53go5XxvBRCgh2Ey9O+eYZhIAofl6VygC8AkKJ/NiyAsH/3UZxcrT?=
 =?us-ascii?Q?ujFsM+T1hFBpOeHA0Ij/8/FbHZOTpW/MfuEXhN/LONKjJz5ifk7aGh6Qoc5J?=
 =?us-ascii?Q?/UnAJ1gCWEWaSHkmEacSkQ8C5Xb0xGYaBBWXn0EH8SY7ENSOakm9Q3rhwmPz?=
 =?us-ascii?Q?Iv53V5P0nqG2W7NXxWILTTZXJ5mYyPV8x4Il+rHAhi5/BtAA9/c2hLEuAQG5?=
 =?us-ascii?Q?gVGWChUOsPiQxk+vgSSfbqnIuleaToi02vUrLxFFKUfCOhHNwD98uOi6lS3g?=
 =?us-ascii?Q?cMyL5p4pbGy7Myqf8gZXHeIuRqLhsbgPa2hK7ysDtnBAdGypyZaDX1nqFK61?=
 =?us-ascii?Q?KjFVC5eVHfbN4pHFGmySSKlNqzDyK3F60rqtxSbafEYiErVFb5uVo9S/HsUN?=
 =?us-ascii?Q?l4Ok1n1JdElkhnScLzMngzSwtTSodijR8CiX3FpQ2+D42VeWrCjqjmLx9nou?=
 =?us-ascii?Q?u2OOYY4bJ9a+AcCIp6R2K7rCXF+DcJT5D6CjOrL5RlUPpELYedHbtUI/qcHb?=
 =?us-ascii?Q?PrHbV0jjdIGrATE1V8DoIoIHRSELMwm2Xysql5GaxlsttxtOfeoQrjpPyNEC?=
 =?us-ascii?Q?F4oAkbFp/bijxKz1XC1pJlhZbfXupngYoJ2D0rtlXZeM6t1jSVq6brPUi2e5?=
 =?us-ascii?Q?nVREU17zYMT31PhgS3fcLC0bCri9Hu3NGh6RPHNiK8PYm5r53SR7+nVpUhhd?=
 =?us-ascii?Q?9PcUdJAVUle8euvb3Rl5oiuG9IJznqidlkA2bqPqLSmlbqmzbESXS5W/b1oq?=
 =?us-ascii?Q?iQRq4ExJmMRD4lpkg1QlwJgm/yNbqkqzZT+AEjucDYyIpoUxDCg0yH4TpOwo?=
 =?us-ascii?Q?JIWKntABUGLrdsm84u6Zc/Nzt6NrNg7lNd8VzkHbYqmrolzeaL9BvtD/A2BS?=
 =?us-ascii?Q?HgUjwb0nK0Hu6qRU3/EDRsH87WOlAtI+RJqiv57A25NBH7a/EZvfrzomgr/w?=
 =?us-ascii?Q?fr86Jy+WVjNb013iii+BZR1kugwcG82zdIk18vBFjctCqGD9tm1UDq9AhQf5?=
 =?us-ascii?Q?qgxkRy7mfaAG9qkhAc3LMPBOBaGLs/tplDsiQnOK2xeOWooOOfef02cBRGd6?=
 =?us-ascii?Q?maaeDeDyD1NpmMwaiDcP5HepkVqo5nIUVs4/NxUag+dGU4VDOv89ADUR9hFM?=
 =?us-ascii?Q?tqwRgQCklvtc+WVpOMV0wGXP4OKQ43B4fSjpj4/rhw60e58DZI+q9vz2teQ5?=
 =?us-ascii?Q?XmW5X7hxHdXNe/mwnFv6xUGRMRh+JapleZIwxW5Ak+MoVCHZFoPzEbT+W3VM?=
 =?us-ascii?Q?x/jE1iO2UykzNooy7ii0AZo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jp8XcGhGNxJUzGmlndoMTavrJEQAFGqwmIVcOAld+J7R9pNFbFOYUgAuCU1r?=
 =?us-ascii?Q?Q2BnhCAkEcA5zYQCNkvlDtm+evnptnKnVPLGsE/U8tB2dUJudaYWFD1imn4F?=
 =?us-ascii?Q?OnryBuHuqfPh5OmBF//q5YMoue9l6L/Q/X85J4YYwAOjZjXNn43izd2d8h/a?=
 =?us-ascii?Q?h3W1vO8Moz+DPikWJYMVVhkwWi7gMWAuB0RYrZUIrfy2uELLUa8Z0ZIEx8Ek?=
 =?us-ascii?Q?gYcuMsv7zC4P+lgxoeeBT2FBv4Gyx5na0xrq/fHWNjcFsHqRuRmM1S6r52r+?=
 =?us-ascii?Q?jM7MYRc7kDlq0S52no0IZDWaXwqwWCNM8oCeSLJcxT4Ez8J3pjGRrvWmWQlY?=
 =?us-ascii?Q?2FXQUN4A8MdeQoAQ+Spw6oeaPmaPPwO+HIcbm7Y+N1xGeT0NffjDNecOSTns?=
 =?us-ascii?Q?VBHzBr4c90S371MT81rvI3v6/iLCeBO/dIxaIPhuRrBwj6eyslOghBgxYTrC?=
 =?us-ascii?Q?rFco2IvHRRyx4D+CxUEZCcGGBwR1JeL7F9ow1JE7lVKcTxXagh9tsTyR8hs8?=
 =?us-ascii?Q?tjerFY/dJ6qAFy1m38rmefdhQJVGbH0z8lIRAlnewDzHcX9ePxT/uP7MLUq8?=
 =?us-ascii?Q?brob/Qvzh26JRRMVDSgINsVJ0+3ZqCUIMniaVzLUVjtJKd8a3ib/lQxO5jRW?=
 =?us-ascii?Q?ranGrX+TTC+LdRZqvuRRLtXUVOoeeQx94nYm300Q1rbmG4Ho4Rf2W0vJvm7d?=
 =?us-ascii?Q?WAdejOFv+uZt43zVemcZqG7WboWbU7wc6gO7uQlWdBJfPUNFR91Djz8DCnQm?=
 =?us-ascii?Q?Bir7T5oK8LC0Br4jC3F6dl52I9isi/5MnBB/xJ00zHNpcbVExBoqxY98WuNd?=
 =?us-ascii?Q?TulWqTLxj97b17KIGFeLbl+IDXU91BVHxYzUSji1JFrTg+ZqTuPzhyOR1Rik?=
 =?us-ascii?Q?AYq5BImbg9VLGDB2nfbUBCrVv1KAKYkVVTQpTumYlEcd1eFlqCa4ub3TDyFD?=
 =?us-ascii?Q?aEd4XxUYQ874qBqrT4i/wqmeQg6Y8EYi5cOJQ182QIA0KzL+Ld2cdRl63CFi?=
 =?us-ascii?Q?Z8CjYOGxTZfaGhcKJVmQy7qRBwY0nS8SF1+8m0QLp44EHB0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ce16be-45c0-4d5b-ba30-08db8d3d66d1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 18:31:46.2205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1CzFBHzzYLrRiP1EWVnjcCxFgqY68kwYUbHo7og1Q3WUEGIa7fQsERzxxvL5CrM2neEAfbYtI+KfpCb0+I8pogz9gOyttPGpncvYEwDkHT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7418
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_10,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250158
X-Proofpoint-ORIG-GUID: USRh1Kijn3wAYDCZP-UQa5Knq-ZjBiKw
X-Proofpoint-GUID: USRh1Kijn3wAYDCZP-UQa5Knq-ZjBiKw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Kravetz <mike.kravetz@oracle.com>

commit 16f8eb3eea9eb2a1568279d64ca4dc977e7aa538 upstream

This reverts commit 9425c591e06a9ab27a145ba655fb50532cf0bcc9

The reverted commit fixed up routines primarily used by readahead code
such that they could also be used by hugetlb.  Unfortunately, this
caused a performance regression as pointed out by the Closes: tag.

The hugetlb code which uses page_cache_next_miss will be addressed in
a subsequent patch.

Link: https://lkml.kernel.org/r/20230621212403.174710-1-mike.kravetz@oracle.com
Fixes: 9425c591e06a ("page cache: fix page_cache_next/prev_miss off by one")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202306211346.1e9ff03e-oliver.sang@intel.com
Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: stable@vger.kernel.org
Cc: Thomas Backlund <tmb@tmb.nu>
Cc: Ackerley Tng <ackerleytng@google.com>
Cc: Erdem Aktas <erdemaktas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

As pointed out in [1], this patch was missed in the 6.4 stable tree.
Resending this patch with a Cc: stable.

[1]: https://lore.kernel.org/all/20230621212403.174710-1-mike.kravetz@oracle.com/T/#m9e33a9ccb76e4db123279b371cff57d4e1a1ed3a

 mm/filemap.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8abce63b259c9..a2006936a6ae2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1760,9 +1760,7 @@ bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
  *
  * Return: The index of the gap if found, otherwise an index outside the
  * range specified (in which case 'return - index >= max_scan' will be true).
- * In the rare case of index wrap-around, 0 will be returned.  0 will also
- * be returned if index == 0 and there is a gap at the index.  We can not
- * wrap-around if passed index == 0.
+ * In the rare case of index wrap-around, 0 will be returned.
  */
 pgoff_t page_cache_next_miss(struct address_space *mapping,
 			     pgoff_t index, unsigned long max_scan)
@@ -1772,13 +1770,12 @@ pgoff_t page_cache_next_miss(struct address_space *mapping,
 	while (max_scan--) {
 		void *entry = xas_next(&xas);
 		if (!entry || xa_is_value(entry))
-			return xas.xa_index;
-		if (xas.xa_index == 0 && index != 0)
-			return xas.xa_index;
+			break;
+		if (xas.xa_index == 0)
+			break;
 	}
 
-	/* No gaps in range and no wrap-around, return index beyond range */
-	return xas.xa_index + 1;
+	return xas.xa_index;
 }
 EXPORT_SYMBOL(page_cache_next_miss);
 
@@ -1799,9 +1796,7 @@ EXPORT_SYMBOL(page_cache_next_miss);
  *
  * Return: The index of the gap if found, otherwise an index outside the
  * range specified (in which case 'index - return >= max_scan' will be true).
- * In the rare case of wrap-around, ULONG_MAX will be returned.  ULONG_MAX
- * will also be returned if index == ULONG_MAX and there is a gap at the
- * index.  We can not wrap-around if passed index == ULONG_MAX.
+ * In the rare case of wrap-around, ULONG_MAX will be returned.
  */
 pgoff_t page_cache_prev_miss(struct address_space *mapping,
 			     pgoff_t index, unsigned long max_scan)
@@ -1811,13 +1806,12 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 	while (max_scan--) {
 		void *entry = xas_prev(&xas);
 		if (!entry || xa_is_value(entry))
-			return xas.xa_index;
-		if (xas.xa_index == ULONG_MAX && index != ULONG_MAX)
-			return xas.xa_index;
+			break;
+		if (xas.xa_index == ULONG_MAX)
+			break;
 	}
 
-	/* No gaps in range and no wrap-around, return index beyond range */
-	return xas.xa_index - 1;
+	return xas.xa_index;
 }
 EXPORT_SYMBOL(page_cache_prev_miss);
 
-- 
2.41.0

