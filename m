Return-Path: <linux-fsdevel+bounces-6083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9F0813525
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 16:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7DB28250C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 15:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A458C5D912;
	Thu, 14 Dec 2023 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YHC1t2y5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gAohjU96"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5BC111;
	Thu, 14 Dec 2023 07:46:52 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE9wrKa021767;
	Thu, 14 Dec 2023 15:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8Di9CB3obj3IIevJw2N07cQfKEMQ5U5vj/6Vv8PEDzI=;
 b=YHC1t2y5AcS4H5r05S6kOZdiXtFKRXvt8AcJI26c7ITbo3yaCaxB4zQSBWY6Oph56Rhg
 WkqpQJ+awU/VJZTv8ee0BZ8kSZrOwvPIXrRoWb/tdsaMeJQjYFDzrZgfXgxPggU7P54u
 syTX6dDQtIb+Er+pRgv5kvKcyXfP79lPfJXDQGosxQG/IkU02VnLBE13A1YE9Pxt2SKy
 fDGYmPukTTNCDriHGMqyQ6DX5VhrgkSZ7vdmkUnblqZnUPtjdD05Lf0vgUW3E1jRGjwf
 WVCFULBTTW1Uytq9+OgSSJkZcIaFQWwCFHld7U3gp8ftdNoR1VX9vbgb41+eBXowdjHw Ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwfrrsh75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 15:46:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEEfSFg012936;
	Thu, 14 Dec 2023 15:46:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepgkea3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 15:46:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MK7/oG+FYmpTGym8LeZsDDEHu7hex5EBGL50Xy99i9QKvKeMoKLX3p56k4UzBezDLv2jg2DPIea9cFiDoadJvNhExjluhd4DOkiLMRBPFCPs4A2NIRPf2qWe6DHgsQyxhVEyz2ks4VZBEGEMw54R9fDHTkkoN9IP7vrFtaoQv1UYy0791n/DBmCfv0aIu5NvpzbgbKgJXJvM6l7syBU7bU4UQfAygWD/ynZb23a9iBOBHVl6iEcXb0T3TvdXDPOf/dpI/hcG2ph58aKON4IGJtG7h2UgYT8sLY6h0upgPjWP/UVKzV9jELYBpxXpleuJe5dYKPYeOcsswJYa4jY2Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Di9CB3obj3IIevJw2N07cQfKEMQ5U5vj/6Vv8PEDzI=;
 b=M2QA3svzMQ763Ht5KraTO495AyzJHlxxToU+/3w/zjb6UjLjWVEdiDtSBdRKCdSQ5tdrvcqvxMQd0OtX0jZZIYUUowWNa6cKzd18d8Ni2ZWwT3a+dcnrMgdYqgtozzMYb6cinC/Lq+vWEdK8uEea3SLNNeCAq76BrUG//D/qktDcA1bSmf7ZDD76mY8Oq+B10uwHWWOsSrUZzEl2XOryfn+miror2dzUax207lZqNnMETnxHDE+OLfJW/jfwRl/sQwNnA0xuWbF5dtsDl+fgqHRKZFBv3i0X+op1PDL3dhhGV4HaZFr71OwnxXNPuw/xSLKrUN0bxiQS4XUjVjFMAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Di9CB3obj3IIevJw2N07cQfKEMQ5U5vj/6Vv8PEDzI=;
 b=gAohjU96eZRB5YazLmj3MpCLpKi2dEkzCAVeDM8ULMeJuT/TO6GJgK0S05t6S3hys514PkQAWs9vaj1RMHdsFRhTUH8zDleOm6OP7+QgTRU3gcMpwkQfez3KrTOwIqvQaF6j5EMJGtkY+gHgp0eB8IS8vZx/Gq/f4d/XhOXHzZY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB6545.namprd10.prod.outlook.com (2603:10b6:806:2a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 15:46:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 15:46:18 +0000
Message-ID: <5ce84888-6071-4fef-a6d5-5cf0b2a8c7ed@oracle.com>
Date: Thu, 14 Dec 2023 15:46:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] block atomic writes
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, jaswin@linux.ibm.com,
        bvanassche@acm.org
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212163246.GA24594@lst.de>
 <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com>
 <20231213154409.GA7724@lst.de>
 <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com>
 <20231214143708.GA5331@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231214143708.GA5331@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CWLP265CA0413.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1b6::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a60c46f-316f-4352-07b1-08dbfcbbd03d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Vw4whhq/YHdIYLez+EeDDaKv73UfKn96Xsj9cUY4qvNvX/MfOBe28R/bJAmi2m02bSZK2YHnmhuOPGY8eKuSApRJKLyCx8/d+DspnPtXSCjxA9wGF7BJVzJWqK+TPxC+7rA8og+Fub9raYHGsGpPL6XP5InASgmW0ZJzF6euu57O9zqvoTL1ITHhL4Wgy8KdsgAECPW6py7xAEcBdnKaTcR4o5Z19WT/z9IGlJJuoAXC1b/1aoClZKwwQXKj5Sxh2L6c5vggc7hvZT7M/TlfZazLalsS29W2pFqy8k9+pbg/bRYHSrJKXRgF2aQWBj1ttJlcs4l8Cg+Fe5ySHJlOjOMNJi4zmVZONjsWvPlVc2OVFN7EqWcZUxto/FwFOyxl9LLauGv63fLRomkoKMrBq81431XZHUcDaMXlnqOG8E0LlRZ0Gj/gs94UcSptK3008p1t5CdrMN6rdYJihmraZ7EAw4cldnmszssXT+A0LReAnBktj+5XHpS+5tkvnbDT/LSbLZYPI96jO6qgeNRb5BJgkAKTZCb7C84zEPDCPebANACigl1At05in8GXx/33DkNoNz2cwo37oM+7cJFQzDi2PsDmJdpEKzwenV8JCeD4EAjVIETaQ6sGTO9VKhtvTOwEZQXp3ALBY1+2cwQbKQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31696002)(86362001)(36756003)(31686004)(41300700001)(6666004)(478600001)(6506007)(53546011)(36916002)(66946007)(66476007)(6916009)(66556008)(26005)(6512007)(38100700002)(83380400001)(7416002)(2616005)(4744005)(2906002)(316002)(6486002)(5660300002)(8936002)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NVJJb2V6Q3hKTnhlU0J2ckFadVNra2IwZ0xFNm53UjJWdlJsbmpkZmppcWRK?=
 =?utf-8?B?S2tGSkVHUzRmNWM4dEFTWXJMcmk0ajFNYmZubW11ZVd3Wmx3U0VWLzJpcWND?=
 =?utf-8?B?QU94Sy94TTdSUU9CaSs2aDMreG9pbnl3WkRXMVFQQWlNaHVjYmRXQ1dnajJN?=
 =?utf-8?B?TE9ueFllazdCZS9NQ1RCbjJaMGpUNC9vbUozMWlsazZ4L3lpRUp6OGd2L1Ev?=
 =?utf-8?B?ak5MMjFwZkpoZ3hzWTVRczNqaW4ydXlnbWxsaHBqNnVGaUFwcVNiN210R0dk?=
 =?utf-8?B?YzRMZTdYaWM1VVlZUTdYWHlGZmNGRSs3N3BWRjJHUmd6azA4YVo2M1IwVUg2?=
 =?utf-8?B?YmdzNmVpS01QNHN5bDYzUnVTa1A1NjQrVHlzQTdGTk1TeVZYRFVVYWhqYXVW?=
 =?utf-8?B?YmtKdFhVY1BBek9nRUU4SlA0U0ZGS2lIUCtlL2V0Sk83Y0Nac3ZWQS9wRURC?=
 =?utf-8?B?cmtjNHpqS0NNNFpuaDFraTlHOEEvTGxlRVBNMkx2Z1cyayt3K292dHYzS0pI?=
 =?utf-8?B?QVQvMytRK1h0WVlNOTRTQjhKQTZWZWVOR1M4K3V1R2liVGZ6S0tsQXZaNm8x?=
 =?utf-8?B?OFlONHRhK2hoajFKdW9LelJMTmlPdi82TVNOVU1EMXJud0NtOXM1R0FRdUxx?=
 =?utf-8?B?MU5USm5RaUU2SWI1cHQxWHY1Y3UyVFFGc1RBbG5GakltRDEwUzFaS0FnVnVB?=
 =?utf-8?B?NlpsRGIwVkRXWllmQ2hMSlUvclMzc3d4cGJuOUgySUx6aW85Mm5xUXJpazYr?=
 =?utf-8?B?R0Z4R2ovR1VHa3YwVy9uTU1BQk43bWp2K2xjZ0lNT3R0NEcxK05yNTN6K2N3?=
 =?utf-8?B?SjdzWXdxbitncEg1OFNwQ3pZWGVzNkdvVzVsV0s2T2Qyelg1QjZ0OUdGL0Y2?=
 =?utf-8?B?N1JOa2tGWlh4cnkvb29qR0x6S0JVazZoWU5WVDN1WjA0aDByNEJZYWROZHR4?=
 =?utf-8?B?UWdYTjNjMjJGN3hCbG1MUlVockxRa0g1am1PTjE0aTRxSXhxQ3BtMXlDd09r?=
 =?utf-8?B?VkJkM00zVkJIMVdzWkRHQjA1VUdZQzBRbUV6NVI1TWJ2M2NVWGkrck9jUElq?=
 =?utf-8?B?bjZDc1N1ZzRyWURTL0tXRU5LNnVJMTZLdUt1NWxVMG9udmpkY2ZLSTBrbzFC?=
 =?utf-8?B?UzYyc0xsSnRjd3R0NmJYTmxsYUF5UE11d3pRTU1WSnlNb216WHpQamNUcUJC?=
 =?utf-8?B?ckcrQ25DWjVIcGovcGlncHlaVTZnK3YwazQ1TFgrMFRJOWU1Z2Y2OWtYRmVm?=
 =?utf-8?B?MGIzRXpxck1XeFlTNUdXSVBOVHZMOWJwd3E4VG5xR2Z4UDg4Tnd2bFd6MGpT?=
 =?utf-8?B?VHA3YUpMR2tpelljblJiU296ZGlOSXpEZFc1d0hLRG9vNkh6dE1UbWNxdHhu?=
 =?utf-8?B?dzd5QWN5Zm5iOUFDOUlPTVBvQm9JK2pGTlRaU1BWM216cmdRK0RBVWFhaVlM?=
 =?utf-8?B?U2hmQkhJOHN1NmVBVUN4QnpYTTJrS1NrNVcyTEx4eGQwR3RKaW96d2VvbVJM?=
 =?utf-8?B?WDdzY1lMMUtkeVlsS3h0a0JlNHYxQzRucVJaS0ZycEN0THVVdE1mdHVVNEVY?=
 =?utf-8?B?ZGJiT0RSYjZmSysxRVY3clIxbmZ6dFJKQmpsNEluLzdtSFozbkUzUlhJU0h3?=
 =?utf-8?B?aitMSlVtVDFWRWtGaXdsTXdDbGFVVVVUeDBQenhzZE9DR3B4a2dSTTFjTU0r?=
 =?utf-8?B?OHl4OWhNb3JweTQzOWpDalVNaDFHYk56UGhZRnFSaVRFNmszK2crdFBpditq?=
 =?utf-8?B?MldNZGYxUk9BNzJJQWtMMFJ3bmY4ZC9INUVmbWtZcUx4WkNnRy9zbG03QkRI?=
 =?utf-8?B?d1FjdG1jdzNtcStzYnJJYi9rZ1JpaGRQOTU1SklqcW1wZzNBWldXbDdMTnhH?=
 =?utf-8?B?TWp2dDRqUHJEZ3M5M25ubDZMZFU3c0M0VXRUSjYwSkdBNGQ4Kzh1bXNoYytn?=
 =?utf-8?B?TVVYRHQvVWw0RWljdUNxbXU1ZnlTbktpUWVVQzR3cmNocW1NQitlMW5oTDlH?=
 =?utf-8?B?K1ozZURWR08rU25jVmlLMkgrNG1ydjlYZmtBNlA3eHQrREc2Y0ZhWVc5SDBn?=
 =?utf-8?B?bmtoVFZhYUFlTzM0RU1Xd25oUWg2SkhFejY5R0FCOGRjZjd4M29KbUZTcUhG?=
 =?utf-8?Q?0d7dHK3GsG7CxBDPTKt+tnCK0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qUPdrjbeh/OuZNLkkmcCcAqzx8xmqCu1pQ7zh7Eb2wA6P5NI/288Nwxm5jZH4yaNVqgMlgeEdJnj4B8pJ3lpufmXd1yvF/CCWZyFLrZTuFCASC9UJ9+5P6J8aSMqOXi9UdReMSH1Bi6Q9GO8jjhRohXGZ6Ke+cNegEPL8R4bicRBa9aXPZpLz0K0fENDs+ryP+4pbW/p+n+BNzMUh00gUxvxa4Z7EpWTZ2lilAiVSmcnBQLEuQyl2g9hihSfQydc6pZPvZSdEM9lqoHbkLfynijXD1Ii1oSrKUpo/5pWvtunSkMGLCMtT0r56YnQYpPWmQm+YdWRiEMFUmEYJx3jTtQAsGpF/u3cbYIXK+h6yOGpPdq8QVoIFsIRga4TxdFfMqin4kbL6XEixMi8BTh6TzAbONfd9U/iFpg+O9LewqN7dXnqH2liGf/ZshUQsHxlcXbAPIp+QxFJzqfxAev4U9OLUjxiV4sm2Hw8k5Y/34LnXkOEw5huZFx9l9EFlxiRjISUv5iZ6f1BbWcT44bJKqaG44CuwMb5RzgSiV2Q0FegB9cy+6c2/OOjoR+jCckwIrjUE4LqImsc3t/jeZsDShW90Tu/N+ovL0QSe8s5dCc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a60c46f-316f-4352-07b1-08dbfcbbd03d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 15:46:18.8170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xeexG8l61dP3jWrksi0Xx71Ri1d1k3p0HKT6n4aG7YAx+EIeIbofLGJ7RLvwXbGw//6O61zsK7O8D7REezM/OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_11,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312140111
X-Proofpoint-GUID: ueI6-cHM-8fPcjlby4IstjDopYl7XlgW
X-Proofpoint-ORIG-GUID: ueI6-cHM-8fPcjlby4IstjDopYl7XlgW

On 14/12/2023 14:37, Christoph Hellwig wrote:
> On Wed, Dec 13, 2023 at 04:27:35PM +0000, John Garry wrote:
>>>> Are there any patches yet for the change to always use SGLs for transfers
>>>> larger than a single PRP?
>>> No.
> Here is the WIP version.  With that you'd need to make atomic writes
> conditional on !ctrl->need_virt_boundary.

Cheers, I gave it a quick spin and on the surface looks ok.

# more /sys/block/nvme0n1/queue/atomic_write_unit_max_bytes
262144
# more /sys/block/nvme0n1/queue/virt_boundary_mask
0


