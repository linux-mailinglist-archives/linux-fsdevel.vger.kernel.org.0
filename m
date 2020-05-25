Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FDB1E0C51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 12:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389930AbgEYK5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 06:57:17 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:14769 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389856AbgEYK5Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 06:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590404242; x=1621940242;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=KxdnSxllOq+QsPCX4BTAq0lX1zgGLjMJANlDRDlB6tU=;
  b=KRgGilTZOZhcwfjyORZJZhp68YqoeVpsqwRGw/cxfR7TGNsw7TYrfk2y
   0cfennITncaMHEsSBUZZWqHn4OPsXWL+LLvoHM/kNbyx6B+qaGRRgNOCq
   7BdLfjs7UYurjMnnlDMmIN6cX4jVDRFVe4V9aRnFH/Ecaxr71EaQrKj6K
   n6axN79/VZDPWR/kKB0Hw00M110tVwnkhA8aZ4UyGCa1MjxvsivAJA4Ih
   FMLW/Akg1Cqg3uj5iJZhsK0P0/pvvqPF948p5HqVbelMtCLNEkfU32f29
   pBNJzhO0LdJvm+mqppkn1/PK8lUHRqVr3jNqZ+7G+UtDqyZzXYBCoXxag
   g==;
IronPort-SDR: a6itGAK27ipYX888lgvnH/LzwXWNUCWyjH3pVXqxmC/9O2X3GJhg458qmjBoADV0YAxLvWC0sx
 pOAhWxckcu6LIYZ9Tq6Nwcf5OcWNU4kNaSA4VDm3Jr9Es7GPW6pNKkW1KFsWSIQsNGOtD8sy7K
 KpoZiNdhKbhMLbwQkTHPzOeSMC5TQ5SnKvPbCHNEQCIMkG572EP7WXAeXXf9COqqFukbrOuZNJ
 SVqSBmsH68BEmvWHdfIlms+81+vMApVi/fnOi2+zAxVar34qAqX9vpx0l2LaQsdRBtfNqU+SwP
 QsY=
X-IronPort-AV: E=Sophos;i="5.73,433,1583164800"; 
   d="scan'208";a="241242031"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2020 18:57:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAdNj+mWhCVMS23XAtT2qV7YKbYgf00SVTpSknwJdQCs8GyvTZKR9/4VmBX5vhBDNJDo01Pb/mrhyzuPP2+KVMZkjl0aPSO3wR+g1Qc0+bIW3kHG5PYQNf8+9jbctSTY3pnl6YQlnpVsO8mvoHZb7tFHfTPlmhCAKCZrBf39Qsx3Zxqd76/wxLCZ9ToF7QUEvhwrAgKo3QlXSaGDsd07FI9Y+x+sET4xVyzrWIiCilYX6GZowQvlPRNg9muUSCyrAIrV45m/N0d4/k5nQ7ch1vlNyby3y63y5KV+aA2xqpATOIAWc2qUhuxNOW0AugVMIciSscmd/l09XYzvVjsuOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWsU+yANSp5Yo236ImY+NuUCTCq0aBgNwNfuMZv3Exs=;
 b=M5wek0UwvqHDEd8wQfK+G2uX7yIudnpfCegwMbnN1JvUTs0BQsS0HQU5eSfzUpSa7yWJXxAuaE9D2ANa8RBff33ESm5I1z1VP7/M1mAbz3vBle40vf6lHYJVZxMWk/8Ou4Z/mwXJbdgjjWIFw1h9VDVhPADvDLczAY9+vsYY9mq8JVn4/CSr/HaJ3EWxqDmRcgT1wVPkYH8Kwr1y/1NoA3w/GwzBjMmVPEvaDBqbRnJs/KAf3rROuvwjz7T9HEQnlcSfX0eRB0L7vVZJCiMT5FsYLZDxO/DeiWhCeSHlkA05hoGLvX7gww4JlejYe5RmmgWV6K4phN+snFPJs8vlmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWsU+yANSp5Yo236ImY+NuUCTCq0aBgNwNfuMZv3Exs=;
 b=z9BncAGWKy0IvgXVbkWSnOx80Cg8yRoe+4JGNozOE6enVhSVRnaiqJTrdpUa/HSIGFzlaDVVFuRMMIIJ9dJcKoFwtX/v3Khq7B9UzxboBKPSiIRcZT8MsYl6DTIjlFOniyl4RMSr4Njj8Xv/e+w+dsm3134KlZG/Y0RJ0RTlepI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3584.namprd04.prod.outlook.com
 (2603:10b6:803:47::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 10:57:13 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 10:57:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Johannes Thumshirn <jth@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 3/3] btrfs: document btrfs authentication
Thread-Topic: [PATCH v3 3/3] btrfs: document btrfs authentication
Thread-Index: AQHWKdGHpFk4qUNYxkaDbw38lHwpUg==
Date:   Mon, 25 May 2020 10:57:13 +0000
Message-ID: <SN4PR0401MB35983AAF3D05F84AACCF8CF59BB30@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200514092415.5389-1-jth@kernel.org>
 <20200514092415.5389-4-jth@kernel.org> <20200524195513.GN18421@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd3238f7-9d80-4c30-68c3-08d8009a6196
x-ms-traffictypediagnostic: SN4PR0401MB3584:
x-microsoft-antispam-prvs: <SN4PR0401MB35848211FD59AA646502EF749BB30@SN4PR0401MB3584.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0414DF926F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wZQVpS8ols8Y3N92ix7nNivxYUwFfC9ABNv87mto+2Zs/nAkn+ezlK4YhuWVk42ga8Ohw+dOSwpnOLB+s4ptD4hwsTBODgfo1P0lAIp6tfdbzxZlh/BiWnRuNoulYbAJDP2C7xkQd3qsTkCep/DfnF9VqPcNqEeszrRsk6HfVYH8jqtH8c9qF9TbAhHv4OxlPryZW3pm7ZyxQwE1qL5gHhGXkx3Pp0mJPs5Asw7Kf7Rz0fRwAWCXhOIK1exyWnQVIwZ8OzFMur53ZM32EHj4vlQaqF15Z7qVnxSBS+pAtRCf5Gy8gJsSl+mhYSdX7XrF4TW7bzpu2ACh3VtGBnMQNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(33656002)(478600001)(64756008)(76116006)(8676002)(8936002)(52536014)(66446008)(66476007)(91956017)(66556008)(66946007)(5660300002)(55016002)(4326008)(7696005)(26005)(53546011)(6506007)(316002)(71200400001)(110136005)(86362001)(54906003)(2906002)(186003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: owhBVaKWWi3s/MA6zv06saS0dNotG7UYnTG6W7KHk92PIz93muiC1AB+h4pvnoRx/EUc7NLjy2sd5bi2BHERnwmO8DdyGXukkNHp2DmOMuqZC1C1LIQ1Pe8UVo1Yx7se9ahCTYaqDjbDCBA0G1VOE7JlGEQEPqua1PmxiR5qE5TEGm11cXBvJxlcbWHchfrJu/tYSp4n5e3dTmSLRQ7w5u6VdYuwXcvuT0xKQKshDSkULD9TX+22mKqFL6gIRu9cu97t/u4Iqm/OOVAKQtrS8j3ZDAj4Pn98u9lzflG91MkYCmE2dDZGZJvH/YF9Sps7CV7ej4vaiaU9o/Cf5cHHp0mytEqSgaeY33ZRcWrl88rwPjwt+KonTc7hD5M0GP0B6tvlf6idBKGqYxUIWMv8IjL1XpM/E2Em2/wIOMri3pupoaP1uO7oQxlqsE/t9imF8FPQK/YqflNsqFnx+vwgU8C+7VCvGTQAA4OAbehjZbLJeJocqL1WWtK6IRVLRtB2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3238f7-9d80-4c30-68c3-08d8009a6196
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2020 10:57:13.3656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GjuBXUFwMv7SWdwCTxAjyH1w8n7L0C14QQndECU9PDa3dchJHgZewybWFk1+0nPZleTImdOuHOhcHPTefeOtCviY6JTmADrrshmX70K2AQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3584
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 24/05/2020 21:56, David Sterba wrote:=0A=
> On Thu, May 14, 2020 at 11:24:15AM +0200, Johannes Thumshirn wrote:=0A=
>> +User-data=0A=
>> +~~~~~~~~~=0A=
>> +=0A=
>> +The checksums for the user or file-data are stored in a separate b-tree=
, the=0A=
>> +checksum tree. As this tree in itself is authenticated, only the data s=
tored=0A=
>> +in it needs to be authenticated. This is done by replacing the checksum=
s=0A=
>> +stored on disk by the cryptographically secure keyed hash algorithm use=
d for=0A=
>> +the super-block and other meta-data. So each written file block will ge=
t=0A=
>> +checksummed with the authentication key and without supplying the corre=
ct key=0A=
>> +it is impossible to write data on disk, which can be read back without=
=0A=
>> +failing the authentication test. If this test is failed, an I/O error i=
s=0A=
>> +reported back to the user.=0A=
> =0A=
> With same key K and same contents of data block B, the keyed hash on two=
=0A=
> different filesystems is the same. Ie. there's no per-filesystem salt=0A=
> (like a UUID) or per-transaction salt (generation, block address).=0A=
=0A=
Correct.=0A=
=0A=
> =0A=
> For metadata the per-transaction salt is inherently there as the hash is=
=0A=
> calculated with the header included (containing the increasing=0A=
> generation) and the filesystem UUID (available via blkid) or chunk tree=
=0A=
> UUID (not so easy to user to read).=0A=
> =0A=
> So there's an obvious discrepancy in the additional data besides the=0A=
> variable contents of the data and metadata blocks.=0A=
> =0A=
> The weakness of the data blocks may aid some attacks (I don't have a=0A=
> concrete suggestion where and how exatly).=0A=
=0A=
Yes but wouldn't this also need a hash that is prone to a known plaintext=
=0A=
attack or that has known collisions? But it would probably help in =0A=
brute-forcing the key K of the filesystem. OTOH fsid, generation and the =
=0A=
chunk-tree UUID can be read in plaintext from the FS as well so this would=
=0A=
only mitigate a rainbow table like attack, wouldn't it?=0A=
=0A=
> =0A=
> Suggested fix is to have a data block "header", with similar contents as=
=0A=
> the metadata blocks, eg.=0A=
> =0A=
> struct btrfs_hash_header {=0A=
> 	u8 fsid[BTRFS_FSID_SIZE];=0A=
> 	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];=0A=
> 	__le64 generation;=0A=
> };=0A=
> =0A=
> Perhaps also with some extra item for future extensions, set to zeros=0A=
> for now.=0A=
> =0A=
=0A=
This addition would be possible, yes. But if we'd add this header to every=
=0A=
checksum in the checksum tree it would be an incompatible on-disk format=0A=
change.=0A=
=0A=
We could add this only for authenticated filesystems though, but would this=
=0A=
deviation make sense? I need to think more about it (and actually look at t=
he=0A=
code to see how this could be done).=0A=
=0A=
