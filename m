Return-Path: <linux-fsdevel+bounces-32869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDF69AFE99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 11:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19102866CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 09:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246BF1F81BD;
	Fri, 25 Oct 2024 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WSgfrBWl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lOmlAua6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCF31D90C8;
	Fri, 25 Oct 2024 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849330; cv=fail; b=IWsIT+m6zZ8CgfHHDeHCO4DhYuAPX1SIVl34WeNNAhlNVOBJcp2pBJGFkQdKHNIEjMQz5bMSNatN0NF0+UAIHwlHHBz6+cS1BsjQPIuhDtB1rwgUQy9Gwm3T7nvDyi5oq2gXrwq1BLIBnLlM1ozks5A845g/JPi2pjtWOslpdS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849330; c=relaxed/simple;
	bh=URx+MB+d6wqrYB/3X5ImI7mIBPKhLFs10r0aaSX/1/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z3SyB48EGKydojqAMqsfAAS2qCNG41Kp++35tB1K0OyAeXDc1s49V2JhSluLua3i9rnHcuH9c8/kbK7CLsW/GTb8siexsmI6wyd2JcEAiTrsm+IgVuWemf2GiRWXLr2fokuWUVV44mqMTheYyvumgl11vH1rogZJMPWk2RY4g3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WSgfrBWl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lOmlAua6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8BZG8005832;
	Fri, 25 Oct 2024 09:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SLlbDZlZ3nLzA+OMshfpAja8xZBB1l8GJOD6tbMQ7pA=; b=
	WSgfrBWl2sYMqXQtdSQbn6UEGQgYeGnjRMU5BcojRJoGFuqZN+tJd+TEjOIp3bSg
	1EeR2KfXaaFX/lYUJ0M0SNqaPhy3/ONpnvvezK/InH2ScaoxbPOeboKgLmTIEbjh
	jYc1dtMGyY4c8HqNxNztMdIF96KvtDwIJjvSwDGuTFCZIvgzQjrw0795nhhvpGJU
	KeSuBfwGHRNreSmzejFhwmQG+lIwk/PI37mi4w+5PpqnEwfn/X0jw6qBMdgbuH4x
	mFor1T9kpm0BRzFS8t5D89L4VmIQSQcOzr4qXwD4BgHN0wKLKHPYxkvNYFN8L5A0
	woNkzTZzpzEMxqSVivXmcw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53uvk1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 09:41:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8gDuV001662;
	Fri, 25 Oct 2024 09:41:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42g36a9y8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 09:41:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgdSu4tmrR+arS06AgM0LNH4xmXpS5N176v1/USAhEMEWOC0TECj4FPB4VtZzS5otglr/gbwf2coBKAT61O1i1G6rxrSj/sWrB7EHn7IWXwLeGXv561LHVIqjNgi8ltdobXh2hSJoW4GrgI2yVCoYHRp1+vRT0BbZ5ZPRHrTSKlahEjMlrXmNpet9GFNGOx8hmlJtFbLaZBoHDHRhwKsceo0DQTeRPQa9d+wHYBRAyZFKVZbI74qLboNlVVyqh1vR1suGftDq+o/Qw2ADozS1I8npMX6LR/yDY7OsAAhcLldrD2J5jOxIgI8n4zgcxs1UkAdK0ORfazvRd3lp9gM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLlbDZlZ3nLzA+OMshfpAja8xZBB1l8GJOD6tbMQ7pA=;
 b=WDe6SEKNxCAKcbTmfSgrL90UKhlwXlvM7dn37XX4BEFgXNFLfndvPS0qzpBN/K9CON6OikUVo9WZC30uQZxv0ayfWT9cvny9RMlZhpgL6qaQlmNBxJHcTTdFifpn7ccfvUYCRuocoF+9T2sUWyRPBNb18qaS5UtfHyTc8LsDBOP1pSgrugNA4JMVTwDm/OF1ubkqm1JspKmxwaDxgiii+/kWhgWuk56oR7077vz0CZr/HFLtNsJHDLhXo1S+xmgTC7lbxp601kHOtqx6q3W2O264hCILRE7QHShXri/nHiicmGARTDKyzWqqhGKKZ4C+pItwfJWfGGxs8ODPae9bWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLlbDZlZ3nLzA+OMshfpAja8xZBB1l8GJOD6tbMQ7pA=;
 b=lOmlAua689kAFCthFnJWNizWEeAZerRgjwzW708mClNJFDTjs2HvHK0ofjo33GqdHBT9y9bsGyrZxhTszwQUSzhv86FuoSn8Ep2ThPNt6o092b1ZuXB77pVsFl3iTW6JZ+0puBEAc00F3BhgVhg6O0U03K4t917n6qOBXGu6qXQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB6121.namprd10.prod.outlook.com (2603:10b6:208:3ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 09:41:50 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 09:41:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v5 3/5] tools: testing: separate out wait_for_pid() into helper header
Date: Fri, 25 Oct 2024 10:41:32 +0100
Message-ID: <391ca859c6e7c997647f43863a756808d368f8d4.1729848252.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729848252.git.lorenzo.stoakes@oracle.com>
References: <cover.1729848252.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0377.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::29) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: d184e8d2-3bee-4e55-bb7e-08dcf4d94062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dxET7Lb0S6TU4XQkkrk/7zZgq0wP/7shpYSDYGAzgVQ9EGCzucqBYzRur4W1?=
 =?us-ascii?Q?Zmoq9IwtWz8waop5X0jYnxKu8aBH6dIUuu6l8ducp46sKkV6a+mwTbaGgg4f?=
 =?us-ascii?Q?WzU6kWgBFakZ+pKEo1+XTBLVA9UPQtFruu/Jq/hCpu36NVsof6HcvsH8U7O6?=
 =?us-ascii?Q?ReEWiqoQ4/RI77d0Aamxi2PYySu5FEsncm+gLPEGnW+f1yEMDUepzz7VlmT6?=
 =?us-ascii?Q?mATV/GCwNYP35TiUnuB9XYMGXU/T+sdNcSAFyOlW+B3M/y17pKZVVYRTAfa0?=
 =?us-ascii?Q?jcObg7xt+nXJd3mR7A3sKwMco/Fs/jw9yCF5IoNgTgmIDadjp6gIQXk0Mi6j?=
 =?us-ascii?Q?jbW412dSxrDPwbm3zCqulUEJp3i2GOX72ATPtoVPKWtcZmFCxLdqEJ4e/Wbd?=
 =?us-ascii?Q?ZXS6ZhJNpUqZ0XSpJWMkcm7SJCdvlELdbM7Gaoer4SWxN+QwJXBYgVZe9Ol3?=
 =?us-ascii?Q?dfP8bU2NO9Dr57qSv3xfTWB9qd1H5IAN/NSJZhVP4eBOQw9nfbpm8uAKjtgN?=
 =?us-ascii?Q?sWDGJiUPMe6pNlStvXyeLSISh6My43/xe59W/T5MY+faB645bAq6mGYUPphl?=
 =?us-ascii?Q?VB9NyUhKfac8vll/bgRowusiBNeF1FIcvPQcDgCq/qALc8azaBtzQmGXUivO?=
 =?us-ascii?Q?N1imi5dT0mUZ7jgA69+FBMhWemBRo7QvtcKr7yjJwgS81/i5niirwhkzm6sL?=
 =?us-ascii?Q?ymvqKLhrwwP+O2NhAaqjWVcJgjcHiv/vTFupTuu1QIv+l87g8ikPfmeTUGXf?=
 =?us-ascii?Q?zqPh7QclRGFTsAvDe5ZPBPeDKogERdfvRKqVEyZcpWjv1dwyV286RRVmkKdZ?=
 =?us-ascii?Q?n02O2KEGSAifCKD+IZOUuNZ066mRFAmpVEKufamxPe11OaB+QLhOT3XWZoxE?=
 =?us-ascii?Q?+Br+rD7fJFk9huE6q0JX48dDlWJsPYFnem/QG4E81Emr0ywKOsD1fVSot9Qh?=
 =?us-ascii?Q?ksKeJQwrjonObtH8X7FQhB5A6p0HA6yOAT+0AOWFqAIMADwiNntqqAESsND9?=
 =?us-ascii?Q?BldXqxNX03H4vhne0PlgFotv2sTWln5bgehzdDGPyxrt3cIP7JPc64ctPnIN?=
 =?us-ascii?Q?tc5k5pUJ3ptLzdoWzehKApeocsq4n/Hogn8hAdveKYs5cMVMqyhZfKlYVz63?=
 =?us-ascii?Q?JFxR6+fyvqbCmtYVrViaknhgE+cGU9+qJUOoYNoc2UhYdv6tO9dWkT+MudE/?=
 =?us-ascii?Q?k+Kf5aX1WXoiTM/QoAiFsAD0KaPaiXyEJwiEgYqA8pkJsyfFqTbckmjzou62?=
 =?us-ascii?Q?6anjulnoQ2iasa/Z5EgAyTeaM++B/l4sihulWp0vPuAvOD8xyj2ZqrhcG4uG?=
 =?us-ascii?Q?YjRThHthhtQ9Uzx0Bqqyr9tA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QvM5UmjLoFG9y9JN4IoiZDV2BdJAL/U2mNSmNQOnvJ61vCZpTIC1X/npwTzB?=
 =?us-ascii?Q?WhA2uDrL0VcHRYDEFU38f7xrG0Ghdq/pVbsYJVfA/mv2beX28tt5aaYSzDEr?=
 =?us-ascii?Q?SE8wnmaGQuxdF2eM04+YiLmJ9v9nrbWLJ5ZhOppUK/cAQDl3ZhWnRkVk8vlY?=
 =?us-ascii?Q?aBb/F+XdsS/H+QZDspW7LrCl+BakVs6PD/j3GkgCP0o0pFK6I8QF51WRBeHs?=
 =?us-ascii?Q?Es59haBsocsCNnsA5DTHG5CP/01ob9UNU5ZbMubVY/Q3AtwUSaHJFELbLVYq?=
 =?us-ascii?Q?1euW8lPoSi5Fc14LYkqjgzVpdk26p5DNhgskF0q5xoP7lIxZ7M8+ZPg/xSGv?=
 =?us-ascii?Q?Vr3IZhRSa3Jtt0MNcEqa3EvoQ2JikceZ4veC/yO5ovu78DGPCGH0hfCWOhJq?=
 =?us-ascii?Q?xfuosN/mIz+R/UXZ63ewyb1Q/VMoHvGCoMX3Rdp5X2Sbge3dGNE1lcFbXdf3?=
 =?us-ascii?Q?IGtsPD1iyZ6jmH6DlZGZGCU8XsPRfHDFpGZkJKasoX1x4cdOU2Bdz4J5WAIF?=
 =?us-ascii?Q?Yr/uQSKApeXoQs51939RF3ew+3a+HWyavmyn/zYbIExNeO0XYqJREE+ZsCjC?=
 =?us-ascii?Q?/VF6smo+OOxjsD4uZVc3u78bCMD7vijtDroZdaCzqqNidHdRSvpdIPf5w2Bz?=
 =?us-ascii?Q?d6wPtdev6L83SOs+INfk0lfH69nqMZOLwsgRGV04FdTMJFyyvrGbvoaclfkF?=
 =?us-ascii?Q?ZA2fHwRohSuUq6fC6z379FHUxIGnsyGqWRpG5WXTVuv4BjzBeqnkSL9mMTKb?=
 =?us-ascii?Q?JbkXZX9mVHcanS4oeQsJO4fxcwlH0cVWps+0XK1cNcHqmkFGHF8BMJ/0Wceb?=
 =?us-ascii?Q?2XhS/2yEPKWO1HnVzVAGXX+ZG7xNOiBnkaT4VWHWKRYAPH/Z6T7wDCIoelez?=
 =?us-ascii?Q?98NYvyowi4xdP7NyPGx5uou4fTBB0L0K2XbHXW4vlVxlZj15es+MQiNjoSBt?=
 =?us-ascii?Q?ULYIhvLfNbRnEMHYHCMAE59lxs5Sp/UurGF/v+f5oCgEFw7oYGWiP3wym/D9?=
 =?us-ascii?Q?iZ+NN/fWxQp3V5scfcO3gmYTCs1tSKADoLXw17r5NtaCYaOypYFsQBSNQkgH?=
 =?us-ascii?Q?MX4quw+tbpvich4oCRfXaawdS5vTySkKYrKUgUgIaF9oHhuzF3xPNAbQ6YZI?=
 =?us-ascii?Q?Yhqy1Gehy57r5Ztvp1VNl8a3EGPschMS43IKhY5roeJbGOQ380deviqhcwfs?=
 =?us-ascii?Q?fksRtiHuStfw+8AyJ4ufDnWIv/R5wisMJXQDDH2vW5tSHYesdDRsKKQrKaDq?=
 =?us-ascii?Q?RYdSXzkGZet2DdxpVcj7FqmODaf2U/xdDt4ox2hXVFLeN78FxjisQuxYvMtd?=
 =?us-ascii?Q?b1LetBTHZuaQRlkKvVe5AUvI+bzSJ9Nl5p0TYOml/DYEMPK89MT8KPkS3qTF?=
 =?us-ascii?Q?EdSPkuoA4xafarVQ8G3xLsWjyPzTp9yA/7nO2WQZVmNZtQHqOXHV1MxGswSV?=
 =?us-ascii?Q?bOttQwWauKyIGwmJmqPAk5F4vYSkdabioznPB9x4MnJbdbBrE5CIUzLE4bT7?=
 =?us-ascii?Q?yXJBTOOExA5fHddnu1GLKYacezAaksNihB+wJl+44wJR9dvqDB+/m7s6Q8Kl?=
 =?us-ascii?Q?AzwvqduM1Eu+EmHpOYnY7ORVTg3OViXEoEBBDPdZvgJvPbU/R8yuc410ze2l?=
 =?us-ascii?Q?lX2ErORN4rHCxQrJqsj2PL87fU7flMvVGgPUS3/19aqmhmlNrNISNnwsw36D?=
 =?us-ascii?Q?ZvjO2w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JMkO1U5gdOyjD6QZ7zFjQ2gwjmsz8AErz93tR5jpjD54jWFDCs7vcZeHKA1OBau4NFL6R+dBEsga0+TncgVgag0ia19uGtrwCQ5XMvK2ab1ZFNkt1AqXApaKbB8G3aO2jzIDPcgNekPdPMqWVAVlO6WRx9+cx+1qK1BfvAB9jZRB5CsA+eHFciDvSkeqYlfNf4hLoK03Rts47rQTUMbgRg0s7bEnVAsE0ZJNPQCdB8j6qUpSocshnyfGTh+T3tkDBm+9PjrtC7p7aXF4gII9gJTfYp7E8P8xe0DJsDN37JnNMi3CA4nP7dyOVcK60ei5uHPDooe4J7bN+qpJi4tK/ZDteq6HO8TcR3+YgUqzsDmxD4+5I6rbr18mpLm0XHbWFPNALbLFbze+QXvcJ0Iiq76L+dosIr3DyQeJmxqM0D4/7zFa/TeOmbA32G031cjIkuga61gAf/eXbGwMmdSs5hOG5GZ23K4TGZ2zAJoJYGOyVsnyzWCAquh1peCgBOgZNrV4DjWX3A/tDNuSsKbsZ5h7knLjRk8dLIbK1vthVyZhNSaH7WN74PNXkyJz8bN9bgilvaJm/1QjUJ0jSo+rIYDQfAk4JNUiUdfvAcv7bWg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d184e8d2-3bee-4e55-bb7e-08dcf4d94062
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 09:41:50.7860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+btAPDiwaR5mDz6CRXHVCoH4FYmleoiRobOEE14ntl80tKgS3OBzsZG8+d7K2X+Nn2eDezDa2mxNJGxfwdcGLGZ2LvRCyokUvo9RKw7hac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6121
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_06,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250073
X-Proofpoint-GUID: 5FgkEX0XTqnEDSHi1T4J8rYwtS3ykv-L
X-Proofpoint-ORIG-GUID: 5FgkEX0XTqnEDSHi1T4J8rYwtS3ykv-L

It seems tests other than the pidfd tests use the wait_for_pid() function
declared in pidfd.h.

Since we will shortly be modifying pidfd.h in a way that might clash with
other tests, separate this out and update tests accordingly.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/cgroup/test_kill.c    |  2 +-
 .../pid_namespace/regression_enomem.c         |  2 +-
 tools/testing/selftests/pidfd/pidfd.h         | 26 +------------
 tools/testing/selftests/pidfd/pidfd_helpers.h | 39 +++++++++++++++++++
 4 files changed, 42 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_helpers.h

diff --git a/tools/testing/selftests/cgroup/test_kill.c b/tools/testing/selftests/cgroup/test_kill.c
index 0e5bb6c7307a..2367f645fe89 100644
--- a/tools/testing/selftests/cgroup/test_kill.c
+++ b/tools/testing/selftests/cgroup/test_kill.c
@@ -10,7 +10,7 @@
 #include <unistd.h>
 
 #include "../kselftest.h"
-#include "../pidfd/pidfd.h"
+#include "../pidfd/pidfd_helpers.h"
 #include "cgroup_util.h"
 
 /*
diff --git a/tools/testing/selftests/pid_namespace/regression_enomem.c b/tools/testing/selftests/pid_namespace/regression_enomem.c
index 7d84097ad45c..f3e6989c8069 100644
--- a/tools/testing/selftests/pid_namespace/regression_enomem.c
+++ b/tools/testing/selftests/pid_namespace/regression_enomem.c
@@ -12,7 +12,7 @@
 #include <sys/wait.h>
 
 #include "../kselftest_harness.h"
-#include "../pidfd/pidfd.h"
+#include "../pidfd/pidfd_helpers.h"
 
 /*
  * Regression test for:
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 88d6830ee004..0f3fc51cec73 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -17,6 +17,7 @@
 #include <sys/wait.h>
 
 #include "../kselftest.h"
+#include "pidfd_helpers.h"
 
 #ifndef P_PIDFD
 #define P_PIDFD 3
@@ -68,31 +69,6 @@
 #define PIDFD_SKIP 3
 #define PIDFD_XFAIL 4
 
-static inline int wait_for_pid(pid_t pid)
-{
-	int status, ret;
-
-again:
-	ret = waitpid(pid, &status, 0);
-	if (ret == -1) {
-		if (errno == EINTR)
-			goto again;
-
-		ksft_print_msg("waitpid returned -1, errno=%d\n", errno);
-		return -1;
-	}
-
-	if (!WIFEXITED(status)) {
-		ksft_print_msg(
-		       "waitpid !WIFEXITED, WIFSIGNALED=%d, WTERMSIG=%d\n",
-		       WIFSIGNALED(status), WTERMSIG(status));
-		return -1;
-	}
-
-	ret = WEXITSTATUS(status);
-	return ret;
-}
-
 static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
 {
 	return syscall(__NR_pidfd_open, pid, flags);
diff --git a/tools/testing/selftests/pidfd/pidfd_helpers.h b/tools/testing/selftests/pidfd/pidfd_helpers.h
new file mode 100644
index 000000000000..5637bfe888de
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_helpers.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __PIDFD_HELPERS_H
+#define __PIDFD_HELPERS_H
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "../kselftest.h"
+
+static inline int wait_for_pid(pid_t pid)
+{
+	int status, ret;
+
+again:
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		if (errno == EINTR)
+			goto again;
+
+		ksft_print_msg("waitpid returned -1, errno=%d\n", errno);
+		return -1;
+	}
+
+	if (!WIFEXITED(status)) {
+		ksft_print_msg(
+		       "waitpid !WIFEXITED, WIFSIGNALED=%d, WTERMSIG=%d\n",
+		       WIFSIGNALED(status), WTERMSIG(status));
+		return -1;
+	}
+
+	ret = WEXITSTATUS(status);
+	return ret;
+}
+
+#endif /* __PIDFD_HELPERS_H */
-- 
2.47.0


