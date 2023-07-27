Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCFD7643C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 04:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjG0C0g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 22:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjG0C0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:26:34 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160122139;
        Wed, 26 Jul 2023 19:26:31 -0700 (PDT)
X-UUID: fdf77aea2c2411ee9cb5633481061a41-20230727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=UfS8nDoqkWOV7rZSaOS0yapc0K0IiRq9zqkXM0F2rk0=;
        b=lJYw0kdZvO/q5V3I2Wc4wkqhLT3bq3Uq3u+Ih087bE3nYl+zztTKwaK6kCU9XkJDbQ1L+sFF//o+JL/SqUfsCi1KHrs3ubcEgkeEeLqh8E2bgL9Yq1x4sA1/VVDANtUNSgI4NGUVCVoCiAkiZZIOHQdyjQnnn9D3KvoW2vF+dmA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:37460758-b86a-4091-bea3-45ef51b2ef75,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:e7562a7,CLOUDID:59325fd2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fdf77aea2c2411ee9cb5633481061a41-20230727
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <will.shiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1790782914; Thu, 27 Jul 2023 10:26:28 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 27 Jul 2023 10:26:27 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 27 Jul 2023 10:26:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLLXWCUTPnQ/s+tS8MDxVEnPCO4Loq8Siv5zDeqO57oAozCll/T5h9ACuiLX3ELjECC6A6Zi/JPuMZRu8dMk7YoghJL4VuQ4sjetgpd0NpGItC+79XOuZKHEpttIO/8qpqYvN3gLt9rPxGsAeGltM+VeVQC5f8UbvvvjDvxzyvdYXyx8uYb8hW9XGPet47sfjt4v0g/0oWjswCqbgt/kkR8gtq6vLFlTlAStaCK4Q2YwaqcD0TciaFbKXkFeGoUka7l19oYg1P4E2IvUKHYfRQOgJ9WUpXKmeZRHcmOr+10l6qb0P+mIa9+N3ylctxDmcv1PhRH24Uep1COBZyjK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfS8nDoqkWOV7rZSaOS0yapc0K0IiRq9zqkXM0F2rk0=;
 b=eCQ5qEQJZ3+TFi9v7DeoqYGc2pFNkAX0/xLC8u/tclM+rtoJ5kzdsWY86QN0rh0W8+5OG7LAY1gosX/rDuU1uFoWxK/BukT+2Xen3f0yoaoWvKS8PCtrAuW6iXcaJv7e+ESGs9vcB6KddLBiB6dlklMLuiRVx7LBmt2bzS79bo3bIrCO9ar9xzRXNJi4OAXj3RHSLHShwT0C41kLHdwQ3Jo39aZ4JENh5cPYkPCFe4HtYb+M/2rbxTFth7/oJlAayhM39zwb0T2+XGwmNpKKJC9bDPr9pWK4Bkj34bLBP+nD+WoOFzLpWXWQIwqHXzG4prWSit4xNSLumyh5A6Lwhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfS8nDoqkWOV7rZSaOS0yapc0K0IiRq9zqkXM0F2rk0=;
 b=IbHx1HuJLzoX9bX31xdOHZTnUK01wPNn2ytJ2tu/oZy+3/SqvZ9Vmi32NnHZHPATvwBuHKgNzf6ku4VPOEc2h8h/95n2fdPhN8V7uW3207IDmFu8j1PNYtTA9vfjnsQGL+fSY/GyF6tsOqDPi7d2J0nSqOIi9+H2MvOjS8mHRxM=
Received: from PSAPR03MB6345.apcprd03.prod.outlook.com (2603:1096:301:5d::7)
 by SI2PR03MB6685.apcprd03.prod.outlook.com (2603:1096:4:1e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 02:15:05 +0000
Received: from PSAPR03MB6345.apcprd03.prod.outlook.com
 ([fe80::e9d1:a896:c17c:c1de]) by PSAPR03MB6345.apcprd03.prod.outlook.com
 ([fe80::e9d1:a896:c17c:c1de%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 02:15:04 +0000
From:   =?utf-8?B?V2lsbCBTaGl1ICjoqLHmga3nkZwp?= <Will.Shiu@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] Fix BUG: KASAN: use-after-free in
 trace_event_raw_event_filelock_lock
Thread-Topic: [PATCH] Fix BUG: KASAN: use-after-free in
 trace_event_raw_event_filelock_lock
Thread-Index: AQHZu5Lmow/B/qCvPEaYTaxVFBL5Ia/EBsIAgAAa9gCACMdwgA==
Date:   Thu, 27 Jul 2023 02:15:04 +0000
Message-ID: <12dca9308e5b37f5686267148ad874084610c04e.camel@mediatek.com>
References: <20230721051904.9317-1-Will.Shiu@mediatek.com>
         <d50c6c34035f1a0b143507d9ab9fcf0d27a5dc86.camel@kernel.org>
         <d0b24d6d5dd15d80be5b1dcd724560bc5a016c08.camel@kernel.org>
In-Reply-To: <d0b24d6d5dd15d80be5b1dcd724560bc5a016c08.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6345:EE_|SI2PR03MB6685:EE_
x-ms-office365-filtering-correlation-id: 0cefb4e1-0620-4e0e-abdd-08db8e474a92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8C1IULFl1KUGbj9bXH4WaxHRHuktmLQzNnTRlf7r5EBoEZQGXec3zZsSlEkkZxLLeaWx+Mz3Sjf0mo2EibSENOhLkhnpQFywmrI8W44HIqkNEWPmIogW7LqzjUQPwkABJKYCx5KNx3EsvpwfeqXbNGrienw1YqgZY98/7OW4YqknAVicygL6wUofPzzhokyLn5O+vCK7LSkqUxTdb9poBudMGjBL5PLtk3eD6q065NeWWATaiTZpjOT+x7Qneodttsomcn17B+MPfUCbs+ZkNGY5RrVd1P6YSIrGv4fosMYgvQmASLE7jMOdDW7b/HUjMYsyDEc3H0x95qCC7BqH5KbJM85GCo2a9wY4fPAKZxnXGSCgd6sPu69IjE7ex8u1ejekLxgihcwfRUrLC28Xllqs3vx2TSjqe9Ni0XVc8wXa6Tbx8AzBtinK4DBezqm90dsroBwEnNXHccUqg1ptRk6FdbDxAMErNMlRL5to2fNdAbbBNzcLEdDJAn8Ohyc7UF2pnjbsvpjGPCreEcdhdxUKnG2lf5IAth8u5NC6xgeBGvEeWvX6LWvaDTevkzKMV24ImMISk9xcs0cY6QBEUjjJXyF61n29b7qxMq71RKm5pkTO5p4bCuNrF5IeNQUsbzcY8IBXZ+D6FY7hHoYI5rIAD9rWJGTuhiP1aYbs5uxgDGwNRGhD4wTrXkCvzOcN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6345.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(6512007)(71200400001)(6486002)(186003)(83380400001)(2616005)(36756003)(85182001)(86362001)(38070700005)(122000001)(921005)(38100700002)(6506007)(26005)(66556008)(64756008)(66476007)(66446008)(2906002)(76116006)(91956017)(66946007)(4744005)(316002)(5660300002)(7416002)(41300700001)(8936002)(8676002)(478600001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGt6WHZNRzR3bnNLWFUyTmVYVm5QU3dMNDNtQjFFQzlRLzU5WjdXVllwMlhy?=
 =?utf-8?B?OFI5TXJWZkd3VTdqOW83cU10Zk5IL0hOdjl5aUJCWjhWY012NFFVNFU2cUlo?=
 =?utf-8?B?OXJZaERGZy9BSVlGNFBaaWsralBWL2NMSU83bXo1MW95ZkhvNzVJNGpsM2pq?=
 =?utf-8?B?blRZU0JCa3VqemJEa004WEpXbEM3ejA2enp0SkRuRmF3YWlGZ3F0bXFZbkFN?=
 =?utf-8?B?eE1sLzVRNmpDcUtuYjdYMno1R2pudURqVzltL3M4TGUxMitMazF2WmVtUHVY?=
 =?utf-8?B?ZDA5VkZ2eS9yMW5XdkpUdm1GK3orbUpZOENnLzVPa0RDaHBYcXVnMUFCdUxB?=
 =?utf-8?B?WWpWZW1SYlhPSlZYQ2RVMUtXcEM4NWFNSU5PcmZBczVxc0RXZWQ4YlVkRlkz?=
 =?utf-8?B?M21rd1ZUWDhhYTNvRmIxVittNUttU1NYb0xFZjFOZXQzWFVNRWx3UmMrMDFj?=
 =?utf-8?B?cTNoSjdPdHZxSk02cUxMQTFIeUp2S0xDbzFPYWtEdm1WOEVNdmh1aHJ6Q1Bk?=
 =?utf-8?B?ekhoL3BnY3pTMmMvOEgzVDA1Vys5Z3VNVHN0cXA5dloveUoyK1g0WjM3d2hT?=
 =?utf-8?B?RzU2UDNGOXcxZlRsL1ZOdFdXMyttS244eEFBejdvdW5uam9Sd2xENm5YVzZS?=
 =?utf-8?B?bW4wT2NvRUZMdWlTdktmVktLM0Qwa3MxTXhUNDlybTBNTnE0S2U2VzRaYXpa?=
 =?utf-8?B?WFlncGd3cWFvenVxLzRrK3JqZ1pnNUFzbFExWXJDcWhwM1VONW5zSE9mTWpJ?=
 =?utf-8?B?YVVLM1dkSWdZaXBCb0FMSzhzS1g1OWRpODdFcXkyamtRenRkVGFiTWZaU013?=
 =?utf-8?B?T0NzbG9rS1hDQll4LzNJaXRITkxYbzlLalFRdWIwWUJVQWN2WlVmTGpwWThB?=
 =?utf-8?B?MTYvMW1tWGl3ejh3M3BySzB4Ujh6TnN6OXlUN2JRcVNucFRCMDdTbWRpc1BR?=
 =?utf-8?B?NC9GbEp5Lyt2ak5CU1U4eFpnSEF6SXVYdzBmS1dqcWx3bko2Q3o3MU9aMHNS?=
 =?utf-8?B?ZFg2OVR3anE1ZGtiVk9BYlF2cHNKREVTTW52amlhbVV6dW9maFlMcXVKWGVh?=
 =?utf-8?B?WllPQWE3NVFQUHkrc2piNi9qUS8xeFd3UXNpbWRNUUIxbndqTWV4NnNUZnBV?=
 =?utf-8?B?V2RDS0loKzlJL0NEOXJZRXV4Zzkxb2dhMkZDVklXYmZQVjVmbWRnenNsU01x?=
 =?utf-8?B?Y1lSa292WmIxR1BtU05rRUp6Wnk5MzJMWlROYS92Ni9GWGFXV083eENTeFhW?=
 =?utf-8?B?QmZDcDk3U0hJc2x3c3Y4OEFqQXlEdkhBUHo3Zm9iSkxOdlV6Z0tCbEdlaGh4?=
 =?utf-8?B?Qlp3K2hYZzJiZVVTbkt0VG0wTW9Ud3FHMVplQ1liYzhFczZ0aE1EQlE4NEZZ?=
 =?utf-8?B?RnJMaENRWUhtNy9KR21HR2ZybkdwV21aRUZ1RmRSV3plYjcrTTV3L0Q2Vk5X?=
 =?utf-8?B?cjZoTjlvSjZSOEx6R1VrQ0padCtYNVRORSsyZlN6UjZyNERXNFprUXhDVTdK?=
 =?utf-8?B?ckp4bXpGeVB4YVJKLzJEVE1lT2E3Q3F6UlVFUkNrZkNxUEp4c2phQWp3TEE4?=
 =?utf-8?B?cTd2b2d3YlhJUFhPTTJsRnFtVEhBclJmQSs0TjQzanhGaU5HMnovbHBrSndS?=
 =?utf-8?B?dTRCMi9UdUJBQzNjVlNZVWZoMUVMcTlyQ1ExSkh6cUxheFNNcUpCVXNRNXpw?=
 =?utf-8?B?RWNKeWNWVGxTRjhRQ0pnd0FJbVFBMkg1dVMvdnpIVlNHMmF3MkVmRGhxcFdN?=
 =?utf-8?B?L3VaNUVyd3ZQemFVMlR2aTJqeE1WQ3dqemJaeVBvczhmZEZsbGNaZk5EVS9V?=
 =?utf-8?B?cnlvTldiek5jVmNDd1lYTzBEVGxhcnVhYlFiZENCYmp4c1ByVTZjbTZTQVUy?=
 =?utf-8?B?YWUvZjhlOUVVaXo1M1RRVVlYb0VHWG5Cd1RmY3Yxb2ErdTcwakxJMENvRnQw?=
 =?utf-8?B?azZOUlJ6Rlg4c0xMU3VTSzQ0VEF3VjJGTThrbldsRUpPcWc0MXJtb09Vd1hH?=
 =?utf-8?B?eFIrRFZxN1hYaWlxRWdPazJNMnVteFFPZXRGeUVINDRZTEUvQWdqWDQwWXox?=
 =?utf-8?B?aFpXbm5lalpQQ1JwOVgxMWhaeFZsOTVMWHJNbCtTS2xLZlloU2plMVNWeFRU?=
 =?utf-8?B?d0tPQkJ3UXZBUThqRnVaWWlVSXRFOFNZalhHWW0ySkJPaHQ3ZTVJSVM1bndp?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <730162610C1244419DD5E69AB6E2CE5C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6345.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cefb4e1-0620-4e0e-abdd-08db8e474a92
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 02:15:04.7959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7AVwkeArl/+uTgXaWr994sF+wDg2F5yO2iQAA8RIfWQnMb1yGuVD1LtJwHBNogYllY6n+KfiIosSmFOYQKxeNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6685
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDIzLTA3LTIxIGF0IDA4OjExIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
DQo+IE5ldmVybWluZC4gSSBzZWUgaG93IHRoaXMgY291bGQgaGFwcGVuLCBhbmQgaGF2ZSBnb25l
IGFoZWFkIGFuZA0KPiBtZXJnZWQNCj4gdGhlIHBhdGNoLiBJdCBzaG91bGQgbWFrZSB2Ni42Lg0K
PiANCj4gQ2hlZXJzLA0KPiAtLSANCj4gSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4N
Cg0KRGVhciBKZWZmLA0KUmVhbGx5IHRoYW5rcyBmb3IgeW91ciByZXBseS4gd2UnZCB3YW50IHRv
IGtub3cgY291bGQgdGhlIHBhdGNoIHdlDQpkZWxpdmVyZWQsIHdoaWNoIG1vdmVzIGZ0cmFjZSBm
dW5jdGlvbiBhaGVhZCB0aGUgcmVtb3ZpbmcgQVBJcywgYmUgdGhlDQpmaW5pYWwgcGF0Y2ggYW5k
IHdpbGwgc3VibWl0IGluIGs2LjYuIElmIHllcywgd2Ugd291bGQgdHJ5IHRvIGFzaw0KZ29vZ2xl
IG93bmVyIHRvIHBhdGNoIGJhY2sgdGhlIHBhdGNoIGluIGs2LjEuIE9yIGlzIHRoZXJlIGFueSBh
ZHZpY2UgdG8NCnNob3cgdXMgaG93IHRvIGZpeCBpdC4gVGhhbmtzIGFnYWluLg0KDQpCZXN0IFJl
Z2FyZHMsDQpXaWxsIFNoaXUNCg==
