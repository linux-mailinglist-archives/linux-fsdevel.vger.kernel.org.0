Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2521730D05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 04:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbjFOCIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 22:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbjFOCIq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 22:08:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C17C1BDB;
        Wed, 14 Jun 2023 19:08:40 -0700 (PDT)
X-UUID: 89c760140b2111ee9cb5633481061a41-20230615
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8PiqmrHHgVDspWVw9GdWNpl4/b9dPbxSEm7wpVtkl+M=;
        b=Zl8ao0G+tNnljW1zde5AhFiaz5Zuibl/ncsIn7t/oAKuWtzMt8YCQNaFwtKVzv2e1ENfNHGyHk2U6ut/a8jviLW/gIdwhIGQDIQtnOytzOfgPdLRoY67JUofccGstz+q6vkbZDS1Nfd21iEZeQg8tWId7JW/+7mxSv0GPPuxak4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:b0d44b35-05a3-46f1-9006-3bd104d43070,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Release_Ham,ACTI
        ON:release,TS:98
X-CID-INFO: VERSION:1.1.26,REQID:b0d44b35-05a3-46f1-9006-3bd104d43070,IP:0,URL
        :25,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:98
X-CID-META: VersionHash:cb9a4e1,CLOUDID:9d351c6f-2f20-4998-991c-3b78627e4938,B
        ulkID:2306141516538Z199Q9E,BulkQuantity:58,Recheck:0,SF:48|38|29|28|17|19,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40|20,QS:nil,BEC:nil
        ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,TF_CID_SPAM_FCD,TF_CID_SPAM_ULN,
        TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS
X-UUID: 89c760140b2111ee9cb5633481061a41-20230615
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <wei-chin.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 667266198; Thu, 15 Jun 2023 10:08:36 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 15 Jun 2023 10:08:36 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 15 Jun 2023 10:08:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4Ed6iXmtIKxY4oRJS65xDmJf0pEFyEU7uEhDRh37xKoqPHTGNlRb3lwzbiSRwQNAlMbHcMJhxKDrIVJdoVnAIFiYK40zuyt81O9qGd40P21GNja0jOc9U0QAJOxmDF9LB4wlV5iLb3Jx3KcTkAGJLMzYTR/PrsLh59/MESBPQHG+WBwIgLvR7HTFvNFLt5Pwpi9l6PAoEO9Ycxch4Bri3HH4Pi6Ftjp6qIigtgXQtYYejd7dL5flzw+PRcn+xAse//L/ojmM/BjkBEIye59vBobVCUb8hKeKdhgUFiNLSc+Xw5mVOLlHtQeTyhTsxUh+UqyntA+K1C4uvxTOMP4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PiqmrHHgVDspWVw9GdWNpl4/b9dPbxSEm7wpVtkl+M=;
 b=C6CLovWVf9Dh7+9JQPOTsw8X420CGsr2+W2aiR8kUD0hSJewZuYfpNMnhAbCsA3CfaofV3unw5k8OsZaCOGjhIIGfyedVsVLrtXY0rGZNp+TzUh2Y7qHnN5e1EG0h0V5tz84V2y9RTXVUnSyA4tyneTVI+TOy2exRCMNdzJZurYkqEezGQdqeeDEEJh8sKabLn3MM0kjiQBfXy04U68CXI8MVS4RZGgTBsklwoxiAeUOWoU+R2Zqtj7O7Xm0i0rxLSTQphT+48Yu7rqIs40OdRehfnnnzGJnsiQfTa3UKg2A/1FsmZLjCqAY/d6AoK4Dxc7AJ6jLiwNUc8T3Kq1TTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PiqmrHHgVDspWVw9GdWNpl4/b9dPbxSEm7wpVtkl+M=;
 b=RpCLO8Q97aXsyA7rFYof6V6lKFubzreWGH2kMXRm1EKLi8TcYEFGyk6XU4k3/JJTK6lV+7uqVp+FllaUhXtPK/I/wHf66VJczD0hYbqLpl9+Yketpc/8FmhUe+GVuUzOsX4+QE0YjczNvnFVlJBVjuPoEHTnH5vAqPBjJXB1U5U=
Received: from JH0PR03MB8100.apcprd03.prod.outlook.com (2603:1096:990:37::13)
 by KL1PR03MB7037.apcprd03.prod.outlook.com (2603:1096:820:da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 02:08:33 +0000
Received: from JH0PR03MB8100.apcprd03.prod.outlook.com
 ([fe80::56de:54d6:38f2:afcd]) by JH0PR03MB8100.apcprd03.prod.outlook.com
 ([fe80::56de:54d6:38f2:afcd%6]) with mapi id 15.20.6455.037; Thu, 15 Jun 2023
 02:08:32 +0000
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
Thread-Index: AQHZnm86bp64uNQQXU2F/FXPNJ366q+J43aAgAAteQCAACTggIAARe+AgACj84A=
Date:   Thu, 15 Jun 2023 02:08:32 +0000
Message-ID: <9cb31614569fb1e121102b6bef7de8870224283c.camel@mediatek.com>
References: <20230614032038.11699-1-Wei-chin.Tsai@mediatek.com>
         <20230614032038.11699-3-Wei-chin.Tsai@mediatek.com>
         <ZIlpWR6/uWwQUc6J@shell.armlinux.org.uk>
         <fef0006ced8d5e133a3bfbf4dc4353a86578b9cd.camel@mediatek.com>
         <cb7f49bc-8ed4-a916-44f4-39e360afce41@collabora.com>
         <ZInpF3aKMLFVQ3Vf@shell.armlinux.org.uk>
In-Reply-To: <ZInpF3aKMLFVQ3Vf@shell.armlinux.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB8100:EE_|KL1PR03MB7037:EE_
x-ms-office365-filtering-correlation-id: 85f95b9d-37f1-42b6-5e28-08db6d456b85
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WgeU93TiY+cr5EVYkijpHmUNU7o/qJRZKvJt4zzr0htXPG7bvMAZBFlbm7/DkqUTcRk+X8UNlwD9Xm7KxuSwofNEbklfBNc2UehxLTNp/HKCF1kQLd4RFhu30pp+40ydZrYwiV19svsj6bDN3AljAdb+ExvtYoM5Stj8yASvKFPuosoUmcC3tSDB4zBX96xK+zHPWzMXNoMs9Es7nHK45dslfx1SnZbU8yuSbkdJ9oXEFdULglpxlX+OoB0p4G+KIpr7TLdwG6WafddIevemtHUY/7CMdoeu2mv93ZrVgAeQi4ljaFHRplgvHheiAUbaavKzk1+tNM+H/SdeGMJIMEiSWCuCgB8CWdUZzEz7XL7j6b7Cfb9lmHxBuglqEn5NtJqvZ6RNjDbK9CHx7jPVVhODcI6o+ozySopGgVoMPhkI8gF5rZBtd6dM5Mm1tJp2+hD3xZdrYfw5hLgYL77WXfsggTTB0ZaXXLwsxK+djwLV+XjCPT6XcsWsyTTUltT+krO1OqryFdCBugfdaYM/V1Fcw4YbUDS6PnhEaFJUcEB2JHDLkA68XXPYWnI85t/HxtoTz9Px7uJMX2dZvR8MghU5o0d83YR4iXkay0B8xPrgZs9kyBHvOeJxfXo3GzqXqeOHZVYVNbVgulEt3vW/cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB8100.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199021)(122000001)(38100700002)(38070700005)(71200400001)(478600001)(110136005)(54906003)(966005)(6486002)(316002)(41300700001)(5660300002)(8936002)(8676002)(64756008)(66476007)(66446008)(76116006)(91956017)(66946007)(2906002)(66556008)(4326008)(83380400001)(6512007)(26005)(186003)(107886003)(6506007)(2616005)(36756003)(85182001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3VjMnUxdTRwekRJMjdTeGR6V2hUNDMyblJ1V0MrVEQwQmp3KzRjNDBIT21o?=
 =?utf-8?B?akVGbUdQeTJZbnJuQURadEV1NjBteUhsbWhONDc2YTloNzArOVdLYzUrdk5k?=
 =?utf-8?B?QkxDaks5eWlFNWQ2QVVsV2ZSQmdUMXl4ZHpvOExPMXZyWVlqeG9aQXFZdUt1?=
 =?utf-8?B?QnJEOFk5cmNuMDlScko3Z3NRL3dIb3pYbWRWMmV5RnJELzZMd1FJQVBVb0Nh?=
 =?utf-8?B?SFdwUlI0OEE5UmJLVkNWb1pxMDBBVnNtQkI2a3ZtREluSm93ZXFoSVB1QzNi?=
 =?utf-8?B?S1BVYWZTdE9rSi9xYWNFdXdMU3JuV1ArR3UzeGE5bUxhRWNUNnJmMk5YME5F?=
 =?utf-8?B?bFFSR2FrYlcrdkljREV1azIrWjZsaU9HRGRUbzZDejMwM0dLRFM1QXhzZkw2?=
 =?utf-8?B?TjRLZVFqS25WZkR4OUJOYmNCcWlsL2V3VWtSSHlydXl2dU52VTc1clg1NGtT?=
 =?utf-8?B?bmw3b1hJaUlJYUI3cmdCd05nVTdQeEQvWXltckxDRXhKOVdpaGF3SzlXd1Vn?=
 =?utf-8?B?Z2tQazV2czNHaEtmRllzOFcrTHh6OFM3ZVF3OXgzb1RueEpiM0lFQTZLNjV1?=
 =?utf-8?B?cGJYb1U1cTFHbTFhSUNXN0Y0R1dEKzZwR01Dc1pjRllpSks0ajlEYldZWnp4?=
 =?utf-8?B?RFVVWTkrUGJPVmFSdWZlNEpPVjh1NGtBVlExUjNaNU5jTGNGOWlvS2V2MTlh?=
 =?utf-8?B?UC85NTVRVGRZUTNFU0NwV0dQUFVwVkx3Y2pmdW5OOGsvT3dRMXl4aFlkTFk0?=
 =?utf-8?B?RUtRSGZ3SWNla25NUlkwUHFvbGM3NlVkem1JWVpsMS9GczUvcExMODQ2VG1D?=
 =?utf-8?B?TUJLK0tTVkZiTmdtb1p5NzducmJUUnQ4VkdINDd3dDdPRTllR0JkdFk3QkQw?=
 =?utf-8?B?WDAxWXREVE9NbW1vNTJkakRjcnZRenZFbDFjQzNzdXF2RFE1aDFic3d6WDdS?=
 =?utf-8?B?d0ZvSzlaVmQyOGZrTFh6eE9rVEwxemVXTlZscUo1MmdXTVFIVXhwb3ZFWEdC?=
 =?utf-8?B?c2RBb1UwM0thcDE0Z1I1K1E4eThDS2cyRDVoVkp1ZVdvNnJXUjVxS0ZWb2ta?=
 =?utf-8?B?R2lmWUNHTmNDc1lUU3FQc0h1YUwxVGZORXZsM2V4b3pscUpOamJSbkhiVjFF?=
 =?utf-8?B?eHY0c2lDV3VOQVZ2ZGNvRlVybzg0ZWJWcVllblFJTC91SzFxY05Nanc2SnA5?=
 =?utf-8?B?Y054ckovajUxU0h6TXZzWEpMYWpwUEZJVkkwS3htYTQrQm5pekR1c0o2eGhh?=
 =?utf-8?B?OXNaVVI4NE91V2FLZ3RaNWRyMEJmVWwveXNHUE9mbFZ5SGljdHRhdHhJWXdk?=
 =?utf-8?B?czZ6Wk9iYmpUTXlkZDJIVStQR3BiWDZ6Kzg0L3hBcFpzVzJzWFNUelJiMUE5?=
 =?utf-8?B?M1d6Wlp2SnNvK3QrTnVVTVYrTnpnL2haT1paaytTdG92WmdYSGxDVDhJUFl2?=
 =?utf-8?B?SWpzQUlsVVozNUp4emNkODNIUVRyL3UxdzhqZWVNQzRUaXVlTFRLRFdGTW83?=
 =?utf-8?B?cVpyMnM4R0QwMk1YV2EreHN5dFdLbGwvbkxrcnQwekJVMlJ5RmYrTE9sVElU?=
 =?utf-8?B?M05KVXJxUHdLeXYzNzVROWZ6cXlhRi92UXY1aVNQL3F4dmFZVkwyU0tRaEZj?=
 =?utf-8?B?a3JVTWxhbHRTZlNqMVhiV1BUdTAyeXpzREtRL2xBSnlmTmN6cGxzZFR3T2I1?=
 =?utf-8?B?OG0xY0RvYTEzY2ExZ1hxaDI3Wm5xNFdsQkNad1kweVdQang5RVdIV1RJMnds?=
 =?utf-8?B?OFczaTlIU1FJUWlFUHNhaCtVZjVJbEdlMmhKUjlqb3E0T1FnOWRYODVIZTdL?=
 =?utf-8?B?djRxWEtEZFZzRG9IRFhNcitHOUNvYTErMHIzdHlveHhZV1dNUUY1K0dlNk5q?=
 =?utf-8?B?dEtpRDZ4YmlVU1Y0S25DNVNkQ2JaVEwyVDNnN2xONWZQRzlPMVg1NHM4Slo4?=
 =?utf-8?B?aUt6VzNUV0sya3pJWHluTHJjbnN3aVRVWkhOelVQSHM5cmtBUlp2UXcwSWtN?=
 =?utf-8?B?VTEzWU04NG1GaEVEbFVHdzl1UzdqbVJTQlF3V0F2ZlNBc0doNEdISkdTNTVv?=
 =?utf-8?B?MzNiT3RKdDQwMEEwcjlyOFdVLzVIUG8yb0cwZC80ZTdMQm9nSGlrUUZ5cnR0?=
 =?utf-8?B?SkZZNkMrQUNpdkZpdzhjeStSVG14OTR2V2lGcXlXN0tSMDVnTnJIL29DWHVl?=
 =?utf-8?Q?Y/0mmGIgsShEsiuV7j5Xt+c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0E018AA8780A848A1C5696C90F7A2D8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB8100.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f95b9d-37f1-42b6-5e28-08db6d456b85
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 02:08:32.6912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ICCifSc9GkO5tbWLgPCIevu9jMNFmiFOAla96vOW7mJ+aLzphk3J+2E6IkO6uRECBXcCmnRdUViQX7Tj++zvelCxjG8XXOlMvuU0nMaOZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7037
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTE0IGF0IDE3OjIxICswMTAwLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2Vu
ZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gV2VkLCBKdW4gMTQsIDIwMjMgYXQgMDI6MTE6MjVQ
TSArMDIwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8NCj4gd3JvdGU6DQo+ID4gSWwgMTQv
MDYvMjMgMTE6NTksIFdlaS1jaGluIFRzYWkgKOiUoee2reaZiSkgaGEgc2NyaXR0bzoNCj4gPiA+
IE9uIFdlZCwgMjAyMy0wNi0xNCBhdCAwODoxNiArMDEwMCwgUnVzc2VsbCBLaW5nIChPcmFjbGUp
IHdyb3RlOg0KPiA+ID4gPiAgIA0KPiA+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBu
b3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiB1bnRpbA0KPiA+ID4gPiB5b3Ug
aGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ID4gPiAgIE9uIFdl
ZCwgSnVuIDE0LCAyMDIzIGF0IDExOjIwOjM0QU0gKzA4MDAsIFdlaSBDaGluIFRzYWkNCj4gd3Jv
dGU6DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2tlcm5lbC9wcm9jZXNzLmMNCj4g
Yi9hcmNoL2FybS9rZXJuZWwvcHJvY2Vzcy5jDQo+ID4gPiA+ID4gaW5kZXggMGU4ZmY4NTg5MGFk
Li5kZjkxNDEyYTEwNjkgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvYXJjaC9hcm0va2VybmVsL3By
b2Nlc3MuYw0KPiA+ID4gPiA+ICsrKyBiL2FyY2gvYXJtL2tlcm5lbC9wcm9jZXNzLmMNCj4gPiA+
ID4gPiBAQCAtMzQzLDYgKzM0Myw3IEBAIGNvbnN0IGNoYXIgKmFyY2hfdm1hX25hbWUoc3RydWN0
DQo+IHZtX2FyZWFfc3RydWN0DQo+ID4gPiA+ICp2bWEpDQo+ID4gPiA+ID4gICB7DQo+ID4gPiA+
ID4gICByZXR1cm4gaXNfZ2F0ZV92bWEodm1hKSA/ICJbdmVjdG9yc10iIDogTlVMTDsNCj4gPiA+
ID4gPiAgIH0NCj4gPiA+ID4gPiArRVhQT1JUX1NZTUJPTF9HUEwoYXJjaF92bWFfbmFtZSk7DQo+
ID4gPiA+IC4uLg0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvc2lnbmFsLmMgYi9rZXJu
ZWwvc2lnbmFsLmMNCj4gPiA+ID4gPiBpbmRleCBiNTM3MGZlNWMxOTguLmExYWJlNzdmY2RjMyAx
MDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9rZXJuZWwvc2lnbmFsLmMNCj4gPiA+ID4gPiArKysgYi9r
ZXJuZWwvc2lnbmFsLmMNCj4gPiA+ID4gPiBAQCAtNDcwMCw2ICs0NzAwLDcgQEAgX193ZWFrIGNv
bnN0IGNoYXIgKmFyY2hfdm1hX25hbWUoc3RydWN0DQo+ID4gPiA+IHZtX2FyZWFfc3RydWN0ICp2
bWEpDQo+ID4gPiA+ID4gICB7DQo+ID4gPiA+ID4gICByZXR1cm4gTlVMTDsNCj4gPiA+ID4gPiAg
IH0NCj4gPiA+ID4gPiArRVhQT1JUX1NZTUJPTF9HUEwoYXJjaF92bWFfbmFtZSk7DQo+ID4gPiA+
IA0KPiA+ID4gPiBIYXZlIHlvdSBjb25maXJtZWQ6DQo+ID4gPiA+IDEpIHdoZXRoZXIgdGhpcyBh
Y3R1YWxseSBidWlsZHMNCj4gPiA+ID4gMikgd2hldGhlciB0aGlzIHJlc3VsdHMgaW4gb25lIG9y
IHR3byBhcmNoX3ZtYV9uYW1lIGV4cG9ydHMNCj4gPiA+ID4gDQo+ID4gPiA+ID8NCj4gPiA+ID4g
DQo+ID4gPiA+IC0tIA0KPiA+ID4gPiBSTUsncyBQYXRjaCBzeXN0ZW06IA0KPiBodHRwczovL3d3
dy5hcm1saW51eC5vcmcudWsvZGV2ZWxvcGVyL3BhdGNoZXMvDQo+ID4gPiA+IEZUVFAgaXMgaGVy
ZSEgODBNYnBzIGRvd24gMTBNYnBzIHVwLiBEZWNlbnQgY29ubmVjdGl2aXR5IGF0DQo+IGxhc3Qh
DQo+ID4gPiANCj4gPiA+IEhpIFJ1c3NlbGwsDQo+ID4gPiANCj4gPiA+IFdlIGRpZCBjb25maXJt
IHRoYXQgaXQgY2FuIGJlIGJ1aWx0IHN1Y2Nlc3NmdWxseSBpbiBrZXJuZWwgNi4xDQo+IGFuZCBy
dW4NCj4gPiA+IHdlbGwgaW4gb3VyIHN5c3RlbS4NCj4gPiA+IA0KPiA+IA0KPiA+IEl0IHJ1bnMg
d2VsbCBpbiB5b3VyIHN5c3RlbSBhbmQgY2FuIGJlIGJ1aWx0IHN1Y2Nlc3NmdWxseSBiZWNhdXNl
DQo+IHlvdSdyZSBidWlsZGluZw0KPiA+IGZvciBBUk02NCwgbm90IGZvciBBUk0uLi4NCj4gPiAN
Cj4gPiA+IEFjdHVhbGx5LCB3ZSBvbmx5IHVzZSB0aGlzIGV4cG9ydCBzeW1ib2wgImFyY2hfdm1h
X25hbWUiDQo+ID4gPiBmcm9tIGtlcm5lbC9zaWduYWwuYyBpbiBhcm02NC4gV2UgYWxzbyBleHBv
cnQgc3ltYm9sIGZvcg0KPiBhcmNoX3ZtYV9uYW1lDQo+ID4gPiBpbiBhcmNoL2FybS9rZXJuZWwv
cHJvY2Vzcy5jIGJlY2F1c2UgdGhhdCwgb25lIGRheSBpbiB0aGUNCj4gZnV0dXJlLCAgd2UNCj4g
PiA+IGFyZSBhZnJhaWQgdGhhdCB3ZSBhbHNvIG5lZWQgdGhpcyBmdW5jdGlvbiBpbiBhcm0gcGxh
dGZvcm0uDQo+IA0KPiBXaGF0IEknbSB0cnlpbmcgdG8gZ2V0IGF0IGlzIHRoYXQgd2UgaGF2ZSBh
cmNoX3ZtYV9uYW1lIGluDQo+IGFyY2gvYXJtL2tlcm5lbC9wcm9jZXNzLmMgYW5kIGFsc28gYSB3
ZWFrIGZ1bmN0aW9uIGluDQo+IGtlcm5lbC9zaWduYWwuYy4NCj4gDQo+IEJvdGggb2YgdGhlc2Ug
ZW5kIHVwIGFkZGluZyBhbiBlbnRyeSBpbnRvIHRoZSBfX2tzeW10YWJfc3RyaW5ncw0KPiBzZWN0
aW9uIGFuZCBhIF9fX2tzeW10YWIgc2VjdGlvbiBmb3IgdGhpcyBzeW1ib2wuIFNvIHdlIGVuZCB1
cCB3aXRoDQo+IHR3byBlbnRyaWVzIGluIGVhY2guDQo+IA0KPiBOb3csIGlmIHRoZSBvbmUgZnJv
bSBrZXJuZWwvc2lnbmFsLmMgcG9pbnRzIGF0IGl0cyBvd24gd2VhayBmdW5jdGlvbiwNCj4gYW5k
IHRoYXQgaXMgZm91bmQgZmlyc3QsIHRoZW4gdGhhdCdzIHRoZSBmdW5jdGlvbiB0aGF0IGlzIGdv
aW5nIHRvIGJlDQo+IGJvdW5kLCBub3QgdGhlIGZ1bmN0aW9uIHRoYXQncyBvdmVycmlkaW5nIGl0
Lg0KPiANCj4gSWYsIGluc3RlYWQsIHRoZSBleHBvcnQgaW4ga2VybmVsL3NpZ25hbC5jIGVuZHMg
dXAgcG9pbnRpbmcgYXQgdGhlDQo+IG92ZXJyaWRlbiBmdW5jdGlvbiwgdGhlbiB0aGUgZXhwb3J0
IGluIGFyY2gvYXJtL2tlcm5lbC9wcm9jZXNzLmMgaXMNCj4gZW50aXJlbHkgcmVkdW5kYW50Lg0K
PiANCj4gU28sIHlvdSBuZWVkIHRvIGdldCB0byB0aGUgYm90dG9tIG9mIHRoaXMuLi4gYW5kIHVu
dGlsIHlvdSBkbyBJJ20NCj4gYWZyYWlkIEknbGwgaGF2ZSB0byBOQUsgdGhpcyBwYXRjaC4NCj4g
DQo+IEZvciB0aGUgcmVjb3JkLCBJIHN1c3BlY3QgaXQncyB0aGUgbGF0dGVyIHNjZW5hcmlvICh3
ZSBlbmQgdXAgd2l0aA0KPiB0d28gZW50cmllcyBwb2ludGluZyBhdCB0aGUgc2FtZSBmdW5jdGlv
bikgYnV0IHRoYXQncyBub3RoaW5nIG1vcmUNCj4gdGhhbiBhIGh1bmNoLg0KPiANCj4gLS0gDQo+
IFJNSydzIFBhdGNoIHN5c3RlbTogaHR0cHM6Ly93d3cuYXJtbGludXgub3JnLnVrL2RldmVsb3Bl
ci9wYXRjaGVzLw0KDQpIaSBSdXNzZWxsLA0KDQpPSywgSSB3aWxsIGRvIHRoZSByZXNlYXJjaCBm
b3IgeW91ciBxdWVzdGlvbnMuLi4NCg0KVGhhbmtzLg0KDQoNCj4gRlRUUCBpcyBoZXJlISA4ME1i
cHMgZG93biAxME1icHMgdXAuIERlY2VudCBjb25uZWN0aXZpdHkgYXQgbGFzdCENCg==
