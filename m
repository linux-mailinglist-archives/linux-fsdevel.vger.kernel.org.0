Return-Path: <linux-fsdevel+bounces-76900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFtiMxSzi2mRYwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:37:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2DC11FC42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17C8F3051A84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 22:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32617330307;
	Tue, 10 Feb 2026 22:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="slsevOnn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDA32FD1DA;
	Tue, 10 Feb 2026 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770763011; cv=fail; b=rTQ8EdPa9O9RIJyPLci4dwrYUl4UHJPfaOc+NT9BLYaeiUaxbqHjzr7Fu4ta2S1esH7j+x9QJgibyfFTCCoRTl2W0DPEFq3z+51OdgXL0H2sIgFnZvOYSL5mZKpFbXaTwOfD+lBFVqVycYw1KsElvpf+H1y1GTldHvy5qgGuKZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770763011; c=relaxed/simple;
	bh=KiLLx5O1hQcjljt4E1NEvXPMEHJQn+e/wh8nd8PFnYU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=HlFevzcmopmkkEwPg1NW2Y28JReu4GpNybofusuPzCS2QHwpqFmiKNmmm2qRGxAdpIc7p/CBV/nr3JA2wlwllH3E3jcmwPpfU3I2NhNq93DSxarxbtb2EFfhog0JBme4pFZwbCfbpXniD2KpRwHFel2rwAEdnnonQQmIFsjCOcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=slsevOnn; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AKqojX024044;
	Tue, 10 Feb 2026 22:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=KiLLx5O1hQcjljt4E1NEvXPMEHJQn+e/wh8nd8PFnYU=; b=slsevOnn
	Ko9Zv5HxQJEwsOrc6GaguCaLpGRiO4vWE0pDwdHN3L29wskEa2b76fE4diKNaOyp
	UmOSdNH+JTZYMcr8Rb9bziRDAswVdUh5XCO/LF2DI9TVBMCUjHGLcb85QikGA+FS
	SWi3wNh+/opujLbIq+eDv1PUi06akTw8N3LTKUJz6+/CtX/FpQGzXZMKrCqodkBZ
	yH8UGvUr7CDX/lGw3Khn2e1u2G72SfSQ/b4U3IHbwUibUh0vw5hMbgnhayKlLzP3
	Q8y/MCrEUvhD96Egn2wwc3cFOD6sXc83iAjpstSXHRGE83bW3hvWoZd1IwBBT6uc
	WdeDWr8S+46JgQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696uenaf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 22:36:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCAcMDIagZ3VqGGzilWjzHkHJU5QA9AoTAdqln14I61EFfa/80b4hGgEckfGId48s6h2cEGENRyOnJYO+/Fa/Ivgsu0m8ASMR6maIUBOlva+s7/eKwyzFS9oxj2FUUsdKK6Lch+uqV9sYRVI32jDaad+Nv52AAXdVRK3BAgWel1BpVDUGj/JfWE7zL9k71nYademBlIWNLRVgj8QprT2WRnF93k2kjjyAm3qxnAYO6muEi82qbrPXKYQjfoUe5IYi1hvBkV5VDyYHbN1OiNsoGRJTEHzOCMG6CC4OiAqxPVVVFzQuIK0kQ/MvJC1sH53u1rdtbhGvl4SyMTP54N81A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiLLx5O1hQcjljt4E1NEvXPMEHJQn+e/wh8nd8PFnYU=;
 b=x0IpYKmnYGWb7UyMAztpGpnOdfuZDhGp+IOlYRbt3knrySDF35V0m4rq2Cc5e1wchHubT9bffD5BoZghLXC5NyU7xswk3SKVs3h3n5eUkXoIv7bA9x52xIMPfkoXAakOGaCiG1i2THqsCjdmi43lV84k95QbJhZBFDpCfa3Cq+2nm5FpByTEWC7kb22bLwl5uqBHMqZ/8DTAPt0mHZqR1Ext9ynsCOg+OIOtng3Cp6Ii1DTjIdxTatXd14oh1FFRhE02WXP+l11AYbGGHe2c0x9SlOnNMGNRqKq3BVeeZwmM5qxJFblqhPrpc5GB1B7qXblxY/6TmqlPTWps/Wzu0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4974.namprd15.prod.outlook.com (2603:10b6:510:c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 22:36:35 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 22:36:35 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "jack@suse.cz" <jack@suse.cz>, "clm@meta.com" <clm@meta.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org"
	<linux-mm@kvack.org>,
        "chrisl@kernel.org" <chrisl@kernel.org>,
        Pavan
 Rallabhandi <Pavan.Rallabhandi@ibm.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>
Thread-Topic: [EXTERNAL] Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Machine Learning (ML)
 library in Linux kernel
Thread-Index: AQHcmpPXPV+chNeGskiA4zJOQ4d3LbV7+8WAgACKfgA=
Date: Tue, 10 Feb 2026 22:36:35 +0000
Message-ID: <c24a209d5a4af0c4cc08f30098998ce16c668b58.camel@ibm.com>
References: <47d21a6821c4b2d085f7b97bcdaa205bfcb0e0ad.camel@ibm.com>
	 <CACePvbVH0ovOcBqCN7kJ3n0QFmvuf+_5tMeRXs-JAQ+m5fdoCg@mail.gmail.com>
	 <a994bdedca7d966168076044249a58e52754c6ac.camel@ibm.com>
	 <6ek3nhulz72niscw2iz2n5xhczz4ta6a6hvyrlneuyk2d36ngx@4ymlemzifugr>
	 <a1bc8ccc-730c-4076-82ec-20bf86dd100b@meta.com>
In-Reply-To: <a1bc8ccc-730c-4076-82ec-20bf86dd100b@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4974:EE_
x-ms-office365-filtering-correlation-id: bbfe6603-f699-48ad-8767-08de68f4d8e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFg2cStxUVVHNUkwdTI2RlZpSkJNRXZTRjdVakg2YkY4Qmx0YVBuekU2UEJI?=
 =?utf-8?B?TVh3UFVhSHdMdXppOGVvUkV1RWRyS2x5UFhKZm1iTDlENUxVV0dnTERBMllQ?=
 =?utf-8?B?akhQUWk2amZuTVFnUGFZdGxXakJqRXlDNUVwaUV1NTNRb3dQM0RJSWhqRXJV?=
 =?utf-8?B?RlE0K2tTUnhDclRRdzQ4RTFXcG5XK1BLOHJoQ053TWZMS1pDR2t4Kzdaam5F?=
 =?utf-8?B?TnE5MFQxL1NOSjNodWN5OWZNUjNaWjc2RTk5eGRMb0FmMUxtMDhNM2FKWEdM?=
 =?utf-8?B?RDhzKzJyUWt4R0s2N3VHcXgvMnNYTFgrZ0hZcGkwMkNPVVdCbUZhdU9CTkMy?=
 =?utf-8?B?b2E4cTVkOWFUOUdrQlMrUEJwQ1BsdHhpbmp0NWJSVEpyeS9TS0tCb2Y2VXpk?=
 =?utf-8?B?WmN3KzdGbDR1dHFJYzZ5ZU5sVjk2TjkzUE42ZnFORDZXRGpmU1VjMjVHR3Ra?=
 =?utf-8?B?NHVSUFJGYmpQd1MxeUVYTUJQbUtxbVF2WGNpYmtJK2drM0hzOHorcGE0NzM4?=
 =?utf-8?B?b29MTFhNd2dDbERFZjN4TWkwQ05PVUU3cER2aDlXMDRpMEJNTUpkbzNTSTF2?=
 =?utf-8?B?dWE5V1RrQm1CK0o4eGpGWldCSGhpVnpGMXFUL1hFSlRGRTY3OWpHVFBTU1V0?=
 =?utf-8?B?SXFQUVpMWFcyUDRTRTQ5MFV5bW9IMTFoNHpkREtYY29FaXZ1Ums5bGcyc285?=
 =?utf-8?B?b212am4yQ0dKdlFFT05Bbi9Hd0NiOWxTNFhCTzdFUzdva05WdjlhOWI2TEo3?=
 =?utf-8?B?eU5neGRrRklRTjV2WXVPN0toWEc0REx1M1VucG5ZUlAvaWdiN0l5STV4WWtO?=
 =?utf-8?B?SW5MZGNQTjM0Vm1hSkNwOTlUK2M4dTY1UUVpY3ErN09mVXFReXozU3ZrazFB?=
 =?utf-8?B?UlgwRVJJc2JBWnQ3a00vUmdEREJLckpKc2dva2ZnZWc2R2RTWDFtWGNVemRk?=
 =?utf-8?B?dVNoVHl6Q0ZhZWtFS3p2d1ovV2ExaVdHWjkyOSs4ZnQ5b3pha0hDN3pKYVo2?=
 =?utf-8?B?RXM2d255V0FmdUU2QmJJM2xYTGsrc3NnYzhaUE5vRU9mK2dxUFJSdGV5YVNT?=
 =?utf-8?B?MXRCTkVOZVovWis4TzhSSXBZYVUrY0h2RjhGR2o5bGxGUE5GMHlKUWRjWlpZ?=
 =?utf-8?B?OEluOUNPdWo2aXJzRkFMVExpeUhKVlZMREp4akRLbElwbWp5WWVyMGh4Zkdi?=
 =?utf-8?B?Z2FzY2VicjdrUDFVanl3bEx0UFJKc203R0RZT2M0TUYvQm8vb2JJSEVWNE1C?=
 =?utf-8?B?ZWxTc0VrZzFsNk1mZGYwTW5jVHFwZFovUEttMmk1c0g0MnM0eXM2bFBmVHJW?=
 =?utf-8?B?NGNMYUVoUllGanRaWlMzTWxRcjNvUDRkcDROTEhTZHJ6Q3VyUVlJS0ZTTm1U?=
 =?utf-8?B?Q2wybjZXQWxzR3hMZnY0SEJoRi9tZWJKd2djdE1iQyswZUJVMHRpN3VwOUVa?=
 =?utf-8?B?bC9CTFN5Z3RGTkFDdVRpbk82WEhBNWFTbEpyTlBDczA0NjZ5dDh4UnpHRmth?=
 =?utf-8?B?V3BqOWREb1BGTmYySndGZ0dscnVveUMzSXc5TkFTUndIandGRkUvN0FuK1FM?=
 =?utf-8?B?VGtJcUFBbGg1WmRHdEJCRDFzOEFMNHg5YVU0Nkc5WjJWRllDSlhFN0ZFdk5k?=
 =?utf-8?B?Q2dnOUhqZUFMbWEvNmFkMW9QR1RtQnJOL0VKcXJ1OW1JZlN0ZXJSRno3eEU0?=
 =?utf-8?B?Mjhzb3JPYlNFaVJ4VkFiVUwzY0EvNDhLR0V0Qy9QQlhZanVGQ3AvNU9BODZN?=
 =?utf-8?B?MGNwNUVXTm85QjBCUjhtc2NBc01UYk52TmtacHZ5N1lSUmVGeG01Y2dqRmF2?=
 =?utf-8?B?U3VVSnlPK0hCckFBcG4wS2p6NG9iOExYUG1lTXU5RUl1TzBCK2lPUmVON3Vv?=
 =?utf-8?B?M3E5ZERkOFhpVmxjLzlkbW45OHNHSk4xNUtBbnRwS3NySzEycFppZUZQZE9H?=
 =?utf-8?B?M1E0SlgxcmJMQ1RsU0d1WklNek52K0c5V0VMZEhHa3RSSVhwaWZHNWR5YUNI?=
 =?utf-8?B?SEsvMlo4WGZQZWtEclUzWVJOd2dNQ3c5cFhOMFM5SU5hdmxxQ0NUK1Zxb1hD?=
 =?utf-8?B?ekFTNURycVgreWpYYzlrSEdJU3ZLTWl1LzhJRHBZbzNOWm1udlBoSnlmWnN5?=
 =?utf-8?B?RFNYYWtkL3duc0V3cFdzNkdYbGRlZENTNlRWWlNEUTN2UHgvZDlnd3d4N1Zh?=
 =?utf-8?Q?T3ekTj6HIw1NujNZlo1eWxg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0dPUVR5b2ZDN3N3SlY2VDF3VytodE9IdlM5T3lqOUZNRWVUcXZNNGZHWWd2?=
 =?utf-8?B?TG5DYVlsVDVtZzBsakJlNG8yMDhXQmxIemsxVzBZU1U3am5HVTlpTTJVWUwy?=
 =?utf-8?B?Y2RvTnE5aUc0V3NnMWt2QmtQMCtsZjFMMHBKRWZzZWo4R0l0NXpPTjBCWVhz?=
 =?utf-8?B?eW9zVml2UlRkNno4Z29HSXNqbU82TFBKdUUrc2dpbmF4V0FOTTJOazdDUXRy?=
 =?utf-8?B?QTkzd1hFcENZaVpXVkRuWTdSTjFnUXQ2UFJRU2tvS3NLSkFrM0lBaDJHeFY2?=
 =?utf-8?B?MXhQUXVVdm1tci8yWjk5WDVHWnpGQ0x5dHNMay91bG95NllHN0IrVzRYcnJL?=
 =?utf-8?B?elZDMG9wWEVJK2hJdzIvZWhRL1hKQnd4R0IrS1FIKytwbHRoU2dsSXpoSC9I?=
 =?utf-8?B?UVNNdlNRNWlJK3RVM3pIOEJyTW9NRmR0MUFiWFdnMEVyZ1NEMkwvMWpCT1NU?=
 =?utf-8?B?MXRJMlJyOWZaYUU4QmI0RFRxdXVtdHlUblJuZis3WENXWmFWRi9MRGkyeUFh?=
 =?utf-8?B?NEpsR28wWW5DcW9GRGVmZW1ZQXZIbzl0bHk2SmhBRC9UTTU1MFBiWkQ2eXFp?=
 =?utf-8?B?TnhzcCtHNGNwQ2hydVhxZWNmMHJ0S1J2Z1lvMVBlODJjUGdHSjBPZ0lzbW42?=
 =?utf-8?B?c1RrbnltRFRpNVVMRjRTRUFQL3BkSmZvUkRzejNnNzZiRU1XRXlsM2pNQUln?=
 =?utf-8?B?KzI2VCtzNFhTUFRERnBUR28zR2tpaFNSTU1JSFhsd3BsOTBkMVhGMWR6VUQw?=
 =?utf-8?B?V3pMNUxkK3B3bHVnbmZVUG4wQmZIajlDZEhsYkhTelBUZ1Yya2VYWVBPZVZD?=
 =?utf-8?B?cHd0QVRrQWxVVlZMbE9OK0ZwRnBGUDRnTUhINEZLeXRqMXRqaVAvMFZ6aVd0?=
 =?utf-8?B?a1NMd2NlTlNzS3kxODBlSXFNcFZQemNCNm5KZHBRWTRETVNraVhHL28rQjRa?=
 =?utf-8?B?ZzNrdmJ6SWQzc0JJcFhOSWQ1bVJPSWpSUVNvamtkcnJ0c0MrY0UwNGFYZzVF?=
 =?utf-8?B?YllkYlc3YXluUUR0Q3F6R0dzdytKQWpvVnZ2d0VoMHlVbTljaWp1NS94citP?=
 =?utf-8?B?Vm9pOHgwS29JbXpuTTQ0RFBFT1VCeXFmbzZaOWtFZnJLcEUvLy84K1FMbFYw?=
 =?utf-8?B?bnBNQVZKa3haczRPdE82S3dDOGI0cEdOQ213bm5sZ3NwcmV2VVhZd1B0bEpr?=
 =?utf-8?B?ckoxSDI3bTZmM0kxQllJVitRTi8vaUxxb3dPVUhLWm8rVnhUMDQ1NnJTbzBz?=
 =?utf-8?B?b05pUHJDR2tOcWRJaGJIaEQ4SVJwYjczZEdyQTVUQTFNWmxjekVLSDd1aDAv?=
 =?utf-8?B?MDFobzVkVU5IZlhKNGNyYzg5TGJXeEdKUFMrdGpNM2lvTUZaWmtEbXJJUW1W?=
 =?utf-8?B?K2xQQ0thcTF4UStwMHJmbEF5Zk1CWmx6OHJlNmwxYjcya2sxazk0Zk9IM0RL?=
 =?utf-8?B?MU1GUG9uaCs3Q0s4MVBpVkVnRWpqaldUNi81U09GQ3J1bG5YSXVJazZQWUFt?=
 =?utf-8?B?dEUxQ28ybE52THM4YnM1MG9HZW5zQkhBT01Jb0VabktKN3k5MWV4M2djT3Ex?=
 =?utf-8?B?K0lYQjRMdkNmK0hTK1hsd0V4Uk1IcmtYaVplQlJXN2F1Si91MjVQd09TZ0dK?=
 =?utf-8?B?T0pyVHdQQVJLbHFac2tjYWNLZlNxa01zei83Ni94SE90Y3poZGNFeVU5Tm45?=
 =?utf-8?B?ZXRJaUVPRnpGVmlLc1ArTEk4Z0pmeHkrQ1ZVQXkzMml1bFl0eHNDd3lMTkFp?=
 =?utf-8?B?US90dnh3OUM2a0xNNkdhVzR0bFhHMXJyRjFVQzFVcjhLTlJBekFnWkJ4c0V4?=
 =?utf-8?B?ck1ielJiNU8vVEJlcWFXclN4K0xaNGpTb2dZdU1BYmlrRVp0WVdqWmdzUEpB?=
 =?utf-8?B?eFlXVm5Sdm1vS2Znb0poNFpEWVBjU01WYUhCb3djcFRwbWpXcmtGRUJhOTV6?=
 =?utf-8?B?Vlh3TDZWbkJ4TlZRVDU4dWRpc0RWRHljek55YTVyRnI4b2VUYU91Vi81Sy91?=
 =?utf-8?B?NlpwZS9Db09mTmVMVWNxV3ZxNWVtdWhwdnNhVHB1YWNldFg5R2Yya0lRQmFy?=
 =?utf-8?B?TnBhQWZja3BORzJlUnZIVURrdElZUk94SEVMQXllMlgwR2E1SFBmcVdqeFl6?=
 =?utf-8?B?L0c1K1RNK2hndTVOV0dmVVpmRDhUZWFsNTRCTEdBTlErM3VWUUsxeFgzZkJm?=
 =?utf-8?B?cWIwZC92eTc4VUQ0KzRialJuSVZESWpxcXhNRWxMZUltNDZsdXNkdU5sKzZD?=
 =?utf-8?B?a1BYOGc0ODkxaHl0VklNNGd0TldhOWJtLzFlL244RFB3U2JiUVJIMTlYOVRk?=
 =?utf-8?B?OVBkSExZcWhrM04zNTB0bXIyTURER1ZDVE9uWkt4UXpSSHpSek83MytBeXZ1?=
 =?utf-8?Q?NOC25xis6GAuCJssaD8Uw6tGmOAb2Tv3GXC/j?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45DEC3203B92084C811E69CBE44272D9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbfe6603-f699-48ad-8767-08de68f4d8e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 22:36:35.2505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7gdkPCJxDsBAZlvAGjVl7acaTp7U5hOj7ZFbv7KDieR6rQ9RFIAYzg7Chg+GpbHBwhVf3vh/z5JDg59SK1C+iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4974
X-Authority-Analysis: v=2.4 cv=KZnfcAYD c=1 sm=1 tr=0 ts=698bb2f5 cx=c_pps
 a=P3qATxxxYOxA1bnNUqDMzg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=P3_vRw78SCAbPuaL0ooA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE4NSBTYWx0ZWRfX8AZ2aiVhSUeZ
 0RyI5wNP5NtXeL9PdU928eFYfbJ0iAIScYYsQMZNsx/JUmPcdv2A5Ye2iCrBWYbHtzEXn0KWr3U
 oGL4IsH3f95kbNtVD23zxc5kcWOofaBmEQf48yJ6jZe1T3b2k6tVZFlom/d8BBh9gRe/shwzMnZ
 hT5Yvyd/Dl4PznkB77fmBHTL4qNhncAwqbNgTaf8zp+Wsn63jz4SKOr4xAtuwH1r8cn3xwy1KKM
 57MJ+OsQLUmmALdB/6si4fe1uLG+JVkhyB+VduL4voR3ixmMVKFp8MINGeKFzlX7SC1l/FsIvYG
 AWcbJPHsUZk6KwVZ1/0xJg3mzUF2Az2eW8Dx8KEY9sm4b26tHUa+Q2w+X8a0P7WVfi47QB36Vvh
 lYjDKocVetFRUsMxOGbz0+h/TtsU84RniBiSI5I5Q8CGJzlORHlcD6Om4M+G8EoYwkuxUtIixhq
 UvgKyPR31R+VY0H6vwg==
X-Proofpoint-ORIG-GUID: zZwJWp17jWrW_wnbX49QGBdPXaKzNxyH
X-Proofpoint-GUID: zZwJWp17jWrW_wnbX49QGBdPXaKzNxyH
Subject: RE: [Lsf-pc] [LSF/MM/BPF TOPIC] Machine Learning (ML) library in
 Linux kernel
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100185
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76900-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,proofpoint.com:url];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2D2DC11FC42
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAyLTEwIGF0IDA5OjIwIC0wNTAwLCBDaHJpcyBNYXNvbiB3cm90ZToNCj4g
T24gMi8xMC8yNiA4OjQ3IEFNLCBKYW4gS2FyYSB3cm90ZToNCj4gPiBPbiBNb24gMDktMDItMjYg
MjI6Mjg6NTksIFZpYWNoZXNsYXYgRHViZXlrbyB2aWEgTHNmLXBjIHdyb3RlOg0KPiA+ID4gT24g
TW9uLCAyMDI2LTAyLTA5IGF0IDAyOjAzIC0wODAwLCBDaHJpcyBMaSB3cm90ZToNCj4gPiA+ID4g
T24gRnJpLCBGZWIgNiwgMjAyNiBhdCAxMTozOOKAr0FNIFZpYWNoZXNsYXYgRHViZXlrbw0KPiA+
ID4gPiA8U2xhdmEuRHViZXlrb0BpYm0uY29tPiB3cm90ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiBIZWxsbywNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBNYWNoaW5lIExlYXJuaW5nIChNTCkgaXMg
YXBwcm9hY2gvYXJlYSBvZiBsZWFybmluZyBmcm9tIGRhdGEsDQo+ID4gPiA+ID4gZmluZGluZyBw
YXR0ZXJucywgYW5kIG1ha2luZyBwcmVkaWN0aW9ucyB3aXRob3V0IGltcGxlbWVudGluZyBhbGdv
cml0aG1zDQo+ID4gPiA+ID4gYnkgZGV2ZWxvcGVycy4gVGhlIG51bWJlciBvZiBhcmVhcyBvZiBN
TCBhcHBsaWNhdGlvbnMgaXMgZ3Jvd2luZw0KPiA+ID4gPiA+IHdpdGggZXZlcnkgZGF5LiBHZW5l
cmFsbHkgc3BlYWtpbmcsIE1MIGNhbiBpbnRyb2R1Y2UgYSBzZWxmLWV2b2x2aW5nIGFuZA0KPiA+
ID4gPiA+IHNlbGYtbGVhcm5pbmcgY2FwYWJpbGl0eSBpbiBMaW51eCBrZXJuZWwuIFRoZXJlIGFy
ZSBhbHJlYWR5IHJlc2VhcmNoIHdvcmtzDQo+ID4gPiA+ID4gYW5kIGluZHVzdHJ5IGVmZm9ydHMg
dG8gZW1wbG95IE1MIGFwcHJvYWNoZXMgZm9yIGNvbmZpZ3VyYXRpb24gYW5kDQo+ID4gPiA+ID4g
b3B0aW1pemF0aW9uIHRoZSBMaW51eCBrZXJuZWwuIEhvd2V2ZXIsIGludHJvZHVjdGlvbiBvZiBN
TCBhcHByb2FjaGVzDQo+ID4gPiA+ID4gaW4gTGludXgga2VybmVsIGlzIG5vdCBzbyBzaW1wbGUg
YW5kIHN0cmFpZ2h0Zm9yd2FyZCB3YXkuIFRoZXJlIGFyZSBtdWx0aXBsZQ0KPiA+ID4gPiA+IHBy
b2JsZW1zIGFuZCB1bmFuc3dlcmVkIHF1ZXN0aW9ucyBvbiB0aGlzIHJvYWQuIEZpcnN0IG9mIGFs
bCwgYW55IE1MIG1vZGVsDQo+ID4gPiA+ID4gcmVxdWlyZXMgdGhlIGZsb2F0aW5nLXBvaW50IG9w
ZXJhdGlvbnMgKEZQVSkgZm9yIHJ1bm5pbmcuIEJ1dCB0aGVyZSBpcw0KPiA+ID4gPiA+IG5vIGRp
cmVjdCB1c2Ugb2YgRlBVcyBpbiBrZXJuZWwgc3BhY2UuIEFsc28sIE1MIG1vZGVsIHJlcXVpcmVz
IHRyYWluaW5nIHBoYXNlDQo+ID4gPiA+ID4gdGhhdCBjYW4gYmUgYSByZWFzb24gb2Ygc2lnbmlm
aWNhbnQgcGVyZm9ybWFuY2UgZGVncmFkYXRpb24gb2YgTGludXgga2VybmVsLg0KPiA+ID4gPiA+
IEV2ZW4gaW5mZXJlbmNlIHBoYXNlIGNvdWxkIGJlIHByb2JsZW1hdGljIGZyb20gdGhlIHBlcmZv
cm1hbmNlIHBvaW50IG9mIHZpZXcNCj4gPiA+ID4gPiBvbiBrZXJuZWwgc2lkZS4gVGhlIHVzaW5n
IG9mIE1MIGFwcHJvYWNoZXMgaW4gTGludXgga2VybmVsIGlzIGluZXZpdGFibGUgc3RlcC4NCj4g
PiA+ID4gPiBCdXQsIGhvdyBjYW4gd2UgdXNlIE1MIGFwcHJvYWNoZXMgaW4gTGludXgga2VybmVs
PyBXaGljaCBpbmZyYXN0cnVjdHVyZQ0KPiA+ID4gPiA+IGRvIHdlIG5lZWQgdG8gYWRvcHQgTUwg
bW9kZWxzIGluIExpbnV4IGtlcm5lbD8NCj4gPiA+ID4gDQo+ID4gPiA+IEkgdGhpbmsgdGhlcmUg
YXJlIHR3byBkaWZmZXJlbnQgdGhpbmdzLCBJIHRoaW5rIHlvdSB3YW50IHRoZSBsYXR0ZXINCj4g
PiA+ID4gYnV0IEkgYW0gbm90IHN1cmUNCj4gPiA+ID4gDQo+ID4gPiA+IDEpIHVzaW5nIE1MIG1v
ZGVsIHRvIGhlbHAga2VybmVsIGRldmVsb3BtZW50LCBjb2RlIHJldmlld3MsIGdlbmVyYXRlDQo+
ID4gPiA+IHBhdGNoZXMgYnkgZGVzY3JpcHRpb25zIGV0Yy4gRm9yIGV4YW1wbGUsIENocmlzIE1h
c29uIGhhcyBhIGtlcm5lbA0KPiA+ID4gPiByZXZpZXcgcmVwbyBvbiBnaXRodWIgYW5kIGhlIGlz
IHNoYXJpbmcgaGlzIHJldmlldyBmaW5kaW5nIHRoZSBtYWlsaW5nDQo+ID4gPiA+IGxpc3Q6DQo+
ID4gPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0z
QV9fZ2l0aHViLmNvbV9tYXNvbmNsX3Jldmlldy0yRHByb21wdHNfdHJlZV9tYWluJmQ9RHdJRmFR
JmM9QlNEaWNxQlFCRGpESTlSa1Z5VGNIUSZyPXE1YkltNEFYTXpjOE5KdTFfUkdtblEyZk1XS3E0
WTRSQWtFbHZVZ1NzMDAmbT12dnJEUHh5d19KWFBya0M4Qmp6QTJrRXR3ZFBmd1YyZ0JNRVhHN1p2
ZVhNNExoUzAxTGZvR3dxaEV5VVpwUGU0JnM9cnFOZXo1X3JtaUV1RTdpbjVlXzdNZnlVenpxemFB
NkdrNDZXV3ZtTjN5ayZlPSAgDQo+ID4gPiA+IEl0IGlzIGtlcm5lbCBkZXZlbG9wbWVudCByZWxh
dGVkLCBidXQgdGhlIE1MIGFnZW50IGNvZGUgaXMgcnVubmluZyBpbg0KPiA+ID4gPiB0aGUgdXNl
ciBzcGFjZS4gVGhlIGFjdHVhbCBNTCBjb21wdXRhdGlvbiBtaWdodCBydW4gR1BVL1RQVXMuIFRo
YXQNCj4gPiA+ID4gZG9lcyBub3Qgc2VlbSB0byBiZSB3aGF0IHlvdSBoYXZlIGluIG1pbmQuDQo+
ID4gPiA+IA0KPiA+ID4gPiAyKSBSdW4gdGhlIE1MIG1vZGVsIGNvbXB1dGF0aW9uIGluIHRoZSBr
ZXJuZWwgc3BhY2UuDQo+ID4gPiA+IENhbiB5b3UgY2xhcmlmeSBpZiB0aGlzIGlzIHdoYXQgeW91
IGhhdmUgaW4gbWluZD8gWW91IG1lbnRpb24ga2VybmVsDQo+ID4gPiA+IEZQVSB1c2FnZSBpbiB0
aGUga2VybmVsIGZvciBNTCBtb2RlbC4gSXQgaXMgb25seSByZWxldmFudCBpZiB5b3UgbmVlZA0K
PiA+ID4gPiB0byBydW4gdGhlIEZQIGluIHRoZSBrZXJuZWwgQ1BVIGluc3RydWN0aW9ucy4gTW9z
dCBNTCBjb21wdXRhdGlvbnMgYXJlDQo+ID4gPiA+IG5vdCBydW4gaW4gQ1BVIGluc3RydWN0aW9u
cy4gVGhleSBydW4gb24gR1BVcy9UUFVzLiBXaHkgbm90IGtlZXAgdGhlDQo+ID4gPiA+IE1MIHBy
b2dyYW0gKFB5VG9yY2gvYWdlbnRzKSBpbiB0aGUgdXNlciBzcGFjZSBhbmQgcGFzcyB0aGUgZGF0
YSB0byB0aGUNCj4gPiA+ID4gR1BVL1RQVSBkcml2ZXIgdG8gcnVuPyBUaGVyZSB3aWxsIGJlIHNv
bWUga2VybmVsIGluc3RydWN0dXJlIGxpa2UNCj4gPiA+ID4gVkZJTy9JT01NVSBpbnZvbHZlZCB3
aXRoIHRoZSBHUFUvVFBVIGRyaXZlci4gRm9yIHRoZSBtb3N0IHBhcnQgdGhlDQo+ID4gPiA+IGtl
cm5lbCBpcyBqdXN0IGZhY2lsaXRhdGluZyB0aGUgZGF0YSBwYXNzaW5nIHRvL2Zyb20gdGhlIEdQ
VS9UUFUNCj4gPiA+ID4gZHJpdmVyIHRoZW4gdG8gdGhlIEdQVS9UUFUgaGFyZHdhcmUuIFRoZSBN
TCBoYXJkd2FyZSBpcyBkb2luZyB0aGUNCj4gPiA+ID4gaGVhdnkgbGlmdGluZy4NCj4gPiA+IA0K
PiA+ID4gVGhlIGlkZWEgaXMgdG8gaGF2ZSBNTCBtb2RlbCBydW5uaW5nIGluIHVzZXItc3BhY2Ug
YW5kIGtlcm5lbCBzdWJzeXN0ZW0gY2FuDQo+ID4gPiBpbnRlcmFjdCB3aXRoIE1MIG1vZGVsIGlu
IHVzZXItc3BhY2UuIEFzIHRoZSBuZXh0IHN0ZXAsIEkgYW0gY29uc2lkZXJpbmcgdHdvDQo+ID4g
PiByZWFsLWxpZmUgdXNlLWNhc2VzOiAoMSkgR0Mgc3Vic3lzdGVtIG9mIExGUyBmaWxlIHN5c3Rl
bSwgKDIpIE1MLWJhc2VkIERBTU9ODQo+ID4gPiBhcHByb2FjaC4gU28sIGZvciBleGFtcGxlLCBH
QyBjYW4gYmUgcmVwcmVzZW50ZWQgYnkgTUwgbW9kZWwgaW4gdXNlci1zcGFjZS4gR0MNCj4gPiA+
IGNhbiByZXF1ZXN0IGRhdGEgKHNlZ21lbnRzIHN0YXRlKSBmcm9tIGtlcm5lbC1zcGFjZSBhbmQg
TUwgbW9kZWwgaW4gdXNlci1zcGFjZQ0KPiA+ID4gY2FuIGRvIHRyYWluaW5nIG9yL2FuZCBpbmZl
cmVuY2UuIEFzIGEgcmVzdWx0LCBNTCBtb2RlbCBpbiB1c2VyLXNwYWNlIGNhbiBzZWxlY3QNCj4g
PiA+IHZpY3RpbSBzZWdtZW50cyBhbmQgaW5zdHJ1Y3Qga2VybmVsLXNwYWNlIGxvZ2ljIG9mIG1v
dmluZyB2YWxpZCBkYXRhIGZyb20gdmljdGltDQo+ID4gPiBzZWdtZW50KHMpIGludG8gY2xlYW4v
Y3VycmVudCBvbmUocykuIA0KPiA+IA0KPiA+IFRvIGJlIGhvbmVzdCBJJ20gc2tlcHRpY2FsIGFi
b3V0IGhvdyBnZW5lcmljIHRoaXMgY2FuIGJlLiBFc3NlbnRpYWxseQ0KPiA+IHlvdSdyZSBkZXNj
cmliaW5nIGEgZ2VuZXJpYyBpbnRlcmZhY2UgdG8gb2ZmbG9hZCBhcmJpdHJhcnkga2VybmVsIGRl
Y2lzaW9uDQo+ID4gdG8gdXNlcnNwYWNlLiBNTCBpcyBhIHVzZXJzcGFjZSBidXNzaW5lc3MgaGVy
ZSBhbmQgbm90IHJlYWxseSByZWxldmFudCBmb3INCj4gPiB0aGUgY29uY2VwdCBBRkFJQ1QuIEFu
ZCB3ZSBhbHJlYWR5IGhhdmUgc2V2ZXJhbCB3YXlzIG9mIGtlcm5lbCBhc2tpbmcNCj4gPiB1c2Vy
c3BhY2UgdG8gZG8gc29tZXRoaW5nIGZvciBpdCBhbmQgdW5sZXNzIGl0IGlzIHZlcnkgcmVzdHJp
Y3RlZCBhbmQgd2VsbA0KPiA+IGRlZmluZWQgaXQgaXMgcmF0aGVyIHBhaW5mdWwsIHByb25lIHRv
IGRlYWRsb2Nrcywgc2VjdXJpdHkgaXNzdWVzIGV0Yy4NCj4gPiANCj4gPiBTbyBieSBhbGwgbWVh
bnMgaWYgeW91IHdhbnQgdG8gZG8gR0MgZGVjaXNpb25zIGZvciB5b3VyIGZpbGVzeXN0ZW0gaW4N
Cj4gPiB1c2Vyc3BhY2UgYnkgTUwsIGJlIG15IGd1ZXN0LCBpdCBkb2VzIG1ha2Ugc29tZSBzZW5z
ZSBhbHRob3VnaCBJJ2QgYmUgd2FyeQ0KPiA+IG9mIGlzc3VlcyB3aGVyZSB3ZSBuZWVkIHRvIHdy
aXRlYmFjayBkaXJ0eSBwYWdlcyB0byBmcmVlIG1lbW9yeSB3aGljaCBtYXkNCj4gPiBub3cgZGVw
ZW5kIG9uIHlvdXIgdXNlcnNwYWNlIGhlbHBlciB0byBtYWtlIGEgZGVjaXNpb24gd2hpY2ggbWF5
IG5lZWQgdGhlDQo+ID4gbWVtb3J5IHRvIGRvIHRoZSBkZWNpc2lvbi4uLiBCdXQgSSBkb24ndCBz
ZWUgd2h5IHlvdSBuZWVkIGFsbCB0aGUgTUwgZmx1ZmYNCj4gPiBhcm91bmQgaXQgd2hlbiBpdCBz
ZWVtcyBsaWtlIGp1c3QgYW5vdGhlciB3YXkgdG8gY2FsbCB1c2Vyc3BhY2UgaGVscGVyIGFuZA0K
PiA+IHdoeSBzb21lIG9mIHRoZSBleGlzdGluZyBtZXRob2RzIHdvdWxkIG5vdCBzdWZmaWNlLg0K
PiANCj4gTG9va2luZyB0aHJvdWdoIHRoZSBkZXNjcmlwdGlvbiAobm90IHRoZSBjb2RlLCBhcG9s
b2dpZXMpLCBpdCByZWFsbHkNCj4gZmVlbHMgbGlrZSB3ZSdyZSByZWludmVudGluZyBCUEYgaGVy
ZToNCj4gDQo+IC0gaW50cm9zcGVjdGlvbiBpbnRvIHdoYXQgdGhlIGtlcm5lbCBpcyBjdXJyZW50
bHkgZG9pbmcNCj4gLSBjb21tdW5pY2F0aW9ucyBjaGFubmVsIHdpdGggYXBwbGljYXRpb25zDQo+
IC0gYSBtZWNoYW5pc20gdG8gb3ZlcnJpZGUgc3BlY2lmaWMga2VybmVsIGZ1bmN0aW9uYWxpdHkN
Cj4gLSBmYW5jeSBhcHBsaWNhdGlvbnMgYXJiaXRyYXRpbmcgZGVjaXNpb25zLg0KPiANCj4gTXkg
ZmVlZGJhY2sgZHVyaW5nIHBsdW1iZXJzIGFuZCBhbHNvIHRvZGF5IGlzIHRoYXQgeW91IGNhbiBn
ZXQgOTklIG9mDQo+IHdoYXQgeW91J3JlIGxvb2tpbmcgZm9yIHdpdGggc29tZSBCUEYgY29kZS4N
Cg0KSSBzZWUgeW91ciBwb2ludC4gQW5kIEkgY2FuIGFncmVlIHdpdGggeW91IHRoYXQgZUJQRiBj
b3VsZCBiZSB1c2VkIGFzIGENCmNvbW11bmljYXRpb24gY2hhbm5lbC4gSSBkb24ndCB0cnkgdG8g
aW52ZW50IGEgbmV3IGNvbW11bmljYXRpb24gY2hhbm5lbC4gTXkNCnBvaW50IGhlcmUgdGhhdCBN
TCBsaWJyYXJ5IHNob3VsZCBiZSB0aGUgdW5pZmllZCBtZWFucyBvZiBleHRlbmRpbmcga2VybmVs
DQpzdWJzeXN0ZW0gYnkgTUwgbW9kZWwocykgaW4gdXNlci1zcGFjZS4gU28sIGVCUEYgY291bGQg
YmUgdGhlIG9uZSBvZiAob3IsIG1heWJlLA0Kb25seSBvbmUpIHBvc3NpYmxlIGNvbW11bmljYXRp
b24gbWVjaGFuaXNtLiBNTCBsaWJyYXJ5IHNob3VsZCBwcm92aWRlIHRoZQ0KdW5pZmllZCBmcmFt
ZXdvcmsgYW5kIHdvcmtmbG93IGZvciBlYXN5IGFkZGluZyBhbmQgdXNpbmcgTUwgbW9kZWwocykg
aW4gdXNlci0NCnNwYWNlIGJ5IGtlcm5lbCBzdWJzeXN0ZW1zLg0KDQo+IA0KPiBJdCBtYXkgb3Ig
bWF5IG5vdCBiZSBwZXJmZWN0IGZvciB5b3VyIG5lZWRzLCBidXQgaXQncyBhIG11Y2ggZmFzdGVy
IHBhdGgNCj4gdG8gZ2VuZXJhdGUgY29tbXVuaXR5IGFuZCBjb2xsYWJvcmF0aW9uIGFyb3VuZCB0
aGUgZ29hbHMuICBBZnRlciB0aGF0LA0KPiBpdCdzIGEgbG90IGVhc2llciB0byBqdXN0aWZ5IGxh
cmdlciBjaGFuZ2VzIGluIHRoZSBrZXJuZWwuDQo+IA0KDQpZZWFoLCBtYWtlcyBzZW5zZS4gTXkg
Y3VycmVudCBwYXRjaHNldCBpcyBleHBsb3JpbmcgdGhlIEFQSSB0aGF0IE1MIGxpYnJhcnkNCnNo
b3VsZCBwcm92aWRlLiBBbmQgZUJQRiBjb3VsZCBiZSBjb21tdW5pY2F0aW9uIGNoYW5uZWwgYmV0
d2VlbiBNTCBtb2RlbCBpbg0KdXNlci1zcGFjZSBhbmQga2VybmVsIHN1YnN5c3RlbS4NCg0KPiBJ
ZiB0aGlzIGJlY29tZXMgYW4gTFNGL01NIHRvcGljLCBteSBiYXIgZm9yIGRpc2N1c3Npb24gd291
bGQgYmU6DQo+IC0gZXh0ZW5zaXZlIGRhdGEgY29sbGVjdGVkIGFib3V0IHNvbWUga2VybmVsIGNv
bXBvbmVudCAoRGFtb24sDQo+IHNjaGVkdWxpbmcgZXRjKQ0KDQpFeGFjdGx5LCBNTC1iYXNlZCBE
QU1PTiBhcHByb2FjaCBieSB1c2luZyBNTCBsaWJyYXJ5IGlzIG15IG5leHQNCmltcGxlbWVudGF0
aW9uL2V4cGxvcmluZyBzdGVwLg0KDQo+IC0gd29ya2luZyBwcm9vZiBvZiBjb25jZXB0IHRoYXQg
aW1wcm92ZWQgb24gZGVjaXNpb25zIG1hZGUgaW4gdGhlIGtlcm5lbA0KDQpBbHNvLCBJIGFtIGNv
bnNpZGVyaW5nIEdDIG9mIExGUyBmaWxlIHN5c3RlbSBsaWtlIGxvdy1oYW5naW5nIGZydWl0IGZv
ciBjaGVja2luZw0KdGhlIE1MIGxpYnJhcnkgYXBwcm9hY2guIEVzcGVjaWFsbHksIGJlY2F1c2Us
IGZvciBleGFtcGxlLCBOSUxGUzIgaGFzIEdDIGFzDQp1c2VyLXNwYWNlIHByb2Nlc3MgYW5kIGl0
IHJlcXVpcmVzIGVsYWJvcmF0aW9uIG9mIGVmZmljaWVudCBHQyBwb2xpY3kuIFNvLCBpdA0KY291
bGQgYmUgcG90ZW50aWFsIHByb29mIG9mIGNvbmNlcHQgZm9yIHRoZSB3aG9sZSBpZGVhLiBJZGVh
bGx5LCBzZXZlcmFsIHVzZS0NCmNhc2VzIHNob3VsZCBiZW5lZml0IGZyb20gdGhlIGlkZWEuDQoN
Cj4gLSBkaXNjdXNzaW9uIG9mIGNoYW5nZXMgbmVlZGVkIHRvIGltcHJvdmUgb3IgZW5hYmxlIHRo
ZSBwcm9vZiBvZiBjb25jZXB0DQoNCk1ha2VzIHNlbnNlLiBUaGlzIGlzIHdoeSBJJ3ZlIHNoYXJl
ZCB0aGUgcGF0Y2hzZXQgd2l0aCBpbml0aWFsIHZpc2lvbiBvZiBNTA0KbGlicmFyeSBBUEkuIFRo
ZSBnb2FsIGlzIHRvIGhlYXIgYWxsIHBvc3NpYmxlIGNyaXRpY3MgYW5kIHRvIGNoZWNrIHRoZQ0K
Y2FwYWJpbGl0eSBvZiBpZGVhIChhbmQgbWUpIHRvIHN1cnZpdmUuIDopICANCg0KPiANCj4gSW4g
b3RoZXIgd29yZHMsIEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCBhIGxpc3Qgb2Ygd2F5cyBNTCBtaWdo
dCBiZSB1c2VkLg0KPiBJIHRoaW5rIHdlIG5lZWQgc3BlY2lmaWMgZXhhbXBsZXMgb2YgYSB3YXkg
dGhhdCBNTCB3YXMgdXNlZCBhbmQgd2h5IGl0J3MNCj4gYmV0dGVyIHRoYW4gd2hhdCB0aGUga2Vy
bmVsIGlzIGFscmVhZHkgZG9pbmcuDQo+IA0KDQpZZXMsIGFzIHRoZSBuZXh0IHN0ZXAsIEkgYW0g
Z29pbmcgdG8gZXhwbG9yZTogKDEpIEdDIG9mIExGUyBmaWxlIHN5c3RlbSB1c2UtDQpjYXNlLCAo
MikgTUwtYmFzZWQgREFNT04gYXBwcm9hY2guIEkgaG9wZSB0byBoYXZlIGVub3VnaCB0aW1lIGVu
b3VnaCB0aW1lIHRvDQppbXBsZW1lbnQgaXQgYmVmb3JlIE1heSBhbmQgdG8gc2hhcmUgc29tZSBu
dW1iZXJzL3Jlc3VsdHMuDQoNClRoYW5rcywNClNsYXZhLg0K

