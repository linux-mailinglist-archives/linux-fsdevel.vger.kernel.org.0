Return-Path: <linux-fsdevel+bounces-76622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGggOEMrhmm1KAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 18:56:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 590521018A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 18:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D4DD3022564
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 17:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73DA426D02;
	Fri,  6 Feb 2026 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="WHNwmIu4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022096.outbound.protection.outlook.com [52.101.48.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C35B2D9ECA;
	Fri,  6 Feb 2026 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770400554; cv=fail; b=rgAc1aldxS/DhREIrmxmboiiUzWOdlmcNyXC907KzBX1f6h3F6daOBCENGzBHftsM5rI/55vo3nKNeSr0Asx3YzXKe4mULfLKtu6jfgO0g5lZy+W2LL7kJ8Ou5g4SuAuLl+jByIgtnSkQuZi0PKB3wiqjZmf9Z5dRKGbOdJa2Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770400554; c=relaxed/simple;
	bh=06Yao1tNCp5NYjm2jT/dHgvtLjbfly+Q+Ku01gkqSMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KCRvvrO8DZ+vhMdCKpW159yV78Umyj/780HpaOMhLd0jwbTkmG7fg59A40k8y7EQnC2EHL5MrkTls8LlYE+jXvIdIvbiz3L1pwPuEjQF/uY/8Y6ue1qbL5d2RxZI3Uv+1VZK8ySRryYKPD/wn4ehGYLmWqqOevdoxhIvqdwO3RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=WHNwmIu4; arc=fail smtp.client-ip=52.101.48.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfAqAXO/vU/P2UnjIp2VLrtRmbSJrEkT0o9wICOMCMg4MXIGzaAkC/NXirc8shI7y7DU15C9Q2zbJncxM66qXUSd9hu8qQTrmlr1IzPQFPJppzlaKcnkHkXoudo+knfjwxbmdvvIw68FQMyTHBC8xGAdooXCxSIzlIJTdOvW9uJcHFZjM6rK7MgmOVOzn+hrhf9tR5+xikJM/Hn6EmBRZrvzBEc2ii1Em5C7i2oYUy6R25aCk13nRuXL1HY1mrNLJ2w4uZKtJaU68RpoHjtr5cwG7bFkxcSKq3sP7gUMcKR6RqU1FbKybsrtHzji6WUOEku2secnoKF04mXVrmMP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bn4mYYgfoiXpxz2IWjJPzIQwIvVGbswZyNE2LusLUO8=;
 b=kbY5coTwV5zjd5DhChEzh2PJrfPmYRO05CoxLficLj82pTgwn61dD6RUkof5gvOQiXy4RzjNCMiM516tbQpU9Exd3vd+8xdr6Qqsbm7JMBJ9igOSiQ4+fMWSDWHcX/j4MVZlZJGeOaD/e0VAXTEgpJkteya3oL7SvXmyqekxN+/jm25zOTCO2wDPiRQSDClPkCsmGJL9tjhgkVqiSJU3svOUwMtMbYRfUwiMSSku5j1GOKvscUjjdzoeMm8KMQopjM76/RQUjs4O3oqrU7NsrfA1oJX6/cnddgOatlEQZ8FS49tlpKE4qHJr1fH6W8tsPJK4JeugrVge6mjDfBD3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bn4mYYgfoiXpxz2IWjJPzIQwIvVGbswZyNE2LusLUO8=;
 b=WHNwmIu4z3wULxDjSrey56Ib4xmWMuNPezdEP5rh4MbwTOWTGJ3r/s7EnymrkSxjpt6eR4tyklVe6GhCIEONLWDeB26lB89miov/ApDOgJU7pOYgpEPUyOfFB+wZ/LybqccVeY0SLwMv7ti7L97H/tVn2Hjq2g8x0sG2YTbD/+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SN4PR13MB6036.namprd13.prod.outlook.com (2603:10b6:806:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 17:55:51 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9564.016; Fri, 6 Feb 2026
 17:55:51 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v4 3/3] NFSD: Sign filehandles
Date: Fri, 06 Feb 2026 12:55:46 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <80816E5C-3537-4ED8-B261-186C085B517F@hammerspace.com>
In-Reply-To: <3865f8f2-186f-4750-8b6f-1a589723fdf7@app.fastmail.com>
References: <cover.1770390036.git.bcodding@hammerspace.com>
 <d34d4f79a7d4c6b77ad260f925cb51c34fd53ce5.1770390036.git.bcodding@hammerspace.com>
 <3865f8f2-186f-4750-8b6f-1a589723fdf7@app.fastmail.com>
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::28) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SN4PR13MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f38766-561e-4c0c-2706-08de65a8f725
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y/VpUCPSd4IbZFZjDu/xu5OM40D8EUBOIJUzCpO9X0c0vjLg2naJktVlnWxi?=
 =?us-ascii?Q?aQscMdor1+6bqYzk31+cSPo7e1eVYsJ8gYgR7BeJCThsPGAbiHP2UcNy0GCh?=
 =?us-ascii?Q?n2yRhAcjdwUl9I/kZfHHCacbGS+dG1QT4ho/ZnRI3hdrKwWpAxjBJosyVDYL?=
 =?us-ascii?Q?e8ZBYfPrNzxMawNYe3XnhWjOW8CzMBoxl9Sgsw/49rC1YumWUVvZFoxUaKOH?=
 =?us-ascii?Q?U6ITRYVaUpeAqn3PprezJ2X+o/J0J74chwN7186EcHHX6afVEu1FhIFPHBjt?=
 =?us-ascii?Q?gyhfBC8/YwOnI2/tolumdLdOM+nb/ccnYV6xI5rkMFyAV8Aus9JJdW48+Ee7?=
 =?us-ascii?Q?lhNq2ioHWsd9RBGj2Hc8q9MtypDyCY/p3okV7vD56F2lIq2b88W0UBPv0iOc?=
 =?us-ascii?Q?yp93ouAUv8FN+pJx6Qni2mEBc+fh0HDVtJBU9DZ/X8Ot+zDZpxmI1bdABBio?=
 =?us-ascii?Q?zRn7NFEdv11jvZ/Gu3cEy3dVKOSr99ynwMDolu2MPjo4/LkXDObwf3coSo1H?=
 =?us-ascii?Q?EGoNkrsgFdzjOHeM8Xj8r2TzBejTIKjJlUaPlpDARgSKoWYx7N0vZZdvBYkQ?=
 =?us-ascii?Q?g3VShjIYJQD3Zt1cRNQoPxZr2Mp7C45Gw+21WmGSiAqQQ8K2NmQ+XX688ebf?=
 =?us-ascii?Q?B4iYZPw8mMB4WzS3O0NoXLCWmaEh76WJCrKnZQaY6zzuiVJewEF0kasMiimA?=
 =?us-ascii?Q?LlzrE1R4c5gkGpj4hRA6IkalSDnlPfelsd8I1yXCV0qGtxNlA2TUrxQSi5tq?=
 =?us-ascii?Q?IvDX5XVR7Pq5FnFYe4CRO89mK0Xs/CUBQJfgTmlfbkfXFFJR/VSjsIpA72En?=
 =?us-ascii?Q?AvAHsVnIsWf+9HRRBT+gwYRBx0xBQd+1lm3aZvfESso53LLov4it5P6bTvep?=
 =?us-ascii?Q?GET+7/h5wr6YdeiiQcsbKz4oriy5nqKf/sBhg6skKnI/utvqQJ96Xwx6qgeX?=
 =?us-ascii?Q?y9ApRyQgFWjILeCRpdL2BQksMtH2v8gtq3jxaxbEFdTm6HZ22+TfpDOVK0vQ?=
 =?us-ascii?Q?AYJbOkoItI4LWiiLHRQ0NNAQwphybP8z1/YzIf96uPlLMWUFVSnYlY8chKzH?=
 =?us-ascii?Q?sciSlm0TPMFc9o65aaUGJC9bq9o3CSQYSdv20XNLERhdFUMRVeuCa3mirnL2?=
 =?us-ascii?Q?UIlU1gnpLp7/kEHtx0jTcLp8e3Ac7gRBI2IG8M+uRi1y9PEAQ9yfG6TSVaD6?=
 =?us-ascii?Q?O4G3T7LqOv3Ns/zOiBYVeyVVg7S+kxly2wm3+0fjuyJs7fG2725a7MBhZ4KM?=
 =?us-ascii?Q?VbbdeWdxhNcNnG5U7H0CzEu1wv1316nMeWk+2Ru0ftVapiSES3TG7dpNTPDH?=
 =?us-ascii?Q?bmcSqFqmGl0DsPIE90vrrI0unF3zkMPNXw2JdEz7pH47GsNEgxui5th7KTeP?=
 =?us-ascii?Q?1cRMoSAVP0ciU1PsKBHNGegFKQBbLp/Y5R1cJv6BanFtlYVxgqFIuJqvhrOl?=
 =?us-ascii?Q?OpEgs0sKFVB04v0Q0y1HaWsFsbd90EKgDpDvWJgEx+sRzfXvNfFQs9qmYeBZ?=
 =?us-ascii?Q?HngB72Z0IinnMHrGhxQD/p6/aRQ3SghW/2dA9F2Xh6ccV9zaEoFwBsXPCKhL?=
 =?us-ascii?Q?A61y8Uz1QRMGPLLr5fo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O+PpsMf1H/lb07Uil/U8gfiB5SbLsz4kIil5bVUc3hKPJhIVU6spR0ozzoSS?=
 =?us-ascii?Q?nnZc/xtnXnyFLIFBz5vf4Drpi9mD26ElaweVowQRcPX1dzKs7EtJy9nkcsRQ?=
 =?us-ascii?Q?CTmzG0Z67BdBseG1ZlriohWRBo4vakLxxFJhXuvFxHwXFI4kjrdZyUAOFZup?=
 =?us-ascii?Q?E3Zo3Ul0Y4vx8YWmg6V12Lu41X1zCeB0a/xd7CvCvMA2BhvST91Vtub8l6ew?=
 =?us-ascii?Q?FCYO9x3hSYGwaZs1QdMLx2v0vhCPbkB45fPpGGxk6xx9NJAXpVgadj41L146?=
 =?us-ascii?Q?eVG+/XIfSbAalMKwRdXUlo0mXvzoUN5LWrHl+3ptK5eZR6U7QW6Pj0O09u7A?=
 =?us-ascii?Q?AG8twL82RYc/+fCAgfYMeOrDwFz4UxANQuf+FMSa+kARfgFcD3mXLZUPTO94?=
 =?us-ascii?Q?rzYNBX0HHvVwDb16Jx078ZJQofxJFU4cC8dA6oRNoFHJLXmajElzjnJ4UUVG?=
 =?us-ascii?Q?4HGAjeJSKRlDR0e9UXEUwtow2+7HZ9W84A5I2+wFN26jIFJ2k+g3DJxdlD5i?=
 =?us-ascii?Q?DJ6LDiXYuNJMa0Z/0PoVVNaxHzF8WoZ89RPht3XJktMAV1PFeuhZ3vrM0D7/?=
 =?us-ascii?Q?R1xab/cUH4Jpcw5CPK7X3CT/Er5f23la1CUK5iJm2O9arYwqSGPkxqPft4/Y?=
 =?us-ascii?Q?Hkl1GIxpvnDFuSwqX95+EpjUPzSPgT2eMFSk/Oa8FrbcYWgzI6xpIZ1rPAeT?=
 =?us-ascii?Q?bAD9nMdT/IP8bjcWt3BwhZbsOAmfO0jM+2VjKLF+ZTL0NGeqQTnM1p/1UGxI?=
 =?us-ascii?Q?1RJuYs+ptaQRrpnYJFuMaFk4UUas/lWMztHH9ufL7bfzWg525XCqSerNbvC+?=
 =?us-ascii?Q?HQ43bipkx/76r5c6kb9N0amTdfThBL5ID87pNeAtN8ny7qwlsOXBU/8CG+08?=
 =?us-ascii?Q?Lti+YI+KZD1P88GE1q1tSnDusekEq8cNlMzSF73lrruEm+rXfC4d7M2Yydck?=
 =?us-ascii?Q?4fSVmBIOuu50XWB3bwqT6lB81Ggk1tD2EjO5GCNLBHvLbwZn8S2d8IujT6/7?=
 =?us-ascii?Q?2SbQVwWoXHaixD5cK6jPc9EwJRNCWTe1wMvRRS4r0r6bFWPoLAKpHwpVW4P0?=
 =?us-ascii?Q?YMaPXQKKZv8XoNropnNKFPwXbXoDFBwVq/vDOcT8c4jm4k44GsnCFJRUnuaV?=
 =?us-ascii?Q?P2aW5rA9JjfBCoQRUE7Wzff1zKe5w9r6R4R8Ig53fKFePu3JD3E1Gv2+/JKF?=
 =?us-ascii?Q?Dt89kW1l1p4g/9X6HYiTxSMuWp57bDCBIL3HmTnHV2UwljMXM2L5/oJlMKHK?=
 =?us-ascii?Q?1kItF6UXB+E04yVR7Y3lDIl/++/ahzuCprENRe1tQozfS9glsxFWtf2+UPj7?=
 =?us-ascii?Q?kTezAyS6J52RQQ1MPR97MKClI2la1VkMTJADRLZf4uF9vEh4HGxXuHEN1cS5?=
 =?us-ascii?Q?1LRyZEXfvpwIkD9ObT6PDdH1AR2cGUGJfy6hxjEk/b0o/g9DR4XuoHc+uUAp?=
 =?us-ascii?Q?XV0I63FRWOBmlSJj7aNa16mBL73Qf8bh1NKcxnPS0/krb4DCOjfCwq+gjhnf?=
 =?us-ascii?Q?yRhijt4ukRdOIUlb0NyrwpBxwz97R6KZzIXlDcl5J+jgu3RdgUznAvOvce1+?=
 =?us-ascii?Q?MPXLZr2JhJ89CtVTIDA13yEC8Fyy+6KLtr9RoygAEYYJMMEUkYAI9jyJBAUY?=
 =?us-ascii?Q?OxlddfOYfb3W3IvFsGW+vCUs5Dl66sFKRNeDXj88c3uS8JoFJHLm+rbVAbvj?=
 =?us-ascii?Q?ZFbYy1ibd06DWGg8GqzP1J49EFGIcvGVbYjLiyteqrwk4WKAVsnz5lW0yN3N?=
 =?us-ascii?Q?ERq0dc0QI3s37PevOn/J2YWa1bKKZbk=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f38766-561e-4c0c-2706-08de65a8f725
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 17:55:51.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z15nL2wpetJXgzdLU4iPX5d2jWMZ9l3xg+x/8l5VIW51fki6oAKUUbbnPVw8jL2v//YCwWHbcU0yz3ZTGSj61An31Fgt8MP1w8mpl0vaglc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB6036
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76622-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 590521018A7
X-Rspamd-Action: no action

On 6 Feb 2026, at 12:47, Chuck Lever wrote:

> On Fri, Feb 6, 2026, at 10:09 AM, Benjamin Coddington wrote:
>> NFS clients may bypass restrictive directory permissions by using
>> open_by_handle() (or other available OS system call) to guess the
>> filehandles for files below that directory.
>>
>> In order to harden knfsd servers against this attack, create a method to
>> sign and verify filehandles using siphash as a MAC (Message Authentication
>> Code).  Filehandles that have been signed cannot be tampered with, nor can
>> clients reasonably guess correct filehandles and hashes that may exist in
>> parts of the filesystem they cannot access due to directory permissions.
>>
>> Append the 8 byte siphash to encoded filehandles for exports that have set
>> the "sign_fh" export option.  Filehandles received from clients are
>> verified by comparing the appended hash to the expected hash.  If the MAC
>> does not match the server responds with NFS error _BADHANDLE.  If unsigned
>> filehandles are received for an export with "sign_fh" they are rejected
>> with NFS error _BADHANDLE.
>>
>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>> ---
>>  Documentation/filesystems/nfs/exporting.rst | 85 +++++++++++++++++++++
>>  fs/nfsd/nfsfh.c                             | 64 +++++++++++++++-
>>  2 files changed, 147 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/filesystems/nfs/exporting.rst
>> b/Documentation/filesystems/nfs/exporting.rst
>> index de64d2d002a2..54343f4cc4fd 100644
>> --- a/Documentation/filesystems/nfs/exporting.rst
>> +++ b/Documentation/filesystems/nfs/exporting.rst
>> @@ -238,3 +238,88 @@ following flags are defined:
>>      all of an inode's dirty data on last close. Exports that behave
>> this
>>      way should set EXPORT_OP_FLUSH_ON_CLOSE so that NFSD knows to skip
>>      waiting for writeback when closing such files.
>> +
>> +Signed Filehandles
>> +------------------
>> +
>> +To protect against filehandle guessing attacks, the Linux NFS server
>> can be
>> +configured to sign filehandles with a Message Authentication Code
>> (MAC).
>> +
>> +Standard NFS filehandles are often predictable. If an attacker can
>> guess
>> +a valid filehandle for a file they do not have permission to access via
>> +directory traversal, they may be able to bypass path-based permissions
>> +(though they still remain subject to inode-level permissions).
>> +
>> +Signed filehandles prevent this by appending a MAC to the filehandle
>> +before it is sent to the client. Upon receiving a filehandle back from
>> a
>> +client, the server re-calculates the MAC using its internal key and
>> +verifies it against the one provided. If the signatures do not match,
>> +the server treats the filehandle as invalid (returning
>> NFS[34]ERR_STALE).
>
> The documentation says NFS[34]ERR_STALE, but the code in
> nfsd_set_fh_dentry() returns nfserr_badhandle on MAC failure.
> The commit message also says _BADHANDLE.
>
> Should the code be returning nfserr_stale here to match the
> documentation, or should the documentation say BADHANDLE?
>
> IMHO STALE is the right answer for this purpose.
>
>
>> +
>> +Note that signing filehandles provides integrity and authenticity but
>> +not confidentiality. The contents of the filehandle remain visible to
>> +the client; they simply cannot be forged or modified.
>> +
>> +Configuration
>> +~~~~~~~~~~~~~
>> +
>> +To enable signed filehandles, the administrator must provide a signing
>> +key to the kernel and enable the "sign_fh" export option.
>> +
>> +1. Providing a Key
>> +   The signing key is managed via the nfsd netlink interface. This key
>> +   is per-network-namespace and must be set before any exports using
>> +   "sign_fh" become active.
>> +
>> +2. Export Options
>> +   The feature is controlled on a per-export basis in /etc/exports:
>> +
>> +   sign_fh
>> +     Enables signing for all filehandles generated under this export.
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
>> +  filehandles held by those clients will become invalid, resulting in
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
>> +When adding or removing the "sign_fh" flag from an active export, the
>> +following behaviors should be expected:
>> +
>> ++-------------------+---------------------------------------------------+
>> +| Change            | Result for Existing Clients
>>  |
>> ++===================+===================================================+
>> +| Adding sign_fh    | Clients holding unsigned filehandles will find
>>  |
>> +|                   | them rejected, as the server now expects a
>>  |
>> +|                   | signature.
>>  |
>> ++-------------------+---------------------------------------------------+
>> +| Removing sign_fh  | Clients holding signed filehandles will find
>> them |
>> +|                   | rejected, as the server now expects the
>>  |
>> +|                   | filehandle to end at its traditional boundary
>>  |
>> +|                   | without a MAC.
>>  |
>> ++-------------------+---------------------------------------------------+
>> +
>> +Because filehandles are often cached persistently by clients, adding or
>> +removing this option should generally be done during a scheduled
>> maintenance
>> +window involving a NFS client unmount/remount.
>> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
>> index 68b629fbaaeb..23ca22baa104 100644
>> --- a/fs/nfsd/nfsfh.c
>> +++ b/fs/nfsd/nfsfh.c
>
>> @@ -240,9 +292,14 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst
>> *rqstp, struct net *net,
>>
>>  	fileid_type = fh->fh_fileid_type;
>>
>> -	if (fileid_type == FILEID_ROOT)
>> +	if (fileid_type == FILEID_ROOT) {
>>  		dentry = dget(exp->ex_path.dentry);
>> -	else {
>> +	} else {
>> +		if (exp->ex_flags & NFSEXP_SIGN_FH && fh_verify_mac(fhp, net)) {
>> +			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp, -EKEYREJECTED);
>> +			goto out;
>> +		}
>> +
>>  		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
>>  						data_left, fileid_type, 0,
>>  						nfsd_acceptable, exp);
>
> When a signed filehandle arrives from a client, fh->fh_size
> includes the 8-byte MAC. data_left is computed earlier as
> fh->fh_size / 4, so it includes 2 extra u32 words from the
> MAC.
>
> After fh_verify_mac() succeeds, data_left is passed unchanged
> to exportfs_decode_fh_raw(). The filesystem's fh_to_dentry
> callback receives an fh_len that is 2 words larger than the
> actual file ID data.
>
> Current filesystem implementations only check minimum fh_len,
> so the extra words are harmless in practice. Does data_left
> need to be reduced by sizeof(u64) / 4 after MAC verification
> so that exportfs_decode_fh_raw() receives the correct file ID
> length?

Yes, it sure does -- great catch.  Thanks Chuck.

Ben

