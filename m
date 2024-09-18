Return-Path: <linux-fsdevel+bounces-29633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752D897BA9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 12:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD49CB20DB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 10:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7583A17B425;
	Wed, 18 Sep 2024 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aPlo/RCF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PGvYMnUR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B208EF9E4;
	Wed, 18 Sep 2024 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726654387; cv=fail; b=p+jGyUmnNkWwGAz+Fja62O1OrR+4ajtdd3oDbHlhODAc2bQIUjvXwlEWe9MLA3ojMnYjbyR08QKtrhpCUpyC9exa6ACtIvwEDqKuFV2zxL2+sIPgpbeWg2Y/KA8XCbbAioLwzFUjGGbuu0Az8GI/PywVxJBXGXumsUCyP0dUBxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726654387; c=relaxed/simple;
	bh=wxJatCalx+eSPB9yY7b1sGYkSVPeYqAzu9QuQ83KzmM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nk4Vl8ovpibDmLpFv95OanBUbeNxPl4Nkv4B29n8F2sco44vqnusHux3akbR7DSEYoDC4YNGCs/Rat7pViduoCbZTQ5XSTOHOi6ISdu36ic4kjFN/t8nonZrMTsPbZ4OAfTRx+fxm3ofas9r07Iwp5+FxnNBAjNPF7ECsv1Wcgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aPlo/RCF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PGvYMnUR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48I7tXE6031985;
	Wed, 18 Sep 2024 10:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=xKaeWupqAON5rlZu+0qcD8al9zPkMIyAhL7e8GYe/Q4=; b=
	aPlo/RCF82BblhoniyAqmJQSPpWzciWjH8vgUxHf3t/rH+VJGaOTplupQGEpyGMJ
	gH8GwlaPCnT5PpJz6JPeRommm1O5QtgdpjYBPkIQx39xO4Ax8jdXx/HDM6sdNs8s
	s6lX8TcEZqEvabl/SAD5JQIV+7ZU152R45CXR/WQ14KMid3w14Q4Fko64vmJcXh5
	/zrM7DK3fO1HMHuSzYL2mrHpsmB4jIXT+B1DCx/fFaSQl/ACsZMx1QuASomSC3EI
	xrSuz7q4r4xpnlslVdFbOuKZei8+xCwoP3Jo3M5fK+qiSOp5IsF0GwFKpYac9jHV
	ntSDTVIKJpxOCeSqcTLiaA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nfrtm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 10:12:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48I8jVX7014976;
	Wed, 18 Sep 2024 10:12:53 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nyg4cabt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 10:12:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWsjCYpzl1U+FPU9IoM2o5Cr0/aniMitwoL3L1Uy2I+F/8QzCUmLeUe67qUKUtdyFKRsOJPFlZxdKJePaD5mPRvLbhu9ZzKiFjGNl5kUZvUSvFxH+o1pm8Sb2mBD+w9exPC3aR+KwgivXMba0HZJYMJT4nncAgGHAArUfqwBaTBnOMXkO91a2ygW4ByyLOTYN4mJ+Qz41KcvtFj7DapfccPXMkbZlop8JfU9Kx7VpsUhbxHnI43Yty2eFB4Q37TtfI4aegIFV/ioLNnnHMOOJT3xPRi/h957XeH7A9fdENo/Celv/fhIsXjUXNAHyAVGtkoxoM0D/gn2+Ati8QArcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKaeWupqAON5rlZu+0qcD8al9zPkMIyAhL7e8GYe/Q4=;
 b=JHxUlgUgOEOubdV8GpdmcP/6NTtyDb58UCEdHiVA3jm2t9AAW31lYObOHo5Pfb+HE5BGoO+qfSp3eOzfdrTIO6QlNgUCglvicXM+lXu4UDpuMeQBQcoBBJTidq4Uda/92v4BWKmQL1/NMbyLbyUrOib+iZKcPYQdH7Ds/5JSld19H2zRgHGUZtSKsFCNM5iujfBCX/vSJnsDSZ7UE8fki9Jo6iPX6IlvXkNlVBj05mYDPmSOTk3QTXEFZoccGzfIpImxLOMF0DZnQiUD3wM4ltnahociFklFxFMS3gFOL4yR27DU51/5tbwSbThjWkFwar8MH9AF/rxYsJxKPBUV5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKaeWupqAON5rlZu+0qcD8al9zPkMIyAhL7e8GYe/Q4=;
 b=PGvYMnURTahxFR+d7nOBdWF9m3+Bm4a/PaTicHAewTCKGwPcuOxComIWnMgoxS8awO4Z+fIXedXTOmPLotC46gRU9fbk9EMvMT+w+fO+bwBpNXdogrDr+NEVr7/7E16hvaDjeQC1641yBVX4/mQn4IAmap6Npe9qke+3Z04+AG8=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by PH7PR10MB7107.namprd10.prod.outlook.com (2603:10b6:510:27a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.15; Wed, 18 Sep
 2024 10:12:50 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%3]) with mapi id 15.20.8005.006; Wed, 18 Sep 2024
 10:12:50 +0000
Message-ID: <1394ceeb-ce8c-4d0f-aec8-ba93bf1afb90@oracle.com>
Date: Wed, 18 Sep 2024 11:12:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] forcealign for xfs
To: Dave Chinner <david@fromorbit.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, chandan.babu@oracle.com,
        djwong@kernel.org, dchinner@redhat.com, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <87frqf2smy.fsf@gmail.com> <ZtjrUI+oqqABJL2j@dread.disaster.area>
 <79e22c54-04bd-4b89-b20c-3f80a9f84f6b@oracle.com>
 <Ztom6uI0L4uEmDjT@dread.disaster.area>
 <ce87e4fb-ab5f-4218-aeb8-dd60c48c67cb@oracle.com>
 <Zt4qCLL6gBQ1kOFj@dread.disaster.area>
 <84b68068-e159-4e28-bf06-767ea7858d79@oracle.com>
 <ZufBMioqpwjSFul+@dread.disaster.area>
 <0e9dc6f8-df1b-48f3-a9e0-f5f5507d92c1@oracle.com>
 <ZuoCafOAVqSN6AIK@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZuoCafOAVqSN6AIK@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0325.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::14) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|PH7PR10MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: b81490b6-c0a7-4ddd-b271-08dcd7ca73c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzJiOTV1cU1SSlNRRlVPNVQ4SDQyQ2hyUE5RMTZUcktMaTNiRFFtNE5zZ2Fs?=
 =?utf-8?B?OHFtVExqOFl4TmkyNE5OS2ZDaCtUWER2Y1lBbk4rSkVSam1yd2U5M0NBMTMv?=
 =?utf-8?B?NTkvTmIyWG5MeW9qM1pwVGtJUGtWdHU3eVR2c2NKbi9BZXd5TG96Y0pTRCtj?=
 =?utf-8?B?bCt2WUxybXBtNXJ4Z2RUb0tUUzZwQkR2R2ZmZjljUHN1d2RhaWRHM21UekN0?=
 =?utf-8?B?NDNLanZYR0t1TDNmRVB4Z2ZWdlFFbTliSzRPNkZLbjkyTG4yOGErTFRIQkVr?=
 =?utf-8?B?UndTRGZJNWdZWU4yZHVkdkh5eVZUUzJ4Snh5MTJhNVBoZFdReHJkcFZuK3Ir?=
 =?utf-8?B?TWJhcWFESXR5dmZYN0s5VWxpaHpZbDlQTVIzTjlVWmd6Sk1ZNHBCc2Rwdm40?=
 =?utf-8?B?WjducmRRN3JZTCt0ams3N3FVbUVTMk9CVHNVSWdaY3pCeUlTT0tFdGlCQ3Jn?=
 =?utf-8?B?aDlvR25Kd0RPRzU3bFI5aGd6Z0xBWUtTbDY0Rjg1Vld6cDdDWjJrTE1JUDcr?=
 =?utf-8?B?OFBiak5ZcThicFBDQ3FPLzMyc2lIMGgrUk4zcUw3c3Jmb05UaWRDd0c4aHVL?=
 =?utf-8?B?NjREVTZpUVhBNkN0R0J6NVJjTFhQY1VjMFlsSS9XNENMSDk0ZnV6SUsyeE5Q?=
 =?utf-8?B?M2VDOXVTQStnd05hME9XeVBncCsyRkFwODhtUk14UlZtK3FZWUZrc29kaWFG?=
 =?utf-8?B?T1lEa2NGZ3RZYnZLcFBOazNiN3ZOU1ZoaG1pakx6YitUSW1yZStVMzBvLzV0?=
 =?utf-8?B?QXNIOUt6NGRhQ1ZEb1hTUVJSZ1E1QXUvWmFHdlZLTlcxZEc3YWRpZndIQkJE?=
 =?utf-8?B?SDdOWFZEMXh1MVBRM3NNQTNnUkR3QVdhUDRUcEpBMlF4dHZIeG5IUHpkK3R4?=
 =?utf-8?B?ZWplQWowcnYrOVNrNytRM0dWd0dCL0tVaXgwcC9NY2FIWWFDdmZXSVpWdk5Q?=
 =?utf-8?B?WDB1SmlBdE51ZkQzZzAvaHVWdU10U0xYbmRQR2JQWVFqc2xrZDRKMWNBeDFV?=
 =?utf-8?B?VW0zUUJRZElERXp2dXR5RTF1dkYxUE4xOE5WaHVSbzhnTE1VMjlsSEEyMUpU?=
 =?utf-8?B?WmFzN21rQ21MQ1NMVitRVzJabXVnZWxSbU5CaGNoVm5Fek5XN3Q4bFh1QmUx?=
 =?utf-8?B?MkNTV0krbkhTeVhDeXRKSzVCeEM1UE9zSzdlVnhMcHhrNDFjOWIwc00vWVQz?=
 =?utf-8?B?VlNQVVI4dkR0cjEvVG9JUVlra25IUklTM0NhOWl3RUtNVFhMSm5TbElJeFdC?=
 =?utf-8?B?Rmk4ZkJ3WHdsU1JHYnBJN2hXQUtLY2xPMWlOZnRGdFRyZ3I0TUd3a1ZWcUVw?=
 =?utf-8?B?TlVOS1Z1aER4QkNRR2U5UFhvQjc5TUFuUHNMK2pYL0I3eGFRUWJRU0haeGVB?=
 =?utf-8?B?TXVLTHhMemhkZS9oSHA1WVBML1JORHNJR2d2YVN6Z3c3cTU3bUFrdUJsS2sx?=
 =?utf-8?B?Tk5qcHBwcXFOZWlFTUwydXNjRlZBSFFqa0tXZU5ZQ2xRYWxmVlZKMDUzN3JN?=
 =?utf-8?B?d08xbEg2Um91K3M4TTNYR3U1dHVRZFg1UllXMkZkMEZqNjFJdUMvZXJpRDhm?=
 =?utf-8?B?SFRNMUNRK3RMOGR1c1N5UmNLbzdvWEhGWmJNaFE1WkdqNExIZGpBWklTalNV?=
 =?utf-8?B?SnhaYU1FZlBmWUdmK1RFd1VKVjlHUHVGRFN1S2xIMFFBeWZGSDE4cDNLV0Z0?=
 =?utf-8?B?dXBvOHFZbDZlUklrWERxd2FhS1ZvZStkZHR3MWNPakVCYlEyMFVkT1BHV3N1?=
 =?utf-8?B?U1BDa25BSkJDUWt6dUZyM1prUVZCVUpDVmhlOXBtSnhqTi9ldHhLamtOZksr?=
 =?utf-8?B?WEJLU1JMQW0vTVpuYWxCZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzZXMVFOMWsrQ09QdUJYVWFQQ0Y3MWwwZkJ5RmlsQWF1blh1NGV4bmkyM2hR?=
 =?utf-8?B?dHhzTExYUlRmRzRxL3lqV25oQ1p1OWFGeG9lVzloK0trUlNPRXZ5bkVnUlVJ?=
 =?utf-8?B?NzJWR0cwQlV0bWNXN2YwWVhrV3dvV2pDZU9sUGU5VG95VktUaDRpNSt0K2Y3?=
 =?utf-8?B?NERmV0JyeDNZRVNsTmx3eHhJN2VBYk9VTS9VTGZmOEVRYjNDQ1Rvam9naW1a?=
 =?utf-8?B?dlBsR3BHU1BGdC9DUnVJSkVRVkRrUjRvR29CZXd2RGcxMGNxUk0xSmlMWGZz?=
 =?utf-8?B?elRDYk9meXJnZnpvdE5zYWEwZnk2dVUyaGNIbEU1bG9DSG5WTTNtcmh6cW1C?=
 =?utf-8?B?YUJ6YVBlc2c1Q2FFS2RBMkpXc1lSOHlnTElaSW45MkNwcFhHMVM4Zk1OejFD?=
 =?utf-8?B?eFcrMEZ1UFFlMWxGRmpXR3FXN3FzZGEvamRtQjFoVC96dkVCYWV4Q3FhanBj?=
 =?utf-8?B?c2tSaGR1OStWbzFZclp3Ymo4eEEzZHlUOFBGdmNXeDkzVUQ0MXdHaHVNcnhL?=
 =?utf-8?B?UWwrVmYwSzhReU82NDFNS0s2OXJXa2RhRkVXWUR2U3MrVTFCQnF3OUMzbmZx?=
 =?utf-8?B?T2d5WTVDelFFallpU0JyaXVZTEg0ZURQMGxDVTB4V3kwMGdZVTQxTUMwWXcv?=
 =?utf-8?B?cFo5NW10OW04YmlRd2NUYmVIUmxWTkdaM1NwWjdjSHpKVVRoQ0FsckZCYTdh?=
 =?utf-8?B?OEcxR1dzYS93UDRqMi96N3BwUU1zOEcraFdEOGg0TTUvN2VJdmJnaU9kSWhn?=
 =?utf-8?B?blZTQ25yaTRpbWVoT3dZNUIwTFgzL3hVenFsQXFsMitJaWE3QkxKZ3lEVWVO?=
 =?utf-8?B?UUNtWklobzZZbmt4dXBqbzY2MHJxVE5vZzMxVUd3YURyb3V6YjJCL1lqUllx?=
 =?utf-8?B?MDJmYUxGTkVYM2J1Q0hONFg3VmhReVh0V0ZmUWZhSEJUVi9MWXNWdTFsanZH?=
 =?utf-8?B?TlExMS9uTFlTcjZFbWswbTF2cVdoMjRJU3JjK3hNYUZJbDBkRHQwYWpNNG85?=
 =?utf-8?B?M3d3ZXhSdjdDbHZnQ2VuQ21UaVdPNFZ3bUdzZ2ZqMHZWQUE2dHc0Uzk2UThi?=
 =?utf-8?B?MTF1YkpCcG9Ibi8zVnZUUGlLM3VkS1F5NGNHczRmV2s2NUxORndxMUFRelQy?=
 =?utf-8?B?ZjNpaUlIcTBhdWxSRGZPdkRJd3hzT1lxaTN1UkQyNllhOEZ0ak43TENWSm0r?=
 =?utf-8?B?UC91a1YzRXZScjZTd3EvUEVReEI2dXBLOFhwVklaVE9KcS9lZlBGRGxTLzFE?=
 =?utf-8?B?M29FRXBDY3hrRlMrMmkreldTK0JsQUw2aWVNbFU4dlIwd0VHb01CaTg0VFJ1?=
 =?utf-8?B?U1NWWHFGaytaYUlBN1N0V01TRTQ0WlJNRUxRYjFYZTBENGQ1ZWlSVWpjRG83?=
 =?utf-8?B?WmtiSzIwODdicnFPeUJ1amlWUHR3UTF1SDJEN0F4MGFLYmh6cExIS3ZLb3Qy?=
 =?utf-8?B?b085SndGSTJiODF6dUdUNUdIb2hsTk9Jb245MTdxc0huWXZxM1QxNjZoRmlG?=
 =?utf-8?B?NzEyNmx1UDQ5eXdDZEY1NUdFY1BJN0x0YXprNTQvU2txVHJNQTZWMHo5eURp?=
 =?utf-8?B?TGFzNUJBeE9KOG9oTDQyRHgvL09PQkQ5NWJYcFB4RWFUeWRURGdLeGR1SEd4?=
 =?utf-8?B?QXA3eHlORkhhUzZQZDFDeWxoTXhHRWl1QUdtTURrVzlOV0FacmI0QmxiVTJl?=
 =?utf-8?B?dktmbEl6dDZpZlB4eFByNmhTbXlZd3FxeHVIYjZwWmhXdWpYbjJKNDN6L1lj?=
 =?utf-8?B?UGYzSzhRYXJSbFJreVJlSStSZ3BqYXViUkFWY0szUzJKMitsMDUzRVU1ZXVG?=
 =?utf-8?B?VWlqSW1nVDU3NFJkTWZUaE1taXl5WHB5cjkzZWRiM3poNGkyeVZmQ01XSUNC?=
 =?utf-8?B?SzJDbjZzUmEyRDNUbi9NM3VhamZMSGZzcUdoUUovUnU2MXh4dFJwV3N3RFZC?=
 =?utf-8?B?K0dpMUZBQ2ZhNGRqMHRyYnNBRFlZNTBiL2libHJvbDNwVEljVHA4WUZCdktN?=
 =?utf-8?B?MzU0OUxlUWU4eXFYbUhYS0dDaXBpcVhKWFFrZWFIa2h3WGR2b216WUh6MWJp?=
 =?utf-8?B?YkdVWktnUHZaQ09ycEptYW12RTN0MWM5Z2lXcWI2SXlUQ0NkUk80eGJWblMx?=
 =?utf-8?Q?CwkHpLHmsE0KFtLVPY+4caDMv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2BTfO/3WCQWUZ3ppmZ0nC36rf0PBlZU2o5m3lgBoIar0lQnmlS9IgE9+ggPb5KrpYCpFQxMntirhCBviP6Fbpq5sIAKc+nlPewds9Zq0AKng7nRTXzVo2mSoG6QX0CTY3OhfO/iWiFzqaVFiQN/ZprwDwJiwKW4uYyGbZZ7arEmfDPNgDQGPWCDy5hUL+LXiWWi0+4P+B7qtkq/ms1qZKsjobR5PWAkARG1YuZlpaeBCdntJmSiHivC40p4WbF9uc0Y+Mv71v+yVeqm8EQBU92YO87OkdvUtEQ7DjupAx6p57gZZeB9Nv6O8oto+SMbA50aorgNwjUrNsGAzN0xEfpr5aDlzQfVsYLaJ+F7zHme+DJ0Nrb/Nv43Yl70xxXFmI6XAWrB0lB+mQ9Stry5/1nidQVduhXwyAbM4Fn6Bq3dQTLArxuNvuALBK+9A7PiZq6lQbWG9R5GW7ihvS6FsMcgM/t2nnPLvPGVWvU2kPtZhyWYJWI6MS8sgLUEdNBbeVjXoffRbBhl82KfFqz2C7R1thEBUoiiaG4j2Yu+AMsmIWBWH4UXCcX686ifLb86oG0TKDW9oHGsBctDKO9p1C0QyjAUfPcKWSs2Rc+mxR7Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81490b6-c0a7-4ddd-b271-08dcd7ca73c6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 10:12:50.7645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZNJUR0PEEW14n3P22/CeYNw7LMEo5uyH73t7ONG162NNUyRal4rtgoUMoiFpgoGNc09t6JZ7DRDlA1J5L0tuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_07,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409180060
X-Proofpoint-GUID: kF6r0GyP0OgmRHMpieiy7rw2UC1QmHGe
X-Proofpoint-ORIG-GUID: kF6r0GyP0OgmRHMpieiy7rw2UC1QmHGe

On 17/09/2024 23:27, Dave Chinner wrote:
>> # xfs_bmap -vvp  mnt/file
>> mnt/file:
>> EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
>>    0: [0..15]:         384..399          0 (384..399)          16 010000
>>    1: [16..31]:        400..415          0 (400..415)          16 000000
>>    2: [32..127]:       416..511          0 (416..511)          96 010000
>>    3: [128..255]:      256..383          0 (256..383)         128 000000
>> FLAG Values:
>>     0010000 Unwritten preallocated extent
>>
>> Here we have unaligned extents wrt extsize.
>>
>> The sub-alloc unit zeroing would solve that - is that what you would still
>> advocate (to solve that issue)?
> Yes, I thought that was already implemented for force-align with the
> DIO code via the extsize zero-around changes in the iomap code. Why
> isn't that zero-around code ensuring the correct extent layout here?

I just have not included the extsize zero-around changes here. They were 
just grouped with the atomic writes support, as they were added 
specifically for the atomic writes support. Indeed - to me at least - it 
is strange that the DIO code changes are required for XFS forcealign 
implementation. And, even if we use extsize zero-around changes for DIO 
path, what about buffered IO?

BTW, I still have concern with this extsize zero-around change which I 
was making:

xfs_iomap_write_unwritten()
{
	unsigned int rounding;

	/* when converting anything unwritten, we must be spanning an 	alloc 
unit, so round up/down */
	if (rounding > 1) {
		offset_fsb = rounddown(rounding);
		count_fsb = roundup(rounding);
	}

	...
	do {
		xfs_bmapi_write();
		...
		xfs_trans_commit();
	} while ();
}

As mentioned elsewhere, it's a bit of a bodge (to do this rounding).

> 
>>> FWIW, I also understand things are different if we are doing 128kB
>>> atomic writes on 16kB force aligned files. However, in this
>>> situation we are treating the 128kB atomic IO as eight individual
>>> 16kB atomic IOs that are physically contiguous.
>> Yes, if 16kB force aligned, userspace can only issue 16KB atomic writes.
> Right, but the eventual goal (given the statx parameters) is to be
> able to do 8x16kB sequential atomic writes as a single 128kB IO, yes?

No, if atomic write unit max is 16KB, then userspace can only issue a 
single 16KB atomic write.

However, some things to consider:
a. the block layer may merge those 16KB atomic writes
b. userspace may also merge 16KB atomic writes and issue a larger atomic 
write (if atomic write unit max is > 16KB)

I had been wondering if there is any value in a lib for helping with b.

> 
>>>>> Again, this is different to the traditional RT file behaviour - it
>>>>> can use unwritten extents for sub-alloc-unit alignment unmaps
>>>>> because the RT device can align file offset to any physical offset,
>>>>> and issue unaligned sector sized IO without any restrictions. Forced
>>>>> alignment does not have this freedom, and when we extend forced
>>>>> alignment to RT files, it will not have the freedom to use
>>>>> unwritten extents for sub-alloc-unit unmapping, either.
>>>>>
>>>> So how do you think that we should actually implement
>>>> xfs_itruncate_extents_flags() properly for forcealign? Would it simply be
>>>> like:
>>>>
>>>> --- a/fs/xfs/xfs_inode.c
>>>> +++ b/fs/xfs/xfs_inode.c
>>>> @@ -1050,7 +1050,7 @@ xfs_itruncate_extents_flags(
>>>>                   WARN_ON_ONCE(first_unmap_block > XFS_MAX_FILEOFF);
>>>>                   return 0;
>>>>           }
>>>> +	if (xfs_inode_has_forcealign(ip))
>>>> +	       first_unmap_block = xfs_inode_roundup_alloc_unit(ip,
>>>> first_unmap_block);
>>>>           error = xfs_bunmapi_range(&tp, ip, flags, first_unmap_block,
>>> Yes, it would be something like that, except it would have to be
>>> done before first_unmap_block is verified.
>>>
>> ok, and are you still of the opinion that this does not apply to rtvol?
> The rtvol is*not* force-aligned. It -may- have some aligned
> allocation requirements that are similar (i.e. sb_rextsize > 1 fsb)
> but it does*not* force-align extents, written or unwritten.
> 
> The moment we add force-align support to RT files (as is the plan),
> then the force-aligned inodes on the rtvol will need to behave as
> force aligned inodes, not "rtvol" inodes.

ok, fine

Thanks,
John



