Return-Path: <linux-fsdevel+bounces-76621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAmAElEqhmm1KAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 18:52:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B94401017BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 18:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 292F9300AC91
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 17:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80F24266AF;
	Fri,  6 Feb 2026 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="C8mMclYX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020126.outbound.protection.outlook.com [52.101.201.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033BC2DC77B;
	Fri,  6 Feb 2026 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770400330; cv=fail; b=Q7C4j1e42FgQnrC36Vdcj+4vj0Ysc+qewLRaCKbEjK042Dft57BPwMT87WPkuiJkzk9IS9U1aC7/Fo2iTHPKgPgt9oRdkIM63Q8ioOB3Hej+KlNugciwPr3r2rz5F+XHIy0f+UEm5Ca/7t3eFNM3HGG40SAHoPI+5qivks2Jgsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770400330; c=relaxed/simple;
	bh=nFsThR1aDUDAPULFysNIfaQruziHcVT4s5MIoqclL9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I7zZe5ioxnMoTw5AtCr046keFERAUdo/Wdn+tYjExnyUDumXr+L1N1LG4xII/PveU1A5bobL5kpq1GWfPFFdtqegBUtAyXa68IuGEsRa2BDbrE8HL2OKtBrIpBqMRBwTGk927WbkEvZ8hvP8z3PVvwAHnHPPNbCWsI8R9rMYuD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=C8mMclYX; arc=fail smtp.client-ip=52.101.201.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoJCAJo42yq2Y8qQHWmM/iorotGr31+Li2bGHhZkcIU1XT8o88r7/cx6I2sY2TCc3ZTbDc2CNMPrBLJzvuQADuQsUQQ+F3k4ZeN8zMQwO09Qn4nIfzgzL7qVJxnPukFJqENLjB2NfynbsI3TXfyGaP2Wz2OUq2vSnetjaAVJKIpXO7IvwP673XLu9wf0BU+/jaAB1C1eRV/lGKCiTLZxg2FnvLEY0LQDk5N2cX+/fBOQfMDrdb6miHLWgS505SSNhCkmknGcZSPPC6XeN2TJx44aUyQIEZqNe7aedez3xP3cKGDtluXUS6ptM0g6/ZtGpScfjY2uQRGqPm68x2wVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1ZTJQAOWMwdg+SqWupaRPcZ09y49Xko96XCsFEP7j0=;
 b=yp8C01w/kvz6Ui6ntqP/YDSDim1JGNum6jMqvFW4Gw9bTHzL46dCCs27YCv3dqlZS8V9AZwLjBkiJpSQtsoUFOEh+W6qyF8EdAivER8DuhxeoblYx7hLzHLa7pREarY7b5Pp1tGAnSW8pwDvNkPxV9pgtYlOdOymCyBy6WiKZFB1qmwtQb7I0K8MyfULxm0RJzjfII1Y32yrnMLTFfqSdGrbvf77bsc/XdzV7zQxWkaiEdXGXYjj/lvrQEil+yGC9J06LwXetMWaQ2/+mbGAX9ktG7DzbJqu/w6EGZLTxcdUIZHk71wtL4pOU1XxOu3TXWNVSb4ZvxlutLZuFwxR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1ZTJQAOWMwdg+SqWupaRPcZ09y49Xko96XCsFEP7j0=;
 b=C8mMclYX+K2WUf4RN/8Bqa5WoH0Di0ubRlvx66sH6IWWEFVU/ApN3CBgl+C1wiNZpdn2fvbnLw69qizAp45pyKorcpl/K20gd5n2Q4BsYl5doMNWwbNGU8Qmk8Q5BAutm3xwSJx8uh27c14bXz61QI9XTVAW0gYZKPG7NSsnsyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 LV8PR13MB6495.namprd13.prod.outlook.com (2603:10b6:408:183::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Fri, 6 Feb
 2026 17:52:06 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9564.016; Fri, 6 Feb 2026
 17:52:06 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v4 1/3] NFSD: Add a key for signing filehandles
Date: Fri, 06 Feb 2026 12:52:01 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <35697253-D872-40B1-85F3-3FD707F0E8C6@hammerspace.com>
In-Reply-To: <88c1ea24-2223-4a80-afb0-89c7272dd440@app.fastmail.com>
References: <cover.1770390036.git.bcodding@hammerspace.com>
 <09698b80d78c7c0a8709967f0f3cf103b3ddad9d.1770390036.git.bcodding@hammerspace.com>
 <88c1ea24-2223-4a80-afb0-89c7272dd440@app.fastmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::20) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|LV8PR13MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: 358bc52f-8a07-4843-1f09-08de65a87108
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C93vSC/Pdh5ia6VD902B+gp9iPLuvHQ6D2s7VGQPp+H/KKREBVaFL6nfsEb3?=
 =?us-ascii?Q?yQ4YdtsCFccQPJzrE4cfEu6APBKQNRm9+2NNXb60csnooLT+fGNDB3BgaMnp?=
 =?us-ascii?Q?2sI6EiEGn9F4m3Ycmo4VZ0IVGwcT7Y8hB540BGdmjQIbTK3F8ycDgaS26iN7?=
 =?us-ascii?Q?rfljJiEdOqNdSLIZirzy4rCno2wzfBpfjFdA9M14lxPji56oOPfPbuDNA+F4?=
 =?us-ascii?Q?ofTq3Wc89hqMZNboX71F5jSdsMjmmIXRnHKt6NLNSmgHU0cfvjCR0OGcBHMG?=
 =?us-ascii?Q?Dcu7FEUPvgVpOBGxt2E0PTeJMhP145Kp25YPfMDDpdnhDSXYWb01dppzlOuL?=
 =?us-ascii?Q?UOYpg4pUockuSsZX4X3CEuqrIKbfSEaI2nZSX7NxtIUP3M7kHS1VTAewruU5?=
 =?us-ascii?Q?bVrDnteBD3kP/Mphrczn1mVlmTvKueXGQaKUvumdIukChZP4VFIWtPXsJBL7?=
 =?us-ascii?Q?oSICZz9IzeRn7CITuKAs32wXf6B5hgK4w9WcMdiHzzIJw89SVMIHiqmMe/P0?=
 =?us-ascii?Q?hyMWxsSXk47l+iJGioryJwqkgyFgmarwMGK95NweizYBUily4iUFQta/Firg?=
 =?us-ascii?Q?YsQxiMHm2Smr4XPDfVpE6BLPdkqBxxcoHmFljt9ZKJdjPm7a+izTut4db9nl?=
 =?us-ascii?Q?bXjrh6A9qbqLaGz7c/bZRGztVvWu3ltz/iCbg9VwXQAYV27hT+p9MT8d9Lks?=
 =?us-ascii?Q?QzlCGGmehjjqpHw1/Q8YGapj+34awqq/tkF/MP9rMk0pQNqJdduZGS9zEaka?=
 =?us-ascii?Q?RVC7Q793u3VkkhFH7XFkIZNv/o1elGQs15dN1UyZSBbCK98sySEwo39YyVP+?=
 =?us-ascii?Q?auPRu4bktM+xo15prCAABdxgNlRiXHfQOVXoknwtkzhK2fLp7X7EaWbJGz9f?=
 =?us-ascii?Q?pL35bPIG8la8369jyCyw2mRBnN+Iy8FSSqZGmBMs8UJHkYrp1zPAtZUcBuWT?=
 =?us-ascii?Q?U0gioEpfvakagmOr7mQ9Wy0fj08kWwsStaVgWgE9AnhFwCuoGdnMydpNdkyR?=
 =?us-ascii?Q?YCdjCs/oqOFF8BEsx14/ueT1wCRjjwHrk75Ygd6S6pbvAPQnaU/9xHKl0vHK?=
 =?us-ascii?Q?s67P0tlmZoBTjwA19hpeC7uup39liG8orqv8iBK3ZnTIBE69kPeJ6+hJK90E?=
 =?us-ascii?Q?m7nb3U8hf7e2UZZnlbqQ0AZC3KFLASMk4CP/YC5ESdCO9YAIeN+RMX0yXZxn?=
 =?us-ascii?Q?54ByLLpL9ByCX1xIE/oGjtt2agMecmBOhMi7xLrp1owfGt6AmSVpsN0yMBYX?=
 =?us-ascii?Q?wk9fD63VIVX8OoM+yJI7od8qqJEiSLScZLTuf2JlGuVoSanYY4aAAnSH9fUL?=
 =?us-ascii?Q?ixMEuNot++G6bUUXDMDAkH+eerV1gRAiuvgOzOyPZEwcqkItyuSXhwnxWwHc?=
 =?us-ascii?Q?hp+xOPPMMpus1MAklgH2Y/8lGAdI72jVpmTpyUAtJioT6hJlyPnlzlUcecm7?=
 =?us-ascii?Q?0AXHJhST+T90G+lwL2xY7muzzCr2i3iIv7tih3qEEyG/g9IoUVktwnb4sYpG?=
 =?us-ascii?Q?tBR/GDGsLNARIITe8QP4vmMUaKESfqhuY5oZppIXQrGSDGTCih8jZEkpywIT?=
 =?us-ascii?Q?YQ1h1xv8fAWnl5YgGVM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sYDuq/SErhRbaAC7/We3VkVgzIKVOnaA7NQ+TzlbSC9tE0zV8vLghsVY+dvo?=
 =?us-ascii?Q?sG4JpwmtFNm+L3y46G7aL2i2oW3I905gAOLGHaofh7B6YSPRl9YpuZvnv2gI?=
 =?us-ascii?Q?CUP8SLftbeDTOvh97W+KIyUfKtiCpKxbolJRg6coJ9Qt/FoIXI2Wnffevn0U?=
 =?us-ascii?Q?Wcq3/Y5lAPMfb01937484JEaX4yfBcmYwtbWWi4savM7RLxiclszwKDjaeCf?=
 =?us-ascii?Q?/WePNdU9o8cFyvbOaNXaDwSNbyYaxEqn9PY/+qbxLIfhZogmLr35SLj92kMR?=
 =?us-ascii?Q?Pir98LMUzzumeNy7SfP1Uz03XmzLzO2YWrCbvP2fAFcNk+ubhKh1wMYQxBa+?=
 =?us-ascii?Q?ns1V62CCwIl3ohXYfk50VvUVnFUH08iN18MrX/R8PEWOx98cGgSRBUfvTE7D?=
 =?us-ascii?Q?3YED3Ta5Kz1uJZLJ5EekLwXAsAxQE+hBiMPkIhvdkbKif4dT5MygMbmO/Gfx?=
 =?us-ascii?Q?DwXefegSb/vsrNuOoamgslu0QWB3KPU5+YFjuZkfLhJKPKY2wpRfb8JrO+DQ?=
 =?us-ascii?Q?abbsLYKHQNEJ5KokqEBSuvpuJpDVWx5tpyTXvTfLz/k262CFOz9M+LGvJg/4?=
 =?us-ascii?Q?x6hNQ9b5bYuGd1Z4kPNy2LZusm7CtpNXqUV8Lx+YIfhzNKkEmGKImWa2plrr?=
 =?us-ascii?Q?qkVplvPnDvyiValbHw0EbNOsHQhyjDltD3sf+7vbJq1Jj1mgLVu5qNspkRjn?=
 =?us-ascii?Q?6f65uiVfOdDXzX8aVAJ3I8vrViEZde85uQ/xFmuiAinb6j07M7JRcIP7otIg?=
 =?us-ascii?Q?Nc3GjO3NAIeXl/cSeZgs5iF+GJAmOa3GXFaLuOiPKYzuVEpfgLwFmKpt+TFU?=
 =?us-ascii?Q?IJj/WjKglkbwP5wcGJl2ZIg82kHGyv1a3v9NG1Hm63B0Pv728A/qMC3AYT7d?=
 =?us-ascii?Q?JHGtC3xrTS60UgI+Tw/8CIMaEUEi25YImUQI2huzU1PTQJ34U/JV3H3tR3Xz?=
 =?us-ascii?Q?BP+wwPGE3O4MYmTslMh3yAWcOi1ek/lTxFc0fAvBYy90H0kGk/3jMnUiWdHp?=
 =?us-ascii?Q?oi04Ks2tO/NN9mhr8YME+chXLaZTOqgBSPoOQtQLv0+qlzzjtpoZE1//tnjE?=
 =?us-ascii?Q?Ra8MlNJnFHSiy7p3Wk/6iY37EfOeKNPWdftrriRfkS4Vy+dZcUOmzF7i3Gzm?=
 =?us-ascii?Q?DLlG3HvqZ7swDcWHups491UM8yC16K/jiRf3VjDp4/bHB6kWSmKEfDZVC1FS?=
 =?us-ascii?Q?qndfFFdtTwqCIanzTZIAolx1AzfqHroT7k0+R/y7LMJM98o+bAdjqdtWaUtU?=
 =?us-ascii?Q?IAhFspHQpYqZwf0QwCsHEGxRCs+UUwsDXzZ/F7IOM5Sqk2FNI4bqRkJ7aSRa?=
 =?us-ascii?Q?8Nrv470H0pdRWSf2xvOxWog+4F91JQAB5gaz30DhLCpXzij00mQphjvk4yCm?=
 =?us-ascii?Q?lbAMofY+5cqFLckGA82LMvfmnGTZNwmmGtz/e4cK6HGj91jaF9BV14TVqF1T?=
 =?us-ascii?Q?OufB4h8/fJR/gHIBWcscntsCqYBjtkPvcXIcUOztn1BYawVAShgaV5vTIWjF?=
 =?us-ascii?Q?ugg7B0n369TvtBqxqDgI7p6F4d51M1/YPdqEtSrBlHc+joN+NtC4cLmjeT5F?=
 =?us-ascii?Q?Vzr9kC5gakF8YCvlx5nA/pDnpe65jx6hxsmFiN1duAn7QaMepAFcuceKICzJ?=
 =?us-ascii?Q?6OQ18G+Q8NZoSj3FTTc/BcDrmrVIlzGvMD4DpznBLGLTkFMLv1FFscj6ZSJw?=
 =?us-ascii?Q?+utLsYSmKX2uPZZo37rTsbbqCBE6ctoE84Gjp5L51n2c4zrq7nzhz5gfpHs3?=
 =?us-ascii?Q?sVW/tHmhvvY0gwUndEHzI/uW5C8mDvo=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358bc52f-8a07-4843-1f09-08de65a87108
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 17:52:06.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5eqc0T9q409u8mShzDo4ULiK5+zkZ0/RLaUFP68xWlpAqI6s0w1K0bkXx1LzbdjC1lFgyrAqY0kkVu1VrCHEW2VoC3J/UYjF8WQCCvJq6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6495
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76621-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B94401017BA
X-Rspamd-Action: no action

On 6 Feb 2026, at 12:38, Chuck Lever wrote:

> On Fri, Feb 6, 2026, at 10:09 AM, Benjamin Coddington wrote:
>> A future patch will enable NFSD to sign filehandles by appending a Mes=
sage
>> Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit =
key
>> that can persist across reboots.  A persisted key allows the server to=

>> accept filehandles after a restart.  Enable NFSD to be configured with=
 this
>> key the netlink interface.
>>
>> Link:
>> https://lore.kernel.org/linux-nfs/cover.1770390036.git.bcodding@hammer=
space.com
>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>> ---
>
>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>> index a58eb1adac0f..55af3e403750 100644
>> --- a/fs/nfsd/nfsctl.c
>> +++ b/fs/nfsd/nfsctl.c
>> @@ -1571,6 +1571,31 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buf=
f *skb,
>>  	return ret;
>>  }
>>
>> +/**
>> + * nfsd_nl_fh_key_set - helper to copy fh_key from userspace
>> + * @attr: nlattr NFSD_A_SERVER_FH_KEY
>> + * @nn: nfsd_net
>> + *
>> + * Callers should hold nfsd_mutex, returns 0 on success or negative
>> errno.
>> + */
>> +static int nfsd_nl_fh_key_set(const struct nlattr *attr, struct
>> nfsd_net *nn)
>> +{
>> +	siphash_key_t *fh_key =3D nn->fh_key;
>> +
>> +	if (nla_len(attr) !=3D sizeof(siphash_key_t))
>> +		return -EINVAL;
>> +
>> +	if (!fh_key) {
>> +		fh_key =3D kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
>> +		if (!fh_key)
>> +			return -ENOMEM;
>> +		nn->fh_key =3D fh_key;
>> +	}
>> +	put_unaligned_le64(fh_key->key[0], nla_data(attr));
>> +	put_unaligned_le64(fh_key->key[0], nla_data(attr));
>
> put_unaligned_le64() takes a value as its first argument and a
> destination pointer as its second.  These two lines write the
> contents of fh_key->key[0] into the nlattr buffer rather than
> reading userspace data into the key.
>
> On the first call, fh_key was just kmalloc'd and contains
> uninitialized heap data, so the key is never populated from
> userspace input.
>
> Additionally, both lines reference key[0] -- the second should
> reference key[1] and write to an offset of nla_data(attr).
>
> The correct form, following the pattern in
> fscrypt_derive_siphash_key(), would be something like:
>
>     fh_key->key[0] =3D get_unaligned_le64(nla_data(attr));
>     fh_key->key[1] =3D get_unaligned_le64(nla_data(attr) + 8);

Yes- thanks Chuck, I really messed this one up.. somehow sending out the
wrong version.

Ben

