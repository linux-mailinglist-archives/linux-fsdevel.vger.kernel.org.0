Return-Path: <linux-fsdevel+bounces-47048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F34A9801F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 09:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4606C1940111
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 07:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20802676E1;
	Wed, 23 Apr 2025 07:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YceZHwKL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PdzF6+IF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1628F1;
	Wed, 23 Apr 2025 07:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745392154; cv=fail; b=dxbI9SvuBTvWrMBYDMKaWz/Qp3LvOEEWZwAabuLGipew5fuONGNG+2sBiGcZ6fti1ALfAHYTV34UCp7eiuEAcrT2beZv7kM8p/dG4pYI8dqnjKYc3Ft8opW6PFjG1z6T2mXYPwe0gjHWifBbBL1mTT+mGpuakIVT2WzjVxZuqo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745392154; c=relaxed/simple;
	bh=AT3W/RRJfBwsWDr8/mcOXNGni6lg6BgY27jfUuA0N4c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GEXIXRn+pokdqZ8ioI4+7S5T9kPy9eFSY78diTNq+m4Zg3tQh8VAsEAQtFYzFB7SR+ZU9rScYu+JRigo66LFN0cp92vloSS6bWjC1+hBPFffxoY5Y2+SDk/eYdrcoEs3f62IrfaNVGyIkPRhsgn6vMqB6NYIwMs4t3/O1b7vFsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YceZHwKL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PdzF6+IF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0tkrI018396;
	Wed, 23 Apr 2025 07:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=xH80FdJUhauhqClr6xd7Cc83WfYnmwyDHYO58m+EC3E=; b=
	YceZHwKLy9sNe0qL0c/fJ9syELmHo4kQED4a7lnkb/eLcdP/Z0EL9huSelPwOqyG
	D1pUF6iR6OfCpanqqd9aDEhAXSn5OW7WVCxaqOu/XQuDXl9RAD8HoQXsM12jNKWI
	gJo7fcZmJT9AleTkHQyfgXfw7MEInbLur+Qdk5f+iUvK+QGlCdUyKryUBeCxJ4BH
	F6fjGF77PSV7wN9mJI7o02m4bXb7apQ9TrnH84f1Zv6BDZrsaWB7esWWKwQuh/40
	yUsNfpV42V1QulqQtysQ/SNQjZBywhxXVprkNNI/lQiklKkCl4K+iwn2db7Y9ZID
	6s0JuopAVF2QiXZeidAr/Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jhe0m31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 07:08:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53N5lPWM013805;
	Wed, 23 Apr 2025 07:08:46 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012015.outbound.protection.outlook.com [40.93.14.15])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jxnescx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 07:08:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcmVTLRe7JZZ+au/gyQMMjCutAeCqful8JeX47K3oGXUwLkXNfvX+PGUycmWNwY0PewxtUDiIiMmpX7woGm96BJVGFZF+eJmkVCLO0pxvTvWp4z7lURATXMnIi1j4lV30ZwlbBscmAmcDvcWAXHPby7gppS8JyVnHTndejPF2BnlFPIZSPdNOfMzZMHP0c96PqbQtpu+D6DuShSnasQ2s4QRldz8ymrehPGk6JwUySHxFFAJkqUpUrAxaUKVZiqiiWXDlDTNVQQZozmLcJIxUt8H2+E9IFDobLgwmnJWGp3oAMaqk7LjkCDhl2GRsAwwwytMmcfdASaJhDDQ/Qjcug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xH80FdJUhauhqClr6xd7Cc83WfYnmwyDHYO58m+EC3E=;
 b=rkk80JXgTM48i7ZPI270Ft0/7RcSZ8MRlsAlKXIRNrb9oRfmFIRCO22qX0ee0xKEvTm8XTCch++UC2QmrgGsXxZWUWA5I4CRgNw7zmJkUlwdjPke8XoxirMoxQmdCXTrvx09it9tBiZUX1t0dC6MaC9PgbZGu/S/ec5l/FC/ZE/9yjE9vtma2UkccqzF6qQSY4pN7NqimdGCTk1nOcWeteAo/CVIPNKf5maGQ2cEzqIt+Ur1V3TXzfE7qYe2XDdIj2P6vIx18FgdX1bdDapBcR8lK/28UkMamq3qEawFtMycT9hAiQ2DZcMlrzO31g1G9HwLiH9PEBGgrBOUD7kJ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xH80FdJUhauhqClr6xd7Cc83WfYnmwyDHYO58m+EC3E=;
 b=PdzF6+IFS+9fRUJC0vQMZXv/R+/YgmRRdofzGkk3HgHmSrOYvlJXuI72yEeAEBZBds92M/fZtoXffUGCMroL+Uj7zFVwN3uUeWlq+uQ8Galx7aPbNPAB74SWD3vt2NKEJteX157kwFgmVxbHPdBsZDCNZFotnfDBgoxU2YZMOVE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7761.namprd10.prod.outlook.com (2603:10b6:610:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 07:08:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 07:08:44 +0000
Message-ID: <cf67f166-4c65-4d76-a3a2-1ad2614e89b7@oracle.com>
Date: Wed, 23 Apr 2025 08:08:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/14] xfs: add xfs_file_dio_write_atomic()
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        brauner@kernel.org, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
        linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
 <20250415121425.4146847-12-john.g.garry@oracle.com>
 <aAa2HMvKcIGdbJlF@bombadil.infradead.org>
 <69302bf1-78b4-4b95-8e9b-df56dd1091c0@oracle.com>
 <aAh4L9crlnEf3uuJ@bombadil.infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aAh4L9crlnEf3uuJ@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR06CA0055.eurprd06.prod.outlook.com
 (2603:10a6:10:120::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b190cf-7109-4bf3-1a83-08dd8235af22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGhIUEM5Q2xNeU1KK0VUbko4OE13UlAyb1BkdFYzdlhKT1VMelRQRHZRL01h?=
 =?utf-8?B?KzRjeGlDMFUvSjJBNmw5anAvQTlXckxERXBJRnFNUUdwbFFlODl2eVBpelVk?=
 =?utf-8?B?M1lvaXFBM2J4emdSeXkrSkdOWlBwcVhzcXdBcE8rRnptNWZnSmFwUXlHZ21H?=
 =?utf-8?B?ZlZrdW9MVnB2QnFHN1FEMklWcndud3JhRUFDTUFsbzM2Umc3d2svR3ArZDZV?=
 =?utf-8?B?KzUrYS9mSUltbXoySUZKdTd1LzAvZEtneXZrUkJLTk53d0szUkEvV1JvUDc4?=
 =?utf-8?B?MHV6WkNNazdheHlvODd0TFY0MTFxNXZ3YnpCS3o2cmlZNlV4RTlhaFd6Y0g1?=
 =?utf-8?B?SlE5cHJLZ1BNUDhVejcyU3hSdXRKUzQvNUNGaFhLR3dEVWpZUWJxZHNrRFdm?=
 =?utf-8?B?cCtiaURoMEVEYmhXMXBpQU4xRnhkVWg2VHc1eWFQNEFVSERqWW5Nbk5vc1Rr?=
 =?utf-8?B?cG1ieVVlTno2REpIQk9sN0hha1h5ZnZXcTlRSFFBUG94RDA3UlZUMTB3MExx?=
 =?utf-8?B?RjZmVE1UNEJoSysvSERYYnpQZkVENnFmNWRhbXR5clZHa09EVk8xYlJCckYz?=
 =?utf-8?B?S2o0MVUyaENTTzYrMGczcDgrSGV6em5XelJQN1JUK3dLOWJ1dE00djAvNXZt?=
 =?utf-8?B?NFdMQnRjZTRrd0ZrTTBBQ3NnRWE4d1k5TFpjbTJIYWYzNjRsV21ZYjYyaXJO?=
 =?utf-8?B?NlVYMThQZVRHT0xGWVQ2a3VRb0RxQksrNFBhdERUUEdBdUtkMkxxWEdCcFJt?=
 =?utf-8?B?aVdRalZqMmIzcGdUK213TnhFanpxYzhQWTY1c05VSjhkVGplRnFpYlRXM3pD?=
 =?utf-8?B?UHREamVWd1ZoTnJHOGo5c014VEppN01mNTEzQnlCMW9nN2NENjBCY0dPSHM2?=
 =?utf-8?B?eUZXYWF3cXh4Nlg5SHk5bm4ydS9rdVIzNEltd0NsS3lJbnMxSWYyd2VwSGRX?=
 =?utf-8?B?eExXZmIya2IxSFdRSkhKTTcraWdhZlhXNHZ1MnBYL202YUZNSTZkTmZxWnc0?=
 =?utf-8?B?emFYYUdqdHB1VE9YVitxL1o3TFluQXpUZ0thWVFVanZFSGlIVkRnekVJL1JO?=
 =?utf-8?B?bWVteERTTnd6OE5GTFkxdkN4dTNubHpwT29DY1Z4MVRBNjlWWUFSTnlFTmIw?=
 =?utf-8?B?M0VWSHlDblBweTRNSjNPVVkrbTJNRXB5cklTb0lvN1JNaFB0OU5xQXVJSVZu?=
 =?utf-8?B?d3VUczZUZFd6em5EVmxqWit5TFJ4OHRtQ1pRVmtjZHVvVjdVQUtWL1NZZmJQ?=
 =?utf-8?B?blZZUGZRbE5yNCtKTHNDdCtjMTF3MHo0WUV0Y3BPTXZQLzAvT3RJTVVLM3Q3?=
 =?utf-8?B?aEcveDFNbEhZdDEvUHZqcisxS0FFb3FtWDZ4bFpwVkxsdG45WmhIN2dlMUJI?=
 =?utf-8?B?NzNEVWJSNE1iVWNiR0x1ZHpzdS94TitrTlozTmY1djV2TUFZUzlYRUIxZStE?=
 =?utf-8?B?cm8reVpCS0JjdkdZOW93c0dpVGNub1VuV0RrWnNsS20xM2g1NXE4d05yclB2?=
 =?utf-8?B?M0htSjV2Mm50Um5yNXdqQnROdW9zUFY3c2dpdHpGaWljSmJPRVZ1SWxWaWNt?=
 =?utf-8?B?cTdiaDRJQnRHcVlObkJkR1BNWkJVczBxMCt5MGdqZUlHV2JKOVdXeTIvTGhm?=
 =?utf-8?B?NnpkWTlXLzhpU3M2TzQ4Yi9POVNyMks0cFpNZmlXYUxTTEk1MFE2WW1KeVIr?=
 =?utf-8?B?eHVYbUxnU2h2NnNDNlFnNXQvODFtVWpZWUdaSHZTckNKK3NWSGlQeU10TEFS?=
 =?utf-8?B?UUVJWStkU2R0ckpoYVloSjNsQTNleVdhQzFBWG53VlIyd3c4U1N6N1F0ckVD?=
 =?utf-8?B?bDQySlFmUFdlU3hraGhETnMvM2QxRFh6Tkx4TmdLblUxL3lOT3hNMjM2WXI4?=
 =?utf-8?B?MzdOWmxvejNLdG43dHZqSlhxNDJWV092OGkyYThMQWt5TnRXcEM2K1RSdGd0?=
 =?utf-8?Q?hqny5y80QsA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elpWd3BVMHVXdURWZ0RPbHNRdWVMY09XWTFlZGJiays2UmNKZzFwR2xvMWJy?=
 =?utf-8?B?c3RIUENiL2NnUVJCT2R0UnEvZ1B6RVdTNlNaamtoWUJHNzg3QmlXSmE3S095?=
 =?utf-8?B?OTF5NTNOcU93R3UwRmJWeHR0Z2tpdXVOQysxZFJ3bXFIbGcvSzU5R3U5Qlhr?=
 =?utf-8?B?cndCcmE0WDlJdmJOZ3lTUGJidjZicGxPdnF4ZG1MMUhySzZsb1UycWRqdzZE?=
 =?utf-8?B?TWtDV3h0YS9rUmVQcU5DQU5sWFVvbFlpRnJJOU1CSENCT0cwN2UvV0tSc3ZQ?=
 =?utf-8?B?dUx3dHB5RXRZNjlvOWlPaDk0NVFFSFFiNmpJOXo3VTBTcFJoTnorWGxsNDBK?=
 =?utf-8?B?WncrM2FzeEdwOVg1NGs4MEgzb3c3ekU5VnpCMUdDWHZTMHRTUFQ2d0w5L2tz?=
 =?utf-8?B?MG5xVThINFZJZVBxQ3JOTnZEVUlYeGxPUGdSdlJKaUdrT1BDYzlLclVEVjVD?=
 =?utf-8?B?R1pTZ29ZczE1OEhQVnFqMmRpMllIMnc0ei91UEh2WFlEL1o2Nm5uQkFxTnUx?=
 =?utf-8?B?dlErNkRFM09KMjIyd0ttbWp3dVRickloREdaQm9VWGhaV2RKL1gwYTZzL2RU?=
 =?utf-8?B?OTRZYU9mRmF2RzNKUTFvWHJRczdRMTZ5bDBiTG0ySEZyVE9YUkhybGVjNGt1?=
 =?utf-8?B?aGVWNEdZSlVZMGdWcFpteGpqZlhWTk5pdFBrNEZTMnUxNytqWU5najR3TU9x?=
 =?utf-8?B?bnNHNHNmNFBZUlpUWXRwWnQzdGFoR21vQmEya0p4cys5TjhRTURWSFNUazlj?=
 =?utf-8?B?ejk3Tk0zOEFHMGhRamgycnpRT2Yyd0tCSDlHbk5BM29Ca3ZsUnltZkI3ZEFX?=
 =?utf-8?B?V0I2ektCeHJGelBJb1lsa2M0Q3pOZStMaFJGdFg2V0hJL3R0RU9JZ3JVb3A0?=
 =?utf-8?B?dW1qRGVmbVpFdWpIMjBPMDQ4NlV0dVJ2ZVVBL2lZYVlldVRDSnp2L2l3Q0NN?=
 =?utf-8?B?R2ZGV3lvNFlCOCtYWlJId0M5Y3ZEM2JEc0lCOTZmbE5xWmxTZFV6TERsc21X?=
 =?utf-8?B?SEZBS1EyaERYL21XZVlXYVlla3pMbVN1UmNHeEFIcUUxcXFLZ1kxRU10TjI5?=
 =?utf-8?B?cko3N2lHOGJ6Q3E4YmRvdU50NmdpRlFYM2JQMUtMeGFUbmF4cjhKdmdDSTZH?=
 =?utf-8?B?Mk1pcDhlWDRYY2ZKMGxtamx6K1dOdi9sdHV3dndmNHo1Z01DdUtna0o2dk9l?=
 =?utf-8?B?UEhxTFRMVS9kM3ptc0NrbE1mMkFQazUzOWpkVkZHcFVhSVFrQW5mUjV1MUlq?=
 =?utf-8?B?QmpLYnZ5VVllalNjL2RqYi92RjZJcU1Qc1Y2REh6anBXZDRhNG9IZFBHNHpy?=
 =?utf-8?B?MVdhRzQ3bVlPS1RXSWI2WGxmK0c2RVlZaW5oeGIweEM0cVhjaGExWVNuTGZS?=
 =?utf-8?B?bENUNGEwSkxIWEc1Q3dIZjZnZWxiZlF1WmxMdW5lcjdUZGxwSUFEakIvM29a?=
 =?utf-8?B?WVgxM2hRSzhJcUlDKzN5TWJzaVYxc2szZ2d3N05GcGE2aG9UOWhHVW1HREhF?=
 =?utf-8?B?dTNlMGhTTXpoM2ZPN1lsTTdBRzFmK2dHV3Y1UGRHTVZGamJRcmRLQ2tzZVMv?=
 =?utf-8?B?M2hyZTdmVXZSb0laOTJOa1o4QUZKL3dVL1Z1aElVb1JSWGdHTXgzT3FWUjdD?=
 =?utf-8?B?OVlQeFFMaHJpMkxMSXFYeGdVQytNS3RES1h5ZFNnNFVhN0h2L2hhS2RXZWgv?=
 =?utf-8?B?TzU4amFEUjBEaDdGN1dTRC9EMkRWODAvR0g0NWhaSHNZRmF6UEp4SWJEeis0?=
 =?utf-8?B?WXBqNU0xckhYZTRYOGxjblJCdTRRTHhraStSKzg3MmdCRWxQNm5HL1lTYm1Q?=
 =?utf-8?B?SnhGUzFnWW1yOExiWFZBZjB1d3RRdWExWW5MLzZDcnNONldrU2c5UWpwcEh3?=
 =?utf-8?B?N1dLNmNmVWtueDBMU2E4VThwWTI5SU41MkpuMUxMSEpsd2VrSVl5Wm5ycmtw?=
 =?utf-8?B?Z1VTaHdsQ3FiNE1FMkZqZXRLUUxhTGs2MElHSVBiZkRNK3YzcGNXTmZFbnpr?=
 =?utf-8?B?R1p6SXVSRW1KQlFnRTJ1VDB1SDJhWHJSemQrWGFpR3o0Nm1Qby95UTJ6YjNs?=
 =?utf-8?B?RXp0K3NpRTRkNzk1U3BSYmhlOVNVeGYrQXlEQ0ZwQldyNmdHZnpuc2RReGpH?=
 =?utf-8?B?c0svZUpDZ0JjQnZUVThHYXdqWjVrb3ZhUzBRSDdIcVRPcEVHbGlCVVlxaTg3?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GPLDztDqwebLmfSGMJbMsWrZOO0NleltL5ifu489r2yUHELd6FRFP8UbgUAz5mcaDov80eN1ZX+H2joSl+OLTaEs/2Aj2rUR/uIKy//jGcx0eppdlcPGXjg2zrJEc97Ee26RIBcXxOxvLjaMR3KRbsZEj3KOQOwXP178svTMg3deF/slxc8JGtfkh8a4/dMzi1OoaA3dDvhJkBnDsCrehR04Zv/HlZOJkuxq6xVumnXlZYe87M71HKe7M5xN7x6YSMoVVicESHgIh0vSsCeFtMXn71uN/KIs8x/MWMDc5/QxxUd8Yf+mNpVdRIPZB70Lgh7VfU68/8HbrICA8zRWR5NDt7QpZa+y19CGuvk18CGm1PbyALlbP44hbcrN0oZWR2BvBnLvqjUqGgafLxvu0DZ6kM15Z6RiABS6Lo8xtNh6Q8CNI2iduzCHnYqK66uUs2Ne8xGUwG4hnrpYVsZuj78pqq1wa3jYO+VBH56rz+D6cFGyaPsIa21J3Rfc3Kz8TglUndPXoEGWuQWWx8fEUmTPWvpRHFCOJ2zglSa7KX+6Riy8ZRZU4TVWsdlP2o8EuWsZLWBG9yC93rS/ZU/VvNHUsWxEv6gKPU3Xhg9MS0Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b190cf-7109-4bf3-1a83-08dd8235af22
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 07:08:44.1611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Uim2+rdQXl1qDs3UIT+LI9Rw+HSeyL0+II6/KUbdbCW2VGbfHoLaBXnQZedrCrAhuq6RZUr/ZYz7ngdPayH2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_05,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504230047
X-Proofpoint-GUID: 3gIK41OqePHrfeIhEohx3Nz21pCTsRb6
X-Proofpoint-ORIG-GUID: 3gIK41OqePHrfeIhEohx3Nz21pCTsRb6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA0NyBTYWx0ZWRfX1LfdQ1+tPTiP EEnE1FoK62MjtVd/gG/pKcXXczxUjKOzLQSJcDHI48fs8OMWoDLMrzarwFw8AdC38Py2gYWHZ+J RTF7CT230qJxo5q3Fc3rSG1T9lSbjg7+23eleSSTnGLf2eKZW3k8O/GGD6lYmfLUVgQG5sAUUcI
 hlSiwdxIvibIxq18pRM7Y4SS2WFAkt5OV3IvHvQBaqOUbmw+jxLpPHyl5esZ447QaCAX4hkuL0w IY7TUElJ7u0Ia7map/fyvppcEfGHI6H4/KJHo54Hsh83bkgxmIBBT2ja2Gln/ASgAk3gAM3pyrN jfMpN2i55cnVh9p35DYTY55ziGTpTRBPuqpFejEmy8s01uiq9C9fuxIpL0xkpBtLy5TwBvaSpCy tMpt8x51

On 23/04/2025 06:18, Luis Chamberlain wrote:
> On Tue, Apr 22, 2025 at 07:08:32AM +0100, John Garry wrote:
>> On 21/04/2025 22:18, Luis Chamberlain wrote:
>>>> /*
>>>> +	 * The retry mechanism is based on the ->iomap_begin method returning
>>>> +	 * -ENOPROTOOPT, which would be when the REQ_ATOMIC-based write is not
>>>> +	 * possible. The REQ_ATOMIC-based method typically not be possible if
>>>> +	 * the write spans multiple extents or the disk blocks are misaligned.
>>>> +	 */
>>>> +	if (ret == -ENOPROTOOPT && dops == &xfs_direct_write_iomap_ops) {
>>> Based on feedback from LSFMM, due to the performance variaibility this
>>> can introduce, it sounded like some folks would like to opt-in to not
>>> have a software fallback and just require an error out.
>>>> Could an option be added to not allow the software fallback?
>>
>> I still don't see the use in this.
> 
> Its not the use, its the concern for underdeterminism in performance.

Sure, we don't offer RT performance guarantees, but what does?

> 
>> So consider userspace wants to write something atomically and we fail as a
>> HW-based atomic write is not possible.
> 
> Sounds like a terrible predicant for those that want hw atomics and
> reliability for it.

Well from our MySQL testing performance is good.

> 
>> What is userspace going to do next?
> 
> It would seem that would depend on their analysis on the number of
> software fallbacks where a software atomic based solution is used and
> the impact on performance.

sorry, but I don't understand this

> 
>> I heard something like "if HW-based atomics are not possible, then something
>> has not been configured properly for the FS" - that something would be
>> extent granularity and alignment, but we don't have a method to ensure this.
>> That is the whole point of having a FS fallback.
> 
> We do with LBS.

Sure, but not everyone wants LBS

> Its perfectly deterministic to be aligned with a sector
> size matching the block size, even for metadata writes.
> 
>>> If so, then I think the next patch would also need updating.
>>>
>>> Or are you suggesting that without the software fallback atomic writes
>>> greater than fs block size are not possible?
>>
>> Yes, as XFS has no method to guarantee extent granularity and alignment.
> 
> Ah, I think the documentation for this featuer should make this clear,
> it was not clear up to this point in patch review.
> 

ok, that can be added


