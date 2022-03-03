Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586DE4CBD08
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 12:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiCCLpv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 06:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbiCCLps (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:45:48 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82C23EF2D;
        Thu,  3 Mar 2022 03:44:59 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2238ZIDB003629;
        Thu, 3 Mar 2022 11:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=sYYeJ1k9niXYGD7+ZSmy0+2xLMsq/d5AfM8m41QBrAU=;
 b=kfEooVRHnF9JNYbuTdMXm7BDeEq2py8qktyPIX3L9gpW2qWI1oAMlS3nWwiEK1hHwPP4
 XMzyMTXWHVVW5oKPiifS/YSNzSPXdb3jFj88ibUAMx9QQtiOejOEcFWiCcT9c+5qXnHW
 xBHySV/eCPX0cB6+0qp2mWwPYSz/5yG81RkuwjW2WvfJGYl3MtsVXU5BL0qyacAVbQM5
 BzxOVv7CD2tcdl+QL6A1QpfbtGWs3jA9FI1/EDU57nA1BUcOZEx6FZ/X3RmmfomLIxDE
 VZrSHqJkdI7hgtes12ZiP22QDvij1hZItQYr4Wv00MO8+duubU3YAlH3PIJFEJA83gRH +w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehh2epfh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 11:44:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223BfbhQ154294;
        Thu, 3 Mar 2022 11:44:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by aserp3030.oracle.com with ESMTP id 3efa8hxh7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 11:44:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfNA8CBdT0Sp/kVNXM6seCaK1smUR3CyrDNAEu8H2MpmM0DVDY35/kTbIbmgV7+o+kz+S/vAM+/3Sv1YMa7vR11LYgSaTg/JSNVPFzFYGQgQk6fDoMpp3ZOMB5IC+9f/ZyVOD3D/1qn1d6iXSbrrb3Dp9VNSc54ZoH8bcmKuTkO29SJ54UJe92kTShtY8PhUaM6yccIhv+xr3/eCNaUK4rF607RU7qfvO0HkCNfk5KKb9OLxh0HY6mpEzjfmRJoFkJd/Pvp9tJTF0eM8z9k7snCy5MRog9nVXKnOm7kfUX8aA9INQ79oaUmZa+ClncnMY0gVO8kho0RwbxXisOqriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYYeJ1k9niXYGD7+ZSmy0+2xLMsq/d5AfM8m41QBrAU=;
 b=LnYjyCgDNOz4R3/zh12FKNj0pMDD9SHiqp/G2+M7KEm+HZQ8oltYgVkOQeuLh75WlgZGctifwNefpL1Y0Tn+bYNXoqk9TktmADrPFyt+XrxX679l9fCgY+OVXRQZtzZRTXGUL4eYbJOu2QGs7DJKCvpCvqMc6BR9Dq2P82wlwTRbnVoqvvRsAkrTyI65x8jULi0PFEFDiv8zEK1J+tvVe0UK0GlReQCQXzcaMG7+RU8AJWr5gwSDWCFaWXpyzTW2XlKwsx3FRjS0OVgIHlljYk+JTT7aGeF2shnkd6rgRH4dhive0ePBII0uf+9Crc9inXj6RHAC+7UyUIOVy65jxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYYeJ1k9niXYGD7+ZSmy0+2xLMsq/d5AfM8m41QBrAU=;
 b=aIA95doZqsyV4H7OlD2wj0AYnTykEbSkqotnlPT4nauynC5q5y8DRVFb/vahSqVGszwC9oaysN0TKGtIzoOQS8dG/GU3mLVD58P5g1RMqYpRoE4JI52S+xpumlkpsgHcbwjXIicoAn3iMzsGoKWXSTuXSN2eeUziy+t9CW2uKxE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2646.namprd10.prod.outlook.com
 (2603:10b6:a02:aa::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 3 Mar
 2022 11:44:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 11:44:29 +0000
Date:   Thu, 3 Mar 2022 14:43:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Yang Shi <shy828301@gmail.com>,
        vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        songliubraving@fb.com, linmiaohe@huawei.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com
Cc:     lkp@intel.com, kbuild-all@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] mm: thp: only regular file could be THP eligible
Message-ID: <202203020034.2Ii9kTrs-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228235741.102941-5-shy828301@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0049.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:31::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99673b18-0f42-43c2-8075-08d9fd0b2d31
X-MS-TrafficTypeDiagnostic: BYAPR10MB2646:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB264600CE43EF4D1563CD746E8E049@BYAPR10MB2646.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wg85Y2ztwpjkdUXgDGnQo0h7aUN4MiiOxdAJSSaMJSrgBwjsSzlr3rZUQBUh61O+TacJJR9pX1yYC3drSNQWw3596jd/wiWYIuS2vjWP/cdWqIOHlwp6tjGkoah6dPQ1ON+dUa9jE81/tTmgtAvaIQStkyxQYJVMPfvxC29Pa3ZumE8lAgb7Z7l+fUFvhJ2yfO/Z1RyVO5yzgoeguMGkinfctlHuguiC4ujIDFz1oq9uezLyHeE+ZBfnuQIpfzBhPYnKVQXuL50ecfFG8XHnLuVez54E3DFl9FlatfxvIdDvx8zAZmay4reY+qYbxFyAFa+wCIzYCq4wDLY2+HKkiUXrG+UC5iuvVlU0SL9VPrPCtQ+1HyPJDKQyoJfC25sSzWtb397dVQ49HTu78u3Vx5on0w5E8cS3Mc+U6dwy4Ld785UGENj0nOX6r7mRiRvbuNpS9DCbZRgpHr1Oo1I1pi04GxnjBYzfb5xP82aUquOz/pXu0EJYvXYsJSJLjycDbgAVMhBRP2256klLhiXBPwd2QZC5sptO065RQ6jVtYhOFDrUM/u6eDBwz/wLXTWgmqpxUfM1sp7iWLgP6IMS/sKNq74kcy2AQZM9VCu/rabGjywN2RXf6qbHTaQdxBmug2tycX5ZpMwbLdEvvM833JOMHK6kTUv1g8WVje3jpAJB+0UkeUjybKJOFefmHwyh6dhp/t9CFUwQ/6QsmtZSTYkAaL8hEJUeKIwlrwFxpRercPLtYDmcIMareGzCiQzidJFii5zh/gCRMoGViCIInT1NdYBoEK9M96POyf2buT2rbRAO+s/m8BAKJTbpegyKdMBiMXWIUsa1hvfo7i0ARJFotPnucYCK4VmA/p52f0k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(9686003)(6512007)(2906002)(5660300002)(8936002)(1076003)(8676002)(7416002)(66946007)(66476007)(44832011)(26005)(4326008)(186003)(86362001)(6666004)(38350700002)(38100700002)(921005)(6506007)(6486002)(316002)(66556008)(966005)(508600001)(83380400001)(52116002)(6636002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u/8pcs106ir03pneBq/9XzuVSSClg6ZjojxWxi32wml7lzZI48xOvo6at7Yw?=
 =?us-ascii?Q?vz1HlSWYyMeNNp9MSQ+p2mOLNzkGl5AbwKyFLMgDxug5tbDaUSeQ/V/SmmGc?=
 =?us-ascii?Q?dXQd8QiROoNt+ST4VTJ5+5omQ0K9E6YFqNdY8dKJVxKTbM23+SCgJjTygZRM?=
 =?us-ascii?Q?1YU1NRKnGIOIaj5msKLmWConfflWZG3C87VP6KPeO798ZYi++DGFDQLoJA3f?=
 =?us-ascii?Q?mYtgJOwrVQ1Lq2Vx5qKL5uaKqWuTuf5X1NGO+BSR2TtJxp2q4UpxXjs2hZTl?=
 =?us-ascii?Q?KWzPwGcoszgwYT1UrbQVBP98Ye5NprUSNlxzaMTal/TnDMG7E3YpOYeLveQL?=
 =?us-ascii?Q?cB4ixONdhkz7r0k4bcc5cYeXFhuGpO9j2HZDUQvCchMX7oIBDMUezgrO6fXL?=
 =?us-ascii?Q?CleJ4CGlQNqQZ/gXIz0MxyPE4IiBFROAmYj4K4YOUHJqT7WprFoNEUFYojLJ?=
 =?us-ascii?Q?gN9/Z5uWJhPJ1EJrwQmjzQH0p2FW0Xa/6k+WjtDjXPu5tPMJoU4xYPavSviv?=
 =?us-ascii?Q?lIcHnj2T8aBsVZ1tJBIFM8Eh8LDd9UauuZVvJoYb75OLgMQ6S7NSfBmYixfY?=
 =?us-ascii?Q?Ksm3S5PpO4AasZqAE51Y/DuqPKwl083xpyZPfifYJQy5B2Ra6mkJpFx4I5TC?=
 =?us-ascii?Q?l9uE4D8EPiotIP8HddqebjVGRVLuc03NlW8U7ZUxULKcAB/FqPcyvFbp28Ee?=
 =?us-ascii?Q?29iU7KPhUuYfQ9klfGK51nqg9vURSL+uaQ1W8tkZLezemylqN3z4h3GU74eD?=
 =?us-ascii?Q?14bfUyVBBGq+5at6WUPZ+70DaZgZ3kv/i09RZwzOqhIk8VeIcJTAnrlVOfkv?=
 =?us-ascii?Q?cL4MeIYs+af9zjeHuYmaolKXSA4sq89QvLtCXzioe2DQi4UQbhlm39L8wqEQ?=
 =?us-ascii?Q?YnHgSGacXGIvFPS/kTkr6Tv6ZvY01eqE64MBByz88OuoPvueQeXWwI2dQGk9?=
 =?us-ascii?Q?9eT6of+9IjqByhlZNV2q7V2S89GvuqHcrk5AR3EekMdQMO3bi1p5baxFp6GN?=
 =?us-ascii?Q?eo0zQIQNM6pyLKOpxoqBJ/274YhsHJXwCIf9a/2gvKG/3JOYlktWE2wBSFnc?=
 =?us-ascii?Q?bXZYRjSD9OdFO/bVtMZ38TmSJy2vvEJFtgb9S817pARMf661IqSJjGqd2ni0?=
 =?us-ascii?Q?mnwrQlwoMqcmRctwbL5JyDxzMISTNZsuMv9r9wnAC2u5M9VuJS5TSRV4m+uM?=
 =?us-ascii?Q?Mmtv3UEja36wpUc5Vh0ec/JQzaK+HtTbhTvbRP4QlLX0TITDb2OBlE0rPyri?=
 =?us-ascii?Q?D35j+PEK/EtAh/yvxFKi2NH+Hg92lfcdb6gLwqfEpzR4OElxR7Ebz1Rx3DB+?=
 =?us-ascii?Q?CKMm+JGWNYPifXlF7LjA72k4CkYck3XGqUsNGk4/qlNyXCSwnAwasfQRbeqc?=
 =?us-ascii?Q?lAxtPrg+VnBVQpK+7ccTUbEcxpIP4pdO/nHcfFTZdfWT9XADILKyrrrj0w+C?=
 =?us-ascii?Q?7Un/iA1dCfzJAhGFARaHb9GVftCQSuALumEKvL0DbDgwPPDXL9dBKRii+1/Z?=
 =?us-ascii?Q?lk4YfIL1LW2ihTjGz7nKdReVc4mXPTlfU92NqQ8NJt+fS8LRJlHJv9jWLSnx?=
 =?us-ascii?Q?GSbE7dpxOUJIGyRF6A1PtfkJiubKJKG8xId/hW2CA3kpNdlttzug2wQtihCp?=
 =?us-ascii?Q?Zo5Snci/SMBuzJ2QBtrs0icjl19lJ8tiyFsZQ4kR5ZKG4UQiR/8T59TmxAa3?=
 =?us-ascii?Q?3wtMZA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99673b18-0f42-43c2-8075-08d9fd0b2d31
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 11:44:29.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGYM8wR0lzQLy9wf+WCWZEFddc9jKfEa8T2qRL6lCnJ9WqDLe/bVYEdoURNh/j1Ai62HfqmyOLelY9+hKeNOWEhDV5p4tI9mI/k3HQkCWOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2646
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10274 signatures=686787
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=862
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030056
X-Proofpoint-ORIG-GUID: oJ3hnQwkr4hx2gm-2r0yhZwe6poyy6pz
X-Proofpoint-GUID: oJ3hnQwkr4hx2gm-2r0yhZwe6poyy6pz
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Yang,

url:    https://github.com/0day-ci/linux/commits/Yang-Shi/Make-khugepaged-collapse-readonly-FS-THP-more-consistent/20220301-075903
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: arm64-randconfig-m031-20220227 (https://download.01.org/0day-ci/archive/20220302/202203020034.2Ii9kTrs-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
include/linux/huge_mm.h:179 file_thp_enabled() warn: variable dereferenced before check 'vma->vm_file' (see line 177)
mm/khugepaged.c:468 hugepage_vma_check() error: we previously assumed 'vma->vm_file' could be null (see line 455)
include/linux/huge_mm.h:179 file_thp_enabled() warn: variable dereferenced before check 'vma->vm_file' (see line 177)

vim +179 include/linux/huge_mm.h

2224ed1155c07b Yang Shi     2022-02-28  175  static inline bool file_thp_enabled(struct vm_area_struct *vma)
2224ed1155c07b Yang Shi     2022-02-28  176  {
2224ed1155c07b Yang Shi     2022-02-28 @177  	struct inode *inode = vma->vm_file->f_inode;
                                                                      ^^^^^^^^^^^^^^
Dereference.

2224ed1155c07b Yang Shi     2022-02-28  178  
2224ed1155c07b Yang Shi     2022-02-28 @179  	return (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) && vma->vm_file &&
                                                                                                    ^^^^^^^^^^^^
Checked too late.

2224ed1155c07b Yang Shi     2022-02-28  180  	       (vma->vm_flags & VM_EXEC) &&
2224ed1155c07b Yang Shi     2022-02-28  181  	       !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
2224ed1155c07b Yang Shi     2022-02-28  182  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

