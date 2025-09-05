Return-Path: <linux-fsdevel+bounces-60349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F78BB4563F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 13:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDDC1C200C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 11:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45598342C99;
	Fri,  5 Sep 2025 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="MPV/gMTU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F77287247;
	Fri,  5 Sep 2025 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757071551; cv=fail; b=IuevMMSueWmaOHuwK4YubM79SkqWx5fw21tuRZ+B7jeNTx1JRv8kISXaXwcaaJDHl8m8m0WaNTAa6WqFtvQwsffulOL4a4FsJV7+FLxFxMED7LYoNwFkSoxZufEJ51CPFSVlqtknD6P6UipSDMN3+fTrO4v/1qE8IoO/oYxg3rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757071551; c=relaxed/simple;
	bh=cFHJkTJJ1G1H506LKOftikeePSmIbOFxPdBbFrj4Hkc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kX76lXVczCnl4ZBGo1SNeBV6qU0FvJf36nH9mIQxlXDYYIQJs5gYViy4rjc23mb4rK2+nYb5Q5CETzLHIjzcYE9N2Lhd3OfDBNAC6ZzK3aKzhqVNyMjrHv1g/Jju1VWBhn7JxbFt9wvEk5WdvXPP4YQOAV5H42FebbJ3KLvN9zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=MPV/gMTU; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58591Xus006518;
	Fri, 5 Sep 2025 11:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=06tHiEO
	yc/dcAonPY8809i1oAyvBtCrOR1w1Xuu6K8A=; b=MPV/gMTU/jrnP/Fqp7GARB4
	/zAZWIj1bg9lc+OhGb7GVuiAecOpXOZE5Tgg4VjGZKiTEUsnhuo7RiEoQicAGhl4
	LHPkPsIje3SxguuaDq3KgKWwYjpN5DiQskfLrp9pIN3Us1/FCT4Rfsug1cgAfHmq
	MQ09TGWpIdrIWViBFPZe4rqGQ8xWtN3s8OqGfR4rpz9nEw4af1eVvyIZmOXidBNH
	N5E1zvHhLdQuV2dG7mJ1nFBjNvZ1oFuoB9FrOnGe2S331PflNowsIPLgEddVH2Dm
	GOqQy3Tg2vaF7FZeF23jfEWXeDOsk4zcQ+GHsPs2cKYeyZqOwcPiBA/a77ef7sw=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012024.outbound.protection.outlook.com [52.101.126.24])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 48y17nhnsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:25:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPfvaFYx0bRbv2ATAjWGnQyuLFg8bmqWpCKvjG3HRHUJLCvHeC5tdE5TVSVyyiwUihMowHaZUIT7VL2f2TzRq9cyE3SFPE+yYFaZZ4+ipEWEcmhvAue/O+z5mwjdVUwNOcIRpUkKivMlZyseT81snog2mZj1ho4wbDFQz6tqCeE/Odj6GmdHFT5uv+AJxbNKqrVzArqwYvsKwU+yZGYxLHUZLyAPpVZHiNfuyaFR7GIzY495J2Y4LO3swl8bjWwcsN2UUUG9MzAdqIN5LYjsvkLCWT5bAcZuA1ZlQOzaDNRtvzwn45Q9ZR/vL1EqGYIeA8ne8Lmgqb28sWNBubBXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06tHiEOyc/dcAonPY8809i1oAyvBtCrOR1w1Xuu6K8A=;
 b=Xcdhj7JpT2JUfMcfDhjvfDcYhFYW6OTcaAjLwqhmu9PZoiVpnRKlphyYWhfOxf4Pnrkj0RYMlOXNO9jDO1kqxwpczu9toWcCR46o5jGIJXE1B4/0M+wum4YzvIbQ+wOsD4nyj0liY78gMY7XaUS2QFv4zDX2+Jd5NO4MTFq5Ct2tzsZ/EwDt+DRjiBo5b97/jKLTKMLFWryS7qgl41mdXWnCKF6br66nMW4MjEVPqY+4vEm7whQVDdyDNmJQNxQIyuYXhM8EgPuT+MmLYX0zDwEn98q2+OYnsfbRAZ2OUzF52CUAfLPX6W9SJyiL1LNNHqwgWfvTxgKr8aupLUfg6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEYPR04MB6870.apcprd04.prod.outlook.com (2603:1096:101:d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 11:25:15 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 11:25:14 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Ethan Ferguson <ethan.ferguson@zetier.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC: "cpgs@samsung.com" <cpgs@samsung.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Thread-Topic: [PATCH v5 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Thread-Index: AQHcHQFN66DQzPG0x0qmSmDoI2X5YrSEZH0e
Date: Fri, 5 Sep 2025 11:25:14 +0000
Message-ID:
 <PUZPR04MB63164B9367EBABF81B381D318103A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250903183322.191136-1-ethan.ferguson@zetier.com>
 <20250903183322.191136-2-ethan.ferguson@zetier.com>
In-Reply-To: <20250903183322.191136-2-ethan.ferguson@zetier.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEYPR04MB6870:EE_
x-ms-office365-filtering-correlation-id: fca63e74-5acf-43c5-912c-08ddec6ee227
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?3tWW4bmZAwAcuq6RMm47JCYgiG5Gu+OgwhMQHXpesMRt22HcvX/EDvyVDg?=
 =?iso-8859-1?Q?4Gis/Uu/cJQNMIpILiJO+iXZNja09+4wjrnoy5sn89igQMyxVcdHhcvlBa?=
 =?iso-8859-1?Q?QjJ2nWharusZJW4DHKEpcSc/vLVCeQWO9sxYK5IsdfrD/mdrdslH45Avox?=
 =?iso-8859-1?Q?VG8aPUVEeD/1Fc5UQ1MS9zzu3OHzldj9BkNEK30UOnkAXb94B+LZ6exy1o?=
 =?iso-8859-1?Q?5ogFAKXGl6eRiXP+dmrWic3BYVNX0U8aK/rzlGDG7EnNActMOTq2RiDGfQ?=
 =?iso-8859-1?Q?hpeqS0TMB6rkZkuYCvRHfPEXfRN7HpKUkZmE2roewh5RiyuH81ZJW00SYt?=
 =?iso-8859-1?Q?rUiMdcQYCqRPgows+rUd9+tL6GsQ+5MoWI6xTcnCuLaWbU9IuN1kOHXZQ3?=
 =?iso-8859-1?Q?LixBMjBCgEqh7ygbj6AcsKGwGK/qHokttLk40NzoSGlzJt/3jTZjEGmtin?=
 =?iso-8859-1?Q?NKXq8wvQZTKIJ5OmB6iHA0T7p4XiBtk+qZA+PFF/FjAsOiaHKg/8BADIyQ?=
 =?iso-8859-1?Q?ulm3wDbYcEqdo5uAFvMj6d4qtrAsRCP9d4UT2ju+9TPWEtFLR1mxwKwcS7?=
 =?iso-8859-1?Q?uniMwMkRUNjKz3rub5+v3PaZMlZ1n3wEFiTFHxj4gEgOPKdM3SmdDPWYgu?=
 =?iso-8859-1?Q?qFjJRsSy+9asY2Hn0mshXAbZJvvH7i94J3rqAkjygHLtdKpsDB5ktphBqV?=
 =?iso-8859-1?Q?6rInCpWLY4HOSoOZyXyPAkLlkxhaJdfJ380Qxnr3LqmGanh2+2WxWEGGM6?=
 =?iso-8859-1?Q?79jTbopVxoG8HnLWI671tIuLFa/6aLDCKFo5j7F/lEfkYkOJJR7LXxv8VR?=
 =?iso-8859-1?Q?5JT6VV4mST7O81e18svZKQ8XzN7KItLhwzHCmn79KxAckxmlGCraDHcnZt?=
 =?iso-8859-1?Q?xr0wQ97HZ/M7XDGdiZv9m6/gDbIwPj5RK/OSpaBeSLR5+SbPpFw4pqus+6?=
 =?iso-8859-1?Q?9vG91zYFWgdLSkHIje4RtNoL1FrWXZ64OjEkDF5GI3jkz21//+njhsH8HV?=
 =?iso-8859-1?Q?ZBtxzyceG2vCfAB8WUhaY41fHEcoDilDNx1/c2/diUqfJINQe7ESN5Uel4?=
 =?iso-8859-1?Q?7bEtjeIUbwsQZBTmqK7afJMg3BjbxS2QH6PN7/UtloCdpcnDN29o8A6PQk?=
 =?iso-8859-1?Q?B4fJn262DAHMNf12A+BkOOVe9Mf4DRPKG+bW6pIsbwhbYQXXg37r27cCnj?=
 =?iso-8859-1?Q?bbrhNeqPXIk9h5GzUcPVo33x8x6+RQLjsWh6lp9J+U19eR5cE5epRZhrbD?=
 =?iso-8859-1?Q?sAXUIuWj9MUEY76TMykSkMtHPdPlr6NPbGJHjDDdhHN59KOKlCexkiaE3m?=
 =?iso-8859-1?Q?glmKB1i8wwe+rqbOoHyZIkqg/0v+Eu+lzVWcnFWfNuSwAJ54xnKD9EC10S?=
 =?iso-8859-1?Q?B/sweJk7wUW5xOWpuWEOOiCPZel3NDizBk3bJ1yZAe3+Pc7CF13q65GPfC?=
 =?iso-8859-1?Q?FpQ8F9rqAHadp84rlTJjy+DC4sZbe3Bb6CV8RJ58MnG4BboeFEEypL3ztW?=
 =?iso-8859-1?Q?HCwvyYaoxN5plDn/h1gtu7WxM8kFiIvSTgWtjLtW4riQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?EXfD1jZQ+wvrNo6Zl8qleoLS5vrzW4eh+S2LGinppQmxjuuxQILNAa6w6o?=
 =?iso-8859-1?Q?o9iDjPEAn6C10V//Op5lxNSkqXzZTlzQdw5IC39lBmqe6/4E1r3KgBYkeD?=
 =?iso-8859-1?Q?Lhklh+JOPqt4rr0sdNU9uYCZMrCyljskvjHicAOv6c+7BgEV0+++GETj2I?=
 =?iso-8859-1?Q?shzdG3jG/vG9iWkieN+KMA8BXy7zSnjZ8b2jWHHxt39zz4ttxyW528TvRY?=
 =?iso-8859-1?Q?KddyLiYxO45zzLzEJgpftvuFr8N1YfkNWdeNyiBbuk4Ftya3SldR4QmOQH?=
 =?iso-8859-1?Q?WhKFCQffBr8b9MiRt1awAU/BAB1oZMbMtAolF8mYERp1VbIXX4b6beBBiz?=
 =?iso-8859-1?Q?wbyBj/OecjFziDqASD6abDPhDEzwo0VNCLBVJBlRCHo6ZQnxy3UdM40oH1?=
 =?iso-8859-1?Q?YkYYWEGAbR2WnsFt/JKGtI9mDW9gZvJH2fPiBW2XvpaKEmzCeg0rCFpwVP?=
 =?iso-8859-1?Q?f5H16Qi9Tj1JurEv9PaB+H958eT5bG3NsaHB/jKAkCDaPxG+BEZaQ0Tob+?=
 =?iso-8859-1?Q?50fezoV+HGthSpRhUowAfhT7bN5fqvr1C2FgZpCBkM8pQXcw4fJ2aJePoj?=
 =?iso-8859-1?Q?iNUtCu29f8xmog8WrM3JFm9mk9pr9OFQu1rn1qSeaNEewkOB/m4rduHUBu?=
 =?iso-8859-1?Q?skBU/Y3yHctG8k9RQHzbIU70N8KkJTmwF9yW7s9Clt+h0g/np/SkfR17Ii?=
 =?iso-8859-1?Q?8Cij9BVjPUUzFuwEoyKzh6t8xwyHBR3bXYtAuoyFX+iO6ZGXSE04BNeymE?=
 =?iso-8859-1?Q?8QfZoS/hfiuSR+JlnJB5tqHUYW4c3Z8KS1tb1CC0P5QNaLoCw2bxh/iFFd?=
 =?iso-8859-1?Q?KPvJZnltuNJkE4AZgLBRAAc04bdGs4996JNmy2xv7Iw+QdOcdM/QIFKkgA?=
 =?iso-8859-1?Q?fqdgQz/nkFozcS8dKEhcT/PovEpm6XVLEVnt6hTxhmQhdbwzMCD+IID8CF?=
 =?iso-8859-1?Q?j2cJFVnSPQz133LVbDBF/zPAezJXuwjE+soMADM8NTlBVA3c+TgQ4YsBUV?=
 =?iso-8859-1?Q?maVitTlT9AfuIhAZKfFWvBm0yWmwEp3yFr9xOwKDyaNcEBrQmm4LzVI51h?=
 =?iso-8859-1?Q?+Hlc1AtVb4VP1coqGVSvI9m70T7IL+V/C7ES0Ye5Ny/donZ7425AVLFa2m?=
 =?iso-8859-1?Q?pLAftsflODsZzncx1ZBYDxq9xkLiFyfzbNDngZcQiSAvNFX9R3C4IRsefv?=
 =?iso-8859-1?Q?u0Ktwe0FDGyhLt2LVUKMcAtBVIs4SMs8vaOzgnt2r0DqR6807/bNf5QIJO?=
 =?iso-8859-1?Q?A9EGYFFCN/NZ84Xzq81pu8nCQ75kwez+dBP3VqFrOF8CFO0G1tyokj/ZGr?=
 =?iso-8859-1?Q?OD/EON2a+bhJOGbrnBq1HTxBBtj+yAj64iid8TyM8/epEC7cJwEQkxLWQl?=
 =?iso-8859-1?Q?VzMkwyKNYiSj9knxGzq8j6RUjWnhkvnjSB05emjOH02Nfkodb+KhD+ZrJG?=
 =?iso-8859-1?Q?taj8YmW/HplcVIadwuigXlDasU2f56d7dzf6ycso8fDF3fEPJwnDtYIVIn?=
 =?iso-8859-1?Q?HstX7DWakwl5mc8ze1zZxpOY/zHhmIRLCFfmBtu1LMQX8qnnov3uB4ALlW?=
 =?iso-8859-1?Q?chrl0YqvcvuGi8cQ0Xb4bQrTYKsIUAwrrrzVJT6XM9qo4dTtn+dWo0C+oK?=
 =?iso-8859-1?Q?gEaQefx2cI8cQaYaSQPbeULFkJJLvjfODk9s5HSZVMP5koa9BVtQbRy2k8?=
 =?iso-8859-1?Q?/Ruqpm3+3am3NeIWNAY=3D?=
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
	Evt36/vD8w5Lt8Kg/BnZlgCn4yTXu0a0kbinQWr9JWuYCcnA6lKfM18kC2cY0WueFUfGttxIU8mGKyIZs/w31hB3gjrjyaIUmKEpSAWSxK2DEfUw2C9/4ZU2rvQ1RJMv7KhXzeVJPeODtCl2tn5rBzPQX3nc0RcNOmBrVlYvKEj3unm/KmR4KZC+v9FJm17JNmpgPJ+vYRlDiqAQBGR/v+tHFyKwg7loJaJP6TLOPp16nN83ggD5PTVqH8w6He8zdTOW8jnISlaSgFWrq5Dn1MLAvS42JmEksITwY5GfW/O172KxlP/JwVfemfXsEDLhTov+iW6/tn79f59FuELl0JlgUxcyhUYXTHMRZhWiK+e1R0y+vcs3VbqRZ5aJxctdefvAt4fcky75ShgizIt7SxCRal5yOo49BU3dHJ+52Ox8jmY/dWmx2rYIeXW8gMIc0vdZEdowHtyjcwBiW/OPWywBCyPcPrcGf9VMx4yDdz2VT4x625UgCUQ7kv/1AmAyohouHe7XXBVXIskkWD7jDE66rfpRglK1RUA6RkmWVuatp7JhQj4BdE6hzzfUKe8w/2h61X8tiAZnawz/6+sjK4SU01pK5+vu29yHpgsa9xp4vp+quMwArhMsWBwn2DK3
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca63e74-5acf-43c5-912c-08ddec6ee227
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 11:25:14.0897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: apDdYt29BpswUlZ4p+/Re6W0boVYGnviVYJ1btjHK+AgxpNuKunl7O4pgJn3CAmpx9dqIxWZIJ/K7SJ3IahpuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6870
X-Authority-Analysis: v=2.4 cv=H5bbw/Yi c=1 sm=1 tr=0 ts=68bac8a5 cx=c_pps a=Tr7ebDVA9GGCAny23x7qfg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=10nkISAlAAAA:8 a=CNpg-p9iGQ0zSDdbh5AA:9 a=wPNLvfGTeEIA:10 a=1PkcQ2-W0spTykm8yBve:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDAxNSBTYWx0ZWRfXyYjh+kzhSLA6 6wCJ8QZOGZaXqpqGDlo9MIAuBVI3Jj5HUShuIXkRWAqJ6lVfkOyf/m3eoeWe1meBOd5410rG9+B xDHYLUVUjdQdpbF/2YlYtOVXsoTXks/e/nGrqgUi7HvxzXQnp1Q3ol/5YkvRswCAeO7OdGqUFYO
 aJRYgAHORkbQOin/fww2FLYM+6yQ3Dx7uKz8Pwx3h8lNAjOdO481AFdT2HlspR5xuTRNMa7w/ik FrbZ8WhyA06oE2xuHnbzvBeLPanIyHYrEXcXvhzYVE6CpTFh+lnYHlAQAGHHKUWX/Xu6P8dRquJ VCHUr7yv2LScMGAjdG0kBUwaoxAdTyi3vHSy65NJIvoIGZP0jViuc5DXYDb2L7tXx4N7kaPNh8C o26+6H1x
X-Proofpoint-GUID: EzWvLMzaGxzqItwz9W5ZXYvFPVFy-0sq
X-Proofpoint-ORIG-GUID: EzWvLMzaGxzqItwz9W5ZXYvFPVFy-0sq
X-Sony-Outbound-GUID: EzWvLMzaGxzqItwz9W5ZXYvFPVFy-0sq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01

> Add support for reading / writing to the exfat volume label from the=0A=
> FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls=0A=
> =0A=
> Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>=0A=
> ---=0A=
>  fs/exfat/exfat_fs.h  |   7 ++=0A=
>  fs/exfat/exfat_raw.h |   6 ++=0A=
>  fs/exfat/file.c      |  80 +++++++++++++++++++++=0A=
>  fs/exfat/namei.c     |   2 +-=0A=
>  fs/exfat/super.c     | 165 +++++++++++++++++++++++++++++++++++++++++++=
=0A=
>  5 files changed, 259 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h=0A=
> index f8ead4d47ef0..a11a086c9d09 100644=0A=
> --- a/fs/exfat/exfat_fs.h=0A=
> +++ b/fs/exfat/exfat_fs.h=0A=
> @@ -431,6 +431,10 @@ static inline loff_t exfat_ondisk_size(const struct =
inode *inode)=0A=
>  /* super.c */=0A=
>  int exfat_set_volume_dirty(struct super_block *sb);=0A=
>  int exfat_clear_volume_dirty(struct super_block *sb);=0A=
> +int exfat_read_volume_label(struct super_block *sb,=0A=
> +                           struct exfat_uni_name *label_out);=0A=
> +int exfat_write_volume_label(struct super_block *sb,=0A=
> +                            struct exfat_uni_name *label);=0A=
> =0A=
>  /* fatent.c */=0A=
>  #define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), pclu=
)=0A=
> @@ -477,6 +481,9 @@ int exfat_force_shutdown(struct super_block *sb, u32 =
flags);=0A=
>  /* namei.c */=0A=
>  extern const struct dentry_operations exfat_dentry_ops;=0A=
>  extern const struct dentry_operations exfat_utf8_dentry_ops;=0A=
> +int exfat_find_empty_entry(struct inode *inode,=0A=
> +               struct exfat_chain *p_dir, int num_entries,=0A=
> +                          struct exfat_entry_set_cache *es);=0A=
> =0A=
>  /* cache.c */=0A=
>  int exfat_cache_init(void);=0A=
> diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h=0A=
> index 971a1ccd0e89..4082fa7b8c14 100644=0A=
> --- a/fs/exfat/exfat_raw.h=0A=
> +++ b/fs/exfat/exfat_raw.h=0A=
> @@ -80,6 +80,7 @@=0A=
>  #define BOOTSEC_OLDBPB_LEN             53=0A=
> =0A=
>  #define EXFAT_FILE_NAME_LEN            15=0A=
> +#define EXFAT_VOLUME_LABEL_LEN         11=0A=
> =0A=
>  #define EXFAT_MIN_SECT_SIZE_BITS               9=0A=
>  #define EXFAT_MAX_SECT_SIZE_BITS               12=0A=
> @@ -159,6 +160,11 @@ struct exfat_dentry {=0A=
>                         __le32 start_clu;=0A=
>                         __le64 size;=0A=
>                 } __packed upcase; /* up-case table directory entry */=0A=
> +               struct {=0A=
> +                       __u8 char_count;=0A=
> +                       __le16 volume_label[EXFAT_VOLUME_LABEL_LEN];=0A=
> +                       __u8 reserved[8];=0A=
> +               } __packed volume_label; /* volume label directory entry =
*/=0A=
>                 struct {=0A=
>                         __u8 flags;=0A=
>                         __u8 vendor_guid[16];=0A=
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c=0A=
> index 538d2b6ac2ec..c44928c02474 100644=0A=
> --- a/fs/exfat/file.c=0A=
> +++ b/fs/exfat/file.c=0A=
> @@ -486,6 +486,82 @@ static int exfat_ioctl_shutdown(struct super_block *=
sb, unsigned long arg)=0A=
>         return exfat_force_shutdown(sb, flags);=0A=
>  }=0A=
> =0A=
> +static int exfat_ioctl_get_volume_label(struct super_block *sb, unsigned=
 long arg)=0A=
> +{=0A=
> +       int ret;=0A=
> +       char utf8[FSLABEL_MAX] =3D {0};=0A=
> +       struct exfat_uni_name *uniname;=0A=
> +=0A=
> +       uniname =3D kmalloc(sizeof(struct exfat_uni_name), GFP_KERNEL);=
=0A=
> +       if (!uniname)=0A=
> +               return -ENOMEM;=0A=
> +=0A=
> +       ret =3D exfat_read_volume_label(sb, uniname);=0A=
> +       if (ret < 0)=0A=
> +               goto cleanup;=0A=
> +=0A=
> +       ret =3D exfat_utf16_to_nls(sb, uniname, utf8, FSLABEL_MAX);=0A=
> +       if (ret < 0)=0A=
> +               goto cleanup;=0A=
> +=0A=
> +       if (copy_to_user((char __user *)arg, utf8, FSLABEL_MAX)) {=0A=
> +               ret =3D -EFAULT;=0A=
> +               goto cleanup;=0A=
> +       }=0A=
> +=0A=
> +       ret =3D 0;=0A=
> +=0A=
> +cleanup:=0A=
> +       kfree(uniname);=0A=
> +       return ret;=0A=
> +}=0A=
> +=0A=
> +static int exfat_ioctl_set_volume_label(struct super_block *sb,=0A=
> +                                       unsigned long arg)=0A=
> +{=0A=
> +       int ret, lossy;=0A=
> +       char utf8[FSLABEL_MAX];=0A=
> +       struct exfat_uni_name *uniname;=0A=
> +=0A=
> +       if (!capable(CAP_SYS_ADMIN))=0A=
> +               return -EPERM;=0A=
> +=0A=
> +       uniname =3D kmalloc(sizeof(struct exfat_uni_name), GFP_KERNEL);=
=0A=
> +       if (!uniname)=0A=
> +               return -ENOMEM;=0A=
> +=0A=
> +       if (copy_from_user(utf8, (char __user *)arg, FSLABEL_MAX)) {=0A=
> +               ret =3D -EFAULT;=0A=
> +               goto cleanup;=0A=
> +       }=0A=
> +=0A=
> +       if (utf8[0]) {=0A=
> +               ret =3D exfat_nls_to_utf16(sb, utf8, strnlen(utf8, FSLABE=
L_MAX),=0A=
> +                                        uniname, &lossy);=0A=
> +               if (ret < 0) {=0A=
> +                       goto cleanup;=0A=
> +               } else if (lossy & NLS_NAME_LOSSY) {=0A=
> +                       ret =3D -EINVAL;=0A=
> +                       goto cleanup;=0A=
> +               }=0A=
> +       } else {=0A=
> +               uniname->name[0] =3D 0x0000;=0A=
> +               uniname->name_len =3D 0;=0A=
> +       }=0A=
> +=0A=
> +       if (uniname->name_len > EXFAT_VOLUME_LABEL_LEN) {=0A=
> +               exfat_info(sb, "Volume label length too long, truncating"=
);=0A=
> +               uniname->name_len =3D EXFAT_VOLUME_LABEL_LEN;=0A=
> +               uniname->name[EXFAT_VOLUME_LABEL_LEN] =3D 0x0000;=0A=
> +       }=0A=
> +=0A=
> +       ret =3D exfat_write_volume_label(sb, uniname);=0A=
> +=0A=
> +cleanup:=0A=
> +       kfree(uniname);=0A=
> +       return ret;=0A=
> +}=0A=
> +=0A=
>  long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)=
=0A=
>  {=0A=
>         struct inode *inode =3D file_inode(filp);=0A=
> @@ -500,6 +576,10 @@ long exfat_ioctl(struct file *filp, unsigned int cmd=
, unsigned long arg)=0A=
>                 return exfat_ioctl_shutdown(inode->i_sb, arg);=0A=
>         case FITRIM:=0A=
>                 return exfat_ioctl_fitrim(inode, arg);=0A=
> +       case FS_IOC_GETFSLABEL:=0A=
> +               return exfat_ioctl_get_volume_label(inode->i_sb, arg);=0A=
> +       case FS_IOC_SETFSLABEL:=0A=
> +               return exfat_ioctl_set_volume_label(inode->i_sb, arg);=0A=
>         default:=0A=
>                 return -ENOTTY;=0A=
>         }=0A=
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c=0A=
> index f5f1c4e8a29f..eaa781d6263c 100644=0A=
> --- a/fs/exfat/namei.c=0A=
> +++ b/fs/exfat/namei.c=0A=
> @@ -300,7 +300,7 @@ static int exfat_check_max_dentries(struct inode *ino=
de)=0A=
>   *   the directory entry index in p_dir is returned on succeeds=0A=
>   *   -error code is returned on failure=0A=
>   */=0A=
> -static int exfat_find_empty_entry(struct inode *inode,=0A=
> +int exfat_find_empty_entry(struct inode *inode,=0A=
>                 struct exfat_chain *p_dir, int num_entries,=0A=
>                 struct exfat_entry_set_cache *es)=0A=
>  {=0A=
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c=0A=
> index 8926e63f5bb7..0374e41b48a5 100644=0A=
> --- a/fs/exfat/super.c=0A=
> +++ b/fs/exfat/super.c=0A=
> @@ -573,6 +573,171 @@ static int exfat_verify_boot_region(struct super_bl=
ock *sb)=0A=
>         return 0;=0A=
>  }=0A=
> =0A=
> +static int exfat_get_volume_label_ptrs(struct super_block *sb,=0A=
> +                                      struct buffer_head **out_bh,=0A=
> +                                      struct exfat_dentry **out_dentry,=
=0A=
> +                                      bool create)=0A=
> +{=0A=
> +       int i, ret;=0A=
> +       unsigned int type;=0A=
> +       struct exfat_sb_info *sbi =3D EXFAT_SB(sb);=0A=
> +       struct inode *root_inode =3D sb->s_root->d_inode;=0A=
> +       struct exfat_inode_info *ei =3D EXFAT_I(root_inode);=0A=
> +       struct exfat_entry_set_cache es;=0A=
> +       struct exfat_chain clu;=0A=
> +       struct exfat_dentry *ep, *overwrite_ep =3D NULL;=0A=
> +       struct buffer_head *bh, *overwrite_bh =3D NULL;=0A=
> +=0A=
> +       clu.dir =3D sbi->root_dir;=0A=
> +       clu.flags =3D ALLOC_FAT_CHAIN;=0A=
> +=0A=
> +       while (clu.dir !=3D EXFAT_EOF_CLUSTER) {=0A=
> +               for (i =3D 0; i < sbi->dentries_per_clu; i++) {=0A=
> +                       ep =3D exfat_get_dentry(sb, &clu, i, &bh);=0A=
> +=0A=
> +                       if (!ep) {=0A=
> +                               ret =3D -EIO;=0A=
> +                               goto error;=0A=
> +                       }=0A=
> +=0A=
> +                       type =3D exfat_get_entry_type(ep);=0A=
> +                       if ((type =3D=3D TYPE_DELETED || type =3D=3D TYPE=
_UNUSED)=0A=
> +                           && !overwrite_ep && create) {=0A=
> +                               overwrite_ep =3D ep;=0A=
> +                               overwrite_bh =3D bh;=0A=
> +                               continue;=0A=
> +                       }=0A=
> +=0A=
> +                       if (type =3D=3D TYPE_VOLUME) {=0A=
> +                               *out_bh =3D bh;=0A=
> +                               *out_dentry =3D ep;=0A=
> +=0A=
> +                               brelse(overwrite_bh);=0A=
> +                               return 0;=0A=
> +                       }=0A=
> +=0A=
> +                       brelse(bh);=0A=
> +               }=0A=
> +=0A=
> +               if (exfat_get_next_cluster(sb, &(clu.dir))) {=0A=
> +                       ret =3D -EIO;=0A=
> +                       goto error;=0A=
> +               }=0A=
> +       }=0A=
> +=0A=
> +       if (!create) {=0A=
> +               ret =3D -ENOENT;=0A=
> +               goto error;=0A=
> +       }=0A=
> +=0A=
> +=0A=
> +       if (overwrite_ep) {=0A=
> +               ep =3D overwrite_ep;=0A=
> +               bh =3D overwrite_bh;=0A=
> +               goto overwrite;=0A=
> +       }=0A=
> +=0A=
> +       ret =3D exfat_find_empty_entry(root_inode, &clu, 1, &es);=0A=
> +       if (ret < 0)=0A=
> +               goto error;=0A=
> +=0A=
> +       ei->hint_femp.eidx =3D 0;=0A=
> +       ei->hint_femp.count =3D sbi->dentries_per_clu;=0A=
> +       ei->hint_femp.cur =3D clu;=0A=
> +=0A=
> +       ep =3D exfat_get_dentry_cached(&es, 0);=0A=
> +       bh =3D es.bh[EXFAT_B_TO_BLK(es.start_off, sb)];=0A=
> +       /* increment use counter so exfat_put_dentry_set doesn't free */=
=0A=
> +       get_bh(bh);=0A=
> +       ret =3D exfat_put_dentry_set(&es, false);=0A=
> +       if (ret < 0) {=0A=
> +               bforget(bh);=0A=
> +               goto error;=0A=
> +       }=0A=
> +       ei->hint_femp.eidx++;=0A=
> +       ei->hint_femp.count--;=0A=
> +=0A=
> +overwrite:=0A=
> +=0A=
> +       memset(ep, 0, sizeof(struct exfat_dentry));=0A=
> +       ep->type =3D EXFAT_VOLUME;=0A=
> +       *out_bh =3D bh;=0A=
> +       *out_dentry =3D ep;=0A=
> +       return 0;=0A=
> +=0A=
> +error:=0A=
> +       *out_bh =3D NULL;=0A=
> +       *out_dentry =3D NULL;=0A=
> +       return ret;=0A=
> +}=0A=
=0A=
exfat_get_volume_label_ptrs() involves finding and allocating volume=0A=
label dentry, which makes the logic complicated.=0A=
=0A=
I suggest defining a function that only find volume label dentry,=0A=
likes exfat_find_volume_label_dentry().=0A=
=0A=
exfat_find_volume_label_dentry()=0A=
{=0A=
   while (clu.dir !=3D EXFAT_EOF_CLUSTER) {=0A=
      for (i =3D 0; i < sbi->dentries_per_clu; i++, dentry++) {=0A=
          if (type =3D=3D TYPE_DELETED || type =3D=3D TYPE_UNUSED) {=0A=
                 if (hint_femp.eidx =3D=3D EXFAT_HINT_NONE) {=0A=
                         set hint_femp=0A=
                 }=0A=
=0A=
                 if (type =3D=3D TYPE_UNUSED) {=0A=
                    not found=0A=
                 }=0A=
          }=0A=
=0A=
          if (type =3D=3D TYPE_VOLUME) {=0A=
             found=0A=
          }=0A=
      }=0A=
   }=0A=
=0A=
   /* no empty entry, hint that empty entry is in the new cluster */=0A=
   if (hint_femp.eidx =3D=3D EXFAT_HINT_NON) {=0A=
        set hint_femp=0A=
   }=0A=
=0A=
   EXFAT_I(root_inode)->hint_femp =3D hint_femp;=0A=
}=0A=
=0A=
> +=0A=
> +int exfat_read_volume_label(struct super_block *sb, struct exfat_uni_nam=
e *label_out)=0A=
> +{=0A=
> +       int ret, i;=0A=
> +       struct exfat_sb_info *sbi =3D EXFAT_SB(sb);=0A=
> +       struct buffer_head *bh =3D NULL;=0A=
> +       struct exfat_dentry *ep =3D NULL;=0A=
> +=0A=
> +       mutex_lock(&sbi->s_lock);=0A=
> +=0A=
> +       ret =3D exfat_get_volume_label_ptrs(sb, &bh, &ep, false);=0A=
> +       // ENOENT signifies that a volume label dentry doesn't exist=0A=
> +       // We will treat this as an empty volume label and not fail.=0A=
=0A=
Use /**/ for all comments.=0A=
=0A=
> +       if (ret =3D=3D -ENOENT) {=0A=
> +               label_out->name[0] =3D 0x0000;=0A=
> +               label_out->name_len =3D 0;=0A=
> +               ret =3D 0;=0A=
> +       } else if (ret < 0) {=0A=
> +               goto cleanup;=0A=
> +       } else {=0A=
> +               for (i =3D 0; i < EXFAT_VOLUME_LABEL_LEN; i++)=0A=
> +                       label_out->name[i] =3D le16_to_cpu(ep->dentry.vol=
ume_label.volume_label[i]);=0A=
> +               label_out->name_len =3D ep->dentry.volume_label.char_coun=
t;=0A=
> +       }=0A=
> +=0A=
> +cleanup:=0A=
> +       mutex_unlock(&sbi->s_lock);=0A=
> +       brelse(bh);=0A=
> +       return ret;=0A=
> +}=0A=
> +=0A=
> +int exfat_write_volume_label(struct super_block *sb,=0A=
> +                            struct exfat_uni_name *label)=0A=
> +{=0A=
> +       int ret, i;=0A=
> +       struct exfat_sb_info *sbi =3D EXFAT_SB(sb);=0A=
> +       struct buffer_head *bh =3D NULL;=0A=
> +       struct exfat_dentry *ep =3D NULL;=0A=
> +=0A=
> +       if (label->name_len > EXFAT_VOLUME_LABEL_LEN)=0A=
> +               return -EINVAL;=0A=
> +=0A=
> +       mutex_lock(&sbi->s_lock);=0A=
> +=0A=
> +       ret =3D exfat_get_volume_label_ptrs(sb, &bh, &ep, true);=0A=
> +       if (ret < 0)=0A=
> +               goto cleanup;=0A=
> +=0A=
> +       for (i =3D 0; i < label->name_len; i++)=0A=
> +               ep->dentry.volume_label.volume_label[i] =3D=0A=
> +                       cpu_to_le16(label->name[i]);=0A=
> +       // Fill the rest of the str with 0x0000=0A=
> +       for (; i < EXFAT_VOLUME_LABEL_LEN; i++)=0A=
> +               ep->dentry.volume_label.volume_label[i] =3D 0x0000;=0A=
> +=0A=
> +       ep->dentry.volume_label.char_count =3D label->name_len;=0A=
> +=0A=
> +cleanup:=0A=
> +       mutex_unlock(&sbi->s_lock);=0A=
> +=0A=
> +       if (bh) {=0A=
> +               exfat_update_bh(bh, IS_DIRSYNC(sb->s_root->d_inode));=0A=
> +               brelse(bh);=0A=
> +       }=0A=
> +=0A=
> +       return ret;=0A=
> +}=0A=
=0A=
If there is no volume label directory entry, no volume label=0A=
dentry needs to be allocated when clearing the volume label.=0A=
=0A=
exfat_write_volume_label()=0A=
{=0A=
	exfat_find_volume_label_dentry();=0A=
	if (not found) {=0A=
		if (label->name_len =3D=3D 0)=0A=
			/* return with nothing to do */=0A=
=0A=
		exfat_find_empty_entry()=0A=
	}=0A=
=0A=
	/* set or clear volume label */=0A=
}=0A=
=0A=
In exfat, exfat_{read, write}_volume_label() are directory operations,=0A=
so it would be better to move them to dir.c.=0A=
=0A=
> +=0A=
>  /* mount the file system volume */=0A=
>  static int __exfat_fill_super(struct super_block *sb,=0A=
>                 struct exfat_chain *root_clu)=0A=
> --=0A=
> 2.34.1=0A=

