Return-Path: <linux-fsdevel+bounces-20662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 998C88D66EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 18:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058B31F2248E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C3F17C7B4;
	Fri, 31 May 2024 16:33:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27920161B4D;
	Fri, 31 May 2024 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173216; cv=fail; b=NIX2Fkid39F71dVyNc1K9FL0O0EgJ0T7WcrRS08IGwjTAwJ155D1q92wBzsFy9csHOPS5drTZdNj9lNqWC2juMS8zd8+q+kZgbWwLYXB47gqV/Pm1n+na62uyeivhbmzp1u2divLQa92PGbRo4yvxMy5YTYhlNY7lM7DCeNeRng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173216; c=relaxed/simple;
	bh=rm6/bFIL6p1MHxYBTQ/ROrm717XpKX2PmgkMitR2IYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XqTZPkngwEeqMRSdm6CS/kXPj0tcHIweD9b1XbkluMnvqTpYpamlnBH0Z6ErfwXtop1R8OLfxOIUyr61e/xdGfG59nK+a0htuhgjwBIGBlP/BgzvyFIkM9RTtYnxZVCi0dE1oizV67QRBzijS0g4WNIK95YVvMHBMTabHOzU0Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44V9T2EM019194;
	Fri, 31 May 2024 16:33:19 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D4FXhuH3znV7KCQLXqKilTUAjWsm/phpAGBkoe5rd4bo=3D;_b?=
 =?UTF-8?Q?=3DbmhSaa1b7KHlFQcbcbpCD/0eUX9stddVrHHC+F4G1HxkBDurMCAD8JroyHts?=
 =?UTF-8?Q?1irSEId5_7OZwhVB/Mlwx8KaaMqE7Qg4WpVQQkGT6SBixcyr5AFRv76hbQk8Jms?=
 =?UTF-8?Q?J1zFKK4Tz1wNkd_ajpfJJqlQsb8rP7VTjXJ5dRGeaUw5fPfWTfnv1Ak2PhWy8Nl?=
 =?UTF-8?Q?bmRHtXHfU48338Yo/3Nz_/sZcZv2nRQ4VTH89NlyMVcZHOaOAYU/qQg51IX3SwD?=
 =?UTF-8?Q?Ju98Ha5KY2cxsyBIRwd9sCljOE_Msdi5q7WA7XlYSKJSxNW4fxTwleHr22TAbgu?=
 =?UTF-8?Q?FKE9093ffFCg6NAj30Z/GIQ2hoDraOdd_sg=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8fckk7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 16:33:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44VFaLYY006199;
	Fri, 31 May 2024 16:33:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yd7c8kmkf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 16:33:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUdkZP/Of3YJrHRueIbiKTU0A4K4MFBb30WH3yzwb5o3nQdo4a3xVfkvvrgb2l3DOtrxtq9cqZEtBh6Pou/f93wvRIW0k+Tmw6DQc96NlJc6dsLrxjDRLor6g/lnFR2IwQz3wIOvuoS+jD9jta/es32Dog6Bh3xLCjZn9gTi/HcxlyiCpo/veSAc8ZPqVli6xzYoupmibW6QPJmVmTBvA/lW0foqLBBgqy5eDR8JHomolu2R4sGCqb5ixp6wP0dbi1lwvI5j6P43Bcv+FXxw5HKCzCuqGj9WzxSjD1PbuhU+bfM9d4vQ1exREKYDF/9z1Qu6ULgPJCb9D0XLnfRDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FXhuH3znV7KCQLXqKilTUAjWsm/phpAGBkoe5rd4bo=;
 b=UtpEqIYwmgvuH7BsfAw4rCbsMkOImVJBhe+2S8gQ+P3nH19xReIYGpVepgYkQwoWyj8gbBamWoeCEfWH7FGa7CKLZhh+gT6WApqA+sBITATXdqqtXML6fTwvd0YCUQsQY9WineP69lwhjYTSpXDW2cf03Pqk7o+2PJ9Ma+l2Qgit1jIpnwSTl4S5Q+LC7qEeK/lSw4/BWOaIX1tmv6Fk43S62b2Uc3i691cQ1Lr6j0O5cz7YJ6KEsmlwuwa/wXuh2xa+mMQB6hSuwUkSdtBrxk0uXHg+1jEkgNLFgWXv4A8NUtsDfEHXWOqEKAY0GjgtQQqfImBJ8SVkzMlFo9SvvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FXhuH3znV7KCQLXqKilTUAjWsm/phpAGBkoe5rd4bo=;
 b=yQemrvhqkCvhAxLoGKnlN+xsOyXHnxJ8mE58v/Pwy/QbUD13PGEMPSBWC/h4qSQPuR2PrqAqfEpbFY7JZi8q0U3vLhhAbHSVNoPGETOxt2OotI4isPfWt/iIxy/rnKcYdVya/De1B6j1RQevdXMD5n9C0eKMs//Qb4hYOWaLOT0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB6318.namprd10.prod.outlook.com (2603:10b6:806:251::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 16:32:46 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 16:32:46 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com,
        Matthew Wilcox <willy@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/5] mm/mmap: Split do_vmi_align_munmap() into a gather and complete operation
Date: Fri, 31 May 2024 12:32:14 -0400
Message-ID: <20240531163217.1584450-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531163217.1584450-1-Liam.Howlett@oracle.com>
References: <20240531163217.1584450-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0082.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::21) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: efe14402-7f27-471b-ed3b-08dc818f4dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XMuHApLxl3QAI/5/yy5cUGp18ToelNpi9Zm/Fuj+U1EmnzFZjiZpOQ7AbfiS?=
 =?us-ascii?Q?hEEZG4UabSwvdyzCp0KyYVOnV5GBGusZJ+IKdiBiq9iYu+EInZoXhM26uWD/?=
 =?us-ascii?Q?mApuMgpO3h6yig3FvnpB2WUEULM++ian6BmkQ4DnLGaTAEjRQXP84GTHQqtc?=
 =?us-ascii?Q?AEcZEBzSU+J3YiBymnl6CkrT63Zc3ciQKKUhO39DWc6lDBk4TKfECr6H8om+?=
 =?us-ascii?Q?qfLmpYQqceeC+Pm5BKqTWK4tFdEdGdH7PLp1jqbbuVNUCdku+HXpWdfGYKLA?=
 =?us-ascii?Q?5W8caV2ZMiNFx+vH9wajITF1UAH+FUaxlG1RAwuaEJXDeyilz8M0pGqxOfGR?=
 =?us-ascii?Q?0MBUllcnon/oybUJYTfC7JFGAP32niCGjHsK9kDN2t0fTj1KnR00s8e9EssV?=
 =?us-ascii?Q?+hgPEgIoyzjHXYhI67ufbwyIQsNIpBWNo428EjV30Cx5TGoTsscVwBtqFk+x?=
 =?us-ascii?Q?jPZo8OYEscKhR85LdNVrC0Z/eXFq2tb2K2mjEDDo86PLZBSJPIwn9juFzG5T?=
 =?us-ascii?Q?e9Mwqsnmx6GHqIh+X0OC3wA0nue0FreEO9jA55G+Wgb5/T2kcQct07xN7ynK?=
 =?us-ascii?Q?ZWdrbHyJxo73QEjmtX8zjeyN3Ng4kkiX2CnoSOffSi4OV10QUlEbSSVU0TDj?=
 =?us-ascii?Q?osDDKuTP6y9fwewEnVah1pmlLbnS6kowqWKU0nzK4BbCeWLpSn0tbIiBRiha?=
 =?us-ascii?Q?HR1R/YSwGFuqrw4jYci+4zZ/qCA5ypI72yNrh7BxNG6ewvOzioPac/CRRIfU?=
 =?us-ascii?Q?WVgyh9YD0R7hE5mkcMC8lz4zjAricOQzep2FT9h5gMcgvO8quIoXIBU6YoVu?=
 =?us-ascii?Q?bw3YPREkh2A9hV/V4Nug5GZquH1NzhqoLX/xREESYvdbDZlyf8FCS6McqioM?=
 =?us-ascii?Q?8romyl57ZDcEzDJ9Peooljz/uP7rfncGYLoRxTSaYHbcYakRPZ7KHn87sRBc?=
 =?us-ascii?Q?3f42xOe+sHbjy2VUYDMeoMfnCrVMWNDPdiIUIPCIjYdvy3bWc7bEFxWWJyBO?=
 =?us-ascii?Q?8dFwBevvMOEvJFCCSq/FtY/GFSdcUphm4TVnVO07uUVI5MKnQ78gbvFSxKIP?=
 =?us-ascii?Q?I9cUSYcJl3fR0AmRK1dXCKU00YxTSaUiK+RH9NiSwHOH1knkaLvXoWSaT6u/?=
 =?us-ascii?Q?+F6ZIYvVRwwACsXzneNzLUPUxiiB/wbD/tJz/lXgbF39YGvOF0MsQqXR1ljb?=
 =?us-ascii?Q?8B94ovqLnLUHa/641mdMyxtxdPzTnp+b/62bBxrAe65lKhEgYdB5ZErp+DsH?=
 =?us-ascii?Q?Q20JbRdag+EioOqho4VWUNaHY5MfgcVYK1dKGVHF/g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?R1Lhe4WQRxri8XnNvL0aUgRoywxjSMc5smfh80jbeOvVl/iVJgUjTSLAeqTV?=
 =?us-ascii?Q?f8VwredilUTfbONHlF1i7Q/LRC2Mrpvl4TLfuKQNK+knB7ESk0COpBeFxkW7?=
 =?us-ascii?Q?Me1imFcCCQAbyfa8w/QrNG33mKGIeuvzQe4cKuLM0TWWOR+H6+6OdezbJs2E?=
 =?us-ascii?Q?JWze8+stfdgWocu9Q66M2COiWhqzlRqUiQgf3MOG1lC3u02w7M6xK4zn1aaw?=
 =?us-ascii?Q?g6iaXZBpsNX7vJjXOahXnPZpwxTse9roNpLXvk4StFbXnSC1/wPBAjja1eCJ?=
 =?us-ascii?Q?3aIWd6R6BhXtwphQRs9wAHA5s3gLFq9kz1Z7sSaV22qfr/60bfD8talGdwQu?=
 =?us-ascii?Q?8PMBKxu76ox21OvxqzHVsurUap+6fLM7eVapMSnbATPNpt83JfzNn5ZbqeJo?=
 =?us-ascii?Q?3I2kpBR03k13ytlsklRatk/Y6i5CXLuuCBAdAeWXhUiUcKLDdzbr4l+Pnnq8?=
 =?us-ascii?Q?j+LGe1XXtBqCu2Db1xnsW2Z5SoUTHlzQZqWk95Hre6j31+mA6TkPuLn5WhD/?=
 =?us-ascii?Q?9rwACwXkMoiXrXXhbpHKKGssSTUBmG8XmBVwntTV1HPHDu4VGVLLmENqQyId?=
 =?us-ascii?Q?IYKEJp/m/N9HpVXiyx9W95hvGf80+K3II5pWXEQxctlBbJS7M+FAhE7k4Toy?=
 =?us-ascii?Q?se8ANGkCFAiaygHkHtrDbHtmyp9xOa2F5gRA69ruX6Bj1Edhmx/EsuH92kl8?=
 =?us-ascii?Q?3OPUFSdCly31G878OL9Hmkzv9m9RWyAJa+reLCuLHHGQz2rFQONu8RjuXh03?=
 =?us-ascii?Q?26NCFksLmYlwtVZb4HKiS+/gJwdVuojv5yjaq4mgadg5jZVe3cHIfmRgGMPK?=
 =?us-ascii?Q?IcaE1n6wd5AstFazviH8XNJPX7WAmQOoRo14bGruyOnk8wakB0Lefe+3hNz8?=
 =?us-ascii?Q?HK+hvrMQE8Z/aw/ecmX1bR79bXmjlTCuv1KYZaV8+ttp8KGQlNABXnY0yJuI?=
 =?us-ascii?Q?loaCmwvCZ8Rf5dgc08nK8dhQh2zNvOAyrVEYd4BFApp/mAqfcgwPW59adxbO?=
 =?us-ascii?Q?5XkFn58F5VrSYfS5BC5QDwOR7mFJwsOG8x/SVEUCvVp6JZBatQSiKIb8gke7?=
 =?us-ascii?Q?U+3ZMEZQ9jE9xvyeTJA6GYuQZB6lnMj90jqDU7hnNLhu+L/HvZXeqKR0IDrF?=
 =?us-ascii?Q?fcv9ScaqhI7clNnwAiXSJM2PooGekoqqgZQcGiM+NF9r6aT0zHBrwrBTqbhn?=
 =?us-ascii?Q?N/Rd2WrgHNLhslGtY8phUV0paSEur7zM+glatmLzcllYBc3KoIIrMwn51Ty2?=
 =?us-ascii?Q?bzv1DsqKrdt5jpUfzzG/wW2mo2/csT3+B1sWTKMP1Mo4AtGXzJ5sXATfAezB?=
 =?us-ascii?Q?GdewNzmput1uKHMBRwgwQ4Rw9GogY2S4FnFz/Ad0SReR4UeFl7EmryZoTjEV?=
 =?us-ascii?Q?tyKb1ppp0bh61wLO1G7/QA/Uo0z3y1ACdOWXgyap772/PP3dFj5Dgdrjdk8i?=
 =?us-ascii?Q?8YeZcgwHcpxU4UrC0cD+Fn3s3NqrXw4TbA4bUnP854zCgQkj4kjYM/yn8rFH?=
 =?us-ascii?Q?CCCj56lB9rmvH8VO/2Yv3czCIKkHqkHnJI9FFnoyxGmld3bZHHCAKsJME9YB?=
 =?us-ascii?Q?14XmkCHrVEiqFsrBkFaOjZb4q44sf4319UVfEn7A?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	t4BWhhr6ZsDxooWz6kcB6GvzGQOy17EkG1Vp33TKmUqcqBE0HsNMq9U+fGJgDlDIA2Kt6oMk+8+ih1seZB+ThJdT+D+NMM27CyNUaAaTcOsp2xlxW7kU2BfhrlZGMI7tVp2N/C/dwGk2nbAYVv8iMuMLp4sQmLH0riKfXKKpLShlHs+Ss7EmDHJ0csOf0C+FyVQtkargZSzNtHEZNgtKKK8N2C6R7tPygoAPLpXSV+lEkr+lgSFMx4/XfisgO3fEs7ccIbGRPEQyQz6kHB0gTaCHRRthgLkYFnI76Xas+zY9QsFrKJqO7lqR8T/vZNiTe9K5Jge0I5SmDnJPySOXZLKjFFKeL2FW+/LfLuRQhSJyvZb9tLHhw1hUt53MOMoBDiXTMohPw9+/Smyftga6HS4wABOTg3hNzAESv1JnM1I+sqhA3ESjmTre+EqggqKIns73v6Sd3jCPbfOF23JSNSyV2QRuVj8EZrMD3x+8dwMsF8udwRr9dxaIlQV8glHFhf4FtzOmW8yqouSax+SYdGfPYVzebmIBzGJ9uFANF6uykc/2E0a3R4bN88Cbud2gBcUcPvh5hTXkbf8mmSQH7jChfch4mqPNChBHEBIyRTE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe14402-7f27-471b-ed3b-08dc818f4dee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:32:46.8486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62O5WHhUf8tKBX6aHjI7xvi7rCdIzdX37yVgRwJiLORMsefJiV+h6zxz9JqOatvf4rPDO8LmCcX5hu9zzAZrgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310125
X-Proofpoint-GUID: jtQTfN2JonQERTfMAMf_FtcFY6I-HA3J
X-Proofpoint-ORIG-GUID: jtQTfN2JonQERTfMAMf_FtcFY6I-HA3J

Split the munmap function into a gathering of vmas and a cleanup of the
gathered vmas.  This is necessary for the later patches in the series.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 143 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 101 insertions(+), 42 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 31d464e6a656..fad40d604c64 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2340,6 +2340,7 @@ static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
 
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += nrpages;
+
 		vm_stat_account(mm, vma->vm_flags, -nrpages);
 		remove_vma(vma, false);
 	}
@@ -2545,33 +2546,45 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 }
 
+
+static inline void abort_munmap_vmas(struct ma_state *mas_detach)
+{
+	struct vm_area_struct *vma;
+	int limit;
+
+	limit = mas_detach->index;
+	mas_set(mas_detach, 0);
+	/* Re-attach any detached VMAs */
+	mas_for_each(mas_detach, vma, limit)
+		vma_mark_detached(vma, false);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 /*
- * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
+ * for removal at a later date.  Handles splitting first and last if necessary
+ * and marking the vmas as isolated.
+ *
  * @vmi: The vma iterator
  * @vma: The starting vm_area_struct
  * @mm: The mm_struct
  * @start: The aligned start address to munmap.
  * @end: The aligned end address to munmap.
  * @uf: The userfaultfd list_head
- * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
- * success.
+ * @mas_detach: The maple state tracking the detached tree
  *
- * Return: 0 on success and drops the lock if so directed, error and leaves the
- * lock held otherwise.
+ * Return: 0 on success
  */
 static int
-do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
-		    unsigned long end, struct list_head *uf, bool unlock)
+		    unsigned long end, struct list_head *uf,
+		    struct ma_state *mas_detach, unsigned long *locked_vm)
 {
-	struct vm_area_struct *prev, *next = NULL;
-	struct maple_tree mt_detach;
-	int count = 0;
+	struct vm_area_struct *next = NULL;
 	int error = -ENOMEM;
-	unsigned long locked_vm = 0;
-	MA_STATE(mas_detach, &mt_detach, 0, 0);
-	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
-	mt_on_stack(mt_detach);
+	int count = 0;
 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -2610,15 +2623,14 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 				goto end_split_failed;
 		}
 		vma_start_write(next);
-		mas_set(&mas_detach, count);
-		error = mas_store_gfp(&mas_detach, next, GFP_KERNEL);
+		mas_set(mas_detach, count++);
+		if (next->vm_flags & VM_LOCKED)
+			*locked_vm += vma_pages(next);
+
+		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
 			goto munmap_gather_failed;
 		vma_mark_detached(next, true);
-		if (next->vm_flags & VM_LOCKED)
-			locked_vm += vma_pages(next);
-
-		count++;
 		if (unlikely(uf)) {
 			/*
 			 * If userfaultfd_unmap_prep returns an error the vmas
@@ -2643,7 +2655,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
 	{
-		MA_STATE(test, &mt_detach, 0, 0);
+		MA_STATE(test, mas_detach->tree, 0, 0);
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
@@ -2663,13 +2675,29 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	while (vma_iter_addr(vmi) > start)
 		vma_iter_prev_range(vmi);
 
-	error = vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
-	if (error)
-		goto clear_tree_failed;
+	return 0;
 
-	/* Point of no return */
-	mm->locked_vm -= locked_vm;
+userfaultfd_error:
+munmap_gather_failed:
+end_split_failed:
+	abort_munmap_vmas(mas_detach);
+start_split_failed:
+map_count_exceeded:
+	return error;
+}
+
+static void
+vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		struct mm_struct *mm, unsigned long start,
+		unsigned long end, bool unlock, struct ma_state *mas_detach,
+		unsigned long locked_vm)
+{
+	struct vm_area_struct *prev, *next;
+	int count;
+
+	count = mas_detach->index + 1;
 	mm->map_count -= count;
+	mm->locked_vm -= locked_vm;
 	if (unlock)
 		mmap_write_downgrade(mm);
 
@@ -2682,30 +2710,61 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
-	mas_set(&mas_detach, 1);
-	unmap_region(mm, &mas_detach, vma, prev, next, start, end, count,
+	mas_set(mas_detach, 1);
+	unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
 		     !unlock);
 	/* Statistics and freeing VMAs */
-	mas_set(&mas_detach, 0);
-	remove_mt(mm, &mas_detach);
+	mas_set(mas_detach, 0);
+	remove_mt(mm, mas_detach);
 	validate_mm(mm);
 	if (unlock)
 		mmap_read_unlock(mm);
 
-	__mt_destroy(&mt_detach);
-	return 0;
+	__mt_destroy(mas_detach->tree);
+}
 
-clear_tree_failed:
-userfaultfd_error:
-munmap_gather_failed:
-end_split_failed:
-	mas_set(&mas_detach, 0);
-	mas_for_each(&mas_detach, next, end)
-		vma_mark_detached(next, false);
+/*
+ * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * @vmi: The vma iterator
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
+ * success.
+ *
+ * Return: 0 on success and drops the lock if so directed, error and leaves the
+ * lock held otherwise.
+ */
+static int
+do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool unlock)
+{
+	struct maple_tree mt_detach;
+	MA_STATE(mas_detach, &mt_detach, 0, 0);
+	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+	mt_on_stack(mt_detach);
+	int error;
+	unsigned long locked_vm = 0;
 
-	__mt_destroy(&mt_detach);
-start_split_failed:
-map_count_exceeded:
+	error = vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
+				       &mas_detach, &locked_vm);
+	if (error)
+		goto gather_failed;
+
+	error = vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
+	if (error)
+		goto clear_area_failed;
+
+	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
+				 locked_vm);
+	return 0;
+
+clear_area_failed:
+	abort_munmap_vmas(&mas_detach);
+gather_failed:
 	validate_mm(mm);
 	return error;
 }
-- 
2.43.0


