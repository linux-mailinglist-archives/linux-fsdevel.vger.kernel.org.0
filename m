Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7D96F624D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 02:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjEDAOa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 20:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjEDAO3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 20:14:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FB372A2;
        Wed,  3 May 2023 17:14:28 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343Housx016649;
        Thu, 4 May 2023 00:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=lzk10u8Z8/6pwlgNG7KJNZEjE2BdZ4fGJDhNQwNTIWc=;
 b=4LOW1OiNBSrqN5XeDB5WmfSP83USmlAYzo/6+dZ2S7vAKfuWfO6dzXNcMIEfEOb4nLGa
 29RI/fEs2kCFJP82t8BCyWuD4vz37Ep9D4h7VLSFFmXoAx9xZrqQaOlOh5W6Q15kwKeE
 Y5BiBTIXejhkA6IGOhrEdB14UnjXYJoDnva8HOt6uEOv5FBeEP6MOlfzHhUCJQhyNHgM
 4Gkgp8EPJ+f3gWyU+iyHkjW06F++jrZUcY1idWKa32cgbUKfuOlab/pq70Gl8JglYVPJ
 A3eWKt+QQ2hNFH3bkYyKf5KSSmqy//w3gzPBoRiOgGK3Wh3RXolijZXpdiPascU/9s2O rA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t5frn7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 00:14:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3440Adb5009902;
        Thu, 4 May 2023 00:14:15 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp89wkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 00:14:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rt44lkKRLvSDMlNNyZngKNXuM6PU41XxAnpliqWS69nNuTrbO8NXakw35oU6uncyj9BnMsmiY19ollYB12YZ+cp7nxFUzNM9Jl8L9m0b8lDVUmXlvABZCTN+y2FgO/QxZUWwf8UC7cK74htYE8mwZKXPQy4VUdw667St0PT5uatxrMqppkYfMCFwFJcYKBzrPZbJEUtyrI6lXMTrsvJg7g0H12tsDZ9X63j/XCMF9DIEHeQW1YRGB0ovpsZ+9ADZqcEf1Li/0Z2loeUwSuX2/ahVcBQyJPWSEL1PUzY/iK5I7BudWi6BSwKcRPdea0fTxf+YQeiM/k2Z50tucCYlkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzk10u8Z8/6pwlgNG7KJNZEjE2BdZ4fGJDhNQwNTIWc=;
 b=eokRBmKkZ/tTTA84w1A8ua7Q/wp9qv3CDslsx/+TIZ7l7IhXaUqs07/3t/a3hU2C8SeIXSGIjcToWgpLrmpYK8EfZfymGxq2kIgD89amy1M8vvfFGblN4MFYNYyZotQwPQcrwBJjgdITMPq2PiSbMDcD5Qun0y5qoW5X2iEjqu9wrJ/Zg46zTCFBHyEB1d/xeLgPPFvqh0WjjmdDY/8QsKln7nSdJlfQuvY/sxevAdhozGP0LTlnQpdSZDfmrT+FUVBtaszKnnRT3qmtqnSfpHpZivoht2RbVLOHOgf6NS1qJKG5uwYJyk9PY3vKajWYPy6qRZWMTxwnkHC7iSESgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzk10u8Z8/6pwlgNG7KJNZEjE2BdZ4fGJDhNQwNTIWc=;
 b=WRVMmCDhXuT5oShzuBS/8S793FhEF5I7RTHmYuuWtdl8UL7cdWIJBpKhjq2x1+KO/q/qj0z1920y3WogISttnWVMTjyDY7n6xukC3wRYENaXENgfLThzXj9sbKCn5tejMuFj4Xm0Oq3/BkAu+nc8MtzM/NVkcu7y+W+/7CK/5dY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA0PR10MB7383.namprd10.prod.outlook.com (2603:10b6:208:43e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 00:14:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 00:14:12 +0000
Date:   Wed, 3 May 2023 17:14:09 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Ackerley Tng <ackerleytng@google.com>, willy@infradead.org,
        sidhartha.kumar@oracle.com
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, jhubbard@nvidia.com, vannapurve@google.com,
        erdemaktas@google.com
Subject: Re: [PATCH 2/2] fs: hugetlbfs: Fix logic to skip allocation on hit
 in page cache
Message-ID: <20230504001409.GA104105@monkey>
References: <cover.1683069252.git.ackerleytng@google.com>
 <f15f57def8e69cf288f0646f819b784fe15fabe2.1683069252.git.ackerleytng@google.com>
 <20230503030528.GC3873@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503030528.GC3873@monkey>
X-ClientProxiedBy: MW4PR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:303:b7::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA0PR10MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbf87cb-e32c-4d76-0fea-08db4c347d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sD3ujwFqy9lbghmD9Pzvo9mPqDZuw/3IybCtu5omEubWvRan+Vm7DnyEF582zLgYkiLqSycKRNqVU8n/eobM53TT2Rs3dRZZmUnfvgVRARJbrBlAY84oUrOKiLCnaPHFzOiOAgljlGwm2RZCjcKZkMB6Wtaz6dbL03lmFuJBDNrOATvKYpg8o9Ri87hZzKgZDXth6DIqwCY56rJuqg15XIN/ybSR/1WWTuc16CzxybMgv6fqSeqzNlLsVz491TM3/66MjmIjRa6tkEvV3XZ2GgkBTbMr6r79RBvbFY3SO32h9HMilUw9xUUHrJYPD/xc8p1W4zl6PEPZKo+SE+f9Dzp8/fNCmqpsYLJxOIT7KwoZP/LeaIdjlQkAO7er8x2ngRAgzWg+98w38nCVVT/dhBErGGPmV9x32co/9Yj+VlU07b0QxChQsYoeMTEWFV6lsqMz5HuuG48MaktZRPK20t6/W2WwzXZxVEQDgZJxV5L5HKDW+8tJAun2WMmmEuOWDU/znAmITBPoJYUm+LOqGBLbJQaHXVZfuEuc6FJA0y9boXYD0U5rlzUtHaLXjB/v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(478600001)(2906002)(316002)(6636002)(66946007)(66556008)(66476007)(4326008)(6486002)(6666004)(33656002)(33716001)(41300700001)(6506007)(6512007)(9686003)(53546011)(26005)(1076003)(86362001)(83380400001)(38100700002)(7416002)(8676002)(8936002)(186003)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9PZ/acYfqpYEfSVYkvG8Iv/b8xABg/iKl/5tCBrto9fVtQhKPK7rAfXjYmba?=
 =?us-ascii?Q?hhZbzTLGIObZKyCFS6BkAs3QDaYzf9JAc/oBIWjRAh9UZAqe9quQdCTu6x/J?=
 =?us-ascii?Q?5TOzrULczYFyW12olsgiqI23doObGmpQIoGXq/HhA/esC4yAEh0VnsLQ3rxW?=
 =?us-ascii?Q?VOvEio4qGylHoyXv49wjKAkHSKdjkib+Ku+mFc4q6l33JgrpBDvoajyPfCUr?=
 =?us-ascii?Q?TjlnCanEiElhsvrqcXk4KQBIY3OM6769ruclpbUIHYPS0GrbLZaQz2nZa+P8?=
 =?us-ascii?Q?U2GaCZ8i3uxHGrlmSjUuxXRss/ZL28hlntIvjYTBYzGPHwHeTTN8iYUiJGVi?=
 =?us-ascii?Q?gwkfBUtogqk13Nfy/cibG88DT+xeULv6zg9k3/wyOv5OAZ3BPmyYwCn35fT8?=
 =?us-ascii?Q?bntchkSoXvXbX/HoQC+bqcHYd89RFrelbxyfcvg2HYn3xoQx9VE1kTMfmrAd?=
 =?us-ascii?Q?1P2GsNYoWFkBcgM2o37q0eIHE70DpTnHZQr3QKebUZGyCnbH47Q/qrkIzWmD?=
 =?us-ascii?Q?IVe1lkv6a/dWzseuHY21Qkax/InLhSLD/evtHz5HK3wGhWXrmiD1J5dGllfd?=
 =?us-ascii?Q?JvsaRWZZVTgPuAqrNN8U6arN8S+acPMRbK9LfKrHkB2G3ko7C5HGr67vll1Z?=
 =?us-ascii?Q?2UCVUvO8ILF2nA1GSEIgqN8oJNSaXmnZKpf14WejW65l7uyUXw91vScHD6T4?=
 =?us-ascii?Q?ibn2Dgs/bgbXrVxS6PDzlbXDGcQvDkwAm5vW7cN9bGBYdftHAVaFI3cwtfyc?=
 =?us-ascii?Q?ttzV+33V8VqktUbAgJsSN699pOXMa3ibJO77bPN5HZQU2Vwd/sgNBfLgR4RS?=
 =?us-ascii?Q?ZVCxGetGMIFufunMIAPlR2F4Nv6Kx2N0WqVGc/qlu/oKTeSgJDKTZ3IkDZFz?=
 =?us-ascii?Q?dsqGs3NA2TKESlBLTEd2Hzc7MgPxzvJd41jgaY57IqrsJpwl83/jSj2j7c7p?=
 =?us-ascii?Q?cRzCekfgnJWuEaoAEo01RW3tFovZ1dKIDqYhrr+w2uUvCwlOaTcHYQrl9YW1?=
 =?us-ascii?Q?td+nFAk+2B8A1JVIdFJmG+kVgVU9x5Eoel67m/OlkYKeamQh+g8ImM7s6tji?=
 =?us-ascii?Q?ekMxVX+6biWWMDUNulGT4P4FYyHStFVTJJwUJf7UNa9A4hABPyfzud+UXeDX?=
 =?us-ascii?Q?p+zVlkP2/QzGRX3lhvvENZoce5RHCPKvIF714Kx/TQ+k2Vgp9UAgupe+B4A2?=
 =?us-ascii?Q?Fr+To0vjmE+JfCEdVlKjbcGKnMmeqAmXzkYcEcvYfMUEXJkrT9GnJ2zV8cTR?=
 =?us-ascii?Q?A8dfRSEhugWwICUWGdxZaUFMRTZaURbkVogFgltxEq5wONB1NAUaOFzqnl+n?=
 =?us-ascii?Q?DPP1Bz63EH/FzqxdNP2JVLEu5NPo2AvWdutziNNQPlAjIootsg7bEZ0IPIkZ?=
 =?us-ascii?Q?S3oZL60aQfZhQ6RKVGJIXQMaiFc08OVt+lK64TVnmfFZ6DAft3HoEMovyg4L?=
 =?us-ascii?Q?g3wLN4A+/e14jmzIY0FIzEh7pDKK2WWrA+qNdoEU2xtm7e3SHmDEvuYhDkW0?=
 =?us-ascii?Q?1EDDW+MRV3TvWAG1nc1d3Xo9n1eCzT+JbTNYlcwAap4xOmfS4X/mq+sgP8If?=
 =?us-ascii?Q?s4MlGEY0NffzGdbflDVmuk4jiv+hGiA3pwqU4VV2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8QyZEGXzfaFb5PN2G37jpBjaHlHea4ktOevHv6QKWkI8YNKp73mjqMIrAQII?=
 =?us-ascii?Q?J7Jw+kq5ni2MpNIjPJfidnel+RngOYnEuXkvTe1rBi7A5ahLv3YgtCSRrV6T?=
 =?us-ascii?Q?YKjJmQQua10vlblbWORLSdAZTmBdIn9lV6DpaKQnyPRK4BhFliV0LrA49l1m?=
 =?us-ascii?Q?AQSFMvkFtXrp/iJSQOQkRq8MbmNCBgjcK/+5s6S/wPQK8DoHn8EdPS1M9/PJ?=
 =?us-ascii?Q?edsSsvnsZskwFBg0i5xmzfzmQPag6bpavvClFZcJk7D9S+R/fs0iYpVFf+q8?=
 =?us-ascii?Q?BI86pRg6LxOrMw2W1FXVMiKGl4iB1+hs1owQxJ/Sa+s9k0pIWnlfXi3njS3R?=
 =?us-ascii?Q?LBIpMwrQwcbIdGOUfN4tzkf5WcFTqfmQK8LaOekNfUPCxRxtsZ3eZL7oqQim?=
 =?us-ascii?Q?uy9HWDGgd94sVduJsCZxuy4DS8zKCI/1xBdzbzY1csvDyykFrwmJRrisffor?=
 =?us-ascii?Q?egbNCx0kk1dJLMl7VEKC7/N+iF02lb9NtwXkgg/Fsr9dkRONxDvT/FrcuIG5?=
 =?us-ascii?Q?j8uHTsrUNq5/eOSMYm1fgUlEMDPXWn7v841r2v4V94toM/VmHINjNTuQ0iio?=
 =?us-ascii?Q?yWVToeriBRLxxmX7cW0otliR5+SDEjKk1vNU0obLGe5sSjkeMMZTsTZk1W8T?=
 =?us-ascii?Q?WAevNoshYftnfPmbwa2SgnSNlqafSHJTY641QVD6FruB7irRrJmYlM14NNvg?=
 =?us-ascii?Q?Uiu0zJRzCIucIqg/pzQpAbLbBZpRsQDDjw3zJXo62sj03Ix7+e8tFEPNsF+Q?=
 =?us-ascii?Q?VG0gVPaCfA4jl7Y0Q+Gbx6d1klWu5tMwFsMjiK2Ltgqs7RtGIuYhZ/ShIIVk?=
 =?us-ascii?Q?c49htCrUI4j2GRgHXJx5c4kW1wovwB9tcvtr69UPuiOTOxJ5S+BHAIvNT3St?=
 =?us-ascii?Q?u+yjtlgBuvyRiLi/oXK5+BM+JSMBZoCkJeIwiUyWhVGRVe2bGEay6jwfEmM6?=
 =?us-ascii?Q?XKSnRyRFsin/wbrz4K8LlQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbf87cb-e32c-4d76-0fea-08db4c347d2f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 00:14:12.7720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjsN761FYyzjAt7bueI4RW4JxbAbtsg0XyMSX45YaxgSAGOMsd3wXUgRbWZZDtw0nmkoQCJb6X7INE9LeFCCbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_15,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040000
X-Proofpoint-GUID: dQ9ze36Ga6DZVvhNInLfezWpobwM0XlC
X-Proofpoint-ORIG-GUID: dQ9ze36Ga6DZVvhNInLfezWpobwM0XlC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/02/23 20:05, Mike Kravetz wrote:
> On 05/02/23 23:56, Ackerley Tng wrote:
> > When fallocate() is called twice on the same offset in the file, the
> > second fallocate() should succeed.
> > 
> > page_cache_next_miss() always advances index before returning, so even
> > on a page cache hit, the check would set present to false.
> 
> Thank you Ackerley for finding this!
> 
> When I read the description of page_cache_next_miss(), I assumed
> 
> 	present = page_cache_next_miss(mapping, index, 1) != index;
> 
> would tell us if there was a page at index in the cache.
> 
> However, when looking closer at the code it does not check for a page
> at index, but rather starts looking at index+1.  Perhaps that is why
> it is named next?
> 
> Matthew, I think the use of the above statement was your suggestion.
> And you know the xarray code better than anyone.  I just want to make
> sure page_cache_next_miss is operating as designed/expected.  If so,
> then the changes suggested here make sense.

I took a closer look at the code today.

page_cache_next_miss has a 'special case' for index 0.  The function
description says:

 * Return: The index of the gap if found, otherwise an index outside the
 * range specified (in which case 'return - index >= max_scan' will be true).
 * In the rare case of index wrap-around, 0 will be returned.

And, the loop in the routine does:

	while (max_scan--) {
		void *entry = xas_next(&xas);
		if (!entry || xa_is_value(entry))
			break;
		if (xas.xa_index == 0)
			break;
	}

At first glance, I thought xas_next always went to the next entry but
now see that is not the case here because this is a new state with
xa_node = XAS_RESTART.  So, xas_next is effectively a xas_load.

This means in the case were index == 0,

	page_cache_next_miss(mapping, index, 1)

will ALWAYS return zero even if a page is present.

I need to look at the xarray code and this rare index wrap-around case
to see if we can somehow modify that check for xas.xa_index == 0 in
page_cache_next_miss.
-- 
Mike Kravetz
