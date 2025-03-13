Return-Path: <linux-fsdevel+bounces-43930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85220A5FD68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 18:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379113BEC63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFDE26A1C2;
	Thu, 13 Mar 2025 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l0glbY/r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zeWDuPog"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865EB26A084;
	Thu, 13 Mar 2025 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886087; cv=fail; b=OYk88o5zq46k2SOapIHPOUq1ISjM2+tpJV1VGG6i/cpw9wp/oIkFbEJxsdVpC1hf5AsBWT1+8+CtCEif034NR8h3Jappb7vm6/en+ZdCZbyLNCrKCIvW3sLpTZGhVPvwQ4sz3RQbPmbEPbt8p5XZD1JaUb6HRC2sKn8TUOOX/EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886087; c=relaxed/simple;
	bh=RWn/YcrMSdBZzOSoQaz7fYqD0H0WZYD1Maor6ej2v2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QT/ywuGRW2ianz15ysq0wL096w1aC2e9pLgty5cQMd8dAFPUvXbUOU5JTAvHWr1w7+gQ8DhN5suRKvg2cX73e6PaotTiHQ9AU3wLKEOiwyqX0VCW2WWvBgAFOCBwEwdM71bngxzz7Dige+GdJvUr8bf1EGZG/QWDnrKClG+QfFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l0glbY/r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zeWDuPog; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGtqgb020671;
	Thu, 13 Mar 2025 17:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FKkE8L4KaOILDepGJCHjg9oa7qgVeuAWEGi3gPeAbeY=; b=
	l0glbY/r63v6J1nbLRfwYerxr/DdVl0BZ5/Z4BJbAkJxkP65y8qIAbmlzJeKln5o
	DB5O11irUXEHgHlXjgDJTDXGGVuubSnlMAv6Q0+f1xy3V+6DiXb3B6I1KFqIKcsa
	EYTNEal2Y7fpnmWXkvmpV5DXcDQdc/Zj9nxyw93U/UCwkBDdcARc36/QC/iW9EQA
	WKoZOaY2OcWmrxGMV/VpdVONWHBCV6LwhvJrt9NEk7TkxGlEnGCD9gKMg9oSPY+B
	RWIkr+p/TxZeUsVzFjDttWm9BPi1ldGiojKPrS/GyBq/D4LEnhMOBnK158vLjDl6
	PdxM0LMuHcZTOs0tZiAUCg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dvpwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52DH6LLU008673;
	Thu, 13 Mar 2025 17:13:32 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn505gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKrF4iG0lwviwicEFHlpdkQluTlY4PnkA7XaB4RAvhxtsZjx9TJVvnhu3Ya2IPBZyH6upzqX5+EZ219JMN+YDbJz3zemqFXQRxhdrM1r/xKSXGLJKogJ+OG3XQ5tPaDMP/N5bCkNk7VcigjlCCOyGLT8ShJlG/lBwO6BaBo+4mSysCWqtFoG/t3fr8Bq+Psjj0sqRwqrJJ6GalH2uTk0RatLUU3l2yySi9+yi09sUZ6ZOvRK0qX0gJ41B+KHb2XuWmzqF5wjhezZTD1D4Ng9TrBl2cp6lc1qtuC16VJgVv/Ps/ahZsGyGTfs+Uw1cHcwx1bizjwTQ7HuekqqRZuDoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKkE8L4KaOILDepGJCHjg9oa7qgVeuAWEGi3gPeAbeY=;
 b=PVQlheP0+9cRtpAEhZqpw2n0TH1T3cFyge7Zm1u6oHgXFib/72Su/X982cvfTlo1FJxyZHc4rFjK7DRpMVd327qBbmJ6SDmVywmdgam52375IUGYCdE7cekEmo0EmpPsv1SBim/qMFaZCmJUIuRRA5z07BtOvoxST5922J2MmF2h7D8Ba336OiL37D8P0kbFaN2aYll07e3eIGsSdlHBO/EugclX7XxRMylFrMiSwKqaz3UipTsdOSCSKG1fpxHGKwWThKzioV3x54cCW824F5oOV6eV9L1/huVym0GlOCgjzHTDvKTmiWOopEmbHBBvTmx6sNmt5a+TYaCSDiItIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKkE8L4KaOILDepGJCHjg9oa7qgVeuAWEGi3gPeAbeY=;
 b=zeWDuPogbm7jykrYROndch0RLp4u0KfMZcpkmk8Is8Cs+Ul/JdkkOVVa3//3Y6hTpn/rK8RPHmQWBBi9dFgCpOc3HhK/5xlP/RQr/WgiLOtEO/MTMc3xdxnsEq07xlkTxDkhg+XW4/RurH5PRkdbtUqE66BCcRe4wMomJEwMHnw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB5011.namprd10.prod.outlook.com (2603:10b6:208:333::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 17:13:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:13:31 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 04/13] xfs: pass flags to xfs_reflink_allocate_cow()
Date: Thu, 13 Mar 2025 17:13:01 +0000
Message-Id: <20250313171310.1886394-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250313171310.1886394-1-john.g.garry@oracle.com>
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0368.namprd03.prod.outlook.com
 (2603:10b6:408:f7::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB5011:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b8c7cbb-af9d-47ba-1630-08dd625260fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K9YQmVECz2RgBM0PWIa2MLGuzLbm0xC9o/0p5nGxSPC1hyDzEDQALyC65Dqw?=
 =?us-ascii?Q?bZ6Ich0Gede9lXuK+JLP3Y/wQUsX9c2hqpsRrKPkuR82lnij+w2dOcely+Q4?=
 =?us-ascii?Q?V8W1J0lVA9KkejRPYIWIuAmDitO57onDiJrlkr35nnsQXjWXd7B2OTBMK28h?=
 =?us-ascii?Q?lARxl8g+kz22rpp0HQg+DG+h2kni8buqtq6/3YIlmqZm5yDYYufVHgYuAEET?=
 =?us-ascii?Q?u4vOkT09koe6yQQ37D68ZdJm1+nwZWf36GeOgrY1j0tniT7PrjPT/KZ6TU9t?=
 =?us-ascii?Q?5mVLzDg+203IHBAdSxTLCKAhx8EoFUHB95QccNOvmfe1ajxdoa7UNXY8Jfqg?=
 =?us-ascii?Q?EPf+I1cG9fnlDDKSvhZ1r4mutF+fZJIDXQ2wl2QUGCXKv3QNHgCE6W1B8CuK?=
 =?us-ascii?Q?51L4ok+LkLhEhM11caXc1QPONrEYlXZKgsRlq9XrsM+2xoib414L/qm4tNoD?=
 =?us-ascii?Q?e6N3TNBqq87K3fpEl7m/ZSt8Wvi5jrTIKP8g4UeljNw6mqKzcVJwXTftde4P?=
 =?us-ascii?Q?z+bMvRwn3OF1/2DHIgNEb0hbAkoVnzzIvDeix49v5yFGTjgmn/FrbGLbF3qI?=
 =?us-ascii?Q?3YA4qrReOydx0KRajlEUJrpbQj0Sb46PGNDCn4usu1F7qnjSE0TBXJ+lB2zB?=
 =?us-ascii?Q?y0ze9F9OEp2ZHuNF5xFtR+qF1vuKABvsFK6E2mSE5t1VfzhIlbu6AAnZgMxs?=
 =?us-ascii?Q?ywjqzkXR40RVpGzgXK9AW32CO1Nuwk6ynpCDx8bePcL2DRFHrVhB5O6KM6Hw?=
 =?us-ascii?Q?p87nYO+I4TFS0h4jQJvax2/IzzVa4nUhBWSz2FKEf3BytFe9gTeznLIObRDB?=
 =?us-ascii?Q?w/D2M24asMOKeSpWyFjv7ugVmBEaFar+7+OX1CPa87sukR3ccyVAhMxRY0Bw?=
 =?us-ascii?Q?nB/3WONeGEqmO4vMJzkYV9tjNuuGmkGTu+sLyUcilWQG3U6wdHiio3+8eEfo?=
 =?us-ascii?Q?mz5i2DBTOo83GLAkeSXMTOI8zQtl7XroUAJr+rMQwEvfh0ZUcDSECCEtauM5?=
 =?us-ascii?Q?YPPs7j7645UmNpatKdzmTidcnsb7hqmUo4rHrIefyUWUppTYNwnFB/gauOli?=
 =?us-ascii?Q?/M8hwaDNqlVWqarDG9Bd385liHB+5h0l7JUtG6AdioCbrQJsm1AS+O4mVkxZ?=
 =?us-ascii?Q?iS0AevNHWXSfy8W/j+gplFFtx7eObIpGEUTKxpOOOkgaTsxScDg0+FkB1SaD?=
 =?us-ascii?Q?BgZI58dTuOjGc8k/cQPYW6K+5mTZ9TH16E1np31Icj3Mg/OWkMrodpwcx5se?=
 =?us-ascii?Q?Tdpv/sKRjtOahSijjUAeux3QvIEREoVwHh1VvuRhIUEOVtBhO2CQU6PF/v9z?=
 =?us-ascii?Q?RcLADVK8dv5YzJMZp7JXB84ze8pDYZxnMj/D0AAJKO3V1hg/cdspTinnXcqw?=
 =?us-ascii?Q?jggbyIT5SUk4YZwMOZnR/51u9bWC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VWSjcnILRAZNPnYgDHPkKWWi1EkLPPy3ra5i2kQ+5j8V5hJkRsn9lpep2L2y?=
 =?us-ascii?Q?sfNyi/SBHf8g3oEdIrxFIAp0R5M8T4S/XA/WFWfTNMrlnZZyZusZjrV6bVgI?=
 =?us-ascii?Q?ryvlzLUrxgOTmLx46B9xkYX6RbOOUeuQp9xcUls0C85esbjbKnvprVmvNeAa?=
 =?us-ascii?Q?atw75YLJlsQsnbhWMiM0AUUICn8lSv8Su8AxzyyBfkjT827gS1u+88dWdoCD?=
 =?us-ascii?Q?Le6nKs58BZiBo4BBfrn2FMF0qnTjwbQ4er4JyrnWBl+8yoS3GWN2tli1qsEQ?=
 =?us-ascii?Q?nBV1qNg+8V9ngHpBD9Sx/r48ryIy9j5ikeCWyc1e2CC9zS5V6+T0jgNdIYNk?=
 =?us-ascii?Q?upcSEaHVnExjW/1r7Nr/K0/n3gL9TwAvpTq1YcXm3CqeoVZNnW3loGS3gqDg?=
 =?us-ascii?Q?T4QV50LdgiJj4gcnvpMHmF2YPDnHAO6b6GNdHqeUwZOSXIl4s1DC5BapKEOI?=
 =?us-ascii?Q?/CeKyNNXHp1x7k+WRND2D21ijD/aDRrO4BMkDM4LDbzdqXmiDxbZABGMm/Tc?=
 =?us-ascii?Q?Fq9xnWR34K0HHxSrBhfM73v8OWTbRMWz6NRhXWw6p9VBLr8GVC4lRkuVylIm?=
 =?us-ascii?Q?8CDMI/+b1oESGgJKFhUh+JFNJWcbLxW5NFlu3K4btsdGjqqAMTFlshDS/4q+?=
 =?us-ascii?Q?nuo224R2obgDwsoEIwnTWTUqwdT57jnBhk934mQKbwQRZWQzDdGnyf0HD21/?=
 =?us-ascii?Q?dCIy1fGUrgDtVXLubFk6dPmI7tAyVS/D8zpKrDUET6SbCzs5nld85IHPnuHY?=
 =?us-ascii?Q?q64w00WDrmHUlSEmBMgx0oe5iAPbfLmIFgpgDy3QgwImnc/GeJ4RDlsi+MZn?=
 =?us-ascii?Q?wih2eAIjr3xqImTaHuEAcya9fr2DHGsp2b/1uAxJL8WyuD9jtT++5p22iC/z?=
 =?us-ascii?Q?1fnEOXhaLNAkAf4WjyBJ0axPhf+9649PZWfg6FVFOhorVJcVC4g3r78SHZ+k?=
 =?us-ascii?Q?gVTVct4ulk4kFTilpNCs1pbm1SVz4j4pRX3xfCE9N2y+bGyYBQfUipgG4MfV?=
 =?us-ascii?Q?+R6rY11+eAIq25AFtEsUWXAS7+EKaN+drw6K+BCEaLNzEWeyu1bhuzwSxCvL?=
 =?us-ascii?Q?PtgYkrkZ5SmL/29W3Y1LHn9bjISmW49dnJ3mLNSxEVF1LdG8Pfmm0LvzEs8r?=
 =?us-ascii?Q?TpQJSzVejpOgxVbooEjlq9UdZuoDl/KcQmCkPnMCzc00RBv/1+B8Thrd3FJ3?=
 =?us-ascii?Q?HWMNMlGC3DgNz4ag5AQxSxeOEy9rin2T1CDasYHMriSjGy0eKMN6ELjMknd9?=
 =?us-ascii?Q?Hc1lYrLRZFsgIF/UHM6J6/PkUdqpSMaAt1fDigs4ixkMgKAJCYv3LhmE2HEQ?=
 =?us-ascii?Q?mNLtTQZyWQe/sXldDcIaFUOweGTCxT97FZL/oiJjjCdweUVAT7LTjRk9mTQ/?=
 =?us-ascii?Q?GOGc68oJK+ex94IByaIRExqtHSFFs4OSTUgY1djvQ4Lt+0jjX41f/wxdxbBT?=
 =?us-ascii?Q?oerG0q0gUZ90yjz5d0x+UsMFhYoKsLZXSYtTKj6jHaueI+vjNmZNM+h40563?=
 =?us-ascii?Q?mTebugbyx9pqu9xoLa1ckoqM0/4fh/YXoIKzw5OENdRNn5tuAtqXn0Prwcly?=
 =?us-ascii?Q?H1zf5zuksogYFulvbwLVgsM7NR2l9Vc54OZbONW6ROubf16mPxZYLxBrNh7w?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nhk6aygiTDkf6ICj5/r7vO8VVcJAuwShKo+nUK3EP+umgMY4OJGVyBrNJWDv2tkOxtYyn6AaeQp9fWWlEnPustbqdJ3XpZJdQgiH+1xg3a9nISKl82gGULBlfMk13BtpCPe1QyqU06nnbshir77FLON/5IACik7a+sX8rXZIqO3Ze5/h8X3nnyetRpBoktwIxYLXOnynSdj+5h/GIFgU1DNcgeX698PgRDK35IUAfV02b0tV9rpBsJqfCZ3f2ReL5QK+6yTS3sqKmYK6AaEM7UDl0OsSBtziUVoLBPA58Vyj9swddbTCuU3aGdR3VZpf+o7k34aAS8qql+9GCPdaiP+4gPT1ABWuaOUeydmAImgIzhfeCNTQcAb7ASck/XhcrQS3kL/51UT9Ob6a16KnFBamrwF4/zhW0DwcwLEmWbOxJsT3TmuuJ2rB2/IKwz+uJPOmGX0gnkcUDgwH4qn+f/vrjjshDTNk2qPW5iLZ0AsN/w0XaD+S9PTC9ki9ZS64JXUyhzMUSuHUAmUXkK7wz1hHvo/72cQYbrUBqijww+lnmwJ2Ow6n0BBKsEQWM3aGt2ziwLhzUARixdcWBzqkMN0wCxO8l/g46qXrm1hvBSs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8c7cbb-af9d-47ba-1630-08dd625260fe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:13:31.1762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: annl/syJQ2aM5WMa6si5CMURyeTpn6rwSnMEeZ/y0orhpPwGrSZyj0t85MSIkSmb3+2Iz7R8YFif6eRlQuKr7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130131
X-Proofpoint-GUID: nvu4UxBhQDF9R8QBiBlKF2xSWTVSbp9y
X-Proofpoint-ORIG-GUID: nvu4UxBhQDF9R8QBiBlKF2xSWTVSbp9y

In future we will want more boolean options for xfs_reflink_allocate_cow(),
so just prepare for this by passing a flags arg for @convert_now.

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iomap.c   |  7 +++++--
 fs/xfs/xfs_reflink.c | 12 ++++++++----
 fs/xfs/xfs_reflink.h |  8 +++++++-
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 9a22ecd794eb..8196e66b099b 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -813,6 +813,7 @@ xfs_direct_write_iomap_begin(
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
 	int			nimaps = 1, error = 0;
+	unsigned int		reflink_flags = 0;
 	bool			shared = false;
 	u16			iomap_flags = 0;
 	unsigned int		lockmode;
@@ -823,6 +824,9 @@ xfs_direct_write_iomap_begin(
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
+	if (flags & IOMAP_DIRECT || IS_DAX(inode))
+		reflink_flags |= XFS_REFLINK_CONVERT_UNWRITTEN;
+
 	/*
 	 * Writes that span EOF might trigger an IO size update on completion,
 	 * so consider them to be dirty for the purposes of O_DSYNC even if
@@ -870,8 +874,7 @@ xfs_direct_write_iomap_begin(
 
 		/* may drop and re-acquire the ilock */
 		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
-				&lockmode,
-				(flags & IOMAP_DIRECT) || IS_DAX(inode));
+				&lockmode, reflink_flags);
 		if (error)
 			goto out_unlock;
 		if (shared)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index cc3b4df88110..f8363c6b0f39 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -435,7 +435,7 @@ xfs_reflink_fill_cow_hole(
 	struct xfs_bmbt_irec	*cmap,
 	bool			*shared,
 	uint			*lockmode,
-	bool			convert_now)
+	unsigned int		flags)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
@@ -488,7 +488,8 @@ xfs_reflink_fill_cow_hole(
 		return error;
 
 convert:
-	return xfs_reflink_convert_unwritten(ip, imap, cmap, convert_now);
+	return xfs_reflink_convert_unwritten(ip, imap, cmap,
+			flags & XFS_REFLINK_CONVERT_UNWRITTEN);
 
 out_trans_cancel:
 	xfs_trans_cancel(tp);
@@ -566,10 +567,13 @@ xfs_reflink_allocate_cow(
 	struct xfs_bmbt_irec	*cmap,
 	bool			*shared,
 	uint			*lockmode,
-	bool			convert_now)
+	unsigned int		flags)
 {
 	int			error;
 	bool			found;
+	bool			convert_now;
+
+	convert_now = flags & XFS_REFLINK_CONVERT_UNWRITTEN;
 
 	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	if (!ip->i_cowfp) {
@@ -592,7 +596,7 @@ xfs_reflink_allocate_cow(
 	 */
 	if (cmap->br_startoff > imap->br_startoff)
 		return xfs_reflink_fill_cow_hole(ip, imap, cmap, shared,
-				lockmode, convert_now);
+				lockmode, flags);
 
 	/*
 	 * CoW fork has a delalloc reservation. Replace it with a real extent.
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index cc4e92278279..18f9624017cd 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -6,6 +6,12 @@
 #ifndef __XFS_REFLINK_H
 #define __XFS_REFLINK_H 1
 
+/*
+ * Flags for xfs_reflink_allocate_cow() and callees
+ */
+/* convert unwritten extents now */
+#define XFS_REFLINK_CONVERT_UNWRITTEN		(1u << 0)
+
 /*
  * Check whether it is safe to free COW fork blocks from an inode. It is unsafe
  * to do so when an inode has dirty cache or I/O in-flight, even if no shared
@@ -32,7 +38,7 @@ int xfs_bmap_trim_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 
 int xfs_reflink_allocate_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 		struct xfs_bmbt_irec *cmap, bool *shared, uint *lockmode,
-		bool convert_now);
+		unsigned int flags);
 extern int xfs_reflink_convert_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
 
-- 
2.31.1


