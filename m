Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6422D6F79C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 01:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjEDXjm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 19:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjEDXjl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 19:39:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EE0AD27;
        Thu,  4 May 2023 16:39:39 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344LxTvO027934;
        Thu, 4 May 2023 23:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=GLq3qI2Yxv5HSwxpOHjg+O6jlpfkeBnZRt5doMWQYRk=;
 b=utKOeqcnSKL7U0EsscMT8wurcwPnd08UQFxbEVN66NZRbXKMEJNskLRlplgPHTBnX9DL
 d5oAw2NCgH3ZxXKnWY+C6u5GLXXvHoHKaU/NaMU1f/THopVvJoMPCimXfsJ7Y7dtUcrc
 9EcQzHsFOiqmZMSsYwKV51XEJwxf03L4hGjP/tuIgX1FjwNy01TeFhGXMxKJyEos+229
 BU/m8zY/hM8xTeHGzb1yatUGDI1WTxujDL353Ocu/YR/q6GH3TrqYGmMJE0PAEilzNJ/
 W1TD2Sw3154Nyb9hn68AjSsmgc9V/DjmFkh4XRnIWDpLkbHiR04H/+B65dzhOc8+Y5ms nA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qburgbfh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 23:39:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344NccHo020736;
        Thu, 4 May 2023 23:39:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp95wc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 23:39:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWkGwQEOBRHFeFOtb/1Bf31zgefqvdxfL8Kf74mD2RzqD/5tu+X+vOJ9n4lsXE5JxFbhlCQ3Zyo8Q8xTgysAwi+ffyvJfzkLBBiGASd+I77Vu/u8UbwdEO7gD59D09eIgoDWetuiCiSFC4Vl7iirC/laNORgSftWOzr/8hcWxoxNleMe13uTVRW9W9OhorjB/SrXJoljm9aMKib4koBJaRKt4PA9Se3b6KpOLWdc06tf/UYv5LbeY6vbFKTq7tNV0t5jgTEvnko0iU6O5AgRXeekF8GHLD+1c0F+41LgofqgYbuAEBH2RTY/Vr8xHxEbBpOqSi6bHf+U3Co5lvQyuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLq3qI2Yxv5HSwxpOHjg+O6jlpfkeBnZRt5doMWQYRk=;
 b=SkDtycF2If6b4PvQM62M6Hv5evnAt3mzxIYDYOjacqMrFKCPMaixq93GPPZzl+M6vzfx2LpSYB+O8nd6dThbvupqxWjL18jiCl1dyxKAzAEf1GUI6sD1NrF3EPIRmqe94cCYnHCT+H4A8+Agxs7vhnjQ0ai5F66PzTT9277bEJ+8+4/JICx9HsEnbkPVoV1S9VnqmkSaFOLayRhQEq1962JfM1ZtLkBu7MAjQsxwfDYpmUmWd4S0eKIjpf6BWc/fRxkeepNcahyIMiM7oO4zn0XV7fOUS4e/XswD7606TSBATyHHe/1azYX0buXOThQ8E3CXVmVUXHpxyLo/5WhKww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLq3qI2Yxv5HSwxpOHjg+O6jlpfkeBnZRt5doMWQYRk=;
 b=n/5vQjJ1vYQNRoUBR92v0oqaqWOVm6i7JNdQjVKDFUuYCrGJmMjxCZpjOLA5sSyVAKS2Ftw8mAgVqqCh1XkwK9Z2C9GUTO5KGxqvdBD68Pe4sDvVLdhohR4JrefSYA0h/ai3QH3LbPT1hJLuSC2JVbagBU9e1YxXvfWt75dGIFM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4706.namprd10.prod.outlook.com (2603:10b6:303:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 23:39:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 23:39:08 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, vannapurve@google.com,
        erdemaktas@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, stable@vger.kernel.org
Subject: [PATCH 1/1] page cache: fix page_cache_next/prev_miss off by one
Date:   Thu,  4 May 2023 16:38:58 -0700
Message-Id: <20230504233858.103068-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230504233858.103068-1-mike.kravetz@oracle.com>
References: <20230504233858.103068-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWH0EPF00056D13.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO1PR10MB4706:EE_
X-MS-Office365-Filtering-Correlation-Id: 07263c40-6768-45e5-2fd5-08db4cf8c193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GB629ZNoFrq7qVvKqPaVP0nwmRjEGnS5jheF9tJ9YsLp0qLnb9EUHt8dA7u3oMknVhZfEy2TboboveX0+g4l0EEhlJbeS9orMvmcb1QNuDV8Jb5F/uHkTnpEbqf2giovbl5TArjX0Z0eEUB01hb9Udgq4XL8k1UHED6aRxhEaMDgjIYHJvrJ60NFi7O4VesbNHnz/shVk97G6l1cqnlGWVgeC+Lctm18/eS1spYP+OOoor1ZRFmVTXJdQE9TLKAAUNYP02cPYKjzEQQNgr1tD19NvDcyqBeE4wkGnIwgSP5Ry/xKPTc71xoVGz19v6YegVWCv0rUxGUYzn1ac6ESHjyPNq97ARirqaSgQHCcEBkMt9VB2CM+BmdqDDIr7aGMYlaPuv9GFDnEWg6h5JPlhYshNJXwOQ/4F64JMI8wtgYs8SvMfwncJcanBCOX6yZfwTRCYkPaehiHj7/YfhWLN4srVGlCU1OjpXYaXOIaNMHVqpQDH+4dmYFgzXy9SlHGBwDL3aaDm04fJjug55e2rOcWXnex2ioviK7JyEe+Hus=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199021)(66946007)(54906003)(2906002)(478600001)(5660300002)(316002)(8936002)(4326008)(66476007)(41300700001)(8676002)(44832011)(66556008)(38100700002)(7416002)(86362001)(6486002)(36756003)(6666004)(83380400001)(186003)(6512007)(26005)(6506007)(1076003)(966005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OaPoHvgFScspsVPcEZY8R30HvPiouIZNHdny4QCqPYFqGMkNTOr7f4reXwDC?=
 =?us-ascii?Q?TQAlmtwNf/fXl452kuBx/ct4U7MCfalIBLaxxhYGm/1czmYlRJdRI3wNlLCK?=
 =?us-ascii?Q?5gZKFpIFFY3xqCdsWUwMUxWm4afdGB2iewCHBuKsXuVK2UoL0Vu9s4vW7BbJ?=
 =?us-ascii?Q?7NtiVyUS9RVSC/wcpU0Gy5O4XjvLpuaudexRsggqo+AcKsP2C0jcfQZ4ZZp8?=
 =?us-ascii?Q?BRubH9v9ikRsCVe0sMZwqoCvRVW6UA0ACrZStfJEeX4TCUzRz1kCaqCAIsB1?=
 =?us-ascii?Q?Jaouw9nE2AeiDm2wscmYD9Av4v74SAmunuva/MpbMs6U6jBqjklplTxEIl15?=
 =?us-ascii?Q?SgbPNAYgjSXWV3d8ky04nUrrnpYov1EEannHZclMhcoMV3p+X17t+QmTvWme?=
 =?us-ascii?Q?TTfXcWDgaCDkHODk/AZ5M7Uvhjn+IxCKDCd7sav7UCoRLP+nQmRJb2AgwbOg?=
 =?us-ascii?Q?jqpYFgkcBlioKAUuZx/6/y+McKNV785dZ7m/uMeVNcnuQeRcknFEO+LxMmXg?=
 =?us-ascii?Q?T8f6JTNx+3CdjGbUjiGBe+zRjXsrE22nU06HG11lRxnKqNa+eNDT0ZCGsoVS?=
 =?us-ascii?Q?TbU1nIDiqSRMlTUra3FkJVj9wJMBATkdDGfKV5n28xUusvaGe9uNjBmzxVhW?=
 =?us-ascii?Q?4X71Qke6lK3xXyUdkyZfOILeHmh3oTMn876c51wFjmfGU/nkXoo6hsM7Y3xc?=
 =?us-ascii?Q?1/pIW9XOhCAcUBBIOnbx2O2TZarDo/AhKEG714+EDSqtKEHFp+IlSxUZIYWd?=
 =?us-ascii?Q?uU0ZmqmzX7+V6bxeY572NKNVQliFoi/ctafbV1VvTnjHo9FBDSgjswr8C4mB?=
 =?us-ascii?Q?nxDGs6Zn1WahZ4h+/LjH+nR32ObJU+Cu99SR7lJPn5XqIAjcI8jngpOCvTlC?=
 =?us-ascii?Q?efLYcVSNm/PjYhHRKtNWvbTL4hDYsjtoVxSiKIkDE8SCKHRKEoz1hUKMr9gY?=
 =?us-ascii?Q?qxlOzoUM2l7cY3TQ3DR38lS0Gk12knjzuC3pvDUfOwqlImYOioEz0WAZP38i?=
 =?us-ascii?Q?8SYtkXA0Ax69zPKYZjKkFHT5sGrMYUhHhXddjkT82NB/WRCJiR63dJ4FN4UA?=
 =?us-ascii?Q?yh88veGqF6WJ6IC+Pc1oTBCmPHQNQC8zgk/EZ6mZm/oQ0VanMzfxATeW+tW9?=
 =?us-ascii?Q?XkR+v1tsP0iO56s+bjkqX1/ZNpAEYPxuAYaNH12MEIvflBxAcgFM5FanukDM?=
 =?us-ascii?Q?XWje6Wkyk+Dkkwjd2hDhm7+8IPxZxU4p3GX7hw48aIyR52F5JYgF0myLLLPF?=
 =?us-ascii?Q?UlK/eEt/V0r+kj1UOpu5ZxucJ52j5vsgmZ89iq/0wZpL1D8oRIjKD327cXyv?=
 =?us-ascii?Q?cSQs2fg1D3WWzI3DIZgZRiJEtai74QpnAwla/+tOIWWQH3Bbs/fAvHAZliZ8?=
 =?us-ascii?Q?M8E1SE/U3GjIQ6ni2PrRwvlMUZkqzy2M4F748UTHWCRAi03KL9tQEHVOA13A?=
 =?us-ascii?Q?7XcIdoEQzA97A9HCJMhuvHRTYB/BXlzQyv0x9F8ns6P9a5MHx6WJQj0mwqpz?=
 =?us-ascii?Q?SgqBZx8KUhVMBfisKSNb+nMYGqxVMINzn0cZ7QPxGXMPsDc5njDTxiaTKK5m?=
 =?us-ascii?Q?dmfoEzEb+giGxMHqFIqvS6PixQazIF1xmJhpXOcY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mQMjqMTrnDUicjk/2ib1pbS1BjCsRfnvjav8+pR6daJPdUDE/JmzG1lbnC9N?=
 =?us-ascii?Q?ho0uZXBhRPwYtxUgR6pfqb1F8ZhD3ivlhW2/XpLBiYc9s0viuVVr1nWwB0gx?=
 =?us-ascii?Q?9/KPkFgWi0RDj5faOw4G44Ip4Y9lblA4ZmRuOTO+2oeM52PLutgH14UIji/x?=
 =?us-ascii?Q?6F+OscAV/NAYXMwgKrYAm4Jrmwlg6yBIBzXT9zLxFyNSZV+QytKHqtkS7E+G?=
 =?us-ascii?Q?vjfkUwl//XtQXN6J8vRG4dmhoAMiJIxkNCW2mwMbtYl57eSpc306qDAKPe9y?=
 =?us-ascii?Q?vGEjm+botQeBgUuDFSv/cTm31slUg3pViA2Rj+e5QqVs668wbdaUAIXVhm31?=
 =?us-ascii?Q?4os5TDXzRGFzm6+MKjcqcXXYncPHJ2YkmvohX87lOX5TBN/oNZkxhGF/JlW6?=
 =?us-ascii?Q?v6LJUYjniEzuqGTPMipD+KggZ7CXZDD08B5HmFv16pZ9CgkkyrYd/CEZYCwq?=
 =?us-ascii?Q?3PePn27M13/tS9Cvd/AVBMCQ6jE6G0zUKu8iWkuLlllUQt4ZmRgqhYrrBiwX?=
 =?us-ascii?Q?W/VEJaSErPGVrK8JAajwzrdF/5L3q6nHv7tdjWbSPh93Pff1WN1yhag/NCSl?=
 =?us-ascii?Q?Z6TlzAGFctZqxOZ6jDuBpwMEp7GXwCA44Ibun4rC2RmadwKD0Psw7IcILPD+?=
 =?us-ascii?Q?HJvBd73UY5sIxQwt2ZcEbtofHsF+yA3RShQ837Bn/+b3VATOTdbo8zsQqUsX?=
 =?us-ascii?Q?Vy53LMoHEds2pgaUTaEcIhoMPUwo12KrepLRDM2HuSeOjlIih4Nr1xUA/8uP?=
 =?us-ascii?Q?Ejn+8W8RhU4tl3jer2nAgyWbKzLs96TNz5xfGwlVTrbG2d+zWY0EZjkx+iyX?=
 =?us-ascii?Q?znGe6LM1xfDqlhqsqJBfhCsTLPbR25X78Wxz9acvbCP4sks8EBsC+EPhlsPP?=
 =?us-ascii?Q?VpidDli5TM+g3G4Q2UfN5df2CfMfECLfgeDAeWTysS67RZOv939yPwe7w4bo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07263c40-6768-45e5-2fd5-08db4cf8c193
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 23:39:08.7440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: auXNcPTzhvyzpl7J7SllsZpfgfCljkrbvqHMcP98ZCh+Qr1ikCXB7u2q7+0MsDjLp6aULkSmskkU9YN0kQx/fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_14,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040190
X-Proofpoint-GUID: DlpToA6PPbKGyarX5I0qZeoGjBI21U_K
X-Proofpoint-ORIG-GUID: DlpToA6PPbKGyarX5I0qZeoGjBI21U_K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ackerley Tng reported an issue with hugetlbfs fallocate here[1].  The
issue showed up after the conversion of hugetlb page cache lookup code
to use page_cache_next_miss.  Code in hugetlb fallocate, userfaultfd
and GUP is now using page_cache_next_miss to determine if a page is
present the page cache.  The following statement is used.

	present = page_cache_next_miss(mapping, index, 1) != index;

There are two issues with page_cache_next_miss when used in this way.
1) If the passed value for index is equal to the 'wrap-around' value,
   the same index will always be returned.  This wrap-around value is 0,
   so 0 will be returned even if page is present at index 0.
2) If there is no gap in the range passed, the last index in the range
   will be returned.  When passed a range of 1 as above, the passed
   index value will be returned even if the page is present.
The end result is the statement above will NEVER indicate a page is
present in the cache, even if it is.

As noted by Ackerley in [1], users can see this by hugetlb fallocate
incorrectly returning EEXIST if pages are already present in the file.
In addition, hugetlb pages will not be included in core dumps if they
need to be brought in via GUP.  userfaultfd UFFDIO_COPY also uses this
code and will not notice pages already present in the cache.  It may try
to allocate a new page and potentially return ENOMEM as opposed to
EEXIST.

Both page_cache_next_miss and page_cache_prev_miss have similar issues.
Fix by:
- Check for index equal to 'wrap-around' value and do not exit early.
- If no gap is found in range, return index outside range.
- Update function description to say 'wrap-around' value could be
  returned if passed as index.

Fixes: 0d3f92966629 ("page cache: Convert hole search to XArray")
Cc: <stable@vger.kernel.org>
Reported-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

[1] https://lore.kernel.org/linux-mm/cover.1683069252.git.ackerleytng@google.com/
---
 mm/filemap.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index a34abfe8c654..60875d349a7b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1760,7 +1760,9 @@ bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
  *
  * Return: The index of the gap if found, otherwise an index outside the
  * range specified (in which case 'return - index >= max_scan' will be true).
- * In the rare case of index wrap-around, 0 will be returned.
+ * In the rare case of index wrap-around, 0 will be returned.  0 will also
+ * be returned if index == 0 and there is a gap at the index.  We can not
+ * wrap-around if passed index == 0.
  */
 pgoff_t page_cache_next_miss(struct address_space *mapping,
 			     pgoff_t index, unsigned long max_scan)
@@ -1770,12 +1772,13 @@ pgoff_t page_cache_next_miss(struct address_space *mapping,
 	while (max_scan--) {
 		void *entry = xas_next(&xas);
 		if (!entry || xa_is_value(entry))
-			break;
-		if (xas.xa_index == 0)
-			break;
+			return xas.xa_index;
+		if (xas.xa_index == 0 && index != 0)
+			return xas.xa_index;
 	}
 
-	return xas.xa_index;
+	/* No gaps in range and no wrap-around, return index beyond range */
+	return xas.xa_index + 1;
 }
 EXPORT_SYMBOL(page_cache_next_miss);
 
@@ -1796,7 +1799,9 @@ EXPORT_SYMBOL(page_cache_next_miss);
  *
  * Return: The index of the gap if found, otherwise an index outside the
  * range specified (in which case 'index - return >= max_scan' will be true).
- * In the rare case of wrap-around, ULONG_MAX will be returned.
+ * In the rare case of wrap-around, ULONG_MAX will be returned.  ULONG_MAX
+ * will also be returned if index == ULONG_MAX and there is a gap at the
+ * index.  We can not wrap-around if passed index == ULONG_MAX.
  */
 pgoff_t page_cache_prev_miss(struct address_space *mapping,
 			     pgoff_t index, unsigned long max_scan)
@@ -1806,12 +1811,13 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 	while (max_scan--) {
 		void *entry = xas_prev(&xas);
 		if (!entry || xa_is_value(entry))
-			break;
-		if (xas.xa_index == ULONG_MAX)
-			break;
+			return xas.xa_index;
+		if (xas.xa_index == ULONG_MAX && index != ULONG_MAX)
+			return xas.xa_index;
 	}
 
-	return xas.xa_index;
+	/* No gaps in range and no wrap-around, return index beyond range */
+	return xas.xa_index - 1;
 }
 EXPORT_SYMBOL(page_cache_prev_miss);
 
-- 
2.40.0

