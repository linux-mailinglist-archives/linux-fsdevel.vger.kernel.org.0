Return-Path: <linux-fsdevel+bounces-49592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE250ABFCB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 20:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3172E7AB742
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 18:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987A028ECF9;
	Wed, 21 May 2025 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yql/xyZm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e9lQPk4D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707CB28150D;
	Wed, 21 May 2025 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747851669; cv=fail; b=Erjq86kOlu0h5oujqUN2tAzqitPtU3Gref/U/iTEwEelO/CumSUuCotnSyV4qhaZxva2nZZCgatwJFnujciuM1s7WAcz4xW+wDwca9skbUlGpdJ/NdsXIbCgEd35qIaRz2UUG5DymzRNAgcIl7n0qazJs0viCMhOlxZDrDVeb80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747851669; c=relaxed/simple;
	bh=mp2OhxLGvVXcM/6MVvKacFapZlIWu7TbmHnppfPFrbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EGovjw3kFYoqngwpG6jqWoe2ZvJNoDjCloiVPM3STLjpI8BopnQTx+Ttt4u/MW74BcqZFgQG5E9rad6CwnCgmmpRLtM9kv12hp+k2hW20di26gG1kTXzRU0p8hHkabGIhlUKTodSRFaUthVxT9IiuS61gem4EOH+tSkeF/6R940=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yql/xyZm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e9lQPk4D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LHvclB001822;
	Wed, 21 May 2025 18:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=myHVESGAs2Q+QmGmRywK8+GqSrnmHrOa3IxaRAMpgR4=; b=
	Yql/xyZm2SKptHTSERVZMHVFDmrKHKxHq5CQCPY2stibQlw/pHRIDlMRrqPehAQX
	Ju4FBR48OlUd4RW3K8opvTHre02N7TLPAsBE6UgBtEnL1iTdHeI8aMasHgT/TULW
	sx1bES5kfrHqPeeFNOAuIVs1Ta1QTS8SFZk0OnhkRNb3/qVQ/I5VHnRyrNI8tmTg
	8/zyUzUvElhFihsI0a3fmgUHhYdMXcDMDN6DO4Bzfc/mV3saAslxTvSvUG+itQfr
	2eREABf54/eagT/iEWCvmlBPorhvTEecHA6hmxcQm9A5Msk7aXBHGrY0NJ53fPyC
	J0Qp2grx9gEqRKlSlBTJKA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46skp901cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 18:20:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LH0Cd0020240;
	Wed, 21 May 2025 18:20:47 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rweu799g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 18:20:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVF+I/W+410hjDX1f8bolCiOwMfRnSJ5/3cnu77oTMCeYAep6N1uhhkD+3hjGhcpO0PC9NQzLJL87Qzc0gVZUayVuXcvRfrF6tdVAiSyTw4wVpg2fhYzyuoIKzzwEZb9gnofBSDn+8k39IBntXKnLiR8ha1QjNfsF44TecaGt/LGHemZUQ4ZD+xMh+C8naOCcoRijEAWt6auXr2wZnaokLt5UdfVLs6pG1KbMhTq0l3tgofNasVH2cDwVtVk+gkBT6dq3YVIM+hXgxECEN2S5sz7tnk9M5emP/DREsTNho0C4xFWFNKCpTkj8WkqstGOC+JqK0b1tyCJVxSFoAZ5+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myHVESGAs2Q+QmGmRywK8+GqSrnmHrOa3IxaRAMpgR4=;
 b=V4Sqr4QCuUabF2btaadp4LVEIDaqKDlmc9AvP3VyZ7r+MFaOASYRZlfPguN8kDGdmIIP6uSlukJpL2Tjkj1Qg11kvhYYJw7mHK09WC9R/rPCRQ8vW9CyDMeKoH2EcxzpOuGaQCqPzrHBB7bw7vmqUSMJcidqiYxUy03OnaBgAsTqCZX9Qr3mKqBBEmKIGXqG28gqauVF1wKyHJmvY8nUoeqMsw/9spntO/xQ4IO1if380kckgA37fvpovyoFC3LqW9w15Vmm5gCr7lonSp/YrsH+ckoV24bW7IFwBMF2HdaHApfFWtJnRre6MpZfnd07E+U3i8yH+Np1o6HFQB07bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myHVESGAs2Q+QmGmRywK8+GqSrnmHrOa3IxaRAMpgR4=;
 b=e9lQPk4D04mhtScMtXKMep6fUi66AKjlpU2GEiBt2zMruVGsw34o2Kevc9baT8g+IzC9/EyvJGPN400DAzNnk2CzBFrNY4vTo63rykZyiSzUL55X/CdGbHRuHaFskqbCM+t7pfohQ7sgyUMbHZrvLYhv9p8157QrnEYf8v8YCME=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB6697.namprd10.prod.outlook.com (2603:10b6:208:443::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 18:20:45 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 18:20:45 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Stefan Roesch <shr@devkernel.io>
Subject: [PATCH v2 2/4] mm: ksm: refer to special VMAs via VM_SPECIAL in ksm_compatible()
Date: Wed, 21 May 2025 19:20:29 +0100
Message-ID: <e22d9582b0b334a1161ffa150708da370bffb537.1747844463.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747844463.git.lorenzo.stoakes@oracle.com>
References: <cover.1747844463.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0315.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: 852cbd07-8179-480d-33a3-08dd989433e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VJ8yAloB2rX3UscCVpbcCwgMpSQJT93n9LIqx2h270M+CetQNqFDlz+uqcsh?=
 =?us-ascii?Q?HNLapR9BzeegoJZXSHgOdFqIpjGpXWxxVRxsQHrJply+08auR5XgxOhARbdL?=
 =?us-ascii?Q?j5oZ4GaCkppa3HyvN95jwnmUiSDBWHh/4Z8GHeJxwJiCbB2oiGZl50UINtdJ?=
 =?us-ascii?Q?NZ4KhIudEjh1+pWBLbf7MNL0zhCuTXtAPD/44RtGQ94rChvYKzXJDmkwoqE4?=
 =?us-ascii?Q?TEqmq2vdcqf1wddO+DhnMhaiRg8sgPF6xHSeneOoTGgcAXIRpOpQPXbF56uS?=
 =?us-ascii?Q?50vfN4tUavGbA6mL8mZTkZi0sYNPhU9qJK9NnKPDEUvo5OZhSl+5IXxWflq8?=
 =?us-ascii?Q?1BWu35aSJ5/rYWFA/EnZAPX6W0dovNMVd8ALOICxmOjqj2m8K/nMK7Mn9FQ/?=
 =?us-ascii?Q?vlMpiwg7k/2o8yof0Cen5hfc/hpiWm5pZvvstV6wFSWyME/GaZABsWfihq0C?=
 =?us-ascii?Q?yn0m8BMETDZnW/ZTjmy/JhVD0xyTj21TpY3EfvVH0yVFPQpGQprjoEVTipH7?=
 =?us-ascii?Q?iQq0OdTHoPLKa7H9nIdIgYxBeel24kphnkVWIzXOL2yry9EnRhkiJKB2c/aX?=
 =?us-ascii?Q?weZv2nEl/dq31lDWO+CeN/KBGXhdasNFeMOG8YuEnBmrnv6quQKx/7kQXZiE?=
 =?us-ascii?Q?5E6sUx1evxs1G+upccaH8TBjHiQstPa7ZeUKZ+ZpfgO3ypw3rj+jxy5/Rvs+?=
 =?us-ascii?Q?kBtcxecbXP+rDlbFYQx3tEgN8qAUZTjDrr7WUHI0GoDg8G06FtP4GCi+t2Yq?=
 =?us-ascii?Q?D8hOxZawQI6l7OFT9NSqQhA9t6xiYh7eyeP9+0nLJi2tdzdGQeuufu1ckFJ/?=
 =?us-ascii?Q?Lq3DVdKGuq0LLUo5CEe0bNNRwO5u//NI1M07Rqqs8vZmE4SAF9+nI/W5/bPs?=
 =?us-ascii?Q?mK8ob5YNpDN5H0EM262aZLA5mhVqfYfytcfYSI+wSSSUOAyWZQObZeCi+GcG?=
 =?us-ascii?Q?UD70HfsDHS3RDOTrFrl4WYN0wtfn1C6GOgQtGa2h5OKJsKBMAvEoHqJHWo/2?=
 =?us-ascii?Q?qMZg9rqwi/spwIxSqhlkNaSzUQWM8nVDi9QgAWHtBq+caugZYauox+2CsDbK?=
 =?us-ascii?Q?41gu0FOpjFM4+fVJhuv7akcQRz+tWUCY+Mtng/YXC0mUaFKFGxBUYBt47qQd?=
 =?us-ascii?Q?bUYdRZz+QpJK4K9xhtCNmsgRWItJXMMp84XL9fHUptShPWypGsNZTJ/QZxDs?=
 =?us-ascii?Q?OOZkBSXgWRrRGjgk3ttfQPrwCQH++Cc+x6OKDUFXA5fv4cfXWOe97Dkz/7ev?=
 =?us-ascii?Q?j9gCbngAJ7Hs1RS7HPb7DZ17AjPg79gQ/bF2X5flnQadMluG3S7zdENN2T3Z?=
 =?us-ascii?Q?+mXPfSNUfcZ7BByZ0qPRwJYIdWV5vQG0ps0Th97jXFEXC0SJFCMVB7q7J2oT?=
 =?us-ascii?Q?t+Q8NzRDf03Yu1rwns+NZ8u1AK6emOTbbinHPYp0pgfnloTiVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yGNlkcOBqYczX6+mbWA7Q4yjGfRWJUp8OViTk6m1ZuOzX4/8KBlfBgCaDJVB?=
 =?us-ascii?Q?cdxClFqTW8ilm0MLhkLdqG3PgQ+c52sY1ebIR7V2pVL0/JcaCc8plN+WoTCV?=
 =?us-ascii?Q?9LQlSglOSY/xYHH3sLapZdINqMpkxO66PPeCpEZjDcdpPxThrSIQ+ypNWo07?=
 =?us-ascii?Q?L4PMybSeGsLg4aAg8JGL+nAvoYhX5NQS5NhkdWKNBwW5rmwNsgHtv2prtPjE?=
 =?us-ascii?Q?YRxRJnq2ZspGycbwwgS+9RrCZQp5MkVyQczkgT2rzPYTuu2uJFKTMrwyDCOb?=
 =?us-ascii?Q?m9fpRGFVFnlRLfxQGUvywMjn7/ryuSYTwFulB0b35jF++Ywp7uuul2Gyeujg?=
 =?us-ascii?Q?pXlpysNBx7w73y6vDtnLy/XTFP57dRHG+HbtOAbykGdM+UvVvcCcjxlVYpCt?=
 =?us-ascii?Q?wKiBY2jo8CIXc62Zjn4vy6f7aIYovPM17ozdp8U5lX1cQPYlzGf12gJCNbBA?=
 =?us-ascii?Q?pf4pqjNwVNvLFs7UBnnaIMNF8kby3WUXHoNqZPWkltUUFtlIFJGpEpUwW+dn?=
 =?us-ascii?Q?KKG+WpPYy79iwwqMbu3A/nmxeEg1FgBYCFM8+4zg02eL8dgBJnfPP+T+xmwt?=
 =?us-ascii?Q?hdHZ1pFIbCIZK4k4BAJQn+OpgzekAFY5gmvuSCaQS5fnYZVN77IgTsrmXjcj?=
 =?us-ascii?Q?HWvxlCyCP9fDO6Jtki2hUdEWaMgxNFxYHFVjLWeqqvWhNMgtjSDXCou1Uwmf?=
 =?us-ascii?Q?rltobOxYJYr2ZFCJcLeoaGFWsJNKnwJpM1BVGUn5kBpNpi99FiUSf/vwuk73?=
 =?us-ascii?Q?R01dT5pCmvdLZ0eQp3TJglaxIvmXQ9JUkNT47kSzV1vV7z9ETfagO9rI/P2x?=
 =?us-ascii?Q?1vY6bfl18Fj7DI8YtoHuNMmpwD7N2P1QUeMNefORM5l+oGUqFKSEZi+Y+rWO?=
 =?us-ascii?Q?Yck/ymeGTCUEtNL09jOXi01+FSzmiALboml5bPMFA99IwF8d08EjT+1MsvHR?=
 =?us-ascii?Q?/4sxxji4j97qzrrIkYlbKlIRODu0BdOCOF3Bj0MzpTvjLPCSnr4Pz9J3vMZX?=
 =?us-ascii?Q?w0akyk3SGzhSE1CBXHQY1xkN24vdzT83+sjAZ8HKKCZ3eheFrElgDWmxYxud?=
 =?us-ascii?Q?7ooD2/3QZSMEWWSPjN+73ZM6JuDDf4bRZPTOu5yP7rtCq8unZb954JbGmmcP?=
 =?us-ascii?Q?gXXED/kl71E8zUN/vrbaucqOEOd9qZMyTLd8gWGVVwWbwjOVFP8x8F39p/dn?=
 =?us-ascii?Q?2AHOM2RTp7l0ubkVZ40HqFsx649/9p1jq5bSi74zRHW2csXajPSDh+UKZdYY?=
 =?us-ascii?Q?mfq6ogbvkf4dGXQBMhaqcBikPM4rEdZmQrKVCHSY/hpOob0V7gyLo2D3KZKa?=
 =?us-ascii?Q?TIIDvXiKnNa93Td9kutS/XDhr9+kToO4Ta7FQSq1nxm6Zs5e6K8L+BeAQj07?=
 =?us-ascii?Q?eZN14PGn+/1b+vdUXfaC9xUCYh2nrRljcUG9W1qO2udwTflGjWslxz/WY8IP?=
 =?us-ascii?Q?RSlb2iYJsonvYSa3ljBeUDitvcj899UFRM868lpkskr7Olkw4qsIAsJ5LNfh?=
 =?us-ascii?Q?bvHnNtFUzmCiDPcwuv/qVOj66KcoSb0eDCqQWhjTjhGYdD+tvGo6TidP1n+k?=
 =?us-ascii?Q?0XwWlIU8P6WRl3CfxQtjTRmUyuH98F9rn/bjOIZWMEG1h47fNWeKmyBOcFlk?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	101Jf269yIn/RnCv6pI0Xma8Admavtd84GQD67ZDerT1vFDXBsWqPeuUBC7i1MH+Cya6h/DbxEnUWg8eiD/FM54a9X9U1Eo/H4SZHglymF/SS+EQx+iSsXYWRq6MCAWoVNETX65Z8gRAMkWTBj2SaF3YipmMQT/5l3xigQY70Ro3DDJJMXdQYo5LabR5RsUDmYq/EboV/Eoq2zFyZIGZENM8PKXkKTBRJpvO/I00QDH8kzZ6vqtH5MbxzU+i5TzZ1j/fsxO7BnFlzVeF//XRdK+TeM4suKzXP0R93gp7eOCtaSwWYjT7LCzdCuXI1Av9G+H878oGZQ+D9Z87KT0SECEaN7Qb4Mufwxoe9xN8mnw2JXL9EP1Gv/+r7TImvPKB8xiibFcnd4U/Ua2FwrEgtBFkB+0PLiBJzP0n7b0/pOn3bY4ka7s+Si6eHf23wj46V321+Yt36O/4CRd1bj7bhfnUg0IgEAZb6qfhRuOK2uYJh/ccK89q1QqnHT7EVKEQvnmBKRYCKFg/w3sQcvWM05DN+kGBQ/SSg5+E0/PMTpZRfpdUAxc1eZd+4DZZrZ1bgBn2HKKMB9jhUpKCbP5KuBtoRY+Jcc5ruWq/xAmUiZU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852cbd07-8179-480d-33a3-08dd989433e3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 18:20:45.0386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a06wIXi85nAM6CiKvlF5w1J3/V1ui48Lllxw14Fffl60w88FkK7sIccJ7KqELiROXCrTHXtPty3fWtw2BeqC9yWH9Byknu+G4SBFjrW9uAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_06,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210181
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE4MSBTYWx0ZWRfXxREUh99JCTR8 M8+UmXhgDP520e1CmXk7FahOGgev5RHGHXH4s+p6jAWjUnGU10xfSDZfSXYEp0VpPodUekRSO+c K+0Q3zdRKSqBEqBxy7KWZ4/eRXcfR1sReWpXrxkwzi5BQ97O14mApckHY+kwI6rjgeZf2t0GZzj
 jrBiz+X58jT8kGGjmB/GHN/LP+ANjSHM+DoKH+7eY0305oCX/FYP8k4bGnQbCjL00/R6+QVMgPQ jxWozozxDizzraNQzE+cRvhEluoNTkU9tp7jBcUaIWTp4sZV3p+Dnd765vVtkTDd1SBqPSlobao IGbyEpPGKnAUVXR1jYE3Q3hMWjCMyMPnbRcQwtC5SHuVg/rDfwg6B6IrZ7Y4Q2eY6nulJksAEtE
 xZqF72+v7YvGeTsh7s3ySSY2UUb1mxVQ2sbXLVVwh8WVTq+tfp7NuDS2AEB4JvJhHDRREp+V
X-Authority-Analysis: v=2.4 cv=TaCWtQQh c=1 sm=1 tr=0 ts=682e1980 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=lnN364MPqBXgp6w5Ec4A:9 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: AD9YAcCKl0Odw3FUv31pzwqYKiw7VSKf
X-Proofpoint-GUID: AD9YAcCKl0Odw3FUv31pzwqYKiw7VSKf

There's no need to spell out all the special cases, also doing it this way
makes it absolutely clear that we preclude unmergeable VMAs in general, and
puts the other excluded flags in stark and clear contrast.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/ksm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 08d486f188ff..d0c763abd499 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -679,9 +679,8 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_v
 
 static bool ksm_compatible(const struct file *file, vm_flags_t vm_flags)
 {
-	if (vm_flags & (VM_SHARED   | VM_MAYSHARE   | VM_PFNMAP  |
-			VM_IO       | VM_DONTEXPAND | VM_HUGETLB |
-			VM_MIXEDMAP | VM_DROPPABLE))
+	if (vm_flags & (VM_SHARED  | VM_MAYSHARE | VM_SPECIAL |
+			VM_HUGETLB | VM_DROPPABLE))
 		return false;		/* just ignore the advice */
 
 	if (file_is_dax(file))
-- 
2.49.0


