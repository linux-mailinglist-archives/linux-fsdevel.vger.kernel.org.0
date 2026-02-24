Return-Path: <linux-fsdevel+bounces-78305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEAiDwH/nWkNTAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:41:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D6A18C2A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A18430F0F10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 19:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0D230EF74;
	Tue, 24 Feb 2026 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="I76NPhs9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022104.outbound.protection.outlook.com [40.107.209.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDA330F545;
	Tue, 24 Feb 2026 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771962085; cv=fail; b=KjIgmOfDeHz9vFEYlipLiSxyMVIKkZvvzCC+17RYNUiB3zbuedHmirK4Zt957jfUdta/fgVyeV1Op+jorLGZOl4XXUIhp/kzyeNbVPxH3z00MY5rnZEYkHCMRjAZwirik3fTfcoyr0UrP/hoJcRJ7FUBAn9HMGmUzyU5l3TaqFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771962085; c=relaxed/simple;
	bh=9DyPebl5tWYGOhvdG7+N16dZ7Xa2fazUDyTkzO940+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ADJa8zfTAXkCii9/9moxH0RH6zrlT2rKBmXdLFYfedPOvrlYZjMFPdBY+DWLRIOX0PYvtm3P/lpM4wTT4DqA1mTyKxMJsGPexgP0lNf1TScIksU7P2tE/virr7e3RYgX0MA4aja+WTo2KRHeEs8n18DesLAG5ZY0eTRqEba2gG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=I76NPhs9; arc=fail smtp.client-ip=40.107.209.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Str+e7fhruldBSfr/YxFbMw1Bwmo21DgVqEkixJDFViZd17jE3zG/S3O52C/UVyacbF8rreIZ2vsfNZQ8dL3SGIRlPsoUK91oDHZlKmIB63MhaNXroN2h70B/jMcdj6SCTTkEzmlAtiwjoT+KNVOT1IFMXBjKdwiV96xvkOVz2SevZ5ZcIKyxvT+JlBUBH+bEr+tNzUqGEmaJAkE5g4I6WdnHhWhMCqw15zE6Qxx7vVvA+q6mmV9soAMdtu81dzeXUpmeEYnsxeE57RcPr5sJ1kqx8J+E8WK6MBMMjWgLhSNxo5M1V/dCV+whtxb2Z93gYlLfdu87zZs3mSDQATHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFkX//TpuFKPkpf2gQ8W7bEb2iU0P/rrJ5YoBxLCpQk=;
 b=Ohd6Uy1fA9Mtn3T+jQrzlBy8PAREtEVCGXjCLsDPlQM3qAx8OlCS8xKLOZAb6d2QCTLBvkJLik+4EI4ybosZEzK9QNwhhoYEPVQ33mfA/ufUzQsxFEIFveqmqXpOD9ODV2NzkGcDqgm1P/ImbBb6DAyWXGdTqTu4KDDG1m2mek9hN5+ttzbBviAOAjIDLlNRik5KKCmMJtrXfR8+edKnCoQF5g7kJVrFAeu+D/J1wIh3dN5peycXN5emnQKTB/5tQHXW0QLf/MdQdlu2g39LNaOhjcLkbxi52Q50pUuWj1R0akcsMRRtzVSsP456s3eZ1pWfFbari4BNoHzGbYRBPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFkX//TpuFKPkpf2gQ8W7bEb2iU0P/rrJ5YoBxLCpQk=;
 b=I76NPhs9jL05zx+0gkRXMhkQ5FQUjQ25nWoxBT3MMpSnECxgqTVPjj8qpSHIBVGFGJV7HUeJFcdxuMjFPVCOHYgSHopCVNZsIOyMFcr1XyTESAVpecwyv1x2WUu72C5RBLU9JLbVjimgVbi6A/6hOkW68Zf1F4l3KyOCa5KMv60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SJ0PR13MB5333.namprd13.prod.outlook.com (2603:10b6:a03:3d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 19:41:20 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 19:41:20 +0000
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
Subject: [PATCH v7 1/3] NFSD: Add a key for signing filehandles
Date: Tue, 24 Feb 2026 14:41:14 -0500
Message-ID: <2fa9ee81cca11046ba123d991dcd36997d8abc50.1771961922.git.bcodding@hammerspace.com>
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
X-MS-Office365-Filtering-Correlation-Id: bd76a1c8-c45a-48e4-fee1-08de73dcaf03
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pfdd2nLWhTYxa3p7eo2OLKZoS05a2s9Wb1+qXoK1bJMrRi9LXZTFaI2A4vYO?=
 =?us-ascii?Q?w7aZA0NUxkHQ3dZcuDshrXplaq+oTWRpV98qfWijQs4hoWN39J3OY88wxBAI?=
 =?us-ascii?Q?ChNjI9fDvKuklirqJbEMfXu+vMBgMdZSJHKLD787w5+gnAOtGkPIPpjj5rAB?=
 =?us-ascii?Q?9NktmdR2I7EjY+akpK8Lvx6fqr2+lL3kR/ME2uVjlEFu1R8GWyES8EqJUI2P?=
 =?us-ascii?Q?J6u/f/sblYHI463akpLFI++KEpAdkoNvBz/1/1x4HMR1wYXHCRYqu6AKkgQO?=
 =?us-ascii?Q?8cJTzv7EF6PxSyoXEeBXn10OgJBW/xELuWzhylo/JJTSoRYy6SjkYSoLroWJ?=
 =?us-ascii?Q?NSNqs8Z9jb+CFiL7h4t53+oLzjPFwJ6X/XIAq8L+16LGvzp3qfPLO6H+6N6P?=
 =?us-ascii?Q?EDUdNaNxNTA9Wyfp+D68POH0YY9+rlv5HscF2UyCBOmzpz3GtpDLMiIzpVZ6?=
 =?us-ascii?Q?P3WmCDGTCp10DSuc+WGM4ZQ3SlHkl6ZfJ2pOdf3qtpdXkht+5g4iMdVIGGkk?=
 =?us-ascii?Q?vbMAC9M9oKUj9a1eMJhKECmtUjuyV107NgaWkkyp94v3nEV2OMW4Hkmbx2mN?=
 =?us-ascii?Q?lxGDzjB50V+kYj6mIfawX0bKZBn1p8u9Irq/TEsvlR4dCcuLrQTUxQIt9wR4?=
 =?us-ascii?Q?FcgistkJ80tXAgrENoX4vOxUb0KiTxbF/HKvuuVpgVIpdEeGZYFM/ZpJNzuB?=
 =?us-ascii?Q?cS9+cY3WnVT5L9CSmb4J7i5ACd0v0IgCP0+UumJ4yWLNIG/bp+OiS04Og4bE?=
 =?us-ascii?Q?aCLCIXQzrpMbrvDX6dbu1TMLIf2NnNAv22qMNdvFpOuMBoCHDKWQSNR+hJ/u?=
 =?us-ascii?Q?8aLzkBoQiAP2wA10BMQ9VFL49SPuPEJgtfqOErGwRunJZLuXfDlO6TzsIAeU?=
 =?us-ascii?Q?oT8whaJGVBk43wdMrub8VT0YsCp7BDjyqCs1xJhKcAPRky5W0/fLe8c1Jq1N?=
 =?us-ascii?Q?x+lESa3Pypw04Z67BKJoa17UHFlmI/7MHGkl8vy4wHeYI4w44UO8sO2ejwW9?=
 =?us-ascii?Q?0s8P9Ph0a78cPtFKJb/mGtbFjiC7JjdXd6veWUCOhxNbBq7nRtP4Wafbao/1?=
 =?us-ascii?Q?59ZHdrxyI+8/aiiws8EEyS1qCQGQ+LcT9lIRtRwLzhupCTyzh9z65eTzMBLl?=
 =?us-ascii?Q?MOYBXi3AIu5hnoJYmGDqH7/AEinbkUao4C0TZMD0QdqzTUbT43E6q+EKd4No?=
 =?us-ascii?Q?3ueaBEqOSR8MqvYWskxa3oXzvcGOnPQ8YZeG5KW+o2IN6oqT/w6W8xOoFDRS?=
 =?us-ascii?Q?S3i+jcciQFr0HQUFHWiE2useo/VgX1JYfwMiTfdcsnr6PpE5awGC+CJOdXTs?=
 =?us-ascii?Q?qL6WOJSilHCrabobAiDi9ecVmKLwq62uN3JQCD0CaqvU1K0Ax7QNYTJF2eCo?=
 =?us-ascii?Q?wqfQNjRNwgrBysnpZrZcsQaCidtCTp+SKvAW7yTKWY+n/zfw2MQoLzj729p4?=
 =?us-ascii?Q?upQ0GIlmTsiVd1Gmr1xbJmk76F/y7vAc6JviUaSX/qBJzIqEwbYAyRpft/fj?=
 =?us-ascii?Q?2d0xNpgOl74EkAw8Tj5iSrIsyu28mw0kZtdv4CT8XwRxIvzvtnFVM2WrApqW?=
 =?us-ascii?Q?wo0uDnxpkw3LY6doIXw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MYXH4EnrUTQFqVnVlDpAYU2hkYMHaFmWDDNG/WaM8SkL4qB7ioVGt+u8mJvq?=
 =?us-ascii?Q?CwI075ltK8IqaHnesfadiM3cSaJ2v8in08MySltbv9hzI0fj+V9fEbv4YQ3z?=
 =?us-ascii?Q?W3/nookukdupe5LWLAGj8yCsj8Zs9TtBDdFV5+1TTYMfmDdaegARkhDQcCsi?=
 =?us-ascii?Q?MuFTHv6PBjKMbwQKGDWF/gAM7S+ijdRF0kyCAvMZ+p3ENmV7BebRm69/74jM?=
 =?us-ascii?Q?RNukhT6FTY0N2Ewh6+yj+UjOrMuxxVRcLthgjwuOqwqTbclhZSl+oRZ0K7s7?=
 =?us-ascii?Q?NwWllhiZU1aru8efjSmTcVCO12zjbtf5kDd/sCqMBjRRceWgomRMzEitlpv5?=
 =?us-ascii?Q?gg6+sWmkxNt/Acudur0c45l/LUwp59Cydq0RiaQSHPuQLW0UNTZAJMbFP4Tp?=
 =?us-ascii?Q?GiRta5fFy53s4cBKU3fG/ADk0UF/4CSFaWsmZiLquzSxaPG/vBefXfx0DFkV?=
 =?us-ascii?Q?hsa4wD+PxN8ti/Cb0W4YpafNy3/lpfmKCG0eeTm8LvdylQnlvhsNsnJ3byGV?=
 =?us-ascii?Q?VdHIz6IkP4Mb01qdpaQTbbmAwsAol+5O7M8ajweXzWlYyctRzhsTYvTFU6c1?=
 =?us-ascii?Q?XHTOnzmAM03OX5ga3W3TzlQD5BAbZjkuOqJ8zxZ9wg212Dc59fxnZZPuA9gi?=
 =?us-ascii?Q?wpXACcFxErkurjNG7wRLkcUBypafelU1PzkWpCdILeINtbzKOC0Jk5O5ioIf?=
 =?us-ascii?Q?jBKOmoE3zWNCyCswj9fFwM4HNzQsuMwZlR/odkFWOy/A/BigvdKGOVwnx1Ex?=
 =?us-ascii?Q?5qtj4vyRMNhr95Q4eB+LsuhopVMuhYU48SHDFAxBvZv4/L1StMCysKMeQVIR?=
 =?us-ascii?Q?0DhtXAUa9VuZd0DZ42KrO5r6uj0Mk4XWo7v8t6WhZD3wt1aha/WS61s20VsQ?=
 =?us-ascii?Q?J6Gqs6KIq4tVmAAZZDhnGHMeb63sJ++v6X/cl4o1tY4z/gvKF5RduUreJVRO?=
 =?us-ascii?Q?oQ2xUtM+TiSLVaTdcSy8VCrS7aCEnxB+gDbNHXn6JlQvdYV6pgSG6aUJxQ4T?=
 =?us-ascii?Q?zqXFw7DqQCjr+CyzN4/+70iyV9//x9U7qV3egi7gvFXoG/VYC2W0eAv3ctnP?=
 =?us-ascii?Q?+snHVcYmAJ+RbdlGsAVYMsbPz8CKFL8mL80y7WEgWpBVVHUE/rDf1lAUkGJu?=
 =?us-ascii?Q?Ho0sgyCTHV8RWQQqBuzE4i4Gdvkcfsy6SUVUTnKfsr/KMFF8PVohCgv89LtH?=
 =?us-ascii?Q?QpXK2pgNe1Xbw0O5Vf9EKxhBmydvf5mlFEG0ieKXOqdBGau/6S+Fv5sTNTZ4?=
 =?us-ascii?Q?j/0YJuuMeKUU0dC+pwaBRYTCQbgziSot3QnYg5C6aB65OOcPSnlekvaeIRuD?=
 =?us-ascii?Q?2x6DB4ndJm7zey/C3eLQRyz7qjcPi5I9j1VjX8K8EJghTtrbfIzabl7jMoVn?=
 =?us-ascii?Q?GcPTKlCcjtmNQFfynkVIV8TUmbXKhNEhtwYqbs7hndSz8Dz5Z0+kSo84BlhX?=
 =?us-ascii?Q?SI1yeZJXO8htMTwXIXhY6BSyPau9zUMgjrb4ocUuGiT+ywqrX+hwAPkT38M4?=
 =?us-ascii?Q?fnPzhrM/PdqMsuhiqEQdL84XNjuhQ6GCm+8YQ3pduUgp9/Na1jS0MN+C/w/7?=
 =?us-ascii?Q?pMmvjA1bqfsGtq2S8Gd83keH9J+CMGbtUgcEcr3pQg09r7TaW7byTQkG3fJm?=
 =?us-ascii?Q?KUa5E9yoGkEfeX0D7y+KMbzQSHGWoO1vHmrcpB8KhrjjEzj0c7VAxnpmIOKK?=
 =?us-ascii?Q?sOxbPxq3HXAI8btNDhQJdxE4ZkrnjswML1tKtk9sdDd8Io9IwtmfP1UuRZGS?=
 =?us-ascii?Q?iNfskyvCK59ZAUfBTGkcr5aqaruozAE=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd76a1c8-c45a-48e4-fee1-08de73dcaf03
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 19:41:20.0926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04YZkXqx3QFzKdSBVHT8UxnHwPUbgNHb4/lD4VpGfrz/dyNrD9+3uRSGWgUJGRtjKSbR3/+ye1sNCMF0DADVfih1xfyBQw6tTVk/ou0wGr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5333
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-78305-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:email,oracle.com:email]
X-Rspamd-Queue-Id: 93D6A18C2A9
X-Rspamd-Action: no action

A future patch will enable NFSD to sign filehandles by appending a Message
Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit key
that can persist across reboots.  A persisted key allows the server to
accept filehandles after a restart.  Enable NFSD to be configured with this
key via the netlink interface.

Link: https://lore.kernel.org/linux-nfs/cover.1771961922.git.bcodding@hammerspace.com
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/netlink/specs/nfsd.yaml |  6 +++++
 fs/nfsd/netlink.c                     |  5 ++--
 fs/nfsd/netns.h                       |  1 +
 fs/nfsd/nfsctl.c                      | 38 ++++++++++++++++++++++++++-
 fs/nfsd/trace.h                       | 22 ++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  1 +
 6 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index badb2fe57c98..d348648033d9 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -81,6 +81,11 @@ attribute-sets:
       -
         name: min-threads
         type: u32
+      -
+        name: fh-key
+        type: binary
+        checks:
+            exact-len: 16
   -
     name: version
     attributes:
@@ -163,6 +168,7 @@ operations:
             - leasetime
             - scope
             - min-threads
+            - fh-key
     -
       name: threads-get
       doc: get the number of running threads
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 887525964451..4e08c1a6b394 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -24,12 +24,13 @@ const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] = {
 };
 
 /* NFSD_CMD_THREADS_SET - do */
-static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_MIN_THREADS + 1] = {
+static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_FH_KEY + 1] = {
 	[NFSD_A_SERVER_THREADS] = { .type = NLA_U32, },
 	[NFSD_A_SERVER_GRACETIME] = { .type = NLA_U32, },
 	[NFSD_A_SERVER_LEASETIME] = { .type = NLA_U32, },
 	[NFSD_A_SERVER_SCOPE] = { .type = NLA_NUL_STRING, },
 	[NFSD_A_SERVER_MIN_THREADS] = { .type = NLA_U32, },
+	[NFSD_A_SERVER_FH_KEY] = NLA_POLICY_EXACT_LEN(16),
 };
 
 /* NFSD_CMD_VERSION_SET - do */
@@ -58,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.cmd		= NFSD_CMD_THREADS_SET,
 		.doit		= nfsd_nl_threads_set_doit,
 		.policy		= nfsd_threads_set_nl_policy,
-		.maxattr	= NFSD_A_SERVER_MIN_THREADS,
+		.maxattr	= NFSD_A_SERVER_MAX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 3a89d4708e8a..6ad3fe5d7e12 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -227,6 +227,7 @@ struct nfsd_net {
 	spinlock_t              local_clients_lock;
 	struct list_head	local_clients;
 #endif
+	siphash_key_t		*fh_key;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index a745b97b45fb..032ab44feb70 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1581,6 +1581,32 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 	return ret;
 }
 
+/**
+ * nfsd_nl_fh_key_set - helper to copy fh_key from userspace
+ * @attr: nlattr NFSD_A_SERVER_FH_KEY
+ * @nn: nfsd_net
+ *
+ * Callers should hold nfsd_mutex, returns 0 on success or negative errno.
+ * Callers must ensure the server is shut down (sv_nrthreads == 0),
+ * userspace documentation asserts the key may only be set when the server
+ * is not running.
+ */
+static int nfsd_nl_fh_key_set(const struct nlattr *attr, struct nfsd_net *nn)
+{
+	siphash_key_t *fh_key = nn->fh_key;
+
+	if (!fh_key) {
+		fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
+		if (!fh_key)
+			return -ENOMEM;
+		nn->fh_key = fh_key;
+	}
+
+	fh_key->key[0] = get_unaligned_le64(nla_data(attr));
+	fh_key->key[1] = get_unaligned_le64(nla_data(attr) + 8);
+	return 0;
+}
+
 /**
  * nfsd_nl_threads_set_doit - set the number of running threads
  * @skb: reply buffer
@@ -1622,7 +1648,8 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NFSD_A_SERVER_GRACETIME] ||
 	    info->attrs[NFSD_A_SERVER_LEASETIME] ||
-	    info->attrs[NFSD_A_SERVER_SCOPE]) {
+	    info->attrs[NFSD_A_SERVER_SCOPE] ||
+	    info->attrs[NFSD_A_SERVER_FH_KEY]) {
 		ret = -EBUSY;
 		if (nn->nfsd_serv && nn->nfsd_serv->sv_nrthreads)
 			goto out_unlock;
@@ -1651,6 +1678,14 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 		attr = info->attrs[NFSD_A_SERVER_SCOPE];
 		if (attr)
 			scope = nla_data(attr);
+
+		attr = info->attrs[NFSD_A_SERVER_FH_KEY];
+		if (attr) {
+			ret = nfsd_nl_fh_key_set(attr, nn);
+			trace_nfsd_ctl_fh_key_set((const char *)nn->fh_key, ret);
+			if (ret)
+				goto out_unlock;
+		}
 	}
 
 	attr = info->attrs[NFSD_A_SERVER_MIN_THREADS];
@@ -2250,6 +2285,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	kfree_sensitive(nn->fh_key);
 	nfsd_proc_stat_shutdown(net);
 	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 	nfsd_idmap_shutdown(net);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d1d0b0dd0545..185a998996a0 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2240,6 +2240,28 @@ TRACE_EVENT(nfsd_end_grace,
 	)
 );
 
+TRACE_EVENT(nfsd_ctl_fh_key_set,
+	TP_PROTO(
+		const char *key,
+		int result
+	),
+	TP_ARGS(key, result),
+	TP_STRUCT__entry(
+		__field(u32, key_hash)
+		__field(int, result)
+	),
+	TP_fast_assign(
+		if (key)
+			__entry->key_hash = ~crc32_le(0xFFFFFFFF, key, 16);
+		else
+			__entry->key_hash = 0;
+		__entry->result = result;
+	),
+	TP_printk("key=0x%08x result=%d",
+		__entry->key_hash, __entry->result
+	)
+);
+
 DECLARE_EVENT_CLASS(nfsd_copy_class,
 	TP_PROTO(
 		const struct nfsd4_copy *copy
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index e9efbc9e63d8..97c7447f4d14 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -36,6 +36,7 @@ enum {
 	NFSD_A_SERVER_LEASETIME,
 	NFSD_A_SERVER_SCOPE,
 	NFSD_A_SERVER_MIN_THREADS,
+	NFSD_A_SERVER_FH_KEY,
 
 	__NFSD_A_SERVER_MAX,
 	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)
-- 
2.53.0


