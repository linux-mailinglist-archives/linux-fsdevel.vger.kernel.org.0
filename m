Return-Path: <linux-fsdevel+bounces-76590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNUsLYEFhmkRJQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 16:15:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D643FF94E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 16:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0BE9301E235
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 15:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1753D28134F;
	Fri,  6 Feb 2026 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="ZLEZ1F/3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023130.outbound.protection.outlook.com [40.93.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9779F27CB02;
	Fri,  6 Feb 2026 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390577; cv=fail; b=Xaa3B3MJfYiwSH7RakYQGBTkRkyIBjPuK+WKNaSPQ9PIUc12f4ie7tRz4MeeJXKFUG7SHm4hiafbjqQdCme7FwXckJ36U9Ewp1ntrWXmXsMBSw7dniMSCmv2Mo6wZ8nMHCsn+PcIuKL87hts7BLjt4nLgeRfvxj9tzp/SD+RcJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390577; c=relaxed/simple;
	bh=OEXSBmfl+WM2zhdTrH9EJIhQfsz2Cjt0+MzFF9jNWu8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H80zb97Pg7UCLuKA5i77r4j6cWvdTjIZkpXmg3Bq/61/nwNX8jomrksEYl+HS9eshTwAk+0jab68RUt4aUOzpTtDj3zmYMPN5/6JEsxVQe+GYr+Ef8+WLtj9pqdzxi9VSiYj/4mvzxK538AsAE56BAwvp0QwaRN5Z4yv64NglLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=ZLEZ1F/3; arc=fail smtp.client-ip=40.93.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQtgQ8YL/kXernF/nlukIDBjhfYtowkQnZ/CsQU9rrfEwHyweSgaEIIYejCxLQYixxGgJ7EnuayQZmdagzRJnVrNTchSQV1evJopknUhie688iZB+kQCY0fk6E5u0i+morIvxoVRp7IKg5IOKSf4/HDrGZdvUAIu1xDyMZjgIpzpwRsca+S/D8fNfRc4ssSZrfGG3v3rHX1wlXSHYbO3TQS1hXH49+ZsY0lCxYyLV1PBm15JscMuynXNWJ1nI4mW1Xzu7S+NgK+UlPA+S1SB58QNjKBC5pgPPJucSV2N2FiUCfXMAiTydmvkRppG5VC/QWbCKaYtR38iRtmG522ONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nb7HFp+X7uqywYssUNEobZViy2FFZvTjRSOhCF8TbOo=;
 b=Gtzg+dGS3o3rQtOUCtm4zotOA0m0ICfgjo0bDqUlGuCQSZkAaF70r+s3GTDEl0J6mLt3+nt0ArPhHVDw01J+7tK0plO1Y0qVWDKFQfeYw0b/7IiEvsU5XEVsTuTGjShSNBnNJTw8H7oYaJJPkuju1iW4JXawzDkgN457/bdzfBMEiSWb627PO4qSMa+WmF0G640ZwtQyRBBo4AqE3X2RcaPT/T+I2Io8xgnck/as4wGdYspcy0ptxZvURURhxLZygXqIGPWt3AOUPZ+bXfNKB3KuMZ2A9rB/otOYwYINveAI+a9CSHxwnEjkW4ne7U0AWPzHPz8hkpVa3oSRlzpe3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nb7HFp+X7uqywYssUNEobZViy2FFZvTjRSOhCF8TbOo=;
 b=ZLEZ1F/3QFe0WAnMu0rahiXCn+6q8pUGYfdr77djV8xsODaiohK0qxKebRX+A7TgGS7KEb3WPUW4FyiDFH8T5uMcA+XoqBhUted/edgG+ujegcIdA8X1g2KSosHt2LRocnH1E3YMfmGFQXCQ1SwAd3yPXCXqkrkESYz4opACVu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 PH0PR13MB6154.namprd13.prod.outlook.com (2603:10b6:510:293::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 15:09:30 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9564.016; Fri, 6 Feb 2026
 15:09:30 +0000
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
Subject: [PATCH v4 0/3] kNFSD Signed Filehandles
Date: Fri,  6 Feb 2026 10:09:22 -0500
Message-ID: <cover.1770390036.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
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
X-MS-Office365-Filtering-Correlation-Id: a0de226a-25dd-4b11-4f02-08de6591b9f5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+088oK1iWtZO4VN5dPKpMrs7kFC0s/+DOMxks93FZOjGZzrTgd5pc7sfFahb?=
 =?us-ascii?Q?VePEAQOiE3D9eIyZu7muMI+9Ms7Mb94Wzy+aj0HfyWkjhC0YK145G2xT8t4L?=
 =?us-ascii?Q?Jx5FMUrI5Fkxoti6xndo0CMR9qOJmolWPShJrU1hkvpDIEClOoIN4uLWfArj?=
 =?us-ascii?Q?pdpn4F6f7eUYEppRUsHG5Vd+3XMbkyytPR4eZm5/ZyySAWMBXda7LAc+eXwB?=
 =?us-ascii?Q?8w2o5B8HliolBWdgqADNO/879QNm5fMt6ZwUrb19xtjq3qJtFE71tG2m98ny?=
 =?us-ascii?Q?247K876CKpwanDwC5NNfQqHxIVeZYPYuRr+9XskUWf+zsePyb9GUkRKU1bJ9?=
 =?us-ascii?Q?nR9FDUMMOLGtlbUfweBa2p05NPyv83sv0bZ9d3+NbAXswYmW2eDFrC3pIxaO?=
 =?us-ascii?Q?uofpt3G+M7iLceO3FBjixqg+mX4tqZm6KxWNtuvxaRRAlHrAaWa6I33pUxzR?=
 =?us-ascii?Q?MKuMqUlghIn8E6ExpK5ZiVeiuXpF/j6gm7DmrMNnFSA4qXp1Sd4cxx2Yf9k1?=
 =?us-ascii?Q?n3kPFLQ3LJ7RwMaXRyyWD50QI26Ywt6gjIfS2X98poeXopoPSBAp/41LtJxq?=
 =?us-ascii?Q?W0M4rvulP1jWWtAi5wKcEfsAANLoswUkduGjarigofUUzCFqvQGFQfiHdSRg?=
 =?us-ascii?Q?nEoHPhz3o/IbUTtqb9oaxS8b1mLLNbXOStVJcKVe7ML8xBqmbYz9iXIWeDfp?=
 =?us-ascii?Q?QGdCSgb5fk/aygGSx3yqFryhU32iUAV0z4bX0pqmyiLKAA1bzthWUZIRoDYE?=
 =?us-ascii?Q?maUfev9vpvToTHV86tvYmSAU2u97VHVWt/KByMqzgv3hhdUezv2M4wBGaolV?=
 =?us-ascii?Q?5tqLhkBK+lcewL2pJAXzLpYt/uYyqJ2U/jbaLX85BwwclCP7sQaCpwMqbO0z?=
 =?us-ascii?Q?UqTFEwalb9VDEq3Oh2okHamwFOTKSq3SKs+0CDLmXB3yKsAD3qVbTEO+veJg?=
 =?us-ascii?Q?hgst34qXU0bzoIvSltFx43BYDx0RGt9DXM1I4v00MhVQQGz4aIjo2sOARUQj?=
 =?us-ascii?Q?dkCA+UYwyDrxZ9TwVSbZDOtvSgLHvppdIAxrAViBAFA9u8NpWEolckl8imjR?=
 =?us-ascii?Q?ubzFZN0yzv3OQExiwNwbtL3LUtZUscBaQI6rliXJpJPfKDDU0HOfpor5toBi?=
 =?us-ascii?Q?2xZBpzuSHRLn93xN1jCXd8yVgqBP/LVlohvC91rg1dfvEoYDUvIAQXg6uOWJ?=
 =?us-ascii?Q?XUNXYabFC93fkj0zLwkGXRPudK2HYFUACJO5wONR7ZaL8mUtDiYKODjWAE1b?=
 =?us-ascii?Q?8/CwZI4KJIeYbVu+dXSBYD5iq6rcR9ndKPyQxKqrMqascZmewW7x9ewIIBqX?=
 =?us-ascii?Q?r2V2LPTllBXzaYbAYbvFBaH6urry9flc1AZKRpZNjxvj3nFyUDcwpm7dZqE0?=
 =?us-ascii?Q?7RrQBggd/eONN8llpOkJzWvHDQ0gA46QDv1Xym1gQqSvyi7ihu7mucAgIoAM?=
 =?us-ascii?Q?JkucpTaCYTu04efgVOoB0zJ3iNw7gCoAH6BCvfUu85yNdP6N1cEgT9dvB0T4?=
 =?us-ascii?Q?mbsckJsbKl9xgstkLMbbMomtoIc9PK69B3bOoZGOyxDCvyAoNR9Cs+rOl2DU?=
 =?us-ascii?Q?RIng8f6lA2cCUC9l4k0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ryl9eXtoUNIFAp3AjuDNQ2vPNToMxROgypm06Zqo8GxHhGcb5yiqqzAWAr2o?=
 =?us-ascii?Q?bBbpSmzOLB8l7twLaai6zHNLTxFIdeMIY8X71qJDK0Yehp4Xy8JcooPFd81z?=
 =?us-ascii?Q?Aa+rKFXJXlHvtXGemnSanhQTk/j3akkjpqLvbFi8R8z20EdxJY9YfWc+vLGc?=
 =?us-ascii?Q?jbOtpvrz8Yud9PFLSFAokeOlJ8sCkMztnTf3D19Yt9obkEPGITd6nAEEu+QL?=
 =?us-ascii?Q?ATN51XihRm2mskp2mRpTSUWKB/BDnSr3cg/yU7OQlqMH2Ki+0hHZ1NFavVic?=
 =?us-ascii?Q?ZR/n64JvpHkraa9WjVXjUDcPQwRKiVAFpk7m4oPNjMivbilSaEFiQJW/6SN8?=
 =?us-ascii?Q?NaOlSgNJk68ZZT0OYXAJPMxV5vjQrbGDxN6RdHc7u/yBpNu0LzR4m3d3Qf3j?=
 =?us-ascii?Q?sIhaDN0ILt3y3O/8LRSfAK3fbqrjVNWe+1+svo7BxGjnVFcRK9jFOZDHpnre?=
 =?us-ascii?Q?qzTKJJ6sVJfKq+bOCAiACz9BlHE7HYyR77r7dnBVc3iW9czV9zQ4OtnMEhA4?=
 =?us-ascii?Q?hUzJAjkGgzyUgVPhVTe9ngikJSHpDOVrujufMqzzADZr3DiBci7znz89vK7J?=
 =?us-ascii?Q?Aaq+CYlh7QA3s87yePvD81mDmgihTj+wYmRymArt0g106EL5u8j7wlBgRnJ+?=
 =?us-ascii?Q?8vEth7EFIDOFpj7MBJv6HDZKz8+cJY0sLRSaIawK6WGulBbeJs65Qjx14L/Y?=
 =?us-ascii?Q?sWIIO3GF+Nq8Bt6PpVhPqb+rJzDo47rbqjgU3M5DktuLjynEaKPmUQO/zQbh?=
 =?us-ascii?Q?O4rQNgaMf/aWhdnQxIRBHT11uPz1kyEv4SOOMTQYmgQUrNrfL1SQXRoHg6OG?=
 =?us-ascii?Q?lIesTKGrzD/dw6IAupKi71Tcd3UVV4nxHduiMQVUzTZEdctYrZ3DL/jVR0J6?=
 =?us-ascii?Q?BMnKjy6PoQ+lrwXSEThIdp6U7iHkClxM+N4AA/sJgQiAhAmnDFC25uhsAZ71?=
 =?us-ascii?Q?ek99n7NKLw61SuK3osvOhRFZWVZ76Oa1NyN0BqI9D6UTTPfvfMoAvr/kw4JY?=
 =?us-ascii?Q?nMyNr179aKf8mppvzQzpG/IUhGfafmubdPMvNeLvnWFl9E6GIC4fy9H+/CDk?=
 =?us-ascii?Q?pPQKYabNr9doebwAwUg0bCphcBOmNxMBTGktTv8LMn6Ltke/CYKl+sIIHOiq?=
 =?us-ascii?Q?3c4ppqSyWHAja0xxEVJvMrZz/2lWPqx8Ml5PQZ70CvkdQakkddpGY031yCsk?=
 =?us-ascii?Q?AIga0WYefeJfQZrtCuRGhT+7SWe9PoJYju2NEuRhQTwNwHOvi/ICApr6kzH+?=
 =?us-ascii?Q?KhGdDFaov2rqZa/zfw7cgK/+awNz8jVQPfY8rR+1DayzxeSe2m9yqLUixNww?=
 =?us-ascii?Q?jRAxISRjCwyGQhte/CYgC5XDFdqz5z2xQRF2rvm988qpd6eK4FA+x0SSf8Og?=
 =?us-ascii?Q?IMz3gjF2FKVTdz8sAhEHzxmuTT+xpeZOHkstMSEXGQU3oMUNUQbSsaDaIUNh?=
 =?us-ascii?Q?C+ABg1uCX+i/6JaWNiE8Puo5nreSfCwH+F5MKN2Getv0bnpil4MfkZbfV4Tq?=
 =?us-ascii?Q?wYuiYedaZ04nk36TioGot8+Mhi0X4mHmLBKUUoZ4sIkloj4jKHXJEov5T6ls?=
 =?us-ascii?Q?fUyCXz5fm3TPsFG/o7rSyQrgr+lka49+ZmNW7kr07S5/SoYaQ63oD1nsdcDh?=
 =?us-ascii?Q?+FTkwO39SMe6FMEM7ikD/Ce2Ew7Ll5n6UwwJT9BSLQAQd4OMMvXpNY7I+k4L?=
 =?us-ascii?Q?M5HeC2ZzWAVbV0q7sT1KHmjKj8SM2aaF6wCe61WEeU1ETKBp2xg3fFQosrR0?=
 =?us-ascii?Q?o0inkiHWGi5MkvjkEoP345ErRgJpjfw=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0de226a-25dd-4b11-4f02-08de6591b9f5
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 15:09:29.9875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9zcFtd3W4okNPH/5mpTAVbmSpXK+KgoYnnYGLGcb4bEip7LMN2jivcwnMQ2ALf0E+DD/goY75B18x2G2KfDlw0buaLF86mRVKqI3vfQhnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6154
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-76590-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.980];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:mid,hammerspace.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D643FF94E
X-Rspamd-Action: no action

The following series enables the linux NFS server to add a Message
Authentication Code (MAC) to the filehandles it gives to clients.  This
provides additional protection to the exported filesystem against filehandle
guessing attacks.

Filesystems generate their own filehandles through the export_operation
"encode_fh" and a filehandle provides sufficient access to open a file
without needing to perform a lookup.  A trusted NFS client holding a valid
filehandle can remotely access the corresponding file without reference to
access-path restrictions that might be imposed by the ancestor directories
or the server exports.

In order to acquire a filehandle, you must perform lookup operations on the
parent directory(ies), and the permissions on those directories may prohibit
you from walking into them to find the files within.  This would normally be
considered sufficient protection on a local filesystem to prohibit users
from accessing those files, however when the filesystem is exported via NFS
an exported file can be accessed whenever the NFS server is presented with
the correct filehandle, which can be guessed or acquired by means other than
LOOKUP.

Filehandles are easy to guess because they are well-formed.  The
open_by_handle_at(2) man page contains an example C program
(t_name_to_handle_at.c) that can display a filehandle given a path.  Here's
an example filehandle from a fairly modern XFS:

# ./t_name_to_handle_at /exports/foo 
57
12 129    99 00 00 00 00 00 00 00 b4 10 0b 8c

          ^---------  filehandle  ----------^
          ^------- inode -------^ ^-- gen --^

This filehandle consists of a 64-bit inode number and 32-bit generation
number.  Because the handle is well-formed, its easy to fabricate
filehandles that match other files within the same filesystem.  You can
simply insert inode numbers and iterate on the generation number.
Eventually you'll be able to access the file using open_by_handle_at(2).
For a local system, open_by_handle_at(2) requires CAP_DAC_READ_SEARCH, which
protects against guessing attacks by unprivileged users.

Simple testing confirms that the correct generation number can be found
within ~1200 minutes using open_by_handle_at() over NFS on a local system
and it is estimated that adding network delay with genuine NFS calls may
only increase this to around 24 hours.

In contrast to a local user using open_by_handle(2), the NFS server must
permissively allow remote clients to open by filehandle without being able
to check or trust the remote caller's access. Therefore additional
protection against this attack is needed for NFS case.  We propose to sign
filehandles by appending an 8-byte MAC which is the siphash of the
filehandle from a key set from the nfs-utilities.  NFS server can then
ensure that guessing a valid filehandle+MAC is practically impossible
without knowledge of the MAC's key.  The NFS server performs optional
signing by possessing a key set from userspace and having the "sign_fh"
export option.

Because filehandles are long-lived, and there's no method for expiring them,
the server's key should be set once and not changed.  It also should be
persisted across restarts.  The methods to set the key allow only setting it
once, afterward it cannot be changed.  A separate patchset for nfs-utils
contains the userspace changes required to set the server's key.

I had planned on adding additional work to enable the server to check whether the
8-byte MAC will overflow maximum filehandle length for the protocol at
export time.  There could be some filesystems with 40-byte fileid and
24-byte fsid which would break NFSv3's 64-byte filehandle maximum with an
8-byte MAC appended.  The server should refuse to export those filesystems
when "sign_fh" is requested.  However, the way the export caches work (the
server may not even be running when a user sets up the export) its
impossible to do this check at export time.  Instead, the server will refuse
to give out filehandles at mount time and emit a pr_warn().

Thanks for any comments and critique.

Changes from encrypt_fh posting:
https://lore.kernel.org/linux-nfs/510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com
	- sign filehandles instead of encrypt them (Eric Biggers)
	- fix the NFSEXP_ macros, specifically NFSEXP_ALLFLAGS (NeilBrown)
	- rebase onto cel/nfsd-next (Chuck Lever)
	- condensed/clarified problem explantion (thanks Chuck Lever)
	- add nfsctl file "fh_key" for rpc.nfsd to also set the key

Changes from v1 posting:
https://lore.kernel.org/linux-nfs/cover.1768573690.git.bcodding@hammerspace.com
	- remove fh_fileid_offset() (Chuck Lever)
	- fix pr_warns, fix memcmp (Chuck Lever)
	- remove incorrect rootfh comment (NeilBrown)
	- make fh_key setting an optional attr to threads verb (Jeff Layton)
	- drop BIT() EXP_ flag conversion
	- cover-letter tune-ups (NeilBrown, Chuck Lever)
	- fix NFSEXP_ALLFLAGS on 2/3
	- cast fh->fh_size + sizeof(hash) result to int (avoid x86_64 WARNING)
	- move MAC signing into __fh_update() (Chuck Lever)

Changes from v2 posting:
https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hammerspace.com
	- more cover-letter detail (NeilBrown)
	- Documentation/filesystems/nfs/exporting.rst section (Jeff Layton)
	- fix key copy (Eric Biggers)
	- use NFSD_A_SERVER_MAX (NeilBrown)
	- remove procfs fh_key interface (Chuck Lever)
	- remove FH_AT_MAC (Chuck Lever)
	- allow fh_key change when server is not running (Chuck/Jeff)
	- accept fh_key as netlink attribute instead of command (Jeff Layton)

Changes from v3 posting:
https://lore.kernel.org/linux-nfs/cover.1770046529.git.bcodding@hammerspace.com
	- /actually/ fix up endianness problems (Eric Biggers)
	- comment typo
	- fix Documentation underline warnings
	- fix possible uninitialized fh_key var

Benjamin Coddington (3):
  NFSD: Add a key for signing filehandles
  NFSD/export: Add sign_fh export option
  NFSD: Sign filehandles

 Documentation/filesystems/nfs/exporting.rst | 85 +++++++++++++++++++++
 Documentation/netlink/specs/nfsd.yaml       |  6 ++
 fs/nfsd/export.c                            |  5 +-
 fs/nfsd/netlink.c                           |  5 +-
 fs/nfsd/netns.h                             |  2 +
 fs/nfsd/nfsctl.c                            | 37 ++++++++-
 fs/nfsd/nfsfh.c                             | 64 +++++++++++++++-
 fs/nfsd/trace.h                             | 25 ++++++
 include/uapi/linux/nfsd/export.h            |  4 +-
 include/uapi/linux/nfsd_netlink.h           |  1 +
 10 files changed, 225 insertions(+), 9 deletions(-)


base-commit: e3934bbd57c73b3835a77562ca47b5fbc6f34287
-- 
2.50.1


