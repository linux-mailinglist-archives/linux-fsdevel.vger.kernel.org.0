Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0DF3E47A5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 16:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbhHIOgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 10:36:10 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4785 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbhHIOei (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628519653; x=1660055653;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vACKBTJ1W3dbxi9/auoShIet6UycyPrHxIN1n7HzEck=;
  b=A2Qg2ATaAFTB64hSFcgyq0tPt8mptiFtprLiAcike+D+5LDX18ctnYWr
   wqkCPegX3oGuwqW7PKgqd73AOfM8UBms6pT4ygtol+ZGXYX6oWMAEJTTv
   S1YLA2g2Grm4wFu1IeyBGWWpb7r3BCwTksQyTjo4pd/G8BU0RQD3QOFYU
   mp6s7NLslJFFTPFHWJ2QsHo7y8ib6wESFIUaL74FpCeizW08qTjAQ7nFG
   580wstoBXWcu34X19O6YoSwA6S3yrSIeTNvOlZKP8j/Hjvlv3/rnCd1oN
   HzFQ8F1Y9yj9vAuXdqVFlIzPodPAOlYg0qpXUiU1iJZbZBDJzkS6lzo7n
   A==;
X-IronPort-AV: E=Sophos;i="5.84,307,1620662400"; 
   d="scan'208";a="280533433"
Received: from mail-sn1anam02lp2046.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.46])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2021 22:33:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTk73hkQiLeqxVRWtEIZc9HVil5wQlFnbviCpN2zcG39L4NWBQylYH80xpuccz9TTQYY25I+6KZ2lkXtFCF/0X4UjwBG0W4d68cXMoPLRZNC9FogTdAnKVmF3oowapSGZj131tzAjm1jIvkit64LJSmffhxFwTBoqaP5UcuivKyePc+c1W8Y6/Lze43AZNct3FL7txLcZx4vSR6bIikAzPimxCUVXC8IQTJNyASQOziwac3eWHDkxpbTEB75CEO5UhiZCLx85RDJ3IJNl9LfnTRtVJSbRzeLpxcN+z+epQq0qm4SOlh4CEOOGkfWsy9KOkONttsBafSBW+KVkiRHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vACKBTJ1W3dbxi9/auoShIet6UycyPrHxIN1n7HzEck=;
 b=BM7iZPG8SKttn54liD7fF0WypAitct7JBERzuomC6BwRl1jZJEHjRg+MjL1ivuE2dWMXb1gnn7mqxMn0FnVlHYCAGcR2fJW3Nkg94ohxF5sXCsTuaNVvtMq61QRha/kI89ND35eyksRa/xlghBkmQW4MtNB+N48NIw1dOrsoMxtMxxk0xOuo0y/61HhfwoZMw6kvB/LJl7lNYeJTzbkQqkRoBwGak4N4gSRRRFb+vYZgTlly7HwTFHx3RzK9ICG78PmhReqnqZFQWphXANovYnkpJBXhpMkGMmpboXEv3Ka0qRqQpe0SDxaO2eSHdwpRbf4Oyj+zpF2owkd6FRXpVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vACKBTJ1W3dbxi9/auoShIet6UycyPrHxIN1n7HzEck=;
 b=F2jeqY6qFSbnSWLlvmpdOWHb0sisNxAbzI2HIegxBe+R3lTKN6pCQXaOFa9Uxdiwq/CvGdefk4l1pbqILZfdjcg07RVbQZ/mdKe55OZyMWzDGD5TdWOGhR8zZ4X6KFi8sgzMo7UbiNveo48ZM6gOcq7SwPS61zsE7bklk2o5tqc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7431.namprd04.prod.outlook.com (2603:10b6:510:16::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Mon, 9 Aug
 2021 14:33:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%5]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 14:33:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/5] mm: hide laptop_mode_wb_timer entirely behind the BDI
 API
Thread-Topic: [PATCH 1/5] mm: hide laptop_mode_wb_timer entirely behind the
 BDI API
Thread-Index: AQHXjSmSRDcfdmHA/EqqLDmcRHSLnA==
Date:   Mon, 9 Aug 2021 14:33:50 +0000
Message-ID: <PH0PR04MB74167976DB6951561F74DCF89BF69@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210809141744.1203023-1-hch@lst.de>
 <20210809141744.1203023-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a365d11-add5-4407-5237-08d95b42b480
x-ms-traffictypediagnostic: PH0PR04MB7431:
x-microsoft-antispam-prvs: <PH0PR04MB7431755FFCD802D3705D0D8E9BF69@PH0PR04MB7431.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DV9aLpo2XsovATPMhM17f1UlsVySkP+ZZJc41KI7xI6jRcLKLd7phOPDc9cuqpCyIeSmafLUSDgoBZUR7xKHas7oCTH3bdOz1WPNiKb8tp5Z4GSlIkWbur17KR5wiAeR1HVOqo4q+9YmGdAlXylFqaU5MpetmzXOZhy+XtI2beZAY8cblxXFGd0Iw3q/KvjAyvWTiDyb6egGrOVn2HUMRaWcLDIm7izlVZYUesSEbmZKUIoSl1/6pR+ariKbAAG03g95zLhPESuzhyItJssVo1PHTIuKMh1s+25nP31HqPf5wjWyU80Hv18YIZHroqyls0Q0lKPe+ES387uHCaGyN6QWLJ1AORcSJAMwyZwCd8cQdz1kQkV/orryQuyxaxabCi+Vnw17DheBTtenV2DsCIQkFzU4By9lkU0oJ68m9cx8oUexHKfQLZsRMZeAkcyz9ec+NATXUdZu9emVeG4fE47sSdQmVGAHbjwiXotQBYo4MBQG0ox/6Mnm/0dC1XBGKik99B6GzzFPkWXwpkeOjB2unt6g/m8ZwB/0x2h0yF2bkKnZur6wa3bKwJIL835dsovHBaZHh+9MPW2mFakKHWebkdLfEUr6t4oN7Rgw0kHlxx2Oleij5/msXk5M2m2SKk42U6O6KAsUUQzRDF6z55X+BZa01JV0Q6fHbuDXtyKA0UVO6Hz2nXR+qZjWGxxbs8d88lhzdPEkbbipJuWrlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(86362001)(2906002)(53546011)(7696005)(38070700005)(6506007)(4744005)(38100700002)(122000001)(33656002)(52536014)(83380400001)(4326008)(66574015)(54906003)(316002)(76116006)(8936002)(186003)(478600001)(5660300002)(9686003)(66446008)(8676002)(66476007)(71200400001)(110136005)(66556008)(64756008)(66946007)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-u?Q?AR8LYrt7+MRCHacpYtu5u13BXmAfhpA8ryCbM4jE8Yv4MMGp8z5GG9fu3JOtKg?=
 =?koi8-u?Q?K/SKSzfewHwmcUqB9CkL7J0X8Z/4VpS4dTDWkuVlsgVXvJSpyp1qdSd++UyyfJ?=
 =?koi8-u?Q?Qtd5ObrN2EQdjTfC3xxoVOKGFYhWs+vVV8hdgthkevp/fpbrY1mZ7uw3iTuvY0?=
 =?koi8-u?Q?oeoQOBnx930uK1V9r0VRrkX6y+Vu17SpC0id1tuv4zKZfRhRMXXgiUds9sukwV?=
 =?koi8-u?Q?Ys2oYzEmkgrAxMWUrJEAkpGbvbG1h9/k62UwdNn7npQZRHaJVrx4z3v46lZF21?=
 =?koi8-u?Q?OU7MYYDNsJ1/ql6u88+8S8uJx6wL1UdJIJpPjRISkXuK+m4axRjGqfC1uGQyWp?=
 =?koi8-u?Q?A8xdKdv/zRslte0et4dQNSBiXdORiYy4FCoS9QM8NQR4AkcVloCxGWn0crCdxW?=
 =?koi8-u?Q?Nzq8O5uikxMlHZULAVJQkOa8cmngeVpP6+Ey91YWF3s0AqEUj4rZTMIwho8Sjd?=
 =?koi8-u?Q?Y079MHtqvunEoK9aaSFiwK77z6aPahuBVHrZ1S+IpaWqJvUADA8ubPffF2h9TR?=
 =?koi8-u?Q?zQehkVGqlKBILZMO0ijHUpsG1nh577T4skOa1WH3bAWDg706fGdF31MrC67KHR?=
 =?koi8-u?Q?eR9MSv1jldUEtGYOvj7+3r+MKYJgXPtY8EB0/11G4bGEezM66kxNzJvxJGEpJZ?=
 =?koi8-u?Q?3izj9oJg06uD9o1+F1CggXq0zHhU6E+FW3zjKSQ2r2h2kwevrr0x/UrQbD6lEI?=
 =?koi8-u?Q?EVfrA55ECSv+UfThCjuY9/m9gNID6bcmKZCMz6k/6oBIW08xOLPD9a6mhpN2pW?=
 =?koi8-u?Q?Ar7rgKflX5js9K1Vh4X9UaENnTD32h6k8tW4T3NHCl3L+aPTpOcqhgg+L32Nwk?=
 =?koi8-u?Q?ibhyXMi8avBX7gHLxHFoOuLlE3UmQWrbABoHEiPNXo+3wXfTFzM2oQrsAwo/w8?=
 =?koi8-u?Q?iG5MOsD45RPhld73W8NiocX8x6IZlvpIBusbV+V5uwagr0yYNsm4qnJjo5w6vd?=
 =?koi8-u?Q?L5H/M97peJ115cqWR7uDgQLrEu9Efa0s5n8/m3OPSSMCDGikCxz5oLaAanA+Ja?=
 =?koi8-u?Q?GkKMIvosxCHLyEQ139pYUf8FctELV7kQNhQv+Ce2v1RgrWon+S017ZbsjzHaVc?=
 =?koi8-u?Q?UP2rImSG5iBKo4AUvoul9r9gUrgqwBzk273VusJCukroTd1xFsGwEeTooa7pb5?=
 =?koi8-u?Q?UEj/ZQUBfEuD49UPjxUt5NbFbg0/ikr9i1SY2hkqW4+NjV/yk/lk4jYA9ISABY?=
 =?koi8-u?Q?ozoADXi64q/xIBZhffiyltAOE5D7v/NSghiBmcnB2tTNfz64XME822MkLAeb2Q?=
 =?koi8-u?Q?hXVjhowvChUErC9k9ZikmmT9BEPBJj3j2ig39gCUd8Uk2Deek3bNtnIU0rEuG2?=
 =?koi8-u?Q?czON91niUR1pEOcM9gsnC7+igHMkBV9UYHY1sWpg/gKeSoS8FVs1YA+iyBvSsR?=
 =?koi8-u?Q?y8Sg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="koi8-u"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a365d11-add5-4407-5237-08d95b42b480
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 14:33:50.2290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fx/c4OON8anbs0oyys6rf/09IZ9kfj1AT+buEuuz8Sb7XQ7/zWXvovaql0I3E6JRE0JrD8LTB9t2RTMzTlQyWb1/Ra9n3wRTZhZVijTQEuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7431
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/08/2021 16:19, Christoph Hellwig wrote:=0A=
> Don't leak the deta=A6ls of the timer into the block layer, instead=0A=
> initialize the timer in bdi_alloc and delete it in bdi_unregister.=0A=
> Note that this means the timer is initialized (but not armed) for=0A=
> non-block queues as well now.=0A=
=0A=
And laptop_mode_timer_fn() is always present now.=0A=
=0A=
Other than that,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
