Return-Path: <linux-fsdevel+bounces-46467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBD7A89D57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 14:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B3519002B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480CA296D25;
	Tue, 15 Apr 2025 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZrLSMDDw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AFWBRbWF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EE12957C7;
	Tue, 15 Apr 2025 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719298; cv=fail; b=MrfeLP3Aw7kiSfbqzLEMfgLYDcDhAsCm3vv1gG23DNSZ/TZ75JGO24Ad8GpmE8Thbw63qo49AAVxv6xRLaJWoXTpbrP52gSHdQ6hIbgUzvQ/x9BdcMbEE2oiGRLmPAQpY5UlTXPkWS4zue1Mov4GZO0ZlxSb9mm9y3yHXxe9lAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719298; c=relaxed/simple;
	bh=96Eu+VEEpNJdkpq44h41WMUR6c4BaA910XJ75KMdX5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lj/wc+MKsmI7Ql9qT2w++eyEfGdAB8B/Vv7g9VlkHFP2O2RIhTYmLH09tGn5ZAEKFbP+lLw8/fs3N/2+3sE7Tqcf/57yfadlAYc2t7YjAUWEH7rQnPTQR247q94nhEOOroBGwUauv1fi2cu/IZVOEy11ZpRrZvjUPhbRN5XpZJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZrLSMDDw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AFWBRbWF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F6foGr032429;
	Tue, 15 Apr 2025 12:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=d3zAPOwQn3c6nTul65QgxHNFMc2vGRcTpjyC6oDEm9g=; b=
	ZrLSMDDwOc9mRY/5a/O8GKJ7UZKzY9heORNhH+NQO8DgcYlpqsRfQPYYstvgnnYJ
	ZXPO+Hyr0J05ssdyg+HDRL2/LcdlH0zeP/Fhp/MRLBX1gmldYyp0Uu2yf5rWby8d
	3bDGlTQBZskfnz9Z3L5YrXU09KOSZjVWQCzi8y/pLPM2jnHLnON6+UeMpYl3VdkF
	JMlYP6M25FNIn8l28/tajXRadROl/2hFbMrWk2v6F4UjzxhP5Nk3zEeOeSN9CCSq
	b9Af0puAhcY/UIkoaZj7QjNgYxpNkA+hLahi0iJQQkfnCH7SH+P5zpfQTLLDhlVi
	yg+hKkU+qMaIrFTz8/ki9A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4617ju9k2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FB4m7K038808;
	Tue, 15 Apr 2025 12:14:43 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010023.outbound.protection.outlook.com [40.93.12.23])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460d4r76ny-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ks/aGc7YJz9/BSRpb6CQyv9UyUjTbvb+YCdfc8cdCWHjmXAIuJQGCNkcNhjv010QyaArRG4sLlelyoTjym5Y0J4Q6Xc8sSoM4A7gJF8lqy0EhlyzEW+r7d6KycYx8iAthuSoURM0LeiVRFdCJbLnIpARoOsTPTG5Uvc/iVfDGRt7u7V7lrFKDE/ov04OEE8GkdXR/fxf6SWVN/jKXHGHrSkAl3nbvVNqG4BvzjQn7tJGuNJ+R3NwdaNGDSU054VovjFmsJzInOthtnPnt31c/smHxmcw17imVaKMZvrQ5JRpXU/UC+Z1b9eNxahHW5EYf4YYN58qCPV5DaKJU0Sc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3zAPOwQn3c6nTul65QgxHNFMc2vGRcTpjyC6oDEm9g=;
 b=TKIYPOKolRtNqnIHvd1GYgcDZcX4Ryc06EoSTsB8MnrC2tNlvGNeUYan+b54PmhaYHKQWO0jYDKwmetBQhn6kC4WJ6cB4pZ1PlTq/y+Zyw463hOKcE0Cm6x9zGE+rRnpo4Cyrg1sijyoElu4ghaqhZRo39d2jsRJLzk3D52tchm2gm+IQIP5wVLG2CZ/dINnPIrMeyd7STG/xuXTvz67CLH9BI5p9HROpo9R+Qco9cEUWVh7LxVzkqBWXYlmxviDLFQlz3tJLybeKxguw64tKVVswX67blQUapkOOD3yx6ZNMdoj+6Wp4Y4e/dJ3IOKv2WiYbJQSiP34ZCJKrZkVAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3zAPOwQn3c6nTul65QgxHNFMc2vGRcTpjyC6oDEm9g=;
 b=AFWBRbWFk2Lzkz4UDT9Wd0/Y/8Q++1fonehl9gMKAZq+ffkBRQr3PzChNRFnvlCk0GqrtJF87gp9nnFgQHijrL/LlILnuEgPbOOwpZVxuqgXPPBvQrAUSzvJUauuaVQ045pg4KZo7Txoa4weErL8Ep/EOND3LfPu3mSCJG8/xfw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4991.namprd10.prod.outlook.com (2603:10b6:5:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 15 Apr
 2025 12:14:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 12:14:41 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 01/14] fs: add atomic write unit max opt to statx
Date: Tue, 15 Apr 2025 12:14:12 +0000
Message-Id: <20250415121425.4146847-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250415121425.4146847-1-john.g.garry@oracle.com>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:208:32e::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4991:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fbd6347-85f8-48a6-b708-08dd7c171981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q2Dxko5xLPs19AGMr2R12AUufefhqodCl9IecF5Y7NBLiyZ2yuiKQgJg3McZ?=
 =?us-ascii?Q?wjtJrf3tUDCcl7DbzEklWwurL6OGxE0BWF7YFNxeMQCwSwL+K8wvTRZbR55F?=
 =?us-ascii?Q?dMTM39J9KAGWGbyveLU3/zUm/6073LfF/EjMgagaGtHBOOeeGTKmbyKpWnZz?=
 =?us-ascii?Q?mXCaXkTPHVL2S36JnNmc47qLUY/77lQ27DUIi5KUoDFJ21KMAqraCmiMkmm+?=
 =?us-ascii?Q?rgf/IPLIwTUC9PVGSsGpsF+q0aIN7b2cSu/lVHxMRA7II2MrLxsqMiB0aezx?=
 =?us-ascii?Q?F5+LgGPvAfD03IvUyA6Zb56myqZXnYfL8qADwI5eEYE7ECjiNR685GXbFrvK?=
 =?us-ascii?Q?U5SxbV6BLpNHf2zsyBS+g4rTjmHwN4Xh6OY1n86Oc746CbruUZVW7e1LBfKh?=
 =?us-ascii?Q?lFBHbI1Y/xv/TbORacTHkN2EzTngs3uZz99gMyOZ78vb4xv9OOqupST/FaO5?=
 =?us-ascii?Q?NaG4xIWWTIJodgbhiqA2RJmEo+YjRUx2bjPgYxs6u+enyQgpwZAiHLFs6BdZ?=
 =?us-ascii?Q?ueHCuL6cU7d2Nyy7UriPLxnd4d6PKWJlQb/xEQCrHMg1NDx30NVnCmH7HGee?=
 =?us-ascii?Q?gn1trfH3QXq2OUA9Z6pTMoof3+1Hg4ig11zEb2XDa2igiDeKhLK2EKoNAJgB?=
 =?us-ascii?Q?4jhbNsgZgxVBLlRg3/trVdFoDd07lN8Jc3Y2d9t83w8XByNXpl/C/fY7nIHF?=
 =?us-ascii?Q?XR22i4j89k0mQkRAJl7PQP0ZVEbk0uDoHo6vMD6Ep3el1y+T0uIof5P5Gbsu?=
 =?us-ascii?Q?xhkkmQfgCSseunzCuTKZleTW1WvPTAraZDBeou08cxz/cQfYQ1lffYRkPODz?=
 =?us-ascii?Q?KuD1Q5LDZFZyweF1meypO7mhKJ7ul0VckLZx9TwXTQPDpT/DZgWJhMICKdrK?=
 =?us-ascii?Q?a08cra/JMh2trjFVzlt94QwQkclMiX4J3NupeoxZ/JOBa0qfkSl+c0XUOix/?=
 =?us-ascii?Q?dyggt3zA7OWxoNVUR+sCzjiLE+pyd3TGMX4Lyfkb6dNI+G6eb5JbH/NBIAgX?=
 =?us-ascii?Q?jqgJK6H4nvAmUJj6Xy2Q4d1HH3vQ4YZ7go2wbQ1EI4DeT9rnD57CT64EwuzZ?=
 =?us-ascii?Q?JvdB9syquREmyTdNURdmcOUCJeaazDTocDj5Wz1ib2Vradm8BDp2cVZiv572?=
 =?us-ascii?Q?jppcs4kcyJlnDPPcB5whY+V+3nePTYiB0CsNAwSriLvcZxCme/lYIuKN7hyl?=
 =?us-ascii?Q?B4wCac17Y+XhWRmJ2bNHZQCbFv0I3C82eKaqyA2cVemnNN9d+o4UruLkPuMO?=
 =?us-ascii?Q?vU4I+vfuJWl7C3i24GkGb3Sh9oRryZmMxae3AIEF5zmaRggyROcg/ACGpSeA?=
 =?us-ascii?Q?g5HES1XYMJZ2Nhw48CzAg5X+tazLNd9FsCkNO6aD7IJFoXQpMehoVG6RB8L1?=
 =?us-ascii?Q?XxLzIiGcR1/epp08hotUDULVl9dAt0ciRL+fJsze3MliYIX4mtyU5WmOVQPl?=
 =?us-ascii?Q?rIfr3jgddpw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gGPxKKGVTLp56hixKRhnm6kGnGvEU4wrxloCFxucskXxRzDN1RwD6NCro8Ko?=
 =?us-ascii?Q?JsVnh71Q6AvFMGBf2rHdyHs30fkvORbajHq33qdzQRyKSqBy6+YLV4W/8anw?=
 =?us-ascii?Q?Q3smvU5G0E86dJtOUKWQdBCBONcj/kFGCW8OP7VrAOl2kTMiCq69oIyKDYdT?=
 =?us-ascii?Q?CI81q4iaLJ8EOC4dBMlBjJQfI4gn1+9KPFeM9LIMZgP4kgSGJNUu+WCKV64e?=
 =?us-ascii?Q?LdeZiwZ8kNX4tCApexOJZHu3J9ivKD/M9li++I1WVwVyMK7ULrurKSwhqLZn?=
 =?us-ascii?Q?0wgkfNlGj84wiWJhpIHai2FpwWXyVT7MeJabhz253vNTBWHn30tfVu1cSyG7?=
 =?us-ascii?Q?RsNPPZa6w3p94jg3RYTJkbv9hmYGWT2xWGnX25fNix7OpudxY76+PQedbF7y?=
 =?us-ascii?Q?pa3kXBDVNwI8pSorRS02THb3TPO8INQ2pwvWmdoQlL000nSCHaSEHKQY/jAi?=
 =?us-ascii?Q?PA+PJEW2tnbLhxzd39o4nt4P5sL51JE/hID/c37aQy/vfm47q9uIjdPptL72?=
 =?us-ascii?Q?Eqx4txf3Tp1/JdQj6FknPxSwO2JimlOUiFyyPhJs5cwKxHVatHsbSgNPHc8u?=
 =?us-ascii?Q?JFoP469sdIy+LOAhmLbg27bMyWv0cfqf9zCxWZiAWZxexPPQIZvBLK83Gdih?=
 =?us-ascii?Q?CFailvp/0sLIQ94nPLHTaAjmAxKKPUFQbAK1wVpP6/mDWz3fZ78CauFviDzq?=
 =?us-ascii?Q?59J0b5R5OzRSdgc6blic8Cb66c2LmdbQmnPJtAzbEIChNB0u5+8MZlAkI5BO?=
 =?us-ascii?Q?TIACTJaLjv24xb2CXplXpKclFqHdA5RbD8EQEJ5uUpsP8wGbnutl9n8xiSGh?=
 =?us-ascii?Q?fL9LJjKJUoLpzM96kxQCISdl3QDl+4WRItWWlF6w0CPBnJ7Il1FfQ25VbdBc?=
 =?us-ascii?Q?5VfYVdWIsFFbHA8lqV20/SUKm00bXdy9GWDQYWfR4Glmyjf2myxKd9PINI5Y?=
 =?us-ascii?Q?inPm6KP0Utz1hhPWLb/r1/IbqkU/WSe4rdLRqISFI+XLkxbDXUBIsLFhBYqI?=
 =?us-ascii?Q?Bw0hph+dYY4eEpgJ4LtmGykazZXvFOYgHChOyZ62hDfem5P0pRl5DgIqj7yo?=
 =?us-ascii?Q?KXKn75LUtPIIZRN88XhmSivDkCCrzaeis2J+4uEpETOhdzb8POvQbQTDb/Es?=
 =?us-ascii?Q?x0H52GsPTO/DTziOGHQGadNzfKFWIA4MSYVZHUgnmD2Wl0hVXL2/nbRuRnXW?=
 =?us-ascii?Q?LPpJxxeHkCWwHVWFN2vCK2E1zXF7/PQyLtCo0zs3GMry3cyaECsvOWZu9KR3?=
 =?us-ascii?Q?0aLzkL8SuD6t7l4kkwAGObUSBy1HPTiPxv3il6XiOmCl4Ozcm2U2nn0ew3gJ?=
 =?us-ascii?Q?zuNcYI7HcxlVbg5FrKdEFtHTpeaG5fmbd+oivkAqr43+WXGuoadaOyS9PiR6?=
 =?us-ascii?Q?o0G5LRzqudY8PM+SmHCzjCp7IXyL3lEaV4caf1DEYCgoEY7li5MfB+P9b57k?=
 =?us-ascii?Q?ydDsvLBud7HjtLnAdmMmnuvgA1M/L51WLG6wxoAmWT1uCnJECFbcJ6rxLZn0?=
 =?us-ascii?Q?FgiaZSf8DWpU4Sbfea4tabA/EgcaTqui2WZQPmEd6K2DJy7NkJLIPZtJiYH9?=
 =?us-ascii?Q?ToikerdVlFdrgCgQh2O9IkOgQc71vJsdn3WxEjbm9pJu9dio9WmGweUeeE15?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ROwmu383jBwy9rR4OOm+EbuyIYMaFno7o6lKGH7Ko8dAHfU+h54PwzAZv7lTKnAm4RBjYOa2upHXlxw0AArs7DDyqMhG62eaar/95tVN/J6TwB65w7SYsvfDEnxdgf4rjfRLz7+Tmh9Q64FWmctT5/WH//V2a2AU4TOx+S5WZw20cl/YgM2XNA07KTka90KsZNf+BPggou+dpN+jwxUBxK4ncNL0NUznDfzzBvSBZmABayUYq6y11E1ax4T8UWfBZ6eImhwcGa7wyFW1/+xxHZS22L30o8tLoeklaOklAq6QsRy6HqWX5ZmGhZKaIYHDVMxsOFYy+ZM2vCLwDFB6AYQynxKMSrlixXkJscMDipup3l8XvTgGa93X9JpEUgQ76ndz2dtjaO9fEfafD645ExG9TyKLWRSOFPx4PPD/ic3U6e+d1rIj8kbMmXLflwPdUyiIxU4Gwrt8GPIIgu5qcR+AE/IAAScNQtymkGJ7nlvK3i/R61dq31njVZV9uipjOuoh8AY2whPDzqaGsgAYsG9mzbgW6/+k820vu+EhLcR5nj5Oo0gPYhhYIfeZ/pZU5So2i8rD1tPSffM69PtHLfVduovFc8vwv8R/N7hC55w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbd6347-85f8-48a6-b708-08dd7c171981
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:14:41.2401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUefVs5cl9nuoDYIuulvt9NPvWUNFcHCVcFKTKqWtHUxf/U6OLf609rCZxG7JYGA1Pk5j741hqsacjes8+R1cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504150086
X-Proofpoint-GUID: x39Hlyw8sVOGcMsWACdbuFCh7nxBokYC
X-Proofpoint-ORIG-GUID: x39Hlyw8sVOGcMsWACdbuFCh7nxBokYC

XFS will be able to support large atomic writes (atomic write > 1x block)
in future. This will be achieved by using different operating methods,
depending on the size of the write.

Specifically a new method of operation based in FS atomic extent remapping
will be supported in addition to the current HW offload-based method.

The FS method will generally be appreciably slower performing than the
HW-offload method. However the FS method will be typically able to
contribute to achieving a larger atomic write unit max limit.

XFS will support a hybrid mode, where HW offload method will be used when
possible, i.e. HW offload is used when the length of the write is
supported, and for other times FS-based atomic writes will be used.

As such, there is an atomic write length at which the user may experience
appreciably slower performance.

Advertise this limit in a new statx field, stx_atomic_write_unit_max_opt.

When zero, it means that there is no such performance boundary.

Masks STATX{_ATTR}_WRITE_ATOMIC can be used to get this new field. This is
ok for older kernels which don't support this new field, as they would
report 0 in this field (from zeroing in cp_statx()) already. Furthermore
those older kernels don't support large atomic writes - apart from block
fops, but there would be consistent performance there for atomic writes
in range [unit min, unit max].

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bdev.c              | 3 ++-
 fs/ext4/inode.c           | 2 +-
 fs/stat.c                 | 6 +++++-
 fs/xfs/xfs_iops.c         | 2 +-
 include/linux/fs.h        | 3 ++-
 include/linux/stat.h      | 1 +
 include/uapi/linux/stat.h | 8 ++++++--
 7 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 4844d1e27b6f..b4afc1763e8e 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1301,7 +1301,8 @@ void bdev_statx(struct path *path, struct kstat *stat,
 
 		generic_fill_statx_atomic_writes(stat,
 			queue_atomic_write_unit_min_bytes(bd_queue),
-			queue_atomic_write_unit_max_bytes(bd_queue));
+			queue_atomic_write_unit_max_bytes(bd_queue),
+			0);
 	}
 
 	stat->blksize = bdev_io_min(bdev);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 94c7d2d828a6..cdf01e60fa6d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5692,7 +5692,7 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 			awu_max = sbi->s_awu_max;
 		}
 
-		generic_fill_statx_atomic_writes(stat, awu_min, awu_max);
+		generic_fill_statx_atomic_writes(stat, awu_min, awu_max, 0);
 	}
 
 	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
diff --git a/fs/stat.c b/fs/stat.c
index f13308bfdc98..c41855f62d22 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -136,13 +136,15 @@ EXPORT_SYMBOL(generic_fill_statx_attr);
  * @stat:	Where to fill in the attribute flags
  * @unit_min:	Minimum supported atomic write length in bytes
  * @unit_max:	Maximum supported atomic write length in bytes
+ * @unit_max_opt: Optimised maximum supported atomic write length in bytes
  *
  * Fill in the STATX{_ATTR}_WRITE_ATOMIC flags in the kstat structure from
  * atomic write unit_min and unit_max values.
  */
 void generic_fill_statx_atomic_writes(struct kstat *stat,
 				      unsigned int unit_min,
-				      unsigned int unit_max)
+				      unsigned int unit_max,
+				      unsigned int unit_max_opt)
 {
 	/* Confirm that the request type is known */
 	stat->result_mask |= STATX_WRITE_ATOMIC;
@@ -153,6 +155,7 @@ void generic_fill_statx_atomic_writes(struct kstat *stat,
 	if (unit_min) {
 		stat->atomic_write_unit_min = unit_min;
 		stat->atomic_write_unit_max = unit_max;
+		stat->atomic_write_unit_max_opt = unit_max_opt;
 		/* Initially only allow 1x segment */
 		stat->atomic_write_segments_max = 1;
 
@@ -732,6 +735,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
 	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
 	tmp.stx_atomic_write_segments_max = stat->atomic_write_segments_max;
+	tmp.stx_atomic_write_unit_max_opt = stat->atomic_write_unit_max_opt;
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 756bd3ca8e00..f0e5d83195df 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -610,7 +610,7 @@ xfs_report_atomic_write(
 
 	if (xfs_inode_can_atomicwrite(ip))
 		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
-	generic_fill_statx_atomic_writes(stat, unit_min, unit_max);
+	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
 }
 
 STATIC int
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..7b19d8f99aff 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3475,7 +3475,8 @@ void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
 void generic_fill_statx_atomic_writes(struct kstat *stat,
 				      unsigned int unit_min,
-				      unsigned int unit_max);
+				      unsigned int unit_max,
+				      unsigned int unit_max_opt);
 extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
 extern int vfs_getattr(const struct path *, struct kstat *, u32, unsigned int);
 void __inode_add_bytes(struct inode *inode, loff_t bytes);
diff --git a/include/linux/stat.h b/include/linux/stat.h
index be7496a6a0dd..e3d00e7bb26d 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -57,6 +57,7 @@ struct kstat {
 	u32		dio_read_offset_align;
 	u32		atomic_write_unit_min;
 	u32		atomic_write_unit_max;
+	u32		atomic_write_unit_max_opt;
 	u32		atomic_write_segments_max;
 };
 
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index f78ee3670dd5..1686861aae20 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -182,8 +182,12 @@ struct statx {
 	/* File offset alignment for direct I/O reads */
 	__u32	stx_dio_read_offset_align;
 
-	/* 0xb8 */
-	__u64	__spare3[9];	/* Spare space for future expansion */
+	/* Optimised max atomic write unit in bytes */
+	__u32	stx_atomic_write_unit_max_opt;
+	__u32	__spare2[1];
+
+	/* 0xc0 */
+	__u64	__spare3[8];	/* Spare space for future expansion */
 
 	/* 0x100 */
 };
-- 
2.31.1


