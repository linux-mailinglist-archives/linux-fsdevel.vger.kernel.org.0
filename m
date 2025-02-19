Return-Path: <linux-fsdevel+bounces-42122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B537A3CA17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 21:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98FF81888E09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 20:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5930323CF0B;
	Wed, 19 Feb 2025 20:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="H8V8vweW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="dXhHm6H0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05CA1F8BA5;
	Wed, 19 Feb 2025 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997559; cv=fail; b=ol2RN8+bfeD8mOcLJwiyBTYOWgqglV8njfs+tlPGx2zKKeVM5jDz334ARSGOcTB6W9QvLcHxtbD1c1gDWKF7paWrG/3Pc32FsFmgVjNHs8NSXtngdSc274xsc+3USmyN0u2UFlUzIfZr3yUZwNQv7gdDoTin22c5Tzcf12TEiKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997559; c=relaxed/simple;
	bh=28cwe71LQ29NpFNnKIf6H7jZYK0lT4/VzTtc3X+le7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UusAnpv8HNqrBARq2Ra+eM1rulUm10rL5RnVRhU3joPSVKZdXl8NaJ/ede2+MnP9vg0ATOyzKcAFyT9DXmzYcOobAdCPVXfPc1uBGEbGqzBL2fylQ4XYLrF4B1IXsk8GCOdo7Jyrxf4yN7t1+CJAHfz2cPirDQlSfaQuDdA1qf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=H8V8vweW; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=dXhHm6H0 reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108163.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JFkrrt017733;
	Wed, 19 Feb 2025 12:38:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=28cwe71LQ29NpFNnKIf6H7jZYK0lT4/VzTtc3X+le7U=; b=H8V8
	vweWEzVFH9nJXCBuNJ6u9S+87aQz69TMJFvu2VRh00HqnCr5+mRQUft7gQ2CtpY7
	Kadoqm7HRpbWb06Bzsj7UCIilwkzp/K4oYbGf9B6kDyXtgDoU6/ItRCQgiIJ9+Lu
	8KJQtWx8q+qVzY0gWXEm8pkpQRm0LjAIUuT1qLYAjqNIwLVObTn3KAcskOovhxIE
	W+MqeKDYGyIdeiOu5JicvUXXOFs33sVMwb3mv3OXAJxcQAP7DNe58tC5iMNyju2i
	wpltzyOT7HXHLyEasSDrmqH8uKW0jTdH6OC/1r7i8xrQw6dTy+OKOrSpeZOcAAwy
	/3CiUvdcvYQZbKRJoA==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010002.outbound.protection.outlook.com [40.93.6.2])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 44vyytkd8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 12:38:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KqBeB0pEKTZiw5yM9XpOrRXLfMXThgMICdoFZU8YO2DTRPoHXLqizmrsENQMxEwkZ9n0PmroCU6h4mbmI5VKtJRZPRZPq+7xGdNiD8/37rUaYCBXdMmxHq2LvRwtvERjx3C0b/H4IeqnLsT3tymJWlhwQn4mmLivvgIyrtV1tkuX8RA6/Qc/CujjG4ICHsZqeQY5nBSGbSOyMS5TpiNUz69/eBrfTcQl3sxjARFDcq5q78eIR7FDIgMaid2b0w6/mJHY0lQnAf2wnZG3BHEKT2/zXFZ/MCbBNcP3/SC7jWYfBODdIXVcAV9R7aHegSO257TqXOAr0vVB8XsNjHnvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28cwe71LQ29NpFNnKIf6H7jZYK0lT4/VzTtc3X+le7U=;
 b=v7m7w9STkfA6yDqBnW/I06BkQDIE8Swf9itvxCW2LAzy1Fx4ALKtL2+w0hfP7ytS6EJY4L2s+CwOGDLh7ZGqZ4o2W60LK1Dm4KwoHpmOL6HksMONT1xMsVKem7bDPspFkDnOJVCP7a66Q7DE/TxjQkz9AdXm4sclzTksyIRHnzmf75Eqwg8EYQRA1eOW7FySAeeqb8iqZnYmtSZ1JwbozBxmgrmFHiV0AN6NXonhxtysRJ1wxDDrOpr/BfDdSUjPIlSdI90QeyBWLGXjBnrl/aKGb+OeSvVmAD13wcVycsj/2ZU3VTXSqw53MmD56O+Ftt/Kx3rHur7We0tRw0SGXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28cwe71LQ29NpFNnKIf6H7jZYK0lT4/VzTtc3X+le7U=;
 b=dXhHm6H0EzVvVVlW6aNaxrfycbb0Qc5QPyaJ3p065gDvlLL3jp9GUa3hkx0cMSM6arIif141mYlw06JqKSKkv1B4wZgxfIA0VA508yuFgrLXBAn6EShIl79q4QJUMX+yyQA+u/wlg/Mua8xvGuQF8Gk3vf7XcEHX4rFqFBYSgCY=
Received: from BYAPR05MB5799.namprd05.prod.outlook.com (2603:10b6:a03:c9::17)
 by SJ0PR05MB7788.namprd05.prod.outlook.com (2603:10b6:a03:2e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 20:38:52 +0000
Received: from BYAPR05MB5799.namprd05.prod.outlook.com
 ([fe80::e33:dc6a:8479:61e2]) by BYAPR05MB5799.namprd05.prod.outlook.com
 ([fe80::e33:dc6a:8479:61e2%4]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 20:38:52 +0000
From: Brian Mak <makb@juniper.net>
To: Kees Cook <kees@kernel.org>
CC: Jan Kara <jack@suse.cz>, Michael Stapelberg <michael@stapelberg.ch>,
        Christian Brauner <brauner@kernel.org>,
        "Eric W. Biederman"
	<ebiederm@xmission.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds
	<torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Topic: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Index: AQHa6Cyyr+Pv/zK/REOrOTMOkQf+lLNN9PkAgAC4SgCAAVa2gIAAOzWAgAAM/oA=
Date: Wed, 19 Feb 2025 20:38:51 +0000
Message-ID: <F859FAC0-294F-4FA7-BAA1-6EBC373F035A@juniper.net>
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
 <20250218085407.61126-1-michael@stapelberg.de>
 <39FC2866-DFF3-43C9-9D40-E8FF30A218BD@juniper.net>
 <a3owf3zywbnntq4h4eytraeb6x7f77lpajszzmsy5d7zumg3tk@utzxmomx6iri>
 <202502191134.CC80931AC9@keescook>
In-Reply-To: <202502191134.CC80931AC9@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB5799:EE_|SJ0PR05MB7788:EE_
x-ms-office365-filtering-correlation-id: 8900679b-8c83-4b94-1d27-08dd51256bc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Og0PiMdMTfJS4QQz2YOk+VTENH7i22DygnXfiMaNmyXrW3aIP7n0WZM4PjTB?=
 =?us-ascii?Q?3eX8qa/0HBaDNGy7SfwcuP5EhWRaMP9ONV6nfDZ7LFVFtfb9CcS1FKj7MOui?=
 =?us-ascii?Q?fVmUZdB1ioaCbamh+sdSqI6sN4lYsQJRFPi25z+Wl97FM8hEAsvAZaV6XbrB?=
 =?us-ascii?Q?KlbxZu23PfP6Re6i8DP+Ky9Fsq1GXT1KoMuPMN6dZPoQbr8yRBVmQGSpJRSM?=
 =?us-ascii?Q?8sY5nQ0wfJo8w1jHsvGljIN8LW3Dy2M2kFwZ/QKQS97vbiy6Lk/65G200dcq?=
 =?us-ascii?Q?ScVEfdpPoahM0AUYuF5XNTc6Y5fdM8veFanTkMLFdW3mAn3BGZuuDVEpcSWR?=
 =?us-ascii?Q?SUwzbJVscPbsrPJH12pu17sgJomZ5+nxK9SNKRjsr/pfy7Hp7tV+keLbvTnj?=
 =?us-ascii?Q?AtDetGy0JBRv1e/oF9EnDKa284HXKPqkx/dHm6OdVSVgFI0I7+0WaKyX54BN?=
 =?us-ascii?Q?Zf6TdGygnjRS4f1FK+M6EL12F7VRteOoYPNk30NtNTrsozAIaJJE7PX5jXct?=
 =?us-ascii?Q?djQ9bPWLgmW0lR2+oQJExrtjdgMp7at/EeAsACmeEVqnLLEa6YupeihcWqmQ?=
 =?us-ascii?Q?fkU1epGYlQyPd+lQnuqnup+fXlevWTlgtdu0DTuE0lOPedxrqBywvy58azMr?=
 =?us-ascii?Q?kTJPFSk6FHEss4B+Cokocm9bTnHUWOkgh/wKD6D2iWy0mr/mclHTlB9wF8nn?=
 =?us-ascii?Q?7F/Ski3ngfvWuRRjlGMQk8hGkYcsTUygd8GeRqQYaf8JKf4CbYg9RTh5gY7+?=
 =?us-ascii?Q?nPc7RQGl0/RodGW5S9hhN4kuef1A3d5aTb/bTTdLe5FnLMn4fvVJDwLpDWT2?=
 =?us-ascii?Q?tEH+lQdKoP6OY64dnDPfiOj2rnPd7+wuiizjbz1O7582ci2WIuvD6sP4+K36?=
 =?us-ascii?Q?5giyX3M+MT53LNX3GqfuftHm6jOhufkIGhJUi7NnYOdMvu6d2VysdGVyUCAU?=
 =?us-ascii?Q?Rkru+7HOpYtM37NUeJXrmCDmojWoKinJ+wxF4JlMf3tlpFx1O6tBJBDNtsuw?=
 =?us-ascii?Q?26uSdkmk99hFqLkSaIOBCBMfUacJ05b74I/XQomuxEF3MC7d/peC6/GmzA3h?=
 =?us-ascii?Q?TojlZqDfew8FU46hM/Puv4zGkoXWVEzKy//JcrlTpyTd1EJkBxBA/ZY0KFCS?=
 =?us-ascii?Q?fdilXB1aQqlIHCxKEdTr1FUgfr3dcEAyEJZLtWRXqVxddjbNk6h7+QD33qzU?=
 =?us-ascii?Q?lsdorsOFBoeJ2DUra/Qm30o4WBKN+yBf7LwdCHks0vESx3SAH+4hwOZqvecx?=
 =?us-ascii?Q?SAsIfgPwyPusRYS5JjkLwntMKnAlD/iH0lRJtbTngTct247Ob0+cEMVO7kJN?=
 =?us-ascii?Q?H/63D3sYfcy8lyFr7DyR3RDVA+m7LTkLCDEAcLvXjkE0lvqJuE8K48/QoX3z?=
 =?us-ascii?Q?ypyQmpdQ53xFHUUJQvOvMU4WhFi2L5wjyOD4W2NkJmDETPeFaBCsfsj+uhPz?=
 =?us-ascii?Q?uGy/rg38LA5OlzBOU9ZvXY3Ureu7mm74?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB5799.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yVX/gBJNEq/GM4UeB6LOFkX5tyQlUX9ldD2sK7/DF+drl/tXBOpa6/sj6A6g?=
 =?us-ascii?Q?BrpTjem6A7wRUFU9E2fRvqordxPkeDj+a3bGs8w0V5VondqcDR+R9m/F7vEe?=
 =?us-ascii?Q?ybGkqRkQYILnI6j/tZLxQksPs0ZXzY79e6J1Ac9PNjD3oGLFaU/qdJQ0BYf2?=
 =?us-ascii?Q?6CSLtWnZV2TT0FXJ+NcZc8FTfPMj6+YkEXSBiKmyqaP5lrIKIgQf9CT4F7pp?=
 =?us-ascii?Q?mXIZ40yFozeeuNGXF8B+MGZA1XPp+mJp/fFCfP5RK6DQo8+4m4BMGUOlg8QC?=
 =?us-ascii?Q?G85C7djWDH/V0wsPvZ4y0k6ON2fc8fDIta3DZ5+ybmTg4gnHmXGa2ZE3REeB?=
 =?us-ascii?Q?6xj+4uxmKAgK8I0Y8tuyE1J9mtRo0sCL2mN/68yXHJgdUOFYSbAukERbpDlg?=
 =?us-ascii?Q?39ESLdtSAy3cr+yCA8/2DrtiBLlV7xcwAwbomqT7H4IrXT69zW44tEQz9l2U?=
 =?us-ascii?Q?bQFZK/TaUOeiyUSFwB3l/LVmPJBlgRORx4+bnFlcWaERXhTt9duF7xqzyn5W?=
 =?us-ascii?Q?dqfLV2mCi0du4Mbhyxi6RmmB5AJbhMkm7CgE7OWOksYMBhUyLa+CRKroDoAX?=
 =?us-ascii?Q?6ec0TTNAbw+sqsvnLrkdoPHnvHUVFyBZPSCjm1DDsqgy0TGzANBb4G8QyAr+?=
 =?us-ascii?Q?r8iT0i+qimLdmEQl/S/SIWfl4t79s1w/A24v7vEy7LVf3qA+98KWprv7tcXr?=
 =?us-ascii?Q?OyuqaUO+YC7aqqSAb4ScrzlDwCyMTdwIEz/wT88hzaSTs0dPanxsC3sXnLTC?=
 =?us-ascii?Q?X0FRa+gSUfV6yNLtCgVym+mqMeRWwBVoA7VqI2gnAoT8fM2EdwMUnQpuMBk2?=
 =?us-ascii?Q?FPq/hZDSu2BT12INU2l2rEr3kTXjIYkoRQIza7XAP8ER/bBiL9CH/BtvJZWL?=
 =?us-ascii?Q?IqAaAesusWbo6g0I54LsTtkSf9zl+MnmwWSAcuu0ZFnk347ZcsB/99+FKK+K?=
 =?us-ascii?Q?9yUYwCJdqv2eA5+cgkO+JNT3O4+wDTEOpVMdLh7CbKPQV4ckNNsMJLttu3K0?=
 =?us-ascii?Q?vFQ15AJ3cY8afZAz6jlqjQ0vxKQA5sbvkZQRX7/BUiWk71z+kMoaWodGW2VS?=
 =?us-ascii?Q?ir0uZZk6RjQa5cALgNhs6YWKqIbzaUobgSNn7Tx5A20e6rqMH9dQ2OwtHPxd?=
 =?us-ascii?Q?KiqMaiFlHa6op/C+yACABoUzZLINd/KJX90PaCWP+M8l1tppt0lNRbkIDmsR?=
 =?us-ascii?Q?/nCq5IbXChlbQ/rOy5s3H5N0AcXhJyUhh4GPxzSVilNzZkH8kaqAbq0iSmnp?=
 =?us-ascii?Q?kXJW7NDV76OViTiRjiXH6PYAcUXlbvGHEXAxR1NgKAlFZ/Fpi8yC1LTJ57mp?=
 =?us-ascii?Q?98XMsyJag93nQE0mWcQ8IkrwAbf687gboC0+gXnenSIE9g/2d0y5SsYpvsYV?=
 =?us-ascii?Q?fskIRBWZGd6TWsuFy9d08WyASZSH2lgHybu9ogYA54Hj+D842Mx55WbgmEag?=
 =?us-ascii?Q?CH48sLZlX38YWmaurXa4K9c7a7yPYOHavraVTK9bC6GSDdb7OPHfUfE+sGFC?=
 =?us-ascii?Q?ozIifwarepkpy5V7ZxfEnYSQrlykNPuslylOKKmhJchZl8KQlpCEugGk/5qW?=
 =?us-ascii?Q?PiObqXSG6cFY+dTIU8Zt1DUQdyenc+cuSQXw0Mq8?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <126C3202096DC94A818913CB0F298FBB@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB5799.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8900679b-8c83-4b94-1d27-08dd51256bc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 20:38:51.9911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/dTgbKUDf6SGTa6IXPz+XwnQusKAnHlq/ck6KKsUEMG/eKghflF/VOF1X3r8o8NSDHi0RWgPg2kRwG4bhFO1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7788
X-Authority-Analysis: v=2.4 cv=F72tdrhN c=1 sm=1 tr=0 ts=67b6415d cx=c_pps a=joY0rRILPjs92yFVhGOM/w==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=cdyz6TIjWnUA:10
 a=rhJc5-LppCAA:10 a=VwQbUJbxAAAA:8 a=_A7RdMXfBQ7pmIc1qYMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 6Nb4mfQitaeaxhWpLxJSi63GOhloC4YX
X-Proofpoint-GUID: 6Nb4mfQitaeaxhWpLxJSi63GOhloC4YX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_09,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=759 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0
 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502190156

On Feb 19, 2025, at 11:52 AM, Kees Cook <kees@kernel.org> wrote:

> Yeah, I think we need to make this a tunable. Updating the kernel breaks
> elftools, which isn't some weird custom corner case. :P
>=20
> So, while it took a few months, here is a report of breakage that I said
> we'd need to watch for[1]. :)
>=20
> Is anyone able to test this patch? And Brian will setting a sysctl be
> okay for your use-case?

Hi Kees,

Yes, a sysctl tunable would be good here. I can test this patch in the
next day or two.

I will also scratch up a patch to bring us back into compliance with the
ELF specifications, and see if that fixes the userspace breakage with
elfutils, while not breaking gdb or rr.

Thanks,
Brian

