Return-Path: <linux-fsdevel+bounces-67329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6FCC3BEB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 16:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 975834E946C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 14:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D7B343D98;
	Thu,  6 Nov 2025 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VVkJncty";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WCyR1HHn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6060433DEEC;
	Thu,  6 Nov 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440933; cv=fail; b=YpsKkZ2Wj9P4V8KwZWcmQElDrQkDCkKOAQrzIQRHZRT4vLWqTOt9Lqa7Vf7CjNyX7jwuQ17Y3HZvBaXdml3dM+H+KFR5FgT6GaXU2XnyHqI1TyLj1TZatbGaBd5VweHc258bHW965p4M/ZXngnAU9d3fWg7kldEOCaEnMibFOgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440933; c=relaxed/simple;
	bh=CwvveEP45K/Li844sjy/YF87bCzKhTeZlT6uLkXr5Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sYYRMULwjuMY8Go+Aohj0A3DDQ2ltQrmdUdnBAojzD8Jc1ClBazXW4p5ub5ppQQcuSf0J0LMViPeRvM9CNJAnwT+T97eLL8AZFsiLiw/rCxE+4+VZhMhgMKKPDz+D/ZLycEzT4/a0N9UMd6yZQ67vJuESHsDNPc8hIq+ARUwCTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VVkJncty; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WCyR1HHn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6CCqw8026029;
	Thu, 6 Nov 2025 14:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=bH8+hWj+lkWJxTBbhO
	7Qk3ipwHNKZclg6LZur+k5tJw=; b=VVkJnctyzfm90FIaYA1JfEUCmjro1bBuHX
	jFJoA2J7Q+8JRP8ZWjYsSbgOnabjfy5NxK+sOE1q7XiQApwDRkhUZDQCGKQFDQwb
	GaMASgtoTozKzIkkp1vqVPAYgo6UeGAoL8M5MSslgfVQ5DGgA9+Cj8sLmQLLCcO5
	GCZFLFye6D8tAp6baABKG7tVnMTauQdFmVsrmxVJF+gPrUKIvEEuEOx6OXtbVd0m
	x2qdD0U8rdIPpARrn8XZxwq0OBiI6iXyQOSxK9gQ0m4uGQHxX6qWb9NMhxkq26+U
	QJUhg1EQByWlxluq5NE8snYRPkC4+5UbCCTgmOGkCC6UFktcvwgA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a88akaky8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 14:54:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6EDMQX039458;
	Thu, 6 Nov 2025 14:54:42 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nc89ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 14:54:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXOsKQR6KvClGZWbBgNF81AHIQj/Yt1ftvM3v8oy81DwdrjslMBO3Vtz1PnyY0vG4Adug2/8KC22NTyUtIexxywL5pIly1STycUhzPEvlgKx6ae810a4bDWeb3Jts9kUydOHGMbIJwMw3pBKj9G9x1Lijs9p4qM77ae5oOc4q6SctspnTQy/L9IO7vAFKVTrpMk2pRikPyEdTzpA1BCOfhGh1yx2yRuigZnCnpGJ9L69HbSQJF4joiN5Y+KvGcwkgruK2yb3K4tFFzubTc0NixPAMHorZFzKJjKb35CFpqkI69gpJ1zZCk/YKVQS6jXU/3AleTgxxYgt05CCfLMZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bH8+hWj+lkWJxTBbhO7Qk3ipwHNKZclg6LZur+k5tJw=;
 b=u01UsCqDq4MPTW7d4XoCb+9JcbXjXRHvlADhtXAlOl7L83gx5dhTj8vatOpIoEZiq3WNiWalujsq+qw4s3KjyJ1OvIdu4KoCtY4QVx8IWp8FR6czb1lcJJ3AjQnpUKd1N3jKnMbPkUd7YwxD13sHW0kLu4+/gJvBKz/5NnxbHBEamx6/7NiJEQIWBTBlmurBit+hBJrijzYwBTHH25qWrQYKqRKcn34ccivfb9426XEsz6WnzkY3SOpq/ay3e8edWnNUDx87r0xHx5JsbbfBE319Sh9zyt5SVLYJsgeKwU7Rxql5pHpk8Si7hYGZ2VFHXDCBwg6OgxmzGnKad2pB+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bH8+hWj+lkWJxTBbhO7Qk3ipwHNKZclg6LZur+k5tJw=;
 b=WCyR1HHn0cBUcrKIPpz0F61SJUL/Z2y5Q3PmjT1hbvPl/6JROX2kLad4mMBB3LMF6zmhkXoIgPDqROC1QZBB2MFSp3Ao9Du2rILlL4vX5Il7hKbz4OE8vf/uFqES1WoKs13+2EAZzTGRumx8PXn7sZzkBJNJKmWTmXi05IJNZWQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF77807A52D.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7a9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 14:54:35 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 14:54:35 +0000
Date: Thu, 6 Nov 2025 14:54:33 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v2 1/5] mm: introduce VM_MAYBE_GUARD and make visible in
 /proc/$pid/smaps
Message-ID: <043dcbdb-e069-46e7-8f79-8fdaf354fb44@lucifer.local>
References: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
 <fe38b1a43364f72d1ce7a6217e53a33c9c0bb0c5.1762422915.git.lorenzo.stoakes@oracle.com>
 <yja2mhwa4bzatbthjjq5rolqlkfgcbmppic3caaiwi6jc63rbc@cims6rqnotvj>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yja2mhwa4bzatbthjjq5rolqlkfgcbmppic3caaiwi6jc63rbc@cims6rqnotvj>
X-ClientProxiedBy: LO4P123CA0313.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF77807A52D:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f86db92-139e-4169-ee6e-08de1d446718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qba1Mv4ygex1YENTs92V6ISXohcjBSn6C+JjwPZ8f7a2tlVGH5UP/F9ljhGe?=
 =?us-ascii?Q?Fimd9HNWrwDJIbqu7MVeT5fIzaD1uobme5WKuLwvUz2JNQoQ+bKAftSGo7bE?=
 =?us-ascii?Q?15SCHeXei8Gi/5w6PI4dHVM9y1Z+KUsbHwqVhowy/bZHjv7947CHoesCN0vZ?=
 =?us-ascii?Q?eGnWxIWiihxag2T00xjnvzj+hchlmRTIj/VkU3MxHq6CDkKNqW8dPOqKPM+Y?=
 =?us-ascii?Q?nKQW3VdMLgijsf03Odmu6SLZS+2201xYPKRDZ2jr54sGSCR1o35DruvKpCMC?=
 =?us-ascii?Q?TnG9M3Be+ETTkgkLmPo47Tns8KJ2c3Q9gEg+ttocG9L2+7DEqv/xm4of3lO2?=
 =?us-ascii?Q?qBuXw6dcDRgoFowgPHVUtkm92DOcLqO8+XbwIE1xE/mUTI0N6GfYhpIS0Brh?=
 =?us-ascii?Q?GrQyZkdjGRzPl9j4QbBnx4JnzxpJyQDWcL23SzMzME6LzArCtzPiTs5EVCsN?=
 =?us-ascii?Q?jpNUiJopFtP+PfRxEghfNxQJ1U8TDri1C/r+kL0n6PA/m7HKo01VRIu7HvK1?=
 =?us-ascii?Q?PWwjvrHiGc+MuNFGFW6y7DDuelevAtY/f5KKUGUaiE9kLnqjff8oW54eLPq7?=
 =?us-ascii?Q?HjYEFO9j8O5iUrMq6qlhOLP2+wgjojMK8j0n+jvsFQfutJYpH/c/24IOsgrz?=
 =?us-ascii?Q?k5ETAH5/+ENDI/R8k0fkfHzJ0AaqZDG8T8ScVDwWJNOgaTuTwqyfPiDEoyak?=
 =?us-ascii?Q?qFgyqkSk0yrlHPXhcs6okeO5X7gfFyU0CiVe4Nc5TX+lx3qG44NkGAx/wBQp?=
 =?us-ascii?Q?UKTmPRQ86B6uoGKFDeTWeGtN+bW35bKclZRVL9b7uu3WqgGb2EYfQ3MaW972?=
 =?us-ascii?Q?NFty4M+VsTvXQZw90WS4mnmYOc5ICyr6ws6828bwf9h5bsx9dpBgW5UmI7oX?=
 =?us-ascii?Q?TeRihlbFeXXHaNoQVVe0jQwowFs2Kf3L2UkOI6naVRAhDTcGxPIvaiCj6dNJ?=
 =?us-ascii?Q?Dt9K9XioJOj1SR7S25TwXU+ZjeamD8BHhp/CHWHWkQbkzi79Jv0657mpBxaB?=
 =?us-ascii?Q?wJSJ2qKCupEHuuACcnkKi9+R9rBWljqGJcyzs0C5bWXT3tRNlVftR5/cLTrR?=
 =?us-ascii?Q?+TUmo2494O9uCVa837Sm1MTBj2IQQ4W/pwSiIYN1M8RP5AjnSMeQnq7fQJcO?=
 =?us-ascii?Q?qlsYDsfDrNRGFWIZdV4B0uDgxmF73VZG9kCUIU4H47R8obZWSxfuU5Tejkeq?=
 =?us-ascii?Q?LdR8KJy2wW1zwiHLusa0RPX6wq+wsBl5NJ7AytN/+Jq0vKoKQOtQlwX9By/v?=
 =?us-ascii?Q?6ipbebKil6kfCua8zerLEFHJv/+a4n/6yAyczbrANUMWNzz+FmiA453lB1+D?=
 =?us-ascii?Q?J1WOsAyzJg/hPhV/WLyxj8iDbT3ilZEhfjFMVs3vHpYZKBG3knqkNTOAXhye?=
 =?us-ascii?Q?bep4IgmEtPTEscZn9y1FnPOdr1XqFNUxOC3n7ukKarD4A9R1wVR19jsXdlUD?=
 =?us-ascii?Q?ym79jKh70WKww2PcXZq8KdJ++4GWsF5wH7+Ap9dsIO9827t3GFgodw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mRVLqTsqXUOw+AcUytKlLAI7nk8bMKeyLDXv/1ky6qRNk3ihYOfpJZL4rVWx?=
 =?us-ascii?Q?hyn2JawFDzCGmGEAsWmZ4YRkIonfLnk0ST0EHJT8kSWKNfpVpSV+U6M8ik0B?=
 =?us-ascii?Q?Q8jI/LvNuf9TXzBxFpvFVe7grFkz5QIaWygqZn5anl3+NsJlOfPvUVuIkguV?=
 =?us-ascii?Q?v4DY0UWZHl9P+l6+T/mXZoju5ESgoCD9Z5jF3vRbCJoxarsABTmgpxQyYTVF?=
 =?us-ascii?Q?une5c1QhBG9y8JZ7CF428GvBP6+ehqjDPahSL3xFiyQEv/a+t/79f9FVZwgE?=
 =?us-ascii?Q?q5qZ6YoAApCPV16gK74p+CvZi0T9k48FUb0tMhF+4gUMHAE3YfQ3hR0Lx4/Z?=
 =?us-ascii?Q?+PyGasI5dJFXhtnJycwrss/QSaajphx96MVM4fBna8gajWm6yixm1Ap7fNmE?=
 =?us-ascii?Q?ECyMq6PstInfg0od+2vq2JF7UsEGs8BQ+k+IG8t/jrQZRu9FL8O+1dZcDyA8?=
 =?us-ascii?Q?SS1xtbcR415TYMfXTvkKeNtdWKHZcKKVFlIUSZcX8nPIEO9Utgaj8Z8G4yHe?=
 =?us-ascii?Q?Eg75+ECnTsu6l5W4/oINbOG7CETrdYe031TVsXyt0DTUnwkSmW+Lls3n0/Qr?=
 =?us-ascii?Q?n1vPVjJc9IRbvPT4GiOnFuHxOETjhS5PN/EsknFY9jbwHIcd6ALEnZgkMtwD?=
 =?us-ascii?Q?8/90h1gbwNUSi/JiiSVMuugkxeLN639/BQwibm3JV3vKR6YzlDDSdDGrl9TH?=
 =?us-ascii?Q?nkpPXeff4964P5nc5lqcnuykK3Em8seTXGZPXc4KRBQlVl6DUlcuju5IQ57W?=
 =?us-ascii?Q?yM0wbkdUI6epVuN7Ev4MV2NPcL8giJ0MGmzbOwvQikT3nM7CkDZqpYCoTmfy?=
 =?us-ascii?Q?ISbMtV44W2fxmnpoc+6A15u786GcrG9WWMhX4ADHKbMOv0u6kcVRB8dCZXTC?=
 =?us-ascii?Q?4fo0wUAy9uN2h50P/2cQiooHFMBPg04wGHa9E1tchGMItskpWuILboXb0QvZ?=
 =?us-ascii?Q?eMH5tLQxK7Ac/9pwRO1egu3hqZyICoZEC7FidxFa/Z4YqZnWph29RZlOyxBP?=
 =?us-ascii?Q?+DMLJ4xNrWY37+CAkJqWndv3CRDHYf85JI4SoFkZhXAGZYrp7D4N8Quin3aI?=
 =?us-ascii?Q?lpHrtn97o8z7oRwhSFrIutzt7WGE9tK3o9Qsv/NIv8UT2otfAzYKqzhBjvvu?=
 =?us-ascii?Q?JNEj07753d3D0YwzbC6cp3Ra+6LpOLUdUOJVEa144cvUNvm/LuG/NG05IE0Z?=
 =?us-ascii?Q?forTpZn8FIu2e/T/wMuSZoGPfz3bHr2zKaIw1xgsNM/nIlujft1IjPbwQduW?=
 =?us-ascii?Q?65+ucHedpKNVjTMhfLOkzEDGbl6HTZwOgUZj1tNbYdX/jvKVHyGQGK1/VZ3S?=
 =?us-ascii?Q?gVm4i2Li9om3dzFYgjpKLRN1Zly56IR82EuIFqgskceTinojARyQ6RcHc+8p?=
 =?us-ascii?Q?V9/lXJO/FE7kq0L/v5sTi8KknIifjy4iLDlTVLdnsxa9c475VXslOSfJQALQ?=
 =?us-ascii?Q?7IXgueELo6TuW6mx6Nw3Yg2KOsJlc+YEiAFESCpEJFwIXBEFZ69JPwXF3OmX?=
 =?us-ascii?Q?pUZN6AdVY2tGhw2MlpGVyjsvLUMx/dVv4KetHy9J9aKduKmx7aao66r7gYks?=
 =?us-ascii?Q?AB+GC/Cbr4blotsstQ/IAGrgydXuCgr7Myg0ynTrq1JbjuXp7m+nV3R72GYI?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7Xgq6YmJFkZH6ZN6pJfEc6kSOiWsyDHkE9XydvWxvk6+kD103wUmTYIkUmDYdlBEy7Go2UMFI3hpgFHaPKK3tqhjuXFqTNWM8X6RUAPzSz40NzVFyu6sMWjcFp0O1/QSDHvN3qdi6InJu16zgxC9sbzWv3l+CHTHX2RO8c1b7z7vkeTXrWcDeseuFqsgV+hrf7KJBMTzO8BbLyARjszdGrshUospyHnItY2xuiCLgWAe9o6ghduDImujee3ZqHNSGFXS8YzHmI4sPAZ2aniA/MK166huTGu1xlXomzf53YYj1GFTUuackkflOVh7E6Z49JHBkrGFXZcQAth7wcQRec12wukAB49EY5h0OyaBlB8Q/A+Fgxf0DsrMa7GAD6iJDuOU0ZTqOeB8CVjnduSqJJMTrMbysyml4h95sc0CniamguEOjjCAVtTvctuWvTvHvcYJYMUhCzuyMITKonprAcbnwYCeWmSms3/Hx1qpGUNa8pdKoPD0NcYJnl8Zk6dxhfB2i2urS5ccG3eHarfhKcGyTK7l25sBCuFKLV1n67ESNJsGbNGu73UR27jNbHWzn1+b8xdq6wWTamSwEkHLmpdbm2tVkfNELsIb1qKJVTk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f86db92-139e-4169-ee6e-08de1d446718
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 14:54:35.8511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E82oTuZ2Q+3FsEuEfP6Z5dj/SeQH8D/iN9/1o0ob+GPDoOeLx26sogIP8skaSE09eoh8XhOrHJH+xLp8fJTA0/EKn9Cf2NNOiYjUFbEcuQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF77807A52D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060118
X-Authority-Analysis: v=2.4 cv=LsGfC3dc c=1 sm=1 tr=0 ts=690cb6b3 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=gEQPEcWbqTh0S0zqMBcA:9
 a=CjuIK1q_8ugA:10 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: k2pwqknHyZbDpD11yn_bfDzrfy9ne2Mw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEwOSBTYWx0ZWRfX/fZSGi3qZO0C
 lyB7gdiizruk/Rd4dolH5/HBRuLxkA4zMzw/tb3Ke8ysI9jkRB+4mxRRQqVWJrwM1Nmeb8aXoqX
 z/HsOCoOWAP3BjtHqTqENuj9pwgBafoBafQzHsPME0fgy3RrnShg7sealVBHbe/y/e9xAeEr7vM
 78EXAyapkbIM6Dc4iRbTNRaiM1DBobljiveVIFyxRnN83UCPU5n+gAE51p6Nb3hB6iQPPwSRn/O
 +M1xBOq+B1WjqmjHT7GT7rt9ApoX1dHEOWUIeqNLJ4PrFghB7tRXga8GOlH4p7gzu+TeefeQSM6
 ae5Vwa4OqDrsA4GJ8ca4wDOiyeDC9Nh7/WnH3atHifIsKEV4r08ME00iHhjmjFS1CUw+o5Abb4q
 t6yzcIvK/N2HvgODxqpuCH+r0iPZpQ==
X-Proofpoint-GUID: k2pwqknHyZbDpD11yn_bfDzrfy9ne2Mw

+cc Alice for rust stuff

On Thu, Nov 06, 2025 at 02:27:56PM +0000, Pedro Falcato wrote:
> On Thu, Nov 06, 2025 at 10:46:12AM +0000, Lorenzo Stoakes wrote:
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
> > ---
> >  Documentation/filesystems/proc.rst | 1 +
> >  fs/proc/task_mmu.c                 | 1 +
> >  include/linux/mm.h                 | 3 +++
> >  include/trace/events/mmflags.h     | 1 +
> >  mm/memory.c                        | 4 ++++
> >  tools/testing/vma/vma_internal.h   | 3 +++
> >  6 files changed, 13 insertions(+)
> >
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > index 0b86a8022fa1..b8a423ca590a 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -591,6 +591,7 @@ encoded manner. The codes are the following:
> >      sl    sealed
> >      lf    lock on fault pages
> >      dp    always lazily freeable mapping
> > +    gu    maybe contains guard regions (if not set, definitely doesn't)
> >      ==    =======================================
>
> The nittiest
> of nits:     =============================================================

Sigh :) OK will fix.

>
>
> >
> >  Note that there is no guarantee that every flag and associated mnemonic will
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 8a9894aefbca..a420dcf9ffbb 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -1147,6 +1147,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
> >  		[ilog2(VM_MAYSHARE)]	= "ms",
> >  		[ilog2(VM_GROWSDOWN)]	= "gd",
> >  		[ilog2(VM_PFNMAP)]	= "pf",
> > +		[ilog2(VM_MAYBE_GUARD)]	= "gu",
> >  		[ilog2(VM_LOCKED)]	= "lo",
> >  		[ilog2(VM_IO)]		= "io",
> >  		[ilog2(VM_SEQ_READ)]	= "sr",
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 6e5ca5287e21..2a5516bff75a 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -271,6 +271,8 @@ extern struct rw_semaphore nommu_region_sem;
> >  extern unsigned int kobjsize(const void *objp);
> >  #endif
> >
> > +#define VM_MAYBE_GUARD_BIT 11
> > +
> >  /*
> >   * vm_flags in vm_area_struct, see mm_types.h.
> >   * When changing, update also include/trace/events/mmflags.h
> > @@ -296,6 +298,7 @@ extern unsigned int kobjsize(const void *objp);
> >  #define VM_UFFD_MISSING	0
> >  #endif /* CONFIG_MMU */
> >  #define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
> > +#define VM_MAYBE_GUARD	BIT(VM_MAYBE_GUARD_BIT)	/* The VMA maybe contains guard regions. */
>
> Don't we also need an adjustment on the rust side for this BIT()? Like we
> for f04aad36a07c ("mm/ksm: fix flag-dropping behavior in ksm_madvise").

That's a bit unhelpful if rust can't cope with extremely basic assignments like
that and we just have to know to add helpers :/

We do BIT() stuff for e.g. VM_HIGH_ARCH_n, VM_UFFD_MINOR_BIT,
VM_ALLOW_ANY_UNCACHED_BIT, VM_DROPPABLE_BIT and VM_SEALED_BIT too and no such
helpers there, So not sure if this is required?

Alice - why is it these 'non-trivial' defines were fine but VM_MERGEABLE was
problematic? That seems strange.

I see [0], so let me build rust here and see if it moans, if it moans I'll add
it.

[0]:https://lore.kernel.org/oe-kbuild-all/CANiq72kOhRdGtQe2UVYmDLdbw6VNkiMtdFzkQizsfQV0gLY1Hg@mail.gmail.com/

>
> In any case:
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Thanks

>
> --
> Pedro

