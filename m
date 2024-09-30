Return-Path: <linux-fsdevel+bounces-30382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED14498A725
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 16:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B3D2828AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 14:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AFD1917FB;
	Mon, 30 Sep 2024 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FtdKYzAX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GxWxikDj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FCE23D2;
	Mon, 30 Sep 2024 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727706784; cv=fail; b=aRUy6yBhBONWaX3QVKYjOfPTky7mYIk4CB2ZcnmtqfJrzAu3vtb76a7LYmkcJx6xBDEAOG9Cf+EwbBa63B78aIuoGUEWEJPFwPpTEJE0Y3eeZ6GIPzpuCc0KnGDmgg21uMwz6grvbsGYvEIAon6INGyWzvGv7l+fgLt2iSRZ2MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727706784; c=relaxed/simple;
	bh=Xii5yab72VqzYwfuF6eAWOFqenBV+g+3OxYvhvIXt1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=itA4afhg+/nry34haHrKI1gcfS4n7E9aN9+ZjZwecPKNLu4ZAn8OFuPZ0DOffEVDoNfwY+VPEcwynGc52ofcAXppzDWXBwruaphYRHOvJppz9yAHA8W6dEIsS3kgWv64yghWAVy6IXP1yp45VKCM/bMZLN7KoyjkXmKektgAP6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FtdKYzAX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GxWxikDj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCXMkF024695;
	Mon, 30 Sep 2024 14:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=t6U3R/fz265Aqui
	8L6Ipg+c3qCtDj2da25C2xdpCgZE=; b=FtdKYzAXeXnZzgoKgOcpRQEYBbQI675
	EPnD+ZIBGIgh+DNt4ObOC645rqeFWhPiWcbkTyeFTBf7+rr4wi+GcpXnrW3SRTux
	9LDRtezfXjblVRQU+vfbdgr/aoEfC/g/T6KW0uYzo5jHAMiKXH7hzPBGB5WEBbIc
	4mUNHoJjW2vydmAmVjgluUrkOP4S2sGpDEkBp1hgvZ41wvCS0iqrxLmoZUT7cV4y
	Nn9dAbPAZaHQEqHoECW36SAEZsof4/Ua3BhZuuz2MpfIc/EiGqPX4kOaix+RgOwV
	2jFqkZjLn1iamZzoGBbLJkQ3ZdQb3e+gR4klskATu+DyRtfjNAgskcA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x87d3f9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 14:32:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48UEBtfd028604;
	Mon, 30 Sep 2024 14:32:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x886by72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 14:32:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4LP/0B4aTEHaduV2y7ZICjyrLO9AY2JqnxzynBaJU+bT2TkTdxHXVZyWge8TZd8XHJaxL3aX2trRinQ7eImXcBkn1PMj6zJU6wstG9/8QW0j9q9t6Qn6co7k3kB6xD2B2rEy1ioYe7kQiwXSRrWfxuKqqhWUPWShNmfbtMu6R7EGfVcjKBiaxi7zMr5M4MjO3w6I6wkfLCbgPsKnsGq0jTZVTueS5zbSYxhdx/oRcG/07fRWhNYQUNBgKjFkeYLHQL+zL0SCAmS/nM38Syj3cUsAuiDz/WKeac8L5VwzPAfxpFwK/NC7MFg4NYBlViBA5aFMm6W6y4r9TYBQQmnMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6U3R/fz265Aqui8L6Ipg+c3qCtDj2da25C2xdpCgZE=;
 b=Vg0iDS2W3LkKFwy9ZmtIYQV1urF9iK3w7BDA+OUy2Sk0kaERIi/shXBSfcUUgu0qJfAVcq1n8mQdXkFie4zVrKjox1oxfw6ICRwCS7qYSBQ5A/vgYNgQK6M9kBQleOcF5hRh7i6tlgo1YTWIQsOh9U37PKUj6YuSkodNlaY87PpepdbyWvBrY85+xl+veu3IBbyjA0uHO2mUzjccFbkDZfHHUMoNlj/JTQpW1fOz+ociToOr/0MDkvCWuJ2EIklkR/h6FGRHJN9F1P3PgIQUqQCEc7yNk3fpUi3Qz2F6yUWyZaGnzYE1dv0kR/TCS3Qdf0ft1LUsz2h3sBAOuvhFFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6U3R/fz265Aqui8L6Ipg+c3qCtDj2da25C2xdpCgZE=;
 b=GxWxikDjRLKM9wB7ZyUrh5jNKNcdYZL104JfM2iROyUtJ5FM5jOQOotfQvpw5dL/MPzabaYCUDtu37QKFCU7JuquBZNMK/gZZF3f1bdoYD2oILIUGMlqo4y9VBDuvj3h1VBUh94hGqkdVBDcLV3CpTIkrlDXODgwYYyuiQOvcuw=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH4PR10MB8003.namprd10.prod.outlook.com (2603:10b6:610:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Mon, 30 Sep
 2024 14:32:29 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Mon, 30 Sep 2024
 14:32:29 +0000
Date: Mon, 30 Sep 2024 15:32:25 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] introduce PIDFD_SELF
Message-ID: <8b1b376b-3c4f-409a-b8e4-8faf3efecdc8@lucifer.local>
References: <cover.1727644404.git.lorenzo.stoakes@oracle.com>
 <87ttdxl9ch.fsf@oldenburg.str.redhat.com>
 <42df57ac-d89c-4111-a04d-290dd2197573@lucifer.local>
 <20240930-verbiegen-zinspolitik-cafb730c3c84@brauner>
 <cdd24e6d-4300-4afe-b2ef-1b8ee528bccc@lucifer.local>
 <20240930.141721-salted.birth.growing.forges-5Z29YNO700C@cyphar.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930.141721-salted.birth.growing.forges-5Z29YNO700C@cyphar.com>
X-ClientProxiedBy: LO2P123CA0083.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH4PR10MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e57306c-6618-41a2-78a5-08dce15cb642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BdJlf3ZI/Y3ivSdj9g3EFR5Tn//TOXgEzwF+JmqF9KAUOq3H91VCyPIVhdCI?=
 =?us-ascii?Q?+i4/o4bXZIMA419HdW9PFanHJC80FyNwaRcvFsfg1lVLJhP0n2BQz/WHwPbP?=
 =?us-ascii?Q?GecP9GmouQjbR8wlHB+haf3JoLZZXpuiGVpYwjndd/9e18CQ+ebGXHdDpsVo?=
 =?us-ascii?Q?xLuD42Y2cfddVgBIdEGjvIY517UCIR6h9UYtRpXmT8GWt7GX+zTxppieZDJs?=
 =?us-ascii?Q?Uzb9ZR4iUIGQn8JDLOJfR048sN+wgHkr9PViDR5FqjIkxlRCG57R552eCzZG?=
 =?us-ascii?Q?qKcZqys/S6K9yenmDt2jNPedFglHBX9waLKOu8wPvRmrM0EJ8A5ZIcb+fdoR?=
 =?us-ascii?Q?ikoTsd0Zw09M725D8VeDLSih3n32YltcsGlBhEEFFiLsprkm2Chgj0tVvrWT?=
 =?us-ascii?Q?OHJ8XRzUnT2gkI0mmGid4P7phrG6x0a3fN0HJIAymAvVeP8cuduQOUm0uORi?=
 =?us-ascii?Q?Oe3vK/m7uoqC56FJtKcSFQ0hxjzN9Y0kIDjxD4ujMuj11djNZkEs1nWLdz0J?=
 =?us-ascii?Q?AMocaqV40+R2VNl2jCaA1Bc6WUipDXgxUlRnY+CMF/GsnBRamfgMwLJcxWK2?=
 =?us-ascii?Q?JtdUMXbT0um8E5MzT8YumkCYfxsWIJ+3spdJ8dN6+fSsvtWvdlX2gYLOuve7?=
 =?us-ascii?Q?kCHnnnVTdOzuhRc4coY8zFlHbKQKGyQcoK98Hz6+fYuAs1uSMY9D73rhEZSE?=
 =?us-ascii?Q?SC0MTuSgRCmMT+mQhcRoCfk4BfQHll6re9B9dPktX9VCDVJVvNEIStDzvYjT?=
 =?us-ascii?Q?B8GPYFsnxAPoU4WMyohl82eL8RTad97lu2OYMP2h6W7ip5pRk3Rn7nnOCYKh?=
 =?us-ascii?Q?TLGmGqwPTqCmLmLu43wBR+mWC0/l7fJXp2oSDRvg/WeYXiMbV3JpNcqGrAQB?=
 =?us-ascii?Q?3tbo6EGNIr64RMGyiiux2cgk2rAeut8NZsB9zZo4iMXbJkwXNyHL96mxZtuH?=
 =?us-ascii?Q?OU1AJMeDgN5zXEM6fL3HZan2RWD9BhueAYovanLw6LeCmQ8mgsLkx0n2JMS0?=
 =?us-ascii?Q?uCSVGM0+pT7ek/PaEKBTvnEr3etJDcLK8kj07jW/IsF7umfek61fzHAn1y5Q?=
 =?us-ascii?Q?sZoh7Qx06t8k4J3pLZtfFC/BDNl/VaqXsV2PEpG+C4KA0AOblh7TztKF4rkb?=
 =?us-ascii?Q?LRfZFfLBIkj93W1JwopNknRAIV3gf4YYdoOfVAA7Al3+DnFc3075ZZpvv24s?=
 =?us-ascii?Q?/3LdnhK9Kv9XTNpcjALx/hxA7WWkpUu9+e1Hid4XUeobCINLEjAL4jTiUNE?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9kuENzYVQ78sI0lLjKulCgMNOZTmr4XkcOLoxGUizsDTc3QPh7JLjEO8gQj0?=
 =?us-ascii?Q?xXCn3/EINIntwzrTQwHZEBPL/I4GKLIHKkrVSCSecgDEbTpH4wzsNyghaQ97?=
 =?us-ascii?Q?ajdZ1cJwDM7Z+nARKr6sPEVkg6zgVcrbrR/SUby8YKbe09oeGpvM5vEnqI2F?=
 =?us-ascii?Q?/uDB5pTbSNmGYe5gZ1GwfymYKGFXAtCFcrM+J8WHK/I/MdpBKcfQ9aJOFEBe?=
 =?us-ascii?Q?gwE++phoz6CfXN/lLRgn36CA/mlNJ1erdoMk8eBjylkKtWyk6QAC/HzjTbEj?=
 =?us-ascii?Q?ai9pc98fQz1CCFqefieCue2ntRZYMBC4PrOUVKLFH+VvPhN9fcA4Y3kzl8Bp?=
 =?us-ascii?Q?7ka3bQD1CwJlBSBiwwYGnFrt2OSx8ZNz8V0fpj25A58KplwPROnHRG82eBZ8?=
 =?us-ascii?Q?yxEFKUarRg7eH9PAaKEv+xtPoOeWGaZ+sbd4vIbUCuoMXLNOmO3Y0I2uOqQq?=
 =?us-ascii?Q?YJRgcTukryC9kpSwIPK6xXhrfcVibldT+uFxtdUGGDNuqweaCZkdi/9amFa5?=
 =?us-ascii?Q?A3fpeeFa1C4KNvjbtC3glO45XbSZ3NkLn+9EJvcoiiY7gjHjo7vN+aM0mu4L?=
 =?us-ascii?Q?bClTZYNbLjQllucyWcF/KxrBRr/LB2O4Y2mF5NV50IBTItIT9OBQfkkyC08M?=
 =?us-ascii?Q?3vQc0FfpOh7fvDuomLb4ly+XtCBRyz2qB+CoSURFnw8xQ16JwGP59GzxxXGk?=
 =?us-ascii?Q?3h4xqjv3e1JE33cW+hTenIuAASTCCgFfpSvNXFCwA+LO/W7UhEOcGQ6urTgO?=
 =?us-ascii?Q?hW+7eMssmZdPVTJ7hlhuExO1b3jTZAEzYnXHv+X24VtDnBAYT6PVnUmSl932?=
 =?us-ascii?Q?zm1dB4O4FT8vsbzMNIiVbWzOu3PiMj8mPFWyuy/hu7GywSucr8gLKKvzOIpV?=
 =?us-ascii?Q?lWjED6r+49wRBgn+YX193IeO070hSB/J+og6X5uYkLb1nspkJkPxBqdiLm4s?=
 =?us-ascii?Q?hjdYXK4lHq8Ha4aBzjf08MYLjG+TGDvOh+ek7ZEE0jhNAlcnzLg7ungkpN68?=
 =?us-ascii?Q?RbGDVZLX5Zvx8pdtxwBDq49I2X4bXXYSBhcWq0yXLCWUq/5RGeNjcI2JNhoP?=
 =?us-ascii?Q?qIJZpxiSvUe2g3ukXI6qsTft0EB5tN/gOGgQNYtWSWxfp52av0ncspWuj0AT?=
 =?us-ascii?Q?lvQbPXOkdUh1OqthcC5CgUYOo9s50L5BKSj1cKMVqckwvARs8ND37j66koVF?=
 =?us-ascii?Q?bM9R+iYqzNiQ5lNxXpsZUgOa8gKcehGgXH5HFVQZoHmcX1JvNdwQdVSUeKxM?=
 =?us-ascii?Q?eYAAaVhG1kAgqbwjgtLjA1j/TYwJrYEe1h5Qnaupmh0YPjlaOB9wA0luAK0e?=
 =?us-ascii?Q?00x7ITyeY78zICRV/JzIWxZavb265j+9jzTicUjf1WVGYG+0Pdgh5v5WXDTv?=
 =?us-ascii?Q?sEve3PpdySOpg/TT1Zx2qUIflj5ODPgre0dtXN/P6PgqXlDEEoZbMg6MC9CH?=
 =?us-ascii?Q?dyWZ3X62J2FhTm+rEURcbYAhC6Vul9Zdrvxy93/f4k5PIsXJ8CfRXFCS0AyJ?=
 =?us-ascii?Q?rdhH6QyEA/ozU4PwU1Ok5tSSy6nFByPTkOdP+aEVkGGz0j2WCBcB1B/A9XkE?=
 =?us-ascii?Q?jG9tJ+NSQTHxToOumxZDkQNNe1Ldo3ZCqAjAxRCg2pZ92HdLTJOmRpekOJWx?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pJGRbDUCwe7+vzisDt43fexMLfxoYWg4mgR5X3scPbQzeHHleVtLJzL8cUkYUWDrFNgqp5wZEu3a4NkDo63kNs/Entw1PFGXBrGg60pOXlAI+Yfhli/ZjlNfHaDuAVMDI86pxDbJ8pubRH07HT416AlFJSI8jXBRC3DlKoRIO6o1YCkBBWcw8855u2LiOgyJwL+GmTrUeW6ua/MuGZIZOgaaA30Np0exgJgB/HZM6Esn8tnRJD9R3wK+Nmk5uZU9PaFUzUBDrC0+qES5VDvbzebjC49Va4hCmWH9vN1IgJkGWdHGOiimUFxNfqsfZw42aW6dGJt4+yfpHKBVrNFZW/UlmkwDjqgGex5B3inoG70fuR98E5R2PlgBIPklgcGFK3vd2Nq1EeT93xpbRxyILEtJLyuvKC3PCrdQ2dVuv2uWHtAPRWl64jLHPzW9k54CVPn9zh5JWQhicG8ZTKm29EtUxS9iaAxshQZRvWzPh/cptuENfrqGXVwgZ7GgYDtZFK/BnsGc7lZb36tKICr1IpWt+eutgvNz2otzwJaE1CO8v7YPfU1A7Wcpq/lLC9HWMCY3IPElo+wnkZ/2cCF2t1jpYk8h7QemHGBj7zIZy+U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e57306c-6618-41a2-78a5-08dce15cb642
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 14:32:29.3586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQOcyB7aMpQ02KbZSeECXk9c5x1NQG9qeyItJIWgeeYxrn6BR25nGw5nw0CZzrL1nSyvdB3/m2JtnrBl4gq4G0Yboia8VzusVkZEv3ZHpcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8003
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_14,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409300105
X-Proofpoint-GUID: QLwbH1gLnsmVys-I_BDXnZkq373kPtIJ
X-Proofpoint-ORIG-GUID: QLwbH1gLnsmVys-I_BDXnZkq373kPtIJ

On Mon, Sep 30, 2024 at 04:21:23PM GMT, Aleksa Sarai wrote:
> On 2024-09-30, Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > On Mon, Sep 30, 2024 at 02:34:33PM GMT, Christian Brauner wrote:
> > > On Mon, Sep 30, 2024 at 11:39:49AM GMT, Lorenzo Stoakes wrote:
> > > > On Mon, Sep 30, 2024 at 12:33:18PM GMT, Florian Weimer wrote:
> > > > > * Lorenzo Stoakes:
> > > > >
> > > > > > If you wish to utilise a pidfd interface to refer to the current process
> > > > > > (from the point of view of userland - from the kernel point of view - the
> > > > > > thread group leader), it is rather cumbersome, requiring something like:
> > > > > >
> > > > > > 	int pidfd = pidfd_open(getpid(), 0);
> > > > > >
> > > > > > 	...
> > > > > >
> > > > > > 	close(pidfd);
> > > > > >
> > > > > > Or the equivalent call opening /proc/self. It is more convenient to use a
> > > > > > sentinel value to indicate to an interface that accepts a pidfd that we
> > > > > > simply wish to refer to the current process.
> > > > >
> > > > > The descriptor will refer to the current thread, not process, right?
> > > >
> > > > No it refers to the current process (i.e. thread group leader from kernel
> > > > perspective). Unless you specify PIDFD_THREAD, this is the same if you did the above.
> > > >
> > > > >
> > > > > The distinction matters for pidfd_getfd if a process contains multiple
> > > > > threads with different file descriptor tables, and probably for
> > > > > pidfd_send_signal as well.
> > > >
> > > > You mean if you did a strange set of flags to clone()? Otherwise these are
> > > > shared right?
> > > >
> > > > Again, we are explicitly looking at process not thread from userland
> > > > perspective. A PIDFD_SELF_THREAD might be possible, but this series doesn't try
> > > > to implement that.
> > >
> > > Florian raises a good point. Currently we have:
> > >
> > > (1) int pidfd_tgid = pidfd_open(getpid(), 0);
> > > (2) int pidfd_thread = pidfd_open(getpid(), PIDFD_THREAD);
> > >
> > > and this instructs:
> > >
> > > pidfd_send_signal()
> > > pidfd_getfd()
> > >
> > > to do different things. For pidfd_send_signal() it's whether the
> > > operation has thread-group scope or thread-scope for pidfd_send_signal()
> > > and for pidfd_getfd() it determines the fdtable to use.
> > >
> > > The thing is that if you pass:
> > >
> > > pidfd_getfd(PDIFD_SELF)
> > >
> > > and you have:
> > >
> > > TGID
> > >
> > > T1 {
> > >     clone(CLONE_THREAD)
> > >     unshare(CLONE_FILES)
> > > }
> > >
> > > T2 {
> > >     clone(CLONE_THREAD)
> > >     unshare(CLONE_FILES)
> > > }
> > >
> > > You have 3 threads in the same thread-group that all have distinct file
> > > descriptor tables from each other.
> > >
> > > So if T1 did:
> > >
> > > pidfd_getfd(PIDFD_SELF, ...)
> > >
> > > and we mirror the PIDTYPE_TGID behavior then T1 will very likely expect
> > > to get the fd from its file descriptor table. IOW, its reasonable to
> > > expect that T1 is interested in their very own resource, not someone
> > > else's even if it is the thread-group leader.
> > >
> > > But what T1 will get in reality is an fd from TGID's file descriptor
> > > table (and similar for T2).
> > >
> > > Iirc, yes that confusion exists already with /proc/self. But the
> > > question is whether we should add the same confusion to the pidfd api or
> > > whether we make PIDFD_SELF actually mean PIDTYPE_PID aka the actual
> > > calling thread.
> > >
> > > My thinking is that if you have the reasonable suspicion that you're
> > > multi-threaded and that you're interested in the thread-group resource
> > > then you should be using:
> > >
> > > int pidfd = pidfd_open(getpid(), 0)
> > >
> > > and hand that thread-group leader pidfd around since you're interested
> > > in another thread. But if you're really just interested in your own
> > > resource then pidfd_open(getpid(), 0) makes no sense and you would want
> > > PIDFD_SELF.
> > >
> > > Thoughts?
> >
> > I mean from my perspective, my aim is to get current->mm for
> > process_madvise() so both work for me :) however you both raise a very good
> > point here (sorry Florian, perhaps I was a little too dismissive as to your
> > point, you're absolutely right).
> >
> > My intent was for PIDFD_SELF to simply mirror the pidfd_open(getpid(), 0)
> > behaviour, but you and Florian make a strong case that you'd _probably_
> > find this very confusing had you unshared in this fashion.
> >
> > I mean in general this confusion already exists, and is for what
> > PIDFD_THREAD was created, but I suspect ideally if you could go back you
> > might actually do this by default Christian + let the TGL behaviour be the
> > optional thing?
> >
> > For most users this will not be an issue, but for those they'd get the same
> > result whichever they used, but yes actually I think you're both right -
> > PIDFD_SELF should in effect imply PIDFD_THREAD.
>
> Funnily enough we ran into issues with this when running Go code in runc
> that did precisely this -- /proc/self gave you the wrong fd table in
> very specific circumstances that were annoying to debug. For languages
> with green-threading you can't turn off (like Go) these kinds of issues
> pop up surprisingly often.

Yeah, damn, useful insight that such things do happen in the wild.

>
> > We can adjust the pidfd_send_signal() call to infer the correct scope
> > (actually nicely we can do that without any change there, by having
> > __pidfd_get_pid() set f_flags accordingly).
> >
> > So TL;DR: I agree, I will respin with PIDFD_SELF referring to the thread.
> >
> > My question in return here then is - should we introduce PIDFD_SELF_PROCESS
> > also (do advise if you feel this naming isn't quite right) - to provide
> > thread group leader behaviour?
>
> Sorry to bike-shed, but to match /proc/self and /proc/thread-self, maybe
> they should be called PIDFD_SELF (for tgid) and PIDFD_THREAD_SELF (for
> current's tid)? In principle I guess users might use PIDFD_SELF by
> accident but if we mirror the naming with /proc/{,thread-}self that
> might not be that big of an issue?

Lol, you know I wasn't even aware /proc/thread-self existed...

Yeah, that actually makes sense and is consistent, though obviously the
concern is people will reflexively use PIDFD_SELF and end up with
potentially confusing results.

I will obviously be doing a manpage patch for this so we can spell it out
there very clearly and also in the header - so I'd actually lean towards
doing this myself.

Christian, Florian? Thoughts?

Thanks!

>
> Just a thought.
>
> >
> > Thanks!
> >
>
> --
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>

