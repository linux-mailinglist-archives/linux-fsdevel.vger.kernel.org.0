Return-Path: <linux-fsdevel+bounces-38287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 732809FECDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 05:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437F81882F68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 04:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8105D155C8C;
	Tue, 31 Dec 2024 04:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="pIQjv0kZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF6B3234
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 04:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735620956; cv=fail; b=YjOF6sJsbuRwA70y3cw4J4yL7KrmhOtqSuUZ4cfQ0daohmp2WD6uycIPiLKUvHdIhnusZnsesVWmXZ8VaxNB13MKcnZLK9oyS5tDSgYDRcK/snnk4LOvf/8MXpLAtc/3hktLBzdb8HkS4n/k+ouEdDexP7vJ+m8HocTGywfxk7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735620956; c=relaxed/simple;
	bh=ow6+qMMdkCgMeVR88AKX+qatdaFW/nNwvfFwhdNU8to=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JG1JShrPAqd0BeFt4VMt6ZTEzbMASO1xxzQSJ/M5N7sxIwEQ7f5IXmL3j0oql3fhURr7Gz8v5iqaqQTAR8awdYt9ANpLRxX1KAMK75x3lqtQFkzmEzQq/Ev5HaMWu50aK/OmAnxZWi7AFjAvgx9zQ3fjOf8LXEqdg0sH0M0t360=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=pIQjv0kZ; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BV4Vr8A008739;
	Tue, 31 Dec 2024 04:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	S1; bh=8cPUXq2eeykATpwGYeQZPhDgv131AdNM7hf4yHCXQ+U=; b=pIQjv0kZS
	+iDFMReeFmy1RviQ3JVtGcpHHPsYHM2WBUwfpJxE3XFvphLqP/HEUIhZvDBZVHXI
	svqPAkpZNir95m0FdoSM5v5WPoiZONVRrsYEDOoqJtWYY2D7Puu4Pp5iKwPkx+Mu
	goOORmrz+ugC42u1/H0Q5Ient8M7sRnAwOgompoOA8FAAIW8iE+cX5dG3Ts1FTR1
	Dgj41CGsqfguCDYE3ZDmrLvGF1E7d/mM/jNqFu0eB150n9Y0TZgD1d3OONwsVWOC
	KqpThXDBq2Lgk3d/mGVhGYlF+QlCqr94HcY9ysCfMtvVjt0GnpLukK05a2DVoniQ
	eSyCMazZzDBJA==
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazlp17013074.outbound.protection.outlook.com [40.93.138.74])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 43t8441nw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Dec 2024 04:55:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOXdeBCuQjP/wma4MD5vyUedGxECm5qWBD+DM90zhcnY6YWybO2pnOhlY0YdukA5/l2AvbwpWNxxnPNN0AYGF0fFh6afCCLl9jcgqkb3Z/dzAxgI/lxsZolDrGCeiJzYgsTVSq1ampsKwPA3YZAqN15hpAyP5XwhU+3qLW4pS6y1s9PJuFNla/ejET45rIISaRHC0R9bDwsebNKz3kwSxCFAX2uQrIgPCZq8ReuRp1FD9USspD5jehSGjwVvyuWiRDn3mUNQ8/M37dt00Oqr4Hrd2Ugn12z6bgjsBf8mQpU7Qiim3VAFv75u/4yJRElSvDPYLUL4Ivc2we3vSvvpdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cPUXq2eeykATpwGYeQZPhDgv131AdNM7hf4yHCXQ+U=;
 b=ewWLN6ypmtXaW0iaxGNCGwGATRhUvc1nllPlZZpn7LPXEmA65zrfdmOovV2KCIcoGImm8+TPowntlzbLQOpFSkvh4E/8bNWl7wn4ykjqQufQ4w7XsBHN4feR728V/O7wbx+6brkeIiTvVAZsH6j+6aueyurkwKrfpXln7OqQpTYDAeyrweSWxfFoBbRNpZ7fk1+5J5J/L3dSFEpPxkNhWo+dkTLkuDzYemoUyRwkVBhD5f5KjHnty0oP9yb59fyv8rLcieLM6Lus+ueTMoQUUtb12rysqoK8tUsCQviMa9eVv+WpLpAWzn8Oh54lOjY6NYcyVS+XYlCRZ4LDKWCXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB5898.apcprd04.prod.outlook.com (2603:1096:101:7e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Tue, 31 Dec
 2024 04:55:30 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8293.000; Tue, 31 Dec 2024
 04:55:30 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2] exfat: fix the infinite loop in __exfat_free_cluster()
Thread-Topic: [PATCH v2] exfat: fix the infinite loop in
 __exfat_free_cluster()
Thread-Index: AQHbWz8bVzA4/x0ZA02mbh+4GV+EAg==
Date: Tue, 31 Dec 2024 04:55:30 +0000
Message-ID:
 <PUZPR04MB6316CCBBA0DD68C90C9333CB810A2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB5898:EE_
x-ms-office365-filtering-correlation-id: c228a0df-c2ea-426f-882c-08dd295759bf
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?AI9MqKsu4o9wyBv9a+48NwIoX+BxY+OAOdF+lXG3m7rG+p1Yd9yddhFK7o?=
 =?iso-8859-1?Q?Dngv5rf6S1aigfy9SkeUjAOprwTlqayqhjvJV7HcByEmlTuTHDvACuJ78s?=
 =?iso-8859-1?Q?7YCRd2qzOYdLzahBRAiUt49uh0yNnfo2b2PRBG/ZdYJQHwRKxTE7Uir3jm?=
 =?iso-8859-1?Q?uYg8ScnmmYyppeU7Jsxuze/aP66RVlE71jfFeN+ih/XniltHf0gbi+x95w?=
 =?iso-8859-1?Q?sdyKaRZJG8QcqVZ4eJpWTuCv50QwzSBtEN5AjZAvS2DAXyoctGZMBCSz5v?=
 =?iso-8859-1?Q?AISv3rrGJmG3/xzeb737WFX32WpylUanc6mSQEhJgsHK+JxDH6TQytjmah?=
 =?iso-8859-1?Q?pzDnbyX5dmuug3wTV9lpInustID1Q2Cnydbw4YPf05CaVG/aJsmwQFM8uG?=
 =?iso-8859-1?Q?tM7R2ZbvIkoyhb69QxglAa1o1CiD5nEpTLMNwpsNXv0/0uQ2XegOQLPJVu?=
 =?iso-8859-1?Q?vQQe8yYJu8YZUKN6npElfGmlfxElBqgQT2SRt4Ym/gaBhh1xS1bI2M1F3y?=
 =?iso-8859-1?Q?oUjrI2wkg8Ia7IrIffBX/sbqSv2XTFbxDgbApGVgfGmN/teHYHRfunoav0?=
 =?iso-8859-1?Q?1XoLXwxMW4UIegz1ydS5GTtw/LWCGwg7j7N8ezOBQNMtf7WHUYAOKMLo2r?=
 =?iso-8859-1?Q?E2wXwW7Eu5/YvL5eTcFvxpsg6ZXGXPkuvm4M7D6F9/5N9jagI11LP3LFHQ?=
 =?iso-8859-1?Q?uPec4xZqh8lJsxTZKZEvUnYbamSO9FFa9auJuwoTk6CSHyX7ha3bCFGqUP?=
 =?iso-8859-1?Q?MXpTTZ1w9Ipd/baSIW4NzW4R1T+d5v/Rondu9cB+7FzKh4P9p9WgTalcCg?=
 =?iso-8859-1?Q?gCKNZhLI45cWMeVOdHE+u6X/62XvLLSw3FtMXWJIE5juI7xVNamRCohYol?=
 =?iso-8859-1?Q?j8YJ2iuVAYVMaAFI1w8Jn0IJR6o4JkFJGmQWre3FE4QRoiB70qrtEWtkY5?=
 =?iso-8859-1?Q?UqqmTHTgRZcwT6K4OF+tU8ZtN7sr99xQB1Onq+z7Co0clTghUwaSiV3AEW?=
 =?iso-8859-1?Q?KcBmDoI0l/PvoWXS29S36yL4GTv9FT81ZOvQQ4fC6hIF3H6BEZLR6PswWS?=
 =?iso-8859-1?Q?PHYVogdg6/ivIL+RATiksdqkU/VbLw+qxAH9TWZC6n457MVVArid0kiK2r?=
 =?iso-8859-1?Q?zyRRbVboIbxpb9LaXDUv2Sfs34L5A3+RDaqxjeXJql8i/bfP0h3vVrAONO?=
 =?iso-8859-1?Q?K7/cnhJPDZ1XuPIVQZ4+AJ/FXr/aVlse28xlM0SiatAxcQeakf2dCYb5rN?=
 =?iso-8859-1?Q?odu1PsVaVsTi5nnJn3H1kKW2C7JHUiDe8tFpyy7p+ThWWXN63etnmhwSJB?=
 =?iso-8859-1?Q?m9khCTo+HPkBzvu1kud/9ocQzPtwlcqXXSWr6rBFlbVEAB5XIlIHqk3Oi1?=
 =?iso-8859-1?Q?4rLdLWJBiogj9FfvBYQ7NfHI+OsVilGg/d0ZSBa4ijk4QNvtpeUhg+2aTX?=
 =?iso-8859-1?Q?TylyJqkAr4E0+u7O?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mJPQesBq1c6V6IcuxfhRrBol3Cp61clBE9S2DXcXN01AUim7B5e91kEYUy?=
 =?iso-8859-1?Q?2F8X1AMQILCFeDwTrPrKOTmF+WE6b7Cvm4+CNSX8DVA1KUwxOFOwf0TECd?=
 =?iso-8859-1?Q?arFYlrQwT4fh9GYJQsBCQUOaXEn7nm2u7ubHlZYPpgTwtNdmmttY52btIx?=
 =?iso-8859-1?Q?vs5D9gseWD99xvZ7FjF7zYTHSRrrqOyblEDcgeMmbBYd3oLRw1uGCO8Ox4?=
 =?iso-8859-1?Q?UmyDKVDzfOr5VZqscpFMA5m65uHP/i8Dn33wvfQILDohWkPgz7qeYdCUHg?=
 =?iso-8859-1?Q?xTvJNe1t3Lrr3Ksr3v7jOH7qla8ZwPR0uwBFsBbeFVT7eY8ZAf67FgEVRc?=
 =?iso-8859-1?Q?M9lzjSXjWH2bdreTuNDi+CJkgkcZZW78QffSBclbrrNv62vLWMK83AF/gk?=
 =?iso-8859-1?Q?rst9xsEOR1Zzkufc4Okz6Z/UOplGQ6wknoN3Z6nA/4FLgy/msd/kQOqG1l?=
 =?iso-8859-1?Q?7wIx5vPHZlaYhKFCJN4BEHr1MY9En+axpRtF8dJEWoumNY8qfOV75Fzb3h?=
 =?iso-8859-1?Q?B3qffh3vlyWA+iXBkaScKe+vlIvETOrePmzEPspvjdcH5p8wgVNjnlgXIm?=
 =?iso-8859-1?Q?xMKS+cSAGqd34btpOgdYv9Fcx+9YZAufjVMaqmJsNVT5PoGLlP2LpMUKk2?=
 =?iso-8859-1?Q?mpmZ85vWTz21kpOMjzjC20ft/uw0TBrdgpzdRtHJghNktSfQiU9UrDapOH?=
 =?iso-8859-1?Q?61DbVIVogYk4PcNsEGIkYqoduvMvCkHwR7lGOwyr5NP4PExiTWzF0R5KYh?=
 =?iso-8859-1?Q?mhMcvuI8d5h+jBw8vQIqmsH4Xn8IP56K0ND8BRD2wyk0r2oWoDpUEeacfg?=
 =?iso-8859-1?Q?G4X/tVwyAzVef/LM2oioN4cY1H3Pj4iKHnc8XaSQHPUOo8jBZZyXSZbrAu?=
 =?iso-8859-1?Q?d8Dt1ZcTqnceHg/iTRKnZ39P6eUMcZ2gM5a2Rg1IOzROSxHisD5PsOPXpO?=
 =?iso-8859-1?Q?3utZfEmgCiFDJTcxCxijPzlIJxvePkiNH1N6bIPAL2l02HmwcIbk3h9lCf?=
 =?iso-8859-1?Q?GkceHmXgqGCo/6qZJccVjltLJfYBEncrFjYyweyAl46kpegQRLZEVzd+6r?=
 =?iso-8859-1?Q?3qDOekrGTT0slfr6bZDJwsWBVtq2LRtHDU53aPBNMp4dIZolJnwg+HBxec?=
 =?iso-8859-1?Q?Il194nMHRrSDah0oryYto6E9VRD5cAFviM+Z2+FWQ/zFMrcgCFJgA+1qUW?=
 =?iso-8859-1?Q?K14Z2u3viTbIurjO1V7wAXEWVp4D/z20HxjOgXS112zvBLxCDocOTc/Dg0?=
 =?iso-8859-1?Q?+c6gQPwODLWWa6ZAse4hwhyfEt5/olOSVewbS+OziEnJZYUyAKkufQ0ps4?=
 =?iso-8859-1?Q?Q9531B8kz+y0XsM3i5maceHBJ4sZX5pVwqOJf5KlnNqjSprHqFJ/XJ4nS3?=
 =?iso-8859-1?Q?zBV17cszUwhwcu1uZXGePfdNSCZmrIeHs2f/e7xx4HTZaLr8sqMB4IRFYF?=
 =?iso-8859-1?Q?g2omULfSpXkTbusOdjc21NqbWELxA7A0va7AQCKnZW7S4lwZkJVu8qmEhN?=
 =?iso-8859-1?Q?5ekUIu4LfKfGupHAGQVGn7XtVLHVtnixYFziWnPGo/V2pQFs/7LtAIlaUM?=
 =?iso-8859-1?Q?ob42fFB/ZHJDBgHBbmTCTalfHT4FHobEsY5Jnr3eAXeVeYyhtBaWhNCpNj?=
 =?iso-8859-1?Q?FBS7+RSBMF1vYwiuy15nNhzK60ailshvjxqiNxRCTMNalzbU+uC/d4K+/w?=
 =?iso-8859-1?Q?6igvRqJycvF4KEVA9O8=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PUZPR04MB6316CCBBA0DD68C90C9333CB810A2PUZPR04MB6316apcp_"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CYLmnAitcAe9HNSVpEJU47K+kUH+WxYBCetbw9v8nWpvaVPdE247w7qt+Hq4xGuCZG6BabaAbr0PuV6N2eRctD6JaWUjOqL8LM0MPtqpvadUBmXOTf1T0n084LPkmv6j+dKzuqyNQLD5NXqMrNv5974mGgHYBFXtVoTVUsacGMJq9iOnmtsWorgA4Po+CpvIyuNIuvNJG9W2yDeeJt2adD47y3pTfdtn7F98CRGHrGWAo5j32zXqbZZ54xL6KTeoZoaDG7BhSDF0xbc/O4o1mL9y9bvHgd9XqBdCYTnF6s6+ARGFRV0XN3K3qc/IFYxJZiemYMx5ZKkrbL2RDeYE0Wuv5ZqIrVaQzg9YDhHVHZ5Z9r71VnDI/8VCo+XixjY0Q1BwqZw8cA8WS/4Le+J2y0Tzd+AEkBL/QJF/mV7vtujMNKNTtF010c9fWX1RDfdCBaX7n5LhpzphnLr2qyVJ8cM/K7dQKTw3pP4PCP1RitlhMdf6S1Uid52RYDm9C1L8wc0gqQ9rGXmwMyJlUNLzTYgZKtJMei5VspM32JlGpupEpYC5WaCrFFGpnkoQ5tNTUxCZoPchHVDbA0ZkP+RZlycdcwYMx0CdPRpd+HEdWnJvWSMTr1OmoG3lUheV4TGz
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c228a0df-c2ea-426f-882c-08dd295759bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2024 04:55:30.0958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TfSOpotkesWIhwWE3HZ3oMS6JGSXEd7+Lx1X21CwQ2ByWz64TQCmtgzM/tjdi+3Ij8gDEb7gqmFJmjZZ7G0Irw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB5898
X-Proofpoint-GUID: aYPvSrktRop1nZA1yb3FVFkW1cd-ioil
X-Proofpoint-ORIG-GUID: aYPvSrktRop1nZA1yb3FVFkW1cd-ioil
X-Sony-Outbound-GUID: aYPvSrktRop1nZA1yb3FVFkW1cd-ioil
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-31_01,2024-12-24_01,2024-11-22_01

--_002_PUZPR04MB6316CCBBA0DD68C90C9333CB810A2PUZPR04MB6316apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

In __exfat_free_cluster(), the cluster chain is traversed until the=0A=
EOF cluster. If the cluster chain includes a loop due to file system=0A=
corruption, the EOF cluster cannot be traversed, resulting in an=0A=
infinite loop.=0A=
=0A=
This commit uses the total number of clusters to prevent this infinite=0A=
loop.=0A=
=0A=
Reported-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com=0A=
Closes: https://syzkaller.appspot.com/bug?extid=3D1de5a37cb85a2d536330=0A=
Tested-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com=0A=
Fixes: 31023864e67a ("exfat: add fat entry operations")=0A=
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
---=0A=
 fs/exfat/fatent.c | 10 ++++++++++=0A=
 1 file changed, 10 insertions(+)=0A=
=0A=
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c=0A=
index 773c320d68f3..9e5492ac409b 100644=0A=
--- a/fs/exfat/fatent.c=0A=
+++ b/fs/exfat/fatent.c=0A=
@@ -216,6 +216,16 @@ static int __exfat_free_cluster(struct inode *inode, s=
truct exfat_chain *p_chain=0A=
 =0A=
 			if (err)=0A=
 				goto dec_used_clus;=0A=
+=0A=
+			if (num_clusters >=3D sbi->num_clusters - EXFAT_FIRST_CLUSTER) {=0A=
+				/*=0A=
+				 * The cluster chain includes a loop, scan the=0A=
+				 * bitmap to get the number of used clusters.=0A=
+				 */=0A=
+				exfat_count_used_clusters(sb, &sbi->used_clusters);=0A=
+=0A=
+				return 0;=0A=
+			}=0A=
 		} while (clu !=3D EXFAT_EOF_CLUSTER);=0A=
 	}=0A=
 =0A=
-- =0A=
2.43.0=

--_002_PUZPR04MB6316CCBBA0DD68C90C9333CB810A2PUZPR04MB6316apcp_
Content-Type: text/x-patch;
	name="v2-0001-exfat-fix-the-infinite-loop-in-__exfat_free_clust.patch"
Content-Description:
 v2-0001-exfat-fix-the-infinite-loop-in-__exfat_free_clust.patch
Content-Disposition: attachment;
	filename="v2-0001-exfat-fix-the-infinite-loop-in-__exfat_free_clust.patch";
	size=1510; creation-date="Tue, 31 Dec 2024 04:52:38 GMT";
	modification-date="Tue, 31 Dec 2024 04:52:38 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5YmQwZTlhMWZjNmYxYzU2ZDNjN2U5YWU2ZjgyZmJiMThmMWJlYTkxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IE1vbiwgMTYgRGVjIDIwMjQgMTM6Mzk6NDIgKzA4MDAKU3ViamVjdDogW1BBVENIIHYyXSBl
eGZhdDogZml4IHRoZSBpbmZpbml0ZSBsb29wIGluIF9fZXhmYXRfZnJlZV9jbHVzdGVyKCkKCklu
IF9fZXhmYXRfZnJlZV9jbHVzdGVyKCksIHRoZSBjbHVzdGVyIGNoYWluIGlzIHRyYXZlcnNlZCB1
bnRpbCB0aGUKRU9GIGNsdXN0ZXIuIElmIHRoZSBjbHVzdGVyIGNoYWluIGluY2x1ZGVzIGEgbG9v
cCBkdWUgdG8gZmlsZSBzeXN0ZW0KY29ycnVwdGlvbiwgdGhlIEVPRiBjbHVzdGVyIGNhbm5vdCBi
ZSB0cmF2ZXJzZWQsIHJlc3VsdGluZyBpbiBhbgppbmZpbml0ZSBsb29wLgoKVGhpcyBjb21taXQg
dXNlcyB0aGUgdG90YWwgbnVtYmVyIG9mIGNsdXN0ZXJzIHRvIHByZXZlbnQgdGhpcyBpbmZpbml0
ZQpsb29wLgoKUmVwb3J0ZWQtYnk6IHN5emJvdCsxZGU1YTM3Y2I4NWEyZDUzNjMzMEBzeXprYWxs
ZXIuYXBwc3BvdG1haWwuY29tCkNsb3NlczogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20v
YnVnP2V4dGlkPTFkZTVhMzdjYjg1YTJkNTM2MzMwClRlc3RlZC1ieTogc3l6Ym90KzFkZTVhMzdj
Yjg1YTJkNTM2MzMwQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KRml4ZXM6IDMxMDIzODY0ZTY3
YSAoImV4ZmF0OiBhZGQgZmF0IGVudHJ5IG9wZXJhdGlvbnMiKQpTaWduZWQtb2ZmLWJ5OiBZdWV6
aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+Ci0tLQogZnMvZXhmYXQvZmF0ZW50LmMgfCAx
MCArKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2ZzL2V4ZmF0L2ZhdGVudC5jIGIvZnMvZXhmYXQvZmF0ZW50LmMKaW5kZXggNzczYzMyMGQ2
OGYzLi45ZTU0OTJhYzQwOWIgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZmF0L2ZhdGVudC5jCisrKyBiL2Zz
L2V4ZmF0L2ZhdGVudC5jCkBAIC0yMTYsNiArMjE2LDE2IEBAIHN0YXRpYyBpbnQgX19leGZhdF9m
cmVlX2NsdXN0ZXIoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGV4ZmF0X2NoYWluICpwX2No
YWluCiAKIAkJCWlmIChlcnIpCiAJCQkJZ290byBkZWNfdXNlZF9jbHVzOworCisJCQlpZiAobnVt
X2NsdXN0ZXJzID49IHNiaS0+bnVtX2NsdXN0ZXJzIC0gRVhGQVRfRklSU1RfQ0xVU1RFUikgewor
CQkJCS8qCisJCQkJICogVGhlIGNsdXN0ZXIgY2hhaW4gaW5jbHVkZXMgYSBsb29wLCBzY2FuIHRo
ZQorCQkJCSAqIGJpdG1hcCB0byBnZXQgdGhlIG51bWJlciBvZiB1c2VkIGNsdXN0ZXJzLgorCQkJ
CSAqLworCQkJCWV4ZmF0X2NvdW50X3VzZWRfY2x1c3RlcnMoc2IsICZzYmktPnVzZWRfY2x1c3Rl
cnMpOworCisJCQkJcmV0dXJuIDA7CisJCQl9CiAJCX0gd2hpbGUgKGNsdSAhPSBFWEZBVF9FT0Zf
Q0xVU1RFUik7CiAJfQogCi0tIAoyLjQzLjAKCg==

--_002_PUZPR04MB6316CCBBA0DD68C90C9333CB810A2PUZPR04MB6316apcp_--

