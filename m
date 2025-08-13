Return-Path: <linux-fsdevel+bounces-57729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3944DB24D2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B067B3B35E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C0C1E9B3F;
	Wed, 13 Aug 2025 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qH7GPBo3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f+Pkr2oC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C4D1BC4E;
	Wed, 13 Aug 2025 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098109; cv=fail; b=X6Mcw//mrrBxGEOGhDxQ+djDyZkoY6RW4nIZdhlj5cPCFOko6iar+5xP68rP43J+Bm960RUBZWd8RA9DvjcALHIpqrf2kbcqp4JNm501GeqZgXvG9LvYZajw26vymPtwYwiKSiLrYU55YyujRfEKaSkAa4e/oryM17XkXfrgui8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098109; c=relaxed/simple;
	bh=Al5UC/OEpa6fQt/jbA0tIXeGuRGuvVKivVaLTlIcRpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A68qqUw8y4uIMp9UYfE1YrH9QtHbhZA8Gq9kbk7Pb0/IfKZmghi03ZdiP1d6m3llHoYRUvoyXE7WEYIxFbH2UmbeKc1jQvODUW7Q5NfnqEAMHlE7ffRFTZTiKx4SxeBLxzb/yXdKjZPu//ZN2+1WbG/VtYHfqzBRgx3DnDocjuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qH7GPBo3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f+Pkr2oC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DDNB1V013890;
	Wed, 13 Aug 2025 15:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KZyv7EtqsAQtR8OQEs
	jrIZIlCz+b+o6njQRv/Bc/DPE=; b=qH7GPBo3F3SDxo6VQrFW8kxp807Jk9Cr6V
	NhSpV27oIt+aMoxJHQ+YA31/BOV47g0h5ZjzYAxeJWzr1+5Z5GyK6I8rvM/dn3Lf
	3Hu92dzdS0aykUl8580iS6iYkmkBDkkdj1CEnuUYS1dZjqVvh7Ria6kfHMNUowEM
	8ZYIhMtfJK+l9EU0dhG3cBKSELpCYFHhXgvB5bTpRwDnhW80dY7bx7Vv+G85c2VT
	GDN7Ibq41u50yJNL2U+l0uPSKIUY5uDJgP4ZpB9FkwwdmSTQiFfGmWHdb0/E7p3t
	bZasuw8Q/MAsZCOByD7uAM+nBwBWeRMrnLUo/8hkbG53suWQYLFA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4fu59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 15:14:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57DEYw0Q030131;
	Wed, 13 Aug 2025 15:14:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsbhhtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 15:14:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fl/9o4ER6NIknI8FcRGRGPO7SGL3C5bQmQO17kPyWY8irSSk5u2luD7E8JiFj4LgwovGsDrIN/hCy4bPU1ofQqcCjuOG/9eZWluqoeCE4Bm6gJY2ysVuzwQSFWCQCNioG9U1jW7t4pYdUwMG86QB6BH2uVgW1wpFXKmqgFVIB4lwbowfP12uVdCfXPFc1YByKaTrsOKrOg2e5w2/ARQon9fabMto9l0ktYwTztlMkLexTcFy0lczhyWkkV+37iseitmk+33WfIKbGXfldtPNFPW7ax5d9cQveLRDvmAEhSVpOCnZc/GR2Nuk5OdFOhpAboNBsFyMoJgshuu0yfF2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZyv7EtqsAQtR8OQEsjrIZIlCz+b+o6njQRv/Bc/DPE=;
 b=fQwaYxc0yGVG75to5oTilHBTgYKpvxmwvYynl+4bEQgLqig7IE9AYz3Y7U2nDTGgFT2cSLR9EKLQ5eLbd2WFQL+V7G9u4maXow6TPqUGcqWkpKCRYzVd7nE5v9ipa3ZOLvgCWjbc0i4g6pxTR/w/xo/i+brRx5MTAA9cugJb5CcIRmQFw0cU3PNHFSCidAkXL4Ckh5ms0E/1Rj2cvbVnoEz7ju5b/pFA9zSgGhD9YDVbzLmAa2kGxOCTBLhZrnSejmyFiznxYZe4Z7kW4lDeIF32/h11I0UJtmHMXwW7kezLJt+0rHb5PvN8Yz04qHhZ9rO24Odq30fLJ2udZJJ6iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZyv7EtqsAQtR8OQEsjrIZIlCz+b+o6njQRv/Bc/DPE=;
 b=f+Pkr2oC7Ri8NoS88mtxYrvUoiz6uZxpiKIskGwbOlHtzXoFDl/nAlsKR4zh4o502doJ2mhP2aXCWZvAxfymPaROz70F79e9G3JL1YUqllxKhgGuxZvaA7cAP7mJZQJ13SkehiQmGnTsFUTmhBQWngHVojoFIKZZWB/seJB8V0g=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPFACCDEE1A8.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7c3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 15:14:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 15:14:02 +0000
Date: Wed, 13 Aug 2025 16:13:59 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, baohua@kernel.org, shakeel.butt@linux.dev,
        riel@surriel.com, ziy@nvidia.com, laoar.shao@gmail.com,
        dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz,
        jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v4 7/7] selftests: prctl: introduce tests for disabling
 THPs except for madvise
Message-ID: <13220ee2-d767-4133-9ef8-780fa165bbeb@lucifer.local>
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
 <20250813135642.1986480-8-usamaarif642@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813135642.1986480-8-usamaarif642@gmail.com>
X-ClientProxiedBy: LNXP265CA0070.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::34) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPFACCDEE1A8:EE_
X-MS-Office365-Filtering-Correlation-Id: 22740533-312d-486b-62fa-08ddda7c094c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L/apSk4C0zv6V1+N4ojn9UvF+Kc+tdkmnZGRA3fanPGK+k1bAZ8uKO6paBRJ?=
 =?us-ascii?Q?Zn84J5KyctKoiPa5m/eJikCtRQtsDkc2SYQJRwa6hveKU60pk3eIjjlCscuM?=
 =?us-ascii?Q?R9o31r8EU59WqR1GP+PRsfC+0SSh/CipFn4/un9kJ+W7Nenz7NHRgOQbE16e?=
 =?us-ascii?Q?ny+6FS+e9ouzabrnQgst3RjYDz9X++wpfLJAgcoyq5lcYqs3Goz2gWICXT6Q?=
 =?us-ascii?Q?vHU2SOxS7+IFmXCoqTyc0pcXEDXWp1UBwxRJTk2p735hvyETuafsGcq4HkFS?=
 =?us-ascii?Q?L7hxXDooBPkgrqjTN4BE1WO04EdjwZ9v8cqeAGj06RcNnrwtTucBb/PQtmEA?=
 =?us-ascii?Q?Xn5PnyaKDddWNFugoFYUYP1sEhTHgTgCjEqw4tL97ymCjDL/AxS6oIS/0Ys3?=
 =?us-ascii?Q?2GIsWygDQZ1aqI4QK8AfWKxncmpCwEqvkSckiFd+BM5q5VfymiIYzZf/lalq?=
 =?us-ascii?Q?DDE+GTYaTPEz2UbmKX3CBls5a6EKRkbZZpXBDPLkwHK7Klq8O+K47V3y/E9X?=
 =?us-ascii?Q?xdoLRew/9nq37x2xBIx2K4O5QSlc7bDzlXioEd9HtdRNHnCm9l/3WF9T0SKW?=
 =?us-ascii?Q?b0qfQI/kFnbQn7bWtFJKsQQbF+ey59VoTSdJci6fDPJmGhuR0YQlwVJJZqgu?=
 =?us-ascii?Q?XZywo3kA21hfbcHMJlfiq7Yp0Zw4Q3idCbV9xK5rLPETtEKtdkXOgyeE0lax?=
 =?us-ascii?Q?ZluM1a8V7tFCbNXyEmLDyhvb9OtnXHoBN0LW4G051kOhmUj3TnAZjhHYP9Sy?=
 =?us-ascii?Q?+AA5An0+HeUOINHuEMKObztcmjX477Z4RskwGinDogv1UAO7TCUZfrLVi3qZ?=
 =?us-ascii?Q?WpGqhJ8Rgk6o35ERodV4+5gpLioFZ0nb06kpAOC4aHAEi1gchUEOKkcckZvd?=
 =?us-ascii?Q?/wytRerMT+G1X2CKiosoLTEZyZYCZ3+G7jdzbosLZ8GfJljXhR1U1VX471Ef?=
 =?us-ascii?Q?TuP4vncOIbeC2i1XqxFbvWXElQi51ThNGK5cz8av9DhYXxySfokurAKxuSYe?=
 =?us-ascii?Q?fGbG2gz6oxd8mSXQz07yEsHxbeCJ6Og1QbE1A3Ke+aAhFRUv0SMEixsEq9ZV?=
 =?us-ascii?Q?eYDf0PUiu7ImeVrvhIrk1JL9Tcwvqhb7nAvKijY+Z+iq1VXJyz8Kv6tqtzU7?=
 =?us-ascii?Q?nW8UfcAY2WYYWBWQldHqoF2OMcfqBkLkL2TaMNIaUyBXasBwT94Kvmk9f3XH?=
 =?us-ascii?Q?7+tbS4ngoA6L1FsSkK1Ylx0kmjdZOA79TfXP8PSLHaiUMZ0Rn1nqRwbU5kpp?=
 =?us-ascii?Q?xfMSN0MmhdRx7MV4khwxO/JIVjeMvueA2vbp5NfGkRD9l0V6Fb3lJd+l/T8x?=
 =?us-ascii?Q?877sR1yQ0v019DRmYUa2IIacynsEBxApkDN6Q/9Hf08Gq9f9CXDg4QGtuRYX?=
 =?us-ascii?Q?lWThJ/wcbrtPVWF34N7k/y/tp4cuqw16q8SYmf9DvUOGX/LNaWq+cqF74MBO?=
 =?us-ascii?Q?4QDlCDo0k80=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fSEA9OwCEaftqrnrLzmhbU2WzJNB4HAG9ax2rQqGQXd3N+1OWC1XQZ/8xRgy?=
 =?us-ascii?Q?bmnerzWuYv2Ldj6uQgKvoayiYRdoIWX0KTPbq1h9vf18I7b5riE6VLXXznFH?=
 =?us-ascii?Q?nz7j/IvsXnQQ3BCyJ1/WBqXKyj34PPqehTqAPtpB2/MrAVBEWfO8UXZ6LxL0?=
 =?us-ascii?Q?BqY/6snkNPrgBXthrI9RwpvDX+Gz2ljnEacf0zKdlEfe8oIFWbvvm9UdE4ky?=
 =?us-ascii?Q?ZsoelPERcHfcSuAdW0a4DvI5mEkcif7NJXxhL3yETvwV0/d8rwBc10+jk4O8?=
 =?us-ascii?Q?rrqdtar4+hAR/+UVnrUXOuDmNeZCDHxbJCM623ovRY1wI269E2hv0VNBPPMj?=
 =?us-ascii?Q?NmzyE7sgjs8pHjJAeUTZF6u3zVL2xv1ojTSfIY7EMzcknpZz4q9bz0K8l7VI?=
 =?us-ascii?Q?mVk2OSlOztMKviGtwaa73Z9Qfl6pSdXwip2Mo3Wu9Wsx/WbFXv9Ybqkc2VH3?=
 =?us-ascii?Q?sCxHv34tLnmbTw/0jr0L2Hlj8MZJcnlSvbkusX04eZ9zcO+t9dQ7JJ2tqDUS?=
 =?us-ascii?Q?JGyR4HFvB1CJuoCFIrnbbK6pdya+yYrg779Kuq1IhqopMmZWV6G10wje00+/?=
 =?us-ascii?Q?7qpP8/WYkYAlfzv2DX/+8E/CLz7gtATXWJzvzJgflAV/Gcl1vOEfwkUnCYTR?=
 =?us-ascii?Q?1eitocNUYtivVHxKPdWlfVk6Idrmaw8lmsak5oZugsConlRXf9SZou4PkkHb?=
 =?us-ascii?Q?hQ0jDrr5cIDgvid+Otnh2fK3CNCIZ1oMeFFf851MxMUTZ7NisIy84foX6dzK?=
 =?us-ascii?Q?zltFS5YEI6tPrXltG6s7+bqlrHiuZxLCNwg0FlUJHSwQZaY3fSDE1AB1aSgj?=
 =?us-ascii?Q?DqmYF8lnq/pANMM1Bn4Zjvkgju4NQg7EKOsFzOew2EtF1Ut8lfUlaIu+IETd?=
 =?us-ascii?Q?xAVtq2G6NpzPlv2E/27HP7f8WgP+nyLo+ZcdntSDv2bEGqqVB9407NLCuWRe?=
 =?us-ascii?Q?kdSnrjfi1/iYFpSTJ8XRdrn9lSc87neQJojp2oBWmN8Sg1IPuv4rrXDjPL5N?=
 =?us-ascii?Q?6PiQKF0RNxCmQrIjMCrssCWJp+veEZfYOnXYD8MX8i4qVx/2XALrCeL6VaF3?=
 =?us-ascii?Q?U0wSifnRkfVt/UfzGQjLapXcEyGmcfEEfQXt2PNzXq/PA5iNWS4fQWBcsmEd?=
 =?us-ascii?Q?Vrg50Eg49mwrRSZzVWzvQ5s8Q7jnrumEbQcy2Y3hxPMPF0E12njUb7x5HEUS?=
 =?us-ascii?Q?MQ9y3cObijweNNJ3QNusNiIaSF4am9bQMTnK3WL4ARmvqDE4YpIRx2Geze9H?=
 =?us-ascii?Q?k4vU2UVRLAO6T/oPAkihEOp1TdT3M5k5g9EbbTmIeEKBl/9aTeAotvA14GGr?=
 =?us-ascii?Q?Fg7jpL1glEdwGX8wcaVk7raA8SrXqrPM8rJIqa8SxgVkRkuvv/XfNV3ji/eS?=
 =?us-ascii?Q?H9pSvtHwuEJF/vPVmMePy499P5dDDfs1wounLzoN4tMDFwCXyTuZtJk4yQ1Y?=
 =?us-ascii?Q?m+mSEarS/IR7kQbhzZTTXGk2bgV/hUerC0f6KGXNIBwiFySJ4lJeSznT5b0p?=
 =?us-ascii?Q?t1OHF+RNxm9X1EJHaLbTgZytK6NNtGLnNtdOESoX7W1d2XnG7XmPAML0Ir9a?=
 =?us-ascii?Q?mj1YaHAuHJF1yUz8yDMKaMbIf/RbxbqeIhj6pTj9J9qlG1rLO9sLB9r+0I2n?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EH34oiRiL2aukj6eEtv8guzkzU578PiCevPiefqypX+JNhSoJk1jvuPtpXtsDPcWx+LsrB0CGok8PjbLohb1krMiIDYwEGCRn9RwXhUmmSTn+W7UdmpBU/fkam9ZpcU02QrMSZ+7vCvkXgA0NOUfO1B9qz3Qz4WTiaN/Z+1H+q4HUG6/smm+uQjPgeH4AtbKljZyfqmUXEDlerZDD57cDMFm3VeiKkda2kWSyFxdz/Q470TXUpYaBx1hHX7OACqqChtVgDd9Ikxky/eB/IhCdgRlixlDw0YZhZThweoyhKpdp442DQGqDBH4v9TWe0cHyD8TMlOU6ppfObzwxiYVvZYy04yOiKE9GzrcTvVpdUklFPJF+n16kF2eyJmCOEzThtReIim/YAgXd/E1YGfKQGnyllU0hsK8A96XMk22aB/h1xEGVEqThdk+Kns0vtaRlMRIy/7Co1Cpdn+/fFO3TwHEUke4ZoEzc1FPkfy5MoHRSn11U0f3SjKxSZp4vCGRBLUuLgx+hq1bQsCksrA7MS6nUJr6p5vJoq2rbXvcwhG/d1GOYn4NDW4CRfEklaCP2CwJOoRV4SJgzRoORtdDDZBVBhFGSswRAcxCdiCE7EY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22740533-312d-486b-62fa-08ddda7c094c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 15:14:02.4153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPaNUiqP/r1f+EIWwgbDfpTZTc3PXbzTn9aMCWviDfj2YiLtIHmUgiA9cp73YAz3RKL83j17BlQXHhYPgFRty1Tf7b+rRPYiT9opSvMwjgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFACCDEE1A8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130143
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE0MyBTYWx0ZWRfXynK3kIMIpFlT
 rO3ris2FHrAobm0QuTYFylqaPSmiRwbxVtmAM0TMc+XtMGiZo+/GIRl13WeHVSCX1oaahzwO4lR
 yiiYaYkXNnceiRNWMBuHy5clt9kKY8vE0A97+IVTwOoyDtGSGLUZP+Smxf8fLA2M4V7esx14nkc
 pLxs8oj7vb8egxNF+7KtWa1wKwZdf6x2AS4QyrmWIgP85HJ8LR4DPFCgdstM1W2sRI6FZXiYKW0
 7jbAq9cixMyvsJxH3dzpnOIqZpIy0DxgvxD27j7MjeUlHO2AebWqvtU2AUO8Iv/s9Z4o4Z4lb7r
 M/S4s+stWSaUmmHHR6WJXOHwhhh/GtkpMdk61e7lPMv8w9ZiGMMmLyBWr6Ue33uUuQhiDUzZiJw
 6hI4YQvbo+tZ8r0ZehIpjkIW6I7bSHZ4Ggh10o3PcflrBmZMgsVrUTlgH0MHokhAcpo6sqOs
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=689cabbe cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=rvUyAA4L0pTB2ge5SVAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Whdn5w8Bp0WopvAD6xT0Is-ulqPJfET8
X-Proofpoint-ORIG-GUID: Whdn5w8Bp0WopvAD6xT0Is-ulqPJfET8

On Wed, Aug 13, 2025 at 02:55:42PM +0100, Usama Arif wrote:
> The test will set the global system THP setting to never, madvise
> or always depending on the fixture variant and the 2M setting to
> inherit before it starts (and reset to original at teardown).
> The fixture setup will also test if PR_SET_THP_DISABLE prctl call can
> be made with PR_THP_DISABLE_EXCEPT_ADVISED and skip if it fails.
>
> This tests if the process can:
> - successfully get the policy to disable THPs expect for madvise.
> - get hugepages only on MADV_HUGE and MADV_COLLAPSE if the global policy
>   is madvise/always and only with MADV_COLLAPSE if the global policy is
>   never.
> - successfully reset the policy of the process.
> - after reset, only get hugepages with:
>   - MADV_COLLAPSE when policy is set to never.
>   - MADV_HUGE and MADV_COLLAPSE when policy is set to madvise.
>   - always when policy is set to "always".
> - repeat the above tests in a forked process to make sure  the policy is
>   carried across forks.
>
> Test results:
> ./prctl_thp_disable
> TAP version 13
> 1..12
> ok 1 prctl_thp_disable_completely.never.nofork
> ok 2 prctl_thp_disable_completely.never.fork
> ok 3 prctl_thp_disable_completely.madvise.nofork
> ok 4 prctl_thp_disable_completely.madvise.fork
> ok 5 prctl_thp_disable_completely.always.nofork
> ok 6 prctl_thp_disable_completely.always.fork
> ok 7 prctl_thp_disable_except_madvise.never.nofork
> ok 8 prctl_thp_disable_except_madvise.never.fork
> ok 9 prctl_thp_disable_except_madvise.madvise.nofork
> ok 10 prctl_thp_disable_except_madvise.madvise.fork
> ok 11 prctl_thp_disable_except_madvise.always.nofork
> ok 12 prctl_thp_disable_except_madvise.always.fork
>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

I don't see any tests asserting VM_NOHUGEPAGE behaviour could you expand
this test to add that?

Other than that this is looking good.

Thanks!

> ---
>  .../testing/selftests/mm/prctl_thp_disable.c  | 107 ++++++++++++++++++
>  1 file changed, 107 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
> index 8845e9f414560..9bfed4598a1a6 100644
> --- a/tools/testing/selftests/mm/prctl_thp_disable.c
> +++ b/tools/testing/selftests/mm/prctl_thp_disable.c
> @@ -16,6 +16,10 @@
>  #include "thp_settings.h"
>  #include "vm_util.h"
>
> +#ifndef PR_THP_DISABLE_EXCEPT_ADVISED
> +#define PR_THP_DISABLE_EXCEPT_ADVISED (1 << 1)
> +#endif
> +
>  enum thp_collapse_type {
>  	THP_COLLAPSE_NONE,
>  	THP_COLLAPSE_MADV_HUGEPAGE,	/* MADV_HUGEPAGE before access */
> @@ -165,4 +169,107 @@ TEST_F(prctl_thp_disable_completely, fork)
>  	ASSERT_EQ(ret, 0);
>  }
>
> +static void prctl_thp_disable_except_madvise_test(struct __test_metadata *const _metadata,
> +						  size_t pmdsize,
> +						  enum thp_enabled thp_policy)
> +{
> +	ASSERT_EQ(prctl(PR_GET_THP_DISABLE, NULL, NULL, NULL, NULL), 3);
> +
> +	/* tests after prctl overrides global policy */
> +	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_NONE, pmdsize), 0);
> +
> +	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_HUGEPAGE, pmdsize),
> +		  thp_policy == THP_NEVER ? 0 : 1);
> +
> +	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_COLLAPSE, pmdsize), 1);
> +
> +	/* Reset to global policy */
> +	ASSERT_EQ(prctl(PR_SET_THP_DISABLE, 0, NULL, NULL, NULL), 0);
> +
> +	/* tests after prctl is cleared, and only global policy is effective */
> +	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_NONE, pmdsize),
> +		  thp_policy == THP_ALWAYS ? 1 : 0);
> +
> +	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_HUGEPAGE, pmdsize),
> +		  thp_policy == THP_NEVER ? 0 : 1);
> +
> +	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_COLLAPSE, pmdsize), 1);
> +}
> +
> +FIXTURE(prctl_thp_disable_except_madvise)
> +{
> +	struct thp_settings settings;
> +	size_t pmdsize;
> +};
> +
> +FIXTURE_VARIANT(prctl_thp_disable_except_madvise)
> +{
> +	enum thp_enabled thp_policy;
> +};
> +
> +FIXTURE_VARIANT_ADD(prctl_thp_disable_except_madvise, never)
> +{
> +	.thp_policy = THP_NEVER,
> +};
> +
> +FIXTURE_VARIANT_ADD(prctl_thp_disable_except_madvise, madvise)
> +{
> +	.thp_policy = THP_MADVISE,
> +};
> +
> +FIXTURE_VARIANT_ADD(prctl_thp_disable_except_madvise, always)
> +{
> +	.thp_policy = THP_ALWAYS,
> +};

again the kselftest_harness stuff is really useful!

> +
> +FIXTURE_SETUP(prctl_thp_disable_except_madvise)
> +{
> +	if (!thp_available())
> +		SKIP(return, "Transparent Hugepages not available\n");
> +
> +	self->pmdsize = read_pmd_pagesize();
> +	if (!self->pmdsize)
> +		SKIP(return, "Unable to read PMD size\n");
> +
> +	if (prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, NULL, NULL))
> +		SKIP(return, "Unable to set PR_THP_DISABLE_EXCEPT_ADVISED\n");

This should be a test fail I think, as the only ways this could fail are
invalid flags, or failure to obtain an mmap write lock.

> +
> +	thp_save_settings();
> +	thp_read_settings(&self->settings);
> +	self->settings.thp_enabled = variant->thp_policy;
> +	self->settings.hugepages[sz2ord(self->pmdsize, getpagesize())].enabled = THP_INHERIT;
> +	thp_write_settings(&self->settings);
> +}
> +
> +FIXTURE_TEARDOWN(prctl_thp_disable_except_madvise)
> +{
> +	thp_restore_settings();
> +}
> +
> +TEST_F(prctl_thp_disable_except_madvise, nofork)
> +{
> +	prctl_thp_disable_except_madvise_test(_metadata, self->pmdsize, variant->thp_policy);
> +}
> +
> +TEST_F(prctl_thp_disable_except_madvise, fork)
> +{
> +	int ret = 0;
> +	pid_t pid;
> +
> +	/* Make sure prctl changes are carried across fork */
> +	pid = fork();
> +	ASSERT_GE(pid, 0);
> +
> +	if (!pid)
> +		prctl_thp_disable_except_madvise_test(_metadata, self->pmdsize,
> +						      variant->thp_policy);
> +
> +	wait(&ret);
> +	if (WIFEXITED(ret))
> +		ret = WEXITSTATUS(ret);
> +	else
> +		ret = -EINVAL;
> +	ASSERT_EQ(ret, 0);
> +}
> +
>  TEST_HARNESS_MAIN
> --
> 2.47.3
>

