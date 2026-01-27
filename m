Return-Path: <linux-fsdevel+bounces-75610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFpqE2jLeGnBtQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:27:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D3A95A26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F2C130263F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A658835C1BA;
	Tue, 27 Jan 2026 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cdcuSRTl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wqY3YIoI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B197B35B64A;
	Tue, 27 Jan 2026 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524053; cv=fail; b=AEx5Y1QyMTJBG9EEKldJuQ+F7wIeWm4JfYSQ8IaQQ9fadYoWdrJStptmA4G+2aY/HRf0OgSVHFVNNfqgVkSjDLUgkvNeKizcepUGd8kiJZHN3humgGp0ixTxyPBVdX4cd4Sg29C8mt0mg96PgSAGr4c2ul+rqWKPyXGkRD1n064=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524053; c=relaxed/simple;
	bh=qd36weFqbD7Tr4pUnE//3m+39yNae0RZA/MLmiByXv8=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=ZsDb9ESSB1uMZuvdV6Vmgo3fH/NCb88AQy/3Du1540zW6T6K6SolsKEpxuUJk7jumuQbfkQjLSfGJ8SlSkyYiDGBamook865+wnReROSbHrTNN7s8+0YKFV8ICLF6HvVNoNRpRas4xinug4JfDNs+cqqoJg4zFTE/a+NfKYiEa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cdcuSRTl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wqY3YIoI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBELHc3922781;
	Tue, 27 Jan 2026 14:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Fa6eX2Nal3sMHOXzI+
	84N+e9LRBfK4Rc/JHYbsqPgDg=; b=cdcuSRTlfWymE1vSxVLgwJAxk7DZU7HUld
	Sjzdfzey9Wb9o/J9hvB/vCiwxB+QVJaRDir1HHfb7EiZm4/bZkaY8mz6Vtmvgi4l
	rbuI4UZoaSAxHZgQhDDaE1fRxTVmbat43NIBBuaSuQCDrGi/1fZ83r4qYIqlGj1w
	USZblI4KqfHroXds+4sVdBk98k15MA1qgAAR/r09cQwKXWvF9A1e58fG2X7mAvrU
	GJ6ogzVau3/QgJq+mFROEcA/AQBSmlwWmhByPeuswqMEqI31LMYYGi6hpkPtmZfJ
	BVle3rk/p8/gndXuaFZdNCUadCTYlwqE6o07/qkwY+2oodTyzdHA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmgbv3e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:27:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RCnF78020046;
	Tue, 27 Jan 2026 14:27:22 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhes01u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:27:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAO1JVEdHdNiLd5hUsgROz7DyuvtJKFfTjyyNWu9WcOPGCtrzZJCuQ/2919Y6JTEV7na+rnDJjmqmd3QgR+4ReeMhQGVeuk5SHlruWr/NeWaZZlXc0mY50OG1XBxnS2G+HfmJv3JxwbCyyNm8NybD4qpTFs2QWcz/i7Fd/Vk4a7iFFMLMJAOiyo/5NHuhwmpdw1igcPMe2qbYMYugJv3qr9qxHjOkyYoinDNDHL8LVnGvV4bC2AFkixiDGkIKJINPzm/rKlUL1qP5Qvv57Wxg9i/FW+9416OTMP/bqdFki10GXAWSxMLMTFXiHF2HEeoByorAz7W3tN3PzS/YMVKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fa6eX2Nal3sMHOXzI+84N+e9LRBfK4Rc/JHYbsqPgDg=;
 b=HAm6qXjG8X/usLmFzLDhL99qcB98DrjSiFEsrmvZjWNQYGRHMvx3TD+SQNcLa79VpaG7AELu41MyKbaJkQ3jwhSbV2ACQwkdj0B/8aXpAdXix8t39zImbHh3/pP7znTUwyr40Fu8hH6Rb7YwEq0dLTgW7fF43bDRewCiDO59Rqa80EzhwzTTmgVv/5AzO7KGrR34ILR5uYtYPOUQ7Ntyp/av9Fq0oUY0urLLAkBYTTDYr/EYV7fO0E0oRaB0ytKzHorbj1b/Fj2UDWgIeWBHSCLtGZIGTaiJvUMu+tLrhHKrGjeh3OvDjsb/rqkaJMTsv60w9yJGPKY48Av9uT2lww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fa6eX2Nal3sMHOXzI+84N+e9LRBfK4Rc/JHYbsqPgDg=;
 b=wqY3YIoIHOGxMjIGDHqUj2abgXV8l8qBWkzmbIeXyuIza4kvaMFh8/PvlKTTzIy9ceA9iNegareKKacPHG6I5pik9ygkDoJqDEei1fs2zjlERMcRkUR7/3hFYAf7UKLQMvlG7XCuf4E+k3BPRQWtCcED/ezk40n2r78Tla3E4rQ=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DS4PR10MB997670.namprd10.prod.outlook.com (2603:10b6:8:31f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 14:27:19 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 14:27:19 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Anuj Gupta <anuj20.g@samsung.com>, Damien Le Moal <dlemoal@kernel.org>,
        Johannes Thumshirn
 <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 05/15] block: remove bio_release_page
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260126055406.1421026-6-hch@lst.de> (Christoph Hellwig's
	message of "Mon, 26 Jan 2026 06:53:36 +0100")
Organization: Oracle Corporation
Message-ID: <yq1ms1zt9kx.fsf@ca-mkp.ca.oracle.com>
References: <20260126055406.1421026-1-hch@lst.de>
	<20260126055406.1421026-6-hch@lst.de>
Date: Tue, 27 Jan 2026 09:27:17 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBP288CA0025.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::26) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DS4PR10MB997670:EE_
X-MS-Office365-Filtering-Correlation-Id: 212c8221-10bb-4de8-8205-08de5db02d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eV9ZyU1fOaKtMoAaMF7hAVJ9m31IxdV1G5wIC5wM7Cee1DCCznW3S5PxjFaI?=
 =?us-ascii?Q?jnidV7gAkESf6/ILGc8GBLYPWZju1ew2VzaYOJaVzFITJL46Vz1u97cLZQRD?=
 =?us-ascii?Q?NI4u+6syD7mSgvpeJkY6CcaRDHqIzww9r+5EHpszt26OLgeRFsjHPPxgTm5Q?=
 =?us-ascii?Q?Ifz9A9iyhWBLLCAXeh1ZaarvO85tWAUYe8TcSFFT9vot9jep4mftKQJMXu59?=
 =?us-ascii?Q?n8ClwLKBtd2gIU2vWOBrdFWGYX/dVnLUYMR2ZkQjBk0BbiPHDU0YRarxZXTU?=
 =?us-ascii?Q?40EUOIURun6ssO6JEurrW/Zp2tYMXW38BChMi5S2gUA5hZ1cBW8JD8knEeK5?=
 =?us-ascii?Q?Ae2LMwNQWr3zdI4CR4sdtRrSCJW2ohQl5cNNKlMk7YrWib4zyCXa4Act5YMB?=
 =?us-ascii?Q?GPQYTj7hvbzD/ytxGfnwH9lbSLNZl0a1G6Hiv2Ntt00pu+GhtoB31CyJ8aQi?=
 =?us-ascii?Q?N7SnvkfUqKlZeSxqRmHOToFQ0Ycjpt/BHNalPunKy4coqSIR7aYKCKeQ+ouV?=
 =?us-ascii?Q?nQa/iDcpIJewyDby5dKIBrKAy0zCo+iDsZgDXzZU0HoP985s4wFO0gxhLAik?=
 =?us-ascii?Q?1QLUVExdgsWZJtfJKyEUDLZI/NtgqEYWdf39wHLcRL5LilyXkTX9ai+m8Ksw?=
 =?us-ascii?Q?MBuuolcsbD8TJUv6pbaRk7uMRY/oVjUuSFgLurLCpu4DYQ8aVt6UEd4cuW6z?=
 =?us-ascii?Q?Jw7Bj4ZHjLCVmM9t+/wSD7NnAFZk7Y/HJC5OGat8UZzl/W8YHGctDlmOju4/?=
 =?us-ascii?Q?t3aUMVkIU0EQ41C9tRQ38ksXunUxh8Y9Y593VDCJR3zKtJ5ykVnyz9y3t1Fl?=
 =?us-ascii?Q?RAZD7AkbwSfd8SV/q7prke83UCqN7q8+XGD3oysflnvCt5YgsWwZE7PIZjQ7?=
 =?us-ascii?Q?l2pklw8kGZ7njt9q+DwgP/lhr8vTStIZQ5XXdKR6we8iY4x9IusxUmWEsESR?=
 =?us-ascii?Q?QA1Vy8pirA0w/J4tyuOuw3jwQsGGH6EYOXFQnrrFdqPmuiHLPxGRWrFz/yDp?=
 =?us-ascii?Q?0Pu4JOhqK5MjVMDMjvEIQQUufafMzrA+TU8d1oSKqyQG6jqnkOjedawygRxY?=
 =?us-ascii?Q?I5FRevMClrYs5FjOWlNG+rF0w8uRE0AXERQwKlLvMdohV+XhheirOS1dm360?=
 =?us-ascii?Q?kcdOQUWZfesxicHokaTbHocpa0Y5o6OLhPBQerHpx34m+zYk+HMv/hbOlkOA?=
 =?us-ascii?Q?jdrUnaTOmsmWHoAfYuEZ8nVR6nTmPWHD1a3toOXnZhuq8QuxfwrZ9wiJ9JkO?=
 =?us-ascii?Q?ePkUqeIVRGc1GI3wHqSCSuYg7K/lVHuOEhNEnnxigfCTgswKWaVjfRLdVXkZ?=
 =?us-ascii?Q?ViljtTY4qC8Sc2Q/1/1tvIAiNSn/a7Fq51CyyChn2ZOTRMP+DPXgt6eAu6r0?=
 =?us-ascii?Q?+Ewh9oRMuJqyjLv1zGnbWIDkIJy242S/sleL8X6NVIRr2fLDc8eG+LSYD5Bm?=
 =?us-ascii?Q?gZuvlB4ZPr7ACniqcMLM0cem0JX27yKjNF0iXODYmWB6Lz4fOgJpGk8KWlxY?=
 =?us-ascii?Q?ipGeAqAd2rfWGsLH5crh/jHj+sxh0iSxlj1A/2K3b1akUG5oR8aqopqooGGH?=
 =?us-ascii?Q?Yjm3+QdL0LA5/Qam3R4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VCeoppNXki+jbpIQASW6CyL50C+62GfAF/QvtnnAWU8X4ufijTVMATzzm6Uj?=
 =?us-ascii?Q?XnckgalMP0ZEsWzFTRFBnmu71BUkpEForLj2fxhG15RA+hNeYCC9hKnAcGgv?=
 =?us-ascii?Q?HL8AY8W/eGiSGB3lnw3qu2l5TMjmIOadpfsVtZHlpcXURkttdKXC18hD6j4q?=
 =?us-ascii?Q?YkQWiLUMDqwNa1FRjuTCBPfMH2GXUpgpBG41kgzNrNDCwfJdlTiOx4J9MrPF?=
 =?us-ascii?Q?YORP0AzWwcogIlyIhEm1qEwHHqffYobKakkQlLXFzDH6cF31fcfm5ZKYFEr4?=
 =?us-ascii?Q?+JjosST3QjSxPM0q2RfUigC8wkFL3WmXaiTr2yRQgYlgEpQSifzvewRPJEt5?=
 =?us-ascii?Q?Rpp1vWiBMDP5RFkUMh+OoSvynNTjAqPtJN8Q72AbfGB3UHvH9vEP2qmISD0d?=
 =?us-ascii?Q?V+Ij/xBq/b94yBTFaD6d+rrhwogCP56TA4Q2xg5YJidl1fSZ0/97+96mcY7y?=
 =?us-ascii?Q?5SqWXBCjk1DGKizPCCkWe/HP56SU1QxF+coa9rVwEuAVEpe9jQry6SLXsKfN?=
 =?us-ascii?Q?8LP5qtNU0yyPyOSJWgkIBQCHNG8QIhDGE3oK9eZY+S4N0mbyYt8C9wBgDZJh?=
 =?us-ascii?Q?djayD3LheSTigCxIrY/PHXQ3q2CZBe6fvu20iDi3yZ+8Gu65DMqaTOXclfS3?=
 =?us-ascii?Q?YfVmh344p9UqK5MeH4kbgJeAHIPAUbCOzPxPKgNQR+/CsxefM/L7D3elyNy6?=
 =?us-ascii?Q?lBDfLfMaP5LTESP1qsihirqN5FA2Ko2rYTv77Kl4AR5583Pj00UWJxkPGCCB?=
 =?us-ascii?Q?CYw5MHaWxEeTurl+EYDmX4MnHNeqWM3nNa0aiEEwtMbvBGkIlWlj10db+k5W?=
 =?us-ascii?Q?s0NDLSEbrPRU9vXMC8TEOQ1IkDiZy7ZYhwOF57ULWqZsIzqWsd1WhemHjA03?=
 =?us-ascii?Q?OhB4TH6OKfFZjgWo8Mfft8XHNo4w3pSR+hW4HUc7l5Z1jeOi3WNcrqgyBDT/?=
 =?us-ascii?Q?tYUe1oDXCKOssYYJRDv/KWyC1fNAkhPTAJ149b+N1cL9wV9EF12MtWcJHGJ1?=
 =?us-ascii?Q?g3tNR51MM3V9AvEqu3hBjoeTTt/bKxnCrVJrucLrncLKdhhFhCyB88JA+up4?=
 =?us-ascii?Q?kcpefzKukdleNAdrjgKsizBwEQ5QJ4ic7Cc5A4lPCHKpPpgwIPJP2zUUlHe5?=
 =?us-ascii?Q?ksaYG2TpHjhECJU89Xj4La52LN+6sce3pGZA1jAyCKxT5O82qZGKFAqa2Rn7?=
 =?us-ascii?Q?vKYvLoMgb+pSD6v6J6crBtAikdxFn+oRwykcSDBTAAmHTQkrA9dErBZJyaZ6?=
 =?us-ascii?Q?T0LaunGJyParkgQRB+cUFkAYAAW8VcM21yVSfJbWIj3RMhDBuAAO+HhFLfiX?=
 =?us-ascii?Q?CSzMGiYLIDSrqw+1HH3Mb49Xa7hNoxRnuJv7HpeYXTiuqcFh3w84Hj+xvAbZ?=
 =?us-ascii?Q?huJWf+E04sWKLQYKyNpcIUlSDrvGDzaOIIJ2QnhrZzTs49Sb8ggI+Z9iSbac?=
 =?us-ascii?Q?j0NRwxVE5r1mSZbevUMBXHqNIH1ryjR3OJNqGRQRpHwszjJB1IB65P3a4GtF?=
 =?us-ascii?Q?jm8caqAqnlNzqCjqzQgrPXLyOa0oXfXvcQIX7StEPVcHgSCk7lm/jD+9lrzk?=
 =?us-ascii?Q?jkMD1VIk7ZX/DGQAjuIqFtjAnzREKuPdfM1TQIDpTAYU+z12TC/gixaLpz+1?=
 =?us-ascii?Q?EGZuxCxqP4RzIapeitJRrTeNyUa3hCuKb340cvjmFh0DzTHSp0T/6YRAgUjv?=
 =?us-ascii?Q?U5iZSKDVC2KOdXosRmeWKk44f9iW27Rd9XQv1FIaHAk7Fuw2JAvMKUgVlksO?=
 =?us-ascii?Q?WVTDEJHCV5p0ypW6RQchgTiSUhJ/MMM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AVuXOYSl9ni1X0B7idiykdkQXW7u8cQhFE2Q4CmtsfgFHe50au8qDhqjGpo0HDJ/4AKiHwNgFdMk/NfXojfNTti1Am3LoXb32cDcfgQYPtmBMhy+ZJV1kRsAXpeW6zLda9wR61GojeMKGAlBCH2yclVskQOGJmNIMIH6OfnwhmDT10u0Pz4X9l1AIKEr17+eO87HW0rELyegICL3N5e2F5TPl0bDrlFVkeWcSbxXjcclt2PC7lgOCulmlExYc2aR5aEufQF2vRLikAn7IC2WWdXkd2HdvJVp8A+9M7r3tp4oMQXPl69xN9LS0Y3ZL7ggAL10Gp7DEvInCTfhx4SoED5SKLBf//NiVTiI1ugUgENG6ctdj/eoPOBSKge5HoXf/0Drj+8V+sSu52D9T5HgVvsOvYNBU57tzHjhrvkdUZMHBVj47yb/xW1QAzwi2yrKm4a0bK3w25xH06leaGg3F6ZmT7oIglSh+xb3RoIySGzw0zT9COdPOKjhwnTq3C+Jwk5iNWwvxeWmsa5gXVoZo2AiWYKIupOPkd0OVM4OyUkf3/9rSZ0oh4Sc363BY24onjkmpR6k3PgGWxmYPZIFONJzaP4JN3Fz0D7UPKnKk8g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212c8221-10bb-4de8-8205-08de5db02d83
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 14:27:19.3842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipQtUi0Bbh41xHJO0BbIcyFhSmQMa2t9dBYA2gOdn1dwfu/I2hMVZPdw2jHdrv65+sCFgZBuo6COp9/YenoLKR7sNvyfNZMHzGWQm3KClIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601270118
X-Proofpoint-ORIG-GUID: kLt1X9bIriUarGMSamhqzoPnNoinhH-t
X-Proofpoint-GUID: kLt1X9bIriUarGMSamhqzoPnNoinhH-t
X-Authority-Analysis: v=2.4 cv=AqfjHe9P c=1 sm=1 tr=0 ts=6978cb4b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=5bH7z0BLeiDiQMqUfeQA:9 a=MTAcVbZMd_8A:10 cc=ntf awl=host:12103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDExOCBTYWx0ZWRfX9ROBOWAjmhOE
 BUUurKc4F9a6jOlegehJwevLa8D6+DnHTLkIRH7jNhkgTW+agGfchnTVZvkd8yO9TK+KTb0lS6J
 yep4YBleIZNFLcDqLm06ExiNQZXgvH/JsVUBsARJ/72T4lA7q8t9eK9up3LZXOb1EoFnIG/RWLr
 b52UQyxgRUwsOVNwxSTYXq1+W1jEWT5eHn/wOquAwMi4US/NNT37gfRLLuEpUacTP32GXyiKlYH
 EkI4FFF4yicggsFPz0gxdAtTkRB8ZO9yqEXf4eLH7Mr34NTDT6InTEnFUMjL3KU/mtAyl1v8Vqe
 m6hY9oClz60266ifj7tU4jWrz8RYyxnAMyUbD46JeHsrpnKlqGjkvl0KXA0wAdJKDaneop4zJ4w
 4XxOexrofjTE4/Pbm0MTDTDaW7ZSEaNTvXBcQokkrotFbUTLAHc47QX5g7Yl8yAU2uSZaWG05Tv
 6AZnRX0Q8RjMluCob7S+b4jDDXi8cHr80we+gfr4=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75610-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,ca-mkp.ca.oracle.com:mid];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B9D3A95A26
X-Rspamd-Action: no action


Christoph,

> Merge bio_release_page into the only remaining caller.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

