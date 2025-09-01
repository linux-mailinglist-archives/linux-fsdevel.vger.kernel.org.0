Return-Path: <linux-fsdevel+bounces-59864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBE3B3E703
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 16:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66BE03A63DE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 14:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A311C341AB6;
	Mon,  1 Sep 2025 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ea5Dbp2D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sXOyPrMy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3E92343C7
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736722; cv=fail; b=GW2JQB/7ShVCAnBa0SBjDdtmL+67Z+z4OGBazP6/twoLA7Yt2bBvwAc0cZ6u3kdvX8rlb/i0KEoKSWfVVu1ZoVfFKS71IhNGgUL11EeUtlNqnUuVJistQWIGL6kuUfrAV3JdJUKvzocWWKg9XLVI7Bb9QQcCS6IQtcJ2N9TpgFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736722; c=relaxed/simple;
	bh=lgx/q28Bk0xHabfiWm+HRd1eIUd9USWRcG+cO3DOQrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NImV2S1sUXd7j/xQosG0HX47Yp1po4StpPuH/lRQw8uh3tnb+jteLtjWVRZPzTF9SWJrjJkfzKCbV+doKJ64889DjxDNysPp8h5cxJZI8Jhd7ZYv8Cv5P14DopwSWK4D5kt82asJmdCIUv64bYkHieRn9WyZHeeYE48z4l8rWBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ea5Dbp2D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sXOyPrMy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815fpw6004799;
	Mon, 1 Sep 2025 14:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3dA2WSYyqPzfn3OJ3V
	+s0cDdA9lI72wyH7A2RQWfyfM=; b=ea5Dbp2DU06PRC/iq/Be7YmYKKIaqTydo9
	QgfRnQfDRtTpgNJpNujKtA3dNvfI2xKROsF8aE/hAwP66q4f/kOqFilFD9wzTYXI
	EXm4+Q4j5LRGLUel+A4KagS8CuYFsElBIB/cq2W2J4iq1Yb2irt/R0hx83Gl1TWx
	P1B1UfShfYxOCbtKEj4H1QR/BYd0Nut3bmNjtfbk22CU9PeN5/vwA/iECOKfUuvV
	Cdie7wndUgVg0Mw+j0k9fZKqjFbXOiKPuYj/tZsloIxWRY30hwnwcY7wEkirdyYW
	zMYO0UxoZh/nRhKKUQ53Bq9YDchHGoYUFF56gVo4tn2Ql1BAoPgw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmnaj0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 14:25:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 581CQCLW004192;
	Mon, 1 Sep 2025 14:25:16 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr867yw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 14:25:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeGtVJnr1OcnGCHEgzw/8p9vQEfCUuARr/FE7KJhUMIefmPqC32suaz8bdGzv/IYWhrPv1GvRZ7C1ephSgZwGu3oCIyiAo8i/Egj1Jr7SkRclkjsNFSNBu/yiTTTzMAHYOfudYBHyg8+rgY2KGHuik97PjSC6ZJH/I8vFtrEzR4hbCWyqZPh93AqCUBdG6HYFwCz7POr8b85XiOui9+4tUXOjgMD2ecMJXoeQvc/dw0SyfaY7FfRB9GQWQwxhoUlgyJWGrcJRxCHQAyhlQpuEIc3IkVLkfKiVTaBHUrnv82aP47Z5fIp7I9G+e5DdOlJ2B8dDjZbAKWzy3GSAR4Zxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dA2WSYyqPzfn3OJ3V+s0cDdA9lI72wyH7A2RQWfyfM=;
 b=mS3/q5vG3+mLWKV/LYbsizzD4ta6NEVa+opO45B0KMGlDNSN4TpbrJBqh8bd3cDQORGHHIN3+R063acPzg37CKeNJFm2bhLgeef2HxKfOAZg3t4jAzXc5/Bl7zmGhtNwSjb7c/uymAOmwiOeAuJZXzhhA9wMdvXJXg6GOz5pa75dWqyRwMzTAoIOat+hG7H22mPfF/tIWmPTby6Bj76GQcXwE9FfZ8Vv0g/icr0/hX6uFnBN43zsBKftTcSAivP8octofcT9WirPyHMtKTQU+Q8PuwndowfHkSVTmJylQ+FK7yH8fWBdAxisS+YKSuPKlK6+yriVazszj/I0OOwzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dA2WSYyqPzfn3OJ3V+s0cDdA9lI72wyH7A2RQWfyfM=;
 b=sXOyPrMymPFqfEhIoVoVJ1fU3TenYAkRQQf/Q7M3YVnRQ9xvac2KRWjoF/XvzmhrbpRBQiQiWQpkiRWJ3+sbVRGCLDkyhgUYfTeaMQxA7gIdCUMIDA0oHZIxkGGkOSl9/r0MYPmI0To1DImZEO63EUFSEi4s25yGBNY1EaqhRWg=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SJ0PR10MB5696.namprd10.prod.outlook.com (2603:10b6:a03:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 14:25:11 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 14:25:11 +0000
Date: Mon, 1 Sep 2025 15:24:54 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
        yuanchu@google.com, willy@infradead.org, hughd@google.com,
        mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, vishal.moola@gmail.com, linux@armlinux.org.uk,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        weixugc@google.com, baolin.wang@linux.alibaba.com, rientjes@google.com,
        shakeel.butt@linux.dev, thuth@redhat.com, broonie@kernel.org,
        osalvador@suse.de, jfalempe@redhat.com, mpe@ellerman.id.au,
        nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 02/12] mm: constify pagemap related test functions for
 improved const-correctness
Message-ID: <26cb47bb-df98-4bda-a101-3c27298e4452@lucifer.local>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-3-max.kellermann@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901123028.3383461-3-max.kellermann@ionos.com>
X-ClientProxiedBy: GV3PEPF00002E34.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::1a) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SJ0PR10MB5696:EE_
X-MS-Office365-Filtering-Correlation-Id: 948b47c7-621c-4ba7-faea-08dde9635b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D/FEt0N6lF+BstsZRxPxzhiOWA6vmcz/3IcyDC7EHyvWRT3sA0bxullIfTsc?=
 =?us-ascii?Q?11MB+Nc/djToETtAXpwwwKmSyHHLYYDY736wij6Bn4bgIvWfWXQqLEZUyWlF?=
 =?us-ascii?Q?cEsrzCze/NervRpb9qYZR9cdBPCf0Br3//qsPQ6bwSpeG4vriJumUeW8aqPV?=
 =?us-ascii?Q?/QpGXb1zsLaV9NykqLuEqbGkXJzfeasVSSU/oFEVx13Ri4YIWVBIteOqT0ZV?=
 =?us-ascii?Q?tBxXukMvZMAAh4jNZx7cN7KMGISG5jsKvqZIc81T+okAAa1/1OCcZklxIaMR?=
 =?us-ascii?Q?ppMGFTylEUtWdCfIlBl/v/Mzg1A/bytFoC0cnnFOTfi8Jxx9l9+IMQhvoSLs?=
 =?us-ascii?Q?YRi7/ggJM8T5yTNdKD/kKljx8ujQBbRs1ixIpsWgaeRxtXKW11IkqmUcx5si?=
 =?us-ascii?Q?aAxRd6GQaTgnqXVvuoJBSL7J1C7s0+k6hGOtcEq5uwrm8ZdGTs6RsvQc5WnE?=
 =?us-ascii?Q?8E1z6cQpNQlE1Uwb5ACYZu4zfAQ382O7jl/hNM+EU4smjXmt1WchwU95o0QO?=
 =?us-ascii?Q?PPgjn6vHhMzBdK5rHUaU0rW/NkqD/n4q0hv9RhIL+ilgj1+H1gIYZMIpD5KV?=
 =?us-ascii?Q?xzpzPwfIvd3K5p1nHYR8Lko1yi/83TbMY5pEYtPgKG0sJU2UJ4lVsN1gwp19?=
 =?us-ascii?Q?a/lWmoNyYamPDgEvy2FNKQQrlv58JVv9o+8sqhmUgnrND/TDcZUZCUMiRzvr?=
 =?us-ascii?Q?6+WXiwDhQTBw832oDLqpICeW6e7cQsPalSdZJ+dhubOfpeCd+xeFlKOlPxSU?=
 =?us-ascii?Q?RRAwg6sZhznse2Nb4yeP2SrsfEYOr3VcqTv4dG85g9U2J97FOUtfRezvGyQD?=
 =?us-ascii?Q?pMHODFfWx0+blIewyWWc8xegNcwr1CmuRYLlIxtRtY88BZL2T4bTvP5dfeG+?=
 =?us-ascii?Q?omwwlhMriN9qRgLKFyjSd+B326joYu+D7NSxu9VauM4OLdwT8cNtNmE65aai?=
 =?us-ascii?Q?fi9wxRFV4wl2i9AqgrlmFd9DFs8s0IGiIn3ei60lcyTzZ+26GpPnWU6MUDPT?=
 =?us-ascii?Q?95XHoQ2X81W8kLHxlT85y0DecN3tfTzbBtBe/FWPQtpG/uZiR9BHxHeMwsSD?=
 =?us-ascii?Q?CoCYE4QfswYOqnVWWm0DK6C6axi8iiOloiP5iLw/tQew50SiXhh+EFShAMFu?=
 =?us-ascii?Q?alNpChAEsJr/wapkxXBH5LdAYq5gDIhBRnujLEGHFbioE9fs1jfv4fvpjYKn?=
 =?us-ascii?Q?shsaxWL9oLBjVcWfKe/jME0EX/ha4EXaAudcO/asKbpyWpZCD323rsX4rTCM?=
 =?us-ascii?Q?+BSYqWHwYdfSYMJ1EOVrOixZC7qanpCkGIIfNzYmFqveX+cPoFVc8J/+KmpZ?=
 =?us-ascii?Q?Z7jVY+dzuXKmq+43u2mWfVC8eBp9Pb/JuCowj8yTGZt7+oOaSZaayC39t6EN?=
 =?us-ascii?Q?Gfu1fRTvgvDMlzW15oRMDhFYuanxf84SWbXBMblY6+DMYiRZc25XdWUPSDu+?=
 =?us-ascii?Q?9TLPSIKpcEs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UTZil/9gV5vSMflXtHLoZyaKW+DFKgegvM9qqDGrr1zK2+fQObsFUnS3Kr9S?=
 =?us-ascii?Q?Hd4cfHg9O+KGdlm1ccoZftK+MemoDuwvpzSHeS9Ft7S6LTnPJIgrxob6J0XV?=
 =?us-ascii?Q?1HQ1+iX9QQNxEkh16nnRwi7h3GdW3bvHRvsJ+Gr9ikNh2I5hixPFE6vP4Bk8?=
 =?us-ascii?Q?LRR/3P+5bkQ22WfnPjbWtCaNltmM6CslMlaG1yqEJLdtm7uiReKALmRbEsiD?=
 =?us-ascii?Q?nr6CpAt+1XNLKzAfvWA9tK1pVpL548eWp4zSQgSFIx2yWGz3Q7GHPKN5ames?=
 =?us-ascii?Q?5mK/JCMKmnhrVwZkQhUaxQwLDclvrJtRBzDuwtK9tIgJWA1xEaEejnWsPm2+?=
 =?us-ascii?Q?tSCuWAudmh8ZbTBNc+fbb/OiALR8u8cTmGewCa2QgAZwnHx6jFEy/mORQDQh?=
 =?us-ascii?Q?koVlOFGO03ic7tVgmmCLetIjo/JioRFN4asDJxeag4/tGXa7x35jObmeRMpU?=
 =?us-ascii?Q?0fP5RLvzOZAfWeIiXYbV3dLPKnN2WijvVCGI+8Yv9Xu3v22ysGM3FwMtcpRA?=
 =?us-ascii?Q?09nFGkbIBa3ETzYbnhNSkZ1TGv0ij1v84k6phYSYYhNBHUD4u/pWPnJfSgxV?=
 =?us-ascii?Q?50HkcdkB4J4pULmnPP7crpLDIAbljwOxwFEcWw/FceAsYvjzjOjjFgKfXV10?=
 =?us-ascii?Q?J+3PQW0CJZX2EjSMzCeDi8Iow85fRvXxLWCQmtESs5d+7JSbOnEo6E0gcuut?=
 =?us-ascii?Q?Gz+4GefdBt3117IuwZSgkGx74oBtCT/LhdGrePfmELqZBvUFxAxpL0l5cHxo?=
 =?us-ascii?Q?A1G9Pz0JR7CMfrgnZ+S9U2HzdRyEDhuKs/eUWPqEAeMHZEGcDiGxj7qGFtUz?=
 =?us-ascii?Q?VeeRtQh1UbPh6gCXDqLQvUpUDqfCXUMUlU/hZeKpDB/nvakWwmqC9miQ0+Zp?=
 =?us-ascii?Q?fj9zkYB822vLAhP4yZ+OMFVOZ8OC1LzUVEi36XHWVzvTSl4HkBkIW5Xi46Hw?=
 =?us-ascii?Q?e+y23qCCmzZS2xEFtTzEd/cZuAM7WcfSEvCJHva27cFxV/7VQlUSbEPCs68j?=
 =?us-ascii?Q?ea0zml7761Y6WTLVw/fZSNIItm2xHiOLF8Qwk4fLFmOIBo3M3/JoMBzlmJta?=
 =?us-ascii?Q?4hfMcPR5gMH17DUCGRmtQBzqgc4ddfyuExPw+lDwcm/srDNgqMbyOggCtohu?=
 =?us-ascii?Q?F35bgsAzKsGEeOdfuauB+0X/NJMUBS6WLpK/K3fP52HqDQwdOaAtNwUZa/Nl?=
 =?us-ascii?Q?V4Avepj9+6A8dq29upVBxXFS3dcB4yxgsh5vi5m4JS/wgJQ5rgJ8PLyH5ofn?=
 =?us-ascii?Q?ShH8C8BQPJ6qesfqiHDbNY+EVcqjf4D5903FyL8iGcyXONqt6coskVMibAY8?=
 =?us-ascii?Q?PdbfgweLdbR0+wgqLkSWB1/ib4AREoQlqFrgSdKG0bpkEJPPyQCmDbe5qDf0?=
 =?us-ascii?Q?nEAn8LaP1iRVKE//K++KPef9jZQIviUd77OD5BYBMSipDL8FaZt0tOHHX7XL?=
 =?us-ascii?Q?xHPLiJioyRxOPV0w6NiynAh5HFRAtsDakhJpaVFVs7iRvDcpdRpgRImnZ8O4?=
 =?us-ascii?Q?yJ6NMTZC2m6I0GLnbsRrTZsE2qGP4WyonRUudVhHREzlkQ8sXMd+j3C6Q97u?=
 =?us-ascii?Q?LIF715Ut1ko9h/UvQBLDro85kmSkK0mthc+ZUpto4K6DoMZYHHizipQ/iuGD?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sO9o5kP7yWduysbCW5suluuGY32cY72QYmjHzI0wh3AqUO0gRtsPJ36/UiNJRV4NC7j5AtjhhS/HiwH9+n0oDeJUebVcvYCoJQeinM6rKwdDsMC2SS0RC6VzdAzeLMpV6+s+ekSeyGVgD8tnU/ZQj2agV1UWDTJLg1Lg4AbIfoXp4kRu4YeETNxEEbRjLvupzxNA7cphffgKI1SPvH3IUbQJIcHCTW2nVyu1IzYSQjcVo8S3TvEZLLBsv83kHwBmcpd5XC1NOKQUv6IfqSahheiMJbjq8TdUaofGwE09qz1E9HER0Uv37T6CKqiGiXNvN1PU/Z69kpnVal1f9dx/ojKXwZ/uLTGarD5L7rxqhB2RTt9w7+zW0JEjgUObLrhcHOMHcT4f8JocJV8KER1f1WAZHxK9gwP+QbvLLergM1JPUjilQeVKjl3yx2i7AP4ha2INz0U7ysQ+axvPLMXlQecTiz2RuWGPvbEq3TTH6p04Uz1QZgbS5d4dLUL9mYsOBAtzHwnOsl8qfj3T27bJUmVTwyPzYvDPR5kM0gb4fDTq9c2Ejewm9Du794GMe4/46pGSpoUwx4gMrX4l3QvwzA6NpprOQNa8ahNNFXSIxV0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948b47c7-621c-4ba7-faea-08dde9635b81
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 14:25:11.7025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMBMh1vwDo9k+MxbRhnhXvCPoAE5Lf0Xa1Af5+rsYBLRfp+4UsNtbE/j3mHB3+YFvVCKtrmCxbCkXZ4qAor+6P25/MP5G5m0NDddv3nJCZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509010152
X-Authority-Analysis: v=2.4 cv=D8xHKuRj c=1 sm=1 tr=0 ts=68b5accc b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=UgJECxHJAAAA:8 a=pGLkceISAAAA:8
 a=43YwVfZmN8WL7PSlnvYA:9 a=CjuIK1q_8ugA:10 a=-El7cUbtino8hM1DCn8D:22
X-Proofpoint-GUID: TJP_CIz61XTgYDkvaGHXlI3J3KgHRBdY
X-Proofpoint-ORIG-GUID: TJP_CIz61XTgYDkvaGHXlI3J3KgHRBdY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX82Xb/SDlMrBo
 UNd4lMVuOJJF9iIeot74FLF/pjnfkj2JKItdNqnXrqdwfj04ZB6sNjCSbbRZS7HvWTsfotz3+zq
 7Nu9qnuWPKEGpu8BfjAv95LJqQNs5RN68DrgNezAvXxGvTu751qnbkiDTtKJ2sSNBvQ5lnDHcSt
 n2lTyr7f2eYbfbwwiIzM9bkdkD4BLZicyEh78kV7B8Sw12rTVheutR+CZr4k4cDWoudRl8uyKkZ
 MnuZ8qYvoX6aeMWxuvNif1nBcgUGHnAa6+JgiSAYA8PXaYBAFqUBWP+uLOYxLXaOXqVXyg/TUcZ
 0CXHT62RLr0xlKIF7NpNb9pARuJiZO+l5cMC7pcIsVAi7yowe4TSVXz06k7t9bWJ63NvB6HFhw9
 wgDVgFGT

On Mon, Sep 01, 2025 at 02:30:18PM +0200, Max Kellermann wrote:
> We select certain test functions which either invoke each other,
> functions that are already const-ified, or no further functions.
>
> It is therefore relatively trivial to const-ify them, which
> provides a basis for further const-ification further up the call
> stack.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  include/linux/pagemap.h | 57 +++++++++++++++++++++--------------------
>  1 file changed, 29 insertions(+), 28 deletions(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index a3e16d74792f..1d35f9e1416e 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -140,7 +140,7 @@ static inline int inode_drain_writes(struct inode *inode)
>  	return filemap_write_and_wait(inode->i_mapping);
>  }
>
> -static inline bool mapping_empty(struct address_space *mapping)
> +static inline bool mapping_empty(const struct address_space *const mapping)

Generally - I'm not sure how useful this 'double' const-ification is.

const struct <type> *const <val>
  ^                    ^
  |                    |
  |                    |
  1                    2

Means:

1. (most useful) Const pointer (const <type> *<param>) means that the dereffed
   value is const, so *<param> = <val> or <param>-><field> = <val> are prohibited.

2. (less useful) We can't modify the actual pointer value either, so
   e.g. <param> = <new param> is prohibited.

I mean it's kinda nice to guarantee that this won't happen but I'm not sure if
we're getting much value for the noise?

We also never mention that we're doing this in any commit message or the cover
letter.

>  {
>  	return xa_empty(&mapping->i_pages);
>  }
> @@ -166,7 +166,7 @@ static inline bool mapping_empty(struct address_space *mapping)
>   * refcount and the referenced bit, which will be elevated or set in
>   * the process of adding new cache pages to an inode.
>   */
> -static inline bool mapping_shrinkable(struct address_space *mapping)
> +static inline bool mapping_shrinkable(const struct address_space *const mapping)
>  {
>  	void *head;
>
> @@ -267,7 +267,7 @@ static inline void mapping_clear_unevictable(struct address_space *mapping)
>  	clear_bit(AS_UNEVICTABLE, &mapping->flags);
>  }
>
> -static inline bool mapping_unevictable(struct address_space *mapping)
> +static inline bool mapping_unevictable(const struct address_space *const mapping)
>  {
>  	return mapping && test_bit(AS_UNEVICTABLE, &mapping->flags);
>  }
> @@ -277,7 +277,7 @@ static inline void mapping_set_exiting(struct address_space *mapping)
>  	set_bit(AS_EXITING, &mapping->flags);
>  }
>
> -static inline int mapping_exiting(struct address_space *mapping)
> +static inline int mapping_exiting(const struct address_space *const mapping)
>  {
>  	return test_bit(AS_EXITING, &mapping->flags);
>  }
> @@ -287,7 +287,7 @@ static inline void mapping_set_no_writeback_tags(struct address_space *mapping)
>  	set_bit(AS_NO_WRITEBACK_TAGS, &mapping->flags);
>  }
>
> -static inline int mapping_use_writeback_tags(struct address_space *mapping)
> +static inline int mapping_use_writeback_tags(const struct address_space *const mapping)
>  {
>  	return !test_bit(AS_NO_WRITEBACK_TAGS, &mapping->flags);
>  }
> @@ -333,7 +333,7 @@ static inline void mapping_set_inaccessible(struct address_space *mapping)
>  	set_bit(AS_INACCESSIBLE, &mapping->flags);
>  }
>
> -static inline bool mapping_inaccessible(struct address_space *mapping)
> +static inline bool mapping_inaccessible(const struct address_space *const mapping)
>  {
>  	return test_bit(AS_INACCESSIBLE, &mapping->flags);
>  }
> @@ -343,18 +343,18 @@ static inline void mapping_set_writeback_may_deadlock_on_reclaim(struct address_
>  	set_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
>  }
>
> -static inline bool mapping_writeback_may_deadlock_on_reclaim(struct address_space *mapping)
> +static inline bool mapping_writeback_may_deadlock_on_reclaim(const struct address_space *const mapping)
>  {
>  	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
>  }
>
> -static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
> +static inline gfp_t mapping_gfp_mask(const struct address_space *const mapping)
>  {
>  	return mapping->gfp_mask;
>  }
>
>  /* Restricts the given gfp_mask to what the mapping allows. */
> -static inline gfp_t mapping_gfp_constraint(struct address_space *mapping,
> +static inline gfp_t mapping_gfp_constraint(const struct address_space *mapping,
>  		gfp_t gfp_mask)
>  {
>  	return mapping_gfp_mask(mapping) & gfp_mask;
> @@ -477,13 +477,13 @@ mapping_min_folio_order(const struct address_space *mapping)
>  }
>
>  static inline unsigned long
> -mapping_min_folio_nrpages(struct address_space *mapping)
> +mapping_min_folio_nrpages(const struct address_space *const mapping)
>  {
>  	return 1UL << mapping_min_folio_order(mapping);
>  }
>
>  static inline unsigned long
> -mapping_min_folio_nrbytes(struct address_space *mapping)
> +mapping_min_folio_nrbytes(const struct address_space *const mapping)
>  {
>  	return mapping_min_folio_nrpages(mapping) << PAGE_SHIFT;
>  }
> @@ -497,7 +497,7 @@ mapping_min_folio_nrbytes(struct address_space *mapping)
>   * new folio to the page cache and need to know what index to give it,
>   * call this function.
>   */
> -static inline pgoff_t mapping_align_index(struct address_space *mapping,
> +static inline pgoff_t mapping_align_index(const struct address_space *const mapping,
>  					  pgoff_t index)
>  {
>  	return round_down(index, mapping_min_folio_nrpages(mapping));
> @@ -507,7 +507,7 @@ static inline pgoff_t mapping_align_index(struct address_space *mapping,
>   * Large folio support currently depends on THP.  These dependencies are
>   * being worked on but are not yet fixed.
>   */
> -static inline bool mapping_large_folio_support(struct address_space *mapping)
> +static inline bool mapping_large_folio_support(const struct address_space *mapping)
>  {
>  	/* AS_FOLIO_ORDER is only reasonable for pagecache folios */
>  	VM_WARN_ONCE((unsigned long)mapping & FOLIO_MAPPING_ANON,
> @@ -522,7 +522,7 @@ static inline size_t mapping_max_folio_size(const struct address_space *mapping)
>  	return PAGE_SIZE << mapping_max_folio_order(mapping);
>  }
>
> -static inline int filemap_nr_thps(struct address_space *mapping)
> +static inline int filemap_nr_thps(const struct address_space *const mapping)
>  {
>  #ifdef CONFIG_READ_ONLY_THP_FOR_FS
>  	return atomic_read(&mapping->nr_thps);
> @@ -936,7 +936,7 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
>   *
>   * Return: The index of the folio which follows this folio in the file.
>   */
> -static inline pgoff_t folio_next_index(struct folio *folio)
> +static inline pgoff_t folio_next_index(const struct folio *const folio)
>  {
>  	return folio->index + folio_nr_pages(folio);
>  }
> @@ -965,7 +965,7 @@ static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
>   * e.g., shmem did not move this folio to the swap cache.
>   * Return: true or false.
>   */
> -static inline bool folio_contains(struct folio *folio, pgoff_t index)
> +static inline bool folio_contains(const struct folio *const folio, pgoff_t index)
>  {
>  	VM_WARN_ON_ONCE_FOLIO(folio_test_swapcache(folio), folio);
>  	return index - folio->index < folio_nr_pages(folio);
> @@ -1042,13 +1042,13 @@ static inline loff_t page_offset(struct page *page)
>  /*
>   * Get the offset in PAGE_SIZE (even for hugetlb folios).
>   */
> -static inline pgoff_t folio_pgoff(struct folio *folio)
> +static inline pgoff_t folio_pgoff(const struct folio *const folio)
>  {
>  	return folio->index;
>  }
>
> -static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
> -					unsigned long address)
> +static inline pgoff_t linear_page_index(const struct vm_area_struct *const vma,
> +					const unsigned long address)
>  {
>  	pgoff_t pgoff;
>  	pgoff = (address - vma->vm_start) >> PAGE_SHIFT;
> @@ -1468,7 +1468,7 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
>   * readahead_pos - The byte offset into the file of this readahead request.
>   * @rac: The readahead request.
>   */
> -static inline loff_t readahead_pos(struct readahead_control *rac)
> +static inline loff_t readahead_pos(const struct readahead_control *const rac)
>  {
>  	return (loff_t)rac->_index * PAGE_SIZE;
>  }
> @@ -1477,7 +1477,7 @@ static inline loff_t readahead_pos(struct readahead_control *rac)
>   * readahead_length - The number of bytes in this readahead request.
>   * @rac: The readahead request.
>   */
> -static inline size_t readahead_length(struct readahead_control *rac)
> +static inline size_t readahead_length(const struct readahead_control *const rac)
>  {
>  	return rac->_nr_pages * PAGE_SIZE;
>  }
> @@ -1486,7 +1486,7 @@ static inline size_t readahead_length(struct readahead_control *rac)
>   * readahead_index - The index of the first page in this readahead request.
>   * @rac: The readahead request.
>   */
> -static inline pgoff_t readahead_index(struct readahead_control *rac)
> +static inline pgoff_t readahead_index(const struct readahead_control *const rac)
>  {
>  	return rac->_index;
>  }
> @@ -1495,7 +1495,7 @@ static inline pgoff_t readahead_index(struct readahead_control *rac)
>   * readahead_count - The number of pages in this readahead request.
>   * @rac: The readahead request.
>   */
> -static inline unsigned int readahead_count(struct readahead_control *rac)
> +static inline unsigned int readahead_count(const struct readahead_control *const rac)
>  {
>  	return rac->_nr_pages;
>  }
> @@ -1504,12 +1504,12 @@ static inline unsigned int readahead_count(struct readahead_control *rac)
>   * readahead_batch_length - The number of bytes in the current batch.
>   * @rac: The readahead request.
>   */
> -static inline size_t readahead_batch_length(struct readahead_control *rac)
> +static inline size_t readahead_batch_length(const struct readahead_control *const rac)
>  {
>  	return rac->_batch_count * PAGE_SIZE;
>  }
>
> -static inline unsigned long dir_pages(struct inode *inode)
> +static inline unsigned long dir_pages(const struct inode *const inode)
>  {
>  	return (unsigned long)(inode->i_size + PAGE_SIZE - 1) >>
>  			       PAGE_SHIFT;
> @@ -1523,8 +1523,8 @@ static inline unsigned long dir_pages(struct inode *inode)
>   * Return: the number of bytes in the folio up to EOF,
>   * or -EFAULT if the folio was truncated.
>   */
> -static inline ssize_t folio_mkwrite_check_truncate(struct folio *folio,
> -					      struct inode *inode)
> +static inline ssize_t folio_mkwrite_check_truncate(const struct folio *const folio,
> +						   const struct inode *const inode)
>  {
>  	loff_t size = i_size_read(inode);
>  	pgoff_t index = size >> PAGE_SHIFT;
> @@ -1555,7 +1555,8 @@ static inline ssize_t folio_mkwrite_check_truncate(struct folio *folio,
>   * Return: The number of filesystem blocks covered by this folio.
>   */
>  static inline
> -unsigned int i_blocks_per_folio(struct inode *inode, struct folio *folio)
> +unsigned int i_blocks_per_folio(const struct inode *const inode,
> +				const struct folio *const folio)
>  {
>  	return folio_size(folio) >> inode->i_blkbits;
>  }
> --
> 2.47.2
>

