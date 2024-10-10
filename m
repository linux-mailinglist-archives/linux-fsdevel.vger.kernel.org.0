Return-Path: <linux-fsdevel+bounces-31621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5574F998F9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 20:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00323281876
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 18:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A961CEE8F;
	Thu, 10 Oct 2024 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X2UCszsE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SWSe4jAp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBEB19C564;
	Thu, 10 Oct 2024 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584171; cv=fail; b=jJAXIYfH1sPMPPzxkpqlBVp1MQCy9nO0SUW+rhLaUqDxGn1i9p/QSYcBiuuf9MjbcKieeil7jquTWQhXg17/jlp/AGt4uovDoyd9ulKa9yo/EXLqNS5t9iPY9PW8r9dT03j1nzk+zWEYAk4XIuHGK+ajBUa8l6f1p0mi0URGKF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584171; c=relaxed/simple;
	bh=NNU+AwdMeiPwGrUfdNmufqfA8by3JsOh/k5Bm4J9m98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=phyUvBwVYLDtkb8CmP3ubHCPlHOdeLQJLjN0N4zqg5xt6PkDKHBd8f3H1udc10f8rP4SKjEWdsJN1PDg6icMbb8HquEJsInM1XXAnXUHiAjVOYkZgtKnczZhOum2lispKb2RXypObB/gPYayb/HgZduxl2KXEYsl1/+b7GWudxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X2UCszsE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SWSe4jAp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHtdKY013526;
	Thu, 10 Oct 2024 18:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DQXBsOR2E19Q2CMf9E95TjmQXv+9t0EfWPaUCkT1KJk=; b=
	X2UCszsEJBiPcWQAMnN1DGqOISFCrR9Uh8OrMLmn9vBEQFjMlC9zR0CYHWRKtwuL
	g/doAR8sq1LgS1cbbHwjFdzDBV+3nuOBqLQqdCca0d+kwePRWUeLzleF4flQRKFq
	6URuZwswOd7qRn/m802mgTIzTPimczhdhdseFksm+jZBtHXDqBr7DGTnYY/xwokg
	aUja3F4wEtBSSrNU7CgrJATy7Y1ASwWXhzEd796E7MR7D4I2puwgRhSlXWFdG+1X
	chmK0RK8S+QRNgETeHTlRMVFtdKKGqcT6fnYQlKM6h5YyB35DglmuJiQuxG5GbaX
	dBwnyOR8l+KVOZXy8BqG0A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pk8nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 18:15:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHH1gR017491;
	Thu, 10 Oct 2024 18:15:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwag76g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 18:15:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTnWEn0le439PPKyyOfWr1gV0ncysPoXdF8rlA/QsFLxDRXm5hHbHRT36ISjlx/pGFrK4OHMZ5WUO/a3dzGu+kJAsbyqNyE4K8rHibW2XowZKsS9zTVCMtnT6ZKm0or3D8pTMMSY3jZ5SKaBiyadvpqtebAUPAnidpi2CISXq8+T0qbmQkisedb8XiVCApK03KgoRmf23VPo/XPNcHj/lyXrwbrNMRwRsNgJEOHVAy/Cx0GaXj2pu6N0AFALOnrFffEvkcfCCH4lY8ydz019PzTpv6Z36Wk3oiGnamhPbqvtHWC+cpZuODaDSv6Uf5rC9isyShOCyrN/Oacfr6HLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQXBsOR2E19Q2CMf9E95TjmQXv+9t0EfWPaUCkT1KJk=;
 b=FB+727kdsA08p87g3NbOpaTDQngSFbCKDC/sdvDArF3uknKT/vpRKmOS6Y/bclRKfwSCqHEbELO6A9dMUIX4Lap4lQXkuo2/eEW/uFklbb/JveLqXMUSW+Sb5q3LwWvDD+1UHOLdk9zYumWMRDp5ogGpumyZuG5Uk1NMldIv6N3SC9iCF+9crA16zupqimAeoUIl+qREHEVmNpq83BxvDbUNHWLw3O53BJzPHU4sKO4H9s+i2X78lDBDv3PSAKJfwFBo487tGRhKwQNVTCVb+rmNUCx7LLFYYrAJx9Xmoj/jY7g9nXIlBVyTC9DYOwslwohAN01WQ2mVwNHl0+Ghzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQXBsOR2E19Q2CMf9E95TjmQXv+9t0EfWPaUCkT1KJk=;
 b=SWSe4jApdzVBLzdo2Bo4P0MNvX1oClT6/HfZmxA7Nell8faUSa/kWye4imRanXpLJ5NxGwAiOQry21nbuna3J+WC+s8shEtn85mjkO+rNPPFPh/LQ6oEQMvNsxGaKqp7lgr2yj7mEBSC3B9Q5unZo+ymaZqwbO8V7+yOhq1mgMc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ2PR10MB7826.namprd10.prod.outlook.com (2603:10b6:a03:56b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 18:15:51 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 18:15:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] pidfd: extend pidfd_get_pid() and de-duplicate pid lookup
Date: Thu, 10 Oct 2024 19:15:43 +0100
Message-ID: <8e7edaf2f648fb01a71def749f17f76c0502dee1.1728578231.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1728578231.git.lorenzo.stoakes@oracle.com>
References: <cover.1728578231.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0595.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ2PR10MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3ad6ea-a3d5-41eb-b55b-08dce95792d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pfHuJPpQyWx/1FVvKbfTWXnEkY0dJjHI4SYLSBkiDOYhoe3dHGKMQPlJwtcc?=
 =?us-ascii?Q?5YHpS9EaPYBXHP94GsNd4WIKCYFqsP2zT06yy0ez2clZlXyqZ2J5oDARKp9g?=
 =?us-ascii?Q?8t9dsgOV/ONNvvrOvMLzQXA1WmzxP3dT5N9srwhk+CIaiaSdvDcE1Iu25Vqy?=
 =?us-ascii?Q?5GgSnOk3OqFnREgpHPHyZVuK7any22J2JeExYgudtOc3jpYlH9OTPGAoIH/4?=
 =?us-ascii?Q?37JeeXUGeTVuCD4yos9n/vN2nFbHYFolOxUzymBnbvylTpoQPCOllR9ur3cm?=
 =?us-ascii?Q?n21l8l4Q57BgUn+Uk7uqHHnTUKCdmnNa87c12OApEr5n30508buAMzYY+vU8?=
 =?us-ascii?Q?Yi0+WtlqT6N3gOgSeAZ3wzcubP2ItOayC3pcJqI1pd4vBP5U74sUCDEttfOb?=
 =?us-ascii?Q?t0IUkMA3ZFO6yykTay+5s0XGfHwsqE/91O/V+EivWS27N2UqFjQGSTN+J9NQ?=
 =?us-ascii?Q?ki332Lkm/2zf5ZQnzUSLgCn0/LHPzVdC4uZOkivZN04GolHVHQ7xjMZ9h98p?=
 =?us-ascii?Q?c3DkxYmD6ZmRj4uTpxDsNcFpDhMvi/gNjMt6PNEmf9DBO/sqE9lhV7Lg/XDB?=
 =?us-ascii?Q?V5STJtlJBzxQUl+1z27CZVYC75UWomsaojn/jY2SppILtBJTH1WbJLKoU3f2?=
 =?us-ascii?Q?GayYLE3/TCWNYjP0orB5a9kJXN5RhipVK1Y62zx5rcS6AasFKQP+CwqYpTnN?=
 =?us-ascii?Q?P2+7XNrXWvSaQMTwvq90zYABYC0VG41Dznp7x9gQlGqmOFBXX9wsk7limNLt?=
 =?us-ascii?Q?Cztk1XDWpwvAeQH7ln5nijvo0fboZmdvP1H+AUdx6wwFv/2IWEYekNL3mT72?=
 =?us-ascii?Q?8TCCRsyODbOO3H0E3icdJhXwzb2+Ue+lo89wh+IvwdBnHhjJel/4wSAuJSFm?=
 =?us-ascii?Q?QwOEeD0TfFiwVkAmis00ry77udFqW13MR/CEkSj6wpVqOhyatc73elIB+ubD?=
 =?us-ascii?Q?yEc3qddElTzrw6uQe5uBFp11cr/YNDq8a/8hl1TkiOuuqwaB3TQcjpLCcnXk?=
 =?us-ascii?Q?W1sSuw8D21fhFk6beaNOTMxcjeeHEmBOQdfkmK7lWxVEiJyijsPtX6s8LL4M?=
 =?us-ascii?Q?7i+Nr9sKMcKYLZ9kkPJ3m/U6iSSTo8QCXJd7NOY0w8VdFXi1GKS7fD6/SAxb?=
 =?us-ascii?Q?c40mzcWh8RwRVzHIYbWHDmok/vEly7JE93vFa1NswltDVO9F/BjkQe5JN72s?=
 =?us-ascii?Q?g+DEd5RPmJtoCab2vT71A5BOLaHsKruLWBNNjTFrmcs7pZpXQ5LaqWnEQdnY?=
 =?us-ascii?Q?TW26yoNPcVrDeVAKKbIJXTJyG8Yz+o4Re8OlWE8yxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dQRq9Ypi4zCD5WmxAm0Hbu7dAufFQMmnNx1fQ1Z09fTB5kXDo0YTMgCW3u60?=
 =?us-ascii?Q?ZZ+3gd42Wc8MDGUEvbBjuMngPZQ4wsKLZRumdKgNZLo6UY4N6M+wrU1JJ0gL?=
 =?us-ascii?Q?plPXXbV5AX3+XqQ8Qn0o3SYhW+sF37X/1z8ppMKQnFRJQTDL5vlw+FXq8Miv?=
 =?us-ascii?Q?O+Y1YIpjQ5in9V2WSs/qguKHQrTmI3Q/DrzZsKG/FfqkHPVM2wWDFMBBoikj?=
 =?us-ascii?Q?YAX7nXMr9b6rVP+C8d4uLltzgZMmzACAeAVuAo863/Z6RHaYHvBuNrB0+/VL?=
 =?us-ascii?Q?LrfylG3RrhDTPAQ5kMV4cp+SvNdYkW9VXREXJVLVdUaLHzLswXMv4owILAMZ?=
 =?us-ascii?Q?lhpEgfnwlI8UKOWZiaaCppsu+3TceDiQgiwq3lOLW9inou+yN/oFbvQbmdIv?=
 =?us-ascii?Q?dqehOzCcQA99ZOH2+pvJ0G4tmmFGZbTMcizdQ+LwIcx2tNAlL8dIvlMxFcoW?=
 =?us-ascii?Q?scI5GaOwEEwFrXmWJNE+0IEw+1ar/sc4Ei2S61ryDv3IFkyL03DU1XQVFLIL?=
 =?us-ascii?Q?vzWB/4itNP1pH4P71o/bZb8PZAeGQjB+3dQDG5guZiL78JBF+z4RX+zk9V8B?=
 =?us-ascii?Q?KB6YST992f/6USFNbuUYCE9FugVMtd5BD/lrDwieK2zuVn26nVOyyVRgV9Kt?=
 =?us-ascii?Q?Ap6v6IqudWmWpBmOgXayyxN25+XIN7v03+3wtckqTALSywRjKlSwtCu4239M?=
 =?us-ascii?Q?HM48iuIBHgLufrd4FDptzmxWbAtauALON1pAVA3NX8iCsgmg51pSFRpzvMjE?=
 =?us-ascii?Q?TXCoFX2U8jkhXHW9s48hHdxhMfJNMpRQ0g84nU3rmQs5ze6KclRACeUiRPUI?=
 =?us-ascii?Q?tWB/WVQ9E0FyUKEHc9RekGS1Yw1k5qAnE25ZRT8sRQx71d/tH4/TMznExvR0?=
 =?us-ascii?Q?gZb7ed6QgL/Gkti8fmBrXbU9W/KyM1ILQsIkW5JFM1aRN6M9j6zWtcXwuF85?=
 =?us-ascii?Q?JxjCmwtIYy4oUcej47L8yfROKSmb9aXrd7Ch0rpMYMcdl4xJuHu8h5FKMSVR?=
 =?us-ascii?Q?WREqyjlA+d7hgLp7vpFTsxZAIbQfuMSWMc3QOZVrIl8FwCdkFlJ/E7rWXCbm?=
 =?us-ascii?Q?ONq355kW5NNRFAluwvTfwAAgczkhSRGwyCclDPdE7RgDVD41NlRj3ovQhxY3?=
 =?us-ascii?Q?2BQLa+DhneZqVKhPT51GXzEcHk6dpdcjBmOZf2UGCdMhWkaLgebg1McHwlZ4?=
 =?us-ascii?Q?mEYavuOKWcvtIIbU41Yt9pRNv7pgZFDhGBrk+FW3zn4CAyIktUjFHchgHVP0?=
 =?us-ascii?Q?BaRYYFroA573lkLNAIaOI4N6a83dFUmOBcYzp8fMBGu41/PUPqVH69tSlfz6?=
 =?us-ascii?Q?F0fp7LxRjI9KM06Cy2QM+HYk3tpgM+jCDfYkkdQhKAw9AoNdKRxya9oIHNmB?=
 =?us-ascii?Q?CF6pWL+L+EmMuQjomm355sMkxP3wyQ/LBq3ZLjGL/Oa3r/3lKjRCF49olZmQ?=
 =?us-ascii?Q?DI572WNWTQDjcEQOEcNGPB6Q1vct+1INu3ADpUmqVLs0tvhsl5X+4idJ9Mhb?=
 =?us-ascii?Q?RQA/RyoYSd/1/DDyw5P1XhzHxHW78beYY5K6JlfVOoEQPp1Ka4iE1huDBg1E?=
 =?us-ascii?Q?unK+6yqWfkx7faV53TWvwJNAYREYLni1G2C23XtN6SCVB7WG8O4vBjWh1u5w?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6eF88WwTfi0BRM5iSfCDgo4AqLvCn7AYVnn53eQu8VYkjL9AIGtktoh9f5JRaCPrCYPCkaTfOx2xrQVaLlNxjGS7mDWfknAkVhMdqaEN0YycbrNJquIAEOUR/mwgbHnvpbnfyrow8Rn/dg2KYX+eoMrtN8lu272uovnpi5jkDF6wpudAxFU5ZfSx7XUu/suFvW/0a/lN6/8IxK7CC0IsgTcD67JWRKX8VhgMkEQla+8Jm0H6FdeVxaWCD+7TXKz8tKc21LHNghCj3VkuuydsqLY7v6D2nFjNyNGx0faI8gVzOC4pEAwVT2UY67hAINOBmNCsxjtqfW0aOa3Cf4XkXIWlfiouQJ+Z9z+A99K4vNJhYBUWXxQWYfPxeMtr+xz/htoRRJPDgBXpsifoWDsZVyI/nhgrbLOoY/3iSBQJuFjp5lAKH7Eob0iGhnWAa510lPLMrgab7XDk/Y/1QgJaoJsIobVtIH/Z2Q+EXaWAAPLnrJSIQ5nanhHS4fQR4ZfQr7s1SFC7SdveHPXJ7QaYdBP3NNnZFYcVClob4IZ1p/gOS012tR3LimZ8TGZAwOyKqjUGPwv/34hZFLbm2LlQOAtuZ4yv+Ad8ydfmbfygh0g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3ad6ea-a3d5-41eb-b55b-08dce95792d7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 18:15:51.5494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acRLvI3S5W2RYOUyqG5FzjZUy08amFpUvxj/riluyyt4SMBTYkY0Msdx0PUJhvDzzo1cYZN0nrNsUeW/iRWgMH9ga1j+btbZSIUbb+byTGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7826
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_13,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410100120
X-Proofpoint-ORIG-GUID: VGFbpmKXnVzGlFPQJyWe_GkShlA0HmN1
X-Proofpoint-GUID: VGFbpmKXnVzGlFPQJyWe_GkShlA0HmN1

The means by which a pid is determined from a pidfd is duplicated, with
some callers holding a reference to the (pid)fd, and others explicitly
pinning the pid.

Introduce __pidfd_get_pid() which abstracts both approaches and provide
optional output parameters for file->f_flags and the fd (the latter of
which, if provided, prevents the function from decrementing the fd's
refernce count).

Additionally, allow the ability to open a pidfd by opening a /proc/<pid>
directory, utilised by the pidfd_send_signal() system call, providing a
pidfd_get_pid_proc() helper function to do so.

Doing this allows us to eliminate open-coded pidfd pid lookup and to
consistently handle this in one place.

This lays the groundwork for a subsequent patch which adds a new sentinel
pidfd to explicitly reference the current process (i.e. thread group
leader) without the need for a pidfd.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/pid.h | 42 +++++++++++++++++++++++++++++++-
 kernel/pid.c        | 58 ++++++++++++++++++++++++++++++---------------
 kernel/signal.c     | 22 ++++-------------
 3 files changed, 84 insertions(+), 38 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index a3aad9b4074c..68b02eab7509 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_PID_H
 #define _LINUX_PID_H
 
+#include <linux/file.h>
 #include <linux/pid_types.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -72,8 +73,47 @@ extern struct pid init_struct_pid;
 
 struct file;
 
+
+/**
+ * __pidfd_get_pid() - Retrieve a pid associated with the specified pidfd.
+ *
+ * @pidfd:      The pidfd whose pid we want, or the fd of a /proc/<pid> file if
+ *              @alloc_proc is also set.
+ * @pin_pid:    If set, then the reference counter of the returned pid is
+ *              incremented. If not set, then @fd should be provided to pin the
+ *              pidfd.
+ * @allow_proc: If set, then an fd of a /proc/<pid> file can be passed instead
+ *              of a pidfd, and this will be used to determine the pid.
+ * @flags:      Output variable, if non-NULL, then the file->f_flags of the
+ *              pidfd will be set here.
+ * @fd:         Output variable, if non-NULL, then the pidfd reference will
+ *              remain elevated and the caller will need to decrement it
+ *              themselves.
+ *
+ * Returns: If successful, the pid associated with the pidfd, otherwise an
+ *          error.
+ */
+struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
+			    bool allow_proc, unsigned int *flags,
+			    struct fd *fd);
+
+static inline struct pid *pidfd_get_pid(unsigned int pidfd, unsigned int *flags)
+{
+	return __pidfd_get_pid(pidfd, /* pin_pid = */ true,
+			       /* allow_proc = */ false,
+			       flags, /* fd = */ NULL);
+}
+
+static inline struct pid *pidfd_to_pid_proc(unsigned int pidfd,
+					    unsigned int *flags,
+					    struct fd *fd)
+{
+	return __pidfd_get_pid(pidfd, /* pin_pid = */ false,
+			       /* allow_proc = */ true,
+			       flags, fd);
+}
+
 struct pid *pidfd_pid(const struct file *file);
-struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
 struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
 void do_notify_pidfd(struct task_struct *task);
diff --git a/kernel/pid.c b/kernel/pid.c
index 2715afb77eab..25cc1c36a1b1 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -36,6 +36,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/init_task.h>
 #include <linux/syscalls.h>
+#include <linux/proc_fs.h>
 #include <linux/proc_ns.h>
 #include <linux/refcount.h>
 #include <linux/anon_inodes.h>
@@ -534,22 +535,46 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
 }
 EXPORT_SYMBOL_GPL(find_ge_pid);
 
-struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
+struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
+			    bool allow_proc, unsigned int *flags,
+			    struct fd *fd)
 {
-	struct fd f;
+	struct file *file;
 	struct pid *pid;
+	struct fd f = fdget(pidfd);
 
-	f = fdget(fd);
-	if (!fd_file(f))
+	file = fd_file(f);
+	if (!file)
 		return ERR_PTR(-EBADF);
 
-	pid = pidfd_pid(fd_file(f));
-	if (!IS_ERR(pid)) {
-		get_pid(pid);
-		*flags = fd_file(f)->f_flags;
+	pid = pidfd_pid(file);
+	/* If we allow opening a pidfd via /proc/<pid>, do so. */
+	if (IS_ERR(pid) && allow_proc)
+		pid = tgid_pidfd_to_pid(file);
+
+	if (IS_ERR(pid)) {
+		fdput(f);
+		return pid;
 	}
 
-	fdput(f);
+	if (pin_pid)
+		get_pid(pid);
+	else
+		WARN_ON_ONCE(!fd); /* Nothing to keep pid/pidfd around? */
+
+	if (flags)
+		*flags = file->f_flags;
+
+	/*
+	 * If the user provides an fd output then it will handle decrementing
+	 * its reference counter.
+	 */
+	if (fd)
+		*fd = f;
+	else
+		/* Otherwise we release it. */
+		fdput(f);
+
 	return pid;
 }
 
@@ -747,23 +772,18 @@ SYSCALL_DEFINE3(pidfd_getfd, int, pidfd, int, fd,
 		unsigned int, flags)
 {
 	struct pid *pid;
-	struct fd f;
 	int ret;
 
 	/* flags is currently unused - make sure it's unset */
 	if (flags)
 		return -EINVAL;
 
-	f = fdget(pidfd);
-	if (!fd_file(f))
-		return -EBADF;
-
-	pid = pidfd_pid(fd_file(f));
+	pid = pidfd_get_pid(pidfd, NULL);
 	if (IS_ERR(pid))
-		ret = PTR_ERR(pid);
-	else
-		ret = pidfd_getfd(pid, fd);
+		return PTR_ERR(pid);
 
-	fdput(f);
+	ret = pidfd_getfd(pid, fd);
+
+	put_pid(pid);
 	return ret;
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index 4344860ffcac..868bfa674c62 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3875,17 +3875,6 @@ static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo,
 	return copy_siginfo_from_user(kinfo, info);
 }
 
-static struct pid *pidfd_to_pid(const struct file *file)
-{
-	struct pid *pid;
-
-	pid = pidfd_pid(file);
-	if (!IS_ERR(pid))
-		return pid;
-
-	return tgid_pidfd_to_pid(file);
-}
-
 #define PIDFD_SEND_SIGNAL_FLAGS                            \
 	(PIDFD_SIGNAL_THREAD | PIDFD_SIGNAL_THREAD_GROUP | \
 	 PIDFD_SIGNAL_PROCESS_GROUP)
@@ -3908,10 +3897,11 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		siginfo_t __user *, info, unsigned int, flags)
 {
 	int ret;
-	struct fd f;
 	struct pid *pid;
 	kernel_siginfo_t kinfo;
 	enum pid_type type;
+	unsigned int f_flags;
+	struct fd f;
 
 	/* Enforce flags be set to 0 until we add an extension. */
 	if (flags & ~PIDFD_SEND_SIGNAL_FLAGS)
@@ -3921,12 +3911,8 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	if (hweight32(flags & PIDFD_SEND_SIGNAL_FLAGS) > 1)
 		return -EINVAL;
 
-	f = fdget(pidfd);
-	if (!fd_file(f))
-		return -EBADF;
-
 	/* Is this a pidfd? */
-	pid = pidfd_to_pid(fd_file(f));
+	pid = pidfd_to_pid_proc(pidfd, &f_flags, &f);
 	if (IS_ERR(pid)) {
 		ret = PTR_ERR(pid);
 		goto err;
@@ -3939,7 +3925,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	switch (flags) {
 	case 0:
 		/* Infer scope from the type of pidfd. */
-		if (fd_file(f)->f_flags & PIDFD_THREAD)
+		if (f_flags & PIDFD_THREAD)
 			type = PIDTYPE_PID;
 		else
 			type = PIDTYPE_TGID;
-- 
2.46.2


