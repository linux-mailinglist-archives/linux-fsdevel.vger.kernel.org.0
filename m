Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029BD4A4642
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 12:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377424AbiAaLvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 06:51:36 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24437 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377151AbiAaLtc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643629771; x=1675165771;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZqRDfmeC7gSqlp2AvRocSOZwLJK1Ix8VOc+4HY0faIQ=;
  b=BzvkPJr6SkTnmaMYkPifyAnlg0Hsf+aMs4zd5Q2Rhq1KpLHIcS+mJDLC
   aEpyBMyQFlxxx/EmAllM4LTGW1SDCXpKDp2Hd/syB+JxF8Xpj9J8rMtmI
   e6o8cb0YB5anFuW7LR3DjvfdugGRe0BpNGXjoEWvJ2mGexovkQ7IWDU9J
   VAbEEpsOhAK7WmncYvZsTpehEtUGfZ8yPRNUQNcKVzAZlmieFd2qGuo5A
   jsdeXKlOP5TeK4np03hkSlax8wktp165U8SO2ZI3XPmpdxDEmhkKlVzZA
   Qg9uqT6UpbCkINjwaaofUT3eFu4h669HJ3V2ts3ysL+t8/HGj0U+w5SXA
   g==;
X-IronPort-AV: E=Sophos;i="5.88,330,1635177600"; 
   d="scan'208";a="191798219"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2022 19:49:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiqTBnJJ2rtjBnVwcR357iV7NU4/lP8Klhqt4iAzC1KID03Jrm/lhryw3j2hFv+tSFjRn9qt0ynmCXC69td9TwOg4LB1mqO+Jc0ZYrop7sn235hwmrFi2Yt1D/cqoZXm4EMdhFFm45aX0REjoizSnBTV5zMImUBMbbBkHQN7oMra1YxRv6WVMoVNsFpkm1OOLeX+KIdOs3Lh+/Jg97cXqxkZovKyWbfLBtPyDHsPuN4m26fb5XVor3KAL3Wlm0/l50qTX8yYAH4z37KreX2k5KMyt4E5jjXzE3BiTVyye+j1azfTq6/hhDiTm8sGoLzZqUjmf6De6QqjmH13elaJkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqRDfmeC7gSqlp2AvRocSOZwLJK1Ix8VOc+4HY0faIQ=;
 b=dMguEMtBclVQrQlIjVstp3egpI8V9ZJffvk65MVSyO9FJXhfjdgyZ8zQ7UIHC38EYa23Iznx18DqokDvacR2pVSQ2gHQY4nKRhFzkqMx3RODfvl8oQSFa9li2k07shgGqy6NAHmJjwLLGQa5jw7sDl8hgSLxy8tPBM42qQTIBxXCNh3D7gdSiEfcbFLls65NPEZLpoSaDSNlvcLS2sdEHpH3y25mKzBL0no1ydgf2QK/R7qfrPDtZOG+GAV8VSkjSzEGBAdaa3tbqLfeGoKeDnTzajZZzm3xZdpXo9nxLmUY6KPRc1FBu8BAfpzd/GWwSxGUrjyS74s2Mf+rYDDFaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqRDfmeC7gSqlp2AvRocSOZwLJK1Ix8VOc+4HY0faIQ=;
 b=FXT6Yjm0bmzGnmbHG4Sdcy/uJ0f2kb/XUE3K7zqx9YA5lbDlrA/KnvRs0JLXZ2d4pRAr4nIJClU+nFtRQpY0ck/dFCYlVP2BqgEQI7KCbqk6REfM6AbQb8BJYxbgZ8tXmlaYju3wNIYUuLhi2bAUNuNQ01LTLMOvmenxe5gpbzQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB5504.namprd04.prod.outlook.com (2603:10b6:208:df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Mon, 31 Jan
 2022 11:49:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%5]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 11:49:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
CC:     "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mpatocka@redhat.com" <mpatocka@redhat.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "msnitzer@redhat.com" <msnitzer@redhat.com>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "hch@lst.de" <hch@lst.de>, "hare@suse.de" <hare@suse.de>,
        "roland@purestorage.com" <roland@purestorage.com>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jack@suse.com" <jack@suse.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Topic: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Index: AQHYE018isCsN3oz40OdcqzMcXhV7qx5YsQAgAOn04A=
Date:   Mon, 31 Jan 2022 11:49:28 +0000
Message-ID: <69241add19fddd4168c9f2ae15fd08e8e701f8ec.camel@wdc.com>
References: <CGME20220127071544uscas1p2f70f4d2509f3ebd574b7ed746d3fa551@uscas1p2.samsung.com>
         <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
         <20220128195956.GA287797@bgt-140510-bm01>
In-Reply-To: <20220128195956.GA287797@bgt-140510-bm01>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.3 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0ff18da-5e0f-4426-bea0-08d9e4afbc83
x-ms-traffictypediagnostic: MN2PR04MB5504:EE_
x-microsoft-antispam-prvs: <MN2PR04MB5504CDC48A827E32C76F7C279B259@MN2PR04MB5504.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LIHDYYF+rdDLpnzdS3fsShR8EgtehxgMmccET5xwjGkfXw10zRKpHKcG7/PB6BTG2EJOOQhDyopvZtkpSZhYDprldCjAk2/T0WS1oJ6+3nnEcao5O/J8OR2eLP7oiAe3G85LMq1fh7tBE5/790Q5pz/zOOKyKZLWniBwK0U+suTtbbimXoKwSnT7TiVfSDIk81xgiJUhitV7peqIh9+NdSHvmFeMSnu4AEBUxJ12vijRId8uebu7LcucwjSKXNhk8VHugUnbHflKZtF5WECXt246UTQZS10S8pJf7qmmVkZk2lT5oHDmC7xHTpdSLOX+0L14ndiZk1Mh87E9dKGoO1xwqrNhn/fA+0GF+nmDOKVPjbpuEJkzxTYy8sYMwN059Deu3HDYIWsHQMMiCFfz46Dkf+eaSMo3G6tN6DUUmJc8CXHIxyVKWPLtbr17TjZuIRKsbbk+7BvQFyz4Bo2KyYxni0yapwvJ0nKZ4MNscRcKzBq0GuuBeHCsiNrh229ABPBW4UmfA9EBE4HpXJiLYdPLlz82b4J+60o9WuJvaXRswouhm4t/CMwRCWEjptJgfbMNF38NlHssC6RctwqAUvQwB0VMIe6vPu6Hd2QuyE5r76YGYiR7Bbi9y4QiWBpSAN6EaHlE++EFtou+mLZSNrSrmqYL+DZFyofZtdSInsTcQiYxalJ0SG1/9RVqu70u2ex8TKc8see22WduPRs1CQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(38100700002)(82960400001)(38070700005)(2906002)(4744005)(122000001)(6506007)(6512007)(7416002)(316002)(71200400001)(6486002)(54906003)(508600001)(26005)(8676002)(4326008)(8936002)(64756008)(110136005)(186003)(2616005)(66946007)(66556008)(66446008)(66476007)(91956017)(76116006)(86362001)(36756003)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ck9DL1Q4WHpGbjNGSnAyVG1qWmJtU0MwQzdZbWY1VWtYS2hQcVh3R0pGRkNn?=
 =?utf-8?B?eFFaQjRQZDhidGtMb0lHK0h0Y0ZWMmxoK3g0cTQyRCtjNnk3cCtCL1RIRFBh?=
 =?utf-8?B?N3BLaE1zWVp1TnFkS0QwZUVPMjVVRkw1OFBqSkZTZm1SWjROaSsrNGRYdWE5?=
 =?utf-8?B?Yy9XT2tLL1VIakJYWW5NeUp6WTVSVVJuRm9RbU0yQXV5endUMGhveXVQVEVn?=
 =?utf-8?B?dkxIWVBLdzQzTDh4MzBLSDV4Skp4MmVuZ2tTQTkrUnBFdzdOeEYzSkpQYysx?=
 =?utf-8?B?RWRxdlY2NFhQeGw0TGVlcit5SUtORWtIUTc4NXNhVWsvNW5ySlpxUFQ2ZWE2?=
 =?utf-8?B?RytzTmVFWklsVjE0dnl4OFF1SjJPQ3dZN0diMVNsOEQ2dGx0RjJ4Z3RaUW00?=
 =?utf-8?B?SGEwd0lxSEdFdTNob0RhN2ZJeEdRZWpaUTVOV055ZmJaaHJRUjNnVVJHdkZO?=
 =?utf-8?B?YVJEYndSRzcvdDJIL2dtejV4L0hReG45aUJUS3hFZENNb05iMVFMMlJxS1pq?=
 =?utf-8?B?OXZVTllRZCtpMlpxcEFjUkZydmxkU3dyb1czSUE2MFM0SmViRkNvcXgwU3BT?=
 =?utf-8?B?OUZZOVgvRlFrR3VDQS9ienlwbnJOY3grcFFpOWE4a0wwUEkyNTFlaWtRMlJZ?=
 =?utf-8?B?TEtCVFpnUDJkeWM5VGxYQm92VzBGRktKZTVraVhyTmdSa2lYeUcvMnl5M3Ri?=
 =?utf-8?B?NVNOM1JvZGh6cVpUQkhNT0JUYmtjSkRPNU5XdzZjckZEaWRhV1R6NlJWN083?=
 =?utf-8?B?aGZJeDQyMXpPbFhLRXgvUE1mRUFhQUNBMzVOZXNIcWpETGgrOVZ2dEwwSUw3?=
 =?utf-8?B?VFpKL0VVblFmb29sTWRzcWhCd2owYVlzSWFQeDk0eUFTbEJ4bGxZTVRQR2J1?=
 =?utf-8?B?bFZqTGdOMkZ4dVYxdE9GTHNCUktNMTllS3YzK2kwQkgzZVY0U1N0TEYyWVo4?=
 =?utf-8?B?Mll4R3hKM1dQbHJkRFRISHNXNW96WFlhTkNYclIxKzVKYjJkaHdwY3l1bldh?=
 =?utf-8?B?SnhiMjlHU3BIVnBQZ2tqVVJKUVpMSWFweUVaQVcwTkZLRFd6MU5EV1RVeVRQ?=
 =?utf-8?B?SXZ3a3FyVGJsWTk0NXM2am54enorUXllZlg4ZWZ5L01FYS9Ra2N6SFBwRU1F?=
 =?utf-8?B?V3AzTHYyTHVPZFFpa2JLSkF5TEpDV3JiYnJVUm0zNU1nYkRYN2NPazhqTTZu?=
 =?utf-8?B?NGZ0WmtBMHRCQVhJek9NSjAxZlRZNHJ2UUZUdFBPbDNQNlQ4N1dnTjBsWHly?=
 =?utf-8?B?ODM0UnZYRHhMeE04Mk1GdkhtYThOL002dU1WbHVzRklNNjYzbnh6cmZIOUZk?=
 =?utf-8?B?eTZ6L0xRcWVnTEFYY3VvblFqUkZ6ZEkvcE5yNDA4cG1aS0lKb21VdTREV0Fk?=
 =?utf-8?B?alFMdnlVQ1dVanM0RFAreXR3RHJjSkgwcGJRTlluYm1Od2R0WWo0OFVOVkNO?=
 =?utf-8?B?eG1LZnkrbkw1eTVSSlh1b3RaYnpkNi9CNkQ4TVRncFFjK1JwOXF5K2hDeWVO?=
 =?utf-8?B?bUd0QVF0ZzY2VHRUTi9ickpjRElLVGl3eUtydnJnb2wrcXZqSkpkaGFVaHR1?=
 =?utf-8?B?RTV6NmxjL2owc243aVB3RnBWSUpIaHRLdmNkUnk2dlVvWjFMK2ZEMFVrYVFr?=
 =?utf-8?B?VTU1UDhGYmQ0S09TeU9OM3NybDBnMkk5QmZzSmpQaGtvZVE3TTB2Q2JpcGY4?=
 =?utf-8?B?TFVXenlQWEdVQ29NYTMweDhUa0R0YnVvUnRXZm9XT2oyUkYrTk11d3VUZ28z?=
 =?utf-8?B?K2piZkJ2d2trTmRlSWlJZWRKZWl5THNXYm1Na1pWOUxQRzQ2K0IvTDNkWW94?=
 =?utf-8?B?WlV2RDRRMjZkRDVUV25oYTE3bHRyTkZIZ2pjTnZXVWgxWEZzNzZxTVlPUFhO?=
 =?utf-8?B?OWtwcjNabmh4aTA2VjYrQUxCeGVmUUZORTVTbmVGUFNLNmlON0c0cXE5eVVO?=
 =?utf-8?B?MGg3MVVORDF2dXFSNFJNTTNSUytxeGtjbkhrT0RTNDlJaGppRWozT1JvbDdr?=
 =?utf-8?B?V3BvbWM0WGtpcHEwRGhYb1dwNkNWTmhWRE5sajNUaDUrM2JrbzlnSmV0ZGxk?=
 =?utf-8?B?cEdrbUdpeitueGhOMHZOOCtSNDhMUGNmOE54aS9Cd3BkRzdkT2hOVm9aanpK?=
 =?utf-8?B?MVVBWmhrL3loS2RvbWhZU1dmTWF0MXhKTUlGVVlOSy9Xdkw0Vkk4SkZMNnh6?=
 =?utf-8?B?ZjVIRXBza05aNTRXY0p6VDU5ck1SUVZ1aDFyaUdiLzNrZVo2TWdWWVowQnVm?=
 =?utf-8?Q?BNkE+4TTJlJrTLcYn3CpgRGlhf+kfX5XldD+DuTuyU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD1311B6D0A3A44CB966E8F883FADF5F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ff18da-5e0f-4426-bea0-08d9e4afbc83
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 11:49:28.0609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eg0MHbXRUbhC34ECSqEe+qbDjTEN2Kb4i+M/iL9UFSUdsctihkRTWzOqS8rYLdrCNSIjGilxGTYji48QtMnffMWmD9T5IOugqEKmUKn/PVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5504
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDIyLTAxLTI4IGF0IDE5OjU5ICswMDAwLCBBZGFtIE1hbnphbmFyZXMgd3JvdGU6
DQo+IE9uIFRodSwgSmFuIDI3LCAyMDIyIGF0IDA3OjE0OjEzQU0gKzAwMDAsIENoYWl0YW55YSBL
dWxrYXJuaSB3cm90ZToNCj4gPiANCj4gPiAqIEN1cnJlbnQgc3RhdGUgb2YgdGhlIHdvcmsgOi0N
Cj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ID4gLS0tLQ0KPiA+IA0KPiA+IFdpdGggWzNdIGJlaW5nIGhhcmQg
dG8gaGFuZGxlIGFyYml0cmFyeSBETS9NRCBzdGFja2luZyB3aXRob3V0DQo+ID4gc3BsaXR0aW5n
IHRoZSBjb21tYW5kIGluIHR3bywgb25lIGZvciBjb3B5aW5nIElOIGFuZCBvbmUgZm9yDQo+ID4g
Y29weWluZw0KPiA+IE9VVC4gV2hpY2ggaXMgdGhlbiBkZW1vbnN0cmF0ZWQgYnkgdGhlIFs0XSB3
aHkgWzNdIGl0IGlzIG5vdCBhDQo+ID4gc3VpdGFibGUNCj4gPiBjYW5kaWRhdGUuIEFsc28sIHdp
dGggWzRdIHRoZXJlIGlzIGFuIHVucmVzb2x2ZWQgcHJvYmxlbSB3aXRoIHRoZQ0KPiA+IHR3by1j
b21tYW5kIGFwcHJvYWNoIGFib3V0IGhvdyB0byBoYW5kbGUgY2hhbmdlcyB0byB0aGUgRE0gbGF5
b3V0DQo+ID4gYmV0d2VlbiBhbiBJTiBhbmQgT1VUIG9wZXJhdGlvbnMuDQo+ID4gDQo+ID4gV2Ug
aGF2ZSBjb25kdWN0ZWQgYSBjYWxsIHdpdGggaW50ZXJlc3RlZCBwZW9wbGUgbGF0ZSBsYXN0IHll
YXINCj4gPiBzaW5jZSANCj4gPiBsYWNrIG9mIExTRk1NTSBhbmQgd2Ugd291bGQgbGlrZSB0byBz
aGFyZSB0aGUgZGV0YWlscyB3aXRoIGJyb2FkZXINCj4gPiBjb21tdW5pdHkgbWVtYmVycy4NCj4g
DQo+IFdhcyBvbiB0aGF0IGNhbGwgYW5kIEkgYW0gaW50ZXJlc3RlZCBpbiBqb2luaW5nIHRoaXMg
ZGlzY3Vzc2lvbi4NCg0KU2FtZSBmb3IgbWUgOikNCg0KDQoNCg==
