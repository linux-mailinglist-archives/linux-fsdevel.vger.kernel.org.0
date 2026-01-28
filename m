Return-Path: <linux-fsdevel+bounces-75808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCLBFsp+emld7AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 22:25:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B38A91B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 22:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E31530677AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 21:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E370A36AB62;
	Wed, 28 Jan 2026 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="QT7gFl1v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020105.outbound.protection.outlook.com [52.101.61.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1CD36C58F;
	Wed, 28 Jan 2026 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635485; cv=fail; b=buo0m1Q2BVK5cpPKUgs9bmAsKdUUwU4ol+12ag1kJrEtAzvjUnIOTWlyqnNDy5er3w0mVJsrhvik7x4c8s6sS3utOGQ1axYt/SEKu/1sBMtnp78IhhKvjAhuQdYSqbaZom0Xuzh33Sbbm/kmVjMqZA679QjyyTHMNIUVHlZhvKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635485; c=relaxed/simple;
	bh=vOmdYxIpys1IewPZZ2tPjatGdm4n2HBSSn/gjouwD94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cemgrrliEjHLoaSot6IZjd+LszCpfBs9xSPbZgKF3sJHPaukT7UfpDs75lbZOypF4P3V+f9KNox9TIaJd9hmT6sUMxP9PBXVdxyiZeR3dKvoLdShakrFeT+isN2+2iA/KwYGY8lWA/rVa9hJOcuQ/z5FeWtYMyG9rf9YnDBiAM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=QT7gFl1v; arc=fail smtp.client-ip=52.101.61.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3YfNqc2NATC78ZOjEZMTYmeJ3XDMU28gxKkRbxMSLPaSC6vIfdzl+J+A03/sZNjT9tYSFAsx7e4eNvNk5AvzvPNRqRBh8dr8PIRUNIhzjif7P+c14eaAifIzIdShcU+Cf6ukAyMQru7vbMmoxlrX6mfVbKDBfy+CvVJDu07UwWt5jFx9xZO5DwljX92GXF3ligPcGPlPdUdXxjLp9XwpR179NkLUcB6JqCU9isSvjBRdPw3STw/GHY4xrj7lPXYDst3d59UEHO2Wh6OzYSyacgaZ6sw9ulThPn3JdefzNQ7/JwMMKvRP0aJcVn48F0+HmMmG3PZ/otRtU1qk3XSgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUXXjra1HfAfCgRzRLmI2MjpRkE724AXTJ43T9C0TEg=;
 b=GEPGzAp4YRqM4Y8B/z4EyBAvtvvSHvLnaLCLYomhcdnOJYB8Tgt1x4fnRzdvNwktNJb4XuTiYcQAjVpeGt4I6x4f8yRElVavDi72B76ZhRO1GzK7s3ByujD1J+codTnRFqiyyK8PxyT3FpacXbTyaZvQDQbgJMHIxB3YnPjHdixhneSEvffydpaVVKOUfu5s3mEVQFtVpSFm/4CA24nsmNRG5RpPW7H5gHWD/aJgcpLnrUCTgNBICOpuk5Q0IRDsJF7xUhbxSToYT85XdAdaCEwupIOiKMooJRWYn9C+qNw3q1gSR0thd4hoc3iryB4tJi77/oZrZvhJR2n4Lshghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUXXjra1HfAfCgRzRLmI2MjpRkE724AXTJ43T9C0TEg=;
 b=QT7gFl1vS+UW1CfxsSFW9WTb4u54HAsJjmNWJmhoOEksxuxdr8WWfcYKiGP40heBur3hK1CRI2hMBeMxpLe2s/G2GEMVZFjUYb7NJ8gNeE3/pCP16eSfFKXtwxr8ZyUWbZ9S0UBn8PFKkYLmJFVxa/xeScYEiVo2MdjxWgqaPMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 PH0PR13MB4858.namprd13.prod.outlook.com (2603:10b6:510:98::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.7; Wed, 28 Jan 2026 21:24:39 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 21:24:39 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, NeilBrown <neil@brown.name>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 3/3] NFSD: Sign filehandles
Date: Wed, 28 Jan 2026 16:24:35 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <5C6C8838-9244-476A-87CF-123F4822F459@hammerspace.com>
In-Reply-To: <041a37d8-c114-4ac0-875d-022e9d07aac8@kernel.org>
References: <> <e545c35e-31fc-4069-8d83-1f9585e82532@app.fastmail.com>
 <176921979948.16766.5458950508894093690@noble.neil.brown.name>
 <686CBEE5-D524-409D-8508-D3D48706CC02@hammerspace.com>
 <77e7a645-66bd-4ce2-b963-2a2488595b00@kernel.org>
 <8be0a065a84bed02735141b4333e9c49a2ab0c90.camel@kernel.org>
 <33c02e5a-03e7-42ef-8ccd-790a9b29a763@kernel.org>
 <D3263C1D-A15E-48EC-B05A-8DC6A0C2B37A@hammerspace.com>
 <041a37d8-c114-4ac0-875d-022e9d07aac8@kernel.org>
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0055.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::8) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|PH0PR13MB4858:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f509039-2416-4000-c921-08de5eb3a4cd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+K3inGQT9A/Gbfu3hKxB1n8P2h7nVOoI2WlZQ2qSkfoi7YnY2bRLOyphiGGx?=
 =?us-ascii?Q?gNmsD4TdL/g5Dil1Qwch/ntQ8ful2LmZd6ZXIwMIgQILuJ7We+almATUi1DV?=
 =?us-ascii?Q?yNuRCLcZH8wY0fhgRhcP/bFUisxaFYdaVE3dD9FfHfNpMiaLdE0JqJW8gjvy?=
 =?us-ascii?Q?chhmW71xBQFmKeObUlDuayZ7ZmgelUKl6rGXmzJnde00a9PyZcl4Q7vSn6JI?=
 =?us-ascii?Q?ZTuMphLWgmzHf5piEOsn+FoDoyS8leSNFmMZRVRVFr4vkz/RswqGnI2IWxmZ?=
 =?us-ascii?Q?JCq4dJ6NW8GF6qMktqYVbpl3OLnSbFvrdP34NUpcXtlXRtELjBF8fa9kymkO?=
 =?us-ascii?Q?BpLEFO3MQOChZmwjbpxIlWi+mb36JiSg8RwIGY7dVOFyI1pzSWEVVimWHVvc?=
 =?us-ascii?Q?IriJeiNd0FN0bO+l50XI95Ea0q3VgG4+Zl+V2eeHpGYZpHTwtBTRljVKASqk?=
 =?us-ascii?Q?mfHXhucP8oVCnDl26W3SCwLS5hfx3OdmachxJxb2z9Pz4N8zBwBabeI7sqFB?=
 =?us-ascii?Q?dnQTyjTwvuJr5GpKiNJt86R/N6As5YTqloOobF5Hl6p8Z9yDLyXSP78I+DbG?=
 =?us-ascii?Q?FbTBcoI0VommnyP0Ty3OpbzVNLMIEx7l+9C6G7T5c14VPWObR+9fe7zuP+hh?=
 =?us-ascii?Q?vX5wwOiabdjL7gTRkh3TXjMfQ1yarE9GOigK9iGyLQtY1LtGnPOY+ElpUbf+?=
 =?us-ascii?Q?9vyaPNa8BH8hOlCJZBI/aLClZRXErLZxyagD1Qyc1/c/XTU3t352FmpA+L4N?=
 =?us-ascii?Q?xtVCb/1qQb6Hb2Tfm9sme+5UmjeVYdW9QPtOgTzBtrAttMQjd6WijG7jzUli?=
 =?us-ascii?Q?V7JqBGPjNf/mkSFpY8h5pe+cAoIe/4PE2I+hrDtLWfLszvzpVCWPbdhOj0Zx?=
 =?us-ascii?Q?20AW3Ue2SmY2d5R/HsCrdtVplLFBjCX4xSSQF1HP+9RAJKlCrabU4UkcUjP1?=
 =?us-ascii?Q?22COeJuSMXgBfKAj7kkiLk9pvMHgq/qcloraVzn8WozrJB8tiQ8tNvKbB67d?=
 =?us-ascii?Q?VqGrrzkU/8E+rzhWf1HMSyoHhi1Z6pIa3T91P2Km87Cp6yntzCfPBKJBKB7F?=
 =?us-ascii?Q?fRAe+GXzPMXolUD6+0QiyqoLNC0/W7SdH9/hmZrrosD09VsQjXRiDAsyL5Bv?=
 =?us-ascii?Q?wtX92c/jW8amXnh3y3kMV7b3DePss7fIRa7KS5XDS3V9C2XiSG2dqnA1n4kK?=
 =?us-ascii?Q?ymnBBtCDQiygtqZpDq4RoXJhUJ3iwusTWvFSXn9lJXQHlDJRUeMr2TZcZiLr?=
 =?us-ascii?Q?ioB5F6WV6rlMeAULG3caPRrsAfItB8/DO6nRpvMrFqEjK6pXxeJN7aMq2PGc?=
 =?us-ascii?Q?M5XgbkB7vRgEPbwI25/lvFWkcn7dNbZ2bSp43jbwGs7wcamUG7VbWNon5p7g?=
 =?us-ascii?Q?Esi4ENI+dXtNm5FOmhqTOZ4Gpf6TUwVGsHyUkDoIqBP6JdL8t5vy0NbT2JoA?=
 =?us-ascii?Q?91Xjjw8+RBvx4g7ymPr0eKVxyy9qNgXA4RCAcXX4A6a33MWc3Iqsw36Iaadj?=
 =?us-ascii?Q?YVu7R1OyPdFpSjZ2hLIwzaZW9ln4kUH2128knC78YppheMTjfz4cXT3WsSFr?=
 =?us-ascii?Q?Oe94gcY2Enr798dRI4s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Awx4Ax8x/jETQpdiAukVQ9q3zJKmAOoCNb5G+1ZlHCRhBL6qJzMj/HXxUivI?=
 =?us-ascii?Q?BF0gORH/O/x1oGG/0MAoUBBfW7iWuOfjELhn0vKFVP74b113hYJQxd10gkJN?=
 =?us-ascii?Q?XqMpdVJ7DBbZM38OAww9X8f3qNI7ltHlBpbgK/5Vx7RzCPfnFHqFn3zo6iKk?=
 =?us-ascii?Q?TCtje831LQ2AGDpFzBsSzr2NQtdS9y/Zsx4orEOXHZM57Tv/PJZYTMvXvFwG?=
 =?us-ascii?Q?rjLaU7GqMByZHHp9OealDKiER4OPYtk+qKUMg5BcXHKcx4dpgZp6btEa3Usn?=
 =?us-ascii?Q?xLNJ599HBk7eRxhm6+Xp4xCWV8C1BADAWsWRe6tLCQczODjhhPP9r3hMmBxc?=
 =?us-ascii?Q?vNWon3sGumW9/3emjKREKEpRERoNi8uwUwLC6CxEhlx/DrKfGVW3R1kLV8sW?=
 =?us-ascii?Q?JVo1+bp2VJGlEqjicJUpyxPK7f+Vp1tuJP/YB+46vSJcK+FHp08tnbK284zu?=
 =?us-ascii?Q?Ih1dDLiP5K6210ilmu8Cb1hFc6QjYgLGPT/AlRRXUnfebfVSpDpZ7Vb6Ay4L?=
 =?us-ascii?Q?HW3uJUttQVgCHXzpDVKpXNIWBDmzOZpXGM7raZELSSlIESV0WCWkwJG3OXoq?=
 =?us-ascii?Q?Nzf2HqlUC700q3LVwV8c52s5Ztf1/Cz8gXNaRwg3iAttQQFOL4bA+XdwsOd2?=
 =?us-ascii?Q?FJOM8H55AhpNjeCNieJE0ElaedP+D0Li3JxyYsGfEA3pp70q5ORq7ufzZQIV?=
 =?us-ascii?Q?sddl/nrSPIhPLq5WnPocdyRXkCNp+f0+zZejdVJGVXjNnEajJ1lYJn+lnnVV?=
 =?us-ascii?Q?dGAYADcy9K3pzsF3HM5kFnQyz1PnvN/mQCL7ArlijRURW2U4rw6sxXs0oMDY?=
 =?us-ascii?Q?C+eypaKWAMonZJjiqXB93xiybCKZen4wtDDJRC7oSEHlHmLjQ5IOcq1bOEWv?=
 =?us-ascii?Q?kr+jL/IjZH5EEZxu5E1Y7SM4ka/a2yTh3OXE7wkueFzA/VNEb9xP2emoXBCd?=
 =?us-ascii?Q?Eqf3U6kYli9suaIUp5/PQ631/J2jyssPQdDWneQlLcAsxwvq8i1yT9C0cH7B?=
 =?us-ascii?Q?etj+O+Dd8+XwDGgcJ2c5iGFwhzC2EEtpeCjyZzs53PRD6Du1zUr0AQmJVcXW?=
 =?us-ascii?Q?XFA2d4XTyjQDRhsnvv01GGEKds/zp4AZRBj5MakUwhjsoAmN+KZ6agVnqffs?=
 =?us-ascii?Q?HEczqqWHJcYF/tyDAWvhiebD7Suzr2MB/kIH0/9LxlOK4jmjAD+ZpjRy0ZNm?=
 =?us-ascii?Q?i66NBvBisnpkwzAaBmy4KivnDxzfHi0ysa3RpaoRoBPaLNcj7BF58fMuY2sg?=
 =?us-ascii?Q?bFG+SnsTS8r2FgyIM6lHqojb0CAU4JoKy1X25m7fOyfyursYFVny8J/QPG7L?=
 =?us-ascii?Q?P/sdmaeAKzV0hXbPbTuVFfMqxHWAVF4Rrkz53piaafaFPOqi0+GDZIoMYHtk?=
 =?us-ascii?Q?XToG5I2xcZVykAxaCX5suHAOVukcsFXhXVvm2CFUbqfsYt4thoKRusDikxIT?=
 =?us-ascii?Q?gMWwNXpSrwwNPm9DqxQZA9ACr8ucyaf+MmadrqD+EqzNz+uvop3+GwnWP7Dl?=
 =?us-ascii?Q?EEVPDwYYhNUR9MmQxGiv5SxrBLtdxVQtOQSoleOZVvgGgAJRPSRjUZfnpQu9?=
 =?us-ascii?Q?d4EDO7VAgEm5p+zPXcKhfjkI/tpIfkZ8FR71XEq2weIy8aCjQiBkVEV3k/KR?=
 =?us-ascii?Q?48NO2Vm9cSw95TZ4GF0p71PBpMMUmQHwkcrKdvrdnej4+OK09zoVSAqy6Sb2?=
 =?us-ascii?Q?meZTZ2HHD3giEVCVw3qJm/XwwaawWTtRSXbfLSe4Ez8jnxMGC323lGOV17k6?=
 =?us-ascii?Q?9DmOr1SkZ1BpdOhMRQkgmOy0CIWknYQ=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f509039-2416-4000-c921-08de5eb3a4cd
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 21:24:39.2147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: in1nR9INICCYzhRgk25SXJeW0wwlfc1BVKRbmWTpQWRg2vIigxyjeWjPqG6lWuxHeRsPTjqwsXawSbAjhrAjD3349aSGhWmzYvEWfS7fkAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4858
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
	FREEMAIL_CC(0.00)[kernel.org,brown.name,oracle.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75808-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim]
X-Rspamd-Queue-Id: C0B38A91B2
X-Rspamd-Action: no action

On 28 Jan 2026, at 9:41, Chuck Lever wrote:

> On 1/26/26 1:22 PM, Benjamin Coddington wrote:
>> On 24 Jan 2026, at 14:48, Chuck Lever wrote:
>>
>>> I can't recall if Wireshark is smart enough to introspect Linux NFSD
>>> file handles (I thought it could). It would be sensible to have some
>>> Wireshark update code in hand before making the final decision about
>>> keeping the new auth_type.
>>
>> I've gone digging and wireshark has a surprising amount of filehandle
>> dissection code - it currently can "Decode As:"
>>
>> dissect_fhandle_data_SVR4
>> dissect_fhandle_data_LINUX_KNFSD_LE
>> dissect_fhandle_data_LINUX_NFSD_LE
>> dissect_fhandle_data_NETAPP
>> dissect_fhandle_data_NETAPP_V4
>> dissect_fhandle_data_NETAPP_GX_v3
>> dissect_fhandle_data_LINUX_KNFSD_NEW
>> dissect_fhandle_data_GLUSTER
>> dissect_fhandle_data_DCACHE
>> dissect_fhandle_data_PRIMARY_DATA
>> dissect_fhandle_data_CELERRA_VNX
>> dissect_fhandle_data_unknown
>>
>> .. almost all with finer grained filehandle components.  I certainly can add
>> patches to parse FH_AT_MAC for the linux(s) decoders, but I admit I don't
>> have any use case.
>>
>> I'm completely neutral on keeping FH_AT_MAC at this point.
>
> If we can't find a use case or need for something, the usual practice is
> to remove it from your patches until we have one.
>
> Is anyone working on Wireshark patches to handle signed Linux file
> handles in some kind of sensible way?

Well the other use-case might just be for those pynfs tests you were asking
for.  Without FH_AT_MAC, its tricky for pynfs to know if its getting signed
filehandles or not.

The other thing about those pynfs tests is that they get awfully linux
specific - requiring new tooling to setup and change the export option.

Ben

