Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E071E1E222B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 14:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389278AbgEZMod (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 08:44:33 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:60303 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389253AbgEZMob (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 08:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590497071; x=1622033071;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=cIwZ82+3Cns7UsJy/hiAOMIYfeonxnN5eD7NDCi0Z3k=;
  b=gqma+jZ3upbtA2mjs+JwtEZ3bs+HsjQ0jr8Ma5wCmAzkI+OOXLGZ9nXw
   klX2+qSb4KqXsFXVazhubD9nt40PhPjSTzkiXjwRDX9bFyapdEwwLf076
   XvyoiyAFdgtyEqFWZWwuDxeG53d13Ctft8wAzbOI4AVVdmr/BGXrqWhS/
   NUpWuIGBzCzZMiUTXMtsURsHbk989iBR68q/7YpMWULimwMR9jaonvr2+
   XfkmfmOK9aaJyjI4DyzwGlI1ShEWho3APqJqRi/rCIfUVjSwBegGA+klR
   dqm0okUSn61HlTUk3zzaIRPsHU1UTjxf8SsxhWqU/4s07yI5LKfBU2Vbp
   A==;
IronPort-SDR: sL3RCBwhVY4J7cHiE5uaik/9GMAbadKQXfBCs6ISWvC1BORSCUINz05ejoa4PLTdpEo+1NM5YG
 4hHfEc21l7kNMxFv/i0lXZa5nqYotH8j/dV7qphWUI4kPBSodDS3yXqmlwYYloRNPtXQGOAzfh
 K4/DDHQWKw+aI02z+OdoKVxgL6W802H20qrYlG0hTZB5qqwoU0lBUMQKELZlAcuBXFpdotAHHQ
 IM71fDbD5f2eIw54Y7CF4JGtrJrv+zo8PfbhNn4ocMS8eLptsgJB32Mm/xrGh/s8dKMdkDtdQr
 u4I=
X-IronPort-AV: E=Sophos;i="5.73,437,1583164800"; 
   d="scan'208";a="142851230"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2020 20:44:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPaYP3OfofP13SsbuIxPoYf8+9/5LlPnw+XmWuMO42pj4quvKcdwl9Fwop9Rn9OUXKhNta0m3QvWDSB3U9njgXTDWVglzgspPELidv2TG+AMl5a58Yvme+SYXPZyRdKesH9QKWRNqENgHsqpm91sXr7DWyz88FRpz2lY3VhhWS1S2SLgaZUNZFma98hmly0Dfa/khukzaSwrfG2Nv9C0l6mTNdZvWFPaIQXAf0yy7/DhjSbZUZRdwFsgBdSKZEh/KALX+jBWKx71F/60Z2WIx3eNP3rRxVYx8XId0ry3eKYjRxl5cDYtpQ40XunGq0xePsd/VzFNvjwELl2Ah45Qrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t58JUwnA2GPu+J9kz80d/QlHKJXVSD/5i3fIQ18t5kY=;
 b=ExCt7cD6FHDSyAMrd4RE8JiRbNxHpaMbxMTnlTniZWgCqvGcpPXfB1d5NFgDTsuTDPBFy8Mx3CGyAYe2Y4YDzJb+A31ZK/6n6wgaydklxYlO2dSnxUlvLsN6WiiELmasm5dmS1vixsjMJ6dIIfAvnzqNHeE3mlC9sXCOXHi7cqV/xHt9fyEXLunpIRwM2c51yMah23/BN+Ih5DZqiemYHgdwxqqsliEj63GysK1/96Ns96VZN4aB62Tuj3qVnFLMdK9o0TauSQFlyKxj7KzBgNEPwSAX0A5Jvh2r3A76ToDl+zclvh9Dwq9BT7+8kcPLwb+vTrorjJZhOKstao0Xfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t58JUwnA2GPu+J9kz80d/QlHKJXVSD/5i3fIQ18t5kY=;
 b=ZT6LMhRUst4GvKiCPHRjXUM0RJ9vuuvenkGKmSXPaPWnOFKsvPXcDB2iCyGzyEPQYT1L9KACdR13JHhjkVXrv+IoL2VX5471h3JkrvCk5h5NfqOg+Xh3v+j0gulm+BO07myaZG8FF6VPhxs0+13nSyFnjHtrqQVy54vYCvvkxME=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3632.namprd04.prod.outlook.com
 (2603:10b6:803:46::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 12:44:28 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 12:44:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Johannes Thumshirn <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v3 0/3] Add file-system authentication to BTRFS
Thread-Topic: [PATCH v3 0/3] Add file-system authentication to BTRFS
Thread-Index: AQHWKdGB/2P28p4DZEOYp4TPCgjJxQ==
Date:   Tue, 26 May 2020 12:44:28 +0000
Message-ID: <SN4PR0401MB35987BC70887DA064136F82A9BB00@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200514092415.5389-1-jth@kernel.org>
 <20200525131040.GS18421@twin.jikos.cz>
 <SN4PR0401MB35986E7B3F88F1EB288051A79BB00@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200526115300.GY18421@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 60094a9c-afc4-41f0-6a78-08d801728775
x-ms-traffictypediagnostic: SN4PR0401MB3632:
x-microsoft-antispam-prvs: <SN4PR0401MB36326A69200DC5F5BE94A54F9BB00@SN4PR0401MB3632.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 041517DFAB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H8KBRdD6dWWGP+g/q3JFANL+jYVDiDX9rYmlk8Yfz52OW1TPqEUVIWBLS5+ytklIVkpYFH1Rczmj1EqL0zF5OBnXSsEk762GWlNbQ3QgibV57IYoQAW/KAFDqDyWauSw/QJYfx5obijteCP9uWwKFaMHI0Qu+mFvRrPM6VfRpBExrCCUBVAkrXOqd83t0w45BbZ5intHBEB7y+pu0R3USB4X/4LLhfmSBcKlb4r3jjdYRC7R2KvOv1CG9s0ymuoNscOgvtRB7nhgTcXvEDydzUAzuWQleLpREuAmF/9qw1PtXyTSOk4ewsX5Ms1/jLT44aVlU6J04Uq+E2f5/jC6xgky7hS/AWapOIG4TTBGyWBBudqmLyPV2sgXw2KEtPLa8rIcKVMmOwawfDU2rQkCDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(5660300002)(76116006)(8676002)(91956017)(33656002)(66946007)(64756008)(8936002)(86362001)(54906003)(66446008)(66476007)(66556008)(71200400001)(966005)(498600001)(26005)(186003)(4326008)(9686003)(6916009)(52536014)(7696005)(2906002)(6506007)(53546011)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ZZSyBUCl3VllWGm4ZifrqwmlP5NFiUHRYeScWZwWDhS90dTN19edeNZ8zEwknkaqBArWed5ptsYVTM92xqOfxKx/hEyFwwMHuX7ZV6uo0aw1Sde0Iceyc7QrkImWfhbYTMmpi6g7gW2fq8p+jD0Q0pUaWTDJqHTcHCGSmkr4d3tvy9jylNstGMZwGKfl/xtmCcx18qBEqG/2n/LLW0LSWYIXeRIqvlT71zuIM6Q0bBhpZaOMv8IxwYe/HyTp2BUEOKiD5I8uRqm7m1kTzfbIIIb6itP+jEUcOHbUH2Zwnj63Sgy7tX5PiK0VOgotIeavHGvowOtokR+sf0QeEvKTlvJV2xoxQTAwvtAqclNRTBqujgnXpbR1+AnDRgLdc07ds8cqNhSkTbJgtkPebxxfflqVyhTQgY0QjayOKi/r/Mh78LlgbsDfDu5txaAImlYawit6AzEumM1nxYxXlMoJip1KvPehpnGjin3Xpj0ln6b+d4DCyBtgvIhd99S1bIH+
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60094a9c-afc4-41f0-6a78-08d801728775
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2020 12:44:28.1924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h+o1kr4N541brjI0IbAl4s61k6HSi0K/egIyQn9UCtm44JHGnnsPoYllfBR0GxvHwPESSCdrFa6v7uEfmF4LSjBPEdvlxNym7Q5PbrYck6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3632
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26/05/2020 13:54, David Sterba wrote:=0A=
> On Tue, May 26, 2020 at 07:50:53AM +0000, Johannes Thumshirn wrote:=0A=
>> On 25/05/2020 15:11, David Sterba wrote:=0A=
>>> On Thu, May 14, 2020 at 11:24:12AM +0200, Johannes Thumshirn wrote:=0A=
>>> As mentioned in the discussion under LWN article, https://lwn.net/Artic=
les/818842/=0A=
>>> ZFS implements split hash where one half is (partial) authenticated has=
h=0A=
>>> and the other half is a checksum. This allows to have at least some sor=
t=0A=
>>> of verification when the auth key is not available. This applies to the=
=0A=
>>> fixed size checksum area of metadata blocks, for data we can afford to=
=0A=
>>> store both hashes in full.=0A=
>>>=0A=
>>> I like this idea, however it brings interesting design decisions, "what=
=0A=
>>> if" and corner cases:=0A=
>>>=0A=
>>> - what hashes to use for the plain checksum, and thus what's the split=
=0A=
>>> - what if one hash matches and the other not=0A=
>>> - increased checksum calculation time due to doubled block read=0A=
>>> - whether to store the same parital hash+checksum for data too=0A=
>>>=0A=
>>> As the authenticated hash is the main usecase, I'd reserve most of the=
=0A=
>>> 32 byte buffer to it and use a weak hash for checksum: 24 bytes for HMA=
C=0A=
>>> and 8 bytes for checksum. As an example: sha256+xxhash or=0A=
>>> blake2b+xxhash.=0A=
>>>=0A=
>>> I'd outright skip crc32c for the checksum so we have only small number=
=0A=
>>> of authenticated checksums and avoid too many options, eg.=0A=
>>> hmac-sha256-crc32c etc. The result will be still 2 authenticated hashes=
=0A=
>>> with the added checksum hardcoded to xxhash.=0A=
>>=0A=
>> Hmm I'm really not a fan of this. We would have to use something like =
=0A=
>> sha2-224 to get the room for the 2nd checksum. So we're using a weaker=
=0A=
>> hash just so we can add a second checksum.=0A=
> =0A=
> The idea is to calculate full hash (32 bytes) and store only the part=0A=
> (24 bytes). Yes this means there's some information loss and weakening,=
=0A=
> but enables a usecase.=0A=
=0A=
I'm not enough a security expert to be able to judge this. Eric can I hear =
=0A=
your opinion on this?=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
