Return-Path: <linux-fsdevel+bounces-74922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC0rIqg6cWnKfQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:44:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E91B55D82F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6103AB297C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E75E3EF0CD;
	Wed, 21 Jan 2026 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="VZidjWNb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023128.outbound.protection.outlook.com [40.93.196.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11319344024;
	Wed, 21 Jan 2026 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769027069; cv=fail; b=ZZr1hMqGys+4Xu3CiJiOsHnKrjxDkdu/1Cm9jDEexm1W9Q35q27s/0tOCtzchev2g/QtuQR/XpgJhY/Y/5ow3fESeT7dBcru9iW9NWp9z1nfrETnGvHnemmZg+C+A8wR6e4+oxJn+fYXxNrvKCC1O9mQADDl8zJRnJz++BUDJjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769027069; c=relaxed/simple;
	bh=1pfHi96fEpuho3+dy+BMcUOI9YuRYt4PNOF5+Zx0ndg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OCCorWLml2NRK0B5P4wIVmSUYQgmF3Xs3aXgHeeoWMLfOI6T/J3vR2pr1ZEUHEo0lhrkY5g9iwxZ/j/voZRAfupcgHBM1NSpco9foHDR9WiX3moW84OkTwmLIXnR4DG/0LKR1z8j3f4R7IO6nUJGd/Y2OMAy62/zT7Tq+ErMdcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=VZidjWNb; arc=fail smtp.client-ip=40.93.196.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5ar09m0bB9s0xHzulCVhMx4bpvNeF/3H4tqBdUG8CY1iHN65abfvtsEr6VA7CSJjFr0RDOz47vB6AHpUqXwm9HHZS06ut2jybnBVBkaShjfhNHUewsB7vA/EEKM8miDm7tH0phsrvHmfU0OcJJqef4XpShjytBLIahTM+Zu5unea75Ezxt3LtiOWSOxsTMoaoDhQUGYUOfF37MhWURdGAMI19GC7qawmgV6FB1y4+U8fAPn3WPOyg2wwcDarCKp5OLs8v3UkOSy2dXcdKfwVJJhoQmhEvyfd8Fqmrfj8NyBQ3ladgMblZPlzYEI4clEO//cXYNwFCuLNPg52HbXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hyb20wXkr2YPxIbfFgl7/CNH69+8kzziZDpQdZYGtms=;
 b=sV6CTC4Dc0iOtUUVktRxUdSyr5RyCmvkN7mXSor+Rh7coRAQP2s45yRWaKv1cnT9oy5WhelDkHN2s3HZDpz24X5wGO/2t8uSqLqMu/w0J1YeJWMXz5DeodF1afvxTvyDtopVu4Y2UrifvZlqzjNfPqXEQdA6TYfRKWoeF2gJ994pSYe4+674AaDxVaRg0Wh0RYZI1pKVYG6MvlvEnGka9TzeEinUV8tl7dLjFd6MoowBlSk0sPGk5yHv4/GcU7pN3v5tJ/75YMogNl/PIgzEHU7skHZx6ou9pU8jPG0EqEIlr39NNCM1wYpPvuI0dlnw9BlNeaf1YTE+SZ8YHbe3pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hyb20wXkr2YPxIbfFgl7/CNH69+8kzziZDpQdZYGtms=;
 b=VZidjWNbQi+5vNxfgUs+sTIm/LZUx5MUeGPTjA3St7q9OEqDO3J8VDPMgOzuKNDHiR0cfQZn/pvr0h+MRqzLwSUuHMuAsGH3nEfG3ttEUZm0blEpBtYoF9dhGCFw8yiIv39Ptm/Z2l49lwm1yEJPrEhAvBVsYXeOzhnLPsn/XI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 BL0PR13MB4514.namprd13.prod.outlook.com (2603:10b6:208:1c3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.10; Wed, 21 Jan 2026 20:24:24 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 20:24:24 +0000
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
Subject: [PATCH v2 1/3] NFSD: Add a key for signing filehandles
Date: Wed, 21 Jan 2026 15:24:16 -0500
Message-ID: <6d7bfccbaf082194ea257749041c19c2c2385cce.1769026777.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1769026777.git.bcodding@hammerspace.com>
References: <cover.1769026777.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF00013317.namprd07.prod.outlook.com
 (2603:10b6:518:1::7) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|BL0PR13MB4514:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce1ca3a-36f1-4576-f094-08de592b1146
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lI2Wpc2eI3sYljGFQ5SlRJBIZmV+USgAmTxFxVKlgMIYy01pwiZKGSL0bcQK?=
 =?us-ascii?Q?o/j179J/HYYHd9N3qXAxGgJ2+nhe6an39dbeT2Q52gi2TSt4Gab2jhZdy7XG?=
 =?us-ascii?Q?3lS5IaEynR+TSV9KuN9B2JKpckvLCteh/vrV/C9eR0lW5Ukixj4PV37ix8/7?=
 =?us-ascii?Q?6fBKQr3uIlOVX80kaJmqtT6aP0k2XQug57ptkBM8CjztDCpyU8Apl5y1ze3O?=
 =?us-ascii?Q?l0LPR32RCTjnmFO59ECjV/wS2On2fk/swjCi1g7s6jq+Nxrmkt2cFHtTGXHy?=
 =?us-ascii?Q?RYUeWmfIoSwcCiDkk99DmElUZpZc9i+b6H4DK37JsBw9aIh5qUySMzHwB5oH?=
 =?us-ascii?Q?AZS7TsiQCJdqTFNfTcV89QzODs+KCxH1DmmHG6dCWPyrOHCP6kKUZgvtVP98?=
 =?us-ascii?Q?12bJ2FF+lUnklEuVIBgVyybOY+eIEd8s9O/65YJR0qhHBpJ7V0Hiwh2qnszm?=
 =?us-ascii?Q?NYtI2slG245v1zoR8dJ6jFf2JtouiLDQq++1fgTpSaRvlS6XNBycZoiUAKme?=
 =?us-ascii?Q?/WGnyW44g3gWN982c7Q3UK68yAOPYWXHPOqigv3+UNfSI4AQdvpipzCzFykQ?=
 =?us-ascii?Q?MBCeI6XVdsa2QrJihsn13jYqh2ZCP0UrxYDV2gueE/GiKjpf/1DR2W7fpZbS?=
 =?us-ascii?Q?3Jya360MhmwY2JhXoe6ktPaWXf14QlPXO0JGtNEFrF8UmZhQp5HFdtDHV+gX?=
 =?us-ascii?Q?Bt4sT7kLtFJpM0rj7ZbDVzJjKe6V1qlUNCdlNzl8Z21xy2e7wl7KDf8omYSt?=
 =?us-ascii?Q?Hk7PKyssIsugL2ST3R/qPgZIEq0BdOpuu078jYAqnIuNW0qVserI8s0RMxPL?=
 =?us-ascii?Q?OxKb8n6Zny1Czawhg22lmDVSUGx6W4pg43F7CiXCSJVT9/QjPaLZLbPzxGRs?=
 =?us-ascii?Q?Vz1tNpexpJWfw1LG6QLhftKErlCz2ziNoTZz9h97DtDlAtrCRO8Oo1Q2QZ7r?=
 =?us-ascii?Q?ZS03Sow7ae34wn1+NGQnwwR8ubME12QViQDbEXMOhWcyz0PAN/nXKeZ7qWe4?=
 =?us-ascii?Q?xHWv1E/jwu5Sd8vDO5n5b3ElePSAxDMqloa3ZDcKz65silmdGh4p/0603jAK?=
 =?us-ascii?Q?82DVeJCsLXkWz9DQD7l5XmkSBBRHFW+fZE1JL0Pxq6RzL7dgR3FoivrIfxrL?=
 =?us-ascii?Q?IfObREKwwmp9DAdh6GTHTq+OC4eONPTqyeLTcwivwkJwaXYxP+71rVcYRqcG?=
 =?us-ascii?Q?pUye8D41xSJgEPmXit6mz2GwPQtFSbgxgIM04Yo1pZFjtl30awHGDusJA5xQ?=
 =?us-ascii?Q?9AI7x9Jhdfdga3AVu/yk7N7LXUr6UupHcbDBh61NPtm3QcWOfUrBQE4JaFb9?=
 =?us-ascii?Q?oDLw3sfW0Ca65Kp4mhL0hay+UahgHZ7DjZwKvVxbGYjupc7IfSmmVr91gqCu?=
 =?us-ascii?Q?JroVxWM6S2+e+pAIb9q6gqqLDqZJ9KftzeI88p/9AriJm7LknrFulkhOHZpy?=
 =?us-ascii?Q?XjjmEbCtfub1ViUGXhztirsw0/36kRrux7IC+IJpme+Rp91VF0NrXU++hOeG?=
 =?us-ascii?Q?d3U5irqEY5gX5ANOhWQGCodyYpcPswONkNTDPdRQerPy0XfdghFgB0HAL/hw?=
 =?us-ascii?Q?M1muLKqrXNKijMF9yJQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1f+pSytc9HUi7iVfKqPMkvtuce57lpdnp0jMkls0yI9PNv6iYkEILxINH9IV?=
 =?us-ascii?Q?yfzrm3o6+uYWajF7n918AFmcRkXDpg1+nuWo9CkwW4j1ktcQMWsDB2x+Lyhk?=
 =?us-ascii?Q?CcObDms+V/JeFtPbxCUvub/Ee7VTl3uJHDmCKTw5szgesVlifAMqvGc9tKmE?=
 =?us-ascii?Q?/sU+TurBYgA1Z2gJJE9QpRgm0wDGn6hjUpgKYG/FKR4EjFGtmS7dLdFU0P96?=
 =?us-ascii?Q?Kwcu+p7mt7rkOcBYZCL2DhbeNTWbJRgJP6P+JOiqyriploAbz5lv+cJ7mJiW?=
 =?us-ascii?Q?JoDnzY3AS4ovEDMYNRBxCs/v9AmO+qsl+lnQckJTywJkkHIvA8JUtxy/PuBN?=
 =?us-ascii?Q?m9+wE8qVn1chOG4MHTmrFOeyhQx6U5A2GSN1AOzKXZI3ObmkY8Q9Zq40DuOB?=
 =?us-ascii?Q?GevP2udlRj/fj2ypYIuJ0EVRI99GixtWA5y6IlxlGgje8AcAhtizBGyzx1tA?=
 =?us-ascii?Q?FB9OgV9aOKptI3GKuiCDw7W7BsaosM8zC6rDUcbmCd1O2HJjQUehauB4n7Tt?=
 =?us-ascii?Q?zkLoMsAe3cnnP3yXDyyMIlp97ibc09m5cax4b6i81xk2vK9xKdW7xtQQzXmh?=
 =?us-ascii?Q?MjG8SMMv+ne3m+kYwTQkShDn6XI+/P+RbrCsInPg/7HXHJs2MADexCZNf7Xn?=
 =?us-ascii?Q?4wLvKxt7siuP7LdBw9rIWjdGMxFLg/ws8RxEv5V4x5fBMfx4GLYUYCUjOQql?=
 =?us-ascii?Q?ZCEEcDrwMh/bRmj5boEJQ7NS5fq3AKvK5kVpb6nwxbjQ52tON3rnxBQGfYpB?=
 =?us-ascii?Q?bBjHA7OaeWQJhe/87jEQN/PzaUsMjPR6nxHEwXOQszYXZRAIMKA7T2rnhBgS?=
 =?us-ascii?Q?cKbsoZ3vWnBujTTgGxXVdBW9ZN/m4InYFiYb2Pr5Sfw/g1dUrZld3+Jdb5Tz?=
 =?us-ascii?Q?Bdme41c2yav182RyVaixmUNGptT1if9hvZZYvQCAOhmeCKDqFbT34dUpG/93?=
 =?us-ascii?Q?yaiK4qbJDvzt8H+y6ES2ZABeR/HzCmTkm1Bs742GwN3/T7oGcMIt8kjejx00?=
 =?us-ascii?Q?qbA4NyFq6Ej9hINjxfosLjOqs6nVNV+NKTJwdruAb3h3ERadcGi65DGzq+sX?=
 =?us-ascii?Q?XPQnLFxp9UtTm69cKX/e0LI+6idvw8VHGZcgI++IdMsphk2Q71k6xmaaoYAs?=
 =?us-ascii?Q?CmQIsm7+PSnhvBbZCmJNXS567xupSLUDr7gLA9FBDnj+UGBZyxTlh7o+5LUJ?=
 =?us-ascii?Q?cY3nchhrlenKDCg8uwBnGKQ9pRM6lWbROMkDYeekKxpycCb05YimwJS2PZME?=
 =?us-ascii?Q?JJe2Wc2XnkkjR1YvVU2sIR7nd8gEB+C0mBuP0U4wCq9J2Y6ZLtInAAm/Mt9P?=
 =?us-ascii?Q?ssZYOjHRdVIxaVC3rdbO9GRmxUnBPMGiK1HXvKcR/fjM0aQ4zgpTu38ktEt4?=
 =?us-ascii?Q?9VOQYhCnAfZ3MJzoh830gtEiRQpXlEjmg6DPjYJotsIiY9KQfv39umBC81rj?=
 =?us-ascii?Q?SC0oGHzWKj+7mmvlkD+LfyeUBIO11d1U7tBH244mrRpmfbVL9gFKBkXPVZcp?=
 =?us-ascii?Q?mKIc04sQl2RKl0rq6i32fH6gIc5W0A+qzgsSTufnxZRBq2Bh47BHva+NjD6i?=
 =?us-ascii?Q?3/BDRH1XGEYZn/eUHAWXuzd8cboiPbB//BIb04sW6UtzEvFs9WTC7td17jx1?=
 =?us-ascii?Q?chZIDfNJcnV4svAfxdO+Lwz9cVRzOsM4CaqyqC7X0N62ZW8VByEFfc+l5b6F?=
 =?us-ascii?Q?YP8swQBRYhHavq9aeqJLE25R3csNCvhrq2Ep+0ahymsBQL8VCHY28CEoFZw0?=
 =?us-ascii?Q?AA8OQIFKzII+N5qH/PSbmfzAEiGoopQ=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce1ca3a-36f1-4576-f094-08de592b1146
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 20:24:24.4097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKKo9mBBT66JyPzyPdJUjAqiEns4QyEl6NnqQ1J2Qv4ccom0r+JOFR91KFTcRLITDbokIZzHJeh26uarJkQcO3utsfgrnqSAoVZ8RpTGH/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4514
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74922-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	DMARC_POLICY_ALLOW(0.00)[hammerspace.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid]
X-Rspamd-Queue-Id: E91B55D82F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A future patch will enable NFSD to sign filehandles by appending a Message
Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit key
that can persist across reboots.  A persisted key allows the server to
accept filehandles after a restart.  Enable NFSD to be configured with this
key via both the netlink and nfsd filesystem interfaces.

Since key changes will break existing filehandles, the key can only be set
once.  After it has been set any attempts to set it will return -EEXIST.

Link: https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hammerspace.com
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 Documentation/netlink/specs/nfsd.yaml |  6 ++
 fs/nfsd/netlink.c                     |  5 +-
 fs/nfsd/netns.h                       |  2 +
 fs/nfsd/nfsctl.c                      | 94 +++++++++++++++++++++++++++
 fs/nfsd/trace.h                       | 25 +++++++
 include/uapi/linux/nfsd_netlink.h     |  1 +
 6 files changed, 131 insertions(+), 2 deletions(-)

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
index 887525964451..81c943345d13 100644
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
+		.maxattr	= NFSD_A_SERVER_FH_KEY,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 9fa600602658..c8ed733240a0 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -16,6 +16,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/siphash.h>
 #include <linux/sunrpc/stats.h>
+#include <linux/siphash.h>
 
 /* Hash tables for nfs4_clientid state */
 #define CLIENT_HASH_BITS                 4
@@ -224,6 +225,7 @@ struct nfsd_net {
 	spinlock_t              local_clients_lock;
 	struct list_head	local_clients;
 #endif
+	siphash_key_t		*fh_key;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 30caefb2522f..e59639efcf5c 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -49,6 +49,7 @@ enum {
 	NFSD_Ports,
 	NFSD_MaxBlkSize,
 	NFSD_MinThreads,
+	NFSD_Fh_Key,
 	NFSD_Filecache,
 	NFSD_Leasetime,
 	NFSD_Gracetime,
@@ -69,6 +70,7 @@ static ssize_t write_versions(struct file *file, char *buf, size_t size);
 static ssize_t write_ports(struct file *file, char *buf, size_t size);
 static ssize_t write_maxblksize(struct file *file, char *buf, size_t size);
 static ssize_t write_minthreads(struct file *file, char *buf, size_t size);
+static ssize_t write_fh_key(struct file *file, char *buf, size_t size);
 #ifdef CONFIG_NFSD_V4
 static ssize_t write_leasetime(struct file *file, char *buf, size_t size);
 static ssize_t write_gracetime(struct file *file, char *buf, size_t size);
@@ -88,6 +90,7 @@ static ssize_t (*const write_op[])(struct file *, char *, size_t) = {
 	[NFSD_Ports] = write_ports,
 	[NFSD_MaxBlkSize] = write_maxblksize,
 	[NFSD_MinThreads] = write_minthreads,
+	[NFSD_Fh_Key] = write_fh_key,
 #ifdef CONFIG_NFSD_V4
 	[NFSD_Leasetime] = write_leasetime,
 	[NFSD_Gracetime] = write_gracetime,
@@ -950,6 +953,60 @@ static ssize_t write_minthreads(struct file *file, char *buf, size_t size)
 	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", minthreads);
 }
 
+/*
+ * write_fh_key - Set or report the current NFS filehandle key, the key
+ * 		can only be set once, else -EEXIST because changing the key
+ * 		will break existing filehandles.
+ *
+ * Input:
+ *			buf:		ignored
+ *			size:		zero
+ * OR
+ *
+ * Input:
+ *			buf:		C string containing a parseable UUID
+ *			size:		non-zero length of C string in @buf
+ * Output:
+ *	On success:	passed-in buffer filled with '\n'-terminated C string
+ *			containing the standard UUID format of the server's fh_key
+ *			return code is the size in bytes of the string
+ *	On error:	return code is zero or a negative errno value
+ */
+static ssize_t write_fh_key(struct file *file, char *buf, size_t size)
+{
+	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
+	int ret = -EEXIST;
+
+	if (size > 35 && size < 38) {
+		siphash_key_t *sip_fh_key;
+		uuid_t uuid_fh_key;
+
+		mutex_lock(&nfsd_mutex);
+
+		/* Is the key already set? */
+		if (nn->fh_key)
+			goto out;
+
+		ret = uuid_parse(buf, &uuid_fh_key);
+		if (ret)
+			goto out;
+
+		sip_fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
+		if (!sip_fh_key) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		memcpy(sip_fh_key, &uuid_fh_key, sizeof(siphash_key_t));
+		nn->fh_key = sip_fh_key;
+	}
+	ret = scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%pUb\n", nn->fh_key);
+out:
+	mutex_unlock(&nfsd_mutex);
+	trace_nfsd_ctl_fh_key_set((const char *)nn->fh_key, ret);
+	return ret;
+}
+
 #ifdef CONFIG_NFSD_V4
 static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t size,
 				  time64_t *time, struct nfsd_net *nn)
@@ -1343,6 +1400,7 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
 		[NFSD_Ports] = {"portlist", &transaction_ops, S_IWUSR|S_IRUGO},
 		[NFSD_MaxBlkSize] = {"max_block_size", &transaction_ops, S_IWUSR|S_IRUGO},
 		[NFSD_MinThreads] = {"min_threads", &transaction_ops, S_IWUSR|S_IRUGO},
+		[NFSD_Fh_Key] = {"fh_key", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_Filecache] = {"filecache", &nfsd_file_cache_stats_fops, S_IRUGO},
 #ifdef CONFIG_NFSD_V4
 		[NFSD_Leasetime] = {"nfsv4leasetime", &transaction_ops, S_IWUSR|S_IRUSR},
@@ -1615,6 +1673,33 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 	return ret;
 }
 
+/**
+ * nfsd_nl_fh_key_set - helper to copy fh_key from userspace
+ * @attr: nlattr NFSD_A_SERVER_FH_KEY
+ * @nn: nfsd_net
+ *
+ * Callers should hold nfsd_mutex, returns 0 on success or negative errno.
+ */
+static int nfsd_nl_fh_key_set(const struct nlattr *attr, struct nfsd_net *nn)
+{
+	siphash_key_t *fh_key;
+
+	if (nla_len(attr) != sizeof(siphash_key_t))
+		return -EINVAL;
+
+	/* Is the key already set? */
+	if (nn->fh_key)
+		return -EEXIST;
+
+	fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
+	if (!fh_key)
+		return -ENOMEM;
+
+	memcpy(fh_key, nla_data(attr), sizeof(siphash_key_t));
+	nn->fh_key = fh_key;
+	return 0;
+}
+
 /**
  * nfsd_nl_threads_set_doit - set the number of running threads
  * @skb: reply buffer
@@ -1691,6 +1776,14 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (attr)
 		nn->min_threads = nla_get_u32(attr);
 
+	attr = info->attrs[NFSD_A_SERVER_FH_KEY];
+	if (attr) {
+		ret = nfsd_nl_fh_key_set(attr, nn);
+		trace_nfsd_ctl_fh_key_set((const char *)nn->fh_key, ret);
+		if (ret && ret != -EEXIST)
+			goto out_unlock;
+	}
+
 	ret = nfsd_svc(nrpools, nthreads, net, get_current_cred(), scope);
 	if (ret > 0)
 		ret = 0;
@@ -2284,6 +2377,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	kfree_sensitive(nn->fh_key);
 	nfsd_proc_stat_shutdown(net);
 	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 	nfsd_idmap_shutdown(net);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d1d0b0dd0545..c1a5f2fa44ab 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2240,6 +2240,31 @@ TRACE_EVENT(nfsd_end_grace,
 	)
 );
 
+TRACE_EVENT(nfsd_ctl_fh_key_set,
+	TP_PROTO(
+		const char *key,
+		int result
+	),
+	TP_ARGS(key, result),
+	TP_STRUCT__entry(
+		__array(unsigned char, key, 16)
+		__field(unsigned long, result)
+		__field(bool, key_set)
+	),
+	TP_fast_assign(
+		__entry->key_set = true;
+		if (!key)
+			__entry->key_set = false;
+		else
+			memcpy(__entry->key, key, 16);
+		__entry->result = result;
+	),
+	TP_printk("key=%s result=%ld",
+		__entry->key_set ? __print_hex_str(__entry->key, 16) : "(null)",
+		__entry->result
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
2.50.1


