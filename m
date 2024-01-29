Return-Path: <linux-fsdevel+bounces-9335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B57840134
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 10:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D613828111A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD54857895;
	Mon, 29 Jan 2024 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eqtqcmFB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dXEVXfQT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C698D57865;
	Mon, 29 Jan 2024 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519889; cv=fail; b=NGcaa2GIkAirFdzmUdyOfKmEcymAmEuQPi6GQynDysO57w+NWty89N/E748bOuE+raDaeYm2W0UwAJjsAYpF1Fav8acssMNUkqozx2TEYq5NkbcdokTDAsiME/BYW2F3c0AxKK+Qg/MbRIufwhNu4g6q2NvfJQsJiLxd4VsvIxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519889; c=relaxed/simple;
	bh=/sfAZ7L3l/0NvQ1cVGx6/3f84sXh93T1m8A2NxmTqDk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u72KIY958QGKRlJj9S7zd0GI+5iyG5JIWg8pu2E1rZB5+NZj+ZYTyZKE53/vNqXpzvRdf7VJ37T8Slh60cnZNLY81atu8Z5DEwSf/eLtIWmBJ06N1SrS7k0L+z6H1OLfBdTCaXqXowUSBucMf1iLD5AV12cAw9J62UMUacMK3yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eqtqcmFB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dXEVXfQT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40T6x3NU019955;
	Mon, 29 Jan 2024 09:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=pcpJ7JgzhEEn2EGUcwn3HUGhg1VWOomkfkEt6VV2p9g=;
 b=eqtqcmFBSSgnqx2NYWYdaJkoum4F/4/9+pJQ8XTkp9ipJuLHUDYDtGWKvE5joBTiASF1
 y3HAk4ZhayxkSW6gz1U5vfPApPUwuh6vQkGMGGv3fqWknpAKA8Idt5xb8rFYF0jpJAvL
 sX8gVNYxEl2odNP2JTEGs5NeGlku9JTj8+KtjAyX9oMJwkDqqdtduq2+A0mLkRerj93h
 pcF4RQO4/Od8/IG23bWd6xi2TnUB4MvXyTav7d0ddQEMQCvveig65X6KfOQxVhp2Fqe0
 EEbE6mdgxZ0WFM68Zri9gA05VBN/HYv8RutcnxERECAfiDfDAKr4F7Ydcgce/G0W285d BQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvr8eb8d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 09:17:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40T8QEAa014589;
	Mon, 29 Jan 2024 09:17:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9bm21f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 09:17:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKZvvrRQbx/hX/ugpohPQTPu9rymy3LLTZqIKohX6yJ9s6813/WsEWp46ZRce3XPnyGPxov2trkdVIj7K788oct63jfwTimaDJRGBL5o9pVgXanKPyTGK1mt9cZ5wQq9+MaXqqP9FPu0g/Bl3kW3hL1NQC2j0aEVJiK6JIstd2UDfwwdNvnic42N+ODSJa4Z/elA/3p4hqAjN+m2LGVh50TNw1us+qw8K4TN+D0c9PLRkReSQxZErTMKuPYUkZrf39BVzEvkUlpg5tZPIM6DllL5Ffsr2JncPMFxK5Xo+2x2ikg5hYpKhdSJy9mm7Z131PYOskotHUk8sWany40zsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcpJ7JgzhEEn2EGUcwn3HUGhg1VWOomkfkEt6VV2p9g=;
 b=hvCPPamT1XI5VZRWspa/U6jxGaVvRLXiib3ehHdD/hfeKDHbxuJSDbo2dFC5edz3/SSiaEuSlh3iBN+ZUz6I6FyQYw69CCTJb+/3zUEd50iLUMPUSy4nAkLlkLt0p7lzJ6LMmE5Rpb4XdpLnlfFti8PmExlgse9P/kXtzyXdxHuW8WqrPDFMlBEzaZpHP0WR6CjVrtNXUJXeqW+e6l9VU/3ddKh9OSQDW/pluqhDiC8t5KFPJgl2Kedypo+o31/dIbIGWcsCxlDbyRhyxeFUJbIrotWKy3kT4Pqt8WG46/uyeYDb5OQz9Tvha60S7dNQ2TVyynAWxCbwYa4Wvg96oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcpJ7JgzhEEn2EGUcwn3HUGhg1VWOomkfkEt6VV2p9g=;
 b=dXEVXfQTInI10lo5jwG8DfknJPxmCY0shSENmZJFDY6AVYQw1oDQAwYD4cF+ZwWaPAFFvUX3Ich8zpMDIF+mWu/nBVi1sv4x1NS38ynbAPQ9g5QtPRjBA3PARCgK3hVpYL82CVCQg9TNY+0DcKAipDu8la5+tYOakC/x7xJD/Xg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 09:17:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 09:17:16 +0000
Message-ID: <60dc2c30-bb05-4388-9a17-d325fda25bee@oracle.com>
Date: Mon, 29 Jan 2024 09:17:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] block atomic writes
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org
References: <20240124113841.31824-1-john.g.garry@oracle.com>
 <20240129061839.GA19796@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240129061839.GA19796@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR06CA0040.eurprd06.prod.outlook.com
 (2603:10a6:10:120::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4688:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3a547e-2cd7-4a15-d3e1-08dc20ab15b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vE3SY66546IxO44E/VUiuuJwRQZCzkSSTpj/bfoCX92vQbWuwiQ7RpfZZVS6nfkw2/qETuk6SEZvx1OzW6hRW5k/khMeK7lWUMwgptR0eRWh5VaNlr03QJcQ8rmPvOKAZaXrO9k0rfZU5QrIGt52uNZK9ooBmujQmQXXPXzUJ0DxwNnX6GAXNWLvBMInWh5nl7Ym6TWZ+o947DmUYWBSHAv4foen4ODv+dDpf9zaltXhGA2yVRIXo6Lj5ytamVE6p6EwVDpHABaBV25Ig0mSBiAXREO53SXelDSUIo5kxn+wUqBKbJKbs1AtsvOrjmoa2n3WmhoxT4FP1cP6GXo4jp8NiEofm5kWm/ZzXa07bXRchASz6OYEROHyO7VlyVOkM+Wk5Bvl5jgD4pk68mHXt+FgJVsT0XTN3w3bNvvnaT4ElyyrD4u2CvQpuLvh20YYY+wXkur/yBqxgP/P+rBRRTfoUO5n2Qmhuq5RoE5bBqUNlloQqbYmsmN6FdlpS/lFIlx049HhHL79R405KnvZH89e8eSOXFMAHYX/N1rY7hwUlyzLG901E8bta2j8tT7Vnnvhjgm47z208bdvisDhk5/Sq7rQHK7K0CZl/Dfoi+nw5a1i77/ji0+ZPV0yJU6Y
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(31686004)(38100700002)(66556008)(53546011)(6506007)(66946007)(36916002)(316002)(6916009)(86362001)(966005)(6486002)(66476007)(8676002)(8936002)(5660300002)(2616005)(6512007)(7416002)(31696002)(478600001)(2906002)(4744005)(4326008)(6666004)(26005)(83380400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NHN5aVowSmJwZUk0NVhubjJrMXdIUzBqa092aTBHSy92VlFrV25DUVFUVTFZ?=
 =?utf-8?B?TE82TnpxL1pNREhobjRHOHZVc24zbkZ1QmJvVmhSWGtkR2ZIc2VjQTZSa0tk?=
 =?utf-8?B?TmQrU1U4Zit0SGk4WXNucEh2QTJ5amUyOGpiYVBvclBCeEJ3NHpyY1BRODlx?=
 =?utf-8?B?aUFWdE1rb2tUTjFyU2Z3Rk1IZUt2UHJ2L2I1b2RYb0NRMmZvb2g0K25RVUhh?=
 =?utf-8?B?RTVQVEFhUUtCLzVlblpIRmZtOHdlQmR0ejNrSmlRMDNON25BQUNaT0R2T2Nr?=
 =?utf-8?B?UFRUSjNwRzFtYk8zbTZIdzMzbW8rWXdWc1VHVWRXSmJzWFc3dWFndDdZODJV?=
 =?utf-8?B?WjQ5SXl2YUNGMTlDY2I5QnRNOVpvRjNBOGxQK0JqMmFzYTNlSHFwS0hQc0RT?=
 =?utf-8?B?dCt3NUkwL3pONytvTTQ4SEVxNUlUT2xtVkt5OGpsMGRsSDVsRDFNdGQ3Wk5P?=
 =?utf-8?B?RDlEejlpK29QZkx5YnhmQ3NzVjVPTFd0YmpXNFppTGJSOWtzMzRDbjYra1lG?=
 =?utf-8?B?Z2RaRGhscDdCRldUbVV0c0swS2hYb3l1S0ZHZXR5MWRGdlR4STZLSXdoOTA0?=
 =?utf-8?B?SjBlMGpPSENmWUk4WlF2dkNJdGNFYVZBbkRTbjZUR1lYL1JqNkxQZnhBMGdD?=
 =?utf-8?B?K0ZKLy9ZQnV5K1hrdEptM1NTdGVqb1BYY3RxUzZ5em43OHZTUFhFaGllL3hv?=
 =?utf-8?B?eXRNVUlOM0xxbnFDcisxR1dZeVZndGlrTVFDczJ5U29TdXBReUI2SG9HTDc5?=
 =?utf-8?B?ODZoYjRxWjUrb0gxcHoyMGJCT3hZYzZZdFRnUjd6ZXdLajlGRFJOZUdOdlpj?=
 =?utf-8?B?TVF6Qzdpd3Q1dW9Fc3dMYlN5bjdUNjVURWQ1cmI5aG11VEpCc2ZISVljMVZv?=
 =?utf-8?B?ZEtnMVhtQ0ZMWmZuQlVLUC9aVnU5cnJRL01lVUtnblhOYUZWN2xiMHUwLzI3?=
 =?utf-8?B?YzYwMWd4bnI5dDNrcEZxYzdicy94OVZDM1JYYmtXZ0VwOXRSd1hFZWVzWUxN?=
 =?utf-8?B?Sk1QVDYyL2dzanRpdXNQeXNZUmw3b3MzN09EQlIxUytGZE5odkxrZmdnTmJU?=
 =?utf-8?B?ZERIb3g3Ui9XSnBxSUpTSkVzcVVmNEtZcVh4VU5xS3pMQlBzalpDdnZxNUVT?=
 =?utf-8?B?dVUvUDBPcmRwd1NwZHBGMWJUM3pPZ1ZyQ2xiaC81TUpnMXBIdkNxcFhKbXFN?=
 =?utf-8?B?M1JBQlppRDZKN0k4WTFvL1lIZXZaV3EvWVZLb3Blc3VwUWIxUDZwRzY5OE9K?=
 =?utf-8?B?bzFqb0RReGw1K3R5Z205NDN1Ump1a21WNmRlZDhGQWpwOWVVL0hzbWx1bjE4?=
 =?utf-8?B?U2FsaDBIZkhmeEhsaWlFeGJQcHpJQ2g0YWhvZ1c5anhjbWliUVo4NWJuaDFh?=
 =?utf-8?B?czJtQVcxQnh0L3RrRXBtK0hnYjdVbU5aRmV6Y3dJblpTSTFwLzRaY2R3VzQ5?=
 =?utf-8?B?VW9TZ1ZyVFhHRE5pcmlsSHljSTYzY0VkL3NBOEpBWHYxWlVoWjN4QUZoZGx2?=
 =?utf-8?B?RXlDbVpkenVIRDI2aFY2QWM2MDZLREM1OTlUeFRoSjdmdlBBUVlWVzFvNjdn?=
 =?utf-8?B?SnlPcllTMDNsblNub3IzYUg3cEJPYW1QTnhSV0tEcFpUU3pGUUNqb3pZNU1k?=
 =?utf-8?B?Vkc3MUpUV2paN2pwN0xZN2tnZjRFZjBLNXRJRC9DaHNwOSsyNzVJZm5xSjlr?=
 =?utf-8?B?NURUZzNrQjdTUDlnSVN1bWtoYklNSzFpVGcxRkViRWROSUQxQkFqSFJiWkcw?=
 =?utf-8?B?cjEvOXRSL2Y4ZnB0ekhkeldnbzJsQ1RMZzhvWUt3eFhOY0pkZHhXTTRLV2l1?=
 =?utf-8?B?eHFDTlp4R1JQcEgyQkQ5MUNYR1RET2Q4eWEzUVpDYjZnRmVWancvdzl4eTFD?=
 =?utf-8?B?TCswaUpDNmF6ZW9vZGNhY0lVUjN1d3ZlUHUyNWs4SkNBQlIwL1lUTlA0VjhK?=
 =?utf-8?B?UlpFcmUyQWFqcU9kcEt5ZVcwaEljeU9ZNzI5enErTUovZ1BQWTltMUdDNVpI?=
 =?utf-8?B?TjlDY3ljTlVVQkx4Q2U1UEJqWlExc09US01rcGxzZUxYb0FnOGoyNG1IZU9n?=
 =?utf-8?B?NVhuR3JTVGY2eXFuNit3L2JUY2VuNlI4c0RNejgvWXNjbEp2VXVxQkZlaDIv?=
 =?utf-8?B?eU1rVXNFcjJWdExEMThhOC9RZXkyMGtFV3NYbXZ0dTdJYVNqeEpnQ01KNERL?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ccNkNKiqXYvBsvnM5OLXn1bv7yJvlbuXdFG429gf8VYKc8MwLHEMxDEaGxADPmi3YaMOVxuebgY5umbLzsX68g0arYh6Px+47CRcPOwvq931F+LaBG9AU8+GrxFMpVKanOzp0MkC44iC9J1sObgBYLpmOPH8jGLCGPEei3aU70pFnJOcEpc5fUxOOXy2N1deFa7I6fHmGESx+UXq3dhHph4oqzV3uy/5845o76rjxLL3tnVHGS/Z9gyHYad/CpGaWif9BzpUMeNE43YlENBiDjxTUqXgt99dkVTsI95Tkzw+q+02N/RupRN2PHi4OHuky2Un1X3UckpXylo86II14SwLWLSn6F6zBqvrR6bXMSMvftEpfQci1t1grkqRZkr7G113r+lKYZfe+YjwINQegR6IYPl3MgFR8MWuFiDGgL/SBmc770cJlZz8WO8nNmWPf+9kSnFw3LBZLZvMk1rwa1Bn3eiIb/9gZTUJ6iyCISGIYyLglC5j1kGbmQqNRvzYI4u7UtxUgjQHwzck5GJZw3ZgPyb/9AeUJiBqic4H0DdsGQb6FR1fMSzAepl9MG2HMWStAuuZnxqYadOlhXoicvkyFt0FMGVVk4Pze0I7HD4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3a547e-2cd7-4a15-d3e1-08dc20ab15b5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 09:17:15.7773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtMEXji7RAmaWU/eq4CzmQ+c8vFVkELCng5ajuKpliRvP2MbMRQK3BRVRywTznM0pKzjZjderPR3FJm6q8cQFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_04,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401290066
X-Proofpoint-ORIG-GUID: R9JkMT61rdUSkVEykY7sSKwS13YiDam7
X-Proofpoint-GUID: R9JkMT61rdUSkVEykY7sSKwS13YiDam7

On 29/01/2024 06:18, Christoph Hellwig wrote:
> Do you have a git tree with all patches somewhere?
>

They should apply cleanly on v6.8-rc1, but you can also check 
https://github.com/johnpgarry/linux/commits/atomic-writes-v6.8-v3/ for 
this series. The XFS series is at top and can be found at 
https://github.com/johnpgarry/linux/tree/atomic-writes-v6.8-v3-fs

Cheers,
John




