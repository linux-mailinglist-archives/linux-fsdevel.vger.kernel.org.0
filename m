Return-Path: <linux-fsdevel+bounces-79739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPX+IWR1rmn4EwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 08:23:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0EC234C01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 08:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D32D030055D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 07:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE1F366823;
	Mon,  9 Mar 2026 07:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a02bKuZk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zh7H0Ohr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BB318B0A;
	Mon,  9 Mar 2026 07:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773040983; cv=fail; b=r22V9dEcJRC8FJnjvU3fwrtdrU4gZdREcHIKsZyFT7OrI6B+uu6D/1wUGqDIQCQDIYpLKL2cNr8/+K9x/DiZJTdbzpPmRwne8ciULu21AMAKOH/TI1rbThnqSqo2y0M22zMcrbO56zBp7Cv+IDRpu62nEikg5UAT1RqTsa69XH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773040983; c=relaxed/simple;
	bh=Luu0x1Ep+z2GgUUhyv40xgQLAjUk+5uXV91rtvipiwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cMYsxT4LrSMv+j00q7+F23NDo2bsvoPReOKQQ1uO95E400aZhl8e0yoivsE3l610HttdgSF9wqSSZGmO8MX++vECoz+LBACDtz8l/SsMhRDgqO/roxERgE2R6LOA9ca1j14xrTYcl5cZ3TyhIsxWggDXNWucyFmIyXQoZA/b2Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a02bKuZk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Zh7H0Ohr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6290mI0J1004109;
	Mon, 9 Mar 2026 07:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VFuKVeeRR343OvwIs9Pi21PXnu5qHljRfbiVAuQw+QE=; b=
	a02bKuZkeKgTq2afWKl6+ThO+UJhhy5nFN/uq+IWYmabJEPSFrgDz7yIXu7i+bwZ
	eA0+Rs5tglgDCjx+vkyOM1skKkA6YToTQxS5BDFk6+TNYIMQUGT4l1LMcGFkrW7H
	KYlYdnSuCHP5UmTs9wxOzSNVvU1x4pr4Fs/WUdq5coIT0PPswDOkm8sZGTFdTqrr
	qSrzgo94JiKlw31qHB8RoLuzvCprsZmyDqtuHBjIyYiH3/skUowTZr25u31Pz6hR
	d37wNsHt5/zPPsCb6ckRj1NtFAVq8btTUJOjqUb35Iw3S7bIpviu2aukjFeWb0tM
	uckaDDfHM6KAQBlA9pq5mw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csjnugaqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Mar 2026 07:22:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62958WXe020504;
	Mon, 9 Mar 2026 07:22:30 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4crafcasgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Mar 2026 07:22:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irBMRjY6S8zAPJH54DkVvDWZcJPKg1yfC65k6SuSh37deYt0spQOR56HfXflRdaNLvashR14Kzzq44/GtoC/iXjrSg19jZszouvhVGoHBvDLZaAG/bQ3xub4vdWr6pDJichbjQ5O2u2Fj4ms+rKsZWkaGNXWQltpyGkrKkAIdH9HWW4qyLwpWzquKAEFpch+DO9Wd61eP181JIuNJCmiwLhWH6JUKq224gwXJZzgf9GWvyqU2XHtAhC9Pz/hyu89im+H81F7b0mXYI2n/gb/kpXtB/AWdW7m994UR9NYOjLmkqpnNkbNY50HPqUQFehs2BTg2G8MbEqMrw+430Axmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFuKVeeRR343OvwIs9Pi21PXnu5qHljRfbiVAuQw+QE=;
 b=homCn2QmEgT1napoJsLqbKyTB65j4ZtDV+mF/rCtRvPCbtPZDEvtuQWaAj1GOQutg8mrPinVlWKBaChIwt/cPEk3IuMY6BuXbzWxagDG72ZTcExznxd1RORwB4Z1GcmDHGWg4OGCB7uB5MIU2/rcwvAmM8JV2lVSrJWUbrDMOYQ8nnKXJpL+7nP0mQy24pzIPTzt10Kdece320gJ/WuNKptdUctN+bu+YQdiOIUE94jclW1IDgsyrK4PJFiC9AbzFeGfR8CCM7lvR6OUpOrYNjTwBZWpgeQLopxeDepMHrHA9rJw0vzkNj0UJVaC3vb8OzOLmdkRs+6GnXlYJB/6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFuKVeeRR343OvwIs9Pi21PXnu5qHljRfbiVAuQw+QE=;
 b=Zh7H0OhrXN2H9zL63Yv5DnVbycTOFSHBhkwlV35u80pABTVvtaqGOmkcgShkdJWT3qg3fzYImF9nslVme5e22ZJCA8IOfxCyylaSBTR/cU1IWvdeD0sCblRA4y08btoyjpOV4SabMVSuIXv6jLBbXfkHJXiAKgPlGoHGkoWklnw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB7114.namprd10.prod.outlook.com (2603:10b6:208:3fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 07:22:26 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 07:22:26 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: harry.yoo@oracle.com
Cc: adilger.kernel@dilger.ca, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, hao.li@linux.dev,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, shicenci@gmail.com,
        vbabka@kernel.org, cl@gentwo.org, rientjes@google.com,
        roman.gushchin@linux.dev, viro@zeniv.linux.org.uk, surenb@google.com,
        stable@vger.kernel.org
Subject: [PATCH] mm/slab: fix an incorrect check in obj_exts_alloc_size()
Date: Mon,  9 Mar 2026 16:22:19 +0900
Message-ID: <20260309072219.22653-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aa5NmA25QsFDMhof@hyeyoo>
References: <aa5NmA25QsFDMhof@hyeyoo>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0178.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: d217db01-fb9d-4f35-dfaa-08de7dac9d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	kHurEqXhkeQY6m6F7cdMHccpLaApLSy5h9j2R7R4LB3//JtJOSn27p/ICyJJuhYsT2DqRLf645MZXD3JsMKxHcV2g4CGp8LRLts8iy1Hv/Fu8QkI4sAgk4P8wW1ngIO2xGN6PFv/of63s/2SXVVZn/25kPFMa79rPT9hzfqqx4VzduvkDjbgvoGaBkGNvH1tDQmrr1ZraM2Glmukxg2RmrUBI5mCMlL204RSvxLYtYwafQsr6IfbbIgCF1IYFU6DFXfdKjRseBntA/ScQuRDfzKIuAMjzWjFFgtsh2WK1zaGawQ+0iu+3wdZ2dRKON/n22wCWJZepKFV3RDWDzfDnlnSpejcaeZGAlFjRgp8GV56ZQmv5sD/rqqePLzXaN+EIAHhNdscRYjiJh1ewOtYXIpuSQRBhGpvpi/8EdbdVDUTaW8JQUvwlTIZRA13WcuyzRPzURi+XmmPfiuIHkkdPDbvcdMgyAXQzHhqWo4JOVB6JHr2RgccnTGegis0fJ61AA0xXIjnqVueypIzVryqU88bwDn3xfrhYF/9PJMip91RiSjiBa2vqE7L+pGJybzusuEkD6V15wjOB/vMwsReG6XP0FBofCujAUsrMpK/Odc42RINHODXFzW/mq96kkq/eKKJJIjW7/TODY3av2vayyRsuy1QdKJuPU9sCgYMlKfICkRXGQFuLFYzSJo+aboR48CzY0xRc3+KyVBYurgaTOC5A0eOLtEkQeZ3Yro6aXJLgDFTW6jKHhz2Y7JcMXa1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?loMtXRLgm1w1x3FC1kU1a91WOYijhEXOPb0pReod747/34XFjUpwxOTcLadr?=
 =?us-ascii?Q?/7tDeUzNoM3xVzY9zphfF4upA4mbGbr6hH4RhghPEScD2hvo+hwlD4PO7rZ1?=
 =?us-ascii?Q?cyJSXhsqbGpZuAuqPKZeOINxZ0XL/UTOEIdLCvXR0AqRzjUrS8e+IMsbHFrF?=
 =?us-ascii?Q?onT8JQf1I0cBd08FOnOYBrbxq9iQBqSruieWnIe+GCIJqthKQfuD215l/qFO?=
 =?us-ascii?Q?pubyGLZGZd/FUQCp4e5zq+36CAEzgEvobEUCT8q8rPcRVdOAQTWgKGSPVynl?=
 =?us-ascii?Q?K+JEOejyV/vJq33VSgdjrHf7WCQ5fW2+FawWMgMrqiemR6kQZOz8KHAZXZOf?=
 =?us-ascii?Q?6sLUQf2IJFXM8y6aQPwMHFLr4G1GiqwFEBoXf38YDIanQT/rxGcrWqBcqcIq?=
 =?us-ascii?Q?FwCVFX2jSXMg0+zZniIQO37V/70plSTkCV6FIRBCuWsri7u1zKUxVcebvfm4?=
 =?us-ascii?Q?VVNsvA5pgvJBZIlEFLtjltJeUkvAK0JvePA3XLgJktnhZmJnoybZCfEroT+c?=
 =?us-ascii?Q?J/wDpfdHFMJE3syMBJuSXg9rTxH+HvHdW4U0vDq+2hXiINFy20pEUlI6GTcp?=
 =?us-ascii?Q?x8mzS+EdHWDtq+VMflgFK9oYkvHOPubrfd7Za3Uh6+5R063jge6LdLBy1f4/?=
 =?us-ascii?Q?ujWEPzQs8vrgQgK5upBt+D8sUUq2gofOrKJQ09QeLbGNetYli7mEo/DbB3gq?=
 =?us-ascii?Q?eDLyC5y2x/QaohOPtEggXtJaQ87ek4AfTyHRFCsW1WRP5mWplehNoLGxRqi8?=
 =?us-ascii?Q?npNdrGYFXIzAc01DfP14L9G6DssoIsjt7307NBAmvf7GZ5m69enqT1gJlguN?=
 =?us-ascii?Q?XE+QtD3fufHNXvvcziL7EEUSH2Mq7Pwvxag7Ba0LDoV7fLXx4R3AZ3jtts4L?=
 =?us-ascii?Q?r6pWfyY6/r9gNl9Ip8uy+KGMhauuAmNHDxlQQAaH3y1BP1AW71cIJsVtwzgp?=
 =?us-ascii?Q?UNrP6b2ZlqH4sZhWuXHYQbrl/Xz0FzfC3RRL9hiE4UtczXqgIwZB9DA0AxUQ?=
 =?us-ascii?Q?8WBWKo9q/LX/9k3E1iAQlZ/SdmVV98Vh2bU773M2ronHcwDQ5zt35jhfX2T5?=
 =?us-ascii?Q?/sHXdvUwGYAXxAgWm+Gt0nDJo2pXlmzTMDNIAsBtIOE61ChOg7Rnnsr+xrHB?=
 =?us-ascii?Q?0t1kCaFRXCX0GvYdjwSD2BoqewaF69HF7ZnHSKom0P9Acc0T7r3bHQXO9ey+?=
 =?us-ascii?Q?CqI/NtRa+RTJyfSDB6phcPlBg0oQ25cPSx0SjpbnIFjccMMLTR5/czneREjg?=
 =?us-ascii?Q?e3m4jDNpUMeMnzuaGWoU1p5pnRdL2iRhTcEOY1AsBVmDiRf5eams87Wd+aoJ?=
 =?us-ascii?Q?464s3Gw5RqgAWJsZBJ9xInciEYO8HL8Us9kCIcExZF9PAMIHOlOQ0RPXLaiQ?=
 =?us-ascii?Q?4RLkRW8/0jNTRPosEOnxwLztyMHaZkBqToQUYwriTZiYcNtWSnCnL7akh78I?=
 =?us-ascii?Q?WC30BOA2gA0xkzMCeAElyjD4nxrTk5oHyvfY40Ywq7P8aIDzIuWFFkNdsZoP?=
 =?us-ascii?Q?sv8TF3p8+nenjCkjP7w8w/32xaZGPP28XUG0RTbRs9KimwuaTN+/BOV4zINA?=
 =?us-ascii?Q?M89EE+KnTjwdK0wR28C4CJZtgZNg6kT4Xcw+1PoPs7GgXratfei9BtH5lT03?=
 =?us-ascii?Q?Z9KPsk5y4PXdDjZaDmocDPBpyAaFJuJvZiBNlLzqGZblwySx2Byl5JF9cpJR?=
 =?us-ascii?Q?ocU5HAg/sKPsEPAmXLztf1Z5hrFqeBLWoHefDZPcZv+mdsAYV7D/hGNh5qag?=
 =?us-ascii?Q?zMNM1Qh3VQ=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	taoHvnRucBs3DFkB8QH9GbyYEF4pir8u+kadWvHtDScSfFy7hEE60NFW1n7ZSDqEFEiMGFFavqApx69tMk5Va/gfQ8D2U4U/e9Hbw/nC/VrqmpaXhQGnAKQYAMo/xscfc+Tn9yBruzaAzHrGXkKbSPLBgDVgbqif8XTqi3kr/+J0pzZYGnpNa41+hXuChSCnnonTEuRpYIjqFSFm8dt5EVXn7ZCYW0XyCrKC2TrPfez/1PMsW0wjGjBj87ZdhHkEGZBL8JiwFbWcPJFOeTkloS2NwKnL9i4/D3SBT319QYo3jSxviL9I/91okBLD7T6kvQUBb16pvZOBk19OltQvEA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8r974mULjT7E8Egi4czwaljXcgv2gRnr40WV6alzIAjDvzJRwzpEa44VoOdIf68M3ZR2zXpl933Pu0u3G38f/8Wx7KIuPPvjj52ctaD3+ZygokK/tcwuMaVF20k3mjciuXeoJC+LRgdEYhE9KtBug5kwIZV2iOzB6vxuFpdFlcK1QoWvRpRGSsF6mrbwnxCoX4fcMNV2++qk9i5pxfYWXYEioW1ASTnDzsPPcG28RqzsG7KuK6YxVMTyptR7M56RfmiLwTO9A4snue7TOWb8Made0Z44Ktf7cH5eyZokbOVB1/TFKuJLLTKMlKT10DzAxJ809TdDdTRWV2WfguxcdV+1Bw074eexAfvkocm8MxR6Z47CqvOT1jo27q3cjw4CNLzkXQOoBIUVyNOm0EIAB5rbkl9/AJCWQbZpYD1DS1xRotNa8UChnSEvRpI8KZ98ReGpOvzFLKlNFxWaLVzXPukT+5BwvNqwFap+qTq18sXeMmxyhwJsFrpPVQ1Sz7y/dRtW5aM11YKToJR6csALMtZgHrG9zHK+1TsR2Gcoyak4Kj/PulfVh3yCnEL8pMVvnvLie2XOVu6NbcMH7GiIsGb+jRr63qHanPCIzFsMpH4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d217db01-fb9d-4f35-dfaa-08de7dac9d20
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 07:22:26.1029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HahCC2ONnymrVlHnPMuAKXpM5dbI7Z7U0WmlwWsuYG7JlyP+HAqPujskhg9qWzWKzt4XnjyNi956lJi5amqrzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7114
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603090066
X-Proofpoint-GUID: 5adgi5nH2artCtbsByQea3dtKdDiHb-7
X-Authority-Analysis: v=2.4 cv=c7WmgB9l c=1 sm=1 tr=0 ts=69ae7537 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=qgwYbtkUS2zLDHN1x-gA:9 cc=ntf awl=host:12266
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA2NyBTYWx0ZWRfXw9Uf2tN+wiZ9
 hfPrICOlBc+JPJI19gaqmzQOFO3tzAFIxWUNaNQIFKGga0P/Qnp5+12i9Ry0SIlfm7aoxqyk36r
 M4XMrREIWTlOzofQXjK725KZkPWlIcLiWoj01pcCPg1toYBAehBLKKkNIkLvfYU17EnH0FSVJsP
 hrG/Os9lJYxgwlKE0VplGwS/NYpZN+vI9IlB1bKReZhXooLwD6tN+YyYVnvfiIQIrUziDefYMl3
 VFT9wqCnjprmXNr5w8C0f+JkL1jTG/QgY06LALKDDNi/0TCw8Iei8YAA+3joIjw5LDyTrcKg3qu
 mGGQfzyubtjD7dnoZWNvm4nVeTW0a4OOyGt2ynz5nTSKCS1Vspqv+K/sIlXN8ixuTbPwjhEiHir
 xeoxBkDLAszhVJAUWiZ97qIMntdHsM7DdUHkiz2V/ExLfiX7AdM9JVt/yj+RkLlQYh7ZNRPJJ+s
 HuxBFfIYHCg94ns4BiDSMNNDsyCx0Bpglc931b1c=
X-Proofpoint-ORIG-GUID: 5adgi5nH2artCtbsByQea3dtKdDiHb-7
X-Rspamd-Queue-Id: 9B0EC234C01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79739-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[dilger.ca,linux-foundation.org,vger.kernel.org,cmpxchg.org,linux.dev,kvack.org,gmail.com,kernel.org,gentwo.org,google.com,zeniv.linux.org.uk];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oracle.com:dkim,oracle.com:email,oracle.com:mid];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

obj_exts_alloc_size() prevents recursive allocation of slabobj_ext
array from the same cache, to avoid creating slabs that are never freed.

There is one mistake that returns the original size when memory
allocation profiling is disabled. The assumption was that
memcg-triggered slabobj_ext allocation is always served from
KMALLOC_CGROUP type. But this is wrong [1]: when the caller specifies
both __GFP_RECLAIMABLE and __GFP_ACCOUNT with SLUB_TINY enabled, the
allocation is served from normal kmalloc. This is because kmalloc_type()
prioritizes __GFP_RECLAIMABLE over __GFP_ACCOUNT, and SLUB_TINY aliases
KMALLOC_RECLAIM with KMALLOC_NORMAL.

As a result, the recursion guard is bypassed and the problematic slabs
can be created. Fix this by removing the mem_alloc_profiling_enabled()
check entirely. The remaining is_kmalloc_normal() check is still
sufficient to detect whether the cache is of KMALLOC_NORMAL type and
avoid bumping the size if it's not.

Without SLUB_TINY, no functional change intended.
With SLUB_TINY, allocations with __GFP_ACCOUNT|__GFP_RECLAIMABLE
now allocate a larger array if the sizes equal.

Reported-by: Zw Tang <shicenci@gmail.com>
Fixes: 280ea9c3154b ("mm/slab: avoid allocating slabobj_ext array from its own slab")
Closes: https://lore.kernel.org/linux-mm/CAPHJ_VKuMKSke8b11AZQw1PTSFN4n2C0gFxC6xGOG0ZLHgPmnA@mail.gmail.com [1]
Cc: stable@vger.kernel.org
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---

Zw Tang, could you please confirm that the warning disappears
on your test environment, with this patch applied?

 mm/slub.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 20cb4f3b636d..6371838d2352 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2119,13 +2119,6 @@ static inline size_t obj_exts_alloc_size(struct kmem_cache *s,
 	size_t sz = sizeof(struct slabobj_ext) * slab->objects;
 	struct kmem_cache *obj_exts_cache;
 
-	/*
-	 * slabobj_ext array for KMALLOC_CGROUP allocations
-	 * are served from KMALLOC_NORMAL caches.
-	 */
-	if (!mem_alloc_profiling_enabled())
-		return sz;
-
 	if (sz > KMALLOC_MAX_CACHE_SIZE)
 		return sz;
 

base-commit: 6432f15c818cb30eec7c4ca378ecdebd9796f741
-- 
2.43.0


