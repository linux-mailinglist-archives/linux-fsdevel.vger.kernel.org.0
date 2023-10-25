Return-Path: <linux-fsdevel+bounces-1140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BB87D6732
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 11:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 901F8B212DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 09:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503F42377E;
	Wed, 25 Oct 2023 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="UvFZmE0I";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="N2qf3WF3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722A8746C;
	Wed, 25 Oct 2023 09:44:07 +0000 (UTC)
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 02:44:04 PDT
Received: from mail-edgeDD24.fraunhofer.de (mail-edgedd24.fraunhofer.de [IPv6:2a03:db80:1504:d267::25:24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BD9B4;
	Wed, 25 Oct 2023 02:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1698227044; x=1729763044;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Up3YVuLKsGDdnBFQmhZhoKZMjl7vV68tAultxQbNSys=;
  b=UvFZmE0Ii0vlQYiYmcDkcURDngOqhLZ+AdlOLKxs8k9scK8UFnIAqgod
   hAcweGZkgg07XjJnuQC7k82yP6FsLzEhIlDPffblezwO3P4GfbkebZ1KB
   fL3SCPmjtziXAde1oT0lTaLbwpv3qAwgWj4FvWQdA+wNA2I0fVVSYjwmo
   9cum9Uvwb0VnylIcJz5KSnzZ3p95ROgdUrGYa9OhUyUb2Mko33m+4VV9q
   52tLO14hxm4EC9xawDo8CJVrrwpTm0EGFc/eFAI5oG7zACEBy6UHT3u7a
   3SPsfRMHSfpz+2P6U2czUXlfqNCtQ4sbGwfy4Xw6gtC5jMFKea54yqgF7
   A==;
X-CSE-ConnectionGUID: I2U5gTPAQ9qQ4Lrbjfnuqg==
X-CSE-MsgGUID: v7vt5JqZQEipSqwlBobHoA==
Authentication-Results: mail-edgeDD24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2E2AABB4jhl/xoBYJlaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YI4eoFdhFOIHYlBnCoqgSyBJQNWDwEBAQEBAQEBAQcBATsJBAEBAwSEf4ccJ?=
 =?us-ascii?q?zQJDgECAQMBAQEBAwIDAQEBAQEBAQIBAQYBAQEBAQEGBgKBGYUvOQ2EAIEeA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBHQINKFYnDwENAQE3ATQCJgI0KwENBYJ+AYIqAzEUBrF+g?=
 =?us-ascii?q?TKBAYIJAQEGsB8YgSCBHgMGCQGBEC4Bg1uELgGENIEdhwSBSoMzhFiDRoJog?=
 =?us-ascii?q?3WFPAcygiKDLymLfoEBR1oWGwMHA1kqECsHBC0iBgkWLSUGUQQXFiQJExI+B?=
 =?us-ascii?q?IM4CoEDPw8OEYJCIgIHNjYZS4JbCRUMNQRJdhAqBBQXgRFuBRoVHjcREhcNA?=
 =?us-ascii?q?wh2HQIRIzwDBQMENAoVDQshBVcDRAZKCwMCGgUDAwSBNgUNHgIQLScDAxlNA?=
 =?us-ascii?q?hAUAzsDAwYDCzEDMFdHDFkDbB8aHAk8CwQMHwIbHg0yAwkDBwUsHUADCxgNS?=
 =?us-ascii?q?BEsNQYOG0QBcwecYG2CTRkHPVEBKwRJA18iCSMvHJJPLgyDCQGueQeCMYFej?=
 =?us-ascii?q?AGVCBozlyuSTy6YDiCLUIF1lHmFSgIEAgQFAg4IgWOCFjM+T4JnUhkPjiA4g?=
 =?us-ascii?q?0CFFIpndAIBOAIHAQoBAQMJgjmEFIR+AQE?=
IronPort-PHdr: A9a23:lPrJrBKHcCYjC/1bwtmcuDdnWUAX0o4cQyYLv8N0w7sbaL+quo/iN
 RaCu6YlhwrTUIHS+/9IzPDbt6nwVGBThPTJvCUMapVRUR8Ch8gM2QsmBc+OE0rgK/D2KSc9G
 ZcKTwp+8nW2OlRSApy7aUfbv3uy6jAfAFD4Mw90Lf7yAYnck4G80OXhnv+bY1Bmnj24M597M
 BjklhjbtMQdndlHJ70qwxTE51pkKc9Rw39lI07Wowfk65WV3btOthpdoekg8MgSYeDfROEVX
 bdYBTIpPiUO6cvnuAPqYSCP63AfAQB02hBIVizZxkj0DqeyuTHk6so+yibCep2qa7Uzdh6u1
 oZsdED0sCMaNBti/lDrt5Ql38c56Bj0gUZmzdXrTtq4KctBYvnGTewrRnFLQMB/VxJQBtjta
 qlRDtgPP+ZCpJbP+3oEtED5DDKrBefdzxJO2W3R5fUY9N4gTS/qzU8DJ4lXsGyXld/ROaw8C
 s+awon6wy6TcNNViC7suKrEfEAjmvzVUZNxIPjS4GMmPDOYqU6396XuJiOL8ecc61ew7LZNC
 r6tmkMoiQBspym9xsgItYjWltstlGn25AYl+r4rP97oHR0zcZulCpxWryaAK85sT9g/R309o
 C8h0e5uUf+TeSELzNEqyxHSR9DdL86G+Bv+UuaWLzpiwn5oK/qzhBe3pFCp0fa0FtK131BDs
 jdfn5HSu2oM2R3e5onPSvZ08kq7nzfa/w7J4/xCIUc6mLCdLJgkw7UqkYEUv1iFFSjz8Hg=
X-Talos-CUID: 9a23:LqQY9Wwk6pEKX4iz866mBgU1QP14fUHl5U6BOnbkLXxjSrOTVEafrfY=
X-Talos-MUID: 9a23:sfUauwXMTB9aCLjq/CGzmi0/Ft5a2omvEHsUjpEsvMOkMgUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="71347880"
Received: from mail-mtaka26.fraunhofer.de ([153.96.1.26])
  by mail-edgeDD24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:42:55 +0200
IronPort-SDR: 6538e31d_h5/+007enWyWsNC8CU0HhGNvwg8wFuCTNOZWq59JBSXCaLB
 VwG/AtCm+DOjrNxnIb9gBXASmQj3fJA6O1ZFOsQ==
X-IPAS-Result: =?us-ascii?q?A0BYAABB4jhl/3+zYZlaHQEBAQEJARIBBQUBQAkcgRYIA?=
 =?us-ascii?q?QsBgWZSB3NYgQWEUoNNAQGETl+GQYIhOwGcGIEsgSUDVg8BAwEBAQEBBwEBO?=
 =?us-ascii?q?wkEAQGFBocZAic0CQ4BAgEBAgEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBBgSBC?=
 =?us-ascii?q?hOFaA2GTxYRDwENAQEUIwE0AiYCNAckAQ0FIoJcAYIqAzECAQEQBqUZAYFAA?=
 =?us-ascii?q?osigTKBAYIJAQEGBASwFxiBIIEeAwYJAYEQLgGDW4QuAYQ0gR2HBIFKgzOIH?=
 =?us-ascii?q?oJog3WFPAcygiKDLymLfoEBR1oWGwMHA1kqECsHBC0iBgkWLSUGUQQXFiQJE?=
 =?us-ascii?q?xI+BIM4CoEDPw8OEYJCIgIHNjYZS4JbCRUMNQRJdhAqBBQXgRFuBRoVHjcRE?=
 =?us-ascii?q?hcNAwh2HQIRIzwDBQMENAoVDQshBVcDRAZKCwMCGgUDAwSBNgUNHgIQLScDA?=
 =?us-ascii?q?xlNAhAUAzsDAwYDCzEDMFdHDFkDbB8WBBwJPAsEDB8CGx4NMgMJAwcFLB1AA?=
 =?us-ascii?q?wsYDUgRLDUGDhtEAXMHnGBtgk0ZBz1RASsESQNfIgkjLxySTy4MgwkBrnkHg?=
 =?us-ascii?q?jGBXowBlQgaM5crkk8umA4gjUWUeYVKAgQCBAUCDgEBBoFjPIFZMz5PgmdPA?=
 =?us-ascii?q?xkPjiA4g0CFFIpnQTMCATgCBwEKAQEDCYI5hBSEfQEB?=
IronPort-PHdr: A9a23:ITK+hhFT8I1cJG2jVMoxaZ1Gf29NhN3EVzX9l7I53usdOq325Y/re
 Vff7K8w0gyBVtDB5vZNm+fa9LrtXWUQ7JrS1RJKfMlCTRYYj8URkQE6RsmDDEzwNvnxaCImW
 s9FUQwt5CSgPExYE9r5fQeXrGe78DgSHRvyL09yIOH0EZTVlMO5y6W5/JiABmcAhG+Te7R3f
 jm/sQiDjdQcg4ZpNvQUxwDSq3RFPsV6l0hvI06emQq52tao8cxG0gF9/sws7dVBVqOoT+Edd
 vl1HD8mOmY66YjQuB/PQBGmylAcX24VwX8qSwLFuTXmdM7/4hu5vfBjhAnZL8KuCuBofzGlw
 I1ncT7vtHgbDzok80SMhP1MsfoO83fD7xYq5dTNbtqqGqFTY5LiYYkBdVVwXd1bSSpvAr2ta
 9BeCshfPNRWrYnnrEQ88Tq0HFLrDdjoyzt6g1Lwgr8d67wDNjvHgCIMDpEtiC+NrM22Da02X
 Oubl4bnwxXxYegGxhf+uZHZIjItr6GOZr8pfevQmHssPinMpWXNjpfCYRqez/QTlGuKt9VLV
 r6C1DIluix+gDmyw9Y+iobtuYMK2gn8qxxL0aVpH+WmUk0rNI3sAN5RrSacL4xsXoY4Tnp1v
 Dpv0rQdos3TlEkizZ0mw1vad/WkWtLWpBz5XfuXITB2iWgjdL/szxqx8E310uTnTYH0y1dFq
 CNZj8PB/m4AzR3d68WLC7N9806t1CzJ1lX75PtNPEY0kqTWMdgmxLsxnYAUqkPNAmn9n0Ces
 Q==
IronPort-Data: A9a23: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
 HfrXCGY1gh6AJDIVXcB4LrFWZNJNM8=
IronPort-HdrOrdr: A9a23:RLSEO6krXCH30wo76QE0GJCEA9vpDfIo3DAbv31ZSRFFG/Fw8P
 re+sjztCWE7wr5PUtLpTnuAse9qB/nmqKdgrNhX4tKPjOW3FdARbsKheffKlvbak7DH4Zmvp
 uIGJIeNDSfNzhHZJbBjTVRUb4bsby6zJw=
X-Talos-CUID: =?us-ascii?q?9a23=3AkaTPr2u2IZBYPpUuHLyX6scz6IsCbUL6jyrAL3a?=
 =?us-ascii?q?XFGpAZuWcFwS5+Pp7xp8=3D?=
X-Talos-MUID: 9a23:xuXgVwgMG7XjZIR2g6LpgsMpM9tE+6v1Vk4xyJhX4cbVaAppHT2YtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="68486262"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA26.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:42:52 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 25 Oct 2023 11:42:52 +0200
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.168)
 by XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Wed, 25 Oct 2023 11:42:52 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJ2m4lJGd3mUhgIFNJB5Ri4Zn9XuLXk9o8IcUSuuwGiaJdCBxXH/8RclxwOPzvQwla5hVOk/b6Ls08JcmjHat3+0nO6kcYr5rzpRkIdUW54ygL67fLzEgjsvze85m1eLtOCeHrDvegMQkIrBQTPadXOrknzid1Vg/tXzmYf0zaAyUQSF5q8/PdGYQ2hVcWkz9V/noEtHKrJJQAC2orLqCQca5mGLNuOavxJjflz+77Aoy4IhluQRup5Rlnb/2RvLVqESjfo9QvDO4/WCcVTF3+DwO+C237C/RmMMbu76X+lXypHjP34wsRVtxj4t5rVo+00Rgk9FesSEhpdc72PXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtB1f8X+crv4H+zg0/84NmoGBdQIoT7tPlukM3fYTU0=;
 b=BtZRcoALYlpNzOFQ04Gz1vrJvRXvxJRApHVymMp5fcxzj8LYl8UbGaxqGrY6hVevQllyJUVA8/Ismi15Mjt9BzbVfyg8jKx2A89pQt4hoqhArGMORBl01sz18iWhjbsjh/N7+mbFhfYAWhIOnhlyJOhe9Lv04ZTAQfVO9wn/VQ4vgdKlWmYJ7lvGLxw7gnr6YJvumfXtnHFoPvQftJlgRd83YAkZNbjHw2mEKkNRI4aNvfEPWC413vEM+UbW7IsXJ7UZORanwunpze3z1zBptHjL14JCfKCOSUK/HWJS6f7X91Te5j42/QOrRuSemLQYLvD6qR4b4xdNQeMc5BUWpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtB1f8X+crv4H+zg0/84NmoGBdQIoT7tPlukM3fYTU0=;
 b=N2qf3WF3EuYWt2sXWYksbvnFhVyl39mJ6iZfjhrcwZ4Ibq3/aSoilZmEn7zOP0JORi4FDy+KP31hp+QbLecF3GGfHZfs8wHk9qy8Jdf8jSe1dIi9ZkABaCX5OsO6AcqxvOky0WCk4E74jyEgJiumyzhgLWiwx1P6QZyK4RPvrk8=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by BEZP281MB1814.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:5a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 09:42:51 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 09:42:51 +0000
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
Subject: [RESEND RFC PATCH v2 00/14] device_cgroup: guard mknod for non-initial user namespace
Date: Wed, 25 Oct 2023 11:42:10 +0200
Message-Id: <20231025094224.72858-1-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.30.2
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
X-MS-Office365-Filtering-Correlation-Id: cbf2ee99-853f-4346-4d3a-08dbd53ec166
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M71rx3AkW9OlJvs6OyvOcAZPOUsZkapbSNEGZbaivp/XBNOWyhzr26wYm7m8SZrROVn6opiKZl/ttiPnEKDrm7KeEq4Asbpkg/Sk9rQU2MNqZEuy8KUexOzh6yoiKrhKI6vKCLA54siKrVD0bOLvhm9x3JHosXDFGFuI4kdiRgRTpWVFOr2UtPr8g1QkgqMfAwAD/T694ot9SaORWTHn6kmPvDb8XuEYN9+fpVjVk5ZmhB0JIUy447pVCKAlLOhle2UQ+gjcq/7kSj2G/rERrzG7Y0NgAU+cYtRCFsOubpV9EBo0/Hvnc6LhJxeCGJWnCxz883NM0vqKhPmrwyMlrTMit8O2ugGbY79LvJgZ+JXopWTO5h2V07RoLtNGlbpPOn4Q2YZopboBoWiyacmqrjapjGG2LRIOi+/6scBaEg0WQqoV6MaGQe4J+Zu77T/TURM5tLhnrcFUQZykHGJGmurusdwgNF8RNchD72kUCqDqrldd3zwiSpK0dD3YfSBE8bzvhBDc4fVSbybPvWpOFF5oV+IVWP9RlCQ2mIwZYu0HIiEc1V+M8nqnqvfMs/Yg/BiS1wwHV9R0qJBmobo56SY8pz79XUa3k9RaEmzjB9Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(110136005)(38100700002)(41300700001)(2906002)(7416002)(86362001)(5660300002)(8676002)(8936002)(4326008)(6666004)(6506007)(478600001)(107886003)(54906003)(1076003)(82960400001)(66476007)(66946007)(316002)(66556008)(2616005)(966005)(83380400001)(6512007)(6486002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjAwWEpwWkJLZlhHZWZFbUVnSkNoTWtSdE9lYU4wS2d0VTFDTitORGRiQVFz?=
 =?utf-8?B?RXYxcnUwMjUrSUxKUWlZL3RwbEVPclZwdWg4QTUyVEJqTjdpVUN3OG1NQkV2?=
 =?utf-8?B?TGRGNnhwNUNTUmNoeUlDcDdwaHhzRlhMVVc3T2k0SVFhWDBIR3VkUk9sNlVM?=
 =?utf-8?B?QjV0NzZKU1BhOUNIYzdJSWVzQVNHV2cwc0VmMzJLU2NNYjhkMStnYTA1a0tv?=
 =?utf-8?B?TFIxMDBGTWV2a2c0MTVzSHgxK3NuM1pKQWlqZVhXdStzcjc1aTczb1lLbC9l?=
 =?utf-8?B?NkFuRUVzRWU2MmZaTE4yQktwdXdSSGRXNVpOY0RtQXQyKzFsNlJHYThCWlBS?=
 =?utf-8?B?blFyZWRYdjlFSHp6L242RGZmd0traXVpWDQzeVpsMUE1MzI0cU9TSnB0Ym4v?=
 =?utf-8?B?amE2elpESzNDbnZ4djNrazE0a1hLSXpaWWUySVBJb0lWcUdvK0dsSmdidjJs?=
 =?utf-8?B?b1YzOVhkdG9Mck1sZHlXeko0NDg3emkyVmdtaVRqWWJrMFFORi9KK1hBSTJZ?=
 =?utf-8?B?QUFQbi9menVSUzJzeUJuVXIvUkhSckpvY1djWXFXVTJua1JtV0dqNzlUaklP?=
 =?utf-8?B?dkdIT09pa3M1dTRleExqZUl5S3R4ZmpxUE5UMUFJOHBoWndCS09xSW9zOHpm?=
 =?utf-8?B?UHZ2NTl5VXNTQnNzZ3NRUzhPNVZFMExaMkdHRHAzdTJxMXFDcUhUY1FuOEdu?=
 =?utf-8?B?dWt0RTV3MWVMUk01YVhFamV5VW41QkQ4N00yZ3ExMmZmUEVkYUduWWdjNEta?=
 =?utf-8?B?cWdGT0RrZ1RiZDdiMnZtdGtaTEZWQVV1QmpBSlpGUzVCSXdpbFFLRFhDbHNK?=
 =?utf-8?B?UXhEeTNkTlFLUWF3aGRwUnNqMWZTWEwzUStJQ2dEbmMwSTJmd2FORW0wdWRk?=
 =?utf-8?B?VmwxSUZHVFAxWVV1NTN4dmdhVDVENEtPbDhEUmZDTEFlWXkwTHp6NUhabG5F?=
 =?utf-8?B?UkFpd2QzOXR2ZlplMXhzMTlUS0psbERTME9OVGdPcGl2eFFPd09HdG1uZnds?=
 =?utf-8?B?Z05zc2JOK2RwTzlUZGFPblV5RHBkTFRnU2RHQ2FySDNScmN5UUU5dTRXcDlG?=
 =?utf-8?B?VWo3ZmRUVzlQZFJ1UlQraC9RQzFpTW9yVW5kbDdvTnFrN1h6NStLMUJGZ2My?=
 =?utf-8?B?SWdTd0huUWVySUxFRFJsaDBMTXg2ZkN3ODR6aHdPNjVIOW9PeFN0QmtRNnRT?=
 =?utf-8?B?T2g0TTVaU2dZM0hBeFN2Mms2MHpwYXh2elF2MGMwdVNYVnkvTXRaM2JieUY1?=
 =?utf-8?B?RUlqY1pwQjJKN3hBbnBiU3ViWFFCRFpiZmVIekpHeUFjUHh5TkR6b0ZUckw3?=
 =?utf-8?B?cGtRbEM4UkN5VlhOb3NKMnR5UHVLWGxNd1p0cnFTZ0t1eVNLZy9LZ1RwdDJ2?=
 =?utf-8?B?OU9WUDY2czBnd0RyQzBqZ0lUeU83ZUJhT3pjYnY4VGhmMmxralpvTS8vMTIx?=
 =?utf-8?B?NVZDZVYvaDN4aDFhWFp6V1JqWlkyY2VZVkVjZ0dHM2JWVEZjQnpaRFZrV25R?=
 =?utf-8?B?eVNsWS9FOXk3d1Iwem5yUUo4NDdzZ01DOENhQjhVYmdLa2wxWnRlYW5CQWJr?=
 =?utf-8?B?RFVNRlcyT0g3Qk43OVZvVTMyYzNNeFNDaXZGb2Q2SzcrWWE0NkxCeEJFT1Rr?=
 =?utf-8?B?YkhiSm9oTjUvdXlzbzNudXhHSGMvWWQ2WWZNazVFeDdvdjNIODRVaG9FVys5?=
 =?utf-8?B?eGRDRDl4ZGdJN3E2QWI3MkpYOWRkalFWTkFiRUJJRDJkeFYrbmFXdmpIVTdw?=
 =?utf-8?B?TVB6em9CemJjSWF2NERIaWprMXV0WTlvbE5IMnNoQ2VkbGtIK3RhRm4rbmY4?=
 =?utf-8?B?RFh4MXltSU9KU2ZWV21lYVJCL2lscGVUVDV5MTRxMEsxUmYvRWJtUWxlVitU?=
 =?utf-8?B?TEtKYlppTTdKUFVJU2YwKzc3SmpQanhKeFNnVUZ2NlhMVjhHSmh1NVFJaFJE?=
 =?utf-8?B?dHgyR3VkM2xhTzNkL0N6RTF1cXcxWGlZWGlWenpva3gwQkYxdlVEQ0xTZVFU?=
 =?utf-8?B?eXNnblB1a3JORWUrcXFIK2JJaUtkNnQzRjlEU1NPam5Bb2JjRlVKZzFTb3lC?=
 =?utf-8?B?QzduU1huUWx2b0E4Ymg0N05GazhvY3k3ZXZkc1BVaU4wQ0RpdHp4K1AwYkkv?=
 =?utf-8?B?RXdKWlJ0cGJ4b1FWeWg3UXozeVUzMUF5Qk5xWDFuUXZKNEN0N3V1eTNZcHRv?=
 =?utf-8?B?WUNaK1Q2MWcvaElHZUR3aDFoZ2tiMVkycTZOaGVHVGdMTlV2elg0dG45Rklk?=
 =?utf-8?Q?xiAKigBmBVBQEtDyXUU1JIpy54LUCe0MFb+giD/qbM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf2ee99-853f-4346-4d3a-08dbd53ec166
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:42:51.4030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgRQ51fTszwwskzABsKs90519CPxfv+r4HUWmtbdjWp3uP5H3u1i96NUyC/W/WnBsj8anuveFMvMlWSzF8Xh6Rh91KQACIVcURLgRmrSVBVz8Cmv5O25tfObg7fMz3lI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB1814
X-OriginatorOrg: aisec.fraunhofer.de

Introduce the flag BPF_DEVCG_ACC_MKNOD_UNS for bpf programs of type
BPF_PROG_TYPE_CGROUP_DEVICE which allows to guard access to mknod
in non-initial user namespaces.

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

To circumvent this limitation, allow mknod() by checking CAP_MKNOD
in the userns by implementing the security_inode_mknod_nscap(). The
hook implementation checks if the corresponding permission flag
BPF_DEVCG_ACC_MKNOD_UNS is set for the device in the bpf program.
To avoid to create unusable inodes in user space the hook also
checks SB_I_NODEV on the corresponding super block.

Further, the security_sb_alloc_userns() hook is implemented using
cgroup_bpf_current_enabled() to allow usage of device nodes on super
blocks mounted by a guarded task.

Patch 1 to 3 rework the current devcgroup_inode hooks as an LSM

Patch 4 to 8 rework explicit calls to devcgroup_check_permission
also as LSM hooks and finalize the conversion of the device_cgroup
subsystem to a LSM.

Patch 9 and 10 introduce new generic security hooks to be used
for the actual mknod device guard implementation.

Patch 11 wires up the security hooks in the vfs

Patch 12 and 13 provide helper functions in the bpf cgroup
subsystem.

Patch 14 finally implement the LSM hooks to grand access

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
Changes in v2:
- Integrate this as LSM (Christian, Paul)
- Switched to a device cgroup specific flag instead of a generic
  bpf program flag (Christian)
- do not ignore SB_I_NODEV in fs/namei.c but use LSM hook in
  sb_alloc_super in fs/super.c
- Link to v1: https://lore.kernel.org/r/20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de

Michael Weiß (14):
  device_cgroup: Implement devcgroup hooks as lsm security hooks
  vfs: Remove explicit devcgroup_inode calls
  device_cgroup: Remove explicit devcgroup_inode hooks
  lsm: Add security_dev_permission() hook
  device_cgroup: Implement dev_permission() hook
  block: Switch from devcgroup_check_permission to security hook
  drm/amdkfd: Switch from devcgroup_check_permission to security hook
  device_cgroup: Hide devcgroup functionality completely in lsm
  lsm: Add security_inode_mknod_nscap() hook
  lsm: Add security_sb_alloc_userns() hook
  vfs: Wire up security hooks for lsm-based device guard in userns
  bpf: Add flag BPF_DEVCG_ACC_MKNOD_UNS for device access
  bpf: cgroup: Introduce helper cgroup_bpf_current_enabled()
  device_cgroup: Allow mknod in non-initial userns if guarded

 block/bdev.c                                 |   9 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |   7 +-
 fs/namei.c                                   |  24 ++--
 fs/super.c                                   |   6 +-
 include/linux/bpf-cgroup.h                   |   2 +
 include/linux/device_cgroup.h                |  67 -----------
 include/linux/lsm_hook_defs.h                |   4 +
 include/linux/security.h                     |  18 +++
 include/uapi/linux/bpf.h                     |   1 +
 init/Kconfig                                 |   4 +
 kernel/bpf/cgroup.c                          |  14 +++
 security/Kconfig                             |   1 +
 security/Makefile                            |   2 +-
 security/device_cgroup/Kconfig               |   7 ++
 security/device_cgroup/Makefile              |   4 +
 security/{ => device_cgroup}/device_cgroup.c |   3 +-
 security/device_cgroup/device_cgroup.h       |  20 ++++
 security/device_cgroup/lsm.c                 | 114 +++++++++++++++++++
 security/security.c                          |  75 ++++++++++++
 19 files changed, 294 insertions(+), 88 deletions(-)
 delete mode 100644 include/linux/device_cgroup.h
 create mode 100644 security/device_cgroup/Kconfig
 create mode 100644 security/device_cgroup/Makefile
 rename security/{ => device_cgroup}/device_cgroup.c (99%)
 create mode 100644 security/device_cgroup/device_cgroup.h
 create mode 100644 security/device_cgroup/lsm.c


base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
-- 
2.30.2


