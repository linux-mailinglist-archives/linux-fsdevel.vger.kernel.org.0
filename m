Return-Path: <linux-fsdevel+bounces-67316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C65CC3B7D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 14:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C721AA0A5E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 13:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2607633508B;
	Thu,  6 Nov 2025 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lhSBiag2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CacJGXrB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E50B334694;
	Thu,  6 Nov 2025 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437442; cv=fail; b=aBgvVL7AbvmXCmB+8Mgf9O4ZrUkzFIOd7RD3SpoChQO8UezrfxCFmzyp3ytiMyQk7+UyH4mRKDCiTHGgNjjTcRCSALB68/k9HkvPWlQFnGfwYUnzwk01m4nFO7V3lMhtw201pUzSm/VB0/PcQnUio8EMAUaIk+NxkUY14ZbSZqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437442; c=relaxed/simple;
	bh=aX9eeGx0W80Sm0kO/MVAdRPgu2ASl1jjU5fe6UEfqa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=REG7GiLHij0mQZD4luFVIVFixU9VbVBPFocody0oGKElzSSFje/+7OYhmH7LXtwhd4yXAwpooynTmTx1KA2icR+6bTlpqYBosqn8FO4pPeMkA14rbeqEXEt0kqmHRaNbGrd1Ui7fE7Wb6LrMtZtELtuq5O0OSa9V2XwTyNruxEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lhSBiag2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CacJGXrB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6CJjZI030467;
	Thu, 6 Nov 2025 13:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=aX9eeGx0W80Sm0kO/M
	VAdRPgu2ASl1jjU5fe6UEfqa0=; b=lhSBiag21Te/EmChwdb0TUrPD+0lyCV5bV
	FXMTFD9p3CzWv5e0CFUa9zLvCvYKakiIz4n36lYOLGxKchNcRPJg2XTGwhrudbR8
	RVbiK6sg+YCqvzFsPZMjaARxeCbyywexcgzD1sAq53qj0cYJhuWLsN6j2lAO0fEv
	/3lZdR+MdEJ16dpvKyofM8lKv+6QiOo2ybd2Uccww47RsXGWZg/XtnEaNTDA4BD4
	Gmlmqfzg6Xof9+8e9r3JQQJinwp67su2+ivWWvxPBTrZpXfLSLpuPJTcZ7ijfaVl
	TwDKDvPVdlrSTB+a+IQz8/njw3KLGH4eD3SnLzSBVX0EWeScnJpg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a89q42907-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 13:56:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6CXsaf010927;
	Thu, 6 Nov 2025 13:56:54 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013013.outbound.protection.outlook.com [40.107.201.13])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nce9vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 13:56:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTQpOHjFO2RZyLlIJZDmzjfm6jxJURCSvTRB9GyiAGvLK+PdEfVpVjzOFXZP8ZezDb2JycflouVCcuhduJJIBEVsWb27Jiytbog8WCa2VFOndrB/5x8BowaUFq4jrZyWiKOl1YHWRvxr4wWw49W2DClh3fDLAxc1KtnzKBO7l1KCxylwDRoR/frDWb9Jx1/SdVrghhq4IBpd4MreemZkilaz8vaiZ5EutCP0g9tVTRmo6QxkqJ0fFVYIAmRiOJqtyHKdXgPkmLsenGgkbRwyV3rZDQG+sULeGhc/6ALMkWPGIBRD/HdtQLLscIolgKCrlP2vei0j+nbZH4NS8CwBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aX9eeGx0W80Sm0kO/MVAdRPgu2ASl1jjU5fe6UEfqa0=;
 b=nVokhghZ3r7Zg4cWkRjuo+QRmF1Jg794V59xtmjg6Q6R7wbaNFg3Yrlw2zlhgUKLQftHOjV6zoheDYw+N/amf4OBMw9nultXdlOzZqwYrcFvjBMiFxWF28i8AcuO12sze6mGinM7BwWk0QMF4vp6KLTuLIQLPuqeedF+ra/V10dV3vPMLRbWQ1aw5W7e+7fV/4ZnVL7LQqm5JULSRoPe9TmcInxdNqGHf7t9yN+PJ9perYF2Kqxpi43V7BO4F5uu8xoGd8EPVHqZLNesKhQvEkx1EG6cLOWQVgEbdTZLaxU9R29DOZjpNW4ICs4+LFCWRsnEUKWHRh6RgldHSI0sxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aX9eeGx0W80Sm0kO/MVAdRPgu2ASl1jjU5fe6UEfqa0=;
 b=CacJGXrB/eF9u37RiDXdDY56XEkMc+jj+fvIwHxVRb5Ncz9NkP90NjxWNcJfCAxrIOKxMI9PTPCKSQ7RqGdG7cAalJpiEWp/HqvPHBUk2z4Pdt6jYVPKv9dRrGmjBUZAMPx5MX79cNFSfmktOL+jOeOesZ2Ftxh5OQm9KNQ6CI8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4666.namprd10.prod.outlook.com (2603:10b6:806:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 6 Nov
 2025 13:56:51 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 13:56:51 +0000
Date: Thu, 6 Nov 2025 13:56:49 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v2 1/5] mm: introduce VM_MAYBE_GUARD and make visible in
 /proc/$pid/smaps
Message-ID: <32e6be58-1738-4f1f-9ce1-78209d4e5174@lucifer.local>
References: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
 <fe38b1a43364f72d1ce7a6217e53a33c9c0bb0c5.1762422915.git.lorenzo.stoakes@oracle.com>
 <30a9baa7-5368-4ef7-9091-80d170cfb5c6@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a9baa7-5368-4ef7-9091-80d170cfb5c6@suse.cz>
X-ClientProxiedBy: LO2P265CA0166.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::34) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4666:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b19e54-af28-4746-2db2-08de1d3c561a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J6cWJXCizpJBgxrXgPl83sxqI9DAXYJCPtSoa9Wnjnth+C6mEU25hEeDErBP?=
 =?us-ascii?Q?kiQkr7YpfbTIpnQxChp09ydhDvt1v4sBBlIuI2Ly2g1N9hsMMew5bDY8ZQIk?=
 =?us-ascii?Q?JBOJ1LRQ+AdFKQbiLC5VT+tuteb8r87Ct384yrE3bspElc4yOxM6McJdP21b?=
 =?us-ascii?Q?BAbocRwmAl+5hSBIhiraesQ4XYDurlJYCxsY0UlrgD6xyr+ChsoOcJ6N7osX?=
 =?us-ascii?Q?kQNwRHZW1TljhQOgpQKBPUB18JLCy/JOpmgOMrDWW8kqZ9hkdY02HIPLBlEm?=
 =?us-ascii?Q?F6lHhFjNaRWH9HvSWg2RfM0jA5iHqdjShgQS5dz5YD38EZSZBGD56SUBSWEh?=
 =?us-ascii?Q?isDTwW4gDuhMcJauE131IsTTAfn7pTtvSMi6mDYKqc/d8cFRYlXzC4S/WLCy?=
 =?us-ascii?Q?Gae9nnndFBTWK6M8BeBtkMXUr9l1tFmobnQXw4ja9DiVXgP8pU+kGSI/9fU+?=
 =?us-ascii?Q?e/bH48/dYN3//9vb+VjM3L2S2r/mhGBaEqsnpz/z3+glDR/xrG+3FPJhMgiS?=
 =?us-ascii?Q?GtVzbJ0/uO9cO8yfVfr2PM4NnWUXnaqrZURq2BMVR/lcaxriH33CbTrUxSkl?=
 =?us-ascii?Q?oCjksD2uOVyiQ2bfm8D8N+1grndFn2ucty5frtyTIrA+U5TkJoWp7p8AkuB1?=
 =?us-ascii?Q?rX3iyDf31O5/sBjgaZblaZ8E7z4euqSe6oBfMjhDOjjUku7dGDdLpPIBKERU?=
 =?us-ascii?Q?FCOZjTRrNs+Rw/qhByHEMceTphdYep2scy9fDt996KpcK5Jyc6/EIalu3k5A?=
 =?us-ascii?Q?aErfAlR6FUEsK2qvM6br2bRWYwzSeW6Dc0Jjh0/bM4ZR2IvwAic1g89eCU3O?=
 =?us-ascii?Q?dcGY64o2LMTCn8VIUk1UlazNdOaN2BnQz1tpI1KT6C38V1H03W4uv8xSdJPV?=
 =?us-ascii?Q?TldqZubJlaS6GqdjMQfDwZFSFMAS37xGx7YPbHAJ/92OEMhP9RjuVpXWg2EC?=
 =?us-ascii?Q?A1r46K8tAzWoXqCe+5m+oGyzPryaVUrrnkyy5YWLouv3MTVQloRuCrxD60Bh?=
 =?us-ascii?Q?+RDydIWAriaHh58QoHPg4uzjFlL+Ee2q06D5oRdPmyydVVj0yelOxp51MIDZ?=
 =?us-ascii?Q?UKbHb6t7W6R9jxtOtiUffyKOzqUUQDDFljbT1UyfdMTcJH8NaCAvkb1f/pBL?=
 =?us-ascii?Q?YnFIO0lR16PjeysBEF5byOgKoesfwl4ZF1/ZdS3dGGF7TVOCwwbqIIgP5vkj?=
 =?us-ascii?Q?8lkBxQztwFzS3gZxbqMGtePPavfGIIwW3a7SHncWZtpVTAKBf6AB/aDdz0jB?=
 =?us-ascii?Q?nChX/xoRuIrVjpIzBH2Syz3WOWkqAE2sF5zmrG9zfP07iO8LmoTG5X0zQGf2?=
 =?us-ascii?Q?U/AGB0RVS8m9KFJoF9jNPOpjNl7nCgHfCaYUW64fD1vTl+1NJG8bZY9ahJr7?=
 =?us-ascii?Q?lBl8z/MAHCZVRiFN/WnFM86bP8Lb75zQ+1gH04I4S2gdQvs0gtOCmYC8WPGp?=
 =?us-ascii?Q?vCWrlTIUad17c7k9eXEz/PbE5+jdWuBn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iDHkYYERXgdcyMmHWNeOC5aGKleYsdpgiI1zG+We9ldH2j4y405HRWTAHf/m?=
 =?us-ascii?Q?67nLfU2K9xq9xGLEDNwK4D+hWsx+/eD5vRMfv4bNM+9WDShnfUFMR3LW/6oW?=
 =?us-ascii?Q?ZmfuISQbXbFgjPOIowGZDd6Dx150W2ZYGbZXbUV8y3MKLZN8KmElIylS9pag?=
 =?us-ascii?Q?6S7k7vWVCq28ux4+ViYzGzIml7ePiaUXPRsJ6sM6CPjuXgRYxZDrin+fMF85?=
 =?us-ascii?Q?+jwKZ940uO2BNdugBKwuyIB5BZsrPwoS1qPibEflub3e+EiRL1J07qVzBjNq?=
 =?us-ascii?Q?+D/N5G0ROrZX1tRAjpqXb9MukY5f43MCrmnjp0KNxjfwlnkeHGBjA8IO6Lgm?=
 =?us-ascii?Q?HGAiXipXKchumYe0tp+N/4TlJQ1QpqZItnRu7C1ifX/MQzFhD2gPrytvJsYn?=
 =?us-ascii?Q?tkjA8tgZFNKkQ89yfatgNKWOhnjG9XI0lm+XaZ2mGCncP8jAcq8SPMTjlZPJ?=
 =?us-ascii?Q?7fyxF15KN07c55QJ3ifSU5y/FfpFPxgRHpuBxKKI/WIGOC4zNbi0kFb4wy6R?=
 =?us-ascii?Q?F39RV5gJlXkYtCyoQp0oo+TY8kdX3jhjDuTywBnPpr171FjgI3wmuPbnKgWQ?=
 =?us-ascii?Q?Qyc6NDlVEfqZBOjNdZz2x1DktNHCWeIViKdDW+nhELSlMb5+8Fhj0vX6IMug?=
 =?us-ascii?Q?YPAY7eFJiKqAltQlre+x9Z6YULmQegeik2OTHR4EM3seol0SmyXBFsMWFikY?=
 =?us-ascii?Q?IkYnb777DsyYADTbnw8pFHppTiWx5LLDoExkivDxJ68d9ZWHtKmLyRZw9XDH?=
 =?us-ascii?Q?V6R46NZRZIOLyRsv96M7xcZ13SJ9OC/vBf/Y8b4vDwNaDSeDYzIWTGD6TrJh?=
 =?us-ascii?Q?nC5dNDTOW/GvS/dhNIeHjnY6UyqKEODNwQd4ZEK9pe5C8x99uJa6Moy6s2OW?=
 =?us-ascii?Q?GXR6KGwacsHLqEKjdPOKtLYL2uG35apJZKiD8xwVbBcz0p8ZCGk4TJ2IeEpH?=
 =?us-ascii?Q?CShmwEguq3VDilbbKKo9LFoLyQvgi7OkjtTsK0Vh5B3vDqROOQnkTaLx8J/c?=
 =?us-ascii?Q?1YzmrbfYc5YDaeqA5KXrvADyy9b8cGCsRUjT0YvBfUuC9cS9+diTC0QL7g94?=
 =?us-ascii?Q?rvwT2iJRqIuLQ/zv4BBX2J9+uwZlWA669ZM6bvUzEoKe6u4OqxV6/6+LbUfW?=
 =?us-ascii?Q?yihAUKMa9dhIylr9cjupu+wyNiuvrlJYSKciTSxORgcmhIKfIeDft65YjFR5?=
 =?us-ascii?Q?WX/BBs51HVj9Ce9tmI/gmN+3jzgY310g2aw5V+sEMJNJGeXapATm6Z86bsIE?=
 =?us-ascii?Q?7NE2e0xmXX3+l6yZ1K770o7IYx/CnSH/5Z7A3tekUEHkMobbkesCVR6znzod?=
 =?us-ascii?Q?DN/drLo1GJ3qvVI8ICJCsWz1NE9DPAQVOFYywRhwce6Hl1/ETLyWlpVT7O4W?=
 =?us-ascii?Q?3MSxUT0F/BfuLx0ZpI7harE2wXHOSA8U11e42GmMRAj0xw26tQ6Cvoi1VG6D?=
 =?us-ascii?Q?da3cOjS316uJlWjU+UY+DBTKTMqt1TZ+VfvepWVSJdiLRYJNLnVNP59GVaFR?=
 =?us-ascii?Q?YrgNIlxoNjFUO2ukiyuzc/zBhXNUHPF1Zsa27CRzNbJam0GtBhnuYqE/UT/f?=
 =?us-ascii?Q?+0NqkNsmJFqJ0bUz75BQhtGB6/RBml7mXrOKhMje5uCylqpbN1lD6GgINDqj?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Iy0lynZNHh6Z27ZjPQohtnnx7fy1AkROO5Vz5PoK33GtiY7BBCj1effzRoChRf+jandsED2a4aP/88kgVSscsBwHqqOKi61/eWMEOJZOcE1bhgGgbd7vjRtY65mAets6UHd+CKSUlarXxLeLHC1fPX4X/8gyLdaXjSnAhQWmOcOniuhAy9o+pDgKd6/wuJVU0TLei20oX7bO5eXij9ptmB8lbY92jChAW4DMGvyqVurkCEb9gRHWvua+uV9Eaw4ENYo0rpdp7AQ2CTF+fsx+xBqyw3ziEdWqnQz+lbwM2hnUW9/940M0tliYRtKBIrVybCto88O0Xe38hmvhjISru6mqgx9zyPcTkTpoSGg9xe1bE/7F9tPdKCFKCyevKNKg28tbiOlKj9PQ8SCIFPVIMDqBfTx3Gy5qDASUh4X5X/0/4rOJwsYqtCVkFEZW8hgmdw+qg003f+VzW5y0fiV4gIxhrRQsRWdtMheTUnMnq6UsUHxc1y5zHZqn9eNhqgU8/PUYkdScYrmh84YYQE69tC+cnjzFFOtVA3NjaO4qPjKFf/LAc8NvQ3L6uBuWQl+tearuuBWzUQNZrgF7txKMiWkK4gWBXiaWqbcAr0DAxcE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b19e54-af28-4746-2db2-08de1d3c561a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 13:56:51.3906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SE19/020zIeXdffhAT6Zo9G4SxINtnb3UBFc+8mE2SkTSUsEgNAmQSo81xt4KaGEcBs62TYmS3wZbIjuMaNzOTHYBAamVUJMLVZgM9Xcy0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4666
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEyMyBTYWx0ZWRfX8Nkz8Frlr0Zl
 6AqvSOKyCCpcfnJ8zeVxqBPaaNYIprQtzhXSz/oxw2VQE9OzCa+jh2DvvhLKKWKuo2DllNfQMIW
 kR6LgqOgPjG60Xx3iZNtWaCL1+phAcdfA4i7sC6XCwOaWKDxCrXxJHO1FwJJPSwF/wWzzig+8ED
 0u+ZvcPzDPifkWr7QovfolzciiqM2EP9ajdZ5YJu+y97tkx6HxT3v1HlBfi3X1Fj3e+mrY7ZC7y
 QnUaBG+J2YgG5+PM66lak9vIv0IEEi/qXAV1Q0iPW5xgseVGoM/3RdQPzadic2zQejdiEaVlNjH
 AoE7Nij65h+ZiecwfUKQJpKANRS6Vl4JSaHYsmEcrCPBgzIp8vC6MV7BGSz+ZizXf4FqPccFn4E
 C6X4fsurAdxtQups5kLpishJ++9zhw==
X-Proofpoint-ORIG-GUID: NOW2lVyAYr6JTKK_flybggKFIL7Dub4R
X-Proofpoint-GUID: NOW2lVyAYr6JTKK_flybggKFIL7Dub4R
X-Authority-Analysis: v=2.4 cv=PcPyRyhd c=1 sm=1 tr=0 ts=690ca927 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=21C9bfrVPfUfU2NVX8EA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22

On Thu, Nov 06, 2025 at 12:12:10PM +0100, Vlastimil Babka wrote:
> On 11/6/25 11:46, Lorenzo Stoakes wrote:
> > Currently, if a user needs to determine if guard regions are present in a
> > range, they have to scan all VMAs (or have knowledge of which ones might
> > have guard regions).
> >
> > Since commit 8e2f2aeb8b48 ("fs/proc/task_mmu: add guard region bit to
> > pagemap") and the related commit a516403787e0 ("fs/proc: extend the
> > PAGEMAP_SCAN ioctl to report guard regions"), users can use either
> > /proc/$pid/pagemap or the PAGEMAP_SCAN functionality to perform this
> > operation at a virtual address level.
> >
> > This is not ideal, and it gives no visibility at a /proc/$pid/smaps level
> > that guard regions exist in ranges.
> >
> > This patch remedies the situation by establishing a new VMA flag,
> > VM_MAYBE_GUARD, to indicate that a VMA may contain guard regions (it is
> > uncertain because we cannot reasonably determine whether a
> > MADV_GUARD_REMOVE call has removed all of the guard regions in a VMA, and
> > additionally VMAs may change across merge/split).
> >
> > We utilise 0x800 for this flag which makes it available to 32-bit
> > architectures also, a flag that was previously used by VM_DENYWRITE, which
> > was removed in commit 8d0920bde5eb ("mm: remove VM_DENYWRITE") and hasn't
> > bee reused yet.
> >
> > We also update the smaps logic and documentation to identify these VMAs.
> >
> > Another major use of this functionality is that we can use it to identify
> > that we ought to copy page tables on fork.
> >
> > We do not actually implement usage of this flag in mm/madvise.c yet as we
> > need to allow some VMA flags to be applied atomically under mmap/VMA read
> > lock in order to avoid the need to acquire a write lock for this purpose.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>

Thanks

