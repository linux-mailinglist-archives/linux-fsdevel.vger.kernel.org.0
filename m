Return-Path: <linux-fsdevel+bounces-44179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 462ADA64653
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 09:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E7D3A8EC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 08:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAD2221730;
	Mon, 17 Mar 2025 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MQJxkkG1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tVvqQ7ge"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D59220680;
	Mon, 17 Mar 2025 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201668; cv=fail; b=cuepuVCLPZcGnVImpPFH+wMvNgSMFW0CAvm6x3lBlD3q3vcGJA0Zlz4hThaWpCSMaISAcOJXwbeYmwfGUH2+Ez2A2N70au9vLzln4EyhwBOFltUuFHYxPVrG0BBZ8zEopEO7NTIqKh4LAekfeus4MlcBeZH4P0B8pnU9EAj8nIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201668; c=relaxed/simple;
	bh=OFw/6kPiVROOEegRtyhgBwiQ1Q7iteQacO5stsB5hhw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z0Dpjvefv10oZ7eCuWQ8KKcI/FJ0FWkAHlWuBXW4MK+a0j1zWk8MD0udZK+3UyVj+VWEwtP9SHY9ZAg3y5CQNPq0wQseKbC/5mB04NZGd4LVO4ycpkiqtUbWkKOCKd/Hd2o+2qUQNnq4jZdZ3baGqYMtBOTEm/GiYk3RTy29GMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MQJxkkG1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tVvqQ7ge; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H7QifQ031127;
	Mon, 17 Mar 2025 08:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XdhPQn6B3aoGS4/052T45l/a08iZFXHlhhUKNtEh7yA=; b=
	MQJxkkG1hD8vjcJb4CqQZewZowX8ZgDx6zLd36WaxSz+6Ta1EQvEcbFJ6TVgxESd
	euZzlXjlvPObOCt/YALrfv2loyx14o1bAKWbYLcpSNMc1U4o8SixPbuRC0HU+F8b
	MDCm9QjjHaAgrwfmYgM4ktNQTgD7eJR85uvVqeo4J5zO4AxYVRHoTkESOgb6Vjpo
	ZuEfUFJaKzxn9vY2XnOWWqXXdaJSAO70SQmvD+q+NUGTaPnfRSKNjLTZul7bjTym
	RLQpRVIijPfDTFEOJOXWKmqUUifjDBNl5f9r2MemEv2sEGq9CAl0PprQ8dTgnZ1f
	8ER4tecWE49/gXO4NbMdaQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1hft833-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 08:54:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52H8ee0D009482;
	Mon, 17 Mar 2025 08:54:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxkwwc39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 08:54:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARPvwbTYxBHvVS5cF1fOpnhSDNzsSrFAhJQEPZqgOItNAvQEiACM7KBl2UTNtPdD1yphzms/lLr5DA4gfJUvM+P7BtYjIqH8kpDH1pmg65yO/ENACAUcyVPRAFVpYOpKxbXFg9/ElqFGJzwBO8mLuySx4Jim8tHk8DrTp95sDYJnikea9mm4/ohoS4Hl6UxSLwpfm7yvd6QGrQw/havCGixCWSGdLWqmn0ZXI4+m0MpVBvylSEKIJx60upUkYoyXwvlIzFUPoXqC9ipen4Iw0wqrgI6mFglrqekdnPOHTvofrVPG7EGmJFDBhShHnljTS6oyjElp3TDk3RjBgwuIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdhPQn6B3aoGS4/052T45l/a08iZFXHlhhUKNtEh7yA=;
 b=jewgPBR2c9x98MPAKS2Nh7c0G5LTqZMN7BT8YAw6Fhq7oYZfVgspMu58rp6LMCzf/k56KyGpS68lvxL1rCSp47RwdxZ8nwICNMHDkeQQvct1m7/lIEcZ0RZaq8/IQ1HyTla7foyntu5G0ZnnN98sSS6SB992zwanIKFdTwHmeAq/YIl7YqigYv+ePlvD6NeuwR2UPB9mHTwGHxX2ul5kHZzvLhyVJJB9kE16aWpNoNo6/7UTr1sfTkABgzGN7l2DCEm3OFxyZS8f6+nDWS6ap8qRsHCLFdSlGY6985eQvTedH8BSR5a2Sfv0gc5UrUIGdh8sk9crdSeOw38yXF014Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdhPQn6B3aoGS4/052T45l/a08iZFXHlhhUKNtEh7yA=;
 b=tVvqQ7gebGVCqb+We2IJ4W3TIEZeXd72LvGDNtQiEW9YehVi3fz4+Pnhprxy3miAqREAwXHI0OFcDxwjOEil4MByZnqUZpDnIj/GR4+VDR54GSY8f39G3jAe11KgAgU10/X3cSCCn47HFkMO3E1k156M52IFFgpoh3g2QIY1M+4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CYYPR10MB7565.namprd10.prod.outlook.com (2603:10b6:930:bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 08:54:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 08:54:07 +0000
Message-ID: <cd05e767-0d30-483a-967f-a92673cdcba8@oracle.com>
Date: Mon, 17 Mar 2025 08:54:04 +0000
User-Agent: Mozilla Thunderbird
From: John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v6 10/13] xfs: iomap COW-based atomic write support
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, brauner@kernel.org,
        djwong@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-11-john.g.garry@oracle.com>
 <8734fd79g1.fsf@gmail.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <8734fd79g1.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CYYPR10MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0bd9ea-0853-4c50-de10-08dd65314702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkR1RWdzYWtVSXNXN3hFMEcyeW53SkE5YVM1WnVvejV1MDNUOWtSY1V6Y0R0?=
 =?utf-8?B?VzM3S3RSUmpLaWQvYXBTOTVpbjFEUmJyczBreGdsc1dUSGEzS0YwdHM4MkdQ?=
 =?utf-8?B?SUg5RHQwYjBBTElqMVhLeS94eWJNZlIrZnIxTzcwSXVKMU1JTHJFSHZyNTZm?=
 =?utf-8?B?V3RST2NQRlo3OUtxSWN5VnovSzdwZWxSN2FEU2ZNcW9obXhYNDZORCs2SGly?=
 =?utf-8?B?cHRVQnRsZndwaGhwT09qV1dQL3B5cFNFZGtoSXhMai9GZmpHMHVWSGhGKzR5?=
 =?utf-8?B?REhjNk9SWG1EbzgrN0tnc0VBUVhpQlRCdXlLaFhRQ3VLSGVpQVVZbWN2NFE5?=
 =?utf-8?B?ME90MmNVVllyNGhrVlBnQ1UzR0pQTkw0WlREbDBHUFFTeWRQd0hzS05ocnV3?=
 =?utf-8?B?VkZEQ1Q5K2cvNktSekNWYU9YcXhlN0lrS1lnbXJPZjhWVjRYRm1DOTZkRTYr?=
 =?utf-8?B?UzI0UE5HTWJqb1F3OWg3WG1zaHpwNC9aZFFVL2JlLzIxQ2llTHVnUVpOcDJq?=
 =?utf-8?B?ZWY3dUJmK2FKcmpTeTJ3ZStwdUhXSXVuQ1MyZ1NsTmR3Q2RxUjFRNytJQmtW?=
 =?utf-8?B?cUdoQmF3OUJ5bkQ0ais4anllSStjbURJYUFIeGpLNHV1S1FBMHFSdm5IN2FH?=
 =?utf-8?B?c08wNFBMUjRrMkVkdWxXWXQ0RlV3ZHFoZXozOHlJeXIwUm56UFlXdk90M2k0?=
 =?utf-8?B?SjF6Qit4amd5ZldaM1RSYnQwWDdCVVhpb2dhZSs5Z3Y2WkpMU2FpaVpVd3FM?=
 =?utf-8?B?cVhRQTIxTkRqM1VoS0xsNEJmR1hwWVVGK2JKOHNkdElZVER2YStzOGRibVVI?=
 =?utf-8?B?SFFETDg3NEFYeXc4MTQyR3pXc0ZhSkFtUWlyN3V4aWwxdzc2anMyWURtVHdK?=
 =?utf-8?B?RXptNkUvWXhBQmpKYURNeVBoaXNRcVN5S0RoODVaek90ZzlkNnBjbG1xK3Ex?=
 =?utf-8?B?ekVqRWovWlUxNEdrMDc3cDBEWXNlSUV6NlV0THFFSFRXQmdSbmtFMXBwbjZn?=
 =?utf-8?B?L1NvcVdDblNlM3ZJN2hUdmlIbWhLZ3lBRGd5aVB5N3h5L3hiVVlqeWFWenZh?=
 =?utf-8?B?M1V3ZjNkdTRRTStBYWx4bDRrMVlCTTFKeWJHUTd2eEJRMUl2dFl1UTBJRjFa?=
 =?utf-8?B?MTluWnJIbkFIYWhPTkEvVVJVM3dKdHNYZ0RFUkVqTFRhcmpDdE44Ym9jT1Jh?=
 =?utf-8?B?NWJUdm1pTlh2TW9Zc1dqQ1FlWnBzQnNvZkdmOUUvY3h6eGhTK2xKMUNvbVlZ?=
 =?utf-8?B?N1hldnJXOTh6dCtJb2QxRDJrbWUzdUF1b1d3MDhCMDFTaktucVNKKzlab1JF?=
 =?utf-8?B?RUNMeUV4U2UrRHJydmQxeFZyclJmUVBmSjRpayt2QXAvSDNMYS9Eb0NXZERO?=
 =?utf-8?B?WWd4L1hzYmE4c1ZFYWRVeUVwWXVRajg0U0VMVzM5V2VNNUpqUmNUUlJmWHB0?=
 =?utf-8?B?b2luT1MvbVM4dTdtTEl4SloxYjIvU29idFdCSVJOeHRjbkszRlpZOXArYlZY?=
 =?utf-8?B?VGJZdG9XME5aQXF0V2pJQ0I5TWJKcDl1bmtkOGdSaExRcExEajRVMmp3Q0h6?=
 =?utf-8?B?S0lJcVIxVzNsTU9nZk1mN2ZYNDZsU2Nhd0YrYkxhdFJRQ1hEVnozZWhNOEtF?=
 =?utf-8?B?b0VpL25zTko0YnNGWlY4cGpvcWIyR2g5VXNFanVHQUhPcHlsZkpmc2tZQklD?=
 =?utf-8?B?eTYwc3BnV2hvTFN0RnVaWUFqWkxJQ3lOZXJwalpFdDJmVEVQNHFKclovMWpT?=
 =?utf-8?B?cFg4N0k3T3pVcDV0TXE1bmZiSHBhU0xYdXo3WWFlM1pjRnVLaVNpZ2JmK2l5?=
 =?utf-8?B?YnRFNkE2a1dudk9FSDhhaDFZOHZwSmk1ZW5wMDVLWG1lMnJLUThkcDZrZE94?=
 =?utf-8?Q?OHV2QJO4he41S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU5PM1ZUcHJaV3gwNXcwTTEvRTB2RURvM0I5dHhaQnFUclZRVFA5SGg0UHVP?=
 =?utf-8?B?aSs3ZzJCOGY0NmIvUUpCdFNmK3FtZmxFU0w3TWRvdXFwdkVOYzZUSEpYcSsy?=
 =?utf-8?B?WE1yWTgweVlaMWd5VksvcXQ5ZWQwdFBFTGl3M01JcDFFcDhaQjhYUFozOVlv?=
 =?utf-8?B?aFRMcGIwL3FnTW1WRmpiekJmaE02c2JleGRHbS9ta29VTWJyVityRWQza2Rt?=
 =?utf-8?B?bjdDT1dzcFlWU285Wk43dUpONnJ5dFljR2syTU1tNDVRNmJ1M1hUMEIyVEsy?=
 =?utf-8?B?ME9EbjE5QjZrTnFzWFFtanRDemFUWk91NG5tc2ZoVTZ1bGlBdzI3NXl4K2Qy?=
 =?utf-8?B?S0lUMEN5OXlLQllSb3lLcVJTT1dlcmJFVEdqb29CdEpyWmRUQlp4WW1oQ1lR?=
 =?utf-8?B?OGZmc1NuS2NGcmVHUFZhZi9KNitjNjRQMitUb2loT05pWjNiZ2xSTENSOSt0?=
 =?utf-8?B?MnJhM0VHK3lkN0w2dTgxc214Y0FUbFlUcHV6MXRRSmJ4M2tHVitLdEJ3N2lL?=
 =?utf-8?B?ZHFha24rc20rZFR4SDVhTWVXN2ZUNTVlblZkVVJlV2VoNFhvNzZwWmhpTzFX?=
 =?utf-8?B?SmJoSVloMzdHT1R5VFZBcG4wZEhOODhiZzlmTVpPeVY0bU9Vd1AwdDdBbDZo?=
 =?utf-8?B?OHZLNENTZXZzSXEybnZEanZ3OTlEVWJNVWdyUGhQWlFBSVpPSkdId1ovdEcr?=
 =?utf-8?B?V01sT2p2WTgydE1zNEpsZXNkTVphczBENG1OUEhGU3JFNEgxb1ZJRFBoSGxH?=
 =?utf-8?B?RWNVbG9zQ20vemRYM2JqaDFodHNBWnNRTzhmWnJabjBlOXlyL21COXlMMWpx?=
 =?utf-8?B?VmNtMTFiTnE3UmF4YnBVNXNlZjI2WG1zNXQrTFVtUXlkZ0c3WWNCUTFqbE1I?=
 =?utf-8?B?OHhnZmhsZ0dSNkZYWW4wTzIzRkhFMEl4enl1UDROUnBmdFhndkRpbTEvUlNW?=
 =?utf-8?B?Y1ZTanpxdVBGTktOd0VSMm9vYkMwOW13SXU0TC9VZjlFNVBzb01VV0F5ZGpB?=
 =?utf-8?B?WGNmcGpxb0syQ3RSVkZpY2FXQkpHTFdXSXRWMHl6dkVEVzBjUU5sQ0lLVGk1?=
 =?utf-8?B?V0hNUjdUcFVhSFlzdU5zZFJ3WS9Fc01IdlllUE5oaU9vckJkTmxiMjMzUmEy?=
 =?utf-8?B?Y2RmZVZYNHk5U0x5UjRIdlBDNWR3RHg4Z3U2em9mTk1yd2NmY2haL1lSeWtK?=
 =?utf-8?B?aUNMTEQwZzFMMlhaZVQxS3UvWFpSd1JrZEJRSEpZMGM2Y0Y2WlNCVEFtSWoz?=
 =?utf-8?B?eWlNN2VPbHF6aUdxM1ZqSjhlUUU1VzVUeHc4NXZ3RlhpRWZUWElaaVhQYnYw?=
 =?utf-8?B?Y1lZZnBtZHFwbFNkS0p1RmFBTWlYcTFLT1dDUFVoQVFXcGVxT2dXYXlwdzNo?=
 =?utf-8?B?ZUlqeGtWUnkyUncyVVZiSW8zRHhDbEFpN3BCcUJaMmVvYlEweWhqOUJLcHpY?=
 =?utf-8?B?RkY3VWpIcDhLTDNRMHZrNXhObTlWNktSZ21GM0NScmZWU3hLc2F6aWlrT1Qx?=
 =?utf-8?B?aVFYOER6dUY2NWNxc25WVTlqSnJxVTVCaVlQRCs1R0wyNnp4MmpXdWtxbUU1?=
 =?utf-8?B?WEF0T0hVWllNdTBZY1RiWnhNNTdpZDRtTENibGIrZGIzNUlpVCtXUTd5MDFk?=
 =?utf-8?B?Tmw0cHR0ellFUGF0Lzd1bGxNYjVnUlV4Y0l5MTdpZDY5dFpHaWZ1R0Y3YzdP?=
 =?utf-8?B?bmFKN2YxRHVSUE91Y2F6MUN5R0FjNUwyV0FuRnRHR3VSSTN4UnNVQjhkYTBa?=
 =?utf-8?B?UUsvbjFkb1gxSHlnQlFFaHIyRTN6c0tQVjRIQzFQQ2RaSzhvV0VjczF6c1A0?=
 =?utf-8?B?a0VZc0Qyb08vV24rajV6NGJtWDVFQlEyNjIxZGNYVGJmTzVqblU3bUxNdWkw?=
 =?utf-8?B?WWVhVXdnRHpDTVB3L3lIeVBZVFAzQitCZUdibm1wNDNqOFlxeUpueGd0UzBU?=
 =?utf-8?B?YmZMQUQzS3ZhM0tORHQ2TXE4K09PUEN5aEoyVDFyaURaVnNBWUFYaithbEI5?=
 =?utf-8?B?UXUwcG91TzJFRDRBQVNFckM3UUYzRWxJbzBLZVN2WlNucHpjcFBkUmRmbitj?=
 =?utf-8?B?WW5GWVdpUW5VRHFUb3BJbzdYRDZsVjNjd1p1UFVMNnpnbVV3Z2RLNzB5ekF5?=
 =?utf-8?B?WTFLa0o3clJHMStNYXJ5d3NkYzBwdmlKRU1JblVpekdMSWl6MVBDM3dKZFJI?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n0xh9JXW6uxyeRtAIdNfEFpVbHNAiu1TvUQS1dKr8ky6Zdgo+upC4CtkP3Istez8LZgfxit+YAYo1Gl+ZTDpIru9sZD4Dfb2v/tgXowHwwC0rrHl4Cv24+95xTHuoZIQ3wAmMrCICuNtsxEXfIstwuNWB+uihskp60t1upQ3dK+hRYAz9OQxvI9PCRjeWoAu+E6Omu+F3RMGa/L6mgsEgd7pe7wCy/LmvMygQ2h4jc2o28fkopBRKDKuNTH2+zfTsaryLsRiroJJ7B3u9dIPcUvl4efc4qW1wqkWMLHvVzJ0u4ILkWsPhIgJtf0U5Gix5hnUwGS5JZLx9JlKtwm3dcdGCLu5R/x1rDZq+7HTNcT9H4Ut1FWhsQjmUH48mJFdw5+jWhzAeDi1to8eimfpfwje7h6wp6Pow2FETslEqsUGs58ov8Sx7uIitt2RitVZpCIEtu8ELN39mtFGpokZqHJU7kINRIgPjXYl96CkzQbiUZs8l6U82+/zVWWQXlOwFwCJGSNDMVy/+UZEXVKcPBClWdg1ZE8D4klIb9Fi+ibME/L+K+Ma3D7MP9ypoAlG2pYduvtFVk5nkBLPjyOJL2Qovyk1VEdiWVYViy3TwvM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0bd9ea-0853-4c50-de10-08dd65314702
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 08:54:07.8154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYhsFR97DOevmmLc52L3S4NOfFBJobgy7PzKRuHh/K6+QEuDOfuhTWGSPopy0h6KnfI0kMXGT8drlCLLPFBOGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7565
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_03,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503170065
X-Proofpoint-GUID: JYCfYNdjqPiM-XBa4voz8MgOXFYz6JSr
X-Proofpoint-ORIG-GUID: JYCfYNdjqPiM-XBa4voz8MgOXFYz6JSr


>> +		}
>>   		end_fsb = imap.br_startoff + imap.br_blockcount;
>>   		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
>>   	}
>>   
>> -	if (imap_needs_alloc(inode, flags, &imap, nimaps))
>> +	needs_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
>> +
>> +	if (flags & IOMAP_ATOMIC) {
>> +		error = -EAGAIN;
>> +		/*
>> +		 * If we allocate less than what is required for the write
>> +		 * then we may end up with multiple mappings, which means that
>> +		 * REQ_ATOMIC-based cannot be used, so avoid this possibility.
>> +		 */
>> +		if (needs_alloc && orig_end_fsb - offset_fsb > 1)
>> +			goto out_unlock;
> 
> I have a quick question here. Based on above check it looks like
> allocation requests on a hole or the 1st time allocation (append writes)
> for a given logical range will always be done using CoW fallback
> mechanism, isn't it? 

Right, but...


> So that means HW based multi-fsblock atomic write
> request will only happen for over writes (non-discontigous extent),
> correct?

For an unwritten pre-allocated extent, we can use the REQ_ATOMIC method.

fallocate (without ZERO RANGE) would give a pre-allocated unwritten 
extent, and a write there would not technically be an overwrite.

> 
> Now, it's not always necessary that if we try to allocate an extent for
> the given range, it results into discontiguous extents. e.g. say, if the
> entire range being written to is a hole or append writes, then it might
> just allocate a single unwritten extent which is valid for doing an
> atomic write using HW/BIOs right?

Right

> And it is valid to write using unwritten extent as long as we don't have
> mixed mappings i.e. the entire range should either be unwritten or
> written for the atomic write to be untorned, correct?
> 

We can't write to discontiguous extents, and a mixed mapping would mean 
discontiguous extents.

And, as mentioned earlier, it is ok to use REQ_ATOMIC method on an 
unwritten extent.

> I am guessing this is kept intentional?
> 
Yes

Thanks,
John



