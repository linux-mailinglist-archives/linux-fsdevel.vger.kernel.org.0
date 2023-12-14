Return-Path: <linux-fsdevel+bounces-6043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18460812AF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 10:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA981C21531
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 09:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B3E28694;
	Thu, 14 Dec 2023 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Oyr41Xg/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IGL5QLcV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D832112;
	Thu, 14 Dec 2023 01:01:39 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE8n6hd026831;
	Thu, 14 Dec 2023 08:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=UWjO2K5cKGF9llZfbKniPeWq9zmOAkJIQgu6gVSdrjU=;
 b=Oyr41Xg/5a4CMkY4eRw/efkvDWPdyZBcMwWSi7Bc1N83GM6hqAsI0hDr8P4Raw95iCfS
 5faiD53KnFoD4/4mFRYYI4lQ4kF5qouhESHHTGdYVKZYIPSBPN0h3+C7hTvNPszzR/IM
 1salkweiPb73zoioH1yKRcRsJ6XBKcJ56FSgkfcGkj+MXKQG2KX8vaH5455vAoToyBL6
 JfnkCwOwy8SR9hxVVJhQzPyCrhliCFO/R6CHZtE3UX1Yn+hjeFi3E0usH0ifhkemcL+U
 tLkE/Tdcy8tWVCvVXOtXm/5lm1kKbAN4tRf0Y5tNVI62JSql34MfJPM2gPIYthNWFssH tA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwfrrrmrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 08:56:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE8Cdel009877;
	Thu, 14 Dec 2023 08:56:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep9s25a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 08:56:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Numza3Nex7qSdv/cx4/Nj0obr0c9d20z+Vdt+3DPhdDd0CtC90r4bAzDUnx6xGzT1rUj2YMDsGhbZ/4zNRxPMnRkXC8l6uyuGDU1nGb8PxerL3iL/zsS59ur7xugA3NFIrnX9MsXKRS2PCci4nQ5YhvZuIEhkY7y/v/YNB5MBhuMPHpJeQ38AtCRJEwWdj444ChfS+6ALIscWCA2STZ9xINxYc2GTF2bU9HxXs4au4Dinuzsf+Ug2FPUhpBHsYNKh9vmv9+uNIdKg6kHm0g3fdCtykxpFxWLOhrFGCzWj9A65SUZoXTt7kfGT4i0TO1l0EDIpUY6zwqlJLSnm/Aawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWjO2K5cKGF9llZfbKniPeWq9zmOAkJIQgu6gVSdrjU=;
 b=BYdC5Ab2p+vKAZNRLIgOxie3wpU9kTHnaRWI7nCTWL7wry1kS/O6tAddRE6CJEbvZrn76BYQUUwxKRCYaxEEwlDeTNUXpsT416GxayKn5sTB3851jNnYMyqg6l9fxdswdrqnhNj3WNr2pfLu16BciHGm1tXHMvowWwyiptgSHqFoQ35RAD3kHMUV+yDSNhCzYIrTPNpBuvmH5siykeHkxIaAxV0WtdL6AAgCJd0m3jSNWA6NxvlBjyBLxnmRG9AMzAPGQ+6zyz4syWcXgsszj5EdKyklJXxz/4mTsgM/j75IhTLxP+GeELBvc+Fv8UrPjBEFqqatYg0dKOFldA8JPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWjO2K5cKGF9llZfbKniPeWq9zmOAkJIQgu6gVSdrjU=;
 b=IGL5QLcVZO+MTm8U7KkIUH3jdpHO+TJDffC/z2ADW3vHbR00hNd0iNpCkzcASHc9P0IPkRNTVF3kEqboExRThm8OasNkMgSIUFGJb90j9GIrLuHZ0VCQbd2JvJiwWn5oWHrD4rRBnZDQguDQELBbvkThnQWuMivdn3pQto5abIM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB7554.namprd10.prod.outlook.com (2603:10b6:806:379::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 08:56:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 08:56:11 +0000
Message-ID: <a3901226-c5b8-4a97-968e-7be156a42046@oracle.com>
Date: Thu, 14 Dec 2023 08:56:08 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/16] fs: Increase fmode_t size
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        dchinner@redhat.com, jack@suse.cz, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212110844.19698-5-john.g.garry@oracle.com>
 <20231213-gurte-beeren-e71ff21c3c03@brauner> <20231213160357.GA9804@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231213160357.GA9804@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0300.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: e0181803-eb80-4fb7-7173-08dbfc8284d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QAR45bbwl68QDXkc9VsSkWjl4lHaUG/Z8FzN79pk4YRsNCcn56gL55aXn68d9iX1Je/ceCliAy2Gtwhh/OnDrPTvcZXIdlQ1g9RTk0DnRVUqBSwyd/YK4cBwchF5F6fsV/t9Rzg1jeuIVV6DFkhdXkrmSFJf2/JeVAPLSUmWJaRImQ2rG69RL1hJNn3HL11cz5yR1bqa37JiRLITRtrqHJ3+5UoQ5E3Qz6bpv7oBD6KTHg2lotn/7jHN3bYVGINuV2QO/SCvaOjXbKH7i2dyDFBLZs+UWkR8boXrqiSyBbewKrVuypdPz/LPmP34+2BXMteSx3hmjSw5fR4V8n7UZCALQBmqXAdQ2F/EpOgLyt6RPjrZ43nnmcDpJ1AOXJ5F0xFHZ9Q8DmcMa5YhzT3CI/LxRNp6hGMcnWrKwVtfbYR+YIu5kPEAdyyrNODTgChwRGNwY1CriQES8vK6CT4LpuSGUMK/ieFeN0hKAvrTS33r0IDZRpLTwXkniMIb2joycW0wJ8tFitlc0Rb46GnpjFUM7CwOSsOfO5pywxZxkZTd24ehyw6FRBeAqqMFdF+2aHYcESz4mXKUOk2QTipWFdwuZTqgbM9S6fMAjd4eayaq0mYAz87JdYJxSRlsmk+k0jxsqKR3mwvRbugcopcQew==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(41300700001)(66476007)(2906002)(7416002)(6486002)(478600001)(5660300002)(31696002)(558084003)(36916002)(6666004)(6512007)(6506007)(66556008)(316002)(66946007)(31686004)(110136005)(36756003)(8676002)(8936002)(4326008)(2616005)(26005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SWdaS21md0NJajhMUzNwL1hDNjZlc2NRYlh3VEZ5V216aHRKNkpTeWdCazNq?=
 =?utf-8?B?SmFuL2RKZlBtMDZwTkE1RGhHSlBKUGRvMm02UXplK3krRVpBcElXZnZEMDhD?=
 =?utf-8?B?RzVzcDd3WUswQWlld2JzSFFLblpLRzNCYmlNdEllZlExSGd6N1FtNkkwNkNG?=
 =?utf-8?B?K05GWS9qdXJzaFc5bjVZUnNZZk0vdnYyYlVOdzl6bmZaZ0t1RmNUdFNnVG0r?=
 =?utf-8?B?QXJwenNSRURVSzZwVm5MZ0ZEVTJnOEpFaERFV3NraE1lZmtyTDE0bVRmUkwz?=
 =?utf-8?B?Y1NmNEE3azlmL2pSM2VmQmlUTE1pZDRYL0F2aFlKODJnNEx1eHVCRDNIMURB?=
 =?utf-8?B?VDU2cHhRUWdkdlFON3VVellIdUFhMm93ZTBMeVlxamxlMHI4Q2pWV3pteGFP?=
 =?utf-8?B?NDI0SWwxZ1lpRUhudlEyYjB3WklwaFlqSjRnVXRBOFd4NnYreGh3N3FYRzZ1?=
 =?utf-8?B?dTFud2tFRk5aM1Y2cndtMzlId2RXaFhENmtnVmpLMkV0dVFKdGxzVm43SGov?=
 =?utf-8?B?bDlRNUdIQ3RXM25jdXpNZzhObFVjZWdmTXdMUXVuZlFheVVLR3E0ZmVNZjRZ?=
 =?utf-8?B?Si90R016d0FWUEtrZDNxTGdkWEtvclE2R3A3N0tNUlVzbUloY0hJQ2dZTTJW?=
 =?utf-8?B?UkdPQVBydWI2Q294YzRaaE5Od1RpUGhYa0srSG9FWVMyRWZiRm9NZVN4ckZQ?=
 =?utf-8?B?ay9tSEgvMmZMYm02dzhmeEZZS281YnAwY2NQRjBVQUFIMEh4d2hsbER1TXdX?=
 =?utf-8?B?TUpQQlMwUEMwSjNTQ2wraXd4SGoyajlrdW1ickFGMWpGaWdtLzlianpCOEJH?=
 =?utf-8?B?Yk51eEM2cm9kcmRnT2FIQUFpTEloang3UndxYmFJdW9kaG0xaFNrN09PZ21D?=
 =?utf-8?B?WE54WXFQZzVzb0d3RUpWZ0UvSjRYM0tYeG1VdHVkVm5yTG1YS0FnekF1WTBB?=
 =?utf-8?B?TmQzYlhzRVdJRWduQ0trUXBOYSs3QlJPNEJhalR2enZrYUpRajk2OGJRVjRy?=
 =?utf-8?B?R24xM0pUSkdPWWpqRlEwZVdaUXE0TzE2eTB3dllvc3J6WDFsaGZkZ3IvSVcr?=
 =?utf-8?B?VFlraVBHb3ZIVjlXT1l1aEpkejlxb09jQmx2SXE4dDBzYmZ2RkFaemJxR2RT?=
 =?utf-8?B?V081KzU4TG9jbkNnb3Q4K0ZsRlBGVnpUdUg5SVFiQ2VveDFpakZWVndxRmZM?=
 =?utf-8?B?ZVIvOTZBMnNDNDRsRlA1VmpLR2hGN0ZFOWVEQjBDS2xCUmRGUGI0Wmkyc3F4?=
 =?utf-8?B?SW8ybHFCbUtsNUd1Q1pjdGkzMXFYNmdrWkpkV2QvcXpEUG5qTGZGZTRZN0t4?=
 =?utf-8?B?b3pUOUZoVGNBRGt3dTlNSTgzOXBmemU0VjFMS3hjSldmT2dmWGdSTllhMGN1?=
 =?utf-8?B?VGRWNmJXU1NJajNLMDZHcDdrTnUvTjlKcWFuQ3NUYVR2blZsZ291RHpJd1RW?=
 =?utf-8?B?NkJsS040eDY2TEpqZE1OM21uRkRuUEN3VFljV3NCQ0RrcTVFMUxHVGpLVk5r?=
 =?utf-8?B?M01RYk9rbkJMU3JkZElKeTFkSUF6WEpHV1JpUncvS1VCR2xsM1JTeGpoazIw?=
 =?utf-8?B?L0hRMzgyOEJuQ2lnYjBHSFZWczNPeUgwVGtkRTZqNkNtSTNra3hHYW1WTHNS?=
 =?utf-8?B?Z2xGeFhLT3NmSjh4UHp0bXpKWGVMZndiRGdYQUU3elNIb0xra0hENnFDRXln?=
 =?utf-8?B?UUdzNDZWUnpFMG11MG1FWWgvcHdFSm5ybFk5TTAydGc4c1VGZTFaT3IxL054?=
 =?utf-8?B?OWV1bEhhbHp5Z1EyZXIxQWYzMSsvdlZoWTBmL1RPN3dRUTVhakZtU29TZFZr?=
 =?utf-8?B?anMvUzZRb0cyNCtJUU5RSXNwNmgzS1ZWeHE2NVlTMmNQY1kzRlFTUDJoa2Mr?=
 =?utf-8?B?SSt5RHNLTE53OHNpY1JBeHp2UWM3MjNiWUg1ejkwbWVBaldKV1hLQlZJdkJI?=
 =?utf-8?B?SWdPb2VhY200d2FGTXowbU10QmxWWkQ3blViVUtSTEtmVHVqa1VaVTRabSt4?=
 =?utf-8?B?QmVpUGtUYVhmbDBBMzlqaW1BRWRUUWNkazJJVkp2OFhDZ0U0MHgxUVkyN0xO?=
 =?utf-8?B?SHFReE1DWUFkdnI0UzYyYzNpVmtrdEhNVG1FOU1NMlViSkVMLzVqWkM4RWtM?=
 =?utf-8?B?YmVjb2J4RURKc2p2bkt1clZ4ZUhJUmlEY0JJYTNmSGhXZkZjU2JieFR2bXZN?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TngF/NTLGl5d+iE0Sf9OFkECbHrSNUJCEYR7aVgBdMNsFOxyD5M8tuVCIHbvbsp0kzjevW4gqQrYlLD8npOuNTIDj8N8OI47IcraQ59enzOzu1di6FirbAkT0BOY9neFj1zIW3uZ0BU/rUGNabOW8o8kh2f+gMEjbZpFfnpjLWQ4hjlgxu7PcEbEh1DKiTIz+uoq19HBCXX8MxlrIVbyMRjYmVFCAmMTHXHJzzJDSbVr4OAnkybInFRwUi/M0ZdbYfVQ1QI1qQhnEUhD568vmoiTOAgnp9qeRzTQZWS87waBMcuvktVnWuUim/OJosB8ZFuOb8NM7xFNzsvLZ5I9HQOBgJOKdQsaZqQ22EuvtpfIU02rk14cu8+uCs2nhexwCTEcz8cvwvknBxAaI6roRv0DcjwnVT8lnGABwSU0FCjc2mDq4KnKiPv+VH1hXBvyRJuHIZSbQSjApVT3gtja0lMj964M4T1TBtYPSgYg7q+1qz+dUKuLuhE8dz2EC8RbKSNegWm41QfGmTijVFbuazXG17zjDKpGPqJ6GRfRJ6RZ0AdrTzefdSV3LECqyJlJ1pw2NCgF1MXeN1cK0u/cE6zrk/74YOYWxHNStzpnlrc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0181803-eb80-4fb7-7173-08dbfc8284d9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 08:56:11.0253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qn/ajEs+0/F80rwaKuEWqhtvqdxnGOaKAR3cmTGDMXk8K+8jL8wLqZpxjZTX2xExJsXRHGYyCt3AB7ao7FT+gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_04,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=949 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140057
X-Proofpoint-GUID: RxVA8dJkEjIGuEagPRwZdLuS-3tl4uEO
X-Proofpoint-ORIG-GUID: RxVA8dJkEjIGuEagPRwZdLuS-3tl4uEO

> But even without that do we even need to increase it?  There's
> still quite a lot of space after FMODE_EXEC for example.

Right, I can use the space after FMODE_EXEC, which came free after 
removal of FMODE_NDELAY, FMODE_EXCL, and FMODE_WRITE_IOCTL in v6.5.

Thanks,
John



