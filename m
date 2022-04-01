Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AA74EFB9D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 22:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348790AbiDAUaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 16:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352798AbiDAU37 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:29:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD825276F86;
        Fri,  1 Apr 2022 13:28:00 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231JOk5n014677;
        Fri, 1 Apr 2022 20:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=kiwJ0IkDgsLb1P7y1cchbq2iFJsri/WWopPRY4bnyKs=;
 b=rpPxWQxiREjg8FGvBM3Kord0iqG0fwo67VSyJMCG39SWw3sdZiHnq9OD4rTA4QhD2FX+
 lq+DwZ1xMCv1yGsLwSmexan/qwodeTUwYE1xCapNrBU3bgVIhvgJHbdgX4zPySzZIuwC
 y0Zk2CX5ZUOQR1UoFJSwz58JjHYCH2udLhhhqqpc0I4nUiLJWrQRWutVlkusTM9eg6zq
 7O9nhxqVLHzxoa5r2BGjrNuMmdAOZeU9vpyI9fOF2F8+32Hvk8q7ZXUmJIgNkTyNjlwm
 wriTZ/0plFoDobACDuqXuRDwFVDGa+cvR/X9jSXlZmt8TCkPxumRO4tGZiuOULsaqIq0 Iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cyk82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 20:27:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 231KGTAM020369;
        Fri, 1 Apr 2022 20:27:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s99cbvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 20:27:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0kGpRECeDSEeLH/binRd6/elHhzn0j/z7C3UHKWJw4oblP9zHQB8PAy6L1biVJ5vgNulmxifOJaFl5fxFhv8HqRhtBv13LMOVZ8f3skOkHkXBm6USavwFqUX065woUKGO0AmiLyVJRDoia9bZeYyDD/AYiAl2fMwwGAZeA+c9HUURG1jNIXgaNm4ft8ZuOOi7bRMkSvBoo+UgFY5VHB0U9+rjkmpiZ9pEG234QKDgc8E25Lj5pVDRLp0RjJf0zxtfZehqSTFfDMRKsJHKxL3B3XKZK6jRcb0OAFIX/jkJq0bwajQ40WeH3kiTMhfq4SUgfu4LLul0YcDCjGkRhnCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiwJ0IkDgsLb1P7y1cchbq2iFJsri/WWopPRY4bnyKs=;
 b=Azpk1Wq0KjyHo4g64opTOoCdzDjY8fZ7h8OsTWUPkOMXIvTy0pHcgfD9judHs2I20kWRCNrBHzy5/IW6ndnz++N3Y1U+mNGF+0CA/EligDdLTY6UUnWy0pfAok54N8MrITFuYW7+6osU6kcH0iCdK1LLcOpW8ksHU1J5SFD3f2cG+IrqXnTJpfBtjeiFZoDYD9Or1DjJ1FEG2MWY3cN6C9vMvE8F1poPVWNBha5+5h8NsrceekZWjk3dxCuxEnC1Zm3DwgdaD5EykAf/qExikg/siaboO9uToWkN1ZlSIurxjdXrW9qcA4++hrS3o4Mdd5Y2AWQwm75qHEViMICk2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiwJ0IkDgsLb1P7y1cchbq2iFJsri/WWopPRY4bnyKs=;
 b=eWC1DMJMdb6XlIP6thuXpr4Nyun5VgXWUejHleJxe7jTAef+mztSZtMrg2qRxBi8Kyc4oEY/EhOgi4VtfykBA3ljasZ8tlh5xIAzRHqzgBenELoc3TBy+83+YJGqZ/hHJMsrTq4Ks2fnc5L+PVxmOI6iCz7IXtnquY9UcQzMfWc=
Received: from SA1PR10MB5866.namprd10.prod.outlook.com (2603:10b6:806:22b::19)
 by SJ0PR10MB5647.namprd10.prod.outlook.com (2603:10b6:a03:3da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.29; Fri, 1 Apr
 2022 20:27:07 +0000
Received: from SA1PR10MB5866.namprd10.prod.outlook.com
 ([fe80::25e3:38e5:fb02:34c1]) by SA1PR10MB5866.namprd10.prod.outlook.com
 ([fe80::25e3:38e5:fb02:34c1%5]) with mapi id 15.20.5123.026; Fri, 1 Apr 2022
 20:27:07 +0000
From:   Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To:     corbet@lwn.net, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, linux@rasmusvillemoes.dk,
        ebiggers@google.com, peterz@infradead.org, ying.huang@intel.com,
        gpiccoli@igalia.com, mchehab+huawei@kernel.org, Jason@zx2c4.com,
        daniel@iogearbox.net, robh@kernel.org, wangqing@vivo.com,
        prestwoj@gmail.com, dsahern@kernel.org,
        stephen.s.brennan@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [RFC 1/1] kernel/sysctl: Add sysctl entry for crash_kexec_post_notifiers
Date:   Fri,  1 Apr 2022 16:23:00 -0400
Message-Id: <20220401202300.12660-2-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401202300.12660-1-alejandro.j.jimenez@oracle.com>
References: <20220401202300.12660-1-alejandro.j.jimenez@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:4:ad::48) To SA1PR10MB5866.namprd10.prod.outlook.com
 (2603:10b6:806:22b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d27d605-a5a4-4a5e-be66-08da141dfdc0
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5647:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5647EF204E813F956704A972C7E09@SJ0PR10MB5647.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /k6dUuougoQMOSO+tIOdgEgwC8gRa2CTp8kk5uLuebxihK4zPqmxPwnfhElBhI6vJqeuA7zpZIzQ2wEX8veeWC5KvmP89F+y00OfOpsIxfGGkz/1sNsegPAJMT/xYK6so8SMGsAZ0ZFlcjtZZ1mdVs2KFoUdtFdMrZHN6es0JkQ5LDAaZmiLUpxQrjUuHRj9PlWdy1ye6FsBRtepYTHrO0/vF1+rA+7UeXGUIR2CJ9MmE+FboIn3KckIbe9ITQD0UtO/RUBM9BH5QWrO6S1getmxH8fznOJWB1pu8j9zEz5ndJ5qe5SgLV4frIbOkXQA34/XesC7Wp/STI4F/oJCbmM/iyQXKTnIKG1DcXj0QZDQVLVgP3K0+OlwVuQ8TgA2KvkvtKB2rloHj0pcza9OSSfD6obT5/ftgTQNdZba87XCgsr6dg0ssymLUfn9SrMzUEA9XSUV1pl5QKU4ZcU8bq0g7LCt2RAwHaQRkJg2p/E91HSHvZj5UAjBpyegzMsEkWxR9nuIak2/VSm2LdybQRGyUJvYK6LbJGEELsu2t5E2ENYRw3vOqf+QybtvlmtfcVO+xx5U/79NKTqCU36wiVa8DW+CFJlibfRWglojA9g61m88WBRH8n6Fi2v5kjjRmKdx+mQopfKptjFQWa7p31ONRH8HYkMRvEDjgws78DSyQReRRo9xOXi8He8lZDMxTddvboenrdjnuC7ZHzv8Bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5866.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6506007)(52116002)(2616005)(1076003)(26005)(186003)(107886003)(6512007)(103116003)(38100700002)(38350700002)(83380400001)(8936002)(508600001)(316002)(5660300002)(7416002)(86362001)(36756003)(6486002)(8676002)(4326008)(6666004)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zv1/rZJ1pvXYiyR8/+q7pcMDDrrRqSLoPs9DqtEVfT4VV9TEKtklBzIHDt7C?=
 =?us-ascii?Q?8cNWgLnxCYNBhIlqMRwEISpoxfiAmOkg+qeJvZhej8338dd51zLBIsjewDcQ?=
 =?us-ascii?Q?bo1DxKKukjLJAvFqzhNFQKTe9bgAEDxRff5zjwjpYJxr6dn0jJu6PQJHWuLs?=
 =?us-ascii?Q?ADmlfR+kEV3o4Eg2g7ldAHl3sdSFhTIFzQjyviHWDOvi1k1mAl4bnRi2jK4N?=
 =?us-ascii?Q?G/Vz00bmYKWjt4klQPsutRUqmNDkEfHVYEoTWDfePSbK/Hg3bFOUPQpWdGsR?=
 =?us-ascii?Q?JWPnt6OBVHkXn4Dj6nBaKJOH3fPOz+fhX8BnY704SCiZFXb67IV0G0qEKT2p?=
 =?us-ascii?Q?HmvcRqOyj5xCP0AFjFmWGJG2I9en4UfM+zZy8srezhodkhwyU2x9RwgoPnt8?=
 =?us-ascii?Q?YpBJAAZWhmp0SzzE+UG/cPG9d33/4bJ25J3CrgSXScEF6FMyy5DXyZqFvvOa?=
 =?us-ascii?Q?Yv6+wo3D+2ZCMuFLcOUeCkLQpPNH8KXWcVnbUAuxluMB8s0b4sn8yj0LMEjI?=
 =?us-ascii?Q?qeoob+3Du61mq9EljNNksxyXEiFiuIkoLKn2YqwwC3WkDkVtSR2OXAZLnct5?=
 =?us-ascii?Q?djHOL0okWiLxJs/pzRANVMddnqRbUYnyI+MyrCeauXjsFjJfjPMzZT7NpxYK?=
 =?us-ascii?Q?lYN27nKgM03lmKb2b3vg1P8ZaiUp6T0cn1RMI2t7SZRmwhkak678dshqWd3P?=
 =?us-ascii?Q?MF9+V/mqgytUeXeEcpUI/eK3z3oJ5+9T20IctwmIZyex/3UHpwcmvlYATxdd?=
 =?us-ascii?Q?rwAi1Lr2kR6BxorCAUQP444AeTgGynevwhFlLZvUD8/JsL47mCx09cBTkENR?=
 =?us-ascii?Q?xd/eQJCy2l7sNUpPM+pRvWM8fgdtAUJE1CWIb1JJsZiS/h75YXV2iqugPmy6?=
 =?us-ascii?Q?MNr1ani9hBIF55mqy1sZLF61l1YHOS+lquS+koEhpO7p/LhfxN6x2Cq13ON1?=
 =?us-ascii?Q?TXTJlozDu7V4rS6vF5pkEeP2WgIgZYxu5/XXVOp+nboNDDkrAuZMSOOmZUhW?=
 =?us-ascii?Q?2dvMtcbF0fg6ET7nYDopeEmLaUclQI/dSfKBpHjI8Iu+9PSTvvT6EwrpKey6?=
 =?us-ascii?Q?mjGzjCQ3cpMM7Sv2ufsEeyjVSmtDlcYHlSpRKIU0qjZQrGn6vtm4mxxpib53?=
 =?us-ascii?Q?4Pvsi0a6JkAqM90f1KGBfQgEJmlqi8j8oKn8WmDDGkETb/f9KmkmM7uSBluV?=
 =?us-ascii?Q?JuTA1COQg31rUILoLiR8AhPFQJGUAHidH8MMW19jdmqBB68U71yO/wMGibD9?=
 =?us-ascii?Q?gvHVLq8NOBzATigr1n68Mp2x8OtxKXtQ8HXLcgOQh0EmqePbUBvCRgXCwzdr?=
 =?us-ascii?Q?iA7Jui1C27TDG8do73Qj75fYP190HhN4E+TWDHJWrKiUJ4Y2XsUU1dUDwUSA?=
 =?us-ascii?Q?h+bYllRGvjCvpzbD2npPnplhGA5OFB9ubvups6rqN/unvUj1nTpcLv8pX+us?=
 =?us-ascii?Q?//TTwRN394BueIA4t3Mkdl7IKFL8ktCRWqLxeC6Q8V2attMmMgJz+Joi+OuX?=
 =?us-ascii?Q?NSruM9hOjwWQQVzuw5P4IKT1PAL6XE8olU1VHx3re/As6SHjX5fLIYYVFegY?=
 =?us-ascii?Q?WHDlGy/56jpsyBSbbB8h+OE8p32BQAbRd2McFIdwBM0JdTJD2bAA3g4Q7kE+?=
 =?us-ascii?Q?NjR9qNZ2D18HAHTNJghc32JVoTVPoWWbm0nbBeEMPlkwXn6BDSWeQBJNJsD+?=
 =?us-ascii?Q?x0iRL811utIWWjpQnh4lzDxzaAIYi9rQ08s/lzImjXhDbngl6uvjGXjmVa/U?=
 =?us-ascii?Q?loTFDYLcs7tJZ1iYiqA3hgNBMfPsZps=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d27d605-a5a4-4a5e-be66-08da141dfdc0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5866.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 20:27:07.2408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4G3ct08gXperrbh0IUUtwFEmnCS1BYQBD8NrJJAJLxvdYFkBMTEQAVyIFQ4E2odYdJHIVcgNrIX8ZKpNtLDTZOchj3xX6CUnS7A93bWkII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5647
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-01_05:2022-03-30,2022-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010097
X-Proofpoint-GUID: GOVPbhHXh64MnadK0BiKWv-LQ5lmEJmF
X-Proofpoint-ORIG-GUID: GOVPbhHXh64MnadK0BiKWv-LQ5lmEJmF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a new sysctl:

  /proc/sys/kernel/crash_kexec_post_notifiers

that allows the crash_kexec_post_notifiers tunable to be listed, read, and
modified via sysctl(8) at runtime.

crash_kexec_post_notifiers can now be set via sysctl:

  # sysctl -w kernel.crash_kexec_post_notifiers=1

or using the sysfs entry:

 #  echo 0 > /sys/module/kernel/parameters/crash_kexec_post_notifiers

which is also available for other core kernel parameters like panic,
panic_print, and panic_on_warn.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 8 ++++++++
 include/uapi/linux/sysctl.h                 | 1 +
 kernel/sysctl.c                             | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 1144ea3229a3..8e07121e2a58 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -213,6 +213,14 @@ If `core_pattern`_ does not include "%p" (default does not)
 and ``core_uses_pid`` is set, then .PID will be appended to
 the filename.
 
+crash_kexec_post_notifiers
+============
+
+Allow the callbacks in panic notifier list to be called before kdump and dumping
+kmsg.
+
+0 Do not call panic notifier list callbacks before kdump (default).
+1 Call panic notifier list callbacks before kdump.
 
 ctrl-alt-del
 ============
diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
index 6a3b194c50fe..921e3ea01881 100644
--- a/include/uapi/linux/sysctl.h
+++ b/include/uapi/linux/sysctl.h
@@ -154,6 +154,7 @@ enum
 	KERN_PANIC_ON_NMI=76, /* int: whether we will panic on an unrecovered */
 	KERN_PANIC_ON_WARN=77, /* int: call panic() in WARN() functions */
 	KERN_PANIC_PRINT=78, /* ulong: bitmask to print system info on panic */
+	KERN_CRASH_KEXEC_POST_NOTIFIERS=79, /* bool: call panic notifier list before kdump */
 };
 
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 830aaf8ca08e..8e0be72b5fba 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2339,6 +2339,13 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_INT_MAX,
 	},
 #endif
+	{
+		.procname	= "crash_kexec_post_notifiers",
+		.data		= &crash_kexec_post_notifiers,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dobool,
+	},
 	{ }
 };
 
-- 
2.34.1

