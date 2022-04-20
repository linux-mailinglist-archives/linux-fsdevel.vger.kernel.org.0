Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E58507EA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 04:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358850AbiDTCIh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 22:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358829AbiDTCIY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:08:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5BE10FF6;
        Tue, 19 Apr 2022 19:05:39 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23JKk2Af019815;
        Wed, 20 Apr 2022 02:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=rGKMWwhH5kxfzhUJGdmd+RVQaEH51yGoDRr/lTdFaTc=;
 b=puE+olaJf1nmVoSe7+56rdf84E7leH7m7dVkQ8CghinBOXAqCxF0HkC+nws4p+PNxVs3
 7AauDtwNsKfGncjJApJwL1up6TLACpcLrFaFOTd9Ci8xN5qAE72jyxxcuZK3RLnDKQQ8
 3mrvhCzaphi1l6ub1zdT3eqItESOkatmvNgzXGfo860VxNsRthuo1hSED+EHJsDB7x7c
 4J2krd0+Fcssvg/uBHiggJLozqcrnAzGFqNhX+9pInVHV/3WNzm/tZ/NxwzUjJ42FjsL
 mSp29iDj/PnJxSGOPMEoLYi2FkC3fnp5kt4WCn/NprEsaBIS6yG9ytLbgD7Rc8rtI8ik Jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmd17ppx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 02:05:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23K20Wh1038030;
        Wed, 20 Apr 2022 02:05:20 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm88mv94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 02:05:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k65fd/AU03wWKdacDnuBpQhx6yB37d8mbLDYDCIU1ToDpzEAsu1xhkLo9rQl+Lu9H6GSv9PKVxu1XctlJ6W+lHSZlLHqO+jIuB8dES+Dd+0Q5O15ywp0zOSwfq9yxOwlj1vCpJlCPTS+k6EPmIl3lDXNGNc70CO1pDBsCftgWcyMnO1x0oWJhWwTk2WvcjaaE2RebtYchbJg4W5JcRmR8f4Cg/2wDTZ3wxRvrlR4n2feLA7rRfGC16RBPF63QZLQkGGgusfnZSu3ZCncqRlPjUrvyXb7d6IFCuLJEc/qAJVVTvPdkoYcaOQXFPzKxmRW8eWaMCuIn5/oZ2BLqcg8jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGKMWwhH5kxfzhUJGdmd+RVQaEH51yGoDRr/lTdFaTc=;
 b=mou88uR4m4ag6D8rAT/msCizw0eylnCVe9nenBH2323vGFGNcdU5jp3/1TBRx6b+YSad4yVL7Cc524vYxA7lDU6glOT2AY/GaDGFXB2H4e2mXmnUm6UdU1ero+C9e/mIQcB4u8A84gW/VOLl0sQcBg7FCk16IT7DgMgIfKNCKd3mELfgaWNTO4Ru4hNYgqKhuA1pMbRfcB7W2u5RL9ysApH2nKkb5/IdHRoeIQgUNgSbJPMVaQ0ChEcEHIpEy7036vBO3qITjxn/Yse4JDyRa3HxGAI3kr4WPrETw9FHCAIW5nGbTEcM7imQ+Xe3vFAaNLUIJEVvX1Nxs9201fhbJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGKMWwhH5kxfzhUJGdmd+RVQaEH51yGoDRr/lTdFaTc=;
 b=sgrXyycQeWRsCL1Zry/fHlDcPvFU1tr9BCCw5zBTEDzN8SviphYGDiLcZcjogHdv7LmxSkPd9P2CRa3OSpZvTZQILrsGMSOX5oRG2Z+NNRMwlXvhGBbRqv68NWzleLJmXt4ki80CtW/SpP7HM+pUGnIy2qGsNy7MAiKwe9ZEfGw=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB4557.namprd10.prod.outlook.com (2603:10b6:a03:2d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 02:05:13 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 02:05:13 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, bp@alien8.de, hch@infradead.org,
        dave.hansen@intel.com, peterz@infradead.org, luto@kernel.org,
        david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, ira.weiny@intel.com,
        willy@infradead.org, vgoyal@redhat.com
Subject: [PATCH v8 5/7] dax: add .recovery_write dax_operation
Date:   Tue, 19 Apr 2022 20:04:33 -0600
Message-Id: <20220420020435.90326-6-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220420020435.90326-1-jane.chu@oracle.com>
References: <20220420020435.90326-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0112.namprd12.prod.outlook.com
 (2603:10b6:802:21::47) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd3ddca6-48dd-42f9-2847-08da227234c2
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4557:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4557927BBEA38273D00D896AF3F59@SJ0PR10MB4557.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4wqIE77SX4EMKaXmn+KgoOMbe9u8K4pJv/8eWigfYW1t5xzmV6Hq7FowrmThJr/HiX19iYDLtRRiVg1r3bEHiPa9/5NPJXer3lcZJcqYi0ID3mD/6VEKbqIcROoZkYlOMc1qmEpd2PA5AKczAt4Mr5S6hbKoYlfq3eEZS0sgMTauAYj2LqiLPMvyuuZJTg7wsZKJIqMGyasxdnSFdnxVBxHR9rwiVawYW5iLU71N//vkmjoBBztH8v6Z6z2xRhJq2uVf98NU54kCnjgErudDsyd9ldJ8Ozsk/pqghKaYCXtmFkGrWXQpL5oHa8vHwVrcP0MkEPMytbYgrW6ZRvmOD//cQYpTOWXGUVSnTsiXKp6D/z+xiLah1koCzvboP7FQMLPNyd0Q04HgSNfFjO9+qDlkDjjWrlAN0KnzuwDoownvWliWjgDfr8u1120fOtaomD49jOg5kM13A7sTZlVXuzvudfens9tKFsat1LhoJNrIrulh+6AEtLbHkce2JbwpvOKsi19UcgcvUyrlyPir8/TNlkNvw50Lo77xT/XpW/KPQmjE9PIdf1M2x5OTK8U7CWqveopf8acrfzjqP2PHssRFm8DBVHYhNvl0iTzS6u9iTnkapxoseLfbWJNqM3hdZF65kIGKlyYdVfVxDOcjfimFqVbvuOjGp8lxf+pOudd9sJVFjP6ypm01VttoE1eQyuX6+6jVxSOdHFD0t3B7XefbKVtlIBkrj3Q5H3zz8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(5660300002)(83380400001)(86362001)(4326008)(66556008)(316002)(2906002)(508600001)(1076003)(36756003)(66946007)(186003)(44832011)(6486002)(6512007)(8676002)(2616005)(921005)(7416002)(6666004)(52116002)(38100700002)(6506007)(8936002)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AEl3jXt0UkeTVfeT2amfqSrOg5fPSZi0dpdk3ILtn5MWVKh9N03UT/FK07KJ?=
 =?us-ascii?Q?KZ4XGkb+grTfIMDKsix0kJ2DBw21fy6SJr3EZp6yKSN8leEJRj9ZDM1kPYXL?=
 =?us-ascii?Q?+vwS5hpU6FrJRrTE0ZyZb+bUsxfCHciQjKhU8Q0h5kH3GR4OIyF29D5We008?=
 =?us-ascii?Q?bl9X5x5ODbrq0KiqdsFcfmMh8br9nDAhzwFGr3Di4UV1Eekv2S8m5w7YP6Ys?=
 =?us-ascii?Q?Lzns+8xuQhElBnN+AJRcpPOw5lkvsv6VAAAKgDOtXhrCrwaXInYAFlpWL8cG?=
 =?us-ascii?Q?sOxT5Jzfxaz/PAw32tY1hHv2RXLKY4GEwg+5hdnUFYzZqYKdZBglfSIxIkEK?=
 =?us-ascii?Q?B/qCUNrseJKHQ98koskgydJRDahY+56UZVZTmRNpmk3xP4BS5P93+s4v/bCc?=
 =?us-ascii?Q?93Lm+1OmZX/rTWT9q5/G/GUb4M09PTudvvqg4eshiy+keiY9wmInR7UISBpq?=
 =?us-ascii?Q?M5T8yOnnT9pWQxX1gX7trNF4lwLenEb2gA/Tcfg2VFNJjzaqdVcqC59VE/CE?=
 =?us-ascii?Q?TNrkWMdXKiWeBQBr07A/uUTMT6HP90ItKMVqWRbREMGsmn8ytlxFSv+SKr01?=
 =?us-ascii?Q?imCzomQXxSDz0dIalHHKD3KOuj/X9oGg1HrREJEGtVrTqa0OzTg7fJSA3P3A?=
 =?us-ascii?Q?mtRgD9Mya+AFrXv5lvmM4tWAON0gWokmY4ZexYxUaVCfbtbJOKSIyHs6usgr?=
 =?us-ascii?Q?xAgwsFSTWSbmJgLNmqWT7NLLNGgUBhmDD2LnHZUZGBI3gRNLnq/H03ssw8cu?=
 =?us-ascii?Q?OfmmoyWs3sqyxhL5eABifqpemxYh+lJK3LNWwCY+3qfKWLuNq25B8dfEYiEd?=
 =?us-ascii?Q?6dduDFhVHJYo0BbQweobM6GcZ2VvPVfxMM2A59/BGzMBgtwFA9r4aliY95fq?=
 =?us-ascii?Q?e3mbABHjdmc7fIhLyzeQCdVZHAU8Q0SixvFEj8vdnmel/on59CZ/bHKKJxzS?=
 =?us-ascii?Q?+btnygooXmZiho9t4ABsmzuKELiJvr7B/jzLIyq1q9JBnTUB/xEGGJ1pe79O?=
 =?us-ascii?Q?8/8IdmyPgMMv+WW5yQzNyVRWCoX60OIl+HDDk4wyJ9rsV3iq1cjlVipVczOi?=
 =?us-ascii?Q?L8ohkJUv0XMDIb+u0P6Hqlr6LNUJ3AmicHEX0A932FGlQblqIdcYf7xs5DtB?=
 =?us-ascii?Q?0XnMr24PUY447qeTe6dkcSD+MeR528gns7IbsfxUKk8hrWf+3IFxlGf3MtPV?=
 =?us-ascii?Q?FbS5yFoyMcIbrELJtLOJCWKaiVRtFcVS6kaeum4GL2MFqoRx7AmhA//nwo8Q?=
 =?us-ascii?Q?iwbCrQGz9DQfR6h94miLBIe3fzM2JmbxbjxmzV+2qfZeI4ABA1SGZRPd2rOA?=
 =?us-ascii?Q?CVPYCXYCPAWQcI+QjUU5Ljnyjrvpq3lWFhqNZ9gYbJtkTVXYVjuj9KJypEes?=
 =?us-ascii?Q?cmw0txTjrbfN3JCBMMqg9Ml+Jy/ZUnxPdLOuPEL3SyCc5dh21zdFwDrkB9V7?=
 =?us-ascii?Q?n6yAwc+wGv0FR/tEE0W6ucYo5kVdx8R3gi5g9KFtjfSp4i6CDnlpi0eDlrs8?=
 =?us-ascii?Q?jGLgyYvy7HOIN+dTzQGbu74YkjbFat4uhDS80i3zZMjhy43FJpH6qg7y4BLY?=
 =?us-ascii?Q?dV3zgWijxeUvEAZrw3W+byPCqX1STm3DUhmclDi/GuGDFTZPtBO/c2DNhJlS?=
 =?us-ascii?Q?/d6nTJh3IJCO/7ZFAWvy/ucY9Xfu1DMstE2tk2LKYJKO6V86FIWmSPvyADDm?=
 =?us-ascii?Q?m/3DRgrr+tuMelJR/oe4tZbDWZqGkZjzRaDBlE3T9EyLaSLtDU8FUoh1T0DM?=
 =?us-ascii?Q?no6xBoLmdkiHzpCzqwDQutm/p4fXIJw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3ddca6-48dd-42f9-2847-08da227234c2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 02:05:13.4351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPsJCFFreogqqrq6IToN2vO6xsowMb9HjGviS9HdP6MGZ0jLrnOmGmhvAn4YikRloR2Z5kiA1lRNEhjvgmIA9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4557
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-19_08:2022-04-15,2022-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200008
X-Proofpoint-ORIG-GUID: hVsQsBx_x-gt84TVWA4ULBpdkfH4Zy_k
X-Proofpoint-GUID: hVsQsBx_x-gt84TVWA4ULBpdkfH4Zy_k
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce dax_recovery_write() operation. The function is used to
recover a dax range that contains poison. Typical use case is when
a user process receives a SIGBUS with si_code BUS_MCEERR_AR
indicating poison(s) in a dax range, in response, the user process
issues a pwrite() to the page-aligned dax range, thus clears the
poison and puts valid data in the range.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/dax/super.c           |  9 +++++++++
 drivers/md/dm-linear.c        | 10 ++++++++++
 drivers/md/dm-log-writes.c    | 10 ++++++++++
 drivers/md/dm-stripe.c        | 10 ++++++++++
 drivers/md/dm.c               | 20 ++++++++++++++++++++
 drivers/nvdimm/pmem.c         |  7 +++++++
 fs/dax.c                      | 13 ++++++++++++-
 include/linux/dax.h           | 13 +++++++++++++
 include/linux/device-mapper.h |  9 +++++++++
 9 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 5405eb553430..50a08b2ec247 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -195,6 +195,15 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 }
 EXPORT_SYMBOL_GPL(dax_zero_page_range);
 
+size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *iter)
+{
+	if (!dax_dev->ops->recovery_write)
+		return 0;
+	return dax_dev->ops->recovery_write(dax_dev, pgoff, addr, bytes, iter);
+}
+EXPORT_SYMBOL_GPL(dax_recovery_write);
+
 #ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_wb_cache_pmem(void *addr, size_t size);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 13e263299c9c..cdf48bc8c5b0 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -188,9 +188,18 @@ static int linear_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
 	return dax_zero_page_range(dax_dev, pgoff, nr_pages);
 }
 
+static size_t linear_dax_recovery_write(struct dm_target *ti, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i)
+{
+	struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
+
+	return dax_recovery_write(dax_dev, pgoff, addr, bytes, i);
+}
+
 #else
 #define linear_dax_direct_access NULL
 #define linear_dax_zero_page_range NULL
+#define linear_dax_recovery_write NULL
 #endif
 
 static struct target_type linear_target = {
@@ -208,6 +217,7 @@ static struct target_type linear_target = {
 	.iterate_devices = linear_iterate_devices,
 	.direct_access = linear_dax_direct_access,
 	.dax_zero_page_range = linear_dax_zero_page_range,
+	.dax_recovery_write = linear_dax_recovery_write,
 };
 
 int __init dm_linear_init(void)
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 06bdbed65eb1..22739dccdd17 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -905,9 +905,18 @@ static int log_writes_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
 	return dax_zero_page_range(dax_dev, pgoff, nr_pages << PAGE_SHIFT);
 }
 
+static size_t log_writes_dax_recovery_write(struct dm_target *ti,
+		pgoff_t pgoff, void *addr, size_t bytes, struct iov_iter *i)
+{
+	struct dax_device *dax_dev = log_writes_dax_pgoff(ti, &pgoff);
+
+	return dax_recovery_write(dax_dev, pgoff, addr, bytes, i);
+}
+
 #else
 #define log_writes_dax_direct_access NULL
 #define log_writes_dax_zero_page_range NULL
+#define log_writes_dax_recovery_write NULL
 #endif
 
 static struct target_type log_writes_target = {
@@ -925,6 +934,7 @@ static struct target_type log_writes_target = {
 	.io_hints = log_writes_io_hints,
 	.direct_access = log_writes_dax_direct_access,
 	.dax_zero_page_range = log_writes_dax_zero_page_range,
+	.dax_recovery_write = log_writes_dax_recovery_write,
 };
 
 static int __init dm_log_writes_init(void)
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index 77d72900e997..baa085cc67bd 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -331,9 +331,18 @@ static int stripe_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
 	return dax_zero_page_range(dax_dev, pgoff, nr_pages);
 }
 
+static size_t stripe_dax_recovery_write(struct dm_target *ti, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i)
+{
+	struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
+
+	return dax_recovery_write(dax_dev, pgoff, addr, bytes, i);
+}
+
 #else
 #define stripe_dax_direct_access NULL
 #define stripe_dax_zero_page_range NULL
+#define stripe_dax_recovery_write NULL
 #endif
 
 /*
@@ -470,6 +479,7 @@ static struct target_type stripe_target = {
 	.io_hints = stripe_io_hints,
 	.direct_access = stripe_dax_direct_access,
 	.dax_zero_page_range = stripe_dax_zero_page_range,
+	.dax_recovery_write = stripe_dax_recovery_write,
 };
 
 int __init dm_stripe_init(void)
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 8258676a352f..5374c8aba2d6 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1147,6 +1147,25 @@ static int dm_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 	return ret;
 }
 
+static size_t dm_dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i)
+{
+	struct mapped_device *md = dax_get_private(dax_dev);
+	sector_t sector = pgoff * PAGE_SECTORS;
+	struct dm_target *ti;
+	int srcu_idx;
+	long ret = 0;
+
+	ti = dm_dax_get_live_target(md, sector, &srcu_idx);
+	if (!ti || !ti->type->dax_recovery_write)
+		goto out;
+
+	ret = ti->type->dax_recovery_write(ti, pgoff, addr, bytes, i);
+out:
+	dm_put_live_table(md, srcu_idx);
+	return ret;
+}
+
 /*
  * A target may call dm_accept_partial_bio only from the map routine.  It is
  * allowed for all bio types except REQ_PREFLUSH, REQ_OP_ZONE_* zone management
@@ -3151,6 +3170,7 @@ static const struct block_device_operations dm_rq_blk_dops = {
 static const struct dax_operations dm_dax_ops = {
 	.direct_access = dm_dax_direct_access,
 	.zero_page_range = dm_dax_zero_page_range,
+	.recovery_write = dm_dax_recovery_write,
 };
 
 /*
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index c77b7cf19639..3c0cad38ec33 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -309,9 +309,16 @@ static long pmem_dax_direct_access(struct dax_device *dax_dev,
 	return __pmem_direct_access(pmem, pgoff, nr_pages, mode, kaddr, pfn);
 }
 
+static size_t pmem_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i)
+{
+	return 0;
+}
+
 static const struct dax_operations pmem_dax_ops = {
 	.direct_access = pmem_dax_direct_access,
 	.zero_page_range = pmem_dax_zero_page_range,
+	.recovery_write = pmem_recovery_write,
 };
 
 static ssize_t write_cache_show(struct device *dev,
diff --git a/fs/dax.c b/fs/dax.c
index ef3103107104..a1e4b45cbf55 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1240,6 +1240,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		const size_t size = ALIGN(length + offset, PAGE_SIZE);
 		pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
 		ssize_t map_len;
+		bool recovery = false;
 		void *kaddr;
 
 		if (fatal_signal_pending(current)) {
@@ -1249,6 +1250,13 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 
 		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
 				DAX_ACCESS, &kaddr, NULL);
+		if (map_len == -EIO && iov_iter_rw(iter) == WRITE) {
+			map_len = dax_direct_access(dax_dev, pgoff,
+					PHYS_PFN(size), DAX_RECOVERY_WRITE,
+					&kaddr, NULL);
+			if (map_len > 0)
+				recovery = true;
+		}
 		if (map_len < 0) {
 			ret = map_len;
 			break;
@@ -1260,7 +1268,10 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		if (map_len > end - pos)
 			map_len = end - pos;
 
-		if (iov_iter_rw(iter) == WRITE)
+		if (recovery)
+			xfer = dax_recovery_write(dax_dev, pgoff, kaddr,
+					map_len, iter);
+		else if (iov_iter_rw(iter) == WRITE)
 			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
 					map_len, iter);
 		else
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 3f1339bce3c0..e7b81634c52a 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -35,6 +35,12 @@ struct dax_operations {
 			sector_t, sector_t);
 	/* zero_page_range: required operation. Zero page range   */
 	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
+	/*
+	 * recovery_write: recover a poisoned range by DAX device driver
+	 * capable of clearing poison.
+	 */
+	size_t (*recovery_write)(struct dax_device *dax_dev, pgoff_t pgoff,
+			void *addr, size_t bytes, struct iov_iter *iter);
 };
 
 #if IS_ENABLED(CONFIG_DAX)
@@ -45,6 +51,8 @@ void dax_write_cache(struct dax_device *dax_dev, bool wc);
 bool dax_write_cache_enabled(struct dax_device *dax_dev);
 bool dax_synchronous(struct dax_device *dax_dev);
 void set_dax_synchronous(struct dax_device *dax_dev);
+size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i);
 /*
  * Check if given mapping is supported by the file / underlying device.
  */
@@ -92,6 +100,11 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 {
 	return !(vma->vm_flags & VM_SYNC);
 }
+static inline size_t dax_recovery_write(struct dax_device *dax_dev,
+		pgoff_t pgoff, void *addr, size_t bytes, struct iov_iter *i)
+{
+	return 0;
+}
 #endif
 
 void set_dax_nocache(struct dax_device *dax_dev);
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index acdedda0d12b..47a01c7cffdf 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -152,6 +152,14 @@ typedef long (*dm_dax_direct_access_fn) (struct dm_target *ti, pgoff_t pgoff,
 typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
 		size_t nr_pages);
 
+/*
+ * Returns:
+ * != 0 : number of bytes transferred
+ * 0    : recovery write failed
+ */
+typedef size_t (*dm_dax_recovery_write_fn)(struct dm_target *ti, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i);
+
 void dm_error(const char *message);
 
 struct dm_dev {
@@ -201,6 +209,7 @@ struct target_type {
 	dm_io_hints_fn io_hints;
 	dm_dax_direct_access_fn direct_access;
 	dm_dax_zero_page_range_fn dax_zero_page_range;
+	dm_dax_recovery_write_fn dax_recovery_write;
 
 	/* For internal device-mapper use. */
 	struct list_head list;
-- 
2.18.4

