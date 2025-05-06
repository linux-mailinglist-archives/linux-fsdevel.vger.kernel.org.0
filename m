Return-Path: <linux-fsdevel+bounces-48200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D9CAABEA3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145D03B2235
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5991627BF8A;
	Tue,  6 May 2025 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G0xmWDSH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vL99t3Ny"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D5D26659D;
	Tue,  6 May 2025 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522349; cv=fail; b=aKAmrAMbLXnzdcLTs3UYw3EETZeb6oTLAW1tv4BWNHF3W/SP837682+42d2zo6Iv0/2vt8tWqNA3dvQJ9d50EHaFc6jhq08c5WhHoJ8dkuvl+MfrTyuy5eRvmZ7KEAHBPj/1gjMozCAM4S8KRzd25AFo4biFa+/DcoZo4irmMuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522349; c=relaxed/simple;
	bh=lESyKXmcD/WIInZy1ooaRbLsrQrEG0WmZvzyJ3JgkqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QaQOiDxUh1b8pz7VYdfvpUox+xVpctIs3UqHUceBSHjCVyNYGZ3nSpQfQaVNitmWt5sF7toL7d7zZk7BeyGykxZMC28H8ajut7BZDpItupkCv9x0woq2FsXpdqTtZYoIfjcyKdG//MnZYJJxcUeV0USvGVpF8XNMPgrOxlW8vqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G0xmWDSH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vL99t3Ny; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5468cw40032218;
	Tue, 6 May 2025 09:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ditZR8XzZpGzgHP6gzZd9TEojSztMv1kem5aHGLO5UM=; b=
	G0xmWDSHiH7uSTfNc3tGUBqpYsFJdxZQyUZWswjsco3mF7jqhgFqSUdYAT+HhJrl
	126GEUF27AiW3PGro5IDDfWxJORIg0eJMsyvoQEsypcupCuodsWeByAGF/zAuOrl
	QByuW6eCLaFzPWQWvXH/1AaDgTaxaD1zD+vFgNJsfWljL7bWWN5/ZkDGcOfl9iz3
	Az6FKFPQHbvPEo+to+I2KuG9NVGAVOrhm+yBQnf2bnmIMWzkjby1LxDimnj1+ime
	wPJFz97Lj79dEpgrqU4jToSBCUOmyedUVNwFq2fh93B0mZ1T+3utihsuRHGq2ySq
	3Id0sqFG46Jo/Q4yRQw+Yg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ff3mg21c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5467sm66012165;
	Tue, 6 May 2025 09:05:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kf0bwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yng74me8yMahQZ4aNMk4dTB1vImxnKfcGK/LA1WdYaG4tibLuj2a425Ph7j2wsGMBAeLK+003vdt67O0X78sYcdlTIAUB8RzBPBi8MNbL2HEf1May16TVrJPbqk/JHmzCDlcMjYkRh7FjPstqz4tvLYsnVfeIbV8q6vDrMi4MsyEpC9FMcgeqwaHsbFbvgAiojcFj8qKS57dXSLGHS9AfuDLCygsrxTByfNsulm4ZLZ7j2LS2kSSaUrNx4e9eijygoIkmWQC/+Rn1b1XclLaIz6wHxKABpw5r929tngF9GnRswXPyFG67G1XP9rIsLnZ4K7fTeuXEEMNbacXJJVylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ditZR8XzZpGzgHP6gzZd9TEojSztMv1kem5aHGLO5UM=;
 b=ynhIaotze5jpb5Jd7+TuIRX7MhUvaur8BYhaMWNUSua2FCrZxyuL4oYv/77s6Eo5qoQsvcruPuWRVgM+e9JUug4b8+YOl28KIIJyncaxle59QPqg4k8lgrXQ3kxZcFXYsgl2QNhVGJCKJZ9ME7i5LWmjcyplAc1zYFGSMVA4LBcJv2w34QVRR2McsN6fRrnG66cI+T6sBtwef3KOMTX9ennxWmxEtaAd7c9nFxuwdVJrc2YBTAuLOZJITAv1GkrFW3Mzjfg6uRL6qjdd+dYLPnFrdCFhsY1x1sNRdD+ucmxL0fLGmnE345eiD3gs04NQEUWoLrafKlFNq1QeT3EWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ditZR8XzZpGzgHP6gzZd9TEojSztMv1kem5aHGLO5UM=;
 b=vL99t3Ny9Bb63XqgQMO0sZSWgCBxZ/ueIqQl9VcqVqfeeLUUMMg32M9E3qEqN3r/a2pQxIb+cc6DX/1TaLWkdGkE0w8hZoMPW9SLO7GT8MBnqY5n1XgXJBJDHyXnbD/eY7Tg6+SFYn/xrE6n0cAcXyPdg7vzehLgFudSRwVVckg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB6069.namprd10.prod.outlook.com (2603:10b6:930:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 09:05:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:05:29 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v12 13/17] xfs: commit CoW-based atomic writes atomically
Date: Tue,  6 May 2025 09:04:23 +0000
Message-Id: <20250506090427.2549456-14-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250506090427.2549456-1-john.g.garry@oracle.com>
References: <20250506090427.2549456-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 226fd6d9-50c7-4d5a-ec1b-08dd8c7d25b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GD27ioNafQjXt7r34MmSqneHeJC2LHk1Xm0ejUJ/KP9oSJtszmY5YKl9Sw0H?=
 =?us-ascii?Q?KaAryMIrjvUxq5u0ThTnOB3ybwXPYrNy4cqAtZ4zZt1dpPOao4JHF1Ead/RD?=
 =?us-ascii?Q?hJ36WEoTyjX4+/arMIa3GE3rTbqUEie8Z9KAtIPrrhmxIgoPYPd5qoazBc2X?=
 =?us-ascii?Q?gkzO5W3IxIsOIvfUET1kVSXl/ZK7puuG2CWNZlgBqEYUYvEAdVTEDhz5iP70?=
 =?us-ascii?Q?R4ppeTSJ56TdMx01Y92U+h3KK+sFVLUHtjPDBDlQ/qQuzXOUypGcMgHdBjhv?=
 =?us-ascii?Q?BO5SY2jY/uZfXPyI0/X7NAhkfSgiY8jRuebI8wmf7WVgMT/PWEkHu33VtkC5?=
 =?us-ascii?Q?jeOyce3r1IR4+0y0wMSDOJLK6wVC/YBcx+KX0cYJQsYY8RUr3wCiiQIdi4s9?=
 =?us-ascii?Q?d3KZs7xoPP0WDBFanSTb/zatfYpGtsE0QgDjYEPPBzPfOBIULZ68LHVEU7DD?=
 =?us-ascii?Q?i9Lib1+ziturgSnHyJHR/M2edEPtzhcADSyJY/xefMIop52KM4mHlHSoqCZZ?=
 =?us-ascii?Q?hngB72/EXioIM4Jx7F8unvlEAScTQnRmpInGe5GcAY54eBTPLE+PFKjEgJF+?=
 =?us-ascii?Q?t7sWaBngkAQhI3iSN943NkJVHEbAbgiCPjKPlgyAWvB+4kqdAziPXhPmlN7D?=
 =?us-ascii?Q?trI9I64CxQ7NPsO8zyI7ks93zfE59fGRv9orCaTuSVwhK2U8Sjml7NJac9kE?=
 =?us-ascii?Q?OlysYhCxku47p7upUQz2nMD76OOGVX89qlkGTrj+z2xKaW6dmxyuopSNEHKt?=
 =?us-ascii?Q?dhXr3Cw5ivxDH9Ap0Njsl2o7JjdVw3RrQQcGot6zk8u2WVXdBPPsWTUPrdBi?=
 =?us-ascii?Q?FyT1C3J1PJbMNxUgcBhlP7oNJL05VgjJ5IR2kNriQ1kCa1Ttr98w7iYaP4wL?=
 =?us-ascii?Q?nYeu+lCXonQD+OLS0ytuQADVTXeiICW7rs8swVy65TfB5AZnEV05CmDebBM7?=
 =?us-ascii?Q?kf2CfUCoBtnQQEX5zmJQvCV6QFaK+f9In47+VceB8szNpeW9Lay8qSKTyGYf?=
 =?us-ascii?Q?fgBmO2lNpZkTE+2X5SJqF+ihGIcZ7CT6wUq8upeYNh3OTPHZHYpKEmVeyRO7?=
 =?us-ascii?Q?hQSRSmBT3OtXITqKIdm5Kh2ftTXgIl2jizp6RcaexuU+F1KF9/zwewL/IfLy?=
 =?us-ascii?Q?mHMH5u94rUEbkz6ebuXjqNgUw2EeuzIsYAgjgZaYzpcpsZdsTS+4SwjnxFUo?=
 =?us-ascii?Q?NfylO5RYnWZFlvuUrfsoB07vPDTPOS8HDHg8dXUlJTq5GM6rBNWLHxg/0Yk4?=
 =?us-ascii?Q?IQrxiY7IZSp3YlDWCbwu2TPKHUC4SYvNoT0Yhg9TlcQhNwjVjnl4ahjY5a/l?=
 =?us-ascii?Q?dZCHYjvt2Rz2k3i9aP/h+kFfggttXj9YHCXVJdaI4SGetvxGvUZGyYuMbP1S?=
 =?us-ascii?Q?o49w+tGkFgQa31P7CG9h3ncZfxJrlShFsf1UqJryHyGapDT0aS32v2LWet4b?=
 =?us-ascii?Q?X1tqzkaRlws=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8B4zRBrdW8bGkABSYzsQXW5tbKP4LOau66wJuATfU8C080HP1LKPog4KTPBt?=
 =?us-ascii?Q?i3g5RebpeD/T+GAQFnNkt5H0MgAShMJen4Dydyzj2ydR7vPVCDFxW8IaCmn+?=
 =?us-ascii?Q?dnB+9izfUfZfvw94LzH7zNiSMIelxEAYEuATEkkrGVdAJUbpKnHWw86d++Mj?=
 =?us-ascii?Q?1IRmCl0KffDQlnU8OTNxig8gOA3+//3RlryCQWlOFB3osAz+62eT5e2cV91k?=
 =?us-ascii?Q?8lgohV53R2TcSsP52pg3j3EQT4/tKbMGxd5mUFM9clT6gkM+QD8wKesMwsA5?=
 =?us-ascii?Q?hhoBEkRK48LJqTxMyShNo5QshuCJFsf1DKrVS2A9rlspjXpnOiY3yqNlkgcF?=
 =?us-ascii?Q?YmiuAaWMbMrQLEabrYwSaslOeKNvDvmT5BTid+2WJvJ1MEqRnFhrvyox92Ld?=
 =?us-ascii?Q?z/VEotGpDE/FnQZgHyVTdziJT+icafKhvJbExHEqhlSwr91+gQPeOv79WJwB?=
 =?us-ascii?Q?nGlMSk1OWd+EiWYcHxEn36J9KrozIGapuW7luq+bl45Pq4dd4yhrY7VFrqzi?=
 =?us-ascii?Q?TUo7z0amc59ALCiFu55IDYpd+rAOhqKjGfQlk7oH4/wmQLfIRlPEuX4uV86E?=
 =?us-ascii?Q?FqIKL220+PJu5zfa1hydmAS4Ft4+cRJHzfukIwdoNRL4bYgOs4hMNj9yVcOf?=
 =?us-ascii?Q?IYnbbXNiDlY+TqN6MsLJSQo8HX3ltsVAvMOXzGtegzyHr3PpScVZrquVy8cC?=
 =?us-ascii?Q?Cqg67VTj+9ub+D5U4fbyzslhqooQ3UrSEubaplbGa5wXKLRQaAq3Gh1D8Wmm?=
 =?us-ascii?Q?juB8zPKilM/KAnktdOH9NP1R8YpQB9u6wtyDtr4SjhMJJNG0qB6isn1lyMqq?=
 =?us-ascii?Q?7viksMrBh3I7+O1W9IR727K1DGoliSM0IiQlBdv+1SGdsb6OkHQ54OHoYM3t?=
 =?us-ascii?Q?b4sIcuVXWDrVUitLo1my2+hCItBx4V1ysudVUMDwRA3Z31BZ6Vi2g64GxjnZ?=
 =?us-ascii?Q?+q8oMMBgSWrzVC5QcAgOJjCPEtSMKXg2heJDiqQFuj5F32TcyExfTLrjFKTe?=
 =?us-ascii?Q?Y5tfrkzpR8Ve9q6DgpEMb0y5BUxF8H5Cpcmf3Y3xwrg4wYL4cV9hFtLSInRp?=
 =?us-ascii?Q?tKmhwdeTE3o2j2RYxQSGhrX4TB3L53jsuXfi0dditwuTdz2KUw2K+EevCiR3?=
 =?us-ascii?Q?915EQup3xyHgHZS4+rH3xBzBi1zwWMxyg6Zcim80n8SJ/qMl0+U8uqbtsT/+?=
 =?us-ascii?Q?OfT2ImpS3bwSsET17h2gl+jiU8Z0WEVCbXUSV0qOtc6RfC6doPTLw0mnMcql?=
 =?us-ascii?Q?AkqXzRY7FjraiNxcESYJku940tQ700MHw3OcVFKcXwyznw50ohr2Dd33g1sU?=
 =?us-ascii?Q?7250WHcTGUOdTA9Oi2z2rxyMqlAE2gHYtIDAdFAtsIZ1vt1/XGMnzCHMVubw?=
 =?us-ascii?Q?0mJZDdkVvUed+Gu/MNMNHsHVCm6Rk4pStw+JYqx+1aV+D9WGyB1HHtraCRmv?=
 =?us-ascii?Q?8TYcJjOAc+eDum8bM7MtxhqaHNZOGPG1NXneGt4ZyaK32//IwiLnznY89isH?=
 =?us-ascii?Q?Fs8gMEUJTCdoLIM7ZAjV/wpXQERkGNpc729qOpWKD4Z509wcF3O3GeRF4vxx?=
 =?us-ascii?Q?304wLhV+sbFteoQWfaYlxQX6xNWB/MBPmsY1gFPT7lhE/ez1Qf1FXJYxtzRT?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6H98AE6Ns7d62Z304GdoRkmQHpkZSdi8cqroBJk2bITUXtlvVtE16tE1P7jMbkjnGwkVFwhZd+mRDaGggrvLalUNn8BDpst0i+pmxIjDOrLMcy1qSDgduGrAu+ke4V1jkdfVd/7hytlWvK2NwSUSym6qcXl9OtPWeJObh8DKAZbTPTYTHUtgkO0TL7Q74atEiEE5nW+zxvbvUmkzd9gF7ckep8hi5N2FpHciHgzWlGpO+SPbkn5ZehPgjIYCENXueUkTA+WXLK+ekOsVWzll3t7kQsfoK+MWysByM1NA1snauGvwGf6/H11rJZnaMyjdhsBAmtDTGDcTC5ShBcL8oddvOdNY9yGGJZ78OKH/BmSmySZIWM3hXOqSF0xC4mqd9DOlzvz2Pt5mLf6bP0vrbB5CCitFn7/rb6RVzbjnfvzMmJt1AQIJgo28d6yRt10QC7Q9axC8DN6o50vD0zOitXnZIngDOyftHJnDvcK7G5H9+P4vhwaoI/RbaAeGEmozJpU9pNHR/3NAOPAZHcCuFgml7yw2vLib60lJupgW986OVjZyIS8qI9pvsraiEgs8NwZrJBp2X8n8bM3n3Ic2lQdU5+dE6PimQPmtg/QXTpI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226fd6d9-50c7-4d5a-ec1b-08dd8c7d25b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:05:28.9572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +j8ACOSkHrfJfO9dVbEMMvDlhRD1JRLeuq92rmOtGC2sHF68WjHMVObriRNtGX1ZcUAtM1Md/lo0dVNhWlak3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6069
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060086
X-Authority-Analysis: v=2.4 cv=e84GSbp/ c=1 sm=1 tr=0 ts=6819d0e0 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=psqDkX_6r_7HCtZpQ-8A:9 cc=ntf awl=host:14638
X-Proofpoint-ORIG-GUID: 5hCpWnu5EyPbwz8ms_0buBAng0zfe31I
X-Proofpoint-GUID: 5hCpWnu5EyPbwz8ms_0buBAng0zfe31I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4NiBTYWx0ZWRfXxVgZvhoVv9NO iZ0BMZu0pstYKqFG+sYvnnAT9DQKoMuv4LWH/2uyGnYPpweRdA59uooVHHElUYf7LwW+8M1COzT Z6nrkOoAj7jRQYXFaRTutZDS24SC4P8cNCKnJcuDFgshYznhvRUXioRN9j/7XHWfs5tEzpBxTa3
 WLynVNeKb6IAqVtv/x5nWNBfxDxQtXxPSF65uAT9A8z33XnWV+k1VXksHd9u0xtGghG0BfjTYf8 iIV5KRtsMUtHt3LJArRFjPnNdReLajrZUfuRWk9PG5HrQshluagkYugKYWCfZ0RW9k/B1l8VvOQ uAtA9zr9TFnSL8SFMMGTg2ezUvps4ita1bjDf6585OhxVpBTYiiBibbH1Oww0x5+aRJvtGJ9S+D
 IO6kPg8Ms8qUhPHDcp1xWCZhmdiqayHCSsN7YOJv8wlSfh1+z7g5eOlcs2mz32/e8voaRgmV

When completing a CoW-based write, each extent range mapping update is
covered by a separate transaction.

For a CoW-based atomic write, all mappings must be changed at once, so
change to use a single transaction.

Note that there is a limit on the amount of log intent items which can be
fit into a single transaction, but this is being ignored for now since
the count of items for a typical atomic write would be much less than is
typically supported. A typical atomic write would be expected to be 64KB
or less, which means only 16 possible extents unmaps, which is quite
small.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: add tr_atomic_ioend]
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_log_rlimit.c |  4 +++
 fs/xfs/libxfs/xfs_trans_resv.c | 15 +++++++++
 fs/xfs/libxfs/xfs_trans_resv.h |  1 +
 fs/xfs/xfs_file.c              |  5 ++-
 fs/xfs/xfs_reflink.c           | 56 ++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_reflink.h           |  2 ++
 6 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_log_rlimit.c b/fs/xfs/libxfs/xfs_log_rlimit.c
index d3bd6a86c8fe..34bba96d30ca 100644
--- a/fs/xfs/libxfs/xfs_log_rlimit.c
+++ b/fs/xfs/libxfs/xfs_log_rlimit.c
@@ -91,6 +91,7 @@ xfs_log_calc_trans_resv_for_minlogblocks(
 	 */
 	if (xfs_want_minlogsize_fixes(&mp->m_sb)) {
 		xfs_trans_resv_calc(mp, resv);
+		resv->tr_atomic_ioend = M_RES(mp)->tr_atomic_ioend;
 		return;
 	}
 
@@ -107,6 +108,9 @@ xfs_log_calc_trans_resv_for_minlogblocks(
 
 	xfs_trans_resv_calc(mp, resv);
 
+	/* Copy the dynamic transaction reservation types from the running fs */
+	resv->tr_atomic_ioend = M_RES(mp)->tr_atomic_ioend;
+
 	if (xfs_has_reflink(mp)) {
 		/*
 		 * In the early days of reflink, typical log operation counts
diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index 580d00ae2857..a841432abf83 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -1284,6 +1284,15 @@ xfs_calc_namespace_reservations(
 	resp->tr_mkdir.tr_logflags |= XFS_TRANS_PERM_LOG_RES;
 }
 
+STATIC void
+xfs_calc_default_atomic_ioend_reservation(
+	struct xfs_mount	*mp,
+	struct xfs_trans_resv	*resp)
+{
+	/* Pick a default that will scale reasonably for the log size. */
+	resp->tr_atomic_ioend = resp->tr_itruncate;
+}
+
 void
 xfs_trans_resv_calc(
 	struct xfs_mount	*mp,
@@ -1378,4 +1387,10 @@ xfs_trans_resv_calc(
 	resp->tr_itruncate.tr_logcount += logcount_adj;
 	resp->tr_write.tr_logcount += logcount_adj;
 	resp->tr_qm_dqalloc.tr_logcount += logcount_adj;
+
+	/*
+	 * Now that we've finished computing the static reservations, we can
+	 * compute the dynamic reservation for atomic writes.
+	 */
+	xfs_calc_default_atomic_ioend_reservation(mp, resp);
 }
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index d9d0032cbbc5..670045d417a6 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -48,6 +48,7 @@ struct xfs_trans_resv {
 	struct xfs_trans_res	tr_qm_dqalloc;	/* allocate quota on disk */
 	struct xfs_trans_res	tr_sb;		/* modify superblock */
 	struct xfs_trans_res	tr_fsyncts;	/* update timestamps on fsync */
+	struct xfs_trans_res	tr_atomic_ioend; /* untorn write completion */
 };
 
 /* shorthand way of accessing reservation structure */
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index e8acd6ca8f27..32883ec8ca2e 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -576,7 +576,10 @@ xfs_dio_write_end_io(
 	nofs_flag = memalloc_nofs_save();
 
 	if (flags & IOMAP_DIO_COW) {
-		error = xfs_reflink_end_cow(ip, offset, size);
+		if (iocb->ki_flags & IOCB_ATOMIC)
+			error = xfs_reflink_end_atomic_cow(ip, offset, size);
+		else
+			error = xfs_reflink_end_cow(ip, offset, size);
 		if (error)
 			goto out;
 	}
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index f5d338916098..218dee76768b 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -984,6 +984,62 @@ xfs_reflink_end_cow(
 	return error;
 }
 
+/*
+ * Fully remap all of the file's data fork at once, which is the critical part
+ * in achieving atomic behaviour.
+ * The regular CoW end path does not use function as to keep the block
+ * reservation per transaction as low as possible.
+ */
+int
+xfs_reflink_end_atomic_cow(
+	struct xfs_inode		*ip,
+	xfs_off_t			offset,
+	xfs_off_t			count)
+{
+	xfs_fileoff_t			offset_fsb;
+	xfs_fileoff_t			end_fsb;
+	int				error = 0;
+	struct xfs_mount		*mp = ip->i_mount;
+	struct xfs_trans		*tp;
+	unsigned int			resblks;
+
+	trace_xfs_reflink_end_cow(ip, offset, count);
+
+	offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	end_fsb = XFS_B_TO_FSB(mp, offset + count);
+
+	/*
+	 * Each remapping operation could cause a btree split, so in the worst
+	 * case that's one for each block.
+	 */
+	resblks = (end_fsb - offset_fsb) *
+			XFS_NEXTENTADD_SPACE_RES(mp, 1, XFS_DATA_FORK);
+
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_atomic_ioend, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	while (end_fsb > offset_fsb && !error) {
+		error = xfs_reflink_end_cow_extent_locked(tp, ip, &offset_fsb,
+				end_fsb);
+	}
+	if (error) {
+		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
+		goto out_cancel;
+	}
+	error = xfs_trans_commit(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+out_cancel:
+	xfs_trans_cancel(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+}
+
 /*
  * Free all CoW staging blocks that are still referenced by the ondisk refcount
  * metadata.  The ondisk metadata does not track which inode created the
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 379619f24247..412e9b6f2082 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -45,6 +45,8 @@ extern int xfs_reflink_cancel_cow_range(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count, bool cancel_real);
 extern int xfs_reflink_end_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
+int xfs_reflink_end_atomic_cow(struct xfs_inode *ip, xfs_off_t offset,
+		xfs_off_t count);
 extern int xfs_reflink_recover_cow(struct xfs_mount *mp);
 extern loff_t xfs_reflink_remap_range(struct file *file_in, loff_t pos_in,
 		struct file *file_out, loff_t pos_out, loff_t len,
-- 
2.31.1


