Return-Path: <linux-fsdevel+bounces-34874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDA39CDA47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 09:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE1528385A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 08:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EA8189528;
	Fri, 15 Nov 2024 08:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EtVq1RcL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tnpqzI/h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2B716EB4C;
	Fri, 15 Nov 2024 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731658530; cv=fail; b=Haz+Jv5tUpEyrOqmBotym8EzeyzJAV8LldSnZvDZTDUgSwtj7t9Mia5OHprQw/04lNrNNpp84P/nmJ5cusw0nr0C+8UBEevzzBABp2olJsGcCEK+c2Hj8kTLwIEKTqDU2gt8SbVEsmTBz+wh8adAU2hPcS/uMGHIszIA/uW3hmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731658530; c=relaxed/simple;
	bh=E+EUhtMXyug1KzPIVRIOSIivQ0VEpaQwrsYak0a8Sig=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JggC9BBQiAipMHplU2+ZUiv9COF8FKNrrkC4eGGnk3x8c7x7JzvOF+JJoQIaH/remvtXilyR1BKuVn9clIYV4yL00TW84oYImUkBEyMiveWphNQpWjb8/3saO1yz9QLkTYdPyjEWpZnQfp5cmyTxscnW9x8K/4LSiJuneqDdRX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EtVq1RcL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tnpqzI/h; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF7detQ014376;
	Fri, 15 Nov 2024 08:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=WK1pzDkErJgtYvBFKH3/V2ugyuVZncy59l/JHSTA2qs=; b=
	EtVq1RcLXNBkQRceAPYN7Zpm7dcNAxcD4QKc3x1cTbmhQNAoIM3nZGaqH2eBOdYr
	98VA0p+hKJ97j81HYX7LmdKwqNZkkLU7UuwjbJqAbNB9ll/+0jq4J95+BY0vzP8z
	1ZdVtEvdbThP2tuiYytp1yt3sJoVuhqujIcGxA8fCg6CBl13eJO3TI1Ubh1xKFyV
	g/e6ceNXSCPJ0Ekprb5+z3tHdWGA16GVpOULRlH37OuQiNCfnAHmx0LWjfVN+Jpz
	Zw+VYR2sQ6BWA3dwHm6v49asyewXpQTNAVolibgf51dU6g4IOAoctQOpLvfjV07C
	22yp/eM6i5d3QP30yQL81g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbk0t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 08:15:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF69ixY000494;
	Fri, 15 Nov 2024 08:15:01 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbpbas5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 08:15:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgKuHuCyohaCguvoxm/M/lBojEE73leYEi8R5X0pOLa7dP4gsiX5AgY/jvX5hRWljMHwc1PU6+mtfnpK03qVVGNV7EIUdOdTQTP5qbsjfDuRuOpmUK4mk0AkDj78P8G/s7LmWeaMkB7+pmN51puO+5K5kz30Xgli8d2WR0/LDIog8tcmTKTIUaxzsORxRRuvbqRjVOP21hnpbnSKrCQn3CpvRSQkTRywIoJouMVF+nvcMRd+TPSKSVHL3VsNiOP2uhaMw9QPlQ0gDtTGfgfCHDcPCJgci9W3gAmrC9P0X3wELMMu3uQmfHRZ9Bc46sAjxstR10ITpOSuCjOARCDqLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WK1pzDkErJgtYvBFKH3/V2ugyuVZncy59l/JHSTA2qs=;
 b=UpPXXdrvbeoiP86pc4ezwpbDwtOGf0Vq9eaVmQ8mMUP4JZx6uWUkR2KiZQ7aUz+N8UlkOnKtuea+HsJt0F7unZl6kmLnZmY3QsLaJ4hfmv/hhAey0KjHdmBj3BC1o02oGgHDY3AzeYpHwrJxNS9t79M4FC7tmG8WASdQdxn7lkZkWhJYLnp9OSz0uwTeqgx84jB5gr46UpffpSnD1llgt84nr88sLYIGiPmhvGsxzagGmBYF8JaS7EFT8wsPLIdhAglFMeW6TerFGC96/kuSAA8ExZzrqPq3xH5vBsuTv0gLN+4jx9EBQL3W1dTP3yJyed1qlLFvTrqA9P9bGIWcMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WK1pzDkErJgtYvBFKH3/V2ugyuVZncy59l/JHSTA2qs=;
 b=tnpqzI/h9gpSxHKTbHyYJ3lW2VlpxdgRxIiJANAZT2NmljHilflDll3yrTFyePg+MopGnhsEjh0E48dX3Jru4ew3HX7ugbYc0GbbJi9/urFwvQQ1JyELJTRHEmTTM/YxKyc+yio5m4LGzph1vFrEpv2SCTyeAiUAK5mL54SLFaw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5676.namprd10.prod.outlook.com (2603:10b6:510:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 08:14:59 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 08:14:59 +0000
Message-ID: <c5e418c8-e9eb-4733-902f-a1000be1ad73@oracle.com>
Date: Fri, 15 Nov 2024 08:14:55 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] forcealign for xfs
To: Dave Chinner <dchinner@redhat.com>, Long Li <leo.lilong@huawei.com>
Cc: Dave Chinner <david@fromorbit.com>,
        Ritesh Harjani
 <ritesh.list@gmail.com>, chandan.babu@oracle.com,
        djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        catherine.hoang@oracle.com, martin.petersen@oracle.com
References: <79e22c54-04bd-4b89-b20c-3f80a9f84f6b@oracle.com>
 <Ztom6uI0L4uEmDjT@dread.disaster.area>
 <ce87e4fb-ab5f-4218-aeb8-dd60c48c67cb@oracle.com>
 <Zt4qCLL6gBQ1kOFj@dread.disaster.area>
 <84b68068-e159-4e28-bf06-767ea7858d79@oracle.com>
 <ZufBMioqpwjSFul+@dread.disaster.area>
 <0e9dc6f8-df1b-48f3-a9e0-f5f5507d92c1@oracle.com>
 <ZuoCafOAVqSN6AIK@dread.disaster.area>
 <1394ceeb-ce8c-4d0f-aec8-ba93bf1afb90@oracle.com>
 <ZzXxlf6RWeX3e-3x@localhost.localdomain> <ZzZYmTuSsHN-M0Of@rh>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZzZYmTuSsHN-M0Of@rh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0195.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: c5760a2e-6afe-4e70-6eba-08dd054d9879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkc5Yy82eXJRZ3RLeFJLYklyT3Q3OC9OQWN6YmJrcWp0WUNEMVBZekJ6emRp?=
 =?utf-8?B?QU9aUG5XY1JFOUhiR0I3SHViRmg1NHFjQ3Z0T3NFVmlweGZ3S3A3c21pOTNs?=
 =?utf-8?B?Q1cyOW8vczB5aHZEZDlLN0RuMXJ5VnZsYTM3aVZ2b1FqY1NqMDMxZStKcDl3?=
 =?utf-8?B?bU5aZ3Y1aFdsbHNtVkhnOHVXMC9Hc2dhTkUxNjUycUR0eFppalRmZlowckRH?=
 =?utf-8?B?bVVrZXRiRkxPUVdvUCt3MzhZcFdoSHBPS1IxcVZIU0VwQXpYRnFZT2VpQUo1?=
 =?utf-8?B?WVN4U3BDTFc5ellWUVF4S04yNDI5YWJhUlZPL1laT05TVUtOTGJ3RmtFM1B0?=
 =?utf-8?B?NzJCK0VVUytpVTl0WVVYTStjTEdJdjBLYTJrQmJiK0MyTU42aHdYN01TSjh3?=
 =?utf-8?B?QkdUSTlWUUlVeWQrV2FBSmdGL2JuVGNVZC9GTXFQOEtDM2hGaGRvNVZIcnFH?=
 =?utf-8?B?R0tGdzdJa2RRNzA0eWYrZEhDNkE4bmZUa2hmUkhXdG4vK2RFbEx6Tm5HbjJH?=
 =?utf-8?B?ZXdpc3FLNVZqYXdjbEY2KzB0Yms2V3JJUkk2WldqWnpwSlo0L1E3RlpRMEZM?=
 =?utf-8?B?TGNUejIza2lMQllneG50aDk2WHllR25wcDlNNEJhQ0xaVld4VFZzRWJPTWRL?=
 =?utf-8?B?L0V1emZFU1dOeWpIRG1XVkNNZGluSENHdXZPVG10N1RHdG40bWFUcGFVZ2Nl?=
 =?utf-8?B?UFpiMnY5Vm9WaHcvdEdZcWltdGhhZ1Z6THlVMXF6Y0ZkZHF0VmlMcGppdk9Y?=
 =?utf-8?B?ZUs1dXZNRXo2TlVBS2swOFdkTWpCM1lNbUF3WGEvWTV3bTFPclhweWZqTzN3?=
 =?utf-8?B?ZlZQUVREc2FzejhVWHNVTmFPY0RZK21idzdOcm9kU1d2NFQrQ0lrU3BiZUYy?=
 =?utf-8?B?bVVhbng3eS8wUlpvTDR4Tit0aHBSVG5qK3F3NWFzWlJmWVJMdkQzZW5wVWNZ?=
 =?utf-8?B?M0Z5QThBMStFeVZsK1M2ZFdVTUdhWjJ4aytqNG96bXhkM3Q0azh6SmJBbFc3?=
 =?utf-8?B?R2xjZ0xDYVJpZ1hFTk1Ca0dhS1VpcjlPY1IvejhGWVVSaktpdzFUb0xGUWdv?=
 =?utf-8?B?bTNSQUFscWFjUEs3eG9uOVFKNXM1ZTJUbzJOdGZXemJoRWtHOHdlRUdWSlBC?=
 =?utf-8?B?aEZwWFluMCtKelRGNitNaVFVbnc3bXl4aXRXZXNNOVV3UmRLUmxnWmRrZkg2?=
 =?utf-8?B?aDVBRWlxQWRTYmVrL0w5dExScVJaSDhTMGQxRUFWOTlyUVJadjV0d0NaQkNB?=
 =?utf-8?B?alJ2SEllMUFjbG14NDl6ekdOdDlWb200anVzQmFqaDUvKzdRakdQekIvaExG?=
 =?utf-8?B?MTFTYUFpZmFOWDltNXQ4VU5YeHNiY1RpZnFRbCtTc3NUOFYyVnFObHdYTDdQ?=
 =?utf-8?B?T2pKbVZRSlNxUzRGc1ZRZVdqL2RMbFJwemZMVHNKUjZYVUVHWGV4bnQxSkM2?=
 =?utf-8?B?Q0hhSE5tVloxeTlmWUUwcUhjSWxkeUZVNXdiZWZKTGUvc05GY0JPNllnRjUr?=
 =?utf-8?B?dTB3TlkxQXZaSXpzbHI3a0Z1cW1selM2aGtQRkRLTFhCYjZXaXBRd3dzdUFw?=
 =?utf-8?B?THpadzBjdFFmaW02Zmh6cHlMU2wyU1liSzlTcUlxQWlWblgzTWVDb1BLb0px?=
 =?utf-8?B?cUJCR3BVRmRZWFRxbEpVY2lNUUxOYmhkZC94RTJ5aVZTcjJvZStvMCtjaHow?=
 =?utf-8?B?NG51MTdEMnp3YUxTMGhLdjY1Ujh1UldHa3FFVGxScDFFQ09KWkxsVlVsc3lF?=
 =?utf-8?Q?+d/vWAwTZ+HHVovkq4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTJFWGV2SGJ2QXRzRWdwQk56UVZaN3RiajFieDJmQUI4N2NtM21waXo5V0dD?=
 =?utf-8?B?cWF1RDBuWnJSMHJ5Y1Y5NGhCR3ZPV25yYXBLZWxZZkRRVXJtYys2N2xlKzhm?=
 =?utf-8?B?QXd6REZoVzBod2ZjUnRuVEJwTW1scnNBWGlCSGdJM0NhcVpMbHZ6aEM0SmtM?=
 =?utf-8?B?WUhoYjMyL3pneDB3UC9ZMk5IaEs4SElubjZQUkh0OGM0R21LZmdGRG4vNjJK?=
 =?utf-8?B?eSsyTFlBbFhPMnYxU3B6SzdPbWliczNXVGFuT21lZHBETVNaMHpoMURsSENO?=
 =?utf-8?B?YmNIbENNTEs4R0h1eGZBeHN2VW1iNWVaWnBxSmtyK0t0U2JMc1Rqc0dCeTBS?=
 =?utf-8?B?Ti9SKzMyVWdGV09mMHQvaFROWE1rQ1J4RkFqblQ3ZGJvQnJVNkJFY0NJWVkw?=
 =?utf-8?B?TkFHcVUyNCtpaUlOaFhIMXhEbHVmSDg5U2Q2alFKYmdFTkFPV2RGSFJ1U1FF?=
 =?utf-8?B?MEdHUnozRzVwOTlGdzl5UGtpdjZCdmVVbEtONGJ5MjN3SEtBcUxxdWhrb21o?=
 =?utf-8?B?QXpCWWZIM0F5bGV0aVB5RysrOUlBMVZ1WEFEZ25tVm1mS0tJQnZkNldTd0ts?=
 =?utf-8?B?OENTNGs1VmFFNG1EdzFydjFxZTJ1aUM1dGtVaVpsOVdRZ0RadkdQUHU3Qjcy?=
 =?utf-8?B?dDFPdHAxQW4wMlZSM2x5NVNRMFpYUWo4YzJhcVBsTVBNUnZESHVqajA3emlB?=
 =?utf-8?B?WUhIeVZNejN0cmdWaGZpMmdpSzdSU0pneGJESG1mRDhVYWtHK3VYTWt5Sldr?=
 =?utf-8?B?bGtOQXI2cC85SzhXdmMwTkFQcEpjRUlWUUxERXRpd0s5N1diRFdWczVEMkVq?=
 =?utf-8?B?blZIYjU0U0pyb3JpRTZ0akxQRmtEL25NWFk0L3RtZ3M5SkxqdS8zaGRhci9K?=
 =?utf-8?B?cVJjS1VIdlkyckFwUFBVWVZzSGVydmtDa1o0dmdQanl6eWlTbkN0UDhzajdw?=
 =?utf-8?B?VmE2SjA3K2k0anUzNFBDcjhyMXMvU2hDYlNXZ1MvZlVibC9xTnVpck5tZHdH?=
 =?utf-8?B?VUV2N20wZDhremt1dFN4QVg0cjVrU04yV0thZUs3V1lYeVE0YU9IdWZ1WU1R?=
 =?utf-8?B?RmxkM3NvUnA5ZGNqZ3dWU2o0aVhNbTFBVHlVSTYyL1lkSno1SmtaUW9KNWxH?=
 =?utf-8?B?d3dKN2pYMnRQTmxkWlhHNkxmbUhZRHRIdFpVQjhia0daYk44YnFuMVEwanFU?=
 =?utf-8?B?SFM2R2hvQnZuUWhkUkt0ckZBbzB2WXNtd21MYjNZU3FISU5JUTluaERmZEVB?=
 =?utf-8?B?OFFhR1hZYUx5bytkQUdRMmNxbmdpNUpCb29JUnFWT1FBYkVKOG16c096VUVC?=
 =?utf-8?B?cHJFbXFsMVVMTFQ3TmQ2OFFKZkRGTyttcTd3Ui94L2gyWTQwbkw0YTlaM1JN?=
 =?utf-8?B?TFVSSEpQM0tjd3hCSU1PeVhzUTdPYm5HN1ZnaEM5Ull6UkY3eHkzMGVsanZQ?=
 =?utf-8?B?YkhRcEZNTFoyRE1FQllEWnBYMnlqL0lmRUFockVBVGpHZ1RiSW5IWjVnWDZB?=
 =?utf-8?B?d0o4ZElMc21PM3paTTBuNm9WZnh5L2pBK2kwNkRmQnBlYkwzWUFOalprSGww?=
 =?utf-8?B?ODJReTJWVk9LcDhLU00vRmtFMWFhZERPd3JZR2dXWmlZNlM5QmlqZE12WWZG?=
 =?utf-8?B?Q1hXMjQ1SEdRbDB2S2lkbWhEZmJwVnpPYWxHVktwTXFiT3k3Zm4xd1hLUGVI?=
 =?utf-8?B?NkFTNFdTVG90cVhSNkRuVDRldFdYUkU3cXNVM3pPY01iMGRNVzR1ZnpFOFR4?=
 =?utf-8?B?SS9uVFoweWs0cnRSN2pBUmMvamEzbEY2NEFKOGhpS3lIMzNnQXFZZFZ6UmhI?=
 =?utf-8?B?aTQ3TG8vY21ML1JOQk5sVXMyU2xjdUVtaFlVeWlHUGhEZ2Y5dytxQzJBRkxx?=
 =?utf-8?B?eVVlK3M3ZS9TQ1M5aTlKVUlISzY1eTA5SmdJdVdhUEJhSEFNSHl6ZXJCYUxu?=
 =?utf-8?B?VVhDYWo0M3pjajc0ODRwYUJQYWZwVXNDdnBmLzRjWFRpMG5nd3FqOGZrK2hL?=
 =?utf-8?B?YnFSbDU3cWpwdGtPMGtaWHYyTzdwZS9lbW5OMFFKVDFQa3pTMC9TMzJyQTBt?=
 =?utf-8?B?WGRDNDF5cStyN3RaU1I3cnVoaW1VWFZxejU3K1l2SFMyeHRnVlQwWHl1OVZs?=
 =?utf-8?B?NXMwbGxrWjhlY0liMWVCSXljcW53eVgvdXJ5UForTFRIVHZ0QUNwV05MbWx1?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h3/wyWekyiZNRt/2tLY4U3OmBO4x2npo89fjhR3thGoQ84jva6Idqv+kAlfzJWQNTN6s9A1T/5JYq/Q1YWbMxV7ikvNSuGk4CN+/tb86PI8a8Tx8pFH9J8ZiDL+EDiDh9X1LZTl1/hBj+so0G2Uw5EE2Qnjbe58Bb3Fcg8tQdgwXztH9ZiqRP4P52VbQ9c2wVocqBl0pKXcqeFvr5G8V/bXm19mjZGwVCxrvzULshDDhMrroby+mzRCGd4wPGdhiWAA0xt/UGocjS0t0a97X8QVBRFht/WRqzTHn+ScKZ3aPDdlzU04yEQ6mhOvgPLSg7nPZ9It5oBdghWDnnJgxfMKbdzCsI3G6NKjY1YqN+DGZ20RNAFwWpXTZWJSAe2kKxsLUgz6f4A4xwPehdoRFTwqprInpFSAhJHX87LuCCooJBTO1YsckH/ntS0LOwSkYxWDtCWUtbQUYtEwpXYQygkNVOgfKAwD9LKPaUjHpzSUEs6hF82XfsqzX083oRO16PaCfaMmjNWRxQg2ePRDGVyadfeMyCqHZhhlAGVTa9MHdU+mIsUpT1DD/5skxGcw59kci0MSafNR7bZc8McM2VqlMcr3ZmzcOjbQ4bsC9G3k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5760a2e-6afe-4e70-6eba-08dd054d9879
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 08:14:58.9219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVriFGGXh7vUXXdRpRR2aWqGFFrtzdYNd/lV1GjGlCiGZtjYpKSMNyhmwxeMT0QndMSTLvqlG9quAI6XFS4fbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150069
X-Proofpoint-GUID: 2EYeAiIPFnSeI25BFLW8U67brbNuYDY7
X-Proofpoint-ORIG-GUID: 2EYeAiIPFnSeI25BFLW8U67brbNuYDY7

On 14/11/2024 20:07, Dave Chinner wrote:
>> xfs_io  -c "pwrite 64k 64k" mnt/file
>> xfs_io  -c "pwrite 8k 8k" mnt/file
>>
>> If unaligned unwritten extents are not permitted, we need to zero out the
>> sub-allocation units for ranges [0, 8K] and [16K, 64K] to prevent stale
>> data. While this can be handled relatively easily in direct I/O scenarios,
>> it presents significant challenges in buffered I/O operations. The main
>> difficulty arises because the extent size (64K) is larger than the page
>> size (4K), and our current code base has substantial limitations in handling
>> such cases.
>>
>> Any thoughts on this?
> Large folios in the page cache solve this problem. i.e. it's the
> same problem that block size > page size support had to solve.

Would that work for an extsize which is not a power-of-2?

