Return-Path: <linux-fsdevel+bounces-73189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA04D11126
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 09:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84A33305437C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 08:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF93C182D2;
	Mon, 12 Jan 2026 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="NSbMGHwY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD14255F2C
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205351; cv=fail; b=aKF9FCmP4oqCWtkEJKB9ewwK4VDvPFDYKIifdfWP2vbLjiXk+gVyhhTHeejPnPcEdyY6qDjVHnH3huAO30rIxwcpFx52OX0qH6EG3TfJZE7ojb99vwplEzpdbRbbMriy2IXq/0A0aKqctd6cwdpaDr541oRKZ52LPPYMVzHhyj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205351; c=relaxed/simple;
	bh=yUQfFlR6Faiwly7RylzeDJ7ODP9LAbXfBxLXC0/6DNE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XlM4WizLSGMUtrSOMe0sY3y9kccavCuAhFhSkWqEycmRwtDnesnr3DHSyFQET7aw0yJ42ptaeVQ0ZdDF9AtsSyXhWEJvZDP2qaHqklRudidPXWqptgif9LTso3lXNLts1/1yCf2LTmA7gtjwFsyqRqnj1AW444CH1uD1U4On5Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=NSbMGHwY; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60C6w1NB018670;
	Mon, 12 Jan 2026 07:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=48KCNrX
	UObzRNSe8g6hmwQLumb0O4UKKSTfsGQI4KCY=; b=NSbMGHwYMgYwuc5RYmUkptt
	//1NNyktINC1T/5AXx90E4SqgBZ+H00ZuxVV4U8s0ddoZNwidzc0DkvuFhHRwcSH
	UUkV0QZdP+32xjsw77C8k0z6ylKRAOJoI5xLJqKm11hbagytsg1EWKkG9GHvnZjC
	tXr5SHMoTtgDwoQ+gE3ffc/IjLjYvsIWPH8c3J2hRVu7aatFonbCrGGT7Uo5tIy8
	BTlW3O5hc8h665Fp0ZKcOeFBA1merQL+ZTAc7AlTdJSyeZbjbV+74bMbzBn3mIls
	Ug5ArIDxC76UuhsPHHyijel101hoiUtLTNtxZ6v2g29QQWI1p/xUF+niQMW77jg=
	=
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013008.outbound.protection.outlook.com [40.107.44.8])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4bkteh1a0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 07:49:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByI4QknvXJk00C3c/DX/RuMlHe3AS4FxrTymMDMh8URmyA3kDH+4IQCX5nstR5m5YJrQRpA1wtliZaHOeNXB0YObNstCmuk1WHpgir3mnV/bc37jip9Lpx9Bjp5yFfkKqhRiSnzH5wsN8OrBRLXwnZH66j4+06jPH832WudV1GdjXdsZ9iwfTZdhVPiCIvZ+RZl4F5yK/RamQhMNEYd08tUuf96daFzZDboQO1+DbIaFMSEjPXUsZWXxxHcpxS+Uf6v+7YvxK5dcC+Fx50iGcqTzcM0gplbIpUKO6OlP0grWfCAmfVd6+6UCvdmX2ldLmEgnNYJXK8sOJKwkwrqM7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48KCNrXUObzRNSe8g6hmwQLumb0O4UKKSTfsGQI4KCY=;
 b=AUGaZDyUk4Ej6/dr5Nxis0WM2d4pSQ+c2RNVV2d/w3bamIRPMSAnfcQcOm5zFm5T+eSHz4j8Si2ITgCC8sZUk0rzrZB67q5phlXPqx2uh2KouZeUVVyoJyANLCp70ttmm8A3V0Yl+yN5989CsbxtcKkVMfiiUtq7ED6kDyoZHDH8UAMxLr47v7b5Mm6bDAGwRO+Q3fDZj+O6CgrUpe1+C3LqFjQvz3gYDm4EhlPzlgeyorfkmeoqzF0h+/BCAo6QxW5lFWP8po/NR0cXbOk1EhPkjiUMroI9zOBUiEitjPstRCUKzWMbTSq/XGgB0ny6jBe0L5Io47mJtCKKfEpL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SE3PR04MB9236.apcprd04.prod.outlook.com (2603:1096:101:2ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 07:49:00 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 07:48:59 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "willy@infradead.org" <willy@infradead.org>
CC: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "yuling-dong@qq.com"
	<yuling-dong@qq.com>
Subject: Re: [PATCH v1] exfat: reduce unnecessary writes during mmap write
Thread-Topic: [PATCH v1] exfat: reduce unnecessary writes during mmap write
Thread-Index: AQHcg5fpslQqarRq2EuBOQC4QqcEGA==
Date: Mon, 12 Jan 2026 07:48:59 +0000
Message-ID:
 <PUZPR04MB631645EC670C756D3C5D26538181A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <tencent_E7EF2CBD4DBC5CC047C3EB74D3C52A55C905@qq.com>
 <aWMy-4X75vkHmtDE@casper.infradead.org>
 <20260112070506.2675963-2-Yuezhang.Mo@sony.com>
In-Reply-To: <20260112070506.2675963-2-Yuezhang.Mo@sony.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SE3PR04MB9236:EE_
x-ms-office365-filtering-correlation-id: 14e84af2-0e29-4b4b-f45d-08de51af0c08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Qb9BVeiBFmuhGX/bMiOT2BszBBV3Caq1lK7nmJdpuZ98FSAYVzC1JAa14X?=
 =?iso-8859-1?Q?0ois3GzHaQ1kNdwKRcDiwUXLzZoAbCXXjmsjWtX9GWP4/9XMcnQyW/aR8K?=
 =?iso-8859-1?Q?lTHO0BxotzuyQZdCZo6mVZJNgC6TLIpAHywgoKjj9Q0AZMS8uW+UaHEWuN?=
 =?iso-8859-1?Q?AVrUzYn5REdkyhaK8FjTrmim22rRadPyRbC9aeh5U5KHqVmKXLHv1TPzEq?=
 =?iso-8859-1?Q?Y2Ya7Q7UgdK5+QizqaVqbgCeQHkK9SdUInH8irbzYHY1TFqMSEkq2nFeJb?=
 =?iso-8859-1?Q?7OYMgOhluHZzdUrEDY4Y7NWgZce4OgOFZT3upc8PTL/ZmZ0Tbc+ToRTCJz?=
 =?iso-8859-1?Q?hSJCP8cAQL9OjfFl6B0Y4OqqunuBmwuFUdbxkmpONOfCbKaR7RIDw/94bc?=
 =?iso-8859-1?Q?BKqBo4v13EdisbGo/sK4ZlF2LirCZOfxy2KOpVJSBk89tsyPvbEYIvYyRi?=
 =?iso-8859-1?Q?WmpDIvMvSqBObwUpJfCOHP5L0ppbQUSgG/JjE8tgkyXdocUNpUklCldIGa?=
 =?iso-8859-1?Q?SStZuoWtwqLZvPZmVRKY5EvLHddVCD2kqn4BDw4J/sVm4OXUCYWCwFMLZz?=
 =?iso-8859-1?Q?J8sLWY9D4FScz84kJ6lzlTH2Xz1zj62Qh4APVOkEw/VhD3Fw+5amqjGaEJ?=
 =?iso-8859-1?Q?RikrnUuvhiWsNmpIK+dJEaKnBOVzuPt79FSQf28SEtdtYfuDFJj8xDOpvF?=
 =?iso-8859-1?Q?9sWIMLN2FqCh0WVKk4icbLr8wLiN0KEzIXTv6U/4BgcuS2rIobEiBzW3Kr?=
 =?iso-8859-1?Q?T0cCYgVea/SAh+lgHn127yZmhCP2J2DzHkFP5T285XDtYKh+IQpv1o+A2l?=
 =?iso-8859-1?Q?wIz+33IVf5cCixvfLdBOuJ/hmrcMiT56NH8O9+pVHlAGBtRkfnx7P7d7SA?=
 =?iso-8859-1?Q?SPpSZ+UdV2+QzT68+X+oRNVYWv4/nX5fMECfB9Msh6c12QiqkmOD+FKHUv?=
 =?iso-8859-1?Q?5Jw+s8ORqZemUViGCKCrc9wd/RynJQ+z8Er27wcnGRq62zEeCByMLhKSJA?=
 =?iso-8859-1?Q?CbRsSYF0dwNxr7D3m+/7PJqOR4KPxJCBFwUYBiUjjWF5jqHxVJZdEHerTE?=
 =?iso-8859-1?Q?Pc/sFk19Rw07xtnhNM1jdxp/feaSbWSep37P24NJNpXHzL2Yq8aGVFcbxH?=
 =?iso-8859-1?Q?iELaVCd90Mv1IyPSL+eoKqdQZ0OH+ORFgaK4r0GBXesMzzOhl+afMR1vCC?=
 =?iso-8859-1?Q?9daQhZoCkilhc2S/hkTMdpShUo+uv4FwPcuZlvGE4xhxvTYrNh1VYfWwzS?=
 =?iso-8859-1?Q?84M8wcl/8xE9+qHx2QaSSRb6MEvvfDI7IZL/CXt7EHzEYxG+MBSQy0LhFC?=
 =?iso-8859-1?Q?4fao3inrEl1aycpLN3sV11UuGxKks8nM74qGUqveNBXJriKwt23yswrdUA?=
 =?iso-8859-1?Q?xRY3JmChATW81a1pzmhAYZ0u9wTqecG4PWMarjvVIYJOgPQ+Yd3iupF7YW?=
 =?iso-8859-1?Q?RM+nGMo4UU3kRcIpjaamC83Ga+KJlWkISTVd/XOUB+6GfVkedACXMj6QsA?=
 =?iso-8859-1?Q?GhuJFqZr4s+DTVOcWOicEDUq4f5hMLH3OQzcXtC5HM+FNzaK5ICV9P5/hO?=
 =?iso-8859-1?Q?KdXONvN7uQYGwkGfw6xMKgIMZJs8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?iOjowP7wbxPRaeqWL/TZuWiAhIUkGxraOj+Cb7IxqQdvYx//Lh8Q8MJDWT?=
 =?iso-8859-1?Q?0AF0LDT2A7ylrtj61TO0tacTJ707VOuW4JxAeFMO+iFl321zMLivJcR5tE?=
 =?iso-8859-1?Q?/Mp+7U6i2lt3L/1uWI1ggwHe4riTrp4cz60PacZLuURmuWuBP1Q28R9liU?=
 =?iso-8859-1?Q?u1yfXhONCJ+xgW6GxCERi+2RNUcDpSc9vkawDEcaBm5qmSvWJiw9fl2BHB?=
 =?iso-8859-1?Q?CFsxn8Rp5nq3t1ScpDU8sW7N0+c291SC34TyItF2+8L8Pk3DdOpe737Fy/?=
 =?iso-8859-1?Q?WBzfJ8CzV5sM/DjyfeBScUaV5EeebvHrqQgpoc/+QUmpsI7gYAJU6wMmlu?=
 =?iso-8859-1?Q?EJ1O3+/8oVDSC8SUFSe5P3vgBDxdg3kpCfVMzqhg94vv4GXr35ozUVw2wX?=
 =?iso-8859-1?Q?+fIHJW7xzBVsEB48e8mJ0YRSiYPAHCNyO7giiXEV2JMNHgkCYBgsqjaXWa?=
 =?iso-8859-1?Q?d+CNF25dxwCHsPGbUnDqcCeOi5pQeb0dSa1eLYy2fy/eJXtekpqTRi4OKB?=
 =?iso-8859-1?Q?Ev0tAsBCWJyH8XhugglsvlhKq8Mu9Haw8LL9z3k05GbP9qh3M6ycXS3khv?=
 =?iso-8859-1?Q?5eYhbtSJIWuUgpgJdB54pCCdXMaTEv1Sf9gx1IMlpK55nAV0+6aQdu5mqF?=
 =?iso-8859-1?Q?U6jai2nsqU28IA8AnpsbPRZ1RJogufNNWX3YmzjFP3PzKZDpq1uduX+Ic2?=
 =?iso-8859-1?Q?9DgXYO+I289F7c2VBi2pyOiUPD1JdexbJprweg89Ob3tlCZ+rE/89mfFwj?=
 =?iso-8859-1?Q?v+YcLL9y31q/660Vp6Ikzwx/TJvK4GVim8QxLw/b2q9Sb3JP6F/JSCj+pA?=
 =?iso-8859-1?Q?iVFhKMmtA/j9k6oPLOBUIvGBNVy8qI/9P5qU8KtimOH9VFp0kz9ae2Cmx8?=
 =?iso-8859-1?Q?GpLRP9E8bhioHHs+WVf1kVcePYKTjo3B1JdsGebmjBeVur15ETvIh758cW?=
 =?iso-8859-1?Q?MECoU24w90h8rM31eLmXfjxWPTQqFElV8lgA+w+Tfd2iXOfYukltkKeNNU?=
 =?iso-8859-1?Q?LCJzh45mvrphNrZhi4pi71/fnPTgKBImt8vBDytadWWQzeGfjt5MAqIT6x?=
 =?iso-8859-1?Q?jb8QmxjTRDWklC3tzRy98dFZg/mzeinweGoMOZCQtjKvKDOTAjOeFNvsF2?=
 =?iso-8859-1?Q?bpimbcUxc3z2K0TtDSe9gXv5FE/tpQVGu7WcPcrTBGdtryWRmf/1IVIBdW?=
 =?iso-8859-1?Q?gqnyxVtVBYmKm5JypS+c5zqbxLXcHE+ZTBiEnmlxNZFujmroMjjd652cAs?=
 =?iso-8859-1?Q?tiCsQunAN+XUL4Z3yX0/jiLG51Gp1izTOPCnz3mLLMl/PXUbReJbPAa5tU?=
 =?iso-8859-1?Q?tyeIxHKfDs55W1ZUx6N3rEfXjsXXtGqEqqDylUw4ly7Yfi2wSfWvfYc1Dh?=
 =?iso-8859-1?Q?KrxWtbXnjbrTro71GBHPLJZJFvM/PG/WAKXmy9MTlcCu9LZgeoG4Fxfn/u?=
 =?iso-8859-1?Q?/uQu+4BPlAYdNE1b/xR4gyQBrQfSth39neMnyoG1PB+LtM+a97A9nL5k31?=
 =?iso-8859-1?Q?94nu5DoDoe+HStQfE+HsMO4lZScPlyYgQbAPqSPW85/YfCMOimvsNFIDsc?=
 =?iso-8859-1?Q?iUfV8J5HfImNgGWvF8soUFCkMp9bX72TN8oS9kib5uj1RmiWabCpTtWV8X?=
 =?iso-8859-1?Q?0ScalAkUWvxc9vM9rzEMn7mxg5IqmED+ar/Z+14771mGxpOocfPjxXAmVF?=
 =?iso-8859-1?Q?+R18LP4/4L8h3irsb6hwnbd+Apf8IzDLviIe2D8kmzPqwFaFZEvWl6wkv6?=
 =?iso-8859-1?Q?9v1RjdARlUZThIB4Wyv7QLqfnUn+A+KOTrjIkdFnswd+ArLm/n+OA80UjQ?=
 =?iso-8859-1?Q?x/yARLXOTg=3D=3D?=
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
	IV423eCVl/B8NbTaGZXXdh2fW9uF+IGdNMqHO9/W5HpUy4br43vOrJY4CpBE7z/ndpO/hdoZf8xIlxHLLKFNOiHQ5aCPw7+vBUuOeIyHNV7nnGLr5ea1os1533Qd75VPIbz92xkqNFMYQhMQAeTsM56ALHutxQM3nKAAGsZYqtrqyXxpAze3k/Wyd36UAJFK2Y6Xe9QR/EIR5kBBUNOSsBdfQTFIh6qDbfSEwlR++GBv+FgRY6eo+afGvelwbOIlMWdxSvIEJCcNYmsujcMUnAlkzrynG4UK7CwU5GcoRWw91EIII69oU5GRbSMINCHTTqDDMAHWYhWYTfyRDyyZBINouuBFCMmCLffr2W7qfVx3fceFeXd9umejxGXXIDmrROgnVX8stg6DBHKuoE8KpSryilm/gesKHEJsOrUqFZRytVDdOgtFurCQCS2J35iQjfnU8zaPSeV1fk5szMXkw/8vDiHV1ydRfEtMIgyapUj66rF3GXkLMzYc+vnSAbASjAJDre/Vt/2NXO2pIqN+fhDcOOAylpUdVlJCiZAfk1EmMtDkYAyusJ0n6z2lnTEsoVsya460/ijM4i68r2D3bQ2B+SWkht9APQwd/bPB+Pw+4gGCYKi0gnkuVaH7P8aq
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e84af2-0e29-4b4b-f45d-08de51af0c08
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 07:48:59.5788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2sp5e5ysMzYD9nwodl846hKRrRZOMXcV3si5MYQyCJJ5GtDnxblpRz4qKX/i9wlCYJA0TvNZNWKVJB85SDz+iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR04MB9236
X-Proofpoint-ORIG-GUID: C8UGP80iKGaHD41ZDbQA9fxmB0yfC8et
X-Proofpoint-GUID: C8UGP80iKGaHD41ZDbQA9fxmB0yfC8et
X-Authority-Analysis: v=2.4 cv=LNRrgZW9 c=1 sm=1 tr=0 ts=6964a777 cx=c_pps a=g2eVZ27FXIkn1cqd9RNbzg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=vUbySO9Y5rIA:10 a=7j0FZ4iXMVMA:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=dZbOZ2KzAAAA:8 a=HrutMRQC_tbIrsyl01wA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1OSBTYWx0ZWRfX4s6LNhQy/+xL j8lM0fEVJ2Z2uOZoq8cJFhSmNR03cEIpdWMW0RjNQ4MkMkzvBroUnwwssQgvNFb/4dTpdJsQ5t/ dzQvdxIewG60PKx+3wGz6jVCE74dAm2qxI1hA5NfVtwXWD5dnvl/QHEtof7EwzTtzeRsPy/cRi+
 6celkmsghKZHb4VORHktnuWYD3SK5NXRwqhzoMbKTtj3FfStwMreUIXxLBfoWIuQdV3+KaI0j1W V/+BR8Lfq8iBTWXtGq51H7EEMfp2J1R4u4EGBnibR5UO1R48kuGshGHKCxaA6dED1ZP+G0j1ccD OHn8QrXubr+DE0VOJ4MThF9ie8G+aujlRbl1jOWXAIHcyLh10ucJF8zZdb8MzKinB9B6K36kC1+
 cR0oHPupUKW8EjQZhVfV4aEC1/I/P6MC8tYK0vlmnJBUpoi+jCniFgkQ/+dwbAUNCcraQ9N9zAo Pr6wHbaJVItGRnNP3rw==
X-Sony-Outbound-GUID: C8UGP80iKGaHD41ZDbQA9fxmB0yfC8et
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01

Oh no, sorry, there's something wrong with my environment. Resend the email=
.=0A=
=0A=
On Sun, Jan 11, 2026 at 05:51:34AM +0000, Matthew Wilcox wrote:=0A=
> On Sun, Jan 11, 2026 at 05:19:55AM +0000, Matthew Wilcox wrote:=0A=
> > On Thu, Jan 08, 2026 at 05:38:57PM +0800, yuling-dong@qq.com wrote:=0A=
> > > -	start =3D ((loff_t)vma->vm_pgoff << PAGE_SHIFT);=0A=
> > > -	end =3D min_t(loff_t, i_size_read(inode),=0A=
> > > -			start + vma->vm_end - vma->vm_start);=0A=
> > > +	new_valid_size =3D (loff_t)vmf->pgoff << PAGE_SHIFT;=0A=
> > =0A=
> > Uh, this is off-by-one.  If you access page 2, it'll expand the file=0A=
> > to a size of 8192 bytes, when it needs to expand the file to 12288=0A=
> > bytes.  What testing was done to this patch?=0A=
> =0A=
> Oh, and we should probably make this function support large folios=0A=
> (I know exfat doesn't yet, but this is on your roadmap, right?)=0A=
> Something like this:=0A=
> =0A=
> 	struct folio *folio =3D page_folio(vmf->page)=0A=
> 	loff_t new_valid_size =3D folio_next_pos(folio);=0A=
> =0A=
> ... although this doesn't lock the folio, so we could have a race=0A=
> where the folio is truncated and then replaced with a larger folio=0A=
> and we wouldn't've extended the file enough.  So maybe we need to=0A=
> copy the guts of filemap_page_mkwrite() into exfat_page_mkwrite().=0A=
> It's all quite tricky because exfat_extend_valid_size() also needs=0A=
> to lock the folio that it's going to write to.=0A=
> =0A=
> Hm.  So maybe punt on all this for now and just add the missing "+ 1".=0A=
=0A=
Hi Matthew,=0A=
=0A=
Thank you for your feedback!=0A=
=0A=
There are two ways to extend valid_size: one is by writing 0 through=0A=
exfat_extend_valid_size(), and the other is by writing user data.=0A=
Before writing user data, we just need to extend valid_size to the=0A=
position of user data.=0A=
=0A=
In your example above, valid_size is extended to 8192 by=0A=
exfat_extend_valid_size(), and when page 2(user data) is written,=0A=
valid_size will be expanded to 12288.=0A=
=0A=
So, there is no missing "+1" and no need to consider large folios.=0A=

