Return-Path: <linux-fsdevel+bounces-32267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A9C9A2F3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 23:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70771C2012C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 21:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B633DAC01;
	Thu, 17 Oct 2024 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GKDEfDDg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oBelhuZD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9159229105;
	Thu, 17 Oct 2024 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199206; cv=fail; b=OUbsCyFjZ7jsbe5rzQjVpurC3+EDSmpjIWLrxDL/bAKPmWQYRLuEZRAX+vTd6uXwQGx64SQJQ/OaMLk+wPIvES8HGAf6pMe1lGn3WZjYWCJEo/Pqqmcq350/Km3jEvNv9xavs60c7PetgtBCNuv9nr6/nh1lnLHm6XyUEvQrYcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199206; c=relaxed/simple;
	bh=xQtjCufHcVj5a8YUnErYbJBocVT1e4GTft4UFk4adxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fr6B/2DziERk0YwlVbs4QEvbhHFU+gyXIXL5HlfRwgnj91z2N3Buk9Qn99MM2DeUEhUYCIIaAASLUxI6DAXKIbYVdXTxAKlrolgKE8Mgaqw+VYXIxl48HteGGfDKDOztuGhjn3e82A1s69rnwIzja95N9j7+y8SQod9kWsL9gXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GKDEfDDg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oBelhuZD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HKtouD006183;
	Thu, 17 Oct 2024 21:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RAj91Ze6DG6ZBIncneUlpECDpYuSfR7OmBgoH5NyN2A=; b=
	GKDEfDDgnRW5oy6HuqvhNVU3j7ZupC4KaWIyJ58j4c4GcvxEKnBkyuhYbdIHEHtX
	BWiGFHll5t9USxYj9lSESKO37CFSQQ39EyJVUjakow1XsCU7LHDLVJzlGkw14otO
	u9lK+xdkV483YiCbPnWlejJXpN69jgsUzLCTgWp+tXKwxu+rmsV9RPyLaXZt5f7P
	IBu0nCD63fwsK4HyTGxycaXCjXgY5j1JpC32diOdMbD1VUryLiztG9PO4+6+fsOt
	i33d6k/hgTGG12kpSZThd4R+lpTxkqAFKRHpVXYumSkSQriiv+klYiGyjRgnRMjc
	rrqRPTee++9tNDuKhTheOw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1aq7jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 21:06:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HJCPJN027100;
	Thu, 17 Oct 2024 21:06:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjasv4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 21:06:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoPxUWIX+iQQfApnyfcWtYEHo4jGlX1ukmoEVgfFtdus+EJah3qUS365jVWls2WOheG0ajmxpnre0Xkcxl7gCH2wzbXiHto40RypPVDjys9Cy2DhUBmWkVQrYOfAtRAytQqXLR/6qbgZSyj8B7OX/slbwmEevAOrbU54+XkVTxkGof+UGvRpKm7rSZ8f64tSpyXEiqKKiEBaHExas8PVzxKT71RIDa7bP/mowDJ/W7k9dEUN51q+y57R/uYFNixtzZf0wJ841Dqn7WHI7GIjQuRGj+Uj3qj34GUCUsd81nJUnBB8LlTooIOoi23jwm1LAfJTCRBu0cblrXGaG+8mog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAj91Ze6DG6ZBIncneUlpECDpYuSfR7OmBgoH5NyN2A=;
 b=kSA1EoHHY/lf66jTFOyPAL6mOcbD/lsz802utbcYWFVQAtsb5HLZ9+erFNmxHerHPQAphnj0IpIO0u6RxhjW0MtPXkdKx4yy+EZzyKavmoP6IZOkkycsSJ6S8AtWRpZNIwYdPMjya7L9T9F53ar+xfC9BMelFTCyMeMm6MKOC2ooOAa1nfazAn+TRy7TQxOIaIOR2SlvQ2J/R23KHzzXC/uNxtK/yWOpubWdLQL8ZOpToDQxJzeqXdNSe7lzgZMR2uV0M3Ayr5v2HM4K/INBtp+R4Kwr7iWRed4HDBil3Cg9BD4HcfnCHMfKJovKMCj3jGfS54o0v+wJZUPyxCDlww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAj91Ze6DG6ZBIncneUlpECDpYuSfR7OmBgoH5NyN2A=;
 b=oBelhuZDQ8zujMrfc3PM5Pqwp3yoHjcA3ZOCAMUdCmjVJELNj9Vez0oyv0msg7+NYIBnjDb4NZxXDFt2x5FB1cHlrRuOro3Ug1P+I7lMrqGUMAH0572kx3kmygRKvDIOPPDGEpJy9H/VJIQ70qWsl5LzC7kUxp4Ur2HnYERw6bQ=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB6752.namprd10.prod.outlook.com (2603:10b6:8:13a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 21:06:20 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 21:06:20 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v4 3/4] selftests: pidfd: add pidfd.h UAPI wrapper
Date: Thu, 17 Oct 2024 22:05:51 +0100
Message-ID: <d8d1a8c6ade7f13a100a5c11fd1e53f7f2fddba3.1729198898.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729198898.git.lorenzo.stoakes@oracle.com>
References: <cover.1729198898.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0623.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3013cd-6f7e-4ad3-ff23-08dceeef8c68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RqKf1QYas7BIecVfRckVuMTQIHcH6rD0MESHQq5Rw4jdOsP89TsRKsqy7aOw?=
 =?us-ascii?Q?+BwftWubpqjYcBEcnZyBYUcROxEwihBKxtf0oruKj9ct5s8HPp+fml+8g2Wq?=
 =?us-ascii?Q?3dpYfLuvsWNjfVuIVRkRXzN099BgALqS7qAj8Ad+W4WOQjwbT3xS1FPTarrk?=
 =?us-ascii?Q?Cjbp2mBMEtUVEXqXUclCNtFtVrmyGivUtNS+Dtc0PvSBKKBGw2NNU/cnud9a?=
 =?us-ascii?Q?9+3Jcc49hEfA2hWGlfQcUmqgs4m4fwoIzd0hMNyZXsV60S8ulQr/nW2GNFcq?=
 =?us-ascii?Q?60lsNHYGIW1nL1rnfaHJQ6NAZIJICINyGuYIKH4BAX6/Lrldhij+rPc1McwO?=
 =?us-ascii?Q?Orzw4eTbQD6SBhQTBHJBIVg7t2zb7r1xELqA6qIhO0jTf4+BybKaE7cjFtQz?=
 =?us-ascii?Q?zfLzcFggs97cR0M6hcxtKhmSFK+rNoefOWrKMrFGmzrc1yvk6jTzH2/ADJ6s?=
 =?us-ascii?Q?NwsuhUYx3sIUHNuFHycl6jLCW0cLBKQBKeSIZ8/nt0l4K9X+pzsI3jyA6toT?=
 =?us-ascii?Q?rB24f1PJbO5plgV47/nYSwSAlcglAxVefL5TFG63NI6Y4Hua8cIgYdT+0dYs?=
 =?us-ascii?Q?RwgG5KLzjqW7wFNDkIf5IlBDwcZABObhwgrqHCj8WKk0mxXnZeFPUUlH2gKY?=
 =?us-ascii?Q?5FmfZYogcFSau4rjjhHnMIFzHnl9ocr+9xp3Kv7ESgKzmgUrIT7KDkGLnKBr?=
 =?us-ascii?Q?aSK40PXsr7rAnIkf99TJWkxXCkIvI/qo9zToDD8WSGWzTSM5gt3EKaVUldmk?=
 =?us-ascii?Q?bAxw3vh0FvBieEyeT0Uy/4BalG+o4mGFW55Ki7enj76/wE7p5UX07voD4l20?=
 =?us-ascii?Q?Yn+VbNZGCWNLsZmmq4RL0yvVTMESHe17NgejCAFZhtr/zlWIEj2bfLsueJTC?=
 =?us-ascii?Q?3KJGTu9ku5smjE4qYYbOCGPU6+tpRJAMuLfQNeaK4BE5ZMsgsq+ZwDwdyFqq?=
 =?us-ascii?Q?DHNsBtz4F9zpsyWyWkbiDJSeUXfEr8yLjxvll5Maq0mqrtKq+Ci4275Y24wK?=
 =?us-ascii?Q?Sn5Aizl2Pthizd+WaFifhCmCVVnbD39i0IUdDRRqiBovkDuRDs9wDUt380iv?=
 =?us-ascii?Q?TdeEqeszUaj9r1uKfBHwLjhmm12RttsxAPlSaH+WuCMa1pIrAcqvgix5e0N6?=
 =?us-ascii?Q?KkNSpgMKQ7m1/4F6yIAdX1/FW+F0iqXW5eVtVGyeNECria/dFJKLj0ZtGC94?=
 =?us-ascii?Q?KXtiCIEEHU0T+PxRfhNWCKQ0P99jvRuQSzIksA1pXm+u5USzOuyVJVEmCmCN?=
 =?us-ascii?Q?3tvukAw8G2viXs8Elq+n0/gX3kKM+L3ENTFaMZ65PVligI7UDIbBVabnDbks?=
 =?us-ascii?Q?rEfcU1oW6Pn//zaALz8y1nAM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4m/lJtGrkyAwkMjaIof6g4tDrxuHn52fi3utolCacQpNGkRfw5mAEs+qFh36?=
 =?us-ascii?Q?vNfvpagj1HLTKb+N+73fQKfXPrCn1OmA4v62SQWF5LydEXuRhNPI8a7oSxfU?=
 =?us-ascii?Q?X6Jh9xT9W4gm2Ci6J8rTtdMfiee7qOUF784vruG7pJ7UGwUROoA7jJN9HkfA?=
 =?us-ascii?Q?/8bNeGp2cXFuzFRe7Rfh4OKy8Hw2o1KxJizYw6SY17Vi4PNzMMEHu+2rw9l0?=
 =?us-ascii?Q?PDqXke7PdEBBYs0rwlCwvuRaZpkVENjfs6Xe/lsqKe6N2fbQ99pFe7G3sUc1?=
 =?us-ascii?Q?xbISV+xEn5Dy579MitR+tp9xCVRCiTc2SaX45z5aI+59kZ8bN09J+MSLPG9/?=
 =?us-ascii?Q?goZ+mub3toWAYcw3jKteL48I25uXVsH0e6CQk+HtH8abDSzrtq1erT4aCya8?=
 =?us-ascii?Q?XTK6NluyHewT0te3lPjTAgPyGeFXw4Maf2JLNIB8gcv7WGKaT4FUz9moq29I?=
 =?us-ascii?Q?kr0NdsvrMrbU3hAKhyXIl3IlLFEqIxVuPsH4tZkeLY4V6MLJ3s1F4Zatyj9L?=
 =?us-ascii?Q?lmhcwC1U/Yk/QJQxR4C5kH7NlG5S/d/tmgil3xt+oJxz9gGR76K/YQFYwxhs?=
 =?us-ascii?Q?vVJ5oeiUe0kkiABkImnODtELE2QadOziJoRe6l1EKBwOAfBq+vNSuNv209rm?=
 =?us-ascii?Q?eBVou3qmxQ9kzojm1RPBxGwHDlEyEEIh0z2DJWKRvmd6opxn/XA+B21AQ7h7?=
 =?us-ascii?Q?bICH3Ud1USktZliJMO5sdP3vNcdaLRET3SNDdl4rdkNaCv22AW+RfLjauG+D?=
 =?us-ascii?Q?pDwPzvSVM21BEr9BVkFZFmiet/w47g70/aQcC9JZAzaStk29W0HBecMnCj0y?=
 =?us-ascii?Q?YUY6znSnGHhBL4TOUE32VELjG6WOFzABj2zE5GTWMgkK7CsTdwR+4uEGI3JI?=
 =?us-ascii?Q?bbLRAOD+UJAPI/YZPnzF9zF4hnJM/TfZHxCTqPIgkhnpWbdXoASla2/vLDjx?=
 =?us-ascii?Q?d9P2RYDtY4FNdrI+R8xuyzrAARfTT1luDoDpdk3UVLnS9agcXuwKtoc+8EwX?=
 =?us-ascii?Q?Aw6Ftr1O5jxM/Tp0J/CwxUTo7ppCSOnJ9JB4f1rLZSdJSWxxBTb6HT7xEE19?=
 =?us-ascii?Q?OAfRKie4A3VJ+XECVtd3tsONJxpB3WtO3MBi6PwhB86gOBb0zJtnrvUSpAo0?=
 =?us-ascii?Q?+o24zqqlIo/K7TmPjysGHFimL1cb4g/yUIO8gnClrO09ZeiXvXQiMuaZoZQ0?=
 =?us-ascii?Q?fzSmfij1L/8SyvpjRw2MHQFEnlEG8iX9zezMH5Q0aY9tdKSss7LMvTxDUApN?=
 =?us-ascii?Q?D7i3z2PuTeEd+S+ujsJdQ/LJyD1xLaEvAhh456QObTapHdy9c/q56kdorhol?=
 =?us-ascii?Q?Pl9PttjNbMy17CNmrvRQ0nM5Kzxk4j+u3jSlH5QTnXEc5be0P2aMkT5o049u?=
 =?us-ascii?Q?vudi8tNNpHW2yD15w8RlYsfF8CwUdabJyZrqDl/lQ2MvOUe8gQkeuNqF7sDz?=
 =?us-ascii?Q?qrd/yVRp57MxhwGbjvf0yT4KbT9Zqs8+W1cDBFYtdROwHgLKYObt1uNA4G6b?=
 =?us-ascii?Q?VT4QA4yxCQXrkITI86UCRgAwScyfdf3IRMgm70x034FcX3ZeQfVsV8/7KgHG?=
 =?us-ascii?Q?2sPgECbP++xMArmDD7SBPA/QxeJpADHaocLx0Cv4txgomShJSFxVXSfiUpzx?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QJ8WPDqxO1N4MoNP+8oZT3tG3hItR3uq7m29+f87I7WVZ2P3zwfnD4svTPUJXnLXpzf5BHljwZ2k9i2b7Al1ShzLb7Hghw37tfGNEa7LCSR/21a68YUbVHYLOj6OYTfgfgqgN9XcTd27009d0yC3Qe1WC+ZlxLja4e5PZqQZTKxNNjUtr4sKCEKdGim9Y244+GLXT85dN02d/IZQJYoP6SEl3IsSzLxLVt7wSjuAQeb/kd/nJxC6Pi+6bZbt239l5Yw3z6nS9mFypy9zlLQdVJJpkZGsi/dMaqnKktsOf5gjBN5gndr/Gbw3UDzXin3k/bg2Uj2nSckzcWfX+/5CEoHN4sp8kRRO+5gMW+TaQNJszJHBReFIqtTaFw9utru+ie0AkmTmA+L2WD4tZL2axiiYUPBPs9+7AvkgRj9nW1OZKE7O1XpUt1baUWn7fBQBtJTtOOcIISFz4WFvKMNo9Pn8RI8DjXkd9OD5zv+vUbSp1OBycvOKO9+5gEF8rJ0c80rA5P4YGZjTUPdhTs/xPtsUWdMjfSAt4zpT5riC0Q4kf+uOCMjPbBU2jxldKRUn3etk4fsmNc8pFbwXCgPy7a1dPwbKyC7O8t3FAYfSoNE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3013cd-6f7e-4ad3-ff23-08dceeef8c68
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:06:20.1247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbs/DS9dSnzTCf9tiVROuPKvCvuz8e5xiY7UUoGBxsxogX1qoha49qga5tRCg6+5qjognsQD35oDdWXqHY3ttydc17JMCRL8M7MnF0i+Ptc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_23,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170142
X-Proofpoint-GUID: dgD7fwfNYYOyQbS51OITWB6zwyI9qkjK
X-Proofpoint-ORIG-GUID: dgD7fwfNYYOyQbS51OITWB6zwyI9qkjK

Conflicts can arise between system fcntl.h and linux/fcntl.h, imported by
the linux/pidfd.h UAPI header.

Work around this by adding a wrapper for linux/pidfd.h to
tools/include/ which sets the linux/fcntl.h header guard ahead of
importing the pidfd.h header file.

Adjust the pidfd selftests Makefile to reference this include directory and
put it at a higher precidence than any make header installed headers to
ensure the wrapper is preferred.

This way we can directly import the UAPI header file without issue, use the
latest system header file without having to duplicate anything.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/include/linux/pidfd.h            | 14 ++++++++++++++
 tools/testing/selftests/pidfd/Makefile |  3 +--
 2 files changed, 15 insertions(+), 2 deletions(-)
 create mode 100644 tools/include/linux/pidfd.h

diff --git a/tools/include/linux/pidfd.h b/tools/include/linux/pidfd.h
new file mode 100644
index 000000000000..113c8023072d
--- /dev/null
+++ b/tools/include/linux/pidfd.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _TOOLS_LINUX_PIDFD_H
+#define _TOOLS_LINUX_PIDFD_H
+
+/*
+ * Some systems have issues with the linux/fcntl.h import in linux/pidfd.h, so
+ * work around this by setting the header guard.
+ */
+#define _LINUX_FCNTL_H
+#include "../../../include/uapi/linux/pidfd.h"
+#undef _LINUX_FCNTL_H
+
+#endif /* _TOOLS_LINUX_PIDFD_H */
diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index d731e3e76d5b..f5038c9dae14 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -1,8 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
-CFLAGS += -g $(KHDR_INCLUDES) -pthread -Wall
+CFLAGS += -g -isystem $(top_srcdir)/tools/include $(KHDR_INCLUDES) -pthread -Wall
 
 TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
 	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test
 
 include ../lib.mk
-
-- 
2.46.2


