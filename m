Return-Path: <linux-fsdevel+bounces-1150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3027D6752
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 11:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13171B2107B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 09:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25135273D3;
	Wed, 25 Oct 2023 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="3THhlKvI";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="DeY+m+M8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3624923759;
	Wed, 25 Oct 2023 09:44:20 +0000 (UTC)
Received: from mail-edgeka24.fraunhofer.de (mail-edgeka24.fraunhofer.de [IPv6:2a03:db80:4420:b000::25:24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76B3128;
	Wed, 25 Oct 2023 02:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1698227057; x=1729763057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=tlRlv8SptwBYts2cjF86uNCt02+ed/rSd9mi5MNlHwE=;
  b=3THhlKvIRhGFtQFVbZHQIrRX/zD8FbYSKqkenNe06Efyh2eg6FqGWBcc
   fdy6JKNeQEQxCT9FLee7csTIjRdh/mJ1SXQpNQaY0a3/8sHyhE3Dfh4xh
   /6Fz+yV3Hy/0V0PbK0q5xq7SF0ZLQJ9QKZ3Zl42wD56X7AMGw0pwdzo2z
   FgNcRmXT7VSaLpHHqEVy+o8rx6emQwInntTXTsztmY8JyPVv/stP6mdmW
   V793lqFKBxZYyCcmJwkXePUA5DUOW8MkDo52tPMRxk1bhYqIPG+VvSSMW
   YBU9f8vda7vN64X/eLbVPUhq1c+5FNOqGmsjN2DuO0WoCaCCsAxbsUUkL
   Q==;
X-CSE-ConnectionGUID: X5z6DShRSF6mhsKDMkc/bw==
X-CSE-MsgGUID: us5IRIdjTkKClrNB+xe6RA==
Authentication-Results: mail-edgeka24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2H8AABB4jhl/xmnZsBaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YI4gleEU6oEhAQqglEDVg8BAQEBAQEBAQEHAQFEBAEBAwSEfwKHGic3Bg4BA?=
 =?us-ascii?q?gEDAQEBAQMCAwEBAQEBAQECAQEGAQEBAQEBBgYCgRmFLzkNhACBHgEBAQEBA?=
 =?us-ascii?q?QEBAQEBAR0CNVQCAQMjDwENAQE3AQ8lAiYCAjIlBgENBYJ+gisDMbIYgTKBA?=
 =?us-ascii?q?YIJAQEGsB8YgSCBHgkJAYEQLgGDW4QuAYQ0gR2ENYJPgUqDM4RYg0aCaIN1h?=
 =?us-ascii?q?TwHglSDLymLfoEBR1oWGwMHA1kqECsHBC0iBgkWLSUGUQQXFiQJExI+BIFng?=
 =?us-ascii?q?VEKgQM/Dw4RgkIiAgc2NhlLglsJFQw1BEl2ECoEFBeBEW4FGhUeNxESFw0DC?=
 =?us-ascii?q?HYdAhEjPAMFAwQ0ChUNCyEFVwNEBkoLAwIaBQMDBIE2BQ0eAhAtJwMDGU0CE?=
 =?us-ascii?q?BQDOwMDBgMLMQMwV0cMWQNsHxocCTwLBAwfAhseDTIDCQMHBSwdQAMLGA1IE?=
 =?us-ascii?q?Sw1Bg4bRAFzB51Ngm2BDoJ0lhIBrnkHgjGBXqEJGgQvlyuSTy6HPgiQSCCiP?=
 =?us-ascii?q?oVKAgQCBAUCDgiBeYIAMz6DNlIZD44gOINAj3t0AjkCBwEKAQEDCYI5iRIBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23:cSN9DxzDyXu5w63XCzKPy1BlVkEcU8jcIFtMudIu3qhVe+G4/524Y
 RKMrf44llLNVJXW57Vehu7fo63sCgliqZrUvmoLbZpMUBEIk4MRmQkhC9SCEkr1MLjhaClpV
 N8XT1Jh8nqnNlIPXcjkbkDUonq84CRXHRP6NAFvIf/yFJKXhMOyhIXQs52GTR9PgWiRaK9/f
 i6rpwfcvdVEpIZ5Ma8+x17ojiljfOJKyGV0YG6Chxuuw+aV0dtd/j5LuvUnpf4FdJ6/UrQzT
 bVeAzljCG0z6MDxnDXoTQaE5Sh5MC0ckk9oDyH940joAYzK6gLVqOYhxjCTE+3sFqoVYGWv1
 aVKQxLHoT4pPDNkq0CH358V7upR9T6sll96gKuEPtilbdBBc4XMV9QcflgeUetheSJCHsClT
 6kMBfINFP1cn6/Nn1Uls0uCLAO0Ce7lz29UxVHUgYR936MnGwzlhwUKNNwAuliEkOfkNuQMA
 cun4ZfS1G+cQdIN/Re+uYr4fDlx+a2RZrdtaPvI5G0ITRneq0S+qIDmBGLW+98DtUmrrNdbT
 fz310NglS1VhiadxecF2qn21qAswWyc9z1YwdcrKojrAF4+YMSjFoNXrT3fLYZtX8c+Fnlho
 z1polVnkZuyfSxPxZgoyh3WMaDBfZKB/xTjU+icO3F0iSEtdLG+gkOq+FO7gq3nV8ay2UpXt
 CcNjNTWt34M2hCSosiKQ/dw5AGgjB6BzQnO7OFDL00u063dLp8q2LkrkZQP90/EG0fL
X-Talos-CUID: 9a23:LBsvp2F37yfBPum+qmJXqVxKNvslSEbzknLQOGyULGViD7eKHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AbTtK3w726eq4v83gjNEzWCMTxox1+PmPMmEBk6k?=
 =?us-ascii?q?FmOKALwpaeCeQ0g6eF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="1802524"
Received: from mail-mtadd25.fraunhofer.de ([192.102.167.25])
  by mail-edgeka24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:09 +0200
IronPort-SDR: 6538e32d_b/52dP1ggGLqKsCp8ZDpm+8+pOPPzqR6dSt1kc8MYf50BLo
 6kwysTKcVMWjf+Fs5yWMeUS4TeWBhcy51vcERfw==
X-IPAS-Result: =?us-ascii?q?A0AbAQC94Thl/3+zYZlaHAEBAQEBAQcBARIBAQQEAQFAC?=
 =?us-ascii?q?RyBGQQBAQsBgWZSB4FLgQWEUoNNAQGFLYZBglwBl2qELoJRA1YPAQMBAQEBA?=
 =?us-ascii?q?QcBAUQEAQGFBgKHFwInNwYOAQIBAQIBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QYEgQoThWgNhk0CAQMSEQ8BDQEBFCMBDyUCJgICMgceBgENBSKCXIIrAzECA?=
 =?us-ascii?q?QGlMAGBQAKLIoEygQGCCQEBBgQEsBcYgSCBHgkJAYEQLgGDW4QuAYQ0gR2EN?=
 =?us-ascii?q?YJPgUqDM4gegmiDdYU8B4JUgy8pi36BAUdaFhsDBwNZKhArBwQtIgYJFi0lB?=
 =?us-ascii?q?lEEFxYkCRMSPgSBZ4FRCoEDPw8OEYJCIgIHNjYZS4JbCRUMNQRJdhAqBBQXg?=
 =?us-ascii?q?RFuBRoVHjcREhcNAwh2HQIRIzwDBQMENAoVDQshBVcDRAZKCwMCGgUDAwSBN?=
 =?us-ascii?q?gUNHgIQLScDAxlNAhAUAzsDAwYDCzEDMFdHDFkDbB8WBBwJPAsEDB8CGx4NM?=
 =?us-ascii?q?gMJAwcFLB1AAwsYDUgRLDUGDhtEAXMHnU2CbYEOgnSWEgGueQeCMYFeoQkaB?=
 =?us-ascii?q?C+XK5JPLoc+CJBIIKI+hUoCBAIEBQIOAQEGgXkmgVkzPoM2TwMZD44gOINAj?=
 =?us-ascii?q?3tBMwI5AgcBCgEBAwmCOYkRAQE?=
IronPort-PHdr: A9a23:yLG4uBSo74peuRLfCfJvHvuoLtpsovKeAWYlg6HP9ppQJ/3wt523J
 lfWoO5thQWUA9aT4Kdehu7fo63sHnYN5Z+RvXxRFf4EW0oLk8wLmQwnDsOfT0r9Kf/hdSshG
 8peElRi+iLzKh1OFcLzbEHVuCf34yQbBxP/MgR4PKHyHIvThN6wzOe859jYZAAb4Vj1YeZcN
 hKz/ynYqsREupZoKKs61knsr2BTcutbgEJEd3mUmQrx4Nv1wI97/nZ1mtcMsvBNS777eKJqf
 fl9N3ELI2s17cvkuFz4QA2D62E1fk4WnxFLUG2npBv6C7f9mxP17/giwxLCFOLoQewqQD2Mz
 70wUj7R2So9NR8y/U7+k+J7gf8AgUL09Hkdi4SBTIykd/89W/ODJONDb1VMeNd7UCp6MNyzQ
 rshAekdfv94jYr3v1cnth+OIzmUCsjxmgNhjGf70Kc/g/hiPyOa9UssWNQEvVePpf/eOqkYf
 bCJ/rjKjiuTROF75y3kstfmU0sFgbLdX4J+WJqJlVQUEh7cv0y9jau/JSiwx8oMv2ugvqlNb
 uypql5kljppvGDz64ASpq3tmLAW6nmU1Rop4r8+GYW6UG96MMCrRcgYp2SbLYxwWsQ4XyRyt
 T0nzqFToZegZ3tiIPUPwhfeb7mCb4Gkzki+EuiLKCp+hHVrdaj5ixvhuUSjy+ipTsCvyx4Kt
 StKlNDQq2oAnwLe8MmJS/Zxvw+h1D+D2hqV67RsL1o9iKzbLJAs2Pg3kJ8Sul7EBSj4hAP9i
 6r+Sw==
IronPort-Data: A9a23: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
 W/sDX64i4xMNqf/ZYNy0z7xvZJJNA==
IronPort-HdrOrdr: A9a23:V2UiFqBJ1v8dKhblHehOsceALOsnbusQ8zAXPh9KJiC9I/b1qy
 nxppkmPH/P6Qr4WBkb6LS90c67MA/hHP9OkPQs1NKZMjUO11HYSr2KgbGSoQEIXheOjdK1tp
 0QApSWdueAdGSS5PySiGLTc6dC/DDEytHTuQ639QYScegAUdAG0+4WMHf/LqUgLzM2eqbRWa
 Dsrvau4FGbCAEqR/X+IkNAc/nIptXNmp6jSRkaByQ/4A3LqT+z8rb1HzWRwx9bClp0sP0f2F
 mAtza8yrSosvm9xBOZ/2jP765OkN+k7tdYHsSDhuUcNz2poAe1Y4ZKXaGEoVkO0aqSwWdvtO
 OJjwYrPsx15X+UVmapoSH10w2l6zoq42+K8y7uvVLT5ejCAB4qActIgoxUNjHD7VA7gd162K
 VXm0qEqpt+F3r77WvAzumNcysvulu/oHIkn+JWpWdYS5EiZLhYqpFa1F9JEa0HADnx5OkcYa
 VT5fnnlbdrmG6hHjDkVjEF+q3uYp1zJGbKfqE6gL3a79AM90oJjXfxx6Qk7wM9HdwGOtx5Dt
 //Q9ZVfYF1P78rhJ1GdZQ8qLOMexTwqDL3QRSvyAfcZeg60jT22trK3Ik=
X-Talos-CUID: 9a23:AOnfv2Bu+Hkqj5/6Ey5N6l4sKv0XSCWD8U3bI0zlDVh7d5TAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AngP/Rw6xooopnBfYduwjm8PMxoxjvpS0S2Euka4?=
 =?us-ascii?q?MutbDNHd0OA6SqW+OF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="188491615"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaDD25.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:08 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 25 Oct 2023 11:43:07 +0200
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.169)
 by XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Wed, 25 Oct 2023 11:43:07 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7pGiGztWSHWs7VchjmqAumX84Y9CO3UgbEZCikIa2hcRotO70DBYDKdqq78dJz5axnXilrNWN16JvhlxhxsOzhrG/buDJ609c+Q2aLBtMJPr/jOzC/P8BKPxLlInOryZT1s3VVA3HadqD9sqPoOXrTBwBc08ue5Kf8EnatBBHUz7uWz+KywAhgfx6I1oTF8P5+as+UWvONWAtG2HlOFy30fSdAakcpGeMlhB27trnQEkD3JmIyujT5ycBWAoQ55TJiQelBqsl/t/TyELe5lVj9LBa/EomcBhE56PU/rg+eAG7FKHyRUJrw9J9MlWoplhkySkcQR1PFUcbajgexQfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdAPg1z7sS0AGvd4vqaFHr3rIQ9eRjIceGAqFce53I8=;
 b=VbWUJoY2+2fjcXUfqYqNNuz3w2HZv8eIIacaYPUS1ghcvUqZBor24c/WeXBnmrtSkq3OfjXfzbF45jncvfPBt56Sp2CJqG45qbbcqTTjnxdZbl5hF3QtenRsXsTDsszna9LvLjb2qn9O+aaTYQ8gSBKlArI/Iru5YghgHVJr53zu9N0O1SV/iTgltiG3iQH34muxotImkFgh+SuMcjLWW40kS7PRLe9nQVC3pxdB/oebNqgEAs0GZNJf7xkOsVeBLcrg0BocgIeateTGb5yKTU7yCSITwNpq0BupCqUNBTf91U21iAYzLLlF42f6/xnyKn8nqtaEH/9fqY7cwS0BIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdAPg1z7sS0AGvd4vqaFHr3rIQ9eRjIceGAqFce53I8=;
 b=DeY+m+M861X1BWeNyBonSZ7gEXFfkt+qHJkbpdAslXNXPfCv8TAbpeebm8t+FJ4A/d/nbeK3aBCffbD8TZyj+v8CzEVrq27FI3LH+9jXfA804uSmuqYqELO2rsMyFidkS9+ESfnIX+USpv04E/VDLLvZkHA8HW8JQcT0jpIi9vg=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by BE0P281MB0116.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 09:43:06 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 09:43:06 +0000
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
Subject: [RESEND RFC PATCH v2 12/14] bpf: Add flag BPF_DEVCG_ACC_MKNOD_UNS for device access
Date: Wed, 25 Oct 2023 11:42:22 +0200
Message-Id: <20231025094224.72858-13-michael.weiss@aisec.fraunhofer.de>
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
X-MS-Office365-Filtering-Correlation-Id: 82c39ad8-a557-480b-9859-08dbd53eca1b
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jY/SBV1iK7Scw2xqGFz3YbLeilwnDgW0w7dH5GXvsLuGeriEagVdlOP/VG0IobOQqDtJ9NHOCVHBWHVHCC/Ktv99AStyJATndzCRcFyphwwaA2f1Nr5bQ2KSXp9UF+VxbYd24ZlXADZQqEOYJjbIsrNhd34ip+D6+XgH2X2Y/OgidbbrHVPWT3nAUPkrLTLKJDZ0VSMAcH57DwIhWrdKrFgaJqUY4qnCGFQwNvyTp0N6riPUwrcUBij4iSsjOO3RHcDue50+Eum+qXLK1SCwblNEwzat8gSvB3QmqhAOXS1FYiyIAqTYftHPN9M/x7A1ZSMqJm5C43W/UEOv7jsO2XXnTOJuJhlWmUd0rw3Jd3NWPAwxYaZXs51wa7Zpcp1u2O4CILzOOrVsJUAK1Tagsb8YDB6BH4U8MOe9rbxiBTl5kqu3yN2tDf5AChssTIkd6y1uhgE+tfIXkpzT+A2XfnwYXf/6p2f1SEnudUHMrLb39uvUvtmCdEaqU3Nu71/yptL65WInpdjaSmjCL0WLQAP0waX0+yVpxzX5S1qoixx/+ugQzgcbFKP9QskSqg0CSFr9qU3Q1OWc95LbqWZO/4QWg7TEq29eVII4gFpqtS8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66946007)(83380400001)(316002)(38100700002)(6486002)(478600001)(6666004)(54906003)(110136005)(66556008)(66476007)(1076003)(107886003)(52116002)(6506007)(2616005)(6512007)(7416002)(4744005)(2906002)(86362001)(4326008)(8936002)(82960400001)(8676002)(41300700001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFNhVW1XaHNjbkdoZzZxRzVWWkZkcFQrTUJ5Snh2UWRmUHFIdDJaR3gzclFx?=
 =?utf-8?B?eVZoRk14QndFL1Q2K3pnTDkwWkRBeXIrcVFVOGFFOGJDaThieTFTNm9sakpR?=
 =?utf-8?B?QitEb28vQm9ZdlBJWVVhQVUycjdQWURVWjhxZEpvV0l5ZXkybmVnQ3RSOExa?=
 =?utf-8?B?cC9rZmhhTjdFcEgxZDhJek1tbWo1aHdQVzZIUU5Fb1ZIQXlUNlRoZWJCZWdu?=
 =?utf-8?B?bko3bEFwa3R3RGZBK0hWdTRWL3Z6dDNGTDhNeitSQit4bDZpWitFd2wzQ1Fm?=
 =?utf-8?B?WXhnamRiNkVyZ29FQnZzanhyMy9NZVVQMk1FUkFpaU81a0VVU2N4bTNMWDZI?=
 =?utf-8?B?TVBJQ0s2Z0tvM3ZLb0FrdDU5MWc0elMwdkhZQllRcEtnWUJ6TkQ3bzQ1Q01N?=
 =?utf-8?B?WkE0L3N3QlNjWVBsbUNKWXhMWW1aUjlvbmZoV2Y0cGl6alB4Snc1bzRaakY2?=
 =?utf-8?B?UFV1VHNOaEJTSU1oWk8yVHo1SGJyWkJHbTRudTU0TGovYlZndWRnNDA5cmZi?=
 =?utf-8?B?ZnB6N2VGNnMyZ0NUSy9JdFlUN0xBMDBJTHc2ai92QUF0NThKQUJSR3JtNVpD?=
 =?utf-8?B?NTRlVjRRTllSbFl0Ym9KVXJ2bHdtRWphT3ZFbHo3VXdneXhDaDl1b1RIb2Rj?=
 =?utf-8?B?NUZRUStkeFJRNVEzZW4xNWFoYS9YMzV3SldiQnY2dmp6TzN3L3d5RnJIcXc4?=
 =?utf-8?B?eHRyUzV6aEdKYi9oRS9FUDhEeDI2V0h5aTczSW13TmRVSFQ0Y0lKbDcxK3Iy?=
 =?utf-8?B?R0UrQUFCcTFrUlU0TDAwY0t2Nm1uUjdLWU9BV2RJL1NXTWgvZDJldzRKMU1t?=
 =?utf-8?B?VmFxdmF0eFF3RmhmUkZXT0N4YUlEdm1BZTZkNC9xWHdYTHVycGtkQWNmODQr?=
 =?utf-8?B?S1d5WWVVZzJDd3d2UkVEamxMS051d2lqTjExYUpoTWU2VGRKQWJkeGNxOHpJ?=
 =?utf-8?B?UUNyVERqRTV6LzNaWEE3WTVTWTA3Wm00L09WVHpuNkh1MXp0bXo0RDJ0MStv?=
 =?utf-8?B?SGVnMlh6ZHFxNGVPWVJOZURlVDBlNERRaWRUSlhjY3JDckpIZXhLb0hSK20w?=
 =?utf-8?B?dGYrVGg0WHpEc1JYbStxblhuU3I0TFJ3dk1SRVpXMi90V0VURGN2RkVrMlpk?=
 =?utf-8?B?eGU1ZGtWT243SG1HYXJKZXF4QXBBK2tLbW5rUW9HTjBwb0FtMEg5QVBDU1Q0?=
 =?utf-8?B?cHZxai9tLzcrbHFZZDRqTzFlR0Z5SmRzdjRlWnRQcGxueWh3WGg5bjlpWmpL?=
 =?utf-8?B?QjZkeVRCSlZuUWYzWDNxQlJXWDN1ZG5DWVNldkVtOGhDUG1ZVWlKMjZGT1dn?=
 =?utf-8?B?d3lsNFpaZFNIR1poSnAzaWYzVzJFSmo0V1Z0RnVFRnd6MWdCQlpSendkWFov?=
 =?utf-8?B?Uzlua3o2T2JRdVFrQnFDNGJNZlNpZnZHK2c0S0NrcU5KblJhWk5wS2VsTWs3?=
 =?utf-8?B?SktBMDRkanlLRVo1dDN5L2twY1B3R0lXcnh6N1FBMlhyanZzTnovUEtIQXEz?=
 =?utf-8?B?QkJjS05vVHROYS9sakZSRVFPNWZvekxrd1JRRjEvN3h1Rm5admVqU3d3bWdS?=
 =?utf-8?B?VWFmL2RIVU03UU5IVUl2SGZ4RmJiejAwWkVicGZ0RDlYS2lKM25iVHNSY2dI?=
 =?utf-8?B?T3crd0taQVBiWUNzcEtzRExVMFdVM3FvTEM4bVVzRHJmcE1YZWpucU5FVHp4?=
 =?utf-8?B?NzlkakZFRUpoM29mRVVUSGtpNFJ3Wm1CUFlpR0U2d1NvSEU1SSttdWt1MnNB?=
 =?utf-8?B?M3F6dGNydzIzUVh5LzdjbmZrK2ZMV1lGeVY1TllXbXZmK3B1d25VZ1hISjJi?=
 =?utf-8?B?MVZkTklLa3J3Mk4yTCtvTnRnRDMvM0JTbUtOZGtlWWNEajBHV2VmcVFHYVhM?=
 =?utf-8?B?VjJoMkc5VzRIQ3EwRllvcU52SEFnY2NaYzhPT1RReFF4QmlRYlNUWDVXZlBt?=
 =?utf-8?B?V3JXNHduNmI2UDFBVittWTlTYmhDZERUZUVKSWNjZ21EUng3cXAwQnBFWVB4?=
 =?utf-8?B?R2oxUW5seHBibks1a3pYdURlTnhqQ2VPQkJrcXBaSi9YQkViMENJMGYxeFF6?=
 =?utf-8?B?dnRJYXdtdHVmZVo5WnZuSGU2M0JEZEV1TzVvVlVoK0lUaEFkNGsveHl3TC9w?=
 =?utf-8?B?cjA1c2wwYzFNQUg5V1ErNnNQeEc1MlVtVGVLNmJmQmI2NFA5TEt2Y0pUOUhP?=
 =?utf-8?B?R0tHNktjUnl2aGgvZjJ2N2pjQS8xaFBxZTBIa2J2N204YloyVy9uTnRIUFBP?=
 =?utf-8?Q?IMLBl0LacPQ2zYb6LCOzND8Djg8svE7gcJ9rd0OCWg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c39ad8-a557-480b-9859-08dbd53eca1b
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:43:05.9749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARggjbMX13nOsPVFNakzq2jKHDqc6UAyDb+ZxMo4hf7sRjo026m+qhLCkJj34UbpVUbel2h50n153oT1n3lS8pei00gQNbKaYLBMA8hXZ1uIjJ00Va/ONokFnMitOKZa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0116
X-OriginatorOrg: aisec.fraunhofer.de

With this new flag for bpf cgroup device programs, it should be
possible to guard mknod() access in non-initial user namespaces
later on.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 include/uapi/linux/bpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0448700890f7..0196b9c72d3e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6927,6 +6927,7 @@ enum {
 	BPF_DEVCG_ACC_MKNOD	= (1ULL << 0),
 	BPF_DEVCG_ACC_READ	= (1ULL << 1),
 	BPF_DEVCG_ACC_WRITE	= (1ULL << 2),
+	BPF_DEVCG_ACC_MKNOD_UNS	= (1ULL << 3),
 };
 
 enum {
-- 
2.30.2


