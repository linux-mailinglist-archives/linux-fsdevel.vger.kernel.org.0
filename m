Return-Path: <linux-fsdevel+bounces-1148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B551C7D674A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 11:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88461C20DF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 09:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5B126E2A;
	Wed, 25 Oct 2023 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="HZhUoJq6";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="OXA40DVp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1F2374C;
	Wed, 25 Oct 2023 09:44:18 +0000 (UTC)
Received: from mail-edgeka27.fraunhofer.de (mail-edgeka27.fraunhofer.de [IPv6:2a03:db80:4420:b000::25:27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A3FDC;
	Wed, 25 Oct 2023 02:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1698227056; x=1729763056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=qzVt3VB4NoMV3791Rxk9znEgZCQUazCxH50RMqNmfz8=;
  b=HZhUoJq6CSA/ACbbNvk3a8Gjx86om/EXS/O32Fnij5WiJxiVCH/5b+nl
   T+fHNI111YqWyCCkFwUfrn/lVClZG4eANAY2PlwBayVysI+L4aXnoMo4S
   Wi4MuSuu3Dj+rMsIFgBRu3ISh+SlSo+/doiclMKb6ovp4N+TIEZ2+/nKR
   GqgWEzjQ5sMQ/GXPS+lX7rjbshmz/On+dS7kP8gxL27Gz5thrfNVVYIx5
   sKGtnJm+MrTykq+LzCpx3L/kRK+HD7MmpZAPCAyVXN+xiG3CjU7LagiSF
   O/R3mimbaB8GNbN2Zg3Ctvc8rmGtDrjvbus7siSOQHAuaiFolDydL4eH0
   w==;
X-CSE-ConnectionGUID: Ci1Zmj02Q5+mZ5bmad/g6g==
X-CSE-MsgGUID: 4RqfGTtARkG5zBguGsmWnA==
Authentication-Results: mail-edgeka27.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2E2AABB4jhl/xoBYJlaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YI4gleEU4gdiUGcKiqBLIElA1YPAQEBAQEBAQEBBwEBRAQBAQMEhH8ChxonN?=
 =?us-ascii?q?AkOAQIBAwEBAQEDAgMBAQEBAQEBAgEBBgEBAQEBAQYGAoEZhS85DYQAgR4BA?=
 =?us-ascii?q?QEBAQEBAQEBAQEdAjVUAgEDIwQLAQ0BATcBDyUCJgICMiUGAQ0Fgn6CKwMxs?=
 =?us-ascii?q?hh/M4EBggkBAQawHxiBIIEeCQkBgRAuAYNbhC4BhDSBHYQ1gk+BSoJEb4RYg?=
 =?us-ascii?q?0aCaIN1hTwHMoIigy8pi36BAUdaFhsDBwNZKhArBwQtIgYJFi0lBlEEFxYkC?=
 =?us-ascii?q?RMSPgSBZ4FRCoEDPw8OEYJCIgIHNjYZS4JbCRUMNQRJdhAqBBQXgRFuBRoVH?=
 =?us-ascii?q?jcREgUSDQMIdh0CESM8AwUDBDQKFQ0LIQVXA0QGSgsDAhoFAwMEgTYFDR4CE?=
 =?us-ascii?q?C0nAwMZTQIQFAM7AwMGAwsxAzBXRwxZA2wfGhwJPA8MHwIbHg0yAwkDBwUsH?=
 =?us-ascii?q?UADCxgNSBEsNQYOG0QBcwedTYJNGQeBDnliIlsckk+DQwGueQeCMYFeoQkaB?=
 =?us-ascii?q?C+XK5JPLpgOIKgIAgQCBAUCDgiBY4IWMz5PgmdSGQ+OIAwWFoNAj3t0AjkCB?=
 =?us-ascii?q?wEKAQEDCYI5hBSEfgEB?=
IronPort-PHdr: A9a23:z5bbSR8KWx2Npf9uWXO9ngc9DxPPxp3qa1dGopNykalHN7+j9s6/Y
 h+X7qB3gVvATYjXrOhJj+PGvqyzPA5I7cOPqnkfdpxLWRIfz8IQmg0rGsmeDkPnavXtan9yB
 5FZWVto9G28KxIQFtz3elvSpXO/93sVHBD+PhByPeP7BsvZiMHksoL6+8j9eQJN1ha0fb4gF
 wi8rwjaqpszjJB5I6k8jzrl8FBPffhbw38tGUOLkkTZx+KduaBu6T9RvPRzx4tlauDXb684R
 LpXAXEdPmY56dfCmTLDQACMtR5+Gm8WxzZPKQHByC7eZr2vnzu9jsF7n3G+EvL4f/cbfAyi7
 IZ0WjXMrD8cGn0pwECC2akSxKgOhyKI+0RT/ZaJXIKpNb1FQoT8TdZCXXptcfRcVClPDpOZN
 ZoCU9oQesgDsq2trncNpgSxKgb3JszvzwVioy/p87wR1tolGEbe3zc4DvkKunfSncWuZb8vQ
 /qb/bfzzB7aaNh72mblz9nvdQgz/fSBZI9OUOOK6kwEST3Zggm2p4fdeBWLj+oJimi23rs4b
 ser0UQ3tTB1hCmUls4Pm472pbs6lUnG3g9Sm6gEcI7wWAt6e9miCJxKq2SAOpBrRt93W2hzo
 3VSItwuvJe6eG0HxJsqxBeFNLqJaYGV5BLkWuuLZzt11zppe7O60g676lPoivb9Wc+9zEtQo
 2Jbn8PNuHEA212b6sWORvZnuEb08TiV3h3V6uZKLFpykqzeKpU7xaU3mIZVukPGdhI=
X-Talos-CUID: 9a23:CBfdiWwn537T4fnfRamqBgU/G5kXd3+Flk6NYEqKVGxsQbHSRgGfrfY=
X-Talos-MUID: 9a23:fmtPbghqjBmjjkJiBICC+MMpaP1x7YuSFGk3krpbqeOLKANrPgibpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="1597282"
Received: from mail-mtaka26.fraunhofer.de ([153.96.1.26])
  by mail-edgeka27.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:11 +0200
IronPort-SDR: 6538e32e_j66fqEKm0PJE88y0HQlU39rkjzJ4/UyWhB1Plu45Tg+nE2z
 xSTxrN96tLjfq0JZlBu8iwr4WcW38MdujSt5xJg==
X-IPAS-Result: =?us-ascii?q?A0BZAABB4jhl/3+zYZlaHQEBAQEJARIBBQUBQAkcgRYIA?=
 =?us-ascii?q?QsBgWZSB4FLgQWEUoNNAQGETl+GQYIhOwGcGIEsgSUDVg8BAwEBAQEBBwEBR?=
 =?us-ascii?q?AQBAYUGAocXAic0CQ4BAgEBAgEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBBgSBC?=
 =?us-ascii?q?hOFaA2GTQIBAxIRBAsBDQEBFCMBDyUCJgICMgceBgENBSKCXIIrAzECAQGlL?=
 =?us-ascii?q?wGBQAKLIn8zgQGCCQEBBgQEsBcYgSCBHgkJAYEQLgGDW4QuAYQ0gR2ENYJPg?=
 =?us-ascii?q?UqCRG+IHoJog3WFPAcygiKDLymLfoEBR1oWGwMHA1kqECsHBC0iBgkWLSUGU?=
 =?us-ascii?q?QQXFiQJExI+BIFngVEKgQM/Dw4RgkIiAgc2NhlLglsJFQw1BEl2ECoEFBeBE?=
 =?us-ascii?q?W4FGhUeNxESBRINAwh2HQIRIzwDBQMENAoVDQshBVcDRAZKCwMCGgUDAwSBN?=
 =?us-ascii?q?gUNHgIQLScDAxlNAhAUAzsDAwYDCzEDMFdHDFkDbB8WBBwJPA8MHwIbHg0yA?=
 =?us-ascii?q?wkDBwUsHUADCxgNSBEsNQYOG0QBcwedTYJNGQeBDnliIlsckk+DQwGueQeCM?=
 =?us-ascii?q?YFeoQkaBC+XK5JPLpgOIKgIAgQCBAUCDgEBBoFjPIFZMz5PgmdPAxkPjiAMF?=
 =?us-ascii?q?haDQI97QTMCOQIHAQoBAQMJgjmEFIR9AQE?=
IronPort-PHdr: A9a23:jwvf0BcPoGpij1yC0tdIxGHZlGM+/N/LVj580XJao6wbK/fr9sH4J
 0Wa/vVk1gKXDs3QvuhJj+PGvqynQ2EE6IaMvCNnEtRAAhEfgNgQnwsuDdTDDkv+LfXwaDc9E
 tgEX1hgrDmgZFNYHMv1e1rI+Di89zcPHBX4OwdvY+PzH4/ZlcOs0O6uvpbUZlYt5nK9NJ1oK
 xDkgQzNu5stnIFgJ60tmD7EuWBBdOkT5E86DlWVgxv6+oKM7YZuoQFxnt9kycNaSqT9efYIC
 JljSRk2OGA84sLm8CLOSweC/FIweWUbmRkbZmqN5hGvcpDbuy/eic5F8ne3LYrOZrZzARCN0
 KlZDzDNsCcEFiEr2kXzktddz7JrgUfywn43ydvzUKjJbNZAZv7hfu8bAlF9eedhUnRZEq+TX
 YYMCuQNLcMCvoShl0pJg0CjIVmlKODk1TBniSTU8q0/6c4EQR7ozSclIdYH92zXl83kH6MYU
 uaE3PKZ1QjRdd1nxwz8w5HPWT0i8OmrDJV3adiNzEQWKj3kpw6zrKe7AS+ZisIDuFDcyfQ5W
 +aWi0MW+llKhzz17Ncyu43vl7lFw3PV8hpa+alqPN+TYmUgT+/xQ9NA8iCAMI1uRdk+Bntlo
 zs+1ugesIWgL0Diqbwizh/bLvmbequhuEylWvyYPDF4g3xoYvSzikX6/Uuhz7jkX9KvmBZRr
 yVDm8XRrH1FyRHJ68aGR/c8tkes0DqCzUbSv8lKO0kpk6rcJZM7hLk2k5sYq0PYGSHq3k7xi
 cer
IronPort-Data: A9a23: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
 W/sDX64i4xMNqf/ZYNy0z7xvZJJNA==
IronPort-HdrOrdr: A9a23:xZH4bK9yVjpisfWi52Zuk+HRdb1zdoMgy1knxilNoENuHfBwxv
 rDoB1E73LJYVYqOU3Jmbi7Sc29qBTnhOJICOgqTMqftWzd1ldAQ7sSi7cKrweQeREWs9Qtrp
 uIEJIOeeEYc2IK9PoSiTPQe71LoKjlzEnrv5al854Ed3AVV0gK1XYfNu/0KDwSeOEQbqBJa6
 Z1haJ81nidkSt9VLX+OpFhN9Kz5OEj2aiWFyLvQHUcmXyzpALtzIS/PwmT3x8YXT8K66wl63
 L5nwvw4bjmm+2nyzfHvlWjpKh+qZ/E8J9uFcaMgs8aJnHHkQCzfrlsXLWEoXQcvPyv0lA3i9
 PByi1Qd/ib00mhM11dnCGdlzUJiF0VmjDfIB6j8DLeSPXCNXgH45Erv/MWTvKW0TtggDhG6t
 M444uojesmMfr+plWP2zGxbWATqqOVmwtXrQdBtQ0pbWK1Us4Q3MsiFQVuYdI9IB4=
X-Talos-CUID: =?us-ascii?q?9a23=3AicDzJGmq7kwBPX/iZjg8t+KpErHXOVPR/EeLJh+?=
 =?us-ascii?q?+MFlKFPqNDlGI84RDveM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AgJA+kgxBFqTCNE1KuTM3Ejj8PMqaqKiTIxg2u4g?=
 =?us-ascii?q?Mh8eZKAZXMTScsR2THqZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="68486320"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA26.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:10 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 25 Oct 2023 11:43:09 +0200
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.169)
 by XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Wed, 25 Oct 2023 11:43:09 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfDRYR/Q5+DZRHCcfiMo2+5flEmg5AOuadpqe4ZJ1psNYgKCTblPG25UL4QIp+cQCEin++Fsc5Y6RV/v7zi/0gTPdcaDnYkw3njSnyU0Pjrdi22ESXWWuS16FteDZv6FlsmeaqIIdgiG+3se4rW+7oOdFsTmyKuZk6CPAbZN3hZVucLRpnl6xsvtOnuT38RjZ7lTNBiwtAN8K2oEqPtXPX28BoX3jNHar3bDIHxmkoHQI0TBtbE2E1bXN+tWCTLn7p3cYRbU4IKr9vB+vpQsp+WePHqOTwngfudFvc4QpYgbYQVmVe/nSKMV2CWi7hwTiwGLqyCkwPwv6WQsTN0bgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoBalLWLPB6Ex/PCn/0LGWfZ/GMPhkIwzBLLpsE+xXI=;
 b=Gj3DQu/b/hzAn5HHX+okmqhIPf522URAnlISz3OJ4MTvbO2H41jA3SB0jYjHlnru9UtXmaZQ2VEVvElRJgM0hPVnlDUtyHLEFLLu+inJx2EzE4sEgDYwKK7OfqoFVjMBYvPaBxVCZpgG3CHcBafvDeD+y9PK6yAa88ju3lAuxwXBlpIbvNDINw5HqkgYBERjHt8x6LnZtpJpmB6sm9js29ztKvizHDepZxbiWGypSDZQB6OEbmmNd9Ozaxzkx3MKLu6B8OuR2/AfT0vtm9eKPSamz9z2OEnWte6yVgWpPCbSN75LiXMaBrl2RgRZBdQtPYCb67q93Os7/OYTjAgrXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoBalLWLPB6Ex/PCn/0LGWfZ/GMPhkIwzBLLpsE+xXI=;
 b=OXA40DVp5TkTi/STOIXm0pxDGZekmfdxM2ye4Xy/F3uL8aDkcwgGg3JGhmRBM8wFyCmVla/pkSpyClbknYx39pUzrFYvSiCqoCEk9pO9Oopz4meQUVIA3KmC6Vtd4NfcP/Nv1flQhEY90SMl2BxvYlNyS8aKyoWKQG7qjCBC3FY=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by BE0P281MB0116.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 09:43:08 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 09:43:08 +0000
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
Subject: [RESEND RFC PATCH v2 14/14] device_cgroup: Allow mknod in non-initial userns if guarded
Date: Wed, 25 Oct 2023 11:42:24 +0200
Message-Id: <20231025094224.72858-15-michael.weiss@aisec.fraunhofer.de>
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
X-MS-Office365-Filtering-Correlation-Id: ea45e0e1-34be-418f-00ee-08dbd53ecb86
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xp9vHEDO7YKQGdJBEgpvTdwBY/OZvvOdNSTsjNFJO7Hhn0fKtjuYeJEBjp8/KSbuhPyyxSAVQfoHukT//WsfLBpe/uPYQqs3BL+2aBicE9Vi/43+g8NMzd00WTTbBm0J+ADYuF2WUiz4iMqZSDt02dDEVxFm8YJEM6/WPTGDpqbqn0H5vAIrO/+ltq/D3e/tvcvnT4u3+f6w1lHxxmJPa/O4O4nUw7IBvz8a11ySUMJTGr55qeqiQ2xIvuBzDJbD6gBZySeFJS3cX4rfsF3YdtfSdelXC4AvvITvKweOVPhSdzLuj3EVxesHlTtZhbjRQHBbStM08chUMdqpkuJu/eZKUKtKx0LQOpLtYQ8lNLrzycaLVG31DhSA/ttfgxX6ooCMSvyu2SWsIsLA/YFGeRJysTOCzuMjlLgWfl08sqigubmZnjqlqR4SyFcjDb1zNBsBpeJz1x4dIjuOzDIQCPZ4LBwZhj/upjpJP1L38s7H3KUEmvLsD+gVnLpzDACLDK/8ZEySqQTU82Vzj2yE8SWOSKga4+OB+qIcoFwQF1Fi77JpAKgpFmfuTYqN5R4lwtq+aDaA/p18VzDHqxwTyWl17PZxknH//FNoIKR/WQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66946007)(83380400001)(316002)(38100700002)(6486002)(478600001)(6666004)(54906003)(110136005)(66556008)(66476007)(1076003)(107886003)(52116002)(6506007)(2616005)(6512007)(7416002)(2906002)(86362001)(4326008)(8936002)(82960400001)(8676002)(41300700001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU52cENSbVBpcklvY1VOdVhBSEg1aGxveDEwYTdlUUdabkxsWnZQOGtQVzY0?=
 =?utf-8?B?aDJNZ3ZYTjR3clVjMUR2b3d1RE5JY3U0cThPOGJUakRjajl3V2V5V0hFbUcx?=
 =?utf-8?B?azd1Q01ueGFibUR3M3RzSTI3WC9LRVR4ZFY1RUV0UzJPUnFxZTRTaytvZ25l?=
 =?utf-8?B?eVFlM2p3a09BOUhmeTkvbFpieHNuV2tEQmVEbmIraWgrZ3pkVVllOHpXeUtG?=
 =?utf-8?B?RWg3VXF3Mkl4dVU3L0poLzExL1ozSW9xeXZTaGc2ZVVTdzJOUzliZzFJUndr?=
 =?utf-8?B?SWNqL0IycFZsenpTb01aZTR4UUo3bjcrNUMwNlQ5OExWbjhKUHp6em1BS2V5?=
 =?utf-8?B?SEszNmFPQjhwSVY2U0VDTjMwZ2ZRbUxTb3ZrMStWYy84Z0xmd2FYd3ZQWmRC?=
 =?utf-8?B?NE5WdVJEUXJKUjdOaEV3Q1RjNVVMQk90TGFZZDQwc25hUzlLME1jZlZEdlBj?=
 =?utf-8?B?eGNpKzdhYVozbnc1VWZkNlZ3dHpia3BXTEtEdCtMS3A5ckRkd3ZYMDd5RDVo?=
 =?utf-8?B?KzEvSS96LzRad20xRkczTmRrYjBUV0UxL3IyN3RldVRuQTRKQktlYXJJdmty?=
 =?utf-8?B?d2VnQWZCdEtiVnpIUEJrRlNzSVZDMVN1dWl4OG1oM1BidE13SEVTRGNKVkZG?=
 =?utf-8?B?d0s0blE1dWdzbnY4Njk3NlFsOUhkWCtES2JNdFhoWkJvNitoY2VlMDJNNlgv?=
 =?utf-8?B?TXYwS2IxTkswUDVpSmZBK3JXNVV0cnZCL1d4cGlRakRaMjJhTXBzRE9mQWlz?=
 =?utf-8?B?VUFyeFBOcEJZMXo3MGZRb0xjWFhXa21qa05qT3JsZmF1bXBCa21sbFFRUVBu?=
 =?utf-8?B?ejVtMjByQ2tHOWMvaDB2MVR1K3JBTGpqcXl4ZkhteVA3TkpOWGNmcS9laHcz?=
 =?utf-8?B?dXVqbU9ERHdLOVV6Z1RGbWdhUU1FdG95K1NzblpSYk9WVE9VNE5KdUxLM2Zk?=
 =?utf-8?B?c3VCd01GYzVnN0ZZU2x5S2VXK1VTdDJhQ3l1clZUWjZqelpPZnFaeG4xKzE3?=
 =?utf-8?B?VjZwNzJNZ3dvT2ZmWXZRSzlEWFNYSjlnUDZxd0RrNWFxdVlVdG1Kb1pDQUFS?=
 =?utf-8?B?Lzhld3pidXcxcXdndzhCVE5vcHF5Z292dGlaa0tId3NhcytPWTZmRHFyYnV0?=
 =?utf-8?B?RENSREIzaEUzMnZjNUhZc3AvTk9ib25PdGNhVTNOVTUzMWdMK2Jya3Z6Sm91?=
 =?utf-8?B?ZDFORW9wMnV2b005SlpSRGVaRnJIdXdCVnpTUjRKYldmY0w1VDZ4WlIzdjZS?=
 =?utf-8?B?WFdPSSt3QnJDaDNLS3hTVFpYSGozWElJc2d4bkZBdHZpZThySHpIVWJpQ29Y?=
 =?utf-8?B?Tkd0Wmg4alY5R0tRZUQzZjFNWDQ3VVF1emdkUWcydjVJWGZyN3BHSGtPRHRP?=
 =?utf-8?B?b0NHTkpVc2p5ODNNUFNwdVp6L2hrVzJsWlArYm85V0EyWVc5QXpGL0xIOTdE?=
 =?utf-8?B?VVViOFBPVEFaZno3bkNWTER5WjBSTUpuSGMyUHFLNk1vYldKSmE3SUt1NkhX?=
 =?utf-8?B?MkFVWjRRUjhERXBNL1JPM3NnTDdjZ2kwbE5kSnJNbGpEQkRrd3ozWjN5b040?=
 =?utf-8?B?VXU0NWhiaUNoa1FFYW5zdEpJS3h1Uy80ZWozdjVIOUJpVkRmKytoRGZtamt0?=
 =?utf-8?B?T2hieTFudEdDYXk0Z3I3ZFl1TzF1UUVid21OZDZxQk04cTFueGliRlpoR2pT?=
 =?utf-8?B?dGJ2N1JzNlpTZEJiSjFSaHgxWnNJOEx2R0szUWpyclpUMk1ydFpGNnVMNVgy?=
 =?utf-8?B?ZzV4SEp2SkY1VGJkWWsyRGVYQmR1ckpxQlBKc0pjTXVkTXR2WkhZYjcrU0lt?=
 =?utf-8?B?TjZIc3gvT05kUWt4SGs2YUxEb1c3L2txYm55VXVOY0s5bU8vazFqOEE2eEVV?=
 =?utf-8?B?NDVaVTkreCtxd0UxUWRSTlhYNjZXOXE4ejVTanViaG5vaDhwREY1WWFPWEZW?=
 =?utf-8?B?dERINUZJYldUY2JkVlo2RXVlNTl2YlZBaFpDZm9UaEFBYWY5MDlQM3VNenp3?=
 =?utf-8?B?SnhzM1lTd1lmckROL1FhUitNeHo3dXVkbE83NTREWWpVZ3JzdCtrb1hJV0tM?=
 =?utf-8?B?b0xCZHYzZmh3cXpxUGpkN2tRVGtFSDA5aHYrU2x5YmxqbzdNMjRGY3pnMlRR?=
 =?utf-8?B?cnN6c0NkQzVGUFJaaGMwRGpsanFsejVJMDlKMW12RElHTDlRN3dTZHdOa0Mw?=
 =?utf-8?B?WkN1NG16ekhJZzVmREM5Q2NMNUh3eklUbzJNR2FQaUkvNEtDRU5HLzR3MGpz?=
 =?utf-8?Q?KfUaqrpCrMF316NWrq0tde+GMsYf28bVqY/zbLLiWI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea45e0e1-34be-418f-00ee-08dbd53ecb86
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:43:08.4202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z032ILo5eW7I8M+KBfdtf1e0rMwDPPIOXQExBCaJmEgcIpSqrTqqI8upd6o3CV8zOR56tK3qR9iIL6m+Mtsloeo04bS7dWN+jZSPqUjCIA21sPyuzRUWrTr2Ca/lV8Zw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0116
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

To circumvent this limitation, allow mknod() by checking CAP_MKNOD
in the userns by implementing the security_inode_mknod_nscap(). The
hook implementation checks if the corresponding permission flag
BPF_DEVCG_ACC_MKNOD_UNS is set for the device in the bpf program.
To avoid to create unusable inodes in user space the hook also checks
SB_I_NODEV on the corresponding super block.

Further, the security_sb_alloc_userns() hook is implemented using
cgroup_bpf_current_enabled() to allow usage of device nodes on super
blocks mounted by a guarded task.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 security/device_cgroup/lsm.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/security/device_cgroup/lsm.c b/security/device_cgroup/lsm.c
index a963536d0a15..6bc984d9c9d1 100644
--- a/security/device_cgroup/lsm.c
+++ b/security/device_cgroup/lsm.c
@@ -66,10 +66,37 @@ static int devcg_inode_mknod(struct inode *dir, struct dentry *dentry,
 	return __devcg_inode_mknod(mode, dev, DEVCG_ACC_MKNOD);
 }
 
+#ifdef CONFIG_CGROUP_BPF
+static int devcg_sb_alloc_userns(struct super_block *sb)
+{
+	if (cgroup_bpf_current_enabled(CGROUP_DEVICE))
+		return 0;
+
+	return -EPERM;
+}
+
+static int devcg_inode_mknod_nscap(struct inode *dir, struct dentry *dentry,
+				       umode_t mode, dev_t dev)
+{
+	if (!cgroup_bpf_current_enabled(CGROUP_DEVICE))
+		return -EPERM;
+
+	// avoid to create unusable inodes in user space
+	if (dentry->d_sb->s_iflags & SB_I_NODEV)
+		return -EPERM;
+
+	return __devcg_inode_mknod(mode, dev, BPF_DEVCG_ACC_MKNOD_UNS);
+}
+#endif /* CONFIG_CGROUP_BPF */
+
 static struct security_hook_list devcg_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_permission, devcg_inode_permission),
 	LSM_HOOK_INIT(inode_mknod, devcg_inode_mknod),
 	LSM_HOOK_INIT(dev_permission, devcg_dev_permission),
+#ifdef CONFIG_CGROUP_BPF
+	LSM_HOOK_INIT(sb_alloc_userns, devcg_sb_alloc_userns),
+	LSM_HOOK_INIT(inode_mknod_nscap, devcg_inode_mknod_nscap),
+#endif
 };
 
 static int __init devcgroup_init(void)
-- 
2.30.2


