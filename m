Return-Path: <linux-fsdevel+bounces-43595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD974A5929D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 12:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE89188CB0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 11:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4198C21E0B7;
	Mon, 10 Mar 2025 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g17MA3YL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Iy9kaepe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E871221D3F7;
	Mon, 10 Mar 2025 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605641; cv=fail; b=DSTb+OyIZ3OlMRgDw4H3E0wGcs4noDaOrQGvg1UW5rVagp2e2y/lelD8pO8ZKseQPEA2ppJEmKqd59E6TNvPoAf119plSaGEzIzUm2R0x3WETotdsCdLj5qTPzVS4x63eC6ti0DNdhnS8PjhslnwUMM1Jiz8NcbmUkVnYzhu53A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605641; c=relaxed/simple;
	bh=THJmrvOA/jK7PvrUcX4cDaP+t597wrXUY1L8I4Ins2g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LMbBIXnhyCt2NH3ecYf1fy4XPtsvgEdXhs3bJ6k357faNMCMFMgtyHDOAmyhSSNPcrgltUjfo9yCuaBfcFyBAy0fuNHuoojH9WPa/VaAcmrsxAbK9hpZDKNgQjRT98X72CjpVqdEgMrWrYtKyNJjGpXYliR9BH531hstXr2Hrw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g17MA3YL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Iy9kaepe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A9BiFR019169;
	Mon, 10 Mar 2025 11:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ZAOVErEgNsxdwzIahhIshrCeLjmC2JnejBwoZIL8JKM=; b=
	g17MA3YLOKfiqF6KLKVGqOAtOvgy2++HVWVJK/b0HvAirIlewezUldBl8eK7mkkU
	HqZbTUi/YCv7ZI3E81yJKgThrySpTaYBk6FJlsyTtpgLeAnc/Nmug8p2yyxBtFob
	2oCLfnKr4awgPwSNsBR1inIPIe9ggX0q8R4T7Dg2VjsDutTr+FCFvx/K+uEhIOA2
	s9Cnu+Fgp+0bbx13z7Dj5/iRIgG45snVILc+OShGlKv6Jfw5fiGCvwKIaHKw8ZQf
	xShMwwAq+grtno37A+9oeNLO26JkkAl3gsEG6aI8a2qqHFT/A2Dh1vlM2KI9hjjs
	6BBV+vnNgiqbp+5mHRpZCQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ds9ja8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 11:20:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AAV2mq030529;
	Mon, 10 Mar 2025 11:20:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458gcksmwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 11:20:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpwECXWNrqfG87ivBKHXh5gjS7oBsF3VMt5orVxIaawvRYhpHat/RSCy6B7IezwJcGa0uh7a4wCF1hiLi1jCZuVJ8jEfiKYOYFb+Wyg9zourOerjYNTu9Tpnvs1I2PGz6/L7WOQ2wopEMFQqbGatsLF8+UnrMt6onzuP259PmoOQMw9y4SyTac/GV5rY6pwrGG7ew0VysI/5e0nJ9CObeO7KBperhy6xPc17BHnE4mOs8nY4VWIBK7cmbyVy+MqrlW1T/TjoxwknqXIyZCIvVYXMp7Mi+yxlXgLXH0NXNO+lpVXxMyjJ0AlOVKWWbvBHesLmmb5WmEdx6f6mThToTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAOVErEgNsxdwzIahhIshrCeLjmC2JnejBwoZIL8JKM=;
 b=nrCKqjvUtYrF2OzD83jcHFt57GV1M2PKIJfk5KJo/KxiT5ALvB4UvFpXtgn548+qK636iJMwFqzT54mye68swIo7MbZM/oOh9f1cjQICw6JqL9O/QaiGQU/Kyyup0fqtFju4IgJ+ih9GJ2qRS526xNuMM472sgNqTCazR2ROS3OG4BCK8vSGrJamH6iMo+SLQr9g1aA8P1CXSsrtJQwWoKBd1PFswUYGHxILqQqLWVmRFsuFScedkMy+oicROAfkIYLy1t8izIa0sGy95Fpmx/yq+2nzsfw+5qhSpG3rx7lMxu9KI9vW7PksmM6d1LUQpsfhXhxGioTyrfI0wGJjyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAOVErEgNsxdwzIahhIshrCeLjmC2JnejBwoZIL8JKM=;
 b=Iy9kaepeSYq/LzryfLuy4QpifKqH5zAP3Rg3IPfzCEZKhU3wwV+ZnQb8WYqLQEXTGxBBpqw1z+fFFnfmUG+tsDaBcN0NqAegn5Npswj3p2xgJ3K4OhAp91cZtPLaa4lLfot9DO5t4O5leeI3bpIaY9J/kLJhzzKLH5QfDKBrpiE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV3PR10MB7964.namprd10.prod.outlook.com (2603:10b6:408:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 11:20:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 11:20:27 +0000
Message-ID: <cb7a9d18-c24d-4d90-881b-1914a760a378@oracle.com>
Date: Mon, 10 Mar 2025 11:20:23 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/12] xfs: Update atomic write max size
To: Carlos Maiolino <cem@kernel.org>
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
 <2LEUjvzJ3RO3jyirsnti2pPKtOuVZZt-wKhzIi2mfCPwOESoN_SuN9GjHA4Iu_C4LRZQxiZ6dF__eT6u-p8CdQ==@protonmail.internalid>
 <20250303171120.2837067-12-john.g.garry@oracle.com>
 <bed7wptkueyxnjvaq4isizybxsagh7vb7nx7efcyamvtzbot5p@oqrij3ahq3vl>
 <QIPhZNej-x0SeCVuzuqhmRIPUPKvV7w_4DB3ehJ2dYmLS1kwYGIJi1F3F34dhPTCy6oBq_3O-4Kjxxt4cIiP9Q==@protonmail.internalid>
 <c2fdb9bb-e360-4ece-930d-bab4354f1abf@oracle.com>
 <egqflg5pygs4454uz2yjmoachsfwpl3jqlhfy3hp6feptnylcl@74aeqdedvira>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <egqflg5pygs4454uz2yjmoachsfwpl3jqlhfy3hp6feptnylcl@74aeqdedvira>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0105.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV3PR10MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 33da4f42-72aa-4aa2-0967-08dd5fc58f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0s1bnFwVkhURWNMK29ja2lxbnVOck5BcjRNOFJkWjdQVEZkOCtGZ21UWk9C?=
 =?utf-8?B?ZGNsSXZVMFl3UW5FVGVZNTVIdEZ6dHR6N0FiY3l6RDhkQzZIYVFaR3NFOTRE?=
 =?utf-8?B?V3dxYXc4S2U4ZlVRU3R3aHZMV28yM002OHo4ZDZ4UXpLVW0wU3FGRmpxamRU?=
 =?utf-8?B?enJNMnY5eG1qTW5BcFF0a1ZLMEMyZUhiNGJLcWhSeUh5OXBjMWJGN3NnNGc4?=
 =?utf-8?B?bjZCZUNaOFNYUys2NEdCUExpTHh0dzFlTVlPczFOL1FLSElnRkJvTW9UWHo4?=
 =?utf-8?B?Qm9jZjYxeGhWVVVGdlBLSmdxQjlNVEhXMVlkVWxwb2UxS3BnNHlLRGZEZHBL?=
 =?utf-8?B?and2Y1l5b1MreHZRVzMwMnlKNmJhMktRbTJJdDVsQW8xekpKNVk5Nk05NTlh?=
 =?utf-8?B?WXUrQkYzNnI4dUxQV1FUVWZxWDdVTW16Nlk4bXg3VTFNd0pRdWVPNDU2NEN5?=
 =?utf-8?B?TENpeVhrUk0raHk1OGRWak9IcmdUbVlQc2tlZnQ1VlV3WFB5ZlhXVGl1dzZj?=
 =?utf-8?B?UFhFdWZrRGMwSXdSWFhQZ0RjMFJLbFNvVC9jYVhTeHpzQkNEUnBZbE5iNDRm?=
 =?utf-8?B?dStIZlE4akR2VUo1aVA3Z0FLSjgvSmFqNVdyOGhZVjQ4dU0zNEI0US9pYkxn?=
 =?utf-8?B?b1hGdzczMFZiSDIyM05ETVRMWXFrL3NpaFFyWXA1SWswTkxqRjhkM1MyNWdt?=
 =?utf-8?B?MU0vakxINEtsWEtXbFU3ZDVhZ0lESUFPMGM0QjZtYysySXhHRUd3VFNCYkFP?=
 =?utf-8?B?RlZONWFaRFovdXVNUEVkSXU1bEVkdmhuSDh5N3Y3TWdjRllidUxWd2poSGF3?=
 =?utf-8?B?UzB0UUgveWJKcFRxZWhVdHcrd0RqTXpEbld1SVMrWUN2d0RwUzZMOERFSzRv?=
 =?utf-8?B?clVGSEpTSEI1UW52b3E4ZnpnRURJdi9mSE1WVXpkcFFkYmJnSzlOU2Y5bTli?=
 =?utf-8?B?NktPWWNDM2ZUZC9leXBDWnEzTWYzMURpSUNPZHhTaS9yTFVBRWt2clp6dU9u?=
 =?utf-8?B?Vmc2cGY4YzJxTHZjb091aTVvR3djcWY1U3loWkozVkNDSUh5ZnpPeWFSaXo5?=
 =?utf-8?B?S1pHOVJocllQbFFQVzZ4UDNnTjZyQm4wTkZ6cTRxMi9MY014dTNLWlZESGV5?=
 =?utf-8?B?R0VpcnFsRTB3TTJmVkZ1TmZTV3puTWdqM2JFWmtSUnUxMW1ZTXBIRDR1djhS?=
 =?utf-8?B?QnVTbVI0ZDhsOWRya1hRYklSWkFUYWxJQnNHVmJNUUlRbG5KNzZEdlVNRTZB?=
 =?utf-8?B?a0J6MDIvYTZ3aG5OTkJ4RDU3YWdDeHU0TDByc09Lb0tZOXZSZUVFZzJuaUdZ?=
 =?utf-8?B?TWNMYmpVMWxqbmkxVTlDUWhKeDZhOXZZakt1QTJ2UmVPQmF5R1ZjdFh3aHJi?=
 =?utf-8?B?NDd0ZkN0U1NXbWFnOWV6MThpenRmeE5Ua1Q2akxFbXplSHFhMHBMZEZoODBL?=
 =?utf-8?B?aTlYeVZVT3lNekNDSnRRTDBLU1YzdkswNXhNcTBmT09wRGVURU9KSHRDTVE2?=
 =?utf-8?B?OGM4SkFhT2N5YWRyczFxU2d2cmwzclVycUNYQUYwQ0dqaW5EYVR5cE9ibTZw?=
 =?utf-8?B?eDlnOTQ0eTd0U3o5ZXp5eDBBaU85R0c2WnBFVy9ZY1QyRkhwbnl6ZHdhSGxE?=
 =?utf-8?B?UmNEa2NGeHcyZ0tjeC9KR0cyT213Ni9lWmxhYzB3M1UyTnVwdlNZOEs4U29y?=
 =?utf-8?B?RUdSZGFTdjY3dnh6em5kRGpVUzg1c1lXcWJEaU5wODVINHowSDFDaDlYRWQ1?=
 =?utf-8?B?UTR4THZZNU1xdCsycHE5UFNxZzYzbTRGVjMxM20wb3JCQ1lkaFQxOGt6NHFM?=
 =?utf-8?B?MFY2VjFyYjJYQ0EwM2NPSjhocnZ5MXBMdVNJUVVIWGtPMFF5S21nM1BOMkZG?=
 =?utf-8?Q?HyIoX8UkIcyg1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bktGYmtPMFM5bmJRbXJVR3ZzNkQ1dFR5NldKc0JaZGwvMG5YVllZNmlvVnZX?=
 =?utf-8?B?TXpNSk1nZVlzUWNOeWxXSXhFbFFpenV0TUYvQ2Q5UXpOSDIrNXE3aWZsNDBI?=
 =?utf-8?B?WTZwbmJOeExpSFI3Y2tKK1hnNktHNjdPNTJjZjI0cHNpTzROb09sTDdRTEFr?=
 =?utf-8?B?UlhDVisyRnZ1SWRmTUgxR1RhSHVyYVdxdXlBNlNzK2JzaFpibUJ4UEtIUGl6?=
 =?utf-8?B?RDZSdDJURTNPQXlOelFXQzMxdmNydXRndGp4SlRRVnRQL2t5aHdOZ2cybTIr?=
 =?utf-8?B?NFhrTUhWR1pERytvQmxnSms1ZHBZdFd0aGRCZkV3b1pxNTVkNThEUHdRL2VO?=
 =?utf-8?B?U1d1TEVDdlRIQWdLRWQwVUhGN20zN2x0U2pUT2oycVYrbHM0M2R2Y2oyTVlQ?=
 =?utf-8?B?ZmxwcDBXcjcxOFh2OWZONkNONERMWEZLUVBybEpWVEdqN29pNzdPVEJoK1Fw?=
 =?utf-8?B?cmh3c2g3dFg3RGVrZW9VQUdVbFBGemlUVTV1VUVtR1FaNzdMZnV5MzFGZDEz?=
 =?utf-8?B?VW44dlN1OXRQTUV5RktEb2wwdi9IWm5HVy9tcElyZnNRdCtrWnB2Z3VEVFVy?=
 =?utf-8?B?bkZiWUhkYy9oOWZIa2Zmd1g1TUlYL3d2NzY3cjlXb1F5NjQrRWswM0xQa1d0?=
 =?utf-8?B?Z2dobDdIblNTbUl6ZFlOOUtsNVRSNktkMHFDMlJlMmFJekJ2TW5MYk9CWitj?=
 =?utf-8?B?Yjd5R1hnR0VYelJmOE0wenhzOXcyVUt1WUlNeEtZRlNSVWlRK3h0bU5wRkN0?=
 =?utf-8?B?ZFRWVDBGbzFwSGJGY2VDTjlqQmdBQWpUR2VvWTllK2ZyZHkyUDRZT0lIQkhn?=
 =?utf-8?B?OUxWNXN1OGxDRnRvNW53aTdXK0RLN0xMZ1cybk5vRFVEU2FSazErNzdZVmhG?=
 =?utf-8?B?dVJDVjZYQ2JhWDlZL2VBdVc0ZmFpL2UxdHRRU25BY0VrRXBYYmswQ3JmckhY?=
 =?utf-8?B?d3h4V2lXK1FBT05qejg0YVUzWWh3MTNLSUpGZVd3NkZvMXlNb0QyYVFIWFdZ?=
 =?utf-8?B?cEFoWmsvamZCMzhYUXNzTkNFdFFRdE53WU4wTDFKQjk5ZE4weHgwL01BbEtY?=
 =?utf-8?B?OGdFWmpWUUY5RndqanliTzh4U3V3aDJPVWplMG5vSmdBYUVNTkgrcEdHYkxZ?=
 =?utf-8?B?aGJGTFpKbFpIVnN4TFB1VXkzQW9GOWpOUEJvelMrbTYvVUZzd0FOOHptUldJ?=
 =?utf-8?B?OExYTi9EbGN6dElPY1FPaDN5Mk5FWk00NXpFMW5OTjEzcmIrSUp3TVZtL0F4?=
 =?utf-8?B?L0RwSDIySTlKcVlzZTlSY0I1VjRDQW1uY3FCa2orY3lseWg1bzEvRURjeC9z?=
 =?utf-8?B?cFhGb3R2a1VTTkJNcElwUEw5NDAzYUUvYXJkRloyZE0yVVhzQ3djYnd2QnVO?=
 =?utf-8?B?RVI3S3V0SDJNUjFydSsxTnFQckpuU1owSFBxWVRyL1JKYTJwdGtPMFYvaTM3?=
 =?utf-8?B?ZmdNSVpxMWg2aHBTVnlGd0ZqclZNNUVrQ1JlVFZxNzQ4Q1NaMVVkK0dSOUpX?=
 =?utf-8?B?YlBkN1hSRDF4Q1lFSXBQQ1kySGhILzE3bjZIRWlWdEI0K2cyNFBld3hDK3Ri?=
 =?utf-8?B?aDFzNWkwZzRQMlRYMlpPZUlTeTZPcmV6a2ZiSVZZTk5hRkJuL2V4bHk4Q1BY?=
 =?utf-8?B?d01QSjc2NTlRK01rZ3dxYmVPK3E5bk84bWZGK2JpNGUwaWdsTmEzdlNUaVRL?=
 =?utf-8?B?K3hLZU9BL0tVaHFkM3FEbkM2VzRRZjllOHBRT1RCU1lxZWU4TkZRdTVxN2Zm?=
 =?utf-8?B?OG90THlZcjBub3ptekpkcFY1MmloM2hsTjI4ZTNFSmJ0NE9NVDZGc3FBZXRX?=
 =?utf-8?B?dUR0SlA2aGg1UUk2dlk1dmdqbW1MdkhoQWFtTDJ5UXg3cXJJNENkY0dNc3NL?=
 =?utf-8?B?cHB0Tkh4OFNqZTBFVFBBQk5FWE13N3A3bkhIN25OTHlROEJRcVpNdklST1BP?=
 =?utf-8?B?Zi9wWVJNMTFqMUFDcmttU3BWd3lOT3FJNTJROWphcnB0WU9FVG5PeDhLa2Vo?=
 =?utf-8?B?NnVya1FtUW5hb2xualpuWThXNU4vcDF3Z2lHUjJrNVcxU0VPTjV4aXFJM2F2?=
 =?utf-8?B?UVF0NVJnR2IwT00wTUp6bFVzTFF5Syt5OTJJVXdRWkVzNnRaN29sMXgrVS9r?=
 =?utf-8?B?Q1I5SzFKZTNvM1Jla3d5Mlp2QkJGS0Z2QjlEdkJYZ1crYkJRK1NiUXNiUXpr?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kfS+MldbjyyAQd6qadq1K0EqNPsqvHGiyRsfqN1seUZd00sWjtptN9/F5KKAUtXw0Rr++AiB102uULw7WiH6jJZD4C5+4Sp8ynORj3Tcnzp+J/i9Rs6N/kvSzRqnIBfRG/2JXCkYlEchBd7bhbgpiQM1ks95avPKQiCwkK4FOIxhV2buF6xoglCoxEBzvf0Rg6Lef4FAKSpP/25b0WZc8DlTnsscYkncOYXGnM8MCrCn+1Yz29ti26q3VttZodNpYMgbdWa4Q+aqRar2SUP0faUei/iiDlzXMMPMzI6gc4Du5P51U+xPwNbYicNy9OO5JCpaG2fuUMF2xBoQ6fmbZEJj0WfFxHaeHR3JEurgblJUdTxAHU8IhuDb3dGUMnnTZgNV0oG9w240Jpwq+b8muaoGbaTjTnFN1uFlqON63hBaGqPtl0kv1ktC7+4J3NyfmUhyx4s05aAvyybAwtk5XfaJM3FgTU3AZ53PcCb4a/Eew9Zm/I/kWQYGIGju45U3/b9uPoakCo3teiIb7XrNYQZKa8yfZRfsY5IZgdQjNIyBFrUqbgaP/sBupUjxvCpXUeaO/U5RPVjlGIA8d7devZa87aTUqBUQMe5dGK4LVA0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33da4f42-72aa-4aa2-0967-08dd5fc58f4d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 11:20:27.5916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vrtwn8hyXx+OCDdEKYAfbdHdBMMWpMCm2h8MBDjK+9PAwvlypVvGhZd2sa8f/jy6jzExO3XyXuKTL4QMMDpyZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7964
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_04,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100090
X-Proofpoint-GUID: HnDIf_cHSAMtd7eDeLggE-yaa3ErybIP
X-Proofpoint-ORIG-GUID: HnDIf_cHSAMtd7eDeLggE-yaa3ErybIP

On 10/03/2025 11:11, Carlos Maiolino wrote:
> On Mon, Mar 10, 2025 at 10:54:23AM +0000, John Garry wrote:
>> On 10/03/2025 10:06, Carlos Maiolino wrote:
>>>> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
>>>> index fbed172d6770..bc96b8214173 100644
>>>> --- a/fs/xfs/xfs_mount.h
>>>> +++ b/fs/xfs/xfs_mount.h
>>>> @@ -198,6 +198,7 @@ typedef struct xfs_mount {
>>>>    	bool			m_fail_unmount;
>>>>    	bool			m_finobt_nores; /* no per-AG finobt resv. */
>>>>    	bool			m_update_sb;	/* sb needs update in mount */
>>>> +	xfs_extlen_t		awu_max;	/* data device max atomic write */
>>> Could you please rename this to something else? All fields within xfs_mount
>>> follows the same pattern m_<name>. Perhaps m_awu_max?
>> Fine, but I think I then need to deal with spilling multiple lines to
>> accommodate a proper comment.
>>
>>> I was going to send a patch replacing it once I had this merged, but giving
>>> Dave's new comments, and the conflicts with zoned devices, you'll need to send a
>>> V5, so, please include this change if nobody else has any objections on keeping
>>> the xfs_mount naming convention.
>> What branch do you want me to send this against?
> I just pushed everything to for-next, so you can just rebase it against for-next
> 
> Notice this includes the iomap patches you sent in this series which Christian
> picked up. So if you need to re-work something on the iomap patches, you'll
> probably need to take this into account.

Your branch includes the iomap changes, so hard to deal with.

For the iomap change, Dave was suggesting a name change only, so not a 
major issue.

So if we really want to go with a name change, then I could add a patch 
to change the name only and include in the v5.

Review comments are always welcome, but I wish that they did not come so 
late...

Thanks,
John

