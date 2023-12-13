Return-Path: <linux-fsdevel+bounces-5823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110BE810D51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 10:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9063C1F21231
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 09:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18613208CA;
	Wed, 13 Dec 2023 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J0hsLGc8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xo0i6cDh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66E1BD;
	Wed, 13 Dec 2023 01:25:16 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD7E98e023736;
	Wed, 13 Dec 2023 09:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=0Nv7RtR6J8R+igSHY8k+kE4lqrEL3I2l5Jz0EXeSu7E=;
 b=J0hsLGc8pGYygvezm6JOGI2Co+EIqr9L+V3y0mqh2nQflCIuYR1+4fJGhrl5C50LpxQU
 bszt5ZSyjLXM8GYeGiLV4bIYMXQgyiGIuczdQe3xtz1ztuV+oI9Arez49ypqwb3hMg8e
 IDXRyyCyr0e3j/P4g1Uqo29lAqOV0DX7vMVYAT1hq8n9y3UzidmHTUvD/Y4OoqD1dIQx
 BPngW4SSo8Q15BeUlq1Bcs6xcR2iYwvFl0IRDXL0L+FjLDsRPn7+XnfgklkVEZOeD/AZ
 Chec5OXbsbqmN7xqe1tuUWQ3iANdFeRNqrkd6Eufhh1cxqL3IY4MlEfeRFQBuxsy0w3X Bw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvg9d7tat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 09:20:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD8W3aq008264;
	Wed, 13 Dec 2023 09:20:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep7x8ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 09:20:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6j69de2YCRqU2sVsVH9Qq2phRcTyDfrVdzf6YfVSwyT8VzWcwEZyGbgAhUTj4ehL17j825a1pxtTMooH7GX4DscxwRFwvyxI5E9TVNQLEHDPkRzeYo5NOE99+fr2mPTUy2QoVIPlaWpjLPUEOvR67s2S3z52RJzSgIpDJ9puKGgDsUYWcaozUpQA+fIFRxdyHOfspi//Xj8pJ5FMxjL4D8OTkmu2Rj1cg4H3Eqrc5rUHiKJQYwnw1hoYjGyC0Y0TqPErfAf5K23GzdboR1eLkKeuNCMt9HJju34nISwA/j7t4NxburMbM90uMBwe/Aj9rE2GnpOrndCOzNCDY6j4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Nv7RtR6J8R+igSHY8k+kE4lqrEL3I2l5Jz0EXeSu7E=;
 b=Ll4v2P3tj0XMWq+XZbRYsbn8uTVbMlAYo4GzSuadoOgC/hnDOCC4z9I9WCLAbrckV2spv85nuw+ZhtoALWEO90VQtDmad074HvHlfGL8RUN8heYWNFQekniMMzh7cOsuanbMIsje5mILK7aGNOWpNe941Q+2KUTNMv31l5iawaRO8zADHHc4m65re21GWZUW0RLaFfMD33NwOSyL51noD1DU5XQ8XD1KezHPZiE4hd8gJptpCOeeUmQ13ZJRX8H8hdNFgxK9AVlDLoBKaw4RqPskQ4iSHvaHh6g8dRl+keZjd4lD4BJamawh3XunCJ05mJNWogxarVw5G40yeeoOgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Nv7RtR6J8R+igSHY8k+kE4lqrEL3I2l5Jz0EXeSu7E=;
 b=Xo0i6cDhrklzk+iFY/349CjjCfQtpPwLFxpwkmT8lGIfxk+EB0zFrFgT5Z/hTjMNCmY6CZVrMJ4xmUOwYvHT+yaCmYH47DKYJiyt26tRC9MDwaOS196wpQ2Kg9Ntwoh3oGo3TqFP1mRS1yfXR4AK74W3v1h/T2jK0EMHRYUiqfg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4661.namprd10.prod.outlook.com (2603:10b6:510:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:20:56 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 09:20:56 +0000
Message-ID: <8e3152c2-6ab6-4761-87d3-e50fc92809b8@oracle.com>
Date: Wed, 13 Dec 2023 09:20:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/7] ext4: Allocator changes for atomic write support with
 DIO
Content-Language: en-US
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <8c06c139-f994-442b-925e-e177ef2c5adb@oracle.com>
 <ZW3WZ6prrdsPc55Z@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <de90e79b-83f2-428f-bac6-0754708aa4a8@oracle.com>
 <ZXbqVs0TdoDcJ352@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <ZXlSR8CTXjkeKxwk@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZXlSR8CTXjkeKxwk@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0192.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::36) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4661:EE_
X-MS-Office365-Filtering-Correlation-Id: 0987bd61-6ac6-4ac7-8ed4-08dbfbbccf8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e8YY+zTrBuxsLZcwfC+R4MrkPLImpb03YQIjpC9kMIAmg24Jh4cdTLwIoEa2PqaI+TWMDebz6EAuO6R28Koa4Ank3v35CHnTU1M2dufz5Ezq7NLR9TH2eAms41I10Lp0ONM3wnuuaQLyxufiDo0iFnLquFfJc+haFlMiSDBvOdnW3o/PgFgHhAKqKSMwmvi66Kg0V5n0zfRMX/5EofJGmBkEab3bHOrSPQm1ddntoHUnaM3cAYxGVw2HBVozgAALoZMqsPbsuxcTXEWjo258c34vo4M21JA/Dy8f48t/2u+nKnmmNABmq/Adv4o4lkJfK0x7jn8DFcN5oxPxvAqXkCS4enQuyXiqaJs0yBtgihQpwWQqJp/N49mSb8ODYN2RlnjDxy8TETMwbVYNBbHUUXVYa1DgnHNc4lQNH672DsLPnoBrol2/S+aWrp+Q/IU3tOdcddl3qI48VR/WbUd35mRW6QMlT7uGy/CSpHSE7xuT3jlVGIlXq19wMhKm+8Su/NYGQtJTEjlhJoYY7A6hPVhjdg+Ou/P7Y2XHotwPt2nHi1ozri1BU5KO4viUEKRSS+xEN79L+LpkCTEHVBqZuHqfXxD7r2rs3ma1+XREr8cMW862scwnW5qk8+9lzMe7
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(66946007)(66476007)(54906003)(66556008)(6916009)(31696002)(36756003)(86362001)(38100700002)(83380400001)(26005)(6512007)(2616005)(53546011)(36916002)(6506007)(6486002)(966005)(2906002)(316002)(478600001)(6666004)(7416002)(5660300002)(4326008)(8676002)(41300700001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VFlZVGFaQUlTNkVValRIUmtGbi9NV3VlOG5tWnJMc1lWcTFJQWlzR2JXMzNz?=
 =?utf-8?B?TThkZEwwbVFkWXpMWkJvR1UvbDBpcEI0bkdqWUJSc0FmZXl2NEN4UlVVcHE0?=
 =?utf-8?B?a3RzWHdkTmovT3JaSXZ1a0EyUjltdnVGQ3VKb2lkMXNSZTJ2dXlKdWVHeVZH?=
 =?utf-8?B?WTFMaHNpN1c5aU83Q0FValRWeTJBeVQ2V2FUVnVZdms0SXVYR2l6SHR6OEVv?=
 =?utf-8?B?cGViR005OXh4ZExPbnMvMnJ2SnVZTXJBbCtSN2o0KzdwRTNsWS9PemlEUFZX?=
 =?utf-8?B?clYvbGJzd09iRCtQUVpwTXVYNHlZbytpQzR4Rldhc1daM2xFME0rQVlRLzds?=
 =?utf-8?B?T2JBMHBFOUdVVlNoNjFMN3lIR0haYWZSdkZuV2pIQXBtOVdsK3pkN0NiRFhN?=
 =?utf-8?B?SDNNL0syRjNmYTF1UWRRZ0FNTUNCNUdCKzhnaUtoczdBL0FDTFBsTkhOa3h3?=
 =?utf-8?B?NnBnRVU4bUFQUFFvTmw3SlRUQlgxS2pQZjZPN0dKTlNuTEF3VzdpVEZqMFox?=
 =?utf-8?B?ZXA1ckc5ZWFZeHI3cC9xbjhON2c3eE9TL0RRNERoMG1VK0x6alpEZ2pOYzZu?=
 =?utf-8?B?T0pXeFF5dHo5RnF5NGZNNjFaREkyZVZlYlBrUENIUEFEWGVJM1poaW1KRWsx?=
 =?utf-8?B?TlNZejFUdm43K3MrTS9NbVFicWxGSDBqQTZMdXpmY0hXU1lJWmMyZWlmOGhS?=
 =?utf-8?B?NlFndk10cXNITEkrT09JOWJkeVdEbjBNcHNoYkNPVVlUaTBmWXZ1THdLSlll?=
 =?utf-8?B?K3c3d2hPRDFlM0h0MmxWTWZhR1JxcUxEQk9ZSDVCK1A3dXUwWTZadEt4cG4r?=
 =?utf-8?B?SGRNekRuL1I3L2NzWTFmNzlmRnpOZUljZFRaREFHbnlYbGhiZ1ROdUp6QTFE?=
 =?utf-8?B?U0Fva2llQm5wamZmTlZRMWNxajlGYkZyS015cE1PM2RiRU9wdG1Mb0VZTXR2?=
 =?utf-8?B?V2dVZlZIY2h5cCtRQlhjSGxkUGYyUy9EcHJmWFVzLy9SRDZCOU1neDgrT0p1?=
 =?utf-8?B?YVpTQXFnR21wb25ZajFQVXVVVHBESU5IQWl2Tlc0SWdBWm51anpsckh1N1lG?=
 =?utf-8?B?S2xCTGIvRXl3aTk5UWRLVW9OU0ZTcDlVc0FwVnlQLzAvb2g0dUhnQjNaQlJw?=
 =?utf-8?B?bVltazZuNmgyRmxudExyU2J3ZXpPSXBYZzY4bmU0eDdkWFlGWlUySmN1YkxE?=
 =?utf-8?B?dzBmVnRuTElZV2phcWxUQkVFSFpiNGN3cHNRbStIcmJNYUhVTlFQb2E5SWJs?=
 =?utf-8?B?cGowVGkyK04wYVZvYTllYVY4MkFQMmc0UGg2d0FGSXFMdlVQTDU2MGlzeDI2?=
 =?utf-8?B?ZjBVRmxzazVEM0tSMzZkZXYvZHdMWFlGNkFrOUdpYU5uWXdYQWsxcXJZYXls?=
 =?utf-8?B?RUJCT0FZQWpyak1lTDdTWEQva2R0d29JRmFIdmQzUmdNODhGRWh3Y1FYZU5E?=
 =?utf-8?B?Nmt4ekZPM25UaFZ1RTVaMlZlWTNVVDUzbWN3T2NBTTlPYlRKRHpXZ1dTL04r?=
 =?utf-8?B?Q3pkRWVBRWFmL0RyR3ltTXJBWkpXaERVTWczaEtYcG1sYlFidU5Mem1TdktV?=
 =?utf-8?B?OXp0NnM0bS8zVXpRWlA1TzN2ZlUxTGVwM3E4Z1dKaXh0UzBBVmtHbjFCVWxP?=
 =?utf-8?B?bDRSNThzUTlHcnZMWUQrWDJZU3ROVFdiZ3BpUWEyczl6b1dTL3FEWDRibkty?=
 =?utf-8?B?ZjkzQS9vSHpUbTJSd3EzMkg1V01MZHgrOXhubXloOUZwSG02KzRhanFhTkNR?=
 =?utf-8?B?dFVBU3F5UzNJaTVWYTR3bDVqWndGT0hMZzhLMk92dUlxMzdNTGlYTllRUFdT?=
 =?utf-8?B?ZzI0dzlRMVUxNDNkUUIzK0RZMi9IWElqWkc0RjZoekZYcmJ6ZlZIcG5Eczl2?=
 =?utf-8?B?cGRYVkU4cUl5R2RkamhnRmNCVnVFdndIOUxJUm9sN2pMTEI2SDM1S2ozMy9u?=
 =?utf-8?B?eCszODhNa09KNkdZTDVzcW1ncmV0R1RsbEk2ZWY4MUdkRlNHWldxRUZJMldz?=
 =?utf-8?B?KzFRZUhWUG1ZcmpJUk0ybWg4aG9Ca0I3K3VuR0gwWlRuTnRtZDZiZkt0RWdS?=
 =?utf-8?B?UmgvSk5UbzY4K2Nud1JUZ3RmVDMrZW1tUk5oWFRmdk0xd08zNUFVREF6K1NC?=
 =?utf-8?B?ckVjVWxXenhSWGo0ZGdDT21hbC82YWt4R2hocVBOaitmckdIbzQ4TUdSVkxw?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lP38EhjpiZMvj/pDM1cBZx+DdeGuP5L2tCgbR0rOITsVKGGhrp5rG+5ItxtFiSpfouU6e9/MBzx4GckrCwlPIxro6ZwccqTVPwr0Y+IdhX4BRwwJgYRBxr2HPcmWX7MySDjpKue1xxu1X9RIPl4RSkbe03g/7C1ee/U7c5Ib1AzaoPux0Z5YvkKbT1JxkHC6m6/UN/1dB6mRsDdMedn7DJuOqdFZkynlHFPJbvlmS5Ni6KbfVnsAVrbVyLh5x4AGpd7kE+wBz1ICZkR4iFUHVM4WTuDh+EX3vituScL+3e1kAaFhL4eb16lcx7IFvz52nUXrLGcmVPHE0aKeygRj97+Eb8x4WxZcur5TIcsCOM1gQK5MuHwNsyVSU211676OSlTBOvumpBJ11OzpWcqVeAOhstR4qf3op3VVJ81hMmqmRSEOYK7sI7LsN64ywbfPe/t/Jo2PysHoMU9FOj2u0WPfklwl/YBCveFA2E4MsC4VqW9CZ+UUJmO/k0cQ9O5jQJfor4FRVtGlHZagj0EswqP2VFR056y65Vx+JLfwi9oBB3c8occYMCh99QomFLUxekaQ+HgiVzsojUNepTlw/4MMC72UtuPJNW4A06s2l+c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0987bd61-6ac6-4ac7-8ed4-08dbfbbccf8f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 09:20:55.9930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiSurL0lXLQMDvE+PLPWFh3T5vGOAoAQ6KBLSARGTGH3pReHM4FLRqpZmxWuOHtMR14Yglqvgz1vl1D5y3Fogg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_01,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130067
X-Proofpoint-GUID: hgfbMLSnBXl68s8mg39Vd9mcD9M4bmHh
X-Proofpoint-ORIG-GUID: hgfbMLSnBXl68s8mg39Vd9mcD9M4bmHh

On 13/12/2023 06:42, Ojaswin Mujoo wrote:
> Hi John,
> 
> So I don't seem to be able to hit the warn on:
> 
> $ touch mnt/testfile
> $ ./test-pwritev2 -a -d -p 0 -l 4096 mnt/testfile
> 
> 	file=mnt/testfile write_size=4096 offset=0 o_flags=0x4002 wr_flags=0x24
> 	main wrote 4096 bytes at offset 0
> 
> $ filefrag -v mnt/testfile
> 
> 	Filesystem type is: ef53
> 	File size of testfile is 4096 (1 block of 4096 bytes)
> 	ext:     logical_offset:        physical_offset: length:   expected: flags:
> 		0:        0..       0:      32900..     32900:      1: last,eof
> 
> $ ./test-pwritev2 -a -d -p 8192 -l 8192 mnt/testfile
> 
> 	file=mnt/testfile write_size=8192 offset=8192 o_flags=0x4002 wr_flags=0x24
> 	main wrote 8192 bytes at offset 8192
> 
> $ filefrag -v mnt/testfile
> 
> 	Filesystem type is: ef53
> 	File size of mnt/testfile is 16384 (4 blocks of 4096 bytes)
> 	 ext:     logical_offset:        physical_offset: length:   expected: flags:
> 		0:        0..       0:      32900..     32900:      1:
> 		1:        2..       3:      33288..     33289:      2: 32902: last,eof
> 	mnt/testfile: 2 extents found
> 
> Not sure why you are hitting the WARN_ON. The tree I used is:
> 
> Latest ted/dev + your atomic patchset v1 + this patchset

What commit/tree is ted/dev exactly?

Anyway, my v2 series is at 
https://github.com/johnpgarry/linux/commits/atomic-writes-v6.7-v2-blk

I'll try that later for ext4.

Thanks,
John

