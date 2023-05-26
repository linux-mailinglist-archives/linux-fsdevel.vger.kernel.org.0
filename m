Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A64712DAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 21:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjEZThg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 15:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjEZThf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 15:37:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEF2E51;
        Fri, 26 May 2023 12:37:09 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QJTWPB017540;
        Fri, 26 May 2023 19:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=DgsR5gpHjGgkhxhZFrzltCMgSAjDgDD/JM14SJFJp/Q=;
 b=k+eyv2MEcJ8MHdYo0bhIKKAeVE0mpXBjmQeo8q4QoNXYCKXkEpyBuX9PgrKEZdCA7Ajf
 R97kvskue5Yq0phaLi8qTYtV+T7xysbcY/bRrmMqCh0S5kFr29JD87eM6PLyFAA0ULIm
 ihmcIcGZM2GFywmh5lovQxu1WcUGL5cckC7deYLcX2n3xnUJFjYKNOvLHilHzOqy++LF
 ULxoUrLvwL2UEMB9RW/q3RCvL7XaQr7en3f+HZShpU9dTs0TM3HM1XjtOdArFEK5TbL5
 /6RXWFQxI04rL4eqTqL4BwhWCIqRZfUmpXASKly7xNVzw5nDrAx1vg3cBhX57KJKro1/ lQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qu2yj80ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 May 2023 19:36:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34QIrSGn028601;
        Fri, 26 May 2023 19:36:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2vk5w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 May 2023 19:36:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAa07LZVD/aHAX0RfYL+viFzbNjoRSJ11BdlMsUfkxsNH7Gbk0IWOyqLbVcE3eJ01lWM9TWEs2/RbPpRgS+OHShNAbkrMllP8Mw7KdP1DoIIeOuiDFrv9NNGu9ZDwItvsPd3HrCou8JoTh9bPfqvds6kGradRr+E0TNP7GXg0DPmq2DjHWKGJdUwyJS/tmuDlbDqUjLDg9DEFbWHuKsjQ2GPnn5sRH6C8Muwo8o31xUy4NaO7iBxO42rvG9xUdtZ3ZtYCkoGPNnRBLKEQRb7KzKlijNDqlDG+ZvJDgIEUGPnHqGkrO3AZn5IOB5yeVp9hfn2Q6BsrGZNSX7kTWotIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgsR5gpHjGgkhxhZFrzltCMgSAjDgDD/JM14SJFJp/Q=;
 b=dDsoHj6nin+Pgya4xHNnY3/rdyWsU6K7QHtFYlq7roLrTXZX/NKG+7cvWgakbxtnwCYe0qQfVEhh4oqVSNujDABoMt/jn594jZHR5UvqdQq/f3cwbROWw36btNu56lIe+ppoGTHkAhwHCyg6gceEfIOyvyu2AcXB7LhE2pKMG/90HLJ2FyyZBeP3NAlbIxtZS4ObGyekQVRKUcdP9QJNzXMVAST8mdReMRCpBfmGUwO9n80+J+h6mZpJS7Z9F95gkl95LdAk2TIRNbnOKIoYdUiF3G3d9dgbM35x5q9CiOvS7+iQb/bAJ4S5fSTJ1iyxpCIywSyOhefgXzvfvAr8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgsR5gpHjGgkhxhZFrzltCMgSAjDgDD/JM14SJFJp/Q=;
 b=n8WjGjQdhHgR7v3TlGZsjRiwGdLd+m4ZqqclzKGuzFkrBspNQthfphRUs02v2WOGbM6wSew5uKf4X1zBI+87+BiTnm5ANnDAjv9qRjk10gTWGLAjSlntdkoMjamBeePdLzVCkCHmFpPcve99bjySl1Q3cqrj5D8AFSaaKy5fAoM=
Received: from CH2PR10MB4264.namprd10.prod.outlook.com (2603:10b6:610:aa::24)
 by MW5PR10MB5714.namprd10.prod.outlook.com (2603:10b6:303:19b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Fri, 26 May
 2023 19:36:30 +0000
Received: from CH2PR10MB4264.namprd10.prod.outlook.com
 ([fe80::8027:bbf6:31e5:2a80]) by CH2PR10MB4264.namprd10.prod.outlook.com
 ([fe80::8027:bbf6:31e5:2a80%6]) with mapi id 15.20.6433.016; Fri, 26 May 2023
 19:36:30 +0000
Message-ID: <a018acee-b190-594e-da54-09c6f5143180@oracle.com>
Date:   Fri, 26 May 2023 12:36:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] NFSD: handle GETATTR conflict with write delegation
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     Chuck Lever <cel@kernel.org>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1685122722-18287-1-git-send-email-dai.ngo@oracle.com>
 <1685122722-18287-2-git-send-email-dai.ngo@oracle.com>
 <ZHD8lDQADV6wUO4V@manet.1015granger.net>
 <85bc3a7b-7db0-1d83-44d9-c4d4c9640a37@oracle.com>
In-Reply-To: <85bc3a7b-7db0-1d83-44d9-c4d4c9640a37@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0196.namprd04.prod.outlook.com
 (2603:10b6:806:126::21) To CH2PR10MB4264.namprd10.prod.outlook.com
 (2603:10b6:610:aa::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4264:EE_|MW5PR10MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: b87ad1ec-e6db-477a-1934-08db5e20813d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLKnCpgdoAbxlRp+FTuIHukA3383pwl5IJuycXiRaP8tFLCuu7UzkHZRAL5ngf7sJA6P5lniO3euGsXNqhdzJzVkZGEMyacw0qSqPBffvpIdOYp8oFvwRAe9p8on8GNG5FA9qmRWnYXSEiHNorn1DzI7gaOuK3sTV5SiPm9EWTiifobt2EFMiFURXoaKBabp+IXdNGoZFNjmHzBMjouv9qwF2ZV8DoQby0fNnwgUOQrKniNDaESrBllnXcaKTE9+zWdQxp0RKrAT0H36RixvmDLSMHBjI6PVwmGWsZTgUTmGe6zMVGL+QDflsE8LaZZorcNoooQh7R6EJcUHPlhYYhAIgsApQIp2jMAPdnCExiuCPP+uEb9Qb4P8FkDRyFQ0aXhZ6a6/jdVQP4MMcjfHgzt9lySPm1l3YA/Uf7dIgfzsDy/EcK3E8I8NX7IxG65tWirEXONyGtVCxB1L9y/UZJG3AhDVyA3x2FihoT6R9DyNXbmtOMqGDC2gr/6SntNNGdrSUKG01s+fXWqK8UHREIZhqEfTvn8G/XjZTF1f0tmbwLALnnxhQj/6mGaUC7MsiAqnanf2uaqgjej93GP13Z31GdKCnLbk3m8bVTPL7TpYSGJ2KxDA1E937bpT1khv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4264.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(4326008)(316002)(53546011)(9686003)(6506007)(26005)(6512007)(66476007)(36756003)(66556008)(6916009)(38100700002)(66946007)(6486002)(8936002)(8676002)(5660300002)(6666004)(41300700001)(83380400001)(86362001)(31696002)(478600001)(31686004)(186003)(2906002)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDdlTVRXNEtRallzWGExY045Smtwdmg5RWdGSmhxTmJ2UFVYdTFnVGl3b1FY?=
 =?utf-8?B?dGpQQnlwK2RtbE1sWGk1amZuZEJYT3pjcmxsMk01SXJUR2VkRWp5VjcxK0dP?=
 =?utf-8?B?UU1yV2hFTElXSVR3cDhwQ01DNUtpUHBpdHNhRFQrUzM0SjR4dkZlQ2N4ejVp?=
 =?utf-8?B?L3pHT3N1dTByWUNBczNTOEwyVDhtbktQZ2NoNVY2ekptRjc2YURmVGtBbTRs?=
 =?utf-8?B?ME1GMVVSTGgzMzd0NjBJelBnZ0w0V253Lzl0Z2VaUWduMFdyMmxlSEZBYnlX?=
 =?utf-8?B?Q3VKRVVQMkhxN3RSVHBLczliUGM4M253T3lEOEJvSm1Ld1dnYzlpam5FTEhz?=
 =?utf-8?B?Ti9wUFZzUHY0QU9hc2FzbzM5QUhtSDlNbGNreExSSEIwTmY3a25Qa1FzbUpP?=
 =?utf-8?B?ME15Y1c5ZDAvSGNWWGh5SWdpcE1WRkNOdmExeU8zQ2pNV2VMLzczc2NMcHRV?=
 =?utf-8?B?UVZyY3pka2UwSzk1V2ZNUFo0cG9FUDVXdjI1c29PT256c3NkNnN4YmRTY1d0?=
 =?utf-8?B?NndRYS9UQmJQOU54U2hiMms4SytGMVhhUEpxdGtKSTRhWmtCeGdKNDZ4VFNK?=
 =?utf-8?B?MWdRditGYUcreHNGcElOa3dPbzhzd3pnNU9mejU4ZEloU0g2ZXc5bThneU5Y?=
 =?utf-8?B?MHZ3UW9Ick9paDFlNTZ3V3hLYUtCbExZUS9xQ2R1cnlSY2hZellvU25YNWVw?=
 =?utf-8?B?UmlmbGFqUHZSRUZQUHFVQkVwYjZ3d2tWU1FadFpUYjZEdXo0NVIxWUVTT1oy?=
 =?utf-8?B?cXpJRG5CM3dzOEpVbjZyT1djUGpBdkpDWGh0cXFWWWNlekErMzJvancwR3d4?=
 =?utf-8?B?ZXgzVmNRdWt1L3I1dXJoVnhYZXdWNllaSUxtcTQ3VEJndWdFRDk3dFY3emhz?=
 =?utf-8?B?bmptaHdNb3pNeGw2dnlWM3dQTnEyYlBWL2FYS3EvS0ZkeEdQR2NzYlpqc3U4?=
 =?utf-8?B?bDdkbURYdnp1RkdBVS9HSFlmZHpzNEI5eTdxNUlsREtqWGxkLzR1ZnFxNDBC?=
 =?utf-8?B?dUR1SHM3ZEZWK0swOUYvcWhTMXl6WGx0U2U5cm1adEIxeFpvNXAyWTlYRHdo?=
 =?utf-8?B?Zksvc3N1WEZKa1FWWlZKQjI1U3FpNVlRZzRYZHFic1AzeGhxeXp1U1pjNS8w?=
 =?utf-8?B?Uy9oZTg2YmRXZVg3VGJSVkt6R2xEK0ttMHliMncwVDV4TlZuajZGR3Rsb2Rh?=
 =?utf-8?B?d3FXdHFuaHhZYnBJY1RUaU5jSnlVT0k3RG1NNUxpUXBaQzZaaW9rQkZha2cr?=
 =?utf-8?B?dUpZb2hyaU9SNHlWS3dSSS8vQXNnelhOQnFNSnQ5dGRQNHVlMCtrS1laRVZi?=
 =?utf-8?B?UTZSR1pMS1JZcHJpYnB3amxiMWxicjk4UWlZTUI0TjBzTERVVEIwRm15eHVo?=
 =?utf-8?B?NjNZUVdDZXlPNW5MVnJBTXA2V3JqNEMyWTVNWmpjMkFPbmFoMzF2OUxjUTFq?=
 =?utf-8?B?UkxGZGJXZDNoTlJEOVlVb2p4SGd2MGRlaWpaUTdQRGk1bThZeE9LbjJKcmk1?=
 =?utf-8?B?NmhaZDJWUU9KUlprR1RJMGhQNEhiZlRHUENHeFVNZzdWeVdRbzUxV1o2RkVI?=
 =?utf-8?B?Vm15OUwySjlva1hJcUs5T3BkeVo3SXQrQVhYNnNseUpiYkp4Y2dJTTR6S0th?=
 =?utf-8?B?SzFPYmJqYi9RSXFPUXVJaU1vaVJTb2lKbjlBRVVsZ2VWN1BuamdiaGtYOW5q?=
 =?utf-8?B?RWVUWlRnYzB5Wk40Y0toOHBIaWpqaFVyaUtJSHQzV0ZCYTk2NXZmMFBOb0Y2?=
 =?utf-8?B?V0tMWkJCcFBrNGVyRVQ2WHFFUGZMeVNPRlJwT1NUNjNrUTMzdW9Mc2JNdERV?=
 =?utf-8?B?aGNHSm1QRXBZUzFzeDB4U0IrZ1lTMlVld3djYStUWmxYRG1Hb0g0ZHA1d0V4?=
 =?utf-8?B?UGRLODYvc09sdFJ5b3A3VTV5N1FtT3poaUdLcnJ0ZGtkODN2S1MxVEt3dFY0?=
 =?utf-8?B?YVBVRzYxN3RRMXFHT2lpbXRYc3VUVWF3OW5La0ZGTm94ZXRDYjdlcWoxUFJK?=
 =?utf-8?B?YTR5SEJ4bTJEdTNhMWNTYWJvZFQ3ZGp6WDZTN0hTbktrQWJjc2J0ZDFGWG16?=
 =?utf-8?B?OC9Kc3FpUFRRNkZBYnl4aUhacmRPRDVkUUpsdVdRUytXK2lVZnVWRUFUMlFB?=
 =?utf-8?Q?Q/IuayAbn0xDjXJJzZWRjTlLs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZMwUI8LDh34tHrZOqt6z03dGA3+E6JmktaYJ0DLfwqhx9IdOyrDtUtZlzkIuu0AMYyA5otgOuWxf0KGdqxN1//0bhf4E1c2ScgHThHuIOoVLzxufErwa54799OohIy7U9yYQAaaBCfcq7Nzv4l/ZUn4mlxnj1ZQ44N+WbuKEetCndzcH6edxeOGYVfzLzWUs1v9LsXP/FChVXvfSdYb3UiY8yT7h4kSmu7MaLVTYxxFsyV1+zmnY5TgmDTbo2djxvgb4VYemQeUYD7xDvVjJTrYgBIF8glRZrp2LQAKhQrW9A9tfTtYLnol23hzGh0fhCdPxRcom3yaXWnn9lbewfjsguWXEEGQyP1oU3mjZWtVpOdpX6ZblDqgNNpZS1xNSMU+EPFpKFbXub1AkeGDOBiRkD61/Man9qfH2ZT0PEgWJytXsWSJXQLd81k1V1H6RQ6Rmdq3Bt/znqhnk7sseDn12gy0VckPvs7riTveC7BxbiI2Jj/sWmW1oZ2DkUhalgJQo3vY6qk7KIRJtnp9wLVtfKsXQnRyT58679Kwz0Cb8ypNhU+bPQ3Vr2dyaAsDqp8GOQLEFAinPiyedPzLKZw9aRaUstvqj5eTzjz2esrjMlM9VVErGp/LctmkWpLaVlHazOmxXZClg1ubmAbRnfn+cQ+mYCSWvsjqBOuba5IlW0NWAJBfAicMeUApvEzDCYPkzOaTwpRH+tRpxP0eerozpwpd1+44SzC3YjN/MaJkJl31P20EJZYqfHIzxkU/81G7iBS8H26G6pGh672y8TtZGA2M75i1Lyc3/VLe4odA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87ad1ec-e6db-477a-1934-08db5e20813d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4264.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 19:36:30.4624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgQuODjv7pbg+erSTneM2Vbc5D0qZ+3v5CgE41Krz0skQWzyhRGVr9aEU4fjD4Lavbdulicgf72NUcquM/NmGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_09,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305260167
X-Proofpoint-GUID: kFvYJRVstWC1ea5sExYE1z2FTI02l0Ir
X-Proofpoint-ORIG-GUID: kFvYJRVstWC1ea5sExYE1z2FTI02l0Ir
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/26/23 12:34 PM, dai.ngo@oracle.com wrote:
>
> On 5/26/23 11:38 AM, Chuck Lever wrote:
>> On Fri, May 26, 2023 at 10:38:41AM -0700, Dai Ngo wrote:
>>> If the GETATTR request on a file that has write delegation in effect
>>> and the request attributes include the change info and size attribute
>>> then the write delegation is recalled. The server waits a maximum of
>>> 90ms for the delegation to be returned before replying NFS4ERR_DELAY
>>> for the GETATTR.
>>>
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>>   fs/nfsd/nfs4state.c | 48 
>>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>>   fs/nfsd/nfs4xdr.c   |  5 +++++
>>>   fs/nfsd/state.h     |  3 +++
>>>   3 files changed, 56 insertions(+)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index b90b74a5e66e..9f551dbf50d6 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -8353,3 +8353,51 @@ nfsd4_get_writestateid(struct 
>>> nfsd4_compound_state *cstate,
>>>   {
>>>       get_stateid(cstate, &u->write.wr_stateid);
>>>   }
>>> +
>>> +/**
>>> + * nfsd4_deleg_getattr_conflict - Trigger recall if GETATTR causes 
>>> conflict
>>> + * @rqstp: RPC transaction context
>>> + * @inode: file to be checked for a conflict
>>> + *
>> Let's have this comment explain why this is necessary. At the least,
>> it needs to cite RFC 8881 Section 18.7.4, which REQUIREs a conflicting
>> write delegation to be gone before the server can respond to a
>> change/size GETATTR request.
>
> ok, will add the comment.
>
>>
>>
>>> + * Returns 0 if there is no conflict; otherwise an nfs_stat
>>> + * code is returned.
>>> + */
>>> +__be32
>>> +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode 
>>> *inode)
>>> +{
>>> +    __be32 status;
>>> +    int cnt;
>>> +    struct file_lock_context *ctx;
>>> +    struct file_lock *fl;
>>> +    struct nfs4_delegation *dp;
>>> +
>>> +    ctx = locks_inode_context(inode);
>>> +    if (!ctx)
>>> +        return 0;
>>> +    spin_lock(&ctx->flc_lock);
>>> +    list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
>>> +        if (fl->fl_flags == FL_LAYOUT ||
>>> +                fl->fl_lmops != &nfsd_lease_mng_ops)
>>> +            continue;
>>> +        if (fl->fl_type == F_WRLCK) {
>>> +            dp = fl->fl_owner;
>>> +            if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker)) {
>>> +                spin_unlock(&ctx->flc_lock);
>>> +                return 0;
>>> +            }
>>> +            spin_unlock(&ctx->flc_lock);
>>> +            status = nfserrno(nfsd_open_break_lease(inode, 
>>> NFSD_MAY_READ));
>>> +            if (status != nfserr_jukebox)
>>> +                return status;
>>> +            for (cnt = 3; cnt > 0; --cnt) {
>>> +                if (!nfsd_wait_for_delegreturn(rqstp, inode))
>>> +                    continue;
>>> +                return 0;
>>> +            }
>> I'd rather not retry here. Can you can say why a 30ms wait is not
>> sufficient for this case?
>
> on my VMs, it takes about 80ms for the the delegation return to complete.

Otherwise it takes about 180ms for the CB_RECALL and DELEGRETURN to complete
before the client can get a successful reply of the GETATTR.

-Dai

>
> -Dai
>
>>
>>
>>> +            return status;
>>> +        }
>>> +        break;
>>> +    }
>>> +    spin_unlock(&ctx->flc_lock);
>>> +    return 0;
>>> +}
>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>> index b83954fc57e3..4590b893dbc8 100644
>>> --- a/fs/nfsd/nfs4xdr.c
>>> +++ b/fs/nfsd/nfs4xdr.c
>>> @@ -2970,6 +2970,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, 
>>> struct svc_fh *fhp,
>>>           if (status)
>>>               goto out;
>>>       }
>>> +    if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
>>> +        status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry));
>>> +        if (status)
>>> +            goto out;
>>> +    }
>>>         err = vfs_getattr(&path, &stat,
>>>                 STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>> index d49d3060ed4f..cbddcf484dba 100644
>>> --- a/fs/nfsd/state.h
>>> +++ b/fs/nfsd/state.h
>>> @@ -732,4 +732,7 @@ static inline bool try_to_expire_client(struct 
>>> nfs4_client *clp)
>>>       cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>>>       return clp->cl_state == NFSD4_EXPIRABLE;
>>>   }
>>> +
>>> +extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
>>> +                struct inode *inode);
>>>   #endif   /* NFSD4_STATE_H */
>>> -- 
>>> 2.9.5
>>>
