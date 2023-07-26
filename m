Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71E4763BFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 18:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjGZQJW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 12:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjGZQJV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:09:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9A319A1;
        Wed, 26 Jul 2023 09:09:20 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q8Eocu017652;
        Wed, 26 Jul 2023 16:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=D9fo13T6cmvZU4kwCqkmIGf/xzs5cc7MW2cvhhmSzoU=;
 b=XeeHTKgl4LCBVPl1xOMoZpcSPLWxWslGnQ09DED2/V8nIVTVFLq7WqvQXxuQam2W73tP
 Jf0YwebEy4oM+ByoFtnWr2H49Q8VduHBcIeQZUwugYOLlgkTsja5S9Kr1mvf2fLeOJw7
 u7FNO6I+X9ROKQ2QxCbIukVi0xjuMSOmPz4NaRQDfIG5EIZbw6ovYuXaJypk52gy747J
 yybtjsWCss4/jg1IclLU6RqfKJvmD/oLAmDxwfCHHl5qA2/mwt2g+Pq9X4W6d36YZYKD
 EHgHasNAceMe7AH5cCUVy/AUQHWiVtRi0KPlPlwulXgT7lx2do7k//mE1bsubJi0q4Jb oA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s061c7waf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 16:08:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36QFZW4Z025271;
        Wed, 26 Jul 2023 16:08:49 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j6wqhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 16:08:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMrthq8f/L2tJcntLmIKcM821Nn+2wcbsOSMF4wRB5HCL5h5GXfL+rDFrhP8WfDirbnyMu9SbWJVmWhm455DKlQIKz6Nz1IUS7YjwHC52TiFNHlIxhq91FRypyUcJhyTCwBQwt9tXB1DzMeW3F83Cob5Zyx6PmtgWzMJzSgWd3633/S0djB7M1wFGf/BngvSi5gBDuadGuByeLJ7zPRBrKdPietJ+j3Y3h1QdYzUY1DdyPp20vG5BaxEwClBHC7s0+VypfLiVsrGoZO+A4XCflUYavy3fU4x7RidTGLMjycKf7NxLsI3GAw1pyJOA+v0337LEmJPKY0U2iHnQF0ANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9fo13T6cmvZU4kwCqkmIGf/xzs5cc7MW2cvhhmSzoU=;
 b=FCBYWp7BBFnqHlQFWfPQxS+M2J5HY6dwTTV2Kj4ZaE4L9lO+KJRvPozB4sJ0YsYdcN01BCYuXpKphqF2XnnOGfM9dzoutRTBj2tAFk1CtpfyMhIoAz8C4Hmz0HxnmQnrCYx+OgyvMOfBWcl5N1nvNLa0uBlyHL7hZs7BFto8mnWpoFJC7q+8sCyf2wysz3UZ9NwP0VtV73xyTh7DrLfvy+A2wv+NuaJbiHgxCqUEEexjWmwEnPi8RreYnUk4r3M0m0AAAHc4XIrfsyRu7cns75dvTuj9qvPsXD3Vnq+6aZ0LWQtCz7c3WuG6RW8wMtuzu/Tp9ut3UgQlr823M3moGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9fo13T6cmvZU4kwCqkmIGf/xzs5cc7MW2cvhhmSzoU=;
 b=c5SC24TAedAeufx5o5p6qrHFOR9A90ZeW0yKiU3ACl53fTsGMQw06VbiyF/7nMUJKmAgcnayzqQ172XoQFc9tBDKtP/Elf+dalqwWRNwkROzj+Sun4Gcgzf8DosGSqUEejLhDEoELRP9EBue70F9erkaqWhbcVOeDNsDzt9K8s8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB5900.namprd10.prod.outlook.com (2603:10b6:208:3d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 16:08:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 16:08:46 +0000
Date:   Wed, 26 Jul 2023 12:08:43 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/11] maple_tree: Introduce mas_replace_entry() to
 directly replace an entry
Message-ID: <20230726160843.hpl4razxiikqbuxy@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-7-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726080916.17454-7-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::19) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a2f4f6-7604-4e36-320e-08db8df29765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cVHYnibFFZR0B7XpRsfPHbu/i4Hn8I+zLHEF6Dp1JqFgkRVnlgvmym9tQJHJ6BGzZ+GmSZbkh6GssipW2/UvJ1Y19rlTPxSdzxpC/AlZZJ5rst31hPfvVwOChGR7SMvN6JrxEviPDN55P2hgsMfqc+tGq9oWY54hTxc9q30mEBGFofurBp/+Bm0lwbPGHTkX+udzeHa1ccVUst/wh5p1XHQxgsqK7MKXbkPlfrwoFKQByePeaz5zdK7wjYGVZcAsA++Mt+VeT/ym9MXTmSHmmWvTycN13csxq9yzmBdWKX73B4gtmGNcABNV6mk78OSAoGcgxTfDQRLP/c1bXweeKpVsXGD693b93kfFdJztb+h7swbbbusbi88H+SyDVx7u7MISX3u1EZFEgpCFOyjz7oYKYg8wRNYo1jbH/iw1+qLdDH1SeV1pX+Z+jRRmHBQX9tM3rVlo+ZozupJDAoHyBfq4IiY9Q2KC6cq64pgu0N2wrYvn0wOE17x6Su2mdOheq3nfO6mIWwpv5B/JegMkilU3NHjwowilGVkrcmO+dbkYlYWxZurGpyjnDo1Uo6oA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(86362001)(33716001)(2906002)(478600001)(38100700002)(186003)(1076003)(26005)(6506007)(5660300002)(41300700001)(9686003)(6666004)(6512007)(7416002)(6486002)(66476007)(66556008)(316002)(66946007)(8676002)(4326008)(6916009)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sQjUkWuGxcInrgjpIWpUOfQTxtd42OL6IvS0d07ANIOsd31Z0ou+9cIsC2Dl?=
 =?us-ascii?Q?0WkVzWWsb/sLBCxeIliKtblvtqNL/93El9U8tbUXhIT/javCRQqA17us6+Wl?=
 =?us-ascii?Q?fpilVha0xnV9jnMPuyrq0BHR2I3sX+CvGKNdNVpYzStdcoG/Xs+JdfW1NstH?=
 =?us-ascii?Q?TnspEua5YXeXIpw02vrtS0J9Z4EoJ7Tz53m3lZU0mWor/K3zVGr3Gnoba34B?=
 =?us-ascii?Q?FXpbolllVmdslRDutW1LSCdhlyqNCc1c/g93jvNgJ4dX7vIOa49qWYKUSZa1?=
 =?us-ascii?Q?W2fDm8UhJRoVtakTaMVglkcU0BQrc1Ej8PL3Bmcoo5dEcNQemncVGVWlg0tm?=
 =?us-ascii?Q?G6PiJrKdgOzydD82faFEeDp5KDCo++aFfGWflbARIUMxAKq2n7GeWwSWG0P5?=
 =?us-ascii?Q?Dud+P3HzFH1XbG3Vz7896qASMOb62b6KCQm94HrCQTJUT7SOFMS4LkASdqVU?=
 =?us-ascii?Q?tjRxyJkUZR9YL/VHOTvGsBqExjrjwFVGWybZkm2gW317KPalhCz+sDfeWG6k?=
 =?us-ascii?Q?IRRDuiL9TCYY/oat01kiUgX2bcsQsByAJjbkF4PhqjbHgwOKIMC3cvMOxEXD?=
 =?us-ascii?Q?vayjPuw5BnYaOQbuIFzmWxl6Y4Tirzm3WY9+rOiaZcTUwbW7+oaGoRwu1pPk?=
 =?us-ascii?Q?ynu4jHNf+9vg4cEMmLLYtvEkZL2QLTcFQZa1SzmE/smLG8iQVIJLppgH3+u3?=
 =?us-ascii?Q?hckq8eIaPyPkSgIzyJYATXPtilE4yD2zKwq9Z4U8jLs5nh0ZNbCFBTL3sl/I?=
 =?us-ascii?Q?pRxraKHNgBKbq2tLFpiCCXb0hxB+2G4ueWSK3sGUqVOiCETR+rPxLr/AceyX?=
 =?us-ascii?Q?RWCohsB8nApsHpUVZpdHjFufk2VFe1PuJp6xc8FfeY0BLCFhJ3KL8aFKyLwT?=
 =?us-ascii?Q?gJZzOqFt7BxeJwhywO2unnKzMeqApiWhda1BZc9G8apLvnLkAAvxdV0TiCSq?=
 =?us-ascii?Q?2lE+47728uxxByeMMEvZq9PZ4ozJjqF2GLKJtVsSwAKKf63LNZjNSxRMIyd7?=
 =?us-ascii?Q?5Ck4wahmT0BH0IXizEJ8ekonptr0njln2JeIvcp0LfGHx7LCOF/4CWFAGLIk?=
 =?us-ascii?Q?fpB/CUl8JYkyqfhA3EHX+vRMvqxZqJDeT8996yrHc3YJ7iT4nrHSjCnesI4P?=
 =?us-ascii?Q?9VM6LIxAxX1Fb0zy6z0OtKP5UEcbh3FSUaKtYXOO6zVcwR8yxm3yF7LrCOQz?=
 =?us-ascii?Q?N7l5MgOLyJeygAAMNh7tWTPsTrZxG7ZBv2Hqxfi5IIKpUwLStrUXKXhqfM5c?=
 =?us-ascii?Q?79SY4PxQgWAGAzbWNYi+x8gHwmw7l80s9cEZS29Hr2RAfNK1Gjy738jHo8jw?=
 =?us-ascii?Q?igHTIDwjsjrem8iIMYsAur5yPaR2U3f60JwrKQEStjt/G+UhRubweDf4ghhk?=
 =?us-ascii?Q?x5AWMNCOkyvMDnuvwOl5KKDBKYxNt7mIxnDqDEiCymAlvX5aCIQWPO+KuvNX?=
 =?us-ascii?Q?kg8E82kINPntm91qgsdAm44FEpdvouAE78UEgcS83xc7A0lbHTZ3eXmAbVwQ?=
 =?us-ascii?Q?HmCMEMUqfSK1FiuSO515KGDuxO6a59Sg8Ycco+1/sFf2RkmpdubTrZogxhRP?=
 =?us-ascii?Q?gM0qrX6VtFGKPbkDCeeMyEB8j3AsuOu77utcgH4dJ83ne1tsc3UgAh3BiLK2?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?wNr8JQPV83M6w/Z+LEm1uzocwyHHNGZgj3HcZszKTHodC4oqYQjS2Tbb2lq0?=
 =?us-ascii?Q?NMX7uLgOgWTijUO7dycOYy4s3r5sVqAPfo8gJFcaKgwG0ZEPhjVjjnCdR3Wu?=
 =?us-ascii?Q?oacMaP6KwZVQPlWyaKBJ905g7BLONpfxcogMYPAtcJfchGKW8eDV205XolmF?=
 =?us-ascii?Q?duibWdEXk2y8k+AGhiQGFJ1YL3LoZBqeyp+Xx494euyfCGF3EoTWRlo6R48u?=
 =?us-ascii?Q?7RZOYcuR2BCzqymDocEyVM3P0PbNNyplQSdFGJrPAQEjPSnlGJoI2DkHoqk2?=
 =?us-ascii?Q?Bccx6b0fhjdt8nBqbc0CzWTGgwM1oHp4hxsy8RWEeQJWO5HG8nmb6+4gbMQ7?=
 =?us-ascii?Q?sRzv4ha73FmCBYpu6JUptVo7RWKG7Aj06TY/ActxWnbCZhih+rzXNmqEhO/B?=
 =?us-ascii?Q?F6fKXe/Ma8W2AhtC/9ozp9m9ONwU1z9ZG+gKC53jsxtQkN0whIpxRqzeqIf6?=
 =?us-ascii?Q?hvRCtEb4QTQuInUMdbbZJ3rH9Cw/EGUhaip/tMRDNnR51ocus6WZD4eGzszH?=
 =?us-ascii?Q?GDp0b78BSGAcvYNkDCMTyYL0t0bzzvXyyt6wJ6bbz4tpWwE+1hXfoGIfIBiu?=
 =?us-ascii?Q?yTOYTILWfvkWxyonrfw++f94M/GKoFEI7zFw0+RFDl5sqnkscJRVFiJKEcy7?=
 =?us-ascii?Q?RN/dJzH0nyLw2NjG25M9DPcB2zkVHyykjYg0GLmdVzPL/r1z1SI1qugeitRQ?=
 =?us-ascii?Q?0HDqknONWFa23JhX/EqiJhkR1aD+SEuxRE8QPb2h/Yed1z+yV9Qkc0yoHuv/?=
 =?us-ascii?Q?hntmNIMMRi8VscBJjM79u9/uSrGmVGhD8kuxw7h843NCylA/nZFCOv7FmWIE?=
 =?us-ascii?Q?FoS/LsIlFJzBcmPUpfwuXxqGxMYlYyMJ1YKvn/udXsBgsxjBiF0A2LeIv5BK?=
 =?us-ascii?Q?LqvwVj6gLRqXY1vFGqq3z1CAZ+ySxckcvx/tMoG2fSvJT6A/tPcv8lQXstfG?=
 =?us-ascii?Q?uZntF8m01pmqPXP8Iz3g34cOuZOmg20NeALKEGpSHX7lja967ZJdRz+w03kp?=
 =?us-ascii?Q?3OBciVPXibM4oSopX0j3gjXgyJaGYo21oyPyQks5oBGqj3Dqt7jBArts7n0+?=
 =?us-ascii?Q?Y3LPktd4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a2f4f6-7604-4e36-320e-08db8df29765
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 16:08:46.5855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uZBko8yxiQ23jSpbzzxWEAODIANPF4AbwApcZSBGEx+LbQ+8yv0I1MKD0HPqJ9ryTo6B1gtqBrmh5fCq9s9sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260143
X-Proofpoint-ORIG-GUID: piPfFQ2OCopH0idlrL4NwBy0qBU9d40x
X-Proofpoint-GUID: piPfFQ2OCopH0idlrL4NwBy0qBU9d40x
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
> If mas has located a specific entry, it may be need to replace this
> entry, so introduce mas_replace_entry() to do this. mas_replace_entry()
> will be more efficient than mas_store*() because it doesn't do many
> unnecessary checks.
> 
> This function should be inline, but more functions need to be moved to
> the header file, so I didn't do it for the time being.

I am really nervous having no checks here.  I get that this could be
used for duplicating the tree more efficiently, but having a function
that just swaps a value in is very dangerous - especially since it is
decoupled from the tree duplication code.

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  include/linux/maple_tree.h |  1 +
>  lib/maple_tree.c           | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index 229fe78e4c89..a05e9827d761 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -462,6 +462,7 @@ struct ma_wr_state {
>  
>  void *mas_walk(struct ma_state *mas);
>  void *mas_store(struct ma_state *mas, void *entry);
> +void mas_replace_entry(struct ma_state *mas, void *entry);
>  void *mas_erase(struct ma_state *mas);
>  int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp);
>  void mas_store_prealloc(struct ma_state *mas, void *entry);
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index efac6761ae37..d58572666a00 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5600,6 +5600,31 @@ void *mas_store(struct ma_state *mas, void *entry)
>  }
>  EXPORT_SYMBOL_GPL(mas_store);
>  
> +/**
> + * mas_replace_entry() - Replace an entry that already exists in the maple tree
> + * @mas: The maple state
> + * @entry: The entry to store
> + *
> + * Please note that mas must already locate an existing entry, and the new entry
> + * must not be NULL. If these two points cannot be guaranteed, please use
> + * mas_store*() instead, otherwise it will cause an internal error in the maple
> + * tree. This function does not need to allocate memory, so it must succeed.
> + */
> +void mas_replace_entry(struct ma_state *mas, void *entry)
> +{
> +	void __rcu **slots;
> +
> +#ifdef CONFIG_DEBUG_MAPLE_TREE
> +	MAS_WARN_ON(mas, !mte_is_leaf(mas->node));
> +	MAS_WARN_ON(mas, !entry);
> +	MAS_WARN_ON(mas, mas->offset >= mt_slots[mte_node_type(mas->node)]);
> +#endif
> +
> +	slots = ma_slots(mte_to_node(mas->node), mte_node_type(mas->node));
> +	rcu_assign_pointer(slots[mas->offset], entry);
> +}
> +EXPORT_SYMBOL_GPL(mas_replace_entry);
> +
>  /**
>   * mas_store_gfp() - Store a value into the tree.
>   * @mas: The maple state
> -- 
> 2.20.1
> 
