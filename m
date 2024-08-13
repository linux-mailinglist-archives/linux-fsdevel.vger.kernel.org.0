Return-Path: <linux-fsdevel+bounces-25809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D13C8950A7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 18:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515C61F243E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 16:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6C01A3BD0;
	Tue, 13 Aug 2024 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W577+x4E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BVHxBHCk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56E41A38FD;
	Tue, 13 Aug 2024 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567133; cv=fail; b=IHz8TxkP+ZZMYjAaWuPyvGtof6zXRti25UAVwokJ0GsahDc58tlkz1Uh6bT3Y+TDVrgiGdMuop3JKIIbSxV347ii+7YJpr12/p0jwMLpnXsnmUJnM0LwkojmtSXh9ZIvdlyb+6UcpfmOxlfJYMav1dVaoplAHTvBibMh2kAe5WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567133; c=relaxed/simple;
	bh=tLAT+7yTG0erOfjc01XunsibZlefS4hD+rb8ihxgoHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rBl9CG0U9G3YKTEjQUEHAH0UdkJfepM5b2ptWyvHMiMoYPdk0t31JU3XwJTdG0FMamoXQ8ouLbDi9Mfsf72CoLLbffA82sPD8L62Vsx9gL5tMKqTZriuWBd9AOqiwoqB/XyZgylxOAfUReFkIMZTQDmZgK1b7msz0MvP+hNQ0sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W577+x4E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BVHxBHCk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DGBTwN009743;
	Tue, 13 Aug 2024 16:37:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=s8OBHluIYSrq2MWT02Gr+cDMi9351QGcXWOLsWmMmeI=; b=
	W577+x4ENQRj41r2jdKqEjbJtxutCuptMODy5P1zPomYOPcE0DUCVxesN9vYnNA6
	9z+xB7cSwxUYl3oUvKTiDBYwMogBjknHxR/UvfOpjMa/WI70Dx9qURnXYyYqd+W4
	r5hJwACw65tkBGJl/pr7wstsPzeIgwKgxZvXYAkhA1y/0GDMaBDmBNTyXHm06/Fu
	ohyBJe91dTSKZ5Wfh/LpbUgo9tIm2SwSJ02YcSVjm27vJW7RzswnAcrpizuXOnIi
	Rea9vYF5pXP86YtSa5blvacgCNQeajd4xmSKM28aloqRRof5pZ9nyx1SDI165nYM
	yw9RA9DtCpWu7MoAMzhSDg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy02xg3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:37:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DGH99J001485;
	Tue, 13 Aug 2024 16:37:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn8qkvm-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:37:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZy7l4NAxI9ZmfDCxlxQ4ZPH5/ZfKsB3WF31Fa6TiDTagB7Nw7Z2Al3/xkHjd3S15ciwNfnxkX+BOooDJg0pxKClCHN0+XnytKv8sHlciO8yLr3ZCu3ORgcpYBEps8eUUdMsAby9WyPgShRVTTcuBHQXvmAWMLzBv1D+om5bYnTU9VE95Q8YVT/yOnN+5W19yUuH9XznfOLH6xb7Nk6C3pKC3LVgu4a4fpIHusHhEgQAOkQGHOD5iBeWGs9KN+Qzfi9bRJ50bcOoOz3D5OM7p37aQNa+3CMKEGmh6mhYSjHjrW1Db5+2xx1I1t7W/HVcxYi2ESnVS8CTwu/oiaeehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8OBHluIYSrq2MWT02Gr+cDMi9351QGcXWOLsWmMmeI=;
 b=fXj3YgLKQg9CT0POC4pp/Be7KOFrreg7oPIzUcVIvrI29PSnxZPfabO6AnPjTmzmgNvQQLrw3ybzSmuyLzAOOBaa34tyr4XiiY2VrujIR32fnv11f5fiJgnlyK0v8k6VQJRqMe+cKXrhTdrzY3g3yv/zHJm00fJnyjtHM99sFlYz4uxZ5ngh2GXP9SqX1+4Q/1LKtGeCaFIFlDwNN2ySGbSKkMTqD9xxaQnZgSq9vC9qGSIDwAlpWWS5cfLiQOD/rmItIYbTy0RoU3PoUVdER5jIkF1YBCSgODm6OE4sr8uI6FYvOg1401MGraFs5pax3WObd7S0L56DqZRu3eKUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8OBHluIYSrq2MWT02Gr+cDMi9351QGcXWOLsWmMmeI=;
 b=BVHxBHCks4Scgp4KT1VB4TaKqv7nE0E7YnZaVD/OxfW6nir4QHUIKnknyDaMRNngc7eykq5pDktxdjf8qg+cwdibyU5KWIh+zdQpwgEJBDku8jM3nOElWHBjRhtUT9/FkbTB60SAU2Kwp4O2vyJp1iQh4Uf4Qtab6dgFFTxHy0c=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5747.namprd10.prod.outlook.com (2603:10b6:510:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Tue, 13 Aug
 2024 16:37:34 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7875.015; Tue, 13 Aug 2024
 16:37:34 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 14/14] xfs: Enable file data forcealign feature
Date: Tue, 13 Aug 2024 16:36:38 +0000
Message-Id: <20240813163638.3751939-15-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240813163638.3751939-1-john.g.garry@oracle.com>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0373.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b36d086-d1e1-43b9-b254-08dcbbb63bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g4dwm1O6q5y9x2qokgqJRPGkbrxHxyFzi1YNlUDhwiwZ4zGJci1N4JHHXCtx?=
 =?us-ascii?Q?tp8JqeKhaaE0SKCPtx3jhuGYi7Ew3+O5YwVfF3LKjb6Tr+Xm4bYiam+OEvmF?=
 =?us-ascii?Q?ARZRjpq1AYNhQyhO9yIgSkaeLIJrGRaCeOUpPRsqbK8XbN7nYFP55Xznn7EM?=
 =?us-ascii?Q?sR1tlE7wvZjZO29EGDLxqdiN/LOZ9yyFAWCbbweJ1TMJdbZvZYr3gX7uRGaK?=
 =?us-ascii?Q?i4lMqQ6YqlwdaXZOYTJSbOkfKEkXrif3DGcpRW/ITDwZKN2rCkucAzzRpCpR?=
 =?us-ascii?Q?4EXj5OxCRcjKUpT7KKrGXr2R9R6Xohpa9+9N+S6crhnKXjU6YVFEk0z48ulk?=
 =?us-ascii?Q?coy0dIdNm/Kmp1Kyh691VzNqcl5Jbz6Ymy8QsWE4mZ1t7Gw2iF7YkuwfY9b8?=
 =?us-ascii?Q?ezL5ENZL/3IF68Iw/eya+Q4mjoG9AJFNfolOZ/WWnc6nPpla0jAQpq9Ikxcm?=
 =?us-ascii?Q?K/D8JETEjRzObY6/HkkSkTD315axixsjJaF2iLaZ6apzWxmtZ2EGMv5Tedan?=
 =?us-ascii?Q?IAAm8rHt+QE4gDn2Xnm7KRGK3l/Tx+tNTV12bkHyxGE8GK5WnB5gu+EcfRv4?=
 =?us-ascii?Q?PvY++Hk6TtXq39Rw8Gm19b51EAgJ99sI0aNd+xw5d8sDtHEgZQCSStnzXbsJ?=
 =?us-ascii?Q?KeEU6OklFVqDK/9x316eS/n7TmKkv91sm7Ksjjh2GR9jQeIxp2t1je8LP42C?=
 =?us-ascii?Q?6tLZr3aR5ibL5ntdYU0K1g6sR8+1Pw7aaJ/vxefBmA0XYFJNeCfFoZkeN6R3?=
 =?us-ascii?Q?QvkIs0i7j7sc5v42DT1hFBmKU9E26gqOqLojan+4YZkUhu7gg7PHXdZgEKro?=
 =?us-ascii?Q?E+oxKfnlmf9x7uFHUVvfGipJe+V3Yzwjq4rxBz4tcvLKCNBWS5vGCKsdU0To?=
 =?us-ascii?Q?opMYCNmvZcy9GAqsPZfWWjEpmyg2vP4+XmvBaZ0is5PWWMusZVyZc3S1PAQN?=
 =?us-ascii?Q?AwIaexi8A0ghl8X69XxE/+mAwL/5B4Yu9AFUIY0EcemFQ9HtqGIA8CpR5dc4?=
 =?us-ascii?Q?cDKyIWnnSuV7KtvvNjQzr4M/gWS9bonFLCoRWQAHq6ltCdlPFDOcDh9GNyMV?=
 =?us-ascii?Q?9MBbXLvsgEoXefpwX+VitLILpRAqYWDPVAndiqC2JeNSXPSb5vCftbpt1FSv?=
 =?us-ascii?Q?uK3MUQ4ui1ZoLZ9EcMpx4mEXJEtuxna19ZdixuAlwoeS5UICawWGNeKKdOP4?=
 =?us-ascii?Q?5IuBKqVRBuWOx7jw+HVCEQPH8Mv/TbiKDiBJoBhufWXHnWcV08Ish73Tp8ex?=
 =?us-ascii?Q?9bk1V4fcDl75Pc7qmSI/P6jHSVagLEKi1QrGWgY6xdq2C/+y9yWUCRY2gJUt?=
 =?us-ascii?Q?YQSFYkGPP5sE97wmdCzGW7vTws5dAJNUjlNRCszwMOskdQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mCpuBjw2DCQ6eIxZgcrXUv6umxvpvd+DRp5RmL0P4beh5IqpFhI7xEf/iicn?=
 =?us-ascii?Q?V8T7jhEMVakeuWhVuwDFFCF67S3OTodFjgEKde0z0fU4x2jOtBmEo8DxyRox?=
 =?us-ascii?Q?cEuMzOtzW6qfNwBvfDyOsvirY1e9ihOS8TYoKkyeImyv+CFLdAobz7IOmRbu?=
 =?us-ascii?Q?l6eBjdW/oL5eYzJ44cgH9tBli1eNmWGgLnevWyUYHrJ0qteY1OvhNmwJ0X8Y?=
 =?us-ascii?Q?a38Yve882OAD6ss9T89HkiE2DzG12RXMY1BzzY3mL1UX970Do6B1RjrNeX+L?=
 =?us-ascii?Q?v8IjCp8vCy0ZWRZM4o7tOctYxu31HJSnceLOl78q0Pm3v2klFZfBNUGiDuuy?=
 =?us-ascii?Q?gwJ3Xf7rNQSBT3H7UD9RCFFqFqjjdAV6kAkIjNv4A7Xus3VbUtpf7ka8ZiAU?=
 =?us-ascii?Q?fq+FPtz0Td7VKQBV9XhT7Lphq15F5g9EnScH0N9YNp/O/wUQSLkrYrTDS0Jt?=
 =?us-ascii?Q?xuGVdvFsha1MY/w1BU/zY3Nffli1Bmj7rvyMOxx5Y/Tkk4kz4CoRCFW8vpMU?=
 =?us-ascii?Q?plSMBVdpKfHrE3ZJYbd0E0FeN30etn8v95fHsBTfGoS02Z0EVJU3JBqlwvba?=
 =?us-ascii?Q?bnFSxgelj+0/m1/We8G/9N0t0A7oBedva4l37ZpT8TP1GpafQ/kRJSzELFAH?=
 =?us-ascii?Q?qnWZ/TIhSYrh2VNvElNKNKKYYIKGCqaKfknhhmN0aIdn2C9oLDQjtoanlJe0?=
 =?us-ascii?Q?bz2gPvURMrMwyvV82tpgH7q9M5zaGEIoVO4q8zN4uVeFUPBsVUJGRg2M/Mqn?=
 =?us-ascii?Q?n5m4S41vdZPH8Zu8vVBMTfsJCuUyMruOa5Ez/y44D+On9lkEdySbGbU7s0IW?=
 =?us-ascii?Q?CdrWquGi/cTlIF6X99GWyAB17CkEQnHV0nEVs543gjY5Zn8u+ll8pFuG3g/P?=
 =?us-ascii?Q?3HF7hu2OHW/r4LVAiSYhGox8UM9RMPx1pnR+Ta+dyFcleV7xIIJSuodYhq4+?=
 =?us-ascii?Q?WDIfKFqcCgfp0T3l/ma0LqEohVfNUyDyLcg0Wk99ShYOnEdmB2WT9YkzWMFx?=
 =?us-ascii?Q?0kQGyXNn6o+YSGlnKzZvzfVntwktmd4L5BbOpkMGuPzKlV6paTetxamssur5?=
 =?us-ascii?Q?zP5AAiRQQzoEwAd25iY4BWLD/cU8M5hV7b2tfCCwhWYPD2z2qb8n6apFaGdk?=
 =?us-ascii?Q?LlLmZAGi01ILQ8Jhh7REJeso4/BBX6pLD5yV2TEodVe4YnmgvClFDudI63j7?=
 =?us-ascii?Q?K3PAFFsxyhfhoDxsCL5P4fsIXT7FGhU8cF+ayyZ4NGmtCH81L1ftrCk65VNi?=
 =?us-ascii?Q?y9sfSktT3Jet/MLwCbCPs7mtgW9l58cJKa4Vu8wYU1T4mK7s4ScmEoxS8lS0?=
 =?us-ascii?Q?mCLDV+fu0klliOm1h8aNkY2FAqsM84zHTKcWjG/GnQLnyAbozzlbJeoAlAaK?=
 =?us-ascii?Q?HdYBsQD858tncXU/RDyh55k+IsEn1PKKSPoL76s1UYHpBKSZF/FGri4U6C/W?=
 =?us-ascii?Q?0FT3RJ+GaSHES5315TuX9FzHEzufY6j1kNwGaenlSxeytYlkOQOtvT0mfIMq?=
 =?us-ascii?Q?6vWbvhGx4YcA7mYqiRGfXHcAiB44RGgYf5jHxnjKtrkb12RAoC5Rw76ZuA1L?=
 =?us-ascii?Q?5JniFAHPrNhSkUNW0DxAwmLt1ffZfA3GClWmZQN1rS7g2HCPib9tl6GD4dv4?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	usvVC83fNdD7F7SzZaMbxwzGI3D2yDVUv6KlwQXibBQV43E7M5L3i57fkxz6tLuRsgNtZnmg3mKxuxblKx2GIsaTpRe5rhY5IO8f6clfntiwZKmWpSyn2W3vnN9vKSVuqH+B4TJ1QmEoy2O+THonCVAQrOit4DrxuHG3lZRVlv03csIHV2xAT3pc+cqkQfht0UQLNaTUhKmS/VQX3UWPyyuXia1LYgBOQp8IVCTYGjGQ5/ygRgDYvQbzDD1xRzaelj0L/I/gcCxRWVi2sBv4Ilbf0KShL+1I3da/6xbP4fRJlBhQmgpJd3drbLsrrjLMTdXIQ4QYxmXQQZJSmo1eQprEwQZp+tFhUmPrnMML7h8jMCLLt2BAGnapUCMv7taKYcRMnibl9DErAae8pf+hfeYzAWXMxhChWtSUleOHk0uwOVJmG6WEcbPZEuZUGTK2w1Um2OFIHtlxjaYB1snzuIrNjgWBqPc4yuw7CfiIN1qRs3Wy/KPBzYwjZ6tOSaA+xalhcXR9CZ0Y7JyeRm3tAesIvxb7LEv3LHIojJ44oS/u4cPcvxknmuBh8yRE3ANFC6AHJPgkO6j6p++tKspKp4dLF6UR+XjcNZ10Ix+4jSE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b36d086-d1e1-43b9-b254-08dcbbb63bb1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 16:37:34.0462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /z2ZF1l06MuTRONgKe2cf8S+S44nL3UO4RtrLeiWABXhmcVNkqMmt+WfY3sUuovf/i3coDd49k+lT8ddglsV1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408130120
X-Proofpoint-GUID: PiOif-9E6dVPNAJmuxrXuG-SvtlKm0Nl
X-Proofpoint-ORIG-GUID: PiOif-9E6dVPNAJmuxrXuG-SvtlKm0Nl

From: "Darrick J. Wong" <djwong@kernel.org>

Enable this feature.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 95f5259c4255..04c6cbc943c2 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -357,7 +357,8 @@ xfs_sb_has_compat_feature(
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
 		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
-		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
+		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
+		 XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
 #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
 static inline bool
 xfs_sb_has_ro_compat_feature(
-- 
2.31.1


