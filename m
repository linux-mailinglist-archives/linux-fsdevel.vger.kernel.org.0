Return-Path: <linux-fsdevel+bounces-5902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB9F8114D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC52E1C2113D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DFA2EB08;
	Wed, 13 Dec 2023 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="G9Sdzzu4";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="jL5W9xhM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeka24.fraunhofer.de (mail-edgeka24.fraunhofer.de [IPv6:2a03:db80:4420:b000::25:24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACA9B9;
	Wed, 13 Dec 2023 06:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1702478323; x=1734014323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=acMlZA/xra8ZJA8XT9qz/nbXxTd/JYij/1sJaqATZAA=;
  b=G9Sdzzu4EfCnEW7zuRdvtzW2pPeq9Z9cEpnn6upELKBMSXGGSmfMxprh
   KbI4x0cLVzCPgps6BdWo6ZGdThxVIj3g4Q+uxtDxDUdHSNymR+3MHDEFa
   dRmztiNVC1iVtzpRtVZJ/v0JGEQwY9GdsdbmlFbjV/CCCk78M9+FCOI0q
   t+eYiFilVFqwwnNICWPPMfQZZRuj9onQud3jXAH7EJtt2YKLCp7u0x/Hv
   DfpEU/phHqjEfcXh8c3UueGkHIhurTZcsSTuAgMFI1xYB2X8yoY6w4yCs
   Tat6UR5/eCvALH+4m3BQ/7OyOusmZVEzFHIC+eVZNQLrjvJ4UeBGVdtDB
   A==;
X-CSE-ConnectionGUID: zkE+Kv4mTRSszHMTxPxlSQ==
X-CSE-MsgGUID: COe0W31dSFeUtVOMLpUOYw==
Authentication-Results: mail-edgeka24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2H9AADxwHll/xoBYJlaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YI4glmEU5FjmCeEBCqCUQNWDwEBAQEBAQEBAQcBAUQEAQEDBIR/AocwJzcGD?=
 =?us-ascii?q?gECAQMBAQEBAwIDAQEBAQEBAQEGAQEGAQEBAQEBBgYCgRmFLzkNg3mBHgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAR0CNVQCAQMjBAsBDQEBNwEPJQImAgIyJQYBDQWDAIIrAzGvE?=
 =?us-ascii?q?H8zgQGCCQEBBrAjGIEhgR8JCQGBEC4Bg2GENAGERYEhhDqCT4FKgQaCLYRYg?=
 =?us-ascii?q?0aCaINmhTYHMoIhg1GDdo1AfUZaFhsDBwNWKQ8rBwQwIgYJFC0jBlAEFxEhC?=
 =?us-ascii?q?RMSQIFfgVIKfj8PDhGCPiICBzY2GUiCWhUMNARGdRAqBBQXgRJuGxIeNxESF?=
 =?us-ascii?q?w0DCHQdAjI8AwUDBDMKEg0LIQVWA0IGSQsDAhoFAwMEgTMFDR4CECwnAwMSS?=
 =?us-ascii?q?QIQFAM7AwMGAwoxAzBVRAxQA2kfGhgJPA8MGwIbHg0nIwIsQgMRBRACFgMkF?=
 =?us-ascii?q?gQ2EQkLKAMvBjgCEwwGBgleJhYJBCcDCAQDVAMjexEDBAwDIAMJAwcFLB1AA?=
 =?us-ascii?q?wsYDUgRLDUGDhtEAXMHpSwBPC0lgW4OQ5ZLAa8HB4IzgV+hDxozlzGSVi6HS?=
 =?us-ascii?q?ZBMIKgQAgQCBAUCDgiBeYIAMz6DNlIZD44gg3iPenUCOQIHAQoBAQMJgjmIK?=
 =?us-ascii?q?QEB?=
IronPort-PHdr: A9a23:U8UzmhasElYXmbcPnD0jMzX/LTF/0YqcDmcuAucPlecXIeyqqo75N
 QnE5fw30QGaFY6O8f9Agvrbv+f6VGgJ8ZuN4xVgOJAZWQUMlMMWmAItGoiCD0j6J+TtdCs0A
 IJJU1o2t2ruKkVRFc3iYEeI53Oo5CMUGhLxOBAwIeLwG4XIiN+w2fz38JrWMGAqzDroT6l1K
 UeapBnc5PILi4lvIbpj7xbSuXJHdqF36TFDIlSPkhDgo/uh5JMx1gV1lrcf+tRbUKL8LZR9a
 IcdISQtM2kz68CujhTFQQaVz1c3UmgdkUktYUDP7ET5UMjJnQTKsslwwjTBGNP3bIo1Gjap8
 YAoZjjPrnsXHGUpzWzGtpRJz6VQ9UHExVR1lozwPb7EJPpbQo+aee8iHU58Q9hPdgdMUr6OQ
 7EBVc9QYclqiYTj9lQRnwCHFBixJqTM5gARqn7ax6Y10LUEFTP23iElDo4EoXCJttnwMLxPD
 8KJkPCRk27YZMFt/Gji1pDNajV6/tKVVJtecsjPyXk9HArevHqvuNXcMmisxtYm4jCQ6uFye
 OyrjkQkhlFN/wK945092qjV36gI6m2Zqz182YweYvC/b09/UIv3WIsVtjudMZNxWN9nWWxzp
 SImn6UPooXoFMBr4JEuxhqaZvCIfouBuE6lWvyYPDF4g3xoYvSzikX6/Uuhz7jkX9KvmBZRr
 yVDm8XRrH1FyRHJ68aGR/c8tkes0DqCzUbSv8lKO0kpk6rcJZM7hLk2k5sYq0PYGSHq3k7xi
 cer
X-Talos-CUID: =?us-ascii?q?9a23=3ALEdxxWmZNdXIqWul/bP8sNHLYiHXOW/e4TTzPRO?=
 =?us-ascii?q?9NVxSU6+1bGOAwLNgqPM7zg=3D=3D?=
X-Talos-MUID: 9a23:9lS+bgYaSmtFIOBTnBjh3A45bctTzamTFH4qtLEehu61Knkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,272,1695679200"; 
   d="scan'208";a="5192938"
Received: from mail-mtaka26.fraunhofer.de ([153.96.1.26])
  by mail-edgeka24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:38:36 +0100
X-CSE-ConnectionGUID: nu86nVvrRsW8njaENf/vQA==
X-CSE-MsgGUID: Yd3cNMxSSqWeNwCHxcrtFQ==
IronPort-SDR: 6579c1ea_eudvFEcDhuXpb3t7EugF8CGzSwoPqVRQGhy00knICAMJ4XA
 0skKpq9RkSDWMm6jiOa7Ljt/OCNUaJJL/9mjsJA==
X-IPAS-Result: =?us-ascii?q?A0C+AQBtwHll/3+zYZlaHQEBAQEJARIBBQUBQAkcgRkFA?=
 =?us-ascii?q?QsBgWZSBz6BD4EFhFKDTQEBhS2GRoIhOwGXa4QuglEDVg8BAwEBAQEBBwEBR?=
 =?us-ascii?q?AQBAYUGAoctAic3Bg4BAgEBAgEBAQEDAgMBAQEBAQEBAQYBAQUBAQECAQEGB?=
 =?us-ascii?q?IEKE4VoDYZGAgEDEhEECwENAQEUIwEPJQImAgIyBx4GAQ0FIoJegisDMQIBA?=
 =?us-ascii?q?aIhAYFAAosifzOBAYIJAQEGBASwGxiBIYEfCQkBgRAuAYNhhDQBhEWBIYQ6g?=
 =?us-ascii?q?k+BSoEGgi2IHoJog2aFNgcygiGDUYN2jUB9RloWGwMHA1YpDysHBDAiBgkUL?=
 =?us-ascii?q?SMGUAQXESEJExJAgV+BUgp+Pw8OEYI+IgIHNjYZSIJaFQw0BEZ1ECoEFBeBE?=
 =?us-ascii?q?m4bEh43ERIXDQMIdB0CMjwDBQMEMwoSDQshBVYDQgZJCwMCGgUDAwSBMwUNH?=
 =?us-ascii?q?gIQLCcDAxJJAhAUAzsDAwYDCjEDMFVEDFADaR8WBBgJPA8MGwIbHg0nIwIsQ?=
 =?us-ascii?q?gMRBRACFgMkFgQ2EQkLKAMvBjgCEwwGBgleJhYJBCcDCAQDVAMjexEDBAwDI?=
 =?us-ascii?q?AMJAwcFLB1AAwsYDUgRLDUGDhtEAXMHpSwBPC0lgW4OQ5ZLAa8HB4IzgV+hD?=
 =?us-ascii?q?xozlzGSVi6HSZBMIKgQAgQCBAUCDgEBBoF5JoFZMz6DNk8DGQ+OIIN4j3pCM?=
 =?us-ascii?q?wI5AgcBCgEBAwmCOYgoAQE?=
IronPort-PHdr: A9a23:ta0mWRLkqzD0QnKbrtmcuChnWUAX0o4cQyYLv8N0w7sbaL+quo/iN
 RaCu6YlhwrTUIHS+/9IzPDbt6nwVGBThPTJvCUMapVRUR8Ch8gM2QsmBc+OE0rgK/D2KSc9G
 ZcKTwp+8nW2OlRSApy7aUfbv3uy6jAfAFD4Mw90Lf7yAYnck4G80OXhnv+bY1Bmnj24M597M
 BjklhjbtMQdndlHJ70qwxTE51pkKc9Rw39lI07Wowfk65WV3btOthpdoekg8MgSYeDfROEVX
 bdYBTIpPiUO6cvnuAPqYSCP63AfAQB02hBIVgvLsynVcaf1kSbgq7FYxii7B8y1T7sqfneMy
 IBNFA/D0zc6Oi8FqFiUjccl38c56Bj0pTgi/N/EYKSpGL16QpuFWe4HW3RgdcsBah5tOI3mS
 tpTINgnMPgJoJbPvGIfvAacQiqAO7rDyxNSjXD1jIg+4dQjPATXgAYxG48UvHHQt4irFptOC
 Lnrl7LD/w7mMOxowTLlzdOXUQkoiN+PX6xwQdjawFIdODzU12yd8rX1DRjEju8IuHq24e5lf
 +GC21J6kRNU+Cn/59t1oJTpu99L0lXd/w4+7YESJNmJHR0zcZulCpxWryaAK85sT9g/R309o
 C8h0e5uUf+TeSELzNEi2xf8QqbZNYaS6w/lVOGfLC0+iH82ML68hhPn6UG70aW8Tci71l9Ws
 zBI2sfBrHED1hHfq4CHR/Jx813n2GOn2Rra9+dEJk45j+zcLZsgyaQ3jZ0drQLIGSqepQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:X6CeIazgGy1XtwcVQKC8KrPw0r1zdoMgy1knxilNoH1uEvBx9a
 iV9sjzsCWYtN9/YgBFpTntAsW9qBHnm6KdiLN5VdyftWLd2VdAQrsM0aLShxX6Gyb3ssNAzq
 9qdqRTDNXxCBxGls7x4gWiM9tI+qjjzImYwc/Ez3xkCSdwa69h6A9lCgGUVmVuXQxHD5IlFJ
 yaj/A3xQaISDA+dcSxDj0iROjMp9rCiZLgb1o8CxYj7GC1/FCV1II=
X-Talos-CUID: 9a23:4t7H7GEsFwDpWWmvqmJh6R5KHP47aEfG8yfWIUaVL2guVoS8HAo=
X-Talos-MUID: 9a23:8qRiwAkyqFBA1VywkuyQdnpTOJxjxYG+M3sUrpggpOKkJSdqJxmk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,272,1695679200"; 
   d="scan'208";a="73956622"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA26.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:38:34 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 13 Dec 2023 15:38:34 +0100
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (104.47.7.168) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28 via Frontend Transport; Wed, 13 Dec 2023 15:38:34 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZ4Q5MxNpoFUcXF5ShoaH8+slCvLV24Y9yRVEJZUwr9POjVxevmXMhZf4iS8+HekAclcJ7f+ZtUJd/RpFVQKzG+9A7rXo+NfcTYia1W67Fi8lEUnbyDjs+lsu+aARyCIxS3eiWqqZaA385RMEbFB/sQXTKmh+dGouwKwI29DsEosQvO+YKcwrYYYGbuSc1ey68ZRWOmhb/4z4QGgMB0rUYSpI98fRBQLdAW5uHEADmRjt3RXj8068vqrR3yOmiqkQGEH9IZVeT6xO8BeRi09EVD4c92embOhfXJECkR/tsIfUrDtmQM9u4nTS8RC2oQ3Cx0ET7ivSbkyzUpu2LDaKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kf7PGGXlKeru3MviIRi+jcvO+FOON4xC3xUeyT0Q+oc=;
 b=jdr9fC/vAVDGdzr9ClA2XAENReOxdSlb7L4wnhyNzChFdgwBxh6cGg9nj3lR6c5Gpx90Lx0FAB7xXd3/GSddkyidWVFW11g84V3X7oNT3HcyFebKr/fifUhYhgNT6DBq6YouSPA+KKsArPuLNrVlG0pHbbRxPTttbRl0FROgrlBOFr6jSE05ujHJNjdKoYI0uGpTxSGVU8HcqfMMmdWVE00z9ylj/cHVykp4pzxhfKQlix+r+eqLqFF7qAwfy/h55zy1iOoqwpvcaCuXEchSdMqoXNlADVwUjUglmmz4ujIUojEu0j4PNperLe6J2ZBWSvumA40spzK+mZ+YROFiBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kf7PGGXlKeru3MviIRi+jcvO+FOON4xC3xUeyT0Q+oc=;
 b=jL5W9xhMTD/lTP0LUuvvICe8UZDRf2M94GZNev9gwZsQyyuJ/KDW1DiDrcgk9MlZXjEmy4byl5rdmls56JT41163scZSM7wVpmpM37KqaAFkjvhXzcasZGWy1Qe3QxZC90cmczEflmBkE8T5RzM2y8It1BuHU56pmqbC/EoOilY=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by FR2P281MB0026.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 14:38:33 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d273:9b9b:dadf:e573]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d273:9b9b:dadf:e573%3]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 14:38:33 +0000
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
	<michael.weiss@aisec.fraunhofer.de>, Alexander Mikhalitsyn
	<aleksandr.mikhalitsyn@canonical.com>
Subject: [RFC PATCH v3 1/3] bpf: cgroup: Introduce helper cgroup_bpf_current_enabled()
Date: Wed, 13 Dec 2023 15:38:11 +0100
Message-Id: <20231213143813.6818-2-michael.weiss@aisec.fraunhofer.de>
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
X-MS-Office365-Filtering-Correlation-Id: 33f0d468-c909-4cb8-66a4-08dbfbe92e76
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sLHo0dGNV+zBI2zXpn5OSkyh+NkoUGF/Gn6/vJnjCqJrx6VM2iL0HufNTcWd7cU6XGLatJYyv9bweU58VMGHVD2xEZGChavC6ekGJoVCDX62VnaTBWFPNBGehlQp3yAvftPODDvrwKb8jMeablKSS8e4j6tVQs3fStkVNVmNjgew37LcFME50TcLK5Z6xBLhchAWUC/HUXPk/ftzQjUSve7HshB8G+mXFni0uabU4Scn5v5iwudlF8xrcWn+27jRQhxcJvyf5y7wLLuzJgzxFZj673ZYcoVPFAgEgd7hIj/LYtNE1P+Qc3HXkSV9t2MSVUFDjsYz+v9F1Cat4bs5DvoVt/MWP0VK/3qSqWjiQgEI83TN/nCe/Ip809PM0Ho+S5zlgxSG8Jm2UJXDiKKxDtE4xDNimUyc04jqacsgV4in+F6Ti3r4KnT+UAw12alLt4B6oRtE5PA1y5H93gMBJ0yoKoehuj3NiAIV3fJZicaM5QV1Z1sRtuH38CXYIzWrK/LWHlt6wJvx856j5Mc5Jf6qfKqOVjNImwqJGrmwUq8ZnOz86oRnHe0jGHSNJDDJeqPFvRZ377N0aTY/SY+SKO9Pf6una+Zxnj788ZMghLc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(38100700002)(8936002)(316002)(54906003)(8676002)(2906002)(7416002)(4326008)(5660300002)(66476007)(478600001)(52116002)(41300700001)(66946007)(6512007)(6666004)(6506007)(110136005)(6486002)(66556008)(2616005)(1076003)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enI3VmI2eXVteUQrMnV3Y3NRS1lSZFhNa0JQYW1DVE5nWGZ0RlJ6MFBnRHh1?=
 =?utf-8?B?V205L2dUcjUyTmpndUdRdURldytYakFqa09VZE90RUZ3dkxSRWd3RzVaSUda?=
 =?utf-8?B?Wkt2VUhtclZvUG5SVi9WRFNGMFFjR3M2MDVpc2R1ODVoUGk4VW1xVzhXVGNK?=
 =?utf-8?B?N2RUU1lqS3ArRXkxKzlkYlc3QnFScEZ6YmtmM05FOU5uYk9mN1RUQ1R5NGJG?=
 =?utf-8?B?Y3RjdG9POUdOQVFrS1Y0MFhSVk94dUhJbkZEVm5VTXhJWjMvQ3FCTGRoVisv?=
 =?utf-8?B?S0d6ZS9mOFkvc3NxRHZBYzZhNnk3c0QyQnFXdnpWb2pnbjlBeDBsLzZscWlR?=
 =?utf-8?B?L29odm9ENmpWNUJVTEpJQkU2RTdqWkZ2eWs3MWdWZ3Y0VnQvNWhVOEg2RVFH?=
 =?utf-8?B?eDFVRkhORDdxS3hQQWFHWGRxMVR4MUtuU3c2VjBkdEtqTFAyRXBlMERaMUhT?=
 =?utf-8?B?N3hIOFhJUVErQlhGU29CMmUvNE1yYkpzbld1OGJ5a2lkZWhrZkM2WjBBa2d5?=
 =?utf-8?B?RUZmWjNUWGhoV1gydXFDRWhGK1J4QWZYQVlXZzdxd2UwaTFzdUdYNmZvRDVN?=
 =?utf-8?B?dlNNTHpCRHF6ZjJMR0Z3TXc4N1c5MEhwNUx0bXBnUUkzZlpmTjFRZnpUZkdt?=
 =?utf-8?B?VEZYTDRRVDlQblU0NEdWVHpNYlFOZStoUEdtekpqNWU2QUgvY0MwQUtabjRj?=
 =?utf-8?B?OVRPSTRYZHhRYnRsT1laTVpKUW1iOVZEMVhOSllTOHNnWVVSd3Z0cXNSWmNG?=
 =?utf-8?B?WUdxUG0xV2p4L1dzWlRXRnhsMExsZWo3WXJNTUJlK0ZlRXZmckRsRTVmSEZh?=
 =?utf-8?B?OUp2RjBSM0Nsc3QwTnNyb0ZUbi9kMnJ0cm1CWUNMV3hGbFQvbC9DaThxQVBL?=
 =?utf-8?B?MktBRWFRaGpVaXR6MDhPMGVTay9WbTJxbmxuTVp1N1BrdGJ6UnoxK3JvRlBJ?=
 =?utf-8?B?QTg5dW5WTEZjQzNPZm16YzZKamZXSnU3ZXhnbWlPU2hPdWRleTRpYXdFeHMw?=
 =?utf-8?B?NGdzaE1CUUVGSjVEUC81ZHpyMmhnT1U1RmxFb29VTUUwZ3FUcy8rMWtjbnE0?=
 =?utf-8?B?R0dEZ2prVlFmRFRBQ3g1dUx4Qkg2c3pndUErbE9uVlF3R0pCOG1CNkRHQTNv?=
 =?utf-8?B?VklkMkFwVzJaTGdOaXJwTDVxeFhRWUpPelozQldweThna0t2UzhjUEhYS3FU?=
 =?utf-8?B?S1VFTHNlZ3ZCSDVQZFRIM3AvKzFBQSt0MzVoRlRTYkVVZ3JGcExYZGJrNElH?=
 =?utf-8?B?TGxFYjlScHAwbE9pZE9OOUVGTGxnVGhleW1KbTMyOGFvVXhDYzZEMlNSR1U4?=
 =?utf-8?B?R2hWSHEyMU9BMjZNMWo5TlUxT3UzL05obzZ6TlF3eG9tczE0MHlhajdmdTFV?=
 =?utf-8?B?SkR6emVydm9CZ1FXQW52TE9MVlZncWgySDdOcDRvOVB0VEFEZGhkWG91THJk?=
 =?utf-8?B?OGF0bFl0ZGVuTXRLamRwczdtZ2plbGFzaU9mVlEwZW00ZHlTWEkzTjBRd1dZ?=
 =?utf-8?B?dkxlM0drVHhtQUdTRllKZHBSY014MXhyOWJPaHBNamF0NHhCQ2lvZVRIek5i?=
 =?utf-8?B?YUU2RTNSQ3VqdUljSFVQYW9GU3NLWkZQYktBcndXUXZ0Vno2cE9CQmVqUXlu?=
 =?utf-8?B?SUk5VmdISzMzWll1MFpLTVpZbTRJeCthNU0wVFJMNEZJczJncVlRajR2M2Zr?=
 =?utf-8?B?WjJ2WUpxNFk3bG1rMUpqRHJIUVBBdWtvT2Y0U01pZVp0Zy9mcXBXZGMxSkhI?=
 =?utf-8?B?SE1hcG9NZ25ncDFXY0Evd2s2cWRBMXJJZnNlamZuV2dOOTZWZmxsWC9PRWhQ?=
 =?utf-8?B?MlJ4UmZaVEczNkRkN09SNzExek5EUEk2NTBrdUVwSVZnTGVPMnhId0ttRGo0?=
 =?utf-8?B?QTVGWXlDRHdQRHFTRXZuZmpSWWhNMjNQM3lYelM2VGhMUzAxLytvS0pKdnVs?=
 =?utf-8?B?YzZjaHRVV2lVajMzUDliemRjVWx1WUw2cGsrVWFSNWIwY1VGak1LWk5xUUsw?=
 =?utf-8?B?aEN4YjMrVWpMVjBqbGE4N0t4bERNQWtLYk51a0tUSXhzWmE0VDNNTTMvMytH?=
 =?utf-8?B?RnFjenJ5eVB4cVZSZytwdkVPb2dsbm8zZXFFVDAvcVFRMTVZeCtxL1JoVHEx?=
 =?utf-8?B?M1FEdE9QcHh6c3JyMThZQWx3VzJmbE5yRktCWlp4KzZBSGxTWDBIT3JDU3hW?=
 =?utf-8?B?LzIvRHNrNm5YUVFxWE1RYy9xUXVDNk1icXlRQjBNb3B1dENTVnFScC93ZnhV?=
 =?utf-8?Q?36iGsysL4SFkGJNrN1Da6xWQoZkHwRAvChwkyjzeCw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f0d468-c909-4cb8-66a4-08dbfbe92e76
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 14:38:33.0294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4uyDlg8Awo9ucSO4WSjBVaJXsKXtQzTgVATA6NiocLaiMyF5AINa11XfBZTTZoK/reAyhSwagNQuVJ6qe6RhHDVz07XYcI3KmXwShPQZMUZHZAggZ9UuX0H5hR15PSz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0026
X-OriginatorOrg: aisec.fraunhofer.de

This helper can be used to check if a cgroup-bpf specific program is
active for the current task.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 include/linux/bpf-cgroup.h |  2 ++
 kernel/bpf/cgroup.c        | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index a789266feac3..7cb49bde09ff 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -191,6 +191,8 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	return array != &bpf_empty_prog_array.hdr;
 }
 
+bool cgroup_bpf_current_enabled(enum cgroup_bpf_attach_type type);
+
 /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
 ({									      \
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 491d20038cbe..9007165abe8c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -24,6 +24,20 @@
 DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, MAX_CGROUP_BPF_ATTACH_TYPE);
 EXPORT_SYMBOL(cgroup_bpf_enabled_key);
 
+bool cgroup_bpf_current_enabled(enum cgroup_bpf_attach_type type)
+{
+	struct cgroup *cgrp;
+	struct bpf_prog_array *array;
+
+	rcu_read_lock();
+	cgrp = task_dfl_cgroup(current);
+	rcu_read_unlock();
+
+	array = rcu_access_pointer(cgrp->bpf.effective[type]);
+	return array != &bpf_empty_prog_array.hdr;
+}
+EXPORT_SYMBOL(cgroup_bpf_current_enabled);
+
 /* __always_inline is necessary to prevent indirect call through run_prog
  * function pointer.
  */
-- 
2.30.2


