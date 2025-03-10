Return-Path: <linux-fsdevel+bounces-43666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88979A5A34C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 19:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59FD9170732
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4734323C8C5;
	Mon, 10 Mar 2025 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zg0B2Pkg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dOWpap2h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6CC23BF88;
	Mon, 10 Mar 2025 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632032; cv=fail; b=kJO6Ux4MmkHRVUPQTmjQl1WWo8Gxye57mR+MA/HaPldA8qlRz+FnOg3K4O4IGEiMcjT/gMC23ozc05ZY6XiPaIHawlEVpNBeLmoYZu7t2/bstFsnTlvJcw1q/XhhNxWU12N5FwrZ/djQTkV7WySz4YxKjReacYq8wRi407/Eots=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632032; c=relaxed/simple;
	bh=PTTAxrpn/WR2Fi3fvHBw8iuQgRlbTLdXk6y/n0vLmq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nsOEZtf6KG4yiC2fK6LvuzrAN4Dnc5ZDcG+0aZ5/yIkrYGLi3rz+jwAm7i1SKO7Zs7f5125bu99jpat4WTnsow5Zb71Yyk3b1yk640yfYkIalEAEntfp48B5NEteBHzT2Bkxgo7NsrsbgIcZVyLckaZ+gFdxNpIh5RyQiA/G9PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zg0B2Pkg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dOWpap2h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AGfit1009790;
	Mon, 10 Mar 2025 18:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=aHPCH8QqQVOMriesypDYFsgeR6ozNImmYs77HKLdH+0=; b=
	Zg0B2PkgAkRuQXbcQMYqhrBQOrJclyUkJXq1i5cwLTbicnboJnw1O6D+/Vn3c+6J
	T07gCZM0DmzGmq2W9qzZMcT5PhJnDoJp6sA5YE94W0sh1edVC8cWHxXbt4Ai3CIb
	rek6eFyPinteimNFTdXTpARSFO2X1Uud0m6W52Uz0MtIh+OVxssOrdsr9DpBFSHK
	0SYC6wQz5wF43y1QwXoIsmtNt8xu1Jzdi34XOuoPz8QTZxubfYTxVx3nKpprcsFN
	lvPPMPoGJFB/obSbNZ8X5qC1H1F0p/tcA4RmzBgBJcZP1ulcApodatFGnF064Z+p
	LDEpialCop+W9CI5FdJQwA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458dgt38b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AIEx0O017521;
	Mon, 10 Mar 2025 18:40:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb80d3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzteq7cExjd8rJPBB16fq2NIYxWfiOzt9orbfGRTBLNheoaUApTOhnAYnIsGLWreK6kJs8Pp1j0fKAiDsFKJ7CQXIdYfdWvslnW9hmDDJwyCZkX+9Te9Kjp5KAYV71EjfnWW+V3sy8sbNFZ2EnTqJT0N3LdaeX3JHZ/C0xmbrSEVojfFXuFacpnt1tpYRmonZF7TgopYPh6z4aCk86TMRxuJZpUUi3+nCgdbNVl60GkJmdcYpXgASW4HkB0/fIwySU1gAddunyJqBbfKpagDn88bCfBOfyJHm6Z4EPCU64HnQzPX1gYbYeDdR3I2X+TMZPw+PLEVuAnuwlq5GYDGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHPCH8QqQVOMriesypDYFsgeR6ozNImmYs77HKLdH+0=;
 b=wIu5K8el/grRKRE5gSjN7vXRvdbGY3F+RrORNYlRkhA4/uwMSifFDk7Bes202L55qzbE/bRIW9t0AgqY2Z66oTUfZOrU/ULQ7upK6xcmF31N905Do2QsXkN7l7Cvchj0b87qRqWO1YZRAkEuiQAFkrUVd2Hbr3SLiFpGSfvxnLPpyb12Ns1Ky1w0Fesr8rHwIwTX3pON0fdf2CC4oUfrDTiA2tA62rc8iOuJylkP4/diZE70tJqpfYGMgK5RJfhO1Q3C51wGtJlxjcWjDI5D+JHAucko4ArN0RC7KABjCltOVCrymC0bPjq4rRruq9KksIEMbtd5HNPG+40Yly2Ebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHPCH8QqQVOMriesypDYFsgeR6ozNImmYs77HKLdH+0=;
 b=dOWpap2hBfKl9gftp1PBcaWY28A2ecfOkO/MgIWDKJNO48peejuvL5MLRSkdDD/fnqwdtc40HcHT2k6yiMWCwJKTjuIwYI1eHPYAP66jcda3QZE/XICe+rRWvWfNDr+f9pCLzr2tGFvLJU+IMKx/2p/llmhkVaTc0gIRsBz62EI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4502.namprd10.prod.outlook.com (2603:10b6:510:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 18:40:19 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 18:40:19 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 09/10] xfs: Allow block allocator to take an alignment hint
Date: Mon, 10 Mar 2025 18:39:45 +0000
Message-Id: <20250310183946.932054-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250310183946.932054-1-john.g.garry@oracle.com>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0064.namprd02.prod.outlook.com
 (2603:10b6:a03:54::41) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4502:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e05f00f-cd9a-47c3-8def-08dd60030202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ac127DsbmhwPL1fY22WkzqyCpgE4twqYxFSJNRfxRdbhOEczuT18wBK6psU4?=
 =?us-ascii?Q?uqHLin+EkVN0sN/KwuKp5EbszA/a7bXI6/I7rhTER86VgYU2PSbTF1++jfLx?=
 =?us-ascii?Q?IeeuXjIyFUXO4yvWWpyEwMNCk2hB+8EDqLBF5//uZ7xEAW/z51PwitMjagd4?=
 =?us-ascii?Q?smkeXSWjOSBpxkDT6EfOMeVEkEcCDFWxpyokUYpZblrbaWKuM+QcehjThrI7?=
 =?us-ascii?Q?A6NeKDTK3Qak6cOMMfDpb4BUhEkqHNB768N9eGpHfypCetYcWVHGZRnR5WPF?=
 =?us-ascii?Q?YCd6/Gq/vNnvpbWCmdCXYgx1ZjHdP5HgRdl4dCUDl4SvsKmgvu/QAZSJ+GtW?=
 =?us-ascii?Q?yE6aajsDfovNt/Qr9K0nxyGua7OJmVvbfb5FIlOpXpQGi6jiElacbEB6yuVc?=
 =?us-ascii?Q?U70bh+dMVfqv4gHbzhE+t/BGE3vLJ2bpu1TH68IFRwjhdpQA7bhmv5RLDH82?=
 =?us-ascii?Q?2ETGFu7wg5AlZzbJfvKtTMjrNbYE37jN0IobBkrV6775G1uL0MtkRKe8zAjB?=
 =?us-ascii?Q?IK33u3riU0jcPEQR6TGp0DiMptSYXasy0l4GQWmxGSIJo6vg2EhnoPeaqFIj?=
 =?us-ascii?Q?475uIe4mtL6J0fR/RRPF1MpkIYCCwZLa1Rv2iV/jlaZoMGL14QlpmL6gM9tS?=
 =?us-ascii?Q?YSq4ZPrAgjSr1tTHT/RbRcv0wea61mM82f9rHCu8VuWexx+/d6wGDW889/9g?=
 =?us-ascii?Q?LnG4WD45jkBlo4jHOr8QyjBkvFsFxkR/9eQTOuhNTGAciijnL0rm0IDcwSwI?=
 =?us-ascii?Q?e0r5teSCz7sPdpCQvCMGiCHgeiRyAJVwCp3zY0xOGfxSRaYrIXrsoLtcWK3m?=
 =?us-ascii?Q?OF8x/mAXyU9eX07FS88V2JJsxorS7bOwnf73cuh6GzVmclnlzjvVyz2UavVP?=
 =?us-ascii?Q?aztEbEy0nVJUN9ArAMvbHnnitbETt3aC+ZaErE7p2uircpNSpTqoA/gFfHch?=
 =?us-ascii?Q?n1VO5+IQwq+o6nyp4F6IjWhSzhnLxp99exxs87HgrzwRIboVfx6Hf7e/BUZK?=
 =?us-ascii?Q?bX0TO/rQBX37rvmlvHF/5Vm87EzxlppWXn7Ea3dJaQi+lwDhM7KtUCoIq9hd?=
 =?us-ascii?Q?p8mKA6/2YluGIXfJT8rgEiSyscg70VPSO6DQExnslFNGS5Lqfs08LKpSekfS?=
 =?us-ascii?Q?W0CBoXIP8YgWImOuXHIqLA7Xh1XgXo8Cm0Ab3hlI1ED8mzvpXkSxm8c9wjwt?=
 =?us-ascii?Q?EFlSbQfKZxuaVKE1iK8rzw2OzH066FIaUHZQmf9xPSnvhdg3FseVaSE164j/?=
 =?us-ascii?Q?KSdmRS+hY2wlHdbVSX66mniLACqihDNptc2mJ1EZdKWiV0PNy+3TYvPj1jfF?=
 =?us-ascii?Q?XHlClbkDNWf8Oi4qJE9Wh2ifqSuhi2BicMoaMN3x/oopJH535CHe2Uf7cFHl?=
 =?us-ascii?Q?TSNrJVe1S3O6bMBJnHsPJEy/+6G4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lpPBqBLYT9KeP92vCvKqtYBjVNuU8ORnufp/xwLRJ3SGTHWvMyZ/PdK3DcCj?=
 =?us-ascii?Q?JnovE1XzQGx0Eju4kUfAsQp0QkPqO1f4C48dMf3WHjDtMDlOdHI7lFfYPW7t?=
 =?us-ascii?Q?tq1QOZjm6aFVeU89HcG3Hjjq1oLfGof76hdmV57BYqfZ5RNswu0G+/ZCIaj0?=
 =?us-ascii?Q?LgkQIFFtptLT8AoMUZv0mWnYggOxaJB4+uFhBPK4HjIZu0Gx12Cc/Rm3NMuS?=
 =?us-ascii?Q?R7MrmYdPu8zVeGgo5M9vqqS1jA0sMFAyxUZXIu17qSRY1WhbQ8MaB7kIZDYQ?=
 =?us-ascii?Q?/Bej0DTTSDy025VcSqJstbM/fBHfEyyqGksuTeEPRvnGMUi0qPL8tq0Q0Iem?=
 =?us-ascii?Q?+a9Zw7Gk8n67Hc9ajIR1gxSVQ09M6O34gbFBEKwL33+XrUI4C4EfjBjBi67E?=
 =?us-ascii?Q?CMtxq6KC6IATEBMJiCusa9nw2aLhGjpT5M4+V1L+Ig2khWv4Z97GCBjMblXs?=
 =?us-ascii?Q?fXiDBNlpIYTudLwcQDBR8NQVsc2S8h2zOqw/xmaS3ivu5OmKjzTDA90qIXn8?=
 =?us-ascii?Q?+I09a9n9UOHOhjKKA+czhwbv1KpPQ0QgTm1bNMHWRcyxmUP5DhwX/QBNfnYZ?=
 =?us-ascii?Q?fKg4PQ1wTCjLz+Klt8n1tOzKzhfn5ZwMsTv2BBPBzHBJu8tKUivxO/quzIGU?=
 =?us-ascii?Q?OBRR2gLFkANO8zxFZ0PBgNG/Bhu1kgPp67L1icYfXudAffTRccpudSk24mer?=
 =?us-ascii?Q?sfvQc71gJa2b1wIx96KgiHDr6fpqmXaVczdFVgjE5al9pYOQFZgYSYWFjj1y?=
 =?us-ascii?Q?/OF06JtWfwqSxz1kb4CAaQUU4ZL4r8BvPGxsz3fa9A+rs7m95wbmrwowzMnO?=
 =?us-ascii?Q?jfn9ML/m9GBx2+XazWWci15HbQKOrh6BlUD/5MABzeeZ+D+qcGd7lW1DWdal?=
 =?us-ascii?Q?tfWr8GVd7HA0mPevLf6DyJOceCW4P/7MIDzAeQkW8RJuUOcGTBF9xYgxX2Bj?=
 =?us-ascii?Q?3RK/LzrRDp+zb8EOacTKy39MfN770xQwHmjH9v/rF0Ky1nrKjGzuJN+Sh0bL?=
 =?us-ascii?Q?Eu/gSnGZLUpot/sCq2qEebg/EYaWnFkUxz3Nf6C2kQ3qvfAshceUlemh2EPY?=
 =?us-ascii?Q?v3A1oKIuYaEbEU/kQj5hKjCix5RVibN3yOWwDVveucNAJokE/r2BsxUTp3Uw?=
 =?us-ascii?Q?mHNWPnksG+cnYSG+mxbLxnNQWmUHSCp+DY7rWObuW/ImM6/0uUUCfE7R08Go?=
 =?us-ascii?Q?gc0Bh9e6LBbzaWNoimGUdWMh9QDemk9FE9fRn0qPQSzEpU2Ndd/X4U9/c/1T?=
 =?us-ascii?Q?oCPu03tOOmTCa84mwIawVzlD5Tb+QiMHQ4udLeN7nURM6ekjAX2ylRuS2nBC?=
 =?us-ascii?Q?dtNsdMmWe4NMVUzQ8Ug6q4Zs4/XsF4t2WzwE2aCfL7TqB8a00X3qaEK0/mFF?=
 =?us-ascii?Q?P9hq63ovQies5/MBPg+Odp3tx4MnqPLo4SOr9rfWpevLHc8+W+ahjDIUpkjW?=
 =?us-ascii?Q?ZwFDuJCU1vU4krEmvSqxhiQkTRW4dM6ztqI/cVgpDCClAHVh7+y9xd7ekhbw?=
 =?us-ascii?Q?Oq1r5J2gbvfZF9sm21VoD1B5wF4wqIwdXVeOvX4XNklXhqUDgYJqBaj2CLA4?=
 =?us-ascii?Q?Ou06e/Tm31zn4CYT8Jq6wLWddt9Gt6RtXWkL3/qLTW2StOIhctVpY9+JBW1K?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c3vljU5tTcAfWSnmgtYHw0Z3iYCn5fmNU0SOdSXaRpQ19LceN5G5pGdrV7czgE9OX9Lbelld5/qXfWcLYk0R9z7tuvP9KaknKavZLYKEPDVr9U/2gsahAQVfP3mNv5fNAvzJ4Izd4FALqLDKE59xb0pjYoJs99yfHP+3cisN5P1XY2AAeVB4vDvGf2GMlvxQKaIUEd5QYGxQKF/SvoQSjozT5E1Rk0TsGC1KBuHQV33Tz0BSd7luZZvDVJYMkZJjA1L/op783EMjgHHtv9VEdMMm9bLgeQlTHCx5eIGm2YbXATrPETWMWY1dyi87Gh+Fy7zw7ruym9HgUEaYkfunSesnR7smUmBM61ofUWrSX1cNqt+jcLuj5pltmdgBZAHxfGymm/Qpv8SwV/aa4+h14lX85Cj3/mb9SQHCUK0axmwKx8gxla0s4SeYubAnA6Lh1heGyxvl7emDgIcQqH42h+JAepfqSNzpWDLbMwIZusvhzQSX8uWBaTShGVjsMLKMzhjNFi10vyxJKkTkILqB4YMNJjZ937+B0BcLwXZ3ksH7MFsslao9dLJ317bCUafevF5KDMpDriPA3naQf+5b3rHFBSfeT9NSdsPvNVr+qhQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e05f00f-cd9a-47c3-8def-08dd60030202
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:40:19.2867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLXpA2yFoFMk0NP0+BQCy4ae+PARSCg7b9q7ptjslbPtF+nHGXluHCx9AY7Rqz22RWGtUlojZAf1Qbx47xippg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4502
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503100145
X-Proofpoint-GUID: 1XvvBqljOm6BhMC_Dzje78VcUXN5XbRk
X-Proofpoint-ORIG-GUID: 1XvvBqljOm6BhMC_Dzje78VcUXN5XbRk

When issuing an atomic write by the CoW method, give the block allocator a
hint to align to the extszhint.

This means that we have a better chance to issuing the atomic write via
HW offload next time.

It does mean that the inode extszhint should be set appropriately for the
expected atomic write size.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 4 ++++
 fs/xfs/libxfs/xfs_bmap.h | 6 +++++-
 fs/xfs/xfs_reflink.c     | 8 ++++++--
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 63255820b58a..5ef5e4476209 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3312,6 +3312,10 @@ xfs_bmap_compute_alignments(
 		align = xfs_get_cowextsz_hint(ap->ip);
 	else if (ap->datatype & XFS_ALLOC_USERDATA)
 		align = xfs_get_extsz_hint(ap->ip);
+
+	if (align > 1 && (ap->flags & XFS_BMAPI_EXTSZALIGN))
+		args->alignment = align;
+
 	if (align) {
 		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
 					ap->eof, 0, ap->conv, &ap->offset,
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index b4d9c6e0f3f9..d5f2729305fa 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -87,6 +87,9 @@ struct xfs_bmalloca {
 /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
 #define XFS_BMAPI_NORMAP	(1u << 10)
 
+/* Try to align allocations to the extent size hint */
+#define XFS_BMAPI_EXTSZALIGN	(1u << 11)
+
 #define XFS_BMAPI_FLAGS \
 	{ XFS_BMAPI_ENTIRE,	"ENTIRE" }, \
 	{ XFS_BMAPI_METADATA,	"METADATA" }, \
@@ -98,7 +101,8 @@ struct xfs_bmalloca {
 	{ XFS_BMAPI_REMAP,	"REMAP" }, \
 	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
 	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
-	{ XFS_BMAPI_NORMAP,	"NORMAP" }
+	{ XFS_BMAPI_NORMAP,	"NORMAP" },\
+	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }
 
 
 static inline int xfs_bmapi_aflag(int w)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index ce1fd58dff35..d577db42baab 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -445,6 +445,11 @@ xfs_reflink_fill_cow_hole(
 	int			error;
 	bool			found;
 	bool			atomic_sw = flags & XFS_REFLINK_ATOMIC_SW;
+	uint32_t		bmapi_flags = XFS_BMAPI_COWFORK |
+					      XFS_BMAPI_PREALLOC;
+
+	if (atomic_sw)
+		bmapi_flags |= XFS_BMAPI_EXTSZALIGN;
 
 	resaligned = xfs_aligned_fsb_count(imap->br_startoff,
 		imap->br_blockcount, xfs_get_cowextsz_hint(ip));
@@ -478,8 +483,7 @@ xfs_reflink_fill_cow_hole(
 	/* Allocate the entire reservation as unwritten blocks. */
 	nimaps = 1;
 	error = xfs_bmapi_write(tp, ip, imap->br_startoff, imap->br_blockcount,
-			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC, 0, cmap,
-			&nimaps);
+			bmapi_flags, 0, cmap, &nimaps);
 	if (error)
 		goto out_trans_cancel;
 
-- 
2.31.1


