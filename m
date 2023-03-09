Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B1F6B28CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 16:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjCIPZK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 10:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjCIPYs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:24:48 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAA020A3A;
        Thu,  9 Mar 2023 07:24:05 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3297eXVj028682;
        Thu, 9 Mar 2023 15:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=3xlw70ADtUHzuyLxVSwfRRS3JsBxFlKXTkj+4oZ/sPE=;
 b=dPyHCBJtPabY5jaMAxGf5bNoNyt8iUOvAAGJOejLy44vwGkfxQuCr/OUr80meV0xEr+w
 exvmFHr7c65Uy3XAWvHZWUhiTJ/dWRlk4T1aEBycSYfPtHnupwAwu9tH2+x9voes93P3
 jQlm7sw6H+drb0nmq1QUpkYb83hAo0H35RXY0JX/qmO6OhKHgItCaWOMN9UJC8BYIK5i
 N1X4y3bBtLGtK5bXvVLZTZ7UXWQ+Y23DQqo6sdQY184IUx1LHd5WnbaryAm2IhLMNoH0
 JEXwtSv1vUgW82a5kByEoopH/qeSEgPW9kDnD5+bwAAbLFsMMcQvISbahFbs+gv/ppv/ jw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416wtyuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 15:23:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 329EpC2X026693;
        Thu, 9 Mar 2023 15:23:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g9vbem4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 15:23:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kr3qG92Mxbuxz1+C3aiG0NukDEEKZkAlbOhlRatmGYWztP5BG7hZ9U/WZIqInqGKnLhFT2Qef+Xr+9LX9l82bCzmzdglPaoQTff1UXD12hUETuqVb92dXWTW6XS71Jr2zr7z1Syv49NwWLgWLQoZH/KGWtlnzr4IngQwBksLSS421wSqthvpPBkrmD8MQMHZ1ZJ0xoOdRUwBl1RZwlZtZDY9tqiXMUHb5KlwKTOfD4ME3ly0j/ZXg5AqdqJMpDf21dLOSmfmDiHAoTlNsuFrLxUa1N960JNuCV76Pq+CUwXvIJnX4aeeBpWjTd0702EktPLIK2jHuiHNtw7M8GUd6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xlw70ADtUHzuyLxVSwfRRS3JsBxFlKXTkj+4oZ/sPE=;
 b=Jav9e/8yCXfLf6xs76Dcdifgp9Wp71uDD2r/St9bgS5C5rMgaOPAOgjaHxkWm8qIoybSSteomnZW/15W29P4E8Wx8FjL2aFt8i1autWQSgBLDerksNXVvdlpmB1YOYcySFa3g7wjt+7Fbp+sudT+t6uscNl/gHOBXxV66dRIPVzsxPg0O3xp+8S5a7uJ6AKkGb8S9OQ1Aa5cxI0PdlzRDd0OtM/nU7IeUH0k2q1dAEaPGfYrC/Hd/HUgl1WfGRo4OL3NNfCHomI2xQCcYawwpLATWFIJUONLT+pP1Dsjp2CjxhOJYfCUO1rNx+NEMwhkQi0e4dv3VO4XIy/AmKIjVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xlw70ADtUHzuyLxVSwfRRS3JsBxFlKXTkj+4oZ/sPE=;
 b=d9lBtJwsPBMVj6nR5kJAH/scML5JLpsw/1wAC99CWu8u+WSh6O7FzTt4k7JyqZeknip6Hlxoos1FIa9oT4C/hmHeWRZ+aCVUAdtq+fLvJaxI6N1aQgI0z9yyTZsjNc9Tbqu2tcICdEeKBQ0+Ii7FzCbtmigMeDrUEloScb9F88A=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 15:23:38 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 15:23:38 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Javier =?utf-8?Q?Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, Hannes Reinecke <hare@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qlygevs.fsf@ca-mkp.ca.oracle.com>
References: <c9f6544d-1731-4a73-a926-0e85ae9da9df@suse.de>
        <ZAN2HYXDI+hIsf6W@casper.infradead.org>
        <edac909b-98e5-cb6d-bb80-2f6a20a15029@suse.de>
        <ZAOF3p+vqA6pd7px@casper.infradead.org>
        <0b70deae-9fc7-ca33-5737-85d7532b3d33@suse.de>
        <ZAWi5KwrsYL+0Uru@casper.infradead.org>
        <20230306161214.GB959362@mit.edu>
        <ZAjLhkfRqwQ+vkHI@casper.infradead.org>
        <CGME20230308181355eucas1p1c94ffee59e210fb762540c888e8eae8a@eucas1p1.samsung.com>
        <1367983d4fa09dcb63e29db2e8be3030ae6f6e8c.camel@HansenPartnership.com>
        <20230309080434.tnr33rhzh3a5yc5q@ArmHalley.local>
        <260064c68b61f4a7bc49f09499e1c107e2a28f31.camel@HansenPartnership.com>
Date:   Thu, 09 Mar 2023 10:23:31 -0500
In-Reply-To: <260064c68b61f4a7bc49f09499e1c107e2a28f31.camel@HansenPartnership.com>
        (James Bottomley's message of "Thu, 09 Mar 2023 08:11:35 -0500")
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0012.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::17) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM6PR10MB4363:EE_
X-MS-Office365-Filtering-Correlation-Id: bf69a389-4fd7-45f9-0790-08db20b241d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDI9Wkjtj71G0HI5Ub7Y8ZNglzcg1u21YX54n+s6p0m7odB+/JR4slsJrrfXT8s4u/Or6NGAxwlf5oI+qNlj54zIKYGJoffJMqvAnaL0gkMvtn/FZzqZM+hhFGiPLhT0vI4e/NUeCJO1JAKylc+g/BSwx5j4KR8hav0s9SoOC5CScL/wJmq9IJM6GivahtkiYFvPIpVVNrQ+S3nbUAu3MaizGa80OWZuksROgZgfJl0AmUj4TYl6e23rTemf/VZgx3NiE8FgClAajkTCZo3b/FJavrwVPfvIG8Y9/30qkrPorSTXg7x6b9FVbWYXKEqt0AIaqVBE+bbACtjDIlwgcmZUaDuOHcU7HOE+WdS/LKUutVn5Z+k4IiyXjDHdOiAYCiKu7wNtYMr2gHnQnEChHJZvzlMsj0L6K0WH8h4pGZlUqAr2h4W0t6TE9VBEQjZEu/q2LAJkW23Gz+W1807OtVHpeijfK9t2WqSLKD8NGAl/EwcLG4K/X08YSN6kNLbSmvuuMuNJeVc3QsS0BB6mZ/D62WUmWHTeoEwoEEaWdfvAyTyZY6G/wGET14JNsfJ899mrHYAeS+quMcbvRM5B7LNxE4RazgTSIsAxtMCwLKRfm/C5nN9NGZytvYwifULs+as5qpheCvvEqJs87Uw0+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199018)(66899018)(2906002)(5660300002)(7416002)(26005)(8676002)(8936002)(66946007)(41300700001)(66476007)(66556008)(4326008)(6916009)(316002)(54906003)(86362001)(36916002)(478600001)(6486002)(38100700002)(6666004)(6512007)(6506007)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5biNZEKHXMz3crCmXLXTCjt8U+cvqTe/09Q8Lva/wOy5seSGCZ2bRPA+dk9Z?=
 =?us-ascii?Q?TVKulIEwpx+/pnuacouz+0VHPlFMZeXJ8V2qUZwrRIfUV02+3BA19Bozt34C?=
 =?us-ascii?Q?ZhJ1+IsIQKgyjsUAVSqJoEaccRlugiZZWXpUpKGPm7rwqjH3yGvK92YYH/RE?=
 =?us-ascii?Q?EF7vCtm3XipkCXrWpabi/8TL9VJNCK7Pk4fG2IM6i4AArXX/XPdRtAqWMSv4?=
 =?us-ascii?Q?kHJq3e19MT/49q15NwgP4s4xtkjojDYqVIM6c9ldBjEt2L8o0x7HWNyPt9P5?=
 =?us-ascii?Q?FghO5pdDL4RgMCGqS0e2nDyD5VeK4kAj0bS0M3FhxHj1s7E2CszP8e7HBjFK?=
 =?us-ascii?Q?hULFnilVb03R7tsjFWeu5bRDioWpgoZA+EIIjp+G+zfRkoW1bcoLakKMpffg?=
 =?us-ascii?Q?Txlnhz/smFmFtl44xB0jQKI0zFScCxNso0ez9J7ZnLxzfbg1F89NyJ/IXCa1?=
 =?us-ascii?Q?fjQP2ITAvLrXtEIuRX/pwijpKZpti3PGaqrXLcR/baVre5zYgtAaFB1pnGhc?=
 =?us-ascii?Q?UO2uoy7BKZIPzdj809n6EywAZUx+s+3WgyzUgCMsqXr9xiXugViF4Nea/0qe?=
 =?us-ascii?Q?1jFc/SSxnhYDoWA3JcmDFZlrbicmG38c/0ndF6pdvvEgTGVEz2hrVreZfWgw?=
 =?us-ascii?Q?xcTnwrJGVfcM2sqc1GRiSnf3dj7tFiHzIAl1LyFdqu97RmmyvWFxRLAv9Puu?=
 =?us-ascii?Q?FGIlG3Z5X+ONTqoky0iIOhyXOgoN7hFMtSL329lCQoCSwtHxSQ00QLg4GjLk?=
 =?us-ascii?Q?FgDyt+eOf1rvDczE9VfVWvfziFEtuQSXPZQMc6YHEUE6+Dy1En3fuac9sSNx?=
 =?us-ascii?Q?rT9ynZz6nHz0eIR91XNfsL52jBLIwCqDwcMzVCtf1ZPBLvUykLQlTSHvmfqx?=
 =?us-ascii?Q?PL7Iv5VdKlj0KkQRWTpHGw2RiteoNB/RbXNtbwj+ento9P7jBz9fyuwgA9b3?=
 =?us-ascii?Q?Wg0vgULGNATjlpEbeDFwoOp4dvkmZT8MStjTNX/W6Q5Az4q6xh+nGhvEkQ+C?=
 =?us-ascii?Q?tEH5p41THCgj56VcYJIhcYerCU7eDT0eANsOmlLps801ROrpeH3UNtYWC5it?=
 =?us-ascii?Q?7XV9L8/F0HMzWrFWossvNfghND3uweS/u5VsBcscmlrpvgqLAvN3iUdPqgPu?=
 =?us-ascii?Q?NRcQXZhn4124kwg0zI8yWZz+N55+kGWaF6XbN7UNO3rx/o92lblOYXfMk5N1?=
 =?us-ascii?Q?kmgyq0GiLXKlEPaLIMNuTG/IPheRGYzrgV+/lyLnStzutEgSjZpO3Pxc8kIR?=
 =?us-ascii?Q?2vWh3067w+5Etr6+WEPb7gxF60hlXBX+LIz7Il7emKXX9PTlKxJ2bm2cYHyV?=
 =?us-ascii?Q?AGJ2duk2mRqQMl4wUa2QhNDFcPmUgb8iKgetXBZUEpawLVTk9KYjTEDPWVB6?=
 =?us-ascii?Q?deyOFgAS8CgVfTn/IHEkzyAAzWTHG8M/0VTeYq1tr16flJd0rKoIkvJp1HdT?=
 =?us-ascii?Q?T1V22FXBEUrheEhwYXQEUDSDXSWNjo2xYTSWO/HbCL0Dg1G8QClKRu/W5m7a?=
 =?us-ascii?Q?vg5iopzr6HWqMIit64dW6fruR6XsWUP3y30hpVznjpLto3YZPXCPlCRfWpFG?=
 =?us-ascii?Q?olLnXRhPuG/7EsxMc8xO3dv9qKzO9kPPB3oilzVP7sPeJKoKaQnkkofePP7g?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?tSvol7gStI/g6xbRmbBWw7y87yRs+I3B3HASzykvgFlJosoui7sFbf/Q87EM?=
 =?us-ascii?Q?AZxRJwMb2FRGi3gWTFCO1PH7vpoFhCe30BcVBAK+eaBKU5G+wD+lIqbqsLLm?=
 =?us-ascii?Q?jdIngXCioQtnr8S3WC6OWVWg02u1A6++4nWJUh2M04Gutlf4YSa69e+lZAOa?=
 =?us-ascii?Q?O9XudDCCqfFg7C74wgijXsyiLl9+HjTFBnu2Fkr3I/agttDcAoP89KTYbKmr?=
 =?us-ascii?Q?2LCHGMvmzJJ+t0vbghoHLdHbcwVqn9tuz5BpNil5XN30qfoEX+gIwOWN9fo1?=
 =?us-ascii?Q?OIJQ7f2dNei5VPMn4JxhyAehFg96VEXDu+E16EOOYTsvDMEFdMFnwwLfITLe?=
 =?us-ascii?Q?YWzer2Nkg9XFDYVTPVCLgFtSAnzmcRXLJmu6TADcV23q0Mjhopx448owrk2h?=
 =?us-ascii?Q?YgJhtA/SzLoRlWxnzD4NeDtGLrm4jLXYNiJVqL5p9q9XtBs2CYjw1TPoPt/6?=
 =?us-ascii?Q?mQKWFPXQjtokKYmbQeiRluoL2tWivYtgpy1Vhrll6sDbMgoL68UGCvD8wR85?=
 =?us-ascii?Q?nVxxb6DRUBl55O7aguV5moZiKCWG8ePlMLRs5IqjTiNCfPhKbpX7hqAcNFn9?=
 =?us-ascii?Q?jUqP+/di/YRh1KkH5PE+l0a8BZWRv7obD+kz+xfqC8QXcdw24KupCVqEolJb?=
 =?us-ascii?Q?vvtMduFCmdOUtOrCWDNPzyttAv9isndNdjzvptCSA06g3VSrrUQGWEXBm8E6?=
 =?us-ascii?Q?3LSK+1pvAlhWF8wj0N/WWrHJ2sLZq+7rq6NjEAiVTj90eD04CHP/0t0TnxPS?=
 =?us-ascii?Q?D9SAlFiRIBbpZ1NpW/2OLNK/d2iaDHiI14XDQv0RyxYKh8fpFD4/cFynr6d5?=
 =?us-ascii?Q?yWstHIsgrbIKwX1tOARuFUQr6X/kZRebd2DmTWL5j6TQNVWFtKOiroVYdu5k?=
 =?us-ascii?Q?mW6DehKjvvsg62dJHL1dCZOagm0mWuI0oVkH2S+qpzSK3jjrNlY0+fzdh3eu?=
 =?us-ascii?Q?JW7aq6RvAyL62QN2xaa+7Mk6+UWAIxj15cH9M/dCi7URzVE+ehNe5yx+mz1N?=
 =?us-ascii?Q?WVNw8yfyvFd10ZwhFJQxdi1rgvCduic1aea1nXeYrOSiSzvKeJGJKLKWQH/0?=
 =?us-ascii?Q?v/O+pHpt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf69a389-4fd7-45f9-0790-08db20b241d8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 15:23:38.5251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8mm3+jrYrmKyseI7aF5uVe7NYzedfJt4j+mZPH65/Zbs2++2ciGlo/U3AFgPePCSTTuh0DqFdQHcNGkIud3FwDIoVJFeX81tN8He6zFgtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4363
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_08,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090121
X-Proofpoint-GUID: gglm9HGFGdRrWOV6je5N8CvT-0bNpn_e
X-Proofpoint-ORIG-GUID: gglm9HGFGdRrWOV6je5N8CvT-0bNpn_e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


James,

> Well a decade ago we did a lot of work to support 4k sector devices.
> Ultimately the industry went with 512 logical/4k physical devices
> because of problems with non-Linux proprietary OSs but you could still
> use 4k today if you wanted (I've actually still got a working 4k SCSI
> drive), so why is no NVMe device doing that?

FWIW, I have SATA, SAS, and NVMe devices that report 4KB logical.

The reason the industry converged on 512e is that the performance
problems were solved by ensuring correct alignment and transfer length.

Almost every I/O we submit is a multiple of 4KB. So if things are
properly aligned wrt. the device's physical block size, it is irrelevant
whether we express CDB fields in units of 512 bytes or 4KB. We're still
transferring the same number of bytes.

In addition 512e had two additional advantages that 4Kn didn't:

1. Legacy applications doing direct I/O and expecting 512-byte blocks
   kept working (albeit with a penalty for writes smaller than a
   physical block).

2. For things like PI where the 16-bit CRC is underwhelming wrt.
   detecting errors in 4096 bytes of data, leaving the protection
   interval at 512 bytes was also a benefit. So while 4Kn adoption
   looked strong inside enterprise disk arrays initially, several
   vendors ended up with 512e for PI reasons.

Once I/Os from the OS were properly aligned, there was just no
compelling reason for anyone to go with 4Kn and having to deal with
multiple SKUs, etc.

For NVMe 4Kn was prevalent for a while but drives have started
gravitating towards 512n/512e. Perhaps because of (1) above. Plus
whatever problems there may be on other platforms as you mentioned...

> This is not to say I think larger block sizes is in any way a bad idea
> ... I just think that given the history, it will be driven by
> application needs rather than what the manufacturers tell us.

I think it would be beneficial for Linux to support filesystem blocks
larger than the page size. Based on experience outlined above, I am not
convinced larger logical block sizes will get much traction. But that
doesn't prevent devices from advertising larger physical/minimum/optimal
I/O sizes and for us to handle those more gracefully than we currently
do.

-- 
Martin K. Petersen	Oracle Linux Engineering
