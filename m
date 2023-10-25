Return-Path: <linux-fsdevel+bounces-1143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1917D673D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 11:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C4528245D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 09:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5E2266BA;
	Wed, 25 Oct 2023 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="kBc2+AsX";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="LEHzHxtF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9A923747;
	Wed, 25 Oct 2023 09:44:10 +0000 (UTC)
Received: from mail-edgeka24.fraunhofer.de (mail-edgeka24.fraunhofer.de [IPv6:2a03:db80:4420:b000::25:24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17472DE;
	Wed, 25 Oct 2023 02:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1698227047; x=1729763047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6IS3qnmwyCNRIjvUFp2Jg7LA5SbSx9BBFQUcZ1ZIxA4=;
  b=kBc2+AsXYkIuJIJzy20otbVqCx7nmm1hk9jMnBEx8IstYupwpPe6CbZD
   dpZ5hB3DVkyHGaN8y13OiRY/6wVZQHicNFAl4qFC7lZVe5PHq+BjZN+Br
   DT+YjC86x3KlMYxFYI8tJ9YBnLR1JCv6/Rk8bFfTGGpdT6B1PO8I+zeiU
   UQgW8ADVdv97fN75ikva0h0JCX0dBABmTIdeS+V36NHjs4rhOiduyJIrw
   ow1i7KLH6rPz3a40s96eBAx10weH6mUIODJvFEom7MZ8H8H9c3JHQ22Xj
   EG3y3pbrxnCJJfLcbRt6fkhBjtiwC51aYs1IqSfqTCd35oX4f08otSZqJ
   A==;
X-CSE-ConnectionGUID: RzyV6OS0RqeDLXDwHmvM6A==
X-CSE-MsgGUID: aTEi1QIdQNS22hvwL+hBTw==
Authentication-Results: mail-edgeka24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2E2AABB4jhl/xwBYJlaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YI4gleEU4gdpWsqgSwUgREDVg8BAQEBAQEBAQEHAQFEBAEBAwSEfwKHGic0C?=
 =?us-ascii?q?Q4BAgEDAQEBAQMCAwEBAQEBAQECAQEGAQEBAQEBBgYCgRmFLzkNhACBHgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAR0CNVQCAQMjBAsBDQEBNwEPJQImAgIyJQYBDQWCfoIrAzGyG?=
 =?us-ascii?q?H8zgQGCCQEBBrAfGIEggR4JCQGBEC4Bg1uELgGENIEdhDWCT4FKgQaCLYQpL?=
 =?us-ascii?q?4NGgmiDdYU8BzKCIoMvKYt+gQFHWhYbAwcDWSoQKwcELSIGCRYtJQZRBBcWJ?=
 =?us-ascii?q?AkTEj4EgWeBUQqBAz8PDhGCQiICBzY2GUuCWwkVDDUESXYQKgQUF4ERbgUaF?=
 =?us-ascii?q?R43ERIXDQMIdh0CESM8AwUDBDQKFQ0LIQVXA0QGSgsDAhoFAwMEgTYFDR4CE?=
 =?us-ascii?q?C0nAwMZTQIQFAM7AwMGAwsxAzBXRwxZA2wfGhwJPA8MHwIbHg0yAwkDBwUsH?=
 =?us-ascii?q?UADCxgNSBEsNQYOG0QBcwedTYJtgQ6CKU2Se4MVAa55B4IxgV6hCRozlyuST?=
 =?us-ascii?q?y6YDiCiPoVKAgQCBAUCDgiBY4IWMz6DNlIZD44gg3iPe3QCOQIHAQoBAQMJg?=
 =?us-ascii?q?jmJEgEB?=
IronPort-PHdr: A9a23:3rWe0h2ruMTvgC8GsmDO+QUyDhhOgF2JFhBAs8lvgudUaa3m5JTrZ
 hGBtr1m2UXEWYzL5v4DkefSurDtVT9lg96N5X4YeYFKVxgLhN9QmAolAcWfDlb8IuKsZCs/T
 4xZAURo+3ywLU9PQoPwfVTPpH214zMIXxL5MAt+POPuHYDOys+w0rPXmdXTNitSgz/vTbpuI
 UeNsA/Tu8IK065vMb04xRaMg1caUONQ2W5uORevjg7xtOKR2bMmzSlKoPMm8ZxwFIDBOokoR
 rxRCjsrdls44sHmrzDvZguC7XhPNwdemBodASP87hLedK72r3LZ79p58RXDNO3UQpFzayy7y
 Lc6DxDSiAQMLjQZq2KUkZkj6cATqkeFijxt457ITsaYKd5OTITcftUlQToQHYVUdzZsIIHtN
 bQsFMQvNM0EtYD24F0ngBiUJ1L9Asni7mJEllzM2bMY8OkCEDvtnykwR9MCkizZno6rJuRDd
 8eUnanN1CTMUKwR4Tbf9ZfuYisRkM6XQ6BoLvvz5lhwSgLOi2nNoLD1YymY+uMgnk239steU
 uGhpV8+khlK+BmN980Gt87GvdkM8Fnu62J7/Lp2f9LtGwZrJN++F51IsDuGcpF7Wd4mXzRws
 T0hmdXu2La+dSkOjZkryBPcYqbbNYaS6w/lVOGfLC0+iH82ML68hhPn6UG70aW8Tci71l9Ws
 zBI2sfBrHED1hHfq4CHR/Jx813n2GOn2Rra9+dEJk45j+zcLZsgyaQ3jZ0drQLIGSqepQ==
X-Talos-CUID: 9a23:FAbIUGM7QxAag+5DYjt2yhAzIZgfa3Dx6Ef8PG+9F0M3YejA
X-Talos-MUID: 9a23:y4txPwQZtDcbqUvqRXTluBxjbf5J752IMxpXkYsZn4qEHxBvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="1802491"
Received: from mail-mtaka28.fraunhofer.de ([153.96.1.28])
  by mail-edgeka24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:42:57 +0200
IronPort-SDR: 6538e321_973YP11K0hq3C6HMmfGN+/8ABaxTXSb4AhUFMyoWpxQ/HW9
 hY5h4JdyAOEtKEvgEYj83a6moneVCK/wwhJL6LA==
X-IPAS-Result: =?us-ascii?q?A0BZAAC94Thl/3+zYZlaHQEBAQEJARIBBQUBQAkcgRYIA?=
 =?us-ascii?q?QsBgWZSB4FLgQWEUoNNAQGETl+GQYJcAZwYgSwUgREDVg8BAwEBAQEBBwEBR?=
 =?us-ascii?q?AQBAYUGAocXAic0CQ4BAgEBAgEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBBgSBC?=
 =?us-ascii?q?hOFaA2GTQIBAxIRBAsBDQEBFCMBDyUCJgICMgceBgENBSKCXIIrAzECAQGlM?=
 =?us-ascii?q?AGBQAKLIn8zgQGCCQEBBgQEsBcYgSCBHgkJAYEQLgGDW4QuAYQ0gR2ENYJPg?=
 =?us-ascii?q?UqBBoIthCmDdYJog3WFPAcygiKDLymLfoEBR1oWGwMHA1kqECsHBC0iBgkWL?=
 =?us-ascii?q?SUGUQQXFiQJExI+BIFngVEKgQM/Dw4RgkIiAgc2NhlLglsJFQw1BEl2ECoEF?=
 =?us-ascii?q?BeBEW4FGhUeNxESFw0DCHYdAhEjPAMFAwQ0ChUNCyEFVwNEBkoLAwIaBQMDB?=
 =?us-ascii?q?IE2BQ0eAhAtJwMDGU0CEBQDOwMDBgMLMQMwV0cMWQNsHxYEHAk8DwwfAhseD?=
 =?us-ascii?q?TIDCQMHBSwdQAMLGA1IESw1Bg4bRAFzB51Ngm2BDoIpTZJ7gxUBrnkHgjGBX?=
 =?us-ascii?q?qEJGjOXK5JPLpgOIKI+hUoCBAIEBQIOAQEGgWM8gVkzPoM2TwMZD44gg3iPe?=
 =?us-ascii?q?0EzAjkCBwEKAQEDCYI5iREBAQ?=
IronPort-PHdr: A9a23:D+O7khVWKy1Hc/+xim2MzOwCQojV8KyzVDF92vMcY89mbPH6rNzra
 VbE7LB2jFaTANuIo/kRkefSurDtVSsa7JKIoH0OI/kuHxNQh98fggogB8CIEwv8KvvrZDY9B
 8NMSBlu+HToeVMAA8v6albOpWfoqDAIEwj5NQ17K/6wHYjXjs+t0Pu19YGWaAJN11/fKbMnA
 g+xqFf9v9Ub07B/IKQ8wQebh3ZTYO1ZyCZJCQC4mBDg68GsuaJy6ykCntME2ot+XL/hfqM+H
 4wdKQ9jHnA+5MTtuhSGdgaJ6nYGe0k9khdDAFugjlnwXsLzmRL4tc5X4S6HZO6vfbQdZW2rz
 4VkaVjakD4gJ29+/1vXqcdphoIAo1G68k8aocbeNaW4FOhebr/zOt4HYVpzecdSURNFUtL/L
 I4vFccjP7cCkKrmiXUHhkekDALrAsrCyRVq3S7w96AejugxMjvCwi4DEvEPil+XicWtNaswC
 e2Hl/fajmTlSNIH2TLk+Yf3LVcZoNORQpRgSvrg9lIxBRuav3e/uNO4PjiQ6rkEj3jH9edMU
 s+CrkI+ij92oTaB994VkrKTp6AkwHr5sipCm58PLPemD0xHXZ3+H84D/zHfNpFxRNslWX0to
 ish17ka7IayZzNZoHxG7xvWavjCdpSBwTu5BKCfOz5lgnJidr+lwRq/ogCsyez5A9G9y00C7
 jFEnd/Fqm0X2lTN59KGRPpw8gbp2TuG2w3JrOARCU4unLfdK5kvz6R2kZwWsE/ZGTTxllmwh
 6iTHng=
IronPort-Data: A9a23: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
 BsbnYdWD7y+gRT/YZcUhu8=
IronPort-HdrOrdr: A9a23:d3B/gq1Ywk/rNvkf769bIgqjBEwkLtp133Aq2lEZdPU1SKylf6
 LHpp4mPHrP5Qr5N0tQ/exoVJPtfZq/z/BICOAqVN/IYOCMggqVxe9ZgrfK8nnJAC30/qpxyb
 xpeK1zJNn5DV0/sN3z6gu1CPYsqeP3lZyAtKP31HdnRUVNcKFv7wBwFwadHAlfXRBCBZAwCZ
 qb4aN81lidUEVSRt+6DXFAefPCqd3NnI/nZhBDPBIu7Q3mt0LK1ILH
X-Talos-CUID: =?us-ascii?q?9a23=3A9U4Cs2jI6AjdSO0qQVEEEAMuhjJufWPB43OII16?=
 =?us-ascii?q?ELDwydp62TEG3oJpHup87?=
X-Talos-MUID: 9a23:9qVo2wWPJzT4XGHq/DntvhFoCp1N37+BT0owlLgpkeS1CjMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="135077926"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA28.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:42:56 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 25 Oct 2023 11:42:56 +0200
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.169)
 by XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Wed, 25 Oct 2023 11:42:56 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXKx87xGk6CMIe7UNiRrfp74FFe2111/bF7U5Q74kf2r/tGdGUX/8Wc+FHsRvrznndVThXTb888DIrq86XtbMBmms43J9eGtOoaFPBYqSmoazak42aZJ5efaSiCvkb2ZbJ1zYFrgJx9xJt0cNpZwswCvofrr38xY2NgBxMEal7rJdOVzNLzrfysaCNrpGSR+kGTBNlyz9iasxP2JFYOZeAi3KWaE05Klb8rEZ0mmsYFJi2noVIYxEIzr3I/0MdySNCfKEqRV+AMqh+fV5yCi3eoTGryaDD+RTV6bPlyT2iRZ+pAbl1otkNRxptg4VUKkEIGFYmzBVibvtZpgfRtUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCQjkLBQou1K1XlAT1aHJgI/ZpqOx9/gRhKcqbH3k+s=;
 b=Vk3qfNohnK6HblcjNgRCdX8zL+VWTABIeNckYYpkj+fkl25RwliTGudIOYc8EyxN1JHK/RSHFG3q0S7VC2oHdVJ/CDqf4U0//1OAmkN8TrARj7owIUv99gdTBeN8G8LkfsyQr67h4EUIE7sreQ4xTFKHcr/4KRZFOUUcBis8DaGxV5qEdVw7iIcbLK42eCShsXxyYNMmFRumXDsDm1FN6Tg922U4kkRsQMNZjx7D+duqUOvBqfyGjiQxG8TXOBszN2+T5nFtyfS/9wq2xpMkJQv8kbtEFJUFQiNknXBYqBlvwv0HOIrqdlc5GVlpKmhwyTpZJjiRbxIu61zWzU5hhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCQjkLBQou1K1XlAT1aHJgI/ZpqOx9/gRhKcqbH3k+s=;
 b=LEHzHxtF/euLXZOiknWl89++mHrEJj92WKsFFaC4rac/nAEkBJ39nBeL5dxKRlvJKeKiRC+Mx0idJ0eZ36z+9NOI9hmqygW7/PiJuwNxSXYWsvzp7YJGy75icmT5aTx4reDoEEMDqIVokfFYqQpS2IJYbBU/gS3qRaBv/jTT+2g=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by BE0P281MB0116.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 09:42:55 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 09:42:55 +0000
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
Subject: [RESEND RFC PATCH v2 03/14] device_cgroup: Remove explicit devcgroup_inode hooks
Date: Wed, 25 Oct 2023 11:42:13 +0200
Message-Id: <20231025094224.72858-4-michael.weiss@aisec.fraunhofer.de>
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
X-MS-Office365-Filtering-Correlation-Id: eee12d09-c658-47ff-116e-08dbd53ec38d
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dm49FTuTQ8jNfzqt2mYOslgd6QfM3A2lGeXCUighYa+9L33GJ/1lupIJMCFi4KWFGFoX14fYrc1cErG5oEerTCbPXTijD8H4NPcFJo5dLUEyZRfKjjwCb84iwXGSEAwCzeD0XHKSksxVCSAXfM9YXXG4JbxgBYajBx8+MFSq484GQRfGyM6H/ZO8U7vQAD9BRm83uw8mS+UeXp/f7te/6Phjz/SD5RKLYtN/pYMNleNrAya9hnO46I+u1eMwtBWG1SGYlo3deAcUKpbi5ZsiFWzM0L6I5t1aOuOlI2kan2dLZe2IOahqDUaQHDULgBIXB3YsFg/CLIgbFubpTyoAzRIhVrEUvWpKl5HxJrBSfv4nRH5eCMhUNUHq6h7ZRy1J1h7k5LCvkslxNA0u8iC66tDgEMgFZ97vu6M6IP0uGjFNFGSVrfjVfOSQNFA+xweHgk4tP5OF6Kb+XKoeeJImKGcYRo6tobER/h9R+aq5p6wAYa7+XJ4cUdJDF5x6myOgO7qdaiXdzuk2WYiiW0qah4CpqvI7oplLb+CGDQsHdoqjzDlysItPqeCiGnY0jowVh0E7g8/LEMDRuu3rTbK4SIiHFqQQZK2L4PkunbI+FKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66946007)(83380400001)(316002)(38100700002)(6486002)(478600001)(6666004)(54906003)(110136005)(66556008)(66476007)(1076003)(107886003)(52116002)(6506007)(2616005)(6512007)(7416002)(2906002)(86362001)(4326008)(8936002)(82960400001)(8676002)(41300700001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGU5RUUxS25DbTBFWlAxMmEyeGJtUHhNdER3eEg5S3kzcDByTmRLMzJKSzBV?=
 =?utf-8?B?ZmdmaGRGNDhKZHhrVWNKZ1NPWWk3dUdQdzU3N3drdVAvS0ZVSk9Wd3E2eXFE?=
 =?utf-8?B?NEZXUTh1Rmsyc0NiNStGZ2E2QXdrL09zT3QrQ3dXY0VjWC8wQTAwTjRvQ3Ru?=
 =?utf-8?B?RTltcDZpcTZHRUxyMEhLRGkxUkVrYjM1Qm9YTGVWVG1iclZST2YvZGZWSWpD?=
 =?utf-8?B?cVppSzh3WmxjU3ZDSEdaaWk0MXVNbDN3Tm9qbXZHRGRKbmtHWjljOGY2bnhW?=
 =?utf-8?B?OXdjb1F0YVZhVGJ1eWZ5czVkZ3NvOTlXNVZvWGtBRlNKRlBvWFQ0Rm5sRzlE?=
 =?utf-8?B?M3NEdGhaRWlJS1A2VWdTWitEUmk3Y3NFa1NqRFJEWGpRODdJRGhGU3lFeDF1?=
 =?utf-8?B?NUtlUmpFRjB1dWdSWlBCVndJMDFxUStzbk1aWTg3QXJDVkUwWWdLbVgyQyto?=
 =?utf-8?B?NlRiclNzMEQ2MGhiYlBFT3VsbHdmM2tZOUVNRlRVS2t0RWs1S0cvY1ErUHJJ?=
 =?utf-8?B?UXU4U3g2bm4zYlZXTzdFSW9oWjE1a3FGMnlWWXE2cFRkcjZhamlhaVlvZ3Z4?=
 =?utf-8?B?amFjUmJrL2YrbnNPQ1kyOFhXdFNhWnF3T0x3NjJjYkdnZm13czE0Y2p2RHph?=
 =?utf-8?B?ZDBpNjZBYmVQY1M5ZnFjYjRFUU9uazVJc3AzclRqSlpsZ3RDNHB6ZDg0SVhL?=
 =?utf-8?B?dFNhbExqRUV3TTdUcmRhb2tycmloR3BveDlPNnplTTdNdVlqc0JibkhKNnJS?=
 =?utf-8?B?Q0FTMEtWdUNxR3ZPa1p6LzRjakZuYTltTWN4UnoyYkcwV1pQYk9mZmRFN1oy?=
 =?utf-8?B?RDNXb3BMNDJmSFpkdHRlaGF3TGRaVUhnekFCbzBVSVBDL1FHcFp3NnBuV1NJ?=
 =?utf-8?B?enE3T1ZiRVlsNVBIc2IrRlRiV2FiWCtJVi9aeWRCYmxoK0dpRFpZMmdYUWgy?=
 =?utf-8?B?M1VSbXJzektFTVlNRWF5VktTRVlXYStVVDFGbVJoM0pnbklXYStnQmZ3bldW?=
 =?utf-8?B?TmFVUGZJdHgwcUpoYyt5SGkzdkNFVzdUZXFVWDR3ak5lL0puNURUKzk1cnhx?=
 =?utf-8?B?c3hXQVQ0NmtUWEE0MmxabzN4SVJrUCtudE81eG5LYXJWUmRNMC92MGZEMEhX?=
 =?utf-8?B?bUZVUHNEZlYwdjdkRUlRWFQ0KzZJSVVXc1daWHVlVmppVnUxdENMVDRLOXRs?=
 =?utf-8?B?V1FsV2dlZlBZdlhwR0UzOEVTcVRBMzZ4TjlTZXRkRFBiSitLdTdGZHVSUXd2?=
 =?utf-8?B?dmhWd1RvSzF3OFF5WFdyTFc2MjE0TUpuWUx5akZ4eWx6KzJWM21INkM2T3dP?=
 =?utf-8?B?c1RGRFhiZ0N6MFV0WlF0MlBzVE5MOFFiQytzRzhMV2JUeFBxMXkvTjRETVlO?=
 =?utf-8?B?NVhLUjlVSFhmN2xDQnBKVXEwT1ozajdESXFBQXQzTWw1a0M3YTlqb1lHUjJs?=
 =?utf-8?B?MlFtWlMydXIrOUZ3MmtXTjM5Z1R0OEIvODVXb2c0R3oxdWZYT1g1L1hsWWRr?=
 =?utf-8?B?eXlsQllvbklHUVo2SmpTNEpyelhwMVRQazRDYXFDVHFYUGR5OXVLZTlmeVJC?=
 =?utf-8?B?Y0ZHMVkwVXdOYkE1M21laE9NclpXd3JZTnhFSlh5UHB2UkRFdFozb0paRXNX?=
 =?utf-8?B?bzVPN2NFZzlJNUNOMzYvM3pLVEVJaTMvdU5yYzgwN0hZdGxwUXVlNlB1MFo3?=
 =?utf-8?B?QnN5eFloVDRreUZZaEF1RnIzdHFTOEh6TEpmbkVMUUpXeGFWWnlNZEN6ckdR?=
 =?utf-8?B?d2pLODFuSlFkWVVuZGhmWWd0ZFVEV0ZSUWM0bHZvOGt0STYrY3pWbk45MWJn?=
 =?utf-8?B?L3IxcCtvZ21Yb0hqRzFobHRJWUZ2aVB1YkhKZitoWnZJdjJhYUZzQ2tXaHM0?=
 =?utf-8?B?bFp0TTdtUXV4R0ttUHBicmlVQVdLZ1p3dEYwSGFueDBpcDFuVWdqa2tjZDBV?=
 =?utf-8?B?akw0L2ROL3BHQjhyVkF0V2Q0QWlIQ0dOaCtnQkxlRjgzcjVGK3ZVR2cyT0Nq?=
 =?utf-8?B?cjJoNVJLTXpYeXp1K01NN2tpM3dmNExsYmNzVFdhNDdlUm1pSnh4S3g3TVoy?=
 =?utf-8?B?cmg0cURvb0RKdU96YVluQUhEY25DSXBDRTZNK01PeEkzQkZrSnZYbHVWTVUy?=
 =?utf-8?B?NHNuSnFwVU9lcXBLQkpPQ3c2YjZRY0U4SGtsMHc2K1FxZ0U1ZkQ0cTg5ckNG?=
 =?utf-8?B?YU9CZWJodHBPQ2lMK0ZNU1pUa0RWSHdCQ2NidTEveTNTZlZqWmFlTDBWelZZ?=
 =?utf-8?Q?PBpT4+NktEtmqgYSVoW0GcfzXbS4nRyzbMxyJn4fB0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eee12d09-c658-47ff-116e-08dbd53ec38d
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:42:55.1248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bz5/VyBR5xryOsAMINHSUV8RoCrXgbMTUczQOV7ZplwvciOnn7ZAHXNTwgrvZXc+OfFzEvppd76qFHZ09bKZXpW6zwlc2iyRe4IWje4kltmq1hR0FQmYmOX+SFSo64Sy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0116
X-OriginatorOrg: aisec.fraunhofer.de

All users (actually just fs/namei) of devcgroup_inode_mknod and
devcgroup_inode_permission are removed. Now drop the API completely.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 include/linux/device_cgroup.h | 47 -----------------------------------
 1 file changed, 47 deletions(-)

diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgroup.h
index d02f32b7514e..d9a62b0cff87 100644
--- a/include/linux/device_cgroup.h
+++ b/include/linux/device_cgroup.h
@@ -14,54 +14,7 @@
 #if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)
 int devcgroup_check_permission(short type, u32 major, u32 minor,
 			       short access);
-static inline int devcgroup_inode_permission(struct inode *inode, int mask)
-{
-	short type, access = 0;
-
-	if (likely(!inode->i_rdev))
-		return 0;
-
-	if (S_ISBLK(inode->i_mode))
-		type = DEVCG_DEV_BLOCK;
-	else if (S_ISCHR(inode->i_mode))
-		type = DEVCG_DEV_CHAR;
-	else
-		return 0;
-
-	if (mask & MAY_WRITE)
-		access |= DEVCG_ACC_WRITE;
-	if (mask & MAY_READ)
-		access |= DEVCG_ACC_READ;
-
-	return devcgroup_check_permission(type, imajor(inode), iminor(inode),
-					  access);
-}
-
-static inline int devcgroup_inode_mknod(int mode, dev_t dev)
-{
-	short type;
-
-	if (!S_ISBLK(mode) && !S_ISCHR(mode))
-		return 0;
-
-	if (S_ISCHR(mode) && dev == WHITEOUT_DEV)
-		return 0;
-
-	if (S_ISBLK(mode))
-		type = DEVCG_DEV_BLOCK;
-	else
-		type = DEVCG_DEV_CHAR;
-
-	return devcgroup_check_permission(type, MAJOR(dev), MINOR(dev),
-					  DEVCG_ACC_MKNOD);
-}
-
 #else
 static inline int devcgroup_check_permission(short type, u32 major, u32 minor,
 			       short access)
-{ return 0; }
-static inline int devcgroup_inode_permission(struct inode *inode, int mask)
-{ return 0; }
-static inline int devcgroup_inode_mknod(int mode, dev_t dev)
-{ return 0; }
 #endif
-- 
2.30.2


