Return-Path: <linux-fsdevel+bounces-36313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE649E12EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 06:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2040B2319A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 05:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E754B154BEE;
	Tue,  3 Dec 2024 05:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="D7pu6RIj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FE72B9A2
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 05:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733204003; cv=fail; b=C22xbhhLzWJpEh/1P1XM7oA/S/cSBIFdDar7E+Ws7dHeeUIL8prv6YZgoDFdb7iBV5jSmevq1O51lTurZRwcM3yY+NrkBh0R6XYPXGcvxcy8rbnBsrYQy5+yQL2fSEeIAnfGta2zwS6BijvzlH2GDO55JtyESX7XBOrHvoVJikU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733204003; c=relaxed/simple;
	bh=wjownCk7ScElNcF0Kru1GtzcdIDhUfX/jnzbebMImKE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KxhiRVDXZ3d+4B3dS5n9tqnjYRbHYThYWl+L7Lu7eeSEnfSmDLsTllwMkkjNLLtMeqqzka2i6q9muBbQdB5rNP6Vu7xpci4lFF3QWoQwx3jYFvpeN4hatdqjOTpZOZpXH8nc57EpfqVrawE09FJ1K2LyzdhhOeIja+9tKKZU1xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=D7pu6RIj; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B34BrlE029405;
	Tue, 3 Dec 2024 05:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	S1; bh=k97OzVUPFkJH+YspjKJ2urUWxiOIstZ/S9PrCts1mGI=; b=D7pu6RIjr
	206CEo8+0ADae6FsuKBtMGnjO8UuMhf7i1i4oUuFMXgFPHpMwNNAYv3R1U0pc1js
	nFvUnedG38oART2biTcgMyxqqWh7w4ofrGNfRwtY2vCGvKOXIqUh0YnRoV92wgYE
	19ZPk8Q1vq0rPnqqSwaQeJM+jjgcDmYEV/YGwausCFBo6NEPBFtWpOiy1zoVNmYC
	usxrZzkBx0wCFJ/h2Iy4r6FiS3a1XDytOCUBOMcB3/9HS0y+pmvHLuSfhu73ggs8
	Jj+ApEBBnEsKsTN0FVsYH+v9bv3bTDMlH8nBsinRx2EPw5iD8UTx8vwoHm5t4XUJ
	I9PiYdq4oy/VA==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2043.outbound.protection.outlook.com [104.47.26.43])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 437qv3aje0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 05:32:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuYkUOpbHsqHKEPsfN0s0BfYwVRiK68eGWnjNi0ugABkbBCPl/XkyrNGmDA2+CqsYa96Gk0ePdAIGqTE6IWgzXt5y/Ej7qMBJ51EuQj8h/8xzwPoudYe3dI/ZCgqbTUS8+uWix0h1bocZWKL5YM8Kg/hl3ZP0svyhL9637vaeBhyzq5evfVf6EIctx5OvJwnHr/dqvlciAhz3BcTMR9Akp6/viIcMV3AOjMDScYVz89Syksj/xBm4ArRLDnYJxm8NvCUP+YyQEeeLIoYDpJFbfT9sFC70bScn0XgN36j6MqNxtNde7Mqjve9GRHbghdCKKuooMOzutKEusWQ3Th7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k97OzVUPFkJH+YspjKJ2urUWxiOIstZ/S9PrCts1mGI=;
 b=Zv/o4je5HUzsoy1eak6FgR7X51XXS4aXcbTo6jY/CX1CDM6W1ZuM59DIAb+eaxTZFG+DNJXfoTSuUF9BSf0ZmCvMhcULtj565u3BvUw+7uKgWjsiWbuw+Ql+pxSrIGVHqq8gerofD8kqkS/X4HQkRUaLWqJYphRRKIkFuT4if8Jj7ddWEhL9WHr9QjrP09vURzmNYJPpevg8UcMEMb9VPVMAHIa0hqxvywKAv956+8uqnfNofyyCB8Y9By+y50k/z+BxZ6gpBumkt20nfHxmtz3WPQoFvz+mijKNTy/6XMnRueP1gZ8iY9ZH56ifWsYa9cDTu2H6BYlfdtatisn5Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by JH0PR04MB7479.apcprd04.prod.outlook.com (2603:1096:990:6e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 05:32:50 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8207.014; Tue, 3 Dec 2024
 05:32:50 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v1] exfat: fix exfat_find_empty_entry() not returning error on
 failure
Thread-Topic: [PATCH v1] exfat: fix exfat_find_empty_entry() not returning
 error on failure
Thread-Index: AQHbRUQhePgXuMCkxkOuqdd6gcFPTA==
Date: Tue, 3 Dec 2024 05:32:50 +0000
Message-ID:
 <PUZPR04MB63164E8CDD8EF7E1F5638C1F81362@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|JH0PR04MB7479:EE_
x-ms-office365-filtering-correlation-id: 4fd7cd84-dd2a-429a-bd2f-08dd135bed93
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?KyF+a/Befnv4x0J1biqpgmJraosHn824OWqEeP36m1nNoI4Zh5rzz1vsAF?=
 =?iso-8859-1?Q?iBhcom6N+2LB95RTqTam2AzKmCmfA26F6nmMw6FE3UZHgdBrn1JqQfAdAE?=
 =?iso-8859-1?Q?9Gngfdd2WhBS49YdAC5MYh6y3VJDcYoaeOo3ViOFSAniDN7Qsv8+5XijnW?=
 =?iso-8859-1?Q?RzoSqg4Vbxy2DRVHrBxcLG4cK4YeZ7bPWibS/wZgagVCQ1DIdo9WjbqfqT?=
 =?iso-8859-1?Q?XCVbW8+TUbRkn7fp6I7LGvfoeIEgZ3GUPG2vTjald28xfG41LDZWU1GWc8?=
 =?iso-8859-1?Q?GYYTs8dIhf/mdKXjcbCFr18FctKQ4pYQkFWJbRQo/vCt834OiB8Wn6/jTD?=
 =?iso-8859-1?Q?kt2Y4C8uXc2G90fey3xgZsKmC92wxpVQmqJr56WnfIbDGLDSv9zGVyl60Y?=
 =?iso-8859-1?Q?b7/bKcbh34zTGgB4+yEWMy7Lwo431qp9JPTp1fQH1lJ0XMOfakm3Kzj/K1?=
 =?iso-8859-1?Q?3usKXtR4CBvptVIvbOYFYw0BLhA4VQA+IpUnZQ8kdIWypEpp6CXfyTIxgf?=
 =?iso-8859-1?Q?8NWc6KcGtYuZNb4gwFxR4x7utQmbmbiiNcw4Agxwv4PtVSUH8R8EbZcnpL?=
 =?iso-8859-1?Q?qscqnI+q3pWJzPpAQQo6EUnlxrL/gP+3pxBtc6yxWCdjbin5o5c88vNgIB?=
 =?iso-8859-1?Q?4zc+mPPsGDS82pyC8mEV/GP4O1r5SHGviMUAvqYw+TLkJ43cc+79kKDktL?=
 =?iso-8859-1?Q?GzZCoZtk5DuM3GL8riaLQV+KOYS1SbkbVXfZg3Ra2CbrXWChSYJl+h8vlh?=
 =?iso-8859-1?Q?GntHA9EvK5FG2odKkeVZqJJ89S3MutbXihGYAGY2jcnrKIs8/ZkO+0tb3o?=
 =?iso-8859-1?Q?GOSI2u1En++/DTlcPcJXkBkyZMcxp9aDv5WomBhaFF0lcmBzpMgWK3BsXx?=
 =?iso-8859-1?Q?eM9DrEwo2nC00Z0yFpa/R5zPZil+qSSII+3Pc0ne57uV7ZwkkHCaVXUTPh?=
 =?iso-8859-1?Q?xu/327nrjLJ1aJf46H3EJHMM2ljRdGHmK3EvROLMNuNlJ5/vrbMh9AIO0w?=
 =?iso-8859-1?Q?ymixxKehKvczXtElRQpdoiVLikFup+Rrr558QNliBjkhJb31C/ZJM8hOzx?=
 =?iso-8859-1?Q?vlXBfUBuH0QS9Jcjy0xZ8POw0bXsbXWvPw7mxZZgSaBwYqzUfcViOtB8w6?=
 =?iso-8859-1?Q?+GT2THAwjja46bi/XikqPxoV9eQX6PW1Kg6lfcCNj/q4v6gwGweX62gV2C?=
 =?iso-8859-1?Q?nRXMK9iNaBkAubGthHvmSKKGrUm54gWKHWutoZkpToOCfVBrm9kcpiuIYp?=
 =?iso-8859-1?Q?zpCdzm72nKWyD0E0/KFM48FQMV/cs7lvouplp1IlpPr/4WXkOgKSGd9KR6?=
 =?iso-8859-1?Q?G2GnehJzyg/plfalnfdfnTNswG7BpDZpmSaI/07+bYFbl6TEI3LM4l0DkX?=
 =?iso-8859-1?Q?ojHxCLMVzfQeQDV4nMRGmKR4/kOu1GA41SuS7kPIaVlrTVnkl0Fl2a6PyN?=
 =?iso-8859-1?Q?BR9IPaVlSFijQaKoBQbuGJCQ0O4P5EW85QIQ2g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?cvoliSgELbVbMskdANvqoNZt5trDLq8/jyq06dfYhwrAKW48kQOncboED5?=
 =?iso-8859-1?Q?QBLDKS3C+I7tnB0B/LE/UxSc6S9TAwSJJLKM0vZ3YeqtPtVHztPVfXTYKE?=
 =?iso-8859-1?Q?ytcryVMvQFa3sGwR4c0yoqvYZAkzJttJSR+2HLxM67gbwvsSeH8NJgQ28P?=
 =?iso-8859-1?Q?OqJhyI4k924v7xsL1axoKlFK19llzeE6OSqA6pY2obizqoRYBQJcpnmy/E?=
 =?iso-8859-1?Q?nGXVgHzWo3qJ9u8BXmQgo0XjCxp+q0Qn5G8Bxq3YuyfgH8k0mWIQd9MMtL?=
 =?iso-8859-1?Q?5/KTAwcauUhuZASIOTDIMOLUfZpBkSk9zIQ6M8OM2Ka7mDq39ET2xEdTBI?=
 =?iso-8859-1?Q?RJKc4E226MwDyPEuqD+M8hoPxGlXnnQh7ybrrwl//P0ol1e3YIKeO/nbsU?=
 =?iso-8859-1?Q?t5PKj0KMwX/2Xk6qHLJbn/9cwwCNw+isP6GLanQpkilL5QclQd8oBNaygp?=
 =?iso-8859-1?Q?9ucMbI6UNmbg69zAPRZ+n4okJJkDDLeDq+7cIYWDI3u4hU0mlk4iNz0QCM?=
 =?iso-8859-1?Q?agAYgAwqlrcyzFUI6zoXt58ZiERNAvgckWwoIG4JLVCdcHiQxJL3VPzOuD?=
 =?iso-8859-1?Q?J6nQKqsJ3buPuXqrsJkbNmGLfr2A6CgU4CtJ/Mzy87exzkqhm4H1htMlB3?=
 =?iso-8859-1?Q?ySeTCVMHsxZnAiIJR99p8j0OafErn5RWmx+oWHSktNR9Z8oeIKrbB8F6Vm?=
 =?iso-8859-1?Q?EFS7muBxGNr92t9HvxMxARQv1/TLlpwOqFsvFln+Og4FlkqhJQ2ELmm38h?=
 =?iso-8859-1?Q?iVUCVu/9Q2VZ/vznUTr3UCTlUH6JFlUZAWq7O9/S+nmU9HEFR25J7eQiTv?=
 =?iso-8859-1?Q?Pfnk7wLG3FSxe+BnQnqEaBkKn0/DlNpwreZIP4S0q7fiGAmnKHIC6JII0y?=
 =?iso-8859-1?Q?5VPxMs3GPMfbb14Q0dAaamtMQ4E8+A/StVPpiSfFuWPBrbn1J1MBWPMKED?=
 =?iso-8859-1?Q?5029r6WGdFNZYeZbYCK96kMR2rdsiqwXgSK7sPqCXn8FuuLNq6BhrD3455?=
 =?iso-8859-1?Q?asKrSZjiui9PrgCmX0/T0PxgF3V4DEZuVIXCTB/Ed/KHI6R0PyIxfXJ24n?=
 =?iso-8859-1?Q?Sx1QQ3n3/8QbNeqgy2njzCHkMwmXZM5fH6RCcaD3sz6PODk3ZVC3vXYyNr?=
 =?iso-8859-1?Q?Zsg9xPd2VdAdJdgo42HH+jUJ9+Fv34a1rfYKNfDkC5ubxtLIAJOnEVrRTh?=
 =?iso-8859-1?Q?C0LdwArrHimzFCIhIJ1iEZfHhFCkoG9uyngp+7vAcSlbeUP8rRNqi4+EHY?=
 =?iso-8859-1?Q?cnV+RdlxHYD2fnyGaa/xOa9Ho0DdubKPLSy4/D1OEIamjbYDnuuGmBfIlO?=
 =?iso-8859-1?Q?gwdQgaFnUwRixLVqTCgkJeqxLdixbfqVi/Zla3VX2u8E+1jbUn1iB1zyh5?=
 =?iso-8859-1?Q?ffP4cLoXR52EKyq9tj7x6qVEiaEBGv9jMMwY8kFjtahG5R4oZmWHPDlqBB?=
 =?iso-8859-1?Q?/kKMbZIe9xLlDEkF3yC6xpXfYVkOIlekWQOo9uvwyu6FbMR40QWFMaUK3J?=
 =?iso-8859-1?Q?TP+B5CJf6EX/9xG5/ZRUGu4r3WEW7w97p7w+4ZDp6foaRkgRng612Y/iR7?=
 =?iso-8859-1?Q?hbiOooLAGK8+f0vi2DqFmcMRycgFLbyXxXdPHpVYGT3VEPBTcixS2qExq9?=
 =?iso-8859-1?Q?Yaxp1fMc4RimVv9tXIgOTBUL4kscAfQ3dzMvCMiqtbBzOg4EIKMtoqi5VN?=
 =?iso-8859-1?Q?pn7ZoyHMUE5BZwkiZyY=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PUZPR04MB63164E8CDD8EF7E1F5638C1F81362PUZPR04MB6316apcp_"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wMgVlnQQ4eKUFLGZpH1YtFoUR55m19Fup9c3LFOAHcx2u8OEk1uLj4b6f3VUVA8fGclM3BNDUNq+lrX6G0la9Wa4CJi/5u2kf728Td2TJYAqapU0b4qXDOubGkDkMY29shCjEbkbqa5rPrDY8BK2c7GU9RYpigXW1AsXHQSD57tIpNpLX1iQC+Si05A8PfsdGdqIBQMV2ttc+X2tU6jtwSMTvt9ojwT8UEI6ckIjx1UAgW8mxoFzNT2/k4NRn/IfKBykrSh8yFjCsT4jqZwpIPamYm5LkEZJ9kLl5InhVeJseUPHSMhi+BFOBLWxObTqcPcAvEIewC4K2Kqsg8Bwmqs1WXK3E+tgSQ/Ocpjf7Ncv4qpPPgvtXj2ORSKGDprf9jg4SvFKG7Yu9gjGx+b4Rccs/RYWoJN/r8Kp0itjDcd7zQu5h5ta+idoiH6/ARjTg9nuNi+Xz96hLYTToML+sNPuhyO8leOkAZqrm5dkgh5gw8SpO49AbpXbEJm2BtRMKHr3sQddSd3Nq2k3a/QoW6fx2nJ9BN7TWmVpQgUrZAJgduujNPWVg/WDC04GKRoBZs1r0bTHX5aEBRGAjIrBdjlAyPoesJvPQfklp2odzrmZZzJQrwOufCbHeJfG+jiz
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd7cd84-dd2a-429a-bd2f-08dd135bed93
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 05:32:50.5037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: onVsOTn/XIBFPZ+p/BrW3qKgOtwgk1xgwkUzifcMN3CY0lwjB09HRd7RlUukch4kYO5ghBARN1YpgpvmMg1Kzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7479
X-Proofpoint-ORIG-GUID: tpIZ3ZS7SgWoYK7_dUAf-m9cUpuZKU3A
X-Proofpoint-GUID: tpIZ3ZS7SgWoYK7_dUAf-m9cUpuZKU3A
X-Sony-Outbound-GUID: tpIZ3ZS7SgWoYK7_dUAf-m9cUpuZKU3A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_14,2024-12-03_02,2024-11-22_01

--_002_PUZPR04MB63164E8CDD8EF7E1F5638C1F81362PUZPR04MB6316apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On failure, "dentry" is the error code. If the error code indicates=0A=
that there is no space, a new cluster may need to be allocated; for=0A=
other errors, it should be returned directly.=0A=
=0A=
Only on success, "dentry" is the index of the directory entry, and=0A=
it needs to be converted into the directory entry index within the=0A=
cluster where it is located.=0A=
=0A=
Fixes: 8a3f5711ad74 ("exfat: reduce FAT chain traversal")=0A=
Reported-by: syzbot+6f6c9397e0078ef60bce@syzkaller.appspotmail.com=0A=
Tested-by: syzbot+6f6c9397e0078ef60bce@syzkaller.appspotmail.com=0A=
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
---=0A=
 fs/exfat/namei.c | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c=0A=
index f203c53277e2..c24b62681535 100644=0A=
--- a/fs/exfat/namei.c=0A=
+++ b/fs/exfat/namei.c=0A=
@@ -330,8 +330,8 @@ static int exfat_find_empty_entry(struct inode *inode,=
=0A=
 =0A=
 	while ((dentry =3D exfat_search_empty_slot(sb, &hint_femp, p_dir,=0A=
 					num_entries, es)) < 0) {=0A=
-		if (dentry =3D=3D -EIO)=0A=
-			break;=0A=
+		if (dentry !=3D -ENOSPC)=0A=
+			return dentry;=0A=
 =0A=
 		if (exfat_check_max_dentries(inode))=0A=
 			return -ENOSPC;=0A=
-- =0A=
2.43.0=0A=
=0A=

--_002_PUZPR04MB63164E8CDD8EF7E1F5638C1F81362PUZPR04MB6316apcp_
Content-Type: text/x-patch;
	name="v1-0001-exfat-fix-exfat_find_empty_entry-not-returning-er.patch"
Content-Description:
 v1-0001-exfat-fix-exfat_find_empty_entry-not-returning-er.patch
Content-Disposition: attachment;
	filename="v1-0001-exfat-fix-exfat_find_empty_entry-not-returning-er.patch";
	size=1368; creation-date="Tue, 03 Dec 2024 05:30:21 GMT";
	modification-date="Tue, 03 Dec 2024 05:30:21 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyOWExZGMzZDJmOWI1OWZkNDM5MmFjMGFlNjNjOTQyMzg0ZjE3OWE3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IE1vbiwgMiBEZWMgMjAyNCAwOTo1MzoxNyArMDgwMApTdWJqZWN0OiBbUEFUQ0ggdjFdIGV4
ZmF0OiBmaXggZXhmYXRfZmluZF9lbXB0eV9lbnRyeSgpIG5vdCByZXR1cm5pbmcgZXJyb3Igb24K
IGZhaWx1cmUKCk9uIGZhaWx1cmUsICJkZW50cnkiIGlzIHRoZSBlcnJvciBjb2RlLiBJZiB0aGUg
ZXJyb3IgY29kZSBpbmRpY2F0ZXMKdGhhdCB0aGVyZSBpcyBubyBzcGFjZSwgYSBuZXcgY2x1c3Rl
ciBtYXkgbmVlZCB0byBiZSBhbGxvY2F0ZWQ7IGZvcgpvdGhlciBlcnJvcnMsIGl0IHNob3VsZCBi
ZSByZXR1cm5lZCBkaXJlY3RseS4KCk9ubHkgb24gc3VjY2VzcywgImRlbnRyeSIgaXMgdGhlIGlu
ZGV4IG9mIHRoZSBkaXJlY3RvcnkgZW50cnksIGFuZAppdCBuZWVkcyB0byBiZSBjb252ZXJ0ZWQg
aW50byB0aGUgZGlyZWN0b3J5IGVudHJ5IGluZGV4IHdpdGhpbiB0aGUKY2x1c3RlciB3aGVyZSBp
dCBpcyBsb2NhdGVkLgoKRml4ZXM6IDhhM2Y1NzExYWQ3NCAoImV4ZmF0OiByZWR1Y2UgRkFUIGNo
YWluIHRyYXZlcnNhbCIpClJlcG9ydGVkLWJ5OiBzeXpib3QrNmY2YzkzOTdlMDA3OGVmNjBiY2VA
c3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQpUZXN0ZWQtYnk6IHN5emJvdCs2ZjZjOTM5N2UwMDc4
ZWY2MGJjZUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5n
IE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4KLS0tCiBmcy9leGZhdC9uYW1laS5jIHwgNCArKy0t
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2ZzL2V4ZmF0L25hbWVpLmMgYi9mcy9leGZhdC9uYW1laS5jCmluZGV4IGYyMDNjNTMy
NzdlMi4uYzI0YjYyNjgxNTM1IDEwMDY0NAotLS0gYS9mcy9leGZhdC9uYW1laS5jCisrKyBiL2Zz
L2V4ZmF0L25hbWVpLmMKQEAgLTMzMCw4ICszMzAsOCBAQCBzdGF0aWMgaW50IGV4ZmF0X2ZpbmRf
ZW1wdHlfZW50cnkoc3RydWN0IGlub2RlICppbm9kZSwKIAogCXdoaWxlICgoZGVudHJ5ID0gZXhm
YXRfc2VhcmNoX2VtcHR5X3Nsb3Qoc2IsICZoaW50X2ZlbXAsIHBfZGlyLAogCQkJCQludW1fZW50
cmllcywgZXMpKSA8IDApIHsKLQkJaWYgKGRlbnRyeSA9PSAtRUlPKQotCQkJYnJlYWs7CisJCWlm
IChkZW50cnkgIT0gLUVOT1NQQykKKwkJCXJldHVybiBkZW50cnk7CiAKIAkJaWYgKGV4ZmF0X2No
ZWNrX21heF9kZW50cmllcyhpbm9kZSkpCiAJCQlyZXR1cm4gLUVOT1NQQzsKLS0gCjIuNDMuMAoK

--_002_PUZPR04MB63164E8CDD8EF7E1F5638C1F81362PUZPR04MB6316apcp_--

