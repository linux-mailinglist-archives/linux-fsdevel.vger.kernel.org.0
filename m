Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BFB609C26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 10:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJXIMh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 04:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJXIMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:12:34 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2AD3D596;
        Mon, 24 Oct 2022 01:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666599153; x=1698135153;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mnrUcCTlXFQOTBphbM7uzgjEgZvswdf1qz1O51iiFN0=;
  b=EQqzpxJHhOHsAG/D6oeHAQCseyJCs9fP8KXsZGUpOq+dQ+D251nnxCum
   vDKPMygcCHTcxGPCubSpJ3Q7V+afSaqqYTpK231n3ElOwUhEv+b3tt/VF
   7EzvB/NKw/YyfGPcxG7NVaU6+bMFGB9SHv/PkoI9QXvCslObL5a4dT+8b
   pSvfwnnjQ932AfBBUPBY7RPPO7DOQXVcZyj/JxM80caQwdYOkHoxQK2nz
   8+fBLBb7bM/0IA+AkBqP3iySBiblYR+KB9lcdfZfP3PV9OLfHRd2Bf0Hl
   RxXWqdrzon4n7J+VBLBz+M3u2tssNpCKMfZ6wAMqPMPRwuNvbGW1GCHsb
   g==;
X-IronPort-AV: E=Sophos;i="5.95,207,1661788800"; 
   d="scan'208";a="214951588"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2022 16:12:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/vi7f8E/9NVSyufo1QeKoj+gkeVBuDDimsQRyta4eAPdT011ZygsXAehmyGzKNUw7Usq5pLkImX5u22TroeCVmcEAQ12h1khgSixmFUL8W4m7EAK606dIjF99Ar7YGpM5tA3gZD/S7z2Hv039QLH1KA243g/pqNEmDnwydmCKqwOCvpGTzjQEwVdMD1wd8oOhUZ63y1uOdGscd3d6x0qMRy+ilMl3wwmnRDun+QkFKkM6zk46rDzNJ0Azm6ptT0hjMGMQRB6tS+Ep9Os6PmziYZoFpFjvsxCz/YnqBn0wVTM/K+YYJYD61ANI3Hs6KCcZloklfIW0595/oET/kiHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnrUcCTlXFQOTBphbM7uzgjEgZvswdf1qz1O51iiFN0=;
 b=SeJ3V3UlKqc+p/JroHc0aXcexSiVKNhfYs3MlXXQNgoOrCTEwvcvfQzS6k5K8o5tK8O3p92IMPhNrNSRBKAArx4/rzHgx1qa91/OJgoX+PgCjNIQxJz98Q5cfJJKSdelBGrYc7BKlM/hy4Ta/Pq58WYlw00HLvQbivzD9usWI69Hty8oJBsGQA3iAMDWXOprXeX5XcFprX06NjJ+A0CPOtDi6JJDyzEJ5akXEqWPdMNVjE6y0+cENn6qQ1WU4o74v+ek9B52BkTIkQZTJqwm+2MMReG2uECX/ySGEcjoEdHyZZH4mvAh7Hbao0U2xA/WjvpsXIEBZr+bAzdl6yOMog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnrUcCTlXFQOTBphbM7uzgjEgZvswdf1qz1O51iiFN0=;
 b=Jmaa/muP0HuG4nPDGVMKZnbhXsNx9ZCx2ZitVgZl5I74d2+NBQRKPXppPvUZEXJUhBF8kysxIvrUUZUP+/mhhHGYel4Omc5t8TPS2xT68CVOgWI9jLKU6xq22csBsW9PXwFdiceHOdZlI3aqsHX/asvTPysHZLbZqmqbSIBE4ZI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB7080.namprd04.prod.outlook.com (2603:10b6:610:9f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 08:12:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.038; Mon, 24 Oct 2022
 08:12:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
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
Thread-Index: AQHYvdZkzfjbXHDoM0mHBIw1hzgYgK4dhQkA
Date:   Mon, 24 Oct 2022 08:12:29 +0000
Message-ID: <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
References: <20220901074216.1849941-1-hch@lst.de>
In-Reply-To: <20220901074216.1849941-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB7080:EE_
x-ms-office365-filtering-correlation-id: 2e1c8104-3762-43d2-b6e6-08dab5977e5c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ndLMQQC1/bA6D/27rQPCvu+KWGUEFgHamnbK0MJVHt+vDo9EVfSFwY3jyaH3FrTA08F1mOUjFpKWhW4eXRiOeJi4E3qPFiOlnfivyBYxC+FhJ/UMiJ3qDgW9ZBWF5TA5HxIlHrxG5yE4+z2giJiy9IrPKbVMqGZHGCOZVO+ovLiDfakYqBFGB6awRlkvAJq3YLlDhS8rzGQAKZJVeCfeiHS1zBbo/rCGweMqEpd+lLOoTplADVLoOu3w1XHobv0l/1uSY7da3ejZvXGpwZIbUz3zu7Uyi8YjYolrMxD+i/wpbSX5410JT4BUd/Zi57ePrSFCgP9FV/pN8pyCu2ddt4OyLxjDBWl63XMc8ZctTOH5C7mWTJnnIt+0+LqgKrAO9ElkMOY8GV0YuvBJcpQEjPuKKRwKAy8z15w7HBL516OGOpdVkygPYo/ubwRvlopPM+kN1bIXb8J/GbFLCSaaLiJvmzNIjwNFBVEZ3+2d8lUWH88RnrRXr2A8xMeCAWJyS9MraWbwVK2btpx5VnpvNAKubK5mRQxd1BQmYFVrkoOgPuZktPZ20N8e0dgfTAqWyXgfysmUb2yRe92YzepRx2tbPJjDDlPzpT+sdODy7+zdMBctp1OrXPo+LmABPglr9lKrQC9urGvQKWHAqJvP3XZ/rC8LWhYRhfE4jWYbmfZLuwaIL2hUAB5XjtL7Ey500CP83+DtsE0eS9YwF6/W9L/jV1Ih08Xzz2VT58nE997neU+juqG1gduKe8q87INFaecRopFF6htY8sCZyaoPzEViYpDk0Cj69Y3mzXTCNd5YWP3piegCekhYO+dsfxkPwzq3KRzRtvg80KldXasUCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199015)(2616005)(31686004)(38070700005)(186003)(4270600006)(38100700002)(6512007)(82960400001)(6506007)(41300700001)(31696002)(316002)(86362001)(19618925003)(122000001)(8936002)(5660300002)(2906002)(7416002)(76116006)(71200400001)(36756003)(110136005)(54906003)(4326008)(478600001)(6486002)(558084003)(66476007)(91956017)(66946007)(8676002)(64756008)(66556008)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFJpYjBKZUhoRzI2R3dySmtRcjJveFhybWZuNFVSYUVwMXBWY1FJRTRlMGxl?=
 =?utf-8?B?VDFOb2M3ajZvbkVabzM0ZjV1TEVwUUFUN0t5NkhyalFNTk5RcHNRdHExdVhl?=
 =?utf-8?B?UWF0TGZMdEJEdkUwWmNBbUM2MjhmVnlnaHJsMmRhQWQ0WmRVRzlFalVMRm9S?=
 =?utf-8?B?WXFHdnZiSEU0NDJrd2hqYWV4dE1TS1o2TjMzRU4ybWh6Skg5VFdPdVNiUlFk?=
 =?utf-8?B?MUxvbE9aT29jM21vMkxTNHRWTDdwdnhQZ2FnaGYwR3VWQU12a3drNkhMMks0?=
 =?utf-8?B?OWtUNmcycHJ0Vy9HMFhZMjA3QUFETmQxRlcyY0VUSUZQVVJvM0YrRjk0VHJh?=
 =?utf-8?B?c2doY1gxK09IaTdrKzRTeVFIN1FJRDJHbXRaZ1lVcC9tQW9KVUdtakxqbmlP?=
 =?utf-8?B?eFhaTEd4RnJ0OWNOejVwWlQ1a3RKSXpQWDdCV2tQZDhJYktYd2N5bi9RZjdN?=
 =?utf-8?B?UndBdnZSS2lwWTV4Zm1tOVNVR1lseC9Bc3duS0N3bTdKbFA4K3B4MGF6V1RK?=
 =?utf-8?B?Y0sySExkU3kwQVNYQy9lVElMMnBHNlU1cHRQRU1QYVpSKytlNGFUK3Z2L29w?=
 =?utf-8?B?RTBPT3lSdk5ZUVd6MnZQWUQwbkFnTG04ZEhlNk9tRDNYTVhPbmVHaEgzRVJl?=
 =?utf-8?B?MmZyc1NLRjd2V0dEUkNKb09TNC9ydGlyNWlCY3VSMXl0aitra0VSbDR0MlFR?=
 =?utf-8?B?MWZXSEtPZUcrRTNmTUt4T3A2ajFxMTVmQUFYMjVMcFVTbFBVWncvVXRjUytQ?=
 =?utf-8?B?WWZhUFliVG9FU01GNXNNa0MrS01sb00vWkhIYVdCVTIyYWdkaHhHN3VDSUVk?=
 =?utf-8?B?L2wxelowU3RjNVk2d2hwcWxOOUd3MnhRUFdHR0VnQ2hNM3QxRWoxbVFmUnhE?=
 =?utf-8?B?VHZOd2w3STY1eUNnbVZtRjI1MjArVjBRZXdVUjhMRUYycTRoOHFQeFE2dVhV?=
 =?utf-8?B?S2VTMEdGL1B6QjlIWXJYa3krMlRubFh3L3VVLzFpSkNwbTBBM0YzUWozTkhi?=
 =?utf-8?B?MGZ2WlRQemNHQ3ZFbS9OZjBVZS93ZGErQmpmeUVmUmFaVm5zSDlFN1l2OFcx?=
 =?utf-8?B?NnJ2RFhVNEhXOHhIRURSZy9BeEhpWm9YTEZPazlwK3pVOGxFb0dsMlMwbEZ6?=
 =?utf-8?B?Tlgwc0pOdUhCbmtkbVU0bUtIL0liOUJldDNkcWVYa2s0RW10Mko0T3hhbWdD?=
 =?utf-8?B?WjFvMmcxUTY5YjZMOEU5eGpuOXdUUUc5Qk5MYU5pVnJPalFtOWpGaGdrZjZH?=
 =?utf-8?B?TUtZWDVjNlF0VTEvbUc4aDhrQXBsbFF2TGsyY1ZJVlkyWi9pV1k1cHBOand2?=
 =?utf-8?B?dDhGWkZvejJQdDJEcVIrYXhUbHBydFpIb0hwZ1R0cm1MaS9HWis5OW1ibUZu?=
 =?utf-8?B?OTAxSTZLcFA4UEpndDAya1Voam9vLzFvRjlMYjJtWSt3THp4UW1oT09vMnRk?=
 =?utf-8?B?d3JVazhRNWRBaW5sZUhYSk8vQ1pDeDdEQ2plb2hWT3oycGQycS9sajJBTzBz?=
 =?utf-8?B?REpiM204Z21LMXJ0R1QvRFc4cUVLeUxZVmhsK0RTUG11U0J1VzliWWljUWc3?=
 =?utf-8?B?M3hrODBSWURaWEFuRE1LcFhlT3JCVmowalZFSWdnWWZQOEdYSmlpNTBhWVFE?=
 =?utf-8?B?RHlkdUNtQU1DQlVrQlgvdjNDd1dsOEVZMjdoTkRBN1FEeUp4N2xibGNBeGRO?=
 =?utf-8?B?MUlseTdMMzhQdVd1QWZjbVVXY2s4RjcyY2RPU1NHT2JML1Y3aXJKRVBsOHpB?=
 =?utf-8?B?aVdINVRBQUxUWDJzbS8yZlRrdWF6NWRvOXNvTDAxTXc2UnRmd202Y1M0YjFS?=
 =?utf-8?B?TEF4OFNTRDB1UmVoRUUzbUNwVzZWakRoUWlFUVVtSmFOM3dMOWRrU3lING9U?=
 =?utf-8?B?RjR3ZkhiK2FjSEJ4aUMrQllKTzRMcjc2S21IbEpPM3lHeEh5UlRLS2pkSXVE?=
 =?utf-8?B?TWdNUitCc3hHWVBTNmNURzczcGRLQUNlWjZJd2FFM016RGxYWjllMWlWUFVB?=
 =?utf-8?B?czVrL293enhza0k5bzJFTmdDNDh4ZXFhMnlHdmFEdXB6UC92Nk1rclVyekFO?=
 =?utf-8?B?d3FkTDFMUDdDNEQvVk1hVCtCMUN3NEw2S2hPNEtkMDJWeVZQWkZUNjZPclVs?=
 =?utf-8?B?enJOdUpFWVFNUXgvRUhLc0phcU1wam1jaGRVYnRnTXNIRzZwRnNQTFpxbzFa?=
 =?utf-8?B?anJTVnNubFY4cGtmZHFmQWp5b1JpeWdJeWE2WXhFd0p2UXZDbDV4NXg5cTJy?=
 =?utf-8?Q?OelKEkWPPxXE6iFNvlxBSb/gUGxS3XTjQS3P3u/L00=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69C0F58BD6F88B498F825DC5759E5C70@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1c8104-3762-43d2-b6e6-08dab5977e5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 08:12:29.0416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2spsvQctSeydH6X5UbBN/b5orrArTZdKeoSDA+5ssirpfF/gcjvQAnP89vtGZjk5do+NHXCv3x+EIEWaZkRrlT9blJPOD/OU8pLZgDkbqFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7080
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RGF2aWQsIHdoYXQncyB5b3VyIHBsYW4gdG8gcHJvZ3Jlc3Mgd2l0aCB0aGlzIHNlcmllcz8NCg0K
