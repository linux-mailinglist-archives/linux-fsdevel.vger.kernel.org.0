Return-Path: <linux-fsdevel+bounces-33800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017049BF08E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 15:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67D1284715
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3039A2022D1;
	Wed,  6 Nov 2024 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DAhbLulk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TKWjMMjF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D028C11;
	Wed,  6 Nov 2024 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904279; cv=fail; b=Vzh07lDueVFpt7kZl3U+82TzZfHCN4fkB1EzdKIJbuluf0jiHF2hpeSn0RXw2ljZCTh4jpm5IIaBcUn1ksxBkzyf3K5A5g4S3fuzy9IbmfWrAzhqPeZhaDEEc1K9ySuIV9gkqJbAkGfgwDga2cAyK0jenyVPvo65PAma92ouZ3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904279; c=relaxed/simple;
	bh=SnwtulawzvAMzBmPRPb0dCRtWRGUdrv/6uCFyFxBysE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PaLLh08H09/9Zxbi7avzdbQFPCfrP5BULglHPW+XUv3lgTMGpSwaLeM8Gq05v5+JLB69rYgDYXnfS2UOmWll2H93crpG4SqY4A7CW4w2nYM+cXKRzaikgGnP3hqXHj051+QZddpwMM3NV7S/ywOOK5svFdiySd33u8Pb01+1rGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DAhbLulk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TKWjMMjF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6Ci5bN012886;
	Wed, 6 Nov 2024 14:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=9RyE9P3GaTIotvb8ev
	0hOJy7/Ni7cr8UqPNPRU2qkaI=; b=DAhbLulkqblAVXshYhXS0QjweQ6oFkAl4D
	GnyTGyM6PGno9dq4UsZMe0Po5Ds7c/jArTo1hfss2hE2BRnUP/5dXSmg1tHloWdk
	mQJaGe/uqF+4d4fT7xUeUMr64Bl7iGmcQ2/0oFlf3DbNu1yFbfvrUaRl8BZs6Dgv
	WvZmpHqFAbUdkWfHmog+UNVvMT8aaqBPN7NBY/bf+9vBFHVcM+cUsizmzZEtSs6d
	TDlrVGzlCCbqFBI8vlJryZoiCc9ETu+OOEP1ewLLbghAsBRk0DSUCxknEPmlQ24o
	wIDbJ6O7+gbca0xs7YeCBPImqVGdPIUMcm8pBWYmwRafOdtse6IA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nav282mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 14:43:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6DNlMK008500;
	Wed, 6 Nov 2024 14:43:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah8m0kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 14:43:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4LJZ++gqHMRCTkjA5c2N/VLIGMDvqdZcX4wvDXNOPLS54Mpjs1G+vM44wk/PiVzDLMSzBiNNGRX1sH3tdNm9lYT4zhkrepnmraODKAguukzgA9GSu3fY+RoTH5nC1bqD0gOmp5byNgzc9Mdl8FSRU9Z6ebSj/+YCUhBeT50fSV0osXPSYJpa8VuY/f72/zUuu2ywsuim4FMJXn5gDsOCMq6ewZvUFHGVwNttP4hheXpWXGNoHWkSKMAPE57PK+aU/lKj/LhVrQoOaxjhEicthJJSty/CIWoaFhH3ZwzyHGema/7o0vYsuaNbN4mx3YK8HyfFj9ulOdoxP3DKUj/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RyE9P3GaTIotvb8ev0hOJy7/Ni7cr8UqPNPRU2qkaI=;
 b=LuBusThFJmjIZwZR+IljS87+BbG/fsWmU5W+T/w0ti1IuN1rucXvINa+csUeimRM77yMY1KxwsbxYyGBbKX5pPqySYfeTo5E4vYRv8NFxOkF9eo97VYs6c2/FFgJmOl3Rqj96Cljl6gU0PbkksJDiS4XH5Vo4JQ3PqoYxG49m42t1Xx2IwMCThYZ0MHBxJ7C0KzoOYL6ukjd0qyA4Jl5WG4rS5Fp8zhj6ngzzcCiXVTU4FBcqMt6jaohbDSecNnfXkHIWGDe7H+jxW+Y1UNYsYcFD/iYAFoCdJzp8DNgJHRz/ePibIPwY9fCeUeMhg8vknvCV/oy0/jJK4pa5mNwkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RyE9P3GaTIotvb8ev0hOJy7/Ni7cr8UqPNPRU2qkaI=;
 b=TKWjMMjF+wUifkrkL8fn5xw48r+3P9pM8QdRkIvuAp+o+Oq/C+IxV1NJT/kcpkz68mcvL5+sNWV3ZXHDHUP/p3MpDmnc4iExC566B3U8BFN5UHEOvmvSw2SNlsplfyyHkZ2e6aEnnk7As5aqUvg9+2vwrDkteyZkvYWCc8S8La8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BN0PR10MB5095.namprd10.prod.outlook.com (2603:10b6:408:123::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 14:43:07 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 14:43:07 +0000
Date: Wed, 6 Nov 2024 14:43:03 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        viro@zeniv.linux.org.uk, brauner@kernel.org, Liam.Howlett@oracle.com,
        akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
        sashal@kernel.org, srinivasan.shanmugam@amd.com,
        chiahsuan.chung@amd.com, mingo@kernel.org, mgorman@techsingularity.net,
        yukuai3@huawei.com, chengming.zhou@linux.dev,
        zhangpeng.00@bytedance.com, chuck.lever@oracle.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 6.6 00/28] fix CVE-2024-46701
Message-ID: <e7942272-9157-4baf-a3e4-ac5957f33cc8@lucifer.local>
References: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
X-ClientProxiedBy: LO4P123CA0413.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::22) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BN0PR10MB5095:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d4f13f-805a-42d1-6036-08dcfe7153f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JLSF6PXT3Eka+ePTyd8ZwODcwZE05L0wbZ/Qj1qcsqlMKuNt14NstvnhGRmC?=
 =?us-ascii?Q?48bKu6J4sSMDc9uXfAk4qaSmarM5mvKgjy+QtTQqs161z/geTkdTIoAGmhH4?=
 =?us-ascii?Q?/OpKquGErmEnP4e3Ce5rlrKfVghYDhhAQWNx7CriAA7lH5Ivs3WXAvN6+qCe?=
 =?us-ascii?Q?ITesjm+FV1yhDZyuIjHr0lC/TpNNwQMqUSn5tyRTD9fCTj9LdCOZx2kZ5wFn?=
 =?us-ascii?Q?T18FMdSoXol4J4uaxyi7HKarrpMxaU0f9clJEbUAcF8u7ees0Nx7AUol9BPC?=
 =?us-ascii?Q?Oenx66BnOJie/sC2ObA7P6mGSyZpH3qAJhS4ATwonIqk46otFSY5K5EUwljD?=
 =?us-ascii?Q?F7vEHDSpQV4ipT+j1viFvwZ/F2Cc5h8DuIY0v88ABodQ6mW2S+I4h9UZqEOR?=
 =?us-ascii?Q?5xHstJBBA+uT4YEz0aMbrCKjCPLLnTlH0/AF1rCj6yaUYyVUHnryEYjkZdAn?=
 =?us-ascii?Q?2D8rXZTQ85+sIKxfErAk5Qs8CYTscB9x893JOi4IF0MgkQElF42MXGXcm0jK?=
 =?us-ascii?Q?ZeNIeKkZMCPFhuwTPgz1TB1slSRCZrNjdJ3/bYdqJgbqSdEe1zP6QaAvo7zs?=
 =?us-ascii?Q?26IJZjPrEE1diTRLX0r9uK+Aoz9lw+VdS3FQ9Spvxy3eQzmJGHftrLeFxXvl?=
 =?us-ascii?Q?vEWmSEWNMo7WbeHorX9nywvHFTGWYDTW6Ml9S4AjCuT5MjrnooDqZvepixHm?=
 =?us-ascii?Q?ACkAc0K4r4rmh1hRSjtgj9yiiBoDFAeQGny9O9AEulzITpCz419m/OYBebx4?=
 =?us-ascii?Q?+eXAIidhHWBERgEj/wHUAlegbSqMAT0SzIpd0hiU9all7N4z4OAFrHeDXO/7?=
 =?us-ascii?Q?o8rb0pLJ4VKarxrHTpD0+NOtSQJ9/V42zHFJwLy6WxJepi5RePlOqifF1pnA?=
 =?us-ascii?Q?zQbmluVJ1KBkelnPRwzY1LkeRTfeH8Or12OUmxBs1zy0P5F5yv/ZlC4k2WKx?=
 =?us-ascii?Q?XXvmnEaJuxE7++kuYAVCEpvqTXtyq274WZa8G2Y0s9MfYu5GT7vNrEXw8O1g?=
 =?us-ascii?Q?Xt/PvgzoV/04OzPWp45eCMEOhsXi0GbH3XHAHIQ/0VK2rZxc2r2CjXobDgl4?=
 =?us-ascii?Q?gsSmc2PxFISxmpZyYriC9X1UMNpyIx2ywBc8CT97ZXcMQoJixU2G2s+dGOcY?=
 =?us-ascii?Q?UARu8a58+nhBltK/2rN6AUYZ5SLM7VCefVBXJagAByJBRZOGE0ksC+gPCobr?=
 =?us-ascii?Q?YS0tBknBOf1eR3FyWl/zIbaLw3n913jVi+EZaIhXTxOmKwUnFUK+cx/KqK+f?=
 =?us-ascii?Q?lXy21z1wlNJOo488I9i4dKeYTiGyqt+p8yhA49yCYtc2N9qRWdtAom04S/OS?=
 =?us-ascii?Q?Rce9CQfvhaxi3rQWvgY7neEC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kh6ejUS6qtvV1rb0KhCQ1EmgdHrTl6yAPMO2rrTDuXpIKdZlbEjwaAWaeO3A?=
 =?us-ascii?Q?F9KJArUPbTl7mZavYwidsglQ1Y16/FPOUoTTXTSEV9zdArZdbg6FlXAgZEkN?=
 =?us-ascii?Q?UVrt9TtMQd0Dk09vpYlONlwuaH5K1vGuICWSh5aGUFhce0+VmBIeflaKJWgo?=
 =?us-ascii?Q?B3irZuldoy47W7209PnZXjHnsWeC+hjki2vD83Le8oLvby65NNSZCT4CThuw?=
 =?us-ascii?Q?Fh6bcUkJqcUfD3V+Jq7+ey+YG850vYZFvcvUMnRroPeiC/DpqhPfDHGwfSdm?=
 =?us-ascii?Q?BTbedYQiK64BpeuCiOyPuQPJmxzjf3u+1GRfPoDmq2yOgQmNztD89y/22tlt?=
 =?us-ascii?Q?fStIAD55pwc0RBSF0e5BgUAeo0V5d8O3BYkO6CVRyrjTL6iTvCylTySeMdgH?=
 =?us-ascii?Q?G/HETXjs+5G91c6thO1GQ3tZ6qOWEU4fiTMHP2O/AZ5h1OhxWQqNKVMFgn1y?=
 =?us-ascii?Q?xVaFV04ZkMDPnncMjgKtlEOq08/CYfuRBRDCRedMSqVUAbze3/xovRizNrdd?=
 =?us-ascii?Q?zT1QJUHRlOTwmI0ss6e5vMlmOY52BZSzDKBqAzEMYk4yux/rUCQ6ZrPG3jBY?=
 =?us-ascii?Q?YVAz0Cm57tyq0FhXIGXdI6/ibP1RrlbCeR2BgP8fxgTGizchCy7g7RnmhOFu?=
 =?us-ascii?Q?4jZaMLJAavCYsyrdw0iYTtyDSbbY8zLG1KBttP92/nbmt0TZ/PxTTJe9Q9CE?=
 =?us-ascii?Q?YU9YUZpN/icYo9Lf/15eMVrX9PzAcgBpTeyNVFiAODpHHzuuFlaCtzSaIUc1?=
 =?us-ascii?Q?nZDJX8KyJtGPO0zwLX+GieLirtKo7BpaFX8ZUkGdPhIm4ApPcOLUUBse8FKr?=
 =?us-ascii?Q?/KKE9xZ5/R/IBlwwcDFgIpp8xA5sLCl8IzkeKkPMlSUhxMXgRuytbSfF61fy?=
 =?us-ascii?Q?+8A3oBPKSL0BJt4UQhhPMM9UuS0SGRgN1Kd4ykpJGJRFzUa+cfsH4I3q5E2+?=
 =?us-ascii?Q?kqB9eO4kD4fYSpUk9tYTRU95TO0DJHKx+/1nbmNX4V25Mmr/9q3YNt1dhdDA?=
 =?us-ascii?Q?I/ID8zQ374wcRgnOCpwbGmz+onzIjRJGbhH8llRM7jijMHSM0MxJV97HHFWu?=
 =?us-ascii?Q?kXyIaGjsMTAUegkoXts0lmfCGG4xN0K5cpazF21fO38aLWS0/rsBwBsV/t4W?=
 =?us-ascii?Q?LIM1FrKgRWl64x5Ke3OWR+LH/Jf3YjCzcm7izjcs/abDU3TA4lQAlWHJEYoT?=
 =?us-ascii?Q?MBMYcjVmd97NZhUWhAfmh+mh/ud8pyntLI75lRcUpQim+tJm24wN6Hu41bGg?=
 =?us-ascii?Q?SAWWtaXEGJwbeW63RwVhb83DOJ1Su7f1gQtQ5QCvJa7aarls+RfVayasW+IE?=
 =?us-ascii?Q?RaPeQEEkWiMOvLEOPe7CMLkH31JleDr7Jq+TWCgm/smE7C1vruh/Bu4fnleQ?=
 =?us-ascii?Q?kDpH1tVeC4dXcT4y/CVCQm5Rcqh9SVUUm/f+ZWpe9GxzziXyCThMzpYZ/iZY?=
 =?us-ascii?Q?k2WpRp7vOMpYpYeqHmhAm/wj/WMDZHvBQ2Bj4sI0x80tp8tlSlYoMGUd6mOn?=
 =?us-ascii?Q?qZjc1d4PxlA6gFn/g4uA3MUImgbefHGDV+g8PAOqh52ANwR9i3RUmy+KEOOH?=
 =?us-ascii?Q?752LymJxDgZ7USV6ClPlts3aHKnUTuBVYUdlChwM1J69YsRv5wxcXH9CuJ8s?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CtMeLBtbC6uk9F0g98V1Rum7ljPPyl0c/lq1BOd+jOtWzapwIiooMq29sQLNPQUh8iXMFCCIWM1mRSOy/QdfJhpsEnKhI8/oDgEqTU3+gT8PMAsmF24tVlTrMXGsCCGPbkknRUI50Y72ye3vah71K4ULT4ifWTpZCAfjmtcB8mc8/O852LI22V9VSBJr2J8yv4U8IhU59wQW5bjN7TBYWHJDN+H3PMvg07Bv4mC1cHpmU3L6bA+U6AxfaklPFcFm7ROO1URnlkEXkIzFxDRDxbaYOd3jA8PWBfnyxI6pGIVWdl0XZEUessgdFlwIIegfURTlijhvD2twZ10CpOhRSOXWMfVDyjcMEVyxYypoH3HH89e9QIpRPVju+peXPiyN89tIiLjMAEjUN1/jARWYgc773QWAcD3IbC6mbV7/IK10wVKNox0UQmBn9XXIOyGkiwI2Rws6dMiNj6qmN4uS5nH90BAnIGq/hX+vUfJ7/lSfe8SowKIeUU9JGjzn22Fp/UOdVb+cd0gfrjeHMBPt7+61Ou9d+1pPi+WMoImDm51JeaNQMeRH1RdIRGlnz7NicwW9+vU2RWqAn5trReUeMwALUbXJwOxL8iyL8IkhmZQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d4f13f-805a-42d1-6036-08dcfe7153f8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 14:43:07.6858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBuMzia9b9OwPo17MU6hKv8J9nB2s7dGAw/CMvAwNG92qYYvtPym1jT8D7dnBc/KPfz3NWht3ydFKbp4vpCCyKSuqnL8ZgO3TxXHdIZxatY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5095
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_08,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411060115
X-Proofpoint-GUID: _itB63oUZ2IRkngYfqTUN9IJeQVkldN1
X-Proofpoint-ORIG-GUID: _itB63oUZ2IRkngYfqTUN9IJeQVkldN1

NACK.

Do this some other way that isn't a terrible mess.

You've reverted my CRITICAL fix, then didn't cc- me so I'm grumpy.

Even if you bizarrely brought it back later.

Don't fail to cc- people you revert in future, please, especially in
stable. It's not only discourteous it's also an actual security risk.

Thanks.

Also this commit log is ridiculous, you don't even explain WHAT ON EARTH
YOU ARE DOING HERE. It's not just good enough to reference a CVE and expect
us to go research this for you, especially one you've 'addressed' in this
totally bizarre fashion.

On Thu, Oct 24, 2024 at 09:19:41PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
>
> Fix patch is patch 27, relied patches are from:
>
>  - patches from set [1] to add helpers to maple_tree, the last patch to
> improve fork() performance is not backported;
>  - patches from set [2] to change maple_tree, and follow up fixes;
>  - patches from set [3] to convert offset_ctx from xarray to maple_tree;
>
> Please notice that I'm not an expert in this area, and I'm afraid to
> make manual changes. That's why patch 16 revert the commit that is
> different from mainline and will cause conflict backporting new patches.
> patch 28 pick the original mainline patch again.

This is... what? :/

You have to fix conflicts, that's part of what backporting involves.

Yeah, rethink your whole approach, thanks.

>
> (And this is what we did to fix the CVE in downstream kernels).
>
> [1] https://lore.kernel.org/all/20231027033845.90608-1-zhangpeng.00@bytedance.com/
> [2] https://lore.kernel.org/all/20231101171629.3612299-2-Liam.Howlett@oracle.com/T/
> [3] https://lore.kernel.org/all/170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net/
>
> Andrew Morton (1):
>   lib/maple_tree.c: fix build error due to hotfix alteration
>
> Chuck Lever (5):
>   libfs: Re-arrange locking in offset_iterate_dir()
>   libfs: Define a minimum directory offset
>   libfs: Add simple_offset_empty()
>   maple_tree: Add mtree_alloc_cyclic()
>   libfs: Convert simple directory offsets to use a Maple Tree
>
> Liam R. Howlett (12):
>   maple_tree: remove unnecessary default labels from switch statements
>   maple_tree: make mas_erase() more robust
>   maple_tree: move debug check to __mas_set_range()
>   maple_tree: add end of node tracking to the maple state
>   maple_tree: use cached node end in mas_next()
>   maple_tree: use cached node end in mas_destroy()
>   maple_tree: clean up inlines for some functions
>   maple_tree: separate ma_state node from status
>   maple_tree: remove mas_searchable()
>   maple_tree: use maple state end for write operations
>   maple_tree: don't find node end in mtree_lookup_walk()
>   maple_tree: mtree_range_walk() clean up
>
> Lorenzo Stoakes (1):
>   maple_tree: correct tree corruption on spanning store
>
> Peng Zhang (7):
>   maple_tree: add mt_free_one() and mt_attr() helpers
>   maple_tree: introduce {mtree,mas}_lock_nested()
>   maple_tree: introduce interfaces __mt_dup() and mtree_dup()
>   maple_tree: skip other tests when BENCH is enabled
>   maple_tree: preserve the tree attributes when destroying maple tree
>   maple_tree: add test for mtree_dup()
>   maple_tree: avoid checking other gaps after getting the largest gap
>
> Yu Kuai (1):
>   Revert "maple_tree: correct tree corruption on spanning store"
>
> yangerkun (1):
>   libfs: fix infinite directory reads for offset dir
>
>  fs/libfs.c                                  |  129 ++-
>  include/linux/fs.h                          |    6 +-
>  include/linux/maple_tree.h                  |  356 +++---
>  include/linux/mm_types.h                    |    3 +-
>  lib/maple_tree.c                            | 1096 +++++++++++++------
>  lib/test_maple_tree.c                       |  218 ++--
>  mm/internal.h                               |   10 +-
>  mm/shmem.c                                  |    4 +-
>  tools/include/linux/spinlock.h              |    1 +
>  tools/testing/radix-tree/linux/maple_tree.h |    2 +-
>  tools/testing/radix-tree/maple.c            |  390 ++++++-
>  11 files changed, 1564 insertions(+), 651 deletions(-)
>
> --
> 2.39.2
>

