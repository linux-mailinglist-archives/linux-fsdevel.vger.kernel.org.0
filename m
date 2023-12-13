Return-Path: <linux-fsdevel+bounces-5979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E9281195B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 17:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA201F21B23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E26635F0F;
	Wed, 13 Dec 2023 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iGnEZeXG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KhO2Yseg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B16F83;
	Wed, 13 Dec 2023 08:28:43 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDEQq9P015965;
	Wed, 13 Dec 2023 16:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=h46qOYMyLpu/ZN+SbO2HO8naC5nIjE4+YBJu11C6feg=;
 b=iGnEZeXG7EyiamgfIQbKGal2RZrzRIGCp8u33oOQPsshAcp/yiCMG4wa0H0OjlQNzqpl
 usAvvXkPzthUDubPeXx3Avth7qYPAbfE4Lh4yDeEDMFL/3X2a+FXpxqRO/8MbQcjJOO/
 JZS55ZA7pQ1lYspa6ms3xFiZiaedJUK3NMyRGauFHhuMTifVhG4twhKm4/BU5dLboQOI
 f4MD32F7TNWGe2L/u9RjdSgYb+isFvlZ+wlnA21jCaSgye4xQgOpUnogSumg7x656s2g
 szMD7nnK7aL4+OOCAtwB18jE8VGGvRH9t53uhDvD59nOBlF81UEoAYv/mRM6j1PY6uHP 8A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwfrrq1x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 16:28:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDFCihV003288;
	Wed, 13 Dec 2023 16:28:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep8j4vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 16:28:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTD+P1FJGwf9wMRk2ibDfkNjanhttxaCm0/ov+1XSFu52T62veTVzzQ7UIfTa45FmU6wgvim6ToomeNVPXz4uPR8ejWfDfzpHSpGLwWcvnlbr5YaA+YbJJbqnbLv7UPAHEwok5io2TiqJ09mTtGi2jpz381lnzKLcbAF3HN2T5bqaUMs+ZPinKu2KcsXQQEdbjRJAkOLwCFCMCVa8qor7v0IbNQHEtVKTSvZ2nwJ4VDzYBAbcPpIJ//inY6S+deFi+dKBGyReQL3EHvSMVeonQKGHOskL2PIZFrBiVq9GgqzIBgEaQi1CpbFpDRirm7dkHiWkuoT7khdxBqRcHC64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h46qOYMyLpu/ZN+SbO2HO8naC5nIjE4+YBJu11C6feg=;
 b=AwztmM1H01uBiwCna09UworYtF9JgJ2c/PnS+bdJeKGfuSfrfKseWqkWoSCZOOcnzEBJVbTcm49mhQMXj+/SY7rE2vXDEW3417NEA+nsgYAPm/yYHoCPnyYNr0v0LD97f4vYNkVqXRr5tlTDs2DDgy28jj8ciya7IGnamohUPMIHaPmC3b2wVHlOCO3PnudbqRG9PIxZrA1LKPOqf5sfwGkR9IT+1UDECz5+HUxJnK8Lb/GUtVPE7L8Ea1ivStDR3njvEJiG6lolrc/I6eOoIv9oaBtxo50ZUBA8S04X95w6NYV1cP3CwbSpq4CWPM4Brx6UIJrlzBVhXCMhMxi2Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h46qOYMyLpu/ZN+SbO2HO8naC5nIjE4+YBJu11C6feg=;
 b=KhO2YsegvId4morHdsDPjb3TF4MvymptlBm/v1yadrLcaR5Mt6eteVMHqRtxehZr1l7fgL4U39gK2Irdts0IP+DCPOI1NJ4zIvAGls8/5NRfHJV8J3dRiksB0xGnNqtxMRXAz8sATU88+c1LllBjoe4CjAFRcPrJUhKtBqBjn6Q=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7127.namprd10.prod.outlook.com (2603:10b6:8:df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 16:27:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 16:27:40 +0000
Message-ID: <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com>
Date: Wed, 13 Dec 2023 16:27:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] block atomic writes
Content-Language: en-US
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
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231213154409.GA7724@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0509.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8ea386-8eea-424d-8817-08dbfbf86cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yV+Wa7j8ffS5lue3wN+Cf6rwrr5ipuo/dqDrT7gvX9F37Ipedkl7GoqKVpA6Ep2Z9H9C9IFgvy87znaSsvk0c49TeEfWqiBa2qn0V9szP0RqbvIOLBAhafd2bDY2TblnHHTo0XUKzXd8pH4AQA4lArpPpRvOz21MyW5tXXC8WIaYzxpVrXxVM+TLJoM8BQo0yhfS9CBIpo+X2eOc6bJW3Zy6jGsWZz9YNpxWrnwvufabnfJLIS9Fvi+EMtf66EvGgD9XnNCrCXtv7mEWo/nak7JiK5F+/0a+lRRgLHdST4CccsO4THoL5BhXoBrhW9YzZqEWn0GcDMSBgexf/BlmnzxCgsI3wvGCvzM5e5BDMd5AZs5V52ZFgoJ/AOe/mc+5Of8r9bdeB02oQBMQe4WzxSLsUmfwAwIOFH+C8YU+cFI8FyDiwFI4YgkPlshqcPU1ROpiOa8aXNK+lo1frMbn8NrHtO6MB1tBErEXYqo6zLZt3NGCb74/uSmexi9lEYQJ8z9XomeS7yDBcBjfVs3sgjcPTznuoNtWg0D28z5AtusrO63DcV3K9/vgmfd02fHPjjBhDXHBRsxqDBmQG0SmvscG4qGXgy77OHVmHhPW7moEVawPyjfraqBzg4tmigIqq4+ApaQjCfJQg0V1MrIkpg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(6512007)(38100700002)(2616005)(4326008)(8936002)(8676002)(26005)(2906002)(316002)(7416002)(5660300002)(6486002)(6916009)(478600001)(53546011)(41300700001)(36916002)(6666004)(66476007)(66556008)(66946007)(6506007)(36756003)(31696002)(86362001)(31686004)(66899024)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?clJDdUVYbjNObFBiOUxZM1E3cEdwWUlXWDJjRi9pZ08yRC9la0xldW9iVmk1?=
 =?utf-8?B?Z3ViOVdDVWxhdy9CRWhVMzhQTWZBWlFRN3I4RUZwaFlmdTZQWEhpdEhHSjVz?=
 =?utf-8?B?MnppTlZYYXowS1ZobDFXWVIzc0NDWm5DUCsxVk40Q2pXSEY5emptRHdDR1ZG?=
 =?utf-8?B?cUZkUVpGZVZYZUhHWmxHbDlia1NwTVhXZVQrWkpISFlFclRWbkNYNjdWSEp2?=
 =?utf-8?B?Y0llMGpFT2ljYVBKYWJyb1BnM1plM3cycEF4NVBZZTFnajRKV3hMYSttSm9Q?=
 =?utf-8?B?YTZSTUVWQzFieks2OFg0Y3RYcnlySXJlejFYVjRQYkphTXgvT3ZDVkFMd2ZP?=
 =?utf-8?B?QVExckE3eVM2b3dtVVpZZUo5RmRTblF0RnMxblFXUEFYQllsbFBsRnYxUzlL?=
 =?utf-8?B?UXorVEV2ZUlJcjZHUVkySkdpOGFFamNzQlhjbllHWVdVZWFQSjhZRDRMWThE?=
 =?utf-8?B?NDJMZEYvYXJWYkRzYkkwM01yNUsyWnJ1WkVGbmtULzhhTmRpdG01WGc4RENP?=
 =?utf-8?B?ZDNPdm5yT2R3Mm8reklkd0VoU2NKMXhZaW5zR0Z4b3JhRGRSMXZVREtsUTNs?=
 =?utf-8?B?aVBLV3l4OFMrTzF5ODNvSzRiTzlZM0pqSHpLekRCdGNrcUtGNlFhN1ZSTFBy?=
 =?utf-8?B?NzdRSmlWVXhUbUp3Tm12ajl0TFRHMnFSd2ZNRWVjbGhRdk5ISi9PVHJwTzlw?=
 =?utf-8?B?cVJsZmE4emJ6VTZ3QmRzdG5JMExjQXFuQ29mREF4Q0xYWkdwMDIrcUFxRlhm?=
 =?utf-8?B?TVVrOXhydUlrWWRINUl0S2NsZlM3R0V2TWF3RDFHMzVNMXhSbVlNQ2RyRStE?=
 =?utf-8?B?RUhqK3lMV0JqeDNIenU5cUhsRkNZNW84enBHQmNTTGpnaGlDVVMxTzNWTzlW?=
 =?utf-8?B?VFBFWHU5YUVoaFZSM2F5elBBQTZ4ZUpHbjg0emU3UW10UGd1RGJyaUg5OG1x?=
 =?utf-8?B?dVgvWDVrOUNia2lUUjBnQktsUVNpRTkvWWY1ZUttVGtlR0puemZiQmZKVDJP?=
 =?utf-8?B?ZFppSXE5RUlGUk94Vk1DdnJFclYyR2lRYXI4UUd0eHhyZFVOZUlDdUVEZXJv?=
 =?utf-8?B?bW9iUWxBdnozaGZmRzFlZXQxS2xMUDgzSmVWYjFpVU5tUzZDMmZmblhTUTJN?=
 =?utf-8?B?eU9iZnhCdzd4bDJLMmdWam1vMWdKUnJPUmtiVm5paG5LS1UybGVIWTJRbE44?=
 =?utf-8?B?KzloQ2VHV0lvRnJ5ZVNFRWZ5T2sxNzdYdGllL1JzTUt5VjdHMVhnNUNYMnpT?=
 =?utf-8?B?cU5xSm1kMW5rcDdqUnlWZmdlWk8vZEF4bmNORWl4QWxjdTlVTlBBOEFUZWVz?=
 =?utf-8?B?TmphYitIc1JCZCtYc2dGdHhSUE42L080ZGRQd1NKcGdpZ0FMNy9OMFNIL25m?=
 =?utf-8?B?cDFSelhCMERkdGUza2ZoTjJlNVo5b0JwRi9mQXRWQnhuRTFUM2Q0eWdsU0tV?=
 =?utf-8?B?S3kzWWlXWC94dmlsVk1TQ245MHVjaTg2NUtYK2JDaDRheFcrU2dDbmFtVllD?=
 =?utf-8?B?ZlR0R0Z4WU5SSmkzaTM0K0pDMDdWN2Z1UFJuOXByYVV4R1FpZStsczh5ei82?=
 =?utf-8?B?UmtzK3FBTkVwYUxEZGFIUmVIZEFFTHhFOW80YmxKNFpnVW01STJOYjB1SkMz?=
 =?utf-8?B?YWg2U3RaZWJmVW42a3U3QldTNEdWall6dTU3ZHQ3M3VhVGtXMzZoSDgvKzA2?=
 =?utf-8?B?bmpISEtBWVdhYm5saksrVkVNcU1kL1R2UHpZcVR1a3MrblRsSTBvZ3hxRERN?=
 =?utf-8?B?SFBKdTYrdjZLR3pya0FMbG9ZOEdJK0c0Z3MyRW1aVVhDTXFPOXZHMTJTS2ls?=
 =?utf-8?B?NE9uQmpEVXVnajRHT2Q1VnhrQ2hNOVc4Z1pQQjgrakcxOGNYb1NUYVZjWXhU?=
 =?utf-8?B?QWxsQTFGRTZlVVAvMnkybDRocU9XRkpzbm9tcEFFM2RlclIwTjRaRDYxd3Uz?=
 =?utf-8?B?ZVFpaHVxT2hRRXNtUndYNGRyZy90NC9JWDcxOUtmSG9VcDZiT2xudXJPSS9F?=
 =?utf-8?B?b2FLTFdrZnBsN0NKamtaTGR6TTJLQ2toRGg2bDhOd3JSeTJBNzUzVnpBa21Y?=
 =?utf-8?B?K1pjYS8vSGFkV2pITExpbTBIK2w2ZlZaSmprR1hPUk5uK2tmZSt0MVRSbkFZ?=
 =?utf-8?B?TnlxMkxPSUh5VFh5VUdlVGxtelJsYys4ODdSVWxCbkJzak1QdzVRRlVVL1lK?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?MEVhNW9RS2ZtQ1JxU3ZFTWdwdHBvbjhLTGZMRVh2SWdxdFordCtGRzFHWjBs?=
 =?utf-8?B?RFhZdE52VFlhcjR2Sm5xbGEvVFdSb3V1SEFDQWpLRFlFb2txb2VYK2EzRlFs?=
 =?utf-8?B?SGQrNGFBQ3FTMkRvNHZ4Uzg5dWdKbll3N25iSU9hdnlCaVpVblJzM1RmanVj?=
 =?utf-8?B?SEtKQkNFR3NwZTEveW9TdEEzOWpFZjM3ZmdwZ1FLOFlqLzZFdE90Z2hkWGpz?=
 =?utf-8?B?Sy85ajFaOVR0RDNkUG5ObVZGV0ZRSUtueE1Nc3RkUTRhaXBudGNlUXRENHhq?=
 =?utf-8?B?NmZodlQrN0MrM3ROUklQVlIwYnlXME9ycE9UU0xTRnd4QnRXeDVWbllzTnpU?=
 =?utf-8?B?WVlIK3h3QVRMZGFVcHFpRzY4cWhXTkNOQmhrMkI2NnhBNkZIN0c0eWlHWi85?=
 =?utf-8?B?Rlo5VUdsVTgwWFRpdGUyZlhyYlJ0andqMW8yUzRWSFVoR3ZOSVY3QjY4ZzRC?=
 =?utf-8?B?NWQrYmtTdHMxcGh3TmtQdTlacjVQMUNkbnd0dkRRVmdGVDNVYUJoSmYyN1RJ?=
 =?utf-8?B?cmNvNERhTUNXZ3doK3lXTlQ0d3RFN2R6ZklTSEdBWWY4dHY2TjNNb01qSktl?=
 =?utf-8?B?c0dpaXNHcFJVKzVIOWFneTlvNXlLZnNzR0NwWjdMLy9VUnF6NEN3amhic1U5?=
 =?utf-8?B?aHJadS85WUdKSWR4a1p5K0J0K2drWkVRQTVzWUlSQXZPS0ZYT1o5Nm9xbkFI?=
 =?utf-8?B?ZDZlSCsrb1VPaUd2U1VCZnpUdnFtUWdhb3JXSFYxOG5Rak5EYzYza0duaU9Q?=
 =?utf-8?B?bkVqY25GTHFieEFRcWEzUE1WQmEzZTRyRzE4Z1dwZ2UxWGprb3ZMVGNpM1ZB?=
 =?utf-8?B?c1VuTE91ZjEyV3QxRVp5V2ZIenc2ZmZvc21rRzB3dnR4OURMbm5PRTBXdWda?=
 =?utf-8?B?RWRhcitqQlFCMzN2ZVJhNEQrQlRGeFhwa2ZxcW5TZXI5MnArdFliem1WVEh1?=
 =?utf-8?B?azVQYzFJb3I4VG5obzFpandqRXlwOXZOdHpVMUt2aVJKdExtcm5JL2xGTDFp?=
 =?utf-8?B?elkxNDBqQkdwcllEQjkxREhlbHRVa0JyaTI2ZDYrcjFPOE54YkhxcDBiK1ZR?=
 =?utf-8?B?Y1JHSnRGamNFM1BzMld6R29FNnpwZDZhMVdRNmk3K1Jld2F3NHgySHBrRWdL?=
 =?utf-8?B?aElYb0I4OGJPTUhzMmVRc1MwSXNNNVdhQWU4aVFPRGtpMGMxYW5lY0RGSGpS?=
 =?utf-8?B?N2JacXBqN1V2QmdxUlA1eW9XcjFoOFhuUStiLzBDZ1J6MkhwR2N3dnUwRTR5?=
 =?utf-8?B?MlN6K08vLzkwZ0VIRXBhRWY4STFkRHRFMGoxM05WZkQrcklJeWN6cE9NanJW?=
 =?utf-8?B?N20rL1hRcjdGRmxyMUN4RlVpNGdHcElFVStTNHdUZGZNZTF3MUxRemd4ajBI?=
 =?utf-8?B?Q0w5R2pmemZaQ25yUFlOcmEvK295UUhoU2dPc0tHeURqVEtLdUZuWm1nWnpw?=
 =?utf-8?B?L0p1UE5pTjFmMmpIWWRLZzR6b2RoMWQvNXg0T1E0ZVBWMUk0Umh1bTJlMCtJ?=
 =?utf-8?Q?PXm1lQzKLvQ0OTv4Nc0fIbsIade?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8ea386-8eea-424d-8817-08dbfbf86cec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 16:27:40.3110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTX4X+9U4qFLuj10eNv+SzVlXpoAWtS8NFONxmaa3gjMqppw+qGeQb5ISzL17WEa21GnDbuj06I6wTPcLWiCPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_09,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130117
X-Proofpoint-GUID: C2j8wE6KyRsX1GaDWiQEP545lPQu0Ka4
X-Proofpoint-ORIG-GUID: C2j8wE6KyRsX1GaDWiQEP545lPQu0Ka4

On 13/12/2023 15:44, Christoph Hellwig wrote:
> On Wed, Dec 13, 2023 at 09:32:06AM +0000, John Garry wrote:
>>>> - How to make API extensible for when we have no HW support? In that case,
>>>>     we would prob not have to follow rule of power-of-2 length et al.
>>>>     As a possible solution, maybe we can say that atomic writes are
>>>>     supported for the file via statx, but not set unit_min and max values,
>>>>     and this means that writes need to be just FS block aligned there.
>>> I don't think the power of two length is much of a problem to be
>>> honest, and if we every want to lift it we can still do that easily
>>> by adding a new flag or limit.
>> ok, but it would be nice to have some idea on what that flag or limit
>> change would be.
> That would require a concrete use case.  The simples thing for a file
> system that can or does log I/O it would simply be a flag waving all
> the alignment and size requirements.

ok...

> 
>>> I suspect we need an on-disk flag that forces allocations to be
>>> aligned to the atomic write limit, in some ways similar how the
>>> XFS rt flag works.  You'd need to set it on an empty file, and all
>>> allocations after that are guaranteed to be properly aligned.
>> Hmmm... so how is this different to the XFS forcealign feature?
> Maybe not much.  But that's not what it is about - we need a common
> API for this and not some XFS internal flag.  So if this is something
> we could support in ext4 as well that would be a good step.  And for
> btrfs you'd probably want to support something like it in nocow mode
> if people care enough, or always support atomics and write out of
> place.

The forcealign feature was a bit of case of knowing specifically what to 
do for XFS to enable atomic writes.

But some common method to configure any FS file for atomic writes (if 
supported) would be preferable, right?

> 
>> For XFS, I thought that your idea was to always CoW new extents for
>> misaligned extents or writes which spanned multiple extents.
> Well, that is useful for two things:
> 
>   - atomic writes on hardware that does not support it
>   - atomic writes for bufferd I/O
>   - supporting other sizes / alignments than the strict power of
>     two above.

Sure

> 
>> Right, so we should limit atomic write queue limits to max_hw_sectors. But
>> people can still tweak max_sectors, and I am inclined to say that
>> atomic_write_unit_max et al should be (dynamically) limited to max_sectors
>> also.
> Allowing people to tweak it seems to be asking for trouble.

I tend to agree....

Let's just limit at max_hw_sectors.

> 
>>> have that silly limit.  For NVMe that would require SGL support
>>> (and some driver changes I've been wanting to make for long where
>>> we always use SGLs for transfers larger than a single PRP if supported)
>> If we could avoid dealing with a virt boundary, then that would be nice.
>>
>> Are there any patches yet for the change to always use SGLs for transfers
>> larger than a single PRP?
> No.

As below, if we are going to enforce alignment/size of iovecs elsewhere, 
then I don't need to worry about virt boundary.

> 
>> On a related topic, I am not sure about how - or if we even should -
>> enforce iovec PAGE-alignment or length; rather, the user could just be
>> advised that iovecs must be PAGE-aligned and min PAGE length to achieve
>> atomic_write_unit_max.
> Anything that just advices the user an it not clear cut and results in
> an error is data loss waiting to happen.  Even more so if it differs
> from device to device.

ok, fine. I suppose that we better enforce it then.

Thanks,
John

