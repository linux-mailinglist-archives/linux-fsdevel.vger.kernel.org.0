Return-Path: <linux-fsdevel+bounces-52508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CF8AE39CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60EE93BAA14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 09:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40CD231A23;
	Mon, 23 Jun 2025 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qOOPmryd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m/+OXddM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99C02940F;
	Mon, 23 Jun 2025 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750670339; cv=fail; b=L0ZX9SPujmLBGMvwHcgkjgoSQyngrCBkyAP6Oj+tgDudKRNsAJ30uIhUNL8K3sGT484I5FGJqrgpjue5v3Hh2i6D3MefOJvM0UNN+aN97BEU/pFhtChubspn4PwsKwFftbjIJuBmK7sWUxrzuDfKLP0osnlY/TmEm2xiL9GfFmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750670339; c=relaxed/simple;
	bh=UecfOdvWZut2osdXqXbprsvbjYG0MXq4lLwJK4lX4qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KsTUYqwQEZm7y2FPq6xFGn60l7CNmW+E9LT7WvN+ZODLQDjbWXBFSzp1QkI+edSom+3h7ibKVkVMy+UO0zeNnUdlHRrKEWBTpDwO9wcProbbbzBAcKtNMfgy/w3woZvoD5QfB1rWAtlGBSNnkZOAjJ70Q4CI53Jm5eCqEB3CA+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qOOPmryd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m/+OXddM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N8pQ5u027107;
	Mon, 23 Jun 2025 09:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=UecfOdvWZut2osdXqX
	bprsvbjYG0MXq4lLwJK4lX4qI=; b=qOOPmryd3DwB1r8L20EuPhEE1WBbXxlIpk
	3Y8L11nEggz4B1Gv2ikk8gfaJYPaPI4acbFVaXkNfkN8kXntEwLomuzmlf3EmvS8
	nBpaSTyU03ggOPoXCNe9mgLDL1lZOauhFP7QFIfGlSbI+rrt7lgqlmE4G0yG8vV0
	HPcYZUp5q8tz2aRHrrJKLK1Ky0BLBgccG6VvpMeFxzV74Wwn9YvjUYQJZB9ncl2v
	whggjPlthXBtS+x8tdTTP59uVAwKxDLr/3Anyck1eEu8BLAQeVn2z67hqediWytA
	A5vWHyrYZ8yIbc2al45xPd37OetLyPFjDi0Zc347qVKshwDai5Ug==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds8mt9pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 09:18:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55N7H5SF002354;
	Mon, 23 Jun 2025 09:18:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpbkqf8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 09:18:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7ZmaBVAl0TQgmSA/0a8kKhbZbTnPWVxJAMz02s5Q5YaENfOp2wNDm7yRBHggSoVzRcUvWvSUbCXpGPZZ9vCDbJoa8Ij64QBmXMu+vAsZwBAobsuMzOMSEVCesVPQj/lAANVz2Sn/5g9+9cThFm4LHp4murt0ZvDhiKbwxGFRdpTyIcQdFQ+A0tnDUEmU/ELYVo4an5hYK10VaOit119r+I/PyN9A7jgWErPETriYivTl+PZMVbJXTsapupem0qgf1bGFNFp+5coTkORX97nqJwBwjx7b1pcv8MlwTnGZyJWl98ZyDbIkalMsoypx1dIjyHoMiqQnYN8uh9JEWNBMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UecfOdvWZut2osdXqXbprsvbjYG0MXq4lLwJK4lX4qI=;
 b=nIR91hMaj8dtrY+Oo7v13nQom3V67KL7KIxYY6v/nozJwpWUH1pBAaEnRDENrV8w55MU/pBxmnK6btH2dAzkmliHGhjpFig3EsBExLYOYEt91vg9zXAQzfzVi9IiRUFBt2vqS6J3u0oNyaZ/0M1Pkw+FrSr4f3j4e1Eh4AZMqOk1tId7GUIj6igz8IWZVLaGNML3RwWUmZ8ec1p5/FnOiysyRFomuNPx4skXqWqPFYN201CKWv4xk9wAOezOJEI6ResNQ6hEXAjnoX1WkcYdDsBGhfLCA+wJfhT5b8LVfnTWLTnsCYbH/tXaL4ZCH6pI11PzAeCLU+h+L+MlrabqHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UecfOdvWZut2osdXqXbprsvbjYG0MXq4lLwJK4lX4qI=;
 b=m/+OXddMzI5b3PitjTI4ggQVeRMJNHcPB7bP63K2CCvRuL2OlxSBdc/6eWAp/foI7xVQ1HF/GkXUWtLLsiCTXiSXf49rKizKJ7ZqMxNP+uerw0Nx+C7rcd/QuKy1k/L3YdZv9duhCU0I2jFb4dN14TgOAtvzzyBI49rYrhhD0x0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB6147.namprd10.prod.outlook.com (2603:10b6:208:3a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 09:18:22 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 09:18:22 +0000
Date: Mon, 23 Jun 2025 10:18:20 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        David Hildenbrand <david@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Stefan Roesch <shr@devkernel.io>
Subject: Re: [PATCH v3 3/4] mm: prevent KSM from breaking VMA merging for new
 VMAs
Message-ID: <848055f9-589c-4f0e-b857-e6ea5f34efb7@lucifer.local>
References: <cover.1748537921.git.lorenzo.stoakes@oracle.com>
 <3ba660af716d87a18ca5b4e635f2101edeb56340.1748537921.git.lorenzo.stoakes@oracle.com>
 <5861f8f6-cf5a-4d82-a062-139fb3f9cddb@lucifer.local>
 <3f8da2c9-a877-40f9-b1cd-1e6455eae9ff@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f8da2c9-a877-40f9-b1cd-1e6455eae9ff@suse.cz>
X-ClientProxiedBy: LO4P123CA0275.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: eb304298-ff23-4281-8f7e-08ddb236e67f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TFhOEG3dbIpkc8E8fUWOlcSTj+2mnY2TwN+eystrVIBLvGj1yNmxxNQFhk4l?=
 =?us-ascii?Q?XaJZLkxKJ7YddVit494tySW2SIPA33EQIc+NXD2/2GIZwk1nkS/oLDehk8RE?=
 =?us-ascii?Q?M58nAtRxln+Ej8EXN9hKMTY323G4cnXjKciuym0+TL0OSmObUM2FmeZ9N/cW?=
 =?us-ascii?Q?+ah8bcYv/JcN2Y4llYPnooMg1Z+38Ic1Vdw766FmJJrAPGV0f0YaknL3UzmK?=
 =?us-ascii?Q?lstNM5fQN/436DmCbmnL1SNWon8grWcyRTna/pTto7ZTaAxULfRATGeIPnLL?=
 =?us-ascii?Q?oLbAbkEWqqfqiqshtSRwS21MH8BeUSWm2aSwiVmC9oRvPBhOCAGA+o3gtm2c?=
 =?us-ascii?Q?Z7KKkiB1FexMk0HEj1hoZe7w6KvOAyOh6vt67xcB4kPiqBSvYhiuXQtiDNSi?=
 =?us-ascii?Q?viN+Khw2JvRDmqLL/P8WM0W3KxpbZt6GIFQzHm8fgrOt5BQtSo85dudDT+45?=
 =?us-ascii?Q?cVgEuMUab+vTUDmARagbdATi8CQ53QC6aIy4ZODCduVHC37HfaFSV+Qe5Htm?=
 =?us-ascii?Q?FiYw54TLPwjwCwgIf8AAhZjfpX5aGJwR3NjzdXaBgtwJS1V7w9+jkNju0/kI?=
 =?us-ascii?Q?1nAa5SsRZHMhWKHqdjXsjNuw+abNvFFp5+dXwYjywqjbdtfH99yJfvKFvtwh?=
 =?us-ascii?Q?p+U+ghXPKXqS2aA7L84Yc0YHwpk6zYGg0ZaREh2pr7jbeAyyq4XTaz5K3dV0?=
 =?us-ascii?Q?wO8P/h7S4Mo2IFh9B4nuhwWlFc0SEEn1omX3qp4D9hO5BAOAJ3aomFfUKx/D?=
 =?us-ascii?Q?78A5sScG6Eye9Ees4Rtw8tQqB6nVFo50aI2yjIzy4xdEIFNPzL1fP3XoltSf?=
 =?us-ascii?Q?+9/oSEtU0ytVbnDe/Alf7Ex9Tf64NBrYG+i6pmNa8tJDLcx5l4zEN/lZsqG2?=
 =?us-ascii?Q?DZfW1VAu0o4Z7woX5+jzXhLJ1xV5u1VyvMfo+nUqmmrzVRGIbnhYZBSmTKMW?=
 =?us-ascii?Q?SZPX7uA9hEvlGFYaLOi3Gw0i3B/xSTGcXpuXL85OPsJzf8k6jRcjAgK9312Y?=
 =?us-ascii?Q?1W5SBthXE3NY/n1LQECIEgOLazdAXnaCGzZ2kAYj4bLqXAKp7egANYfezFOU?=
 =?us-ascii?Q?v/xhWWA09yJ0pZcSwZm3td2scrwYTYUtupvmd54a0WWrwIQUMVvy9eQnT/A0?=
 =?us-ascii?Q?ydpelNtRIEpa0QUO6WAtv2SwC8T2bP/xL6Txliwtk6Rz/LOg1SLM7hAH66SK?=
 =?us-ascii?Q?slbTVoQtvHX35KZwKKfcsyv3gqFf6sDOASwj0TWKbZzP7JuP7oLQl/gM34C2?=
 =?us-ascii?Q?8M9+VgI+W6IaGte+I4yylKQmhID9haGzNyPHczytmtxkQrs559prpz0boBj6?=
 =?us-ascii?Q?WnKY4SrIBXlPQN9cP1RHHvTF4Na71zyIPFALwE1DFDMn0bpC5Ep/nKHa/dWo?=
 =?us-ascii?Q?WkQz2sr24Pd+qTzLss2Rwgmo/0KKZs4N6T+jTPc3QcgBG5DHPUbZ4K1ktSJC?=
 =?us-ascii?Q?q79g07PnKSc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8VCEPV1iNoJYypCay2g3e7s2VT1VIA/ImGd3oU2N+Ht9A0C4kc51b4n6rrG5?=
 =?us-ascii?Q?8K7qFeFflwl1+5lu4Mw16Uk7OEgCj4B0zbB8ipX/Cm7EwacXWFaw1+1TTO0D?=
 =?us-ascii?Q?jZ2fw2CweXwfRwoIgiDHKP4uU3ZRR1fKkRvN98LaWSqQupKy8xDdYEl1i9DR?=
 =?us-ascii?Q?M/eOjD6n7iezxukil8jpCIPYRZUKshp4XpP6wxBl4jQ6tl7lK5lFa5Xfio3L?=
 =?us-ascii?Q?y1TVG2wa07N+0Cqx+/hlXcg0b7TdbICbJj4Wdv5nr6gRJb7refdgTeXe8ZWf?=
 =?us-ascii?Q?poXvPlXLx7xSTfJBKMw4VjVcSxt01VJ2jzl+xL2p5y2U6u9ZBbl+J3NI3nn7?=
 =?us-ascii?Q?KvIYvaWmVMlkBfdAs1XdakuYCrAbricaY6lMNBux+fSZ+eR9om1/XoTj4NVu?=
 =?us-ascii?Q?zdDzaaUGSThLxf2je8mVUIfqbBwsFnYvxMNc6JBz6sRI+Bd8ghrf1fCnknpt?=
 =?us-ascii?Q?M3Do7sYhzV8xmbLf5eDgDmp3I1uV5vWbWLCm/XczbeDcU7DY0Vb5bBKR0Lnp?=
 =?us-ascii?Q?KFabuidC8DiuShFCHkbgw+SLt05JK6LjaC90eIzeKDrg2euhz9eCzyMGaKip?=
 =?us-ascii?Q?KZBRKc4qdwzHav1QPLKES6+9zVUQ9BOrk7cIMwQ+K0gQl8YXjlAiPS1ym5CM?=
 =?us-ascii?Q?hlkyVnPhnrX1eJuu6FuRsItYUfks0O7JbDUyiSkdAf7+NYJUZXzFdMtlTtsi?=
 =?us-ascii?Q?ubGm9/XCFCZZuuQ7hclvfVO48osMLsy+UQ9QYvVOmU7OmxYF84SG6SIINsLX?=
 =?us-ascii?Q?I3jwp8Ken4BQe1IE5VlOrdk6mdUWQffkxdA66e4nuxH1pP36l6v52XPweUQb?=
 =?us-ascii?Q?V+RU4EDFlNIoGSvd0G45SpOaToMTlIAEFvbULIciGf8Hkg0jaoW90YehCRfV?=
 =?us-ascii?Q?WcKhfJz4SAJ1WNrC8lm3F/BRQwtWcOZqMnBjzWDQGGzJOfbhBkUtkjV+RHOJ?=
 =?us-ascii?Q?x9hzPisFB528gluvng77mF0dD7SY6Jr3TkLBMsrd7i3dY9ADyGklGqT5nZdq?=
 =?us-ascii?Q?Ia2KRb2X/NUC725JMXS9ErwFhnw1pL9MxaX4eBXuIuUT8YVzhnSm0utMuNdH?=
 =?us-ascii?Q?70OKcQl1hDKZmoU3/4LY3G9P29SBlhnBvVkG9sn/hGjIc8Hzm30XJnJWFy5a?=
 =?us-ascii?Q?HelSmeDNqmxW5m/15WSV1y9p2vxzpvqS1q8WKns0qcm2pzPtyu1+9YVirce5?=
 =?us-ascii?Q?1kRh35yBs/7Mr3gDaPBAhRg8QvU9P7sqW8dWc9MTHcYA6B9awtkfyZZmUXgB?=
 =?us-ascii?Q?MIpZ0+07wJfSJV1eiPaUXddFhDEEEyvXZglv5EpvQl0kc1RYWIZ9d6ggdsB7?=
 =?us-ascii?Q?Co9UZw2nhfaqKhoDyeHWfSf2autJ1O/TSY+vOSK+3L9rKtFpE5c+JDy7lH25?=
 =?us-ascii?Q?NvzCMScPY1vPnXeW1bSns9CdhAmQUCwLeTE0UU4n8rLFAkb7+L87ksDbVNc8?=
 =?us-ascii?Q?bISFNYzbd9gqs+jUgqpqsDEzEuMq+N4cEkR0EWDAjUdchiUbmfyS9xlewycr?=
 =?us-ascii?Q?POjCaXGCRl+oihXS2ZSBdSg2Q+wqPSmeep/kDSLHEJLRNW30hj0wmhDFTqJw?=
 =?us-ascii?Q?QrUwRjpkDuHltjkgYdwCGY+p5c8WGXAGATknvi3+s0f0dbIX3Iu+4Ripe2hq?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dscO+zNhWSyUJadEBHIXC+2QnbZZSz9cHgZE9a0hTEkGX86Df6ofhd3ydyB9xSSDvv/AfL98gLS/Ec9KplBp9dhwI1Qv+6IsYQIG/1hCMF4PMJWj8CXFRsUbaT6dQcHkBszsbCP8Ym9Ki97210vWTcqozvr9kK15IV8fPx4WDvQNdlNBoeqbhuDR73txvPLvl3GBIcC0EPn1rsbvAqufVZFpz0fwkQBrpgCdalyERvagaLCXPcVtEBWIugJUznM+D0uHKSUr/6r7O+S/djokPiYvdQpq5T/rjp+CNn4yJUNidowPT1RN2IuxleA66Cb+XVrWoH0JLomtBEui2FEATTMQ6DUOE79OSLDlg2K4JllUR6yyQRmZll8NUgyuLc9lm1A8Kp0mxHKoB7YuVypdegX+3CoJe1ak5PnHSbcjWFosu9WiwXo+uzhvPGDobdLrRAK23HmpC4qTXzAx6dTP4yAHim77j9ShmI3ZXZiEPYq5cVVGirxYQnx5t/rvlVqPapp4CAF0S+yFNKDY5LHtILGImnREiezFKRo3MTsXUICjZGQDEWc5JuJsH87YVL+dBdkEsZI2FpPW9q5vNIJ4QHacMyzpNhDkq3L9F/hnuDg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb304298-ff23-4281-8f7e-08ddb236e67f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:18:22.2509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdwcHM5X1Wtl44Di4mOUkeJWCctHmQs3X+RbSdtM1VgC+P1ycS1BPCeV2JTkSVlJZZ2sCpN2bA2bWSoO/Xr8N7ktUaOmMTRR4ajnC3UAzUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506230055
X-Authority-Analysis: v=2.4 cv=IcWHWXqa c=1 sm=1 tr=0 ts=68591bef b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=hSkVLCK3AAAA:8 a=MGWgpXRfS8OR2IXV7OEA:9 a=CjuIK1q_8ugA:10 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-ORIG-GUID: RchOaMfV0ad1E0GxyG_XzpoAL-zRws_A
X-Proofpoint-GUID: RchOaMfV0ad1E0GxyG_XzpoAL-zRws_A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA1NCBTYWx0ZWRfX8ecuXKvD88ce VVVX/ByCn0mFiy5ZEcK0nfJvRIiIgBI0MrKTLnaoE7lrjp1TsLxoXj96L0h5FNfrXPxd4P3rvzw zwaNRbhT4Ql3MTIPboQlFZw6Nb+MMkQxESpveI4YFSw9GMOM2Oi9BTJoJIZYe8YifOdoFWJRFGo
 tArkg+NyRqoWzqjRLiwalaiZ1LRJTs96aJ6c+Ua4mobC0Zqw/gg4een3d3Qr0ENQWsnlX8C1i10 O30surqe3gNgB6Hef3iqHkaP98tbpd3M6a4HnoaZjO966D8hiKIIwvpQ1uedmoB45xGaZVfrYeh 9VqNo0U619dT+7OP0wUYtADHFq0gnsy6xgBbHKMJmX8XbDDv63dmmPg/nmLmvbFFopbaWMYr/mB
 8RkKJCSJMdpxsZpDX71E/G4PDpVcIQIG1AjNp9Hug1JoPhtFu4JQL2yzOHqEfckTgQFFWuDZ

On Mon, Jun 23, 2025 at 10:37:53AM +0200, Vlastimil Babka wrote:
> On 6/20/25 14:48, Lorenzo Stoakes wrote:
> > Hi Andrew,
> >
> > Sending a fix-patch for this commit due to a reported syzbot issue which
> > highlighted a bug in the implementation.
> >
> > I discuss the syzbot report at [0].
> >
> > [0]: https://lore.kernel.org/all/a55beb72-4288-4356-9642-76ab35a2a07c@lucifer.local/
> >
> > There's a very minor conflict around the map->vm_flags vs. map->flags change,
> > easily resolvable, but if you need a respin let me know.
> >
> > I ran through all mm self tests included the newly introduced one in 4/4 and all
> > good.
> >
> > Thanks, Lorenzo
> >
> > ----8<----
> > From 4d9dde3013837595d733b5059c2d6474261654d6 Mon Sep 17 00:00:00 2001
> > From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Date: Fri, 20 Jun 2025 13:21:03 +0100
> > Subject: [PATCH] mm/vma: correctly invoke late KSM check after mmap hook
> >
> > Previously we erroneously checked whether KSM was applicable prior to
> > invoking the f_op->mmap() hook in the case of not being able to perform
> > this check early.
> >
> > This is problematic, as filesystems such as hugetlb, which use anonymous
> > memory and might otherwise get KSM'd, set VM_HUGETLB in the f_op->mmap()
> > hook.
> >
> > Correct this by checking at the appropriate time.
> >
> > Reported-by: syzbot+a74a028d848147bc5931@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/6853fc57.a00a0220.137b3.0009.GAE@google.com/
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> I've checked the version in mm tree, LGTM.
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>

Cheers, appreciated!

