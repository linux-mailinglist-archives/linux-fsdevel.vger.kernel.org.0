Return-Path: <linux-fsdevel+bounces-22658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC1E91AE06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 19:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0DC5B2A83A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 17:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2AA19AA48;
	Thu, 27 Jun 2024 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ki9kiOdi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BcookIiP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57C619A295;
	Thu, 27 Jun 2024 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509181; cv=fail; b=s1oPkbSH2R5A2bdNnnmT6vLYJVfiXGVN/VuJ5ZMXDzMkCIMKqTw2hDu+5d9K7F2tKRjoWhkuq3URrm1YGo+ZUawo5Vuf3rTC/KeWwlcZt8XBUWg8eri1fJdeVOIBKICoqwpH1JhFLt3BTiX499cnT1hEGG2ozOd79sWYH/f08h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509181; c=relaxed/simple;
	bh=BLKk2wYnMZkaZ+6Og/xhGfNPjuW9+q40e+vF2uS8KX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LtIb818cQ0jWjZk6mH9RUQQE2IMpFgCmkxod3EAPsakopgsgeUXEacysLKF1yFYOzOwODHW7JCWc1X69YznViiaHnKYFvqPl9Qd45zhsHAYYkE5B6bJEP+l2RCnPrhnF45WU1EdEd/vlrLpSkX+HPTbECd02bnbwRzBpviBjiPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ki9kiOdi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BcookIiP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RFtTMd003652;
	Thu, 27 Jun 2024 17:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=EGZHRP2X1vEL5e5
	ZwjBTN0jBTnu1by2PaZJII4JHZ9M=; b=Ki9kiOdieItw249KbkjqU0aZMwApRrb
	OxIBjHqzWmkgNnGO69ta5yxIBdfpk5gPVyt4cLxsXoUNXk/3RgSCYO9o3c3kqOcH
	35k/TpeY+WIeh3eBjN+qCPg6tzAPPGGa8wqV5MgBpn+BXigFsWNCyTR+fkzd1+LA
	W0dgfj71yqNUGbNy0PlolJncfNlcpEZw0PRJC7UzKywhOQizKD/Sn3+iq3nDzUNv
	QnfRVvPseRwSMQr6mVvRju9KxSn9Sw11bdK39jhGBfiWD6Qs5SQ9wimelm5RVc6j
	Tw2hIWYmOjdSkpGmVJRWc754VAq6v3WvOv/O5ZJEgLMvnlTfFaIMxxA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywp7spkaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 17:26:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RGu3rh001333;
	Thu, 27 Jun 2024 17:26:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2bdxsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 17:26:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeOXE/lpaEYUA2Bo8tAb8hHDu7Zl4cNgK/neb13OHl4bH4yaLuxYA9+yOrChz/rozW2Ye3wZ3raAnjt+1kzPHOnQOvKnPP1RpXphdW0IFyspVoebZJzoe3zZR2Mg9ZtZmowPYkLfNmtcswei0UYDISGNecr0/E44pXB4mVt+Kv/Ky3PgY9vbGJZv6ifJ5z4ipkRfTTDdjDCxM0ddozz34/q0T/GNEqmqwR7JBP8qwRsRF+wxrNskN4qQzDGBzpI4/FcEZk9fcyaIzXFQfaJNYp1txOsBj3b/SjIe0qXM/clPaH/a0cHUGyPn3hKppMDs00PMlnMAuS+K0vVIloNiYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGZHRP2X1vEL5e5ZwjBTN0jBTnu1by2PaZJII4JHZ9M=;
 b=NYp6CqII4OXtJNs4i+Qb8emg39Sq0L9DL7jAeGC9LOCkbNj0edj+uGyp5mJt9XAWrBS8h7tFQJWZJx5h2C2mzm2HSz2Nigw/tuUv9ru7XfndV0pfD+ZmsH0IFYK194zz2f6HPZbAVIx9lKYaUpCAyn2FHXA9H7W0k13A89Csy/qN+0cULFa2HrSH81AIG5YOup9Txe0kD1Hf+5nWAMx20+Km3ZGm1WgMHv3FyvRWQlciEre4I2IUTI8jS1puw3dUJJHhQSVULPH78s0ft/bGX11GHAs/3HgAHei0sfp9R6WgHTnXI4WK78YeaCCBVAcN7OwKNQ+2euBUWV1SHbepCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGZHRP2X1vEL5e5ZwjBTN0jBTnu1by2PaZJII4JHZ9M=;
 b=BcookIiPapBDbXADmfRL0YeoQSwhUg/EM+6nnoX0MWeKtGuqNAxxLp/Veoxya3Idti3mKoNjU9MhPEeb9fFBPTgEj3i/rV1HLJnvQxRCm5aW+Za3M0mERwonqhP+Df5mtbesJkbQoet5EC0MGI9SwhdVSYGcsYmnErZU0BB4gIo=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA2PR10MB4492.namprd10.prod.outlook.com (2603:10b6:806:11f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 17:25:58 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7698.032; Thu, 27 Jun 2024
 17:25:58 +0000
Date: Thu, 27 Jun 2024 13:25:55 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH 2/7] mm: move vma_modify() and helpers to internal
 header
Message-ID: <y6c7ojrdegke6klyw4dxsduza65n6lxy2eermku4rwx2cwbdil@muvorxujta6e>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>
References: <cover.1719481836.git.lstoakes@gmail.com>
 <2fb403aba2b847bfbc0bcf7e61cb830813b0853a.1719481836.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fb403aba2b847bfbc0bcf7e61cb830813b0853a.1719481836.git.lstoakes@gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0325.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::8) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA2PR10MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: 252c71b9-e780-449c-ef02-08dc96ce3532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mzVkexOtL765SQuCo68zxbXN7rt73GpeLlsfdyMS5607Dd1ZuEWEy2/9ZCn4?=
 =?us-ascii?Q?aB5pKihj6YKwwBs+otvsuPtiFXlk3qhWXRE1aPlLy28DjCi3Q7ntv3BwREVM?=
 =?us-ascii?Q?v8nOUYRYJc1/BoYpkquKbpRnfVSnB91fQvhiPj2YwR0k6KHfQ/IpEZehXLaT?=
 =?us-ascii?Q?4dHsVHssh23G8TsDNQbd1aBBIhG8y/odlfyStLeL8O05erNSded8Pa4uCpBj?=
 =?us-ascii?Q?X6YW7alK8lGKLAqHOE8lYRprSRBUCObw4/L1+mPT0ZcXdZYwVwbp3r3FGD5g?=
 =?us-ascii?Q?OiC90wBPzLaLLeOshfRRDpsaxZsN/XFWyD+zn9B0+P/hY6YNsLgw6OLQgmnG?=
 =?us-ascii?Q?n31fnGc8BE1XkHSGWEs4hv+cqNJWt+MBNGjzAdiRSjHkuIwIeZevqOMMgqYv?=
 =?us-ascii?Q?ntAurZDCTKvbZgqrqLDcmfY0WyL9vHQQSUMVayLFvZfSlKHkZm5vYCOhQKoh?=
 =?us-ascii?Q?0jXbwwqfBNcWfF+29Y8Q69EG3+4oY/ztgufrS6y1oR+ok53iNZGaFJEfzOGz?=
 =?us-ascii?Q?KIoJtF6yrEOt9gs2F4aXrc1Mw2dW3Je4QkHczCL/QJdf6z5NHXkH9lNrSIV0?=
 =?us-ascii?Q?WUm1GSA7Sjkb6KJeqbzw2svYym9NpEzne084IqRWPauLhruL5o1BAspOazhl?=
 =?us-ascii?Q?R1web7fCTo0nTGKK0Z8DcfMftJcnb9dgSHlR69cuPeNwzFLnjcT8JpGKP+Iv?=
 =?us-ascii?Q?qu74JumDrl1Dp/wRoHC/FxZ+aN5BQq70a190Ng4S8VvqcAb3s8M1kHBOjQKJ?=
 =?us-ascii?Q?H8pc2XhSse9eoDq005GZipSAH8RP2BTAOAJLHywxX9q51vaL57De00Cx0Pm2?=
 =?us-ascii?Q?i/pcRwP/vkaY5/GTiza5Lbmjqp4LEH1CyKplRpuk5Lbj8/eO3Jl0U9CD0rsl?=
 =?us-ascii?Q?4beDmxR+U1MLCWfGISYW6K+42IlJEhAQMgn9utGeRuck49GcniYZoQPKuXPU?=
 =?us-ascii?Q?owrOS6flO7+HEIC4rF/aJP75lf0D76+Ma6MR9O9Ek4bJZa3jM6LViSYZR4ce?=
 =?us-ascii?Q?CQk+v5Ut1FuH+JqR8lohBpSvJEMZk1ujSVPChmnhJ4a6K8t79ait8NCIT7y+?=
 =?us-ascii?Q?OE0pdKruHaB/Vi1ArdjHOuGK9auezX8HDwe8stZywb7lGzNZDWoFvwwhDATY?=
 =?us-ascii?Q?nVyJegi9ku8h6oYsnUTdLIYyRkN9ur89Oqf+xrME92neR+K28YSorRBJxwpw?=
 =?us-ascii?Q?l0scLBbbDlm9vKMjbgiAeD70zfuZpWvtZNFEOdLW5QfyxJZhUNHb2ZUamr+W?=
 =?us-ascii?Q?sSMX/DixO0cptcMwTWkPO3WBpgjIpY5j0pZl7X9pGoQGRZC45E7axDcTMRfq?=
 =?us-ascii?Q?tLnqjLrr3LHt/Km9r5ZgYAwzXR2zCTq56Q7rgD1V+JdcwA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1iOJxzImCwKVCfhU0eKK99o2GOi440XsoPiDMhpwSIZ7uBPrN1HsoIYq6Wx4?=
 =?us-ascii?Q?C54ioKtKV3nazv6F4Xh/XF5Wj80x8HdFLXqQnzLYAsU9/Z77O5mle4kQXzjm?=
 =?us-ascii?Q?4su9aM39V3xYiyG16PBHmh0Y/rTtUBuyK7tw8UJGPHWWEtTHYNDDqAGfZ9yW?=
 =?us-ascii?Q?FFmFVcV8oCZMoKRALxxS0SeUDzVrJJ1wbRPX+rdsFlR/zFz0avflJJVs9QXO?=
 =?us-ascii?Q?1DvGmWDQZJZJQ/WAi9l1TYNYqYGCjuU029TMP5tWqb7dnUv13pZGye4N2hur?=
 =?us-ascii?Q?4p2OoKB97Ex36fKkqCekH3R8JnhUrzs5yCLpyDBTUWKY8ejhSNRGzuYbi/q1?=
 =?us-ascii?Q?fQnJMNB/TjO51jT66F3YYDK/Lnymn5AFkn8HUqQrolLroBrE+hDjEGHvA7BT?=
 =?us-ascii?Q?Yxt2DXtQwgnYfDAU+xNQT4IQOeLpPGzV1J2746s450VcBwms7CoJnMxqM8xZ?=
 =?us-ascii?Q?UL5HYTrM74sqnjZE0yzfa7akI6LfULosGcF22HneU3Aak05hTfK2QWiNgAJz?=
 =?us-ascii?Q?SS1s4N/RlBKABzedhPW93KH/sI/7qvHJUeEi3TzGWRW8Osa9i43kkD3JP1iX?=
 =?us-ascii?Q?Yf62KBY5N36IFkvZMNXla0itiwmdiF69G2fud1uqT8mWHGkOr8T3z79eV7pb?=
 =?us-ascii?Q?PgSJjopqwI/UT6yPZ080XG1N+okOFxdmW0c8bYAWS9Fd8XwMa4GgcC5AFu2/?=
 =?us-ascii?Q?ke5bn4mw3y1bSYkdCqlIcfQ1QUoH3Kc3a+rn0SfqvJ8o1w/Dgo98dGBQd6N6?=
 =?us-ascii?Q?nJac67QGO8J3SjueR3k7KhVABFmaQvOwWgq0M9IhpIvU7GoenNiS+ndrnycZ?=
 =?us-ascii?Q?EpCCD1rSstPv/SMndPUyvzQ2ELEjn8/d2BkwSfmuI5aNqNIeAx5VITEOr6N8?=
 =?us-ascii?Q?e7xSWNR394+1oIPb+A1X/s/qUyI409nQlITUSuLilSALI1EgTvpFPWnZDg2U?=
 =?us-ascii?Q?GndE2eJYkqMcEqpvj5Yh3ewrwpK7IOS8Ygvq6YcLq+TI4nHoSaKrVWZ/rut4?=
 =?us-ascii?Q?WySTEWwRI+yFK4L7OfR9VP2aQ8433c+V4qgsW3R7uthHpB900NTke8hFfELL?=
 =?us-ascii?Q?vhSm9gvr7E3245MVnoQoJ6/SK4aKi+3tHdyOyOgS/EtraAavK1MBxxrj2m5n?=
 =?us-ascii?Q?XfVlS1SUCbgzZloxSQUSsPYxUq0nSxP2F2Gbgp6GOX+eCG9EABkUppzVqgsE?=
 =?us-ascii?Q?YM/IYes/1DoQT+avtJxiDOkDEtXGPXGeUeVLRdj53KtPODZKxBvEnv+mOm6r?=
 =?us-ascii?Q?x4rxu3M3qFJso8grgSXSHvV8b0zyfJyNV9Q07NCVSY1dZ89WHzU2nw3ACuFx?=
 =?us-ascii?Q?ulkewZT1xyJ8xtn2nckpLTnFM4qBIkSXMDC56h6gR+KA68sdpLIj45xauoKf?=
 =?us-ascii?Q?lTT6QjDqeHwQbJrf8DGB1iHxTHEoI3RvtTmvUzErMi08z/BWJOjXIfhQsjzq?=
 =?us-ascii?Q?3BjmM4mRldxQlRqNJ9nZ30MZ26F3jSqt1bS50BmjEiAQWORCBZ+GrOkd74Ez?=
 =?us-ascii?Q?GgcOBP18oLBJ81woTvupVsj/Owfb0GjR+bQQDOFV35ol0IQ0zE3f4X5x58VL?=
 =?us-ascii?Q?dK51LSI8FetPoAJKrdFLi947Ae8eYPtCUXDg0yDA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pJcERcmbriR6AZ0fKaxkrExfzK6XJt7QHcWHb91VZZguM8rS+oN5EIpPZFoshMI/+/8b8ux/jVLmYEVeOy7arSGbRZ9HpN4ssQW4y5R0pnX6EziTQwurcZbEWbZ5NTY0RjVmlePRMd+3RQBK8qWoO94bssheps10bNjsoOSDiWi7dbHDdD7mNUFJFJ6hdokj6zMmFHEMNxGY6pd3UmCp+XcdCyEx8KjxxNP6cV49YXtNRTlPrMwQd0BBtYYPp1xhrQQvVjtATjervvG+X1hr0/Uz8nsMw9ziC+PEZc6jNngnT79Z5UiIw6I2ZjD96UQACUOLHcf4/O4KDzBEJargI67iqTmcgxNOdvphvU3U0WmOMdTuVw1U9kZGpDiAaeJlGNS6bigWwqTJX6ybfxLggTsEtT4sJibPF9iUF1z620R1HYo9gMWS7++vnkA0rxCRoJgyY8G6jCsiHuksKFFYseVRYnsrHBniSle/3v+/I06mqgVGDoNA3I5xTX6Kh1GXPfRFvxJ979rMT3Q0mSt0tJkWRiBa4rX+G0UJmYhiI/52e5I21//U1gMYsua9mrvsxzv9w6LYcandFXh4xMeqQmGXCMSdxNr/KhfY5ZUVrQY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252c71b9-e780-449c-ef02-08dc96ce3532
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 17:25:58.1193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjG40dd7iYGAkZ920pPLr3SGoOHZuv8ty5ktdy4EmCOUCuHAKWoJDK0S5YlCu1PaI/bqMygGU4mTEeeYjAJnnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4492
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_13,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=987
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406270132
X-Proofpoint-GUID: xGgr4CV4xMdayTdlf_yKjUWSpspbd-h4
X-Proofpoint-ORIG-GUID: xGgr4CV4xMdayTdlf_yKjUWSpspbd-h4

* Lorenzo Stoakes <lstoakes@gmail.com> [240627 06:39]:
> These are core VMA manipulation functions which ultimately invoke VMA
> splitting and merging and should not be directly accessed from outside of
> mm/ functionality.
> 
> We ultimately intend to ultimately move these to a VMA-specific internal
> header.

Too (two?) ultimate of a statement.

> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  include/linux/mm.h | 60 ---------------------------------------------
>  mm/internal.h      | 61 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 60 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5f1075d19600..4d2b5538925b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3285,66 +3285,6 @@ extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
>  	unsigned long addr, unsigned long len, pgoff_t pgoff,
>  	bool *need_rmap_locks);
>  extern void exit_mmap(struct mm_struct *);
> -struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> -				  struct vm_area_struct *prev,
> -				  struct vm_area_struct *vma,
> -				  unsigned long start, unsigned long end,
> -				  unsigned long vm_flags,
> -				  struct mempolicy *policy,
> -				  struct vm_userfaultfd_ctx uffd_ctx,
> -				  struct anon_vma_name *anon_name);
> -
> -/* We are about to modify the VMA's flags. */
> -static inline struct vm_area_struct
> -*vma_modify_flags(struct vma_iterator *vmi,
> -		  struct vm_area_struct *prev,
> -		  struct vm_area_struct *vma,
> -		  unsigned long start, unsigned long end,
> -		  unsigned long new_flags)
> -{
> -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> -			  vma_policy(vma), vma->vm_userfaultfd_ctx,
> -			  anon_vma_name(vma));
> -}
> -
> -/* We are about to modify the VMA's flags and/or anon_name. */
> -static inline struct vm_area_struct
> -*vma_modify_flags_name(struct vma_iterator *vmi,
> -		       struct vm_area_struct *prev,
> -		       struct vm_area_struct *vma,
> -		       unsigned long start,
> -		       unsigned long end,
> -		       unsigned long new_flags,
> -		       struct anon_vma_name *new_name)
> -{
> -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> -			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
> -}
> -
> -/* We are about to modify the VMA's memory policy. */
> -static inline struct vm_area_struct
> -*vma_modify_policy(struct vma_iterator *vmi,
> -		   struct vm_area_struct *prev,
> -		   struct vm_area_struct *vma,
> -		   unsigned long start, unsigned long end,
> -		   struct mempolicy *new_pol)
> -{
> -	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
> -			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> -}
> -
> -/* We are about to modify the VMA's flags and/or uffd context. */
> -static inline struct vm_area_struct
> -*vma_modify_flags_uffd(struct vma_iterator *vmi,
> -		       struct vm_area_struct *prev,
> -		       struct vm_area_struct *vma,
> -		       unsigned long start, unsigned long end,
> -		       unsigned long new_flags,
> -		       struct vm_userfaultfd_ctx new_ctx)
> -{
> -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> -			  vma_policy(vma), new_ctx, anon_vma_name(vma));
> -}
>  
>  static inline int check_data_rlimit(unsigned long rlim,
>  				    unsigned long new,
> diff --git a/mm/internal.h b/mm/internal.h
> index 2ea9a88dcb95..c8177200c943 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1244,6 +1244,67 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
>  					struct vm_area_struct *vma,
>  					unsigned long delta);
>  
> +struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> +				  struct vm_area_struct *prev,
> +				  struct vm_area_struct *vma,
> +				  unsigned long start, unsigned long end,
> +				  unsigned long vm_flags,
> +				  struct mempolicy *policy,
> +				  struct vm_userfaultfd_ctx uffd_ctx,
> +				  struct anon_vma_name *anon_name);
> +
> +/* We are about to modify the VMA's flags. */
> +static inline struct vm_area_struct
> +*vma_modify_flags(struct vma_iterator *vmi,
> +		  struct vm_area_struct *prev,
> +		  struct vm_area_struct *vma,
> +		  unsigned long start, unsigned long end,
> +		  unsigned long new_flags)
> +{
> +	return vma_modify(vmi, prev, vma, start, end, new_flags,
> +			  vma_policy(vma), vma->vm_userfaultfd_ctx,
> +			  anon_vma_name(vma));
> +}
> +
> +/* We are about to modify the VMA's flags and/or anon_name. */
> +static inline struct vm_area_struct
> +*vma_modify_flags_name(struct vma_iterator *vmi,
> +		       struct vm_area_struct *prev,
> +		       struct vm_area_struct *vma,
> +		       unsigned long start,
> +		       unsigned long end,
> +		       unsigned long new_flags,
> +		       struct anon_vma_name *new_name)
> +{
> +	return vma_modify(vmi, prev, vma, start, end, new_flags,
> +			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
> +}
> +
> +/* We are about to modify the VMA's memory policy. */
> +static inline struct vm_area_struct
> +*vma_modify_policy(struct vma_iterator *vmi,
> +		   struct vm_area_struct *prev,
> +		   struct vm_area_struct *vma,
> +		   unsigned long start, unsigned long end,
> +		   struct mempolicy *new_pol)
> +{
> +	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
> +			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> +}
> +
> +/* We are about to modify the VMA's flags and/or uffd context. */
> +static inline struct vm_area_struct
> +*vma_modify_flags_uffd(struct vma_iterator *vmi,
> +		       struct vm_area_struct *prev,
> +		       struct vm_area_struct *vma,
> +		       unsigned long start, unsigned long end,
> +		       unsigned long new_flags,
> +		       struct vm_userfaultfd_ctx new_ctx)
> +{
> +	return vma_modify(vmi, prev, vma, start, end, new_flags,
> +			  vma_policy(vma), new_ctx, anon_vma_name(vma));
> +}
> +
>  enum {
>  	/* mark page accessed */
>  	FOLL_TOUCH = 1 << 16,
> -- 
> 2.45.1
> 

