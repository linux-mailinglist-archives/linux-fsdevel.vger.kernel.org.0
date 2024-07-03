Return-Path: <linux-fsdevel+bounces-23022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 895FB926013
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 14:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53E02B2E320
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 11:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497FB174EF0;
	Wed,  3 Jul 2024 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qc2RP5Gk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wBysTfUh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5161DFC7;
	Wed,  3 Jul 2024 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007918; cv=fail; b=URURl8rWbJI3TvDXoFUGX/8afhojqINC6NP7rExLOSU2v8GcnPstSlITv1ViymfjRxVwvs5rD7qpkCKvXVHdai/5WavPLk404VqMIFBrblPpLIqu+l2FjxoCpbjD5Wje4dVzk6r63NVk0e4FgaN8yXSse0d8Lq9x+ybNFUCisaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007918; c=relaxed/simple;
	bh=jewyOe6Vn9f1chPXCpGR4ubI4n0ms2ip6g94ejRpxaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S7R4Cly2N+tvD1cTF6L56vPkcjMCbLrb3RKXoHCHILBNkAum+0VJCh/7ZKFMPquq8Lx6fRlCvDC52B98acV3isW4wadKBkXH39Y1gfFzIXAZiJqb3YafSNHB/RNodjVvWi7KwixDKAqMSodYxh6dEM9/BjtwKLDeiBLlPomEbWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qc2RP5Gk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wBysTfUh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4638O9mL008131;
	Wed, 3 Jul 2024 11:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=LppbTmxL7SanH5/9hBCtpQL8LVm/XBspRFp2C5Ys6nk=; b=
	Qc2RP5Gk6EKdXfVqZmbz+5OGSz1lL/bW0yVFjYAySGvWhOytu+YEDvdBBbmt9LNV
	FsTXZ0X6FLiMxXSoJ8HNNbSvTUgL3R+c0EZ0BBga9j0LNjUoQKx67bFEtj9+aFed
	rx9vmXTDGVhLZ/cxNfjXBKVMdqxVWA7c4vTOMERoxHV+rrJrvcWN+LoEdT8PBcMg
	uvv/9qsRs9vPaUGJ6cpJCNFUkoluwSFJKiZShLpObQwaluNAwjgzdc0OqMzqdkFb
	Zb+JJeBSl7Jlydf7KzmqVYV3NZucQmyW+mzMe8s5FZAcxp3/z05dOWvWzuHvJBCh
	mG73xTcLs0Ilubot5ssLRw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028v0r1uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 11:58:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 463BCrMJ010934;
	Wed, 3 Jul 2024 11:58:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q94r3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 11:58:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4vDzY2c4m/rUaYtkzNLjuqW7oTmcmJ0Q+Dz0t8eU16kTz7ZuzuPAf/Lk42EK5TO/kRlkRSqRf9lQAIy6iojvHa+gdVVto3WA8K+6vheb3yWnNONnWWK/L00LB6mNBdsI0CYJQUsrOrIsLs8sk3yv9b7Q2pEqf8KUeKFnzCL+UhRI5qEZVYLmvl0XFpBx0SL0v+fZjyYojxQC1tYpQJ07Yjjd9CVngVp34o/No0EFz/hKfU1JPVn9hMXFYmE2qm1XDzJDlCtCk/BZ0ONyVChdJk9hm0rUjfke9fR4wgqqdgm7VWAmIeOQic5SGoFm/XeeGVaDS5HppJzCzYc+YgvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LppbTmxL7SanH5/9hBCtpQL8LVm/XBspRFp2C5Ys6nk=;
 b=nDrYS+f4uLLF5iWI4c4uBfBTgXumqqsEtjszC0aRaRiVr5U6Kp2+TLJeO57aVvQyz/eoQ4ideAE/AUbIjkrqIgD70KZSnuYEGbv8uZZvWYoSwyIC4NAdZcUjYdhlmqyLcdhmgWYT9uHhU7fKCVtowqDra3Rez88iylPRdlHhHXBFvLf9tm5s95FFOiVBeMyUiitoplEK6m9VegqpKYv0vo+80jaIQxG9wFhkwuLuzrY2cbYbQXudF+Kg87r0CLZhmz4QMY0dCPCAKMqzJnP5zGqJ1a2PVatJgvPtaz60zfaafl7nIpb41AyW6Pxa9CB8xXiBauXTpCWsXP4hHbqGEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LppbTmxL7SanH5/9hBCtpQL8LVm/XBspRFp2C5Ys6nk=;
 b=wBysTfUhDlOJ3lrpOLxJBkWI2vGiqtIuzJCLU2XlMno1BIIR/jSYf5JFk9LrNgZ+ikHiGXZLLn94VknSIe3JOFTeoa8OUzV6+wpbrTY8jDtVCLEU52z0LXTWoQFTeyuBEhNV8bfwRd2Ub9WcbORwKGMBCbEv5RhlBggBoMoaaZY=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CO1PR10MB4676.namprd10.prod.outlook.com (2603:10b6:303:9e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.39; Wed, 3 Jul
 2024 11:58:13 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Wed, 3 Jul 2024
 11:58:13 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH 5/7] MAINTAINERS: Add entry for new VMA files
Date: Wed,  3 Jul 2024 12:57:36 +0100
Message-ID: <7177e938f13dae3e44fd77d39f1f1b3e935e4908.1720006125.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720006125.git.lorenzo.stoakes@oracle.com>
References: <cover.1720006125.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0203.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::10) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CO1PR10MB4676:EE_
X-MS-Office365-Filtering-Correlation-Id: 15bb3fc2-3c6e-4b75-b08a-08dc9b576ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?sdm7yOWyJhvtaPWzk3NQUfXIkj9Y/2cUo3+qK8g67B6sQ9VDp2Eexy1Qjxt5?=
 =?us-ascii?Q?D1w2/9xshUCVhlAutIAYbFEMhbSJRlKhXxzfmUpr63hzcca01h7obwf/If1j?=
 =?us-ascii?Q?t8ImOLdCd+z2wirjM7ofuC8JB43MoHsj2QZLwWpd94jXbjKIGhIYKDVkAgcx?=
 =?us-ascii?Q?iuTmuscOf7GEKYCIxUmbULvUU2H1ou0tzf5mW6c19wWSD18SlmA01KETkB+V?=
 =?us-ascii?Q?kcAS0wyq75kUEjjeJ6/gvhu+5rhE9Q4p8mpyxyDkFUASGUDJl2aGs+Woe3j8?=
 =?us-ascii?Q?ze7f39Fwy57JbP1QSo4f4zQrb7ULE2FYOwkZARutkTxSbhKaOGipMNNhKQyq?=
 =?us-ascii?Q?0QTCrt2Xnm+YJ4Gd1iWmr6CXGiHbIxN0uz6sOXUiJotKvBw44rd22cYBCBXu?=
 =?us-ascii?Q?ve1wpotjynob0ClP6b/Of4Df3iIgPGLMC3TcqmJxykxuF7Z+P67R5xfz6Qvw?=
 =?us-ascii?Q?08WWoUbwcUfTSTIxuaSRM4t4RMiONw0PSTMMjZaLE7yl7IYtq9GblJtEPNNp?=
 =?us-ascii?Q?mjE+8T6hZmANx9MhWurWiO7i2O4wKtbhdCsSGRp3Rn8J0hJRsqhhEbDpT/fG?=
 =?us-ascii?Q?CAZqiUVUUXd5dC08x9qq/0NSpPWilLE3KbOd+vMETQA4BmEXeMKaOYFjh68+?=
 =?us-ascii?Q?eQK4BTXIcYbkiNLykWK806Fudc+SsAMbd7mqDOlSuyTS9Bb8uUBj2/x/vCOz?=
 =?us-ascii?Q?v00Heh3V4PMQYGbSobpiDPFec1rZpregXQdaTPY01UomRvrnXOW2GXpaTSS8?=
 =?us-ascii?Q?hFhbpkW5nY8T3NUm+cDtqvaKp9v9kuwCyKUzBFt/olwMoSw7hNFrNxMKytnV?=
 =?us-ascii?Q?Dzdm1TsgrcDV13G0J9XqNXZVvdYroXbJH6G/v8hN2cPFkoEKy90GQ9pRlZ7l?=
 =?us-ascii?Q?ytWrVAl+GbXitn8ANy2X6N4ixraa294tMkgnw5Vm075DiXhIP1SGkwWaqeKw?=
 =?us-ascii?Q?ubTSgUL4r/BaRoR3kNPll8pqrTQumz/YuYMJIpWtEgVulnNFBPb/9fL/wGJt?=
 =?us-ascii?Q?X4Iob+T/d4BQvOlmMFygfkeIoF4I9Pd1/b+TUFyjMbONJ+KzKbr4k+FaqRgu?=
 =?us-ascii?Q?A9A0MYJqmlOtRpmpbTw9RxdLwjp81Rn9dKbGFcWjF/zlJAuOQMrxgSZoswbt?=
 =?us-ascii?Q?+HrCudGECENfSI+1UfUhXPyBB0XaohhQ/pnb8519u2I41Ht9ClptruLkueSB?=
 =?us-ascii?Q?LTqF3eEFHrvpOVrM/OPVqA10/NGI92SVsXIJD61rZUgAec8Vi4HJWzrniVQ2?=
 =?us-ascii?Q?gMSLK2Co2oS+GpT6wJ1+lukFfBTxldkzEb8KZ8znWds8x8GA/zfb9MW0C0sd?=
 =?us-ascii?Q?zh8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HLIIuoZtEHypLjazK4lIUwFHlJ6rP5CGjQxXiMQC01XOn51CKtM+D6S4qDy4?=
 =?us-ascii?Q?3BHVjPz2GwepTHhE0uNLNfA+L5mPKKucN9y80YxEyh0W1k6Y3z+1Z8pb4jjo?=
 =?us-ascii?Q?Q4s0WfC/Yehl2xUdf6efk1ciJfWVhZpQTUbu9pDDxp1ouBY4oyZBnm2EKRJA?=
 =?us-ascii?Q?dvNhmFgESEXxBAgOny+caHaPO1NNApzCcK8a3APcjnrEkk2rOajc2I22iXX1?=
 =?us-ascii?Q?EM6rE69WwI/5IN3xPDqPJlpeRA/383l6ekFQl/cPHc2JLnLPo36Qv4Br/cNM?=
 =?us-ascii?Q?J/q0GmHd0LyLmWbOAGpDwXbWIM2WUDm3HTAqO0yHP8DQT09lMhxRLcfrKCta?=
 =?us-ascii?Q?WXpG9UTmUqjFJgxpF+dqv4FtDzj7oDGptDW0dzKaKYirtsywKidcvo6nOtRB?=
 =?us-ascii?Q?6uaIaCLKorOil/LbVNN56I+ch9X01DpLduLPiuxP2GRqWDpKNSAp+D+Kw5po?=
 =?us-ascii?Q?ubulF2StQYATCbHaCEfAxEEhonlLcVV/JSfJ8ypWqr5M9eD5ydSMAcKH+oHC?=
 =?us-ascii?Q?sRncZn5BBVjf+HqbrXVRwCHIZ+L52SjqZYLOsi8enjsyD4a8xGZKurcKXfN4?=
 =?us-ascii?Q?pNcfhU9CEIXNvdC98K9xFeLkbjLnxEjv7+wfGlhHPo63XfZOSpXo6BcBdpGU?=
 =?us-ascii?Q?gsshAzQXQBtRmsNJMIBxvL1M0Z3ZXl7sbUZHV13bdnBk0sAspCiS9gHeKPjq?=
 =?us-ascii?Q?UM0xHrQl7rVt9SpEnlMQoKmKC2EAw3BIyQZTNkbtdWPeLqqGtCZ49YlF3FXN?=
 =?us-ascii?Q?mWhGC60gKG/l2NoIpMnD0412DYmGS4NcokcSDBZ6mEG3HMiHf+NW9Mz/uZWl?=
 =?us-ascii?Q?It042syGSj+zJELc2zSOuv97LvPGrlZ+kcQF05ll84InGW11d6JvbJlitr/7?=
 =?us-ascii?Q?G8EITWGvejpwSKmFXZCtaB1n0F/FF2lxu0UBexFSgTSIc8nf0cibbshacW71?=
 =?us-ascii?Q?/qHzdmd0U/5yxWA8xm523Kwf2eH613KYfIcuSeCrBqj0sR3FkhXoCyEcQstl?=
 =?us-ascii?Q?mTz0j7SL1MfyeYIlNAmpBC893rkiA+NsA07MakhcI3ueapXx6h9twsabaQ2W?=
 =?us-ascii?Q?VaLDlGFx2LJL5ekPlh/jZjzsJzsrgxgKlEo7DipFSOtISqM1RzDaVMG/GcQF?=
 =?us-ascii?Q?oATZxU/dTs0ejE4HrJ7sBv3S+WLhwppzCffkfBvGsuZ/0N24mKHvvQFxnm98?=
 =?us-ascii?Q?HrEcQCw/xO/Ep2piIiyGp2XXzbCXIUmuM07AoLsCcTI5Jm3Xp2zgVMkTGNfg?=
 =?us-ascii?Q?5z1zkSfFBs/z7ICIMSUx3Xxv2A4aO4MQvnemY5SQQy0W2jcanZOY0UQGdBDF?=
 =?us-ascii?Q?zo/gisg0V6pPPJvZTR5URfR59HjwyTIWu9yYG7M6KsPOP+WmO2JdMxdxPNFj?=
 =?us-ascii?Q?drML5vjMbNnoyEB8RO6YuA5KnIWuy76wXsQhMEF/Ra6vSdKe356Q21b9onfp?=
 =?us-ascii?Q?QpDMAWmzxpQJpqHGsqLTCPQ212Kgy9rJK7/UhK2WI24o8WlXKNN+vICtT7Br?=
 =?us-ascii?Q?PW3OjhApBiTIGY2opmit3x+wQR0IGqHkJ+HWeHCZG/TFDjje2W2IomvAdrUA?=
 =?us-ascii?Q?OLQNHLmswm3Z7zKLfiklnp6j5LoFA6gNvThTCqbIu1qU6p/dLF+qshwe89DB?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oT0LFHu0CTShB5rU2ILIBvcqyvia3MaQ1l77EnYFR0KhiSDEk1UzvZtz5nJ5t8EZggwfbLDsYBsQDNkXyYbgZcyZ6+kLaCMc+RUv1KMsQclLEkkY1fOgOc4XyqMSPGPUTOjVGEgtOqBqIL286h/+qffBdyRzxvhDroQp8anulGYbEmOO7MFMIPfpN6E1LZ1q4QeX5UsWN9KcLTyMTjN60Ze5SlVUgRL4iPIu8OcVAev9gBbxelVLO3krb5/EZEhivS9/O4og/VVMVwT1kQdJjKNMti2UDhXOTr7ZVmLBNlG4TMyZxSRcvwSkOMZqdwzL7PZBJ866KfaTJfAbJ3Xkg2sTTEOqgu35oKt28mVvROkg6iS2kpv4/xDeAD9dtdDqDeIlOPzo/LmhQusGClQI5+NcDqVjqPIMhOa4V9j+UUdrz7x6q01FNSKlm7QMypBb09ZzqJRGCjuY2wE2MGxc0vZXLAH3w+dkupVnCX/g1OY19yEt2Y0S10uUsxYpNiBvxbQQxgw5zdG6524roSWdHHjdhmtCyJSkSy7BTMCHjF3GfwFldEmG3SOUCdM8qm8eYoDo2rAnCSNEWN0//BGRdar9KvCo85HkwFrCsKJKL5Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15bb3fc2-3c6e-4b75-b08a-08dc9b576ac3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 11:58:13.6037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlcW+t79iq686M3DAu4te26VWI0OIDM40/iXyNFjg8lpPCiagJaeLwxerIzPEB8xardkf9KDh4z9eVKAquktvDdDTQhI09fTnZMrBN1Q6fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_07,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407030087
X-Proofpoint-ORIG-GUID: 5XFDISORlesfDbIytP-Y4ElOBAYdqWU5
X-Proofpoint-GUID: 5XFDISORlesfDbIytP-Y4ElOBAYdqWU5

The vma files contain logic split from mmap.c for the most part and are all
relevant to VMA logic, so maintain the same reviewers for both.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 098d214f78d9..ff3e113ed081 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23971,6 +23971,19 @@ F:	include/uapi/linux/vsockmon.h
 F:	net/vmw_vsock/
 F:	tools/testing/vsock/

+VMA
+M:	Andrew Morton <akpm@linux-foundation.org>
+R:	Liam R. Howlett <Liam.Howlett@oracle.com>
+R:	Vlastimil Babka <vbabka@suse.cz>
+R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
+L:	linux-mm@kvack.org
+S:	Maintained
+W:	https://www.linux-mm.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+F:	mm/vma.c
+F:	mm/vma.h
+F:	mm/vma_internal.h
+
 VMALLOC
 M:	Andrew Morton <akpm@linux-foundation.org>
 R:	Uladzislau Rezki <urezki@gmail.com>
--
2.45.2

