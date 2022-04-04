Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553C34F0FBB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 09:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377582AbiDDHHi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 03:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiDDHHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:07:37 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF123298D;
        Mon,  4 Apr 2022 00:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649055942; x=1680591942;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=wkRZT2qOV9RnaNK5nQolrFcskWRAVCYFdOooolHYlSg=;
  b=AHE4VLV8R2q3OOHIHpLfArLkTEfQC/IbpTmeiaN876JvHhhz7crqSNgH
   iq2IY/ABvMme77R0Y7dVsHA6tIMU2V63zRXsEOCmnSfM49kTx5HZOgYK1
   Ktci/Iu1BwmhX0BhrPCV3GHDTzBxAW79KGEFszZ1u+H80bA/9EKrBeWrc
   1sqHM8N+X+IX7idCS9x46ozNkk7PQ5qNp2Vplc9Pb3wWhCjLsFp9Qfr/N
   0YMlzTOY9WSJgermHLJOu8R7uEquRGU5kFN8XmE2/Nw7PbBAJwINPzRij
   8DF5reU8AxzxZPiBH+PxabsUxEKdW1RoorOVrIc+a7EhEkrRdX06/tGrR
   g==;
X-IronPort-AV: E=Sophos;i="5.90,233,1643644800"; 
   d="scan'208";a="195885419"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2022 15:05:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcgsSsEWKEWTvPFiGYVMp3ftfy7bYsnmN8jsl6trWeH0QxAriwbg18iPQqcCEexJfzAlJe1dblfmsu666kgFiX3oOwaO8lX0ZB4lKi8qD3KBkwejlJUK9hg3fCS51W2JW7XuaLcNDgRm684hOn9MfdRU6dN0BJDbI7x1N9z9/abXyfnZ78OxHgbQKzHP7OwxxCDPmJVLKer8JHJTlekHKEiiCOyRyRomhz1uxqEr1tzf8OImTbklOICHZ1NXuQ0FKTaCH8s0dG8caa3f8hR+L65qXJWwi1Zs+0eRPuO4FX+UodXkTahsFF+8PComy3HvuWy8LY7tMga8HKCIw2yeTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkRZT2qOV9RnaNK5nQolrFcskWRAVCYFdOooolHYlSg=;
 b=KTLUC5u7uIM5Q0TrT61aMvd6CPOSrKDfGcQLgZWdi6H2+NxoJVtaKhMCEUVAT3kixOf+2jX/sX71lb1O2oUSM5GZBvOHS6MnMJqg2v/Su4ADZAGq7Ugz2SknKTuqP1OAZlaDsbnnum7q47Z+fzoTP+Gz/Vo+Ylti5Djgwb4THNSIGqFWwmMENcyqas3Jmr11jYUiN7vqlogW9gXZaGWO/ua9dZgoROKQbr3S4R1Yp23oRVtxrTuZ3btCp+atxJGso4ab2ePgmcA/yTGr0LdjoYrUtxSQju9amTsFAuXZfa7G1zO9pL9zBnTuiNAmwqDiEm6KY3xcn93WyH5dYZvIeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkRZT2qOV9RnaNK5nQolrFcskWRAVCYFdOooolHYlSg=;
 b=XIXDcry8wJk3h+NoTl9E5t3OJL+PfGQfKsZouWe0qcXXGEm4OndeCFMclXPPzziZZiaOICVXT2pe7xk+kcvqQohfmwEllPsDWGf5+WhdIZbdL3XgY1TmUpPkjUdcfpb3CG5HeWKgyLngGalTjevinalZagaHnuaOesliFcBQ0Ng=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR04MB0336.namprd04.prod.outlook.com (2603:10b6:300:c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 07:05:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 07:05:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 08/12] btrfs: pass a block_device to btrfs_bio_clone
Thread-Topic: [PATCH 08/12] btrfs: pass a block_device to btrfs_bio_clone
Thread-Index: AQHYR972QezStfo38E+cMLogodCdMA==
Date:   Mon, 4 Apr 2022 07:05:38 +0000
Message-ID: <PH0PR04MB74169A7FEDD5C747CC7B1ACF9BE59@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220404044528.71167-1-hch@lst.de>
 <20220404044528.71167-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a482105-f467-4055-1a24-08da160985c7
x-ms-traffictypediagnostic: MWHPR04MB0336:EE_
x-microsoft-antispam-prvs: <MWHPR04MB03367E3B00B4983E2FD076D39BE59@MWHPR04MB0336.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 308dB8myBTCukLVDDRdUeka3bH6dwE/2X6uj/RlSEM3w1hOE4OANIR+qdO1a8auRXKOAGIiz5Y0Bi2caun4kdODqRJmuACuBvhc49t1tT2Ve4/GZuHPuvs07Kioel6UfYcSstv6JqocCRAycttzhGwZkASYvmDmu9Otzy8Q48xSjHR5QNwy5ucMMy2p99kOtUtw15L99/wUYS9dwrBhP4VXiI52ehc7HqLMya6Km86mYcs325b5WFiVe4nxuv4xShzdQBUHiF6rHbZ3kNM9D9/lcLWGJZu3QokUfaycdTOjKUeuy0nlvXKkcgCGWJ8diJxae+3J6DDfgsuWG5JquSltg2nh/k4I9kudCzAmx4QWsg+YbNN/o7e9bd8u0zh6fkTepiWpfKZjUT4teCpaUo2Izily/1t02jKUPPu7DKaU2SHkR4bjbYb+FIONOZLh0FnIzV5yqFJ6dTjMWwzb55LUZKLx+JJc+xnr04wlK4ehn2lQbOGzuhJtSJR2tzi7FXTeqSN1GttkpKjyFadPH6DBxxgd/rk7ILoR4y4Iq9ceg3Ee4yhvC7IdiME+yAMOlvNhgsWwUd1ruKvyuicSfGBQeg1nPD0xrO1Jxx5PQwVUb+ltLMRx0zOCWrlcketFqIuIwZ9dfFg+EveUQ8DfzX3qfVBeI1KDrAxubbKo7Hqo+RDocctOONLAmb7xl63PPQwzM+CiXjAfO0SNIkEY3mQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(66946007)(66556008)(66476007)(54906003)(91956017)(110136005)(82960400001)(4326008)(8676002)(66446008)(76116006)(508600001)(83380400001)(186003)(316002)(9686003)(53546011)(7696005)(6506007)(38100700002)(64756008)(122000001)(2906002)(71200400001)(52536014)(86362001)(33656002)(5660300002)(558084003)(55016003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tFP/F1NyonBdLXU6wfjP5FLkKj08EP7DHKRkkwE438g5VDa8oXavCUfiN3ao?=
 =?us-ascii?Q?ueSTyxOaTAwGvvxTVFdFTSPCmp1tMjnMad108hu1z3UpByDs9NVGz5hg7rZP?=
 =?us-ascii?Q?eBPqo5baKZ2eoHRskCmYhAbAg6l9xscquzzhddY2RsoEHE1z8DyUC3plMA5V?=
 =?us-ascii?Q?Vx8NZyovyMp8EUdI8YEQ7a89urh4GNlw3KFL7n0uaxgnoQL/ShPR3invSlSi?=
 =?us-ascii?Q?5py1yyRDD5yK3Cfk8/yb+yOHuJeG3Zt7EdaO/TdMWfsSYtzCEMTcsqv6TB+e?=
 =?us-ascii?Q?a3BXSWIehgi+BiN/Lg0kqsPl4rRcYehp1hb6hks4vgJwYVumx6KFHS/9v4vn?=
 =?us-ascii?Q?tQKRozzB3CPsoonX595o3V6lHIOD87oKfK3Qdn9RssqgJXNUKFCC8JCy5OWT?=
 =?us-ascii?Q?k9SLkliDkvyOg0rWMDDy027451l3qOUr8mrZx4exD4bygxZb+C8MR70FaksV?=
 =?us-ascii?Q?Uzys5dnhTrKQGFGe9QvloXQbhGKewNWsNv3SbvahSh3gEKt4e2p3VDhow1FC?=
 =?us-ascii?Q?4445UQyTuZnHS7e/VMV6Mk+D0furttp8s3hPAGs8puD0uwcUlrf78w9BKUYD?=
 =?us-ascii?Q?GMIea6eO8FPFiy7BbTUbrCuKA9ktxY5G/uVRwa3tUZB8feLuaMnspQQTxbT4?=
 =?us-ascii?Q?BDgAtWtayFg7FSYS4FwO3QJ0bqZBjrbguZIapt0C5cSuVNpnUC/Qk1KTTga1?=
 =?us-ascii?Q?kfMqcA2mRUqwEKYMxJVM2dL5bADcxVWLgLTHrPB7WitcdGePOeMA1EZ8m5rO?=
 =?us-ascii?Q?Ep4OZVCZ7TF6T4qbOgA0IYP0ZhuTX5fVHi5cL3/NFwNfLU5Yt9Nih1HbaT1r?=
 =?us-ascii?Q?tPwpHaPjS0M1S4idfmEI2aRf35JdeLCLH6e322KzVZIPwG/L2kQrmPuDV65O?=
 =?us-ascii?Q?g5RdYO+pLgdvNrQhHAIJhtO25VKiyWto+MAe4+cnniTBhBnIZESkvleDVAud?=
 =?us-ascii?Q?wneH98jzWqlJ7NPaMSK3F5jqXerzZ7kY92tWr87M4hOrbe6lnJXYfQTygDwH?=
 =?us-ascii?Q?VYivftXKxTeE7HNLqcqlVv+KoiH2hgMt0rcah6Rhcgoa5jLKCfZppPT41NZ9?=
 =?us-ascii?Q?sbulTLeAZfjCuf+N4kIrpc+5GgEp34VTFuMLrn4SqvlsRI9zr3KjiOjqCe12?=
 =?us-ascii?Q?neJumeeZtEOoC9D4CJR94YIQIQCpM/eqM0yCGTUbNDSR65sxsKIzsWg33Xi4?=
 =?us-ascii?Q?G3tDpeC5K8XM3Xxe7FUIxWVgZti/GV7lHnPm7hT2sBuVervUsfq1/x7SHP/c?=
 =?us-ascii?Q?kqnli5W+SjnFy4VFZlAKWJAmsfQWYrvwHPOEBSFtj3at6/QPLtO0OsUGEWv2?=
 =?us-ascii?Q?KvlIMwHNKtabuc1jKJUAxRW5xlIujej8075HtxLpZvopv8mgNAJSNzxriDGZ?=
 =?us-ascii?Q?8vASkj5LcBuNFpWnFv0g1UbBpPz48trRmr3GHF25CLVoMnPZVxfkci3D/WLv?=
 =?us-ascii?Q?N5CP42oGWw723AmM1P5iSrgImAlB786xl//tImn6VwrQcfS/sjkBelA+2QWH?=
 =?us-ascii?Q?zMGclvKiUn0aFilXkrOJS96lMh2tKPZk5fpjyVhH5/6mbM+b0r9zBjdOJNpw?=
 =?us-ascii?Q?UXphJRd4v7Q17yHhYCj1+j29SsUmOrHeamfglrj6z0DEdyWNWIfwNna77n3f?=
 =?us-ascii?Q?xVtMwF0sUeGL6935X88kMWcH9IQtJ7GNRmc8tpNzRKBsnOHXDc73/CZIX4ai?=
 =?us-ascii?Q?pFPXGaWFxQrODzgaOS3aQ3Vvftz/8YzwW7nCzvJiL2ImrYPKVlFQ5NeIG32+?=
 =?us-ascii?Q?txUk3UXt3qkp9J5l4/l8mulTAz1AiArDqrNh4z1Hdhmy5bNVwAjvNaJl1bp0?=
x-ms-exchange-antispam-messagedata-1: 3xGpY2DUYMiYWPJ+l0SqCU100iWxufu+6hVTW6EaYgKyEOcW4JsfhS5t
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a482105-f467-4055-1a24-08da160985c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 07:05:38.0031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZcc89V+2VbnfcUFzh7/OwlqNjH/TxN4DrftgkWVzRoUBn+cwCRZZRowDAoEMeYEEg4nq+Or0wrCb/X7NM4PYxxc1M2850RJEphnWtIJ/fA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0336
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/04/2022 06:46, Christoph Hellwig wrote:=0A=
> Pass the block_device to bio_alloc_clone instead of setting it later.=0A=
=0A=
s/bio_alloc_clone/btrfs_bio_clone=0A=
