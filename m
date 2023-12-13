Return-Path: <linux-fsdevel+bounces-5901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 859CF8114D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C6E1C20F64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518BA2EAFF;
	Wed, 13 Dec 2023 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="by6Run2k";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="f9PXhz8U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeka24.fraunhofer.de (mail-edgeka24.fraunhofer.de [IPv6:2a03:db80:4420:b000::25:24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794D7B0;
	Wed, 13 Dec 2023 06:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1702478319; x=1734014319;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=2TnjwO9i/eP85clOfvQ11qDesl68BQ8bIGxoj1sSSxQ=;
  b=by6Run2keZ7tOF7+AmqvS8NsiArKjM1M70ra5Z3G9lBjyLBNF2tGmfuJ
   0vcUfbcukLvXUpXw8AORggggZ0/Sjc5EFgBRCBUTj4c5i2GfymM9bGDAd
   yB/h8ZytTexELJdSEfowW/1M4yVpV+oAVVAY5uqSNf9Ha0014TUUsUdw8
   Ri2ibAKIdhyyDiR4nCvbqvVggnhcEgMSf2sLDJUK7fo8wuuM1DUGaRk3z
   ceKEuU7JKxr8eMqvvdI5uBKAzyABQIOj1Abcg3Zt6SiHIi1HAjylVt8L7
   UNVflY00m5ZLKOLBQ3ryH4ex/O4+qDhjQ05L4FI3IeDKzXMTWBDgKJhFW
   A==;
X-CSE-ConnectionGUID: G2HBlTZUSIia7SF8kpZ3+A==
X-CSE-MsgGUID: 04nOxZ/WSwWMYnDEVngLzg==
Authentication-Results: mail-edgeka24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2EfBADxwHll/xmnZsBaHQEBAQEJARIBBQUBQIFPgjl7g?=
 =?us-ascii?q?V6EU5FjnCsqglEDVg8BAQEBAQEBAQEHAQE7CQQBAQMEhH+HMic4EwECAQMBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAQEGAQEGAQEBAQEBBgYCgRmFLzkNg3mBHgEBAQEBAQEBA?=
 =?us-ascii?q?QEBAR0CDShWJwQLAQ0BATcBNAImAjQrAQ0FgwABgioDMRQGrnZ/M4EBggkBA?=
 =?us-ascii?q?QawIxiBIYEfAwYJAYEQLoNihDQBhEWBIYcJgUqDM4JKgg6DRoJog2aFNgcyg?=
 =?us-ascii?q?iGDUZE2fUZaFhsDBwNWKQ8rBwQwIgYJFC0jBlAEFxEhCRMSQIMxCn4/Dw4Rg?=
 =?us-ascii?q?j4iAj02GUiCWhUMNARGdRAqBBQXgRJuGxIeNxESFw0DCHQdAjI8AwUDBDMKE?=
 =?us-ascii?q?g0LIQVWA0IGSQsDAhoFAwMEgTMFDR4CECwnAwMSSQIQFAM7AwMGAwoxAzBVR?=
 =?us-ascii?q?AxQA2kfGhgJPAsEDBsCGx4NJyMCLEIDEQUQAhYDJBYENhEJCygDLwY4AhMMB?=
 =?us-ascii?q?gYJXiYWCQQnAwgEA1QDI3sRAwQMAyADCQMHBSwdQAMLGA1IESw1Bg4bRAFzB?=
 =?us-ascii?q?6FBgTYBgVJbBgEBPFEBKwRMgQEJUhyWFwGvBweCM4FfjASVCxozlzGSVphDI?=
 =?us-ascii?q?ItTgXWUfoVKAgQCBAUCDgiBeoF/Mz5PgmcSQBkPjiCDeIUUimZ1AgE4AgcBC?=
 =?us-ascii?q?gEBAwmCOYQUhBUBAQ?=
IronPort-PHdr: A9a23:v7bX3hDYhcoHCIJ7bE6QUyQUPkIY04WdBeZowoRy0uEGe/G55J2nJ
 0zWv6gz3xfCCJ/W7/tUhuaRqa3kUHwN7cXk0jgOJZJWXgIDicIYkhZmB8iACEbhK+XtYTB8F
 8NHBxd+qmq2NUVeBMHkPRjcuHSv6z4VFBjlcA1zI+X+AInJiMqrkuu1/s62AU1I0RSnZrYgA
 ByqoFfqq8MUjIB+eIM80QDArXYNWsgE7mRuOV+Vg1PA99+9rrtC1gkVhf877M9HV/fKOoEDC
 JFIBzQvNW84ofbmsxXOVyKjzXsRWWZF93gACQiQwEDxHZHLvzH0hvMmxSiGeuurYYh3XD6b8
 YdGZhvTqggpLzNgyDvnjc9Nh/cIxXDprUlxkrbkYJPFCfNzQofDRooUXjdReZdsXi1QO6L7b
 LIxHuYkO8NB8q/ziGMC7iOTWyCqBb/2zBkZhyKt74Ih6786NwHn0TMsGNwcl23To/vPaJZOc
 6fp1PSR6j/ecMNI2Tmk78+PWxYt+cmgUplMffPKxW09TCzIim2/7tXFMzeq7fkSqivcxvNFV
 emQrXBglgdDgRHwwcgJi9foudoz6UGd3iJ/6cUEOP2kVUkuMpa0VZpKsCeCMJFqB9kvWHxsp
 HMiw6Yd6vZTHQAPwZUjghPTZPGEetLUpBz5XfuXITB2iWgjdL/szxqx8E310uTnTYH0y1dFq
 CNZj8PB/m4AzR3d68WLC7N9806t1CzJ1lX75PtNPEY0kqTWMdgmxLsxnYAUqkPNAmn9n0Ces
 Q==
X-Talos-CUID: 9a23:W82FvWF8fADauo4mqmJIrm4+HvwXT0b8zX6PGGHoCn5bE/68HAo=
X-Talos-MUID: 9a23:s5ueqQkHcDACJ7/4vWx8dno6aMFP85bpN3sSrrA3veWpCyp/HyWS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,272,1695679200"; 
   d="scan'208";a="5192934"
Received: from mail-mtadd25.fraunhofer.de ([192.102.167.25])
  by mail-edgeka24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:38:34 +0100
X-CSE-ConnectionGUID: BVIt/n8sTBGq/k989s8kDA==
X-CSE-MsgGUID: HvGe8cBgTTmi6Ncob3wMTQ==
IronPort-SDR: 6579c1e7_YtN3y5NmURbeqtvcrSOWoGMBgYWZii8KVdIpJJc7M9Lfiyh
 uRQCZlQVzf2c7asHAwZul3pRR1wuk4Coja7epvw==
X-IPAS-Result: =?us-ascii?q?A0D7BABtwHll/3+zYZlaHAEBAQEBAQcBARIBAQQEAQFAC?=
 =?us-ascii?q?RyBKoFnUgc+NlmBBYRSg00BAYUthkaCITsBnBmCUQNWDwEDAQEBAQEHAQE7C?=
 =?us-ascii?q?QQBAYUGhy8CJzgTAQIBAQIBAQEBAwIDAQEBAQEBAQEGAQEFAQEBAgEBBgSBC?=
 =?us-ascii?q?hOFaA2GSBYRBAsBDQEBFCMBNAImAjQHJAENBSKCXgGCKgMxAgEBEAaiCwGBQ?=
 =?us-ascii?q?AKLIn8zgQGCCQEBBgQEsBsYgSGBHwMGCQGBEC6DYoQ0AYRFgSGHCYFKgzOCS?=
 =?us-ascii?q?oVUgmiDZoU2BzKCIYNRkTZ9RloWGwMHA1YpDysHBDAiBgkULSMGUAQXESEJE?=
 =?us-ascii?q?xJAgzEKfj8PDhGCPiICPTYZSIJaFQw0BEZ1ECoEFBeBEm4bEh43ERIXDQMId?=
 =?us-ascii?q?B0CMjwDBQMEMwoSDQshBVYDQgZJCwMCGgUDAwSBMwUNHgIQLCcDAxJJAhAUA?=
 =?us-ascii?q?zsDAwYDCjEDMFVEDFADaR8WBBgJPAsEDBsCGx4NJyMCLEIDEQUQAhYDJBYEN?=
 =?us-ascii?q?hEJCygDLwY4AhMMBgYJXiYWCQQnAwgEA1QDI3sRAwQMAyADCQMHBSwdQAMLG?=
 =?us-ascii?q?A1IESw1Bg4bRAFzB6FBgTYBgVJbBgEBPFEBKwRMgQEJUhyWFwGvBweCM4Ffj?=
 =?us-ascii?q?ASVCxozlzGSVphDII1IlH6FSgIEAgQFAg4BAQaBeiWBWTM+T4JnEj0DGQ+OI?=
 =?us-ascii?q?IN4hRSKZkIzAgE4AgcBCgEBAwmCOYQUhBQBAQ?=
IronPort-PHdr: A9a23:HmJQFRcSi5pYAQlP5RBl+zBhlGM+/N/LVj580XJao6wbK/fr9sH4J
 0Wa/vVk1gKXDs3QvuhJj+PGvqynQ2EE6IaMvCNnEtRAAhEfgNgQnwsuDdTDDkv+LfXwaDc9E
 tgEX1hgrDmgZFNYHMv1e1rI+Di89zcPHBX4OwdvY+PzH4/ZlcOs0O6uvpbUZlYt5nK9NJ1oK
 xDkgQzNu5stnIFgJ60tmD7EuWBBdOkT5E86DlWVgxv6+oKM7YZuoQFxnt9kycNaSqT9efYIC
 JljSRk2OGA84sLm8CLOSweC/FIweWUbmRkbZmqN5hGvcsb68S3Au/Bz6DDBIMzqCpZpdQzh6
 q1SVj/FpiM8FREX6GyOspZAi6Fmq0fywn43ydvaMbmlNOguQ6rQQfcEfjNPRZtBcH18C4KtV
 qpIDNM/LOp9qazk+n0AgiOyRjGBWsrpy2NRgFmn3PBh4cs6KVrd+gwBEu0Ct3rGi8zyO4koD
 dHp7u6U1WiaSPlLxgfj6IaRdVdmiPeABYpcfuHtxXA0GyfX1XqdrbTKeGq12uAyiHWE9qknf
 PuKi2UYjR82nz6d5e5zjYbsh9w09Qji1jQg64EzDJ6JVW5nfNnxQ9NA8iCAMI1uRdk+Bntlo
 zs+1ugesIWgL0Diqbwizh/bLvmbeqSkuE+lWvyYPDF4g3xoYvSzikX6/Uuhz7jkX9KvmBZRr
 yVDm8XRrH1FyRHJ68aGR/c8tkes0DqCzUbSv8lKO0kpk6rcJZM7hLk2k5sYq0PYGSHq3k7xi
 cer
IronPort-Data: A9a23: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
 uNAOJTiLB/txJht5YCr
IronPort-HdrOrdr: A9a23:WhhLMazL43Yh88lQHNbCKrPwM71zdoMgy1knxilNoNJuEvBw9v
 rCoB1/73fJYVkqOU3I9errBED/ex3hHO9OjbX5VI3KNzUO01HGEGgN1/qA/9SZIVydytJg
X-Talos-CUID: 9a23:VrWFWG9oZVYUUWeTACCVv2QqO9xidC3G8F3/Ogi7WDY4U+2WZXbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AfH+OFgx6HScdtnfSDWZe6IerEQyaqISwJ01dmr8?=
 =?us-ascii?q?Jh/WBNHJWMDCX1yuSfrZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,272,1695679200"; 
   d="scan'208";a="193377217"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaDD25.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:38:30 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 13 Dec 2023 15:38:30 +0100
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (104.47.7.168) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28 via Frontend Transport; Wed, 13 Dec 2023 15:38:30 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewX9bWfBGmGvjUtI2KdI6MWH9wFrd1kIjXultS33YTAmPCdGww7pTiv2Frjnxk4/t81wO6TEQU9tV1iFuJWmelp3KgltmoJF4iK5gojaWVLZHadL2nt9U8hE3STFyKlCb1Lzpw3rkDkBpk9pe+zJZFCs/mvO8z8K0XvkkitY3GsPeIOm8ISynOB6hhkAYV5wRrXEn1l8tZYrARvnEJha3aoo+4bjy9+UUG8VZlBV/5LjcUoWtH7GvwVUQ8HQcPV9q5YNErELbT8eiuiJYnzBk0RJBiTDCbAO6x09h/Ofenv5YgxKvfLlNmHOzpnHyEYMfwsexHZi4VGciQWWRdy81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9c+nRerfXq3uit/N5DP+mbQvHEFlSJGFpe1P2XokUc=;
 b=L8ppZYqIHXBsQ667ciEfKPLZD6NbtuK8wd/KandrnRIz7+oWun+gXKJ/I/ahDL/J11rZfd/XUkYOkK0Y3P6OOpqw+3DeSIB8IOwVpzwpdBJcB0VdAZdW90GYhn2v9wZiqmiA1O4pAletv78tkVMVhM+5iKUSi5lg7zcOfq074vSDJ06TTCwWADTyeM6ogNgiH6UONXFPsQphR3/rrgr2EtgUyNWfCM8swkvp0IaGto9PXp0ifupQ5YLtu7Q404GFY/3eS+5wqk/k9JOHRO27oNKEzF5ZjEF0mTGXlN1n028ekekTeOTuIx8snmci3E4Z3Z51yH7bckN5NjccGOJm+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9c+nRerfXq3uit/N5DP+mbQvHEFlSJGFpe1P2XokUc=;
 b=f9PXhz8UaeTLvS1fs5xO9UaiyQI/kQVydMnMq5NfGPd+PE6Ani4qnN9i53ZGsP3sNhIeWdofzOqogFR4Y4J/4p51ObuwXvhf1o//And0PDgCTdQsdLz3GelPG/1HdlWSuwq+/AqMhcWNv/UnZKA7ogMi6IW0NKy1ConA+YuHtuo=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by FR2P281MB0026.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 14:38:29 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d273:9b9b:dadf:e573]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d273:9b9b:dadf:e573%3]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 14:38:28 +0000
From: =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To: Christian Brauner <brauner@kernel.org>, Alexander Mikhalitsyn
	<alexander@mihalicyn.com>, Alexei Starovoitov <ast@kernel.org>, Paul Moore
	<paul@paul-moore.com>
CC: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein
	<amir73il@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<gyroidos@aisec.fraunhofer.de>, =?UTF-8?q?Michael=20Wei=C3=9F?=
	<michael.weiss@aisec.fraunhofer.de>
Subject: [RFC PATCH v3 0/3] devguard: guard mknod for non-initial user namespace
Date: Wed, 13 Dec 2023 15:38:10 +0100
Message-Id: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::11) To BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:50::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2791:EE_|FR2P281MB0026:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f186d2f-0a8c-485c-e8f1-08dbfbe92c00
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GNjTbbD5ZFnInKKfJIUb9aR02TJiBr5/0UrqRNOK9uHNSdtSJyAUsHkZtgOCVIhoVuOr7w8WkX6CD/eFe0scOc7T3wctGJXhbIWb0ntXFcDAA48NuoWxxHAuviZpN05cK+4P6a23b1hNj+3nsrGgTPpJ+ikkXQAYO+NxV7/F3kCp00okO/fbuihvJRSyGky+gvjvVYn05+vjGY17EFMAb7c9ecmTlVsvx3Z/PZ0PTBrFlFfooOEeMZCM1e3sNUekqlpCGEiTKMm5uYzs14d8I4dY1bxDhEEHXxIyJtCE0/avAlFB2NLVFyOsjc9GMmYln05JJKwqP5/JkNutYxw9G+olLCo/G5ZPqHtgpfOmoqI+pD0NSsPM0q+Dr1RKwmwbXbbxyei6DoVL4JiJwM84d0SymQMboF1SgPgFCyeQJT1kjqPCRE4bUeReS6Zy0OrQ3WCOmmHjPMVUfoNTvGjniA4kHBA2uybc1to6mNEdJNLq+oE/86mXhiR4+m1smPhSleCTPZgm3dnEwY7HJu9hqPhK+7Xhsmir6B2crzAE0TmNwyWhPJWWv+5kcYArZtEhLLw7twQDqrj0AzK0/fakkVo4a8crb6s0zGllbZ3wUYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(107886003)(38100700002)(8936002)(316002)(54906003)(8676002)(2906002)(7416002)(4326008)(5660300002)(66476007)(478600001)(52116002)(41300700001)(66946007)(6512007)(6666004)(6506007)(110136005)(966005)(6486002)(66556008)(2616005)(1076003)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjNIekQ3ZS9PNTlUUGx2MTBhTko3UGViUzZ6ajdRejBVOFBKY2FIc1graThI?=
 =?utf-8?B?aVhiRVRtVXJJbXpVRHI1QmMwSTBBNkJITWhsWHEwM2lFNGgyODNsWnVIQmRC?=
 =?utf-8?B?d0tNb25ZMDUzcHNBTUpmbW9VZGZ4UkcxVE5meGtURDBiZDRRSW1hemNTQi9z?=
 =?utf-8?B?RzZidFV3Y3JqdkVXcHlJd1lseVFKOHpYQW9DNnlKb2FEZ2R0eTlDQ05QaEM5?=
 =?utf-8?B?emo4SGNQR2NGSnV0SzBRMmxXeTIrd2hrdk9Zb0FqbnpwZkk1T0RRdDAzb1N5?=
 =?utf-8?B?TFViU055L2IrK1V6KzZKeElrWFRLYmVFT2xPVWRqd3ZsMk11bEtxZWdyTmtS?=
 =?utf-8?B?bnZPSHhDVUthSUg0bFdXcVI1T1ltdlBqN0RKTDk2VzN6QnVhNG8wck5ySGY0?=
 =?utf-8?B?YzlTbjhWUlZCZDVEY3NNMTM3QVEwSjM4VUs1cnN3Q2RnWmJsaElyL29oT0l6?=
 =?utf-8?B?eldHRHVKbGF3WVFoVzlqRmR0dmFVVDhXR3hmSm5LdWhmaW5WODRCSmhPR2tp?=
 =?utf-8?B?Yld0ODZkNEpPRmY4bTM5NUFucVhOMGtHK2NLcERtWnM0WnFkU0k2Z3dKejRP?=
 =?utf-8?B?dzNXQi9KellWV2c4MmNXRUJuL2tOc1NHTnhzSFVCWnJlb2pmR3d5M2Zadk1x?=
 =?utf-8?B?R1hldm44YnM2NzN1QjhhNkpwK0J0bWR6MDNiMDFSaVI2TDNJYkp4b0duRDFW?=
 =?utf-8?B?VWt6QnBmN3pscDUxZGUvNk4vWXVhNWxQbkxIZXpoNGRYcG14YUYrMnpVSEJx?=
 =?utf-8?B?K2xOazkzSFVrbmZEQ3JCeWV2cGF4R2M0d1RBYy8zdWRaV3ZkYklKS25GeDRy?=
 =?utf-8?B?MHlwcUYwNVBacXpKUVg2eGNLeU10aVVSejluMUc3Y2UzZDY2SENDRkRkWGJK?=
 =?utf-8?B?WUc3aW1GZzB1ajFuTi9xcU9wV2JOMHRDRjE0SFM4cmwzbERZNjNoQnlhTm9K?=
 =?utf-8?B?SFNtVVJ6R1lNVy83S2RuV3U0cnhoemVXb3YzQlJiQmtoQ09TaVFyRFVvNEJH?=
 =?utf-8?B?Sm5XRDUxZTJjTDB4Y1AvVVJFbC9Zd1ZURGc1K0ZUc0pxeXVDakhwU1NJc2pC?=
 =?utf-8?B?SFhJOXFJNVZSeCtsQVd2M3hYamVPRmNrU0hIMkZKdHFJQi9YRTN4bWZXWEZY?=
 =?utf-8?B?V0VsdTJGcGpwUE11NXBjb2Z0SEJUYkJKQU8ySER4MVFST1kxbjhEcjJQaEk1?=
 =?utf-8?B?UVBmSGdXanVObDNCRHlqb2IxMDlzdFZQZVlUd1RPalJrTDFndW0xV2RiSWg4?=
 =?utf-8?B?cFpPSjdZVXJCUDVvb3E1NitzK1FLNUc3eEk0ZVQ2R203TEQ4OWg1WTZQK01H?=
 =?utf-8?B?VDRnQXRvQnZRQ2NFYmkyZFRYb09DS0VpTTZzTHNTeFlSVjBwcERHbmhoY3hB?=
 =?utf-8?B?UXhEZ21BRFp5ZkpCdVlleUZqYVFtR012U2dMK2RKMEF5TnFrV3N1Q3h4aDlw?=
 =?utf-8?B?Z2tia1pPdTJvS3RVak8wWk1WSHRlbjAzQ2ljaVBTZElnYWt3d1c0cEJnc213?=
 =?utf-8?B?S3hXVlAwVWZUWThlRnpKVkE0czVucTh5ckZCQ2pRTW9OWC9VUFI0YjhnZTJr?=
 =?utf-8?B?SC82KzFBZEgxejlIb2RrWk44Vk5odTk2Rkg3MEVuWnllOVJ5VGxSRURZYmsr?=
 =?utf-8?B?WDN3WG1QN0NDblI0MVJMNS9jVUJjWVVQWFFCWG01SngxUk5RQWd1SUYwZjlo?=
 =?utf-8?B?NEU2UkQvWE5ZU1pHRkNNdngzdWVTWFdYLzI3cUpwQ0F3Y2tMWFpFWU0zWG54?=
 =?utf-8?B?K3cwVW1sd25qZUIvMWpIb2wyaEVwVjU2UUpYWDUvRHRZTFMrQXVSNjhlai9m?=
 =?utf-8?B?anlEbzl4amJROGNkOXowZXNpbVdLcWVtNktJZG1iZUZTSFA3NU9RZGZtWTJP?=
 =?utf-8?B?Q3dHS3A1cXpGREJRVUMzWFFUVzF4ZnFiemFvckREMFV3Wm02emcrbHovRWx0?=
 =?utf-8?B?QklRUXdOZWlrWlpDWVhuUTM3WFlEa3lORDY4YktGNFVlMzdFU2NQc3pjRmlo?=
 =?utf-8?B?WGZHeWxKTmpWQ2kyS2g4cWZvRlRYNEcwaFlHTHZvY3dtMkdNTGE5OHVXTmZK?=
 =?utf-8?B?eGVWbHpXTldKSzNSbC9zQTFZSlpSZTVNVUJHeDJjSGFyaklUeW5oMGg1aGxs?=
 =?utf-8?B?Rlc3cU5EZUswWjlONzBzb1lCVmpmVG5hSWsxbVJkZ2xHUUJ2SkdkU3Jzampy?=
 =?utf-8?B?U2g5VEVNSXJXbldmQWhQeFMvY2ZPbUVrUHFSUVFuZEZncUxpeWx5VTRReTJT?=
 =?utf-8?Q?uAs+aJeb5SXphUrYkkyl2EeAU/zOcAQL0ZU+mfvcXE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f186d2f-0a8c-485c-e8f1-08dbfbe92c00
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 14:38:28.9079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjT3qlJTF5/8ZuTPSm8wGlshT457b8/HJPgTlaLBfpESHgGQ23DIjnl3W0tP6lZn3VfGsI4WfvZGGDnlbwYlBVbXl1eGOqFEriJb2/NpTpkKKuWmnUMWjHeEjgyIsIjb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0026
X-OriginatorOrg: aisec.fraunhofer.de

If a container manager restricts its unprivileged (user namespaced)
children by a device cgroup, it is not necessary to deny mknod()
anymore. Thus, user space applications may map devices on different
locations in the file system by using mknod() inside the container.

A use case for this, we also use in GyroidOS, is to run virsh for
VMs inside an unprivileged container. virsh creates device nodes,
e.g., "/var/run/libvirt/qemu/11-fgfg.dev/null" which currently fails
in a non-initial userns, even if a cgroup device white list with the
corresponding major, minor of /dev/null exists. Thus, in this case
the usual bind mounts or pre populated device nodes under /dev are
not sufficient.

Due to the discussion with Christian on v2, I agree that the previous
approach was to complex. Actually, we just want working device
nodes in user namespace if we have a device cgroup in place which
handles access decisions.

Patch 1 provides a helper functions to check if the current task
is guarded by a bpf-device cgroup program.
Thanks Alexander Mikhalitsyn for reviewing.

Patch 2 implements the ns_capable check including sysctl as proposed
by Christian. I provide a short overview about device node creation
and access decisions in the commit message there.

Patch 3 provides devgard, a small lsm which actually strips out
SB_I_NODEV.

---
Changes in v3:
- Small LSM to just implement security_inode_mknod() hook
- Leave devcgroup as is
- Strip SB_I_NO_DEV in security_inode_mknod hook as suggested by
  Christian
- Do not change bpf or cgroup access decision at all
- ns_capable(sb->s_iflags, CAP_MKNOD) in vfs_mknod()
- Link to v2: https://lore.kernel.org/lkml/1d481e11-6601-4b82-a317-f8506f3ccf9b@aisec.fraunhofer.de/

Changes in v2:
- Integrate this as LSM (Christian, Paul)
- Switched to a device cgroup specific flag instead of a generic
  bpf program flag (Christian)
- Do not ignore SB_I_NODEV in fs/namei.c but use LSM hook in
  sb_alloc_super in fs/super.c
- Link to v1: https://lore.kernel.org/lkml/20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de

Michael Weiß (3):
  bpf: cgroup: Introduce helper cgroup_bpf_current_enabled()
  fs: Make vfs_mknod() to check CAP_MKNOD in user namespace of sb
  devguard: added device guard for mknod in non-initial userns

 fs/namei.c                   | 30 +++++++++++++++++++++++-
 include/linux/bpf-cgroup.h   |  2 ++
 kernel/bpf/cgroup.c          | 14 ++++++++++++
 security/Kconfig             | 11 +++++----
 security/Makefile            |  1 +
 security/devguard/Kconfig    | 12 ++++++++++
 security/devguard/Makefile   |  2 ++
 security/devguard/devguard.c | 44 ++++++++++++++++++++++++++++++++++++
 8 files changed, 110 insertions(+), 6 deletions(-)
 create mode 100644 security/devguard/Kconfig
 create mode 100644 security/devguard/Makefile
 create mode 100644 security/devguard/devguard.c


base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
-- 
2.30.2


