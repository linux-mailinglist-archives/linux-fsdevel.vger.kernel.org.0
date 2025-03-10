Return-Path: <linux-fsdevel+bounces-43649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF37A59E62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6417188F60B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 17:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695F123372F;
	Mon, 10 Mar 2025 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mhj87Q4k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t9jx1y7t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C54881E;
	Mon, 10 Mar 2025 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627829; cv=fail; b=OLf/cNdtMWYJDC3xVEduzKco1Ozb4n/BdRqme4dIKAvFg6/78WARd7spEtTSSmjANnkdxaI5AR2YkXS6CHaafOW+tmW/1EH+Iu7XZ1Gzfr0LpzTIpj17Yl980j79AgkEsI0EDuTvOb/UytwwGD2AmcKg4yHjT1F/l2ciyokA+Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627829; c=relaxed/simple;
	bh=DFAUaBiT43GvoE1ouNH7XReheSu5ojMsJsYtA5lEzmc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hx5s0E7gvLsps4oreqJdtdDHmRpig4XTcrZXocEwKh9hWZuBBQQ1HCQOhHfk0YnMakVnhnh69nasLILPzhP+dE7Xfb9Y6QzVFyaACW9j6SwPFa1j/X3u2lEdi0kcxsX5L6BCLgRCFuCs8wU4lX77K5ucuhezpupm7cuPlQQ1xz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mhj87Q4k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t9jx1y7t; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AGfg7B032539;
	Mon, 10 Mar 2025 17:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mSgG6INfOSMMDp96wf6hU1unvwWBrkq2f6MWCjc1+i0=; b=
	mhj87Q4kQbttMnOYo4Qc2VdTwQhl8FQowwAZtIMp6fvtEf4zpRM3jjWWy/1cJh0H
	YZG8dfkceSzsHP/lH8fv9rsyhsaj/6xE66hNx2phALeVG6ZCsJnMuTstGuZCGWda
	82PDypgtejHli+JvlsYWfa4z2/+YPHvnlzBC2LLMoblsipuaNwdofi9g3tFK7Vmh
	ydcVs4LgNxACNt9hQ8b+4auArCuQTHNtoMq4yOIquu1pHARIhLGDIkMydlBsSmqn
	92TIcbuyoguyBV5dg79MnavVEBXfaMNQnSwWHflK4wICVxZ1KXuielggrYjJG1f/
	xkYBsiA2zbJFPGBPctm/ew==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458dxck5bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 17:30:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AGghpC026367;
	Mon, 10 Mar 2025 17:30:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb7wj1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 17:30:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctEgK3YPSWde+co0leNmdHJYbKjh+8ASPZ0Em7/EMXiQJqTsNYDM1A4wKHuSeWYrtkwrC5blKFSHTBDbsqRz7bBAizHMyFtodnSkptVE1RbtdrMBEACQ4gGV11Mmg0HmGNeOgfsNBacXgWbKewD7BQQBo3yxsNmF5hETCvk9fucbFHmNDZbFzywppzmBb2fBQtAoyNeteDMY9Cxkdw3pMoVL029/L7scoZZ3asnMEp5Bk30L8xvQdC98jWG7+J2EhJCH67Muw7pc70mJ75MPkQmadazvhr25loQ1eZU6Vamci/7Cr45k8KgMjlSVcsXVFzwNtwTyKy80dgOsxglX8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSgG6INfOSMMDp96wf6hU1unvwWBrkq2f6MWCjc1+i0=;
 b=FJKk3zzC+lRqYRPCSCrp5H2o0xh0vZRvDkitoKlgIPrAuVl1+ENtcEF1tcABrB3x27hreB3tgRtjVWKLFQ86Ed5TzIkeh5R2LOuEpKJPS2D+gA8/FxTtKXZup35+u/pOYLs1OyXSxqujZ/Bye03sG2wYdkhgOvwXZF3FF/QnfEWKLqITc/6Rb/fdHN4QFfQFrfrldnd7S0fcDehjIiL9LHjsah0XWzq1qT6MQIRiNPb7rOZNOz8WwtE05y+Yd0NkydtFXS4KJjHXYTgDCNNm8y3OHkBLWjR1TXdkkGHbwFF7R0UZAm0y2bVi37pJhhLZI+mzSikDr+HpVXCMuH7TzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSgG6INfOSMMDp96wf6hU1unvwWBrkq2f6MWCjc1+i0=;
 b=t9jx1y7tok8jGs4qgC73mo58EZ1otWroCk8unB9lYe5jb4hAkMCeTu/RBVkpF7BEDVWikmS1De5A82Xn9Qt3R2iRbJeH+9l7O4R1YD/9+CAsv3euGPpMDSoA1d777dKDjfXHA1048yaF0En8WvUoAtfkVMbGsEFvaorbtKPgNhI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7362.namprd10.prod.outlook.com (2603:10b6:8:f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 17:30:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 17:30:13 +0000
Message-ID: <d61acb5f-118e-4589-978c-1107d307d9b5@oracle.com>
Date: Mon, 10 Mar 2025 13:30:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "libfs: Use d_children list to iterate
 simple_offset directories"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable <stable@kernel.org>,
        Takashi Iwai <tiwai@suse.de>
References: <2025022644-blinked-broadness-c810@gregkh>
 <a7fe0eda-78e4-43bb-822b-c1dfa65ba4dd@oracle.com>
 <2025022621-worshiper-turtle-6eb1@gregkh>
 <a2e5de22-f5d1-4f99-ab37-93343b5c68b1@oracle.com>
 <2025022612-stratus-theology-de3c@gregkh>
 <ca00f758-2028-49da-a2fe-c8c4c2b2cefd@oracle.com>
 <2025031039-gander-stamina-4bb6@gregkh>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2025031039-gander-stamina-4bb6@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0010.namprd08.prod.outlook.com
 (2603:10b6:610:5a::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d5603a1-fac4-4c5e-1941-08dd5ff9374e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTIzTG03VCtSYmRHT3h3K0V3Kzl5eG1BN0NVUWpFandIZytOcDRnRE8xbEMy?=
 =?utf-8?B?ODdCaFZzdVNzQm5GOWtXb3FYbUc1ZkdDREJJVHIwUENlS3dYeXlBeFpqYnRY?=
 =?utf-8?B?alAxREd4VWx1YnN5Q3VGUmFYaXl4ZXg2T3pRZmtPMUcwMmVnTFpZY2pWdFlz?=
 =?utf-8?B?WUxrQTNZdDE4RXB6dWsvTkpmTXVTN2hQam9IMlZmRENOYnRCRkZpQkVtYW9h?=
 =?utf-8?B?ZnZqcjZFUDVXTTVSQWpHZjVXcEhlMHJ2NVhPREJTc3ZSN2RXZFp0YnNhZ2RF?=
 =?utf-8?B?bjhzUFNiS05GZlRIeklUS1pCSy9haC96R2lRb3JYd09kVTF5Z0h3SzBJbHpB?=
 =?utf-8?B?akIrREVxU2pjTG1ITGxKT01kbno5NEc1b2NtOFVVVGdLSnlPMEdYT0Q1NllQ?=
 =?utf-8?B?SnkzNzIwSVVUaFRack9mWjRDREhnaytsOXNSVlM1aVU0WWROMFYrNzNqczVu?=
 =?utf-8?B?NjdBbDEyYWk0SXBRaTBFdDZiQ1FHWUlKakZuMnArLy9sTHJZYmJGVkE0Lzda?=
 =?utf-8?B?NFAzNG1yOEtGMVRmclBJTDVrVXlUWjIvU3ZQeWhFRjNNSHJwYWJlQWJVWmkx?=
 =?utf-8?B?d2lFcUgwOEtyZERzY2MvRjdTTmZxSE0wY2pqTFpBdlJLQ3dsOW1rTUtUeWhi?=
 =?utf-8?B?SmRQdGtmQnJrRVg3aWdiZmVtclE2YzNwcitTV0s2Y3hKMC9ZclJxYVh5TVZo?=
 =?utf-8?B?OVN4T2JROENnSVczdTR3RXhJeHNPQldjVzNVNEFOdUdEOTlWM2U3MlJhUU5p?=
 =?utf-8?B?OUdDL2ljSmxOK3EydDlEU0JIb3FUM3cyZ3BLWG0vQVRSbitVSFpIMUxURHU0?=
 =?utf-8?B?ZHY3Zy80bEc3Q3c5Q2RWdjZKWHc0dC9pQTg2N2F6Uk4xTkQ5OEVaK3JKRXNP?=
 =?utf-8?B?cjFkM0MwbXMvcXFYbFMvcjBrWENiRnNVZjdUcnROT1U0MHNlZmFmeUlTeEZ0?=
 =?utf-8?B?eDNVSS9BUkdpU2Q5c3I5T3hoR2gxT1U3dHJWbC9EUXpiMXNLVnBWVStEMDhI?=
 =?utf-8?B?eWIweXM5TnpkZld4bW12MXlXOEJCTGxBMkRjb2lpdVRicWtzdGM0eTJjaDVx?=
 =?utf-8?B?OE1IY3dGQ29hUXhieEF3c1Ruc1lvMjcxQUJZalUxaHovRVA4cHQwZW81Ylpj?=
 =?utf-8?B?dTg5eUJSRWVHL0ZrOTJkZGRNbDlJZVFra2lOdi9ZTWl4cXVyTUluTExqK3BP?=
 =?utf-8?B?c2JMdjVLOEJXZ0owZHhhR3ZmY2ttczdEZlBrVDcrSWFkVHA5Y3Jra0plY3J2?=
 =?utf-8?B?RWI2a205d0lueXd2RWNKTmJOdGVqbWZYU085Vnk1TVE0QlNpNVZadnI5UUNs?=
 =?utf-8?B?a1NINWY0Wno1K3VtdUQzWUEzZFovREZUeHpmRWExUGNTMm0zcVI4d0lUczVp?=
 =?utf-8?B?d2IzQ0dNZlFYYTRRYzA2SjJBbUpZRDJBYTFRT29sWnArWHByYk5UZFdka1hK?=
 =?utf-8?B?OE12UWFBK2xEODZ6MFN5Mm1MSkgxMEU3T3o2VnduL285aTdjNW1UM25NRFVT?=
 =?utf-8?B?ejRGcW4zOStMVkcyRUNGcmJKcUNKSFdBSHM3OEZNeTlJVmx6SjFNRHVPcTVS?=
 =?utf-8?B?OEJYT1BWNm84T3NvUlpSWjlSMXZ5bnpFVmxaSmUvYWhtQitqSWRGL0EyWnlx?=
 =?utf-8?B?SGZKSGRwem13cG1ibFdicE9RWDVrbHlycXNHZjhORGU3TnVwQUxEcmRzTDI2?=
 =?utf-8?B?aUVTWlJBMVFIeE43MFVETWgzWDEwclN5L1R5YkNwOUVuZHlselRRK1NTSEtv?=
 =?utf-8?B?d2ZUaUVvcEFsaXNkRHJXWGUyUENuUUluWC91Vnd5Y2VBOHlzSFZmdmpiTGtr?=
 =?utf-8?B?V2Y1Yy90Zm5hcUhVdkNHZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXpGL2pSZ2V6Q1V2QytrZzZ1Q2YvZHhEMFdHdERjanZ1QWlSWGI0MGxEZGUy?=
 =?utf-8?B?ZEIxdGpDd0VoWGRVN1o0VkJtL3B6aDR5M2VwUGFaR1FITVBtN1cvemtrZUVj?=
 =?utf-8?B?Z2ZHdk9kY294bnNRa2dCUThYQmIySW96SE5BVE9rUTFyTnVJd0o5VmtBMTZp?=
 =?utf-8?B?b0FCRTltVmN0WlhxM05qT045L0xxSVRFSWFwYXRGa005UHZ4dEJzYVVUb3Fx?=
 =?utf-8?B?RTFZR2Q1R01qS1ZpVDhSb0RKVHhDbytIdWNmSitaUTM3Qlh3MWttMnFwYlVR?=
 =?utf-8?B?VUt1RElqeEw4RzhIMnpKemVocFNFL1JaeWtpVG42MExQQzVSeVZlZFRGRjU1?=
 =?utf-8?B?ZUVtNGwyNm1Xd2p3QStVYUdVZ09FUWFGc0liVTl2OWhZK0lXYU9SUWNHU0I4?=
 =?utf-8?B?cklqUXprbHpiNEZmZVdWSFZpdDd0Rm0wNFhUZnh3anhoSkVTbjlPS0VHUEFh?=
 =?utf-8?B?NUMvOHk0U0kwYnY0cEdtYytocDI4dEtpTUdMVE85UDNpSFB3MDRBV1NwdStR?=
 =?utf-8?B?ekR2VldmeHp5UWF5WE9XdnF2dE5ybEw0a2dDVklCL3pJWjcvaHNJUU1obThX?=
 =?utf-8?B?aU51MExVZmhrbDVGcXJVZTNmMzRpZDZ1RWIzT0hTRnFKcUZETXJid1k2L1Fu?=
 =?utf-8?B?a1ZRMjJZSzhSaUNMdCtyVm1FU0NhT3BwRnNrZG1HUVE2Z1NCNkxZQnNCTm9t?=
 =?utf-8?B?dUNNVXNDc1NMbXFaZGFLKzQxem8yZTZocVZxK2pJaVZBb1I1REd4SGtLTHFp?=
 =?utf-8?B?aVRtQ24ycllENWhoQU5qT2VUVXNEajBsUU1KK3VzNDVvRHZRajRUcVlrZ1N2?=
 =?utf-8?B?cjRickJLTE9oVDZSdW5NNGduQ29LbVN3TTJrYWE1aVNTdnFXNDRoRTlvNE9J?=
 =?utf-8?B?WDBzSHBDZVRxaWlaWFdXQ0JnMkVndDFtelhBa1lPWlhURGpNY3hFd2lub0xT?=
 =?utf-8?B?T3J5bXprQmZWVjZUWFl2TWZyZkV1MVgvRGZwNElMb3dBZ0hWZEgvdnkydkQ1?=
 =?utf-8?B?dzc4ZjM0a3BJVWhiNkxKaHNCV2dKa2toOGY1MW4yTi93V1ErWGZ1c0RldjJL?=
 =?utf-8?B?TWx3ZnBzQzc3czFuOXFyZlovcWVnS2JLY0szbk9xMVc5RVhOQm5oclRKNSt0?=
 =?utf-8?B?WGgxYmdETzlFOVRNb1Y4Mk1US2wzNm1LMjdSdEE2ay9UMVhOUFFBNVVEUnRh?=
 =?utf-8?B?SVlhaWFHWUdQUHlDbE51eFIyeGVTelhZYzhMYUZJVEZoUnZTWTVPMGRDNTNG?=
 =?utf-8?B?cmIwS0VUVHU0a0t1YUxFYWxSSFQ1TkFackdsT3pwNTdiaG01TEhKL2ppQzFU?=
 =?utf-8?B?L2l5VlFsQ1NIYlAxenJRVE1FK3ZlT0c0OWhTdWtDamNZRkxVUStIT0o5REJp?=
 =?utf-8?B?VVVXM09xZUkwTUJBNTRNSEVQaEdORHZ5ZjBpTGxmM3FSU0RWSEMwc0o2RVJh?=
 =?utf-8?B?RC8vTjBRRlNLMkh5cnBNMWVUbGMzZC85R0FmL1V2aC9ncU1XTWpRTkxLVTBT?=
 =?utf-8?B?SXh6Z2h1dGJYU3phaVdSSmJiOWJ0MDV4ME1IdGlMaFBKTWExQWpkdk54b1Qz?=
 =?utf-8?B?eEppV2NsT0o2UkZkZ0FEUHlLaFlENmM0Y1hTTWlxTTFmVFlBWG1CMnBBdm9k?=
 =?utf-8?B?cGMzRnMwLzlnSTc1ZWVhL2YxWEhBcE5OUFRnbzE2aFdJUmdOM0dnaDk3MWJQ?=
 =?utf-8?B?R2Y2RndDaDF1UUNpTmN2allLdWVQRVBvZHFROEpRQzZXcXJWYkRpNitta0tw?=
 =?utf-8?B?cVBjay91Y0t6ZXRoU1gwLzlxdHN0R1RiaU5YcGFQRkRzeEp1VWx4T0UyVmJy?=
 =?utf-8?B?MzFSWW05aXFSN0FmTE5WK01PMHZic0NmSjFSRlE1dXBNMHNXTGdzTUU0N25p?=
 =?utf-8?B?OUh2OTRTRE5LU1l5RmhidVl3OGJOZjZ0dWcvaDNjUnJSM0Qvem9mSmxzK016?=
 =?utf-8?B?M0dBVGFaaGJXMGltVkljdzRybTNuakhKNldUTTVyTUVRdGNDZHRmU2Rwbi8v?=
 =?utf-8?B?Ly9ibkRGdWhDU0hqSHRGRTJ2WXoreHZpZWlOQWFzT0lkVlFNVEVYRTZDMzRX?=
 =?utf-8?B?U2NaOFc4SUxuYjZUdVVEQW9NYkxyd3NFQ2p6TjFJNGx6MzlsSWw2OGN5dW9P?=
 =?utf-8?Q?Fa2MEq3SqEw3/yZ0+GAUSJP4A?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5wKj66kQBdRuVdonkNpx+NTWQrAJz/pBD/hOXLVEMNEjmtakkolyU6kZ15ZdZ2sO2/jsVX1O+lXE7kNGq8OLUS8K78tSlYlrK2r0jDiZ/vFnHO8DLxfCy5PK15ONl9qQgHgMak1XR0+zuqBR0qxQQEgkdWLChFjx39sYyKCLZPo4q25//CLnW7+JZmv/Pk5L2yCh2B2j7fp64cAn8fETGjGRooy1e1TIgYjxUmrHWue8XwA/Z5oPxBv70siZjoUfwmrzD5YOh4DQ72elQI9IsyPJkgW5M2Z39LOejOflnS/a/ixOmSdBNgmqDb8jSCGVxOch4NfkdFHPdWGxLqQuth5YcxRCuhl8nV7wdC3HL8Es3T/gLn6uckld6LdK1c/Acnkph83d3SGEHHSOY3Hyi7bwaLlBHDwA7O0/MBVlh5aakO486dNXKU8dt3KfqIm/zXAVyS7W3rLInLP/OQPdN2tOd36f0KeM2WA9tPrgAoFTi8C12E4f0oH0GgQk/B078j1GeCjtZerUns5s93iKlPiUqgYn+VTYsJOlENYiCaHaNyLOQLQgZQrKcODKQLBlHhS+KMrbs9k0almJOLuGp2QOIzV/ThRQl+9joNfflQE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5603a1-fac4-4c5e-1941-08dd5ff9374e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 17:30:13.7248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3xotMau85sslBSX3qVsbMqAAvRIxF0SIrFCIVwye45d3bbeEu5bWXXJNieetXLfVTkyq3DnBrkqKGa8W2fsPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7362
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=768 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100136
X-Proofpoint-ORIG-GUID: XKSIkgSmirZXDgcdI9-TVen4-sJptoJK
X-Proofpoint-GUID: XKSIkgSmirZXDgcdI9-TVen4-sJptoJK

On 3/10/25 12:29 PM, Greg Kroah-Hartman wrote:
> On Wed, Feb 26, 2025 at 03:33:56PM -0500, Chuck Lever wrote:
>> On 2/26/25 2:13 PM, Greg Kroah-Hartman wrote:
>>> On Wed, Feb 26, 2025 at 11:28:35AM -0500, Chuck Lever wrote:
>>>> On 2/26/25 11:21 AM, Greg Kroah-Hartman wrote:
>>>>> On Wed, Feb 26, 2025 at 10:57:48AM -0500, Chuck Lever wrote:
>>>>>> On 2/26/25 9:29 AM, Greg Kroah-Hartman wrote:
>>>>>>> This reverts commit b9b588f22a0c049a14885399e27625635ae6ef91.
>>>>>>>
>>>>>>> There are reports of this commit breaking Chrome's rendering mode.  As
>>>>>>> no one seems to want to do a root-cause, let's just revert it for now as
>>>>>>> it is affecting people using the latest release as well as the stable
>>>>>>> kernels that it has been backported to.
>>>>>>
>>>>>> NACK. This re-introduces a CVE.
>>>>>
>>>>> As I said elsewhere, when a commit that is assigned a CVE is reverted,
>>>>> then the CVE gets revoked.  But I don't see this commit being assigned
>>>>> to a CVE, so what CVE specifically are you referring to?
>>>>
>>>> https://nvd.nist.gov/vuln/detail/CVE-2024-46701
>>>
>>> That refers to commit 64a7ce76fb90 ("libfs: fix infinite directory reads
>>> for offset dir"), which showed up in 6.11 (and only backported to 6.10.7
>>> (which is long end-of-life).  Commit b9b588f22a0c ("libfs: Use
>>> d_children list to iterate simple_offset directories") is in 6.14-rc1
>>> and has been backported to 6.6.75, 6.12.12, and 6.13.1.
>>>
>>> I don't understand the interaction here, sorry.
>>
>> Commit 64a7ce76fb90 is an attempt to fix the infinite loop, but can
>> not be applied to kernels before 0e4a862174f2 ("libfs: Convert simple
>> directory offsets to use a Maple Tree"), even though those kernels also
>> suffer from the looping symptoms described in the CVE.
>>
>> There was significant controversy (which you responded to) when Yu Kuai
>> <yukuai3@huawei.com> attempted a backport of 64a7ce76fb90 to address
>> this CVE in v6.6 by first applying all upstream mtree patches to v6.6.
>> That backport was roundly rejected by Liam and Lorenzo.
>>
>> Commit b9b588f22a0c is a second attempt to fix the infinite loop problem
>> that does not depend on having a working Maple tree implementation.
>> b9b588f22a0c is a fix that can work properly with the older xarray
>> mechanism that 0e4a862174f2 replaced, so it can be backported (with
>> certain adjustments) to kernels before 0e4a862174f2.
>>
>> Note that as part of the series where b9b588f22a0c was applied,
>> 64a7ce76fb90 is reverted (v6.10 and forward). Reverting b9b588f22a0c
>> leaves LTS kernels from v6.6 forward with the infinite loop problem
>> unfixed entirely because 64a7ce76fb90 has also now been reverted.
>>
>>
>>>> The guideline that "regressions are more important than CVEs" is
>>>> interesting. I hadn't heard that before.
>>>
>>> CVEs should not be relevant for development given that we create 10-11
>>> of them a day.  Treat them like any other public bug list please.
>>>
>>> But again, I don't understand how reverting this commit relates to the
>>> CVE id you pointed at, what am I missing?
>>>
>>>> Still, it seems like we haven't had a chance to actually work on this
>>>> issue yet. It could be corrected by a simple fix. Reverting seems
>>>> premature to me.
>>>
>>> I'll let that be up to the vfs maintainers, but I'd push for reverting
>>> first to fix the regression and then taking the time to find the real
>>> change going forward to make our user's lives easier.  Especially as I
>>> don't know who is working on that "simple fix" :)
>>
>> The issue is that we need the Chrome team to tell us what new system
>> behavior is causing Chrome to malfunction. None of us have expertise to
>> examine as complex an application as Chrome to nail the one small change
>> that is causing the problem. This could even be a latent bug in Chrome.
>>
>> As soon as they have reviewed the bug and provided a simple reproducer,
>> I will start active triage.
> 
> What ever happened with all of this?

https://issuetracker.google.com/issues/396434686?pli=1

The Chrome engineer chased this into the Mesa library, but since then
progress has slowed. We still don't know why GPU acceleration is not
being detected on certain devices.


-- 
Chuck Lever

