Return-Path: <linux-fsdevel+bounces-6385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C414D817602
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 16:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F111F24892
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 15:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89A17207C;
	Mon, 18 Dec 2023 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GGC85dmZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TeZNmZWA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E217642379;
	Mon, 18 Dec 2023 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702914053; x=1734450053;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PzAqN7m+rzrPpxK8aWINAjzWjTvMuPhXKalKKlHMzTs=;
  b=GGC85dmZEPtNDnnNb9y0MbiGjsh2jap1w/mwamQDcKIIk7ZctSJwukoD
   tXuepuyKgfERebCnX0agEDRqtb/bMrRaoLdyvaDFzxd81O59L6i2uNuzn
   fsLw7l/GCmmNbuePsSkL63s80Ei5LTdAEziqzCm3khAXsvmvGpcSNZHiy
   0pjjkWCVQBwVIvwhKQc1Inru4K8eCOgR08nUlTdqRyb5DoT1itXl088Ju
   fGnjXwcir6YwtKBuvGptX18E6m4wI034L/JADr08Qcc7exmGqZ4QQLXIe
   si77X+KDPIlrBQBgDxaIcZNpETYibjsLVYBHUIdtOwQGfkAJXDcfw8Ir5
   g==;
X-CSE-ConnectionGUID: pvzzJ9LHTtaS95T6DCxiZg==
X-CSE-MsgGUID: ZjukNLDMQNSKSurtGuK+kA==
X-IronPort-AV: E=Sophos;i="6.04,286,1695657600"; 
   d="scan'208";a="5124976"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2023 23:40:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQSirs3YSjw4/CYoydxuMVbiEzNZKX0VqZNuC4eHMFBKpNuP1uhHkpFvHmUE1jR2Jof0aXSnjPJRyyw2mFHAjE33kj+yWCIPoZlI6Jx6DhvH8IEAfdbs+5rtAVQt2sQyCu7wQYnbn+PR0MhBjQp2Tea44tYEcAJ68ZV1k6G8MqtsE3jEmZ/+pL5bBwwjdc3OjRkl5YSqcQJ8Xor9XvvwsSem3kO+rH1Ytblbl58KUSDesnTiZX3NRbBoMvDO1Tkj4VJV36vbAZLArgIekA2HIx7yeiVbl1VrDI0bYF89A/D5my0aLDoKSuYN7P/xBYmo22s/f8V/l/QSc5icjfpXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzAqN7m+rzrPpxK8aWINAjzWjTvMuPhXKalKKlHMzTs=;
 b=PZZoJ7ram1xnJ+4f020sT4dH9z9ltiUn1Jr4sdcGNPaH67dUq8zfyD8bGBPfEf9hQ07OqMU3kd0t0SUUh9FXVYu83vvD2EKc6j029MOLkCTfADNy4xye8jGWJo8Wwuhk3koD+aDihg9PndswKxsTh3daY6lDuvR5GZfKahykhw5NH/6N6G7kFGBUgb6Lg34VGtU7yg25g11AJa9EGVdxxUQqZW4ChOT3TsCYZ3LgOWqiy8i1yJqqdK1Re3FREwCx7qX1r2GURX7qOPZYTod2xcMxsxB4EqP7KaZzypzZZF3IHfPS7m4CvJPCA59RdHvBSZA40ONAVA5/hPQcjRvFWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzAqN7m+rzrPpxK8aWINAjzWjTvMuPhXKalKKlHMzTs=;
 b=TeZNmZWAUYgBqJ+1EZRkFsfwoqp9rZF2damwFhz/V11oYqHt0FYNlJZ4Km1FpSLpMODBTBiIQYZAD284Jv6X9wOWmTjsnfE2L/Her3sEPsTkSyR64sAvKwzUtimC7yKO9XFw9ZPxZ76rLIpDCKXHpwt9xK6OguKsxwbpt/KB0m4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7548.namprd04.prod.outlook.com (2603:10b6:806:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 15:40:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 15:40:42 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH 08/14] hfsplus: Really remove hfsplus_writepage
Thread-Topic: [PATCH 08/14] hfsplus: Really remove hfsplus_writepage
Thread-Index: AQHaL5Hpr4Da0he2ZEWmJqZkmdfVTrCrUuMAgAOLeQCAAElegIAACj8A
Date: Mon, 18 Dec 2023 15:40:42 +0000
Message-ID: <cdf6a3d8-4f5c-4fce-a93e-9b0304effcb9@wdc.com>
References: <20231215200245.748418-1-willy@infradead.org>
 <20231215200245.748418-9-willy@infradead.org> <20231216043328.GF9284@lst.de>
 <50696fa1-a7b9-4f5f-b4ef-73ca99a69cd2@wdc.com>
 <20231218150401.GA19279@lst.de>
In-Reply-To: <20231218150401.GA19279@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7548:EE_
x-ms-office365-filtering-correlation-id: 4c2ca3ef-67c9-4438-f910-08dbffdfb1b5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 S8q0GlENa63HA874iyd7n4kFnniWmrcDJzP3twE2ld+qZlvNbLEn1eL8iKE9SSkrqi7oPXO6VTr8FcQe61G1o2doKtSg1J1GEqLib4PuuNf2w3VuUu6b3fxwLP7AxjMoO0pxR2kfMm2ZMdEntQHdpu+s63IOH4NU1cVAHOrtLV5jLtxZAs/VKDi2bARCrLHCy1Myb/3Q194l6eeLel+JuNFr03GDQxGpMA79h9KcZLkibkvMWCwz9YwZ0tX97H9pOLP4FnIsNetZZ8VKsSXcxBgd0DM9KKYsyiJU4Vs1Y+wweBQhIBQ6xC+PgLudRaEFF+nPL07ROyfZzmnQDiljoyGBGgKlKy/C7RaFi6A8ILQp+anW91XYApgTGShTGrEEf38SxeqJUYRxR1L3H8gsbTfflpug9vbC8JTHQccCtI94OUT0T2jxR7mcZuvbgqsZjGDJhP7tvQQgH22bixWN9lbWHvXtfsc5Gh5LtJ4lATmjq9H85HOLN3nCnsi7NPWcNWbYxNQ84QYeqvPa7OR7xyNlLZharIOC3IO7XHw0Lmti/UzMkad6//D2Ji7d60VzqbAsE18KzodjsZkezqDrKuTlURW7MDnWehhANP+TLp3vWFz4Wr1GeZO1RELVXk17Q8CfgWI7/KdrQnFWDD/zwvuBvZ9aGPYRrHVcDTPGavr0Gk5IL2Ge08un113gNjH5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6512007)(478600001)(6486002)(2616005)(83380400001)(6916009)(316002)(66946007)(76116006)(66556008)(66476007)(66446008)(64756008)(54906003)(91956017)(53546011)(5660300002)(8936002)(8676002)(4326008)(71200400001)(31686004)(6506007)(82960400001)(38100700002)(122000001)(4744005)(2906002)(86362001)(31696002)(41300700001)(38070700009)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z21lZDJYUFg0MjhXVldJSkZoeWh1Q2xmaGYvbG16RWJpeVkwMVBvZkpVdkpJ?=
 =?utf-8?B?MzRSWVM0cUpxb0hkNmd5YzJVaHNDbEE0VDZlUmF5aDdlVG5XZ3llTVVkWnN2?=
 =?utf-8?B?OUh3RnlpMVBRNEUrbFZFK1V4TnduUHhaQnFwbjZKdzhnMFZZZGNORERCV1F5?=
 =?utf-8?B?VGFPeGFHMjByT3pyODVLQ09tNlJOZlc2QUtEOFNsYXlzVHE3bDd3eXpvd3RE?=
 =?utf-8?B?SEdweVFJRWNvanQvRkZ4azg0TS9EZmJlV0NGWVkwSHVicWNpSGNFZ1hOV1M3?=
 =?utf-8?B?RTloTDh0R1J0TVJEMzRSbHJieGJyblJkeGRCNk1VSXFiSDhhNzNORVBxbUQx?=
 =?utf-8?B?dGYxYW5WQ0FTUi93ZXJNdjkrQzRVd2Z2ZXZuZEZuTno0V2FobU5TcTlqWkdF?=
 =?utf-8?B?R052dnJEcEUrbkt3R2pycThzL1orM2o1djlJSVp3Tnl0Y1RaTDVYNis1cS9H?=
 =?utf-8?B?U2JCZ0tMVkpYT0cwY3gzQ0NPY2pMWk5pbjVlS2VEenNQTW8wSzl2UVFFQ290?=
 =?utf-8?B?MmdqNG1PdkhWbWhjcGNlaVhxeHdYNjB1LzFUbTQvVmN2d01oSGttSisyM25D?=
 =?utf-8?B?SkJXM2EyNVJWK2RhZlVrellyeEx5REp5MlZkM21EOGNMaGdpaG83UzkrVGVy?=
 =?utf-8?B?d216dlpRZitKeFQ5WXFFTmNnU24zc3dZaTB2V0dHK0kyWk42S1FxTXZUd0NG?=
 =?utf-8?B?cGwwNndDaUtqR0dScm4xZXFITEZQWTJtQXVKcTNXTDFGeDMvZXhKK0cralFq?=
 =?utf-8?B?Q2o3OERPU2VrK241YzRPbEdwSWxndjhvMGt6SWU2NTNIaUlUZnBlV1N2UmNi?=
 =?utf-8?B?VjQzaUo4K09BRkgyTHNwZ1AxLzY0SWg1WmxkQzFtbXRWcElQM1BvNy9wSkEr?=
 =?utf-8?B?ZmhlUkFhZUJiSE9vR2J3ZCt3eW03QUtrRU5QUGYyYXpaVVpOQllYejM1U3Fk?=
 =?utf-8?B?SWIvVmU1Rzd4RG9tUFh5YVVTRUZJNW1mVkN6d0FnUjh1Ky93aWFBSjI4NGtm?=
 =?utf-8?B?a3BkVTZnaERTVzI3MHM1SmtqV2Y3V0ZpRjAzSjZoRGJJNVZNUyt4TW84Q3Rr?=
 =?utf-8?B?T2FJQmJabVRoSGhpZjV6M2FJenVTTkJuN3o3ZEFoTkdLelUxQnlremNRS3lU?=
 =?utf-8?B?Z0xYQjVqYldhOEtnbDhFV1diamRLUWdJVG8rVW8rckJ6WnZIQnNDbFVwM3pn?=
 =?utf-8?B?eklic0M0SlZUVW5YcnF0WjdlT253ZlhQVkY4MGdrTXRvQW1RQzUyT2dCdllr?=
 =?utf-8?B?LzJ1K0g5eWkzRUZ4ZGRuektDUnNxbTh2MEhlalUvSWZWUGFLMmtxZEJDZGp0?=
 =?utf-8?B?b3hZUHB2S1RHRG1NN0lqaWdVYTcySUJrbGVuTElRODE0YnFYWW5lc2gyWXdL?=
 =?utf-8?B?K1lmWXJKUFFLQUtsZnJlazgvanM1bHFzMWl2SHAybC9RbzE3bmhodDZSOWwr?=
 =?utf-8?B?V0ZwdEJ2SnhobElvcnVRc2owenQ0YkhqdmJEOTlYZmRXYkx2M2xXa3VhbEZU?=
 =?utf-8?B?OVFnM0xFMHNtUE5LRktpMEtuWjZIR2ZCdGN3S2kyLzlqMEVZUDNqd3JQSSsw?=
 =?utf-8?B?UGtUZGliZTJxMUt6eU9zTjQ5S1pDK2lqZ09aREtPMVpVNy9BMXlZOUVqcnUw?=
 =?utf-8?B?amZucU9Obmw4V0kzQlZNcHlHUVNXQzU0alRld2xMRnc4OEU2R1BrU0lqdG03?=
 =?utf-8?B?bzFXblE2RkhZTmV3RmRaRUpsKyt4UTcxUXphdE9QNDlvTkVMZ2VsYU1PMndB?=
 =?utf-8?B?cTdVQmk1clRDL2pBK2EybG4xSXlqd20wZi9lNVhJU2FFWS8yQ0VIR3l1WXNq?=
 =?utf-8?B?VklPeEJXWXhtUy96SGZ2VWJ5S0lSWHUyWHppdkh3NHFJdUZhUHkrcElscmpO?=
 =?utf-8?B?UEFLUnhma0J2N29KWVFhUlFkQ1poQzBZczg0UXJIV0hBSWFvYTRTbVhxbTRT?=
 =?utf-8?B?bytVVnkyeGkvNzIyS0pWS29xMUV5RGZQOFZ2MnpNM3dIUFNXdFlRVzd4L2Rm?=
 =?utf-8?B?SFpnYnk4Q1M3Ukp0STI2TTNjbksyRHlwNVlVc3BlTVpJVUl5a1RFZFNON2ZN?=
 =?utf-8?B?ZFo2L3pLVVBoeERLMUZEajZmRDlybmZITUZKUTU0Nks4M3N4RWFqaWhDTFRy?=
 =?utf-8?B?MHdscG0rTSs1djlTU2p3SHpGWCtWcW8wbDMycmMxdjE0bmJ3bkRZQldNZGFh?=
 =?utf-8?B?U3pDclNRcEJsWGp1cEcxNFF1L0FLMHR1djdnTjBHMjZzdkZqS3JidTlZSjcz?=
 =?utf-8?B?M1VQdUppQjU2TG5LVU9BTTBnQXlRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE76016B93D0F14EB3ADCB7B4E5889CC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b/o7Ak8zTVr+HlCOPA3fUWeAerBKsFSU1Qf7iuEEuWN8Xy+FVlMneja7hMAHAOGi3AL22BbPkUUTfwVwNzZS1RxfZc+t9MMpPIu12bH2KY//GszZsDw6BQTe1vaUvYVAWWZ3YCe0BTMmbOCnXLvuIuaO59QkAyCSodSmYCYbJQ72aU7BibUV7g26J3p4OJP9RJYOySiDTKqBrywuD0eHmnxIq+A+o6wVr5PA3BjObyZoyFHGeZrMUckKevAnIRrpFQ3D1lCyY1AZG+nzt1iSaYQo9/87JslFpt93yL3hg7AVn5voawLc5/64F6ePs+I/A8WPYGZ1FFSc9yHj9DrwTxRYPGEpOqUFGhGn2EwyS4RUCfyvMYpl1ajfJ4yigZlrKEVI7oOebLfqrLgDm9Q76KE8IFs8U4UwhCtqimVaOUKyYY6Y0QDSCloH7sWc1CqBEXmHtMuRD9zl0OfWaHN5rmeTIYh0w09aQ6vq+EC3upLvijCs2GY7U6b3gbzn/JnxH5ya1roSSoXnLd6lSYWCr5gNdVPYXZlkaC1ckW/Rvf6ARnpARHdSqyZkcKj52fQmosphQAVvFM1lwpfe/Bab5LndoMxu3JupNGW58U6nEfC5WBlvLLjGwqO2oBmsN7Ja
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2ca3ef-67c9-4438-f910-08dbffdfb1b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 15:40:42.7138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4AtKu5x8DWJMAyDkrDoJziTzFtIzJP97OKNrKQgO7aCY3q7Sl6mUdNF9faZzj0hUTbleUtKjkkpIWFCHOxMGy6SgL4xbVkHkD/rxGQfiERg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7548

T24gMTguMTIuMjMgMTY6MDQsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBNb24sIERl
YyAxOCwgMjAyMyBhdCAxMDo0MToyN0FNICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6
DQo+Pj4gYWx0aG91Z2ggSSBoYWQgc29tZSByZWFzb24gdG8gYmUgY2FyZWZ1bCBiYWNrIHRoZW4u
ICBoZnNwbHVzIHNob3VsZA0KPj4+IGJlIHRlc3RhYmxlIGFnYWluIHRoYXQgdGhlIGhmc3BsdXMg
TGludXggcG9ydCBpcyBiYWNrIGFsaXZlLiAgSXMgdGhlcmUNCj4+PiBhbnkgdm9sdW50ZWVyIHRv
IHRlc3QgaGZzcGx1cyBvbiB0aGUgZnNkZXZlbCBsaXN0Pw0KPj4NCj4+IFdoYXQgZG8geW91IGhh
dmUgaW4gbWluZCBvbiB0aGF0IHNpZGU/ICJKdXN0IiBydW5uaW5nIGl0IHRocm91Z2ggZnN0ZXN0
cw0KPj4gYW5kIHNlZSB0aGF0IHdlIGRvbid0IHJlZ3Jlc3MgaGVyZSBvciBtb3JlIHRoYW4gdGhh
dD8NCj4gDQo+IFllYWguICBCYWNrIGluIHRoZSBkYXkgSSByYW4gaGZzcGx1cyB0aHJvdWdoIHhm
c3Rlc3RzLCBJSVJDIHRoYXQgbWlnaHQNCj4gZXZlbiBoYXZlIGJlZW4gdGhlIGluaXRpYWwgbW90
aXZhdGlvbiBmb3Igc3VwcG9ydGluZyBmaWxlIHN5c3RlbXMNCj4gdGhhdCBkb24ndCBzdXBwb3J0
IHNwYXJzZSBmaWxlcy4gIEkgYmV0IGEgbG90IGhhcyByZWdyZXNzZWQgb3IgaXNuJ3QNCj4gc3Vw
cG9ydCBzaW5jZSwgdGhvdWdoLg0KPiANCg0KTGV0IG1lIHNlZSB3aGF0IEkgY2FuIGRvIG9uIHRo
YXQgZnJvbnQgb3ZlciBteSB3aW50ZXIgdmFjYXRpb24uIEFzIGxvbmcgDQphcyB0aGVyZSdzIG5v
IEFQRlMgc3VwcG9ydCBpbiBMaW51eCBpdHMgdGhlIG9ubHkgd2F5IHRvIGV4Y2hhbmdlIGRhdGEg
DQpiZXR3ZWVuIG1hY09TIGFuZCBMaW51eCBhbnl3YXlzLCBzbyB3ZSBzaG91bGRuJ3QgYnJlYWsg
aXQuDQo=

