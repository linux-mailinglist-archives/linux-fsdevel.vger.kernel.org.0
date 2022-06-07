Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138CB53F7BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 09:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiFGH7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 03:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiFGH7d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:59:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB18FCC146
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 00:59:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2577KDDS026474;
        Tue, 7 Jun 2022 07:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=r9j/TO3HUkCsL3OLSYG+OI2WBIWgVkuKULVuhdS1t2I=;
 b=lnHRgSdYd4yScN9SDpOX2OnCReRR0ED/MthsI9HF96eqtM7NMZeHoUfeVox0LEt6QNz6
 Cof2mm+c7gxhM6KQrD2loOqQEHnz1ImjTfdUWViGqny4KGuJLByhnFJt2Cm2ovevrmRv
 EaUwcllx+u8jtLC0A+exoKSB4Omd95j3MQtIsXWqz4AB4KlJiWFcglBdWQyo3Poz8uw5
 GcCE5tgt7lsLLsOxXmK59FRujhBSiQA/xWKbFtnLRGDMsyVyHqVKfprmUf5YuatmDKCf
 0raKaind+4/DJmHQF9gBLQL1Cs+R2tRPk2pph9J+AwAC0K+0Ak9rAZYS3XG6gKvy3dG5 qw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghvs38jtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 07:59:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2577tvjT024899;
        Tue, 7 Jun 2022 07:59:24 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu2dhxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 07:59:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGQKksMOf8JqtnIus3tvG6O12SBh5xFt38CFs+40Y22JgALilr6IPDpbks65CxFGZISo9V7FhefbRrYypHjg7ga72+nry6Bj2pXb1hWjai1epCBs+P2RWfvIghYHJQh3A61vPSZvtVqPCDrBgVH9cT5GuRvTXyMvrvdNXr1Epkwh+5nkw0+G7K1EAdHnn5VxLxXe5ghtFwb9xDkz1FqJZOf/3SXyLBy7bCDPoEQpjd0PTTpY8nFYZalT7nGaKdDZtHegY2xz/VTW4Bu6ZZTdPAcVL/uwYhcdh+hQxEHzx8u3RgB/WqeSpKM9JtizGPl+JICMyahN9QqAYTFiF7KPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9j/TO3HUkCsL3OLSYG+OI2WBIWgVkuKULVuhdS1t2I=;
 b=QpnJvAn1fL6YbCzpL507s/Rdx5KUGVSnd07oUNSrXorCvZ3qC8KzQKcDoMg60lokRtM7+fkM/yY4akr8p3xVgUKUbz+2UGdgZ12HCglmEbaeFe6HTB4+iBUNSzPL4jcMf8rFPARiMbWgzK2p5me0cXfABXRx5DgW0M6Ri9IWPib1ixxIEyWLH4XTdS6wfnFzqXY6W9Smc3u4gx/+jo3dIVB5QciqGRL3v6XasaPeKQSYaGW0Ecj5i3BO4b2hFrD3ipi2ydTZ9ZlJvzFBbKb6lt+qOR0BAZ2C3rVW+eUtIvExDhbmT9VH2cJ/m3zDoLLWDZJgrCPrAdtgkhUhj8sU8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9j/TO3HUkCsL3OLSYG+OI2WBIWgVkuKULVuhdS1t2I=;
 b=lg0uI3zofTywnE3hqEeyUN89VOkqtZxA2mdR6h5vYHeHWFu5NZnapkoZ7XfzvWflx2n+Sr8nEhzY5dzpyBTmhw/Z/C6Fi6lFgdu+4nTzN4qWCq/GDjbuSMXwKvjLM0g94L+4VvUmVZx1uO3OfMNt16hb6xUZiKtSQUobL0cEDqM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1286.namprd10.prod.outlook.com
 (2603:10b6:903:28::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 07:59:23 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 07:59:22 +0000
Date:   Tue, 7 Jun 2022 10:59:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ruansy.fnst@fujitsu.com
Cc:     linux-fsdevel@vger.kernel.org
Subject: [bug report] fsdax: output address in dax_iomap_pfn() and rename it
Message-ID: <Yp8FUZnO64Qvyx5G@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0125.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::22) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dc70957-3bca-4a46-fa71-08da485ba235
X-MS-TrafficTypeDiagnostic: CY4PR10MB1286:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB12860EC18B1853E2FBF094178EA59@CY4PR10MB1286.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FfnijtGRNTZRx0TiCnG7qwsp/rQEJqgNXWe6X3rQwfplciWJoZeKW1+ayIeUrWYTxyJ7Xm8DHut6aBHI7UNhd+0dc2eiBzoJHH4/dQaJ5/ZQx87GhOmmnNoOSyHWpxiX6+2YU4jwJ+vYtMPsqYQtPpmNG31kDUeos5YzlJwzNqbZHD5JQ/gPa26WYCDEulNkBJYMYWhBGz8pg9uFdovF+pR62Ov1k5zi8gQPqiG+U4W2khm9Awgk5BZwCSFk3fbqsLFYPp/icSg8vB303znMKam5xAyapL55F7cYjfcla+YYeapXGLv4i01cJ4sKM+X4+OXrnJ8MeoyDwBU+OSGpnFDMX4v0DrukkrRWx1leN/q/5dhJvWgQ4y7AebPsUddTJdl1TKk5+qswTt4l0xxAlsVbU+h5ahktOOBgEd9SD8OKV/RLq46RABx1fH032os2pLUjufCStEg68x3WxsczCc0HfScy2fImynRQxYbq9UaQQK7ClcrTgEbUcuu9uGEwRdiasoTZFNTErxzglSUsBKt2DNRyHkhWFncgcqsY+2ycyVARitGvPDM7ca/hrCLanHk6fSrRkZpTaqA4nL4Z0fFiIzQPa50ziCTYbK5as5XKEF04o/iJJUd8V//Q/GVxMmrThu7WN3reGiJTOXL1DqyWnMuauBHIvTtCAdRaRhtNmH67m1wNVrLDoLiUm1yHQndAbXUQqzd5RL0ouMVuPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(26005)(508600001)(6506007)(5660300002)(2906002)(6666004)(38100700002)(52116002)(38350700002)(6486002)(83380400001)(316002)(8936002)(6512007)(8676002)(6916009)(44832011)(9686003)(4326008)(66946007)(66476007)(33716001)(66556008)(86362001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fx8/k7YBCzFCq3q465nQAwWZUltPXnkPufjFJx0GT46VBl9KRSXyOGKFYBeR?=
 =?us-ascii?Q?AcxzExm/ZqJRNGw8JPyjKRZMVK+acJlwCw65rcZC6I53gN2nF+QehphXS/BT?=
 =?us-ascii?Q?kEFNfjJRhfryEIiTjZwFSVTdYKmPLK+khTTA2zIemCHaYTEhiAhE9/lSm2I1?=
 =?us-ascii?Q?oLRGrvVl193qtXLPMm/mXKgSLNQYHlfhCZ8qwMBsieeBZfqWD7paMPLDgbvY?=
 =?us-ascii?Q?8dhPXaqdHa11TKX7g1gMVLYklZUVw/HdnmxBfpKTWPzuf6GV/eugCy+ngPP4?=
 =?us-ascii?Q?msKG5H0sw2LaWwYWNwL7fOg67KaPcX//ms1/3/8Kg6asoEASaX8eYPKWux7M?=
 =?us-ascii?Q?Hb5fKqWCJHdWZzhkUzZi9b4GzHWC7rID3xnbmkhREENtDnff0xsjAv6xvIlW?=
 =?us-ascii?Q?xkoYcYIz4TShv+JEGPEzVW/7gHAG9j6ph663mehrWKIziiVJihIdAWO7AIgW?=
 =?us-ascii?Q?pbsXbMGoZq1S+/0oRduE8UUv44iBaH611ioXtBYF+NsWJrP7TLqLuIGp2qLU?=
 =?us-ascii?Q?so9YiV4yoy9ZcaMQ5XWgt41mE4rpStkAZzJDhWvsQ8GoonIcwsefef6aXfeO?=
 =?us-ascii?Q?HVX5645QZBDBUsawgQBMu6TSGpwv3yHJufJxsROIznQfRwL1pEn+uHqjfl/I?=
 =?us-ascii?Q?OTYen6xod9HP8wT3FDC53uWc9WM5ZywsiSPm7surIQELrRkEHmSo/hWbSIZ6?=
 =?us-ascii?Q?LZLNh2mVjW5iwyoHxkPXNd03nafx6KxvhxtBaym4fWw7r7J+txAZ7ePOL2G4?=
 =?us-ascii?Q?bee/ZPSaQCzypPtRV+zzus1FbAgKWuUOeUUcPMNGxZWCcRB5xgesQw7M6K71?=
 =?us-ascii?Q?b/EVWil98x/MRe76100oF5jVlhP7Y9JPh5u8BV9gV28ILVRez97De61E5HdM?=
 =?us-ascii?Q?1IYmfZtb9D+hct9+2qoHZEUHEM+JJqftqaYSLRFdIC3csO9YDeWQKR4YvzWS?=
 =?us-ascii?Q?za8yPavf1lL9MtL4LEBVT6p6uaAIZ4zoBwUUmXLmJM7Hbjnnw44mUtaMuT0y?=
 =?us-ascii?Q?XSoq+3fYeMneFN88LHcGfqsQiH+fqUkozHPoRjEBM1c2CrNfOYq1gI5Vurnm?=
 =?us-ascii?Q?oBVm8mdINYNFegwuly+4R2rXHA620MphiVSHamDJ0VHIvPyo1ePXPeo+qQ6S?=
 =?us-ascii?Q?92w9xGaKdwh/PEUfeNFu7qIJK1KA50eR3IaRIAjyCHj/3Z4nQ6c3v/amvEO/?=
 =?us-ascii?Q?YHvTYKwicN74oWeSgCnRhwxF+Wbl/EfY0W84sUy4UFbDOKO7Cs7S+qH3Jmwg?=
 =?us-ascii?Q?/TKCOJ01TozVbVQVokad+SNY2J/0lfHFRrR6FSQ3FBf9POhqhXuV95tC/s+z?=
 =?us-ascii?Q?tjSZu7LDHlenwvbiJhLomiG9PWXR2a35FSD2tUjaXO5YK9moCQ6TnTaCn9rN?=
 =?us-ascii?Q?Aw20v0VxPyuNDLk6vfr9F06Nnzys3s0cpG0RIkvrzyy8CpDo7bUfFzNOOR3P?=
 =?us-ascii?Q?rstaq5UwZvHcYy3BjOQcLbCqynXQ9Koeo7NZyUzeZgakTwTslzjWWbOiYQq/?=
 =?us-ascii?Q?UT55ekDYQ82bnfwAsug0roX9BlbtxhSMeSCe/oyK/3yLJNpjfGi1SwOtbz4x?=
 =?us-ascii?Q?VIzJ43QlBIlXJBUTy4R9n+g2ZMlnBJ6zW2rzBtq1hDkDDKBLyqizSJwQMuel?=
 =?us-ascii?Q?cZKlSLUQzqirLZUxxRVom0kmvRxGfNTtniHBjH4ujcMnnTSyF8P1eS1szhxg?=
 =?us-ascii?Q?ORHqLPH3qTF9mFxvHyqP6+Li+AkKVn8ZEKUVUt4tFb5COmF51OmLEUOB45WT?=
 =?us-ascii?Q?krAD0LESto9+IbwY29re8DZVRA/mHrI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc70957-3bca-4a46-fa71-08da485ba235
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 07:59:22.8579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QI8Iis3rxhvmkR8M/4OwS1e/0nmXQeDVG2R1Ok1b8UIqnoN4dAXkva5J952Gcy4jl2bt9Fwo6VPhZWDllSYfTkRXto2qOvuqKZw6tW3oeH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1286
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-07_02:2022-06-02,2022-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=960
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206070033
X-Proofpoint-ORIG-GUID: 5rsFp7xdW1zkxDZHbeRQOPC6qbQQmcYG
X-Proofpoint-GUID: 5rsFp7xdW1zkxDZHbeRQOPC6qbQQmcYG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Shiyang Ruan,

The patch 1447ac26a964: "fsdax: output address in dax_iomap_pfn() and
rename it" from Jun 3, 2022, leads to the following Smatch static
checker warning:

	fs/dax.c:1085 dax_iomap_direct_access()
	error: uninitialized symbol 'rc'.

fs/dax.c
    1052 static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
    1053                 size_t size, void **kaddr, pfn_t *pfnp)
    1054 {
    1055         pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
    1056         int id, rc;
    1057         long length;
    1058 
    1059         id = dax_read_lock();
    1060         length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
    1061                                    DAX_ACCESS, kaddr, pfnp);
    1062         if (length < 0) {
    1063                 rc = length;
    1064                 goto out;
    1065         }
    1066         if (!pfnp)
    1067                 goto out_check_addr;

Is this an error path?

    1068         rc = -EINVAL;
    1069         if (PFN_PHYS(length) < size)
    1070                 goto out;
    1071         if (pfn_t_to_pfn(*pfnp) & (PHYS_PFN(size)-1))
    1072                 goto out;
    1073         /* For larger pages we need devmap */
    1074         if (length > 1 && !pfn_t_devmap(*pfnp))
    1075                 goto out;
    1076         rc = 0;
    1077 
    1078 out_check_addr:
    1079         if (!kaddr)
    1080                 goto out;

How is it supposed to be handled if both "pfnp" and "kaddr" are NULL?

Smatch says that "kaddr" can never be NULL so this code is just future
proofing but I didn't look at it carefully.

    1081         if (!*kaddr)
    1082                 rc = -EFAULT;
    1083 out:
    1084         dax_read_unlock(id);
--> 1085         return rc;
    1086 }

regards,
dan carpenter
