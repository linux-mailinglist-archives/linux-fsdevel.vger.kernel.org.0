Return-Path: <linux-fsdevel+bounces-43717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B70A5C69C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 16:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D173C1693B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 15:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6F725EF9C;
	Tue, 11 Mar 2025 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lqIGwQoI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xwX24AKu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CC233EA
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706603; cv=fail; b=oHw4qjVlgaqMj7H4W9gl0h6vIVXGBJLDmWpxZLwoLM+HvafnICDrNDcxamOLkE0vyx14xAQhHW1Jo5niF9DttNmXCfC594OlYsYMf6ZvuADLqm2UD25vTJD5TKlj1lOwTENfOdbkjPjHiCmiFMeTm6uPoeeyZ85lNYokEa6Mn0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706603; c=relaxed/simple;
	bh=vIadCr/KrgVx9g6lXvX2/NFv4s7zIBa0V5Q7udzO8pA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o+iTZ8kIh5L4ku1O4felsRxu4VUC2EiumHgTJ97K0/Ttnd5goem3c/OcNdR1ybmA9sDK+HBvRh5rkOB7XGQCrCP4gLjk6ChGMqxU2EAz8qV5UHLBh0gsIE0EpJhpKjiE62oif/6Zblfy8cYR4nCl7LNvb1WS1JQLg1V/s/TQIc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lqIGwQoI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xwX24AKu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDN3cw008743;
	Tue, 11 Mar 2025 15:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=aLjCZTU+GUtfswzmizpLSe19Qq8YVlMh73hll+0bHDg=; b=
	lqIGwQoI0OL4oy7Y9O9w/ybPTeKLKEDKrqH6w2sDKshZlP8bQrvdxTlaNQ0/V7EZ
	pxbZKrM1lMHbR2LdueI5uERLaDFmxLX1L3MGGgxbI5LvYDCAxzxJ6DJLAC3OJ3w4
	RiDAx9pgvAvC3oIXk1xuNozkCqV0QR3BEQ9mv1CKIaESXWPwmKLjd3Z3w9o4TKvz
	C40mGO3yJMh7WHSFWAZUxkwo6slKhBnhf7Eb0p85f7EASwPXHj4GWSQzh6UsQe/Q
	0q6wzYgLE005ATe3DWRKg12UfVlq12+0UeLYKbSu/N7CvdB/XsxcWeWxjZFeif7f
	paGk9FdxCQxuA92GF3wJNA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cacd3am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 15:23:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BEMsf6014929;
	Tue, 11 Mar 2025 15:23:11 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbffj1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 15:23:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjEd1S0TzW+25mAeSL5fPvtMWTp2bWg+FDs2NRfb3WDIoEUqrhQmCwHkf0f1ImoWNmcJqlcn4LwJFbsJARm3GV90IF45Yve+KukpoSBF1o25pu6jgXjg8Pf6D0d0UTlW/EPg0KUZvRBLtms/jmRLomluUbkeCaAfXrv4asWre7uMvnLUN+8DnXlz56a3jmr4UDQNirAqMHaKYia73LlnN/3m7XJ7uQEzv/bOcdr2UyAbc3NndJxgbzRZBCmjuBG45/dGJEv4evVqlUCNRiG20eVqioZvuFPdbvT8nTV7PgrakfwouI5my/KQmNBJor63q+2hHixGUwZmAmuZg2Zybg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLjCZTU+GUtfswzmizpLSe19Qq8YVlMh73hll+0bHDg=;
 b=yGGplSdPhOnFIDk34Qf92O1nkNtEk7nJdHJvI8e379aKKmH0H1WcnAKFUWZ2xModBQXgurc/6fLEzf3hZsFbYrqke4Rrzdsp2B/Bat/jsxBISZPvT2uLERkev+zXVonC5c8b5k4c2E73FSYRyjSAuUFUqel5YUTMkKmVNwjZRk3xVXJwOqB8STJiXgVtcAFB5zkS3lv4Qj3K/3lZaHW7PK1rQLUAJHcpNx50LhRB8QhOjcO8iG7lCh2BENBLIg7gs/kOvFFOo2ewUSO/ddQmDv5RM1gxl9LwC0+6lTnOxSMSKGf1sFR8QmAb8SzuPzQhGAq//4NuCLxL43aFSxZ5uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLjCZTU+GUtfswzmizpLSe19Qq8YVlMh73hll+0bHDg=;
 b=xwX24AKumnLRTAlc8O2CDpMq5vTavXvdHwG2cjCxr3wJSOYkHBB8Sa7miR+X2vZq/LZvhwcL01L1tfZZBvapypef557C5smmdqf0wy/XB+h1npapk/45Gj1f1sUPQ1XI2+BnIAxcnfk1mXPibi8U5ChuQhH5J4JCRh2eUhp7GUM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 15:23:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 15:23:06 +0000
Message-ID: <f73e4e72-c46d-499b-a5d6-bf469331d496@oracle.com>
Date: Tue, 11 Mar 2025 11:23:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "libfs: Use d_children list to iterate
 simple_offset directories"
To: Sun Yongjian <sunyongjian1@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, yangerkun@huawei.com
References: <2025022644-blinked-broadness-c810@gregkh>
 <a7fe0eda-78e4-43bb-822b-c1dfa65ba4dd@oracle.com>
 <2025022621-worshiper-turtle-6eb1@gregkh>
 <a2e5de22-f5d1-4f99-ab37-93343b5c68b1@oracle.com>
 <2025022612-stratus-theology-de3c@gregkh>
 <ca00f758-2028-49da-a2fe-c8c4c2b2cefd@oracle.com>
 <2025031039-gander-stamina-4bb6@gregkh>
 <d61acb5f-118e-4589-978c-1107d307d9b5@oracle.com>
 <691e95db-112e-4276-9de4-03a383ff4bfe@huawei.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <691e95db-112e-4276-9de4-03a383ff4bfe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:610:33::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b4d6f1-2a5e-46ee-a734-08dd60b09f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHdOZzhleGdOWmhucFM1UERqb1RhTUVTTHJtYnFHcE9CNjY4ZGFtT1ZOcE1Q?=
 =?utf-8?B?MGt6SkdRRkcwVm1sSytFc2FvakxaekFSaDJUQmtHTWQxNnlFdTVyWDhsVFpR?=
 =?utf-8?B?VEFmQ3d2cDUwdGVUSllUUVZrOFIyMjFZSk51NWQ2MmUrWTNhZFZTRysycldZ?=
 =?utf-8?B?Ym9sd0EyRjREeTVGZ25ac1NKVnBXK2llYUlmU21LVXgwUTI4UGRZeXRwK1BH?=
 =?utf-8?B?dUxZWmRpUkFzVW1GbHQ5eHlRdThtaWw0SmZuZWdod2JYQ0FFRU56Q0dKT2pJ?=
 =?utf-8?B?enNlNVphZHVCVlJoaXNhOGFweGtzN0c5QWN3WXNlOXdpV090dm8xbzFUWUc2?=
 =?utf-8?B?T3pwTTR0T1lKbE1tV3NWbHhnNVFDdC9RaCtZMVBHMmdhZnAzT29kUUtOeFF2?=
 =?utf-8?B?SDdFekw0S1JRVzduMVlWTUt6ZWp6N3dTekpFLy8yL1BDdThoaG9OZjNxZ1ZC?=
 =?utf-8?B?NG1yTGpTQlBHOVhCVFlqUk5FazVkUGtCWk9zYVVzeFVrWVpxeUJ2Q25xWmpu?=
 =?utf-8?B?d1pDVW1PMmNYK3Q3QVA5cmozZWJuRSttZWJoL3JuTlRaZGV3Q016NzVDaThU?=
 =?utf-8?B?cTAycWVNekkvd296MHZIUENHQUZBMHdCZjlnU29ZZHhBR1NmOFVnQ09SVS9j?=
 =?utf-8?B?QlFsVzRBTHlGZjg2YnUyZ254N3lvMmdacjRXZ3dVaFpHaGlSQkluelVIR2NT?=
 =?utf-8?B?cm5JRUlxemc3WXlEOVBZQ1BlZmVxU0hkUWlvdzEwL0NjMGVXZnJ0N3hieGRv?=
 =?utf-8?B?Wi9CbExHWnRXMXFyOHFTTXBTeFA0aEMrTC9xRU9kWSs0T0JPNllPRDBTQ3FT?=
 =?utf-8?B?QmRlalFwV2lLWEZUaHVBaFljV2c5WWdHem5yQ21tK0xYb1IyU0R0UDhZT3h3?=
 =?utf-8?B?bWdvQkRsdEFXcVFoSGhkWXFxWS9JbzN3Wkw2WFhCNkJtNTdyOWlWbkpBbGdJ?=
 =?utf-8?B?UTZJdmlKVFlySzVCOFB4OXFBRDlzaFJxNDZOb3BZSEVSbmt2YUhLLzJnemVU?=
 =?utf-8?B?UEN4dzdNcU83NkZxWkZ2V0RSMms2OTIxNGtYZFVoVm9zOUo0Q1NmSUw1b2xH?=
 =?utf-8?B?OW0xdDJwRGxwSitMbGp4dURMMnVpS1F2YUhGVGNuanBQVDR4cm94ZURYT1Jw?=
 =?utf-8?B?azQwSXFZaHBsUk1pNHhZTVpEZEl5OUdQaDIwYkhLYVk0b2JydENYMmtWdUJK?=
 =?utf-8?B?RlpzS3hsWFVjV1piRzIydTl4S2tWZ0psMkVqZnRSMlFMZFBCNE9SOXVsMDBa?=
 =?utf-8?B?eHc5Y21oNUxRaEFkSXBHSHhJa0lOajZseWRwV3hGTmYzOUxEdHg2ZVhXSjV5?=
 =?utf-8?B?czZmSlR3eENua29WTlJXUkQ1R2ZoUDVWeGFqNUo3Rnl3UTY1aDZsVnoydnM2?=
 =?utf-8?B?N1JDSm9lVUx6N2dDVmgrWTdqdytsajJ5QTZIWFlSRWxud2FzSUpWTE9Jaklo?=
 =?utf-8?B?WnlTWGJ2SUJWSkFneEs4cWJZQ2hhckRzV0RZenQ2Q2J4cG5wci9jR0FJSld3?=
 =?utf-8?B?Yi9lOXJlMGx1WjhnVDBnZ0Vvc0FJQ1MwTURCQmdvZCtvSS9qamtKZGtqaXll?=
 =?utf-8?B?WFZFQU01OVo1c2YrU1JzM2RpMFQwNkE0cEZMb0tvbUdNcnovcU5ZMGxSRldO?=
 =?utf-8?B?UnJ1anB4c3lXTlh1K3ZnQ1ZmSURmemdqRkNiajZDb2JnVU4wSXNhMkVOY1lU?=
 =?utf-8?B?bUYvZ3MyYm1FaWpiYXFTSGg5SmdiR0FMM3V2UUd2Q0crSk1TR1h1UGRCUmg4?=
 =?utf-8?B?emFsSXpzUVIzTnpDcnMyeG9BcnhSM3p3eTBaR1BaL051VWhyNXEvOE4wZXJN?=
 =?utf-8?B?YThXWjNVWXNIQUcvWUJDQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qjc3OHZNcmNCWDdqNjk3SGk0ZFZZZjRmeWlzS0JSNmlMb3JOZFNDbnNZaFo0?=
 =?utf-8?B?bmxMMnl0WjE0ZCt4V3d1dy9HUEl6UzJmTXdQTE9YZ1Z1WFRIUHNnTVRpODZZ?=
 =?utf-8?B?ZjIvVjVpOVBDK0lPSllvOGN6NTdmN1F5U3o3RlFOUGZPTlBWRjcyRmJ2UVBG?=
 =?utf-8?B?MzZ4UWpxSXY5RTB2T0Z3anpSK0VJTGtzSkVZOWE4aHg0MWJjajkyZWJrWXdr?=
 =?utf-8?B?OFVHRVFTWnN6SlBJMVdMV2ljMkhqaWV1UEplU2FuUzNNOENSdXRCcGwzZmdk?=
 =?utf-8?B?cFlzOUt3Y0NBQUo3OW5HSU9xNklFY0lTRlRiNU40R2xrMEJuSmtJNWFSUkxN?=
 =?utf-8?B?OWp5RWFCZ0ZlM2ZFSGNtRWFaa0FGbHNNR3pmQ0Q2QU8vcE5xTThtQncrWWdy?=
 =?utf-8?B?RHYrWkRoQVN0Sk8ySmxWZ2xOeVNRRlBzWW9EUkVVbzNYRGRxN05oU3NMZWJi?=
 =?utf-8?B?V3lUMWJiRThIVkxBdzUvQXliZFk5dUVjcHRPTS8xS2N2WlJLeFZPTDJlQTBi?=
 =?utf-8?B?Tk1RNEt4WGl0T1VyMFNxTDJacm1sVFhCQ3k3aHdXWHhzUjNjZlRHbXRiUS9l?=
 =?utf-8?B?M3VaQ2pUdHhsa0JpdWhrWTZkMTZnRHR3NHJFaGx1SlVhTHVxc3hJYWZDZzBR?=
 =?utf-8?B?VlZDWlVDUHpPRDR1cGVTRmhzaXoxNit4SUN4Q2JhdDFQSmxOQ2ozVkNXL3ox?=
 =?utf-8?B?azJZbzczTGNWSTl5eGZESjdmQ2Y1MGhMYVdLUWhtbEhGa29hUHB2cWdvS1I0?=
 =?utf-8?B?TDArTFZ3aExZMDl6WHpPQ090M01UWFp2dDBCbmR3dyszRnByRmlDR1o3b0tx?=
 =?utf-8?B?ZFBuZWZqcm1vSHZOemVmT1NaR0VENzlINGUySlZYRDB6eE5DbnRzVWFhWmdB?=
 =?utf-8?B?b1VsbXl4dnM2aGNBSm1TMklQRUNkUFVnUEVZWDdibUlIOGJYbkoxQUN3MGZG?=
 =?utf-8?B?d0FIeERkNVBKT0VwOUVDRmdCLzNad0Z0YUxFSmpwT1ErWlhCWFRjOHlyMU95?=
 =?utf-8?B?dCt0cFhPMnJ5MHJwajhkTmhLVnpRWW1rUUkwdVBPcGxaSEJWblgwZ1ZmWmFi?=
 =?utf-8?B?eThaQzRBL3pVcy8zeUxFSmZoM0JHRlM5UGc3bjJIYzBzRElyNHpTSkJBaU1O?=
 =?utf-8?B?a05TMEt2cmFEcUo2VkdXanVNdU0wRk93U2Q1Njh0elZnR29NWEFBc251RlFr?=
 =?utf-8?B?N1paRHN3WXh1ZVAyMXBHRkZwT0M1NFpxN1R2aU1pK2J6RW1VcUtUc3JGdVdM?=
 =?utf-8?B?YzF0WVdQZiswelhLbEJ1bGIwNHBQQnIyeHRpK0tpNDJhNDJvL1JnTnArUnBC?=
 =?utf-8?B?SENqUmNtOWUxZjYrR1BwZWk4Vk00M3B3OW1hT2tEclhFTUEvaFdRbjVwSk94?=
 =?utf-8?B?d0hWVFh2bnAyQlN4c0Z0RFdORzhmSTlKSTFwSWVTZnhxd3JlOTZiVXdYdE5y?=
 =?utf-8?B?WWhtMFVzSS9qNUJjd05tV0xKd3g3NFY0bDFicWZuSXFBNWczOFlDQUVCbUZO?=
 =?utf-8?B?dmV3cTlVV1NtbEQyZnREU1haMWp3WEU4c1ZDeXYrVlRjV0Y1bGczaE82L3Y1?=
 =?utf-8?B?R0NIL3dNRllpeUVNOFFQbUpKeTRlRi9YTEJ4cSsxMkgrbkxiRGE0NDZHODFm?=
 =?utf-8?B?Um5LdllkZ2ZMVjhvcExXUGp0VWhKUGVLdnhMMFhqbWVCeXdDVXhmMnoxNVZi?=
 =?utf-8?B?dGozN2VZcWlmTzJHNVU2M2F3dWE0M2hqbFNxY1dnM3pHb05MamZsMkZTUjZk?=
 =?utf-8?B?UjI5T2padGt6ZzAySkJ4enZ2K3hVSzM2SDdQcmIvQ2Y3OFQ5QjFaYXIzV2dD?=
 =?utf-8?B?Uy9mNGRKMVAxMHhrcVplMGJRWU4rWTdtSllHMkRhY1dWbEl1VXFLRG50VHpS?=
 =?utf-8?B?QVdmUnJsOUxlTWdMUUl6b0dEMFFnejdXeUJzN0Rndjh0SHdBbnVXb0Y0eVJs?=
 =?utf-8?B?aHArQXYvdS92SFZpN2tnaTMyUDRVS3FMMHNRWjhEK3NVbDhWay8wbGVrL05G?=
 =?utf-8?B?ellUeGVpRWw4TEJzM2dLektraGcvWnNPL2dCV2pROExqcDZ5RWEwL3F5Y04r?=
 =?utf-8?B?TGV1SWQyTlZ1WExHbGE3WlhFYmJjd2dTTEFXazl3YmNDK3k2amNITUx0alov?=
 =?utf-8?Q?U5Pjl2bybIU2Siocs0DWkmhwt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UztWEKGN/RwkWSUpYVaMfNJfpc2en870c7gDwKcWi/VwbNma7VIZHda7IpAniNyi6IkTuDLf04lRvkf+nau9YqYLQurG0yspS38ED59oNOiQmevAejv2PtJDOqUje6UtHnfOJqnwaAfatl3sYw79agbLGlDc9IwAn6EwUxxjF5nvtrFgE7hxHkue+oJm2bS51UciAWmJ+DBgMD8is32kmnGWowsVFxfq7Vrsdq4RgGj1b15uY/MOHx1YZDQPOp6rW4YK5gBX/xg/P0jmbADUo2XfFObfzHwjW2651OGry37gKy1b//u9hy0F35dlX+KoT6JWSY+ZOIUSTRdeMethp3TZxy3Ta+nhJMOmBqzOtCvDT5c63eRlDRkNqrpdNEyczyXhTu3HtVnY+ezgnHtl1KDFzJR5ikzgezqeVDgSdL3pB7R5OieqsvmAFlzcy+lVqMBPumN9r4pon6larz7tqQC6ezyBIlfDnWHNc6iJRzFJKhwRg0c17P4+s9TVTzOgJQtmGNOe+0A6ZTeOhoINLqWFKbe8TGnBBNcXO6oZGSrSRPOoNcKu7tq8Ehmewa7eYb6Wt3PYt8qki2QJUtkfJd6jPKyzceUliyFhZOX2s1w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b4d6f1-2a5e-46ee-a734-08dd60b09f5b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 15:23:06.2422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKFjZI7wvvhj6vefSEROONpwACGP/9sU1r9W8epHn0/akAUwU1In0+MxHT/l5yghpApUxCBZFZ0Yi7OY8QwASg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=974 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110096
X-Proofpoint-ORIG-GUID: sDYSQiTWAt4erz6EUTDwM3Hv9leBawBX
X-Proofpoint-GUID: sDYSQiTWAt4erz6EUTDwM3Hv9leBawBX

On 3/11/25 9:55 AM, Sun Yongjian wrote:
> 
> 
> 在 2025/3/11 1:30, Chuck Lever 写道:
>> On 3/10/25 12:29 PM, Greg Kroah-Hartman wrote:
>>> On Wed, Feb 26, 2025 at 03:33:56PM -0500, Chuck Lever wrote:
>>>> On 2/26/25 2:13 PM, Greg Kroah-Hartman wrote:
>>>>> On Wed, Feb 26, 2025 at 11:28:35AM -0500, Chuck Lever wrote:
>>>>>> On 2/26/25 11:21 AM, Greg Kroah-Hartman wrote:
>>>>>>> On Wed, Feb 26, 2025 at 10:57:48AM -0500, Chuck Lever wrote:
>>>>>>>> On 2/26/25 9:29 AM, Greg Kroah-Hartman wrote:
>>>>>>>>> This reverts commit b9b588f22a0c049a14885399e27625635ae6ef91.
>>>>>>>>>
>>>>>>>>> There are reports of this commit breaking Chrome's rendering
>>>>>>>>> mode.  As
>>>>>>>>> no one seems to want to do a root-cause, let's just revert it
>>>>>>>>> for now as
>>>>>>>>> it is affecting people using the latest release as well as the
>>>>>>>>> stable
>>>>>>>>> kernels that it has been backported to.
>>>>>>>>
>>>>>>>> NACK. This re-introduces a CVE.
>>>>>>>
>>>>>>> As I said elsewhere, when a commit that is assigned a CVE is
>>>>>>> reverted,
>>>>>>> then the CVE gets revoked.  But I don't see this commit being
>>>>>>> assigned
>>>>>>> to a CVE, so what CVE specifically are you referring to?
>>>>>>
>>>>>> https://nvd.nist.gov/vuln/detail/CVE-2024-46701
>>>>>
>>>>> That refers to commit 64a7ce76fb90 ("libfs: fix infinite directory
>>>>> reads
>>>>> for offset dir"), which showed up in 6.11 (and only backported to
>>>>> 6.10.7
>>>>> (which is long end-of-life).  Commit b9b588f22a0c ("libfs: Use
>>>>> d_children list to iterate simple_offset directories") is in 6.14-rc1
>>>>> and has been backported to 6.6.75, 6.12.12, and 6.13.1.
>>>>>
>>>>> I don't understand the interaction here, sorry.
>>>>
>>>> Commit 64a7ce76fb90 is an attempt to fix the infinite loop, but can
>>>> not be applied to kernels before 0e4a862174f2 ("libfs: Convert simple
>>>> directory offsets to use a Maple Tree"), even though those kernels also
>>>> suffer from the looping symptoms described in the CVE.
>>>>
>>>> There was significant controversy (which you responded to) when Yu Kuai
>>>> <yukuai3@huawei.com> attempted a backport of 64a7ce76fb90 to address
>>>> this CVE in v6.6 by first applying all upstream mtree patches to v6.6.
>>>> That backport was roundly rejected by Liam and Lorenzo.
>>>>
>>>> Commit b9b588f22a0c is a second attempt to fix the infinite loop
>>>> problem
>>>> that does not depend on having a working Maple tree implementation.
>>>> b9b588f22a0c is a fix that can work properly with the older xarray
>>>> mechanism that 0e4a862174f2 replaced, so it can be backported (with
>>>> certain adjustments) to kernels before 0e4a862174f2.
>>>>
>>>> Note that as part of the series where b9b588f22a0c was applied,
>>>> 64a7ce76fb90 is reverted (v6.10 and forward). Reverting b9b588f22a0c
>>>> leaves LTS kernels from v6.6 forward with the infinite loop problem
>>>> unfixed entirely because 64a7ce76fb90 has also now been reverted.
>>>>
>>>>
>>>>>> The guideline that "regressions are more important than CVEs" is
>>>>>> interesting. I hadn't heard that before.
>>>>>
>>>>> CVEs should not be relevant for development given that we create 10-11
>>>>> of them a day.  Treat them like any other public bug list please.
>>>>>
>>>>> But again, I don't understand how reverting this commit relates to the
>>>>> CVE id you pointed at, what am I missing?
>>>>>
>>>>>> Still, it seems like we haven't had a chance to actually work on this
>>>>>> issue yet. It could be corrected by a simple fix. Reverting seems
>>>>>> premature to me.
>>>>>
>>>>> I'll let that be up to the vfs maintainers, but I'd push for reverting
>>>>> first to fix the regression and then taking the time to find the real
>>>>> change going forward to make our user's lives easier.  Especially as I
>>>>> don't know who is working on that "simple fix" :)
>>>>
>>>> The issue is that we need the Chrome team to tell us what new system
>>>> behavior is causing Chrome to malfunction. None of us have expertise to
>>>> examine as complex an application as Chrome to nail the one small
>>>> change
>>>> that is causing the problem. This could even be a latent bug in Chrome.
>>>>
>>>> As soon as they have reviewed the bug and provided a simple reproducer,
>>>> I will start active triage.
>>>
>>> What ever happened with all of this?
>>
>> https://issuetracker.google.com/issues/396434686?pli=1
>>
>> The Chrome engineer chased this into the Mesa library, but since then
>> progress has slowed. We still don't know why GPU acceleration is not
>> being detected on certain devices.
>>
>>
> Hello,
> 
> 
> I recently conducted an experiment after applying the patch "libfs: Use
> d_children
> 
> list to iterate simple_offset directories."  In a directory under tmpfs,
> I created 1026
> 
> files using the following commands:
> for i in {1..1026}; do
>     echo "This is file $i" > /tmp/dir/file$i
> done
> 
> When I use the ls to read the contents of the dir, I find that glibc
> performs two
> 
> rounds of readdir calls due to the large number of files. The first
> readdir populates
> 
> dirent with file1026 through file5, and the second readdir populates it
> with file4
> 
> through file1, which are then returned to user space.
> 
> If an unlink file4 operation is inserted between these two readdir
> calls, the second
> 
> readdir will return file5, file3, file2, and file1, causing ls to
> display two instances of
> 
> file5. However, if we replace mas_find with mas_find_rev in the
> offset_dir_lookup
> 
> function, the results become normal.
> 
> I'm not sure whether this experiment could shed light on a potential
> fix.

Thanks for the report. Directory contents cached in glibc make this
stack more brittle than it needs to be, certainly. Your issue does
look like a bug that is related to the commit.

We believe the GPU acceleration bug is related to directory order,
but I don't think libdrm is removing an entry from /dev/dri, so I
am a little skeptical this is the cause of the GPU acceleration issue
(could be wrong though).

What I recommend you do is:

 a. Create a full patch (with S-o-b) that replaces mas_find() with
    mas_find_rev() in offset_dir_lookup()

 b. Construct a new fstests test that looks for this problem (and
    it would be good to investigate fstests to see if it already
    looks for this issue, but I bet it does not)

 c. Run the full fstests suite against a kernel before and after you
    apply a. and confirm that the problem goes away and does not
    introduce new test failures when a. is applied

 d. If all goes to plan, post a. to linux-fsdevel and linux-mm.


-- 
Chuck Lever

