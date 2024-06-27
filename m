Return-Path: <linux-fsdevel+bounces-22659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A045691AE64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 19:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2966A1F29845
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 17:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695F119A28A;
	Thu, 27 Jun 2024 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fnzx+dAH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YxAx8yUK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99334C9A;
	Thu, 27 Jun 2024 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510363; cv=fail; b=euYq9UdrjulXyi9/lo5xxYtFDLAHVglHZ6he0DXy8Moq+AX9Ji7sjCUQhiQNm5jLUDABEwkRUXVanXrSsiKv2aQtzGJAtBuBXisAvIKDYCP0m8ZBsMToIkqxBKfQTPj69KMPFsV6dDaWrSpOud/9c7H4n6r/oTIQKm+mzJfSixE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510363; c=relaxed/simple;
	bh=QGCsC++7HlKKj3pnlBM1gU/9HNB7WfZqvpugWVXXnoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o2wwhHMtqZY0+eXvN3HG2+9hsWN+dVCdH/jtmP3QcOHZjHn5tAHE5aBHkqcUYUNOlTlIu0mHvIbt3YeW8XjpvDa57DT3+/HJY+dfqak1SadVnFxn8yMQDmFOenJ4p6sWU7ZKyCdQBbTJvbKHX9VhPHTf/mKzhEZIhNS6eVWIDu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fnzx+dAH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YxAx8yUK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RFtTpQ003656;
	Thu, 27 Jun 2024 17:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=/+pI/nRuzj8KVDx
	a9Hn2kh5bBVqPhxlw1MlmOA38Svs=; b=Fnzx+dAHuMk2C0YpqYz56lpaScdv2Pa
	97K4nZfBOLDsCNg7qAL/JUYUYz+ZYTwac4EfcuKho5QAp3DD1mXsexeqEbFOCJbU
	6S8X5LXHwpixdQT+/lnlNLBgaOqyuSvUPN6J8UAu3SQWMMh+ErevBH9LLVuo0T1R
	/KyGJQRpGkIcBDOrlzcQC0l8wlDXrnc4fX+AFvJBMz0MakVChi3tryUGHdQqUlFd
	4S+qWsZakVzTAuE+vwebyvM2WHnF1CpxgORCJiqPOLhm1v1AyONbt/qHPyiBanJt
	QUivImeus7id6vTKJ9X9Uqqj/pJOfmkpyfRwaU7SbmqrV1/khx0vjbw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywp7spmky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 17:45:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RH1bNa017845;
	Thu, 27 Jun 2024 17:45:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2ap3as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 17:45:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxG1E88PxPexObisN9Uab6Mwiv907CeS/OB4fX15lCX8NtB1DTgAPJAALYoGUM8ZbTqxphxlVuP6W3wdNMIXgb3H6z276Xo+FVwroNfK079iic3SUHt/3yMuV6LadRGeCqC604oxB4/X0A+GsEZsNr9KuAso3gn1gFLBt4FD5AcO7C7KoQ6FT3NnxZ87vhiIyFmCTEOysRBMQ44jGdYsdHVy+Zfqur9JaRdsWlzr42ltEtcx1yb74MsPavyAESVOqkMSW6MQiTOIr3isfOG5VY/YcqqquiyNFQbOKk9ZnjqK/aoyDvLt1/E7Is78ru15qOAsZoUkRKrb/hW9tkStYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+pI/nRuzj8KVDxa9Hn2kh5bBVqPhxlw1MlmOA38Svs=;
 b=l+u4FbTvHjpEYuw3x1MHfbdcleTlAWca6k/vMakg9jzgGbLSySvMe8pgtff6V9f+wYruNdsRBRi/JMeBtpy+pZOw5PNBJti2E2NPS9bVQi2sxnfoZOokX6ttg6mZr0RDJHSG85QbuI0e+67d3aDRS2yLJ1xCZiTwFVt+bnBpTrl0zsYKBfNP/soEkb0bkwOqL23V8D6iXM4PUK8ywc92g9CbqpjwpZkbn/+hzEeo/LMU47NHf4Mfkf366nL82SC0Ckqu9gdoxUE910pytu+a3EtXfAMyzxl1l6eMKp2NsJBhRkYVGvN2XhiLRlncQVqeASlv2xk1smnCa+3gRnFG8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+pI/nRuzj8KVDxa9Hn2kh5bBVqPhxlw1MlmOA38Svs=;
 b=YxAx8yUKTyWubt70Smi2ZFQffR0FTGZ/ZyMDGrpQRT35hyrmVck8c/FeuCGo+HgbZHXWwXhE8du033gRqr/NBrmDd6UEmIzxULYeEr7u3WK950hxumfEUS2Rgyt6a8bWNL0zxSfFtjJCKtFOHTe1UGnJ7Phjq4UVU+S7oCs+a3k=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7545.namprd10.prod.outlook.com (2603:10b6:208:491::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 17:45:37 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7698.032; Thu, 27 Jun 2024
 17:45:37 +0000
Date: Thu, 27 Jun 2024 13:45:34 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH 3/7] mm: unexport vma_expand() / vma_shrink()
Message-ID: <gj5ugtuztq2h5uxkbeizl2jwl2r5cj7sev2qhokzjiqkhwbr2t@67rwpanaw5vk>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>
References: <cover.1719481836.git.lstoakes@gmail.com>
 <8c548bb3d0286bfaef2cd5e67d7bf698967a52a1.1719481836.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c548bb3d0286bfaef2cd5e67d7bf698967a52a1.1719481836.git.lstoakes@gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT3PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 396c054c-1079-4daf-7ecf-08dc96d0f42d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dnK5NXzGrpECBd9T4q95HlBbtO4j9CQE9OXkT6O1iZiclHSCnUl9lx6m6lJZ?=
 =?us-ascii?Q?/1LiIYHSDj8EU8piMBMoojP7AJifEAuVbU5eYX0D87Fz2PSJvgQvXTx7OxrQ?=
 =?us-ascii?Q?sEZPrlI0ByaSSF/YjKKoEuRhzhCa+TzL1qCjyqZTCG3IuAEYtk+pG9I4Ygy5?=
 =?us-ascii?Q?4QNe4bi+6rg0rRZMQjMKC4z/sqL1S2z2VNt4uRlzoXEK8qwIhC67g0qTuvon?=
 =?us-ascii?Q?Nmmhtfc0QVbSgm7IQeLjZRpvCA/zOrpgBk1RKsDJMiMrytowSQq937zUzuNv?=
 =?us-ascii?Q?89Ar7NolJuRlVefpEG3Nd1T9qt4sISPFdGiomWTH4m3S3UlQeyvav2xGsaXd?=
 =?us-ascii?Q?hHZrdeSc0EioGco+KlXlcQLV4ZqH1mnWxg95cBEeYiidsCQZQTRnhjfS+0HK?=
 =?us-ascii?Q?jjiLWjy8FBBD6j2bL23t9HVqYsgoh7SYLxM77eCwaX+0Jw2BsPZz/jDizzcy?=
 =?us-ascii?Q?pz4EmCwswMZocxq5pci9wOvUFPy+lHASJOobTZiavbl0M0phosJ/FuFqH38k?=
 =?us-ascii?Q?Yv9297YE3mfJDPJT/dgFAVOJMX6SdCNIpmDRaWIxNNxblSZ0L8yYScy+xcp/?=
 =?us-ascii?Q?WcJLDz+5Y3OyanB/yNEZhllhBSXrKUKBWrMeHrjaowI4f1cJptJA44ufdpN/?=
 =?us-ascii?Q?T18ErPKfcHV5KExD5gZguG8WpMgDKjc1xwEpuqQiqWPk2nY5qZB0NpXoLc5j?=
 =?us-ascii?Q?lTcojEiOAxWxitvHnlgJ7XaRRg2PP2kQ/bs/tuvrQtqbXrRg0YsL+wUHSTFc?=
 =?us-ascii?Q?eM5D0KU6JJRhwKl96GPDYBveqOL3bN3DiD+ymRIYk8h5ytBploP6lYZ7PrE4?=
 =?us-ascii?Q?oK36xUOSFWJZHJ6j36LaDjK5pPMFjUYwpRN/5MsES7vaGdsENOhMa/XOp258?=
 =?us-ascii?Q?T/wFHQHRx2OL5Wt1v6HY73TKgZDp9HfuubFPpvA//TDrAQYc3AWaRidt6boN?=
 =?us-ascii?Q?eOKcger6Fp9lUL7OYFOBg3ZuUCcclz7hwmoqrtsel9tIXldafjGN3l230P5M?=
 =?us-ascii?Q?dEkoDyK5f260t7gols5X2wzsButn1RzoHQaM3lzGbRJA7zK0c61PrT+aB09j?=
 =?us-ascii?Q?EV3aBJslA6/4ap3tpZG+RSwelqWEv3o0w8mP4N8wj4sL6ui3VBxs8+qT0XXG?=
 =?us-ascii?Q?gXaT6fdpK8TPwQOKAEoMM1vdsUjYfOA9go9QYRmIso8oHHmxQv0CNp6Kjzub?=
 =?us-ascii?Q?X09MfaVHWNSufYVYhVc1P4cjXuZ2PZ6bujTzu0oaOZMAxG1vYhpWTQGq3JZ/?=
 =?us-ascii?Q?6hwFW8ZJO9f9Tf9V/ErOsjsgheM5hivvONwhg7FLwhxlCQ4rQBFRqGDfXikO?=
 =?us-ascii?Q?rryVkRBBptjwuE6mwgwk2nntcVptgf2Xl8Fti9LGb0C2kQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FCxBw/p8PMLJtsI2tQTF83gGIw8O9q7kSj6dMdBZmtFwHvDytPSbipVmm6U/?=
 =?us-ascii?Q?wpCAtD2Rvgfv3qCBXe4jUTawo0miXrplDM5jbEC4rVRT4YfWwcH+lZ4WZQOk?=
 =?us-ascii?Q?tTqV8XLLgfw77vmfqVxfdO5a/b02RsDu0nbrHhgG7SKRFC2Ve5GFw6HILkuN?=
 =?us-ascii?Q?O0dsUAWs5vvP/4LulfyJyHM3FDRbcO6tVi1bp9B6HoHgXl3I7Z7XLmwhoRFm?=
 =?us-ascii?Q?cwzhdZaKJPDkTT/KpfSIPuj/Ar3VkBUhTVWwptpJ7Im80Uw6jxJ5iyM43FAz?=
 =?us-ascii?Q?AMfvYCAqU0mAO11JJfImJTcvRt8FcALPkIJWTlfDWxHqfb2+1xHUnBHe0kqW?=
 =?us-ascii?Q?oCDWKbWvvN7dSkAkYqlt2/oR5SDZy/sfZiDdA74+7K+P+qFOkUwB3gckEEYi?=
 =?us-ascii?Q?liATPtRUDS4TdXvtyZ9ldT8dHAzSCQRdHvWruT0l+ECoaDEbvyl0ib+omOCy?=
 =?us-ascii?Q?3zd32GatZ3giP4dtNnoOmxjFhMO9OfJXiGbifFmq5khqUk04Z+J1G7SmAx3D?=
 =?us-ascii?Q?6HBXZBVcXjeb035pJcxHWXVDMGh2NmPoI3UkdFK6n6arIp3AWRFZNEaIJXcf?=
 =?us-ascii?Q?+VaxoRYqsdN71J3t9LUXYdPbT3Nkd280i06ilqnUJLLZnYRfFaPNLX4glrXM?=
 =?us-ascii?Q?9Y8E12IFM4sf0RcFaccKLN3uLMh76aPsuEX/cyNSPtb7m2mQsoP9Jf2BbykX?=
 =?us-ascii?Q?fQFsYTc3R9AhkUdq28Ave5oP0diPoIMMiyl7cJB2BaJFCbIa5pziOJfHDfWs?=
 =?us-ascii?Q?9nMnQnqljsiYOOrmSpwq/aywRccpcewgRBi0vunhYzZqNTqjHh3bBqeHOnXo?=
 =?us-ascii?Q?QZdGPp4JTL5z8ExXF6Ok7/8r06Z15NHeUVNaZiXqt1SQV5Xp4PuG/rxdOZR2?=
 =?us-ascii?Q?VL4RXCKY6UcMnLbZN6gjSF/AGqI5BJd4xm0Grg6TWWF18DuWs0Vzu1fADuCg?=
 =?us-ascii?Q?eZTN82/dUbWNHclHEE28L1WMIccYaH7P/pA+BT8Y9It1fwiY7ys/mB7Yi0Hw?=
 =?us-ascii?Q?IojI85NggeipKcaXWnJ69jqZ2i51rcEQcpVhUxYAjsds0vqvhQXXnawFFlsG?=
 =?us-ascii?Q?wvyM+A8KYzRZ3LuOFIbKtZ7PX65ROJ7ZXtqpbuXQReYf6capH8E0fThuVUv6?=
 =?us-ascii?Q?wbjrWXau0crz6Id5w0cBP8barjuIcl2F3/RFlShWnqQ0S6PU76hIsqvQfi6m?=
 =?us-ascii?Q?iL4+yhCbmancKBm3gdBO1QY2iQLGxrZEOCvy1iGF6m/bQ8/2t6OGHuTia0jv?=
 =?us-ascii?Q?XcRuRQV9jfCep1RsfIJGL9l70SL9y5SzxfSIpQhCeMlcl7Kg2fyyoSo8FKq+?=
 =?us-ascii?Q?d6rAfPc7cRjLoWbc3nukr6/+F46ZMafhMNvkHFnh9bj7byxL2IBvZPYEwlCN?=
 =?us-ascii?Q?sJ9Slc1ky522bIn8tUXnb0+d4UQ7shAyaH26VEvBIV8pRzuBSdOiFxK/RH/I?=
 =?us-ascii?Q?bnsJDaIT8NRNWSjs/fcsvS1X3dqtTmqfHRIn2fZSrGdnWHA2c4gQutcc+6l1?=
 =?us-ascii?Q?5DG/gjCPWRPzCwfS74pgUAgGSV3DEtFr1mhZSi4VBb3vVHlNO88yHwp8eAR/?=
 =?us-ascii?Q?RWlGE6kUGqIWjPOhXXhTsCjOcGPDud1y0x6vXAOH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dPC7ZLeyp9EV2apr9VpY4GCcKDmdSwSS8bFwVCf+hMsCsWSWiRNRRAINQ0xT7XBDLbJEU8Z6a1keLsr0wKp3WAjYVGqNbUsFpDxyy7lxwngi55/SHYI4gYU9/Doc9QcKtSt0fFvnDePXcWt1OuHSZsrIIQ6sv87Kf3w7Z2hUzaDfgG/F3onKUgvKbZwwQeYAbnZ2CRPqAS39c+UqIzTxAATW/4jL2XAE+uRKg8NYoY9nDEoLaIfGOHNpsMXFZ5yHJB6FT6K/csPyUhd7J50vdL0HMy8OvFjo0glJlCwOLXjFeQy7weExgjpVY6xQ6RtT9RxIugGu4deYO7lw1ZR+c2zo1V0nT/LZ9MpqE57j6gGqW66+Nq6Hs8LY3l8DLpB8107mdxazH9Mxl64A4c9B0f4Qx1L3ziB8uDlVzwQodMUJmQYME0MPM9PdwOK7zPOyGJ3Fa/PNW6VEqsOZxwAGp/UBU7pLO/1KDh9YqoGy7Hu0mvG2Ob0kIYT+hoQ1NMYZIjwcSK1S3M3vEB4lrxIAUgvGJ6OCHgyEmo3U782geSNNcTmRwIUZaCUmTV+awY24J7/hYj8TWQXAquwb2caK03r74D8HMfEr8MTUYXJDV8g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396c054c-1079-4daf-7ecf-08dc96d0f42d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 17:45:37.5077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StrnQ1AR33bKJud841pmy8PVbaZ3RvYjReeizNy769PSwIW8OxdfsOmmxxjeMl0z/mnU6bkJBm3IuNatauE4cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_13,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270133
X-Proofpoint-GUID: V7Jg2GyxyldtuFzap34pGPsLxYgGYxhr
X-Proofpoint-ORIG-GUID: V7Jg2GyxyldtuFzap34pGPsLxYgGYxhr

* Lorenzo Stoakes <lstoakes@gmail.com> [240627 06:39]:
> The vma_expand() and vma_shrink() functions are core VMA manipulaion
> functions which ultimately invoke VMA split/merge. In order to make these
> testable, it is convenient to place all such core functions in a header
> internal to mm/.
> 

The sole user doesn't cause a split or merge, it relocates a vma by
'sliding' the window of the vma by expand/shrink with the moving of page
tables in the middle of the slide.

It slides to relocate the vma start/end and keep the vma pointer
constant.

> In addition, it is safer to abstract direct access to such functionality so
> we can better control how other parts of the kernel use them, which
> provides us the freedom to change how this functionality behaves as needed
> without having to worry about how this functionality is used elsewhere.
> 
> In order to service both these requirements, we provide abstractions for
> the sole external user of these functions, shift_arg_pages() in fs/exec.c.
> 
> We provide vma_expand_bottom() and vma_shrink_top() functions which better
> match the semantics of what shift_arg_pages() is trying to accomplish by
> explicitly wrapping the safe expansion of the bottom of a VMA and the
> shrinking of the top of a VMA.
> 
> As a result, we place the vma_shrink() and vma_expand() functions into
> mm/internal.h to unexport them from use by any other part of the kernel.

There is no point to have vma_shrink() have a wrapper since this is the
only place it's ever used.  So we're wrapping a function that's only
called once.

I'd rather a vma_relocate() do everything in this function than wrap
them.  The only other think it does is the page table moving and freeing
- which we have to do in the vma code.  We;d expose something we want no
one to use - but we already have two of those here..

> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  fs/exec.c          | 26 +++++--------------
>  include/linux/mm.h |  9 +++----
>  mm/internal.h      |  6 +++++
>  mm/mmap.c          | 65 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 82 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 40073142288f..1cb3bf323e0f 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -700,25 +700,14 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
>  	unsigned long length = old_end - old_start;
>  	unsigned long new_start = old_start - shift;
>  	unsigned long new_end = old_end - shift;
> -	VMA_ITERATOR(vmi, mm, new_start);
> +	VMA_ITERATOR(vmi, mm, 0);
>  	struct vm_area_struct *next;
>  	struct mmu_gather tlb;
> +	int ret;
>  
> -	BUG_ON(new_start > new_end);
> -
> -	/*
> -	 * ensure there are no vmas between where we want to go
> -	 * and where we are
> -	 */
> -	if (vma != vma_next(&vmi))
> -		return -EFAULT;
> -
> -	vma_iter_prev_range(&vmi);
> -	/*
> -	 * cover the whole range: [new_start, old_end)
> -	 */
> -	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
> -		return -ENOMEM;
> +	ret = vma_expand_bottom(&vmi, vma, shift, &next);
> +	if (ret)
> +		return ret;
>  
>  	/*
>  	 * move the page tables downwards, on failure we rely on
> @@ -730,7 +719,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
>  
>  	lru_add_drain();
>  	tlb_gather_mmu(&tlb, mm);
> -	next = vma_next(&vmi);
> +
>  	if (new_end > old_start) {
>  		/*
>  		 * when the old and new regions overlap clear from new_end.
> @@ -749,9 +738,8 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
>  	}
>  	tlb_finish_mmu(&tlb);
>  
> -	vma_prev(&vmi);
>  	/* Shrink the vma to just the new range */
> -	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
> +	return vma_shrink_top(&vmi, vma, shift);
>  }
>  
>  /*
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4d2b5538925b..e3220439cf75 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3273,11 +3273,10 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
>  
>  /* mmap.c */
>  extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
> -extern int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -		      unsigned long start, unsigned long end, pgoff_t pgoff,
> -		      struct vm_area_struct *next);
> -extern int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -		       unsigned long start, unsigned long end, pgoff_t pgoff);
> +extern int vma_expand_bottom(struct vma_iterator *vmi, struct vm_area_struct *vma,
> +			     unsigned long shift, struct vm_area_struct **next);
> +extern int vma_shrink_top(struct vma_iterator *vmi, struct vm_area_struct *vma,
> +			  unsigned long shift);
>  extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
>  extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
>  extern void unlink_file_vma(struct vm_area_struct *);
> diff --git a/mm/internal.h b/mm/internal.h
> index c8177200c943..f7779727bb78 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1305,6 +1305,12 @@ static inline struct vm_area_struct
>  			  vma_policy(vma), new_ctx, anon_vma_name(vma));
>  }
>  
> +int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> +	       unsigned long start, unsigned long end, pgoff_t pgoff,
> +		      struct vm_area_struct *next);
> +int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
> +	       unsigned long start, unsigned long end, pgoff_t pgoff);
> +
>  enum {
>  	/* mark page accessed */
>  	FOLL_TOUCH = 1 << 16,
> diff --git a/mm/mmap.c b/mm/mmap.c
> index e42d89f98071..574e69a04ebe 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3940,6 +3940,71 @@ void mm_drop_all_locks(struct mm_struct *mm)
>  	mutex_unlock(&mm_all_locks_mutex);
>  }
>  
> +/*
> + * vma_expand_bottom() - Expands the bottom of a VMA downwards. An error will
> + *                       arise if there is another VMA in the expanded range, or
> + *                       if the expansion fails. This function leaves the VMA
> + *                       iterator, vmi, positioned at the newly expanded VMA.
> + * @vmi: The VMA iterator.
> + * @vma: The VMA to modify.
> + * @shift: The number of bytes by which to expand the bottom of the VMA.
> + * @next: Output parameter, pointing at the VMA immediately succeeding the newly
> + *        expanded VMA.
> + *
> + * Returns: 0 on success, an error code otherwise.
> + */
> +int vma_expand_bottom(struct vma_iterator *vmi, struct vm_area_struct *vma,
> +		      unsigned long shift, struct vm_area_struct **next)
> +{
> +	unsigned long old_start = vma->vm_start;
> +	unsigned long old_end = vma->vm_end;
> +	unsigned long new_start = old_start - shift;
> +	unsigned long new_end = old_end - shift;
> +
> +	BUG_ON(new_start > new_end);
> +
> +	vma_iter_set(vmi, new_start);
> +
> +	/*
> +	 * ensure there are no vmas between where we want to go
> +	 * and where we are
> +	 */
> +	if (vma != vma_next(vmi))
> +		return -EFAULT;
> +
> +	vma_iter_prev_range(vmi);
> +
> +	/*
> +	 * cover the whole range: [new_start, old_end)
> +	 */
> +	if (vma_expand(vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
> +		return -ENOMEM;
> +
> +	*next = vma_next(vmi);
> +	vma_prev(vmi);
> +
> +	return 0;
> +}
> +
> +/*
> + * vma_shrink_top() - Reduce an existing VMA's memory area by shift bytes from
> + *                    the top of the VMA.
> + * @vmi: The VMA iterator, must be positioned at the VMA.
> + * @vma: The VMA to modify.
> + * @shift: The number of bytes by which to shrink the VMA.
> + *
> + * Returns: 0 on success, an error code otherwise.
> + */
> +int vma_shrink_top(struct vma_iterator *vmi, struct vm_area_struct *vma,
> +		   unsigned long shift)
> +{
> +	if (shift >= vma->vm_end - vma->vm_start)
> +		return -EINVAL;
> +
> +	return vma_shrink(vmi, vma, vma->vm_start, vma->vm_end - shift,
> +			  vma->vm_pgoff);
> +}
> +
>  /*
>   * initialise the percpu counter for VM
>   */
> -- 
> 2.45.1
> 

