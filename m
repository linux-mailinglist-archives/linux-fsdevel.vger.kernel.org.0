Return-Path: <linux-fsdevel+bounces-1152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091997D6758
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 11:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D589B217B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 09:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88BE273F0;
	Wed, 25 Oct 2023 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="ETN9AftI";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="dNUXAbV1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABFC273DF;
	Wed, 25 Oct 2023 09:44:23 +0000 (UTC)
Received: from mail-edgeF24.fraunhofer.de (mail-edgef24.fraunhofer.de [IPv6:2a03:db80:3004:d210::25:24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A4818C;
	Wed, 25 Oct 2023 02:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1698227060; x=1729763060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=gFNlG21hG/sxMF1KBM1RHVr2MMnDPrrmCyHPmjqTDOU=;
  b=ETN9AftI2VH5xZ+m0AI1/Qn1qe449Jt8fX1CnOfLnArXAeDMlbzAD5J3
   UU9ROMInm6hzQvJiN3PKC4RfmWVvIUTUFwn4PSB0xE9YtnMKJaLNnYk/N
   w/NIVVhDWh70dtHAgY8ipn3mJXWv6OyMw84H0gr0aKikyf8TX4ZrRgADR
   9fRzr/5xZlJ2Uy2MRcoPe9vB9I/q/p/DnplFSGGyaAkX6dVfNcRXo4jWf
   xGtQLmd5Vi0DSuUTl4mPOnJcdA0aiBqA2TT3v/qXOq1BE5l1yhDHO4flY
   r4yOr3zTLsS0Y9YF7XLCbiegVAB9CVUPflPbBLWltTxaI4laOQfK8YJ55
   Q==;
X-CSE-ConnectionGUID: FNRhH9OYR72QJYuNmKwI2g==
X-CSE-MsgGUID: Em72RxrxRKisqQg4dlw01g==
Authentication-Results: mail-edgeF24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2ElAABB4jhl/xwBYJlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIQKIJXhFOIHYlBmCaEBCqBLIElA1YPAQEBAQEBAQEBBwEBRAQBA?=
 =?us-ascii?q?QMEhH8ChxonNAkOAQIBAwEBAQEDAgMBAQEBAQEBAgEBBgEBAQEBAQYGAoEZh?=
 =?us-ascii?q?S85DYQAgR4BAQEBAQEBAQEBAQEdAjVUAgEDIwQLAQ0BATcBDyUCJgICMiUGA?=
 =?us-ascii?q?Q0FgiZYgisDMbIYfzOBAYIJAQEGsB8YgSCBHgkJAYEQLgGDW4QuAYQ0gR2EN?=
 =?us-ascii?q?YJPgUqBBoE3doRYg0aCaIN1hTwHMoIigy8pi36BAUdaFhsDBwNZKhArBwQtI?=
 =?us-ascii?q?gYJFi0lBlEEFxYkCRMSPgSBZ4FRCoEDPw8OEYJCIgIHNjYZS4JbCRUMNQRJd?=
 =?us-ascii?q?hAqBBQXgRFuBRoVHjcREgUSDQMIdh0CESM8AwUDBDQKFQ0LIQVXA0QGSgsDA?=
 =?us-ascii?q?hoFAwMEgTYFDR4CEC0nAwMZTQIQFAM7AwMGAwsxAzBXRwxZA2wfGhwJPA8MH?=
 =?us-ascii?q?wIbHg0yAwkDBwUsHUADCxgNSBEsNQYOG0QBcwedTYJtATZECQuCBVIclhIBr?=
 =?us-ascii?q?nkHgjGBXqEJGgQvlyuSTy6HRpBIIKI+QoUIAgQCBAUCDgiBY4IWMz5PgmdSG?=
 =?us-ascii?q?Q+OIAwWg1aPe3QCOQIHAQoBAQMJgjmJEgEB?=
IronPort-PHdr: A9a23:eEZLuhJkiVNlqM5m39mcuChnWUAX0o4cQyYLv8N0w7sbaL+quo/iN
 RaCu6YlhwrTUIHS+/9IzPDbt6nwVGBThPTJvCUMapVRUR8Ch8gM2QsmBc+OE0rgK/D2KSc9G
 ZcKTwp+8nW2OlRSApy7aUfbv3uy6jAfAFD4Mw90Lf7yAYnck4G80OXhnv+bY1Bmnj24M597M
 BjklhjbtMQdndlHJ70qwxTE51pkKc9Rw39lI07Wowfk65WV3btOthpdoekg8MgSYeDfROEVX
 bdYBTIpPiUO6cvnuAPqYSCP63AfAQB02hBIVgPkyy3fecngmXTFuudWxHGTHtTJZJwGUA+Qx
 IowRj3V0AM7OhozqFDp0pwl38c56Bj0qzpC86feXtilBOR6V/33Jv8HHjsefvhcCnRGRYm/f
 5IjIeMFHLwDlamglUdU8jaROQutI/js1DR6gVnEmqo076N+Eg7sxTQlEYohl3n3po6yG7wvD
 v6N/rDYwxngQON//Rnns9fVdk96rsydf49tLePA6GAWLyXVhViAl4XcExOW9+crqlKD3/V4C
 Pv1lFY7lTohnB6k2uIAio6Zrb0Ww1Lc9GIi+942YuS7HR0zcZulCpxWryaAK85sT9g/R309o
 C8h0e5uUf+TeSELzNEqyxHSRabbNYaS6w/lVOGfLC0+iH82ML68hhPn6UG70aW8Tci71l9Ws
 zBI2sfBrHED1hHfq4CHR/Jx813n2GOn2Rra9+dEJk45j+zcLZsgyaQ3jZ0drQLIGSqepQ==
X-Talos-CUID: 9a23:1E5CkmB2LER7pKT6EwdBzk40S+cUSCKH9VXhPmm9KnlIErLAHA==
X-Talos-MUID: 9a23:oRpsBwbCKfluSuBTmjqz3gtyLtdSwKW1EXkCzZkCpJHdOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="62757490"
Received: from mail-mtaka28.fraunhofer.de ([153.96.1.28])
  by mail-edgeF24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:10 +0200
IronPort-SDR: 6538e32d_qqFUkNDfE+GaAo77s5JplLIbgmHxK1JyQ2+Knb8aIqCaohb
 4QUEFxf5fUoJMNQFxPw7VF3SLuqrO3ByhgM+XGA==
X-IPAS-Result: =?us-ascii?q?A0A8AAC94Thl/3+zYZlaHAEBAQEBAQcBARIBAQQEAQFAC?=
 =?us-ascii?q?RyBFgcBAQsBgWYqKAeBS4EFhFKDTQEBhE5fhkGCITsBl2qELoEsgSUDVg8BA?=
 =?us-ascii?q?wEBAQEBBwEBRAQBAYUGAocXAic0CQ4BAgEBAgEBAQEDAgMBAQEBAQEDAQEFA?=
 =?us-ascii?q?QEBAgEBBgSBChOFaA2GTQIBAxIRBAsBDQEBFCMBDyUCJgICMgceBgENBSKCB?=
 =?us-ascii?q?FiCKwMxAgEBpTABgUACiyJ/M4EBggkBAQYEBLAXGIEggR4JCQGBEC4Bg1uEL?=
 =?us-ascii?q?gGENIEdhDWCT4FKgQaBN3aIHoJog3WFPAcygiKDLymLfoEBR1oWGwMHA1kqE?=
 =?us-ascii?q?CsHBC0iBgkWLSUGUQQXFiQJExI+BIFngVEKgQM/Dw4RgkIiAgc2NhlLglsJF?=
 =?us-ascii?q?Qw1BEl2ECoEFBeBEW4FGhUeNxESBRINAwh2HQIRIzwDBQMENAoVDQshBVcDR?=
 =?us-ascii?q?AZKCwMCGgUDAwSBNgUNHgIQLScDAxlNAhAUAzsDAwYDCzEDMFdHDFkDbB8WB?=
 =?us-ascii?q?BwJPA8MHwIbHg0yAwkDBwUsHUADCxgNSBEsNQYOG0QBcwedTYJtATZECQuCB?=
 =?us-ascii?q?VIclhIBrnkHgjGBXqEJGgQvlyuSTy6HRpBIIKI+QoUIAgQCBAUCDgEBBoFjP?=
 =?us-ascii?q?IFZMz5PgmdPAxkPjiAMFoNWj3tBMwI5AgcBCgEBAwmCOYkRAQE?=
IronPort-PHdr: A9a23:6zXrWBT+0EVSYsnXMXNFXV55E9psovKeAWYlg6HP9ppQJ/3wt523J
 lfWoO5thQWUA9aT4Kdehu7fo63sHnYN5Z+RvXxRFf4EW0oLk8wLmQwnDsOfT0r9Kf/hdSshG
 8peElRi+iLzKh1OFcLzbEHVuCf34yQbBxP/MgR4PKHyHIvThN6wzOe859jYZAAb4Vj1YeZcN
 hKz/ynYqsREupZoKKs61knsr2BTcutbgEJEd3mUmQrx4Nv1wI97/nZ1mtcMsvBNS777eKJqf
 fl9N3ELI2s17cvkuFz4QA2D62E1fk4WnxFLUG2npBv6C5zQlRffkbRs83alMcDdUeg9ei2dx
 otZQSTaowpcORwEqEXrh+h61JNl+EL09Hkdi4SBbKeoBNN0QPrtTc0ebDRrBepMDH0eIr2xM
 tMISOACLf90gYD5hgFVlzvjNxX2W87A9j1JoWT1w6YI1MITVgbI4Et/HN0kqUzRoo3aE6oxW
 7vy47L1kiv7XepG1xvex5jhVj47+q6RWe0rfvfA63QySyrUr3ypkar1ND6F6O00n0iYzulGT
 Ni3u3E/9hgrvQCz+Px8tK/Cmqc5yleU3hp6yYQtJJrjcxZ4JuenRcgYp2SbLYxwWsQ4XyRyt
 T0nzqFToZegZ3tiIPUPwhfeb7mCb4Gry0izEuiLKCp+hHVrdaj5ixvhuUSjy+ipTsCvyx4Kt
 StKlNDQq2oAnwLe8MmJS/Zxvw+h1D+D2hqV67RsL1o9iKzbLJAs2Pg3kJ8Sul7EBSj4hAP9i
 6r+Sw==
IronPort-Data: A9a23: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
 W/sDX64i4xMNqf/ZYNy0z7xvZJJNA==
IronPort-HdrOrdr: A9a23:1ECvRKM9OzLtw8BcTvyjsMiBIKoaSvp037By7TEVdfUnSL39qy
 nOpoVi6faaskdzZJhNo7y90cq7MAjhHPxOkOss1N6ZNWGM0gaVxepZg7cKtgeBJ8SIzI9gPM
 lbHJSWQ+eAamSSxfyKhjVQPexQueW6zA==
X-Talos-CUID: 9a23:Xr3eSm59CeGjma3vadss+BA+Ku4mI0Xhl0zrGGaeKGVsD+a2YArF
X-Talos-MUID: 9a23:7Czu4QTdESZ0R/1hRXTdgDJtKsRK6p2NDWEIvslYgNenEypZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="135077959"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA28.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:08 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 25 Oct 2023 11:43:08 +0200
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.169)
 by XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Wed, 25 Oct 2023 11:43:08 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2hzgb8r7hZalJF0ZM2bkrYt5zOI2Yeh52VSsO3MiBtOm8Abdht3AAeWtavVWCcro6E0QUsykMYy0HbvogvfsTVvfaXttf5gV43jY36KsPR9iefohkGUC2mldifWnxWwcsJVym0VrzqI1dmEPHatbeuz3M26KdWVpSkqkJSVTkL7+GubtL1Hq1iDwvClKd66clXm9mOOVifEUJrxxDNjhxt4W34wACV6WXFCKBF+QQSoDEvBfu/7NR1eISf1zJTfBADh+6wnR73/S7b9v7ztmr01JFhcmhhSlJHeeunx/5iQbKAvRYcvBUdMkD7sAjgCeTiPEYwiaVSQ0eA2oUUjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIOTMO6yC7WdeCt0aKqWADZaSZCE3fJU0LTeLb0YV08=;
 b=Qpb5n5l+AqRU/0oum+MBrunSDz1eWoTtXIrg5+0o42NyfYCA9VYSEvexjkhsGOlNfOui7hHLvH6uidZXs3eVn/0LtWnxf2IW1PLjTIEaorg4LOTJtk3m04CvYxYJqs/XXKyU5CLZ2IY2elRZMhqReamQ350nGXtqaeKl27XUlqV64MlKh0KjJK5vCleFQcP0vQZj739foVMg7drFAXm2hwVLNI9vSsZwWxZ0YgnsJTgxBxTOzkhKiTS6HtZ7mnAIB876N1IVAxJyQgjZWJq3YhOot0gouvqlFRpbJ3HCVVuvaSFUKvjVtNZgVrJ4HSS+KfcqJ8QfORuDDnbxTi9C5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIOTMO6yC7WdeCt0aKqWADZaSZCE3fJU0LTeLb0YV08=;
 b=dNUXAbV1XXvlA6B3Du397HVe50o/bkxqDFalI23RH5Zt27EGTjiOskvcZoNZ/ofT/7kgBqPmf0GOeKb3/GsU7vPZqxfDKGxALFr37ul73gUyJUu4AyIAQPNxcexVaQDHkIkNqRpXwp5q2wPtVS8VNctMDho8CWkajpi/3S0k/Qk=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by BE0P281MB0116.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 09:43:03 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 09:43:03 +0000
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
Subject: [RESEND RFC PATCH v2 10/14] lsm: Add security_sb_alloc_userns() hook
Date: Wed, 25 Oct 2023 11:42:20 +0200
Message-Id: <20231025094224.72858-11-michael.weiss@aisec.fraunhofer.de>
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
X-MS-Office365-Filtering-Correlation-Id: ce86aa94-ab14-4c5e-f490-08dbd53ec8b5
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QbgbIKIngUxtsPJvgT/sCum3eicU7A48hQd8rzkB01YSVWePCPn9urLE6xLhCr+8DwAvftzISqEaQ3ywUOz7iscGXT5WP2+De4wlqlV71djhDgtobVw6myqlPkMYZbh7aAkP3joQXuCB0F5ocb4tyJdKu87qDEIUnd056cT+fjjGRtz6keVpC01roAa2Wxko4AogCHnrS5tOctiNMq5JP/89Dpa+K8sHTNLNPRoOvvv4NCnghvbYCIb7tCc8u9OaD/PxxhCBGDiq2aqo1EAU2iudgKYKDhzAttJRHQTyMB9vU1PtzcZtPKMa2TAu4tvf8+Fv1uqoktkW5EOol4jhoJvYUlBBaVdlrdQK9LLewv6M6BJbOk1ClyKIkrV/JWLHvlXahVeXdZ1/tH0mZ59uP5AOuvcvodbGn+Oqgc0HRMdcG/OnDXQix//9cAJ6XQBIRbIM/KrFGNcGvahrLyQHaDOb9bja1zP5IPMkgJaxaV5qZrlILa8BLyGXl0tp9hkfg2UTq7ySzvd01PNJ/8OVBonSOuxg100v/uNz6X63KS+mch8Iu14OCW1DyxbmrDmvF0gKDroaK3fURtyxn0zVWkdqUO2lMaBBunEzhXZ7WzU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66946007)(83380400001)(316002)(38100700002)(6486002)(478600001)(6666004)(54906003)(110136005)(66556008)(66476007)(1076003)(107886003)(52116002)(6506007)(2616005)(6512007)(15650500001)(7416002)(2906002)(86362001)(4326008)(8936002)(82960400001)(8676002)(41300700001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGoxQnZNVHcxbTIxU1NJY1NtUnpORWQ5ckJsRWxkcEVsTXJXVitHanI0eVNp?=
 =?utf-8?B?TklvK2gyOGpNNFptclU0OHBHUXhraHYxV1puSmJKbkowWjlhcE9TV0Y4UWJm?=
 =?utf-8?B?Y0JrSDBZTjVPbjdCeHR4OHpiRFNKUU1TL2FVTUN6UForOHlvYlM5Vkc1dVVG?=
 =?utf-8?B?S1JYZFIrUFBwak0xK21WN2NBM1JPUDZQMjhucU5BakpQWkFTQVBLWVNwTHpv?=
 =?utf-8?B?dDFlZG5jK0d1Z3AvNFBlUis1K0xxVmdoUlplVVY3NWNIM280eXBLSmFLL1lB?=
 =?utf-8?B?aG1KOWdkQTdkSTR5Q3Qxcmdaak5lQml5bmx5SDVUb3R6eERPdHBoUVlWZ1hQ?=
 =?utf-8?B?YjBDWVVmSk1MRDBSMVJxRlF6c2hneFlBakR3endyelc4dVdJZHdDSEFYVWt5?=
 =?utf-8?B?U0dPMnhJaEtVYzNrVUp4NGNrTzJJbHVNWlUvRWg1amFmWTV6Y0VGZ1gyb2V1?=
 =?utf-8?B?RHR5cFZrV3JEbEdnV3ZWQnNPNzBxdTRteEYyWnk3cXRZMitMd2V5R0pMdU91?=
 =?utf-8?B?eHpDUmFwb0dYa2JjUzZNNEsvYVVrWkxoN0tNOUFhMWwrV3poYlpOOEV3QzI3?=
 =?utf-8?B?bERQQUUrYzB2Ums2TUlGZ2dNbjg1Z0FJblRQenZHajBmLzlIUWR2RFhPTU1J?=
 =?utf-8?B?N3o2VEE1TCs2V2syVXNQbUdFajlRbW5OY2NUSFRmNXhlSk5wUW1MWWF2SnRl?=
 =?utf-8?B?UzRqdnJVOEM5Vm45Q3FvZUZjTkE1dWswWG4xSHV0bHg0dlJEaDN5ZThvbXRE?=
 =?utf-8?B?dHpkMWwxUVMzYTRCOUVvRU0rQnc0UStjbHprMlpUY2dEWEpwbUhzUFhOSi9w?=
 =?utf-8?B?bzBacm9zWkZqL0tCakNvejJzcWhvWjVtUXB6dEVFREx6QXFvMllSdjYwTUx5?=
 =?utf-8?B?UEhQSFMzOWx4dCtDMFVXNXFvejFRMy83WUhEbld5Q2VOYVZHcGR1OHZMVnVx?=
 =?utf-8?B?TDRoTlVqUHlUVHJKaEpQNjV0d0VEVXcyblZMU3VQRjJpT1JRTytMQ1BMTC9C?=
 =?utf-8?B?emMzU2FHMkxRYUpLWHFYdUtvMlA1amxGRm1EVm5pNmZXc05Sd05UaS9WdU9q?=
 =?utf-8?B?MU5CZktZVWFpUy9UelRkVHpVTGhhaG53c3NReHRQTnpoNGtYOXllQ3gyYTFU?=
 =?utf-8?B?TWZsck1hZFFBZWd3aEJ1ejBmK1RUUUFhWnFXT1dGaFJ1RnhCd051WURKNUts?=
 =?utf-8?B?QzFpdUNlazhId1FCM09iclVhS2ZyMWpsSHMyeDFNcmo3aEJPZmc3RTBVUkR1?=
 =?utf-8?B?TXJRUkZFeCs3Q2J0REpGclUvT1V3Zml1dGdhSVBtOUQrVnJBeGlVdnJ1Vmpy?=
 =?utf-8?B?bDV0blBTQU1RQTJLMXpteHFtbXhyT1JUTm9SdWxKZWdkQlQrNUI3TC8zYU1M?=
 =?utf-8?B?K001QWt0dEwrR2FRRHREMnlsUGx1Y0Z0T09BcHdFUVc0U1F6ZG1MemFBbmlp?=
 =?utf-8?B?amJ3YytnSm5Fc1ZXNUhTWm1FeE9zbk9leVVndVNrWUJGaEQ2V0F6VjQ2d3lC?=
 =?utf-8?B?MmJqQ0M3NkNmOXFTRGFiNVB4ang4VjJiSnNQcHprQnRwTENpTjVvdUVEdXd3?=
 =?utf-8?B?c05UUEJPc2lWNk9mdUszc1BabkxJVmtJZ1A3NmkycXFUMGhrSVpiM2J3Qmhr?=
 =?utf-8?B?ZE5YdFRPaVMzZGx5ckdxWnpzdk55WDNhbHFwZlI3SldhdzN4dENtWjR1eklL?=
 =?utf-8?B?UHM2dUE3TXpsTlVFMDlxK2YzVk9NaFZqU2R4bHB3cCtLaUQ5aFVRY2IzU21i?=
 =?utf-8?B?aEVwaklpZTJTUUtJenIwS0twVVVXcEtYLzdNRDRhSVNoRDM5ZldmUFlSR04y?=
 =?utf-8?B?SVUyZHpKVjRqWW9mVzVYa0U0K0pCbXpTYjlFMWltaEttWWFxdlkvbzc5SUs4?=
 =?utf-8?B?WFhuSDVlVGdHYmhpM1J3V1RscjNmaEkzUUk1dEw3WUlwT0VlOUhBOU5jVngv?=
 =?utf-8?B?Q2ZVUWgyWXdvVjZnMFlSWEh2Q0xzcnBramMrOXl0SlFjSmNnODJJR1B2Zmt3?=
 =?utf-8?B?LzI4bDVlS0JjWEZ6Mk43MWpRaC9wdURvOXJ1WnNETFRPTzA5WGFOTlhjelYw?=
 =?utf-8?B?bTlsbjlPVXFZNlpna2grWWFLN0J3NzZVT09PcExIcm4ySzRyM2FHc29XOXpi?=
 =?utf-8?B?bXhwYkc3UXFFbkdYcURXdUhIN3gzdm01Qk9tS0JtNVNvc2RpSjN5WW00cm83?=
 =?utf-8?B?dWkvWGdoUzJhd2QwaHV6SWdPc3ovd1QvS25CVDZDS0Mzdm8zYVhCWEx0Mith?=
 =?utf-8?Q?yn/+SlXnuLdx8E715HKeKC312uXWCAv5Czigv4Tq1A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce86aa94-ab14-4c5e-f490-08dbd53ec8b5
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:43:03.6216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JgeP67re2q74JkCUO30lzjbAs+YaH9mKGtX3aa1EDydjk67ULJNDox/xr3C+mEVtIbzR0v14mz4P5IHzheYMFWb9xw3QkIN/bArfkH1/gJ4+r/cHrfLfBk1yhrOHCDkF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0116
X-OriginatorOrg: aisec.fraunhofer.de

Provide a new lsm hook which may be used to allow access to device
nodes for super blocks created in unprivileged namespaces if some
sort of device guard to control access is implemented.

By default this will return -EPERM if no lsm implements the hook.
A first lsm to use this will be the lately converted cgroup_device
module.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  5 +++++
 security/security.c           | 26 ++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index f4fa01182910..0f734a0a5ebc 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -278,6 +278,7 @@ LSM_HOOK(int, 0, inode_getsecctx, struct inode *inode, void **ctx,
 LSM_HOOK(int, 0, dev_permission, umode_t mode, dev_t dev, int mask)
 LSM_HOOK(int, -EPERM, inode_mknod_nscap, struct inode *dir, struct dentry *dentry,
 	 umode_t mode, dev_t dev)
+LSM_HOOK(int, -EPERM, sb_alloc_userns, struct super_block *sb)
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
 LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
diff --git a/include/linux/security.h b/include/linux/security.h
index bad6992877f4..0f66be1ed1ed 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -487,6 +487,7 @@ int security_locked_down(enum lockdown_reason what);
 int security_dev_permission(umode_t mode, dev_t dev, int mask);
 int security_inode_mknod_nscap(struct inode *dir, struct dentry *dentry,
 			       umode_t mode, dev_t dev);
+int security_sb_alloc_userns(struct super_block *sb);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1408,6 +1409,10 @@ static inline int security_inode_mknod_nscap(struct inode *dir,
 {
 	return -EPERM;
 }
+static inline int security_sb_alloc_userns(struct super_block *sb)
+{
+	return -EPERM;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/security/security.c b/security/security.c
index 7708374b6d7e..9d5d4ec28e62 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4065,6 +4065,32 @@ int security_inode_mknod_nscap(struct inode *dir, struct dentry *dentry,
 }
 EXPORT_SYMBOL(security_inode_mknod_nscap);
 
+/**
+ * security_sb_alloc_userns() - Grand access to device nodes on sb in userns
+ *
+ * If device access is provided elsewere, this hook will grand access to device nodes
+ * on the allocated sb for unprivileged user namespaces.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
+int security_sb_alloc_userns(struct super_block *sb)
+{
+	int thisrc;
+	int rc = LSM_RET_DEFAULT(sb_alloc_userns);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.sb_alloc_userns, list) {
+		thisrc = hp->hook.sb_alloc_userns(sb);
+		if (thisrc != LSM_RET_DEFAULT(sb_alloc_userns)) {
+			rc = thisrc;
+			if (thisrc != 0)
+				break;
+		}
+	}
+	return rc;
+}
+EXPORT_SYMBOL(security_sb_alloc_userns);
+
 #ifdef CONFIG_WATCH_QUEUE
 /**
  * security_post_notification() - Check if a watch notification can be posted
-- 
2.30.2


