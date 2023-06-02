Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB26D720C20
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jun 2023 00:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbjFBW66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 18:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbjFBW64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:58:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758EA1B9;
        Fri,  2 Jun 2023 15:58:48 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352Hf5WY008205;
        Fri, 2 Jun 2023 22:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=UX2zF7AAbNcFJFaE0l8xuRYwS+0ZT2DTAUgvTYkzDio=;
 b=xg1nOnnpTVS1yVnIUw+p0CnOQy6/21GwWinadd1I6zhq3NFEVG2ouEOYmEkQIF6Qw8uq
 PFEVqrwliw1QmNgn9uxgllZr4+K6DJGc5LbYcKFk/bFY3KxfUmAmRSgurCCoRe/jCx5D
 qeimUw+iVuZZVy38bIIm8i+Mvi+tk+usU4Jp5uBxdCDvwzYNB33ivE6Clhod+R+jSO9S
 Wm95hdPqH1K5FuVCsdae8WsK1ct2JIsntYAFigqTLHWukB5uJAvgFmO9HE16frExwZ2c
 r5s66HLuw10dGooRxFO5BwBWHq6MKLUWyYJZ5RerYZu2ilCJEAMWQtROF/2osVj4AaRS Dw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjhbxka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 22:58:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 352MCUZI004640;
        Fri, 2 Jun 2023 22:58:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8afrys7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 22:58:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6QLwCX+ovq97NPlYBzomOgM8BeNo89or4xut6LPM286ezWwxGxRliSwRmnkxvEeEs37G/obgiaVK4vGOtLIbUjplKCQRaNYn2BMPBdzrzBWLKg44ZTCPHtj+ka1+FE73mT8pWgH29mtinPpDhMxIpyd/+2r8qSUxy46qUgbnS6nQMXWl1wFDeny3zPwcHGysUqYC8fJ5dzwZYMHqgGX/4jjYZiLUbBk/SX/oC1uv19SScpCOK41UATtboAlSgAqMVjD2Iu1tWtkirWp2L+p3U3aB7g9G9Ev34xpn8Eg94N7IlWro/BTxptL7JwTWNYMgymJcsGd+YZFOYCCk66BkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UX2zF7AAbNcFJFaE0l8xuRYwS+0ZT2DTAUgvTYkzDio=;
 b=ZqiWPWeRliGysZJ50By4ob/lhCVTma2yL5PoyUp6RSe/kcp0qVBxKJx/baYHRq9FlIg+OyVScU8j8tqa59Dmzw38ZeZBDoV8iTcA3qqmfXt0lwUQSaiX5Xpwz78NaC7IJ/vy4D5ktqSKzOClqrvKKAdekxmLUM6u8RBlBDvx+PN0ANA/HTWxImTi5/+5sNs2UKbYP9e0V4Rz9dEUbfLUFe2IPzPMCXHViHUFDbKTdUZO/gjUWWJFlWWwiuAeJME5qr1OsTcJ9Vg0O5MNspYlp4t50y1IKQM6xA4T3V0BeGbs87eDfzYTEr+rySxyjQdYWpZSS/J2zP7MEaFUjcyvDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UX2zF7AAbNcFJFaE0l8xuRYwS+0ZT2DTAUgvTYkzDio=;
 b=djhC+iA4fFcEyAUH+oWChOoT4cZ8CFUz48GtoSX+y1gXMWhleQ+7a291ADiB+cpI0hen8+9z168AWH2ZrqctqmrWbs+qfZenHxzeHpuydrLeawzKVRmDhxrtjjunsfHV9gV0ENnG7mPemFkXEblQiqUqbdcw35Ra1XxU0Ciy1xo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA1PR10MB6519.namprd10.prod.outlook.com (2603:10b6:806:2b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 22:57:56 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%6]) with mapi id 15.20.6455.027; Fri, 2 Jun 2023
 22:57:56 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, vannapurve@google.com,
        erdemaktas@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 1/1] page cache: fix page_cache_next/prev_miss off by one
Date:   Fri,  2 Jun 2023 15:57:47 -0700
Message-Id: <20230602225747.103865-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602225747.103865-1-mike.kravetz@oracle.com>
References: <20230602225747.103865-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:303:b8::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA1PR10MB6519:EE_
X-MS-Office365-Filtering-Correlation-Id: f10cd4d8-36a0-405c-591e-08db63bccdb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SDVJXKr1O7oi06BWIMl7y43QxkefYtdJyajFX/XJXMLtou5otllkGafvITzdl0x0KXk5n4uiHrc5MyoHSkOJcmj8Dng/OZy/33sUPtipg0BZj+dDpT5OAx18e3Mh/rY1xBUHprdIICz7k+3wA1e6c35r++fRE4ALAw7HC1qdhSLFQJtnecjNKPcT3wiQDeRB+jW8NqqYb248DA+pBfPC4u3vwOTZcUwbhEDOuDINzw2mh/uMMBMntTplYuilebViJdHrz3NUCAI96e0572oG4PgWuuqlrfbIZC+XAWiEW/h001pQIFEhU8F/IIPgGK9LbMEhygnDYZKfpJsdaEEnO3y4J764eHL33jpXwKMomOrkiQDae8pUngAZx0zETu/LFgbTk1DqT+GxL91QmvXUwl0utS3CCqT5OBv3c6mbXbc35lKx8gYhXfEqfMtvC57yA2o6Uty1qPYMFbZY12Zf0AY3+YXwTmwvkUCme9VdYtdj9FcZzvtqauj2ed7CbEeD70QoNB3KyocESrFlP+RB5dv/13fNQecH/ZO95YNQLKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199021)(41300700001)(316002)(5660300002)(54906003)(66556008)(4326008)(66476007)(26005)(44832011)(86362001)(66946007)(2906002)(8936002)(8676002)(478600001)(38100700002)(6666004)(966005)(107886003)(6486002)(1076003)(6506007)(6512007)(186003)(2616005)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8RrIQJig+8nQ+FsEd0UBTTVf9dxD5ZzicEpVocn3sLu9ZpdO3F8EkOh7e5UJ?=
 =?us-ascii?Q?R/PnVuUAOkhwH1d1o+462DCUKM7BT1jYPFi2T2Zjpmdseq1zx27MJxebi+Vp?=
 =?us-ascii?Q?ZVVnbtjyoUZToacIY5jk0QFgtwNOja7SPDHW7u2yyywA0tYBRYdoxu/HM4Pd?=
 =?us-ascii?Q?zaw39gl6ABFMvuFVuAnXZpdL/28gI04yj8fKjDdBpfZTAKYOrRRUKzFN2wnC?=
 =?us-ascii?Q?glQIXnK767g0VU/hcA/SDehcDKdOHYCO5KbTxs5k8l5/mxec3N+vVV+j0jYr?=
 =?us-ascii?Q?Utm4WjlPsFQP7NKZ0n83jD0hxbP+jlmxDRIAqmOobdtOPe9L0yVnKHbebN+c?=
 =?us-ascii?Q?iDO1aUKF0fMAmSlR90sd2Te20nZyvZid8Wn5D2gmt4GKZG69Gz+pPv5vVcWc?=
 =?us-ascii?Q?7aCe6gYz09KCaEecnyNoye9WRZ77WLSgKq783/uUyEkgeHcFGlf6+ph7a5DB?=
 =?us-ascii?Q?CrJJfRP/crgc6lhk97zC9Y3Cx2Cgy4VqucutY62BBVTF4DeQvjYl+UfgDsv4?=
 =?us-ascii?Q?ItnDfb+nHtFmpZviJr3d2OBUutVQuI24GfiIsrFXaDsxrQR1qLbpdE0Y5d9I?=
 =?us-ascii?Q?/i823cw3Jp/9ZccYhcL8L4ik85kk2gwclauDwOrLi1BQi3Stsc/N4rw9WxMW?=
 =?us-ascii?Q?FXpCmDY/UXHFXAYG7fYJlCrJr3+3ZMP25MBUWk7J/ZVzk2V07EqIzyg35VF3?=
 =?us-ascii?Q?5kj6IYREu/NdoszxrGHKb96enMqZCvMjOlY8TNBatWZSIIABGTQ/2TqI9iiu?=
 =?us-ascii?Q?YIv0oDY2XiMlqBv++XPFTsmsbT5pJtRhET6iiOOEiQUMwk67II2oJ5pxpkbg?=
 =?us-ascii?Q?nqaxw2Etobn9SGOzlJ8mmOqlvfBXeBCvZH5qD0nMhZy8su9idvxkl7jsuZqn?=
 =?us-ascii?Q?d4XyhhM6qkZkVVtzOJk4NuCXyMANJr2v9olMW9yUikJjQNHUr4QQcaPyLrMK?=
 =?us-ascii?Q?Wjw6fwqE+vOiQFTOpJ1IEuQ/15Xfe7YKysDfkeOW2tZ4S3EuZGUJMdqxWwSg?=
 =?us-ascii?Q?amkeW2EUtxm8pK3936PQO8aZr/3J6+nlA+YakTeiIwQZ7cUOEQWNXFfoW9gq?=
 =?us-ascii?Q?osEcsjnEeE4cfOLOGFzH0DOMW+fxbr0iJsIkc7Um8wGea4OmYlbX/MTN9YMO?=
 =?us-ascii?Q?0cDyUDGeqv3ezI87zvW0845wK8W2oCCyOLqc0vEG6BlPkabMC3lBwTZWrUqW?=
 =?us-ascii?Q?3/e73xUCz5xpFqoQkU3WzJF9puyPUzqdVnzHy7QxRIcsxy8o+th7OVEuVO0X?=
 =?us-ascii?Q?cwv0iT++ewlBiLqEn8n2LxtkTw8gllqvWMDH3p2f5WrYHEqGRmKMv8DuD5dx?=
 =?us-ascii?Q?8YCR7J94P0F+82yHdb1UDhi+m5E1IYYflpPPAWS5p0wpKF3lu9MmumWpLwWk?=
 =?us-ascii?Q?MPexpNBHfd2Ypkh35LvXe05s1sF5jHhgiJ3lNNQ4H0L/WLKLPGQOLd2Ko1MB?=
 =?us-ascii?Q?gZ3NU6Putw7p2+7kc2k/39QmrowhA6IzK2Wj7VVxP+ZOTW0Ay7onzag4Xm3v?=
 =?us-ascii?Q?QQZ0cbagcxlhqPjoBM32f2VYxSnC4J+cjl66QI3CJxDmCuRFqbH+WaghCpzF?=
 =?us-ascii?Q?CIqvsfMzCjucmrNdwKgKelWt4LZ5NGs2P6mGkuf8UY0UOh7j40772eK4Z7EC?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?n9WBZ+lS/sBg63e8wTzw1ZZqxn1z4ntdzf0GS4e8ERNm1NdBIWzaO4J8V1ZZ?=
 =?us-ascii?Q?MgZsUiAl0WGSgzJ16P5UFPcRPoYhy2hFhZ6WPfXhg3Fh3VjfpkKgOsKDuEB9?=
 =?us-ascii?Q?Q+Kd08AClGLiNTdKWc1kJlMQmN9bLaTyGgfJRZN2GAx1h16B3ui6UYF+PplP?=
 =?us-ascii?Q?vbwBKq3TqjQQboIplENr+0WN9Nfo+wB0x0gWeV8OJ8f7cXfYBaU9pIiXdOhJ?=
 =?us-ascii?Q?rNa9ayvieaZhnVjZA8d+ur/ifttuou4CmOJEJDi3Gu7VL4MpaQVlkFh9XeWY?=
 =?us-ascii?Q?nFn81UWNf18si2zkAPjm4XFGkq4xeljPrj3N7X8t6W9m+oQkoFzhRREODa1d?=
 =?us-ascii?Q?YReC58STdpF4F/NBJ2Vh73Gg8aJmM9E96ajFe8A4YnHOhFPfHm5weENdSlJL?=
 =?us-ascii?Q?InVyq1IQPDFi00acQYgDJKRmFOlVDlevDUCp6mGMygBxse0IgppVi+JT+8YO?=
 =?us-ascii?Q?O3GgVPuCtZbB6DwzoVpvGamHqZBhpo04YbGgBDPfZcCK3iOYoXCnqrxUb8xx?=
 =?us-ascii?Q?vX+/EhCORj8WKbfee+ATp0FVX0OEoSKzVsQocMetTWvlH93XvplQ3pztHAOJ?=
 =?us-ascii?Q?qOentZ0XEvbI8rwsFaPVGfNijkH5mBZMGsiO43cAfgh80cPUk/lpIC6K2I/S?=
 =?us-ascii?Q?x7MP7a7XvtXMh82DDNyaXKhIoebCAvuHb470Ph48E8G2tPnwJ7vKwJ3ByIUz?=
 =?us-ascii?Q?CFEvw/DeFn+x0zRuh/gO+FxyGk/Ts6G3Bl9zW4NzhzhOQrKiXpNHXW4sJRmK?=
 =?us-ascii?Q?1qXXunBPDtvCNbbOkwEb/kDxTQ+tmkggnHA05aztytDuKZRl+l75Q0lgh7ko?=
 =?us-ascii?Q?IeSknIdPhT4lKDvxzj/tooLbl8k1pYuFcKdmDAXppkoDB/O0vuSV4yffWL0Y?=
 =?us-ascii?Q?E2ChMGGVazxhR+UR4s+C2U6P6eL75SZuUVhCBiALsekeIshfaeyTVMMFZH/w?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10cd4d8-36a0-405c-591e-08db63bccdb9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 22:57:56.1045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5Q/3ofeT6U82SbO/v8U4r7cHpC1xf/226v5A7vE0hfTFB5hIZ2JOL/2E5DnRBDEL2Z0PSe0O837NE47g61hlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6519
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_16,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306020181
X-Proofpoint-GUID: -lqIgs5IfhyMUgG4BmkCOZm1ml9_72Gf
X-Proofpoint-ORIG-GUID: -lqIgs5IfhyMUgG4BmkCOZm1ml9_72Gf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

[1] https://lore.kernel.org/linux-mm/cover.1683069252.git.ackerleytng@google.com/

Reported-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/filemap.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 71dc90f64e43..123540c7ba45 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1733,7 +1733,9 @@ bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
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
@@ -1743,12 +1745,13 @@ pgoff_t page_cache_next_miss(struct address_space *mapping,
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
 
@@ -1769,7 +1772,9 @@ EXPORT_SYMBOL(page_cache_next_miss);
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
@@ -1779,12 +1784,13 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
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
2.40.1

