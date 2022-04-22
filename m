Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF40B50B470
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 11:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446314AbiDVJ6H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 05:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446325AbiDVJ5x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:57:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8300BE3B
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 02:55:00 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23M8oN7p019412;
        Fri, 22 Apr 2022 09:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=pQYP/DBTzZgVomg5w1AEYPhJm9/megcCvAs46kYOqu8=;
 b=cwvEdgrtZPGO1KjU9AOzzEVyLdu35wMGIsueKX6/AYehwJQvWtlblkPwOB84WDNv79Cc
 VV7yfKknKiBkoekzV1EgD6zeEEkWJ2PPfRJFFaFRkGQ1SmRpgJEy+SnRiiQfwOzQEY45
 lOg/1QRCsp/cQqq/PcY9gJakF+l+8ssv/BvjruDmxePl+CdKC8fXyLVE1WyHN0lJoW8w
 bp92XHYOxpvz10Lp38zUzdMHo6EcM1WONANoX1qXXCYYTG14oL+Pw94/BmIIvdPK2ACo
 xSsQuNm9u+eA6cSOoJRDnfr7I6CB9kcTwEMHkWzq2Jx6VkbcJsOBadcG/1Mf5dF7aU1Y 9w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffm7cwxnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 09:54:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23M9ov2q005670;
        Fri, 22 Apr 2022 09:54:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm8a5422-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 09:54:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMKiQj3EJIv50Uf2mYT+cEOw5rZjZj4sRLHMokqAxWw4HFhoLxF+Z97Z0xxX4hHj4qqNgfYVLS8Wgod5BQjEFi4jEEfYeADb0+gmcknLTXpxaAdYKo9uOR20qoRlJGJj6YxuDNDj6QEObRgUER/0mMTzIB9Swws3ogft4gl9wFB+cJy7z2z2DwD+NadWWW8pMHKzs//tjS2tzA3siLxlpO5/hclDLm3+pgr/93ILMtDvQcMYhQO1wq9RvNqxNHn9ma9np03vOLwDTLUKU9/EykBHIBY75LGBZa/gjOQ5BHzFp9b/zw6RDb/n/fzyIANA1aEZlwAqJa0AR/K44qhx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQYP/DBTzZgVomg5w1AEYPhJm9/megcCvAs46kYOqu8=;
 b=Dj8PxRGv4QTCo+ppI3GdtohsXrKT6XP59hWIN6U14WaBshwhzmk05K1/PPmVGdIcdn/c8RAXi7z/6qxoxmi5r58Q24cHtGGeRledKqPI5zzZTNH0FEnlMShDkod1GjavG7VjZfIR8p0ipetuowhWCUKF829vpNdEwVcvPwtZeSrTF1z4LXpMTUan7DNduo/21OsCBVDEwyzd9RvRCYsY9hCXpAhRRf/7EPdc9KyXBjgs/Cm9s3QEkQCH7Bbs06kOU8TXsYTM05kJvByRbzTRUbMNJ8m8/9nm7BhsF+JHeisZdP8z8objSl2xwW/wgLcekhi3xHmm5fmPHfG2o6889g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQYP/DBTzZgVomg5w1AEYPhJm9/megcCvAs46kYOqu8=;
 b=ZQ5YMke7G5WIrWKz1+a9rYwJkrTBq/i+2oS/5YppsKGi4gS5yAVS/tL1d3IA5RwwyUuaQOszPZHjtI+ZgwBDez1y0htHWmDez3y1ELozP4ZDIbuRFJcDGs3s1ZLUNK99SFq01sUMUtTioOUSsN06e0VAqsqXZ0cdZNuf5OWri7A=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA2PR10MB4713.namprd10.prod.outlook.com
 (2603:10b6:806:11d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 09:54:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Fri, 22 Apr 2022
 09:54:48 +0000
Date:   Fri, 22 Apr 2022 12:54:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        hughd@google.com, akpm@linux-foundation.org, amir73il@gmail.com
Cc:     lkp@intel.com, kbuild-all@lists.01.org, viro@zeniv.linux.org.uk,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] shmem: Introduce /sys/fs/tmpfs support
Message-ID: <202204200819.72S8HjcF-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418213713.273050-3-krisman@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0021.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::33) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7239d607-c36d-4072-bec7-08da24462308
X-MS-TrafficTypeDiagnostic: SA2PR10MB4713:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4713FEB63E10915E11BD8B268EF79@SA2PR10MB4713.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1mKwLvxY4Rthmuf5OqF5sgJgALLRKLHma7W8S/HOUCOfcQexpO/nGRoX8eYYi0n2y3+1w3zReu7slS1L8ssu6c2wdBBgxLsRsL8M7Iy+pM8ahON5k0AFYKkFP7PCO/rlvLaCLJKn7yBHhKEv5pgRwrzq3au3UuIkJLevHlCZDZuLhwxx2T7THDd+YF4StWj6i7fhzxPqzpfVGsh1nfpV45FwYjhQyTQPZ3ChFUhSKH1Is8kViqwGPptBSYju4al0AaD8fwkVzT3dyEB1XJh1rzqL83r7X8sNTb7UoGZsJ09NYCgO10i28MR7AdXiLqmUf7F1WzPkiWTtRti8vfDL3b46x/kyt1BFCaxnqQIiqAFKSaaFSsfIle7KK0dEpqUgioBrX08o21hm2Ub6Aa1aTP0aJ9hWHGKbZfHtW/mFX2hqWoZ4hmPdhd3IRMxJdMbqk23FunWua3jiqmaFyO1K9IfFcbbwUALfYSKTTCdnwHSweZq/uwt3JjpP47zRZvbKA0OGkX5ALkkwQ9V3ujz+xdtZUU73A6o56YZeHDD9pWMgdI+sgXVdicvB6U+7wVovd8i2j0u/BmUCVfYCUF90cHBZLMESCXIGECL2SbBanZ1yVL0WbfrPavQt3eYSZp0vDwOa2iJVOxOTepo1VqsOG9QcC95cjsz+5Yhy+VIuIn01ge2dXyIY682xTLelXO9lk6QiR+czPWFoICRpSwcUsYNsCskc3BKW9uhNOPiASKHML6e73doKuJ3n3R2LwOdwNF4MNasYHFZVmV3wrScg+aoykqoqCGw6uEVgTlDFQ4lj3VMfqVXhsmAsMzfg38Az
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(4001150100001)(6506007)(66556008)(4326008)(8676002)(26005)(508600001)(8936002)(83380400001)(44832011)(7416002)(6512007)(66476007)(9686003)(5660300002)(186003)(2906002)(966005)(1076003)(6486002)(6666004)(66946007)(52116002)(54906003)(38100700002)(316002)(36756003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SvWTSTWCAHOQgOGjc0XLndTHLjdZSYY+62FozWra/Ph5yaRDsuBdepuZZjvJ?=
 =?us-ascii?Q?bPN2WqkfUBkxtUynzrvps7ztZWgKnVZrfwXECcba7t0N1jZD+fwXZmh6qmYG?=
 =?us-ascii?Q?aSnN5N4Du9oFj9ZPEbI2Rkr8VJ48RfuX2pkgjxb9GBv+uopTOMEXjUf/5tW/?=
 =?us-ascii?Q?OItYFMkq5oalfM6po5S/0wAOV7C4E8jrztKQll55U0YsWw5n9nOgJ82ZlYRd?=
 =?us-ascii?Q?aK9DFK/ZLasAEMrS/kYz+8FvoS3eCWM3yzPZ9oDkW5/1G0OOZyFDZvxK6j1f?=
 =?us-ascii?Q?fu/MgKVojh9j6Ck+H4BbJSx9ME/E/gGD+wiRe378KTSBK3TfEzZ9rFynxZu5?=
 =?us-ascii?Q?yZ3MGaazvdXuPu4T/awMHjbl35KpXzMZET/Gjhk44zgBHvxlf0Bs7ZcJOWG7?=
 =?us-ascii?Q?NSipzSCuGyDgq3IZqTr6GZTmgHcadJjqS0WNaGg/JgZmse+SD4Hrcbq1/sIF?=
 =?us-ascii?Q?NQOjd9ANRb9aF1Y56DZgN6gphcdzv3q+PzHLJhMqLCVfXwLq1L4Yl3RxUrHD?=
 =?us-ascii?Q?Uct2El/iCVSHI1M4mjDJd2xOJ6vFJ/OOLuGMG5X9H1jfSaS8kOzpcgpTi58s?=
 =?us-ascii?Q?U9H4Dgqrooy3LUIuc3s0/lSlb8QUY6nNn9HUhyLinKF9CuAtl7puGC4nl/LS?=
 =?us-ascii?Q?lG161APdm9IA38fx6JErjnpB1oGCGXf0xS+j9xyLdbH5wRKSj+Yh9LOk3AOm?=
 =?us-ascii?Q?HdWCPdcjKZobnzUYOm8WbwqHSNUY6+5JkouFAoDZj2dT6CDAx19nAw5p+gYk?=
 =?us-ascii?Q?LgWrBCV5TK91XhHNGNKbsx05zev4NutH92YehJb7XdhBM3PH8Trl+uzMl3iK?=
 =?us-ascii?Q?Un5vCRmBx7tP+f2pnbnJqtEx8GK3zmndgcejrTfXoalEqLgTWf1NvGPHakvk?=
 =?us-ascii?Q?SF8MdsaBajy9M7n1e5PJS4i8FbguyHriy6VOUH5uvfja54o9c8YFUrYC4aRQ?=
 =?us-ascii?Q?IRWAOmYbNoRWhjXeS6iqplx05e1TPMCkKdVQ1CHQR0+GxT+qTA1doL8VJEY1?=
 =?us-ascii?Q?jt9/uEZQZ3dtvykTQAaEjDCTDFqWdj1EXGYMI7B61EsOpO3Y7Nooult+AWMU?=
 =?us-ascii?Q?mKV2n58waeCa+wV7YVhb41LYZ/vT4dB69lIbjgLvvVSecZqNG0yYZ6wvfRtP?=
 =?us-ascii?Q?yZdw8Nzvg1enjK4NLhoae9GGNgqaKy9IJFm5C7mERGJv2bzAYb2M4IJdmSNb?=
 =?us-ascii?Q?0dybHtdfpfb9l1c0U0GQMAQuqGVbZTmF/AKU1na2VWPgtp0pdlhPCEUAHmLU?=
 =?us-ascii?Q?K2ZhDKw4iSb2hnGkbiJ4klefqLRcGzy2pb8zVUjvE29P4A+gehHH0JGqxr0R?=
 =?us-ascii?Q?OLnRZ/t9bxuknVnb5cA0jsCmm4G8lnLlamrpB7aRam0HBWpZ3U4G/Slb+41D?=
 =?us-ascii?Q?WRx3n9aoj+flitavATQf4NLwXHMwu/UrBysduMQoG8bANr9rdDCXwvOcfgno?=
 =?us-ascii?Q?39w+KUw29jMF/j12vyQ5eW7KvC3cRUQLwQumNMyA6mXyJ0OeUw7KBbwXRcjM?=
 =?us-ascii?Q?zYUJk/q0freYjEWh7MJAakmZofvW/yGueXcRrx6oyYy1Qv3R0sYMFLry7ibN?=
 =?us-ascii?Q?83Ebt9T+kHGybZ9u6ZAOZp8NzpmrRA5/xvtF7m39EiuNe2uAnl8+DrYSteXg?=
 =?us-ascii?Q?wzE6XBbvNY2XKWq6QQxxxG3mKyVFDg2fQp1UyjVnrZbEuR67kpNC7HlbL995?=
 =?us-ascii?Q?SpkOthdFekfBfU8gK4ONFVE6RDUluM5UrY8MmjQ7gggMbrQILf3tOXIg7uYT?=
 =?us-ascii?Q?ZKur9Pu/kUJ57iSndIPCdXtN+2f7rkw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7239d607-c36d-4072-bec7-08da24462308
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 09:54:48.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghNo5grVg0q8pB2wa6n0UyFi3wZXEY4i3U0wFPMxrKBOFukzML2C4vfThTUH1VaTxJT7ts2jz71t4ABNuLIe+Cjh7Bz24p3mSqie1UkY7pw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4713
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-22_02:2022-04-21,2022-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204220044
X-Proofpoint-GUID: yYc1Aecyi7zJQ9Nk9SmdS2LNyY6KsqZO
X-Proofpoint-ORIG-GUID: yYc1Aecyi7zJQ9Nk9SmdS2LNyY6KsqZO
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Gabriel,

url:    https://github.com/intel-lab-lkp/linux/commits/Gabriel-Krisman-Bertazi/shmem-Allow-userspace-monitoring-of-tmpfs-for-lack-of-space/20220419-054011
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b2d229d4ddb17db541098b83524d901257e93845
config: ia64-randconfig-m031-20220418 (https://download.01.org/0day-ci/archive/20220420/202204200819.72S8HjcF-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
mm/shmem.c:3965 shmem_init() warn: passing zero to 'ERR_PTR'

vim +/ERR_PTR +3965 mm/shmem.c

41ffe5d5ceef7f Hugh Dickins            2011-08-03  3928  int __init shmem_init(void)
^1da177e4c3f41 Linus Torvalds          2005-04-16  3929  {
^1da177e4c3f41 Linus Torvalds          2005-04-16  3930  	int error;
^1da177e4c3f41 Linus Torvalds          2005-04-16  3931  
9a8ec03ed022b7 weiping zhang           2017-11-15  3932  	shmem_init_inodecache();
^1da177e4c3f41 Linus Torvalds          2005-04-16  3933  
41ffe5d5ceef7f Hugh Dickins            2011-08-03  3934  	error = register_filesystem(&shmem_fs_type);
^1da177e4c3f41 Linus Torvalds          2005-04-16  3935  	if (error) {
1170532bb49f94 Joe Perches             2016-03-17  3936  		pr_err("Could not register tmpfs\n");
^1da177e4c3f41 Linus Torvalds          2005-04-16  3937  		goto out2;
^1da177e4c3f41 Linus Torvalds          2005-04-16  3938  	}
95dc112a5770dc Greg Kroah-Hartman      2005-06-20  3939  
e43933b9793ad3 Gabriel Krisman Bertazi 2022-04-18  3940  	shmem_root = kobject_create_and_add("tmpfs", fs_kobj);
e43933b9793ad3 Gabriel Krisman Bertazi 2022-04-18  3941  	if (!shmem_root)
e43933b9793ad3 Gabriel Krisman Bertazi 2022-04-18  3942  		goto out1;

error = -ENOMEM;

e43933b9793ad3 Gabriel Krisman Bertazi 2022-04-18  3943  
ca4e05195dbc25 Al Viro                 2013-08-31  3944  	shm_mnt = kern_mount(&shmem_fs_type);
^1da177e4c3f41 Linus Torvalds          2005-04-16  3945  	if (IS_ERR(shm_mnt)) {
^1da177e4c3f41 Linus Torvalds          2005-04-16  3946  		error = PTR_ERR(shm_mnt);
1170532bb49f94 Joe Perches             2016-03-17  3947  		pr_err("Could not kern_mount tmpfs\n");
e43933b9793ad3 Gabriel Krisman Bertazi 2022-04-18  3948  		goto put_kobj;
^1da177e4c3f41 Linus Torvalds          2005-04-16  3949  	}
5a6e75f8110c97 Kirill A. Shutemov      2016-07-26  3950  
396bcc5299c281 Matthew Wilcox (Oracle  2020-04-06  3951) #ifdef CONFIG_TRANSPARENT_HUGEPAGE
435c0b87d661da Kirill A. Shutemov      2017-08-25  3952  	if (has_transparent_hugepage() && shmem_huge > SHMEM_HUGE_DENY)
5a6e75f8110c97 Kirill A. Shutemov      2016-07-26  3953  		SHMEM_SB(shm_mnt->mnt_sb)->huge = shmem_huge;
5a6e75f8110c97 Kirill A. Shutemov      2016-07-26  3954  	else
5e6e5a12a44ca5 Hugh Dickins            2021-09-02  3955  		shmem_huge = SHMEM_HUGE_NEVER; /* just in case it was patched */
5a6e75f8110c97 Kirill A. Shutemov      2016-07-26  3956  #endif
^1da177e4c3f41 Linus Torvalds          2005-04-16  3957  	return 0;
^1da177e4c3f41 Linus Torvalds          2005-04-16  3958  
e43933b9793ad3 Gabriel Krisman Bertazi 2022-04-18  3959  put_kobj:
e43933b9793ad3 Gabriel Krisman Bertazi 2022-04-18  3960  	kobject_put(shmem_root);
^1da177e4c3f41 Linus Torvalds          2005-04-16  3961  out1:
41ffe5d5ceef7f Hugh Dickins            2011-08-03  3962  	unregister_filesystem(&shmem_fs_type);
^1da177e4c3f41 Linus Torvalds          2005-04-16  3963  out2:
41ffe5d5ceef7f Hugh Dickins            2011-08-03  3964  	shmem_destroy_inodecache();
^1da177e4c3f41 Linus Torvalds          2005-04-16 @3965  	shm_mnt = ERR_PTR(error);
^1da177e4c3f41 Linus Torvalds          2005-04-16  3966  	return error;
^1da177e4c3f41 Linus Torvalds          2005-04-16  3967  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

