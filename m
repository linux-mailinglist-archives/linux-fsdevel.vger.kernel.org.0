Return-Path: <linux-fsdevel+bounces-42984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DB1A4C9CC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67AC617557A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C9C25D207;
	Mon,  3 Mar 2025 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZsN4KRjz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dg7VEG/1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2421625CC70;
	Mon,  3 Mar 2025 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021945; cv=fail; b=KPBZ8PCcjw4Dk6Vp9oI7bYYOySEyVwqJKtJKqQhWX1EDoe699RYCRIg1qcgmn0ZNU0EI5baCb85snQE8zI4y65rlCMyrdOz7EsnS58SXaxgnmeLDGiC7ZFe662VKIEhn2Bz9Bw5a4nV9THt3MXGdQZWhi76E40+lhR6EKUtL8mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021945; c=relaxed/simple;
	bh=u5NgwwPOkP6fmlznjI6Hl19OQXI5eBVU/Yig+LrH9q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hfRilwI6uOgeh1k7jYRGDlPGFX4F80ZTgr13CP7Qr/jXPIStRe3qYxmbZqN001nEk3C8tNdi4GGW9i1VX1R1nbI/5fRKfEhFIGucwH2iXtyLlqqUUjTOXXyf9u//ItYCkSL3eddXc7m6XyKvU7ABObRGHbGEjPWYrYWMjzfnIxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZsN4KRjz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dg7VEG/1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523G1VZ3030062;
	Mon, 3 Mar 2025 17:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=T6D5YJX94gUD2AkSYT464ZF5Zew3sqQnvZb7IqSaIGw=; b=
	ZsN4KRjzE7azj0ickRH5WbJrJQEouGs/XUywv/4Lw1qV63b292SeCjMuY3R5/paC
	LXSL9Tq26cLWiGGM6BNDaqpLyY7WjT1tV4kcWEdmqQWTfmUDgQIMnE91RV/tt2vL
	GL2PaTXxi+K6CoOEtYIfaVmTEmGoMwnayvGWr3tcsMHPI34DG59UBN2NhVUpenqh
	VIMJDUNgOlcRzG+hZIFILs1RDqJ+AUiaK/0Mv8RBfff9qnQhwd9XIOHzrHY04gh3
	guDhDm7laMNvEU05Czq0bj24qtEwwq4YDTLGHMO0wYY8BwU6GyZ8UZsfPiXOQTQe
	Xw4/BGdNnSslZfVsauyLAA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86k61p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:12:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523G0Ji3040320;
	Mon, 3 Mar 2025 17:12:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpe1fmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:12:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfSzKO+K2TsagkJnQr87B/otFGfLZTULZBceo2u6370ZgQimbq+Roue+b0FHZg2E7AkL/5lEF4SU9mWmrLyaKeqHKQbsFwnqQH5YS/RzmAtLnxVP9zfcQ++GFHDIhraLqIW8G3Xnr22WGfFCTM+5ugrzw1K/G5SWO/0fMwQ71T1y0e+7fUAk/Uoa32Ih6C4sW53h2Gs/1QcO5QS0ANHem5Pwyuv5gi9//lFovWONTG9oz1L0CSXBIwcVcD5hMUD2uFgja/LszTEFyL7Y3pQ90tpkHm1p0U0K5a8JHClGvrEQlpugfE69Z+Vt2/aHbvgM0+hsE+h5gjad9+HVGy3RSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6D5YJX94gUD2AkSYT464ZF5Zew3sqQnvZb7IqSaIGw=;
 b=jrvp6ht8GFMQpwmgu7jz2CXR0RsRsM6WR5JxOFsffKieYrPlTVomMeChY/wqVm/MxDTo5Kc64XC/WF1/boQKeiva8lERBJ5HrcpVarBJF1R1EjDT1gg2Jf+1OzyA6/RZX0U7uOdKxqa84brVxcBr1+SvbN76jh7JSDHtD9CFdhBEWcKyQT8ujSXt3eWmQm6j5nV8wu3BrFDH+uBWcT9E6OftOWco5cpB/xSA9REfIdXrLDK4KjeiD14xYpBS8wVlRSWwYD1XNKSun97u4lox61BbGENrb495BEG81mj2AXQD4cF5GE1+GLUeLP3DhBVaYWpE6CmD/ZhZjg/ov4mrqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6D5YJX94gUD2AkSYT464ZF5Zew3sqQnvZb7IqSaIGw=;
 b=dg7VEG/1dnYoXlnfL9RwTi2Y+bg876SvR/gzvHu0bkHjhFXuCNpTplwx2Bc45scP8J4YEU4kANRWo6g1m/0QgqXXK/acNLKo2RUGWcHKMO/lQv+Qpw4HEOIN1DFvhdg1Fd34L7JO3ZElM0A3PZLoMqTdV92VwJovIQJo9M+O/8E=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4696.namprd10.prod.outlook.com (2603:10b6:510:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 3 Mar
 2025 17:12:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 17:12:11 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 11/12] xfs: Update atomic write max size
Date: Mon,  3 Mar 2025 17:11:19 +0000
Message-Id: <20250303171120.2837067-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250303171120.2837067-1-john.g.garry@oracle.com>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4696:EE_
X-MS-Office365-Filtering-Correlation-Id: add4fe4b-10fb-4ebb-cf26-08dd5a768919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YoRvJ/7nvlbnHsS6ba+ltdvdaeeX3MEuNDKTEmeY+w6rjdFMXtLN3njxX40X?=
 =?us-ascii?Q?seZRk96sfHzlLtDe4U0WFB3cdgvRf0dWXvdNAYb58Y/ANMkHYNyAdjkvoU4e?=
 =?us-ascii?Q?ISdET3Y++cv/wR/PkGyBVcI4xeGXQ8uzmjq7ln9z+c0Nwa3Mo2su1WEemfrO?=
 =?us-ascii?Q?6Iwy/cwo6DGP3OjlRguxe1l/3ggpNtCWarz395qLGCofF6GC2LMc0dLALljv?=
 =?us-ascii?Q?XZ0CmvAgzomgbOecdq6P2qVZnWkmwofKgl/ZT0z80VaE3as9gseJPyQ9d16Y?=
 =?us-ascii?Q?uadttiZDjcfAc7X+Pa1/aua7nmEUcVlvA0FqLO7TgntZEvvMMUV8+VTWb07Q?=
 =?us-ascii?Q?Dit76PRoWkZ/6sJ6jdwRnzMFt17JWEba0RKX4fyDgljB7IqSbVBxn4J1MRSF?=
 =?us-ascii?Q?2VRqNAwrIz8arPDPD1Fb+r3Ke4q9nmQsdt8OH5YAu1tLAWX1UTgRrsD09f1R?=
 =?us-ascii?Q?YN6XRGwhUSA8QKgYE5IcwQMtLuZX/DsdrBaT8yEiyFW3lrk9yOyGfY6gjMlS?=
 =?us-ascii?Q?LU370pp9Jc+vu3Gdz156yGS2pQYxMVTPZcb1hiA0hrVc3yjKGZbNSKPTw9it?=
 =?us-ascii?Q?N5NKNZaFQVoEZ+ArC21ag0OgRnHMMVDeltji/70CdqJ4gdQYI99VVIPHN1R+?=
 =?us-ascii?Q?3yr8OUkOSBwTi10tJG2YRTG5JyDDrw2lvsvWJjW2LLpIrUn8XYL9q0WnnnvE?=
 =?us-ascii?Q?UkwnRFDOI54h+T++FcDrJVyG0bD+F+jNsEib953J2nGajdquprizHkh20AOf?=
 =?us-ascii?Q?rwC7CuCAqy5+RtGUG66dLuNe2oqVWf3hjH4SLKUh03vZnrhgrO624Exs59Vs?=
 =?us-ascii?Q?3yckoso7gM4rfdvBmbrDmupYv8jahERDDk1ISd1InGBYboHsFhuLXIFK+Zl6?=
 =?us-ascii?Q?wLzbeDkCVN1WbHTOo+LPgCDu6/2rQiRVHxbE1BRgIMxREboweRhHrNgA3u/A?=
 =?us-ascii?Q?/7Zla7yzT3EubFznhwCxLbNYiha+M86E7qviXkhe1rInk3JmGlQTaipaFTaz?=
 =?us-ascii?Q?oAgcyxL+HjXcfEsAnqw6DT/ZJsPpZ/4i8Er8NmtVNhVVBTwB5wQC9GgdNKR5?=
 =?us-ascii?Q?Ognj1J42gLV2tfJrd1Y04fDqVXdxW5/VN7xiFb/H1M+wKrCQzD/pCXm3/TO4?=
 =?us-ascii?Q?jwe5fe5jTvBvrD88lorUL/k7ikXcoloXXWP8QYIql7TJORMHoWkN6iqC9R+F?=
 =?us-ascii?Q?phHhcWdMXSGrRVOQ16+uS02aVD0YY4xgCUNXjjvpm37kaEwv2m861kPKodpb?=
 =?us-ascii?Q?276J3SfQzCnodPePfMnPQl4KkjmjCL+cHsrsNlpgvSFqFHHjKj2lnL4v+h0x?=
 =?us-ascii?Q?WD5OODhuZHOrfmxXJjXrkDAf6R7AJow6xGIGEbX+sq4hu+Do4kJsM0jxu37M?=
 =?us-ascii?Q?nzwmHJMEDktBNkdix3vsWH+nyImo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+DcPwvDnEbzSRn+o5tuNRWBOYXcS2T1/7NvhrneaU+XgrH5xof5nno+LQZ4c?=
 =?us-ascii?Q?kcwr+7QqFtsiMsxkzLDdg0siFbyHTZeAdzCyGPitn1SkElFZJCpxOCvmKi27?=
 =?us-ascii?Q?YIutZY/UZKTu+c/dsojLUSk6Gq/hMyeWM/SsrMJVdQgktXHy2ITQL6mkCVtQ?=
 =?us-ascii?Q?5BqwLqKL6DK5/VvyIdcWD+9EcSINjMrufvm9ikq2BTEshHj6XKvLjx/dYzRG?=
 =?us-ascii?Q?gaR4dALqVGwg4ntaUymPK0Bq2eDEJKPzE7pCrJOGD46zq22Q1hpGg/NwdBe5?=
 =?us-ascii?Q?mnQdJ8Ls99/a4akFYxl0a7cTWtCOz/Ww/HImYNyu05Q7Xw6LV7uwFlG4jm/T?=
 =?us-ascii?Q?+DcN028NJAA8KfpfG0BiY4rII+XpTFS1rnx+iRT0JcULskebyJyhzqs8M/aX?=
 =?us-ascii?Q?sm5u406bRoNB+0a7EH/x05lrNjgsJRMiVRQrl79lHwZEq4oEWyU+WqqK4z5w?=
 =?us-ascii?Q?BK1BEmuwV3LnPctbYzHgbGArHFd9tX9JwCcuDanMArzj249yXZcDSQunTKR/?=
 =?us-ascii?Q?mdsLyepwjtkBNLAky1bD+nmwz5qUs/zep/6QqObvmbkO+P8mUrrZZpR7iNf2?=
 =?us-ascii?Q?tk3B5YK6gQnhMpjsR8UsFo6d18QU3qDs/pyh3RwTPzHuaGOJrsCPb0pAauQg?=
 =?us-ascii?Q?/9gZhHUbYc8c01+sY4XMgo8crV7i+L+S5y81Ene4APFyhz+YE1s7t1Fk5t1E?=
 =?us-ascii?Q?hR8dKJCsu3l7dWfo2RNmnPmDwdnMMYLIAyZe/X7ggtpo0LcG85BMmR1pgTNr?=
 =?us-ascii?Q?S47LIEaIVuRLs4h4Ar8HO2Hk1G0qdQCJ5X+OLLcO3nsbPGj5v5xyMNfi7qmm?=
 =?us-ascii?Q?WXA0+XAduOHSaUjRfeh2HHwt3hcGXoRMFTRVSZAFFvFOwCFlS6fQlRUhEqCj?=
 =?us-ascii?Q?yp0TyddAVxkc1xYctnfkdYeN2l7RUYcXFEV5GeIR2OFmw9Bn2SCLzN5fbssm?=
 =?us-ascii?Q?u0ukslWirExPHQqJPnm8fALKM8LsT/1GmSl2pxEDAuQyO0iKNqH+Za9yT29X?=
 =?us-ascii?Q?FtR/iga357UUKa5oHx5bj1TEkcn5EL7DBrYtnU5QVQGIacq7NUjshL/VAsaK?=
 =?us-ascii?Q?Tn61Yo5MEi3ntzn/wPFIIjxC7QWrtbPvn8qPQbT3iHnqF/90SgXdckziGnY1?=
 =?us-ascii?Q?gQs2W6nmMTUMD5+iSmNVzpN2bcJCWj2mXdUd4L4G3xk6nYgBs9gBx+sdUs8G?=
 =?us-ascii?Q?XJg2rJ6ffdlneCiTC0AXai855elyQxXAm8bgwvUBvgmlt+HK8dEDDcX5+lAr?=
 =?us-ascii?Q?KTuFudxVoGkcpe/5UwXGxh6Owlgnr65pSR9M7ySKf4SDl+QlplptuiLQUev6?=
 =?us-ascii?Q?byQmvkcEpzRJMVivVo6EHzbZqx4JSLLitAB/5u2rY/Wo8pDlL/U73Z6yKO8I?=
 =?us-ascii?Q?8vCpa6JFocyI0NriMs+tTuUo0aVUv2nHaMKs4hJXPwDywIzxprdDoua6sc8d?=
 =?us-ascii?Q?qlBCNneh/XQgCuvEXfbuRMBfad9QvLruLaZTcJk9yvYWuMwYu868/+y1/Mki?=
 =?us-ascii?Q?KqTuoXKBVoCFinVFeOCfvxgDZsD5kIM6vZeC0Ma1i7HFQ+b9i5XL/pKh7Nz5?=
 =?us-ascii?Q?RWSf/UT1ciON9hNqeydp6mIXn2KHAUV6O13VYn+Opb66mz8HgcZbA/KEk13x?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q1EUvZ1NNatf2WGGLeGhm6Xxsrav+7nPxAsD7GJjLy/NB+7pO0jBR0g1bZqwXSVAcnOj8B2hwD9LBQKjWIzsOCZP0tV+SsPoLquli4hVi7EQeBQwfo+n1dy090aTrj/Q8faD6wklsQ2VIYvcDLhlEzq7EkuYGy4v4tvViddFKJPM5HeLjMIX5ODj4ktExBxVeBilKvDsovSQKPSM2EvJwRc8sE3bbES/Ttr2X2c9W6nq2jqY+wyHPGfG74pctLXFMFIRRGhFYx1jU5uUaCVFlkL3USYfyCTuJKxSsKZeV/kSj66Nsv+Kwj881aaxJJdJGTSdw9pU7cVWA7Jo45MBWUzp0LmeQ+Ws8sxFNpUvM6A71B9FMaXwQDBVZ+qLXjwD2zSm1O9LZWoCVv6Vm5dCkeLK3hFbmEFRW/M1BSN6Ly4Izah40CwzXpgKR2YolKYt+8BIt7SgTlcRVPEZrmGcBMIu8eWlmOtubDyppU58ssxwqo4yyRQNqliyuyEXnGihyqcqMRQ5FBx0fFpouoaRSz0UpUmDChLRl0yCOS0rJVbLUGNifT/+/JMt/ZQgWSM7DFvDotkZxvh8ybyWdbeaqbMdHiFp0y/BQPhUsWdWons=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add4fe4b-10fb-4ebb-cf26-08dd5a768919
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:12:11.1133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: puzkITM6aoz8BIO9kLdHW3U8pTFuHxRagQgZ8N/JUdLKV+11J8L36zm9klk77pe8Y5YjBxcey+dK0KCUqw6bTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_08,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030131
X-Proofpoint-ORIG-GUID: QkwRyV3IMpcp6Fs93wmF9SBtgWljuKnL
X-Proofpoint-GUID: QkwRyV3IMpcp6Fs93wmF9SBtgWljuKnL

Now that CoW-based atomic writes are supported, update the max size of an
atomic write.

For simplicity, limit at the max of what the mounted bdev can support in
terms of atomic write limits. Maybe in future we will have a better way
to advertise this optimised limit.

In addition, the max atomic write size needs to be aligned to the agsize.
Limit the size of atomic writes to the greatest power-of-two factor of the
agsize so that allocations for an atomic write will always be aligned
compatibly with the alignment requirements of the storage.

For RT inode, just limit to 1x block, even though larger can be supported
in future.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iops.c  | 13 ++++++++++++-
 fs/xfs/xfs_mount.c | 28 ++++++++++++++++++++++++++++
 fs/xfs/xfs_mount.h |  1 +
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ea79fb246e33..d0a537696514 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -606,12 +606,23 @@ xfs_get_atomic_write_attr(
 	unsigned int		*unit_min,
 	unsigned int		*unit_max)
 {
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	struct xfs_mount	*mp = ip->i_mount;
+
 	if (!xfs_inode_can_atomicwrite(ip)) {
 		*unit_min = *unit_max = 0;
 		return;
 	}
 
-	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;
+	*unit_min = ip->i_mount->m_sb.sb_blocksize;
+
+	if (XFS_IS_REALTIME_INODE(ip)) {
+		/* For now, set limit at 1x block */
+		*unit_max = ip->i_mount->m_sb.sb_blocksize;
+	} else {
+		*unit_max =  min_t(unsigned int, XFS_FSB_TO_B(mp, mp->awu_max),
+					target->bt_bdev_awu_max);
+	}
 }
 
 static void
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index b69356582b86..c6fabf7ac506 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -648,6 +648,32 @@ xfs_agbtree_compute_maxlevels(
 	levels = max(levels, mp->m_rmap_maxlevels);
 	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
 }
+static inline void
+xfs_compute_awu_max(
+	struct xfs_mount	*mp)
+{
+	xfs_agblock_t		agsize = mp->m_sb.sb_agblocks;
+	xfs_agblock_t		awu_max;
+
+	if (!xfs_has_reflink(mp)) {
+		mp->awu_max = 1;
+		return;
+	}
+
+	/*
+	 * Find highest power-of-2 evenly divisible into agsize and which
+	 * also fits into an unsigned int field.
+	 */
+	awu_max = 1;
+	while (1) {
+		if (agsize % (awu_max * 2))
+			break;
+		if (XFS_FSB_TO_B(mp, awu_max * 2) > UINT_MAX)
+			break;
+		awu_max *= 2;
+	}
+	mp->awu_max = awu_max;
+}
 
 /* Compute maximum possible height for realtime btree types for this fs. */
 static inline void
@@ -733,6 +759,8 @@ xfs_mountfs(
 	xfs_agbtree_compute_maxlevels(mp);
 	xfs_rtbtree_compute_maxlevels(mp);
 
+	xfs_compute_awu_max(mp);
+
 	/*
 	 * Check if sb_agblocks is aligned at stripe boundary.  If sb_agblocks
 	 * is NOT aligned turn off m_dalign since allocator alignment is within
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index fbed172d6770..bc96b8214173 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -198,6 +198,7 @@ typedef struct xfs_mount {
 	bool			m_fail_unmount;
 	bool			m_finobt_nores; /* no per-AG finobt resv. */
 	bool			m_update_sb;	/* sb needs update in mount */
+	xfs_extlen_t		awu_max;	/* data device max atomic write */
 
 	/*
 	 * Bitsets of per-fs metadata that have been checked and/or are sick.
-- 
2.31.1


