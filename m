Return-Path: <linux-fsdevel+bounces-76857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFZpGnpji2nDUAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 17:57:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAB111D7A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 17:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0A6A303799D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 16:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00483246F0;
	Tue, 10 Feb 2026 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="UIGmc8vC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021073.outbound.protection.outlook.com [40.93.194.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E33030C60D;
	Tue, 10 Feb 2026 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770742586; cv=fail; b=kvpVjERWpuNQXsFoimdHZhUSLYprnuS2cHeiGBvrUOSLxXtRWncu7jskVXgORFLeCirIaXBiVn1jFPrr26XJTcfcgtqpcqf3s+NVliwzd72LwwGb6aKVIrMbMlX5y1Tt4qE6MSwgGk71U5yCvt0QjXWsOWmPhUTjf4PAO4Z5pb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770742586; c=relaxed/simple;
	bh=bpMVn+Oe1Fow3BG9a7MCeMmchV5zkF1zLpcfA6Uor/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=De1SPXmF8xlFuprLANXzEcqrKQIo4/dShDCj+5W70y4P+MuqRbYjxxs3hAouXPV7bF2TqmVuQ8lr0xQMHmq37lW+TYQPyBlX8q3nj9N+sfwTXD9bvA1F/mBInUbbfZohlm1gvlVc6lnHTU9R7EdUc4foqJnedeNYtZL8NUnPWNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=UIGmc8vC; arc=fail smtp.client-ip=40.93.194.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCmHboimiVuBxsmrrIzbCVFqcWhpbWZ4OoWtyKHXjIKzKDDZ4MnZox1Fjd0jp0K4pKRbJ+dTIcC96JndK+JdKo61XRsJFE8z7stx0G3mMMcXTURnZF0qODlUlUp/Ezz8B9KapDXRJNswI6iJE3hSBSztSnoygooldB1oWCp/lzmWJlliv86W/MbarA495F4o2ULxF6cC8QY4jjQiyMIrmriQrrhUivmr6s2F04avxWQgE3lJKnKSm2+9Lnhbz6dr+34DVu8MBC6vDtXSRPqwGlCCeHMY2mgknRf229aE8LUNWLvyOhVYj/QPifBYq5jrMFxEl6mv+Wry0xi/oWryCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIw8fJ51kBO/Ijyli249eEe+x8P2fQCr+lT6lZ4LwlA=;
 b=bZaD/pLz/YfM4S7XFj35FX3sAQ99p/hILpe/gzdW+UoK5G9YeFwIStISPR52j6BrhkGjqycc0POMv5+PLk+imXK7TaiBfkjIHyOnfKUoryAHgMjl2oVxvo/PDJtnhpXG2dvSteAsPkoLoR3N3trVifCxFV4gnq8dI4o1MpV+ulmfND7g0cr9nHIkClBRWfIV98b6mTaxbGaoS0idKtiNr0SpXzAj+kmchdzHNl89NnPhrmzp9FdnfotfJl9+Z5X6+YjjAwJNECsW5SXXcBIhJlemVi44loK4bP/1xBWA4XFEigAmN3VG32NBW8ZtCPhjl7XkY+yrpHA/CTJ6xiEzqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIw8fJ51kBO/Ijyli249eEe+x8P2fQCr+lT6lZ4LwlA=;
 b=UIGmc8vCU6AWh1lBoiR1w+L9kehs5jnPrNGqYBoFIgxouxvhxbpPqwLSNyTmttrwFA4d/YMQyHcNCdgoNxI31rDESqObja+NHhk2yOoz/mTF34TIKGvuSs398knVXrvXBLDp7oWq3XkwQhW4iSoaGiBzEs0jEACFH0zVWTlHDB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 BY1PR13MB7116.namprd13.prod.outlook.com (2603:10b6:a03:5a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 16:56:21 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 16:56:21 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v5 3/3] NFSD: Sign filehandles
Date: Tue, 10 Feb 2026 11:56:18 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <8CDB950C-7FAD-493A-A69D-9F7AB0D3775F@hammerspace.com>
In-Reply-To: <8574c412-31fb-4810-a675-edf72240ae29@oracle.com>
References: <cover.1770660136.git.bcodding@hammerspace.com>
 <c24f0ce95c5d2ec5b7855d6ab4e3f673b4f29321.1770660136.git.bcodding@hammerspace.com>
 <8574c412-31fb-4810-a675-edf72240ae29@oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:208:36e::21) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|BY1PR13MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 057450dd-dd8a-4159-6079-08de68c55133
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PDHWaWcVpw8ikEf8pqCMXgY5jsWCyPXRLNhozazvhP2xmCSKrWHfu67PABZq?=
 =?us-ascii?Q?xPQ2D4aoSF034BXdegDBFy9QAEazB0ekJmZT2KadqUOTdinH1snoGPnTdUus?=
 =?us-ascii?Q?eIWzjuD9VaDS/prYEbhCjHcwD1LidtPHT/SYLXdhUhFOB22VfOla8Ie0KzUn?=
 =?us-ascii?Q?x/v1QoEgnB7DPQQjoo64uDiMDcfSl80Qrqg/aJigf+Y1ZBFUrzfAPI+HUT0S?=
 =?us-ascii?Q?c+lbMvyZs80o1xSr12wyNlnD6p7S8Wl/IJReC7KDpcVtBXqAPldhITLBE35X?=
 =?us-ascii?Q?hpzJRle0+rVV1bgVp1jpdoqDO2O1SlkVSdo8lDaiILMLyT8QdTDnps+NTre+?=
 =?us-ascii?Q?+n4NZInnRp5geq86JZ3EbpKuRdQ8nbFEPF//JQHI8BYuQ6u6t1zSyDBbK76m?=
 =?us-ascii?Q?SiUbUJztHh3kUI7FRfULGGUv/b1hHAb8g+LdJz2z4naiupGV/S1ejUoNB3J3?=
 =?us-ascii?Q?FhbQmvOoRAMEvi2DMk4eBgkVdd+cDrpCI9m359RaSicT95EsTDktmyjwAxDl?=
 =?us-ascii?Q?oMsj/sehrMBqiN1GwGAGWPx7fOZxEaCTy8ZcYYHyz7Qp7KQYOh/hngvtbMo/?=
 =?us-ascii?Q?+6M2Ob+B8z2SDtOdfatuuDP+24BC9nEa1U/nM0pAxLr+yowq0oNn9ByIKiGe?=
 =?us-ascii?Q?hdH+rquhY2V/fJZ6WMIZ28H1N8U5mUg+Irps03YBJAKFI0YB/aZRzWeGDQzv?=
 =?us-ascii?Q?G3XFu1B44p0ibqTwUujr5+EE3+qJWzCm9BkfLO0yAs2imxoC8W05aDKi0j/S?=
 =?us-ascii?Q?wRkLX81XzwaA7AJclgerT04VzhMn96A//9ylI5N+io2HYBpAfD95sqv9Q4Pw?=
 =?us-ascii?Q?cS5LOUi6S8JYoKbHzQyziX3TYPqLLCxUSsswZ7elxjlXDkARAOyAT4mx3Yke?=
 =?us-ascii?Q?8LADKWI8cdJHI4LWaXWraDD1EYyxCe70Rgy5QH6e9NyBUIvb0Ajdm4XE/Tjw?=
 =?us-ascii?Q?lK0BJhC+rW0G8dhp1fIs1DfNgc+ySni4Ue78KubUo4gTotXgagQPV01OMEtu?=
 =?us-ascii?Q?/CgP8bupghfEwjLSOIFg3/mI2xH+LfVzZ34wPpFccfWuOvNgjwytZ4mfZ9eo?=
 =?us-ascii?Q?KNJEnZb89zLiFQZQPD5oYam+N+Wfp0567a/YOjDYabiayLzlBs0uL1k9kHHo?=
 =?us-ascii?Q?b259YEcuYdsA/Kw1Kw6rwd1yo7UfTcZm55x4ejUpnebbPoGnYPBImX1Ru9/Y?=
 =?us-ascii?Q?blbh7xNhxZEBj5PzNsfnKyiGYmVjsYV/rY4j8TrWzWF7XHTMeB9nm5y6eAkG?=
 =?us-ascii?Q?KsqRqg5bMDi+QkCl/GLJ0UOpUicnlz48TuI5fE8WVWhATMIElwcHpPXwHA0l?=
 =?us-ascii?Q?x1HyC6NBKZV5yRr15gOPvyaI4RWX+nar8/3Uno1TJBibitRj3BhhX/AQ2GL+?=
 =?us-ascii?Q?4W4ZRt71RFcdMaLVbqlV5G/u2Yh1FUq6wdyKSw/GPoF9TDXz/LAqdrGxmxYV?=
 =?us-ascii?Q?fpnu7DIzWAPfWyu1dXWF2L3f+P3dZOy/baGn04H49fImkPy5fC1Qm/6A1Sxr?=
 =?us-ascii?Q?QSQ5J8QP5Era4SA9fdW0p8ZR4M91pzkE342iqeEhrjhj5e3mZNIDXKOY1s4e?=
 =?us-ascii?Q?cy4fjKhytFn0aM8Bgdg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VOELWq/rsowvpk9CnyTz5sLOmme0vK0QWfy5Wo1DozfwIhaqGWxwYzrrGhMm?=
 =?us-ascii?Q?91+yVKkT9mOBXAT2OISBmTEK0gLIi6p3CVZJtqVBqdNVWQRgnW0khUnMJAk3?=
 =?us-ascii?Q?V4H3d2XO7Ss9ABqRZR6N9PUEJd+12505VEaPAPO5RHsuVWxHnQutIK6RPiQy?=
 =?us-ascii?Q?IT6Zwd75jk7pE0d4Krqw4Fd/8LkbfCEuyisoV1zBqDU45Tv7jwHDXs759UUk?=
 =?us-ascii?Q?HK4iFJA31AfzM+5Pi1BVY/v5WH6zga4cCo1RMWpHRIh94iFZ8e0aVexynYkI?=
 =?us-ascii?Q?c+itaiiToXc75gRqAxoW9hRDn3cErUKUyyZZvOvlE7BYDmB/6iDPY9zRkfQt?=
 =?us-ascii?Q?prq73wCSU4U6fMKdFnTRtQ3Z7uLwu2xTPlXt02eNkDK4tW4NmlvBkGFSXZPP?=
 =?us-ascii?Q?YQH7U4iwxnsfMEPLQca2VBOc+K+4tpL7eKXPx96HTjzL2mrzgY5QcphJIBR9?=
 =?us-ascii?Q?+VjAQMrov93lwOVBBwTl2F+Ba1spD2s1Hvcyu2pIbxJAFG3zYzX3IbPp7Oax?=
 =?us-ascii?Q?jtAx8Ndu7RU15NY+0Fct8rCWK8WEShQ/GGQrnbURmAznCtmNd3aw+rx3P4Kv?=
 =?us-ascii?Q?xOE2GPZnWXmCnONvz9UrjQQg56+iiKUOD2SoKIBWvvs9hp6pqb6fKBrGInYV?=
 =?us-ascii?Q?57zxejA/fFBlbnH22gC7sdIs7BGvupr8AnUIfswenJ9iTca/feKcTRRR/146?=
 =?us-ascii?Q?yygYM/E2u5eO+mjIqOv7NH5hcpzexfy4mpPeu3kjhvNtUCupNSaPN9mO3G2i?=
 =?us-ascii?Q?irvZVKKboCJLhgSOSJSQVdL9CjCSn/P/fpmrJhg2UQlAsIo5fp4EQaKuqZtU?=
 =?us-ascii?Q?4OHekXlr2ZVzDpFt7EaPZ+cEfmP+Kp9y7SHtAGXiFpVFd2ZFmoRdgh3id3ym?=
 =?us-ascii?Q?DDKcCIgmmdvKHnJ1HP5miCMQYNIDC/dZbeluam4uQ0YFEs499mWueXqFVLgf?=
 =?us-ascii?Q?aJulcDmqsyIFcahBroCxh7dGDzFrv87lXqUsWODIN9IvZE+oWYWS6a5Mco0k?=
 =?us-ascii?Q?NF/s13C7gsFmaYJcW5IJJKDYLYU8w8J8ugwF5lYveN7Nwhf3UoOj08tL2Eq+?=
 =?us-ascii?Q?xr9R+QhKyNUtFIZqtDAAJH7jCFhZ61PM6f0XzI/brQiGNlails8hmojLjUwf?=
 =?us-ascii?Q?n6FgeYSdtctY0nBftfAHqG6A5xMSQ43GI2znb4SmA23fpmtCKd4z0xpTQOsk?=
 =?us-ascii?Q?j5SDuMhQn3wIv9cx+/b0PMMLE/VBRvqahloJqgq1PyofD71iyhzkbZWe3M4i?=
 =?us-ascii?Q?MR90JMy/qdr3CHbjRco1qfvGicGT1uIqLLadjOG36JEa2KCUrFKuIljl+Kmi?=
 =?us-ascii?Q?Q1c/9t8JQLUz2PP3RlI5SnwG+bnxeNjhl6kNO2nXuogvuOUCk9Ht3afiVXOq?=
 =?us-ascii?Q?SkCZd5wFoGqJ9LYKlFzlMCXsC5ypekAS/4WbAvQZRfSroPaNgj6BCvfLBwdN?=
 =?us-ascii?Q?Odyd63U/usS0Ol97JF/b8A2X1p0CRYLh3MzCEPNwTcP3l423KR38oKMpOuiI?=
 =?us-ascii?Q?XUvA1GcniNfmz4DYKvyyrXozlDTGSFzxvbosv68dRr6S7M0ujQotX5IZ9tbL?=
 =?us-ascii?Q?5R7GXg3m7+C7Rf38upDTKztkM9+h4qj9afAMZNvQ2YmImpfY14DX1txy/mnl?=
 =?us-ascii?Q?a25FEx7m812/Eg4PL0SIKH5eaBsn5w2Ud/6Yud0pwLelnNfUcQZvU7Z1oe+l?=
 =?us-ascii?Q?PP77YkAUGYDefPBwNr1aRZhKUiThhMNSqOkEbtIjzP9JF8r0ITcWv94K9++Z?=
 =?us-ascii?Q?sMqXfQu4+hWhtogi9vFzYVKPYtPnxFE=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057450dd-dd8a-4159-6079-08de68c55133
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 16:56:21.4546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNHouJLmD6bQpTGYF1IdEnbaZgRdyLymFHQk+gqfgsbiLc5uOdZG7BwQ/0SSiXtgpyLafth8DiHvUTLD9VmVe2vH9nkFGqCTtPE2+RkkN64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR13MB7116
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,brown.name,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76857-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:email]
X-Rspamd-Queue-Id: BFAB111D7A6
X-Rspamd-Action: no action

On 9 Feb 2026, at 15:29, Chuck Lever wrote:

> On 2/9/26 1:09 PM, Benjamin Coddington wrote:
>> NFS clients may bypass restrictive directory permissions by using
>> open_by_handle() (or other available OS system call) to guess the
>> filehandles for files below that directory.
>>
>> In order to harden knfsd servers against this attack, create a method =
to
>> sign and verify filehandles using siphash as a MAC (Message Authentica=
tion
>> Code).  Filehandles that have been signed cannot be tampered with, nor=
 can
>> clients reasonably guess correct filehandles and hashes that may exist=
 in
>> parts of the filesystem they cannot access due to directory permission=
s.
>
> It's been pointed out to me that siphash is a PRF designed for hash
> tables, not a standard MAC. We suggested siphash as it may be sufficien=
t
> here for preventing 8-byte tag guessing, but the commit message and
> documentation calls it a "MAC" which is a misnomer. Can the commit
> message (or even the new .rst file) document why siphash is adequate fo=
r
> this threat model?
>
> Perhaps Eric has some thoughts on this.

I'll follow the guidance already posted from his response.

>> Append the 8 byte siphash to encoded filehandles for exports that have=
 set
>> the "sign_fh" export option.  Filehandles received from clients are
>> verified by comparing the appended hash to the expected hash.  If the =
MAC
>> does not match the server responds with NFS error _BADHANDLE.  If unsi=
gned
>> filehandles are received for an export with "sign_fh" they are rejecte=
d
>> with NFS error _BADHANDLE.
>
> Should this be "with NFS error _STALE." ?

It should.

>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> ---
>>  Documentation/filesystems/nfs/exporting.rst | 85 ++++++++++++++++++++=
+
>>  fs/nfsd/nfsfh.c                             | 70 ++++++++++++++++-
>>  fs/nfsd/trace.h                             |  1 +
>>  3 files changed, 152 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentati=
on/filesystems/nfs/exporting.rst
>> index de64d2d002a2..54343f4cc4fd 100644
>> --- a/Documentation/filesystems/nfs/exporting.rst
>> +++ b/Documentation/filesystems/nfs/exporting.rst
>> @@ -238,3 +238,88 @@ following flags are defined:
>>      all of an inode's dirty data on last close. Exports that behave t=
his
>>      way should set EXPORT_OP_FLUSH_ON_CLOSE so that NFSD knows to ski=
p
>>      waiting for writeback when closing such files.
>> +
>> +Signed Filehandles
>> +------------------
>> +
>> +To protect against filehandle guessing attacks, the Linux NFS server =
can be
>> +configured to sign filehandles with a Message Authentication Code (MA=
C).
>> +
>> +Standard NFS filehandles are often predictable. If an attacker can gu=
ess
>> +a valid filehandle for a file they do not have permission to access v=
ia
>> +directory traversal, they may be able to bypass path-based permission=
s
>> +(though they still remain subject to inode-level permissions).
>> +
>> +Signed filehandles prevent this by appending a MAC to the filehandle
>> +before it is sent to the client. Upon receiving a filehandle back fro=
m a
>> +client, the server re-calculates the MAC using its internal key and
>> +verifies it against the one provided. If the signatures do not match,=

>> +the server treats the filehandle as invalid (returning NFS[34]ERR_STA=
LE).
>> +
>> +Note that signing filehandles provides integrity and authenticity but=

>> +not confidentiality. The contents of the filehandle remain visible to=

>> +the client; they simply cannot be forged or modified.
>> +
>> +Configuration
>> +~~~~~~~~~~~~~
>> +
>> +To enable signed filehandles, the administrator must provide a signin=
g
>> +key to the kernel and enable the "sign_fh" export option.
>> +
>> +1. Providing a Key
>> +   The signing key is managed via the nfsd netlink interface. This ke=
y
>> +   is per-network-namespace and must be set before any exports using
>> +   "sign_fh" become active.
>> +
>> +2. Export Options
>> +   The feature is controlled on a per-export basis in /etc/exports:
>> +
>> +   sign_fh
>> +     Enables signing for all filehandles generated under this export.=

>> +
>> +   no_sign_fh
>> +     (Default) Disables signing.
>> +
>> +Key Management and Rotation
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +The security of this mechanism relies entirely on the secrecy of the
>> +signing key.
>> +
>> +Initial Setup:
>> +  The key should be generated using a high-quality random source and
>> +  loaded early in the boot process or during the nfs-server startup
>> +  sequence.
>> +
>> +Changing Keys:
>> +  If a key is changed while clients have active mounts, existing
>> +  filehandles held by those clients will become invalid, resulting in=

>> +  "Stale file handle" errors on the client side.
>> +
>> +Safe Rotation:
>> +  Currently, there is no mechanism for "graceful" key rotation
>> +  (maintaining multiple valid keys). Changing the key is an atomic
>> +  operation that immediately invalidates all previous signatures.
>> +
>> +Transitioning Exports
>> +~~~~~~~~~~~~~~~~~~~~~
>> +
>> +When adding or removing the "sign_fh" flag from an active export, the=

>> +following behaviors should be expected:
>> +
>> ++-------------------+------------------------------------------------=
---+
>> +| Change            | Result for Existing Clients                    =
   |
>> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
>> +| Adding sign_fh    | Clients holding unsigned filehandles will find =
   |
>> +|                   | them rejected, as the server now expects a     =
   |
>> +|                   | signature.                                     =
   |
>> ++-------------------+------------------------------------------------=
---+
>> +| Removing sign_fh  | Clients holding signed filehandles will find th=
em |
>> +|                   | rejected, as the server now expects the        =
   |
>> +|                   | filehandle to end at its traditional boundary  =
   |
>> +|                   | without a MAC.                                 =
   |
>> ++-------------------+------------------------------------------------=
---+
>> +
>> +Because filehandles are often cached persistently by clients, adding =
or
>> +removing this option should generally be done during a scheduled main=
tenance
>> +window involving a NFS client unmount/remount.
>> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
>> index 68b629fbaaeb..3bab2ad0b21f 100644
>> --- a/fs/nfsd/nfsfh.c
>> +++ b/fs/nfsd/nfsfh.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/exportfs.h>
>>
>>  #include <linux/sunrpc/svcauth_gss.h>
>> +#include <crypto/utils.h>
>>  #include "nfsd.h"
>>  #include "vfs.h"
>>  #include "auth.h"
>> @@ -140,6 +141,57 @@ static inline __be32 check_pseudo_root(struct den=
try *dentry,
>>  	return nfs_ok;
>>  }
>>
>> +/*
>> + * Append an 8-byte MAC to the filehandle hashed from the server's fh=
_key:
>> + */
>> +static int fh_append_mac(struct svc_fh *fhp, struct net *net)
>> +{
>> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>> +	struct knfsd_fh *fh =3D &fhp->fh_handle;
>> +	siphash_key_t *fh_key =3D nn->fh_key;
>> +	__le64 hash;
>> +
>> +	if (!(fhp->fh_export->ex_flags & NFSEXP_SIGN_FH))
>> +		return 0;
>> +
>> +	if (!fh_key) {
>> +		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_key not s=
et.\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize) {
>> +		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size %d w=
ould be greater"
>> +			" than fh_maxsize %d.\n", (int)(fh->fh_size + sizeof(hash)), fhp->=
fh_maxsize);
>> +		return -EINVAL;
>> +	}
>> +
>> +	hash =3D cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size, fh_key));
>> +	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
>> +	fh->fh_size +=3D sizeof(hash);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Verify that the filehandle's MAC was hashed from this filehandle
>> + * given the server's fh_key:
>> + */
>> +static int fh_verify_mac(struct svc_fh *fhp, struct net *net)
>> +{
>> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>> +	struct knfsd_fh *fh =3D &fhp->fh_handle;
>> +	siphash_key_t *fh_key =3D nn->fh_key;
>> +	__le64 hash;
>> +
>> +	if (!fh_key) {
>> +		pr_warn_ratelimited("NFSD: unable to verify signed filehandles, fh_=
key not set.\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	hash =3D cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size - sizeof(hash)=
,  fh_key));
>> +	return crypto_memneq(&fh->fh_raw[fh->fh_size - sizeof(hash)], &hash,=
 sizeof(hash));
>
> Nit: fh_verify_mac() here returns positive-on-error (crypto_memneq
> convention) while fh_append_mac() returns negative-on-error (errno
> convention). Would it be better if both returned bool?

I'd be inclined to change the function names if they both want to return =
a
bool thing, so that the functions assert a fact that can be true or false=
,
rather than explain the operation.

If you want them to both return a bool, then maybe prefix them with
did_{fh_..}?

For me, the semantics make sense as they are..

>> +}
>> +
>>  /*
>>   * Use the given filehandle to look up the corresponding export and
>>   * dentry.  On success, the results are used to set fh_export and
>> @@ -236,13 +288,18 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst=
 *rqstp, struct net *net,
>>  	/*
>>  	 * Look up the dentry using the NFS file handle.
>>  	 */
>> -	error =3D nfserr_badhandle;
>> -
>>  	fileid_type =3D fh->fh_fileid_type;
>>
>> -	if (fileid_type =3D=3D FILEID_ROOT)
>> +	if (fileid_type =3D=3D FILEID_ROOT) {
>>  		dentry =3D dget(exp->ex_path.dentry);
>
> The control flow silently skips MAC verification for FILEID_ROOT
> filehandles. The rationale (export root contains no per-file identity t=
o
> protect) exists nowhere in the code. A maintainer investigating securit=
y
> boundaries must deduce this from branching logic. A comment explaining
> the exemption would be helpful.

Comment - roger.

>> -	else {
>> +	} else {
>> +		if (exp->ex_flags & NFSEXP_SIGN_FH && fh_verify_mac(fhp, net)) {
>> +			trace_nfsd_set_fh_dentry_badmac(rqstp, fhp, -EKEYREJECTED);
>
> -ESTALE might be more consistent with the documentation. Any opinion
> about that?

Sure - after changing the tracepoint name from v4, it still shows where t=
he
problem happened.

>> +			goto out;
>> +		} else {
>> +			data_left -=3D sizeof(u64)/4;
>> +		}
>> +
>
> When NFSEXP_SIGN_FH is not set, the condition short-circuits to
> false and the else branch executes, subtracting 2 from data_left
> even though no MAC was appended to the filehandle.
>
> For a typical FILEID_INO32_GEN filehandle on a non-signed export,
> data_left at this point is 2 (the fileid portion). After the
> subtraction it becomes 0, which is then passed to
> exportfs_decode_fh_raw(). In generic_fh_to_dentry():
>
>     if (fh_len < 2)
>         return NULL;
>
> This returns NULL, and nfsd_set_fh_dentry() treats that as
> nfserr_badhandle/stale. Does the data_left calculation break all non-
> root filehandle lookups on exports without sign_fh?

Oh yeah, I messed this one up bigtime, obvious dumb error - and then of
course only tested with "sign_fh" on the version bump.  Good catch.

> Also, let's replace sizeof(u64)/4 with a symbolic constant to survive
> MAC size changes and better document the computation.

Sure - can just define it above the function..

Thanks for all the feedback and catching my brainos.

Ben

