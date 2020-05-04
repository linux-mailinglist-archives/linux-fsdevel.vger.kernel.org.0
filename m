Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D5F1C34A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 10:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEDIjc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 04:39:32 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47679 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgEDIja (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 04:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588581570; x=1620117570;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=fVjt1YcGebSwIDPmsljMIYvRmXY5oL1Lyhuu+9ulCWE=;
  b=euCRRdFMB5esGrR8VoQm2WFs2dI/E0ZSR7WH357PlmS8TFAsFj/0RdQl
   3s0MW/0yBKqlThjjxIs4X8d/m4w7qZwekOKvA1wJbpn23kdsTqeSDHYRo
   mwQ/obtz46XYXfzcHh8QED99N4OiHK33IP86nWJeSkTn1JrnxMePPCEcm
   0ZJdNnKLCUmt5vmQeQv12z5je3Fw/feYdiQhAYNOn/IDNUTbmrOL7ru9n
   ZzkCRdRYDJp0kCOtP5o/mc4iHu7RuKxBpgqmuQ2XjgJYogyhCI+XdfkJC
   tcK1hX95t8FBDU4mJh6DzVWNIOlu5q1NNMhsnIbeXU9LQFWtODoK/y06W
   A==;
IronPort-SDR: iiq+lWxDsRsILN80yAtui2n6V0xaFvSRNMncIbAuuvUTZWtCh/1cpC/v3UiIiYTDRS/E3RIDVv
 RhzNJKBgGPGoMOiBpjkObsY01xGNVs6UPRcyMrPQJMKnSOL6Q0vh+OUqF/OU8eFLlmBPsrSmfy
 3w5erg+VyWf6h4e9sP3Gvx2TC7UNULQpJ9o/5EiT41EMcwhCA/iNS9GZnQSMvdMbcRE4PnTL+k
 VyEt/zNrsYk1vru5GlthivpdrE6UaQylXG1+qWmJ6dyCAUZkAzRjI576x9uw11I7AdieWGT3tY
 oMI=
X-IronPort-AV: E=Sophos;i="5.73,351,1583164800"; 
   d="scan'208";a="141201327"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2020 16:39:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSnX3C6mv4+b042o4oyaXkL7xQqi4JX3EAiky5M4gsDlnfIAr3y3IZTA7mdrq/i0T1a6Zp5by5IP2ptGASmW1zGUctrb4o4u/wbazWZo5JqsS42tmABsI4/NwACICYJ8g+iJ3UeU/WRKF+uHrddrKBpUaX58YMjJtscphmGtdRKePLA2iYK9Ty+Ul9X3atCVGLWjt4bk5bkR5folqa5T1A9RS+ZlvTs9liTuLJHQEHlcD/x1Wt7kR2rZHJY4fsFelfD+tpWd7XMCzyNwuOmVF+BVmLZdnqPsg74aqcIurUs3Kd+y6PiCmI0gg3nyXjMGgLEFxLoGaRgsLw9TzrWIDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVjt1YcGebSwIDPmsljMIYvRmXY5oL1Lyhuu+9ulCWE=;
 b=mil3jfU9fOevFNX9encXE0wez5w5su4yQf6Kk8Th1j5wWjxmaGV7zKZMg7BWd5KoC7K2w/cnhY38DRfw1R63PIaXZop5mJEg2TvZyyLTFosrYbBp+JuitQbn+9KbPdrl8++0XVYPDCyRvhZWYtfmC5VQJ2s9xwDtF4wOXUaW2srSIXiVPJtmYB6W1/OjZ7y3AOl/fZPR+BhS1NWOe42tO4rZvBq1235zeeEem+IsPeHXBgkb1yKxG97UKlgPeIhiC4cVtBoKK/PVlWMFHdBMwdd4DytcyRVuPs0gRz0CH9jT8h7vr0vOoscpYBQ9nkuu1YxNgYNbve0WDw5R/iGLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVjt1YcGebSwIDPmsljMIYvRmXY5oL1Lyhuu+9ulCWE=;
 b=xYGCmYFqj2A+uQZzt/eubsc2mrg7UTGXCfIpz2cY2EhRaXH8iPFI2flJp88icxT5b3KnApAZ5V6wMf+bu/C9j/QBr9ITHxwtCgh1uSwxz3FeaZKi4l88Gq6tnoNBDTEi2cgDZu3PlwhJiP1krqnJbNwizjK9RPZlqA3uKOp65xU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3519.namprd04.prod.outlook.com
 (2603:10b6:803:46::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Mon, 4 May
 2020 08:39:27 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2958.029; Mon, 4 May 2020
 08:39:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>
CC:     David Sterba <dsterba@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v2 0/2] Add file-system authentication to BTRFS
Thread-Topic: [PATCH v2 0/2] Add file-system authentication to BTRFS
Thread-Index: AQHWHUw3hztYQa6VL0S3obvMfUtXAQ==
Date:   Mon, 4 May 2020 08:39:27 +0000
Message-ID: <SN4PR0401MB3598A2A3FD9B0DE8DE16D7EB9BA60@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200501060336.GD1003@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 89d69713-298d-4843-c369-08d7f006a83c
x-ms-traffictypediagnostic: SN4PR0401MB3519:
x-microsoft-antispam-prvs: <SN4PR0401MB35198B456059101145B957259BA60@SN4PR0401MB3519.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 03932714EB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V3itk8AeJzq6PRg6eddSpuRTXurjX5ef6zkVpB8nFZZNvosEr3dcTnBb+FfRKC9g8eVU3BER1ipAj1OTqKtyH17/EEFOlmIie8fmgg/ZYX0c6UxY0Rp/C2Q+lRi1krfwfwZ70GhLnTDXG/oxgMokmnyZDAB038JI3VXYEqRJLUShSXWRsDcoUpgmexGWITAhvT5RCHC8zv2pTYGzrKS466ChjM/aZ+xjziE/PERVEtz3/qBvvPnV/oa1Izg/JDqUvog9CthVoTfPZ06JOIE6wsjfrdHqhRkAORsdOJfTSZML0GaCFfW0kzyOLgpcSUxHzWOHhb/fEgL3GimtDJL77FD42fm0GxgRwVqNGFOVm0yZY0K8Lz6uGY24nQhAw08pTe1VIgmyixVC6ZJ0an4VlEHR038mJ0tCWluDUWqWSmZqm+bpEHb5yt+sRTH9MMHn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(86362001)(8676002)(71200400001)(4326008)(9686003)(4744005)(54906003)(110136005)(55016002)(316002)(53546011)(186003)(26005)(91956017)(52536014)(478600001)(7696005)(66446008)(66556008)(76116006)(64756008)(66946007)(66476007)(6506007)(2906002)(5660300002)(8936002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: PBIWEJ2g2zR4YQ9Wsfhfab3Gw0Vt4uvocSJYaLjy4bwg0ZIMCP1lQfhPZS5XwITWu/CjWSS+hehCqM4oPvflutYaypxvndYRN43HDlL3lPUt4YIQOyXT9yOX2a8mDPT5RooanmjFv7/TYfZ+ful0y87bMcm91y9XGg1Z1W3dfkm+WeD92VBqN/Kf2YCFbeW78L3yH/1FaIWUaoK7s6A7+pA30q0Sn5M4HZEXVKHIURcaBqEerhk4DSo3BmaUp/hLHzvrGAwJHDZFGdvydAp2wMdQB+a+d59HuiBEVKoCP8n88khN3VeaJ4uji198ulm29Hy/kxae3D1E/rG02XGNhRbaXr4rm1Al5Ze3USZYMiIEDY7rneHoIPogiHDrsNxCjT/87H/HUKOy7rbYnq7rJ6ahM9HQxBWg5ZLhRDb3APFfa4dhSsTC0wxcF5AWIp2t8xRDUP2uQLZLjVLw0zKoQpCQy95CLKRe+nozmqSvgq2HUeGH3DAC6RaPM/1xyxWFAYWXNKPqdGsjxZZqXGpGNENTkSb3IrMlRMMpJiWcmB8M4BexVcdh95KAUgjr0+PJSeJeaXilkeomSsXfvjphQg+zuuUVs7J3eRGibF09HdXcqKUDGUBdiWdRFP6gUoMjKcZqWpj8TG9BCic34UaeF83CYSRIV9JRMhx4nJliHF4U33aRIus81Gp9lfJiz5c+ViVWB2vqd6DZi8CsyPTK0Zk5bm32vT0gW3eUjts+BvZHX8U2Woq3Yw99nbUk4dWwfSSzcmAi0HSyc/bobFa1KYkAplzcHTfFFYpqpZj7L7A=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d69713-298d-4843-c369-08d7f006a83c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2020 08:39:27.7470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q9+Jtb/wb8c+ce3oSvXO99xH5MuUOigWk4GPWQR42OzRE/9GqgZRXaaH+osPFzaJ6OWnUKgPTOCXPJdrEFWock5CV2FkgfB9kxV5rXcQRV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3519
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/05/2020 08:03, Eric Biggers wrote:=0A=
> On Tue, Apr 28, 2020 at 12:58:57PM +0200, Johannes Thumshirn wrote:=0A=
>>=0A=
>> There was interest in also using a HMAC version of Blake2b from the comm=
unity,=0A=
>> but as none of the crypto libraries used by user-space BTRFS tools as a=
=0A=
>> backend does currently implement a HMAC version with Blake2b, it is not =
(yet)=0A=
>> included.=0A=
> =0A=
> Note that BLAKE2b optionally takes a key, so using HMAC with it is unnece=
ssary.=0A=
> =0A=
> And the kernel crypto API's implementation of BLAKE2b already supports th=
is.=0A=
> I.e. you can call crypto_shash_setkey() directly on "blake2b-256".=0A=
=0A=
Oh thanks for letting me know.=0A=
