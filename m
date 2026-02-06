Return-Path: <linux-fsdevel+bounces-76591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO52EXcEhmmyJAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 16:10:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA6AFF842
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 16:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2B653030D28
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 15:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E442848BA;
	Fri,  6 Feb 2026 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="dA051CQo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020137.outbound.protection.outlook.com [52.101.56.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC827CB02;
	Fri,  6 Feb 2026 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390579; cv=fail; b=UKvFtn3wdeYohaENwprw9S9f71TKzydYo0BL+YulHqHAN/4feVHCNPsoZFENr3lZaRzGCsUxOK4EGQfus/0N/z36saFZZFEhbg0N7nesqiS52Hty4eQZugnWJOV2uEzoHld9tX8GxRPoww8J6AUnDbKdzm1yjZArHI9YHYON9hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390579; c=relaxed/simple;
	bh=C/wiGIBDk0eIIHCmBbAWgzlQ2tcw6HvpZI8noXiBk4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FBkeRb6A74puET840NrdLD6arlLpxSgPK6KdAf9wUJUJE4S+E/p3ERKxAcRJ+IUWgd25ups2l1atXvcDRsRikr892Y0XpnOc3JoRj1y7sawB4enuygEtgL4X7xRndywnfkpGMcEFXbGpn4bNA8W6uehY26q4YYx5n/Kq6oxTOpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=dA051CQo; arc=fail smtp.client-ip=52.101.56.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x19GhujRQMGPPpqEdTg9gyW3gey+2cei/X69qdeuzLVv5wHvqiWpmb6kxPHSimOihSEF6pxWg5Z4QwSoORlSbjmGLBv5m2WmpitHoW0LHaOANPxGrbX06cghwcULo4XBqXzbVxFOpZBrhgiBuLHOmGeArkPnAtGPRCvLy+iKeuOcQiiP2e/urfIjmdrwmE3OLMfubj2MeJSmRRFwz0gXbuD1YyDJDmbHPa2KIc9IUcsoJd+33xI0cbcKqqisyKMgfrbTnV4FhqnmwJ4lVKnLA6GmS4J1AYNAf63F2z72JUL5rxvH99ff2+JJ5LkEuvDYqmywdwm7dSg4ClTBRPNupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3oklWTIjDW4dUPm4a0aHci7JFgkN8RoPYeygE6LYyE=;
 b=g7BN+DkrXTWTiRVy9ymIxawIHU5bkJr5eXbDeNbEjj9nOTuktMf8xFqeoU83eYbpBfZp/pBUbblCm+VVAM2HrUr66pXOuDbXZSdhDQfboqTidCeO0R3sPsA4/suBNTXJBrjfkUeIE8alxK3DaVcZd+app2fWLyLLWxV23mK7uq+Snrkj7jiY1mE34cHVgyR75EAHs3ByI2YmX3HeQFIy6iqZKPT2HfIWVEWhYgyayaViVcLqyq1o4hPNTaYGGkyWVgSsTCYjmjWjDrNFpmXXiSUIgnXtp5uEuEZq+4AXP04+siBwSrlBlxoSja5XsZ7FNUJD6tqclSmhYAhNXEn4/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3oklWTIjDW4dUPm4a0aHci7JFgkN8RoPYeygE6LYyE=;
 b=dA051CQoBWUj8RrvqL5U+0wp1EJq+a8U2ORKDPvEK4sSCr0CQiJdGNdz2xb2eyWcNQe5WkSbkkxBeweKtKz0w9E5LvFaZnxv/9sHJvt+0O8fAQ22UC5FWcuxmP/9cVJ+hAIzsbscMBq6v7xSWL/hLiblkisbNhh1iN9JDMnczqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 PH0PR13MB6154.namprd13.prod.outlook.com (2603:10b6:510:293::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 15:09:33 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9564.016; Fri, 6 Feb 2026
 15:09:32 +0000
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
Subject: [PATCH v4 1/3] NFSD: Add a key for signing filehandles
Date: Fri,  6 Feb 2026 10:09:23 -0500
Message-ID: <09698b80d78c7c0a8709967f0f3cf103b3ddad9d.1770390036.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1770390036.git.bcodding@hammerspace.com>
References: <cover.1770390036.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::19) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|PH0PR13MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 409346f6-0e99-4a71-2e23-08de6591bb55
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?1cRnWMNvcv6bDiPlr3rx9dg5DtDS6zmdwQNOJ21PWMy9WZ0YaI/wEge90Ygd?=
 =?us-ascii?Q?+vmbHinOy/4rmOguYULcWIq1P+M6HAeQJnia7Vop73KPp/dKsg1gPQ6ierZA?=
 =?us-ascii?Q?Uyis1WS4ghsZfMK1EwHFeFruzJXMjReMlW+ue/ty0tMJjZUQ0oCfU2U3a2E1?=
 =?us-ascii?Q?9Q8PqgSZuXF7fy+/auLnx2CgNiR7bBZcB0sSAsyPLbnrg4hRC7dwCvNrlFKm?=
 =?us-ascii?Q?/bLkS82NprweyYkvzCaREJT92DlARhdECxcbxkrN9rHmSROe4LgkvFUEKEgF?=
 =?us-ascii?Q?tOK6QIECgEdOka7ZtQQkJMb1w3tD9HMHS8ieWgr/7i4ROPhmLtt+gzboBpeN?=
 =?us-ascii?Q?Z0N4whDZ9JwyIn9CsKvUxiNCgGcwelwQ6rtoQ0+qcpI5L0DhL6EqvDuAwJ6e?=
 =?us-ascii?Q?olT/h1Jc9n+qYwJeYi+0pCSw2lhzeA+64XdDnqcA8hbwWwIqr57+POQiewZ0?=
 =?us-ascii?Q?uAZg2U6pMAJpG2X6Dle4X7O+GpJ2btabcaG0IKyzAr3utdNNJv9XCBkUIlkD?=
 =?us-ascii?Q?cy2mh55J68EgO4DkvynYnEvSseelpbiZTfJxFEnq50anm/H8YtQnx3M2P0zC?=
 =?us-ascii?Q?fxVR6sL+SveVQWNFVEnkwrhdAarL+VH7LxKPqiamZcQfsouceEBmV0fgvi29?=
 =?us-ascii?Q?0DMyTPlfm+fw68zlV8wKIw3yeiHW6SanjpLuSIcl41Uzd9jO3a0SNgdwCCRT?=
 =?us-ascii?Q?Dwb98olrlF2vt3BxEQgyZzu9usR9L7rzVcneeg6i1/UtCWe63FGDlpaYzzlN?=
 =?us-ascii?Q?ya04fNvFGCs+9EmqEjQSCk7dSnae9WcM+HcCVeF4x6f/8kF1sxoxF0Zae7+k?=
 =?us-ascii?Q?w/Z24zWCfsOfqqIHVxOGaeeES3GbtQrLgcDLj1tE2NB3Z46RtmQlYp8OzT+b?=
 =?us-ascii?Q?rkFBPQqQPIpsem07ytYr6qWieSHoF7odnjoCXwQhZu7b3al0XtB1l/GqDnvB?=
 =?us-ascii?Q?ZGAN/NGMgCUMsoquPPLbAxYo8tqp7NyAENKrFjrB89ZZ01v7YCGy4ezRTqfl?=
 =?us-ascii?Q?e0P+NSwpJeAeV0BOUEqBGIk7ow1BTS3ddh1IEig4wH5eHY542GZzRJqiYH86?=
 =?us-ascii?Q?Yxy0vxD8Mke4xka57Eh4R/KNxBB+RPBoQccYOiogYooDzNc3HjP9WKDUu/CH?=
 =?us-ascii?Q?33a1ZZBiVdTFIkEZeRuqCuWCxQH4SUIxCW53M/MNGAO5LrjAOG3pVfsxrcXK?=
 =?us-ascii?Q?xX2146FjDIDJEumwOzcH6O3uCt6rtpn1LLD/EeRi21p382893U5TPZOp588Y?=
 =?us-ascii?Q?RYHuEfK3Hbo0s7/ItNkCYCqOqM74zKOapG/i8Nc0Stn+fs4OyEI710TqFmUW?=
 =?us-ascii?Q?N3+odCEfVN70DU6k2mRoWB7nUlQp4mm0qc/7T6uiyeYWQVDZcuxMtsjmacqB?=
 =?us-ascii?Q?dWtd4SfZ8ubk7LE1OPSfD0y4IucD2Mg6L2qhGXVA0cKYBXnHIIumSofU9kqu?=
 =?us-ascii?Q?aWw3VcC3VTyn7UQZNblKiMxaAnTJqg6KiX1JSsqjzqhXZwtHX7iwWEt7xDuZ?=
 =?us-ascii?Q?7QctDolC2wYfr20ip5/J97dU7Rb+HPsCcIu3tZgH4UTvqBMX8MmCJFUyCusm?=
 =?us-ascii?Q?QsPM2m2QrS5EXxIsUns=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?uFYflT6/MgdPepNr6wacpKVCksaQsyNp8JTLD6MoFrtPwf2m1c5kfsYfP/QJ?=
 =?us-ascii?Q?bbLVQRPRRehlmjnKZoJEw1b9z0sqFJlQf88za3eXEfxCTIDFjlInBI0fVZbE?=
 =?us-ascii?Q?mQFTnwKr/Kit7q+BR05UA9FYz7HvwHG/S1JoFVDcf7gOY+csIxPk1KjngVjm?=
 =?us-ascii?Q?LptcPeEuVFr4OYOJ4McqM9REhLbPlsqNKOIQ+ju7K4NREyiRG82kgwGzOIvz?=
 =?us-ascii?Q?RE08yAPh0Ri/IZgWQbMlyKqJtCszLsUL4ntF66oh942J86IaEoc5GL+sq/dk?=
 =?us-ascii?Q?yxmQAyFu35MlNlcegwH/SkiYatAZ9sx/JiNw8mXIW5ThLIFLT76hheWLZy2T?=
 =?us-ascii?Q?DYMPAVc1Oaq3OYKT5bTbKGVIB20CLtS6YrwiOiHVY46okqcDPv7LzWr/sCkQ?=
 =?us-ascii?Q?DViQL4w5rJNCml+gTONEOrk9pnVIQ47YTIsVsTsPpboHIzux207sbAQXV57j?=
 =?us-ascii?Q?D9hBk1p2YfUrBGqhp/jZ1zvMACYUuYc9dzhVsWaLp+4UcJcmyj0LBJl/ibKq?=
 =?us-ascii?Q?zo6TMNJoxsovn4ZMq5I9dQF5wxKN4mH6s9vlRQxZYk90TImbQ6SuSYY2TRlT?=
 =?us-ascii?Q?6FGKN67gK1gkQbnlwt/q5Gn+hN9EGnqLhPPsuAkA+kOPMNHMfA04NIzC0RUw?=
 =?us-ascii?Q?qn0J42faHvbmuTV91ucxvxw/MZ3Y/9J0OZ96KynwB50F+azg2Zd9WSwPLM1t?=
 =?us-ascii?Q?FGAUMtGg/VZvI3zFB1yP5Cv6QOPib+p4FIIsoBZLLeqtOeSCZvBzv0YFICcP?=
 =?us-ascii?Q?6bbIR73uo8Br/WTy2EaUxu7NCBFlgSzUpDRMB3SZAtjWJGJ8izaqeT1ois5i?=
 =?us-ascii?Q?RUWmPHCTfdzccIF0/naWDUdbXCs+w8hrDRh7wfDhQvDqNz3Nrme1F0l+/TD2?=
 =?us-ascii?Q?TRbmuRLZah0UtQydAt3FY3xmytxhawCrV0p5N3kta2sr9UMNaZoVkBbC6L7X?=
 =?us-ascii?Q?nmE+uSFJnuDdxPD4Xhb4d9zcRb6Tdk7OCjKOarxO0HNWJV9Vezl5iMMtMz35?=
 =?us-ascii?Q?OdI7lYK6mHvZ9YQpDsb6OFCIFWLQt157dpkIwFuNEmiRhHDuz3mmDzaN6Ehk?=
 =?us-ascii?Q?J8a3+LMKffEDZVQB72aUO9mn7BgfkgEBi6wwWJVQLPMK/wAseiydVgYTfMDT?=
 =?us-ascii?Q?YZjV0yuKMwZqDB2+dtUBdm9cin4nz0fuzsEHSj/dMgZeEtzA+SpADXzax08o?=
 =?us-ascii?Q?9bJ0f832OL6b+bj02Bwm5HGyoWrj02ly2OHhF7M7jRv6ugUfau+tG8bxOnr+?=
 =?us-ascii?Q?rHMN3It5EBX7tLNAedF9URvo9bl9u+t0omFxjPLErijkdJmaxEgMZWVakOiy?=
 =?us-ascii?Q?LsdKGa0oLepjpLb7ld4n3L7XvTNjabp/e3WGDJwqDY4TkW328Lc++iKk7I8x?=
 =?us-ascii?Q?gH4R1QHnpthC6GocGZkYugMgmmczdYmklDp5Z3nYwIahBmq5OLZA1PhOdDHd?=
 =?us-ascii?Q?on2nq7QHpKoPvXLm8IMwfOXq1RjDyk1hMZqArUKd2A6wpZWP8UujjaRlq8j3?=
 =?us-ascii?Q?bnoXPQZ+EunK5Fp4CX9ei4siNO5wECfO4OOjNdfa8yUh1Ijdhn93XY5OPDvR?=
 =?us-ascii?Q?hlPRfbS+F0Kbit2kwbxJeKUGulbOjVPXiUDtYblJB/IZ6fUjRy0fMchRtXXW?=
 =?us-ascii?Q?3/2SZUFXrIu8BYGJ8r1SJBlBT8UVB22eNJOFpJYzx4pc5re7VwVL+mIMGwna?=
 =?us-ascii?Q?2gJvGHRH6YDrkhoZJlxjCBefV2Vxmm66ewYSy48nmiiHGU2I+3e602HxC6Zs?=
 =?us-ascii?Q?97zEeXUMz9vaftz4nTyjp81Elhm2foA=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409346f6-0e99-4a71-2e23-08de6591bb55
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 15:09:32.2450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7AQf5tgg3R57UNr1/VT1WGVSgbwrgQ2C7BwB+6OwEfqXcnhHW5Z5dIFbscXVs7EI2jxKghLgQ1crJgNQefzbwAleRLD/2omojfvxY7R++g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6154
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-76591-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADA6AFF842
X-Rspamd-Action: no action

A future patch will enable NFSD to sign filehandles by appending a Message
Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit key
that can persist across reboots.  A persisted key allows the server to
accept filehandles after a restart.  Enable NFSD to be configured with this
key the netlink interface.

Link: https://lore.kernel.org/linux-nfs/cover.1770390036.git.bcodding@hammerspace.com
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 Documentation/netlink/specs/nfsd.yaml |  6 +++++
 fs/nfsd/netlink.c                     |  5 ++--
 fs/nfsd/netns.h                       |  2 ++
 fs/nfsd/nfsctl.c                      | 37 ++++++++++++++++++++++++++-
 fs/nfsd/trace.h                       | 25 ++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  1 +
 6 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index f87b5a05e5e9..8ab43c8253b2 100644
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
       doc: get the maximum number of running threads
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
index a58eb1adac0f..55af3e403750 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1571,6 +1571,31 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
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
+	siphash_key_t *fh_key = nn->fh_key;
+
+	if (nla_len(attr) != sizeof(siphash_key_t))
+		return -EINVAL;
+
+	if (!fh_key) {
+		fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
+		if (!fh_key)
+			return -ENOMEM;
+		nn->fh_key = fh_key;
+	}
+	put_unaligned_le64(fh_key->key[0], nla_data(attr));
+	put_unaligned_le64(fh_key->key[0], nla_data(attr));
+	return 0;
+}
+
 /**
  * nfsd_nl_threads_set_doit - set the number of running threads
  * @skb: reply buffer
@@ -1612,7 +1637,8 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NFSD_A_SERVER_GRACETIME] ||
 	    info->attrs[NFSD_A_SERVER_LEASETIME] ||
-	    info->attrs[NFSD_A_SERVER_SCOPE]) {
+	    info->attrs[NFSD_A_SERVER_SCOPE] ||
+	    info->attrs[NFSD_A_SERVER_FH_KEY]) {
 		ret = -EBUSY;
 		if (nn->nfsd_serv && nn->nfsd_serv->sv_nrthreads)
 			goto out_unlock;
@@ -1641,6 +1667,14 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -2240,6 +2274,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
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


