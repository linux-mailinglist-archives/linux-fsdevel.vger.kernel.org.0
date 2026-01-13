Return-Path: <linux-fsdevel+bounces-73373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A0ED16DC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 07:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C1C3301A482
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 06:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D420735971B;
	Tue, 13 Jan 2026 06:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="H8BsjZFT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0885A255F2C;
	Tue, 13 Jan 2026 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768286303; cv=fail; b=ARyYS/3OeQGVBp+pLrHdrXwKlGwyXBPP3aWV98Bx/RWs4tZVJBpeVnBUqrYD9DDReuefXjIRpS1FLIYM3Ex2BG+5eIvtNiKphPxtZDbMOD8heppz5rNkPkzWuB6a5ThAwK3ufaJlzrdmnSGwLPyOTRHyOJR+XeqIC0CAvGEzsq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768286303; c=relaxed/simple;
	bh=D/EeQRhVmQgbZbapnYWwagYF+0jRVXJwYFrDT63oL/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pokwaZe48Auy3pagNE9sCW+nbI39T0yCYP3l9K5GYF9RNTPQgRVSfqkHi6yWMjCKTeiu1OdGpKoqMMpOzG8OjJD18P5MSwFFRoFTzmrzXSKPkT0oBoEKS6/A8ZyVh2a0mGDpf3Y8IWz23FZJhwVEZ99ADCcutYGRmJB40D9y89Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=H8BsjZFT; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60D5JBcb002410;
	Tue, 13 Jan 2026 06:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=d+FBNQt
	bI3tl+NrA90ag5zzEgRclXgjfFlXko/SOskY=; b=H8BsjZFT5eDJE9vDPhawiBm
	3GA8+X/3B80OmjjXTreFx0J+nr0mb6shqXL8DS7xI40wPhAIyxn9JpV1/MMyAOjI
	8Dq9VXNmZyW1dR+FDX8dpb6XxtsfFLkyYIlgXPMLgfgoECZz9wVKqv/vvH0OIdXA
	XDgSOh3VIx17PZ4L1ZkJVl8FYFyYph+zq+yjBb/8JUxwHaorx5kIvE4joPBanUcb
	wKvQWeMbqPHPm54/bceSuFEfN7V8FS2gwOJfwJ4uskE2DjeXPI/U/eNXoLtomX4I
	R7M1RlWUo04lDSMsV8mGrWUqWe6wZ23bXKBkVjAiA7/UcRARWNqLnXY75dUFulQ=
	=
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013035.outbound.protection.outlook.com [40.107.44.35])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4bkteh2j42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:37:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bi27fqCiDs29BvkwpN9IDlRrZ8/J4YMKbPnqcyYSz29W4AMf5DTZGtQfmrH2kJ28SvegqEJSEoP4DSWX3dZ6aX/GdNHMXrgPKgHqwsUD/Vpp5oeohVDSmXZQ3K6dd00MuEkiKDkMPxcO4s2k3uIbQfiRslFUA1Undv0c2bGG5ej7hkZrj8oDz2T8nt2BOG8UlrUkD0ykaaCWam5aAH+VWjRStoDeh9l+fBSHwm7/4+yV+5j/SuIOC6hq2Uf728gboz7I91Cg8K93JvzoPnUovbejc/VWRMBt3GCe0OZXg/Ebx3475ykAwsCiiIjDEC+EcrTOUKX/w0MFe/huSOMwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+FBNQtbI3tl+NrA90ag5zzEgRclXgjfFlXko/SOskY=;
 b=EhdmNt4pP82jiM2+tsfYu2P2E3rUnB5aHIXs42KWwmwR9+pWH5r5vQllkUPlKp4LTNLxUAh53poFtRfcAIdt8lobi+CPVSWzXAer1ethLMPMg2VjsMMawnuUMWSuRmVkmc8aRL/nl9hCyybL8FbmRjRahmMUaUen5Z++G7OW9Zjvsfpf3jnk2OXmIg7TVq0juywBjmN0JG83wZe5sxQoRxHgKPGLTuMITq4Es/JNcwWCpI4+V1fcngXwTjk3mS73FWkpW2btH0DBsGKujXCNXIFCqJszUIwpzjkW+/lNIhpJT6i21RnyMJTHaq9ojDOVxLjTziUFwhj9jkK35vQ8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SE2PPF18D171749.apcprd04.prod.outlook.com (2603:1096:108:1::607) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 06:37:45 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 06:37:45 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Chi Zhiling <chizhiling@163.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo
	<sj1557.seo@samsung.com>,
        Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH v2 10/13] exfat: support multi-cluster for
 exfat_map_cluster
Thread-Topic: [PATCH v2 10/13] exfat: support multi-cluster for
 exfat_map_cluster
Thread-Index: AQHcgHN7X7Pv68Je5U6kxvoRzuBpFbVPqmVU
Date: Tue, 13 Jan 2026 06:37:44 +0000
Message-ID:
 <PUZPR04MB631615D6191EF6FB711E63C3818EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20260108074929.356683-1-chizhiling@163.com>
 <20260108074929.356683-11-chizhiling@163.com>
In-Reply-To: <20260108074929.356683-11-chizhiling@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SE2PPF18D171749:EE_
x-ms-office365-filtering-correlation-id: a466518d-51ab-4882-7233-08de526e4297
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?zmfW0uwte7p5ml1SyQGgOak/prhIdwmM0ondHNB0Pmv6TqD9K1XIz36pac?=
 =?iso-8859-1?Q?+x3MMCnEYHKLQbIM2uwCVf3LbJpsmEKHg9VVp9Ly5zKT2heEr7/k3QKEJj?=
 =?iso-8859-1?Q?f5Zs824xSUWgvgVolgg8vgXL85cqxYNxtzisZ8SfgpIlRl3RgmPuPQXmjE?=
 =?iso-8859-1?Q?oISPlQhLW+SFzisla3eQlLHjs+JJ11HGk3rigW6djTGx0BP4yIvMPI8g84?=
 =?iso-8859-1?Q?q6Z/8K8+1WXWVNU1MeVis5bkVKqgAXq/24n/pQp5SvWWbilIiPofPVoUdP?=
 =?iso-8859-1?Q?kBzS2o76RD57eJ2jEaBJB8YkkhWvTjp9crAZIf86WXv9VBrhjBI2TiCF2h?=
 =?iso-8859-1?Q?y3onMs/QaEBERj8M7/D+y6R3nNwz8bAu9xHCY8dQErzMqhKEIYYsXEML4D?=
 =?iso-8859-1?Q?qRyswZTlGoissa0UfnMlaTinAcUldHHe4L9+a/hwXnFpAs+UjupDptuqz1?=
 =?iso-8859-1?Q?fPAurttJYMtVSRdgyki/iAMMuSr5SOH1aO+V6dTdKPLrL4rFmXwn4A96ZV?=
 =?iso-8859-1?Q?0zIbM+8q0D5aewYZ8p7GZ5H/Or+xH1NK3FZnnw+aZLU5/2IibGA4NZA6GX?=
 =?iso-8859-1?Q?70SjTvGNex7RhGb94oZOWkOIVmaSMR0f/EyCuG94IE22Xi6iRUDucRyJBk?=
 =?iso-8859-1?Q?4402ZwiWLvbiwlWfDdLBcCJZ+HMqAoiXbPGNU3VcTtyMXif9CQdzsH477D?=
 =?iso-8859-1?Q?xwjXPqcvHGSmnzc3Er8JYv+uS0kk7MllyA4RSVwHqGuYQ3P9yUrnRqLAhl?=
 =?iso-8859-1?Q?Z8B5ZGTpmeu1aXecdAeSwSyuYFHjqlZv5yi3nxXyWAxvpjvZyjrqzep45V?=
 =?iso-8859-1?Q?TwDgWPKN+ZrUJETk4oQWq/H+wWEj6M7ll/ylp8cBMhi84teypd9Zn/kiS2?=
 =?iso-8859-1?Q?qA2Pgq33qwvwUQwUxkv9buHeiLZw5BXdGBlWmbacZrO3APqJBynAYNmkh1?=
 =?iso-8859-1?Q?49u0cNls4ibboOVX7mpKp5wAS0jbej0E2b94gmO/yypZ1KXev+57/pieqq?=
 =?iso-8859-1?Q?+PL4Jd4mOklGuG4YKJwMqiXua09a00skSq9xhW/cgo8VDqoUpE8r8gwWLe?=
 =?iso-8859-1?Q?Y11O9vEIy3hH7AQDCJvZFpKG+pTc7bnk2YdHc14Nn5lGdLyDwJ/RlbTGYE?=
 =?iso-8859-1?Q?wpjp6HfktwnQQYXAtQ1Ygcgfiae0kdCD6O51kJ6X3FOjE6/ifqOPBjAjfb?=
 =?iso-8859-1?Q?+ZeS2XGnSU/yc9HNsnWKImLHdWPeC6bO9VXE1d/EWCpAzLjjyA5FFqfffw?=
 =?iso-8859-1?Q?5gZdghiszonVmcVnDFRDqlLR/WgyF4HpjUi9HrL7fCD/zCwUgOcJYtufmR?=
 =?iso-8859-1?Q?5nQOcqFIHYGUe9I7/RQ0pGOkJM8l6KNsOa3m00NFEykpFFMwI3hR+GAa/M?=
 =?iso-8859-1?Q?TOAWNnyFZFV1MFAixp6VCrxBBDmw5WHDPsaM2KNdVkB92WJqWWczQukdb9?=
 =?iso-8859-1?Q?b534CwUvCrTyS57YkKMCx2l+7BhSO+/7qBszXnPNRFQ1OQITy8L4JI2E0G?=
 =?iso-8859-1?Q?ojYZEP8byW3AsiM9KmUSCapi/IoHYHCVhltdgmqu0O+n2/dCgH5+qbPoe4?=
 =?iso-8859-1?Q?Uei20bMDmqqtIkg14KBbSRAvVBMI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?OibQ5vYWN55HXkvyku5Ne4hUb6SM1soBMEm5J1uzYGiDoSHOwWwaT8DOY1?=
 =?iso-8859-1?Q?bx/6NxqHXbd3W5z8bHgkG6UXmrFNqUiFdnJof7nCUUxsbvuboPe6DSWvw9?=
 =?iso-8859-1?Q?WIlrH5upr1x5LkoGxq/wi9/bfsp2O1mFe3YXL9JGJWoYXNZ7YuzfdBraX8?=
 =?iso-8859-1?Q?f7v6Prcke7honJjysxrwr3iZHl5nVOtoaNjGZq0aiUUBnTbah08+RrRf5m?=
 =?iso-8859-1?Q?3UOzeJCpve56YKVWOWRKmRhiykh4wvDj2CzMwmwhZH2HU5Xo6wSEHCg02f?=
 =?iso-8859-1?Q?kYTYTU0QeFsxt3xo7owYPFnXw/3WTxh3spfHS/O06pSwy2kibD/5LHJM1D?=
 =?iso-8859-1?Q?0CYl+wpZiXSQXTllBfSijhrcckFuj3esHxz1SbBnez2P1h8QxbO+zJ0RTP?=
 =?iso-8859-1?Q?vbaaCSORSqiEFLAhH52szB0Fe5ilJQXRqPSjTc8YbhGwKXgAQ9c5J3BbjE?=
 =?iso-8859-1?Q?pFCYUPNJCc1YTma/w5M0tsD2N2MHYK71fwLxOdT67z2c4+WGB3nNBiMhtR?=
 =?iso-8859-1?Q?N6gnZKQd6rErujpS5Bbal9gHicvWYtghCTFV6hLbTQ4G4PdAtXTqydvej9?=
 =?iso-8859-1?Q?jjYho0VB1n5DNDZ6BtvabpwWy5gE6c+XSlqwG1OHMVuMtcf0vFBz4IfQlK?=
 =?iso-8859-1?Q?b/7hnarFn6QjrmnZjPdThsj+0AT9kXwgKb4+n/SpvKYVYn7J/x3sbmKSJV?=
 =?iso-8859-1?Q?3MRsJ3lVcGTbKhqvh4TCd1mpEp6fxijgVr5VV14s/zUaCCNt3pNcqM0pza?=
 =?iso-8859-1?Q?hk3E14ibkxhL4VTph751nrROXlkL6YfYEBLEsjBcMRaq5BXmk/SF1wX++D?=
 =?iso-8859-1?Q?yG06IqXAEznG0fGeu4/9uUWXGEoeSIIfp+Ch7ZD+4CJAzSYOKxPkg6qUfg?=
 =?iso-8859-1?Q?vdDFP3TtrKJYFLdw39CqexO1pqeT3ykgHBuxDqti1K3ecFPlLIVXlK+5gx?=
 =?iso-8859-1?Q?aECh1+yvmr6Ulp63t8xoiB9S/kQEbEz+IEV1cNFOt7i068QdUORgUgQCBU?=
 =?iso-8859-1?Q?x6pGdiU9mIhNHjQU9xhaSqrf0UvqzO1lOtdU98jSuPaQKXNMQRKuYOOB/e?=
 =?iso-8859-1?Q?7GDgC15h/c8pNd6rViSEkTquLbTOQHIuaP/NSA1ez/ql9/Lqxn4l869zu3?=
 =?iso-8859-1?Q?zTK5WkXr/GlNz13nS84rLmEbWUOzQW1XQOhNi2fMEtc4xEHliYejaGRzpd?=
 =?iso-8859-1?Q?QwySODzoKteo/n6RJW0WbmnutDVdY0nYCwhGpNtT9BTSKkp7DxpZ3jS6qv?=
 =?iso-8859-1?Q?oCOzKuNQQjBMNR1BPrhOkFAMLX77v0qSLGr61TL0lvH5eazGavDBvmu1FX?=
 =?iso-8859-1?Q?KkC82/x9DWBniJx9Z/yrl6W8/5o63Yd33TfImIO58Wn0hCMGhw7Kiac8Ym?=
 =?iso-8859-1?Q?Ttzpc6yZuF4GLr7Em9JftGqkyCA0Ftt2mjiC2I+hE5bqqoiKMuOcsrkybl?=
 =?iso-8859-1?Q?TKDbeQPP/3HkbcmqgTmFvwkUhoRpwgrFraYGW5gR+yOM2IUepyhwhhqEbn?=
 =?iso-8859-1?Q?DfhyiN+1bivDRIWa2gf1tA8Nmu+4y+e+/dEDOpEC+s5DJ0WLB6xFVJ8Hrs?=
 =?iso-8859-1?Q?MrtmYqiIb+nGuOlPxra8UTdZZ1ygX+6aH2SvtcVpiDD4p3wygLV7oo+h86?=
 =?iso-8859-1?Q?eVkL61S/3ugGuiRtDaIuyvYGDFWCmJDNsFnWLIzMJL6QQJBtrygdX+MZjM?=
 =?iso-8859-1?Q?52lsH97Z0fPFwl3PyfH476aGmy3zIDMhA/V8sY6Ne8weHokSDgPj6B76u6?=
 =?iso-8859-1?Q?C9Qq9dkneGI92WK4XKLobrkV+gUTIDCTwDrxXIGYyvku9hF9e4eZnt4nPV?=
 =?iso-8859-1?Q?8gWcgN0U+A=3D=3D?=
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
	F8iu1Ubna69N7T5gvKWW7QH3/XIpjKCUyJIA3r7FDgwZ0Pc3CfopJUTEDtkJMrjOdEmr0yO1WF/uk/tkQi5zWtWG+dOV6uXsrkKn/3Jm+nW5HNG4m/0nefZAfh6SJvkVBDqfrdEOpG1w7Cr2/DsWB3Sv0uk+wKsD1ssCPEcernA0ZFg6U+55cLZSI4xV5H+yTxA722WPEnlHX75lQclTipCehjPsSW3pJN4ocOfMzYVwhjrLKWOAWBw7n6dLF76BST0jwBq1FGuHFyKWKYkTleoOfYP+FQG3/WxbP8+sR05yLhMdBbWxFjKUAZs1/uGa+ZValj+N91EJpR648OjqLRB1JQNba4iHbpIqILfGJTCLRW1u33jsBtl0a+3YFi4i7MyGJq31Dbl6XVBiQ+Qs+rjXfdBMJjSRGN33qhbdr7agZ1Ks3m0TnM5x8g028kh7oaU1S9vl/Ao2a8Qh8af/J9Bq9Gy11GxXAXP1FbN+cF2wlbATtDG7dbixUvf0eZPslMm/5HJxzblhxKMulbU3zbII5sv4Z3YbfrugSii1cHwHipClpnV7UxlZd9rDw5xM1HHOGBi68ycHudVgqRWWR20pN5jbM0/DbYz6sotJ6PB1VVBCQ+Nya5p+wGQgxXSm
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a466518d-51ab-4882-7233-08de526e4297
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 06:37:45.0083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ZWVge5LOh+l3TwBJj9SFUFhZJ0sl9EZZu8Ovxw00GmySyucqT+/pSTF35BSurSjrqBVUheiqrqJmCsKNJJkjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF18D171749
X-Proofpoint-ORIG-GUID: zG7nQAUA1zW1sCY9G1Qz8BICXWRu6hwh
X-Proofpoint-GUID: zG7nQAUA1zW1sCY9G1Qz8BICXWRu6hwh
X-Authority-Analysis: v=2.4 cv=LNRrgZW9 c=1 sm=1 tr=0 ts=6965e83f cx=c_pps a=vta+3uztsr+Y9ot/tint+g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=vUbySO9Y5rIA:10 a=7j0FZ4iXMVMA:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=z6gsHLkEAAAA:8 a=azEX5703NOKUl-qZ2UIA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1MyBTYWx0ZWRfXyyTTLNqtIvqs d3vSZiRS17lOm1JgCpfQxU+Y+m4d7/VrLFkRdirU3nA1Qq/cjwzYXFc8H5fKE1Anlnmjfqmc+BS AiY/J4AXQerL+ps2g6IF69+CFqjUTuSgi4aOGUz2CbT8UHrarzhC2U+cY6j4ca0KP9bVW3bNfaS
 QJvGtQOU19YWXIcDaFSMZckbCnAZY0aqBLam9UAOoHPeWjiZvy2pzOOM0QXF6eW4/4w/hDAXT1a vw0UsOF6xLQwh7mcAFmfXgFyLE3hU28ye0a5/Ve+NhoVv4cCLCgpna9hXCL3An5YfJeMtdKdXBx 05NyvKl/jxNATo+pVSdQT/bTwl9NaqUEcTi4BkCKMRVMOSikZshYa+SqvEkfFR938mU73BsU5O0
 f7oo0yuY/Eq2WNTna8m4fGSSZWLgcTa8Yy/SubXrfHb7wVZAPJ6d3/5cq7bCuRVqWOUmUlBAbi3 jPdUs6LDOPS1tDWpe6w==
X-Sony-Outbound-GUID: zG7nQAUA1zW1sCY9G1Qz8BICXWRu6hwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01

> @@ -281,7 +285,7 @@ static int exfat_get_block(struct inode *inode, secto=
r_t iblock,=0A=
>        sec_offset =3D iblock & (sbi->sect_per_clus - 1);=0A=
>=0A=
>        phys =3D exfat_cluster_to_sector(sbi, cluster) + sec_offset;=0A=
> -       mapped_blocks =3D sbi->sect_per_clus - sec_offset;=0A=
> +       mapped_blocks =3D (count << sbi->sect_per_clus_bits) - sec_offset=
;=0A=
=0A=
This left shift will cause an overflow if the file is larger than 2TB =0A=
and the clusters are contiguous.=0A=
=0A=
The others look good.=0A=
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=

