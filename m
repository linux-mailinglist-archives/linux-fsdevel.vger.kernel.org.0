Return-Path: <linux-fsdevel+bounces-1146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB42F7D6744
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 11:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48700B212DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 09:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11D426E13;
	Wed, 25 Oct 2023 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="VsImCdJ5";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="KWzJjcuK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92061641F;
	Wed, 25 Oct 2023 09:44:08 +0000 (UTC)
Received: from mail-edgeka24.fraunhofer.de (mail-edgeka24.fraunhofer.de [IPv6:2a03:db80:4420:b000::25:24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9009DC;
	Wed, 25 Oct 2023 02:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1698227046; x=1729763046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UvaaY0D2++qOD/ii0lqFtjoizSxctX+kms0LuYLxRQU=;
  b=VsImCdJ5NwKF2bDq+rZwfYe/sw24G3hauGr+3+QMJPW3tjC/ed2t/cM8
   C5isAB9PI4ShWT7hGGi+jv4Zg7rKm62WbyaN+F/Dvp7ZQhZ6afmV4bY63
   wL2UTQ33gci3MDevVrmcjwYdJ7UpAM2tOEh1mw4MI89oUeNg2mtGdm0ln
   6oMH0Ov2z5r8Xnespabh0O91OEPma566i9RtBa77b6c10NLDBZwnGb2ci
   e6j0jfqz+D5wlFxGwXYw/MbJ/L4XOce6G/1C6xMU9xFMX4jsFbvTNpeNi
   /XXeIT+N8IKQ4gxKIgVjz91iIqt+3F/FIVUaShjFqsSEi9AtYVIbkvSv9
   w==;
X-CSE-ConnectionGUID: UsCzEJH8QGKJVSbJ/d1qnQ==
X-CSE-MsgGUID: 1t6KDezzSF2yxEQnL9FvCw==
Authentication-Results: mail-edgeka24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2ElAABB4jhl/xwBYJlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4gleEU4gdiUGcKiqBLBSBEQNWDwEBAQEBAQEBAQcBAUQEAQEDB?=
 =?us-ascii?q?IR1CgKHGic0CQ4BAgEDAQEBAQMCAwEBAQEBAQECAQEGAQEBAQEBBgYCgRmFL?=
 =?us-ascii?q?zkNhACBHgEBAQEBAQEBAQEBAR0CNVQCAQMjBAsBDQEBNwEPJQImAgIyJQYBD?=
 =?us-ascii?q?QWCfoIrAzGyGH8zgQGCCQEBBrAfGIEggR4JCQGBEC4Bg1uELgGENIEdhDWCT?=
 =?us-ascii?q?4EVNYEGgT5vhAYEHy+DRoJogVaCH4UAPAcygiKCejUpg0Vph1CBAUdaFhsDB?=
 =?us-ascii?q?wNZKhArBwQtIgYJFi0lBlEEFxYkCRMSPgSBZ4FRCoEDPw8OEYJCIgIHNjYZS?=
 =?us-ascii?q?4JbCRUMNQRJdhAqBBQXgRFuBRoVHjcREhcNAwh2HQIRIzwDBQMENAoVDQshB?=
 =?us-ascii?q?VcDRAZKCwMCGgUDAwSBNgUNHgIQLScDAxlNAhAUAzsDAwYDCzEDMFdHDFkDb?=
 =?us-ascii?q?B8aHAk8DwwfAhseDTIDCQMHBSwdQAMLGA1IESw1Bg4bRAFzB51NgXouRVg2A?=
 =?us-ascii?q?YE8PF8Rlh0BjBiiYQeCMYFeoQkaM5crkk8umA4goj6FSgIEAgQFAg4IgWOCF?=
 =?us-ascii?q?jM+gzZSGQ+OIAwWFoNAj3t0AjkCBwEKAQEDCYI5hjWCXQEB?=
IronPort-PHdr: A9a23:JpXXBhHZqhiouQJblQvDn51Gf3BNhN3EVzX9l7I53usdOq325Y/re
 Vff7K8w0gyBVtDB5vZNm+fa9LrtXWUQ7JrS1RJKfMlCTRYYj8URkQE6RsmDDEzwNvnxaCImW
 s9FUQwt5CSgPExYE9r5fQeXrGe78DgSHRvyL09yIOH0EZTVlMO5y6W5/JiABmcAhG+Te7R3f
 jm/sQiDjdQcg4ZpNvQUxwDSq3RFPsV6l0hvI06emQq52tao8cxG0gF9/sws7dVBVqOoT+Edd
 vl1HD8mOmY66YjQuB/PQBGmylAcX24VwX8qSwLFuQn/f4vz7S/5l/Vg2C6eZ8zTEbARCDayt
 P41dkLKoigaDD4i3TyGgPJvpocO83fD7xYq4LHGQoOeKdlYIoHwJpAodXcYWstrZTxBBYH7N
 YQFMuEeZNgIgdTmrBxWhze1NAi2AvPmywJHmXn5+vML0bgYNRqZxyYaDdg/lC7W8enRZIAZf
 +qtyfiZlx/9a8176zPlsITMaE54h9a9Bapfa+z61UMUHQCVsnqAjqP5HWqpxNhSoS+488w/X
 s2hkzQYjAx2pRu16J89qoP1uLoPlEL+0ihUkZYPLvq/R2xwNI3sAN5RrSacL4xsXoY4Tnp1v
 Dpv0rQdos3TlEkizZ0mw1vSZ/OKcIHSvlTtTu+MJzd/in9/Pr6y1F6+8kmln/X1TdL8kE1Lo
 SxMjsTWuzgT2gbS5MmKRro1/kqo1TuVkQGGwu9eKF0yla3VJoRnxbg1l5EJtl/EEDOwk0Lz5
 JI=
X-Talos-CUID: 9a23:vX7no2PAj5FiUO5DZTJM5mM2OpAcXV7/8kzaAQi0UH9vcejA
X-Talos-MUID: 9a23:qHyVKARTOcVEJvbQRXS1mG9BGMp68Z+AUlEdvKwAn5iqKwdvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="1802487"
Received: from mail-mtaka28.fraunhofer.de ([153.96.1.28])
  by mail-edgeka24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:42:56 +0200
IronPort-SDR: 6538e31e_SVkz+WtSrnIdaVjRtAd2dn2jlB4LrnOoT69w0XC6kpFrx50
 ga2osAWbubpX5I0u/WiqWUdKZjdLJs1govSjWdA==
X-IPAS-Result: =?us-ascii?q?A0A8AAC94Thl/3+zYZlaHAEBAQEBAQcBARIBAQQEAQFAC?=
 =?us-ascii?q?RyBFgcBAQsBgWZSB4FLgQWEUoNNAQGETl+GQYIhOwGcGIEsFIERA1YPAQMBA?=
 =?us-ascii?q?QEBAQcBAUQEAQGEfAoChxcCJzQJDgECAQECAQEBAQMCAwEBAQEBAQMBAQUBA?=
 =?us-ascii?q?QECAQEGBIEKE4VoDYZNAgEDEhEECwENAQEUIwEPJQImAgIyBx4GAQ0FIoJcg?=
 =?us-ascii?q?isDMQIBAaUwAYFAAosifzOBAYIJAQEGBASwFxiBIIEeCQkBgRAuAYNbhC4Bh?=
 =?us-ascii?q?DSBHYQ1gk+BFTWBBoE+b4QGBB+DdYJogVaCH4UAPAcygiKCejUpg0Vph1CBA?=
 =?us-ascii?q?UdaFhsDBwNZKhArBwQtIgYJFi0lBlEEFxYkCRMSPgSBZ4FRCoEDPw8OEYJCI?=
 =?us-ascii?q?gIHNjYZS4JbCRUMNQRJdhAqBBQXgRFuBRoVHjcREhcNAwh2HQIRIzwDBQMEN?=
 =?us-ascii?q?AoVDQshBVcDRAZKCwMCGgUDAwSBNgUNHgIQLScDAxlNAhAUAzsDAwYDCzEDM?=
 =?us-ascii?q?FdHDFkDbB8WBBwJPA8MHwIbHg0yAwkDBwUsHUADCxgNSBEsNQYOG0QBcwedT?=
 =?us-ascii?q?YF6LkVYNgGBPDxfEZYdAYwYomEHgjGBXqEJGjOXK5JPLpgOIKI+hUoCBAIEB?=
 =?us-ascii?q?QIOAQEGgWM8gVkzPoM2TwMZD44gDBYWg0CPe0EzAjkCBwEKAQEDCYI5hjWCX?=
 =?us-ascii?q?AEB?=
IronPort-PHdr: A9a23:T9zkzh+Bs0AUef9uWWy9ngc9DxPPxp3qa1dGopNykalHN7+j9s6/Y
 h+X7qB3gVvATYjXrOhJj+PGvqyzPA5I7cOPqnkfdpxLWRIfz8IQmg0rGsmeDkPnavXtan9yB
 5FZWVto9G28KxIQFtz3elvSpXO/93sVHBD+PhByPeP7BsvZiMHksoL6+8j9eQJN1ha0fb4gF
 wi8rwjaqpszjJB5I6k8jzrl8FBPffhbw38tGUOLkkTZx+KduaBu6T9RvPRzx4tlauDXb684R
 LpXAXEdPmY56dfCmTLDQACMtR5+Gm8WxwJNIhTHsxX5f4jssiz+7OtYhCm/bM/mFulqZ2mAx
 ah2cx/zpXpWPQAm2kSC2akSxKgOgy2zhR503q3yPKO4b7lMTr6Eed4gd3pBWcQWDSNLP4ijN
 rVfIbcaNqEAhaX2lloUqwu3BDSjG+Xg7WF5hCPP+bZlyM4bAwv3+FYiQu4q4FPfgt/tMfZDC
 8qLyJfl/zHbN/9Sw2mkzq/5KggOu9enQbhLe8mB9WY/MCzZrAysu7C6LXS2ysJSuEeV97Bfc
 u+ojE09hVlggjKT+P821JvzoY84m0D+/gJ+z6Q+cI7wWAt6e9miCJxKq2SAOpBrRt93W2hzo
 3VSItwuvJe6eG0P1J0E7kSPLfKdepWO4hXtWfzXLTorzH5mebfqnx+p6gDg0ezzUMCozUxH5
 jRIiNjCt30BllTT58GLR+E7/xKJ1yyGygbT7e9JOwYzk6/aIIQm2bk+itwYtkGrIw==
IronPort-Data: A9a23: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
 37sWm+R+CqD7xT/Y0fyVw4B2seY0c62I/U=
IronPort-HdrOrdr: A9a23:+VWDVqxUEyFSRGE7w46oKrPwQ71zdoMgy1knxilNoH1uH/Bw+P
 rPoB1273XJYUgqOU3I8OroUMK9qBjnmaKdj7N/AV7bZmfbhFc=
X-Talos-CUID: =?us-ascii?q?9a23=3Alv5xrWtlwCJjhTKtiA+iUKq+6IseT2zE1nn+OnO?=
 =?us-ascii?q?jCEAwd/7MbUCX3Ptdxp8=3D?=
X-Talos-MUID: 9a23:4rSwYQXvqHGbY6Pq/GLhmWh8a/tx3/mBSxFRiZxFi/KjZSMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="135077913"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA28.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:42:53 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 25 Oct 2023 11:42:53 +0200
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.168)
 by XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Wed, 25 Oct 2023 11:42:53 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZg46aljA1ZaPrmZW/IC1pQ37bPo6dOeNAYiyEhk7Yb18JkWQ5nRUeIPxnJBXlqJCUk3C7hZc2g5fkP9jiG2pl/bW2IFOEFwuiYFMrzmkcDryf5xbAYCVKd3ZGzuONkC4cnMo04hSaQoXueO+3TlUJgbvrawKHFRcreAAYs64VH0PacCBO53Zb2+9OhTChggiU/ZfgYy1AF0v+m2m9LCfnPdEkoyv2fnGmncgCACaajXkMlJjIom8YhCCFbQ/MZwClz1vNlazILy+mhDdKwhyU+G+0972Ack3gn+7GGzYiVp8VpLAdIfSUWa9MzF5xSNDT/iE9LoKRO+0cCbiRmcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmItj7lkIwuhol2iM4hM9jx316V5JBguShsE59bVwBM=;
 b=TmbAU09A9UN1rkR1oorAJvbs2SxyIBSsecpmG9kjjA3TiL0g2qdq+VsTNknHkkVwJs9zjjtTZj5XNkV42D9GdLBLOLGhiOlL+2ttDYA7FIfEoA86TzLpF/rXy9RxTq6lwVapzPhXCRhTQEcyzKExA1gP6vDGKGJt/ZGcfzt040+GIpLtlDbvuBv8mAG+NkTkTSYiKhh/AlyvV7wAViNntRg6wE9fHpPD/Pxk8fHsgB8N113Y2pzkW9veqFP47DCPDaap+SNEQc/C4uQFYZvFWrlE20kwpZOaWP0mtBF56TjqqreceUcK3B6bi1wNsAqk1mpKkvMuSCwZnT9c8lNXxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmItj7lkIwuhol2iM4hM9jx316V5JBguShsE59bVwBM=;
 b=KWzJjcuKN4JE3+ZXu1leRZxhoj/2gbUcw1V8F5sc/0BDcYirnxaiUgwngO6Yj4QLs7sBRzbYL2j5TL8OcFbpm992BVlVEZlp0dlr61NOY0pGrNCtbSbk8TGxOGtJ1TzT7z/KtN7cGfp2WOeooKrF0yHbTVPr6zROeE9xRcOogJc=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by BEZP281MB1814.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:5a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 09:42:52 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 09:42:52 +0000
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
Subject: [RESEND RFC PATCH v2 01/14] device_cgroup: Implement devcgroup hooks as lsm security hooks
Date: Wed, 25 Oct 2023 11:42:11 +0200
Message-Id: <20231025094224.72858-2-michael.weiss@aisec.fraunhofer.de>
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
X-MS-TrafficTypeDiagnostic: BEZP281MB2791:EE_|BEZP281MB1814:EE_
X-MS-Office365-Filtering-Correlation-Id: 89133558-01a2-4e78-1f3b-08dbd53ec219
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ScFY5SICWCi5VFR/ImqkvuiYTw7WuAsZjcHU4ycButAE4UsGUtOUynM1i7j41xF0+Z4Vfkmf6j5yXgNxKZqXJr7QrByiwAAtvDit802SR4mbqDe+y9veuXUTaSH9M7E9Lb4yyH441q+FQO5ZH/rqkGyYKm4yMjCmgT2KViaNu86YiDZRh76brPpdQTPGfA799WPxaOpn3S7agnRED79/m/4uxdoF2ODtfD9VdfyZgUIUiMYH9enVndYo8Ylma/8sPqI4qY+wLgTu5AuIbwZ8kenbOds2qw2x0H//1olC7mbommm7uQo3m3fybeLu++JEJHPaGeWMMyCgY6ptY7OBcyTS4MTmqnAYjsK0mmKuuEJkbR0WijtCugm/ft8Pkvn/GumY5QZ/0vjXSyDqqHmMY3dppHhGYxX/PVvlsK5TPS9wTwKErBkFPQEoWLwXG0mlhoYAzr4F69ToacOu85tj/ra+3uRvPhX1om6rMOlURkAIJN1d21IHgK5XchMudbPn66BvVNe/B02tBWFK54YHGlchzbIOfKm+LBHu8Smuf1mkI7UUh7FUUlse3mY0ZgJHc5Q9hz0RUm2pU7x1VHUmh9XHkZFKmxAb6Cp1E1yVtUk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(110136005)(38100700002)(41300700001)(2906002)(7416002)(86362001)(5660300002)(15650500001)(8676002)(8936002)(4326008)(6666004)(6506007)(478600001)(107886003)(54906003)(1076003)(82960400001)(66476007)(66946007)(316002)(66556008)(2616005)(83380400001)(6512007)(6486002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVRqclo1dytZR1ZhbUV3Y1kxaDFPV05IUjRZMXEwNVFGU0FNelFscGdaTkhv?=
 =?utf-8?B?RkFqTEt1a0oxT0JGLzZucEtDUHM1Z3F6dU44aXJydVZpekRqTXpZaGoxQmwv?=
 =?utf-8?B?WEhaMDlNeU1mdWVPQmFtdi9YYzJaVDhodzhZaTFUR1cxMVFtMStMcjhtekIz?=
 =?utf-8?B?RkN5YmdHRmdwd2RJdDdXb3JBL1JlSXhyQTlmdlNUTXlnZVhxYlF6MmFjUEI2?=
 =?utf-8?B?NWYxMFZIMjNqQnBGL1hrMnRPSUx1ZjduZDdLVVZvYzZGb3VjZjdDcnZrSytY?=
 =?utf-8?B?MHg4RDM2Um4rMEdNMlRFZGw0cmF0eTB4eGZLVkxHa0Y1MkdmNERKV0NxU3JF?=
 =?utf-8?B?M2QrbkJ5SGc5MHlMZE1xYnZPTisxSVRaM2F0cTJmR1ZXeW1nYjB6cGNqUTJm?=
 =?utf-8?B?V0lkRzBmNFFscW42UFZGYlVDOUNjR3RzZ3pYYTZYQUY3WVdGb2dteW93bnIx?=
 =?utf-8?B?di9TRkU1U295WHM1Q3Y0a3c0WDNIOGpuQ01xRUw2SDJTS21XWnlWMmpxWnI0?=
 =?utf-8?B?UE5IbytaVUVpWFoxNjlLRlBMV1FXL3laYk0xcWxPRjA4M3NxWjczSldYVHpy?=
 =?utf-8?B?bzVrUms5ZXFCVTRsekdHbmk0QVY3cUFXRWQyeXFiQ3ZTU2RBYU84V1FzMjNi?=
 =?utf-8?B?aG1BKzU1RlhqZzR6T0d1MVZZc2trUFkxNXFsZXArSDF0cHhZQ2JhQ1N6dTZu?=
 =?utf-8?B?dEQ3NDRPL0dEbkwvL21XWkhqWVpsaU53TDU4WitmbGJnc096czhFakJiTEFq?=
 =?utf-8?B?ZEF3UkQ0cC9iK3hKaVVvRDlOOTVwZ2JEblZiMEM5RWtoZk11WHQzeEFMd1pO?=
 =?utf-8?B?N2hUOEdpNXFtNFZHdVdoZU03T3QySXU2KzFSaHlva1BnNWRrL1pUbWFYQXJm?=
 =?utf-8?B?NVVXeTNUUDlCNVkvVEtLWm1KeElzV3F4a201YS90dm5jY0ErSnhjV1pNMzJY?=
 =?utf-8?B?bnQzRHRHQ05qS1BuRitFYjlQb1R2d3dSck14REMxYVVGZWh5SW9uZWVCV0ww?=
 =?utf-8?B?K2VwZ3JjU3dhKzZsckV1eHlJd2lqWDlVbDV0aCs4amNDSWRKcFBkamNJekMr?=
 =?utf-8?B?VktIMVVvb3NPM0RyaGY0MXllZ002WDJCd1h4Y2JTNnpGaWhJcC9LckQyQlRR?=
 =?utf-8?B?UzkrTVBzNjIzRG1QQUFjUHVST0NpdldQK3JSVlZFa01wUU1nVUFLRkVaVm1q?=
 =?utf-8?B?aVFpcWQzZGE2am1JMmZzTm5PTnA4R094NGYzSlJvWlNZeVhJT016ZklqSm9w?=
 =?utf-8?B?ZU83c2swNmdIcDhHdzhkTzRUWDVWK0xmckIyb2huK1RtY0dJc0ExWXl6NGxw?=
 =?utf-8?B?dFJ1K2FzOFlJMmN3cGdPWkE3TGUva1A2eDE1OXlkQzJTTitlUTJ5YlM0citL?=
 =?utf-8?B?K29ta2o2dVdwelRVUjRNaHNuaGtmM0JucTdobEJZaUZ2b2RKZFRmS0FqbTNZ?=
 =?utf-8?B?a2tMSldIOTJybnFQbktzclp0TXQvakp1K2VYV1JVSXNad2VjakRJazdDNlZN?=
 =?utf-8?B?ckU1VXNidi9mN3ZnemFieHFrdnBkZytHTzBqblFqYlUxcFl4S01DaVRuaW4v?=
 =?utf-8?B?RmE1OWRKb1VtdjVPSWRJQkNrODdTN2hSVkswK0JBUXVNTGczaDZqMjJ5NGJo?=
 =?utf-8?B?eU5nYUtHSkF1cThPNHpHRDRsRFpNd3Z4ZnFPUDNjQzFVaGpxNE5wWFVOQXlI?=
 =?utf-8?B?Tlg0YjVkVXpMV2k0NnF3Z3kwMnhjVFMvWU1MdFhTUU93YnZycGRja0tobGo5?=
 =?utf-8?B?bnhxTXAvNEkxM0g0dGFzNXJDajlLblJVa0NmRFBuS0VxaTJUSXdqSk5vZlQv?=
 =?utf-8?B?ZWlDdGxmR3BRR0VVaWpqd0Qra01keUhhb21FYmxMOHcyZjJrMWVnVHpCcHdD?=
 =?utf-8?B?NnhxZVFSTE8rVGs3RmNxR1NOZ3hsVEhUeG9neU9ZUFBheHJXNlNBb296RWF5?=
 =?utf-8?B?dS8zV2hhd0xwajh1MjVrRnJBVURvRHdIbjdKWlEvM1hRT0Z6OFQxSThQa2kv?=
 =?utf-8?B?V2VrQzkzS1lMYmZjYzQ5YTJGN2puenZPREhRVkFESkQwd28rbXhBTGx4U3Rp?=
 =?utf-8?B?VEgvb2VkZFJPaTQ4cnFQKzE0NWtFZUlzSDlkMC9FUUpZVndyZnYxdENSdFh6?=
 =?utf-8?B?Z2dyUFQzWjRMYnM5R3ZQbmhtMTZzOThuNXFhSGdiM1UvRTJHcTJYc1pVYkVW?=
 =?utf-8?B?Ukk4M1BFcHdqNDc4M3QxS0VGbFVxUSs4NXZOejkzOUh0VGpvSDhncm84ZEla?=
 =?utf-8?Q?XCGdwUxECxOFGZpWOaGUeix6uNQ6PP3n6FItHoUcbI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89133558-01a2-4e78-1f3b-08dbd53ec219
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:42:52.5908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlB/ngqRoJJyjF/5UCmh/JKp5moB6LgnBl4R8bHyIafHah6+J7SNpaeY5ijT5sLxwe3doTiQ/R1+uHMPq+U5YmFrLEeWQ8ni/amBa8Z5haZid0526YfrjPUm9Ml0hovX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB1814
X-OriginatorOrg: aisec.fraunhofer.de

devcgroup_inode_mknod and devcgroup_inode_permission hooks are
called at place where already the corresponding lsm hooks
security_inode_mknod and security_inode_permission are called
to govern device access. Though introduce a small LSM which
implements those two security hooks instead of the additional
explicit devcgroup calls. The explicit API will be removed when
corresponding subsystems will drop the direct call to devcgroup
hooks.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 init/Kconfig                                 |  4 +
 security/Kconfig                             |  1 +
 security/Makefile                            |  2 +-
 security/device_cgroup/Kconfig               |  7 ++
 security/device_cgroup/Makefile              |  4 +
 security/{ => device_cgroup}/device_cgroup.c |  0
 security/device_cgroup/lsm.c                 | 82 ++++++++++++++++++++
 7 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 security/device_cgroup/Kconfig
 create mode 100644 security/device_cgroup/Makefile
 rename security/{ => device_cgroup}/device_cgroup.c (100%)
 create mode 100644 security/device_cgroup/lsm.c

diff --git a/init/Kconfig b/init/Kconfig
index 6d35728b94b2..5ed28dc821f3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1111,6 +1111,8 @@ config PROC_PID_CPUSET
 
 config CGROUP_DEVICE
 	bool "Device controller"
+	select SECURITY
+	select SECURITY_DEVICE_CGROUP
 	help
 	  Provides a cgroup controller implementing whitelists for
 	  devices which a process in the cgroup can mknod or open.
@@ -1136,6 +1138,8 @@ config CGROUP_BPF
 	bool "Support for eBPF programs attached to cgroups"
 	depends on BPF_SYSCALL
 	select SOCK_CGROUP_DATA
+	select SECURITY
+	select SECURITY_DEVICE_CGROUP
 	help
 	  Allow attaching eBPF programs to a cgroup using the bpf(2)
 	  syscall command BPF_PROG_ATTACH.
diff --git a/security/Kconfig b/security/Kconfig
index 52c9af08ad35..0a0e60fc50e1 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -194,6 +194,7 @@ source "security/yama/Kconfig"
 source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
 source "security/landlock/Kconfig"
+source "security/device_cgroup/Kconfig"
 
 source "security/integrity/Kconfig"
 
diff --git a/security/Makefile b/security/Makefile
index 18121f8f85cd..7000cb8a69e8 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -21,7 +21,7 @@ obj-$(CONFIG_SECURITY_YAMA)		+= yama/
 obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
 obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
 obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
-obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
+obj-$(CONFIG_SECURITY_DEVICE_CGROUP)	+= device_cgroup/
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
 
diff --git a/security/device_cgroup/Kconfig b/security/device_cgroup/Kconfig
new file mode 100644
index 000000000000..93934bda3b8e
--- /dev/null
+++ b/security/device_cgroup/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config SECURITY_DEVICE_CGROUP
+	bool "Device Cgroup Support"
+	depends on SECURITY
+	help
+	  Provides the necessary security framework integration
+	  for cgroup device controller implementations.
diff --git a/security/device_cgroup/Makefile b/security/device_cgroup/Makefile
new file mode 100644
index 000000000000..c715b2b96388
--- /dev/null
+++ b/security/device_cgroup/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SECURITY_DEVICE_CGROUP) += devcgroup.o
+
+devcgroup-y := lsm.o device_cgroup.o
diff --git a/security/device_cgroup.c b/security/device_cgroup/device_cgroup.c
similarity index 100%
rename from security/device_cgroup.c
rename to security/device_cgroup/device_cgroup.c
diff --git a/security/device_cgroup/lsm.c b/security/device_cgroup/lsm.c
new file mode 100644
index 000000000000..ef30cff1f610
--- /dev/null
+++ b/security/device_cgroup/lsm.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device cgroup security module
+ *
+ * This file contains device cgroup LSM hooks.
+ *
+ * Copyright (C) 2023 Fraunhofer AISEC. All rights reserved.
+ * Based on code copied from <file:include/linux/device_cgroups.h> (which has no copyright)
+ *
+ * Authors: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
+ */
+
+#include <linux/bpf-cgroup.h>
+#include <linux/device_cgroup.h>
+#include <linux/lsm_hooks.h>
+
+static int devcg_inode_permission(struct inode *inode, int mask)
+{
+	short type, access = 0;
+
+	if (likely(!inode->i_rdev))
+		return 0;
+
+	if (S_ISBLK(inode->i_mode))
+		type = DEVCG_DEV_BLOCK;
+	else if (S_ISCHR(inode->i_mode))
+		type = DEVCG_DEV_CHAR;
+	else
+		return 0;
+
+	if (mask & MAY_WRITE)
+		access |= DEVCG_ACC_WRITE;
+	if (mask & MAY_READ)
+		access |= DEVCG_ACC_READ;
+
+	return devcgroup_check_permission(type, imajor(inode), iminor(inode),
+					  access);
+}
+
+static int __devcg_inode_mknod(int mode, dev_t dev, short access)
+{
+	short type;
+
+	if (!S_ISBLK(mode) && !S_ISCHR(mode))
+		return 0;
+
+	if (S_ISCHR(mode) && dev == WHITEOUT_DEV)
+		return 0;
+
+	if (S_ISBLK(mode))
+		type = DEVCG_DEV_BLOCK;
+	else
+		type = DEVCG_DEV_CHAR;
+
+	return devcgroup_check_permission(type, MAJOR(dev), MINOR(dev),
+					  access);
+}
+
+static int devcg_inode_mknod(struct inode *dir, struct dentry *dentry,
+				 umode_t mode, dev_t dev)
+{
+	return __devcg_inode_mknod(mode, dev, DEVCG_ACC_MKNOD);
+}
+
+static struct security_hook_list devcg_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(inode_permission, devcg_inode_permission),
+	LSM_HOOK_INIT(inode_mknod, devcg_inode_mknod),
+};
+
+static int __init devcgroup_init(void)
+{
+	security_add_hooks(devcg_hooks, ARRAY_SIZE(devcg_hooks),
+			   "devcgroup");
+	pr_info("device cgroup initialized\n");
+	return 0;
+}
+
+DEFINE_LSM(devcgroup) = {
+	.name = "devcgroup",
+	.order = LSM_ORDER_FIRST,
+	.init = devcgroup_init,
+};
-- 
2.30.2


