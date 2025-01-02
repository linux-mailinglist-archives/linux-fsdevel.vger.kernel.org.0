Return-Path: <linux-fsdevel+bounces-38333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF569FFB2B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 16:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903EF18833F0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 15:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DDE1ACEA9;
	Thu,  2 Jan 2025 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ndPXfa7H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IiRQxqwW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7AA4C9A;
	Thu,  2 Jan 2025 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735833195; cv=fail; b=AP8hAj0Wa3TlsIQpcFB2u9hW9nSBa5rRk687YpFaGq3wZxYXMF+1KqGqxtcPfq5o8VxRkeddGV9TGHIa2bQPdXmp8HvECEo7A8HbuxbjJDC3WXstKxxE1X/+B/Iehx6D6QuYj3ASM4gXTvLWIPebaYn3y97trnTE6HvaFbx6OmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735833195; c=relaxed/simple;
	bh=GHdocgFH30vdz3wORGquo0IXTwMByMi8+iVUaKLYoy0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jm6YcMnBt8lGA0R9PAcq30qH0eZ6k7V5YjrvlvfYAdlYe7F1DHyK9+EAiJlUBRDfFG5Fmq+u3hJX/qkiHoxLnd4tgEo9VvZE3nxEURNpmnQIz0KFmpI35otjeS1cLiCQ59GHDEovGmZx/sgnWz1NEEeWExRnDtd1sCVSrd8kEE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ndPXfa7H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IiRQxqwW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502DtpmG017366;
	Thu, 2 Jan 2025 15:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=IioQM8DInouxgomU8b3zE4DZLNulm3NaVxFhZzhMsjc=; b=
	ndPXfa7H9pkXMlvIJKethSl7R98kwhbV79nxdSB0VB9iiqHtygKlFa+a5lKlodcZ
	bXbPMfZXclyp+u3CUGc6So0UXsCyo58X08EN3z+OQZsqCm3BbeD3zrBerO7StsiA
	tKNAG2RpjqRcT6l1GAVDhQHPoW78THUgsIL7A5WImBBh52JiqfRng9petkCzHV6c
	W2fXrpl9X3FaC2/lRs9I5RXbq1W/ecSOiq4/sZDTkblFgbVhlczwaaWb6lTn336/
	FObQ5wRNwU0I2DBFGW48XPKV6aV91+UKYdHi/o+gr95ybjyIylj3nCDLBmAZB9Px
	kJVZHLba7lXlY7L6MWl1ug==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t7rbwm6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 15:53:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502FMCon027500;
	Thu, 2 Jan 2025 15:53:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43vry1r6ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 15:52:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ux/WLGrWlSjV0kbhUV6TOAad+vLWpzKtvEK1Xkhi9zOBgy1HFdeyu0gkZdQGJZnCu1DG7vUMKeM4d/0x5y83U8vO4WKSRUzKGgev2j4UtePUs/1iV+kNzbMOcjIEw2ApwdhMubCQSgga0PVcYJsyT/JkQPsvcEhucOZ8TRnxDE8aHHBAOERKt4HYvpF6aBIDRSjwALDPehN+aEumWC9fOiDIVhpEarQD7ZfuRMzm1thgPSyD0eOUdWL7+zAj99ZwfvvqFYV2hcgAlo9KiuBZ1biyMSEeOhIwbMMTrcKKRHGkvMt1Ua5VXghPJHGSx9XQWDJjauhv+HQUQz+uIZllMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IioQM8DInouxgomU8b3zE4DZLNulm3NaVxFhZzhMsjc=;
 b=xCcU4RjQOeOJpTAoTXw5WOcFEeY3iJO7qz6jrbnDqK4ji7Wq5As84Dq80mMbWPKZUsMWLJyRAR13fVQQwUNTFYjBCAelIz5YI12YXnrSYDXJuYZPw+dsOZ1zhKpMDnkAB/MCgsp1Evlh7BMCAGZSQK2Xwvicj+uEyUB441eD3V8zEW5JAeHflow4acqrOBE+LSbCo7S+O5W+Ys9p02zOR16BcJLNJMbxIenyJrHJtCEbTUhoCVQQsPcMMyGHzeMcbL9eSrPDEwccO4ajsKyzo5c3asGFhOO9Xx1/KEfgddEFEM7g0Unua7LIuAlJShozvcIrwoXPSNA53eFiOVhXpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IioQM8DInouxgomU8b3zE4DZLNulm3NaVxFhZzhMsjc=;
 b=IiRQxqwWtZvdraHf9Yi1Feh8zCsXlEbhNw1zIiSG07tFvs0nkxTBogB2GciH+UWHlAUvo7dCuiks55Sfa3t0X5xDMNafUR5GG7JdQW4tj5FuM4pW2RbbBhmVaJ5GNTDs6rWkGtPdRXQM4Y1GLT0+IOpm2pWarNV9+XY7j/4cF8I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 15:52:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 15:52:53 +0000
Message-ID: <28f0aa2e-58d7-4b56-bc19-b1b3aa284d8f@oracle.com>
Date: Thu, 2 Jan 2025 10:52:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Immutable vs read-only for Windows compatibility
To: Jan Kara <jack@suse.cz>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
References: <20241227121508.nofy6bho66pc5ry5@pali>
 <ckqak3zq72lapwz5eozkob7tcbamrvafqxm4mp5rmevz7zsxh5@xytjbpuj6izz>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <ckqak3zq72lapwz5eozkob7tcbamrvafqxm4mp5rmevz7zsxh5@xytjbpuj6izz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:610:b3::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 4006dad7-1053-48f4-5e24-08dd2b458482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzNsb3JXbGhyeThoaDQ5RGlQT0NvNnQydEJrWnNSRWhlQ1U3T0craFhaK3Ry?=
 =?utf-8?B?cElHRHE1OFRZMXZYSXBhTUFlT1QzMHE1WTRmRWdYMFcxcVZacndSY0RxTHNX?=
 =?utf-8?B?djJsblY0cVNKMzVhSThMSXhacldyT2RsL1h6TWFLTW1LTWE4ajIrcThHQkVl?=
 =?utf-8?B?SW1qbzhOUVdBdjY1Z203czdEN3FKRnIxdHZ2QzNxbjdWQVBtZWlSMnZZalNI?=
 =?utf-8?B?dURjdG1pL3dKa1poZVZTMXpXeW9MYnZOZUxxWjFvZm1aUDNFUmpTbTVvWk1s?=
 =?utf-8?B?UEdxamJoNmZZcnBqUVhIeXNPTmNsc1MycHR4clhSczllblFwU0t4bnEzeFZy?=
 =?utf-8?B?THpncGNCVGxvRHVvV0RkM0FTQnNWODBESS84d0x2Tm5ZUCt0ZWNjUC9FdWpR?=
 =?utf-8?B?UG1YZjd1YjRvd0k3bkNpUXpYZ0dRc3dpalNXaU1VbGF6MS9TdnF0NDNkU1ZU?=
 =?utf-8?B?TGd3VndTT2UwYVpPSGp4OVBrMnN4S0gyRHl0SVE4Y253dm1PWWhTc2J2b3B5?=
 =?utf-8?B?OGJjR3NxSVNYT0F4RlJWSko0MVZxR05sZXc1bTJNZjIyUDJJYnV2d0pVVEJK?=
 =?utf-8?B?ckdFR29mUHFzRWkreWhmVzlUemNuZ0R0QUozRTRtN3FPcDhsNlM2OEpkRXBL?=
 =?utf-8?B?WVByZmtnUkx4dGR1WTNmK0ZQa25Ndk80MVdDZ2dsTUhCdnJ5blpWcEwxcklx?=
 =?utf-8?B?akhpQmtCemlQUm1YREs5VHFTcnFwNnlhaEpOc0FTZUpQS0UvdkQ0NDJjWDRC?=
 =?utf-8?B?ZWg3Yno4dWhqcjBENlpHeVZDS3hNSndGVjVuMGRBN1ptMThIRjFQNkZDL1N1?=
 =?utf-8?B?M3hsYnFQa3g1Q2pKbFRTVDNqY2Y3ZVJWdHhOUHE4QnlpdXFlMjhLU24zalNP?=
 =?utf-8?B?dU82Qi9XUk91QVNZbXkrQy8rSlNQTEl1Q2kxV2U5OSszR3RTNmRBM2daUVR1?=
 =?utf-8?B?d2xDMGc4YzBaQW1DZkxNcjhLY2dLbkVzSEh5Zjh1MURhZXhIcUw3QmtuK0pr?=
 =?utf-8?B?aHdYZnFhQVN5WEhqbmRwTUNoNFZwZlkwdG5LOUNxQnplRjlaQTJ6QSt3encx?=
 =?utf-8?B?a0pxZEV3ZUFzK1IxVDZHYXhjVVAvMHdqMktrb2VrNllDZXdqU2ExRFQ0UHlz?=
 =?utf-8?B?anI2cEh0a3orOSs1MUFvakZCYVRQcE9uL0VrWjlsRHBtanJOVlBra0tFZjdG?=
 =?utf-8?B?OGhMRW9RUVcvTnhEWVg0Umdrb2lhWDkxeml5UytEckhOWTZ5cFNzYURBZjlF?=
 =?utf-8?B?M3pGNnh2ZWZUR0NjaVdDNm9qdnFFYjZobm5DUEZBaFkzbng0RnlubWF4L2dq?=
 =?utf-8?B?Z3l2RXVkRHM5ejBTbEpZOUdzMGg3MUdHNFVpK3JTRERMQXZuNDNzNHdEekNE?=
 =?utf-8?B?ckpHbXFtVXpIbkhXK1J2VGcwZTU0dUc4R1FMek81ME15aW5rUkUvK1FkYjBF?=
 =?utf-8?B?TE9aMU1qeVMzL2kzaUV0WFBJWGtmdWZva0IvQ3NZWEs2d3lvaUh5Zko4amtv?=
 =?utf-8?B?cmdDcEkvUXZ2N2JpaVBxT25wTnZJM1B0RHhHSDZDQWtOZ2lTdVZqa25odENX?=
 =?utf-8?B?b2dHaUF6TkxSM2ozSUEvRm0rOTJiVnRkeEZSRFZnbUVIK2R4N0JEYXF5R3JM?=
 =?utf-8?B?MW1MaTNHZ2hwUmNVUHVvQjhOT1R3QlZ2cWR2MzNCanppTnpaZnZ1SUNWMGlR?=
 =?utf-8?B?RUszdTFLREFYNnZzdENGVVVpd2JRSzR5VU1NYXgwTVkyTkJ1TnNvTHI1ZzhV?=
 =?utf-8?B?ZlcxK0hYeHBIZFN2c2pENEptRFpUMnNTcVFTTVorN3kwMW5UYUVhY2xUZk5P?=
 =?utf-8?B?VTRSRXpLVjNicHlOenRzVm5SRHlOMjJuS1B2MWRiWVBXdzhSRW1SRUNtVytX?=
 =?utf-8?Q?8wjxzbZjbSsYD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzRvYkdMNTQrU2hSbGY0R3dQN0lpQU9Md0JMOWdmS1R2TThxTXlGZ0c3VGxT?=
 =?utf-8?B?KzNSbmNISlFNSGN2RHRQOEErZUx2c205ZXR6V1MzUjZDVEFUREtPVlQ4NktY?=
 =?utf-8?B?bmFWdlp5c1Z3YVNBUS9KZU54MTVaNkxlVVQwTkh3eEl4YmtOaStRM2ROOFlV?=
 =?utf-8?B?Z2N0Q09jZVc4ZkZmRkU4L0IxRTh1UkRmWlhlbzRaZWJ3NHhidVJxb01KZTRF?=
 =?utf-8?B?a2oycEIvbEpjOEhOdkZVbG1KMzdIN0VCR2dxUkE5RGNDT205N0pxSUorcWV4?=
 =?utf-8?B?dWpPVTYvbFN6cjlPeE9yY2wybGU2NUdsQ3ZBVkZYakdHNzl5RUdZQmMrbE54?=
 =?utf-8?B?ODdIRCt6Z2VPK2t2eWc0bkJxRVpybzlZMm94OTlpRVNnN0VPL2RyK2hDemhy?=
 =?utf-8?B?ZXBYRE5OL0JsWnI2MFdqb1pPemNsS3hmdjJpSjRaaXVlTGFZN1B4RENnN0dz?=
 =?utf-8?B?OUp1Ni8yWVNJbzJjVnRHSU5LMzlnOS8rVkpHdG55QTJEcERxbTliWk1Kd0li?=
 =?utf-8?B?b2M4UDlyWTV4SXJFelZCWjlQM2YyNkdzZFd3QzVLYmRwcnczeTNqUGY5bUlK?=
 =?utf-8?B?OW9hNTlhTUE2M0pBbExrZVRnZXBzVzNzSjA1cDZ2T1RTTlF5QnVjMjZJWTdI?=
 =?utf-8?B?WENNR284eGRrdkpEcWdJMkJYNWtFcDF3VVFuK0FjcVpPTnYwcndxZmlJWi9K?=
 =?utf-8?B?VGsxRzJyeGNpMVN3S1VUejFLdlZXZExIem1Zcy9KdjNzV2xVMUMvT0V0MTNZ?=
 =?utf-8?B?bGR0TmFkRW1ScVRYc2I3VkU3NFFPYTlzNklKWlNXcXI2bmJpaUVGMXp0Z0E1?=
 =?utf-8?B?QlRuRXlGajNkVFFSWlp0NkI5T3Z1eW9PbldianBXTTlWaGl4cnYyZVJCS2RM?=
 =?utf-8?B?cFhaTGRpN1l4ZlZvNERvdko0UENOVUFxcUJEUUM5WHkvWGF0NWdKR2dvR2Ew?=
 =?utf-8?B?ZExzVmdLYzYrU3BJTVVmK2VPMmlCaklWNU9kQlptSGg3UExZLzRzY3hLUlho?=
 =?utf-8?B?MWcvV1JHOWttczJjNVE5VFVzWFczREJ3SURIclZnaFV3RzhqR2oyZXduNktZ?=
 =?utf-8?B?aGVLdHBYd2x2VG5Vb0JkY3BmYWxDQ3Z2aXFGWkxTaUxtbEY2dXFLdmhhSHZa?=
 =?utf-8?B?emZMWVNQL2VYYzlQUDFFV0RQYlFYdlpVT3pJcHdiN283TU84bkdZWW9TZnp5?=
 =?utf-8?B?dDU2Qkc5ZUc0a3hwWnl0SkFWY1Bja1IyYlJSZCtMNjdTTnk2ZjNPMHFORGYr?=
 =?utf-8?B?OENIcFRVWG9Vc3VuUHVRVVoyNkZYZ0hLbjhWNzdNSzJINFZRTGdLOHhwb2tZ?=
 =?utf-8?B?VE1maWZpcVNKOWV3b3hBMlhIR2pXTjZMbzk3YzZTdnRpc3p4WGx3RnMzdjFi?=
 =?utf-8?B?VVJOUGtjc00reEp4OEo2VGV4TFdqNDk0SkNJOStFZFFZbzJ6MzJ2VWQ1eTdp?=
 =?utf-8?B?aDg3MFU2dkNVd3FGaiszbmpGSmhwM3ZUZDlhR0YxQ0Z3bk9qT0hRcGNoUWlo?=
 =?utf-8?B?WnFtN21ITW51a2ovRjlnMm1jZEh3UUQxYVBXbWJUcTRyL0JtR2t6bTllOGQ1?=
 =?utf-8?B?STJURjJKbkN1REVkN2ZxTXNLVmxnaTFzOUd1MnFDd1VRZytZU1RiYVROSVBU?=
 =?utf-8?B?NjVNNXVPbzk0L21JTzJ5VmxMVk04L3EranJYNUJmQUEwRnlsdHQwK3lnZmVS?=
 =?utf-8?B?ck1zYkxyaERWV1JnRWRVUG9uSDdIYTFxcEM0WS9odmgzbGJ1TEpoUUxFNHRJ?=
 =?utf-8?B?V0FvMXdaTCs5SXpLbU5pUUdPZjZ2YlYydFZPbFZZMDdSdE9BclVkanNZZWsy?=
 =?utf-8?B?L1N1QjV1WHBFZFVIOVlzc0Q0N3BIU0R2NUNHUmNlQXdiRDBDSUd5Z05sZjZF?=
 =?utf-8?B?Wlp4VmFRcDByYlltTGVnT0dqMUZsUXhkVTkxOXBNR3lSYW14V1huSExObGNs?=
 =?utf-8?B?NmtybngxNEllSzFwS1UrQ0R0cFJHcVFzNW12UlRCM2FGTVJIQmhZWGVjVlhj?=
 =?utf-8?B?YmdYVUE5aVk2Z2VDcGswd3pBUG0wN05DdDFyQ3A4d3A0cVpoWi83aUNCS3dT?=
 =?utf-8?B?bmZQSVFiREtZc1V2R0syQ3BnaGloMS92dFZUa2p6M1hScmpkK1pxdEMxZlNJ?=
 =?utf-8?B?YmxicUZ3NXYxY25teHpZSm84U214NktQTEJ3ZG1xUk9Za3FJTWVoT3gyWG83?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/jQGq2q9cl7PtzTi0p+A3PlvaDxhUmhwFu8QLZ5e/RL6zTCK+RzYa9maFp7Ar9Fw8EtvjvDR7FQH4oa8lsanAC3JpENbqUHvmkIkzcoTPM+v10iHUi5b3D492dGWhAl/SuQywFUFpFfPbNhRYm038QEILnDAlSLWQ77vOSM88cxhAA5sHEpfySlrzl4YGJeKwFXcCtv+EcxiYq6lSpyyvIgu6enOKT4CWHm0IvyKEhF/uKMc0uct5LstcVaRrSwGiL4LbJaEd1lk4fc+c5A97rdUhcfl6BQarB1f8Zo0xm5sz8ll6z38T1MsfTErfH99H6Re/blG/7RYPwGhwiJR3kk4z0nWgm2tSTefPpxDk0j+Ti8T0n9bZo3inDUKDujH3Av83GFDM4u4Kl6U1a0dPbjv/PYZmVEWeOHE7eID19Gsbb5xkyYhd/rGSqR9p3C0jMEnScTPxLvigrHzNZCgoD2PQrNhwVw4QtIfA+b4Qvw2r332dLzKr4wRgbnDka+oADAIzFYXJ0+Quy3zrjjnKdkUjC2cLsVxaX0MYDThmEDi52dt97GNN+ycbigbRYVhOZh24RG+QWeL+0aHg+Yp1ujGgq6ZGYREDng9yciBO4M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4006dad7-1053-48f4-5e24-08dd2b458482
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 15:52:53.3997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgMAOsol92FV5ZqGtpSc0whQerirSZbNPZchirtD6Kum4tSMH20w/C/Zktcil6+MhBRcDlQ8Ya8ArnkxZNZ0Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020139
X-Proofpoint-ORIG-GUID: uNRxJNh85HgjTguxeMS7krAbZlJ3F4tL
X-Proofpoint-GUID: uNRxJNh85HgjTguxeMS7krAbZlJ3F4tL

On 1/2/25 9:37 AM, Jan Kara wrote:
> Hello!
> 
> On Fri 27-12-24 13:15:08, Pali Rohár wrote:
>> Few months ago I discussed with Steve that Linux SMB client has some
>> problems during removal of directory which has read-only attribute set.
>>
>> I was looking what exactly the read-only windows attribute means, how it
>> is interpreted by Linux and in my opinion it is wrongly used in Linux at
>> all.
>>
>> Windows filesystems NTFS and ReFS, and also exported over SMB supports
>> two ways how to present some file or directory as read-only. First
>> option is by setting ACL permissions (for particular or all users) to
>> GENERIC_READ-only. Second option is by setting the read-only attribute.
>> Second option is available also for (ex)FAT filesystems (first option via
>> ACL is not possible on (ex)FAT as it does not have ACLs).
>>
>> First option (ACL) is basically same as clearing all "w" bits in mode
>> and ACL (if present) on Linux. It enforces security permission behavior.
>> Note that if the parent directory grants for user delete child
>> permission then the file can be deleted. This behavior is same for Linux
>> and Windows (on Windows there is separate ACL for delete child, on Linux
>> it is part of directory's write permission).
>>
>> Second option (Windows read-only attribute) means that the file/dir
>> cannot be opened in write mode, its metadata attribute cannot be changed
>> and the file/dir cannot be deleted at all. But anybody who has
>> WRITE_ATTRIBUTES ACL permission can clear this attribute and do whatever
>> wants.
> 
> I guess someone with more experience how to fuse together Windows & Linux
> permission semantics should chime in here but here are my thoughts.
> 
>> Linux filesystems has similar thing to Windows read-only attribute
>> (FILE_ATTRIBUTE_READONLY). It is "immutable" bit (FS_IMMUTABLE_FL),
>> which can be set by the "chattr" tool. Seems that the only difference
>> between Windows read-only and Linux immutable is that on Linux only
>> process with CAP_LINUX_IMMUTABLE can set or clear this bit. On Windows
>> it can be anybody who has write ACL.
>>
>> Now I'm thinking, how should be Windows read-only bit interpreted by
>> Linux filesystems drivers (FAT, exFAT, NTFS, SMB)? I see few options:
>>
>> 0) Simply ignored. Disadvantage is that over network fs, user would not
>>     be able to do modify or delete such file, even as root.
>>
>> 1) Smartly ignored. Meaning that for local fs, it is ignored and for
>>     network fs it has to be cleared before any write/modify/delete
>>     operation.
>>
>> 2) Translated to Linux mode/ACL. So the user has some ability to see it
>>     or change it via chmod. Disadvantage is that it mix ACL/mode.
> 
> So this option looks sensible to me. We clear all write permissions in
> file's mode / ACL. For reading that is fully compatible, for mode
> modifications it gets a bit messy (probably I'd suggest to just clear
> FILE_ATTRIBUTE_READONLY on modification) but kind of close.

IMO Linux should store the Windows-specific attribute information but
otherwise ignore it. Modifying ACLs based seems like a road to despair.
Plus there's no ACL representation for OFFLINE and some of the other
items that we'd like to be able to support.


If I were king-for-a-day (tm) I would create a system xattr namespace
just for these items, and provide a VFS/statx API for consumers like
Samba, ksmbd, and knfsd to set and get these items. Each local
filesystem can then implement storage with either the xattr or (eg,
ntfs) can store them directly.

Semantics like READONLY or IMMUTABLE might be provided in the VFS if
we care to expose these semantics to POSIX consumers.


>> 3) Translated to Linux FS_IMMUTABLE_FL. So the user can use lsattr /
>>     chattr to see or change it. Disadvantage is that this bit can be
>>     changed only by root or by CAP_LINUX_IMMUTABLE process.
>>
>> 4) Exported via some new xattr. User can see or change it. But for
>>     example recursive removal via rm -rf would be failing as rm would not
>>     know about this special new xattr.
>>
>> In any case, in my opinion, all Linux fs drivers for these filesystems
>> (FAT, exFAT, NTFS, SMB, are there some others?) should handle this
>> windows read-only bit in the same way.
>>
>> What do you think, what should be the best option?
>>
>> I have another idea. What about introducing a new FS_IMMUTABLE_USER_FL
>> bit which have same behavior as FS_IMMUTABLE_FL, just it would be
>> possible to set it for any user who has granted "write" permission?
> 
> Uh, in unix, write permission is for accessing file data. Modifying access
> permissions etc. is always limited to inode owner (or user with special
> capabilities). So this would be very confusing in Unix permission model.
> 
>> Instead of requiring CAP_LINUX_IMMUTABLE. I see a nice usecase that even
>> ordinary user could be able to mark file as protected against removal or
>> modification (for example some backup data).
> 
> So I don't see us introducing another immutable bit in VFS. Special
> "protected file" bit modifiable by whoever can modify file permissions is
> not really different from clearing write permission bits in mode. So that
> doesn't seem as a terribly useful feature to me. That being said nothing
> really stops individual filesystems from introducing their own inode flags,
> get / set them via ioctl and implement whatever permission checking needed
> with them. After all this is how the flags like IMMUTABLE or APPEND started
> and only later on when they propagated into many filesystems we've lifted
> them into VFS.
> 
> 								Honza


-- 
Chuck Lever

