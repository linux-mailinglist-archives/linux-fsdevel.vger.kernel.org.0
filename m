Return-Path: <linux-fsdevel+bounces-76962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LHREB+4jGnlsQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 18:10:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB24F12679C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 18:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E953E303E3A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 17:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907AF346FCA;
	Wed, 11 Feb 2026 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Jcz+QRN4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023074.outbound.protection.outlook.com [40.107.201.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0681346AFC;
	Wed, 11 Feb 2026 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829797; cv=fail; b=iiMgGJHHhRfVUyHxSbvLXXflhABZD+fBzYsPwtpyt4qLg0gMR7dxiizhPpsUip1GfOJq9Sd6/PYCtEQvkrVV0feqNkh0YwBd7woCp9CGqNrnrMZrvkFkZzCtE84Teq22Bx7sZr/v4m95olMyWcSU8PnnbxpWFWA6YOlBKoWjVDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829797; c=relaxed/simple;
	bh=1UXC57ufGcVJIbAZR8Qdde4TEwfMYabM0s0Mxpg0PG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M6IsN4jWnKhGSY2qHjqy8wd3S43Z11SDx8oviD5RNJVjPGvMqckMKVzzZCJVPYn+Lz4/E56zAjsxELPap83hT/0XltUHqYcCRKukJA3skWTM3CkdTQBBNoxjMYCm5YFxUe2TXyN52/4OtW4H/aOOyjkotKAjJCaOk31lPSUyV5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Jcz+QRN4; arc=fail smtp.client-ip=40.107.201.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwvX2imKcmvekIYiEMd2IJGp5DhJyPkCCRzmbfnPS/nyd0rPam4F7LobQ2ffw1WEFGdi32vYIq8q0fGVFhXScYgysKwDc7aTvYSvp1g3RXIkhrsmhS19eYBJYRbmNAW9JWujlQsn+huVM1D1BYa3b0KmIPlfKEX/C3u/UAl1B8bcfdz4b7ktSMPH6Wd4swjm+/y4TD0hknBrQX6ENyncW9CbjlYTg0zDzxAfUzW0FZ++e60a/D8vfMOdck+FbTvwvsZK4ldHojPRN0y6OD78iinaCwEWdMssHZD5wzQZfY0n1AuwJ6Zpz8dK5lCUoZZ2u7Agx+JqCz4MDibCT8QV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cKRdT/HyNgqTucv5QC6fDSsaRrEcIsIMJkcP7BOeoc=;
 b=qVUNjqxn0LgINjyMvhVc8eUZf9hBXgU3l5vosnGmeTlD3ybBvKcx52V3gpfyglL6QXDHspgivc30ullMb9zaxLkHOvPZHTpSvoLEP5soC1gN7jGzUzPjuLcAojhf3GJRyXbZAfP3Li/NhSqPbbUrqjJNkc0f3Fpig5Yh83YS+KF2wfVb3rKBPXHb+YrWCAFAGeCmuP5VKaWZNKlnKLaIShR8mznxH3qHmzelQgVciP6Do7/RMnHJa/oAGQxQ9MbpOU1NdPoiyXa9hIkUz2J2/SNWUztf5+jdm2QhMeKHb+aELwdkJEN4GVidipH0EI373KFf8jzwn0wT2HtaQ/fmtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cKRdT/HyNgqTucv5QC6fDSsaRrEcIsIMJkcP7BOeoc=;
 b=Jcz+QRN41uCqSNUJa1QCs1Y4MWKJTEbQiyZTo8TKQYtKc2Nthm482K//IMvX1qf9Xge4e0JjPEq8H8B98ZEYNXTDmuPwoCJqX8NGkGxE9jIcR1XSUTudIht4jCiqpZFaJvWK9dlG357ybD1puk4rp1Yb53m1Mk38ceJL0Or29ag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DS0PR13MB6252.namprd13.prod.outlook.com (2603:10b6:8:117::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.15; Wed, 11 Feb 2026 17:09:46 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 17:09:45 +0000
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
Subject: [PATCH v6 3/3] NFSD: Sign filehandles
Date: Wed, 11 Feb 2026 12:09:35 -0500
Message-ID: <cb46e1aee9656be5f3692e239300148813b5c05d.1770828956.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1770828956.git.bcodding@hammerspace.com>
References: <cover.1770828956.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0084.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::7) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DS0PR13MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b9a3c82-b0bc-4dc8-59eb-08de69905aa5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HCeTgrQZfjg3J4Z6N4CyAdoH83hCtkp1nFQp77dIp9qFTSj7Y/a6/2jL+isL?=
 =?us-ascii?Q?xAYAbcP+kUSkhP2tmRQYuRAftih4VCdJMdJiXQDifZblEK8hOC3KqTYbuB4t?=
 =?us-ascii?Q?KVb7Qmn6Y09GsJKc5EDCDgcJG35hNEtk27T70+RwUGUh2xeu2NkB2RGNkvES?=
 =?us-ascii?Q?3Xo8+2ex5mz70hUBr9ijsCf8zUPAkUuyXb4munfbNpLLz9WN6GqBtN5s99y1?=
 =?us-ascii?Q?sTeCwGghE63nCRnYg4+yz2zYrBQXBGFBbAIgx0YRrtcVNBAx8U5KB70PMBwT?=
 =?us-ascii?Q?4TmnT7nd6XLK/MzEB8TjITY8dbDx/e8ZhS3+nkuFivaQXt8WoHwQxJ2CCGZI?=
 =?us-ascii?Q?Yy2reSCs0L6i2Y5SJnHXUaj/CWMj6oOlHRPty++QKQgxf8BDtvRp5Px4GPW7?=
 =?us-ascii?Q?LIaDBwfiGAqQbynKUqEv9dsVSQVyBFNaQVOaKiC1wpWz1nHNetzADK2aH6rF?=
 =?us-ascii?Q?BQEBdisYAeOryxsiVMoRJw30ExKuEtoJCCW8T2SRaseWQNTD9zNfX0AYD/Ac?=
 =?us-ascii?Q?4l2MgTouNcBbvnfKN5rCQHaNhSF9o/kXg8+O6sp/9KI1gPHDy7In8jMvraoH?=
 =?us-ascii?Q?/LXswK/IER1aY1lBXHr7a03GZUP1DtVvZL+hQ/7qH13XMCQQfL35zYjl8+a9?=
 =?us-ascii?Q?1IWB6FeTzH9oacQdY6CjF+60z9JVVagWjWdLI0iV21v9c1B69TwyOgLRx44N?=
 =?us-ascii?Q?AuK5QhP139eeCSoYn2WtHxaWZ8LH+sBEBh9g5J2aNB/EQQsqCwsEdBeASd5i?=
 =?us-ascii?Q?PGlPGlgHTAQmr0oN9tyM4r0ynLFXq4TmNehjuPFE/8w1ScEWDyJX/AqnXkjQ?=
 =?us-ascii?Q?ojOMmi3RNe1bjaO4LASBQr3q9OfOVmWzOhKZrTxnVwkdtQaEbw1CzHNdkbdc?=
 =?us-ascii?Q?xwO9eB0DlnS4m/WLo/P6kUCtVAzyupVVCA27y/FOQ2zIyRbPbhMl5LRcjj/O?=
 =?us-ascii?Q?70DRD5P9T+2XmRcmoX/GDq/bbkjrwNXKmr7HeHgv8qml2mLosi0J1pC3HbJ1?=
 =?us-ascii?Q?INIYd4/zjlcWGbLy4xOB2P+YePZC41sDVfVg7PIftaWOCYocarK3eMNBvCVE?=
 =?us-ascii?Q?5+eeAIxe6O9pHN0dgRkoq1Ld3OH0wyyzlrHAhvVtoP8iDLIJ2z0SfrFa7hp8?=
 =?us-ascii?Q?EEg68h/K+ZTkU0vEXkk0O7QDuVSyMg/ZtFdzu7mx9pTLN0qz4MlMgj4/Lo8u?=
 =?us-ascii?Q?HDlw7EFj5UqFPwNaRnbe41bShd4nVYTYuiVwh53u45vRYRtb1HWBVD5I+bRE?=
 =?us-ascii?Q?1wUIo7E3/MNe7ANAlWbJlMv9Seasy7WLiokBV7pjQkl/CCio/pUlqp3oy5/D?=
 =?us-ascii?Q?S+0HVAclQg79yFyPD+Fi/CbL7nuB37paVpxrO1hl7IPmArKsGV1MLAds/EaO?=
 =?us-ascii?Q?8To3pdclxopuwKPqKtAoQltPxACWT1UToL2HLkvUqv3UsKJXXxJEgCwD9Rl5?=
 =?us-ascii?Q?vxXH7/8RePiZL8Tz9N8BV/TGYXGSmZFboM/9dRv3PcRptMuLK3oNbg/e4TE3?=
 =?us-ascii?Q?COBSaZpdPIyvRj+Sjo5T+w53Df8m8B6/xD97?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ooPvSlKiupM7lIopFFNjVMcCm46TPo366bpGn8c5NojDplDNbk0FTL1diXc?=
 =?us-ascii?Q?7naq4WLAsl77pjRFW4DF0SALK6F8UsAV8iZS+gsFqQmkOyqtBgQNa+JvJe5U?=
 =?us-ascii?Q?KOvL1JBw40WPpByWDlP23iBj3091dTfALCcfmAhNi+LW4T6/HOyQ3cqjiQHH?=
 =?us-ascii?Q?06tc1c6C0TUMYJP+xrdayv7eA9232/5a6duwbPuP+uKG2H2/pok5udybOP/h?=
 =?us-ascii?Q?tPlM+dspvyHh+ZOUp/bpxbPYFguY+/uh0jFXUz9J2aEDKvQ0bwGBtBaI7kbp?=
 =?us-ascii?Q?/qK0bx6LSzpz7PGJRxKKnAlE9UoZ6j8KyMU6DqTlhSae7lylBNOc8ACXdtBr?=
 =?us-ascii?Q?tCcCoC/+rhA2tOiMOLdA6DisbpcDO84xrisqxyCQX/LoiPagjFYUgx8ddzGI?=
 =?us-ascii?Q?vjdSgOkxPbHmK0r/smM+WVlxlck9aCGYJ736c9jlzHkDBF1dlCjf2bqkwsWy?=
 =?us-ascii?Q?Q+GrL0Nv0ksqWmBkMds0kkS70tMB4KTPwcytFKpM+aTyKQ35QEdZptuBf9l+?=
 =?us-ascii?Q?PNxmLet8EKxgAmn05+NMhQMSPwZ1KwvMOf01fpSLxwVdqaet91CYA5wyLWnH?=
 =?us-ascii?Q?7WpgBkFRtGFiQXUe1GwXD8xKjnW/o0cTSKOLyp8zeodA620pdDdA2pugOFHA?=
 =?us-ascii?Q?r3/8KOyArzH8ZsnHWl4BfH0vrhDAoZewq3M0ze+4HbVs+COtB832vRn8IBl5?=
 =?us-ascii?Q?Frh3eDZU96VqE0LcDmbke226/Yw7YvUEW+zrs32vkfituVX9wj06PnwSYMjU?=
 =?us-ascii?Q?Yv3z2QJhZpzmdf7VC87FtZplSV26O+MPJHUrZ2trV8S/CMI4FF0qBNZiYKT3?=
 =?us-ascii?Q?UDmW+uM4DQD+WhL2cufGr6NpATnWiNP1PW451gr0+dByVMwoo4cXtQ8GGUcK?=
 =?us-ascii?Q?CfzkOx2MTXGPHGkG2ipAkYTyh7wSQjKJ1ZPQW1s2rc+4ruMdbWdiOcRPDFws?=
 =?us-ascii?Q?R4Espz6t+u5D410qT2fcGLvQ5qP4DoUpcI3Uz5qD8JhzgIbB8Z84ZlnZRkT5?=
 =?us-ascii?Q?m1H/o5QwQysqXdWH3LDl6tKQ5jgYsaMsKA6JarW+BD30n2CaLbhhspi/90z7?=
 =?us-ascii?Q?klGUMLsmNE/BJRvERT+quJgOXHbvKiRo+wyqV0TFvW/tlzQNDYEH+W36AQ+v?=
 =?us-ascii?Q?s15JU+vqwzRWOiPf/B7RvZ7tjokfl1VW/BKrzIyKccwFrIY9bEf7OcTyuio7?=
 =?us-ascii?Q?DSzp4X1v6hiHx35EGG5SWjibXaa5t/THxgVACRwURAvNim+92BBz4me5XbXZ?=
 =?us-ascii?Q?VwY0RhZ6WFzwsw39fiRcvgzZqiIY8P5hi8nytXibcdXnbCTyvRIPJBCB3w1E?=
 =?us-ascii?Q?L6hulSrGpDyQ3ZB4/DwJCqXjA70mRrOAehnEN0s3qndqp57LA6Z6j4okfiDD?=
 =?us-ascii?Q?wXrZn4Xq8RbJ8+u8S9el05eTyihEKJJ5xkgMnzcg5+H3MpHV4NG8f0xK8GPe?=
 =?us-ascii?Q?QUnf3U9xBY7vYmItvLEn8l3Vkp+3AcfcRxD1NHKvMbQvqrRTRZt/X5i53f+t?=
 =?us-ascii?Q?jtnozQ67imqrrJn093OaHqBvGdtPZ01LrvRrTz+eBNODahXjB0Xh2BurcBiW?=
 =?us-ascii?Q?LCMy9UEmzDlVPabyoHupGgHFhzWnIChpXJIssdoH+8IcvbyKxWKvoJGymTDN?=
 =?us-ascii?Q?wv0YAOdUt99l4+fNDiki5Dxc16sS/MzGGOlKsK10Za1PhF/ETyi2bcHEkMMH?=
 =?us-ascii?Q?LbB8OwHbC+6/jewY1r+fc+e+o+f7KObTa1N+oXa4k5jdBSDTM4k9hiO3gfbn?=
 =?us-ascii?Q?KrSnduxc710VzbQk9ci/kTkmdT0Y0Gk=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9a3c82-b0bc-4dc8-59eb-08de69905aa5
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 17:09:45.2439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdYiF2/b1LD/glmChHoCXYP4jFaq+ddTzi/+hSjfhW73BOwp/oB/VXduJHbLRg5l1xGu3UArMiNCR5o/b5KFA1NuKsjOlBIsBMWihtNaUEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR13MB6252
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76962-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:email,yp.to:url]
X-Rspamd-Queue-Id: AB24F12679C
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
 Documentation/filesystems/nfs/exporting.rst | 85 +++++++++++++++++++++
 fs/nfsd/nfsfh.c                             | 70 ++++++++++++++++-
 fs/nfsd/trace.h                             |  1 +
 3 files changed, 152 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index de64d2d002a2..54343f4cc4fd 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -238,3 +238,88 @@ following flags are defined:
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
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 68b629fbaaeb..3bab2ad0b21f 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -11,6 +11,7 @@
 #include <linux/exportfs.h>
 
 #include <linux/sunrpc/svcauth_gss.h>
+#include <crypto/utils.h>
 #include "nfsd.h"
 #include "vfs.h"
 #include "auth.h"
@@ -140,6 +141,57 @@ static inline __be32 check_pseudo_root(struct dentry *dentry,
 	return nfs_ok;
 }
 
+/*
+ * Append an 8-byte MAC to the filehandle hashed from the server's fh_key:
+ */
+static int fh_append_mac(struct svc_fh *fhp, struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct knfsd_fh *fh = &fhp->fh_handle;
+	siphash_key_t *fh_key = nn->fh_key;
+	__le64 hash;
+
+	if (!(fhp->fh_export->ex_flags & NFSEXP_SIGN_FH))
+		return 0;
+
+	if (!fh_key) {
+		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_key not set.\n");
+		return -EINVAL;
+	}
+
+	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize) {
+		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size %d would be greater"
+			" than fh_maxsize %d.\n", (int)(fh->fh_size + sizeof(hash)), fhp->fh_maxsize);
+		return -EINVAL;
+	}
+
+	hash = cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size, fh_key));
+	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
+	fh->fh_size += sizeof(hash);
+
+	return 0;
+}
+
+/*
+ * Verify that the filehandle's MAC was hashed from this filehandle
+ * given the server's fh_key:
+ */
+static int fh_verify_mac(struct svc_fh *fhp, struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct knfsd_fh *fh = &fhp->fh_handle;
+	siphash_key_t *fh_key = nn->fh_key;
+	__le64 hash;
+
+	if (!fh_key) {
+		pr_warn_ratelimited("NFSD: unable to verify signed filehandles, fh_key not set.\n");
+		return -EINVAL;
+	}
+
+	hash = cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size - sizeof(hash),  fh_key));
+	return crypto_memneq(&fh->fh_raw[fh->fh_size - sizeof(hash)], &hash, sizeof(hash));
+}
+
 /*
  * Use the given filehandle to look up the corresponding export and
  * dentry.  On success, the results are used to set fh_export and
@@ -236,13 +288,18 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 	/*
 	 * Look up the dentry using the NFS file handle.
 	 */
-	error = nfserr_badhandle;
-
 	fileid_type = fh->fh_fileid_type;
 
-	if (fileid_type == FILEID_ROOT)
+	if (fileid_type == FILEID_ROOT) {
 		dentry = dget(exp->ex_path.dentry);
-	else {
+	} else {
+		if (exp->ex_flags & NFSEXP_SIGN_FH && fh_verify_mac(fhp, net)) {
+			trace_nfsd_set_fh_dentry_badmac(rqstp, fhp, -EKEYREJECTED);
+			goto out;
+		} else {
+			data_left -= sizeof(u64)/4;
+		}
+
 		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
 						data_left, fileid_type, 0,
 						nfsd_acceptable, exp);
@@ -258,6 +315,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 			}
 		}
 	}
+
+	error = nfserr_badhandle;
 	if (dentry == NULL)
 		goto out;
 	if (IS_ERR(dentry)) {
@@ -498,6 +557,9 @@ static void _fh_update(struct svc_fh *fhp, struct svc_export *exp,
 		fhp->fh_handle.fh_fileid_type =
 			fileid_type > 0 ? fileid_type : FILEID_INVALID;
 		fhp->fh_handle.fh_size += maxsize * 4;
+
+		if (fh_append_mac(fhp, exp->cd->net))
+			fhp->fh_handle.fh_fileid_type = FILEID_INVALID;
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
2.50.1


