Return-Path: <linux-fsdevel+bounces-1139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD187D672C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 11:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC06281C67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8799823761;
	Wed, 25 Oct 2023 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="FtUk04Xf";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="I5GgAjek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2298A1C3E;
	Wed, 25 Oct 2023 09:44:07 +0000 (UTC)
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 02:44:03 PDT
Received: from mail-edgeka24.fraunhofer.de (mail-edgeka24.fraunhofer.de [IPv6:2a03:db80:4420:b000::25:24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33CD9D;
	Wed, 25 Oct 2023 02:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1698227044; x=1729763044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=jhb96eHx5V3sQacscu38ciSxM56ElbvGxM/gwY8kaFY=;
  b=FtUk04XfiQrRT1jUi8zFO0xU1gKWiLbpL39QXcQu7lHSIQ4lEGzmkelq
   fCYAW4v6ZTFGOSGPF4M1vkqt2SyxZmVkK56XbVqA6snXloQOHi5f9gQaR
   j7dShGp+isCa/hnVfu8J8SY+WMBT10eY8nV9IuINlEWLh+o2g7891CeL6
   zBlnkpdidIJD7Ubcgo3dMrlcPr6p1Xdrim14ffQHw/gZLULcnyr04VthP
   cQeRFZ+W+0XHme+JhrwKmCXtiSiBtI/J/UO21Rk3HxVG7RTKR2QNDeKQW
   tbgsvkSSXR3o3rIwpP2uplxwh0fPWK5nW+FhjRUsK95WupEg8BJBmxrON
   A==;
X-CSE-ConnectionGUID: kEM4vVTeQPm7VCLzIwglLg==
X-CSE-MsgGUID: ND91yhsXTAOEFXVHLdsJaA==
Authentication-Results: mail-edgeka24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2H4BABB4jhl/xwBYJlaHgEBCxIMQIQIgleEU64IKoJRA?=
 =?us-ascii?q?1YPAQEBAQEBAQEBBwEBRAQBAQMEhH8ChxonOBMBAgEDAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QECAQEGAQEBAQEBBgYCgRmFLzkNhACBHgEBAQEBAQEBAQEBAR0CNVQCAQMjD?=
 =?us-ascii?q?wENAQE3AQ8lAiYCAjIlBgENBYJ+gisDMbIYgTKBAYIJAQEGsB8YgSCBHgkJA?=
 =?us-ascii?q?YEQLoNchC4BhDSBHYQ1gk+BSoMzhFiDRoJog3WFPAcygiKDLymLfoEBR1oWG?=
 =?us-ascii?q?wMHA1kqECsHBC0iBgkWLSUGUQQXFiQJExI+BIFngVEKgQM/Dw4RgkIiAgc2N?=
 =?us-ascii?q?hlLglsJFQw1BEl2ECoEFBeBEW4FGhUeNxESBRINAwh2HQIRIzwDBQMENAoVD?=
 =?us-ascii?q?QshBVcDRAZKCwMCGgUDAwSBNgUNHgIQLScDAxlNAhAUAzsDAwYDCzEDMFdHD?=
 =?us-ascii?q?FkDbB8aHAk8DwwfAhseDTIDCQMHBSwdQAMLGA1IESw1Bg4bRAFzB51Ngm17E?=
 =?us-ascii?q?4Ipll0BrnkHgjGBXqEJGjOXK5JPLpgOIKI+JoUkAgQCBAUCDgiBeoF/Mz6DN?=
 =?us-ascii?q?lIZD4EbjQULF4NWj3t0AjkCBwEKAQEDCYI5iRIBAQ?=
IronPort-PHdr: A9a23:sbks8xFNZzetKhKsCytat51Gf3BNhN3EVzX9l7I53usdOq325Y/re
 Vff7K8w0gyBVtDB5vZNm+fa9LrtXWUQ7JrS1RJKfMlCTRYYj8URkQE6RsmDDEzwNvnxaCImW
 s9FUQwt5CSgPExYE9r5fQeXrGe78DgSHRvyL09yIOH0EZTVlMO5y6W5/JiABmcAhG+Te7R3f
 jm/sQiDjdQcg4ZpNvQUxwDSq3RFPsV6l0hvI06emQq52tao8cxG0gF9/sws7dVBVqOoT+Edd
 vl1HD8mOmY66YjQuB/PQBGmylAcX24VwX8qSwLFuRjRYsvKvRb9kq0lyTSBJvzZYIAFBz2lt
 LZobET3tSwaFwcW3H7Nof5OoZ8O83fD7xYq4tP7b6iXOfl7I5v3Te0mb0NqBNcMXAxkPIqOS
 7YlMPAvHMt4sZbWo3cS8SfgW1TwXNnE9Bpnhybp0Pdg0+kEUkL+9hU7AM8h4VTlqIj8G7cJS
 eWy0ZGZ1GvyLNUPnizN6dTlQhANqveQB5xresH6xmUzClrdn27JkZHKBRmEju0wsnCHxsw7c
 sKiu0t2oT9Y/QOr/Pwc27voudlIx07F5xxW/qoSe8KqS3RKNI3sAN5RrSacL4xsXoY4Tnp1v
 Dpv0rQdos3TlEkizZ0mw1vSZ/OKcIHSvlTtTu+MJzd/in9/Pr6y1F6+8kmln/X1TdL8kE1Lo
 SxMjsTWuzgT2gbS5MmKRro1/kqo1TuVkQGGwu9eKF0yla3VJoRnxbg1l5EJtl/EEDOwk0Lz5
 JI=
X-Talos-CUID: 9a23:eAQr4m2Po/pco9za6y64aLxfGe0ALmPj8HrpG0rnN01NWpyKRlu09/Yx
X-Talos-MUID: 9a23:sF9B0wU06PsWcXjq/BnA1WhzNNxY342JJW49r7Uit9KmPAUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="1802490"
Received: from mail-mtaka28.fraunhofer.de ([153.96.1.28])
  by mail-edgeka24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:42:56 +0200
IronPort-SDR: 6538e320_pDqJ/Zbj0YhgknOVNjseWRoy3ormceWTyF5I0ck7jZi5W5q
 pRn7ey0hlVC58rt0SGpfncYL5P/jdCaTn515a+Q==
X-IPAS-Result: =?us-ascii?q?A0CtBgC94Thl/3+zYZlaHQEBAQEJARIBBQUBQAkcgSqBZ?=
 =?us-ascii?q?1IHgUuBBYRSg00BAYUthkGCXAGcGIJRA1YPAQMBAQEBAQcBAUQEAQGFBgKHF?=
 =?us-ascii?q?wInOBMBAgEBAgEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBBgSBChOFaA2GTQIBA?=
 =?us-ascii?q?xIRDwENAQEUIwEPJQImAgIyBx4GAQ0FIoJcgisDMQIBAaUwAYFAAosigTKBA?=
 =?us-ascii?q?YIJAQEGBASwFxiBIIEeCQkBgRAug1yELgGENIEdhDWCT4FKgzOIHoJog3WFP?=
 =?us-ascii?q?AcygiKDLymLfoEBR1oWGwMHA1kqECsHBC0iBgkWLSUGUQQXFiQJExI+BIFng?=
 =?us-ascii?q?VEKgQM/Dw4RgkIiAgc2NhlLglsJFQw1BEl2ECoEFBeBEW4FGhUeNxESBRINA?=
 =?us-ascii?q?wh2HQIRIzwDBQMENAoVDQshBVcDRAZKCwMCGgUDAwSBNgUNHgIQLScDAxlNA?=
 =?us-ascii?q?hAUAzsDAwYDCzEDMFdHDFkDbB8WBBwJPA8MHwIbHg0yAwkDBwUsHUADCxgNS?=
 =?us-ascii?q?BEsNQYOG0QBcwedTYJtexOCKZZdAa55B4IxgV6hCRozlyuSTy6YDiCiPiaFJ?=
 =?us-ascii?q?AIEAgQFAg4BAQaBeiWBWTM+gzZPAxkPgRuNBQsXg1aPe0EzAjkCBwEKAQEDC?=
 =?us-ascii?q?YI5iREBAQ?=
IronPort-PHdr: A9a23:espShxc3Y9AvDPqgveobLASWlGM+/N/LVj580XJao6wbK/fr9sH4J
 0Wa/vVk1gKXDs3QvuhJj+PGvqynQ2EE6IaMvCNnEtRAAhEfgNgQnwsuDdTDDkv+LfXwaDc9E
 tgEX1hgrDmgZFNYHMv1e1rI+Di89zcPHBX4OwdvY+PzH4/ZlcOs0O6uvpbUZlYt5nK9NJ1oK
 xDkgQzNu5stnIFgJ60tmD7EuWBBdOkT5E86DlWVgxv6+oKM7YZuoQFxnt9kycNaSqT9efYIC
 JljSRk2OGA84sLm8CLOSweC/FIweWUbmRkbZmqN5hGvV7zN7hD1i+1Zn3GLINbtfJ8ZaQX85
 qAwWRzM0zg6PCMZyU77ldZbvpx2nUfywn43ydv1Pa6aHfhzfaaARfkqe1Zrd+0LRnFKIqaCZ
 rkrMsA+J8h5gqnjuHAKgQfiOVfyWb+38BR2o1D3hLI3ib4hHCSFnzQKBskRrVuFjOTxaa49Q
 futya7V9WTaMcIV/26687jJLj0Rod2HW64qX9HawmIgOx/Y102BktXdIhyv/PVVulWa9/ZJc
 7mIq2MXjlB7nBHw/cMWsbmYtKMqkQ3J6yRr+akLCfrmV1x4W+/xQ9NA8iCAMI1uRdk+Bntlo
 zs+1ugesIWgL0Diqbwizh/bLvmbequhuEKlWvyYPDF4g3xoYvSzikX6/Uuhz7jkX9KvmBZRr
 yVDm8XRrH1FyRHJ68aGR/c8tkes0DqCzUbSv8lKO0kpk6rcJZM7hLk2k5sYq0PYGSHq3k7xi
 cer
IronPort-Data: A9a23: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
 jnicgNhOYxNNqA74sPFY+4UvJI=
IronPort-HdrOrdr: A9a23:TGxyaa4+D/yWjKNCZAPXwV+BI+orL9Y04lQ7vn2ZFiY7TiXIra
 yTdaoguCMc0AxhIE3I6urwQ5VoIEmsvaKdhLN+AV7MZniBhILFFvAA0WKA+UyqJ8SdzJ8l6U
 4IScEXY7eQbWSS5fyKpTVQeOxQpeVvhZrY4ts2uE0dKT2CBZsQjTtRO0K+KAlbVQNGDZ02GN
 63/cxcvQetfnwRc4CSGmQFd/KrnayAqLvWJTo9QzI34giHij2lrJTgFQKD4xsYWzRThZ8/7G
 n+lRDj7KnLiYD39vac7R6e031loqqu9jJxPr3MtiHTEESttu+cXvUvZ1RFhkF3nAjg0idprD
 CGmWZbAy060QKtQojym2qo5+Co6kdT11byjVCfmnftusr/WXYzDNdAn5tQdl/D51Mnp8wU6t
 M944s3jesmMfrsplWJ2zHzbWAfqmOk5X451eIDhX1WVoUTLLdXsIwE5UtQVJMNBjjz5owrGP
 RnSJi03oceTXqKK3TC+mV/yt2lWXo+Wh+AX0gZo8SQlzxbhmpwwUcUzNEW2n0A6JU+QZ9Z4P
 msCNUfqJheCssNKa5tDuYIRsW6TmTLXBLXKWqXZU/qEakWUki92aIfII9Fl91CVKZ4vafawq
 6xL2+wnVRCBX7TNQ==
X-Talos-CUID: 9a23:2Ug9ymMKcjpFT+5DCXhs7HAIHOkZNWzY6y/tAWiREzoxV+jA
X-Talos-MUID: =?us-ascii?q?9a23=3A79ZKvQ2zxysStDMAJCcUFU9cTjUj/5mxCWAryrw?=
 =?us-ascii?q?6ieLdOXR1PSu60iroe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="135077921"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA28.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:42:55 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 25 Oct 2023 11:42:55 +0200
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.169)
 by XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Wed, 25 Oct 2023 11:42:55 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jnef7P7QOVWsWNV1P6QO74uh3gVlqM8wF4OQtdHS0/aVufedd237u2C7lRzcwVRaS04dYmeoiV0NlZt1Cf9NyzuYarIWZOCQXlRj9bFA/zXMxkr/46bfSatHxLcnFaBhgh8gxf7qlUEjt2DztFvMZuxrIu4gSftC+ilOBt6hpCy0m2l+zzlSxIQ6UVDwxqhUfQZsSp/ko9vXHg3mj86yMYVGHn0/Dsha9++eK6rVDF4RnGU1E6Y2/i9wc1apSqmSnt5NAY6QyZisurPguSSZgbSWvCJvOPKO3Vx4r4+Q2CSFuQ5f3m4tc2BnnvMZRzjCePQ6MHDr6GmJneHzjoQl8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCT4SgUoL/0yussYGEXY6ao3ykL3wUcuHQGDwrCZVEU=;
 b=YSkvaVdcrqZifjbuPv3fDjmRkzSN0C4wc0jzkBgibgnxRsn+3/QIlUf1dcxG/EQiq1Vgt2CwHrsMtITsY6keHTOhfQ7avnM5K1neIUq/5/fKmesrGpXQke7ySs8hbJy/q86JOxYvmWe8+e0FZUgA5Df83upIAPumpT8cCwmxvotb5KBaOClTNQWxOw0LRh9l8rfkqRi4MNjowgdIq1U8vLLcbQJzIaBqx5gWImogszE5J4K8JWvsRZow+rriXdeYKWEkujD3oma9IDfjGtD91Zhfxgkqn7faH6BewvX+hu0pJJnPvrXtFttLwX07RFLocp/fbCHoVb1snOEtFouTuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCT4SgUoL/0yussYGEXY6ao3ykL3wUcuHQGDwrCZVEU=;
 b=I5GgAjekm5PBXVTBAC2y5cHMVaZLUBWrFIEHvwClDt4T66540RCVMGi1we22heM++PBqswuG9HYl5aGxspmouP9q6Y+N1/sXi4EXhDcnt2FsccCgDtu1pyS1PuGRBy0aUiptAN3OHeXM9bVA7SlRSX9ZIW35evizQGVDO6wzkRY=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by BE0P281MB0116.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 09:42:54 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 09:42:53 +0000
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
Subject: [RESEND RFC PATCH v2 02/14] vfs: Remove explicit devcgroup_inode calls
Date: Wed, 25 Oct 2023 11:42:12 +0200
Message-Id: <20231025094224.72858-3-michael.weiss@aisec.fraunhofer.de>
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
X-MS-Office365-Filtering-Correlation-Id: e1f8b819-4272-4858-a1c7-08dbd53ec2dc
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9VvorlZKgkslf3oJMirlkDDUVXdlX7B2XEWwUI/+JFLUqfFL7D66R4WLaEnhexqYP/lhnmrHaf9NMZ6nN04LsVZ5tURLY3tnLlXWGlCuNykl9cHCUg6zmItms2jfm7Rkm3HHRLkl7yFhXKfwS9gqa28bSETsmJmnfH96V+gHL11zc47uud2TJST7yIXya8xLpleDhSNHnz3HQyOnZZJZtHuMOkFzTkVWb92+pMpq9GG4jOo9bFp4jGsiHlC2L9JFXJKTuq/7cvxJRNg1OZisqcAkGfvhkM/+W/45DLcSCxIeQg4/Z7B3mtjRYYEYfDWDvsLG/W8VKHYPyVCwkVTkYrDe9f2UX4opvgEMUMPXkHttx1Ti5XBim0d61GaciOGL2o+BJlMX8IMtSPyYQ9Xg3/oHBcSJkYd7Yeo7ZUcuBzFQ58izEFdbw9h3KCe71ew+jZ0IxX/1vJSWhRKITme4SJm+LTykWwjUrXMLfG/0UgZC/i6ooUrvBpjVsq/28BXFRMGE8IOfs8xesc/fysraVDCDf+rzg3l0vAWvccsemQJ1oAZAwCn51+tKxNx1nI7+HSX3EEAMyjnbh4JwgmIHBFRy98HRKdy60/80lt8e2w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66946007)(83380400001)(316002)(38100700002)(6486002)(478600001)(6666004)(54906003)(110136005)(66556008)(66476007)(1076003)(107886003)(52116002)(6506007)(2616005)(6512007)(7416002)(2906002)(86362001)(4326008)(8936002)(82960400001)(8676002)(41300700001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVMzRDIrMEJSeS9zaHJ2QVEyNjFlRUVNRDVtRUhPVUIrQzA3amtqY1doK0dl?=
 =?utf-8?B?djNUb0VUSTlGTjdBb3VrSGtCdEF5K2lGYi81VmJaTWNJUHNFUnk4OTBwSmxC?=
 =?utf-8?B?cFpXTnNkdFhaVVZWTGN4RmpzZG9aYTRPeU5tdEMvRGpJTlZTem55SVRwczdB?=
 =?utf-8?B?MkFzdXc5bTNoczMzTWNHbGI4a1ZQM0FZZkFaOTd6amZsNjl0VVJXU3ZzVm5z?=
 =?utf-8?B?czgrOHZGc0xDZGlJMDFwODlMRTdPODZJVHdWZFRSMU1MVUlRN25ibU5Tb3Fs?=
 =?utf-8?B?OEJQbW04bWdhMm9JRU5WUk1JRWVzb2IvaVp2YVQ3UHVxOE1MUGdSdUhJY0hm?=
 =?utf-8?B?UldZQitUS3dLM1Z6M1d6ZUhWRk1BOENiWm1NQUZMbDFXUHFQdlhmeGZ3NC9q?=
 =?utf-8?B?QXU1RXo4TDRPUzhzRjVDM1A1ajdmSytQQ3piL2s0Z3dLaTFMZWJFT08reVVy?=
 =?utf-8?B?YzJsWmtvYVQvUkF1RkNOaitzZHp0Yk9Pb1l0TkJlN3F5ektOMlJDUTFpaG1V?=
 =?utf-8?B?T0ZVUksxeGtNV1VwcWZjeEkzTWp2dEluL2hZVytyNGR0UHZZa0RSOU1PQkFi?=
 =?utf-8?B?alNDeWpFQ0wvYUxiOUNJZmlVbE1hdStSZHA5Sm5UM3U0TlhDeGx1ZGxlY1JY?=
 =?utf-8?B?K2lmNEpTYkpSSTRrMm9YMklUTk1TeDUwYUs5bWgvMEtva3pDNGlKNThqL1Az?=
 =?utf-8?B?STAwSlpxbzdjTmVxdlJIQm52WXNaUjkzVE1sWlhVZWNpRlNpNTVQU1JGczdL?=
 =?utf-8?B?c3owcVZsc2YrZEFUN2JRS1pJb2ZmUnkzdUZhZzI2SEgwS2NXSFpYSDQ3ODVy?=
 =?utf-8?B?K01wb3ZTTC90THNkeEUvbXhaVnFzUjliekh5ajZvaXdmaFR0ZjlxUHJQc1Ft?=
 =?utf-8?B?eEZ2dldSeVdKZXUxdnRJUHNnYm5vMHh2NEpnL3B4M3E1QmhucGNXVjBENnBD?=
 =?utf-8?B?MzV0WWJNTk1QZEtKbHltVGxkWFF2U3F3eVdxY21pSDFva3FBL0tTSFFtanUw?=
 =?utf-8?B?SkxJN1ZOcUtBS2QzQ09UYzN5Z3p5MW8xb2Fkd2dsSWNlRXkyNjFQdFF2T0E5?=
 =?utf-8?B?cGpGRGFiUE5JVzBkQzhiRnBXdXV2MGZMSEx0RGRjeEJGbVcxamRUOVBueGhE?=
 =?utf-8?B?bmhTWnBvSFhweE5Ic0k1T25EaU5uOTlxSXRaTDdzNmdxYWJXZVptY2hiR0kx?=
 =?utf-8?B?QjhzZmlMZHJqQlVQOUZER28zYk1BZmdiVnV2TjhHVFphL1NORzNMTFJXUllB?=
 =?utf-8?B?QWYxcWpnWlhvcTVYbXVETTUzaitiNHhETVVxMXBLZUNVY2RjSDd2OGIzd2Yx?=
 =?utf-8?B?RXNWZW9JTjhxcFd0dGNJbE1rQXNIMVZDWWRJU0hPeHBxMGJ0V1ZLbmwwVXJX?=
 =?utf-8?B?Q1JZd1lxd3Z4OWFLTk15eVl1TzJmaW1YSUlXNU03OUlSTTFCQjRGV1B5MlQv?=
 =?utf-8?B?TWdvbHNzZkVHV2Y5WG9ackpNK293SG5XL0QwKzY2UGpEYUxpRHZGeEYxNkNy?=
 =?utf-8?B?YW55U0tJYkh5NkxYclRQbHFWaldLVlhpem1ScHZiTk1saUgveTYzR3pMZjRT?=
 =?utf-8?B?TDF1cEtxT2NSRUt5TzBOYUwxMVVNN0NrZktpZm1vNmNaMkN6TWNiY1luZG5r?=
 =?utf-8?B?NXc2V256TklnVDEramExaXJFa2FEV2NObXZwR3d6SStybjg4NEtGU0EyWkUx?=
 =?utf-8?B?UEpVQlVVa3hxdHk0b25Cc3BvdkJoS21NaWV3QUFteTlFb1JIM0lMaVJJZDEz?=
 =?utf-8?B?MUtUNGZJN2dJMVZGak81M1F3NDBYTExmcDJFZlREdHJpclRwZjE1OHRtZ1FT?=
 =?utf-8?B?OTFtNVNyOUlBbFdWTU51U0hPTmJVTC9wL1k2VTdmMGhLSkVIOXN0RVowL2JU?=
 =?utf-8?B?NWV2MmR4Sks3Y01VTE96OG9PTVFtVWI0akJqRW1YZzJiU0M1S1o1ZGRYNFh5?=
 =?utf-8?B?UDNzUTdiZ05xWUdhcmc3SjlwcmVRWVBVZklFU2xocmN4dGd4RjZ0NC91bDhY?=
 =?utf-8?B?a1VwSUExelpqR2Q2dkJqS0taZWZMVk93S0o2U0JzY0RWMU1BRzBLdkRsSTNh?=
 =?utf-8?B?bStWZ2doSGtadEpCN21oMkl0TTVOVVlsVnByOW5HbGU4aEh0Z0s3K1dWVEph?=
 =?utf-8?B?VktVOXdlRldqUmFOMy9KZXRCOFYyWVRTVFRUdWdSYlBNRHNEeUt6UFBxMnMz?=
 =?utf-8?B?a0lEbFVLTHhkUEYzT3lzNEJjUlRWSWtYdWNBaFlqQWNTMTRUTzNIQlc5U0JG?=
 =?utf-8?Q?8nCWkmHJSSqXyrPXvxguM8mzpBi7mANhvOlYAbmjJA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f8b819-4272-4858-a1c7-08dbd53ec2dc
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:42:53.8515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLA/SPFiVYZIdu2tFQBaXrsERJE48HWs9r9jkhiTDhoxiNeRLdUY8ra5AGOQnBt2OfSxF0A9rB17VAseAelC9PUU2Wi8R3G1vNSLe4xTt48EeLW+fyXler0J/IWrWKgC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0116
X-OriginatorOrg: aisec.fraunhofer.de

Since the new lsm-based cgroup device access control is settled,
the explicit calls to devcgroup_inode_permission and
devcgroup_inode_mknod in fs/namei.c are redundant and can safely
be dropped. The corresponding security_inode_permission and
security_inode_mknod hooks are taking over.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 fs/namei.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 567ee547492b..f601fcbdc4d2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -34,7 +34,6 @@
 #include <linux/capability.h>
 #include <linux/file.h>
 #include <linux/fcntl.h>
-#include <linux/device_cgroup.h>
 #include <linux/fs_struct.h>
 #include <linux/posix_acl.h>
 #include <linux/hash.h>
@@ -529,10 +528,6 @@ int inode_permission(struct mnt_idmap *idmap,
 	if (retval)
 		return retval;
 
-	retval = devcgroup_inode_permission(inode, mask);
-	if (retval)
-		return retval;
-
 	return security_inode_permission(inode, mask);
 }
 EXPORT_SYMBOL(inode_permission);
@@ -3987,9 +3982,6 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		return -EPERM;
 
 	mode = vfs_prepare_mode(idmap, dir, mode, mode, mode);
-	error = devcgroup_inode_mknod(mode, dev);
-	if (error)
-		return error;
 
 	error = security_inode_mknod(dir, dentry, mode, dev);
 	if (error)
-- 
2.30.2


