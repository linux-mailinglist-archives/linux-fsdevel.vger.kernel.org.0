Return-Path: <linux-fsdevel+bounces-1149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339657D674E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 11:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569D01C20DB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 09:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB43273C3;
	Wed, 25 Oct 2023 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="c2jzdJXP";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="QNBpFHpp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592C123756;
	Wed, 25 Oct 2023 09:44:19 +0000 (UTC)
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 02:44:16 PDT
Received: from mail-edgeF24.fraunhofer.de (mail-edgef24.fraunhofer.de [IPv6:2a03:db80:3004:d210::25:24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8AF111;
	Wed, 25 Oct 2023 02:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1698227057; x=1729763057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=LisGFJtmoMraL3Xn+b4+s7LDuexwXcQjYJczf7X3VJI=;
  b=c2jzdJXPQt9xZBomLZRtQkd4dnGbz2ksbumvvP7hgvjSiwN6tRDj662k
   Gdq/8XVeYKFAGnZy4/nF7a0F17Js5dl3XvtRfhoTDx/m2cYk5OesXNTRE
   NaEBB+FzUgaSJy1BF3LinTbbltCWuuAwz0Zh7UwGCjUGySBI6cChTmLc/
   /mKqD79M+Lm7/nrrSof9sLwWGgTuyrRcW88KqV//ewBJf+sfbB9F+r4xM
   vb3gg2JYIlXUQnDiyG2RCJJ5b4s3Ow51AeIljF4vNcxgqVY8YiXPtf50W
   yz8zRtygIy2gql6iNQTcc6zgAcXXnd3cd2Ihwp9pIHMnhS/uJUMbjwKsN
   Q==;
X-CSE-ConnectionGUID: yF1TmqScQcizelVPON5AOA==
X-CSE-MsgGUID: +3Bc1tHOTpGvzjHknweORg==
Authentication-Results: mail-edgeF24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2E6AABB4jhl/xwBYJlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYI4gleEU5FenCoqgSyBJQNWDwEBAQEBAQEBAQcBAUQEAQEDBIR/A?=
 =?us-ascii?q?ocaJzUIDgECAQMBAQEBAwIDAQEBAQEBAQIBAQYBAQEBAQEGBgKBGYUvOQ2EA?=
 =?us-ascii?q?IEeAQEBAQEBAQEBAQEBHQI1VAIBAyMECwENAQE3AQ8lAiYCAjIlBgENBYJ+g?=
 =?us-ascii?q?isDMbIYfzOBAYIJAQEGsB8YgSCBHgkJAYEQLgGDW4QuAYQ0gR2ENYJPgUqCR?=
 =?us-ascii?q?G+BKIMwg0aCaIN1hTwHMoIigy8pi36BAUdaFhsDBwNZKhArBwQtIgYJFi0lB?=
 =?us-ascii?q?lEEFxYkCRMSPgSBZ4FRCoEDPw8OEYJCIgIHNjYZS4JbCRUMNQRJdhAqBBQXg?=
 =?us-ascii?q?RFuBRoVHjcREhcNAwh2HQIRIzwDBQMENAoVDQshBVcDRAZKCwMCGgUDAwSBN?=
 =?us-ascii?q?gUNHgIQLScDAxlNAhAUAzsDAwYDCzEDMFdHDFkDbB8aHAk8CwQMHwIbHg0yA?=
 =?us-ascii?q?wkDBwUsHUADCxgNSBEsNQYOG0QBcwedTYJNGQcBehMBglcckwmDCQGueQeCM?=
 =?us-ascii?q?YFeoQkaBC+XK5JPh2yQUCCiPoVKAgQCBAUCDgiBZQGCEzM+gzZSGQ+OIDiDQ?=
 =?us-ascii?q?I97dAI5AgcBCgEBAwmCOYkSAQE?=
IronPort-PHdr: A9a23:hAvQGBfa1JXOlQzY4yEmL8CKlGM+/N/LVj580XJao6wbK/fr9sH4J
 0Wa/vVk1gKXDs3QvuhJj+PGvqynQ2EE6IaMvCNnEtRAAhEfgNgQnwsuDdTDDkv+LfXwaDc9E
 tgEX1hgrDmgZFNYHMv1e1rI+Di89zcPHBX4OwdvY+PzH4/ZlcOs0O6uvpbUZlYt5nK9NJ1oK
 xDkgQzNu5stnIFgJ60tmD7EuWBBdOkT5E86DlWVgxv6+oKM7YZuoQFxnt9kycNaSqT9efYIC
 JljSRk2OGA84sLm8CLOSweC/FIweWUbmRkbZmqN5hGvfLStogTxsONs9iO7YNbmUrtzBSq5q
 JxqeT7mmB8dcBcX0WbK1OVArKFAu0fywn43ydvtRquNGtpmZozXPtwBamdnQepQD3RtM6+YV
 YQfBvdaObxzgLm6vgoMnUGHLBeNP7zzlBtVgn+x37YRzdouCirr9x4SB/dWu23QndHEGKMIV
 /+V57jU7W/iYs1qyBz/7rSPbzcY+t+LXZZud+DrmGcISBjdg1iT6qv5DwqfiMkQtHiAxNVGD
 LuulkwVjzlLpTad99csoLvjm7kJkFDH9B5H2JcuJcCdaXVmQOPxQ9NA8iCAMI1uRdk+Bntlo
 zs+1ugesIWgL0Diqbwizh/bLvGLfIWmuE6lWvyYPDF4g3xoYvSzikX6/Uuhz7jkX9KvmBZRr
 yVDm8XRrH1FyRHJ68aGR/c8tkes0DqCzUbSv8lKO0kpk6rcJZM7hLk2k5sYq0PYGSHq3k7xi
 cer
X-Talos-CUID: 9a23:3HlCLG5QqIMbiN8rCtss5WBNJsU8SXbkx3bCLkuGMUFPFZSyYArF
X-Talos-MUID: =?us-ascii?q?9a23=3ACMu/xw7+Su/8hM8eZ3IeIV82xowruI6lUVwttqk?=
 =?us-ascii?q?elNeWNwxzPSiQqw64F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="62757485"
Received: from mail-mtaka28.fraunhofer.de ([153.96.1.28])
  by mail-edgeF24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:09 +0200
IronPort-SDR: 6538e32c_b493myw0R909fuRaR4AsmG+OCYaq6+vLKwYCQSlVYmhkVdu
 k4dZezblnxLIG8wZcXXyPhh4jz4yZsVOZpB1ayQ==
X-IPAS-Result: =?us-ascii?q?A0BgAAC94Thl/3+zYZlaHAEBAQEBAQcBARIBAQQEAQFAC?=
 =?us-ascii?q?RyBFwYBAQsBgWZSB4FLgQWEUoNNAQGFLYZBgiE7AZwYgSyBJQNWDwEDAQEBA?=
 =?us-ascii?q?QEHAQFEBAEBhQYChxcCJzUIDgECAQECAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QEGBIEKE4VoDYZNAgEDEhEECwENAQEUIwEPJQImAgIyBx4GAQ0FIoJcgisDM?=
 =?us-ascii?q?QIBAaUwAYFAAosifzOBAYIJAQEGBASwFxiBIIEeCQkBgRAuAYNbhC4BhDSBH?=
 =?us-ascii?q?YQ1gk+BSoJEb4EohnaCaIN1hTwHMoIigy8pi36BAUdaFhsDBwNZKhArBwQtI?=
 =?us-ascii?q?gYJFi0lBlEEFxYkCRMSPgSBZ4FRCoEDPw8OEYJCIgIHNjYZS4JbCRUMNQRJd?=
 =?us-ascii?q?hAqBBQXgRFuBRoVHjcREhcNAwh2HQIRIzwDBQMENAoVDQshBVcDRAZKCwMCG?=
 =?us-ascii?q?gUDAwSBNgUNHgIQLScDAxlNAhAUAzsDAwYDCzEDMFdHDFkDbB8WBBwJPAsED?=
 =?us-ascii?q?B8CGx4NMgMJAwcFLB1AAwsYDUgRLDUGDhtEAXMHnU2CTRkHAXoTAYJXHJMJg?=
 =?us-ascii?q?wkBrnkHgjGBXqEJGgQvlyuST4dskFAgoj6FSgIEAgQFAg4BAQaBZQE5gVkzP?=
 =?us-ascii?q?oM2TwMZD44gOINAj3tBMwI5AgcBCgEBAwmCOYkRAQE?=
IronPort-PHdr: A9a23:yEIcARWLInvLpmtnAO0xufYdv/HV8KyzVDF92vMcY89mbPH6rNzra
 VbE7LB2jFaTANuIo/kRkefSurDtVSsa7JKIoH0OI/kuHxNQh98fggogB8CIEwv8KvvrZDY9B
 8NMSBlu+HToeVMAA8v6albOpWfoqDAIEwj5NQ17K/6wHYjXjs+t0Pu19YGWaAJN11/fKbMnA
 g+xqFf9v9Ub07B/IKQ8wQebh3ZTYO1ZyCZJCQC4mBDg68GsuaJy6ykCntME2ot+XL/hfqM+H
 4wdKQ9jHnA+5MTtuhSGdgaJ6nYGe0k9khdDAFugjlnwXsLTkXfqmeF70Ti0N+yrVqArUnP+8
 bwscx7ZqSkXDyR+2U/2jdEupZJ7owm68k8aocbeNbizHuJQXrvFUtlZSnFuU+BOey0ZWq+NQ
 681APoIIL1c9aLSlxwX/BmOXzCFGsLUlSMWomLy3eo4yM8/Lw7d9yELDeAWlSzftdHEMJY+V
 fqz04nj3CnjNdJb5wvsw4rOTlc8hsjXc7VwVdTX43N+OSSalU2dpI+mGC+l7+5TnnWc//FLa
 sT20m86iTNVmgKoyPUdmonjtKgI8Uye9SZ4+7gtNMa4VWtaWsOFLc4D/zHfNpFxRNslWX0to
 ish17ka7IayZzNZoHxG7xvWavjCdpSBwTu5BKCfOz5lgnJidr+lwRq/ogCsyez5A9G9y00C7
 jFEnd/Fqm0X2lTN59KGRPpw8gbp2TuG2w3JrOARCU4unLfdK5kvz6R2kZwWsE/ZGTTxllmwh
 6iTHng=
IronPort-Data: A9a23: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
 m7zW3DH9lX+Nqb/Ykf1k4lBbXdINM+2
IronPort-HdrOrdr: A9a23:7Q8696rWnhh9g0u9/MmzokcaV5pEeYIsimQD101hICG9E/b0qy
 nAppQmPHPP4gr5JktApTnoAsDpKk80nqQY3WB+B9iftXHd1leVEA==
X-Talos-CUID: 9a23:tMGknWAtKwJK28b6Ewk5pFA3M8MkSXaelimTPGadAms5UZTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3A/mARSQwgxj+mAjSklcmDZ6dpbayaqLWRUFldtZ4?=
 =?us-ascii?q?pgci/LAZxPQa6ljvtTpByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="135077953"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA28.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:07 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 25 Oct 2023 11:43:07 +0200
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.169)
 by XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Wed, 25 Oct 2023 11:43:07 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bs+S8UwYlKnYI4ov1SzOpkRhIyplMOn9bOSMFpllLLYIAfBC0smn5YygVHsYznPyM7Fg/bjloEW6r1u4fujfb1GiCsTcgoNX1hkUUp4i2UuxHuGmxVXCOd5hJFxS3MKVVdz8pr1LGvUh7YZqE1ISxIGGFsdYqHT3A2stytbZPqqb4NbwFGMaVMhP+qc5CEHjhN6rmvILSQ0f/gGOloMZKeMBzJYGraCTnNWA0z2U6jU7imkYCPqfl14I8vGEwN9OUTYSIHS1oVA/0kRFZfzIcSqKJuPl4i5imV9BypstXuVJOOXpfosWuyI+LDxBQq6Dlrax0ztR+9GLE6oqSgb10w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JK4xGcnayFbI5sxwc/4vs/SiYIfxPr/AFIou6AXHkss=;
 b=VWYYX3qaoZPFMBZbofGfZsjFBwBGjHt6NEBlZWRTIZpb4g5z1NuFojsHcQA3M4OFharEugZH4pl1i4b/Amo0zmD+ShbCm+w3BxMSincvLyGVfj2flDl8LaeZttOSMg3TFEPzeyEsObdx3iRiwQnrpkrXUHVcP4sE6SrOsjA1WWzg8oefSVqHdLFXt816ZdUwZNFRyXYGAWERBZ6CwXecvK7MEeOjcpbjIXw8K2FhbnDDw4j+gE/3G4DibpdviwhZhCAvVeIMpRteSa5+ayvQcZiIMudrwlvdG+aOjmCQ4qqOFIqlMFZ2qFXPetIdpoWtiRK/u6wKlGogUQWvb7FQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JK4xGcnayFbI5sxwc/4vs/SiYIfxPr/AFIou6AXHkss=;
 b=QNBpFHppGb+gsGeNwDi00DYDLRgxau3l2CGX/q9jX2QAvIS7t6Lulh/jsCvVgsCECzZpM0cqlYlYDlrnwHCytH2IeVTyCjnT/uOQ3FohLvnBR9FO7speek+OtXQb6EuoxsCWN11iuJZLPRofZYxhBZBuSt2hkiSVpyshuMISuIU=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by BE0P281MB0116.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 09:43:04 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 09:43:04 +0000
From: =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>, Christian Brauner
	<brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Paul Moore
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
	<linux-fsdevel@vger.kernel.org>, <gyroidos@aisec.fraunhofer.de>,
	=?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [RESEND RFC PATCH v2 11/14] vfs: Wire up security hooks for lsm-based device guard in userns
Date: Wed, 25 Oct 2023 11:42:21 +0200
Message-Id: <20231025094224.72858-12-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025094224.72858-1-michael.weiss@aisec.fraunhofer.de>
References: <20231025094224.72858-1-michael.weiss@aisec.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0420.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::17) To BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:50::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2791:EE_|BE0P281MB0116:EE_
X-MS-Office365-Filtering-Correlation-Id: b9833b15-f62b-4867-3cac-08dbd53ec95f
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aEYq8zw0nbTULRmdCjI1RSphFKaK/BSHK43AtyWLZqjhqvHMnNsZmnIeYR5HI3jTgiAs9KnOUnozWHeWJOLOi/iAEzJaPjn9qNaRMro81EwsIpfSTsvZBdzZhal/kiE7ppMcVt2wToCg3M2R/KLgcagcA0BdyN8XzkwafTGJhZfBpQh47K5UDaojGB7rb5vdM4A9nwBiDaUNYSsX9WDzELopziMJKAzK9Vij3Uz99G6sWdBTPWepTNBfZEeeRxuJOCG5rgdVTI8loSW/6QBSY1BBkktksmj1v+OoZYy6SIXrQa/l60h4jsCQxqCMzqGFSUW9O11WR++bwgwJMihsemmKoNyaQUD2CjRSNBA5orPN12SMFUQP7sVsSc1/tReLteavk0BhdGXVb6CnrlUIqnxJ0vWprqWnJaJOpaXEuTg3Yiq77zUH75XhNgh+kNnKot9JCwRgyoPAw3xd1JFkqEPivXJ1ErIYwQfu3kVa4PnGc0SC7My+jSTzfbQE/Xp9LwZx/LZZVCKL3jfmhATOJbdFx9lQicYpeCW5L3lb9u+JRd/HViOsl8zTqv2Qy/fHeLT5fRGae0V4CYXisaBT10tHizUxYUtAjYKbi0jPS3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66946007)(83380400001)(316002)(38100700002)(6486002)(478600001)(6666004)(54906003)(110136005)(66556008)(66476007)(1076003)(107886003)(52116002)(6506007)(2616005)(6512007)(15650500001)(7416002)(2906002)(86362001)(4326008)(8936002)(82960400001)(8676002)(41300700001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2ZpT0tmNEdKNUZubGkyUmtNOHN0MWkxWUVOQUpGejFxT3RveXZ3c3cwZ3hI?=
 =?utf-8?B?NThIV3F5SUdxcm1nTUtYRlVxTTdiWFBDWUZXQnZxenJGTFZpTHBJYW5yamJN?=
 =?utf-8?B?YzJHbnY1clJ0KzZXNFFhakpyN2VqOW1wMllWUTc5RkpwYWROVGgzTitzL3ly?=
 =?utf-8?B?S2dBUWZEbW5rQXpKdDh6WkI5Q0pkZlpHT3lMYWdQaEtZUnV0NzRRMjdnSGlY?=
 =?utf-8?B?QWJMOEMxR2JrZHdDREZxd1NNYUtiYzFrSFlLZkZUTDJwUkYrTlhhcWU5Y2Zy?=
 =?utf-8?B?NjNzVmRlRGZQY2dwbmRkMUtnblhBdExneS9HelJUdkJVamtLSnRLV0EwbFll?=
 =?utf-8?B?ajdVN1A4TFo0aEg4cEZGMWhiSWpPak8wcUNpZ1FRTTdTcDlkSmI3QzJQMVlz?=
 =?utf-8?B?MXhCQkFFUVd1V0h1NHI0L0s3U0pzSktiQ0IzRW5OMWl4c0xETFRETThIY0ZI?=
 =?utf-8?B?cTNnS0xnSjFiZkMxbXpUTVBNLzNlbDZYOVBMaDRTZHpYTHFPSTNsdFpsY1NW?=
 =?utf-8?B?NGVJYWtLVTl6S2R5aFNVRzJTY29jMnBTcnFvYy81eDBWaDYwdTRmR0RSckpF?=
 =?utf-8?B?eUY1Y2FxZ3RxK050SFdGSjNhc1NvMmwrMGgvTnorWW9paDcxM0RNNUU0SEpQ?=
 =?utf-8?B?N2tEKzlnSWFEb3JJWm5yZDNCTHQzZzhIMW96c2I0enZWYk1nazZpOGRiS05R?=
 =?utf-8?B?YkZlaU1TbzZRYmdiMndpdmt0U3Y4Yk92OXRuNEhqTjJobzhLVFIzZVJLRnVW?=
 =?utf-8?B?WTdzanM4UklaRnMxYlVkdmNvN2pDMHk4YUtRNmJzUTNGVGZnQWEzZjJWZVp4?=
 =?utf-8?B?aGJLSUhTcUFOaUNsTDludUUxdmdLT3V0UUhjRzA5UjZQUEVLaXNIRnUrektn?=
 =?utf-8?B?U3ZzYkI2b2xJK3NvQkhhMEh0OUh3SzllRE5EQUUrNklOSktITndGeGRYczNw?=
 =?utf-8?B?cDI4Ykk1NlZvV2hFUmVqWHVTQWxRNXRka2lCN25PUEd5aDdVdEhOa0NZOGw0?=
 =?utf-8?B?YWxRUzhkSXpneHhCYlliOWs2MDdFTUw3N3ZpbjNVVGhKUW03ZklnaHdoWFFt?=
 =?utf-8?B?clY3bFlQM3BmRDZ5Zmo1bmhYVzdiTDh0V1Y2Vjc4eVBNMXVCTGJEZWZTZTkv?=
 =?utf-8?B?TU1raEZxNVRWNXdmRHdSUS9rY1VRQVJWS3F4TUhlTjF5eFp3QjM3amVUY1Fm?=
 =?utf-8?B?bVBsZHJvL014OUgxclhHOW1ya1FmK2FOU2wwRER1T2hnUzFCeDhSaGdSenRX?=
 =?utf-8?B?MU04WHdIZXlEUEpWMWNIL1hrZzlTVm5Sem1sNDY4eU1GUkV1cEhaN3VXeEIy?=
 =?utf-8?B?U0QwNzF2REgrTU5NcjFWZVRLODY1dGJLd0wwQ2hkdGdUaHVad0FqOFF6dGFz?=
 =?utf-8?B?OHhwREEvN05uOG82REpkSXprUGFiZGV2SlRjZHJoK2ZpQ3lJb0JhSnlGQzRq?=
 =?utf-8?B?dHMxZDFqNlVoWW1QSlhHTklxQ3EyK2twSHBwdVJZRmpkQ2xsc3VPNTlZd2ZR?=
 =?utf-8?B?R3I0RHlncDFSeUY4VG1Ma2hTWEQzZXRzUzFBaXpmSkVHa28xQXJRbnpUa2JN?=
 =?utf-8?B?ZHd3dDRHd2Yyc1o0TkpqNVVqQUtXMElKZUtmRWxTSUJLS24zZHV1SXVETXZ3?=
 =?utf-8?B?a1FNUGFRR0YxNUpiS1RvMnAwYXp0b0pvMG45K3NVUFdTd3VTd2pMdWY0R2pV?=
 =?utf-8?B?eU12cmJybXY0UWJrZFFZRSt1R1FjN3VSbkRZUVludEk3RUx6ckhPRVdJVlRD?=
 =?utf-8?B?Ulp4SWllaVRRaXVzaTNTa1plV3pwbWgySEFVMDVDVlFvQTZzcmlaelZYY0kv?=
 =?utf-8?B?OEpmdEF2QmZscVhHYldsNDdHSHNvdDRuN2lMcHRscnYrM0luVzViNGt5K0Jl?=
 =?utf-8?B?aXROV0xaVjlzR3h0SUlRcng1NFprMXp6dVg1T3pycTk3OXltV3dmYlV5TlZk?=
 =?utf-8?B?WmpBa1ZUenBZMHZ0NzlyM2VQbU5zeXNFZGJ1Z0U4THFLZmtFdDAwNUZmeG5U?=
 =?utf-8?B?QkFqV0VhUVJkb0hZRVNnOFM2bkRnNnpiMGFXQi9HZU1vS1NoSW1DMmo2V3FM?=
 =?utf-8?B?UGwxcndnZSs2ekxhTnZkTTR3N2Zvc1Z2VGs5bUh4OTNCTFNncFQ3Wk1WU2gy?=
 =?utf-8?B?djBublJ0SEUxZ1FBQVRXSy8weW5RSFJycURNQ0tZZnVVMjhJZHd6RWNJWXlp?=
 =?utf-8?B?TXJ3THJnWmxjWSt4b0Jia0orMEtWcSs5TUNmWHJWUEU2ckJwYVpMRjA4Vk5x?=
 =?utf-8?Q?GgZ8rFEDfdjGv1lBLfIFTNpvhldyj5i0VhvqLqobgw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9833b15-f62b-4867-3cac-08dbd53ec95f
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:43:04.7497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+ZRML4Ps91BZxiS4XCWPJgpEwPkJspdC0VNOCc56xKMj4oHJ2gUuFBSHO9WHrY/awuAyLgQqrWpBcRMBepHFJTqwU3QmkYh58/wL9QCbJ+Y99h9r6BBC6lIbRKdjSiU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0116
X-OriginatorOrg: aisec.fraunhofer.de

Wire up security_inode_mknod_capns() in fs/namei.c. If implemented
and access is granted by an lsm, check ns_capable() instead of the
global CAP_MKNOD.

Wire up security_sb_alloc_userns() in fs/super.c. If implemented
and access is granted by an lsm, the created super block will allow
access to device nodes also if it was created in a non-inital userns.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 fs/namei.c | 16 +++++++++++++++-
 fs/super.c |  6 +++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index f601fcbdc4d2..1f68d160e2c0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3949,6 +3949,20 @@ inline struct dentry *user_path_create(int dfd, const char __user *pathname,
 }
 EXPORT_SYMBOL(user_path_create);
 
+static bool mknod_capable(struct inode *dir, struct dentry *dentry,
+			  umode_t mode, dev_t dev)
+{
+	/*
+	 * In case of a security hook implementation check mknod in user
+	 * namespace. Otherwise just check global capability.
+	 */
+	int error = security_inode_mknod_nscap(dir, dentry, mode, dev);
+	if (!error)
+		return ns_capable(current_user_ns(), CAP_MKNOD);
+	else
+		return capable(CAP_MKNOD);
+}
+
 /**
  * vfs_mknod - create device node or file
  * @idmap:	idmap of the mount the inode was found from
@@ -3975,7 +3989,7 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		return error;
 
 	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout &&
-	    !capable(CAP_MKNOD))
+	    !mknod_capable(dir, dentry, mode, dev))
 		return -EPERM;
 
 	if (!dir->i_op->mknod)
diff --git a/fs/super.c b/fs/super.c
index 2d762ce67f6e..bb01db6d9986 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -362,7 +362,11 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	}
 	s->s_bdi = &noop_backing_dev_info;
 	s->s_flags = flags;
-	if (s->s_user_ns != &init_user_ns)
+	/*
+	 * We still have to think about this here. Several concerns exist
+	 * about the security model, especially about malicious fuse.
+	 */
+	if (s->s_user_ns != &init_user_ns && security_sb_alloc_userns(s))
 		s->s_iflags |= SB_I_NODEV;
 	INIT_HLIST_NODE(&s->s_instances);
 	INIT_HLIST_BL_HEAD(&s->s_roots);
-- 
2.30.2


