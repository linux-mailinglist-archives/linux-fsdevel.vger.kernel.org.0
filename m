Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E518797D38
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 22:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbjIGUOY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 16:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIGUOX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:14:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2731F1703;
        Thu,  7 Sep 2023 13:14:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387JtiEr004487;
        Thu, 7 Sep 2023 20:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=9TK+tMeB+Bu5FReug/mKes6jcDW6k92zSGA4L+wzZuU=;
 b=2Htrzv3GCowYBzKZO7W5DU6MMWFZTBCKU93sh7VC1mYYNfCMvTNKXc6oYsUtYV02f0Q0
 x7vJW0bqbIdrClQ0BlwqQ28dZl/WudzMbiIFYFIughyfrgml9wPaZijxYIxOwfXh9QTl
 +mYGhVs+bydPz5i7fH7WDkxEPfnG9rmQ3/ViTkaHe3B6UW5UW3AZb+DNA1ptPE95PK1k
 M3Ily2uDiu+nzX7rMe1mYqArOstLoLq4tHEbTETc2vtsGTXCFejqPAP16JjdX4FnqbHt
 MjlLsT94rnU5TI8oeclzY9TXPBv5/syTPjpdWtlIu633joxlbgUixHPXfFL4xycB1zyJ aQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3syn3c018k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 20:13:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 387J5Y59013243;
        Thu, 7 Sep 2023 20:13:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugefcmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 20:13:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjZRk+ygrRt+bSAsSKo9HXh0zNjKJNOkBoqfYxok1hoF5BREAiMw4E34FOvBP8IiqeiQLnbKSukfzG7oPJ0WGrxBa/skynrRyRA3VY9uM2RiANBwl8zzTFB90zvnmhayH+KgTjsucWzJ7e9Wn13Ssdsmps/crcKBWoAFBm8OPWDL1ry8CnK5MgGGxgw8/AewllThxEUYgIs5ajDsXryYSVk5QQyVpRTZSaMRXWXGQ/rd6PtuhXX7+ZU5iSqC4BG1PVf45fJURLAv5V1pCURB1V9mwtwb+KcqAsZZ+bwYdMPQKnmb6iuH/d67+DvGnHGdeDn+kwhCJFCG15F7IwxV3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TK+tMeB+Bu5FReug/mKes6jcDW6k92zSGA4L+wzZuU=;
 b=HNW3OID0NxT0uffTNmoAbj2wnz5j3wAOabLB6K8cdUm884fnM9EI1UaNWy1Mn6PZ0VJYUvmpNCtaePX/hHHXJYbLZ1982DR5o3sUJJBaknBrd3sS0XWKvbfp0JR/+TxEcj9KgdwfK3lqRaTC2muITEf+8h77uwriIXMH3LBCucq+67o+jxLCA08l5E6IOAqgpA3bgXwQhv7i3JHJ/ScdafSmSy8sL87Hl0J/Z85ThdRxV0L+KXjvQP4AmApd0JmuqqChGnR0+DDO3Hr6j4FdTyC6bVQdAsfICNM5JnE4ld4XBlGbYoqLSQwH0Gsin9FT4rrgSCbczW09yx9KF74SCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TK+tMeB+Bu5FReug/mKes6jcDW6k92zSGA4L+wzZuU=;
 b=a2ssfbxwnY1Opjg9MJFbw81KBn+oCp7sKUAWwicZeaMCiaRfYt/5g1+8uHqnABnxDo1CRnnT1k4IMcvayJwsCPKsFI+gK2iA/0nItJvKLx77N8wy1KmWmFG1P04EcJduwH7GIePvGCH1riX3zfyvHPpE41A99n4xyRwgr+V8Hj8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB7045.namprd10.prod.outlook.com (2603:10b6:806:342::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 20:13:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.029; Thu, 7 Sep 2023
 20:13:17 +0000
Date:   Thu, 7 Sep 2023 16:13:14 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] maple_tree: Add two helpers
Message-ID: <20230907201314.g4scadi3tk5ctrd2@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
 <20230830125654.21257-2-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830125654.21257-2-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0398.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::19) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c08a7b-561f-4ff2-2e58-08dbafdedfce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FXZyHW/WQ0hyM9mw5ohrY5S3mLqHTqGeYz4b5hduPcsx40P4u48qfq+MXl2zIXDP5FG3vWnEUrbEKNljxd+5Sha4TKhyIGY9KHYPqjWarAs4sPZi3GKF1bwdF2ik6mxngq0LkqxFW+kKJux/P/B8PjImMFkaCjxrfLDs1TjOu4vq5k8/ziIO9gxbSqaOC5C0iOkcAIji4+Ap0OH3SNCyrQSeuDn/eWGozkCEa98/3WD7J/aXvj6HhC9iut7it9D3FTvpAoATtJPYiC51CryiL8IMB1ZSh5TIQaP8LpElQ/7i8uJqkxqtChTXTp1ME0UFZS5D8F/mkRq7pa1ZDYL585md4/mRBWfhjwqzomP4gwXC5rx2KRE8iGZMevKKbUkaq7DJ7qBJDCMQjPpaYHJkqr/oAeYXxd+L9IGM1Keq/QZBxNJfiFp2Xo5qUW43qg8+foz5s8ucoeKBIHOnb/ogEJtsASe1P79S/h6SBV30Z7rlJtV2NGguCXihq2DmAjDquULceynj0qL3wJZEZrFWTKej5zJPEej49EErqowbmz31Qzp3cEQcyI/s+BR9EGKO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(136003)(366004)(39860400002)(376002)(1800799009)(186009)(451199024)(33716001)(2906002)(5660300002)(41300700001)(86362001)(7416002)(38100700002)(8676002)(8936002)(83380400001)(4326008)(26005)(1076003)(9686003)(6506007)(6512007)(316002)(6486002)(66476007)(6666004)(478600001)(66946007)(6916009)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oxGPm/Ai4jsnUsJ+XwFOKquyB6QSnZ1N5gQ0HeNZcdvdGf59OX2mPbL5orc6?=
 =?us-ascii?Q?d0e0pHQxlyyKboNyIeVh8tTr5EfV1nFVJoIESB3nB3BKReYy7Zuh0AwWdJ8A?=
 =?us-ascii?Q?lQjH5xQWpYyOeEn5YyUqTYYR3wqEL/MIvADBn4TvbQMVhaplOnXDNLwgUqs6?=
 =?us-ascii?Q?BuwNbtyESnft11gifoGQeMOGAqANcFJjbmaxTIE8ddqOlteFoAnJL8BBF89i?=
 =?us-ascii?Q?9RzShVhkzxZ1x31N+aPO1qnukotWuCaeY0a/u23ncXWrLF8T32WAebMw9VhN?=
 =?us-ascii?Q?rlcDca4ybxnNGezlJU7L54opqmIvJxT+fc5oG/kQ/iFygy6faiM5YJ/fqENq?=
 =?us-ascii?Q?B2yE0Y6PC6lzdDg/70KwknIYYdnNnMg7lFkZxKsqUjzpm7q4ZFDZ+zLZcITG?=
 =?us-ascii?Q?IoVcdh2ZQIA4WwZ7kHhnBemb3Md3qi2t5IuzuLd32h8n1i+gS6s23sl9giku?=
 =?us-ascii?Q?rNGuYZ29xuMcntllsCIfBRG0Xw3HyeaPlSA9r+H+BxQ4Mt4dsB1aT7Fhm0eN?=
 =?us-ascii?Q?h+SLTDX9TU2C0GyERWGfcaWNdIAULS209aUAZVluk8vJb4aikRnlrklRXzpC?=
 =?us-ascii?Q?bt2w9ZEcpJVBXtXSjUhNzPBMhjHE6foI4hCe/bXPfrZnUNW3LOu/LXq45BbU?=
 =?us-ascii?Q?ssQvpu4NJFGffW7cWc5W1qX9tBDBcyBgs2UEbyfs30vjqJsv+n8i/pZZA3Rf?=
 =?us-ascii?Q?34sFa2SIeiCg0j5qUFoDYu6aZZ2EV8ajree+dG7teQevrQdMKIp+fXgO4vJu?=
 =?us-ascii?Q?/Ra7d1ZWqA8fUmSTgspZvsMX/WTo59vU2KxTFFz5mpjX3N4wmjbC54vQoJv2?=
 =?us-ascii?Q?M73Ra+qt2fXMoMFfhVyLQo5fr7tFiAgx1ydeaSeHdIJk00wxTzaDmKyKYUUT?=
 =?us-ascii?Q?0nkVNDpnbkLIRGVNDgQprKwFHp7dAKSRZOzAv1VwYX8iLOnYAEQABQxFFbZM?=
 =?us-ascii?Q?Gneo6XbcoeI+FtmpbkmNWdeuqv+35wFfkp64ZOYl+igSnKAvsQdcu9BrIAAr?=
 =?us-ascii?Q?FyFZfpDFYwRLb5j7C847RJ0lxkfMka8bGkfe0OcEv3WxD5Vip8pO6udyjO8H?=
 =?us-ascii?Q?4eS/l41KFV8Rrt3kE3bIHI6P9CMEw/6cjU+s++60YZ7tCITqoNWZZOuBCKP/?=
 =?us-ascii?Q?PyTy1Qj7awFZsyPq4KyvC4/MYRK/PWO+yXxelU3Ik2pVo4Ka0Ca9aK8UUuJA?=
 =?us-ascii?Q?fCpwbh5+hUS0BS6DJv2oxJG/W1u2nfd0s98+BlLqOnvTH4g735CoIkW0sJt2?=
 =?us-ascii?Q?R9i3SU75OSMjhRqzwgK1yv/JnE7NvVEdeUC4d3ktO6zhEWHf1Mo9t31jPcnZ?=
 =?us-ascii?Q?Q+8VbHknVONSG3hZ2fqZnTLgGi8olM4Uc8oL9sCw9smGxIyy0FazZTsYhQid?=
 =?us-ascii?Q?qcH4CmBG23CMOSIT45QNwqxqMLkLWQTG8n4Ar9Xcv7Vzw5+2BnO0xoPHSKe8?=
 =?us-ascii?Q?galq95AGFENqHe6vBRCHsmDWWxTOFElVp/0Ve9WaBhFfxHCRfpOuLoriM28C?=
 =?us-ascii?Q?NSWQBOS54l9hGApehxFThFEZYHW/6k2m2Cl4kPtVoKIaxgVGs5pFNc3FsSWS?=
 =?us-ascii?Q?uvtrhAg8gJowC8gRQn3HXL5ZJ2NaNj+hS8c8sg63NLJ5JJ8rLrOkjKweb4Xo?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3I6bBSJuqyJMP17NH2ueZywLwFZZS4ozQaVbRtesQ3QSCtXJQ53mHlAYd0qO?=
 =?us-ascii?Q?FXK4tmAQElvj1ufmJWreb2Ojfg1XmZkK4k2WKUzmHWFNizGuqO8Y9N0yJTCZ?=
 =?us-ascii?Q?eeAIcDDtlLrv/kHqUvFh6PGfgdZt+/cTRYIQPo026GjQE0N5LeHD0aBQrwjh?=
 =?us-ascii?Q?bRdo8iUJpu60ZNS6bgf1sULwR+4exZEctcKlId6OpxMWtFkAWRnxQJyBeaFW?=
 =?us-ascii?Q?uSos6yE3nhO92fBzVYqGO3QuO/TzrDdydSEVYHGeA1ls09eCCvecstPX8bk0?=
 =?us-ascii?Q?+US21BYyITX342K5J/YQaY8ublFFahGDb/lNOpmDIFZv/veJBnOeUTUFR+cL?=
 =?us-ascii?Q?+JXwaHJz5S2OHdDotnHfW6ukMLZ4FM/9rr3SmyqzNsFXVJU470Z2OxdonRNy?=
 =?us-ascii?Q?POnAV5/ZVwfNIIXDPiWhk0hQFizYx4gsSVkYUP2L5cYKNwtzHluRtqf+u9b7?=
 =?us-ascii?Q?1whmzrP9Ga5dFxkD3QubWRsjzZBbSfWU4UGlgQ78jwRJPK6HjS90Go9Henfs?=
 =?us-ascii?Q?edltP2GWf7G94CsRDlLHSqdXM/YLYkfAc/xZJHTGQZ3wYsO1JxQgFEtYA0DB?=
 =?us-ascii?Q?Dgf2+85tNQNF1fjYKQYPqwbkeoCdtaGwlry4u2GJrfPzcd6Q1/cHvtS8WdCQ?=
 =?us-ascii?Q?6PbGZyEEfVNlfIZnzVWVGUkc9JGQqGCVI6tRk/DoYCbaiJmmXN8ZLvwygRxV?=
 =?us-ascii?Q?lI55uwzC0y74ojWwanoXh/pOysbRYLO5/mhbfRZx0xaHlMg24OW/+cGqAJhx?=
 =?us-ascii?Q?Jd01uMAP7hN1hHemfhV9K6MciIml5UKJb/aPZd/VzmUYY+vpkohqPbJ4U1qo?=
 =?us-ascii?Q?xFDZNit+vz8H6/zxB+TTyOLZ112KHzLygkDNKCcgn8b6ICEJVdTrwJJLIke7?=
 =?us-ascii?Q?HGJ43K7iZGxKg019+ec+Oh4WwXG/mQw7/UiG/ESUIWO90FOVX62IAEvYVpsz?=
 =?us-ascii?Q?+CryIbD2T8MPuM2W6q2PXYrcWmtNrRpy8j89WhOZQCV+Rb107SztoigIxq6p?=
 =?us-ascii?Q?h9Zhc6LscyOqAsHD2KzzOdfEhqYrX3lAYpSFWepYAaHGP1+C6DQ0CWHKFw0D?=
 =?us-ascii?Q?H+QBVGbm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c08a7b-561f-4ff2-2e58-08dbafdedfce
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 20:13:17.7080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnsRvnpZtzeSvowAlZah74cb9Jo4AWddNLlOIZULUmaxLORjxQsF2HQv5I77LwhHniFA4LtbHFjsWdsmEG4lUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070179
X-Proofpoint-GUID: 4J60jG0GPyUl6m6LZ0OnLB3kO_9lYR5i
X-Proofpoint-ORIG-GUID: 4J60jG0GPyUl6m6LZ0OnLB3kO_9lYR5i
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230830 08:57]:
> Add two helpers, which will be used later.

Can you please change the subject to something like:
Add mt_free_one() and mt_attr() helpers

for easier git log readability?

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index ee1ff0c59fd7..ef234cf02e3e 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -165,6 +165,11 @@ static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
>  	return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
>  }
>  
> +static inline void mt_free_one(struct maple_node *node)
> +{
> +	kmem_cache_free(maple_node_cache, node);
> +}
> +
>  static inline void mt_free_bulk(size_t size, void __rcu **nodes)
>  {
>  	kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
> @@ -205,6 +210,11 @@ static unsigned int mas_mt_height(struct ma_state *mas)
>  	return mt_height(mas->tree);
>  }
>  
> +static inline unsigned int mt_attr(struct maple_tree *mt)
> +{
> +	return mt->ma_flags & ~MT_FLAGS_HEIGHT_MASK;
> +}
> +
>  static inline enum maple_type mte_node_type(const struct maple_enode *entry)
>  {
>  	return ((unsigned long)entry >> MAPLE_NODE_TYPE_SHIFT) &
> @@ -5520,7 +5530,7 @@ void mas_destroy(struct ma_state *mas)
>  			mt_free_bulk(count, (void __rcu **)&node->slot[1]);
>  			total -= count;
>  		}
> -		kmem_cache_free(maple_node_cache, node);
> +		mt_free_one(ma_mnode_ptr(node));
>  		total--;
>  	}
>  
> -- 
> 2.20.1
> 
