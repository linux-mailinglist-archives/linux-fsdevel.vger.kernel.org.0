Return-Path: <linux-fsdevel+bounces-75789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD6BBFxVemnk5AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 19:28:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E66A7C1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 19:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C34E730160CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 18:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F276371069;
	Wed, 28 Jan 2026 18:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BbY4YNlR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hUyU90Dc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5AA2C1586;
	Wed, 28 Jan 2026 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769624916; cv=fail; b=qN1eC1t/BfEjBmjbPTD/eiU3qm8/koRptlBCE9koOwhNcovzwQpxq7Otsz7l8I95D3KpS6MCnMwxMbzJ6IjE+pCqww4qwIzjwZF85bRy3VW+brz70u25IiU3zc+dE/ur7+iDE4O5sGnDVlNkZ9C6zTvgopIEaGfIpbMEm47nKCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769624916; c=relaxed/simple;
	bh=RsklJyNACAFfiUMN7LyRM0L/H8DxXCnZeExx6THWqOo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oTX/Q7NiQSnAEXz7pEAYjzKcCKrLxvGs0bzuLQXWkadNVpYMQrx7toBu2onrTANlVmHv2Aa1gv1Udcb+WbBRa1L5ZcaUJ8O4QkOPQvXQ9kZDqwONJRbjeFKfNNogpqosT1EoOyofjwo2Bl505lpCwTMSeu2NHzHbamfKUopyKZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BbY4YNlR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hUyU90Dc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SGll4F1562539;
	Wed, 28 Jan 2026 18:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SmcIzINZDGf3ksssrktHp4md+7rS/ByEIkMEY+u3QaQ=; b=
	BbY4YNlRguYZ79tKXptYuPPx+kZZiUQNierEgEiQptpauLsQmFgmQ/f49x3Olllz
	5W9/Z9bjc/0nIllcIh1UhYgaN+SLbKV/Uyj2wsYJTpv+ArTVr6igYqNy4mjn7tOc
	SlhiBEw6FHW/vRL1G0IgO8oggSxVfbzOk37o2Xk+nIbDuEe2m9Co9PGaBMKSH511
	es7a4RsGPTsLJUD+O+/PVeNCg5H/cHO5FidusN0zmAwHkh0baKJdr7v6m2silNL2
	Pw5xtvdjF3IojjqTW/6lj7mxtjU+j/AQZuTehS2Iro45KdPbn+H6gtW16lJ3jjhB
	1bl8DHxHKLXM6DCxNq6kdQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by2vghx65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 18:28:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60SHjaBx034800;
	Wed, 28 Jan 2026 18:28:20 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010051.outbound.protection.outlook.com [40.93.198.51])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhb8xf7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 18:28:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYSemeTNLd7GGiApNKVmSUtdH0x43/G9LEh+fJSPfwNygEEiJ7cJmJxLASi+p0dTQXlU/1A75db6Fzolzk1ipbKCrCVRrQQ3YtcHE+AIiTHbaC0L7crJGY0VKUPT8T9pdyVn70P67fY4z2CnrDgHbSUYYzO8YZASGSA7oaDivj+WHrevJMewblhOmCIC3bPDXqzAYUEL4W6f17MnD9qe6ADKHL5XJmpWdv+ceYUeKQHcnv9Ny2Eq7xGn9g5SHN6DjjVt0YBgc1/SDsxLFKSk2oy7axYRtdJA1AjZBXBsXewazHDJdiQgJYAgMkjBGlRpGxi/buG4EskTLG0nMg6Ayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmcIzINZDGf3ksssrktHp4md+7rS/ByEIkMEY+u3QaQ=;
 b=VxhZbs/v98bXzFtQhtyexqvLLvsQSlB6nsQ5JIkxZRfce5CYWYePpnPIVajArNqidqyQ1t81Uku2wUBNy6X7DMDbQTaUGLJxiFG9MG2Xx5UQf8xnrR0iDIbd6rQ7Uqo7zjvmNbVJAswG4IpRXfrUGXJC4FNs6TfKndp2mQt3Y2MX3TcBDPPJ6oLklMlscEisTylWsqjYQOaPcql43eNoM3ZWWQX/SzHMqmTtbl85tMypKKXhm6XeTSPVMbafjeDjjctHb6lOF2Jz8EQApscqOJv8EObIOeaNMHXqE0tMPtQ/lu4R0QUYM1GrwdOuD+ciDcRjofxZ0Ik2S9XBTRZgfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmcIzINZDGf3ksssrktHp4md+7rS/ByEIkMEY+u3QaQ=;
 b=hUyU90DcXZ4aLK+XjLy3MKqoeFlKPR4UyUm23KsSD6PiINthwsqWq7V2F0QC8YRwt+QW8pmOqpowp5xEZmezUKthpEQlTSBjGNk2D+yY+WLcOrWfKm7UPHAaLcjwAc2roOVKe+SS2rkDdSDfd4qa1IzHwoZU7T5McwomviYSY3w=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by PH7PR10MB6377.namprd10.prod.outlook.com (2603:10b6:510:1a7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 18:28:01 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 18:28:01 +0000
Message-ID: <267c6448-20b6-46f4-b287-833bbbff8479@oracle.com>
Date: Wed, 28 Jan 2026 10:27:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] NFSD: Enforce Timeout on Layout Recall and
 Integrate Lease Manager Fencing
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260127005013.552805-1-dai.ngo@oracle.com>
 <5d2288d77498582f78152bdb411222930a7e5978.camel@kernel.org>
 <c566182b-2256-45a0-844e-a7c8614ec895@oracle.com>
 <ac6601d20f1f48db9eca7ba204be8030fc16a1d0.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <ac6601d20f1f48db9eca7ba204be8030fc16a1d0.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0165.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::14) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|PH7PR10MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: fc65559b-b5b9-4ccb-5053-08de5e9af7ef
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bEtTY0dxMFU0RDF5bmtrNnZ1SXl6SzMwc0J1dmVhd1BNcmNQUXc4OFV5dnVo?=
 =?utf-8?B?bFhwcVdxTHZSZlJaWmpTaUloQzFPUnltSXR5cGE3enl0REVWSDdnV2oxVE1I?=
 =?utf-8?B?ZjEybXE2R1ZSdUQ5NDlsU05pSkRzK1JxVGZaQkZVdGR4a3RGTXBlWlZTdGFk?=
 =?utf-8?B?aXUwYWxjT2VSYk0rMkdYbjIwSGlyUlRmajg5VzMxdS8vVVpDYmZtYUNYTVNL?=
 =?utf-8?B?R2NaUEsrdG9sSUdXMEVuc1Vxb3N4ZHBEOWhvcXU5TWtYN1UyeXpBR0pDeUJE?=
 =?utf-8?B?QWJtbHNud2RKczJxQ3BScDNYU25mV1hlTnAzTEV3RlpyZ0c1S01FOUNZeWM0?=
 =?utf-8?B?TlBMcDg4a2NUZVgvQWhqVjVWL0MrSVBVMTFveERZdzRiNUoyV0NoNk9SN0ll?=
 =?utf-8?B?a256Nis2c1ZXVVNVR3ZvbUJ6dFE1elBlUVAyMHFndmFoTzRJamNoYUhuVExR?=
 =?utf-8?B?Ylhzc3ZaczJBMVMxTDhBS3JPd2tMRmRSM2M4ak5hZENHVGRWNU1Ma0FOWlpD?=
 =?utf-8?B?R1BWMnExUk95eFI3Smx2NEJWWG8wQkhELzBmcXpPNFU2bjBHMEpycTRUM0Zh?=
 =?utf-8?B?b1dKTk5RdHlpR3FtVHRpeXR5aGVxd2F0a2Y0RFN6Y1BTM3dSa2xyMUFKRVZ3?=
 =?utf-8?B?UUROQWRJNEM3M29WMDcrNUhpMy8vNFVOQWh2S1B1aVBsK1lCWnVSdERBZ0FW?=
 =?utf-8?B?MTBWRVJpYmF0azl6dVl3V3hIczQ5WkVoZGdUbEJUZzlqd3pHeGxNbisvQU9w?=
 =?utf-8?B?MjVQaW5KVGRGVi9PbkVHS2hUcDRFSXZVaXpERkdhRUlvTHZQUmNhMnNQT1lP?=
 =?utf-8?B?VjF6VDJnTE4zRkhXZlZGR1MvRWJOVFRFRmhOUUt1Q1BvR1dqOTZ2R2U3LzNN?=
 =?utf-8?B?Z1lsd2xGUnZ3NmtOcUlsZTJVRm5TclJYMVREQk51c25EM3BxV2MyeU94ckdK?=
 =?utf-8?B?NmIwK3BjY016dk80ZnU0Z0NoOXU2UVZDNC9TckcxKys0UDRLZUp1cnJwYjVj?=
 =?utf-8?B?Z1hKbUZHbUJlTnR3ZDdFN1Q3dy9nOUsya2FFTmdKQmhDNWNYd2ZKcUZnWjZL?=
 =?utf-8?B?NGhHSmRhRDY1NDNCOHYycktseXh6QnNxQ3ZkNUNESWJJdEdUWEUvMW5YcmxJ?=
 =?utf-8?B?SDVodjJrK3R0cVhlbkg1cHJDVUhtWDZWTlhESWtHZHd6dDVJUzJOazd4enMv?=
 =?utf-8?B?L0w2UnhvY1dQRTVqc2lqRllNNHJubGRrRi9EYjczeUhMSzYvK3FlaTV1dXhY?=
 =?utf-8?B?cmNSaEk2bWhmN3c0RHByaE9BaDVwQ3AyUU1KSTRHQUlmckU1dXZNZTBRS01z?=
 =?utf-8?B?aS9tQzJaRW1NUGFIT2RvRE9uUkwxbHZmbENPTGZDS2pObXRDVGcvY2Qycld4?=
 =?utf-8?B?MW9OS282ekx5ZitSQ0FnaGtoYkdBWE9Icm9lUm03cCswbVl0MTIrQUtHWDB2?=
 =?utf-8?B?SFo0dEluZ1FVMmFDSko3OVJRN2ZTcTBuQjBsWk1RN0JaWG1Cc3lHK3d2RXcz?=
 =?utf-8?B?SFZyTWhnYU9sR0d4S3MxQzdOTXlUTm81SVJid2h6NXRYTzMvdXJuQ2xFK25Q?=
 =?utf-8?B?RWRmckw5Rmx3VlgrOWp3elJkSVlBNmx5UDdMVmFHNGlSc3lqbkt3QW90MitF?=
 =?utf-8?B?TzVuOURFS3FhZk8yVXh4N3JMaGdYdGp4ZlU1QjBveThzNHNycFNaYUQzTVFI?=
 =?utf-8?B?eHNMQm01RFpqb1pVS2VUNkZ5c3hlaXo1Y2VlMjZuTmdnTmVyaHZwWXpsVEp3?=
 =?utf-8?B?V0JpYVdYOEl5YnNTQW9rTm1nVFJrbysrcU5VYnQ3eTJwN3pOdENTTDY2L3hV?=
 =?utf-8?B?TWM0T1p1ZklmNG1iUmRnenNwOXFlU3V4SGNPbmNLeTdqV1R2bkR0a1VYaUg4?=
 =?utf-8?B?cjlDbm1qSGZ1Q052SnIwYldwV0lqbnlsNCtUdEcvd3g0M2JLWG9nMU44blY0?=
 =?utf-8?B?bVZPODE2M1k5MXpvMDA1bHdDd0xJZTBRc0drK1JRb0Vma2tudWNuenhpUGxz?=
 =?utf-8?B?dTYwMEF4cWdST3Y2UGJ1ZUNnVEsrSkptZkMwN1h2VTRNaWNSRFRTOGo0QkZZ?=
 =?utf-8?B?NGtOeW5KTTdncm5yMnpRNDJWdWU1VHo3c0h6WE1qVWhvb01lQm1JdGFJV1pk?=
 =?utf-8?B?RmxzTkZtU2Vuc2RDMS9Wa1gvcFdlZVRXWitQSVlaa0JIbElwcXh0c05sOC9Z?=
 =?utf-8?B?dkE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QnFibndDeHprZkJVcUxNa2MvM3d6UHp0dnVvREpmYWMvTVRmb3NPSE91UE1H?=
 =?utf-8?B?YmdTeTdJZmd2REpZZzdWZldRbWNyQ1lUNjliTzg1OFBhWnVqTVpLampaTzJm?=
 =?utf-8?B?Y29YSmVqZDY1UHN5YXJrdGZYdmhFVnR1ZG5sTnR6VmlqQzc3QnV4Z0N2b1FO?=
 =?utf-8?B?NEphSmFCK1JyZGFCUGllNVRzVlJVVVFWZU5XcnBhZms2d1NnczA1MmNqOFhR?=
 =?utf-8?B?Sm9DMjBINkQ1K0ZzR1pVdGJPTFhjU2ZHK1ljL2dXbEx6aG1kaW50TThZVlJB?=
 =?utf-8?B?UHE4bHBXQ2VKeE9KR1Y1TExVUjMzOUZLOUFLVFhnN1M2NHFHa1R0TmNJNk1L?=
 =?utf-8?B?aWl4TTVRMFZ3Z21zaVlUV0dVb01PVW5ES0h5dVk0SG9wYUh4VEwrU2tQN2Jo?=
 =?utf-8?B?K0NuTEhCYlNBV083Vkt2Q3FXbVMrdStINzhPallSQUZ0amtZS2NrQ1NJemdn?=
 =?utf-8?B?NUt0Z1Uvbm1YZlRDaWdWVnI5ajFhdmFHdjNIZFA1SGpSZ3N4cG5aaXNtcThB?=
 =?utf-8?B?RklOSmNwcG5ZZjRQUHBwMTdYd1ZhWDE1R0sxTmJDNDlwVml3K2FuajVlc2tU?=
 =?utf-8?B?UU96WGVways0YnN4dmFub3hPVXZScCtJKytZN1Q5MTRZeW53TmxkZll1TWJ6?=
 =?utf-8?B?aVBKazNHeFVYbXk3enZ5ZmNBdnM3VGZucGtqMEdadzdBTDZsdlBIbUgzOFBP?=
 =?utf-8?B?OHFSUVNjMHhyT2lwdVFRclI2TGtQdHV6dkpUUkppMnVuU0M4N1piQzBXNHNW?=
 =?utf-8?B?REJLNmYwa2NVOG9ZYVV6TmI2ODJxbW04NTZOWmVtTi9zRUFFdTNPZmF1aVJ3?=
 =?utf-8?B?dHZnNXQxMlJHQ0FZRDVmeGZrZm5wVytyS0FybnkvZjQ3TXJ6MjZ5SkpFbjdj?=
 =?utf-8?B?VlNVbmFQam1wZElGTkJ0K3dqU0hXWk16N0VBOVQ0NmZCc1NJM1hlWDcxR3lE?=
 =?utf-8?B?Y2hwODd0OFlCZWE0Y1dHRmVkbjNlemNQeVVpNWZtUWtRa1c3WmlDbjhkWmJ3?=
 =?utf-8?B?TnJVQXdYOWtNcTIrWHBEQ0ZKZ0xUdEJKWXN4Nnc1ZjEvbmxFdXBndmJJdTNH?=
 =?utf-8?B?d3YwZXorQTdJRnRqS1kxaE1kZDNKUVpVWmxFYWhvRWV6NGJCckE5RUkrTU5t?=
 =?utf-8?B?MUdpaFJ6cDVrdWExZGZFeHVtT28vZEZrSVBqajRoSS9oK3RxRE9JSm5UdzdI?=
 =?utf-8?B?ajZZZXB2UUJHVjRsRzJONUc3LzZaNnVjTFRMcTc0bEhKeWpGNDA3L2NzL0Fm?=
 =?utf-8?B?TFgreHhHcUpWMkt0VlRMUlRQc00wWUxPZ0VBR1kremFmUHJnTDljRy90KzBV?=
 =?utf-8?B?eWpOYTVwS3lsUWh6MVlWeHBuRkpscHRIUkZIc3Y4dysxakZaYTBvY1Y2bTR3?=
 =?utf-8?B?cGZ5V1hBdnRqeXhXcVhERG5BU0RVWTQwZlM4MXloN3FXaThQKzR0Mm1scnNM?=
 =?utf-8?B?elVCeEhkOUcydldTRi90WEJXSVF2TFg5eHdjYjNwOC9qUDA0dlRGeUdRQ0hW?=
 =?utf-8?B?K0dvRFg0bWtQOXlySVRWVitWcUh2RkVXRkg4bmFjcDhtU1FoOXdvYU85VW4z?=
 =?utf-8?B?dmtHdm9lMTRkY0UzT1EvbTFncGwyWjJhZVFRcEFUOHpKZTNYcDZzdG1ycW56?=
 =?utf-8?B?RUtudHBxaUhQOUFrLzZCRk1LMXYzSk0ya3FQNE4rb2oyZm5lc1JWeTFYcTdL?=
 =?utf-8?B?Wmo2UGJvVmlmK0UvSnNDTHlFeTdWSjFFbjB1V2RGL0xCY0VrNHlqb1BHakVP?=
 =?utf-8?B?cGlySlcvc2VhWUdpSkxXRzZPRUVqV1JBb1h2L00xOUVsaE5kS2oycGlLcVQ2?=
 =?utf-8?B?ZlpxZ0wzSGRUZ1V1S2VnYkhMbVZENmMzY3lxbWJMWWJMRDJ1SXArTzF5c21K?=
 =?utf-8?B?bGEyaVpqcEtZUUZ5SmNRaTFTbjBzcXJ0ZGJjbUNWa0hzVjhISWpHRjJLeE9Q?=
 =?utf-8?B?S0laL2IzcGxIVldkdElLZzJicTc0Vkp5RHQzdnpoVzNTODVrMWdaT1I5WlVE?=
 =?utf-8?B?RWpzUmM4V3FQWnl0L1g0SlRRSUh1aXlCekRIdG5jaHhLN2hHSUQ0VjdsYXpW?=
 =?utf-8?B?d1BZVnFRMTZPdXhrOUQyVnpMZlZjbjJ2Zk9LZEhkKzQ1NjlHNUtYMWo2RU9Y?=
 =?utf-8?B?a2FkaEI0TGFyLzYwNmhGdmo4blo0MGtFOTBreGkzVXJsd3U0eWE4L2ZzaU9v?=
 =?utf-8?B?V3NkRUQ5OStIS2hsc0dYazlEVXZ4UFo0TUpid2I0aklHL1J2WEhRS0Rad3FS?=
 =?utf-8?B?Q3ExSFdQYjVLcGhHUkt4RWxtU0FiQ3cvZ1J2SnpQdzV3M29HZ20yT1ZwYkhY?=
 =?utf-8?B?dENkenlQcW9RZHNNamZlV2Z4bFZWbnlkZCt4R25DMm9BMi9pdFdadz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f3vtUB40a/fXNaSuEcfZAABQ8zSqbGFB9WbTxhxvSlSOuerhQlvX2ZsaAS6OxU1uOv2wgou8fyitpHHliopKXdiRcazVs4/pBFIl/5nTNXzHSk8t9aQ4CN450Yr7SW5bDepUx8ytTWk+OL4vcvi4e2UCA+bytK7b3XTOYN77by7LdjAtm6r6qBTotXP2S12HVNkvytOEIOV+sB8ow9FLOWvnm0RRFiH0/AkuUiaCb3r+srj8CgV89qpECi3FSwoBdgzK01c7JnvPaMNyp+mEwxrgSl6OIttIxgyx9nRTtF3d8EzUY2nnxwxClUa+SKBazwOBMwwbE/te8y6Pt2dTJfIwAjGSJrwH2vLz3Bx1durMuIV1jPCZOU25D0HMhZJvwY7o7EDnQ5nGwntvrTg+E6jAJrs0ZjoH5DdHf4rqGyDFnR7g0IrSkpW6EbYVsHgsKgVYJXB9K5qvUGHncQGeUtcCwj3jfSM0JN6SA9CuE9Pe/swNkcigCMlXkfzkkZI/whawqFVOpRDUupAMeEvI+gCsX9lM9IltJFI+tPMXHJiSpFjxgRyRcD+5lu/wD/kxue+mM2blohZVTvhbCFhBjau0y8SrO40blpn8HGNTMGk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc65559b-b5b9-4ccb-5053-08de5e9af7ef
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 18:28:01.3274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbRA9SV0zCItjacbR+vEy+0alepwqVEQ1id9XjJCNqFGR5hhKsuoZaqENeqX2ONERJdPvBTTckWuO6kelMEdgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_04,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601280152
X-Proofpoint-GUID: PzRQrgsTkE7WM64PO1kbKqaBxfyRX1W0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE1MiBTYWx0ZWRfX+VfbalPzRl+Y
 UMu8NGt/i0Us+/NL33AiqJvOl3mYXUaXO73j5HPcizwlrAbHmTrrm2S353m6NFIceJqALWqLaDr
 +PtirV+wqe3eQYihAnEx4gX8TaKDIBmZn2+nMebiUlwyn7It6PwUl4pGOas7JK4JrR+OvzvlrIh
 PZqwrTH24RWHd0eQppLuMLCgGl4oNrVehgID1VlndmKsN3tXGFfkyzEPcVC2Yx/PBpfOjBRN6RG
 OeGTN1bzpP4CYFBAxHn2QZF/adK35qNp+AcbwYPmeDYnEJHry4HiMwa2AXubLuQeoJOmXSTjqmV
 S0FhQNyEWPqJGWtK602iTzguWVsBraX+PnNiZVeYpL3OlSFoShnofnZkewGrux3HJZWbMUvh76X
 5a6Xt0hrG9//YWta1SQIXdBmP/DZivo//fsHVlitLczs3bov2GJiy25odWBKe7WTL3VftgfSlRk
 uHsJiV6tG7nf12Z9IYw==
X-Proofpoint-ORIG-GUID: PzRQrgsTkE7WM64PO1kbKqaBxfyRX1W0
X-Authority-Analysis: v=2.4 cv=a7s9NESF c=1 sm=1 tr=0 ts=697a5545 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=bT8oth9F-bxFjDFTkGsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75789-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 78E66A7C1C
X-Rspamd-Action: no action


On 1/28/26 10:01 AM, Jeff Layton wrote:
> On Wed, 2026-01-28 at 09:25 -0800, Dai Ngo wrote:
>> On 1/27/26 9:54 AM, Jeff Layton wrote:
>>> On Mon, 2026-01-26 at 16:50 -0800, Dai Ngo wrote:
>>>> When a layout conflict triggers a recall, enforcing a timeout is
>>>> necessary to prevent excessive nfsd threads from being blocked in
>>>> __break_lease ensuring the server continues servicing incoming
>>>> requests efficiently.
>>>>
>>>> This patch introduces a new function to lease_manager_operations:
>>>>
>>>> lm_breaker_timedout: Invoked when a lease recall times out and is
>>>> about to be disposed of. This function enables the lease manager
>>>> to inform the caller whether the file_lease should remain on the
>>>> flc_list or be disposed of.
>>>>
>>>> For the NFSD lease manager, this function now handles layout recall
>>>> timeouts. If the layout type supports fencing and the client has not
>>>> been fenced, a fence operation is triggered to prevent the client
>>>> from accessing the block device.
>>>>
>>>> While the fencing operation is in progress, the conflicting file_lease
>>>> remains on the flc_list until fencing is complete. This guarantees
>>>> that no other clients can access the file, and the client with
>>>> exclusive access is properly blocked before disposal.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    Documentation/filesystems/locking.rst |  2 +
>>>>    fs/locks.c                            | 10 +++-
>>>>    fs/nfsd/blocklayout.c                 | 38 ++++++-------
>>>>    fs/nfsd/nfs4layouts.c                 | 79 +++++++++++++++++++++++++--
>>>>    fs/nfsd/nfs4state.c                   |  1 +
>>>>    fs/nfsd/state.h                       |  6 ++
>>>>    include/linux/filelock.h              |  1 +
>>>>    7 files changed, 110 insertions(+), 27 deletions(-)
>>>>
>>>> v2:
>>>>       . Update Subject line to include fencing operation.
>>>>       . Allow conflicting lease to remain on flc_list until fencing
>>>>         is complete.
>>>>       . Use system worker to perform fencing operation asynchronously.
>>>>       . Use nfs4_stid.sc_count to ensure layout stateid remains
>>>>         valid before starting the fencing operation, nfs4_stid.sc_count
>>>>         is released after fencing operation is complete.
>>>>       . Rework nfsd4_scsi_fence_client to:
>>>>            . wait until fencing to complete before exiting.
>>>>            . wait until fencing in progress to complete before
>>>>              checking the NFSD_MDS_PR_FENCED flag.
>>>>       . Remove lm_need_to_retry from lease_manager_operations.
>>>> v3:
>>>>       . correct locking requirement in locking.rst.
>>>>       . add max retry count to fencing operation.
>>>>       . add missing nfs4_put_stid in nfsd4_layout_fence_worker.
>>>>       . remove special-casing of FL_LAYOUT in lease_modify.
>>>>       . remove lease_want_dispose.
>>>>       . move lm_breaker_timedout call to time_out_leases.
>>>> v4:
>>>>       . only increment ls_fence_retry_cnt after successfully
>>>>         schedule new work in nfsd4_layout_lm_breaker_timedout.
>>>>
>>>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>>>> index 04c7691e50e0..a339491f02e4 100644
>>>> --- a/Documentation/filesystems/locking.rst
>>>> +++ b/Documentation/filesystems/locking.rst
>>>> @@ -403,6 +403,7 @@ prototypes::
>>>>    	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>>>            bool (*lm_lock_expirable)(struct file_lock *);
>>>>            void (*lm_expire_lock)(void);
>>>> +        void (*lm_breaker_timedout)(struct file_lease *);
>>>>    
>>>>    locking rules:
>>>>    
>>>> @@ -417,6 +418,7 @@ lm_breaker_owns_lease:	yes     	no			no
>>>>    lm_lock_expirable	yes		no			no
>>>>    lm_expire_lock		no		no			yes
>>>>    lm_open_conflict	yes		no			no
>>>> +lm_breaker_timedout     yes             no                      no
>>>>    ======================	=============	=================	=========
>>>>    
>>>>    buffer_head
>>>> diff --git a/fs/locks.c b/fs/locks.c
>>>> index 46f229f740c8..1b63aa704598 100644
>>>> --- a/fs/locks.c
>>>> +++ b/fs/locks.c
>>>> @@ -1524,6 +1524,7 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>>>>    {
>>>>    	struct file_lock_context *ctx = inode->i_flctx;
>>>>    	struct file_lease *fl, *tmp;
>>>> +	bool remove = true;
>>>>    
>>>>    	lockdep_assert_held(&ctx->flc_lock);
>>>>    
>>>> @@ -1531,8 +1532,13 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>>>>    		trace_time_out_leases(inode, fl);
>>>>    		if (past_time(fl->fl_downgrade_time))
>>>>    			lease_modify(fl, F_RDLCK, dispose);
>>>> -		if (past_time(fl->fl_break_time))
>>>> -			lease_modify(fl, F_UNLCK, dispose);
>>>> +
>>>> +		if (past_time(fl->fl_break_time)) {
>>>> +			if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout)
>>>> +				remove = fl->fl_lmops->lm_breaker_timedout(fl);
>>>> +			if (remove)
>>>> +				lease_modify(fl, F_UNLCK, dispose);
>>> I'd not bother with the return code to lm_breaker_timedout.
>>>
>>> Make it void return and have it call lease_modify itself before
>>> returning in the cases where you have it returning true. If the
>>> operation isn't defined then just do the lease_modify here like we
>>> always have.
>> The first call to lm_breaker_timedout schedules the fence worker so
>> fencing is not done yet. If lm_breaker_timedout return to time_out_leases
>> without any return value then lease_modify is called to remove the lease.
>>
>> Am i missing something?
>>
>> -Dai
>>
> if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout)
> 	fl->fl_lmops->lm_breaker_timedout(fl);
> else
> 	lease_modify(fl, F_UNLCK, dispose);
>
> ... the lm_breaker_timedout() function (or the workqueue job it spawns)
> is then responsible for calling lease_modify() at the appropriate time.
>
> In most cases you're going to need to queue a workqueue job to fence,
> and you don't want to clear out the lease until after it's done.

Oh I see, thank you!

-Dai

>
>
>>>> +		}
>>>>    	}
>>>>    }
>>>>    
>>>> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
>>>> index 7ba9e2dd0875..69d3889df302 100644
>>>> --- a/fs/nfsd/blocklayout.c
>>>> +++ b/fs/nfsd/blocklayout.c
>>>> @@ -443,6 +443,14 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
>>>>    	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
>>>>    }
>>>>    
>>>> +/*
>>>> + * Perform the fence operation to prevent the client from accessing the
>>>> + * block device. If a fence operation is already in progress, wait for
>>>> + * it to complete before checking the NFSD_MDS_PR_FENCED flag. Once the
>>>> + * operation is complete, check the flag. If NFSD_MDS_PR_FENCED is set,
>>>> + * update the layout stateid by setting the ls_fenced flag to indicate
>>>> + * that the client has been fenced.
>>>> + */
>>>>    static void
>>>>    nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>>>>    {
>>>> @@ -450,31 +458,23 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>>>>    	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
>>>>    	int status;
>>>>    
>>>> -	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev))
>>>> +	mutex_lock(&clp->cl_fence_mutex);
>>>> +	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev)) {
>>>> +		ls->ls_fenced = true;
>>>> +		mutex_unlock(&clp->cl_fence_mutex);
>>>> +		nfs4_put_stid(&ls->ls_stid);
>>>>    		return;
>>>> +	}
>>>>    
>>> I don't understand what this new mutex is protecting, and this all
>>> seems overly complex. If feels kind of like you want nfsd to be driving
>>> the fencing retries, but I don't think we really do. Here's what I'd
>>> do.
>>>
>>> I'd just make ->fence_client a bool or int return, and have it indicate
>>> whether the client was successfully fenced or not. If it was
>>> successfully fenced, then have the caller call lease_modify() to remove
>>> the lease. If it wasn't successfully fenced, have the caller (the
>>> workqueue job) requeue itself if you want to retry. If the caller is
>>> ready to give up, then call lease_modify() on it and remove it (and
>>> probably throw a pr_warn()).
>>>
>>>>    	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
>>>>    			nfsd4_scsi_pr_key(clp),
>>>>    			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
>>>> -	/*
>>>> -	 * Reset to allow retry only when the command could not have
>>>> -	 * reached the device. Negative status means a local error
>>>> -	 * (e.g., -ENOMEM) prevented the command from being sent.
>>>> -	 * PR_STS_PATH_FAILED, PR_STS_PATH_FAST_FAILED, and
>>>> -	 * PR_STS_RETRY_PATH_FAILURE indicate transport path failures
>>>> -	 * before device delivery.
>>>> -	 *
>>>> -	 * For all other errors, the command may have reached the device
>>>> -	 * and the preempt may have succeeded. Avoid resetting, since
>>>> -	 * retrying a successful preempt returns PR_STS_IOERR or
>>>> -	 * PR_STS_RESERVATION_CONFLICT, which would cause an infinite
>>>> -	 * retry loop.
>>>> -	 */
>>>> -	if (status < 0 ||
>>>> -	    status == PR_STS_PATH_FAILED ||
>>>> -	    status == PR_STS_PATH_FAST_FAILED ||
>>>> -	    status == PR_STS_RETRY_PATH_FAILURE)
>>>> +	if (status)
>>>>    		nfsd4_scsi_fence_clear(clp, bdev->bd_dev);
>>>> +	else
>>>> +		ls->ls_fenced = true;
>>>> +	mutex_unlock(&clp->cl_fence_mutex);
>>>> +	nfs4_put_stid(&ls->ls_stid);
>>>>    
>>>>    	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>>>>    }
>>>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>>>> index ad7af8cfcf1f..1c498f3cd059 100644
>>>> --- a/fs/nfsd/nfs4layouts.c
>>>> +++ b/fs/nfsd/nfs4layouts.c
>>>> @@ -222,6 +222,29 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
>>>>    	return 0;
>>>>    }
>>>>    
>>>> +static void
>>>> +nfsd4_layout_fence_worker(struct work_struct *work)
>>>> +{
>>>> +	struct nfsd_file *nf;
>>>> +	struct delayed_work *dwork = to_delayed_work(work);
>>>> +	struct nfs4_layout_stateid *ls = container_of(dwork,
>>>> +			struct nfs4_layout_stateid, ls_fence_work);
>>>> +	u32 type;
>>>> +
>>>> +	rcu_read_lock();
>>>> +	nf = nfsd_file_get(ls->ls_file);
>>>> +	rcu_read_unlock();
>>>> +	if (!nf) {
>>>> +		nfs4_put_stid(&ls->ls_stid);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	type = ls->ls_layout_type;
>>>> +	if (nfsd4_layout_ops[type]->fence_client)
>>>> +		nfsd4_layout_ops[type]->fence_client(ls, nf);
>>> If you make fence_client an int/bool return, then you could just
>>> requeue this job to try it again.
>>>
>>>> +	nfsd_file_put(nf);
>>>> +}
>>>> +
>>>>    static struct nfs4_layout_stateid *
>>>>    nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
>>>>    		struct nfs4_stid *parent, u32 layout_type)
>>>> @@ -271,6 +294,10 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
>>>>    	list_add(&ls->ls_perfile, &fp->fi_lo_states);
>>>>    	spin_unlock(&fp->fi_lock);
>>>>    
>>>> +	INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
>>>> +	ls->ls_fenced = false;
>>>> +	ls->ls_fence_retry_cnt = 0;
>>>> +
>>>>    	trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
>>>>    	return ls;
>>>>    }
>>>> @@ -708,9 +735,10 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
>>>>    		rcu_read_unlock();
>>>>    		if (fl) {
>>>>    			ops = nfsd4_layout_ops[ls->ls_layout_type];
>>>> -			if (ops->fence_client)
>>>> +			if (ops->fence_client) {
>>>> +				refcount_inc(&ls->ls_stid.sc_count);
>>>>    				ops->fence_client(ls, fl);
>>>> -			else
>>>> +			} else
>>>>    				nfsd4_cb_layout_fail(ls, fl);
>>>>    			nfsd_file_put(fl);
>>>>    		}
>>>> @@ -747,11 +775,9 @@ static bool
>>>>    nfsd4_layout_lm_break(struct file_lease *fl)
>>>>    {
>>>>    	/*
>>>> -	 * We don't want the locks code to timeout the lease for us;
>>>> -	 * we'll remove it ourself if a layout isn't returned
>>>> -	 * in time:
>>>> +	 * Enforce break lease timeout to prevent NFSD
>>>> +	 * thread from hanging in __break_lease.
>>>>    	 */
>>>> -	fl->fl_break_time = 0;
>>>>    	nfsd4_recall_file_layout(fl->c.flc_owner);
>>>>    	return false;
>>>>    }
>>>> @@ -782,10 +808,51 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
>>>>    	return 0;
>>>>    }
>>>>    
>>>> +/**
>>>> + * nfsd4_layout_lm_breaker_timedout - The layout recall has timed out.
>>>> + * If the layout type supports a fence operation, schedule a worker to
>>>> + * fence the client from accessing the block device.
>>>> + *
>>>> + * @fl: file to check
>>>> + *
>>>> + * Return true if the file lease should be disposed of by the caller;
>>>> + * otherwise, return false.
>>>> + */
>>>> +static bool
>>>> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
>>>> +{
>>>> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
>>>> +	bool ret;
>>>> +
>>>> +	if (!nfsd4_layout_ops[ls->ls_layout_type]->fence_client)
>>>> +		return true;
>>>> +	if (ls->ls_fenced || ls->ls_fence_retry_cnt >= LO_MAX_FENCE_RETRY)
>>>> +		return true;
>>>> +
>>>> +	if (work_busy(&ls->ls_fence_work.work))
>>>> +		return false;
>>>> +	/* Schedule work to do the fence operation */
>>>> +	ret = mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
>>>> +	if (!ret) {
>>>> +		/*
>>>> +		 * If there is no pending work, mod_delayed_work queues
>>>> +		 * new task. While fencing is in progress, a reference
>>>> +		 * count is added to the layout stateid to ensure its
>>>> +		 * validity. This reference count is released once fencing
>>>> +		 * has been completed.
>>>> +		 */
>>>> +		refcount_inc(&ls->ls_stid.sc_count);
>>>> +		++ls->ls_fence_retry_cnt;
>>>> +		return true;
>>> The cases where the fencing didn't work after too many retries, or the
>>> job couldn't be queued should probably get a pr_warn or something. The
>>> admin needs to know that data corruption is possible and that they
>>> might need to nuke the client manually.
>>>
>>>> +	}
>>>> +	return false;
>>>> +}
>>>> +
>>>>    static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>>>>    	.lm_break		= nfsd4_layout_lm_break,
>>>>    	.lm_change		= nfsd4_layout_lm_change,
>>>>    	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
>>>> +	.lm_breaker_timedout	= nfsd4_layout_lm_breaker_timedout,
>>>>    };
>>>>    
>>>>    int
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 583c13b5aaf3..a57fa3318362 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -2385,6 +2385,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
>>>>    #endif
>>>>    #ifdef CONFIG_NFSD_SCSILAYOUT
>>>>    	xa_init(&clp->cl_dev_fences);
>>>> +	mutex_init(&clp->cl_fence_mutex);
>>>>    #endif
>>>>    	INIT_LIST_HEAD(&clp->async_copies);
>>>>    	spin_lock_init(&clp->async_lock);
>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>> index 713f55ef6554..57e54dfb406c 100644
>>>> --- a/fs/nfsd/state.h
>>>> +++ b/fs/nfsd/state.h
>>>> @@ -529,6 +529,7 @@ struct nfs4_client {
>>>>    	time64_t		cl_ra_time;
>>>>    #ifdef CONFIG_NFSD_SCSILAYOUT
>>>>    	struct xarray		cl_dev_fences;
>>>> +	struct mutex		cl_fence_mutex;
>>>>    #endif
>>>>    };
>>>>    
>>>> @@ -738,8 +739,13 @@ struct nfs4_layout_stateid {
>>>>    	stateid_t			ls_recall_sid;
>>>>    	bool				ls_recalled;
>>>>    	struct mutex			ls_mutex;
>>>> +	struct delayed_work		ls_fence_work;
>>>> +	bool				ls_fenced;
>>>> +	int				ls_fence_retry_cnt;
>>>>    };
>>>>    
>>>> +#define	LO_MAX_FENCE_RETRY		5
>>>> +
>>>>    static inline struct nfs4_layout_stateid *layoutstateid(struct nfs4_stid *s)
>>>>    {
>>>>    	return container_of(s, struct nfs4_layout_stateid, ls_stid);
>>>> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
>>>> index 2f5e5588ee07..13b9c9f04589 100644
>>>> --- a/include/linux/filelock.h
>>>> +++ b/include/linux/filelock.h
>>>> @@ -50,6 +50,7 @@ struct lease_manager_operations {
>>>>    	void (*lm_setup)(struct file_lease *, void **);
>>>>    	bool (*lm_breaker_owns_lease)(struct file_lease *);
>>>>    	int (*lm_open_conflict)(struct file *, int);
>>>> +	bool (*lm_breaker_timedout)(struct file_lease *fl);
>>>>    };
>>>>    
>>>>    struct lock_manager {

