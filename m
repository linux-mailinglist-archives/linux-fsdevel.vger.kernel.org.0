Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD845A9378
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 11:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiIAJoV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 05:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiIAJoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:44:19 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A0327DCF;
        Thu,  1 Sep 2022 02:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662025458; x=1693561458;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=BxHHBcA4U/1EiqS8CB75FOvPdoFQRvjjIaI+rF4ExFP3j7uqkJRfSO2u
   3A6Wn0zAXwqd8d3GakfUTN9uR6lG+9i1q3gvUIQZ7es8jySKnGms0/66P
   RiAd/oIcWiENnNS/MGvY8q1AJTpXb6Dai5q6pqRNur+p7gn31dOhkckfh
   qyk83Aj2qUOyHlpdopc+GQmCIkmfix2yuKHRfJPqnwQ62Dv+ImuPYfSoG
   KpbLqm+eS0DEFinmpXaDcmogbQqGgjebpbh8V7pBaciHsD+yVfG4oRe5v
   068oNAMOQ/06/mWLELCz5va41pjwsDpyBwDMJ1y4zHNTvT8V350Aj8BWF
   A==;
X-IronPort-AV: E=Sophos;i="5.93,280,1654531200"; 
   d="scan'208";a="208650775"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2022 17:44:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4YuQ/puYtjgWe9ZNFkXoYEu30xvRZjw9fvBhPo2EkM1g/4IisGRLfA6D9mXMU75HYMnJ3nkMi+fEypfyOawa5+L7dywHQXrJuzOBzPoczXul4mAv0fLB4CS6qkyf63z8Le7fnDAJrEVWKn9zf/0MeGfOG8xhKqn/uN/tj+P3k68WMIvqeYfiABBpQIjgFP9J8B20wiU2iRBy+l78Nk6FgcZB/ICJdqg1MLrH80sQ8GPGyGV5abuVYGH+BckVAoQfDF3Twjxj1u+ryXuG5x/yb61oBICGZzTakqtFxnjjW5R0/VD1kperTsS+orsMc3DGlEQgGbvP7Jiqy3+nxpVxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=nddfd3PrMfwIP2TYMmxEDOY1XTfkZ/Cy0as+gFjlLa8lXC6X+FfWrsJmMS9OYeZYr9uLYPV/oK5EBYqj2JoyDT2TXBEfKDJ/NCPMqODa0/l4WAUYp15NgDJ2/jrVEpBJwD/oonW1YgFvM9C21RPHXqdqyCPg2VjDS7M1BvIX5JHVma0eeiGDaPbEUODrMgyNl3Hoj00eERKkS/i9qPMr7kH/G9u7biyJXvrx+9rmTHIMBnxcWD4T09yfA+qn3xQScCSMTZdRHMnKWB9eLu0m/JuO/6FW7tSv8LDZKyc9CAOaM8tUe5lJC6uPV9LHQ96KmPhc62zwjdSnbC/gZqgqxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=OW7tTbHnV4FJCMHW2qO7mgJY5j1R2+NeK7ZNYBXnmHCNUJii7XeLE3F5FWC19RRNNi7prMhz5a58SpIHIk5nxz90I5RZTevWMBAncICSFucnvKCEO7sHKaFU0JfrcH8R7OR1BAwg77nF/9Tj8Dv/LUYFwZDJIxpNtv9DXNDFdaE=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by PH0PR04MB7884.namprd04.prod.outlook.com (2603:10b6:510:eb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 09:44:14 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::14d7:cf0e:219f:ba97]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::14d7:cf0e:219f:ba97%6]) with mapi id 15.20.5588.011; Thu, 1 Sep 2022
 09:44:14 +0000
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
Subject: Re: [PATCH 06/17] btrfs: handle recording of zoned writes in the
 storage layer
Thread-Topic: [PATCH 06/17] btrfs: handle recording of zoned writes in the
 storage layer
Thread-Index: AQHYvdZztUnLsGDr+kOrzr9lYcmggw==
Date:   Thu, 1 Sep 2022 09:44:13 +0000
Message-ID: <SA0PR04MB741819331EF4F26CE54EB6469B7B9@SA0PR04MB7418.namprd04.prod.outlook.com>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6429f23-f087-460d-7e4d-08da8bfe879d
x-ms-traffictypediagnostic: PH0PR04MB7884:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vK7iR6/ISDBLIF9YyG9VcBksbn+Q6CiXVYMRmVDPzWIWZgyMNz06LPhYEXVlJYf0entRcfObA7GIi86eueyN83MTx60O4tRYTCts9bU7h49leodWSVcSXBd4Y4Ww5ef/AaTozKVOJvOHWGlesH1235o113bMSPpbuqDWUa0FD0Yh+zB608zfEIMIYtoFwn9TBkWx+uspSnSFz4gD0GAzQ9cLud1sSpmxkJrf3hwZ/2Bvck1dPIPjFtyPYoLlmmxNRJ0Qe/gxsZH3E2SVYbmjlDQkt9LjCJinvdpVNJA4lIRPE8GYSAGXFOgi0jYTzT24semLgJvdkjOqTiXBugCHinbSO0URCKMfBiNT5OgOd5sjIJ3ZPUqxH6oZcmD69C9umMTpFutz6sU09D2v8TlK/kw8LTcZwEcxuYBdBdqw/GExTcKLJIK+b3kJXz78AmIMnrof6tlFoZES5jBpcmkV+VLkZZ4UQgRDe9OpyaLnH+xIIAeY+ouF875DEUYW6VV4Ix/SRXe1axlpVyOefQTsHG7d26z9pWq2FzLjMhosA9c9dPm3SI3H7IRCgSfy/NejG15ofqiCQ66poSHvIbQBTDYdGzq+/oqn4rdQcVlYT+ZCwydb448FIffNExv1B0mD+Ny/oyiULSUxNgslz1YMzcwQ40e/UeGGSRAmWBMpAYdys1Iz7xUlyn1WgIaDJHRrjdizdkW6htcHEn+t+dFDwvM9NF0Ab8/9PW325Q/BBnJGxtLl2FFWBpFpLXHTzL4ujejbgqbjRbHh6St/yiR9rQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(71200400001)(82960400001)(54906003)(110136005)(38100700002)(316002)(122000001)(38070700005)(55016003)(19618925003)(26005)(2906002)(9686003)(66446008)(4326008)(64756008)(52536014)(66556008)(91956017)(478600001)(66946007)(76116006)(33656002)(5660300002)(4270600006)(66476007)(186003)(7416002)(6506007)(86362001)(41300700001)(558084003)(7696005)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RYjR3upu8zlxUpICg3UNNtMs3Y6Zhi+3sjHIM7O0kmLRHFsrb1PlqP86ce1Z?=
 =?us-ascii?Q?3LHO7BJkbBCg/FczFwp2RgKUr0K/Td4Z6NKyqjmYHC1eoeeTNGYsofgpnw6w?=
 =?us-ascii?Q?LZ7XPCq7kkc4SU8+ZTxhvdpwD4ylqzg74PeMkoV0QNLQRF2IHXj8lpmdeS4e?=
 =?us-ascii?Q?himq+/Dx/9So1BPxmo3t1q/rjufBYDe+grrxS/xksK7HMPwZcRYGh2Lxxz8Q?=
 =?us-ascii?Q?7VNpy1FsIlf7ZmUgzgKC7/Xrd8RGmgHxm0Bk9QRisk6mpzQ9oyi37//dMhry?=
 =?us-ascii?Q?M1qw1dXXwxjsvfFHYE+xtlJM5fNqaIqeUeCDU/pEdu20VAl1DUTmPx38ZF8u?=
 =?us-ascii?Q?ojnPNE9VkNSobDa1meDVITj/tWsyjmf827K3hKnuVt2dkqaAVy5+9hgoa7l9?=
 =?us-ascii?Q?MRgbZdNOJ2zhDI0cP2T8+Zi4eZvV6ZnkwBd8IvIxNp4reDsBFEqNug+NqU/w?=
 =?us-ascii?Q?GnSPX4M9YBbStgvDuiquEh6Qzhs4Me7RwThIaUtDSZl0xSEp1UzP/TkQ8EDA?=
 =?us-ascii?Q?xpBY+u85x1I2mWfhuFmmW/5w5m5A/3zPHuOEd5ZVO1Csfuh8wQhFFUZB6Y0S?=
 =?us-ascii?Q?fZ9xdfNxJj0ahsHLHq2+eV3zjlnbJr1yhFZh6PegHaCwxGQULxP5tpG+y/HZ?=
 =?us-ascii?Q?/R2+lpeZPF+vnga6lkU2/HnOR1OL2F4tIVaoPzrkKUAPyBeB4W+i8phUfSFS?=
 =?us-ascii?Q?qnEDu8OWKAAgodwIarjAuAB5Lz0a39ywNo7xL21ohrWjCG0XiX3g3rLP6WFH?=
 =?us-ascii?Q?PoBqjY71Y9GYNWjEPWyqX9+DmXYbMucOA8Rdt65ROsoOhlwee3EMLm9akvV4?=
 =?us-ascii?Q?ymaKcyFLkFtf/6XZOwj1Ezvl2+Zz53hPqgC3yamt5t8kKIbXgBqEYpPTeFO1?=
 =?us-ascii?Q?8Uca1SNdYogusEc7XpXNb/Es4wGnvG4wbbqHUudVmWasnQrvb5HM60A0c4GE?=
 =?us-ascii?Q?ETK20ac8C5yjHj309lhTGhW218IBc4OnCbddmn0x52jFKic+rV5T8F6S6Zh8?=
 =?us-ascii?Q?Rd16XiHzdEO31c87LOc6OJHXR85m2i/Z/8KNBP+nABaQLYROlXbpCexYzrz0?=
 =?us-ascii?Q?pEXatWb5b4BUyhclGUUiOTjgNeVmZDsnHRf9XPCz06fbLG0RRThkwddTlc9P?=
 =?us-ascii?Q?+9w0SXkIkAW1vZFObHTszU6WECrjd2XhkBDxdBhIuavta+vZ14Lz8hcT8nwu?=
 =?us-ascii?Q?TWqXh4xbLC14Gk/8uwwlCJamI2fLRuPtb3DsY6j4YHSS0IYXXL3Os5aZEcuf?=
 =?us-ascii?Q?RbGi51Izr6CuEh4lLG1L0fMVhVaeT3QimrP305B28PzQ/irB9sRHFQORgkrN?=
 =?us-ascii?Q?MmWfnCbGMuoRjoQMHL0pBmoT2qTuceHGkQizMB49ONDphkJx+OCxiyfEgxMf?=
 =?us-ascii?Q?mafFtrtqanJcG+DdFVYUHT9X6gQT13POe2CLfbWPp7ZEV6Rku/DJeCW6/AuB?=
 =?us-ascii?Q?psoPWycKOyYgu281AcsRtzRStjQfNmJekynvIwqtXelzIB1LYYi/e0rneVYA?=
 =?us-ascii?Q?BypOgpXRms7ZT5D4w7R/XUX9H+SQ4xDUqFAoiZWA9vJDOqestbr5wBEYvx2Y?=
 =?us-ascii?Q?s7giBkjGQ9to/ePHQbbQ8CWBczfvtkGuYmMbeimgPvDnIC/apset61mKJXL1?=
 =?us-ascii?Q?g3NsFA7GozQ84naQdc9fSok=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6429f23-f087-460d-7e4d-08da8bfe879d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 09:44:13.9077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OtO6o3cpERp6fyvg/A9xEtcSLRcdM1IAEYvt5AbixXxqV5fExdb8+5stbpgS4NFyofdSN3cej3sYbp1kyupvvUP9JsWTCAJ+jnHiEJCEFFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7884
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
