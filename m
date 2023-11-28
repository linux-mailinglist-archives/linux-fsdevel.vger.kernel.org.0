Return-Path: <linux-fsdevel+bounces-4095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2637FC9B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 23:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 343AAB2136B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 22:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70735024A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="rVP+FC02";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="m4oCU8fb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeka27.fraunhofer.de (mail-edgeka27.fraunhofer.de [IPv6:2a03:db80:4420:b000::25:27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9321988;
	Tue, 28 Nov 2023 12:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1701204886; x=1732740886;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ERXBmyh7O8XEUTLLLwHK32AXZ0+CRRgJ9BFDi1bCAZk=;
  b=rVP+FC028608AXiGMB83s42+3orhtfld+smQk1vl9h1fGBvQoudkx+FV
   UQQAUz/nyTBSm7dAWA0S5siKiIa6iIu3JzZ/t18AZdnj2spRQg1DJ33Em
   Kx6OtEZSC3U9cDXaoP5hlmT8nOFF8xqsPJ8xojnTzKMR4KmsfekuZz0AN
   V1gn/ITL03zL2fa+OVq+3rdu8EL2+BElvGFQ+sjaT6nGBpmCdxf21nsI5
   S05mhfcMNtuRxA5ODVYFR/4NV29mF4fZLBlo9vNyYbrN8D57GpP7h7qv5
   hc5nlgJMawMRp+jtFOWhD9aAZZTHVwDBvjljqYT8aHv2aqEIGfpjShrRL
   A==;
X-CSE-ConnectionGUID: mb8VCoe3REuUtNaZ4w4CPw==
X-CSE-MsgGUID: ryec9kRHSPeB3Wg/PBzW9Q==
Authentication-Results: mail-edgeka27.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2ENBQAdUmZl/xwBYJlaHgEBCxIMQIQIgleEU5EyLQOcU?=
 =?us-ascii?q?oJRA1YPAQEBAQEBAQEBBwEBRAQBAQMEhH8ChysnOBMBAgEDAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQECAQEGAQEBAQEBBgYCgRmFLzkNg3mBHgEBAQEBAQEBAQEBAR0CNVMBA?=
 =?us-ascii?q?QEBAgEjBBkBATcBDwsYAgImAgIyJQYOBwEBgnyCKwMOI65hen8zgQGCCQEBB?=
 =?us-ascii?q?oJmrToYgSGBHgkJAYEQLoNchDEBig6CT4E8CwOCdT6ELSuDRoJogVOHUAcyg?=
 =?us-ascii?q?UlZgygpgz5lixtdIgVCcBsDBwN/DysHBDAbBwYJFBgVIwZRBCghCRMSPgSBX?=
 =?us-ascii?q?4FRCn8/Dw4Rgj8iAgc2NhlIglsVDDRKdhAqBBQXgRIEagUWEh43ERIXDQMId?=
 =?us-ascii?q?B0CMjwDBQMEMwoSDQshBVYDRQZJCwMCGgUDAwSBMwUNHgIQGgYMJwMDEk0CE?=
 =?us-ascii?q?BQDOwMDBgMLMQMwVUQMTwNrHzYJPAsEDB8CGx4NJyUCMkIDEQUSAhYDJBYEN?=
 =?us-ascii?q?hEJCysDLwY4AhMMBgYJZRcEDgMZKx1AAgELbT01CQsbRAIno0UzEQIPLRtSg?=
 =?us-ascii?q?QsWNAx3MpJCRIJcAY1OoS8HgjGBX6EPBg8EL4QBjHOGPJJVLpgSomEzC4UMA?=
 =?us-ascii?q?gQCBAUCDgiBeoF/Mz6DNlIZD1aHdYVVOINAj3p1OwIHCwEBAwmCOYY2gXMBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23:EoFkNhVdqjTa9JVrZUtsS7OuL/XV8KysVDF92vMcY89mbPH6rNzra
 VbE7LB2jFaTANuIo/kRkefSurDtVSsa7JKIoH0OI/kuHxNQh98fggogB8CIEwv8KvvrZDY9B
 8NMSBlu+HToeVMAA8v6albOpWfoqDAIEwj5NQ17K/6wHYjXjs+t0Pu19YGWaAJN11/fKbMnA
 g+xqFf9v9Ub07B/IKQ8wQebh3ZTYO1ZyCZJCQC4mBDg68GsuaJy6ykCntME2ot+XL/hfqM+H
 4wdKQ9jHnA+5MTtuhSGdgaJ6nYGe0k9khdDAFugjlnwXsLs4iH86+1b0gfDENHWFYhsRHOI8
 bV7axn0hx4sCywd6VHOh9EqspocryyQ8k8aocbeNYTJM9FDLq3XIss2HElOBOt8fhdOJKSeX
 rJfJc5ZO8tlpaz2uEYWrEGUIFmsGdKw0BFVh3T2gO4//Px/TR6aww97T4MLjn7f9dHpOaASb
 eLvkI2P5BTYQtJc6xXe7KTLWSIcn8yeWZ1Ae/Xc7lkdJi/0h0ec9N3dM3CT2+kPuWeA7MphV
 9+p0WNgsy8uqReK9/4LpKvOpY8b5XLD+nwgzIVpKszpEkgjccSFKc4D/zHfNpFxRNslWX0to
 ish17ka7IayZzNZoHxG7xvWavjCfoSH7xHqDrnXLy1xmXRlf7yynVC+/Bvoxu79U5ys2U1R5
 mpek9bKv2wQzRGb9MWdS/V880vgkTaC3gze8KdFdGg6j6PGLZ4mzLMq0J0VtEXIBCjtn0vqy
 qSRcy0Z
X-Talos-CUID: =?us-ascii?q?9a23=3AmczO7WuamYEHtaK4kh+6HIDr6IsgeC3j53DdeHW?=
 =?us-ascii?q?VFFt1brSnFUDM05t7xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A9bnJOQ9jUIEPAW+UTX6kQPKQf9157q//C3otqq0?=
 =?us-ascii?q?LkZK7OmtIESWi3Q3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,234,1695679200"; 
   d="scan'208";a="3933417"
Received: from mail-mtaka28.fraunhofer.de ([153.96.1.28])
  by mail-edgeka27.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 21:54:43 +0100
IronPort-SDR: 65665391_hjAhPuCH5gpTxJhlXneipJuKg+PLwXh0b218VmeA042Ofz5
 kmUMn+Eb0RC3qhaINzmLj/kbxocrESZ8SNOnyIA==
X-IPAS-Result: =?us-ascii?q?A0C+CwCNUmZl/3+zYZlaHgEBCxIMQAkcgxFSBz6BDYEFh?=
 =?us-ascii?q?FKDTQEBhS2GQoF0LQM4AZwZglEDVg8BAwEBAQEBBwEBRAQBAYUGAocoAic4E?=
 =?us-ascii?q?wECAQECAQEBAQMCAwEBAQEBAQMBAQUBAQECAQEGBIEKE4VoDYZFAQEBAQIBE?=
 =?us-ascii?q?hEEGQEBFCMBDwsYAgImAgIyBx4GDgcBAR6CXoIrAw4jAgEBoncBgUACiih6f?=
 =?us-ascii?q?zOBAYIJAQEGBASCXq06GIEhgR4JCQGBEC6DXIQxAYoOgk+BPAsDgnU+hC2Dc?=
 =?us-ascii?q?YJogVOHUAcygUlZgygpgz5lixtdIgVCcBsDBwN/DysHBDAbBwYJFBgVIwZRB?=
 =?us-ascii?q?CghCRMSPgSBX4FRCn8/Dw4Rgj8iAgc2NhlIglsVDDRKdhAqBBQXgRIEagUWE?=
 =?us-ascii?q?h43ERIXDQMIdB0CMjwDBQMEMwoSDQshBVYDRQZJCwMCGgUDAwSBMwUNHgIQG?=
 =?us-ascii?q?gYMJwMDEk0CEBQDOwMDBgMLMQMwVUQMTwNrHxYgCTwLBAwfAhseDSclAjJCA?=
 =?us-ascii?q?xEFEgIWAyQWBDYRCQsrAy8GOAITDAYGCWUXBA4DGSsdQAIBC209NQkLG0QCJ?=
 =?us-ascii?q?6NFMxECDy0bUoELFjQMdzKSQkSCXAGNTqEvB4IxgV+hDwYPBC+EAYxzhjySV?=
 =?us-ascii?q?S6YEqJhMwuFDAIEAgQFAg4BAQaBeiWBWTM+gzZPAxkPVod1hVU4g0CPekIzO?=
 =?us-ascii?q?wIHCwEBAwmCOYY2gXIBAQ?=
IronPort-PHdr: A9a23:Ru1T/B/1muPpRv9uWWy9ngc9DxPPxp3qa1dGopNykalHN7+j9s6/Y
 h+X7qB3gVvATYjXrOhJj+PGvqyzPA5I7cOPqnkfdpxLWRIfz8IQmg0rGsmeDkPnavXtan9yB
 5FZWVto9G28KxIQFtz3elvSpXO/93sVHBD+PhByPeP7BsvZiMHksoL6+8j9eQJN1ha0fb4gF
 wi8rwjaqpszjJB5I6k8jzrl8FBPffhbw38tGUOLkkTZx+KduaBu6T9RvPRzx4tlauDXb684R
 LpXAXEdPmY56dfCmTLDQACMtR5+Gm8WxwcYCQ6Y6zfwcM7crguijrJgnwOEL93VS6w7YB+e/
 YNyeAbllX05D3k2zlCC2akSxKgOpU6mjCEvzYSLeK3MF/UkU470Rtw8YkhwZ5Z7c3RHL762S
 oAQEvIAZ8x9/4nglgQUgwa/DgnxR+bA0mEUmSPp3vZqguEfGwqf2BAtGNIysi6IiJLcFbw/c
 OqH7orM4TboXc5o5CX5x7jCTR0GscO9cYN5Y8aMmHEjVAXIg1eappfmHzKX6+JXvi+DwbVre
 seeskkJiQZSrzaA5MAj09DFhd4a2wGe831p2qcMcI7wWAt6e9miCJxKq2SAOpBrRt93W2hzo
 3VSItwuvJe6eG0P1J0E7kSPLfKdepWO4hXtWfzXLTorzH5mebfqnx+p6gDg0ezzUMCozUxH5
 jRIiNjCt30BllTT58GLR+E7/xKJ1yyGygbT7e9JOwYzk6/aIIQm2bk+itwYtkGrIw==
IronPort-Data: A9a23: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
 37sWm+R+CqD7xT/Y0fyVw4B2seY0c62I/U=
IronPort-HdrOrdr: A9a23:Xg/2LaGDOccEkcP5pLqFbJHXdLJyesId70hD6qkvc3Nom52j+/
 xGws536fatskdtZJkh8erwXZVoMkmsiaKdgLNhd4tKOTOJhILGFvAa0WKP+UyCJ8S6zJ8m6U
 4CSdkyNDSTNykDsS+S2mDReLxAoOVvsprY/ts2p00dCj2CAJsQizuRfzzrdHGeMzM2YqbReq
 DshPZvln6FQzA6f867Dn4KU6zovNvQjq/rZhYAGloO9BSOpSnA0s+3LzGomjMlFx9fy7Yr9m
 bI1ybj4L+4jv29whjAk0fO8pVtnsf7wNcrPr3CtiFVEESjtu+bXvUgZ1SwhkF3nAhp0idprD
 D4mWZgAy200QKVQoj6m2qo5+Cq6kdQ15ar8y7nvZKkm72+eNtyMbsxuatJNhTe8EYup9d6ze
 ZC2H+YrYNeCVfakD36/MWgbWAiqqOYmwtUrQcotQ0obaIOLLtK6YAP9kJcF5kNWCr89YA8Ce
 FrSMXR/uxff1+WZ23Q+jAH+q3mYl0jWhOdBkQSsM2c1DZb2Hh/0ksD3cQa2nMN7og0RZVI7/
 nNdq5oiLZNRMkLar8VPpZIfeKnTmjWBR7cOmObJlrqUKkBJnLWspbypK444em7EaZ4uKfaWK
 6xJW+wmVRCCX4GU/f+rKGj2iq9M1mAYQ==
X-Talos-CUID: 9a23:XcrvJm5If+4mxCkX69ss8UcICuJ/anHhnX79BBeSDiFPQ5asYArF
X-Talos-MUID: 9a23:xnCuzQlELTIEQ/qsk8VgdnpDG98xx4W8AnkI0p86hs+oHyh2azGk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,234,1695679200"; 
   d="scan'208";a="138403265"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA28.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 21:54:40 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 28 Nov 2023 21:54:40 +0100
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (104.47.7.169) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28 via Frontend Transport; Tue, 28 Nov 2023 21:54:40 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zv8xugiZaYZ6HjNa71ERKE4VpWyuIvITxCoSm08CwxAmnXfVnxF3n2rLeR4emv9P2n8xBDyzcG8XO7xsFXqKrQKMBYhc8wmGoIEEKpOJBCIjzZtoC5BItNyUvLIpjCPnPtSCxa2UZ0wKHv2nI/dk83eX4Ysp8SNfyyrEYvAtg1SNven52H1DVjHPgmrIl7vdJkp1B5zqK0gg2KLGMAPNJfptJMQ+u9EhJwheJfSXduH7gCRjh0e2uIiSgLPXGAzg8it0tiWnM/GmHrtyh45B337oFk+QpYsf90DXhuwDsht1uGibDAdibf9tw12EdvOeWjTYlFmmNLUb3s0fx4XKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8bn5oNbF1EtH0P0u/BvzxKntgQCTzLqXqeu2VP/gVY=;
 b=g80y3Ch1X+JjH8/kfwp/lhvuiWNrr4TplfnRFLK/A3DjseIfSWDqgJddgR00OM0ihFyogbFMDKvfvobgT+iKGZu7m0KEWMsLYagz/y57Dmu2TyhH7WFHT8nGzH/pzzkcVuUUafcov75U82YuhsRWXJHgwur18tCDJzam58Z0YffXjXI77pkragg9uCKc+MTNVO0cl2TUUhMEDkfEe/s+2d6DiUEyx7EY+w6BTC91qX1jc0lBbO0kJ2rr2GcwQzUeGeC38ntugBGgcC1e98te3dnt0S+1jJpKUHUPN5DJ8adHAS8hTwkw1l93jlFe3CMZH0UPcpwIXMBKYzKHx7tHTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8bn5oNbF1EtH0P0u/BvzxKntgQCTzLqXqeu2VP/gVY=;
 b=m4oCU8fb7pD1Kg2EEASgNOJYQ8BL0nEUbMcwupi2BM8huY7rFuich5+mGp64w4wk389mVbc1lteohTj24L/AIsEIbZJKlDkCZUVUzlGXbWeOxZYDYazd59Pd+neejbgskHijUn2e/pF7cGMYQOFJoKefGJog11dk4gy92n0xrIQ=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by BE1P281MB3079.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:60::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.30; Tue, 28 Nov
 2023 20:54:38 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d273:9b9b:dadf:e573]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d273:9b9b:dadf:e573%3]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 20:54:38 +0000
Message-ID: <1d481e11-6601-4b82-a317-f8506f3ccf9b@aisec.fraunhofer.de>
Date: Tue, 28 Nov 2023 21:54:35 +0100
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: Re: [RESEND RFC PATCH v2 00/14] device_cgroup: guard mknod for
 non-initial user namespace
To: Christian Brauner <brauner@kernel.org>
CC: Alexander Mikhalitsyn <alexander@mihalicyn.com>, Alexei Starovoitov
	<ast@kernel.org>, Paul Moore <paul@paul-moore.com>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Quentin Monnet
	<quentin@isovalent.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Miklos
 Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, "Serge E.
 Hallyn" <serge@hallyn.com>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<gyroidos@aisec.fraunhofer.de>
References: <20231025094224.72858-1-michael.weiss@aisec.fraunhofer.de>
 <20231124-filzen-bohrinsel-7ff9c7f44fe1@brauner>
 <20231124-tropfen-kautschukbaum-bee7c7dec096@brauner>
Content-Language: en-US
In-Reply-To: <20231124-tropfen-kautschukbaum-bee7c7dec096@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::17) To BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:50::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2791:EE_|BE1P281MB3079:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b79846a-9aa8-4c0d-0f3e-08dbf0543c6d
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lGk3TbWO8f8IEbedR41f+64Y7OBdh57Kd2iXXyOM5p8JPrQqpSCTMr6oXGMmw8lBnZPlE2QR4q0uqikOoagm8p0jQ5a6LSMT9fmXa/KKueNEsIqOJJ1R4UnSQcjkGSFRnXoo6itWXJRHRyElVngOeRuaIowCCyWLFTXqE6l+PsxffsaLLSVsGzMaxQ4GVmwctWyVwge6ug1XdzTFczJTdz+Y572Eyp1+N9E5Dur8+9OwYY8DtD9Zx47b+SvZ5eRTAlI3iJzgutWxYE1LqsSzuXgF0dYcRaUDCz6Ux5Uug4n3vDJja0D4Mc/jhsY+kXOrswUwuMpDgVDtqHPffOtKtsh9uE1S/2Bhk85JPDUqEBJ9pc5hCrEk/kWRwhMKLOOP/qPnPqwWXuoQNSdo/+LzFFNyFxs+JWaP1+ydZgQt59Q1f20U2DYOrOSHFGPmhspVnqbbW5+cjTine58ccEdmiSvdXM06m2N7DNMOASQ2YmjsZ9iOstVGk/xE4hoqIGN2RWDKkpQnTkymA15+n1YW8A0S9VOFkoYNayJD8CMkLdyn4b5QOrhhjdxEsRbDsCj22Ta7l5pxDhakHrH9shZ/Sm8uELXus7xLTYGHDnUxCiu5kJ4Bk3DiSdigwGBcmoTqnBfX0HyZMhkM6cApW8o11Igyz8AZvqx1q1h4/9KaX1M/iV9C7+h/rpOblRBbrM/byl2k5y1QGl9DYu2jvNV5Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(2906002)(7416002)(41300700001)(86362001)(5660300002)(82960400001)(6666004)(6512007)(53546011)(83380400001)(38100700002)(2616005)(6506007)(107886003)(478600001)(66946007)(66556008)(31696002)(6486002)(4326008)(8676002)(8936002)(6916009)(66476007)(316002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnI0bVRKRlorWFB5ZC9Ea2tmL3VBNXNzQVo3Vjk2dHNpZ2RBS0NMYUtnZGs5?=
 =?utf-8?B?RnliaUYvL21sQ0xMcHVQcm1lYzJEYkE0OU5tWDlkdzZPQmhJOXRnSnh2b2Q3?=
 =?utf-8?B?aHJiaVRjWEFZbENCMFE5SzI2UmRRYlY0RS92R0pobitoekQ0MDJXV0FGa0V0?=
 =?utf-8?B?RTNBMzdJeXJNcUJHNms5VGdpallUU0dSaXg5cEpNTmhNTUdlZGlQbHc2YUIv?=
 =?utf-8?B?TkxSQjI5QlJXT1hzRzVsRHJBb1Z4NUZ3R0pKRUhRUDVJdnZMWVIwVHRtTkt0?=
 =?utf-8?B?Y2puL0YrMzU3dSsydUVJSTNZUHRsa0pmNTYrU0syV0FleW5pUVErK25JSEpY?=
 =?utf-8?B?dUYybWN3aXI0dHZ2Qmpjai8zei9IZHU5bzZad2UwbWV1Wk9kU21WdTVWTTR4?=
 =?utf-8?B?RmpFOVpwMTA1eW8yVmNpSjcwQ2oxb2pMeU1RTXpHQ1ZmRW5BQmlSNXRqQ2U5?=
 =?utf-8?B?N2JLazNmbTlxK0RHRjFpY1pBOHVvRkZlR3Z1SjJUZGJvUnFQZEVPcmJNckFa?=
 =?utf-8?B?dU1IQU1pSTJ3TDA4dmZCd215Vmg3bkN4Njc2VjhrL1U0MklHOVB2bE8wNS9u?=
 =?utf-8?B?cVdFKzIwNzV5NFI5dzJmMGI2N0Z1QnVEeXJrT0hGOFREeWV2OXV0WGo3c29H?=
 =?utf-8?B?T2MrSXhEYk05ZXZ1N05EMVNCR0ZrM1Z1MlJjUUh0NWZnMzZVUnVtb013bzlk?=
 =?utf-8?B?S05MNUZjei9LMHJuZkhvYnRlWFBYWnBVUWpPZXU3N3NQbFRVVUFNakpFby96?=
 =?utf-8?B?emdwZCtTWTBrN1NjZW92L1dEN3lVWXNPWmx4c08rTC9uYkxkMFh5OVM0b2lx?=
 =?utf-8?B?UHB4STVpREJTUWFoQmRuaDJMK0o0Y1U5elFzem9PNUVvNm93eU01OWt5emJl?=
 =?utf-8?B?RUo5VjJiWERrMDRSM1FuMWJrMXMyNFVhekxVcm9aTnlwcUQ3eWZ3MWtqSDNo?=
 =?utf-8?B?TXRhbGZ3c3E4NDJWaFZodmswRzdoajlRTXNUQVJKL2VtaXZVUUdtQ1dPckM3?=
 =?utf-8?B?SnQ5cEVpNm9meUNXa2tRWVhjV0VYb0lWWFg1TXZiYXMzdURTN2tTeWp0WEtr?=
 =?utf-8?B?Q2RWZnpPcWlpNkZZS3RzQitGR2dxcnJtMTV1cUU2Z253cERGTk15Qm1zdGov?=
 =?utf-8?B?aXJsMStpSmV2NU5BYW9sYkZyVEFzRStZWkRpNEFkd0JUQ0pqMjdyQVhDc1Bs?=
 =?utf-8?B?Ykw0TC9IQUFTS3gxVHZkcUY2T1d1cUpSVjhzSUVjdy9UNGdTbS9DRHlQZytq?=
 =?utf-8?B?ZWtjN09QRnJoMVEzWTBlY3JoeXpIOHVOVTgwRzZISmpBb0tmN0VHOGRnVVpO?=
 =?utf-8?B?MDhrZjYzQmk2ZHNPMUpKTmxFeXhkN2xZbldaSEIySldUQXNmV3FKb1FSUEdv?=
 =?utf-8?B?NUgvVHQ5S2lOb0VxU3RhNXNERyt5Y0p3dG15Wlk5ZXJrajRNcmltbTBsNXBw?=
 =?utf-8?B?cnhWMU84V3FKYkZ1Zmx4MGY0YWQveEFBYXZBeWtXSEExNDlGVG9WMWtZQm1B?=
 =?utf-8?B?TFEzSmQ0VHIyUVVMQnZIZkRhUU1FTVBKOWQveDNnbmN5d0pOWm41bDg2ME9k?=
 =?utf-8?B?N2IxVkdvRDNsejN3L2psZnpNMlB6M055eUtRVi9oNW16dXNRNzFyNWFjM2hQ?=
 =?utf-8?B?eDlkWi82K1BoR1NqNE9rMVppdWlKRmVvTUZLSGFQMWpYb2VxRWhBYTVvL3Fj?=
 =?utf-8?B?MUhlN1FoK3ZXcmc4NTBpWDY0V3NIVjVaWkRjU0RMbHJqYWl2ZUdDWU8vWjk4?=
 =?utf-8?B?VkRkTnp4R1RjK3QyS2JjS1ZVS3NUUEU2VStwUFhCTjJDMmtWU2dXdHBWd2ZD?=
 =?utf-8?B?blNlcUFzYTlKbmErQUFrdERUdlN3U2xhMWtJS2xPZnRvV1BSTERiTXgwSVJI?=
 =?utf-8?B?a09pWDZWT2lxeDRBQVBSTHBOVEc1UGxCVE9rc24rVVg2QnJJaVhwWWRaVnI1?=
 =?utf-8?B?QXQxWTArVlo5dC9KRHdWVkg2US8rdHJ0VE1VbTVmc2ZVYU9tNCtlajQzKzkw?=
 =?utf-8?B?UWhuK1FPSE9YMWNaaGJ3ZGI1Rnc5NnVlb282aDRHRmJIZll6cVRTM0d5Umwz?=
 =?utf-8?B?TDF1NGtIb3NUWHNlKy85b2dJKzJGSmdPT3RqdDB2YUZ5ODhna1pvRXNjcWhO?=
 =?utf-8?B?aERmOHAzS3hrUTBNczFEQ3QzQlpKUjIzUXdUKzhPYTlHVFhKRFpQQzM4dldY?=
 =?utf-8?B?V2EvZTQrOXlQeklaM3BDY0FpT0lGdDk0bmhoRk93UDVzaVBXYW5qVWV6TVpH?=
 =?utf-8?Q?K8g/kOp7oDW0Djo41uh0obVSr9Usb0W1VYgZX6yTWA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b79846a-9aa8-4c0d-0f3e-08dbf0543c6d
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 20:54:38.6553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svkq9o8AzDjAice13CF7pqbcgitDvG9pjR105+kyY+R/B7uRYmDKcIHGumV2tuD1lL9FuLduhuzUqbw7zJCKcbzTjkder3DCEbkIjRb26sStALzZoLB9eF1eF+lmw1wD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB3079
X-OriginatorOrg: aisec.fraunhofer.de

On 24.11.23 19:08, Christian Brauner wrote:
> On Fri, Nov 24, 2023 at 05:47:32PM +0100, Christian Brauner wrote:
>>> - Integrate this as LSM (Christian, Paul)
>>
>> Huh, my rant made you write an LSM. I'm not sure if that's a good or bad
>> thing...
>>
>> So I dislike this less than the initial version that just worked around
>> SB_I_NODEV and this might be able to go somewhere. _But_ I want to see
the rules written down:

Since we have some new Ideas, I also will try to better describe
the vision and current device node interaction when submitting the next
version.

> 
> Hm, I wonder if we're being to timid or too complex in how we want to
> solve this problem.
> 
> The device cgroup management logic is hacked into multiple layers and is
> frankly pretty appalling.
> 
> What I think device access management wants to look like is that you can
> implement a policy in an LSM - be it bpf or regular selinux - and have
> this guarded by the main hooks:
> 
> security_file_open()
> security_inode_mknod()
> 
> So, look at:
> 
> vfs_get_tree()
> -> security_sb_set_mnt_opts()
>    -> bpf_sb_set_mnt_opts()
> 
> A bpf LSM program should be able to strip SB_I_NODEV from sb->s_iflags
> today via bpf_sb_set_mnt_opts() without any kernel changes at all.
> > I assume that a bpf LSM can also keep state in sb->s_security just like
> selinux et al? If so then a device access management program or whatever
> can be stored in sb->s_security.
> 
> That device access management program would then be run on each call to:
> 
> security_file_open()
> -> bpf_file_open()
> 
> and
> 
> security_inode_mknod()
> -> bpf_sb_set_mnt_opts()
> 
> and take access security_sb_set_mnt_optsdecisions.
> 
> This obviously makes device access management something that's tied
> completely to a filesystem. So, you could have the same device node on
> two tmpfs filesystems both mounted in the same userns.
> 
> The first tmpfs has SB_I_NODEV and doesn't allow you to open that
> device. The second tmpfs has a bpf LSM program attached to it that has
> stripped SB_I_NODEV and manages device access and allows callers to open
> that device.

I like the approach to clear SB_I_NODEV in security_sb_set_mnt_opts().
I still have to sort this out but I think that was the missing piece in
the current patch set.

> 
> I guess it's even possible to restrict this on a caller basis by marking
> them with a "container id" when the container is started. That can be
> done with that task storage thing also via a bpf LSM hook. And then
> you can further restrict device access to only those tasks that have a
> specific container id in some range or some token or something.
> 
> I might just be fantasizing abilities into bpf that it doesn't have so
> anyone with the knowledge please speak up.
> 
> If this is feasible then the only thing we need to figure out is what to
> do with the legacy cgroup access management and specifically the
> capable(CAP_SYS_ADMIN) check that's more of a hack than anything else.

First to make this clear, we speak about CAP_SYS_MKNOD.

My approach was to restructure the cgroup_device in an own cgroup_device
lsm not in the current bpf lsm, to also be able to handle the legacy calls.
Especially, the remaining direct calls to devcgroup_check_permission() are
transformed to a new security_hook security_dev_permission() which is
similar to security_inode_permission() but could be called in such places
where only the dev_t representation is available. However, if we
implement it that way you sketched up above, we can just leave the
devcgroup_check_permission() in its current place and only implement
the devcgroup_inode_permission() and devcgroup_mknode and let the blk
and amd/gpu drivers as is for now, or just leave all the devcgroup_*()
hooks as is.

> 
> So, we could introduce a sysctl that makes it possible to turn this
> check into ns_capable(sb->s_userns, CAP_SYS_ADMIN). Because due to
> SB_I_NODEV it is inherently safe to do that. It's just that a lot of
> container runtimes need to have time to adapt to a world where you may
> be able to create a device but not be able to then open it. This isn't
> rocket science but it will take time.

True. I think a sysctl would be a good option.

> 
> But in the end this will mean we get away with minimal kernel changes
> and using a lot of existing infrastructure.
> 
> Thoughts?

For the whole bpf lsm part I'm not confident enough to make any
proposition, yet.
But I think an own simple devnode lsm would be feasible with the above
described security_sb_set_mnt_opts() handling to get this idea realized.
Maybe we go that way to implement a simple lsm without any changes to
the device_cgroup and keep the devcgroup hooks in place. To implement
it as bpf lsm with all full blown conatiner_id could then be done
orthogonally. 
So from a simple container runtime perspective one could just use the
simple lsm and the existing bpf device cgroup program without any change
only having to activate the sysctl. A more complex cloud setup Kubernetes
what so ever, could then use bpf lsm approach.

