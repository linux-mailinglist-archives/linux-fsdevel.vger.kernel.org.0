Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01107294981
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 10:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441105AbgJUIx0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 04:53:26 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:28509 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441101AbgJUIxZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 04:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603270405; x=1634806405;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=VAIBNvZaREdwAYKN6X8k/r6lEuRGa4hcP6jfwMPspBY=;
  b=kIv5oK8+cUCiIdEGkTFH61TRHqVgsy0siLPDtZIpKjMIawLF6FId4vRm
   veOzyRbXRFtP5ZSMjXQ34/i+Bz/xXYv5X6C/LLN22LzgaJbRawtE5MiPl
   hEBtuwpn8jZW0huQhkWon6PDt0gi0TRd1C8DuIad7sMDsLkXQ9x+CTldK
   ADOORg2qvJ2jr+nget9H9ZhUSD5V2RYXJLszstuPd/wx0Ye4SE2M68LSZ
   a8qwj5VQok9dNhstsB+Un8cyXug/gL8Htt+BBgATI94z8baVtKG+iMFIc
   712uw2EdDpqDS4q47I6OuLWHvYRFgqXu84zwLCilitwwO3UoSI2mX6mUT
   Q==;
IronPort-SDR: eTh8ptXouSNudNgxN+5AnlsDUQ1DvUt8lj2vOgGNsEivOjlR4/Z0odJpXCgxiyIO7OYLvBIOtH
 FhkcUPgXRklfI9tTJjqSZTsZ1NIOGQelN46NxqduiMeIO2ffbVxsf7Ifb0TiI0twPzwi6J2CAr
 XyM5V3DfbSzfoNbjM6fHzn1be3uZ4HT8LTBdn3+Avg1uqH4FH2NdLcCDbaf+D8KpROjLeoyx+s
 SXfjW48kKh8WjqUvedx5L0hZdrTJrYdZ/3JIZJgyowL5RPkbedzL1W2TYz5WfZE90Mi+rQ/p3F
 LB0=
X-IronPort-AV: E=Sophos;i="5.77,400,1596470400"; 
   d="scan'208";a="150586646"
Received: from mail-bl2nam02lp2055.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.55])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2020 16:53:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDCfpNoKW4lUeuwGJWdsqDOJ7s9aQVBC5Kv3Ldf/1FpZjI22cDDD+iY5NQaV2YWY7jfIg2lrdP6wx80s9CDACLiD8EBY1O2RYBZcVhZ/ZagBd7y1fhluFR3EoeAiRLl/tVt0/MlhCxW3w9eZ87EUz8Lc6SeIArJPvvRKGSYgKHSH5YvRznWIXyn59riT3X0rqeiGPwkIRvgGaCDETQvHNcXGLqoR0bWyFg9T6gRpttG4UWJEkcMTvgXYegFQGt7CZ0li4+aoTBhlOh99g5BPo+PCS/A7AEiQFqIZYNFucCpOS+RTCr+Tnah7VFTdL0JZ9lCd3nBa25j33tIAc4Tx4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9zb+1FcYLLK72Gla3PPH599CiLS5OGU5Jtqho6wTCY=;
 b=XfwXxPH4W7l2CEtcZfBdYqnoy6ZoHI3p7+lF/m87jGbjvcs9jUx9Z07+CkEw8ku+9NNdu5hltbv4gaAmZ8m847RJKwX/xD9sig/NqmCR846NAfF8GAmNcMqBmRgFHpUrmCALBvUIka9OApTvHb673fYl/Dlw8/nRh6eyFc0jjOulSnbUdOJvtApFNTV2CSvU9YzT/LWUbCHLasORIMAVx69GanNr3sQyGC5whO3jym3EiR7y8364ylawzC1zQnD8uBk1ZY2tjnSnEGAenYXwJ1xssi+/y2EIZ701T41qB/kpG2YI6NalWy+z4cyncCkVXTvJr6KHFpjYoqabr91SDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9zb+1FcYLLK72Gla3PPH599CiLS5OGU5Jtqho6wTCY=;
 b=DLGYbMaHCBrY9HV34FF7HczPD7HiRa1/XcKcwbYHhzDwbTYnkzbOnGi4JMhXQVao9/6xuMlLwYQJl7z5Xww7JrMjQckLoAthlNmfUIxOWbaKZHo8NoJuyIqfV8ieInJV81h2qYjKWOPyyzjTZG53GshYVB1cYe5IumzEwv+ZzwY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3680.namprd04.prod.outlook.com
 (2603:10b6:803:4e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Wed, 21 Oct
 2020 08:53:21 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 08:53:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v8 07/41] btrfs: disallow NODATACOW in ZONED mode
Thread-Topic: [PATCH v8 07/41] btrfs: disallow NODATACOW in ZONED mode
Thread-Index: AQHWmuact/Oj6EsLmk68O+cvghRL9g==
Date:   Wed, 21 Oct 2020 08:53:21 +0000
Message-ID: <SN4PR0401MB3598DDA2919BB7707D1E4ED39B1C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1601572459.git.naohiro.aota@wdc.com>
 <c5f6be584aea6de94506d91093be11c6c22e6088.1601574234.git.naohiro.aota@wdc.com>
 <20201013153917.GC6756@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a4aedaa-b029-46fc-abb7-08d8759ec355
x-ms-traffictypediagnostic: SN4PR0401MB3680:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB36802D84A79C50A6912DD4819B1C0@SN4PR0401MB3680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4TpkFRQoPBGz7iAjEUC6I0PrUcvR8fwgEjFnNPNlFuuHCAPEhFik0Pz8D5RDoRuOwn2jjMVcRh2POh8lEddyKajNArQiearK5YdfOqTpG/cn9rrJql60sET10DMR9KN5+XN8fUuSBJrp7r2EqncN7vQPc7NfPAACewlwrE+iBcn5JzxXrHoZSWU3l+K+R3paiZI/dNKL8XwGvMVTY6/g/oiyTPwOx4TfbuIgjIL7gYb2lZ1lF3uIcmySXWvqot2ueH62+fANe/+sc9bK8ycroZfLvfFN9xCVI0Zi76T5kZV/5odEeOR4DgNWzlGo98vN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(66476007)(316002)(110136005)(4744005)(9686003)(52536014)(54906003)(66946007)(5660300002)(55016002)(64756008)(71200400001)(91956017)(8676002)(6636002)(86362001)(76116006)(4326008)(33656002)(2906002)(66556008)(186003)(53546011)(7696005)(6506007)(83380400001)(66446008)(478600001)(8936002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Toe0TN9byW5xr/133vWc75u4I+w5ywKxmVl9ufLmnjWqUdrIH+5+2oC/wTFMciAIes5CYfGCheZEEtOE1lChWDOFR7clPMSmm74Yg0sSMhNAfb2tgpwdNJ3nuKfVqxqYNY2rCvgfxRxeGiYjNc/a8/0DOADKd39gnHFHAo7VnYyECtW2YXPb7VXspsOyqp4hhewQq9/EiohOIsCouyw98/G0h3sJeStFILH1P96kKRAQty6LVGMZzGrYYmyX7rG+zYuXG0QkjwrpxrOvdJT11UIGPsYn9dhWP5RgqybSW3zu1HuBbVgbtR3NOuo/eg6RRdmaN4HKsMlkXEsrJ+oPciIRYG+NGXb5ptoqeENsQOKRiATiZ4RzlGzXjffLRm8arwVsSEnoOox5HbDPBNU5XKGiahXl2sC8ydjMxpkefq5zGtDfsQ4i46Gy472fTdiNZnthLxfm+BwjV1DhYwUka1mNfkC9F8jbGD034oIo7HI24g1egvhl79MnWVg3pugwSIn1Uq/hV3YQEpaWu2cpEaPEWtAjQFcdltyKgecPI/8KU+dPEQpVC/sDv/VgJQF/DbX2Xs5MNJ6WQS0aFjiRO/GPNEGGn9nA0b0VMLhwsgPwHWEkBlU3biVE8vrAQEb76UuCt6HL0MrJTyRY+fzy0g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4aedaa-b029-46fc-abb7-08d8759ec355
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 08:53:21.4439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cCDIYY5/3axeqUur3kfs8mnqEGi/Ey/d+Hs9sDGdAWOGatKDrTCZaelReIOpwk+juVtNFy/bIw2RBgLMWdhU1skEb22ddUsAirCIEidOD8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3680
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/10/2020 17:40, David Sterba wrote:=0A=
> This can't be inside the function, the 'type' here is for inode that=0A=
> does not know anything about zoned mode. The right place is after=0A=
> check_fsflags in btrfs_ioctl_setflags in a helper like:=0A=
> =0A=
> 	ret =3D check_fsflags_compatible(fs_info, flags));=0A=
> 	if (ret)=0A=
> 		goto out_unlock;=0A=
> =0A=
> and check_fsflags_compatible checks for zoned mode and NOCOW and returns=
=0A=
> -EPERM, not silently unmasking it.=0A=
=0A=
And done as well.=0A=
