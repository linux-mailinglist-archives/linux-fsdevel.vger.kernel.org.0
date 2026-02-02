Return-Path: <linux-fsdevel+bounces-76059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICGYHKvPgGlBBwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 17:24:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05702CEE92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 17:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74346308A12E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 16:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E46127BF7C;
	Mon,  2 Feb 2026 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="bKTzsV0v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020127.outbound.protection.outlook.com [40.93.198.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B819287276;
	Mon,  2 Feb 2026 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049191; cv=fail; b=LmL0V2ut+VcFo7BkFTW9wfkrdm/qcAOW36lsybFZxivwEcpEvE0h7mwGpvZwlC/+H4H5W+9rua2bxABAaQ5M6nMCL9UTTS9PTtdzn+TM1SWzm0BcKP3BVlrfRvAxVvupDG+G94pKC2W6OTFdAxV2+DQHgRpYoLREf1YO/ydl9WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049191; c=relaxed/simple;
	bh=rSTIISJS+Mmesc+waIk/I7cqm/NCrsW1iY2tYLeRHho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ds2xLrGuvLhppDDBYUZ7bR3F7hh3xOILEC1pFH383U9v7EGFMK9gAu0d5Fdxm8J1FV9XDlMUn9P7LErgg8UYY2MQEvydqxOArHgbqWNt74VAC3xvEo55Eb+OM7MzLQfn0bJq/FqXDM5OF7Szls6NwuJzTnAppqA3UTNjlZ7Kp/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=bKTzsV0v; arc=fail smtp.client-ip=40.93.198.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQYola89TyUNUSgJiONJuk3vpzF0kO8PzgROqD8GpkAL/bpOOqKmJVLM92L8Q6nM595t18Z2otp6jkQB7821kejLS0/O8AQVkgIIL1dLiskSK+2qCnMuKuBR/ETtvrh0I+oOBMvTJnFnqb/EJUXvXjNwEJl/+mz+TF7eMp79zLnx1cVl838d+U0c7re/1tNUZM58WViDefrWEmJMLv+uaBnRyQf3ok/8cB34m1B42JYcbP4m66Zc4R8P0cIuUZZxeXPr362h5C9BSY+p1WDSDM4bXD89Gw9QUPrklyaUE7FjtdkNc9/0OJ5P4HYcl+M9JqKJv/SauXd96pCQgzX4+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9B8/u/3UYpQRaFspQhSIFW4CJxJIKN0atBNiUcWfbY=;
 b=POgfFB5tOjur7PByHL573x2iKa7a/sLiVNNHy4dgjhJlTr7gzTBDmxVK6jXsj1qOKeMdkUTkv4boPuNPZ7KwiYLuMJmQeKU/3YawRsonFMBXNrv3urMOEwLho+FTVulZDJuYqAaVw+CLX4wBP559NUC73jb1Dx0M25Ed9ssS1RTnrMJ7Yjc7glgmwe83M8ARwMNPL21veQXLNO0/qjdCccCrnizCigPHEl7jKIxsgescMvX1fAQZ1RfMoJDvabSIxfXbxOdCpQVguggr045VZDqCF0FSzh7WCAyuiQkqxQpZ8OHd0HYzWNfEN1vamnEZ8DqD1vngXfv7tUGqETT+HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9B8/u/3UYpQRaFspQhSIFW4CJxJIKN0atBNiUcWfbY=;
 b=bKTzsV0vvxEGXTPJhxS/L13XsenVnIlNOI0URDZx7D1zx6byWWq+q1sb7TaMko4qiEcJNc3bOsBlsXgJCF2SYp+t4KmIz3zCaWr0A83Vt5Y1+9b01JgMLEvmQxR1njk8BMZAvp9DgCmsoINmUK0ehOfzXUXZI0R2JkyfXLGlB4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from BN0PR13MB5246.namprd13.prod.outlook.com (2603:10b6:408:159::12)
 by MW3PR13MB4060.namprd13.prod.outlook.com (2603:10b6:303:5f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:19:48 +0000
Received: from BN0PR13MB5246.namprd13.prod.outlook.com
 ([fe80::39d0:ce59:f47d:5577]) by BN0PR13MB5246.namprd13.prod.outlook.com
 ([fe80::39d0:ce59:f47d:5577%6]) with mapi id 15.20.9564.014; Mon, 2 Feb 2026
 16:19:48 +0000
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
Subject: [PATCH v3 2/3] NFSD/export: Add sign_fh export option
Date: Mon,  2 Feb 2026 11:19:37 -0500
Message-ID: <a16c4db7053b512e2965d0c25a47d47f1adb703f.1770046529.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1770046529.git.bcodding@hammerspace.com>
References: <cover.1770046529.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::22) To BN0PR13MB5246.namprd13.prod.outlook.com
 (2603:10b6:408:159::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR13MB5246:EE_|MW3PR13MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: 6978d9c7-0804-4d2b-5976-08de6276e27a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YiKYwPLlMGhWd+Kjxu0CmPTZPteCwsCQa+5leFKzI44ViZCQ5CC6OJ3APg0n?=
 =?us-ascii?Q?gh8gTRaAP0GZVvBEwm2fqWzMDKz7FWrAiRelK2jc6gV0NfzVhUzO1DGJvuzC?=
 =?us-ascii?Q?kkQCNnT0iO+IXyVo6ZPVjhh1hP1Tes4PcmO0TY9sed6ZJzm++DDD0AFPlthj?=
 =?us-ascii?Q?sze9jJU83yGftbWRKdGVxvQ+U/C+phTj1ZxEXEnCfQC1wxK3JLlorwDDz43l?=
 =?us-ascii?Q?nTR7gW82Z5joHxijirSpmgPpjFyPTOWoPuFs0B2VOyDlct8twri73KA0Tmrv?=
 =?us-ascii?Q?O+Z66u/fb6h4BflT51/sXesqn5uai8FaKbm7YeFldiavF56ICNy4k2L+ARdb?=
 =?us-ascii?Q?7YBtl0D6L0jN2gr8kCYtDsXxEH+qcOjh3JpjI/LhAvIk/1ew7csF5YGwzpj/?=
 =?us-ascii?Q?mQaQ9g+2ebUeqw+feDGbe59lbcSa7hXKd8synZAkqtJ9+X572ELJ99cODqLS?=
 =?us-ascii?Q?0b3t96tOBXBUbxtAI/3PEdoCZz6O7ro4OSXA4LdBkXv9dVgyj62cJ1KM1efT?=
 =?us-ascii?Q?qGMHY/mp+n0Z5Lbzzp1tCGUjytg1BbgjsxykifglU9k2x86m/EyH+9F1OwiA?=
 =?us-ascii?Q?M2hWoUF4TpaUcWf95H/AdPMA09L2Ykiu+Y+4Ch0sGtG1b9YWLPoosgOGHxFd?=
 =?us-ascii?Q?HwsL3MVnTz4HXuJ/fFF8Au+GDebg/FOU+J8zCWFISWlUU1oZPXkjQuEU3EA7?=
 =?us-ascii?Q?z4tyDz4ejoCKuhVJ4H0nsqgA3fZ0aFLvWETBp5WRtmY6DAKcTAjqbNXc2I2C?=
 =?us-ascii?Q?MQAnzm+OnvwKOwgl+t27Qd/k3s6cXlBB/Z4zm2XF0bwsbgHW9mpnrTmyO/hr?=
 =?us-ascii?Q?c8ipCAtnUdkS9CKBSV2wBFOmjUfyGGX184H0STQmvg6yAipzCxgBr03D9hIW?=
 =?us-ascii?Q?aoZkgGinXx/u7AkgXHbeoQG9WGRp1dVn/ewnWUcHlXT7/I1FfkRVzPgXDiUZ?=
 =?us-ascii?Q?DEvSDGh+R031WDgdAGm71rbD3wYRXaY415nT5hgy2KyGP47HgMic4BO8R1Zc?=
 =?us-ascii?Q?Oj2adQayDHKYXThexmdSYhTQ/JC9itMmlNmzlmo7YQ95PAJ1V/v+9trnFJgk?=
 =?us-ascii?Q?97yVVrmG9PTiYnVpJ50QMkn9bkUEo2yz6IydK92dhWOimQpD1nnjcivxq2vd?=
 =?us-ascii?Q?SDIiWc8URf3KhFV5s7ZdU6OW4/addJZDfAlE8uvASO2LjgnZnoqoCfx20JLC?=
 =?us-ascii?Q?pf+ZJ/5jPsm2Xg3bO8aIzq3y61aKnsX9nRE/K0yCzpFocVRtBsSRnMPeabpJ?=
 =?us-ascii?Q?cZKU/qlH35vcARtedTYvfGGrPXeMry3VU53ytIpM1GmffFz/L1SLUqxiduQ0?=
 =?us-ascii?Q?8oXtFbAtjSHDGAexHuucIZMBvKKD+lYyhN3WYv7jMnlNpbXX0sgFUVlqCW0u?=
 =?us-ascii?Q?sa3XTU9tR73olZm3u6ryC5D+KZGOHc5pIGa0bffdp/Yjxiw8/28ZpIK8c7YJ?=
 =?us-ascii?Q?F5XvPuvMJ8iFAlXGUR5SDqUVqXtRidDwhAknxGgCsw9tnVwLSQGU/x5icNSF?=
 =?us-ascii?Q?01KW2AhMDUEvATn1ryne+6j3/oamGDQphdRnjAkw8lqcZT32aVxUpRJp7G0s?=
 =?us-ascii?Q?YkI6wNABvSVvcnPMVvg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR13MB5246.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iXMMC+wUkn2tah8IqaesVc97GsDUsNoBBNd1OZHewPB24RLrZ1y76y09Ylvc?=
 =?us-ascii?Q?rKbQsOTcUH0M69KTFPgMflFAJr6EtG96Cnjd/h/NJzjIcNw+4AUq/YGeOxh1?=
 =?us-ascii?Q?gszyVftjPCkgFs6cbNl+rguXc8iH3ZTFoMMVQkHgKXsM2W0R+iCQ4YHFsltW?=
 =?us-ascii?Q?pLanZJi+2HreBSnPeOuOtKEHKUsjMAsO4yrdD7/zhG7i+YACPymh68SohDvv?=
 =?us-ascii?Q?/Px5NekcEf6YOb76xqQam9KIvpdKzcv4lWLle4rh/7SUlEuztc6yR5U/TMwO?=
 =?us-ascii?Q?oP3ikYypeJqum6Dut/lyZYv0U2+2fxcYFk3KCzK4PdYBBdfMBse0bKjjOXBI?=
 =?us-ascii?Q?CgLgljKJwSew/joS3CNciXjMpteRnYgtiIyyBuvUwcbnLpy2SG/+SEzh7/AY?=
 =?us-ascii?Q?sn/O40GxdRToRKVwSPzmQ2U7BwhKRDW6o5zWAXhOtWXGaVuL2+MkayiXrhxH?=
 =?us-ascii?Q?HCUa2IMB3cyKWjz/cEqxCJwrOYY40hF0tf0dptSn7UvvPpIDs7KGC+EnMW2r?=
 =?us-ascii?Q?Kgss/1PtcmOmjNQJa1yTpwWU7pSAEDNcxna42LsVdqs2e0DDSONljmGG52vI?=
 =?us-ascii?Q?oooMrlnvQeWyGdR2u6r48sDpslbE0H8aGuTXtobLcWc0UrtVrRGcgwmGqAMM?=
 =?us-ascii?Q?3XP5hkEPyS+7/GQ33cykXVFnh19xBqgkmFlIfBqMSLR/a5HGUOY009HXSd08?=
 =?us-ascii?Q?XcSYuOUOLLLXE3CQ9YjwnP6zYm9LOj26fQMB53k/Zdeks8ZpI0Zm15yLrBNx?=
 =?us-ascii?Q?Jbo0eZW+G5w8o8sQ/YwQtT3MOTQG00VoiCRqZHB7humYQRf7CjscAptj8XUr?=
 =?us-ascii?Q?WaZswkilT79gjDVro+8N0ZJQEGHHtZh+uwPVnIsGPxlw8F4Kif+0pmmBYRT2?=
 =?us-ascii?Q?7xjN3eFqpVQpTZRepsBYwBY+PJwZkHVYfbXP6rdsOqeioxaQdxERZBWh3YOb?=
 =?us-ascii?Q?SxWb55OREP96EFE4wuVBBLKCcA+j09WzOUvqBSTgUeZlKLF/jK50wWOdZ8Nv?=
 =?us-ascii?Q?IlrOk7WaAVphrZeYxWn4RcuwOn1T9GN4H/zfYJr9DMBTrcMqk4+3k4QQgwBH?=
 =?us-ascii?Q?ioB55ElgMx3pt0ubUui63+RodbBiNRqxg+JHYpcBTjMXC41nUZDcRVD0q/M7?=
 =?us-ascii?Q?MzKUpjImpuBG/oX205+RNCvXAYvLaXhWn71lp+x/9+i7vlvSyXuNZrBUeoFZ?=
 =?us-ascii?Q?9paJ6hlnbXOeGg94vjWptE1h4EJxebQe4Is8OxH3Cxf00kQJOKko4WCtaxbh?=
 =?us-ascii?Q?xeCZKLm81Ns9OcoppmkFPsMh1veBkEK+ydOBQmfKqEAzvMAZT6yjCOxVjwhg?=
 =?us-ascii?Q?nLFlDMtUCrpYdcpyTUc3bM4ey6Bmw9Q+5lnPIvl8XzoIvLtS4a7J6wm8bJiG?=
 =?us-ascii?Q?+tlZnREDA668dgRAmv9HkHhohJLhqNlhuJgDVXLY9dxMGDOZd1Thkr5QdZhO?=
 =?us-ascii?Q?otzriEExKkM6GqbP43TSe2uCzwWaNTE8PunBxhVlUpb54DJGgRttElkmfopr?=
 =?us-ascii?Q?gvvoN4047inF1Dz8CoC0VN2runEl2AwdbaVmbOTocvcIuRT3O7gMof9mkyEA?=
 =?us-ascii?Q?lv71h6VR5yPSPEP1TG9WZGkeHxIDZTxQ2G0JWeZ3paUZbFnR8thk+u34X4HG?=
 =?us-ascii?Q?urA5yLg6CvjrBowfcR1oibyLoOwN7eI2PEBMQ3gGyroLWWXfNbokmiEms9M3?=
 =?us-ascii?Q?/aYJs6sPTZ/1wh331InejqP+OaF2cVYKYNCn5CZtx8ah0zBshGTRfms5Sjmh?=
 =?us-ascii?Q?Xa0zRKn3f3oCl/TAEmtX6ipMgAzVU+Y=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6978d9c7-0804-4d2b-5976-08de6276e27a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR13MB5246.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:19:48.3442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u01sFZA/G3+E/FFZk7kJKPUGuRC2RG/843H2sXJ24Zhn7aY/vfVpt+vb8D0yS/R8+qSpCzHiUpjOSFI0EvZofIkpaWVZ1kgKoT8QI1bPZGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4060
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-76059-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05702CEE92
X-Rspamd-Action: no action

In order to signal that filehandles on this export should be signed, add a
"sign_fh" export option.  Filehandle signing can help the server defend
against certain filehandle guessing attacks.

Setting the "sign_fh" export option sets NFSEXP_SIGN_FH.  In a future patch
NFSD uses this signal to append a MAC onto filehandles for that export.

While we're in here, tidy a few stray expflags to more closely align to the
export flag order.

Link: https://lore.kernel.org/linux-nfs/cover.1770046529.git.bcodding@hammerspace.com
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


