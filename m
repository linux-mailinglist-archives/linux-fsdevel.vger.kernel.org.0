Return-Path: <linux-fsdevel+bounces-49594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 172C4ABFCBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 20:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA07A1BC6F80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 18:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D567E28F519;
	Wed, 21 May 2025 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="luMna/DA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wy6550QG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089D328EA7C;
	Wed, 21 May 2025 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747851670; cv=fail; b=eoY1UVD6QIaKRFqgmLcZ4mD4E5xDtSorMNNp8T+HpBQ0wjHhu9ViG7BTR3ggss4xP15X6SAie0f5z05BHaM4TPswOadzhVdsGmXS/XxxI5yWOjb65v+YLOPZB49/hTuegCT9tSBduI6AQaD0UYbeuF15gIwpdSvb2MZD2Sv1eWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747851670; c=relaxed/simple;
	bh=Pt8H8ktigzCvBd6V3OTiV2b0tq4sUSqM8argS0OUpMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s4PmRc048FOGrqtXIWQoKXKlKf1p+Kf9bFY/LVDPU8J0FEZzV5V+86iDor2gop/O7xnOYMmGKxhQB8x4/mUY3GPgv/kz4GgEfoDkuw9ZRYpcyBpnyDvKUVAAow1P4cDrXWdPSkZB6cSqY57mf+WkzS7wIygizjeGO7CjFRZ/ozQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=luMna/DA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wy6550QG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LIBx6j014607;
	Wed, 21 May 2025 18:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FkisJEkO1oXOWT5s6JEr8l6FkKoaEUoqC+gHLyLzmgs=; b=
	luMna/DAzV2aNofcUE1e7QJZaoMEcNbCxGsTcDaTPTPWAMrGieJ0cXDomoJxIzte
	x0i1NenfpVRnHCz4AXwtHcmfGzlY2yVGERaXqqkAltkhcP6tdCiobKPKxe5YwHcy
	vvF2dlM5bezkejTcXkGtTNVqrFVnLB8zKJrMhj459NaIONR1EeZqltLwnvUWIR33
	eaMvTkTY0lYQC5TtLH9G5mDcYiUxJMVSq8wFPZQTvihuaGTOwwn19meYS6whsY//
	j+yX5dEbNqmFeGmHsh09z2v24TUdebvW3BypFukkZllC9NQMFHZrbB4z74Txz8G4
	d7A2pkHT4vQb3AZyNvFgsA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46skw6r11u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 18:20:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LHE6GD032152;
	Wed, 21 May 2025 18:20:50 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwemq9q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 18:20:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KULjCjbJMqQSA0jfTLq2SE2q7Bmm/2XqooYY2REpuKqF9xTFJN+YkQDvVA9ggRcAG61gZHtms2D6hCoj57KyoID7MYe6I+Vii7vShfDD+TGozK34j5/3gt8O750MMEm+Ys9wlUGrTOd61KP+8VoFHcrzME0I4PvsjXDkJBRUlPxGvXFaP6DwLn0iqMYTSmOjMXFy8CYeKJp8OhwQaFYn+pDjf1VwXKbBjYXTBDcXvXnS6v9hd3NVmVkAO/LPNtgVksiy0MMTFB0+0URJJ1cY43eko6r5JEBnnD7ojUsdzkRJO4VkzJdC4br8lFw+z/yOqsSXmANFs/bQilLObSZiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkisJEkO1oXOWT5s6JEr8l6FkKoaEUoqC+gHLyLzmgs=;
 b=NOam7NycuC0+Qmwx0y+GXysC4n87dNQFZqeZlp9zZizTmTuBd+93z8XPqc9z1jZXcCeOBal8U6d92sUwd57Du3E3SDnx4CUN4YceLlgmb528yGNCRG42GPXb5qr5WkfVZtO/MbHtrveZ9t3hr8hgyImtznFCmIMnmA62KpNO9CaEQXyoQ6G51OQGtsNd6IBmNWfces9x3t9v2loFQmU6rUE5MCkEC16lgJSG92dXPYXniI+iS0MXjv0tMCzd/O0HcQHq2IE1N4Yia+u3Qs+EEWuXCvxnUR/w8A49SKiLyKY+50QEl1J4cSpaBTofc+9DOr1l7PHM2JdCO731pn8tGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkisJEkO1oXOWT5s6JEr8l6FkKoaEUoqC+gHLyLzmgs=;
 b=wy6550QGvrAAT3YGSWNrdz3eMskRlOoSiluj/sIfsxivtNmCuZRZ01jQni+T3Aw+PPkeqh+UlYg75VkRT801IzMOKbHjcKSNXj1kqC+axCkn/at0o0EARMk00U5FtapSeL+Ug7iAONwEhmwJvX1ACU7ihdRJypKM7dZOVI2CZKY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB6697.namprd10.prod.outlook.com (2603:10b6:208:443::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 18:20:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 18:20:47 +0000
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
Subject: [PATCH v2 3/4] mm: prevent KSM from completely breaking VMA merging
Date: Wed, 21 May 2025 19:20:30 +0100
Message-ID: <6057647abfceb672fa932ad7fb1b5b69bdab0fc7.1747844463.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747844463.git.lorenzo.stoakes@oracle.com>
References: <cover.1747844463.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6e87f4-f05e-40b9-d3c9-08dd98943553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3j00Y5UBtFgYXPzMiYH/f2VmAXYIZ7gnMUpA2iH4gSZ1YFBzDgd7AHDaqRKQ?=
 =?us-ascii?Q?/Bbc/BZWm7d0V6I6/khnZ6wH8r6qLjCrdIeQF/JdEosaeojqd6tIVAD+h+WW?=
 =?us-ascii?Q?hwSzfYAjZVDhdvxLkPpdVxAU7CJOnsjN3FrLnDjueq2IFmoN73Y2HcCQzqWM?=
 =?us-ascii?Q?ixUtiIZkyOfU/5qgKAx+FIZUlCeUYrCEDUwK50XMlJKuwRBnSl2pGrpnIJ0p?=
 =?us-ascii?Q?QZlDRYQUt+DrJ4KazPbhfglIa7ek3XWfeAzYCw27DAki3NObVKcydqDYbQZT?=
 =?us-ascii?Q?eSlgvNbRNRMJSWa6ya9yyCfq55mkww6hnNlQG96pH3J//X4R1GyocWePmNP3?=
 =?us-ascii?Q?ji4WaR6Q8lAEH49WU2+pOqpZzC3hDyMJ6A3bRHPRG4gO6AzRMXfpdQe4y4s1?=
 =?us-ascii?Q?jFouuZDTzqAj8r/okPjqwaNt7Ph48yvdBpkdEzgZ7jww3qzDSIJiFTRDCLgV?=
 =?us-ascii?Q?HMSw6zf8uP/Ea14yR7AViNeVUHM7V6FkwjofDy7GGOQ9h27kZEeVotXr5J8W?=
 =?us-ascii?Q?XSA7cRc9X6sQZdddkweylXui5grYvwpTVUud0pDMZNwp2PLOMMKizZeZGoFf?=
 =?us-ascii?Q?D52jRqOdki7Rbe9u3QWxr2t56GMV2fzQP2jYrsA4h8hmjQL8Sbnx2A0Q+Ukn?=
 =?us-ascii?Q?MpIQnP9nwLBMLI3DY8+uMEB7JH+an6M5iCRlMi7iqg4mGmwJN0TMe2g8F1cG?=
 =?us-ascii?Q?E8ZUNunzt3+XwG19LB2Qp8mjAVIKGIB565W5FmSILpdyyx2n0WElIwPs0vJu?=
 =?us-ascii?Q?Hdy9bKNufWVWIDZpNPtTyW45NvfnuPoDozLVVFIfDqzCoDAg5Sa7LockiYjJ?=
 =?us-ascii?Q?/nxXBBkCSm7eeq8h/xRh9dMUBXCCND8TLjA6mj+Iw2+4B++KShv1oiJdpPFA?=
 =?us-ascii?Q?2OVG/xzI86SvocB8Zl4NVE+Itvo2Yts0poZ3Pl1G7xseMyZKyKalar2X1gFg?=
 =?us-ascii?Q?PrZzTmQtAWKJAFHWgK/fqIs2+1jxyH5oMXFAjegcHjqXb0i+W9JBigKQgj4S?=
 =?us-ascii?Q?Ew0rgJIxFjYY1Adq321SRm9fQljYsnJizck6NjNyaPwXTls6frG9196+LGCj?=
 =?us-ascii?Q?sPwwYlthWmM6nnwQSMX+QnPzd3Yym/tHwyA5eB7ZjVvBriiHUY3SpjgSV6AX?=
 =?us-ascii?Q?VpZR5BJmJkH9AQU3ZRhVy7KZ5uQ63jC1V1Z9L10NgVM4C5qtHhnnbImy+GON?=
 =?us-ascii?Q?ZDLu1O2FGvPYYb8mXVpz/OSmb1ZnIWpVKTzHP0JUYIGCE9J/BYM44moDmrTr?=
 =?us-ascii?Q?F8XM+aELpv9oxBFtTRsUvVCPw0myASv3hlWkqgj6FEL90hjYQBF9qIbduc2T?=
 =?us-ascii?Q?qToWAn/c6PRh+Iawy4VvpeOhP5j5b64yNpR3SQg/JZTq7Iin9oJndeK2oD/A?=
 =?us-ascii?Q?xekjSVJutpOPXSGZw4Qqc52Ko5LhmA5ydb4h3amMQa/6sPZw9ov+G3X41OD1?=
 =?us-ascii?Q?cG/15Z7J4t4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NVyqdMJ/+nGZAXqc+j3DiPCG5/VAgnqSdbbro0qPqyqIrQXPzeARbWhLoAba?=
 =?us-ascii?Q?XMlLytCELaGTpD67t+H9ULbYyAmVG57G46gjUQewSXuw31skKV6MaHcBleZn?=
 =?us-ascii?Q?9Z2M1nYrI3P6E6HWXVLq7ChosZcT3K1/LuQiGJPmNNxQPh856pApjl5kG62Q?=
 =?us-ascii?Q?sxIqfz9HuErrzHkuRi/SMEJzWw3pbONjb02qEhi3kmIBThICjEosHtLIjcxK?=
 =?us-ascii?Q?Zt24dknatyVxQnYDJCVmKgSnha60UeXpYVIpD3s9gOKDTLEgLMeG4wezyO0A?=
 =?us-ascii?Q?/bbbYBD1V9IfswLueSdyQE4Vqr2AaoSN8bV2jxzntPKyQJ7V8GSdvJCEal2X?=
 =?us-ascii?Q?4SvdWhegBiUKJ86PAsaK/8mAMLqCedla4y5kZ2WC+M2QIrXAWapkd2Lw2lwJ?=
 =?us-ascii?Q?OOG3rxevQwPUVSsBqM4GR9Lu5ckm9/ZgyL/dmtVPbZSMxPpZkQYiJ4wX6gxa?=
 =?us-ascii?Q?6M7MzEcTIAts16WD8DMAk5UkFSdtqodTLCjc5o+ZmFYl7PBXrMjR1pM+2hjz?=
 =?us-ascii?Q?dH8Scg/fJygMS89/PQ7hFSTFmhrrEC65CSCjlFhiY9fhoRwiu4HNb2FxHGm5?=
 =?us-ascii?Q?JTzyIJCl0hPF12b61xC7B+Zbq8m7Yf8ZmzHswx2m5D/pFoQPrUsv+Nk3BrcW?=
 =?us-ascii?Q?u0R3uB0P4SnFDvk1fH8vjeYb+Lq+sG3KLbLeeRXKb+3NHGvEfsH/7ZTJ4Liv?=
 =?us-ascii?Q?AhfSCxzf7qUMSMOIiBDcneadnfpoPsB0M/czUXtYL5j/q8AdBHO7OQKuRu5N?=
 =?us-ascii?Q?H/X7MvSF+3SnL1JNZrF4+YWEJq+rXtS9ri96az1+NTMuJugembByOno5Z6ol?=
 =?us-ascii?Q?WhNUQMEf5OQFtj1eLGFKlk93IJHGfhMnH1fqBb2cQVeZB6L1IbHQM/0IjZT0?=
 =?us-ascii?Q?rbo7fCMxsEMU4mHVfYRTLLSJdC/S3KgpisncDpZKHuppzsoRPxf3ZcAC/d2S?=
 =?us-ascii?Q?lILmTwYZ9wVU4jC2CSfmyQowoSKJxeKMpuWN6Mb3aErWGyoQLhEozCTLXuVW?=
 =?us-ascii?Q?VuDZJXRrIw4vY4BSo3G4GfJBxR4TCAU93y2evPpvhwRstcj6i7iA0AVhBHjV?=
 =?us-ascii?Q?PAH7MftPxRzWOFLBTs88bOFGpdD2V4K7wPJUVmR9m0dYq/+bsFtZSAwZBF5r?=
 =?us-ascii?Q?Ijj/VZzLj9dmt0BcEPVrJWfBAYCcl8+aOuiCNDlrv6NRi/RsxpLYk+cKB+Bh?=
 =?us-ascii?Q?nrLFOYN+InxyDblo9x72CyET4TzuOUcs36kkE2G03ivG4mKvdIgxxbhQ1q0V?=
 =?us-ascii?Q?diGy5yyJBg/lHUq+MkycWQhVFuO9ODa4iS/3rY5gLn59VfqKLLFkzFNMQ2Xl?=
 =?us-ascii?Q?PrHhU8f7iDytPX+F06gpkiBPaUula6kYOLBnSr4UjYnxtEyiIH+m0+c+AgSE?=
 =?us-ascii?Q?NIcQuplyVReLmVpvlMYzv6HnJD/yVT3IErVkvMYFCGg/J7h4g/eWsEOS0Lje?=
 =?us-ascii?Q?Ja8UoVT/alGzDAm+jqqOXoxGjiqa6wO+0u0CdfudcpI/Rr4PNiy1JwX8hV5H?=
 =?us-ascii?Q?RmgaRPfFQmozFMmL/3YJdgMv35vDed2bqaZBU8ufShq8N/Sn6Z2EGF1ceZmb?=
 =?us-ascii?Q?xiNg9R9OsYpd0Cx4BX6phyu5+WaD+Ixz8yjR7CvGy2784o8Fa7cT7LKTYuqt?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qja3Vv4bFxWZbYO9cS9Y/liFxbQp9su1ghe8YRXEQivqx3RjimsoxaEMFTek09CaoaNC0tI8lpPuaY3tAgdHlyWFdOXMS7XSn0aQEKwcr9YD0CetH36dXdFD7R/iM076SYmnwmfsVJymqYdcayEYwiP1k1NgrPhMZ66+zm6eH1N1F2bBFZaVCVquQeB/NQvJH9lslofpNvB6U5q+lJq9SYFk9j+gZThrIyyrFs8Yy66Q77gzwYnvnA4QLZrBKN5CknzQOR8aA26kSd8mUkW0olymLFMk7dpINjM31UdSFLSkviUOswd0xoVV61cOpoOYrJTyrRHgaslqWhNbzjoARrlao/cwNvn49jPxraG6gzt35DK589m2w7m/zj/vM1ik/I+GLY4N7n3vZ4Ey/sIevxCoEY9ML7Si3+xNpdSS8+RevaCR6KAJcsP2TFnynZs0xvzxCZ3LBlGmuuo9cUojd4WnVbK7HxSXJjK23WB3fZ5z/Sm+DPUYA9LSEOFLU8vwp9TLaf183/TBGelgOVSdYSHH6RXzKcGt4D4yuetODM5Of4e5lrc8afKFNFhLLVqXcC8GIw23jXpoPhOCbIWUHz+F0bRnpP6oUMNddho91Nw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6e87f4-f05e-40b9-d3c9-08dd98943553
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 18:20:47.4427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2T11bnlbv4qhR3vdzUiBmknmx+47cFU9Jqzhn5ipXcLmrvJLKNtyAE5XKzg5hcdbPaLWC73AUhzcDOkOovX3JVf2czGz2oxYmHavo9nnrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_06,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210181
X-Proofpoint-ORIG-GUID: JZr4R_vzXTX-TLNbZyNnhHcQtmdxiDwf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE4MCBTYWx0ZWRfX6XKee7+Umn9W wBE16lrF55GFsXJar8NZ5fL4BqvCfEEUeagRxPnCmApjw4C1fXRQKWMtKsk+r4VgstmD5A8vrAB 69Cyemg/EJ0t31E7c9wdAxSJTUpA+25Z4lFElhp+hvM+197b7xC/GK4JLHBUc9eqiXaBdngrjvE
 T6UaMlZh5r4ylFz0y1GLdwj60+oLtbBRKJC+AR2lyByMAwYasX9DyM2COgWHDp4nlwi0DFnz8t/ duZ4gkXDBQCIuo+epCIwPsOzgazYZb29pilvo4EbEagDCLAnLbdxPWM0gFqqG9QEacR6cDd3X4U DBxVK8xhkbOyxGkyuhtfPvqRmNt0H2gqPKSxYtIa4Yq6gcY5bG8t+cgrKE4BX3PKcu+8NnPSi9A
 Njbl2wXoVnny89GKQUj+WsZnAbi896KYgoN0XfYUqdWKaAXdYK5gV58eMNYIDHLJv+Rl5CBE
X-Proofpoint-GUID: JZr4R_vzXTX-TLNbZyNnhHcQtmdxiDwf
X-Authority-Analysis: v=2.4 cv=IoYecK/g c=1 sm=1 tr=0 ts=682e1983 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=rPgcKIkS7eLJc_CnTLkA:9

If a user wishes to enable KSM mergeability for an entire process and all
fork/exec'd processes that come after it, they use the prctl()
PR_SET_MEMORY_MERGE operation.

This defaults all newly mapped VMAs to have the VM_MERGEABLE VMA flag set
(in order to indicate they are KSM mergeable), as well as setting this flag
for all existing VMAs.

However it also entirely and completely breaks VMA merging for the process
and all forked (and fork/exec'd) processes.

This is because when a new mapping is proposed, the flags specified will
never have VM_MERGEABLE set. However all adjacent VMAs will already have
VM_MERGEABLE set, rendering VMAs unmergeable by default.

To work around this, we try to set the VM_MERGEABLE flag prior to
attempting a merge. In the case of brk() this can always be done.

However on mmap() things are more complicated - while KSM is not supported
for file-backed mappings, it is supported for MAP_PRIVATE file-backed
mappings.

And these mappings may have deprecated .mmap() callbacks specified which
could, in theory, adjust flags and thus KSM eligiblity.

This is unlikely to cause an issue on merge, as any adjacent file-backed
mappings would already have the same post-.mmap() callback attributes, and
thus would naturally not be merged.

But for the purposes of establishing a VMA as KSM-eligible (as well as
initially scanning the VMA), this is potentially very problematic.

So we check to determine whether this at all possible. If not, we set
VM_MERGEABLE prior to the merge attempt on mmap(), otherwise we retain the
previous behaviour.

When .mmap_prepare() is more widely used, we can remove this precaution.

While this doesn't quite cover all cases, it covers a great many (all
anonymous memory, for instance), meaning we should already see a
significant improvement in VMA mergeability.

Since, when it comes to file-backed mappings (other than shmem) we are
really only interested in MAP_PRIVATE mappings which have an available anon
page by default. Therefore, the VM_SPECIAL restriction makes less sense for
KSM.

In a future series we therefore intend to remove this limitation, which
ought to simplify this implementation. However it makes sense to defer
doing so until a later stage so we can first address this mergeability
issue.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Fixes: d7597f59d1d3 ("mm: add new api to enable ksm per process") # please no backport!
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 include/linux/ksm.h |  8 +++++---
 mm/ksm.c            | 18 +++++++++++------
 mm/vma.c            | 49 +++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 64 insertions(+), 11 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index d73095b5cd96..51787f0b0208 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -17,8 +17,8 @@
 #ifdef CONFIG_KSM
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags);
-
-void ksm_add_vma(struct vm_area_struct *vma);
+vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
+			 vm_flags_t vm_flags);
 int ksm_enable_merge_any(struct mm_struct *mm);
 int ksm_disable_merge_any(struct mm_struct *mm);
 int ksm_disable(struct mm_struct *mm);
@@ -97,8 +97,10 @@ bool ksm_process_mergeable(struct mm_struct *mm);

 #else  /* !CONFIG_KSM */

-static inline void ksm_add_vma(struct vm_area_struct *vma)
+static inline vm_flags_t ksm_vma_flags(const struct mm_struct *mm,
+		const struct file *file, vm_flags_t vm_flags)
 {
+	return vm_flags;
 }

 static inline int ksm_disable(struct mm_struct *mm)
diff --git a/mm/ksm.c b/mm/ksm.c
index d0c763abd499..18b3690bb69a 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2731,16 +2731,22 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
 	return 0;
 }
 /**
- * ksm_add_vma - Mark vma as mergeable if compatible
+ * ksm_vma_flags - Update VMA flags to mark as mergeable if compatible
  *
- * @vma:  Pointer to vma
+ * @mm:       Proposed VMA's mm_struct
+ * @file:     Proposed VMA's file-backed mapping, if any.
+ * @vm_flags: Proposed VMA"s flags.
+ *
+ * Returns: @vm_flags possibly updated to mark mergeable.
  */
-void ksm_add_vma(struct vm_area_struct *vma)
+vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
+			 vm_flags_t vm_flags)
 {
-	struct mm_struct *mm = vma->vm_mm;
+	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags) &&
+	    __ksm_should_add_vma(file, vm_flags))
+		vm_flags |= VM_MERGEABLE;

-	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
-		__ksm_add_vma(vma);
+	return vm_flags;
 }

 static void ksm_add_vmas(struct mm_struct *mm)
diff --git a/mm/vma.c b/mm/vma.c
index 3ff6cfbe3338..5bebe55ea737 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2482,7 +2482,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	 */
 	if (!vma_is_anonymous(vma))
 		khugepaged_enter_vma(vma, map->flags);
-	ksm_add_vma(vma);
 	*vmap = vma;
 	return 0;

@@ -2585,6 +2584,45 @@ static void set_vma_user_defined_fields(struct vm_area_struct *vma,
 	vma->vm_private_data = map->vm_private_data;
 }

+static void update_ksm_flags(struct mmap_state *map)
+{
+	map->flags = ksm_vma_flags(map->mm, map->file, map->flags);
+}
+
+/*
+ * Are we guaranteed no driver can change state such as to preclude KSM merging?
+ * If so, let's set the KSM mergeable flag early so we don't break VMA merging.
+ *
+ * This is applicable when PR_SET_MEMORY_MERGE has been set on the mm_struct via
+ * prctl() causing newly mapped VMAs to have the KSM mergeable VMA flag set.
+ *
+ * If this is not the case, then we set the flag after considering mergeability,
+ * which will prevent mergeability as, when PR_SET_MEMORY_MERGE is set, a new
+ * VMA will not have the KSM mergeability VMA flag set, but all other VMAs will,
+ * preventing any merge.
+ */
+static bool can_set_ksm_flags_early(struct mmap_state *map)
+{
+	struct file *file = map->file;
+
+	/* Anonymous mappings have no driver which can change them. */
+	if (!file)
+		return true;
+
+	/* shmem is safe. */
+	if (shmem_file(file))
+		return true;
+
+	/*
+	 * If .mmap_prepare() is specified, then the driver will have already
+	 * manipulated state prior to updating KSM flags.
+	 */
+	if (file->f_op->mmap_prepare)
+		return true;
+
+	return false;
+}
+
 static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
@@ -2595,6 +2633,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
 	VMA_ITERATOR(vmi, mm, addr);
 	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
+	bool check_ksm_early = can_set_ksm_flags_early(&map);

 	error = __mmap_prepare(&map, uf);
 	if (!error && have_mmap_prepare)
@@ -2602,6 +2641,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	if (error)
 		goto abort_munmap;

+	if (check_ksm_early)
+		update_ksm_flags(&map);
+
 	/* Attempt to merge with adjacent VMAs... */
 	if (map.prev || map.next) {
 		VMG_MMAP_STATE(vmg, &map, /* vma = */ NULL);
@@ -2611,6 +2653,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,

 	/* ...but if we can't, allocate a new VMA. */
 	if (!vma) {
+		if (!check_ksm_early)
+			update_ksm_flags(&map);
+
 		error = __mmap_new_vma(&map, &vma);
 		if (error)
 			goto unacct_error;
@@ -2713,6 +2758,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * Note: This happens *after* clearing old mappings in some code paths.
 	 */
 	flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
+	flags = ksm_vma_flags(mm, NULL, flags);
 	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
 		return -ENOMEM;

@@ -2756,7 +2802,6 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,

 	mm->map_count++;
 	validate_mm(mm);
-	ksm_add_vma(vma);
 out:
 	perf_event_mmap(vma);
 	mm->total_vm += len >> PAGE_SHIFT;
--
2.49.0

