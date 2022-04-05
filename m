Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841C34F4D2D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581668AbiDEXkV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573715AbiDETux (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:50:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060E11B79D;
        Tue,  5 Apr 2022 12:48:54 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235H2TkC012558;
        Tue, 5 Apr 2022 19:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=v9CK3edz8FX5Jr3KqTFF6nuAQBxxNQpCXDhbmzBXf74=;
 b=SH+MaZ1T2iv9daxK1Zf82+zCPa0aIeLmifyF/QjHf2gkKRy5vnChalyERsaAXdOPcB9P
 0TmVf50hQCtu84mPGTEqW1R9aidw4EzUCf2twbt9JmJTdYZxIXT7vf3M/wET64YNk1eJ
 PDxwvwcE3rwp5MpL6tqz9R+j9ZfjFXTa2aV+1TFPMMAhjJ64IF579V789ou+N/h9OQ0Z
 4yqWpXXJpYcPX3P2Q7sa0ivG4hv8Ui0UE5laswhZp2zOqva8UM5NzIIavJQHnqHbMwXp
 R9wL6V7sfv95GO4jHKMrshQz6uwzfkIjoomf5nyhwlS6OsMFQHp1LtKWbnvzlRrHbAVO Nw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcevwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 19:48:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 235JaOxn002758;
        Tue, 5 Apr 2022 19:48:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx3tu5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 19:48:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THo1MksWEm5yWFxU3TKqRmbxSioRNYsVpXD/0MW1nelFLHyktBw36nT9pdshsOjaTQMVVhhsjkqv9VAO+k1KpNNn4xsA1gf1L1dtj/1aIVOZFF8DT51TgE7db1MvRwnXFHogNDYz+0q1e9qcTfg3hwQ4+AP2CtKw0hwzjhhqKJI05FaadPvnaOFkMyEhG7nPYkgsrCmUMawB7bRZhFLDahBJVF6ZglaStnLlWwaClUyr75KNgtN6HZJdl+y53jfhpakXKI9AGekN3Eo123Vz2ecry0HJY6tAtyLC4uF9eo12nvJn8dDbcf4OXeHyCV+d/6LLgNlL8PkyNx7UBHBLEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9CK3edz8FX5Jr3KqTFF6nuAQBxxNQpCXDhbmzBXf74=;
 b=WdPcHLTkhHjk6LOueLa07QNH8cpSnBHTlgrJHRx5UEig0gEPYN3Ajk9qNz/wGH7dX17Ahzr1v/UEibaRVKKUQxMxtZybHRTNdCI76xaHFXmyaXpdAb0OSDn6Zi1ZD7o+WYm8cN6c3auOPxCoh6TgPrhpjSbIgWmUzdm0p0CbhZNqSQ9mesrrjPLWRWQ1YpujCNuZ6KmQ9Vz5wlkvHedhR06KL/PCQLg65v3Sko6Fy41tQ3tRSdafYh1+zNjFkwynRloSbdSuKgry6CpyP9+8xsazrCjtkc5Z+H5cWv7U8iuxPJGtEweyFAr8W/xbgYLIe8CfWZvG5H/PATLIFi/o6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9CK3edz8FX5Jr3KqTFF6nuAQBxxNQpCXDhbmzBXf74=;
 b=F+gtRPWZ3mth82jrKNq7hGv+3165z5mxc6ta+iurNmkxM9ElcFhBOL3FS+FjylcnsXDEu6jRIWWCuF4YzgDx4WQ9Q7Ixkh238AVcL2XpDGtgP6GFP65/RusA0Hl6bMZdf/o0993BrRTVu6YrKOwG1VrsqVK+bmipRsocqY0cbPE=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CO6PR10MB5475.namprd10.prod.outlook.com (2603:10b6:303:13e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 19:48:17 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%7]) with mapi id 15.20.5123.030; Tue, 5 Apr 2022
 19:48:17 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v7 1/6] x86/mm: fix comment
Date:   Tue,  5 Apr 2022 13:47:42 -0600
Message-Id: <20220405194747.2386619-2-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220405194747.2386619-1-jane.chu@oracle.com>
References: <20220405194747.2386619-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0054.namprd13.prod.outlook.com
 (2603:10b6:806:22::29) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 987949c4-3079-48ba-e9f4-08da173d3a7c
X-MS-TrafficTypeDiagnostic: CO6PR10MB5475:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB54751FF8656E4FB27BB3309FF3E49@CO6PR10MB5475.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: poyo2Y7uxG6xIPYx+gG3I/Tzz0KJmf6bG1sw3SK5klTmrueGK5olzA86Gg7/jyrQTwY6PeT1dZNkJ8h+j+/8RbG4AWXBRfxurcheCct2y6P6QoOiXijcBKU6LjNdaQr72gc0q/cWVQFYGcFqoc5wsRmJAg+AVJk9Ts61Cxl+uxPKbcVHaC+2sh9idN2GXWyGQqInWunk6ML3GnzlbVpoq09Xnm+GA8vWk7BbuwHo+kpKgj5p4iablGESDxxKZo0oWwD6OGLqFEcPpGVGtMz4uqzRFpMh+gZTA0R6biwRBZpfRNCbg8YTx7bcP7CZBlrvnZCxLwP2j5JB9ObCXrj++f6eyQsPHHfs7XEynM3gMaLONGuGEK63v9JTXtWnmGLVkvwkE0cvMmkXHi16k/1D8PLmDfwkSnfos5gl8MxS+jYbfT2hCLFKQZUmcgnQx10lks9ShXMpgAx8XciADVb9NegYQfkiw7gO5NZwAYyFi/y0FiLiVyIxRaDBgUngriMvuuesygH6MMuBbgbZh80GHCfY6gOLPWAJ59tqKw9kOX7AiKD2gpmBE+KMGuPqHLhgAKsuRwe9MT4rU1PHWiJI4EuVkf90S6g6rhLVTb/I1vBJ3Qk9F7wgUuSB2R3Qjeq7g1kePs2017NQBF5Sc7OV3L5ONqTTwEzV7zrNfBUVSwEKpaBs4o2Yl+PEZj47kmCe1neOBXJvnr01SQfBmiuQ0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(1076003)(186003)(2616005)(5660300002)(2906002)(316002)(6512007)(921005)(6486002)(8676002)(36756003)(6666004)(52116002)(6506007)(7416002)(508600001)(66946007)(8936002)(44832011)(83380400001)(66476007)(86362001)(66556008)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bZzwgagaJ/9SmvRUHZuqDbHm0BsgRUBu09UNCVIMXvR2mVNfJOexGog8PWth?=
 =?us-ascii?Q?kd7gLad/GVAJgg1Zgh/CdE/8NLNoLlBbRDc3I6qdFIpfUq+jw92aFvtjIFd5?=
 =?us-ascii?Q?upphysxtc5sSoQc6zrgtSI0vfIuHilGAg6AuQFuvQqbHKOxJraaYPg6lBasQ?=
 =?us-ascii?Q?oAfFfLq76j1pSJZzZxk76+eHMHV2EsluMy6zTpMDrNN5sITBfGE9+EAx0tt8?=
 =?us-ascii?Q?F4CEoAkMx5+MjizpdJ6HulWLkIiP7Y+9ZjXnloNY5qUhX53HzedCvTYd6ka/?=
 =?us-ascii?Q?Mt/wsutZhpzkc5tCKnbeyiJ8vbusLfsYmrToVe7uCbnBcxzkuDFM2Jnsamzq?=
 =?us-ascii?Q?0F8ByqrSYJxul8LWBk2DY42mcx5OmBotdzu48YsluE5L9I3zsDl8efXXKlWc?=
 =?us-ascii?Q?voveTLeB7UFqydZKsGpRLe9RM+XL1+Bo6W9KJV1QnF1ivZIDa9XH44PjXX0i?=
 =?us-ascii?Q?eLdBgqnmxdekq+3je7pY5ttTS/40qaxeSoJzc9VHWKtF41UsKHEgUVr7s338?=
 =?us-ascii?Q?XiALJhS6iMH57t++6kkFQ3wCkzpZfOiE27ajbbmJlRMPVX2AxdeJrZgtmxnL?=
 =?us-ascii?Q?H5l2ALqgB0v2Q+U3jmt9CUZz5UGkZUfrr29/BuYmIu4KStzxD9160G9USgFf?=
 =?us-ascii?Q?VVTAj69LbYQwwx6ZFbQyQtLBnJEtQTmCLYUKaSSOFD5O5sJzweDzSKonsfaA?=
 =?us-ascii?Q?4YZd4a8Csz1gxejRvSyV6PEzJA+Uz4zkEgB4WwhleylM1TnbxCI8aQx8O7aB?=
 =?us-ascii?Q?x0sRfI9n+Mp4D4s0fzzbDvxu6YrTOVV4EFBY/MOw8vlJBoLqV1+QUm4hU/dL?=
 =?us-ascii?Q?r7kwWknBEGD4fZ17PDUNoRUc+HNtV8ffA8HwaO5K38vQkO2WiizEJSxz407P?=
 =?us-ascii?Q?8uGMF/tPSlijP9KHiqjKZA03yvj1QwKEWoV0yfVzV4fCPCKh1iEfVxdhyfXF?=
 =?us-ascii?Q?SjPrqgg0c7o5yo6tEeqs7DpIOfP5hHn2cowlHAqRUjXKsZ90rp/RyXYf8Gp9?=
 =?us-ascii?Q?d8QgA6FW9Pi31ii3masOB7LWe0QWM5KJQTzXf8M8oay0bNdERDw8FzcCVL89?=
 =?us-ascii?Q?wL5VYoN4yzRZiuD84iwjVj60k3zzoKnG9acn6j7YRB/hSZCub8fghvJkoVmD?=
 =?us-ascii?Q?jfnhz8TW+QyKx4NFNnOWurO/OhxixDi5d9B2pXGdkjj+r9liHrf378wfSWzv?=
 =?us-ascii?Q?Yqf7vK1ONytLObcL8L/W35bOgRwtb/Taj9MH8xqjplcC/5iKaUt9Lfw0QsNt?=
 =?us-ascii?Q?LUyQ0YreGDmyqSWSaCptsgVmvmALZnEcB1HKTQjNqNJNRUEGrUzSMFD/t/id?=
 =?us-ascii?Q?lNcb8+zAB0wAoRHU6cRXSKbV0irF4qbaACYhhAGS7acvU/1wwA/V7o9Tj1ma?=
 =?us-ascii?Q?C67ew47vssLgWlLmMtzuQGqxTn/FDoOceVgbUHJKKygH+3k88JzDusGOiA3I?=
 =?us-ascii?Q?DQKrSIcxc1ZvNMhf1S0pak91dS7YT1qKHnH3n7Y/U3TcfMRmzBR+nCSlX1lf?=
 =?us-ascii?Q?ceW2A4iJgRelTBcXlJUjon1PAwBvRdUl4nmJPuwnw2BlJEkFJ1ezwyAoB3KX?=
 =?us-ascii?Q?4HRHLgcKjCswDYaWLc2xA8Ugnbz9AlQ4NGpcQ0TeQl6GN1kICOL/EfTDCI6m?=
 =?us-ascii?Q?rmS6uiF2WVbYwjdjyVYQUIWa0IrIdc4RMr4CTqb6z3Zu+kuIB92ckE7XsmFA?=
 =?us-ascii?Q?nLd9rfEa3jqjft2kq/4QOGISqnv7sJcg3dt96EHCNvZuZTor/5TJfiJkljuM?=
 =?us-ascii?Q?tlhLYXaB2rQ4mWpaL/TOfkBqUwtxDLM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 987949c4-3079-48ba-e9f4-08da173d3a7c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 19:48:17.0711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2ssMUH2ZCIGDE7HbAsd9v48r4cEN0dV/mp+1Fa9yJEIhL6Q6c6098fL/o4S1MllG5BjI8G3MR4QeK2PGdCmNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5475
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-05_06:2022-04-04,2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=828
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204050110
X-Proofpoint-ORIG-GUID: 5SvP6HpOCiz4WKn42FNJO7gmhf1Lg0Zf
X-Proofpoint-GUID: 5SvP6HpOCiz4WKn42FNJO7gmhf1Lg0Zf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no _set_memory_prot internal helper, while coming across
the code, might as well fix the comment.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 arch/x86/mm/pat/set_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index abf5ed76e4b7..38af155aaba9 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1816,7 +1816,7 @@ static inline int cpa_clear_pages_array(struct page **pages, int numpages,
 }
 
 /*
- * _set_memory_prot is an internal helper for callers that have been passed
+ * __set_memory_prot is an internal helper for callers that have been passed
  * a pgprot_t value from upper layers and a reservation has already been taken.
  * If you want to set the pgprot to a specific page protocol, use the
  * set_memory_xx() functions.
-- 
2.18.4

