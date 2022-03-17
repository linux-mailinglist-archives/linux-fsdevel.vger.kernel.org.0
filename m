Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41964DBEB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 06:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiCQFtD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 01:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiCQFtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 01:49:01 -0400
X-Greylist: delayed 7038 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Mar 2022 22:19:13 PDT
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466442A85C2;
        Wed, 16 Mar 2022 22:19:12 -0700 (PDT)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22GNSa5v032662;
        Thu, 17 Mar 2022 03:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=fGHqYoLRVbu10w+te7khMCY8dKDoonNSaM5V2bH+TcU=;
 b=fyGipSdspD0lhdLdHEKpdxXFmKmzXd05CrsOosyATJmEBXwZHTJExVDmxdMN+cvWDejT
 ZxPSVjhkyVYp7PcU157ZJZvtz2w6w6E6XF3CbqgRbJ9F3D6uj0AHL1ocTsxi1ubA1Cbr
 RCMt7mtKgqgaO8iI6HJChE4TZO3V9I30VdQQAWvEnQHYLl5EyxG40IAbrJ5lTaNxM9l5
 6f8W5m2g8EOcgql1R8J/NKSw5whmYDFPcnN4iArDrIDCU72RSJygmHGTGkihta9lmoRJ
 1T7XzJBH2hGBoGn1MMDq2qh5JLQyFukghEb62V9EFgpKbYnEoZXotcvJr8dzYLPDjRgo QA== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2112.outbound.protection.outlook.com [104.47.26.112])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3et65eb0ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 03:21:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaKmnNs2e2fncjdY2G8yovCzNIuaMdDRPgMHw5DlFAgtXIiUA8vlsgWtp/cErGxuGHtNrPyW5zIM+ntMtXKvQsNqVnDste1QiEC9mq1QDZcFS33+tt0NtPaZclrJAavSk2ON4ul0DeLK7wSzEisPFRiVSZck9Z+I9rKAYw2QMSQiXZNWGvYmI0O4HfhtxVtHN1xncctDaM+Um4/9WubErDJ5ir/DA+gM6A5duA6uQ6AMi7UxW+evCNAEfjCZfIu6ot3TQ/+WbSOaUiJ0o+DbXRqoygq5GeK+AvwNyDDr7TWSTkmcWyV4Ge3nSym7SXZ05vRajtHHYQn7HsuH3WdtDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGHqYoLRVbu10w+te7khMCY8dKDoonNSaM5V2bH+TcU=;
 b=gzwo43oiHeor5VqB6Fqlhy+dBz+8EcpTu3u/7PYXzBpQBsycIMqL/Fpc64r8fISyYaaFtzU0mXI99Mdo36M1kPfmvwT26rU9tykDw23IlNj7oyZ4X5RxcDfezx/6PMttEVPgKqvyL8pegQohI2e1uX0M0022UKAip0taTcwxnN1cXoNcr50g478Njg4PyDtm4GnrL5ZT10ryhmRs5QY2kQcu+luhbRmOQrhPh65SDwAKo6BkEW1Jj5bjFKzkHG0zn9jZ4zwfFqrc8LBc3q2HCFEUZIzQEtCvFI4Fas/Bi3HBLITLrz/vaQP5WxUAqFONNWJb9x268dApE3kz1X+VrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TYAPR04MB2272.apcprd04.prod.outlook.com (2603:1096:404:1c::18)
 by PS1PR04MB2837.apcprd04.prod.outlook.com (2603:1096:803:4e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Thu, 17 Mar
 2022 03:21:29 +0000
Received: from TYAPR04MB2272.apcprd04.prod.outlook.com
 ([fe80::21bc:f520:8d5c:b819]) by TYAPR04MB2272.apcprd04.prod.outlook.com
 ([fe80::21bc:f520:8d5c:b819%7]) with mapi id 15.20.5081.016; Thu, 17 Mar 2022
 03:21:28 +0000
From:   "Andy.Wu@sony.com" <Andy.Wu@sony.com>
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>
CC:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: RE: [PATCH v2] exfat: do not clear VolumeDirty in writeback
Thread-Topic: [PATCH v2] exfat: do not clear VolumeDirty in writeback
Thread-Index: Adg0Vskc+T+8E+65Sm+jIEZBsmb4mgAqgpIBAL5OAAAARKJNoAAn5W/g
Date:   Thu, 17 Mar 2022 03:21:28 +0000
Message-ID: <TYAPR04MB2272239E6B2EBE91E719C9A080129@TYAPR04MB2272.apcprd04.prod.outlook.com>
References: <HK2PR04MB3891D1D0AFAD9CA98B67706B810B9@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <TYAPR01MB5353A452BE48880A1D4778B5900C9@TYAPR01MB5353.jpnprd01.prod.outlook.com>
 <CAKYAXd9BO1LipYx1EtOK=Uo11dY3beBc_0mh_t=opWXPibutBQ@mail.gmail.com>
 <HK2PR04MB389107EDB293B91E9750CEEE81119@HK2PR04MB3891.apcprd04.prod.outlook.com>
In-Reply-To: <HK2PR04MB389107EDB293B91E9750CEEE81119@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa561423-7466-41e0-0122-08da07c539b1
x-ms-traffictypediagnostic: PS1PR04MB2837:EE_
x-microsoft-antispam-prvs: <PS1PR04MB283772B22F14E69C9E5B49A980129@PS1PR04MB2837.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PxvE3vGXlFkWUF+2r1mK945Zao/8vynDCSS5K3kca9j1pOFAKUZeuXBlqe2DU1jr//nRQsv//vjc6eikRWkpuw3xE2lO69dOsGX8NMhqqSxD4kjsoChVlHFgSJdYpnM4eodFpTEB2g/i74Al11N9kk7xc+fnF6uX2TpGl1EulViruxJNfKrvP+847W3j9shMGp+fKaZVguv7R4w1w28kxSZ993UYATf1oQCPzUW5/DQKiuVsOEGiUw7afXGVsRJAkzY5bCHEKd2VDNyaAJRMjVsrIPOFOt+YOHlCmCUBKkBZLbEo8F8fvKwob5GQa3zENtMZPoN7FYIfRWZ9aODmj3Mt/YuoylH1LzCdu8X+b3lFNa9iEFOeWX6PqiPhAOS92hgabReV61l57cZLeS9UOvMyvVUsr40wZRys9T11cEgFAPQurWm5Hem3nOWjvHwt0qosukkRYul0cpgKQaFv277DQzFGHyKQFadu41NLzmWuoHRouVHGUlAwLLWLj8iHs5vcK3KBzAaDINoDJUu/izCjC72dvUEJIIdYqQUe47LnVMlJZ/7kKD8MnXKIk9YFyePx5j46fDt1mK06EA68ni3PI1Bs4X5lYOY531bw4N7mvqKXhOA3yp0Cf0jtLBDVr8nakZvIh6X7Vz6+65WBDe8GDnlTAOudP+Mam8x0Vpc2xb6bzCdEhlfhbk9jahbQ9rt+L3jROt91NrDphRs5yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR04MB2272.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66476007)(64756008)(76116006)(66946007)(107886003)(110136005)(186003)(53546011)(55016003)(71200400001)(38070700005)(508600001)(26005)(38100700002)(8676002)(4326008)(66446008)(82960400001)(6506007)(2906002)(7696005)(5660300002)(122000001)(52536014)(9686003)(86362001)(33656002)(54906003)(83380400001)(316002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVM0SUlwZ1hGdytMMCtyZWVKaVZvbWVWQmM1ejRiLzc5TUppK3lKdjk3RmRW?=
 =?utf-8?B?Q0FIMXFkYzlkMTE1L2dYZGtCMkVpaDI1SXZRMTlHeEJFTFFONzJ0WHNoT2cv?=
 =?utf-8?B?ZTJVbjJFQzJRRjdxaGN1b3R1RTNQMGpndWxhaWZ2MjlqZjdMZk9OOEhLSjRq?=
 =?utf-8?B?VTJvOGdsSXRzVEJEVStOZFdha1ZPTmJ4eVN3WmZYTUVSR1Nta1ZDK0lwTWU4?=
 =?utf-8?B?b2t1a1I5WTBYbHRwcXVkc0oxOEpHUVEyOHFHbkJzbTB2VkNoTzNzQmxHdGh0?=
 =?utf-8?B?N0U4ME1wcGNsTVJiMmducDVMb2JycjA0c09JcjIyNHV3M3BXcXpxUnkrOVFQ?=
 =?utf-8?B?eElQTWUxMzl4UzBSRUlqZ2tyU21sZS9id3h1Vkh1OVY2V1dYckVmQ2M5VGNh?=
 =?utf-8?B?MFRoU0hBRlZBTDMyOGNQNUgxUkdWdVF2ajNyRXhBYzJlZE5SL05ueWFhNmFG?=
 =?utf-8?B?VXJ5UURmb3VhYzVIMU5XYmM0T3JhWFJhcXI0eDNQV1NRRlpBVFZpSmNNWnBZ?=
 =?utf-8?B?anFEYUhLdDBZKzFRbUg0UThzY2FaYVM4dFROUm1HNk1jM0lxQUwyRUgwcWN2?=
 =?utf-8?B?ZndaYkJoRkJsQ3VWU2hOL0lIbkZBeWxIQkQvZDRQUlNYOXo0MXlySVNnM0Rs?=
 =?utf-8?B?SUlCc2JhNElqZTlwQmMrTmFnWGpPWGRLNnJEdFRxTXlOZ1pTQnBadUNoWS9W?=
 =?utf-8?B?SVY0emVuQStiMXo3THVwcWQxWm1XTmRLOXJkK3VCZm1kcnRRRjQrOHVmQmFn?=
 =?utf-8?B?SksyWlBsNEJaRzhwTjc0VlM4eEZadXhNaUphamEvTXk4cFE0eUdXVG0xWUZv?=
 =?utf-8?B?UVZGbFk0Um9IM3NLbXZ1eldLb0krRmN0dGpvMlk3bjc1eGRQU256RGpERzNL?=
 =?utf-8?B?cG5mUnNyTmxUOU1BWkNQZHE0cjBscU11UGhuZG4zYnVEV3BKQ1hReXZSVnhm?=
 =?utf-8?B?c043TzNyMHZHaS9odGlWc3BmY1orMnhsdWlZaE9BcHAyN1N0OW80dVRUOThG?=
 =?utf-8?B?c3A2TDh3OFVGaTZSaGl3MXloT0J0U1pYY1lnbGxtZU9zTldJdHhPOHlLUmNw?=
 =?utf-8?B?SlBKam1GcFNXK1Q4aU9VeHNML3hxdDJKL0Q3Tyt4VW1VbFVJb0sxSHVHN2Nm?=
 =?utf-8?B?bmdVMXZ4ZzBRMTNmNWEvR1F4SzBKdnlrY2tSbzhjTUlPV2VIQjUzWVBjd1p0?=
 =?utf-8?B?ci9LWWliMnVZbURidFJXNFlZb3cxVitIbEJsRlA4blZLQUJnbTM1SXJlbFoy?=
 =?utf-8?B?MGtOV0pYZzhDMlMzZ3loY2dYQlJHQUJGaFdpZW5ZV0tZQkJTaEtueGFLSHlZ?=
 =?utf-8?B?eCs5bTBQZVg3dDR2dTJLVXIvUWlNc0dVbjI4aU00MmJmSGswUG05Sjh1VFp2?=
 =?utf-8?B?SXZLbk9wNmN1MnVNZTZlWUpzSkMxYlljYWxoMFQzekN5UTROK2tuM0Nwc05P?=
 =?utf-8?B?N2JSU0VTb3pOSWs3d0Vmc3VZVHljQ2FvK0hXWURlMExtbWE5V2NmV04vVm5v?=
 =?utf-8?B?cE0yNXM1Y0xObDBjNG0yZEdJT0lDK0t5SVAzL2N0NEx0SUN1dlIwVVkzNzJI?=
 =?utf-8?B?MnVRcHlVZklFZWppcmxtVFZTVGp2U2RlZUVacHZGY2pUdTFrOVZidisyOW5n?=
 =?utf-8?B?UldWTkJCK3V6OFhwUmdIYTNqQ0pxMWZjYU9pcnFSN1MraHJ2MjZhVXhSRVRj?=
 =?utf-8?B?c3BxbWhOSnN0ZTh4NFltazVuWXIxR1ljZFIyVUVBOHlmUEJJWlY5bDU3bUgw?=
 =?utf-8?B?Z25kWFc0dllvL2M0WkMyLzFJR1c2bnV6Z0lmN1pMY0hiZTVrb3I0dElMRXh4?=
 =?utf-8?B?U0piY3VCQm03S1hhbGtwNmg4NjFSaVdBVGxYZmZSWnBVUEdoVityL0tZNlhv?=
 =?utf-8?B?YUJIQVBWbTU0bktSUmZwR0t3enZHTGlGc1BvRkZVbXVvMHVPQitGMmpRTmFx?=
 =?utf-8?Q?mbauYsjUMAA41eYsB15ih2z30fPwO43Q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR04MB2272.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa561423-7466-41e0-0122-08da07c539b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 03:21:28.2949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0+4VyXTYANtab20722ezN/8pC2AGVz8eO35QNJ4wfkcvnbHQmrc16nBG+GQwzwcNH4RBlOOnnD/9+jY2ulS7vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR04MB2837
X-Proofpoint-ORIG-GUID: wG069fi-A-5-blwTC1W4pRtA2vs8hC8B
X-Proofpoint-GUID: wG069fi-A-5-blwTC1W4pRtA2vs8hC8B
X-Sony-Outbound-GUID: wG069fi-A-5-blwTC1W4pRtA2vs8hC8B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_09,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=716
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170019
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgWXVlemhhbmcNCg0KPiBXaGVuIGNhbGwgZXhmYXRfY2xlYXJfdm9sdW1lX2RpcnR5KHNiKSwg
YWxsIGRpcnR5IGJ1ZmZlcnMgaGFkIHN5bmNlZCBieQ0KPiBzeW5jX2Jsb2NrZGV2KCksIHNvIEkg
dGhpbmsgUkVRX0ZVQS9SRVFfUFJFRkxVU0ggaXMgbm90IG5lZWRlZC4NCg0KSSB0aGluayBLb2hh
ZGEtc2FuJ3MgbWVhbmluZyBpcyBsaWtlIGJlbG93Og0KDQotIHN5bmNfZGlydHlfYnVmZmVyKHNi
aS0+Ym9vdF9iaCk7DQorIF9fc3luY19kaXJ0eV9idWZmZXIoc2JpLT5ib290X2JoLCBSRVFfU1lO
QyB8IFJFUV9GVUEgfCBSRVFfUFJFRkxVU0gpOw0KDQpJIGd1ZXNzIHN5bmNfYmxvY2tkZXYoKSB3
b24ndCBndWFyYW50ZWUgc3luYyB0byBub24tdm9sYXRpbGUgc3RvcmFnZSBpZiBkaXNrIGNvbnRh
aW5zIGNhY2hlLg0KDQpCZXN0IFJlZ2FyZHMNCkFuZHkgV3UNCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBNbywgWXVlemhhbmcgPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0K
PiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDE2LCAyMDIyIDU6MTggUE0NCj4gVG86IE5hbWphZSBK
ZW9uIDxsaW5raW5qZW9uQGtlcm5lbC5vcmc+Ow0KPiBLb2hhZGEuVGV0c3VoaXJvQGRjLk1pdHN1
YmlzaGlFbGVjdHJpYy5jby5qcA0KPiBDYzogc2oxNTU3LnNlb0BzYW1zdW5nLmNvbTsgbGludXgt
ZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IFd1LCBBbmR5IDxBbmR5Lld1QHNvbnkuY29tPjsgQW95YW1hLA0KPiBXYXRhcnUgKFNHQykgPFdh
dGFydS5Bb3lhbWFAc29ueS5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjJdIGV4ZmF0OiBk
byBub3QgY2xlYXIgVm9sdW1lRGlydHkgaW4gd3JpdGViYWNrDQo+IA0KPiBIaSBOYW1qYWUsIEtv
aGFkYS5UZXRzdWhpcm8sDQo+IA0KPiA+ID4+IC0gICAgICAgaWYgKHN5bmMpDQo+ID4gPj4gLSAg
ICAgICAgICAgICAgIHN5bmNfZGlydHlfYnVmZmVyKHNiaS0+Ym9vdF9iaCk7DQo+ID4gPj4gKyAg
ICAgICBzeW5jX2RpcnR5X2J1ZmZlcihzYmktPmJvb3RfYmgpOw0KPiA+ID4+ICsNCj4gPiA+DQo+
ID4gPiBVc2UgX19zeW5jX2RpcnR5X2J1ZmZlcigpIHdpdGggUkVRX0ZVQS9SRVFfUFJFRkxVU0gg
aW5zdGVhZCB0bw0KPiA+ID4gZ3VhcmFudGVlIGEgc3RyaWN0IHdyaXRlIG9yZGVyIChpbmNsdWRp
bmcgZGV2aWNlcykuDQo+ID4gWXVlemhhbmcsIEl0IHNlZW1zIHRvIG1ha2Ugc2Vuc2UuIENhbiB5
b3UgY2hlY2sgdGhpcyA/DQo+ID4NCj4gDQo+IFdoZW4gY2FsbCBleGZhdF9jbGVhcl92b2x1bWVf
ZGlydHkoc2IpLCBhbGwgZGlydHkgYnVmZmVycyBoYWQgc3luY2VkIGJ5DQo+IHN5bmNfYmxvY2tk
ZXYoKSwgc28gSSB0aGluayBSRVFfRlVBL1JFUV9QUkVGTFVTSCBpcyBub3QgbmVlZGVkLg0KPiAN
Cj4gYGBgDQo+ICAgICAgICAgc3luY19ibG9ja2RldihzYi0+c19iZGV2KTsNCj4gICAgICAgICBp
ZiAoZXhmYXRfY2xlYXJfdm9sdW1lX2RpcnR5KHNiKSkgYGBgDQo+IA0KPiBleGZhdF9jbGVhcl92
b2x1bWVfZGlydHkoKSBpcyBvbmx5IGNhbGxlZCBpbiBzeW5jIG9yIHVtb3VudCBjb250ZXh0Lg0K
PiBJbiBzeW5jIG9yIHVtb3VudCBjb250ZXh0LCBhbGwgcmVxdWVzdHMgd2lsbCBiZSBpc3N1ZWQg
d2l0aCBSRVFfU1lOQw0KPiByZWdhcmRsZXNzIG9mIHdoZXRoZXIgUkVRX1NZTkMgaXMgc2V0IHdo
ZW4gc3VibWl0dGluZyBidWZmZXIuDQo+IA0KPiBBbmQgc2luY2UgdGhlIHJlcXVlc3Qgb2Ygc2V0
IFZvbHVtZURpcnR5IGlzIGlzc3VlZCB3aXRoIFJFUV9TWU5DLiBTbyBmb3INCj4gc2ltcGxpY2l0
eSwgY2FsbCBzeW5jX2RpcnR5X2J1ZmZlcigpIHVuY29uZGl0aW9uYWxseS4NCj4gDQo+IEJlc3Qg
UmVnYXJkcywNCj4gWXVlemhhbmcgTW8NCj4gDQoNCg==
