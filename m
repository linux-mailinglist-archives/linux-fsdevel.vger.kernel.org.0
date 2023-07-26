Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F6E763BF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 18:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjGZQGv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 12:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjGZQGp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:06:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750832696;
        Wed, 26 Jul 2023 09:06:41 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QFnA7l025744;
        Wed, 26 Jul 2023 16:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=HxQ4SpeG/o7tPw+bmEe+bzEnbUqsGTIAlCF9U8RpRKw=;
 b=C0QKxoXfLBZJ1VlkHy3bv7ua9HAFLOMXB4fYblCejPOszQYMUr3nu2+FAd8ON4qObzz/
 FkA7LUBV5a6bW/M4Nx3IZzQqFfPIFvhp0eBNstWyrvcmH2hDNPcUbLu2UXGGc5pyYuOT
 gUvkj+ueClZZ2jXXEzbTv7In5rEoBYtz/9tKXvPVdXB4KuUconBnMBuf8/+bTCtsot2h
 nFvYLGYZbPowkprECEDvhKC6tzPrZUZ3ZR0BwzazZyToSz/U00TZyLN2T0Rxacasq425
 Jr4MJBnWpZ+XoVQVk0bI+8+lt1KeMV0F8CYlH/MZPu4MN5cI8Q+fXoALhedA1PwgV7ni Dg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s075d7x5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 16:06:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36QFf2sk029421;
        Wed, 26 Jul 2023 16:06:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j6dstv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 16:06:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FE4YuLmEBVZLJVtfpd0yP9I/Gb2AL4c3cHJRc85MID/o4ZFXNbgYLDigUPiWic+J3c03GHZwZDYtMOOWPhol9oz3hYXPahki+/lag4pWInpNKAcqx8Q6o3SIPFpixZCrZNUWgycwG7WIq4iZLJ3dsfqp0570RXLMiC8+acSd6n03ZAZ0unUW7oY1hLZ0g7wWMnoeMXtWFWrNso2Jr2VbJqeXE3J/dtqj7Ad2JvLGN9zRBq/W8vpsJI/iYT5yZ45Oj+97uOEHrLAnAhq46v4ae/WhXVQzBvETuqVcx9MneJJtGvmG1d7jn0/l9eDfZVm0F9eV0pjcJuxNsyRzThlzsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxQ4SpeG/o7tPw+bmEe+bzEnbUqsGTIAlCF9U8RpRKw=;
 b=VXelSYkNU8aknIBF0plPF7IFY4YXRRntG5em4h4HlI1I/UBBzSYufOSEpDiRF0Duq48WvAGZBApClnI3DwiSuKrVWwNfuISU89taDggMiM3HF4rc7rM9ov6N7bMNdT0LM0KhNXylgq/wMwXpDQhXaurCiGyWiba0Y11yPHTbbgTQ+tQRUa6NWYQUwB/tautVG+Gq/IzHsxb64RlHO9aBLvK4m6oBAW5Zt60EzuFnMwDzEFN9qQ1a2P5+iTlZIdgoGfxgnioORiy9ZQAc9V6Z9/JgFJMI1SolrLgTyBzYYxoKuYgtWJIhRvxbUM000HpCH8MLEzAXmqKxnKcFRIa2Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxQ4SpeG/o7tPw+bmEe+bzEnbUqsGTIAlCF9U8RpRKw=;
 b=l7c55uDgTOCc8AlNU8KyRwh5STVpjHAEwGrXPpTQhXP85Kv47zdV/KBcxAeMOrVpwYN0UX3vYYKlezdz3AXa9RHzMUn4TBoIutd4WKAHI7yA1gbchLxf8Iq+RHzNlrFn8wm+SDtCSw2Js1Awv1mbkjJOnImr2E6piHm6GIO21aY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA0PR10MB7668.namprd10.prod.outlook.com (2603:10b6:208:492::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 16:06:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 16:06:11 +0000
Date:   Wed, 26 Jul 2023 12:06:07 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/11] maple_tree: Add test for mt_dup()
Message-ID: <20230726160607.eoobd4dyvryfb25a@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-6-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726080916.17454-6-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0434.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA0PR10MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b98698-559b-48c8-d8e3-08db8df23aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +gUVO7vtt30oRLEtIr4uy9wGotNZMhmCUEPWmYs5hJZIWW2fwe5Wp6jakiiExjv4uMWDEcLNamV79+lEh7GuIgi2UXGidp1waXh+orU7zeXOBhQh+0+AXkEMxkXPF3TUMGCNiPfpJ96E91XSxBQ1SCYg1XMoIw/gdTKs9zO784fH64+MDz0YleaNp0lali0Ml2wQfuw/GqTv1s3Yt48w3FKM1WEtJu0tp7b9SU5cniNSOmZKxQ3CpfHQU+5dIFrsgF6Or9XmPDbhaLM8tSTMfaJ85J3/qJWiAaQoEBGXyzBUskNEofPWTyfZx30m9m0ODB6Jdf7i91w8ym2knxO/ixsAQprUnViBtjEPAt0N0lSV9BKPgnbxiyYjQCfMFIwdoluLh9+T9Nf3eEgnk09L/mRZ3K3iLr7DnlxU10EOc6Ajbed8yp0o5vdGUm1KP6TFUqVRzOz4NGM8V1XiAyT5YSel9WoleSLdd7WkXVrpmWvnQFBThqspEpg4gBgn7ZD7m8m1lCI1Q+boG7S5g/Y/AskIjDoWeXrbvdYXpNOP7yGt9gE6QQhyUPnvs8keAy4S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199021)(86362001)(38100700002)(33716001)(478600001)(2906002)(186003)(26005)(1076003)(6506007)(8936002)(6512007)(5660300002)(41300700001)(8676002)(6666004)(316002)(4326008)(83380400001)(7416002)(66476007)(66556008)(66946007)(6916009)(6486002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zO/UPH70GNeJxZXK8FESqklf8/8GGx+RbBsPhCEsFiZZV4Gpaq+UTlneGlvr?=
 =?us-ascii?Q?4b9WfskH0X+JKFIQetH2l9nRHiD1swHbw9+CcaGKOQe4/UC9+efwFKzB+/tw?=
 =?us-ascii?Q?NebsUzW7X7symCltpxfucpG3kfr9JCzhSKWu4Wz3kR8Pte+/abCd+SdV4pwB?=
 =?us-ascii?Q?1Rca1qtKr1sQwgx77+YsmwV0gQwRqBqj5oIxl/MQyFSTze6S3iIZHdd4pI4C?=
 =?us-ascii?Q?xLd6xdNNx1b3YGGtponiWFELevS7yGwx4Pkf7ps91oDHW4xPDgJ2E+Lajw0k?=
 =?us-ascii?Q?6QHMFng2I5WGmIi0MEAtuOfaMbHZZUO9UXOD8/S6JslxR7FyY/2+KIz/XZHX?=
 =?us-ascii?Q?/ho10WEkEjTIip1Vl13suko8Oqsi3aow0dBGaxIJUd3oIWaCy4E8giCi/Vss?=
 =?us-ascii?Q?G5PyMyOQZhEFcEiUi4B0CXV4gN8TnNDF6djSl+qGfZwNw/SnD+MnGzqVGtv8?=
 =?us-ascii?Q?NxbCuTDRs+wTAZ3ucuXHEiJc/NN0qoM8BYUwZCFqJYkZSFqZU8DdlEZFKFVG?=
 =?us-ascii?Q?AHdnk7N+ZI6IO2DNB4eWmeOS2gPUmik1tBT0BYhp5AxKEuWqRCTv143HVbFM?=
 =?us-ascii?Q?66m2t4rF2TfktFK9hF6v2+ULZaCNgvYgvG1QGgdF9NpCanOBvTUt7grECFFu?=
 =?us-ascii?Q?wjz0czmiaWQiI1rghNYItsZzuMV93qQHZjPcu9ZKHZe720IXPV4xD2obwOdK?=
 =?us-ascii?Q?BZ9eN9+iqEKIkpTSthXy7DYON4bCtFy5K3pw+/TWB+Aa2PjO/p9t1Rkn642I?=
 =?us-ascii?Q?A/8eQcuoIGK/BBxV0oQk9XhHXVMBovD5YcZ78TA3cs8p48o5nTZCHffW/4jm?=
 =?us-ascii?Q?g8miATCiVO+oQnkwaE3PtF2TX61ZAbU2dTKubrr8iyDJwXr48uk1/E58PF24?=
 =?us-ascii?Q?sbFDMhPk3OQKI0qr34SYeNJDdXXPbA2ABnrqBVuoUPsivpXmBZdY1dISCmi8?=
 =?us-ascii?Q?QIDsVaN4wg+SwKBggXcgUEqmIyP9LWLeW0VEX9b+2lyNp0RD+7oQHP/2KNBs?=
 =?us-ascii?Q?hs/Eqg5/tmP3qpOE4txaY03aXltyN+QQGS4xxxCF5Sbo4d89khHx7XKHvVP9?=
 =?us-ascii?Q?WGRBz9jXdeQy1fpH00di+Fm8FVkl/qkOyK3SbXdxIfx1zDgtu6OwUyHE3CJY?=
 =?us-ascii?Q?jHLp/M8qVuMLzTFQUM0DTr6QpsnaqqAZR/S96j/OwuFw8VZPssI1jagDk75A?=
 =?us-ascii?Q?I2p6B8yGRXpEycIoBJs9+hK7Xnz1cl+hOki4HuQbHbZ77GAKnXCE8Rf9zt1K?=
 =?us-ascii?Q?npS5+fTDheEONGoAy1Q5IMd0Si9Us/jVf/WEc7wqpQdJ7BdKrSNHJl1I6c9N?=
 =?us-ascii?Q?AKgAtIBeNxVee4nA/zDAod3LgvcWtCycbn8j96zREpA/z0Yq2Up7X6Jysuf5?=
 =?us-ascii?Q?aWWwFrCr4Va52eBi6fnCxwBX00kTohKP8dUxez1WOcAXERTROp/m2XkLBzKW?=
 =?us-ascii?Q?VlMJ+JybmhOlUTJSX2wCtBb8k5O7rsKAuSyx+TMCjvCRC0lriQQ9Ex3dRK/4?=
 =?us-ascii?Q?rZU3h88XBLU5P7nMS4RtogXzx9DGLMqWpRhb4nh1avTnSgzwPzzrXxsCxRQd?=
 =?us-ascii?Q?s7f9XfKr+1jBGyqcyRNHU1hx0GxLMGdOmm64XmizN+dLzZiLmcjIBBDwSHUE?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?aG4oZp+Lt+PF9iNmI/vEA8fegFbelrTjphsF5U+Fm+0JdFmpUrou7DSmzxmH?=
 =?us-ascii?Q?+NLrPYvw2kLtfy6yk2ei6fMH5khqRi2r9dqSyE+5apU0Flk1+ez1NQTn+QNW?=
 =?us-ascii?Q?wy3SHlNYctJ2bOgGIltEJbcRP4XUJD4LwSsJv5A5xU5UjVE45ulzZ78uZzhS?=
 =?us-ascii?Q?/OEnpHH/J5+Lik89K6c92wLmJ1YiAoJyMaHcXiamdesr8BWh1UVWFEtUwX9P?=
 =?us-ascii?Q?+dy0VJfErQ/Vu1BfHfECZH0rtinWd+bfQ0zbNBq52wP39ixxvUJtF5rqABxp?=
 =?us-ascii?Q?OCL5s+YmANw0Mi73mm4+5F1dMOr5a8CLcnm9gM0etDpTSRzworNSrvS+B98T?=
 =?us-ascii?Q?TcycQv3Qlrrjpx2O1iIL5frNcUTzngxHuETKiRey3hWu/R2uBCzIMTEuzPPx?=
 =?us-ascii?Q?mo5a66V7/nPo21S8x/jllZShrhSSzJq+G7SumWgO7VuRK52sRdJbVh+HvEJK?=
 =?us-ascii?Q?ywsHt8yGQ59o4dmDsfxo8efTorqfp3udheWaT5loJd2qhnWrckSMez4K1UOv?=
 =?us-ascii?Q?VoUQdjWxY8r2LIcYwV6PtzXd61bGvThqUtNRRMV3Fjq60M3icEDjv3Conj7P?=
 =?us-ascii?Q?IpVyoRXj10ZHvIhXqrH4frV2i9HIySv6LPVshOvqBYpMPaR/4Qcd0CmabAuZ?=
 =?us-ascii?Q?rSOoBvyP6lSSIVVdZMm+ai6ss9fJQqvlrfOz2j5aZVM4r7PXXPVDAAISN+zQ?=
 =?us-ascii?Q?xpIJ4orz58dlZB8lUwlhpfFOsHmMdapvZkrCgblZWsp+HuexY1R4xs7zQMwM?=
 =?us-ascii?Q?LMDuGsGifZs16YTHOuNWpeA3EOITQZJN6aZ4abFq5tJMx7bmBaBBxZT57NHv?=
 =?us-ascii?Q?mibJMPsh6kKDOQCWZK2aX8DtwQMQjhVxv+KqE8oEsBjIuaT3966BkCmHHCeA?=
 =?us-ascii?Q?bAutMCMyv042Hux6mewb/Zq28Ce/tHHO32ltO0RvR9O+0VKhuVWL6MAx+T+5?=
 =?us-ascii?Q?RrPltHJsLGgK2lHzoByPZg6nW47G9roO2cj5GRXzzW0hSaxJVVY4Aj5xZaFm?=
 =?us-ascii?Q?d7nQgpxsm1OAJlCPfOmJrCXonQpFKcCXWwItkbNQRABCrysE4cKzFUvvSvQM?=
 =?us-ascii?Q?StdQZ8nV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b98698-559b-48c8-d8e3-08db8df23aad
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 16:06:11.2079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7S7cfibtj8vtArtPr3F7VQjUeM2N2mD0NcSDyOruRbwE/wP4pOS36ZiT/8Wlo97YmJeS4zEk6k0kdrig3FAexQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260143
X-Proofpoint-ORIG-GUID: qZmabKATeRNoeExb13GrnrKfkiWLl4_b
X-Proofpoint-GUID: qZmabKATeRNoeExb13GrnrKfkiWLl4_b
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230726 04:10]:
> Add test for mt_dup().
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  tools/testing/radix-tree/maple.c | 202 +++++++++++++++++++++++++++++++
>  1 file changed, 202 insertions(+)
> 
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index e5da1cad70ba..3052e899e5df 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -35857,6 +35857,204 @@ static noinline void __init check_locky(struct maple_tree *mt)
>  	mt_clear_in_rcu(mt);
>  }
>  
> +/*
> + * Compare two nodes and return 0 if they are the same, non-zero otherwise.
> + */
> +static int __init compare_node(struct maple_enode *enode_a,
> +			       struct maple_enode *enode_b)
> +{
> +	struct maple_node *node_a, *node_b;
> +	struct maple_node a, b;
> +	void **slots_a, **slots_b; /* Do not use the rcu tag. */
> +	enum maple_type type;
> +	int i;
> +
> +	if (((unsigned long)enode_a & MAPLE_NODE_MASK) !=
> +	    ((unsigned long)enode_b & MAPLE_NODE_MASK)) {
> +		pr_err("The lower 8 bits of enode are different.\n");
> +		return -1;
> +	}
> +
> +	type = mte_node_type(enode_a);
> +	node_a = mte_to_node(enode_a);
> +	node_b = mte_to_node(enode_b);
> +	a = *node_a;
> +	b = *node_b;
> +
> +	/* Do not compare addresses. */
> +	if (ma_is_root(node_a) || ma_is_root(node_b)) {
> +		a.parent = (struct maple_pnode *)((unsigned long)a.parent &
> +						  MA_ROOT_PARENT);
> +		b.parent = (struct maple_pnode *)((unsigned long)b.parent &
> +						  MA_ROOT_PARENT);
> +	} else {
> +		a.parent = (struct maple_pnode *)((unsigned long)a.parent &
> +						  MAPLE_NODE_MASK);
> +		b.parent = (struct maple_pnode *)((unsigned long)b.parent &
> +						  MAPLE_NODE_MASK);
> +	}
> +
> +	if (a.parent != b.parent) {
> +		pr_err("The lower 8 bits of parents are different. %p %p\n",
> +			a.parent, b.parent);
> +		return -1;
> +	}
> +
> +	/*
> +	 * If it is a leaf node, the slots do not contain the node address, and
> +	 * no special processing of slots is required.
> +	 */
> +	if (ma_is_leaf(type))
> +		goto cmp;
> +
> +	slots_a = ma_slots(&a, type);
> +	slots_b = ma_slots(&b, type);
> +
> +	for (i = 0; i < mt_slots[type]; i++) {
> +		if (!slots_a[i] && !slots_b[i])
> +			break;
> +
> +		if (!slots_a[i] || !slots_b[i]) {
> +			pr_err("The number of slots is different.\n");
> +			return -1;
> +		}
> +
> +		/* Do not compare addresses in slots. */
> +		((unsigned long *)slots_a)[i] &= MAPLE_NODE_MASK;
> +		((unsigned long *)slots_b)[i] &= MAPLE_NODE_MASK;
> +	}
> +
> +cmp:
> +	/*
> +	 * Compare all contents of two nodes, including parent (except address),
> +	 * slots (except address), pivots, gaps and metadata.
> +	 */
> +	return memcmp(&a, &b, sizeof(struct maple_node));
> +}
> +
> +/*
> + * Compare two trees and return 0 if they are the same, non-zero otherwise.
> + */
> +static int __init compare_tree(struct maple_tree *mt_a, struct maple_tree *mt_b)
> +{
> +	MA_STATE(mas_a, mt_a, 0, 0);
> +	MA_STATE(mas_b, mt_b, 0, 0);
> +
> +	if (mt_a->ma_flags != mt_b->ma_flags) {
> +		pr_err("The flags of the two trees are different.\n");
> +		return -1;
> +	}
> +
> +	mas_dfs_preorder(&mas_a);
> +	mas_dfs_preorder(&mas_b);
> +
> +	if (mas_is_ptr(&mas_a) || mas_is_ptr(&mas_b)) {
> +		if (!(mas_is_ptr(&mas_a) && mas_is_ptr(&mas_b))) {
> +			pr_err("One is MAS_ROOT and the other is not.\n");
> +			return -1;
> +		}
> +		return 0;
> +	}
> +
> +	while (!mas_is_none(&mas_a) || !mas_is_none(&mas_b)) {
> +
> +		if (mas_is_none(&mas_a) || mas_is_none(&mas_b)) {
> +			pr_err("One is MAS_NONE and the other is not.\n");
> +			return -1;
> +		}
> +
> +		if (mas_a.min != mas_b.min ||
> +		    mas_a.max != mas_b.max) {
> +			pr_err("mas->min, mas->max do not match.\n");
> +			return -1;
> +		}
> +
> +		if (compare_node(mas_a.node, mas_b.node)) {
> +			pr_err("The contents of nodes %p and %p are different.\n",
> +			       mas_a.node, mas_b.node);
> +			mt_dump(mt_a, mt_dump_dec);
> +			mt_dump(mt_b, mt_dump_dec);
> +			return -1;
> +		}
> +
> +		mas_dfs_preorder(&mas_a);
> +		mas_dfs_preorder(&mas_b);
> +	}
> +
> +	return 0;
> +}
> +
> +static noinline void __init check_mt_dup(struct maple_tree *mt)
> +{
> +	DEFINE_MTREE(new);
> +	int i, j, ret, count = 0;
> +
> +	/* stored in the root pointer*/
> +	mt_init_flags(&tree, 0);
> +	mtree_store_range(&tree, 0, 0, xa_mk_value(0), GFP_KERNEL);
> +	mt_dup(&tree, &new, GFP_KERNEL);
> +	mt_validate(&new);
> +	if (compare_tree(&tree, &new))
> +		MT_BUG_ON(&new, 1);
> +
> +	mtree_destroy(&tree);
> +	mtree_destroy(&new);
> +
> +	for (i = 0; i < 1000; i += 3) {
> +		if (i & 1)
> +			mt_init_flags(&tree, 0);
> +		else
> +			mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
> +
> +		for (j = 0; j < i; j++) {
> +			mtree_store_range(&tree, j * 10, j * 10 + 5,
> +					  xa_mk_value(j), GFP_KERNEL);
> +		}

Storing in this way is probably not checking a full tree.  I think it's
important to check the full tree/full nodes since you have changes to
detect the metadata.

> +
> +		ret = mt_dup(&tree, &new, GFP_KERNEL);
> +		MT_BUG_ON(&new, ret != 0);
> +		mt_validate(&new);
> +		if (compare_tree(&tree, &new))
> +			MT_BUG_ON(&new, 1);
> +
> +		mtree_destroy(&tree);
> +		mtree_destroy(&new);
> +	}
> +
> +	/* Test memory allocation failed. */
> +	for (i = 0; i < 1000; i += 3) {
> +		if (i & 1)
> +			mt_init_flags(&tree, 0);
> +		else
> +			mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
> +
> +		for (j = 0; j < i; j++) {
> +			mtree_store_range(&tree, j * 10, j * 10 + 5,
> +					  xa_mk_value(j), GFP_KERNEL);
> +		}
> +
> +		mt_set_non_kernel(50);

It may be worth while allowing more/less than 50 allocations.

> +		ret = mt_dup(&tree, &new, GFP_NOWAIT);
> +		mt_set_non_kernel(0);
> +		if (ret != 0) {
> +			MT_BUG_ON(&new, ret != -ENOMEM);
> +			count++;
> +			mtree_destroy(&tree);
> +			continue;
> +		}
> +
> +		mt_validate(&new);
> +		if (compare_tree(&tree, &new))
> +			MT_BUG_ON(&new, 1);
> +
> +		mtree_destroy(&tree);
> +		mtree_destroy(&new);
> +	}
> +
> +	/* pr_info("mt_dup() fail %d times\n", count); */
> +	BUG_ON(!count);
> +}
> +
>  extern void test_kmem_cache_bulk(void);
>  
>  void farmer_tests(void)
> @@ -35904,6 +36102,10 @@ void farmer_tests(void)
>  	check_null_expand(&tree);
>  	mtree_destroy(&tree);
>  
> +	mt_init_flags(&tree, 0);
> +	check_mt_dup(&tree);
> +	mtree_destroy(&tree);
> +
>  	/* RCU testing */
>  	mt_init_flags(&tree, 0);
>  	check_erase_testset(&tree);
> -- 
> 2.20.1
> 
> 
