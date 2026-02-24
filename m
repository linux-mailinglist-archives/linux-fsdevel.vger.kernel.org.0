Return-Path: <linux-fsdevel+bounces-78307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBMwBjD/nWkNTAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:42:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8712618C2D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB64E31172B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 19:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC15A30F816;
	Tue, 24 Feb 2026 19:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="MvfQsI1p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020114.outbound.protection.outlook.com [52.101.56.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA81025F988;
	Tue, 24 Feb 2026 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771962091; cv=fail; b=uKbOLwtjTQ3DduXKBijk/4coA8PdgxCIdL4TsU4FbF0s5Z8Pp4Uk3VLHPIMitJZCL6YBIMgTaXrdnhayG0XxUNYvnGGTuHNyRD5eL9QrNFXSnsOPxJbeGTxpzC6gJYFN+08oNDSNm553HMS+DQsismMJqQfe3ckNsYBGYEWOnOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771962091; c=relaxed/simple;
	bh=/CnwovVZDJj1rHa6en0ePMDjJsvRs24jXfn3EuEKMLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j3j4Tpnx1gNMnJpowlDG3Nli4HXkq+9WOKX02dNNcxYMMPahASlEl+rb27TAZu8GBhYNoKwSa9wtWuHjoRxI0UDzSFsgxT30JaXtaOCk5jL8dEMpz2Yk8O5zNgnQBKtNTJrenJfHaGzQUsjhTFsqKTQWHg1xq+kBUHt865bFBQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=MvfQsI1p; arc=fail smtp.client-ip=52.101.56.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBRipQSC17nhM4L7uUfjK/ruXillAqPBzukjc6Xw6fJa+J5vNnjWeGCin+X/KkH196tZIe906IRdj0Vei92L4FooqNCfQRrVNG/FhE5h8VB3Ls4YMUo/GA/YTomAS+kFTMIgRPsX+p5duqLxvfl/gk/hGbSMxWT+JMsK4zv8hb0Y2MCWysDQ5B9S50lHyT4cKbMnNBacuclUKk7wIoHnpPGNReLqt6n1/ntzdK6dYtMFiey/ZqIapzXuqb8mfc6L8isZbRZLx6wai/q2FwYV6onArN6G+3qIRJaTBWOnMxzcmig4UG1PHoOfV5iQ+JGtfUDeYsNR/HJvSYIXh5ZRbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COsXiNI4wktaGtpqMWTizMngqgsegvU/t+yLOTM8Qr4=;
 b=d4eVLEA4IqbZkBBngam1DcyUGGnii/hTsQMYlCiMgIzDIcykQT10GrQN8FsO+/qRwhwSjOHuoaOG5sEFgHHTLiOwtoPucH7cQt7Ge2AcmZowaM3didO2E12EEtC8rdyoJLRgGzjqjRKGQdMh6rHjABZ583T78LWdwcfGoR3JZ47Z8x/GGpLdqxNSS1okjBnGcCAxik1/1IZ1Fxf0TnYG+4XfutOlaMl0MDmM9+pLWdEZd7iG3t1u0kVG0TThpt7/UgKuJ4ZWyaCcBk6v7AGw9tKJH0e+ieshCZiep0de6AxDrgv7u/UFs3QIuq4uLYrCjurFu6uPD3x94FLF31ZTkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COsXiNI4wktaGtpqMWTizMngqgsegvU/t+yLOTM8Qr4=;
 b=MvfQsI1pMi+HJag6nXzxNTn0KoB+BjyaXGJSPf/IWVJFz3qejRgmroC/4E/N0rgyI64GGS1kcYEjn5c/1kmMmkgyTMummARyxlcLUq02TLGByKZ7drbOtEJBuK7+He9cypFFY512mviHeVBjAEOgkTmblfClCdC7hkR05aw/pWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SJ0PR13MB5333.namprd13.prod.outlook.com (2603:10b6:a03:3d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 19:41:23 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 19:41:22 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v7 3/3] NFSD: Sign filehandles
Date: Tue, 24 Feb 2026 14:41:16 -0500
Message-ID: <6ca1559957e3ebe3a96ac9553df621305a4b33ea.1771961922.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771961922.git.bcodding@hammerspace.com>
References: <cover.1771961922.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:208:2be::18) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SJ0PR13MB5333:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a7e276-7543-41e9-5309-08de73dcb079
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hP8pxPmtOUJY8ArfD/987i8pp/aFtyC+qEaagA2nNP48QB4o6F6B7CS0Teas?=
 =?us-ascii?Q?iiufE79mWj15R5vi6/FERt/A1R6WlG/THvfW2DqFCL6G9fu/AjBRKfWbla0B?=
 =?us-ascii?Q?x24EV8dWnxPLXZlCjf6nVv+7L4R/Y4FE7W8U8FIFyJGKxcI5a9p3eGSRTFUa?=
 =?us-ascii?Q?5WPbbw0CewVeXkP+kB+dKOdoLn9dM5XiPg3+PUIDKkx5bTgBLXiAUdIk9kj8?=
 =?us-ascii?Q?u4E6Xg2pm0EuqXmhUuohNEAvgM4hruQhYPecWr59T30/TJirmudHaS5claBu?=
 =?us-ascii?Q?d57TgUvxtanrnalb6T2ejAfyqauVj+n8wf2mZUw2lUDBg7qCGp2J/ZHFxAfe?=
 =?us-ascii?Q?h+NANRN8pG0NCyQv13klFM+A6cG6enFA4r4an+ArPIsiVyuT4QCXTPUjV+Vg?=
 =?us-ascii?Q?blNgilUaNSfiLy2iGSdQe4Kc44oBdsA58gy7Cc08HpuMXLfDQnXJPKOFPZAm?=
 =?us-ascii?Q?W9IUqHw8EQgykafowvUZECeC5SoPeYTpQJU4eVG9op1H+hfLbsqzkVXSVsjt?=
 =?us-ascii?Q?/5Vf7yQutLvBETut9tUI+EFoBwqWMeBOCoiyepKO9Q4Bm/VKQLyvXlYuEbqh?=
 =?us-ascii?Q?jYMSexqpeBVTuCvfbkifft6swQjXWrhtj3oYTjOI9W//Hkk3KcSauRNzZ5VF?=
 =?us-ascii?Q?yBPz4CVrOs7bz8yMM7KIR4tG7Vw7Bf6iQhTH6BSTCim7cwBYvqXqxaPJpcEQ?=
 =?us-ascii?Q?pe8C+6Awy6KeGqlrH01eTZJETNP6L987lllCd83t5gBCVc2BS6hVLzQ5Q13p?=
 =?us-ascii?Q?fCcixIXoiddII//27cFPMxgdI80kIgDujMXZsfAhZIwWJK7RuGsvMvNUaN/g?=
 =?us-ascii?Q?xFQQ++4Ygvcplg3cX/EIJ0YAW9ivwtvtY/zSjZyXKvv9+IgPZA78fX2xfZ7I?=
 =?us-ascii?Q?ZjKewsGSsu2DstR0WhLOimf0l1y8v6fcsWW9aJliFMNNhVgJDA/ISYUwwp++?=
 =?us-ascii?Q?DIBBlq+oFLH1KuiLS0w1OJtdjpDQjtXBAFearJ7kFNluE6MapSCwfmjJl6bh?=
 =?us-ascii?Q?euqadesq5alLZJ47dprZ5H1l2bIPFIrglImYC1oB26qFFWIlgoN5cnOGqmwZ?=
 =?us-ascii?Q?2O3e4lG75aFargjxKpqgWN0RHb0TXoziUsi00YFHZXKGJqkriaivkRH3gPPq?=
 =?us-ascii?Q?Zjlf1QmKnFipYBESc2DB0H5jGCj9pQVRlgdIANNykcbvcUWEji8FBvpZ/hMW?=
 =?us-ascii?Q?GVZS4SU8D5F+gZ6wodn6vYKHkmm+LqnNuJeQKWUBbf5ZHSpWYU0+NUErIdOV?=
 =?us-ascii?Q?nwI8eWyVTp4VObWT3E8MUq3Xu8KyHt4sI4+ltkMbKcHja4vj0o8vEL5ABUek?=
 =?us-ascii?Q?qB4fQ+ZHbAOwKX5Izl9bjXM48pKiSUYpP6JaliEaVG12qYdODc3DI4zEFNen?=
 =?us-ascii?Q?LAPOX8/zlKqWJsA411usyhgLh/SmGYL3dJbDbTGH4vo+opqeXJAzGpPUo4an?=
 =?us-ascii?Q?8AvWEmvKnoILJm8Aotb2Fd9+uM+wu9Zt8fIxshUXREdsq6cqUwyExQZ9Nxr4?=
 =?us-ascii?Q?ZAd1wNK5KWDHa4B4zXPeusC585yql9QIuenJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lj1YfqZ+Uu1l8CAjeQURRmxGQ0SFilc+5h9S08VvhjSc/+xYiLo7btfNvRii?=
 =?us-ascii?Q?PA9U9rGp2D8jS4BMow0vDTEmkXvzDpy7iSssxk3Gef6fvp9gfqV6IS3Jw6qs?=
 =?us-ascii?Q?dMCnhd2/3VlQqzxiTyFxeflDShpBnvRhoXKKHKRdw9XivUpROO9gnQXElZBA?=
 =?us-ascii?Q?xRJD7klgsLxR30198T2pQeX5FuaqKfkb3MauUtkGuj/vtM0y+0q10qgjX+BE?=
 =?us-ascii?Q?qOpz5wDFzQOsHRKp+OUW9+nGhxoZcAj+XEuoT+PuOmz5sM+WGr5vb860rE+f?=
 =?us-ascii?Q?SyX6nEFkJK9nc0MJrvUttNTg361TAHkL2j3B2OyrFFfclgLIKx6FfLK0A/Re?=
 =?us-ascii?Q?ikFAv1dFtReqGU+MpzDLvhx0d0oVLgmTxC614xU6S/pRjedk1sU9i8e0DQZd?=
 =?us-ascii?Q?gayzreBTCwUUJXUEp9NEOniNnrbDpnsTDf+KeR9k+baR93Q5q14Hh9LN7qMm?=
 =?us-ascii?Q?wrqsgK4Ae/5robb2X5xjJ0sfC8tsmSvtdnqs/YwQLChjxkqdhImiACVr/Bes?=
 =?us-ascii?Q?C7rr5y35HS2nGoPZ8AY5VOEjt9yxdMoybKHlgoIGKUTQqBCGTyq18fl+1prg?=
 =?us-ascii?Q?/V910KhM4VXi/uMrR2EA7pQMX7GpbXzE31/ridEfv8wioERFY2Bvs6fGp/Us?=
 =?us-ascii?Q?YmMumCX5Cei378GEuyOKXL7GaPSgU1xphon/dpoomcyt+QA5uqWQi3JsMHPg?=
 =?us-ascii?Q?wfgQ+s5g62XjBpM9Iik2kbX/cMwlxrXJoeaoyoCI4nKnFugHP+vw1Wqux1v6?=
 =?us-ascii?Q?JkE4DN2nUU/vqdvC9WCGOkPsYPomEznXpiq20n09NfxLTJ7RbE6Bepn1bO9M?=
 =?us-ascii?Q?505x5DvZ1+LP6PjFpmreoG4tu6QHnpIKN1TH9z6NvwGLHjArHIA1bvDuhnA5?=
 =?us-ascii?Q?r3OJdoaLPDcOqZKHu97p7ajjd7bi/38wxfwK/1h8kk0d91uWO9qj//kC8S25?=
 =?us-ascii?Q?p4IL05qVKBNjGB0s7gzQ7lW7GaKJrwt+I+GqI0MKMNPS+sFFkKSAF3Pu8s3/?=
 =?us-ascii?Q?7H/TADtzK6WLDc0nN3JulyZo77d+SBM0LNg5N0Ab/JjV403aVvJGDgZ6ALMg?=
 =?us-ascii?Q?MtH9X1x6U2fQOot23ICGRYsuRZmv2l/4jlMU8NUskFnZU5lqz2F+HGSnw40z?=
 =?us-ascii?Q?Vx5Fy0B34vezvuNLvjfj742GesxB9UAnw7WgEeDZJXviX7qrFj5hwMwJvX7T?=
 =?us-ascii?Q?6E4jEWXYbpocG7xHeR0KClaK0tHL2ha0j4WBCdYvoD19+wiREhz/Rf/K3usH?=
 =?us-ascii?Q?1ipuwRR0TGHkrTSzK9ZNnwVFHWRkgi+fU2gckZfpcHfEkRxsGbLt35VoYGAL?=
 =?us-ascii?Q?OJno9njmX8qXA4ILa6b3ffsMdydNPeXimLpcvZpvV4bn59PnwtJajI950lTi?=
 =?us-ascii?Q?FoGFWlB93/s0zBJXxQqDncmi8/rdf9CVhae02xoe/72Yn0KMeeywOxjUh1d3?=
 =?us-ascii?Q?7ppFBE7weKfSi8jIvyV4LxjOg/rIBOCq+4lhWu1I1dVDjo/azNeBk31tCVcV?=
 =?us-ascii?Q?79OPnbiMoG35o/k3YPKdChnGFHLPRIIk/IyGKBbxy0ixqgGQbtkzYxfIjx7H?=
 =?us-ascii?Q?OG2n+T5Wyl3ZTNhqKsa69ntkEX0x4EYWwMBjghnm1nwJUgkF4Z0+z00PSwaL?=
 =?us-ascii?Q?pjZjHK81h9wgly7VLKFpBmzVJgSwvruy72pnhPvZoHfsQV61mKbfek5CPQc1?=
 =?us-ascii?Q?i1T/fPixirBqbiOl4JsZBgj/XpZhfQdMiYanZvsWmDGYuFGc2pmh017XHiRA?=
 =?us-ascii?Q?nXoWbgpWQICsV219v2KH7xXIrhNAYEo=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a7e276-7543-41e9-5309-08de73dcb079
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 19:41:22.5361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5Uehw2tJEMiV1vhct4da8fYD/qcGhsD5/35YzfqDoerYiYjIVljmNVN57xfMbi8BdgsFwKLJz1hEDqErhwb3IrFJZnRTRsJ3yqrY7rjubo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5333
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-78307-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:email,yp.to:url]
X-Rspamd-Queue-Id: 8712618C2D1
X-Rspamd-Action: no action

NFS clients may bypass restrictive directory permissions by using
open_by_handle() (or other available OS system call) to guess the
filehandles for files below that directory.

In order to harden knfsd servers against this attack, create a method to
sign and verify filehandles using SipHash-2-4 as a MAC (Message
Authentication Code).  According to
https://cr.yp.to/siphash/siphash-20120918.pdf, SipHash can be used as a
MAC, and our use of SipHash-2-4 provides a low 1 in 2^64 chance of forgery.

Filehandles that have been signed cannot be tampered with, nor can
clients reasonably guess correct filehandles and hashes that may exist in
parts of the filesystem they cannot access due to directory permissions.

Append the 8 byte SipHash to encoded filehandles for exports that have set
the "sign_fh" export option.  Filehandles received from clients are
verified by comparing the appended hash to the expected hash.  If the MAC
does not match the server responds with NFS error _STALE.  If unsigned
filehandles are received for an export with "sign_fh" they are rejected
with NFS error _STALE.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/filesystems/nfs/exporting.rst |  85 +++++++++++++
 fs/nfsd/Kconfig                             |   2 +-
 fs/nfsd/nfsfh.c                             | 127 +++++++++++++++++++-
 fs/nfsd/trace.h                             |   1 +
 4 files changed, 210 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index a01d9b9b5bc3..4aa59b0bf253 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -206,3 +206,88 @@ following flags are defined:
     all of an inode's dirty data on last close. Exports that behave this
     way should set EXPORT_OP_FLUSH_ON_CLOSE so that NFSD knows to skip
     waiting for writeback when closing such files.
+
+Signed Filehandles
+------------------
+
+To protect against filehandle guessing attacks, the Linux NFS server can be
+configured to sign filehandles with a Message Authentication Code (MAC).
+
+Standard NFS filehandles are often predictable. If an attacker can guess
+a valid filehandle for a file they do not have permission to access via
+directory traversal, they may be able to bypass path-based permissions
+(though they still remain subject to inode-level permissions).
+
+Signed filehandles prevent this by appending a MAC to the filehandle
+before it is sent to the client. Upon receiving a filehandle back from a
+client, the server re-calculates the MAC using its internal key and
+verifies it against the one provided. If the signatures do not match,
+the server treats the filehandle as invalid (returning NFS[34]ERR_STALE).
+
+Note that signing filehandles provides integrity and authenticity but
+not confidentiality. The contents of the filehandle remain visible to
+the client; they simply cannot be forged or modified.
+
+Configuration
+~~~~~~~~~~~~~
+
+To enable signed filehandles, the administrator must provide a signing
+key to the kernel and enable the "sign_fh" export option.
+
+1. Providing a Key
+   The signing key is managed via the nfsd netlink interface. This key
+   is per-network-namespace and must be set before any exports using
+   "sign_fh" become active.
+
+2. Export Options
+   The feature is controlled on a per-export basis in /etc/exports:
+
+   sign_fh
+     Enables signing for all filehandles generated under this export.
+
+   no_sign_fh
+     (Default) Disables signing.
+
+Key Management and Rotation
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The security of this mechanism relies entirely on the secrecy of the
+signing key.
+
+Initial Setup:
+  The key should be generated using a high-quality random source and
+  loaded early in the boot process or during the nfs-server startup
+  sequence.
+
+Changing Keys:
+  If a key is changed while clients have active mounts, existing
+  filehandles held by those clients will become invalid, resulting in
+  "Stale file handle" errors on the client side.
+
+Safe Rotation:
+  Currently, there is no mechanism for "graceful" key rotation
+  (maintaining multiple valid keys). Changing the key is an atomic
+  operation that immediately invalidates all previous signatures.
+
+Transitioning Exports
+~~~~~~~~~~~~~~~~~~~~~
+
+When adding or removing the "sign_fh" flag from an active export, the
+following behaviors should be expected:
+
++-------------------+---------------------------------------------------+
+| Change            | Result for Existing Clients                       |
++===================+===================================================+
+| Adding sign_fh    | Clients holding unsigned filehandles will find    |
+|                   | them rejected, as the server now expects a        |
+|                   | signature.                                        |
++-------------------+---------------------------------------------------+
+| Removing sign_fh  | Clients holding signed filehandles will find them |
+|                   | rejected, as the server now expects the           |
+|                   | filehandle to end at its traditional boundary     |
+|                   | without a MAC.                                    |
++-------------------+---------------------------------------------------+
+
+Because filehandles are often cached persistently by clients, adding or
+removing this option should generally be done during a scheduled maintenance
+window involving a NFS client unmount/remount.
diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index fc0e87eaa257..ffb76761d6a8 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -7,6 +7,7 @@ config NFSD
 	select CRC32
 	select CRYPTO_LIB_MD5 if NFSD_LEGACY_CLIENT_TRACKING
 	select CRYPTO_LIB_SHA256 if NFSD_V4
+	select CRYPTO # required by RPCSEC_GSS_KRB5 and signed filehandles
 	select LOCKD
 	select SUNRPC
 	select EXPORTFS
@@ -78,7 +79,6 @@ config NFSD_V4
 	depends on NFSD && PROC_FS
 	select FS_POSIX_ACL
 	select RPCSEC_GSS_KRB5
-	select CRYPTO # required by RPCSEC_GSS_KRB5
 	select GRACE_PERIOD
 	select NFS_V4_2_SSC_HELPER if NFS_V4_2
 	help
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 68b629fbaaeb..383d04596627 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -11,6 +11,7 @@
 #include <linux/exportfs.h>
 
 #include <linux/sunrpc/svcauth_gss.h>
+#include <crypto/utils.h>
 #include "nfsd.h"
 #include "vfs.h"
 #include "auth.h"
@@ -140,6 +141,110 @@ static inline __be32 check_pseudo_root(struct dentry *dentry,
 	return nfs_ok;
 }
 
+/* Size of a file handle MAC, in 4-octet words */
+#define FH_MAC_WORDS (sizeof(__le64) / 4)
+
+static bool fh_append_mac(struct svc_fh *fhp, struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct knfsd_fh *fh = &fhp->fh_handle;
+	siphash_key_t *fh_key = nn->fh_key;
+	__le64 hash;
+
+	if (!fh_key)
+		goto out_no_key;
+	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize)
+		goto out_no_space;
+
+	hash = cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size, fh_key));
+	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
+	fh->fh_size += sizeof(hash);
+	return true;
+
+out_no_key:
+	pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_key not set.\n");
+	return false;
+
+out_no_space:
+	pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size %zu would be greater than fh_maxsize %d.\n",
+			    fh->fh_size + sizeof(hash), fhp->fh_maxsize);
+	return false;
+}
+
+/*
+ * Verify that the filehandle's MAC was hashed from this filehandle
+ * given the server's fh_key:
+ */
+static bool fh_verify_mac(struct svc_fh *fhp, struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct knfsd_fh *fh = &fhp->fh_handle;
+	siphash_key_t *fh_key = nn->fh_key;
+	__le64 hash;
+
+	if (!fh_key) {
+		pr_warn_ratelimited("NFSD: unable to verify signed filehandles, fh_key not set.\n");
+		return false;
+	}
+
+	hash = cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size - sizeof(hash),  fh_key));
+	return crypto_memneq(&fh->fh_raw[fh->fh_size - sizeof(hash)],
+					&hash, sizeof(hash)) == 0;
+}
+
+/*
+ * Append an 8-byte MAC to the filehandle hashed from the server's fh_key:
+ */
+#define FH_MAC_WORDS sizeof(__le64)/4
+static bool fh_append_mac(struct svc_fh *fhp, struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct knfsd_fh *fh = &fhp->fh_handle;
+	siphash_key_t *fh_key = nn->fh_key;
+	__le64 hash;
+
+	if (!(fhp->fh_export->ex_flags & NFSEXP_SIGN_FH))
+		return true;
+
+	if (!fh_key) {
+		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_key not set.\n");
+		return false;
+	}
+
+	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize) {
+		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size %d would be greater"
+			" than fh_maxsize %d.\n", (int)(fh->fh_size + sizeof(hash)), fhp->fh_maxsize);
+		return false;
+	}
+
+	hash = cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size, fh_key));
+	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
+	fh->fh_size += sizeof(hash);
+
+	return true;
+}
+
+/*
+ * Verify that the filehandle's MAC was hashed from this filehandle
+ * given the server's fh_key:
+ */
+static bool fh_verify_mac(struct svc_fh *fhp, struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct knfsd_fh *fh = &fhp->fh_handle;
+	siphash_key_t *fh_key = nn->fh_key;
+	__le64 hash;
+
+	if (!fh_key) {
+		pr_warn_ratelimited("NFSD: unable to verify signed filehandles, fh_key not set.\n");
+		return false;
+	}
+
+	hash = cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size - sizeof(hash),  fh_key));
+	return crypto_memneq(&fh->fh_raw[fh->fh_size - sizeof(hash)],
+					&hash, sizeof(hash)) == 0;
+}
+
 /*
  * Use the given filehandle to look up the corresponding export and
  * dentry.  On success, the results are used to set fh_export and
@@ -236,13 +341,21 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 	/*
 	 * Look up the dentry using the NFS file handle.
 	 */
-	error = nfserr_badhandle;
-
 	fileid_type = fh->fh_fileid_type;
+	error = nfserr_stale;
 
-	if (fileid_type == FILEID_ROOT)
+	if (fileid_type == FILEID_ROOT) {
+		/* We don't sign or verify the root, no per-file identity */
 		dentry = dget(exp->ex_path.dentry);
-	else {
+	} else {
+		if (exp->ex_flags & NFSEXP_SIGN_FH) {
+			if (!fh_verify_mac(fhp, net)) {
+				trace_nfsd_set_fh_dentry_badmac(rqstp, fhp, -ESTALE);
+				goto out;
+			}
+			data_left -= FH_MAC_WORDS;
+		}
+
 		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
 						data_left, fileid_type, 0,
 						nfsd_acceptable, exp);
@@ -258,6 +371,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 			}
 		}
 	}
+
+	error = nfserr_badhandle;
 	if (dentry == NULL)
 		goto out;
 	if (IS_ERR(dentry)) {
@@ -498,6 +613,10 @@ static void _fh_update(struct svc_fh *fhp, struct svc_export *exp,
 		fhp->fh_handle.fh_fileid_type =
 			fileid_type > 0 ? fileid_type : FILEID_INVALID;
 		fhp->fh_handle.fh_size += maxsize * 4;
+
+		if (exp->ex_flags & NFSEXP_SIGN_FH)
+			if (!fh_append_mac(fhp, exp->cd->net))
+				fhp->fh_handle.fh_fileid_type = FILEID_INVALID;
 	} else {
 		fhp->fh_handle.fh_fileid_type = FILEID_ROOT;
 	}
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 185a998996a0..5ad38f50836d 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -373,6 +373,7 @@ DEFINE_EVENT_CONDITION(nfsd_fh_err_class, nfsd_##name,	\
 
 DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badexport);
 DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badhandle);
+DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badmac);
 
 TRACE_EVENT(nfsd_exp_find_key,
 	TP_PROTO(const struct svc_expkey *key,
-- 
2.53.0


