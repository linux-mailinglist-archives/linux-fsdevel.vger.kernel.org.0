Return-Path: <linux-fsdevel+bounces-72360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8436ACF0BDC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 04 Jan 2026 08:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E674D30184CB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jan 2026 07:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0712F659F;
	Sun,  4 Jan 2026 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="a0X6hEtV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6FA1E3DED;
	Sun,  4 Jan 2026 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767513435; cv=fail; b=ZhEYwS2VdpK5N6VNwQtXgaUdUHfkRpxFSKFngHtYVOoG5dCHsstu5K8crW0JH+7LcDU1LCF0ijEmRiZehnMNnZQFIMGk5iQsO9hu6npiJ58QG2xdvpcvnNUK4073J1RbmTE+KayqA5saMS71ayn3hxk4bKmK+fODrSwhtz0SCsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767513435; c=relaxed/simple;
	bh=YXfOvJ+5ITm1B4wiEdm0c6E+qVtiBdLWNGjsykRbW4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dUf5jgRI+iKB1IdKnX9LmJoTd0xidVpnx11LJrNmNqva75HyJ0sE7kJ059QYKSW8vtrnZ5P9L4c+oQ7BXQnbrtud/6VVYXVBW8zxnMuPTidGW6uNqAIYjxzNS/kYg79sqkNeIC3kV+5utO8b59t/ldh0MxkXFEdxiE/1BbBQJ2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=a0X6hEtV; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6047oAZB017558;
	Sun, 4 Jan 2026 07:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=FHW4yOX
	GIlef9p+oX7S+Mh7sJWTGTvN9FuQU3sGxIIM=; b=a0X6hEtVAV3pyHX5iryZPHg
	IfcMDU+h8wyHhMNHtffNmHX3h/l21pqrHFcIp+p3fQEFe6nQVUTAVNElWi0UPF8x
	Olwf9XOUwD/1i8S76hQgQ4p3nXfaXZz1X4y597QI0vJKrf4VG4Ex3xOtSsd+QEtw
	RNozQ31O6pX9jwAW7T2Hm2J+XZDhky/QHDnjwo0kT1wIuajoiWzXDRGoLqe9J/on
	YTWPfkesI+Nynxz+cnyOCI9b741HbDpGcxhxNOjOx/mqQsTN7io4dER9FAJIybI+
	nm8qAMqmKDwMdocfkUPCJF4BLRtdYhDuIa7q1IusMxZ3ydOOFHjtkvYW245+Ppw=
	=
Received: from tydpr03cu002.outbound.protection.outlook.com (mail-japaneastazon11013033.outbound.protection.outlook.com [52.101.127.33])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4besw2rsug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Jan 2026 07:56:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQaX3D/tTvv6uKMbKVZx3WG1NsmGRwbG91NpiQEleFYdODbbc5XL/O09pmm9L+XuZLLDCLWai15GiBN7il7Cy6OByA4vNG8PkklRdj13NtYbSSCnHOosr/l3iptYHOHAaQ9gY1dP8/ajAo/cuXVRwQoGQynOCmDwTBWd5X2XfCZ6rkirr39VwToaCf0Ekimj98ctbHYgZmsJ9gOdtfHE5teXmzYpKNQbsA3MPBllqKh+3YuZ7CZQFuj+HDahY5mN8ZfP8p/3Fb8Z1BTUG5fcyKPbL2b4ut3M7On3kqRZnQotq6xa1S1X66oL1Neb1Smvci8nxhB6z+BWYJtqM10qFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHW4yOXGIlef9p+oX7S+Mh7sJWTGTvN9FuQU3sGxIIM=;
 b=lrmYpjceF1qxlHckHfmoun6UUKQbWxb96T/BwiRJIGFRMhNjPUGrEUiHSrJMH5Ht8x535Ajb9iVVuoSYWTkq8foaPbLSfLxm2f3379O3C0XncP6FGeDLmb3CfJ+VpJQdlyh6FMlNPvqDcfXkCI9kmaoT+Wj0dE58cHM0qVdjIVxsshm2JP2Ibiy9SNiVC+GGh8L65Kll6rjuv6bDG0txtqROIumvwPllktldAe8KX5J/dnIXWu7kGChRa4vBXSlLqKTD0KEELUyoUnQo29B2lzMf8ry8qLFXzlpozDSFfEQPtd9wuKXz4bLdHD/EhIb57eSzokDfQBt6Qened+2zLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYSPR04MB7274.apcprd04.prod.outlook.com (2603:1096:400:473::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 4 Jan
 2026 07:56:20 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%5]) with mapi id 15.20.9478.004; Sun, 4 Jan 2026
 07:56:20 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Chi Zhiling <chizhiling@163.com>
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
Subject: Re: [PATCH v1 3/9] exfat: reuse cache to improve exfat_get_cluster
Thread-Topic: [PATCH v1 3/9] exfat: reuse cache to improve exfat_get_cluster
Thread-Index: AQHceV0OEW8234g91k6RDdC9JppEj7U6+WWAgAaOahA=
Date: Sun, 4 Jan 2026 07:56:20 +0000
Message-ID:
 <PUZPR04MB6316842140CBEDFC8E30CDE081B9A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References:
 <PUZPR04MB631637893887AB587E1E3A9381BCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <4c72c670-5ec1-404d-8177-bd80fabf4695@163.com>
In-Reply-To: <4c72c670-5ec1-404d-8177-bd80fabf4695@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYSPR04MB7274:EE_
x-ms-office365-filtering-correlation-id: 8bf940c8-1802-4d5e-23a5-08de4b66bf71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?SVtkN6I+7hw8DEWucuyLHBoIdD+nDRNcwJLj3SpPcKxpCq705YdPsH+xHH?=
 =?iso-8859-1?Q?RnmDzWSyQDxFPYXjnpzWzVOnxxPW1t5aJiYrl0Lk0I2F7CPWGSyj8/9oHU?=
 =?iso-8859-1?Q?L6cR++YN0vxo2+lbXY7JISDhFKA9sCFukpY4vyUWtHf9667U1zVslifG82?=
 =?iso-8859-1?Q?+R9sRme3uDYMyauFfhl3zRCZ1irHZYuUbGcsCxFDsG+Lx47YknsJhGqaxB?=
 =?iso-8859-1?Q?CGsX+s+wFkAY1HclAgvjWu9St06yrK+Bd0RuCqNjzOIpxekZVwHHLxnus8?=
 =?iso-8859-1?Q?cYB0jXGV3sRiBX9XWarEhsRWBCbHs7UFzXUqvvKLZYuvM2uAQD7XYMnCnn?=
 =?iso-8859-1?Q?dY2ntWvYwpXX1Y7MMvOYmL+uTmAXzl0BdSm3Lozwt6aZQFcwnBOSnc52cH?=
 =?iso-8859-1?Q?aDS4oos6ABo3R+eneE5hOAi9DJea49+hhXVhns7K1xzlf50HGBOr6UdxQm?=
 =?iso-8859-1?Q?JxGeqQdTgvPKzNart10a0K1nAZ7oYzsNTYWtpO+Sq4k4dPiYXw+8SKMmE6?=
 =?iso-8859-1?Q?sC4tnbQsmK6TyveS1pdDeWZj7fvT5SGKgyRntAo07Ry+2W0wjKNL5QRXOO?=
 =?iso-8859-1?Q?qfDcsjRr+4fLEDQN3Kyngnioa3BA+u+E5lYdiRZoTF12KjeAozeOM65I0p?=
 =?iso-8859-1?Q?xoIvR1M1vPD/iokg4uJ8E2eece9swBJLXf9N/N5xiKmcKjFEVoVFg6SlD2?=
 =?iso-8859-1?Q?NoR8CPahFx02f97VAtWg6KCFAa3FxxnwgucG86ojMWpDhjIa8+DRik7KlH?=
 =?iso-8859-1?Q?EfIHNQQ84t/FaRD6bo73Cp/G8ftEIU9DsIaHGJLbtdseUVaQV2L6yglahR?=
 =?iso-8859-1?Q?0wAhnbcVXcSwq2lCcQ2dubk/8xSBKSA63QnqGIR/Dbn38/CjUtC1v7vJS3?=
 =?iso-8859-1?Q?Hq27dQ3h8pPd8S+pjyeUSu7IqLZqLGawDO5S+P3izeqx4xbp47AjEV2XKg?=
 =?iso-8859-1?Q?hQ8FQtPBOFYVRcV8Sop/e0RHaxCM/TPGKZ/IZOWyyb7y24lAVjNpzMCaeS?=
 =?iso-8859-1?Q?SU8PwIUVUoLDVlOTgkcuq3wdU5VfCJlLq6D5C2F3+NtBSd3V/ssbENoZnP?=
 =?iso-8859-1?Q?2fnlL3U6PByKlWGpg8yK3UzGVdNgDjuQixPJ/yU651SHhC5wQYtTfeDObV?=
 =?iso-8859-1?Q?9M0UcmJ0C7kJcBnk14EJruUFDaUgNOTKHqBY68ZCH45CDH/IgY1HiXfBuw?=
 =?iso-8859-1?Q?whGgnaQSzpoTUqMozlmOD/i7TKrUotkb7Iv8ZSg0JAQVQDgbWZpp17Z5h1?=
 =?iso-8859-1?Q?uctq+76gmWjZsh7f/mvRuFA4YL6OM3IINS7MppXcqV7rSX4SekcQMnUyUl?=
 =?iso-8859-1?Q?hRcntQhNj7PMxgKwawDR+ROkDmVZWHlBlhlj+S5ouOFogSlC7nARICfT1s?=
 =?iso-8859-1?Q?jackhf4FRjyRVj/NhHwKcf/4h+nE5eu4Gn3bhshaTEyyeTafFLkSFXWSOF?=
 =?iso-8859-1?Q?aGLFuZ674Z/RT5ITTQcOZz/5NckpQ7kYNstP2E+N/f6m9E/qrUraqUSBhS?=
 =?iso-8859-1?Q?uiM7w+Y5Tun1kg0Ng0wfhruaplpuqhA6yjb1vkDC29nhRkN8hO/7RaOOlW?=
 =?iso-8859-1?Q?3Pt4JhIZbmG/7FJ0NrbXNev69Ey1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?OSj/Uojee7YuV5meOhHaS8Nfxi/+AA8POFJXjJ4ooBmP5xTnsJyEeNCs6W?=
 =?iso-8859-1?Q?G4QJubcQDX64WGWXx4MmNz50tAb1jnTFmYL6S0/JKijYLiftcOTmhsV7LO?=
 =?iso-8859-1?Q?nto4+fwdQCbRaPhEMzrpZs4WAHjqtSQB9GhC4aLloJO4KWGMWc0bxynmph?=
 =?iso-8859-1?Q?bDIgywzbnckD2AknnS/PRUeTks8d3iclzdyh7Ng4akB9tJBzHBZUfW4Z1M?=
 =?iso-8859-1?Q?O9Rd5TigJY014U0q1sHD6VsmP+aaP8XjEQpNYOj0pdPG8KtL4YY9sXyGWQ?=
 =?iso-8859-1?Q?OvmaGe2hppeYI7MYf3knxrfzOwKDqqRlmL1Jy7PaHK+LODp7o7hWjFXE5j?=
 =?iso-8859-1?Q?CCxDmm0k6pqetCT+RokW2ZMRyqu0uuF/0LCYORDPgot3uqu1Ym4gUPe/dC?=
 =?iso-8859-1?Q?NOG+12RVXh/btexxvD5YLl8GuR/NHyw1ab/+XtuhCbUyzN6vI+rHjucyV9?=
 =?iso-8859-1?Q?Ku6sY3VUoTLH4JL2lMvpr4B3VhVHm14Xc0bLGDPZihjRNnnFZapJ6LedDz?=
 =?iso-8859-1?Q?/iyC0lFiVyldJy6T6QxbNFsoSSNTwm3wPjJETL3ilW0RLGKUFALgzfV9z8?=
 =?iso-8859-1?Q?j3PgjtDZML11KYsXFKJNYfcsMdPdRKT3DwUVBmTbkB/q3K1f/ImBrm6S4b?=
 =?iso-8859-1?Q?+tJg7Ewrroa5rItD1MtLd8WlRRZr2EpazQEftbGOPZ/NmTWnIcUB8KcHEj?=
 =?iso-8859-1?Q?+8Bvn5ftv8ztnN3wXL8XrcvsiOl3rKX2F3rEq0ZNamDIIVueu4NpgIp+dS?=
 =?iso-8859-1?Q?rPWZHI7YWAos7tprSBpz1EnQkrEhxd5E25mKkOFni3ObAXl5EUmepeoDpy?=
 =?iso-8859-1?Q?BnGTpok2DqtrcuH/7uWZcrE55V3oug2qKpBpLNe1b633bRiyOaymL0+gwQ?=
 =?iso-8859-1?Q?Ktm/IKohIG1c3QiNbbGdPrmS+kJHabR791e00ygxDotUPZ16cj51itxb1S?=
 =?iso-8859-1?Q?bTEUnrVNh13fOVOBgW7YoqAQcLNZVhmpiFaSzDDZR0UNAsdXp0KeGapB3V?=
 =?iso-8859-1?Q?J75HH1kzU6OS1QeXvd/62rN3be2WdE97FiE9srub7p2KgvL6wguPqMujqe?=
 =?iso-8859-1?Q?EpLNbVP4aOW97M7d4h/qQ6m08tKPWMQMqoL7UORKflxG6DbAOirBcV/JkY?=
 =?iso-8859-1?Q?MogEmT1K2kkKKjfLCGWYHOpW6RUWvi+eIh755BXib0fY+nFlddCU/0T7R5?=
 =?iso-8859-1?Q?jb+Z2OPlD/btKs2fk/puZ8KhKFfRJwFwnYkPfC1ilvJOSEuuHQvMPOykEX?=
 =?iso-8859-1?Q?k2DEE/9swrXIX0vihdvrrA1iyINrJ9TxDDJ+xUjLkKzjdYez433EBZDkrB?=
 =?iso-8859-1?Q?iO+83qVDtMrakaFaJXCEY/SqVCAaPBbkJ3Byo2+geQ8CrkCMsf7xLlutmu?=
 =?iso-8859-1?Q?Grvc29aEeI9vcIuzeVZCkTP5FyVCp88P2yxHc2aOftyLXB3ZCeCdZ4YTk3?=
 =?iso-8859-1?Q?NDl59QbgmL2fsTPEuqxY8umeE9Z8qUAHaE/ag6+TrE6EpUN7jJMDl+2L2x?=
 =?iso-8859-1?Q?J0w59WU6fDu0bqk+6iLOntREMygSt0slkt8OIPA0jzmaoewV9NSQ1lbglj?=
 =?iso-8859-1?Q?qw6Tn8/1RwDlmZNenhD8CE7ff2LMng+8x+l+umP6DTEhm7lR1eur+zVGPt?=
 =?iso-8859-1?Q?O6q4SXNHCxRbssXUoD39IjPaYaAp0Bokwm2vT6Cwu5ZT1l354AbnagQ5Ul?=
 =?iso-8859-1?Q?e+5VOLWsA11AB+D8QKgn9mTVzJ3chv5kkMne3fFNtlbizP7XeIXXpU/dNu?=
 =?iso-8859-1?Q?ecBm0WobVAqAE2Wjj/nzmpFRsv5XHZzOk2Ou6E/kY7MZB+yn33ixnm5VnO?=
 =?iso-8859-1?Q?wUQxrFhE8g=3D=3D?=
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
	oXoMEehpjHB16ec5jxOpUGcmV5D0Clhj2zM0aQXYQHfeU6xNocSL4htKHdFnbJi+MKM4w/yVDIY6ilsCd6JV7+kSle1LU5hK8tWeH8S55uLGvfYtMZGKHtbFA5Lq390m7HaIKogx9a2lcsmqLHmpwxs+9VagdJzunTEuUsrDWegMCn3z08uRVRQ9DtqhepLtveTGeoWqadTifqwq3Fi6WZQJIa9x0E+AA/Klh0xZ3KNrizUfN1EDfkY3m+cG0FoyGHtSfPdlbH52r/PtuY9RFUlmcfhv7D3rKwCYx7D1rYh4AZqAw3ZZrWhYYiCAmjRK8q3oNzqI9AmZdSjuOK59eyTYcGajCq0bDMAESgaiXxkkQrIOLGQRudS2xiDCGkH14iKSyy64P5TJhNpx3DZgAcoEQUxvCaoC1U79im42QBfIOPxCHHW0y5jPFnfZZAY2jKAuay4qk4quiBoijq25Pjc4+i3+sRTwTCC3Fed2jRXwuDLiODOXYYJ1wO1RFZpDa5w+Uh4ybD7e7kOMKfXOBORSaudBOv+nGgeBwDllz5woaUrHbLt12Yic36zuw+iUgHqNYCnTFC3Wf1znnHDucx4JZrA2BjdllbqS4Tu2aivWVICqj0mvjnS2MBcOsdUb
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf940c8-1802-4d5e-23a5-08de4b66bf71
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2026 07:56:20.3182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wNDKR03+F+EkWrwdsrAINbeBoK58iV8qhBmMBFt4XfBm0kS55KqNpVf7rFx2+FsD2/LETMUXmbAkKmANjkVybw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7274
X-Authority-Analysis: v=2.4 cv=P/Q3RyAu c=1 sm=1 tr=0 ts=695a1d2c cx=c_pps a=AV3VLuJWgg5JCmondQPfTw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=vUbySO9Y5rIA:10 a=7j0FZ4iXMVMA:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=z6gsHLkEAAAA:8 a=QDFJC1UiOV9febE_v0MA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: 2hBMxFS4-rEDl0SI0qIoKtrlMnrVJ8xn
X-Proofpoint-ORIG-GUID: 2hBMxFS4-rEDl0SI0qIoKtrlMnrVJ8xn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDA3MiBTYWx0ZWRfX8RIRy+FJEL59 6Ddw8LcWRkBEDg6Iz8mEK9d8Fykr5CtHpezf2vnqveZ4Np6I4jZB08Z5879VpAY4K661oic4xg0 mdXy+300ak9TESbUWjBVFZsq9Rf2U5kPRtQQ4xVvrPKIpo1f+sg7kUwa3hLzeES8IZv6y9+3vg7
 Fgn3yQ7FdmwlgBeFrVlk5SPaphQiklx3CqP9wPzMVfox18qtjPlv7hBrHw3qvESlsMeiSZWYQF+ cxdkYfg5ugYD2yrAI919hkz3sMIR2X9y0yRhkcxLmPEXILB50MqrsvjKUCSsVgR7BttAdtiAKzm 5+1MEpO21bTLm3qqgTtGiaag2nG7CeVHDagpiEQLGMMeK6QWx5P0D+m/7PUN55Ll6cdDLAHQdlU
 SC1J/75O65SVo5QF+Pb9T62zPEiwZfa5QJvofXZXVj6f44fJCEYqE6YOlK8eb7v68rMt9Zynx5w r5JSt7QEiF+HS/8PHeQ==
X-Sony-Outbound-GUID: 2hBMxFS4-rEDl0SI0qIoKtrlMnrVJ8xn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_02,2025-12-31_01,2025-10-01_01

> On 12/30/25 17:05, Yuezhang.Mo@sony.com wrote:=0A=
>>> -             if (exfat_ent_get(sb, *dclus, &content, NULL))=0A=
>>> -                     return -EIO;=0A=
>>> +             if (exfat_ent_get(sb, *dclus, &content, &bh))=0A=
>>> +                     goto err;=0A=
>>=0A=
>> As you commented,  the buffer_head needs release if no error return.=0A=
>> Here, an error was returned, buffer_head had been released.=0A=
>=0A=
>=0A=
> I mean, it seems like a duplicate release in there, but in fact it's not.=
=0A=
> =0A=
> When exfat_ent_get return an error, *bh is released and set to NULL. So=
=0A=
> the second brelse() call in exfat_get_cluster() does nothing.=0A=
>=0A=
> ~~~=0A=
> int exfat_ent_get(struct super_block *sb, unsigned int loc,=0A=
>                  unsigned int *content, struct buffer_head **last)=0A=
> {=0A=
>=0A=
>        ...=0A=
>=0A=
> err:=0A=
>          if (last) {=0A=
>                 brelse(*last);=0A=
> =0A=
>                 /* Avoid double release */=0A=
>                 *last =3D NULL;=0A=
>          }=0A=
>          return -EIO;=0A=
> }=0A=
> ~~~=0A=
> =0A=
> The reason using "goto err" is that I want to handle all errors in the=0A=
> same way. Although this does seem a bit strange and confusing with the=0A=
> comment in exfat_ent_get.=0A=
=0A=
I don't think it's necessary to handle all errors in the same way.=0A=
=0A=
- Only the following error handling requires calling brelse.=0A=
    /* prevent the infinite loop of cluster chain */=0A=
    if (fclus > limit) {=0A=
            exfat_fs_error(sb,=0A=
                    "detected the cluster chain loop (i_pos %u)",=0A=
                    fclus);=0A=
            goto err;=0A=
    }=0A=
- This makes confused with the comment in exfat_ent_get.=0A=
- Unnecessary code modifications are avoided.=0A=
=0A=
>>=0A=
>>>=0A=
>>>                *last_dclus =3D *dclus;=0A=
>>>                *dclus =3D content;=0A=
>>> @@ -299,7 +300,7 @@ int exfat_get_cluster(struct inode *inode, unsigned=
 int cluster,=0A=
>>>                                exfat_fs_error(sb,=0A=
>>>                                       "invalid cluster chain (i_pos %u,=
 last_clus 0x%08x is EOF)",=0A=
>>>                                       *fclus, (*last_dclus));=0A=
>>> -                             return -EIO;=0A=
>>> +                             goto err;=0A=
>>>                        }=0A=
>>>=0A=
>>>                        break;=0A=
>>> @@ -309,6 +310,10 @@ int exfat_get_cluster(struct inode *inode, unsigne=
d int cluster,=0A=
>>>                        cache_init(&cid, *fclus, *dclus);=0A=
>>>        }=0A=
>>>=0A=
>>> +     brelse(bh);=0A=
>>>        exfat_cache_add(inode, &cid);=0A=
>>>        return 0;=0A=
>>> +err:=0A=
>>> +     brelse(bh);=0A=
>>> +     return -EIO;=0A=
>>>   }=0A=
>>=0A=
>>=0A=
=0A=
=0A=

