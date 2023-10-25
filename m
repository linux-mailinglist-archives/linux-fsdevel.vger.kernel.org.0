Return-Path: <linux-fsdevel+bounces-1147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3AD7D6747
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 11:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 774DAB214B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 09:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CDC26E1D;
	Wed, 25 Oct 2023 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="hgqRT+mw";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="jefJQZW6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB1226E0C;
	Wed, 25 Oct 2023 09:44:14 +0000 (UTC)
Received: from mail-edgeka27.fraunhofer.de (mail-edgeka27.fraunhofer.de [IPv6:2a03:db80:4420:b000::25:27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61EC9D;
	Wed, 25 Oct 2023 02:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1698227052; x=1729763052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=oxWDGcnVMwXFlfg3W7IKT59Jzi+dyHx6V1yuIAZISXo=;
  b=hgqRT+mwQhxyaA+qw67e5IGLuRJAtdBXd5i4aItZYcgHCd+2g2gPu3e5
   Z6rNtYA+5jxP39y9WoJ50S4cAXPOSNrAWt7PQAA5skoDGr9q2Ihe3eq2a
   kViIccFitbxFzStCZnByI2fB4c+uGmllltzO7t8obFM34inAC8OptSb4l
   1B+9nKwyAheCGfoKzMzxTHYjZ5bLElkFLJj8zEZTS5vhqYw7vcfo6TBrA
   dsEPdimLjZjZdx5MQtYmv4XHLbI9MRS1AzxDFcapIAINbztx87yPZzpCY
   I3BGoJv0u/s2sljlQR+X/BuSDNBScjN06CldltTAGoyOsGEc/rprnBbM/
   w==;
X-CSE-ConnectionGUID: WZHM/xG6QeWg+jJ8GvC5uw==
X-CSE-MsgGUID: eDYbp71HQcCRAwDxhgYgxA==
Authentication-Results: mail-edgeka27.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2E2AABB4jhl/xoBYJlaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YI4gleEU4gdpWsqgSwUgREDVg8BAQEBAQEBAQEHAQFEBAEBAwSEdQoChxonN?=
 =?us-ascii?q?AkOAQIBAwEBAQEDAgMBAQEBAQEBAgEBBgEBAQEBAQYGAoEZhS85DYQAgR4BA?=
 =?us-ascii?q?QEBAQEBAQEBAQEdAjVUAgEDIw8BDQEBNwEPJQImAgIyJQYBDQWCfoIrAzGyG?=
 =?us-ascii?q?IEygQGCCQEBBrAfGIEggR4JCQGBEC4Bg1uELgGENIEdhDWCT4FKgQaBPm+EK?=
 =?us-ascii?q?S+DRoJog3WFPAcygiKDLymLfoEBR1oWGwMHA1kqECsHBC0iBgkWLSUGUQQXF?=
 =?us-ascii?q?iQJExI+BIFngVEKgQM/Dw4RgkIiAgc2NhlLglsJFQw1BDUUdhAqBBQXgRFuB?=
 =?us-ascii?q?RoVHjcREhcNAwh2HQIRIzwDBQMENAoVDQshBVcDRAZKCwMCGgUDAwSBNgUNH?=
 =?us-ascii?q?gIQLScDAxlNAhAUAzsDAwYDCzEDMFdHDFkDbB8aHAk8DwwfAhseDTIDCQMHB?=
 =?us-ascii?q?SwdQAMLGA1IESw1Bg4bRAFzB51Ngm2BD4JXHpYQAa55B4IxgV6hCRozlyuST?=
 =?us-ascii?q?y6YDiCiPoVKAgQCBAUCDgiBY4IWMz5PgmdSGQ+OIDiDQI97dAI5AgcBCgEBA?=
 =?us-ascii?q?wmCOYkSAQE?=
IronPort-PHdr: A9a23:uecSFBdbpU/jXvmQ7rrk1DJFlGM+49/LVj580XJao6wbK/fr9sH4J
 0Wa/vVk1gKXDs3QvuhJj+PGvqynQ2EE6IaMvCNnEtRAAhEfgNgQnwsuDdTDDkv+LfXwaDc9E
 tgEX1hgrDmgZFNYHMv1e1rI+Di89zcPHBX4OwdvY+PzH4/ZlcOs0O6uvpbUZlYt5nK9NJ1oK
 xDkgQzNu5stnIFgJ60tmD7EuWBBdOkT5E86DlWVgxv6+oKM7YZuoQFxnt9kycNaSqT9efYIC
 JljSRk2OGA84sLm8CLOSweC/FIweWUbmRkbZmqN5hGvbIj+9RqimedF+ia1Id34Rq0zW2ij3
 YRvTibJqHY3PWcT8Tzbr/Z7grxE/Efywn43ydvWbY+3DchBILjAcvczQltcePRdRQUcA7GdV
 ocENvceEssI98re+mot9EPmD1WLHOi+6WJkg27kz/0K2OV6DSXsgTYhO/YXsUj0tN/VbIcUV
 +uelqTK4BaAbtJHwRDS0tXJakgNsdzdYptUKteM11kRSh+dkHOVmJLXbjOZ+fYdmW+lvro4b
 P6UonMekjNjiAqo6egW27PMuZgx51TvrCFV3IosfP+JUGcqYsXxQ9NA8iCAMI1uRdk+Bntlo
 zs+1ugesIWgL0Diqbwizh/bLvGLfIWL60i8EuiLKCp+hHVrdaj5ixvhuUSjy+ipTsCvyx4Kt
 StKlNDQq2oAnwLe8MmJS/Zxvw+h1D+D2hqV67RsL1o9iKzbLJAs2Pg3kJ8Sul7EBSj4hAP9i
 6r+Sw==
X-Talos-CUID: =?us-ascii?q?9a23=3AbJKUxGt+N9rr676lHSnkJBbq6IsaQF34i2f/fXa?=
 =?us-ascii?q?1NmkqSp/FZkG7pb57xp8=3D?=
X-Talos-MUID: 9a23:n06HvwRO/ILW5gDsRXThqABoLJgxw52lI3okjrkWu8a1OjxZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="1597276"
Received: from mail-mtaka26.fraunhofer.de ([153.96.1.26])
  by mail-edgeka27.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:08 +0200
IronPort-SDR: 6538e32b_8LqzoNYC0Pmo74MEZcaqQl9pyx4ENdrFiwt7t/1q/dtkCxh
 jl8UKPABgPl54arDzuUoGNz11WXyKfz5eZG+y3g==
X-IPAS-Result: =?us-ascii?q?A0BZAABB4jhl/3+zYZlaHQEBAQEJARIBBQUBQAkcgRYIA?=
 =?us-ascii?q?QsBgWZSB4FLgQWEUoNNAQGETl+GQYJcAZwYgSwUgREDVg8BAwEBAQEBBwEBR?=
 =?us-ascii?q?AQBAYR8CgKHFwInNAkOAQIBAQIBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQYEg?=
 =?us-ascii?q?QoThWgNhk0CAQMSEQ8BDQEBFCMBDyUCJgICMgceBgENBSKCXIIrAzECAQGlL?=
 =?us-ascii?q?wGBQAKLIoEygQGCCQEBBgQEsBcYgSCBHgkJAYEQLgGDW4QuAYQ0gR2ENYJPg?=
 =?us-ascii?q?UqBBoE+b4Qpg3WCaIN1hTwHMoIigy8pi36BAUdaFhsDBwNZKhArBwQtIgYJF?=
 =?us-ascii?q?i0lBlEEFxYkCRMSPgSBZ4FRCoEDPw8OEYJCIgIHNjYZS4JbCRUMNQQ1FHYQK?=
 =?us-ascii?q?gQUF4ERbgUaFR43ERIXDQMIdh0CESM8AwUDBDQKFQ0LIQVXA0QGSgsDAhoFA?=
 =?us-ascii?q?wMEgTYFDR4CEC0nAwMZTQIQFAM7AwMGAwsxAzBXRwxZA2wfFgQcCTwPDB8CG?=
 =?us-ascii?q?x4NMgMJAwcFLB1AAwsYDUgRLDUGDhtEAXMHnU2CbYEPglcelhABrnkHgjGBX?=
 =?us-ascii?q?qEJGjOXK5JPLpgOIKI+hUoCBAIEBQIOAQEGgWM8gVkzPk+CZ08DGQ+OIDiDQ?=
 =?us-ascii?q?I97QTMCOQIHAQoBAQMJgjmJEQEB?=
IronPort-PHdr: A9a23:X5LsFxNxlPUN3uk3KMEl6nZKDBdPi9zP1nM99M9+2PpHJ7649tH5P
 EWFuKs+xFScR4jf4uJJh63MvqTpSWEMsvPj+HxXfoZFShkFjssbhUonBsuEAlf8N/nkc2oxG
 8ERHEQw5Hy/PENJH9ykIlPIq2C07TkcFw+6MgxwJ+/vHZXVgdjy3Oe3qPixKwUdqiC6ZOFeJ
 Qm7/z7MvMsbipcwD6sq0RLGrz5pV7Z9wmV0KFSP2irt/sri2b9G3mFutug69slGA5W/Wp99Y
 KxTDD0gPG1w38DtuRTZZCek5nYXUTZz8FJCA1338x69b8/evxPYucVhyCeRIMr0EbEGejCk1
 oZLGS/i0Q0GajIcymrZlNMs2fE+wlqr8h5yzaztUr7LL+dxWoraTM48d2ZTd5tQZQ14DoiFc
 pQgIrpZfsUFnqqk/wME8TymDliPWc/q2y1a1k/93PYm9858KwDi+BUhI/IWulSMjNPzP4xIX
 OKY7+rJ7CTbSNxshDblsKTYX0EeiNXXQO9uYfSM1RExMQb0kGfBqYDKLSO/0dpc4zCi89FJS
 NuWuXwNmQZejQL+/MITkK3kgqlMznzY+Twg4rctDIy7UxsoKc7hEYFXsTmdLZczWM45XmV07
 T4z0aZV0XbaVC0DyZBiwgLWSNXdLc6G+Bv+UuaWLzpiwn5oK/qzhBe3pFCp0fa0FtK131BDs
 jdfn5HSu2oM2R3e5onPSvZ08kq7nzfa/w7J4/xCIUc6mLCdLJgkw7UqkYEUv1iFFSjz8Hg=
IronPort-Data: A9a23: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
 jnicgNhOYxNNqA74sPFY+4UvJI=
IronPort-HdrOrdr: A9a23:VpQ6yqvSp2SKoYIyXEu1mfc17skCf4Mji2hC6mlwRA09TyXGra
 +TdaUguSMc1gx9ZJhBo7G90KnpewK5yXcT2/hsAV7CZniahILMFu9fBOTZslvd8kHFh4xgPO
 JbAtND4b7LfClHZLjBkXCF+r8bqbHtmsDY5ts2jU0dNz2CA5sQkTuRYTzrdXGeKjM2YKbQQ/
 Gnl7V6T1nJQwVUUizlbUN1G9QqwrXw5dHbiFM9dmgaAE7kt0Lc1JfKVzyjmjsOWTJGxrkvtU
 LflRbi26mlu/anjjfBym769f1t6ZDc4+oGIPbJptkeKz3qhArtTp9mQae+sDc8p/zqwEo2ke
 PLvwwrM61Imjvsl1mO0FbQMjTboXoTAyeI8y7WvZKjm72xeNsCMbsKuWoDGSGppXbI8usMkZ
 6j5Fjpxaa/PSmw7BgV2OK4JC2C7nDE2UbKsdRj+0C3ArFuH4O5B7ZvvDITLH5HJlO+1Lwa
X-Talos-CUID: =?us-ascii?q?9a23=3ArYO3PGpwZiokpX4hEZS3p3zmUfh/cG/4k1f1H3C?=
 =?us-ascii?q?lE3huEqWqTVW9w7wxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3As8+vRw2mSwWOLRugLEVTEq/7jjUj7IbpMWEiysU?=
 =?us-ascii?q?8qsTYci18BQ2Xhgnve9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="68486308"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA26.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:07 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 25 Oct 2023 11:43:06 +0200
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (104.47.7.168) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Wed, 25 Oct 2023 11:43:06 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxc6IZKHi3PG8yYtV04uOu/dGg+DwwKj0OmO61lMow8WiaeGU+MyuFrcWelcpn1u7wp8S4vHCNe/DH51cIO71d61jk6lpv6/v/LHm5DnqNCrNl4VwJu3wdT/9SgEzYq+RbQrNZYkXclSR9VDxiAB5SUAmvu1XoYrlIcGB9zT0JPfusVUZ5IsAUSQs8K9+vns3l1XDw/mqo+12/Es6y7U9a9vD9hzoHlyNzMD65H1EY5UJn4QZsEKc0TrSkqhI0AhmSqfEKBZkrKVOd3TrR65MW6/oO54HiOu6e3z/q4byePQsxsMzEKUgivdU4EsI/k8pjrk8VEcvcPd+XJep5w0Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zwg/Y0GePJgGtxfcuoj4iZKlnQIH9Xb1Bi5dMRcfvw4=;
 b=Oelfl45kD/cELO3Si57nGwi3mO3SMqqz48rK3vuBz5U66dqoJmQBwK8rBJAQAj1GayvULbfRthnT+vCIm6EUZ/XxgoPWd5S0YB13l1sGv+wqvrYUYJirYgMHGdV4YhHjeW6VjtkFYanT9w8AoLfLRV/Ttj/sqL1jnk9Sy/TuXIBQ5x6ULUYTMDCJCasyMLF+QwnpbT+duAlZQ2rs6je38v9dabaSuO81UEdEbT9uESoQdiC+kAmvzEUUsXPg92Gc/5nKBIOe9xEnKKTvLvMaNOTWCUDmrH+abPvF6UKuGgVO4sl4jo6l9TeR2XU6wYoG6pPNaTE6wD2rSCkp6VSHuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zwg/Y0GePJgGtxfcuoj4iZKlnQIH9Xb1Bi5dMRcfvw4=;
 b=jefJQZW6sugLAoYuNZdzA5iZIQdcQuwGE80+K5YK100b4Opc9K5Dmyzz8Xci3tLB5RiLLqiTHpbH0HnncC2ejEK+iIypOGR5ip0DxE9WAL3u5vxV5t0vNmYvZ9hdGzxBoV980QtSAuQQZzBZoGGR9RmWrLElC1lDtdq1JYpA9ks=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by BE0P281MB0116.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 09:43:00 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 09:43:00 +0000
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
Subject: [RESEND RFC PATCH v2 08/14] device_cgroup: Hide devcgroup functionality completely in lsm
Date: Wed, 25 Oct 2023 11:42:18 +0200
Message-Id: <20231025094224.72858-9-michael.weiss@aisec.fraunhofer.de>
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
X-MS-Office365-Filtering-Correlation-Id: 8d886489-78f6-4591-3f95-08dbd53ec6ff
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndlma0MVWI/LgjB6ouDGoxg0X6efYczAJ5OJ1x0o+Nzzy+q/LU0T7beIb23bdlLfpn3hSUfdrqzDpb89bwMNawkFfHBkakfsOqx5Q3ugBg2YbNFVCJm6MmVBSffGsyyMlj1UXv7aZlD9sMyfzpXRX06qoI9aBhwJThD8yPRXKspUYGrlSUkJ1WPIKVSIsalqSz/+IhByDSonZYyEii8o1krSrN1lS6/hwrdk1X2b4gH1/7Jng7Y+w/BjeXDB0NOD/QmQeJaf5BVGF+PwlDBswn+7FP+ea6uTn2B+SKW4gUeBWTg6+q3gTB2WysYqMvAwK6wpUa3k7mr2pAKTpRFbCN4KooYn0d2+yEefmn2vInjJbVLYaoiPXfPY2df+aEL7h/LU1PXD4uyfdWHQGNLfCk7x3HOJLv3HCAhaseVbf9GGNbxpoJ1L3LHDf4VYA5fKy9hw01HMwubfxsJeair9vDli0kXRvaBVxxrv+tx/4AMLRv2HeMo14Qf9vP6L4bVBX+rE6IH72rJ7Cbklq85OpCwUGrMlOVIxCBpYsTo0emgSQUGj9IjvcWATpmNG9NGyf/Ko2oC13apcHcUSdDRSK6KPFrApQprHkV8z+iN87s0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66946007)(83380400001)(316002)(38100700002)(6486002)(478600001)(6666004)(54906003)(110136005)(66556008)(66476007)(1076003)(107886003)(52116002)(6506007)(2616005)(6512007)(7416002)(2906002)(86362001)(4326008)(8936002)(82960400001)(8676002)(41300700001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTI3UUZZSnZFWEJjSUtsd211b1RHNGNGK0tIdlhzbEtWdktIZ28rbjNuMXNV?=
 =?utf-8?B?Y0dCYXdiREVvcVpXbjlRUDRKT2NzaWUvc1RLZFJpOThCaWxpcHY5YmFkSzlO?=
 =?utf-8?B?d2xBc0U4VmxiTGI1SlQwOUVwWit3dVN6SU9yZnFVd2xCaGpUZFZCWkZtMDUw?=
 =?utf-8?B?TkdjKzJBeGl5a1VmY3BISTlVaHdneDd3aGdESTVHWW1XQTR4OS84VHZyQXBX?=
 =?utf-8?B?bzNwa0dzSExzMUcyZWJWS1JocjJaQ0Y5aGNMbmNHUWVLSjk2bjRla1JmZnBK?=
 =?utf-8?B?RWd5SWhQaVE2ckVNREJ3WXkvQ2JTTTdCNVkyYzZmRlE5Tzk4OHVtN3NYbGNI?=
 =?utf-8?B?UTRZRUIwVFBpM3RLM01nYTZ4YkRrM1ZQaFhqdERNQnNZWGpnak94ekdwbVhw?=
 =?utf-8?B?bHpDUFpiVUtQUlJyT1VLTzBpMDFMUUF1YVpLejZGemVqemM2V3FEaGVqQVlP?=
 =?utf-8?B?RGdlcTJSbDlERVR3Z1M0a1kyeDhGdlVDY3NVdjMzdEh4NUhwV0pJUXBtMHhZ?=
 =?utf-8?B?cGdRZzJHNVRyUzlMRGh5QlZsYldkV1gwZzVJeHVFd0N3aVVCNTY4anFHYzJj?=
 =?utf-8?B?K1ZIbDVGajBLTGJjZy9BNGl1S2MvUTJQRzdqbFpML3owU0pCU1RpeUpJNVBM?=
 =?utf-8?B?YWEwazFuekcwRTNNNEVJWnBtVDI0MDBJNlJwcG44UlQwUWJvVDdQK3lDTi8r?=
 =?utf-8?B?VUJjVS9KQnNleGNxN0J3cGNTZ3pmY1NxUHJXOStERlZ6NWFGcExsakRVZGxB?=
 =?utf-8?B?eW1wU3hsNTM2Mkl0MXJXZDROSjRqaGdxckFJbHVLRDkzN25UbHZpSjN4bzhX?=
 =?utf-8?B?VDJqazJBUFo3dTZYNThESmtTcjJqY1gxVCtWRTExR0cvMWRhV3YxbjZGb0hj?=
 =?utf-8?B?SFNwQVY0NkdmQVBTdm41bUhuYndhK1NyRDI5SGhsSVpkL0JpeEkvaG9zemd1?=
 =?utf-8?B?MmY2WHU3bW1OcHF0SzlhWDNhMXp5bCtERC9Xa3AxVHUzMW5Uc0t5Q2IzU0V3?=
 =?utf-8?B?K0I4b25LRnFoWDIxQXI5NTczc1ZVM1dhaXBQVllrUWF5MHJjQUdDZGJYa1Mz?=
 =?utf-8?B?TVVHTDJkajNCai8vUTUyTFNXeEViVG1GcVhUQjhKV1ZMTVMrMW9CdEVSYldp?=
 =?utf-8?B?Y0ZsSmIxeVRsZXRuT3pyeVV0VEFZYUFDMStFYmNhQmVvcG9DOGxTVlMxS3hH?=
 =?utf-8?B?SmRoaFFUeWJUMDRFK1k2ZXNZa1VUdUZYcEQvTFhMcDBBZjlwUnF0UWs0VEtR?=
 =?utf-8?B?bVczN3FRWnZWcndnRThteStpY0pLUldSQWlUNUpQdzc4ZFloam15OWorSDN5?=
 =?utf-8?B?UVZ4N2R5dHVzdEJqdTVFZTR6RS9lRW8rMGxLUE5SMnVYSzkzdkxDa1UzSFBO?=
 =?utf-8?B?RHN5SzhlODBIRVpaaE92Qk9hY2MyTkJNQ056ZUZpaGdUY3p5Zi91WDdZU3JX?=
 =?utf-8?B?eU9pS3JkeEdyVUkwR2M1c2YxY2J4VFJFelZEdGdhT0IvQW9DRHd3dHpmV2Qv?=
 =?utf-8?B?b1hUWTJrVDUrTHQ1VzdyNTF0UXF3QVRDVzBieTF4S0lQNlk1THZEdit0Vldi?=
 =?utf-8?B?YkF0Ry8vcCtYMURiMUNrdzRrdEYxMGttNjdMcnN0L3BFSmR4N2lSdHJ6TXpP?=
 =?utf-8?B?SllBYUxwUXNtejQ3UXNNdVQybjJSbkNkSml1T2lnQURZV0hIYXNObHBsWVhE?=
 =?utf-8?B?SWVvNU0vMi9pZThGK1hHUzVoUThGMGgvZlpyQWJ4ZDh2anZuTkxtdGh1eEls?=
 =?utf-8?B?aFRybm9oTlM5RW5wWHdiMmlCUldrZHpKSExPRXJaUFNHUVdBaDVQM3JHSXU2?=
 =?utf-8?B?MS9kZFlnZUMyTjhQU3c0Wk5oNERSRk9STmtLdTNEd1owZU5KOXhEcXY3S0lB?=
 =?utf-8?B?S3lKWERQaXo4N1I3aHBNYjVLbmFacSt3azV0YytFNFBGdnpXcWlvWXl1SVU0?=
 =?utf-8?B?ZG9NNnEzc2xFM3JVcnFKdHV0bzBSRVRTQkRjRTlSN0k3WWlwcFdaL2NEK3FL?=
 =?utf-8?B?T0lIU2pVdkwrQnc1dnAzOFdDbjVjMHR6bzJtN21NeEo0RVQydmF5WDBqSXp2?=
 =?utf-8?B?bmZ2TnJDT0ljR1ErY2FKL2EyUVBOU1BuVHpWYjB5eEdQc2wzQkNJYkJLODdX?=
 =?utf-8?B?c0ZaTlRTN0FBZFo0RjAySEt1RVg2T3Q5SXcxZDBkNVFuLzFrM3Jsdmhvb2Iv?=
 =?utf-8?B?MThla1hGUFZENjBFcTVsd3c5YmJDZHZkeTlwSmVkQm56ZzJPa1c5VG14U0tR?=
 =?utf-8?Q?UN5NW+0rmcaLvp42z9G4w4jzFmq5WaZxybCgQHdFlQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d886489-78f6-4591-3f95-08dbd53ec6ff
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:43:00.7572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: of5JJ0/Dbvv/Mv5uDI+VRSliwBdlVUTne3G70JgQhm1qEM/3iGp/hpiGLjHq9pGRqPe8beFEOiHch394T5MJDVJpBsTksKXQ0VciK42KIonwLUBXJXn9roOLvwl+DxOQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0116
X-OriginatorOrg: aisec.fraunhofer.de

Now since all users of devcgroup_check_permission() have been
removed, all device cgroup related functionality is covered by
security hooks. Thus, move the public device_cgroup.h header
into the subfolder of the lsm module.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 security/device_cgroup/device_cgroup.c                    | 3 ++-
 {include/linux => security/device_cgroup}/device_cgroup.h | 0
 security/device_cgroup/lsm.c                              | 3 ++-
 3 files changed, 4 insertions(+), 2 deletions(-)
 rename {include/linux => security/device_cgroup}/device_cgroup.h (100%)

diff --git a/security/device_cgroup/device_cgroup.c b/security/device_cgroup/device_cgroup.c
index dc4df7475081..1a8190929ec3 100644
--- a/security/device_cgroup/device_cgroup.c
+++ b/security/device_cgroup/device_cgroup.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/bpf-cgroup.h>
-#include <linux/device_cgroup.h>
 #include <linux/cgroup.h>
 #include <linux/ctype.h>
 #include <linux/list.h>
@@ -16,6 +15,8 @@
 #include <linux/rcupdate.h>
 #include <linux/mutex.h>
 
+#include "device_cgroup.h"
+
 #ifdef CONFIG_CGROUP_DEVICE
 
 static DEFINE_MUTEX(devcgroup_mutex);
diff --git a/include/linux/device_cgroup.h b/security/device_cgroup/device_cgroup.h
similarity index 100%
rename from include/linux/device_cgroup.h
rename to security/device_cgroup/device_cgroup.h
diff --git a/security/device_cgroup/lsm.c b/security/device_cgroup/lsm.c
index 987d2c20a577..a963536d0a15 100644
--- a/security/device_cgroup/lsm.c
+++ b/security/device_cgroup/lsm.c
@@ -11,9 +11,10 @@
  */
 
 #include <linux/bpf-cgroup.h>
-#include <linux/device_cgroup.h>
 #include <linux/lsm_hooks.h>
 
+#include "device_cgroup.h"
+
 static int devcg_dev_permission(umode_t mode, dev_t dev, int mask)
 {
 	short type, access = 0;
-- 
2.30.2


