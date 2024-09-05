Return-Path: <linux-fsdevel+bounces-28712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7277196D5BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D661F280CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 10:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B961991D4;
	Thu,  5 Sep 2024 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lFMHAVTA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P26NErNS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0957D1990DD;
	Thu,  5 Sep 2024 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531620; cv=fail; b=S7Rt0j+AAbEcczA9zVDUgDaqvJqwtEBf/fBvaKHWd6Rx7mtZgilYURjkU2li0mJImmAZpw4l8nQ+naVpI1bm0Y62DvF6tmZtLg070Q6TuSyIk9bhqL4+THNTgtB0Hiu7K2nH+Egd37ppmTw2uXAw8co85ZxbpkAB5IlEDudJIt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531620; c=relaxed/simple;
	bh=pw2aNt2lmbFACFUY8G4gteJX/JC5blGDtzyj7nbatvc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N7DC8o9mlnI2Q+GQgeRM9CsftebVJSxlNLwVZwoGWQ23Ry3D7tZrT4Ecz+A+C0bZgz+gtNhav2nTsv9d14MgpErkzhlyuCX6zfO+pGCN95XbZEFFkQugvBoWH6SdJHkkZ9Ki1Dy5IBXSD4DiStVUal947AxiR/kFZDsxLC0UuyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lFMHAVTA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P26NErNS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4859BmbS005958;
	Thu, 5 Sep 2024 10:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=6NT8LXBQfUV860aWIG5OhVZSHWYVrAb25WQxbnzQ0GE=; b=
	lFMHAVTAM54tZMSDLr9mPI6So6zJPnnjFn4y10jh2vCFp5seqtniIDSnH4FaN4eN
	lVSJy7ZdCcRXVzxuvKG9/piTdnlIXZmcjEdjy/jLytVD2oQpzv/lmJIGYDyNDA3v
	UuviwyMX+VsqYPnlLUrEYF0sgUVECleCqUSa3t3zUAO09/A/SGg83JaCeT06b2yu
	Tp/lOHF4sHKrvwTpwHACS+lJPy792XS96TC0C9u/rxqrPw6tORLD2y0akczzoYcy
	6SomYRudT4Ja64JWutEMWkT9ZhvpLS6C8yoCkvMub//nFYlrE+2QshFRRt8kNsTc
	eZYuM8RwXsnQ99SJMT+PxA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dvu7df5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 10:19:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 485ACKC6023619;
	Thu, 5 Sep 2024 10:19:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmarfdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 10:19:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kw3mn9BDYC2pV84laVUDcH+dX6pbj0RRMVJfqjo4M8T+nwil2uyVZK3DhSObSlcm1u4YHOUHiIQRbd8fkipsgFYCQ8IlD622+0ha39jq6Ht+O+d7NH652rOHlukl56RMu9FHzk10Kb83hMHTuztGIaF/3c0N+l7+4S3ib58I/BmCE5PApbxw8Kma8hQ58Idvt5e+ajcaVWtj1rolszTiQoYF06Jeg8kiQbpzsh7VyKRCYMG+2zyo1mRihY5/oWGpp/f/5DFmvTfM5hgMCcsUFGuqRFPpqm6+Y1NcZ5jCqJRFhvZFfkeJA/hV66DGQsD04eF31HpMgV7GzX/yWpsc2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NT8LXBQfUV860aWIG5OhVZSHWYVrAb25WQxbnzQ0GE=;
 b=PaBsw96qI9odTyQF2DGFRprklMxw/4wK11Uubb7JHzg629jo+wrRXa84WK+Cjr/tOoOIAxt4znLPQve9XNsCNywfSRmonVJbUu7Tu+Q0H8wtz5tUNqKEOUykXdNZhcNQiHlqC8+OpCN8AGpSvXYmth+azivP9CYuXnp7TZj7xg889Bbex7pEPviGm89pRgOh4wHq+SolhV0Re7FmQEnTGRaxOrzaYVUSXuuzV6HJOJNoMwgCstFsK63cVw/ZmETav19W7+0ELA3Kh7fLFj/0Tk2NtBtNiLXhYrAdpdEFUZshuqPKsZ9UaaTAyvV+YABn0dbSjxhogsy7J4NDyeO1EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NT8LXBQfUV860aWIG5OhVZSHWYVrAb25WQxbnzQ0GE=;
 b=P26NErNS4Ut6oLZiCI1tdUuzjmkYEvkSRilwTLVYdEMfj3H9DQUwqeQGVWcb5yubjBx9WLmURvjdoRKrp/Qisu9GGR01UU4zo1kwMercEDSD4Zyjs8PQeBCarE4qpzb0g860vWF87pR0ibeaKVwhaql0Iyl2A9n3tK8DccRHZo8=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by SJ0PR10MB5859.namprd10.prod.outlook.com (2603:10b6:a03:3ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Thu, 5 Sep
 2024 10:19:42 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%3]) with mapi id 15.20.7918.012; Thu, 5 Sep 2024
 10:19:42 +0000
Message-ID: <c6e22d5e-b8d1-44df-9e00-0a6b076e1804@oracle.com>
Date: Thu, 5 Sep 2024 11:19:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/9] ext4: Add direct-io atomic write support using fsawu
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Luis Chamberlain
 <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1709356594.git.ritesh.list@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <cover.1709356594.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0018.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::12) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|SJ0PR10MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: af98bdc7-9b43-443c-86d4-08dccd944166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SE8wdExabVh2c2ZNc09RT1RYS1dwenFtRHcvbUJUTVdCRndERndQekxxc2JH?=
 =?utf-8?B?RE83YW14ZGEybzVXWGd6VUxJWFlTa3MrQ3M5dXJiOWhJRmlQbFdOK3FOM1lO?=
 =?utf-8?B?Uy9pMFpTWVBUR09Kc2FOVityMCtQWEV3bERoanBZRlhqcjNJWGVDVSs0azA1?=
 =?utf-8?B?WXhJelhGOFFJSUg3bHhkSGdybWZIb25BdkNWcmwyU3JmRllOamZGaVAwVitL?=
 =?utf-8?B?dVFqeTE0TGIyMlR2OE1wdWlGenJHOTBrQnVNVWVaNTE1RWRTMmpFQ1F6VUVv?=
 =?utf-8?B?MTJQMTRnRG4rTjZib1E0aWQ0R1pwWWdPY0FCeW1iTjRPclh3QTlCREFHWEtP?=
 =?utf-8?B?d1ZkOThXSVVRaEhtTVY3WkpIQ0hVZkxQNVBSSkozcUoyRlMxd1F2eEtMRFZ0?=
 =?utf-8?B?bEt6QkVuSXNKNGp6amcrN3VLczdNNGFsdndReFlOdUJMcFQrL1dnWUV2QkRu?=
 =?utf-8?B?dFNTNHAvZk82TDBzTWMxMHNTYVZiZWdjK3dJWGorVDBQT2ZPSXFXVHBHN3lv?=
 =?utf-8?B?dk1PZlgrdXhOZWVxa3pRUXZRdUtRb3dNSTd1VHpGV1ZtbjlGY3VnTEZxeDdN?=
 =?utf-8?B?MTZjd3hRMkJ4TGFVQkVkOHMxQmxmMFltQTVxTDRKRmIyamRYUFk5VjcvRERT?=
 =?utf-8?B?Z1NHYzNvM1k5SDlqbEVXYi9ybEZNNGJ2ZWJxQkdwMXUvWlB6YVNySWQ5U0kz?=
 =?utf-8?B?end3VGUxeWFYK2g3R1dFMTFhZjU5dy9rNTFkTWFMUFpqcHBGeDI1eGZ2amNM?=
 =?utf-8?B?RXA0SmI5cW5UQXljalRta21paUpoMkZVa2hsMWFhckVEdU4xZTU5Z25zdEJJ?=
 =?utf-8?B?K0NSa202RUxkVkJHVGNLWWxiK3N5VEFoMDdaNW1Tcjk3UGpsbExvZkNwYkJk?=
 =?utf-8?B?clYzS2JyYmVSaEJzd0dWMGs2TmdZNHYzdERKQWJiSlNuSGRLTGk0OGlqd1NR?=
 =?utf-8?B?bmxvdzNOTlNHaTZrV0tqWGhKRlc0MzNSQ0hraGlEMVlBcVdiekJrSkttSzRE?=
 =?utf-8?B?QnNtQXliMDk4eE5tNWhxWXlBOEtIbFcvLyt3YU9pVXpkYjh5Zmtha2Z2OU1r?=
 =?utf-8?B?S2dqM3BJYWx3OURCbE9BVExlRkRnRlJ1eHNpcVR0bC9nQkNKUW1TNUdya2Rh?=
 =?utf-8?B?Z1VDaCtQcUFMNjJDaDFsOEdSd0ZWeU9uZ0FYQklGNWRCbDJneXVoN243aTl6?=
 =?utf-8?B?SUFlTzBId2w5T29xY3ZrNk1yUGJaWk5WNGZYRVBBa21xSm1uSDNoMHc2NlM3?=
 =?utf-8?B?NHQrRjNKTFkrNkp1bU9iWjRBUnpJWGd2ZHp0WmI1RmNQYUhVRGVzWURzaDZs?=
 =?utf-8?B?WHF0cHJrYjlJcTBpRWN0R093OWRZNkE4UDcyMjlHemNLVnVhejlFdFNRRGZs?=
 =?utf-8?B?dTVIbnF3NU5ubFR0TUE1Y2dQcmd4UUZtMkJveEdTQm0xVFdWVnhyV3VaTEVO?=
 =?utf-8?B?L3V3ZXpCTTJpcTlGZzdhcjhGWms3elZLKzNkMU90a2xIQkxjd0t3aGcrejVF?=
 =?utf-8?B?ZmFVQmI2c3ZOeDBlcnRucW1FenZhWkx0R0ZSV3NTN2cxZENjZFh4bUVzUkJW?=
 =?utf-8?B?VkxIWmV3cTFJejh4WmhSQU83blUxdXllRXhyemJxN0VITGN4RkNpaWJrK0NS?=
 =?utf-8?B?TWZVajBhZVJMaGNLZ0luV0tVaWxmTnc1TllJVjFMWUM5OGs1MlVvWG5sU0xQ?=
 =?utf-8?B?Vnh4OExIU3NDZlo2MmcxbjRuSXNjdEFMeitaNXB0RzdBeUFack1KR0hnVk8x?=
 =?utf-8?B?SDFxRmsrNUpEeGExaXJQUGhyQUp2cUZCSlJROS9HRDNubVVPdGx0OE5FaDdI?=
 =?utf-8?B?RnRXeFg3a2YrdUhDb21EQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkxuTUxVRjlWeVNCVFIwbEF5S2xvRy9tQXhxWGtqampNOS93T3Y2YnFvQ0NB?=
 =?utf-8?B?NXJYSVJBNUJrT2Ixb3pnOVBpaURzYUVFM3VvWnplSjJSU2ZIT0hXekxmK28y?=
 =?utf-8?B?cGxlUWdwWTliaDM4cGRTV090cjRXY05icUQrUjdEajVmRWJ6VFF4b0REbkRo?=
 =?utf-8?B?R0FzbFdWUnppTjcreUxjQ1RweGpra2FyZUsyK2hXVVdhT1dnZk1FVENpWitE?=
 =?utf-8?B?ckFLbytJd2dPMDNObk9Db3JpdUxxQWg1OFp6dWxCbVZlZlZpdDVpKzI3c29s?=
 =?utf-8?B?RHRmVzZmTlc3UWNEVkM3ZW1XaXlWOVNNQ2xqU1lVVUdQbVlmSFdncG9PZjBu?=
 =?utf-8?B?YUVLV2J2NWpxUlFPQ0tYcmFQeTVOSEhseUdMSFRRb2M1VXZCTDJBS1JMLzVO?=
 =?utf-8?B?aGpDSmVXK2REZ0x4eEhMUlVmd2VrVGwwV0pmMUFQRFFvNlZUVkNNVE5LQWVt?=
 =?utf-8?B?QjhFRm55d3l5ZUZjS3JvZEdDZVYyVmZTeE15RTdjeU02S0s2NW1wVzNPaTVN?=
 =?utf-8?B?RjdMS3hVS1lyZGluOWI2WnhOTkNLR3piR2ZNK0U3dXU5eXBOVHhYbkpIQ3Rl?=
 =?utf-8?B?bzFvbkFBNkVxejJqcFJza0RMR0c5RlhwcXMxSTh6SDAzbWFXamNDU3VtRXJt?=
 =?utf-8?B?bDdQdElOaUJxcWROUmJiTkowamhvZ0U1N3M5M3g5Y2hXZTZnY2swMGlOUlJX?=
 =?utf-8?B?OStLVWhXQU0rdUQ2cmI5UUhpVC8rT1J2ek00aEMxZU1pd29vT3psbXFMYWpS?=
 =?utf-8?B?Uit5ay8vcVlSQ2tHNnVhditDV3o2WmFqMlhWeDhDa05WUlZaU2d6WTBBNkhp?=
 =?utf-8?B?bVRVbnJwTC9LOUl0Z0tsZ05VZTRXMXZzdEtpUGthYzhpZzFyaUYrelNkVTN3?=
 =?utf-8?B?Q3l3YjJtOTFRaDJKSVJObFFXbzFLdmdVNVZVekg3Y29Fc3NRWWlSSFRyTUMx?=
 =?utf-8?B?QkFnbzlwcFRpTG1NYVNHNXNmNVIxYlAzcDNQVjBUNHE0QUs3eGNmeE9WZ3FL?=
 =?utf-8?B?ZC8wenlUNy9GQ2ZUdXYvQUFaYkVycEVEQkJBYnZBbXBYSzRTVXFENEp2bERS?=
 =?utf-8?B?dVhLU04zNjV6QW5NeHRCN1Q5U1pkV2RSK3AvS3pBcmowZ0lGTEJZZnVqUGcv?=
 =?utf-8?B?aWFGazF6eG8zWVFiRWxjRHBnb3A4K0Fqd0gzN0VnaDlrdjA2RGN4L3RZZjgv?=
 =?utf-8?B?S2NBRlNWTHk3Y2VkSktZaGdKUlhGQVVFeWpmNlZuQWhVcXZuWkE4akN1Y01a?=
 =?utf-8?B?SDZDRS8vSXh0L1J4c0RVV3pxeUhDOGJiMVpzaVBuS211QWFaMFRQbGwwMUpv?=
 =?utf-8?B?OVNvMFNrRU5maUt6N0ZHYlBuQXpkZHJsbHk3OFNPdHBIczZRSVArazZZYXNu?=
 =?utf-8?B?MDR2alUzOGJaUElMZm1PQWJsT0tHNExQeGo0c0l6Rzd6ZnBDbkpSdnd5cWpq?=
 =?utf-8?B?aWhxa0VvaHptREtUU1EvWlZlak5xdmRjcUZ1dmhqTHBBQkJka3I1QWNreks4?=
 =?utf-8?B?NzljMjNJRit6WnoydDNQOXRmcWZGMWYzeVhqdWx2MStNclE4bWd6aDJVSU0z?=
 =?utf-8?B?YkVpY3RvaWVFYWZ1SmVuU2dPbUhOVUJzZWdIZGlhVys3bU5kenJDUmdIQkZr?=
 =?utf-8?B?eVhFR1NxSm9mbjlaWHNib1ppSFUybVBFemtRLzdtOFlYVS8wZVVvT1V3UGJW?=
 =?utf-8?B?RkhLKzRnQzBzSitKUDk4VWk2R29WWjBQeVdBOGlaWURGQkhaYVA0amgyYzZk?=
 =?utf-8?B?UkR6OUJqVElUUDJNYWlWMWtlTDYxczJmOEsxSmx4WjZ2b3Jma3pwY0RvUVdQ?=
 =?utf-8?B?ZWRSeTB3VVlUUkVtNXJFcDduTUFrdTVNMTVVeUJHVHpMYWIzUzMvdUhrcFZR?=
 =?utf-8?B?bXoxTnB3Q1hFaXdDUFZHUFNwR1R6SlIvYmNaZFlyNjcrVHBzRm8waUh0a0FQ?=
 =?utf-8?B?dWs2Zlo1ZXhEOUpCUUZmL0ZRaHRja09hcnNqTWJ1eUo5V3M3WCtYMVNvQnZ2?=
 =?utf-8?B?dG85TnN2L29xVVo0bE9nS2lRYjhLQ0hwUVoxeG5zZ1dVUkcxejdHNGZ2cGtF?=
 =?utf-8?B?aE1ab1dMYy9IZ2hoZFUyRzR6MzZUalNqZkZMc2hpQWM0aW5VakVVQytyMUY3?=
 =?utf-8?B?d2wrZTFUV2tiaUltVnNMMm1GaVBORmlXMlZTRXdnSFRZZy81cTI2UUczMTRS?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JftFMnUzpxO6gm3RbSsgoCnLdX/heQ/YXuMqpPBE/koV0tMFfU1Yj1Q5ZcVM7FmVfoieHvEmZvx0Vm1D02jFLg1DPNvcGwqjHpBPTZvvTbREgeaPsqU4TAAViZjRXYYibMHNz8oN8md2kUw/G51J8RkwkZ74qXPy7lI+VflzQgzNx4+VErK7Vxn28rd8RRIl4nIASrrV1H7fEM7BIMXAHyEVmtZ3oeAFoRc0KueCHNCkp9UPRcOL84DTyUF9YbxtA+DDYqpgUeH1vDQVBCfVDqtguvtElgXlCA0M/VdpVdX8G08gNmeFbAhAv0T2Q2oqqhh7HkGAOcugBuaq5NNukj4Y4arcY/oU3g1c2HuNjUwYtWXS/CkiSfubtYYKtOv1l1XBG1vRQ0h5UJdqYJV+SX9V54aUM1GLQRhcnWgHYEL7gul5Wd2sFdz46T4B7VPLXsN0E7DgofIqQog137AGWFBuMTQme9CRUN4Tt6VtaYbD/tzap0T/Wc3m38RcY48ekQnL3+5EobF1ZAtD42JTq1dlc4lZjls/J2c9yv/0POapuVMrJcB3HjhFO8rFJGlNdUjiUqqdJDsAwqVtORrSL/ZWlhPcjhNJjYSBF/tmKPk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af98bdc7-9b43-443c-86d4-08dccd944166
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 10:19:42.3377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kd0iCTukigDRV7xeuPfyNkp3Sl4ixllQIdfQXwukniDb4C7E/UzHlm0JxHUaY5n4Y6kLi7DbGnw/tSkQjjBVwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5859
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_05,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409050075
X-Proofpoint-ORIG-GUID: BatEPlMSpjTP0S-YoJ_iLYduqIjQ1M97
X-Proofpoint-GUID: BatEPlMSpjTP0S-YoJ_iLYduqIjQ1M97

On 02/03/2024 07:41, Ritesh Harjani (IBM) wrote:

Hi Ritesh,

> Hello all,
> 
> This RFC series adds support for atomic writes to ext4 direct-io using
> filesystem atomic write unit. It's built on top of John's "block atomic
> write v5" series which adds RWF_ATOMIC flag interface to pwritev2() and enables
> atomic write support in underlying device driver and block layer.

I am curious - do you have any plans to progress this work?

John

