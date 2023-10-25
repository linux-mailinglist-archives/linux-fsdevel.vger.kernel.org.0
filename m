Return-Path: <linux-fsdevel+bounces-1144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0866D7D673F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 11:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0FE2282573
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 09:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA0D266D3;
	Wed, 25 Oct 2023 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="EeaG7Rw+";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="OO7+q2w+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC30823775;
	Wed, 25 Oct 2023 09:44:10 +0000 (UTC)
Received: from mail-edgeka24.fraunhofer.de (mail-edgeka24.fraunhofer.de [IPv6:2a03:db80:4420:b000::25:24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A375110A;
	Wed, 25 Oct 2023 02:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1698227049; x=1729763049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=eKElJcu7Id5sldol2s8MOyzTK9+7fV+g6NYwtKozuZg=;
  b=EeaG7Rw+yl3KJeSGh4Og437zykxXpDvM9cpFeu7GLNcj3JSZie9W52dy
   QXwt4ShHwaGyi5ilfgP+IMivp7LBzNKuitOiTSimMoxNgcDW40GapQq1n
   6qVR04W6T9wYPZ0LCn/xhTJYo1kQlQnDpq/CUvA/J2ulCZ4yUtJU+5uwN
   nuU40paR4qf1VzfTrqWXnfVfNLg9QgttHMcAQ7zwNvVAD/giHiOGg3fpZ
   bPqcXAfu0VUuhocW0BmyURwGJf5DLjZ/473uEbqZJXksKe82lMfm/7RXv
   mSVTBWbKsKyFX9YnUzZG9wcxey0FCYeoNEgsGUet5XffdMVb9bcwKyVty
   Q==;
X-CSE-ConnectionGUID: Oar3O4eMQGmOAAyffpgzYA==
X-CSE-MsgGUID: DROKL+LfSdGdHNyU3Ffiqg==
Authentication-Results: mail-edgeka24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2EqAwBB4jhl/xmnZsBaHgEBCxIMQIFEC4I5gleEU6oEh?=
 =?us-ascii?q?AQqgSyBJQNWDwEBAQEBAQEBAQcBAUQEAQEDBIR/AocaJzQJDgECAQMBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQIBAQYBAQEBAQEGBgKBGYUvOQ2EAIEeAQEBAQEBAQEBAQEBH?=
 =?us-ascii?q?QI1VAIBAyMECwENAQE3AQ8lAiYCAjIlBgENBYJ+gisDMbIYfzOBAYIJAQEGs?=
 =?us-ascii?q?B8YgSCBHgkJAYEQLoNchC4BhDSBHYQ1gk+BSoEGgi2EWINGgmiDdYU8B4JUg?=
 =?us-ascii?q?y8pi36BAUdaFhsDBwNZKhArBwQtIgYJFi0lBlEEFxYkCRMSPgSBZ4FRCoEDP?=
 =?us-ascii?q?w8OEYJCIgIHNjYZS4JbCRUMNQRJdhAqBBQXgRFuBRoVHjcREhcNAwh2HQIRI?=
 =?us-ascii?q?zwDBQMENAoVDQshBVcDRAZKCwMCGgUDAwSBNgUNHgIQLScDAxlNAhAUAzsDA?=
 =?us-ascii?q?wYDCzEDMFdHDFkDbB8aHAk8DwwfAhseDTIDCQMHBSwdQAMLGA1IESw1Bg4bR?=
 =?us-ascii?q?AFzB51Ngm0BgQ2BW32WLgGueQeCMYFeoQkaM5crkk8uh0aQSCCiPoVKAgQCB?=
 =?us-ascii?q?AUCDgiBY4IWMz6DNlIZD4EbjQU4g0CPe3QCOQIHAQoBAQMJgjmJEgEB?=
IronPort-PHdr: A9a23:CFKR8RQniMpNkGXxX7O91BFdstpsou2eAWYlg6HP9ppQJ/3wt523J
 lfWoO5thQWUA9aT4Kdehu7fo63sHnYN5Z+RvXxRFf4EW0oLk8wLmQwnDsOfT0r9Kf/hdSshG
 8peElRi+iLzKh1OFcLzbEHVuCf34yQbBxP/MgR4PKHyHIvThN6wzOe859jYZAAb4Vj1YeZcN
 hKz/ynYqsREupZoKKs61knsr2BTcutbgEJEd3mUmQrx4Nv1wI97/nZ1mtcMsvBNS777eKJqf
 fl9N3ELI2s17cvkuFz4QA2D62E1fk4WnxFLUG2npBv6C8bvvHL7psonwQ24L8nGY58+B2itt
 aRGSBzlhAE/HiUI7E7SmPxxiqljpS/09Hkdi4SBR6bKd+MkYeDjWPxGaFcYf/gLCwpPJZGTV
 ogrX7UFMuN9sbjf5GtQrgOuAzCUWPLI7z9MjSLr/o83kNYELRrAhFwEI/U1km3rp/Xvc6MPC
 vmE0vKL1m6cfdVH5S3j85LoVC09/PKFbIxsduTR0Hk0EAbMkW28m4bObmjN9MgMnm+f3udle
 9iRhUMY9DosiQO1/9kio67JhKww4W2D1Stg2oIpI42SWmRLRPmvRcgYp2SbLYxwWsQ4XyRyt
 T0nzqFToZegZ3tiIPUPwhfeb7mKf4eF4Ru5CKCfOz5lgnJidr+lwRq/ogCsyez5A9G9y00C7
 jFEnd/Fqm0X2lTN59KGRPpw8gbp2TuG2w3JrOARCU4unLfdK5kvz6R2kZwWsE/ZGTTxllmwh
 6iTHng=
X-Talos-CUID: 9a23:I6tyOWPBZ39xWO5DfyB9r2lIF+UcXXj65V7BLUGgBnRYYejA
X-Talos-MUID: 9a23:k5P0Jwn5V1VVswmSpSq+dnpODuBLx+eKBnsBvpkmndi5bgJ+Oi6S2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="1802503"
Received: from mail-mtadd25.fraunhofer.de ([192.102.167.25])
  by mail-edgeka24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:02 +0200
IronPort-SDR: 6538e325_vEal4lnTu32ysoXXPPkFmYXiAftA6WmewohagMT40cLgkXK
 G6s6YC3m5gyCrw2lp8fRwb/U4vt0zSy2covv0kg==
X-IPAS-Result: =?us-ascii?q?A0BZAAC94Thl/3+zYZlaHQEBAQEJARIBBQUBQAkcgRYIA?=
 =?us-ascii?q?QsBgWZSB4FLgQWEUoNNAQGETl+GQYJcAZdqhC6BLIElA1YPAQMBAQEBAQcBA?=
 =?us-ascii?q?UQEAQGFBgKHFwInNAkOAQIBAQIBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQYEg?=
 =?us-ascii?q?QoThWgNhk0CAQMSEQQLAQ0BARQjAQ8lAiYCAjIHHgYBDQUiglyCKwMxAgEBp?=
 =?us-ascii?q?TABgUACiyJ/M4EBggkBAQYEBLAXGIEggR4JCQGBEC4Bg1uELgGENIEdhDWCT?=
 =?us-ascii?q?4FKgQaCLYgegmiDdYU8B4JUgy8pi36BAUdaFhsDBwNZKhArBwQtIgYJFi0lB?=
 =?us-ascii?q?lEEFxYkCRMSPgSBZ4FRCoEDPw8OEYJCIgIHNjYZS4JbCRUMNQRJdhAqBBQXg?=
 =?us-ascii?q?RFuBRoVHjcREhcNAwh2HQIRIzwDBQMENAoVDQshBVcDRAZKCwMCGgUDAwSBN?=
 =?us-ascii?q?gUNHgIQLScDAxlNAhAUAzsDAwYDCzEDMFdHDFkDbB8WBBwJPA8MHwIbHg0yA?=
 =?us-ascii?q?wkDBwUsHUADCxgNSBEsNQYOG0QBcwedTYJtAYENgVt9li4BrnkHgjGBXqEJG?=
 =?us-ascii?q?jOXK5JPLodGkEggoj6FSgIEAgQFAg4BAQaBYzyBWTM+gzZPAxkPgRuNBTiDQ?=
 =?us-ascii?q?I97QTMCOQIHAQoBAQMJgjmJEQEB?=
IronPort-PHdr: A9a23:x5yH0RbTUb4ZIAlKXeBzA5v/LTFg0YqcDmcuAucPlecXIeyqqo75N
 QnE5fw30QGaFY6O8f9Agvrbv+f6VGgJ8ZuN4xVgOJAZWQUMlMMWmAItGoiCD0j6J+TtdCs0A
 IJJU1o2t2ruKkVRFc3iYEeI53Oo5CMUGhLxOBAwIeLwG4XIiN+w2fz38JrWMGAqzDroT6l1K
 UeapBnc5PILi4lvIbpj7xbSuXJHdqF36TFDIlSPkhDgo/uh5JMx1gV1lrcf+tRbUKL8LZR9a
 IcdISQtM2kz68CujhTFQQaVz1c3UmgdkUktYUDP7ESrQJmoszva7PNZ+jueDePZR+5oVm6hw
 qdoRRPOsA4cBiIW9XPni8p7tKdm9UHExVR1lqnzP8KMbuU9QIbyIf4nHEt/BJp3WQtTLbq/S
 9tQC+UEGPhpjcrN+VgWvR2HPVW9I8bvzjQVm1zU0O4I9tg6F1mW+DAHJPAXj3/0tpLxKfwLY
 P7uj7KTkiflfs9MxyznyK71bk0iqMCyQbVecdPh0k4qHhz9omeagt2+ZxG518kKt1mW6sRaa
 +yCtDEc9ipKuAGxyO4Liovno6kojXDK7D993IBlD8+SeGtcaov3WIsVtjudMZNxWN9nWWxzp
 SImn6UPooXoFMBr4JEuxhqabuCOX6TSv1TtTu+MJzd/in9/Pr6y1F6+8kmln/X1TdL8kE1Lo
 SxMjsTWuzgT2gbS5MmKRro1/kqo1TuVkQGGwu9eKF0yla3VJoRnxbg1l5EJtl/EEDOwk0Lz5
 JI=
IronPort-Data: A9a23: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
 2bCL4dXD7t6BlRI0Ufxh+8UvA==
IronPort-HdrOrdr: A9a23:RZ8ZcKpE7yzNIpJcSDx02wgaV5oveYIsimQD101hICG9Ffbo8f
 xG/c5rsiMc7Qx6ZJhOo7690cW7Lk80lqQFg7X5X43SODUO0VHARO1fBO3Zsl7d8kXFndK1vp
 0AT0ERMr3N5AhB4PoTomGDYrMd/OU=
X-Talos-CUID: 9a23:QIwa6G90eT2iqJG25PuVv1QfCpoaSVDF9nj7CF2jL0xKUIOHdnbFrQ==
X-Talos-MUID: 9a23:WWakWQZVyTZtVOBTiGPJxxdhLsVR6aH1I0Ikv5pBvsydOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="188491576"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaDD25.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:00 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 25 Oct 2023 11:43:00 +0200
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.169)
 by XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Wed, 25 Oct 2023 11:43:00 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lg9iLr8G6916I7kCYC2wWi1OI7WjKUcRV58hV5n75Oqb/r1jTvy2iuDhDLw3ecGsLkLOrQZPtwwk8Xy0/fX63CdzIqLU9u9Kitq5GfXlWaFIG5GDFVlkGAVjfaRJL+qE5Z9ynVewD9ivePGj0z8nkk6QywaZHXKaxPzOWoKVlr2tZ0vzeDijY7gsnbkgVI59Awqjc4r3Zw/Cg83+gpovO2qEUoKh9FJnx1+pKnO/+D5g9S3zysmy41Cfo2m9PWDbHQcNCw120KRDaL1R/qJF01/snbfYiQ0IFeZl+4/1BPX9Gx+dAEWdPhWYecRa3TikiB6Ubql8LS0cfkVgNJLrXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vf1ixH2qLJzlXFGb64g2kEhkedNPAsYtGmzXincPmU=;
 b=jgmKdhOiviBX5SQCIz5ycw/EosOE9ZSCk2vKRnIELHkz9F1JDo/HbnOGdELIdJ8fx5VzpJ1YRmvE1JtfqjQrEezgHDUP4GBEp2CopO+QFQdq3XCtEqcAQAPO/GUBnB+cu+G2FCFnJVJg1PwcKXtXhjHIqjU2PnPR+X5pEbflOgr48Kwtli/h26D+OwzcK031DACNkWrcdSgggV1R2yCE40XZZ14+6jq0/UhdlYFz5CSVUS4Tkhd5i66vk38dFYwsiIxiwc8rFfnn9HZer/AzXAT4arg2MomelnOrl/veMmuw292eU+50EdgTE6RdOMpg+rFk0KAeWgsO4/zlRWtZHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vf1ixH2qLJzlXFGb64g2kEhkedNPAsYtGmzXincPmU=;
 b=OO7+q2w+VMG4EU1IV24NfOzGQkL87lgmMvYJ+X6kpxnQP4yOMhlc5uKJe+ZMTsn08LTOSJqWcHr/lu3qYv3+s37zNyTrvsrHNUt5kaYVtoFhqXsomawPDZbC930JDiEolYemFRVfEW7S5CSrQvfAOhjFMCU/Hfqrltn8BzBXMOc=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by BE0P281MB0116.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 09:42:59 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 09:42:59 +0000
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
Subject: [RESEND RFC PATCH v2 07/14] drm/amdkfd: Switch from devcgroup_check_permission to security hook
Date: Wed, 25 Oct 2023 11:42:17 +0200
Message-Id: <20231025094224.72858-8-michael.weiss@aisec.fraunhofer.de>
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
X-MS-Office365-Filtering-Correlation-Id: 1b2dd8f3-608b-4c5a-1e21-08dbd53ec65d
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O23ydpS7Q4O/fZ1BIHXAfRW8N1PmHcR4YLsIgpB+KYu5GTgpfH4NRP7H7NeuJ3gCHniy9YXaoIpzzqpht3yzcuLVSyOGNFCdwjnCQlecBMSC9f7m1oW64D/gXF9a26m7dOwEg1i54cvXBOHh4kdAJs5wN901ar7WIrEegfQwPSmg3RSx9sO8lea3ZAOdbX/FMBWV/CNKTtKVRaxwvskvQt0tSzZwF478vYhDOZGGjwHN952BbrjrfHFzy0SEIXdEDaujYGxs9l3i6FM91C2LCWVNFvxp7dBFY6jhQ9wT8gwSLIbZcn5cxXllJGrrWXnYvHmoX1MC4JzKr/TJuQZ5v0F6NxRnAFlWY1XErxZ924+liXO3EAPcZTxF4jAdgZkqRLFOAlX8C/M4ergvMKmchiTv+zMWOY8PXOEo8VdsRlZTTi35C0lMM96L1na1npFA2JWVM14WAJeawqAlNfz/EP62s0Ck4Wz8piLvvyyiJ1D8laTg5a1CwannsuzwfqyPKtwasVzBEHDVKbMEnM7fDQpD1EXBCap/K6NhELKW6G3Sys3yXq0POX2XeTr+B2N20wPTfUAQY9kdjPRjcbiRxDZhr55Nyor3n/kL7DznJgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66946007)(83380400001)(316002)(38100700002)(6486002)(478600001)(6666004)(54906003)(110136005)(66556008)(66476007)(1076003)(107886003)(52116002)(6506007)(2616005)(6512007)(15650500001)(7416002)(2906002)(86362001)(4326008)(8936002)(82960400001)(8676002)(41300700001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODN2cm83K2NuK3JuZHhqSGR4SFJtTkx3bUNzWFJrUFJNK0t2Rzg4KzhSSWZz?=
 =?utf-8?B?V3Y3VGFRcnJsUUM0S2h0ci9hQnVZdkdPVWJ6YXBDUlNUSjQxVU5DWjFBczhw?=
 =?utf-8?B?cWtPUjVzNDZ1RFYxMEh1UStTSWl4ODc3WjdxQmsvRGZIZzRoUlJMbkNNN2dD?=
 =?utf-8?B?Z3hDUGtxSlVSVzlxekg3N0ZmNXBkZFB2VkwzVkpseTVuSTUybFRGRjFnTnBE?=
 =?utf-8?B?OVJvUkhocUt4TW9CNDNaSDRabWtSMTNMR2tHK1N3LzFYckNuR09yMTQzVjVE?=
 =?utf-8?B?N3BucldldkpjNTJYdi9LTFhDWTAyVnpwWmNMYWR6SElIOG42aytJelNiU1Iy?=
 =?utf-8?B?OGZUWVBxa0ZMTEdFc2JqVW9JTE9YM21WNWx1a0ZQeU5ybGlHVUdCTVFQa3BC?=
 =?utf-8?B?eCtsUTZaMGRvQ0g2WkxSL3dsdWN0dWtlUGorRmpHZ2plaG1PT042aVdRMFlt?=
 =?utf-8?B?bktZU0M0YVZGY0lqaU10WEFtNkVVNFA3RFBZVEFBVllsZ1hTRzZjd3hsK3hB?=
 =?utf-8?B?cFAyKzFyY0dzVWw3NGNtMDcvSXFSTnBGZU1Cd2E5UWk2dEpOS2wybVdEaWwv?=
 =?utf-8?B?MDd4YlBuQlk3aXdraUx3Ry9JRmg5VWI3bHU4RWxQYzB5VDkrNDhRNWk0VXND?=
 =?utf-8?B?QWNBd2hpcWhyRVd0NGVmWWdBcmRBMUN0NlUycXB2U0NUREpobENtVE9QUUhC?=
 =?utf-8?B?N0pwcHd4Z093RGI0cUFxcmdvejdVaDNibVNoYUNvdzhrUTRrek9UVytCKyts?=
 =?utf-8?B?cUR4LzU0bzFzZVBndXlsVjJ3SGl2RlUxSHJNZ0psRzE4d3ZoME8rTWl5c2Jw?=
 =?utf-8?B?VkY3ZmJ2eE1PUElrcFhreG5JUmhNNzFjY3NFQUYzdjJqaldMdW9LaC80UzJi?=
 =?utf-8?B?NHpWZ1AwNCtRR2dpN0VzZHZKa0R1dkRYNVpnN1kvTVQvSXgwZyt3eU9pOUFM?=
 =?utf-8?B?R0FJR2cxN0syWithK2cxNVUzUnJrMEVVc1pkVTA5S05lMjR3Y0dlY1lvSkJX?=
 =?utf-8?B?WGxta2JjZUNzZkVMS3piZmw2SUNISVlKSHNqdWJiMjU1YWtFbmE4ZW9Pa3Q2?=
 =?utf-8?B?VWVib0RuQnB5OG5qbW9pR2wwTVdMQmt0cVpScHFqUXd4RnNPV0F1c0hDL2pT?=
 =?utf-8?B?QW9DZHdNbzgrVkV5WUtlVjhvTGpQT3lnVk5HRVNpdmVJZW1kYldOcFRBM0RC?=
 =?utf-8?B?S09ONkNvdExkRzlJVmVZTU5xRlY5cXpHd1F5d3VFcHd4SWF3ZUxvUWNYblAx?=
 =?utf-8?B?SHQrTzgxbzJhWEN6blBnNnVXS2p3T2hQWkdjZzVrVjNhR3VrUVkzT2J3TXpJ?=
 =?utf-8?B?bk93Sm5yelVqSGZKK1VVRjFCcW5UM0hFVXA3dHh0UlY5VXZmMFdkeFlQVlJn?=
 =?utf-8?B?Uk5BVUZab2RkQ2grRFhwZVpQNVhyYXJpSWlGek00TWhCOGorU0o2ZXRIUEc3?=
 =?utf-8?B?NmxqVlhNQTFmaWw5THdVMURTSExxUE5EVEM3T0FLL1pmWUowVGtRR1JnMjlL?=
 =?utf-8?B?MFJGeVZXQm5KbXZXcUFqdHBzRTgzRmRFcnFmY2ZOcFhNeG5TcjBkbHRZWDJG?=
 =?utf-8?B?S2IyQVNUS2lVQWtrWWU4a250Yy8zMUt1a2ZlZUJWR1ZsSDR4R3NneXcrNkt4?=
 =?utf-8?B?UGtNYWVONURrcGYremNpMkc5MlZCekpsTlJqSTl2UXFiK1B6YTBIem55blBU?=
 =?utf-8?B?L2ZiOHZRYzU0ZUZ3dmV4VG4zWHBzNUNtRWhtL3FBbUtDVzh6WU5KK1l3YXJy?=
 =?utf-8?B?R2FYcTh3MWxaSHo1eHVJUmNBNms0dnFXeFF5OTNvQkJtSE5PMXBxUFRsRXYr?=
 =?utf-8?B?dHlTZG9qYzZCdk9YemRYelBwMVVwejFFUEs4WkVrQ1BEa1g1M1Nna0wrV0Jh?=
 =?utf-8?B?amNONFB4THpIZjY1MlpMYjI3RUpTamxnbjAzSG52a0gwek5mYVZaN0ZiZXg0?=
 =?utf-8?B?RW1CREJjNGw5SWNUa2Fndkx4c0dFN29La1NZc2dJaVkva0poNENzSUh2RC9j?=
 =?utf-8?B?Qit2UURxRVl2N2wzdGZoYXBTSWozRzA4NG1DNXpMN3oxLzRrTzZmaFcvVmxT?=
 =?utf-8?B?TjRQbGV0b0ZtK05MZEJub0FiVUQya2hNd2E0cUFudmFNRnNXMXhUd0FPSVE2?=
 =?utf-8?B?b01VTkhWdzRiMkg5ZmQ3eHU0YVZ3UGVaK2dGS2xtZkFGNGw0TklrRHVaMCsy?=
 =?utf-8?B?eGVuZDAxSVE4Y2tVVUVoNFJYN2dSOGZIdG56anNONk5LMG1Gb2EwbWNFMkJM?=
 =?utf-8?Q?nF4eBX4mv9OYcr4+OFjYK3pqKsPC5UsuxlZdnTcQlI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2dd8f3-608b-4c5a-1e21-08dbd53ec65d
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:42:59.7039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhSYmiedWO3oUym7gS3eVavdGcHH09CWT+7c0prcN8iiPWCBz8kMf/eF17UFrRF7pCRGwbXw5Fiu2V5HpO8hXH6H5VQdpll8ps7A+M1FerIWv0J4BEC9tPf4bjJVpoRP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0116
X-OriginatorOrg: aisec.fraunhofer.de

The new lsm-based cgroup device access control provides an
equivalent hook to check device permission. Thus, switch to the
more generic security hook security_dev_permission() instead of
directly calling devcgroup_check_permission().

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index fa24e1852493..50979f332e38 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -38,7 +38,7 @@
 #include <linux/seq_file.h>
 #include <linux/kref.h>
 #include <linux/sysfs.h>
-#include <linux/device_cgroup.h>
+#include <linux/security.h>
 #include <drm/drm_file.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_device.h>
@@ -1487,9 +1487,8 @@ static inline int kfd_devcgroup_check_permission(struct kfd_node *kfd)
 #if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)
 	struct drm_device *ddev = adev_to_drm(kfd->adev);
 
-	return devcgroup_check_permission(DEVCG_DEV_CHAR, DRM_MAJOR,
-					  ddev->render->index,
-					  DEVCG_ACC_WRITE | DEVCG_ACC_READ);
+	return security_dev_permission(S_IFCHR, MKDEV(DRM_MAJOR, ddev->render->index),
+				       MAY_WRITE | MAY_READ);
 #else
 	return 0;
 #endif
-- 
2.30.2


