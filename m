Return-Path: <linux-fsdevel+bounces-32945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4B29B0F6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 21:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7631F251BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 19:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE0720F3EC;
	Fri, 25 Oct 2024 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k+9u7ZP9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ttNyYapX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E3F20C31C;
	Fri, 25 Oct 2024 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729885820; cv=fail; b=CuAmB6IPfcy8xd4PNaM0MnWzd7QRMrDWehySu18CBWGZ43HCq05hXWdotAnvvpB0XAemE+JQzEwdXxw4MC62jjJ5eq1xcqR1j9GRVj5KcXszOPVeaMHAgUm5/gyr8GYhOvXa+wz+/w6uX9JBMJsiPoo+gzfiY39R5fUl1APEJ8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729885820; c=relaxed/simple;
	bh=iGfC+hdsPMLJXkbivtGjm2shk6/2K3nAAIUKZN9RGus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T+HYNxqOG1d2ZhuhqOjWu4MgGaTWCtgeWWE5k21NlRvT0/Kr3qCy1/PDkku/khH6YeXdPD0AooddPQhGpsVbtI2PgcJ8m3s5ZDrZwRFVrQjcWxap4k3bf96hdqqmdeWBiqe4CxN3IZTok74pFdTsnJKcbt4Zu7qI8kJ5K4BF/pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k+9u7ZP9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ttNyYapX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PJdUO8020754;
	Fri, 25 Oct 2024 19:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Zw2x8WpbwjmPazuGaZihcTM+wGvxkUID6s5wRjWmdAI=; b=
	k+9u7ZP9WJmdKIfmQWr9/7DEesrUUbw85XK3urxa2kvj0bcy2+vQyin0ahwIbIjL
	9TcT6sO1lUeSvK3Rqgz3etRIs9HGzfUPXECY8KHUQP46vzToCcuZI8oK7sEYi295
	NwFjV/Mx0P23JA4upaWpllRh1JOnFgrS1xluotovgZvm0jFJmy6+WeUZx3wx4zGn
	TSkM5zqRVgD9gD/9wf9txjoshXjp2+xHxVGJ+Q+ns+DQxJ2CyH/Bof3OFQpP8pKN
	6+UQb9udZhIQ8NIawyop7WjLxYvCmJPSq3+oDMOgZUvtRJcpt/GRexEbKn45qPPG
	xbj7RXZtueMAPVRs6+Nbjw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkr50jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 19:50:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PJTtON020939;
	Fri, 25 Oct 2024 19:50:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhnt0hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 19:50:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mji1vCZpiOPQAYOgLB5sXTumYT7Z87S5ZjBXaCtLRxGUaTxCuvmBAwZhbw+V7k/NTH484SpQDGeftXMSzp/oz+9XK21Op74C0VaQKmjTD7b0SzCLu0deaIjVvlpzQcS2jvbVyl2/zOEC8fM9M/vU8EQWFs+m9yeuwUa3KnrAEG7yo0eWaUxyBzxDhy3d0c6I6pe/1S8YVD7Qc4ey5iC62AozZQyL/Pm08l9ePdWeDz9hY42eo+KnEX11UH3/W74j0dxUIuzsLqkcLoX+ikJwKF8IvbF0hssJwdYds2RjUi0d3hywKbyeSR65b90ge++wB0QboKMNTjffSm75Orhqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zw2x8WpbwjmPazuGaZihcTM+wGvxkUID6s5wRjWmdAI=;
 b=LA2D95Nqg7kk5vkzrcb4yrEw7SH2gg1mcRyCmSsmcRekDiR31B2DtHOoisrNxd19pc61OR9h+Wcu0i8GfEmezuZTa1zmSywqEkRRKxIlKbMZd5FoyaI27lM5nl/lmkcn3GipG49iWy/obJLc6+LSv99wR5vc7CxPvg0dQj6zpo03YBqEkjz/NJBxUq0aRcSZCeHSui6kEydC9G28+X5hKScLCdFBH16omw7vbq7VTZ+/sZypok3MU11+13ZpkuBpADhTFCYS9ky5QY18zc1oA1H1K/FKqS2OeyPT2kIYM+32ddt4j70hv8LWs1waNIKK2lf4WvxFZdX6iYKnNAWYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zw2x8WpbwjmPazuGaZihcTM+wGvxkUID6s5wRjWmdAI=;
 b=ttNyYapXeTX6BGLYRv/AXx0p1F8PBBLwfHKRPnpfYvUBpn0aICLJPM6NYntO6NYtWNgJv1Cf4kxLXCV8rEqEBDiaExCidCe8ElmGXFypHblD3QTM1oUaKu0SZt1z2cy9pL3ZhAyHLkzkEIYd4E1or0bRtZBvIlbhTBC2tWuczQg=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH0PR10MB4986.namprd10.prod.outlook.com (2603:10b6:610:c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 19:49:59 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 19:49:59 +0000
Date: Fri, 25 Oct 2024 20:49:55 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Sang <oliver.sang@intel.com>
Subject: Re: [PATCH v5 2/5] pidfd: add PIDFD_SELF_* sentinels to refer to own
 thread/process
Message-ID: <31dd0e52-9868-4cb4-aec6-d8749cdd2560@lucifer.local>
References: <cover.1729848252.git.lorenzo.stoakes@oracle.com>
 <788fdfcc9ef602b408951d68097918d6ae379395.1729848252.git.lorenzo.stoakes@oracle.com>
 <CAKbZUD2ZB+U3GKJftfRH_2ejNja26v38OLVE2Lbfn_1KSOKhNQ@mail.gmail.com>
 <828674d9-e862-4438-86b6-61977f4cf3b5@nvidia.com>
 <CAKbZUD0fxczjSJo34MnWRNT4M6HTfWN0DRXr9CFe_+cKJW_mog@mail.gmail.com>
 <e5ac648b-88d7-4fa6-8eb4-d061a4b2baac@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5ac648b-88d7-4fa6-8eb4-d061a4b2baac@nvidia.com>
X-ClientProxiedBy: LO4P123CA0181.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH0PR10MB4986:EE_
X-MS-Office365-Filtering-Correlation-Id: dd123579-2c6f-459a-3bf1-08dcf52e351f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTZuN0R1akZGbUlpUDl1T2dZSk9rYVZPaXd1Mmkrc085SUgyNWhlUVA1T1dh?=
 =?utf-8?B?VUVjZFVsV0hhT09obkFTUzMwTDBKSkhTa21oMWpYSG4reVRxLzRsTWRjTGlF?=
 =?utf-8?B?Vk1BUEFOL3l4OE1BS1BOcVoraXMwYnVYc0dFYVR0R2w4NERmQ1dOMTlPd1FL?=
 =?utf-8?B?OUpwN2xBT3I2em5rZTNlNmFCMkhIdW9ZeVlTZ3JvSVdpUTFjSjlPTjFjSWd4?=
 =?utf-8?B?SWlqQW0xOXEvZHV5ckJINDlFNlBZR1NHdlVMN1k3R25rc05YVWc0UVdzdCt3?=
 =?utf-8?B?UEF0SThVeVIreFVmSXdDRi8vUExHQ0NVcEdvYnBaYkF3cFpKYkUzNldvUSty?=
 =?utf-8?B?QlpFTWQxRWdLbGh2NzZITW8wMTlCSC80S1RTZk1KRSsyQzk0OTdDL09pTnE2?=
 =?utf-8?B?T0w4UFZleHNSYXoyRWxTdDU2dnBSamNoZVNMSXFqNFY2SkcxYlRneVBSdXBt?=
 =?utf-8?B?ZytvdGlnL1hUdFBYMWZESnR5elVZQXJPbWVJNWlzTU9ObzRsNDhvQzgvWHRs?=
 =?utf-8?B?VTQ0OXY1ZXc5aVhSUEd2QTZZVXA4cUdIUHhSaFUvVTRuc0l5ZzZHQXlrVmFz?=
 =?utf-8?B?MFo1QUtTZWYyU205dWtpK0xiRTRydUtWM1c0NzU4WGZBN1FUY21IRUdEemZM?=
 =?utf-8?B?Ty9UTmpvNHNwcndMUU9lMSt0TkFPRml6Nzd6K1BVSVBTY0o2UWVuUm1QR0dl?=
 =?utf-8?B?OWtYVlBDOXcwdEtiYW14M3I3Q0V2Qm5GMkRJZlBSa0lRRCtmOFJIbFRoN2Fj?=
 =?utf-8?B?MVlQREk4aFplSUk5SVBNR01tVmJvVnZLRnhHSE9mZUsxVjBRQU5uQ3VDcWx6?=
 =?utf-8?B?aVZHUjdVUlp4c0ZxNWFNVDhCeGIwaldwaGtFRHUyTDN5VWtoRHVtQ1Z2RkVj?=
 =?utf-8?B?Rnh5ZDFiS2FNbHEzaForMmxCWndLUUxRa2llM2VEQVVTempCS0s0NC8yZXZy?=
 =?utf-8?B?Y1V1OE5mZ2h0MTNyQU5tN1BXcloxOXFLdE9MYm56cmdNMVQvZXpjSGFEVDRO?=
 =?utf-8?B?T1BKcU4zalFTVm8yakZJYWY2WDl0anNXcWo4MVNXemtGOWFCVEgvVjRrNHpT?=
 =?utf-8?B?Y1o1MXMyVFFValdsNEJJd2F0WWhDbGJ0U2hQS1VUMkk1ZXE5TlBHS1prU241?=
 =?utf-8?B?RkFDcjJJMFgzOFppY295RnJJQlduaEJCZmRvbXpaRjIreUpKcEovZ3RybnFI?=
 =?utf-8?B?azdqTXNCQXlDWS9DdURXemQyNlNXVnRLMllFb0svNmR3amtyb2VLQVlMa1FR?=
 =?utf-8?B?Z1hYTm1wVFlSbEEwZ0ZRcDdjMmZJelRyeUU0Vmh5NUZoWGNOSXNsN0Y2OENm?=
 =?utf-8?B?eVRybGtEdHZuN3Eydyt2NytYOEdqTHhDczNiWjdWVjZIbkRtcXNlTVpYNmY5?=
 =?utf-8?B?L3Q3aXBNREduREFmU2hOMG1zVGU3dFMxYkhMd09Yd1FZU0dQVU5adEpXenQy?=
 =?utf-8?B?UmQ4czRtakV3eGJsbkhqWjJmNjNMcW9yT0UwcGVUdXpQcXdCZzdyMUpkbmVj?=
 =?utf-8?B?VkR1aUZVUjc4OGFHdW5YZ0trUVYwVWVtdExjaW0zZm1hWHFQTVR1eGUxNXk3?=
 =?utf-8?B?aXN6a1FmcUQ0WFp4cGNhbjhERzdhUVErdENkbmRkREVUS1dPd3g4UjViRWpT?=
 =?utf-8?B?bWZabzJJemlsS2hVSElHU3NQL0x1RVZ6eThpc0RkWmx6RUxiZ0RjTTVpSVNO?=
 =?utf-8?B?VHZwZlBuZDBGYlBIWXE5SHlKajdUV0R3aDBvN0pVRk1TRTVxNGorZS9IS3lC?=
 =?utf-8?Q?9Au4HI9NFCOk+1ectwnH+oXIi5HYMIrvlHZ6x+K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmd4TzRlaXUxYlo3SldNL0U1VkFWVHA4TjFMZmJWTCtPQmpuYXBueUFRVDBz?=
 =?utf-8?B?R2RWeHlLQ2lSUWQvNTZIV01OUmsyNHJ6NzFkQ2dPY3MzN0ZmUytYd0V2U1Y2?=
 =?utf-8?B?YVdZZm5pNmNoeVNvM3hTVlhTUDU1VkowcVNvVjV6aEVUME9zVGNSNmFJUXFO?=
 =?utf-8?B?blRwamtsQU5DeEIzdmRyajBvUjdVT09Mc1lKc2RZRmJVWG1QRHhYWis4TXpC?=
 =?utf-8?B?OE1Ca1RrRGEwR0FublFnN0Z0d3o1WkZYR3BxYXFGTGdQb1AzcDArbjdzY1pC?=
 =?utf-8?B?R0pCMkJkNVJhM291bHdiUDE2Z2ZKaWFHUmx1Y0ZNWmJibjlWTFlKdXArdWVu?=
 =?utf-8?B?T05ZUDM2T2t5S1UyOTRUWHQ1czJDR09XL3ZlaGRoTUQ5NFZWQ1IyeGFpNjZu?=
 =?utf-8?B?RFRrbWVCTFRYelNmV1Rpc0Njb0hSanhvenFyRVVERUpra1drSWdjMWdvOE1x?=
 =?utf-8?B?K0wzQ3lxdWRDdEpNdU1EU3NFS3lIaUs3ODJQS2pLWWJXSzB4WElWM3d2ZGQr?=
 =?utf-8?B?ejdybHNjR0NkSWxYN2dTWmpwbEltMmp2MUwxV0FrTXdQbzY4a01ZeUo0UUNF?=
 =?utf-8?B?UFEyNVIyNksvQjBJWS9wY0VDek1QYWtvY2o5WlppN2JDNVdLRkdzWlBIcEF1?=
 =?utf-8?B?cjlMMmJLejZqbW94R3hML1BheUFFR1A0OExORzI0a1Z2bW9BeUxNSG1uU1N5?=
 =?utf-8?B?UUorbEloRHBUS3ZGbjc1MG51OUhWeVo2NkltV09sazBRUFpVMW5KQjJCMXhh?=
 =?utf-8?B?R09UcDJqM0FmSDhjQVZwdzltZlBIbXFvSGtaNmtiSXZoVFZRNGgvYzZ0V3gx?=
 =?utf-8?B?SGgvb21hRWllVXNBc1MxYzBRSEJ0NVQwL2xGdjdLQlRMNzBiRDlTakpjQTd2?=
 =?utf-8?B?VnhHWTdxOXlxVkh6dkJ6YmxpOFh3QThmQjFQR0Evam5CaTRQMlpXWFpkRG1R?=
 =?utf-8?B?aFNHL1hIeGg0SGpBUTg0d21ZSW0zakpTekc2UnZhWlVqSXFZcHpHSWtmRTRP?=
 =?utf-8?B?WWhZR0hwSU0veWY1S0VNeDhBc0VubTE1TFlMSnc1WEloVEZFcHlVemp4UFZx?=
 =?utf-8?B?aVRRRC9PQ3ZPWEpzcjh3N1E2UENoa21iRkpvcERMRWdrMzduK3pBKzRJTDRa?=
 =?utf-8?B?emxza3prYnhnQ2tZYTZjSVRZck1ORmJSMkJFQm9aa3FnL3E5L253QTVnZEph?=
 =?utf-8?B?OCtnTlRVL3IxT2htVGdkMk5Sa1ppTVZkSkprcUUwaCtsTlJVVEl1TWJZaTUy?=
 =?utf-8?B?YlBxYVBtcVhhMHdxTVh0VXM1UjQvQjJKK0NjRnNURjZKZHRZckR1c2VaTmZD?=
 =?utf-8?B?YzdFRlYxY0RGc0wzS1JHaDFCb2FpVzdXb3hTZitQZDBtZHVlTjYwc2tOSlRr?=
 =?utf-8?B?YytWZWZqckZxakc1SWRyS2NsYWFyQkpoaGhOMkc4SmFKYVpjOWFLQ2RtUEtV?=
 =?utf-8?B?aTNSVmRvWWlFZFBhdXRYdGlVMVM1aXI4VGU4aWVTZHpaYXF4YXpqc0YzbVZu?=
 =?utf-8?B?a1dWL0dCcUpQVkZoTjRyRWtQODV5Y09JRzM3TndHQmJMcVlpRkQrcnJzUjZo?=
 =?utf-8?B?enloQmZiYW5Pa0plM2FYZGpuRHJiOHRTRzlESG51bU45dm14RmhEeFBVbHRn?=
 =?utf-8?B?QkZFVGlqZ2pINkY1OWk3ZEU3K3c5T1VlRi9iOUVCOFBMWkJub3JBeDZvV1lZ?=
 =?utf-8?B?NkhadmJKcS9Gbk5wUUFibHA5OHpLbkdtbXYwR2VKZjJuK2ZwUnRlRnRQR0tm?=
 =?utf-8?B?L2FQNmhVd2NBVGRlK0RralZjODVCYWJWUWhpd3gvTHYvR1pYNzRLWTJZanM0?=
 =?utf-8?B?L2h6MkZBazdUN2ZmMC9xT0ptclVsM0taUGI1a3Y5QVNURjVUNlFmVGQvWGVu?=
 =?utf-8?B?TURBcFRVaWlGc20yQW1xeERWTTdqVDdCcXVTQVpqdThidjZiUEhUR2ppQ1l4?=
 =?utf-8?B?RXdBSjhCTms3WUl0cHE0R2FTRTFLV0NVbFplK09CRXQ0aUdaWVlhNjBxVHJi?=
 =?utf-8?B?czF0UVF1YlpsNTlTRFFlYkl6bTY0dDdLTC9Bd012OCtmRnF4OEl1U2xjMmFI?=
 =?utf-8?B?VFBSazF3L2NUc3VmZWRydnM5UU5TeGsrZDBmeExqMjk2T2cyUGttSlV5cVhj?=
 =?utf-8?B?MHhZM0c0VDVRREx6T0NpblRIdUFhaFhleE8vMHdEUnRlUFdoT3JsNmdoTE55?=
 =?utf-8?B?OTB4c2NNK2FHRTZMZE0zUzFOTGs4aG1YbTV3UVVuR0JycEVGL3E5Z2hzS3V1?=
 =?utf-8?B?TndsWHAvajkxRGE0N0dIaG9pL1BBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T7B57wc3kLO5UymbzNglgzEJxzNs8wqWRVi7mQBND19oazBDARga096ulsVvhYssBEqFZrkC4PpylP77bxFP5M5QwspHz/DwRm08X07x8bfUAGmkm58IKQChiG2ngSDYgEZdITf8aR5ox7DwVfzdOYR0lnU//MWGduTcd268dENa69MKdPyuLmsEzIL7bTs3dc7MnYaeAPatY29FyRZnoyaoYkQpawrM6khMoPw+DqglyBbWv5JIfW3ZCCxoTsYYVv8pdEInrff3cY4BJ8OmAnJZHfKzSmHVXZWBtjuhC6q0bPV4FOrocQHlo7nuHw4HQocCIPHdweQRrwHZs2yVhot1PRfN5cDOo54KHMnIW6JRYnSqltKa5HD0xAaMPvu8oAmEPejJb4sYSujn98pvRpJPGc/lmFWypXA2fKvZeHa9x8XE3MksaRSkKK0yXxvofZqwBK3LUIy4LgdXkAMzFglwTmaCTuR/OJTr7TKB2WpTvO5t9ZEfuiZpl6Y5cMkJOkBh+IIWRIe9Zawjg3ZrMSX+/pKeVQMmos8HpRctEWTo/dmoyfeSluPiuld/mc+78wWVDl1Gb7+9uTRagikWvrkvyYEishxKUnzktN0qFs4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd123579-2c6f-459a-3bf1-08dcf52e351f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 19:49:59.0940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRVUcgN9+7Mlzs4ZVNA6l6YM0fIRa2Muzc7izL9f25SKp2q7YwTHry/wsp8s26yOdXRtjL4BJPzA0dH65ksVFRpf+qKrh6Y3gdA2D/f8IPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250152
X-Proofpoint-GUID: au3TLq3LyBi03uPJZ1d8vXKg-spnTdbR
X-Proofpoint-ORIG-GUID: au3TLq3LyBi03uPJZ1d8vXKg-spnTdbR

On Fri, Oct 25, 2024 at 11:44:34AM -0700, John Hubbard wrote:
> On 10/25/24 11:38 AM, Pedro Falcato wrote:
> > On Fri, Oct 25, 2024 at 6:41 PM John Hubbard <jhubbard@nvidia.com> wrote:
> > >
> > > On 10/25/24 5:50 AM, Pedro Falcato wrote:
> > > > On Fri, Oct 25, 2024 at 10:41 AM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > ...
> > > > > +static inline int pidfd_is_self_sentinel(pid_t pid)
> > > > > +{
> > > > > +       return pid == PIDFD_SELF_THREAD || pid == PIDFD_SELF_THREAD_GROUP;
> > > > > +}
> > > >
> > > > Do we want this in the uapi header? Even if this is useful, it might
> > > > come with several drawbacks such as breaking scripts that parse kernel
> > > > headers (and a quick git grep suggests we do have static inlines in
> > > > headers, but in rather obscure ones) and breaking C89:
> > > >
> > >
> > > Let's please not say "C89" anymore, we've moved on! :)
> > >
> > > The notes in [1], which is now nearly 2.5 years old, discuss the move to
> > > C11, and specifically how to handle the inline keyword.
> >
> > That seems to only apply to the kernel internally, uapi headers are
>
> Yes.
>
> > included from userspace too (-std=c89 -pedantic doesn't know what a
> > gnu extension is). And uapi headers _generally_ keep to defining
> > constants and structs, nothing more.
>
> OK

Because a lot of people using -ANSI- C89 are importing a very new linux
feature header.

And let's ignore the hundreds of existing uses... OK.

The rules, unstated anywhere, are that we must support 1972-era C in an
optional header for a feature available only in new kernels because
somebody somewhere is using a VAX-11 and gosh darn it they can't change
their toolchain!

And you had better make sure you don't wear out those tape drums...

>
> > I don't know what the guidelines for uapi headers are nowadays, but we
> > generally want to not break userspace.
> >
> > >
> > > I think it's quite clear at this point, that we should not hold up new
> > > work, based on concerns about handling the inline keyword, nor about
> > > C89.
> >
> > Right, but the correct solution is probably to move
> > pidfd_is_self_sentinel to some other place, since it's not even
> > supposed to be used by userspace (it's semantically useless to
> > userspace, and it's only two users are in the kernel, kernel/pid.c and
> > exit.c).
> >
>
> Yes, if userspace absolutely doesn't need nor want this, then putting
> it in a non-uapi header does sound like the right move.

The bike shed should be blue! Wait no no, it should be red... Hang on
yellow yes! Yellow's great!

No wait - did we _test_ yellow in the way I wanted...

I mean for me this isn't a big deal - we declare the defines here, it makes
sense to have a very very simple inline function.

It's not like userspace is overly hurt by this...

Also I did explain there's no obvious header to put this in in the kernel
and I'm not introducing one sorry.

ANyway if you guys feel strong enough about this, I'll respin again and
just open-code this trivial check where it's used.

>
>
> thanks,
> --
> John Hubbard
>

