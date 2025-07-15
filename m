Return-Path: <linux-fsdevel+bounces-55021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E25B0665D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D121AA1C62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 18:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534EA2BEFE0;
	Tue, 15 Jul 2025 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B75VlFPc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3A82BE7B5
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605823; cv=fail; b=eO9GCcnknQ+7G+iOtZkt6wsBzQjheRqJhs92I0Fn463E2osyoAP0jBaR9LB6GTF0Mb4gEBo1/V+0d5sp4CZghYhb8MCKlo6MR0HFGcmaeAqCaPKHuNyfrZ/E5+FzajZBYG0BJXvO5lzllKvg3kLNZIscq6cY4MSSmlnFgAJDs50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605823; c=relaxed/simple;
	bh=UvR7kvi9anwDsmDPVJw034D32SspRWgVlecrR4/+cOU=;
	h=From:To:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Qhs40xRA0gKk7HaxmKsdpqrgHa5bsmJrZOEYkPTXiUuqHK2sYr57iNfEHFyHbN0wQ7ErUt6CTRiTDGM8h+EYBFbx84yxtsXlAbCKbxApMtCS61x6diM2iaT9N1O8I+T3MZud+Qep3gGJR7CV8oEsz+yKsNTghSnvA7NIleFZZbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B75VlFPc; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FFAwS9027616;
	Tue, 15 Jul 2025 18:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=UvR7kvi9anwDsmDPVJw034D32SspRWgVlecrR4/+cOU=; b=B75VlFPc
	0SHUk72LMaL0ac6Ix/mqQBLzDyqoKwys6coqujVViyggY02L5NEBbJ59w2D6jQmR
	kAis/wKn7HU8SGZUXGKCtwC029EgE2iL8ntO39f+yVQcUhUnAD07U1F9hSuJ3H/z
	BGPkHGNfxjKpUbAYlGxTSPvOK9U/n1FpMMINMwkWpuZ7d+zZEc8mjmMrYai1BLIN
	hm379g8hZYTz2tGxCOEk7L5lW8ffxG9MqRZKQO7TrVXiWZiW11Tnzc6ikRglph6p
	jFrof9+kEi4qwPZ+U1jmHLTZhfT4RjjNDbmUFMmRKZgVCQWnMFKu2KLbm7Ka8XL8
	xUZTWmmTcnpP1A==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vdfmm0a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 18:56:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuZ9cm+EGn8/QgS3i+oHsTPT0uaUvLsG838duM3ZM27B2yypVZ52HfUl/OQoLKbQ4XtX0FQC9GxD+oR/Tu1cA4OrSbdVk5C6I+D5LiFd0ursQQTb51WqxD1JE39Gqabhv0t3tRb4NILgjArHooxpEpW6V0HdDIgK760hU8ezelSqYvKUTvsbocyEnYvS20K7KEJ0EKoiPukr/QjXVReLZr0XI4z4Mh+wWkRITPQUVSkmSwUtAOW+lnyGz5DBCWnitngSO7yKYQ9HlsDC2YLChSPyaT+NFP7NG9Js7ukJBxIMTPFG5c67lvCtu7nbKVERGL0Xqclye/aid9r2ZXpDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvR7kvi9anwDsmDPVJw034D32SspRWgVlecrR4/+cOU=;
 b=VOEqLJIgRjiyRSCjL5euPmYRKkn/2JA+CbZMgLvCXP0dt5v96zahDRjRMZqz9qm8mBHNeirb8OOmP5Y1FtqAnXDgtfKVSoSGib9BjCRDu7w6w8SRtxBoltAjfN7FeJE64jlARo/1ulLDMrt3FQfYmKd/6TmeIAVu5lbdT5LmKZ5eks5xIPw6jfmIRg/MAUXGQqZ3yLCDWM44vv+vQtOWOMoTIu2fQbt6huWgWV1C11It3Amw6NPmbo6ejxY2ZxRM/fDzZXTe11CFZgujQduhvltdL42/L4ntPyjQVAzYyJ/ovsessYhw16Ww6N1snxFpbsUhOlaco4vc15ZkbdRb4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA0PPF81A6374A2.namprd15.prod.outlook.com (2603:10b6:20f:fc04::b2f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 18:56:54 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Tue, 15 Jul 2025
 18:56:54 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfs: add logic of correcting a next
 unused CNID
Thread-Index: AQHb5m3j4i7L1Q6SX0COo3N/Ll0IuLQcH6sAgBbUjICAALNigA==
Date: Tue, 15 Jul 2025 18:56:54 +0000
Message-ID: <a63b4f98e31d2116917661d9fabd1e482199158c.camel@ibm.com>
References: <20250610231609.551930-1-slava@dubeyko.com>
	 <6c3edb07-7e3d-4113-8e57-395cfb0c0798@vivo.com>
	 <3025bb40a113737b71d43d2da028fdc47e4ca940.camel@ibm.com>
	 <ae8ea217-92c6-4294-a8ad-3414893d927d@vivo.com>
In-Reply-To: <ae8ea217-92c6-4294-a8ad-3414893d927d@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA0PPF81A6374A2:EE_
x-ms-office365-filtering-correlation-id: 71f2ff9a-96fd-4859-407c-08ddc3d15dd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RURMK3Z1by9sK05rZTRTeVFLdXgxWHRYaUkrUGs0SXJWenM2MWZoQXBnclYr?=
 =?utf-8?B?aXdndTE2NEllb0JhUHo4VlpCOFgzYlM3Wnc4ajU1ejFzdklhRkxDeU81ZFkv?=
 =?utf-8?B?OFNNY2FseVFFTVpDUEVuU0REN21XYnNiOHFOeEx6OXdyR2hrbXc1aUxsV3pT?=
 =?utf-8?B?bDVDZi9yTHJmbWoxWVU2K3gxSVFVVjRqN1BRbDZ0Um5QTWtGRGRiZ0tQRFhH?=
 =?utf-8?B?aU9hRXAyY3FmOXdxTXlMdFIzbkRvSVE1QVlQenRMREhhd1pNcWoxWFlpN1l3?=
 =?utf-8?B?RnBOeituSHNaM3E0LzdBbUs2dWVKL0JVZ1UxV2NYaHd5aWlON2l0TjdYdlZ4?=
 =?utf-8?B?cXNRSTVscFJoYnFNOFNwUUVQMEk1cDFPWktXdUFKZ1BvQ0RnbkR0SUxleDlD?=
 =?utf-8?B?QkU5dnVZRy8ySnRIbkNZTVA5OTlyNkgxbVhSUCticWJnRTkyNldXMVZ6cVpm?=
 =?utf-8?B?K25neXRSQUtOWFpNVmJuZnB6dVNPZkdqZEFEdVhBRm5DVTg5MmRkVVphTFBO?=
 =?utf-8?B?eVUvUC8rbFM4MVM2T0JmWDJyeDBzaEd5bkdLZWF4RkVQWi9tNTdvYjY3MjNE?=
 =?utf-8?B?aE15SWtkYTJuVVBUcndhLy9XdW5rSW9ERzYzVXJMQ2pwckFWcHd3QkpKWkVp?=
 =?utf-8?B?WDJLV0VTK284R3ZUNE8vVS9uMHBtUzZXdVlTOFN3eUZQd0xFRlpOU1VjaVM1?=
 =?utf-8?B?WUZjMGJrWjcxeUlkMFJSMlhpanNqN00zejNUc1FHTEFZQ0s4NXpXaUJNcDlI?=
 =?utf-8?B?bmZFVjcyWTZudFlBZk1sbkJvM0YvUDBRSlZIREUwbVJWM1dkUzNlMkRnWGEy?=
 =?utf-8?B?RmkwTzVmamNCb1FHTjFteFV5bjNYcWUxeEdvMGdlVU1ZK1RIQkFiUlhuakpn?=
 =?utf-8?B?cklZV3RZcDBTamNTenROTkc0aDVTYzNxR1U5NmlqU0lYMWxXTEViTVFsL0Zj?=
 =?utf-8?B?eHdjdUN4b2VIVVZrR3pwamNQNEJpSnZUZC9CTUd2amw0ZW94c2srVHhUd1hV?=
 =?utf-8?B?N0xQSnljT3dhWXVGc1NMdkFLa1Vmelc4LzRDWjRNNFhOVE9WZ0ZObit1K2tL?=
 =?utf-8?B?bC93azdpSTEvRDhXVmpTM09MUExyNVNjSjAyWXMzeTVLNE40RFNwOXR4K0FO?=
 =?utf-8?B?R3dEQ1BTSVU1eTQvbERIVGxFbWFqa3hDNFpUU25ZdE8rZmNORHhtUE9hWU9w?=
 =?utf-8?B?aGo4QnZ0ZmZmSWEwNUdDb21SaWlCZjkyaEVoU1Z6Qk9BSVMwbXRmUXJ3RzBB?=
 =?utf-8?B?d3pma2MzS0pmcnhVT1JvMUh3WUpSWGVHQlZxUHh5OWNadmFITkd0aDFma1po?=
 =?utf-8?B?SG9NeUdZTWk4YW5KTGx6OGVWbHVtSm0vM3RiekZyMno4dE9BTmFlRUh5MnFR?=
 =?utf-8?B?OWQvam0rc1NYbms5d2JjWW9BeUtoek5ZTFg1RmtmQnF2Rmo2eW0wWTBpVVFy?=
 =?utf-8?B?dVByVGVYVVM0QnJuc2RwN2FDZmQzd1NkV2pLekJ5ejdHUWxUZlJ6QzBjTEhH?=
 =?utf-8?B?Q3FnNEgzeFFHRFN5cnptTGdZNXVXVWVrTXZzaWF0QXlHcm1qeTZIVFk0a3lX?=
 =?utf-8?B?SzBJSzNrYnFyMU54ZXRid21RUTg1OWJrRmNFbjdUT2xvYitXS0QwUnB2NDBY?=
 =?utf-8?B?RzdyMzNKb0lzWWx5VkJBd2tsVEJHbUt3Q1JKclpqYzc0WGd0aUw1Vk1zbERh?=
 =?utf-8?B?YzBCdjFkOUFMazdWeXJyZWJrODdkTkFFVVBzSXRVby9tSWhkM2hyZFcvZUVG?=
 =?utf-8?B?YjJFV3FwVUpkaWJKVXRGTnRJeUx2Vytqajhnb1FtSUZjRi9IcjdSeHVjdS9V?=
 =?utf-8?B?TGlKOFZyL2VMM3h2V21nVm05eVhINy9JVVlNQy9WSG1vbGJoR0ROSUxwcVpr?=
 =?utf-8?B?blN1L0d5emlNQVJYOGhYWlBCdDc3UGJNdFRndXNmd1hhVERMNmNueEJRKzI2?=
 =?utf-8?B?U2Z5eWFFUXdTTWY5U2lqTU02RStEYmVHSTJnUXBwNXZXNVNrSWU5cFlQL3No?=
 =?utf-8?B?Y3FpRXgvNkJnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aTZ3bG91VkZNRktKZ2Jxa1A4ZUcrMDBaUnRodk15NEhJcHQ3K29qVDZzUGlP?=
 =?utf-8?B?WmNKUFNqU0hJUEdPemhONmNOZG5xT3R2OHAwVm8yZnZHUUFUYWVtY2pFUjZT?=
 =?utf-8?B?bnJrMUt4N2FDajdJV2NyOGtlL0FRUGpiYWo3cEhLTnJEbFprZlpqdkF3NkQ3?=
 =?utf-8?B?RDkrMmpNbFRTSDBpWmpsOCs4ZVo2RDBRVkozV3VnUGd3ZVpzV0xKWTk0cWl3?=
 =?utf-8?B?RDRqRnlvMDlwVWhBNFVDOGV3MWFVelRNck5sMkFtZDF5YnNrUzFoS1pWbTJ2?=
 =?utf-8?B?REdON1EzRUVpRFVVeDZXeG1pRFVkRWVsRy80eHB4bTIvbjR6eUVvUHRUWG9J?=
 =?utf-8?B?c1dtUjU5aVVJU0pNbmwwem9ZZDVEaWJWbExlU05KVkcxRU9rNmRRR0xvTXo4?=
 =?utf-8?B?cU81YS9IaTB3cjg3ZjJ4OE4wK0JWVVd0cjNvQWNWd0luMkNoRm50MmVnQTl3?=
 =?utf-8?B?Y29DYVJsY2VVNUZ2SGVEdFlqYTdmM1Flc0JHMkVHNG1WWmpnOVFaeHdsQXZu?=
 =?utf-8?B?ZHJoZ25YSUhsTS9saTBWUE1QOHpzVUF4ZnhxWFQzQmJ1cUNtODBSYUpjTjgv?=
 =?utf-8?B?cGYwclhBWkN3RnMwdko2QmRVZ0dBcHFheTcrY05YRDNNOFFXVnFMSjB2UFpq?=
 =?utf-8?B?NkpMOEZ0aWhmS0hkWUdkWVhzaEZNUkRUeHlIYlg3bWMrZWVRUHg1djRheVhZ?=
 =?utf-8?B?ZU9PWkZlQ25UWkYzUkZFUEdDY3BFem1UQ1FQUlAvYzM5QlZhZEhzVGhjZzZt?=
 =?utf-8?B?UDJQM1Nka09FUHlnSlJqeHlCQXJYYjlhMXE5YlMydGlmbm0vbHhlSnBjTGgr?=
 =?utf-8?B?UXJPcVZITmc0SHk4aHEzL2pscTJmdklYUWlVcVlmUmVuTVUyakhxNkhIZTA2?=
 =?utf-8?B?TDcvVUtxUFgwL2M1ZWJwKzhXaTkwY05DQUo3TGhiT3kvREZWRUFQTW1tRStF?=
 =?utf-8?B?a1AwRURSbjBzS2tkc3pSMEhEeGlSbnhMeWxJWDNYMW5oYVBMc1lkSEIvMzZS?=
 =?utf-8?B?QWRncXNYaW5OcjlZR3BLZjVodXp2R3ljUXBOUk1lUEdMN2ZweHFOUkhIQ1Fn?=
 =?utf-8?B?emwwV3Y4WkdOcEZhTG1xWTFWdE43N1hlcTllOEgvSWE2K3o1T0dnZGxUM243?=
 =?utf-8?B?ditOeGFDQVcvVWloNXUxVzM1RjM2MG4xSFduRkdNdk42d2xPaVdUYzhJVTNs?=
 =?utf-8?B?eGhlU2FBeFlwUTRvbkNDUllLeElFWFkvdjlhRDdkQ1QvWGRUWDVCcjJwLzU4?=
 =?utf-8?B?YjZGaGdtdTAvMWRreTdqOEFkVmZZbFVPVXozTnhLT2lwempBVXNnUTFwQ01C?=
 =?utf-8?B?Z2o5dEM3UzVHaUo0cW5kOXVSdWJyTWtSZjhCTHd4Q3lMUk8xWVBrbFhwZUNJ?=
 =?utf-8?B?akZDRGJFbmJmdnA2U1l6N1Nib0hnUCtHMTA1Z1U2aFNNemFTRnVBTVBpaXpr?=
 =?utf-8?B?QWRrM0tiYVkrTUVOWjdaYWtWelZBR0V0MUJVNmhkYkZzeEhQa254a3c0RUgy?=
 =?utf-8?B?cjhCTEVSZFRMQXllTFJ3WkJZTGprM1dRcTZKZG1RWEJTNmlxK0ppOEoxM2hH?=
 =?utf-8?B?bkFHbkd4T3BFNDgxcjFtbHZ3cjRyaU9LMXFPa1dwRHl4RlVSVXNOcEVRYzQ2?=
 =?utf-8?B?OVpzMGRLS0wvZjV0VDIwcnhUUkxPaDYraEdhSmpCNFE2OXdDcUFxMEdPUUla?=
 =?utf-8?B?d1lnOFFib0crWmdJcStCYmlob3B6bmdxN1VVMWJZaG9ISWRXVHFTcHhDQXBG?=
 =?utf-8?B?dWxOYXBqQ1dVQ1pnWUl3UEdhbTdMbDVRdkF4RmdlK3RNdWREcjVLd21WcWIx?=
 =?utf-8?B?NTlvMU5hajRyV3ZEVlY0aHdDREc2UTFmN0tUNGs2c2RsRFIyQ2tXNVRVNmY3?=
 =?utf-8?B?M1NJdVd0V2Y5aTU4bkNFeitWaCt5QlQrbnhxYmNkNUxtSm1tdjJ6YjFBTEt4?=
 =?utf-8?B?OURNZDZHSm96N0IzRmg4VHJ5emlQcndNa2I1V1FPZittOXhtM3RKYUJiTGFH?=
 =?utf-8?B?SmNHRENrV2Rub2QxdXdLZjEva0VTTHZoOURTM3htRFUvaENnOFFwUnYxNk8r?=
 =?utf-8?B?bWU0UTgxZlJxbW1OQ2QzREJqVlRkOGIycW16TXJFOEJ1VUoxMXZaRTVIRXBr?=
 =?utf-8?B?TVJ1bkpIQkhoK2VULzhVUzV0T01RQzU3Y1Q4TUZOZUNiSkRabmVIS3E2Rm1J?=
 =?utf-8?Q?Nsfbi7Hm+zh7Cs+ggnTdgmg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E43A19EFB4C9B4DBB247DE7AF5A455F@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f2ff9a-96fd-4859-407c-08ddc3d15dd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 18:56:54.5789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzjI+SEYOaB2fMegHHECsqzQ4ERBKcUHmpG6QAnjziMVqJOtzfj6Yc619g7IJ9aYrWegramhI4mti3gn1ceC/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF81A6374A2
X-Proofpoint-GUID: 6WJZ-eVaLL8RcWFTjOT8oWs6DtGMmJOM
X-Authority-Analysis: v=2.4 cv=JOI7s9Kb c=1 sm=1 tr=0 ts=6876a478 cx=c_pps a=VbRhRuKwnmm7QzOe8LwpbQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=8GujtMTPTqKWCJwAwOoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6WJZ-eVaLL8RcWFTjOT8oWs6DtGMmJOM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE3MyBTYWx0ZWRfX0axOHJXUALuu Aj0UygMWmBR96aDIZIthxa0wnF8ynH5I02PVboXlBgn7endXYmR2sZ/CIAIx1KKHm3zbWZuH3JG ZBxNeyZ2JLEQ+WoHE0WBF5CDPRorzy3w++p2Idj02qX2lwup7RKQ+KPpWO8mJNDcvOfasZm+R6E
 MkAILzCeCNH1rvMj+XKddQrxoi8qh6KzvqYfDfBVKLFHHjvv3midRSnta2yOQuCz4DbeU0pe2yC +e4lnw1wMFL0CstRbF6ZIf0P0duNAC/W5OUoPLCNNutzYqkY/fISSxNkkTJl4Jj6IyHt4QZZbLv 90TDJY0MwfLT4LwBour+U4Ah0+vpXNpuwjizX+2nu8RQnNDDv4algeQXpzYW69nN3GrhGIUonHO
 K88Mdfvoa8gjwyg2+zvRUWA9t4eJHhACfgm1iIt519cN/qEAaBLwkWL+kRwhK4CncEJyJXg1
Subject: RE: [PATCH] hfs: add logic of correcting a next unused CNID
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150173

T24gVHVlLCAyMDI1LTA3LTE1IGF0IDE2OjE0ICswODAwLCBZYW5ndGFvIExpIHdyb3RlOg0KPiBI
aSBTbGF2YSwNCj4gDQo+IOWcqCAyMDI1LzcvMSAwMzozNiwgVmlhY2hlc2xhdiBEdWJleWtvIOWG
memBkzoNCj4gPiBIaSBZYW5ndGFvLA0KPiA+IA0KPiA+IE9uIFRodSwgMjAyNS0wNi0yNiBhdCAx
NTo0MiArMDgwMCwgWWFuZ3RhbyBMaSB3cm90ZToNCj4gPiA+IEhpIFNsYXZhLA0KPiA+ID4gDQo+
ID4gPiDlnKggMjAyNS82LzExIDA3OjE2LCBWaWFjaGVzbGF2IER1YmV5a28g5YaZ6YGTOg0KPiA+
ID4gPiBUaGUgZ2VuZXJpYy83MzYgeGZzdGVzdCBmYWlscyBmb3IgSEZTIGNhc2U6DQo+ID4gPiA+
IA0KPiA+ID4gPiBCRUdJTiBURVNUIGRlZmF1bHQgKDEgdGVzdCk6IGhmcyBNb24gTWF5IDUgMDM6
MTg6MzIgVVRDIDIwMjUNCj4gPiA+ID4gREVWSUNFOiAvZGV2L3ZkYg0KPiA+ID4gPiBIRlNfTUtG
U19PUFRJT05TOg0KPiA+ID4gPiBNT1VOVF9PUFRJT05TOiBNT1VOVF9PUFRJT05TDQo+ID4gPiA+
IEZTVFlQIC0tIGhmcw0KPiA+ID4gPiBQTEFURk9STSAtLSBMaW51eC94ODZfNjQga3ZtLXhmc3Rl
c3RzIDYuMTUuMC1yYzQteGZzdGVzdHMtZzAwYjgyN2YwY2ZmYSAjMSBTTVAgUFJFRU1QVF9EWU5B
TUlDIEZyaSBNYXkgMjUNCj4gPiA+ID4gTUtGU19PUFRJT05TIC0tIC9kZXYvdmRjDQo+ID4gPiA+
IE1PVU5UX09QVElPTlMgLS0gL2Rldi92ZGMgL3ZkYw0KPiA+ID4gPiANCj4gPiA+ID4gZ2VuZXJp
Yy83MzYgWzAzOjE4OjMzXVsgMy41MTAyNTVdIHJ1biBmc3Rlc3RzIGdlbmVyaWMvNzM2IGF0IDIw
MjUtMDUtMDUgMDM6MTg6MzMNCj4gPiA+ID4gX2NoZWNrX2dlbmVyaWNfZmlsZXN5c3RlbTogZmls
ZXN5c3RlbSBvbiAvZGV2L3ZkYiBpcyBpbmNvbnNpc3RlbnQNCj4gPiA+ID4gKHNlZSAvcmVzdWx0
cy9oZnMvcmVzdWx0cy1kZWZhdWx0L2dlbmVyaWMvNzM2LmZ1bGwgZm9yIGRldGFpbHMpDQo+ID4g
PiA+IFJhbjogZ2VuZXJpYy83MzYNCj4gPiA+ID4gRmFpbHVyZXM6IGdlbmVyaWMvNzM2DQo+ID4g
PiA+IEZhaWxlZCAxIG9mIDEgdGVzdHMNCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBIRlMgdm9sdW1l
IGJlY29tZXMgY29ycnVwdGVkIGFmdGVyIHRoZSB0ZXN0IHJ1bjoNCj4gPiA+ID4gDQo+ID4gPiA+
IHN1ZG8gZnNjay5oZnMgLWQgL2Rldi9sb29wNTANCj4gPiA+ID4gKiogL2Rldi9sb29wNTANCj4g
PiA+ID4gVXNpbmcgY2FjaGVCbG9ja1NpemU9MzJLIGNhY2hlVG90YWxCbG9jaz0xMDI0IGNhY2hl
U2l6ZT0zMjc2OEsuDQo+ID4gPiA+IEV4ZWN1dGluZyBmc2NrX2hmcyAodmVyc2lvbiA1NDAuMS1M
aW51eCkuDQo+ID4gPiA+ICoqIENoZWNraW5nIEhGUyB2b2x1bWUuDQo+ID4gPiA+IFRoZSB2b2x1
bWUgbmFtZSBpcyB1bnRpdGxlZA0KPiA+ID4gPiAqKiBDaGVja2luZyBleHRlbnRzIG92ZXJmbG93
IGZpbGUuDQo+ID4gPiA+ICoqIENoZWNraW5nIGNhdGFsb2cgZmlsZS4NCj4gPiA+ID4gKiogQ2hl
Y2tpbmcgY2F0YWxvZyBoaWVyYXJjaHkuDQo+ID4gPiA+ICoqIENoZWNraW5nIHZvbHVtZSBiaXRt
YXAuDQo+ID4gPiA+ICoqIENoZWNraW5nIHZvbHVtZSBpbmZvcm1hdGlvbi4NCj4gPiA+ID4gaW52
YWxpZCBNREIgZHJOeHRDTklEDQo+ID4gPiA+IE1hc3RlciBEaXJlY3RvcnkgQmxvY2sgbmVlZHMg
bWlub3IgcmVwYWlyDQo+ID4gPiA+ICgxLCAwKQ0KPiA+ID4gPiBWZXJpZnkgU3RhdHVzOiBWSVN0
YXQgPSAweDgwMDAsIEFCVFN0YXQgPSAweDAwMDAgRUJUU3RhdCA9IDB4MDAwMA0KPiA+ID4gPiBD
QlRTdGF0ID0gMHgwMDAwIENhdFN0YXQgPSAweDAwMDAwMDAwDQo+ID4gPiA+ICoqIFJlcGFpcmlu
ZyB2b2x1bWUuDQo+ID4gPiA+ICoqIFJlY2hlY2tpbmcgdm9sdW1lLg0KPiA+ID4gPiAqKiBDaGVj
a2luZyBIRlMgdm9sdW1lLg0KPiA+ID4gPiBUaGUgdm9sdW1lIG5hbWUgaXMgdW50aXRsZWQNCj4g
PiA+ID4gKiogQ2hlY2tpbmcgZXh0ZW50cyBvdmVyZmxvdyBmaWxlLg0KPiA+ID4gPiAqKiBDaGVj
a2luZyBjYXRhbG9nIGZpbGUuDQo+ID4gPiA+ICoqIENoZWNraW5nIGNhdGFsb2cgaGllcmFyY2h5
Lg0KPiA+ID4gPiAqKiBDaGVja2luZyB2b2x1bWUgYml0bWFwLg0KPiA+ID4gPiAqKiBDaGVja2lu
ZyB2b2x1bWUgaW5mb3JtYXRpb24uDQo+ID4gPiA+ICoqIFRoZSB2b2x1bWUgdW50aXRsZWQgd2Fz
IHJlcGFpcmVkIHN1Y2Nlc3NmdWxseS4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBtYWluIHJlYXNv
biBvZiB0aGUgaXNzdWUgaXMgdGhlIGFic2VuY2Ugb2YgbG9naWMgdGhhdA0KPiA+ID4gPiBjb3Jy
ZWN0cyBtZGItPmRyTnh0Q05JRC9IRlNfU0Ioc2IpLT5uZXh0X2lkIChuZXh0IHVudXNlZA0KPiA+
ID4gPiBDTklEKSBhZnRlciBkZWxldGluZyBhIHJlY29yZCBpbiBDYXRhbG9nIEZpbGUuIFRoaXMg
cGF0Y2gNCj4gPiA+ID4gaW50cm9kdWNlcyBhIGhmc19jb3JyZWN0X25leHRfdW51c2VkX0NOSUQo
KSBtZXRob2QgdGhhdA0KPiA+ID4gPiBpbXBsZW1lbnRzIHRoZSBuZWNlc3NhcnkgbG9naWMuIElu
IHRoZSBjYXNlIG9mIENhdGFsb2cgRmlsZSdzDQo+ID4gPiA+IHJlY29yZCBkZWxldGUgb3BlcmF0
aW9uLCB0aGUgZnVuY3Rpb24gbG9naWMgY2hlY2tzIHRoYXQNCj4gPiA+ID4gKGRlbGV0ZWRfQ05J
RCArIDEpID09IG5leHRfdW51c2VkX0NOSUQgYW5kIGl0IGZpbmRzL3NldHMgdGhlIG5ldw0KPiA+
ID4gPiB2YWx1ZSBvZiBuZXh0X3VudXNlZF9DTklELg0KPiA+ID4gDQo+ID4gPiBTb3JyeSBmb3Ig
dGhlIGxhdGUgcmVwbHkuDQo+ID4gPiANCj4gPiA+IEkgZ290IHlvdSBub3csIGFuZCBJIGRpZCBz
b21lIHJlc2VhcmNoLiBBbmQgSXQncyBhIHByb2JsZW0gb2YgQ05JRA0KPiA+ID4gdXNhZ2UuIENh
dGFsb2cgdHJlZSBpZGVudGlmaWNhdGlvbiBudW1iZXIgaXMgYSB0eXBlIG9mIHUzMi4NCj4gPiA+
IA0KPiA+ID4gQW5kIHRoZXJlJ3JlIHNvbWUgd2F5cyB0byByZXVzZSBjbmlkLg0KPiA+ID4gSWYg
Y25pZCByZWFjaHMgVTMyX01BWCwga0hGU0NhdGFsb2dOb2RlSURzUmV1c2VkTWFzayhhcHBsZSBv
cGVuIHNvdXJjZQ0KPiA+ID4gY29kZSkgaXMgbWFya2VkIHRvIHJldXNlIHVudXNlZCBjbmlkLg0K
PiA+ID4gQW5kIHdlIGNhbiB1c2UgSEZTSU9DX0NIQU5HRV9ORVhUQ05JRCBpb2N0bCB0byBtYWtl
IHVzZSBvZiB1bnVzZWQgY25pZC4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBXaGF0IGNvbmZ1c2Vk
IG1lIGlzIHRoYXQgZnNjayBmb3IgaGZzcGx1cyBpZ25vcmUgdGhvc2UgdW51c2VkIGNuaWRbMV0s
DQo+ID4gPiBidXQgZnNjayBmb3IgaGZzIG9ubHkgaWdub3JlIHRob3NlIHVudXNlZCBjbmlkIGlm
IG1kYlAtPmRyTnh0Q05JRCA8PQ0KPiA+ID4gKHZjYi0+dmNiTmV4dENhdGFsb2dJRCArIDQwOTYo
d2hpY2ggbWVhbnMgb3ZlciA0MDk2IHVudXNlZCBjbmlkKVsyXT8NCj4gPiA+IA0KPiA+ID4gQW5k
IEkgZGlkbid0IGZpbmQgY29kZSBsb2dpYyBvZiBjaGFuZ2luZCBjbmlkIGluIGFwcGxlIHNvdXJj
ZSBjb2RlIHdoZW4NCj4gPiA+IHJvbW92ZSBmaWxlLg0KPiA+ID4gDQo+ID4gPiBTbyBJIHRoaW5r
IHlvdXIgaWRlYSBpcyBnb29kLCBidXQgaXQgbG9va3MgbGlrZSB0aGF0J3Mgbm90IHdoYXQgdGhl
DQo+ID4gPiBvcmlnaW5hbCBjb2RlIGRpZD8gSWYgSSdtIHdyb25nLCBwbGVhc2UgY29ycmVjdCBt
ZS4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gDQo+ID4gSSB0aGluayB5b3UgbWlzc2VkIHdoYXQgaXMg
dGhlIHByb2JsZW0gaGVyZS4gSXQncyBub3QgYWJvdXQgcmVhY2hpbmcgVTMyX01BWA0KPiA+IHRo
cmVzaG9sZC4gVGhlIGdlbmVyaWMvNzM2IHRlc3Qgc2ltcGx5IGNyZWF0ZXMgc29tZSBudW1iZXIg
b2YgZmlsZXMgYW5kLCB0aGVuLA0KPiA+IGRlbGV0ZXMgaXQuIFdlIGluY3JlbWVudCBtZGItPmRy
Tnh0Q05JRC9IRlNfU0Ioc2IpLT5uZXh0X2lkIG9uIGV2ZXJ5IGNyZWF0aW9uIG9mDQo+ID4gZmls
ZSBvciBmb2xkZXIgYmVjYXVzZSB3ZSBhc3NpZ24gdGhlIG5leHQgdW51c2VkIENOSUQgdG8gdGhl
IGNyZWF0ZWQgZmlsZSBvcg0KPiA+IGZvbGRlci4gQnV0IHdoZW4gd2UgZGVsZXRlIHRoZSBmaWxl
IG9yIGZvbGRlciwgdGhlbiB3ZSBuZXZlciBjb3JyZWN0IHRoZSBtZGItDQo+ID4gPiBkck54dENO
SUQvSEZTX1NCKHNiKS0+bmV4dF9pZC4gQW5kIGZzY2sgdG9vbCBleHBlY3RzIHRoYXQgbmV4dCB1
bnVzZWQgQ05JRA0KPiA+IHNob3VsZCBiZSBlcXVhbCB0byB0aGUgbGFzdCBhbGxvY2F0ZWQvdXNl
ZCBDTklEICsgMS4gTGV0J3MgaW1hZ2luZSB0aGF0IHdlDQo+ID4gY3JlYXRlIGZvdXIgZmlsZXMs
IHRoZW4gZmlsZTEgaGFzIENOSUQgMTYsIGZpbGUyIGhhcyBDTklEIDE3LCBmaWxlMyBoYXMgQ05J
RCAxOCwNCj4gPiBmaWxlNCBoYXMgQ05JRCAxOSwgYW5kIG5leHQgdW51c2VkIENOSUQgc2hvdWxk
IGJlIDIwLiBJZiB3ZSBkZWxldGUgZmlsZTEsIHRoZW4NCj4gPiBuZXh0IHVudXNlZCBDTklEIHNo
b3VsZCBiZSAyMCBiZWNhdXNlIGZpbGU0IHN0aWxsIGV4aXN0cy4gQW5kIGlmIHdlIGRlbGV0ZWQg
YWxsDQo+ID4gZmlsZXMsIHRoZW4gbmV4dCB1bnVzZWQgQ05JRCBzaG91bGQgYmUgMTYgYWdhaW4u
IFRoaXMgaXMgd2hhdCBmc2NrIHRvb2wgZXhwZWN0cw0KPiA+IHRvIHNlZS4NCj4gDQo+IEkgZ290
IGl0LiBJZiB3ZSBkZWxldGVkIGFsbCBmaWxlcywgdGhlbiBuZXh0IHVudXNlZCBDTklEIHNob3Vs
ZCBiZSAxNiwgDQo+IHdoaWNoIHNvdW5kcyByZWFzb25hYmxlLiBJbiBmYWN0LCB0aGVuIG5leHQg
dW51c2VkIENOSUQgd2lsbCBrZWVwIGJlIDIwIA0KPiBmb3IgYm90aCBoZnMgYW5kIGhmc3BsdXMu
DQo+IA0KPiBJdCBjb25mdXNlZCBtZSB3aHRoZXIgY2hhbmdpbmcgQ05JRCBhZnRlciByZW1vdmUg
b3BlcmF0aW9uIGlzIHRoZSBiZXN0IA0KPiB3YXkgZm9yIGhmcy4gQmVjYXVzZSBJIGRpZG4ndCBm
aW5kIHN1Y2ggbG9naWMgZnJvbSBhcHBsZSdzIGhmcyBjb2RlLg0KPiANCg0KSSBkb24ndCBxdWl0
ZSBmb2xsb3cgd2hhdCBkbyB5b3UgbWVhbiBoZXJlLiBXaGF0IGRvIHlvdSBtZWFuIGJ5IGNoYW5n
aW5nIENOSUQNCmFmdGVyIHJlbW92ZSBvcGVyYXRpb24/IE5vIHN1Y2ggbG9naWMgaW4gdGhlIHN1
Z2dlc3RlZCBwYXRjaC4NCg0KPiBBbmQgb25seSBoZnMgZmFpbGVkIGdlbmVyaWMvNzM2LCB3aGlj
aCByZWxhdGVkIHRvIGZzY2sgZm9yIGhmc3BsdXMgDQo+IGlnbm9yZSB1bnVzZWQgQ05JRC4gQ291
bGQgd2UgaWdub3JlIHVudXNlZCBDTklEIGZvciBoZnMgdG9vPw0KPiBUaG9zZSB1bnVzZWQgQ05J
RCBtaWdodCBiZSByZXVzZWQgYWZ0ZXIgc2V0dGluZyANCj4ga0hGU0NhdGFsb2dOb2RlSURzUmV1
c2VkTWFzayBmbGFnLg0KPiANCj4gDQoNClRoaXMgcGF0Y2ggaXMgbm90IGFib3V0IGlnbm9yaW5n
IG9yIG5vdCBpZ25vcmluZyB0aGUgdW51c2VkIENOSURzLiBUaGlzIHBhdGNoIGlzDQphYm91dCBr
ZWVwaW5nIG1kYi0+ZHJOeHRDTklEL0hGU19TQihzYiktPm5leHRfaWQgaW4gYWN0dWFsIHN0YXRl
LiBUaGUgYWN0dWFsDQpzdGF0ZSBtZWFucyB0aGF0IHRoaXMgdmFsdWUgc2hvdWxkIGJlIGFsd2F5
cyBsYXN0X3VzZWRfQ05JRCArIDEsIG90aGVyd2lzZSwgZnNjaw0KdG9vbCB3aWxsIHRyZWF0IHRo
ZSB2b2x1bWUgYXMgY29ycnVwdGVkLg0KDQpUaGFua3MsDQpTbGF2YS4NCg==

