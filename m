Return-Path: <linux-fsdevel+bounces-78659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PAEJoXXoGl0nQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 00:30:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D85CB1B0EB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 00:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF1DF308301C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 23:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723D8329E4D;
	Thu, 26 Feb 2026 23:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OC5KN/rx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1C22E0B58;
	Thu, 26 Feb 2026 23:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772148583; cv=fail; b=sHg2/4bvYZp16IFcxxQZS03fVpxGntu0DAl8ZB1y6zFkLw+/io5TZgx2PZSr/ngC83XFDcALy2cv/jPZ+qX+972N0/b3uOHg0F2+29Qk4ZLkmG2PEqiwtWlX1L/lQpRmNgM8MMRsriTd/EfKhHMrcvn/yDzdrRDDEm2SNC52e2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772148583; c=relaxed/simple;
	bh=No+XPJNm9tL1wggh1AL8K9ZUHyT072kAcGZMi3HySCE=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=av3F2nJqZabi1CELvRNSonWbnMJTx17lz9Qbp4dEiKFdvJtoUitmSvI22nIeFsdzy4+lhjFGXljm9kWND3MWMy4X2u7hTEsCLbgZK2vwMbipndyeTu4lx0i99YJyFj9e2s2o8PsxYCx2mMSdMW7Qrm5sLtTP2Q4ni/75EcymyN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OC5KN/rx; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QI5lCP961544;
	Thu, 26 Feb 2026 23:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=No+XPJNm9tL1wggh1AL8K9ZUHyT072kAcGZMi3HySCE=; b=OC5KN/rx
	9LdYeRPQCp/M+plcFxamM3iWclc2bnYxt+2Lcg2Txvf/mqrJWJIDgIFfQz/fo/PY
	oMT7BI+hpPI3Cv4npolyHqiliYCr5X+ICC4zSEVcAs1blOBhTz35a3iAhZTCXjhg
	Nkol9C/KHt4bIY/Kzk/s5n3U5Fr1EkkPxfXyj5uNshS4XhS2KQj2Hs36aYI0or1f
	dhS4n8HOJZGZJO6bgWxNbB+uNeka3y5ZAAkbpAXpRVqnk01ObQ5LtBXVM2E5Q66t
	xolNcTrxVRGm5ejmbnGbjGqnwau+Cm3bh/C2Wu6PP1XPFBogdR2KF1bb8TLEhJZU
	rQKzzdw4ZcNFtw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010012.outbound.protection.outlook.com [52.101.193.12])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4cr9n5v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 23:29:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3qj9Z9A9EGfLYtcpIvQylfjm+5fe2NUOFLJRqav7yZPoZCahKsuNo4KmF93y+rMdCh5q3grj9ySu1qa2eMTO9Tj0XEgkKMWMYTMuLZBUtYBrAb3YsC3RLvfowPBlZsmHo8BPo4MKR5H1QMf53SmlwzoEnyGR8ocyezCf7TDwlzfX4+iISJmlqYGYyL6GU6FDvdR5Bwxvjma1ImNwGZDcUvKaGKR0U16Sb+7HkVWn7g9SoNuHqAXs3wRBOK9uaEToXzoH29tF1ttcR2xjXHCPD/MwlfO2kFNFGHshWNpEhVm3IiAEhwCDxQYQmvf5qvz/jCRtfARgtg4+1tTsdxM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=No+XPJNm9tL1wggh1AL8K9ZUHyT072kAcGZMi3HySCE=;
 b=AUkDqYSYKhs3PyU+4NUJJNasfwODPaLDaqtQgYkvQlOYTfyqhYFoOqwqEwBZWXXPAulFzpATXgVNkyqV1rPc2sbaQSvVqPB3rsCZH8zpsGIcA8Ppkxx4RrLKeKQAlpimQ9ujtkpsxBSBWsL5LsrrLECiMBZX855gMfgmkk2s0Zl2vHRD92VxJgfr1SsOtzjSAeNU83NKSuW+E0XdouXjU5Ctq7fSXlf3acI6Yd+j0cG/lbzbrxiF0oHxmhUODBqM/mrg2cVggEcEmY1WkETWdk6q0PMK1iZBGAwjN2DqseN8ZcCxAmk4H1G4eO2XGSZn6dggnmnuFxt2uXyotoVeXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW3PR15MB3964.namprd15.prod.outlook.com (2603:10b6:303:43::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 23:29:26 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 23:29:26 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "shardulsb08@gmail.com" <shardulsb08@gmail.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: "janak@mpiric.us" <janak@mpiric.us>,
        "janak@mpiricsoftware.com"
	<janak@mpiricsoftware.com>,
        "shardul.b@mpiricsoftware.com"
	<shardul.b@mpiricsoftware.com>,
        "syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	<syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] [PATCH v4 2/2] hfsplus: validate b-tree node 0 bitmap
 at mount time
Thread-Index: AQHcpwDmjIXiwiu7oUOE97Xr6xeyh7WVoXwA
Date: Thu, 26 Feb 2026 23:29:26 +0000
Message-ID: <5deb0aa2971a6385091c121e65f0798de357befd.camel@ibm.com>
References: <20260226091235.927749-1-shardul.b@mpiricsoftware.com>
	 <20260226091235.927749-3-shardul.b@mpiricsoftware.com>
In-Reply-To: <20260226091235.927749-3-shardul.b@mpiricsoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW3PR15MB3964:EE_
x-ms-office365-filtering-correlation-id: ee0e9699-570a-464d-c3e0-08de758ee1db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 2n8Muvg9TDE56yYb3RnMGjXHzlevAl/nni04gbaOkhJhJFQ5iJ54bRz6QmCkp8fdQ/Zw6Afwd9g7UF2J+XR9n5BtHz4ARc7cYjVS0C/Y+U0CxSg6rl0kwSE0X38tM+qb9h+mq4iU7P+mSmzzexXMUC5EsQhrJ0UIWkwMGibv+7mFb792fpXNGJcciiRmHTiLJIzH7SkhNW5V0XzOcQm+xmLICftGKtWA1zoSDS+lvlZ8z1q8YEKZaRFC6hg6kOV69fJmNBwu2KN4MORUBBl820sr3gZzo065orc3JIbxVNdPEDVqh+4QRo/pMDGvTPNrEBV5M5sLgWkS0LO4iS1VNSSjpdluWhd7mH0CkpKvMRk0dUSjsAr6idIlby9JRv/jHxGQtssyOim/QjqjacMmDXqnyzE+awO2aNJjpFSf43kINi+iz/wAsK8xWMTHckURoGjbkhNwfd8IaHw2+jQcgruzkDWOgNInFXLwwXHOMMvizBI4e8DExuz9EMdeoBKlaCQXFZ7yWnrFbOhUxTCRUc+5mU7Sp3MUIrmSwbDGZIF0LXlrpibvrdRPAkps1XQlm/uocuNBip0clHrpwoTnrPb6ohzU/qg76YT+dy9LdSIu6zLecBSZ5GjTV1BTaOo929zhJjlqk6dUFiDSLNvzGkb2+Kko40uZwTtnPBlQV2dZoTN5W4kk34oRvtEM8QyK1u9o67uplpBLu2EE6rrJH0AqI1dPfRD+riplmhF8vr7fV2n1yLlNHZiaSn0zM00u
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0RMY0lQTUZIYjdTelREY0cyQzBBSjNMMzQxTkdoVWdTZ3cxa2t6aUUwZmwz?=
 =?utf-8?B?MldBRlM4MkNzeFMrdHk4WDd1K0duRUtBTEwwN1FYYkRqNEhINlROM1VuVklh?=
 =?utf-8?B?REM2bVEzM1J1b1I3a3gyditJL2h6Qm5KUzBjaVQ1WTJhdlpzZGZSNER4dktS?=
 =?utf-8?B?dXgzbUlJTXZmV3NYOUpQT0M4NjJHMTUyRDlkQVY2M2RVRC9CeGtKS2t4c2ls?=
 =?utf-8?B?UzVQblcrNlNFZTlaWEl3dUs1cUoydlNFZ1pBTmxZdGxxdzNTOVZnY0s5V3pi?=
 =?utf-8?B?SEpVQ3YzSVI4ZWtoaVMyOVZHeVo5dEoweWZ0SnRieGliUkptbXQzVFdOTENS?=
 =?utf-8?B?QWpYWHdlbzNMZ2k2YUhNNVpydUZwQkRVZ21nbzVXMGFSa0ZpQlpXdmFlMW5z?=
 =?utf-8?B?WXNSa1ZadzU5SmQyeXBYZFR5VFBLMllyWVl3dGU5d29UWXBTSGF0cG9KWC9S?=
 =?utf-8?B?SkorZzZhL3hCTDluZXM3M2lHckdDdEt5cEJVRENpMG1kOXVNNmNzb01UbFpR?=
 =?utf-8?B?WElxRW5VRnpxUzIrV2xNdmVQcklCT2czRU9wS1FSL0FpZjhRVFBpbXFvMlpm?=
 =?utf-8?B?NHJHTThyZnU4a1lxaHV2eUI0QUtDWHNYK1lLYzVuZTYrekVYKys0V1pzYTV1?=
 =?utf-8?B?RUpzY0tzYS9IKzhtUzQxMVpyUVY0L2ZFdCswSjZHRDkrNXh1ZjZVNlNUa2Ju?=
 =?utf-8?B?VDBDSUpabnh6SFhjY3lFNm85bXAxWE83NkdiOEh2cHlxU0tJaldGYTY0N0Nl?=
 =?utf-8?B?cWdQcjd0SWZrMGQwRklydDhEVmd0VnBmT2d3WWZUZC9FOUswTGNEMyt0UUFo?=
 =?utf-8?B?THZ2cExselRza1FWbnNGNEFGb1RKQk90NVdGRkd1ZFRhajB4a0Zqc3UrNjM3?=
 =?utf-8?B?SldkSkR3SGZzdWFqRHZxUjkyd2VBeG1FNGZoakJMWnBIWExlaFFvQnhSVENz?=
 =?utf-8?B?Tkc3MVQyU2hmakFoWGVTRW5oNG9Tbi9lSUswdHVqRGc4a25XN3BXdWZKSm5R?=
 =?utf-8?B?aW5XajNkaml0ZE9XLzNTU0grVThwK3VFU0pOc2RVWGc3RzJ0cWZ4VThocEZa?=
 =?utf-8?B?bWE3RlFoNWkxUnIrQjV5VzdzYTNyQ2ZPSmlzajhNNFVBTnpLOEk0bW10Mjl6?=
 =?utf-8?B?djhvOERPSmg5QnYyWTlXMk85c0wyaDhmYUtGQmhwSGFnTkIxVDluNGhkTzd5?=
 =?utf-8?B?aUJCejQ1Sm1WK04xNzVKNG1TdWo3VFhaWWN4VXQ2cFRSNnd0Y2VtWXRtdFFw?=
 =?utf-8?B?RnlqNzBMSzJSWDExYVZxcjE5STdpSHJaeU9GTU9JR25JOVNXWkZnV1NXaWpY?=
 =?utf-8?B?UDRIZ2dyK2pNbyt6R2YwUWxIQ0ZtdEN5ZFpnUzV2UTlmSEpFREpGYllkaFp6?=
 =?utf-8?B?T09zMnVxdnk1bHEvK2duUUlabHFWOW50Nk1KSDFzbHFyazJBb0dBWGZDZnVm?=
 =?utf-8?B?aFBrVVNRTDhNVXl5T3owN0tXd25QTHNuenhSVDF2bm1ZMmdFZGJDL04zc1FV?=
 =?utf-8?B?bXFKSnNGR2dDb29nQ1orL2R4a0NsUDUycGh3L09PbXlFRnRXZ01GdzRqUXZT?=
 =?utf-8?B?YU0xUFNwT25KcDVaV2QyK3BJMnZFSktXeS9JM1ppQkFLQ0pLOEc4OWVKYmpK?=
 =?utf-8?B?OFFCWjNZdUkwM1lJQlZ0LzdFT0s3S0RKY25jdit3OVMxTVlpZi9DRHZtejZG?=
 =?utf-8?B?Q0RSU1I0WnhWQVh0QmdlQ01sWkhwZjZzeXJhd3ZOcUNlRXhRRjU1WEZyNzQv?=
 =?utf-8?B?UEtlV1lBNGNXaytxZk4xWUNLZ0NJQkd6dXZxSlVINVhPc1JTTkYzQjFZVHhR?=
 =?utf-8?B?N3ZUdHBzR242SUVkMTdEL3RsVGtORUc0QlZ3WGN2WmZLQ3AvL1NxMUtLdGhl?=
 =?utf-8?B?b3ZWUm5pN1hlOU5zcG9KRVJzZlNKMzRrTmNHL01WSWR4ckxZS3JEdEdtbEhu?=
 =?utf-8?B?NCtuK0pGWFpxUXNXTFBUT1FIVW1wNndzbzBLRUNHUEZ2SVJGQWZGU0pWZElR?=
 =?utf-8?B?dVpyd3hGMk9EREJPUDBOM3g2YjFCeE1Ub3BTNy8wZFZQK2Z0UU1rN2MrMHNa?=
 =?utf-8?B?ZFlNa1JueVVsMkF5YW9jc2MrQmozS051ZDZMdUp2ejMvM0xadE9DSDFiSzha?=
 =?utf-8?B?ZVF1Z0pUZk1IWlR6bUErb0tROGc4am9URGQwUDhVNFNuenlXMSt1bktrRnJj?=
 =?utf-8?B?eGpTK1JnYmppVStrZzcwVUhTZEhLaUk2WDlRcCtkdDVvbjVGU0tEbDR6cEk2?=
 =?utf-8?B?dG9rM0UyZVlWR2JHU3pmY1hpbi8xU0thczNSRTZuNEdoL1ZIeU9iUzdkdlUw?=
 =?utf-8?B?N0kwcWxZNEVrTzh6SHI5NkhZRGNsMmpvTHJ1WE5BS0pLMHNtYzByU01ydjBs?=
 =?utf-8?Q?UYeQu34MVZi+/Cbt/V70yiKn1W11BNwarDf0p?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0276002A7A66034D8BD1A1B0671F53C7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Xhr9Kad1QvoWFf/hfvBlHGskoACMjN/7UrVuZwFN2n1LCdSK/4M+OlXoWMUyIvTfmk1C7p39dL96sb+MuwK7aSm8qoyQn7m3XSovXNWXeWeGMU+uincJ8SvCf1U8VBcM8kuoW0hw/CW8flSOuvjSi13+wo+Z0hHEy+JED/HjNV0l0z87JUbEuIFXJe3XVB0lWKd6Z96/8euYtPhqQC1YZxsPTymlUP/V6rdESgoHtllgdGpWhUToQvFUHrkT2KNtYIb9U+aJ9SaBdA2bEz9Oe9vjsVtJDDS3HBrQnOrZNEBS45n1S2Ank7+CCJEd/2nie/Wo/16inb68AnBIKdaqHw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0e9699-570a-464d-c3e0-08de758ee1db
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 23:29:26.8050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rcHXxsapOa0AJUqSu5UkfeV5HbwyBlJHM8sJqjxloG1XA7MdcC074gQ6DmkuaBsjzq+64LXCrN6Nk9DYD9FRbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3964
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: -zYf3pszQ05czj3WRzp7LLUd5SY6xrxb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDIxMiBTYWx0ZWRfX06VeCo4joUC0
 hbt9f0j1eDDrX1CxKFRCHQAaHRPywZd1r8TatEaqMGAbe0OQ04nG1RTNOMzykHraSopAUdP1i3P
 Ngyz6iyhOapzrqxSlYqpsxSepy8RPO+x5oQKof0l//8U6zyXh4I6M9Kas+sWKAhZ+SvEgONlW2v
 Or5LQVDXSc/hBWIT/x70KH9T6dEt3bdcf2S6FDs6EFN+FyFgiNFVRIQ0jzGlaeXH5Vu26GBSwaR
 uL6ocrIAYmvjvnEW9n7f0srH9J/f6PLDO851x4H4jcnQ698MmA84KMSuuRPy71CM9GrjtqXz/I1
 cTyamKcvdogYuiV7benXCdXl4gEuXF5UAIIj8TBQYFtCCnzMApDk9VUej7NZdYTmktapDYixfkM
 Y7AykA6dhJwlx2BVnVX1SmjdaoQqTutWmqtgzC9EeA1oKvmn5ysURjpEQYDNzRQ2H3j33Nwlb3r
 VO37IgSwZTNutHRBMqg==
X-Proofpoint-GUID: I5QBTzW8cxRPve4SdnBsGoR_mIWz4zJd
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=69a0d759 cx=c_pps
 a=G0fLBfPV4gnnEhzimi2a/Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=hSkVLCK3AAAA:8 a=szKgq9aCAAAA:8 a=405KmdUGkDcG8Zkd5IoA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=R_ZFHMB_yizOUweVQPrY:22
Subject: Re:  [PATCH v4 2/2] hfsplus: validate b-tree node 0 bitmap at mount
 time
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_03,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260212
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78659-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[physik.fu-berlin.de,gmail.com,dubeyko.com,vivo.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mpiricsoftware.com:email,appspotmail.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D85CB1B0EB2
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAyLTI2IGF0IDE0OjQyICswNTMwLCBTaGFyZHVsIEJhbmthciB3cm90ZToN
Cj4gU3l6a2FsbGVyIHJlcG9ydGVkIGFuIGlzc3VlIHdpdGggY29ycnVwdGVkIEhGUysgaW1hZ2Vz
IHdoZXJlIHRoZSBiLXRyZWUNCj4gYWxsb2NhdGlvbiBiaXRtYXAgaW5kaWNhdGVzIHRoYXQgdGhl
IGhlYWRlciBub2RlIChOb2RlIDApIGlzIGZyZWUuIE5vZGUgMA0KPiBtdXN0IGFsd2F5cyBiZSBh
bGxvY2F0ZWQgYXMgaXQgY29udGFpbnMgdGhlIGItdHJlZSBoZWFkZXIgcmVjb3JkIGFuZCB0aGUN
Cj4gYWxsb2NhdGlvbiBiaXRtYXAgaXRzZWxmLiBWaW9sYXRpbmcgdGhpcyBpbnZhcmlhbnQgbGVh
ZHMgdG8gYWxsb2NhdG9yDQo+IGNvcnJ1cHRpb24sIHdoaWNoIGNhbiBjYXNjYWRlIGludG8ga2Vy
bmVsIHBhbmljcyBvciB1bmRlZmluZWQgYmVoYXZpb3INCj4gd2hlbiB0aGUgZmlsZXN5c3RlbSBh
dHRlbXB0cyB0byBhbGxvY2F0ZSBibG9ja3MuDQo+IA0KPiBQcmV2ZW50IHRydXN0aW5nIGEgY29y
cnVwdGVkIGFsbG9jYXRvciBzdGF0ZSBieSBhZGRpbmcgYSB2YWxpZGF0aW9uIGNoZWNrDQo+IGR1
cmluZyBoZnNfYnRyZWVfb3BlbigpLiBVc2luZyB0aGUgbmV3bHkgaW50cm9kdWNlZCBtYXAtYWNj
ZXNzIGhlbHBlciwNCj4gdmVyaWZ5IHRoYXQgdGhlIE1TQiBvZiB0aGUgZmlyc3QgYml0bWFwIGJ5
dGUgKHJlcHJlc2VudGluZyBOb2RlIDApIGlzDQo+IG1hcmtlZCBhcyBhbGxvY2F0ZWQuIEFkZGl0
aW9uYWxseSwgY2F0Y2ggYW55IGVycm9ycyBpZiB0aGUgbWFwIHJlY29yZA0KPiBpdHNlbGYgaXMg
c3RydWN0dXJhbGx5IGludmFsaWQuDQo+IA0KPiBJZiBjb3JydXB0aW9uIGlzIGRldGVjdGVkLCBw
cmludCBhIHdhcm5pbmcgaWRlbnRpZnlpbmcgdGhlIHNwZWNpZmljDQo+IGNvcnJ1cHRlZCB0cmVl
IChFeHRlbnRzLCBDYXRhbG9nLCBvciBBdHRyaWJ1dGVzKSBhbmQgZm9yY2UgdGhlDQo+IGZpbGVz
eXN0ZW0gdG8gbW91bnQgcmVhZC1vbmx5IChTQl9SRE9OTFkpLiBUaGlzIHByZXZlbnRzIGtlcm5l
bCBwYW5pY3MNCj4gZnJvbSBjb3JydXB0ZWQgaW1hZ2VzIHdoaWxlIGVuYWJsaW5nIGRhdGEgcmVj
b3ZlcnkgYnkgYWxsb3dpbmcgdGhlIG1vdW50DQo+IHRvIHByb2NlZWQgaW4gYSBzYWZlLCByZWFk
LW9ubHkgbW9kZSByYXRoZXIgdGhhbiBmYWlsaW5nIGNvbXBsZXRlbHkuDQo+IA0KPiBSZXBvcnRl
ZC1ieTogc3l6Ym90KzFjOGZmNzJkMGNkOGE1MGRmZWFhQHN5emthbGxlci5hcHBzcG90bWFpbC5j
b20NCj4gTGluazogaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0
dHBzLTNBX19zeXprYWxsZXIuYXBwc3BvdC5jb21fYnVnLTNGZXh0aWQtM0QxYzhmZjcyZDBjZDhh
NTBkZmVhYSZkPUR3SURBZyZjPUJTRGljcUJRQkRqREk5UmtWeVRjSFEmcj1xNWJJbTRBWE16YzhO
SnUxX1JHbW5RMmZNV0txNFk0UkFrRWx2VWdTczAwJm09VjZvdVBOSUUzMjVMMVVobDBnTDVSNDho
aHpBOVJ3NFBTZjdtN0hQeUxnTnF0dUJiaVptaXpnMWtyZ251MHA0NyZzPTgzbGdXTTQ5MWozZjc2
VTZNZEJrdDNPTi1RaTM3UHU0S1VSSHhJa0RsRDAmZT0gDQo+IExpbms6IGh0dHBzOi8vdXJsZGVm
ZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fbG9yZS5rZXJuZWwub3JnX2Fs
bF81NGRjOTMzNmI1MTRmYjEwNTQ3ZTI3YzdkNmUxYjhiOTY3ZWUyZWRhLmNhbWVsLTQwaWJtLmNv
bV8mZD1Ed0lEQWcmYz1CU0RpY3FCUUJEakRJOVJrVnlUY0hRJnI9cTViSW00QVhNemM4Tkp1MV9S
R21uUTJmTVdLcTRZNFJBa0VsdlVnU3MwMCZtPVY2b3VQTklFMzI1TDFVaGwwZ0w1UjQ4aGh6QTlS
dzRQU2Y3bTdIUHlMZ05xdHVCYmlabWl6ZzFrcmdudTBwNDcmcz1DRUZBaFoyaXY0SlZHTmoyS2JO
MTliMHd6S0VVeDlrWnNaSXBNZEdvbThBJmU9IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaGFyZHVsIEJh
bmthciA8c2hhcmR1bC5iQG1waXJpY3NvZnR3YXJlLmNvbT4NCj4gLS0tDQo+ICBmcy9oZnNwbHVz
L2J0cmVlLmMgfCA0NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZnMvaGZzcGx1cy9idHJlZS5jIGIvZnMvaGZzcGx1cy9idHJlZS5jDQo+IGluZGV4IDIyZWZk
NjUxN2VmNC4uZTM0NzE2Y2Q2NjFiIDEwMDY0NA0KPiAtLS0gYS9mcy9oZnNwbHVzL2J0cmVlLmMN
Cj4gKysrIGIvZnMvaGZzcGx1cy9idHJlZS5jDQo+IEBAIC0xNzYsOSArMTc2LDE0IEBAIHN0cnVj
dCBoZnNfYnRyZWUgKmhmc19idHJlZV9vcGVuKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHUzMiBp
ZCkNCj4gIAlzdHJ1Y3QgaGZzX2J0cmVlICp0cmVlOw0KPiAgCXN0cnVjdCBoZnNfYnRyZWVfaGVh
ZGVyX3JlYyAqaGVhZDsNCj4gIAlzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZzsNCj4gKwlz
dHJ1Y3QgaGZzX2Jub2RlICpub2RlOw0KPiArCWNvbnN0IGNoYXIgKnRyZWVfbmFtZTsNCj4gKwl1
bnNpZ25lZCBpbnQgcGFnZV9pZHg7DQo+ICAJc3RydWN0IGlub2RlICppbm9kZTsNCj4gIAlzdHJ1
Y3QgcGFnZSAqcGFnZTsNCj4gIAl1bnNpZ25lZCBpbnQgc2l6ZTsNCj4gKwl1MTYgYml0bWFwX29m
ZiwgbGVuOw0KPiArCXU4ICptYXBfcGFnZTsNCj4gIA0KPiAgCXRyZWUgPSBremFsbG9jX29iaigq
dHJlZSk7DQo+ICAJaWYgKCF0cmVlKQ0KPiBAQCAtMjgzLDYgKzI4OCw0NiBAQCBzdHJ1Y3QgaGZz
X2J0cmVlICpoZnNfYnRyZWVfb3BlbihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCB1MzIgaWQpDQo+
ICANCj4gIAlrdW5tYXBfbG9jYWwoaGVhZCk7DQo+ICAJcHV0X3BhZ2UocGFnZSk7DQo+ICsNCj4g
Kwlub2RlID0gaGZzX2Jub2RlX2ZpbmQodHJlZSwgSEZTUExVU19UUkVFX0hFQUQpOw0KPiArCWlm
IChJU19FUlIobm9kZSkpDQo+ICsJCWdvdG8gZnJlZV9pbm9kZTsNCj4gKw0KPiArCXN3aXRjaCAo
aWQpIHsNCj4gKwljYXNlIEhGU1BMVVNfRVhUX0NOSUQ6DQo+ICsJCXRyZWVfbmFtZSA9ICJFeHRl
bnRzIjsNCj4gKwkJYnJlYWs7DQo+ICsJY2FzZSBIRlNQTFVTX0NBVF9DTklEOg0KPiArCQl0cmVl
X25hbWUgPSAiQ2F0YWxvZyI7DQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgSEZTUExVU19BVFRSX0NO
SUQ6DQo+ICsJCXRyZWVfbmFtZSA9ICJBdHRyaWJ1dGVzIjsNCj4gKwkJYnJlYWs7DQo+ICsJZGVm
YXVsdDoNCj4gKwkJdHJlZV9uYW1lID0gIlVua25vd24iOw0KPiArCQlicmVhazsNCj4gKwl9DQoN
CkZyYW5rbHkgc3BlYWtpbmcsIGl0IGNvdWxkIGJlIGVub3VnaCB0byBzaGFyZSBvbmx5IGNuaWQu
IEJ1dCBpZiB5b3Ugd291bGQgbGlrZQ0KdG8gYmUgcmVhbGx5IG5pY2UgYW5kIHRvIHNoYXJlIHRo
ZSB0cmVlJ3MgbmFtZSwgdGhlbiBJIHByZWZlciB0byBzZWUgYW4gYXJyYXkgb2YNCmNvbnN0YW50
IHN0cmluZ3Mgd2hlcmUgeW91IGNhbiB1c2UgY25pZCBhcyBhbiBpbmRleC4gQW5kIG1hY3JvIG9y
IHN0YXRpYyBpbmxpbmUNCm1ldGhvZCB0aGF0IGNhbiBjaGVjayBjbmlkIGFzIGEgaW5wdXQgYXJn
dW1lbnQuIEF0IG1pbmltdW0sIHNpbXBseSBtb3ZlIHRoaXMNCmNvZGUgaW50byB0aGUgc3RhdGlj
IGlubGluZSBtZXRob2QuIEJ1dCwgYXJyYXkgb2YgY29uc3RhbnQgc3RyaW5ncyBjb3VsZCBiZSBt
dWNoDQpjb21wYWN0IGFuZCBlbGVnYW50IHNvbHV0aW9uIGZvciBteSB0YXN0ZS4gQmVjYXVzZSwg
YXJ0IG9mIHByb2dyYW1taW5nIGlzIHRvDQpyZXByZXNlbnQgZXZlcnl0aGluZyBhcyBhcnJheXMg
b2Ygc29tZXRoaW5nIGFuZCB0byBhcHBseSB0aGUgZ2VuZXJhbGl6ZWQgbG9vcHMuDQo6KQ0KDQo+
ICsNCj4gKwltYXBfcGFnZSA9IGhmc19ibWFwX2dldF9tYXBfcGFnZShub2RlLCAmYml0bWFwX29m
ZiwgJmxlbiwgJnBhZ2VfaWR4KTsNCg0KSSB3aWxsIHRhbGsgYWJvdXQgYml0bWFwX29mZiwgbGVu
LCBwYWdlX2lkeCBhdCB0aGUgcGxhY2Ugb2YgZnVuY3Rpb24gZGVmaW5pdGlvbi4NCg0KWW91IGFy
ZSBzYWZlIGluIGhmc19idHJlZV9vcGVuKCkgbWV0aG9kIGJlY2F1c2Ugbm9ib2R5IHlldCB3aWxs
IHRyeSB0byBhY2Nlc3MNCnRoZSBiaXRtYXAuIEJ1dCB5b3UgbmVlZCB0byB1c2UgbG9ja19wYWdl
KCkvdW5sb2NrX3BhZ2UoKSBmb3Igb3RoZXIgbG9naWMuDQoNCkkgcHJlZmVyIG5vdCB0byBoYXZl
IHRoZSBvYmxpZ2F0aW9uIG9mIHVzaW5nIHRoaXMgYXN5bmNocm9ub3VzIHBhcmFkaWdtIG9mDQpr
bWFwX2xvY2FsKCkva3VubWFwX2xvY2FsKCkuIEl0IHdpbGwgYmUgZ3JlYXQgdG8ga2VlcCB0aGlz
IGluc2lkZSBvZg0KaGZzX2JtYXBfZ2V0X21hcF88c29tZXRoaW5nPigpIG1ldGhvZC4NCg0KSSBw
cmVmZXIgbm90IHRvIGtlZXAgdGhlIHdob2xlIHBhZ2UvZm9saW8gZm9yIGNvbXBsZXRlIG9wZXJh
dGlvbiBsb2NrZWQuIEFuZCwNCmZyYW5rbHkgc3BlYWtpbmcsIHlvdSBkb24ndCBuZWVkIGluIHRo
ZSB3aG9sZSBwYWdlIGJlY2F1c2UgeW91IG5lZWQgYSBieXRlIG9yDQp1bnNpZ25lZCBsb25nIHBv
cnRpb24gb2YgYml0bWFwLiBTbywgd2UgY2FuIGNvbnNpZGVyIGxpa2V3aXNlIGludGVyZmFjZToN
Cg0KdTggaGZzX2JtYXBfZ2V0X21hcF9ieXRlKHN0cnVjdCBoZnNfYm5vZGUgKm5vZGUsIHUzMiBi
aXRfaW5kZXgpOw0KDQpIZXJlLCB5b3Ugc2ltcGx5IG5lZWQgdG8gY2hlY2sgdGhlIHN0YXRlIG9m
IGJpdCBpbiBieXRlIChSRUFELU9OTFkgb3BlcmF0aW9uKS4NClNvLCB5b3UgY2FuIGF0b21pY2Fs
bHkgY29weSB0aGUgc3RhdGUgb2YgdGhlIGJ5dGUgaW4gbG9jYWwgdmFyaWFibGUgYW5kIHRvIGNo
ZWNrDQp0aGUgYml0IHN0YXRlIGluIGxvY2FsIHZhcmlhYmxlLg0KDQpJZiB5b3UgbmVlZCB0byBh
bGxvY2F0ZSBhbmQgZ28gY2hhbmdlIHRoZSBzdGF0ZSBvZiB0aGUgYml0LCB0aGVuIHlvdSBuZWVk
IHRvIHVzZQ0KbG9jayBmb3IgdGhlIHdob2xlIG9wZXJhdGlvbjoNCg0KPGxvY2tfYml0bWFwPg0K
aGZzX2JtYXBfZ2V0X21hcF9ieXRlKCk7DQo8Y2hlY2sgYW5kIGNoYW5nZSBieXRlIHN0YXRlIGlu
IGxvY2FsIHZhcmlhYmxlPg0KaGZzX2JtYXBfc2V0X21hcF9ieXRlKCk7IDwtLSBzZXQgYnl0ZSBh
bmQgbWFrZSBtZW1vcnkgcGFnZSBkaXJ0eQ0KPHVubG9ja19iaXRtYXA+DQoNClRoYW5rcywNClNs
YXZhLg0KDQo+ICsNCj4gKwlpZiAoSVNfRVJSKG1hcF9wYWdlKSkgew0KPiArCQlwcl93YXJuKCIo
JXMpOiAlcyBCdHJlZSAoY25pZCAweCV4KSBtYXAgcmVjb3JkIGludmFsaWQvY29ycnVwdGVkLCBm
b3JjaW5nIHJlYWQtb25seS5cbiIsDQo+ICsJCQkJc2ItPnNfaWQsIHRyZWVfbmFtZSwgaWQpOw0K
PiArCQlwcl93YXJuKCJSdW4gZnNjay5oZnNwbHVzIHRvIHJlcGFpci5cbiIpOw0KPiArCQlzYi0+
c19mbGFncyB8PSBTQl9SRE9OTFk7DQo+ICsJCWhmc19ibm9kZV9wdXQobm9kZSk7DQo+ICsJCXJl
dHVybiB0cmVlOw0KPiArCX0NCj4gKw0KPiArCWlmICghKG1hcF9wYWdlW2JpdG1hcF9vZmZdICYg
SEZTUExVU19CVFJFRV9OT0RFMF9CSVQpKSB7DQo+ICsJCXByX3dhcm4oIiglcyk6ICVzIEJ0cmVl
IChjbmlkIDB4JXgpIGJpdG1hcCBjb3JydXB0aW9uIGRldGVjdGVkLCBmb3JjaW5nIHJlYWQtb25s
eS5cbiIsDQo+ICsJCQkJc2ItPnNfaWQsIHRyZWVfbmFtZSwgaWQpOw0KPiArCQlwcl93YXJuKCJS
dW4gZnNjay5oZnNwbHVzIHRvIHJlcGFpci5cbiIpOw0KPiArCQlzYi0+c19mbGFncyB8PSBTQl9S
RE9OTFk7DQo+ICsJfQ0KPiArCWt1bm1hcF9sb2NhbChtYXBfcGFnZSk7DQo+ICsJaGZzX2Jub2Rl
X3B1dChub2RlKTsNCj4gKw0KPiAgCXJldHVybiB0cmVlOw0KPiAgDQo+ICAgZmFpbF9wYWdlOg0K

