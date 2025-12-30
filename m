Return-Path: <linux-fsdevel+bounces-72238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D68CCE932C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 10:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 542D13014A3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 09:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B1728CF42;
	Tue, 30 Dec 2025 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="YEnXA8vJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9110A23EAA3;
	Tue, 30 Dec 2025 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767086662; cv=fail; b=VTIi0PxnWtmq+nr435IBDHQCCbZY+ASzonchtwjKXR/t1d9HCbfe9JH3Z9yKI01+flnZNSVNq/Hzm+MLRIiSUHtrMBbtfIa/bDbwG6kYdH4gp3+sDrGJNIGMhn3o8aTG7fHfwe0nn2A/xwGjXEvHITYkXsMH93fSEPi/003PFmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767086662; c=relaxed/simple;
	bh=Hr6w4GgvK4QlYcK3TR9/HPOufFCVzpQjae+GQmllv1M=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=es4dtE2nHDPZ6NZ36n7KufTrkUymrXp1T1OR/758f9vorUcMNkxgt4GRGpL1wrpYIwL2sjwrf8NQuNh2CvMu4qpvDCucMKPYgjDpEUuitvkcukzp+LLXTJODZzhAv/gSM+9UXPRQFKwSjz5a+6aq/Mes1Xl7NcytuMvi9+qhLzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=YEnXA8vJ; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BU6u2HB021791;
	Tue, 30 Dec 2025 09:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=6xAe/vgrHQUdOikkwmJo1gkA/siSh
	ojaRnNE9ssK1to=; b=YEnXA8vJsk7gOodzf3UlBv8S0IMB/fh4KVKaVJ3XwuZxA
	5khUSKS/0XVxl/8yMuHhdSLZhFZZLut5qrYp3AyyjDkzVfZGQXCA8VigdxTYboZZ
	08tVtGutnXJxGkA11oTjYU0Z75aySraVCCEPTkfd8noDuwRq0acMxcIK5GnozpHj
	mJDdvTDq6odzOSZAEO57BxKMkW+zr51Fj57QVTUz4FiWrRBLdoZFVFM6yMVLlreO
	FH7XmtLBq50E8+LjOzvNZwESDsm3JWrtpqLPX3B6oBNlVaWN9H5Zj7/spbM+KKkM
	dlJA4YFs80nUjFXvSh49+ZdbLZya60bd9ikMaBsOA==
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013033.outbound.protection.outlook.com [40.107.44.33])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4ba4m1u4un-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Dec 2025 09:05:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwLnOCaiKhnByPmls56ODCLwykfnJnEhZ4i0i7kXCd3yooBaM+t6l7Pt6NnIxihw8B5Uh36zaJBvL3NPSJxZUd0I2RQPzt/6GRXl9d5P8FEg2Tburp8maa6qrr3BnhifwTmJTScSMakkCsG6za2sAgUKlsjTUXGzA9wh8HNqktmqOhlKsydJi3h/LvjXmMQ5DxgJO1mjJQfyemDOJaU1eK4kSiwqyauq8IlmuyXE6Kk2vHQ3ubj3VGjlG7l+2t0GAmzXSCTRNuaI/mGqUjkgLiV1Ol/2dOOOEwcvaRpsI8yEqBrnOVyORhcddBTqQ/0nKln5PWXcXuDpiO/u6+CBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xAe/vgrHQUdOikkwmJo1gkA/siShojaRnNE9ssK1to=;
 b=MxY8+tvadylYvlGu3SaMLtIGfjWUaVQEC5sUC7gJzElrbnjzqydH58VE07tJBMyf0+6z39Q3PaVGIJot8rAu/ZVUmXrOdaiI9GJObFcikPfTxF6eN4JivVvJI6dEpGSyHRlW5HKyzQauBjKWfBkgLNmbHPxHFLyOZutzN0hjDJ45k43sAzhqG7bWs5QHMaTCFvqZC1YgfhoFHyy/8aW8WWkN69y2xUTRzWcUFh6yKgqkVqt3algllODADkoKuQAkvHSulItGXsGcAeRNgV49ZwRW3iKzxEZ9W9oJ32j5WWVi3n61hbp4k1egm4xoIhd1cLZtBWHhuRGWmU2mhReN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEYPR04MB7450.apcprd04.prod.outlook.com (2603:1096:101:1d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 09:05:56 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%5]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 09:05:56 +0000
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
        "willy@infradead.org" <willy@infradead.org>,
        "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Subject: Re: [PATCH v1 6/9] exfat: remove unused parameters from
 exfat_get_cluster
Thread-Topic: [PATCH v1 6/9] exfat: remove unused parameters from
 exfat_get_cluster
Thread-Index: AQHceV/KZ2Tcq7SVoka490Fvc18brQ==
Date: Tue, 30 Dec 2025 09:05:56 +0000
Message-ID:
 <PUZPR04MB6316EAFF1D1D002551408CD181BCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEYPR04MB7450:EE_
x-ms-office365-filtering-correlation-id: d4d62d0e-303b-45eb-091f-08de4782a453
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?EB0U1VWLyEDFBq+uMUATyQJIaUP9j/2AVaPJ3dnPLdFWLRNLRinsgP1FGn?=
 =?iso-8859-1?Q?3HK5MOh0ey3VS1o9wuBMXCWrF6N5YsuQzibvKfsN8VR5i+z1rHdruLi/7b?=
 =?iso-8859-1?Q?B5SWMo7Wr8fwvBYZT7dIR7B6c1y6cfJUEl5SDk8VrAzCm6beg4igmIgzSa?=
 =?iso-8859-1?Q?RXLDM8MaQxlEwTKfUtzA3Trm1fsUQfzfeYC4DMk80vstjQ8T165DF0682m?=
 =?iso-8859-1?Q?T3emZKAXkbQftoVLUjjQplo5XA7a5ThdKl4OhB9DoCXNHr7z55HssJLyi2?=
 =?iso-8859-1?Q?oQKWO7HlaVxfKoQaHQUXp0fGZLuJaM81fpZ11PMu73K0QgpRHc0YgooCsE?=
 =?iso-8859-1?Q?S4cyJI7FgEQmIhvbBnSCTkVCAOKjmhcPwAQiQOubuL7ALJR3xu1uCwm0PM?=
 =?iso-8859-1?Q?abLjTylqtbiaqP9GBe1TouvmJV39DpVYM5/IYge5aEDELdjIkD1VihYRZc?=
 =?iso-8859-1?Q?5oCPk0LLSlxKwBszkdbDa0yLvuEi7l5CZ9Tf0H5NdfhFx4SU65lg8zsxJj?=
 =?iso-8859-1?Q?oP0yh8+0W1WYLVT50gdV0w7T3Ae1LlsRXYsz0jdxa6WX0k3VOz9vyRt0Un?=
 =?iso-8859-1?Q?+eP2iujr0+8YLfvoJfql3Rm+Z88Mu6hR72INL8LtoM7zyTxBKfSzCXwxby?=
 =?iso-8859-1?Q?p+gGyDmRdOEYqZOjuxbMBw2pvjOR/xswV+uOJj4SYpnWqorJmQs/VHgvnQ?=
 =?iso-8859-1?Q?Xpr96aI/zTga1uAuZURx2HbECUxb/kPKycYmz2h7BxVzwUGhkIX1cTiRE8?=
 =?iso-8859-1?Q?+K/YVCDG2MCpwhJDqXNwpc1BEnsd2HwEan5wbYJgwVrmkLg1lsqgf6Hyvy?=
 =?iso-8859-1?Q?ylG2nPcJOmXKS2VYI6/Vy4s+NkaCEBxpvLnFpgTq+a7Z1Oyj3kj0Mw89VP?=
 =?iso-8859-1?Q?5bjEH3Btq7tSZJG/7KyBjJyXooaJY8FXJkPzqtQd+WIQTmiagZElXnCVCv?=
 =?iso-8859-1?Q?emTn1ryOrCvT5PAgVqZgicRQ795Y4CW7Bo0FXigNWPtpfmA16RMYAxPiFb?=
 =?iso-8859-1?Q?4rz8tfXdIgaOdinH7BQ644Q1inlPPnXre0IqJ+X2OWBWGtkr/URxSG5cwc?=
 =?iso-8859-1?Q?JKtfsADLKKl0yflNrpptIhPGkfVLNTs64P0HNgNwGkQth9/l68aHQ36Rti?=
 =?iso-8859-1?Q?Bkmftp35N3eGAUiX25KtQSn/RUEs/Yfn5tm/hijhYOvTr5O9E4powRw+8N?=
 =?iso-8859-1?Q?Av9gWTM/aQ1orszW4ooAfjp3HBPCp7tSqJbL6soMTi06KT06T2Dv/TbOxn?=
 =?iso-8859-1?Q?58cUhYxWXcdAd73SyI1fozMbIOruB7ei1+31/DtdXhD2cu9DDh5Xuddhgb?=
 =?iso-8859-1?Q?JAQWpyMg60KW3JGvtkbBGZ2BlBIU/6tLYa9cMC+7u1lwXCJB33YHKYgfXy?=
 =?iso-8859-1?Q?m5xIMbODC1xhjrkv63p5sQjEz2LC2t4jBW3bL6sWQWq8ecwTgCJjT1ahXc?=
 =?iso-8859-1?Q?/GlYkZWFstgdkT7wSJT+eAHRSnchq52Vj4pEB+iO6rjgqppedAyGe5d1oD?=
 =?iso-8859-1?Q?fUWCW/Zs209Y3Th3ukvysi/IeyUejxWIkzVqGvvfRzeOBMBSTsLg1B1WOp?=
 =?iso-8859-1?Q?UNEbSIzOXAE5eMSMrhTnO+Thu/Wi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?W13Wv9OwJfYYTbliMRY0GGK4rP0iBsiwuh1UPhtMS5RXTKq3UU3SHqjsjo?=
 =?iso-8859-1?Q?ULaA3TZKrHZPFgQtcmgpPJJ85v31be3pFfSIS0kg6wyaiJhNNpwgOqNaLZ?=
 =?iso-8859-1?Q?7us/GaK7sB4RfuFKrCGDgSNdEeAuAjFWeFyvmL+x2oWFjew0vFgcZ/GxuJ?=
 =?iso-8859-1?Q?WM9fIWOvEx5+Hf4Bm1htZryIO2KhPU8mioFs9ktWnoEdiAuNNcjQyM/Mfx?=
 =?iso-8859-1?Q?QwlBXvYeYPGyG9p+1VbAM8iZkMBXDlfDsVY1zog5DPMIyNmqtnWLI8O8ao?=
 =?iso-8859-1?Q?LyEBzxbRPvanTTcVp08xJqEjL6Hq7O6SAnuiEIHxmI7C5lmbjAjHej+eFH?=
 =?iso-8859-1?Q?fTzn0jbVO6AA4WN86DZsWDSDolBPykoli6016qtvwCxi8HRgQNQQw68w75?=
 =?iso-8859-1?Q?c1iUl0ZuPPnT1LAHskt7ktVnFSu3t7eJWfPrkYbHfLGBtd/FPIm3yTWnJZ?=
 =?iso-8859-1?Q?/OpWZfVo0PKbL9Tf9pFNtSM6NCNzwoJ8HbxNMn7uose1GF/MxSJGD7jZwt?=
 =?iso-8859-1?Q?IeNmVniRwiWRjGCzdIi+nlQ0oBHfsBsYLvpm+oiw7khuiOfmZ7+zQV99Y1?=
 =?iso-8859-1?Q?ozaGIDJ4fm/siTCU7ULbv4HSBogl3Qmfy0FGLPd3Fx84Ujxt3UDwWMoAvs?=
 =?iso-8859-1?Q?zSv7vteiRquC8B1PUrOgY/i724IQUqh/ao1ALOmyKL6wa04PJIJzClA+x9?=
 =?iso-8859-1?Q?xTOghd/gfSNbjl5iaiAm11LTAwYBtT/5qGiep7GhGHdKdIJ2HLUXwmzqPc?=
 =?iso-8859-1?Q?A0HGq3VAQ0x11Wv4pfIC/y2/dMFtGuB/15WyLZoSHQ5MgwcTohN+hd2Qw5?=
 =?iso-8859-1?Q?uDqZxzzK5fb1Okdnw2QYNQHtJOeIaYLcV2dgoiGX/KV5eIWQ1PuVi+gYIy?=
 =?iso-8859-1?Q?brXE+5M1nzPqaU8kU4aFagyiSx9RdW3wGa5XfAKpNyd1xy7nb66WHJHANY?=
 =?iso-8859-1?Q?k9wwSSTYmVcHyrVa3r7xccwMfm71L1FHtTOF09dGU3FfdyFkTZ+0difLAV?=
 =?iso-8859-1?Q?H3NwZNQCrrNsM/laZZp2US9HqXaJvKWn8Lv6nf5PnS+loXO024h+DLcLn1?=
 =?iso-8859-1?Q?3TO1P2nilO9PZYM1NpR9YDEODfZhgl/L+dRkIGRk2wvQ0v7qJB3I+y9POS?=
 =?iso-8859-1?Q?2vb5d3pSkR4uTpbfXMta5WhTjwdSRSSWmzs03LV/VnQHshVQiIgGYQFj42?=
 =?iso-8859-1?Q?a/sHM6ezdY8y4832xH4OFiQ+YepYiIQYHhpkepSjMB9hQK9dmxsDqZUpiK?=
 =?iso-8859-1?Q?xKblorOpdA0IeKhnrahEhrgy9mBd+PHliG4WAMOhPlR5Trxe0sH3s/cvee?=
 =?iso-8859-1?Q?2GvgJGLSDBdc3Os0Sr9wtRufLAS/9WXKu0vGv03K4rwjzKPhwptLyDlOzp?=
 =?iso-8859-1?Q?LnSD84WFZ1GQHQvnFEN4I/YFEhkGj9TeCdnS6J934V47anjqpD5QR4W5kn?=
 =?iso-8859-1?Q?vYwBh5+P5rinqc/RpASiagp677SxQU6/bI6zoczuvMC6I+WqOtyiFHkQs7?=
 =?iso-8859-1?Q?FntLeJRq5fmza9G+tP6djNXp0usaIxZqN2eo8J16Ke2ZOyD7IYYoTDcfiK?=
 =?iso-8859-1?Q?Rq85SyaTMm9rbSUVsn7t3jM9cp3hiRSRh1i1VgqihmVwSqalXShwjyoEty?=
 =?iso-8859-1?Q?wuwaOzQn9lqN3UYyvXnppkI4znzQEZoDzp/HScL26YfjjoOq3Y6NbSDzXT?=
 =?iso-8859-1?Q?ApVXNQIBBEDp3hNw4rIdW6HACwV94qfXOkve3ZBLfs4VahCuS6rUMMLrXZ?=
 =?iso-8859-1?Q?E9hXLILy14q2bLjuy/DO7kKQbsg4Q6Q3ruQyR6hzP/ixgsyig5mFJiz5mU?=
 =?iso-8859-1?Q?dEfgdQNeQg=3D=3D?=
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
	Q6aQaququcbxfZT3fwxYv1x0OluZP/J/WHafhM5mwObjWXh/RI+70W8EWVBtCp8gx6R9nmEkh32fqKaerKWk9q00Y05i/kpyTxbqKx3McUY4R1HwVdDUWMvRSYomGQj4CcRVsxIa02Io7ELgvt8Rj7Q+bpzIUzxajbmpvztaKj9qBIjXf/Vaar9rJyeCO5SzsE+9Q2HczNmfUAOOmkZpkeQ25UbY08+wysJRN5fpP1QiTTh6nDxG5UbA1GU5vuIG6QQdy7PYG7res/aLMkWntiRV1f4Xbtuqp7RIrswAiroQD8QwaE7tuclY8d2v0SrOQO9F5EmkzIrdHKVvZwszVQtFNu4Me8N8D0RJPiH8RVPSLaNBCPSvMkh75+f5aIcKdIGDEANM46oRCuXHidJoXzKlRrxFtxifA2Uxq6nHnv6v8QaGbF9H0xiqiK/lEbaiK/Bbi7ya9+poAjA9vWeeQz+JfaKvPBWybmWNVCW+6ynlHRYAN4Sq/hJnBAn0RxESWaBDRTdLMyUqzhEMrv5mNWxofGt7ioApoUC1YJzx30mamiwqSnNFSeedPgpN3WK2WJx4n+3A31kwYYGz2m+ywWn0naVAiYr/kHQfnyccZuQXGCRD+0qfI1opDmegbTHt
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d62d0e-303b-45eb-091f-08de4782a453
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 09:05:56.0945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9bDVE4R8OlRflUIf64klLfqXMlbmg0r0rVoLuu66/yM3gDZS0LzQxolJi0Pe/yLUyrNFLaCL2Tcm0uSxNpnoew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7450
X-Authority-Analysis: v=2.4 cv=GK8F0+NK c=1 sm=1 tr=0 ts=695395f6 cx=c_pps a=OQkrFVMm8+dctdvY1lDM4A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=wP3pNCr1ah4A:10 a=7j0FZ4iXMVMA:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=1vALsLEz67qURlo1PbYA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: _PH73j9MH0kFOAZJlhycoPuEUVOguHPw
X-Proofpoint-GUID: _PH73j9MH0kFOAZJlhycoPuEUVOguHPw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA4MSBTYWx0ZWRfX3nkjdizmhSwJ X+UAFPFBfXqCK1KgBkA03LCGidAUXfbhY6oEToD2tUJSpy5grbAtWlawOk115HOaxDXvc8G5Oro lCNF94sJKMlQtQJa+b4axU6blM4iyDiREa2pNev3ggYYBzpQEsp5LjujabsFS/+QdyI1+1E6lRh
 Ts0juix+wvAWF6dDHgI5/yflFf5VFhTEm5a0SpSDUEn1mfPlJVPvDpz5bBiXwWCNv1tYyi8/7cd MP4dkvJ3OUZ0OVx0hTDIP/96CE+r3epvKfFc4vsfrXWheUhMMD9yM5tb8RC6jUEVUHlXMTY//TU 9Y58anOCcewMEx2FJwes69MaxcxeBhzCAw87rKC7AgI675ycBRHJgGUvvbHoMOxmplJsTkPNwZV
 LYqDZTt/20g/qq9xG2/KN2Jj0LrWvLP6Ymesphd7NGP95YnyHLYE+5D831drpJSnLom+EZScLSU bb5nw5ektepWL/Helww==
X-Sony-Outbound-GUID: _PH73j9MH0kFOAZJlhycoPuEUVOguHPw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-30_01,2025-10-01_01

> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c                         =
                                                                           =
                                  =0A=
> index f9501c3a3666..1062ce470cb1 100644=0A=
> --- a/fs/exfat/inode.c=0A=
> +++ b/fs/exfat/inode.c=0A=
> @@ -157,28 +157,26 @@ static int exfat_map_cluster(struct inode *inode, u=
nsigned int clu_offset,=0A=
>                               *clu +=3D clu_offset;=0A=
>               }=0A=
>       } else if (ei->type =3D=3D TYPE_FILE) {=0A=
> -             unsigned int fclus =3D 0;=0A=
>               int err =3D exfat_get_cluster(inode, clu_offset,=0A=
> -                             &fclus, clu, &last_clu, 1); =0A=
> +                             clu, &last_clu);=0A=
>               if (err)=0A=
>                       return -EIO;=0A=
> -=0A=
> -             clu_offset -=3D fclus;=0A=
>       } else {=0A=
> +             unsigned int fclus =3D 0;=0A=
>               /* hint information */=0A=
>               if (clu_offset > 0 && ei->hint_bmap.off !=3D EXFAT_EOF_CLUS=
TER &&=0A=
>                   ei->hint_bmap.off > 0 && clu_offset >=3D ei->hint_bmap.=
off) {=0A=
> -                     clu_offset -=3D ei->hint_bmap.off;=0A=
>                       /* hint_bmap.clu should be valid */=0A=
>                       WARN_ON(ei->hint_bmap.clu < 2); =0A=
> +                     fclus =3D ei->hint_bmap.off;=0A=
>                       *clu =3D ei->hint_bmap.clu;=0A=
>               }=0A=
>  =0A=
> -             while (clu_offset > 0 && *clu !=3D EXFAT_EOF_CLUSTER) {=0A=
> +             while (fclus < clu_offset && *clu !=3D EXFAT_EOF_CLUSTER) {=
=0A=
>                       last_clu =3D *clu;=0A=
>                       if (exfat_get_next_cluster(sb, clu))=0A=
>                               return -EIO;=0A=
> -                     clu_offset--;=0A=
> +                     fclus++;=0A=
>               }=0A=
=0A=
exfat_map_cluster() is only used for files. The code in this 'else' block i=
s never executed and=0A=
can be cleaned up.=0A=
=0A=
>       }=0A=
=0A=

