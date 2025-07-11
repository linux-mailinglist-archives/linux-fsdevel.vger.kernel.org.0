Return-Path: <linux-fsdevel+bounces-54620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0BCB01AAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08AC87B0A4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFB028C03A;
	Fri, 11 Jul 2025 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="si5O/3Jc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bt8PJ1Hu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC76146585;
	Fri, 11 Jul 2025 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752233954; cv=fail; b=O4FaVq4LcAOre5kunm8NDsaEFj5VnroWuqB1ImxeAEpYOz638VU/pNF9LiCiUM/hwppUZPZEYhscZTN6vKJH5HX1jXcITLQrOKiWc6C3w7nyDmUAhjqXS8cJdZ8diVGzIuh2aIo41MSJoUMXd+tyGwduUHpI/2+mdB/lN6ocX/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752233954; c=relaxed/simple;
	bh=BPW/sItHid4F/G+59k3ddS+KMjbTTHH4D3yHUwAn9+c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=f5tImdPi+lXk2Vp9kP0EikYGCZof4Xdr0WViWuIdkWnAp73WZSubAsVbX/gcZtZMKKfMW+qIN8RMR73tOIUkq8WL3mWaxgWI9RY5xLz39E+LrKVGMPqeyuwgBqKi7hLAqbukOq8aOs9I00sTaaMXTd7JiZbmlg83NAr40gup0KU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=si5O/3Jc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bt8PJ1Hu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAvPOF006524;
	Fri, 11 Jul 2025 11:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=lKWiF5Q8/FuqdKIq
	SIWVFMj+NTw5fIhvg10KgAonIo8=; b=si5O/3JcJN9mWr06HubfhxeCUp4sy4dl
	0uEsLfVvnsGr6hkUjvXJY7i6n4/jgq5e9T1+wR5fCMZt9bUEYhOiWyoJDhx4aP9g
	x4xsQnqOMXROzGElivVw5k3RBOEtBTqJtZGILFWYIe35exSwLQlg030zZvYBqpA+
	CRo56YuxifdxKeDQy/Pgu1ojksJdQNHWJigMyMwiqCwkzQyeVXc5hUR6mJlHAgh9
	wgKmK2tACGerbv6rmLKRWsolPjbu5HePAPpJG8ZgIqlVmOXF50711T5i3oUh/jOM
	9JH/GD5BDyVyFvy9TjGDPu35rUjoj+rY7fPv86370KzM0zbILV/Dfw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u1abg1pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56B9VEPv040420;
	Fri, 11 Jul 2025 11:38:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdpjtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPal+yDrdTFSveU8IapYO3YijOG0kiOZZLJvIz0bC6IRnKT03WDmHdoH9T36i+Bc3Ygk56obiMQ5cgYLFKb1T3WUn60wcep1EgYKdPLfJ0MMZMOKN64HMqNrNsfswaTfIg1Ik7mJdmCMONGsBC9Il13FVQ7FgwZvagLrmNKDwj0Funsf51W/5EO4vEi2lJQGrtUw5S4bnZm39O94BpAmjXf065UQdNzNbC11fPt/3pDCydjlwPej/LMEX7Xw0YXcNzom2Y8O5nGzSl7mlHriPpqP8E81OqFVmDsRacqFwN2GZUxmwuzloFQxpPwQEvr4IQrrOU/yCakN/sXFhcxwaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKWiF5Q8/FuqdKIqSIWVFMj+NTw5fIhvg10KgAonIo8=;
 b=Lv436OFnI48D9AAdTtyk381Oaa78NINc80oNIwXgWFsJFokloWTsdNlwJ/98f11qf9UOni8yn7NGuhED24NTN3DTvVUTV16bhl3gjvhx1xY4Fq23CVTV20OoIwqtcrrJIJtp65fSz8kimylRHVk1DZ/kA16od1BQQOt/w3zkA7GbfffpdRalDwj3/sVT+liN2tDdCEG4TjZL5q9nR0NHexg8jvwRRnMYEJkKJi9tcfx88iOFyuoXI7YbOKAjPCCz52qC+n9QU2mtDoPw5aQsnUofgEI/WUhKmPhZw4QN1Yzxbr7K3MU296XW1bRakfg0kYOucSKIEPK6/hS2nYfNvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKWiF5Q8/FuqdKIqSIWVFMj+NTw5fIhvg10KgAonIo8=;
 b=bt8PJ1HuMBqUTXFjSHG7jgNlYBoXSWfL4ghDL7Oq4rsU00q8A7IU68gTT28iAsQVFgMjgA/tt5dngFzeJwq6z2F1R+uo4TtB+bdyzT6DgmgCiorQX66gNN1d58sa18VHnTRM5IkA+W6fmVHEhRy9y6rG4gL4FaVGBGUPv7qt1/8=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BN0PR10MB5174.namprd10.prod.outlook.com (2603:10b6:408:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 11:38:32 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 11:38:32 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 00/10] mm/mremap: permit mremap() move of multiple VMAs
Date: Fri, 11 Jul 2025 12:38:14 +0100
Message-ID: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0343.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::6) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BN0PR10MB5174:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa08ff9-c059-4307-e598-08ddc06f76b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ebthIlzvX44RvZdjzXdexoqPpkHiLs/9Zp37ooyXA+PD9fqjijXd3SlyIV3J?=
 =?us-ascii?Q?+G62cOu/IBaaaGfmhlhDtrO1AiAt/oJsIPH8l9GnFYqaV/pz0DdtGCqRElWY?=
 =?us-ascii?Q?5udi1RajA62TaQCbqSxPZFPHMxbQFX4y7V2J3uFmOV/330lcJSDkOyRt8C/K?=
 =?us-ascii?Q?RmoBHtetIFaVSBiVDJ7u+fGMxCTbAYdbcQB83MhFu1kLGTasH3AzL5Vi0Grk?=
 =?us-ascii?Q?eN47QQwSq3a1Dl+DXh3MqeG2DXMVLDcK9ennpFc5ZOru8lj94nXM76zRP4uV?=
 =?us-ascii?Q?N4j+MXhf4x1F/o2H3JZwfJk8UVd7S3yvvOXDMeLpFtOzVNv9+Q6NDSjXD/G3?=
 =?us-ascii?Q?rPgH7F81V/Scq72b5Rns7Rf8KR7Ly3Fz4YEY8uM1/SlSS5+GlhmCQR4UWr8m?=
 =?us-ascii?Q?mnSXsn1K2lsHlx7pqcM4wSCp+Zp+oAaVnlXMqR3gC3pmZlGwk3b4SzFnY/Hs?=
 =?us-ascii?Q?DdMmalz/JVrnHYWzyQ4dPmhObInmtVCcPZBy29BXwt34J4Me7/T9mYWdybmu?=
 =?us-ascii?Q?zbeqOwDYA0nieftIK6cuYOkTmoX8IwnIVYIRLMN5NC5On/J4IubHPhbXj+2q?=
 =?us-ascii?Q?AvZe/y1CRCsTqCKtMUptYPr7ei423h7gTsAcn7yFL98HxFiUEbbT5Hkn/SbG?=
 =?us-ascii?Q?sd5p+I3D86qbrQYJ3wa2qJ7Po3ChZHZJrEnyMmfYOZHnHH1zzpvA2epISUPb?=
 =?us-ascii?Q?MoeLo91UMASOfC1oeEMwkCUlg7zWa9OB7EjHz/borBnhIZWZP9awDsFpeBsn?=
 =?us-ascii?Q?cZjGktSx8N2ZDJzOYhKLBeqO/nNsvrQn1MH6B/3cP6f1lwLwxEjJun0jF2cX?=
 =?us-ascii?Q?cFajpKVSXU7yUPN1EVG+Cx89/XPr2RNiVx8lebUTX2qKJgGfE49/7xevibeQ?=
 =?us-ascii?Q?zOqyyv7oQAMpIeGhpZ+lFDxPJNJY7Mj3aD+TnGcN55XZvQMSm8iwZc6sJDrX?=
 =?us-ascii?Q?OgRBXqEWlIBgV1HYCqWBXmO3aD1i2l4MQUfC3AQ0pFcfkFCg2hsSw7Jz0TTg?=
 =?us-ascii?Q?m0FWHxpokgW7b4kdrtwKMolrIuRPiRBPmZYHs4xpupwQpogow0fO+QvPisYk?=
 =?us-ascii?Q?Y4T9PeyD2rlkwkmYTcxMluzMcu10lQCu6FUoqxl78L8ug8sc0+v1SRWMM1Hf?=
 =?us-ascii?Q?ZTGqO/38a41MnbDdPabPx2zL08iUIiS27l4ppZQ4raITVyETUgLxAy5If9sP?=
 =?us-ascii?Q?OTk80vPgBF2S4Z8eQgHhkAWbI0MPcK9c36l5724z86+Z+u66UKcd1bpVkAnJ?=
 =?us-ascii?Q?ya9qbZ7lIFBlSEKdxXTb5xsStI+jbfk3Dw4UIEQwgwBeoPZmEz58KwdgCTpl?=
 =?us-ascii?Q?WziAoZbkDKxwwkmbBMJDmDSkAmOslzUoQBg/ID6Xr54gfWpE3LxE1NtepVDG?=
 =?us-ascii?Q?SvlY0exBtiBK1x/z62QFRi+vyiN/FxPFSycZxoqdjaOqT663fqu60D+15Gd0?=
 =?us-ascii?Q?F/Le8owN6A4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k4S5EvXXBx6JLogSBq/lpVpNhr4raxir0TumIecT+dYjdxTMWXA/AZhfKcLt?=
 =?us-ascii?Q?o8ExTInCv8MBUtANZbG98wCYQkjqfBKsRaJpIj1yilXwo/zLNaYGoEfJZ/XD?=
 =?us-ascii?Q?yqNHc4QlyRBtLK83w+R2IC1vmBcjdJMzC8FtCKFP1q+dhtZDP4oNLbjAnewG?=
 =?us-ascii?Q?5cH6mXm5bQk/mp18ApOHLD2t16lKLNgZxcLecWnfotZjfTVIDTf08hCNM1//?=
 =?us-ascii?Q?/98A1FT2oUhlWv49RkEH4hfW8nnXd1/YeW4720zPRZq4tR9gk933yEeiUQrb?=
 =?us-ascii?Q?G2ugHW9XA6GXBm/Fih2M45FvOUv0OfXDIvzomdomkgI1M8G5ZV534nIqTHYw?=
 =?us-ascii?Q?RF6uD3h2ylpKGt56+hkdV59DQqMkuEjpTSL37pYQiSsqySr4O0C/8/HlyD3e?=
 =?us-ascii?Q?jGB6wPjlmIY5/R2UQIJ88sIbWLeL2WXFqcakh5F47vjz5sCESkSYbxGiaY68?=
 =?us-ascii?Q?ppNlZDA4o7ZN/XJqDss6vfBec3bID9ppR+SDS0+I9zABIqUvrlQLMBPQa5Jp?=
 =?us-ascii?Q?5im+P9zlXZ6nFQ7YiH2QTZdvasIMDC9yzAH0u3JO21GUYFK2Jag59w6oTQBP?=
 =?us-ascii?Q?OERWXVpxUArh0W5uJAADRbK5PNgRB/PPgtHygytbYKbyd/qDsBKEJ/rYjBBL?=
 =?us-ascii?Q?3GZwHuQo0938P0oxrTMPnRh8DC0MaeGs8kHlZdrDyLzSl3ithR1a63RXUJMJ?=
 =?us-ascii?Q?Ec7tXmtZoIv1awuZU4KviZsBWij16lRMdqZDbWxi4m/S3hpIRvW2SM569yg5?=
 =?us-ascii?Q?K1vW2T1Hiw/qNnM84yTa8hTaDo5nNjkE85OW5aSHokA0M2Roum7wM9XKSiZP?=
 =?us-ascii?Q?7QWsVjMzIq9wBi0fVbT2ZQQIyHpr7vUtbod5wK5dNG5QylXINq7MD0zozP3S?=
 =?us-ascii?Q?HglLAoxNl2l0FhO7FypTOy+MmXH0UOComO1NdoeD2eEZxR21MXKFrKkYxY96?=
 =?us-ascii?Q?2LPzyqTyT5uPHK3TAS557RmWMXDwzhlXA3S/plJxGfJQttEoV6oftC0aCCL1?=
 =?us-ascii?Q?QiKNGUO1GWEM4y8zWYrOZzrW2XQLh85anu9qQKnOjvO5wPlwuOdxcjpVCkm2?=
 =?us-ascii?Q?/ddtMmsTGUi2C1Aj8fJ+Bdx7QmIa4HyA1uo+4YnPL3LIqZgW4GH75oPyup93?=
 =?us-ascii?Q?xzo1KDAv3gVJBQ7fOLR/BW4ALrVY7obGk6fS58zfNjgcMScP6E/XrqgfEPCP?=
 =?us-ascii?Q?znLVb184epfSLCYC1vGullvUWwZ4oLeZQvf9o6CkebJcZfTf2cfUDyriCb7P?=
 =?us-ascii?Q?4eQnhN3sPTAXLTRpg0Q6DbEeI7qUsHkLR2DiIkC8yLjkmJF1aVcYpteHLYzA?=
 =?us-ascii?Q?ovz9K5PpRMJ02DXrCmYblldVupf+lyZIBqfkaIyQoKpw7hVuXWl90v6qgm0k?=
 =?us-ascii?Q?bQN/2MZ1Mqn3ra++3verPVTlS4X6gcgFU+lMM9tM0hOGrQuxDG9qxUj3L8hu?=
 =?us-ascii?Q?sKvsFY5o+f8jgjj5M01m7rdEgrjLa+CQUfQLQoWkOFJS0yy8gBJO9+5Z4eIb?=
 =?us-ascii?Q?9MozMLvG/0HzmfuPZI7up8/99Be8Jxq1I/8D2U6DKa6/KjLijlHQ72avPDvE?=
 =?us-ascii?Q?Dr6FxGDD3YdS4YbJNZED89lNpI9ycBZmtKKMnrbDHlgDm/eH9UYN+nk+qu67?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3bfpLD1Mf6uxhCTDFY3PFvL2JRMq6Nawc1PPmfFMkgz3+fZtGfDYwKX//HVWa4iVj27ozxlVNQaoVYtzGeFpWtSsmMom/ooBpYe7HPnmVsxwJIBxxwCb2XcZ6zHkAUBHFg7vlKUHJ87uBkqoFyEHQPTp0LejpUu91sflq713m+o7yqo+zgQrMz37JTGrRrM+lloAlcAG2JsvIznIn3xlz74jbZ+h6QM9+eHRoXuIBjCkt6B5nrqHH397a5ak2a7/lNW3R/FGmdgjDVOgqwwKNGEjItUpoH6hb+f54E7keWFy2zhTk+PuPK1Fb0qBGYyivOsZGWCZeQBl8QPTbEoHg9r4wuR3Uw8yovRqpsnk+dMExPHZDRmsBJ7BKufVLvF8kXGSURnlJkuLQtofrzZzyBamIo4zz1K9FDL8ENPiYVoZOxjWDDZYvucCH6w+7qB8252srv9J74Xdu2CBdyX77So3ugp9lsjy4OkHThc4508cxmyOGAIO1XiIR1INYfAd8FP6N+/ftW+HyOfr46RH4Qc5kHO2zukUXlU6kRc6B+V3w4Wr6tX58dzu+IUFVLKcsCgGcjnDYzw70qMiNiEMifE4nbpd3DzFvG0y8LM0r0A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa08ff9-c059-4307-e598-08ddc06f76b0
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 11:38:32.2274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbBhUw+tMy9FysoLMeR6t73DJDPuZ/LU8FDHsl26pyhSXaBm46QA0+l/XRUmpCTCNSnZtzjprhjIO7ahb059ej6eS6Q4vDlDVSsg/ecv6yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110082
X-Proofpoint-GUID: V2X0kgWPOhROpQ1-fWoXvEXX-pkgHGAr
X-Authority-Analysis: v=2.4 cv=JoHxrN4C c=1 sm=1 tr=0 ts=6870f7bc cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=cHio3vxFbJXGOxi3Ld4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4MiBTYWx0ZWRfX0CYb1is1YGPY xAmUFxqLzUSd2GU1pvZCy+FNYKhpAJlXqIWbD4EhFsiu5tx9lhR6v/lzyZl87vyfXjP/jRjkWyq 91Rz7bvVM7T+iIT6x98kqQs0iJnB0eJ9DfEWcS9KVY8ydIYWWRTZc59qB7orHyqzwDlmcBwlNld
 kvZJpY72d0TRA4s3JoJllT0OLIMwCrFL5VrJKCUm23Ncx7oS1uUW6m9wVLstxnTAo0ShM6KOgdN 5CXCoX/72TsK93VR4yCTmxUktJCR3pVVzWH4wyB2W8ZltMn8e6JuwTPA2gbTGQpvWPo2hxG99UZ 1X5o1d55XMp6i7YPdqYKjnjNUL06eazyirN6kitCayeVMyYo+CulUoOIgWU7CLaxFlEJOMy3RX5
 g8nNCWqS3Ny4bCPcntn7T1jAJGwKDWmtnzBjtmwHoNQtVysFadZgiHb4zFzp+wKjYrmZ6Ohq
X-Proofpoint-ORIG-GUID: V2X0kgWPOhROpQ1-fWoXvEXX-pkgHGAr

Historically we've made it a uAPI requirement that mremap() may only
operate on a single VMA at a time.

For instances where VMAs need to be resized, this makes sense, as it
becomes very difficult to determine what a user actually wants should they
indicate a desire to expand or shrink the size of multiple VMAs (truncate?
Adjust sizes individually? Some other strategy?).

However, in instances where a user is moving VMAs, it is restrictive to
disallow this.

This is especially the case when anonymous mapping remap may or may not be
mergeable depending on whether VMAs have or have not been faulted due to
anon_vma assignment and folio index alignment with vma->vm_pgoff.

Often this can result in surprising impact where a moved region is faulted,
then moved back and a user fails to observe a merge from otherwise
compatible, adjacent VMAs.

This change allows such cases to work without the user having to be
cognizant of whether a prior mremap() move or other VMA operations has
resulted in VMA fragmentation.

In order to do this, this series performs a large amount of refactoring,
most pertinently - grouping sanity checks together, separately those that
check input parameters and those relating to VMAs.

we also simplify the post-mmap lock drop processing for uffd and mlock()'d
VMAs.

With this done, we can then fairly straightforwardly implement this
functionality.

This works exclusively for mremap() invocations which specify
MREMAP_FIXED. It is not compatible with VMAs which use userfaultfd, as the
notification of the userland fault handler would require us to drop the
mmap lock.

It is also not compatible with file-backed mappings with customised
get_unmapped_area() handlers as these may not honour MREMAP_FIXED.

The input and output addresses ranges must not overlap. We carefully
account for moves which would result in VMA iterator invalidation.

While there can be gaps between VMAs in the input range, there can be no
gap before the first VMA in the range.


v3:
* Disallowed move operation except for MREMAP_FIXED.
* Disallow gap at start of aggregate range to avoid confusion.
* Disallow any file-baked VMAs with custom get_unmapped_area.
* Renamed multi_vma to seen_vma to be clearer. Stop reusing new_addr, use
  separate target_addr var to track next target address.
* Check if first VMA fails multi VMA check, if so we'll allow one VMA but
  not multiple.
* Updated the commit message for patch 9 to be clearer about gap behaviour.
* Removed accidentally included debug goto statement in test (doh!). Test
  was and is passing regardless.
* Unmap target range in test, previously we ended up moving additional VMAs
  unintentionally. This still all passed :) but was not what was intended.
* Removed self-merge check - there is absolutely no way this can happen
  across multiple VMAs, as there is no means of moving VMAs such that a VMA
  merges with itself.

v2:
* Squashed uffd stub fix into series.
* Propagated tags, thanks!
* Fixed param naming in patch 4 as per Vlastimil.
* Renamed vma_reset to vmi_needs_reset + dropped reset on unmap as per
  Liam.
* Correctly return -EFAULT if no VMAs in input range.
* Account for get_unmapped_area() disregarding MAP_FIXED and returning an
  altered address.
* Added additional explanatatory comment to the remap_move() function.
https://lore.kernel.org/all/cover.1751865330.git.lorenzo.stoakes@oracle.com/

v1:
https://lore.kernel.org/all/cover.1751865330.git.lorenzo.stoakes@oracle.com/


Lorenzo Stoakes (10):
  mm/mremap: perform some simple cleanups
  mm/mremap: refactor initial parameter sanity checks
  mm/mremap: put VMA check and prep logic into helper function
  mm/mremap: cleanup post-processing stage of mremap
  mm/mremap: use an explicit uffd failure path for mremap
  mm/mremap: check remap conditions earlier
  mm/mremap: move remap_is_valid() into check_prep_vma()
  mm/mremap: clean up mlock populate behaviour
  mm/mremap: permit mremap() move of multiple VMAs
  tools/testing/selftests: extend mremap_test to test multi-VMA mremap

 fs/userfaultfd.c                         |  15 +-
 include/linux/userfaultfd_k.h            |   5 +
 mm/mremap.c                              | 553 +++++++++++++++--------
 tools/testing/selftests/mm/mremap_test.c | 146 +++++-
 4 files changed, 518 insertions(+), 201 deletions(-)

--
2.50.0

