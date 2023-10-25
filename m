Return-Path: <linux-fsdevel+bounces-1145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7E77D6742
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 11:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86FBDB21472
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 09:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD623266DF;
	Wed, 25 Oct 2023 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="xS+RGo9s";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="HVNRq5uD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD241A599;
	Wed, 25 Oct 2023 09:44:08 +0000 (UTC)
Received: from mail-edgeka27.fraunhofer.de (mail-edgeka27.fraunhofer.de [IPv6:2a03:db80:4420:b000::25:27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EB9DD;
	Wed, 25 Oct 2023 02:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1698227046; x=1729763046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=gv9yrbDlT55tNu9gSi5nUtsqTT5sNurOJOivF+/yNDw=;
  b=xS+RGo9shBJCSWeJtZT/8ZKPAamFLIPU1UYDbQKuPFE6n1/DCdWpwqgL
   ZqaHdMTvyV6ZEnK2dnB+UTwVrwAtChriUstUfd4FWZvlH5MS1gRakWYwi
   0PNDSYSh0kixV+wrNgdyj3wuE6j5UGzPmSAK/n6DsQGk7+9vr0dFN9PXU
   GCf/a+Rs60a/JCLgEcvZntdRF+ubSemE4QnklFDm5YE5nWDyypUGLMvXi
   zriSjHAqHqyMWwUmiT7/miHx8nTW7QKgTGnIzDAAKiIK9iTd6/0ZPI15M
   afGA/L1SxFk9L6tKknnFhxNICms7aYdJeLNXjc8XvBUxG6tr3TM9+Kuql
   w==;
X-CSE-ConnectionGUID: i+AxNexJRu+qNaabQM866A==
X-CSE-MsgGUID: X8UfNcKgSD2EPuLqF5Ciyw==
Authentication-Results: mail-edgeka27.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2E2AABB4jhl/x0BYJlaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YI4gleEU4gdpWsqgSyBJQNWDwEBAQEBAQEBAQcBAUQEAQEDBIR/AocaJzQJD?=
 =?us-ascii?q?gECAQMBAQEBAwIDAQEBAQEBAQIBAQYBAQEBAQEGBgKBGYUvOQ2EAIEeAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQI1VAIBAyMECwENAQE3AQ8lAiYCAjIlBgENBYJ+gisDMbIYf?=
 =?us-ascii?q?zOBAYIJAQEGsB8YgSCBHgkJAYEQLgGDW4QuAYQ0gR2ENYJPgUqBBoIthFiDR?=
 =?us-ascii?q?oJog3WFPAcygiKDLymLfoEBR1oWGwMHA1kqECsHBC0iBgkWLSUGUQQXFiQJE?=
 =?us-ascii?q?xI+BIFngVEKgQM/Dw4RgkIiAgc2NhlLglsJFQw1BEl2ECoEFBeBEW4FGhUeN?=
 =?us-ascii?q?xESFw0DCHYdAhEjPAMFAwQ0ChUNCyEFVwNEBkoLAwIaBQMDBIE2BQ0eAhAtJ?=
 =?us-ascii?q?wMDGU0CEBQDOwMDBgMLMQMwV0cMWQNsHxocCTwPDB8CGx4NMgMJAwcFLB1AA?=
 =?us-ascii?q?wsYDUgRLDUGDhtEAXMHnU2CbYEOgliWLgGueQeCMYFeoQkaM5crkk8umA4go?=
 =?us-ascii?q?j6FSgIEAgQFAg4IgWOCFjM+gzZSGQ+OIAwWg1aPe3QCOQIHAQoBAQMJgjmJE?=
 =?us-ascii?q?gEB?=
IronPort-PHdr: A9a23:sVzF9RBsaOfoHmq1OLKhUyQUPkIY04WdBeZowoRy0uEGe/G55J2nJ
 0zWv6gz3xfCCJ/W7/tUhuaRqa3kUHwN7cXk0jgOJZJWXgIDicIYkhZmB8iACEbhK+XtYTB8F
 8NHBxd+qmq2NUVeBMHkPRjcuHSv6z4VFBjlcA1zI+X+AInJiMqrkuu1/s62AU1I0RSnZrYgA
 ByqoFfqq8MUjIB+eIM80QDArXYNWsgE7mRuOV+Vg1PA99+9rrtC1gkVhf877M9HV/fKOoEDC
 JFIBzQvNW84ofbmsxXOVyKjzXsRWWZF93gACQiQvTuhQLitmzLBtft71BiDDePdR+otWAX9w
 KViFhn4qS0FPDcU+W/8s/dti/cIxXDprUlf/ajuedyIGOJRRJv6UPVDGWBefe9eCnBqUqmcd
 7IdP7paE75+n5PToHocqB6gL1a0KOj+zR9Y22PX/IMz7M45Plzi4z18HehRlTfkt8/fNoUtf
 +Ll57f44xj+ZbQL5mfetoXTVjELnq3UXIkpS5uS02YNGQ7U0UmBitH+Dm2KiPownHWZydA5C
 N2zjF47igJypwSw7eMMjZPv17Mc81vfqABa3K8TJ+SoUBIuMpa0VZpKsCeCMJFqB9kvWHxsp
 HMiw6Yd6vZTHQAPwZUjghPTZPGEetLXpBz5XfuXITB2iWgjdL/szxqx8E310uTnTYH0y1dFq
 CNZj8PB/m4AzR3d68WLC7N9806t1CzJ1lX75PtNPEY0kqTWMdgmxLsxnYAUqkPNAmn9n0Ces
 Q==
X-Talos-CUID: 9a23:ZQbSXGDurzwbMMb6Eygk3V4yF9AHSGCe1VHZKkWBLDY3FpTAHA==
X-Talos-MUID: 9a23:C7P2AwSi9cAikfNCRXTc1AxsEsxL7J+CUm01jLEflZSvND1vbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="1597260"
Received: from mail-mtaka29.fraunhofer.de ([153.96.1.29])
  by mail-edgeka27.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:01 +0200
IronPort-SDR: 6538e323_4JQlWwXat3Mn6HlFJZA6SkSVpu8cvPY28xR2+8iCx8lJ1Un
 m9trjJ27v1/lnRBwjc8W1LIahWzpTFyEBi0x6MQ==
X-IPAS-Result: =?us-ascii?q?A0BZAAC94Thl/3+zYZlaHQEBAQEJARIBBQUBQAkcgRYIA?=
 =?us-ascii?q?QsBgWZSB4FLgQWEUoNNAQGETl+GQYJcAZwYgSyBJQNWDwEDAQEBAQEHAQFEB?=
 =?us-ascii?q?AEBhQYChxcCJzQJDgECAQECAQEBAQMCAwEBAQEBAQMBAQUBAQECAQEGBIEKE?=
 =?us-ascii?q?4VoDYZNAgEDEhEECwENAQEUIwEPJQImAgIyBx4GAQ0FIoJcgisDMQIBAaUwA?=
 =?us-ascii?q?YFAAosifzOBAYIJAQEGBASwFxiBIIEeCQkBgRAuAYNbhC4BhDSBHYQ1gk+BS?=
 =?us-ascii?q?oEGgi2IHoJog3WFPAcygiKDLymLfoEBR1oWGwMHA1kqECsHBC0iBgkWLSUGU?=
 =?us-ascii?q?QQXFiQJExI+BIFngVEKgQM/Dw4RgkIiAgc2NhlLglsJFQw1BEl2ECoEFBeBE?=
 =?us-ascii?q?W4FGhUeNxESFw0DCHYdAhEjPAMFAwQ0ChUNCyEFVwNEBkoLAwIaBQMDBIE2B?=
 =?us-ascii?q?Q0eAhAtJwMDGU0CEBQDOwMDBgMLMQMwV0cMWQNsHxYEHAk8DwwfAhseDTIDC?=
 =?us-ascii?q?QMHBSwdQAMLGA1IESw1Bg4bRAFzB51Ngm2BDoJYli4BrnkHgjGBXqEJGjOXK?=
 =?us-ascii?q?5JPLpgOIKI+hUoCBAIEBQIOAQEGgWM8gVkzPoM2TwMZD44gDBaDVo97QTMCO?=
 =?us-ascii?q?QIHAQoBAQMJgjmJEQEB?=
IronPort-PHdr: A9a23:b0dI4h0vScq9Q4LosmDO5gUyDhhOgF2JFhBAs8lvgudUaa3m5JTrZ
 hGBtr1m2UXEWYzL5v4DkefSurDtVT9lg96N5X4YeYFKVxgLhN9QmAolAcWfDlb8IuKsZCs/T
 4xZAURo+3ywLU9PQoPwfVTPpH214zMIXxL5MAt+POPuHYDOys+w0rPXmdXTNitSgz/vTbpuI
 UeNsA/Tu8IK065vMb04xRaMg1caUONQ2W5uORevjg7xtOKR2bMmzSlKoPMm8ZxwFIDBOokoR
 rxRCjsrdls44sHmrzDvZguC7XhPNwdemBodUiKe8j6md47KsTr8uttk6AexN5fvTIFrdjars
 aF7aRXqgy4qPjASyVrKjZkj6cATqkeBmTpF2tPJTJm6DsJZU4WEIdkFZkNOA5p6BwZhGrquX
 9tUIbInDfx2qKjvol4Qh0SmKQK9A8P/lyNpp1H/4oci/LkFLjCa3jZ/OpE+q27+rvfKGqVCe
 v6F4oT1x3KeUKN1hzrmzKniTUx5oMrVZ+Mza+Xzx0Q+SB/UrQiLmNL6YS2o+fkPlVLCstV8U
 tKzqm0krj1uiRyPwd0K27jAv4kOl3Xn6Qxfwr8lPYHtGwZrJN++F51IsDuGcpF7Wd4mXzRws
 T0hmdXu2La+dSkOjZE7zj32Ma3BfZKB/xTjU+icO3F0iSEtdLG+gkOq+FO7gq3nV8ay2UpXt
 CcNjNTWt34M2hCSosiKQ/dw5AGgjB6BzQnO7OFDL00u063dLp8q2LkrkZQP90/EG0fL
IronPort-Data: A9a23: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
 GjqQ3eWqXWjspDJVXDFZ/py6UOsNc+2Iw==
IronPort-HdrOrdr: A9a23:7YmcYajFRMZLlXzps3wKGAcVDHBQXiQji2hC6mlwRA09TyX4ra
 CTdJZy73XJYVMqNU3I9urwXJVoLUmxyXcW2+cs1N6ZNWGMhILCFuBfBOXZrAHIKmnX7e5X3e
 NMb7N3A9j9IVxzjcO/3RKxGdQt2/mLmZrY4Nv2/jNEVgFgY+VH9Ad2CgGSD01wSk1vHIM9FJ
 CV+8pAoFObCBYqR/X+LmIEVOCGgcbKmpLgaQMHABBi0wWHiDfA0s+YLySl
X-Talos-CUID: 9a23:Xx0RpG9ojZRbiLQNMeiVv2w6P+k6X0fs9nKKMheqLEVRUoWOSHbFrQ==
X-Talos-MUID: 9a23:8Vy02QTm2u3QgnheRXTuhQ9oap5j5Z6RN0U0lY5bnsaGNipZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="64504541"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA29.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:42:58 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 25 Oct 2023 11:42:58 +0200
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.168)
 by XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Wed, 25 Oct 2023 11:42:58 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/HEfxQoU3o4NJzhOW2WBmpBBW8gJgF470SySJWi0rcRwSDQQO0BXX8RjvSfrl5z2irIjkTdlTdqLqfOHdgHlmXz//wYW8n0fG5dyX7O11wQSeDcOHGfYkIsd8t95rCEC6p/iGjm5HBLrKBjHaxhM3s7Wme6eZUiX+//jaFhDSQoDdG9O6trFatXYSwQKoVtBKIcTetsaIC7ZiWqNQQRfQIRSmTmL4gzfjWcKHkdJo6WdAPgzwenatpRE4HibJoYgeocC9vmW8LFR18OpwjrV3OCDcKF5PPrvHpbu7+ihuVMHUepu0Iq8QzzIcs4Oi70LM2Yh8TVyue+qpqerlRhWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9B3vG4AqSkyndYqXFCb2qiY7Gja6nxIbjcaEafCQSuo=;
 b=Piqo+u6AdWzZi8dseXJBAGBhY239UElLIZ8Ek306XUeL09RvHmHmCDHGKWUKWWdJibadROmH6lLoq/5gz+cDk7gYyoh0j8WRdVCK6uObe/4uJ5Fa8JyEUY+YnKbW+15nF9J+9RQgfmtx3vuAm8ZxHLmU9PFqynKB8ogDL5YhLstGT4D38vOGcG+Iq6K7a+XjqNIviwD0s4FpT4hi8clK4Z22OYlXAMy1hN5XngkwVf8tGCN7L6JH1BYZpl/w+kN2DyaaprPXaFszyXdn2eSV6M3RspdvvFpbk50jOnm8RavQsd+mHhds5ixcWtVkW+81fnX72hcJPy9r/9QLmsuGFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9B3vG4AqSkyndYqXFCb2qiY7Gja6nxIbjcaEafCQSuo=;
 b=HVNRq5uDpGRPOEN14bwKAg54C8BHpQzX83F0NXrFoIzmmvB7pDcyoHx5tIIFaWBpG5LWY4jR7M+XsrBjJWFj8CvXFEUb/5W8K6esLIBW40iS1R9+rGJfey7tyK5sY6w6vUGujNR15WtoXtIkkmTwCLHorN9YaQcs5MKtANjQxp4=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by BE0P281MB0116.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 09:42:57 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 09:42:57 +0000
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
Subject: [RESEND RFC PATCH v2 05/14] device_cgroup: Implement dev_permission() hook
Date: Wed, 25 Oct 2023 11:42:15 +0200
Message-Id: <20231025094224.72858-6-michael.weiss@aisec.fraunhofer.de>
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
X-MS-Office365-Filtering-Correlation-Id: 2a0e69d7-6565-44a9-6605-08dbd53ec503
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iRFrLvHz+bi/+pCJOT/RCSM4JL5AdLfabO1RJNi/Y51PNRTbEReB0BU3dSuEFYo0eQ4bZQJKC8XXBuGxeWnzjJz3zqHGLFI+dcELerXBRYPvna48q0XyR/olnZ0OCfOQ/35X9lZns+CX7QgMF/gjwlb8q24T3wQbDk41VwjWnuTr9XLIDI3XES4xsLPM/QcOvgQi7Nxnwf4Z+OTsStR0TWdLvhhCSmlzFduzIWiwDDrCDwbbxSw1YcQ7PUb8BzPJ1HO3S/i8vv3EqgQPUY8RAe5I2pCYVAGpAhfKLJqepbIx8pc9DudZ/TWyitjtdN6EbFOUoOMqi20Pmge7pkVpQexd4DT5ZLCCK/ATDQHWuU7MJJR+w3Wz03NyIszXfZo1w+f3AMZQmo6CvKX/NqM8gGwYxtk0cDE9PaLWNgPt5WEIE2QIajmkV2vxpHYIJCsq16BpuwD7M2+RS1yZvDgKcHYELuvw3n8uTuG6+EjoWUWwXhaEd3G+7AQPwmpQjmdvLpja8mWsPnp4BqXIvh0CKAB+K0A3zynt0DP1uR25UfuTSIP7mHLIkgwP1BmaL2DHrRKqShAgRRdDZZy42KFbf5sFDisyYCwBQfFcm9Fh488=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66946007)(83380400001)(316002)(38100700002)(6486002)(478600001)(6666004)(54906003)(110136005)(66556008)(66476007)(1076003)(107886003)(52116002)(6506007)(2616005)(6512007)(7416002)(2906002)(86362001)(4326008)(8936002)(82960400001)(8676002)(41300700001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDNoMlhTV0F4QkNKR2U3WlZDNnJ3VVl0bjBFeTJ5c2pLWWF4cG5GdzZGdndu?=
 =?utf-8?B?dDJmOElzTm9vZjgvK0xRdkpkbU5MVlIwQkhPUWpwTURKYUJJY0VyUGtXKzNN?=
 =?utf-8?B?dkFudmU1N2FXNlBaQVhJRFdHaWMwTUFvRER5SkZaRVZXVUs2QURaWDRTWEZr?=
 =?utf-8?B?VnVsSzgrdjU1cURqTlVJZlB1QzlFVHZSNHpSWktUeDFJeDU4eVprN1M1QU5K?=
 =?utf-8?B?T1NpTURXdWlJeUJYUzdPeUZKc0FYaHcvQnU4SVhoU2w4WUo1NHZHWmFMeGtm?=
 =?utf-8?B?R0w3NjBEcDhGY1BtY1lzRXVmUmlCbFJ0MW04b3phR1NBRnBnK3R0d0YzSjFy?=
 =?utf-8?B?NERLenFVcjloUk5FVVI3QTNLSkk0QVYrQTVZcThUa0JjQjcvNGZoWGtyS1E1?=
 =?utf-8?B?OHh0a2g2MXg1OTdpK2l0Mk51N29DMkJZYUxCYlFJbDRTL21KWnVYVnZFd3c0?=
 =?utf-8?B?OTdhNEs4M1RYb2Nma3BSRWhuRlE5YldXR1JrMWpRWHpmUWhMb3Jwa29tNnYz?=
 =?utf-8?B?QzFBNEdJUlVGd1VybFRSVUEwUXE2bVFJUjhTYm0yaXVuRlNoNXUvV3JkY3VF?=
 =?utf-8?B?U2lpWms5WEJ3MWNQMHJRNW9Da2NXbnNCYVNkZzBua1pCTEIyTmRSaTYyZ013?=
 =?utf-8?B?L1cvTUxBZ2MvSFlLWXpoc3pUK1JnazRqZFh4VVEzRjkrNjY1MzhwY2t3a0x5?=
 =?utf-8?B?ZHcyeU44WjFSSmxvYkJ0T01jOWNGdk9VU1Y0SXNLc3VwbHplRzkyZWZYZ25r?=
 =?utf-8?B?V3dTRTRuUnhVdjYzejJLTVltMTlkajYzSVYyaDRVUVFCUkRMOGxUWXB5WHBJ?=
 =?utf-8?B?MFdmNVJnWjBZRXBGdWdidkh4cC9xOUtQNzdaZ2VTQ2dTT0ZudkNGQnJIRENp?=
 =?utf-8?B?UlRpNFJXd1lpYXZPdW15MytZVWUvaVNvU3hJdUprUWdkMkJLdVRHYWhCQU5Z?=
 =?utf-8?B?VENCVkR1ckJVd1UweG5Uc05kOC8wa1IzclBUWHRQdmd4WVpwOVg4NkdyMW1x?=
 =?utf-8?B?bk9MR0ZKVDVUd2NSc2l0c1R6aDJlOGpUWXhpeUwyMEZYN29CaTY3dEM4ekY5?=
 =?utf-8?B?RkVUWm45c2c2RFBETktmYzdWa21NNER4MFRhQXEvMnkwMWkwbGlhdFl5NkMw?=
 =?utf-8?B?a2Z4eFUvbkJFRmJsUUt5aGlBN29XcFQxUDF3NHBXMXkvblFMV2RseGtCcTkr?=
 =?utf-8?B?THMwZDl1NzByWDhocUpYUnFWeFZaM01YdkpTNlpkRDM5elQvN0JtcWdYZjhZ?=
 =?utf-8?B?NW5YUVk1Q0VkbU11OUhJV1VqbmdVbXpkTlIyeW5SVlBGMUh4MWNVNjVvQnNv?=
 =?utf-8?B?elB2ZVlkV0hwbDlVTzBmKzQwNVlsZzU1clA2aEhnUFlPRDg3RW5uM0VmUS9U?=
 =?utf-8?B?ZWNtWW9hSm9HSHljQndDZVhZRzNYb3R1TE5Ycmg4cjRmZ2tpekd1R3cvZlZh?=
 =?utf-8?B?MTdpckh5dnB0SWJDQWk2Q1hUS1lOd252UVBnVElENGljUGJlMXhseFZ4YnRo?=
 =?utf-8?B?amhXSnVXc2pZUXgxTjZIbUdaQWJ0bDNqMGFEVG1PYWdRMHlRbVgwT25Hcnlj?=
 =?utf-8?B?OVN4RnIwc1hBWVhRNGFEckxUbWxFNlNTQ05hQmpkS0VUSWRlbkZBdjl0eUpx?=
 =?utf-8?B?NGE5ZG1oWVBaVGE4TFBOZTVxbmJmSlRTODU3U04zYkhGOGZPNXIrbXIxc21l?=
 =?utf-8?B?YmhjNWo2QUc3V0lldmhBRnp0amFtdmJCRUlCdXZ1QTVQRkJWTVhyZmg2c0hM?=
 =?utf-8?B?MUlaZGFGaVdtWlRRR1JTVVVhVmpXRjlFNjBoSm81ZGNsTXlUdStJZmdTb2Rh?=
 =?utf-8?B?WUI2WktoaWxWb3F6OXRrS3I4azBqNVFBQ3BCbWpHeWVQNmJxbm9CNTNTOVpZ?=
 =?utf-8?B?dTNCRUpVNjdNdnVBQ0x2RHBqZ2VxUFdjR3o0d3FzR1lKbVB2akdmcjFtVEZa?=
 =?utf-8?B?ZnB2QWZUVlorNmNMbnc2ZzBMeHIwSTQ5UGt1SmJvdUxMZ3Q3dHVSejcwcWwy?=
 =?utf-8?B?V29hMHA3QTBlam43K2J1QUpiSEI0S3ZHd2xqOUtmUUx6YkM4djNyRWNvTmRZ?=
 =?utf-8?B?NlhQVlVtd1U2NUlqaXB4WG9RTncwOTFwMk91cUx3a2ZUTGVlUGwvUUlacmt5?=
 =?utf-8?B?bGZveXZyMTdERnZQeFluU3ZIWjE5cENJN1Fuc1hub0NRY0IzcUg5MU9lUCtI?=
 =?utf-8?B?cVplUWlSZWpVang0S1ZjWWRVVTQ4Wm12Z3V1eTduekJlU0tKa3JHdkVuZ0JV?=
 =?utf-8?Q?dhliJDhWuWCKR+xaSUT9GobkcTkk/cKYBYfPiC0ho4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0e69d7-6565-44a9-6605-08dbd53ec503
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:42:57.4355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJFKSi7qN4GDjSpm4p59ogIROeXx/9+GGfkvzU/cJ6Wcym482w5KH/Ssuaab3wmEkqPw9/P+rgireMePHwE7E6WDV3bkcETBk+XJMisBM6D2Ix8LTPiz3wTi+88RYQww
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0116
X-OriginatorOrg: aisec.fraunhofer.de

Wrap devcgroup_check_permission() by implementing the new security
hook dev_permission().

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 security/device_cgroup/lsm.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/security/device_cgroup/lsm.c b/security/device_cgroup/lsm.c
index ef30cff1f610..987d2c20a577 100644
--- a/security/device_cgroup/lsm.c
+++ b/security/device_cgroup/lsm.c
@@ -14,29 +14,32 @@
 #include <linux/device_cgroup.h>
 #include <linux/lsm_hooks.h>
 
-static int devcg_inode_permission(struct inode *inode, int mask)
+static int devcg_dev_permission(umode_t mode, dev_t dev, int mask)
 {
 	short type, access = 0;
 
-	if (likely(!inode->i_rdev))
-		return 0;
-
-	if (S_ISBLK(inode->i_mode))
+	if (S_ISBLK(mode))
 		type = DEVCG_DEV_BLOCK;
-	else if (S_ISCHR(inode->i_mode))
-		type = DEVCG_DEV_CHAR;
 	else
-		return 0;
+		type = DEVCG_DEV_CHAR;
 
 	if (mask & MAY_WRITE)
 		access |= DEVCG_ACC_WRITE;
 	if (mask & MAY_READ)
 		access |= DEVCG_ACC_READ;
 
-	return devcgroup_check_permission(type, imajor(inode), iminor(inode),
+	return devcgroup_check_permission(type, MAJOR(dev), MINOR(dev),
 					  access);
 }
 
+static int devcg_inode_permission(struct inode *inode, int mask)
+{
+	if (likely(!inode->i_rdev))
+		return 0;
+
+	return devcg_dev_permission(inode->i_mode, inode->i_rdev, mask);
+}
+
 static int __devcg_inode_mknod(int mode, dev_t dev, short access)
 {
 	short type;
@@ -65,6 +68,7 @@ static int devcg_inode_mknod(struct inode *dir, struct dentry *dentry,
 static struct security_hook_list devcg_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_permission, devcg_inode_permission),
 	LSM_HOOK_INIT(inode_mknod, devcg_inode_mknod),
+	LSM_HOOK_INIT(dev_permission, devcg_dev_permission),
 };
 
 static int __init devcgroup_init(void)
-- 
2.30.2


