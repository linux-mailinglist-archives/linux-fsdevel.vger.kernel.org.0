Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BF14DD4FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 08:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiCRHD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 03:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbiCRHD4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:03:56 -0400
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950E42B7215;
        Fri, 18 Mar 2022 00:02:38 -0700 (PDT)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22I5HvaB003067;
        Fri, 18 Mar 2022 07:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=ijqZB65NO06ZX0YwF5qw+KW7OPL+sQLkgONhysd8Y+c=;
 b=SeE6Z5PEof4Eu/C/WJeA0hPyQunzqYEG6Q1aRy/n4VFpyFhzixA77BPRQyMQvbNgUmLy
 oJ2rF0nQE5ofLuGsXGSGrrrNQ6MUrkSyiRKPSmSdaPdLKHEKvRXT5QVpxwQ96FMaUuIG
 xmxE7jNm8WCAiL5x7vBhujzJycHCwkviXIcz49VRBl9gbQ26gn+im8OKWvPKQr8Z/lSP
 eSAoLle42hZgTLD+1rRnY93eJM1Tewwe4SkhXVEx9LxrnWD6YoWtyvItVe9gHsJi8EgB
 MW7xj8Vxy4Yr6+euble9Ge+LsAxJQWiUzUDh4oS+oniB4GpiEF2YuMW3me1BRWC3MgDi Gg== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3evgjyr7mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Mar 2022 07:02:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ai6r/iIxFvOYOLbMWUDdXa816vTr1R95kIQget1YelZvTWBQMZFCVCxNBghkP/9s2E0CyuvaFUzHshluqpOJrCBoZEk6vnGN6UPFh7fnsr4/DxWsKHchhJT6kWBYsnlNqPmODoyYp3nlDiaOyEMvkWxOZ3gbnHxktsQgl7vb66FMCJn6rRdyb82YWVYzPWAS6fOaDqt8xr2VPiZKVkchzzxX7glhTcIeH9iuiy2CzIPnQhVurP+Mnx8EdN/XQJg2Nw3Gigaz/jBh6Q/pI9gM4cOYgodncJx9jEiANmB/gZNT/SUtZis9MiRNCLPo+mrKI9zg7v9kQ7hL3u8ADpfjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijqZB65NO06ZX0YwF5qw+KW7OPL+sQLkgONhysd8Y+c=;
 b=Q4UvPMPBL4zFvPmCODpHGuA/rbVaYWI2qWt6D0A3Bs49yfbYafAk8PA5Di6E/8ELH3cd8n6hEua0hvPGE9v9w3bOkoyOUc2x8x4YIChKiAFlIgb4qrsr92LVRfEYMVTccqzDfNZfl98mTYXqH0fhzk+ZUrPpJLAZjpDHStpBjcdtMyDRQo6I91LO0N70Pc6JJwBbniFEtjkqFHFSZrz6p044dobc8OY7rq8LwzV0TXQsoEnctkV/7WFxjLgGw4ZsTUX8fqK4WEo8+QjiRmigAKD9RrC/G312QxIyM22C4cZW0oK9+j1gFuIxtFV4vL65B5UX/lc7s2VRJsoxXpmXLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by TYZPR04MB4350.apcprd04.prod.outlook.com (2603:1096:400:21::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 07:02:12 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094%4]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 07:02:12 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>,
        Namjae Jeon <linkinjeon@kernel.org>
CC:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: RE: [PATCH v2] exfat: do not clear VolumeDirty in writeback
Thread-Topic: [PATCH v2] exfat: do not clear VolumeDirty in writeback
Thread-Index: Adg0Vskc+T+8E+65Sm+jIEZBsmb4mgAqgpIBAL5OAAAARKJNoAA1uDUSACKGEAA=
Date:   Fri, 18 Mar 2022 07:02:12 +0000
Message-ID: <HK2PR04MB38917C6F999A9186CCDCB90F81139@HK2PR04MB3891.apcprd04.prod.outlook.com>
References: <HK2PR04MB3891D1D0AFAD9CA98B67706B810B9@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <TYAPR01MB5353A452BE48880A1D4778B5900C9@TYAPR01MB5353.jpnprd01.prod.outlook.com>
 <CAKYAXd9BO1LipYx1EtOK=Uo11dY3beBc_0mh_t=opWXPibutBQ@mail.gmail.com>
 <HK2PR04MB389107EDB293B91E9750CEEE81119@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <TYAPR01MB5353C2C84F4006C2BEE20DC090129@TYAPR01MB5353.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB5353C2C84F4006C2BEE20DC090129@TYAPR01MB5353.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff8da3ba-fc77-44e8-d0fe-08da08ad3a49
x-ms-traffictypediagnostic: TYZPR04MB4350:EE_
x-microsoft-antispam-prvs: <TYZPR04MB4350C8B55B6107E0CB80CCDD81139@TYZPR04MB4350.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tmDYAXNhxfNt5dnE0BoOtpVhzLXbConWjj26vgsDCuWUeNUOeSynaQGfxQsYNb1ioAvOH5246Tucp/XVS7HUyv0CkZOSQU8r4+l2BzPFmd7/7Z2UNOMHmNZ96b0aar6ygx+rbJw774Bwsip1QdO6meVCSgGeA3KLk5HbHf27iCfds1myFR4tJLcru0ajq6ZTAbBIddOUfrLFATnmvVhuVvtmCg9xJnaJhrXFdqRv6wtZwOG22EnNOdqs3P0SuaDk6M2rOH3cd278pG6zg4TiWZY+kU7PcIQ2EVaQ4dE51efw2r/8T7dnhbbIJz3RqW+EvK9XI8oWfTIaf7f/+RhJPYnYKKvHnN/MAUX6i19KuBEjKdORvhlsxf+IA97+08+vofLzhQr1d6sEsDwtu7UyDHGtfj7Ozap6elkzoA4zaj3Ovz7o/dpIDrB/UWYP3Myy3yVO/VejNTtF2/Fs4nV7t0r6q9LKxaisBzhOn3vsrSCqkQbnkcSxigkmHNIslCWIEwIcG8WuwpgHYeorGoTjkVo5SOa/+BFNzOkmD4EEMmwx802osj2sCwYIRrKToFawnDDi6AthW5JytIJMEHgozTxBu/5JtMaZBR/2RHl1VsLyC7vho5bpmxCYw1GV9jyRoQQQriPadKMUDV3aQurgen9ropfzGDIrSXMUEIOk0c3evHZwGfMtECB+Vau9umZSW9PEfUGhpr2DQyBCsCLKlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(66476007)(66556008)(66946007)(76116006)(82960400001)(7696005)(66446008)(110136005)(54906003)(8676002)(38100700002)(64756008)(4326008)(508600001)(33656002)(107886003)(26005)(55016003)(186003)(316002)(9686003)(71200400001)(6506007)(2906002)(8936002)(52536014)(86362001)(83380400001)(5660300002)(38070700005)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wk9WekdpcDJaTm1tZUx2aUxxTG9vRGFQcUpHWDJqZi9RbWE0UDFOT2ROVWw4?=
 =?utf-8?B?Z0VudFBnNEVIUm40M0VLMlJ5eC8yQStPMFZxalFrcVhmdWt4MlUyOWIzUnRZ?=
 =?utf-8?B?Uy9BS1RIcThRYS92OTFyOENoUWFOdjBjY2o3aGpVZnFHemRDNU9pTTVUZ1Zi?=
 =?utf-8?B?YVJWR0ZoaDA2c0tCeWRuY2tRQS9sTXRUZUFRZ0o1bDN6SEphRzdlc2xVeDYy?=
 =?utf-8?B?alFUWThERkpxVlAzY3YzL2w0bWR0blFiaTAzSDBodGRHQWw4YUQ4ZzJzQ1VP?=
 =?utf-8?B?RXRGYTdaajdRUlR5Z042bDd6eDliZGdBMVEwNzRCblRmSGgwMjg0cXdsdG05?=
 =?utf-8?B?cEJabGJIV2ZWUG4xVFRpMXVrMHhoMERSeGFzVUtMcFlpbndQRmJZNi9aempG?=
 =?utf-8?B?UE9aUkdESHlEV3QwV1NjLzN4RHpEN1J6Z1dPSVRMc2VnRUZnNmxQYWoyVWVO?=
 =?utf-8?B?YzNNWTRUTWhlOWlUVlFyUlZNVzZtT0Ztd3ZrUU1ieWozRWkrWEphM0xVVW8z?=
 =?utf-8?B?MmJhcVZDV0M4YklzaU85ckdWbFc5S056cUNHWFdsMElEK1cyRVdlek1WbEZp?=
 =?utf-8?B?UlVOZHYwaVVxRE9NaXJ3L0dRYkIwclFLVGh2M01qVlF0cHl2cFVML0lHckp4?=
 =?utf-8?B?WWo3WTBoaFJhbWhjTHR3T2Y0Nk52Mm5vL3BERzAwQ1B5RVZuZStNS2RGSWV2?=
 =?utf-8?B?cXBxMDBlWE1uQURMZXgybUJMendDVGJ5Y25QTkZkNlNVMlBQNnRqVzlVRDRO?=
 =?utf-8?B?VVh3a3VDSDM5YStsZUQrUEtLaU5sOUpweHNNVUZXc01CWXdMVXg5bEt1d3FZ?=
 =?utf-8?B?MXBGSDNLRlRQMDNDTTlYRHdDY2JvOUxTc0lZcU5Va0s2Uk1ibXFvUjRibi84?=
 =?utf-8?B?eFNTb2hRNm0xVkYyYTZTQTRpQ01ZMXV1ZzZHUFJUR0MzcmY5K0l2OG0yTi93?=
 =?utf-8?B?TFNqSzYydEU3VjJDS3ZUcWhEOXNtM29iVW1GT2wxRFZVL2R3b29KamxibDBk?=
 =?utf-8?B?a1ppT1pnYWhqVWtkVkNjMy9DN3ZRYXJWcDhOK3hSd3BJUWJkVVlBdnZRblNv?=
 =?utf-8?B?OTVqRXMwSGRXY2llQUF2OS9xdFJsN3JSNGVDdHlOWk15bWUvNFJENlZidndh?=
 =?utf-8?B?YTZNbi9LL0FZWUVJMUlaUGR6OGZ2OHNkRU9YSi9NcUJRb3JCU3R1ZE1MWkZ5?=
 =?utf-8?B?TVhnL0JCbUd5N21iZ09ETGwyVkU2VXZZcHpFTlI5aTdFbkQyVXNCODQweHNk?=
 =?utf-8?B?djhZTm1qaXVtcHBiYUJ0YXRQOHBsWGxOcUlhMHppK25KWkxXVCtVdzMyNk1T?=
 =?utf-8?B?dDdINk1zMU9XaUo5MkJZNSttQjVYTDhIVFR6OElrMUZvbUhDcW9icjducGZ0?=
 =?utf-8?B?Z3pFZDJMa3lzdXJXVzlsSFd0SzJITjFBK2dqTTdZOURBejJqVExnZVdiT2cr?=
 =?utf-8?B?aEJrV08vaFBvYy9zcTFmdnNCOHFxU0c3K25GVStpaGs0MlIwYVpueXVueXRK?=
 =?utf-8?B?OStHZWRhaEdjcXJ1bUF6d2p4WUhVRjhVZzFOV1gyUDNwV1JzeVI5S2diOElS?=
 =?utf-8?B?L2Q2RWxvQ1diS1lBcVEzUHc4eFExcldkQXNEQlFWRlkxbjNyMEhmMFAyRU5l?=
 =?utf-8?B?TFRrcm9WdlkxNUgxM1BJL1BYc1ZBTVV4WlRFQlFaOEEwWTNtcVoxb0x2ckJ6?=
 =?utf-8?B?d1ZCQTltQmoxMUlkZkhxU1liQnBNYTl5QnJEQVRLMDZBb05HdVMwb1M0ZFBX?=
 =?utf-8?B?bGszd1ZzNk80MFZrMVM2cERXRVhKYVpwOGRxNThPMGtyVDlDUFMzRGNpOWJW?=
 =?utf-8?B?aWFXbE9JaCtxelA0c1oyRnNIVk5RTnBPYzAxQWU4OWtFekQxUkdZTWVOL0c0?=
 =?utf-8?B?dXlwRHFJcTR6M2pZYXZqV2Zaa3hNYm9iWmQwZVVnYnp4MWNCQUVJQjl2WTF0?=
 =?utf-8?Q?NQorhFQrUhhIy8iXYjooKxAyy9E0VRPn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8da3ba-fc77-44e8-d0fe-08da08ad3a49
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 07:02:12.4283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BMCKLgu0PQ6ngvglxJG9Sqic8CLjn8e5hI3oLprcJpTdsFT9qOyrScTdOmNVNNWL44QcCdWW7gtGN6Xx2SwArA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4350
X-Proofpoint-GUID: UlTejO9qd_ehHLv6GJ-oeHQnk9osBeiB
X-Proofpoint-ORIG-GUID: UlTejO9qd_ehHLv6GJ-oeHQnk9osBeiB
X-Sony-Outbound-GUID: UlTejO9qd_ehHLv6GJ-oeHQnk9osBeiB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-18_06,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=567 clxscore=1015
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203180036
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgVC5Lb2hhZGEsDQoNCj4gPiBleGZhdF9jbGVhcl92b2x1bWVfZGlydHkoKSBpcyBvbmx5IGNh
bGxlZCBpbiBzeW5jIG9yIHVtb3VudCBjb250ZXh0Lg0KPiA+IEluIHN5bmMgb3IgdW1vdW50IGNv
bnRleHQsIGFsbCByZXF1ZXN0cyB3aWxsIGJlIGlzc3VlZCB3aXRoIFJFUV9TWU5DDQo+ID4gcmVn
YXJkbGVzcyBvZiB3aGV0aGVyIFJFUV9TWU5DIGlzIHNldCB3aGVuIHN1Ym1pdHRpbmcgYnVmZmVy
Lg0KPiA+DQo+ID4gQW5kIHNpbmNlIHRoZSByZXF1ZXN0IG9mIHNldCBWb2x1bWVEaXJ0eSBpcyBp
c3N1ZWQgd2l0aCBSRVFfU1lOQy4gU28NCj4gPiBmb3Igc2ltcGxpY2l0eSwgY2FsbCBzeW5jX2Rp
cnR5X2J1ZmZlcigpIHVuY29uZGl0aW9uYWxseS4NCj4gDQo+IFJFUV9GVUEgYW5kIFJFUV9QUkVG
TFVTSCBtYXkgbm90IG1ha2UgbXVjaCBzZW5zZSBvbiBTRCBjYXJkcyBvciBVU0INCj4gc3RpY2tz
Lg0KPiBIb3dldmVyLCB0aGUgYmVoYXZpb3Igb2YgU0NTSS9BVEFQSSB0eXBlIGRldmljZXMgd2l0
aCBsYXp5IHdyaXRlIGNhY2hlIGlzDQo+ICAtIElzc3VlIHRoZSBTWU5DSFJPTklaRV9DQUNIRSBj
b21tYW5kIHRvIHdyaXRlIGFsbCB0aGUgZGF0YSB0byB0aGUNCj4gbWVkaXVtLg0KPiAgLSBJc3N1
ZSBhIFdSSVRFIGNvbW1hbmQgd2l0aCBGT1JDRV9VTklUX0FDQ0VTUyAoZGV2aWNlIGRvZXMgbm90
IHVzZQ0KPiB3cml0ZSBjYWNoZSkgZm9yIHRoZSBib290IHNlY3Rvci4NCj4gVGhpcyBndWFyYW50
ZWVzIGEgc3RyaWN0IHdyaXRlIG9yZGVyLg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgZGV0YWlsZWQg
ZXhwbGFuYXRpb24uDQpJIHdpbGwgdXBkYXRlIG15IHBhdGNoLg0KDQpCZXN0IFJlZ2FyZHMsDQpZ
dWV6aGFuZyBNbw0K
