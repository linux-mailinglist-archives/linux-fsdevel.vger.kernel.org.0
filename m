Return-Path: <linux-fsdevel+bounces-5903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1C08114D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E0E1F2188B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487F62F507;
	Wed, 13 Dec 2023 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="GkojnU8N";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="MRBxg+Gq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeka24.fraunhofer.de (mail-edgeka24.fraunhofer.de [IPv6:2a03:db80:4420:b000::25:24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EE1D0;
	Wed, 13 Dec 2023 06:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1702478323; x=1734014323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ZK1sB6YyT1eBqXeIWt8Dt08WbuOcDu6WuCBOadhSrdA=;
  b=GkojnU8NE1lNqBBf+P8BM0OG6LlpHzNxgpuHFgI8eQ/DbxtFDnz3lQdT
   40XFFv+k6jCh4E8xVAStxXVywAyaxdGaXwpyYmvXAnZCwZrlg8yEYwOwv
   4f84EPq7xeV+PXw+ct9qBTDHS2isjn8a2FACE1PG0OFnxlKjRthi0qyHe
   3QhYttM6buWWSL6SxswVDzPWj0y5HdOlHw5J1Db4grWnOXEOAhHm4c2px
   Rq6r4eDOr03R8IL+A6cMShFfEBdFbCKshSx6nZRvAzI8E5QLqv4jimPhd
   436R9D3pQyRnYK7Hzca1S2Oo6UMmMs92VSlqLSqPkOJc3AgB9pQ2E83jr
   w==;
X-CSE-ConnectionGUID: 6BstVSBHRYKyQyCbe2cAMQ==
X-CSE-MsgGUID: 4AlxyK8lTZydOBlz7NthLg==
Authentication-Results: mail-edgeka24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2F5BADxwHll/xoBYJlaHgEBCxIMQIFEC4I5glmEU5Fjn?=
 =?us-ascii?q?CsqglEDVg8BAQEBAQEBAQEHAQFEBAEBAwSEfwKHMCc3Bg4BAgEDAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQEBBgEBBgEBAQEBAQYGAoEZhS85DYN5gR4BAQEBAQEBAQEBAQEdA?=
 =?us-ascii?q?jVUAgEDIwQLAQ0BATcBDyUCJgICMiUGAQ0FgwCCKwMxrxB/M4EBggkBAQawI?=
 =?us-ascii?q?xiBIYEfCQkBgRAug2KENAGERVdKhDqCT4FKgQaCLYQKToNGgmiDZoU2BzKBS?=
 =?us-ascii?q?FmDUZE2fUZaFhsDBwNWKQ8rBwQwIgYJFC0jBlAEFxEhCRMSQIFfgVIKfj8PD?=
 =?us-ascii?q?hGCPiICPTYZSIJaFQw0BEZ1ECoEFBeBEm4bEh43ERIXDQMIdB0CMjwDBQMEM?=
 =?us-ascii?q?woSDQshBVYDQgZJCwMCGgUDAwSBMwUNHgIQLCcDAxJJAhAUAzsDAwYDCjEDM?=
 =?us-ascii?q?FVEDFADaR8aGAk8DwwbAhseDScjAixCAxEFEAIWAyQWBDYRCQsoAy8GOAITD?=
 =?us-ascii?q?AYGCV4mFgkEJwMIBANUAyN7EQMEDAMgAwkDBwUsHUADCxgNSBEsNQYOG0QBc?=
 =?us-ascii?q?welDCABPD4TCQKBMmwvHJYXAa8HB4IzgV+hDxozlzGSVi6YFSCiRgeFQwIEA?=
 =?us-ascii?q?gQFAg4IgXmCADM+gzZSGQ+OIDiDQI96dQI5AgcBCgEBAwmCOYY1gXQBAQ?=
IronPort-PHdr: A9a23:6l7bxxSPRhnPG3tPY62Yywm1ltpsou2eAWYlg6HP9ppQJ/3wt523J
 lfWoO5thQWUA9aT4Kdehu7fo63sHnYN5Z+RvXxRFf4EW0oLk8wLmQwnDsOfT0r9Kf/hdSshG
 8peElRi+iLzKh1OFcLzbEHVuCf34yQbBxP/MgR4PKHyHIvThN6wzOe859jYZAAb4Vj1YeZcN
 hKz/ynYqsREupZoKKs61knsr2BTcutbgEJEd3mUmQrx4Nv1wI97/nZ1mtcMsvBNS777eKJqf
 fl9N3ELI2s17cvkuFz4QA2D62E1fk4WnxFLUG2npBv6C47QtAb7qshC0iCEGPf8Hb0YGjK7z
 JUyVjzM1H0JFyc4+zvmjpFCjv9anzP09Hkdi4SBRbu/JPU9UbrCRPpLR2QRD/gAbWt8JJKXX
 tcgP+hcG8xms7Oni3xUlDeALwSXLdnw4CZulF3Kw/co6vZwE1/J0wFnRO1JqXX+vNPqDaExA
 P3u6PiPiiTnVqpE2gb9taTDIk1in8mMcrEqfvvbllYTDSObhA669YbBPT2W2OQV6kGmzcQ9c
 N6g22keuRty8z+UnsE9gNTz268l22ze6AFL66FvB+SYdWt8UNSrRcgYp2SbLYxwWsQ4XyRyt
 T0nzqFToZegZ3tiIPUPwhfeb7mKf4eF4Ru5CKCfOz5lgnJidr+lwRq/ogCsyez5A9G9y00C7
 jFEnd/Fqm0X2lTN59KGRPpw8gbp2TuG2w3JrOARCU4unLfdK5kvz6R2kZwWsE/ZGTTxllmwh
 6iTHng=
X-Talos-CUID: 9a23:gMIXE2AVZ73pKvP6E3dN71IqIeoFSEz+3U7BCEW1U21AbYTAHA==
X-Talos-MUID: 9a23:nMT3dwkMca45bK+xD1d1dno+HcN48of+DHw/gJkhkc2WagpsOxOS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,272,1695679200"; 
   d="scan'208";a="5192944"
Received: from mail-mtaka26.fraunhofer.de ([153.96.1.26])
  by mail-edgeka24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:38:40 +0100
X-CSE-ConnectionGUID: l1KIAwhgT1KSmFdOXIdFZQ==
X-CSE-MsgGUID: 6FlmAzNGTwmOOwqkGkANTw==
IronPort-SDR: 6579c1ef_9fQJLxIh06Qw4+Sl5gyIhw+lAqbMU1V9935hCf4t7hLuZpc
 ImU1tlmF1XKCCcvGDuqEkOwmSwXDuyag5InZkpQ==
X-IPAS-Result: =?us-ascii?q?A0DOBwBtwHll/3+zYZlaHgEBCxIMQAkcgR8LgWdSBz6BD?=
 =?us-ascii?q?4EFhFKDTQEBhS2GRoIhOwGcGYJRA1YPAQMBAQEBAQcBAUQEAQGFBgKHLQInN?=
 =?us-ascii?q?wYOAQIBAQIBAQEBAwIDAQEBAQEBAQEGAQEFAQEBAgEBBgSBChOFaA2GRgIBA?=
 =?us-ascii?q?xIRBAsBDQEBFCMBDyUCJgICMgceBgENBSKCXoIrAzECAQGiIQGBQAKLIn8zg?=
 =?us-ascii?q?QGCCQEBBgQEsBsYgSGBHwkJAYEQLoNihDQBhEVXSoQ6gk+BSoEGgi2ECoQUg?=
 =?us-ascii?q?miDZoU2BzKBSFmDUZE2fUZaFhsDBwNWKQ8rBwQwIgYJFC0jBlAEFxEhCRMSQ?=
 =?us-ascii?q?IFfgVIKfj8PDhGCPiICPTYZSIJaFQw0BEZ1ECoEFBeBEm4bEh43ERIXDQMId?=
 =?us-ascii?q?B0CMjwDBQMEMwoSDQshBVYDQgZJCwMCGgUDAwSBMwUNHgIQLCcDAxJJAhAUA?=
 =?us-ascii?q?zsDAwYDCjEDMFVEDFADaR8WBBgJPA8MGwIbHg0nIwIsQgMRBRACFgMkFgQ2E?=
 =?us-ascii?q?QkLKAMvBjgCEwwGBgleJhYJBCcDCAQDVAMjexEDBAwDIAMJAwcFLB1AAwsYD?=
 =?us-ascii?q?UgRLDUGDhtEAXMHpQwgATw+EwkCgTJsLxyWFwGvBweCM4FfoQ8aM5cxklYum?=
 =?us-ascii?q?BUgokYHhUMCBAIEBQIOAQEGgXkmgVkzPoM2TwMZD44gOINAj3pCMwI5AgcBC?=
 =?us-ascii?q?gEBAwmCOYY1gXMBAQ?=
IronPort-PHdr: A9a23:RBL2yBXF6JF/qooYCHuLyNscVSLV8KyzVDF92vMcY89mbPH6rNzra
 VbE7LB2jFaTANuIo/kRkefSurDtVSsa7JKIoH0OI/kuHxNQh98fggogB8CIEwv8KvvrZDY9B
 8NMSBlu+HToeVMAA8v6albOpWfoqDAIEwj5NQ17K/6wHYjXjs+t0Pu19YGWaAJN11/fKbMnA
 g+xqFf9v9Ub07B/IKQ8wQebh3ZTYO1ZyCZJCQC4mBDg68GsuaJy6ykCntME2ot+XL/hfqM+H
 4wdKQ9jHnA+5MTtuhSGdgaJ6nYGe0k9khdDAFugjlnwXsLoky3Xt/Zf5yOTI+jMR+A5dXek9
 oRZEQHLrHtdOR4g8WqNu8gtvqAGoS2A8k8aocbeNaSvHupxPYzEYuozFGhPDpdvBhYGP6WtR
 LpTINoDYMBykZXH/Xcp9yKSOyOhP8rV1RVRoG3U4bNgwd0zQAOY0wMtWIkx923VhsXzK54Uc
 rGol42ZinLSS8oPyzTM6NXkeUB84s+0XZ1zK8XgwxYwKxnl0F/Lg9DvGzGb1eoNqzGy0shOC
 MeThD4gkhNroWmo/Z8qm4OUvN84+kH47zhd8q0Sf/+BaHNeZu+uH84D/zHfNpFxRNslWX0to
 ish17ka7IayZzNZoHxG7xvWavjCdpSBwTu5CqCfOz5lgnJidr+lwRq/ogCsyez5A9G9y00C7
 jFEnd/Fqm0X2lTN59KGRPpw8gbp2TuG2w3JrOARCU4unLfdK5kvz6R2kZwWsE/ZGTTxllmwh
 6iTHng=
IronPort-Data: A9a23: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
 tV030UDOQ==
IronPort-HdrOrdr: A9a23:2UfVDqM/OqxBd8BcTj+jsMiBIKoaSvp037BL7SBMoX48SKalfq
 WV8cjzuiWE7Ar5NEtNpTnjAse9qBrnnPYf3WB7B9aftWfd11eAHcVL9ovoy3nMBzb3/etQ+a
 Npc607Ncb5B1p3lub2iTPIduoI8Z2u66CijaP51HdiTQZjdqFm4UNQEx+fEkd/WQlBAvMCZf
 ihz/sCjyGhcnxSSN+6CHkDV/XCoNOOr57vZBpuPW9F1DWz
X-Talos-CUID: =?us-ascii?q?9a23=3AGAhmHGrQOhPNTOwu6JHdyIPmUcR8UVz003ffHxa?=
 =?us-ascii?q?bMmNHRJqlaFO+ypoxxg=3D=3D?=
X-Talos-MUID: 9a23:5mpvQggIvjIgcStTmuYfssMpauls5o28Lm8xjpAhnNadNgNzEhGhk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,272,1695679200"; 
   d="scan'208";a="73956635"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA26.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:38:39 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 13 Dec 2023 15:38:38 +0100
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (104.47.7.169) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28 via Frontend Transport; Wed, 13 Dec 2023 15:38:38 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvwT4mE6ADU6Vny9aWCUkiGrKHvTEkuHlrHEDQcPsuvExz1qKtadM5jq0/TVswh3njiwJG7dU0Y8tx9GnvbaKk6hxTbxIHqr36lPpiDkwolkH2mExX8NobXGfdegUU/BGbRre0nyoEcZZ/ndcXUhxQih6Zrye0zkxRZw5SgDv4DdJTe0z9KxrrE6a0AU+mZehEry/xQgMsW9pjaYGk/vv0GlW5Gp/uTkBm87VktIpUi51mWamfhJiSY/8Azmq0CgJ1hYp815iA2QQclMPzamroT2ou5FraGj8pg3HoMObYNFCrhLTiUuAynl60lqks9A/IWZHUKHVj7utVJgmQ/ZQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qInEitJWbavMRb8eD+nqKZ1vKL42fHqic2Yl5Zj5iWI=;
 b=gUaglQ9ocs72jKpHAvGAfDH92UX7sP7fxFUQInaU/uICRzmMLV55MGmQ+q/LOILHhLLoek3JqiH/b1nIcGt50Q94P2KI3x0l+d6DDXwo1wzF5AIPAeQ7DbIGxdDkmb/ZVY4S/Y2x5+VqtL2W5TkxMHEiQ70b2HgiHfda03RwnOom68KC+sCK4GPXv0zfZOkhjkYmqNIdBGKPe5vQ7webCjv0WoOlEDVV61caBHzZZbWOm30LidUsM96bioz2c4s35/9dd5qpn7rzp5D9JG7CiB7U661mtC0ZhNsf1ybuun5kVdCisr8dQsKY7ZFq2udnjGd7HEf7Itk5/VDngTtehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qInEitJWbavMRb8eD+nqKZ1vKL42fHqic2Yl5Zj5iWI=;
 b=MRBxg+GqwQA9jf89V9R/UNyCY4GXj5NBVtR2DO2QDVBeSARwBqNzJTv2zQz9j6gge/3W/qiBxnwQnK9u3L9//yLQ1zkYh5Dc85+VPhGk2gYb7wTrH6b3B4bLjfkfhp1AUJF5MTg8oQzrk9oS0nyb5R5EXyTruLZCO2JQHUMoYbg=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by FR2P281MB0026.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 14:38:37 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d273:9b9b:dadf:e573]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d273:9b9b:dadf:e573%3]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 14:38:37 +0000
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
Subject: [RFC PATCH v3 2/3] fs: Make vfs_mknod() to check CAP_MKNOD in user namespace of sb
Date: Wed, 13 Dec 2023 15:38:12 +0100
Message-Id: <20231213143813.6818-3-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
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
X-MS-Office365-Filtering-Correlation-Id: 4d387641-8229-4b0d-6be4-08dbfbe93152
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Efena57SBdHhQOhS3PL7/J3MV5xj2ZTnE7K5rFX+Ilb3P/l7q2SbyrpdWK1Op1NRDB/84tPFK1MQvXJKl7W44qyIkUl5Dl0KNiFtXl9fsyUPsxGFp15E+8NbptoALdFJ2IUkQe0dywmoHA9Wtu88j1kLnnVCuU8rAZpZszbf/kBIoWLQwX8rcpCqlpQzHo6PsdfEdc2/8LaDyf0oLQBwdrbuX5rFiLLilnmMtHEiVWavsWGChuAgtCNfKrnLUec+s5NOB7EtOlxuMYlqkPCn8/xEwqcqrsgaFK9nKABA5S1LefHu4klb4arWAh7SS8OSUv/hPzXLrvVjLFeDDn7yqHjoSdSAzlTf6n6RuiKIhFmoAk0HLAKrem6e5Y6BRJ6RdQXmPnH1Dotr+JIea99is5m3ihsVsMA2VH+aq/1JytgCgE1SIRaK3l/1CLXtd8KFYbGkZyrpYVBg2og9QlFLHtBbGwRPpZGT/Ecf51pk1Rlmodj+xJr5SSD3/+PbpaZcin2ELLOqdlDbvfPcMJUvFGmOx7S4QD/OQFJvVUMivDLPFnf9fR8Tl8n1mGZYzS1/9ZV70PD16mCJ9NSl0zMSkXDu2oi3A4xfRSCFEVr3H2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(107886003)(38100700002)(8936002)(316002)(54906003)(8676002)(2906002)(7416002)(4326008)(5660300002)(66476007)(478600001)(52116002)(41300700001)(66946007)(6512007)(6666004)(6506007)(110136005)(6486002)(66556008)(2616005)(1076003)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bExnM3lnc2ZMb090ZEw4NXBQS2JMeDZLcmMrUHdwQktKYm9PSVlTTTJKbTRN?=
 =?utf-8?B?WWZMRnYvSm9OeXFQZDlyV3JoaUIrMEd6TVlHWElKMG9hNjFmMG9aUmF5R1NR?=
 =?utf-8?B?QlRGN2hma2NSVWVWaGJjcVJ5Wnp0Y2hCQi84VnJkRUNLZjNJSTEyY2VweDZC?=
 =?utf-8?B?ajA4cjRtbjVZR2pOR2UwaHJsV1k5K0FrWW14SHlVcVdxcEhEVkkyd2hNU2xX?=
 =?utf-8?B?bVppMEwxVVpPY3RBOUNXNDR1MHlDUk05am8waThuQjFkKzJsam9jaktpVUxa?=
 =?utf-8?B?U3NGRG5CVkpXbWNtcUVKU05mVndpNVl6QXNEV2ZDVGRrNCtRenFucWNuUm5u?=
 =?utf-8?B?T2hCcHl2VW4xZTBya1ZKQ2RnQjRsU0Z2ZDZDRDBZblkvVUJ3NkdVWHpFR3ZB?=
 =?utf-8?B?bnpEUi8rbHRBVkExcWRHdVNQY2RQSTdRZmYyUEhoN0hBaC82NTJHSnRWMEJQ?=
 =?utf-8?B?eEcwOWU5WnZLYVdRTkFaSU9EcjM2cVEzR2FQR1N5V0ZkR0RUNmZGbk5aOFBo?=
 =?utf-8?B?VllLN0ZKcXVLV2gyUUNNVUtEMXllejRkcndNSFBGdXpQUVlZNTVEemhVSWNz?=
 =?utf-8?B?SFVBMlNwSDJCWFo2WDJaVjhtUCtPOUZIMSt1QUUvNjZNc01abDJ6azcwWWdu?=
 =?utf-8?B?N3BiYXJuWkJnNHVIeklIN3p3SFRTUUhESDJPQTA5aFNhTEpYNkt1SXM0enIv?=
 =?utf-8?B?OXYxV3FWUXBQNVhEQUdLRFpQc2pIUDhIZW9HVTRRcWo4Sis1M3kzRXRtdXhN?=
 =?utf-8?B?MzZWSkswS2dGWHBUaFF6Y0l4YWVCOU1CNk0wZGhDSG5nWEZLMndOdVVYRkJS?=
 =?utf-8?B?NjVjbkxPYXlweG1ZUXNkaGJ6MTM0d0h4UXgzSElqT01FejNyVzl3amY3bis4?=
 =?utf-8?B?emdBVGFOeVFxQm9ncU5pTDFkdVBmUjVjdzFNbEMrdHphWTYyS3QzSHk3eWQ3?=
 =?utf-8?B?L1dRN0h1R2VBT2pEWHp5elZENC9LMXZ6eTFFazRRTHFhV1FMMTBJK3cyN1h1?=
 =?utf-8?B?YUZ5UFpHRkp1ZXQ3OVAvTkg5c2VIck5MYktkcmsxRWlJY0dTejU4bGJ1SzdJ?=
 =?utf-8?B?VGRBOUs0UUg3MkNsL1N3N21xd283YzZMSHErT3A5TkQ0ZmY4MEJjMnNCbmtx?=
 =?utf-8?B?d1pvNjNZaXJNWFN2L2k4MzJRVlJ6MTRYYkdtRHYzeTVXUzBoS1JGRVNMMVdC?=
 =?utf-8?B?WXdveS9QbnNQbnpMdll4Mk04Q2NVOEUrQ24zZjNpaGw2YmhadDB3cGJvMU03?=
 =?utf-8?B?L1JScVFVY1NjYzI0TWVmVnZhR3pSTVBubEs2M0ExZ0w4enRMZlpxZVhtdEN3?=
 =?utf-8?B?Sk5sMjRkQ0p4bE5TQlVjbXVGQy96cmtQWVZlRWFUSnVSbzNVZm5IbjZrN1BG?=
 =?utf-8?B?c3pwMWJRdUJIWjNDclNhdUdCeHhMMnN2STdXNS9VSlg1ekp1UlhKT1VEZXB4?=
 =?utf-8?B?MW4zVUtWNFI0T290T2JMajhPT0xSeXVJK2FmdW9vdER6Zm1rTTFQc3RZcjRR?=
 =?utf-8?B?dlNIendaYjR2c05kUFQxL29obzZtaXdjNkxmS2ZwdnMxT0theVpLTlNNTlIw?=
 =?utf-8?B?dWZLOFE0UDM2b2x2Q05ieXlGS0toVHJFQzBWcDMveEMyNng2emQ5WjM5RkNK?=
 =?utf-8?B?V0xwS3FMc3B3eFFSUGtCWUJ5SjFGeUU5ekxvYnM5MS8zb2lubE4zV2N1Nmx4?=
 =?utf-8?B?d3NsUVZYaXRvRmRrcGJoaWVHbXlLalFJV1pOaHZDTXFGeC91YzZ4Um9UV3N0?=
 =?utf-8?B?bkM1SUpYVUxvNFdFZk1UZGg5eFg1Zy9DdGo0cXQ3aFBRcGNBUnRqakZNTE4w?=
 =?utf-8?B?NzVVZWpSdEh1ejF6bTcvZkNzNzBRd0Jka2FUTElTQlB0eitzK3dEMWpIeFFI?=
 =?utf-8?B?YW1tV1c1ZzdwYkxKRlM1emRlZmtpSC9KK1F5SzZZc2JLTXczdE9xZm83R2dL?=
 =?utf-8?B?WnhvL3hDdXJ1M2p3WEYrOTJDU2g3QUpUNWFTQVdUZjVoSTByZWdnbnJUU2dn?=
 =?utf-8?B?aWZQYkR6TmFtOVBoNEhYdlF3M0N6ZEpUbzVBY2toaWxDMlo2QXVCUjZFRGpI?=
 =?utf-8?B?aTZkcU50RTJPamo1ZWFsSHA1Z2Y3alNUTXpjcnE0T0JFRkF6ZXVndUFVNzRS?=
 =?utf-8?B?cStmVVBGaGdmbzZMZDI4NithQ3l2Ym5CbmJHV3dMMTRhdjl0VU9BTS9TMGM1?=
 =?utf-8?B?dCt0b2YySWdBQW1GdE1ob0VXTmEzR3JGU2dWdHRxek83eDFxUjUyMTZDajFj?=
 =?utf-8?Q?XU3v2sKwsrAU9WddKXS+T3yeQhFzqlSG/W8zARW6cU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d387641-8229-4b0d-6be4-08dbfbe93152
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 14:38:37.8133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inWNPP5rXJPv8+40/lfU8h0e0fVzINWORuOy67+OHCfHVAdD495BTkRB4LsnY3H1RbLYorZVejGWmB96CXK5N6Ab3tdCD6e20TClnq//nixv0NNNs1588LkUpBv9SQ9D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0026
X-OriginatorOrg: aisec.fraunhofer.de

Check CAP_MKNOD for user namespace of sb with ns_cabable() in
fs/namei.c. This will allow lsm-based guarding of device node
creation in non-initial user namespace by stripping out SB_I_NODEV
for mounts in its own namespace.

Currently, device access is blocked unconditionally in
may_open_dev() and mounts inside unprivileged user namespaces get
SB_I_NODEV set in sb->s_iflags causing open() to fail with -EACCES.

Device access by cgroups is mediated in the following places
1) fs/namei.c:
	inode_permission() -> devcgroup_inode_permission
	vfs_mknod() and -> devcgroup_inode_mknod

2) block/bdev.c:
	blkdev_get_by_dev() -> devcgroup_check_permission

3) drivers/gpu/drm/amd/amdkfd/kfd_priv.h:
	kfd_devcgroup_check_permission -> devcgroup_check_permission

We leave this all in place. However, a lsm now can implement the
security hook security_inode_mknod() which is called directly after
the devcgroup_inode_mknod() in vfs_mknod() and remove the SB_I_NODEV.
This will let the call to may_open_dev() during open() succeed.

Turning the check form capable(CAP_MKNOD) to ns_capable(sb->s_userns,
CAP_MKNOD) is inherently save due to SB_I_NODEV. However, this may
allow to create device nodes which then could not be opened.

To give user space some time to adopt, we introduce a sysctl knob
which must be explicitly set to "1" to activate the use of
ns_capable(). Otherwise, we just check the global capability for the
current task as before.

I tested this approach in a GyroidOS container using the small
devguard LSM of the followup commit.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 fs/namei.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 71c13b2990b4..cc61545e02ce 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1032,6 +1032,7 @@ static int sysctl_protected_symlinks __read_mostly;
 static int sysctl_protected_hardlinks __read_mostly;
 static int sysctl_protected_fifos __read_mostly;
 static int sysctl_protected_regular __read_mostly;
+static int sysctl_nscap_mknod __read_mostly;
 
 #ifdef CONFIG_SYSCTL
 static struct ctl_table namei_sysctls[] = {
@@ -1071,6 +1072,15 @@ static struct ctl_table namei_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
+	{
+		.procname	= "nscap_mknod",
+		.data		= &sysctl_nscap_mknod,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 	{ }
 };
 
@@ -3940,6 +3950,24 @@ inline struct dentry *user_path_create(int dfd, const char __user *pathname,
 }
 EXPORT_SYMBOL(user_path_create);
 
+/**
+ * sb_mknod_capable - check userns of sb for CAP_MKNOD
+ * @sb:	super block to which userns CAP_MKNOD should be checked
+ *
+ * Check userns of sb for CAP_MKNOD
+ *
+ * Check CAP_MKNOD for owning user namespace of sb if corresponding sysctl is set.
+ * Otherwise just check global capability for current task. This allows
+ * lsm-based guarding of device node creation in non-initial user namespace.
+ */
+static bool sb_mknod_capable(struct super_block *sb)
+{
+	struct user_namespace *user_ns;
+
+	user_ns = sysctl_nscap_mknod ? sb->s_user_ns : &init_user_ns;
+	return ns_capable(user_ns, CAP_MKNOD);
+}
+
 /**
  * vfs_mknod - create device node or file
  * @idmap:	idmap of the mount the inode was found from
@@ -3966,7 +3994,7 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		return error;
 
 	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout &&
-	    !capable(CAP_MKNOD))
+	    !sb_mknod_capable(dentry->d_sb))
 		return -EPERM;
 
 	if (!dir->i_op->mknod)
-- 
2.30.2


