Return-Path: <linux-fsdevel+bounces-46342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC5DA87848
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 08:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C937A7DD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 06:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8176F1B0421;
	Mon, 14 Apr 2025 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="i6lPYUN8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932DF1A2630
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 06:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744613867; cv=fail; b=U2fK7oBW9QQTM2kcQvDz/8S26a8uiHqYMrXYDEL6uake1UBn6nByEwDU1w6Tq40BrCkq5GfrFmy3lnAhAv2/4xKdfQ6AsXlw5Mw1QkfIrXK8g4un/7CjBJ/piEAdceDHPCnXIh+evfFZiEWoSLEpbUM56aftgteV3w2V7ElU15E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744613867; c=relaxed/simple;
	bh=z+c6atXQBQ1OstLQTcGnVruyd39jriVKeuzxn7ylk2g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lzpk6nRZlttZWo5H7oMiLVqE1TG6zCvepIbHph7AnQzZJTYZzOPCuip4GCJuhwfeZKq5Dd6qzBmV3MrA6eMDeFy/k+ermfiFnf0sjJ5jBk/FS5A2BOVWiBvq7pf5t/MANIoF6DepH4VAWUIzuuYdXLchh2IA3JemCa61/wHtaWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=i6lPYUN8; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E073bp011518;
	Mon, 14 Apr 2025 06:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=z+c6atX
	QBQ1OstLQTcGnVruyd39jriVKeuzxn7ylk2g=; b=i6lPYUN8CZWzUBx18OFYfs3
	CgPvsSM241W/PA1Nts2nvu4G0u8zDMVsGQj0jNK4MVq+GeicDPypCZOzRpTpRiDW
	BYRdtyszVdhyybwDYfkXglcHkyzkkLlP927xNMOmkNCHC5EbuIrrlZcLAkXfCgyV
	6oyi8G0XdvXYnLBVYhHljX1ppIDTAkAIqyzddLtxWwXNJq7UEapqzxFcIjblD6Kf
	lR6kv8OWfZbAXPVHlX2DGkVIj41m9IulMn2MsT4snMFyHbojDqWKaX5qzGoVtM1e
	yxJiAmdRr3LccrxOfOEPvo+A/89nWBEog9QGxCn8qii7jRwErqFmS6+/SEM8Y4w=
	=
Received: from hk3pr03cu002.outbound.protection.outlook.com (mail-eastasiaazlp17011031.outbound.protection.outlook.com [40.93.128.31])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 45ygv91599-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 06:57:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSivw8ZpzC+5zVOY5yLkjprrAtHdIA44VW9/MjCw6w6dBJvip+L89OWDBQumAVMVRzG3ecPuVRgWT7DdQd44csBsGLaXdnWDJCMgH6holAaNy3aexUMzqbMhvVWpQIa5MKijXmhAU4pjPIdl/IUUXaL0KGQr6Zdu3VK8PIXrovl3klEntU9hV4G5VJVGJQ55Gf2wteYNIR7QHly8gJf9OjtRE28Rq/Zxg3fPJfb7z6Gjr+P9ZR6Eum6555Jy8/uaZUhZzTlyBESmlGSBymZuXJKeT7cZNeDna+rUELWztfXUuhLrOOkD4Cvc3uOks4x9CANHNIeQiAJ1qkcufv/Z6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+c6atXQBQ1OstLQTcGnVruyd39jriVKeuzxn7ylk2g=;
 b=bql+QkAFqK63d+U94LyZc59/NJg40WByqy1E5cRo2rzCnkGn2dmz2AdgsVZCRYTQWcfi4Dr3/ceoRvptk2021v59k8WBBI5dbLLN+dgaWKfEGKq4vS+Vssco17ykR2HGZgug1ksvPoyK7td81LG1/DtiwZo5UFHn9Q0luZwbJU2LmwCRGBftmkxZ+cZKYbTFqNBDDqyB9rQ4xruQpxy/Bo3JVw0OXpE8cA+dgoMi+tVynQDLVnCVHg9R6SwjbCChVo5d62uPAo/VJYQ9PaI1NpHHWyJ+XHSdZYOm8RLAeTR6VmMwGMJNh5zKmgZEp192ZWGQx0fYSDUMV2ZRn5ux6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI6PR04MB8281.apcprd04.prod.outlook.com (2603:1096:4:236::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 14 Apr
 2025 06:57:03 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 06:57:03 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Sungjong Seo <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "sjdev.seo@gmail.com" <sjdev.seo@gmail.com>,
        "cpgs@samsung.com"
	<cpgs@samsung.com>
Subject: Re: [PATCH v1] exfat: do not clear volume dirty flag during sync
Thread-Topic: [PATCH v1] exfat: do not clear volume dirty flag during sync
Thread-Index: AQHbqfsOkAAQ6BC01E6p2zt2I+nt+bOhEv8AgAGq+SQ=
Date: Mon, 14 Apr 2025 06:57:03 +0000
Message-ID:
 <PUZPR04MB631655CE7BEB6B2E4F6E7AC681B32@PUZPR04MB6316.apcprd04.prod.outlook.com>
References:
 <CGME20250410094112epcas1p42245e765dbdc61c0c9da40884386bbf9@epcas1p4.samsung.com>
	<PUZPR04MB63168406D20B7CF3B287812281B72@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <12bf001dbac33$7b378fb0$71a6af10$@samsung.com>
In-Reply-To: <12bf001dbac33$7b378fb0$71a6af10$@samsung.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI6PR04MB8281:EE_
x-ms-office365-filtering-correlation-id: c4762abf-d09e-455f-b3b4-08dd7b218fd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?X9wuxhB9LB6nl1LahQeylzPFNzWnApsCiSSle5rgeLnE6YdjBZmYTU0p/h?=
 =?iso-8859-1?Q?C7mHxR/eKOqkIeBAUEtT9g78LExAcJZEv4ZdAPTWufaWJbEVEHMRDkdlKF?=
 =?iso-8859-1?Q?1iLob1js0Oc3h5Ny2Z+Zu9+1UWWilOV3VzYcN7Sx1uCszn1q8MJ+kI0ERx?=
 =?iso-8859-1?Q?vkQdoHfe2foliVdQEFxGLEJDVoGP/KjyQMU6byVS2KMJGhpvii1XwQ7iGv?=
 =?iso-8859-1?Q?6dpA9na8WooKQKkdY+RJW6suFdNkInrqFp8/aMG7fZYSkLYDa9JRkzBRD2?=
 =?iso-8859-1?Q?HfFRl3ve0WlWlxNg/90eKgnFqviE++KBm5x7MuuewC8FCm8iaLjr74Js5m?=
 =?iso-8859-1?Q?VrSOZiXemvhZlv3f7iX2pMIY3AXppdvtTQ5wvNgQPCqXu9FICSiTiLq4i5?=
 =?iso-8859-1?Q?9zAVO6ElAS6QdoNEVzLyK/0m1RXRq6KR85v412XEnud+x7SQR3PDtR+90s?=
 =?iso-8859-1?Q?2YW2OhHO/baRzhLtmplHjeI/Coo2X3Hr02kd0HzsvEeTOP+8xXdoRnc3RJ?=
 =?iso-8859-1?Q?ZSS01lUTIy33Ch2x9ENgChZAam/Jowaz9VFJCSc6/qLV8TbC4RVPPomU03?=
 =?iso-8859-1?Q?i7ZwziumSHaXF5eQbqhRHKbjo33GlpBI7wXzpocPoVJmfmhMhiSLaxqMqg?=
 =?iso-8859-1?Q?UV2cFUYnEYYS+drTnAPZmc+o+okjE3cHfZVtmawkqCUlMDC9SEfxGNOwfv?=
 =?iso-8859-1?Q?8TrFeTbeC+oQ/KwzRGJd2/c8DEwVJ34FMU1Bd0K3O+l5fUROezvz/cMxIH?=
 =?iso-8859-1?Q?Ntzc3tFKkAa35eJyVEOIXZEwFNx4bMvO35ay2sTqZ63IY0b3m3DK6mntvz?=
 =?iso-8859-1?Q?f7hAmFNhqBABcklLHITweQaQdw1ue+G9UW8/sm2tDA692et/1j+mYkQNvJ?=
 =?iso-8859-1?Q?l9RjU5M8ivNKmw1eZvaBWGJISnGQdvBjPTICwQLeqqNkVebYILNFXCcKDo?=
 =?iso-8859-1?Q?OCqRWAcQiG9+UE/rxn9KPd5TyWz3DE5JFhGYejuNoWaZfNljwzpFT6KZJ0?=
 =?iso-8859-1?Q?ednl7tIq2R1xbOEAhxiHpyC6TNqkPe0huASp6LRNnBvTbgt+ltQsULlmzZ?=
 =?iso-8859-1?Q?wFjI07EXQUIZ6zyh5/bRHyAo4u5aplpXZ7mwxrCxCYu+D7dtDrbln8O8p5?=
 =?iso-8859-1?Q?2W4AIjpPoYnESCsMrkQaJJQaBb0kzt6mWpQQlurG8746oLjqaSh96Zlcyf?=
 =?iso-8859-1?Q?wB06VCDzVwguA54rdXDx0hz7sT+GW9gL10beoeCMJdkDPHTMqOBILSHrWg?=
 =?iso-8859-1?Q?ao0+4gEa1iUh5htwE0qAuJL8dtiAvVhX2fPrkJdzfa6AKtXkj81F4mw7a4?=
 =?iso-8859-1?Q?9HwKet4ORBBhsWOpUjKJUG6SVrRHsOg+zTFZT6zGgRXafWqitPOQc+mcjF?=
 =?iso-8859-1?Q?W1SSxtW28WAUgBAM/brp14+69AkKzvYnzorCC11KwuY9jIFGQsNCHHj24y?=
 =?iso-8859-1?Q?tfmr0lJZujPXXXyF87gcgDjhKS1UW2zmrmjpDjV4oqaVWi/SIoAtxMY52a?=
 =?iso-8859-1?Q?Pqm6kPYrW6+IUnraeYHhnGxt+t6LkW6PuYkQATweTdpw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ZEs9Dkj1iV9uL/1OfMjvUk+f+o98VVERcqR6o/2ESbTg9xmNPsSY9pNRLz?=
 =?iso-8859-1?Q?9j2u26B7PbNTGVDMBaKOSsAqc+UgE7cUM9Bcdb9ptYy5bO/YU6dQKgA2gI?=
 =?iso-8859-1?Q?+19dOXg+s6k+OhOXoONMI8Chl161yCIyTphavKJW3paa3T7cIvSI6aey17?=
 =?iso-8859-1?Q?Ait0mZgoQytpUcGGPtB0zGCp3cg+l3TmBlQM/thJBMNt52l+34tcMhczmH?=
 =?iso-8859-1?Q?0SAlSMdFbBDgai3fBltS8zp+LNkAdbM+OdfsnOhZNpJC77GCfeEI5e7N7+?=
 =?iso-8859-1?Q?XvoAdS7ayzanhm3NFc2v9N/QW7HH3Pi4H3RlcrUfosMOqNsTTF+R9wibWt?=
 =?iso-8859-1?Q?WEvdYmCRPcxmiDNfClenkl2UAhIdnDngzo1+aL0ya+ExYA+/NRD5C6uCNJ?=
 =?iso-8859-1?Q?+oBLHYQFERY3lds0GXPE7O0QnOfqSzqgBXugYkayrGRUoeyfFZjLJ3/5xq?=
 =?iso-8859-1?Q?wBCR3MLR/AE+gQ1W8Bd+Hl68V4q+N24L/5DuQ0oXawM1e863v0dj6TPsy4?=
 =?iso-8859-1?Q?utyWrCfcA2YvxNiLABV2IQCNiR6sLH6Bl5AlZnm6n7ESt4L0FaLT++c6A3?=
 =?iso-8859-1?Q?uDZR5zUY7gzA/Bea4Y3NxGEQfMG03smTULHDZNKzEBNXV/vOv81l7n+Xqp?=
 =?iso-8859-1?Q?sdKMo7WP4VfUzLNw0BUgFjKkJEG69QYVJe9s97lTvGDe0NZI9OAZavxG78?=
 =?iso-8859-1?Q?TRYAMQKXQmc4h3zXsmaApYuvgx4zcZwf+rQRhAoZEzP4uzIF+TaI1Udq67?=
 =?iso-8859-1?Q?N9KzEYcOxUdRyVcD+zXV/x7P0E+FDpvoParExEVPiIgCahT/HuPh0ry8rY?=
 =?iso-8859-1?Q?wE+Nlwiuy2YCDb/Sj8jQ2/NLjadQthicfQNDSwqjXcFZpY432hMfR2dUpj?=
 =?iso-8859-1?Q?d2YOJUS8Ep/B3MRkzHSst5RL39eGqerP0SRQ2RVwH+V/vLQaWE9b26YrwW?=
 =?iso-8859-1?Q?Oko7UiNnapvJETS4t7C6fjA7hYh2bXrBuv6MuEPTsPB7SW0Kfd+2ox3d2T?=
 =?iso-8859-1?Q?z1GYHfcNM6Xx2bKCqcTZ0qbK/WgQrNcZbaaPUAyz45C00nuUjxc5mL0s+W?=
 =?iso-8859-1?Q?3OtpFWC6/kz8e7MXaqoRkScSXKCVOaUQWvGN8i3T7jqyyPMTzMwwR/pvqt?=
 =?iso-8859-1?Q?skaQbaqJfWSFVNAioV+e5UON2E0MdAf6IkxMH+7rPL/debwS4QqBpdba5P?=
 =?iso-8859-1?Q?aVYUn3nBBrWGSYdhfCnL0b5aoOb0VgTh9/3l+x4P1AU79FFcuC+jMkd1Oh?=
 =?iso-8859-1?Q?DpY3RFjFi4sb6fZ2VDabpibJQcvMCLd8B+z233oRliJ/e5oA18jwhCRbSA?=
 =?iso-8859-1?Q?kTyroG7jfD3k74b6/THP+MzySVslUDsIHW+ErHdgAehJcjFAPl6MMi6sTr?=
 =?iso-8859-1?Q?FJm03Wab5pjiiEeJZ0TefLBQ/gSw6HzNb3R8ASgcWyOrubrg/0KCOOVuMp?=
 =?iso-8859-1?Q?ZOuJhR/yubGjuJwKF033wmPFtwV2MpYtzgW8YAnlt6+DAnCx8TLcuG/PCu?=
 =?iso-8859-1?Q?pS1FMymLw3zHz3DqjsxCXPsIAX1abdLBYKwVhw5RD5sk3c4hmWWsbr+IT6?=
 =?iso-8859-1?Q?w2kicBf8WixgwFrQOibNzekMQ25RgdVA7roapgoIjivLDl1vqM8n0db6W8?=
 =?iso-8859-1?Q?W33nONIeCrlqJFiCnkS3VCRYwDwtzuSjpu8MG/lWQNxqvg4crDocOiMfux?=
 =?iso-8859-1?Q?/XAtXaV1TgoKZoXON28=3D?=
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
	GTSefPcWv9vg/I3f2EQ+jV7zNaMNdB0/4I34aAkgM8VxmgT3VQGMdu4aSVggM7vIb+CZ/HpfymJHJ0YY2d4JXER8OxcQgGD6ZeYoVACh06Cyx7zsfB3T7M++JfmVwoVMopm9XNm0pMICbYUbZ5brr0mBYYKzKG7ChO2BRAnqnz/tL9nr40OMKH0/nyxqSg+ZQtyYJ/1nmiMW7wA/y15NcJR20W4z69/AyZW6NUTiKP/aHaV6QxycSIRA8xzyvXnSISjfkhvHKUbmafmg7k/ES01HyMt3AryOZvwvFpDrrpcsATQ7ZfSQBiGtwBK0J1Xqhv41cKYlQG9dpMnO95T2dFvA/DmmU85BEtULnj0IA3s6u2EZ70pn/e9RXDF2XeJvvLL5Dq1dn4NkVMNG9qK0PHzaVjg8T+FxTYAoWl1ke3BUZ7Jvj2tJc12PA5gfIlK/eSR/RgoPxsQtI5m9V+R4MJ1vPNmvXMSlpmYsxWq2cNmGSLGlvi45rWcDcuC/ynzw1fuZsJB7t5LgqaQXdmkxw+j0HzpOuRVjN3+Bs9WAQgIdAe30ukDkIlEimyXc83wSgiw6Etu2bLQptl9Ms83gemZzRHF0ZYdefFGIQLRTLd41bZWd5kNzxway9SaXrMXQ
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4762abf-d09e-455f-b3b4-08dd7b218fd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 06:57:03.3719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYazu7QUKyieDenem+vYL7zjzr9n1zh+TQ/5RYFfNmkWQreYqWIXxHwbT0vJS5izy5U+zMcvZ0IAbsY3+sDgrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR04MB8281
X-Proofpoint-GUID: ixmLnM28VWOJWHDLCvPkonq_gBLH6qrk
X-Proofpoint-ORIG-GUID: ixmLnM28VWOJWHDLCvPkonq_gBLH6qrk
X-Sony-Outbound-GUID: ixmLnM28VWOJWHDLCvPkonq_gBLH6qrk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_01,2025-04-10_01,2024-11-22_01

Hi Sungjong,=0A=
=0A=
> However, it seems that a modification is also needed to keep the state=0A=
> dirty if it is already dirty at the time of mount, as in the FAT-fs below=
.=0A=
> commit b88a105802e9 ("fat: mark fs as dirty on mount and clean on umount"=
)=0A=
> =0A=
> Could you send additional patches along with this patch as a series?=0A=
=0A=
This is already supported by the commit.=0A=
=0A=
7018ec68f082 (tag: exfat-for-5.9-rc1) exfat: retain 'VolumeFlags' properly.=
=0A=
=0A=

