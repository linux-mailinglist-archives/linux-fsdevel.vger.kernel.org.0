Return-Path: <linux-fsdevel+bounces-59958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 926FCB3F912
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 10:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A429D1B2236E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 08:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3658F2E8E19;
	Tue,  2 Sep 2025 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pkNv4d5I";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cFRwpgCv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C900E22A80D;
	Tue,  2 Sep 2025 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802859; cv=fail; b=l8pFyE1jWaE79NJxy4k7E2wvdV6R6pNpOhbCOuO70/htYxyO0k4CL/Z0YPG+ZqdV+5+E0zdfMfeCMekgzuwTKT5B1GJ1RRMB8ifV0vJlEqfRPUb3tyYzhEYGn1i1gzBP2RUGiAXEUSG5ZhbiU2+aRBlyLi9I68B7nQVbGVBsSAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802859; c=relaxed/simple;
	bh=c1owyHP4lW43knF5pUh+04Wq2DsLWwtZgJDz/WLwh+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nVqMCMId5dpnsxS4qlqqWpHmmgjOUxrNudgW8740fCkx2UfpymZ0J+5YwbXq5wOkrx1rIQjywI7u1mqWwZgEihBqw/hebtVkEO0Zvc5KnXOs7KG+OapYE5uF3yOmOe1TTHWk4MRyu92D8Yeq8iAYE/DsDViLiiFz1IQhp5d/Y38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pkNv4d5I; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=cFRwpgCv; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756802857; x=1788338857;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c1owyHP4lW43knF5pUh+04Wq2DsLWwtZgJDz/WLwh+E=;
  b=pkNv4d5IgEaKXXmsn95OjCbmU1FhZiD6htkCTTm+5vXoNTZIevVUcZh/
   Cb7DsNXnAmpwOcZtGZisIneChZZ4O9up3WWJQ1pdxybqm1m/c+tXYpdhL
   j7vv9YTEnDDhXZ8HwvDoCt7MNp0cIWYTC7xM5qrtXt+/WKPZsNSWxGBNR
   7UQnjukNT8jI2nh5VabbMSPzxWV7NRuSRchlv00rRWDHviluRBxXsIrer
   42B4dydVJWhz5V/8VPfYwsYUtYRlLpiZgz0+HVybznKRUN10Ow5200dq3
   Gv1COHd6bjeTTM+m9f0JDHnSdzIqjFfTiJvrnqSuiGVMlCmgmIuOXSdxI
   A==;
X-CSE-ConnectionGUID: I+9iR4LHQAGV+9sehGAM9A==
X-CSE-MsgGUID: ogzwOuA6Tw+RjYgyrGAy3w==
X-IronPort-AV: E=Sophos;i="6.18,230,1751212800"; 
   d="scan'208";a="109915990"
Received: from mail-dm6nam11on2072.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([40.107.223.72])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2025 16:47:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMPJ8xQJPKjei67eWW5MAmM2TUqSRJYWdeZtlZUHJZlblFsvrlhGYQRJ+PHzZfyRpe6a3jIaj/7efG3f3b9A8XoBsqSxifdCL9O+6cC+UTwS3200PJ5eO6bQqwguDrDmhhBB/1fiFWERCm9LQ61coiccIPKlyATFl1+UCaHD8NU/uX3ACP1noXCkYAsbWlMTxh5fauOna5aSqFVeOtKyBFq4jJQjPG88rBuelWSVUY3a41ANa9XsroyeugmrsoYMKQvXbeApZyYVzixV9kXv7zMuhgQXCSHzWPoS0V3xqslPfOFXPvi8zh0RDzIXZHyfDXKXT9CpS+gDSMKXHFfYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1owyHP4lW43knF5pUh+04Wq2DsLWwtZgJDz/WLwh+E=;
 b=XbTfntqXGSPltu+00FocXeAudfmbTexEMLrLz2gmr44JfTy+j+Plq+3vKz2EwOGH08+XXZhnoV50k/hr9VWZD7aG95Q4OlsjD44kePgiMoSZNfDTVrqTeZEZafg4GFVkmilORMg1h736kAWG3ofuDkr0k8vIo3Jl0XUMx3f4HIGLd9eD6KeBlchTEuMFq6a8ZeWhuOz/XAnjjffRpdGPP6DdttXuogJPYj00R6u+rJSDbmNDlusfaAR4QIDyx+fC/B4/ElTg2A4fAY2jqzRDizhaAhqVZOEoRpVSORu62GxgBEsnl2AhluKNubli23BpKG28wP3sXlc+9ActaCByBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1owyHP4lW43knF5pUh+04Wq2DsLWwtZgJDz/WLwh+E=;
 b=cFRwpgCvRgg9IlAGD2hfUSsNQEqzM37Su59dVY8wWCEncx3KLHYA+XjgwKNFaPszxsoOzaLE2w8++9f/RrQZ2qeXZlornsL3vixkaDGVBrUGI9qv4JtKa/okeVm2X5vOVimb7psnosJvVxh88cjfwFxNQcK2aLKJXQRFkLtTQA8=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by DS4PR04MB9698.namprd04.prod.outlook.com (2603:10b6:8:282::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:47:28 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 08:47:28 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: hch <hch@lst.de>
CC: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, Carlos Maiolino
	<cem@kernel.org>, Dave Chinner <david@fromorbit.com>, "Darrick J . Wong"
	<djwong@kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Bart Van Assche <bvanassche@acm.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "chao@kernel.org" <chao@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org"
	<brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>
Subject: Re: [PATCH 1/3] fs: add an enum for number of life time hints
Thread-Topic: [PATCH 1/3] fs: add an enum for number of life time hints
Thread-Index: AQHcGy5z8GIOy0dghESg7mz9iKIwIrR/YgGAgAA0DYA=
Date: Tue, 2 Sep 2025 08:47:28 +0000
Message-ID: <2f996d15-4cf7-42fe-90de-f77f515a86d8@wdc.com>
References: <20250901105128.14987-1-hans.holmberg@wdc.com>
 <20250901105128.14987-2-hans.holmberg@wdc.com>
 <20250902054108.GA11431@lst.de>
In-Reply-To: <20250902054108.GA11431@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|DS4PR04MB9698:EE_
x-ms-office365-filtering-correlation-id: 66c49a1e-3dea-4e85-45c6-08dde9fd58ce
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R2JOWUdQeWNDTHk1RzdXcVA4d1dJdERNVEUvd1ltN1I3TW5KTzkyQnY0VG44?=
 =?utf-8?B?dExWLzdNZWpSN1hoRkhFOVZQak16VVluRGVQc0FTdXNkd2hWMUhma0xNdmxG?=
 =?utf-8?B?WU5HSXBYLytmd0JZY3BJbFlnTEtJM1BhakdCV3B1OUZESHREMHRmcFRDMHda?=
 =?utf-8?B?QWpiU2QzTHQzeFhIMXY5cFNyV2M0TzFrMWVrZDc1czNMYVVsS1MyQi90ZDNY?=
 =?utf-8?B?NGUwdlN1aXZBOWFQWUI2Vitydkc5YXFHQitqZWp6RGRzNU01UkV4RHZSVW50?=
 =?utf-8?B?d0M3L1M1cXgxdVRYaWgwQVFzZW9GRzVtb3UxcTZVWVBzTi9JR3NQZlU2cUdP?=
 =?utf-8?B?NzRPbEtIa1UxZTBxVU9qRzkrYURFNjhsQWhoR0lyNERtbzhzQ0Y2QlFPQnQx?=
 =?utf-8?B?TGVFeEF6ZnIxbkFGU1RuWFpTaEUzSm9icVo5am0zZExrbGhxRGh5NDFUWnFK?=
 =?utf-8?B?OFBVSTRpLytZcXphT1dDWXlSWmxEekdnMzhLTmdxaDNCZXJwZG1DTXBrWTBZ?=
 =?utf-8?B?Sy9wS1plYWU1cHNndXVjNXU0blhZQmdxUTlKMnFBM0s2L0J5UUlsSFJwREZY?=
 =?utf-8?B?RHp0RHpnd0N5RGhTRDhFS1VpbWVYT3ZUREkzUVBYOWpZZEdLdFVkODU5UHJG?=
 =?utf-8?B?VVdyWG5QT0k1OUVWcjMwL2h4WTVWdmR0RDFPekFYUDZNYktLQU9ZU2Uxd2lw?=
 =?utf-8?B?NEZNNmRDYVRYQUJoaWt5eDJyTnFjTGVodU1IRVo5RmNVdXlhS0paNnNhVVNP?=
 =?utf-8?B?N2NBdFBXTlhadkNYVVJjcFJMem52SE0rbjQwdU1OaFdFNUY0cDRzWEw5TDdm?=
 =?utf-8?B?Qm9DRDBsU1dsbWVsOXM3ckFsazhTTWUvNmRadzhpQ1Fna0dtbWNJSXNlQUw3?=
 =?utf-8?B?S1BNZVQrdWN0MFQxU29La2ROTEhNa0h5ZTAzcTByM0xPN1Z4VThEalU0OXlM?=
 =?utf-8?B?WXlXcUhuMlZTdUY2OS96WDZ4ZkZHZFY3NTNrem8rclFrRDAyQXlET2RkbEF1?=
 =?utf-8?B?NGN0S1VjclNMcDk0UHlQVTZFeGphbVhzNDdLeHBSbEdRMGEzTFd6U2NKYmtR?=
 =?utf-8?B?amFlSVFZdUszRDNmeExNYlROOWQxUks1ZUo2WnBBYkY1WjMrR1hVckQ3eXRR?=
 =?utf-8?B?VThJeURGYUhZbFJwdmNQSEdOeWlUUGpTU3ZzUWdvbGY4dGFDWS9NRnBsZXZL?=
 =?utf-8?B?WExQbDROb2cyQzhjZlRWTFozOUxFUGdGWjZuRXlYc0J4cVA5NUdiMmJMaDhK?=
 =?utf-8?B?UHdMdDV0YlFSNDJ6dE0raXBGT1Y0TUZTZnFRdFVBbk5MTFpFZVozc0FzY3p0?=
 =?utf-8?B?THdkZ012OG5CTHBDQmZIZm5VUnNKdVhONDFnVzdDRWdiQ2ZtNkJMZ3NVOXNu?=
 =?utf-8?B?RVdjTGpLcUdmRWE5YUQxb0RCR3NwdmFiUkVpM1FVcjhSVFh2M3l0OUZFWU1J?=
 =?utf-8?B?cGVtMTFDejZUeXJqMUxzWEc5RkVQWUlwY3BBOElkaUFiWHlCdStWRnc4blBu?=
 =?utf-8?B?QmlSWk1KbHRvVUVCOUxKbEFGdy9GYmdtdTdXZmtTbGlESzJDN01oOEJDVWJ2?=
 =?utf-8?B?OWorb0ovY2RVNnlkcnBQclhxQi8xS1g2cXFZNTJjaDVZOXhsaXVqay9oUnJN?=
 =?utf-8?B?RmxxMFpQdWtUT1paQXY2ZFJ1aUdJQUNiVGRWVmhjbmdZcWQwU01CRy9GanVP?=
 =?utf-8?B?dkhSRXUwNms3ZkhmaHV6SFFkVXBuWmxuYWt5YXgvL1A4aGVvS2FVT2V6eWlM?=
 =?utf-8?B?dVZnUERtL1FUVVdNajkyWVRKWitSWlhST0d1c1BkRFhOWXg0V2pQT1ZPcG1y?=
 =?utf-8?B?ei90ZHpLeURJSEZZUjBFWERhS09tQWlKYUN1N0Q2ejB0YmFLVXN1dGd3bzBi?=
 =?utf-8?B?eE9EYm1hV2FqVjZ5dUQ1MUZTYUlKcERXaGQ5amV6TmdsYmpVSnlvT3o3UDNw?=
 =?utf-8?B?OXZLNThKOERLd2tYK25RdjVYRzJFcjdnNTBwVW82a1ZDTDRObmVRbGV3TzNw?=
 =?utf-8?B?bHpwSEZqMGtRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWNvZmRpamgyek9DTjlSQzVpZTNhMHU4OXkybG1VUDBmNldlVnV0MFVVaE00?=
 =?utf-8?B?UUxQaldUeW1pM1NzNzZRc1NJOE15d2o5QXBtTnZMZnlaMGhtNi9PNFQ1VG0w?=
 =?utf-8?B?MjFDbEJQdjBTY240ZitoYjJLajJTVTNmTjUwUFN2Z2NES0VuckFERi9rQklE?=
 =?utf-8?B?T2hFVDNJU2JDUENhdGlROEw3bnJnTnJzUVdsVHoxTHBNVGovbjJoTjMwWnll?=
 =?utf-8?B?Tk5vdTExS01pQi9XS2hYL3ZBdTZZV0YrL21VSjBzMzB3ZUxHSHZ2SEEybC8y?=
 =?utf-8?B?VUhvdStFV3ZxUjVrR3g0WWxWNm1JWGdQcHdvZlFMWGFDKzJqYnVVdWxWYi9v?=
 =?utf-8?B?SzVQZ2lnRWlBL0EzbFZNYkJpcktrdW43WjNKN21CcVNzY0d6dWd4RFdPczEw?=
 =?utf-8?B?aHFUak5iOG5teVlSNGlTUDBIY21DcExlOGFHY0NsWWpqVW1wWTkzLytMaTVN?=
 =?utf-8?B?WitnMHFIMHpFbm5HS1pOZTcvVCtRR2ErSStFTTE3T091SmNGdmVjT2VkUTA1?=
 =?utf-8?B?NmFNYUJPVmwzTFZjLzZFeExmWVVyRU0zR0VWeGxCV2pxbER3eUJjN25PYUVt?=
 =?utf-8?B?RE9wUzhoZzJYeGs4Rk91dzJBS0RwSU5xeU9hakVIQ3JwQ1JsQVpERVc4Ly8z?=
 =?utf-8?B?RmNXQkp5dktjN1NnaUN5M3UwTE92dFpkQ3phYVcrMUxXUEdEQmh0STg0aTdC?=
 =?utf-8?B?SEI5VFVVY3UzQVBLRnlFZEQxNHFKQW0raWQ4R1B0MjBWVWd1ZlBXRkp4UDgz?=
 =?utf-8?B?TGhiZWZzTDdOSitLWjlZU1JrM21OdlQ4Z2d3OUhwSm1iNVFML2dFelN2Qy84?=
 =?utf-8?B?UnZRT2FMWnVTRm5YTUxreXMxa3FjRkc0NzcrTXNDYnFvSkk5dHE1NGwzd1pk?=
 =?utf-8?B?SGFmK01kd3YzTGVDRStUbm9FNWluOUJpZ2FXZHo1ZDZxNEFEZ21wdnZHQUw5?=
 =?utf-8?B?Rms1Y29Md3BUZmJOQzB6Mk1uLzgxaXVJSTZyVGxHTW9DZTA3VnUyOTNMREY2?=
 =?utf-8?B?VjNoUG91U1RKQnRkRE01NjFTcHZyVnNib0ticGVmdGRKRlVmWVRyVDAxbmFC?=
 =?utf-8?B?TkorcFByRGR3SC82VlNIRHFXRHJTOXNka05JUWFpUGZsaGE0WmVYZUlnU0RN?=
 =?utf-8?B?TnJhV0dTd2FvbGFudXVOR2FXdlZ1MXlIZ1VHRStObmQ4ZTUvWktOM3NhZWJQ?=
 =?utf-8?B?ZXYybE96cHBVU1I5UmkzZjJRMnN3czlHbXN2L1F5eW4vUFc3YWFLc1BZbzZC?=
 =?utf-8?B?bW9WQXg4SWMrZ2RhcVY1ODRKSmhjVTNLTmpSeXRVYkVjdWM5VWp6ZmxwTmpk?=
 =?utf-8?B?T0kyZnlYUmNiRG9PbzB6WG42L1Q0UHZwNmwxeDhDaUhRdU5HMWhpdHBQVi9a?=
 =?utf-8?B?L3Y0YjFoK3drSHd4c2tXUk8vLytlZ0kxcU9WQVFRd2FSN2tmTmh1L0RKRHpY?=
 =?utf-8?B?N2YvYXl6aDJKcXlVdldya3Q2bnprM2xKaU9zbnlsdSsvSTVNREhseG9GNThp?=
 =?utf-8?B?YklkUksxYUU5VkRIcXEvSitrUTZyc0FOa2JUcHQrSFJYSlpIVThsQkc0dzNG?=
 =?utf-8?B?Wkw1V0VKTEZrT1ZEWU5HalhXQjFCSnJMRVFGeFBsZFhkWlZJTFJCaGQvU3R6?=
 =?utf-8?B?c0lFSEk2YmhTMTl1YXh3cFBoaUp4akxERTF1UzMrK0N2Y202TUNzNVA4Nmtm?=
 =?utf-8?B?WVdMR05iVlpmNDZsUlJYYkZnL29nTnNzdDl3SXY0KzBVRzlXY3lRUm90NE5k?=
 =?utf-8?B?TGhOTy9YSGVKbGJsdVVDYldPUllRcWFkMjFzMTQ4WDhZaFVFUlEyWGhXYzJG?=
 =?utf-8?B?VUdhNmw5cDQreUxZYnhYT2xBZ2VUNGZsYU1CaWxpNmdlcDluV2lod2pqTVQ1?=
 =?utf-8?B?QnpYbzBaWUFnNWJ3bXR3NmlOaVE1U2NRQzl4Um9PcTlSNSs2eEtzVEtVa2ZH?=
 =?utf-8?B?a3E4TXAyVTl4dXYrZXNtQlpJeGlRRSszQTYrejVKMkhLS1RUWk0xYjBEWlpn?=
 =?utf-8?B?ekVOMk5NeTZuWUhSaUdkdnVqZHNPSzY4aW8yN04yNlVLQ3dlQ1N5QTFNMlBt?=
 =?utf-8?B?Zm1UOTJmV1BhbjFtaENqMzhuZ2Q5c1cyRjFpYURZRlFwOG9ubDEwTy8xV3Ar?=
 =?utf-8?B?ZmtYdkxXeS9PREFydWFaVElZdml3K0lkamRmaVlmQjI3ZWh6RC9TeFMvWUVp?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0CAC820470CE94B8CAA1D2C37BB5484@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AocyWRL3RzqOL2CZ7o8xsklO0YdaGgwTIhWswzI/tso3+XYAiZTnEgGXvchsVf2siJAsphF3mwOsU8tPZ/B23g9vRl0nLrYnq1/90CaM3/OosZBS+aj3V7RMSlgNRI7f1KSDJw3OGHqzyCzuaDyzIRgRKMWL93fKRawiRYLUEQDnoEg3eGgUmuPD06oLlMdaLP9hi8656u43GL2xnAvfQS77WBIrXbNN8vMSqC6rF8lDlq14w5p+N4JxpQeGMeSS/mKN4nk2vqlmNYADkCAd+xv61gGPtrYtaJfx0AlKYvjF40rBvdk9emmPfy3ThW7NR+TRxnJVtesSYm8FKa2GmY6XTv1qz5Ik9KFgbdU3yJ0tHQitLH/azfdtFCc6O1EDvsX5M/bQzL+ItTKCpmgAGK9uFA+gmngWRKJi++IpCuyOjd1uWpDLIyge5nCbE241uLnsGeutop0JIPs1X0apBFQfz6K2sF3Lc3yA2rjmJP9Nq4iLXjqaQeB0jB3pzXZhH76pORHJDV0bODvNZpbl/DMmYx2iaywlto8HP26LD6ld95wIXlXNNcDEa+b80GOFW8p81H24CAClmWbxyIWgoDxAlvZpjHYNFxUq70n15MBxWSXcudFJ7ihIcHWs8GFY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c49a1e-3dea-4e85-45c6-08dde9fd58ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 08:47:28.1973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YFGAqqMpTTV6hzwaBtCWRvEI6+yStWqaXzc5daTvlZptTMTiYyMHWc0kRwZZzyfFOg9T+ib2oa/bepzaWnbnoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR04MB9698

T24gMDIvMDkvMjAyNSAwNzo0MSwgaGNoIHdyb3RlOg0KPiBMb29rcyBnb29kLCBidXQgeW91IHBy
b2JhYmx5IHdhbnQgdG8gYWRkIGEgZmV3IG1vcmUgZm9sa3MgdGhhdA0KPiBjcmVhdGVkIHRoaXMg
Y29uc3RhbnQgYW5kIHRoZSBoZWFkZXIgdG8gdGhlIENjIGxpc3QuDQoNClllcywgdGhhbmtzIGZv
ciBhZGRpbmcgQmFydCBhbmQgSmVucy4NCkFkZGluZyB0aGUgb3RoZXJzIHdobyB3aGVyZSBpbiBj
YyB3aGVuIHRoZSBoZWFkZXIgd2FzIGNyZWF0ZWQuDQoNCj4gDQo+IFJldmlld2VkLWJ5OiBDaHJp
c3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gDQo+IE9uIE1vbiwgU2VwIDAxLCAyMDI1IGF0
IDEwOjUyOjA0QU0gKzAwMDAsIEhhbnMgSG9sbWJlcmcgd3JvdGU6DQo+PiBBZGQgV1JJVEVfTElG
RV9ISU5UX05SIGludG8gdGhlIHJ3X2hpbnQgZW51bSB0byBkZWZpbmUgdGhlIG51bWJlciBvZg0K
Pj4gdmFsdWVzIHdyaXRlIGxpZmUgdGltZSBoaW50cyBjYW4gYmUgc2V0IHRvLiBUaGlzIGlzIHVz
ZWZ1bCBmb3IgZS5nLg0KPj4gZmlsZSBzeXN0ZW1zIHdoaWNoIG1heSB3YW50IHRvIG1hcCB0aGVz
ZSB2YWx1ZXMgdG8gYWxsb2NhdGlvbiBncm91cHMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSGFu
cyBIb2xtYmVyZyA8aGFucy5ob2xtYmVyZ0B3ZGMuY29tPg0KPj4gLS0tDQo+PiAgaW5jbHVkZS9s
aW51eC9yd19oaW50LmggfCAxICsNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9yd19oaW50LmggYi9pbmNsdWRlL2xp
bnV4L3J3X2hpbnQuaA0KPj4gaW5kZXggMzA5Y2E3MmYyZGZiLi5hZGNjNDMwNDJjOTAgMTAwNjQ0
DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3J3X2hpbnQuaA0KPj4gKysrIGIvaW5jbHVkZS9saW51
eC9yd19oaW50LmgNCj4+IEBAIC0xNCw2ICsxNCw3IEBAIGVudW0gcndfaGludCB7DQo+PiAgCVdS
SVRFX0xJRkVfTUVESVVNCT0gUldIX1dSSVRFX0xJRkVfTUVESVVNLA0KPj4gIAlXUklURV9MSUZF
X0xPTkcJCT0gUldIX1dSSVRFX0xJRkVfTE9ORywNCj4+ICAJV1JJVEVfTElGRV9FWFRSRU1FCT0g
UldIX1dSSVRFX0xJRkVfRVhUUkVNRSwNCj4+ICsJV1JJVEVfTElGRV9ISU5UX05SLA0KPj4gIH0g
X19wYWNrZWQ7DQo+PiAgDQo+PiAgLyogU3BhcnNlIGlnbm9yZXMgX19wYWNrZWQgYW5ub3RhdGlv
bnMgb24gZW51bXMsIGhlbmNlIHRoZSAjaWZuZGVmIGJlbG93LiAqLw0KPj4gLS0gDQo+PiAyLjM0
LjENCj4gLS0tZW5kIHF1b3RlZCB0ZXh0LS0tDQo+IA0KDQo=

