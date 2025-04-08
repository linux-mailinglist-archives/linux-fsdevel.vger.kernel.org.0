Return-Path: <linux-fsdevel+bounces-45952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDE8A7FCCE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C263AF1E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45EF268C55;
	Tue,  8 Apr 2025 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CH3nUfyP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jrH0+TLG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22CF266B73;
	Tue,  8 Apr 2025 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108975; cv=fail; b=Jxp67CMu01P5H3oJKIglUm4nYi502MMkr9RBqVLsrmlLCP03K+sNlNX9LxD3z8WEZuioaNkZB79guV28iPUga5J/OzY0VIzo9AdChj0g7e5A0Kp06lifnz9ZDHhivI+gW0xwvLx1L3CFDbQ36QstjaCdxWwYSy0QgQqIzcfdD/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108975; c=relaxed/simple;
	bh=WTXKdoVW+HzlSznAqaJPaOsYk9MdrDGVK3c+oYJ0ZKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XZ2nBuHGYZYa2eI9so0US54xAbZ10KeIkTPwppcw02l9st8CcQLHWDZGlm/uwsiLWuNUd7TjrUWVQKOsWS9q5MCa50CiVRKI5ir4yDi3Kp95yxc1mc0317ouPkNGlQBu6MfyEY693AH14pp262wk0i0GqWLfjB2if8dMKWMawQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CH3nUfyP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jrH0+TLG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5381u74I023244;
	Tue, 8 Apr 2025 10:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=AA1W8cz6KEXhmBCLvInw5J5e8A8DF0WWsK69iqB/foA=; b=
	CH3nUfyPFZSuo+2crFa14EbGmUeYUldBSKXkLvCahVD1oSXTdfBu9RKSwfTEpLj+
	3WFtouEzZxiQh2D8iAmcyZXgMvVDy6PQSruR9uxZiCcVQzr6GiC/5OvhVNvvLsP5
	lGW10xXyIKnc6wKcp7JBL20ChHpISLzV6C8veLQOgE7cuFQk0P4C5p1UyU93Bco1
	jzbenIzbQhe3psBXN8F5FUbiIaC2+QhHDNDoHaixW+A1ipLRJoD7JjZOxcHTWLnI
	GY/V+1LLxmLDSOpxhUI1ByjfsGVTaGmNtud82LV7guZbZ+eVMIqf0klV0+CL3KzJ
	g4UzBxYPb3QVqESNd2H2fA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tvd9vdmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5389JfLK022130;
	Tue, 8 Apr 2025 10:42:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty9tw8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0hGGWGZ/bJYoNLhVoveuXRRzU7+kyd+vceU/MZpf8lznQ6jSppJ5JAbudSMFyL/Zh/PE+FXzt+Bl7UhLedLGEKO5UaevncCQxCqf6LBenqc+j+maHpqb1vu0P1nZjiSFYbuFytwIwxwnCHYvtdYrpQj+Cet/OmenkK0309qk82DdgxgQxPH8OQpAb5FoNB2x3CojK4WdWeC3jzViLumh08UBdwfzVLifS+kKiRr/xV+OF2frscF/8mGy7jKc9ebEyDOO7rRi7r0rZonaYwfpp1m+2W9Ovr3lDw1kWFecytiszmDfyJClyE7Njg2EqKC7RzxWEDTV2Rd15lPTiQcPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AA1W8cz6KEXhmBCLvInw5J5e8A8DF0WWsK69iqB/foA=;
 b=qxGktuqqsb6hHPv41cJa+LES1rnxaQWYbHPgUDEYI9XqQr6GyYsBAKyzXvP17iAhojsX5CLRDasKTwoR4S8z7kZU3i31g7DDJfyGpBV7yE2+wME9sgvsUquvGGsCQeeUJA2IdnzBByav9Y8/RIeTELXx9C5017xRc0fZIxXRb6BqCU5d6LpgaWUaxJp9I7iHo1SKWtHfFz3vN+WW3Cxy/CWBuGy1cvRl1+x80clNAzvvaCEilKoUHi5LrGgd+YD2HJuDO7ib7+DlklnoOcu7fV7+XTdEpWLobRncSyGpBLCQpefMVgwtkmM03rar+00K8IJdQl74xOzivPAofbFtgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AA1W8cz6KEXhmBCLvInw5J5e8A8DF0WWsK69iqB/foA=;
 b=jrH0+TLGaTmvlvdkb8FQIBrb3YmMp3ovOb9xJQfGuk/qWZ2o96fr/uIGxiHtgY6duVTx9iihlkyZ49MBgm9b/wjShfUqYSUEPCdmtDil2procS/g+ckOSwo3bP9NFBMRsZWd39OAhXCVEm3BDzDJXUsPrGzAkEh09tUe2EtDVKI=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Tue, 8 Apr
 2025 10:42:38 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.8606.027; Tue, 8 Apr 2025
 10:42:37 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 03/12] xfs: rename xfs_inode_can_atomicwrite() -> xfs_inode_can_hw_atomicwrite()
Date: Tue,  8 Apr 2025 10:42:00 +0000
Message-Id: <20250408104209.1852036-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250408104209.1852036-1-john.g.garry@oracle.com>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:208:23b::23) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|PH0PR10MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2a6a3f-c482-47e8-8cf3-08dd768a146d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ME9WGKdiIwuSTzXAh4wu5VvqtKLYyQBy1tfjij5dtNymWOsmoP4P8JLzQPzm?=
 =?us-ascii?Q?M2zu/XLmo5bfF/69dWcVTmmPueubX3xbE35YmR6Dc27dDnsa9mhDcBHHvBal?=
 =?us-ascii?Q?IZQLB/eCSW8lAHYzNOTRN4rJSW46buVoxif3e9I/7MxmKnhIMbQ/Yuu1+pmx?=
 =?us-ascii?Q?ISHpqUiV/HjLsSnTh3nobCqnwdBfDzesR3wmiAEldVhixzL0oDq1EmeUyTDv?=
 =?us-ascii?Q?+4a5Zk4Hvfgivj0RegdlY+EpYPADDg0X+Z++GJklSZS5w5CH7L01u7rgaX8g?=
 =?us-ascii?Q?BojYUetMSVpJlgPdEuvv6fZI+0eXy0d4D4LiaeYsfGCCS1illCivxtCP42tA?=
 =?us-ascii?Q?1Cafj55gpDXip+ovKer6u0zXrAYEcQrs3CcE4ajfJ7QJDB0b0YKMlxio5Nej?=
 =?us-ascii?Q?DRRA7d3wzbXbKp2K3eIBEiA51SFvPnWPPdfI8jMYhbhYKFotLR/bH7AjTuvG?=
 =?us-ascii?Q?fPFW8O8UakPJHrK+ew43I4J3Crg0ZCc7m3GD42of7hwUJ4WMw65nsLISi0Nj?=
 =?us-ascii?Q?n+ItE5kZ3a6hoO6Giam0JBAa+S9uLbR6aMVxlI1fsa7QOvgGA+EbpjGYCrMC?=
 =?us-ascii?Q?Af/lF1arQOilQfPy6CoAoTrmzk/ClCh3jg5tULw058jMBOIWBUsnQLzhhPAB?=
 =?us-ascii?Q?YM7wvhHr1vvCiG+aGmsBfs/9bJbUVhOEEUoptBAlcDx1Ry3ohBXnDGQjdQUj?=
 =?us-ascii?Q?dedycEshg4Sysza6jO98QqpnMwKXM+Lgf/dk+zJ07v8Dtj8N5D71yRHtPOXB?=
 =?us-ascii?Q?cvZiNRn5EdCbzg/SSjWMmdza5O7tb+UKMoRYZ9giicI2xS4vMD3NU8V1mYfD?=
 =?us-ascii?Q?T3RgADbNl01ggR1oofUF43a+COCJ6Hm/rkrw0e8rlMcIL0FSgRDuKLaQAkU1?=
 =?us-ascii?Q?wA/HKphJkw32mZ8NiY8zJPuYJHZLLySlr9tsA2FkDYP7w++A0gFxztJyacsS?=
 =?us-ascii?Q?jtYAG5zEC27BUWzPHX6rNyq6CehVYpLY4E6Ch1cV/kUvABka9D2XWbHUWvWJ?=
 =?us-ascii?Q?Q8otFlc6s5gyJyLGUMVtwOcxsenMkfSZNTGM3ghEDeiLVa0/9S3rP6ioaQq+?=
 =?us-ascii?Q?oRJRWA16Bi0uUxsmhwKrtY2CeTyKMfHJIVSk0tXF632visRQJxNvVufuVrwT?=
 =?us-ascii?Q?Axd9qaE5ZUyyjWsD7p2FTrFrg0L1V1u2T3iQvGBZuV5dlPk6cg878R4AYdlS?=
 =?us-ascii?Q?PikSO+Sm/Kf2IZWWkVtLIiNHNEb2EnS9bPpGhmPgQUIQGcTngfYB2Iaz9cqw?=
 =?us-ascii?Q?S+K1PxovF9XgE1Q6/2H8mKUoUYJH6iBOdaCv1/uyzKqjlAQ9n+jydeki0L5c?=
 =?us-ascii?Q?t3qW/QCloyrscp9eES4u15lvQnnqGVHcg9XfutcJoamot8GH+hWQa5/LbyHx?=
 =?us-ascii?Q?Ebz/Jb3+3aj2lIrCYKA6DB6HRdHM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q3VGAtEbybgYmF0dkOwAkpITePKdQorsbKhJHwi1cDUOgNfKEqBH1JSx6+vB?=
 =?us-ascii?Q?irhQcNCK67khcFlfAo540Xe+xv8tKUPRtkq4pV5boOKWv+/vVfJv10zMuKxc?=
 =?us-ascii?Q?rzx4lu56ZhCS0/yb9DvSbhgD8TVDOV9rwihEaJGbc7gFvih/IZU76olcpXON?=
 =?us-ascii?Q?cJDxBylSLYROtEPKawcAZJgxo6MfUvA/Nd/WbyqXYzSvugHTbBdda2oIc6f5?=
 =?us-ascii?Q?ljUAUWA9UrLY/dnag72ycyOe9kDLgaDvjzVJM8Up/+3QNmgehPTJJjloOqP5?=
 =?us-ascii?Q?SRWPxzC9AUCEiCtV2uaI6UETLxAJ05wBY0T50cZx8YcuACfmShjZregLT0AN?=
 =?us-ascii?Q?wHm++6oMFdnLQFdecVUM5L1t64S7RRsOqJfJbSdVlqSoF2KYkGLcrCvA/ojc?=
 =?us-ascii?Q?N8g8D8gLjetsex2utCgAM7S1OhQV0Bg1uxvnmUmzC1K1LYnhcXva93N4ucLm?=
 =?us-ascii?Q?GUC1zemT+Fc0oDgygK/S6YAjs0c92jnFmaf+r6l+u52XxofKCc/wyJPYJ8Zx?=
 =?us-ascii?Q?/AM5FqAUS5carcApthnAiZ+j3MtV8SCcfUGtuaWg9LO/MLX0KmzmHpsyOb9F?=
 =?us-ascii?Q?GIxyWfbaixfoh0o6lP+8/99FpjEo+rndU/jsdoKiLYRUDYeUX81F1TiBLN/D?=
 =?us-ascii?Q?uNUEoEwE5p3uqkvU+QEsUgqAmwfxD/Jai3ZUfy+xZQaHH4BeJVBfOLoDdJhD?=
 =?us-ascii?Q?8MT/RUSiB/AKzU8OE9EJ3uYT+bxICXp8oHIiL4xKZ0kmJHcH0Z8nk3+xmKqh?=
 =?us-ascii?Q?OLFa7iizfgIGRik7rdzICIBB6f9QzzUJ6ydawbzfnngKfjvcXY8XEoPdQUo4?=
 =?us-ascii?Q?ZQ08COSwd6poMFZ0HSiEx6zziHz7fXEQeL3qCg0b7bv8oajM2RGp6uUrTQcY?=
 =?us-ascii?Q?noPRjHeSV7IYBhgYeuvlKV1xeFbC1pyCS5vLjuXR0XrLnQa51leCB5OqqRVG?=
 =?us-ascii?Q?SdsLg6UMJs2ssyUDYG3A/RDutuwZ1OjTu0Rnv8nBRXgov/wM6UtAe/hZfBfU?=
 =?us-ascii?Q?sA5VDSeidubKTX3cffcHkM18UfqPuKueq89A6SJqzXKneiZCIV5EuQFS+xrh?=
 =?us-ascii?Q?xo1WeaZKuz5BnFRoAjVvk6ve0ros/Uj7ukBugO6WIkQgiitOEqFriN9aV+Ai?=
 =?us-ascii?Q?uEIv60yS6IAGrxkzrKm8ML7Z6LsQfCbZp0axHcxL4yw/rlRNTlzzFKn+XYbE?=
 =?us-ascii?Q?wjn7GNggquobMwhRqZ8bHxwRKppxntEMhR0AVekh24nj5zedizDpt0ed6Jmo?=
 =?us-ascii?Q?p6mSpPnAOyLyGMdz6Wn9JJUjN7Po3d3iNSlRNRYoHFLWB/po7Tl4yXeSnPF9?=
 =?us-ascii?Q?Y7jczZsGUkPNF37bL6qLLjP775qg4dZSA/CxEZkkP/3Qxn0ZzyJNHph5R/S1?=
 =?us-ascii?Q?/bQN837OipY6Adm3CW4ShUHW8eQh1Ke42+hNYzKb/A6vMJ7W3Ss6GMCMxmIy?=
 =?us-ascii?Q?zWrZOVzal+PNyqilSycpDbmwmHy6p8P4qnO3aizVDyLnkYTg8Z7IQLsEiI+F?=
 =?us-ascii?Q?UsSCup0D/IGe0iN8XWV9+Rk3aJ+iokLgEjyqOjC0OnDhTbZXDJWB5eCYf9IJ?=
 =?us-ascii?Q?eLnzH1pxK1rNX/izLPOrPFs+OwUDPd5hVndrLgs3l+JTZHay1LrWz2mIFNSg?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aQEUUQg8vbr2gaD+q6cLVulfxD7aogji6lDWJxzSx+m8zzPbYYHntAAhhbArqX5D47bFSfdLUfPAiDyVFG8tNXrrNo/wYHBdGgAywHhCA+ZjbuUr71QXb4QBMUc0iqxjIrCoSg+PAiMK+Y/9n+i5AUG85ucP7GwuoUuWpHE5z+7hgZaU5PeP8pNe6jmYRBpzleVBO5WiVfYypZzD5a8Bn/q45wAMDK7LaFUifNM7ZAs2M+0mu4ocJVfVl3qxXTe8utdbqh96aLCa7PlwmOtUzY0HSJiJsvVRg4GM9q5Xh+aqVtxXYupKKhrUWOUfgHWX+8tjAZBtpK1PkH4uQASdnVhDZrqSwQO3polrPaTU5l0txskih1EQlX5y3YerxgypytU1/v5OqS3eRV62yRqBuD9MAcW+Ab1AT1iEIOyfCvupRu0RmlGRB24u194KsKSc0BrvaVdT8Xaa8Q9UMnVQQOYuMu6ar7iIuDeNdpP2DOshlYAybhbOU2zA1UtI3jZcaJ8+S53sc/uuRttfsBavxdAVoTs0Qtuhd53e3jYxr09jBeY3sakasCmdUQ4gh1PhdWM+owJCacHqyU6Ti3UTm2nn5dcNFzB12oWZ1KfQcmk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2a6a3f-c482-47e8-8cf3-08dd768a146d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 10:42:37.9180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCQNKPaHAILB0LPh/VHzdLsCP//MD7/WKP1b0F13f3OBJEsawwTbevKSAgRVHnbFzgHg6CJbPndE39Pg1r1mHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504080076
X-Proofpoint-ORIG-GUID: oDzf_dLV7zlKUZvF_dzytoYk_S3OkOGE
X-Proofpoint-GUID: oDzf_dLV7zlKUZvF_dzytoYk_S3OkOGE

In future we will want to be able to check if specifically HW offload-based
atomic writes are possible, so rename xfs_inode_can_atomicwrite() ->
xfs_inode_can_hw_atomicwrite().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c  | 2 +-
 fs/xfs/xfs_inode.h | 2 +-
 fs/xfs/xfs_iops.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 84f08c976ac4..653e42ccc0c3 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1488,7 +1488,7 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
-	if (xfs_inode_can_atomicwrite(XFS_I(inode)))
+	if (xfs_inode_can_hw_atomicwrite(XFS_I(inode)))
 		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index eae0159983ca..cff643cd03fc 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -357,7 +357,7 @@ static inline bool xfs_inode_has_bigrtalloc(const struct xfs_inode *ip)
 		(ip)->i_mount->m_rtdev_targp : (ip)->i_mount->m_ddev_targp)
 
 static inline bool
-xfs_inode_can_atomicwrite(
+xfs_inode_can_hw_atomicwrite(
 	struct xfs_inode	*ip)
 {
 	struct xfs_mount	*mp = ip->i_mount;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index f0e5d83195df..d324044a2225 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -608,7 +608,7 @@ xfs_report_atomic_write(
 {
 	unsigned int		unit_min = 0, unit_max = 0;
 
-	if (xfs_inode_can_atomicwrite(ip))
+	if (xfs_inode_can_hw_atomicwrite(ip))
 		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
 	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
 }
-- 
2.31.1


