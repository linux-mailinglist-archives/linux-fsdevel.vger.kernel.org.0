Return-Path: <linux-fsdevel+bounces-4315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D57A7FE84E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 05:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C240B20CAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 04:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D73717EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 04:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="oZn7acu3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6508FD71
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 18:46:31 -0800 (PST)
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATNS2iL006869;
	Thu, 30 Nov 2023 02:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=GwQi6RxI/rIAqU5w4I15+wvR502Ry/kaQ7KCn1F18Rw=;
 b=oZn7acu3wJ6MwBsqkz4Yy+hVgBc3z/3heVOJpjqpNoR0Um09MTA9cu/nsfo03QldR5H+
 i/YAsqYzqvro4fW2dwzjwHYlNXE8ugwbsPacIySU0nI/2b/07c1IarB3goq2/4B+ng4Q
 NK76G6uZOC+TiXjXc9dzKfWKcOqtsSiZRuQTiseIZYxFDNxn56PoHhFyfbGZ5cZdTRPX
 0KUN8mUFatyqAf3fhT2siRBugp7hM9uO+QBWXxaf/+UiEPK9x7AaaaokMpFFCE23J/ko
 DZWmoE6RiEMmIPoauAYp1znVjqCI5gfL9860XjRlzqLoFdRgF8G4cmmgAIKCaAZxbyNb 6g== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2040.outbound.protection.outlook.com [104.47.110.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3uk7t1511c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 02:46:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcNoPYNOGK5ArvCyjz6ZSW9iHd/DfqhbS0+ONM3+xwd2Q4AhrmfmVlSBxPVSUi1F3EWNqrvOj4kxyu+MfIdTmtOmx0zN1i2qJY6jJcrLKyDqCQd8J/2A2ZCC+Tkze/ifgz/F+BaYtng1a5PHQFgih3rakKCCh7iyhRBJd5UYjQ0PvwOSdD+79SUp9bPfGIk0omDwIrT0LPzSFxuolk5u1gPUQlvqdW4TZp5CEtIqArIG7X+zXN03rCK0vHWPBTk0yjuD28NMBca5/wuVEfcbEgnKssmQ7amv0bCa2MI5N+Ck0dVp6707jrSDfZIQU/jhHZGaUIfBYtzbFBw8Yu+9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwQi6RxI/rIAqU5w4I15+wvR502Ry/kaQ7KCn1F18Rw=;
 b=HgFBkrIxEBRQTy26htPEOZQ/nV5auAd+pgLlFk4mp2s9P7yLK9aBK9thD/N65+nOa2G1TGuuobyNXd+SV9Y7aUucaatFXzRzsBxhok69wTojKQYRgaaM7n0l76FtIyu7ih+fPOUrpfi7qaH52Q8c9KRoT9csJWmeH/7X8ghy6XajCdMi7EYuGf+wxPry+hi/UtvNNOrPrsRpRZqOXvpQXE0z2a3cwMg69W3wE8Y3O2UGBClF0IlIxZyuht795pP30GWbHYNgTltkDqVs3xeNTHT4oYEExtw4IruzpKUgzbPa6fNKPFZzmeaJOSA+gJDaKS4lEepVMorKH7S8TvH/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PSBPR04MB3957.apcprd04.prod.outlook.com (2603:1096:301:f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 02:46:00 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a%4]) with mapi id 15.20.7025.022; Thu, 30 Nov 2023
 02:46:00 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Sungjong Seo <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>,
        "cpgs@samsung.com" <cpgs@samsung.com>
Subject: RE: [PATCH v4 1/2] exfat: change to get file size from DataLength
Thread-Topic: [PATCH v4 1/2] exfat: change to get file size from DataLength
Thread-Index: AdoNcqiciL5m7DeAQVy9qFZcQUwgXwUaYyaAACw8KJAAAGr18AAEkSgAACVbv3A=
Date: Thu, 30 Nov 2023 02:45:59 +0000
Message-ID: 
 <PUZPR04MB631652916C704AAB235AB1578182A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: 
 <CGME20231102095908epcas1p12f13d65d91f093b3541c7c568a7a256b@epcas1p1.samsung.com>
	<PUZPR04MB631680D4803CEE2B1A7F42F381A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
	<1296674576.21701163681829.JavaMail.epsvc@epcpadp4>
	<PUZPR04MB6316FB0EDA2C6B92617CD4538183A@PUZPR04MB6316.apcprd04.prod.outlook.com>
	<PUZPR04MB6316FDA1CB1C7862C179F2CF8183A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <664457955.21701248102069.JavaMail.epsvc@epcpadp3>
In-Reply-To: <664457955.21701248102069.JavaMail.epsvc@epcpadp3>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PSBPR04MB3957:EE_
x-ms-office365-filtering-correlation-id: e4ce9212-d326-4493-760f-08dbf14e7bf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 yc/+rqmufgk61gfqZnQX4EaO+lNff8gzf510NM/CYfdtuVKJ4Vp1FxZeAzO/t/m1RjD7ZDzuIo9ftidLcGWTP88snWRAclQlmEC8j8hQrrxnFFX0W8Y5ySQGyk6g4X38c8GdQWGhSJr/gkm6ubO0LegNz0OessHmAX+GxMVjYl+vlpUve7XGn1ZDqTqzbAzE/9Pf6nT7qPSQoEVeUedRzlSldUDbijLYmjoxx8wWUbpVu0ygK8rSDCJAiOrI1cZ4ntRJqKZrHmrfgN2bXamdNxQsYg6gHMGmOhazl7nDH0HtSWs56pmycVPA2WstNI8caLQwJ8ClnZ5/bZQpmCsGb/zsqUWi7GxLBoNoW43CbkEGYqgvacmBMYw+FlhsWndqB6DrhfMRAUuOf0+5l+EMbBKazRjU9OftoKCwdM9Mq4Zo1EQhyak1dolWdTSTVkyiLqEVtfUrw9u+GdAKFxBslin+a0nVhqP/YY+ImQthqyvaTeuKFe5UuauGyiJeZ9uaIiKo4EDw6RiroiCexYogi9/zD3eAm9ZX7LbVZXCftXlln2HQgQ+Kk+5tTy3DP39WdHDIsmgYiOjNKS2/Iw5qCqAH+t55QdiIiD4V0nPN6mSYy2n8+qA0eMvOp6AStbWcoVQsGHHu6ShYZAeZsmyYotyldcuSEQHL/jMpAX7I8xw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(202311291699003)(26005)(6506007)(7696005)(9686003)(83380400001)(8676002)(55016003)(8936002)(4326008)(316002)(52536014)(86362001)(71200400001)(478600001)(54906003)(66556008)(66476007)(66446008)(64756008)(110136005)(76116006)(66946007)(122000001)(38100700002)(82960400001)(41300700001)(38070700009)(33656002)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SmJZZzk5dHM0eVdrdGlhdE9neWdwdGZRSi81SW42bXFMbll6VWNMMWRRbG9Q?=
 =?utf-8?B?WktxTVRBaS8zZDRlN1ZmdG5saE9lcnBWSmVIejl3c3o2dlg1Y1dpdWFFcXF5?=
 =?utf-8?B?cmJHMG5seDlNM25IY21rc213cjVzN0crRmFIaFB2Yk52cDM2U0M3VXB0SjIz?=
 =?utf-8?B?cmkyV01OOGtuNzIzK21XRTRLU0J4ZmRCWGVXUmdoNHJPSnhJUUE1YkQyRms4?=
 =?utf-8?B?ZkRPVEprUlUzSk5wZ01lVkhYbHVva0MvTkUyODd1SVVaV2ZRa1lkUDJ4ZC9J?=
 =?utf-8?B?d2RBQzlpTEI3Qng1QlhiRFI2Vnk4MStSb1lkdWttZWlRdm9ITDJtdGtZSE0v?=
 =?utf-8?B?VUV5WjJIOTc1VDlSbDhsbTVuOURibWpZSERwTnIvc2lJREhEcWNRUy9haFAy?=
 =?utf-8?B?TFNZeWxJYk9vODFNMWFxMXg3aHZuQnUzdFk3TFNDMzBGbVpJTmR4VVU0SjM2?=
 =?utf-8?B?Q3NIek5yS1dIYWg5bXBDaDlZMXI5QW0vTDFYdGl0TzEwM2pyMkQ3OStLc0JN?=
 =?utf-8?B?NjQ4VnR1bGZGWU5pUTF3SXlBSjNPT0d5MlJEdS9BcU5kMnVlVkx1YTd3amZJ?=
 =?utf-8?B?WkFGNlpKQno5M3duR2VLZDR4R3hyYmVqd1kzVVZuVytKa0lTai9mMkUvTnZR?=
 =?utf-8?B?NWVUQkt5QVJVZnJIUnZwSThMOGxscEZhckNTalVPZWdES1RNMHhEV2QzSzIv?=
 =?utf-8?B?cHYxcHV2NnJ6ZHJIa24rVFhjcmF6VUdPejMvNmhZVG9TdVkwZXFHV1NHRXJs?=
 =?utf-8?B?QVQvTWtvVmlWV3k3ODg5MXhPT3FTemprN3hRV2tJcU83UXI5ZlpBQk1rZWky?=
 =?utf-8?B?Y2VjbG9aWDRmenAxNzJ5bVZ5MGhoTzRUZW01eVU2anZQU3RPR1dVRGJkZjN5?=
 =?utf-8?B?czhaMHRPSEVDQ2MxcjlPc2F1Q2FTQ2wwdVJsT0JvaTV1OGF3SlN4Tk14YmVT?=
 =?utf-8?B?ME1HZ25uSFU4MllFVmtiMmo2QzY1Y1pKaDdMNElBRTlkbEswbkpOZzl5alRU?=
 =?utf-8?B?ako4UTNuYnpWVU1ORXdiQ2d4c1lmVnNTdmRCY08yUmZwQXNlOUJvcWRGWVlj?=
 =?utf-8?B?VHlyQ1hONUcxYWRESXJTN0tNaVpUaStNRWU0bHl4UnhBYmcyYTBOVGk1U2lz?=
 =?utf-8?B?NmVDVVhMcENhcEpnWWpJekgrU3M4UDErZDJtTjdoUHI5YnQ3T2cvaUlhQjNN?=
 =?utf-8?B?MzBQS0hsZ2Z0VE5VU2U1b1o1WmVTSGErdGlCR2RVVkE1Rjdldk9paVhUNzV1?=
 =?utf-8?B?T0Y2YTI4YnNPS3FDRW9EYVAvQzZTcTlMSFdadDJaaWErUjVsaVBlVHE1eWJZ?=
 =?utf-8?B?YXhYa0pVaUd2SERjNGluci9lNHVON1R0b0NHbVYvODV2MkhRQkFFcWNzUHBM?=
 =?utf-8?B?T2VQdEN5Nld5OXU5ZkxWWGYwaE9yNTdTcTdxVmF0ZDhDQmtGZGtsaDNtcGtl?=
 =?utf-8?B?TnRCYWRBY0pIRmVjODVZMGRWcHk4cDN4MTgzcWljcWs4ZGhnN0oyc3MvckVY?=
 =?utf-8?B?a2tFRWw2bVBRU2x5MEM5MGlQS1JYc2I2SnpwSis0dGl2ZkJLdjNLVW10c3Nv?=
 =?utf-8?B?RWFpekNzTW10L3k0RU9XYkptb29pWjlHWEJoalg3eEIwaE1hRjlVUVd5Q1hp?=
 =?utf-8?B?dUFMUHNaTUZpbnZXOTd4akZYaEtxTGZnYUdmZ3NCU21FSStrWVJ5WTBJRUYw?=
 =?utf-8?B?dkVjdkZSN2hRSnB6eWEvc0UrMyt4bUdrRFBuZmZUTERBZEQ5RnJSN2U2RnZn?=
 =?utf-8?B?VVNhSVJpWUh3K3hMQzJFOUlFNWFPUDgzS2VBMHgwZnJ2VGxzT0hTNkhXK3d1?=
 =?utf-8?B?S2Zvd0ExYm9BSGY3WTVHM1IxOXF2WnRHQkYwS09kdDhNOU5uZXhSOWQwTzc1?=
 =?utf-8?B?OVVGc3QrbmcvNFJvOWUrdWkvZVpqWUJXSEd1Z1FlQ2Mrc0pLRTRML1UycFZ2?=
 =?utf-8?B?dXVxdlF1TW9FRkxKemRZejZ1eW9lMCtxMDhaY28rUFRzaW5RRXpkSlFvMUZN?=
 =?utf-8?B?dzVSMHc0L2Zub250Kyt1dEpxV3lKY1I5TlBwaVRoSUo1V3BwNVVlM0JwZGEr?=
 =?utf-8?B?Mk5DOXFRclZDRGhFcWVpSjhPZmVSR3RsMVh1MlFCU05Ga2t2R05DNWdGUzRp?=
 =?utf-8?Q?TJhdfgDgZOi+j2Qlyh3v+J7UG?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sQD0r3AaNSc0l88oXZKypMF27GEBwXXVTh+l7NIN8aZ9UWmvN3HsbePeYpYPR+QX1AGfpmt2g6iZ7LduiYOb8g6FX9ndLhNxxkWs5daPLxMNR7abeAXn+MEC4qypgRYSAM0zN15lva0OVH/REbSgbC9t70WrRrJ31s3aZ0l4xwkAt+yBKQWS/itx0E85txTPCFrDiHSiW/FaughN92tPskPZUv82sT1akMOebj2rfIZQ9RG5ZRd1XaIS5YSgrhobEpxyT4EoFPxiR1OpvEaFkVuzRBb54HcBkwytahvlnoeyFSCi46lmG5JRUJ2SQE5/12I3PfGqP5XP8TtrzN+jQUQmoYHneU8/tMmcl009xK0mptFHBDdWOR4DE559N6xqfN3Ru5WjkSoPCbFbsnh74b1iS4JYFkSVQl+FSh5djT7KrqMNfJ0P2N3UPJzF+634B3FSmhO3vawniudTrrxC1B0larWUD5bTb9MPE76gJwsRGp59+R0BVfXAKfbykSxzb3rdZq1IZqEl6tfM1VZGb3oMMDdGDgX1ybjk6VhIRlB2xfC758pr1YAMATzd+U5oy4BnPq0iz7CjwD4JL58TBFchJsVqdGoR2Jnmr0TDvPITNe3YNmbVrUbqom7vSsRD3BfP/nocdqAoc4CN4jVQyLbnp6cJ7cijJcX+sHaEtvlERGt2MaJUDJnX6s676v/V8BAjmol9CqNP92cQJUs2Pq7HZCTtEziHi+LSw2wiWbQ3ANk/D7SEqT2WaBhhSLRf6OL4r6E5kxnFO3Z8jLi5Wti9rfFK88oijMKWBiCnHJprESa7Cz8oD9tgLLFcKt2A2i4RGoInT1dIa5j7fLqD1w==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ce9212-d326-4493-760f-08dbf14e7bf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 02:45:59.2061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKXxDIaVgFI4egRPDGfKcXtDFSE92HfBVJKcyt+77er/SMlC6v97EG8oDVw9isliQP0ep8CuznsEI5oRFbDbJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSBPR04MB3957
X-Proofpoint-ORIG-GUID: lmWHOiIc5j_zJm7xTmuy4xm_NsUq-OOp
X-Proofpoint-GUID: lmWHOiIc5j_zJm7xTmuy4xm_NsUq-OOp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: lmWHOiIc5j_zJm7xTmuy4xm_NsUq-OOp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_21,2023-11-29_01,2023-05-22_02

PiA+ID4gW3NuaXBdDQo+ID4gPiA+IEBAIC00MzYsOCArNDg1LDIwIEBAIHN0YXRpYyBzc2l6ZV90
IGV4ZmF0X2RpcmVjdF9JTyhzdHJ1Y3Qga2lvY2INCj4gPiA+ID4gKmlvY2IsIHN0cnVjdCBpb3Zf
aXRlciAqaXRlcikNCj4gPiA+ID4gIAkgKiBjb25kaXRpb24gb2YgZXhmYXRfZ2V0X2Jsb2NrKCkg
YW5kIC0+dHJ1bmNhdGUoKS4NCj4gPiA+ID4gIAkgKi8NCj4gPiA+ID4gIAlyZXQgPSBibG9ja2Rl
dl9kaXJlY3RfSU8oaW9jYiwgaW5vZGUsIGl0ZXIsIGV4ZmF0X2dldF9ibG9jayk7DQo+ID4gPiA+
IC0JaWYgKHJldCA8IDAgJiYgKHJ3ICYgV1JJVEUpKQ0KPiA+ID4gPiAtCQlleGZhdF93cml0ZV9m
YWlsZWQobWFwcGluZywgc2l6ZSk7DQo+ID4gPiA+ICsJaWYgKHJldCA8IDApIHsNCj4gPiA+ID4g
KwkJaWYgKHJ3ICYgV1JJVEUpDQo+ID4gPiA+ICsJCQlleGZhdF93cml0ZV9mYWlsZWQobWFwcGlu
Zywgc2l6ZSk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkJaWYgKHJldCAhPSAtRUlPQ0JRVUVVRUQp
DQo+ID4gPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ID4gPiArCX0gZWxzZQ0KPiA+ID4gPiArCQlz
aXplID0gcG9zICsgcmV0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJaWYgKChydyAmIFJFQUQpICYm
IHBvcyA8IGVpLT52YWxpZF9zaXplICYmIGVpLT52YWxpZF9zaXplIDwgc2l6ZSkgew0KPiA+ID4g
PiArCQlpb3ZfaXRlcl9yZXZlcnQoaXRlciwgc2l6ZSAtIGVpLT52YWxpZF9zaXplKTsNCj4gPiA+
ID4gKwkJaW92X2l0ZXJfemVybyhzaXplIC0gZWktPnZhbGlkX3NpemUsIGl0ZXIpOw0KPiA+ID4g
PiArCX0NCj4gPiA+DQo+ID4gPiBUaGlzIGFwcHJvYWNoIGNhdXNlcyB1bm5lY2Vzc2FyeSByZWFk
cyB0byB0aGUgcmFuZ2UgYWZ0ZXINCj4gPiA+IHZhbGlkX3NpemUsDQo+ID4gcmlnaHQ/DQo+ID4N
Cj4gPiBJIGRvbid0IHRoaW5rIHNvLg0KPiA+DQo+ID4gSWYgdGhlIGJsb2NrcyBhY3Jvc3MgdmFs
aWRfc2l6ZSwgdGhlIGlvdl9pdGVyIHdpbGwgYmUgaGFuZGxlIGFzIDEuDQo+ID4gUmVhZCB0aGUg
YmxvY2tzIGJlZm9yZSB2YWxpZF9zaXplLg0KPiA+IDIuIFJlYWQgdGhlIGJsb2NrIHdoZXJlIHZh
bGlkX3NpemUgaXMgbG9jYXRlZCBhbmQgc2V0IHRoZSBhcmVhIGFmdGVyDQo+ID4gdmFsaWRfc2l6
ZSB0byB6ZXJvLg0KPiA+IDMuIHplcm8gdGhlIGJ1ZmZlciBvZiB0aGUgYmxvY2tzIGFmdGVyIHZh
bGlkX3NpemUobm90IHJlYWQgZnJvbSBkaXNrKQ0KPiA+DQo+ID4gU28gdGhlcmUgYXJlIHVubmVj
ZXNzYXJ5IHplcm9pbmcgaGVyZShpbiAxIGFuZCAyKSwgbm8gdW5uZWNlc3NhcnkgcmVhZHMuDQo+
ID4gSSB3aWxsIHJlbW92ZSB0aGUgdW5uZWNlc3NhcnkgemVyb2luZy4NCj4gDQo+IFlvdSBhcmUg
cmlnaHQuIFRoZXJlIG1pZ2h0IGJlIG5vIG5lZWQgdG8gY2hhbmdlLg0KPiBJdCBjb3VsZCBiZSBo
YW5kbGVkIGluIGRvX2RpcmVjdF9JTygpIHdpdGggZ2V0X2Jsb2NrIG5ld2x5IG1vZGlmZWQuDQoN
ClNpbmNlICJzaXplID0gcG9zICsgcmV0OyIgaXMgdXBkYXRlZCB0byB0aGUgYWN0dWFsIHJlYWQg
cG9zaXRpb24sIHRoZXJlIGlzIG5vIHVubmVjZXNzYXJ5IHplcm9pbmcuDQpUaGUgY29kZSBkb2Vz
IG5vdCBuZWVkIHRvIGJlIHVwZGF0ZWQuDQo=

