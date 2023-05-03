Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06886F4EFA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 05:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjECDFz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 23:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjECDFx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 23:05:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0087F1FCD;
        Tue,  2 May 2023 20:05:50 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342INwLC004910;
        Wed, 3 May 2023 03:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=N4gCTDMM6jCEdDnhZVPopiJ8UafE8O15V4BFZ74/ME4=;
 b=G9gif8B4Xe5UuQuDDYD4w7O5gYufohb64fK2AbZj2um72q5mzrjmsqT4orQry7mx0TUY
 CrJE8qagM5FzYZaR2dPLBCDrw1lQbmjMubQf5hLr7GoGDzCdyG9xLJYg8vKU/k5OGH3v
 661RDDoaFPHAPBCobzze7BmwctyUasufa7S99HqPsvHuVgiJ6kKJ8lcqKHASg7h7ugnv
 XERYNN0Gx/pU8wJBb9lUyLdPk+p8cG0UmVJ4IABQ2es62Uujhch7875kp+oheSne5L4B
 N7kD1MUNVOnVaj4dxnL7EMki8VYlthz7GldZUZFv0j3aqLgQfFLxI79sURse0IAvwJPL iA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t13x9pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 03:05:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3430ERSl027434;
        Wed, 3 May 2023 03:05:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spctvjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 03:05:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLbd/6TuC3pSxcsm+QyxFCeiPe1KeeY+u/7rclWUwJGolqNWznAYRbqNn468jLeUjBiQju6nvcTtmWXYShKp8FcBalTTlMtsAJDde0by2ph4KKS/iiLhR3xggp8hiFTe1LkGBsP8uTzrlUaBIK4DuoP8LGo18zPfjkjOnCr44jbHUGaumKP7YPHl2w0E8gZ/mOpXGQXtRLYFUSKIpNvi3a9vxLjPyz5kKs4ePZxFJMY36qsUa8oyOHWR8gQNvPF7DZJjdOrrvocePH1AwInurvM+ShJ3g8H0r3f7zQlfGw1+UeBSeGIK2JpsFEus5wvldM9m23sGA5/M48dG2VD4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4gCTDMM6jCEdDnhZVPopiJ8UafE8O15V4BFZ74/ME4=;
 b=BnIlIPqoyYKdewy7IKExJ6HlvCvf02/o36ZQXThr7B9pYUHjBb19F4amLbWcMVb0UQ9IhH1h8IH9qaQOjHbhJScBquO2w5vWYdC4Dtsf1Yb5oAvQ0JSkoXiE6d1OooAZsVk2mufzkFxx77B49Suc6x3uw+SnIANlJplsw2QF11j5DY0rnKT4cRQ3XT48FqbuNtjDWd6So5xha2X7KXT+fGhZ7jDjA2VWhjgLj4duy53+kFiIVegvgXcvdSR0/1YlEaYiOM6rvC+r+ORPGVFnHZ20HNfwvUqFFArdRcVPg2slZwBhDb0oBh0MdjO38xb8Y1FpmJ+R1nnOuv5ZhTRdqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4gCTDMM6jCEdDnhZVPopiJ8UafE8O15V4BFZ74/ME4=;
 b=Ryn3fMgifAcaAGFWhufSgIZGKDPsqZ2n9h0AwIqJUT/pU0I2T55fOuvqWvyyrzE10YdUZXe7neATkVGi4HkPM0/yaPBLGRUVQodDfuMevVQqxh/K1cpsl+FZrUzUAqUac4CLPBcMfBTrTW9d5SqD4KzwMP3mMC/GQt1H5nyH9uY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ2PR10MB7669.namprd10.prod.outlook.com (2603:10b6:a03:542::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 03:05:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 03:05:31 +0000
Date:   Tue, 2 May 2023 20:05:28 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Ackerley Tng <ackerleytng@google.com>, willy@infradead.org,
        sidhartha.kumar@oracle.com
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, jhubbard@nvidia.com, vannapurve@google.com,
        erdemaktas@google.com
Subject: Re: [PATCH 2/2] fs: hugetlbfs: Fix logic to skip allocation on hit
 in page cache
Message-ID: <20230503030528.GC3873@monkey>
References: <cover.1683069252.git.ackerleytng@google.com>
 <f15f57def8e69cf288f0646f819b784fe15fabe2.1683069252.git.ackerleytng@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f15f57def8e69cf288f0646f819b784fe15fabe2.1683069252.git.ackerleytng@google.com>
X-ClientProxiedBy: MW4P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ2PR10MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: da92e58c-1949-422c-d4f3-08db4b83417c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fpSe6mo92IEPzXB95qLEk0kxqJ8fhyyxqiYATl4VfnhgHvzeKtfwI3G5eHU9quXz9gnCJ/bGhYO5KpxDbI1IX9f40P/5n86ZLYKeV19RmZD4BTLGrqYbMwuDur+DcQoTL6vYQ7/1ah8Ot5/bSfWJvyoFWoxDOXrbIBb9bCMVnL1u+O+CifYzQeEG4wW8ic6fbgEdmaWzJyeNUPOgyGT+E92cfDNX9MfxcEFPvjUcNe2LD3KvWlqNjCt4ETTOXHrDbEudjmXGVzhNqKlXDOfzajX/iQnf3zFQ3qZip3yy9eLnomfs4y92QUCuOQ7aZJQesBiMUcXIltkVmf7zo9jXMPRM1VLT+O0jkbCO+OVxHTVCqKMFfRgFmrm/RiBmnyauYqYNP4ugz/x5B41QzKFmQWPg8GvRYkU8fXQN1id8GzfdDo7EhsDNAmBE7q+Vly5ezYuJ7ax8SPIevfBFHuFx6SkO3ok45XTEYwjNwWU5ytyvA5F4ATDhbWwWN/xaCufnM8z/nsWC5BtNxSD/x7OVT4eEF5TSMJHKuyWZptnQQJ5LNORlQxOTJZtiohR0O09i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199021)(66556008)(66946007)(66476007)(4326008)(6636002)(186003)(316002)(478600001)(33716001)(6486002)(33656002)(6666004)(86362001)(26005)(1076003)(6506007)(6512007)(2906002)(9686003)(38100700002)(53546011)(83380400001)(7416002)(8676002)(5660300002)(44832011)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D8aAHfjeJSl4pSpugx6YW7AcKoMPHtzhEuTFFPYHwNaT2bONcVXn7OlvRZF5?=
 =?us-ascii?Q?35mQ3QERK09S+Bkti32yWkDCm7BgPEN6LmhHt25OGjMF7uk3ZRBDle/lRmoo?=
 =?us-ascii?Q?+FqANDMtgqyBVpJ+S1f4EyJyJE6T1Rvb99WnTVLCDYl4e2qOE1hWoJSUWpHp?=
 =?us-ascii?Q?1pfFJMZ+05QHMWMp/Lrgw4pnjxjGfoHP7CvqF2GT4r3sm/OaWUWVt8+jpoV5?=
 =?us-ascii?Q?M4e5Yn54kh2vZwP5CekuZ6XWSglkQZUKwAa0vyAszejmYEV60Xqt7ypOR+f8?=
 =?us-ascii?Q?9Vh6vfoi8dxSWjLDihk7hMtJqVoa1hiidRJrA08sdvA29Orpv/4QrpTz3yAy?=
 =?us-ascii?Q?C4s903U4XY9u+fWyL92z5WZqMujiBF23Fq9yba23XOOCui59bMA+twrwmURF?=
 =?us-ascii?Q?L/EPvlXdbj4MWUHRUPY8ob1bYd7nWzHCtLb4E2957pnCu/jrZ0gzmnfNNPcN?=
 =?us-ascii?Q?F3tIVZDTH8puqZZvrpEHAqjcreZn6axIXyjDF1RedALQ5u6g6IXy3wN/2Pv9?=
 =?us-ascii?Q?YfBXWNIf0ddNd5vEGCSI6F6ZL4EdDq78ygXrZ/cy6R1mWK7lM+cjmUC6Hx+V?=
 =?us-ascii?Q?q8eqTQ5aupR3TzG3Crsj3VkjBfUcoc1o3+sHte1uSz8nLfA0PjagKFoLMaiY?=
 =?us-ascii?Q?u1wHAuwsBTop07uOD6CUoYrfuQGJn4Gqdwu0mBUlHb6E3XXcUQpzCvFSrCDH?=
 =?us-ascii?Q?M6gIvrczXCJm3p2cb0c9EpBG5QjnBJX/HZQrtRMP5fPQirBL8ijUtSC5jSsX?=
 =?us-ascii?Q?0wowh0Fbbu9XQQhuPoMQxahb25mxeEZ9ofyCYHvoY94GtFG2xz8467NmiM9C?=
 =?us-ascii?Q?Sg7Zbckz0xRyDz92b3aen/xw5OQf+ml7ZgZOE41fCg8m8KdPRu3xKF0UP9kI?=
 =?us-ascii?Q?TDgWBH77ZX1REAsxyegG3PFmQtR5lFoOynTzCHswAnTOSjc0UTTjpRthR6oF?=
 =?us-ascii?Q?tuIt5RvkdZ9YgoVouDaKy1LWkZgXfMbMyY+eT35lTYE41hEF2BYI8p5AKiZC?=
 =?us-ascii?Q?xrquakLGkHeUKiNywOgAEj245Q3xR/M6Ljw+4WaY4F4lD1YTfyjW/Kf6HAXq?=
 =?us-ascii?Q?G0fX1lupHfQahj2awJquppEDrIrulz7KngxgE6BrGR4Erj/a/a5uW6df1j7e?=
 =?us-ascii?Q?6zGcfzVCc6HRABI+4UY/PU+A2dmMaw5v9qhHwjd00Jv4VU3HBaAv4JXrB/wJ?=
 =?us-ascii?Q?zYCvEY6xkTqrTlPBcrTYqSeTFVds0TrSDc03NZmzCkCiR92ISes3Fm5GetdR?=
 =?us-ascii?Q?yz+lIsMnBQ1C64WDHYw0p2OUt7pS+ZJO9VdqzkMF/neBQOCuvtmFqsqu29XM?=
 =?us-ascii?Q?0H9v1Rd+20TFISOIEy6Iim5FSZikk/hCIyGApBNAMPGhEEGU7NR0TQrdxIbH?=
 =?us-ascii?Q?+TZnIZwUTSIzQIMzu94BuivSQhcnOA+E3yktqTo2W51kQ6nmuF9NjHJYCQ6Y?=
 =?us-ascii?Q?8D0BvIzcOa7ijZO5VjyxRVVfVs2iJl5VjLv0jdfJD3HNkRj66OS89BGwMqQ9?=
 =?us-ascii?Q?luBIjnfS6v+/H+FmbvF5G6kcXtrW1XPJvMZjKFMwyOTET+nC0NGYPyoSUK32?=
 =?us-ascii?Q?DtMrWBeSVSFQZbU5DfJy0M01JeRfwvg3VCEDhoL6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Gc0KEPoTjtIboIPz2Krj0FuOBv4ztlTKUedzlMwNxDItZKDYZN573wWcbiJ/?=
 =?us-ascii?Q?6Zk5tUBk9oQUavpjczxszm+x9O2lT9UyNH+yVW5lLRhoti9gmfPWg8jmYxAh?=
 =?us-ascii?Q?js9abjtPxaCR06LYI350ZtFg4kofCsjmvJy1NEoMAsvrmK8kI/YQNSHAu3Vo?=
 =?us-ascii?Q?ijrkZglsdw6vfhRd6yaIET2Ein3k3BMSNMXReiMBlqMu/YOfY3zrEUfrkCDO?=
 =?us-ascii?Q?IO/9JYsE2ovVqlo+vTaJ+qDNSg1fXspWgu1fp15kDdTQeeKw07Njk/8J1kld?=
 =?us-ascii?Q?LDLVJaTZsEIuSQUL4XW4in5IWkWjsMEycTxq4jVCwYRkP4cO9yrDHiyLiAtO?=
 =?us-ascii?Q?X7iC3+2c/oUjK+D8T2JVxT1Oyc1DloLiZNiGeQtAvfOOh7NQIsegtGuDYu5i?=
 =?us-ascii?Q?hqQvsdBOLvPt06KTHE1E83XcnE8cX9aP8EVlmer4YYblTcQkcuXtipfr9S3g?=
 =?us-ascii?Q?KtJTQBs+PiFXgrzAJEmLRdB3ot1lBVftmab0mSuET7FDmU38QjlYVeVUv/4V?=
 =?us-ascii?Q?tG+tJqi8YzQHVapNhXSopqUUUdWQNIo+Dsd3v3FpWHt6CAV1w8GufdoUcfww?=
 =?us-ascii?Q?dJuDW26EDHoGekOaXTV4v+xqJmTtjf5d8IKdwdDuSK4UXZ0iPDSSx5bNJjQL?=
 =?us-ascii?Q?JJmgCuWtLaZ4cGlf/vJ6Nz48U6RDDDyPSWp6905xrwotTGRrTUzt40ds4wb9?=
 =?us-ascii?Q?9Zt3SL8sYyIZpkOMzTRyuh/X7VhfQpcsBmHrQyheuYRw5W3wdN5w4PChEXHG?=
 =?us-ascii?Q?bWBZFtevqIgSz5gViag8GPuvT7T5t2B1X5B6h+7udQMuhF5pkn5kf1FFtcXu?=
 =?us-ascii?Q?Sxf1P5Uigz6ofzhZOLN2C5dZPqlmSRKrwPCU/QCXltaNoc43NcqmIqrfq8SN?=
 =?us-ascii?Q?7OUIJqQXf8mrGhfpvonLIU7zlkWMU+8eVYr/faLi4dvhU774RCBUs/3FjQ6i?=
 =?us-ascii?Q?4EQDd7e0FkDaC7OhUWDedQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da92e58c-1949-422c-d4f3-08db4b83417c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 03:05:31.7107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KpYN8YvOuBtcmdOBEKXwRTC5SQfW/JTW2L5BNsPrnKNlFolNuT7GQV7ZD9UxRaaEwVA0c/UqJ0SaXRkyVpFmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_14,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030024
X-Proofpoint-GUID: QF25Lze5xQ4Mv8yKWSSaPa96Mvt8lnhH
X-Proofpoint-ORIG-GUID: QF25Lze5xQ4Mv8yKWSSaPa96Mvt8lnhH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/02/23 23:56, Ackerley Tng wrote:
> When fallocate() is called twice on the same offset in the file, the
> second fallocate() should succeed.
> 
> page_cache_next_miss() always advances index before returning, so even
> on a page cache hit, the check would set present to false.

Thank you Ackerley for finding this!

When I read the description of page_cache_next_miss(), I assumed

	present = page_cache_next_miss(mapping, index, 1) != index;

would tell us if there was a page at index in the cache.

However, when looking closer at the code it does not check for a page
at index, but rather starts looking at index+1.  Perhaps that is why
it is named next?

Matthew, I think the use of the above statement was your suggestion.
And you know the xarray code better than anyone.  I just want to make
sure page_cache_next_miss is operating as designed/expected.  If so,
then the changes suggested here make sense.

In addition, the same code is in hugetlbfs_pagecache_present and will
have this same issue.
-- 
Mike Kravetz

> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  fs/hugetlbfs/inode.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index ecfdfb2529a3..f640cff1bbce 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -821,7 +821,6 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  		 */
>  		struct folio *folio;
>  		unsigned long addr;
> -		bool present;
>  
>  		cond_resched();
>  
> @@ -845,10 +844,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  		mutex_lock(&hugetlb_fault_mutex_table[hash]);
>  
>  		/* See if already present in mapping to avoid alloc/free */
> -		rcu_read_lock();
> -		present = page_cache_next_miss(mapping, index, 1) != index;
> -		rcu_read_unlock();
> -		if (present) {
> +		if (filemap_has_folio(mapping, index)) {
>  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  			hugetlb_drop_vma_policy(&pseudo_vma);
>  			continue;
> -- 
> 2.40.1.495.gc816e09b53d-goog
> 
