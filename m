Return-Path: <linux-fsdevel+bounces-38320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899B79FFA0F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 15:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50288161445
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 14:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931BB1B2190;
	Thu,  2 Jan 2025 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D0GEaRA4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vDzv6gtI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582692A1AA;
	Thu,  2 Jan 2025 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735826693; cv=fail; b=X130kkwPkK9nMBVnmJ8+yBv2SembsMlQBEoLPQYjyE1lQScmAM0yQ9PfLUKbGVMYdaSJXLStDS1wEcahfOKHXovybUWsw083S4Szcva+T0kXL0aht3LB/H0BmNC3Cq5qgtgmo4CqEaYy9z0r+Z8s+mFVS36INfLh0ep5ArL029I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735826693; c=relaxed/simple;
	bh=L+4Knl7nCtqXr5ksJZkH07sbQASo6PXxqrkkVpfcwCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tagy6Gr6mNGQCSQkTO/5ulsvyEib5ONpH5iAEQxtHa+ZoYeijHV2zfyIz+LLeW+vhGQSXQPce8cj/BVvsj4k4+8OIrK7OcBuBPhp0Ub7eE9lONHTspgCkTOYLpLNx2QG6HQolhEcIQKXhCm0LdjTvoPngv+gBT5Y7o1MrmFD6gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D0GEaRA4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vDzv6gtI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502Dtq4u007357;
	Thu, 2 Jan 2025 14:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0iE5Kh8TJJCnMiL7y0XxbbiwgChtmDjzVXehBJ8coRY=; b=
	D0GEaRA4uSkTi7DgP/EXsK3ii1OQuIW28TFUC1aYmzX2IGE6oDCU7RKaED5Aqdb5
	ts8MKT1twStw927iQsXOiSwp3FH7eyaAggExOLZiK980vgic9SWU/rICEapi3m0Z
	4sQEEY1dCQzPU5o2vdxlyS0gdVS1MXR5E2pr9b5knfU4xTW+GlPwNwmXf7lkqSdb
	tX/d4y4OkVolJnFVBmkXYU9x6P00MZT93Oa1ScOyxDQj4v7epMB9e1G4jmPTFHwN
	Mfy+MQgh7ceZeji8tybeytNGH7UZjSWETVYSF5jFQ+wuHCEO3nkZ3NKkcFit3T4a
	Y4dj8m4Ix10Y2eydF2Xxlg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t978najc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:04:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502DEWN2012914;
	Thu, 2 Jan 2025 14:04:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s8jqvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:04:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lESuceQ0FxRw/u6O3vgrHa8BfFvf6t/TfRrdDXuW32WxQVLAzV95OkiEV10xYRWMB1kF1t4UITdyVLEvjw/59m96B5XfzTcqhkrfMVYx691EFyWiVadrWw8Drq6UzlXZxewq7Tq+aY+5ldt7F51hOKluil80AiTb3EBxSvt/M4/NauboH5PMitaCVfL4rZgaaA5jV+OUY3d8T2+lzikBOxUK3FSc+FQlrT+QTC6ZjcOTK5IM8zcw5BTdrB23VJlk4xB8MHd3+btOU6evPBNFhqWwRi4pwLOtnzqoBgKjFcWPkrdR3p1t3vwxYyIk1sGhNcWranl9pSuF2zGqYrtVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iE5Kh8TJJCnMiL7y0XxbbiwgChtmDjzVXehBJ8coRY=;
 b=wh8sExwsYt3HJL1DJvDxp2CP87sk9Bkssg5DiWTUkV3yXk0bD6So7nUQxC7trnCMoJ0ItiDrAxMk6Hh7eyqiUHRR8e6rf/KIZCSPBhm1Ie/15uSyCWXjbzCbOqo4gvJNLi9Ll1IM0FDlj5dmk5H3AII3D5PL/7u+Jj7bF1kQGWnG1m9+pXoOZrH7qeSe5FaOevSiP8oozOC3jgp82FlNvgoj8yQU0njKF2jjLfVjpNEQL4knQpqf4WF4CTDstbD+eRImJFKenwWEdmbQUk2i6y0B/ZEOzO8M1on8Sow3RrgP8Qv0ZDjryRTqrVehEPGGwtVXQ9vM8d2wOT07j1j1kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iE5Kh8TJJCnMiL7y0XxbbiwgChtmDjzVXehBJ8coRY=;
 b=vDzv6gtIKNVG66x5Qqyl35gFZ1MY5/uo2wiLARUq5QEmFZwyp2moehwki0XV3fLJa1i0DbDhPNGnj8vXIGDOTZQ8Q9Q3spElAccduFoJ/sUVyigORkkL3zT9YTEcdxxbXkIYu9SC709husCmIToeJhwzNgogXrD7PXG+82nPUtM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA3PR10MB8164.namprd10.prod.outlook.com (2603:10b6:208:514::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 14:04:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 14:04:36 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 1/7] iomap: Increase iomap_dio_zero() size limit
Date: Thu,  2 Jan 2025 14:04:05 +0000
Message-Id: <20250102140411.14617-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250102140411.14617-1-john.g.garry@oracle.com>
References: <20250102140411.14617-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:208:23b::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA3PR10MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: ff93f813-1a47-4ae9-3c99-08dd2b3663f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B+vShM4YYQSqrYSK12qRZFmCi3i7Rw4FUHlP8bxnxs0a5hI2f/knnQG9Podx?=
 =?us-ascii?Q?923RRcgrOa0CjzA+0xN8NXNjsxul5K52LLjVdhDPVQc+Jcs5Ijfw00oeq32V?=
 =?us-ascii?Q?KSKgwHxz8aSODHWMXMCQtvSxHVc4K0qGfMq9WPdK2Thpa9QP8C66q76wvcsv?=
 =?us-ascii?Q?RnqwzhjwBBZVyBGDCZ8Qd+KM+G9JYpQ3UbocQU31S441Q7KUUqP4leAO4wpk?=
 =?us-ascii?Q?kH0nyimLoBpfj0bTHPBj2vHhtBtVVh6SI9EqXLt/ZQ0y3PcobPC37CLvLchL?=
 =?us-ascii?Q?KzlbMdfsuU1TS/FWuOS/XjO7h7Z6wvTc1hqoIvPtZqSsOfykQwZp2ZjHBDEQ?=
 =?us-ascii?Q?P/+B0yxIDb+qWu9FMA1hVjAR1H1fM/ZEYNVTOot8IF3atYsQBWZcYsF7f3zA?=
 =?us-ascii?Q?8bJfI5mRDnQSLkcZbA55B47CE0iq8YQCLCu0Ylm97Fs9G6T1/6k23gysCijY?=
 =?us-ascii?Q?pbBVizD5R05sOD1RUqiNEgRN2KocFzrzFMBAUKM9/dDWQYcnevbruQkZXkqX?=
 =?us-ascii?Q?fjFbiWJxVjJcz35RxerYOMMfNfen229KU+BBWNOw5FTNSJFkvEZUUwz5QTpk?=
 =?us-ascii?Q?TaKieaHI6shpJ1X+O998sDqZ3tXteJGmcLP7z7TdOgzHF/cp3x/CnBd/J64e?=
 =?us-ascii?Q?yIiTvF2SiqKQqXZr5rBrfkta/751XLHKVmsUoFKJKqeG1ahUbmPA8Vjwl0ws?=
 =?us-ascii?Q?KhaCCe44IFYqoGhBTGO8WrNw476ZXYEZNRfiNAI2ysB/73GUxCmLH91a600k?=
 =?us-ascii?Q?LWLye8udBuSy22dOIsvwHHAQGkz5xVkwSyTFQsSFNOYWojJ8TB+OxDvpqMJ1?=
 =?us-ascii?Q?28Hvz4ZvmDWrl0tLFr0UncDTmAPmpJxTOAQ7TAkIGSxkz6tcVPPz7RUwKAV+?=
 =?us-ascii?Q?5D3DjcpGjdpBvCVzqpavxzB8LqQpT+j3SoP5AcsotCBUUPNW9+WCZiZNo/WT?=
 =?us-ascii?Q?GBsZDdTF1kPWZSzVHX2bvNczQW5z8NWgdu8n8xEUnaSJPUhELlybKyI01r+2?=
 =?us-ascii?Q?itoXRrwCAsnY2G4QURlemAmQJGLXwxni1xqXGHKkH83OemuYyNpwJAH/lIzT?=
 =?us-ascii?Q?xv5Rs84lXHUCRIRkjBVEXirMjCM2YhZxxZnUhXrPKgAh1bUREsRuaIIFQ5mX?=
 =?us-ascii?Q?AxGOPAB/MEUQMhovKfyqr2Zv075+JqbGMyNQEg6voS/KUjsCfwbsVJi/2nik?=
 =?us-ascii?Q?j25ZH6omgdOxyb5ICEK6S3pWGfIvvY2znaeMdlg4MCllrU3TxMh8oRzwWMMD?=
 =?us-ascii?Q?y2WlJlw7Gmh/0//ULG0G+z1r8FkuMK5MFrnPgTrJVpkOFwV4OyLNhfyYOxhU?=
 =?us-ascii?Q?DVavHkDegVekGX4hWnKC5oxOvzNKSEnu0yLZzx/RyQmMC3BQ/no1sgaOvhDa?=
 =?us-ascii?Q?izLrXT6wc3xKT807irQzg5TBLpSr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5evN3mO3qMyd4gjv1chiDo3kdYLru9+UEr2iqW9wCDeKL3wZcG0k7kSV7BzT?=
 =?us-ascii?Q?XQ5pCGEUgGfCMq7KVDchNuyCJi+cGWcPew+MUzjWWGIJHyewVQrMEK1tAWGI?=
 =?us-ascii?Q?OazUI7HPpnqzqi83o+tcYGoQczoeKGAVSNtixQPLEPailTwrlgTvj/mXuDDi?=
 =?us-ascii?Q?Q6jC+DitKvVS/MqvFlkpi+XfAUlG4XNCKoamMkbCQdyIzc16WxL9sNKZ1T+K?=
 =?us-ascii?Q?4mCHS+0FxTjA6qTuW+UWo6CwCLgpk15RZIKOYRDbK5339kQ/buoX30KPusMR?=
 =?us-ascii?Q?a3B6bwkLy/S9Pnwa+P/h1Y3QJnq7hckvXCHXm2/G/zafei/Tdj9Xwdhz+rgV?=
 =?us-ascii?Q?Z0pXx3LiRT7uHYXUaIOaJGOEz3s28eRHQMaCgvXz4ueide1CoEbz4jdTXdJp?=
 =?us-ascii?Q?zzZCbMqXIWpdK1n0DFf9yY98I/3j47KFEKi0/jnC4fPA33fTzMh774yue4IR?=
 =?us-ascii?Q?a6A6ehPkahb77q+TO+uRBxGJVIf99hgTzWG32KSzGyG3plGEzzEFoIQs8lDM?=
 =?us-ascii?Q?+oPu4UmOB9IEOvMTebn0rQnkfRq0Ye8VPMi2+mZtalvcbRGzHMpYjDgxRbdG?=
 =?us-ascii?Q?KAqFOHsD9KLm0U91OBlGWIZYEywhcrmXAXfXLiTiUDpxuWdLWvMMuG1PQj1G?=
 =?us-ascii?Q?eXnqDna1+RzSv9EBOAlE+z7IULOR9PbyrJ8mcGKWElsuD7sv3sGyit/qeGUg?=
 =?us-ascii?Q?3MKTBvYX7A3T7SZEzOQqQ5gkHJXs8xW+qujBbo/c2LEigumR9VSc3iqKZXK4?=
 =?us-ascii?Q?vWLkvLVUyyJUapnU6amkpLFoIjDnNGlDsJCx/0Kzse5Hu3gcrkzrw93d0HwU?=
 =?us-ascii?Q?jxEn1FV23s1HzniqMFoaK0779UyKSpmEZxotmdZ6dWU7O+lxrkr8MhuZXKDJ?=
 =?us-ascii?Q?HRFVIw3j1JUghRh8+2pCeP1fv91iTr86gaN78GO0iQFAkjuV3zKhE6/1Msg0?=
 =?us-ascii?Q?gCV0EXVyzHQS6rmRC80AjESg5Z1aGRsDSCJ3YVsMX3dokcL13NCtogNLivVr?=
 =?us-ascii?Q?REEWFbNm0ahFeGR6WMkaXrIv7GZtSxac73Z/qE5mrGzbirokHoO9NXYpO90t?=
 =?us-ascii?Q?sztSFnlNkjpkf4wTlg7tQLQ+1Az6C9ht069LJALnM7CScfLjanjWTS3Izph4?=
 =?us-ascii?Q?/uovLJnu4b6WZXEihpd6CEV3SVKckIy9pzwpGhMat7BE3tH7+TtyT1haRROg?=
 =?us-ascii?Q?tITDXEOPL6nawVROHyIJj/qK4eiD+VvKREpoyHdnnlAGk6OGgynqYWlHsLiJ?=
 =?us-ascii?Q?9Vh8az6UiIss0mQqbKJ52LEww2aU0DSssOploX9gV8N72guaUSqKNNhXUCcF?=
 =?us-ascii?Q?kMfzRnspd/7jJsHyIpMZai5oTTL0j1C5IFdkZoCMg+43JJWTrmkQKIJeBTje?=
 =?us-ascii?Q?8K5g4yMr6xSEkb3dGIqYvmYE45NTausFO7da9AWaJAvw6EU3hb8fjzSLg+kT?=
 =?us-ascii?Q?PRP3Szj8rHk4t3FWngJKaaME0PRcMXd4eOB2xr1CQ9V3hhmPa5CctMpyMIL7?=
 =?us-ascii?Q?/ZjtG2FqakkYiSpR/Ss0SLEntdULVgL72ytI4xLDckX7r7TNArsMcN8/OLgt?=
 =?us-ascii?Q?ey71TfEx8OYV/vAmijSIDzkhxkkT0uk2zB8pUXfTiibfSea5C3le2w7TF5j7?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EFhAiLGfbPtkoLrEW8EG+2o7Y4X6pHPXreadphqMYTWzkAbs0Yja41rJzaBvZ6ixdSr7IC5B6wWbruTB+g72hbXP4HEA2rJRXK++oNjaycLZw1FhMpMm99ceE/AGSZIZ/Ahty/7V5TxggJg+SlBS0zzfhkG3Utb4qBJXUJWiQwGJxziNNSryW8sw/rc7EVWsxP3wWY5EIBA/WzVXUlShWfsbLee1svR0VPOWpU4gBjQbfn5RYZniV7g51Qzwv0HNStJDoACBPMquiW0fkf9ELDIZrA3fwHqcKT9+CqO9Q11ar2AZ41NFNoHKVSeK4QW0UooXPWyYmVu7m/tR/5FGD9VuraB/UYbRTWDFqL3R/LrFjk5gTAMJqyc9uQyM8GQ9Hq2UJqWqE7lzCLDeFibf2Zbam7o5hNqnMfvcknvvdI0nTZwdvG55oZPEtlwh63joXXJLCwm92oyBMG/ZyDSYF2SkkihEyxQX+yrdIrKjPq+gnBLYh8dQWSfrjirw66+57hH1DAvkyQadsg/lTMcp+gqUScEeUEtDB3GreRmRIIAtdKlZ1nD2meXEpS0r9lpaKuXkC/dM+zXSoFXsusI9d0RZlACBOZ/nKLDX5LJL/Uk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff93f813-1a47-4ae9-3c99-08dd2b3663f7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 14:04:36.3357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfTRv/bVWelZldLlACe70tkn4D8pZtces9h+CPvkyQEe7XdF4j0xeffOmeUY1c1WutVBM8txYjwm9T7seQJMQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020123
X-Proofpoint-ORIG-GUID: gQwG63cTWAJta1yF78SgQ4R9MajSp9do
X-Proofpoint-GUID: gQwG63cTWAJta1yF78SgQ4R9MajSp9do

Currently iomap_dio_zero() is limited to using a single bio to write up to
64K.

To support atomic writes larger than the FS block size, it may be required
to pre-zero some extents larger than 64K.

To increase the limit, fill each bio up in a loop.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index b521eb15759e..23fdad16e6a8 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -240,27 +240,35 @@ void iomap_dio_bio_end_io(struct bio *bio)
 EXPORT_SYMBOL_GPL(iomap_dio_bio_end_io);
 
 static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
-		loff_t pos, unsigned len)
+		const loff_t pos, const unsigned len)
 {
 	struct inode *inode = file_inode(dio->iocb->ki_filp);
+	unsigned int remaining = len;
+	unsigned int nr_vecs;
 	struct bio *bio;
+	int i;
 
 	if (!len)
 		return 0;
-	/*
-	 * Max block size supported is 64k
-	 */
-	if (WARN_ON_ONCE(len > IOMAP_ZERO_PAGE_SIZE))
+
+	nr_vecs = DIV_ROUND_UP(len, IOMAP_ZERO_PAGE_SIZE);
+	if (WARN_ON_ONCE(nr_vecs > BIO_MAX_VECS))
 		return -EINVAL;
 
-	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
+	bio = iomap_dio_alloc_bio(iter, dio, nr_vecs,
+			REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
 	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 				  GFP_KERNEL);
 	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
-	__bio_add_page(bio, zero_page, len, 0);
+	for (i = 0; i < nr_vecs; i++) {
+		__bio_add_page(bio, zero_page,
+			min(remaining, IOMAP_ZERO_PAGE_SIZE), 0);
+		remaining -= IOMAP_ZERO_PAGE_SIZE;
+	}
+
 	iomap_dio_submit_bio(iter, dio, bio, pos);
 	return 0;
 }
-- 
2.31.1


