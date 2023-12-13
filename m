Return-Path: <linux-fsdevel+bounces-5905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DCD8114E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4F41C21019
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C252EAF2;
	Wed, 13 Dec 2023 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NVf8c2mN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zlzSUEiC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3206891;
	Wed, 13 Dec 2023 06:40:50 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDER3bP005729;
	Wed, 13 Dec 2023 14:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BU87WT+rhq1TiZRthnVcOuY8msEDslsTtr8SXdmOuxA=;
 b=NVf8c2mN7dnd+k4qASqA6nxForOxOmDt539168xn8QMPSYD8L4W6nCOVcZaaSjMH0P5X
 LCVTk9HMjF4iBvhvOe8TpCO1X/LrtjGTYuDGR/6ScM3XqzChzgsqib3drV6an/OxEnaS
 nPJYV6qW2H2ze0GOdMKQdZpp6lVOxRab1PzNEW2Ui82J0tF2jDjFKnAsxZWoZXvXoL4I
 RCRSGPNIO7KiXDvlYfQIESdGCD2RL9tWd3fzpjSTukew4VEnAoWePuu3ZxMEwYhL22c/
 TX4cxD0almT/MJoil7ZQGLh7x3s4LVsWI2EBs1NaQPJNd2qw+tCa88uiLspEBQjpR0aZ Nw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvg9d8ehm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 14:40:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDE6La7008227;
	Wed, 13 Dec 2023 14:40:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep8b89e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 14:40:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2WP9IL7imNWKUdn6KsVqBPvrztICRRn9WqDopDXbi/IsDv86+d/GAqU5y/Deaah9kniCNNzOXF6px5nLVN8qvK5+Nej2oezWz4tMIqPIhSfDHRHknv6VawYV5fHjSSUpsOStXr4uA0eiMOKOzkylLMuFKFvU5ZlySsxq90zZWNRJcrKZfa7V99fZqoejX8h4KYYLmpHXX2JFHaJXDQ7iiWQY7BY0wJMBa41FmLmS+1rx9qFC/AtCBKQxpgqRm5kXKuY4XgykyNFsMIz74neKuykj5UsOA1gU35TB95xg4k3ojhTBzWvTFXaQiNiMTOzFDG5oygB/ol1wppe+lp/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BU87WT+rhq1TiZRthnVcOuY8msEDslsTtr8SXdmOuxA=;
 b=l798zQXpy1oKXhIkF4D8TLMwvR5ktZ52cCWzAPyKDTMW7RAs9L5MDy3djmBg8oCBhJqwzbmfNIYjfQDC69wPdbJ6gSff0VjRI9rpxTlMKJ9cKhLTMwNVFoo6TrwfWXXQ6fCg9FUpTsrx4OueOGef/0BqgHJJxURcd5sUJsMHIjvOKIeKwvnLA9kX08A0nSq2BfGKvpbhpo5cEDD6v7oFDf7jjD5GaBYU1DDP7zv6FZKpbZ8Y8iC4Tn9/xgPG+OmrAQ2HP8+9xxZWkQPHxlOHGKKHYq8pXxNSLITA/YIUALyOjNOTddmzqEYVUy/82pNHd6ZxU6Y5qjJKtdy8oG+D+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BU87WT+rhq1TiZRthnVcOuY8msEDslsTtr8SXdmOuxA=;
 b=zlzSUEiCMnw1irGXoVEV+WLIMUbIJE4LPhnZQG838l7X96+7697enKLWCxfcHSNyPgtUX/gR/96ljGTUtopS3L137cL6JautIH1OLQtr+QVkO8Yr8X2roqnI9JaLO+RVNTnLTj9CLiGy9lvB/sK+7qQFwX9dVYW6hdvwKkUZ7nM=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by MW4PR10MB6370.namprd10.prod.outlook.com (2603:10b6:303:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 14:40:40 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 14:40:40 +0000
Message-ID: <fb2cf7c5-cced-4ea3-bf5a-a442a0e64bda@oracle.com>
Date: Wed, 13 Dec 2023 15:40:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dcache: remove unnecessary NULL check in dget_dlock()
Content-Language: en-US
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Waiman Long <longman@redhat.com>
References: <20231106134417.98833-1-vegard.nossum@oracle.com>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <20231106134417.98833-1-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P193CA0045.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:51::20) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|MW4PR10MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: fa40bd93-087b-4f48-6824-08dbfbe97a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9/ZflScWBLMBKPDqaTRKJKzH2YfYJokHeGPfYNXSLapTm5gM7q+3GCNCkjky2OuNAygxuBDGiAnwmj+nZbIn7Zhqr5S5vmQnaTxU8mCyRwy5iJMXgMWzD1UROMyTTotkaKSVUs4jo9qRbgzQNJ6oRUgg59HXt87EfNjmf1A3V9TZebJ4NVamIba8QqxGIxKO9Qz3lgxw5VgyhTorFOUbGEjBJSmzIU4dzqhrhfgMEm2NLNepqRqTilhuPeKQqp3oxEXMzPZH93tgbd4RjrMFJwWOzUJej5muJYfIdG5vFDGLhqBGDEhj0qKOP5ITYvfOsuLJfeTraiHlNgU+5Tha6n8R28jUmWVJkqkZAkJJ8vLw+YpnoP2X4g57uPY7Z8rWQ6ZM6pHD4PQcTfScwaTsXhk41QKpRglOGre6xuuiMc2vNI5OgMVvsqWqs7woWdsrQHO+f0WZM2sDltz0LB35vbhF+5ZIcLGDDukEjNSTvZr8Jm1GsZ8xv4S3p/TLU6zH32+QzxBHgOvVK3rdaf3b36K0LTyVE+wv7NTTBaFvm9ergeqhN5Z0/dXqbC0t3lhA5v5vQgI3uyf6jhaeHdqNiXfQWXGto7Y/knypCccAViJ8Sx1NoM+1IDHc3h/4O8Nn/1OgJJe/uqfSZQs/Tm5lntFmrzI1BMA50fY0Qgd9G3XggSOmgFiLPWvr89mQNHNf
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31696002)(83380400001)(6506007)(53546011)(8676002)(6512007)(2616005)(5660300002)(44832011)(41300700001)(4326008)(8936002)(2906002)(966005)(38100700002)(26005)(478600001)(6486002)(6666004)(110136005)(316002)(66556008)(66476007)(54906003)(86362001)(66946007)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y0YwYnhXWjVyTFFJaXg5WS9qMjVuQlAxQU56VU01V2JTWkpZenVzL2tGRC91?=
 =?utf-8?B?ZzFSYzhjRWFodHdvdVJUbU9TTGIxQTdxNkhDMjY4dDZ0dDc5bFoySGd3N05x?=
 =?utf-8?B?R3JVbWFMdVFCVVVWN3Vya2NlOGxOdFFqRnBueVo0MW82WmNPSUUrZ1N3VVdp?=
 =?utf-8?B?TWZKcXFJRWJuUHZOeWN2U3EvV2NodXZ6RGRvUXVVQmhnTXAvc2pqaVZvb0Fn?=
 =?utf-8?B?cFJ4Z1FrZ2FjNEpKUHREY09KTzdPdHc3MmRwdU5CaWJreWpkWFFuOXFuL2xB?=
 =?utf-8?B?WjhKeVhSblBwM0RkVVJpM0NoUmpvWmp1OFhFaXdUNUd1dDROdDZGOXB2UnA0?=
 =?utf-8?B?YklxUHBLVUwzVm51Q0dPUUpnTzlsMERzNEhYeUlVTmVydjBlaE9hZXprU0FB?=
 =?utf-8?B?aDlvVS9CemYvaU5rRi9URlVSWEZrcUNHM3BYbVN5RWZhNHFWSkxnaS81UUtP?=
 =?utf-8?B?b0hCdEdvUDU4Z0Q1M0YvQ3dOTldLclpGN2hxMitSNEVnL2ZqQ0htekJkeTJw?=
 =?utf-8?B?TnI1QkZjU3JoTlBaQmczMWZiVjZWa0YreDVodTROeWRCa0wxK2Vid1NjVm5F?=
 =?utf-8?B?NWZXanQ5WnluZFcvcHpEZUZ2U3kzbW15MU9QTGlndUNTazFQdmQ4bTVrc1k4?=
 =?utf-8?B?cEZkK1lWckY0R0Z6Z1FjS1FNVURkMkU1dGhvRldzdVpJVzUxZVNKVmhvVGo4?=
 =?utf-8?B?K2JOZEs5eEZ6SEgwNHkxZHFjWXRlS1ZPajFXZ2RYaG5YOFpaczFxSVo1RXRo?=
 =?utf-8?B?bEQrZzNjSGVlcTJ4OUFrWDBKQkN2dlZrZTBqSGZyOXA3bDBSeXJ0UURvUkZm?=
 =?utf-8?B?L3ltNVhnb1dxZURWR1l0K215a3E3cmRiK2hDNE9jYXoyc1VRckkzQit6R2dF?=
 =?utf-8?B?YjdpOGFYOVpxVTJ2QURxd1h3Y2dzUE5laE1vMWdlS29NQ3NmOUVGSVduL2gv?=
 =?utf-8?B?YUVDeEhhTGhuSnZ3MFpONVN3dUVTMGJoc29EQ1lYV21YRm5oSDZmWFRXKzRK?=
 =?utf-8?B?YjV3ZXhkWVRnN0l2cFQ1M2ZXaGg5NC96eEhTQnBLYVg4ZVp0WjVpYnhIL3Zy?=
 =?utf-8?B?UWV0UXM2cmxNRW5RSjRUMlA1Yys2and2cUtJVzJMVTFzU3N6RkpYMVdzNm42?=
 =?utf-8?B?RXlpYktQanJrYXQ5RlpTZHBWM0RvdnpFbGkrMHdjaXhveHA1b3ZPVFgzTml5?=
 =?utf-8?B?RzI1R2djZGJRTk9tSiszMVUwYmQvekx0cGxDNW0wL1lpYm91NU5UU2FOT3lu?=
 =?utf-8?B?MzNSKzZRWWFNS3RnZTdFVmhmZHdtTjFBNVhobmRRWVpoVXZEQlZSaDdjSE5N?=
 =?utf-8?B?SjRPL2dHRFM2L3hlbkZpUDYzb21RYmpUcFpucnIvV0phSWhGZkVDa3YyZFZZ?=
 =?utf-8?B?c01HTUEySW5pckFSOFErUys4dnA4MjBZcnRsdWpITytGMnBjS0I4NWMrakpq?=
 =?utf-8?B?c051WnFCWGM4UFZZSUhSY0d4SkREVmVGcEZKVzV2Vm5aMG9rMUlhaWRaZ3Jx?=
 =?utf-8?B?dE5acmpZamtub2pwdjZ1TzY1bk5KMU5hdDloc0p6czJQRkxxYTZSa0d1em9F?=
 =?utf-8?B?aURQdFlzUHdDZng4TEwrL3JvdXl1SkowQnY2a2lBOWxmK21Zd1BiVy8vVmp6?=
 =?utf-8?B?UFhJd0pPRHdjUnhTdVZHSGs4eS81NjR5U09PR25ON0xrUVl3N3grVkF3Yytu?=
 =?utf-8?B?ekE4Ykd5OGlxN3ZRdmMrd2phM3lUT0t5ekl2TnIxNWs1ZW9BQUo4VUViZFZw?=
 =?utf-8?B?T3lXM0xGSmNjdnJRckEwNTdBMjJOanFhTGpoWi8xNGh0bms3ZCtqL1hoNGVY?=
 =?utf-8?B?MXVmTGxkc0xnYWs3V1B6ck96MGtHU21GcDRwK2lHVTlnRHBrNGptUHVhQXZt?=
 =?utf-8?B?RGdZblNCTVNxcXNjQ2hwYVFCSnVldVVhcTBzcHQ1akRlWlo2MUt3eWd6OVM0?=
 =?utf-8?B?bjlTRnRUKzJyWWJOOFJjUkk0bW0xNU4xOVZ6NHJpdmtjTjlDZHBFZ0c1clpQ?=
 =?utf-8?B?N3hNbTJuQ1NTT0xYUnpaMm9ETm5lU25qaE1UVjJDeTE4M2FSSnF4dWlqK2ov?=
 =?utf-8?B?dk04MitPcWxwNkU5SEJGcldudjJUbGV4WVFtc3h4Z2VhK29tTjl0RStmL3Rl?=
 =?utf-8?B?dFBoMGFGTjhyT200RDExdlhsLys3dWRzOXUzTFVDakltQ1NGNGhBSFFRS0ZM?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	edSMeEFggiugJPMJByyIkKdrr3an8q8HxANc1ozF40+DIUymdybavpH3FVuxi9+6Oqc8zFidi+qtz3ze2nPRsMj3ieb+NmMYflB5z5Mex20ejez0z9nr+thjW9sbMeZttBqVdC7Ec3B2RUCaUgb/a5zACW6QdzFVk/kvuKoTNRlTrgaz+aNnkuLPjFXyIxoH1Sl55wRZzljsqZvqzl4/zkgL3BCq4jkY3Whrs5QkpTMA7iyxiB7/O91/gK3QGbqLkpsRwJiUL694MJGfqO8l1Ngnaei9jbzqctgiyvpty5O5kqqd82DzVDaSQ/F3arW46IwhjqrzBNKJbq+vhA8zU0oBTwh6S8GTx/Sc46itNLBD/eQH6hlOvEDvGE+92Pdlzi4G5FggpSDOZi74FoYMNK41zMPom2waH4U3ZbFfEzQPA7VC78VZxyv/jLzUyGhL1hDnPAsb+vuSQnnVlxg2AApomkwnIq6+APYF3SNU9CgBPZw0NpiOV/xcg+HNbzqxgLJWVZEWTBuW2AiVvBtoqX+idgAe8O2s6LLQUM0WDigIKQZ0e00fHdbgiApu3UHlDOODxluGGX9hPNefHbboqJcqNu5ueLA17DqpaA0hkkKpW3rTr+uBh3KQ/20rrV75vzELnQauoRPjBsmn1wL295Jp4tlAyC/KMgWTBO0ALGUaTYvoYalHGrBnyqlX2o/CInYhtgIw3BMorqH67hucpgN+XcJH6ZOvrb8b8JrAbQ+p+Vp1O+cjcgv4FUwB3j0zqRQyHpMDRzkBlpGZtOO5jzwc18RVdkESTsn/JUIm+vDTLt/0QhN18JJfvrCGYJV7FpZJw1vG9MRB5VDlzZT9Pd/YQs9Ys+cDb/DltEvmO6zlQLvZ9G93ZbL796nhjUptWkMz0oNSYN0oLQtGEN6RwQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa40bd93-087b-4f48-6824-08dbfbe97a23
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 14:40:40.0596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IhOxQ7cvO1oyPaD6dZjlQmPeS4pMongnjt1SyvwoxfsXWQWA4xuLgci290GPBNozpB5c5T7smhnzNrnVoxzt9ACG8142hUHa4D6tuCXOb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_07,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130104
X-Proofpoint-GUID: pExDxE0kuRVZGcEIMCp60dpDdlnsztmN
X-Proofpoint-ORIG-GUID: pExDxE0kuRVZGcEIMCp60dpDdlnsztmN

[Fixed up a couple of bad addresses in Cc]

Hi,

I didn't get a response to this v2 of the patch below and I don't see it
in vfs.git.

Was there something wrong or is it just awaiting review? Is there
anything I can do or help with? I would be happy to try to review other
patches if there is anything outstanding.

Thanks,


Vegard

On 06/11/2023 14:44, Vegard Nossum wrote:
> dget_dlock() requires dentry->d_lock to be held when called, yet
> contains a NULL check for dentry.
> 
> An audit of all calls to dget_dlock() shows that it is never called
> with a NULL pointer (as spin_lock()/spin_unlock() would crash in these
> cases):
> 
>    $ git grep -W '\<dget_dlock\>'
> 
>    arch/powerpc/platforms/cell/spufs/inode.c-              spin_lock(&dentry->d_lock);
>    arch/powerpc/platforms/cell/spufs/inode.c-              if (simple_positive(dentry)) {
>    arch/powerpc/platforms/cell/spufs/inode.c:                      dget_dlock(dentry);
> 
>    fs/autofs/expire.c-             spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
>    fs/autofs/expire.c-             if (simple_positive(child)) {
>    fs/autofs/expire.c:                     dget_dlock(child);
> 
>    fs/autofs/root.c:                       dget_dlock(active);
>    fs/autofs/root.c-                       spin_unlock(&active->d_lock);
> 
>    fs/autofs/root.c:                       dget_dlock(expiring);
>    fs/autofs/root.c-                       spin_unlock(&expiring->d_lock);
> 
>    fs/ceph/dir.c-          if (!spin_trylock(&dentry->d_lock))
>    fs/ceph/dir.c-                  continue;
>    [...]
>    fs/ceph/dir.c:                          dget_dlock(dentry);
> 
>    fs/ceph/mds_client.c-           spin_lock(&alias->d_lock);
>    [...]
>    fs/ceph/mds_client.c:                   dn = dget_dlock(alias);
> 
>    fs/configfs/inode.c-            spin_lock(&dentry->d_lock);
>    fs/configfs/inode.c-            if (simple_positive(dentry)) {
>    fs/configfs/inode.c:                    dget_dlock(dentry);
> 
>    fs/libfs.c:                             found = dget_dlock(d);
>    fs/libfs.c-                     spin_unlock(&d->d_lock);
> 
>    fs/libfs.c:             found = dget_dlock(child);
>    fs/libfs.c-     spin_unlock(&child->d_lock);
> 
>    fs/libfs.c:                             child = dget_dlock(d);
>    fs/libfs.c-                     spin_unlock(&d->d_lock);
> 
>    fs/ocfs2/dcache.c:                      dget_dlock(dentry);
>    fs/ocfs2/dcache.c-                      spin_unlock(&dentry->d_lock);
> 
>    include/linux/dcache.h:static inline struct dentry *dget_dlock(struct dentry *dentry)
> 
> After taking out the NULL check, dget_dlock() becomes almost identical
> to __dget_dlock(); the only difference is that dget_dlock() returns the
> dentry that was passed in. These are static inline helpers, so we can
> rely on the compiler to discard unused return values. We can therefore
> also remove __dget_dlock() and replace calls to it by dget_dlock().
> 
> Also fix up and improve the kerneldoc comments while we're at it.
> 
> Al Viro pointed out that we can also clean up some of the callers to
> make use of the returned value and provided a bit more info for the
> kerneldoc.
> 
> While preparing v2 I also noticed that the tabs used in the kerneldoc
> comments were causing the kerneldoc to get parsed incorrectly so I also
> fixed this up (including for d_unhashed, which is otherwise unrelated).
> 
> Testing: x86 defconfig build + boot; make htmldocs for the kerneldoc
> warning. objdump shows there are code generation changes.
> 
> Link: https://lore.kernel.org/all/20231022164520.915013-1-vegard.nossum@oracle.com/
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Nick Piggin <npiggin@kernel.dk>
> Cc: Waiman Long <Waiman.Long@hp.com>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>   fs/dcache.c            | 16 ++++------------
>   include/linux/dcache.h | 29 +++++++++++++++++++----------
>   2 files changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index c82ae731df9a..4bf33ba588d8 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -942,12 +942,6 @@ void dput_to_list(struct dentry *dentry, struct list_head *list)
>   	spin_unlock(&dentry->d_lock);
>   }
>   
> -/* This must be called with d_lock held */
> -static inline void __dget_dlock(struct dentry *dentry)
> -{
> -	dentry->d_lockref.count++;
> -}
> -
>   static inline void __dget(struct dentry *dentry)
>   {
>   	lockref_get(&dentry->d_lockref);
> @@ -1034,7 +1028,7 @@ static struct dentry *__d_find_alias(struct inode *inode)
>   	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
>   		spin_lock(&alias->d_lock);
>    		if (!d_unhashed(alias)) {
> -			__dget_dlock(alias);
> +			dget_dlock(alias);
>   			spin_unlock(&alias->d_lock);
>   			return alias;
>   		}
> @@ -1707,8 +1701,7 @@ static enum d_walk_ret find_submount(void *_data, struct dentry *dentry)
>   {
>   	struct dentry **victim = _data;
>   	if (d_mountpoint(dentry)) {
> -		__dget_dlock(dentry);
> -		*victim = dentry;
> +		*victim = dget_dlock(dentry);
>   		return D_WALK_QUIT;
>   	}
>   	return D_WALK_CONTINUE;
> @@ -1853,8 +1846,7 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
>   	 * don't need child lock because it is not subject
>   	 * to concurrency here
>   	 */
> -	__dget_dlock(parent);
> -	dentry->d_parent = parent;
> +	dentry->d_parent = dget_dlock(parent);
>   	list_add(&dentry->d_child, &parent->d_subdirs);
>   	spin_unlock(&parent->d_lock);
>   
> @@ -2851,7 +2843,7 @@ struct dentry *d_exact_alias(struct dentry *entry, struct inode *inode)
>   			spin_unlock(&alias->d_lock);
>   			alias = NULL;
>   		} else {
> -			__dget_dlock(alias);
> +			dget_dlock(alias);
>   			__d_rehash(alias);
>   			spin_unlock(&alias->d_lock);
>   		}
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 3da2f0545d5d..82127cf10992 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -301,20 +301,29 @@ extern char *dentry_path(const struct dentry *, char *, int);
>   /* Allocation counts.. */
>   
>   /**
> - *	dget, dget_dlock -	get a reference to a dentry
> - *	@dentry: dentry to get a reference to
> + * dget_dlock - get a reference to a dentry
> + * @dentry: dentry to get a reference to
>    *
> - *	Given a dentry or %NULL pointer increment the reference count
> - *	if appropriate and return the dentry. A dentry will not be
> - *	destroyed when it has references.
> + * Given a live dentry, increment the reference count and return
> + * the dentry.  For a dentry to be live, it can be hashed, positive,
> + * or have a non-negative &dentry->d_lockref.count
> + *
> + * Context: @dentry->d_lock must be held.
>    */
>   static inline struct dentry *dget_dlock(struct dentry *dentry)
>   {
> -	if (dentry)
> -		dentry->d_lockref.count++;
> +	dentry->d_lockref.count++;
>   	return dentry;
>   }
>   
> +/**
> + * dget - get a reference to a dentry
> + * @dentry: dentry to get a reference to
> + *
> + * Given a dentry or %NULL pointer increment the reference count
> + * if appropriate and return the dentry.  A dentry will not be
> + * destroyed when it has references.
> + */
>   static inline struct dentry *dget(struct dentry *dentry)
>   {
>   	if (dentry)
> @@ -325,10 +334,10 @@ static inline struct dentry *dget(struct dentry *dentry)
>   extern struct dentry *dget_parent(struct dentry *dentry);
>   
>   /**
> - *	d_unhashed -	is dentry hashed
> - *	@dentry: entry to check
> + * d_unhashed - is dentry hashed
> + * @dentry: entry to check
>    *
> - *	Returns true if the dentry passed is not currently hashed.
> + * Returns true if the dentry passed is not currently hashed.
>    */
>    
>   static inline int d_unhashed(const struct dentry *dentry)

