Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C21720D49
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jun 2023 04:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbjFCCZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 22:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237206AbjFCCY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 22:24:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C25E41;
        Fri,  2 Jun 2023 19:24:57 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3531xw0T030857;
        Sat, 3 Jun 2023 02:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=+uoJf+kj3cCAHGZhv/prIpuMXzlWf2vM0XE6jgGunzY=;
 b=JUpajYaorLwmE6Md9BfgsdbPT52Xf+XB0hbeVcCV1VRhwHjq6xmQT4Mzc5iNUA+ulxJD
 Fa0NujEeM3EIfqLQey4Ocm2W0fWhK567N0jjYAcYq9HcgCM4iXUiwTMmhW6IpOSPglSy
 rk4TMtf+CD6rurxiKSxvyfkALhO9/T3QWja7RgQCYqU0ABBw6MxRyYffCDMkZJGd5APA
 el+cPUJpORDew9MEwrajtrpDshE2+B28iW2E10pza+B1pqsePc6sn2ZIPaJC/bfkMVk7
 9vDtRSmW9loBlFYvC68iDwtWdHCae2SDWcNatv/oZ3sc3QzyYT0gYAryzj9hXaefRZIs IA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyva3g0q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jun 2023 02:24:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3531X1F2008911;
        Sat, 3 Jun 2023 02:24:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qyuy1h0ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jun 2023 02:24:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTT1IESg2JnsQrPKu84LcJs4ZSWpp4LnolXY5xpS4vvoN/n+1PeYjqlOaTOVz/7BHgaSXSXFRkM/kb96a/8srfKohH6aSH9Dp8Uy9HDcaWjYvQRgBzHFwT5bctZxeK5hKW85cMJQub0KrIdPrOcRyCEBUm08uxk4VS7G+H2Ynr/q9/CNauWyD45MDT4/TlhxPoFEiSisHV+aeMCmeM9IOtM6f8e/GVtPqE4rO9tEWbPj7N21YvD7gwjur8/0IMBoRe6W7cY5Gii/YuJ6YbPj4NZ4lC4DuMwAhgjNgGMRxdGi7y4YrAMfGdJy4Cx18v3V60+p9wQ4jPkY+iAU90jALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uoJf+kj3cCAHGZhv/prIpuMXzlWf2vM0XE6jgGunzY=;
 b=Aij9DtPHTOZFv6Znmt/uOOFot8i5KI2GDuBsYwaAIS9+fiFQ3a0zF949DGU7MuekTSCk1xMUG9eyvZcevGSh30bOSuTyCxuLxIfSg3pDcjDZDJU4Tmptu4QNaSwp7MNI7KmK0OUm1GNah0t6eqKKF+TUcqhfhFeiFxrY47R3M0kqM0y7X/Z60GKA1Hw3Rw5ebHLW0S7nDDePzGgAx/QAcq99ST8UKIGBdCMwjHmu8DZdTOYo7heSc8U32OYxeEMYZIkVcBxEFl0yWia1WUnOoDIj16lfwS6VzMTHeeBxIjqYcpaaR1hHQl/DPbdN9c7ReAlUFjZLQx/WWxSfGvkziw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uoJf+kj3cCAHGZhv/prIpuMXzlWf2vM0XE6jgGunzY=;
 b=gUa/YGAa6BIq1Cz/T64hA/9zs1Cqh26DaUe8vWR94bJoEK+q4CIRAQURTbuvckZjMks98VFZ6VKxK6ZTSohSr2bHel0J1lqocLtNB9ErZfd2u7W1hC8f+U0PoSDchQkLi/6Kap9o3msUpIKTfyqUG0gJzNM4r5rwNyJBs7cqP2o=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM4PR10MB6744.namprd10.prod.outlook.com (2603:10b6:8:10c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Sat, 3 Jun
 2023 02:24:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%6]) with mapi id 15.20.6455.027; Sat, 3 Jun 2023
 02:24:30 +0000
Date:   Fri, 2 Jun 2023 19:24:27 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, vannapurve@google.com,
        erdemaktas@google.com
Subject: Re: [PATCH 1/1] page cache: fix page_cache_next/prev_miss off by one
Message-ID: <20230603022427.GB114055@monkey>
References: <20230602225747.103865-1-mike.kravetz@oracle.com>
 <20230602225747.103865-2-mike.kravetz@oracle.com>
 <20230602175920.4891c718afd2b20b7cd620cb@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602175920.4891c718afd2b20b7cd620cb@linux-foundation.org>
X-ClientProxiedBy: MW4P222CA0025.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM4PR10MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ecfdc31-fa23-4600-d3eb-08db63d9a940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxq808hAyB8sbQg+X7nmXJHU4UuLscgo4B5MWlE1BNwBGd9vgpMdzSYeb+KsgAPjDql7BopQI0/tbrzghrPPAj2gbthKScKi+JH63A8YFaH6VBNE9asAipcA0eIO4gt6abSIGE3L3aG4j6q0TokAGliTaArd0xGQLHhP85CSoo1TNHVuxIeAfWLst16qYM5QavLaBuGFRtl0Tq7vW0WoA3eWTKp7oG1OmDs1ttfAT21rztibP0e1bmeaUH//O7qabXcDue4PQh4EpkcKHni0VF3wsg9CtT3MpKz6LmxYNcB/c7UVZCPNlxET0dvy5HRD5E0azfmtr4KSJfSjbSkFLZszx0U025EIMiAZn7dc39eAvXxeSafTECjJ2L54CrwxaRMJVvbFGqkx7JHix6tjT3PxXgjcB1N7nhKy9Lx+UHdvHfNaXmgglrP0FP3EPhDnogDnElhI35AdNU2zV9JpHMa/L5PMcBRDbwFo0fJyQ+T2P0clRimAcyowxVBEO5Msc/AepjalAjBTziHY+aU6yWDFb9w2LG5le2f9nJUiRS1gQ7wL9puHoZQ3th88PFmp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199021)(186003)(41300700001)(38100700002)(26005)(6486002)(1076003)(6506007)(53546011)(9686003)(6512007)(6666004)(478600001)(54906003)(66476007)(66946007)(6916009)(66556008)(316002)(2906002)(8936002)(5660300002)(8676002)(44832011)(4744005)(33716001)(4326008)(86362001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ajB3mjRtGzpAdvgw/Q4OFvP676ra9TUMhKF2FN2jseDohMwZRC6yHlI3LBED?=
 =?us-ascii?Q?qEI8YRw8gbHleTlVCNLDghAI7uflJ9m3as+eQg7xvNvY7nyDpau+l0+9HI6o?=
 =?us-ascii?Q?xAvouQF4u4cVRi21mrqc7BqZrXQpqujb8a+KcZlesOHX1ZKkwC36QwX6/BC3?=
 =?us-ascii?Q?NMFMdBax/lJSw3POrFQEV2MjccdnhMeq81y6zAn8T3xRxQai8rF4Q0g3aCjp?=
 =?us-ascii?Q?uuqBi7BvrlbFTZvV8Kw+xNWOe1SRRdLnZ7c5dvFN+WgQcyfQ0ClhqTW/UhJ0?=
 =?us-ascii?Q?R0jlKdU/seTMOY0YDa9oxtLALycXN0e0E3J380T9AzqRkhPauVNSJ1uIaPCW?=
 =?us-ascii?Q?sFI1vHs/D/Hv/w1EaYE3qzhXuEOnRzSIKcqO/ejcOVjQk3vtnh+WdeRtLBG7?=
 =?us-ascii?Q?ozw5Ujy66EiIRJ+FC1I1VLpWoFD0WB6tySCDiND5WO4YqxuNQEvsvUCvx7Wd?=
 =?us-ascii?Q?kcqPlt4iOBtTaTPV2dKC/2emY/5Jdw752wfNxfSer/Mp+mufgpbw+Vo6kuVL?=
 =?us-ascii?Q?/pprMYPfC9ftK4FHml+zBPIcfmyLzIAFZVu1A/GxsG7U9Ae+ayeSq2m/1eI9?=
 =?us-ascii?Q?byf1dQlvPUxBnqNm1tULuJZwZYEUzl6SdnjxOQHA9xqNxfUyDO128NixL70s?=
 =?us-ascii?Q?zN/qYZ/+y81AGVqvljV7AWPTZMJ6z3988iFqZ7mjvaAGTfLoMuuyHL2mXaSy?=
 =?us-ascii?Q?FKFWLLQ38qP2bxYtG0bLzr7oFWyTxbSUenNaYbu1//Eg5SJBm2gE6dexJX85?=
 =?us-ascii?Q?dZyWV0RkLfDbP9KU/W7nt8PO0d4iBuIFd5GYkK3jBHa252tdnJ2Tkru/SfgB?=
 =?us-ascii?Q?c1p6SR2JhIwQYsQU5Zw553VqVUZZxWRa95yJSUWnEYyAYsIBqzZHZots3kdx?=
 =?us-ascii?Q?NSWjOON6kl9EWnKswPGZcFbO7J+15VjEHAtxHMyuIWXJsYPNnxA8+tfZ4DBv?=
 =?us-ascii?Q?68EIiyNma6qXDKWS2XC1FxV66ABhA6W6fxDyRobufBQ4dxAV7sViqxAHWGhr?=
 =?us-ascii?Q?SemEMvhmOl5cMhrZVRp6IZ7IaYZaxrnZ1Zr0ljPpYAJZObcTECvW2jUFvSaS?=
 =?us-ascii?Q?gn74QENAePfTG21qNjCD2GfS0dS1zgmaoXmqKGuRmDSk9A+/GdKMMWiSBTvO?=
 =?us-ascii?Q?LxOofEJy5r72ebYV9gS1g63QSf+YDa5Bklrt3USxnNBIpYzCqRemh1xw/n0G?=
 =?us-ascii?Q?puVTTzaxgQJac3Oe317To4Fdy+Hu5gP+BRauvZBhUUXdoiTvI8fV3Rak+Z+v?=
 =?us-ascii?Q?akBoAvSBrc+Sn17BMnYXBNtNWYN32m/K9hCSwUmvNxvXXuuBDysLAZ+g+AXw?=
 =?us-ascii?Q?gt8rwZRJAVrWT2Fmsgj9PLxS0n0X/HTl6OuPchcKXsn8Z8zwbpTA+N0GyZF3?=
 =?us-ascii?Q?zN/WiHhBbCbINUaf/KVjRizGxJj/p78yedEo9mb0m/WeFZAowTx+MGrmNUAP?=
 =?us-ascii?Q?c6zUMUYg7XnD60a2StF59TblcJiIHqMFykUmxiCK0tDqIPRJoIWa0Iew4q67?=
 =?us-ascii?Q?fuxjTzgF4o25TjeD7QU3IsCowBWXkbRjUAJfHEG6gmp8/hWH/sYpFFKWrz3o?=
 =?us-ascii?Q?DfeQVfCbUljqTdnvo7aQWbk1sQ2HV8b2Vv95dMZj9i4ZR0LPG0Acx9BN+eMs?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Hjtme2hpTqLEgLbRebka0x1ZEIQ2h2AkopXilLR/x8WDgTVZZj4S0WIsvv3R?=
 =?us-ascii?Q?j7h6VZ1nyQ3sTcVlpfY7/dqEe1SbPPNfIoq46bT11vELjKsg4IRt7SEKBvMC?=
 =?us-ascii?Q?wB6q6HxI9oZb5oov98sp7ao4AiXxQZ3z59SPxmj00bxU05JmgQWMlENCmN4n?=
 =?us-ascii?Q?u7XZwmHfSCCdtdW4SZMQC8fptxEd3EgTbvnUjPJnQ8/uScqpOGzUTuvoInWX?=
 =?us-ascii?Q?Q/MRMb723Expq4FN+B4ZYO4sV2gjGWc9XbascBKG0IDtgyhJagprKNseFngd?=
 =?us-ascii?Q?I0w3xd4tTJ1JhPMkVnJ9AYnPjs+IjHzCYnPZHiVWDQUD0jBuh6edEG9Yf1aM?=
 =?us-ascii?Q?fSZR8Zi3An6Xs2/7+pSkc43Q4jtYYtxGbMcJhlu602i8VvGBNpLDESW1PJcM?=
 =?us-ascii?Q?eL52wzRYTjnfcAWMjdl/cJYI7WrSEJovShI4EiFBalBfwtLqtDbKnCz7DhCk?=
 =?us-ascii?Q?YKv/IY9J5Lut/t8Ek/7UyYsfzRk1NysPkUobEhh7+r8lpY0vUYGqgTC64C/l?=
 =?us-ascii?Q?zNfVNRtAGb0sTbEWVdO0leRnvRkaJw5aQdAyB7CY7cI/ob0W5hzkMYeBKD4v?=
 =?us-ascii?Q?9UvWBEQ1RcbgArQ5/Ug2ET8N6Os9w2Dt3qEz5rdqw2lcivjYi0bJUwXYl/Aw?=
 =?us-ascii?Q?SD5XlXMTM6vyKUOJSbPgzboEArepJ87/BPP0HEanO1Th+sQbWeHMR/jAXBRm?=
 =?us-ascii?Q?/2Ph94AQf3dLCULZG60McJikU2t/pZPJ0QUmKEm4g27l1PWsyyGhgeflx5G+?=
 =?us-ascii?Q?3CbakI1Kz4sNWvFNYMbj1cLAckPnBApzVryXcwc6mwuwzGN4Gpj6WpnjZyNN?=
 =?us-ascii?Q?S5tzPOTYzslf3FYgtnjcDAszXe93cUOEqGmKTq7aXdSpGrxK29uRR9xh0w/D?=
 =?us-ascii?Q?VIJyv0qdcoUafZPQJ3KSxBRPXox48YMZHxa7322Vr3QxWC+EyI9qzqulcV5J?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecfdc31-fa23-4600-d3eb-08db63d9a940
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 02:24:30.2617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDGW1eYysrD78GH2wOWOwh1SB3kVKaaRu83YkbENqbsNNJe9Kx/q4RdJrqkKwel+33/G4mpsRTxXJUpm38cAUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_18,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306030020
X-Proofpoint-GUID: _rEaH-brFTsmsTVXt8ojMOLvgUoI6p_j
X-Proofpoint-ORIG-GUID: _rEaH-brFTsmsTVXt8ojMOLvgUoI6p_j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/02/23 17:59, Andrew Morton wrote:
> On Fri,  2 Jun 2023 15:57:47 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> > Ackerley Tng reported an issue with hugetlbfs fallocate here[1].  The
> > issue showed up after the conversion of hugetlb page cache lookup code
> > to use page_cache_next_miss.
> 
> So I'm assuming
> 
> Fixes: d0ce0e47b323 ("mm/hugetlb: convert hugetlb fault paths to use alloc_hugetlb_folio()")
> 

Yes, that would be preferred.

I originally had Fixes: 0d3f92966629 ("page cache: Convert hole search to
XArray") where page_cache_next/prev_miss were introduced.  But, there is
no issue until the new hugetlb usage.
-- 
Mike Kravetz
