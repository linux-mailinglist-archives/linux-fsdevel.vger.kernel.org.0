Return-Path: <linux-fsdevel+bounces-49333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D827ABB7E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 10:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532E11887903
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 08:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605B126A1AE;
	Mon, 19 May 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JYvq8HcK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YzZBQhJl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD1526A0AE;
	Mon, 19 May 2025 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747644742; cv=fail; b=j9CiC0r0NBs35okd8pCwQk5B15VmdidlnKgf6WRMvA39sFlThWCtPvaHUxKONgXtbe5ADhCntXHRdrEwYq/5V3DAcEpKaVoXU37SZmIptY1QivHvNKgVD3aI/L+5tsc51H7M6E0zbAhoNg8ipVm8D3kZ1hok53kkUaAlNFhMXGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747644742; c=relaxed/simple;
	bh=6/sKvf8vqS/WkmwfxrLkZKY1AQ+syPxTLOdjyhd51Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QF9bxh2IC/YY2t7MQ6BVuDao8MWm3F5vyWnuPd78aedDWbzGvaSojeuw+JcdCaCTBKpG/02zwkHq28+N+NIMlsLKTOfHyEMWZPc/B4zG/BaL0Eh4O8RwXrMWJUQOgtBj760PfMNkU22LOQDbvFXRfaTf+BWIaiiRUGSgJ2SGji8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JYvq8HcK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YzZBQhJl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J6ijwA024932;
	Mon, 19 May 2025 08:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=eTotjCqvzuqwBDx0TGUdS1aD9rrUNtEE6ZwURwlQl2Q=; b=
	JYvq8HcKPWNj6nnFBO5AqdviOXYI/OphZsW23hce09Kdv/jRyj43kfmJ9XPABjWp
	UTdOYpXuiJKYWwvYrfqAdL/J2eLxKzO4zs4+1TKWik4J3PT+l+YAEOCiRJQXRmF5
	rX8yuGmsNwG3tVrdpRGTRSf10pGt1Kotzcc7ZK4Rj5ydaE/TU5/+ZGF5i+DTHikb
	aYFpvUstlBczfINUvyGRtFUStnf2KZdzHhzzg4zuoC0UxLFUGLuEHSJpYKCq+YVg
	eORWzsTxTC/LDctshGJaPYG+BWaUQeHLF30UFjYMPK6Ojch2agtLkqqj28ddNakL
	CJs0hec9rgMAtQU6RqKc+Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pgvejfq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 08:52:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54J6rrcU022284;
	Mon, 19 May 2025 08:52:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw66jcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 08:52:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWW4RKylfhNC+n1P6TkvynTII2IyMDsrIBkJzZ2/K3uQyj1+PBB+Tj0gGiSxG3QjrG7oJh+QCA8TAppKpUGd9z8PO6U38Z3u/L8W4H7Pp+tB4A6K83SD93YAK4uY4WnApq/VgsZMYlO5bMusAHigaXPJLIGmaTM0PM2uA8PppxEGlUJvx7ESxi4Td/+RuK9Aht079L8NVMQvJRUkYQuCo5jm/rqow4NszT9MweG02ql0kcGzKuYg2cewP/hnJzE9wOdf33fN7UGl7Zxm9Fu+b0rYr9lT4eg+eHIM2qPOdVNTQsv8KlDiL2t1HhH4inx3N2iGtpu9wXE3cEOJ71N/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTotjCqvzuqwBDx0TGUdS1aD9rrUNtEE6ZwURwlQl2Q=;
 b=qj5AQvcP1vhdbLQJq1Fk4zGEclcIuVMrRoWqxpUZNdXnpdbvPgZQzobU7Pb7liYhcxkTl8oUJGMai7iP8076EWURrSOs1SbYxo7ni6L+RcDxaEIPC3CU0aQkRbucEuIa0d6/gvY3v1xaPC3C0JltOBhMSstAcWIvsQ9N1jma11vCsoOfpcZk9KrmPkE3QX2Ua4OrYGd7ppTi1+EsU49I4CR/omqypECjpA+iMgHYRAetEhlMkmSumos/Ce45fcQWJUIBBFsHZvvmk9jtACnSn2iZoRduGBG62eUcr5pnZCkMtilZrQm1+L1pk+jM7ADpnNIFCxMrE465fls3HYsheg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTotjCqvzuqwBDx0TGUdS1aD9rrUNtEE6ZwURwlQl2Q=;
 b=YzZBQhJl6R83G4TjX8KzqNvxoCVTAhsoHy2AHpP7Dr6763wzg+kxPQ1a0uhMVvm7ciN/aO3DRDXqBMzoA4fab+TJA6hs696cmratKiSlWLNzWdF4yeIkC2eExOHunh8Ebb/YE3RH5gWhDSt+mslsSF6XqO5Fdm6zVYFUULGpYRU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7767.namprd10.prod.outlook.com (2603:10b6:510:2fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 08:52:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 08:52:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] tools/testing/selftests: add VMA merge tests for KSM merge
Date: Mon, 19 May 2025 09:51:42 +0100
Message-ID: <95db1783c752fd4032fc0e81431afe7e6d128630.1747431920.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0261.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: f505d65c-7309-4a2c-836b-08dd96b26c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0wTJVCrdrEJWj8q62c1l+ISgCul/Jc3Giy7d5z/58hKl1dI9LiMSSLFfbtpd?=
 =?us-ascii?Q?ZZ+I1Z6dERu2UFFKFV5Yegddo/0gis4CqJnMlo+2AEJq8KLT3t+j1JLm4+xA?=
 =?us-ascii?Q?pSe2b3pnJz++QB7FT4xxYaBMnYtJkHhQIrlMSWjXsaUemmKJytNKB/i/eHdY?=
 =?us-ascii?Q?3LqRvbmLEKa3e25EMMczjEKwFIubpt+6V4Klk/hneskdXsAs6OyvToM/7fPM?=
 =?us-ascii?Q?iMqW54lZyEjHpY6GHTt5dVcnO+rX6MnwAME6lqkkw+TMMvqZc6gGTs2zEXnV?=
 =?us-ascii?Q?0Z3v9vOXUtVNyFz8N1PdURTZWWK/yRgIpMb5c2c7QgsJuPUdAbYwyabFBeSQ?=
 =?us-ascii?Q?ORvNp6k7YEizJa/0dpGHc4it3VtZn3dwAAMiffqpmG/rwXzYVSFgPdwdpy43?=
 =?us-ascii?Q?wceUpzzttQRLnHvLcYUQBaJz67T8w1n0nfxxjFCWk1597sZAaOG5jDQDqW57?=
 =?us-ascii?Q?53PKvi7qh2I2agqJ9CjDz62GTPJ0oB6GzQ/m32v8MMzGsV2vT+8SlXGMCbgw?=
 =?us-ascii?Q?x/nUqhwSsAXBL3zKfVNBqi6cWBRNiL/9ZExEL23bHpKe6TVHL708aO+pLe9O?=
 =?us-ascii?Q?wbrlnzVDYxMRNfXmC1pDM7X7CoCfBAlWhw+FuZmc6vrk3s8oEggC3LGAmLvU?=
 =?us-ascii?Q?QzqkZh9lejmXNz5kOWhZLKKvCUWNR6klNc8Tb4Ta3GqqdXPUHc52jYkgDXHY?=
 =?us-ascii?Q?xHZchb1Ry+oj8Vv1DjqDlqzfH6+AbSrsP1M71DZrOC6lvfPmxp14j71qHV/1?=
 =?us-ascii?Q?qIE1fo0z++rIG5v3sNgiWpVp/VBw+2R3IHi5oxjQeIb8XYacfpI9e9T2ETzo?=
 =?us-ascii?Q?A+YtBAqIjQVdWAGZyF+o6Stz9Osjxhv77hNRJ4nPdcumCllaNg+K2uZri0ul?=
 =?us-ascii?Q?pk49QbFAsLNDJlTmvI1Kp4zQgF7jmrLVzZhNW0nTQ4DYxX10K/ugJF0yJ+4x?=
 =?us-ascii?Q?tfmNbzflXRpzV2naHMg8OCsXAd8fCNjVLe2CRzOXmuFCj28LwdCLUxCxtIQR?=
 =?us-ascii?Q?EYNU78fS3KcvoXj27Yn0JtudkyJMW9h9aMRaZmOIPBRbyhkgqE0QM2X2yAoW?=
 =?us-ascii?Q?IvLhwFqaq+tOl/hzdVsGrilka+7L1xEeEzcNzIQy+FC4LVNoOmSTwN3lIMtu?=
 =?us-ascii?Q?6t35Qr/wRkbIIp9ceMRgvEvtyFklbd9X/gb61gmprrE5KZcZYkB5vVe2mUiq?=
 =?us-ascii?Q?BOxmR5T4vyQbswq8OJoFyU/ODH59COLpUaJgiFwiwuKdA1NPNlHcMLmJ1f3N?=
 =?us-ascii?Q?klfoOcGsJItyBfcs7isVUxjc0BbiJ5VR9OCcKZ7KlO1kc8Aox78eoSe96GD/?=
 =?us-ascii?Q?fJaBRIWWWf4nNGTW3M1rF2Erh/um4UZaSQLmVa/W05rDCoGuq6GNSa7ES9/C?=
 =?us-ascii?Q?CUtXKzvpWJ5ztmKq/0Ua4GKk96bMgqGx7vKsWsqG6hKK7znGzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YLq8gwD/mGEQApW5FLHB+5JlMJnN79Ka4TYR2DLGjfkKzif7gAFPG6rZvbtD?=
 =?us-ascii?Q?uch0oIP/jYt6CdPoqfjZ+j3u7I4XpDn7TzdcHF/Nd1rnAy98WOOo166SOCkJ?=
 =?us-ascii?Q?7KTUOdGQvXQ21kbK4ltQ2ZFGGnimSQjLuuTZq4lgmvnX1Ctb1xbUSLrXNfl0?=
 =?us-ascii?Q?goQ5GlCoySEFrpqsa3vwrIGShvm+/fIIBOTUOUjgLTNo4kdeJmUFLnkSHF56?=
 =?us-ascii?Q?rhI0b/P0N/fR7ZB9BCq0kqIf6bv2KuJj+p3lnMtyRCOPHnzN3IBWdOipOuSv?=
 =?us-ascii?Q?z85F5awV5AZzjv3YVRYJNlB01Dx5efC0jNIswz3VwruywC00a6lMpKedB373?=
 =?us-ascii?Q?bUtZV9FXVuDhJUJljKuRDVgblOGdBunk0wdjuARbG+M0ddpSowW5RlMJ/0T5?=
 =?us-ascii?Q?4a1s4KcYZi6VfZG7WTG9OKKO4242U60hu1FQvokVrPahx717wHI/solB41Gh?=
 =?us-ascii?Q?nHay+HFwujjAGHRTmAa0NgBjX2g1pdwGMQoQk/uanjLHb9RhFiGtzOkzuO1B?=
 =?us-ascii?Q?9zagcEv2pZDrCj+NlFj5U73gL8cNbZnpgj/9y3uystNmLdsAspWWYwvA0Be5?=
 =?us-ascii?Q?0Efu9D3ZfM8zAZlluev0MuSnCY8bQOkG8iHq4UzhG5CFcT56Yf2ibwHcwA2V?=
 =?us-ascii?Q?t9u0D7EBO0Cqq147TPsD94deZPjntXSLzp19jZEWvsz42tLbw1fKIG+7GBM5?=
 =?us-ascii?Q?e3z766SitjCo/tH8dgOYCFLltX+Rup0Y4qIpW1luzEdK2Mu4wo013p63TIEU?=
 =?us-ascii?Q?sd03mmzUA/8cNbNO/7f+Ft45f10+zP6MJWUIFH7cY0BQjfnZcgVLmrN1WLft?=
 =?us-ascii?Q?HQXEgoHnjldPcP2bm7oSolgnPaZHSqjy4ZMpvnznmqMXNVpHFZyyLT8He7H2?=
 =?us-ascii?Q?1PAwBynnspSI9XiDbnag1u2EQcoi6CiwZLkrU0+jvgPMSqrt6e6BAktTBwHu?=
 =?us-ascii?Q?al6lutoLztbHVTbSY2ISc2p5hqTs/9Fm95vVWFJbQF6YsW7Y611UuZS8RdWD?=
 =?us-ascii?Q?TQsuDsm85vd46SgFXGD2Ztnnn4+HQoSgj8/CHL67vNq4IMkfynDiVJ1apeFM?=
 =?us-ascii?Q?WiadtSpMATyEYjKlxliLm40viTok6YZvp2nuGBuP5EKk+Fl3odWq+cz0cmwe?=
 =?us-ascii?Q?DV2OTmCH5prLxmBQvkUFZTjh47wL+oywK1SDnfugqYj+TIEe/VmCuYPd1KPa?=
 =?us-ascii?Q?acyckQBNd9TOkUmyI/hSVzFdCUk4ww9WcGlgQDxKD7QqDWvs0rnzCAJuo4Ki?=
 =?us-ascii?Q?etvI3GQSJDF2zjxghMa03HI/PoyXRT3a8AZ2CTjUbnpVVl4OsS4KAXyRDMN1?=
 =?us-ascii?Q?ygFq0fddV52U5rL7tNUPsoQvPsb+pFTqKz0zu5dHpMHFDrEVMmll5ZbSdVqd?=
 =?us-ascii?Q?L6cFaeYaeqrBK7wioCKBBfVziy3+OXCkvt2+DLUTeXC0bUHydGstjNdLcbD6?=
 =?us-ascii?Q?vjMJnC+ZLGxafMrsJm8nK0YLSGOyhhdiCpQYJXh1Qyg7D74zoR8b2cbPiNUf?=
 =?us-ascii?Q?CGnMaL+I1nIb/UPcyGhqvUySe+iaiJHP5vV+IXHlYGQoHL4Wa9gFn4tmOa5m?=
 =?us-ascii?Q?/BORPfyoMgfjoIpHIMfBynp4BtXYsCkEs7oNARXeknEhk6bTgikFfCyws3L9?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i6xazKNFsHa9nDJQAKLGUWW2BQ0VVT8IhtOPe36pRt4Y6Dul+1vGFr2s78OEEV99QAUKz2mz64IDy4uxduTbJylOXrja9tNijcYyIavmVJecEi2eaUVkG9rkZk+w/GnWzZ6jiUX3ac0oO7L0sqtXCkTL2vOdykIYBWG3d00/5R78WRvd2dNwJ9ObFYFOpN+ouS1eHx5586S+ChPGufCQ/08bg5ggT4d8NDCYLODcjiMcUcS7eE2zc1N0rxE76pxwYivJiScr+wzk4dCViPDlS48u7T3I5IGY/CIHkCV5ljYJEMr3vcF79v5NDaSC307JN/Os8zR+EvMAqn27rSNAlHtiZCFCcoerAR/L61PQRXe6MYVZyf7v6kq8LHv1ZYuqs+lmKVjMSJfKR+6KUwp0cEDKEOSNGnrtMVqf6acPWZEJJ/RyhMOzhG7FnaQ/OwV9eE5YdbCnxheMroImjD4Ws2xs9VmWj5yKUQzrgmeO80qf+HLZNZlq08VHvcANPLFOLKz42d4Fze1TjRQppjCRZEssSq6swCNe83RuJSm5v8JOt1OhKsNGZuPgI5pPEfh7VXpuYx3+iZDCx9ad0qgSEyvaX8xwQ+lTuYmIXJ9OJe0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f505d65c-7309-4a2c-836b-08dd96b26c1e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 08:52:01.9430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSrBvlLGCiB2/PYeke9dbJxv5BANjPX6m8nYmDPs6+TGi+AB3yx/ieqpoRdJgGXObD0HkuuingWXXUDX6pduqBPuVhg0vWWeJ60NrtpGRUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505190083
X-Proofpoint-GUID: XoRuabH-Y1GqjyzWTSSsnQyTlBhFMuzJ
X-Authority-Analysis: v=2.4 cv=JJk7s9Kb c=1 sm=1 tr=0 ts=682af135 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=gr9gRmO7I7NIG7Hr9ywA:9
X-Proofpoint-ORIG-GUID: XoRuabH-Y1GqjyzWTSSsnQyTlBhFMuzJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA4NCBTYWx0ZWRfX/Un2SWW0IZo9 wn3gV//ylzEhAiZKuVysOuvSkL9KQ7gOMxOzZaZzICrbM39QIsYQYxKfGNcQM8h4AEyKBbPtyl4 DaeLvzwRowepmWiKQQi/Z+j63QMU+f8cVZ1sUPLFtruBshZZ01XFZy5cyexa/zDGyHZdBZ1v1Ps
 zNx7qMl63axq7j1e6T/R2lwrnOO+uGyKD+6Qwc3Y9fen0gFeNiLsF9d2vQuwV2iAQ7vVJU9HZLu qNovfS/PSFF8L/FDIwzzGdqvfQ6niIhHXikvoMZcY9MKp9onHzCjAKM8EM1PoTNccSpL4sVV1H9 j1imjwBWLjVA64sWZrJekhtJkZlbhlmKt9pENqACRvz3aAO/oKBfVp9m2ee1DiAnMYlMrd2fhAI
 cB5sOqIDy5cWNLrldIAAxNvFNXahgh5o1GpwrvCxNG5p58mLV2UnKJ6iXkne0ZoaUwrN4mEF

Add test to assert that we have now allowed merging of VMAs when KSM
merging-by-default has been set by prctl(PR_SET_MEMORY_MERGE, ...).

We simply perform a trivial mapping of adjacent VMAs expecting a merge,
however prior to recent changes implementing this mode earlier than before,
these merges would not have succeeded.

Assert that we have fixed this!

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/merge.c | 78 ++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
index c76646cdf6e6..2380a5a6a529 100644
--- a/tools/testing/selftests/mm/merge.c
+++ b/tools/testing/selftests/mm/merge.c
@@ -2,10 +2,12 @@
 
 #define _GNU_SOURCE
 #include "../kselftest_harness.h"
+#include <linux/prctl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <sys/mman.h>
+#include <sys/prctl.h>
 #include <sys/wait.h>
 #include "vm_util.h"
 
@@ -31,6 +33,11 @@ FIXTURE_TEARDOWN(merge)
 {
 	ASSERT_EQ(munmap(self->carveout, 12 * self->page_size), 0);
 	ASSERT_EQ(close_procmap(&self->procmap), 0);
+	/*
+	 * Clear unconditionally, as some tests set this. It is no issue if this
+	 * fails (KSM may be disabled for instance).
+	 */
+	prctl(PR_SET_MEMORY_MERGE, 0, 0, 0, 0);
 }
 
 TEST_F(merge, mprotect_unfaulted_left)
@@ -452,4 +459,75 @@ TEST_F(merge, forked_source_vma)
 	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr2 + 5 * page_size);
 }
 
+TEST_F(merge, ksm_merge)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr, *ptr2;
+	int err;
+
+	/*
+	 * Map two R/W immediately adjacent to one another, they should
+	 * trivially merge:
+	 *
+	 * |-----------|-----------|
+	 * |    R/W    |    R/W    |
+	 * |-----------|-----------|
+	 *      ptr         ptr2
+	 */
+
+	ptr = mmap(&carveout[page_size], page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[2 * page_size], page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 2 * page_size);
+
+	/* Unmap the second half of this merged VMA. */
+	ASSERT_EQ(munmap(ptr2, page_size), 0);
+
+	/* OK, now enable global KSM merge. We clear this on test teardown. */
+	err = prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
+	if (err == -1) {
+		int errnum = errno;
+
+		/* Only non-failure case... */
+		ASSERT_EQ(errnum, EINVAL);
+		/* ...but indicates we should skip. */
+		SKIP(return, "KSM memory merging not supported, skipping.");
+	}
+
+	/*
+	 * Now map a VMA adjacent to the existing that was just made
+	 * VM_MERGEABLE, this should merge as well.
+	 */
+	ptr2 = mmap(&carveout[2 * page_size], page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 2 * page_size);
+
+	/* Now this VMA altogether. */
+	ASSERT_EQ(munmap(ptr, 2 * page_size), 0);
+
+	/* Try the same operation as before, asserting this also merges fine. */
+	ptr = mmap(&carveout[page_size], page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr2 = mmap(&carveout[2 * page_size], page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 2 * page_size);
+}
+
 TEST_HARNESS_MAIN
-- 
2.49.0


