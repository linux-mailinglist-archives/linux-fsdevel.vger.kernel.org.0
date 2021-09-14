Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D113440BC3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 01:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbhINXdu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 19:33:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4868 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231435AbhINXds (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 19:33:48 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EKxRSR007088;
        Tue, 14 Sep 2021 23:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=X4AZ6r9vOmPEEJsgaTOlVuG6WEl8FHwySaWrePQXINY=;
 b=Dg9nXsGJAvu0cw143n3YmNFqjjTYjTNtL7Ds5+3faEcUOmSuZF2vUhmObY8pts7RqU3U
 qdh8rnuF/lGH2YfuvGwc6NX9EiuMzqolNotJKHmM1kRBm6YGrNSj8MZrHq+Ih4hmNbnR
 v4osWpZeeJyraWU5iftnE6LANE7vv9CNXyju2+73Q+stVVLwrPUvA2XH+xD1jEXH0i98
 /l3s59KKGWYzDd3vutDzGRRGYhLjoSOGTBHkYQ9DV64bIjGczi62ga53q8bLQqjYg7XS
 XZOyavBUAhrkl9WRQSjXE7c+DJNzkhBtk2uwlix0H9FUnDTD5YBUYHvEd1AJYvpyQXDn TA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=X4AZ6r9vOmPEEJsgaTOlVuG6WEl8FHwySaWrePQXINY=;
 b=TdCb9Rk31DA9um7wKdJzJpi0c56aotUFDPRvvuMFJEzLm5q3fbO9ObiQTTpOaC7XtS7E
 MvMxem9d0G2Dyk4vwXAlVEoVWw/7dUoC1JA4F2mbOwHbGJxb03fBjgm8gMcMbZtqWcoe
 L1RJDS61tC7k78qhABWSfBXQqKDh2twsx84fNAgdpXjaF/V4hFdZ/1nwuecTHHsAO3YU
 FvEar3+l5FXO2RbjLscTyJpOINXm3pBgQpgzww3umD12aEAqFJO05nKPua9MMRNFn9KP
 zNx6XqI9YIroPDPMaPTjYS3BAF2RCc26RCJzkBuK+8aMO5cwg2ts3da8ERXiiZZx25vi aw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p4f35n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 23:32:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ENTjwm169855;
        Tue, 14 Sep 2021 23:32:21 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by userp3020.oracle.com with ESMTP id 3b167ssv6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 23:32:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTS2DF55kpGEoCzhDbZsRsv1lihkDHx92tV8xcbN+vGgYfJ8icA2T7CslICJSdEsuOufLVO0uyZXUHcxNxet9/aeyiUpV2s1Q6848qGlS+FHT7dxTaAdJ5PD5p4K2d4haPm7EVTgVzzAtep52i8rR4zFuVwogxafWEUyZNeJbRac5HtowMW3wyTe9nvb16SPcIAbtsVFDxhCHZ16uxFGJmuaekMkkPz9NT6uOtPO6k3YDte29VDGlQ1ub/CHz6ihSSUlXQsXuRDAngA/XujQeg9b5NMpf7gzb6FnBd/5MtXQ7+7tj6sHt93UrnkQyodqwRcvQqjU9kw/vJrr8RkFoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=X4AZ6r9vOmPEEJsgaTOlVuG6WEl8FHwySaWrePQXINY=;
 b=akfENGD8jGvIa8Kb+soE96Nv96rad6Byrec54dSQIvBwGHaZ+9QOZL+ZIaeNMc4tJC4Ozmb8It2787prfesW4o215zpzGysukScAdwNaMHJngAm6aBRrIJBroWWDPElNeUWGsJ9AHIPBOtAJ84RZtXgg+d3ZvQb//xonqv6AST9/4/SNJM7YEDQc8zGd8vi1RDiVHFjaw+1IuJa5FY8jFptYcwokScJ61EwThBaJ/rn22ufgzqVXicum9P+cTH4cIVhw1PuorqEi2AlnMTogPU6lu5viJnaBiQlhk2GZ+bVC+aOaehOrf5oK18RU4ufJnEdHT6nizEcR5URK819Gjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4AZ6r9vOmPEEJsgaTOlVuG6WEl8FHwySaWrePQXINY=;
 b=cdSTdj5OIhywpZEEllPSKIbzJE/UhJasrbmtVCwnW6oLSUbCZv92xY4KNwK7o/ofDOBPKb+bdIP+5d5jyGnDn7Q2fMNvRP51o0kYVhShjLuhH8hR7Q7KO1I0pWgFEO89MxOX5Ep3WelKIiUhrwD+VtGMujlKdE0aPNswrzDWKHk=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 23:32:19 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%5]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 23:32:19 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, viro@zeniv.linux.org.uk,
        willy@infradead.org, jack@suse.cz, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] libnvdimm/pmem: Provide pmem_dax_clear_poison for dax operation
Date:   Tue, 14 Sep 2021 17:31:32 -0600
Message-Id: <20210914233132.3680546-5-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210914233132.3680546-1-jane.chu@oracle.com>
References: <20210914233132.3680546-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0601CA0008.namprd06.prod.outlook.com
 (2603:10b6:803:2f::18) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
Received: from brm-x62-16.us.oracle.com (2606:b400:8004:44::1b) by SN4PR0601CA0008.namprd06.prod.outlook.com (2603:10b6:803:2f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend Transport; Tue, 14 Sep 2021 23:32:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7701a6cf-9a0d-4ee2-b26c-08d977d7e4c6
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4306789A61528D9022B047F8F3DA9@BY5PR10MB4306.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+R3ZZIjf8PiPcBIlhhoodUkoSsNYr9iwRgAm+0d9vS5oW7BoYr0S1C9niszfZek1yEGoem2iQtt2Z/Y+6H1UxFFtu9GzbFcwkiuZd7NGzbmvw34i6ZlE/V2D1Xi9weX0t4O//nSc/Gm7WNLRvr2njwK36rplfZUe3KLeyp+hgQUI/SisT8u7kifqzfxvNVqlXe0xJaaQWrPhpAmAsE5/WigdBGKpMDMqEiBDCANuIcfFSoJqHLYiOnifV/hq1AEKJK6q2cOHi/cCUGzoc2N0TfabwTeCOIANiXVDLqpthmKzNfQ2i2BChsHani2iXuxlzt7YdIPLA28mN1w6mMRgS/ZHpPhwRiGUQTZRJiyFKNIxumma12cH+6rgiLLe7fZo1O8oLCHT9d4N8mSJPeMO1O4B4lBzEsGqkOznE1lVvzJu1XQBIg9A354iVvcF4m63G8bZmNLHo6VqnquDZ+6E9jUGLhDINjgqvEiQaNCXtwZ2iD9/5sXxtbdKpRRhHnV3oTqU6i4/+cx+oxyfAoOtn3N57uv0DJzRMEQH+ByYpcEUdY31xBkSw04yN+0NifJt8Zfq3E9ZnKa94xK2++xd1I6Uu0+jH9mXA3Drzfm5JDpchfhfK3Jv/DMml5FHjI8WIpg/0FaEacbDpIyiNdMYK8slkNje6kWbVUrnrvGAKum8tcCjKxJAckFChzTUhMa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(396003)(346002)(39850400004)(66946007)(66476007)(7416002)(1076003)(921005)(66556008)(36756003)(7696005)(52116002)(316002)(5660300002)(186003)(8676002)(38100700002)(8936002)(2616005)(2906002)(83380400001)(6666004)(478600001)(44832011)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IWUQNaeiLu93hHcWM0QFUSQRSn/hpo476K1xxi8Z7PQ4PuN/e1VJTcniVL5o?=
 =?us-ascii?Q?kOS/NXjRZJIg4fc8kcpHl5EJMYst4yBu1I3XUum1/lxNZ20V/Pmjk0bhjXF9?=
 =?us-ascii?Q?a+T1M41vDcF5QwOCpS9LFLWKrpTCCxHznD+2gK6r9avqH+oX+G227587r2nY?=
 =?us-ascii?Q?4x1Tn8ojhug+tDmrr7TjylGHdETH6aYv5Dl5sC6c/MghP4LC5dsKOg91yQrO?=
 =?us-ascii?Q?+EY2OiYwWfsyJgUoUJlqbq1n9szf3ip7IuY21CEMKqCLs2SwGOEBxcIlKBf4?=
 =?us-ascii?Q?APWNzI4+683Nt9MlSLIFz2jJiiCiegih9AzK9TBUhim8oqEeBe+GVXqRpcOB?=
 =?us-ascii?Q?8YKHJr7WkPK0iwae9dlwMTYa6GzOXikccUEc/tirLHj9reHdOg8slI8PzX/I?=
 =?us-ascii?Q?4lcZ99menVRKpVJO1nO1Q2hF9pvEAjEvhckmyA22ZLk8SRMlMUdzWZHkdxcF?=
 =?us-ascii?Q?766UJEfcm/mwJNkX5k778UtQhyYfkmEzkNE4jVL5fvaeGeFNDsGgVcnaFRTQ?=
 =?us-ascii?Q?BZCTbKRji2zcB9206SoEmAbLWF9/WkwfqgMNerVC15XP9xb1sRTTGThy5gqO?=
 =?us-ascii?Q?/JFnpZWZB/ovvp4jJLzO0Mpm+BxAtdqTqjw3HYQmlsl9p2I06H5FSK2u24vz?=
 =?us-ascii?Q?qN7wK0AhCQLmevycyagjpP9BMJPvXhZlXpRuJdGcFOrdI+zQEOdDOAdRXZda?=
 =?us-ascii?Q?er9Wx/V5PbmarFiIfFjx9cMxZPOLjSzsDPrUSnFit2jV+tZK3qyVsa53FzB0?=
 =?us-ascii?Q?rDppYWkt+MRx0SC8UUEd5TpX1cktBsiJBcz54u5ITBes80gUGOYqHZZp6aZu?=
 =?us-ascii?Q?RmkV7c/fYsSpoSKQdrOyK0jhG3v89mVd3vQA2YcLW1YE07MFI7zZCigVTry+?=
 =?us-ascii?Q?9n26VAecP0AYcMxkgKnB7f9k9oh6EqQ1g/lPkiMZyHh3iRaXUXoIFiwumMrZ?=
 =?us-ascii?Q?mYGk5gBdzlPy56WgyIUJS5V6IX+L4r5nrfH7lPe0oY2e5n1P0siyLYVydY/g?=
 =?us-ascii?Q?CyUYZ1h+c58b9UVUR2BcCo6Z3NX1rj5O7vCVv3l1YJ7FC7KHvIWdUDPI8Ws9?=
 =?us-ascii?Q?UNHrU77tEOry8SigBjCcKUFkPiSEENkBEUMPWyYZZYdAlczTXMcHJubTeVHU?=
 =?us-ascii?Q?PNprmO7QJbkXcCOzoM8AwLEXrtflFTSp20h0/jJdJ30ud+OwKv5swphL291I?=
 =?us-ascii?Q?NfUD8wLegLAnX3VCjn9+rcO3ORRIs4RcdbjpFh2mCehr9MjmVfgOcKfSMlf7?=
 =?us-ascii?Q?M8+dqWwnKsh+UxmCRTpg8Diydq8Wmks2wLPdNhityM1Fa18LmqTAAlseiR6w?=
 =?us-ascii?Q?lX5xI6wdj0Cpe4mNPEawbRrxjEDTA0SmhPqqmk5tdaPI9g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7701a6cf-9a0d-4ee2-b26c-08d977d7e4c6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 23:32:19.1657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0LjDv1Zp3yHJntoYYpMbUot87kgsZE7cRutA2/PiKiQYyx/3Z63fM//L0/oUhhNCjDE0xn69JqYE8C+MpQLiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4306
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140134
X-Proofpoint-GUID: 1hnDXXc4LumVARAo4mVeQ59E60TF0jb6
X-Proofpoint-ORIG-GUID: 1hnDXXc4LumVARAo4mVeQ59E60TF0jb6
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide pmem_dax_clear_poison() to struct dax_operations.clear_poison.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/nvdimm/pmem.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 1e0615b8565e..307a53aa3432 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -294,6 +294,22 @@ static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 				   PAGE_SIZE));
 }
 
+static int pmem_dax_clear_poison(struct dax_device *dax_dev, pgoff_t pgoff,
+					size_t nr_pages)
+{
+	unsigned int len = PFN_PHYS(nr_pages);
+	sector_t sector = PFN_PHYS(pgoff) >> SECTOR_SHIFT;
+	struct pmem_device *pmem = dax_get_private(dax_dev);
+	phys_addr_t pmem_off = sector * 512 + pmem->data_offset;
+	blk_status_t ret;
+
+	if (!is_bad_pmem(&pmem->bb, sector, len))
+		return 0;
+
+	ret = pmem_clear_poison(pmem, pmem_off, len);
+	return (ret == BLK_STS_OK) ? 0 : -EIO;
+}
+
 static long pmem_dax_direct_access(struct dax_device *dax_dev,
 		pgoff_t pgoff, long nr_pages, void **kaddr, pfn_t *pfn)
 {
@@ -326,6 +342,7 @@ static const struct dax_operations pmem_dax_ops = {
 	.copy_from_iter = pmem_copy_from_iter,
 	.copy_to_iter = pmem_copy_to_iter,
 	.zero_page_range = pmem_dax_zero_page_range,
+	.clear_poison = pmem_dax_clear_poison,
 };
 
 static const struct attribute_group *pmem_attribute_groups[] = {
-- 
2.18.4

