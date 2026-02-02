Return-Path: <linux-fsdevel+bounces-76082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHx3BmHsgGleCAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 19:26:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C68D0250
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 19:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B49353039CA5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 18:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFC72ECE86;
	Mon,  2 Feb 2026 18:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="BOZljDzW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022132.outbound.protection.outlook.com [40.107.200.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCE82D9499;
	Mon,  2 Feb 2026 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770056726; cv=fail; b=IOooS9ATlABQ6E8VY+AqjXDGXmDY2zuEqvVudXn0yWDRNLLsJabzCDI0QafjJeXquHVgcXfY1B9SZE4ik5DUlgD4gvq92wGbqNPl7YRaIAjSMVqSZAhEe14tLDEQDh7WcI/Gw3awOKXV9HH4XkPGsUqQpcwJn798z+ITRRkB7sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770056726; c=relaxed/simple;
	bh=TzyljdE+V9/uGI52uZm2N1XyUJS9ZmCbozLlQnxBQHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OApGMnz/zIfIFgl3jggtwM/SpFb08qms3HoMj4X3XeSFneljegxbEEf3LQPX2ngpyS+PvLcSqlX85jcElHdxnt25UitWMiPdYSrOF8ePANivIUd2nMx1ct73ETse2PWBpglG10iValgQPZs0LyfslqlanHMDLBBMDuuTLv1QTkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=BOZljDzW; arc=fail smtp.client-ip=40.107.200.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ps21IcGiim52DLX4OHAGjOSHXk9cnyp7HazkG+JA74E2+cqHiUU23jybLJt9UdmLhxMOg4zWgvWaWfgNdYxnH6gWRpBhS4hxwuMD1kY0o6ixDCh18Ro7JMi/grTMpGX+uVFLBxAy9Y6n2lTM+8lgesiA3T00FNtbPw3LlJUki8OJz/xYn9XGNbhtGopZx4NkBU4apDOYn8M7qKTeE6xVJqXSZL9aNoZzYB656JEP/10KQlLP17QgBTK2pzyQafjLLv2CR3JnU1/nlOqXFLfUXnuaWA9F5HlfNfnTIJlatMGSQJ6CxmxEm0d3RVaScR29xp0h/9zKEB0jSDNeWX+01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CfaP4mo1UVvgSNpqrV4D/UDa2gBd/AuuLJ3HFpJgVs=;
 b=D+Q72XZVzXD+Ra4gK5dMS8pFYQJEYPbYZj4qFFNhQTUY6A3LvQjTyQvhezkGnf2RMGMDMtIUormiVFl5jd04fvBKObWNY9ngfcZvLqrTLa+xrtf7JcnjjtUW29cM+UnoNEb+X9GaghEe1PAnyvFMsNYz6jR2eJCsXUteQTkbksNXr6WgQZmVEDIh3SXokhI3F7oBGlf5n4w0P0LVrfTTOOlj5fOyJc1jynqHLWM5V55MKXqeRLIuofmWqeR/atNlQyVHxcQqlqDCR/bVIw8VbDgQV6IVItwPQ/b5F7xsgGLGNjzyBW5jDzMc1vUUtPCYNl42ybhttrkssyw1CO16bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CfaP4mo1UVvgSNpqrV4D/UDa2gBd/AuuLJ3HFpJgVs=;
 b=BOZljDzWeIkN0e/8K7PRqafAHSdfuRKHcdWqo+D70PS8IaZse0+sonAmYv69BSFH9WzB2X6GrPD53vkwzdVohcmcDCaMPnMSruyXUTYg2fS/OfgrL52PR0prrpOu+3FUCpOhilgSGbjB9N41f8NpOzdRGOYxPiWGnI57HQEblig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DS7PR13MB4751.namprd13.prod.outlook.com (2603:10b6:5:38c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.6; Mon, 2 Feb 2026 18:25:16 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 18:25:16 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Rick Macklem <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3 3/3] NFSD: Sign filehandles
Date: Mon, 02 Feb 2026 13:25:12 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <366B1054-69B2-4BA1-91C4-AF62F59296BE@hammerspace.com>
In-Reply-To: <20260202181932.GA2036@quark>
References: <cover.1770046529.git.bcodding@hammerspace.com>
 <11253ead28024160aaf8abf5c234de6605cc93b5.1770046529.git.bcodding@hammerspace.com>
 <20260202181932.GA2036@quark>
Content-Type: text/plain
X-ClientProxiedBy: PH8PR20CA0001.namprd20.prod.outlook.com
 (2603:10b6:510:23c::15) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DS7PR13MB4751:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc6f53f-aaf8-4448-6a54-08de62886975
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?57m7YMSGW7972MVatOHo2kk+zNvUG49EuTWvXEUIgy9q2iexYZr8Jt8Utdy+?=
 =?us-ascii?Q?tM90KerOmO6j6cU7bsseZqXryOOvK5DkZI5z4wf1VjTDbzVpnyNCF1dWFRPH?=
 =?us-ascii?Q?qdTX5HYMr+sdEct4zXck8gwYao/FDAK5usMj57lJPn8CMPf+Hqy18D0Akwmw?=
 =?us-ascii?Q?11NXm2SQkVtuLUY5i4roLmLm/i77FB68qLDN8WF3mUT6ck9/BJO4Ubm6uPn4?=
 =?us-ascii?Q?ijGZjUVOZDV3Y+Pi9TdwbMjA/C1f/4T9bfjTe4PayqxfAp6FYUMYyM91XAS9?=
 =?us-ascii?Q?+LfrKuaDGNTsy1Ml584uW1M7C0WPcO6BHbiIrtQYQOE/vv9hYEN29QVQIPtq?=
 =?us-ascii?Q?8SFClrF8OrHMZkO05oZeIoqyYv5oz/Rf0UaX2otAFZEWCrQVtc0TdmALkOW3?=
 =?us-ascii?Q?XQug3yV0uMSRn5uxNmmHrhJ9fARJ979QJczaB0piM6fB/wvpsBdfgr65hHs6?=
 =?us-ascii?Q?bKxtevAHp4oBmNwlzE+n4/HDQUNQzGbd2m6UbLMOZZvGBl1p/D4p+o1ZcaKo?=
 =?us-ascii?Q?sacUqK2pBPVTbA3gpxwyGOyUi7NqhaxvEffU+2kWTS7OP99DvTL5VdK/Z1u0?=
 =?us-ascii?Q?ia5HL7w9DQK8ivMIa7hu7k0t8VvvN9SErPMsZElMRLfQdtXAXLi7WenL0dF3?=
 =?us-ascii?Q?vQZooNGUtDjRR+nXGVR9/0Msar+un/nLNjd82qu3tbaTRIutq2RLKZSfdQSg?=
 =?us-ascii?Q?/4DhSwsitbuzN78qs22RsVZAdJpEnS7YD6zWGNKBZeV1IhdnXjIk/aLeCn58?=
 =?us-ascii?Q?qCUuCd9VOgL74SzQ9bof/0dxRDeQC50Em2hX+jX6tsfbfHK/Hc9SrVPPBb29?=
 =?us-ascii?Q?XvDZNXceuuFP9RBiJLqX1zmRzWp8XreSZU/99LXgCsUxiEJWDLbqT58r0/GV?=
 =?us-ascii?Q?qxzgIMAfLC7X+UwcVNA+m5Crb0h7uZXkG015HvBebpcAzJayx/HORrwYRUAq?=
 =?us-ascii?Q?lryQGGGWUe6Fy8jZWO9M3fnWKar68qXgm95AqT6zE0+JAk50EfqGIFqD6l5Y?=
 =?us-ascii?Q?SiDpEUdXQf/BLHV0QzbwyyiIQ0TPrJs92lhWowdgZkh84oUd97piTDQBW/WA?=
 =?us-ascii?Q?xSeFNBm/lrmIHjKPK9lYIRa2j2KTf9whATmcKYQroJoeNaQAUGszqLKTmtVr?=
 =?us-ascii?Q?RHdcevR691kDG6abBAR+/v3Z6pkHhmICOhpAi8BUFbRxP6TWB17D2UuwkFRs?=
 =?us-ascii?Q?EQKl+jSHLApKb9HgoWHofywUCc5ns9gSRgAFd7rAopHidD2Env05Rq+sluac?=
 =?us-ascii?Q?Htd0fEEIE/pFIns1XpzilwXD119Row4u9pYb4btmOrNMjdhTmJuYVmBxMg13?=
 =?us-ascii?Q?+cjAZIQtYj2Ydo/gACJU6blgf52uj7Larg1ZulUtsmtufwjq2ifNZPXPEWLS?=
 =?us-ascii?Q?gymmI43fFQ9VEzW9sJb+3sLb0PPnlgzpQ+GnE7j5kED/80ExyqWRSJ72JAce?=
 =?us-ascii?Q?J1gtO0Njth+zB1b2VevkqWP6PQN/xwvl82rQL0D0Cjn9J9ltgsZrBps0d1zT?=
 =?us-ascii?Q?v+DiUYR5B2QIgkLYvGYYafi2n4ySj9Yq+DHDzOYuo0zk7YExPa6z4SafRwSu?=
 =?us-ascii?Q?GsaLOrmoo7E41EZ5Zck=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6MMdyAbYGkKTroCBigkGt0hmOEPieBD6OcKKfBNhV4ZTN54xQy2QUVomI3mW?=
 =?us-ascii?Q?0GtViICkavn40kkrN/mfG35wouSIDVWjURLMGm1kVkPazNkqHl5SodktJhH5?=
 =?us-ascii?Q?0OdwJxoeZdSlyT/RM7vIJcoE7QbA7spStf90gTQNmWwvf3r848xamOLAsOHB?=
 =?us-ascii?Q?8ludkpYJNefe/VYheGQnEsWg1k95rUh40BcCgbVju33B0H9IoFnjeASMNKUt?=
 =?us-ascii?Q?m7oVlrhzUmJtE356Byrx8hsp1kFn8s3crjqOO3uxRz6jqTiBuP6ap0R9s2Wl?=
 =?us-ascii?Q?Vpbm+An5OMsQ59/1g0EjkwexdifmIqfu2rZ4qLdHgFJVNb64F8+Qu687wgJ8?=
 =?us-ascii?Q?naQzgBsormz5VLKW3yZ0etiCarqI0IkEREJMAmJztSdM7oYqbCvkVQpeBvHs?=
 =?us-ascii?Q?33zW53WBe+ucmIWDhjnvm43d3uB0FRCr3H7Ut9yM2ZKYiV27kfeJTX4uQCt3?=
 =?us-ascii?Q?iH9zCBkStBgPoOd+/L4Hi1NRQXe/bL0AOwh6vo+MJtR/ZG5YEFeICEB6pE3Z?=
 =?us-ascii?Q?daGTsqbdrQ0fkH2e8ZkWTWccR6RxCIdYY/8smCmZLzMbbBgGAK8o2SKe9Ure?=
 =?us-ascii?Q?mIvcrEmXxuRbpZP6RC/F7XQIv4sp+nNcxWVSO/T+80qY/tK9PDbaLUWRoHm+?=
 =?us-ascii?Q?BBtYKq0OGLAcoC7ukGaiVf6AA9+gWQbX2uuk26DY+Rz3mepCN5bg70unCFyZ?=
 =?us-ascii?Q?9xJVqXw+2JRyIFw5xcYt+b6e18zbkEzRbrB6m+AwcPRfZLWNfoihsnTnRnzH?=
 =?us-ascii?Q?nzEmn+E3wT8WwjXUI8RP/ZzK+AieT1uiS+tTJlE57/dwUkrjzquYPbOzY94+?=
 =?us-ascii?Q?+HqgL3A3LgQlk3M12DCfqVF4+Jtgg5uHJvdokOS6EhKoc26rqN985phUjz4y?=
 =?us-ascii?Q?0EjBi7zUCUfjXINOoXRLWcAkDffwINJuT74nv9JKzA7/jzYe24ISHe6Y+mLy?=
 =?us-ascii?Q?TSSNLV964IcsHRHpzs+6iNty+D0/qeWzp/c8bjPPHXGn8i4WdxgRJSrG/VSx?=
 =?us-ascii?Q?/OZMAY8L2+N/TQhu/ZdyRklJ6mxuo2ECEl87utC/Outr5Fsgh7bQxzWZnw+Y?=
 =?us-ascii?Q?8IqeKHSng3sqKeJBuAQgvZs+COCjFR8/F32VPMR6zR9INyaAtCImCUfnIqQP?=
 =?us-ascii?Q?krUCdDI/Nx/Z8Dhx7uW8Hs9VcqUDQzD82Fxhm4OzuM8vfsdRkJgxsyU74Aqp?=
 =?us-ascii?Q?XpCORSuvDUhKSd54XRl0wZjhT2K23XWNmKTTpbvTOLZ5ERtI1nxc4abdCPCG?=
 =?us-ascii?Q?Imv3nICtH1lAbStslt+Nm84WkOZSKQ4HNrhBfjk7YaFwNSaLZYz2bPoIdIY/?=
 =?us-ascii?Q?ZuLo6v2WlAOwPxlgsMx4JrvyPlCWPDARHJNW9ygUSqXK8ykFdbbgHwAqdmQI?=
 =?us-ascii?Q?DrHJ1cdDZ9LP0PvQCoSm1y+3PprUVNUFw/lOlt926agEJnYkxCi4VRbLetlb?=
 =?us-ascii?Q?+JmAYkH4ufl65AhbA4hjuV2YRAnVqqtvZdCJSsUnW0nlMViUlOe+Gx1AQiQy?=
 =?us-ascii?Q?ahF7J8hWgAuw2ZZSgMUcnHDK3jC49AaHk8T991JZ+T6v/xBGhaN3YsrB/IkU?=
 =?us-ascii?Q?FwKpJLVDxwz3pwq5IoJ+ScFmhuPMA0lWz5mm61l/1xLR9hRA0cYFe8wA7A3E?=
 =?us-ascii?Q?lWnqfOQkjS57HYO5s2xtS1DkAWh4OJcG2KsTWnfX6DJovglz5BFO9h2Xgs5z?=
 =?us-ascii?Q?pCPpXLHle1D9zLHktvloy+B9IvH/f1Hy3qwApwEZV0DS9F6XXo/elUH2fpC0?=
 =?us-ascii?Q?q2F3jUaKxG+VYQmhhTwAbu4mxUefw8w=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc6f53f-aaf8-4448-6a54-08de62886975
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 18:25:15.8847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e85PpGHgTbPjCkKh/K2Gg01pf6Q5IjpRaykzlEYQPJCWQJKIWyJ5pRGYk0ki9lC5HNaEbaf91dsAL/1abH9M/nSwpxNc4PEUb7DYXZ12hDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4751
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
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76082-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79C68D0250
X-Rspamd-Action: no action

On 2 Feb 2026, at 13:19, Eric Biggers wrote:

> On Mon, Feb 02, 2026 at 11:19:38AM -0500, Benjamin Coddington wrote:
>> +/*
>> + * Append an 8-byte MAC to the filehandle hashed from the server's fh_key:
>> + */
>> +static int fh_append_mac(struct svc_fh *fhp, struct net *net)
>> +{
>> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>> +	struct knfsd_fh *fh = &fhp->fh_handle;
>> +	siphash_key_t *fh_key = nn->fh_key;
>> +	u64 hash;
>> +
>> +	if (!(fhp->fh_export->ex_flags & NFSEXP_SIGN_FH))
>> +		return 0;
>> +
>> +	if (!fh_key) {
>> +		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_key not set.\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize) {
>> +		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size %d would be greater"
>> +			" than fh_maxsize %d.\n", (int)(fh->fh_size + sizeof(hash)), fhp->fh_maxsize);
>> +		return -EINVAL;
>> +	}
>> +
>> +	hash = siphash(&fh->fh_raw, fh->fh_size, fh_key);
>> +	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
>> +	fh->fh_size += sizeof(hash);
>> +
>> +	return 0;
>
> Note that this is still creating endianness-specific MAC values,
> considering that siphash() returns a u64 which is being copied directly
> into a byte array.  Maybe not what was intended?

Thanks, yes - not intended.  I only corrected the userspace key copy.

This would break filehandles if the server were migrated onto a different
endian system.  I will fix this in v4.

Ben

