Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117CC6FACE0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 13:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbjEHL2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 07:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbjEHL21 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 07:28:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93743CD86;
        Mon,  8 May 2023 04:28:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348BIu7u023861;
        Mon, 8 May 2023 11:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=0cOTao+NGOdbydKGXm3KDCg3tNHwAhLYSQvMiwg469s=;
 b=PIIQU+Ag0FCgo46JhF/Pax2esjh9HQAquITFVkoJI6YP0Pqowo3/Ol+EGVRim5n8RcRz
 E4kEap2Q/6Ho+ZKdM0LRLb813igKPbBi/aWPO0EuXsGaGGlVp1Z5U58vhI6hKki+FWyX
 urJ4jEa1ESg4cJSALPW7WUiq9lB11F383tbqCmBPQz43SE5jYEl9lf+/m8ysRfbuHcDC
 P60uFT2D5S3z/Buzjqrmms8S4J5q27VSmWrDsSkw1sS8ZHblLCW0v4ZqMGeiH/giclFp
 SLinp3TpFywfJ5BA4LvCJan7fmJFgsPFtcZRqXrk10FtmMPtIl9gZq2m7y+Zab+m7PZh QQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qddae331g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 11:27:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 348AIh9F038474;
        Mon, 8 May 2023 11:27:41 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qddb53mmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 11:27:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ozqz7751uZzv6SB+Y1zfvZk8EczD2GceqVPS8P2vlPxywkYLFGKI1na+CFMlfF6g9H9gKGs6XkNm3TOrF+voT4dM4IZbJTT8qXslU48zB2BxjKhAEeLniEFCtRNDNJ61YVQSFvUcHbeCEGpHSc+C2Vnuo4dN3bsJj0bPdAMhdRCwEX2NKXHoBQDouEhVtPrt7//Igis79uC0UV44QtLAr5IA5cX9Qpl8PvtSlYpfE+/g/a3+KiSh7wG+CeT6yPRELpzMggsRTrIjFjwsMC8585EdJ+SDMiDw+V1I8a0CsarWYQZMVZfbBMwhkDydAJtf3PRDhsOngrYATXCfRWeaNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cOTao+NGOdbydKGXm3KDCg3tNHwAhLYSQvMiwg469s=;
 b=nMxlA4MOD7YIa+PS1zs4YuwUrJdtGCixhgko/ah28WFM+BwmlDpvnY/NF4a9ouqEH3nKWwd58jFY4dROCR5gndhkCu+QLGY2QK5ql3Pnw5g/aGY3H1YrUj9mR58RxgsYzNIFhDV90luoamDRb4HYa7SWvDaH7q/6NZbPHSJF63a6QEnaoAhJk6VFbbV+ZskqsjgiWg3U4Q4Ics+ijGEWMRA38yeYE4cOvGq7hfEt+7px0vhy+UwbbfL5aYP/3fEFu5jxGSgHWyG8r5jlzKYQFFhv9dLB0XWPzlA33b4N3QSLxVegSoQgm6OCV6utSmeKc3v2AsGxRCF78opnvl0iKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cOTao+NGOdbydKGXm3KDCg3tNHwAhLYSQvMiwg469s=;
 b=SBYwHy03DQ1RfuWsHHm+41Qag0a5t2PCYwXdw2UQMtOQUNI38xkaii2869+UdThggbAx/GJN+XPTQsCpyuyK5zVJIzodeQyq4/Ii93JbVIrOXcmsptHnGUSVuVc9qtBwZFqxNJ6lZQszhiZWaG3FFafhhb7vWpw3sFRB08m/kgQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB7409.namprd10.prod.outlook.com (2603:10b6:610:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 11:27:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 11:27:38 +0000
Message-ID: <9839c86a-10e9-9c3c-0ddb-fc8011717221@oracle.com>
Date:   Mon, 8 May 2023 19:27:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        nborisov@suse.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
 <2892ff0d-9225-07b7-03e4-a3c96d0bff59@gmx.com>
 <20230505133810.GO6373@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230505133810.GO6373@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e1f948-f7c0-43b8-b5fb-08db4fb73a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FFt12NRowSsY1/+Ft1rvnScspiW75o3x3QPNhGnx3eS7LhJKWgaiPsv+6i3K1qW6WPxHumWZl80PixdGV0L+sQneUqNBYIMghJw/7tqR8InytyvisESla9Nadn/PeE8xIk4hbwTZwqZKMgbrmlZITo85L33AfktsdWN8N/vDPCcjDndPmKBdECJVGsbn9f+MlVkD06GLNB5oI7EBXFEaYI1Kz1lpWolNgJ+UWlkLPeNc28JTXNHKaBQpg3CvrpXeSYVOl5hsZyQkJFWBruh/BDcekD7PTGB6M4rKHb+VtmOnVSqEVThQ2S2vHjbD7QAcR3EcZ33M6B6zDOhQ/Byxa3c8hKLOmshbGBO+a9YuDdlZED6hYZpzPNwjxsKHdYXpH+d8CfpZrCMJJg55jVsp6DTXIIA7+JdKsqkr88VfDzcOye0SOKCKEQFFV49tDzBTLCskj7RDn71/cu1ZDgXbZtl5b77PLcJ2vTlQRhVMgEet/lH0cGHW2RtpChuPMbopAdJZA8anxbovPt/eSTn2Xio9i6+LWUDfjD/YxocDYwBJOyQ89moFoInz3obGtZ8+hoY1sCR0lFJqbX+Ksp/cQ4jbyoz+Q9baPmE2PzmbDpxp7Io00nPN/awB97iEsdiT1NhRA0cAbx1VRflpUZZh3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199021)(26005)(6506007)(6512007)(53546011)(6486002)(83380400001)(36756003)(2616005)(38100700002)(86362001)(31696002)(186003)(44832011)(2906002)(8936002)(8676002)(316002)(41300700001)(478600001)(7416002)(6916009)(4326008)(66476007)(66946007)(5660300002)(66556008)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amNRL25LMllLaTkzeVpxeGhwa0hSY3lidnJYQjJJT1Yrck9rK2s2RkdxM3U4?=
 =?utf-8?B?dHg0UmxPeCtjbVRWVmdoSUJYYm5Oczd4QWR2S2lXVG0yMUtzc0ZwNEQ0Z0dX?=
 =?utf-8?B?Nk8zV093aHJ1TWZ3WkhMdS9LTzh1RkRDT3BCeUhCTWl2aEdncEoxV1BPbER5?=
 =?utf-8?B?Y01xajc3KzdpTSs1R3BmZ2VRNG9xMUo1S3JTbS9pYlVyL29lTEkrbkMxSlpW?=
 =?utf-8?B?UXJpMkhDVGxQWWJDOFZTT3gvYUM0M3k2MFlFanJUejZDcWtKVlBCWGtRbVI2?=
 =?utf-8?B?MWVWTXhVaHZlL1ZuY0paRGVxVmg1clowN1JEMDA0cng2SmJjL2ljYW1NR3JG?=
 =?utf-8?B?K3VzcWlQWFpuWGxQdGtKbTdZSjNNUXZleEpvbGhmWkZGcStaNkR0WFJqcUdy?=
 =?utf-8?B?ZmdzMkFjL2hvM3pYTkE0QnhQN0FIMnJwVkczYTI2cHB0OGNxZndobVZBZXc3?=
 =?utf-8?B?VVpRYld2b1JYN2N2aC9UOGZKODVVU3R0M214REEyc295NjBuUVUzNFBHTlNB?=
 =?utf-8?B?SlNieENCQnVqYUd3alpMeWVKZnkrTkw1UWNxaUhpVTdxc3Y2MWE1b3VRR2FZ?=
 =?utf-8?B?bVhtT0t2eWlReTkxTGhjRmdKbDc1SFFPbXFsN0VxbmRudkxzVDBPbUFnVXJ0?=
 =?utf-8?B?R3VQVW82Y3BIdmhtRFJUZWhpVUJSZHJmdEl3UFdkcFJnY2xreUNIeG5DNG5v?=
 =?utf-8?B?VWxEVW9idXQvWDVuQjV0VEtEc1Zuc0xnQXVmT29jSlBpM0V4dkZvRG5UcDdJ?=
 =?utf-8?B?dmhhd3ZObWpFMlJZTEc0cU9RUExuS0l6M2RFejVFekZ2ZEdVcnBaV3FueG5Q?=
 =?utf-8?B?Q1FnN1Q5Unl6Z3FTRlNaNkxQb0N6NUlrUUhtQURxWWFRNm54WitDcW1IcmtX?=
 =?utf-8?B?dFg2a0hmeHUyTmRPNUJPZnFydmUvWHNKK2tSY0pFWDdJcjVSTFViKzhIUW94?=
 =?utf-8?B?d2RVUTFKMWFYVFBnV05LUHpXVWFKUXhEWERBdWRyTjZjNUo4TU1EaHdsSUVv?=
 =?utf-8?B?RkZqVnFpQUJobmZudm1YV3pOZGNidEVIMmE5TEtsdGdRK256V1kxclF3dXdL?=
 =?utf-8?B?YU9vdDQvcGhrNTZzZUtoNFRnOVNZWGpJRGMrNEJCN01kOGo5STFFQ3F5Y2pP?=
 =?utf-8?B?dy82dlRZZ2dWcUhzVDNsTi9TRFZFTDBBWUlNLzhMNGNiTkdZZmo1Ly9ycjAr?=
 =?utf-8?B?ZjJSYXA4UlBBZXpkYUtNdGgxSGY3NEJzaUdveGw4L1hHQlJxL1E2REhvM3JZ?=
 =?utf-8?B?Y0ltRzkzaHk0Q0cxQWtVTHhhbitUMGV4NHFscGVSNkk3QlM1ZkcwK0FWMU9E?=
 =?utf-8?B?VFY4ZkdNdzJuMnZjUU9rTWU3Ym9RTzB1NW5weC9PVWFLT0o4aVFpZ08wcERq?=
 =?utf-8?B?U25pSk9SK0RoeGErUmtxUXlBaExJamhEM083a3VaMjVnVGtLeHdETFpWUFJa?=
 =?utf-8?B?Zy9yODBhM0hpWVlnWnYwLzZQMyt5QmVJNm0xdXVhek5YY1hyZGJZNlR5S3FJ?=
 =?utf-8?B?MnpQWWNDZmNTOUhQRWl3NEZTZ3ZuWTYzQUFjbks4VWZNbWh3OUcyRTcrWW95?=
 =?utf-8?B?QlFMNElGNlN3SVNKS1dHWjhlZStLdzc4MzVhNEtacUI2WWRBME12b2huWjZE?=
 =?utf-8?B?ek02akFtVTJwSVZKcEhrbkk3ZmxwSnpHeTBHU3l6bHRWMUVNVnZ6T3N2NXQ1?=
 =?utf-8?B?bTNrSVdNbDRMRmtWNVRMSnlMUUJkNFNZT2gvNWxiZkFwS2JsTWZJa1FBWllk?=
 =?utf-8?B?c0xrdHdoa0ptMERNalczTUZvSjZuV01jOTAreFBpejZtTlhqS1oyV2dkMmJi?=
 =?utf-8?B?Vi94RGZ2S29LbmVxaGV0L29FT2Zqc2w4N2Z1R21IRjEzUlZUUUh6QXBDQjNr?=
 =?utf-8?B?YmNKdmxGNWZTTmlWSHI2dTh5UjdYdVAwZXM1MTBwREpydzlwM0NxaC9hOFQr?=
 =?utf-8?B?Tk9MbU9zRldIS1JHZWlMcXBKOWJpV2NXc3BDbWI0RDR0MXBhOVE4aUgyb1ZG?=
 =?utf-8?B?WXZZWTFublFhRGMyZG9rV3lHN3JudzFDbTBPb3I2Y1l0dmtjaDdnVDZwZXdM?=
 =?utf-8?B?WHRna3BvbmxXbnUrZnk5STVpQ3BjMk1QMnFWL2ZRUWVJbnBUYWw2S3pzYUhw?=
 =?utf-8?Q?Rk4CEQaIgULF60b/k4JnYqsOE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d2N6c21RQ3V4cDlnTERVWnBCa3ZsMGtzZFYyTVVCSEJnOTFNcENMcHN2TXNB?=
 =?utf-8?B?WnczaHp6UGYvT3RMdEFpcUVOVUl5ZU1lYzFMQ1B2UE9paG1zalV3OWRxQUVZ?=
 =?utf-8?B?akhpeXFhVm9XWWdzZGZNTE1GVEtQRFdFR2I1ZWJxWENWZmFJR240cmRoZTBY?=
 =?utf-8?B?citTVkFlYWI4Z0xoSWtxRUhXRXJ1RkFQZko4bmV1eHJnWWw5U0lXckthYW9V?=
 =?utf-8?B?aE5ObXBaZ0wvSWNZVENBYXBkZDNjMEZ5YnRFMVFFUEhaSzIwUmJSZ000NjZW?=
 =?utf-8?B?ZlJ4OWdlcDJ3ZHdFbzNxdks0cjVJOExRK1JrUFBSUVlJYlZTMjJUbTJ0QkhR?=
 =?utf-8?B?RzFXMXJhcXRCWUQ2ejFwaEx6N3cxSUFMQk9EVXNVUVpJYXNyWksvSFAvbVA1?=
 =?utf-8?B?UmZQNG9YbTF6TTJvaGtiN3EzeWhHNHF5YlRLbmVoZnJQb3NuTHJKTlNTUW1B?=
 =?utf-8?B?dTRYU0R5T25oVVVwSFpYU0ljMGNKc3l4RVg3VFNZc1F3Wm1lT2tiTUJLMFVn?=
 =?utf-8?B?aDArelNVdEJjUkxzaVF1N2w2YTZXaFBMWW9mOXo3K2UreEo0ZUxicjlmVjdG?=
 =?utf-8?B?MkFOT3NQNmRIeUYwMk41bkxUaXV3dVZESllqLzEzbmZONDlJa1VsWDBrSG1C?=
 =?utf-8?B?aWxMS2gzWTYrS2F5S210c2pzUmtvUE40SFBjN3NnWkFoRk96SGxZNStSN2Z0?=
 =?utf-8?B?SFJYM0tMSGx3Q09kdW05USttTndWU0thRzBtZ2lLT2xMOW81NFB1ZTZCakM5?=
 =?utf-8?B?bEVkQUM4ZjdkVnpudDlmczhNejFkZnhVM21yYXZUSFB5OUc5cFUyMlBBdWEv?=
 =?utf-8?B?ZEdkT0k4am9lckk3T2JjR1owN0pzWjdPZjhvR25mN0granNaVWV5aUFwbnRB?=
 =?utf-8?B?MEZ6MDJtWlVBNDFSZ2tOYTFIWk1SdXN6SzdteWkvdVlLb0Z2VERzYWFROGN4?=
 =?utf-8?B?eFlRaGVxbG9McHlna1M3OGRxeGgzdXN5MTY5VTk5cTk0RGdpMmRTSjRRTzIy?=
 =?utf-8?B?MzV1WExnT1pScVlFUW0vY09KVUlydFZlWHZDc1FWbDY1bG9wby9OQzFwTW1s?=
 =?utf-8?B?bHkwQ0xSdExhU1NXNUU4WVlheXJwVmZHcmFpNVU4RFlDVTFIRFQ3SitQWEw2?=
 =?utf-8?B?UVFsZmtQQ1FONGd5b2N3dkR6MFJwQ1FTcGtydTR3bFcyN3pHT1J4VW45OWtN?=
 =?utf-8?B?K0Z2bUhQeEc2alY0c2Y0STZlWFZ1Zk4zVVZydnVycDBsckRtV09TaXR1cTJH?=
 =?utf-8?B?MHVjZVcydHpISDVXUlRVaDJleWtRcmMrNDROeVM0ZWo3a3BreENBR05xazBF?=
 =?utf-8?B?VG4rT3QwK25qWklSdzFNWUp4UVhHKzhVTUh4dUlBS0RCcUJqSGR6VG5ONllJ?=
 =?utf-8?Q?blPyFF1IZmmqHzlp6xXgtJyGXOzIzrjg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e1f948-f7c0-43b8-b5fb-08db4fb73a7b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 11:27:38.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Hv9CYfU0X+ORtzpNmjvwGIDOwLn9d4iSDVA6YQWj3Nz+GA14wUcHZleibCKMK1hfA3m5hCrujgXyOpftkok4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7409
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305080077
X-Proofpoint-GUID: RpBeeKNAyRYRgd6g-axSY2I921MB1HQj
X-Proofpoint-ORIG-GUID: RpBeeKNAyRYRgd6g-axSY2I921MB1HQj
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/05/2023 21:38, David Sterba wrote:
> On Fri, May 05, 2023 at 03:21:35PM +0800, Qu Wenruo wrote:
>> On 2023/5/5 01:07, Guilherme G. Piccoli wrote:
>>> Btrfs doesn't currently support to mount 2 different devices holding the
>>> same filesystem - the fsid is used as a unique identifier in the driver.
>>> This case is supported though in some other common filesystems, like
>>> ext4; one of the reasons for which is not trivial supporting this case
>>> on btrfs is due to its multi-device filesystem nature, native RAID, etc.
>>
>> Exactly, the biggest problem is the multi-device support.
>>
>> Btrfs needs to search and assemble all devices of a multi-device
>> filesystem, which is normally handled by things like LVM/DMraid, thus
>> other traditional fses won't need to bother that.
>>
>>>
>>> Supporting the same-fsid mounts has the advantage of allowing btrfs to
>>> be used in A/B partitioned devices, like mobile phones or the Steam Deck
>>> for example. Without this support, it's not safe for users to keep the
>>> same "image version" in both A and B partitions, a setup that is quite
>>> common for development, for example. Also, as a big bonus, it allows fs
>>> integrity check based on block devices for RO devices (whereas currently
>>> it is required that both have different fsid, breaking the block device
>>> hash comparison).
>>>
>>> Such same-fsid mounting is hereby added through the usage of the
>>> mount option "virtual_fsid" - when such option is used, btrfs generates
>>> a random fsid for the filesystem and leverages the metadata_uuid
>>> infrastructure (introduced by [0]) to enable the usage of this secondary
>>> virtual fsid. But differently from the regular metadata_uuid flag, this
>>> is not written into the disk superblock - effectively, this is a spoofed
>>> fsid approach that enables the same filesystem in different devices to
>>> appear as different filesystems to btrfs on runtime.
>>
>> I would prefer a much simpler but more explicit method.
>>
>> Just introduce a new compat_ro feature, maybe call it SINGLE_DEV.
>>
>> By this, we can avoid multiple meanings of the same super member, nor
>> need any special mount option.
>> Remember, mount option is never a good way to enable/disable a new feature.
>>
>> The better method to enable/disable a feature should be mkfs and btrfstune.
>>
>> Then go mostly the same of your patch, but maybe with something extra:
>>
>> - Disbale multi-dev code
>>     Include device add/replace/removal, this is already done in your
>>     patch.
>>
>> - Completely skip device scanning
>>     I see no reason to keep btrfs with SINGLE_DEV feature to be added to
>>     the device list at all.
>>     It only needs to be scanned at mount time, and never be kept in the
>>     in-memory device list.
> 
> This is actually a good point, we can do that already. As a conterpart
> to 5f58d783fd7823 ("btrfs: free device in btrfs_close_devices for a
> single device filesystem") that drops single device from the list,
> single fs devices wouldn't be added to the list but some checks could be
> still done like superblock validation for eventual error reporting.

Something similar occurred to me earlier. However, even for a single
device, we need to perform the scan because there may be an unfinished
replace target from a previous reboot, or a sprout Btrfs filesystem may
have a single seed device. If we were to make an exception for replace
targets and seed devices, it would only complicate the scan logic, which
goes against our attempt to simplify it.

Thanks, Anand


