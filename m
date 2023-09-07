Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008F1797D3E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 22:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240394AbjIGUOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 16:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240299AbjIGUOs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:14:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5C51BD8;
        Thu,  7 Sep 2023 13:14:36 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387Jt5fh030591;
        Thu, 7 Sep 2023 20:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=DqjbO2bSm+278aOAsXEfDxt3AaD+a10ZDl0dvm9xWLg=;
 b=YwlEGgHlcD/wBTOVtH0DYXZ88LOxnskic53+6YqtaolG+CiBneBclYKxK2ouh4L3m3J6
 m7wFOwxeQC+XGIIM+qgpnACwbROkPvMeauAYeFjHLKAxghOTXPaCKO9y33ebv0bg7Al4
 CTnOr+5D1fI4+3s76x3kTtseEq9x9GLI9a+dmeZhGsruiaQvjXmzOpM7jVUJrnvHNj+1
 sa/747W6CYZZgWufCIrujp6LmI3uPBcRUTe/L+d27ja43oSIkUgjhEjLL9LRSLiZfPgk
 PH2HmhaC8wBtyTAHTK1afrWWQZWIYnlnPcdtBWdJ+ujuT1VxHqryx3wR+IKXvMKqT0EH 9A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3syn3fr1ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 20:14:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 387JAZno005035;
        Thu, 7 Sep 2023 20:13:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug86ud8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 20:13:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2PmbSYH2Ogyw48jupWEfTJ2WATfjAqvq9X7X8hTpDCEkbiKmm9cPV11o66UHHEqOioQa+Vys9zOd8x8ACvd2VeoJwmHUtb+RDy18uSzT5+Zd07vlVP8xq2xAaUekH1EnA65EATAO3kKZJQmzll35pxtD8WV5osGc7Ya4HJoRskifsjjr9ccNe3non5lQkVzP2YsnhSTyE72zkSN3y+bRvThFqwUavksNM2YU7eP/HvE0HqbpRRZoHOfxhEpEU6ziyLrr+1mOEesN+UapJOPyBKICeWwHdq+DywuRbHF4j1J8zG6xdycgttuxVMvCFFD5W/Wt+LuE6jK7RNGA6RoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqjbO2bSm+278aOAsXEfDxt3AaD+a10ZDl0dvm9xWLg=;
 b=GfTwn1MZ+oB4qNkubFYAiPtMsdG1ZoiFuYgbJPbz/nB0ASQwjhYDDH5LEICDdIaLPCmLczBEPXMjz9A4YEkN1e2UzDvH+yo8iynUyBGL2zKofEHZbgs5Hj+ZOyIHYg4naYylZG/o/scDQ0aFtcROXQ1VKaYRXLuL9xXaKH68E+CRxxELM1R7p5MWVsDv25p8V9Zi6dIqGjX1W4Fpz8MwnEafSKFJ/QI8L9POsw7XN/iAHzP76X5Lfn8LcfLQVZYKrL6UqyB2ee+i9BBt6k/uwBe6WeTCLEOD3BG8dYyu7DH2R9zCJcqM3RrNvWe2DMtXKjXKq/a9WQSagRaSSOC08w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqjbO2bSm+278aOAsXEfDxt3AaD+a10ZDl0dvm9xWLg=;
 b=xe0bUrXb2nRnskfIl12xIcsa+XWDAjikQ3JzZJys/S9ZAk5J2hsBE3jZqvKDcjkGP9Pc0ObhfoKGILdJHadEUxnIOsN9/ebEKtgq5+G/p2pI91xFFy0lbLpy8yDmO47pLSxAG+cCrznhZtlMUSsbjcVft1sTkZTi10ZGPoEnEhE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB7045.namprd10.prod.outlook.com (2603:10b6:806:342::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 20:13:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.029; Thu, 7 Sep 2023
 20:13:57 +0000
Date:   Thu, 7 Sep 2023 16:13:53 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] maple_tree: Add test for mtree_dup()
Message-ID: <20230907201353.jv6bojekvamvdzaj@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
 <20230830125654.21257-4-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830125654.21257-4-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0180.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: a5339292-0286-4e78-292c-08dbafdef760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6q+baJhOsnTSKgMKqslJm0+KE8dgy34LgXuxluXHdT8j5w34EoOsJdbf/RQvrhHOyK9/zEd5fca9+gTQMYPadDDtGfGXa3nqK0F9YkbgkozfkiaPnkWIVy/434hR3j6DyUQfTerHvlHBplegqgLHPag6MdRcnURnuXSCFY2HFw0dQOX7YpmsFGfF29GzNB0ZdaRM09BsGolCe8w6Lu5fhvjbIL1+FDaE18WRK7wNQys23f3TTSAn+Wz1nE9VLsrk4ib6q1jS5EG8MqG/kSJuXIFEXtYqGfn3xX634cEMiVkwwDx4nNsXy8kY5BuEtG73M3tGkvxPsRuYK42pgeCjY05oscYLDDGas+P/GlIBt19IvhMptxGWfh7g6fvDkBurqRIFlLIh3wBL8TabuF9PL7aAeE8uiUyUJx1sloqkcbnnvgQMn813okLCnMEuOi49/aSBIGfdA2b6dspZXTRvwzeGixCx+2aKYMbCxGOKfvAqQMyoPwE+FEIAvFwKBpNQUXHN9aTxdJEhUwdlZ2tvlKPhViVNsYoxzF0/i9pnkvHq7kTKsT6TuFlsNIhl5wZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(136003)(366004)(39860400002)(376002)(1800799009)(186009)(451199024)(33716001)(2906002)(30864003)(5660300002)(41300700001)(86362001)(7416002)(38100700002)(8676002)(8936002)(83380400001)(4326008)(26005)(1076003)(9686003)(6506007)(6512007)(316002)(6486002)(66476007)(6666004)(478600001)(66946007)(6916009)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?89Hv5bm09VHmHCjRKAr4KcJdQtod9b/YqikRv35LezV4e97vXC4NXOtkGnny?=
 =?us-ascii?Q?ODcBCqK4QtY3bLw4NNpKDDQlldM4YwitRY2plrhH5IZXBlWAFxefexRf/Ipe?=
 =?us-ascii?Q?gH4ZX0MTXL/5iUjIzZxmRAeIvSqorlJTNLmVS6RJFD1NuF6skT5q1UyZ0Wlw?=
 =?us-ascii?Q?lAF0LuCOr1iVKhSMSzZNm3z/IB4Dhk0OBdKd1iAScSecHLntIAAg3AZm7mL1?=
 =?us-ascii?Q?BwvYKlbQHvxSR0HyPnD/SsaNbvwFi4dK4Z8549uGLSGuZianwmRoYsIZzkfU?=
 =?us-ascii?Q?9qFiR54hIxvhrboIMiKysqhTP2FoSm0c03rqWURb6eBuMJCdzv9sLBr7f3xq?=
 =?us-ascii?Q?O+ZAsCD+AYdNxlTAsVY4cCvNmc23e4oa4tFSS5tAYB9rU+JQy0/slGNQ6fKm?=
 =?us-ascii?Q?ygjZpT6pNzbrjxrNHpRxIunqgL2SFxXCqGlORifEAAU3BQ0SZNK+PrksaDw4?=
 =?us-ascii?Q?HhSDrqZzflVkZ0nHCY4Md43caf3StayTIM0EGkfrCOltKl0d4q8uq4qi4Uqf?=
 =?us-ascii?Q?lIsjBhFiHOn6uDcf6DTV5f6skRK77wA++rvmZNRjo3r390V20oHqX2QQ9PQZ?=
 =?us-ascii?Q?bd0xczw9QFo0vvGJ+9N3s1lKmFHXBlAONEqgtTdmOEJa94BkLT+8nJebsTVK?=
 =?us-ascii?Q?e0jX0KHdeKNxCnelc3AFst2nOvHLMwwuH5XPAS1DN6wQ6kxVudrAfwSHqZNN?=
 =?us-ascii?Q?P/kV/NAMvvYida515mwKwV73LmQrboqiHrJh08d5HGjGf55PITFwt6IbXdbz?=
 =?us-ascii?Q?aEXKZL31J7kg4OLeemje7K4FlvNeSYYbWkYRu/8vrTjwLvR77OhDvvA4stsw?=
 =?us-ascii?Q?Fxw1YD64LSu6cHcP9i3qND2FxeOH6tVPXzNz9Zg+iROMBIjEoDH5tBdvLtvL?=
 =?us-ascii?Q?NOr8A2IPWAKHnGi9JynV7EjME2Cwq3Vuwz+z9LtJOaBMW9T6QO4cgLnuHwJc?=
 =?us-ascii?Q?Tztvd0l+9EDfEfXrrbMty9bBMC/05m9rMYlx/hJRmq7NdvfrBtMoZBiGRxbO?=
 =?us-ascii?Q?DdrGzvtk4Xv2p4rp/nyhUyQ6JnbYkYu1AA9hoRIMmOhW+sychzxWt87aenIM?=
 =?us-ascii?Q?+qZfnbCO90K8E05o2WujyJnmd4uYeQ78h58yCLpOhKv72lc+ynsusT19mbI8?=
 =?us-ascii?Q?nGE2QebfEQR8rrqitnw7ix/RXeIPiahBUVwX7Qvh6WeIFpVauJ+4H6lOhJyU?=
 =?us-ascii?Q?qYnp8aBufmCOX+mCLwgGL5yacQwu5mZHPNrxhjOn+JIEGiHR4W85XqSZ+dI7?=
 =?us-ascii?Q?YwZlPu2qLEg1HPf+ihRxK6IeKxNKooRVBWbnXCiN46QWgD7NuEWccxjXpITx?=
 =?us-ascii?Q?hmgI+VmwY2JjYVX7GWtAt4XO663fSFSHCk1jBTZ9FDydk0aZEAxm/0NpqEXu?=
 =?us-ascii?Q?mGoMFrat8IW22i1TO3DU+c4cUgDMxwrl+Gxsk8XMe2Ik0gOYRxyI9iEGZKcx?=
 =?us-ascii?Q?0hfueMKLPaAML8exu3hR7uQRb+gkFRW8im3YZCyoPgnxwd5RBdRTxN43sWq8?=
 =?us-ascii?Q?p6azDNbwQTTH1GY50XQPLRzJILXM04Er7GPApC1mq+i9t7AxKzAnZdIPpRyK?=
 =?us-ascii?Q?RkmZ6ml4PeTpoaatJsoE4m+JP98sdQKMFCXeQA3X2V0zrbkoqunAvM2ORY7Z?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?u9DlgvmtiGJeQW05ituzphgtJUuEa4V2FfiesdTsSTFiaXq6OZf+BSMefRFX?=
 =?us-ascii?Q?i0O7ScWcnT4SLDzJ95RkoII7voEw6DTmHLUkjzgIsTPWtTI8mVJ5i3ixpiGv?=
 =?us-ascii?Q?XKZPYumxD3TA47E3MBwsL3fgxNn2ABF337ZXobSOMod2RKfP2cf8v1dPKosN?=
 =?us-ascii?Q?s+iYEUjiYgqDHcKepD/Cil51YkB+ShPKPf91JLGHl2443WVg7zwjvzJ0ahhW?=
 =?us-ascii?Q?x6A/pXXHqDB2vGXbz7lkJ09JbG31XLx8ShFcBMjjYJIG+zalIBXA9HpykS3K?=
 =?us-ascii?Q?wjdow41MzmgGisESwFd6ypT7/fhR40hEt3R1UTq38Vstnh9Awfz0k+h1Cgw3?=
 =?us-ascii?Q?uKU4sn9vIf9ebvl467v/AG2i1VmMQPslqTZtP+y1PSkIbcY+PE4bCac1TshG?=
 =?us-ascii?Q?NKXegqfCNvrOD/qZf8GSxbSRsIIZ14617n+EHTPlfdhuUUNEM0kFWxTC1fsk?=
 =?us-ascii?Q?IoXpR789SUtJL4eEJ6nUuYOS3yWN4NIvwsCQPGUeXdWbkS+Ks1bfJ/f7h6x3?=
 =?us-ascii?Q?3E+s7SHuNxdrETNKq8oRle3p3fa2yZ7Oin2/M9GLPHdN16H/f3Bgj7kXK34z?=
 =?us-ascii?Q?78O/Ec4sBONKsddwUSXNaTC73yr931qpjb6tNtMhrxojksD17kBiHSTe02tv?=
 =?us-ascii?Q?Gm9HhbCLzSKO8YOk15vy/jFq7eH1IQG0B2HJu18V0yxihdg4zIlHlVKHZbxq?=
 =?us-ascii?Q?86kZC1K2ASATj2HRWGvyDnrrLD/aySfINSOndSOzGDXbj4NHxFnsUeeIfImJ?=
 =?us-ascii?Q?x5P9QMi9uPpN0wC+qU6ymOv62IBwyQnjEa3ens0aOlgSK26M4B58fIuXIcH5?=
 =?us-ascii?Q?nBa52asHmfOY8sKKhx9/3UHzyeu+DZXZ7RM8foJBJDGyH9s7ofFVDGHL2bAW?=
 =?us-ascii?Q?ps+5d1svBI1IsAzaIRRw+MDgWN6W75zBxxaznBSpGX9C1XYmaubvh0dmZvSP?=
 =?us-ascii?Q?HrrG3S1XsKl02iBc+sROh1B5H9OXGJren/p6yko7yV/r1WuF2wahbLhu/EIZ?=
 =?us-ascii?Q?c5AQhxWrmL8xrxPnwp3PGlYM8iy1WHFTB0Pep+abWJYOOV/TtA+S+OgRVeCd?=
 =?us-ascii?Q?LecZwzZM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5339292-0286-4e78-292c-08dbafdef760
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 20:13:57.2129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwKn9R1APeLhprhhi5V7vajevIv1KcTpNg87+ByIyoktCb7vxPO/GgRzuqiar6qqui//XRCENlHvt8fW3ZnTBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070179
X-Proofpoint-GUID: sMwnH0BKUA-C8j4tkRJnwY-ZkP56OChg
X-Proofpoint-ORIG-GUID: sMwnH0BKUA-C8j4tkRJnwY-ZkP56OChg
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
> Add test for mtree_dup().

Please add a better description of what tests are included.

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  tools/testing/radix-tree/maple.c | 344 +++++++++++++++++++++++++++++++
>  1 file changed, 344 insertions(+)
> 
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index e5da1cad70ba..38455916331e 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c

Why not lib/test_maple_tree.c?

If they are included there then they will be built into the test module.
I try to include any tests that I can in the test module, within reason.


> @@ -35857,6 +35857,346 @@ static noinline void __init check_locky(struct maple_tree *mt)
>  	mt_clear_in_rcu(mt);
>  }
>  
> +/*
> + * Compare two nodes and return 0 if they are the same, non-zero otherwise.

The slots can be different, right?  That seems worth mentioning here.
It's also worth mentioning this is destructive.

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
> +static __init void mas_subtree_max_range(struct ma_state *mas)
> +{
> +	unsigned long limit = mas->max;
> +	MA_STATE(newmas, mas->tree, 0, 0);
> +	void *entry;
> +
> +	mas_for_each(mas, entry, limit) {
> +		if (mas->last - mas->index >=
> +		    newmas.last - newmas.index) {
> +			newmas = *mas;
> +		}
> +	}
> +
> +	*mas = newmas;
> +}
> +
> +/*
> + * build_full_tree() - Build a full tree.
> + * @mt: The tree to build.
> + * @flags: Use @flags to build the tree.
> + * @height: The height of the tree to build.
> + *
> + * Build a tree with full leaf nodes and internal nodes. Note that the height
> + * should not exceed 3, otherwise it will take a long time to build.
> + * Return: zero if the build is successful, non-zero if it fails.
> + */
> +static __init int build_full_tree(struct maple_tree *mt, unsigned int flags,
> +		int height)
> +{
> +	MA_STATE(mas, mt, 0, 0);
> +	unsigned long step;
> +	int ret = 0, cnt = 1;
> +	enum maple_type type;
> +
> +	mt_init_flags(mt, flags);
> +	mtree_insert_range(mt, 0, ULONG_MAX, xa_mk_value(5), GFP_KERNEL);
> +
> +	mtree_lock(mt);
> +
> +	while (1) {
> +		mas_set(&mas, 0);
> +		if (mt_height(mt) < height) {
> +			mas.max = ULONG_MAX;
> +			goto store;
> +		}
> +
> +		while (1) {
> +			mas_dfs_preorder(&mas);
> +			if (mas_is_none(&mas))
> +				goto unlock;
> +
> +			type = mte_node_type(mas.node);
> +			if (mas_data_end(&mas) + 1 < mt_slots[type]) {
> +				mas_set(&mas, mas.min);
> +				goto store;
> +			}
> +		}
> +store:
> +		mas_subtree_max_range(&mas);
> +		step = mas.last - mas.index;
> +		if (step < 1) {
> +			ret = -1;
> +			goto unlock;
> +		}
> +
> +		step /= 2;
> +		mas.last = mas.index + step;
> +		mas_store_gfp(&mas, xa_mk_value(5),
> +				GFP_KERNEL);
> +		++cnt;
> +	}
> +unlock:
> +	mtree_unlock(mt);
> +
> +	MT_BUG_ON(mt, mt_height(mt) != height);
> +	/* pr_info("height:%u number of elements:%d\n", mt_height(mt), cnt); */
> +	return ret;
> +}
> +
> +static noinline void __init check_mtree_dup(struct maple_tree *mt)
> +{
> +	DEFINE_MTREE(new);
> +	int i, j, ret, count = 0;
> +	unsigned int rand_seed = 17, rand;
> +
> +	/* store a value at [0, 0] */
> +	mt_init_flags(&tree, 0);
> +	mtree_store_range(&tree, 0, 0, xa_mk_value(0), GFP_KERNEL);
> +	ret = mtree_dup(&tree, &new, GFP_KERNEL);
> +	MT_BUG_ON(&new, ret);
> +	mt_validate(&new);
> +	if (compare_tree(&tree, &new))
> +		MT_BUG_ON(&new, 1);
> +
> +	mtree_destroy(&tree);
> +	mtree_destroy(&new);
> +
> +	/* The two trees have different attributes. */
> +	mt_init_flags(&tree, 0);
> +	mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
> +	ret = mtree_dup(&tree, &new, GFP_KERNEL);
> +	MT_BUG_ON(&new, ret != -EINVAL);
> +	mtree_destroy(&tree);
> +	mtree_destroy(&new);
> +
> +	/* The new tree is not empty */
> +	mt_init_flags(&tree, 0);
> +	mt_init_flags(&new, 0);
> +	mtree_store(&new, 5, xa_mk_value(5), GFP_KERNEL);
> +	ret = mtree_dup(&tree, &new, GFP_KERNEL);
> +	MT_BUG_ON(&new, ret != -EINVAL);
> +	mtree_destroy(&tree);
> +	mtree_destroy(&new);
> +
> +	/* Test for duplicating full trees. */
> +	for (i = 1; i <= 3; i++) {
> +		ret = build_full_tree(&tree, 0, i);
> +		MT_BUG_ON(&tree, ret);
> +		mt_init_flags(&new, 0);
> +
> +		ret = mtree_dup(&tree, &new, GFP_KERNEL);
> +		MT_BUG_ON(&new, ret);
> +		mt_validate(&new);
> +		if (compare_tree(&tree, &new))
> +			MT_BUG_ON(&new, 1);
> +
> +		mtree_destroy(&tree);
> +		mtree_destroy(&new);
> +	}
> +
> +	for (i = 1; i <= 3; i++) {
> +		ret = build_full_tree(&tree, MT_FLAGS_ALLOC_RANGE, i);
> +		MT_BUG_ON(&tree, ret);
> +		mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
> +
> +		ret = mtree_dup(&tree, &new, GFP_KERNEL);
> +		MT_BUG_ON(&new, ret);
> +		mt_validate(&new);
> +		if (compare_tree(&tree, &new))
> +			MT_BUG_ON(&new, 1);
> +
> +		mtree_destroy(&tree);
> +		mtree_destroy(&new);
> +	}
> +
> +	/* Test for normal duplicating. */
> +	for (i = 0; i < 1000; i += 3) {
> +		if (i & 1) {
> +			mt_init_flags(&tree, 0);
> +			mt_init_flags(&new, 0);
> +		} else {
> +			mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
> +			mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
> +		}
> +
> +		for (j = 0; j < i; j++) {
> +			mtree_store_range(&tree, j * 10, j * 10 + 5,
> +					  xa_mk_value(j), GFP_KERNEL);
> +		}
> +
> +		ret = mtree_dup(&tree, &new, GFP_KERNEL);
> +		MT_BUG_ON(&new, ret);
> +		mt_validate(&new);
> +		if (compare_tree(&tree, &new))
> +			MT_BUG_ON(&new, 1);
> +
> +		mtree_destroy(&tree);
> +		mtree_destroy(&new);
> +	}
> +
> +	/* Test memory allocation failed. */

It might be worth while having specific allocations fail.  At a leaf
node, intermediate nodes, first node come to mind.

> +	for (i = 0; i < 1000; i += 3) {
> +		if (i & 1) {
> +			mt_init_flags(&tree, 0);
> +			mt_init_flags(&new, 0);
> +		} else {
> +			mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
> +			mt_init_flags(&new, MT_FLAGS_ALLOC_RANGE);
> +		}
> +
> +		for (j = 0; j < i; j++) {
> +			mtree_store_range(&tree, j * 10, j * 10 + 5,
> +					  xa_mk_value(j), GFP_KERNEL);
> +		}
> +		/*
> +		 * The rand() library function is not used, so we can generate
> +		 * the same random numbers on any platform.
> +		 */
> +		rand_seed = rand_seed * 1103515245 + 12345;
> +		rand = rand_seed / 65536 % 128;
> +		mt_set_non_kernel(rand);
> +
> +		ret = mtree_dup(&tree, &new, GFP_NOWAIT);
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
> +	/* pr_info("mtree_dup() fail %d times\n", count); */
> +	BUG_ON(!count);
> +}
> +
>  extern void test_kmem_cache_bulk(void);
>  
>  void farmer_tests(void)
> @@ -35904,6 +36244,10 @@ void farmer_tests(void)
>  	check_null_expand(&tree);
>  	mtree_destroy(&tree);
>  
> +	mt_init_flags(&tree, 0);
> +	check_mtree_dup(&tree);
> +	mtree_destroy(&tree);
> +
>  	/* RCU testing */
>  	mt_init_flags(&tree, 0);
>  	check_erase_testset(&tree);
> -- 
> 2.20.1
> 
