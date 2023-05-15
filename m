Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2BC703B77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 20:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242603AbjEOSDM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 14:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244366AbjEOSCy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 14:02:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923D91886A;
        Mon, 15 May 2023 11:00:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGnIKs022649;
        Mon, 15 May 2023 17:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=oahQUZhQTTjJlE7L131g2B2yMfNhktH76sdM3nNkHsc=;
 b=xGmU3Ook+lICPKBx6VA3zGAB7CllArfvFxUOwMYmLR6a8n7bYWE1Dr09QI+rveyLIIwo
 YL2RmOd3vvipCxMAGhy6O/M11f8rZSTjQylIjAMIOirefo4OZmC7D9lHna6a18Njwqn6
 yF7lihaC5mm6CLKKadUESCuf/jQVxIRNI+yVeoN/MQfpiZ5kyFz9/71s1gM9sTo5BzGO
 1FgAtvqf9MbNPP/ZVgHo9xrSau/NgQkVN94tnorOzZIFNY9FnUc2CbB9dvhoR5J4D7My
 OQs0+uxEsIw2k+Wj5+CO+iEUDoLkVai4I5P2DnV2OWzI5ayOjEukA0ufxfAB7oigIKWy ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1b3ru42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 17:59:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGnYhJ022343;
        Mon, 15 May 2023 17:59:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj1098p8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 17:59:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNBpAxweHEnGvt8Z4a/GBAWMfQnGRmWf5okQMNXKjJ58Kps9kIZYRrBxtNHzrCEJ05gx8KlMEUTw7F+zHXkZ9Rn7En9omufLscL5FecRf8PNCfFSTe4E/EKvCSqJKeJVeA/IFSPpFi9T0YheJiYju/zudtl0lV6hSs7gmFQe6xzgKNqy86Ullae4n4Vm1Ce5B4dEG4nS/CXxawTasVJo9aCjMnCYkXV+qRw1ihW0h81KX4zT8U3xajmO8CEgj85bU/p9FBTprnnER3vpdqH+gx8FB1oV0hvfSCaqhhX+y8Mh171hcZrTuw/jcvriiAKGC+3WUCAXiY37ntiMOQZHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oahQUZhQTTjJlE7L131g2B2yMfNhktH76sdM3nNkHsc=;
 b=ZL+Rs3AX3qZXI1FWZZbT/EV+fRTKzx7EbDjqCJxK/Mbf09AsO2CiSvNcJFZJI5yCIsDqPtN31ZcjYyoC8Jrdb19C65I5FcLyp9D283Cz7vSOg5UoAqFcYkef6ZoPF1cvxgF897D8Ts2nFkdcOI3ydbzZB5oxuX9+Xvj3yQ5fTQTA+SwZG3eTkPPcgm/2JGGIPTFcxMGsJy3+qyfaWhAmK9ICZnWl8N27hmgqhMTrVdbR9jh6kZp1W/TzN3RQfII6PM3UKRqq1m4bZ4zeZeyAF2ReEt4gfPCPFqgon+1QWcuAvw9bXJm2B6qNVBgX8pKGWG0h/ixqNbkzFHsgvq/0bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oahQUZhQTTjJlE7L131g2B2yMfNhktH76sdM3nNkHsc=;
 b=DYsn6FU9KIfrneNN7HMVY8FgdFo2UG/L8Fkmigud5hTI9zPIHATT5tooxtZwzOq3f9O4zL8F37LKdIXhkJ4rriPpNKU7Gq+zOTGdsiGrLYM0f1936/avsKsiy3bMHJMhTdu9rGrbxTWIbhOWB3+PSGhTUXOwSy9QWzRcmo1lI9Y=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by IA0PR10MB6745.namprd10.prod.outlook.com (2603:10b6:208:43f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 17:59:53 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%7]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 17:59:53 +0000
Message-ID: <a62a7592-e1ba-1c27-67cd-ea6be0fd4a0d@oracle.com>
Date:   Mon, 15 May 2023 10:59:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/4] NFSD: handle GETATTR conflict with write
 delegation
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1684110038-11266-1-git-send-email-dai.ngo@oracle.com>
 <1684110038-11266-5-git-send-email-dai.ngo@oracle.com>
 <0dcd16bae001b3cbc51337e360341f9efb35470e.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <0dcd16bae001b3cbc51337e360341f9efb35470e.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0042.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::16) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|IA0PR10MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f2d794-9394-4462-f43b-08db556e2f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z45Gu1/J6noItWk5/sG3fquoEzDEkNzb4KiowR7nLIEwkiyWWkJvR1n+FVoKZwfTTp5aNo1LcO3ahoVHC03sqw1jwtnKJnC8Iw5w09/mWaqE9Cfjg40bl2Izy5LJiLZfTAPuwLhvv0EomDq0nD0Y0MdsCq8IOaywLGT/9tkJvls4HD47FsJQBAid9RWI24TVkoFwMmfD2kgjwKJhBDWkzHhxhCjO/cdQ+cRiZYrMnXXv5AbtbEQ0jzQp3ujaeq2ddRpECKWQ8JGXw2sxziDnhuO0Oqsf8RHSrTz+M3KczVxQ/ll+Njxi86A2l4e8H7z0H1ldCO3f38B1N0DgcknM0HuCUf1wHOT42AJH8+67k1MV9Aa6xmAj5iX5LiIOiQCEFPfknKE2LnvP6asXMTec4GZEnIetHnB5QOEnaCouOyXLIp1Xui3Xx2LWAVyY6v1AD4boeOPJb/GcIYvxkAkuQea4uLqZEXmYyHZHO5QMbl9XC5EjzJ74qeyPQDhIb6mh0IAj+R5SY/0tKKz1ZED55WG9qNoaRJiWigb2ZFA9/WZwlRPUwQMns2jvaUVNUumPNyZfORqbQ18AHlOT3WaHEU9iA9AGoP2NMBFs/6Mywfwj+maeWUUbcNVWn0gTCuDc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(66556008)(66946007)(66476007)(41300700001)(31686004)(4326008)(6512007)(26005)(6506007)(6486002)(38100700002)(316002)(2616005)(5660300002)(83380400001)(8676002)(8936002)(2906002)(478600001)(86362001)(31696002)(186003)(9686003)(53546011)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU5PSkUxRlhJRHNSaDdiUTF3dEZCR3NTVTk2QjQvbkRVNUU4N3FjWElCTzR2?=
 =?utf-8?B?RVgxN2phTExsb2V2UkZZN250eWREdEtBSjJLSlA0NGFOdDdVRE00a2tGRnZk?=
 =?utf-8?B?NERRNittVnRqL2Nsa3RzUUxxTmEwN3RnZVZoMTE5a0FZQ2pKRHc4S1E2UlRG?=
 =?utf-8?B?QUZmVUJZeW1taXJGeW1EU1Z2RGRGSHdPaDFYWFFWQ2RkZnkvT1NmVUxKK0wv?=
 =?utf-8?B?dmttT3Rmd2dOUVVqYWVyaUNFYXdkWks4Y2l6bkNOSkZvcCtXVTl2S2NVbmZv?=
 =?utf-8?B?bERCbTZpUElPbzU5Y0I1QWsxOW1wdVdHb3ZNRjBmeWRRNVcyN2tBODRTcHI5?=
 =?utf-8?B?VjhiYzYzc2ZNLzlRZXJ4Nlc4RDZXRmpCNWZzaGE3ZkQvSDdOanp4L3JKc1hH?=
 =?utf-8?B?N2VJSHlWOTVTNXBVeDNtVC9HazJXZktOZkxyajRRME5DSjlieGMzaDlRN2hW?=
 =?utf-8?B?QVo0TG5qYUNZdGZ4VEI5TDdLQllxcFp5OWhFZVlaMjZhbWtJMWtLQllXRDhx?=
 =?utf-8?B?cndiWURnY0dIRDBUTWlKV0hwNlV6VmJNNC8vZEY3QTJ4bjFPbkZpYlZHdUg5?=
 =?utf-8?B?WFdsdjFGTjhBdU5oNE5BWkNBcDFVZ1JBK2hNTU5KREJWYUpKTCtrbGdoNGdx?=
 =?utf-8?B?VExKckZYZHhQVVVXQmNtaEpZclh1Y1RPdENraDhlTWhFSnBOcFFLS2xFZnA3?=
 =?utf-8?B?M0dsazU0WCtDdk1PaUg2TWU1VmRMdG5LcmZqYXdnYXpicUZsQ1VVRGNNSjM3?=
 =?utf-8?B?MStlV1NuVy9aL3U0TFh1dTNpTG82TUU5elBSY3VtK2F1TmtRUkhlV3VwekpC?=
 =?utf-8?B?MWZsazVGVk13dFprZWFuN2FQOUpTa1krS0IxZGFzVUR5b2tMbkpFRU5ST1dm?=
 =?utf-8?B?VXhDdEVzNEFobzk4ZFZWZjV0eW5iSFJqQVMyWVE2M053czRoWk81V09sUnpO?=
 =?utf-8?B?ejU4Z0xWdTdsS3o4alJ1SzNPTnpsMXVPNXhWNGJJQWVxR2ZBdGR5UVB3aGZ4?=
 =?utf-8?B?NWRLT1ZyMko0U2gyeWRNVmVUMklYdjB2STBUUHh5OUh1UEk3aVV4ZkJLOGZR?=
 =?utf-8?B?cnRnekJwVXJ3d3JTQkJ0QUFZdGRmNW9IUkh3MmNCTGJOYkp5T090K3lsTjdE?=
 =?utf-8?B?UnM2UjhqTC9Ca1lGM1JOL1owbkpMd0NqbWJEeks1RVcyRU9BaVQyVzhwb044?=
 =?utf-8?B?aEcyNHV3clpud1VLbWtoSlZIMVBqWmpmVEJDcTFPSHZKeDhmOU9iS1VKZEs2?=
 =?utf-8?B?ZDBoSFBHZU43RjhhbjBIMjc2YVdyTk5uVVdjZDFoWVJiYTN1WFBzbXRIdEZz?=
 =?utf-8?B?TER6YkRZTGVMRURLRG5ScVlHTkc3R0h6UzRscGF6Ulc5dDRTaW9URGhRS2Iy?=
 =?utf-8?B?OHVlYkNzdDR3MnVtVmpYRlZUcmhqdVhpLzVDV3hwam1xODNTSU1xSWJ3RzJz?=
 =?utf-8?B?azVKdXpjTjdFQ2MxN2lxNm9NdEtnMmdWZE82bHRpQm5WUHNsMDRSVVdQdzIx?=
 =?utf-8?B?eURWWnN3Qld1aC9vMHBjTDB1SStRRzZ4bStTY0x5M3R5NXA1anhESUF2VkZC?=
 =?utf-8?B?N2pGWDg1dWNoNnA0TytidUhNWEVjWlNVMkt3a2wxVC9yVEtxUmltNnJhNENO?=
 =?utf-8?B?RVFKQk92TmEvVFVVYm54OW14eWM3OGpZRDEzYmEwSTdaQzdBaUJMeUhvcTgx?=
 =?utf-8?B?dmJ2TFQwcjY3TFNncXU4bU11WW56bVJJWmtadzU3VHdTdGVmMFczZHAvWWE2?=
 =?utf-8?B?WFpOWmszbVA1dlhGYm53eGZwU1NHVU03RkNQMkZJQUsyc0NKK0c1RnNNOUpL?=
 =?utf-8?B?V0h2cjE3bHg5aWkrejQzdk9VRlk5Qjc0azdHOHFVOTFydGxVRlYrK1VjMFVF?=
 =?utf-8?B?M1l1eXowU1Rvak14TWYyaGtWWFd5RVdLR2pPb2V1cGdKc3FXNGwrUXZpYjBz?=
 =?utf-8?B?RlIxOUdtcUE4VEZoUk9PbWM3VWZBU0d6dW8wa01TdEpHbVlFTTBCSmQ1OHpI?=
 =?utf-8?B?NHlEajgyWnc1L2hLQlFsZjVKMFQ2K0NLcEZiYWxwTGhRSlQxcms3c3V3bG9v?=
 =?utf-8?B?Y2VHK0J0dHZQZG5RdTVScExQNi9MRWVQcGRvZFhjeit5TzZzczB4R1pLU0Vs?=
 =?utf-8?Q?Akdu9VTjHef2VnDPbgTMXFuXS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: clmJRLRLIkIDJzdUq5sAPaH0Jg0T6hZJvQnrXlytlcDcQQTXaBZyrCGki0JCk8A5GzGHr4NV3iFOtoSTQcEkgCkoRivzx98DQyiih1YskAu7k/s8kuRA+XHIdt0tRQrc5cNpNYz4NeCwdK11o18UGClBqb1Sv4RL6Hd4WC115FBwler2MRm6h33hGkg7ax/3dBI3mCybJG05Lz7VFy46/7kuU9Sm5w7ZH6vjMeenPLHvVO0onjBGTPP9/xcHMgR6t3Ddhnk1kx20QF2xoWfLObJonBsYYghl6MhAitP/al0C1aBjNMfUeLGDDGkKlK/anuIrMtz6+1d3f1Yd8n03ea0svUjYGMT45fKYZlj5hFnFHn6HpqNRneinC5HXraZTJ4LJhSsM9CCWMMKASghYj5MdXp7n31zYmdPxtYsKbM6PZAG0SRopYX0xZyr1+1fSjzswjfMtj2rbGKnsIoJb78700lPTykiKYAt2wG60sAX3LhkAIH4tRTuwy1sKXUOfOrx4xL+Lj80exvFmaVgEMB3SL4XaXKHT7kTRFo1JBru5AmtT60sFyufwex3Sj5aopmmnv7yoRYJXiUe2FZGCvO7MkxG7gWdU+9BILY9fWDnwvtOwFPoU5tmdt5NQNMohhE8AIg0teQjCZZMNT5IJcLR6Uz4oln3N/nQJZBxHJt1DXccN+f+B4w22lK7UilgtGyxUFe5RvZFCB+s5nSn1RKE4Yb8sjCke91eb8DgWAz1ECaY3e2ED8sYb+dZzEq5wywsZ3OT+uW8vzMZ4auyparjId3ZS0+kOCFCOCLZ7jfg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f2d794-9394-4462-f43b-08db556e2f7a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 17:59:53.6072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aR8pEHeC6DllJaN7NbbYW4tg08XJs/L0udOxWH45/9aOiAVDJWl5YF9x1uaEiUzSSQeJH9St6X664GDQAb+lAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_16,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150151
X-Proofpoint-GUID: GZ2rTKBV2Xlp8oaLM1mbuTOKAkr4fh64
X-Proofpoint-ORIG-GUID: GZ2rTKBV2Xlp8oaLM1mbuTOKAkr4fh64
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/15/23 4:51 AM, Jeff Layton wrote:
> On Sun, 2023-05-14 at 17:20 -0700, Dai Ngo wrote:
>> If the GETATTR request on a file that has write delegation in effect
>> and the request attributes include the change info and size attribute
>> then the request is handled as below:
>>
>> Server sends CB_GETATTR to client to get the latest change info and file
>> size. If these values are the same as the server's cached values then
>> the GETATTR proceeds as normal.
>>
>> If either the change info or file size is different from the server's
>> cached values, or the file was already marked as modified, then:
>>
>>     . update time_modify and time_metadata into file's metadata
>>       with current time
>>
>>     . encode GETATTR as normal except the file size is encoded with
>>       the value returned from CB_GETATTR
>>
>>     . mark the file as modified
>>
>> If the CB_GETATTR fails for any reasons, the delegation is recalled
>> and NFS4ERR_DELAY is returned for the GETATTR.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 58 ++++++++++++++++++++++++++++++++++++
>>   fs/nfsd/nfs4xdr.c   | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   fs/nfsd/state.h     |  7 +++++
>>   3 files changed, 148 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 09a9e16407f9..fb305b28a090 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -127,6 +127,7 @@ static void free_session(struct nfsd4_session *);
>>   
>>   static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
>>   static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>> +static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
>>   
>>   static struct workqueue_struct *laundry_wq;
>>   
>> @@ -1175,6 +1176,10 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
>>   	dp->dl_recalled = false;
>>   	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
>>   		      &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL);
>> +	nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
>> +			&nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
>> +	dp->dl_cb_fattr.ncf_file_modified = false;
>> +	dp->dl_cb_fattr.ncf_cb_bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
>>   	get_nfs4_file(fp);
>>   	dp->dl_stid.sc_file = fp;
>>   	return dp;
>> @@ -2882,11 +2887,49 @@ nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
>>   	spin_unlock(&nn->client_lock);
>>   }
>>   
>> +static int
>> +nfsd4_cb_getattr_done(struct nfsd4_callback *cb, struct rpc_task *task)
>> +{
>> +	struct nfs4_cb_fattr *ncf =
>> +		container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
>> +
>> +	ncf->ncf_cb_status = task->tk_status;
>> +	switch (task->tk_status) {
>> +	case -NFS4ERR_DELAY:
>> +		rpc_delay(task, 2 * HZ);
>> +		return 0;
>> +	default:
>> +		return 1;
>> +	}
>> +}
>> +
>> +static void
>> +nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
>> +{
>> +	struct nfs4_cb_fattr *ncf =
>> +		container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
>> +
>> +	clear_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags);
>> +	wake_up_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY);
>> +}
>> +
>>   static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
>>   	.done		= nfsd4_cb_recall_any_done,
>>   	.release	= nfsd4_cb_recall_any_release,
>>   };
>>   
>> +static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops = {
>> +	.done		= nfsd4_cb_getattr_done,
>> +	.release	= nfsd4_cb_getattr_release,
>> +};
>> +
>> +void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
>> +{
>> +	if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
>> +		return;
>> +	nfsd4_run_cb(&ncf->ncf_getattr);
>> +}
>> +
>>   static struct nfs4_client *create_client(struct xdr_netobj name,
>>   		struct svc_rqst *rqstp, nfs4_verifier *verf)
>>   {
>> @@ -5591,6 +5634,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   	int cb_up;
>>   	int status = 0;
>>   	u32 wdeleg = false;
>> +	struct kstat stat;
>> +	struct path path;
>>   
>>   	cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
>>   	open->op_recall = 0;
>> @@ -5626,6 +5671,19 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   	wdeleg = open->op_share_access & NFS4_SHARE_ACCESS_WRITE;
>>   	open->op_delegate_type = wdeleg ?
>>   			NFS4_OPEN_DELEGATE_WRITE : NFS4_OPEN_DELEGATE_READ;
>> +	if (wdeleg) {
>> +		path.mnt = currentfh->fh_export->ex_path.mnt;
>> +		path.dentry = currentfh->fh_dentry;
>> +		if (vfs_getattr(&path, &stat, STATX_BASIC_STATS,
> I think you want (STATX_SIZE|STATX_CTIME|STATX_CHANGE_COOKIE) here
> instead of BASIC_STATS. You might not get the change cookie otherwise,
> even when it's supported.

Fix in v3.

>
>> +						AT_STATX_SYNC_AS_STAT)) {
>> +			nfs4_put_stid(&dp->dl_stid);
>> +			destroy_delegation(dp);
>> +			goto out_no_deleg;
>> +		}
>> +		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
>> +		dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat,
>> +							d_inode(currentfh->fh_dentry));
>> +	}
>>   	nfs4_put_stid(&dp->dl_stid);
>>   	return;
>>   out_no_deleg:
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 76db2fe29624..5d7e11db8ccf 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -2920,6 +2920,77 @@ nfsd4_encode_bitmap(struct xdr_stream *xdr, u32 bmval0, u32 bmval1, u32 bmval2)
>>   	return nfserr_resource;
>>   }
>>   
>> +static struct file_lock *
>> +nfs4_wrdeleg_filelock(struct svc_rqst *rqstp, struct inode *inode)
>> +{
>> +	struct file_lock_context *ctx;
>> +	struct file_lock *fl;
>> +
>> +	ctx = locks_inode_context(inode);
>> +	if (!ctx)
>> +		return NULL;
>> +	spin_lock(&ctx->flc_lock);
>> +	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
>> +		if (fl->fl_type == F_WRLCK) {
>> +			spin_unlock(&ctx->flc_lock);
>> +			return fl;
>> +		}
>> +	}
> When there is a write lease, then there cannot be any read leases, so
> you don't need to walk the entire list here. Just check the first
> element and see whether it's a write lease.

Right, fix in v3.

Thanks,
-Dai

>
>> +	spin_unlock(&ctx->flc_lock);
>> +	return NULL;
>> +}
>> +
>> +static __be32
>> +nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode *inode,
>> +			bool *modified, u64 *size)
>> +{
>> +	__be32 status;
>> +	struct file_lock *fl;
>> +	struct nfs4_delegation *dp;
>> +	struct nfs4_cb_fattr *ncf;
>> +	struct iattr attrs;
>> +
>> +	*modified = false;
>> +	fl = nfs4_wrdeleg_filelock(rqstp, inode);
>> +	if (!fl)
>> +		return 0;
>> +	dp = fl->fl_owner;
>> +	ncf = &dp->dl_cb_fattr;
>> +	if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker))
>> +		return 0;
>> +
>> +	refcount_inc(&dp->dl_stid.sc_count);
>> +	nfs4_cb_getattr(&dp->dl_cb_fattr);
>> +	wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRUPTIBLE);
>> +	if (ncf->ncf_cb_status) {
>> +		status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>> +		nfs4_put_stid(&dp->dl_stid);
>> +		return status;
>> +	}
>> +	ncf->ncf_cur_fsize = ncf->ncf_cb_fsize;
>> +	if (!ncf->ncf_file_modified &&
>> +			(ncf->ncf_initial_cinfo != ncf->ncf_cb_change ||
>> +			ncf->ncf_cur_fsize != ncf->ncf_cb_fsize)) {
>> +		ncf->ncf_file_modified = true;
>> +	}
>> +
>> +	if (ncf->ncf_file_modified) {
>> +		/*
>> +		 * The server would not update the file's metadata
>> +		 * with the client's modified size.
>> +		 * nfsd4 change attribute is constructed from ctime.
>> +		 */
>> +		attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
>> +		attrs.ia_valid = ATTR_MTIME | ATTR_CTIME;
>> +		setattr_copy(&nop_mnt_idmap, inode, &attrs);
>> +		mark_inode_dirty(inode);
>> +		*size = ncf->ncf_cur_fsize;
>> +		*modified = true;
>> +	}
>> +	nfs4_put_stid(&dp->dl_stid);
>> +	return 0;
>> +}
>> +
>>   /*
>>    * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
>>    * ourselves.
>> @@ -2957,6 +3028,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>>   		.dentry	= dentry,
>>   	};
>>   	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>> +	bool file_modified;
>> +	u64 size = 0;
>>   
>>   	BUG_ON(bmval1 & NFSD_WRITEONLY_ATTRS_WORD1);
>>   	BUG_ON(!nfsd_attrs_supported(minorversion, bmval));
>> @@ -2966,6 +3039,12 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>>   		if (status)
>>   			goto out;
>>   	}
>> +	if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
>> +		status = nfs4_handle_wrdeleg_conflict(rqstp, d_inode(dentry),
>> +						&file_modified, &size);
>> +		if (status)
>> +			goto out;
>> +	}
>>   
>>   	err = vfs_getattr(&path, &stat,
>>   			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
>> @@ -3089,7 +3168,10 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>>   		p = xdr_reserve_space(xdr, 8);
>>   		if (!p)
>>   			goto out_resource;
>> -		p = xdr_encode_hyper(p, stat.size);
>> +		if (file_modified)
>> +			p = xdr_encode_hyper(p, size);
>> +		else
>> +			p = xdr_encode_hyper(p, stat.size);
>>   	}
>>   	if (bmval0 & FATTR4_WORD0_LINK_SUPPORT) {
>>   		p = xdr_reserve_space(xdr, 4);
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 9fb69ed8ae80..b20b65fe89b4 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -121,6 +121,10 @@ struct nfs4_cb_fattr {
>>   	struct nfsd4_callback ncf_getattr;
>>   	u32 ncf_cb_status;
>>   	u32 ncf_cb_bmap[1];
>> +	unsigned long ncf_cb_flags;
>> +	bool ncf_file_modified;
>> +	u64 ncf_initial_cinfo;
>> +	u64 ncf_cur_fsize;
>>   
>>   	/* from CB_GETATTR reply */
>>   	u64 ncf_cb_change;
>> @@ -744,6 +748,9 @@ extern void nfsd4_client_record_remove(struct nfs4_client *clp);
>>   extern int nfsd4_client_record_check(struct nfs4_client *clp);
>>   extern void nfsd4_record_grace_done(struct nfsd_net *nn);
>>   
>> +/* CB_GETTTAR */
>> +extern void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf);
>> +
>>   static inline bool try_to_expire_client(struct nfs4_client *clp)
>>   {
>>   	cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
