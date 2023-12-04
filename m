Return-Path: <linux-fsdevel+bounces-4762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD358032E0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 13:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB7E1C209C4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 12:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD08E23772
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hQ6hDs2e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QGcIxdZW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45888B9;
	Mon,  4 Dec 2023 02:43:17 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4AZ5Iw013596;
	Mon, 4 Dec 2023 10:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=OmUuag0Qg08MEHBxj6pqWh7E6KaKOQZFiU009QSgG2E=;
 b=hQ6hDs2eY551xQbKck8lXl21MjIQ3DWpzE91erihLDPHXTkZq/EleXArXEWalRVdcThG
 tR6yqt88uysU9RlfuHIGBSM4wzVQRep3c/lwhOD+I6UQMOTB42eBgGJl3/aoXal9uxc2
 FgAWrZDJ89GKeUXQ4JXx4XN9lOEe9nLB8V/omjhmmFMImjtaSoVV7jnzrFGPXvDTGOZH
 qofvm7QXNTr+X3+1k4k+AmxxHpBe6NjM8xa6IUeY6bau840Cw8itqB/BVW2vGNrU8kE+
 80obBj2jMWa4t0pyiSddJWuje54Bff7AK+HPC1KjXBkh7H/03dki/rODaFXRrxSNGFQq dA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usd41g153-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 10:43:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B49FiSu020749;
	Mon, 4 Dec 2023 10:36:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu15n7y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 10:36:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGd4wrjidRMae2eYn/XSygMnmdsmoxRBZdgcrd2aXmfcDBeKI02oj50TOTUs56pmyjtzIsyO4TrRr0Ac49ggaCxQ0/ZZIWyHEpr0sgvGXJa4QFU6gcND8X5hGNX3ahKodnlEawfWvDAPVOnNCHyS8vnJfzxvoMPn/Hu2t69cVXjrpjLa0Pu/walR46vIr4S0mxyVoRG1CMJd0tyrufOOjL1DW+VQsUF5uFl4QUV6vhhrm4TPoHGCh6rQJ51N6LfHtAsn1S/PT60SdCqM/a7IcFHreYOLHW3Mveyo1GcXSmnYMxOdDHGxebSfaCFbfMCpTfEFVKD3Qmp3RvQET7qTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmUuag0Qg08MEHBxj6pqWh7E6KaKOQZFiU009QSgG2E=;
 b=Ne4OfYpIp6AOrsW93OI3t1h4q2/fgPJVqtDIStzie41M/L/0kPiUB/xsm1l3u5mFLLtt7OhvOzZQDvzGqdcLKBJAnWdYQJpa0z3bj/PzjybImcRzFyCo1LCJjNdzWNV8E3xylpRobIa6VX/e19aQOkt1OUx897lyAQoiJXDcpuzDfnq6/xJdNVfhq2Tg8xFE7fJdfczi53QcAaDGnxRZQFQeQ0nPjhf28aKaZ9NpKygQWPsXj/e4xxQt8PleDBkFyTamL3jFou9gfinP3prSHST1tohW6qsXaNwA4HsIXiSpfoXcGrCBvnqGgY6fIPvVX38Uz46Z0No6p0g082mOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmUuag0Qg08MEHBxj6pqWh7E6KaKOQZFiU009QSgG2E=;
 b=QGcIxdZWC2eJDEx4y9Tpor6LhilGvVAjDAfb/NJFWFkzmRjlX54otGiy7E8zmcLeTD1cMnkzcREIZtvutf0ebG/XAJVxA1prAiHzz3z36wY2UhtmPkCDKES9xFEPbxMZT7GvN05ng+Eqoy9K90QMYDsj/rwtAyCnpmj9eWctXU0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV8PR10MB7726.namprd10.prod.outlook.com (2603:10b6:408:1e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 10:36:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 10:36:05 +0000
Message-ID: <8c06c139-f994-442b-925e-e177ef2c5adb@oracle.com>
Date: Mon, 4 Dec 2023 10:36:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/7] ext4: Allocator changes for atomic write support with
 DIO
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <cover.1701339358.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0020.eurprd04.prod.outlook.com
 (2603:10a6:208:122::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV8PR10MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 0429fb91-2e18-48fa-b9fc-08dbf4b4d1ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eTwvVwjTmBa/bEKRm8/izu/1UpI1xaUlSQ3jbqQq5l8EBNLzOufthRN9TOK7/aSFMhbChGpC6NRCw6r4k7QRa9zdUdWL/QPCdPhrB4mdxaNz/UkaPljFe87h+LTPjWRXpEew63PhDrh1/jNOS2Vjf56TpiHdEAb9desU6uXVdsZ7Yh2Utt5XxLeuS39JCCS8z/MTo+0RVGJmL9dZ9RGlGjifz0XH3fZjWBBQ9BsE2cPSXx14CyuxlpMofwTb5DnlsZf3NkFZCgXuvOye2sfii0MFFRuqmA2Q8tyb9cHwVtU6uALBvFJY+C8ELQhud+aYULvOSaO2/kc57QoBgxsGURmFD+3Ww1FPnT7aRWbGVPlaI62wsim5/MKEnxmL3HPKRaY/LgMp+3dO0/MQt6qVpazWLRw1wK6FDexIxvPEMgciY5mtzjLRN1FERy+TG66cWDlH2lnQeyFbmdEOuun+PoDGL11uQ/1FooLs91Ba5HuMvANOCKKFjE9hOWi/rnJoaBhObIrUstoumdrA3dUlI/f/vabj+gVU5ITHZMTa3kQFgoZAFnyHLa6faf+tbEnta2GEgShddmjPE9CXF2u6cSIGRu26VT8RnlgQLDChOafJfSDGm69tpan+rp9i4PXfaw6QNPxZ5iuFiS1j5v2wQPkHaC3k9q9G+AuAieHOBVr99KtH6uYN45Sguw4NIBR6
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(230173577357003)(230273577357003)(1800799012)(451199024)(64100799003)(186009)(41300700001)(31686004)(6666004)(31696002)(86362001)(7416002)(5660300002)(2906002)(83380400001)(4326008)(66476007)(966005)(8676002)(54906003)(66946007)(8936002)(36756003)(316002)(110136005)(66556008)(45080400002)(2616005)(6506007)(36916002)(478600001)(53546011)(6486002)(6512007)(26005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d3F6d2dhNE95UkJzMUtFZmw4bUpJdHVhWitlbkxHa3AydkVLTWJuRHFZdnQv?=
 =?utf-8?B?djFnNldiSERjOGIxaE9hM0dEbHJ1WWczMFdaeDNqbmVHMEVaNHlVZXBYWW1X?=
 =?utf-8?B?L2NDWjc4bjFTVmlMNkdYdCtLQWkzcTRQaEJWSGtVNzlBTWxReituZlZOS21P?=
 =?utf-8?B?TVNLOXhYejk0ejEzZ25DUjJZc3dDMmZUSkE5SVFpaUp5dUZoYzRqNmFLRTRx?=
 =?utf-8?B?OEJ5cWUveVNZNFB5N25qVjNRb3AySnk4OGZRdHo3MUx0ditHY0wxWU9jYisy?=
 =?utf-8?B?TUNxcnRIYVNxL0xqVmRtalFvVDJVMmZNbEpoeE9USUh5V0dmTDAwdUtSeldM?=
 =?utf-8?B?aEVCdUlUSzdmdFN2V1g1d1N3RjY1TzFwdjBSRU5teFlXdkZpRlRzN0U0THVC?=
 =?utf-8?B?VVZrNWlkZU16L3dhL0tDQmYxKzNUbmxJMENHQ3gveFh4eHlDK3RPeUZBN0Rr?=
 =?utf-8?B?T0l5cXFTQ0ZrWGZmWnY3VXFOQmtkS0ZqdW9YOWhzeStKVHp6TnVqVDJGeVdt?=
 =?utf-8?B?NVZZbEFaZzB2STlhQUg0YmZTZ3I3U2ZvQW1GUFhZUERYc1hvSEhyZHVXRFpr?=
 =?utf-8?B?dFVrNExwdXJXUmQ1WjczSXlDcGFsN1pSakMxQmhMNjFwWkQyN2JoenhTSTYr?=
 =?utf-8?B?U2pmVUtWcG12SGZnSU4rVmtLdTBGQnAzdkkvdVNXNmNRVUFJQklPcjZjY2Jm?=
 =?utf-8?B?WWJCRnpScmVPait6N3ppSmc0RHk1SUdPcmlyaFZZWkFYLzVVbUw3VWpQeW1Q?=
 =?utf-8?B?QitUZmdzVHF3TjFjRWlWTU1tZGliR1NjWDlHV1NHZEVBTE0xa0VjMFcvb3VC?=
 =?utf-8?B?NUMzOUN2dW1qUHJuQ3dHWDVqWUdoY1dndVRFR0tRMVVXZmxobFdYTjRMTmJQ?=
 =?utf-8?B?Y0orR0UxY2o3c0V2RXozZCtiSTUwQXVBUTErUHdHMUJ6Vm9QenpLdUFsZENl?=
 =?utf-8?B?aFZiWFFJdXVwR0xPeXVHbTFZSHU1WE12Z0pXNUYyMGt3NGxnZDlGNmdLRjVt?=
 =?utf-8?B?dU56anZYM00vUzc0NFM0MjA2NHpCUmU0NkRtVzhMbWtyb3pUSmdVRHZrT0x4?=
 =?utf-8?B?RGczT1pVZmhwaWJ3VGpBeVQwejgxSEpzMmE0RVNBLzNTSlZtQ0VtQlZYRjJY?=
 =?utf-8?B?RHQ0bit3S1dUSzBCbXNpWEN0RjU0TjBzUk8yakJWekNIMFN6UWwvckZ4bmtn?=
 =?utf-8?B?MDlSc1BCR0hkTGd1bVJBSS9rQTNVY2ZZLytENCtjR1NXR1VWSnZlcmUvdnM3?=
 =?utf-8?B?Z3BCZFFsZVVFdXNwZUF2eURPem5ZbGtqVXh3ejFVa0NtQzJYYjVjT2NlYy9r?=
 =?utf-8?B?VTlaVVRNSWFWNmN1ZjhpYnY2Z2FOaGlKUzV1c0RMUkxGbm96OTVRSGpxY096?=
 =?utf-8?B?TlZSbmtOUytLUlhqbmVhSzRCaVN3ZEMzRzJrQkpNa1JseFhQdWlwOVZoeDFE?=
 =?utf-8?B?NkV5ZWE4NmovcGxxeGlCRmpzaFB3aFU1Y0lTQVZCSHdCMHdDSUdQRzhmbm56?=
 =?utf-8?B?cnFYeW1uaWtlTDhEbUVXQ0hOK2MrNS9CcCt5T09YKyttV1BkU0JvUVlGNFdk?=
 =?utf-8?B?TVZBck1yTkc1VnZkM2h6eEdMb0hnZUxxMVFaV3dUT2ZGRlFqWnhCakFncXNM?=
 =?utf-8?B?R1ZhbjkyTjRkc05DVnA1ZFFQZWhOUzVNcFg1azRaWitnSS9RcHNtaW4va3d3?=
 =?utf-8?B?czB6K0NTTUl2aXpqTjJRVkhpUGN1ZlRxNG5sK2dSRDNjc1NxWDBaL0NGN1Bi?=
 =?utf-8?B?U3prTWkxV1JmY2E1UWx4T0RRSTJlN0s1VTRFR2c5bndRcDlFTTVuMlpvKytZ?=
 =?utf-8?B?S2I5TzJsaVpjYTVRT0o2cXdHYXNqYzBMaGhkVnlsSGdPalZPVVd3M0Zqa2R0?=
 =?utf-8?B?Z1Q3UkIxbENGV1JrTm5jeE1ydzdvdTVzejhZNmI0UmFkakpocG9xaVpXeWZr?=
 =?utf-8?B?WSs2T3BsTWtnZU1aaU5kWFBVWVUyWnFablNBWFhWbDEvK3BJWk96UnhrN3Jm?=
 =?utf-8?B?b3hsR3FuSS9vdzZKRVNqT01tc3d0Z1lXczZLekc0OTJQcG5OTm1LaWVLc0p6?=
 =?utf-8?B?L0NscFRKUUJhbklQaDVqYS9oVUZIZm9KcDNpb0twTHh3TFRLVEFZVTg3Y1ZB?=
 =?utf-8?Q?uF5y6TNCNPKDr3h24atEs/sLL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	csS7oqGw1NdiV91J2nIpmF0H5yXnsUigcvqWAYvNFS7kyu8CRxgxEvDU7D/ZelSPtvbOeUaJWcS9Fp9WygfoKzQAb0YFAG6fwpLM8Nu8avcnveAPSpt8YFf/GICpi5XvY+i3yYNpdJ8dVDihjAElSviuBGOrWY3m3UWZQbhWSNaHoeuKlRvVi7T+ZCH/DOtirCQtvMC7lzRIj5kncpcM2sJinss3FRkrsWOWwNHuKAgeeeP3Ynap7uls63LWZLSBzsWv++acM7VDj9NCOHjgZBRikKekz6n6t9sRmfuvC6Q4Es4NZ8l9qm3h05t8UfzXY3dBSYKsMaMCWLFlScy46/1If3nkiLIMwWVpmL+YHG/1+4la4+6DDs8ElLMgPqBVBmTNZmSIskIiycGVxrX7Tg+/UJaFJNytakmpfDDnwj+t3THE2aJrB1Ow5SxnICBpz7N3ixTa5b9EmsI+iQm/jKUEoA7/A8v/R3pyWguKEvbFkaYez4eanT01XuLCBiG1JV1Knhy3K9SJB5dEcIr+BSLyJryZzfjQLpj/WTRvi++hTRGCPiPTXPO8VrbcDnrnWpG+gdUYwpZ8u4sAtsfCcpJ/E0pFGAXjw0IEauHPnDjl/NgVyAzkwQj7HIf/NVsNpWjbZDR945mr3lCBnmyVzFhXJ+gXqmWW7Sc7hZOUShzi+djV4PnzxW64x3MsEJYx+JgaNCa3z+Lacm2EY+g6THnevjndpVJoYoreimZ9uAr8rmA5oOyCkbsiurIk4+HKrvyYAABvvQ5zsJE5r/BOQug9LkIZm7CpZNGmnjPZypwIdJw10e8fXVlpIUCvkCmzFVMBcYjzyQTt9QIO7bgP+jGUt0/YcGfQPoFErBtGDp1pfmZ87bt+JzvdK5zLemNBQp99KcnXtLicCWt9GZTvJz2bqnOoUWLvv4z5gebKw7w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0429fb91-2e18-48fa-b9fc-08dbf4b4d1ac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 10:36:05.4092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmYuzbGNT084Ft2NB00C6levC568X6efwE43jCUOU75iRL1jhc+Gc+e+94r+Ij+buOBDZ3OnLvxkDMrGYVREig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7726
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_06,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040080
X-Proofpoint-GUID: 7x00_rw7p0PEvOFz--OvXF5H16Skauaq
X-Proofpoint-ORIG-GUID: 7x00_rw7p0PEvOFz--OvXF5H16Skauaq

On 30/11/2023 13:53, Ojaswin Mujoo wrote:

Thanks for putting this together.

> This patch series builds on top of John Gary's atomic direct write
> patch series [1] and enables this support in ext4. This is a 2 step
> process:
> 
> 1. Enable aligned allocation in ext4 mballoc. This allows us to allocate
> power-of-2 aligned physical blocks, which is needed for atomic writes.
> 
> 2. Hook the direct IO path in ext4 to use aligned allocation to obtain
> physical blocks at a given alignment, which is needed for atomic IO. If
> for any reason we are not able to obtain blocks at given alignment we
> fail the atomic write.

So are we supposed to be doing atomic writes on unwritten ranges only in 
the file to get the aligned allocations?

I actually tried that, and I got a WARN triggered:

# mkfs.ext4 /dev/sda
mke2fs 1.46.5 (30-Dec-2021)
Creating filesystem with 358400 1k blocks and 89760 inodes
Filesystem UUID: 7543a44b-2957-4ddc-9d4a-db3a5fd019c9
Superblock backups stored on blocks:
         8193, 24577, 40961, 57345, 73729, 204801, 221185

Allocating group tables: done
Writing inode tables: done
Creating journal (8192 blocks): done
Writing superblocks and filesystem accounting information: done

[   12.745889] mkfs.ext4 (150) used greatest stack depth: 13304 bytes left
# mount /dev/sda mnt
[   12.798804] EXT4-fs (sda): mounted filesystem
7543a44b-2957-4ddc-9d4a-db3a5fd019c9 r/w with ordered data mode. Quota
mode: none.
# touch mnt/file
#
# /test-statx -a /root/mnt/file
statx(/root/mnt/file) = 0
dump_statx results=5fff
   Size: 0               Blocks: 0          IO Block: 1024    regular file
Device: 08:00           Inode: 12          Links: 1
Access: (0644/-rw-r--r--)  Uid:     0   Gid:     0
Access: 2023-12-04 10:27:40.002848720+0000
Modify: 2023-12-04 10:27:40.002848720+0000
Change: 2023-12-04 10:27:40.002848720+0000
  Birth: 2023-12-04 10:27:40.002848720+0000
stx_attributes_mask=0x703874
         STATX_ATTR_WRITE_ATOMIC set
         unit min: 1024
         uunit max: 524288
Attributes: 0000000000400000 (........ ........ ........ ........
........ .?--.... ..---... .---.-..)
#



looks ok so far, then write 4KB at offset 0:

# /test-pwritev2 -a -d -p 0 -l 4096  /root/mnt/file
file=/root/mnt/file write_size=4096 offset=0 o_flags=0x4002 wr_flags=0x24
[   46.813720] ------------[ cut here ]------------
[   46.814934] WARNING: CPU: 1 PID: 158 at fs/ext4/mballoc.c:2991
ext4_mb_regular_allocator+0xeca/0xf20
[   46.816344] Modules linked in:
[   46.816831] CPU: 1 PID: 158 Comm: test-pwritev2 Not tainted
6.7.0-rc1-00038-gae3807f27e7d-dirty #968
[   46.818220] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS rel-1.16.0-0-gd239552c-rebuilt.opensuse.org 04/01/2014
[   46.819886] RIP: 0010:ext4_mb_regular_allocator+0xeca/0xf20
[   46.820734] Code: fd ff ff f0 41 ff 81 e4 03 00 00 e9 63 fd ff ff
90 0f 0b 90 e9 fe f3 ff ff 90 48 c7 c7 e2 7a b2 86 44 89 ca e8 f7 f1
d2 ff 90 <0f> 0b 90 90 45 8b 44 24 3c e9 d4 f3 ff ff 4d 8b 45 08 4c 89
c2 4d
[   46.823577] RSP: 0018:ffffb77dc056b7c0 EFLAGS: 00010286
[   46.824379] RAX: 0000000000000000 RBX: ffff9b2ad77dea80 RCX: 
0000000000000000
[   46.825458] RDX: 0000000000000001 RSI: ffff9b2b3491b5c0 RDI: 
ffff9b2b3491b5c0
[   46.826557] RBP: ffff9b2adc7cd000 R08: 0000000000000000 R09: 
c0000000ffffdfff
[   46.827634] R10: ffff9b2adcb9d780 R11: ffffb77dc056b648 R12: 
ffff9b2ac6778000
[   46.828714] R13: ffff9b2adc7cd000 R14: ffff9b2adc7d0000 R15: 
000000000000002a
[   46.829796] FS:  00007f726dece740(0000) GS:ffff9b2b34900000(0000)
knlGS:0000000000000000
[   46.830706] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   46.831299] CR2: 0000000001ed72b8 CR3: 000000001c794006 CR4: 
0000000000370ef0
[   46.832041] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   46.832813] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   46.833546] Call Trace:
[   46.833901]  <TASK>
[   46.834163]  ? __warn+0x78/0x130
[   46.834504]  ? ext4_mb_regular_allocator+0xeca/0xf20
[   46.835037]  ? report_bug+0xf8/0x1e0
[   46.835527]  ? console_unlock+0x45/0xd0
[   46.835963]  ? handle_bug+0x40/0x70
[   46.836419]  ? exc_invalid_op+0x13/0x70
[   46.836865]  ? asm_exc_invalid_op+0x16/0x20
[   46.837329]  ? ext4_mb_regular_allocator+0xeca/0xf20
[   46.837852]  ext4_mb_new_blocks+0x7e8/0xe60
[   46.838382]  ? __kmalloc+0x4b/0x130
[   46.838824]  ? __kmalloc+0x4b/0x130
[   46.839243]  ? ext4_find_extent+0x347/0x360
[   46.839743]  ext4_ext_map_blocks+0xc44/0xff0
[   46.840395]  ext4_map_blocks+0x162/0x5b0
[   46.841010]  ? jbd2__journal_start+0x84/0x1f0
[   46.841694]  ext4_map_blocks_aligned+0x20/0xa0
[   46.842382]  ext4_iomap_begin+0x1e9/0x320
[   46.843006]  iomap_iter+0x16d/0x350
[   46.843554]  __iomap_dio_rw+0x3be/0x830
[   46.844150]  iomap_dio_rw+0x9/0x30
[   46.844680]  ext4_file_write_iter+0x597/0x800
[   46.845346]  do_iter_readv_writev+0xe1/0x150
[   46.846029]  do_iter_write+0x86/0x1f0
[   46.846638]  vfs_writev+0x96/0x190
[   46.847176]  ? do_pwritev+0x98/0xd0
[   46.847721]  do_pwritev+0x98/0xd0
[   46.848230]  ? syscall_trace_enter.isra.19+0x130/0x1b0
[   46.849028]  do_syscall_64+0x42/0xf0
[   46.849590]  entry_SYSCALL_64_after_hwframe+0x6f/0x77
[   46.850405] RIP: 0033:0x7f726df9666f
[   46.850964] Code: d5 41 54 49 89 f4 55 89 fd 53 44 89 c3 48 83 ec
18 80 3d bb fd 0b 00 00 74 2a 45 89 c1 49 89 ca 45 31 c0 b8 48 01 00
00 0f 05 <48> 3d 00 f0 ff ff 76 5c 48 8b 15 7a 77 0b 00 f7 d8 64 89 02
48 83
[   46.854020] RSP: 002b:00007fff28b9bff0 EFLAGS: 00000246 ORIG_RAX:
0000000000000148
[   46.855178] RAX: ffffffffffffffda RBX: 0000000000000024 RCX: 
00007f726df9666f
[   46.856248] RDX: 0000000000000001 RSI: 00007fff28b9c050 RDI: 
0000000000000003
[   46.857303] RBP: 0000000000000003 R08: 0000000000000000 R09: 
0000000000000024
[   46.858365] R10: 0000000000000000 R11: 0000000000000246 R12: 
00007fff28b9c050
[   46.859407] R13: 0000000000000001 R14: 0000000000000000 R15: 
00007f726e08aa60
[   46.860448]  </TASK>
[   46.860797] ---[ end trace 0000000000000000 ]---
[   46.861497] EXT4-fs warning (device sda):
ext4_map_blocks_aligned:520: Returned extent couldn't satisfy
alignment requirements
main wrote -1 bytes at offset 0
[   46.863855] test-pwritev2 (158) used greatest stack depth: 11920 
bytes left
#

Please note that I tested on my own dev branch, which contains changes 
over [1], but I expect it would not make a difference for this test.


> 
> Currently this RFC does not impose any restrictions for atomic and non-atomic
> allocations to any inode,  which also leaves policy decisions to user-space
> as much as possible. So, for example, the user space can:
> 
>   * Do an atomic direct IO at any alignment and size provided it
>     satisfies underlying device constraints. The only restriction for now
>     is that it should be power of 2 len and atleast of FS block size.
> 
>   * Do any combination of non atomic and atomic writes on the same file
>     in any order. As long as the user space is passing the RWF_ATOMIC flag
>     to pwritev2() it is guaranteed to do an atomic IO (or fail if not
>     possible).
> 
> There are some TODOs on the allocator side which are remaining like...
> 
> 1.  Fallback to original request size when normalized request size (due to
>      preallocation) allocation is not possible.
> 2.  Testing some edge cases.
> 
> But since all the basic test scenarios were covered, hence we wanted to get
> this RFC out for discussion on atomic write support for DIO in ext4.
> 
> Further points for discussion -
> 
> 1. We might need an inode flag to identify that the inode has blocks/extents
> atomically allocated. So that other userspace tools do not move the blocks of
> the inode for e.g. during resize/fsck etc.
>    a. Should inode be marked as atomic similar to how we have IS_DAX(inode)
>    implementation? Any thoughts?
> 
> 2. Should there be support for open flags like O_ATOMIC. So that in case if
> user wants to do only atomic writes to an open fd, then all writes can be
> considered atomic.
> 
> 3. Do we need to have any feature compat flags for FS? (IMO) It doesn't look
> like since say if there are block allocations done which were done atomically,
> it should not matter to FS w.r.t compatibility.
> 
> 4. Mostly aligned allocations are required when we don't have data=journal
> mode. So should we return -EIO with data journalling mode for DIO request?
> 
> Script to test using pwritev2() can be found here:
> https://urldefense.com/v3/__https://gist.github.com/OjaswinM/e67accee3cbb7832bd3f1a9543c01da9__;!!ACWV5N9M2RV99hQ!LbVSb-43597CLDmYnhgOwH6MAcikusRh75-4fUbUrA_8go3B6JL1lWJPmhij8siPJE031qtQb6-bpdLEa1qrVA$  

Please note that the posix_memalign() call in the program should PAGE align.

Thanks,
John

