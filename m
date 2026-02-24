Return-Path: <linux-fsdevel+bounces-78306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACrNMOn+nWkETAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:41:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6800718C28A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2858830637E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 19:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0790D30F946;
	Tue, 24 Feb 2026 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="O37GWV+l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022104.outbound.protection.outlook.com [40.107.209.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669A530F95C;
	Tue, 24 Feb 2026 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771962086; cv=fail; b=lZLlogLXRHN3p+mScw3e8ZqABBK4N1yjj/o7ETj+mGQ/bNVUy1i0jDntieZdu6WHmvypf+bRTiYLXk1gMV/BvWLgXHJ3MEVwE4urdR0CmEqCqsW3kioNTIEt2wItRRjk3VFUg+LTzruhk9uoMsyweqrlS4XN8SOYZhJw7JCmeqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771962086; c=relaxed/simple;
	bh=yrthcl/TTyv2KdXp29dveon0TcV9JdjlDyQhujkVtTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sF3Kfm+MgV+QEuCnyHJ4fTHmgLvI/zdjnftyiSizvLejL8BLgTGNzNluHcsa24asZa+Ek4t/paDJVqs3kFlSh0/MrX5Z6Com/iR7opCFgrIWjRDej769onQ/MQj8e2GmVjqW+V+gH4yO2dwaG+eVA6u4eVY5Ik7YScPK04YfkmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=O37GWV+l; arc=fail smtp.client-ip=40.107.209.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMCW7dxLn0LofP+5klPcsDaQuEeNCT3mLhu6ofkm3qSCPo/hSKCtJuqALO8aSBafhnE9ZhaQPflpA+XnU/l1VG8JmKTSthfWPgKPXb7uB2Pk76yg3+JBAjZsVVyqhfxpnyRpJAz8N/XmYH4U3gDcYVEyx5m6AXy56EI3OXfFSdHBpXvPdQLc1m3NwDugzL0vi+31+o0z7tCibNtxmwot42fXmpXY0SExc0xu8IG1hK1MRK5lkTQtvD17K8RqkULGqB2RmrOCIpU2LkUq1oa6Rmj9I/kc/4hN4M/nG+Mbof7IfJpe4YV0RKKYwNL3DnDrkGSnt5ODldr9tFY0MWp/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrAR0sP0Qcy1aidcvCUwpaWh4mRiG9s/QpolLZqqy9g=;
 b=SzxQWI6nGnLqjD9AlR8gp0s1kEZZkZGYr4dvO25jGB2hUorz84kfsguWBz2TxC6hzVbJDFTY5lNs6ASvBeG/s0T5tGi6BjcKtG4tlGVRZkmgxBjQtLB2uNKvk8kUezG9gibG7uzOGJe9tCHsAXl/wS4bo4fsCXJt4+yTPzkN8cHv6piUbY420ICxDseRSx1HxB/+yE9PYgPmTj1I2avIgJgysm+yykdv0pOzVyhEVGgc3Uq3tw26uPIvwO46aeVbLHXOEjZZQTLqKV4l0JLqqpUaRJVl2KOR9JmPkksgMrR0CI5EzCuSF/FmSpE0/FTOnL363Yo0qvRTUXLeT8TZIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrAR0sP0Qcy1aidcvCUwpaWh4mRiG9s/QpolLZqqy9g=;
 b=O37GWV+lUNDHCPgfL2hDJEXUtmuD6awHmFIq2zGSxfBWbfjAl0mFp7PxIn/FZ60xmPq3kTUNWNUVqYmXYV9vD5dVP8P7dQSkAwVzQqarATwm/ScEGMtdsvopQ7xTGXhVeehAMazZPn6eWwXsslYmLKYty7w7oaOfcOmiD4oh2YE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SJ0PR13MB5333.namprd13.prod.outlook.com (2603:10b6:a03:3d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 19:41:21 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 19:41:21 +0000
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
Subject: [PATCH v7 2/3] NFSD/export: Add sign_fh export option
Date: Tue, 24 Feb 2026 14:41:15 -0500
Message-ID: <1b3ba6ddb66cdcd2f63db2961f52894bfa3f1fd3.1771961922.git.bcodding@hammerspace.com>
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
X-MS-Office365-Filtering-Correlation-Id: 28a78ab1-59e8-42b9-e043-08de73dcafa0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tdNcAyIXWGq9vI1B/8cypQMtRb2tr1qJuRrxAQIWyEJPXthqa1zuy+eHqH26?=
 =?us-ascii?Q?vVlUEE9EIwMzhemB6Qu3fFxEIgT8F16UEHnavJgGm43dMEaBfLlyk+2z01zR?=
 =?us-ascii?Q?Nrxm+uVLEcjpN3wtqCx/8fxHApeXCpsbkRp5YzJ9ZeMHYEJRPlDPMKDEzsKG?=
 =?us-ascii?Q?ksl0RNv0zL/6abJL6bEjrZK4nqXjygtkp7V4dVBw4Q90LIvOketGx1u0JqkE?=
 =?us-ascii?Q?eUCZ6kBQb+hEWBigmUxKz93DqlPLMAZxJizUlA74mSwAFDWBCAvOvS8voDmV?=
 =?us-ascii?Q?qsVFgsSiCf4lfWl8LpwALVOIcr0b2c88lsHDB7/B9ERukgn/1FRF337ng9P3?=
 =?us-ascii?Q?OvgCKTvxYd6GtbnhBbWVFLAIH2F2ft9U+Vrs9+e00FlF7WPl4rLZ+yXO8rZE?=
 =?us-ascii?Q?QpoXYAqZAjyyTk7JSnC0rtoZ/ghzsD1iL7tPzSL8+pcxoLiWofY41QxUbr6c?=
 =?us-ascii?Q?RxYbfbv5FuL+OWOh8fm1aRcbalGE8qmIg4y6dt2uSQUOrzJ58HqPguzZ1vtX?=
 =?us-ascii?Q?VaV7qTPq6jNaEIn28DVaM2JcAbumEMChq2blXN42/fUbmxXk+nXPN7N2QRcc?=
 =?us-ascii?Q?0XuW0X+hZK7/ttLIBSWKqG7jdIkQsKMA35r/GXpaF5/fGNELnBXfgJvpPyHn?=
 =?us-ascii?Q?Aj//qZn8PIqFLV/vehwt82nfOlQpa6lmDkXq2cUZryhRT+HhH6g6g4eIcvPQ?=
 =?us-ascii?Q?GCGz4esLlvU9r8eb28/IEu17M6wMeYGIsVJn671USV5U2XahGZoDYe0ZaRuH?=
 =?us-ascii?Q?vt9xD3SnNlYj7iI3bunwJBOMf+DX8LKGZy5kkhrlV9DkOO6b6WKMxx1aoqPr?=
 =?us-ascii?Q?lBSBMHUWDZ23sGi6lB2bh4MOmEGU57qtpguhqx2XPo3/t2mC4ugJt5x1Lsud?=
 =?us-ascii?Q?jndGp1QdmdRwevmTy32l1J4yEiH+ZeziUDiDoxDTkCD3ZwAFXKAH3cp1Em2/?=
 =?us-ascii?Q?RStZju2DOsGggwC/rCMbfQPOlKRBCHlJ4p5vpMjsSepvuLAMDqKomvbPW5iH?=
 =?us-ascii?Q?EYK4+hBKx2hqniyokcE8EJdSDxMOploW2FXljLcXIZvI9sRdBw9E5pKP70/7?=
 =?us-ascii?Q?h0gqhMEL+qWJsh2oM9q3I4SIKiYZnmbPOi3rxmJmS3v3rY0pBmOi7oPwvEcB?=
 =?us-ascii?Q?X3Bm8jDawRVp/bAD3VtubI6twkvqgUvYtZ4x1Hsy2xOD92hTwhcFn4VdAQ+1?=
 =?us-ascii?Q?f5OsWS+7G1NZUxUkSy6ab1nQPzn0LmnqfMoRkk/eo2X5Rw3xTJwfwsYrOOtP?=
 =?us-ascii?Q?3nGj/NdBQOweGknWugX+jykmB/W/XOrPvTIricUal2Yl9GlsNAb3CTifBaic?=
 =?us-ascii?Q?cFZFi9al3Fkh+Gpz58bRr4RjE7hffBGtRZbV1hLEfk/IgOcSRA85dCny5ayF?=
 =?us-ascii?Q?TmId7CAGp2ZG5Xwfnx/QD4v8DY6jGfglI9YxfhN7MbZ8oWAZor8JnYrBew8Z?=
 =?us-ascii?Q?/EWVN9RaxR9yZINkng0xYXCl9/ZjpIXVi4LY/ghG/x/LwD7xOdDUSj4w/qJH?=
 =?us-ascii?Q?lBN9CDPUaYuZLOjvS7ifG1mgfiZeNwMW7a5im91LwbIDhXg+2pzQKFYjGH/X?=
 =?us-ascii?Q?kntIqTkwAMG/hqOgZ58=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LA3jiMzYBY5l34yS2IH22ivCEIPOzrxHVzfq4LqNlL4bSxafTIdI9/z0IvbV?=
 =?us-ascii?Q?scIPr8tANstvjXZOy01voOrzgOHEXbazHtC2RrrPHLgn1H2dz8pkSU0yOe/e?=
 =?us-ascii?Q?VFNtw1hqx/b99dV6xHr1ZMdi0NZpBnoywhl3LWRidzBU1g+OFjdT0G2fm9eN?=
 =?us-ascii?Q?UL3KoTDPzPYGpvg+QaBNgurS9Y99PbF0kCK+x1ytb4lz221Fww+SLdS2hPRs?=
 =?us-ascii?Q?9uS4FDof/JgQP3fY2v9pzs3W28eQWiMMT2wGJcH3K1BybdW4zI6bPfGzBFfE?=
 =?us-ascii?Q?b7SAn8FMeEVYaCDqmHXDjghxw6atqfODqxVII1vi7XenxRqAVjgOTye0UxIA?=
 =?us-ascii?Q?ltcL1e0hUJpqvaQQwzEHkCu2WlFpyziJWcIdtkFuKZUL4tswgOv9V/lctw44?=
 =?us-ascii?Q?d1601rez4wPM6Q1xqh/PLtMmwQwG36ZqEnevfLG74rPQery/kAa5cIMD3gej?=
 =?us-ascii?Q?o7KgYFFfLL9KVVNZTGwtvbVAT/77AGwdQ96it++TNMkTSAWB0sS9yNhm+B5r?=
 =?us-ascii?Q?UGnDo1kwZ646R2kCG5jHhZsT8wjxB0q7pnEuRAYLjBOhEnMZm14MUNeUoK5V?=
 =?us-ascii?Q?BNJm+Z771ubOCcTRJIAnkWqzkqFW90ucxkYUJVlzBDoz9Og4jMe74GjgZDyL?=
 =?us-ascii?Q?hohDO7hhBfn5d3LbToe2snpWLOtWRnVTKg+41G++0GujtyFdw2DjPJfex+26?=
 =?us-ascii?Q?qY7YaC0U+8jksvDca2r5Vj24IypiArMxDwXTXwuxZkKixQjt5gpks/79E0Rs?=
 =?us-ascii?Q?+srFtLRHFu2YgyCGVTS48lXwG0Sv3q0cJyvqkWghAETtRG5jDe1jjn/3uLvO?=
 =?us-ascii?Q?AVFrH7ERFfUziRcuLjlJDpmyZNLnOj+dBQM8GzVcshoJ6UYzZfVIwEK1QN7v?=
 =?us-ascii?Q?Vxs7JwuvvZjZgIPEPYTzvQ5VkLN1G3FXOQxmSmuwBBXe5Em0++ibHDx2OFev?=
 =?us-ascii?Q?esI+Enz2yW0seiibIz/7eDP1P8/KytWYjJexl4SIz5sZIdjRhynwezEqUXsW?=
 =?us-ascii?Q?nFAjnMBWdpM6IaxDRGb+rUPHk82fE4jGXvarCBzGKkem1n+MsDv3CwcKa44b?=
 =?us-ascii?Q?5ud2l8+MP3eQZTlFNDdQrM2j0mhCnv1y/pquLnKIMjipXeUvzUaGRpx605fH?=
 =?us-ascii?Q?uBFVaDmIxHz8zYmX12ez7TRfX4kQ4aiuMuaQ5sC23tQ5tPaV7f8fdeBhz13x?=
 =?us-ascii?Q?wejemq5BLPxylKpZysUw51+OD3mwDnVzud3At4KgX5FTZ6mH+ZN6dYvzZA/6?=
 =?us-ascii?Q?ytF39Dw94Escs5Xqty3HMWGcK7O7Q30K8bIJEl/CDBzywpTGYU2YKaoGKrop?=
 =?us-ascii?Q?UuttjAjsMgPs67w87X2w0FankN9FnMVZiL2odrmSAfy6roiHi6/XBbV1A/1o?=
 =?us-ascii?Q?LKLHNMhSqUVUQg6Mh465W/ppb8Uh0LJFE92CNdN64RvcVr6SDyffVfKpcwdh?=
 =?us-ascii?Q?EedDIDIJHjI45cFx97Uzf42sNCMwwh+9YckIqmqeE9mx6FxEOIRMV7rs9Gcu?=
 =?us-ascii?Q?UF9lmEYUbH7nL4maGk/luL5DthUSl7+hZxWcV8rndKga6y1bTmhfhyt6kWDy?=
 =?us-ascii?Q?x8J8EWMrpO3APY6mGG76OuUHt4Qyntdcrj4fz4n4J9Wx5FgysUi0hSQ1H5+W?=
 =?us-ascii?Q?OTgsKfrqryd/FTuP+bvvt20TVuroI1PTVDKmoUj0h7YCT4S+EdBmpa0XfUhN?=
 =?us-ascii?Q?wuSUL+6heyTG/si5gnEfJ1AGx8Jgldu7zOQft1NJLijmLsC6xLiFScaAZfur?=
 =?us-ascii?Q?+VesVj0jB443dKB+ZyYyCmc5hlZHM4s=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a78ab1-59e8-42b9-e043-08de73dcafa0
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 19:41:21.1091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbIuzfy+2GTyLK5hnDetBpOU+8+Nd18jvg4VJENhNacUv30/lyK/UmH4pSfx0jaJkxapfBWqHxO5hRnCIdhxcSVfoT/+GD9kbkNKmUVJBDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5333
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-78306-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6800718C28A
X-Rspamd-Action: no action

In order to signal that filehandles on this export should be signed, add a
"sign_fh" export option.  Filehandle signing can help the server defend
against certain filehandle guessing attacks.

Setting the "sign_fh" export option sets NFSEXP_SIGN_FH.  In a future patch
NFSD uses this signal to append a MAC onto filehandles for that export.

While we're in here, tidy a few stray expflags to more closely align to the
export flag order.

Link: https://lore.kernel.org/linux-nfs/cover.1771961922.git.bcodding@hammerspace.com
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/export.c                 | 5 +++--
 include/uapi/linux/nfsd/export.h | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 8e8a76a44ff0..7f4a51b832ef 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1362,13 +1362,14 @@ static struct flags {
 	{ NFSEXP_ASYNC, {"async", "sync"}},
 	{ NFSEXP_GATHERED_WRITES, {"wdelay", "no_wdelay"}},
 	{ NFSEXP_NOREADDIRPLUS, {"nordirplus", ""}},
+	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
+	{ NFSEXP_SIGN_FH, {"sign_fh", ""}},
 	{ NFSEXP_NOHIDE, {"nohide", ""}},
-	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
 	{ NFSEXP_NOSUBTREECHECK, {"no_subtree_check", ""}},
 	{ NFSEXP_NOAUTHNLM, {"insecure_locks", ""}},
+	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
 	{ NFSEXP_V4ROOT, {"v4root", ""}},
 	{ NFSEXP_PNFS, {"pnfs", ""}},
-	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
 	{ 0, {"", ""}}
 };
 
diff --git a/include/uapi/linux/nfsd/export.h b/include/uapi/linux/nfsd/export.h
index a73ca3703abb..de647cf166c3 100644
--- a/include/uapi/linux/nfsd/export.h
+++ b/include/uapi/linux/nfsd/export.h
@@ -34,7 +34,7 @@
 #define NFSEXP_GATHERED_WRITES	0x0020
 #define NFSEXP_NOREADDIRPLUS    0x0040
 #define NFSEXP_SECURITY_LABEL	0x0080
-/* 0x100 currently unused */
+#define NFSEXP_SIGN_FH		0x0100
 #define NFSEXP_NOHIDE		0x0200
 #define NFSEXP_NOSUBTREECHECK	0x0400
 #define	NFSEXP_NOAUTHNLM	0x0800		/* Don't authenticate NLM requests - just trust */
@@ -55,7 +55,7 @@
 #define NFSEXP_PNFS		0x20000
 
 /* All flags that we claim to support.  (Note we don't support NOACL.) */
-#define NFSEXP_ALLFLAGS		0x3FEFF
+#define NFSEXP_ALLFLAGS		0x3FFFF
 
 /* The flags that may vary depending on security flavor: */
 #define NFSEXP_SECINFO_FLAGS	(NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
-- 
2.53.0


