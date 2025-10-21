Return-Path: <linux-fsdevel+bounces-64805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEADBF4578
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 04:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8386D18C5DC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 02:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86564260588;
	Tue, 21 Oct 2025 02:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="NqnhBi4o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B471F1932;
	Tue, 21 Oct 2025 02:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761012175; cv=fail; b=pmEfy119AQ+Jp27TaDYDtVliaaA84IJsPn1L3GrrEWl2h4qDqbbXbnjFF/tGYqFB87/WoovFcdAFgvbxanWehl8uzTP/eo+DXnvOlpp6T5rPKkEPBJJoKnNvnMN2hjhp/GBiYGmkowNeMg7JgKa1cnzArWr0KAI0hg3rtIU18E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761012175; c=relaxed/simple;
	bh=vDkacOLbJyOdLqqMsmzb4tLcrsPuk8I8pZ29yKCldlg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bDJH+7z+zitUedkjo3c3VC6UWiQ/fvdlpNWoW5hKV9978sDVF5kwBRxuvkVocfodfyg1Zmi7vE8xiMyN2HogOK8fBVWaQTSp3U1xrxkY57uKIBTSozkVEe4Ot+Z0cPGQslYJxHnDqKbSGXZaAXQx+J7txc5AtxBlpD+EyLuxJso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=NqnhBi4o; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KNXGj6007324;
	Tue, 21 Oct 2025 01:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=u1VgzVV
	clKa2DV8Cicmw34/BOCJiZWvps9ykgbLcoFs=; b=NqnhBi4ojo3+egS558WqN6P
	S4jKn/2tOzIUz2qFkkOypCDTDd7+il2LYLolehDA2963GMDJw6S8h/DDQ0T6DS+m
	/Mun03rZjfVcdOQAL3Wn+pd3TVlCXEIipPhKrobDaz8oUtkU3jMX9vO3A5Rsw3FJ
	ZvUdbS7qde+eFf6JpbQ61ktanIVGmiUvMfgzYkClrePsKEGnT2fJN8v/8DNEVjK4
	s2P9LZxIziZU4NKD4M9ApvC1TnBiJiQ9OSz/coMtMrmMzRSe6RlrGJSTS9GqEedA
	3JsLQwB2eCeLpraxpVsAzoLA5hCKtjpCSDaobuUJoQNcLahDS5qzBP8pMvqQLng=
	=
Received: from tydpr03cu002.outbound.protection.outlook.com (mail-japaneastazon11013020.outbound.protection.outlook.com [52.101.127.20])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 49v02530v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 01:38:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgqinZ8+vx2kqLb0fhsYnzN6JFVzpsFQVlJgtcOJY9+foJ6Dfm6SEtpNZKdulOMUxnh4losDJV6/3a9dA8v6l9Imt5yXahF1X5SGgpm1zn5TJqBZcqOGoWf1wCR+tBduKgXfuhX2s5QLWw2jizpaMs90Qq4uMYoVk3cAIVZjHSigVTkxpSQZVmFOJ0UYHI0kxuMbSg1aG1RSTXWGZNS3mN6eL2vlFYalIkSLnlT2L4F41xXRaLfGKKmtdu0j7LjkE1m240XIXUcKXHde9dPmfNgWxZKuK+0/6SILOMX4M3/JuSg+ORd1QLj4UJqonAaEBiZ2ZFYCYIBvvpgFUMsLAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1VgzVVclKa2DV8Cicmw34/BOCJiZWvps9ykgbLcoFs=;
 b=PxvJQU7RYaW+Ks9ZOR04x+RDoJIRcBnbbExzyqLAzoZ1kgzvMucao6wphGMT3QAsHjravbw0ywUS+jMQVkU8NIzwSJmvLT5gH80n1wTtcjMpM5biHYMuCFLchaiUvGIt7v56PZG2EKN6wpNbVZHK6Cr+tA+vfzVSJ5hg2yE1+Iuzc1YBjSFd69xHN5WehOe9/hTn2hj/wlp11LysNlrHWjXNU2y/7pYW770IENLltFw0VnhICoaviN3LLiQjcJltgtRIHFGG6kDUq2QrqFHs7NtRgXWe3EG8yXl7WdB+COY/Yz3AWvYFa0RYmJoeEpT7nSaKCpQGhABzsKyqiHa6IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB6811.apcprd04.prod.outlook.com (2603:1096:400:339::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 01:38:29 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%7]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 01:38:29 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Shuhao Fu <sfual@cse.ust.hk>, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] exfat: fix refcount leak in exfat_find
Thread-Topic: [PATCH] exfat: fix refcount leak in exfat_find
Thread-Index: AQHcQdJ0wcH5u5sPR0ix9yLePJBMrrTLzpsf
Date: Tue, 21 Oct 2025 01:38:29 +0000
Message-ID:
 <PUZPR04MB63160790974C70C70C8A062481F2A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <aPZOpRfVPZCP8vPw@chcpu18>
In-Reply-To: <aPZOpRfVPZCP8vPw@chcpu18>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB6811:EE_
x-ms-office365-filtering-correlation-id: 41babfcf-9ad8-4824-d3a4-08de10428965
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?MiGH6wxXrE+gyrDgoEEklsOSdQlplhQdW3IiYDS5fHpLRlAUpWUOQXAkdp?=
 =?iso-8859-1?Q?+45tPQ9IN7wiNLHEwd8LsL/9O+IcXbCUHFFmu+0ak3afeubK2WAxje0qr9?=
 =?iso-8859-1?Q?tE8XWZ/c+0xw2Gg8I5youOownr4xiWC9Oy0KDi9H4NgplYuy7u0nl/Uly1?=
 =?iso-8859-1?Q?kpmIhXCQBIynAEd6aeOjOAazF1pScuCs/jOtlXnj69/vbAnEMIgwoShEJj?=
 =?iso-8859-1?Q?sYWkf2gtg/MMORwyrO9P/Z73YmLhbFrQ2M9awZZimt+cM80xJZMRgSmQn2?=
 =?iso-8859-1?Q?u+OB91PpeMZX0Kdq9j4mKUKRNg8SvGa6SjHzRYiuDj6Tat/gA+B45a1n3y?=
 =?iso-8859-1?Q?YpBmNP/AzePGHCiMuGAhvnrvYHG4DcDwIN48LuYK47GVeqRnH7QPiozBDF?=
 =?iso-8859-1?Q?6XFU2HUyZJophgZtl3fXzA188srZjSZi02w62tcrnYcabidRzsN6NV8taJ?=
 =?iso-8859-1?Q?BTfVF+y513I/nNctBkLOM4/cMnxc2fK/1w/Oy6sSF+64O/7Xrvo4aIr/o/?=
 =?iso-8859-1?Q?/5psWNoyLY8BdcZKg9MjTThAEz4ndlQlW8HaB2nJ6v3bcEYAz1MCXJKYPN?=
 =?iso-8859-1?Q?SGBIGzujQWS6lQro3yxXq3JW6T3Ax58yXC0cPvQGrUjcJ3RiAd9l14O3af?=
 =?iso-8859-1?Q?Z4J2Cs1GwyfUfmeD+oQ5YMrXkTlU4+pNzUwssm0C+AeRGk8JLRmB7HFdt0?=
 =?iso-8859-1?Q?+9R1aJ5Z7UP0JcQtGR09pEF/vQLT1NzCN0RCkPajlZW4cMFEPa1SlUu/4b?=
 =?iso-8859-1?Q?DH+qyhBN4U0kvihJyTy4eyPAXB5yfPsQk5o2fNhU2rFxrhCfyzWwMCHyWz?=
 =?iso-8859-1?Q?haZMMKDn2RI+22HkdSK5aDwxxCzOcwdvmfEcG7pfu2PSZKniC4pYbOg2Vx?=
 =?iso-8859-1?Q?LSafgLfW3B8OfeLL793H+gmIGRLdEJLcutygKXdamXvwYdnfQMw8a1Upo0?=
 =?iso-8859-1?Q?ozAIQPT8BeUglYQEZNxHQOqBoUaGaGNrOjW8UzVO/BFP0nUNEP2VHA4NpG?=
 =?iso-8859-1?Q?ksI4RprR3PQzPd1/STBz8G1414aqQyl3lLn+czVCULwoYi5P3lYWsujZaA?=
 =?iso-8859-1?Q?dUHvbn1hKt6pwiFaPWvWqGhn0inhwX8+MYrYXkueBMkeN93eWIvAXXuZy5?=
 =?iso-8859-1?Q?9FeLLmx9SRoRcIfwhes3LS3YjrZxVNSqCX3CqMr/e3FtQ7y75R26Lujxxj?=
 =?iso-8859-1?Q?1YYZ7QOdHYQlJiRHkNGwwWqahp5AezeP+n6jxtJpQRhnKU9hHj6Y2pr7bg?=
 =?iso-8859-1?Q?kxSsY3Iw9Nhypj6cBprXqBnoJbIa1oSK2qC7ZRt1IszsixJNQTEtljTU9H?=
 =?iso-8859-1?Q?iqMCBoDZbijn4dQOjU7iBVz4Rsb6g/96nwTESmJoi+ac4P5QZ3iaU4j9ob?=
 =?iso-8859-1?Q?fjb8EQ8rtmEAGVcMP4zvR2n4/T9bw2HWRahAoCrEdO9Lm2f3AGtlzp3kI2?=
 =?iso-8859-1?Q?7bEq+q9T656lScDuURMxtkJY+8zbbfqzAR3KswY3acEmUHhs+hvc/ZV3eZ?=
 =?iso-8859-1?Q?2+Kd0pAAGCSt7czRnAAhL7Jy7LAHrcKEX+5OclwKInZrw+V0ledMokV5H9?=
 =?iso-8859-1?Q?gdSPoc0+FLGyxeNrrt4FCDyJce7R?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?jifKX5AH18jiENBwS1MWibDNb2SBTaIk8BQstfqBVDH3SlJsRQeS0hhT9c?=
 =?iso-8859-1?Q?W+coHGMJPtV8B4mIpSPhcHcgshlNfamjuYShzbrrziqOCg/EQD0Iubxekz?=
 =?iso-8859-1?Q?TWYOYZ80ILZtZkdl6XRD9UB+DAAARtO1tcy8A3FBV1zgBnDqteLQKU1sO+?=
 =?iso-8859-1?Q?yIlrWtsKASDAXPD19za23iBxfv0r8hELvevK9DJ+ietSwYb7OmOroZfLO1?=
 =?iso-8859-1?Q?ybdrq7cK5XslK9hDCc+O31AQsVGEgcF1ULj0vOjYeLgtaGGbS5fc2/tJr3?=
 =?iso-8859-1?Q?Ga4+LIHQoOdCBLeWi0djQ2N9dcJ3R2KtBifcvqtDi7JmX7cDkSy/2wwv4+?=
 =?iso-8859-1?Q?KVPT/zP2P+Bb7F+vHhsXf+pR6+xCcVEiumCcLNNhzqhDOkptMBYOXZ+6yX?=
 =?iso-8859-1?Q?+QjeTQdhSk5B2ww2pemFBCj9NNPIZhTsHL7mVQABulWz177qRzeLT07xGu?=
 =?iso-8859-1?Q?mNVd78Jz3OCyAMyCLyLnlyhlomZ4uqx8+QK7uTCwRh1XcKM3RwE7Qv79MI?=
 =?iso-8859-1?Q?b/X4uRmC1gPwEgIR74CF1ah9gH+Ar29YxjbWKKwDu5eArwgXeRjmb+iTca?=
 =?iso-8859-1?Q?12s+BhD2c/ourpDZ2QCNnFeEStBYc76Cy6ASsZuExvJiJjk9feekRyZStp?=
 =?iso-8859-1?Q?t/OpHqV4gE0I16Fm2B0wkV1SOj7NLzTK5gmyFqLNJBp1HG6hqvONXb0SvA?=
 =?iso-8859-1?Q?77I33k1ZZzj6TQjICBZ6m0lPzee3atvrzDYZzOlrteCAWlJpl/esG4GYKN?=
 =?iso-8859-1?Q?OTczKnA9zzipirgzG3WofEGyq4K5cDGK3qmFR8/+k+90iWeFEy0NHvEscw?=
 =?iso-8859-1?Q?M9dM/4uw0E3f6TrgrVm9Hpr6y3yraZB9HytAroWGPKHyhQCYp6X0Y5jIN7?=
 =?iso-8859-1?Q?iLrvrnpcZI1k/+ZwPgylh4WU8gF93yeunJnB+liHeeOHNmDrTkZdZml+GO?=
 =?iso-8859-1?Q?KwyVCdZrJPSXTzhquqn5SNVOYVTBf8aT3UtLym6vYdmBrQHwAc2/V20BId?=
 =?iso-8859-1?Q?msxWJpi8ISf94Z50oIyyeX75drgFqGg66FtRxUssKTqUNisz9NN2JBBKYM?=
 =?iso-8859-1?Q?7w7ThhAUENQ6of4ZgOo3Fud/UFYDKA22nS7KIN7ouJalW12bqn/e4E6nuW?=
 =?iso-8859-1?Q?hpqooU91sD9MIoBJxcnL0jYeLHe9abvPhJGlNSQ/KDdwo+zE+zs6yesCrl?=
 =?iso-8859-1?Q?V96DhWKJB7TJXm1ZrvvGoYmUPxGibbJADqa5dnUgA9v/yIK0rdOarCRHll?=
 =?iso-8859-1?Q?K4LRD2lNaZSizEodSZQIMOvrhDVs2usa315TBXzpKjmonXoPgzFjfuqP8e?=
 =?iso-8859-1?Q?e6mCf+mghAi+6l4jCsZBRdwv/etSqiWrVaXxc6bAjhv7dKuTz/QQj7jv5j?=
 =?iso-8859-1?Q?WHLoJcBGomMS5eizbkfO6eC2jyp72lBDMKcWDZeajCVGGByupX1P9muZah?=
 =?iso-8859-1?Q?lXZbmHb6wSt9E7GWnn9SemqSEzk7rjbYPtIWz5jAfEVG9z1xq8Na3fT/7I?=
 =?iso-8859-1?Q?aYmxElmKs5s+5iqAbnA5FeYUB7pXfslJWypIGLqXhAN/NJVW7tDUmZS7Gy?=
 =?iso-8859-1?Q?9zHIVHfIJvH3VPHveXGsXz5YSfhUChmH86cw/tq4k1bCcPdZAPMiAb3OFr?=
 =?iso-8859-1?Q?7YhlfuLY2elro5VKdRHdy9/sMN4x7vr7OCpEfb5wW6bNU0rQ7Coyu/9A?=
 =?iso-8859-1?Q?=3D=3D?=
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
	Ap29wJjcjf0rBjQDaw9b/2pDUbhjo6QLx10UDprVU60uLr+v6P13qc9hOzApYHWLibiXuk6c6DvemXxnZUBi0GAEe//9SbH9HQbjut4/faBo4dikb7o0plhJvq8QqeQfepU3T9AWuwr9J1HFZrlcylmy5OfYf1I/Z2z6EJ+udOe2W6o83P7AKdJDNSnOILuf76Ma8yzPD/5iu5Kjrx6cbxeRaV0NRzeWzh4tN3ICtg/aaGXJv80dF+N1GV71l2EsyfY6H8wGV5deHEDyvUMtZN1Z8hVbR5kHu55TU2ovN0s1QBNaLYrhjWtoEIHoZOwMiS5m5yaOsn0IqCiWXXaic/zC+0tOl+L267jR7Eriw2IpoDpDmi+/31sr4v82X4MNmKVdkN2Qg9hgUTFkqv9nwQLz2UkR2fW5MnGG2IFbxLB9QCCBhQKUr1D/ZLN8QiMurUPpZrSfs0y+buohPc0hTf2EsjbH9kkaTCds3+YbdvOeSSoiceT+/m4bu6n2vcWmHclXC2FxKPhUkBnSkafiahDXvGrNExq8fI0ZNZpgqznlh8FxfK78xmnToEpVibdxUBIxpocyUQqJ/f4eu37pNVSEW0Z92D39IGrU/iG/44dYYLT845xqwGuk5rcpy52h
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41babfcf-9ad8-4824-d3a4-08de10428965
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 01:38:29.1973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mdwmHd+5aiNRxJZsBsnqpvkbwHFBX8SZrPxcpSoKD43nyPPn/bVsX7l9115wRYzJtpIqkcFGLXZ62TCzrGJlwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6811
X-Proofpoint-GUID: maMPgo9oXCZ8AGYnmg6I89nTkMZDsFIb
X-Authority-Analysis: v=2.4 cv=RqjI7SmK c=1 sm=1 tr=0 ts=68f6e41f cx=c_pps a=PBKioTtUWgOmbxP0qoCihA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=7j0FZ4iXMVMA:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=xWbu1OW2Z5O8hl3cv18A:9 a=wPNLvfGTeEIA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDE4NiBTYWx0ZWRfX0/eskKU3Q0HJ Vc79+rcCf4WVYiJaWF2t+CbCGHiyo1asNi+hpcF/YtN2YsWJZGuD5y3f0fUHEcE8Wh3U3r4wDqn T0srzOEU/cI87xRpNWr8Mu3XLHfvolD2tfGdJHNHM1HECeLn6apZOBf2RV8lLteckn1P8hyzxzp
 SxenmgpWNn+xWPTEPGN6cz75/QcMNg1djO6+oJ/z2f/35wCKhWKMdSi+ExAMHoG6dDYg87KQitw WPJiYuPNdrHxtWecMMCaUnQrs/iRsxs1mie71cwWEMFwdgarolcT+cZJIdOcJY4a6OPf67hKHnl KZefoOvxFZdOtbGedbADwK7Jygbgi8gG42t3TJaq36fnnU5jG0ijcF8PkVuimTEn9BI9zy+UJId
 /OvR3+oFbJHWHCggunlJ6OR230qnTg==
X-Proofpoint-ORIG-GUID: maMPgo9oXCZ8AGYnmg6I89nTkMZDsFIb
X-Sony-Outbound-GUID: maMPgo9oXCZ8AGYnmg6I89nTkMZDsFIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01

On Mon, Oct 20, 2025 23:00 Shuhao Fu <sfual@cse.ust.hk> wrote:=0A=
> Fix refcount leaks in `exfat_find` related to `exfat_get_dentry_set`.=0A=
> =0A=
> Function `exfat_get_dentry_set` would increase the reference counter of=
=0A=
> `es->bh` on success. Therefore, `exfat_put_dentry_set` must be called=0A=
> after `exfat_get_dentry_set` to ensure refcount consistency. In=0A=
> `exfat_find`, two branchs fail to call `exfat_put_dentry_set`, leading=0A=
> to possible resource leaks.=0A=
> =0A=
> Fixes: 82ebecdc74ff ("exfat: fix improper check of dentry.stream.valid_si=
ze")=0A=
> Fixes: 13940cef9549 ("exfat: add a check for invalid data size")=0A=
> Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>=0A=
> ---=0A=
>  fs/exfat/namei.c | 2 ++=0A=
>  1 file changed, 2 insertions(+)=0A=
> =0A=
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c=0A=
> index 745dce29d..083a9d790 100644=0A=
> --- a/fs/exfat/namei.c=0A=
> +++ b/fs/exfat/namei.c=0A=
> @@ -646,11 +646,13 @@ static int exfat_find(struct inode *dir, const stru=
ct qstr *qname,=0A=
>         info->size =3D le64_to_cpu(ep2->dentry.stream.size);=0A=
> =0A=
>         if (info->valid_size < 0) {=0A=
> +               exfat_put_dentry_set(&es, false);=0A=
>                 exfat_fs_error(sb, "data valid size is invalid(%lld)", in=
fo->valid_size);=0A=
>                 return -EIO;=0A=
>         }=0A=
> =0A=
>         if (unlikely(EXFAT_B_TO_CLU_ROUND_UP(info->size, sbi) > sbi->used=
_clusters)) {=0A=
> +               exfat_put_dentry_set(&es, false);=0A=
>                 exfat_fs_error(sb, "data size is invalid(%lld)", info->si=
ze);=0A=
>                 return -EIO;=0A=
>         }=0A=
=0A=
Thanks for your patch.=0A=
=0A=
I think it would be better to move these checks after exfat_put_dentry_set(=
).=0A=
Because the following check will correct ->valid_size and ->size.=0A=
=0A=
        if (!is_valid_cluster(sbi, info->start_clu) && info->size) {=0A=
                exfat_warn(sb, "start_clu is invalid cluster(0x%x)",=0A=
                                info->start_clu);=0A=
                info->size =3D 0;=0A=
                info->valid_size =3D 0;=0A=
        }=0A=
=0A=
> --=0A=
> 2.39.5 (Apple Git-154)=

