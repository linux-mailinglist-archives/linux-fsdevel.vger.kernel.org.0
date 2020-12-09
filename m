Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B7E2D4376
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 14:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732590AbgLINjt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 08:39:49 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42641 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732577AbgLINjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607521630; x=1639057630;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=cLg8v8xzcwI3GFvfsMpCuZU2BOr6bHwwWly3xZ1uuZI=;
  b=NChQjD89aqyh/91DkY5z7NuzvivCnUXe92i9aVray8CeUGMpWtN68UlP
   2OrUsMWmILlzmtQbWc1vn+rl6Ax0Lkg2/mSZAi2tuKmZUzWt1/GsmAMJE
   NGAJkagXWq1jfB3ikhuWmyrrUeN/vHegIhU28wxBMGq8kVQnnI2qI37CX
   hwDahGrHEu7X1pUi8vRyW7s8kcwdgIJ0na3PQj8kReiy15XihqppyOApn
   FdH2rhdqAOx7PkJMNz2EyhAGppiPMNTDrgLlq4SRY2lzxCYIAeoiH9GSX
   l+X0BLoeq8kTjW35M3F4eQbYG/hY/dZV6wxMp2IIE9zwltU2e3yAmK4Wu
   g==;
IronPort-SDR: zzDmEVJdQLy6i62soikyoipfPXF6bW03aGtzULvOT+E0i30luDfHCpws/8VGfbwIyt5CfWzSGb
 g9r2cEzLbWtwvOBh9YevjxG3kU8gsa1fsryJQ4Q0xR/T/7tqWwEsg8g/RKqGxe2jzdLH5yeWTN
 R4HkPkRX4ndQ76OQ9yKcyEtW6TyYCobb2Yuo0LVM7BkY7waOOYArERowjtIjwlm6rTivc/90M3
 KSL+/aGjZKHldV1D1QI9n8UseF7XgbxRt3zTz4iOU6ewgXE1gWNEnKtgBq5C0ljn8tnFyoWKae
 nCU=
X-IronPort-AV: E=Sophos;i="5.78,405,1599494400"; 
   d="scan'208";a="258493663"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2020 21:45:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pfivnlpgose5ixthj/q2xaR2fRUuzyzvnaMYDXppmctsxaKRJ/bBUsTiOAuhc3hJEt6N+ObsjpLsSdBDOQdd7LLF9+Csp7e02XpBfYUQrMiRsVaBwZ4A8BIUB3ncIad8lGbEB3dEXPGd56b+oFO4oUSP5y3jPV0DqRxqxjyY245JYs+CdVOQS+OReHs7LS90iZgj/X/JELpMW/0FMC/pzRGUs2bAAx2EIR0hdHFI7X162PbDy/FxsNPAn7ln0oplZaQujG6lGhZIXVfnaukL4+CGjLjVlQCvpDfTFL2EVeuMayrJOWO/5bZy8SBzBX5D9nboUbtQvyhz3spR9xp28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+g4ISUr6a6kG5vX7CmzZ5cFeERqM8REqyosxJtLflU=;
 b=lM+sDVXOtoo0ZsJjX+Xvw6wHfhuCfJqzDO+HIDoZYqaBDSgx3+L0hX7c3+NyBQ7CEd0Kk09gnS6JEVMzZFUoEJmLocdhLKI6R/5gss1/+PMJpZCNBRIDTOg3+vzLlHElUfbof2virXbyoCnPOk/31OZ2eFQVjEukKcaSaXrwfJD1OOUT3qYu6jQ9PPALEzlAyrji2olPoirzWB3BaTpmkvF1rBQ4E+z9vx1s4JOwWF1bbny8dwszAKiUMhnAUHlMkP1MLQSZO4lHyAH+TpW7qBgLDOJSjKYDGhEjlZVYs5WhzR9RkmOmColKk5K+xWGbWyKt6Ub/yFh4DeZt2RAPlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+g4ISUr6a6kG5vX7CmzZ5cFeERqM8REqyosxJtLflU=;
 b=noWFCiBbGr2AxNELRjd7PsvfUq2qqFszbn6XhWrVeJ5MqS8Jj74GgFezEUIvnU0LrqChdk1wtJM2ZWva5LuUNxc35O0+rF6nZRexPUxwjTAlQ4ry5QBiZwFyPZ8inFKXgksrtMh6BiM9n/9QR2sWVM4J6aoGjxhPdhv3T5iBmiU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4048.namprd04.prod.outlook.com
 (2603:10b6:805:40::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 9 Dec
 2020 13:38:22 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%6]) with mapi id 15.20.3589.038; Wed, 9 Dec 2020
 13:38:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v10 02/41] iomap: support REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH v10 02/41] iomap: support REQ_OP_ZONE_APPEND
Thread-Index: AQHWt1Sb3HZRbzGDlk6Pnuh0g860vw==
Date:   Wed, 9 Dec 2020 13:38:22 +0000
Message-ID: <SN4PR0401MB35987F45DC6237FC6680CCB49BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <72734501cc1d9e08117c215ed60f7b38e3665f14.1605007036.git.naohiro.aota@wdc.com>
 <20201209093138.GA3970@infradead.org>
 <SN4PR0401MB3598A4DA5A6E8F67DFB070859BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201209101030.GA14302@infradead.org>
 <SN4PR0401MB35980273F346A1B2685D1D0F9BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8cb63b73-7a94-4082-1d88-08d89c47b2bc
x-ms-traffictypediagnostic: SN6PR04MB4048:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB404879CCD1FEDF79FE0816659BCC0@SN6PR04MB4048.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qsH0dJGoApUme8ChL8x2nAUjIJwjfn6dq6y9G4rw1V6R2iXnGynYyP4k4VmzpQOWjBpoO7vVMHt1IxLx7KdnU0kUGbJZO+3SO2r252s+NZvbiQBCmdEgNkZEL0m/Ko53iO01IUbnWuJkA7kihJNKk2IqWON2RWgcNhbE6coFdVuaqtba0/Y+qMy5eIIpW2nVBQV2hOPYYP1iKu4aVz9XBAl3B+iDObZLVZAofyXHmfF8RX04fm7EfUgme3g2J/PjXjDJC7NY/jWRKdZWM0Y2HEjRX/cc0MXg8BYq0oXOlRFiQWg/GJmfnbHWh7NEG+KwsuCFkZE3d4NGaWgFMeQMkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(66446008)(52536014)(66556008)(66946007)(66476007)(26005)(186003)(4744005)(64756008)(508600001)(4326008)(71200400001)(33656002)(5660300002)(83380400001)(2906002)(76116006)(86362001)(6506007)(54906003)(8676002)(7696005)(53546011)(6916009)(9686003)(8936002)(55016002)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?K/LPIrnzWFheusFsB4nkJF6FXubr4mGXk8QDd2xOULxFbBUVDj+x4eqIOjg3?=
 =?us-ascii?Q?8dUSHB/ib+H1BbV8PI/WORCwNgZSXHkXDbwH67rso+ovqtayOZ1ItfEapKfp?=
 =?us-ascii?Q?ooNgjvK2kPFxAgT9QdiqgxOXWT4+oknI94bOuxmC4OB4Hkke6nE5eNMiqQm7?=
 =?us-ascii?Q?M9YksnJp33GpMxqLIOTrFemcycTtkdA3I5m4M2JKAznMqj/AT4GS7DFQu5Yu?=
 =?us-ascii?Q?gS7NjGL1C3Hiwc9Hh54xIVeGtHrmGaEU2pjGA+u8i7JVz3klNFfvK+55hW8R?=
 =?us-ascii?Q?kdTkq7/Pwky5byog92gOWjO4V1BmcgYEU3/N2Wvz/uoF+3Pi9EWpHkc8lZIJ?=
 =?us-ascii?Q?LWjCbWTouOcLqM4YmO+sxTc3p8oZ3i++ZDYyLeWz+kuM71Azd4lR75pHsSDp?=
 =?us-ascii?Q?M+zqhU82YdGPfLlln7VGarhBGsrnsZkYKvbOnKhk3SNonhQmn8RA9ew8pO1w?=
 =?us-ascii?Q?NpoXSDhIFcLzrWfkFKuRBKpC9H/CoJpxoxRrdPhrGy4JhsUmr35l4nvL7iii?=
 =?us-ascii?Q?JwRLW0/U9a20NTpVNs8nY/OkDB1vcoPIIe1fjJJfKTKOul14dA7vwIxJZRDx?=
 =?us-ascii?Q?XJZzvIMNHT6lH/qUmUw+o4pF4oct8E1UNa8ePhArW9D4AO17qLR9uLIcPdUo?=
 =?us-ascii?Q?GRuZqg97fr+LPdH6KVcmJP5oChPECgO6b7YQrLdhaOFxvFx7dKQqwbPBJ3pp?=
 =?us-ascii?Q?tpwrYCQkpTxNGKVZjJzxYtjT4Z22c70c9uYYEiGoIWBgKHD+mUJse1auGmoL?=
 =?us-ascii?Q?w2jdOWxVQ1UkhupZrdU3bAzPfbYXx73uX9fdEc59f5SISLLt2bFCCDKEJlPq?=
 =?us-ascii?Q?oVRSIK8f8loZmKLflAH1jZA80tT32Q+I+TnZkJi4rcJePVd4R5c8zzZsVrkX?=
 =?us-ascii?Q?QVkC+3yqSNc3NWdyxUQscs/hrxueGvAQG7WhG7ppufqUnDaQwEvL0MxDSY5O?=
 =?us-ascii?Q?hasKO2b260uB40lHowowQAW4qOuO+aWZtlJa2mNyVu87a14Tho3BW9z9uVob?=
 =?us-ascii?Q?QHtl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb63b73-7a94-4082-1d88-08d89c47b2bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 13:38:22.7319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zYaitSnOouwRaHi1FoV07rWKuKgyHBE36Sdo0BvGFA/stmlUbM+XheYyTFskXZ1nNV6MqHQ231yDgSAr9VIKDkQ4S0s+DNd4xhlPMUL34d0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4048
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/12/2020 11:18, Johannes Thumshirn wrote:=0A=
> On 09/12/2020 11:10, hch@infradead.org wrote:=0A=
>> On Wed, Dec 09, 2020 at 10:08:53AM +0000, Johannes Thumshirn wrote:=0A=
>>> On 09/12/2020 10:34, Christoph Hellwig wrote:=0A=
>>>> Btw, another thing I noticed:=0A=
>>>>=0A=
>>>> when using io_uring to submit a write to btrfs that ends up using Zone=
=0A=
>>>> Append we'll hit the=0A=
>>>>=0A=
>>>> 	if (WARN_ON_ONCE(is_bvec))=0A=
>>>> 		return -EINVAL;=0A=
>>>>=0A=
>>>> case in bio_iov_iter_get_pages with the changes in this series.=0A=
>>>=0A=
>>> Yes this warning is totally bogus. It was in there from the beginning o=
f the=0A=
>>> zone-append series and I have no idea why I didn't kill it.=0A=
>>>=0A=
>>> IIRC Chaitanya had a patch in his nvmet zoned series removing it.=0A=
>>=0A=
>> Yes, but it is wrong.  What we need is a version of=0A=
>> __bio_iov_bvec_add_pages that takes the hardware limits into account.=0A=
>>=0A=
> =0A=
> Ah now I understand the situation, I'm on it.=0A=
> =0A=
=0A=
OK got something, just need to test it.=0A=
