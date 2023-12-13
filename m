Return-Path: <linux-fsdevel+bounces-5821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DF7810D1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 10:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0F04B20A75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 09:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7B4208C0;
	Wed, 13 Dec 2023 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="otNe4AOr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bOYwKWFG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488B5AB;
	Wed, 13 Dec 2023 01:14:21 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD7DuTt017543;
	Wed, 13 Dec 2023 09:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Bb5uGWN89dKm9AOZdG8LMuquVw5eP0nDqVHv0xNfg9k=;
 b=otNe4AOrSuxwHsa0L13vX+sMpoza8kKuUAAATmuRPJFlqeHEQviVVu21QHtFCeCnhnJy
 JOE4kSxmKYojsk8k2B7F41lTpYGYyGJkncyWKq5IVC9z0Hxon6P/0Eugf0iap14HSAr3
 zppnS9szCpBdKM4o6/1Izo0FBdrtZjInwuITK5ZseMkk3dctNvuwgnYRmBjbN9ZpQr0u
 IocyseL2O+KeNNvRI3ja/W1/ginFyYS5juvl+42StZr5EhePRoJI4xw886l2ikrPskNZ
 fycULmIbHooEPIWpXo8G80//EQSRoeJeAX472ajJ/YeC/l1mP/WptgPP2/jTxw7XbrY6 Aw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuu7q6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 09:13:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD80b2P012871;
	Wed, 13 Dec 2023 09:13:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep7xww0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 09:13:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpmB9BkxSFHEEyA2IgfAkIj3i4i4AimSLBhrFo1Z15lZ1SzOUQEAvmFrrJTX0mEtjiB0wXemuCb87Wes+KnuWjAUlERYXY6FAznHhzui1f46VeajHUmvVoT0B/Fgy82kTBySPxpnMglMwWgzVk3qrU1kyZy+dw0tDOtoX9l8mv+b1ZJuCMokBDBRLzT8BSoZ4tdvTDINaGRZm/MAkfzBtV1dHFq23jK20j6hZJayZhq21wU0P/dlRDhnK3LMqADSQ63xCKgmWwrtDE7GV2SUwGGO7Hyaps6WUriKin0kFddfnodLtkDvqpwi7HdL1CDCyUr6QwKvLpX+RUt+IL+KfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bb5uGWN89dKm9AOZdG8LMuquVw5eP0nDqVHv0xNfg9k=;
 b=jzJW4CAUfKRFd4v3EcocNQ0Wj9P4bSuNnEDQ43dDiHKbQ3gLuCqExihq9X9pT79YwIr7/qGkVAi5hkiE3KVNKimpxmPCSgAAbMDBo/v+Jq2MH49EUVrANWHJxv95fg1TIJHSgPKf3qa91GmIIGeof5+uh+flRCH2SjnfeVAXrBOCIrjS1BD5gZoZpUPk7IgrfffD+SZZ1f2TWtmfofFnUBJrw6R0fxKxs9j6sBIzu9bKSgI7dU4u974wJB8DxnZ8z23O510Oeu5ofDOYQhVjd0PpDZR/K5sbLmcftfESx7SnytMWiQq8aPGfuLGhALFINFRozU8J47Dj2AFkj3QUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bb5uGWN89dKm9AOZdG8LMuquVw5eP0nDqVHv0xNfg9k=;
 b=bOYwKWFGrIvbAIFeBKFRbJdGnPXQZDfE7r1a4dHvb3NWSLvMlWytn5HEr6iL3Z3HF+Oq46aL9ZMnNvcsl7oEvFNQfnUwylmRQvpX6lVonkTvfddpQeLv/KOiqfztTmz7SWPzLII9GAWYKTY7moARrQn3TE7Zh8QCVKeuDsvP64k=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO6PR10MB5537.namprd10.prod.outlook.com (2603:10b6:303:134::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:13:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 09:13:53 +0000
Message-ID: <36ee54b4-b8d5-4b3c-81a0-cc824b6ef68e@oracle.com>
Date: Wed, 13 Dec 2023 09:13:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] block: Add atomic write operations to
 request_queue limits
To: Ming Lei <ming.lei@redhat.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        jaswin@linux.ibm.com, bvanassche@acm.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212110844.19698-2-john.g.garry@oracle.com> <ZXkIEnQld577uHqu@fedora>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZXkIEnQld577uHqu@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0182.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO6PR10MB5537:EE_
X-MS-Office365-Filtering-Correlation-Id: 23674b0d-c8ab-464f-2719-08dbfbbbd36a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	q1vbmNX0dxwFkwyLeJ4ZPg5oOzPPZvjZw7xbjW8z7K3ckApP9UR8USWHPiY0dSggOVg9VVvdwutfJ54wLpzOucafNdVFuMtpwioevLVaAn5Ruqr8Y0JMh4G7b12wU57myvuV17eYJc7UBqRMAUg35DUdXDGPxOOEluIr/dorHDmdS/f/H9tA8vJx/r2RwObU4KRavdAQVpvPxfkAw/vunyKXfxTsLKe/WVxi7YG1Ghvfrl6/ncYol1xHIGd3IQYI4B8qDizTnapB4dtmtxjrVnVMzZcU04yBSLI4ZcMg7mJzPwugC+VLcjMkAAR82fVf98TXnPsxT34n3ACRE0GC857MIHRa4qlM5BwhlGgV91AreoVVHa8gZZs/gfNVuHdb4/vVY11WeOStwDNFVH6+X6MkT5GdoGaeyMpJDb0wMSvisXi76QhjXPZtrBvsX7xoTEkcfAZsyPgHSZGdvFSoNgEyrkqmiUSKV8FVZXFUkBIQ5HKo06uewPyid10pCptbdOca+YgP+GGr0v/7JeORvB50MI8XZ1jBdIjfFVF7tnDPi3a3D70UfBpFEk9/iuQ2MBs+UhSYd/+xW3uiGgjhKtiXkPNB2Sf+5K7ovA7CuxgXa8+JeQlA+0jcZvpSJcMlMNfcBOoEUS4/lIEM0RwW0g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(376002)(136003)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(31686004)(66476007)(66946007)(66556008)(38100700002)(36756003)(86362001)(31696002)(26005)(83380400001)(107886003)(6512007)(6506007)(2616005)(36916002)(2906002)(7416002)(6486002)(6916009)(316002)(478600001)(6666004)(5660300002)(8936002)(8676002)(4326008)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bHJQcyszSFQ5VlZKdjdoUENjOWUyVmE5RTlFN1NPcmZobGdMTThwZng1bzVr?=
 =?utf-8?B?a2cvbnlOcm1KdWRoV0dIbk5YOVRaWWJ1L09NSE9TenFxYVhUQnZKOXphOXN5?=
 =?utf-8?B?SEtTSzd5bXRxb0NYNFJKRDZXQkczd3ZUeTVsUm9vNS9zMkZybDVNQmN6Ukdn?=
 =?utf-8?B?MmRpVXk0YU5IdkI0bHhidmRzZ1lHU2lFbFZkMDdUenl2aU1PMlhqSUZmU3dO?=
 =?utf-8?B?a3RyZ1l0RS94T2hRYUc2VmRtclcrTTFWcnlSVjdkdmpYQzlpekxhVi9jZXpD?=
 =?utf-8?B?dEZHSmhadlFrNThSZFFoQlY2S0I2ZGFZQXZmYTQwcTdqaXVuV3R0dElVaUdu?=
 =?utf-8?B?cm1iU3dXWEUxUXE4c2U4enpidzlQMWVTbmFocDdnT3dkWlhWK21sMzJkUkN6?=
 =?utf-8?B?QXlOOG9Sd0J3K3JXdnB2SXZrTUZUalk3MDUrajRVMlVqc2Vjc0k5cTIwMDF4?=
 =?utf-8?B?NDRRNGp1TnVnUmxtVFRkNjNBUWw2MTNDdDlJUFJnUjdHZTBGM1N5cmM0cVVX?=
 =?utf-8?B?MnhMdlJkekVkN2U1S3I3QmpSVjY4N3U2REx0Y0NZdVpuRmRqNVNnNUQ1T2o1?=
 =?utf-8?B?MmVaODZwK01EYzF5T2J4NDM3K0pQbGg4d1I4eGI4ZjI1NWZKclNVa1EyQ0F3?=
 =?utf-8?B?Zk9jek9WSnNYcXRGZXJzZGk5N00rMHVxZUVraGNuck1hWnBadnNJamZnS2Fj?=
 =?utf-8?B?MnRhRGVWZU13L1pibkUwdU1MMWh6cC9GcmNNaENTZjRCZW5ETzcvOTd2SFpU?=
 =?utf-8?B?bW9pKy9PVlhBaGE4SEYxdzZzVUJPbW8yS0xndUxDWUlYaXJDRDBWZHFnZHZR?=
 =?utf-8?B?bGtqdzZIcmEyOG1nQ2J4bm5oZ2I3OENVbTd6WDZlODk4RXZoQXZDTktpejEv?=
 =?utf-8?B?RE0rc0w5TitSRmtsQU9kTE5RNVloWUc4M1VwbmY4cmllbFRjOXZ6TkJ4R3Nt?=
 =?utf-8?B?eHJYMFZxNkJKOC95UFRwOGh2cytqckhFNDNYdVMzWk93YTR4VURGZ3k0Y202?=
 =?utf-8?B?NGVRWU5abjlPdXdEYVU0V1R1aWIwL2FDVjF3SjdXbjVCcVg2RGNIdlU5QWp5?=
 =?utf-8?B?eUZDWTFyMEQrWHpDZTZBRHhyYkgrSDdVMHg3S3JxcGp4Tzc0dkptWW1TVjhx?=
 =?utf-8?B?MDJaQmRBVjU2MVErc0JMTUlmckFpK05mWVdzbktZbkJ6NHhyc3VQNHpjcHdB?=
 =?utf-8?B?U3ZhU3pKYXU0eWdITWZHMlR2SzBWdG1rYXFVTjhNMXhoZjcwb1lQckpqbWZm?=
 =?utf-8?B?eUM1NGUwbFFkL3E2VW9oQUZzdVN0NVV0QVo2cXNSMzF0T3hZTWdraENFWkY2?=
 =?utf-8?B?UU9TbXFTcjA3dHJPb2svQjE5T00reVF0MGx0cGROWTI4cE5uTy9OVjZIMDdH?=
 =?utf-8?B?eGZsUVgwemVjZzN1RjAwZDl3cDQrdlZEcjY4SjBxSEo4S1dEd0poVDhjTC9Y?=
 =?utf-8?B?dHFoc3EraHhuQzk0bEh5MzRwVXE2d0F6aGppU2djZ0MwcmdqQWM3ckdWT2l2?=
 =?utf-8?B?Szl3MjVhMllrajNpanFxaTRMeEZ4Lzdodm5oRDZkaE5rcTIrb0REZzVhd093?=
 =?utf-8?B?MUtxSTlGVVJUWkNYUDdPYzQzOGpxcWxwTmRlRlN0blovbnJMaDZHYjJmS3Zr?=
 =?utf-8?B?dWhPQy9RUzMwayt5bmR2Y0pWaUtBU2svK0FjeWx2TlJoNVo5YWJCcDdoYmVL?=
 =?utf-8?B?UkdzZUR3Z0hEaFovK2V2S0Y2OXdVZkg3TTZpeEFzaERYcWFXczJGOWVFSlla?=
 =?utf-8?B?bzZtMURzMjRmMXFpSlpwdUVSbCtieGFnYjRZaGpBd2dQaFRMZUJPMUQwcjhY?=
 =?utf-8?B?N2RYMEhLMmNnUFROUTN1Um1LbWpla1FpTmNsSUROWWlCN2JJdlRuT1UrTlhH?=
 =?utf-8?B?bW8vTUNaU1lxaEZQMnZMaVdrOExkeUc4M2FIY1lyVzZqcVRlc0k5L1RYVGYx?=
 =?utf-8?B?MU8rZXZZalpzZjhqdTg1blY2NEQ3K3RlWEhkZmlKNTBwN2tRVUlRcTluQ1Zs?=
 =?utf-8?B?cFVXZ1AvaVVRaXBwRVRJODA2M2QxYWc5Q3hsUXUyVUhMVEVKWW5HaU1tODRI?=
 =?utf-8?B?bFFsbWRYSjJaWHF5cVh5dUg0OVdrSnJrc05sUUltYk9FQUhYTW1LdzBlcDVL?=
 =?utf-8?B?WnI3a0lXa0xoRHd5WVNvN0REcCtmNEZYeExTWFIwUUJ6Uk1uNG5Pb1RLamli?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dPUoLZjIvWy0e5F0dPxxYcfJM5mTvexgy5McQDEva84gE70ehdA3SiBfx/rKkuoJv4ETagPQobxwFakTxp8Fc8IKfGZG2M7daouSIKS8fQeWhtza+rrC86ZxT2bVV1xsvU7tHLCd7ZS56BhdnuaobfNkT3BHKJgWopnRueogGSkR3va1JvtYl/zoLjAlKCuweWjcwzAjnTeQaelLJib9hY5pywm+H02X6wdCkJhjczQRU7X+LRY1wBAfG/g/IkNsZmg1HclyYMoHR4gDdfNoC7d1eglpaJOkIpHJy0cOPsWt/x2Cxh24NxWHVMyWj7UOYLoLxK3Pxvyv3LVyas7fVmZmxmYV2FxCG08wNzQn1hp3cO5BbRsIXmLdr+xBqC21Yfv6BxMqAl49tqtMd4d16sD3mHFTfKBpKiFiv9lbpKj1UMAqyjm5NQFJLZLE7U5z9io6gnz7IU4wUr7by42TNaeVJcSAyoS39C5gYEhqNNesAus87D1E29jDfxuST8vDjovwg9B9dT2AhdkK0r21Q/EeOaj3mcxzaumQtidIEWO7YDtbKW404i3rUnWrqWY7Tmo+vYyw15QNdGoXb5h6+OMul0WNlAHoi8Gdp9ZyY0g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23674b0d-c8ab-464f-2719-08dbfbbbd36a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 09:13:52.9769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2q338Y3EIo0w4MJ8PmPkBH/BCEc5q+p8Hn6PfYECEui1tx4MUafJ8VUXWpydkh6dmFC9K2aH/x9uLLahm49nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_01,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130066
X-Proofpoint-GUID: R4rGgWxaitsYiI58cDy50FIn_8O7zQPt
X-Proofpoint-ORIG-GUID: R4rGgWxaitsYiI58cDy50FIn_8O7zQPt

>> +
>>   
>>   What:		/sys/block/<disk>/diskseq
>>   Date:		February 2021
>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>> index 0046b447268f..d151be394c98 100644
>> --- a/block/blk-settings.c
>> +++ b/block/blk-settings.c
>> @@ -59,6 +59,10 @@ void blk_set_default_limits(struct queue_limits *lim)
>>   	lim->zoned = BLK_ZONED_NONE;
>>   	lim->zone_write_granularity = 0;
>>   	lim->dma_alignment = 511;
>> +	lim->atomic_write_unit_min_sectors = 0;
>> +	lim->atomic_write_unit_max_sectors = 0;
>> +	lim->atomic_write_max_sectors = 0;
>> +	lim->atomic_write_boundary_sectors = 0;
> 
> Can we move the four into single structure

There is no precedent for a similar structure in struct queue_limits. So 
would only passing a structure to the blk-settings.c API be ok?

> and setup them in single
> API? Then cross-validation can be done in this API.

I suppose so, if you think that it is better.

We rely on the driver to provide sound values. I suppose that we can 
sanitize them also (in a single API).

> 
>>   }
>>   
>>   /**
>> @@ -183,6 +187,62 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
>>   }
>>   EXPORT_SYMBOL(blk_queue_max_discard_sectors);
>>   
>> +/**
>> + * blk_queue_atomic_write_max_bytes - set max bytes supported by
>> + * the device for atomic write operations.
>> + * @q:  the request queue for the device
>> + * @size: maximum bytes supported
>> + */
>> +void blk_queue_atomic_write_max_bytes(struct request_queue *q,
>> +				      unsigned int bytes)
>> +{
>> +	q->limits.atomic_write_max_sectors = bytes >> SECTOR_SHIFT;
>> +}
>> +EXPORT_SYMBOL(blk_queue_atomic_write_max_bytes);
> 
> What if driver doesn't call it but driver supports atomic write?

We rely on the driver to do this. Any basic level of testing will show 
an issue if they don't.

> 
> I guess the default max sectors should be atomic_write_unit_max_sectors
> if the feature is enabled.

Sure. If we have a single API to set all values, then we don't need to 
worry about this (assuming the values are filled in properly).

> 
>> +
>> +/**
>> + * blk_queue_atomic_write_boundary_bytes - Device's logical block address space
>> + * which an atomic write should not cross.
>> + * @q:  the request queue for the device
>> + * @bytes: must be a power-of-two.
>> + */
>> +void blk_queue_atomic_write_boundary_bytes(struct request_queue *q,
>> +					   unsigned int bytes)
>> +{
>> +	q->limits.atomic_write_boundary_sectors = bytes >> SECTOR_SHIFT;
>> +}
>> +EXPORT_SYMBOL(blk_queue_atomic_write_boundary_bytes);
> 
> Default atomic_write_boundary_sectors should be
> atomic_write_unit_max_sectors in case of atomic write?

Having atomic_write_boundary_sectors default to 
atomic_write_unit_max_sectors is effectively same as a default of 0.

> 
>> +
>> +/**
>> + * blk_queue_atomic_write_unit_min_sectors - smallest unit that can be written
>> + * atomically to the device.
>> + * @q:  the request queue for the device
>> + * @sectors: must be a power-of-two.
>> + */
>> +void blk_queue_atomic_write_unit_min_sectors(struct request_queue *q,
>> +					     unsigned int sectors)
>> +{
>> +	struct queue_limits *limits = &q->limits;
>> +
>> +	limits->atomic_write_unit_min_sectors = sectors;
>> +}
>> +EXPORT_SYMBOL(blk_queue_atomic_write_unit_min_sectors);
> 
> atomic_write_unit_min_sectors should be >= (physical block size >> 9)
> given the minimized atomic write unit is physical sector for all disk.

For SCSI, we have a granularity VPD value, and when set we pay attention 
to that. If not, we use the phys block size.

For NVMe, we use the logical block size. For physical block size, that 
can be greater than the logical block size for npwg set, and I don't 
think it's suitable use that as minimum atomic write unit.

Anyway, I am not too keen on sanitizing this value in this way.

> 
>> +
>> +/*
>> + * blk_queue_atomic_write_unit_max_sectors - largest unit that can be written
>> + * atomically to the device.
>> + * @q: the request queue for the device
>> + * @sectors: must be a power-of-two.
>> + */
>> +void blk_queue_atomic_write_unit_max_sectors(struct request_queue *q,
>> +					     unsigned int sectors)
>> +{
>> +	struct queue_limits *limits = &q->limits;
>> +
>> +	limits->atomic_write_unit_max_sectors = sectors;
>> +}
>> +EXPORT_SYMBOL(blk_queue_atomic_write_unit_max_sectors);
> 
> atomic_write_unit_max_sectors should be >= atomic_write_unit_min_sectors.
> 

Again, we rely on the driver to provide sound values. However, as 
mentioned, we can sanitize.

Thanks,
John

