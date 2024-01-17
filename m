Return-Path: <linux-fsdevel+bounces-8177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4CC830AE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 17:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D316C1C241BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 16:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B294224CE;
	Wed, 17 Jan 2024 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GT1VoC0C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BKko5IBb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D811F602;
	Wed, 17 Jan 2024 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508272; cv=fail; b=A4G61EuSSVtYU65ZJRCuKzydbyPg48kEARGUtPNK/WJB0VU7B7HPpU1G6wv7Ti8gsjY7dHhonVUPQ6qUkY7RWjbXQKWNMntXI2HknLUvlK+jI01bbDx3BvyxgrmfYesoSDRiCX35Simvp4eGVb/L/13qmMn1DIMi2aGnLndHE1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508272; c=relaxed/simple;
	bh=vGKjnTl4+LqZ9xW9WbSSzC1uVdlNJCQHuSKnXf5g+wA=;
	h=Received:DKIM-Signature:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID; b=AFX4hY9cnHUM6r+IKz6/5X6sVaUBDN2m2d8qpBqneyoN2xzLC4uWFBdc8HmoiQOhrk/rHxIFGbzdUzLVd4fdHBo5zO0GFtgqvHtUYmyEbwnK1F41CI0KxUZBf0C2X5j84Cvn+Tob1Xh25/GcUO1xDpkXMjc6XzmuvyzJeZRZ/MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GT1VoC0C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BKko5IBb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HG0ni8029319;
	Wed, 17 Jan 2024 16:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=hsrPGYzklSDwmLX7oIwjh3x1rXVuMgjbWXHPwUaBOLY=;
 b=GT1VoC0CAapOzuUGIK5SVQNRils4RqrTxbkzlqFahoBFYfisYg7r6MQtipq/gRfjqFBL
 qXLAKZbXMlRIhcuvZN4fAb7tJTzfNlpy2KbpXCAuQfPiJzZvhjIdsX7MWcPd4Bjp2czr
 ogIKMvyakzI/+EpTXop7l1q9VKjLV5eujMSdfHtnPBxsIPpXMWsIwmmKaMAeicqbUa+U
 3CXioz2lnLW+1CmZYeeNIeMvl901qJyAraP6/iopPNg2tAdlBXZUijJ28a45QIrEca4f
 GEDIQr5BVkgOPCR60+Rm4CCrTsW/G3bacwoQT3QJMLlCrRJYvizv3fX85Yr+LrFGIeK6 vQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vknu9r0hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 16:17:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40HEvCZG023306;
	Wed, 17 Jan 2024 16:17:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyajy38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 16:17:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yi52vUm7bGNTWsXnvdDzU7rXHl7J/9qRMtEsoSTWxUvF2FUub5no//ViOOCyTqr4/9tD5VpA3GYQasqO5SayTlj8B4Y5WrNK8NUMmmmUppxlmSzFY+WYbpMFx2zcgp486T9Ymgs+5CA3ZYXUp/ryy2ChxVNRQMCCF33Vwhv9ifTQEQ+Mh0kNP1UVuYX1sXGu4zXmi1iNc0YpdP3xWGOTnI62oE713tQyL4PqV2Z55FP2JmRu0umBWJEcYn87sWNK2yFcbWBSZzIW98+WEmRoy8YUaB4QR/8IN3dKjJptMDKX+43Eqq5GD1cbLjYpiSodInR0BucPoZ28gOhAgoPzfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsrPGYzklSDwmLX7oIwjh3x1rXVuMgjbWXHPwUaBOLY=;
 b=kllQtvYq3hQf53s3GvA6eXw6oFMpkK7qoQQUFAc2Y2E61dUszi9XAh7mmBcUf8xTdVoTkn3sInRuBq+k5oyLfsoWVOV96QEJBoDiu+JK+MZPjUITOZ+UO/aA6pxYsCUgrRoctXLvMZBIExxor3DSZLW+EnYwcfZt9ZwUYIrmAOiMOleFxqU8hTLy6GswLe9hyEMae7r/HpQgWrzlsSOOE7KkfZ8iNdQ0CaGhdp53oVxUK3JMJUZYmFIEiz5293bkQUAF0DS7y6WXwbPOdtBRYegQHj4TQ6abWgi0W01L7wFbibTYjEdKccPT/w8jyVEA1iIFrAGyPXmjbhyO4TVcEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsrPGYzklSDwmLX7oIwjh3x1rXVuMgjbWXHPwUaBOLY=;
 b=BKko5IBbXZAur5UvwpjTWL3xmPvai0NWU1sy6+HsogjarUCfQBd8IDFHaLtKAKpkvFGZSF/uJWpGKw9LiDzRjVZCzOfuTStqJX3pjZbCz9zxUkOGhmI/NhUPtZsJI8TOTko6PEJfh43zKUSKwDIRSL/mEreLtP9DFZqIIg3hf2U=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by PH0PR10MB5612.namprd10.prod.outlook.com (2603:10b6:510:fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Wed, 17 Jan
 2024 16:17:02 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::c29d:4ecf:e593:8f43]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::c29d:4ecf:e593:8f43%7]) with mapi id 15.20.7202.024; Wed, 17 Jan 2024
 16:17:02 +0000
Message-ID: <16a6e6e9-b7b0-40bb-9860-324ab7515a5a@oracle.com>
Date: Wed, 17 Jan 2024 16:16:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] block atomic writes
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, axboe@kernel.dk, kbusch@kernel.org,
        sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
References: <20231219151759.GA4468@lst.de>
 <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com>
 <20231221065031.GA25778@lst.de>
 <b60e39ce-04bf-4ff9-8879-d9e0cf5d84bd@oracle.com>
 <20231221121925.GB17956@lst.de>
 <df2b6c6e-6415-489d-be19-7e2217f79098@oracle.com>
 <20231221125713.GA24013@lst.de>
 <9bee0c1c-e657-4201-beb2-f8163bc945c6@oracle.com>
 <20231221132236.GB26817@lst.de>
 <6135eab3-50ce-4669-a692-b4221773bb20@oracle.com>
 <20240117150200.GA30112@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240117150200.GA30112@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0234.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::11) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|PH0PR10MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b75a5f-7406-400f-bd74-08dc1777bc98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fKRcuBK9u5ijkWSi8h1RaEzZZhJTTvVbwPqrxCUlrYjEg+yRzrf2dZTGHHhdxZDJSa2EyNSATh6QPg3LSpIRM8h3/HepDBKmXMeCJM0hyIkeKsMBjGgpAduAkziru0rq9hrR/ltYYALIQzJ5MhO3/bkXPQTXimBiEjvDm0JZSdj9Rt0KNjEmMYK7zi1fduCXMgCLHRBx56iaBnlhtzqGZTKPvZUlBeu6PN3ooyIPrurtVEXXTMFz9gP0mxcfm9BIMn6Rr0m4Dwj5I8WqTMj0DqoFfVCXrnNZ62Lprv+/kfpu3biuprhOWXhtFnw37Xz8cvOAYgZZoLpyaUVdSLYpKjF42zlB6SjR5uYAemHi9XGSQizUj0AbyVESsrazDo8Hd/G2xPS8dWj3T48ONYHUOaC4X6va4jr+Jaq/FpV8BJ4qvGnWQTcfyF4O3VOL03NbasBQMe/EUOfqYxJ/TzrgTS0aRxNhBSn0c5PuUsyPVV5rwdltRM0H4COdk4uBxz4z+Bi1USU8lP7FDB+IDFt+xQCksiSn/kJqwmye5+cerdDqD6brmE0FKwYhA9BWPv7D+TZ94sa3TbDvpApoyBLxBd3DAJSByLRVNOmmlZGWb/s15HcmNWNkmzSq77Tq/ryKDwQFCpsx5eFUfdFq1TnXxQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(7416002)(41300700001)(5660300002)(2906002)(36756003)(31696002)(316002)(6916009)(66946007)(66476007)(66556008)(86362001)(6512007)(53546011)(6506007)(36916002)(26005)(6486002)(2616005)(83380400001)(478600001)(6666004)(38100700002)(8676002)(8936002)(31686004)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TmZRQ2xNOVl2QmMxcU9XdGxPR1ZWalRINUhrd2lkZ0tkLzZ6d251eEo2anp2?=
 =?utf-8?B?T2ZUNUZBWFhlY05kQXlMVlpDVlloQWl1WXl3b2ZFZlBGSDErTUNpYytIS0FU?=
 =?utf-8?B?RFRsWGd3MG1BQ1FuWTU3Wmh6TytneUdJTGhERXFuaFlhN0hLb05pdXZZakFk?=
 =?utf-8?B?dTlscVB5eU95bFNIeStwNlFvSGM5cjVzaVZjTnVrVmZkNzJNbUdHKzFzQ0dz?=
 =?utf-8?B?a0JGYk9BT0dZa29pTGRTKzgzL1VoRU9KNno5VTU4UDhzYk5raHRhaDVYNGsz?=
 =?utf-8?B?WHlhZWRtYTN4clhoR0FQOGRqTk5NY2xuZDVNSDZheVNPbDdrQjlnT1QyN2ty?=
 =?utf-8?B?MU9QREFUaElOeDkzT0orYzRRYXBQYWlPTG1YRWdKUitPaFhFK05QRk5CSUwz?=
 =?utf-8?B?Z2pVSkV5UzVrR2NhaG9wS2JHV0E2ZWRFUVdLYUtBN1pRaVFTTzV6WkNnTWxN?=
 =?utf-8?B?eXRzdGNCV0U1WktiVDdYWXV6bVNaa2laYzYyeWtEUjhSalAwZXBHdGw4T2Va?=
 =?utf-8?B?ckJJbVNnOFEzNHRVdkpjR1l2dGNJOHVHY1RORWtZNmdGS3orOWtrRGl6Y0kv?=
 =?utf-8?B?MERLdFJ0MCt1bWl0WXNvbnllclBRYlBSZEMveW1jL1dvanAzNWFQN3ZReG5i?=
 =?utf-8?B?NUZEeXRtQm1xaGIwaXMwMWFpSHVYOTVmSmhkbFBZOGlGRDlvdjd5NnphWUZO?=
 =?utf-8?B?TEZETUJiemc2V0hpenVTbmFOb21BV3haN3FZYnVEbVByL1ZZdm5DSS9IbDB1?=
 =?utf-8?B?bGJsWnl4amxsU2xDbDdKdzR0Q0VoUFN2MlZBSDhtc1RkcDNIWjdJcmtRZ2lV?=
 =?utf-8?B?QzhWeDlhQmlvRG1abzREdG5yaTlzUWN0YnBpRXVBNjFmVzMrV2JYKzNYN3JG?=
 =?utf-8?B?TFhjeU5JYzN0R2FuWVJqYjltSWdkM0hoUmg0SGtYRENkeWFub0tPNTl5Q2Q5?=
 =?utf-8?B?eFlJOGZMazZhMUdSN0tKci9RVXJFTS9hbTUrQ1Bkc0g1MTI3MnVFUzJkNm0z?=
 =?utf-8?B?SXhjc3BoYUNkL3BmdkFwRTNPMjV0aDhqa015RElhbU9VRk9VT0oyRmR2Q1dK?=
 =?utf-8?B?UzFVYmt3bGhmT2t3MHBtUWFqN1U4ZG5nbmZIQUMwcGw3UDVpM0d2Tm1sbTFu?=
 =?utf-8?B?dFBkcnVKQzBMei9ETmxvRm1tS05DRHJuNitKMUJpMGRyRnJlemUxTU9ONmEx?=
 =?utf-8?B?aHloNGpZQlluUDBsL2Y5ZTVLcFNnVklqMWhlY2RJS1AzS2pWYlducFMvNWpU?=
 =?utf-8?B?VkhCTHZ1YUlBWVV0dW9ZWndlSW9aL3YyWVRhcUpKb095dVpCRXVUYTA5ckdD?=
 =?utf-8?B?WkNheFNBNXNQUW1hNFdNQWlUdThGbjA4NWgwaGhlbXNzZ3BMZkxrL21rMFZv?=
 =?utf-8?B?dVJYQk5mSUtvQjk1NHBoNVRjUC9pTlVkMStzYjJpTUVQcmtqYnpLaHRpYzNM?=
 =?utf-8?B?b1gvOXJWdTBmbEF0OW1pSUV5TDJRZVM0dVU4cWxULzBaVVNLK3N3M0RMcExB?=
 =?utf-8?B?aE9OSkhEYkgvbFk0MnJPNGhFYTNWbHd3TXBUNWhUNGJyVHE4bGtLUmowaGtN?=
 =?utf-8?B?KzhaRVNXWmNsTUxFY29vUTgvVmgrZEpmZ1EySXNSNlFMdkhpc2xzOU82bksz?=
 =?utf-8?B?TVpPZVRTZk0va2xsem5DaGJ0RW11QUJVeXczRitNbWFaR0RUdFhMNXE1aExv?=
 =?utf-8?B?K1ZiUmFtK1dlVmZDdW96MU9Ja28wWktvOXlNZTFZMUNSYzBQQ0QxczdocXEw?=
 =?utf-8?B?SGdtUkd3Q0JZdFZWT2VZZ3RmVUc4U3JSSzlkbC9lMTV5TE5LOXpYb0dISFkz?=
 =?utf-8?B?TlJYTEJiRVhPTmlnZWpOcGVDQnpJNFhOOGhJbDNWd3UxVTB1U0I2eHFZUlZ0?=
 =?utf-8?B?MzdUNjZ2cWN1OG0zdTFUdkN2U21VM3pwN1dLUVNweENOL3E1TWU5M2Z3VGVl?=
 =?utf-8?B?NG9oTE9kZkI5VVZ6YlloTjR4bWxIUWJ3Ukcya2o0bVJvTVJrbUkyVHh4bHBo?=
 =?utf-8?B?VkNXc3dETmFacjlOK2p1RnNSb1VSQU96MEJsNG85SzV2dlQxNDY1YUp1YXRl?=
 =?utf-8?B?SjJ4ekw4SGk0bFpZdHpSVEhNK0dia2cwSUY1ZTZKOFc2eDlURWwwRU1UOVhJ?=
 =?utf-8?B?NFN2aVJUckQyNzJuSEo4MHh6KzNuSW56Rk9qazlRSDFNRE9vaUswU1lEZDhn?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VV55dGg41VOucT2EEgJKXa4t9Pc0ruOnMFprcYxMoKKZIQ858AO4YXOJ5b4WbXeifShvCa/G0KOzauUfrCXRF6qNE8HgFuH3pO23kLof1rpAZ9fcOcAJMTMo2J++ytDaYwsmG74V3ELKyBYURqBTf0zjsfsigeuwAOOECpnIIOUq2zIWs9NiYCwyiucVmTY7bfHddGjw1/qwTyJvtBIWXlZmX1uj/twB/qeIjNFjztL2teqm7eeO/6aIJI10OfeqtE2CbDNbAkTT9+A/3LJEm3cYcLcIKXA6j7ALrU7nSXGHECNOi3Lo15oLNUzOrVL4qPoOaS1vM1lZQQsPXNrhssj6Tbif/7WA+JkOmGjuigxwsWZWC4Q6V+8q0bXrgpn0R5s/5O77O9MsMjKjBaIiTAOEAQNik0oIOyRhd+UWPP6ijV1iurPOTfk0P8TC17umCy8yCA0W1Qy1G8fTZYKNwgX37WhWYXfFiOkhIu5+lGmCkAj9CXFUtky00ML/AFaPUVHjqWUbet2+PZaww/GIvD9zEzId9lgAREDW4FV6ACM1X0gyYK/zGPE7ec9ka8W/QYYgOV+DxfJnYgcMRe6pKRr8hGLBRt+0mI1EK7mS8vQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b75a5f-7406-400f-bd74-08dc1777bc98
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 16:17:02.0932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzND9t4/dah0BYxAuCz8JMntmF68wCjG2UNs/XZmEyMNIjbOoEN7yUYBci4NLfjfpmxihStwfEphBKLQHZF4aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5612
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_10,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170118
X-Proofpoint-ORIG-GUID: 90JbNHEOxNoeFC3dFCu7wbV64oKuXJB1
X-Proofpoint-GUID: 90JbNHEOxNoeFC3dFCu7wbV64oKuXJB1

On 17/01/2024 15:02, Christoph Hellwig wrote:
> On Tue, Jan 16, 2024 at 11:35:47AM +0000, John Garry wrote:
>> As such, we then need to set atomic write unit max = min(queue max
>> segments, BIO_MAX_VECS) * LBS. That would mean atomic write unit max 256 *
>> 512 = 128K (for 512B LBS). For a DMA controller of max segments 64, for
>> example, then we would have 32K. These seem too low.
> 
> I don't see how this would work if support multiple sectors.
> 
>>
>> Alternative I'm thinking that we should just limit to 1x iovec always, and
>> then atomic write unit max = (min(queue max segments, BIO_MAX_VECS) - 1) *
>> PAGE_SIZE [ignoring first/last iovec contents]. It also makes support for
>> non-enterprise NVMe drives more straightforward. If someone wants, they can
>> introduce support for multi-iovec later, but it would prob require some
>> more iovec length/alignment rules.
> 
> Supporting just a single iovec initially is fine with me, as extending
> that is pretty easy.  Just talk to your potential users that they can
> live with it.

Yeah, any porting I know about has just been using aio with 
IO_CMD_PWRITE, so would be ok

> 
> I'd probably still advertise the limits even if it currently always is 1.
> 

I suppose that we don't need any special rule until we support > 1, as 
we cannot break anyone already using > 1 :)

Thanks,
John

