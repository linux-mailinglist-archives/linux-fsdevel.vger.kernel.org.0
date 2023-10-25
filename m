Return-Path: <linux-fsdevel+bounces-1141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B927D6736
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 11:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1CD0B2128A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 09:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927472511A;
	Wed, 25 Oct 2023 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="ViWaggDo";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="IfNeqAB7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EB312B8D;
	Wed, 25 Oct 2023 09:44:07 +0000 (UTC)
Received: from mail-edgeDD24.fraunhofer.de (mail-edgedd24.fraunhofer.de [IPv6:2a03:db80:1504:d267::25:24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66505CE;
	Wed, 25 Oct 2023 02:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1698227045; x=1729763045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=u8J4QNl6bGHBAAGKFG1CKmom9uj9k0VkWpIZmDvdvHw=;
  b=ViWaggDoEuen0RvTIMG1GXBw4zRsp3EFjhUe1CbyLOCOjQvKz31p+58L
   7vDVn7kv3rHW5VbOk3MexREiD0wd5ppH63u5IWn0x13k4P6WGRjtnKr/i
   ZU+qK8tBawkmdDGAvEMcpmqPp5nUGRXqa1p8ffw7WQUCDDyWkuF0NyQGf
   ZWAuLgoXdGho0rvPxNSJcQBTEYFkiZzOzcOBGyCoyuvznNI/NxUip0sLk
   F3zSdypHjY+tbMdBg5cWo19LoymBWeBjinxwXvA7pxTbvayEsKhPJNe5M
   9VYc7hL2VJdsTmevWfxFGKjXAVj4zJSM/8QQMRuxkBdz+bNHCea3Tgmnx
   w==;
X-CSE-ConnectionGUID: bGpp7yw1Qb+D08fO5o1H0g==
X-CSE-MsgGUID: NZUdsIxMSmWvBHD1r8+GvA==
Authentication-Results: mail-edgeDD24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2E2AABB4jhl/xoBYJlaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YIQKIJXhFOIHYlBmCaEBCqBLIElA1YPAQEBAQEBAQEBBwEBRAQBAQMEhH8Ch?=
 =?us-ascii?q?xonNAkOAQIBAwEBAQEDAgMBAQEBAQEBAgEBBgEBAQEBAQYGAoEZhS85DYQAg?=
 =?us-ascii?q?R4BAQEBAQEBAQEBAQEdAjVUAgEDIw8BDQEBNwEPJQImAgIyJQYBDQWCJliCK?=
 =?us-ascii?q?wMxshiBMoEBggkBAQawHxiBIIEeCQkBgRAuAYNbhC4BhDSBHYQ1gk+BSoEGg?=
 =?us-ascii?q?Td2g3tdg0aCaIN1hTwHMoIigy8pi36BAUdaFhsDBwNZKhArBwQtIgYJFi0lB?=
 =?us-ascii?q?lEEFxYkCRMSPgSBZ4FRCoEDPw8OEYJCIgIHNjYZS4JbCRUMNQRJdhAqBBQXg?=
 =?us-ascii?q?RFuBRoVHjcREhcNAwh2HQIRIzwDBQMENAoVDQshBVcDRAZKCwMCGgUDAwSBN?=
 =?us-ascii?q?gUNHgIQLScDAxlNAhAUAzsDAwYDCzEDMFdHDFkDbB8aHAk8DwwfAhseDTIDC?=
 =?us-ascii?q?QMHBSwdQAMLGA1IESw1Bg4bRAFzB51Ngm0BNlcBgVorUpYuAa55B4IxgV6hC?=
 =?us-ascii?q?RozlyuSTy6HRpBIIKI+QoUIAgQCBAUCDgiBY4IWMz6DNlIZD44gDBaDVo97d?=
 =?us-ascii?q?AI5AgcBCgEBAwmCOYZGgkwBAQ?=
IronPort-PHdr: A9a23:YLtoMBfm5VeEmyS1DH01krdjlGM+49/LVj580XJao6wbK/fr9sH4J
 0Wa/vVk1gKXDs3QvuhJj+PGvqynQ2EE6IaMvCNnEtRAAhEfgNgQnwsuDdTDDkv+LfXwaDc9E
 tgEX1hgrDmgZFNYHMv1e1rI+Di89zcPHBX4OwdvY+PzH4/ZlcOs0O6uvpbUZlYt5nK9NJ1oK
 xDkgQzNu5stnIFgJ60tmD7EuWBBdOkT5E86DlWVgxv6+oKM7YZuoQFxnt9kycNaSqT9efYIC
 JljSRk2OGA84sLm8CLOSweC/FIweWUbmRkbZmqN5hGvBabJrgT+vORa2CSZYs7nYrUPfQids
 5w2VxWvlAFaLSdlrm3o0dFrjK5Xu0fywn43ydv1bqeYLdNUIfz7XYMka3R+ZeRKB3BvLqa+b
 LMWM+QsBb9FobWlugAwkwmQWy+RGP22yiMUqifu7IYB1/4mSiKf0VA8J+M/vSjuk9HcZaU0V
 fqp7PH60zzqMu5E2TD36LaWch8Y/9uGfaM3Nsv+zVEBFCrVigSxqoffZyvJ0vgKs1Oa4u4jB
 eujl3wOmSJ+k3+BwMgi1MrIgLw52lvuzyN/wJQvAoSmEFNpMcHxQ9NA8iCAMI1uRdk+Bntlo
 zs+1ugesIWgL0Diqbwizh/bLvGLfIWkzki/EuiLKCp+hHVrdaj5ixvhuUSjy+ipTsCvyx4Kt
 StKlNDQq2oAnwLe8MmJS/Zxvw+h1D+D2hqV67RsL1o9iKzbLJAs2Pg3kJ8Sul7EBSj4hAP9i
 6r+Sw==
X-Talos-CUID: 9a23:bpVleG8EV3vpS7NjwviVv0Q7Ath6Y2KE9X2TDxfoB0E0T+S1EVDFrQ==
X-Talos-MUID: 9a23:Yb8i2AWc82zNiljq/BneuT15FddN2KGRFmotvcwc64qrKwUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="71347887"
Received: from mail-mtaka26.fraunhofer.de ([153.96.1.26])
  by mail-edgeDD24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:42:58 +0200
IronPort-SDR: 6538e321_8uYvttgzKjzemzUDq3GF7/M7Ych4sU7/REFbzrxKIGAcXaX
 +ALTrQ/Bym+v+lRHkrxupvO8EPpsovw9xTFleZA==
X-IPAS-Result: =?us-ascii?q?A0BZAABB4jhl/3+zYZlaHQEBAQEJARIBBQUBQAkcgRYIA?=
 =?us-ascii?q?QsBgWYqKAeBS4EFhFKDTQEBhE5fhkGCITsBl2qELoEsgSUDVg8BAwEBAQEBB?=
 =?us-ascii?q?wEBRAQBAYUGAocXAic0CQ4BAgEBAgEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBB?=
 =?us-ascii?q?gSBChOFaA2GTQIBAxIRDwENAQEUIwEPJQImAgIyBx4GAQ0FIoIEWIIrAzECA?=
 =?us-ascii?q?QGlLwGBQAKLIoEygQGCCQEBBgQEsBcYgSCBHgkJAYEQLgGDW4QuAYQ0gR2EN?=
 =?us-ascii?q?YJPgUqBBoE3doN7hCOCaIN1hTwHMoIigy8pi36BAUdaFhsDBwNZKhArBwQtI?=
 =?us-ascii?q?gYJFi0lBlEEFxYkCRMSPgSBZ4FRCoEDPw8OEYJCIgIHNjYZS4JbCRUMNQRJd?=
 =?us-ascii?q?hAqBBQXgRFuBRoVHjcREhcNAwh2HQIRIzwDBQMENAoVDQshBVcDRAZKCwMCG?=
 =?us-ascii?q?gUDAwSBNgUNHgIQLScDAxlNAhAUAzsDAwYDCzEDMFdHDFkDbB8WBBwJPA8MH?=
 =?us-ascii?q?wIbHg0yAwkDBwUsHUADCxgNSBEsNQYOG0QBcwedTYJtATZXAYFaK1KWLgGue?=
 =?us-ascii?q?QeCMYFeoQkaM5crkk8uh0aQSCCiPkKFCAIEAgQFAg4BAQaBYzyBWTM+gzZPA?=
 =?us-ascii?q?xkPjiAMFoNWj3tBMwI5AgcBCgEBAwmCOYZGgksBAQ?=
IronPort-PHdr: A9a23:1DOoMhHh3nJzvaA+sPt+9p1Gf29NhN3EVzX9l7I53usdOq325Y/re
 Vff7K8w0gyBVtDB5vZNm+fa9LrtXWUQ7JrS1RJKfMlCTRYYj8URkQE6RsmDDEzwNvnxaCImW
 s9FUQwt5CSgPExYE9r5fQeXrGe78DgSHRvyL09yIOH0EZTVlMO5y6W5/JiABmcAhG+Te7R3f
 jm/sQiDjdQcg4ZpNvQUxwDSq3RFPsV6l0hvI06emQq52tao8cxG0gF9/sws7dVBVqOoT+Edd
 vl1HD8mOmY66YjQuB/PQBGmylAcX24VwX8qSwLFuUrLZovetiH0kepw23aZLOLzdpQIZmiZs
 rhhDwPO1T0ea2A1zzrKkcx8gLkO83fD7xYq4oDybZi8HqUhWIONQ/0EelFjRZYNeQBkAICEd
 rcBItJYIOhk95SmmWUcg0WYOBWyXePzlhMQnk7d5qkg1L8CSAyawDQRLt9SikvQhYT3EqMIT
 cDt/rfB5GjeffNR0zfDtojHS04Lq9GdGvVxXs7J50oGBweUr1abk9T9YzeJ0eQ2smWfrLppW
 f69olwEpDA2jD6gyJlvi4/3qpIe4GrC8yVr2qFsO4WlWh5kNI3sAN5RrSacL4xsXoY4Tnp1v
 Dpv0rQdos3TlEkizZ0mw1vad/WkWtLWpBz5XfuXITB2iWgjdL/szxqx8E310uTnTYH0y1dFq
 CNZj8PB/m4AzR3d68WLC7N9806t1CzJ1lX75PtNPEY0kqTWMdgmxLsxnYAUqkPNAmn9n0Ces
 Q==
IronPort-Data: A9a23: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
 Z8tq7BhP0jNspDLhZYUhg==
IronPort-HdrOrdr: A9a23:7n0efKAmlQrleynlHemR55DYdb4zR+YMi2TDj3oBLCC9Afbo8/
 xG/c5rrSMc5wxhO03I9ertBEDiewKmyXcW2/hyAV7KZmCP0wHEEGgI1+XfKkjbexEWgdQ96U
 4PScdD4ZbLfD9HZI7BkW+F+vgbsaC6zJw=
X-Talos-CUID: 9a23:e/u9R2O/XP3VSu5DVQJc62kIP/0ZNVqB00jOc32xNEFWYejA
X-Talos-MUID: 9a23:qV95HAoKSLWOWKMOCCcez2FMD9xmxOe0MWscoKlW582BHgIsCg7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="68486274"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA26.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:42:57 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 25 Oct 2023 11:42:57 +0200
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.169)
 by XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Wed, 25 Oct 2023 11:42:57 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BN2rXsY9QnihpXD5Zd8rBkELaQwvCD3OQ+kKNr+/P4R5Z3lOQOahIamHo7SkmbUM4/MDc1k/oeeqRrx6sDFou6pqPdUlTBNy80eE2mEIbXyxLh8BKQpR06gd2+DaEwqmAFz9ZsOH3Vp29WQYsDNvpc64rFrMlj7LjPlFcEEtRoKa6EiXBoeRTlTfT5AetOxDiyzVYyaE4/eQqpkwrnLN7813rMnqzXEzNhTyNhPydFUOftcg1fax6pZDma0wQmDNPM78St2hOOnjplpmcYaWhLYtJ6LK5s73N1QaSwuHhkHb1hoNEmuQ3xZfYSK/9VCv2GyfL85DnsQKq1RdCxSeAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YPtGlbfOhek7kyGmSLTW4S5wb/tN5rq46dW3ushdds=;
 b=nmR0tfo0eHGpYGcsnZHIXqPJEsU+2k8AvPxatGJeNKvF2YK1XCFgrWfBxDigzMGo2sUDMfxs/CLwQNd6sNzHOfEos9z8z4tOIeiBu5lgBhOI9ZKitTFVylLNETX5aJk87qHDQL9wkPwYEFzk0sLgYoL9mFZca/6tmMdZUFXhD9KkPp34aLE3q3WEe1SGKVlsRjDThoWsxq6AJUIBL/onpDeUbKaYyp1efRvk2+FHJVRRPGAIAhRf9HPcjb7kiIfJir5Qj3pFdDxfrpBKy4xOjpKAua181s/vW2ZQbLLnx/y/gLQ2Zv4BUsKeRTV+fzV52+TWk0PhAWmY31Vw66VXrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YPtGlbfOhek7kyGmSLTW4S5wb/tN5rq46dW3ushdds=;
 b=IfNeqAB77NH8VFvWSJs84FDMjkPqTfEP1ufT0u3VVzF6NUtv1ht4D0pYCSlro3K1e4tPYYe4RWlA9jNlrtH0ZvaA5uzhobhV6hgQ6BbHy//iGlpFkAxl9IkcR0p4ltohSiel+8adtzAZKgY/Fngf6+inVDxcBRnnhzrO1v0uz8w=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by BE0P281MB0116.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 09:42:56 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 09:42:56 +0000
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
Subject: [RESEND RFC PATCH v2 04/14] lsm: Add security_dev_permission() hook
Date: Wed, 25 Oct 2023 11:42:14 +0200
Message-Id: <20231025094224.72858-5-michael.weiss@aisec.fraunhofer.de>
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
X-MS-Office365-Filtering-Correlation-Id: 25109b51-b884-4bf4-bd14-08dbd53ec457
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qKuTr92LRkKjBsNEJJug/7v2Tf1byhv63SiyvdpcP+m3j7CImijZwvx3ytKTpUzsoU3CnoU4tE9hj9c0YXRHzHhxkkbkeYb4JjU5KKMcOdSjykVcutIT94AxAMWsfpwNXD1OmbZWPWT8Q+NU2rhXFM+m1uU7rdX4QGgIH0+vWVcabtHrpmwuh3wWHrRblimEiXCiZYb3EqUOl65Bjo/7jPiQGXdqoV4PB8KN3J4AiuHkLWU/r3izOgiSIWqLyARrxcAzdpaL02bWZDDjgMPEmAG1GT4RpFf/ucswYUAVFX8nyUsZNhT5Ln34oiTQwI92bZLQoX9MPq8qKcZUxo/NR5OU2r9nnXi37ZhRz7ly2TZES6KdU3s1GpBNtJo8+fBQpwbEClOLgxWgELHwGh5yCv20x7BsrGQNKH/t1TwDymTfAQ8efOleLIsGGBbSq1mTUdpHjOCdBZmlgT4f1Fg2eAIRsspCzFAvqnpxyeOzbBt6PjKHOnOWGmME06edN/epAaT40TzAS1FmG1v4xJHlNv1VIuEfefg/zY4ApsZssZMNz9EzplEvmO4rWPzxw/TOb5VeDemizYq8KX1zIRwvy66xsuHSTvCTi4TEVNoHcSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66946007)(83380400001)(316002)(38100700002)(6486002)(478600001)(6666004)(54906003)(110136005)(66556008)(66476007)(1076003)(107886003)(52116002)(6506007)(2616005)(6512007)(15650500001)(7416002)(2906002)(86362001)(4326008)(8936002)(82960400001)(8676002)(41300700001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHdaQkg4TnlSbFplZGxxYTQ4QUhzQ0xoaGZqa05PV000d2x6WDJiYlErcW05?=
 =?utf-8?B?SzBCWDBRYjRDMjZGMUkzVWI1RkhQSjNJY2dxa3NMMEt6TXlnb2RrTENIT3pi?=
 =?utf-8?B?a2d0eWFCMnA4NUJOaUlOMU4rb1lHM2h5bGRnQnBKRHNxZ1JGM2xpRHlzcS9u?=
 =?utf-8?B?RE1VbEJUSXZYcmdtU3QyMzlocnFEZnRHSCtzZ21OaTFlY2k4dWdzRXlLZWFh?=
 =?utf-8?B?VFc5RVg5MEt1OGxFQTVDQzJma011YTRTT3diSnlqT0ZOdW1IWGVBanpISVBR?=
 =?utf-8?B?RCs5RGxXdUxLbkVXOGRrVkZCSGdhWlE2eXJqS0ZXV2RyVXRrTzMwNmdWVDYy?=
 =?utf-8?B?YnptbVZpTDgyVjZ4bDRGNGNoN0sxZXAzbjl6VlhqQVdaQWd0QlB2cWZJSXpa?=
 =?utf-8?B?dWxBcjdRTGIzMTF2TFB4NWRuOWY1TDZOKytjT2hOd2pwdlk0VS9zZ0lOQ3hj?=
 =?utf-8?B?SXptaVAvVWFudnNCTnJJblVzT1k2eEFOVEl4WFB5SWFMTi9BUkpBSXhyTkRQ?=
 =?utf-8?B?M1lWci95NDJ4YU15MjNYZFJtVHdLaFFaTnJCbkU5US8xRTdYVnU0Y1U3eEts?=
 =?utf-8?B?TTYzUGFxMTJiZmtLZEJZSEJoS3NXblpmRUplS1hpa2lBY3c5dUdaaTFNRUJC?=
 =?utf-8?B?a3hIK29tQ0haRk9neHhNYklvUE5sU1h0R1crMndteHRtc1FpZmQ0Q3l5VXFW?=
 =?utf-8?B?SXdIZ1pJNkV1UHllcVBxY2RiaEF6NWljNzVrZDhvV0xBQVZ0YWQwTnEyTktU?=
 =?utf-8?B?NHQ0RFdONkl0aDZsOE8xRG1XZEM3YktxTCtxbFFBNW5hZklPd1JwQlFkcFpJ?=
 =?utf-8?B?cWFGOVgzUlhrdTVnWklkbjhrcU1mYm1FOVVRSHl0NDltNWFtMTNaNHNnMWdU?=
 =?utf-8?B?ZDlZNmZwaGk3S1ZyVGFTU1pQak4xTlM2b0V0NkU5aGkzS00vZDBWdXFjRTdU?=
 =?utf-8?B?OWtPeUdGNDl3WUw2aEU3UUV5cmV1RllCVzZaNytTYXdsN2FsL1ZZMFdBa0NY?=
 =?utf-8?B?QW5wZFc5OUFqUU9UUWNQc1lRTVpGWjRibU9ZYjZnS3ZZVlVCdlNvVVpzbzBI?=
 =?utf-8?B?Nm5tOEl2VG5PSFFldUdjNi9kbXR3YjUvNGR4dzJnSThEU1ZXMUpSRXdvS0JY?=
 =?utf-8?B?NE9lVXRaVjk0SmpDVWtmYmVobTFsVTYraGZkNTViRHdkOHMxRHVMS05CTldi?=
 =?utf-8?B?ekJrN1E0TFUycHQ3WDQ0TTQxZ01odU1vMUx5RTZtcEJYUmJWOTUvMmthWDZB?=
 =?utf-8?B?SmVEdys2dDltbVZ0VnM5emZYOUhmbEowUUsvekFqTHZYQU5WN1RQVmtzUkJT?=
 =?utf-8?B?dWZ4WEdaaXlWa2JsUXFHcDNsS2p3TDVnTEc2KysvQUNJbFlkWStlOE5rUVpN?=
 =?utf-8?B?alN4dmlSODgwM0J1WE1zNUhjczlKTlU4QStiRzczc0huTmJudVM5QXJHcU9B?=
 =?utf-8?B?WnVOY0tnTDNtT01lc1BaekIrVXJTUmQyZ1NzOHhObGNmM3NXRTg5R2hTeVJW?=
 =?utf-8?B?NmRCaHJva0lWdi9KUFFNRnRsQWN5T2dkSU5Jb1FkeWFYbFFqNmMyaGJZSndO?=
 =?utf-8?B?S0FpbWlJTGdxZGZzbWRZbDdTdkdWVzBSc2VaZGtmbDlaNFM1Nzh0RG85M0dV?=
 =?utf-8?B?VUxidmJMVkNqTnZ0ZVFHeFB3bGxxSjI1c0psRmpVZ3R0U3AyUyswWnIzWHlp?=
 =?utf-8?B?aEF0WkVGSVVVU0dQa1VLYlhvZXRISmw3MmtZVE82UTRiRTN6cFVSM2JkYmJG?=
 =?utf-8?B?VXlhaHZjUWVsZXFhYitMK2d5a3R0VjlLazNNRnV2cGhSOHFRdDVUamEwL2t4?=
 =?utf-8?B?dlA0a2RGWlFmL1dTMG9WL1hoUUVIbVI3S0lLU1htNjBJcmdXT000N1JRSWNi?=
 =?utf-8?B?dzRBU1ZXZEpDOGVxTDM3QUt6d0xEci9CZTQxZjN2aERXRVFhbE8yTWhUMnE1?=
 =?utf-8?B?T1dzUmJpdDZGbTd4U0FSQmkxd1hsNGhnMnVhN3QyQTJUeDZ1WHF5OXlyUEIz?=
 =?utf-8?B?WkVLS2dIc3RpR0Y0Z1Azdnh6SnpMallkdkNDeHJ0ZVhUNkZFWHRkSHpDV2tr?=
 =?utf-8?B?ZWwwdW9ycm9OMVl6dFcxRi9VZE1qSEppbzNOaTZxdHB6SWNjVHJUdUpHYk5T?=
 =?utf-8?B?clE3akdxc25TQVNSZU5qREJQaFpIcmxjVXF0RlkyWC9OQ091TzFBS21JbjVI?=
 =?utf-8?B?VGZEVUoxOXNZcFo2U25VZDdmVnZkR2RjTkJOMVpKdzdwSThiNzlkQnArb1Bq?=
 =?utf-8?Q?aPNNGCNsWnnys0/gepIGAAicK4TyHvTeXFN4n2V+nA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25109b51-b884-4bf4-bd14-08dbd53ec457
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:42:56.3254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNQFbFkTT2YqM3/5C6BGsxNfAQU+B4F02gvmmxjusFyHMl7TPimZLaGldB65yPFx3B4pfTH1ZCNJWJtCNkcX5NzcxOQ/QCEdmJnTxa/XydIt0Q882WfPYW/s3frcqXx2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0116
X-OriginatorOrg: aisec.fraunhofer.de

Provide a new lsm hook which may be used to check permission on
a device by its dev_t representation only. This could be used if
an inode is not available and the security_inode_permission
check is not applicable.

A first lsm to use this will be the lately converted cgroup_device
module, to allow permission checks inside driver implementations.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  5 +++++
 security/security.c           | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ac962c4cb44b..a868982725a9 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -275,6 +275,7 @@ LSM_HOOK(int, 0, inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen)
 LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen)
 LSM_HOOK(int, 0, inode_getsecctx, struct inode *inode, void **ctx,
 	 u32 *ctxlen)
+LSM_HOOK(int, 0, dev_permission, umode_t mode, dev_t dev, int mask)
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
 LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
diff --git a/include/linux/security.h b/include/linux/security.h
index 5f16eecde00b..8bc6ac8816c6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -484,6 +484,7 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
+int security_dev_permission(umode_t mode, dev_t dev, int mask);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1395,6 +1396,10 @@ static inline int security_locked_down(enum lockdown_reason what)
 {
 	return 0;
 }
+static inline int security_dev_permission(umode_t mode, dev_t dev, int mask)
+{
+	return 0;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
diff --git a/security/security.c b/security/security.c
index 23b129d482a7..40f6787df3b1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4016,6 +4016,24 @@ int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
+/**
+ * security_dev_permission() - Check if accessing a dev is allowed
+ * @mode: file mode holding device type
+ * @dev: device
+ * @mask: access mask
+ *
+ * Check permission before accessing an device by its major minor.
+ * This hook is called by drivers which may not have an inode but only
+ * the dev_t representation of a device to check permission.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_dev_permission(umode_t mode, dev_t dev, int mask)
+{
+	return call_int_hook(dev_permission, 0, mode, dev, mask);
+}
+EXPORT_SYMBOL(security_dev_permission);
+
 #ifdef CONFIG_WATCH_QUEUE
 /**
  * security_post_notification() - Check if a watch notification can be posted
-- 
2.30.2


