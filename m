Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3DB7487A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 17:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjGEPRl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 11:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjGEPRk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:17:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237831709;
        Wed,  5 Jul 2023 08:17:39 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365Eu5aj010290;
        Wed, 5 Jul 2023 15:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=k2bJ938nudHyRKAShPZjcfDPGQbFlYLFYXl6qIc8ZPM=;
 b=c7t8B6CRihfkJ2T9trEs3K89NiznG/8IQmJBi3tp98xpUsSNW5ZvC/uld2VQ30Bgv8iQ
 LkqgdpWzvaGwntcuhG3Aivm1/1JLGIHkTLJvibj23DwkMpQbUdRCW1yqFOlmxUxnkQ4F
 UebBVtNq6TXrNZ8BOELvQdJIhCIzV/FMjkJLzMIpykVq7qulsvhP034t+bL7k2xosRXJ
 JKEQ1m83HKJOtx3UdJowEx21J1wPUwzSo9xt646vG6FhmkJMYNde7g6C5UyEc5C3IBB/
 AoP+o6oSDKGB/qeUmEYka3zGIQFrXm56aToF7269W0nRhhpK3j6dhjD41p05qHKRsraM xQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rn9ybr62t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 15:16:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365EuDq9024594;
        Wed, 5 Jul 2023 15:16:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak67wa9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 15:16:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jt5rYvuarh2Z2aR121sZ00h1Mift366NCXqDfPf+ifyOhTwTqnNd0aayCzIPZu44dCxbxl6rDiuvbqKKsoKRRAlQ5wpoq4EMFovpg2yl725yRP/E07zmF28e5j1e/0mWSWTKvrEID78s/DUyotur/u49FmknyBq+hWUVtyrSxbgYZC2UF+1++7I7+IrUf9u0btcTlY6bEiN0eUmC30/14k2y8wzdB0SWcvCQfcd7vjsK+ooAkzE1jom1+Xoy+uPrf636gj5rtexjtblDAqyUhPcFP/TLAwtp44VS5roowI+TTth5Myracc+6PuDOsFbsZ9/Zx6Jo/YCWvUsl8NEpKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2bJ938nudHyRKAShPZjcfDPGQbFlYLFYXl6qIc8ZPM=;
 b=Wy8Ek4SfIPdyFAhuIVINjEyqt0TP8/ytUH2SwMtOcVTBBVHFXp9EFEBSOxMyjDXm16NrR8XEOXCxNPSvKQWnZw7WXSehtsahceozhqQ+3mu9zCK41ejb/50f1piQkYrGYq82llnWmfNG9Fu4frwp4fsrqv+78H14XGreYpLlqmjHtmdyoxi2iGhNZlTrsRiNxDcyQAjfwiewAB+N4M+sHRkf9GGFTaHGIB2J/57Q2mDQG4lON59+Q6XrimaudNabkwQB6NUioSpEo7AE0iE2jiRTYOVFSExG6DUEVPHftN5ocUe6/JWAglHS2STNuC2JftahkvFEKqg6RkMEliqQJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2bJ938nudHyRKAShPZjcfDPGQbFlYLFYXl6qIc8ZPM=;
 b=x02NDtATSgLIokCxWvR6+F8dCeaWLDIJdfPj9x+/J/E74eBXG4AenWXhL+hV0NWe+9Ouo0RaIHF6FSTVFljPgOMJkpFMEFfF8WNKYQkIhz0oIbxNA+kaFTAqJXqp13YkwPnPR3tuuhs3YzhTJ5Oi8HlLOmgOeENXtEUywjOwf84=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by SJ1PR10MB5953.namprd10.prod.outlook.com (2603:10b6:a03:48c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 15:16:47 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96%6]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 15:16:47 +0000
Message-ID: <1a7e551d-2419-f783-ab53-037bcab6cebe@oracle.com>
Date:   Wed, 5 Jul 2023 10:16:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 25/32] jfs: Convert to blkdev_get_handle_by_dev()
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        jfs-discussion@lists.sourceforge.net
References: <20230629165206.383-1-jack@suse.cz>
 <20230704122224.16257-25-jack@suse.cz>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20230704122224.16257-25-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:610:4e::25) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|SJ1PR10MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: fd680146-1055-48cf-213b-08db7d6ad939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCPYeBoR60yr8Z7zHkT4Hd4L2d+hquMCnZi6sQhmlewcTUska8R1zyWUXMcgG2jE4/iYuAqDEAN9I7b4Rj8R3BdCeofSCWbiJ+o7MbEe30q+5X5XsMJMiap2kwub/A2mPSgI6NcEivG2ZP3Xsal0+g4eIu+7lZOWxdrZTayLDEx16WC3EcdUEVAoX+0BTo2WGUeNVfJjKyD1e0jteKK9Gx3onZNBmTGrwWVrUV0L0KaSf5R1rh2JoTWYMgkJ+ZtTOn6S0KnbDVcPliOJKxoX8H3JJv73LZhZ+IMl7PJIN1ihtsl2PKG1hfyRZ5e0+XqHCOts68hnH/w3xSBnt7LVztKqxnT/nHOaC9h1KQBa5meCOwPCxlE9wEi90ZUjvbXA+afp0bGfgNSronf+1oqzuA7lgFBSaqfer2MZSb2w8Zi3sP5odISlS1xOasE5EUUT7mGTk39PS9VWX0SJyimvQ7D4Zy0L1cB8hbtoLw7z6/jQxuoFG+HKVRFlTqBKmJrjFjKrrM+0lYLRBv21BSudrqs6FUasHyp5RxtAW/VfcejvYdjoUinbllgTeweXsnR3c/8QyHEtZtmDkrce3dWflKHi3F08/Ll4mf/7Ddj8xykIaoSvQ01yku7ZyZ1Ll/r+M//l5K7UB6UuSg8rd9OsGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199021)(478600001)(36756003)(6666004)(54906003)(6486002)(5660300002)(8936002)(41300700001)(8676002)(44832011)(2906002)(4326008)(316002)(66556008)(66476007)(31686004)(66946007)(86362001)(31696002)(2616005)(83380400001)(6506007)(186003)(26005)(6512007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1pjM3JRRldIbS9mQjNURWxuYmNHSnpCR2tWcW56Z0lPZXFMTWpjMEdrc3Fj?=
 =?utf-8?B?VFEwdUkweUdRS2tmU2ppMVFLNTFPTWlVUW1yYXk1bFhwejRpLzhoVDkxUFNF?=
 =?utf-8?B?OTY3NlZZa1RRMXFHelcxeHFJYytuZDFrMVZ4ZFc3dFpNbitHR0VxeURtNDdD?=
 =?utf-8?B?REYvOXBzQkxsZzVCK25HZVdMd0RJOG8rV2cxZUc3WjFlZGxPS0JKQkxZcWwv?=
 =?utf-8?B?aXNzakwvK3BpUGJQcWVuZU5sY3dkYzY3MnhSRnphSWpUY3NaQ24yQjh1c1dm?=
 =?utf-8?B?OE13Qm9UR3d2bVR5d1huWkpNZlhYRnNBMER0TGFsbUo5Yk0vNW9Pa3IwUlNR?=
 =?utf-8?B?TmhCd2RxRVpVZnNBem01d05pQkZQa2hUVFFVL0NLK0NwY0JNank2ZUg2ZUpF?=
 =?utf-8?B?UmhOYWZXc2VMYVVva2hsVThXWEZvN0hlR1UyVUVDRnJFZllidUFlOHA4bG5F?=
 =?utf-8?B?US9KRzNhL0RlZS9GSFcxa2hnRFRaL3l6N1h2Z2pTVmdoVmV2d3l6d1dMaUx4?=
 =?utf-8?B?SjlrcVZHdExsSG1WSFZnREhOdmJnYVFrQWN5eEFaOUlUQzZPc2F1bG5BRXI3?=
 =?utf-8?B?MllVZGdueWdMUnc0TzdsYjJSTTRMV29NTEFvSkY2RjUzUnNsUXBMOTFGRGhR?=
 =?utf-8?B?ZUJadzlwN0FQY1BSeFIrQmV6bStNbzJESEZlY0cydXRRN2dXZEcwWTlqSHkr?=
 =?utf-8?B?ajZrL2pzcStqdlFacFpONWp5a2ZYOEthWWgzbDFWT1ozQ1BOVjRMVnFpWnll?=
 =?utf-8?B?S1ZOc3hlU1hlTnFqQmZadnQ2Y0Nwb0xBcHRHejIxTis2NEtQbng3QU51ZUh0?=
 =?utf-8?B?U2dpZEZoSWJCYjAyMytBSzJhYk1qZWdrWXhLRWdWU3lBUHB6TkhRbGtPbDZj?=
 =?utf-8?B?Y1ZzU2JzNjlPZUhhYzlxTGxKRzl1R1pjRGJMYmJZTXN3ME45d090MllENkoz?=
 =?utf-8?B?OVU5eHl6WnJKQS9SVHdPU0JzK2l6VXJPVzM3czdLaWxDTWJ0WktaU2RyRWRs?=
 =?utf-8?B?bXNqdGpELzNIWEZJOUZqbkZoVkEzMktvUjVjM1pONFV2cVM0bzE5RE5KY284?=
 =?utf-8?B?Qi9TYmRRMmZ1WlkyUlVrUGhLeXBHTThnZFE5TWtJYXJyenlydXRWYWRDck1D?=
 =?utf-8?B?amxuNk8xL1gvaHRTQzJUWERpTWpZZU8xcWJHSklIbW1wZndQYm55RFVUdFVk?=
 =?utf-8?B?SEtkZStHQndxTVdOK3l0NFZIV0RVT3RnaFcyTEdCVFF6dmhudUhjK1hMRFR3?=
 =?utf-8?B?Tkk0aUt4WUJyc2FtNmFGVEszN1g2VktsWVJRWjBWNnlhb1dkNHBPbUpraGNI?=
 =?utf-8?B?L0I2U2F6WVk2VktjcnF6RFk2T09sVWZYUkc5QW9CQ2FMak5GSlppQk9STHkz?=
 =?utf-8?B?R1ZzWnpteEtBdVdPSHJSajFMZVR1bW82M2NxMFMweWMxTVk5ZW5jMS9nM2JC?=
 =?utf-8?B?Y0o4NGwrTThqNXZEdFNnR1U2TGpJbWZPYUhQYXBFc2xKazhDS1ZCYjRtMmwx?=
 =?utf-8?B?c3dhd0g2TE5jU21NdWVTWEJBNzVUYmw0TXJnaW0vVTJ3ZC9GQWFldGs2UnRF?=
 =?utf-8?B?RWpUcjhYS2lZR0h4aGx5QnFDUUVVYnltV01GMjQ4YTJZUEFaYWJSdTcxVFNn?=
 =?utf-8?B?ODYxY1NiSndiMkIrUEtONGszQlppR2k4NlNiaHpOQjQrcTl6dnltRGFocDVO?=
 =?utf-8?B?SkpNZ0hmclNBSjVMTXZKZTZSbU5KQ3U5WXVURVZwMStGb29kSUd1NHNJYk1Q?=
 =?utf-8?B?OC9Fdm9GTEZJKzB3dFNyTld5Sm94bklhbXp2L0tUNVA2dGdlT2RUSzh4MmJ0?=
 =?utf-8?B?UWVTYUtJeWZmaXJFNzJTT2k0Sm9DUWpHRGJRa1lySnlYeS9uZENyVkV4TnpU?=
 =?utf-8?B?MS9VbVVLNXpFV29lQmpBWEM5blBMK0pwZ1ZKRFdTZnJIL0ROb3EvRVB3T0xp?=
 =?utf-8?B?bFZsVnZEaUU5cTZoWThSbmVSa0lZclBPMG8wMUgrTDJlYlhsKzF3ejkvYnNx?=
 =?utf-8?B?TVlLbDZlR1IweHllczlwSEd1VWQ3OGVkTFdncjhqaGFmaVc1cEpqZytUSzFo?=
 =?utf-8?B?ZjA2UWRuT2plOEExQk9hcTNCSXpZNjQyQ29sMEp3MEJBcjF5TzJ4aEFWV0NJ?=
 =?utf-8?B?dGpWZllWdEtlWFk5SWthZU9yYUhsaStVaUpHNFZuRkFKRlNTcVlxa1NWYk56?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rOqbAoq/hknDbGCBD+fDFbgyNa5pTJk9/P5zNjvZjREVNQYQImzMexJd2MI2fKOifT5D58f9MQ7TWQ/HL0O2Nje7cqrcvgSD/ta3BCRx2IK+E839Ut6/kVuzhqp8JdG+3IFCnbvgshtryxLHLsaorcl4QE+MXzTHyNg4EUl8nhe4gPe7o5XbWTy+9PYoLzqfXNQzzMgByUdV5AH+fKjzhWwZb7v2eIDF9GI+IJhsKhpRvO0u+q3E1I0HrzeuHyaFUaexp4saG7f6DlzlzKqewkbPTSGk1WTus1svQ+F5jN7tZSm0S1At+EYPxQoikGksUAMy9caFQU4/5aeA2c8zX2EXJqMdCbYZmT+iRdPhD9TT8MkPtf0CfoJJQAjcmFJxeh5dp8tF22WxIdkkpd/6t+WID+ADjCtLIaRc8cyPFLaPPhcoy0MaFMYuBc28PJcwWyTkpdfqop1uJYzSdALDIKN+11k+UFvbUwLKe5dPFaD4bMMUCUnA+O2di0lrbVumtVCmUE1Rg53qFDpkxvHJZ9lqOf+g5nIRowOGwIMXpkPit62+9IwPZiO51mjtX2KkpwiAEdTl0UKghkRIjwR4/vbMu/CsxZyyfmugjPyTwsDQcH722yfIKEwUTt+5Nb4rFK2dXtKkPYmjRS6P67Bl2eWAfNA3FO0ph4Pqhy7TCtnXiUL4DyqJfRBgcf9YTcFZihKF0ZeK9velffLzlmvIW6LPwNqNLsJpxI/lRf+2dq1mrI3eWaGzwAy8zQc8JOPWihqBEhk1rg54uIoJrvEVyrqu3lbpYCI+mcHVLe/xkKpefFLOo1O5ylK5YzL7dpN9D78v6yTACSi6PhV5nqNaHW1/diFdEY2/ld71dglK1JGU2ycR03O1UVRcdxO5vinH0QUrafF4Kwn8qR5CBvcxiA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd680146-1055-48cf-213b-08db7d6ad939
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 15:16:46.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vmREIGgMUvYS7Pckgqoiog/w78zrdsYhwazVG0Ww8EkGK+D5H9+rHyXCPJ+9U3eQA/652NAJSVb7C4eIdAaD4KV2H9AdMRKDxspruHUzH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_07,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050138
X-Proofpoint-GUID: 9-GIT2PsUONzCXSHi6ONJ-_RzKSfa9we
X-Proofpoint-ORIG-GUID: 9-GIT2PsUONzCXSHi6ONJ-_RzKSfa9we
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/4/23 7:21AM, Jan Kara wrote:
> Convert jfs to use blkdev_get_handle_by_dev() and pass the handle
> around.

No problem from jfs's persepective.

Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>

> 
> CC: Dave Kleikamp <shaggy@kernel.org>
> CC: jfs-discussion@lists.sourceforge.net
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>   fs/jfs/jfs_logmgr.c | 29 +++++++++++++++--------------
>   fs/jfs/jfs_logmgr.h |  2 +-
>   fs/jfs/jfs_mount.c  |  3 ++-
>   3 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
> index e855b8fde76c..9d06323261e6 100644
> --- a/fs/jfs/jfs_logmgr.c
> +++ b/fs/jfs/jfs_logmgr.c
> @@ -1058,7 +1058,7 @@ void jfs_syncpt(struct jfs_log *log, int hard_sync)
>   int lmLogOpen(struct super_block *sb)
>   {
>   	int rc;
> -	struct block_device *bdev;
> +	struct bdev_handle *bdev_handle;
>   	struct jfs_log *log;
>   	struct jfs_sb_info *sbi = JFS_SBI(sb);
>   
> @@ -1070,7 +1070,7 @@ int lmLogOpen(struct super_block *sb)
>   
>   	mutex_lock(&jfs_log_mutex);
>   	list_for_each_entry(log, &jfs_external_logs, journal_list) {
> -		if (log->bdev->bd_dev == sbi->logdev) {
> +		if (log->bdev_handle->bdev->bd_dev == sbi->logdev) {
>   			if (!uuid_equal(&log->uuid, &sbi->loguuid)) {
>   				jfs_warn("wrong uuid on JFS journal");
>   				mutex_unlock(&jfs_log_mutex);
> @@ -1100,14 +1100,14 @@ int lmLogOpen(struct super_block *sb)
>   	 * file systems to log may have n-to-1 relationship;
>   	 */
>   
> -	bdev = blkdev_get_by_dev(sbi->logdev, BLK_OPEN_READ | BLK_OPEN_WRITE,
> -				 log, NULL);
> -	if (IS_ERR(bdev)) {
> -		rc = PTR_ERR(bdev);
> +	bdev_handle = blkdev_get_handle_by_dev(sbi->logdev,
> +			BLK_OPEN_READ | BLK_OPEN_WRITE, log, NULL);
> +	if (IS_ERR(bdev_handle)) {
> +		rc = PTR_ERR(bdev_handle);
>   		goto free;
>   	}
>   
> -	log->bdev = bdev;
> +	log->bdev_handle = bdev_handle;
>   	uuid_copy(&log->uuid, &sbi->loguuid);
>   
>   	/*
> @@ -1141,7 +1141,7 @@ int lmLogOpen(struct super_block *sb)
>   	lbmLogShutdown(log);
>   
>         close:		/* close external log device */
> -	blkdev_put(bdev, log);
> +	blkdev_handle_put(bdev_handle);
>   
>         free:		/* free log descriptor */
>   	mutex_unlock(&jfs_log_mutex);
> @@ -1162,7 +1162,7 @@ static int open_inline_log(struct super_block *sb)
>   	init_waitqueue_head(&log->syncwait);
>   
>   	set_bit(log_INLINELOG, &log->flag);
> -	log->bdev = sb->s_bdev;
> +	log->bdev_handle = sb->s_bdev_handle;
>   	log->base = addressPXD(&JFS_SBI(sb)->logpxd);
>   	log->size = lengthPXD(&JFS_SBI(sb)->logpxd) >>
>   	    (L2LOGPSIZE - sb->s_blocksize_bits);
> @@ -1436,7 +1436,7 @@ int lmLogClose(struct super_block *sb)
>   {
>   	struct jfs_sb_info *sbi = JFS_SBI(sb);
>   	struct jfs_log *log = sbi->log;
> -	struct block_device *bdev;
> +	struct bdev_handle *bdev_handle;
>   	int rc = 0;
>   
>   	jfs_info("lmLogClose: log:0x%p", log);
> @@ -1482,10 +1482,10 @@ int lmLogClose(struct super_block *sb)
>   	 *	external log as separate logical volume
>   	 */
>   	list_del(&log->journal_list);
> -	bdev = log->bdev;
> +	bdev_handle = log->bdev_handle;
>   	rc = lmLogShutdown(log);
>   
> -	blkdev_put(bdev, log);
> +	blkdev_handle_put(bdev_handle);
>   
>   	kfree(log);
>   
> @@ -1972,7 +1972,7 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
>   
>   	bp->l_flag |= lbmREAD;
>   
> -	bio = bio_alloc(log->bdev, 1, REQ_OP_READ, GFP_NOFS);
> +	bio = bio_alloc(log->bdev_handle->bdev, 1, REQ_OP_READ, GFP_NOFS);
>   	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
>   	__bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
>   	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
> @@ -2113,7 +2113,8 @@ static void lbmStartIO(struct lbuf * bp)
>   
>   	jfs_info("lbmStartIO");
>   
> -	bio = bio_alloc(log->bdev, 1, REQ_OP_WRITE | REQ_SYNC, GFP_NOFS);
> +	bio = bio_alloc(log->bdev_handle->bdev, 1, REQ_OP_WRITE | REQ_SYNC,
> +			GFP_NOFS);
>   	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
>   	__bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
>   	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
> diff --git a/fs/jfs/jfs_logmgr.h b/fs/jfs/jfs_logmgr.h
> index 805877ce5020..84aa2d253907 100644
> --- a/fs/jfs/jfs_logmgr.h
> +++ b/fs/jfs/jfs_logmgr.h
> @@ -356,7 +356,7 @@ struct jfs_log {
>   				 *    before writing syncpt.
>   				 */
>   	struct list_head journal_list; /* Global list */
> -	struct block_device *bdev; /* 4: log lv pointer */
> +	struct bdev_handle *bdev_handle; /* 4: log lv pointer */
>   	int serial;		/* 4: log mount serial number */
>   
>   	s64 base;		/* @8: log extent address (inline log ) */
> diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
> index b83aae56a1f2..415eb65a36ff 100644
> --- a/fs/jfs/jfs_mount.c
> +++ b/fs/jfs/jfs_mount.c
> @@ -430,7 +430,8 @@ int updateSuper(struct super_block *sb, uint state)
>   
>   	if (state == FM_MOUNT) {
>   		/* record log's dev_t and mount serial number */
> -		j_sb->s_logdev = cpu_to_le32(new_encode_dev(sbi->log->bdev->bd_dev));
> +		j_sb->s_logdev = cpu_to_le32(
> +			new_encode_dev(sbi->log->bdev_handle->bdev->bd_dev));
>   		j_sb->s_logserial = cpu_to_le32(sbi->log->serial);
>   	} else if (state == FM_CLEAN) {
>   		/*
