Return-Path: <linux-fsdevel+bounces-37471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979FC9F2A78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 07:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF771881759
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 06:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26CD1D1E74;
	Mon, 16 Dec 2024 06:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="HpFCraF8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B711D0F46
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734331813; cv=fail; b=kKp+GZfRDXNJpKPzq8XFxind3G1BRywVgUve01iB775KNGDVhTwTlS2xc29Ljy5bsoi+1WMMB5DzjxCGo+/l+VMnnGzU2q5rYcI3D6XbqlVpZzBT3kuo18fyLrjV2+5EPcNt8fo8JEad9wrpmSPYNB+mb4pNE532mzj1kNNYJX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734331813; c=relaxed/simple;
	bh=uNEcSL9ANicyq3/3uGc0+QhzzdGQxoSNu8UPJ0WqJhA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=g7aY0/M+nLkUOF7lHF78LU3LXEMwCu3mKG13oHt9lYgnB4siKvdKz1Mn1e2GVxc6OaS0SAUvvN4D72QcHsdpXpiM4HCuxFEEysX7eGzmby3C4lpbh7AUYImXi7Qr1KWQtJ5OjYyLV6gYlTtc7oJDMnD2vFlGSXyEyuaef2RJblw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=HpFCraF8; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG4f0u4001058;
	Mon, 16 Dec 2024 06:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	S1; bh=RrfwBaCRwkT7srcPzS4EAy3Khf/VqAY/vN9J5afYjwg=; b=HpFCraF89
	FzaUgWK5l0e6yimnrNa1VxlASDICRpjGW7bMJ/bPQWzVHuM22/F9enHVqqFSIx6s
	vz2AsdKAfDaEo9Y+6Dn1Qq1+R+L2uB+JF9YHxlae7Hze0du0vqmUhX8k86U27Fry
	p9FJKH4h50HYdZujuUDZCkjGdCMcTivgkiCQUJp1wmr6WUvTrogtUBrh88w938X3
	8hsmpP96Q3Z6wwPIlXX86o/KlTXaaC4PfoLuufaOSdSj/oFJ7KfNRtB6ErrLKD+8
	VUnQ2XImvjT5Vs8R8uidVHQYTy/rY+hhkQZF1Md4VZObKrIiwGysLerK+qZesmM5
	8nPV1wVItBZeg==
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazlp17013074.outbound.protection.outlook.com [40.93.138.74])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 43h2dph6xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 06:49:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=By5PLiNvt/YRdYb5I2YGBaj2Fu6wOsTYclHhr7p8o3bDUidgp097vLpMU026ulIM1g3mqS/JaP11fK7uTujCB+xl4h5qXztA3Vl3upXq5fPkdWRF4qp1YP4X3SA5m/seUTnerm1hErqWcGh9PAYfd4lWg5zIqtApv+Ux0MLTc5sS2T3X6egLzFpiOdM+PWdJu+LJgyyo71yJVrH6TOuZH71Q1lnYjjWqz/plgdJA6DHFdcZoci52QbNY4ytNfBp46lLzMV9Wnw8B+dR55DkgTRBhqFvtaElDw04bx+qEq0MbExrdu4DHTYXofAwnqpfW+y2ZiVq0y3NFssm1c1tmxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrfwBaCRwkT7srcPzS4EAy3Khf/VqAY/vN9J5afYjwg=;
 b=OI943xe9WdY6J0Amxg1FScfQ6vxNsLtcyamcckS5jcliqc1CR1SKUV/qKNT+yF64hXUi5s97ScucFH/l1xVZF3ch7pQ/yxyhIesBiswSwe2PrlIEsMXIxbu9GY9SiMYW3p6vWGnhmX9rFifPg8ueVqE+l9equqmsLqJfIueNDf5AJslmPgmsgm2QhVn/XsDrH01IMY0te9dSkYpAO1b2bElc6NLkgUwBCqRutE4n5R3XhIuJkf5vWVkTj0sliwrAqDXkw+5ECSUWIUefGT3+U3ZGiJ9ObI3z1YdwAShxYLLIDp39rzk5ufBoRtZrwqpuLZzYHymqBYFFQLuoWZpu3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by JH0PR04MB8086.apcprd04.prod.outlook.com (2603:1096:990:9e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 06:49:51 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 06:49:50 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v1] exfat: fix the infinite loop in __exfat_free_cluster()
Thread-Topic: [PATCH v1] exfat: fix the infinite loop in
 __exfat_free_cluster()
Thread-Index: AQHbT4ZwRRWPpYQMFkW/JmXzHxF1MA==
Date: Mon, 16 Dec 2024 06:49:50 +0000
Message-ID:
 <PUZPR04MB631652FD1320924CD92D5ABF813B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|JH0PR04MB8086:EE_
x-ms-office365-filtering-correlation-id: 847a8d15-e7f9-4eb8-cb93-08dd1d9dd6e8
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?bzSTxk3FY4FUT7l+2dBRjMTPMuArESXsDTPFEMdovnjsG/+OC3US1gTBiJ?=
 =?iso-8859-1?Q?+ict/714bTsOHsIhXMAVtcsafuAzkj2DzmUZHzQBzLanEmObYVcR49DbGE?=
 =?iso-8859-1?Q?JiXrVBUPHo1MSslk2X6tjlwPnR6L+M971DqGvYiqwKhv7Pg6z+NMX+BzDZ?=
 =?iso-8859-1?Q?jvtPjF8WHwTs1plJeIOhlKlGa+d286zW+MoaTfJeGjaq6cW+TPTqKS/0dr?=
 =?iso-8859-1?Q?yCRKSuAIErR24/hNlzjVigTRaOQUKbauGeqRnQAScMkc9Huh/myUO7vVlr?=
 =?iso-8859-1?Q?H+ex0MoCBJNX26k2PTY1oaZYnBo5rH08T+oem++w4PQj6Ru5642K3UOQ2O?=
 =?iso-8859-1?Q?6msFOlwY2fzusAX+kDXYsk7uQOBaX10WCdSsh2N5ygeDxzAxckqUZwjAOF?=
 =?iso-8859-1?Q?k7N0XFFe1qpbQQUg2ACwf2EgQt7/BzC8cQLEIeqXcIa5QjITID/iYteO6e?=
 =?iso-8859-1?Q?OAs2eIOax37j0jcC0CUsI1jBUjjv1bVcm8DH3nX8p8EGaLXOACyfV75Cxc?=
 =?iso-8859-1?Q?YIaipGBg0XmuEmX40PJRNXuh7rwGBuaSKxVZ9Z7k2uroucA0VXPjkEDZR8?=
 =?iso-8859-1?Q?FmJSMql9bwocejSLgI8o34pV2DUhfrXgDJaBEWiYwMeEie5VgVqXhXfoT4?=
 =?iso-8859-1?Q?KdPD2lBH6+2brjfl8lGB7uXCLzDuLoJSFu6SkM4ff1wKfMaELXUrPMi0lU?=
 =?iso-8859-1?Q?l3owCCy4IbkMTn4QIsXxS1bYdZC/A5GgZKmGX5BSCEWJkUKQ0sKsrMs+Zn?=
 =?iso-8859-1?Q?L96K1t/y/7P+OLaXxshfcBAWscl50jHFWvsOWloATdbAAhcj4aNICDY+F8?=
 =?iso-8859-1?Q?wwvu8FziibaRkLCSMhPG5+ohC7ss7PnsiOdinQsRwRGPcJ29PTs14WC19/?=
 =?iso-8859-1?Q?LSjwr8KGSb0ZZQzEnaDTAlS+LBUWHtFIFvdcfjA2eTvAFNzRObWNZ4+1Qs?=
 =?iso-8859-1?Q?lDpSvhyY+XH3ciUhRWIlRkSpyYXvzZ6vh2lU2xzTbkQvg+N1Eg97AHAFMN?=
 =?iso-8859-1?Q?WKAeBGCs7rDgH8wMy3+oH6SvjYk+HZmUQmArKLcqh1pb0Xux5HWpEVRN+q?=
 =?iso-8859-1?Q?K7tBvGbl/zk5gRXMHnXRXukyc5YDENJPTlbFyxQAQOQ1x9NKuwDSuixdFA?=
 =?iso-8859-1?Q?PVwcaMdOIkz88B7jTZ/LDxs042cU/0sUDggmcMYmJZUbq78HGQl9s1yawz?=
 =?iso-8859-1?Q?alFnI3a2vNX1j/g3oFvEbZhaHoebMlXeXB/OPaaqsWJpHvuGTQVLamdOiG?=
 =?iso-8859-1?Q?CWPunFgXL1lo0Lfn1StBrmsmbpPLiL/IK+xVRntHVlBxC866uyI96hmquf?=
 =?iso-8859-1?Q?AunWzPGMyd16iFI6N/TptUdh5ekn2NGffHBWrx7TEz9Bv+UnEuQwnSEhOG?=
 =?iso-8859-1?Q?8DB3A2TrdvbylHe5T1x3VydCCRe9ykFbxov9kEHT5lNxHJ6gvJ1WvyPTTw?=
 =?iso-8859-1?Q?LCspcBJevtg6OFXG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?LVn5bx9SIf6RfH9YcZLgAdT+2FjN73yuVdVi2LcNB8CI9bjwdGr3T5qrq3?=
 =?iso-8859-1?Q?NFOxVlHFA1hlZarGDYbhNyjw6GxTWmi/2EN+4zVveK4X+QACscnaHVtxWu?=
 =?iso-8859-1?Q?avUoEvQFk53QQTtt5+urGVjnhZzmPdV6eytWyXBNw5+xevjP2ACanzr3dV?=
 =?iso-8859-1?Q?dQV3NxsApnI7yW+JjTVNhRjIT5XrM6bhNbLQ4i3gafFcStUWgfNfWxJsvH?=
 =?iso-8859-1?Q?ncTHLi7XpRHcpo8UUofahVAVXF4KkXSzTL/AS91flCRjkfw/DdKFRyJZHw?=
 =?iso-8859-1?Q?ETBnuE/bkYH+UKN3MTWA3P3DixCDPXRoUda2oxcE/XrEN8IAP6GoRJ/1Eo?=
 =?iso-8859-1?Q?QxXcz/QzIH4N+Ck1QOqkHrRHJFP0+k7Z10+aFMGKidI6Ij+BpLk/ViWrt2?=
 =?iso-8859-1?Q?7zVqT2TIqVfgygwspaDzFzRN0Wc9TEYRZU8STWKvRP1S3z8DKR9bMpZOpB?=
 =?iso-8859-1?Q?KhzrR9D6fWyHIGTiWE3A3l8ZHFK6zH5JZbk+lVx2NHsJ99Dolqa6x+AYdg?=
 =?iso-8859-1?Q?DeAteBZ43AzF+8OVLSm5FYQmlqRMuOcBB1Y36aqoVd6hk0KnYA2ZXM7yT4?=
 =?iso-8859-1?Q?3m2YWoakG8ZbbXKmn3DESPCl7j4Z/8vBqcWmZusXwTxTBUAfe1gTnp0Cfv?=
 =?iso-8859-1?Q?5iEJXVuBePckBKO82cRdgoeNGP+VzO2ccUW+pUyeqnmBbVOPEOv2CG1Jw7?=
 =?iso-8859-1?Q?NPUymD+zpTSTPjagxBVVgkXqZ7lC2oHZyHL9lErkweWkQg0QuA5snbN4o+?=
 =?iso-8859-1?Q?XSPpkFsceshluOoF7nG2qwI+jiPWyXb8Kr4D/2EDqB/wdJRpxtA02OXvyL?=
 =?iso-8859-1?Q?6stdsiPjRrZOan0VnkrYumjwUP6KYyo2/0pn0ReXNj0n1dTOgNIuXoIrTX?=
 =?iso-8859-1?Q?M0woEiEOKmogJw7wRv0N60h5M1u3NaW3cFM968Sp2wDGWDWf3QIIwp7bcb?=
 =?iso-8859-1?Q?be6WRH5UOsLzzqbh7UTj56Gk9UrLI4Z4t9gxIo1A0ZfldHxWuVR2f/utGS?=
 =?iso-8859-1?Q?dIY5fLHu3U0Kojt7FLvjOLyXj0yXWB5fm6i+Lk9uil/FFNfWm1+ccVjIbe?=
 =?iso-8859-1?Q?SQ7n7+xDtJYHZiaBHdBrtwqXRArC6W3MfJepE82QDZtYZFDCy3G5O9K/ys?=
 =?iso-8859-1?Q?XLqu64PNPrgWs6RMe/Ud8OBKhlO5ddZ7RPoERcLtxo+zDOiRnXpdyTZTJm?=
 =?iso-8859-1?Q?5jnQZSnkFn/f6FQhk0vvJSaQQeCj37MdIQ6PhDdmYvdmYjC/1Epr/5r06f?=
 =?iso-8859-1?Q?RW2a111wASfqlLfg3Naej1hnOKcRKRcVw74sOMJO2bnEYsIgmgU+0qSg0R?=
 =?iso-8859-1?Q?FX8wcwUkUB6WJNLT85nATkNW9ku3e2u3sGzQbv/0PE/wfNzCoA/4gG9pR3?=
 =?iso-8859-1?Q?ixGMuPbgyqAI5IDMhzCjqm7SHmgioZybH72RJOT5FCFBIwwAMFIgTTBldr?=
 =?iso-8859-1?Q?g8OksCGTv05fbGjod8SB+sUTNVvm/6uX6In/fzfO+/2CpORUVBvpbYafCZ?=
 =?iso-8859-1?Q?aESBVK760Lo7b80dsnqDgYN0GqPYWPTAVZaATrO4FPGmz0zvEB3dnCMi5a?=
 =?iso-8859-1?Q?+FDaHk7wOcQCnutEaULy6Tfm59f+DAjxIqSFwxoTBIyDT2fctZP5arys3b?=
 =?iso-8859-1?Q?fhaow5lBQK3cdvRdU8GPOs7Xhm1KnCmcDV0W3HEF4r4pzl7F5J7ReW+hF9?=
 =?iso-8859-1?Q?eCl8xifEs6SlS4BsS4k=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PUZPR04MB631652FD1320924CD92D5ABF813B2PUZPR04MB6316apcp_"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TTibb5kmRJD9FTpAgIK+r7jYCcEKhM/4WjuKazhojw1/X8UVffuglyO624HiO5rIPuWT6fDqORY0wP3hV13BmUIBt4pI0tWuskLPb3LKooUzwvbftqQYeuRG1PLT0VZ+6QPnTuyLhlyCAR9GQzqlIxz4n/Wj5LeyEh5ExO8wcShezJ2bB2wvrXCC1242GpsJh9B63chXXKmb7UFxc+t1/tZYkjGo77S9m7MlUzQuyKU/hCqGgj1QtKH4EGAP/KFHU+uX8UQ4GpkI+akxrcWtNfvZ+Q3NP4zwNf/BKqGgd5/PzIUR23yP5rUUMJv1NQwkp6L0swGTahA+/ZlsOliOekQfC43q9riGtCekt041CeitNcmprjXDZPQdubyqGHPqH0+ud3JZAUOP/OXa9OwpHPtWZc2bOm8rSMTGdY/Bqu8pY6rwEn2MAYHZ7BAVsj0z4ywRUEGdJ6IjGkkkNeQuPBSN+dcprqvC8U0cUMvHnXlruTTex96qZoWSrdXeVT6GeCwpys/zeZfgyZSYQpBDiAvEgF1aF+zWClwy2ktIPoeQgZNJd3aI2A8662smlQRBp4Z4FP4G6JjRFvsx4lbBEYvPU/5uCLC+vEI18CqXRxJg3fX0LjSQohwPQYKfub7t
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847a8d15-e7f9-4eb8-cb93-08dd1d9dd6e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 06:49:50.8829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A4nQS7mHUwC00qGxBpOhjjNeEUDjYVAjEXxLJldPEOqbS0+nUf1lLdE6b83LoX/p7U4k6gFfPjPFGq+pNnXuBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB8086
X-Proofpoint-GUID: cCYgIDm4-c7SNQOSEx6kb484t-ntxSEL
X-Proofpoint-ORIG-GUID: cCYgIDm4-c7SNQOSEx6kb484t-ntxSEL
X-Sony-Outbound-GUID: cCYgIDm4-c7SNQOSEx6kb484t-ntxSEL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_02,2024-12-13_01,2024-11-22_01

--_002_PUZPR04MB631652FD1320924CD92D5ABF813B2PUZPR04MB6316apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

In __exfat_free_cluster(), the cluster chain is traversed until the=0A=
EOF cluster. If the cluster chain includes a loop due to file system=0A=
corruption, the EOF cluster cannot be traversed, resulting in an=0A=
infinite loop.=0A=
=0A=
To avoid this infinite loop, this commit changes to only traverse and=0A=
free the number of clusters indicated by the file size.=0A=
=0A=
Reported-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com=0A=
Closes: https://syzkaller.appspot.com/bug?extid=3D1de5a37cb85a2d536330=0A=
Tested-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com=0A=
Fixes: 31023864e67a ("exfat: add fat entry operations")=0A=
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
Suggested-by: Namjae Jeon <linkinjeon@kernel.org>=0A=
---=0A=
 fs/exfat/fatent.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c=0A=
index 773c320d68f3..ab29c30ebaab 100644=0A=
--- a/fs/exfat/fatent.c=0A=
+++ b/fs/exfat/fatent.c=0A=
@@ -201,6 +201,8 @@ static int __exfat_free_cluster(struct inode *inode, st=
ruct exfat_chain *p_chain=0A=
 =0A=
 			if (err || n_clu =3D=3D EXFAT_EOF_CLUSTER)=0A=
 				sync =3D true;=0A=
+			else if (num_clusters >=3D p_chain->size)=0A=
+				break;=0A=
 			else=0A=
 				next_cmap_i =3D=0A=
 				  BITMAP_OFFSET_SECTOR_INDEX(sb, CLUSTER_TO_BITMAP_ENT(n_clu));=0A=
-- =0A=
2.43.0=0A=

--_002_PUZPR04MB631652FD1320924CD92D5ABF813B2PUZPR04MB6316apcp_
Content-Type: text/x-patch;
	name="v1-0001-exfat-fix-the-infinite-loop-in-__exfat_free_clust.patch"
Content-Description:
 v1-0001-exfat-fix-the-infinite-loop-in-__exfat_free_clust.patch
Content-Disposition: attachment;
	filename="v1-0001-exfat-fix-the-infinite-loop-in-__exfat_free_clust.patch";
	size=1460; creation-date="Mon, 16 Dec 2024 06:49:24 GMT";
	modification-date="Mon, 16 Dec 2024 06:49:24 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhOGM1NTAyZTcyOWFkMmM1ZjhiZDJmMzBhZWFiNzg3YWNhMWVlZjA2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IE1vbiwgMTYgRGVjIDIwMjQgMTM6Mzk6NDIgKzA4MDAKU3ViamVjdDogW1BBVENIIHYxXSBl
eGZhdDogZml4IHRoZSBpbmZpbml0ZSBsb29wIGluIF9fZXhmYXRfZnJlZV9jbHVzdGVyKCkKCklu
IF9fZXhmYXRfZnJlZV9jbHVzdGVyKCksIHRoZSBjbHVzdGVyIGNoYWluIGlzIHRyYXZlcnNlZCB1
bnRpbCB0aGUKRU9GIGNsdXN0ZXIuIElmIHRoZSBjbHVzdGVyIGNoYWluIGluY2x1ZGVzIGEgbG9v
cCBkdWUgdG8gZmlsZSBzeXN0ZW0KY29ycnVwdGlvbiwgdGhlIEVPRiBjbHVzdGVyIGNhbm5vdCBi
ZSB0cmF2ZXJzZWQsIHJlc3VsdGluZyBpbiBhbgppbmZpbml0ZSBsb29wLgoKVG8gYXZvaWQgdGhp
cyBpbmZpbml0ZSBsb29wLCB0aGlzIGNvbW1pdCBjaGFuZ2VzIHRvIG9ubHkgdHJhdmVyc2UgYW5k
CmZyZWUgdGhlIG51bWJlciBvZiBjbHVzdGVycyBpbmRpY2F0ZWQgYnkgdGhlIGZpbGUgc2l6ZS4K
ClJlcG9ydGVkLWJ5OiBzeXpib3QrMWRlNWEzN2NiODVhMmQ1MzYzMzBAc3l6a2FsbGVyLmFwcHNw
b3RtYWlsLmNvbQpDbG9zZXM6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRp
ZD0xZGU1YTM3Y2I4NWEyZDUzNjMzMApUZXN0ZWQtYnk6IHN5emJvdCsxZGU1YTM3Y2I4NWEyZDUz
NjMzMEBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCkZpeGVzOiAzMTAyMzg2NGU2N2EgKCJleGZh
dDogYWRkIGZhdCBlbnRyeSBvcGVyYXRpb25zIikKU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8g
PFl1ZXpoYW5nLk1vQHNvbnkuY29tPgpTdWdnZXN0ZWQtYnk6IE5hbWphZSBKZW9uIDxsaW5raW5q
ZW9uQGtlcm5lbC5vcmc+Ci0tLQogZnMvZXhmYXQvZmF0ZW50LmMgfCAyICsrCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZmF0ZW50LmMgYi9m
cy9leGZhdC9mYXRlbnQuYwppbmRleCA3NzNjMzIwZDY4ZjMuLmFiMjljMzBlYmFhYiAxMDA2NDQK
LS0tIGEvZnMvZXhmYXQvZmF0ZW50LmMKKysrIGIvZnMvZXhmYXQvZmF0ZW50LmMKQEAgLTIwMSw2
ICsyMDEsOCBAQCBzdGF0aWMgaW50IF9fZXhmYXRfZnJlZV9jbHVzdGVyKHN0cnVjdCBpbm9kZSAq
aW5vZGUsIHN0cnVjdCBleGZhdF9jaGFpbiAqcF9jaGFpbgogCiAJCQlpZiAoZXJyIHx8IG5fY2x1
ID09IEVYRkFUX0VPRl9DTFVTVEVSKQogCQkJCXN5bmMgPSB0cnVlOworCQkJZWxzZSBpZiAobnVt
X2NsdXN0ZXJzID49IHBfY2hhaW4tPnNpemUpCisJCQkJYnJlYWs7CiAJCQllbHNlCiAJCQkJbmV4
dF9jbWFwX2kgPQogCQkJCSAgQklUTUFQX09GRlNFVF9TRUNUT1JfSU5ERVgoc2IsIENMVVNURVJf
VE9fQklUTUFQX0VOVChuX2NsdSkpOwotLSAKMi40My4wCgo=

--_002_PUZPR04MB631652FD1320924CD92D5ABF813B2PUZPR04MB6316apcp_--

