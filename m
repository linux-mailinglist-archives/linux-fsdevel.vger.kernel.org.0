Return-Path: <linux-fsdevel+bounces-50085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878D8AC818F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 19:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33AE83ABEA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 17:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B65B22FE0D;
	Thu, 29 May 2025 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KRJh4XUd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QhTpLi4X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE4522F756;
	Thu, 29 May 2025 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748538996; cv=fail; b=syn1N/IeJ6rg22LU8kBB0a+u2Ia1tJzOauwkSPNA6GiVhqu4+dF3N4pq/DVJd3kLoykoRzRwgVE+xndYKExQ2VSU2Kh+LF4Hp/akA8lnAnI2dYCZOhjRSiwUxYBT0M9G/M8mQgjkybeHIdqZWXT+c+mIBMrBvu7162Gf0+GFtQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748538996; c=relaxed/simple;
	bh=IW6XIwA3EFGBvVRIY4U4jhPd8OEtVsJ3Ow+Mq2+RWEs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rec2qmNUb3qkt8irfYFEwSLD9moF1hmEwTjL//w36/RzJXQLnmdLiQQ/giS6TEvs+d6h3BJqfa8RKaI+D19PpaigTiskqXVSLT8sbNeUExN1su/Ng1vdJGLl3nE/Ln1f7HTGU3Pn9JYfbXjnQzRpxRevjKJpE7+ycH4dUdzq4Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KRJh4XUd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QhTpLi4X; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfvVF003890;
	Thu, 29 May 2025 17:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=C0IhgM2aFrY25ikk
	vTY8654pH4tmM8+nKMMijWsjXtQ=; b=KRJh4XUdeZP8wtQwCqSyripitmRH50pT
	w2FpCzaTaMPP+kuDNQrUXlLo5ZBekawB+Z55TMn2MMSwAkPqn21c2PJ27Tghpv+U
	jyAzuFFeP73w+k6H7zLKuSEWWKXGB9ZKWrSQfy9SyI4wiy7jzSYW+e7fE4kcwxw3
	Q8mSeiJcwp27DumX2GAaoR9/UjagJ1EAeOhbKIvrEX+O1Xafpmn///XgWumi/azt
	k57DI7xg/C2y/FoK0/pk/WGFhnDRSQu5WQmRuqGTC6KkHXHycDJmSKjoMNfb/NPJ
	5uw2prjFTVJseS3lNPpC35s8NJOCGIi7ZZupQHu2rpQ97i27ktjDsA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v2pf0d63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 17:16:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54TFr56Q025467;
	Thu, 29 May 2025 17:16:06 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jjfrtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 17:16:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdCdmb9czs7e37ykHuWnR/n0ww+apw+i0j1Gyfsp7d54J47/BnNpnwY96vca12REXlni+ViPoDsRzlEbg+UBrDXHRLynlh7BAqw0dbsrgkhX2bMVBnKVsEbtq/u4XZO56AiSdPd/FyzbnglRfaP1c8uzzRzyMBDFpCO6dbVEjP9g5Uf3SoE3864vwvlSyXW6HPshehulX8IFZN/bbgchbexN4FIIdXYYKbm6UtULaoQi93HsvcBVPTcEC0txsQVmBSp41IcLUG9zkmauwoLjqo/FMXYXr4t6izoU33lAP9GScATscJySN/jvZgpccn3wNJTowDfJ5OpFi9/HLatbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0IhgM2aFrY25ikkvTY8654pH4tmM8+nKMMijWsjXtQ=;
 b=KLgsvb+VYBW5gb2AVjrsuKdT7W1qkJwUaGzvX8RFmpT4bovT9hmkPXWYXCPYkySji6pdX9ZXrAKQs85gl8gzRQTN9zq9a1V64JgYcSQ9JDC0lSU/8FjenlOdZmsMsUP9qCO790DHrlocJtvkViK4+OvbIVHCCuXJPXbhnow5DwOM/8QwlUlLG6WfDs25OcdTz3vREl38cifCXFzZFkM2xnmB1PXR89cArDU+p8xVasXjHBFRS6E3bU7hi+TjkHK+Pro783ZQFPNsrrWNhh/CFhcBd9Xb11QG4/DorQMOxZ19c5KHG6AK/DtcyDUKAYTiYFujARiRUlEhEfiQiNKlGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0IhgM2aFrY25ikkvTY8654pH4tmM8+nKMMijWsjXtQ=;
 b=QhTpLi4XGET2sukDgiRCjbfBcMxKx7ZpwI9yTjJ9yNQp9iFt77EFVyOisRnk8+nqDZBauExX9SQJyvDjr5sY4USTHuUsy5zHd+dX1aJAqVoni1q9yJeJXn3mP1GRJnFU6wl07DaXzM76b/6bOykBSYwql67v9b60OnAdesc+XHY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV8PR10MB7991.namprd10.prod.outlook.com (2603:10b6:408:1f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.35; Thu, 29 May
 2025 17:15:55 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Thu, 29 May 2025
 17:15:55 +0000
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
Subject: [PATCH v3 0/4] mm: ksm: prevent KSM from breaking merging of new VMAs
Date: Thu, 29 May 2025 18:15:44 +0100
Message-ID: <cover.1748537921.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0015.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV8PR10MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f19ca56-56a8-415a-0b1b-08dd9ed478b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ERTHG5lrhNNLKxPlnzcUD/BdbnLGPW27ebgOhppWqUKaiZW2lcZ67HXmt/rp?=
 =?us-ascii?Q?bY2jMnjAT7naY2gc2fq2DABagr2TXE6mykH+J/EeWHsyTxJLPmD/c3Ccye4e?=
 =?us-ascii?Q?Tp1VzoULfAOBi1BoXvMaNO8Ed3jARHGQi9W4FkHHc3nNqvx1sohDMc/Xx3xX?=
 =?us-ascii?Q?VOyYQgiBOjAY67wfN8W4Ml275X5JfYCXDFXcnfejQHVpY5uyNpOI03O3Cx+2?=
 =?us-ascii?Q?6OWjVEphOtaWdqII3mpXcQBQlfujcSvuNhI3CQ00iCwnUGJ3TMZLAhmtU/p/?=
 =?us-ascii?Q?v2tZgWBw8QgaH3coGjqKYQ0OLBU6VKN36UA3Zn1gsVPtQXuyeu2TlEkVtslo?=
 =?us-ascii?Q?OMPXgBp8cU5z7HGMbceYoaZdmR24jpxdekGUMa86sS1hdOnEt31id8CLzOQZ?=
 =?us-ascii?Q?ujCGc6pHUiHQrZRLRo9IGFTWADt1quEFEbaTTu77Z+baSSHhZIgl0q++qESG?=
 =?us-ascii?Q?qbYPolJb7KXygmpu2CDhrdaukJdRlm1Y/3FGjHZ0tpck3/xrWXaX6jH0COkT?=
 =?us-ascii?Q?GBlOgouh3VBQsAY3MIBjaMwR213YVSVNSw8Le1cEUnUsZ3R0NdNIUEl/xYXa?=
 =?us-ascii?Q?oAbzpEV3SzP55+IXI0UpHCoeCr04wth2Tn8kgln5uOd4KdJ8r8O6Q1c7PeL7?=
 =?us-ascii?Q?ZBgbzx6tMAuc6legRVs5WfBZPjagkOcYRtpigs26CoDcP/+UoVffHeuOZxAe?=
 =?us-ascii?Q?hl0elvzkVBdi8oEu+kHkdTC4bgjmsU8dxekBEbh3z2BMfvZDTvrP38i04Roq?=
 =?us-ascii?Q?wBpYNxZ2VmBAAz+JtTZ9ctQ31+/TyjUhRH0MambGaDeQtfrSHyNPj8eMWt1K?=
 =?us-ascii?Q?iARBvSHklT8pd8kDz1AQmojBVA1xeo9VbWPMV6iC3T3SPYsZHoABweF8x+34?=
 =?us-ascii?Q?A99/5LoP3iwbVZG3rmgkvpm7erhYFnwj746HlJeUjyFOHf5TMRDbyTBJF8bN?=
 =?us-ascii?Q?C8udpcOQQ0Qa+YaSeirQdIHG1zERZkYe/3UAJyt7Y9dy2OugZnkJ5WWYeTOr?=
 =?us-ascii?Q?8OSj9OorbWlo2w3woB9OFCFp01HVK4Ev9nRM7RgHQRvet1XA8OCI0hkQVHmi?=
 =?us-ascii?Q?DyAfVYlvbB0/irNtPj9CZX01b1z5mjt8/gksWimnCHiitI2C8MMIZoMvIl61?=
 =?us-ascii?Q?8HT2YumGO3K66rK4JLD1QD6OTE1H3xzMbJUo1PoTovcR06uKxYnH1BPCtJVs?=
 =?us-ascii?Q?Tj5qfKyqhIrRwLDlz94yRHRVF929GMVfeiFYok20V04i+XoExse605R/ReyE?=
 =?us-ascii?Q?qyv6VdmEQf2cpDTIoJwQlice/9q4tV43fyz8UGCLLHGnWy8NWGjmp6J/vKqM?=
 =?us-ascii?Q?bcE8f55PZs4C1YGHcNTtGTmBQZp6bawylrdpROXmb1JnOg10Zt5dk+hlqQP9?=
 =?us-ascii?Q?GQuUYgt/QrLobpTNSBNxeEGqkMsG/ocv8hkSLJ0jDw8vR/NiSUvCpreQlhnf?=
 =?us-ascii?Q?VUN7lnwIJEGHAtiQF/DSMNfvj0QmF12P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EZse8zsVAmN/JHYIMISd0ZzRLBu0ZeL2eHr0hWL6Vc1QZOoBY/zwQLEwMyyK?=
 =?us-ascii?Q?jOpS1HaNGb7eGN5RIcDkAxMNHYUSLsgRnJzQuopnT8LZkeW1w5Dxu+lDJRDK?=
 =?us-ascii?Q?rw9a8qhxDtbuLsTZvOn0st7WuImRAhQVrx27leO42JPTjj2+vqQcaThTZp2Y?=
 =?us-ascii?Q?1cpqayazRvrCBMVdjAGdjf50tbh0ePdZ2/9Rfjk1q2d2CrzEBGb5ApEO7u8K?=
 =?us-ascii?Q?eKbqHGyIv3kxieEKOY7ggRsdozZdJ9MqgFCzmz0o9JUEVIvhVQ4n8CsRBRtR?=
 =?us-ascii?Q?s0kLeXKkLzulPVNXVnxHj3xBAsMjNaSlYN7GJDj8spV22y7tqL8A6cR+1S0l?=
 =?us-ascii?Q?k+POFnTwXf20oGaFNvOhNEtVtm662Zy+Y8cB5fjhTpymSEXibEt23Y+atZ0D?=
 =?us-ascii?Q?3jQujBPNAYTg5bdrVs9EuTEFDYZYTpUcF4cK483Nv/L6en0yDvCf7ch5wBuW?=
 =?us-ascii?Q?Orh8e0KfjOkJ+Gt0BlZ5wpEFbbJPAf97vO8C/oETvs263HBzOogfbjYVQyTs?=
 =?us-ascii?Q?PkNJYYgyRF/y/cckmbAW7hcvU1XUqq6ShzzYsiodBJrDbEWdY5O5UN9e3mNN?=
 =?us-ascii?Q?FZ/BowwW5LlJF4fgMXd19AGvx5z71u6vRqS6y/xbrOMqR2YoxkFG3G76a4OQ?=
 =?us-ascii?Q?kpA6hXgWwgplB3HLgl7HUAsu27Tyjinhj/wbacaZ+gMcyDUR7OnMVzzJ8EpD?=
 =?us-ascii?Q?iF8HnoQ0vpXdepx4mBp9dHQ8n8kAJ5YlK93xO+u2NXcPAQdY2j/T6xijUUIp?=
 =?us-ascii?Q?tjAHX0ed/EyWrRe35eFzh9icL9iT2fMhq9n69lDX8F4oqoomlJzFV6u3wWAM?=
 =?us-ascii?Q?M5bb9pD4IzB7t2upFpFB1w1VwerapMVEEa/iTCvf4/NXrxPnGfr5Y56M8LO0?=
 =?us-ascii?Q?94R1f9yw+lMztDo/gmsqnBwXxApMzRjy5vslH39SXwsVWWDq3GbdV3E8AVee?=
 =?us-ascii?Q?ysquGixUHqRmFrBmG4RDZgWSoM8dlbmfrQf7KgASEX2aTnOaLwlBBuUq8XKN?=
 =?us-ascii?Q?LX4UFL+qHZxFqd8R422oXwC04wfcLTZ7UbBnZ2ejp1lY4rQZHchvn+weBgnM?=
 =?us-ascii?Q?R5qVt5ofRjX/89hpeuXBF/uJzSymbnTT2P6s252UxUK4Lra+k6BdFkg0FJl9?=
 =?us-ascii?Q?XeG7CdW9Dr/8ZAR4tEvJgf8D2s9AI+U+O/SplNnuIGNHvrrI5EMxQUrYvP8e?=
 =?us-ascii?Q?xELTJuNhuBjpm5Wj679kpE959qKjZ6s6+zzxStXB/VLhuJ9Bh1FuZykdNXc0?=
 =?us-ascii?Q?7iyzEeY4TVqS9V4vzU8TffsgAJ9O3YXFy9tQLdLnWftwNkbSHsHCgXngWeag?=
 =?us-ascii?Q?2Dvy9kWCUaqyf/9yrprbGja4Zo1V9CCr+21jLVEPIPsqqkXJQxPFyfKR7Bw4?=
 =?us-ascii?Q?ySy59/Etrzk9jLOjMkA7srdeUDvCGGV8gPnYtDvC0b1noseN3H68YEhYIbxC?=
 =?us-ascii?Q?s1TXNLnIFFMHl4YNm97OcPambzrtQStJcVM0ZqEuXYs94G/FGLcjQC+oQcM/?=
 =?us-ascii?Q?vDcdmpcyY6V6xPVOgL2iu6uCa/75OUr9rJ80LsTnz78iikjjdgERd4I6TIBN?=
 =?us-ascii?Q?ab4SsOW3eyb02DT4pV+jj/SrSWYD+Y3ufvHb2KXAZX7+4cvz5nwW5ZoC7ls5?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qmt6X1WPs0H/FhZXzstvCdDiGs0p3nWmTigUI2pOHKjSBlpapfxm4TAwX+oSmTeSkZOCA9abqKsp60j7WVdlc9onNvpKzxHkXOefnUCLw7xV7EvddwWMOv+F6WQLyDL5oBOEO8st6Djzsh7tw1tB3H2Wyzcb8AyzLMzyCC5cGizgfYIU+pD1D+3YIGUWJbn+Jo3qQCKmh/O2XUUH+fCn8LFRdS7LRr/tIGwg+3C3YMAalxW2m3Q6TEB6lcPZ7MQnDfShmP/gTWewbR2GWJ20in8ZX53yMtYAXIQObrIE2csKv53E+1i2ysSQAOjwitPKVsI0tKbvcQHQTS5kKbRpoGoxEGj/rnr0p5hsI9iRkOK5j9mHWY6VBZTAFUlTFAKjRss7l59R4Sd94v0iU6YIF2+3cIsSVubbT6JyZNDXx0lnTyDI0o/lP+gtedHPmiqD9ZFfE8vpwaUyUtHBVO8FqVSXpDEpuKX00rBrXrVDoZkA6foVsJy2wo0JDsF20Ad23IZJmRJLS5guWw9oA/f1ah4lezckWxunBx7PR4IQkvMNugmUgZc/Cp/D++1ZWVo7Me3oMeNgG/Hn4i75QTbJ+ZXWhiF9as1fpPwhq8+2Lkc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f19ca56-56a8-415a-0b1b-08dd9ed478b5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 17:15:55.2608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6TuzMtAuOb4BODhMZBZ9X/SHDaiyiFm6VBlaH0HTHlHvzwvYb6UjWmJv9VMt2up5FMRq0X2pscLYgJGyUrefyouTHrzvzc5jppgGYsy5X4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290167
X-Proofpoint-ORIG-GUID: PDOodkjDeW0jVk-sT0VDthZT6r_FIWts
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE2NyBTYWx0ZWRfX+/8Bw9Dc/kIr q06II7cj0x4oCm7mLzGoHmZROA8qToQ454l1Czg++hmM5JIfNKAzind7+3PRzkisZ/h2Epbvgze 4DAc4vVKDv7tPZ1YXkTy3/jXdmO6UyLLTUV0XdN6jB2UJr+UGXkCjmhBCUsx1CEtlH8n1PKCCgL
 wSx9/gWb6NyfUQefh6mojl8bg4EQO5j/u1mCmY6WiANgw/5Is4hNFv2vUU8fIoL8l3NoO2cd21g ZM3SgxMQS1ikkxzV4joPI14UmhYd6uttNBvR/eyQBKKYdOK7R2StOg+o/lEcTSTZ1oVJQUGeXVA KLYBUrQRuqXXR9rzSBpYBo1wJbdgVmStN+AA7S6SEOmHAYZzQUvQI2Boy0kdS9olelsprVyO1MC
 ezdjx74QdDUE0iDPy5Lm3pJaFbZyw9He7YZwRl+bXDkZ/JwBgP339hMKtSUeBzdta+kX+3YB
X-Proofpoint-GUID: PDOodkjDeW0jVk-sT0VDthZT6r_FIWts
X-Authority-Analysis: v=2.4 cv=TdeWtQQh c=1 sm=1 tr=0 ts=68389657 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=hFX7TUO13cnaMy6grXkA:9 cc=ntf awl=host:13207

When KSM-by-default is established using prctl(PR_SET_MEMORY_MERGE), this
defaults all newly mapped VMAs to having VM_MERGEABLE set, and thus makes
them available to KSM for samepage merging. It also sets VM_MERGEABLE in
all existing VMAs.

However this causes an issue upon mapping of new VMAs - the initial flags
will never have VM_MERGEABLE set when attempting a merge with adjacent VMAs
(this is set later in the mmap() logic), and adjacent VMAs will ALWAYS have
VM_MERGEABLE set.

This renders all newly mapped VMAs unmergeable.

To avoid this, this series performs the check for PR_SET_MEMORY_MERGE far
earlier in the mmap() logic, prior to the merge being attempted.

However we run into complexity with the depreciated .mmap() callback - if a
driver hooks this, it might change flags which adjust KSM merge
eligibility.

We have to worry about this because, while KSM is only applicable to
private mappings, this includes both anonymous and MAP_PRIVATE-mapped
file-backed mappings.

This isn't a problem for brk(), where the VMA must be anonymous. However in
mmap() we must be conservative - if the VMA is anonymous then we can always
proceed, however if not, we permit only shmem mappings (whose .mmap hook
does not affect KSM eligibility) and drivers which implement
.mmap_prepare() (invoked prior to the KSM eligibility check).

If we can't be sure of the driver changing things, then we maintain the
same behaviour of performing the KSM check later in the mmap() logic (and
thus losing new VMA mergeability).

A great many use-cases for this logic will use anonymous mappings any rate,
so this change should already cover the majority of actual KSM use-cases.

v3:
* Propagated tags (thanks everyone!)
* Updated cover letter to be explicit that we're fixing merging for new
  VMAs only as per Vlastimil, and further cleaned it up for clarity.
* Corrected reference to shmem being permitted by KSM in 3/4 commit message
  as per Xu.
* Clarified reference to MAP_SHARED vs MAP_PRIVATE file-backed mappings in
  3/4 commit message as per Vlastimil.
* Updated comment around mmap_prepare check in can_set_ksm_flags_early() as
  per Xu.
* Reduced can_set_ksm_flags_early() comment to avoid confusion - the
  overloaded use of 'mergeable' is confusing (as raised by Vlastimil) and
  the first paragraph is sufficient.
* Rearranged comments and code ordering in can_set_ksm_flags_early() for
  clarity based on discussion with Vlastimil.
* Reduced and improved commit 3/4 commit message further for clarity.
* Added missing stubs to VMA userland tests.

v2:
* Removed unnecessary ret local variable in ksm_vma_flags() as per David.
* added Stefan Roesch in cc and added Fixes tag as per Andrew, David.
* Propagated tags (thanks everyone!)
* Removed unnecessary !CONFIG_KSM ksm_add_vma() stub from
  include/linux/ksm.h.
* Added missing !CONFIG_KSM ksm_vma_flags() stub in
  include/linux/ksm.h.
* After discussion with David, I've decided to defer removing the
  VM_SPECIAL case for KSM, we can address this in a follow-up series.
* Expanded 3/4 commit message to reference KSM eligibility vs. merging and
  referenced future plans to permit KSM for VM_SPECIAL VMAs.
https://lore.kernel.org/all/cover.1747844463.git.lorenzo.stoakes@oracle.com/

v1:
https://lore.kernel.org/all/cover.1747431920.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (4):
  mm: ksm: have KSM VMA checks not require a VMA pointer
  mm: ksm: refer to special VMAs via VM_SPECIAL in ksm_compatible()
  mm: prevent KSM from breaking VMA merging for new VMAs
  tools/testing/selftests: add VMA merge tests for KSM merge

 include/linux/fs.h                 |  7 ++-
 include/linux/ksm.h                |  8 +--
 mm/ksm.c                           | 49 ++++++++++++-------
 mm/vma.c                           | 44 ++++++++++++++++-
 tools/testing/selftests/mm/merge.c | 78 ++++++++++++++++++++++++++++++
 tools/testing/vma/vma_internal.h   | 11 +++++
 6 files changed, 173 insertions(+), 24 deletions(-)

--
2.49.0

