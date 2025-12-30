Return-Path: <linux-fsdevel+bounces-72237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 869A3CE9326
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 10:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90BD33014ADC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 09:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77B129A326;
	Tue, 30 Dec 2025 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="AbODSnrV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9813D23D7CD;
	Tue, 30 Dec 2025 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767086596; cv=fail; b=NQhC9bcnmTR46J4i+QnZYKWlClRgSbyp4nezDQUSobtlf0ifX/FmmKSF3fn1doCyWY0NBQ8EofRSqNF7ODTpGFSF5K/VPmKaPewhA6anQDq5QX2PvGwTJeqtThwYb/xl+fT7iGgdKGIBXU9vyD6EJ3xvSQDgiRULsadJ1bd40og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767086596; c=relaxed/simple;
	bh=1/2qKiii9022410W9P5XLshFlaLvk+ZPhkW6hX+WrQs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e6IthbuGltYOyg3ntxS7EflQx4SZJBvzye1ccxpUSTyKx3LJ5hmVPTC1rmcxSrO2qegzhkfyWgKX9mlbti7INBmO5Eeh1tB3Ks2eMynWEB+xh4doChMRmBPppGjEVV3k32gvhH4wsPtpJnl5PsCfXiRhJXeAcorYSfcWRLTb1fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=AbODSnrV; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BU6u2HA021791;
	Tue, 30 Dec 2025 09:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=AFBTCiZID+oSgwsZvqzc5EMyIDuei
	sRTaDl67N28GDc=; b=AbODSnrVEE+aF6bN1pJI3m3Gq77moHq2AuCtEvm76gjx1
	Ao1H4G6bEuUsq+ml9BmwxIHy330rTsNlcas+6mqCSot5Pz9m0y61TTuMaAYsn1Sw
	hl3drPkyuNv2Usl28fmR+OYl6uPOi3ODqZrnz78wwz89n88dExp8zWwczF1JuZ9b
	vT+t8v1wFPY89woUTa5CVbhDelDEyqV/lr0hE19soRSqlPaa7f7xVLf/vGHBrr/2
	i99Wp8dyLwBr5wm6Btb+KvjzXXlVD5cng59mW+vhtgCeQx075ZiLJcfrQW4gqHD6
	Q5Wxc4zkgeBBOqyNgd7C7Q81kwHe1EH1taMgHdcCw==
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013033.outbound.protection.outlook.com [40.107.44.33])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4ba4m1u4un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Dec 2025 09:05:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwTP/qkV4C5Z5fq341189UpbUI9pUicbRU4fDK7H8M7aBHcjvOKNGBov9UpHIXAJwHoAt7l06AzLiETbHdDh0XCTycbEkIm8KS1CnPDvcAbGKqfD0U3mSluqYN5QdPo/lIcU6NajcHB1C3X5LvQ3lFQrsh73amSNl0zkO3qE8eVIe7Mz0arFK5hmX5bCl5OGNcdKiRfmpEKfvoNUNDMHvMspRxlLb4h+Iqy8I2Hpg2cI5hGu30KaanjQcR6BZj3bWzf6Db237Om8QIwx8kA7VpFNmmtD/cIw1GWMsWiKwQJ5FJiA2ETuyjJxvGS+UCwv3jggKUa6UAEfPBrtndmdzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFBTCiZID+oSgwsZvqzc5EMyIDueisRTaDl67N28GDc=;
 b=K682yazEEzaAfCJxxmqmJC1acMBfrHx1SvxlReUMCvpVYYsjmEsyrD0TjNVNQrNLyvc+eAgmj+iKEfY5VGK6Y/9CWqL+YIuQgLpJaGvNdP6lmyYEaCqOADYN6GPmHC72GNj6FVrtm1Q73ds2kxOqGUkW884nWbvwGYRyypeOm/t6dV4zdC9qpgg77fO13oYJedfINPbEYyRvmELhxJI20wARYOwBi16als7xFGqG7xQ/B6Gb3KkMfRvd6zl10yHYEEh/QXhCHr8CeJUr5wyhXs3wjElqJuf8fsvM0CmlMKvIDc5z20okmtlOUaW+uM4aA07SoJx3olCOBUCMmOyJCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEYPR04MB7450.apcprd04.prod.outlook.com (2603:1096:101:1d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 09:05:52 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%5]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 09:05:52 +0000
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
Subject: Re: [PATCH v1 3/9] exfat: reuse cache to improve exfat_get_cluster
Thread-Topic: [PATCH v1 3/9] exfat: reuse cache to improve exfat_get_cluster
Thread-Index: AQHceV0OEW8234g91k6RDdC9JppEjw==
Date: Tue, 30 Dec 2025 09:05:52 +0000
Message-ID:
 <PUZPR04MB631637893887AB587E1E3A9381BCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEYPR04MB7450:EE_
x-ms-office365-filtering-correlation-id: 9c163200-3054-4450-fbb0-08de4782a205
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?X6lDWAWrK2PhkvE31m6Tx2T7lu0MwysrqgZbNt5GUWsbDNnLELU03lIl99?=
 =?iso-8859-1?Q?1152DE8lscb62TDaAIlGY5qrX93ueFQgwGtmM7v5UooGBsdBqlrGc/g8ah?=
 =?iso-8859-1?Q?q6SbmGic7Bejpq24jWRA/CAduiqbzPYSYMQDxMWFpUb2Le9ebu6fHSzfve?=
 =?iso-8859-1?Q?prsQ0PyLzbD70jtfhFHnMCuOpcE9OjikXf/bpo622pyxgA7L2cTzZ0KZQh?=
 =?iso-8859-1?Q?xyTXTaHN26NT5H/XUM5gkhz8p2tby1apqzI8Ab3EYllCx9PAfjyzOApDsc?=
 =?iso-8859-1?Q?oCiycXfKRTFmHuczoGhAfPEe3wMPzxRfryFfBoWUI3b6Gq1C3CRxPy92OY?=
 =?iso-8859-1?Q?j/f0/LNJApYMn/dpN3fioBGHLFviYy8RWPHZTzkbPv3iEpcyfvrkVCoG8b?=
 =?iso-8859-1?Q?nPX8hjw9eJvnm25nl8IUgfpEhmizKIYz6oJ7xox+7aWEmw0Vp7+PaNrhV+?=
 =?iso-8859-1?Q?xVR7HXGJJRGYnxx7NTLYddmtzIS9cItv12VNxCXor99OXqbYyvYwwYrCRJ?=
 =?iso-8859-1?Q?WPEwUZHGBFbHsEzkjyXxnR5b5rO+pEBmM2Iu+InxdfujAU5gcbQz3C4RhQ?=
 =?iso-8859-1?Q?7gACvRyIFqmPwd/ZvwtP9D7Wa/huAyyR0mLOV15N5GXB0TdQjsXR9My3LV?=
 =?iso-8859-1?Q?Kp4ER8l0YOfrDaY76Sr6uNVpRwXTUGpvyleg0SQOAUr++ir36Ai0xPLOWd?=
 =?iso-8859-1?Q?ubB0jcXBdb7qd1WTtTiO6ycJ3jOmI9QlLcYE5YnPN/09wpZ3EFz1v0LaPV?=
 =?iso-8859-1?Q?UAEnOtvtHSjch9gI+rrtWSWJHRL+yPM0oS9fsffg5h7kEq4QfsDNbPABHX?=
 =?iso-8859-1?Q?pkTIzQStM3GHNIAwMq6GiXqb7/3IZX7+njWO6dkPP8kaLG2MWYGUGJD7VV?=
 =?iso-8859-1?Q?PdSNEqry2QGviilwhOt68d0ikL8kxiKrAfQpw3iaP1apIgaj14+8OrkS8W?=
 =?iso-8859-1?Q?undmokQZARPIM3YBporLkDvMdx5ovs4zXXOBRQekLN236YUJQLDhQ27R0I?=
 =?iso-8859-1?Q?1d/2yWTHT0yuP+SOUpK8gc1NC0rQs2jBbAtu3mlUFwOqJJQqTj+LplTfwn?=
 =?iso-8859-1?Q?cM46wkBLBdmey3TlT1O2JbQxNZsLTK6DDly5yRk0ObAtTS3+CGWjJAlBWD?=
 =?iso-8859-1?Q?xL6TuE2yKY1mBHMeilRXAKZLZyszGIZopqycK9gA0oKxg1cI+ghEXKYixx?=
 =?iso-8859-1?Q?HfZMtEWNkno1Xw3SUiq+JLCy+mlTKME6hX0tlMAraK9OJANwFaS8oImp4b?=
 =?iso-8859-1?Q?XRmHWmbTwTqZL4GlN3antHRJO2oNzTVLJ6DLH0mdQtBPdju0BByWx1bIix?=
 =?iso-8859-1?Q?fYm+i+PjnvAU4W0cdXE8kMOXDzsUl+kmObTutE8QjRNG7rob45uZZ6O41Z?=
 =?iso-8859-1?Q?HI0CyvSq1Jf/TsTT7z+EJK0vrv1sZxCUQhh/zuO6yByqmtE1nc9UXd/oBn?=
 =?iso-8859-1?Q?JWhcevEhuD8vodQiIkuG87/5/Q6EDl5jdYaFru2cgrrkvXr/3B8+hPHdFQ?=
 =?iso-8859-1?Q?YPbXKYX9f4/HGYOkT40ZxLtKrpLb0OuTChzarMUnJ9C+FNktwFmMJmpRkj?=
 =?iso-8859-1?Q?yRwii6GuSfls9/dkjbr4NFLrCsat?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vjTkH4/kAhg5SM0ZSjDKhy9tOB4sd2aenV2Pul2U47wh7wK9M4eudfxWiS?=
 =?iso-8859-1?Q?s0tTiJQnYPXvZDxQBD6mF8/XOuz4w2+hXdCc1nBduUIcViLtvMfj2yx1nF?=
 =?iso-8859-1?Q?av7/ypDGt3acGk/QqWJPTlKqoMXaz/thAq4JQ8dAiFBTvXp5NKVy+0QGej?=
 =?iso-8859-1?Q?18RpPX+MBgmByOgtVqTGAOasGHx5VYbjjKMSDkM81tPjQSdYKFbFUst+Wx?=
 =?iso-8859-1?Q?LP+1WNJnvgqAzomPLgSbvek2XUsZCko0K8Jx0YwP0lluIGV5VvmgxyF/02?=
 =?iso-8859-1?Q?Q+ydzF676psDja1w9+zllVZ8hRCGVnDY4lQ/G5OcD5m8T30Kv3bVQUn0UY?=
 =?iso-8859-1?Q?CLwnn0UZ97gx0F4lZgTtMN/hl6XRrbB123WOFq0nH+gUM4aMMaBby3af/y?=
 =?iso-8859-1?Q?JUriyJuuTbgu9LtIyH6hSzZrXUNvN7DAmP++Osr6wgXj3Z4tdJNShHn71S?=
 =?iso-8859-1?Q?5Av7D2btacrs6rIDlXR6Rf04V7lonY+TiaCJV9U4HWe/R5LrB+CwJ/vqCo?=
 =?iso-8859-1?Q?ZPoYFRRSauVePPXzwhZYSyadWOR0ye8O8xF7hTOFOQSQOklXn9IdaZ/yVh?=
 =?iso-8859-1?Q?L2amYfqKRh59fNpWjZr3gGoLTodHZzeXXk/lcl840qBVaG9u11bqhFUsl2?=
 =?iso-8859-1?Q?V0gzzaCy5rU3YRidnoy6UaOK6b+dS5n6g/7difkX6a3TkEashxo93mxKt1?=
 =?iso-8859-1?Q?jlTDfxaf6xvoDoetQYRCT/DK68wfimUQekjRIMR83e9iLCvusfyLxlJgUo?=
 =?iso-8859-1?Q?hYZSWGWY36AQpZ2snjdpfsBTdAwZNXqR3h2ujRah0CGqTgVjhbNfFKzl0R?=
 =?iso-8859-1?Q?bGdt7Iw2+D27GWuKT9fwAO9hmB413x1hlb/8X1MPIT4sTo/I1cShHBQEmi?=
 =?iso-8859-1?Q?Zsi/qwehxUormknYKUIOzX/1CR16+d+MsuPzJEpSgBIwce9sVntKyxcmhZ?=
 =?iso-8859-1?Q?HrY6RC0n2m/Z8sL+KhSl0oFdwK4ka1nEH09K4DFmmS+hmjUXHA/Nym056w?=
 =?iso-8859-1?Q?l/3ahtgGOYiQhdHIeg82757NIXKT5T1Fk36+jvCEXre/vg7HRcQGi8RxAM?=
 =?iso-8859-1?Q?t9PRebG3i6WcZReF168BNpNewkYt6b9D9pgmOE5vUmQG0xKcscr0DF1vjF?=
 =?iso-8859-1?Q?9swXT/Raajag2vJH1PtRZnOSCyuBA1bapLH3RXR1/4BMtbChTeoguXPjKT?=
 =?iso-8859-1?Q?lLeHx5+diT5r/ESvPcHX9i3nlzuARoa3FI9GYDlEYxtKcRhQs9e2qSFFqg?=
 =?iso-8859-1?Q?HJ8HAc2P3EG54a3ncPcHK8/0RqX7h0m6gXUcRVF30kK4we1rgCpjkxGQWm?=
 =?iso-8859-1?Q?QDIlm//nGj2TQH60pbBnRWBap/I9UyY4m4IiePR+JWXSqj8ewh8DYCVdbx?=
 =?iso-8859-1?Q?hAW+jtrin7dYKuJ6Nwp0ZLPDjCwMWFXrf6kdxUlG0XdhAE4oPv5qaXac7s?=
 =?iso-8859-1?Q?o2Blj6esv1W12WoLimL54QwloiiG9K9+YtVadVJzkhJGgY/vzw3kGfZpdV?=
 =?iso-8859-1?Q?lyP3gQZyDDMXCcJlQwJ4tQebp0ry6CM2KE4uMa4NNNvqn+KifcoxV6PpwC?=
 =?iso-8859-1?Q?sR7PpHJ2OXeH7DR5hd04Dk6u0Q+mdS2Kzhz+3ZZhOhLqsyT0OgYdgsi0rQ?=
 =?iso-8859-1?Q?N9/isxNHHUFZMrrtOTjnJv8oMJ7wQk4kP3CLnKIEW9qg1amTNMdnhIn13c?=
 =?iso-8859-1?Q?+Kisi1XtXgbWBZs6FsGFHtHZ8tXFUQdSU1gCYrhOaVvfDRH6DM6AuAXpJw?=
 =?iso-8859-1?Q?uZMpuwCcYBMkewNVpes16rgIVWMWnVW00usy3BYuGCLRE/fBTgqUK6YajD?=
 =?iso-8859-1?Q?xTLsgujw+w=3D=3D?=
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
	1LBsRuWxAMKymAiFtqPqdtm0ws4V0eUvT2QVdOQEtLR1kvCQFALg0OKC3U7LAUAb0/S3HyYyU3lcZsM6nrvXLfBPdW8NOwbbH43J00HU9KfWo4qTRduKkyK3RGSZROrh9bcjH7ViXIeKGGMUDVjwyzYb+INW0rlN0fuMCgl03T6jJPwm897gaf+36+4uvlfuobgglUVBQ7hWVilXy8qLPrzdefEomxok1czSvR61blF3XhGyRIODtCpOtSyILAeWQY0j68f97aBjXmf2E3JW/lKh6r033TOC8iRjmiicBxGp0HWBY3VjbYan8wkxtc+QHBLSCz419Z5NEagc0C6ZZeB1fQmOBco/RNXWwWZxI9yh2yrWPfmdLqwnbGUED/dGwnZKcfUe4w0+uL9jexP+Mlmxfwv//7zdMGdgm75TgVRDQKmOfuckGBr/ODkHH8tjunT1lty0ysg/Dk/49tIVwvDDGYVhYwRM0R8eoRJFP47NyqNJfkTEvR3oq0O8PyrT0QJ+4ie4Knq917PfwwE2g0wNWa8LA5no6Cx9N5OsnDKb8s+gkRJ3LlvSbLH6bhEaSFLCHJqGpX2+gd1dJlZ6Ko3mGb7Udm4NLq3eh44eToPEveJ3bgxaHOB9JKV4xml2
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c163200-3054-4450-fbb0-08de4782a205
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 09:05:52.2190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+TOw18b2MLZLGzLjKSj6Dhg0h4/Jt36TfMkEcfO2dg9jVInlMfAgZ2UAFiXl+kV5LwsNhr4CasgyizHGGMtAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7450
X-Authority-Analysis: v=2.4 cv=GK8F0+NK c=1 sm=1 tr=0 ts=695395f5 cx=c_pps a=OQkrFVMm8+dctdvY1lDM4A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=wP3pNCr1ah4A:10 a=7j0FZ4iXMVMA:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=TzMiJfr9Lv_7HiasxN0A:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: GMxLKyEOJQCzvgDXbaB9t6dRIQTB8olI
X-Proofpoint-GUID: GMxLKyEOJQCzvgDXbaB9t6dRIQTB8olI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA4MSBTYWx0ZWRfX9BbmMR0FMrEK H53CbDIZW9OukQnoUDETCL4kZz21LObBeZVC1SSeXBU3JAOgB/iv06/z+/hh/AkbECtINuR+TDi S+bKJ7htjdqhHqSpghhiAGL4M5Fb3BEipWSWEZhKWd9UR/x8W1keIYy7jab4vuaDu4etNl2MyvQ
 /dNnH5+3lbhsoBfaR9tYJv1ULhEXDr+D83OyVe222xAuTYo8IEdT/J8gQ6TBPuA8FgiN6VD9UjM hLShRTyS7bgWzGyTatXJSlNTOht2R5830I+sTv2dDt6h67B2pQsx8I97HPEG31IUUF3hAKd+yNJ bZyO0Ed1xMc66i9/bUPfyx1DvnVa9TKugIN/JzgUrleVDEslYoCVRnd+hLKp/DqYuLqKtxsLdoL
 NOMqYBkUczPrx7jGXuQILyIOaz3JHgYCEqfpdtgXXJ8vjjcraBMNmmyjTPtPTZiBgXwWXVTYsuk +twDJC3PpyDiOiGxVWQ==
X-Sony-Outbound-GUID: GMxLKyEOJQCzvgDXbaB9t6dRIQTB8olI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-30_01,2025-10-01_01

> -             if (exfat_ent_get(sb, *dclus, &content, NULL))=0A=
> -                     return -EIO;=0A=
> +             if (exfat_ent_get(sb, *dclus, &content, &bh))=0A=
> +                     goto err;=0A=
=0A=
As you commented,  the buffer_head needs release if no error return.=0A=
Here, an error was returned, buffer_head had been released.=0A=
=0A=
>  =0A=
>               *last_dclus =3D *dclus;=0A=
>               *dclus =3D content;=0A=
> @@ -299,7 +300,7 @@ int exfat_get_cluster(struct inode *inode, unsigned i=
nt cluster,                                                                =
                                  =0A=
>                               exfat_fs_error(sb,=0A=
>                                      "invalid cluster chain (i_pos %u, la=
st_clus 0x%08x is EOF)",=0A=
>                                      *fclus, (*last_dclus));=0A=
> -                             return -EIO;=0A=
> +                             goto err;=0A=
>                       }=0A=
>=0A=
>                       break;=0A=
> @@ -309,6 +310,10 @@ int exfat_get_cluster(struct inode *inode, unsigned =
int cluster,=0A=
>                       cache_init(&cid, *fclus, *dclus);=0A=
>       }=0A=
>=0A=
> +     brelse(bh);=0A=
>       exfat_cache_add(inode, &cid);=0A=
>       return 0;=0A=
> +err:=0A=
> +     brelse(bh);=0A=
> +     return -EIO;=0A=
>  }=0A=
=0A=
=0A=

