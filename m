Return-Path: <linux-fsdevel+bounces-79317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDlsIgCop2kHjAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 04:33:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA911FA638
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 04:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B84FD30464ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 03:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DE9366DCE;
	Wed,  4 Mar 2026 03:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OPw881fm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58178366550;
	Wed,  4 Mar 2026 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772595193; cv=fail; b=UrjT/CufH5qFM/mA7bjZwqqJxcnnQKgLeiBDy+fNNf08dy1b7q+QvhsB0V2mZdBySdpxDhAp/ownA/qo+RwBoSTAvxEhCtn5LjX5f8OpLToJi0D+PpbY2SbSkt7zkW+m0euyjQX5dgbbYqd/BDEicmIreivfO5GXad7k/i9NTGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772595193; c=relaxed/simple;
	bh=Denu20d++PTyLGQbz4ViSp1u5U+8Nh6hAQM0hDmxKwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A5wP42eGOWRp2U3MR6NQKdjrGXUxUMUL8BJpHrmDIOeLJfqalHFH7q9/OfxN2QWIWS8RTGzNtiBADSGcjgVm3LPhsTLbihJzFmrCYl/1ruecOiazLAbQvWP4F1HfIQfBvw3YNVF1FWPtiiVLQwFf36l0qJPqUf1P2z3aVxGByjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OPw881fm; arc=fail smtp.client-ip=52.101.43.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkKPF7gtQu/6vnSV/S8pLCuYRLeddeNDBrPH1p5E3nPH4eZ6XMHCbMVE92lXryAkykerxMd7wkFtdDB1QAtTPBV3G3eL93TUceHPf7AikHRAcpnGr3c9glx1FyvkGC8sHUOpoDCPgAnP4KDCSXdzrwGDO/xjC7E0JL4DZVJDC2pWx7wC2rNsMOnmR5FDEgdGea3r9nNrEt39Yi1RXCA6p5UERxsp9QJ5Cg3Vs9XENWvk9HcRXJLp1R2LT6VS7aZIF8nlHFIU5PMQqntXLSeh1U7T7WLAVX4wuqE90Fl/jyJzWRVPothEw6MWhnvR5jVs12LzF1htRXnPjgysWj7beA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DUpp2sS5DWOdg6mUbEn46YK54O6OkOlKSq07gXUAzw=;
 b=tBhHlql0QwzQ5KxeHwwxZmLjot5tuqPqptALhxY7Ewf23vuE0AkrBRZ/1uiDrEeQmbDf/7CYLfCs5gHcS+6XP0CWNnGhPBGoFVetZtjzU5duJDHBzJddJnXUBqktzdcUUs/q6qzrlKhMDrF/RrOcTsIzc6B8yU05oZGWtPTTjXv2rtjQgl9r0BAPzA2QP1JRAJY9hidJ8sccdrG5vr3mDc9kNggZ7q/1vL+40CVC2SM3P3nwc8ww56F/cc45C/t6Tqo/PDq8NsZzsCo4tZyvBesbkhV0+NM+pNgs86ufV16DSF340DIwHy9gun1NfwAcsgi4AV7f/bbc3g9Zu2Wtcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DUpp2sS5DWOdg6mUbEn46YK54O6OkOlKSq07gXUAzw=;
 b=OPw881fmpEMsjVxnAPjMLJY/wE7WSICTbWg+iac8xW/MFXDCNwMeHFJrO89GanLnA5XITjEHf3Tfbrsa4WDgXDSeyCFs5H47C6XYOkRkiCXvADsZtydnAe2xbTgnrqObqpc0DbmzZKuwnfRSZSNVDSIbQG9a0xDjZjTZbGGqker7SfLYaVxVW0U/NHUScOASdXXsb3p4ImbXAWZ1I9w0Z2usOAXhB9A2I9cKqOIVhvjvvzHQIziQVpAB6XDI7T82BUqCqF+3MAb/+CRgaeU6aH3v3VetE8S/+sOEKpVU5SE7e+XYmxN3T1RPCGkIpWYAZLPH/N1KhVgAWu7268qywg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 03:32:45 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 03:32:45 +0000
Date: Tue, 3 Mar 2026 22:32:42 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Anna Schumaker <anna@kernel.org>,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Aswin Karuvally <aswin@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>, Carlos Maiolino <cem@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chao Yu <chao@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ingo Molnar <mingo@redhat.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Linus Walleij <linusw@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Namhyung Kim <namhyung@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <pjw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>, Takashi Iwai <tiwai@suse.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, Zheng Gu <cengku@gmail.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-block@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	dm-devel@lists.linux.dev, netdev@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
	v9fs@lists.linux.dev, virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 0/8] mm: globalize rest_of_page() macro
Message-ID: <aaen2pGs0UeiJqz1@yury>
References: <20260304012717.201797-1-ynorov@nvidia.com>
 <20260303182845.250bb2de@kernel.org>
 <f8d86743-6231-414d-a5e8-65e867123fea@kernel.dk>
 <aaedwFwXh9QXS3Ju@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaedwFwXh9QXS3Ju@google.com>
X-ClientProxiedBy: BN9PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:408:f9::6) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: c12f8f5d-bd13-4d2a-a3d5-08de799eb2e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	Ldi53hmpQjSMzjv+DwE2D/6skKToxKApb/Fi3TyBNqzlLCyZv9Ny8w2FvJ5aaaodvoZUVdBcZRQ43CR0UDd8xUEAfoDJDtX2PwS3RLwkm6m6uZtQZyYGdG/VR6DKMgPmzNew/u4gQYMnCCXG/3Z7LHqWuvXTHHnqa3nvY4kU8gEWs7DY269aFPsfaeasGbY24+Gt8HMwWrUrNGFQ4APBNvxiiGnG/pmGnctnsYltpNeaTg1tHGnhpYueNMYLHEqinlLNo5P5WAbowZWeEgrQt+P57UpYoQ4O/hK1sntckbIFDcwe2L+m48L7WoJKsBViQY5lQNfIXALIqt5CqPWW0BdfJ9dDK1Buq1z9/bELGtxmyQX8pODlCUBaHKK49u5lJp7sOS4YiwX/n8kYDiw3FaGm0VA+UY4fcIu3HICVXNHJTOxguTby4nXUHX8X/ULHYatZgnCRYgi4FLd2NhAcip9yI5LnsQnRLRZK1Z9ob6/bG9zj2SsocegdZhqPwQ7PsbdZD380uUCfNQPchfmFPHbgWJ54QqioXSy1UQ4v4TNxi1csnhmGSBd2gEsJF6l8RXrKLAr1WXgeDGCkFWg1c1Oi20zfMpnCRMfu9rQYvfDARl+RiJhQl1mvlXH6f8Rc4eyR4a+4pzexqbszVCiE+DP9xO1R2Q8qmaW/+uVqBOUX0uxEXmvOjCDmQ/P1YqcRL/dT1leZH3U67Gs0/tqy7zeOOAm54kdueTG1qx2u9Aw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4oTSo9zEH/urMCTnwCydlGadgtEgpgaf9/rLv8XGuQ2jAskxeuJyoKtWMXgi?=
 =?us-ascii?Q?1Due/xj30p8rNayd8MGTN0+5PmlgnCA0FPGrx34X05CE2hKvBpujqDYgzFlS?=
 =?us-ascii?Q?4cm04toEFwgZLE7MsA2OE66ZTFHuNv58pOpKpohiHwtvA791k9+nNr2rEPDZ?=
 =?us-ascii?Q?3zxhRjefHQW1WVflYhR/uBfNk/e8PxlYQ+UeckubDAeP+Vp30YRauDBvVUPq?=
 =?us-ascii?Q?oJdu3HWY1hnmc555shB7tihguvtmm0Lgrk9VxEjppgYvzXri39OpXQDEyMAB?=
 =?us-ascii?Q?QQEW1Tz1nm6ZUedHHJhJBpmLLXlElq9xGnD38kXQ0BLWc8Ud6rgyOrTfAgo0?=
 =?us-ascii?Q?TCmzVITaeLeFSqtD8YthR7imyVyWf1TmoBrO735k1V3V0igGpKlI5koIxxIE?=
 =?us-ascii?Q?qT+5HQnKiikyhbtWUvN+Vc+FEvC6Y4lB20p0jYYfbTY2OP2Vxeco220Bpb2Z?=
 =?us-ascii?Q?IfI06MuCPl7Q12/zwSxcSHh9VU/Vy82D98HQeuApJOtVymBAQcuD99Ev7kUv?=
 =?us-ascii?Q?UdN2xyykBICHFCLq/eGbSp4SP5uksibQyz6f6L9rIrweO5Sgq+HMCoykLkpt?=
 =?us-ascii?Q?JpUoknDmfibMwGzkaQBq8OBsMHC9ppx3b4YSsiSL/LbMZTX9Huhlqsb3Mpoz?=
 =?us-ascii?Q?Y8KA0YF0p2WjBlf0Zk5XHXGc7cd97iK3HgvgqShIPQZMs8hXujQXZdUgNe01?=
 =?us-ascii?Q?XuOYpoc7SQSzKwHehkn1Q2QyBn4NGh3cETemrb56zrKr5o8xUNLZ89zE/NwH?=
 =?us-ascii?Q?ASX/ENwvocjS59Slic3cf+3M/ofHzFQwQKGJ9qnBIuGztqxnj5MORxYdymbG?=
 =?us-ascii?Q?dbBLaXrrnA7gCF59DCvVZEFqd1TJdaD0iV/qUmhL1TR2DuUWnt5PG8RR5O/f?=
 =?us-ascii?Q?m1gWBkUxTVAkhEQsHF5ypRhzaLi89hS2s3pyq5r08sabaaglI67jMGXCDEXj?=
 =?us-ascii?Q?R2qFIGnaOWEV4FxfOTu+7fhu5VN6QB2MbIGHEFIvj3nDlW0/iuyq+JYUMxAQ?=
 =?us-ascii?Q?e1Z8ZQTZLDcy/CU3rJX5UTaE+mBhfadSKnmz/wcMbIvTvAnwhdMlDrNUBlbR?=
 =?us-ascii?Q?YyE+AUXdD4r0rTyNZWr1Ww8trj6SMAI5vXCmpCq9dwk17Atsyu3noRhVHaEG?=
 =?us-ascii?Q?6TjfF3hhSynb7tg5tkz9C7pKm34Tvpfxgk1cL0yel8zr62kuJy2PgswMe4Dv?=
 =?us-ascii?Q?BPBjImzQJYaGNLHwp2njqWZLBMLJRDD21VK9z+ORDqPoAlwQgJ7bWQpBhnGA?=
 =?us-ascii?Q?o0jbutz6zquXcTN86eBZXTwU2GjQd1wTLYb7O56AGM4ioOXTFi60nFSZ6NtY?=
 =?us-ascii?Q?zt5ADR1lOXv7HbhtQ5/h4qe1cGM/FLKv5xERC2lrkkvZPUJYaLZkLKLTh37l?=
 =?us-ascii?Q?B3sgbOyRtS395nqgAKrBUNG3Dh0R9Hd+iAWYtTqLgLIOXaNrnH2tDQyjljAI?=
 =?us-ascii?Q?GnHncJzgdLgP/SD1Hp/5e6k0p9gBGDuV+fQdRXCzAyjMhC8Wx8Obq455rOs0?=
 =?us-ascii?Q?7B9d+fESDyo/Jh+10RLpuBhpiE5Litmhk78uiNhNLsc/EpUICAykwWUdgFhc?=
 =?us-ascii?Q?ITpXHzo0wv1SU8RjHh4UqLso1ZKJL5DlDg+ELmMHOAVg3rKagX98nkOy33Pt?=
 =?us-ascii?Q?apyxPGadJY+vuuedAU1sQldj173rfhZhaOvBSh7htAyLySbtZDMw1SlcHjGT?=
 =?us-ascii?Q?E72uxDxYFKOAkwwwIxnJt4WZhewNCtLXOhmUF3F0p9BCzE9DVggCi0cdkyOA?=
 =?us-ascii?Q?FIq7CdK0waE9Qn52EKHsYj1sPSwMiAPoJs5WI5hTGpHEcH7xo9b3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12f8f5d-bd13-4d2a-a3d5-08de799eb2e2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 03:32:44.8820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rpnZef7riRHYzt1o4UV+yE5ncFeLWafMn/9WG3ukqbaxdt05KGWQQBRI3nHrRx7dnDmEGE4VpNyc482T5TV4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958
X-Rspamd-Queue-Id: 1BA911FA638
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,linux-foundation.org,davemloft.net,redhat.com,mit.edu,eecs.berkeley.edu,fb.com,linux.ibm.com,zeniv.linux.org.uk,dilger.ca,lunn.ch,opensynergy.com,alien8.de,arm.com,linux.intel.com,gmail.com,codewreck.org,linux.dev,google.com,gondor.apana.org.au,perex.cz,ionkov.net,ellerman.id.au,szeredi.hu,dabbelt.com,infradead.org,intel.com,ffwll.ch,suse.com,ursulin.net,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,lists.freedesktop.org,lists.linux.dev,lists.sourceforge.net,kvack.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79317-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_GT_50(0.00)[85];
	TAGGED_RCPT(0.00)[linux-fsdevel,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 06:49:36PM -0800, Sean Christopherson wrote:
> On Tue, Mar 03, 2026, Jens Axboe wrote:
> > On 3/3/26 7:28 PM, Jakub Kicinski wrote:
> > > On Tue,  3 Mar 2026 20:27:08 -0500 Yury Norov wrote:
> > >> The net/9p networking driver has a handy macro to calculate the
> > >> amount of bytes from a given pointer to the end of page. Move it
> > >> to core/mm, and apply tree-wide. No functional changes intended.
> > >>
> > >> This series was originally introduced as a single patch #07/12 in:
> > >>
> > >> https://lore.kernel.org/all/20260219181407.290201-1-ynorov@nvidia.com/
> > >>
> > >> Split it for better granularity and submit separately.
> > > 
> > > I don't get what the motivation is here. Another helper developers
> > > and readers of the code will need to know about just to replace 
> > > obvious and easy to comprehend math.
> > 
> > I fully agree, I had the same thought reading this.
> 
> +1 from KVM-land.

My motivation is that it helps to simplify constructions like this:

-               loff_t cmp_len = min(PAGE_SIZE - offset_in_page(srcoff),
-                                    PAGE_SIZE - offset_in_page(dstoff));
+               loff_t cmp_len = min(rest_of_page(srcoff), rest_of_page(dstoff));

Or this:

-               if (folio_test_highmem(dst_folio) &&
-                   chunk > PAGE_SIZE - offset_in_page(dst_off))
-                       chunk = PAGE_SIZE - offset_in_page(dst_off);
-               if (folio_test_highmem(src_folio) &&
-                   chunk > PAGE_SIZE - offset_in_page(src_off))
-                       chunk = PAGE_SIZE - offset_in_page(src_off);
+               if (folio_test_highmem(dst_folio) && chunk > rest_of_page(dst_off))
+                       chunk = rest_of_page(dst_off);
+               if (folio_test_highmem(src_folio) && chunk > rest_of_page(src_off))
+                       chunk = rest_of_page(src_off);

To a point where I don't have to use my brains to decode them. I agree
it's an easy math. It's just too bulky to my (and 9p guys too) taste.

Thanks,
Yury

