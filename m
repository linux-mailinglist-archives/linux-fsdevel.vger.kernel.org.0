Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C8F51F8AE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 11:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbiEIJje (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 05:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbiEIJHx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 05:07:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6009E1C742E;
        Mon,  9 May 2022 02:04:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24978wF5024511;
        Mon, 9 May 2022 09:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=G0rR36ThSFIbChCVzEJAhRJGTNn9TQ8DD6TrDp57kpw=;
 b=0LziLibLDpxT58KbSr2wHfV8Nl2FzeGmf9O8584hkqGU2V9yOtCZvkLy0sB3N4nRbbbm
 +SIVMhsQP7guoMXfo9yWgJB0FoT6TjDs3f7KN24sKjbqo/gm2BBsNCV4rWfsqCiwW5GV
 VmEkas+gIgVWhMihIm5M5SLERA7CBG3izuOKvdwRkt5yRu4Bh8FWLrSdU4p+EhxS4/R8
 Elhfc0RgqLWEuBcGSCd9gF4682d53HJtRwA/kNpb5zUowQhmbDN/0g2i4Lap+gmWOZMG
 JLpSepldc0qWDl9draWD77EwjUjlKsLxPrxMSM1rhNh1qSnrM4xte5sklksArzIoAwxW 3g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfj2auye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 09:03:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2498tYPW001573;
        Mon, 9 May 2022 09:03:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf71efg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 09:03:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBlSfrpunt8dk3XeRi9uCEXurLQEPaPIyQjNf9UyJvIjtIxjwnI++2VpLFz8KPi1w40uNEwuklF6sXiOVayshzplFU9plUHSM+1EPVBl1+2aZyrKYIgpgBbtW73hLQkxmhgED2YikD7cfvz6HSbuqdh7Hk8s3c/hecaGVrzkBRH0ZehcADiwVC1aP/aA1HF1rC/zxB2Ak5YnWRQhMZfoJS/Xb6mNTJaXzQTX1/NLbX5QC59JzTj7C3FB1T1oRNxghR/tPH1DTBjXcOlNA7m/1Yh1QlZijcOzE9T7QVCNuKVGtJKpD/qbHMA7CuARRkQsMmO2jCZE4UDJqDpTgqgjpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0rR36ThSFIbChCVzEJAhRJGTNn9TQ8DD6TrDp57kpw=;
 b=IG0xVCIJV+b9zAbvOKoORWPYOfMobpfEg3w9JbroO9+2McYvllfRV8U47K5Azd2gAKSfMdfXENek4NRDwbblQikjNPXo7vtpPOnTwiAx769cchKQ9NCVMJ1ui/QwW9ucPfJz3DNBISQ54SuEnY7HCsqD8ZhBdTnmJeMDa0zoftToE8ynyM1mCXi1MqWqY8iKWGJoEdOYfwJdl527jhQn/qgAodx+11ytxPM0eud7R5wJH9/zGTzMfvyimBWFBmsKw2rsEgS91zcUqxdBF2BZMr9RhjUZGrhf+mgtQwjIe9kXx3xoKdLqgMGy883jNvrJ2iXoCa/4s5ARIMQk9HUJ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0rR36ThSFIbChCVzEJAhRJGTNn9TQ8DD6TrDp57kpw=;
 b=R/3NVtMXgSJYv6jeLn4YevCXE2bMzylghqtMjpmTmWe0SMgKzu5Q311nno5xVdzcqyZhTpUO41Hq5tZM27ZVD7RJlQlqBv6uH6d09mwcdu/GFlAeYGPj77EAd0jeLSm6At9YVXRt51uN7dgOeo/qLzmtgyXqELNNOBW5GvK35M0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 09:03:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5227.020; Mon, 9 May 2022
 09:03:45 +0000
Date:   Mon, 9 May 2022 12:03:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/ntfs3: Don't clear upper bits accidentally in log_replay()
Message-ID: <YnjY58EpRzaZP+YC@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0110.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aadff312-bb46-465a-27eb-08da319ad26a
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4542:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4542EF348E65BCC6FC945C0F8EC69@SJ0PR10MB4542.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sHd8f5t1+qwBigVmCqztxoBJpLMRknVcKTXqJCV/9GjGRjj8bEIT5F9ajNgFKwAtcTg714J/ZgNrKVi7DgrCRifsX5t9/uYzbp/EN2WZdDxD+iHd3Zmyx9QDDux5a8tOoBmQLdquvoON2muG9iE6o8JWMlPa0rpLcCrJls7Wk2bKlOQUvHGmPusPXtWGbB2Rh5szcqmUr/X82U436DYhIZ7ykC3OQcViIxkShowAyZFGeXtCL72uQkUYSUA5Oz+L6tNWm3aHuHUiXG4X69B5Hxu4v/k3e3WvG59UVOfM9AOBEfGYSDMN+QkX83cw2eMMR4POLO+c0qD8PurQD+BlLjvm6wwSWXYLd2GH8EgXxxvNhcE39fyj4qIvRmcLXxf/VTdvU35ut+45dVsH33/lbQOoKworgwXjRmZGmAY1Lgy7X1Vt5XKgisir7SXWqb/tvywHusduRTwTjiKuG/B028IilGTkEgeEfBDQ6poUgImq/o28las5UADUpIu84c2jgdghfmSHi7Nw3JK6QDoVvcPmtJ2roqFe2MKowN+07RNo4UrTNimRp3xMSRb1njbAygiT7hPlkMbML2DQG21FE6Zws7kPaJLUFh0obhcMI6XSSymdNhxELkOn0/i+t3nI40iZrMF4C123rT5ozb0nwY4RfAXg1nugd6eK6vw2KaEqwhDCRyePvSw66WRVGEPYVDFhY6Mazhhlx1+ZAab/kmPjAZVBU3kJLUVWKLtrCaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66946007)(6486002)(316002)(66556008)(6666004)(26005)(6512007)(4744005)(44832011)(9686003)(508600001)(66476007)(186003)(2906002)(52116002)(8676002)(4326008)(6916009)(86362001)(38100700002)(33716001)(38350700002)(6506007)(83380400001)(8936002)(5660300002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wMyAFU1jTqD/cO+2uvNHBuHlCHATgdP5LOCGTh1ep6kBYwrojHoj0wJKeE3A?=
 =?us-ascii?Q?7NVvfuYBKzay4l4e3JnYM10WmcxblfQgqkFzS0slGA49GinOxbseLdztkWbR?=
 =?us-ascii?Q?D6rh92rPwS6sBItnxz9IJD47r7LLFpmDAA69tjW2UYdKxOTnbM79rJEqbs6w?=
 =?us-ascii?Q?YW5Z4LWEE21vOWDHsTaCa+IKlHQsyfYMLeTad/5a583jvl9sLoCeUa4gTyb6?=
 =?us-ascii?Q?LQKM6R9UlPOcprTDdxCmnxq9OlLDh0T0MmxqCLqk8ln7D7kW8cjDIdrWn953?=
 =?us-ascii?Q?KbzCJ51R0MKAPItIy1+Jd+0MFK8WBAsm7gB1/w077UqCUkZPV3El7aNvLZv9?=
 =?us-ascii?Q?YvUQaPOtxUoYdWcd6+7S2iSFDsNN3LsGzAq5Ny4v44QUBTYWgy188DwFBH9S?=
 =?us-ascii?Q?+/hh2bJ4KX+dKkXqOwHsutIOptdHXfsFcAtub3QBWEfu7BlN8YErTMnq1CiV?=
 =?us-ascii?Q?xnTIczq4a2sqQU+RWJ/skU62HhL333Yqz1twL1O88ENv8AYBhkFQnWghIxFO?=
 =?us-ascii?Q?lMT7ZHxWIx5U1dGgF4yvA+Nmvs6+n1wRyrcaK9zvtGQkVvQNzRZpGgbHB5kF?=
 =?us-ascii?Q?sUP8N5G1nyJ2V0xICPWUeav4bYUPWAT7Kv8OBr+ttZMCimJK3s82q+RALzix?=
 =?us-ascii?Q?79KEf0sgPK6Y/yJjDwhHNBcD8hn9pSDhiWawk7ho+uYFbtVHwwD+PXHBWnuf?=
 =?us-ascii?Q?0eyq3nEmZzC//O+1Ex5Pi8C6b9wdwKGQrU5X+3qUukWe4e+L4B7R6xDogD+S?=
 =?us-ascii?Q?LJhwhfagnIfcE27Vcvlzu2slR/HjucqP3sVqE+AEkafMkha4XxxXXxcUoX8F?=
 =?us-ascii?Q?m7Zjd6ff4vIjIBx/nFVXiwKLU/1Y810X6tylN+8Gutz/+kbGzgZsSAPK1kHI?=
 =?us-ascii?Q?PNbuQjOkgsOKybY8RPc1GvRpHIU9cZHJntt7VD0wy3zCNrA7NqmljDBLtRA9?=
 =?us-ascii?Q?mAV60yNAZ93TAa3ZcXalq95TRTfaTvzRwaANgeGQikF1hDovZcZcfzpf5tBf?=
 =?us-ascii?Q?b4jb7bIR0Qfa+2XRrvkUNxgMzWGPtNOuISJX1E1xhft7+Cr1i9Ws91nLq63r?=
 =?us-ascii?Q?4ZRxL1ouVoV6YbGpwQrOmDwUNlFUY3qiO7qKAdwe9QHYSrG+aMartiUfxFx+?=
 =?us-ascii?Q?sEcMX2BrXcaOGtH3t17h+H00+lv0CvK5oKW7uyb3Y5icyJEvclB7q+NDVf4m?=
 =?us-ascii?Q?6CNU+Cb9fXUb8NWosUJSLVq72QnjKhhT5xCfJ7NnWE/JfGwY+E5pHM/bgxiq?=
 =?us-ascii?Q?5VMVSz6he82Uo/AuS33Hq3RS9GVneMbT0LvoQecWZpKasEri27X+jvKpAbgl?=
 =?us-ascii?Q?VWe/tDfkbR2NOGQJ0u5S7kUA+aLzsV97JcYl1GK9kbCRhmGVFwtHZvuuxruL?=
 =?us-ascii?Q?io3doY+3Kt4Eh6uRYmfFqPBvrQuTaxf2zveCP616euk4ZLQkKJfR6BUiNvLo?=
 =?us-ascii?Q?43qPSfkIdVX3nVvUd8kt3QNe/lof9TwFd2+n/jCbkXMW2HgCTfQt0u4Q6eGM?=
 =?us-ascii?Q?Jzd4rQ0hRZOqCDSymG0K+kK/8NaLVy8iQvIlM6bWoxchrcbup+IEqopxk4hn?=
 =?us-ascii?Q?kAkxeT4doVBzA3mhjuDYNm9iaNZylrGFmRoeYJy2u/Q0vYxXLToLJF97NLao?=
 =?us-ascii?Q?9Ph8h//J8egy1nKWcW9wj2xWNDgnXHcBNu8HQlV7Cjlx5mwEbOsXIqX70es8?=
 =?us-ascii?Q?ulOJ9jDLn5/SF/2MqrXw5xk/sWUJ9zVrUh03KT0woXVGSvISJYwk2Ojv5bMn?=
 =?us-ascii?Q?drCxzAa4pIEXQvXi9tdYsPhItMTbmXw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aadff312-bb46-465a-27eb-08da319ad26a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 09:03:45.3899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: neyKhC/CJnWv/Kwk70yueQsI9/gywRa03MXdFagFDh8svysM2lVgPWXPQmIg6WRyN5h9W1nu7Yj6gcZwO3LJO5p/+o8kfh8e3CrisVDCef8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4542
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-09_02:2022-05-09,2022-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090051
X-Proofpoint-ORIG-GUID: IlReYy-NMdxDB1E6KTGJVh48mjVlGbZI
X-Proofpoint-GUID: IlReYy-NMdxDB1E6KTGJVh48mjVlGbZI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The "vcn" variable is a 64 bit.  The "log->clst_per_page" variable is a
u32.  This means that the mask accidentally clears out the high 32 bits
when it was only supposed to clear some low bits.  Fix this by adding a
cast to u64.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Why am I getting new Smatch warnings in old ntfs3 code?  It is a mystery.

 fs/ntfs3/fslog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 915f42cf07bc..0da339fda2f4 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -5057,7 +5057,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		goto add_allocated_vcns;
 
 	vcn = le64_to_cpu(lrh->target_vcn);
-	vcn &= ~(log->clst_per_page - 1);
+	vcn &= ~(u64)(log->clst_per_page - 1);
 
 add_allocated_vcns:
 	for (i = 0, vcn = le64_to_cpu(lrh->target_vcn),
-- 
2.35.1

