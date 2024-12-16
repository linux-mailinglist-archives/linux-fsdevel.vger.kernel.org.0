Return-Path: <linux-fsdevel+bounces-37472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E0F9F2A7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 07:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77D241664FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 06:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ADF1CEAD8;
	Mon, 16 Dec 2024 06:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="UoJkB8xE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284E41CDA0B
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734331959; cv=fail; b=QxmWm1fHTB3H4WUo7/Rqxw59I4lwN1nxDyxILpvbo5UZ11bi0t5tFzphJho34OcLCRvUSd2SpWHui/ORepgyXjOxlyi/II8YNvyyqXKtuubfofY2H3osNCcjmOf7GgLh9Nd2r5C7E2roVNUlT5z5dvcPcX9WP5L4aPFxbQiBUB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734331959; c=relaxed/simple;
	bh=L6TwbY2EXAjvN6hqYyUxikG19d4VrtyXvM0McWnTsjY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hMiyzCQ9mu3gV6XsPoQ0Jv6CN3TFPjbiWArwj3xMiK5slI1SYg/w3USUjRDIEZayFjkaJhC18XXJmsLa6h6sLpYMdTG4xL3e5d8XzqbZr/bvrWPVYNMhmzvukZiMd6YQy8nDGWjHHKkTeyLxtGNvbge4rlWnImrs6mDUiRvZdxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=UoJkB8xE; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG5OdX4002111;
	Mon, 16 Dec 2024 06:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	S1; bh=QWiKfUxwno8IRdOXt5Rhg/QaKQXu00gGWy3Wyte/CbU=; b=UoJkB8xEq
	HJhlyo8hK7rxHL4hyZ8QjssHcYVQcJcpoQkUswRopPae7xNEwTiMkqD3390+aIrp
	GbxPzM/3R7OCDe+WDivJCd68O448oxwxJcTlIEUC2QFrNqHZa0n9k6LHeVm/5yIH
	t/PCGtd2SL8+H3mB5lJbRL0TmZIsjsdgwbunfcr7JdicS3bu3GBcLSMvSs4i4QUB
	QmHjOymJP/+eL6xGZhQ8tWcHyKEBbNCB5AOa+QiNNY4zrwBUHQf7ahFjSo/61gSF
	Sek+NhFIiMRwYymPB1jVoXYs47bSSM2A6TflvKAYRv9JOKxPdhy84fH/Q+V6NqYX
	CBwn2I5QjIwAg==
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazlp17013079.outbound.protection.outlook.com [40.93.138.79])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 43gy631gkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 06:52:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9z+fcBOG/tb4P9tmbIOJlACr9ilwcuumLapM4tepS1Gm+BfQL/tTd/3TJVT3FP3Vll9v8qPlOEQzMkSwWdbYowZBKQZmdFG7SDT2R6yLe7f+80meL4WvawFZVlLKGSArcb5Aj9iGUNRDWhIqK9coKJ/k510Ge6wFBFVM4r6yqwNoQ1zRa0N9IvZZEJSVfrOCtejz1ocmmF28/EoNCrbZnAHOFkje623P5qAicZ1mZul36aAMt1U1/Sa761OjML9vmkLxasQPnLr1x+pL6+9P3nWXNy7liIQ/6NOOD8v0rgfgrdX3Fspfc0TJjux0PDPxeES+Az796Vvvd+KJ69Ajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWiKfUxwno8IRdOXt5Rhg/QaKQXu00gGWy3Wyte/CbU=;
 b=ShsNm4r/7Q1s0oy/2fBmPG7YXshJepwWjRShuwsllPFY04nbtIhlYPdnttTsNm2083Fqq1Beje1KyNeIHPjPq4b0gj+lbU+iQvG0UxV1BQdHgtJidGmQtcJUFknKsrMT3nVK4UCa55Ndcbyh1wiue2B1oNmt9oM0M2icKSM/IQC3Wmd1KkwK4TEuZ4whxFzGqGOppWb/yGF0Ce3ySE9XJBxJdP+yeTqZJ9nkCSPq3BtoTbWZmYkzrJ1LvAB0bALGDlrqLu7MQM4hr77ev/R2hBf5sC0GJsoPIMTtwWIiuKaaVfIelMTxq9DNzD79Ff0Q5mMCitdhOHQk2ucJVlZR0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB7014.apcprd04.prod.outlook.com (2603:1096:820:f2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 06:52:18 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 06:52:18 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v1] exfat: fix the new buffer was not zeroed before writing
Thread-Topic: [PATCH v1] exfat: fix the new buffer was not zeroed before
 writing
Thread-Index: AQHbT4bVRxvn3M6qdkW2vGpg4VXG9g==
Date: Mon, 16 Dec 2024 06:52:18 +0000
Message-ID:
 <PUZPR04MB6316800E3E260C6F1DDED59A813B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB7014:EE_
x-ms-office365-filtering-correlation-id: 87cd4fc5-145e-41f1-6217-08dd1d9e2ebf
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?DMhAX+gN7hqWApNqo5nHCLEe7phM/LL3kHRdHgYXA+O6E0qedxg2m+FA5t?=
 =?iso-8859-1?Q?JOhCky8CoAaA9VTzjl7jlFZrPHZmlK+/pk8I4lDTLexX2K2pnpERG6uHoU?=
 =?iso-8859-1?Q?cN3WWyfFi7dWg0dJYyj1QhIo5QI9jci9ndMpe+vKIdh8DzhbCgAC2X/fMC?=
 =?iso-8859-1?Q?A5G0eCrBSJK63DT++PXEnwPidSI0jP7GZ5odZNkqL7eHC4MTKG7r5oye/5?=
 =?iso-8859-1?Q?qAzrUNH7H40pEQh2Ou8zzzrEsqCDdy38VQNNrbaeqVsilu8nRAa7t9cJIC?=
 =?iso-8859-1?Q?wLXgKUfLSyZhk49jpiULyAHcVnURebOVTQC6vaEiOm4hppMwQFmXnnX98G?=
 =?iso-8859-1?Q?s7/ujYSZXjq3xhXltyKGTctur/Epu+M12edm5jNvEYmDlMI2zyAW5k0D/1?=
 =?iso-8859-1?Q?EMLKC3TC60202/+h32c5I7I0HO//ToewP8wzMDfk+0m16NqxypEjOTI4js?=
 =?iso-8859-1?Q?JVSwt9tWjplouHA/HjoG7eIgE460Zw8GUAS9pRVTtNol/6Ks6YIjQ/VGPK?=
 =?iso-8859-1?Q?GJ+QCUsKyswSTB8oXIF0z+BceiOL3j698R2d1NNC8B/jy8Z7CqszIVm+3R?=
 =?iso-8859-1?Q?yjoiqA9gjiKRZVUdQUKvcMG5Kuf+VNdvkUVYhezP4wRb6SSi4VzOApQekK?=
 =?iso-8859-1?Q?7JhlnTpYfkY2k0QFZ9+dQrazyPXfpnSG7aYig3ZhcSE+hnFo362tHWdygu?=
 =?iso-8859-1?Q?A4884AeBm3fkqPkIoUsq6kULcV8OKG2byf2KnPbN0V8g5bRnGFwxE24p6N?=
 =?iso-8859-1?Q?FU4rbINSwcqoJ2/vLtHZTyB+Y9Zdf+cifWDac1JyOxry5p8azVwpgA0gdn?=
 =?iso-8859-1?Q?IY+Psy7pBDG2Qusn+I8mMmd5KHC5x9YsZWfZ4kTAwKwYApyw2Nr7IbQkvu?=
 =?iso-8859-1?Q?GaAG08/EMcvUnLuDCkqP2uW6pqcdgAiapqhqPk2xV7IiAriVDA4ePd7PgF?=
 =?iso-8859-1?Q?G1UDB6tZxngG/Gpc3qzmB8G4Ff4M/jI19wCuDCS463+VaQv3+SYoKPi7LN?=
 =?iso-8859-1?Q?pYJ8cv6Qf4OQt+YsuULSdvTZhsTZ8DGS817nmsvLGP3MonToTjlnevpnlW?=
 =?iso-8859-1?Q?qyW9VkSjlA6AnQ4mBtUaxQlxBifQShYtKMLMRYZvQ5cVvC+rnqbJkVrlwz?=
 =?iso-8859-1?Q?ar8IDUkwPGmu2sAdoXSt62LJXqdt38NQyDRwe70B8Evpb9s1w+/drSx1CO?=
 =?iso-8859-1?Q?k5rlum75J94bn8PzPJzDs4myI7WgifOdcTzGRP+2Y2g40YQnJ8dejyet75?=
 =?iso-8859-1?Q?5YSgbysa+gBhZNzPGAsKDcwJw/h3g/o6tS8lOQc0fa2ep08ieNEI5VA6QS?=
 =?iso-8859-1?Q?ljvjHCfmMlWyGD1nXExUjLvONPdA6XaTVZQNjTRk/q/VggeOuvwAfDKJS4?=
 =?iso-8859-1?Q?81HkgewFeD3MS6cDyxBEanAW6mtonaDMYCV9wklwuaRmQkQOwG1DV0Ew0N?=
 =?iso-8859-1?Q?bmgvy4o8BQUogW2k?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?dB7HlA+LXAanjEsgONg7XPke5VGVT5KPajEOxmYLeC4wHRSfxR+YyoWhVr?=
 =?iso-8859-1?Q?JLCIsmfLLwPs9y5aoq+03HaWYXDhtCT+mKG37WkOQRIihlzY3D+UkV4+Ri?=
 =?iso-8859-1?Q?Nh8K1P9IPMLBs4kwee0xIPzleIQlfl4TOyjXNlVCFNAiEE5+YA2UBy5Dwu?=
 =?iso-8859-1?Q?UGa/Osh1dsOoHSYF6+66zZrDCDX+wO9mPU/olQXIb8zokb5xJ8t5vEMDAw?=
 =?iso-8859-1?Q?ZQJgnTji7OdMJ7y2Ofn7B7fQIWqaK/dqhsR/IZaO84Ck5xb5TVWpvXpTIo?=
 =?iso-8859-1?Q?hHuH/Uc6/gW1iHCprpU/uB+248rXpBLhGAp5QE8CLO6sHhRX8S9yVZUBww?=
 =?iso-8859-1?Q?7pZViJsZ0W2hQAEMIyjBgbV6E70sqIf3RPuwLks8g0ExPIyGyIeGHb2S70?=
 =?iso-8859-1?Q?RWYwRQtNeX+6jmVIkaCl1rdZoPPGTllgM//wuvA0qNousoztNrq/Kq6tqQ?=
 =?iso-8859-1?Q?FurYJFAhp69l5w9SOdyGohDXjE+4m9GYlfxL0pcT//YwNSlwzqSb9gQ9px?=
 =?iso-8859-1?Q?G5/TGVpWVizscg9qeTdun8FcelewsKmFKWN25E1lIXXlCMYrDgzneZ1/mo?=
 =?iso-8859-1?Q?X3NbkAbO0wLxFwryizpaBl5tTQyW3L0MmwvAtXFgsWVk5aMTDfnAsnvwNh?=
 =?iso-8859-1?Q?VJIA+OziHlpwUn4MhTA3X3/ZdOoxxIRQqlecPAGp+Jkrm/qVy0nkyKobd0?=
 =?iso-8859-1?Q?jLem/VS59xOO4vW1HAPUIPKKshSskVslPqfnrZGT0HHn2/qXnIU4INEXxu?=
 =?iso-8859-1?Q?ny6TkJV+NuAJU1OUA/Sp24CAP65mdV7ZkxmiZwoSk6l7bFeWltEBkMFlgg?=
 =?iso-8859-1?Q?qhSlI23U/vRPWepEjDsQodDSfCX4V9xb/E9oPdvehx6AUKyycvEBy0JVMJ?=
 =?iso-8859-1?Q?0H1AyS7RxqRt1miuPJWfS2XWpSHho5gq/50LyGFlkyaoRbUKbKC1jCCjLN?=
 =?iso-8859-1?Q?26HWS5bfeIastGrDC1Q3QDsRcA58dT8xVlAzWMV0fChZskOVfTsjRQ5YTV?=
 =?iso-8859-1?Q?kL15BmjkoLpYRzAzbq4Sbr/OA36VRVbAI6vJtvtKGY1QQEMOu2oOWnv+YQ?=
 =?iso-8859-1?Q?AIrb9P0pBgLsX3USI+U1efvG6XQ09DDQE6Z3YFgdf43mWAWMdvPMpZ/tXk?=
 =?iso-8859-1?Q?5rMel4kXW3D2IAssicNdS5MtzDVFFK6I/TR8TbUyQTVLx3NKs7JuRU+V/q?=
 =?iso-8859-1?Q?z9ItT7pB89zFcqCpli+P8Zr1rZo+RTrEcT2r5V+rCysjY/18zSYd5YpH7G?=
 =?iso-8859-1?Q?PnxU7cQXI6wUsvShlJ9Ly1DfVjPzst+WtWfLmJ75vlOa0oPvEyYA5GjIPD?=
 =?iso-8859-1?Q?dAXeLDe2zCNyRh8+ZNUDWN77gkK5Fcsi868HmRi7eQVofRlnKwN/3Zuz90?=
 =?iso-8859-1?Q?gxPZtWjAg92KsygDkKelmmBONQmpEH61dVjjg9k8KPyce+vATcMzq9NNXh?=
 =?iso-8859-1?Q?lPJoPXPQ+wtGWVDoiD6PLVD1xa4KKLvyYabFJsMz/cMczBEuotNq4t5tXD?=
 =?iso-8859-1?Q?rh/IbFcFRRkJseOhr04aE4o4da3mFg5dl090zYEQRELsd/lFm+X13xz+qh?=
 =?iso-8859-1?Q?Y7Tw010mVCYb75QPJFTHgud7mnLbSHty1+hicwoD7dLH5X+xFldwqzolgn?=
 =?iso-8859-1?Q?c5cLwjMp6yXNSPASYfE49yBTMHNgWi6oQBUwEMn9Qy//+PPnxUZq7ExOIO?=
 =?iso-8859-1?Q?Aq1SN+cr8Av2td5grmo=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PUZPR04MB6316800E3E260C6F1DDED59A813B2PUZPR04MB6316apcp_"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QNNdd3r0X1ZMQ2xXy6lWCTMgm06Lfj1xOtHq6bmkNeDKBq5afNF7Im1YQRGYYTABcgzhMwXDFN3rm4SGuzEwPV89kcp9ynjsGJYlHgbx77OsyE6R0sBkFWfTN6KwuZPE4TxwD3DZE//4nxiPqbUWjYs9PjAemMmxnTc8YEaZPLz4y4WVcs5jFDb4xK+fWY9ua5oHdCuPtJapzoS+mJ0KVuTPamiWDr8Yi9gw4DOjwcQMFfKLYEqp7aYOcR8aRlwBcJfXi55tHcY5zofEaxkwVZDeRI0TskOUNGmLB0UbnuUE+IZwqa2P2G68+i44ZpiZIZMyAc4OpGqF7LHu4VGv/Jl9qOjEuEnFrQjAWeQiUYyKgNqU1a2IB0ku8qZgQjYmr0qiYAMKWWalZvedMBkRNHTdsoOwMAHlFVU8upbMO+xD+gWNh/DwvbINF50q1JxfYRnoHnuDzTP1SUCEYAHdh2BXS3A8r0kuelRahM4/im7t+H6qiv2KBy8z6IP6RVLOhgKvgtx+hj0nffOop5k9+rFqFIVSRI3YZSh61XQykjYJ1bYLnA333IH09pHQbP6WsWH5xqBaudReCbnfSCBXzegNrimX2HksdHNurUM6hm1aCsabC+z0cTWIrTzJShYJ
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cd4fc5-145e-41f1-6217-08dd1d9e2ebf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 06:52:18.2451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QrCMDba90SDfT6vlV+ynJQS4BJAucU5sCXe9wWoucKVyUHMWEPbpiUaNIENW1xwLO4sr+pcPsR1SPPy7rP/Ieg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7014
X-Proofpoint-GUID: MIF7afhMTjcpVvKyjVxit7mirqeY_su0
X-Proofpoint-ORIG-GUID: MIF7afhMTjcpVvKyjVxit7mirqeY_su0
X-Sony-Outbound-GUID: MIF7afhMTjcpVvKyjVxit7mirqeY_su0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_02,2024-12-13_01,2024-11-22_01

--_002_PUZPR04MB6316800E3E260C6F1DDED59A813B2PUZPR04MB6316apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

In exfat, not only the newly allocated space will be mapped as=0A=
the new buffer, but also the space between ->valid_size and the=0A=
file size will be mapped as the new buffer. If the buffer is=0A=
mapped as new in ->write_begin(), it will be zeroed. But if the=0A=
buffer has been mapped as new before ->write_begin(), ->write_begin()=0A=
will not zero them, resulting in access to uninitialized data.=0A=
=0A=
So this commit uses folio_zero_new_buffers() to zero the new buffers=0A=
after ->write_begin().=0A=
=0A=
Fixes: 6630ea49103c ("exfat: move extend valid_size into ->page_mkwrite()")=
=0A=
Reported-by: syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com=0A=
Closes: https://syzkaller.appspot.com/bug?extid=3D91ae49e1c1a2634d20c0=0A=
Tested-by: syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com=0A=
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
---=0A=
 fs/exfat/file.c | 6 ++++++=0A=
 1 file changed, 6 insertions(+)=0A=
=0A=
diff --git a/fs/exfat/file.c b/fs/exfat/file.c=0A=
index fb38769c3e39..05b51e721783 100644=0A=
--- a/fs/exfat/file.c=0A=
+++ b/fs/exfat/file.c=0A=
@@ -545,6 +545,7 @@ static int exfat_extend_valid_size(struct file *file, l=
off_t new_valid_size)=0A=
 	while (pos < new_valid_size) {=0A=
 		u32 len;=0A=
 		struct folio *folio;=0A=
+		unsigned long off;=0A=
 =0A=
 		len =3D PAGE_SIZE - (pos & (PAGE_SIZE - 1));=0A=
 		if (pos + len > new_valid_size)=0A=
@@ -554,6 +555,9 @@ static int exfat_extend_valid_size(struct file *file, l=
off_t new_valid_size)=0A=
 		if (err)=0A=
 			goto out;=0A=
 =0A=
+		off =3D offset_in_folio(folio, pos);=0A=
+		folio_zero_new_buffers(folio, off, off + len);=0A=
+=0A=
 		err =3D ops->write_end(file, mapping, pos, len, len, folio, NULL);=0A=
 		if (err < 0)=0A=
 			goto out;=0A=
@@ -563,6 +567,8 @@ static int exfat_extend_valid_size(struct file *file, l=
off_t new_valid_size)=0A=
 		cond_resched();=0A=
 	}=0A=
 =0A=
+	return 0;=0A=
+=0A=
 out:=0A=
 	return err;=0A=
 }=0A=
-- =0A=
2.43.0=

--_002_PUZPR04MB6316800E3E260C6F1DDED59A813B2PUZPR04MB6316apcp_
Content-Type: text/x-patch;
	name="v1-0001-exfat-fix-the-new-buffer-was-not-zeroed-before-wr.patch"
Content-Description:
 v1-0001-exfat-fix-the-new-buffer-was-not-zeroed-before-wr.patch
Content-Disposition: attachment;
	filename="v1-0001-exfat-fix-the-new-buffer-was-not-zeroed-before-wr.patch";
	size=1985; creation-date="Mon, 16 Dec 2024 06:52:02 GMT";
	modification-date="Mon, 16 Dec 2024 06:52:02 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0MGEzMDg2NDdkMDMyZTQ0MmUzZWI3NWFjMWVmMjI2NGRkYTE4NWQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IFRodSwgMTIgRGVjIDIwMjQgMTY6Mjk6MjMgKzA4MDAKU3ViamVjdDogW1BBVENIIHYxXSBl
eGZhdDogZml4IHRoZSBuZXcgYnVmZmVyIHdhcyBub3QgemVyb2VkIGJlZm9yZSB3cml0aW5nCgpJ
biBleGZhdCwgbm90IG9ubHkgdGhlIG5ld2x5IGFsbG9jYXRlZCBzcGFjZSB3aWxsIGJlIG1hcHBl
ZCBhcwp0aGUgbmV3IGJ1ZmZlciwgYnV0IGFsc28gdGhlIHNwYWNlIGJldHdlZW4gLT52YWxpZF9z
aXplIGFuZCB0aGUKZmlsZSBzaXplIHdpbGwgYmUgbWFwcGVkIGFzIHRoZSBuZXcgYnVmZmVyLiBJ
ZiB0aGUgYnVmZmVyIGlzCm1hcHBlZCBhcyBuZXcgaW4gLT53cml0ZV9iZWdpbigpLCBpdCB3aWxs
IGJlIHplcm9lZC4gQnV0IGlmIHRoZQpidWZmZXIgaGFzIGJlZW4gbWFwcGVkIGFzIG5ldyBiZWZv
cmUgLT53cml0ZV9iZWdpbigpLCAtPndyaXRlX2JlZ2luKCkKd2lsbCBub3QgemVybyB0aGVtLCBy
ZXN1bHRpbmcgaW4gYWNjZXNzIHRvIHVuaW5pdGlhbGl6ZWQgZGF0YS4KClNvIHRoaXMgY29tbWl0
IHVzZXMgZm9saW9femVyb19uZXdfYnVmZmVycygpIHRvIHplcm8gdGhlIG5ldyBidWZmZXJzCmFm
dGVyIC0+d3JpdGVfYmVnaW4oKS4KCkZpeGVzOiA2NjMwZWE0OTEwM2MgKCJleGZhdDogbW92ZSBl
eHRlbmQgdmFsaWRfc2l6ZSBpbnRvIC0+cGFnZV9ta3dyaXRlKCkiKQpSZXBvcnRlZC1ieTogc3l6
Ym90KzkxYWU0OWUxYzFhMjYzNGQyMGMwQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KQ2xvc2Vz
OiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9OTFhZTQ5ZTFjMWEyNjM0
ZDIwYzAKVGVzdGVkLWJ5OiBzeXpib3QrOTFhZTQ5ZTFjMWEyNjM0ZDIwYzBAc3l6a2FsbGVyLmFw
cHNwb3RtYWlsLmNvbQpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29u
eS5jb20+Ci0tLQogZnMvZXhmYXQvZmlsZS5jIHwgNiArKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9mcy9leGZhdC9maWxlLmMgYi9mcy9leGZhdC9m
aWxlLmMKaW5kZXggZmIzODc2OWMzZTM5Li4wNWI1MWU3MjE3ODMgMTAwNjQ0Ci0tLSBhL2ZzL2V4
ZmF0L2ZpbGUuYworKysgYi9mcy9leGZhdC9maWxlLmMKQEAgLTU0NSw2ICs1NDUsNyBAQCBzdGF0
aWMgaW50IGV4ZmF0X2V4dGVuZF92YWxpZF9zaXplKHN0cnVjdCBmaWxlICpmaWxlLCBsb2ZmX3Qg
bmV3X3ZhbGlkX3NpemUpCiAJd2hpbGUgKHBvcyA8IG5ld192YWxpZF9zaXplKSB7CiAJCXUzMiBs
ZW47CiAJCXN0cnVjdCBmb2xpbyAqZm9saW87CisJCXVuc2lnbmVkIGxvbmcgb2ZmOwogCiAJCWxl
biA9IFBBR0VfU0laRSAtIChwb3MgJiAoUEFHRV9TSVpFIC0gMSkpOwogCQlpZiAocG9zICsgbGVu
ID4gbmV3X3ZhbGlkX3NpemUpCkBAIC01NTQsNiArNTU1LDkgQEAgc3RhdGljIGludCBleGZhdF9l
eHRlbmRfdmFsaWRfc2l6ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgbG9mZl90IG5ld192YWxpZF9zaXpl
KQogCQlpZiAoZXJyKQogCQkJZ290byBvdXQ7CiAKKwkJb2ZmID0gb2Zmc2V0X2luX2ZvbGlvKGZv
bGlvLCBwb3MpOworCQlmb2xpb196ZXJvX25ld19idWZmZXJzKGZvbGlvLCBvZmYsIG9mZiArIGxl
bik7CisKIAkJZXJyID0gb3BzLT53cml0ZV9lbmQoZmlsZSwgbWFwcGluZywgcG9zLCBsZW4sIGxl
biwgZm9saW8sIE5VTEwpOwogCQlpZiAoZXJyIDwgMCkKIAkJCWdvdG8gb3V0OwpAQCAtNTYzLDYg
KzU2Nyw4IEBAIHN0YXRpYyBpbnQgZXhmYXRfZXh0ZW5kX3ZhbGlkX3NpemUoc3RydWN0IGZpbGUg
KmZpbGUsIGxvZmZfdCBuZXdfdmFsaWRfc2l6ZSkKIAkJY29uZF9yZXNjaGVkKCk7CiAJfQogCisJ
cmV0dXJuIDA7CisKIG91dDoKIAlyZXR1cm4gZXJyOwogfQotLSAKMi40My4wCgo=

--_002_PUZPR04MB6316800E3E260C6F1DDED59A813B2PUZPR04MB6316apcp_--

