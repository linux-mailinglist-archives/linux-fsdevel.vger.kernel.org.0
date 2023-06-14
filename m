Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D9F73043C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 17:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244951AbjFNPyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 11:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244919AbjFNPyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:54:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3135A1;
        Wed, 14 Jun 2023 08:54:01 -0700 (PDT)
X-UUID: abdeba720acb11ee9cb5633481061a41-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0qVyox1+oOHTRxjz7CNgXPcEzoaJo2Rd3Olgj4EWn00=;
        b=owFvTQ6BdUcv4SfsbCvIVlRSBAi7MQm/iEWlkl56vlgrUVKv9aLaMZgaYCrLH+Oe3u8/vCH0U3g4mMINfMZyQJRuhQhYNQrSDHpfTNTSgEPznm+v7qb9WmE6J5iR8450N32//uIfilqi7PaYE15wa+KK5LRlkCuOrK4pxm9HnFI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:1c19933b-d6ce-49f9-a7e9-724454f78bdc,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Release_Ham,ACTI
        ON:release,TS:98
X-CID-INFO: VERSION:1.1.26,REQID:1c19933b-d6ce-49f9-a7e9-724454f78bdc,IP:0,URL
        :25,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:98
X-CID-META: VersionHash:cb9a4e1,CLOUDID:5026126f-2f20-4998-991c-3b78627e4938,B
        ulkID:2306141516538Z199Q9E,BulkQuantity:38,Recheck:0,SF:29|28|17|19|48|38,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40|20,QS:nil,BEC:nil
        ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,TF_CID_SPAM_FCD,TF_CID_SPAM_ULN,
        TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS
X-UUID: abdeba720acb11ee9cb5633481061a41-20230614
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <wei-chin.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1173652626; Wed, 14 Jun 2023 23:53:57 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 23:53:56 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Jun 2023 23:53:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7TLUuqksBSXy4Voq35i8IphTH9tXRVhF4Q9m+VFeZwkciPr91JP8g20JwzeJsuNqwia7CaCyzK+x4uJ+XZAkrwrz1jr4AaH+EjXJDJIcQ74VH+gWQJGxOFOccSH/usbZ8UI0djbrumvUOexQQO1sd+WOtdTUGrDajdOoeEWPeJu+cBOMQxK7gtd6H8GoszFaK5twYCuOKm/kS83Tfjl9BE2xs9EKy+Ek51mkbVLl6iu15dww5aLYcxc3EkmNLYMsZIn0ov0+00E+acHUJWs9YFVMCM6irv8HqC6HHBqNdQnB8n4yY88WHokZehd68gK39rqL+Ko7hO9nqoko59tqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qVyox1+oOHTRxjz7CNgXPcEzoaJo2Rd3Olgj4EWn00=;
 b=oKV5C1/L9vKduwOdmcyDgnrq6+YnGK3l8sRu+bxX2jpNh9/YbgVKIC0bL+dXnUx5BoMvf4tJCfAozZpygpT2qPac4GV6lUi0WnmwOmdWyV1x57m1ELbsgQaV4D/W9ld+bRH63RWsBq4dS95P7NXX4nbXNlvsaUUMwPtGW9UMRdEGoytOc7EB1KsSpXGywAlIai3W0GpJvcl4Q5rzFe8bWGShUjvDq8eulM8JHo7INRTgdz5U5S3Gd3FAyVwVUiF1PWoc/cKbtl1NbotNh/+G+4JoNwB1kP+NNEWJSaEzHsJphiNR60NTlKdVralTz/LOO+i9SHv357Nf0ShxJ3RGyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qVyox1+oOHTRxjz7CNgXPcEzoaJo2Rd3Olgj4EWn00=;
 b=QoXWdnhr87PXb/aB+5NzzYb2YnHSD6VUNftyFXR3PuzMTdrqE5Pi5CNc8C735XWeiNSigWz2AfHiRbRIVTf/O7vgC1x60tsvoqeu3Rav/tfk3WW6i6eawXZRedQovKdlEbLNqlbr0PGNTQsUPhkxlYx/mUFIBJhgLRGwGFdDCRk=
Received: from JH0PR03MB8100.apcprd03.prod.outlook.com (2603:1096:990:37::13)
 by KL1PR03MB6350.apcprd03.prod.outlook.com (2603:1096:820:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 15:53:54 +0000
Received: from JH0PR03MB8100.apcprd03.prod.outlook.com
 ([fe80::56de:54d6:38f2:afcd]) by JH0PR03MB8100.apcprd03.prod.outlook.com
 ([fe80::56de:54d6:38f2:afcd%6]) with mapi id 15.20.6455.037; Wed, 14 Jun 2023
 15:53:54 +0000
From:   =?utf-8?B?V2VpLWNoaW4gVHNhaSAo6JSh57at5pmJKQ==?= 
        <Wei-chin.Tsai@mediatek.com>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
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
        <ivan.tseng@mediatek.com>
Subject: Re: [PATCH v2 2/3] memory: export symbols for memory related
 functions
Thread-Topic: [PATCH v2 2/3] memory: export symbols for memory related
 functions
Thread-Index: AQHZnm86bp64uNQQXU2F/FXPNJ366q+J43aAgAAteQCAACTggIAAPicA
Date:   Wed, 14 Jun 2023 15:53:54 +0000
Message-ID: <a5af0ec711b3704f4f2d8ed60f2f2987e3cf44ec.camel@mediatek.com>
References: <20230614032038.11699-1-Wei-chin.Tsai@mediatek.com>
         <20230614032038.11699-3-Wei-chin.Tsai@mediatek.com>
         <ZIlpWR6/uWwQUc6J@shell.armlinux.org.uk>
         <fef0006ced8d5e133a3bfbf4dc4353a86578b9cd.camel@mediatek.com>
         <cb7f49bc-8ed4-a916-44f4-39e360afce41@collabora.com>
In-Reply-To: <cb7f49bc-8ed4-a916-44f4-39e360afce41@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB8100:EE_|KL1PR03MB6350:EE_
x-ms-office365-filtering-correlation-id: 44f492f3-4ef1-423f-78b1-08db6cef8e33
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mbTcptU/wu9mLer78kRzszUkry61SeI2om5Jwj7Xa9Zwce0o9iphQswgqrbKSu2UTdcUFsIPWATKzioYTjT5sOPtLjLw7EXwmN4WzcgaLXcLRkRjgoLj/E1XuVp2rT0Om0cNZBsUWp8c58VH7CBc0yJUPiP054lP8mx2HpQZEQElYB1jnN3ESk6iudLZ2FI9Wat6o0R3q8itIcTxgbKuiUG7F4FW3+QIfR8PiRq7nrLphMsNlMwgj9xvUchUdr0F/QcdiNyprxmLpsyz0P2xgoO3C/rkHtMeoMxbCr+GbcMnp4nrd3e0EGqNwUr9c02MSofX3GdBva+kwJsWMei05VDQjQuSSOxrytL0ywmtBNTPoIl5g45lueiRhLmOUBBX/gpUrykTdz92AfYV68OtQ1auCQ7QZe9TIEq6iXDbbPAuMhRjrsUMnAoTdfmiiAxmf9Rc6QEmEZIH29RQ1W6mVjoCcZMmhs9jzrhN4xdYrLI5U/nouudIEayn4Fu9ItMgRRurD/2cllhU1YVnCYUtSauvgM66iYFTRMtoDhszli6g6TM9JX/iiD92xsXVzGjcnCIsUmUcTm1UGMmjC5sgMp2LwfB5yZ0dNes8BnTlfGy9YnsOI0uGmdXiukgV/DS78dqleFmEaj38+mXUrNUYsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB8100.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199021)(122000001)(38100700002)(38070700005)(71200400001)(478600001)(110136005)(54906003)(6486002)(966005)(316002)(41300700001)(5660300002)(8676002)(8936002)(64756008)(66476007)(66446008)(76116006)(91956017)(66946007)(4326008)(2906002)(66556008)(83380400001)(6512007)(26005)(186003)(107886003)(6506007)(53546011)(2616005)(36756003)(86362001)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm5oQ3BBRDRJS2RPQzc4S0dxNzVLRHRqcEc0dkdpeUgzam9XeTNUNEcxUS9U?=
 =?utf-8?B?dnpTMXd5VWJ0cDFseVFTZnVQbFYxOTlnYUVjSnBhN2YvdzRFR0ZkNWxGSFpl?=
 =?utf-8?B?T2ZDbDVwbWtpMHd6VnRzTXNvTE5BUnlpMW9qSHkrSm5SdnpHWGJVSTR5Skd6?=
 =?utf-8?B?UFpacXAzUy9nak1tdmR0Uk5PUkptaTdCakRwVVA3dmMzcUp3VFQyOWNJZHBa?=
 =?utf-8?B?ejZrTzJpMW1RakRwS3ZEMGs0N29WNlVOSGZMS0h2OTlpTk9qUFIzWGtLY3RG?=
 =?utf-8?B?ZGxnL1UzWXJmSkpEdnMvWWtXYTNLQm5UZVkwcktzQnd4UW5mS3MrS0R2RDVL?=
 =?utf-8?B?c3FhWnNLNFlOT2Z1VFpKOVpqMmtLTytvYnc2MDZwQTVqVUxIR3U3ZGJlZXJW?=
 =?utf-8?B?OGZyamNZVG1UdzkzS1MvSkVTbzRHcGdSS0lCSm4yQjNwc3hSMU9MbEEyMjlp?=
 =?utf-8?B?MCt0MGJlV1VpQ3Fwak14N2ZnUnpmSlN5cDU5MGl1TTJBYVY2U05MWVl6UFF3?=
 =?utf-8?B?Z2MrWVJIRi9IdGdZbnZqRG95Rm1rZTF6R3dNQ2tONHl4SFZVMXJVMjRRQVJq?=
 =?utf-8?B?UnNsTDgyR01LaHBDVXV0bFZ5ODV6emVhMmJOajdoeGR6MHR1ekwwN2t6ZHky?=
 =?utf-8?B?Nkl2TG5KYW9KMTB5T3dFT09GVXoveXRJQ1lHWWtzRzd6MkdtblgzVkViQUlT?=
 =?utf-8?B?Mm10ZjVzZ3g1cEhrUW9IV0s5SFpqMEF0SkhMU3hJS0dTeGlPakhoNm5mV1R4?=
 =?utf-8?B?TzloQ1A4TEZ1RHY1TEkwYnQxV1FUNjh1djFncDVZR0ltQlhINnRBcVJJUVZi?=
 =?utf-8?B?MG55YXY5TkVZdmdkT0NZWFBOTFI2K1g5cTRJL3pFbGFtZXcwdUs0bDdiNDRa?=
 =?utf-8?B?UWRVNVk1cHhiWG5JdlE5RmptMXlvQTdHTzVIUitvdDM5cUUrdnBVSWNwQ3Rw?=
 =?utf-8?B?ZUNSYTQrMjNTMWRNYkluZGRTdkFkRjRoSzVveEx5WUFMR0JoWEQ2WXdBR0RT?=
 =?utf-8?B?dmVPbFp4dnlBVGgxUmFEaE1OY0tWQmtiZ2NOek9LSWlvQldra1BNbmV4WXhU?=
 =?utf-8?B?cGZDdGxLM0U4MnNRNVp0VU9NRStjRXRGU0lzYXdxeEViQjZDd1oxT2FaWU01?=
 =?utf-8?B?TWtKZS91Q0c4U0FCRXpBUXBnNEVUZ1BWKzNpWmNPQ0w4MUVYejNnZGZSTnBT?=
 =?utf-8?B?NjdtVHB3S3RPMFdJdmdlajJnSDIycllhc21KS1BOQUZqTEtaSS9RTVhseGNG?=
 =?utf-8?B?eFlENkgvMTFVSVVYeU8wbnVKdjhZUnMwOGpxK05NZ1BTOERHRGNUSjc1WnJt?=
 =?utf-8?B?TDFmdUtMUXk1ZXhZNXd5KzIrdDJPZU5URUNFNGNwUXlSMGJIZ0xydXAzcjVq?=
 =?utf-8?B?THROVGtaKys3TGJ6dTNDd2JveEYwbm01NEkxbW1jdmZHL0Y5Nks2clVTcGNG?=
 =?utf-8?B?c0NnY0JucXN0ak1uU1FBc25sQkQzR3lwem9EUXhxZlVTS1htWXJDZE1wV2Rn?=
 =?utf-8?B?aXBMa2pobEFRTEVUVThhRVdlZzZxa1dNczF3MFhCQVUyZzFMN0hzMHFLODBD?=
 =?utf-8?B?L294RXBORnlXeWgzSDZGMnAwM0RtVkhwL2xMcytPMGRaVjBoNXoyWHBzdEhr?=
 =?utf-8?B?aTIraUdMeW1QbVE5d2FQVW81SWowM3pjN2k2M2xaSzNOK0Q3SkFQZ3ZrdEFi?=
 =?utf-8?B?QU5yWG9tZk1rQWdwbFJyb3VnVi83eC8zMWRQZm9TZFZTUjJLNnlsYWVkY0FV?=
 =?utf-8?B?dTlzL1FLeTJ6TUFRTno3RWM3MEVpbFg2UDMzSE9qTzE5YkVVOTZzY2lVNk5Y?=
 =?utf-8?B?MFhVbVd5L014T0I4TmlEQUt0aTdPd1NRSElncnk0d0tvWXkvYU5BMytZclJj?=
 =?utf-8?B?c3g3OFZpMmNxNXJIN2dqUDgrNGxuUlVGc2pINnhqMXlWZnBrL0dyUDkyYWZz?=
 =?utf-8?B?VEtXa1ZSNDFjaVNEZVRVdkxOOFRNcWJSOXhWOU54OUdvZG5ZM3E2S2xiaktv?=
 =?utf-8?B?YzliYVRKUXVPTEpFSFVOYk5vWGpNUjdWdWUvL0hpdkhWV2xoeWNpWWtkd1hO?=
 =?utf-8?B?Tm51L3pwSVNpQTY4bnRSWFQzbG5sQ0ZmVG90NmxYK0wvdndIUEhZbDRiM0dE?=
 =?utf-8?B?L0txbTdRc296cCtKMU82N1ZnUm9TWkh0bFd6TFptK3RvSnI1Z3B6cTFGQlgz?=
 =?utf-8?Q?eJgbeoCqHXebTjmQ0XdX9VA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAA33DAC15B16C4593D300BECFFF2522@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB8100.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f492f3-4ef1-423f-78b1-08db6cef8e33
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 15:53:54.1708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JhW9i1fn8FfjX/FwrJ88VrYaUsMUFmrPzCI2MI15JvsaPjHlQ4NKw4KeN7dNQsNzm8G8TREWrvv5KMeFPWuvua+KhGTcKVaF7H0v/mJIfvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6350
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTE0IGF0IDE0OjExICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBJbCAxNC8wNi8yMyAxMTo1OSwgV2VpLWNoaW4g
VHNhaSAo6JSh57at5pmJKSBoYSBzY3JpdHRvOg0KPiA+IE9uIFdlZCwgMjAyMy0wNi0xNCBhdCAw
ODoxNiArMDEwMCwgUnVzc2VsbCBLaW5nIChPcmFjbGUpIHdyb3RlOg0KPiA+PiAgIA0KPiA+PiBF
eHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cw0KPiB1bnRpbA0KPiA+PiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiA+PiAgIE9uIFdlZCwgSnVuIDE0LCAyMDIzIGF0IDExOjIwOjM0QU0gKzA4MDAs
IFdlaSBDaGluIFRzYWkgd3JvdGU6DQo+ID4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0va2VybmVs
L3Byb2Nlc3MuYw0KPiBiL2FyY2gvYXJtL2tlcm5lbC9wcm9jZXNzLmMNCj4gPj4+IGluZGV4IDBl
OGZmODU4OTBhZC4uZGY5MTQxMmExMDY5IDEwMDY0NA0KPiA+Pj4gLS0tIGEvYXJjaC9hcm0va2Vy
bmVsL3Byb2Nlc3MuYw0KPiA+Pj4gKysrIGIvYXJjaC9hcm0va2VybmVsL3Byb2Nlc3MuYw0KPiA+
Pj4gQEAgLTM0Myw2ICszNDMsNyBAQCBjb25zdCBjaGFyICphcmNoX3ZtYV9uYW1lKHN0cnVjdA0K
PiB2bV9hcmVhX3N0cnVjdA0KPiA+PiAqdm1hKQ0KPiA+Pj4gICB7DQo+ID4+PiAgIHJldHVybiBp
c19nYXRlX3ZtYSh2bWEpID8gIlt2ZWN0b3JzXSIgOiBOVUxMOw0KPiA+Pj4gICB9DQo+ID4+PiAr
RVhQT1JUX1NZTUJPTF9HUEwoYXJjaF92bWFfbmFtZSk7DQo+ID4+IC4uLg0KPiA+Pj4gZGlmZiAt
LWdpdCBhL2tlcm5lbC9zaWduYWwuYyBiL2tlcm5lbC9zaWduYWwuYw0KPiA+Pj4gaW5kZXggYjUz
NzBmZTVjMTk4Li5hMWFiZTc3ZmNkYzMgMTAwNjQ0DQo+ID4+PiAtLS0gYS9rZXJuZWwvc2lnbmFs
LmMNCj4gPj4+ICsrKyBiL2tlcm5lbC9zaWduYWwuYw0KPiA+Pj4gQEAgLTQ3MDAsNiArNDcwMCw3
IEBAIF9fd2VhayBjb25zdCBjaGFyICphcmNoX3ZtYV9uYW1lKHN0cnVjdA0KPiA+PiB2bV9hcmVh
X3N0cnVjdCAqdm1hKQ0KPiA+Pj4gICB7DQo+ID4+PiAgIHJldHVybiBOVUxMOw0KPiA+Pj4gICB9
DQo+ID4+PiArRVhQT1JUX1NZTUJPTF9HUEwoYXJjaF92bWFfbmFtZSk7DQo+ID4+DQo+ID4+IEhh
dmUgeW91IGNvbmZpcm1lZDoNCj4gPj4gMSkgd2hldGhlciB0aGlzIGFjdHVhbGx5IGJ1aWxkcw0K
PiA+PiAyKSB3aGV0aGVyIHRoaXMgcmVzdWx0cyBpbiBvbmUgb3IgdHdvIGFyY2hfdm1hX25hbWUg
ZXhwb3J0cw0KPiA+Pg0KPiA+PiA/DQo+ID4+DQo+ID4+IC0tIA0KPiA+PiBSTUsncyBQYXRjaCBz
eXN0ZW06IGh0dHBzOi8vd3d3LmFybWxpbnV4Lm9yZy51ay9kZXZlbG9wZXIvcGF0Y2hlcy8NCj4g
Pj4gRlRUUCBpcyBoZXJlISA4ME1icHMgZG93biAxME1icHMgdXAuIERlY2VudCBjb25uZWN0aXZp
dHkgYXQgbGFzdCENCj4gPiANCj4gPiBIaSBSdXNzZWxsLA0KPiA+IA0KPiA+IFdlIGRpZCBjb25m
aXJtIHRoYXQgaXQgY2FuIGJlIGJ1aWx0IHN1Y2Nlc3NmdWxseSBpbiBrZXJuZWwgNi4xIGFuZA0K
PiBydW4NCj4gPiB3ZWxsIGluIG91ciBzeXN0ZW0uDQo+ID4gDQo+IA0KPiBJdCBydW5zIHdlbGwg
aW4geW91ciBzeXN0ZW0gYW5kIGNhbiBiZSBidWlsdCBzdWNjZXNzZnVsbHkgYmVjYXVzZQ0KPiB5
b3UncmUgYnVpbGRpbmcNCj4gZm9yIEFSTTY0LCBub3QgZm9yIEFSTS4uLg0KPiANCj4gPiBBY3R1
YWxseSwgd2Ugb25seSB1c2UgdGhpcyBleHBvcnQgc3ltYm9sICJhcmNoX3ZtYV9uYW1lIg0KPiA+
IGZyb20ga2VybmVsL3NpZ25hbC5jIGluIGFybTY0LiBXZSBhbHNvIGV4cG9ydCBzeW1ib2wgZm9y
DQo+IGFyY2hfdm1hX25hbWUNCj4gPiBpbiBhcmNoL2FybS9rZXJuZWwvcHJvY2Vzcy5jIGJlY2F1
c2UgdGhhdCwgb25lIGRheSBpbiB0aGUNCj4gZnV0dXJlLCAgd2UNCj4gPiBhcmUgYWZyYWlkIHRo
YXQgd2UgYWxzbyBuZWVkIHRoaXMgZnVuY3Rpb24gaW4gYXJtIHBsYXRmb3JtLg0KPiA+IA0KPiA+
IFRoYW5rcy4NCj4gPiANCj4gPiBSZWdhcmRzLA0KPiA+IA0KPiA+IEppbQ0KPiA+IA0KPiANCg0K
SGkgUnVzc2VsbCBhbmQgQW5nZWxvLA0KDQpQbGVhc2UgdXNlIHRoZSBmb2xsb3dpbmcgcGF0Y2gg
dG8gc2VlIGlmIHRoZSBwcm9ibGVtIHN0aWxsIGV4aXN0cy4NClRoYW5rcy4NCg0KRnJvbSAxNTAx
NjJjZTIzNjU1NTc3MTBlOWFjOGVmNjJjNTlmODcwZmZiYmIwIE1vbiBTZXAgMTcgMDA6MDA6MDAg
MjAwMQ0KRnJvbTogV2VpIENoaW4gVHNhaSA8V2VpLWNoaW4uVHNhaUBtZWRpYXRlay5jb20+DQpE
YXRlOiBXZWQsIDE0IEp1biAyMDIzIDIzOjMxOjAyICswODAwDQpTdWJqZWN0OiBbUEFUQ0ggdjMg
MS8xXSBtZW1vcnk6IEZpeCBleHBvcnQgc3ltYm9sIHR3aWNlIGNvbXBpbGVyIGVycm9yDQpmb3IN
CiAiZXhwb3J0IHN5bWJvbHMgZm9yIG1lbW9yeSByZWxhdGVkIGZ1bmN0aW9ucyIgcGF0Y2gNCg0K
VXNlciBjb3VsZCBub3QgYWRkIHRoZSBleHBvcnQgc3ltYm9sICJhcmNoX3ZtYV9uYW1lIg0KaW4g
YXJjaC9hcm0va2VybmVsL3Byb2Nlc3MuYyBhbmQga2VybmVsL3NpZ25hbC5jIGJvdGguDQpJdCB3
b3VsZCBjYXVzZSB0aGUgZXhwb3J0IHN5bWJvbCB0d2ljZSBjb21waWxlciBlcnJvcg0KUmVwb3J0
ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KDQpTaWduZWQtb2ZmLWJ5
OiBXZWkgQ2hpbiBUc2FpIDxXZWktY2hpbi5Uc2FpQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGFyY2gv
YXJtL2tlcm5lbC9wcm9jZXNzLmMgfCAzICsrKw0KIGtlcm5lbC9zaWduYWwuYyAgICAgICAgICAg
fCAzICsrKw0KIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQg
YS9hcmNoL2FybS9rZXJuZWwvcHJvY2Vzcy5jIGIvYXJjaC9hcm0va2VybmVsL3Byb2Nlc3MuYw0K
aW5kZXggZGY5MTQxMmExMDY5Li5kNzFhOWJhZmI1ODQgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9r
ZXJuZWwvcHJvY2Vzcy5jDQorKysgYi9hcmNoL2FybS9rZXJuZWwvcHJvY2Vzcy5jDQpAQCAtMzQz
LDcgKzM0MywxMCBAQCBjb25zdCBjaGFyICphcmNoX3ZtYV9uYW1lKHN0cnVjdCB2bV9hcmVhX3N0
cnVjdA0KKnZtYSkNCiB7DQogCXJldHVybiBpc19nYXRlX3ZtYSh2bWEpID8gIlt2ZWN0b3JzXSIg
OiBOVUxMOw0KIH0NCisNCisjaWZkZWYgQ09ORklHX0FSTQ0KIEVYUE9SVF9TWU1CT0xfR1BMKGFy
Y2hfdm1hX25hbWUpOw0KKyNlbmRpZg0KIA0KIC8qIElmIHBvc3NpYmxlLCBwcm92aWRlIGEgcGxh
Y2VtZW50IGhpbnQgYXQgYSByYW5kb20gb2Zmc2V0IGZyb20gdGhlDQogICogc3RhY2sgZm9yIHRo
ZSBzaWdwYWdlIGFuZCB2ZHNvIHBhZ2VzLg0KZGlmZiAtLWdpdCBhL2tlcm5lbC9zaWduYWwuYyBi
L2tlcm5lbC9zaWduYWwuYw0KaW5kZXggYTFhYmU3N2ZjZGMzLi5mN2QwMzQ1MDc4MWUgMTAwNjQ0
DQotLS0gYS9rZXJuZWwvc2lnbmFsLmMNCisrKyBiL2tlcm5lbC9zaWduYWwuYw0KQEAgLTQ3MDAs
NyArNDcwMCwxMCBAQCBfX3dlYWsgY29uc3QgY2hhciAqYXJjaF92bWFfbmFtZShzdHJ1Y3QNCnZt
X2FyZWFfc3RydWN0ICp2bWEpDQogew0KIAlyZXR1cm4gTlVMTDsNCiB9DQorDQorI2lmZGVmIENP
TkZJR19BUk02NA0KIEVYUE9SVF9TWU1CT0xfR1BMKGFyY2hfdm1hX25hbWUpOw0KKyNlbmRpZg0K
IA0KIHN0YXRpYyBpbmxpbmUgdm9pZCBzaWdpbmZvX2J1aWxkdGltZV9jaGVja3Modm9pZCkNCiB7
DQotLSANCjIuMTguMA0KDQpSZWdhcmRzLA0KDQpKaW0NCj4gDQo=
