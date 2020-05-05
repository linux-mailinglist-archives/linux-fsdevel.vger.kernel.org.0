Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A171C4FF1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 10:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgEEIMA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 04:12:00 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25034 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgEEIL7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 04:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588666320; x=1620202320;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GV59OBYDlOVpeVeLxam3CuwfP6fJprW0Uhi3D+Jvjww=;
  b=NGo1li330f2tZuIaiX/XhUbdq9KihUx6eSguqaBvY7HaNbmyplrMbn7G
   JG3Knu6HHolMuxBLFP9vEAcvFTFcpPLft429lO7IUOUyI8JXOahRmZ5LE
   Az5e/QNihdf++noOTP0bXX8b+cWCH6/5pc3ohd4+bWhulGOh4ph9uwYKd
   TbMT5coNz8dspXltdoSIEhqRQc+cxqtCHqRk84yzRDiToHRVvnE4yQyZa
   waWJosLNwWi7+lvTzxdZ+Oa05miSGUc9NlprNTZ6I8qeBhYcAtNOm9L3P
   82uf4+4rDkayEakk4QDPp6dZyvHs9NQV8Jw6AxRkycdD+B1TGQjGzZBNN
   w==;
IronPort-SDR: 7ak4saP44UkG1eljJOl8Vf1oPV+0IiOW+AJxr6/cnnZUMszoEC5c8TZeCA/L7IKEjAwaBeMKBZ
 O91kTFOXP4YFzP89Tl5qF1E1yz0vj1gHERbdVBV8Wir6ffIb2ByIr3wl4/7AerH/8uWrUBNAut
 VRFSf6KLGRK4OaHQUFr5xpJc20cK6sfRebkhjnvwO+bW0ggQ8ujSzWA4nRGBInLqwXOtvnO+Lr
 0+yCsqoRZxFKkXaeJTQvdgK0WDvflrpsEvFCTswTu85UXyMX1TrLqa8WW02YhJuduuYx6Vr+S0
 AkQ=
X-IronPort-AV: E=Sophos;i="5.73,354,1583164800"; 
   d="scan'208";a="137271656"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 05 May 2020 16:11:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBrLXUgB/+0/ROInqetw3plShj3xGd4dw8ZP7u5I2dunH7XIfP32Vx6/j5CD/b9K+hsTvxgN7x07qddEfeRHf5wILpxQEnFQKLjC7iAuDAMPGlnSlcfxi7+IYIqXw9kl7Z3vBdBxpSVKVcZ2Qkohrqide7ieXDB9FrEGngHQ2FTHfKqC8qaYJPGf2nMWBJfp3ZLJs27z/Z+s661EywbgxAsnz0nQTsvZy4L4DzKWlKQVImt9Dmd+mzxUjjEZiNGB5XXqafeMGjHfFg3nqERA/sfRn465LKdaU77ZiYbQi5K44fmopxydplBRj1B+k8DhbxTGoHmtATuwMFHIeBuWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43Gs+ZrV2puft8xmJIaGodQHMC21x+cYyVTf+Unp+1I=;
 b=Ro29bRHc0zMyxf548jyLdgDTuXIz8JoqSptzfI9SBXdthPnyIRohae/yCKGvq86f5FU1ykqj8dxqPi7g08pHA6s5ffM44sxtkPTz+ZQlFota5ha6uu9DVJuQwNmn9HNQQKI25Lqdcs/AcbEJZWea+sjIuWzJAr0g4SE2LPAiNc22l93rFwRbwTIYsGDB7NtgDqVobFpAynad6Hw9Runs7Z+riXCGrUubXmfvs196PUqypY8PGbhGk33VciGJR3rx8XARhk9tfMgayLQoSaq9szpcPIH6lc0rqBpUcHzILn9ZyB45MK92lRV32L6BTLqpGz7zGwI8RHXHi7nttxQvoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43Gs+ZrV2puft8xmJIaGodQHMC21x+cYyVTf+Unp+1I=;
 b=EaMhM8GP/yBunzbW83xye2nrlM6GJfnCB83SntGr1LXuFEG/okbi0H7fUyyoDle2AhlnDMhfvWVvtntSHumXsdTHtAFKrCZqJtCzTGbKvYCjxcqxiTl4eyJsHPiYV8BUVXPZC4F5EpXx5nOFChTuqj4qaXFHIM2ie793ufnrfCg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3565.namprd04.prod.outlook.com
 (2603:10b6:803:47::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Tue, 5 May
 2020 08:11:56 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2958.029; Tue, 5 May 2020
 08:11:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Johannes Thumshirn <jth@kernel.org>,
        David Sterba <dsterba@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
Thread-Topic: [PATCH v2 1/2] btrfs: add authentication support
Thread-Index: AQHWHUw3Fjk34p8J2kWvUrIfOj4HzQ==
Date:   Tue, 5 May 2020 08:11:56 +0000
Message-ID: <SN4PR0401MB359843476634082E8329168A9BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
 <20200501053908.GC1003@sol.localdomain>
 <SN4PR0401MB3598198E5FB728B68B39A1589BA60@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200504205935.GA51650@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 202759a3-280b-4cce-1a4e-08d7f0cbfa77
x-ms-traffictypediagnostic: SN4PR0401MB3565:
x-microsoft-antispam-prvs: <SN4PR0401MB356589A738FED8F3285376E49BA70@SN4PR0401MB3565.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0394259C80
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tc9muOsHFLpAMcCArC+vwA92sMc80x15BQi0KRZ2xR6WSrjmXbr6Ob9Ck2Cz/BB+ilzATYa0kIlJJggVSP4guSgxX0wYr0QY0vBIGCGTD4iJ1tePIw0a3oxiW2bp7Znfm7+moHJyFUufdj0eAx+sOSfUZp/kqV5hzc4rzG2qANIZDWfZkXlbRsbmzHOrT7NNX13yphvciMTQu99DqHAB4KjrTC3gB2uT00jBA0s6K7V60E5dULajfZR6Z3m9VwWpDXgC8UZae4wrdJShdnjzFNIObv06a6FodK8ceoSVrZ4psUiWByxrCSmihwcaMmVFnEBYFU5dZMvEVURXr0ct1SvKOsVUa7j1f+F736KPVDTodRK68I2u/MnaWcfbdC2Lz5qv3jsU9txO8pSND4o9c2cQqrZIPC30Roej/aghcTf6kT07+e3BlyESH9jQFZtfmLQ/ns1nUz+XTruWQPc9tC4SEkD65eHrnci2ayDP/dfeE+1W/4cp2FEetsFaCdzcuvoey+8XbKcqt7I0jAGq0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(33430700001)(2906002)(53546011)(6506007)(478600001)(26005)(7696005)(86362001)(186003)(5660300002)(91956017)(76116006)(316002)(55016002)(9686003)(52536014)(6916009)(54906003)(66556008)(66476007)(66446008)(66946007)(64756008)(71200400001)(4326008)(33656002)(8676002)(33440700001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wy3mRtUJ6/f1uzWHzGCkOJA00L8D2v1K1mdpsTQv+6VDpnQGU86xduceVqvBRN61d9UlSvt0D9CmBRyXaH70N0Wy/UwgfnTOcrS5kbf5yYSoC6jbtVfHj/fbRbCJJLDegd1Q/OLLBDoDTuN8/5jQ6/z7vDSg5zFRueYVhUBxYz9UOcDhKb1aFisUgONRlTEZXoWH6/BCkpFcRcVXxBe7svSp9nklo3o0akmYT6wc3EFr7mwo5DpLxpW38NZyczIPNIPFWc7QsbVGzFLP894LnXPQ3QZlrvSrIw6gCflCvWT6/5r/3Um4TRtgfMTvxZkTzto1qQGi5bo+G4JB7sv9j0o0d9zHqYJFcFlg6Gwrm3Qb86yOhvMxmBtB5j6NXTWMnXBHps5x0Q5wjS/kXxEyK9Uwqx4/A6HMt8Hkn/p7vq88pOd48Eu+s++NUaTuhjeA+ASW+4LG9JqW2dEiEANA5pRscsVYgz4CMP58n7z98JrDo5RKohqnfAGYQ6eT8039P9l+jwLZPb8fWgyeOKQbPQcYt3vON4aaYXJxdlfb4fOv20wg4aAYGJgCbpmjS/OlUxY8UogvJn52xqK7s2NxL5DpuPlNFHqhGE1908FFPy/BkRvnHR3y3uHPChKUSLffVW++qE+ItpsY+sfelpkOsLnb/SVfwrxkNmUrh3Ufwk29eyyPzYTKaRuhdWTk4A8P/Vm/9gSrSWz2Yk//K20GqSEbChcDxLTfpXA2IO7ruGJNcHunF7+Tptg267I14BRtLQihEF1PL81xz4E2yajUgDj/fTgdzr//AoWszyEvGtM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 202759a3-280b-4cce-1a4e-08d7f0cbfa77
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2020 08:11:56.5952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c1NYDsR8ysYdAY8lIp+dABKNttV421iVdvJDbgIT3SH5xLRUEyoavMC7EsuNP4EPUGQBIVRrpSjKW7ZAozfgeeQfI7ffUByFm5WA+cF8J4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3565
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/05/2020 22:59, Eric Biggers wrote:=0A=
[...]=0A=
=0A=
> But your proposed design doesn't do this completely, since some times of =
offline=0A=
> modifications are still possible.=0A=
> =0A=
> So that's why I'm asking *exactly* what security properties it will provi=
de.=0A=
=0A=
[...]=0A=
=0A=
> Does this mean that a parent node's checksum doesn't cover the checksum o=
f its=0A=
> child nodes, but rather only their locations?  Doesn't that allow subtree=
s to be=0A=
> swapped around without being detected?=0A=
=0A=
I was about to say "no you can't swap the subtrees as the header also =0A=
stores the address of the block", but please give me some more time to =0A=
think about it. I don't want to give a wrong answer.=0A=
=0A=
[...]=0A=
=0A=
> Actually, nothing in the current design prevents the whole filesystem fro=
m being=0A=
> rolled back to an earlier state.  So, an attacker can actually both "chan=
ge the=0A=
> structure of the filesystem" and "roll back to an earlier state".=0A=
=0A=
Can you give an example how an attacker could do a rollback of the whole =
=0A=
filesystem without the key? What am I missing?=0A=
=0A=
> It very well might not be practical to provide rollback protection, and t=
his=0A=
> feature would still be useful without it.  But I'm concerned that you're=
=0A=
> claiming that this feature provides rollback protection when it doesn't.=
=0A=
=0A=
OK.=0A=
=0A=
[...]=0A=
=0A=
> The data on disk isn't trusted.  Isn't that the whole point?  The filesys=
tem=0A=
> doesn't trust it until it is MAC'ed, and to do that it needs the MAC algo=
rithm.=0A=
=0A=
OK, will add this in the next round.=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
