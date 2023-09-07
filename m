Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEC2797D46
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 22:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbjIGUPv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 16:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjIGUPv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:15:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C238B1BE4;
        Thu,  7 Sep 2023 13:15:17 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387KEDWd006022;
        Thu, 7 Sep 2023 20:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=tFm0LB4SrCCvm3Yup44YLd/tRuDZ5SMnKgTOLmHYssE=;
 b=DVsB45U5XzI33GrOjNG6Orv7TFqiFr8VEDIWfzoKEB8moLHMfyw/6PUUSBxMjLA1yUaT
 K8R3nzDe8cAWLB9MqtgO5f2avRFH5xyusdSQByM+wyH/Xz77MoazotODsiSbFgdFvb37
 /FMWtVy1zeCfPul9tpz9WopUvIVONn9iRWL3KK63RAvGe9nMZ55iUdVTCVP9YK8iWlex
 WWVWGlV6vHXIH2TFv/jIKYM7QT7C55VYOTKPy2LJQBvv+1hMO/YOqAatycvtbUPGTooU
 DCeTMRHvRq3Bgshue57oKEd3pcWNi6uXdXLHonplZg9Hl6Mb/nHO/8EZfrZwvkbeB8mR qA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3syn3c01cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 20:14:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 387J85XV009378;
        Thu, 7 Sep 2023 20:14:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3syfy0e6q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 20:14:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhNwl3D2uAeLoJWemehOgL8vOTmu68hpNkHxbSetw/QtqrdbnFu7Uj4XARQowM2Gf4h5MNJKPPvoT1TEU+Cf8MvIMXPsqBXkSjpneFDC4mxA8LYNtmyNWxuqs+fcQgeiUuIM0LueBpBzfooxV4IOtX24Ca0vmdLSXMqMMVV7ylCgQrHlalCCMYGr3Qk6VWP0dxU00Rvoa47YUroLEGikonIBZCN1iI7OoXOw12Yaa1LhulKxjtLK2Bx5DXbbd9VgiOjPGrg8LTpiDHYRWmKov0hbleYx9tIwequJUH33dU7Uwwz7YM/3bspv1Aa7p/qqOtmImLTNqnHGXwCId0sBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFm0LB4SrCCvm3Yup44YLd/tRuDZ5SMnKgTOLmHYssE=;
 b=YfXqRzkHsocNxJPlmVJRUpAciCJei6BvBkj3w80KDi18LN7yIodxUFedkHVbHtxjISoj7/GdXTFdCNNBwzorB9uxpm0n0TJr08SR4RtvwdhQ2mLcAkSiv+ALX7ehHi2S55kCDQJntEGeR0n8Im/IT+0NS4g9zMERwcKbSKzxcuxxGbbxbHL3Td46Eusbf3tKc8ZtW1ytBTUTCC5jGVlXgKFUG1fYKv4LXlH52vUNc2RiAYZOQjC7JqCohg/OBra45GShcHu7LVTaYNL6kX9YhM5FK4bjRCeoe8jv7u81cAVF/GeL3Dmpc8EbVXeQQMyfBk27gny8luauPdNAHANaFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFm0LB4SrCCvm3Yup44YLd/tRuDZ5SMnKgTOLmHYssE=;
 b=hi04ozdZRn1FnIQnPnIqSvMVZuyIk4QbqXtncn4qw2ZSTJ+YwzkOyxesgx1m3IgiBDNoxs+GKnkW1s5Dj8R2235lV0GqZJWliq6kB05luVl5mCksGSLJM4jxpEnM6ano5TeZygm1IuOxhBybzQthwQWvZFukjgefpHdVwjG6kU8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB7045.namprd10.prod.outlook.com (2603:10b6:806:342::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 20:14:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.029; Thu, 7 Sep 2023
 20:14:05 +0000
Date:   Thu, 7 Sep 2023 16:14:02 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] maple_tree: Update check_forking() and
 bench_forking()
Message-ID: <20230907201402.znapmmzbdh4wpsg5@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
 <20230830125654.21257-6-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830125654.21257-6-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0036.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 251eb84b-f6a9-44e0-d74f-08dbafdefc75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLUvLEQfZt4gwXLRDP+9FGTUBz2P+eZ7YFnMHwzX/9CnirbeuY1bD0bW56BHP9dwHN45bOetJd7ex4xFCwzPYhhOmPYshICNGU5PO7pOlnduCbMq854PiBFqo/ek3szITz2j1Y5H9edmpZj60WSFWbEcoqBOo3vqVOb69mtK9FMV4aGYCb/8iUIG/WhETzsV12Oh5rmHvBTfL4WMidNMuuyA2pvLKETylCRJtv22kC9vIwX8k5VPwfjuUhU3d2kedbQvgaQIiI9CSho44Z8s7FRv2O3C4PNr11anwm5FScbWtBf+Dv41/blVBiDYdJtWzM2omqS/2p1tMyBAS5qgg7d78gVtodkEpiWv57pKCTcE0hE+2iQgIl/cNJGHvqslHQbg1TrJcGiaFFDFjXYy5PShCeNV8KrQq5nqV7q85OyRzLVxli5WF1SlOC4N7rlYYj01p33yzf96amPp3aJqs56DWztBiV7m3x0DtRHpGgdMt+6BdMWazOg7bcXeI+bFha+2ttnOlmJrBFQEaEU70+8WViVM922SQAgvRjJYUr5bQmqNjf/LpTqfSWXW4uzD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(136003)(366004)(39860400002)(376002)(1800799009)(186009)(451199024)(33716001)(2906002)(15650500001)(5660300002)(41300700001)(86362001)(7416002)(38100700002)(8676002)(8936002)(83380400001)(4326008)(26005)(1076003)(9686003)(6506007)(6512007)(316002)(6486002)(66476007)(6666004)(478600001)(66946007)(6916009)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y8cKmFrosgWSry/18i2gRCDR9k7bsk3qxn9/kYkqUP1w3WB6TxhFS9idSj/z?=
 =?us-ascii?Q?8Ix55d7DUM57T9kyDeGaG1puGUgs5i/8cKIMy8j2saDmf855ngWL7hX6rSjn?=
 =?us-ascii?Q?kFaXwaXC2simTT4OohCETJoWxoCgMK/B0XtWYyvX6nhr2cgoKmXLnIjZos8m?=
 =?us-ascii?Q?t6/QqIr0P53xIQR63sZQ96WgiVrxY0JlKV+Zly1SnllXUw/HPFBgHPLPMVXq?=
 =?us-ascii?Q?l3fg2wwR5y6CCEt+NuD7sSRi2Hjr0B10lKklKipHRFCTThggbO0PY+E9bJpC?=
 =?us-ascii?Q?JaIVX3oZd9vlNl9YdGDStRKn39XuJfiyfoPi84gUKIL/utXg8hY9IF6fBci4?=
 =?us-ascii?Q?3JJgg8BUyGuezUnvBj5t+9yNfM/mMLLikHOQ6P3pmht5gxbnAzZxZsjhjQ5m?=
 =?us-ascii?Q?HVFcUy3tgduYMKVAveBIeTOJApBdgjOtHnqWy+USORTWGsR1hcE8Y3p1uSI8?=
 =?us-ascii?Q?jrplmlmz0m1Y3kG/Z5//HyFiYUp8kanDOd4qG/0j/BOlTw5J0TKuvblmbMp/?=
 =?us-ascii?Q?R8sFEBqrqfbpxTIXPOpecbFQ0v0aJw2Ro5ELFWe996P3erPGJIBwV/uuS3wv?=
 =?us-ascii?Q?YSXpteJ/7EBZIedi1tlQeYOnu/bbc5nGwfDkDVUZv9SQM0Y2iOxSzblH3IMz?=
 =?us-ascii?Q?2/hEfcEUZJU/YOXfNUlB3imeqzJt1uJFqEBBa65zZ9ZUL+vjt+rg+/1us9mB?=
 =?us-ascii?Q?nQSnp7HKIG/oSsGu9oxJ19j2PtOS68xyFb5oHwYTCPWi4rQi0ci/QnkdjTp/?=
 =?us-ascii?Q?8gTp4j94gW9gykZFnKvcKWwHCrq58V0IlalioRaw2dLy6MGp55Zp/VbYd8dq?=
 =?us-ascii?Q?HHtVTdG8H9zkZNN3wLkILNfa1RxZbenkG1qmbtIG2yMBDEDmZqaPbwpFFIAr?=
 =?us-ascii?Q?u4Ka+DGNu92YnJw191oyG8bJT8wdeHuCBGvROJHy5RdD0DyemXqvksd3P1C1?=
 =?us-ascii?Q?R0TGQcnbGoO0gGnWb0/qlB3U8N1oTE9mvZvsgeW7BWmXimfrC1Ylf4bcg4Zs?=
 =?us-ascii?Q?+bHmFteVTPKpex9/AXgksIkKxdii4HzCVfeFwRHlkcz1oVVLfDqI+HtVrqX1?=
 =?us-ascii?Q?6Yl96wYcEImUfVf9gytPmnEFpfNVUIR+mZXtLFH9jGhARt4eRM/YkKqGHtSB?=
 =?us-ascii?Q?Uia+LQddr3A3tJTUrE6rbxwU+Vdn+JTf/IMQUkKAsxiPbA+JR66fALJkMMoj?=
 =?us-ascii?Q?PtsR6uPA/Pyicwk+i9O3Oj78558I01CoZKYPgi4hNmwICXlbZVE91Mqv4j7w?=
 =?us-ascii?Q?ILlQbXLX9K9F1eqNHAvEqsSLo+T8Rornt3XhWm/O9lT9ljeirfuMaU9ckeO3?=
 =?us-ascii?Q?iOWLNA+gDt3dAucMnQSNn0u3RLwJ5w5sIA/154k4UNXVioGBHz7JpoANcg+8?=
 =?us-ascii?Q?O54ZDG7KnuSpapHQu8f5JmktsVqC2doaeVkihHXwuX7vKv8uOiBdd3ec/eh+?=
 =?us-ascii?Q?Qs7tcIMZAfZA2qPSrjkzvrcfjaXFlZjO9zUtvNsBrfuau9GFfZ10U65BzP64?=
 =?us-ascii?Q?X8o2KS+vt6d53M2xd6RO/eECwBCGp/GRyFT+TxpR4YngxbijQ6hYi6To25xy?=
 =?us-ascii?Q?/Ejx4/+BYRqc1mHdRAxnWXl3g9TgZ4In1ORqZ0K6IBjxRnfQ1oFVF9oHauQJ?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jc5jz7iegjeZ1cn60R6Yrsb1C0VrI1xbGSane8xq1cVQ7dGINw3DCCPLrfY8?=
 =?us-ascii?Q?P43cdueoigFOMJxJvtxHOH77cvXlQdaq4a7PQdGG6r7V6fs7RB46ek45k+Iv?=
 =?us-ascii?Q?wIWQumFaJcrNx3BKNzkS8Ot7mffXdfpcDdzwqoAvs/AWJvmYM34OcO0D4nid?=
 =?us-ascii?Q?ehEbqfElWXnYeYMhLL+7mO62NV0SPQHxntp8dT5429sN1qurQF4JjmKXAscg?=
 =?us-ascii?Q?DDySPZ+GlKSHsxjKNo2AfYyKJZhz0Rm4YU5WuNwY49j8Npc0wUzFLNm8O3lQ?=
 =?us-ascii?Q?56EXQcIz/g5wxrQ8Q2lDAYyGr6K+MKYOnUntmarEquVLv+NaocCf5x3qtK68?=
 =?us-ascii?Q?AzixRnfnC3m9mTTluilw38zNAlpqDbRfBzKvYsgTPQxru2GAkXdJhcex4a7i?=
 =?us-ascii?Q?fpdOpV+sVIsp+ThdOquFsaH1kK5j+zw47CLul34jTAxTDbPnXFeuovD5Y++Y?=
 =?us-ascii?Q?6FvJtsPZ8W3567mUS6FesboVhaENUgFHmlwDHjqWFeNG21Zap4we466TZlW2?=
 =?us-ascii?Q?EijnrsHt7PqSI6PwHq3H8AjNLZD8BBV1gOv2jUxLtE60HYkFjSWUkM3znhEg?=
 =?us-ascii?Q?vhB7RwO3o680qu6McR2fBe+o1ED69vBcPYZSode1aWji/sp5bdp+c/DJu3g/?=
 =?us-ascii?Q?XAVCHqH4NYaEF8pE0uf+EkCxWYYo4tMcpLhvFkKa3NbLiACIh5mAe4dPMSsr?=
 =?us-ascii?Q?dRg/CGowyQCaYvM7gvau4s/AsYI/IRf2NBdcEwbyTaiV63sCV/jwxVDenNek?=
 =?us-ascii?Q?TtKR1KwVcRUkSLePMmyoyUnmZG4zzdDp0fmlTovvZfvFZS0cn+/4I9r4WeWc?=
 =?us-ascii?Q?woc6xImefJCqvA2KJlC6y6H8y1jjY4PG7eZXgD2Yr+EhW0xg9xqc8pe3MJnN?=
 =?us-ascii?Q?6KWtJqqYgPZUixrLRJgUChepgLPJKxtUEIRV4FXat2RybMBZBaMi1GLkLmrB?=
 =?us-ascii?Q?v2l70JgKqSQT9st62zhg05FLVv6y3/iXm6rTyhT9WtWskMIXe1DNlRnCPHi9?=
 =?us-ascii?Q?8YiqL+QaYLmgGjzsEQfXxXKHKzaKaA7YIXHXfiI1Hd20tOO37sEubRNVrfgc?=
 =?us-ascii?Q?S7aMZFnt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251eb84b-f6a9-44e0-d74f-08dbafdefc75
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 20:14:05.7677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxK6hyWOOx2Dn7Mqdbjdf2oASwYzRVhDKmz5GWbxWl18xhkP2Qi9tBYpvn9dZHO2hYZB8zW6sDGHvKhLxuQ8Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070179
X-Proofpoint-GUID: Rn8KODFFckxa0ScyhgUD3DMFZRzio3Sb
X-Proofpoint-ORIG-GUID: Rn8KODFFckxa0ScyhgUD3DMFZRzio3Sb
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
> Updated check_forking() and bench_forking() to use __mt_dup() to
> duplicate maple tree. Also increased the number of VMAs, because the
> new way is faster.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/test_maple_tree.c | 61 +++++++++++++++++++++----------------------
>  1 file changed, 30 insertions(+), 31 deletions(-)
> 
> diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
> index 0ec0c6a7c0b5..72fba7cce148 100644
> --- a/lib/test_maple_tree.c
> +++ b/lib/test_maple_tree.c
> @@ -1837,36 +1837,37 @@ static noinline void __init check_forking(struct maple_tree *mt)
>  {
>  
>  	struct maple_tree newmt;
> -	int i, nr_entries = 134;
> +	int i, nr_entries = 300, ret;

check_forking can probably remain at 134, I set it to to 134 as a
'reasonable' value.  Unless you want 300 to test some specific case in
your case?

>  	void *val;
>  	MA_STATE(mas, mt, 0, 0);
> -	MA_STATE(newmas, mt, 0, 0);
> +	MA_STATE(newmas, &newmt, 0, 0);
> +
> +	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
>  
>  	for (i = 0; i <= nr_entries; i++)
>  		mtree_store_range(mt, i*10, i*10 + 5,
>  				  xa_mk_value(i), GFP_KERNEL);
>  
> +
>  	mt_set_non_kernel(99999);
> -	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
> -	newmas.tree = &newmt;
> -	mas_reset(&newmas);
> -	mas_reset(&mas);
>  	mas_lock(&newmas);
> -	mas.index = 0;
> -	mas.last = 0;
> -	if (mas_expected_entries(&newmas, nr_entries)) {
> +	mas_lock(&mas);
> +
> +	ret = __mt_dup(mt, &newmt, GFP_NOWAIT | __GFP_NOWARN);
> +	if (ret) {
>  		pr_err("OOM!");
>  		BUG_ON(1);
>  	}
> -	rcu_read_lock();
> -	mas_for_each(&mas, val, ULONG_MAX) {
> -		newmas.index = mas.index;
> -		newmas.last = mas.last;
> +
> +	mas_set(&newmas, 0);
> +	mas_for_each(&newmas, val, ULONG_MAX) {
>  		mas_store(&newmas, val);
>  	}
> -	rcu_read_unlock();
> -	mas_destroy(&newmas);
> +
> +	mas_unlock(&mas);
>  	mas_unlock(&newmas);
> +
> +	mas_destroy(&newmas);
>  	mt_validate(&newmt);
>  	mt_set_non_kernel(0);
>  	mtree_destroy(&newmt);
> @@ -1974,12 +1975,11 @@ static noinline void __init check_mas_store_gfp(struct maple_tree *mt)
>  #if defined(BENCH_FORK)
>  static noinline void __init bench_forking(struct maple_tree *mt)
>  {
> -
>  	struct maple_tree newmt;
> -	int i, nr_entries = 134, nr_fork = 80000;
> +	int i, nr_entries = 300, nr_fork = 80000, ret;
>  	void *val;
>  	MA_STATE(mas, mt, 0, 0);
> -	MA_STATE(newmas, mt, 0, 0);
> +	MA_STATE(newmas, &newmt, 0, 0);
>  
>  	for (i = 0; i <= nr_entries; i++)
>  		mtree_store_range(mt, i*10, i*10 + 5,
> @@ -1988,25 +1988,24 @@ static noinline void __init bench_forking(struct maple_tree *mt)
>  	for (i = 0; i < nr_fork; i++) {
>  		mt_set_non_kernel(99999);
>  		mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
> -		newmas.tree = &newmt;
> -		mas_reset(&newmas);
> -		mas_reset(&mas);
> -		mas.index = 0;
> -		mas.last = 0;
> -		rcu_read_lock();
> +
>  		mas_lock(&newmas);
> -		if (mas_expected_entries(&newmas, nr_entries)) {
> -			printk("OOM!");
> +		mas_lock(&mas);

Should probably switch this locking to not nest as well, since you have
to make the test framework cope with it already :/


> +		ret = __mt_dup(mt, &newmt, GFP_NOWAIT | __GFP_NOWARN);
> +		if (ret) {
> +			pr_err("OOM!");
>  			BUG_ON(1);
>  		}
> -		mas_for_each(&mas, val, ULONG_MAX) {
> -			newmas.index = mas.index;
> -			newmas.last = mas.last;
> +
> +		mas_set(&newmas, 0);
> +		mas_for_each(&newmas, val, ULONG_MAX) {
>  			mas_store(&newmas, val);
>  		}
> -		mas_destroy(&newmas);
> +
> +		mas_unlock(&mas);
>  		mas_unlock(&newmas);
> -		rcu_read_unlock();
> +
> +		mas_destroy(&newmas);
>  		mt_validate(&newmt);
>  		mt_set_non_kernel(0);
>  		mtree_destroy(&newmt);
> -- 
> 2.20.1
> 
