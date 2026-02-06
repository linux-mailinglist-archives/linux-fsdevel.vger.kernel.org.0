Return-Path: <linux-fsdevel+bounces-76592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLEYEaIFhmkRJQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 16:15:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9A8FF96C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 16:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8504A3081E35
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 15:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5BB285419;
	Fri,  6 Feb 2026 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="ZYQeUL+X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020137.outbound.protection.outlook.com [52.101.56.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7539628469A;
	Fri,  6 Feb 2026 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390579; cv=fail; b=WnfLbbSxdh7VL+2ZCekHU/SFl4PYnFn4vQoI8PJD/BNo0G2R8NRPDJsHqDdKJsbHHE/U/GkIPXAkDRwkD5eiOZz5zzxzK6OpoMOBe114NOo5tAfbMw9EY5FojldBV4eQJFJNIp59ngEbjdr06vYwcP75aS4L5bi8VfZuLwwMD64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390579; c=relaxed/simple;
	bh=hCBe+d37LowFP4gvnqQSRZnfs1QhMgq6jz0UnkYU9RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R4VkFWOgruaAZ4ygrjepUdwHQjJl1UPoFXfk1iZBCS7iOdcXWBio0XVnON3VLEvgR/tdon3+QlZ/EfRRtc0G3+AuxNtxi17ZfURX5WysjdYF1b4hiAfu7Hnv9TniIBsEYg8/Vka4s4GOj9VyPhyiYdXHkqfm1LbOEEJvMmHE38w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=ZYQeUL+X; arc=fail smtp.client-ip=52.101.56.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdiESbAO87puJfedLKPMFzmNKxemc/6uqCzvYz8XVVDbWJcb87Ny2qr3uCcfMw3b5udU62h1rrLDnmW5yesXQ8uVLtG630tRhfgmZ3LXsmbzZu2Bays67YQcCguRlfS5hgLEOqrHFngCg4ISMDqTwusjI/KobJ9xcERwUPW9dfQIyUAaN0Jbj5z5vxybF8BvYPUoXWcRanE7l9mPrk0WiZiSTQiLTexmtsToZNCkqbjys/1nv4zSm92W1aAZOh6zRp7+yxGn6qaEk2rEnxcBQGLiVovwXkCxSpYusUgZQdtbReEpuPIW50jhv2Kd/S4PhBk0Q/2tMyfitpgudB6L5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTOLM7/cclqbDrfkxYoGc6S95wCKGw2kQiCxGlqJ9oc=;
 b=nmSES82+O19bXUmlRGQ+5Wj1F2N4Mo8Zp2OhGubaDfLaQ7JP5E0qKQHzOZc0rYbgkchvLZKd8kPX4mDxd6sHenxFa4/0QyhS4BEAxNny6ajRW6aKPSl2F17oiM4P2ZeZsaZg4ZKewJT4ky5eBonNb/WDzjn2gzuZTgqJ/sE4ejKZjYfTlr15bMpg99ZjQfbc5BAOC5/y74NIc9cqqIDM3QlVj+mMKK2kA4bGFFqF3gop6x7L1aJKYDoOYBBv/xdFLP6kOtcaxV/JAXNSlFqq3YoyoSi38HxrVOI1AqnRrEjyHCxCxu3AwuSG+zL+nWJhNSy5D9Q8F6VOujdsyJKhtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTOLM7/cclqbDrfkxYoGc6S95wCKGw2kQiCxGlqJ9oc=;
 b=ZYQeUL+XTjHDY9lGV9RCm1R0x0wHQe/i7Gik/Htq0e/fGygeOW/iJtzQ+9srL1tOi6DG1nPTX1QgMC/9RGP7WTW0KO1M5DtzOHX66cAJGveAmgtGrNCoBG9dJNqfcvUkrXFbba/ZI/Dj44MVOXR3CyO0lpmv/OE4MRmY3OgyeNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 PH0PR13MB6154.namprd13.prod.outlook.com (2603:10b6:510:293::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 15:09:34 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9564.016; Fri, 6 Feb 2026
 15:09:34 +0000
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
Subject: [PATCH v4 2/3] NFSD/export: Add sign_fh export option
Date: Fri,  6 Feb 2026 10:09:24 -0500
Message-ID: <59206b612f6efe02cd05a78f474949099e28a2c3.1770390036.git.bcodding@hammerspace.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4859584f-412c-4e5c-a385-08de6591bc95
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lPaLkda2G2KFoyQ7o28cFyPZfffF1bvnUqKpF0C4HtfJFu656IkvPxhKimny?=
 =?us-ascii?Q?KKds1waUQNkqLfIoU1Ovk639Xl56ZD+PIF3/+9mdG0u1s884UmKPLiESBdK6?=
 =?us-ascii?Q?IPqxE/KxssihhgGPTM/PDsd1aPhN0PacuuowZfLitVofViAgyVIoRwbbI52f?=
 =?us-ascii?Q?jzLfbovBRxlZi4gHFrm3FPVDPVntXb5ayDoS6uAUSbEMwtVtvtwAnIIZrMI1?=
 =?us-ascii?Q?6h6qV+hYiZushhhakJtTi08c5XCmLn4Jdk30Ahy3voAkSCRonC75EQ32QOKN?=
 =?us-ascii?Q?j0Jl6JDgJvfB3cINcRbIcUVz8vy73zpCjgo9R3OPh52ZE7FKO3HQB5oAt6eS?=
 =?us-ascii?Q?ifJDOEYPlCmp5z42DZJsfFQd7aEUv8k+uh7c9GeHEVuYbiFwXq3vBj3o4yTX?=
 =?us-ascii?Q?gYDXfzXmYbr7sJ1vpug7em8V7cEhDj+qLmf/7y2O4Ep7EwnI0/CtBZfHMe10?=
 =?us-ascii?Q?ayDuaD6or7UC0C4aupkb4U/aqmz3NVFC8wogYAEXPtY2R+Q5xMk1G0MUgTCk?=
 =?us-ascii?Q?V3YlT1BGPIC3fqxJb0ZMRmKn8/+xA8GvQFqmru6oTUMwfGLRvxsg8gxhcNpl?=
 =?us-ascii?Q?7SDUxvAyFHb3/t2Cee+mQw8LikeqvqJHlMw/oYuW8qFyPPOYtuot/bzxH+za?=
 =?us-ascii?Q?2aa1OLQDogIo+s5GbktRXDXyaRyZ2UZhYbqTcpZsUHzSubZXYEWTLv1w3raj?=
 =?us-ascii?Q?GRW3FiYoUOscgubNa5F4BkaOs33SyHgAs/qzk83xajnUZBOOGfpDMrtc5d8D?=
 =?us-ascii?Q?RooQcMH8bjceYPY7qXBhuW8z/QXwGwK1gRsyRKnT/lT2eeDV3Db0H6QZ5t2X?=
 =?us-ascii?Q?qJshapaXhmVyXKYFlfDcmgRdfGvi9dNzGJIN1GOHQyAtIXnSqQNcRDmfy5jJ?=
 =?us-ascii?Q?r4bkQ6RIZERHfNsTxAL50YYcyM14B1/Bg+3XS9q+OCH+GdKFGrxseupE4u5W?=
 =?us-ascii?Q?lelj/Q/bgbL/bnh26U7bLu4eRZzt6d5vCRCcm2GM2N2N34X5MqJt6FLja/Q7?=
 =?us-ascii?Q?wH3I2EqnTmSRNpLDjuIyA/lSvu3JxJgk0Zz4oPA/DYS/wsFMnCI+e3gMt/H+?=
 =?us-ascii?Q?K2OosSqmFhBM8NEzN1mQDfHZDZRGpUVUWNhUJe6kmHo007DfhRhldvUk6Off?=
 =?us-ascii?Q?WzBzve8ly0iMxmLLmcOpDSNQaPCtn+QaAKmc/KBIn+BqQhFmeyElhmDpCoXV?=
 =?us-ascii?Q?6SUfe8ZsR94bAr8meQ6Nwrwn9cy4dm5xsd3wRgF7ixbh7Y5dUYHkRpbuWcRl?=
 =?us-ascii?Q?gLrmhX/34gU7jok2Ccuewao/wNxQXXopO1AG1M/vvg/eq3tgrf2MEgCpbruX?=
 =?us-ascii?Q?zCxfV7GPV/CZZvXe94i5LGsi0Mycm8GSK6KCPfDsRyN23Y91tdwJPs6mCAtl?=
 =?us-ascii?Q?GsRIEBnI1e1Ux/hUo2rT4CojGS2kUXTRJOPdcGZi9JeMi0IN9HzpqT9x5lhO?=
 =?us-ascii?Q?XN2/twKbIQDgETHwOXuVkAwrZ9hMXEmKdq6xo0si/5iTk803i4JT1c8dI3uH?=
 =?us-ascii?Q?XFSXaXErXfrTAbHsiSdwuiLBa1pB+nN44wIFYbde7MlzTdaUiol5ZoXI3b2O?=
 =?us-ascii?Q?wuRNgqB02elUZLXUPMA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M6GbW0kTpoZLydmpIKlnFzZ1qwTkmqiwD49Rvr2LQQvX/Ke98D/6VYOmFYN+?=
 =?us-ascii?Q?JwCTv6pHzgP0twQiOSf4YPktXa7ZvQCWLl4FKkV6sq2Of8exAMu2BryGA/ru?=
 =?us-ascii?Q?DtcN0z1edsQBNpF7qZzebAs8P5l37g+b3IBcR4uIF7tux7/EhSYeMgDAxknh?=
 =?us-ascii?Q?uSG1nwORDH+1bUF6fuBWV0TN7u8u16u2mjO3n+nASkuTmCHZtMeoCtqxOWVI?=
 =?us-ascii?Q?+1RRDnWwRnQohnSbZ7ORN/gXK/QNaDwZrBsgwHacpxYHMXL+E3p/qGb22zWl?=
 =?us-ascii?Q?LELgbUn0q/EbxBTu/tIi/+75L8WxZhs1+mCGs7soPf/V6B3sub/sT/QEJvAR?=
 =?us-ascii?Q?vAXbCcfnd8FTJM0go2HFtn8WGaUltapRrzV7wt6FQap3Idmt7bdUxCl/mzpY?=
 =?us-ascii?Q?l9lA4+84IkGz6kkIVRFT7DWwEqSGUjExvxvlzIZh0tql4xB8SVixHiu+abfY?=
 =?us-ascii?Q?8CjaaF9nsOYGJK4UK2Zt0Y4yw5xsWHcLX85zCDHuY4G//dfa3BeB7gM2XGKh?=
 =?us-ascii?Q?7AfD7/MhhsTMDaYrfaNrv/y9XTJ2c9uBphK3B6R0FbkTyahrQNvDqqcPRc1u?=
 =?us-ascii?Q?Slz6Hnw1cRNBId45taQC2lPuulYp3uWpoYSRTI7rMyWeeXzg8D8Wrc9SNgAZ?=
 =?us-ascii?Q?pIVpOYIH23G8fzHjQc/ObbLDPNWMnqpmnqLO7SoqXHA02JLh0IEhPKQJvMd3?=
 =?us-ascii?Q?zVTYPn46V6bzDtHqjgjQcCRO/jt/vs0hdFn4X0MOYifZXpbyP4u2AtAPdywi?=
 =?us-ascii?Q?mG+NRUvo/2R1qub1TK7MxpMW6jCfb82SwoNJtDwrCqYbRCO64bSBkC9qkRJC?=
 =?us-ascii?Q?Tdci2gGvqoGNBKWHqIkPjG8Fjt2uRfWKXJ6FjqwcuUR9vStJpdqHswCi/L+l?=
 =?us-ascii?Q?bBwcQ6RGUiUFRKYeduzVNlOfIeDFgLpCjpSj2cuNzbOnJATC8J0zjWe2mwin?=
 =?us-ascii?Q?D7cCINiWWHOCg2N5XcJUgxqR34JrAk3DzZEIdUHgdXmQlhRsNYu7lQWHCBkx?=
 =?us-ascii?Q?p+92k7FIwSHWZS7BOB5RdB3E18jJP6HVhDkxH2AsyruQ5xfgFvWRb6zHCl8x?=
 =?us-ascii?Q?QDnHr6E/N5Y2fVlsEcATyBC74kg3TGEqnsPzp3UcWQ+ZlFRs0KRlMIS7dazk?=
 =?us-ascii?Q?FqvDky4IU7U7BS+tivzOKauLEvVslyvXfyvZWiyXWxfRE2jAkTDyg+3Iolc/?=
 =?us-ascii?Q?Upg/Mi5QpzgQDUZ82zdODZ2WoQrzUWqm/VQ6dWUafK/re606S62soMHXrbZN?=
 =?us-ascii?Q?UoN2uzLKh3XYBaJzKZgQE2B2Jx5JEbemPurWVX96LsM5n/wg5cVLJn8c5JAl?=
 =?us-ascii?Q?yJz/KSiFp664eKz6YmCWQnFgMVvq66huen/qQtYkNvu6svX2PXCu9/SmiZga?=
 =?us-ascii?Q?u1X3MKQ68wI1HyCpVmHIswXAieUtrydwWO5S+7+oVe5b2pxfm+rsEljEcQ/V?=
 =?us-ascii?Q?PrLVZTboTTptnY3RdXXS41qnqaHDlbvtMyNKuwpbgFiNWcl2xUNDwuj9sr5E?=
 =?us-ascii?Q?WD0IRHN2BBY92HbcVsFikXU6t5b9gOgCzZUNqoRRdMKRe4Tbf7r/iZ2CQ7wE?=
 =?us-ascii?Q?CBvPX4iTaWkKV0kPNyoM72yXbVaHzd9+EqzU0S13pjl0/KOxXjvL92XnmTeu?=
 =?us-ascii?Q?n34sbo73e4a7D452SlnC3LJFz1NOLq2upfs7DKP/27QM4zPMvrwKx6IKP3Ms?=
 =?us-ascii?Q?kdN7ZQdqZDAv1//uVlRwYYn9O3n9oK/LnpqaHNcSAH0luUm6j9ALZSxpb4ml?=
 =?us-ascii?Q?6Y3XZnYGJTjjv43tLekc+qmcrr0G7dM=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4859584f-412c-4e5c-a385-08de6591bc95
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 15:09:34.4317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bR8d6RTcbX/3rri9samFniEoqKHdzoW5bgNJzs1zr1wdshM3SjCe2ZA6g1oLp3j5RMQQx8GNACMjgkpCkuKzMt5X+whPpiey5Ue6DcCUzvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6154
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
	TAGGED_FROM(0.00)[bounces-76592-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E9A8FF96C
X-Rspamd-Action: no action

In order to signal that filehandles on this export should be signed, add a
"sign_fh" export option.  Filehandle signing can help the server defend
against certain filehandle guessing attacks.

Setting the "sign_fh" export option sets NFSEXP_SIGN_FH.  In a future patch
NFSD uses this signal to append a MAC onto filehandles for that export.

While we're in here, tidy a few stray expflags to more closely align to the
export flag order.

Link: https://lore.kernel.org/linux-nfs/cover.1770390036.git.bcodding@hammerspace.com
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 fs/nfsd/export.c                 | 5 +++--
 include/uapi/linux/nfsd/export.h | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 2a1499f2ad19..19c7a91c5373 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1349,13 +1349,14 @@ static struct flags {
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
2.50.1


