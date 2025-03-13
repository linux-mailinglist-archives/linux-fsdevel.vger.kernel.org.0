Return-Path: <linux-fsdevel+bounces-43929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFC0A5FD5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 18:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68DB3B8259
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C7126E620;
	Thu, 13 Mar 2025 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hGzEvgyf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YI8nZR7W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECDF26D5C9;
	Thu, 13 Mar 2025 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886039; cv=fail; b=mmrb2cJUemie6dvTeQuwGeIPHdyD6OXhTYzwzLZZdB48EyLcjtCzIQEmCIQ1HyodgIBeJwcIEa27R2DbMzcSQ1PbiZbLjBexwYH56poa+e6tnLrHleKnRN/9gQlNM8XmZod2xRK/QSbuSev3yhQ65Nn8XyR9RZX+YpNM/SoJtec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886039; c=relaxed/simple;
	bh=+KVaI7R45JHr1Awhb5rUwI2B4yXkO0eKC5gAZxHvOtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K1sg+NKdsqoTfvBWhs3Q2VMwYL1E6tCcKnH4s5zHxK3eXRS6g8L3vk+zNh1iLxue74Lamu4NheOXDZUMknMmOCX2txORl48YEEbrYnKZdIZ+8NqzHpzYfw5NZubqZZTPJ41GRFg8E2qVtqy3/TRRDRfW4zwNNLyCTPUTmr9KoAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hGzEvgyf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YI8nZR7W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGtuQU020758;
	Thu, 13 Mar 2025 17:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JFF+gnQWFjR2gRmrJdJ4QHOHJ63OdAqkRZKoLGLEFdE=; b=
	hGzEvgyfl+kNvruEDbAU/e6tHwDF5FmSy17PtbJg45LwkOgE+73zmWFfSzoROiW9
	Z/UqmL62mbbXoeqNX8yyOKWauTa0xMYcxU7+KQIy5tQVv6m5MWZp5tWsALUdDnR2
	2rR21btDyyktFdt6AUvTE8pgvdj27/KuhNLS9ni8M0HztEG6YMnAboNnJjQy9BlX
	wVARvIqB07aN3A0N5UXguUXSMflnR1yL7T3JXdiUGuT8ViZB2yUIkzDx8q5Vr7Gm
	DhF95PkgE3WQ8+cX2PWfuYnoJQQ0rC2UdokcEH1O9wYWjW4Pd5WshRrGLf+rVSTQ
	jzrgt04wUtiMD9ehEOKekA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dvpxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGB0pg012177;
	Thu, 13 Mar 2025 17:13:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn2yrt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gH5XDvfUWY8QeXdRE5KEmgSyEolGSjdtvnglFj+kFj00W3Oy/zT+hCpJQUZXUDjat0gW403bBwag33jZlkwI+/7yobRcMT7o7afrXvAFDEwWNVwm/askyxtwsTehbUWYb5UGtGfaOuaQuJfyac0rqWsklPY+1ad4FWk2NHhw+tGoaYQb7gZHbnEqaYwU2Ozua8miwXa6qOSUzbLOAhcrU+R/Kp3xk/gM3gwsVXaJhbdGt4EpObEKW8rtnUrn3ikCyohxF2w12o/OsMEqHWOeb6P3BoKotfmtvUQ9LM+OUnwnxVuCeuBTQxYND6YDnVPFWDMHUBrCRfPpy1BE0WNl6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFF+gnQWFjR2gRmrJdJ4QHOHJ63OdAqkRZKoLGLEFdE=;
 b=hzstF+5oaqkxJBg9h11V4KFMMLEZd/bLEwZ2zjepH8QsJM5yPfAOkE8Jcvtk/pjoAQhJXXHYUxxWU8uZY2RjLE0WEVcWE/9eNeiP0wKVaA8KW//4nMTDJAbLH7dhCSQevwc8LPTHNaQtBa1IC4oHRcCRQvYOE60TfIrIsKrfPXSgV3Da9Z7UyVixditTCLZLbDXUOUN44nESpH0NA263xTWfsOXng5wlfoA7JtEBxdxah2xoMMqBMeQY4eFsIovH4rB9iVRCj+zohj7vDPetOTeSv8oqbWJyj+F6xechn9FXAwqy/+Q+W9/488W71bJzWrCFAWoxUq5Tjxqmm3xgyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFF+gnQWFjR2gRmrJdJ4QHOHJ63OdAqkRZKoLGLEFdE=;
 b=YI8nZR7WavvV/IHwwRV2eKVh6JinnohkI0OHeFD8thTYP7wwjc3fK7SAboQW7VRy9kcaLNbyw0YpCPwCVkrgmOlSaqJleAvsnCkLXFufIjiDLS3fAwWl4sXPxmCtsrtTpe8iZx34QcBsLD5oCdp2QtNS4EaqbsYcEnCy5FQ7PwA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB7662.namprd10.prod.outlook.com (2603:10b6:806:386::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 17:13:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:13:39 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 10/13] xfs: iomap COW-based atomic write support
Date: Thu, 13 Mar 2025 17:13:07 +0000
Message-Id: <20250313171310.1886394-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250313171310.1886394-1-john.g.garry@oracle.com>
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:208:52d::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d23676-a468-4d6d-79a5-08dd625265ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cnHIXldKg6Dg2v1IW9fBbNLZ8VqG/gThhjldaH6EyhkSsZu7w6VwiCz1qq9R?=
 =?us-ascii?Q?ZfBg2+wEkLmJgIRzlCC2wr7BSbmA+ONtXaE132CUjlC6gS8/oYIbkNf6lp4x?=
 =?us-ascii?Q?kcBe3miRkUtLHyeiEaOuF70xmp5yC88mVbnhNdVTyq9uxqt4S+2B7KbGVH0P?=
 =?us-ascii?Q?Z756veW534v5/AFWBwgrTMLAS48K4zEYAc20kUoudrB1g1iL4Lm9tbgk+eyh?=
 =?us-ascii?Q?jlN7/IWuyNFkjwJMtlbSxVHH1fJmLULT+fDlYV1ZjvDSsP3icXI3pl2DOmxk?=
 =?us-ascii?Q?4Z6BKx6fyQxkbFGwXsvRibBGMSpWjoazktCg9xwqxYf9VbtyWGdLUOA2pnjr?=
 =?us-ascii?Q?CBdH9SoIWwUZinuRtV+xa8ARnk/vKCjCNfJNSqageWMD4AV9FhIZKxyMRiUS?=
 =?us-ascii?Q?xAsAxkWjPVNOV64ueLf61z92rfRgJ/b2Mpvui5nZP4P590jUvBRXFSQ91tDl?=
 =?us-ascii?Q?w5WNCkL0xjJfDR+Ei50ex4ImSXb3EknqpiQEvlw2gXhxCzuKaomeKZ+0TdBb?=
 =?us-ascii?Q?5T1UjN4Qh2NUsGAJlNhGBngWqliyrEWO072g6/LHBft8QF5PoMVLuEMExHsb?=
 =?us-ascii?Q?ZyotEfn6H2gZtAM1Q9HDQ/Jh5BWRfFYHnXtwoIgS4074XcNimkJUwPF99mdX?=
 =?us-ascii?Q?1uM6ZgMWBBsz2ymoxOhYyo0tu6AIVY/v4AZ4pv7bUBxgClBzXkDN3UvalB46?=
 =?us-ascii?Q?MGUdljvr4x/7KhZ5pL/67YK/z9NyOwNoRJnEDeRRP7SdglECO+MMc4CcInIm?=
 =?us-ascii?Q?l5LMsZnQDpqK/gEWsstrb/yqHz+Y0AkdaADkgfZp0pJLP5hPJlohfCblOYnW?=
 =?us-ascii?Q?xARgVHOAC5z6IPz0/IOMOaKjrK58K/XMe4X44vozNVGIHDESLfU1igHgLE2x?=
 =?us-ascii?Q?b/zIM0v6kRFA2X8sS7/QqNQJOyr5fusYGaCaKeKzaNyvMZCvPAgSMd2HcZvG?=
 =?us-ascii?Q?UjjENXj31UzFmR0I96mT7rSluP2iMxCJfPuOHQctMyyY4wWLPE9HDsAOtk0F?=
 =?us-ascii?Q?Ubc0btJru5OB2KZcqqxqezTMezeAz1IxmGRBE+fIVmAs8wgUi2dpCuWj9N/1?=
 =?us-ascii?Q?WeZBY/HstCxG7pHeT2AYELH9jEHCf0f5jS/OohNotRT05Kb+6vWaiPT/DtrE?=
 =?us-ascii?Q?sEMZynPOaaC3vjD/yyeyL7jb6Cepo9lNEaLh8K9wptUwwLrbKSYWugdbJCkw?=
 =?us-ascii?Q?gUxaDxwKjYYmfRwkMnRvFJDO636Ez8ySS+04SOyGwBCN3VmjPb4R1okvuwCX?=
 =?us-ascii?Q?l+KuHqiNsMTZFrudlzNDoSAk1huvG+tCmzGDgLM+XflAxnZh9HGSv7hR5rSh?=
 =?us-ascii?Q?bsN2PEmZz53Zt0E512FT2Crv2A3x1yEFVLNquSE0OCzyId78Zd5Wj5DVn5EE?=
 =?us-ascii?Q?IqXmHXVrRWfSKW3Ab/rwtj6P9cIK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7p/D4q5lpIjwMMKK9ENWs5RfLnYzx1+ElF/20B2ok21IAI/iEVcr42ZHdv8O?=
 =?us-ascii?Q?DZosWvfaIxVl+BXoXRyyfGjGQsl2Ibx1h9Bx8fHlH0HWv09s672YdoZkuLj4?=
 =?us-ascii?Q?XZTEWwI5NZ7IhvrCegIuakW+VeiY6e2ldnRMtUdrG12zcj6Gm35uFOybN+kF?=
 =?us-ascii?Q?wSng7wtaWvp+0yVYXw43cik3z/2ukTmfLXr14qE8fH+3Dn/TtQNRMRKCBybf?=
 =?us-ascii?Q?fOT0f7GpjkDbzbOoAMlMrB1bIY8QiaFmjfO+9J4KLrlFJWM3ULCJveAl4ijZ?=
 =?us-ascii?Q?/Hl1zUB/MfFWyJNSqkm8WBkdiQPQIH/PFURp1orNPicXwJxGVnqFL7U3NBYd?=
 =?us-ascii?Q?WOQ/uOLB/4ToKwMYp+I3qJFvzxOXgJQQS+En4QgIrywSX97xhKPkiYljZKpy?=
 =?us-ascii?Q?/kCtPCC7Hdi0DVJJvEB06y1XXCkcLUR5tQCZ9MpbSCsTuGjBpRiBmfnHfcD7?=
 =?us-ascii?Q?hCNrGJUxdfgpJweyzt2ryTt3ayqwhiis89plVA7wG2nqXzS4M8qThnvRhJLA?=
 =?us-ascii?Q?1+vGBdHIdnnp59w2Hb2iw1boROB3LFrDwkwBoy3WGycH+CwsGT8HBKo9L3Op?=
 =?us-ascii?Q?rpjh0Yu6lBj2wSQIlKEI5eg0Arr8qV8OpNTRNJThanBTC9NOlHImbDeu1b1R?=
 =?us-ascii?Q?jxJLLVu4KzVdj9if8FIzyJqj1dQ8CakMRyY1qH7SgizPecPg5zDJYvweGuUp?=
 =?us-ascii?Q?N1afieFjg6nHKQJPnEUQA+Xxb3rPkhuSMCRZdI9yH1Lu+S50mYeuVS4G16RB?=
 =?us-ascii?Q?B+4a8VJj51U6U20DrJzrqJikrjKzAG86Axi5ZFf3wmKKSnUexCFkg50vkXx4?=
 =?us-ascii?Q?E2pGE7x98jnMupKbKes0LUmGUBSiP6oboQ0fLNQhy+kU35a0eHuC736jLqdc?=
 =?us-ascii?Q?9sBx5Frutw57V4Kg+R9zRZ8v4xL56jZFDCXtC9B1OXrZjFgdI8Fu9vf6i6BC?=
 =?us-ascii?Q?Vqa1aX6IaEh/AvJJn7LrQcqCRTAAV+29VQ2JLxm1uob9biYbAwc0JlmUfwfj?=
 =?us-ascii?Q?TuX2LQUtVgjqBQFjWzssXW78kXE1OlS8KjMjeDwq05bDHpaAb2f3Bmr/vVdr?=
 =?us-ascii?Q?rdiz3xoYEPSPsquq5ywrxq+OCaJ1K6dnf72F6xynh9IQ3RvL6sCb1reDEFzj?=
 =?us-ascii?Q?UdxoU6KsvcKSi41bPexCciK91n0NH0XP3niL4eVBgUpFLKZl2nsWbG12cSpE?=
 =?us-ascii?Q?/B4jyKo2ll3fYZd5Ni9UPjmze0ayDXLWYrmvCGvc/m/OwB/uJslIPbFnayAR?=
 =?us-ascii?Q?TH5Q+XgeFErOn19nMAsznHeWCiB5U1A67hJXv2bM9sFqFKzDPwuNDW+80WHG?=
 =?us-ascii?Q?jS2We8PHJbCjL2hJ3zWwFt+iSbZ2vpozLhQYhADbpxPcqubuUiN8TtG8hQSl?=
 =?us-ascii?Q?wcF0AHmRDrslChaoXz0HwSvNsKu4unaVV899xh/xp1lKp2XFYhM8GdbeVSl6?=
 =?us-ascii?Q?NCHiLF8p8cCTgY2RzBVrIK3urid1Kye/G3tHZZ6WAGiXeyq9kNTRwveEyo8V?=
 =?us-ascii?Q?gGK4LSSFGks5vzWp3d/8vMjkwpITrlzKXw6sY0UBZnOESRJecm1SqwBFp+we?=
 =?us-ascii?Q?tELTiKD9L3w0aTnljADes4nJwog6Bo74zjJOGHAaoQXTIPJGA+CRVDrPleWI?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gC0xcD3nq/fSnTkng4DrA4LZ26xJ0qD1cuZ1zCUd3UPOlZDFiGP2eNSPDOP4MlOPVAvSKEHOuoy6RYj9ZdHwK3i1ZJiKJWHvSXUuTuYRZv6cja6TPo+GG2DfFlavlp9hBbuxUW1I5Wc8Hvhl5Dujj6LvENhsr1Va2IGwCBW38sNpDd/x8SQLE5Cv/JCoeALNEUhZrWkdSUHZVNZDEYUZjSYi5J6jcr8MaD0xLdGBp+TYujskQ9sRP9KvDUn43tUj0V1F7XiZ/VMwqekfwdSsG73S6Iy5gVO0DDTdlCf5BCxJ6Rxh2n+iNvLF3h8gp/dykT9XvGHWo+QoK3XVUV4j3vJ57AQqMm77HiEh7PDjpcMxQoo/z7VKJNtXkW/ZvLK7FRZSlOx4tuSRDyHuD5EdsrdPYOa+tbHNKULOxQavV3BKAGTd5RyeVvoNMcDcDPFckLZ5OKN9PRtGIuFnY44p+WSNgBi//gnUlQF+YcB3LZzTcVp7yQSncn3WM22FSEZIMYRyxX4iXs6R44VT/f6qPxYce3URFCyaQUxUJe807P8yNR0u/nJwjzrxsr0GfocwUdQxvrO90saw5NJf0AgSSOlrwAs3QQZfhgGhxtHJ1bE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d23676-a468-4d6d-79a5-08dd625265ec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:13:39.4968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0ItJx09g7WLZOCOEbHtAmkiMSxpJAY26r6QvhWHnL2vf1PjEZQ4A+c9TEijUjIWDgnAV61SCsSOYKj8VYFBlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7662
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503130131
X-Proofpoint-GUID: ooipXPGxT44QCkTY6RdLGMl-mvhOXyCM
X-Proofpoint-ORIG-GUID: ooipXPGxT44QCkTY6RdLGMl-mvhOXyCM

In cases of an atomic write covering misaligned or discontiguous disk
blocks, we will use a CoW-based method to issue the atomic write.

So, for that case, return -EAGAIN to request that the write be issued in
CoW atomic write mode. The dio write path should detect this, similar to
how misaligned regular DIO writes are handled.

For normal REQ_ATOMIC-based mode, when the range which we are atomic
writing to covers a shared data extent, try to allocate a new CoW fork.
However, if we find that what we allocated does not meet atomic write
requirements in terms of length and alignment, then fallback on the
CoW-based mode for the atomic write.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iomap.c | 131 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/xfs/xfs_iomap.h |   1 +
 2 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 8196e66b099b..88d86cabb8a1 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -798,6 +798,23 @@ imap_spans_range(
 	return true;
 }
 
+static bool
+xfs_bmap_valid_for_atomic_write(
+	struct xfs_bmbt_irec	*imap,
+	xfs_fileoff_t		offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	/* Misaligned start block wrt size */
+	if (!IS_ALIGNED(imap->br_startblock, imap->br_blockcount))
+		return false;
+
+	/* Discontiguous extents */
+	if (!imap_spans_range(imap, offset_fsb, end_fsb))
+		return false;
+
+	return true;
+}
+
 static int
 xfs_direct_write_iomap_begin(
 	struct inode		*inode,
@@ -812,10 +829,12 @@ xfs_direct_write_iomap_begin(
 	struct xfs_bmbt_irec	imap, cmap;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	xfs_fileoff_t		orig_end_fsb = end_fsb;
 	int			nimaps = 1, error = 0;
 	unsigned int		reflink_flags = 0;
 	bool			shared = false;
 	u16			iomap_flags = 0;
+	bool			needs_alloc;
 	unsigned int		lockmode;
 	u64			seq;
 
@@ -877,13 +896,44 @@ xfs_direct_write_iomap_begin(
 				&lockmode, reflink_flags);
 		if (error)
 			goto out_unlock;
-		if (shared)
+		if (shared) {
+			/*
+			 * Since we got a CoW fork extent mapping, ensure that
+			 * the mapping is actually suitable for an
+			 * REQ_ATOMIC-based atomic write, i.e. properly aligned
+			 * and covers the full range of the write. Otherwise,
+			 * we need to use the COW-based atomic write mode.
+			 */
+			if ((flags & IOMAP_ATOMIC) &&
+			    !xfs_bmap_valid_for_atomic_write(&cmap,
+					offset_fsb, end_fsb)) {
+				error = -EAGAIN;
+				goto out_unlock;
+			}
 			goto out_found_cow;
+		}
 		end_fsb = imap.br_startoff + imap.br_blockcount;
 		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
 	}
 
-	if (imap_needs_alloc(inode, flags, &imap, nimaps))
+	needs_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
+
+	if (flags & IOMAP_ATOMIC) {
+		error = -EAGAIN;
+		/*
+		 * If we allocate less than what is required for the write
+		 * then we may end up with multiple mappings, which means that
+		 * REQ_ATOMIC-based cannot be used, so avoid this possibility.
+		 */
+		if (needs_alloc && orig_end_fsb - offset_fsb > 1)
+			goto out_unlock;
+
+		if (!xfs_bmap_valid_for_atomic_write(&imap, offset_fsb,
+				orig_end_fsb))
+			goto out_unlock;
+	}
+
+	if (needs_alloc)
 		goto allocate_blocks;
 
 	/*
@@ -1024,6 +1074,83 @@ const struct iomap_ops xfs_zoned_direct_write_iomap_ops = {
 };
 #endif /* CONFIG_XFS_RT */
 
+static int
+xfs_atomic_write_cow_iomap_begin(
+	struct inode		*inode,
+	loff_t			offset,
+	loff_t			length,
+	unsigned		flags,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	ASSERT(flags & IOMAP_WRITE);
+	ASSERT(flags & IOMAP_DIRECT);
+
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_bmbt_irec	imap, cmap;
+	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	int			nimaps = 1, error;
+	bool			shared = false;
+	unsigned int		lockmode = XFS_ILOCK_EXCL;
+	u64			seq;
+
+	if (xfs_is_shutdown(mp))
+		return -EIO;
+
+	if (!xfs_has_reflink(mp))
+		return -EINVAL;
+
+	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
+	if (error)
+		return error;
+
+	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
+			&nimaps, 0);
+	if (error)
+		goto out_unlock;
+
+	 /*
+	  * Use XFS_REFLINK_ALLOC_EXTSZALIGN to hint at aligning new extents
+	  * according to extszhint, such that there will be a greater chance
+	  * that future atomic writes to that same range will be aligned (and
+	  * don't require this COW-based method).
+	  */
+	error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
+			&lockmode, XFS_REFLINK_CONVERT_UNWRITTEN |
+			XFS_REFLINK_FORCE_COW | XFS_REFLINK_ALLOC_EXTSZALIGN);
+	/*
+	 * Don't check @shared. For atomic writes, we should error when
+	 * we don't get a COW fork extent mapping.
+	 */
+	if (error)
+		goto out_unlock;
+
+	end_fsb = imap.br_startoff + imap.br_blockcount;
+
+	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
+	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
+	if (imap.br_startblock != HOLESTARTBLOCK) {
+		seq = xfs_iomap_inode_sequence(ip, 0);
+		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
+		if (error)
+			goto out_unlock;
+	}
+	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
+	xfs_iunlock(ip, lockmode);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
+
+out_unlock:
+	if (lockmode)
+		xfs_iunlock(ip, lockmode);
+	return error;
+}
+
+const struct iomap_ops xfs_atomic_write_cow_iomap_ops = {
+	.iomap_begin		= xfs_atomic_write_cow_iomap_begin,
+};
+
 static int
 xfs_dax_write_iomap_end(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index d330c4a581b1..674f8ac1b9bd 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -56,5 +56,6 @@ extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
 extern const struct iomap_ops xfs_dax_write_iomap_ops;
+extern const struct iomap_ops xfs_atomic_write_cow_iomap_ops;
 
 #endif /* __XFS_IOMAP_H__*/
-- 
2.31.1


