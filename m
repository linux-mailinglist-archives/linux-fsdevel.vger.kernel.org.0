Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A36609D7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 11:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiJXJHx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 05:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiJXJHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:07:40 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA39C761;
        Mon, 24 Oct 2022 02:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666602448; x=1698138448;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yRqlZjJUhG7A+PXHx572xLpuZv5jx+M6D/sydDXf1Us=;
  b=pxcJ2m0K009lQ90TI5UUMDsLAQF9Q3dvusVuNFW26/CUgmukX9apPjrv
   7S0s7uFmxUmWu8hrvYlYwaTT7hKlxhVbtimvMBcEaCHWBz5Cr2BpwtNGr
   HbI8EdnAT/AcW5EtjhcFZwZjWNZKX7Ug5Idk0EoThaU1hLMbkJEYmEDxN
   VTdRXL999kiB2Dn/3HZee38hU/8U4XNJ1UqYrTc2bnJqOQLA9O88uOPCM
   M93e0wDyYse1h34hkMFDNbmhNtrHwagSgkHFe9mVzXCzLDiurFIk38IJZ
   Nc9LUPGfJAdM1gdxDDY7r3uf5G+aw6DWzp7SsmbrvAQAwpr54nswkS5GY
   w==;
X-IronPort-AV: E=Sophos;i="5.95,207,1661788800"; 
   d="scan'208";a="326693363"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2022 17:07:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8ICobHnmZsjOgv2oOz7jmyYJDSEYprdQNf2y6n8r58zObJAmsr4XJ2AU3hlWZVL5eu0FE4Uql8KeNnt6GxigRkTnuAwOVS8TkAfid9RZ327FVT75onesB7rAJT791kT/ItvJM2hBNG/2+BjVPZ0Sea1OVU2RiP7GFe/BcunXfeMyi+dH+nzvtjuZmXWfZUWWOxn4H0q3JZDq1fZCHvedhZYw20YqkPpDRHYB5r/HpTI+lgep0XIdQKX3PMD1y57qpbOhQEjajW5LuTffGkTGovUSMLpmbwC1ddBOmeyFYgkJVjMUrGPPTqWge+rUZIXY3w1im2pf5Qa05xlg5cz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRqlZjJUhG7A+PXHx572xLpuZv5jx+M6D/sydDXf1Us=;
 b=Qa5ZNpDRS/GUy9EJCTxOT1yXnQmNz+EJ3T0JPW2/8OPUc2Jz79RsWqJDny8O70U2kfXfBz2IIZCjc3V02w/ia5+tLfDg44Ah5jV7Y6JCylDxPK+rXCI2KN68UTqwk0zwUOoGZLhKmQreK5tJKrTwol5HTa3wPCF+th8RjpDQH6l9vvL6qJNgIOygwyIC5rHrxLl3Z4ArEGtT++mO2Lt4/9ffjVVMngrm+OKh/o+nBSe1txYw1WlhgHWLUTNZ+EDuwTK/662BGnRShBY3Yn4AF97kwgDoB8Dhpf7ZNHC8kOimloONG/ODzYu+yMi4iikCwCD42nXb1fAiYK8sYuZUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRqlZjJUhG7A+PXHx572xLpuZv5jx+M6D/sydDXf1Us=;
 b=ckxvzelFh7lWUkpIPymseynkuMKtwQg6ZrHaAb9Z2p34LFCQuuPENk5k9gWoL2zNU/JT6RKhp91lXmzHaPXCo/jFF92PX52u8ioaM/FQxw8uWnN2igQVhzjeAbD8tA3sWLdc8Au+cOnGmG//1v49MhQM8/6b3d0vEqgGVSr9jpk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB0338.namprd04.prod.outlook.com (2603:10b6:404:1e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27; Mon, 24 Oct
 2022 09:07:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.038; Mon, 24 Oct 2022
 09:07:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Christoph Hellwig <hch@lst.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
Thread-Topic: consolidate btrfs checksumming, repair and bio splitting
Thread-Index: AQHYvdZkzfjbXHDoM0mHBIw1hzgYgK4dhQkAgAACIgCAAA02gA==
Date:   Mon, 24 Oct 2022 09:07:23 +0000
Message-ID: <00e0cbbf-8090-7da1-22a7-a10bf4c090f2@wdc.com>
References: <20220901074216.1849941-1-hch@lst.de>
 <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
 <de4337f4-3157-c4a3-0ec3-dba845d4f145@gmx.com>
In-Reply-To: <de4337f4-3157-c4a3-0ec3-dba845d4f145@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN6PR04MB0338:EE_
x-ms-office365-filtering-correlation-id: 2e7c78a4-5afa-4a65-e2d3-08dab59f2a18
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hOBirLwOTIJ0ITaw4cQ7XxOiHnEEnlwLgO1Tp2eDWesk/4BPaiXERB/u8sCRdxOkqVNn5CZMkoUxvgeoABn64kl2z1sCdBEy2FgETk0+AGs62SdLrXuW5W1ePufrZJMQruZdn1E7ERSWxmdpRrYyJBRZy5zLCoR2VX4JzeJftvjwX/qJvqJL8d+87MqZIt+ip3RM7eWOfDS1flz3wtFG7CCTt9tIl3egNXcwqDSDD6lOT5de3S2cKkfFoI6hOsVnXYt89UZZeJ81gtGNfH+gI7ufDqaOx13hNEVkb9XHzj4PVCbHCZh1PvFaAP9jHBMemiyo6iD7y4cJcYD9kq121N1Z8zNS6z2HRctkO90dov8JQdYd7Gi8en8uYDWxLQ4csW8ewXfb9n7jJC237Hto6Gg1kLZyPVPrqETy/k/hKfY1jQ3QgQOQYkbJv8gIiR5sOJ+w63lVQRCf83cKYJD7ZMjYT/pR337orCaRNF6CnW/TCXGyFQpKwKeqmHkoOkCZi6/OcszdJ/whKhYSTF5QuJzv6H2jx3vAjBykoeMUpsY4CYQSZc80FRVHxm2ehmKF8gfz6Ha4rdypmYyKliK2zrwnh5Z8xIeKHZWOdv3dRmfNJMmvJcwy7WNnddLer5KpFTcRwjYCC21X81XNX0UAxiy5+bI/jZWnpJlOWSZlVFImQjXKDo3IeWt+2q8jH82wTqjjWv5AhbROpayk/Rzf6PhlxD3sdwIxxDAQFEvIIR0zbNmDOKua8joLNy8yCsG7Pa0IkvgdFXdm8F6YWbwnDMK4+hHeAM0MxspuTxJcn8qMUEf1kzGdWCUqX0YJPiZ2FH6gAxbxkwYFdo1MJ53+AQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199015)(83380400001)(38070700005)(86362001)(31696002)(66446008)(82960400001)(38100700002)(122000001)(8936002)(4744005)(5660300002)(7416002)(76116006)(66946007)(66556008)(66476007)(91956017)(8676002)(41300700001)(4326008)(2906002)(6506007)(53546011)(2616005)(186003)(6512007)(110136005)(54906003)(6486002)(316002)(478600001)(64756008)(71200400001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUhBTWRpL1lBSnp6L2k2dTV4eHF4Zmhyc1FnWndQQlpIdHU2NnA3WjFmWFd2?=
 =?utf-8?B?RDdiV0ttOVBUR2NLKzlVRmg4UzBDc1ZIN241OGNOcXNCTEo0VlYxYUJLSFlV?=
 =?utf-8?B?cUdzeFZ0QmhHNUlmY0F6ay9aQVZOamZ0Q2dmZ2hzbmN0SmlLTjcyaHFGekls?=
 =?utf-8?B?MFNCeEhWT01LS3QweTA2ZFZEQXdwYmk3V3R6TDRJTGtSaG9uLzNwVGNKQlVr?=
 =?utf-8?B?S3RiYktvTFV3d0tzQ2dkUGRRRktlM2d2TlBkOFN4eE9GTEsvNjd0SkU3Q2hn?=
 =?utf-8?B?TmpkSWllY20xUmdldHJ2VXpLS0p5SUMyTzlLS1FNYkl6NUdhd21yaGgzWnZP?=
 =?utf-8?B?aDRmQ1V1RHpNV0N2d0ZONXFJN01oZ2pUTTJaTTdka2NBSnFqTmEwRmIrdE02?=
 =?utf-8?B?Sm1UQnJXYUdVU1pXNHhyU1kzc1JaUUJiWWtZeVRQY21tV0J0M1RkM0NBTmhp?=
 =?utf-8?B?TVRLRHFSUFhMbWJIUzU2QktYQjREdlA5eXR2ZHI0MmZBVDhEbXBiQ2NPRFpL?=
 =?utf-8?B?Q2I2aVgyWExXQlFtK1BYWEQ5b202ZE85WGd2SzROK0N2WCtkVjR2ZWlHVS9k?=
 =?utf-8?B?bUhCTVRxa1NheEx2eVQ3TXdyeDVJbWQxZVpVU2IzRXZPRTErZHJhNXQ3RVYx?=
 =?utf-8?B?WXRNSFFaN2ErY2tEbGNIZnBBU0RMc3ZSYmtZQTVaRkF6TnlaaWxLWHo0d21w?=
 =?utf-8?B?ci9oKysweitBOGpJZG5taEd5YUdhcmYwWldHN0VPYmYyNm9kUHNmT1Z3SjJx?=
 =?utf-8?B?bE1RSjY0RGo2VzV5ZnU3U1VBSGl2NHY5NVE4TldFQ0NBMkRLUkN5bFBuT3k1?=
 =?utf-8?B?MmdNL29iZ3dOM2FrUWh1a2VKdmZSUjdMVGExOWs3THFnWjBBcDlQZFRoYUk3?=
 =?utf-8?B?WldBcW9EOTRHdVhHa2lpdmFMbklWK1RONkRVb3BMcTRhTzdsMTY3L1hjbzBB?=
 =?utf-8?B?QmNuOTZWSHlHa1BtbkhtdG5zRlpiZHcrT3FRYXY5THZzeUM4cVRiSXI2U2g0?=
 =?utf-8?B?b3I2cnFxeUVTaUsreUpJSlJ0UlVuR0VpSXNVRWV3bXQ5Wmwzc1B6dmtjSXhD?=
 =?utf-8?B?VmNSUXU5K0p0K1dHeXV0a2VFWWFnSUthTTlJWFBZTXU5MDJTTUYvR2lRSWhx?=
 =?utf-8?B?UGVabmY0Nm1KMlpRY1VibG13Ri9hT3pmT2hSSlpwTjMxTFNZTCtLSGN3WGMx?=
 =?utf-8?B?WjZJWlJrMUVCU09SU1A1d2JNNHhlQS80YUkwbEVJZ0NlS3IrQUN2My9IeWdZ?=
 =?utf-8?B?UWRvVHYxZldDQjlmZDBNalBQQXhXL3MrZ3FqYzVWTHJyRmhKS1V2UkZNUWhw?=
 =?utf-8?B?dlcxK09vNTFIOSthdnU2WDZ1aUswUWs1N2RSUjRRUGFNckxKaFZNVkpsTGpz?=
 =?utf-8?B?MHJjTlUrS1FXT055eXN5OTJOclhBaEI3cEJRUkwwRVNLSmFJSlA3SUEwWGg2?=
 =?utf-8?B?Z0dyeFhMVmloY0VXU29qMHhUWWoyK1ZmTkFEQzBMK3JmYStMRTF5VXdBWlRR?=
 =?utf-8?B?M3lKMGg5KzUwMjkvR1MvNzBzUzU1eC9JRmttK3N6NHpHUzRiZHVzQmlyUU5a?=
 =?utf-8?B?SXUvN0pURW0zdm9tTllkVVo1b2R2M1ptZHM5cW04dDZ6NGF3dWdsK1NsN0M3?=
 =?utf-8?B?SE0zT0tVYThZUkd3RS8ybXBiRkpCcFdaNlpqMG1BbkF2bURJbERON3VrR3dy?=
 =?utf-8?B?MXhKMDR2R0kvamZneDhRckJCcC9kcmMvM2NRQTdEamRKVFZnc3QvK1djbjZ0?=
 =?utf-8?B?VVcyZXhNS0p3cXRwUFh6NnVCQzY5Y3dVTGo5WTYwRzdQQ0VNc2hJWXFQZ0M4?=
 =?utf-8?B?SGQ4ZGk5V2twcUt3cE9LUWVTS0RCK1IxbnRCNURPUTFiRGVZTmp1OVZuZ090?=
 =?utf-8?B?UXMwV29aLzV4ZG43b3JzKzVrSWRpYmtIRU9YeklWUnIwUHhlL0VzQ1hpeDJz?=
 =?utf-8?B?aEF4bzdzM29tTHFqQ1pCdUVQaVJNbE54T1NDdG9YNG9Kb2JrcVNMaTNNdmg5?=
 =?utf-8?B?SVBTWlNjV292VGdreGw1d2R0ZTdGaHJHSFVEQndqMGMwQ1oxRGo3YWtmNTFk?=
 =?utf-8?B?ajhvV0g3WTZJUCtPTnZNNkhjeDhaY2RBSGJ1RWw3Um5FMU9vM2txN3M0VmN5?=
 =?utf-8?B?WmVWTG9IOWMzaEI5eWdOb3YvdE5xREZFMWRvMFJ4aXN4R1Z2OUJSZWlxejZP?=
 =?utf-8?B?ZjNoUFV2QXdmeFhRYU9lWm5aa3N2UUtwNHlsVXZxTDJZSEY5WW9NeFJrMlNF?=
 =?utf-8?Q?SBdAvQpdndO+Q5TEEk/SBEkoBpsdMiDrn1y9W9yvuI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <146AD3480B6F124B9DCDA03155E5DABA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7c78a4-5afa-4a65-e2d3-08dab59f2a18
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 09:07:23.6411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +IxrBhwCLFmiIkOC11hd3BczqzPQnI++HAp9A/WpbRJR/3/K3O1H1GZ8dhBve7wOhBQ5dWW/JzvtQ1GHWnLw8hNtw2fz2nw1sS47yxzmIsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0338
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMjQuMTAuMjIgMTA6MjAsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiBPbiAyMDIyLzEw
LzI0IDE2OjEyLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+PiBEYXZpZCwgd2hhdCdzIHlv
dXIgcGxhbiB0byBwcm9ncmVzcyB3aXRoIHRoaXMgc2VyaWVzPw0KPj4NCj4gDQo+IEluaXRpYWxs
eSBEYXZpZCB3YW50cyBtZSB0byBkbyBzb21lIGZpeHVwIGluIG15IHNwYXJlIHRpbWUsIGJ1dCBJ
IGtub3cNCj4geW91ciBSU1QgZmVhdHVyZSBpcyBkZXBlbmRpbmcgb24gdGhpcy4NCj4gDQo+IElm
IHlvdSdyZSB1cmdlbnQgb24gdGhpcyBzZXJpZXMsIEkgZ3Vlc3MgSSBjYW4gcHV0IGl0IHdpdGgg
bW9yZSBwcmlvcml0eS4NCg0KV2hhdCdzIHRoZSBmaXh1cHMgbmVlZGVkIHRoZXJlPyBJIGhhdmVu
J3Qgc2VlbiBhIG1haWwgZnJvbSBEYXZpZCBhYm91dCBpdC4NCg0KSSd2ZSBxdWlja2x5IHNraW1t
ZWQgb3ZlciB0aGUgY29tbWVudHMgYW5kIGl0IHNlZW1zIGxpa2UgSm9zZWYgaXMgbW9zdGx5IGZp
bmUNCndpdGggaXQuDQoNCkkgY2FuIGNvbnRpbnVlIHdvcmtpbmcgb24gaXQgYXMgd2VsbCwgYnV0
IGFzIHRoaXMgc2VyaWVzIGNvbnRhaW5zIGNvZGUgZnJvbSBib3RoDQp5b3UgYW5kIENocmlzdG9w
aCBJIGRvbid0IHRoaW5rIEkgc2hvdWxkIGJlIHRoZSAzcmQgcGVyc29uIHdvcmtpbmcgb24gaXQu
DQoNCkJ1dCBpZiBpdCdzIG5lZWRlZCwgSSBjYW4gb2YgY2F1c2UgZG8uDQoNCkJ5dGUsDQoJSm9o
YW5uZXMNCg==
