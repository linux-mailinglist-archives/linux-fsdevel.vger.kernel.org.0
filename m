Return-Path: <linux-fsdevel+bounces-46187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B73A8404E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 12:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B1C1B82310
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 10:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C473B26B943;
	Thu, 10 Apr 2025 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="KhVhNk4E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E91326FA4F
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744279752; cv=fail; b=YTEwDNjTCtw32jvH+LgmnbCgyjaAF7JvVImIE6JdPkep/uTbAfb4HFsfDFXQbKYI/pbGmbHh246saxIeDZ5KHL3C/8noKQZ06HzgFDEETIaL5usp/9+L7a06CXPnSO8PeCI0ZzwWbg7G58VZD+eLYL+ZONpCKf80+UVd7Ecc6s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744279752; c=relaxed/simple;
	bh=X5uzHe6RKdHVtcPq2JbohvxG8jagfhLo8cGSl2OnVtk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jKpbsxwdidgxiAKCV0HgZMxFIZWs326vJYNbKLzdxAxzS8FvfUTmUgq80ArflCf45TGYshoatE8bjFbRrkwjpf60Szw3BFGWmqNoL2WFf80ne8vXoPnO36A/5IuHYJjFDL6IOfAwuNNhhXf132492AWUe+m4O/1b6Rp+zfrGTzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=KhVhNk4E; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A6Tggi005092;
	Thu, 10 Apr 2025 09:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	S1; bh=ApmNMMqNC4RulzgrQxwfzp3Z24py9u/ellor90Yxhvw=; b=KhVhNk4EP
	B6/HVCqZYL7VQNl0Exz5/G3iMFrs+lQuCWgAL1iNQ0C7lqM6A+Swni/hX/UySOcr
	iTwVMQ891/6VfaLySJZ8r9WnfuHrjNjmK9ryi3tkd/ZGHuBZu3VAF2KT/ExuyVai
	YDr34vRQQq5BfWQzBW3IrDJxC3unB7NOqExvgVubNvdREngJuEVOZDCaui/gfNWk
	7VapkJnL95LlVXrSPdth4EY+ioPp2NyWMo5QUa4l1XmGqY6lMnKx6G+6nMiKepWI
	YWuyecqIxrR1uQupeDY7cfsRClXyoxMpaCRYK5WhEMMvYbWmnc/XVK2srmIDzRGl
	DDBBUiCGWpv3g==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2049.outbound.protection.outlook.com [104.47.110.49])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 45twpjcuba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 09:40:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtMhHIAxN7+qBRo4WY4U2/qKY0GAUygBm9eXoRV8Lv9T0D0T4k4PNHC5cbwr5E3XcS8w6EdxH2mRtbBmZMYWAqTTIW552cIsbGtf9VU+2BS5lATo2baWLMe89hmw8OsumorUba7MXDevX5zTz9luzrcQgV9wuJfR4RLm6O/HVZPeL2K28J3NZYRlYWusIiXra36Bce0diAjb6UbiUgKQ6jxT1Px8fmi41AS8mbR8ufLQl3qwm8Bq0RbMHWq4SwH77fxle0yLfrEMD0dQ0BgmJcwRs0JLrap0MTpNFCfWKkW3WdU0J5M40+c/H/dg+FAdnpKMMAyj5ECYqyg1a66zCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApmNMMqNC4RulzgrQxwfzp3Z24py9u/ellor90Yxhvw=;
 b=ru/YYQt+zoJr+XlLrJzmSax18eBYnWjWTVeah2Ac8S2nwfWGjAqRs740VJBtIbGMev80yGsWgNqP8FuLyGcOlxNactxCcFqecn91rbkfs/X08gIyXkIUHhosnkCRdnSlgmDiIiNNiZl2KAa4LHpap71jssL/vsqZ0fw/KrmZJ699uXn31rHGgCVZetQJLOaR4g8WflKbQx0Z9ZLIO8TsdFWQlP+GA0v/TPCCwrNUB/vvqgnHfC5zmIPEghOgGdCBM8LNcmiZ4t71fqVh7ern6lMNzEFIxhEqt1opkF72xhf5EyJAMi4p6Vi66op6f/MyAE4p4hS/cqoik/gLcfZYHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB5784.apcprd04.prod.outlook.com (2603:1096:400:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Thu, 10 Apr
 2025 09:40:41 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8606.029; Thu, 10 Apr 2025
 09:40:41 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v1] exfat: do not clear volume dirty flag during sync
Thread-Topic: [PATCH v1] exfat: do not clear volume dirty flag during sync
Thread-Index: AQHbqfsOkAAQ6BC01E6p2zt2I+nt+Q==
Date: Thu, 10 Apr 2025 09:40:41 +0000
Message-ID:
 <PUZPR04MB63168406D20B7CF3B287812281B72@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB5784:EE_
x-ms-office365-filtering-correlation-id: 72b94539-5e1f-4f94-4b84-08dd7813c250
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?NxsRonIvhx5rhzVEXV/qNntQdf1zjyCtQ40ioPLsRciR8I+UOYwiIqzYid?=
 =?iso-8859-1?Q?PzVT7l9gRnh3GfpmrN4pSpHebrPkh6QoaF9DwQpQYhCPTXnb726G82GuMO?=
 =?iso-8859-1?Q?06rM4KBeymVKc2ikdqSzje5DQ80CV75yeBs5KV9fNBOeqjtj7hzKNVTkhd?=
 =?iso-8859-1?Q?ah7QjwWcwrEkl6137tWDRg/I+Gpm5T5bS5YFEd83kUzn0tFOq6/7fME0nX?=
 =?iso-8859-1?Q?robbh72/NhVeAfe1KqYhAImfWfqbfCdjDD2cXxWQAfNNa2VCMTcwgXOAVb?=
 =?iso-8859-1?Q?zbvWETHJmRfpG5TtULXJpD483p9h/xYqbuIeiUYfzQnCFD7A/7Ayod23Ya?=
 =?iso-8859-1?Q?0bYq3BdrRS1ybEmVbIC0XMqE8LdwDz4YKIusax8WlpPrW88pjCKxuqBR8/?=
 =?iso-8859-1?Q?mAoidBKYzk6dBl1MtoKnFbi96hNou7wiELmBjgZ39z4wn8n/W37whVpa7R?=
 =?iso-8859-1?Q?ehQGehd7IbnFesdeKH0CrGsvb3mL9kuy/Eb6+AYM1shk6MdFLJr8EFv8q4?=
 =?iso-8859-1?Q?0b+QXtEiyqyZoF7zfLVIxMRuK3QdB7RiEB1FvCDf8JpJxq7GswB9F3LZW5?=
 =?iso-8859-1?Q?GHGCAO3cgHTYWLX8H25ubClcj13R64J3sWvZAlxmfmOW90yS+EvtNWVFms?=
 =?iso-8859-1?Q?6nDKAX2wSk1cX+OJi5QUEhMp/JIjjN4Spd4tOpFYi5vnxM009vaROGyNdr?=
 =?iso-8859-1?Q?CbMZNG1Q67RmTTVCW+KDHeI4V+ecUqEFrlGK/Ynq/yTRJUZebYsIdQChqY?=
 =?iso-8859-1?Q?0BfdQhOtiKYwAF3/VltupwHEvNQZ0LORY5FD5qsvRTsOJ83KbYxo9JZZt7?=
 =?iso-8859-1?Q?Ib7dtpjdw097EIxJ7UX9pJPysPPE0arlBFNCwfhWOhkcSGRXecHhzKifWz?=
 =?iso-8859-1?Q?//Db1OuhwNwVYykqv8rCxmVuoXn6ELfzIzXRusxlnOZpcDSw3hItYIBuTZ?=
 =?iso-8859-1?Q?5J8mkps31xOiRTR85vAwsIxLE886YlRQ5Y36cvmAi/zBySlovUy+prOAhI?=
 =?iso-8859-1?Q?RSWn2LlwEcopEcElREBLH14Y7tDuSTMXUYH2fNY7ueIMoQ8hPCnjfenodi?=
 =?iso-8859-1?Q?IABh7zlL05y5Oou+cuZua8gUdnKjhDCkHZVfhyZPd0h84GIZW4N51lf8SM?=
 =?iso-8859-1?Q?/9ma/cT/BShJI01g7Er6gF8DYN0goc6r7jWj8OtCBKp6sFm+KNYD3NhMvk?=
 =?iso-8859-1?Q?KoyHC5eaVB86wic4Lr7Ylwi+JRd+w0BeDwWE7Ikl/fZTB+e8Z+pULC99DY?=
 =?iso-8859-1?Q?K2e6sG+ABI1+d4rcVfAmzY/I+FYMQ5XckczGPF+jH4a/5Z5j38nX9j1AGf?=
 =?iso-8859-1?Q?fgqhpPUF9K3smejAKBQHciOFOmeJ8+LqQnjd2o0LkICkZCF1NVGalX1J6D?=
 =?iso-8859-1?Q?jllWBsCN1nYbH6DjhThfzCR5KtNQ9S44C721lRuAPDFLKP5rW38s/bm5Ms?=
 =?iso-8859-1?Q?N+pnWvz3PD1ZufEvh0w4aLMrpPtE59pGQu3u/A6ho0fp93jk6UMx7m9jdM?=
 =?iso-8859-1?Q?/2v3ZjCPZW5TtKe4sBFxlnlox1D/Mdh1CA6FSB7UydFVL28mTk1Kcn4AmH?=
 =?iso-8859-1?Q?x4K202Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?MGPeAU9JllvtOzajXJJ5Za8yYVlf9Sxa83QtMtl1kHCG5wMSSfMEnFJEv9?=
 =?iso-8859-1?Q?ENkdO3aES4hUkq7MA7o03OE6s+71w7kKaYGtV6SFt3fNDnB1TjOKln/CnX?=
 =?iso-8859-1?Q?xmDq/h9TYWgOLq3JjRMEVXVoRL6/aG+NzqpnfvoZZ+NghFcYuwPUbHicKY?=
 =?iso-8859-1?Q?9OK2nUjDjjxFda8mQAm/Yoq1ojcxTDmVBRlFTeSDHW1nlRSMCimi4+oH6z?=
 =?iso-8859-1?Q?YgCPnpv0QuGhO4j0dT94BMOdegytNp5tBEew08c1PDKY1eZVvBfAnc9nTm?=
 =?iso-8859-1?Q?Sma+AHfbRMoGtc86mKx75BviGigCGtSacdxhTUO3xVghmBpyDI2vtSb3Jl?=
 =?iso-8859-1?Q?J8bGqa+D3rathBdyLaebFrPHLznnDOrWKcTcKn2CTw800v90aCgigyw3PV?=
 =?iso-8859-1?Q?McVV4906zjrihmciLJbZKb6tgFDJXq8lJFglXGzeu9x8N3+KHTI22tLPcy?=
 =?iso-8859-1?Q?QXvfYIz4aBin1yVpSN28yldfON3J3z2/ereC9Gr3U5UYnFYyXK9Y1fLCLb?=
 =?iso-8859-1?Q?gvPMczkYx9kG19ia+nwfyt36tYMN2d5aYyLTokolW72MgcCYqMv1h1Iwi5?=
 =?iso-8859-1?Q?hhFHZ3PXyiOhuWsaHmvMChQD87uhDUqUQjsMTq6Edp2R4WCstirYMrE0Hj?=
 =?iso-8859-1?Q?A5sJjbeBkPtF/tKXRDvKAGIUXCMmDHY62huk/bMJGS7jvKBv9a7UW/xL0g?=
 =?iso-8859-1?Q?vZ2pxJRHjpxkeO8kjzKlVIRJ+bPLdAeWJLHi5UXRkPBmMzM/MeBXJ25fuV?=
 =?iso-8859-1?Q?LMkupbJPc7yvvRKIO7/f3MKDunDls4qb84up1dowizUh7IKd6ESBYH8LhE?=
 =?iso-8859-1?Q?RWzTRTrFJkjrX7QxqIuYpVTk3C5rsO+4gJj+RjzEzSL8wVawXe8+rHluKT?=
 =?iso-8859-1?Q?KUiOObCOgF5WhvImdcjY3xHHO35it1a8LqJ86R8MWi49PTEXFrynLtwrgu?=
 =?iso-8859-1?Q?JwLpRUjxJbfH9ldOnYngYaGZWneCCd/gD9ka4WW1GKmyKIJGTZoaw6B8rn?=
 =?iso-8859-1?Q?EE27ToSC24nKFAo12Pa3JQvsjbrMFYIxzAmsC1IMewMW8q1oDjdMx8wwQY?=
 =?iso-8859-1?Q?FhGyczoznyxaywJAYcK4iuApwpRZpzMsiN3l6ZHKOhAISx2o+M7Giy/MSt?=
 =?iso-8859-1?Q?rcP05igUb2Zcb3jMRefKuAwsLn04+Q6qPnBfyOZnXIutFY4pfzlbh78VKS?=
 =?iso-8859-1?Q?4Qj+R4YObct3UaLINwAcehfkCe7cN8UVyeYwLN2sLohg/d+ylT64kNjqIB?=
 =?iso-8859-1?Q?i7Juk6Nc5nDniFQfmZJoaSsal8Q96tFuMt1E0fT9mrzt54s9p4S0zSlPIx?=
 =?iso-8859-1?Q?ISY6rS8iTRi9oP6CUbVBrFDKqPHGnFoTup1EmtSy+woSZfMDjWmtQXZ0th?=
 =?iso-8859-1?Q?wPSsVz4qmZ5vh4kTh18aDph3zQIl5ipmkfFYW4lWFZ/HA3EqofXTd6CLmK?=
 =?iso-8859-1?Q?Ef4D38YBTf1hSx3a8Liy2iYGLIJdt3qRwMrkqRk89BTsPQKYIIdprAefhO?=
 =?iso-8859-1?Q?IXXeJyoiQ0VlwKLGZXOB9DKOdxuvCBzGMgA3xH1KtMyWtp0F5ePpan51qH?=
 =?iso-8859-1?Q?9/Ca07bdbtfmSfiRFCDLZ2Bx7XLr79BW5cPuPcf8iP8Y/K1JFP3Lm9lqWW?=
 =?iso-8859-1?Q?y0wtGUWtxKVhFxjF7ubGrY9aMbLoLJLnW9lx6uDsDPSLxnv1hptIsiwm85?=
 =?iso-8859-1?Q?Kn3ZaOkE7GmKvwG7Q0w=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PUZPR04MB63168406D20B7CF3B287812281B72PUZPR04MB6316apcp_"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0x6p4mWt2we3032oBubAQ0T3m3DyYvTJ9ixJbVPGuIdkmYKdU5Op4SxF6QwXdG8eRWbQu5NZuHHTQcJB98eogB+NXE/tEm7leqkl/o3oJwotWGwTGCjde8nGhBLjDeTfKOsOhYgTUha8zgc7PcPxWl02hC7YQWvExKQcMmIt3IvzQP7JEPvGK8btxy4tU7+bWKMMt2qMTLLQWM5ScrS1vIpnDb0Mv5RAsefEqpzex2X/S+zNpC9qaTPPiMcykCKXD9eZNOMgaVUQxjFeTW/iD9tSM8QouSnznT9NQmpLgow2xGPYFYhGFAe14FwjMVeRaR3FOlg6D2/OZ23Hxtp0hTtRYmnLZiSqSfcFQHHpPby9pg4ffOELUtWAWDhR2v+FG1E+8xJQMkH6SfRIzaJuS6V5+nOK22BcsFKUTmE/4GOYl+Aj24rfFC+Dtpji+2lj3wcyqedzoVetPLdUeB2mmLD8rUxKhn8jHKB5aKaHbgYrpjGmYMtCmvwc6gPoz4eSdzgxfnmIq3N+Wz0l/qZskLMlS8eoi9YhcyORgMBeicdqcvPMaMcu5ASYRIbuyaXeEqe/+/BN3NRqG8umsT1bID8E1dn67Ci3aMAW4FP1XVS5uzeb70LEtpBDfO5Bs/a9
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b94539-5e1f-4f94-4b84-08dd7813c250
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 09:40:41.5874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4IKdlzIDPD1o9T22ncFOuAmnKRxdIhFQ1ZOSCDEq0yfcJh/T8GvOsAVoMMqjtUN44HmlL9bgw1UKoPTGSt3+BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5784
X-Proofpoint-GUID: rJuTnBvDj9ibnynRxLooWFpkEoFNlCHe
X-Proofpoint-ORIG-GUID: rJuTnBvDj9ibnynRxLooWFpkEoFNlCHe
X-Sony-Outbound-GUID: rJuTnBvDj9ibnynRxLooWFpkEoFNlCHe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_01,2025-04-08_04,2024-11-22_01

--_002_PUZPR04MB63168406D20B7CF3B287812281B72PUZPR04MB6316apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

xfstests generic/482 tests the file system consistency after each=0A=
FUA operation. It fails when run on exfat.=0A=
=0A=
exFAT clears the volume dirty flag with a FUA operation during sync.=0A=
Since s_lock is not held when data is being written to a file, sync=0A=
can be executed at the same time. When data is being written to a=0A=
file, the FAT chain is updated first, and then the file size is=0A=
updated. If sync is executed between updating them, the length of the=0A=
FAT chain may be inconsistent with the file size.=0A=
=0A=
To avoid the situation where the file system is inconsistent but the=0A=
volume dirty flag is cleared, this commit moves the clearing of the=0A=
volume dirty flag from exfat_fs_sync() to exfat_put_super(), so that=0A=
the volume dirty flag is not cleared until unmounting. After the=0A=
move, there is no additional action during sync, so exfat_fs_sync()=0A=
can be deleted.=0A=
=0A=
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
---=0A=
 fs/exfat/super.c | 30 +++++++-----------------------=0A=
 1 file changed, 7 insertions(+), 23 deletions(-)=0A=
=0A=
diff --git a/fs/exfat/super.c b/fs/exfat/super.c=0A=
index 8465033a6cf0..7ed858937d45 100644=0A=
--- a/fs/exfat/super.c=0A=
+++ b/fs/exfat/super.c=0A=
@@ -36,31 +36,12 @@ static void exfat_put_super(struct super_block *sb)=0A=
 	struct exfat_sb_info *sbi =3D EXFAT_SB(sb);=0A=
 =0A=
 	mutex_lock(&sbi->s_lock);=0A=
+	exfat_clear_volume_dirty(sb);=0A=
 	exfat_free_bitmap(sbi);=0A=
 	brelse(sbi->boot_bh);=0A=
 	mutex_unlock(&sbi->s_lock);=0A=
 }=0A=
 =0A=
-static int exfat_sync_fs(struct super_block *sb, int wait)=0A=
-{=0A=
-	struct exfat_sb_info *sbi =3D EXFAT_SB(sb);=0A=
-	int err =3D 0;=0A=
-=0A=
-	if (unlikely(exfat_forced_shutdown(sb)))=0A=
-		return 0;=0A=
-=0A=
-	if (!wait)=0A=
-		return 0;=0A=
-=0A=
-	/* If there are some dirty buffers in the bdev inode */=0A=
-	mutex_lock(&sbi->s_lock);=0A=
-	sync_blockdev(sb->s_bdev);=0A=
-	if (exfat_clear_volume_dirty(sb))=0A=
-		err =3D -EIO;=0A=
-	mutex_unlock(&sbi->s_lock);=0A=
-	return err;=0A=
-}=0A=
-=0A=
 static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)=0A=
 {=0A=
 	struct super_block *sb =3D dentry->d_sb;=0A=
@@ -219,7 +200,6 @@ static const struct super_operations exfat_sops =3D {=
=0A=
 	.write_inode	=3D exfat_write_inode,=0A=
 	.evict_inode	=3D exfat_evict_inode,=0A=
 	.put_super	=3D exfat_put_super,=0A=
-	.sync_fs	=3D exfat_sync_fs,=0A=
 	.statfs		=3D exfat_statfs,=0A=
 	.show_options	=3D exfat_show_options,=0A=
 	.shutdown	=3D exfat_shutdown,=0A=
@@ -751,10 +731,14 @@ static void exfat_free(struct fs_context *fc)=0A=
 =0A=
 static int exfat_reconfigure(struct fs_context *fc)=0A=
 {=0A=
+	struct super_block *sb =3D fc->root->d_sb;=0A=
 	fc->sb_flags |=3D SB_NODIRATIME;=0A=
 =0A=
-	/* volume flag will be updated in exfat_sync_fs */=0A=
-	sync_filesystem(fc->root->d_sb);=0A=
+	sync_filesystem(sb);=0A=
+	mutex_lock(&EXFAT_SB(sb)->s_lock);=0A=
+	exfat_clear_volume_dirty(sb);=0A=
+	mutex_unlock(&EXFAT_SB(sb)->s_lock);=0A=
+=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

--_002_PUZPR04MB63168406D20B7CF3B287812281B72PUZPR04MB6316apcp_
Content-Type: text/x-patch;
	name="v1-0001-exfat-do-not-clear-volume-dirty-flag-during-sync.patch"
Content-Description:
 v1-0001-exfat-do-not-clear-volume-dirty-flag-during-sync.patch
Content-Disposition: attachment;
	filename="v1-0001-exfat-do-not-clear-volume-dirty-flag-during-sync.patch";
	size=2923; creation-date="Thu, 10 Apr 2025 09:38:17 GMT";
	modification-date="Thu, 10 Apr 2025 09:38:17 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkZjBmMzVkZjkzNzQwMDBjZGZkZmY0NWRhNDE5NTNmNjY5OWVlYzYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IFRodSwgMTAgQXByIDIwMjUgMTc6MjY6MTQgLTA2MDAKU3ViamVjdDogW1BBVENIIHYxXSBl
eGZhdDogZG8gbm90IGNsZWFyIHZvbHVtZSBkaXJ0eSBmbGFnIGR1cmluZyBzeW5jCgp4ZnN0ZXN0
cyBnZW5lcmljLzQ4MiB0ZXN0cyB0aGUgZmlsZSBzeXN0ZW0gY29uc2lzdGVuY3kgYWZ0ZXIgZWFj
aApGVUEgb3BlcmF0aW9uLiBJdCBmYWlscyB3aGVuIHJ1biBvbiBleGZhdC4KCmV4RkFUIGNsZWFy
cyB0aGUgdm9sdW1lIGRpcnR5IGZsYWcgd2l0aCBhIEZVQSBvcGVyYXRpb24gZHVyaW5nIHN5bmMu
ClNpbmNlIHNfbG9jayBpcyBub3QgaGVsZCB3aGVuIGRhdGEgaXMgYmVpbmcgd3JpdHRlbiB0byBh
IGZpbGUsIHN5bmMKY2FuIGJlIGV4ZWN1dGVkIGF0IHRoZSBzYW1lIHRpbWUuIFdoZW4gZGF0YSBp
cyBiZWluZyB3cml0dGVuIHRvIGEKZmlsZSwgdGhlIEZBVCBjaGFpbiBpcyB1cGRhdGVkIGZpcnN0
LCBhbmQgdGhlbiB0aGUgZmlsZSBzaXplIGlzCnVwZGF0ZWQuIElmIHN5bmMgaXMgZXhlY3V0ZWQg
YmV0d2VlbiB1cGRhdGluZyB0aGVtLCB0aGUgbGVuZ3RoIG9mIHRoZQpGQVQgY2hhaW4gbWF5IGJl
IGluY29uc2lzdGVudCB3aXRoIHRoZSBmaWxlIHNpemUuCgpUbyBhdm9pZCB0aGUgc2l0dWF0aW9u
IHdoZXJlIHRoZSBmaWxlIHN5c3RlbSBpcyBpbmNvbnNpc3RlbnQgYnV0IHRoZQp2b2x1bWUgZGly
dHkgZmxhZyBpcyBjbGVhcmVkLCB0aGlzIGNvbW1pdCBtb3ZlcyB0aGUgY2xlYXJpbmcgb2YgdGhl
CnZvbHVtZSBkaXJ0eSBmbGFnIGZyb20gZXhmYXRfZnNfc3luYygpIHRvIGV4ZmF0X3B1dF9zdXBl
cigpLCBzbyB0aGF0CnRoZSB2b2x1bWUgZGlydHkgZmxhZyBpcyBub3QgY2xlYXJlZCB1bnRpbCB1
bm1vdW50aW5nLiBBZnRlciB0aGUKbW92ZSwgdGhlcmUgaXMgbm8gYWRkaXRpb25hbCBhY3Rpb24g
ZHVyaW5nIHN5bmMsIHNvIGV4ZmF0X2ZzX3N5bmMoKQpjYW4gYmUgZGVsZXRlZC4KClNpZ25lZC1v
ZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4KLS0tCiBmcy9leGZhdC9z
dXBlci5jIHwgMzAgKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9leGZh
dC9zdXBlci5jIGIvZnMvZXhmYXQvc3VwZXIuYwppbmRleCA4NDY1MDMzYTZjZjAuLjdlZDg1ODkz
N2Q0NSAxMDA2NDQKLS0tIGEvZnMvZXhmYXQvc3VwZXIuYworKysgYi9mcy9leGZhdC9zdXBlci5j
CkBAIC0zNiwzMSArMzYsMTIgQEAgc3RhdGljIHZvaWQgZXhmYXRfcHV0X3N1cGVyKHN0cnVjdCBz
dXBlcl9ibG9jayAqc2IpCiAJc3RydWN0IGV4ZmF0X3NiX2luZm8gKnNiaSA9IEVYRkFUX1NCKHNi
KTsKIAogCW11dGV4X2xvY2soJnNiaS0+c19sb2NrKTsKKwlleGZhdF9jbGVhcl92b2x1bWVfZGly
dHkoc2IpOwogCWV4ZmF0X2ZyZWVfYml0bWFwKHNiaSk7CiAJYnJlbHNlKHNiaS0+Ym9vdF9iaCk7
CiAJbXV0ZXhfdW5sb2NrKCZzYmktPnNfbG9jayk7CiB9CiAKLXN0YXRpYyBpbnQgZXhmYXRfc3lu
Y19mcyhzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBpbnQgd2FpdCkKLXsKLQlzdHJ1Y3QgZXhmYXRf
c2JfaW5mbyAqc2JpID0gRVhGQVRfU0Ioc2IpOwotCWludCBlcnIgPSAwOwotCi0JaWYgKHVubGlr
ZWx5KGV4ZmF0X2ZvcmNlZF9zaHV0ZG93bihzYikpKQotCQlyZXR1cm4gMDsKLQotCWlmICghd2Fp
dCkKLQkJcmV0dXJuIDA7Ci0KLQkvKiBJZiB0aGVyZSBhcmUgc29tZSBkaXJ0eSBidWZmZXJzIGlu
IHRoZSBiZGV2IGlub2RlICovCi0JbXV0ZXhfbG9jaygmc2JpLT5zX2xvY2spOwotCXN5bmNfYmxv
Y2tkZXYoc2ItPnNfYmRldik7Ci0JaWYgKGV4ZmF0X2NsZWFyX3ZvbHVtZV9kaXJ0eShzYikpCi0J
CWVyciA9IC1FSU87Ci0JbXV0ZXhfdW5sb2NrKCZzYmktPnNfbG9jayk7Ci0JcmV0dXJuIGVycjsK
LX0KLQogc3RhdGljIGludCBleGZhdF9zdGF0ZnMoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBzdHJ1
Y3Qga3N0YXRmcyAqYnVmKQogewogCXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBkZW50cnktPmRf
c2I7CkBAIC0yMTksNyArMjAwLDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzdXBlcl9vcGVyYXRp
b25zIGV4ZmF0X3NvcHMgPSB7CiAJLndyaXRlX2lub2RlCT0gZXhmYXRfd3JpdGVfaW5vZGUsCiAJ
LmV2aWN0X2lub2RlCT0gZXhmYXRfZXZpY3RfaW5vZGUsCiAJLnB1dF9zdXBlcgk9IGV4ZmF0X3B1
dF9zdXBlciwKLQkuc3luY19mcwk9IGV4ZmF0X3N5bmNfZnMsCiAJLnN0YXRmcwkJPSBleGZhdF9z
dGF0ZnMsCiAJLnNob3dfb3B0aW9ucwk9IGV4ZmF0X3Nob3dfb3B0aW9ucywKIAkuc2h1dGRvd24J
PSBleGZhdF9zaHV0ZG93biwKQEAgLTc1MSwxMCArNzMxLDE0IEBAIHN0YXRpYyB2b2lkIGV4ZmF0
X2ZyZWUoc3RydWN0IGZzX2NvbnRleHQgKmZjKQogCiBzdGF0aWMgaW50IGV4ZmF0X3JlY29uZmln
dXJlKHN0cnVjdCBmc19jb250ZXh0ICpmYykKIHsKKwlzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiID0g
ZmMtPnJvb3QtPmRfc2I7CiAJZmMtPnNiX2ZsYWdzIHw9IFNCX05PRElSQVRJTUU7CiAKLQkvKiB2
b2x1bWUgZmxhZyB3aWxsIGJlIHVwZGF0ZWQgaW4gZXhmYXRfc3luY19mcyAqLwotCXN5bmNfZmls
ZXN5c3RlbShmYy0+cm9vdC0+ZF9zYik7CisJc3luY19maWxlc3lzdGVtKHNiKTsKKwltdXRleF9s
b2NrKCZFWEZBVF9TQihzYiktPnNfbG9jayk7CisJZXhmYXRfY2xlYXJfdm9sdW1lX2RpcnR5KHNi
KTsKKwltdXRleF91bmxvY2soJkVYRkFUX1NCKHNiKS0+c19sb2NrKTsKKwogCXJldHVybiAwOwog
fQogCi0tIAoyLjQzLjAKCg==

--_002_PUZPR04MB63168406D20B7CF3B287812281B72PUZPR04MB6316apcp_--

