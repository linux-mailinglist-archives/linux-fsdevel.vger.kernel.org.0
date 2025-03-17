Return-Path: <linux-fsdevel+bounces-44200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A39A65374
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 15:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE303BED3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 14:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03347241690;
	Mon, 17 Mar 2025 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oo/3F07G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j40e2/cS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E6623DE95;
	Mon, 17 Mar 2025 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221553; cv=fail; b=ClnzuUKnK9bfnwPSRFZHxC5PlyKUU/sR9hrCLjxQOcwdj6GW95DKNA8KuY70qX2XTglfzEXsIGEeijpsKewOsQkHI22SN2IZUUuY1w4aaYnE8XgMXpMUSF9g+LYj2SSKT8aWdqbEKei0G9+EO58XTthlP+6FWn7qeTSxyil30iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221553; c=relaxed/simple;
	bh=vTZVyiJvdeWFizs2LvMSjbp7mdd9cHho3N6IpxQWImc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SQ51P66d2ECyS8S1r7xU2py/fNfwJQpI5aUhO/8vo87CM5R5AAe12QHQiVElh0gbiY/jHqUFo8uJTqD+fLnwk7L+HvFcNlED+txiaDqEk3TEV7O05ecYU5lCMxgL/q8v0kXvpTZj7CTnnoohLsXy5K7zEX33AE/A0/KSVA8RdS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oo/3F07G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j40e2/cS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H7QmTf026943;
	Mon, 17 Mar 2025 14:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=L1tNz6hwyXOs19UU03LaRQTTAPr4LUWhB5TQ8GiGQhY=; b=
	oo/3F07GvSe8F0cEUuRBjXZxWBUbUEb8ra1h3Pfo2gOHwfr/XPOaeF/P3cUMvXPe
	ySDl5y7EeA7QbDbA8891qBdIETNsjNeBT23poYLJwKXtyEp5XNKJvtESziqAYfT2
	Xwg0SrZgqA1YzxAaIvWE3nc+ACjB4Od7W/97etHMCP3w9UXRCEju2rJ9MrN+9UCP
	jFIMcAFGPwEXRRPHyNegvmxMi+kQFvjpAKYsq+Jk7+zS+U9m5pVxi83P5Mlx9MKn
	Q0RWQmKTQj/PUEy9dVOaem+OMpeMzy37m1y/dyhJd8T+gM6FAQlTVPiAcdF9486j
	q0uEBH1wZr3psF2J4eRfwA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n8auwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 14:25:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52HEK7cB022510;
	Mon, 17 Mar 2025 14:25:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxc488by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 14:25:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djgWANeZ85ZpI8fo6olnK9ykUZtV9G1PIurz1QEMMt77nnD83T7EPkhhtVLql7fjwGGQu1uf21OdbC4j7nVZo//oZGJnKw0mFIxuOl51T0wAbC4eVzMn81gtbO1zeFbWLv3hwqJyqjXKSns1hl3MvOD3xECnQtGBSrg1gKBgsFiPAz22SGcIbjTDgszWbUVomkovaVE1eeYTsOZql7QIr/9tZtG+hS71wRHo+gGejeizstxRTAWgm1J28pedv78w1fIzPSE23sWGGFkCPFk0NCOsMCxpNjB66B8NAoy7U1bWHePu+hTDWwmBTbdG94JSGYAtXNAtYnpPQOjGPJLk9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1tNz6hwyXOs19UU03LaRQTTAPr4LUWhB5TQ8GiGQhY=;
 b=Gw0xfUjKCm6lqXvASoNvVWYQw2W80php11U/ybRoVdbF9Yycwun+mH+JXNpH3RC2XWUCriOnIu11PRMsdh8dN+yHp3hJCDUxce4zuA+x4QG5Nuyj+LfNtUwbRIYzm465bAXOKWXjxS43eTkG2LPwGL3/flRTCUsnTqnen0SktCP7idg24jA299H4aAcDzb+gyVYgaM/uZbMvVdExe+lZbqP26+WIlq12vDKaIixVkhu7jRn+GEyl9j9AxNceuLJyeE19NbMN1+EFbRgF05srYmcxUFM0SAZpR796HBe4XW+Zxmu7/nfdK3+FEKmELWBqrgVAWG4V4sfo3iJ0x3y8Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1tNz6hwyXOs19UU03LaRQTTAPr4LUWhB5TQ8GiGQhY=;
 b=j40e2/cSuKIYUret54g5pO22iUJ82yuxQD3A6JBas5eicYP1XP3E7ao4fHOrr1QqJKe4eRXuncJ0JYnMTZ07iLxqpPNnxl1GtaLLMjcU1hzQJ5hiAelTttHh7Z6wl6fRoWtxn0Ybe+ivEt9TB6Bx50XjYU92okn3IlzufENn/3c=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB7166.namprd10.prod.outlook.com (2603:10b6:208:3f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 14:25:34 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 14:25:34 +0000
Message-ID: <99208409-87d4-4ed2-8294-665eafd60b47@oracle.com>
Date: Mon, 17 Mar 2025 14:25:30 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/13] iomap: rework IOMAP atomic flags
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, brauner@kernel.org,
        djwong@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-4-john.g.garry@oracle.com> <87tt7rsreu.fsf@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87tt7rsreu.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0211.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9b6785-def3-4e92-5de5-08dd655f944b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDhHUXVYbHJudExidnhJSVVZSFVSYldaRXFnLzdIL21TUlkyV2hkUDBqWjkx?=
 =?utf-8?B?TU14MUdXSUorQS91T0ZBMnJYOEozKytDdWtmeDl2dWJWK2ZoL3BPQnpmRmhx?=
 =?utf-8?B?S3Nqd01aRUFqRU1TNldFNG40aW9RZk0wS0J6WVlKSXJzSnRmU2NMNWs5TWc3?=
 =?utf-8?B?eUtQcjlLV2hhYUFCeDBNb25GbzBZdmM3a2ZQY3prejZ6a1dGZ1JJYkRnb2Jn?=
 =?utf-8?B?UE9pYi9YT2srNk8wTFZ3dTNJODMvUllVeGUrM3FsZDBaM3hWdXZ6YkNlS2Q4?=
 =?utf-8?B?QnhWQURCTXZkendOTlZCODJldEVZK2tIb3lhOTV6WU05RzB1ZjNVTlBMR1Fx?=
 =?utf-8?B?NWRvVmJvRHZWS0NOOXdlcktZZzI1VXZNUEhlako5KzhEOWszWDlhR1JiR0ZR?=
 =?utf-8?B?cWZhQ2g3VGdzcnFpd1pEKzNva0E4OURaRGloZ1FxVkxIS0VOOUNRZmVWVVdt?=
 =?utf-8?B?MlNZOENDUG8yTUpCaWE0Z1RQVFY5Y2tyWnpvQ2xkME1PdzJmb3BSS0R0SkhV?=
 =?utf-8?B?M2tMRkY1b3pRb1ZBdXBCM1hKYldFdEhVbTZId1RVSTA2TDQ0SCtSS3gvMllY?=
 =?utf-8?B?MVBVY3NzUnZpZTRlbnB3OCswWFVNdG9kb2lNOEpGMG9ydTI2dXpET1ZCNlZP?=
 =?utf-8?B?WGY2clNYT2pKTERhdHRhR3M1YVFVM2tmUGVmb0JJUUZRdUFnWWZhSFloQ1NC?=
 =?utf-8?B?VFVYSkRvUWk3Y1hyK1FzTGlCWEJBQ3AxWjZIcGVGSEkvVWcwcXE3S1JlaDhx?=
 =?utf-8?B?ZVJwbCtJWlB0M1lUN0prUnoxeTVHYmQxUmUvOFk3cVdvQ01iaU93VmJjdi90?=
 =?utf-8?B?TUN4OHVlOFk3UERSMzdVTDM2TFNXMUtlWUVDSGQ0eXVoRm1sLyszQm9KR3Nu?=
 =?utf-8?B?SURma2lCN2M5YTNoZUdpQWJzVWd3LzBteDcvbk0xaTRUL3ZMUzRiYms1YmRP?=
 =?utf-8?B?YjBpNkdncW5MWjNoQ091RnJYWHFES0R2TmlkRndMQTlYWXVCMUR3emNWQnRv?=
 =?utf-8?B?U08wS0tuY0ZGREQ3WVhUell5WUVCVHFzK0pDZ3BnKzFkT3hRRmVTSlp1VElR?=
 =?utf-8?B?V3I1VVkyOEFCZHJyMGFnYzdyMkNERWxpcjM2RGNKUTFSYVRRNjlHYUFFZlNG?=
 =?utf-8?B?eENlNUJEdE1SV3l3amFSOHZwN2p1Y0VtakQrZTFLMlBHOFNvM1RmNE9aaXNa?=
 =?utf-8?B?WWF3ejNwaFBHdW5Cdk0vbU1GWWlocVpqbzRpV1JCUTU4eHp3ZVZGWDc3MVJ4?=
 =?utf-8?B?dy95Vk1yd3NCd0dEeXgrSldpYXAxdmJoTkkrWXA1a1hNYjZpNEhRSHlndi93?=
 =?utf-8?B?UWNLZ0dmbHcyOTNDdWdNRlZFeGtsYUFqU0tLVkpWNGVVTzZrb3E5a29uSW1L?=
 =?utf-8?B?Yk9BR05kNko2cFlBendNOEVLV3J4aGFDNDZpeHh0emlIMi81eW4xVmlTclJn?=
 =?utf-8?B?aHlBTjcxcktLcUtyK0N6NS8zS0JEbkpySWgwYnpTVFB2U3lMaGM4eUp5czV0?=
 =?utf-8?B?YWF4VUc3YkYzU21tRXZud1ZUVWhhQ3dwZEErSGdhazRYYUh4R3huaDdWSVRu?=
 =?utf-8?B?QThDQzU4YVMvQU02VDNZSlFzdHR4VkIvNmxZSGZOU1BLa3NQdDBsa1hDTjFK?=
 =?utf-8?B?TzFQYVl5MHpBdmE2TlhCZEZldzQ2cEFISzJPUDBmSTZUd0ZWTTZNamZ1V1lV?=
 =?utf-8?B?UjRGTEp4SkFGNVJNanZENUFvZnZ0SlYzakdKR0E1bHZIS0dGdHdoQUc5WnRU?=
 =?utf-8?B?N2Y3aXN6aE5meTlVTTZFcVpLL0JITU5KU214ci9QYlBuOXBYcDFEMUhTQTRY?=
 =?utf-8?B?eHFCSWk3dUhpY3gvUzlXbXcyRW9ZMENvbDcxbXdzckRPOTJ2ZlhxRkdTMGlG?=
 =?utf-8?Q?zZXYubqfbl0f3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlBLWklLbDc5bjZtamt2SllORjNGZ0luUGkvWDcxRWFYcldVek52cFA0NlZp?=
 =?utf-8?B?UDd1QlRrRDVxbmJnem9OMldnR3lQRDViVVdYK24zM3cvd3dnRHZHVXh4a1V5?=
 =?utf-8?B?TnNHSXVUZXd1N1h4UUwzVmRqQXBhOCtsemYzeHFiM3UxK2dZMDVwNnY3Umx5?=
 =?utf-8?B?OEhFRjhlOTVzaTYzRUVaaFpXT0M1Qy9LUDBMZ3JZTloxQmxBbU9rZkkxUVFU?=
 =?utf-8?B?d2NqR2l3MzBxU3IwVHB3V0NURGNmZDdBL3QreXExeXJheEhiM2tad1QwRTZM?=
 =?utf-8?B?eHUxU3d0SURGWEdwUXlaTjAxbTMwcmNQc2pPNGZ1M0ZpM2l0Q0ltU2tSMVB4?=
 =?utf-8?B?ekhqNktwWXNwVlM1N1Z0ejZmSDhYdXUwYVBpRFcvYk9adVRtTldiYXBrMmIz?=
 =?utf-8?B?U1dnTUlXTnY0dnd3UEd6cmw3NjllNzBkY0VqRWJVTFY5cEpMeCt2cXpaTkVH?=
 =?utf-8?B?bUxPNFlzdGcwam9CL29Ed2FhVVZkSEpaTDd4MzQ5QjFsUlFaMjhrb0dIb0xD?=
 =?utf-8?B?bjFTaVdsa2J6Sm1ZRmJRNjlteTRFbWVmdkF0L0xsSWg1TnBoS01BajlocldJ?=
 =?utf-8?B?T0RyRm44WkowaG1ZTEVLVTlWblJIOWFYems5V2Z4b0ZUalZsa040QWNBazUy?=
 =?utf-8?B?ek9lL25sWXlnWElDeEkzeEEzUS95dkdzb2RIVVFxcHBTSU00YklCSFJ6bmhq?=
 =?utf-8?B?dTBYZ3NaSFpvdE0vcE9ObkxPUFFFamZ6SDFjaUk4ZHk1SWNlSk5yK2NMamoy?=
 =?utf-8?B?b3NzNFQvRyt5b0tqM2lQQXBiRWQ3eDJONnpkbUZhNG84OG1STXdlUnBjTUty?=
 =?utf-8?B?cHVoQkFkdkpMTUVWRG9YUmp1eEI0V1hmQXdjRE1RZkdaUlFRVEt2bko3WVJ1?=
 =?utf-8?B?aEp2ZjJBc2lQcnVTcjlTQnlQZlRHSGlDdXh6ZXp5UDgxOWswU1hDSy9xNWZr?=
 =?utf-8?B?N25CZzYyalgzQktNR01MTEpIMFpMTWF1ZStHc0NzVG5idUprVlhuSHRxRTFM?=
 =?utf-8?B?dGlPa2J1bVE0VVBFZ0t3b3ZveUdnQUNMSkJpTG9sSmJlYUZLa0VnUlhHa0JV?=
 =?utf-8?B?cTY0NjgwbUhDT2Rqc3k0VnE4c205UFhSOVdsYURTN1laYmVIVTg4dU40NG5W?=
 =?utf-8?B?UXh6Yml2LzZGVVVGTmlzTENQVlg5RldnMUtGQUo0Ny9kSmpKTm01U2RHVmF6?=
 =?utf-8?B?cm80QmR1a0FWc1FuMndHMzhHWmVJM0dRMU0rVTdGVzBWbVVRNll1emw1Zncv?=
 =?utf-8?B?TzJDMnlZVWthTjkyTVVSS09KZm95dUpDNFFhd3p6bmdpNjI5b3pRbFdNeFZi?=
 =?utf-8?B?UkpoenlOM1BqNS9LT3J0WnhIQkUzaFU2dWU5MmRwaS8wTXdSQ1lwUkphM2Nv?=
 =?utf-8?B?UWF1TEg4MHdtNWxCVzNYSFUxV3Uxa0VaZGxFYzROQmpxMzRpbDdHc1FaT0du?=
 =?utf-8?B?eVNxYVZiOU1Pbk01Q3c0RDV1cHNEZ3ZIZDhXR3Q5Qk51QnVwaDVBbnJ2cE03?=
 =?utf-8?B?RmhleklQZFVXVmw3cXhxZHFVVitSUzNkS2RKM2V0V2NRSGNOSnBjaUtpT2tP?=
 =?utf-8?B?NTdKUjYrK2tRUEt1ZGlIWGRDcUdZbkpjWEg2cUJVZko2L0djMm4venZzWU5X?=
 =?utf-8?B?ZVl0d09JOExMd0w4Y1N0cm45dU4xdmd3eGZra2dXdGx3aDJmQlhobjJ6VTQ2?=
 =?utf-8?B?NUFoSmkyYnNhTWh1Qnp4T0ZMN1VTMDR2NHgyUEVOZXR3ZUYxeW5YSEx4bE1z?=
 =?utf-8?B?cTY4SUZGRWdxZjc4bllaZmx4UTVsL3lUM0hOcTVlUldmNTRKcHpKczR1NWtC?=
 =?utf-8?B?MVpxb3BVSWNlaGtpUTl4NE9vYVUyQk0wTDNvSGcwZDFtdEJyeWRYK2Z1UXVF?=
 =?utf-8?B?c0dRakFlTkFrblFaZU5HZm5vZFYxSjMwTmNkTjlteGdFUVlvOHpQZFJKM2dt?=
 =?utf-8?B?aTR3T0t2dWlrbUxYQzFFdDhTZ0prRXYrRnJocCtDMEthU2RoZGEwWE9nWDRz?=
 =?utf-8?B?c1Zabys2U2lreGc3THNhSTVoSmhhYUVoRCthRkt0ZzZMNWc5ZUhyczkxekp6?=
 =?utf-8?B?RjRzQlJ1TkF2VGc2Qll5ZmtRaEFocEJqOGs1UTF0L0Jmd1R3YzRVaWEyNlZi?=
 =?utf-8?B?MjdxRDh0VzZ0QStFZ1kvemN0RTJtbGd2ODNTY1ZGYXRVM0F4R3lVdmovbVBa?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	63HQaM9YfvtGmFBRM5KDIL/wSEkUurzG1BqS3/hVaPxZz+98//ruSVs1qnez0AXbZWwAC8GEgtDbishb1MjzAlhASnHdyHq7GykIR6uSYJPFl+1irbQGEJt6KBu6rn3IuBCedykzsqEHF6swvxoYxiL1/D6D8EyK7SZjXcLNjQSrXABJPHBYL5iLTIvm0/8Kdm70On+/wV3iwpVE/oy2W+4nsrDM86CGnjuWFCotzepxNlWrwyfygCN/LiIUfEwcSPRiuI1tKR5TOVgPE3AVOZEqLOqPh/qItItUhJlqOai2sKQC0D/FMSGiehwjRyiAP67qAii9luMsWRiIobQ06cWSiMs0jzlgit0Pm30b2ljgR+Jd8HgiCcA7IeQYgrkJ+l6lxgIIGGmv58OWT4OHgRJLQeubjD/nA7WqQpbHZPzSvl1+H3QMaaF437DQmVGufYmBiCuPBmMUvVYEuy43rp4wHzSqUMx/CHRJws9TSd8bximHBqyJsIJyZ92T0OOyjxQLUVcPVfzgTeRHlm1QlPX2JPtMP9Cw3sDmB2cuK/YWIWW89ZO2sSd0OM1ayWa9PYHzDUXhBYlCqpI1qD/YlkfnjZK5tGNWur28A2KeG1g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9b6785-def3-4e92-5de5-08dd655f944b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 14:25:34.3138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDGwULm/Efaxk2LliqktlabTf5sVqclpQLEqcgO5KYap1iJnjBMZEVpPPinZbUzGPN6qQg5Dd6Rt28s+szJBPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_05,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503170105
X-Proofpoint-ORIG-GUID: Giqow4LL4WC9OAqaaJJj5STz-gJrkcIh
X-Proofpoint-GUID: Giqow4LL4WC9OAqaaJJj5STz-gJrkcIh

On 17/03/2025 13:44, Ritesh Harjani (IBM) wrote:
>>   	if (flags & IOMAP_DAX)
>>   		iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
>>   	else
>> @@ -3467,7 +3470,7 @@ static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
>>   		return false;
>>   
>>   	/* atomic writes are all-or-nothing */
>> -	if (flags & IOMAP_ATOMIC_HW)
>> +	if (flags & IOMAP_ATOMIC)
>>   		return false;
>>   
> The changes in ext4 is mostly straight forward. Essentially for
> an IOMAP_ATOMIC write requests we are always setting IOMAP_F_ATOMIC_BIO in
> the ->iomap_begin() routine. This is done to inform the iomap that this
> write request needs to issue an atomic bio, so iomap then goes and sets
> REQ_ATOMIC flag in the bio.

Right

> 
> 
>>   	/* can only try again if we wrote nothing */
>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>> index 9d72b99cb447..c28685fd3362 100644
>> --- a/fs/iomap/direct-io.c
>> +++ b/fs/iomap/direct-io.c
>> @@ -349,7 +349,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>>   	if (dio->flags & IOMAP_DIO_WRITE) {
>>   		bio_opf |= REQ_OP_WRITE;
>>   
>> -		if (iter->flags & IOMAP_ATOMIC_HW) {
>> +		if (iomap->flags & IOMAP_F_ATOMIC_BIO) {
>>   			/*
>>   			* Ensure that the mapping covers the full write length,
>>   			* otherwise we will submit multiple BIOs, which is
>> @@ -677,10 +677,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>>   			iomi.flags |= IOMAP_OVERWRITE_ONLY;
>>   		}
>>   
>> -		if (dio_flags & IOMAP_DIO_ATOMIC_SW)
>> -			iomi.flags |= IOMAP_ATOMIC_SW;
>> -		else if (iocb->ki_flags & IOCB_ATOMIC)
>> -			iomi.flags |= IOMAP_ATOMIC_HW;
>> +		if (iocb->ki_flags & IOCB_ATOMIC)
>> +			iomi.flags |= IOMAP_ATOMIC;
>>   
>>   		/* for data sync or sync, we need sync completion processing */
>>   		if (iocb_is_dsync(iocb)) {
>> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
>> index 69af89044ebd..9eab2c8ac3c5 100644
>> --- a/fs/iomap/trace.h
>> +++ b/fs/iomap/trace.h
>> @@ -99,7 +99,7 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
>>   	{ IOMAP_FAULT,		"FAULT" }, \
>>   	{ IOMAP_DIRECT,		"DIRECT" }, \
>>   	{ IOMAP_NOWAIT,		"NOWAIT" }, \
>> -	{ IOMAP_ATOMIC_HW,	"ATOMIC_HW" }
>> +	{ IOMAP_ATOMIC,		"ATOMIC" }
>>   
>>   #define IOMAP_F_FLAGS_STRINGS \
>>   	{ IOMAP_F_NEW,		"NEW" }, \
>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>> index 30e257f683bb..9a22ecd794eb 100644
>> --- a/fs/xfs/xfs_iomap.c
>> +++ b/fs/xfs/xfs_iomap.c
>> @@ -831,6 +831,9 @@ xfs_direct_write_iomap_begin(
>>   	if (offset + length > i_size_read(inode))
>>   		iomap_flags |= IOMAP_F_DIRTY;
>>   
>> +	if (flags & IOMAP_ATOMIC)
>> +		iomap_flags |= IOMAP_F_ATOMIC_BIO;
>> +
>>   	/*
>>   	 * COW writes may allocate delalloc space or convert unwritten COW
>>   	 * extents, so we need to make sure to take the lock exclusively here.
>> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
>> index 9cd93530013c..51f4c13bd17a 100644
>> --- a/include/linux/iomap.h
>> +++ b/include/linux/iomap.h
>> @@ -60,6 +60,9 @@ struct vm_fault;
>>    * IOMAP_F_ANON_WRITE indicates that (write) I/O does not have a target block
>>    * assigned to it yet and the file system will do that in the bio submission
>>    * handler, splitting the I/O as needed.
>> + *
>> + * IOMAP_F_ATOMIC_BIO indicates that (write) I/O needs to be issued as an
>> + * atomic bio, i.e. set REQ_ATOMIC.
>>    */
> 
> Maybe we can be more explicit here?
> 
> IOMAP_F_ATOMIC_BIO flag indicates that write I/O must be issued as an
> atomic bio by setting the REQ_ATOMIC flag. Filesystems need to set this
> flag to inform iomap that the write I/O operation should be submitted as
> an atomic bio.

The comment for all these flags is that they should be set by the FS:

"Flags reported by the file system from iomap_begin"

So the second sentence seems to just repeat what is already said.


> 
> This definition (or whatever you feel is the better version), should also
> go in Documentation/filesystems/iomap/design.rst

Yes, I need to update that again

> 
>>   #define IOMAP_F_NEW		(1U << 0)
>>   #define IOMAP_F_DIRTY		(1U << 1)
>> @@ -73,6 +76,7 @@ struct vm_fault;
>>   #define IOMAP_F_XATTR		(1U << 5)
>>   #define IOMAP_F_BOUNDARY	(1U << 6)
>>   #define IOMAP_F_ANON_WRITE	(1U << 7)
>> +#define IOMAP_F_ATOMIC_BIO	(1U << 8)
>>   
>>   /*
>>    * Flags set by the core iomap code during operations:
>> @@ -189,9 +193,8 @@ struct iomap_folio_ops {
>>   #else
>>   #define IOMAP_DAX		0
>>   #endif /* CONFIG_FS_DAX */
>> -#define IOMAP_ATOMIC_HW		(1 << 9) /* HW-based torn-write protection */
>> +#define IOMAP_ATOMIC		(1 << 9) /* torn-write protection */
>>   #define IOMAP_DONTCACHE		(1 << 10)
>> -#define IOMAP_ATOMIC_SW		(1 << 11)/* SW-based torn-write protection */
> Now that we are killing separate IOMAP_ATOMIC_** names, we may would
> like to update the iomap design document as well. Otherwise it will
> carry use of IOMAP_ATOMIC_HW & IOMAP_ATOMIC_SW definitions. Instead we
> should only keep IOMAP_ATOMIC and update the design info there.

Yes, I will update it.

Thanks for the reminder.

John


