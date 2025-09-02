Return-Path: <linux-fsdevel+bounces-59928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C902EB3F445
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 07:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F262012AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 05:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E432E264C;
	Tue,  2 Sep 2025 05:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="K8TPUxaU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E642E1EF5;
	Tue,  2 Sep 2025 05:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756790087; cv=fail; b=pl55N0meEDpvA5KuG8Wc9EY98kTrYzbunZ4CjIxdtT945ZRDF/Q7vk4Q/ke2Ev4rJYKobUhKXcYQO6nUW1e0L1RrRvk1pD/ffvQ/j85J9p3W1IsbA8IMUAWHsjSvippMziZH1lUE+jMm2SGyoUtRfD5AyqLaL17UeKLOS+3J6Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756790087; c=relaxed/simple;
	bh=AQh1RR8eKVxg2LT8Z6HEJ2oE0U6CmQ+Pp2RIPxQFLD4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yj9FJ7Xp2U5Igdp9Vf7H+7o3IWWwQbVljHaaueNmCRZ/1CQL3rexJe8n2paVTdycnWzVWXqL7Dv+dnv0fZ/Y2S9raMkKhzMNTpBg/LSXM4r3VIt7lDGAAOwyp4fnLKQUGB3RMhgLBjDchnuhKH+V6pzYShFfYo5sJ5hX5smpmVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=K8TPUxaU; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5824KhwV029749;
	Tue, 2 Sep 2025 04:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=fSC48Yc
	hRCjcNiilQl2eCftQVuVwfOCaAozsELmMSA4=; b=K8TPUxaUVp4qIqolnFZRa1n
	0wI62WPJOfB3ZMvQI9YQZ3Na8L2IK86dExnye03SAc6Ya8/rFknGP4Qfu3Vt7rtE
	O/fq51qPDmkmjhUKQFjUe/c35QrUCdMkxtBs/6S8/x7jAItJDgPh2WqCtERG7LJQ
	HxfhxC+LokgxnsmPgoWfQ4yq21rbm54opBz3sEtv+Bi93Nxbwf2/dFgzrN3GLAv2
	qWzPUoUYHdGWq66xsXiAkDZjtxr978530D+Qvbl8MqQHKaAa3Gn7nMkTIw1McBF4
	n0MHzO8rrJri+u9LQM6/UL5/PZlufXhPHxWiOSqOf/s4thUQ8cjv5BPNC7DwnWA=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012053.outbound.protection.outlook.com [40.107.75.53])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 48usgyt311-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 04:56:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DeIbZWl8YXTNECs+Fq+ndC+NjCzl75ACuJ5K98umFdYF2Hqq4pBKejgBhU7SNrti7b2ay78pe372QA/wq366sYvyzg8dHnDsOIaq6dGf4A1Y20ehTX+FFYBj9Zg0b4wGsyLgIFli1VJDQjcND+Dp7Quj5R94e1lUQwhU7nCFP4j81aQiB2Cep/Pf6HmJ1OGVhB6xvEEIzDC6aE80+fDX6bwF807sPXllbtvS66lvG5P3exb4+5soNi3Vvxjo+iKRNtr188/rdh2G8by+Y9CNM78bqBVrRwV2hampPBIzjarJ2q/O4xrEGJw7l/zGh7fX2LpANF2CI5M2DLWIbwlFTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSC48YchRCjcNiilQl2eCftQVuVwfOCaAozsELmMSA4=;
 b=bGuEg9GcsuLgbROGxbWovn9qQZXcsLTPMzbRLqs1CbghVG42jclCZEb1R9kkaT7qM9z5kiJpI/oppUCKtHsg9CXjKGVjzfZoj4iRJGSzU6QpR3bQvM41SXF+ZXIkjAYYFy1kWzW8cBG+M+YCbqAcgxo/El2NINmeo/6+kJokOJaENxH+T6+nqr35JNvJGdJ/PxvRxHMNGb03PTxQZZ5J9gTjv+aOtA4QOkOxik+nak/d7kRcuZIpsZAs5pJYYGAWLnGL9HmDRHq6raNHV4XYx1Nf53MLQMAiqWUYoBlC+yf3O1sv2Bei18u5G0E/FL+z5BikaEdn0pAH8JKeo06SYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYSPR04MB7149.apcprd04.prod.outlook.com (2603:1096:400:481::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Tue, 2 Sep
 2025 04:55:59 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.9052.027; Tue, 2 Sep 2025
 04:55:59 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Ethan Ferguson <ethan.ferguson@zetier.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Thread-Topic: [PATCH v4 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Thread-Index: AQHcE6I9IgEshd3irEqcwQIMSQKH3LR/R4zE
Date: Tue, 2 Sep 2025 04:55:58 +0000
Message-ID:
 <PUZPR04MB63160C89856D1164322B643E8106A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250822202010.232922-1-ethan.ferguson@zetier.com>
 <20250822202010.232922-2-ethan.ferguson@zetier.com>
In-Reply-To: <20250822202010.232922-2-ethan.ferguson@zetier.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYSPR04MB7149:EE_
x-ms-office365-filtering-correlation-id: fa37f47f-3aae-4e7e-8e90-08dde9dd021b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?D00N3TCheuyq4TLbfJ3TdJO9Rzr1Q5VOnffGl7XbyxpmwzIgX0OxqaHWAG?=
 =?iso-8859-1?Q?kEvQHPE2KJrSqp9qd1JmQ9RMgxz08lXBhI6f/+NhNqZtNekv666SXK41Sf?=
 =?iso-8859-1?Q?uhpeHIAP0vLPIzids9mgGAt9pKtnL6xPiMKZ8Lhavqs5YfzuMaOUlDYzYo?=
 =?iso-8859-1?Q?pxUiUrWdciyBOv2nRAeiCE2m7dDb59ZYyffFu6N6r4c4nymSwIFDF1t1Dx?=
 =?iso-8859-1?Q?RMFyzPrFY8dmV+zxZw7N+R5fbKNk0TOA8lp6evRGubeI+Ew5+YxAJ7zRtG?=
 =?iso-8859-1?Q?kgsT+dKjcfPfE1QBbRFDYGh/VcKGKPqdDyNdSLIr3jxt0pbLEle5u/j4Yq?=
 =?iso-8859-1?Q?46a5B5JpyyIjulL2lCgfBISQKe+QnQYFCDwP25OgN8zYNQ4MXtRUpN+nkc?=
 =?iso-8859-1?Q?6N14JoACll24hMs9CcwfsRqAwB9xN47a6/VwLkxI8383cRReZslrVzczHQ?=
 =?iso-8859-1?Q?4V0OWlfI4VxjD9J4w/bLV50/bctZRkka/oF2uXxnIW3sFl2SgHF1SRt41M?=
 =?iso-8859-1?Q?a3weWzw9x8YMyZAUoBiBCKqh/mrfdmfB2HeGywTCgdONKKdKunRxBy9pTl?=
 =?iso-8859-1?Q?PfaovYdSaTunvIew8Zha/m3Nwm6A+ji6W5HoqZEEOKfFy14TJjLWrnpZ3r?=
 =?iso-8859-1?Q?p0grMvrm+4zTwoR6fE2IcqD8vUfuT7sN1jmpule/2A8e8CokhGy0IaGumc?=
 =?iso-8859-1?Q?ttcqOovWm43l2uEV5VQf1Zae+/e8jFbGO0nmX9Dg4rjPg+5wbH87LhlCGc?=
 =?iso-8859-1?Q?kPTMNXnxbFWjCXFJaRA1RMy1hLje2iKGzWZ9vPTh539DS5pivHVcDLs5H+?=
 =?iso-8859-1?Q?igpPZUtFuRvEqyVfb9cQhdiq1FgV6szyGumPTJpbv6YdPpFR/mlUhayV0K?=
 =?iso-8859-1?Q?RZ5jza6wPHVUvFaQKx15dIpZYSzpIm1NCGjv1Igwb8T2F0PbjSOMzrzYms?=
 =?iso-8859-1?Q?3UT72/zha9gps/krgFKpD0V+0B/2FvPV/Es8+atrrEcTA4UqJGlZqTrd51?=
 =?iso-8859-1?Q?+us9CKKpcqo9FbX23YfkKiXm1rWNHcRYb2XQXfLj4ZKjCZeNmefpMMaJ6F?=
 =?iso-8859-1?Q?EjpweSZKIM2Dtq0dGOieAR5OBp6IrU5DlLRB7Gp1OfS2FC9043RYBNx7KT?=
 =?iso-8859-1?Q?bs9rqyxTYfCEBnlitivji53mNTLWVTvWbcluPExZ3IVijc/ySXEMr65E3g?=
 =?iso-8859-1?Q?Is26TG1GG7MkNscyHtPtx85tv11uRzhR4DSTvccW4zgsj+xhyfmlXL40kL?=
 =?iso-8859-1?Q?7g+LZYjRVV5UzPndXou49UOqR/9/vPW2hspl5pWlJQvXv+lC/jYRjDGQAu?=
 =?iso-8859-1?Q?TZow5qzwqj/ibTe1qswLyfX4ACrLzQJWhKnZIElmue5OcJkQLYlUP09cFN?=
 =?iso-8859-1?Q?oSNuh6HHIWo6ujLraijqdVTchv1LQWihsH1edlQtpFA2ky/sirbmBXLeh9?=
 =?iso-8859-1?Q?C6lyuki905g/+m2062+OyE6SDNifeIZcGB1n12Nkddvu2zksE5l/6S0DA4?=
 =?iso-8859-1?Q?kr1UUk/IEjl36ECrOs4l1znt1fxEEXkZBMKpuQcGZzFA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?01Qq3qvONMmuIoqcQOGihosidY8SvdrxSZicQVDdv8KC14nCYuMJaFDclB?=
 =?iso-8859-1?Q?d+ktV6CAdsasWG9k6uR+H3J8E2kY0L/0Zh5ZzgRRu/Bhx4IUScjNz0eWZF?=
 =?iso-8859-1?Q?AZEk/BjBgQrFtoBth+UkubaQCNO5hpqkSFSE3P7MHiLUKP2rt0bdzsUpwO?=
 =?iso-8859-1?Q?7AC03//ssPRrKlAtvIYd5m0JM22R3ZucV9+0VE4/z8LhuyZe3p6ldidA5T?=
 =?iso-8859-1?Q?7/NGDdNB70nwhxUM1kcryeFv/972IRkP1NgAReaDIpFelIbHVxPJ7hZZ93?=
 =?iso-8859-1?Q?ir6CF6FUaWoatzMku7FUEG6McqqG1uZCoClUdpwpeBir0WiUc6orsdUG6c?=
 =?iso-8859-1?Q?jUTi6WQd4Y2/JuvEhhkzzttLADbGQofRoVZHpdZHCpl3DzFwc4H1ITRdlV?=
 =?iso-8859-1?Q?PdnoMoMDb56CcmrgteAqsZTQmyvN157klyv2iuVR6uHoWcuFeuPPrF5V23?=
 =?iso-8859-1?Q?fVxTbR59gxLWcfiJsg4yMquYEcJ6VV6Gyo0l1w9eERIPhOUz1Fz9vEimIh?=
 =?iso-8859-1?Q?tzaZYimTdLTv3uToFNK6iYPbfLZVVmVnDnrxO78YwOzl5AwxJIsh6hR28E?=
 =?iso-8859-1?Q?CVdnAU9EhfWRCX5S7f8FiaK4Ejq0ivCUTpeHMh22oApjlpcvHdBJw5FDH8?=
 =?iso-8859-1?Q?HH5RoQbUYRobSQEf8CzxZVg04p5BPphLpv6xRz5/RuZLmrWrM+dawaCdfo?=
 =?iso-8859-1?Q?dauqGJh+Vg5od9lwVmmla+Gcp+91lxPP4hxVC3NBWzZqbDudFpcI6uUSjc?=
 =?iso-8859-1?Q?a53ZFNvtDvvueppC0VrBETjyIuiHK6baE4E5bXId3xEwDg2spYdhkdr28K?=
 =?iso-8859-1?Q?TVkFNgVpTE/LyfZMClwURhL/0ZRI1i1HmEqkVOv2i76c0bmDkG91f6LYL/?=
 =?iso-8859-1?Q?Mylm6iNGfwE/cmZgcHyDOKVzWyanmpqgldd439Yswi/ROT76YzOvhqe2SX?=
 =?iso-8859-1?Q?KeYMXIrw/9OLOLtuR7G33EOh9d7jBErS0d3McISefxJzt/kq0DsKMXBc0N?=
 =?iso-8859-1?Q?LHeXkJB6UlpDFcv4Wekex/2W+rWFcAIwRbkXncO/rZJ6aRgxl0Gw15g9nk?=
 =?iso-8859-1?Q?AP9FmRtgprDxeshFuOYfNzD6Oxil3idOpGOsTcczH12LM2Bc38MavFg6Tk?=
 =?iso-8859-1?Q?IKgIKekRivNEtOX+XC6kkDmDQgPiau/AOIHbWr1B72I6pgHWE+MOyT/WK5?=
 =?iso-8859-1?Q?sq6/cn8su6+hx7HA2VNorlgbbPcqvQSHdPZtOfqt4mS9jhIdGaHK5/2mO0?=
 =?iso-8859-1?Q?OkQDpajL30/XOMYfjvHzirl/4WKNR9Js0z5Ar8KdPLk+nAQNGo89uuJ5iD?=
 =?iso-8859-1?Q?tdnOQEc1fSawYOB0pg87NDEXkoh9Vd1WpZev5CUpckI/BS5k+ifHijODNI?=
 =?iso-8859-1?Q?OMc07RfTpr9xT2T8g7yLL39n+PVw1w6g8ebm7Q19ymZZyQ+HjjVXwYAaH4?=
 =?iso-8859-1?Q?UXmw44VxDQx05upDQnnNpvqns+adWkZUvxpTNm6xnQLjTaa5VZbnWdVpgN?=
 =?iso-8859-1?Q?qx88+aYNNmjrmMInkzzVl9Qmw+bRVRwX4dsSiPZsHGet0gWPLbmsEeo0Qe?=
 =?iso-8859-1?Q?mTak00SWeJj3EsaiJRDxtlHuY4Wb+MPDQE57kCh7i+ev3D7tD9mr0kC3a2?=
 =?iso-8859-1?Q?Z3nuDVYL4wYnCUp2S1TiG1CtycJp0CVJl2lnp60iPcN8yPZkL5le/dA76c?=
 =?iso-8859-1?Q?RSDJjM1c/ugkoVYgQ9o=3D?=
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
	9eTzoup6jRYMzxWd07Msp/D6FksCBkwG4Pyi0jWUuAugrD+B9O5yIBx92W206tJejv0b/ezfvsVW1GoT3dM1c2cD8b+c5Sf9kpfGp84EwawuIyrKwhMB8nV+kYB02Yb41PoDJAgTvMsEuSM5716J+tldPwXwlR6pgx99OYWU+7Ozv7OKEIrrxlermPy9zY9yGoRkCCfc+/Og9pXkeRH3k3ILz9KaMnrkHD3lq4rr4Z7koPowcwiVO2lkRIFEuagb/YMP3TkFCVMeJsfVonYnLUYSnyEz/blsgewuRCklMW5qapmVIFrdeiNljvRCDdvepqS+YrgK8MX/oXd9XLkj0dyX6oHl8uX2wqi390B0YG08VRnTSUEr1JaMQ60VHxGejI1o56ZNZefO2jvVpi587uw31ulA5deuVdQ1+YAIpK2FStyF+wbogHGhYI+eTZTrOMAsc+0h7JdvZ4YbeNMi/f3VB6KPc2h7SDKJAZQQPcR3/j9P8t7IyTfm+Xl2aLEFF8LfhmSQJUHOHJ82AdV5c4AfMSB8fZ72O+pLk6SdL+FhX75ny/Oporlfsyy4QUck+s2v1J+NV+mTzuQhpn+UKXQm74Sb3axmBiRu7Z9E4acXH+Q/YfCnqWZd66QyoPeZ
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa37f47f-3aae-4e7e-8e90-08dde9dd021b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 04:55:58.8657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I0mzuP6vNlVEOAw0fbvPveABMsW82eyRcQaBzpoR49sF+2z6Ic1F8n452rB2SxbmiThQ7dW0eZ7t92LmJhLWyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7149
X-Proofpoint-GUID: gPKr5TpG58n-ZBjfYB0o17Ptxd57BriA
X-Authority-Analysis: v=2.4 cv=fuHcZE4f c=1 sm=1 tr=0 ts=68b678e7 cx=c_pps a=FxRjoDWrW0nFRHFIgE7KIg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=10nkISAlAAAA:8 a=iqn_c2uuIOv6S1nmLkIA:9 a=wPNLvfGTeEIA:10 a=1PkcQ2-W0spTykm8yBve:22
X-Proofpoint-ORIG-GUID: gPKr5TpG58n-ZBjfYB0o17Ptxd57BriA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX6eDj96alCFia LOvQKOzD2lVFrjwrO5bn87VggibfbV3uGRz1qR0mS3FdVEfoxp8CugBMH/ZR8M5bM2I9QjSEc2d 59SqlpVPkw3OKxx133JoECCe8HcVJUXOCjeXDi62jLqZHD4ze9iSv9ertPD3s2V5UvH5u8SGqWk
 gr2Y9OpzDVhPax+24YrL1S9j8f5EVSv6q8UUit4xXe7ootC3djKehg+U/0lpe9W/YU+9zk5bAXN wOzKNBCpUJlWlqu6bw5LJfg+Jwnu70ad9ykPyolE2+sQAkJxRRSC72QNuNlMPZI12ESykSIK43L 6kpJl86fO67r99G5kQ/N3U5ojrYTtS+AEwmFqDuiALVvLDZ0mfM0yCZyrHJfU3pBm1F/KOk9+Qi jm1dcWLs
X-Sony-Outbound-GUID: gPKr5TpG58n-ZBjfYB0o17Ptxd57BriA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01

Hi,=0A=
=0A=
I have 3 more comments.=0A=
=0A=
> Add support for reading / writing to the exfat volume label from the=0A=
> FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls=0A=
>=0A=
> Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>=0A=
> ---=0A=
>  fs/exfat/exfat_fs.h  |   5 +=0A=
>  fs/exfat/exfat_raw.h |   6 ++=0A=
>  fs/exfat/file.c      |  88 +++++++++++++++++=0A=
>  fs/exfat/super.c     | 224 +++++++++++++++++++++++++++++++++++++++++++=
=0A=
>  4 files changed, 323 insertions(+)=0A=
>=0A=
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h=0A=
> index f8ead4d47ef0..ed4b5ecb952b 100644=0A=
> --- a/fs/exfat/exfat_fs.h=0A=
> +++ b/fs/exfat/exfat_fs.h=0A=
> @@ -267,6 +267,7 @@ struct exfat_sb_info {=0A=
>       struct buffer_head **vol_amap; /* allocation bitmap */=0A=
>=0A=
>       unsigned short *vol_utbl; /* upcase table */=0A=
> +     unsigned short *volume_label; /* volume name */=0A=
>=0A=
>       unsigned int clu_srch_ptr; /* cluster search pointer */=0A=
>       unsigned int used_clusters; /* number of used clusters */=0A=
> @@ -431,6 +432,10 @@ static inline loff_t exfat_ondisk_size(const struct=
=0A=
> inode *inode)=0A=
[snip]=0A=
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c=0A=
> index 538d2b6ac2ec..970e3ee57c43 100644=0A=
> --- a/fs/exfat/file.c=0A=
> +++ b/fs/exfat/file.c=0A=
> @@ -12,6 +12,7 @@=0A=
>  #include <linux/security.h>=0A=
>  #include <linux/msdos_fs.h>=0A=
>  #include <linux/writeback.h>=0A=
> +#include "../nls/nls_ucs2_utils.h"=0A=
>=0A=
>  #include "exfat_raw.h"=0A=
>  #include "exfat_fs.h"=0A=
> @@ -486,10 +487,93 @@ static int exfat_ioctl_shutdown(struct super_block=
=0A=
> *sb, unsigned long arg)=0A=
>       return exfat_force_shutdown(sb, flags);=0A=
>  }=0A=
>=0A=
> +static int exfat_ioctl_get_volume_label(struct super_block *sb, unsigned=
=0A=
> long arg)=0A=
> +{=0A=
> +     int ret;=0A=
> +     char utf8[FSLABEL_MAX] =3D {0};=0A=
> +     struct exfat_uni_name *uniname;=0A=
> +     struct exfat_sb_info *sbi =3D EXFAT_SB(sb);=0A=
> +=0A=
> +     uniname =3D kmalloc(sizeof(struct exfat_uni_name), GFP_KERNEL);=0A=
> +     if (!uniname)=0A=
> +             return -ENOMEM;=0A=
> +=0A=
> +     ret =3D exfat_read_volume_label(sb);=0A=
> +     if (ret < 0)=0A=
> +             goto cleanup;=0A=
> +=0A=
> +     memcpy(uniname->name, sbi->volume_label,=0A=
> +            EXFAT_VOLUME_LABEL_LEN * sizeof(short));=0A=
> +     uniname->name[EXFAT_VOLUME_LABEL_LEN] =3D 0x0000;=0A=
> +     uniname->name_len =3D UniStrnlen(uniname->name,=0A=
> EXFAT_VOLUME_LABEL_LEN);=0A=
> +=0A=
> +     ret =3D exfat_utf16_to_nls(sb, uniname, utf8, FSLABEL_MAX);=0A=
> +     if (ret < 0)=0A=
> +             goto cleanup;=0A=
> +=0A=
> +     if (copy_to_user((char __user *)arg, utf8, FSLABEL_MAX)) {=0A=
> +             ret =3D -EFAULT;=0A=
> +             goto cleanup;=0A=
> +     }=0A=
> +=0A=
> +     ret =3D 0;=0A=
> +=0A=
> +cleanup:=0A=
> +     kfree(uniname);=0A=
> +     return ret;=0A=
> +}=0A=
> +=0A=
> +static int exfat_ioctl_set_volume_label(struct super_block *sb,=0A=
> +                                     unsigned long arg,=0A=
> +                                     struct inode *root_inode)=0A=
> +{=0A=
> +     int ret, lossy;=0A=
> +     char utf8[FSLABEL_MAX];=0A=
> +     struct exfat_uni_name *uniname;=0A=
> +=0A=
> +     if (!capable(CAP_SYS_ADMIN))=0A=
> +             return -EPERM;=0A=
> +=0A=
> +     uniname =3D kmalloc(sizeof(struct exfat_uni_name), GFP_KERNEL);=0A=
> +     if (!uniname)=0A=
> +             return -ENOMEM;=0A=
> +=0A=
> +     if (copy_from_user(utf8, (char __user *)arg, FSLABEL_MAX)) {=0A=
> +             ret =3D -EFAULT;=0A=
> +             goto cleanup;=0A=
> +     }=0A=
> +=0A=
> +     if (utf8[0]) {=0A=
> +             ret =3D exfat_nls_to_utf16(sb, utf8, strnlen(utf8,=0A=
> FSLABEL_MAX),=0A=
> +                                      uniname, &lossy);=0A=
> +             if (ret < 0)=0A=
> +                     goto cleanup;=0A=
> +             else if (lossy & NLS_NAME_LOSSY) {=0A=
> +                     ret =3D -EINVAL;=0A=
> +                     goto cleanup;=0A=
> +             }=0A=
> +     } else {=0A=
> +             uniname->name[0] =3D 0x0000;=0A=
> +             uniname->name_len =3D 0;=0A=
> +     }=0A=
> +=0A=
> +     if (uniname->name_len > EXFAT_VOLUME_LABEL_LEN) {=0A=
> +             exfat_info(sb, "Volume label length too long, truncating");=
=0A=
> +             uniname->name_len =3D EXFAT_VOLUME_LABEL_LEN;=0A=
> +     }=0A=
> +=0A=
> +     ret =3D exfat_write_volume_label(sb, uniname, root_inode);=0A=
> +=0A=
> +cleanup:=0A=
> +     kfree(uniname);=0A=
> +     return ret;=0A=
> +}=0A=
> +=0A=
>  long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)=
=0A=
>  {=0A=
>       struct inode *inode =3D file_inode(filp);=0A=
>       u32 __user *user_attr =3D (u32 __user *)arg;=0A=
> +     struct inode *root_inode =3D filp->f_path.mnt->mnt_root->d_inode;=
=0A=
>=0A=
>       switch (cmd) {=0A=
>       case FAT_IOCTL_GET_ATTRIBUTES:=0A=
> @@ -500,6 +584,10 @@ long exfat_ioctl(struct file *filp, unsigned int cmd=
,=0A=
> unsigned long arg)=0A=
>               return exfat_ioctl_shutdown(inode->i_sb, arg);=0A=
>       case FITRIM:=0A=
>               return exfat_ioctl_fitrim(inode, arg);=0A=
> +     case FS_IOC_GETFSLABEL:=0A=
> +             return exfat_ioctl_get_volume_label(inode->i_sb, arg);=0A=
> +     case FS_IOC_SETFSLABEL:=0A=
> +             return exfat_ioctl_set_volume_label(inode->i_sb, arg,=0A=
> root_inode);=0A=
>       default:=0A=
>               return -ENOTTY;=0A=
>       }=0A=
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c=0A=
> index 8926e63f5bb7..7931cdb4a1d1 100644=0A=
> --- a/fs/exfat/super.c=0A=
> +++ b/fs/exfat/super.c=0A=
> @@ -18,6 +18,7 @@=0A=
>  #include <linux/nls.h>=0A=
>  #include <linux/buffer_head.h>=0A=
>  #include <linux/magic.h>=0A=
> +#include "../nls/nls_ucs2_utils.h"=0A=
>=0A=
>  #include "exfat_raw.h"=0A=
>  #include "exfat_fs.h"=0A=
> @@ -573,6 +574,228 @@ static int exfat_verify_boot_region(struct=0A=
> super_block *sb)=0A=
>       return 0;=0A=
>  }=0A=
>=0A=
> +static int exfat_get_volume_label_ptrs(struct super_block *sb,=0A=
> +                                    struct buffer_head **out_bh,=0A=
> +                                    struct exfat_dentry **out_dentry,=0A=
> +                                    struct inode *root_inode)=0A=
> +{=0A=
> +     int i, ret;=0A=
> +     unsigned int type, old_clu;=0A=
> +     struct exfat_sb_info *sbi =3D EXFAT_SB(sb);=0A=
> +     struct exfat_chain clu;=0A=
> +     struct exfat_dentry *ep, *deleted_ep =3D NULL;=0A=
> +     struct buffer_head *bh, *deleted_bh;=0A=
> +=0A=
> +     clu.dir =3D sbi->root_dir;=0A=
> +     clu.flags =3D ALLOC_FAT_CHAIN;=0A=
> +=0A=
> +     while (clu.dir !=3D EXFAT_EOF_CLUSTER) {=0A=
> +             for (i =3D 0; i < sbi->dentries_per_clu; i++) {=0A=
> +                     ep =3D exfat_get_dentry(sb, &clu, i, &bh);=0A=
> +=0A=
> +                     if (!ep) {=0A=
> +                             ret =3D -EIO;=0A=
> +                             goto end;=0A=
> +                     }=0A=
> +=0A=
> +                     type =3D exfat_get_entry_type(ep);=0A=
> +                     if (type =3D=3D TYPE_DELETED && !deleted_ep && root=
_inode)=0A=
> {=0A=
> +                             deleted_ep =3D ep;=0A=
> +                             deleted_bh =3D bh;=0A=
> +                             continue;=0A=
> +                     }=0A=
> +=0A=
> +                     if (type =3D=3D TYPE_UNUSED) {=0A=
> +                             if (!root_inode) {=0A=
> +                                     brelse(bh);=0A=
> +                                     ret =3D -ENOENT;=0A=
> +                                     goto end;=0A=
> +                             }=0A=
> +=0A=
> +                             if (deleted_ep) {=0A=
> +                                     brelse(bh);=0A=
> +                                     goto end;=0A=
> +                             }=0A=
> +=0A=
> +                             if (i < sbi->dentries_per_clu - 1) {=0A=
> +                                     deleted_ep =3D ep;=0A=
> +                                     deleted_bh =3D bh;=0A=
> +=0A=
> +                                     ep =3D exfat_get_dentry(sb, &clu,=
=0A=
> +                                                           i + 1, &bh);=
=0A=
> +                                     memset(ep, 0,=0A=
> +                                            sizeof(struct exfat_dentry))=
;=0A=
> +                                     ep->type =3D EXFAT_UNUSED;=0A=
> +                                     exfat_update_bh(bh, true);=0A=
> +                                     brelse(bh);=0A=
> +=0A=
> +                                     goto end;=0A=
> +                             }=0A=
> +=0A=
> +                             // Last dentry in cluster=0A=
=0A=
Please use /* */ to comment.=0A=
=0A=
> +                             clu.size =3D 0;=0A=
> +                             old_clu =3D clu.dir;=0A=
> +                             ret =3D exfat_alloc_cluster(root_inode, 1,=
=0A=
> +                                                       &clu, true);=0A=
> +                             if (ret < 0) {=0A=
> +                                     brelse(bh);=0A=
> +                                     goto end;=0A=
> +                             }=0A=
=0A=
In exFAT, directory size is limited to 256MB. Please add a check to return =
-ENOSPC=0A=
instead of allocating a new cluster if the root directory size had reached =
this limit. =0A=
=0A=
> +=0A=
> +                             ret =3D exfat_ent_set(sb, old_clu, clu.dir)=
;=0A=
> +                             if (ret < 0) {=0A=
> +                                     exfat_free_cluster(root_inode, &clu=
);=0A=
> +                                     brelse(bh);=0A=
> +                                     goto end;=0A=
> +                             }=0A=
> +=0A=
> +                             ret =3D exfat_zeroed_cluster(root_inode, cl=
u.dir);=0A=
> +                             if (ret < 0) {=0A=
> +                                     exfat_free_cluster(root_inode, &clu=
);=0A=
> +                                     brelse(bh);=0A=
> +                                     goto end;=0A=
> +                             }=0A=
=0A=
After allocating a new cluster for the root directory, its size needs to be=
 updated.=0A=
=0A=
> +=0A=
> +                             deleted_ep =3D ep;=0A=
> +                             deleted_bh =3D bh;=0A=
> +                             goto end;=0A=
> +                     }=0A=
> +=0A=
> +                     if (type =3D=3D TYPE_VOLUME) {=0A=
> +                             *out_bh =3D bh;=0A=
> +                             *out_dentry =3D ep;=0A=
> +=0A=
> +                             if (deleted_ep)=0A=
> +                                     brelse(deleted_bh);=0A=
> +=0A=
> +                             return 0;=0A=
> +                     }=0A=
> +=0A=
> +                     brelse(bh);=0A=
> +             }=0A=
> +=0A=
> +             if (exfat_get_next_cluster(sb, &(clu.dir))) {=0A=
> +                     ret =3D -EIO;=0A=
> +                     goto end;=0A=
> +             }=0A=
> +     }=0A=
> +=0A=
> +     ret =3D -EIO;=0A=
> +=0A=
> +end:=0A=
> +     if (deleted_ep) {=0A=
> +             *out_bh =3D deleted_bh;=0A=
> +             *out_dentry =3D deleted_ep;=0A=
> +             memset((*out_dentry), 0, sizeof(struct exfat_dentry));=0A=
> +             (*out_dentry)->type =3D EXFAT_VOLUME;=0A=
> +             return 0;=0A=
> +     }=0A=
> +=0A=
> +     *out_bh =3D NULL;=0A=
> +     *out_dentry =3D NULL;=0A=
> +     return ret;=0A=
> +}=0A=
> +=0A=
> +static int exfat_alloc_volume_label(struct super_block *sb)=0A=
> +{=0A=
> +     struct exfat_sb_info *sbi =3D EXFAT_SB(sb);=0A=
> +=0A=
> +     if (sbi->volume_label)=0A=
> +             return 0;=0A=
> +=0A=
> +=0A=
> +     mutex_lock(&sbi->s_lock);=0A=
> +     sbi->volume_label =3D kcalloc(EXFAT_VOLUME_LABEL_LEN,=0A=
> +                                                  sizeof(short), GFP_KER=
NEL);=0A=
> +     mutex_unlock(&sbi->s_lock);=0A=
> +=0A=
> +     if (!sbi->volume_label)=0A=
> +             return -ENOMEM;=0A=
> +=0A=
> +     return 0;=0A=
> +}=0A=
> +=0A=
> +int exfat_read_volume_label(struct super_block *sb)=0A=
> +{=0A=
> +     int ret, i;=0A=
> +     struct exfat_sb_info *sbi =3D EXFAT_SB(sb);=0A=
> +     struct buffer_head *bh =3D NULL;=0A=
> +     struct exfat_dentry *ep =3D NULL;=0A=
> +=0A=
> +     ret =3D exfat_get_volume_label_ptrs(sb, &bh, &ep, NULL);=0A=
> +     // ENOENT signifies that a volume label dentry doesn't exist=0A=
> +     // We will treat this as an empty volume label and not fail.=0A=
> +     if (ret < 0 && ret !=3D -ENOENT)=0A=
> +             goto cleanup;=0A=
> +=0A=
> +     ret =3D exfat_alloc_volume_label(sb);=0A=
> +     if (ret < 0)=0A=
> +             goto cleanup;=0A=
> +=0A=
> +     mutex_lock(&sbi->s_lock);=0A=
> +     if (!ep)=0A=
> +             memset(sbi->volume_label, 0, EXFAT_VOLUME_LABEL_LEN);=0A=
> +     else=0A=
> +             for (i =3D 0; i < EXFAT_VOLUME_LABEL_LEN; i++)=0A=
> +                     sbi->volume_label[i] =3D le16_to_cpu(ep-=0A=
> >dentry.volume_label.volume_label[i]);=0A=
> +     mutex_unlock(&sbi->s_lock);=0A=
> +=0A=
> +     ret =3D 0;=0A=
> +=0A=
> +cleanup:=0A=
> +     if (bh)=0A=
> +             brelse(bh);=0A=
> +=0A=
> +     return ret;=0A=
> +}=0A=
> +=0A=
> +int exfat_write_volume_label(struct super_block *sb,=0A=
> +                          struct exfat_uni_name *uniname,=0A=
> +                          struct inode *root_inode)=0A=
> +{=0A=
> +     int ret, i;=0A=
> +     struct exfat_sb_info *sbi =3D EXFAT_SB(sb);=0A=
> +     struct buffer_head *bh =3D NULL;=0A=
> +     struct exfat_dentry *ep =3D NULL;=0A=
> +=0A=
> +     if (uniname->name_len > EXFAT_VOLUME_LABEL_LEN) {=0A=
> +             ret =3D -EINVAL;=0A=
> +             goto cleanup;=0A=
> +     }=0A=
> +=0A=
> +     ret =3D exfat_get_volume_label_ptrs(sb, &bh, &ep, root_inode);=0A=
> +     if (ret < 0)=0A=
> +             goto cleanup;=0A=
> +=0A=
> +     ret =3D exfat_alloc_volume_label(sb);=0A=
> +     if (ret < 0)=0A=
> +             goto cleanup;=0A=
> +=0A=
> +     memcpy(sbi->volume_label, uniname->name,=0A=
> +            uniname->name_len * sizeof(short));=0A=
> +=0A=
> +     mutex_lock(&sbi->s_lock);=0A=
> +     for (i =3D 0; i < uniname->name_len; i++)=0A=
> +             ep->dentry.volume_label.volume_label[i] =3D=0A=
> +                     cpu_to_le16(sbi->volume_label[i]);=0A=
> +     // Fill the rest of the str with 0x0000=0A=
> +     for (; i < EXFAT_VOLUME_LABEL_LEN; i++)=0A=
> +             ep->dentry.volume_label.volume_label[i] =3D 0x0000;=0A=
> +=0A=
> +     ep->dentry.volume_label.char_count =3D uniname->name_len;=0A=
> +     mutex_unlock(&sbi->s_lock);=0A=
> +=0A=
> +     ret =3D 0;=0A=
> +=0A=
> +cleanup:=0A=
> +     if (bh) {=0A=
> +             exfat_update_bh(bh, true);=0A=
> +             brelse(bh);=0A=
> +     }=0A=
> +=0A=
> +     return ret;=0A=
> +}=0A=
> +=0A=
>  /* mount the file system volume */=0A=
>  static int __exfat_fill_super(struct super_block *sb,=0A=
>               struct exfat_chain *root_clu)=0A=
> @@ -791,6 +1014,7 @@ static void delayed_free(struct rcu_head *p)=0A=
>=0A=
>       unload_nls(sbi->nls_io);=0A=
>       exfat_free_upcase_table(sbi);=0A=
> +     kfree(sbi->volume_label);=0A=
>       exfat_free_sbi(sbi);=0A=
>  }=0A=
>=0A=
> --=0A=
> 2.34.1=0A=

