Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887374B0106
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 00:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiBIXO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 18:14:26 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbiBIXOX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:14:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA360E00D0E1;
        Wed,  9 Feb 2022 15:14:25 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219KYQul020178;
        Wed, 9 Feb 2022 23:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=IjpUwYdnyj8IMOcG4YQLpPXNd2LUgTj3nWSXRDhJbKM=;
 b=gJxzyENWXHjThvwbkAXow/pE+ASpewwHmjmtxFzyQOG6cxMiw4qU9VqotN+QGmxEhnfO
 Mm3x+3mc38X17H5rE0jvuAwS6W7c/SQzhLHOYKJIVUgWPOtJWKzKWa8nApZ4e7e+q+TR
 FXxYa4gUhurrPhbNZdH5niTGxUUul3q5Jjf0H3sDega0wopELk0eaMoFJfe/xJnooPeA
 beDX/f69nr61T/BpWBNblmPDTuPJadE0sWip+GUCi/Q1gokL5w9ye62MxtdQu6DciWF9
 msNf4FLPUJQzlN+4UmEgMzcmFoklp6MVOpHHOtVlr2WQNTHrHeZqlhav7aIKc36u/h8H QA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366wybq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:14:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219NBqmL104943;
        Wed, 9 Feb 2022 23:14:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3030.oracle.com with ESMTP id 3e1ec3kf7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:14:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGaCocY4kelpKzJbbzbx6z6vHCL7/JBFvWdl/HoSyOixMFKcCGP6j8eAEUagFclAebSi0Ergtm5DShqEqN8R6ThxFBwZsyU5tKR6HaGshieH7DXXuAM6H6y86xaxi389QPh2UZR3wfTlLDTbE789SvcdYLakU7tsyXINTVZ96MrCAJDpEvfWIuj1QugmkTQ3aBdseTD4BCBpwykr6Ua1xvqVwRnMqYsZlVbqr2JvDcbQ9bSf+0bk/YxDyCBsuaS3YNZ8A4jvmRNXah1/UTwjvDH+SevTLsMMjORxaVk+PqxHJwQId+p9yzkj29qMO+Bhb8NZTdj0uIw2gbtyr5XfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjpUwYdnyj8IMOcG4YQLpPXNd2LUgTj3nWSXRDhJbKM=;
 b=aHlEzIDz3rT9B+X62q38Jlv7lJJmEKNrNpJRoReQpwj1fIoNC+hwyRiPXi5Ui7F9wCvw5dBbi6hnwgEPB9/2TmIxw5amfnf5JOxZmykEtyCydGi+DYlrsoBM/7om49sWi+86/rHIxJcwngq18I4N0Ds9qEWZ6qMNVo8PYWBKYEP9J5O23fdCpBHfW4j00I1r+AqGHYzpDdE4mZi02X8b41tZ/NyiXg5BE4Qz+Zmt26AEl7gmsP7AXcbtsqyvGTdRVSRn0BNMUf7mBWX4qKrWCHYZrjF8MWocsfURH9M3fkUyTaxuHs0jIQ9XoFNXFM8N/Q1/ZA0uMpWSPlL6lsuN3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjpUwYdnyj8IMOcG4YQLpPXNd2LUgTj3nWSXRDhJbKM=;
 b=dhPlWrqN88aPHfES/Ql4vDrvZlKbrpMmzre1HP+omQhaWqLDkKAVqgiJbuopU3KL+HE2Qf9HhY5GVsMn1595Mbk1qjLmmSEFHm2UL3FhYGfCedieho0DWRDy3J7q1xJsUxz5jaLY027e4AuE6kUL1ZXpqm7r3/WKJx8cHO0JfIw=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BLAPR10MB4884.namprd10.prod.outlook.com (2603:10b6:208:30c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 23:14:16 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4951.018; Wed, 9 Feb 2022
 23:14:16 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 3/4] dcache: add action D_WALK_SKIP_SIBLINGS to d_walk()
Date:   Wed,  9 Feb 2022 15:14:05 -0800
Message-Id: <20220209231406.187668-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209231406.187668-1-stephen.s.brennan@oracle.com>
References: <20220209231406.187668-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:806:20::21) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0df24ea9-0677-4861-fc9b-08d9ec21e467
X-MS-TrafficTypeDiagnostic: BLAPR10MB4884:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB48848D9608D012BBD0E6C8E8DB2E9@BLAPR10MB4884.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hs9H4bSmB3vpHvgFeXT1F6qZMdQRhg1X1s4udv9cyImHCOjY00/rNxrGUlwU3yUYs9raCipNoD5W1Sqc4wiz3OLiRrBHoqA2rwcQCdwPaSFuTKKwy5b3e7IGfD7j4WEbDwA9LUytaqBWfEbR4t2zwgJKOjXjRx1MrRB3gr83CtkQCssyy6lGUDhWesBvPW4TK1Y/b5mQmHWMQ9j2SMarrbIlKpBiME4N1Kq01bC2B1aDX5SeaphIuGGIR5rI8/sLnbvl6hNZ6cXY2pruNDLYtkJ3yNjHskmu+SSwC/IobHKfbl++/EY+XnOwHzOsIK6rl7rfRMaJ7GKVgyTs5EA/OvcJg9mR9pDsou3HRDD6MWXVRp3Os8RK/cgrgysxQa7O7Yh/G4AmAjSb7wzkZ0PYEDe3/BJVRSHEHHLv4ojohflVRCHjQhRKmgSEANBToSQFEUBjnZBpskioa3yh4IIVX3eJvopn+gPBk2fxicMkWK2HOGLv8rPqDwEKSVxu4Bt1nM4W0lr4ozi4FhiM1u6mxBCdlrmkuAX3ATUHvL7aIaccILq/0D2HjaMa/faPys+9peWVZY2o4c8XwtvzHpD7EpvH3vHB+fdNcZJGJ8E5muI3h6Wl3Aar3pu2S2ZKEYYvkaEbMbZretk0nZ7lXMJFn4yPy70MKI++94wLKcQlxQxlAl5/R90XhmirvBfLMJ0P+67BdWesy1cq8NSko+8ovw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(86362001)(52116002)(8676002)(6666004)(6506007)(8936002)(103116003)(66946007)(83380400001)(66556008)(508600001)(4326008)(2616005)(38100700002)(1076003)(186003)(26005)(54906003)(2906002)(5660300002)(6486002)(38350700002)(6916009)(36756003)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QWjQbdlJx5qP8GD2EZBW/VkX2LBiLN7likCQf3hYS18R48kR+tsGvHFWyOns?=
 =?us-ascii?Q?m+FHpB6wVfL+9zpF2E+H+kbcxGJVW55e/k2QB9yJyjb26wo1+AHp7rr5Mv9p?=
 =?us-ascii?Q?dfhJ0dVXV7hS2zZeqZUNEHHOYABJQhD0M9w7DJtbYoL5tgZCj8vHWdNZD9RM?=
 =?us-ascii?Q?qy7m42GW5sWzqmHA+m6ILN/Py+0py7oS40xsPJFgluU5ynjAa5Uy35rSpGjd?=
 =?us-ascii?Q?+p97Tas6zknVTUjiyhPR+VhCqXob8PxDjeU+GJIW6GUkmSOaA4h/WC4OfQfg?=
 =?us-ascii?Q?u0s6XlUpQBcH8M+kf57PyNbpYkmM035ZSOH2NuKwBbHam67BAQEmXDUMybXU?=
 =?us-ascii?Q?AN8TqrvNSAR6dDlOmntW6kUXDowigoJsvXC+xn4h1jZCr1EZbAl0yHrtvAsJ?=
 =?us-ascii?Q?TExQsZsjNrj4JqJUFCe8pkJiGKPWsvV5ilkHG+N4tbJq53u+AfysgEpdr6KJ?=
 =?us-ascii?Q?CAbDJ0JNklRev3orZW1002yrrJGLVSSQfdzMjjeLOWxJUK7w4/PoH90mujm5?=
 =?us-ascii?Q?GnU3jF3zJyupAR1+XpAsQb/eH+Rq+wTjuqDxBynr30omij6hsLqbLzUu6dNT?=
 =?us-ascii?Q?4gTuXdMkI17VQBb/jMupcvNxMAnB2keDAmAZqnHvorDcmcgoj79VhMRlRgZW?=
 =?us-ascii?Q?2P1a/1faJoGrqU08w8vLxZdtUHAMKH+T2zA6tIIQZ3cNEb2hcDZa5M6wYAE/?=
 =?us-ascii?Q?MV0PWHxXrNgpDhmS8m1hH2J8E8k50hWEFgQ0bmu/x/lXq7NPGa90ufJDdmUP?=
 =?us-ascii?Q?ijfcBrVRA5E3p9j8sQ0ZKcF6xTwM9Z0BiV/iggJXv7Aj4sv3I4EqoeNmHyCW?=
 =?us-ascii?Q?03iDpnIsxinFSRH3qF2KNCUho0mYYRup04aC56/iC4GUIXIrMEmf0l++XvUJ?=
 =?us-ascii?Q?TMCqx8Y6xvQHste4jx2V/L4zv+mazfAmNEL2ep8MZ3gESAuFl4lQCyTyW4Th?=
 =?us-ascii?Q?WCSeQB/WtIWpZ64WieFWtTPsRftFVNZ9M2h34WMAhIY51K2xVV39uH1mgxEn?=
 =?us-ascii?Q?gVK2yWPnG/s2cyT9efNmjRST4xq7evo1KGh1AS4/RUoYvSLbM5QJMsZtKDcT?=
 =?us-ascii?Q?YpSZu24FKYX9tJok4vM3y+6P1be0AvjE/3QNLTzfuU3mgYfeMqNhTe2PWwzo?=
 =?us-ascii?Q?MB81iPtID0yinPCCv76SaECizdbHJchnQpLdJZlcNoFQtx/5y8Z6dVxGdfWY?=
 =?us-ascii?Q?7ayzo69QH/yey+ixfHvHOnhnf8IcRBaW1thGaycryEeeZcf5szxgz6CMV21I?=
 =?us-ascii?Q?R4B4z5/3Ke4aR5YTzHdPPIuQ1ZkTeggYVkFNb3FE/7zAuuAuWHD3UKnLJwSd?=
 =?us-ascii?Q?aP5iqksWf7KOCqjieVEZOGNVUS8Rd0ytiZ5mgYV8kXwSLDK/MMmMdBkur1M/?=
 =?us-ascii?Q?OnVXzHhsao2xh21PpWmbADt7rt2qdkq+n4m7fM/iwc37cumMHnV+2lTIqtli?=
 =?us-ascii?Q?MQkn5EEsX1Dew2cwNtd3jXkdvuqvnWF2jhjWX56UOAsAlkGFfHBUkU+9Zxfb?=
 =?us-ascii?Q?V8GWewrNQ1BDlS25Wc98YNQEwr5/Z1J3to+Q6VFHm0iZxuomXe+3P8xsV2xd?=
 =?us-ascii?Q?l28r9LoE0+soLgl/SqZYuHSFyxCf5GjHuCs+yAAKvmjDyf5F+6EKZR8Y2U+K?=
 =?us-ascii?Q?VPJVQy0EpuvpV46oobar7o/4qQqBDMYgbMCpZz15bAaRcCkAMK1p4v4mGGL3?=
 =?us-ascii?Q?SKpuqQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df24ea9-0677-4861-fc9b-08d9ec21e467
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 23:14:16.0825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgduZWKZSbYBEC+XT3ygZXBeEnq6KAgpZz5JpSz/fv5cYBV4AxmHoL4c5Jq70FPnrPLdDxq8kWeoloW28YYXY20vx0ZGTvf30rASPZsHq04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4884
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090121
X-Proofpoint-GUID: _n_bxwDVEw-hliyxpAA9vqD7_uzuZZdB
X-Proofpoint-ORIG-GUID: _n_bxwDVEw-hliyxpAA9vqD7_uzuZZdB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

This lets skip remaining siblings at seeing d_is_tail_negative().

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 fs/dcache.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 0960de9b9c36..8809643a4d5b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1391,12 +1391,14 @@ EXPORT_SYMBOL(shrink_dcache_sb);
  * @D_WALK_QUIT:	quit walk
  * @D_WALK_NORETRY:	quit when retry is needed
  * @D_WALK_SKIP:	skip this dentry and its children
+ * @D_WALK_SKIP_SIBLINGS: skip siblings and their children
  */
 enum d_walk_ret {
 	D_WALK_CONTINUE,
 	D_WALK_QUIT,
 	D_WALK_NORETRY,
 	D_WALK_SKIP,
+	D_WALK_SKIP_SIBLINGS,
 };
 
 /**
@@ -1427,6 +1429,7 @@ static void d_walk(struct dentry *parent, void *data,
 		break;
 	case D_WALK_QUIT:
 	case D_WALK_SKIP:
+	case D_WALK_SKIP_SIBLINGS:
 		goto out_unlock;
 	case D_WALK_NORETRY:
 		retry = false;
@@ -1458,6 +1461,9 @@ static void d_walk(struct dentry *parent, void *data,
 		case D_WALK_SKIP:
 			spin_unlock(&dentry->d_lock);
 			continue;
+		case D_WALK_SKIP_SIBLINGS:
+			spin_unlock(&dentry->d_lock);
+			goto skip_siblings;
 		}
 
 		if (!list_empty(&dentry->d_subdirs)) {
@@ -1469,6 +1475,7 @@ static void d_walk(struct dentry *parent, void *data,
 		}
 		spin_unlock(&dentry->d_lock);
 	}
+skip_siblings:
 	/*
 	 * All done at this level ... ascend and resume the search.
 	 */
-- 
2.30.2

