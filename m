Return-Path: <linux-fsdevel+bounces-24182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A2B93AD46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 09:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9A6282DFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 07:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AD1763E7;
	Wed, 24 Jul 2024 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kJmjUf09";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aALmDdpK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91801CAAF;
	Wed, 24 Jul 2024 07:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721806817; cv=fail; b=DuJboEBrF1Ot3DqWJUSid/RoywfSiMrN7ICkhxBGaYrflLZQcno/xuOKyzOi9CtEEJwo4vZ/b2aEOD7IK7X0a6fpMM7uACu9lgd2/ykb5k5Im5DqCUPoQGTTSbBDqVzFQcer9St5BVi3Sh9k/gtOcIwSakzfmSbWbv9fqUWzbL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721806817; c=relaxed/simple;
	bh=INkr8+KFLSLPTJNlWr6/Ry2YaUW9ZA4JtDyY4YzKJOI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AmSIIORg6G1T4fi9TTNwbYdIB5ly7FVsrkyqg78UFOlCiDI2pQoxCXv3FWE4gS85KMd06rXYdmiaK2/VlHWFwG1b2E1uAdrewfx4wFdEbstSlbeJkSX4VVNecQXNtKNP1W5YD8hvacZRtkF3IA5zhWV1iAouI7fAV3XirjFMRQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kJmjUf09; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aALmDdpK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O5ooOK005434;
	Wed, 24 Jul 2024 07:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=/qCpe0loTyLmEuCX3nIiOgEOAH1rAvyhto3uHiUptE8=; b=
	kJmjUf092HYNdXTE8VjaLjeSl8drPNhqGY/cIH7mE1/rttaG4/cfWZTLFIU4Scwo
	WiiiKsTrFrH57sxPb42Mco1PhFm2dXOpPlOJKdXBg5LRAYv2RMVi9Yf4t5Fz4+Fv
	TaKM7kk5qqodp8apDQimqWvo3g79BOsFJymxO9H6BfHRz37A+Xmt4WxFX8pG9DQp
	wwpYX0/2fjqUM9MmuSj5KEWK7Okwh39wmBRZ/AdlMwwjbLB03+hlDw24NR0Bns4i
	6EABVU/xVvpBgFGo86UEtXGAFOPH4iqjB9fXHX9qOWOssxxK0qjsYa+qeklrbPYF
	MuSB8C5ZXM8PGD7BXJMCog==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft0gb1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 07:40:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46O6QoDW033695;
	Wed, 24 Jul 2024 07:39:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h26aebhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 07:39:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLDkyNAAHOfKZaAysTqtM3y6a31lr47oZT5ihG7C1P32dg/eDMlexAKwaSEwYJAEd0/4fpYq/+vM6z+liXkwSs/WnB5IIUMvxSO2OG3vImBnodivA3hMFza4ysBMZ/xYRrmgKbpxPXDoKN4bacgAqSJ4JEIRySDXOlbzK3i6t7mScWfqiXvQcgu9IJUqe/9L33nxUjdevs9wLO7YlA+uj39Gx3IaRVgtxOHZZHALiSXHvh9/6gt8lsSIj077uJjnQhvDzeuV6d8QJRn1Rawt/aLNwfnRRSZHxmfqIsZ1ss8aqDcXu1/WGSD/6oIelbH6CIEBJMy/wybhid2khpgI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qCpe0loTyLmEuCX3nIiOgEOAH1rAvyhto3uHiUptE8=;
 b=TnFa3eco6DKxt3wZwmuA/0oAkvxghMW3j1ZiWL9uS4UDhgn2X9sIRmyWU4OlpAHRiCvgIPK0OLIuwO71+rThAZxSPPXUVKW03PV3NtJB9YN3S0GpJVQrhQWlse0HGmTLeRJDbW9LPmzEFzxK+QY4q27cLWhVe/06f6XSL3g1AvRkzZDoGDg24R1/kLYOCQpNFJLAH68FdITmrRsVXaSPovNclFis+jTtckPFtVHd9wCxEQCWFXinD19oZmqmA+/PWpTitIzPz970fC7EhvKoB6WC/zpVzxDEnmNHYByhuf9Ies/6dKX+e+1yOcg8Y46X4XbJFmLn5LRW7tJBlhiicA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qCpe0loTyLmEuCX3nIiOgEOAH1rAvyhto3uHiUptE8=;
 b=aALmDdpKaEy1Sj5aTKQo6lcU9HCRBxaCu+8nYt/KFh42LkQf5iLQ0JTsEthsAJobQ/f8nUgUvPNgUvUBL5rS72xLgsegXzzLG9HJHJiPvJK+j5IRWUwGZWRdU1M25zcJk2us5a2IEiMjw8Or35YzL8RHqXFqrDbY/IevkFcro50=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH2PR10MB4215.namprd10.prod.outlook.com (2603:10b6:610:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 07:39:50 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 07:39:50 +0000
Message-ID: <9989a2a6-f07a-43be-829f-74562aa212a2@oracle.com>
Date: Wed, 24 Jul 2024 08:39:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] xfs: Introduce FORCEALIGN inode flag
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, chandan.babu@oracle.com,
        dchinner@redhat.com, hch@lst.de, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        catherine.hoang@oracle.com, martin.petersen@oracle.com
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
 <20240705162450.3481169-8-john.g.garry@oracle.com>
 <20240711025958.GJ612460@frogsfrogsfrogs>
 <ZpBouoiUpMgZtqMk@dread.disaster.area>
 <0c502dd9-7108-4d5f-9337-16b3c0952c04@oracle.com>
 <ZqA+6o/fRufaeQHG@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZqA+6o/fRufaeQHG@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0385.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH2PR10MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5ed475-5624-485c-5fdd-08dcabb3cceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTd3Ti9GSzdtUHp5OXRCZmxCd1Rqd2F1dWU5K1JVOE9qQXZHWWFtQzBDNUpw?=
 =?utf-8?B?WVFNVml1Q21GdHVPaElXOFkwcnVmS25SUCtEUXJ4b1JLTGpiRStvczNXYWhk?=
 =?utf-8?B?TitoUkl4dlkrTXJwT2hTQUJtczNDc1ZZZFBLRU5yYklUZlNwYUQ5SGVnb0Iw?=
 =?utf-8?B?dmNvTlhxM2RPODR5MGpPS0o0TkdVZDE1d3VlTEZwWFM1TFFJeEFaeFRucXZi?=
 =?utf-8?B?U2xrSTdxeHppTnB0alFHeW80cDZTQTVXUHF0ZDBYS25oUjF3b0xiZ1U0NHB3?=
 =?utf-8?B?V2R1NG9kckhLMWhxSkphVWp0NHkrVHFyenFSY1hMTHpnY3pJUmlGUEZJckky?=
 =?utf-8?B?SVhMWGNOcXFWT0h1NG12OUpzRm56L3Z0WCtSaHlKWEVUc05qYmV5UlNhb3hI?=
 =?utf-8?B?YUtUOGg2MFFoMGFYR09scHdiOHFZdm5UbGhWdGdiUlRIeW1CNkhtcHdMSHBN?=
 =?utf-8?B?SEtZbkN6RElMYWwxNGYxUVhaSTdYY0VJRXh5ZVowQ2hnNzQvNXZEREthWGJT?=
 =?utf-8?B?Sk45WUxBOW8vL3AvUnI5NjBSNEFSSWlxUTFmTXpIdUU1WElRT2NibnQ4eGNO?=
 =?utf-8?B?akUxaWFGT2t6Wkswb3ZRckxWQjZaVmp5RmFoK2F1eWJwdjc4MUxJVHFwd3Nl?=
 =?utf-8?B?dDZjajRiVlRkdDBXTkRNMGxvMlZYZkRURkZ3ckVGYkN6V2RXUGlDaFJHSG55?=
 =?utf-8?B?ZFpaM2FsMWhjbDRRQkFaS2NtUUc2STErTFlzMXhYOXJGT1NMOHdieXZnMVdz?=
 =?utf-8?B?THN5SDl5VUJCOURQYUtQSlZBNGxWRjdhYkZ6eWF0aFJJQzluT09KOGpaWDBI?=
 =?utf-8?B?UFNDUCttNGwyS3Q4MkQ0ZGZrWTFDdEJQbGVsNDg3ajF4elJOSkV6WDBkbUF5?=
 =?utf-8?B?aGkyaU9ZYWJveVFvNlZNYks0ZTVZcko3eHRyeWlWamI2dm10VkNrczZmTitu?=
 =?utf-8?B?eWZUSUpyMXozTzRFWDdEQk9NSUJKd2JvSGE3OVpUQXUrK1ZsMHUrVUpxNVBt?=
 =?utf-8?B?ZkZRbzF4Z0RYVXNlTzRMU3V3ckQrQ05jVm9KTm84WVplVkVNMEc0QWQ4UjBi?=
 =?utf-8?B?WUV4NUtvWVNRbm1YemRpQmdBS2tLL1N4R1hhZ1QxZWl2Tm1ydW1vS0hETEpx?=
 =?utf-8?B?VTdsb2twMVU4Mkd6MllqTW1BWEZ1eDA4aDBrQWpSN2xybHpKTE00T3daSUVk?=
 =?utf-8?B?UjFsSDJOTlFtUnJ4OHovc2ZNWXc3T3M0VEphVmpYbDNnUHhlbWU0NjdiUDRI?=
 =?utf-8?B?RVBmUHlFYU5zTUpObXJUY25lTlBmd0ZtdGNkcjYyMXZqOWRraEsxakR3TFlZ?=
 =?utf-8?B?akhnU3RHbitjUFk0Z1oxV0tRWktieFVCTVByRFhreHFab21taHYzZ0pDMUsv?=
 =?utf-8?B?dDBsYjFQZVI1Nm1GbkFaNkx4Tmx2dGlpWnc4OWh6Q015S0V0MklkeEdzdDNk?=
 =?utf-8?B?Rytua0FUTVFGWEhsL2g4ek1EN3dGdW83TVJEUGVlZWtZdmpaNUlaNlpJdFlO?=
 =?utf-8?B?TjBYMURYLzI3c0xPZUxqY09WZldyazNqQW9aWldYTnVES205bXJFWG90Q1pr?=
 =?utf-8?B?UDBkbzkrTXVzTEQzOEY4WmpBYnFMWXkzbnB2N0JkQ3NvdFJGV3JjMnh5R2JV?=
 =?utf-8?B?NzN2NFdVWm4rL1UxeVBRZ3RVN0RFMVZOcXE0RlEwNzdjdTVCOXF1eXRiOEF0?=
 =?utf-8?B?dWVMN2daR3loMnNjZmpvY0FDdWhpMHViMGFQWGhOL25CMVQ1NVZneE9Bc09r?=
 =?utf-8?B?YmE2L2NRUzRaNmZ1eUZ2Tmw4NnF1UzZIU0RGYk9lakJISmYrOEQ1a0d0cFZY?=
 =?utf-8?B?azg0Nnd5Njloa0dGTVlXZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnRjeDRRbHpEbzJ5ZVRjakNJcXArdktYR0xqdVhoUVJ6K3hGRzFJdEgwa3VX?=
 =?utf-8?B?MkIveGtNdW1qQkpWWExHa1g2WG0rdHJIUFN0akFGblhhMER5QmZ5UWtxSVBM?=
 =?utf-8?B?RnVZR2lLVVdGMWxxd1lXb3JUMGZXaUl6VVJPOE5DM0tOVk1IVFFtWFVnaVRJ?=
 =?utf-8?B?WThsSGxHeHBNWG10ZlU2d3pyTW0wSHkrbThaRXRTa3dHQlhPUk40WmNKcU9X?=
 =?utf-8?B?dGJoWDlhTWNSbG9zSGZ2VkdoRnpZVWJ6M0xVTkV6TDdJdCtZMUEwbzk2SFNa?=
 =?utf-8?B?VDhVaUtLR3RVYXUxWWhUbWlxWUZpNlhyWVdnVzJhR3VkbmZWOGJzdUd0TlZK?=
 =?utf-8?B?aTN0VlczNUdNSC90QjBueFQrYlU5VUpBWk93bVUxU0MzVHpaSVZkTUxDT0VJ?=
 =?utf-8?B?OGdka3duRlBJdkMrUVpSOWs5SWxuSW52a0RnNW9PcmUyWW1sbG5XOVIvSU54?=
 =?utf-8?B?TGY3cUwwb0lMaGJwZ1JlTVdJZmZSeExZYkZwbnZWMHU2SmM5akorZTJSUldm?=
 =?utf-8?B?TEl5Tm13RFhSVTFwZ1k5S1RVS2w2eC8xdkYwdEkwbTlINXRPdisrem9raUs4?=
 =?utf-8?B?RHovbFdIdFIvUHMwNm1Ma0xyVmJHNEtlbkhkL2JPZ2FKY1U1Z2hrZzEzZGh2?=
 =?utf-8?B?ZTQwQ0R1ZVF5ZlRQdFQxOS9vVU5jcXpyWTVsbDgvOEM0SHc0Y3E2S1I4M1hK?=
 =?utf-8?B?bFA5MnJ1bFhKK2RuZjM0bVJxSEtOcFpqdW4xTElHM3hZMU5WWE1jTWlhei9w?=
 =?utf-8?B?dVFuMy9UUG1yYUc4SHQ1VEp2ZDNDMGlKQ2hBcGo2d3IyYlhBSjlhNGtxdWti?=
 =?utf-8?B?MCtDM0lBeEhrZG1TclVkczVzZHdIWVpsSGgrZXh5aVFYQy9QMVVVRDRzRFVW?=
 =?utf-8?B?cG5qUk0rZXBOS0hsZStlanRSTzBEU1JHSlVFbzJvTXJmaUdXWmVqczN3RWZv?=
 =?utf-8?B?bWRGSHE1dlg3c1FsUTdweEV5bURFMGFuWXpXSG90UUhoeDFLRjFwMW5sYk9l?=
 =?utf-8?B?N20vaDdBL21JQXJCL0I1Y3pTek9wMSs2RjlUSVhBUVMzTUxpdmVFNURUMlVY?=
 =?utf-8?B?SVJoeVZBZ2JsT0VXRDMvTEdDcWtxZXM0SC91cnk4akpjdnIvKzh6UHlqUVpi?=
 =?utf-8?B?enZYSDh0OHVGOHh4d0k0UmNmZXMvL2cwNG56bXFZMzhkZEVOVXhiQ0RxdzdL?=
 =?utf-8?B?OU9vRkpIaHFBQ211QUc1a0hWMTRHZzNjN3UvNmNsL0FIUkk1Z0F6YlEzWXFD?=
 =?utf-8?B?Q2pnc1ZVaFk2MVBNeUFwOUNLZmJ2QUdnVEpwTWxrWktyemlSRXJvaXFmd0N0?=
 =?utf-8?B?QzZxNVMzdFc4SHE3MUZIU1VQVnRlU2ZSWnJ4TUd1ZUgwUmkvejRna2RCdTNw?=
 =?utf-8?B?UWpKSTgyVmJFcVgreXRsVzB1Y0pwQStrcmcvbDgzVnc5V2FWalFSMEZtSlBL?=
 =?utf-8?B?TTNJL2RaTG9rMHBrdGQyLzFSaVdrSFpsa01WQW5Gd29oR1U2NHRWOUg4L0J3?=
 =?utf-8?B?ZWs0SGtxU25pbENqQjBwY2JOLytDYWZJVWQzQUdXeWt4YXc2YmlvVGg5ZlU0?=
 =?utf-8?B?T2p3S0wzNEpLYm02Y2pVRkhJNysvajFXRGRWUFB2c0hpNkk1RlhLVUJWeHBS?=
 =?utf-8?B?SitFRnFYN3lhOUNCSUlwQ2xVb2RvYlNsOEp4anJqM1BWamtpaUtPc3laRzRs?=
 =?utf-8?B?bHppM2VtZk9QaU4zeVZHOGxZSWU1OU9JdnNTdDI1cUFqNHRiWDljN21UMFZj?=
 =?utf-8?B?d3lHUlVuN1VHRmF1cDhNbE0rSlR4aHF2a0Z6N2JJbEpQc0MzTEs1cjFseHhx?=
 =?utf-8?B?cFEyT09SOVduNEhSZ24yd21yTDV4a2hXTXlUc0tZNE16SXJPeWlFOTBjRWZJ?=
 =?utf-8?B?cmRBOWJjTk1rMFNtRThYTjlCWjdSL3hYMjZYeW92TUN5cWhBY1NvYkZ6WGtV?=
 =?utf-8?B?Vm5vaVpaK0pDVkJacVh6Y1NnOGhVQWlPZFVSRjR6Wm5jc3QvWjBEZ3I3dnA0?=
 =?utf-8?B?N05ZVHh2TjRsNnJTVG1OWi9HNk15c3ZwT1dsdjY0Mm9RR21LdnR6c0l5bDkw?=
 =?utf-8?B?by9ZL1M4RVlHU1JCeFordytYUVVKSW5WUEJ0N1JTbDhNZ3FHSjNVYkVQKzVi?=
 =?utf-8?Q?58YIePtQQoz4VRyeroDN5qfpt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h7wdZspHmHy1PaUDySYERlubk0h5TastKLUxWLT9WV4wynF2Ih4Brjsl+xhT89/agLzyF+kdPpiEWVAQnPW0agd4WILohtERuO964ZOcECyjuMYKn4xbjXSLbdQNSnoJ2lSJkpLNgPEf2knS7yrH+89M3y6E0RnnfLrnVE2p64N/j2FAjptU+QOnXtoxqUlGafbtWHSl7KOvghCr3oW7DMdfNIeH33B9fwyhSxM21CSe1gZaeYAOaDmGff8T/hVQHR4UFLkng0/yoQ2wPp2j68pTNGCpfKH2yvmqP1eSwpUYaFC08KjQSP9wCBig4/TbPfwQnOpLogIyS5AA0dHK1H1zsyQHCP08SF2ZENgbaDRZAkbGg0BjfMqqbLYji/m7L7IZq8vDPFMoBTyBHY3+Op6lBeONvxbq4UjL6BW3WmKeBYYbnQ9gNxncNqRGjcWDB14J8j3FHA4EkS6dbOV44QGVuYkNC+ndpUjpiogYg0KwDA3S/b4ultvueSoeMTgAM38v/7fynPcJ/AS8xvgeLxg1xthm4o0DZLw45FKmpucvvYm2bEcFLWhXd+fSpk5XKuoz7cdAFOHeCSu7gwKJQBkss4p0WOT8OMxvY4GSOy4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5ed475-5624-485c-5fdd-08dcabb3cceb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 07:39:50.7539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZApCLcxugHYkpV+g7Lqvft31BV0lW8uLxmdOo7DkteKt/hObJRRGs8S1UzDO6MJ/030eHM8uuyJhJ3i0wGr+qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_05,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=895
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407240055
X-Proofpoint-GUID: 4CZbiaBkG-IEAX6hW0yM22n6Y__Es4Pl
X-Proofpoint-ORIG-GUID: 4CZbiaBkG-IEAX6hW0yM22n6Y__Es4Pl

On 24/07/2024 00:38, Dave Chinner wrote:
> What's the problem with supporting it right from the start? 

Simply because I wanted to focus on regular data volume support first.

> We
> already support forcealign for RT, just it's a global config
> under the "big rt alloc" moniker rather than a per-inode flag.
> 
> Like all on-disk format change based features,
> forcealign should add the EXPERIMENTAL flag to the filesystem for a
> couple of releases after merge, so there will be plenty of time to
> test both data and rt dev functionality before removing the
> EXPERIMENTAL flag from it.
> 
> So why not just enable the per-inode flag with RT right from the
> start given that this functionality is supposed to work and be
> globally supported by the rtdev right now? It seems like a whole lot
> less work to just enable it for RT now than it is to disable it...

I'll have a look... if it really is that easy, then - yes - we can have 
it from the start.


