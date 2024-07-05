Return-Path: <linux-fsdevel+bounces-23223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE3A928C4D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 18:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336051C232A8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F15C175546;
	Fri,  5 Jul 2024 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DFZem29f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T6mbIEph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E14172761;
	Fri,  5 Jul 2024 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720196739; cv=fail; b=Fyj5O5I+oS1Pppybwb40HdY0cjR9wuVWuDFgTJ3amgnwQr2M0NKuPTrZClJYl/RlP6Dn1jGdYHLEj56t1MmHktS7gVzpg2z44OV+mnHKAxPdYyeC0I7AUeLeYm7CiSB5MdR5Kht3V2RZrxwtOkQMfJEdbpi+heliDetD+mH2AoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720196739; c=relaxed/simple;
	bh=9FTMcA7rkZfmIgyL8VqAmzt5cNENoCeG0+P/w6VgWLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gIdmN07iK8JW+gZc2gQN5VI1TfwLBEj3cmjWjjfMCzYHWy8EqwKGHS2By4Nhnjcjq59/lcygdJaNS6fCBWC7Z2r4arH4N1Le5drhh2Xdm9OuKB0h4XtqJRl+9IOLHhWVGdFlrOfaQzr6fVsxEQ9ZUZfy53lLDAZHLfKkzK5vY40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DFZem29f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T6mbIEph; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMoAp024762;
	Fri, 5 Jul 2024 16:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=IJpgAtqzqy5NPMAuN6MwKwGQVoR3/AfpA32R9j58sLA=; b=
	DFZem29fW6xHb/5O5i+vZ056qFiAZXwnJ8+D6iislmxzncqBKU5PG8ajcu9/Kgg8
	Xd4bIldOFYG1S6oxj0lRdsJtZYhG7j9Q2LR3qeUwH0+TKYKuEcsgUFHKjiNeaRSo
	WS3z4DvaEn6mEyr/o9jB36JeQ/ILYXU5GAqt1sF1kndaEDypdfUO5qBkLxxUd3l+
	j+6dcx8O7QjvxtslYq7EtPdJD+/4bozQiYRbzg/pDCYmgz4EMdcwy74bVZq9Pseg
	6jlPHW/UR2OD58bTgLEL5XQdaxBb5RN5zPkBMWl6/tH1OusRsO0OpIyMW0OyWqlc
	Q8vHXPLVy9DASPzHjoBrow==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a59c03q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465ECGxZ024807;
	Fri, 5 Jul 2024 16:25:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qc1c54-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8otQp2MTLZqatvACTJqTXW8unLkvVdp1mIpfZ7KiBES+FfXYD/mcm4ho+asBscul0iEByTeaPThibkf6dhV3d3e0An+nHNja47a+YXz/oz3UdYPe4vbtKrfMOx7dHOYi6dlfizHe7v0uMy6gTClRGh7uqk1TJWZbUb9/2V99Ml+sOXcuD1PIW/02QEna3OrbvEksmLGBaVggG5t1V80BO1jjEZPoq/IfN0/rdIhQPTTykie180eJK8se4TTCuS67qVcXzRc5YPBtFG+TOF+RF8xs3Jgk7Ma30v42z/JWAy/jP0e/IpO0tMwd3iz5MF9c9E88pmdhpqT1QUfpCTl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJpgAtqzqy5NPMAuN6MwKwGQVoR3/AfpA32R9j58sLA=;
 b=JDObkB7piskK/iLl4pFngKcQwiUx7E7pjf298NAw+5YtYlM+9CKsB9zi2H74ef4ux1bKZLDx24LJaB3q4LNurkP0FxQCzgK4NQ9UN0PvdMCd3Ci784UIGVzPRXCeE6rftHRRxkDyfgDGrZIgcWaK9L0Ts6KhiGTKtRXB4EomTW9L+m5sVyhVQx+Wc6DlxsQI32Xtj42tfgzl1aoNFE/v5FlzIkXsqY3bL50iYJsQ8wzAfTQzmzblCCa+5pPQ5/ViALy9R42h8HCRUS4Mvv8mezBNteICA6Q2Q5RFUfh18vq/mbFI8dwBFzEvf1s9dnwdH3Jr3J5LZ7v8zN4Z6ATfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJpgAtqzqy5NPMAuN6MwKwGQVoR3/AfpA32R9j58sLA=;
 b=T6mbIEphHA/8e69tLPFlIRhw9ByhwlTgPGgjy17IP5daZPC5+itD1NX6O/Q6/UoOHNf/NfHxlmQrMpKKwf8t+Ookw3c9Hs5TgJ89o1mp5/r/uyR4JCS7cXwkc8w8RvBQ8V9XW4Tock0LXcb+Jsrktw6Z8GkgW9yeMjc7qTk59o4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV3PR10MB8201.namprd10.prod.outlook.com (2603:10b6:408:281::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 16:25:25 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 16:25:25 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 13/13] xfs: Enable file data forcealign feature
Date: Fri,  5 Jul 2024 16:24:50 +0000
Message-Id: <20240705162450.3481169-14-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240705162450.3481169-1-john.g.garry@oracle.com>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:208:52d::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV3PR10MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 3343c02b-bd57-44d3-aca5-08dc9d0f137c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?WdgL3iXErbQDGWuMwpPI1MapMmta80EC13T36MwOo/qlnyMkSA10VWUVGWCn?=
 =?us-ascii?Q?4VXG1yfOrTPGDGmD9P0oJLzq1JuyyxDRp4Jij3Coz8AFUd5zvWecI//sHIwg?=
 =?us-ascii?Q?uYL66SsqNXwUxmvWntHBoUzaxR5EOhnGRwC3EQNMS5fxDYBx5Z7WKnvpkazp?=
 =?us-ascii?Q?uu1i+9n2w0Ui7Nj+ya9NYa28kjF7Q0xl/SJUE/HQvLuWvgTSuLjRK4Wndsfh?=
 =?us-ascii?Q?jC6/6L5jEfQwHiCZhTeZNQ3H24kR8qedGsrigmo5P8Ntb4kN/lyV8bQ5Zolv?=
 =?us-ascii?Q?TqNC4zpwDCUjeA1NH99jr4N3wJ8gqZAJ1+CCnAFXQtQ/XLIIIzuguR0BZLds?=
 =?us-ascii?Q?qmFRWwc7VtucOiMVtxB8Z0eymWtauwaoVN1YE91mJU6oogTraRiQNEgzXU7w?=
 =?us-ascii?Q?I5X3pVa75IU0ij+og9VGO3BuTrSrny/7VJTppwU6Oqh8aGs3x0AyYARiJLRe?=
 =?us-ascii?Q?y7Ih6IqBRuIaUDyHi0azbzaQENypY7oc2PRTvofEaoKOEVirK+vjI5H/+TsF?=
 =?us-ascii?Q?bUHzeGCG4CpOq5qXPNfzdih6ABSbucJU2ogyfA9NmVRTeCRv5NQ5dmLGSU+S?=
 =?us-ascii?Q?7Tqz8zdfMih07w7MeHVd+5XtTwiW0rL5KgeUz6p1Gyo9iO5IIhmv54aGkJ+a?=
 =?us-ascii?Q?7uaj7TEclaHenUqkthW9HGo/LHwuAH3TTR9IGBQo2vQ5sfSwpDWQ126cd4ow?=
 =?us-ascii?Q?7KjXA+3AW4ae+raF8i+04ZPkfjxKSPIdrC5gonM6/Ehl/Apeni7w2SClN5A6?=
 =?us-ascii?Q?gjPGQrlXmPwhP/6wi2QspwH4BsHI69DbEyEdXmBdA7fVawMgDWYaYZ+pAdFL?=
 =?us-ascii?Q?+675sGH/aPdhh/hx7xtuHZ2D4I6D2XRqnEr9GaD0Qp1Vo1HG1VmvUdFnrtQq?=
 =?us-ascii?Q?napI0QnLp8e8rtcmlcLO9gx/O26YOqfadkQPuuDfLs7XGmBPFWN0vxcLDQqW?=
 =?us-ascii?Q?jHQ9E21DyTGhIEcP7OtIcClvWdg70hcqLB46Q38a1NlXXsabENtkW2G/ygGZ?=
 =?us-ascii?Q?f6YTQJXk6Ymt0YCDvy1cmjU3rdqQUp0iU0TcxW5ZxAZgUq7G/Q4ogn69m9ej?=
 =?us-ascii?Q?8ATNcsORS2ePqTQVt/zaTcdQ8OR5jmVC43dQoBc7RMrfvgIwTBYdp9QuHMPU?=
 =?us-ascii?Q?QclcSKf2T2zefzrkAnKZTXzF/t1VnJHO94HAlYm394sN1ugHrPqnG8W+FiIA?=
 =?us-ascii?Q?nTkZ9ATXTcGkRPUUn6uX3e+VuWbzm3S8bkhsJgdiV9NuYwRXoPMJ/bjEig3i?=
 =?us-ascii?Q?racvEXfF/54BN3HiVcrxapE2DwFs5RfpIxSmAP6eLycHPeYHucdGGjr4x3Ns?=
 =?us-ascii?Q?k8OuNP19hUM5AdtkDwEG2chYfflqfMKux7goFT5GpeNBFA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yZQDz8zkiQYAIDVFintuZYgBQn+GHuk5Ar/GeWZgq8ex7dqF9uYAj8tVlmwi?=
 =?us-ascii?Q?LEjmRLUd0bbw5zHpCz/JYMenGS/oKpGmW8xxA58lwkRwUUo+fXLxOZ8pKWP/?=
 =?us-ascii?Q?lUY0SrZkLie2QV2flmodsSKkn2ncf0+INHTE9v6UhqxTmmHXD1dY/ktaAolw?=
 =?us-ascii?Q?VPW+UYqMD+Sslh8nivruyt7Xbc6ZPr99eeAYcLcjQcTEhXoBoV2UvwRRYHyq?=
 =?us-ascii?Q?+vyCXfNGZcX/pc+Ao8/IDQ0oIM9tkQtBRBLmZngPkvI9XZPsDSWwbknncWD1?=
 =?us-ascii?Q?cA6ZzVJjlSMBtKZx1TGNELVRCF1o3Ty3xK2fffH9z9yyoY9urQIsOK/F3DSa?=
 =?us-ascii?Q?t5q2Ep83AsvFR3Xj8DsYLtQOyz7HhKctjb2oYpUKo8ijHI71h79DG0j56Kd1?=
 =?us-ascii?Q?7NN0fnb6UZVw2fPtNwPyFE3iO8Nl6AB6qeh5uYiJScviYEyYOXGrrSiKeyzg?=
 =?us-ascii?Q?iOGt2B7WIF3f8jgQ5xTIGrIWjbs3hYMip1i1zj1ArtgiB2AQSvZtIfGPdYyR?=
 =?us-ascii?Q?tEBp/YDzzAj1V7FHTPC4Sii5ZmJsHIVAsDlreP8s1TPJqh8E2dPqo9gGwqDM?=
 =?us-ascii?Q?B2itpkwq46i9cR7UzLfr+wwyh7GkJxiA34K4hvG74edE+CGZELAA7g+Lotel?=
 =?us-ascii?Q?zaYhU6Wucy1hZIwcUGcaOtUb4Q9sil+ahH26fvrwLGlunnhzbZPtIn329MJO?=
 =?us-ascii?Q?8D30dRmMqT7lwIGqzc2a5pK4jbVHpmLg7SwtbQXVGE/7DY09SGHJ8mm7Zj8x?=
 =?us-ascii?Q?4ryCubkoNzrHWYN4rM8IBAbqtMFxWH8LdAxdudhJ+Hu5Q92E3kBqo5Ib8L7u?=
 =?us-ascii?Q?6f5kgDsr9MTqgMFzm2gcciKisATUcE9tDbEjcPYcrXTrpcPaFG4AXxH+TfIA?=
 =?us-ascii?Q?gP8Y3c7vLREGHUdKdyC+SREE+eIK2NwNDvBmSGQLzCJkSLe+ySMzI9sdUoUU?=
 =?us-ascii?Q?T7zNnpOYiWjg3RoFyjfBbAjju/FsH8g86mPtcOine25kstQf966l7st8M7FE?=
 =?us-ascii?Q?gS340tuSSbIC0DgJ/ffxYsjO2vh8ehduJBMo4UkzbTKzXQJpEkMDhvaWJ8wa?=
 =?us-ascii?Q?UQishtdlegUvC1iBbn9rbaKGE/u74Msw6p9GBb6ly8tisUItVXI/m5VTmCp9?=
 =?us-ascii?Q?6YwdWq8aZu5Bh8G/K7n0CS1jAWnh7Jx6yu/BM3JHIjfqYokrab99KK1dhybx?=
 =?us-ascii?Q?LlUVxpLyb07IP00rH3S0MnSgDwcp54xhosK7g/oZ0/4CwH4a/peHpho3OGNN?=
 =?us-ascii?Q?h/vQbh+rqhJAFfU/z6fVtAExNQkvFr148oBgIkEuaTpe4wun2SM7JSFnm2s7?=
 =?us-ascii?Q?RTO1NempVhvWbHmT1+jbF/hwlnQeOdCGo7jpAIXJ/wSEWpt2yXLpec9Dq1Rw?=
 =?us-ascii?Q?Dtls8Z9S9oSTO/qe+I/VM24i/hKW/g13MtjQVSI6oQG1ydARjIav5cYiiTaO?=
 =?us-ascii?Q?OubSUic4F4RSZCOZ8jZ5IK16i2FZO0PEe3zROMqtM0CQAieJDoBRq3iK4+zb?=
 =?us-ascii?Q?8iqyPJE7sKF/hBkIIH9LpbfheotBXDLgVSb7HvIVohnzO+8RStdeUaO9T878?=
 =?us-ascii?Q?ipRMuYQdbJL2RLPvlrsVt+C2ttwgtM8xwLFt+uo+kqB1fFrt9EDqCf5NnsBU?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IvCT9fqb6C0HW9wINmY1tc5thfU7VCiYkGU1dWx385Oofc99fxk+FgHYYkQu1GcipaQ9mETlX0mTC1B3QL5vreJPXKiJuciGiMHcN34x87Ztd/HT6zL6/JwnKWA1V3ty+wvlZP6c7mqNicRIBf4JW5mGP5H7/bhlZQhpu2zXAo52+zrWsfR/8VMoGtAgyNcUK0VL3+juWXYYfmzSroj0diEpNzEJ44deSJxLuPAtLO7Kk+Es70ahzqn0rpzmop+rqVvDAHoWCu3DBCPnaCV2bj2N3fPesRfFyZreegPM9n1d+XeS6qSODx4WuqALMXvqXpIaOCws0Q98q/cqn5rKCNiTmDP5SltSgZh00g/RI7FFXsNG+uitq2jOlqAGjP7Mda6FMaN8K77TuhZkU0AQzHzLIfMe3QdF9fOd1iDKuj7HcGhCwBYXV4TFdoHRahad3jri8DGV5L3jWPHUU3SteV8FB4vd3fRB9aATbJPpF77YefSpNaLd5xLfGhfsG06xCzGcrV57F/PUELn960ewFNbRtQ846gWtZY3IdBmSchsPFgA/nMJUkhPSyCr2NyEht4haG1dwTqpFDPQZdZ2x6+Ll+MDZhUZr5T1YNF7QoFc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3343c02b-bd57-44d3-aca5-08dc9d0f137c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 16:25:25.8452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PcdhYjfWgfEbSj6Uc5sjGszcJ7ylJUE7iwKsB6qW1vWMAlPsgYWiO/xkadVx6K0zemMhZvTs1KrvEI8mktrWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050119
X-Proofpoint-GUID: qJyWGNfNNjdBw-BN3vWvucwWkJREvoJO
X-Proofpoint-ORIG-GUID: qJyWGNfNNjdBw-BN3vWvucwWkJREvoJO

From: "Darrick J. Wong" <djwong@kernel.org>

Enable this feature.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index b48cd75d34a6..42e1f80206ab 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -358,7 +358,8 @@ xfs_sb_has_compat_feature(
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


