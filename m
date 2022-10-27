Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D358060F9B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Oct 2022 15:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbiJ0NyR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 09:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiJ0NyO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:54:14 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60801843FC;
        Thu, 27 Oct 2022 06:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666878853; x=1698414853;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F0ZV6p8/aWNkEgune5e/jAT+xeTxBnFRLRIs/u8+cwc=;
  b=QAmHpCAlarmWY0vF6iOapjQLWjzCOzraSfg2o/10k53GKAcjBlNMYMHv
   thKbV3yrlmoZ15nippUvhOlOH3BHRCqRS7rlh7LPsIRFVWiYG9sHYhbh3
   wJGxfkucsdIhcWUTLzSpMcWHvJNFt3ySfJ+pfQxPO1iYRBXvdAuaqX/pa
   seBoMfBnMwlbhhzJjgErDNRbwj4GnBQ+c+9encU0LcqimEJd7STBBajpt
   r+rJJo5TmPj7eDbjPIqOhxwezMtuhE4DpQ30Sa02Qa7HCs/XIYxMujcKf
   OK5+MUifJMu+O+zSBn1KeG3krubQcMzQekky8sBAmVs4Fchuu/hi5HlFo
   A==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="214875920"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 21:54:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGguwp8SzIV92IWa89tyPQyZs7TTjO/KxcGfwSp4SiI5gY6cCWm3J1A5qqn6ydUiOtFk4DWUXC1F5aP1a0T25IhKeyyXs8ieUSkjPgxfOMPvERn/2ZiHwoJ2PPLJMW2vIwolRugiIEvLBoBo7QKn4xmarjmNPe/RNAEA6gDthys3o+Msw3QwGooBSURMWi0/1F4M04pwbpGP0SoRV2mKZIjMiTf84vgJHw6qjAbCyR9TeyIrkT7p0dJbXyupm4i1RyH5nd5jrvCFsPNR8UyfCg+IUIxJv111XNZAeMpr1nDbIBsxAezvY/UG7RKRHomm231YmE8YNidrI/TRRlA0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0ZV6p8/aWNkEgune5e/jAT+xeTxBnFRLRIs/u8+cwc=;
 b=eG5z57ZpAHhH9EOLt/0vaPjyCgSB8yK8/Xt3x/ilM5Wr+DDYy3yxuWon3xuKbTIgshj7aqUezcphlRTniOJFoKF0YUNwtXzKms0TwP0+OJ0dF/FLzdbeLlcEq9ZIsZrY5c/suhFl4YSPFpWgFbwvZs2BqN2Gr+2RmIQ+9mVGswCHNOPSyQNuAqzOO3XOsvBVsIKtJgXNouQDnWVrKtld9NEDGO5S2v3dyK0ndq9aJE/VS9YUd0AblMVOlZPst5ZPJkfDf1iG6uQu4qV8RlIQldWVsV7mWOdOgm53f2sGr/a95dEe0CanViSe9mq10E47XLeWlLXM/qmjesK9Eq+8Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0ZV6p8/aWNkEgune5e/jAT+xeTxBnFRLRIs/u8+cwc=;
 b=WR0IUGDilNs4c1sH9m7tcNCqsV0UQsZ8EuVrSNdAMyf2EMl7CZ8nyRAoa4kzaocvL2MUqMyPBlfJJVBGnjkOnlYmhFUCEwOAei0MJynyKs8XNba6PyqY9z8hWUYCv7s3sBak5lH1KCYeqotRX2DVQjWGSMKMEZHhPF6hb28iPEg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7718.namprd04.prod.outlook.com (2603:10b6:510:56::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Thu, 27 Oct
 2022 13:54:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 13:54:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "dsterba@suse.cz" <dsterba@suse.cz>, Chris Mason <clm@meta.com>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
Thread-Topic: consolidate btrfs checksumming, repair and bio splitting
Thread-Index: AQHYvdZkzfjbXHDoM0mHBIw1hzgYgK4dhQkAgABtcoCAAAtsAIAAHYQAgAKETACAAER1gIABt1OA
Date:   Thu, 27 Oct 2022 13:54:09 +0000
Message-ID: <822e2bb6-a0a8-b0e1-50cc-d6d2952e938b@wdc.com>
References: <20220901074216.1849941-1-hch@lst.de>
 <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
 <20221024144411.GA25172@lst.de>
 <773539e2-b5f1-8386-aa2a-96086f198bf8@meta.com>
 <20221024171042.GF5824@suse.cz>
 <9f443843-4145-155b-2fd0-50613a9f7913@wdc.com>
 <20221026074145.2be5ca09@gandalf.local.home>
In-Reply-To: <20221026074145.2be5ca09@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7718:EE_
x-ms-office365-filtering-correlation-id: 5d088181-9d2d-4c30-7b60-08dab822b8de
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dQjRm3k2BKf1Zogj6WKkZasfpXkjaQjbI+oEw1CCE9QYmaPfc7ZGlSq/FADKF+mVzvd8kdz5WNqJxK/QBppBPJivywynnYl8r2hs4RR0ZxCQaB3j7yk9GaQTSoemi/v4rWLz7ZNzz4iyfl92MLM9s9aUhUP/js3gzAr+kqzdxID/9NY6rq8QmE/QfJcXUhJcZMbxHZj+am2WMYEhhrQVxePDQMk3Qw5Q6pGnaesThf35ljz6sa1TAs3MVntQxSirYgp4pkR+NRw1OjUi583ZuCKt3c9hhGrWPVCxkkkDvBUTyq+PA12PKEn+1kBaZCZw4UEC/RLk/E6ce2aQ6WIJa7Roi++KFtCn2hguAdd7pM0/2hjGqETodySBvJu0Nu7BGbc7lDa+1/8kW8k79/O+rP1lTsUA7BKW4UG1gKa9YWcHOWN5NvLLG0Ow0CPaLRBrK/gBkGEQcvfHzqvc/+h2xD7jlNGmyYGGNI46qfpzBHx54/y9p+4jifbltKgsPzMiD/vCiZvWwdojaRbpCCwhWh7UpON0iG3jAuug3agtwnrbAdVFrXMllf8iUA/QhZCuVJv9WzLvQJC8ia0ZV+tRB7f1qYfWUPSCQFSjhxIGUCIHEiVjVesxtlPmRQoGYVi0wxrWE/L3xpbMwmoMvosWbNsS11muyrf63W+rlDG3vBLcHj0RZS8tbhcO2D2i5oGezIIJ05nGXoN0RJKU+6eLYVPsB/FQew3zXP/gN+XI9mcRKSYiVe6RyoD/jTJiCn2KfYc/Bl688zC5lqHWeHT6Ea9e823hAijAlbaC7YykCG87ZNXAWkxFA8i3UIhTIvb4j7Vn2anuKUe6YvSuUoykAp5N8A7AKVLhticTSoI0gv0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(84040400005)(451199015)(38100700002)(122000001)(86362001)(186003)(6916009)(36756003)(82960400001)(54906003)(478600001)(316002)(966005)(8676002)(66946007)(66476007)(6486002)(2906002)(66446008)(31696002)(5660300002)(71200400001)(64756008)(91956017)(41300700001)(4326008)(26005)(7416002)(76116006)(66556008)(38070700005)(83380400001)(53546011)(6512007)(8936002)(6506007)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTVvRXFOdmJZdjAvQ3F0bVhMKzF1ejFudElnOXNqQW4xRm1nejhndStvNEE2?=
 =?utf-8?B?U0VmY3lCSmVySEpWKzJHV2pOdzVGUkQ1cEdlRElhUEdrd3g3K05GVlBEek4z?=
 =?utf-8?B?eWUwK0orNzQwcWdjczdUVUlOWnlGZlBnWmdJT3FwL2xsWVd2WGlza0tiYmVo?=
 =?utf-8?B?ZzZaTDZZR3dmSVAzMk1BTWJ5QXJYTzBzU3h0T0JJR0x4dVFPTVM4YWJXdG5k?=
 =?utf-8?B?MC8rZmhLdWJnOW5sQVhBUXp2RG5QaU9GMGtSWDZwU09TK0VXZ3hWSDJCbHl3?=
 =?utf-8?B?ci83RkhoQWcyM1VXSE9LbWxub09CVGtpalN5Zlp2LzlxUThqZ0N1UmQyaTlG?=
 =?utf-8?B?RFVHbVlrUnh5cVlrSi9uSGFrUGUrcHBrcEVkaVM4WDZnSlVSNlJUdGNHa3I4?=
 =?utf-8?B?OFlIS1p4ckk1MTFiUG1WeEhzbjdCV2x1b3plSlp1T3FSWmVQNHVwalVZQnVx?=
 =?utf-8?B?Y0ZNbDZod1EwZzJkK3daWDNUSzFqTnExL2E4OTNUcUNSQ3o2Z0F3N0xpekZv?=
 =?utf-8?B?NSthZDZGOUFyQThvUnZMUDVaSjlGKzh0U3g0K0ZCQm1XcXhxN1EzWERmMlQ5?=
 =?utf-8?B?YXQvdDBIRUYyN3gydmtRbjNsTXhySitkaWQvSXQ5NTJvbTczK0pzanB3UEto?=
 =?utf-8?B?Mnc4ZExBZ1JpZzBYV01GbTdJazBvWXRKZmU5enQyOEZZTXhQRkRFaSszem1s?=
 =?utf-8?B?dEQ2eVhGbE91cG5pV0JuSEhMcVltVkdBUkExajR6eER4WmI0R093VENOVmlB?=
 =?utf-8?B?YVh4YUVFc3VjL3k4NWZDMm45Wm02RWJKYkUvdEwxVEpNaGNmT2hhWVdJM3dR?=
 =?utf-8?B?TXNGVG1hY0I2L2hUSlYxUk92RDhlNXJ0eVVxRkhHVVo5cFo3N1h6RjJNcVJJ?=
 =?utf-8?B?bUpQbzcxYWFjY04vaEMzR3c5V3pmV3EzLzhHdjlrSHAvdlovUGdSamVybkZs?=
 =?utf-8?B?MTV0QU11d3NLWWVOVkZLNzJxYTVNWjMvMUVsK3M2MS80TjUyR2thamMrWW00?=
 =?utf-8?B?YnROL1JSVE5CMWl2Y05tMlI0MlFlTWNsN3FKR3NvUXpFU096dnIyQmhMYno5?=
 =?utf-8?B?ME5lSDVud29EUHJ0MGFsaUVQWW9xUXNRL0NrTFhTbVZrajZXUWN6SEUzMUw4?=
 =?utf-8?B?aE1uRm1TU1JTMGFvWXJwNXVTdUk0SzRQL1RRZmdTanVyaDRyNk96U0laNVhC?=
 =?utf-8?B?cm5FaEZHS3RYZ29rckM2aFUrS2EwYnlBRmZtTk96QWJ2ZXZvMVRSVGV4Vkw5?=
 =?utf-8?B?UUF1UFJiUTluc2lnR0NMVXFkV0lKOVBUN29WS3lHT3ZpOExmbWllWEx1Q0RX?=
 =?utf-8?B?N0l6WS9DVU5adUlaL3RpUzc2dlJMU3pIakFVNzJRd1JvM3pOMXpaYUVQRmNa?=
 =?utf-8?B?UXNXQTlTWElnMTRPS2U2UVNPZFNLQmhYVHNRSlVLTWFPYkRIc2Nobzk3T3Qw?=
 =?utf-8?B?QzlETzd0dFB4L04vMTU3Ui90T1Z2ZFQ1d05Ub3FrUjFqZzk0RjMvS2IwTlFB?=
 =?utf-8?B?QmhaQU83ckFZV0FINWlwWENlbG5KS1JhSUJZcm9BS3l1ZjBrSFdCd2R3Q3JL?=
 =?utf-8?B?WlF6VDM4bjcreFh3bW5xRXlWWGY2KzJtT000dzdNQnQ2U09weVdsR3hWVUky?=
 =?utf-8?B?c0x0YmY0V0w1WFI0UVJGNlBhbmlmaU1mQkZNd2ZMK3A5SVlpb0lvSno4QWo3?=
 =?utf-8?B?UXZCdmt5NlVzRjNCMnlVUENETnNhV2JaWnRzM3o3bXNSMys0UXorK1JjdXJp?=
 =?utf-8?B?VnFpWm5hTlR1am4zNkNUQVpBZFdiSmxybFZ6d2NTNnBVQ0xjcmRMNEowY2ov?=
 =?utf-8?B?Z3BOY1JPaGR6VnhmTjMrMEk2M1dnSnJQOW5PL2FxeUtjZHgzdm84bEFSQnZ5?=
 =?utf-8?B?L2RmYnlydmhJYWlmK0tEU3VFc0kzc1FGeFRlN25HVUdrMjJOUkVUTjBpVXU2?=
 =?utf-8?B?MFVzOGhlbHEzZ2EyYlJyaXZtZ0VmU0YyVVVPb3ZWaUlmUWtRRmlnWGhkNzA4?=
 =?utf-8?B?M0FVbnZGNGE0VmZOU2RwWHdTZ1VNekRaTGpDemcvdmc5VGVCazJKR1c1eU5L?=
 =?utf-8?B?eTNDZDl6YlI0ZkpMZTR5aXJ6Q0kvVlVWWkFOL2craTZobFJEU3QwN1V2NnNw?=
 =?utf-8?B?NjRQNEtFdEdqZHdXNUVMaFBkZU5kVGFXMVZ2Vkh5T1VKZnV5UWZ6Y0tJYjhW?=
 =?utf-8?Q?+X9ELBhHfA2U95xjWgTQ9WQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3046BE766180D409BC2964E55A08FBD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d088181-9d2d-4c30-7b60-08dab822b8de
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 13:54:09.6021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bK3Yq7ROvon2+rfa608yCYsNANRnqsfY6+1O8B6TSkqv3K1kmyKICR8i4yg6eVZTcSWyUZTWvBUw12Bz2Mr+2g6/J5fMJONqC4ScBOexcuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7718
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMjYuMTAuMjIgMTM6NDEsIFN0ZXZlbiBSb3N0ZWR0IHdyb3RlOg0KPiBPbiBXZWQsIDI2IE9j
dCAyMDIyIDA3OjM2OjQ1ICswMDAwDQo+IEpvaGFubmVzIFRodW1zaGlybiA8Sm9oYW5uZXMuVGh1
bXNoaXJuQHdkYy5jb20+IHdyb3RlOg0KPiANCj4+IFsrQ2MgU3RldmVuIF0NCj4+DQo+PiBTdGV2
ZW4sIHlvdSdyZSBvbiB0aGUgVEFCLCBjYW4geW91IGhlbHAgd2l0aCB0aGlzIGlzc3VlPw0KPj4g
T3IgYnJpbmcgaXQgdXAgd2l0aCBvdGhlciBUQUIgbWVtYmVycz8NCj4+DQo+IA0KPiBXZWxsLCBD
aHJpcyBNYXNvbiB3YXMgcmVjZW50bHkgdGhlIFRBQiBjaGFpci4NCj4gDQo+PiBUaGFua3MgOikN
Cj4+DQo+PiBGdWxsIHF1b3RlIGJlbG93IGZvciByZWZlcmVuY2U6DQo+Pg0KPj4gT24gMjQuMTAu
MjIgMTk6MTEsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4+PiBPbiBNb24sIE9jdCAyNCwgMjAyMiBh
dCAxMToyNTowNEFNIC0wNDAwLCBDaHJpcyBNYXNvbiB3cm90ZTogIA0KPj4+PiBPbiAxMC8yNC8y
MiAxMDo0NCBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6ICANCj4+Pj4+IE9uIE1vbiwgT2N0
IDI0LCAyMDIyIGF0IDA4OjEyOjI5QU0gKzAwMDAsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZTog
IA0KPj4+Pj4+IERhdmlkLCB3aGF0J3MgeW91ciBwbGFuIHRvIHByb2dyZXNzIHdpdGggdGhpcyBz
ZXJpZXM/ICANCj4+Pj4+DQo+Pj4+PiBGWUksIEkgb2JqZWN0IHRvIG1lcmdpbmcgYW55IG9mIG15
IGNvZGUgaW50byBidHJmcyB3aXRob3V0IGEgcHJvcGVyDQo+Pj4+PiBjb3B5cmlnaHQgbm90aWNl
LCBhbmQgSSBhbHNvIG5lZWQgdG8gZmluZCBzb21lIHRpbWUgdG8gcmVtb3ZlIG15DQo+Pj4+PiBw
cmV2aW91cyBzaWduaWZpY2FudCBjaGFuZ2VzIGdpdmVuIHRoYXQgdGhlIGJ0cmZzIG1haW50YWlu
ZXINCj4+Pj4+IHJlZnVzZXMgdG8gdGFrZSB0aGUgcHJvcGVyIGFuZCBsZWdhbGx5IHJlcXVpcmVk
IGNvcHlyaWdodCBub3RpY2UuDQo+Pj4+Pg0KPj4+Pj4gU28gZG9uJ3Qgd2FzdGUgYW55IG9mIHlv
dXIgdGltZSBvbiB0aGlzLiAgDQo+Pj4+DQo+Pj4+IENocmlzdG9waCdzIHJlcXVlc3QgaXMgd2Vs
bCB3aXRoaW4gdGhlIG5vcm1zIGZvciB0aGUga2VybmVsLCBnaXZlbiB0aGF0IA0KPj4+PiBoZSdz
IG1ha2luZyBzdWJzdGFudGlhbCBjaGFuZ2VzIHRvIHRoZXNlIGZpbGVzLiAgSSB0YWxrZWQgdGhp
cyBvdmVyIHdpdGggDQo+Pj4+IEdyZWdLSCwgd2hvIHBvaW50ZWQgbWUgYXQ6DQo+Pj4+DQo+Pj4+
IGh0dHBzOi8vd3d3LmxpbnV4Zm91bmRhdGlvbi5vcmcvYmxvZy9ibG9nL2NvcHlyaWdodC1ub3Rp
Y2VzLWluLW9wZW4tc291cmNlLXNvZnR3YXJlLXByb2plY3RzDQo+Pj4+DQo+Pj4+IEV2ZW4gaWYg
d2UnZCB0YWtlbiB1cCBzb21lIG9mIHRoZSBvdGhlciBwb2xpY2llcyBzdWdnZXN0ZWQgYnkgdGhp
cyBkb2MsIA0KPj4+PiBJJ2Qgc3RpbGwgZGVmZXIgdG8gcHJlZmVyZW5jZXMgb2YgZGV2ZWxvcGVy
cyB3aG8gaGF2ZSBtYWRlIHNpZ25pZmljYW50IA0KPj4+PiBjaGFuZ2VzLiAgDQo+Pj4NCj4+PiBJ
J3ZlIGFza2VkIGZvciByZWNvbW1lbmRhdGlvbnMgb3IgYmVzdCBwcmFjdGljZSBzaW1pbGFyIHRv
IHRoZSBTUERYDQo+Pj4gcHJvY2Vzcy4gU29tZXRoaW5nIHRoYXQgVEFCIGNhbiBhY2tub3dsZWRn
ZSBhbmQgdGhhdCBpcyBwZXJoYXBzIGFsc28NCj4+PiBjb25zdWx0ZWQgd2l0aCBsYXd5ZXJzLiBB
bmQgdW5kZXJzdG9vZCB3aXRoaW4gdGhlIGxpbnV4IHByb2plY3QsDQo+Pj4gbm90IGp1c3QgdGhh
dCBzb21lIGR1ZGVzIGhhdmUgYW4gYXJndW1lbnQgYmVjYXVzZSBpdCdzIGFsbCBjbGVhciBhcyBt
dWQNCj4+PiBhbmQgcGVvcGxlIGFyZSB1c2VkIHRvIGRvIHRoaW5ncyBkaWZmZXJlbnRseS4NCj4+
Pg0KPj4+IFRoZSBsaW5rIGZyb20gbGludXggZm91bmRhdGlvbiBibG9nIGlzIG5pY2UgYnV0IHVu
bGVzcyB0aGlzIGlzIGNvZGlmaWVkDQo+Pj4gaW50byB0aGUgcHJvY2VzcyBpdCdzIGp1c3Qgc29t
ZWJvZHkncyBibG9nIHBvc3QuIEFsc28gdGhlcmUncyBhIHBhcmFncmFwaA0KPj4+IGFib3V0ICJX
aHkgbm90IGxpc3QgZXZlcnkgY29weXJpZ2h0IGhvbGRlcj8iIHRoYXQgY292ZXJzIHNldmVyYWwg
cG9pbnRzDQo+Pj4gd2h5IEkgZG9uJ3Qgd2FudCB0byBkbyB0aGF0Lg0KPj4+DQo+Pj4gQnV0LCBp
ZiBUQUIgc2F5cyBzbyBJIHdpbGwgZG8sIHBlcmhhcHMgc3BlbmRpbmcgaG91cnMgb2YgdW5wcm9k
dWN0aXZlDQo+Pj4gdGltZSBsb29raW5nIHVwIHRoZSB3aG9sZSBoaXN0b3J5IG9mIGNvbnRyaWJ1
dG9ycyBhbmQgYWRkaW5nIHllYXIsIG5hbWUsDQo+Pj4gY29tcGFueSB3aGF0ZXZlciB0byBmaWxl
cy4NCj4gDQo+IFRoZXJlJ3Mgbm8gcmVxdWlyZW1lbnQgdG8gbGlzdCBldmVyeSBjb3B5cmlnaHQg
aG9sZGVyLCBhcyBtb3N0IGRldmVsb3BlcnMgZG8NCj4gbm90IHJlcXVpcmUgaXQgZm9yIGFjY2Vw
dGFuY2UuIFRoZSBpc3N1ZSBJIHNlZSBoZXJlIGlzIHRoYXQgdGhlcmUncyBzb21lb25lDQo+IHRo
YXQgZG9lcyByZXF1aXJlIGl0IGZvciB5b3UgdG8gYWNjZXB0IHRoZWlyIGNvZGUuDQo+IA0KPiBU
aGUgcG9saWN5IGlzIHNpbXBsZS4gSWYgc29tZW9uZSByZXF1aXJlcyBhIGNvcHlyaWdodCBub3Rp
Y2UgZm9yIHRoZWlyDQo+IGNvZGUsIHlvdSBzaW1wbHkgYWRkIGl0LCBvciBkbyBub3QgdGFrZSB0
aGVpciBjb2RlLiBZb3UgY2FuIGJlIHNwZWNpZmljDQo+IGFib3V0IHdoYXQgdGhhdCBjb2RlIGlz
IHRoYXQgaXMgY29weXJpZ2h0ZWQuIFBlcmhhcHMganVzdCBhcm91bmQgdGhlIGNvZGUgaW4NCj4g
cXVlc3Rpb24gb3IgYSBkZXNjcmlwdGlvbiBhdCB0aGUgdG9wLg0KPiANCj4gTG9va2luZyBvdmVy
IHRoZSB0aHJlYWQsIEknbSBzdGlsbCBjb25mdXNlZCBhdCB3aGF0IHRoZSBpc3N1ZSBpcy4gSXMg
aXQNCj4gdGhhdCBpZiB5b3UgYWRkIG9uZSBjb3B5cmlnaHQgbm90aWNlIHlvdSBtdXN0IGRvIGl0
IGZvciBldmVyeW9uZSBlbHNlPyBJcw0KPiBldmVyeW9uZSBlbHNlIGFza2luZyBmb3IgaXQ/IElm
IG5vdCwganVzdCBhZGQgdGhlIG9uZSBhbmQgYmUgZG9uZSB3aXRoIGl0Lg0KDQpUaGFua3MgYSBs
b3QgU3RldmUuDQo=
