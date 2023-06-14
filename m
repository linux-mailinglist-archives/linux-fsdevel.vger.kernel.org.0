Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBD472FC4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 13:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243784AbjFNLYH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 07:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjFNLYE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:24:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EBFE55;
        Wed, 14 Jun 2023 04:24:01 -0700 (PDT)
X-UUID: 2ed930880a9a11eeb20a276fd37b9834-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=BLxZRvrny0FzR1NXdvQefms/LVvNEDrIvrxySeuBJIw=;
        b=LWOPHFz6EU5E886AY2i4cNQmgo6Vnu5oJJxRSWqEAkMRO/QkEn28LXflvcg/icnjTBot27FFQpaMPn8zNDcq1rUZCV0WSqyBa5R+wWYV38/ppdSjefeCed1XdBHq/A8CjzyiSDYsJE7Yz73+PT3TgeEqHaoPGpY33jyHOy0tEA4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:b5117cc4-f1c2-4228-a3de-f09df4e63525,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:cb9a4e1,CLOUDID:d431983e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:b5117cc4-f1c2-4228-a3de-f09df4e63525,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:cb9a4e1,CLOUDID:d431983e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2ed930880a9a11eeb20a276fd37b9834-20230614
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <wei-chin.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1917998810; Wed, 14 Jun 2023 17:59:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 17:59:41 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Jun 2023 17:59:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fs5A+A3eDJd/A0azkWjVannPY03CzV1xN1HfaKRg8JrbhRqvWNOJKYMSrmEz39XbGxqX7nYspO7AtBCcoD2I6MxDUYGRwVpjCHAdyuCRrTcqnC8S1i0/1fwFbw3C58s2eqLEkodiBXSCu4bh/q7Yqn8q45Ob8Wq4lPuZkDCkJCNNPziHl8NE/4EuJ9fPhGjAEjPgQ2fqAGj2intgy5xsjhoeuNDkWGTW8kGnyk7xKcZZgkuwCv8EOU9691YdzxybezYBuQgPwGoeMteEEJA1kTuQxDFJHtfDJ2uXAX0V2VllLsK5zsgwdafs8zoy36+veMs/D9bA3mdc9GQZjuU52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLxZRvrny0FzR1NXdvQefms/LVvNEDrIvrxySeuBJIw=;
 b=odQA+6NHXX4EL73ymv2TpXDY+KoxM/8uz9d6VN9CiCMEQ/3S4pdnQ8aOTkYfX78vvkqv5lCTi+MwV/cfGfnJ0PKuuGZnu+IH94ZZSpX1Eqn0aOF9ihB9pID+Y2IMoWgid5f4zqMf1DyyFDf6r6NqbNpZsDFO1Effe2Pc4nZGsKFW6d9ljN7DbQQ0FU6cbNFdVXQvFhgXIRXW3JFhpN1xo+BBg6Uza49f+a4Pppg+YG3PmnzDagZRXpM8i9SwZjIfQ4IyHVXFYZuhp8Km+5PeT2/AQKq8EPSNC+zUFMVYG/MJRg3k4d+lASWmSPoTwZQFL2vD7keQLEfokcUW4LS9Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLxZRvrny0FzR1NXdvQefms/LVvNEDrIvrxySeuBJIw=;
 b=NQtzElN3cj8zwwhF57n2hkHpUlNZ/vOa0JqxN0TxAUsuyaPumq22ubrG8xp8u99+QrLfJP7B2ZW70O8G2Aja5bBnqMzm3RNnTqvKKSSj1Tn/UECpHxeVv+t6ng0P050wtw8mykquK/jV33A+sgYcdKmFsCNQ5G6WEmRkMAzC2Gc=
Received: from JH0PR03MB8100.apcprd03.prod.outlook.com (2603:1096:990:37::13)
 by SEZPR03MB6444.apcprd03.prod.outlook.com (2603:1096:101:48::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 09:59:27 +0000
Received: from JH0PR03MB8100.apcprd03.prod.outlook.com
 ([fe80::56de:54d6:38f2:afcd]) by JH0PR03MB8100.apcprd03.prod.outlook.com
 ([fe80::56de:54d6:38f2:afcd%6]) with mapi id 15.20.6455.037; Wed, 14 Jun 2023
 09:59:27 +0000
From:   =?utf-8?B?V2VpLWNoaW4gVHNhaSAo6JSh57at5pmJKQ==?= 
        <Wei-chin.Tsai@mediatek.com>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TWVsIExlZSAo5p2O5aWH6YyaKQ==?= <Mel.Lee@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= 
        <ivan.tseng@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 2/3] memory: export symbols for memory related
 functions
Thread-Topic: [PATCH v2 2/3] memory: export symbols for memory related
 functions
Thread-Index: AQHZnm86bp64uNQQXU2F/FXPNJ366q+J43aAgAAteQA=
Date:   Wed, 14 Jun 2023 09:59:27 +0000
Message-ID: <fef0006ced8d5e133a3bfbf4dc4353a86578b9cd.camel@mediatek.com>
References: <20230614032038.11699-1-Wei-chin.Tsai@mediatek.com>
         <20230614032038.11699-3-Wei-chin.Tsai@mediatek.com>
         <ZIlpWR6/uWwQUc6J@shell.armlinux.org.uk>
In-Reply-To: <ZIlpWR6/uWwQUc6J@shell.armlinux.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB8100:EE_|SEZPR03MB6444:EE_
x-ms-office365-filtering-correlation-id: 8ab81ff9-3683-47b4-4365-08db6cbe0a4e
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NpVFO6KzCJBUB5JMHX34zeKpnuz5EC2Zgt8TiP+qW4VKEl5ESezxCVkjwgv2r7if7Q/CIslDNXJbACp6DJXhsSh3RufLBmml7ww58Gt5pIIhAe5eMzQBEX3E3gQbZUM16r/ww6ZN6GI1Ki4KudUWxmO0rwpUPHgMoLeZ3izq9eE3kmW989XxbXHF01p6bncsAwrcbshkA66Km2xWoDnCJJ7c1hZ9weRJpfkJMeRr0V0OWVK8OPh7gH41sCJpckX7Cyk9yUMJlYXiNbcCB7hhwoBs6KvupnEVwg9VJsFBlYdVe369bbLImSaG4dCUo+EZf3x2iKmsarZgW8Yn/zjsr5OnJS+c8z9oDsbVnDwvHg894hRr8rNAm6Z+NUUm7VVTFR10ZI14fOAkY0j779Q2eemdpLi/W3wzFZFaCESLWdoN/l7Gu3lcc8a1aWsqkmemmVn0T1jnXpSmgRIvS9irZspz7+Ug13WhDbAfY3ZAcFfi1BYm4B+Otgr5nJOOQdGo5UcOqufC6Xf7mDm0ASigYfoDPt3gwEtWmZJ/9pH19DH+33faZNpG5evhShbpzUd9o/VHOSvxV2vpa4vpORMiHE1DdVNVbEeQuKVvyhUYNbI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB8100.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199021)(83380400001)(66476007)(64756008)(66446008)(91956017)(76116006)(6916009)(6512007)(966005)(71200400001)(6506007)(26005)(6486002)(8936002)(54906003)(86362001)(2616005)(186003)(478600001)(2906002)(8676002)(66556008)(66946007)(5660300002)(85182001)(4326008)(38070700005)(36756003)(38100700002)(122000001)(41300700001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnpxSEp0RVYyNGFsMHJGWXNURlJSWVJkcDJRdW82ODUyenpwNzREdVVtWUxi?=
 =?utf-8?B?NWxONXFsSFNqWENnMjJsc1B4cHJaZHgvY01hZDh4KzR2RDZxRSs1cHNSaFpn?=
 =?utf-8?B?RVA1RXBGSGdwcmR3RzhGT2pKS1dBdUxnNTkvQW9PM2tPdk5EaG4xbDdJRUto?=
 =?utf-8?B?ZXNzeENOUy9xNDlSMWtKMU5vcTd6RmtrMDlrbXNLR01ic3pMd2NsdEgwN1h1?=
 =?utf-8?B?RkFyWTFzQityZEF3M0tZTnBweW4yMDN0ZDhnRnp5RHBMUEROYXVWZ0U5QmEy?=
 =?utf-8?B?YjVqK2JxajA4cTViOGFFT0JKSWpvOEJpcVE2Nkhma0RkWThpVGFZOUcxemcv?=
 =?utf-8?B?STlEdEZidFM0bERrMzVSdEV2dmkxbXVNaXYxU2piNThTR0Z5RlRnemtjWFRy?=
 =?utf-8?B?YVhNaU4rSUs3cUdQVGpxZ08xajRRMm1PUFRqK2ZFWnZPZERTdUJDNEJmQ2U3?=
 =?utf-8?B?amZudTVEdXVRQTQ1S0dIdGFNU3NjaVZkdHl6Ri9JTDQrMnJkZ3NtUTZ2L21t?=
 =?utf-8?B?V0JNOWE4cXF1eGVaelZtTUg3dEZkMHd2eG5rRTJtb202Q3puWXp1QXRRb1kr?=
 =?utf-8?B?VysrSXlaM1RxWldwU0k2S1lwM1U4RzVneFIyT0J4WXVtcEJMSVNKRUdlenlQ?=
 =?utf-8?B?NStBWEN6MlNmQlBLeXlsN3pEQ3o5aTE3bWw4Z3RDR1MzeGtabWtyNkVnbDZ4?=
 =?utf-8?B?M0VpejdzZ2pxd3hUTVRFcHNjcGZCWDZPKzB2cHNPaWlITDVSSFNWb2ZKYVZY?=
 =?utf-8?B?THY3a2NoakV5ajBDUnhmMUExb0VVRWpxaFl6dXB6U1hRelI3aHZLK25rZUxo?=
 =?utf-8?B?bUE0RjU1QWI2VUFaSTQxUXhOZ3RTd3pqT0JSenFRNkFrbDF1dFlMRU5abk5K?=
 =?utf-8?B?eEU1Z2F0cDYvRmlqVDVwWjdSR1JTU0pjY1FiUVN1VjdCK1MyendtTVF6VkRv?=
 =?utf-8?B?SGVQZTBOK2lJVUtvTDF1TWxOUitWVFNqdXBqbVFVbkxIaGJSRWd3dFFvWUcr?=
 =?utf-8?B?UVhaVWtSakt2YkZXSDUra3ZhZjhYckU2YkZaSFVGcVdqWW43WlpQZ2gxb0tH?=
 =?utf-8?B?MjU4TS93SCtUUGE5T0hUTGtBZzBhMHJwemFFY0NIWnd3dS80eHFuS2d3NUtI?=
 =?utf-8?B?V1VCNHk3V1I0bUtTRTVGSTZOY1pzc2xYeVRBMEFheFVSWndkcXFtZ21PV0Yv?=
 =?utf-8?B?OXRoNmZmU00xZWloNGNhd25ndExOVWs5VzluV1htL3NxZUtVSXM3U1YzL01V?=
 =?utf-8?B?MHByR0tuSTNRU0NNMmxGQ2o2VlZHcEg2N1p4Z2pRbC9tZGh0UEpOS21oNUVu?=
 =?utf-8?B?bUkzRlV3WEN3M3U5TXpsUHRVUEVzMXpEUlV0TFVGempaeTNjN3B0ZldKd3FS?=
 =?utf-8?B?NkhGOG1WOU9ZanBKTCtWbUs4TVlEQ2pZdzF4Z2ZvaFVnUVpDVUtmOFFHMTY4?=
 =?utf-8?B?L2VHOUVoSmFhRWtYeFBHM2M2TUVodGoweVZnL1BYdngrZTRsN1BwYnRyb2ZX?=
 =?utf-8?B?S2lzK09aN0RSUk5IRmJWZjJkNmNEY3ZqVjY0aUpaNXM0K1orazZjOXdPMnVt?=
 =?utf-8?B?YTFSenZaWnlmK2paSUlFVWlwVTRaRXpadHdiRDliaW1EVHJTUlZxTG4xR0o2?=
 =?utf-8?B?d2tDN0l6UVcyMnBCWG9HM3I2WitSbDNMMGNMNHoxVFdwUzJ6MUxiczU1M1J2?=
 =?utf-8?B?SjFjME93emh2MkFFNVg3REYwWm1HbVJiZFd2TXVSaXpJbjE4UEN1NTJ2YXls?=
 =?utf-8?B?eVIwZU5NSVQ2aU5pcU9LckQ2NFFvSFJEeG0relh1QkFoZU5ka3RnY29JdlJ5?=
 =?utf-8?B?U01ySy9aa0VNZnNWS1VRcVVPVEdEcTZqK0dTMWx4ZHN4bXBEdzROMEZLamk0?=
 =?utf-8?B?UEFKRU9mL3B6VlRnbURjbHRuOFBWQWMvanJVK3lDNzR5bytSc2NUZjdQeVZ2?=
 =?utf-8?B?KzhBek5WREdoMjB2TlhHWmplNFZwY2YxaXFSLzVCcGxrOTdtMHM4WUxGZG9L?=
 =?utf-8?B?RlNWR2JndjFjQlhGS3VUWk0rYjg5T1EzMVRNRTdyTHpxSitYeHNzaEhmU1ow?=
 =?utf-8?B?SUZHWVdHeHdSSVRZR3Fvc3ZuWGpoSFBQZXcxcjBFT0xjZjZ2TGV1dnZUUWhX?=
 =?utf-8?B?VFZPcEg1c0tyaEVPaHZmOVJnU24vZUlKNFJSMDFkbkhvcWpIaGR2bkpPM3dj?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A59B22EEDFC9F4389A4B17333D70812@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB8100.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab81ff9-3683-47b4-4365-08db6cbe0a4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 09:59:27.5015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w1v0iaN01DmGtx8DDjSzGD8iuDDe0iZgsT9X80ohyExC1bYWy32R4j7Zctq4F5fr8tzsKwKWYOABRnqA2w4BhhcyHZ+lh8+81I90xYnHgdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6444
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTE0IGF0IDA4OjE2ICswMTAwLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2Vu
ZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gV2VkLCBKdW4gMTQsIDIwMjMgYXQgMTE6MjA6MzRB
TSArMDgwMCwgV2VpIENoaW4gVHNhaSB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
a2VybmVsL3Byb2Nlc3MuYyBiL2FyY2gvYXJtL2tlcm5lbC9wcm9jZXNzLmMNCj4gPiBpbmRleCAw
ZThmZjg1ODkwYWQuLmRmOTE0MTJhMTA2OSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9rZXJu
ZWwvcHJvY2Vzcy5jDQo+ID4gKysrIGIvYXJjaC9hcm0va2VybmVsL3Byb2Nlc3MuYw0KPiA+IEBA
IC0zNDMsNiArMzQzLDcgQEAgY29uc3QgY2hhciAqYXJjaF92bWFfbmFtZShzdHJ1Y3Qgdm1fYXJl
YV9zdHJ1Y3QNCj4gKnZtYSkNCj4gPiAgew0KPiA+ICByZXR1cm4gaXNfZ2F0ZV92bWEodm1hKSA/
ICJbdmVjdG9yc10iIDogTlVMTDsNCj4gPiAgfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChhcmNo
X3ZtYV9uYW1lKTsNCj4gLi4uDQo+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9zaWduYWwuYyBiL2tl
cm5lbC9zaWduYWwuYw0KPiA+IGluZGV4IGI1MzcwZmU1YzE5OC4uYTFhYmU3N2ZjZGMzIDEwMDY0
NA0KPiA+IC0tLSBhL2tlcm5lbC9zaWduYWwuYw0KPiA+ICsrKyBiL2tlcm5lbC9zaWduYWwuYw0K
PiA+IEBAIC00NzAwLDYgKzQ3MDAsNyBAQCBfX3dlYWsgY29uc3QgY2hhciAqYXJjaF92bWFfbmFt
ZShzdHJ1Y3QNCj4gdm1fYXJlYV9zdHJ1Y3QgKnZtYSkNCj4gPiAgew0KPiA+ICByZXR1cm4gTlVM
TDsNCj4gPiAgfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChhcmNoX3ZtYV9uYW1lKTsNCj4gDQo+
IEhhdmUgeW91IGNvbmZpcm1lZDoNCj4gMSkgd2hldGhlciB0aGlzIGFjdHVhbGx5IGJ1aWxkcw0K
PiAyKSB3aGV0aGVyIHRoaXMgcmVzdWx0cyBpbiBvbmUgb3IgdHdvIGFyY2hfdm1hX25hbWUgZXhw
b3J0cw0KPiANCj4gPw0KPiANCj4gLS0gDQo+IFJNSydzIFBhdGNoIHN5c3RlbTogaHR0cHM6Ly93
d3cuYXJtbGludXgub3JnLnVrL2RldmVsb3Blci9wYXRjaGVzLw0KPiBGVFRQIGlzIGhlcmUhIDgw
TWJwcyBkb3duIDEwTWJwcyB1cC4gRGVjZW50IGNvbm5lY3Rpdml0eSBhdCBsYXN0IQ0KDQpIaSBS
dXNzZWxsLA0KDQpXZSBkaWQgY29uZmlybSB0aGF0IGl0IGNhbiBiZSBidWlsdCBzdWNjZXNzZnVs
bHkgaW4ga2VybmVsIDYuMSBhbmQgcnVuDQp3ZWxsIGluIG91ciBzeXN0ZW0uDQoNCkFjdHVhbGx5
LCB3ZSBvbmx5IHVzZSB0aGlzIGV4cG9ydCBzeW1ib2wgImFyY2hfdm1hX25hbWUiDQpmcm9tIGtl
cm5lbC9zaWduYWwuYyBpbiBhcm02NC4gV2UgYWxzbyBleHBvcnQgc3ltYm9sIGZvciBhcmNoX3Zt
YV9uYW1lDQppbiBhcmNoL2FybS9rZXJuZWwvcHJvY2Vzcy5jIGJlY2F1c2UgdGhhdCwgb25lIGRh
eSBpbiB0aGUgZnV0dXJlLCAgd2UNCmFyZSBhZnJhaWQgdGhhdCB3ZSBhbHNvIG5lZWQgdGhpcyBm
dW5jdGlvbiBpbiBhcm0gcGxhdGZvcm0uDQoNClRoYW5rcy4NCg0KUmVnYXJkcywNCg0KSmltDQoN
Cg==
