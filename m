Return-Path: <linux-fsdevel+bounces-6956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F384C81EF71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 15:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C8E1C21270
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 14:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2295945945;
	Wed, 27 Dec 2023 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="3n8cvVCQ";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="E61M9tH5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeka24.fraunhofer.de (mail-edgeka24.fraunhofer.de [153.96.1.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C65F2F50A;
	Wed, 27 Dec 2023 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1703687584; x=1735223584;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dd5T/L0bySNq+sxi6/HV4sMQ/LCMAZCEzETSpLLDlRs=;
  b=3n8cvVCQJxZ8b9+waj4LT++mhPWMdzY/JYxXoMIl66Ic3oIv/moKAwaw
   3fVeClhyuzc7mQw+hUpFQbzndKSj3dWMF1xG/SRAQJzqB38tOLSEmZOhe
   Yci9oI+oMjXvHPyHsy0RMVAdSpGaw4XrNNox1xQuRquR+lh7UVvYIZldc
   Va79V0CNBqBchsMuwhpScdNf/P5D/VbNtP32lv4yPDdZBv/SOmoyGPp9N
   IxneZXRY5JqJbMwN5fuaPVPbGXJOfRrIZusdIAlQb7AGjSiCmLIz041ME
   WppsfLtPLxVxkpyZP7FUDXlA6LezDX2Uc1zuqQ33wdhbG2CVoLmG4Wn/5
   A==;
X-CSE-ConnectionGUID: rzDvsChWS8K43BmV5yTDLA==
X-CSE-MsgGUID: NVNu+d3HRHOuHZa5N0Vo8g==
Authentication-Results: mail-edgeka24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2H9BADpM4xl/xmnZsBaHQEBAQEJARIBBQUBQIFPgjmCW?=
 =?us-ascii?q?4RTkTYtA4ETmxgqglEDVg8BAQEBAQEBAQEHAQFEBAEBAwSEfwKHNyc4EwECA?=
 =?us-ascii?q?QMBAQEBAwIDAQEBAQEBAQEGAQEGAQEBAQEBBgcCgRmFLz0Ng3mBHgEBAQEBA?=
 =?us-ascii?q?QEBAQEBAR0CNVMBAQEBAgEjBAsBDQEBNwEPCxgCAiYCAjElBgENBQIBAYJ8g?=
 =?us-ascii?q?iwDDiOtUHp/M4EBggoBAQawIxiBIYEfCQkBgRAug2eENAGFZ4Q7gk+BFScLA?=
 =?us-ascii?q?4EGgTc4PoRYg0aCaINmhTYHMoIcg0+RVlsiBUFwGwMHA38PKwcEMBsHBgkUG?=
 =?us-ascii?q?BUjBlAEKCEJExJAgV+BUgqBAT8PDhGCPiICBzY2GUiCWBUMNEp1ECoEFBeBD?=
 =?us-ascii?q?gRqGxIeNxEQFw0DCHQdAhEjPAMFAwQzChINCyEFVgNCBkkLAwIaBQMDBIEwB?=
 =?us-ascii?q?Q0aAhAaBgwnAwMSSQIQFAM7AwMGAwoxAzBVRAxPA2wfGBoJPAsEDBoCGx4NJ?=
 =?us-ascii?q?yMCLEIDEQUQAhYDJBYENBEJCygDLAY7AhIMBgYJXSYHDwkEJQMIBAMrKQMjd?=
 =?us-ascii?q?BEDBAoDFAcLB1IDGSsdQAIBC209NQkLG0QCJ6UzEVANBT0+CQuBcGcRkwaDI?=
 =?us-ascii?q?QGvGgeCNIFgoRgGDwQvlzSSWod1kFgZB6JTM4UXAgQCBAUCDgiBeoF/Mz5Pg?=
 =?us-ascii?q?mdSGQ+OIAwWFoNAj3p1OwIHAQoBAQMJgjmILwEB?=
IronPort-PHdr: A9a23:7aMBAh8SRIi9JP9uWXO9ngc9DxPPxp3qa1dGopNykalHN7+j9s6/Y
 h+X7qB3gVvATYjXrOhJj+PGvqyzPA5I7cOPqnkfdpxLWRIfz8IQmg0rGsmeDkPnavXtan9yB
 5FZWVto9G28KxIQFtz3elvSpXO/93sVHBD+PhByPeP7BsvZiMHksoL6+8j9eQJN1ha0fb4gF
 wi8rwjaqpszjJB5I6k8jzrl8FBPffhbw38tGUOLkkTZx+KduaBu6T9RvPRzx4tlauDXb684R
 LpXAXEdPmY56dfCmTLDQACMtR5+Gm8WxxRkMwzOvRfeTrPvoArTjvJn1Bi2LcvISpYoXzqA3
 YREYUXZggdZKgIG/GqC2akSxKgOjUz4gk1j49PYZqGuD/tRLvLwVtwaSDsfZph9FDQbAt+8d
 pNVNLEBNuxyn4Wiun8xtwD5GQTvHci0zwBsmnnv2v0GzOMaCBvp0jUkHfBUgnrwq9L0JuA/b
 8277o767yXiNLB84hCj6YXGSB56vvzXZqlvT9vb1hB+EQPH0w26jrb7GgiS3+MJuHaWydN9d
 cuCqykq+zAygGHy1J0jltHVj4Q823nc/jpAn4NlcI7wWAt6e9miCJxKq2SAOpBrRt93W2hzo
 3VSItwuvJe6eG0HxJsqxBeFN7qJaYGV5BLkWuuLZzt11zppe7O60g676lPoivb9Wc+9zEtQo
 2Jbn8PNuHEA212b6sWORvZnuEb08TiV3h3V6uZKLFpykqzeKpU7xaU3mIZVukPGdhI=
X-Talos-CUID: 9a23:smgfKGP+AoJqf+5DQjtL6lU/Gv8eIl6Bl13VHRKpNUpNYejA
X-Talos-MUID: 9a23:HoWF2gngDve8pFQF6l8KdnpECuF1oKj1KHottogmicDZE3ROPGeS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="6047915"
Received: from mail-mtadd25.fraunhofer.de ([192.102.167.25])
  by mail-edgeka24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 15:31:50 +0100
X-CSE-ConnectionGUID: lghvpeHATjqHzeaVdU9ZRg==
X-CSE-MsgGUID: JmXXnyLySJWzgDWLOt1LIA==
IronPort-SDR: 658c3554_lS+RWJnPvZiJpBNIlIQWVtrN080/S2+BiOMz64MJZncWAUO
 9GOAsvVR2KS9sUXsku7WLCrpyL4u70WBdszfU8g==
X-IPAS-Result: =?us-ascii?q?A0B9BgBWNIxl/3+zYZlaHAEBAQEBAQcBARIBAQQEAQFAC?=
 =?us-ascii?q?RyBKoFnUgc+gQ+BB4RSg00BAYUthkUBgXQtAzgBWptCglEDVg8BAwEBAQEBB?=
 =?us-ascii?q?wEBRAQBAYUGAoc0Aic4EwECAQECAQEBAQMCAwEBAQEBAQEBBgEBBQEBAQIBA?=
 =?us-ascii?q?QYFgQoThWwNhkUBAQEBAgESEQQLAQ0BARQjAQ8LGAICJgICMQceBgENBQIBA?=
 =?us-ascii?q?R6CXoIsAw4jAgEBoWEBgUACiih6fzOBAYIKAQEGBASwGxiBIYEfCQkBgRAug?=
 =?us-ascii?q?2eENAGFZ4Q7gk+BFScLA4EGgTc4PogegmiDZoU2BzKCHINPkVZbIgVBcBsDB?=
 =?us-ascii?q?wN/DysHBDAbBwYJFBgVIwZQBCghCRMSQIFfgVIKgQE/Dw4Rgj4iAgc2NhlIg?=
 =?us-ascii?q?lgVDDRKdRAqBBQXgQ4EahsSHjcREBcNAwh0HQIRIzwDBQMEMwoSDQshBVYDQ?=
 =?us-ascii?q?gZJCwMCGgUDAwSBMAUNGgIQGgYMJwMDEkkCEBQDOwMDBgMKMQMwVUQMTwNsH?=
 =?us-ascii?q?xYCGgk8CwQMGgIbHg0nIwIsQgMRBRACFgMkFgQ0EQkLKAMsBjsCEgwGBgldJ?=
 =?us-ascii?q?gcPCQQlAwgEAyspAyN0EQMECgMUBwsHUgMZKx1AAgELbT01CQsbRAInpTMRU?=
 =?us-ascii?q?A0FPT4JC4FwZxGTBoMhAa8aB4I0gWChGAYPBC+XNJJah3WQWBkHolMzhRcCB?=
 =?us-ascii?q?AIEBQIOAQEGgXolgVkzPk+CZ08DGQ+OIAwWFoNAj3pCMzsCBwEKAQEDCYI5i?=
 =?us-ascii?q?C4BAQ?=
IronPort-PHdr: A9a23:y6NpyBRHGRTyACNINeiudRlc3tpsovKeAWYlg6HP9ppQJ/3wt523J
 lfWoO5thQWUA9aT4Kdehu7fo63sHnYN5Z+RvXxRFf4EW0oLk8wLmQwnDsOfT0r9Kf/hdSshG
 8peElRi+iLzKh1OFcLzbEHVuCf34yQbBxP/MgR4PKHyHIvThN6wzOe859jYZAAb4Vj1YeZcN
 hKz/ynYqsREupZoKKs61knsr2BTcutbgEJEd3mUmQrx4Nv1wI97/nZ1mtcMsvBNS777eKJqf
 fl9N3ELI2s17cvkuFz4QA2D62E1fk4WnxFLUG2npBv6C5ndgi/x5+xZyA2EL+zfdaguVQWO/
 6FVTzn0jiklBR0W2TvmgOwukZ5krBn09Hkdi4SBTd/MEatiXv7Re/MhfmtuDpd8fCNBD9LiV
 9UjTPJbPbpYtpGnnAAOphGUNQXzGcfQ0CQPmnK1xIZh1tsFDQff21wcANU1qW77ouzxNoVIY
 +6Ry67J33LuUd5Y+xDPypjpKVMLmtbSXL9+S8SK1kR0LBjasESattW0OTOXi7wnlFKFytFnX
 OWrgHAqjThsghGC5oAh2riKpNtI2ArL6X1lyYAcNPSgQ1FCPtv0RcgYp2SbLYxwWsQ4XyRyt
 T0nzqFToZegZ3tiIPUPwhfeb7mCb4Gkzki+EuiLKCp+hHVrdaj5ixvhuUSjy+ipTsCvyx4Kt
 StKlNDQq2oAnwLe8MmJS/Zxvw+h1D+D2hqV67RsL1o9iKzbLJAs2Pg3kJ8Sul7EBSj4hAP9i
 6r+Sw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:IBIzNK4QLW7LjkFMxwPXwLjXdLJyesId70hD6qkfc3Bom6Cj/f
 xG9c5zvXTJYV0qN03I9+rsBJW9
X-Talos-CUID: 9a23:xSl2Pm0g4V1wB3ePKibo97xfHs8lbGXQ7F7sIVaYG2tgdrGoGG2q9/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3Ax79WQQ0+WN20MyoamkV33PZ/4jUjwaGeOEYctYQ?=
 =?us-ascii?q?9mfaWOgBPHxCB1RCWa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="194522139"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaDD25.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 15:31:47 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 27 Dec 2023 15:31:47 +0100
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (104.47.7.169) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28 via Frontend Transport; Wed, 27 Dec 2023 15:31:47 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+vHdhG7z5svMJT/rk4yWmcbt8MXPGjX+8fe5/4H834q59tH+OFMmS/+Ol7llrB2ZoQMSCWS0ROkOZ01e9PXLLDLwKhCjer1BfJpotWGNe9z0t6QuEcaP0wtkmj/SVvNVTauCJdOqSeN8jLTp5tX4L41dldjFn8SOTyliQMbE9LzjyC7PRbud8yOufK3f8GchQujt5zP5fswsqycxjewamRn1SGkrG2r82qyycfdOfyGfOsa1cD0yi/Hxf7kxmki1UE2iTvCSGDqcecNMSJCmMHrcY7KFsN2Hb5hO9A+wm6OL3VsQ/j9bWcXJ1JgOvDeU7An1gD+sLXAYGQk0JssAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDXlc9nLxLvzIAPprdYDxnVoNtnfJZKGA2YbH6uTWdc=;
 b=XB42GZlOAg5JcN6z+aUECwuLpH7XIcNbKsX9+Bbme9KffwA1mu8r+SDMeHa2xV6uRpeCliMs8Gt5NUFC6onRVThVmWsckyB5FD0/mrOmS2ivZHtZc/zj7+3b2jy6SvHhzwuYi/6XpvWZKEvcq3vYxqHYLqzDvgmBeebOtkLTDON9PkK/QDFk8Xyhwra4k+LQMZtxWVVggKejEalU05qFQ0GsulbiGyB3aLKVsl5nS3Wa4/EHaomnzvT9G7zJYbCpv+XRO7YzIq0vAeS2U9X3pITZFRKG4wUH+V2IHI5iQzqRWKr/dptJ/3Nh+5xX2tU300YQ4d3d9SiCRpNjsmyPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDXlc9nLxLvzIAPprdYDxnVoNtnfJZKGA2YbH6uTWdc=;
 b=E61M9tH5dnHSSiG89ECghe96P6D+p2h4hqp2S3hcbBXd7uLWrs/te+qC3mWLtnqo8TwoSqrGfQljJ2ZfLooiz/EVEfJOZJxI3+BSO6iefRf3we3SswVybw19nhj50BORvMSoaolcveNQuHAEH/e8Y+J15z2gt0tanAyApcwQ7m8=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by FR3P281MB2909.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Wed, 27 Dec
 2023 14:31:46 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d273:9b9b:dadf:e573]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d273:9b9b:dadf:e573%3]) with mapi id 15.20.7135.019; Wed, 27 Dec 2023
 14:31:46 +0000
Message-ID: <f38ceaaf-916a-4e44-9312-344ed1b4c9c4@aisec.fraunhofer.de>
Date: Wed, 27 Dec 2023 15:31:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 3/3] devguard: added device guard for mknod in
 non-initial userns
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, Christian Brauner <brauner@kernel.org>
CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexander Mikhalitsyn
	<alexander@mihalicyn.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Quentin Monnet
	<quentin@isovalent.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Miklos
 Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, "Serge E.
 Hallyn" <serge@hallyn.com>, bpf <bpf@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux-Fsdevel
	<linux-fsdevel@vger.kernel.org>, LSM List
	<linux-security-module@vger.kernel.org>, <gyroidos@aisec.fraunhofer.de>
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
 <20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de>
 <20231215-golfanlage-beirren-f304f9dafaca@brauner>
 <61b39199-022d-4fd8-a7bf-158ee37b3c08@aisec.fraunhofer.de>
 <20231215-kubikmeter-aufsagen-62bf8d4e3d75@brauner>
 <CAADnVQKeUmV88OfQOfiX04HjKbXq7Wfcv+N3O=5kdL4vic6qrw@mail.gmail.com>
 <20231216-vorrecht-anrief-b096fa50b3f7@brauner>
 <CAADnVQK7MDUZTUxcqCH=unrrGExCjaagfJFqFPhVSLUisJVk_Q@mail.gmail.com>
 <20231218-chipsatz-abfangen-d62626dfb9e2@brauner>
 <CAHC9VhSZDMWJ_kh+RaB6dsPLQjkrjDY4bVkqsFDG3JtjinT_bQ@mail.gmail.com>
From: =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
In-Reply-To: <CAHC9VhSZDMWJ_kh+RaB6dsPLQjkrjDY4bVkqsFDG3JtjinT_bQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0385.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::10) To BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:50::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2791:EE_|FR3P281MB2909:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fdb614b-7105-44ef-bcdd-08dc06e88da6
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /SFkE1kAw1wJyvCXrNkV6RZmBTU5HI9kt2bxfC/Pre4wSzPHmSZLmxpizW/necVInmF5M53MKY6Gg2EMbVPaYqPqXBE3enjf81y4HgV/AwuSXpqHMxdvekYmxxt1zjcmeftHBbeCGSlwkUT0Onkz05CId0w/ZoRJTrVLOpegmNsf+if6bsXbkaePlBiw1Fiq+4uuCq4l/Cxe+Mqo/ZBvJnY8saZPJfXR9h7Bxs2mla0c/wzKMzAr9iAmc3ufWyygP8AFFfEzbYHcjMDoh1gpsArj8xbBCWiEmDkAe9joDjTGsy3NpKV0lt9Kwp5ZXrzYEYEd3MAc+3ujkjq/KNy90UZAn79ofwabULr8Akt/T/8IVVmCzRv1vg6Qw0BwK7dtsEKf0dyBsmna6i7bIuuPjjWhoRglUHezzgxsqLBivCl1hihs+Up+n7TLf2F1om/FsjRwLcxVVDwS+d+lBFDoJBnCn8H7+4yKzAOQ9gAcpMnwyMXFf+gdddsytPMZv2LvORAXTkHi/WrWA8ilnsLEpbqkD/lZViRsllBtwef5na4kCx2x+VVdKTTHw0nNEJhm88q3rxEoUpSU52fFBq+aVk6wQqUnC95f0hzdxeR+y+lTFLzdqhxTMkZLl676agvkepPzNK/IKHWRg8ebtEQMkS6Qcea6PY9WwL4TKQY+CC2DosotYoKBZNU5CvuDyGHYr55el37x89Er6pPMcY6rnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(478600001)(6666004)(82960400001)(2616005)(6506007)(6512007)(53546011)(110136005)(31696002)(86362001)(66556008)(66476007)(66946007)(54906003)(316002)(41300700001)(6486002)(31686004)(8936002)(8676002)(83380400001)(38100700002)(2906002)(4326008)(107886003)(7416002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkRCbW1Ua3l2M0VVNWE2SE9rOW5TVlhYcVlvVEZsMVQvUzRZcmdWR1lPOUtO?=
 =?utf-8?B?WHVGbVBXT20yYVNUanBQS2Jqc1pmMlVjMjhlU29aRTFUc1B6dW8vRkNUTUNj?=
 =?utf-8?B?NEdUa25KUVhnRUVGWjhHZ0FvZXVrVi9lRmFCZ3VBTHM4OW0zMjhnbml1Ui85?=
 =?utf-8?B?ZlJPN1docS96eW0yVzNrOVJXZE9zVEc5Z3VBZkxVbWg2RzNzaXIxRXBEYzgz?=
 =?utf-8?B?WU5CK3pKZm5pKzU0UWlHdjZyekJZQ2F4bWF1SnErMGtjNzQvN1ZpZ1lNamtO?=
 =?utf-8?B?aHVLNVV1cFQvOVBWMm1EWDdYUGo5T0w3QTN5bi9jODV3b0FTWnlmYmMxOWJI?=
 =?utf-8?B?dVQzSUdWWUVPTDNoTUV6eVdpVlhFOHZ1RlMwYmJDRzE1T2tzaTdhTUlHdXJ5?=
 =?utf-8?B?YWlvQ2hrbm5zRlFpQitUdDB2SFp6NmlyUjkvTUpVc2kvbG9UZDNJRGdNYU1B?=
 =?utf-8?B?TlFmTkQ4SE9QNE9VQkF1R21ER1dnazFsTnVUMWg1UmVBclNNT09WcWw4YndV?=
 =?utf-8?B?aFp1WS8wUE9lMXNPbDVDbGtGRVcrUzNTM1prS2lEaFBiVHRGb0JtUXppc3Rk?=
 =?utf-8?B?cGRFQTBudC9GaUdzdnl0OG40djZwYkorVnBRNVVNazQxcmdvZ2hyays0Y0NV?=
 =?utf-8?B?V2pVRi96TkVKNFVmS3paeXFEUHFzWmtZeWF0ZDRSMUtLSUxFRXRuWjVCQkU3?=
 =?utf-8?B?bFNWY01NbE93em9vQUNvWGtMZUYybnU1SkV1d1dkWm1mbSsxbGFxNkM2K0d0?=
 =?utf-8?B?eXYreDVyWjdpd0R0WlBqMjh4TThUbU95cGl1WTliNlYra2hnUGF4WHNMYWht?=
 =?utf-8?B?bGtxRXhmU2FMcVJVVmJ6VVRZay9VcE1ZbUxRanh4Y2dzOENjUUNQRnpha25H?=
 =?utf-8?B?cVlMWHpwVWNCTmhPSHlCbXhkcnhmbzRFSUF0bk4wcnV6a1djRzloVnhibWRH?=
 =?utf-8?B?emoyT0wyeU5qdFNyTjlCUyt2U3hjTGM1WmJ5TktJcE5yOWlCY0wrWFZNemRj?=
 =?utf-8?B?aDZEalJ1L0Q3bThDZU9qV01yemYxOU1WMmdQb2IwWGZVdDlkaC9sZ1VNM25P?=
 =?utf-8?B?eXNyNXJYb3RnZWs3MVZkRGhHRGZ2R2d1anF1RHNZQ2VlZ05kUEFUM05ZZnpO?=
 =?utf-8?B?ZkErMFNhWm4wV1ZETS9mK0tPQkRvYzVhZ21BTUZnV2JhWU93N2F1NTlYR3J2?=
 =?utf-8?B?c0ttUTc5Nnh5NzFnM3FtT29HUVJmbS9rZjNBZmg4VVNmZnZaaVZEcks1ZkJG?=
 =?utf-8?B?cTVsSDU0ZlovS3gxR0VBY3I2b2xvS2NKN3NnZVBrUVJ1T1JONkVOeUZsYjlI?=
 =?utf-8?B?RTA3Ulg3NnV4aldvKzB2V3ZuaTU4cENtMkRCVURRSXV5dUQrK0FYaUpBOEhT?=
 =?utf-8?B?NFM1SHpjbzVMUE81U0ZpdWJjNGNGaUkrMkZRRmI5TzlVdHBUbzRrK0cxb2dZ?=
 =?utf-8?B?TStzL3ZLN0RaQ0NVUFBaR0xnSjhRcndxS1RrUFllcVdvM2lGVURRcHJRWXBB?=
 =?utf-8?B?aGRESW02aGhtMGt3UG83MlBEaWRUSTlJNFZZZFZkNEhYUVZsNU02TDZ6ekc0?=
 =?utf-8?B?cTFValJ1NzV2d1doMEJVTGJzZnQ4SkVPc0tONUYrUFo1NTkwWjZCek1NMENw?=
 =?utf-8?B?NjMxWmc2VTNKdU54Y2tNV2xmVENTc0RlVUt5Mmg3UFNLUytneE02Nkk2cmRY?=
 =?utf-8?B?aVYvZm9pdmhqSStoMnhWMVdDbWVYWnlSL2NrNmw3RndiNVVOQVB1UWNlWjhv?=
 =?utf-8?B?VmxmcHJXRFBzeXpEWk9DRVRFV3lTR21qTU5sTWJJYXlnc1lhTU1CZHdJN1hk?=
 =?utf-8?B?Slo1UzJoSVJhaVc5NFR2ZXF3eHNTU3hFaUtRZDY5bU5zTjFEMk5ZQzFueU55?=
 =?utf-8?B?SjQ0TDFwcFZBd0h3b3Y4SlZBeVMyd3hxdlZ0eTNielNSYWRlcDJHamQ4YUl3?=
 =?utf-8?B?VFRjWVFCU0FtOC9iK0Z5TFphaGowK0RlVENYYnZEUWlyQWM4aXBFUmplaDN2?=
 =?utf-8?B?bWluT3FQTnM3UndXQ3M5VXljL0lPbjNEWXdGdEhhUmFsbVhaSWJDd2dHQUtW?=
 =?utf-8?B?Um9DZWdObG5nQW1IeUY5MzNOdGZvVXhjZXN0b290TXh1MEV4WnZoNDVpcG9S?=
 =?utf-8?B?clpSaE04enRtKzVXY25uMzBRcGc5Z3VHOEFkWDhLc2tGYWtJL3JCMDNCSkRO?=
 =?utf-8?B?cWszcmMrRWNSLyt2bnI5Q0laY0l1VG82amJwZUdsN2hXMURXbUZMaHBuZFpW?=
 =?utf-8?Q?HWUp6JjNrb1+6hR5yxwXtShyAZvZ9B7wFLa47/1r5E=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fdb614b-7105-44ef-bcdd-08dc06e88da6
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 14:31:46.0232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RYF4M1cfgyuMpNQh1j9NsbtDK3JNXQ+lhPKqEu/hF/JSzJ+7cQRXCj8Ih5XrkXP0MacRFWPgQykP5Ix+X26J/flAawrFb4Dz1kelFoGLsYoohj7jEWCoQVfyVSfqxQT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB2909
X-OriginatorOrg: aisec.fraunhofer.de

On 23.12.23 00:39, Paul Moore wrote:
> On Mon, Dec 18, 2023 at 7:30 AM Christian Brauner <brauner@kernel.org> wrote:
>> I'm not generally opposed to kfuncs ofc but here it just seems a bit
>> pointless. What we want is to keep SB_I_{NODEV,MANAGED_DEVICES} confined
>> to alloc_super(). The only central place it's raised where we control
>> all locking and logic. So it doesn't even have to appear in any
>> security_*() hooks.
>>
>> diff --git a/security/security.c b/security/security.c
>> index 088a79c35c26..bf440d15615d 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -1221,6 +1221,33 @@ int security_sb_alloc(struct super_block *sb)
>>         return rc;
>>  }
>>
>> +/*
>> + * security_sb_device_access() - Let LSMs handle device access
>> + * @sb: filesystem superblock
>> + *
>> + * Let an LSM take over device access management for this superblock.
>> + *
>> + * Return: Returns 1 if LSMs handle device access, 0 if none does and -ERRNO on
>> + *         failure.
>> + */
>> +int security_sb_device_access(struct super_block *sb)
>> +{
>> +       int thisrc;
>> +       int rc = LSM_RET_DEFAULT(sb_device_access);
>> +       struct security_hook_list *hp;
>> +
>> +       hlist_for_each_entry(hp, &security_hook_heads.sb_device_access, list) {
>> +               thisrc = hp->hook.sb_device_access(sb);
>> +               if (thisrc < 0)
>> +                       return thisrc;
>> +               /* At least one LSM claimed device access management. */
>> +               if (thisrc == 1)
>> +                       rc = 1;
>> +       }
>> +
>> +       return rc;
>> +}
> 
> I worry that this hook, and the way it is plumbed into alloc_super()
> below, brings us back to the problem of authoritative LSM hooks which
> is something I can't support at this point in time.  The same can be
> said for a LSM directly flipping bits in the superblock struct.
> 
> The LSM should not grant any additional privilege, either directly in
> the LSM code, or indirectly via the caller; the LSM should only
> restrict operations which would have otherwise been allowed.
> 
> The LSM should also refrain from modifying any kernel data structures
> that do not belong directly to the LSM.  A LSM caller may modify
> kernel data structures that it owns based on the result of the LSM
> hook, so long as those modifications do not grant additional privilege
> as described above.

Hi Paul, what would you think about if we do it as shown in the
patch below (untested)?

I have adapted Christians patch slightly in a way that we do let
all LSMs agree on if device access management should be done or not.
Similar to the security_task_prctl() hook.

The new default behavior in alloc_super() is that the
SB_I_MANANGED_DEVICES flag is set if no error is returned by the
security hook, otherwise the old semantic which raises SB_I_NODEV
is used if an LSM does not agree on device management for the
superblock.

So a LSM can only be used to restrict access to the superblock
but not to do more privileged operations, since the
MANAGED_DEVICES would be allowed by default.

The LSM default value is set to -EOPNOSUPP to decide if an LSM has
implemented the hook inside of fs/super.c for backward compatibility.

> 
>> diff --git a/fs/super.c b/fs/super.c
>> index 076392396e72..2295c0f76e56 100644
>> --- a/fs/super.c
>> +++ b/fs/super.c
>> @@ -325,7 +325,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>>  {
>>         struct super_block *s = kzalloc(sizeof(struct super_block),  GFP_USER);
>>         static const struct super_operations default_op;
>> -       int i;
>> +       int err, i;
>>
>>         if (!s)
>>                 return NULL;
>> @@ -362,8 +362,16 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>>         }
>>         s->s_bdi = &noop_backing_dev_info;
>>         s->s_flags = flags;
>> -       if (s->s_user_ns != &init_user_ns)
>> +
>> +       err = security_sb_device_access(s);
>> +       if (err < 0)
>> +               goto fail;
>> +
>> +       if (err)
>> +               s->s_iflags |= SB_I_MANAGED_DEVICES;
>> +       else if (s->s_user_ns != &init_user_ns)
>>                 s->s_iflags |= SB_I_NODEV;
>> +
>>         INIT_HLIST_NODE(&s->s_instances);
>>         INIT_HLIST_BL_HEAD(&s->s_roots);
>>         mutex_init(&s->s_sync_lock);
> 
---
 fs/namespace.c                | 11 +++++++----
 fs/super.c                    | 12 ++++++++++--
 include/linux/fs.h            |  1 +
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  6 ++++++
 security/security.c           | 26 ++++++++++++++++++++++++++
 6 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index fbf0e596fcd3..e87cc0320091 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4887,7 +4887,6 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
 
 static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags)
 {
-	const unsigned long required_iflags = SB_I_NOEXEC | SB_I_NODEV;
 	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
 	unsigned long s_iflags;
 
@@ -4899,9 +4898,13 @@ static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags
 	if (!(s_iflags & SB_I_USERNS_VISIBLE))
 		return false;
 
-	if ((s_iflags & required_iflags) != required_iflags) {
-		WARN_ONCE(1, "Expected s_iflags to contain 0x%lx\n",
-			  required_iflags);
+	if (!(s_iflags & SB_I_NOEXEC)) {
+		WARN_ONCE(1, "Expected s_iflags to contain SB_I_NOEXEC\n");
+		return true;
+	}
+
+	if (!(s_iflags & (SB_I_NODEV | SB_I_MANAGED_DEVICES))) {
+		WARN_ONCE(1, "Expected s_iflags to contain device access mask\n");
 		return true;
 	}
 
diff --git a/fs/super.c b/fs/super.c
index 076392396e72..6510168d51ce 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -325,7 +325,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 {
 	struct super_block *s = kzalloc(sizeof(struct super_block),  GFP_USER);
 	static const struct super_operations default_op;
-	int i;
+	int i, err;
 
 	if (!s)
 		return NULL;
@@ -362,8 +362,16 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	}
 	s->s_bdi = &noop_backing_dev_info;
 	s->s_flags = flags;
-	if (s->s_user_ns != &init_user_ns)
+
+	err = security_sb_device_access(s);
+	if (err < 0 && err != -EOPNOTSUPP)
+		goto fail;
+
+	if (err && s->s_user_ns != &init_user_ns)
 		s->s_iflags |= SB_I_NODEV;
+	else
+		s->s_iflags |= SB_I_MANAGED_DEVICES;
+
 	INIT_HLIST_NODE(&s->s_instances);
 	INIT_HLIST_BL_HEAD(&s->s_roots);
 	mutex_init(&s->s_sync_lock);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..6ca0fe922478 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1164,6 +1164,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_USERNS_VISIBLE		0x00000010 /* fstype already mounted */
 #define SB_I_IMA_UNVERIFIABLE_SIGNATURE	0x00000020
 #define SB_I_UNTRUSTED_MOUNTER		0x00000040
+#define SB_I_MANAGED_DEVICES		0x00000080
 
 #define SB_I_SKIP_SYNC	0x00000100	/* Skip superblock at global sync */
 #define SB_I_PERSB_BDI	0x00000200	/* has a per-sb bdi */
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ff217a5ce552..1dc13b7e9a4a 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -60,6 +60,7 @@ LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
 LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
 	 struct fs_parameter *param)
 LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
+LSM_HOOK(int, -EOPNOTSUPP, sb_device_access, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_delete, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
diff --git a/include/linux/security.h b/include/linux/security.h
index 1d1df326c881..79f2b201c7bd 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -298,6 +298,7 @@ int security_fs_context_submount(struct fs_context *fc, struct super_block *refe
 int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc);
 int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param);
 int security_sb_alloc(struct super_block *sb);
+int security_sb_device_access(struct super_block *sb);
 void security_sb_delete(struct super_block *sb);
 void security_sb_free(struct super_block *sb);
 void security_free_mnt_opts(void **mnt_opts);
@@ -652,6 +653,11 @@ static inline int security_sb_alloc(struct super_block *sb)
 	return 0;
 }
 
+static inline int security_sb_device_access(struct super_block *sb)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void security_sb_delete(struct super_block *sb)
 { }
 
diff --git a/security/security.c b/security/security.c
index dcb3e7014f9b..054ee19edef0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1221,6 +1221,32 @@ int security_sb_alloc(struct super_block *sb)
 	return rc;
 }
 
+/*
+ * security_sb_device_access() - handle device access on this sb
+ * @sb: filesystem superblock
+ *
+ * Let LSMs decide if device access management is allowed for this superblock.
+ *
+ * Return: Returns 0 if LSMs handle device access, -EOPNOTSUPP if none does and
+ * 	   -ERRNO on any other failure.
+ */
+int security_sb_device_access(struct super_block *sb)
+{
+	int thisrc;
+	int rc = LSM_RET_DEFAULT(sb_device_access);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.sb_device_access, list) {
+		thisrc = hp->hook.sb_device_access(sb);
+		if (thisrc != LSM_RET_DEFAULT(sb_device_access)) {
+			rc = thisrc;
+			if (thisrc != 0)
+				break;
+		}
+	}
+	return rc;
+}
+
 /**
  * security_sb_delete() - Release super_block LSM associated objects
  * @sb: filesystem superblock
-- 

