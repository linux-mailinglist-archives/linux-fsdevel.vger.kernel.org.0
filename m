Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500006837C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 21:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjAaUqD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 15:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjAaUp5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:45:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373015A368;
        Tue, 31 Jan 2023 12:45:39 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VIiFd0004181;
        Tue, 31 Jan 2023 20:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=8abmFCX9fsDHs6ZUmXJ/CIHOX6oVmnIj95cf1CAIF1M=;
 b=JNh3BYDSgDwJf6X7z3ZngWJKLY8WM4l7F6iHFZCfrMQSjzpeIjO+anhgd+9WhW9EQ9Uh
 idAGYD9d/YKevwnMaxf8rdhIICBbpjMpgoCPBu71e11OaMNmM34L00MuS8CJG2jmT+oS
 mb40tS/sE/7Ww/odxYdjzTTC1xMndgMpqgpIq2Y5xCzok3815YIBRxk4NWTt/sxcWNfj
 4NhJkJ3ZxCFUdPqC+M4YrwRyDL+SqE0g9vXoBxpMGspJXJlpM7wMf8w9EkbNXj6kMmpy
 JVWQ3Lle+qk2nOlSoCDUdnBg0e/Rkxryycr/clAzzHGeprrYQiSNui6VJR95LNAEj3S6 eA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvmhpq2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 20:45:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VJbui7012959;
        Tue, 31 Jan 2023 20:45:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5d33gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 20:45:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsMaezNy4UbbrthfiPn5HTp6UbhPcZHBM5A76UC5ISfcfIxyaKLGIVZ8uiTeDXutazpanUP/Mrrwq5vHjP7MfglVIpLnpw005vShj79YdVcCSGfwEd9caoaHnBFNV6KGpU9fhPrxbM42XD0hHjUk46aJtINdWQfnICKLVuWY631h4a1gjUp7LErqKetbJRNaUzuz253Ih8fPUFyKYNYpfFLnh1zMj7mF5OH+gVxmsoNvbaW6L8050EKTMuakguVvgDVtnCzVyEVEIs6LBjiIgga1pQDuV8dFmS7IuwCZ5JWWUsF/J5j/5ZfG7ejWbU8RHkC9WNEcVaTr2RLu1L6wYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8abmFCX9fsDHs6ZUmXJ/CIHOX6oVmnIj95cf1CAIF1M=;
 b=Y2G8kSU57Zyxa4ZHb0DfEu+5K1Gg/k/KbA+vdqwRJOjuWWj4URQ61QJ4iwnNMPaSBNygDovkRJN4+ZXxJbEk7j1fdg/wIK2q2ZTuwQwY+K1WmavZaDY81jcLwaN3A/okPW1jVoo/lHRkF9CY4zh0oE18q2tlpqNy5bwIeIIckyQyZIQExYivpX2rz25QIfUZJe3JqKbfgSlycJFVBSQbCVb9qhmoQlMlChy6CtdvtHsAgEq536IpQSu6LXBb6jSBiem3tx7Z9TA6khF/GCXJ1clCWRvrG73qzIiU/dOgTiQ3zJJOLOOpwqjX7EeTkFzTi3YH/clwTfvPLbveNW14nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8abmFCX9fsDHs6ZUmXJ/CIHOX6oVmnIj95cf1CAIF1M=;
 b=y8j3tzLjaMi38VvLbrzWQnN6PTosA5H77wquJrQbGufkY135c5h2pYKhsW0O1sNIRErmTxZHhcDmiCkdLNSNWvFWxNkKf/pkVCf7JUlcfhbt/SjORZby84gqAW4t4azDy0c5KUad8rpUYsTGOeaM0n9CaPAqUdWk8wLspiOBMTQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6277.namprd10.prod.outlook.com (2603:10b6:8:b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.19; Tue, 31 Jan
 2023 20:45:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 20:45:24 +0000
Date:   Tue, 31 Jan 2023 15:45:20 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kernel test robot <yujie.liu@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [linus:master] [maple_tree] 120b116208:
 INFO:task_blocked_for_more_than#seconds
Message-ID: <20230131204520.ad6cf4lvtw5uf27s@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kernel test robot <yujie.liu@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <202301310940.4a37c7af-yujie.liu@intel.com>
 <20230131202635.GA3019407@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131202635.GA3019407@paulmck-ThinkPad-P17-Gen-1>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 848f0c51-3e77-4ffb-066d-08db03cc137b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Flej8yGqGNZR+8yqiVjXzG3aBzoXsFpGqjWfPqMN30tdxMFa8G4LR5Nsk64jydjufiHY0EfPJfv3Xy092E/0uHueXYe7zUZbbHjA1dhV3KbbzC63p20iqY+P9L4q9uXXYccvOM4ovK1zKSOiiL/fjyuWs8h2X7wwIpRSEp+K4cIg++Gq6ciqNl35eIm0JIg8cH7FJB3MVi4/RJUPfaWDN3VwP0BFE4spbrspVXV0To3AipdqvYOG56nHdmxTxH8iP+sAqHRoLTScKKsXfI6wC6xhGzFBur9pi6jDUpfJLFwVGKkQC90YVfbSztlUQSb5/3N+zzxD6UO2PST1KI+9Ts8Gd2/oojpGHEuVwHJ0ikwnkhS1UYGdb/lYvaOZFgLjh+XmNS2lyL+dExEmhlshV/T6YWjMzUmKboGFAiS0gb/NG3OiiwVZD3QLQY48XM7dix6pVMJAM/FLJDltzO1rsuO/wy2jfR5UJbCZB+AqUl3b2AMxO1s4pFkkvn6WoWv0Xn/7F46CGzB1o415ex7U+gzqrUzSc8QOmoMwc3v0lsYarD5IWUIhANthtnoM/7I4dK0dqVaVjIycpSvKG2e5o42r/8ZCgLZemIrTtCK+vuNPzEBi6cTP2etiZ1Z3cJ8mTRl8E8y3ZQIHjCeKA31NampZs5MPEZi54l7kp/25SvXNbRCiiA5xdCyUpgGNxN3oogM5jFQ37qeem9NP5Fqe2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199018)(54906003)(86362001)(38100700002)(33716001)(2906002)(9686003)(6506007)(1076003)(186003)(6486002)(478600001)(83380400001)(966005)(6512007)(26005)(41300700001)(6666004)(6916009)(8936002)(8676002)(66556008)(4326008)(66476007)(66899018)(66946007)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OWXQuJMLsj+TVsXj1VkuveD0C2CkDBPzxqTHO2wnaxfdWYq1YoCVWbHGkFFw?=
 =?us-ascii?Q?JgkqtRnCBbW5b40rXd+0teu4dyHah+tzqzUMf22bBdafLzSfiW0LHvK9iwym?=
 =?us-ascii?Q?8IDIWLDksWfz5Sbs5V8q7ZXmMgfKcQx8Vw8taWgLl5URheu9ouxMmyFrotK8?=
 =?us-ascii?Q?FbtdIzTpd0qm6IbonjhiRBaH0pZ07vd+VdGyUcN6tv6/masGKQK65g6T3B81?=
 =?us-ascii?Q?hyaOfNdW+UsK6rO+YfNyHOnFcjXKPEMNsuw6uiMunex7L/aCyOHquwqANkIS?=
 =?us-ascii?Q?E8c5PIW5K3Uf8Dp+YRZ9pa50Ab7UQuSDuVLwNUzlszbuOeQmg1I3yvo4NgeM?=
 =?us-ascii?Q?Tjt9/w5o7ZqNT8DpiviH6LMXys95eNPVSH1/Ap2ef815DPTM7Noi6PjYqJ+Q?=
 =?us-ascii?Q?AXFGYZdedrcQOdnnI8Qq9bjjJhJ9oclyHm0s3JKTPJLjVL0M2S9T8FtZHXTC?=
 =?us-ascii?Q?6DohuBTI9uhZx8oURRqT9MKv7VJHSDs9OIUpDQhd5baVobozvCJ82gPQiMX5?=
 =?us-ascii?Q?iVj22ztIFH0VgPLvM6mO4L/V3ClGEv7mB9mcOkZ9YTVqhvqppay/YpdFM7kf?=
 =?us-ascii?Q?Vj0cxou2LLUAlwHigPJ3+6gBd6s7D0NBrvu5yxoIgNIh1b2RQi/Q+kzN0ovd?=
 =?us-ascii?Q?FT91agg+4ISzZd6Vv30giE43Vef+LWSI3VwSChqyfnU8O9r9cgTeyhbH/wer?=
 =?us-ascii?Q?T2SwqRgw6rIO4yWeyXoUiernnyYKbKLZzMW+L1vMgMxlysRsLwUx6IonnqWX?=
 =?us-ascii?Q?RznqGT3PAIeEYlTXSpXql5+P5e2AaHAt+duZoLoHrhHhDjxeMH3h9Av2CMu8?=
 =?us-ascii?Q?NM+fmDxDr8iQbdP5j7PfcoU1EdnK0uvxq04RF7uib6k+A1hesWDizJOn3N2e?=
 =?us-ascii?Q?kUzAV/KQuVm4kmE0KYo/MvJxc72rd432uVXuyx3/nZKN37USNiKr9Jvk7RBV?=
 =?us-ascii?Q?Voj00iJE6ejEWbbq+V7Bt34ywc1GK8pfSIRMlgPO+jVNc7t0pP3QpYvMED0R?=
 =?us-ascii?Q?nt9MsqQOeNHIxRNDao2d5jA9HwkANlQJ8G2Gsb7Y29Q1KWqPgxMfepdl8S9P?=
 =?us-ascii?Q?rOCudGGbWMYHMjp0YCIQFDk7Ez+NrK2MkXAgn9Fh9JW0p7gx04pojpr2NcfM?=
 =?us-ascii?Q?ppkc+i6/DHjnnt8K8UedAym+ka6TUIq4fb44A8RlGYCvTLIvN/aP/BpYZ1K+?=
 =?us-ascii?Q?0fQxhK5Ea1rPyPfTM0qHfoMTK2t7pTBM2SYACEUi0y56boGsIbbQl02Ue8OU?=
 =?us-ascii?Q?OqalzMPUE4qPz7gHeZWxFUy+iJ1A4lkuvhN/39LNOYZu6lIERHzYSATiAkl4?=
 =?us-ascii?Q?j/7R0PFrF6Rnyh5VtC0TcvgWMaDHS2uEUD6HoS+pg6ZQM8XGG/77T4zY3A3O?=
 =?us-ascii?Q?Fc2lv7a1V0ccrs4noajcVluPypLYoR1J0OFEuuc+8eJMbtmbi+wNUGoMnzg+?=
 =?us-ascii?Q?CP3IN48TF0KkdkqWkfqq2OrnNuWIEw77XKRkDii7iDFt/3QlHWGozJY8J6kX?=
 =?us-ascii?Q?xT/dMWt805DK+oqukJ4Gri18kmNAwBFRaYCz3L6Ho0dT4vx7aqhRF7/fPOEO?=
 =?us-ascii?Q?SdTthLudv92kt1I1L9wKzMhdpNHbtJaatOabAhTwqLM0ZjEqkvqv7jYOVIb4?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?904ESV93hqXGZ+RxcFiBWFONgjFcpgprWAc1/p0IAljce0ZgPVxCKwRjLyLy?=
 =?us-ascii?Q?DPSIuM2/LZd6S3i25CmtCFy6epasWvKHwCFv1xRf0gf27zXgY3X1k8gDYXcz?=
 =?us-ascii?Q?SAbkk4Xigo9RtecM1ZGoqmKsk4ItbZSMVvTJ/LI0OKRyldTKw2Yo+c3SyXCQ?=
 =?us-ascii?Q?5AyNKQT45Fj6K6ixTD3q/UGT9QxwnSM69Lxb1cTBcI47LdTVwRZl9ZpI7UZx?=
 =?us-ascii?Q?IgzhDc8jeLq9ezNactd8hVmf+EhLwsKM8+wkIRW2nJrHA6dnshT8jZB/r1hD?=
 =?us-ascii?Q?1EcHaShedNLJOfIy602a8Bmp7RnpGCXLoy3HSJYs7NXIN7KOjWQA6mtBHvLM?=
 =?us-ascii?Q?fpSzQRZPGcoG4EocMHv6wlKUI/EN8WUeFEjQ3J2feU4slkEZOynS8KngAEdg?=
 =?us-ascii?Q?R2EMpQd/1OX/OmwUhDIo8TNdDTbWkweumw1Adh3CMK2xscuepErgmz6yDqdK?=
 =?us-ascii?Q?vo/mLoFtZjfwvChl0e8lYpNy/or9LNlgaFPUt/ntuvujMNlQ+C/Uvy3E/C7J?=
 =?us-ascii?Q?D957oRbgwJxzdN/jUgIrFI6jT4qL4PEi4lL41HiUjKESx76Yb8Uf4DKnTJez?=
 =?us-ascii?Q?kEXAa4Q61Z5jj6OmTlBiH7ND06OjCy0iswwdLs8bEX/KUTtvGi/+3DOSb7Am?=
 =?us-ascii?Q?YOa4cADXfoopGfYpbCM4/dpZCboAkQmjXkdaT21iXcE366mjxeUH47itqomQ?=
 =?us-ascii?Q?oVoWw0KJrXlGLIQtoeFW4g8IVMcBZKpvotwknm/mG0jArr3rC0vL6VNUBh+E?=
 =?us-ascii?Q?WJ/q7TdmEAAbQfgVUfOGhkhOFJA2pXOs6qZ/1lZzmxoX5tYUPl4zKo1mlvBE?=
 =?us-ascii?Q?Sy3fvXpAlLvb0fpIbwNlXRxSIdIHzakHwI8abQz7wWxnIMjIhlFrTgBAI+Zw?=
 =?us-ascii?Q?g4JNmQF8S3FBPHha+GICGI9XYo7phRS++2YyjyO9tU40VmIzOVwJvv7ZToO+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 848f0c51-3e77-4ffb-066d-08db03cc137b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 20:45:24.0598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qqva30nawSKJMdmkhrjEDCPYF1FVbxZ8hH5AP8KdIR2pKGzKTnmuq2XbI5zPXrLzOlgR/KNIURj4eMNs7A2NHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310180
X-Proofpoint-ORIG-GUID: piSJKSYOZ0v8it2GCqEQKoJOR4iPhu_G
X-Proofpoint-GUID: piSJKSYOZ0v8it2GCqEQKoJOR4iPhu_G
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Paul E. McKenney <paulmck@kernel.org> [230131 15:26]:
> On Tue, Jan 31, 2023 at 03:18:22PM +0800, kernel test robot wrote:
> > Hi Liam,
> > 
> > We caught a "task blocked" dmesg in maple tree test. Not sure if this
> > is expected for maple tree test, so we are sending this report for
> > your information. Thanks.
> > 
> > Greeting,
> > 
> > FYI, we noticed INFO:task_blocked_for_more_than#seconds due to commit (built with clang-14):
> > 
> > commit: 120b116208a0877227fc82e3f0df81e7a3ed4ab1 ("maple_tree: reorganize testing to restore module testing")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > in testcase: boot
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > [   17.318428][    T1] calling  maple_tree_seed+0x0/0x15d0 @ 1
> > [   17.319219][    T1] 
> > [   17.319219][    T1] TEST STARTING
> > [   17.319219][    T1] 
> > [  999.249871][   T23] INFO: task rcu_scale_shutd:59 blocked for more than 491 seconds.
> > [  999.253363][   T23]       Not tainted 6.1.0-rc4-00003-g120b116208a0 #1
> > [  999.254249][   T23] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [  999.255390][   T23] task:rcu_scale_shutd state:D stack:30968 pid:59    ppid:2      flags:0x00004000
> > [  999.256934][   T23] Call Trace:
> > [  999.257418][   T23]  <TASK>
> > [  999.257900][   T23]  __schedule+0x169b/0x1f90
> > [  999.261677][   T23]  schedule+0x151/0x300
> > [  999.262281][   T23]  ? compute_real+0xe0/0xe0
> > [  999.263364][   T23]  rcu_scale_shutdown+0xdd/0x130
> > [  999.264093][   T23]  ? wake_bit_function+0x2c0/0x2c0
> > [  999.268985][   T23]  kthread+0x309/0x3a0
> > [  999.269958][   T23]  ? compute_real+0xe0/0xe0
> > [  999.270552][   T23]  ? kthread_unuse_mm+0x200/0x200
> > [  999.271281][   T23]  ret_from_fork+0x1f/0x30
> > [  999.272385][   T23]  </TASK>
> > [  999.272865][   T23] 
> > [  999.272865][   T23] Showing all locks held in the system:
> > [  999.273988][   T23] 2 locks held by swapper/0/1:
> > [  999.274684][   T23] 1 lock held by khungtaskd/23:
> > [  999.275400][   T23]  #0: ffffffff88346e00 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x8/0x30
> > [  999.277171][   T23] 
> > [  999.277525][   T23] =============================================
> > [  999.277525][   T23] 
> > [ 1049.050884][    T1] maple_tree: 12610686 of 12610686 tests passed
> > 
> > 
> > If you fix the issue, kindly add following tag
> > | Reported-by: kernel test robot <yujie.liu@intel.com>
> > | Link: https://lore.kernel.org/oe-lkp/202301310940.4a37c7af-yujie.liu@intel.com
> 
> Liam brought this to my attention on IRC, and it looks like the root
> cause is that the rcuscale code does not deal gracefully with grace
> periods that are in much excess of a second in duration.
> 
> Now, it might well be worth looking into why the grace periods were taking
> that long, but if you were running Maple Tree stress tests concurrently
> with rcuscale, this might well be expected behavior.
> 

This could be simply cpu starvation causing no foward progress in your
tests with the number of concurrent running tests and "-smp 2".

It's also worth noting that building in the rcu test module makes the
machine turn off once the test is complete.  This can be seen in your
console message:
[   13.254240][    T1] rcu-scale:--- Start of test: nreaders=2 nwriters=2 verbose=1 shutdown=1

so your machine may not have finished running through the array of tests
you have specified to build in - which is a lot.  I'm not sure if this
is the best approach considering the load that produces on the system
and how difficult it is (was) to figure out which test is causing a
stall, or other issue.

...

Thanks,
Liam
