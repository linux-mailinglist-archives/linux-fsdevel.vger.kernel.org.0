Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBC753F8FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 11:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbiFGJEb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 05:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiFGJE3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:04:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8BACA3FC
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 02:04:25 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2576HX7T002917;
        Tue, 7 Jun 2022 09:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=MEzQgGXHPRBXP85zndpndDWo8wazMnYKkW0/bAges4w=;
 b=HGTWLHauWW1GfiybAwfA+OcdNDegTtiKmkBuv0XQu6sWHCMSmqTLk6nlgdN9syBFKN0Q
 kGwdA2s/cQD4CUT4lV6znjC063eBfU+wZJpuhJB82+uwz3v7hido6W1olPQMHUe8Pcs3
 jGyQFKFYVnF6pUAV9sXkOseFjILdrE7p5mgzi5f1YbFB4dKgGYPXgdJSODHxRz0QkEDy
 sMQoHPq41oiorFc2c/XdTvuq174OzJu3p7PK3TIk/ys4mSFJHpZgPRQmQH0HVQzYR0qs
 kAHXZBX3WMCryw3b/h3TfGfTHOt8SGdWJd93VKvW+v6N8LeKKIh6o9p2jLxylHXGVRZY jg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ggvxmuh9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 09:04:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25790S9P031101;
        Tue, 7 Jun 2022 09:04:17 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu2ay27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 09:04:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBzspaAxmLzOYiL75qRjc9msQzl/baOWG7l6Sg4byj2bxPLtXbK00TtNKWrpwCawrBT7WgefxXO1AqwVXSo4ZjIBSP1tqwEwugL9uLnO27XiSKpdtPULwt8jUjQamPBM3fhUjCQZeleDraNytwc6zLX6V8+CNvzU0Mn0c9uzNMWwuBkKi7od+Ao7xfZ8LRI/EOh++ZkLYdSgFxBHlePiCoivktgJ8raRK9IumjbLShyWlxv/x5mlOYZRhbNPuy0ev3yfzqNP7T60XZnFYoqNxgCny0khvd+rmST5LyR6tIJ88ujQOLweE/sxHocNWecB1y2rOtJm24TXPxtyunK7IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEzQgGXHPRBXP85zndpndDWo8wazMnYKkW0/bAges4w=;
 b=VQpx0lH1HR1+QJdTOqtRF/nMCpCwtVQmADxxEKWHYH5sWNDsp7iTvjQ26J/H6u97Nas/0aRFGJQwIxxs5q0woHsrIMX2f7YVuoeAmreMOHyv/hvqSEHMUOcITMInIusvYSrFePzsw06h7TfC2cfwCeWg7laIiIGMdAfl+lsIsnWLy6vjan0xbdApHi2HfirsRp8qx41GlrKZiDZhQt5aaGIYmUQoZ0JvA17RVk/DfaHTUwASHmpY7L89YtbaavZTSwBZIfh82bex5UeemJ/N8QyVZ+9sbx2gtSJR2dWoxswjeqH5wJaQgLSgE5A5bIMZq4pCsbm0kIvLeLUBe3kduQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEzQgGXHPRBXP85zndpndDWo8wazMnYKkW0/bAges4w=;
 b=CfUDWfJ8WbaH6PS3yVIIbApVrCCMu4Sok01mxL73NfThtyRJfoZ74X9EDDY+FTuTuCOfnzAvDnyzAVp5uxCFWNLD5W0zS+ODZbxacoUstEO2y4hPVEf7Gx5DWd5Ywl8uTbMZ0eEGzi4ceRIMU1cehnOQis341REQ52HAI5B6pxM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3172.namprd10.prod.outlook.com
 (2603:10b6:408:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 09:04:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 09:04:14 +0000
Date:   Tue, 7 Jun 2022 12:04:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] fsdax: output address in dax_iomap_pfn() and rename
 it
Message-ID: <20220607090405.GP2168@kadam>
References: <Yp8FUZnO64Qvyx5G@kili>
 <8d640912-d253-bcbb-fcd1-cff645fb09a2@fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d640912-d253-bcbb-fcd1-cff645fb09a2@fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0004.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83d132bb-3fe2-4a12-2465-08da4864b1ef
X-MS-TrafficTypeDiagnostic: BN8PR10MB3172:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3172FAF19FBECCDBC48EB8DE8EA59@BN8PR10MB3172.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/ZJuMsYzTi8mEwC8QTdd1ey+cLSxAOP29l2IhmA7X0NbJaHhJaOgcNrNk6PiaPGnTYzpdUohKo11pTJEgjLH420PptSBD9V3K8RoPBICZg6fuR2fsErSH0t2zQDOzZz4DGGxgXN+mf+xJZCVMMYk/uJxv2r4ei/jYVg/OqaTNXidqawuG8zdGhwHo5vRpJ8JWlg0NWZ3BtzhNKMdjroJnXMqUxoRnd2IGMlQbKOkKgSwoRUmLou+1YywjG/pPXIs0q2UaV3qT51/nCh7xlssxkGVtiMnvcUDrJhSPqHajpkOa3vYQ/uPM44sjU0nlk42BJwZQDHs0pmpJsrTYG7ms1tJRehaA+jMjeFN53wbEifgkoezOlYann9N5kapDtNhllpbipEO5aZz48pPFPkG64f/sXtp5+dV6+42vJQbdl6coyoJrme2tRI5AR0vpXo9aZMU8KVyHmgIMPo1TjuSZlLs9V0Gp7uQhf87zU4nLGrLSxdrm6dIpq755kpWmmnGSgji2/K1dB0Wt4rnbtfhHgDB+XtpqAuJIu2ajVUhIOjVsasW4Pp68o0OxHAQr2/FBqJSnWxdGJtMaoHvp/rIgS32TMtXAxzjddMcK28lK6QdgfjNlU0qPVHv/Ls736f+IfaTbgO82vQMP66wXltPTjcgHEnYs/Cn7uaP5KYw4pKHMfwO6/iVC1aM76bmA11EDjfRgT5yruKvU3u8iCYsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66476007)(66946007)(4326008)(66556008)(5660300002)(8676002)(6666004)(52116002)(83380400001)(9686003)(26005)(508600001)(6916009)(38100700002)(33656002)(8936002)(6486002)(316002)(6512007)(44832011)(33716001)(186003)(1076003)(2906002)(6506007)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clExNTRBbVJGcm5lTWtvVWdUeHluV3BUQU95N0hLU3g2VnFIWmU5alBxdlNo?=
 =?utf-8?B?OUJ2ellLWlZIVm5JSXdZbm5jSGVQK0tZMUQva1FSb1FKNUJiT1R2QVNTZ1FI?=
 =?utf-8?B?YnNUQ1h2bzN2KzM5K000VDZIc0JGc3JYUkZUNXRNRHRzc0JFa2ROS3lNRUlx?=
 =?utf-8?B?OFBHMjQxSGM0TXpWZk1YMndua2Flb0ttbEVvTUxScm1TU2NaQ0dQK3YyWGYv?=
 =?utf-8?B?Uy8wdmE0OFlDdG5FRE1uZkdFdnQxM3NhR01xOXpycXNURTRnSEZwbERmcmFV?=
 =?utf-8?B?Um9sSUQzSFcyOHV2UDE4a29CR3BQL3Y2MkFWdDBueW0wVFZmdUhDQkZqQm5C?=
 =?utf-8?B?OXNIWXQ0UXB1NWtRc1U0emJlZS9iZUloM0VQbU1IS2J4aUpiWlc4V3A1SFpL?=
 =?utf-8?B?dm9ya1NXUnpCUWloQUt2VTVkUnpjQWJoWWtEUlNLNEpnajJrSXV2TWR6cmRP?=
 =?utf-8?B?ZVpLYTdnZUhzTjBxZStJbWRkVGUrdFh3b0k1RERJcDE0Mm9nNm1JbFc5cURi?=
 =?utf-8?B?VWY1QVI1WVR5OTVuWXNha280VDRNa2d4THA4cFZkK0k2MmdQVklpTlpnc1RT?=
 =?utf-8?B?OURWMTlRMHRhekdFcUlaSlJRMWd6Mm9CZE8yalVUU3EwZENZalV2SksyUlJj?=
 =?utf-8?B?TS84NHlmb0tiU3l3TEJxR0JQenFQT0s3MXVLTXJoamljK3dHWnFvVUYyMnNn?=
 =?utf-8?B?TFBvZ0ZJeHJSc2lxMDVZSVVLOGQrV0NBa05oRERsdjA5MnZuenJEN3hmNllS?=
 =?utf-8?B?UjdCYVQra3htQnI0aUw4cGFMNWNaci9ncUlrVVlWbFFQR1VYWU1HVytCWExu?=
 =?utf-8?B?RWRiSjA5R2lRVlF2aVFieTlhaWY4Z3BtK29VZ09mdEVhYXpIN2txZE9QZXlZ?=
 =?utf-8?B?WWw4em9pR1FTL3pTYTRWd0JOQ3F1R3NPYWRoTW13ZXRkUDZwczZzU2hJdUtl?=
 =?utf-8?B?T0FRZTJnT0dCQnpmL0hqQmhWQjNZbWlEUjE1QnRGWEdueFN3MmMrNmUwUnly?=
 =?utf-8?B?WHZTQTFCRGxlN0tNNVN6NGtGcXlTQWhUTHhFTm8wLzk5ODVRcUtLQ0xqMDU2?=
 =?utf-8?B?RjkvTzJwS09LU3p0b1kwK0pQamtPcWtWeGpiblBaT2VtUnNWa2N2TmcrVDVw?=
 =?utf-8?B?WHZTTmdqQTIvQzA3QVJORW1iM3RVWjBVbEVhZGlkTFhQZlRwc2VmYUF0ajN0?=
 =?utf-8?B?c1RGKzVqNGpndkhXT3NsN1d4U004U05MbXA5SWJ4dVpweXQwRWxSeERBMkh1?=
 =?utf-8?B?T1l3UGJDYVA2Q3dlTFl3aUJ2VytSeDhCcFUxbEpaZm1PdVY2dWdYb2xwNEZ3?=
 =?utf-8?B?WldodXpWNWUweTRpb2hCNjc2K242cjc3NStkTDBZaEhrNWRpRWpNMXlXaGJ0?=
 =?utf-8?B?K3FvMUdhMWJvTWJPQUN4UzU4ck1COXUvMWU1TlF0UDBrMi82K09KVjVrbEhN?=
 =?utf-8?B?Y015ajIwNXlrN0E4RjJrNWl6WThDbTYvTzdtb2NhUjNkdHZmTlViM3RWRlNG?=
 =?utf-8?B?T2ZPS2FTSG1WTmdhblgyQ1cvdkNHNVRNSSt6OVZzdWQ1NXFMYnJLaGpIS3M2?=
 =?utf-8?B?SFZkdThZUS84YU10dmJzSU1WQlUrOU5GWkh2UmhOS3VBY2tKYjFwTVRTMW01?=
 =?utf-8?B?NzVVNXFTc1pGSG5EVS9ObjB3QlRPRlA2WnlkM2xyOCs3WHNidy82U05PRGJp?=
 =?utf-8?B?QWRWZ1pMOGozOHQvaUNIQVNNaHJBdDR5VldmZWd0dWtveTRQQ2lFSVhvN1o3?=
 =?utf-8?B?QXJqeTQ1SzYwVGcxQng2b1NVOEJhZk1nWUdLRkZnWnNraWpTdStSc0o1OWdH?=
 =?utf-8?B?Mk9uMEkyQUtVOHhWSjNza21CMDN1OG5RRldubEpqY09XbTRrQkpIamFwTitT?=
 =?utf-8?B?MHhVTEhub0c5SGlJc0xycVQvQ2ZYWEZPT2FqVUVkd3ZTTkRTMWRydDI1K2xp?=
 =?utf-8?B?VUI4ZFBqdUFBOVJQTGlHVHFGcUNaV2RkNzNIODU1ZnVBM3hGbXZJbUNoLzZP?=
 =?utf-8?B?NUpMNnE3eDUrcnRWUVdWd1dQMG1GZVVHVHBSTnRsZXZHdFQ0Z3RlaGMzOE00?=
 =?utf-8?B?Zk8wcjV3TlhnQWZoelR2bVBRM1FTcytyOXVvWTQvREd1dCtCWkVRUEhhRzF6?=
 =?utf-8?B?NHIyQS90WW1nYzhMSFNPaU1paVNmaitXZDVibDZFaDFmdVZlQ1Q4WFEwZmxB?=
 =?utf-8?B?aUVIanB2eCtDUkdvUUh5VUxWdlYxU1lGZmp1dGQrV1V1cXQ4bWZmVlBRTnh6?=
 =?utf-8?B?OVZGMG5VbFI4NGFUdWYwVnJjYkdSenlSM3JycU13N255NUVIRjFyak44Szl6?=
 =?utf-8?B?Q1U4UGh4MVg1cHpIaWpxWkVJSHJiTXZlWnBWemM2WUhTblZoN2dGSXJVVUtx?=
 =?utf-8?Q?BBkjE71w1ba99KCM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d132bb-3fe2-4a12-2465-08da4864b1ef
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 09:04:14.8796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8V6iK7sPUY2ice4Sc8v2ZSEb5RBu9UKx829l4fWulWVpdBIdN/5LN2Ejvz4Vtpv7xKkgNKhws2qUXU/4kaijgGmDW6r8GsfwKDaDNL3WC+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3172
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-07_03:2022-06-02,2022-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206070037
X-Proofpoint-GUID: j9p-Hy7qTwr2uAH2c2UpLnyYQnnxZriV
X-Proofpoint-ORIG-GUID: j9p-Hy7qTwr2uAH2c2UpLnyYQnnxZriV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 04:54:29PM +0800, Shiyang Ruan wrote:
> 
> 
> 在 2022/6/7 15:59, Dan Carpenter 写道:
> > Hello Shiyang Ruan,
> > 
> > The patch 1447ac26a964: "fsdax: output address in dax_iomap_pfn() and
> > rename it" from Jun 3, 2022, leads to the following Smatch static
> > checker warning:
> > 
> > 	fs/dax.c:1085 dax_iomap_direct_access()
> > 	error: uninitialized symbol 'rc'.
> > 
> > fs/dax.c
> >      1052 static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
> >      1053                 size_t size, void **kaddr, pfn_t *pfnp)
> >      1054 {
> >      1055         pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
> >      1056         int id, rc;
> >      1057         long length;
> >      1058
> >      1059         id = dax_read_lock();
> >      1060         length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
> >      1061                                    DAX_ACCESS, kaddr, pfnp);
> >      1062         if (length < 0) {
> >      1063                 rc = length;
> >      1064                 goto out;
> >      1065         }
> >      1066         if (!pfnp)
> >      1067                 goto out_check_addr;
> > 
> > Is this an error path?
> > 
> >      1068         rc = -EINVAL;
> >      1069         if (PFN_PHYS(length) < size)
> >      1070                 goto out;
> >      1071         if (pfn_t_to_pfn(*pfnp) & (PHYS_PFN(size)-1))
> >      1072                 goto out;
> >      1073         /* For larger pages we need devmap */
> >      1074         if (length > 1 && !pfn_t_devmap(*pfnp))
> >      1075                 goto out;
> >      1076         rc = 0;
> >      1077
> >      1078 out_check_addr:
> >      1079         if (!kaddr)
> >      1080                 goto out;
> > 
> > How is it supposed to be handled if both "pfnp" and "kaddr" are NULL?
> > 
> > Smatch says that "kaddr" can never be NULL so this code is just future
> > proofing but I didn't look at it carefully.
> 
> Yes, we always pass the @kaddr in all caller, it won't be NULL now.  And
> even @kaddr and @pfnp are both NULL, it won't cause any error.  So, I think
> the rc should be initialized to 0 :
> 
>  {
>         pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
> -       int id, rc;
> +       int id, rc = 0;
>         long length;
> 
> Do I need to fix this and resend a patch to the list?  Or you could help me
> fix this?

Could you handle this?  Is this in Andrew's tree?  I think you send a
follow on patch and he'll eventually fold it into the original patch.

regards,
dan carpenter

