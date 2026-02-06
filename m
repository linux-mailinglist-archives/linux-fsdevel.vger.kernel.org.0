Return-Path: <linux-fsdevel+bounces-76593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Fv6EEYEhmmyJAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 16:09:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8283AFF7E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 16:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EEF23012403
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 15:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E899286417;
	Fri,  6 Feb 2026 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Ges1UP6F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020137.outbound.protection.outlook.com [52.101.56.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10BE26FA60;
	Fri,  6 Feb 2026 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390580; cv=fail; b=QIF8MWqe8g2H4HmchmsXaj2F1T0zKqTKRy+YZ83VCDXdKtc2nPB6UzsE8w0xula0RIRoXOTJwixfBXlj7AKXd2MOSYwBy6dWMLvvOv+7rkMZkli+ukY1xBlyX7WJ4Il9+0vmCPOvhRUNI1agNG2uYKoUVDfSwGRa3bY3TDxxPCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390580; c=relaxed/simple;
	bh=q+JS+UU+uyyT/pLrm8Rj56G2J6Ilb7+H6jlV+7tMVyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bLqTIPYVK3kkXAW2cT4HdohHdi8yAsne2M5Yt+6PeMMyLmNBk27lT6d1hZhIqoGBRH2SvOlh4nMS2pqtXNxoxBldiwJ9rD9mppbuW/9aN6czf6yNWVJbIziIDR0cNLXw57Yx6P5Xtfk/xjv7YwYhGEJOtWkWXvh2ehG4klvZC40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Ges1UP6F; arc=fail smtp.client-ip=52.101.56.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUGwepGHgeX+Z+3eOMFXCMyY8eCO3t2jKDHRUDMXWWwpVrPWWqZhTzH7ooqq3JCdTnkEoOL/KmZt6T7GCXLTC00atu/lSCLO12yq6G1uPhc6THgjKGqLD/yu6UYjrTdSXJQ+o9nMJa2CAyfrUS7zYp1A2gsjYW0Dg0aQGsU5cxyD6jq3TwC+dWf5SUzQLuVPsOtRbWN2dgjOkB4kI3SA2rynZtG5LhgaFJ341y3KNJKbwY6iZ8B86vzORzZecvXSKYBQXCvRz2D49WW6hTJn5AMFwhK/HvsvDYyosypzfq56vvLQWrB1sBMTX7Mu3hUUTihAkRPB+9pK4Ubu4H4hgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+zBq8bhayFdakAML/zzzfwASMTg7J7sRs4RmPWJBZc=;
 b=SMhuRSBOYJg9lm0MvQEFnXGXkp94iP19ZYvx3KHMBeeax4WaiH6IB30nwNij/RLvfl2wwSNs4Ti+nt431pyN69ph3B2XK8bjmqaZvvmeBiyotqvtVni63RLat8ZW77aK/sARERWbTBekFTImSka6mjAJAjkqWVryAFgjCRYgaTn+OVIqmUvjATO4sonzOQvuE+MKB/XWndpQ1cyhfh2jQnVnjJNsRv8Wy44ykRvwHwBNpy82HEFrTCO2Udsq9EVXcfr5RjW+LiKhWUVprtJafQE9FkD0rwggsx1Op4VjNjwMlLuIohftNQ3DwPsfvHiabh8FARihrEL2B68NioDDqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+zBq8bhayFdakAML/zzzfwASMTg7J7sRs4RmPWJBZc=;
 b=Ges1UP6FPNoC6qrWYfVoxCq9VrnWg2hl1ZOKll/J6P7quHDMkVNjge2bFOu5AcDktGaQij0csQBxl3hC3H83t7IcmEoK8N8oP33HGrrK9wUL2JOG9RJA0BpMSvfRnM+c/J8gdZxZeXK6ZNBa+0x59A/InHaMQMoD77cyMiKTmYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 PH0PR13MB6154.namprd13.prod.outlook.com (2603:10b6:510:293::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 15:09:37 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9564.016; Fri, 6 Feb 2026
 15:09:37 +0000
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
Subject: [PATCH v4 3/3] NFSD: Sign filehandles
Date: Fri,  6 Feb 2026 10:09:25 -0500
Message-ID: <d34d4f79a7d4c6b77ad260f925cb51c34fd53ce5.1770390036.git.bcodding@hammerspace.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4d7b266a-a0df-46f9-b154-08de6591bdf8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gbNyd3ZfZFvswHj3T5eTPoBwjCK8jXzXfU1/MuVUM8Wm31eBkHkaH6FeucXj?=
 =?us-ascii?Q?M/NXHBuRZpbJOD9VP1KwUqC5kvZeiapBDFQ8ipLmVheqmnsDTypUxipy78EQ?=
 =?us-ascii?Q?1Cd9KPoHs6fQ2eYtp4KqD8cptaFoouNYz8lkAX++1Heg8eRS1fRXsSQvUp6p?=
 =?us-ascii?Q?BMmjggm7anQCnHmlot79pZKe6n3kXaZo2sH1qOJqUshj9bOE7uCntK3TGk+Y?=
 =?us-ascii?Q?mVTikSUcIUGsRuMGHztxy7U7ui7MrLY/kex66x4nf6J7yjqky0MsGaMOiLxX?=
 =?us-ascii?Q?YNHnAWroyDZiM/jLnbIxxatEXpnjKvIdXUCQJZv1yTHXCRUtJ+stFOTl/fZQ?=
 =?us-ascii?Q?xtwhzPW90QK3SQf/nuVF1ZiV5FVr6tq6YD2tKUwXviAubKkFLmMXo7tf4kZE?=
 =?us-ascii?Q?TJciJBik5aIqF2ugx4kizaVdbzvXtFkc96SiuzsqS3sRQquI6cOc9e9mmkxL?=
 =?us-ascii?Q?2MUf4BUvY51ddBpKHhCo0ECtRq0pZSg+fkxFnqTzTb1GZAfnFv9ryXGlRGyd?=
 =?us-ascii?Q?/nqDk8IrM7up4XSK6LcCaf8aJhQscl7dbX2b+1vw6q4eTBzg6XfBcaYnhr/J?=
 =?us-ascii?Q?M4YwTw4CEMbpXqYo544gJtMQme7mXkn2NBHmD4lV2wB5aRQ5ZyBFPB6ILQdY?=
 =?us-ascii?Q?9roaCJVTjzDHSMsu016YdR4ums1uaOP2C3poBo7KsebFRuk0MFbP2E/9qfrS?=
 =?us-ascii?Q?0SaBk24PghjG3VBMSaW1VD50iUr06R6/Yggs0+kMfUB9U7N6gvmZgdb5tWma?=
 =?us-ascii?Q?5ldix8hRfA9qnc4WpH0EssY8OYZi1duoJeCkXrAFKV0WRKoZFKQE3k7WHHqc?=
 =?us-ascii?Q?AhWQHPgeDTmrCh0pV3Jl+0/XIc2mR4g4FNuJ4Xz+FYTpVPxUo1oTunLOkeYw?=
 =?us-ascii?Q?yRJ+61jsGnbdpagRq38UUj1wDGVISHm0cqXBlH7lXwN02q68UBwWL8tANL71?=
 =?us-ascii?Q?3fIiTthwDIiQxuqpYlqUgT437FUucwFsteIA5H5LKaxalgrlb9J0nAuUsTp4?=
 =?us-ascii?Q?FU4yBqwrrySzgXPGj8lY8SapvPgFaE3cTEehEir65coUD+T+5gHnCndT/6lb?=
 =?us-ascii?Q?nOJAxtIoHxcNuo/hSQMcT+H04hBNpc1uYHNYXl4HiiOo04IcCyye27BEVeGI?=
 =?us-ascii?Q?p+xtg6IpNPoNGicv+BRKzG7i1U9en/xyiURmGMbFh6qQFueNA2TH5xNiF723?=
 =?us-ascii?Q?6FwQL650LXPyRGbLhtrYsTQeBy/6dCQnmnyEXbKmyN3dtNyPn5XKlDkTOyyz?=
 =?us-ascii?Q?ZQrCIy5WVJrQ+1oN4yhCT/Ng/m9vguSTmnY89sGH7Bl4c8zTXbvFkL20BZQz?=
 =?us-ascii?Q?0ZJLqwckXzSW+zvFudsd2O/NwkeaaVhOuv1w6BreYK7qTZYJRXQiCzERAIa2?=
 =?us-ascii?Q?QJ1SB4H+d3KJrWNSqw+pPsIICVy5WA2ZeTbnFaV9Ph2SJi5mmCDPlLsFmNll?=
 =?us-ascii?Q?kUi4WBxELm9UtMRIYreWb3njif/IS2ioLwdk2fon7upCXL35DPD/SI7MEnlI?=
 =?us-ascii?Q?w9QgA5dvHe/aeOs7A9J11uxdJ3H7Bo9wT89qEYaxiqSahx2Nr3dZ+5hbY6xt?=
 =?us-ascii?Q?Jsb877vdTKrOZKDickk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XibYyKN0bfZv+wjzpSEGogiaZxNAdpPlQUkxpMNK8aj8Il+WgCtJXioYIOwF?=
 =?us-ascii?Q?YWJrXOSW1nHnZuYpcyAqBLO/OlPDjKEjnYYoB09hzsUqxT0pXVskCBt931Te?=
 =?us-ascii?Q?WGBuH6rlkyFieZFJcqKbKIUM8VYCOTKJfejRVsrD6nFFfdXpB4wQ45M71sNu?=
 =?us-ascii?Q?meC5MnUfSb1/FHdM1JfR7xT1pU0C8+fS9IBkCgMNOKm5KYf4v1Q89G3PkaeV?=
 =?us-ascii?Q?hbKnCVYrzZ2KTSyx70xSsWNZIO+7sEdHIEuOI+ZNscboBrDzFYy92unRnI+U?=
 =?us-ascii?Q?YnxUqsWTWyOELn5JHelxgVyEzmeg4lOYAGT0y3yfUaYpfZu2Uia1mZHlq8Hd?=
 =?us-ascii?Q?tag/HIsJWP54jICl3w31ZvORGHKHjU7IIIk1ySh51oa/GZAzAQbSjy30h1zw?=
 =?us-ascii?Q?+l+Dz5dtPb8llky2q6KDfO2eGCUKMg29PjzbcsqMe7gaQB3BRyhTJXJtBRpy?=
 =?us-ascii?Q?T2BFOnBMN7+LA6S0fWhGnbWX3v5Ac9EWjdkktFIDBNia6p0Y4Gpq9PhUUiRl?=
 =?us-ascii?Q?04GEVropPVQCMoWJ/LkFLUFmnmh2A+NZDCzW8aZmUllb19k5ZfXjxOHoSkDi?=
 =?us-ascii?Q?nlRSdSu4DqZjRqgVMiK3HF7/B1pqh4T7Uw7F78cg27iEUcfZyZGxnmM51Bbg?=
 =?us-ascii?Q?D6yi2+k7E4mGVQtVZEO9RrFeaGWVl3gX8kZ7VjRdwYrcoql3x8le6si+P7XT?=
 =?us-ascii?Q?acmY2hbSAmM6b9snpcXD9WAbAzEHdersvRhxZd2yUdVsjyNj3VwK9GjglEWp?=
 =?us-ascii?Q?1EX0o6JGUaiaeqQDPr9hteIxmtWhdb14PqcDsoZRflwgE186fReu33wlBR5K?=
 =?us-ascii?Q?JtLTWiEleNdE7weAsaNZ8K5ns9Y+hpHA02YV+Is5TbeWnihz5YL0GjemsvvA?=
 =?us-ascii?Q?StM5lc7EQXMFgDjhkgDZS/uXNsULYmR2quW67ddVrsU4ubm2AryHBUOYhZRV?=
 =?us-ascii?Q?m/ZwwiMgDYIXQEIixQG32IhDqWjgUAmYwptnxbwGGbHCUTEocbH1EuRzbcv7?=
 =?us-ascii?Q?ETSgtzWNv4V+RAzsezkB6UDStdGyEexrphSciSoVynEcHhUorzxAtMWZiasQ?=
 =?us-ascii?Q?yEUbm/U+1+4KEgXWzugolo4NVY5KVmWDTyhANq9UsHhYfrr+ykGLWxZvImB4?=
 =?us-ascii?Q?548dHWx/lLF0nU4917lxj+0miEHe92QObwUyV7HvjmZZlzndE9qYBYs/j4Ok?=
 =?us-ascii?Q?cSSYiLb8zwwmI647SVpZLF5mhVgQTjQNGlql/LZdI4LW6bJTrz75Ha6+IgTb?=
 =?us-ascii?Q?v1fPzZZaprsG3zx3UxtvGrLkuNPqEYMz9wAlwFc96yY/ZHIanZnE0k4PkhpM?=
 =?us-ascii?Q?QZ76+cVtzeVrqtF5m4dsGOhjtLl1xzD7hlv9RqF3VYsoaW99HfeMHhw4ZFcW?=
 =?us-ascii?Q?gv2jNen1qK0HZAEiyjq2uQIkNE6HkdZE3IyJ81UiSDaxKfad6sDkZ1CDnyM6?=
 =?us-ascii?Q?9oWX7hSO9qa4HTyvvIBpGBVJkjW2MYhPQyfCzqkOAHVduNdssTgBmGwE4pMK?=
 =?us-ascii?Q?5c2tBVaTMP22LbXeAqjzwOHZuEnY+i08WRrNEnyAbHfq3yr8CO5uKsBDJA2u?=
 =?us-ascii?Q?SVN6vgQ0roMSb0P+1Ty1MzzjXWzWVtTJMRuvU9Q2woFNyS5RB0nNdl6qvOxI?=
 =?us-ascii?Q?2ONiIduUeSHpIcZZX7BGMz8FW3Q/QDgaF6mhPBtdSzLnh+nAtI3mKHNCf8Iq?=
 =?us-ascii?Q?aNwNJjsRMsfL8Bxv+ZUxpJJc9OqeYlvtPO4MQ6Xi6z/Y/0Pewuvgf16cgYxP?=
 =?us-ascii?Q?Bw6r8P3JLzaqRqvfgvqqeV2aqktSyGs=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7b266a-a0df-46f9-b154-08de6591bdf8
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 15:09:36.8827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEvQd3t0NLQw23Nn3wvxdqyXFwAkvBHp8VdUCv6PSLKZpRJJZBRpXiYVSyUncFdgvXHhtwQNNn4IUoLrAaEQGMsmiSvj2cqhXnQE8RVB3hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6154
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
	TAGGED_FROM(0.00)[bounces-76593-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.974];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid]
X-Rspamd-Queue-Id: 8283AFF7E0
X-Rspamd-Action: no action

NFS clients may bypass restrictive directory permissions by using
open_by_handle() (or other available OS system call) to guess the
filehandles for files below that directory.

In order to harden knfsd servers against this attack, create a method to
sign and verify filehandles using siphash as a MAC (Message Authentication
Code).  Filehandles that have been signed cannot be tampered with, nor can
clients reasonably guess correct filehandles and hashes that may exist in
parts of the filesystem they cannot access due to directory permissions.

Append the 8 byte siphash to encoded filehandles for exports that have set
the "sign_fh" export option.  Filehandles received from clients are
verified by comparing the appended hash to the expected hash.  If the MAC
does not match the server responds with NFS error _BADHANDLE.  If unsigned
filehandles are received for an export with "sign_fh" they are rejected
with NFS error _BADHANDLE.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 Documentation/filesystems/nfs/exporting.rst | 85 +++++++++++++++++++++
 fs/nfsd/nfsfh.c                             | 64 +++++++++++++++-
 2 files changed, 147 insertions(+), 2 deletions(-)

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
index 68b629fbaaeb..23ca22baa104 100644
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
+	u64 hash;
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
+	u64 hash;
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
@@ -240,9 +292,14 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 
 	fileid_type = fh->fh_fileid_type;
 
-	if (fileid_type == FILEID_ROOT)
+	if (fileid_type == FILEID_ROOT) {
 		dentry = dget(exp->ex_path.dentry);
-	else {
+	} else {
+		if (exp->ex_flags & NFSEXP_SIGN_FH && fh_verify_mac(fhp, net)) {
+			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp, -EKEYREJECTED);
+			goto out;
+		}
+
 		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
 						data_left, fileid_type, 0,
 						nfsd_acceptable, exp);
@@ -498,6 +555,9 @@ static void _fh_update(struct svc_fh *fhp, struct svc_export *exp,
 		fhp->fh_handle.fh_fileid_type =
 			fileid_type > 0 ? fileid_type : FILEID_INVALID;
 		fhp->fh_handle.fh_size += maxsize * 4;
+
+		if (fh_append_mac(fhp, exp->cd->net))
+			fhp->fh_handle.fh_fileid_type = FILEID_INVALID;
 	} else {
 		fhp->fh_handle.fh_fileid_type = FILEID_ROOT;
 	}
-- 
2.50.1


