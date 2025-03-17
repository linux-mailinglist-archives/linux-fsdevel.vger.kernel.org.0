Return-Path: <linux-fsdevel+bounces-44193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37237A64994
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 11:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F3937A6189
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 10:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9C323C8A9;
	Mon, 17 Mar 2025 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QoJ6N3eV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GawspNk2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DCC22257F;
	Mon, 17 Mar 2025 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206761; cv=fail; b=iuO+ma42bMObfb+23M3wUv9qs+Fs3uI+a3sco1swjRnUNcnbc94utNuUv42oU4A+UFlo8bCRPbb9lAG70Ym8280S5D1/Da9K3r9Z1nGg2Kvz5dHaX/5O/GjF3DGfjNvD6F6k7Nh+vwZBibPZRsvNVXbvtHcxRLrx5Cp725pUX/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206761; c=relaxed/simple;
	bh=ZXMk9Q9WFtqQ/s/vxFl5YJ0OLrXHawwxKgWW1AgH1Qo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TwDXGm67tK74VPZfFGdsUSmuxrm6rsr6h+Wse9jbEjZ3WhIb8li/nxCE2qTzKBXCskXnOkIPNGd9Jw2mDf2A9vyzOkAeIKUu6OaNagafIv/SStRYYTRgzDd5ZdzxKbsslvmwIaj7ke/j5UWu6NKb+IfyKDh5kYMRISadNFATKdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QoJ6N3eV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GawspNk2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H7QnEV010983;
	Mon, 17 Mar 2025 10:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qvnnc39rya7ozJRPzByqCpO8nJgCwJwqqszF4s35Ud8=; b=
	QoJ6N3eVJ3ULEou4tzRk2e77BqDvQ/BIY+ETMpB6i8OY3pLwndiyqIQ2KC9vNgV6
	8czeIoRh4gXOc+sRK05axZ8tOT4YhcpXnyZ282coTTaBS+dKLXWR1I1VbhrxyzP2
	KzVaAti8AbdsJuh+/6w6eqyAQip2NrZqbSA/fGCvqlnWgNZlbDiHr+OaTn0zf7wo
	hY1fQ69jIPpc6dXxWIN8Cy+NHhoQPvCtt96/fy1eFSqqiA8fCOePgLouHEemYhSB
	4+qwMlt2FYJgKOwMF7kGPKuF5T46894ZgMjT/Xssi0X7eMpdEq3gbFWbilITEyg+
	njMc9Rr5LntJ1lv6Fkqy/A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d23rtccb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 10:19:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52H8M5S5018502;
	Mon, 17 Mar 2025 10:19:04 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxdhfs7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 10:19:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFbia66MODYbjNrof+Lw8Hpy5y8HvObHXeUlrNY1YzoWQzJcNzJZmbbN8bqUBt2/yR/OF0vz+7H6Oq7jwcGKqqdMp/6bSsRgZyRxIMh+9kC6db5mi6+2r5j5HnHItNpT/8339mb1NIOb9JWcu0dogL8JHRCflbeXrPSXhCN3dP62cEZqbl6ULQV4a5ZdeeIa5+FYo88DxiJYXG7mDNfjTslrsBrMyOl0TApkR/nekg2R6/7l3u6X2+kglSj2onR/FCoVBzUhV39z348KpM2YIoR1FkS3QpJhBYIe1dRH4CtArWcw1e57TYmUeWibQgeDWXv13iVWFdWdBO3o0NBpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvnnc39rya7ozJRPzByqCpO8nJgCwJwqqszF4s35Ud8=;
 b=h4x3jmgHeUygPeF5eg8hpCMum415nNWM889lOZ+XQ4UKSLc3HtChhRBkU+DU1z4Ama+vCwC3b+BjlCNUt20P7R9IVra3sEV1WsqA1jQ96S9ar6I6ytPwrk0QcsQMdZ+p91xIr3lL/c0XBV2ordCaSarhkTeztLqRsFZyevSFnh7fk3cQESwULdTZuGPsArOtsHWHIsSkgk1cba2bvnKE9OpMOWTv/Pbppz6wi+jYvcxTZTqkwWd7I6bICCxiXY3kf/g+NOUuYTC1BPaetQ4XB/GKwdgSyMhMIebYClEzyreqfqB9ZHnCfJfUjS1qaCytGOw3AzI6vz9uYbKtWURg0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvnnc39rya7ozJRPzByqCpO8nJgCwJwqqszF4s35Ud8=;
 b=GawspNk296LGSlmCsspfvk32jpuHwsuSrDv9ti+Oy7zWxdUHZGdNBMgvNauodJSggYKLR9uMz/kRIWL/RfwxKddktMgxsSUl//6V0XMGF7ACYBgXXT9/bxGfjmvr9ZWh9R09J/DqSZ0C9lrDaEVwJ7M7ldnzUifc+Ahgqdg0jpg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV3PR10MB8081.namprd10.prod.outlook.com (2603:10b6:408:286::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 10:19:02 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 10:19:02 +0000
Message-ID: <eb7a6175-5637-4ea6-a08c-14776aa67d8b@oracle.com>
Date: Mon, 17 Mar 2025 10:18:58 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/13] xfs: iomap COW-based atomic write support
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-11-john.g.garry@oracle.com>
 <Z9fOoE3LxcLNcddh@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z9fOoE3LxcLNcddh@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0339.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV3PR10MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: d81334ae-da61-41eb-84c0-08dd653d236b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkVhVFM3Q1BmbmprUmNaZ2xVSzJVdmVBWG1ITmdQSnpWV2psTThHUnhWUWlj?=
 =?utf-8?B?OHovN295Rk8xbWpaTk44UDdNQ3hYcWRrZjVmOGVZZStTS1B1TE9LNFViT3A0?=
 =?utf-8?B?RC9kYU9iWDVGNlRRV0VXb2RoM0RYcjk1cEdGWVVRR2VDaHlOQ2ZBZytISEVs?=
 =?utf-8?B?Si9HUlR5bmxzZzdYdnpiUWsvWVBrNXo2M2NhQllteGRqdytoenRSdXhrb0hy?=
 =?utf-8?B?YXUxYmFDejR1aU9jOCtCNTJaWi9QNEdLM0VmcHcybndGV09HK1BOM0tLM1ZL?=
 =?utf-8?B?SXdWbVV2WG1QYkMwR0xTRXA0L2VOZVB4ditiQjFEQ3BPbnFYWTZSdDlOdCs1?=
 =?utf-8?B?WW1taXFTSlFKLzFFc2F3K01sNStXbE12NkNZVnppL0pHajZKdmdUUTkxcXNv?=
 =?utf-8?B?WFBxTjl6TjU2VUNiZDg5NCtQSUo2YmlZU25OdUZlZlJLWFN5cStwRWNUUmZ1?=
 =?utf-8?B?UWdIQWdsdDZiRGcrdTVxNVJ6UkpsOVNTeTBiK3YzT1B5ZkJDcmU2RkZhVERm?=
 =?utf-8?B?TElITmN0aVQvaGZPS24rZm04OTUwNTk4aTE4OWtQd0NrblJjNDNSRHlRMWNH?=
 =?utf-8?B?QTBIckVUcVlFMFR3cmFhNWdjVld3NHJyMm9SUUZqNmsxYjFMUEdVblNrZDBy?=
 =?utf-8?B?dGMwR1RyWFJTdnFGYmR2T1pyY2xSTGJzc2lMdUhRd2JrZFNXNVdyaGR3c0ZH?=
 =?utf-8?B?Z0pJajlKWHBCVEkxQVltdWFCWDgzM3ZybFJwVHk2SjZzb0RFeUVVanpRVzJP?=
 =?utf-8?B?bW91S2FNd2ZqZHJiaHhNalBURnlibWNoSGNvaDdZOVkzcWYwVHVtOEdKd1J1?=
 =?utf-8?B?M3lHZEpIVVBzb1o3UXNlM1g1cUUvdkFMR3hQbThlWTFCOWhIS0dLQnRTQ2or?=
 =?utf-8?B?dFBGVlpNYjYwRFZOWmlZcjlkeHQ3U3FHQzl2TDBRNzNtVXJVbitVTWJtMnlp?=
 =?utf-8?B?R1YwUjBVWjZBaVBGMUp2ZjJnUHpMVDh0cnBSa2dTaUt1VituQlZKamkzbkFx?=
 =?utf-8?B?T09TQkwwZVlramc0SlVEVkcrM0NFNzZUTEkva3hMS2NiODFYMTU1Tm1VNFQ5?=
 =?utf-8?B?c1RPN3dVcXpOYytRUER0UEFxVDRVL01tSEQwaWN4RWc1czVYTUM4dkRXY0xC?=
 =?utf-8?B?UEZUdm1GQ1k5RVhyekhGMmpacVV3RngrKy9TeGV5Y0hSdXM2Rmk3MkNZVnV1?=
 =?utf-8?B?c0ZnekhKMk9GRHF3WnhNTk9xeE5RTUphWW53SmVRWkt4TXowdnNqdHlxN2dF?=
 =?utf-8?B?cGIwMGdnN3ozWWxZRlJ3YW9RV3FHdkdnUG5sNnIxYW01YkRoQkpCdXhFSVE2?=
 =?utf-8?B?MWc0bHVoVjJvWWhVVFpnQVRxT0lGMkRtdHllaERRZGYyUTVmQU1STFhxYWM4?=
 =?utf-8?B?N0RyOG11enBnLzQwOEoxblhrTzlXWkhYVWRLNktkWHRnRWRoZzFneE9YNStK?=
 =?utf-8?B?aVFmZXBkSmZscFNFZkpwZWJhWmVCVytPUHFRcWlXaDB5R2MxNlY1WlloR2Qv?=
 =?utf-8?B?UExXT3dLQnBCd1kyRjZwcUpkMDZ0SnNiWHRINEZVbmFTRXc3dmhIVnFxNUpw?=
 =?utf-8?B?RnRHakhGSnNNNnpQaHM2c0MrV3UrSk9nb1B4Q0RJNXg2UVQ1UC9oSHNpS3RV?=
 =?utf-8?B?RVRDNmxQbVpNRFJUQ1B6ZHRTT3BvdHVONUhjQW1WQnNwNXZXdFRqSUE2bjNh?=
 =?utf-8?B?RkRYRkpET1Z4VWttWkwxaFJ6aTBocHdoMlBzSG9aZ2JFNTRrbE9rRUZoOUlK?=
 =?utf-8?B?SGNsQUx5WWcxMHpsWGZYcHBtSzB1VG9qVkVjbXYxMlN2SjdJdkExWFgyc2VJ?=
 =?utf-8?B?VWtaK3Z3NGxiUnN2eHNPNHlxZlZ3b0tucmJ2eEJrV1BJRkZFTFRFU28xZ3o1?=
 =?utf-8?Q?6FZHYMJNnaZKZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3ExOUJZQUZ3Zk5GUXBvRXFUZXV6TkRsT1RDc1VBWGRsZUErTGJDQTJDU21a?=
 =?utf-8?B?eWJiWk9Rb0VrdVhLWFQwVkxKa0VrOVFneHZUcUZxMEo1V09GdmhXOUc3U05L?=
 =?utf-8?B?eU1icEUrRGRTcXgxaEp3SlN4WlhsRmhyZDM5dHhLM1l2K0k0byt6cFhVMEYv?=
 =?utf-8?B?dCsxVW50VlVZVzdBR09sMlJ3RExWeEJrUmt4cWh4WkQ2MWJuMkVDY1YyTDJ2?=
 =?utf-8?B?ZHF5TTZZYi9nSWlURTVuRkM4cE05cTFPODdENmlTaG9jZU1hQW94SGxwc1Jm?=
 =?utf-8?B?VjBLYVNTV0hNMEJuTzVhUmZYWnFPWXUzQUlEdTdFdk1oU3BWY3NBTXBSOXpK?=
 =?utf-8?B?anA4QjN5OU5KS1poV2M0ci9iaDJwdmtmWFB1WktaRXZQd0c4T09mLys5eW5B?=
 =?utf-8?B?UzE2RVMvNmJJZm9PeWxhY1VPaStuZHhYNmt3OTlzTCtPQlNBZnZtUkRlZ0hH?=
 =?utf-8?B?d0xWOGxrMVdIaUhDNkZRNllQOGZDdDZyZ2xzZ0J1K1NBT1hheTRuRmx1SURP?=
 =?utf-8?B?Q2N6SHpzTitQY1hBUGFYZVBrMURBUGlTcUtqOW9sUjM2ZVY4SExyL1QwQjlh?=
 =?utf-8?B?VFN6ZEQwSWlXcFJCWGpZZ2NUYVpxZTZYZ1VNQk9ZMHk5WG00K1orc2I4Y3dY?=
 =?utf-8?B?blB0NDkrUG5PeUpiS2ZsTVZ6OGt4bEsydzVoWmFrZy80a01VcXFLbnF4SWxY?=
 =?utf-8?B?aisyeEZFdDBWUWJwR1RJcGVkYTJobmN3MkJnd1lQRjhuaU5sdVRiblZ3c0Vq?=
 =?utf-8?B?VUtLUDFsSll2ZUt6dDRBSXJBcFFSTFp5SDJQZFNNVGdKeWFWZk5nOFJNQms1?=
 =?utf-8?B?eGxNR05QOFlSTWZVdG84alNOMmY2NnNJazc5T1N2eE4xWUJ5VG9zTWdid0Fz?=
 =?utf-8?B?ajdGazdZVnVjMEV6a0YrUzlPYTVnd3J5SWwrdW5odGMwMDFCTTZab2tTYkhw?=
 =?utf-8?B?eG5Obyt2dXlsYXMySEkwUTV4MURucnpWN1ZPcEtuYitybjRrdzlKNXUxOTB4?=
 =?utf-8?B?WmdlTFpzc0lOdzh3Q0hNb0VOd2xETzA4ODhRNzhKbldvZHNyd0VEbWFyeFRj?=
 =?utf-8?B?bzVqd2dkWlh6elhDUjdQT1lMVmlMZXNhVUMvbzMyMy80WFhuM2pBUTVkZzQx?=
 =?utf-8?B?Tlh3MDNRZjdYRGdHMm81OEFCQXRteGY3ZEd3UkdVbWkrZDNpQVBCeEx3N3Rx?=
 =?utf-8?B?aWNEVWIvTjVzZldlTjVySDltSVJpQzZLZ3czTCtZMllabFU5bldYUlhOdkIw?=
 =?utf-8?B?bW5ycmdGM3d5ei8wLytEdTJkRVd1bWFhTGhSdWhVRFBRY3pMYzVlVHRKZ09B?=
 =?utf-8?B?WndzeXRseHl1R0ZTVlYxNjFxQmpGRVN2aXJPMlFocVVDOEcrdzFwQ3NuNWQ4?=
 =?utf-8?B?eERjbktaaU9MSmRjTFR4cWJnZzY0TUVKZnlGVlRMT2VrZWg3Y0FEM2libnU3?=
 =?utf-8?B?RlljTTdnRU1sdElXVldNVTJWdFBVQytxOWI5bERkd21pZGdZeDcvZHY1dk5r?=
 =?utf-8?B?Y2tBWU1VWFZNVVhnOVNDOVBhN0E5aGpvL0hudFQ3S2t2M3ptSE8vblhlL3Fm?=
 =?utf-8?B?ZkNRS3N3a1FaR2FvVXF6bXFJVGJReDRMbklncS9WWUpVbGlWTmhING9RYjcy?=
 =?utf-8?B?WUkwY0U0OE9YdXRrZVNqTjE4QW5seTJGMVVJTFFVbFJXa2dHSWRTU0VkRXBU?=
 =?utf-8?B?dTZKTWZKSXJ2b3BVOWNjRWErd21ZeWhlcGx6dUVON3AwY0JWcllkb1pvWTFx?=
 =?utf-8?B?K3VublcvQnJUQ05IMTZIaExnZVZSbVZ5b241a3JSZ3ZHSEt1VllXK1lwOThz?=
 =?utf-8?B?R1dCVER1SlFrMm1uY1V4TVFPVkF4bDRGT0crWnRLUTFMNlhKQTB2NWZqMy9r?=
 =?utf-8?B?ZjNzTlF3TlpvTCtFWjMyOVh2akZjbEZGREZHTmo0UHpFOE5xRUxETUxlQnBj?=
 =?utf-8?B?bVVoTC9KbEdQVGNRTjFPY1k0Z0RqQnplUE4xMkVFeHRqdU4vdFdvbGVGNnox?=
 =?utf-8?B?b3Z4bG1SbzkxOEVEM0t2L3p2NllrTTNNWGZiZTVrWDNnN2JFRmtNdENaZk9l?=
 =?utf-8?B?bndBWkxWOVNTNy9wck8zc2NmNVF1UEk0czZFakxwa0ZUVXV6a1Z1TEc5L214?=
 =?utf-8?B?VnBXUmhJWnFQVmt1STNYemE2SEloUUg3aWtKYldqTGZ4S2JKWTRTZ1JqalRk?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CwXxx63nnIknwF4Y5qDtdbhWVQzWygwX2zciqYd6ZHC1TUPwcKhhoqy8orOW8GedwezmzKjm4iYkXrYxkMoqTB2Q2dSk3J5uonnNrozNbLFTrD7+fk1RRlGqwTay0MedWLTW5z3YJeT98x7L2RSQg96t+ZwyfvdUmDMImYes5rJt0iOpWpg4BOib3LX6Ssp5owGjafgRqRbjch6NmruKap+rMs7ftgIl/ZRBa5tRVzXr3Xw+ZPHSk2d2LRV5gnqZTtZm4AKpTlCGEe+0qAvvW/cIvXbtYlTvDYCOf8bfBtW577WG1sUYWok3Vd0C8QWZgWQpyTifN7uNFvF1NtFhs3Qh4gEvJuJsN5Uj/X62Xj0/ApTQql75RwaFlGch1BxdTdyrSqbt60ujYwkNhWHQrDvmxyORUcLHYtu9iSy4ofHAKHm1q/yoygYvkoZVbIS2g2cI2+zmJEk7A94reBbmrDWMiex7Ms13i3KJHCoyx9bD8gyM+/dJG6PAcfChaok3/lA40Yb/3p6gPvVgZEdSm3Q+z61PTQ2e3zZcYGtf1YJaEHLE500YkUIoXclmfB8emcfCSpmqYrMZ2soqR2a/HI57w/HovdaxtCiB0o/OqmQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81334ae-da61-41eb-84c0-08dd653d236b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 10:19:02.0197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XY7EtHizIht3V6y3hRy3ctUStF4d1RMP3tRNc/btpPt5R5XJ8pD9AEHAMhTSEKhEBdNHUWv19maWD9USejx1Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_04,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=962 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503170075
X-Proofpoint-GUID: 6v43Q_F9_5SBL88CVGObdtZEiziwq5ZQ
X-Proofpoint-ORIG-GUID: 6v43Q_F9_5SBL88CVGObdtZEiziwq5ZQ

On 17/03/2025 07:26, Christoph Hellwig wrote:
>> +static bool
>> +xfs_bmap_valid_for_atomic_write(
> 
> This is misnamed.  It checks if the hardware offload an be used.

ok, so maybe:

xfs_bmap_atomic_write_hw_possible()?


> 
>> +	/* Misaligned start block wrt size */
>> +	if (!IS_ALIGNED(imap->br_startblock, imap->br_blockcount))
>> +		return false;
> 
> It is very obvious that this checks for a natural alignment of the
> block number.  But it fails to explain why it checks for that.

Fine, so it will be something like "atomic writes are required to be 
naturally aligned for disk blocks, which is a block layer rule to ensure 
that we won't straddle any boundary or violate write alignment requirement".

> 
>> +
>> +	/* Discontiguous extents */
>> +	if (!imap_spans_range(imap, offset_fsb, end_fsb))
> 
> Same here.
> 
>> +		if (shared) {
>> +			/*
>> +			 * Since we got a CoW fork extent mapping, ensure that
>> +			 * the mapping is actually suitable for an
>> +			 * REQ_ATOMIC-based atomic write, i.e. properly aligned
>> +			 * and covers the full range of the write. Otherwise,
>> +			 * we need to use the COW-based atomic write mode.
>> +			 */
>> +			if ((flags & IOMAP_ATOMIC) &&
>> +			    !xfs_bmap_valid_for_atomic_write(&cmap,
> 
> The "Since.." implies there is something special about COW fork mappings.
> But I don't think there is, or am I missing something?

nothing special

> If xfs_bmap_valid_for_atomic_write was properly named and documented
> this comment should probably just go away.

sure

> 
>> +static int
>> +xfs_atomic_write_cow_iomap_begin(
> 
> Should the atomic and cow be together for coherent naming?
> But even if the naming is coherent it isn't really
> self-explanatory, so please add a little top of the function
> comment introducing it.

I can add a comment, but please let me know of any name suggestion

> 
>> +	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
>> +			&nimaps, 0);
>> +	if (error)
>> +		goto out_unlock;
> 
> Why does this need to read the existing data for mapping?  You'll
> overwrite everything through the COW fork anyway.
> 

We next call xfs_reflink_allocate_cow(), which uses the imap as the 
basis to carry the offset and count.

Are you hinting at statically declaring imap, like:

struct xfs_bmbt_irec imap = {
	.br_startoff		= offset_fsb,
	.br_startblock		= HOLESTARTBLOCK, //?
	.br_blockcount		= end_fsb - offset_fsb,
	.br_state		= XFS_EXT_UNWRITTEN,
};

Note I am not sure what problems which could be encountered in such an 
approach.

