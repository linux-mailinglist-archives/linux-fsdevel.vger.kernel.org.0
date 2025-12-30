Return-Path: <linux-fsdevel+bounces-72236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA17CE930B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 10:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EA6630111BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 09:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A6630C618;
	Tue, 30 Dec 2025 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="g5Gjkjkx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FC230C374;
	Tue, 30 Dec 2025 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767086492; cv=fail; b=umn6xnLvArKHrgqzoku77kOW40hdB+zHW7k6OPhwMpHTkcvTZxkRCccFcBux//LyOClnch03HdRdouHjO0FP9f2wsPmjJ5llzgDYtUR8OokiuEedfnR6a2JJC70I/mY5pF3dAqGNS6SmdkZKtrm5MRurSIwKGd289XwQayXm5yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767086492; c=relaxed/simple;
	bh=W7bZmwDCmcxtmsKZNa+Xcz0kAfIcDrucAYyh5IWCpdg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dOZnYtsOLILkNa5A7aHDRyorpbdSeuvA/M4eprLRkKlRafBeeww9FKCcJFxeOoJeqHLrsWakMPbudFP4OKWgSdIEuNwMQLPfg9Zvt/XoIbJQwf9CHgkticouT7Z0LS+NG3gd6uMdN0Y8YgeD+V8MMAYMcGfiFpwWI5jpl5ojvjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=g5Gjkjkx; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BU8f0M6001657;
	Tue, 30 Dec 2025 09:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=9t1o3LgUfQoE8D8Fm0eoq5t2yrz/9
	dEvIe/5L1rA2zE=; b=g5GjkjkxEo6TsUq4rWBhQXLjIdu6bOLrtLsSH/vCVM+rR
	IbidbIDCi69l+Zc1ddpeoe2xClta1z5GQZnwsXXyW/WXrlMo5INjNayZGwyGm5gf
	9+wXbv+dD7JtkBAm0BxLpRHRNlNNTfsQ+hRu2shQYg4DxJ3K1xPInleVwfrxBvcu
	7fTmsSbo1S4oZ0kZgWast7gaKDbn/pn1w1dOP3z2BRAAgBDfV8w656c4d5PyjxOJ
	APFg/VoAL6TIOYoevPWBfn1c7A0+WPLeJlRq8IFQREINZSLEn3HiXFCaiMQaSwP4
	cg2tx6x5UlPqqRJgFC785XZyEHJWExIA0bHtk98+g==
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013043.outbound.protection.outlook.com [40.107.44.43])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4ba4v0jtg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Dec 2025 09:06:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bf48q7YHq9GsI3ILbScqbilEPSAED3NRZCCMCKr/oRWiwy5blNE9OZk3Fpr1gFYgUQM3T1KDDKDEj1Om8eHJixsuBsfZfmDqXjPOtTHm6oEa1GVHLRmiplrB81FFKjkVOhzcvF6m25JjzIGagRphvgeQkWvmIiAlDh1wz55JavYHtlTGtzoCTRC6G3SojBZ3e0+d056T4lz0TOj+mG1c7HBQea2vpdus+F1TA2R+DQzP00K1fMOBKI4f814cORPpzcZz/SRNuiXwZMqtKWoYjvIepqrxAPcn2S3DH+YLhEuxzyMRAikvsGcEnbjCLIRXkq7NH95Fq/xIYV0EStJuLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9t1o3LgUfQoE8D8Fm0eoq5t2yrz/9dEvIe/5L1rA2zE=;
 b=eIuQM4YwNIy0iH2xJVIjbkIFLzUCZPwXYaHRnx73av0QMS3emulRIrMDWhFkdQ9uZLedUxj/yHtCgJDRismkp91E0CxEihlB9KS3W0kHXKIRaO6+zi9ya3k8KVDq9DPLM9tpTUPZUQuxOzq2Ahk7hP2w+ENlWfc18d0OPfTOXVrgVo1zmqCTOnTUnBAMSlNWgTNa7L4uUmcWU69FjIQq7g0cFcIXr0xoWSFHHAkB+hAKxORu4Eq1BHkEes9NIqUqasBTHTS1cXLbwh+GkMe0RXP7DaMOUjUTkJxvfwm5F3PJFc0VQH6gKV2VNEsPmwyza3BKralU2JcLRUcj0iSILw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEYPR04MB7450.apcprd04.prod.outlook.com (2603:1096:101:1d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 09:06:17 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%5]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 09:06:17 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "chizhiling@163.com" <chizhiling@163.com>
CC: "brauner@kernel.org" <brauner@kernel.org>,
        "chizhiling@kylinos.cn"
	<chizhiling@kylinos.cn>,
        "jack@suse.cz" <jack@suse.cz>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH v1 9/9] exfat: support multi-cluster for exfat_get_cluster
Thread-Topic: [PATCH v1 9/9] exfat: support multi-cluster for
 exfat_get_cluster
Thread-Index: AQHceWR4L2gswImwWE6uvNkpmwBpsQ==
Date: Tue, 30 Dec 2025 09:06:16 +0000
Message-ID:
 <PUZPR04MB6316194114D39A6505BA45A381BCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEYPR04MB7450:EE_
x-ms-office365-filtering-correlation-id: a55fb165-4f75-4c2d-8c4a-08de4782b0c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?5Fnt0ddQTOQG7IVd51YeWBYloP5xmP13wnqo47SwypQ1ZB08UU9gSqY272?=
 =?iso-8859-1?Q?ilk3L2oagfEbRSFY7cvkruYXAGVLBFaA+9k5zPNjXQSAs+Wdi/FIWnJGzh?=
 =?iso-8859-1?Q?S+rv46nVeoqEP/sT8F+tXdsEpW7p5XN5yHv66pfiEELvZ+t1SOPIg1Sav+?=
 =?iso-8859-1?Q?sB0pBqqtKBrmkxeOEJdZACpUhhx+FxZCF1QTZ7FIF/QxsIkRJMeFEBD78P?=
 =?iso-8859-1?Q?xCU2aAxZVtCJvh2IU0BqaZJIm5qoEnewbZFU6q4cBpDr4lkFWt4TYxjcVC?=
 =?iso-8859-1?Q?WexSQJGx64tzbPXwEaWalR+hIRk8YwET8VVt8F57Vg1dQBYIUyfU8e1fzC?=
 =?iso-8859-1?Q?Ob4sQftlbjJQxMYOG65+SrqtH4o6K0ZK7TjV6/nc5OxYmJCNKZH0dRbR6L?=
 =?iso-8859-1?Q?M2nJKOD6FevKWPgQFIS/wU+BVFG7tpu77K7Y6Uk5LTJHaqq/UJ90wlO7Is?=
 =?iso-8859-1?Q?f4bLlttlx3QkbaB9/SKBgOw+b8gdOGhfPnVqzlPAr3QTQXI5MMdgoK5K2w?=
 =?iso-8859-1?Q?ZuK+25mhKXxfonmMP6pvLH1D2AshWzrFwHgy4Fyv1Y43MZNucEH5E2jPrO?=
 =?iso-8859-1?Q?URj9xjOd1pkZ41vgN6ESWFeJASsMG/+ZWYq9UG5Z4l653PWgcMeTyu1xTP?=
 =?iso-8859-1?Q?qwjRAC9oElX43difzGT2picIe5t0GwyI0Dz7aQC+9wGsKAXTb9ZoVLnijl?=
 =?iso-8859-1?Q?Pe1nrQh6T6VCQuSDP7JvWnsCQSBqueze4f25OdHw2LLQS0ptwpN1cjx6E9?=
 =?iso-8859-1?Q?YxoW+xb3moPD+wD2WufevF9eWGwZBOz4NpHuzFsgkMpkRaIJKXefOeas8i?=
 =?iso-8859-1?Q?KMM6KeI5KOPGk6RLqRP0MOp+7ijgpGo70thfqDwnEbkP5VIRW6J/MzDoJ5?=
 =?iso-8859-1?Q?5/23rlfRRH2uDTA+cooMxskkGpSCrBcMPUpbBD4ct9jQANALdQSnH3xBmQ?=
 =?iso-8859-1?Q?9hb/TQ7GeIyY7iyNyFf7L+aXxtYme/Z6YmR5wtiaztD/THamTgjtiujyMq?=
 =?iso-8859-1?Q?DLRSsgBvfpUh7q6wll1gTmN6JEW5qiiZay6GwxeA3QTJVLesbitaHzU53h?=
 =?iso-8859-1?Q?fy2UKuWirHp5pAk90i+loIM/fo+dyrKjW+cxo0DGMp7Na6jQKb49+sBytx?=
 =?iso-8859-1?Q?D+RqWmGu1rM4BvvsSjkX/az9Lc0fvRgn8zhcrxf6EHllyQZkSLrzUcX7Zq?=
 =?iso-8859-1?Q?+2177bSrwlS/7irJNXqtKysniVZ/Xg2zMaDl8bibjJgvNj0CLTp89Ssj/m?=
 =?iso-8859-1?Q?M7U4CnAb5IqBUfsgQg5dfneLr7xz580Z8kkmA755IM1UYNiEPGY/FyjDIn?=
 =?iso-8859-1?Q?L4MZuUcialxSzondNp0cIlmKepbvos7asuKsLEQKl/ztP3scLBbw6ekRLa?=
 =?iso-8859-1?Q?uRnWzP8TxNvIePVfcYAZlbZUb8ESdd2o7MCxaH4YzNIyfftHttHe5UY1o8?=
 =?iso-8859-1?Q?QoZIhsHucfIOukXJHcYVnPTLaCMjLh0bVhEnH9pyhj0bIKxU8264Mc4lp0?=
 =?iso-8859-1?Q?8wyN/JotpEJOi+u1yqDb7Oal/4LSz3looGWg3eeNxnEceG5p3Wh1OeW0bL?=
 =?iso-8859-1?Q?ykZEb+9tS/ZIVOy8rgy5gxNmdPxq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pGlhdD4Le873EXj6Aws+bCTVHSZnVnFM8KsCzg8kjAn7WZ11WRccSnqtIK?=
 =?iso-8859-1?Q?SSLpMtARh7iefyxJfNcjjRuUT7OB5pwOCu4rQoE33c7SYx38LnHTDvDxen?=
 =?iso-8859-1?Q?N8+sCXpvyIqf5VJnqQQqgnub66L0mydAW1MQojWhaXYyR+cT7fij86brXF?=
 =?iso-8859-1?Q?xV9RmD6zP/p8RgAC4Y0sCEtxZLUKPlO2ml5qMfOXDBKpJq8UScwQ4ShMk6?=
 =?iso-8859-1?Q?OsVM27W4w4uOPI0mOj6cL5lp3aBvTTFMhNRzTDKiYc+bKUGjZnulgd4aH4?=
 =?iso-8859-1?Q?JTm1/QW9NquXJYkrZeFile5ReIGrbqPsXAtMEFuvojUNfIj/JbzBtpRDR1?=
 =?iso-8859-1?Q?sjzrjvtSXyeWT78Z5SIfprf7GZsp0S5105lJboPnfnzHzkx6fUv4rLD3Q7?=
 =?iso-8859-1?Q?EcCN/IA4d95jXwVBbOUsQ45/QWOGLihVX7kZvxxvlzc6zkBEvVMKaGcKNq?=
 =?iso-8859-1?Q?WtMYMyPAVp0WX9EMr80pccdK5816bY3Axwj8n3xE0SYyuvBN6U9JzQbipy?=
 =?iso-8859-1?Q?Y+yKf4C7YbQ7koMxtJkzyjznEanJg9fbYLT5nsH6J4UVRUanJ38hE5ruVU?=
 =?iso-8859-1?Q?EPiCKvF/7+tjOs3eH5PMKrmaPw/y0xWHhktpcSXgTsTWl/PQcGMtKiHSa4?=
 =?iso-8859-1?Q?ctTtWFKdlQreYVcE2o89W7uuJMKU4t72MyxEYH0gWt+R8WyCza2Rv/brWm?=
 =?iso-8859-1?Q?Il7OzDF17rPxeeYllfFN+JwSYrELyOV9Y2H5PNnTFvsCjBXBRCWZBCDLOA?=
 =?iso-8859-1?Q?1CfWHpOiWhsdMWzj5rtP06Vp3yM7nv4EXY9IaZhKaB9uNWJoNOhGyafMDZ?=
 =?iso-8859-1?Q?bl8lT2uanfmxG1rPMnq2Nj971Qxg5GlcVZn3iQtsdMvgnazV2Pq191aLk1?=
 =?iso-8859-1?Q?HTg19Q/5mC3bTwkhplOl5cYfCFYGLN8o3WBRbZRI1/PTFboZA+nAPJNeW1?=
 =?iso-8859-1?Q?PmQhPccy5PcrCzyxiKcUcwFmQL87eCbuFPItGBaEh0ssB51UUWQotakbjN?=
 =?iso-8859-1?Q?sHHq/xaGQlwE1McmyQAPqzVZ080elBfzFZEFgtB1s/rk7iopnM1mnHBGw8?=
 =?iso-8859-1?Q?8Hg+vIOvbsTxl5EDo8LurY5FJThOOj9i8ZU8bKK2TzJKs6hLjVHHz1P7WP?=
 =?iso-8859-1?Q?SkoFo60+fSrBRNs+XzBFZ9NsNwIIyhjJwNUpFm59zwwGRxfWmM8QXPPJCB?=
 =?iso-8859-1?Q?L9J4v9vrRQZRfzvycilP8gfGANRYF3z+z3zyCfODgLkO3u+R0yQpxg/kix?=
 =?iso-8859-1?Q?31H2m9qr0AKCYPIl2JfH81Iap5GWy8jCdFMnflaOyB1xRUg+SydBqkGnfN?=
 =?iso-8859-1?Q?yncqPh+Yle5CJfddMQg46sDn8Qi2faBkrGmHUq1ps6Z6NjJm769IyVs8sK?=
 =?iso-8859-1?Q?RyR7lu5KqQ7qKkqM1K5kM0N8LC8hjHexAss/IzeF/SjghuQWLmws2ruiVA?=
 =?iso-8859-1?Q?2VZOnUS/0X/bZCDorjDZtVay2zek7ncbWfQhbYguxMDMWI2OcGQ+tckY6X?=
 =?iso-8859-1?Q?xqMBizpEN4m79L5MOhk0qfAXVy2IXScEzgnz/L4zbehKXNmlHQAz32S2Q9?=
 =?iso-8859-1?Q?dCABSigrz6MhXOxFNFN3gCignn6CkoXRnwFeQHsyvodX2B29bSCm99A0YK?=
 =?iso-8859-1?Q?RqnOmoLqW6k45c97ZB8b4eivtqDramsMSe5IaitXAQx73k/Lj6ae4VtBKx?=
 =?iso-8859-1?Q?Kmi/dvaE8q0DxGIDTmMtYRvNLJppuaChgQ+g0Q1gMjarhgyEbkTL8aIpjW?=
 =?iso-8859-1?Q?Lk/seqaAQx7Jb3vTU9RC8P5EgXX0XZ7WUfPQrCoXKxmUl9CFsRUOc+IO/m?=
 =?iso-8859-1?Q?ncve0ldbaQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uNL+NjSYFRedEdlo6dgA4pXB049fS9Odg1EuGoS/eGPUm7AU3iHOmzcuUmXnpgNBMi1H5fyxTPlX9wFGMimMwKSPaEpCJmQjxMONlV+2KqHBiM7KGscKs+cFFDNAqaKtd6sagye6VlDl62UmQ18zRmFBHTfY/kKIJSFL1O/fx1SUflI7aUuFyAZ3FLun11kLAfhp23agDKGoDjqGh86q6E0judJqk3xGIRSDLOx8yBiQcDAdjWmv8m1Q0yuKsc530Cwq3eUhvFnubz5x1LwnOKjZ3emsFaqBtTz1c09uCrqduQvrzsSn5Teei9u1PC2RwCopDYn+naYbWulKm+WEtZvrJWquTRKXMAUAJCHePF5tMdyfiarzI9tNAb3tsyjOpMg1ER9lFzpBV9dwuBbiRnr4naSQw5RCSrUE1Gax+J1zK8GjJevnC2B/tDaz4tpMXvAbAorNGgj9sCiIHDOV/iD3iBEIaFHb4yLMVvzsEXW/hHMzuP+dBPm+K5F5ZbAi9J26lWTkwRS5JevbzrLDHDKsDjuAexzSzS3Ad0wQVuKOorU6T1iU5p80bpAg7LVoSkCiTAwpxbn0m96BCjPQrg5nUdvgtvsurB5mjzA/oLwQ/wycXZYKvHwR9eeK6wSQ
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55fb165-4f75-4c2d-8c4a-08de4782b0c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 09:06:16.9473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQTQr9iPSe7e1jQabToy8H+5VU/sQcUi6FyjnkJOxpe4R1qD0CdQq0h8rpHUo2g6ueC+WUnsWTQvtZrli6enYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7450
X-Proofpoint-GUID: CbKrSJUJA9MqfW3kHeNSamcUmZxlKE63
X-Proofpoint-ORIG-GUID: CbKrSJUJA9MqfW3kHeNSamcUmZxlKE63
X-Authority-Analysis: v=2.4 cv=C4zkCAP+ c=1 sm=1 tr=0 ts=6953960e cx=c_pps a=3LWbke0kaGtId482X7Fz2w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=wP3pNCr1ah4A:10 a=7j0FZ4iXMVMA:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=kY_Rp-MA-9mi7CNvHJMA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA4MSBTYWx0ZWRfX8GGeemU/78nl kMRnClmYLdOY3KCHvQrljU4gYBk6HRLmMnj7j7GJFPXkB/lpLAsGcMca3p4A9nL1sZxgl+AJzJr wcbLapItJdBe6yxPosO/rRk/Z+9lLKfN9PvDi8WX6KtVmpM/3QrnukCsfJznLU97Awvtq6Wbk0S
 XJ/cGizJiARtETZdb5JCRLuBXaVYokfiHs5xylXWO5UqKgATmAZV7j2PMCrVyCkxLq/r1ai7yr6 yfIYMAvjsD0gE5r/BnZPSzAHJ1vffEGd55WRqoDVKsp49AAPUdUQxUbYKM4JNerLCpuukknfNyo 7Xmus9XRBz+rVn/Elqg8Hexgj4WJWRFTsHDBGbLyyitURFKIH7DLqRWGpbKW26TrkLKuaCLmWns
 orq/pwaVLghsGvEk3HC1UwPgEZcXheG4tFh+afPcS+zzDnVWWH7p0Wg3tRUi3h1wTtlqf9r74iD GuoDRR256mdhrG6BtMA==
X-Sony-Outbound-GUID: CbKrSJUJA9MqfW3kHeNSamcUmZxlKE63
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-30_01,2025-10-01_01

> @@ -243,6 +244,7 @@ int exfat_get_cluster(struct inode *inode, unsigned i=
nt cluster,=0A=
>       struct buffer_head *bh =3D NULL;=0A=
>       struct exfat_cache_id cid;=0A=
>       unsigned int content, fclus;=0A=
> +     unsigned int end =3D (*count <=3D 1) ? cluster : cluster + *count -=
 1;=0A=
=0A=
In exfat_get_block,  count is set as follows:=0A=
=0A=
count =3D EXFAT_B_TO_CLU_ROUND_UP(bh_result->b_size, sbi);=0A=
=0A=
So '*count' is always greater than or equal to 1, the above condition seems=
 unnecessary.=0A=
=0A=
> --- a/fs/exfat/inode.c=0A=
> +++ b/fs/exfat/inode.c=0A=
> @@ -134,6 +134,7 @@ static int exfat_map_cluster(struct inode *inode, uns=
igned int clu_offset,=0A=
>       struct exfat_inode_info *ei =3D EXFAT_I(inode);=0A=
>       unsigned int local_clu_offset =3D clu_offset;=0A=
>       unsigned int num_to_be_allocated =3D 0, num_clusters;=0A=
> +     unsigned int hint_count =3D max(*count, 1);=0A=
=0A=
Same as above, hint_count seems unnecessary.=0A=
=0A=
> +     /*=0A=
> +      * Return on cache hit to keep the code simple.=0A=
> +      */=0A=
> +     if (fclus =3D=3D cluster) {=0A=
> +             *count =3D cid.fcluster + cid.nr_contig - fclus + 1;=0A=
>               return 0;=0A=
=0A=
If 'cid.fcluster + cid.nr_contig - fclus + 1 < *count', how about continuin=
g to collect clusters?=0A=
The following clusters may be continuous.=0A=
=0A=
> +             while (fclus < end) {=0A=
> +                     if (exfat_ent_get(sb, clu, &content, &bh))=0A=
> +                             goto err;=0A=
> +                     if (++clu !=3D content) {=0A=
> +                             /* TODO: read ahead if content valid */=0A=
> +                             break;=0A=
=0A=
The next cluster index has been read and will definitely be used.=0A=
How about add it to the cache?=0A=
=0A=

