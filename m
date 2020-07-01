Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB3A21051F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 09:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgGAHe4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 03:34:56 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:19927 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbgGAHez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593588895; x=1625124895;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=YvIBRRoqi+k2lSCZp+sNSpEy/Mx2AG8cvht5jwLxmNs=;
  b=AXtv7+BTHxeUEBSNYiG9fJkorYmLOoiDkyUW2fBZcYyn27G20G566Euf
   SBnmaWextWG7+vVZYMTT2Nf2rFPrJGxCh99yuOLBgk78SYNX3A8Aexv9I
   fmLiD21UHKFQi1bmHgkaOTOYWNVI38OkN531RCsYVYe0OimL7T75IwO1o
   Xpfuz12CjFD8hOsmE6k4r/Kz7SxKCZsRRcbqFS9Ri07zvBJoO1liqhV/7
   9eF4sjSYzqyyMgt7yfMkE/aUZXteEgLlWQBhuxShVG5XffncJBoO6JDqk
   WkB8/UiChLGVhW/jScaqmzuQWQl5hUeWio3Cofiw4RsaChpISWomrFN40
   Q==;
IronPort-SDR: zaS9JXgBWA8kOSoJFoHO/EcrU2GPUM8zXHPC2PPiPNGbktRDyZJNQBUyQxTVk3K+BloJb7eGnR
 /CpYrU1S6r2rbvlFHbvv5tGUY57cP8N1GD0/CvrAcNohf8KsGjFwhpgfZrw9V4YoIIITXjLnZD
 DCdSSOsnpoDKmwttL/EKkKf0QUlpcqbYEWuYAg/25I7yEbpcUvYVBbgxpnx/NhGYleJv/PlaHm
 F3Bieqe3eAQJNrwKutgu8q5VArsua3+bdM5i616MKB/8FGZE8fVjZBbFSkGWtF2i7cwi/TKJbC
 i50=
X-IronPort-AV: E=Sophos;i="5.75,299,1589212800"; 
   d="scan'208";a="141353715"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 15:34:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAmUfG8gKnhwL8QnmHHZcyQ9YD5Fh2vvTv6jWJUb2Ocgds1BbGWEbxg3m9FbefJk9tyyWKbqlhp2RcE4QnaDGrKbCPQgwhMROWV8uzKYrmaHAQPFHzp/5Fag7DtaMgWV/OA5w1pPwYpHmaov8hN1E41G9B5mGg+Me3OZRXr77S2S/USLKkLG10stlKMSvhgK79Ii34HNvRvB8ow/nXq2kcbndG28an2Te5ZcjgZtXfDIgh+RXgJfzjNECsWCIEWfkGYm7bve891SAW9Wd67d/sjnFrY8G1DqvN+8IXwX/mwjeO+IPDzLPH6FxmUpxjwOh85srfr1H+pqdj9hNS9vcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TD0ZxQjBk1+BdFQJxKASo4aebYPWew7smXgsNFd5/Mg=;
 b=FsBTwNrubjOzW6wYR4GZ+y6dxXbSHAHckXuFZWayODXOsGoN64UvwjShhWZIWn8kLt0tBcM8JJT+Vr3xkjabJ6NnPbrEvfxKlZn6hwwIrAYZWrImBpzSUvLFMuL6vYzb4yPBX/UlB5b2+Er1ZPvHlMCMFzwh140L+b8RR+Doc+cEKRYI7VFH7pEhaE57E8Bo8+V18JNYrO2upZTOLuObD8x+K3uxUtDTc233iJxErtPZU4tjrtEQvL3HJ5h/OG3/JT8PXvRxLZg+VjdXyZTqi+8njW7u1BLHvZbKAjk+MO1kMHVgepNlipHZrYClJvzw8nbddx2gm8AfdJ6+VL5uBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TD0ZxQjBk1+BdFQJxKASo4aebYPWew7smXgsNFd5/Mg=;
 b=il7CJ7oLHYoHcLS5gyuOaJ2eVY8fUeSwObQtAFkmJOswM1U7zlQ1Y+PNjEQQDDVTO5wBxObPcw4WOXzPSe4ULmf/hvQoY5rC1Hl2cN0wVhf/FcJcCs0ol9g/zIHNYzey3XE1vSsLd3cLfYWiiPhaEaeRsXwsdkWd4G33teQv8xM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2320.namprd04.prod.outlook.com
 (2603:10b6:804:16::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 1 Jul
 2020 07:34:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 07:34:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fdmanana@gmail.com" <fdmanana@gmail.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "hch@lst.de" <hch@lst.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 1/6] iomap: Convert wait_for_completion to flags
Thread-Topic: [PATCH 1/6] iomap: Convert wait_for_completion to flags
Thread-Index: AQHWTkr/uY9Di/yWiEGgkXu0GpZGug==
Date:   Wed, 1 Jul 2020 07:34:53 +0000
Message-ID: <SN4PR0401MB3598E2A7A517F94D574E59C79B6C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200629192353.20841-1-rgoldwyn@suse.de>
 <20200629192353.20841-2-rgoldwyn@suse.de>
 <20200630163527.GZ27795@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:85ad:d97d:6da7:d614]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c88fb0e3-df0d-44f4-45e0-08d81d913ec1
x-ms-traffictypediagnostic: SN2PR04MB2320:
x-microsoft-antispam-prvs: <SN2PR04MB23204985E53E0ECFD503EDD79B6C0@SN2PR04MB2320.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xzq9SWvr4hslWgMWOwFKcJDgD49Ew7FGtGgTiq27RHLzwzDd2FMuKYPVwAI4K4dUMnK2v265/rmdWweJkI8F/gjqfW7MEl08TLdtn2/orwMmU4q+00gVTUp2wNCPL03ulYoXE00okUQp8QiAZ4pqv/gsA3fNWfgHMqgJ3NTkbGxHCUcseC0Dpebg9l/Sl6ryelEbWiiNXm1dpoo6SQzTCqY2Qvj+M+ZrhCjeCvFjaz2rJ+ix3KdkUIp3TMy+ATIpltteYImWejx1bs7jvAvTz/Cs8y6g5o4tqod24iOmAvt8eWkt5oyptsxw75v9BqDFy3d6yOgVucfHHX+JBosOmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(7696005)(478600001)(33656002)(53546011)(6506007)(316002)(86362001)(4326008)(8936002)(5660300002)(52536014)(110136005)(4744005)(8676002)(9686003)(55016002)(186003)(71200400001)(54906003)(91956017)(66556008)(64756008)(66446008)(66946007)(66476007)(2906002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6+vIIayUDcNZg+3EZOJc5PQzHWqS3+KqqASYM13KNVCi94se2WchIIsta2urM03emij86FYuq1jA9UXgmBHE40cDZEtwgfrYK7v7HZoISwpQ94TVi/p7RSHTaXdS9Q+0mcLVxOnYXqOkjLpBl8fJX3z3Ioh84pCvyOFKouwN/K6Kx7eO9M7m91azipekeVu5s8HoRpD+5o3GtstymytwvKBxlHEiBrKIw1I9N8C2wcm1XUDzTraw5FGhKEUy9jq0CruISdeCc0YtJazOh6wzy5hQtZNygRpxfTr2+uKi9bF3h8vS3Bb7Sv5SNzHs5eddOi5OjR/2v3phtE+FYnPwpStalBBfxky8oVYZ1OddDUuFhWCKDg4E6UqclmpZk2ciaBwCsOlu366mPlzUlTWmj4gpzEdqQ1qVPnjmPMYIYazM25liNLAB3SfWILyekZEVGWjR9aNgFKyehkYROtkwhNmrVrvWo3DOQiCIXYpM27sfvFk6ImzwTspD2Kjhey+R+xHzi758aCTT+zSt5lmWJ1/vIsnSGByBu2MCsWygUxvUtAgbvUTMsiSfTrSVy64/
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88fb0e3-df0d-44f4-45e0-08d81d913ec1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 07:34:53.1843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: daPmYCdbm3tYxdOTmnubn8qx5yuHCCMufIRHJ9kUnLl4JnZU6UiIiK8iK/rcTVhGECeJESJWecawRiozinKE40MH81CA0enkQZ5+AStxMj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2320
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30/06/2020 18:35, David Sterba wrote:=0A=
> Though it's an API change I think you should CC all involved subsystems'=
=0A=
> mailinglists too.  I don't see GFS2 or zonefs.=0A=
=0A=
zonefs doesn't have a list on it's own. We're using fsdevel. But both Damie=
n =0A=
and me are subscribed to the btrfs list as well so no biggie for zonefs.=0A=
