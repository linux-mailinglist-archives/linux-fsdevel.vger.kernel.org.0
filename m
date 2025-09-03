Return-Path: <linux-fsdevel+bounces-60038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAD1B41275
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9B554402C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 02:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703991E5B72;
	Wed,  3 Sep 2025 02:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="EDlMKWe0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D093288D6;
	Wed,  3 Sep 2025 02:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756867361; cv=fail; b=ZLRcsp0nK4Qv87UgVtDPygQ7+MqhwbqouK9f5nL0Oo/LXeu7FflzifP4OpEhBR8wVZ2h5rp3dPmv+cly1LNjwlru9t/RqRu9KLohgWDQymU1Qe/4U3N12vj9tzKQVe14zRfI/sRhq9zylTseXEslXfYwH0n6Y17V/bntGr3UV6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756867361; c=relaxed/simple;
	bh=bWW6Wnr1nuPP2lj5cVOPseedjeuMbc1igMRsL/eBYFY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BqRV3n6EZ9oftPuvHsYOolJE+GF7HAR9IJenMRYuEKphAx3HnKCDubuynTshwNfzFnJz6YoH4KMfO+IVe/CBsnzx1GMYVrlLIZmzbbmdvoyHHQpCGGK1TWBaOofOxtgQZcM+fOJ/6A1vpaZz30N9hWGkPbqDKAcQM8Cz54bWcK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=EDlMKWe0; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582NMvnJ026606;
	Wed, 3 Sep 2025 01:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=rYE43bx
	xDEbva4YruP8nkgluKmWkcjSV5NCNwHsFTDw=; b=EDlMKWe0u6Bhr2uZB674x/O
	Ln3z0Qt8T4G6I0joL3ywxU9ZX6hI7JT3zFMIx8u4+oDX7pZ8isgLqrtSMCOUwWeI
	bxy36XHZglMd1f6+yMthssXAhoNLX12rdwpZWwThjdDy1u9Hfu8S+QlMRcWoNu9C
	S8n7rHYOWEl9ODeCELtqS6eSqcVx2qSDtJAtX/+9F4OaQAiUAQ9PcQ8w/HJRw+nu
	RHKyi7wfzinbGPiZg/JnH0U71zecso1JIMu8nDib2jKXedBkjc3NBU1dOIESeTsT
	GkH0oNaebDx25tTKISsGMkcUrUcZi7BKFzVPSBPF242hrIF1nM9uPqeA6S4IeBQ=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012048.outbound.protection.outlook.com [40.107.75.48])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 48usfdbbv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 01:59:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3Pka+XcSMWTFaX+Nh0zw55X5F198mOIrAm4FS0qa3HBIkrxJfDLj117BxJ/niOtuMchDFveYz+NeUXsOWGfPtObxgdlj/4W5UQzXdKa4mIiaBFW6/fjwGeulaNC1osAYVGyokx0oPtUTAXy/DVpBoTN4VdWEZHyA5E6QW9VPasH60ZM1YVZDSimEWONK+83RxS7AWdWluefH+PthfVKRDAWpLNx40tSgI0VkwdjIT449Obu8zm0O6wz74hO8VvmTF6bNeAXk+52YH8D8ZL5ZeLC4Fd9xcP/gDCqaUEPb+sg5U00D7eXzw556r+D+zzSR3X3RGH6PX8fYN5gRpTsEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYE43bxxDEbva4YruP8nkgluKmWkcjSV5NCNwHsFTDw=;
 b=NnOiiWdQk5c6AjHfUHKrfOYybfxUBi+cZKig0k1d59KWzPfdewB0AvOuXzODBJaiJZ9CcKeDoppDnHqL9RS+NKQ2nyz2IH5jT9yfwjnQUwRrI7yK1v0rQjRmWbqSMbHfmKKxQceIfGb+6+puali6kmc2fWRnrbu1erizNNpT9k0VhEj/m8h4Gqzy0xldXecXI3hyYH90STDkVa25ig8nfPxcHFuVu2i1lWqy/1fTZkTDrByTDwIXamqa3tHPKQTlxLQb3QuUtubtUY9H5iToIW0wezUIaBXdzie9JrYqZ/s6M4ejR9iEwpn6+RjT6KovHo6PQxT0uUlNAD9GCqvHkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB7790.apcprd04.prod.outlook.com (2603:1096:820:131::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 3 Sep
 2025 01:59:07 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 01:59:06 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Ethan Ferguson <ethan.ferguson@zetier.com>
CC: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
Subject: Re: [PATCH v4 0/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Thread-Topic: [PATCH v4 0/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Thread-Index: AQHcHEeEN+x4VRKl9Em7Nxb4LLREyrSAoceX
Date: Wed, 3 Sep 2025 01:59:06 +0000
Message-ID:
 <PUZPR04MB631625FD025D0762D36578118101A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References:
 <PUZPR04MB63160C89856D1164322B643E8106A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <20250902202306.86404-1-ethan.ferguson@zetier.com>
In-Reply-To: <20250902202306.86404-1-ethan.ferguson@zetier.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB7790:EE_
x-ms-office365-filtering-correlation-id: 33aa361f-fc19-4bba-a793-08ddea8d76d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ewvdD8vc09RjVoeZgOLiq3q9aY1ipnyVGl5CtCrA97xrStFmHpJHG0fSny?=
 =?iso-8859-1?Q?gGTV6nExef+bZpxB/zpvhrhhFFc/gyE9Lg6wcNmfwnwdA+EBvkl5vaQcUW?=
 =?iso-8859-1?Q?pPFLuP0MGvG5AZCciYQLCQ9licZ06lHge79AJlLmVcfJx1pWNlZxQCO11m?=
 =?iso-8859-1?Q?l41HNMVdYQk+lOuFf80Gq2lKCDRQILIf8Z2GAXBEhXIXrYT0PunleWJe7T?=
 =?iso-8859-1?Q?+szqLfDstTjIC3De0DhVbjCDjr/qD8BNDWnpnB7pSejbfjGqJ5bFI4SzDT?=
 =?iso-8859-1?Q?lqJwsRTzvb1JQwYf1RyqTJOMVhehPhvylkJ0611Ug43D+qJy//DO45LYvC?=
 =?iso-8859-1?Q?bXwZKAQOvcMcY4WHQfWrGRKoHopOJgUQxlPvym/fDPb4GBMRMRlWVxm6ZO?=
 =?iso-8859-1?Q?POkb0uRVtQIt+ke9bWgvMlNRQnV0D/Qczz/5e8KRPqjx/HA/w656PQdzvG?=
 =?iso-8859-1?Q?P1LnzN9hOoOmu7WjMpticSSdOaKyeEAbCpe19QZe+Eva7mXJ33xzNisEun?=
 =?iso-8859-1?Q?ujLecrDVCADaIF+XdnYoa622RHyUO4SO2XTQKgV1+AqFXHD/n2gb7qq3jU?=
 =?iso-8859-1?Q?u3gJURfflT5sj5nXIoo+LJw/xh66lkpIT4xH2AUD1lGU/OIJudlj5pAiYZ?=
 =?iso-8859-1?Q?0nxygnnbBqAK/BEOzSX0f20zZJl475dhatTEXXRzovGxW9yDSN34NMo/c4?=
 =?iso-8859-1?Q?BoHfgf8a8oFTHZ6j/6avB6b5I0wMvegalVErgbn+Kj/lCbsctMcQ1L9U5j?=
 =?iso-8859-1?Q?zO/JosMhWYDPqaMhOKfWOoodbOTIlix13+/N1loCfBspwU9duLkhdP9Z7r?=
 =?iso-8859-1?Q?iD8lYj83CTMnunR9XyT1MuZDmPh8avazC9biew3xycwyQ6SXzP+XDtOTx5?=
 =?iso-8859-1?Q?Mdz+j3wyhi0kbA9KzyLMwru1kP4bfvZBOfiveP+jUAvEsPUH0rP2vUv7SF?=
 =?iso-8859-1?Q?rSx6emrsN/q5n2YQkmFjz6UxK5O/3+I/0kl0Qkqq40Yez47ZCH2nLMKaDs?=
 =?iso-8859-1?Q?Ifo8xcYfIa2zvSL/Gezkq7v/R+vJLt95jcSnwaXqhIes+t6dzEw1Kctvn3?=
 =?iso-8859-1?Q?dR76r4P1b/kIEeJNWrBJV2lPeOdPeVwXx9eyK5pyOP3c+ibXXZBzU9VRvC?=
 =?iso-8859-1?Q?DKA6ce1AZ6xNSA7VMlS0kEb+PbCIX/77Iv2ZM4FkFPOy6aD9reMEDi7U/4?=
 =?iso-8859-1?Q?rR8p0WUyTbzqBwhh3s0g1ABnwnz8V6wxgO3oVQNldWOvGsocKTBCoZ/g5i?=
 =?iso-8859-1?Q?pzSvWrV9ocPu3mi3Pp/hK7YOtXq5HUXBrCHYHpYm6s2bl1OYRaeapD28xG?=
 =?iso-8859-1?Q?zMHDhZLppFc+tKK4cXjS83VbwdWGCHSZRVzFQRd15+VfO4pmVTQWgAZy8g?=
 =?iso-8859-1?Q?XChEDCmydvLlWdaWj/WWPqtOf8Surj4+qVHXv9FHxXWHGN4GQOX48EtuCx?=
 =?iso-8859-1?Q?p1cvGKS0d33hc7Kbm+H8Y8jONLR+i7cnl+fyUkKSi5nu0ZVlFfG/QWqHu2?=
 =?iso-8859-1?Q?5D/ozC9RAKPjvA1ntP0rlcvTrq63vwnBrugg6zIm51xA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?omb2zN33KFIe5jpLoMrfbf4tEW7EHoaRgNBht8lOlunr3Hvd1edzoubW/v?=
 =?iso-8859-1?Q?0Z0Y7aLzo8NRkL/cTRGlUHqj24iOcROmLXtMaPVU56KzDCql7ozy4GpOXj?=
 =?iso-8859-1?Q?JGddMW4bizpWlZ+5L5Og1qAbk8GWuMxpOVer/OOVUb5bpTGaJmx4ZBawCu?=
 =?iso-8859-1?Q?HF2ppZK/Mznzo6l7e7mbR+Et7hHRLpSnaOo//WC0fjoOB40gSkOI1q0d+8?=
 =?iso-8859-1?Q?fBHVlUU+RKx53ygHsmJkEGWA0FEgFXL47O9xMFXcwm9P1tgpAoXMYuKy4M?=
 =?iso-8859-1?Q?6DkviDdik0JKihEa14XN8L+JYtfeHAANEnTtMCc6PBrrAipNRVVRnqTbDR?=
 =?iso-8859-1?Q?rRyz5QCChnmry+JIWkZ0qP6BbzTbdqhqa6xzvJzF+1LO2WNz2dZre2Gwrj?=
 =?iso-8859-1?Q?1BlasNl69Rl3B9A9evu83HjyKpvyabnk62RHEyychp3MaDTFuDVYK9VviF?=
 =?iso-8859-1?Q?aiLIjcAwLfYmp0hFdyH4PbmUZE549hb19BtOMOMrH1kH+sx6VPyJ/gt/7g?=
 =?iso-8859-1?Q?dCpw/FDbkv26jOi0nTnwmeO2nG4RzlydRJa0Y7nHRnhvtGpIUKWu+3x3ic?=
 =?iso-8859-1?Q?XsXaHc8eVUDAORL5TLqJzHS6QssR1yBOWidSeIknevsQKdQmJsgL5dPIMi?=
 =?iso-8859-1?Q?LMliUp0EgkH+U0iAZoU+Gs2hjN5ifTkLAweeKfl9pMAbeBvOOhptARDD1E?=
 =?iso-8859-1?Q?k25HYgatK2dBuwvy+m0ypxz9zuG21G+RqdJE/6of8ZnPfpJQ9ax/EcjTDo?=
 =?iso-8859-1?Q?HcjxbRR+SSLR7jhwTZSIRBR2rf0vTwA++CsnayYq2UA+KMP2whBtd9tM7N?=
 =?iso-8859-1?Q?xmSiMdaKGqp9onopScihf7Cemg0p8UGJ+Jrn+p6HzuL16oCSqt+d48cxMw?=
 =?iso-8859-1?Q?DLALODS4hysMiZTIY09aWwtjrEJSl8iJqO5LVqr1bKHbv1r6ImR1841VcX?=
 =?iso-8859-1?Q?DKCdUu5vuoZoZYd7r3SsSe8bFqJbRdmPL7KD7OrBCNN0+UlfysM+zguZS1?=
 =?iso-8859-1?Q?TT+N2F2YjMjQyBbyGZ0HMa14ToIIVPEONcXhhE+zhvCuE2I3rrJWR+C44t?=
 =?iso-8859-1?Q?FYpeUVkx3tY+459+ShHkG2UTAFj+iascUsPR3oNGknn9V3nfaWwEKLZWKF?=
 =?iso-8859-1?Q?a/oJYwZiezzhOQAsKzYZ5XrME+ZuPNLijJXWCLP1s1bhDE+kwfaPGMeNm5?=
 =?iso-8859-1?Q?PT9uIHcJV77XM9QiEh+LLRFcH9xP1qydcSVSnZvSBCW1VLujbJiCX7c9sJ?=
 =?iso-8859-1?Q?wLaoGSADpe1aMzLe8pbJo5cWi7yqPU5T6ZtQh4SX9jyTpO5FW7X75p0SyM?=
 =?iso-8859-1?Q?BUjhDS3qYTh/9kWIESsbTGSyIv+sOR4NWOAD4z2JXBki+ndS0uNM3eXhN/?=
 =?iso-8859-1?Q?y/oznHzOXelSs7i1/99/wceMghoWAXNRY5weXNf7UlHXkerC7MIi7rYOd6?=
 =?iso-8859-1?Q?TsD9jvT3AS+r1I8Dy3ZhPEREmWRsvcBwora5NIwJpOnx4G0wcXVY4030O4?=
 =?iso-8859-1?Q?SVa4neDLZmzUSsoyE+h5doRaPxvbUxoSB5PFscUM9g4T1cUq9c6kclFQFQ?=
 =?iso-8859-1?Q?2fxhQ+uYxN5I1OZqwYbCXGFWZm4ftp175Z9xWTbtxiZaPjEGTcKDonQ8e8?=
 =?iso-8859-1?Q?o7gxv2in4ODw4TXXIvnvjOaTuekIGrmyCzlgvhsgLm56dHNd1qNOjSD+UH?=
 =?iso-8859-1?Q?xTAGsd6mUZPVks/GnZY=3D?=
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
	vCyi7H4b0xpajk+mRS5AGTCO1hJFV6foEwT5wgi2zeS6ORGYp+eQdhCmj6Ud8skKQs5yHO69mJoLIi1tWUsE8E5noRUMQv82U0AryCfdC7I6pYJnyvb/gwHqSOEaY7Lk6xLw/8ZsWY9ckQaGNqjh4auVfBFXKUk8UDJ+29HwLZ6M8MCorH6ToY2ecUX7QT/3A/Nx83icnlIg9Fp2vGpXUdq/M++RW1xy71+oL8IIWIB4OV7ykQNHZcC2QMrObsTkuJbecKP1HExsbBzscPaQryUHXGlEoOp1BVBPV9s697KveqnKUG2078oqp4dd/JRMDRJxxB2RXICpkuXupVyqymRLtFUqJqcEOFb5Gp3VxeGQmV0zn5f4OI3vRp2v/k1omQjSrqDEfTXQlgV6+assT7cBX95CHNDdLj3q6hRySdHFgNIdSBSEehpKJye3BajOc3y1XJIcgulEA84g7Yx3MAbVwf0g9ycag3pO6pN4lQEqTyU5HQPLfOW8bvWbtyPmjnACM6joxm6yrKDJrv8umshZhi5ffYf1lGb6sBABug6/nVw9byc5g5EBkEMTtlrPpzxB/YQQxvE3M281WfExwURIIPryMy8ci0FVGyHJV/z5GUqrt7ybGvpo/ue5zINs
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33aa361f-fc19-4bba-a793-08ddea8d76d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 01:59:06.1565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /R7Iic509q0GfMHoba1mtj0P2TNhyeMqE3bZAs7wH1Y4/neSKpCSdKmIh2xUSb0W4vt0oqXOn5Rse4rLs2pfgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7790
X-Proofpoint-ORIG-GUID: eCyCX_6SFYFA2md34KlPl_l0ZistEoY5
X-Authority-Analysis: v=2.4 cv=cpibk04i c=1 sm=1 tr=0 ts=68b7a0f4 cx=c_pps a=vOzGGWgb+jyie9Iy9Qmx6Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=VffZNPLIJi6fMKskMXEA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: eCyCX_6SFYFA2md34KlPl_l0ZistEoY5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXzFiwDxAgr+KG 00kfw3/3pDWaOSIdIzM9TOzjK+8B4n2Qn54ppk9PF7XaGacf5N//2s37Hpv3Myust6DcZexYuKY 2jbXg6Jjeg1xXDhpKIxAL7cODWUOcFxtYRfLmsqeZtY2mICsEdQlJrRe3JnXzfC0+9Fn3Ktfg5l
 h4blOK4qq9uTDGSuDCgXVw7eGU6kGaAiR+4p2ARHynTntX8kFLcFgdIy9e9tTntkDFSTY6TrZ/l g0Y6O02/CXXeh/WWGYQaV2/epteNPiZDJvhBqD/7KZL7rLRhcTHxpQf/ToSq7zQDBxOhPTvx5qE Meq7lF1BfA/GcSKAV8QdKRW5AaAkHajsjGCgpzU6Fk7Al5329p7bNeVK/H+A63u6ungomIElz1O 1bdZ8Z1m
X-Sony-Outbound-GUID: eCyCX_6SFYFA2md34KlPl_l0ZistEoY5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_09,2025-08-28_01,2025-03-28_01

> >> +                             clu.size =3D 0;=0A=
> >> +                             old_clu =3D clu.dir;=0A=
> >> +                             ret =3D exfat_alloc_cluster(root_inode, =
1,=0A=
> >> +                                                       &clu, true);=
=0A=
> >> +                             if (ret < 0) {=0A=
> >> +                                     brelse(bh);=0A=
> >> +                                     goto end;=0A=
> >> +                             }=0A=
> > =0A=
> > In exFAT, directory size is limited to 256MB. Please add a check to ret=
urn -ENOSPC=0A=
> > instead of allocating a new cluster if the root directory size had reac=
hed this limit. =0A=
> >=0A=
> Noted. I am switching over to using exfat_find_empty_entry, which=0A=
> checks for this.=0A=
=0A=
I think it is good way to use exfat_find_empty_entry.=0A=
In exfat_get_volume_label_ptrs, if an empty dentry is found, ei->hint_femp =
should be=0A=
set to avoid repeated traversal.=0A=
=0A=
> >> +=0A=
> >> +                             ret =3D exfat_ent_set(sb, old_clu, clu.d=
ir);=0A=
> >> +                             if (ret < 0) {=0A=
> >> +                                     exfat_free_cluster(root_inode, &=
clu);=0A=
> >> +                                     brelse(bh);=0A=
> >> +                                     goto end;=0A=
> >> +                             }=0A=
> >> +=0A=
> >> +                             ret =3D exfat_zeroed_cluster(root_inode,=
 clu.dir);=0A=
> >> +                             if (ret < 0) {=0A=
> >> +                                     exfat_free_cluster(root_inode, &=
clu);=0A=
> >> +                                     brelse(bh);=0A=
> >> +                                     goto end;=0A=
> >> +                             }=0A=
> >=0A=
> > After allocating a new cluster for the root directory, its size needs t=
o be updated.=0A=
> >=0A=
> Where would I update the size? I don't think the root directory has a=0A=
> Stream Extension dentry, would I increment the exfat_inode_info.dir.size=
=0A=
> field?=0A=
=0A=
The root directory does not have a Stream Extension dentry.  We just need t=
o update=0A=
the new size to root_inode->i_size. If exfat_find_empty_entry is used, root=
_inode->i_size=0A=
will be updated by it.=0A=

