Return-Path: <linux-fsdevel+bounces-72971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E98C8D06C8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 03:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36FA7300D2AE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 02:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C642236F0;
	Fri,  9 Jan 2026 02:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="I7IYvdFX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0921B142D
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 02:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767924222; cv=fail; b=Bff8XsyJRx6C6WRuVRPvpyZbDIly+oeHC34Tbn2QleOI7EZAmsPz0//gj+ECSs8MzE5eQEYRqvyhhc63Xu8U+pyQ6Iyt6O6rk2POTxgPn8kvqicISOg8uxx4Wqk11yYYmVdqnf9oiHDlM4YlEIBA6ayWuxa0qa0K78EQDWirMeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767924222; c=relaxed/simple;
	bh=/M+AhyyYDzZyl4VDxhrlb3fgPtmrGUfAkZkjOk6sylE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kNIeQt3ur007a2NDMxEra+fJP9zGOVy05bKZ/2+jsVhBso3kZLstGheI0/z+srmqmmtRU4Z/UllU4q7qGp+IC431jNHUg2vPHJ09/82UdaU80cdIJnYfM/uaHiBS1PuGtvUD4O5BLoykoqILYm1DNM9QfLGWy4BD46LboPBSroI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=I7IYvdFX; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 608MfCNa017820;
	Fri, 9 Jan 2026 02:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=wkNUxs2
	ebscuR1V5Oq4yJFnRmsMaWG4ZmtIZrTu4yvU=; b=I7IYvdFXjC2yRVAsOreSNGw
	AQ2J3uw1u49gZrKQa/9VCt4UOfHhUnrh8FigVE2qO7ylJnDDwSCUTL6o32RRAckM
	7DenvrsnbZMaT7BWBlyLPsyAp1GVwS2k4kDhqpqEJa7K0NBlOEJtoF+q2TSb2IQE
	hFmr0BgquoYwRi/HDny0J9V0krHYzMsvTbUEHaHjVdsbG6Xgso/f9iSEgGNHpF3X
	kbrR1mjA6kp5TfPmrsOzy5mOmCFuwJRWEk9ZYEG8JHEF6clFFFJYlGnEyKff4cOv
	t91Y4gkjK7wgyA+hVF0VloAvBIxMWuwHwjnVSjZpegrx6GNqkSSr0dv7F95CMFA=
	=
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013005.outbound.protection.outlook.com [40.107.44.5])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4besw346hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 02:03:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A00FuCnq0ySY/rPGZUudKel26OGlm/OSj2AKhQzJbZmMl86p9OBnD/vxzSlBQ4tc2MpPOEZsDBx+8dPtY8YY7sIAOJ1pLBpWOoMCDv1sxKnZFQHRT9Y4UfCYXOoHlglAjZXkmjWQBbSZ/V6wBgPHdQcrKTI7I5OTZvkWj8ytq6uQXs9N9LxJd5kL7C2Ga0Xa85FYUCfVBPEJilWClM7vrficBz/HiFTBrcjzhdspxig6gcCLOeD1O4mfVlnSRoB+vDMThgHZ2Uq9fDySN7CiE7BT+JqutnvNjB+ufztovkEGdn6HI/RUAMsvMT/YSV3aefoaQEifH5mEKFT8LnQKzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkNUxs2ebscuR1V5Oq4yJFnRmsMaWG4ZmtIZrTu4yvU=;
 b=n7iXvLCdAf56rectr1FGVXTaTWRNuAwvq0RsmfDBRP7R7Xn1HrkpqQZRkY1JQh7lc1FaKVrUbtOCEHH5lLMRDp5y61uctqhlzzYcaGHFkYEYB7NJSqJNh+2XRtA423PI2OTAPsayAvzjcS102t8nCC1qqAMiUDH9Gnu0OOsKdE+v88cF+Lxou0A+ug+2iUz4PKpzYu+b3OO1pjORp2qpOu78ErIszb0DOSk9wD8Y2QMYwBYS9WuK/dQv6fmySgVuZT53OdgsXBy41W1Z3RFK6QpBXPM5pe2RaBDL9YmsW/vMhYfIqGCr9wdFa9PEFUNFtSu/eifpsPRIvHsNd9by9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEYPR04MB7526.apcprd04.prod.outlook.com (2603:1096:101:1de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 02:02:57 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%5]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 02:02:57 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "yuling-dong@qq.com" <yuling-dong@qq.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v1] exfat: reduce unnecessary writes during mmap write
Thread-Topic: [PATCH v1] exfat: reduce unnecessary writes during mmap write
Thread-Index: AQHcgILw0g7Zqb7ggkO3ubAVka9LLbVJFcW3
Date: Fri, 9 Jan 2026 02:02:57 +0000
Message-ID:
 <PUZPR04MB6316042365E58DC3625A23F48182A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <tencent_E7EF2CBD4DBC5CC047C3EB74D3C52A55C905@qq.com>
In-Reply-To: <tencent_E7EF2CBD4DBC5CC047C3EB74D3C52A55C905@qq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEYPR04MB7526:EE_
x-ms-office365-filtering-correlation-id: bd7e7776-000a-491b-a305-08de4f23358e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?cRlks6cdmGCF8KySTmw//bnrD7+edtb1R83CMknTM6oBPVhNjeLggdX/l8?=
 =?iso-8859-1?Q?/kgpnTxk4I6iuYRjjbdNOIQZHvbbU8CLdzoqX0myWWb2CyEGQyCvZapjft?=
 =?iso-8859-1?Q?7H+fG7gliaThtoVGP19As/85XxXskCewlkVT2po/2BxOkaxZcNF/WvIagJ?=
 =?iso-8859-1?Q?Wcdyj02JR9JjaNTQJmutilClzsAPy9w+/9Vdc0a9e07vP8jTLajBZEEOu7?=
 =?iso-8859-1?Q?oskNbDIc4HsMCIgsBGrSX/Ux08E21gBzW1PuvpRe0UQOVvb4fvf34gs8Oq?=
 =?iso-8859-1?Q?RkkvDXNDFC4JcqaZIWgmMMgxZyiSCaSyjxtRnGtKudrxd68tVQY0Y5hmaD?=
 =?iso-8859-1?Q?z2DH8Be0gN1pQH/3gRBs/j+u8HyobDo+MQV/wmLzoJc7xMcl0CgJHTLBLb?=
 =?iso-8859-1?Q?877DAkQUIqN+KE5R/MhrEWjJkT/ljc2QbXpReNQFOFkd9iejZeSc+ve9VY?=
 =?iso-8859-1?Q?/rOrBFmPjvjcWEcB8tVAVXB339+UsXJqbMAEEzFQ40ekTlKZrCRHXnNKZ9?=
 =?iso-8859-1?Q?MyxrvuLRrdD/GYTNDl3zgYdt/4RuYkt0rytCF4y/j2DejrAz+e7205vPM4?=
 =?iso-8859-1?Q?ljmCU51ktYOWkgaLpt26Lsq1yN3g9AD/3IvZOp729devmz7l8iVy5oFAb/?=
 =?iso-8859-1?Q?GiVJWksDaVXdqj/oTX/l1FxQGgdPEN1GDOzJtXSRA7iWglqCDAmi2pPTXb?=
 =?iso-8859-1?Q?CEkI8MmM2LFCMtRMIl7kkYx7k5yFNuVKB9LQYFps4WR20XSrt96BXgoXwx?=
 =?iso-8859-1?Q?t35z9MLnJISv6zUR73umok5Y+ZWkWt6GbywlRcrs+7BGHmb7atL4avwYTu?=
 =?iso-8859-1?Q?ZLEGYdspU+jctGpeG+tr792v7e54vmoXgLIubLxha+PaIJN/mYvvMkeXMr?=
 =?iso-8859-1?Q?UhbhwJKPpN9QxV8+uxLr5SiA4TP3PTIGVF30JrkxLSNfknWeViM1UwwQVx?=
 =?iso-8859-1?Q?o1g4ojW4JT3mEHDIMB8M7qYrsrITfz/KSXbYx0EI5n3We7t2Wv/eLt9pi2?=
 =?iso-8859-1?Q?01QyGjdcX4lDl5v8h19nnmLB+nDTMlm7XIGRNX1QFr+7GALE+p81dPdC7L?=
 =?iso-8859-1?Q?3BwJwb1USgiX8akA/QAhLdp76xfjAQFdoh/L848xbTFrtambby01XGDbKp?=
 =?iso-8859-1?Q?nlDef8+Nl8OGOd0w5DgmrQ52NeJ99whHOdHFGtUoeXPmlOub5Y0oQbV7Jz?=
 =?iso-8859-1?Q?Nunu6y9gEPfrHWD2Yfm9oI/tZAty8z1QEAxOV/wi+cKDGozC3Lu60kf0DA?=
 =?iso-8859-1?Q?tFXapE4XjAKUkPQWYghZL4j6USecI/JL/RyTLKlTDXASaBW9EGYthoDXVq?=
 =?iso-8859-1?Q?aXjHNJh4LavTqJwci6WZ5hebvVXtKs5U+oiYjzC6NV/o14aQ9lmYbkj2fL?=
 =?iso-8859-1?Q?dMZb1F3DmPa3WIuTiiskt1vy/X8FqcYfX/1cTvuVdpkMl4MHPm2ip3BD85?=
 =?iso-8859-1?Q?zoFfUzd5avKCByEnI+tsIC4H+OVy0YwsZA1Ny1aDnzunX1SgRTRSVydBeU?=
 =?iso-8859-1?Q?t+P9sT+9HnkFLNd541pRgeuyfQYiMqf131/AHHFa0BkVrPNJRcLT0DzDRf?=
 =?iso-8859-1?Q?DgILpxRnrmvt6aZX3nnDmwmbbfT0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sRL2Og2W2Bt2OBDnJoCXIHLDA/xvpkkmBUO27omsrTJ5tNUGfIzJgm3qc+?=
 =?iso-8859-1?Q?Wl0FrwteRAd0+pV2x3EoUcg1nhVlfYKSob2gHXSHYGsft7ONg051iUen+W?=
 =?iso-8859-1?Q?dCU+vDCuBs3EnW4D1r2sf3izOsERFzg2pMy4Ihtptighg4guafMF5ThXU4?=
 =?iso-8859-1?Q?QziQsXb0QH+aT+RfZjiDbDbOpczXaFi9t4Zpe2wK3aho2fAq3SaFuKAhu7?=
 =?iso-8859-1?Q?1+yml6UuLBoHn0z5GON9NQac+9x2fcGDfkwRmQMl8leXnpPV1cAv+KL7RO?=
 =?iso-8859-1?Q?KkHBVz8WxpwLkN+cOK234g9/+Lb6RQ4Z6sTE3yC9tUulEAjIR7rTPiOV9E?=
 =?iso-8859-1?Q?ED8/9CVeKGYVmZyWNxH96hSUrQLlQReC2nreRTjG9iDTm0djDojYuVLTaM?=
 =?iso-8859-1?Q?m2xZbvHZIANlT68WPKhKGUTNNOBijo7CyeoQ9JMybIdKlZskQRXDPRg71s?=
 =?iso-8859-1?Q?lufVxbqcvY27MWNPmJXlQEXOB7m8tkbJ7SFo43Gt0o4X2IT4WxijeNmmcf?=
 =?iso-8859-1?Q?flhZNM2T1js2LraCvnA0L0tUn7mg6olv2uNj7ohX1arJHpSucovpInBuYC?=
 =?iso-8859-1?Q?fbC+w17rO1zF60yFkl+ER0ozHhEIPPixI1CYgTbc8vl0tgD0lSAfxYtPeL?=
 =?iso-8859-1?Q?XzBXdq3c2qz7YBWSM59gewI6rPRiUT+g3ez6oT6Kb1izDJwR/qBbbJeEVu?=
 =?iso-8859-1?Q?QWm7j+1czo1VJcDs0syBAs4Wj6nKNOC0hjW0uVXsC2WO5D4eTkjOAC+K04?=
 =?iso-8859-1?Q?zFGPvujrhwG9qNfIeThHPfm+Eb3fwCA3Qa42hA7+wkqpFGvG9UlrGOCxXz?=
 =?iso-8859-1?Q?EFC4ZjkDehOmqtw9Wm1gul/6AYJyL/p8x1068tcTnBO2A/J+e0fWg64cVR?=
 =?iso-8859-1?Q?fKsdaAtXHzcXFWcEOXNbg9OD98WGpGLbxat8tLSuhCCFsjXUA9zVsiTz4s?=
 =?iso-8859-1?Q?oQHJsO49bxrFdu1BT1daSSlRvrzLR8jZzUiV0b8m6DJp5m9HeutfgGAcyH?=
 =?iso-8859-1?Q?oyakhJz3j+VN/xRutvfaj9cV3gsGGFobi7pViO0xBM/1wmgVHEM5BRypLq?=
 =?iso-8859-1?Q?xCAdNwzjdxFaLuaH/hPReqCXw580JPKDFhDJ6Jqot12eQnBHe5JK985pYP?=
 =?iso-8859-1?Q?h/Kiluwj7kkhCvx68GBCHvb/MAc2xUqcbETCxnNfgL6C/9MkSVHbjcadTE?=
 =?iso-8859-1?Q?9MlKSb9AeMiV9NpQaYpdLlqqryUd2yE3JlE+VMXZaVNTBGqZAEHWtv2xFs?=
 =?iso-8859-1?Q?337n42RywAmuBqDA+XRYQTG9KNHsQssPmL/nsY+zsNv6k9kWJlYbLbWNjM?=
 =?iso-8859-1?Q?s464fOwI/xJ9DQYjIfGT+iDOQHd2A57197H9iWLhw6+LgCXP7jYsxS9Fbf?=
 =?iso-8859-1?Q?OzFJGmY66ZAvWkeXONAK9P4oXNS1TauXv7DiIosJjP6Y2nfoQIfRgC6FsS?=
 =?iso-8859-1?Q?CUC5lbtk7XoQwOrsH1YiXg56FciXl6BsdYwmj2q0R480rdB4UpcuyWSQhC?=
 =?iso-8859-1?Q?rwS2xUk+3lHXUnCZ6IZsWPdGPIcmhyLAOJbJrTVksd+i7Qzoa+PIc6foD7?=
 =?iso-8859-1?Q?FJXan6QvMys5IZ/8gcdQgzMq6pU8IYSnfMYh1GDyz1gIs7z0WMYkUZPLo+?=
 =?iso-8859-1?Q?Bt8460jrRe8kx/rArjNEu2Of6Hj/vXwhzKPedbntk+7Qtkc14UJVlVlhdP?=
 =?iso-8859-1?Q?HH1LlyRr9UoMCDu8KgC6rTeDoUnDTS7YetKNW6EYeVA/EB+g2z6s+Pvwo6?=
 =?iso-8859-1?Q?B8lOU5swUJTKS9i2tvCix4ExRJSjFe9sbhEgRCIzXOP2aTR4psowqmPFba?=
 =?iso-8859-1?Q?iLaos6FQ+qQglBo1Vf2TaKP1aYYx1jE=3D?=
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
	6ZfyBlmFDanusvoGYDOnR3mqH88y2941yaa+KVM3a4o5KogL/8yCHfSeyBHFaRJF1dPF59iFZ1RHHqX7DboorRDZlGGyPW/R1VvbbeElkIvhMbGPnj4hY9mdVwTTPD9tC7lg1Ndp3GJGM79Vi5QFUx3EfOt09M1/jERF1Ftum8gv0XugSSS3VxMCy7pHa/S/Dt8YC1eP/aYG7oMnJ7n8p9N/aU+68XDU9w+irAA0HYzyk41UJFUEL+udAOgsfKgr3DCqkxI3bOORcjrHutN2ELfsoKvWJfzWhgTY05adCh5VP4DBujpN6uxIyEFHk11VxHD58YJQ8IQOwy7L+wDDTuGS0v7onjWJHOX6LEHs3xkcVUIxgi89AZtZ0E7uhPFsC+i6L1vDTxBi9LGh8wMFJaYOBiuxeEjGY1jA64RfP3XfFkIWeHD5MA9o1TWht6ByU0lsigpCw8st1vw96btlr1rRwjHbi2WW5URAB4Q+TcQdl4UFFYumZl+aXvvee41DKGSAGMyNHV9hSHKIKVcYLG4GYviljLcwjRD30owL84hdSFONyJh+VZes7kyDYlSPL2en/xFLp28k0QX7u+u7cKyPwjxJJbUTys/e60h8HroSJwgZgIB31r9gnte/8XTb
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7e7776-000a-491b-a305-08de4f23358e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 02:02:57.3705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4zpYriQmvd28mYHTSJu9FMezVzUx29a7IFLUqWn56IP24sZ3HpJYtGuJ7pi/fARAu8lePBlAQdKEsH1a6YHIzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7526
X-Authority-Analysis: v=2.4 cv=P/Q3RyAu c=1 sm=1 tr=0 ts=696061e2 cx=c_pps a=cs3pSOWwGIniS7uFNYxq3Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=vUbySO9Y5rIA:10 a=7j0FZ4iXMVMA:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=dZbOZ2KzAAAA:8 a=z6gsHLkEAAAA:8 a=VPXunuYHSewunCiI07UA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: vMhqwj5LywHwHasdudt3GxTUfmWsBl2G
X-Proofpoint-ORIG-GUID: vMhqwj5LywHwHasdudt3GxTUfmWsBl2G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDAxMyBTYWx0ZWRfX1tFQeRE1inqd qZkRSkaSv3x6Bd10nerJlYsqF/eSLoXpzOHejha9NocPXMjzit0DD0fMu+2otXm8DyiwdBjRetg N5mqRrAleacYLSsAzVzfnR6LfOSpv4gb9aM1UVmuc7xeFEZcxNfe2eZZW67UzVhPErBqiUc3iV3
 3yFYIE3/vU5epYHLyN1FeQ90g4TfzOLyBt6+BX0CT3cbX7Pf7rkPAHJ8Lj4Np2JBqTvTedEVyNH goaie1NH9wLPW4MllB5i0KfBjs09fysghFNT3Vh2Q+6yUtAvwi1XFhDNwUDF4cJvE6mY6KSlgeB Rv+pCTx+5Cc7/+HtbKh6qBTrqC3J9OU83sgR5rVs9OkL7q5+8cDcymejrAUajiC4sKD3tt982JR
 T7+s4N1CeWtMehDZW+xRzMAxfdl4deV8DaKKW4XoZVSfgu50FdkwmZ1u9pZ3mnBI7d2Ja2JemqY rPssPDjwGF1cWWO2SZw==
X-Sony-Outbound-GUID: vMhqwj5LywHwHasdudt3GxTUfmWsBl2G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_01,2026-01-08_02,2025-10-01_01

> From: Yuling Dong <yuling-dong@qq.com>=0A=
> =0A=
> During mmap write, exfat_page_mkwrite() currently extends=0A=
> valid_size to the end of the VMA range. For a large mapping,=0A=
> this can push valid_size far beyond the page that actually=0A=
> triggered the fault, resulting in unnecessary writes.=0A=
> =0A=
> valid_size only needs to extend to the start of the page=0A=
> being written, because when the page is written, valid_size=0A=
> will be extended to the end of the page.=0A=
> =0A=
=0A=
Looks good.=0A=
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
=0A=
> Signed-off-by: Yuling Dong <yuling-dong@qq.com>=0A=
> ---=0A=
>  fs/exfat/file.c | 14 +++++---------=0A=
>  1 file changed, 5 insertions(+), 9 deletions(-)=0A=
> =0A=
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c=0A=
> index 536c8078f0c1..83f9bebb49f3 100644=0A=
> --- a/fs/exfat/file.c=0A=
> +++ b/fs/exfat/file.c=0A=
> @@ -707,21 +707,17 @@ static ssize_t exfat_file_read_iter(struct kiocb *i=
ocb, struct iov_iter *iter)=0A=
>  static vm_fault_t exfat_page_mkwrite(struct vm_fault *vmf)=0A=
>  {=0A=
>         int err;=0A=
> -       struct vm_area_struct *vma =3D vmf->vma;=0A=
> -       struct file *file =3D vma->vm_file;=0A=
> -       struct inode *inode =3D file_inode(file);=0A=
> +       struct inode *inode =3D file_inode(vmf->vma->vm_file);=0A=
>         struct exfat_inode_info *ei =3D EXFAT_I(inode);=0A=
> -       loff_t start, end;=0A=
> +       loff_t new_valid_size;=0A=
> =0A=
>         if (!inode_trylock(inode))=0A=
>                 return VM_FAULT_RETRY;=0A=
> =0A=
> -       start =3D ((loff_t)vma->vm_pgoff << PAGE_SHIFT);=0A=
> -       end =3D min_t(loff_t, i_size_read(inode),=0A=
> -                       start + vma->vm_end - vma->vm_start);=0A=
> +       new_valid_size =3D (loff_t)vmf->pgoff << PAGE_SHIFT;=0A=
> =0A=
> -       if (ei->valid_size < end) {=0A=
> -               err =3D exfat_extend_valid_size(inode, end);=0A=
> +       if (ei->valid_size < new_valid_size) {=0A=
> +               err =3D exfat_extend_valid_size(inode, new_valid_size);=
=0A=
>                 if (err < 0) {=0A=
>                         inode_unlock(inode);=0A=
>                         return vmf_fs_error(err);=0A=
> --=

