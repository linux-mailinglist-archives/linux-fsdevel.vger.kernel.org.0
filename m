Return-Path: <linux-fsdevel+bounces-54533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4801DB007C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 17:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870CF64582B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E392E8E1F;
	Thu, 10 Jul 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UyL8dIXq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="su3C3OXk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69F2E889C;
	Thu, 10 Jul 2025 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162741; cv=fail; b=ZzPohKctE/54apEWa5N0VoJ1SONKIBb/CyjntCHTJg54IIw5atqOCwkFS4FlVmgRFS1MXwVEV93vmcCg2RD3LJJaOuBRQPMEPewph+9k/8qinrjTTvzgN3m/PRbwPbZrGB+/hJnNyb6w0Bt7izFQDFn5duWODeGGRvlUQEuicww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162741; c=relaxed/simple;
	bh=WjIvaaak3+a0ZLQYpZMMIIPF1jwippv2MvpS0SDzK8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XfgO92qSw409kkf2pg+tlxEXSFDSUYd9Jg1fnKyy2hZoHXzisPYWTsq21SlPU3mK3I5JRPxtQM7Bww9KQDArAiD6sZ0bSKRfATg7TNy/4fj8wRRJWk8lePC1XV9Q8b4BcGjK0gRN08HhkkF/Xv6/5jXhpWK39vgUqfUbcDD/S6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UyL8dIXq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=su3C3OXk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AF2txB011988;
	Thu, 10 Jul 2025 15:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wLrC+vwRdPPXcPBcFwBvNGSjcZqJaEwUh3SicxKQA40=; b=
	UyL8dIXqJuPG7YMJXUCruIaaOW2884nz4/ZxwUWqw9xsqYqTEv9JT6jdqUzyTujU
	QxFaq15iBocikohCIdBvxgBvOZ01EqXwPRtcM/0/Etz6Ei20Kzwjzo17Nio8IWXc
	MZXC3D/5629pT1NsDQnEgxFvehWzhfFHKQWkl5MBJk4R7GzRcU4Inh0cykSFWJLu
	pJGH5SMlySKrp6FgMK73YDmBbKeyEDYmsM5At6A5mFqFoMqPKdwc2+0rFog4fkzy
	gjlH08jv5a+PaltDDUCwBz+x8DqAXiw52e0uy5tgKa7/gjRH6k9KdnSgiDTSZRVd
	iGyJNCL0LBEtAv15TAGaEg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tft083tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:51:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AERUUJ023626;
	Thu, 10 Jul 2025 15:51:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgcpwg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:51:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C08thwamT5TPeVsX6VhUi7M5bEmGeNlcZPeYcH/Cj9YRzlIv8PSRye60iiRuSbN9gEgL8y1CYKIRkU7gSa4NS1v9IVPVv+jEguQds3Y3tm41eRkaf34jESGgpcLZgVj8HOLhA5sz/e5Qa/SWGbSUsWKNJbFmmExrrVXfBBg6gQPcN9ypbuLDQaF3xS/aC7+nbaFlQOZf6J6fmysKUjunA7PkFICD/HZlR4dORJzohvO3Jpqt6Fu7ORMPGl/Q+Q/dwW1bAIUZnxaCfeiW7y9K9wLDxroWcHm31KTBEa1UewSlZzs0dUgxFksfK9LSBW9mvTQdYq7Yk5TdIKZeKAPBLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLrC+vwRdPPXcPBcFwBvNGSjcZqJaEwUh3SicxKQA40=;
 b=eWoN/u+H67KOC4PMfVaT8HfAf5erpOyKSLZqMrS7LTfqfSRdOMgmdj02EEQKZQrvYeCFEF8keBh4WUzF7I5mcgqyIHKZGRXnZCT3Ky0demc+pNl5wXhQQo7n5va4z1xhAADtbrsukoM8uDiYCB/jhli4uob08WOjIG2HwBD/Pe7B1PDb5GnOAPcByf5HjG/7kM4czCZ1y2idkt0UPfMoajriPH4c7wA5RyJ10H6aLlWk470F9pP1D2IsF4KxK/8XJp17ilRnPolekJKiyQMBr2oQTr1I+oyQSO/7d7QgTqxl9wr3hTroV68btiBEICKha8kPJaPIbPWLznzbS4qahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLrC+vwRdPPXcPBcFwBvNGSjcZqJaEwUh3SicxKQA40=;
 b=su3C3OXkjvW5QcR1Lvl9q1Te8Am6Egink5xuYAs7gp+OLiftarJ7GPzkA83TculdN3IxnWnXNenVdzsHQRKoGzzBY7G+cu/vrHCO76i1u5pHoLoRjks7jHrkjW5JWgSP8YBaslJoaLS09GWrRrIh0AtGsEd/9gih9FvdPejB15k=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB6769.namprd10.prod.outlook.com (2603:10b6:208:43e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Thu, 10 Jul
 2025 15:51:01 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:51:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 09/10] mm/mremap: permit mremap() move of multiple VMAs
Date: Thu, 10 Jul 2025 16:50:33 +0100
Message-ID: <6fe9dd2a366c7f55201320a81412f789ccfd675c.1752162066.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752162066.git.lorenzo.stoakes@oracle.com>
References: <cover.1752162066.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0156.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::24) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e16d6e-74df-499c-8640-08ddbfc9920d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vKM3iuMqKv5Gdy6PJPPFaUReTyQElMqLEqLpaAxWukB/B7mleUVYr+SN9Ya2?=
 =?us-ascii?Q?+wT6+d3e8IDih+hkD1K42uHwcIfasUAn3lInzKTaMjbSYRh9WP/d1QJou5Ge?=
 =?us-ascii?Q?b9UepuFAg/gCBubLA6gDmZIv9jl70iundtDXtj0IZQXpfr2yda/4vxjayJmx?=
 =?us-ascii?Q?0FtOVP74dtm5eJz0c4z9wfmNpICQSlBTylEyP3udWt8UiaHTOMnXuEJbFDrL?=
 =?us-ascii?Q?d7GdkI/39nBWZbeAyXSO/fI1T3CL9mmdXGszXiBcaf9s9yqa8SRt14bYb6ZG?=
 =?us-ascii?Q?0Vp4k9Ww275iqUrnOCTrfPBSR+QrFoL033zKiiePmwT2bEOE1JXjdIjUA8ga?=
 =?us-ascii?Q?de4+Wr5OJuLaXMDcHMlJr1OutalyfC0G7pZZRN70Q5dw3kmvPpklnN0exLr+?=
 =?us-ascii?Q?C3UxqPbfCqLVe9wjfYyGXczU5n9HRkEXjitMJ3yBO6H65q4p6o7gqBEzGTvz?=
 =?us-ascii?Q?7++g8XeCBZfEHQXYVFDqNEx80DSJSpRUSS67u3C1A+GGBrAnjqgl1g0iu4C1?=
 =?us-ascii?Q?XPRM+jg4sYwWsC3eZY7d3IxT2Qei/7k6XTz6zKHnPHjI9outbX/zYHuodOqy?=
 =?us-ascii?Q?gz0OtQcqVHXMvkleAQGSvZLGXhOpss3TSqQdG7kTUfOIX830PRhYG6cggm7b?=
 =?us-ascii?Q?AMGkVlinnOTYz6LL2WIblyRqUoW8EWXWDz80vFeJko4ugd4QncvttgcbAc+S?=
 =?us-ascii?Q?jOhtUsSMEB6+BOTwV2UZ169IpJXrXRxda9gZbERgptkpxpeBSIPkt6tTh77C?=
 =?us-ascii?Q?ttcXJPMj85lvQGPObHeN0pbtLHnUd71z2m70cLVbwIHWRrcHo1Ib0Ssp0Bwn?=
 =?us-ascii?Q?6kwpWMAk/6VNvcqAcauQ3hy80AKAwsGfnMcBWiHCWiuPC4z37vVsSShLLHvh?=
 =?us-ascii?Q?dpKQ8ebtyHSEujKDeMZ4Tr20yf8AOCb5Ek3cQ5x9F45OfPIol5oGJ+ZSzLPR?=
 =?us-ascii?Q?RHSWNe8EwvBXB+xq24TYm7EqpqjAv4MF1wLS47EBmHYF/sHbB2NEmGgzoadi?=
 =?us-ascii?Q?olfpaWuG0G2+oKhCdPe+GPh6Hh10X8kJZeNdlKcCs/iXBSV2fBy8fyPoL8K3?=
 =?us-ascii?Q?ST761D7D1H578dPPPsphtX3jQ9zLhlu5pUUTnoOPyNvfpkvjEDlc3tapZ/IS?=
 =?us-ascii?Q?Ue9zwKkIUteut7uv3I9ymEmY0/0as3KdcfOcvP0gIeXpX877jS6/iJZJ76RW?=
 =?us-ascii?Q?dMFTxlhQJtloVhOlPI+87WV0gFfRzw/dt/kXEnU+Dx7PExegWFaVS4r/1rRd?=
 =?us-ascii?Q?oLNtz5TmymMcrVRTZ2k7vAKrz/GhXA8oRklXJ6ZObekla0NBJZea1C/XDUSR?=
 =?us-ascii?Q?gQyatIjtSbCWdPigdt4rx1dgcd5UqUCSFY1pTEvzlCgHNmo2maM8Emse29j7?=
 =?us-ascii?Q?pIIJrdbwve3hO6JsZOoij74kGNqipBu2q+XkJ8neBd4rZf38+MboN+h9BdxK?=
 =?us-ascii?Q?iGTZk2BIIRI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TeoV/f380GvW+vBw9sNG3/VVM5dgeKjEsvR2lr/0z2P98ejUbmdv8Jqkh1A0?=
 =?us-ascii?Q?NhUhYop5fQtkUm96kUt9le2X5V2zL6Ae76cOCemB72dpr4sLpHsbOH7SlEcj?=
 =?us-ascii?Q?IjkHUUWUBCx2t7Kbp3dmIoktpFaq5oSK9poPbtA1u7wG9ZmvAH2/Tw2z9o+F?=
 =?us-ascii?Q?bwBIDABkPo+TtlW5izX86XLWq02H6IzUeG7deypwyDzF8KVjX7YcZ+cpVOQ8?=
 =?us-ascii?Q?+6sWhrYb8BRAo19Et26HIHHchahqH6dvKBkqxzBgwi/kXZlCEU7fpOx3yn1v?=
 =?us-ascii?Q?PFVB4sjroxufuzegcSvrjTPLBMc0YtqJOCZ+GNV9tiFyOjzOhrWlIT+bGEGt?=
 =?us-ascii?Q?w5AeYXS0zDuHnMoN3f7kMJZaVIe6kyRDPVfEYItu5cpZvbzObdDYMSLep2Hj?=
 =?us-ascii?Q?f/pxQ8n4dln+3XYrMrqgBpNDpgoekfI2QYVNTqRRJoyntpicTCcxvT1ziW8M?=
 =?us-ascii?Q?T9NUZCsSixxTx+jIue7nsg3YY6U9IFqo+QNHUtQ5vg3Td7jSyr/9wHc7qQCi?=
 =?us-ascii?Q?0peRhID06PbXFyMZQRGdmi4Gff2oHJXLiRuAEXHA4IinGIc/14UEBHoPd66u?=
 =?us-ascii?Q?jVz/WvZJm46V0qn2QHKkSFr0V3muWsWy447u/zh2H8mIMdfiegiJc0H8AYc5?=
 =?us-ascii?Q?d3lkDL4Ieq3ryju2mKY0RCuS/G2SMh9aAktwmorlEBKs/UJXKj3258iIs+x7?=
 =?us-ascii?Q?WE3f9X2cPjJMfylf0KdZBlwdqcjM4kwKJSox1BW3udMafrKTsNFiOxE0dDhh?=
 =?us-ascii?Q?+8LrSTvhu4XeVyp2sjtb/hTyDwg79hT45H5FAfdI79O/sKN7fnDrrXV0gfTD?=
 =?us-ascii?Q?SPWO2dQlM1E3ryuHhZajst3QovE5eJcvBBtISGVzH9omV3psYZ54C2PFU+k4?=
 =?us-ascii?Q?oSNEt/6D2PIJpH7pQSMJYBRY/sejq8WEeV4D7qC65W/x6XY12ybCKP+d4Tny?=
 =?us-ascii?Q?oGAMbj5TLL0Oitjg1G49bjqi/ClxZIEqi35FKgwxL9cI20X2+0uD0W1gydMW?=
 =?us-ascii?Q?BsLsGwJiYZh7hujgR9cDsPAV+6AUwYUSiw0+q7ZS6XR9pTU8AjJRdz6jSYGx?=
 =?us-ascii?Q?R2gJmpV+NKXZwM0ky2uNCmsyGn0d7OF5DIcPCx05BcZpf8hJWzyYe5XlupGn?=
 =?us-ascii?Q?5J2XBTchYoghWu0WuAVngC+uQ8Jo+HV21YgQuoXsyIKduJi8DsxiDMQjiG2T?=
 =?us-ascii?Q?syGLICT8Q+GO4zg5Zq5cgW1OxytuHneFExIZtyy67NpkTtL3jhFzZ2iVYop7?=
 =?us-ascii?Q?gAtZSSr0H7yli4CYdrhdF+ywhNb/BACNXm2CtGwGgG4TOUEhu5jHoCtzPC3o?=
 =?us-ascii?Q?gxBX11wknX1dyZ0HYLAcp59bGiMv5+ZG99/hcDyUdhvQp+LIYcwiZLtKF7mW?=
 =?us-ascii?Q?YXpQllrJYaQp52UAd47Oqnu/8tWXEJydPdRJAO4SvJQ2nszU13Kc9XOeyuvh?=
 =?us-ascii?Q?2ynhnSPxzm8kYFPm30yUZ1rHi4YrrA4AmELiIwwyQWVBM+LeZQpaLIjwfku3?=
 =?us-ascii?Q?Iq4UN4ap5HuaPrz+6TyZZ/cejgEQ4YKNkVib6YAXrwPgD4MuTpCnN/MM1iEX?=
 =?us-ascii?Q?sxLAbrzthqhcLVmmxUFEzegsFusXw5Yr6OamAAf5LJiMK4om2OmvmQtE7mvy?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xiwNtbpYK+Tk3dT2vU8CZ6b1lLENGW2Ik1S7qUHUUp+cInlqP6NP/NHzjLI4F5p3hgybuuWUZxxjDnIR/ovfnGYaP1F9ZCwwjDaqKf2gd4ty5yDfcnTcOrO0SV56piOh7le3as8kawnUQEW7I5/rXHdHkG9qGfSta4YDHDC7rCfp7fz/FPmr0Z0DDI3ImEnM7xBNCAhq09khglx4Jbg1dj7Isib9t5lvxSzqZOSe15UCv8Gy2Ydr6OzNaioBo0nN+PmSGRFsMNKxrJT7LfqokkOQbQrMOiVOgX9K4/Trva6n+d3FwNmmHvb3AwDLh2IFhsV+TetXFDo5JaUMBrpx6Uj2alyTG0xE6DlD8UT+oDtHA26q0kvOStcKb/ZDM6lp31gV9bQDGC2NjlqgJu60WQ5HpZxYFrHSvRNY8mB14yHViMoA1az+yw3O/aIIiZX5iJicG3gJvciuXP9uYlAbhKzfm2Yh9zY4UwdpX58llhMNeN/xXOyIO2Ft3EhXZwYW/oFN5QME8GKsbagSwgFv7e8ll5Wwm4Jx6Eowy8RzuIiCe/TIrChvHcsZ9/R5yPanSfWks2auoUdA/V0QkzpdPzRmPlYSwlmdz+EFKd7MkKA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e16d6e-74df-499c-8640-08ddbfc9920d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:51:01.6876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3PqZzBpGu6Q7j7cSFHuYKsh3EUWUEcA6fpgLSE9c2iuaVeinegivICLnAS6xS+ZgjMHAr6VTIL5PI7c53tJE84gvnwMh60NwzY2H/ymfI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100136
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzNiBTYWx0ZWRfXzvC9fYH+Rsb0 kzaayej4gYr+qUbBua2AL/C4jZmB4kIckaqFvpyWOyPHYsC5evFDckJTYzG4XFMMZi8qQXq5sk5 hnFjq4u/kK50X2w/GE39ZuKPS7T9lQ3LC+8P3WbsWLYJ1aew2CvzEqFFFYyQIUxRW3gEz+qz0mR
 +M9eRMoQx40Fnl0JIaxoQYPX4xl07X7R+PJ+keQGzhMD9iDfz8uAT28wrn5gpCxoD8CMyDSd6xn jhjg1fRQ41gE+Y56aBnjaetozjvSEbaXcV8hU8lpzS59zobGXjgoypAqRBEefquHygmc6UzsjOC Wp1hfDUsnusyQEJ0WjI9UKXLKZ6JaHgKu7jZ6qtvi5vRO5wJvmKGaXEQB7Wl1mc7yNJy1im4vV3
 ze4ilzjaDvWHMkrhZtbVef4O2ms/Tu5gkkOFxKK9WTeqTh1FN/lLYRSZPUfmIAOXO/q4xKIY
X-Proofpoint-ORIG-GUID: kUeBEkcXRU3p8mWPi9oFXUp52VGiRov7
X-Authority-Analysis: v=2.4 cv=cvybk04i c=1 sm=1 tr=0 ts=686fe169 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=0r5cTyXUqGrpW3ZitcIA:9
X-Proofpoint-GUID: kUeBEkcXRU3p8mWPi9oFXUp52VGiRov7

Historically we've made it a uAPI requirement that mremap() may only
operate on a single VMA at a time.

For instances where VMAs need to be resized, this makes sense, as it
becomes very difficult to determine what a user actually wants should they
indicate a desire to expand or shrink the size of multiple VMAs (truncate?
Adjust sizes individually? Some other strategy?).

However, in instances where a user is moving VMAs, it is restrictive to
disallow this.

This is especially the case when anonymous mapping remap may or may not be
mergeable depending on whether VMAs have or have not been faulted due to
anon_vma assignment and folio index alignment with vma->vm_pgoff.

Often this can result in surprising impact where a moved region is faulted,
then moved back and a user fails to observe a merge from otherwise
compatible, adjacent VMAs.

This change allows such cases to work without the user having to be
cognizant of whether a prior mremap() move or other VMA operations has
resulted in VMA fragmentation.

Having refactored mremap code to aggregate per-VMA and parameter checks, we
are now in a position to permit this kind of move.

We do so by detecting if this is a move-only operation up-front, and then
utilising a separate code path via remap_move() rather than the ordinary
single-VMA path.

There are two tasks that occur outside of the mmap write lock - userfaultfd
notification and population of unmapped regions of expanded VMAs should the
VMA be mlock()'d.

The latter doesn't apply, as this is logic for a move only and thus no
expansion can take place. In the former case, we explicitly disallow
multi-VMA operations on uffd-armed VMAs.

The mmap lock is never dropped in the move-only case, this only occurs on a
VMA shrink.

We take care to handle cases where a VMA merge has occurred, by resetting
the VMA iterator in such instances.

We needn't worry about self-merges, as in those cases we would, by
definition, not be spanning multiple VMAs. The overlapping range test is
performed on the whole range so specifically disallows this.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mremap.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 125 insertions(+), 7 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 8cb08ccea6ad..1c88ed7eae0a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -69,6 +69,8 @@ struct vma_remap_struct {
 	enum mremap_type remap_type;	/* expand, shrink, etc. */
 	bool mmap_locked;		/* Is mm currently write-locked? */
 	unsigned long charged;		/* If VM_ACCOUNT, # pages to account. */
+	bool multi_vma;			/* Is >1 VMA being moved? */
+	bool vmi_needs_reset;		/* Was the VMA iterator invalidated? */
 };
 
 static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
@@ -1188,6 +1190,9 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 		*new_vma_ptr = NULL;
 		return -ENOMEM;
 	}
+	if (vma != vrm->vma)
+		vrm->vmi_needs_reset = true;
+
 	vrm->vma = vma;
 	pmc.old = vma;
 	pmc.new = new_vma;
@@ -1583,6 +1588,18 @@ static bool vrm_will_map_new(struct vma_remap_struct *vrm)
 	return false;
 }
 
+/* Does this remap ONLY move mappings? */
+static bool vrm_move_only(struct vma_remap_struct *vrm)
+{
+	if (!vrm_implies_new_addr(vrm))
+		return false;
+
+	if (vrm->old_len != vrm->new_len)
+		return false;
+
+	return true;
+}
+
 static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
 {
 	struct mm_struct *mm = current->mm;
@@ -1646,10 +1663,29 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
 		return -EINVAL;
 
-	/* We can't remap across vm area boundaries */
+	/*
+	 * We can't remap across the end of VMAs, as another VMA may be
+	 * adjacent:
+	 *
+	 *       addr   vma->vm_end
+	 *  |-----.----------|
+	 *  |     .          |
+	 *  |-----.----------|
+	 *        .<--------->xxx>
+	 *            old_len
+	 *
+	 * We also require that vma->vm_start <= addr < vma->vm_end.
+	 */
 	if (old_len > vma->vm_end - addr)
 		return -EFAULT;
 
+	/*
+	 * We can't support moving multiple uffd VMAs as notify requires mmap
+	 * lock to be dropped.
+	 */
+	if (vrm->multi_vma && userfaultfd_armed(vma))
+		return -EINVAL;
+
 	if (new_len <= old_len)
 		return 0;
 
@@ -1746,6 +1782,84 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	return 0;
 }
 
+static unsigned long remap_move(struct vma_remap_struct *vrm)
+{
+	struct vm_area_struct *vma;
+	unsigned long start = vrm->addr;
+	unsigned long end = vrm->addr + vrm->old_len;
+	unsigned long new_addr = vrm->new_addr;
+	unsigned long prev_addr = start;
+	VMA_ITERATOR(vmi, current->mm, start);
+	unsigned long res = -EFAULT;
+	unsigned long last_end;
+
+	/*
+	 * When moving VMAs we allow for batched moves across multiple VMAs,
+	 * with all VMAs in the input range [addr, addr + old_len) being moved
+	 * (and split as necessary).
+	 */
+	for_each_vma_range(vmi, vma, end) {
+		/* Account for start, end not aligned with VMA start, end. */
+		unsigned long addr = max(vma->vm_start, start);
+		unsigned long len = min(end, vma->vm_end) - addr;
+		unsigned long offset, res_vma;
+
+		/* Merged with self, move on. */
+		if (vrm->multi_vma && prev_addr == addr)
+			continue;
+
+		/*
+		 * To sensibly move multiple VMAs, accounting for the fact that
+		 * get_unmapped_area() may align even MAP_FIXED moves, we simply
+		 * attempt to move such that the gaps between source VMAs remain
+		 * consistent in destination VMAs, e.g.:
+		 *
+		 *           X        Y                       X        Y
+		 *         <--->     <->                    <--->     <->
+		 * |-------|   |-----| |-----|      |-------|   |-----| |-----|
+		 * |   A   |   |  B  | |  C  | ---> |   A'  |   |  B' | |  C' |
+		 * |-------|   |-----| |-----|      |-------|   |-----| |-----|
+		 *                               new_addr
+		 *
+		 * Now, new_addr may be altered even with MREMAP_FIXED set, due
+		 * to e.g. alignment changes from get_unmapped_area().
+		 *
+		 * So we map B' at A'->vm_end + X, and C' at B'->vm_end + Y.
+		 */
+		offset = vrm->multi_vma ? vma->vm_start - last_end : 0;
+		last_end = vma->vm_end;
+
+		vrm->vma = vma;
+		vrm->addr = addr;
+		vrm->new_addr = new_addr + offset;
+		vrm->old_len = vrm->new_len = len;
+
+		res_vma = check_prep_vma(vrm);
+		if (!res_vma)
+			res_vma = mremap_to(vrm);
+		if (IS_ERR_VALUE(res_vma))
+			return res_vma;
+
+		/* mmap lock is only dropped on shrink. */
+		VM_WARN_ON_ONCE(!vrm->mmap_locked);
+		/* This is a move, no expand should occur. */
+		VM_WARN_ON_ONCE(vrm->populate_expand);
+
+		if (!vrm->multi_vma)
+			res = res_vma;
+
+		if (vrm->vmi_needs_reset) {
+			vma_iter_reset(&vmi);
+			vrm->vmi_needs_reset = false;
+		}
+		vrm->multi_vma = true;
+		prev_addr = addr;
+		new_addr = res_vma + vrm->new_len;
+	}
+
+	return res;
+}
+
 static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
@@ -1763,13 +1877,17 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 		return -EINTR;
 	vrm->mmap_locked = true;
 
-	vrm->vma = vma_lookup(current->mm, vrm->addr);
-	res = check_prep_vma(vrm);
-	if (res)
-		goto out;
+	if (vrm_move_only(vrm)) {
+		res = remap_move(vrm);
+	} else {
+		vrm->vma = vma_lookup(current->mm, vrm->addr);
+		res = check_prep_vma(vrm);
+		if (res)
+			goto out;
 
-	/* Actually execute mremap. */
-	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
+		/* Actually execute mremap. */
+		res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
+	}
 
 out:
 	failed = IS_ERR_VALUE(res);
-- 
2.50.0


