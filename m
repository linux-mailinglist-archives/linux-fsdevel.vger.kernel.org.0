Return-Path: <linux-fsdevel+bounces-59776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 779A0B3E0A7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 12:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28AAD3BA072
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 10:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D623101D5;
	Mon,  1 Sep 2025 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RNNde2cq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lhWeblbC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EF03101C2;
	Mon,  1 Sep 2025 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723936; cv=fail; b=dPjiyi7aMok31+XsUa9mOd22JYJ2mjxaLvFvk8MSXH++m6TFDtsK9AgGa34NUHN+IDwD923+WqEJ9RflfvN3VFALtzrhBDJAgfDgMYPBxE5l0LyU7de0gy1Z2cab2rNpJOX6dHIf2QZHTqTDSg9QIR1k1bUd4SK+4zwnOiARWsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723936; c=relaxed/simple;
	bh=DdW54yL+FO8GIBd/2fK6IK3hfQeuAsj0xjs6ArFpUSs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R+VRntrzulgLl28j1dOfoDlUQ0dIFy0W730TIZ21n1JHaGQtBTzilmCxSaEkemvJfCt+p2HvysJBD285eFzjMbQxkwuCL1kCJSMVJrET4ONM/1VsTkBAMk7nZjY1UKxzHoZOytjgcCcP0skWYpRvMeCZKAh/DGgqtMudjhUX/+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RNNde2cq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lhWeblbC; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756723935; x=1788259935;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DdW54yL+FO8GIBd/2fK6IK3hfQeuAsj0xjs6ArFpUSs=;
  b=RNNde2cqWwn4nfE/cMv3fJ6y1tlb1KfX+QDVxwQuPCEArp6sSMyqJWUg
   G3jrkYY6rwo4JYjNtakA5I7s47dBbucz623Ixx+sbWO+vGyC/PLVQ0Khf
   5aOiEVTnAi3gHT4UtCCiaAKjLRAtnIlNriaPr7ccl/AYcSeahZYceDn5u
   LSUIdEjkRlWhQyIupzbhkCxU+bhW3G4xImr0Ussaykdq2Yy+k5rW9tsds
   rn5gs14bsgRwvwlU7JeCvMtit07kE4dA/tU3WTVcH66rVwmnyiF48R3Cf
   0N1+n7xRJOmHrVL3cuXVLvo/N39PRSnjdTr0FF3OHsrohU64dwedG3kNv
   w==;
X-CSE-ConnectionGUID: zr+eHh7oR9iqbNwgGueRmA==
X-CSE-MsgGUID: 68+VYS1dT4C7kb0tYvLMZQ==
X-IronPort-AV: E=Sophos;i="6.18,225,1751212800"; 
   d="scan'208";a="106132137"
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.62])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2025 18:52:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suqFu1XHUgNCjhz9D4JiGfoX7POka6smyZJqJ0kMBEfnehYrG//X/TnYSN67u4aaqMHrrPN8rjqmT/Yk9PvXFmxjnPwbqsD4r2NQ5BghcyIT7WY5l1w4oRAUBC/MiYGpkiVI8JgkPg7iteDdhcMQReeaG6QtCgc6FDS/RJy8xDEkznZGvf6Z8DZWGloduGgbcQTpIo+QSD/4tkDLkBeRCEc/yywQkXhEY07jTXunOPAssviPiFR3IDbUqHf5xByNOd7/npRM5RTxuBm4XRWlhh2wuVKIEOSYxc7lCrk3WddWXsPk10w+adakdIfks1++4GB0zP9rN91UIh4dNo+LbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBm3fxSsUX8Jl5/M7fiWy+1X80OHo7ajLHV5J2LW27o=;
 b=kHnedj9NAcQLOZuo0SbdIs+wFGz1d1RAJ+CvLbyCHZc4H3kzYHJ9wYqhSpB0cwUz//VZ6qdmv+s+roZQjJIrJESSKWurHkAoH7tzMA8kEyDBkkVLO8hAQzevJ7XiZF2H6Evm9EZRcuuCZvBVgPv6ew6qmiUdx3vPh9e3CWI48c9rZhOow+aODymx5bgDZCOlyO0zU1tCmoND3CnvtWPztbMuF13Btr0d5m8C/P5oa2LzA67s1mChA0pnJLTTfMZnmZqqLNvIOeNATVzRZw6aOBmfFj2cK8o94NaNCTzme+dbG8ge00tvBJU+VuR+jx5Zy92v1nQOSDNAmUg6XIb9cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBm3fxSsUX8Jl5/M7fiWy+1X80OHo7ajLHV5J2LW27o=;
 b=lhWeblbCRIu4zsZMlSIHZnFmLNtPpuznZ6djb1ryOs8mr2kB8fxu4ZRZ6EZnqqz8qQ35SqdpvzNcQZD+SImi2fNfOuawTIUNrOfUD6t9yISqaXKoi6wnCpYIevpjZXpeoFlqb7LoIEpmak+mIpxPx0DxV410f+bDSKt5benfI78=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by DS1PR04MB9234.namprd04.prod.outlook.com (2603:10b6:8:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 10:52:05 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 10:52:05 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
CC: Carlos Maiolino <cem@kernel.org>, Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>, hch <hch@lst.de>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>
Subject: [PATCH 2/3] xfs: refactor hint based zone allocation
Thread-Topic: [PATCH 2/3] xfs: refactor hint based zone allocation
Thread-Index: AQHcGy503kPauXE4fUSx6W9oIULQGw==
Date: Mon, 1 Sep 2025 10:52:05 +0000
Message-ID: <20250901105128.14987-3-hans.holmberg@wdc.com>
References: <20250901105128.14987-1-hans.holmberg@wdc.com>
In-Reply-To: <20250901105128.14987-1-hans.holmberg@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.51.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|DS1PR04MB9234:EE_
x-ms-office365-filtering-correlation-id: 444f1bea-c460-430c-fbf0-08dde945971f
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?S5XTqyn93Gpdooy6oe+mphZUuSQUSMM5GdyclLmjPbk1uIKSmrx1ncPjJt?=
 =?iso-8859-1?Q?dCLTZZRj22EQ4uUXM3RZGYSOTJg4llze2IytFt4f1qpNBqsRiZdQlxEuw0?=
 =?iso-8859-1?Q?ce6w+Xj8ydHLkSO5SbcP1LcYhNchVIvremy1KKJMKxEJjWaK5PMwqQWIwD?=
 =?iso-8859-1?Q?YjHGDKWaC8O2iPFUupsvspJo86eNeNRS94eAKXEDZnA6uwNhNT0dQcSNqq?=
 =?iso-8859-1?Q?iR1GfG+5PsdYHL57A7F4zyQh+HLIL5SMEoKt/BUP86RscLMvRpWGp0v6ay?=
 =?iso-8859-1?Q?aRotiIyg3gIFHDk/rg8LyNGG+piPy4ajvbCaT8+KvVfenwNDjU8rf6RUU3?=
 =?iso-8859-1?Q?aW00HEXUq6UIh3nvI7QJaY3t5i3WafuM10/8Amr3Kv7m0V+ibGvkfNKaUe?=
 =?iso-8859-1?Q?QURS31Hi7iKUPdbY5zq+rIO0o5VOjaApK0MGupM5vslzrEqQOjDFkZtrlw?=
 =?iso-8859-1?Q?mY4nbS33i6/LD3AUrcjYD3aPWn/szI+9nZFvn4Zkubr7kPQIgpn7wwGDu3?=
 =?iso-8859-1?Q?THa1MZvu5oOzy/UKimYxwVb7cX/A+uN+nUYUmqS73f1p5xArintw+9r7K5?=
 =?iso-8859-1?Q?/32pbrrLFU1tdN7Z4krjjI7mFi3sUHnMDWqCLMCB6aCy8lDYhEuknPXOma?=
 =?iso-8859-1?Q?XmBnrMF3uO3e269aIM3BpHAVZH9Fu1SvpgWvdK0F5icWlKzsS6cZubg0YS?=
 =?iso-8859-1?Q?2tfijVqgz/MTsNH7bYY3imqK+5uh0+RH+IRhgLRQf+anaffRxHoCZLWO4R?=
 =?iso-8859-1?Q?MnWAEPpW7sUWEXaQvGb5fOf1ieKVzeOd3GPgWgeRF/hK31rYDV4frLYTyB?=
 =?iso-8859-1?Q?U+LSLcr72UC3KiWkXm9aVtsoAuxCsRhbB1h2VfUfoWq5rwJLmRWnEoiKE7?=
 =?iso-8859-1?Q?OY4DfWtCV5eaJ9EshWC4FDy0QhAhBUELSrMG+5DqWccbH8FzpR0FXY3cAh?=
 =?iso-8859-1?Q?SXPbAD2Z8yTwIsduAa3g9kv2f4z/PKAH+LUEie2s29k+1FSZtF5eOUZZGG?=
 =?iso-8859-1?Q?A+SKcwQu3+M9pzgDAwjDXioVRsg+TKzi+D8z9s+KW3n3MYYq/i5GhvDWuZ?=
 =?iso-8859-1?Q?6aSzrBx1wBBiAJZC3l5Q7OXZd8Ky0lrKv6BAuTD6YJK9Do1FAAEC+FpKFB?=
 =?iso-8859-1?Q?3/gEkWAw5UtA/8D0pB1zIScWNP1+OZMe5tZgnWJ5GTE9dqGPjjW2SsMJ6S?=
 =?iso-8859-1?Q?U2SWZE/l/muCO9ry0DLBv4CG1g+Ksr1j4AEXtNeV91MYAo/taZmFd+fVEM?=
 =?iso-8859-1?Q?hEPEMkDloHN6U0rO30a+zOPj7QrRAXjE44S4ohl3V6eQ6bK8PsJMo2mZ9n?=
 =?iso-8859-1?Q?SyFSHx1HIruNYaK6SiloK1zrAXjrgVlZ6oLjGHkut/hg4srWpjVsKiZtRZ?=
 =?iso-8859-1?Q?ytg6k/V/fs8MYJzt0f4LAV22O+8IzAAmktYsFlIa6N8KoI76uF9vDzdEPd?=
 =?iso-8859-1?Q?rTwrAhu2pMVjn/9Z6Y9C+nadyLlHNdZh4fB3f+xVDO5KsXsNah5MchdQrf?=
 =?iso-8859-1?Q?oAngsYvcfgIJ5o/mk5JaW/j933d1y1PVJnn+RHSXF2Xw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?FFCLoTdfDXS9ZHrzYp4LTnW5IODAzhydiSTSx9s995g7BSMkYowG+2V57b?=
 =?iso-8859-1?Q?PnQVuARHhq3hyv7BnW4xdbVSiOCXbWuMEnLeLYX45/3tCs6DVn8+o3GmIe?=
 =?iso-8859-1?Q?TrkYKZf14QZojnnBLOwva7SMxmjBdFAJ65Ve0yDFwdlbD063RQHzpp/9yU?=
 =?iso-8859-1?Q?gbBrpxtAmzKY9EedXl7UFuB/w46GzQukzfhT9MmZ8wWtAB2eCJ2aPuZkHI?=
 =?iso-8859-1?Q?Ej+kx9e5LNWSnvDC3iTVoEL+B/HBZ5Mcxs1BNCBeD0ZKXWWo2oFvkA4QQv?=
 =?iso-8859-1?Q?loCc6+hlW/hCmZi14H5yKaupy82ceMgMiEJNsUzhzqBR/VTKzf8zxyc2+A?=
 =?iso-8859-1?Q?hENDY27J/HL4PRMQ/UsvaRs5OTD8/BTjO9jkUZAyBzWR3caN/ho6FVn7rF?=
 =?iso-8859-1?Q?m7srGHXnvwkMz1KxMFz5kHffQVvuILol9dTMZ/6tZ08iwBNg6vmLT+ad7S?=
 =?iso-8859-1?Q?ps0s/rT4Wwlw2Mjc0Uq2Murm/AToslPlI1LVtZdZfworrxDNh66Kd6hr7o?=
 =?iso-8859-1?Q?4o1rRNWWSaKtGjr0KwadUvL591drl2iete6qqdDOENb0llcGz98bkCHIYf?=
 =?iso-8859-1?Q?LKE5xvJubhbJShC9x7T9QndgpHCB4Wi/JZqRPS/ov+YjTmnDZoPUrvY/cG?=
 =?iso-8859-1?Q?gUggIGRo0uQ0OZYqjIyy3qR2qRc3HfhoBj0Bv4huVvyN/Gkrzs+uykp32h?=
 =?iso-8859-1?Q?1zJ8Sw9XDTKloah2FWmEbbwTXJKzLBiv0ZDKzWRvT8dbeIU+uBZHbnGdgw?=
 =?iso-8859-1?Q?M208P/K7QIxLgxvZmICTVDdcwl6DrFFCqf7xgyhgj32mlrFpL1fz3YYqQV?=
 =?iso-8859-1?Q?OmHpQIupWgxCdlgV5We+66iT2L0VIlbKfHmzw/F49K+pOJaWYRVUP51Zqh?=
 =?iso-8859-1?Q?WcWMkezZtTZlbM4nW1LPeJS3og4NhNQ2lo2fwPEvNDt6yQNjivx3313Ors?=
 =?iso-8859-1?Q?7shjwHrz7NA4G6mIBtzhHUyXVWbUoVC6qRgXkA8o5VKWVEd+khqExmdT+8?=
 =?iso-8859-1?Q?ib9MkFwoyUrejZUdA/UyHg2ZV4E9puSx9q3gUOSMTdu90UbabTf9YcjwSI?=
 =?iso-8859-1?Q?scLrH3AjB6O9BZTM1KPK9tGFl6VgeYCMt0ltus3RmqZ3BvJOZAqWXD0OEh?=
 =?iso-8859-1?Q?utG1PXEmN9tDcPSkiwBftRHK+82McOB/hvFeFNK7T1LUE5YA10GVqEWRI6?=
 =?iso-8859-1?Q?q0sTDpz59ANzJbVi99IuclXjUWvU/uNFAuUK75UIe9GcIWgTy905/dXMgU?=
 =?iso-8859-1?Q?qbT0VbPbc30FV9HYEOJa5O8zA8BJvSmGofEXYqDy1AHEcZVC+sx3CMHDFX?=
 =?iso-8859-1?Q?P9vSAdRBW0NNjyFTvBvQFdNLQBSCGb05pJHW3lF8MkHNo7k5G1P97Hw1Ep?=
 =?iso-8859-1?Q?CixBsKFU4q4AWNOsxKDdFmu7NQKRFFkvTjw365+skBWDRHm8yAvOiVCD3p?=
 =?iso-8859-1?Q?QaF3ZCeUuzi4VOfBHQTRt6XvBrmRPIdyw0YnBHRRkSXJVbiLYaWjPKPydi?=
 =?iso-8859-1?Q?7vD7eq1rMvFvRjiDkPwHlbCKz0ZfT3DXF27Qsj6H1p5drqlBG87bVecJoX?=
 =?iso-8859-1?Q?ct3zgTTilufl3YY/dVMkpFG/qpIT4dK+1Lt6YjxIYiGGbKDTgRO8cQiitX?=
 =?iso-8859-1?Q?NDFjFB2LOXs4eGsasHLsEcIo16WkohuYM3pO3kRbydulmefttsmumaAQ?=
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
	JiOl4f//Ko4QUEyTYK464K2aqGFLwVCpiWerfcJe17Xgwa+Vf9kY4S7Jq/ASkTcUQJV1tpu+8LLZdI+EcJtxE66b1z+G0aqrB8OTWM6P2Diituwx2p/k4gmuWS03QV0P/3hVkwyzN+dW1heFzOkf+MnBrw/SOk753oz7/EzQt1hi9ykBYMyr5EiDc6owGwTpB08kmvx2t1JffDL4sjjFi2j/cLkCNfJF1MsXtEv3n/zp6XoPLctM1Ar5Y7bUhiR4l4v60DAoEJr9anFQwGIRXXbhfMXlGv78/JEAnMdedNZkXeKHeDDYQ67a0dnVUookMzKZZSbT9JZ7m0d63RpKzxDwHUJMm3yP+16De0sGjRY1JCPHWIfjCt8w5Y29f0TMzN3lwd8yMyg8CK4tt/bxG8LG+RaOiM0x5Gq+sRk51RH85VslQawUAFE77c0sk1UZNzY07zEL7HsVBUv8aolux8A7kzCQWqgG2lkC+lXM2GpMDq8i7jTSUF2SEwunwMxpIgSkSgU6zaVoP+rKoCZqoSCxfWhfN//KlYI/K85+y8IrZX0GVCn1AeDbTeolG4dZZOyWxIK/uruNXTU7l6PqvOl3B0SusFT46kaD7zspoFnHJGLz0Pt/Z17BN1d+p96O
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444f1bea-c460-430c-fbf0-08dde945971f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 10:52:05.3839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VsGi/Cy2UiKRUkAZ48BC4cR2Vj1kZoWKA16w7BhDzP35QraziEgwejjMg0Xs7tukdKWYNNVaPN6Mu41qn4y4yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9234

Replace the co-location code with a matrix that makes it more clear
on how the decisions are made.

The matrix contains scores for zone/file hint combinations. A "GOOD"
score for an open zone will result in immediate co-location while "OK"
combinations will only be picked if we cannot open a new zone.

Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
---
 fs/xfs/xfs_zone_alloc.c | 122 ++++++++++++++++++++--------------------
 1 file changed, 62 insertions(+), 60 deletions(-)

diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
index f28214c28ab5..ff24769b8870 100644
--- a/fs/xfs/xfs_zone_alloc.c
+++ b/fs/xfs/xfs_zone_alloc.c
@@ -493,64 +493,64 @@ xfs_try_open_zone(
 	return oz;
 }
=20
+enum xfs_zone_alloc_score {
+	/* Any open zone will do it, we're desperate */
+	XFS_ZONE_ALLOC_ANY	=3D 0,
+
+	/* It better fit somehow */
+	XFS_ZONE_ALLOC_OK	=3D 1,
+
+	/* Only reuse a zone if it fits really well. */
+	XFS_ZONE_ALLOC_GOOD	=3D 2,
+};
+
 /*
- * For data with short or medium lifetime, try to colocated it into an
- * already open zone with a matching temperature.
+ * Life time hint co-location matrix.  Fields not set default to 0
+ * aka XFS_ZONE_ALLOC_ANY.
  */
-static bool
-xfs_colocate_eagerly(
-	enum rw_hint		file_hint)
-{
-	switch (file_hint) {
-	case WRITE_LIFE_MEDIUM:
-	case WRITE_LIFE_SHORT:
-	case WRITE_LIFE_NONE:
-		return true;
-	default:
-		return false;
-	}
-}
-
-static bool
-xfs_good_hint_match(
-	struct xfs_open_zone	*oz,
-	enum rw_hint		file_hint)
-{
-	switch (oz->oz_write_hint) {
-	case WRITE_LIFE_LONG:
-	case WRITE_LIFE_EXTREME:
-		/* colocate long and extreme */
-		if (file_hint =3D=3D WRITE_LIFE_LONG ||
-		    file_hint =3D=3D WRITE_LIFE_EXTREME)
-			return true;
-		break;
-	case WRITE_LIFE_MEDIUM:
-		/* colocate medium with medium */
-		if (file_hint =3D=3D WRITE_LIFE_MEDIUM)
-			return true;
-		break;
-	case WRITE_LIFE_SHORT:
-	case WRITE_LIFE_NONE:
-	case WRITE_LIFE_NOT_SET:
-		/* colocate short and none */
-		if (file_hint <=3D WRITE_LIFE_SHORT)
-			return true;
-		break;
-	}
-	return false;
-}
+static const unsigned int
+xfs_zoned_hint_score[WRITE_LIFE_HINT_NR][WRITE_LIFE_HINT_NR] =3D {
+	[WRITE_LIFE_NOT_SET]	=3D {
+		[WRITE_LIFE_NOT_SET]	=3D XFS_ZONE_ALLOC_OK,
+		[WRITE_LIFE_NONE]	=3D XFS_ZONE_ALLOC_OK,
+		[WRITE_LIFE_SHORT]	=3D XFS_ZONE_ALLOC_OK,
+	},
+	[WRITE_LIFE_NONE]	=3D {
+		[WRITE_LIFE_NOT_SET]	=3D XFS_ZONE_ALLOC_OK,
+		[WRITE_LIFE_NONE]	=3D XFS_ZONE_ALLOC_GOOD,
+		[WRITE_LIFE_SHORT]	=3D XFS_ZONE_ALLOC_GOOD,
+	},
+	[WRITE_LIFE_SHORT]	=3D {
+		[WRITE_LIFE_NOT_SET]	=3D XFS_ZONE_ALLOC_GOOD,
+		[WRITE_LIFE_NONE]	=3D XFS_ZONE_ALLOC_GOOD,
+		[WRITE_LIFE_SHORT]	=3D XFS_ZONE_ALLOC_GOOD,
+	},
+	[WRITE_LIFE_MEDIUM]	=3D {
+		[WRITE_LIFE_MEDIUM]	=3D XFS_ZONE_ALLOC_GOOD,
+	},
+	[WRITE_LIFE_LONG]	=3D {
+		[WRITE_LIFE_LONG]	=3D XFS_ZONE_ALLOC_OK,
+		[WRITE_LIFE_EXTREME]	=3D XFS_ZONE_ALLOC_OK,
+	},
+	[WRITE_LIFE_EXTREME]	=3D {
+		[WRITE_LIFE_LONG]	=3D XFS_ZONE_ALLOC_OK,
+		[WRITE_LIFE_EXTREME]	=3D XFS_ZONE_ALLOC_OK,
+	},
+};
=20
 static bool
 xfs_try_use_zone(
 	struct xfs_zone_info	*zi,
 	enum rw_hint		file_hint,
 	struct xfs_open_zone	*oz,
-	bool			lowspace)
+	unsigned int		goodness)
 {
 	if (oz->oz_allocated =3D=3D rtg_blocks(oz->oz_rtg))
 		return false;
-	if (!lowspace && !xfs_good_hint_match(oz, file_hint))
+
+	if (xfs_zoned_hint_score[oz->oz_write_hint][file_hint] < goodness)
 		return false;
+
 	if (!atomic_inc_not_zero(&oz->oz_ref))
 		return false;
=20
@@ -581,14 +581,14 @@ static struct xfs_open_zone *
 xfs_select_open_zone_lru(
 	struct xfs_zone_info	*zi,
 	enum rw_hint		file_hint,
-	bool			lowspace)
+	unsigned int		goodness)
 {
 	struct xfs_open_zone	*oz;
=20
 	lockdep_assert_held(&zi->zi_open_zones_lock);
=20
 	list_for_each_entry(oz, &zi->zi_open_zones, oz_entry)
-		if (xfs_try_use_zone(zi, file_hint, oz, lowspace))
+		if (xfs_try_use_zone(zi, file_hint, oz, goodness))
 			return oz;
=20
 	cond_resched_lock(&zi->zi_open_zones_lock);
@@ -651,9 +651,11 @@ xfs_select_zone_nowait(
 	 * data.
 	 */
 	spin_lock(&zi->zi_open_zones_lock);
-	if (xfs_colocate_eagerly(write_hint))
-		oz =3D xfs_select_open_zone_lru(zi, write_hint, false);
-	else if (pack_tight)
+	oz =3D xfs_select_open_zone_lru(zi, write_hint, XFS_ZONE_ALLOC_GOOD);
+	if (oz)
+		goto out_unlock;
+
+	if (pack_tight)
 		oz =3D xfs_select_open_zone_mru(zi, write_hint);
 	if (oz)
 		goto out_unlock;
@@ -667,16 +669,16 @@ xfs_select_zone_nowait(
 		goto out_unlock;
=20
 	/*
-	 * Try to colocate cold data with other cold data if we failed to open a
-	 * new zone for it.
+	 * Try to find an zone that is an ok match to colocate data with.
+	 */
+	oz =3D xfs_select_open_zone_lru(zi, write_hint, XFS_ZONE_ALLOC_OK);
+	if (oz)
+		goto out_unlock;
+
+	/*
+	 * Pick the least recently used zone, regardless of hint match
 	 */
-	if (write_hint !=3D WRITE_LIFE_NOT_SET &&
-	    !xfs_colocate_eagerly(write_hint))
-		oz =3D xfs_select_open_zone_lru(zi, write_hint, false);
-	if (!oz)
-		oz =3D xfs_select_open_zone_lru(zi, WRITE_LIFE_NOT_SET, false);
-	if (!oz)
-		oz =3D xfs_select_open_zone_lru(zi, WRITE_LIFE_NOT_SET, true);
+	oz =3D xfs_select_open_zone_lru(zi, write_hint, XFS_ZONE_ALLOC_ANY);
 out_unlock:
 	spin_unlock(&zi->zi_open_zones_lock);
 	return oz;
--=20
2.34.1

