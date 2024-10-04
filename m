Return-Path: <linux-fsdevel+bounces-30943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8CB98FF92
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 11:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD23282BBF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 09:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94DF14A605;
	Fri,  4 Oct 2024 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PNYxxMSM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eUyBsRf5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8433B146A87;
	Fri,  4 Oct 2024 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033836; cv=fail; b=TZ0u/tiJHrS/UbujTd+4SoLH03AmVV7GWaXKBP4+EP9U9VUr2Jpk7FPIxDcD1aYdw94sOXDMWfU2Kg7YAtbz1uRc3uCJvM8Qtz8dooRglgjzTMlu3SV601+2/z22oUSRLV5yt4NFC//tY/9bedzQEbYcc9KwTZPxLUBFIrZceos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033836; c=relaxed/simple;
	bh=lGNYrri/HJQPWknfrvKz2k+CBLT4mLEvBM9QExasZm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FlAhE4EJAoiJZ7M1PM1T+15bJBT/ZuccUXumqfRdFEjXoKUteBpugkswez2vknFgks373KRHJ+ZKmRk+1QLEBKzcniG8OfvVQB3ALoRutDW3RZnDjznSREjZ30q3qa9ivOnMYuB4psT35Dvl7HnipGnTGhINZSri4kf3Hquss3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PNYxxMSM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eUyBsRf5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4947tfDo020700;
	Fri, 4 Oct 2024 09:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=uupbWVuUYeTpbKkf2Bdo7HW9s2UUsk1y4e/cYsxtjUk=; b=
	PNYxxMSMMqwJJGJTxfOPCt/d58v4wX+8vjFLNXUAJXs0vfcTCeobX0jSkjRiQZIL
	8iIsXUK3UXV9FjnM9J3mAuC7I/NfY/WUoM/t8tmXNT1F4rAv9l6N7J4y1u3QhcaU
	ohg3a2xsUraGdAw4ttp5hvJ35lHVBwx0qnHeE08eKXSMrLYqbTHotebPUNd0hK2r
	UdRN65LHtmUiPFRIK/Q1jLo508ZqNjMOCOMmaL3K0mKHZhjAre2K1egilOJ6AOi6
	ZVJjQTHRwtk1OLwty+Y19WeFkQcl/aicmI9F+ry11Km1hlUr3pfMDD1GOHQQgYmR
	zPb5KbbFazDOEoo7McHZsg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204996wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:23:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49495IE4038110;
	Fri, 4 Oct 2024 09:23:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422057118t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:23:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7gkixfP3gLcUrF8qe6EQ739+g05uyOo4kUCsLm1eUxD9HCFVxKsl38+Ebeu/T6sM85BaRnpB5muyFS4/9tJo082230sSiipLckzOUzgPDVIzhx4sa76uRLYE3fMsDISUhQbX99LlIgM7ldAmIJKd/ioVa7nOv1htfflKe4LfZ4pAtv56mRlAfHYS0rlGF4n8z/UOguGdKhh9uqYI4/dyIvcv17LP6RnB2oRgqKEJwrQYGmZIhm++Ktg3PJpXNDSu1aKZi9hmqXUwShIDkQ26j4aKGnUUte3EuEiWaYwphmKHxLJSyq6csBeN8jqS2ED5FMkKW6lBPsmulaB+yxxRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uupbWVuUYeTpbKkf2Bdo7HW9s2UUsk1y4e/cYsxtjUk=;
 b=DtK6+3Lyz0whneLumrLLBMUbhv+fhP8XABNUSC948uw+k6L7QDEY7giifJfPqVRMTLwmnknwaM0E+8HIlesf9xOY4pBYRaXGNRQ3WMV4kgiTSptqQ/GE8HlrvtKPCC+Op2JecL403c0Y3DDmxwtkUxG2Pw0p3lmNvssE0vPxvq3TObGz84umCSJdFiG6uvXdhrsh0SeInJFAxlJZ3F0LipHT5L/8S6mnbvMQ2mO2WhTW/rV5Wnlb20F/DQxldHNyNXLTERtCg2eoXnmep8rD0vcCxorg354+9saJHheccSi0YGN6CiH9fAIcWwzEhfDcmVdl8ZhsKwOXx4UaZCqUGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uupbWVuUYeTpbKkf2Bdo7HW9s2UUsk1y4e/cYsxtjUk=;
 b=eUyBsRf5EsSqo9luzHFaPJQ7Acvw3g/NKkldbj6VE3CV1qJHxTBEDqWXwzswzhHHSo7xvrfshKvoqql6ENR+lo3SFuPKbP1u5KI9EQ3Qk19xfu9zYnZIxpMq3Xx/YevbYhevwCBjZUytBisl1986KikdPVwj+00eCkqRDXUhBD4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6900.namprd10.prod.outlook.com (2603:10b6:208:420::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 09:23:19 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 09:23:19 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 3/8] fs/block: Check for IOCB_DIRECT in generic_atomic_write_valid()
Date: Fri,  4 Oct 2024 09:22:49 +0000
Message-Id: <20241004092254.3759210-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241004092254.3759210-1-john.g.garry@oracle.com>
References: <20241004092254.3759210-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0558.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 0495a590-fa2b-4278-621d-08dce4562f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5rCHPZjqaQ3gcA1tuWS8Q5vVziXHT9BhtgcgE0i95tb9AhERj7eV10UDOKp/?=
 =?us-ascii?Q?i76yp8yNQm8FmPO8nj/u/KAOVxQQPwM8HjuOQrYV+k/2oRXCPQqZZz2Kii2Z?=
 =?us-ascii?Q?BJRNEPFjmSICOmq2RTs4waPK/REhMF0LSKQ6GR8oCmVNzCADGjEATDdcHvIZ?=
 =?us-ascii?Q?eb3fogiTsGVP7wO7eSRBMJwnZr5LCHnPRjosD0Toadphq3y5Io5P37PDs16F?=
 =?us-ascii?Q?TD3UYwVVjtcLIi7m0r6b0AtOdgd6op32DJjDUG6RIKsFxNM47tLGvaM3Q4aG?=
 =?us-ascii?Q?/1HAy+ZAklnbKRAjks6r7neRYAKoCkMK2Cjr6F+jOqXW7/JbE/m+rZsv3DPo?=
 =?us-ascii?Q?SbAYpR3Wc40AlvrhuNONJ2Lve0S2dBITZfJTxvpa49AuWhOb6HKjd6bpWOM5?=
 =?us-ascii?Q?BZpOPZk1GO4NLnLDI6C6HI//oS3r6ZfBgEgLSLdY1FCV9eSrFJ4N0H3X9mml?=
 =?us-ascii?Q?r7o3ZHM2ZcNagI3y1dAXYaP0+6QVLIlFnjdTtX6h1A8fCG1rp74XsAoWOqQy?=
 =?us-ascii?Q?vc9nvoKZQEfbVNTxj7Xd8B340AfTJwEy3Qt7cPpqNvpzTfbGMvMH1Kf2ssjZ?=
 =?us-ascii?Q?UG/cKJLnzm1roOwju7HV0PGjWClFy9wWgmmfBKYLc+6tBejoeGSFgC1D5p5Z?=
 =?us-ascii?Q?4fMZ8g3BCnZyAmLNXscVVzs4M0pgc7KkVzWubzuHYnGgjMVghmFWhzc4MwZz?=
 =?us-ascii?Q?8jGPMHschWWqqiZ2XjOWxKKXUhhTVPmbKKFmihDzzfgzU9pXbd7CBfIf0oHV?=
 =?us-ascii?Q?h3pHXqKY4slHm1132YM5T9vD0APDo322E6lbtXdFPODii6eQuLzhyxUgdDvd?=
 =?us-ascii?Q?JMid5RPPetz7K/Oqm9KNrEjblVArnsoR/+ICF7JiqIDULIV9SAYvYRQHe2bY?=
 =?us-ascii?Q?fMdDIz4mji7N6igcuxk1xqFH7AJmYceQMR9w9n+OQfHv8P6TztU/jUTxnREy?=
 =?us-ascii?Q?UUgdtuXVFRz4oZ80yQnYFkiv28v6xvOvRCmMtqluhA0QOys3pfxuqg4QQv5T?=
 =?us-ascii?Q?B0IF6iy/TaiwGMUtDpgk7hSV2qvdCorHZS7eUgY0J1D9XxqSCtWfmj6d6XYQ?=
 =?us-ascii?Q?gBb4gHMWr1PRu8c0+cCdUD6RxfRIn51k+RGFvaz5RFT4lNF3UBRJyBK27KzZ?=
 =?us-ascii?Q?DqGl3d1dSO+o455YZR/za1L1LvZi2iI1sG5nJg0s0axATofP+pYg1UTdEA5m?=
 =?us-ascii?Q?W7Su2GkNp90iAyxdoXtpY66YhtksCNf46sSooxvnHl0jb+EWe7c1D626oqRI?=
 =?us-ascii?Q?LfrXpygLnf5rWpqtUbUN25zDttZLehuGn19XmF/HLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0E4jqGLrfAkft50Qav3Vr2glt/KubXNJCx3/Hx9J4FuR3yn0kTb6YLjFlrxE?=
 =?us-ascii?Q?/F6h1YbOThvxTOeFy0ZrjDTCDsPf6WeJzwtG3QDGqyFKTeqTaqbl5W+MRTMm?=
 =?us-ascii?Q?q2DZ7CehYZZg7shbJMWkJHg/iHEw5a2UZeYBjQ7vCLeUGiZgY13cWBLFYmNA?=
 =?us-ascii?Q?PbFVUIRyny5fq5R6DXjGtefyBTidFKD0GSf4DnTe3wnFVBwwqN6slmzY6mVm?=
 =?us-ascii?Q?86WTbZI9W6raMi5J9WLiORg3XmhhN1If/YYkv1KBx4TT5vJtJXitkOGiY3W7?=
 =?us-ascii?Q?ol8Muv6z3+0NXdsSTHbnCqeIYeQe1aVj8FWzNNMjnEMOw8Kf8OS2R1h0mdQU?=
 =?us-ascii?Q?CeR/2c9lLYBuGrlaLyELwKd9KBx2WxS/im/nqL6WF+ZrA8SiSti41n8VXewp?=
 =?us-ascii?Q?xUlQTn/xXLeTIeft470+2DsXwQdM4CDYBkHkvrEFF+yLfnIle88ynZqv3hgy?=
 =?us-ascii?Q?SQjWFWJP/slO2gQMLKuurpjkvG5gGGkYPHWiAvI620WJs3ArGDQsDiG1B6F8?=
 =?us-ascii?Q?em0Ow6PGPAXF174uSoAXkYpSUhAq0um9CTbdb6SaOkIzqEogSCZlVrbsT+n9?=
 =?us-ascii?Q?wUXC8l4olTMLMhxH3xBiJbUrHma+1hW9ySnnkKnwrX34OUocQEI4hqLEXhAW?=
 =?us-ascii?Q?vSi02Ob3Fr3zT+dxhFi1PFDZhjbVXd8zLGy4/MP9ru+b1gC/dsSq53rAizn4?=
 =?us-ascii?Q?OkhGAfMW2lRayMjjDJs0yqoFZ4dddhK8VL9+QES+zxcIY2hhCvtjCmKkkPVk?=
 =?us-ascii?Q?Iv+lpan9wpw3d+2DPekW/FGJ2yEmpFwSzuvSEZbNGwe6dYJCASdQu+BraVwg?=
 =?us-ascii?Q?nU4BwolHAdfjzXiSCAulVEaEPBM1wxv/0/klKXfaXBHKTJPXjs7HHyPjw/Ey?=
 =?us-ascii?Q?Xe6oi8D63ELikHX4p9A3T/R3Uf/8DOi9tQ1NnWObUpdnv5916rjte9O5GNps?=
 =?us-ascii?Q?KUB+NzPK3IPwQvnaF/oV4g1R/TUyQ8rqYLe+jPcNJo7lOxdSnT1prADAa+oS?=
 =?us-ascii?Q?Zlfciy6ibDzRAj9Yqcm5fSyMzB+8oZ3SYywmJ1YL/bPt3je+55lpbwV0PsY8?=
 =?us-ascii?Q?06seSoVVZUk56694mYBdJ11tbs5s6fJpuiDIa6wFsbK2YLX/ZlWUGvYWUit1?=
 =?us-ascii?Q?XEQpgHo7lrv9ZYCegbmORz/I9yR0zCwGD+L4GpkvPM4TJayvIgQUGp9H1aM6?=
 =?us-ascii?Q?ALHnlp/dFYqyqaxrWpOpBiLV/YmScFyF3jM6k8dXeWzp5iybL1T0f9A3yxPR?=
 =?us-ascii?Q?JFCO162rulON9ekN3pk/59VuixSyiOckg8zezWgGUZVWVCW/SBhzjUfbHusU?=
 =?us-ascii?Q?x+crX5GQnqrRzppHy0yMJmR2SPg4ZFZtHpv0RM8JilROkFGXJqY5RuQdYAQc?=
 =?us-ascii?Q?d52lF1hoj+IygUayPBGdIw3KcOqTeBIDuJg7iXXjPeQB3VqAdO2p6C5HhrRx?=
 =?us-ascii?Q?7RYPeDTN/+CLV8nZfpDSOjTAQyZYMVyzy22dy0ktiC+oNtv/R4jyStMo5NpX?=
 =?us-ascii?Q?D4sFc62VONC4d9/rBiJX2WIt7X6qxsUM2t9MKvnJAwd7qN8Cq1KDTMjk4SV/?=
 =?us-ascii?Q?rwHKQQCnfuC2A8WRfhspOrqxq4mkBe9/bgbAyTPzVx/rmTzta3S6Mb0rEUXp?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WcKSaRCSmjBbZe5BrnPemIc/m3KXFOFG9OiIObzlfc5OnlfSECAJDZFU5lc8n2b3w8czIbg19LouhHnKqiWgeZw2CMMaReaWDCCmgZrLaH/JcWHt/qQ/wt5EY+9TPekWgvG5L5r2aO9GNXxbZDKdZMPHTRZ2CjABkcIT406C3Rw0izxE6Sc7q9mBePnxfiQY1egLTsC3XbaX4qG4+a6BPX1URgnyP9j/3LaQIU5y/xBvcFSiw8DSrs0X35LbTV5ttEGTycGboYhdL6LmEIc79IHrpLCSXs3cQ6nKY7iJ3px7rKuC8nDafnt/rXuTevpBf/XGob0TQSYtHsMYr6uLKBpEmiJNBMA3N5knKj+ytngTo0mAn31UkEJ/QXL7O14A2b1farj+ANfyv4p0YjtBVvxCqKPMxRY4udedPboGq6hmn1LZ28FSE3GiiA72oxdCoPW8yk19MjBMRnLyYkZ6gmswa/5f52j4vYqu12/eJoqdu2UtRu8NBcOwjyNAjW9FsjDPk0+A56q9SFFYn5lGYtjBcYWak2y31YYscqxbDRPNGEp4sBgmVS6gHo3XaYbfOZAOB4IIc2mbyvf3lVPa8YPetmGqfRNfab8gXegjlZ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0495a590-fa2b-4278-621d-08dce4562f97
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 09:23:19.7492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uS9eo8tM57NO0Yhbff8DNJhGyNIZVfJcZUwrIqjwA/JYv1LeE55VjSPUV8ckMgXJbsHBs4Q3Cyg2yUGObP2H4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040068
X-Proofpoint-ORIG-GUID: hRNdTzxuEKJShvqm60_uDONfFt0-CeMo
X-Proofpoint-GUID: hRNdTzxuEKJShvqm60_uDONfFt0-CeMo

Currently FMODE_CAN_ATOMIC_WRITE is set if the bdev can atomic write and
the file is open for direct IO. This does not work if the file is not
opened for direct IO, yet fcntl(O_DIRECT) is used on the fd later.

Change to check for direct IO on a per-IO basis in
generic_atomic_write_valid(). Since we want to report -EOPNOTSUPP for
non-direct IO for an atomic write, change to return an error code.

Relocate the block fops atomic write checks to the common write path, as to
catch non-direct IO.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/fops.c       | 18 ++++++++++--------
 fs/read_write.c    | 13 ++++++++-----
 include/linux/fs.h |  2 +-
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 968b47b615c4..2d01c9007681 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -36,11 +36,8 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 }
 
 static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *iocb,
-				struct iov_iter *iter, bool is_atomic)
+				struct iov_iter *iter)
 {
-	if (is_atomic && !generic_atomic_write_valid(iocb, iter))
-		return true;
-
 	return iocb->ki_pos & (bdev_logical_block_size(bdev) - 1) ||
 		!bdev_iter_is_aligned(bdev, iter);
 }
@@ -368,13 +365,12 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
-	bool is_atomic = iocb->ki_flags & IOCB_ATOMIC;
 	unsigned int nr_pages;
 
 	if (!iov_iter_count(iter))
 		return 0;
 
-	if (blkdev_dio_invalid(bdev, iocb, iter, is_atomic))
+	if (blkdev_dio_invalid(bdev, iocb, iter))
 		return -EINVAL;
 
 	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
@@ -383,7 +379,7 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 			return __blkdev_direct_IO_simple(iocb, iter, bdev,
 							nr_pages);
 		return __blkdev_direct_IO_async(iocb, iter, bdev, nr_pages);
-	} else if (is_atomic) {
+	} else if (iocb->ki_flags & IOCB_ATOMIC) {
 		return -EINVAL;
 	}
 	return __blkdev_direct_IO(iocb, iter, bdev, bio_max_segs(nr_pages));
@@ -625,7 +621,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	if (!bdev)
 		return -ENXIO;
 
-	if (bdev_can_atomic_write(bdev) && filp->f_flags & O_DIRECT)
+	if (bdev_can_atomic_write(bdev))
 		filp->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 
 	ret = bdev_open(bdev, mode, filp->private_data, NULL, filp);
@@ -700,6 +696,12 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if ((iocb->ki_flags & (IOCB_NOWAIT | IOCB_DIRECT)) == IOCB_NOWAIT)
 		return -EOPNOTSUPP;
 
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		ret = generic_atomic_write_valid(iocb, from);
+		if (ret)
+			return ret;
+	}
+
 	size -= iocb->ki_pos;
 	if (iov_iter_count(from) > size) {
 		shorted = iov_iter_count(from) - size;
diff --git a/fs/read_write.c b/fs/read_write.c
index 32b476bf9be0..3e5dad12a5b4 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1830,19 +1830,22 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 	return 0;
 }
 
-bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
+int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 {
 	size_t len = iov_iter_count(iter);
 
 	if (!iter_is_ubuf(iter))
-		return false;
+		return -EINVAL;
 
 	if (!is_power_of_2(len))
-		return false;
+		return -EINVAL;
 
 	if (!IS_ALIGNED(iocb->ki_pos, len))
-		return false;
+		return -EINVAL;
 
-	return true;
+	if (!(iocb->ki_flags & IOCB_DIRECT))
+		return -EOPNOTSUPP;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(generic_atomic_write_valid);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fbfa032d1d90..ba47fb283730 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3721,6 +3721,6 @@ static inline bool vfs_empty_path(int dfd, const char __user *path)
 	return !c;
 }
 
-bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
+int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
 
 #endif /* _LINUX_FS_H */
-- 
2.31.1


