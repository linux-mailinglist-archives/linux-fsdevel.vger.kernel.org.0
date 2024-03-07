Return-Path: <linux-fsdevel+bounces-13880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E07B874F81
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 13:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7930A1F24961
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 12:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D69512C528;
	Thu,  7 Mar 2024 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BblRqK9g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ve4E3vk/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4159126F3E;
	Thu,  7 Mar 2024 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709816248; cv=fail; b=jD3xoqOghKmiAgLUp2WB+UijFIgerWNYpfeOg0D/tqtZAKIpUsSa/AKbCvMYQ2zOD3bCVsmPuIZQ6hK6KykfsljKS16CJwPiu0N4NoyDkBMM0r8tSu+gL/DZkHboudck4Qsxu1u/6A8ms8baj41srb3zhWqrAaqEA/1Y53gAddg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709816248; c=relaxed/simple;
	bh=Qdthw9q1rggyW2wbSfdLrXCLPL3uoYS82ODvJulYX+k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BqlTYj8YHp/N3YcOtZroGiu7nv0Uuhr6LfHm+2n4wlHRKkFkAxajUpcl+wTgaSphDvZgBNuJVGbOjUbS9sFLV1tGufo008gzMsobUX4pxs2wSp+Ab8YC9qZ5g6HzFOKpN8qaqyiMq86CvPcUUvf+PEeqqCqw3vWO4CkSNkf0emg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BblRqK9g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ve4E3vk/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4279n9kX021884;
	Thu, 7 Mar 2024 12:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=y+xLJV9mc9WsQP/281Ha4KchmUD55iAZYZK4HOE0fMU=;
 b=BblRqK9g81UwtLZEBkr4dp7kM0xltCJWGozawZzIToyVJtSc4xLzkBkP+a5OY7ki62kg
 vV41EiVUviFpY8xNlFjNa6W1igqLYt0i+Krh78G6PViqyvU62fHGMpOyrziZhduWYCLp
 1kkHGhnzp39+XblJS6pAXQhufZKtCpNl0eIoOEHXjUv9Zq7FIe9/WIqHVN2FckM/RiOT
 wUUVk/eQd05c0D0T53+LmWh8oyqUJ3aN9YdZOkcZfGUTGhnXM0xX1/oEtF9miqOmXA4c
 xjY1MkO39jatM4CzTSGZAXPxItA1Hj2Or9XkN0Iw8NQxiszDdtuHeZyMICSH1Hk8JRB3 zA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkthekupf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 12:57:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 427COv1a031891;
	Thu, 7 Mar 2024 12:57:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjb62w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 12:57:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oa08ELOwDILuxGPE8Wf73Wibatsj8BdWD0Q4xMOreQ0jaGS3GoZxVFBFouLC0/laBIjgq8CJUQt3mMBVCqJ/5OC6BZOt4HRpfOvtMQpuMWupD440JuvtI66yNriudvRTeNV4j5Xm86is7wg0aOCy3SxpCpHL4u7EACDeaAVrBQO1Xd7ibptHn3HcgB1MmssaQrYN9zHIfsGW8rJ7R80wkCBXkVRygUvmuQjlkJONs/LOIe6UZNkj+OXIGtWQ80EorZHTVtxzxFn0mmd2JSEQCkKm64WtF+dAGX96Vv29MIJ05T6Xs15Ju0HEKQzRssPQJ41xOgSYaQhg/yp03sIplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+xLJV9mc9WsQP/281Ha4KchmUD55iAZYZK4HOE0fMU=;
 b=UmZxDaTlvQ9kQ67hn6eG6qdQPoLnOOEg7pQrT3cWbWYAbEOUtRgxcAEpr+Y91KVJ/hGJDDqhaNuStJKIabALB+YXR4VnEAbcLZSIY+t6N9D2JTgEFoe93C9477ueWf5HlaBio87mjj8F5xttCP+LEQjof2T+oFMrRk3rknnvSlW0H49yIeaOaLwbN0Se9adcvu2RUOsM070CnntQQFn8Ha8lfITuVQoQMfcqnGa+3oVPzHwyCIINUuvrgffMam1dw1PTSNlv2otfF4lxiErqmf6Rb8LCaQyWlam3qCj547u5sLRzINjbxJDSNA/sMYFs/XpH0x+3Vu7yJo/igkt+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+xLJV9mc9WsQP/281Ha4KchmUD55iAZYZK4HOE0fMU=;
 b=Ve4E3vk/QbYuJGH8gF3cllwNmembUUih2TCwC5/ArCh8+gsI2xO2eGNVx5k13W3qM0TMEuw+CNU8u6FMhalbNmEXJ7kCSLyOqb0PE+Qz2xqsNPFzNgoEguTsDJ78HfTiLdYVXB9cGynFl0aQZnHjgzjklTfWX79i3LhigPByGYg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7495.namprd10.prod.outlook.com (2603:10b6:610:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 12:57:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 12:57:11 +0000
Message-ID: <66204b26-7a8a-4c21-8728-aa3c5af5822c@oracle.com>
Date: Thu, 7 Mar 2024 12:57:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] fs: xfs: iomap: Sub-extent zeroing
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org
References: <20240304130428.13026-1-john.g.garry@oracle.com>
 <20240304130428.13026-9-john.g.garry@oracle.com>
 <Zejnc+M32wRIutNZ@dread.disaster.area>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zejnc+M32wRIutNZ@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0268.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a9d028-ad15-4028-0009-08dc3ea61a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FeMTPoe67txU+GyTHgo5QPldZZlDKRA2qdlNiyhOj5tDzjqlb6OQnuqHPHdtvSLyVArvdj0jNMQMgizlr5Q8RIzF/solGVYj/V28j/mXTSCD1yPVXu1KkVzbW7pkNRxr/z+l/sLhfQx3dhVT6IhGRESHRRI+bZTsLLfWkIqFGb0+Cril7l904/ojP14s2KVnbmVJebcFw/dFnEzpths9KnUFKL0CvrLcYUAdqBcZmpmQDg2F2rYR/LcErrqm+iYVpcPSdafhLhI9SYIi+8XCFK2KkLY2UNcYNwtM93dva+TLxk1leqsy7ragMVjjShXX6/TuxPIqdU2sU5HDJeDsxRSEO9KNMHhPH43I/zMTpahrb9YeVSCMpcb8rRYYny5N/9apFAUqfX6N9STFwhpYE3iSERIyRSUWsxsfvXBmHJl5YPdMLqbj9/5rwRiX34woY/2AioWVAgt6W6wQLkxVNVa2WxAGM7/s02ZN/17ctKNN8N9md0jYZSPwdwXZhXYK99SZqjgQzLFXHZ+HAufY9Mady7Sr95cBr5P94PZeQM6zfBxERxVjfNxamFWua5YGcWU2LB3G3Dd+dHYEVnDuayTxm5RsiLLx+iGWEi6OYiJXFa9EOMJIj2w5G/Y67uX1gtKJfisiWbFRGjCOlJ0ey+6hmQ7i4ZDV6OJTaYsKoF8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S3BFMnBkUVA0SkpoMENsUUhHdkVoR3FjdWRLcUNHZm1PU2dMN0thd29hbFJa?=
 =?utf-8?B?QmgzR0RBSlJiR0twVWQyWFQ1ZjN0MDc1d1pCWVZ0TEFUazExNVdwVTVwb2NR?=
 =?utf-8?B?ZnBDRjJaaXlSK2RjQUN3MUpDVFFPQmNSb3VJUDdmZ2JWRGpGa1lIUlJtM2M2?=
 =?utf-8?B?NENVeGxYRVFWZ3RCNzVFZ0t5MkZlajA4UElUdmRxMnpmekJCYXBhT1ExZEpU?=
 =?utf-8?B?VXpXQXpOTE1ZS0RVZ2RwTmo5V2dib0Y2bFhHaCtZSG5sZmN5TCtEZy9UWElM?=
 =?utf-8?B?amVNdStXY3ZXVGNEQXJ4NnNOQWV3aFkrU24yc28xblZobkpXc3h0TFp0L0p6?=
 =?utf-8?B?OTJUNEFySHF0NjVjRXd3Slo5TzkwUE9IT2pYMzcwV09GSnN2U1JVbm5WT3pw?=
 =?utf-8?B?YmxBWTBobEhVYlM4WEEzcnJsRmFpSlhMK0JDR0tzcEkwRG1xZk44aWpXQW9y?=
 =?utf-8?B?NHVpc29vaFNUb050WFpwZ2dkSkpCUlRIVHdHWnVqUU53b2RuT3dtZ3RJQWl3?=
 =?utf-8?B?OVZkS2JuRjNjZGVyOFZQRTF3VUh2YTB6WS9QbUlHM3lKSmxXT3FhNEx6dXhN?=
 =?utf-8?B?SUk2TjVyVHREcVY5ZGl6aEx3WlhRcEVLZENQcnFjRnpSczhtSVdHaTdvb2w0?=
 =?utf-8?B?NVVON2pYbU9MUVZNb0tNMFlWenZoejlTcEVwdzYyYUxrdWM0V1M2RUxrNkVK?=
 =?utf-8?B?K0hEWTFTQUEwWFV1VHhkYU9xY0dzREdDSDd0bWxjZGozN21wRXhKWXk3dUlK?=
 =?utf-8?B?bjFablRIbHZobHZmYzdXYXBPNXdOdUlNb0J4TVFqZC9uS1FRYzZrSmxtdkVa?=
 =?utf-8?B?dDdlVW9pNFZ3T2NIcGR4SEpjS1RLRzZ1MDY2eEZpb2xLbkJkaUhnOGlldlhm?=
 =?utf-8?B?NGJRODhhRmdWVUF1ZXdBUDhqVUlkdktqL1hsZk9XMTh0VFdSNWk0R3hpNERB?=
 =?utf-8?B?dlZkenVza3Jaa2ZQN3Npd3RndkhkSkovNEJXWUlOWTlaaTY4SUorRDdLbXJi?=
 =?utf-8?B?N1lRU0dnUFdhc3ZNVElRaUIrQmUwaG1QL0RwZmw3MkpQTkYvSFRJU0hrOGth?=
 =?utf-8?B?K3VIMFMrUkhlMnlsK3FxR3BoZWRXVGQwOElVQVcxN2lYV3doLzRORGhwbVRS?=
 =?utf-8?B?R2ZOYUJWaWd0K053c3ZFdWZPRHZvdXQ0ZEN6MjFQM2dENjJ3Q2NnUGR2elpH?=
 =?utf-8?B?UmZsemdIUnRyZysxN3QxSVhBTXJQTUhYQlJCYlluVmxpYTA3Y2J6blhiSlZS?=
 =?utf-8?B?ZHNEUmRtNnRLaWJHK2dtZHg2SndKMUZybUl1V3R6TTZUeDBsbXI5SVdEVklv?=
 =?utf-8?B?YnVIaUx1MkJ1R1pvaGtJbkZ0TkJwdlkyeCtSM085dnVCaVJCVDExRWc4em1x?=
 =?utf-8?B?bmdNQ21sZStLOTU4ZU9BOVQ4VEVxMU04eHdTMDdxcDFaVkVZUGZpa3krT2FP?=
 =?utf-8?B?T2xETFd3YnJiYXNFZUFWQVFoaWlQbGhkcUp2QnM0SFczTGcxSGVPbHBiUW5K?=
 =?utf-8?B?ZzB0aXQwMDlJYnk4TW9ObHRiVVdkUlhkN0kvWWRXdlRvZ2NnQmxtRUdnUUdr?=
 =?utf-8?B?am9EN1phUXdZaVk3UUduMmVUblhZODhoaUllOWsrWVpIZzFYOG84L05MU0pU?=
 =?utf-8?B?cmFxd1pNWUZxNm5ML1NOWTBxRWhpU2RjdnZOeDRNQkdGNVU3V3p3MTdZdWNS?=
 =?utf-8?B?T2pQSkVHTVJQYTFMdlBHUlJEODhQdEZncFZBczA0TEdHUFBrQXU3R3FUMnJy?=
 =?utf-8?B?bUJ4OVBRMlA5Mk1rTWpoVlJsclo3Tm12YkFHa0tXQXJlTG9MaC9USU5OQmIy?=
 =?utf-8?B?VzNCK3pYcklLemtYVjh0M0dKR1h2QUhSNzN6RkFvanpmY3NtVm5TK3A5YWZY?=
 =?utf-8?B?YzlkSCtNUTVyeVRJbytmSmR4eHMyVS9NTytoOElpZm5TeldyOTlNdkhiUEsz?=
 =?utf-8?B?ZzlaTnlXYzBFYkRBeVdjQXRDZmgvOGMvcUFkWFNTNzErSzlvM3FKZ3FFSmxa?=
 =?utf-8?B?WlpRZFZyVDZWUHJGVTFGdVl5dzgwVzF6T1JYRGZVM3o4RWUwVlFLdzJZVkgz?=
 =?utf-8?B?R3ZiSEFDSmYweXBETnJod3FGY1Q3cE1yZ3hhRDNiRFdBejZFdURKdjhWMG1S?=
 =?utf-8?B?V1lrZ1J1d2JMNlRGVHJWNFFyeE9KS1B0S2hOeUxEN20vaXBzS1RUeEwrcE5m?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	79n4tHsx8fvRl8u1ItPC+tz33NGx5yXUbOYsM0HQku+D4Fk2fztMSqjrIa1YDeRLVlOUhvGMVjHTDNVho2hKO5jTU2kyYL4iW26VFmub7RlWIWKNaWhYG5JnnzuFb6OJ1NoS6YrSOq/OOOoo6y6e+4v7PR06I26gjjNfhe9IAG5/6OtzWoEtafW5Zmua+NfAqgovhBm9J4VW5DY5D2QAlEIJVAeIyqDOmn7Lzb7d8d4ew1v1njQop6JgV7+wi0mIb4JDj6nH5yfGoG3Zs2POi9Az4oyY0ypGtqoEsSWWJPY0zGRtGAYQuT9JyvMkIls+lnmuYund3pQ58Y1GqXwgD9U3GcYb9HaikjmN8HdK6eOgvuwyBItF5nxFCUegQDzn8ACWh880rIc0u/CofOTBnelOufa0bhNp5adeM5iFjsmwdawTQyr7VwLcAw76qtIkZx4JJv5AYV70XI8yS+iUKe4MLRZip5/L+ClGFwketPCObLMW/WyeMaMHWzFtmTT9wFKZ0VRPx5mFQ96KwOULLt9JHEKy9uXZxfs9D64txlGe4e2okm5z4z0rf81ah8oRYHTUCa5pVnyV8T3IileTl2IsQMHXm0G+xWmXoGD9lRs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a9d028-ad15-4028-0009-08dc3ea61a9b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 12:57:11.3455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3aMZ4w4GLGNaCNPSFBJJR7pLqkn83ZkmFziHuHdMUcnEaUEbhKp3/vOsRTSxkl3ZydKDv/C0OAAB6h4UH1wEgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7495
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070087
X-Proofpoint-ORIG-GUID: _01GJSuokra5yP2Dld3zXMFfqw_rsKDI
X-Proofpoint-GUID: _01GJSuokra5yP2Dld3zXMFfqw_rsKDI


>>   
>>   	if (unlikely(!xfs_valid_startblock(ip, imap->br_startblock)))
>>   		return xfs_alert_fsblock_zero(ip, imap);
>> @@ -134,6 +135,8 @@ xfs_bmbt_to_iomap(
>>   
>>   	iomap->validity_cookie = sequence_cookie;
>>   	iomap->folio_ops = &xfs_iomap_folio_ops;
>> +	if (extsz > 1)
>> +		iomap->extent_shift = ffs(extsz) - 1;
> 
> 	iomap->extent_size = mp->m_bsize;
> 	if (xfs_inode_has_force_align(ip))
> 		iomap->extent_size *= ip->i_extsize;

ok, fine


> 
>> @@ -563,11 +566,19 @@ xfs_iomap_write_unwritten(
>>   	xfs_fsize_t	i_size;
>>   	uint		resblks;
>>   	int		error;
>> +	xfs_extlen_t	extsz = xfs_get_extsz(ip);
>>   
>>   	trace_xfs_unwritten_convert(ip, offset, count);
>>   
>> -	offset_fsb = XFS_B_TO_FSBT(mp, offset);
>> -	count_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)offset + count);
>> +	if (extsz > 1) {
>> +		xfs_extlen_t extsize_bytes = XFS_FSB_TO_B(mp, extsz);
>> +
>> +		offset_fsb = XFS_B_TO_FSBT(mp, round_down(offset, extsize_bytes));
>> +		count_fsb = XFS_B_TO_FSB(mp, round_up(offset + count, extsize_bytes));
>> +	} else {
>> +		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>> +		count_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)offset + count);
>> +	}
> 
> I don't think this is correct. We should only be converting the
> extent when the entire range has had data written to it. If we are
> doing unaligned writes, we end up running 3 separate unwritten
> conversion transactions - the leading zeroing, the data written and
> the trailing zeroing.

Then I missed that in the code.

For sub-FS block conversion, I thought that this was doing the complete 
FS blocks conversion, including for the head and tail zeros. And now for 
sub-extent writes, we would be similarly doing the full extent 
conversion, including head and tail zeros.

> 
> This will end up converting the entire range to written when the
> leading zeroing completes, exposing stale data until the data and
> trailing zeroing completes.

That would not be good.

> 
> Concurrent reads (both DIO and buffered) can see this stale data
> while the write is in progress, leading to a mechanism where a user
> can issue sub-atomic write range IO and concurrent overlapping reads
> to read arbitrary stale data from the disk just before it is
> overwritten.
> 
> I suspect the only way to fix this for sub-force-aligned DIo writes
> if for iomap_dio_bio_iter() to chain the zeroing and data bios so
> the entire range gets a single completion run on it instead of three
> separate sub-aligned extent IO completions. We only need to do this
> in the zeroing case - this is already the DIo slow path, so
> additional submission overhead is not an issue. It would, however,
> reduce completion overhead and latency, as we only need to run a
> single extent conversion instead of 3, so chaining the bios on
> aligned writes may well be a net win...
> 

ok, I'll check that idea.

> Thoughts? Christoph probably needs to weigh in on this one...
> 

ok

Cheers,
John


