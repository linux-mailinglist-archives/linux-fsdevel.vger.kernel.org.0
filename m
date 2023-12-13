Return-Path: <linux-fsdevel+bounces-5851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C65981129C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0AD91F215B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DE12C87A;
	Wed, 13 Dec 2023 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BWNlDQDo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oA42xaX2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD6CB2;
	Wed, 13 Dec 2023 05:16:21 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDCsQvJ032170;
	Wed, 13 Dec 2023 13:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=5F6ZgsHhYrKTZrI5OfEpzulPN4fi6IC+cj4/9ljBqGw=;
 b=BWNlDQDo7CbsMw0hcCQRgA8Sl8cHLo7iqrFOOjNwn0BTlQ837GG5kuLwCQTSGqRIZzLX
 DzrCcb6m8seX4jOvFlAh85v22sMcgeHIlOPoYjtVFLvEhvccNZhPh2GOFSK6q2d6amjl
 IRqLEE0habGiw3YS3NriC5g7lvtLCtlSWgGah1X0KIY3VowWuLJVKtPRTI8VS+qtGPcF
 RS9EuGuBnAsLbryM2CawhiRaFNMWghDeBBJdPH39PTxOGhyO8Xc/SR9KISrm4jXmUTPY
 IDC49BImw9/l2vHdpMOrmhTpbAi9VUBU3SnO9k3vGnPioYlwH/TLQUKWBuBMQKbyK4qR bw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwfrrpjv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 13:15:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDBsVf7012849;
	Wed, 13 Dec 2023 13:15:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep88kwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 13:15:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noSizzjjkLiUvPDV38/5DMwJ6K3vWOfNz29fVmv7nXGTbVs/3HhYuiZG8SHxr5/WTr3soolvKTnr1SMeNu6VFOzSERK7M/VqmSeu87n6LSQRtnfSbv1W4wNWP0jU/U8AN+9gODercr0J2ihoLUGmHy3Lt83vNcR8EWj4YsBb/CNmnC8qUXMgQ5Q+ukiQY06jGA0gjm7NZq/tER9MWRp4//6bG1KG/A9TSIlwBH7Zso0P7snR+b1u62fi5mdtrU8yBfhFMd2qnihWgdqRwUTa6zQtrkwfS6MM/A63iEQFLPFx/xw811kTkQ8pMKqWDqGFJcx+HIm8TsR5TxtyJmPGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5F6ZgsHhYrKTZrI5OfEpzulPN4fi6IC+cj4/9ljBqGw=;
 b=nhfEQ/AKVywT2jMb+zfi2Ido70lDis8lBre9Bu6gE/WllNsa90V0n03VUyMZAXbBQz5DmoTT8ciWcxlgVBg4ca0wwMWhgGr6s+DRHUJwz+EIKR4szodZOW3Zy5gfY76LSIb/5yjdL0e3yM5ksDV47ro3VadvK+wf2MqyxLCMKP3AnzXTktn8MWCx3g1lt8UMDO+sOdGuwZpEX8OlQZW4UOprH8tZHdI8AHn/j+xYsU+isPfyXXyNNqD7EiWCYsb5sNkA+7vbd7j5hFlkIxPMUqAbTW/7LdDNxRQjG5+vsH+BUFxxvpXrrAtdMlWhQlX3Q/KSzLZvo9V1/XB5lQCP/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5F6ZgsHhYrKTZrI5OfEpzulPN4fi6IC+cj4/9ljBqGw=;
 b=oA42xaX29HmmJdhyHerXSrbs1FeKTqkP2u2jVfw8x71PPiWw6yyZ3gEPaYzEHgNFFC0TorbKX1xeL/KvBLaEyi0kfr/pp5D7CqUZ35yXP878QmeTt0zFp9Sns50UQ7JwG9+P71gh134hDBY7gdmKF3t1mSURm2dNNM9lE5HavZg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5081.namprd10.prod.outlook.com (2603:10b6:610:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 13:15:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 13:15:44 +0000
Message-ID: <267f7b59-fbdf-4c88-bf6f-596de09ba831@oracle.com>
Date: Wed, 13 Dec 2023 13:15:39 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/16] fs: Increase fmode_t size
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, dchinner@redhat.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, jaswin@linux.ibm.com,
        bvanassche@acm.org
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212110844.19698-5-john.g.garry@oracle.com>
 <20231213-gurte-beeren-e71ff21c3c03@brauner>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231213-gurte-beeren-e71ff21c3c03@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0633.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: 93cd994a-7030-42c3-3c0f-08dbfbdd9d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e9jFuOf6DNtG/RWSDlvZIFm5exbCrKPTXOr911joHhEPbWLXOvRDmbpFwgM14BDSxsnIl8iAI0k9SBYZBeMG5Zj9M88GHBt1XgFiVCol8PBNBRruoR53HWOSEQGRhK71q9pI2OENy0oaZ/jqywVeR2UH62VeaxYGbyBVjVHzSKqsEiZdBbmFOoBmIvbvABTKbNMIynhEP3eID4eBkJjpK3xQ1vlTdVJiBcMxCg0Udh+KvBoRGnvEzpx2jGH8rqgbQy/So1nss8oYd61ToJCQcmwrVGrM0l+AImGEVI5ISYAHZlNDE2CWDAenPrMhRtgLo2aM+WgBZ7ahTcR9UTmwhBQ6OD5BDrAJr+HrZ35j7wvU1GwFkg5NhSe0bTjIo87yYUZYImFpyPZw+ixCpowSDmcIJCZbKyjUxBymyOrmcS6mKc3VpJGNNFoVL+Vim/MMDOlvbFPKmyyd64PKDnInPMBhYgCBA7VMKhXgGkHYcck2BB3pe39SPNLoAshSeOYpkD6oOpVAAZkf+GOwIS/5hBfY0p60sD982OtQVZpV01eeq9tBsf1fLgaebWbab50wM0/xjj9AEs/LlzNHr3BgoxPYTsMaJicBOySwnf+VwxgLm0e3aJWS6CxPdbE/JkX1vRwPRB291beTtEFf75wvpg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(31686004)(66899024)(2616005)(26005)(36916002)(6666004)(6512007)(6506007)(31696002)(86362001)(38100700002)(36756003)(5660300002)(8936002)(7416002)(8676002)(4326008)(83380400001)(66476007)(6916009)(66556008)(66946007)(41300700001)(2906002)(6486002)(316002)(53546011)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?blhxOXpaVUhzS3ZVcUpONkkwOUNpMTZMNjRFM2xIS0M2ZmRxWVFpbHpmV3d3?=
 =?utf-8?B?Q0N1MmtCeGZia3FVbmtBa0JjR3ZORlVhS3Jyc1pBa1pxdi92Vm1COWFzMzRK?=
 =?utf-8?B?eHAxR1hzY2VkVG1IZ3ZUTytKU2tEd0hka3BYYSs0SHdnQmJBUVlJbHJTQkc1?=
 =?utf-8?B?Nm1RdmkwT3ZRUjBlUnhXM000V0t5Ritvd0Q1YytXNmhFcGpYZ1Y0TjBsSXJ0?=
 =?utf-8?B?UHQ0NXZhY0ovbGNGR3d0ZDhrUHJ0V1B4RU9yUndtenVmUFl6Z2V0Tlo5Tjll?=
 =?utf-8?B?UWVvOWVFOFVEbUUySEoxVml6RGpNWFcvT1ovZGU3RDFJSnVpajlzd1lOZFAx?=
 =?utf-8?B?TG5NNGRYYXlidm9yazJMT09wWWtKK1lqdVBIWkt5czVKV1p2OGxYK1RvRERi?=
 =?utf-8?B?U1U5MUZDekxsb3BZcDRCT0tIT253V0RGWWpGa3lpRDM3MXdEcWk5QnRlRjVt?=
 =?utf-8?B?eWNRb3djMkpMNG8vMzh1bTRCNUYzTHM5dDlHZ1k4R0praWZTdjN2WlA2N3pk?=
 =?utf-8?B?MXRNVjVZUC9LTUQyTjhjSEFnZXMrZFQ0R3Bvc2hsVEx3NWloS1kvZ2ZUYWJH?=
 =?utf-8?B?dVFDRS90U3FpMk82OG9mZWpyelN2VlpLN0djR2hFNVBmeU9YamZUQ095VnZM?=
 =?utf-8?B?cUovNHBscG5lZGpMWGhQaUg4M1RDbWZWWm9naVgxV3BsVFNVekJtSWxleTg0?=
 =?utf-8?B?aTE2OXhERVcrNk82MjRVT2J5cW10TDlRYmNUUmFIYVJocXJvalVFRXZ4K2Uy?=
 =?utf-8?B?SjFXNyttcU5xcDdvUno5KzVWMkc3aFNqMDI5cjVGclJ2MkltZ0ZXbFFaYVBp?=
 =?utf-8?B?V3MxaFRYOGx2VUxuT1R4QTFmdXR4Q2lhVXl6SEF1eFNpRGVZVnMwK2dNdU9U?=
 =?utf-8?B?a0dnZXJtSHY4UmUrNG5JdEpreHZ4c1lKQnBjWjl2VEE2c0ZpRWVmU0ExZE1Z?=
 =?utf-8?B?Zi9KNVRPcklFS1RITXNrQ3MwN0NueTBWTWZlUjlZVUQ0cjdMVnRIbVErdUJG?=
 =?utf-8?B?TUtmYjZ5NTgxVXgzMmM4SGs2M2ZUQW1CRnkvcnBWN1hKOWtwWE8wRW8yZ0Vt?=
 =?utf-8?B?V01RVE5nd05PT2xYdDhUOXQzRnc2REI3bitIOE1ld2d3TnhnRmFGVEp2cHBC?=
 =?utf-8?B?U0RiTGRMTmplL0Vhajl2eVNQNWJZV2dDcVU0RE1Ea2M5TE8vczZjai81bmQw?=
 =?utf-8?B?dzVvbHdWOGRkK0ZTMWFhN2tEUTJZczhzV0VlaFhxSU9EVUlIZGtFSmZnMk5S?=
 =?utf-8?B?eEJUMzVaREk0YkhQMTgzb1ZaM2xRRlN3akhCWi85bEVYVlZ1Z1JjOFF3Qkdp?=
 =?utf-8?B?K01DRmxFUjl1OUwvZEVHWmYxNERqZklDV0dOU2R1cXRqcGJ4Ti9mdkRJYlV0?=
 =?utf-8?B?cW1tNytsK29CeVBWM3BHNkZ3U3ROc1U1emVEVjA5UDVLQURpQTNKbUdhOXBu?=
 =?utf-8?B?U2JVcnhiaU0yVUxIcjdPa0N6aTExZTg5ekVLRjMxaTBETHlKa0d6elVlM1dt?=
 =?utf-8?B?YkRCRHZDU0QwL2FMM0NVZ0pzWjJWbVcxR2NEVG15NWpVMXNrRllqcXJTWmxM?=
 =?utf-8?B?akYxdnorVDlEZGVFa0RuUS91aDk4eis4MmQ1aWVadVltSkhQK2ZicDZySnht?=
 =?utf-8?B?aWJZMXA1QlUxZXdUUlkxVWdWZTM3R3FHTWN2Zk1wa0Vhc3JhanVVcEs3VG4z?=
 =?utf-8?B?RTRZa1VSWkpoaVMvc245d0FadGtNOW9udDVraGVaVGZ4MndVMTRkYXFXU3F2?=
 =?utf-8?B?YmFJUjZnRG5VN1hONENtOGNpc2F6eXYvY3hmQ3pjcTlNN0dPemFpVzdQU0Jm?=
 =?utf-8?B?c3M2YVBMSTl3am5acVZEWnpSeVZ2Ti9kbmdIMXFBdzdKOEJHL25vd3hZMHBH?=
 =?utf-8?B?dkpQeU0wc0IyWllpNzAvQXZPMDdqSjBNTjltMkY3ZXp2VXJ6d0xpRzhrTzEw?=
 =?utf-8?B?K21DcGhZOEdNRVlzZjc0UTRmeGU4REFvTGxJbUhtckJTU05kYW4rRFRjZGtK?=
 =?utf-8?B?ZkNhelI4Q0hjT1lzbjJpa2Zjb0EvVFUyOHM2Mzd1ZGNxdjhBUGlickczK3Uz?=
 =?utf-8?B?enJDRE4vUWdoWjRpaWpYam9vaG5kaVcwb0U5dkN4YjBhU2p6N1N4TmkzbTYy?=
 =?utf-8?Q?TwIUbJc9agb0hWe6onP/8Twk1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tZcNXUFFTmDZZ02gbPVDvhC2SqFzG1Bu3QL7i+wRevbodOz2qv+cPgGirVb6Z7AYbucoIpAWXgUimAuJnj9wybA9/TEirz8O17vX6ndJnpuQHCseDok3AqbggUmFvBUkPJseu92wpUckxg5lVeNF40g7nEVo6AyLLqQ5hi/wO1saNF530VcqscT+UDnge+wNjNWpAKB72ps25n3n9ajr5bDfIps7PYHwlH0+4DuZJtYYX4Me8PjZKTmoedO3+cFibx/sACPd+c74f8Hrqt/W/KhwmlSp8JX6jxlrFUE26xHN3OxzUcAD3FGX09NBf5BBMjOIPquAtaeNlzJlOG/6qF/jot8KfXV0waH4htawlh1UF0QjA5gBAIENza7q0a5u5HstFkoExBcTtXGDy4idhftJPihKv+apmVgj9Lwa3EQwiuq1GA7aug59W0phoqy6PtUT/2w2VaUqWf5day/5lp26DklhcuulAQ+88AGNUHWfXudV+G16fRHx+TKhD4DiWCKORMShls2I2YdtsQ/WOIk2ubyBZhADDi29Scfk1Ebwsq7KaOwiDUpGTnSMGuhC6cFHTXrKIBzP1bL3FDjC3xWOqPMObwP/CBG6Pcn1VhU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cd994a-7030-42c3-3c0f-08dbfbdd9d1a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 13:15:44.7228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoOHaDy4RT3nr/NSE/I/wjlRC1NDX7V90x/i4WZ5Vyjlwf6X105CsXRCAabvd7m0cCsi+IrqG8KGWeU1s0CDUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_05,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130097
X-Proofpoint-GUID: 7FNnPwsG0gkBY_hWnZtMrnTpeLQF0lJ_
X-Proofpoint-ORIG-GUID: 7FNnPwsG0gkBY_hWnZtMrnTpeLQF0lJ_

On 13/12/2023 13:02, Christian Brauner wrote:
> On Tue, Dec 12, 2023 at 11:08:32AM +0000, John Garry wrote:
>> Currently all bits are being used in fmode_t.
>>
>> To allow for further expansion, increase from unsigned int to unsigned
>> long.
>>
>> Since the dma-buf driver prints the file->f_mode member, change the print
>> as necessary to deal with the larger size.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   drivers/dma-buf/dma-buf.c | 2 +-
>>   include/linux/types.h     | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>> index 21916bba77d5..a5227ae3d637 100644
>> --- a/drivers/dma-buf/dma-buf.c
>> +++ b/drivers/dma-buf/dma-buf.c
>> @@ -1628,7 +1628,7 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
>>   
>>   
>>   		spin_lock(&buf_obj->name_lock);
>> -		seq_printf(s, "%08zu\t%08x\t%08x\t%08ld\t%s\t%08lu\t%s\n",
>> +		seq_printf(s, "%08zu\t%08x\t%08lx\t%08ld\t%s\t%08lu\t%s\n",
>>   				buf_obj->size,
>>   				buf_obj->file->f_flags, buf_obj->file->f_mode,
>>   				file_count(buf_obj->file),
>> diff --git a/include/linux/types.h b/include/linux/types.h
>> index 253168bb3fe1..49c754fde1d6 100644
>> --- a/include/linux/types.h
>> +++ b/include/linux/types.h
>> @@ -153,7 +153,7 @@ typedef u32 dma_addr_t;
>>   
>>   typedef unsigned int __bitwise gfp_t;
>>   typedef unsigned int __bitwise slab_flags_t;
>> -typedef unsigned int __bitwise fmode_t;
>> +typedef unsigned long __bitwise fmode_t;
> 
> As Jan said, that's likely a bad idea. There's a bunch of places that
> assume fmode_t is 32bit. So not really a change we want to make if we
> can avoid it.

ok, understood.

Some strictly unnecessary bits in f_mode could be recycled (if there 
were any), but this issue will prob come up again.

Could it be considered to add an extended fmode_t member in struct file?

Thanks,
John

