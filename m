Return-Path: <linux-fsdevel+bounces-40436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CEBA23544
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 21:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277463A6EF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 20:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6741F2C2A;
	Thu, 30 Jan 2025 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S/91QAB0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wp+4QXZ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEA51F2370;
	Thu, 30 Jan 2025 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738269668; cv=fail; b=i3hKDYDK28c0w6M9Py2x6Q+q1ERVfCaoChHsP23EMWCpbMQ6tC5UBxveUZoV0IaTDxsoODna5ub5evLe5oCmWZV/6/5TktVSu73u587yVmBEtguat8yvwIBFmZF5l+6ppvC2ueJafXVYRmGQszmsuk8DkDOEs0kBOiTiGwIyY9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738269668; c=relaxed/simple;
	bh=rO+V74lsNxVrl5SLYQ8FKaFFISkHbzLycLUBDF+nIx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OPRqxUSSWtMdlh31ngx1fxCSkv195IFlt1LZ5URd4B02P9oGtZ2oxB3ppTIZaB4cznRwvi8QOXH7kroPjXB9qjDDm6K/yuis4DYvnPXAd/oWAyw0RlezDb45G3Sk6RBeYM5ntAquHUcnLbMyZElNmUzaHHV6aYuiKwwZzCq86zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S/91QAB0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wp+4QXZ6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJic59009892;
	Thu, 30 Jan 2025 20:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=KeWPgFb/fq7YdqcyVIZUKRTbdDD+ChS7+ubYputWHNo=; b=
	S/91QAB0qPKpyCF5MoFE1pb3f0VW2Gl5yu5OM06gHbEib2hg9jCYJ57cK3X3U+sb
	APBUptTuncKbsMqCxZOA/k2o8O6n/YOTJY4gOgCD803K1MhwS7hhhsG3rxdXjXAE
	yDiFTiBkGfZDYakOJOE3PzYjEVKDjeHNiF0C7Ldx7vRDm2RpbUkRt4OMwVIEsxZe
	/UX9lXr4J7azkVY+UXQcWwV8Lb6pgAtMkJqZ936kFVuAUL6h7Yg7SwJ1RgEH5QLv
	/9Hyn54AfA0kkxjqTQYdNnO7gXljKcyQ/d8s3c7YD3ijZeRH7qt06ssghkBzkSd7
	mVrPNNaaC+4llmdDCL8gyg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44gf8206yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 20:40:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50UKDfVN028297;
	Thu, 30 Jan 2025 20:40:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44g0vbm9gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 20:40:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfOHk74WTHBJWDLXTEgkK2rwBJEE74pR0byktm/4xwEthMJCx6Isy86dO4/4R7nkWahIxVOrkKs3Q10AULylUwZMghXWJBvJuIanmJqq3u9Zw6R9/5g1FATR+xc5ypF+EF1+6vYs8ovdOuKbeDQsZZox9ZWaPdgyOn+IKc+96y+xyH5oKuj7uheV3NpT8IbXVRaN+B66Q6Vtk/T/pWD9d+qe0t87MqGv/Xh0hD9Dh0OExCMHlre8tpO+iS2Uu2rnr04aNixGWZBWaqPDmeEWVhLl1HCcB64VlXZrwIzBrPbyxARwqrYT2II+bmBte8mTxIzZ7ceVUgG62V+8KcjI/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeWPgFb/fq7YdqcyVIZUKRTbdDD+ChS7+ubYputWHNo=;
 b=ZSYrOypdxb4zWjtsCXm435FN19/BrMyRp1K7kV0CD4awwEtl+t+BSGHTNIbbg3/SHBU//kASklh5CO7qXzol44+sLU3l+l/jGTWexadcvcbcjTgZgYq+mFCmCtOKr9Y8CwmTifpPrpquY5h8vSmZ6tgQOEvSdw0HbQ2k9m3Qul+cOfhcZOO/MGqXRVkPlwVHQj5+/gdbc8OEXDhjtVUEML/PywzfvsvAffFBYgxRnq2Oe6db/QGhD6N5qnp1o93Wf25GzWcWX0A3pVC4Nbs1HN/uzr+sNDMGKu4LVokmX8Yo/mw/wQt1/YShkPfoJdPQtJjU7SJMGea9T9UfDYlLog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeWPgFb/fq7YdqcyVIZUKRTbdDD+ChS7+ubYputWHNo=;
 b=Wp+4QXZ623Z00JVmstXJepllzqWLfF1/N/jJo7pz4MIhcxqvqATTzncwx0f1bNCRb6Rj7qziBWy58e4GLBXVSRZnuvxRjHdEjoLWPf3kqeqvoDaSEpSesroTStQ57Cen3Ivb235zKwO5hxLj1wFNURYt6ByRej1cIQFRKjSbIVQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SN7PR10MB6547.namprd10.prod.outlook.com (2603:10b6:806:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Thu, 30 Jan
 2025 20:40:46 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8398.018; Thu, 30 Jan 2025
 20:40:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH v7 4/6] selftests: pidfd: add pidfd.h UAPI wrapper
Date: Thu, 30 Jan 2025 20:40:29 +0000
Message-ID: <751907a39349d0a1526f6f63f4270e4a5700e244.1738268370.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0044.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::32) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SN7PR10MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c91255-2f9b-453b-44a5-08dd416e5f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YUcABkNnYa32CWSmZj9YcqZ+vKqJ51yqFvg52gzh1/56dmhLRgEaonvm6OCZ?=
 =?us-ascii?Q?CwL5hjPIkmvDwURGeFxlYF8URPz9mUyOBSym/4Tt41Bd/dmfr54SQg6s2IIt?=
 =?us-ascii?Q?ESsbVNaEuNONLbzF/OY1TtSZCmTtBJXDT68BSELK5msYCsodAjIUR8wJXzJc?=
 =?us-ascii?Q?ZW6USiBJtHTQOEaZ5QtNUq6IKPXs8Z+ntus7Uye+i3LI8+x3qt47iqQ5O/AT?=
 =?us-ascii?Q?LIarMjIR+gk/yJEVm5QQJHigXw8PJqNzxF3Rnzxy/6w//BzH5VVoyx2a6fEO?=
 =?us-ascii?Q?dWIAuB45tsLt8h4ajzL5hAMvcqw+FLalPtYIj0rrVuCO2lrQtxD2WkR42C30?=
 =?us-ascii?Q?xg/3gPy5dc+DS3G2rH6JbujSmPO9yOw6y9KaB49qYp4V3pSxY1yRlIL5BJlP?=
 =?us-ascii?Q?6CcPpK1sVo9OpQiGqNIxJ6V3XWdvc608gHpILIzsURoH30Zc4Ia0jSAhuUUT?=
 =?us-ascii?Q?O2ZFjJHH0OKed6poNcQjoBOMVczWaeD5IMRTFjCaUMGurYtT0SL/hgv7BP9/?=
 =?us-ascii?Q?8PZ978PN+qP4ptkognFkXqjI0WATTXBCNR/fVPbSdy3FSZmJFqry+Uz1LS6Z?=
 =?us-ascii?Q?NTrD4wW4lbiFk+4TlrnneK8D97MhUw96G/sLCC5bTyeoh2L4RWKNLd2nYj/1?=
 =?us-ascii?Q?sK1XteB85yXO1RtjcvjPJqCk7kO6bsuloFIjZvK5Fym4HTpa+I2t3OVBN8s/?=
 =?us-ascii?Q?dW/2Wv9vF0jloSxWMgvGueQ41NW8MUHMcK4SBiHlZWAKdA3tzIDB8tRErD7J?=
 =?us-ascii?Q?yr3GwQZv48TtQadW16ZbVhzAQ1vLSEHAkiuE0MzTLoDp/+P20zCPGwWzX6Qs?=
 =?us-ascii?Q?sQjN0pGZWbuXODP+ooU9fxJpin+geBNlrJL7+6hk0T3h+YOxMMIQei0kgUZM?=
 =?us-ascii?Q?hgNgnruy815QLoSfSdAFO1UpOPshglkHXde00KQ/sVK6wwxv1prfimKmTRjN?=
 =?us-ascii?Q?lRmwjxTeP5LUjYGat5hUPlWp5ZNxtZ1PD+Cx8iK9y72nuB/Rq2ZlHypOZqyd?=
 =?us-ascii?Q?k8qSMKD54T0E6PoetyUIBF2Xdy/bbJO7JisqPCTbkJutsFT5gGYX7VCVrYDq?=
 =?us-ascii?Q?NEtqZXfpeEZmkrBGc905ITKwAKyCqlpuYdJg6Ys4XLzw7MQw4QFHtABZOdgi?=
 =?us-ascii?Q?Iw0X989dRexjAG2W3XgGCY4IgePuunnEDDKarhJkwMufBlg9q6rD0H+yjpHU?=
 =?us-ascii?Q?RIBAMCKpQAAkloc3FGTRSlOPUpgNLqUJsy2dzF2gOTPzRLpueutxJeT60zkG?=
 =?us-ascii?Q?FlJonPM6Vp0pynSUhVu74WqQtOT7oHbEgFKqfqiOrVHgkTEvp40Gk4kGUvwe?=
 =?us-ascii?Q?jlK3XXYmbFpC5cb4Bii1ZRq49riPLECcNLw63m2L80RHKhRF7oAvLyybMzdH?=
 =?us-ascii?Q?y5X4Db05sN1GExhvOq419UQw97nZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XHoPLt+xamfoSL6Ro6XFl4OUfXsjVl+j2fSdYa7Hlt1cTUWJoMZgTFStqM0G?=
 =?us-ascii?Q?dNLjtTPxYdRPQ9PyEgaSo0i/xtsUD2cguJ1zzAKiNeMgpSOLspV+sLVoMcrr?=
 =?us-ascii?Q?XYrSggVLdBHA9hUdocGi1DXKaCd2vYFFmrpQDm/Catr7TNoGWDy4i3goD6BJ?=
 =?us-ascii?Q?laj0iAVzINMsb6SRqMoAqNlPeBLOS5bAKCutApMTqUXuQh2z1CNxFOfmchRs?=
 =?us-ascii?Q?a4pKKmmsLD/k1SbZWKH1Mos/Cf3+l9f+KTVAr9r5mziDlWZ2DQZfYOnZI8kn?=
 =?us-ascii?Q?VVqaa2cIAgt5wd94qjnsHS7Xq5UkD+zeCwhGdq2MWd4uhqU1YdjzEb8pqQ6W?=
 =?us-ascii?Q?BaaxJrTJnnMpcsLht06z6kW2R9QWWGndEr//w6cBC3fkm3aBrxLViy09Vz3r?=
 =?us-ascii?Q?g19Nvg4oUUp3HgXur2ntU3/Tozfmuy9gr5dDUoliInz86dDkObIhSJQiad74?=
 =?us-ascii?Q?rnaOA5fyEs1FLra6xaecWTkYhnXNR/wxdqhFKfxFqdzaPAkiW4yW1+OFCo9M?=
 =?us-ascii?Q?B9jreURDr/+K2pu3hZd4qZ3j9VzlrHT8eY4oq+V3GFWRA6UNMfcCwALWqwtR?=
 =?us-ascii?Q?kwgGcArIbfxyVMSoBsy3qNMlfQtIfa57BU2L9iIArD/DHW1xCkcHyKnWgQut?=
 =?us-ascii?Q?6vb9teV1+FPJG7kkBl1Quh0dGwpEBqLshf10f1NwHFM6qAG8h/P/WYXWijDQ?=
 =?us-ascii?Q?m0f3EEJp5P/TAMtQw6whl/SeRL+ZUVbwUibpoisaFC1EbzTB+0YjihZVvKef?=
 =?us-ascii?Q?yaTjdUSmuXBOlmK0eTmdcpJN2XXQ1W0SsBbdlhQa/WFx0kO5Lh9DGt5fQ0qE?=
 =?us-ascii?Q?Y2U5wNHiLfoMU1J+qy9wjZFyVLKXGzhjzlPvLUD7ADg3d+3OqQIyu0uWvKTh?=
 =?us-ascii?Q?Lr0F9pR41PNCQyR6iLrxe931+QX2H2X+cCQSxfstIln5kVTZ9zj4kD5/Y6+Y?=
 =?us-ascii?Q?DEN8uACZCOx4ox71bpW7R8yQodmUQUK2VZa6ezFVQGzcxzeMOAeOE0ZjXdD4?=
 =?us-ascii?Q?0vHM4cZ9HSPWz97SxiE6lfdLvXZvwiBL6oTmucHAgRrtuOoV4WvzbkPoTIUf?=
 =?us-ascii?Q?bql6guzxv7JfGAkQvzCzvaFkqIqQWHEFm3rMPLNWEqhzhsaKzdkuLnK0c+v3?=
 =?us-ascii?Q?bMc2ZD5ib32plaPOD3/3ft0yLP0EMBzrnYDqrNs+hbGgFqT34RsAA3EjIGVt?=
 =?us-ascii?Q?igCly6inx3wqTDs5EK7OfO2LyxsDNKzWFVsnBpiWxj9u70Hv9PPsastPEsX2?=
 =?us-ascii?Q?QmUuErEwcXg99SBR8JMM7Sa6vaSFLZDB74F6h5QyEnUP9EY41K6HGu8v0mLG?=
 =?us-ascii?Q?9jXijCtHxufliafpzgcvH3sT3M3PkX6MIVZxFYOo3lfNF/nW7/uIVRYoOpc8?=
 =?us-ascii?Q?wr5k3BI8WCYlPc2rQKTwfE18SNxMwR+cWXnzU9Dya4B0QUzx055jZwrKydnc?=
 =?us-ascii?Q?PfLZoozo0qv9PHfMvZx3xs6yB/kV7VC7jyxR7bIGHK/xsdZTOZT/Vm1hyJDX?=
 =?us-ascii?Q?w6+/HiI6TjVhs6UH+oxrPyK20eWV7wmRrM86n4SISmUhkDaMAPaKPQklV5VL?=
 =?us-ascii?Q?tukqP6rj98L692jThJL9s568dYSeXAExlitT3pa8SsU50R/FUQ+yoHEUTgG5?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LnaABLgQGbeN45VmKOopqOmIWoL55ox8BtMDYJYAiy5BRT4j1KDnRFQDo2xMnM6ru8MEW6PTZVt9VPUskk7q6WHFORJW3cUAhqcJ5jtIDc8jROlEqkV6ntVPwR/0eKZQJzWWYSk86IoZbyWD2nw7KD6qQ99FDJVPVVkmaJOWMxD24vZks5xaVv5Ik3Zvy7oGUOf1zIg+oJlz0Wf+ESezXPfbWrvAQDjY+deiJ+y3WniSesT37GD/ZR7D5GygEQeoSuWZ+g6jc+z6imrzSkxA1Djx8CIRVDKSV1zxQEYaxo+fadMIbV+Ru95iFMXkxO4lT3BEANRaFMfUvT3C6pfKBdRjM+Fn1G2PIPS46eDjcPZggo2/JahJxiUlfIP0EyhC37HfSIGN0fhZ2xLePfJ9wbioJqSnAO8M540lvReJaB5UlZJZZa3N7nWv14j0oPnZkSeLRM/pAMBjk6GOPSevbGqyLML4StrXO674A+mweBzvzNilDhqOmI7dnlTLgB1aFzFaGOcdPHMjHJraoqsiQbJDvxRZveQViwxGtfSvqMpJjRW9t9Yxi9+Wz5KWGymveAHpYorfGWj4zh8715psB9lWetYEYKaFgnxE09obr6E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c91255-2f9b-453b-44a5-08dd416e5f88
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 20:40:46.2427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIdLRajGtTtP8InUuKVE11YRW6PJ+xCRKtBElqu7fJ/qRR+T4mBrlUW+1EPmMINQuINB6N5+U/HyZym6ArMqmSrjZUY4Qk/TeB+MsZkLj1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_09,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501300158
X-Proofpoint-GUID: XfV_9gjByChqX8bkpM8-xht-m0EjaK7R
X-Proofpoint-ORIG-GUID: XfV_9gjByChqX8bkpM8-xht-m0EjaK7R

Conflicts can arise between system fcntl.h and linux/fcntl.h, imported by
the linux/pidfd.h UAPI header.

Work around this by adding a wrapper for linux/pidfd.h to
tools/include/ which sets the linux/fcntl.h header guard ahead of
importing the pidfd.h header file.

Adjust the pidfd selftests Makefile to reference this include directory and
put it at a higher precidence than any make header installed headers to
ensure the wrapper is preferred.

This way we can directly import the UAPI header file without issue, use the
latest system header file without having to duplicate anything.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/include/linux/pidfd.h            | 14 ++++++++++++++
 tools/testing/selftests/pidfd/Makefile |  3 +--
 2 files changed, 15 insertions(+), 2 deletions(-)
 create mode 100644 tools/include/linux/pidfd.h

diff --git a/tools/include/linux/pidfd.h b/tools/include/linux/pidfd.h
new file mode 100644
index 000000000000..113c8023072d
--- /dev/null
+++ b/tools/include/linux/pidfd.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _TOOLS_LINUX_PIDFD_H
+#define _TOOLS_LINUX_PIDFD_H
+
+/*
+ * Some systems have issues with the linux/fcntl.h import in linux/pidfd.h, so
+ * work around this by setting the header guard.
+ */
+#define _LINUX_FCNTL_H
+#include "../../../include/uapi/linux/pidfd.h"
+#undef _LINUX_FCNTL_H
+
+#endif /* _TOOLS_LINUX_PIDFD_H */
diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index 301343a11b62..5363d5ab27a4 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -1,9 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
-CFLAGS += -g $(KHDR_INCLUDES) -pthread -Wall
+CFLAGS += -g -isystem $(top_srcdir)/tools/include $(KHDR_INCLUDES) -pthread -Wall
 
 TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
 	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test \
 	pidfd_file_handle_test pidfd_bind_mount
 
 include ../lib.mk
-
-- 
2.48.1


