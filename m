Return-Path: <linux-fsdevel+bounces-47819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F46EAA5D51
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 12:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135649C4E21
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 10:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9723621C19A;
	Thu,  1 May 2025 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bYleCvcr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ovIOMz8M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1701D89E3;
	Thu,  1 May 2025 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746095918; cv=fail; b=lpr8mY05TbeDxjY0FEFnTP9ib7Q3tbr7zoNpgVnG1YHhg1TL0o8CyZzPbve4Q87zFBRLt46NWeikl+96LVjIeMS5d4bWZmmQ0CFtUoSigYTDlfsNmcQ/yhLPx4gTVn/kQkkHu88q44ESVgvMfYy1IL3klRKllwL7rIH4E0Zl/ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746095918; c=relaxed/simple;
	bh=MMvqR4NHifnNIgIIq7Bt25qj9fHGNaHFgraqNMgVHog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xy6aHR0nmtYwz87W/o+CYouMGn4MPIm3VBkl+vdRMaPoT01JD6OviLDeJnjkN94MMRG9nXlZ8fmT/CbVvYP595JL1ujW5a89aTA5HcKUs5PBg/RXpixzGfVPzx1+4NDGWHSRBzE9iLM1HBYffKKTwpSPNb/mtAVbBa5S08eoxA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bYleCvcr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ovIOMz8M; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5418fxEI016754;
	Thu, 1 May 2025 10:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=gZEynNfEsLQ40cYRVO
	CuBIyfGVF1RJX2i2zqo3+ZNck=; b=bYleCvcrIL4We1fbhf42TYBSICAP5qeiGi
	FlRdrJGaJnPsq6wkd24tk9d7OS2hNLA3sAy3WYNuer+621SxW2YNdz5x/ix8mjkm
	/VckMQ1PbXI3IygjqDg09HK6QXUnjvrt3BWPLvdoNDAVxWM3LQUhDGjxmrEoJJeZ
	XVAK6hF/zQejdbTzpjI4EI1jFMbkQJ8P97yU1SOL1gKv830GfwM+9LR7VYGSoWy1
	qmYY3yg0Vz2QJixekMnxH6fKslQERblqoViU9+Kze4mBqNtHZGbuarOYoKmw4vKK
	TiQj3cR05PCG6kR1QrbFnosNX/MRVdH/IT94T6r3QMqxXN58B9fQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6usjusn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 10:38:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541AUu2v013885;
	Thu, 1 May 2025 10:38:21 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010006.outbound.protection.outlook.com [40.93.1.6])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxcdyac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 10:38:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DD3129h2bYjCrL9PnTII5b8b7/c5EXp28bxEWFvWxI/YG2nybhaXxhSDVVApmjPTx2ostCDe9XDF6tjC5c6mr+5PcKIQDzyt9k2F5vV98s05+NJzbIy38mukxHC/injp/p7V70AesltHfSgVonKY5Ty7mb49vCBD9fZ2X0mJoluKvpP9wJTflp3fH4T+1yLoHD4clRW4il4hPVRI6X0xFoEL8fcpdmmwiwOoLPnYfRA4zXFbUaWLZ4P4S9GnEMZmpNKReZddY5z0+Ih4RTtSTYr9uI7J23NYEOZIyS5v7CV+AmHdghD8wfBU8TMo76LAIwTC3Jena8smgJOY5DnqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZEynNfEsLQ40cYRVOCuBIyfGVF1RJX2i2zqo3+ZNck=;
 b=e1OjQUPvhaFLFnBUJEspYEXUWfkFw0ip48tBwNhzAh1diBy9yxrPH1ueB2Hhj0Z9Hzfb+blM5qxLxYdNsb2jOWEG66XShSpN0+HC7nVytU5GdXb6FMEOxtALeYZsjum+80pbWXJIEBB4xI+0hWz/M82U6ZOIrsJTlvp+KlSynsEMOusbcZ4Slnaztnoym1pHVFmLYF1NsM85reaOXJrly5GB2iCV4MNmm2U3eoK6maUXMTij8YDXR++QvtR7DU3vp6x95anvg6I02x45YMGLdzfCtl122lCLNxZ2h8yLg1ZJkKGr8ppH8zUXBBV6e4btqhG4ClczLySAXrWrtsraVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZEynNfEsLQ40cYRVOCuBIyfGVF1RJX2i2zqo3+ZNck=;
 b=ovIOMz8MT5gkhNY6q3xxq4BHsS5BETBTp40/YxpxV+gK6gs+2Sp+B+XWCcJl9tbzD5qArWBpO//iGvD9+hd4/VQxh5HQoeabS+j3Vd5gGdg1AT2PZh+ZlayeFiXhXbEoLvIeq74lHKyVM6GCeIS2mLVbsKDAcjo+GF4TQjQmHc8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF7113AF9D1.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7a7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 10:38:19 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 10:38:18 +0000
Date: Thu, 1 May 2025 11:38:16 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mm: perform VMA allocation, freeing, duplication
 in mm
Message-ID: <bd42b6fd-77b9-43cd-8e30-b6d38d5e39e3@lucifer.local>
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <f97b3a85a6da0196b28070df331b99e22b263be8.1745853549.git.lorenzo.stoakes@oracle.com>
 <c1acc2a7-5950-4c56-8429-6dc1c918e367@suse.cz>
 <5edc96cf-4f48-447f-b5a3-7e38679fa3f0@lucifer.local>
 <20250430144236.1877ef24177b40cc6a007874@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430144236.1877ef24177b40cc6a007874@linux-foundation.org>
X-ClientProxiedBy: LNXP265CA0047.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::35) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF7113AF9D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 5342917e-8e20-4571-a8e9-08dd889c49a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X9Ehegt29XGUYjkTGoSWr3iKEJh37x2PdqlP8yzd8TVd4sIg5j67VDZfgerG?=
 =?us-ascii?Q?cxbFYE7ZUF7y+qwzebZWIw+6PMhx8eT+sD8oUhC8DkT5K05QX4t6GhILGn4O?=
 =?us-ascii?Q?57bpqlycF0z+hdi+VlRIOYhoKYjQXs1iSev08WdMdU88XvdrXPVdRrTpcrNV?=
 =?us-ascii?Q?USxn9QygPdWV9GdVyRI7utQY1AZ8Yt6XHgkOLBlQNyhlJkSljukplZjP8S0D?=
 =?us-ascii?Q?XR/XTxlmKS/OTcByjKC+GoiQjABkJTOGDerHGGNsVdqWr5KaTN68e/Q80DsT?=
 =?us-ascii?Q?N8MhGUZTYImEv8KgPns+9ybi4ZkxhaoFDYAQrw/c8I9bi2lAhDa1S1owObNE?=
 =?us-ascii?Q?xax+tciSh8bT4lYYqH9ueesTdhRNtALRzKhBRfjod+O37Bi/ZMV7K8GbhT7k?=
 =?us-ascii?Q?PLnAOUFSp5w+kJsvD2O4Plz2rNtTebJnITWI2YHUqKv5PYgCT51RQmZ0nd0M?=
 =?us-ascii?Q?IteAniS0cUldeS5EgmZTfQqb/G+b1czQsUYSwiap9o2QXdVZgAzKB+BXOiQ4?=
 =?us-ascii?Q?0+apPClUSrWonp23Ue6GuQq4ZmDDXvYayQWrwpH1W0FC84WNhd+GguhfMsEA?=
 =?us-ascii?Q?Z6VojWLQ7VDJX3pYSsFHZ266isBAiOeTX8KDXmVyhsPSijzGjlj3ZYBLFK5Y?=
 =?us-ascii?Q?J2pUkka1OA7ZdXu9R5OSHz48edKZ4VSfc5JQO54fEeuoKCtORAxajHzPIMfJ?=
 =?us-ascii?Q?1uwjpwD5oo8inTWaM3J5ID8z//woR/TpOjLhSoJUMFkmzlUZGGMU1wbW3GEP?=
 =?us-ascii?Q?CnR342SThoOy2N/dqRRVu6cAqs24s/XUOF/qsnqyIUTj4PRAnwzl3VOOdTrA?=
 =?us-ascii?Q?9+MRZLRllVuNz5CeLTuYetQ6JwiQPQdy4ByjgGlf+j+Ode/L/bxeup1GQil8?=
 =?us-ascii?Q?cGWXm01/HyqiVxSQyTUM6p27JlxfJF1zlDbGxmzlydWU62eqAZkPo2CH9t7C?=
 =?us-ascii?Q?H0INGwGPlk/6dBGws3+FejxzlRAx3dLyLLpydFNh40hok1plq9Mut10CMhqW?=
 =?us-ascii?Q?21lUAfZhdbOIYPOJeDwGqBUB1fFoQ7IebhkrNHUWe+zAo9GgUAlastVWCq6+?=
 =?us-ascii?Q?tfSJW6vFDJUn/BRMzX5AMdniNrRyfknFMG2PazYRkLWw2J5MDFsF8f2a2ihg?=
 =?us-ascii?Q?Z3RDnfJZUbZOgnyNnWXBtzvOMOetP6FAfMVTzGrBvpUSrT1aulrmWlw+9w20?=
 =?us-ascii?Q?JLNZ9VWs0kSFDfbFvnFLtrop2xJlyP/U54pAopFwpthVtRl2KHCCe6RMhMsj?=
 =?us-ascii?Q?omVh4TVYqOjqFRqNJaF2sh5Zid8bFKU0DenahPwecCTeRnjX9RrI5uXhz9v+?=
 =?us-ascii?Q?WnEZ84Z/6DtDdJAzbGuZk+eGyWshfcXJa4gDb2ubWq/Z67++WipEIcua/wZL?=
 =?us-ascii?Q?lyAk+I0tiq51hcesVm8McSv6QZaglFdINYymJc3fFferBp76th1wvW1FClg0?=
 =?us-ascii?Q?+rY7CDITNSI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G3LYLt+BWDpdZJIJ6sARmVywoCpTD3ARAZuJrNgpCS1ThddPqBOMVvtUBtpm?=
 =?us-ascii?Q?aDqrmwIX3gCuY2JJZFPzpekxobZrePmHXJVwgB2BCbT/onXymW5J24LiUy92?=
 =?us-ascii?Q?/S5wbuTcjfTKLrF1/Qh+0V9KJhcZM8ktAQc8gwje0tn2KJxe2ilTx5QDjM1N?=
 =?us-ascii?Q?jLFhdXnI3jrP/SNVg8oQVzWZgK/ACvf44jwMdYCoqYCV+Cui1mFCt1C/c1NI?=
 =?us-ascii?Q?bnXu43uXTa+5KHIoyVGJ7LJfBLYhe799IUpuoBGXuxgoVc11wtUjzD4k+GT/?=
 =?us-ascii?Q?T3fDT0pulbVJej8zdBrCqtBMzUxqQYIgwfV1Ab6tILPrGlZaWna++A/IcSWY?=
 =?us-ascii?Q?2YbDmtc5LpMYg4dy5g7pm1DI4iLA1X4pM2MnA3N2BuVkQBvdjg2sHsPBaxc/?=
 =?us-ascii?Q?0onRXfSdn14Wi9B40RENAJpbBnFMQH5zEXu8ZTE+G20NeMvN4gkWNOgN8R1i?=
 =?us-ascii?Q?4BEyqNwFazfSykpU2Lnwxmfd//K3DuOzfLdOQyUhjLpi7W8LJzr5POZ2ceCD?=
 =?us-ascii?Q?Ya93lEDpJaxLMi9YRIGilXeZPLM/RFS4n2k2NlpXAbiZ4XEpJJsWlXu+oZjF?=
 =?us-ascii?Q?+bvGfDBnSVrSNQr1lZx63GZecP+h/NGMerBMFdtJvtREoZspSRhKox8gkiLy?=
 =?us-ascii?Q?WiiiJcTHBErikamuD4VC6m2Rf4N+JRgeNzFqmf2JjOMrfbXb92/ON69B1wkf?=
 =?us-ascii?Q?zmjdHGp7i4ljnfKIpZh+VSthTiIIPW7mUXXjoeXU7fbaWJRm/C8cpwu+XAyq?=
 =?us-ascii?Q?t5pad/TDjafxT2whyYNiJZPQenuhETb/8ZSjgplm16wmSLQvMHjDmAbq4tgB?=
 =?us-ascii?Q?QA9IIJafO452wyeTEpPqheiWlNjKsPmJSlV/KKTDYJE9UFoJs8lhmG8+fw08?=
 =?us-ascii?Q?BRvrQAwfBLp638kDR8gehqMQhkO9TvSXfkBdf+5VWzsFCexE8TfPeJ0f4xU6?=
 =?us-ascii?Q?mYX+lVChd8i7zzwZAf+U3n++w6YAlXhJpGTYgZ456tnsfQAR9ntFrfV234Oa?=
 =?us-ascii?Q?wTRKIfMtUq6bm53lUwEa1bmbX5piWaeBTuDKxxAFUmmr7EBdlMhze3XVC7rh?=
 =?us-ascii?Q?LXP553MODjZDULmYIcLCfFaTaqGEI1553LhMnslqkDWCe13irU169cMaLhle?=
 =?us-ascii?Q?9C+ggZJ+fxq/qvb5NaS79I/z6f8ii4pqw13g+1LfAo1noLEIAPBeAjzdd6bY?=
 =?us-ascii?Q?k4pxhP6nwqqUouBVVKJJGXzq4V8PDzKLENDU2ZrS6WRtrtB2b89m1jyo3nlg?=
 =?us-ascii?Q?r0lvXzXSsgByjiYrzj9hj6lQmzxJghWKnjNjt4Coy7EtkTe98ySU8pDLwLgs?=
 =?us-ascii?Q?mQheO5uCzBazXIfnq5RNlRLd4PeZa3uvAmbOlF+hBfzvspNRLZw8yfaSP5pr?=
 =?us-ascii?Q?1YnvMt2aEsUCd/w3muC6+cDk5Omjwbl0BFAo4TSdS+K3O4zCpiR+yuDLGl8/?=
 =?us-ascii?Q?3agCmihGXsk7WkiSU8QyI7Ouc7nOpkoz76yrj8hb2qB3l9gcm4AtVGFqTkMh?=
 =?us-ascii?Q?kEYbnD3PR0dXDBVdWeffmy6787S8CcTz+qO2QxVa3p0h9NpcKWSo1/O4vbU8?=
 =?us-ascii?Q?8JpcsH83iq94rb4GUffuFrUiQO1jKIYWFY4FIVpXeqEqzt5JaRfpIyV9svwX?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IlZJM+rWgY8o/oJkvSxknv14QNUxGOe1idW6+6ixaUPFawBN7591IiJiWoga38SyRMDijTT/wRarQ4vx/COMtqSLIWVuTR9DAIx8fIMj7BJennfehJsTafzDTMY5hVf5vF3CM4BX3/i3OriUkV/VnJJM3TmwvriRvgueWety58K6/gxeU9rgKvOLNkWfMsdCbVledrz0yQEyuQ2GNTi664EUb/HxhNv8kAHowCVNRs9Q/pWDXIugeXdpxSw1G9k0CSdAy9vNt35MQ7NMe5YWDjVlBQ770CCcJHseTDmRgE0MIGZCy4Qk49aNY0ljh0WUnU40O7BgU4EE+YPXw6He7/AyX3h2LR3zbTJu8m8ivDWGg1rcNXSLHcXruMhrR1M/Gq63ow2wR9+/bCXyjqDkSi1PKn+I3V1ffVVe7TFs23I1gtgSZ8dBXL7Qd49KdPhdZ23jvCNd/O2nAFHMlTe2sVFWz5jQH+XlVhKoZwXZwLWqXsF6F+So7/Yp0ZUplsD4qce8/rSFH6AI6fFeQNKMnMXypPwwYY8VgZmfryI3lAme0VWNC4PqjM51T2NjWFgMuJXcGJG0AFmUHZKNlpzWmPere89XrlB0USnBiHoiZkk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5342917e-8e20-4571-a8e9-08dd889c49a4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 10:38:18.8994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sn1MUWZxFqS+CKJQIO2wpMWbCpm9P7ev/JZq+/OQ/2x3IIuRRemmrLacaJsZQWIyFR7v7Zfm7E+eS1VSeKwGEB2eEssP7KkdymIAuCuNY9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7113AF9D1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505010080
X-Proofpoint-ORIG-GUID: 23rx3XFCIiyWeWXsnP5HU0L3pm7NJer3
X-Proofpoint-GUID: 23rx3XFCIiyWeWXsnP5HU0L3pm7NJer3
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=68134f1d b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=207ZRDXqdZlhcXymky0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDA4MCBTYWx0ZWRfX8PJNv4md0weF QKMyC9o+V8QvNicUzVLxcqGk2p8dPhy7Fu/v9fJTW0chkvmbcTT2iGuNtqxVudqDngh3yVD/mRV D64ruzQOT86ZJYppfvihv+bd46SkrWkQRfUK68oPcO6+cjbMVf0906kqGfgvGgF+ahVZLrmQnAF
 w5zwFhQRGpXPRV3otI0iAdVnoU6U2yftsUgZNG9tbj8sKr6zkmxXJxxHlZ0txRqJ12u8VU/dgDH Pai0AbCnUot5cbJ4JPW0ONPebqzcXDl7QNqoyGh9roHMNwJPDs4oN7dfxVhQQFPsX8IOZvKyxuC dN0RIcT5vUh//7tCoBD1q34pnavXiGaOtAIaGPs5upGfln5tMjm5UchUKNVHr37PkqqzID0NpS8
 SVNYGbed6e84ub3zxQex+nyGrceBXoaIYwzu1yof/q8eUyaIWKK3HNkfjlSK7fjNCAjCnOco

On Wed, Apr 30, 2025 at 02:42:36PM -0700, Andrew Morton wrote:
> On Wed, 30 Apr 2025 10:20:10 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > On Tue, Apr 29, 2025 at 09:22:59AM +0200, Vlastimil Babka wrote:
> > > On 4/28/25 17:28, Lorenzo Stoakes wrote:
> > > > Right now these are performed in kernel/fork.c which is odd and a violation
> > > > of separation of concerns, as well as preventing us from integrating this
> > > > and related logic into userland VMA testing going forward, and perhaps more
> > > > importantly - enabling us to, in a subsequent commit, make VMA
> > > > allocation/freeing a purely internal mm operation.
> > >
> > > I wonder if the last part is from an earlier version and now obsolete
> > > because there's not subsequent commit in this series and the placement of
> > > alloc/freeing in vma_init.c seems making those purely internal mm operations
> > > already? Or do you mean some further plans?
> > >
> >
> > Sorry, missed this!
> >
> > Andrew - could we delete the last part of this sentence so it reads:
> >
> > Right now these are performed in kernel/fork.c which is odd and a violation
> > of separation of concerns, as well as preventing us from integrating this
> > and related logic into userland VMA testing going forward.
>
> Sure.  The result:
>
> : Right now these are performed in kernel/fork.c which is odd and a
> : violation of separation of concerns, as well as preventing us from
> : integrating this and related logic into userland VMA testing going
> : forward.
> :
> : There is a fly in the ointment - nommu - mmap.c is not compiled if
> : CONFIG_MMU not set, and neither is vma.c.
> :
> : To square the circle, let's add a new file - vma_init.c.  This will be
> : compiled for both CONFIG_MMU and nommu builds, and will also form part of
> : the VMA userland testing.
> :
> : This allows us to de-duplicate code, while maintaining separation of
> : concerns and the ability for us to userland test this logic.
> :
> : Update the VMA userland tests accordingly, additionally adding a
> : detach_free_vma() helper function to correctly detach VMAs before freeing
> : them in test code, as this change was triggering the assert for this.
>

Perfect, thanks!

