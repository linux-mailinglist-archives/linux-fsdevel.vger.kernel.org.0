Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9596835F111
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 11:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348029AbhDNJu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 05:50:58 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:55396 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbhDNJu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618393836; x=1649929836;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=RoCuowPpoXvLE8gDwFHpkplnRVbpMIA1Zr8vnom22WR7LaJyo6rCvkeU
   SoA6kl2TmIPTIsKlP7GNTftqt6liphO7F+xrGpxptgH1Ca2BVIlSa4Hm1
   6jc1KIu3IisNbhQhsa1u4xK15UoaX+OQHKdoxlKlagL76pHOjI4U2omwm
   VqSIQgInEywpgN+oqEKtJ0uZzF+amMx1Mp6NG/kH4UMS4JYeewiOkWH15
   jW3AQBZZJrlBshm52fZ8Z+TXWAdeRbZsFSJ7AX19npzPszEI85HmOxbp1
   LcSzCnwnLMDE3QflWwGVW3PTR4WyI/bDTTDPp21hUxMoYp8WIuodszWLd
   w==;
IronPort-SDR: GtkvqCS+Yldol25rygVahprvsTQ1bj3T8q6Hw4rNdli7p2l9yeedYV/vSERRkOkFBmUrcIJ6gO
 SzTwJkn+OQYUsQmwSdhH7HbVZhdtD/Og/kzUaox2B2KAfyK7JPoNd45wD2QyHCj+h8FdJcCp1T
 soUvrhIw0AsOqOsAi2vE36+/3t+W8/p4yox+NXeeKjsN/zqPhKAeTLcmwPbLY3a7KU6QlLNi/Q
 +tNf3x7bh0O2hFdB6lbmJy1hh8r+69L8xS8+VEZiYHdXQjr9jF8dFbn/3c/YDYGSC0qLCRdkU3
 JQI=
X-IronPort-AV: E=Sophos;i="5.82,221,1613404800"; 
   d="scan'208";a="164290263"
Received: from mail-dm3nam07lp2049.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.49])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 17:50:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxcKAEG/OXtDMTgOh2pJilG5Ug25wMLqOff0Q2L8EsE7E8oaorso4gt4lR35LZ//nY47YQ6HEd33BKWCJbCsQa47rK5m0wYrUk8C0GDBd3lMGgkJwIeUpjne79rLMWWfCmYxeXJRVMWVdKO/sAKfA+TjEJLkqAVcVQPZKdENSEgkxie/4OyrnqcOScFJUQTg2zSIZh1rMp5yiMsTpyiek0U3+1GvdOojS9I8+Xu1pFl2OeFNGkM1XmPQsSPwjddwnRSUHVAm31RnYbkrklx9CUp2VdJl5cNcG9lltiNUfxLF/YaPDpXxVRQQdBO72O7GBm+GrQJPuIOtnPa9g3FRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=kkXtS0Z4XKkHDwCikb5pbLS3WeaKEuKSu//kPTAHgY4n8P0ft6+O/MsjMSWUyksrdLZPuRCzfYsemcCSKRVNCcm6Y9xgmat4E7xZT3RoO6uiqv0NcfRViwt591+Ta5/Gh6UWvhotDMJYuI/sSSu4Qo9/vcT1RqtajbBF/8swSh0zqgQ/kW2bzZQNWb4d6BFuge5+KOf0WyFaImYbPIFpBo8bhAqrrcc0bUhR+10ytjsf5cDEudoXueSoNLpOrFYRGhCMfrez/ToKCumewTWrdMgoGUUX4rl14ZVtjQsXy7nJ+O6Gl+cdzfjFGlQmQZ5kv2cHyHp0Kfbbadtm+OM4dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=EJ99mX5z/MHu+wLLIiDHTzTrXS9+KxsLvQQh27/XEH2wddUSfN1dM+YE1r02Liqx3HQFYMW5+yv/tv9F/aiHSDK8qRNZBsrQJem6Y28t5sST2+jhBDLByNkOLWyqAFxIwuCOih4MCs1RfHlkGUc7bwqDcQxTgY3Lu/S0VpZhe1I=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7271.namprd04.prod.outlook.com (2603:10b6:510:16::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 09:50:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d%6]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 09:50:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>, Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2 3/3] blkid: support zone reset for wipefs
Thread-Topic: [PATCH v2 3/3] blkid: support zone reset for wipefs
Thread-Index: AQHXMM45EGTBx6ulhki5pUxnQXzbGA==
Date:   Wed, 14 Apr 2021 09:50:15 +0000
Message-ID: <PH0PR04MB7416E564EFF2B1DC67409FD79B4E9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210414013339.2936229-1-naohiro.aota@wdc.com>
 <20210414013339.2936229-4-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96cde988-0373-4793-37f6-08d8ff2ab4c2
x-ms-traffictypediagnostic: PH0PR04MB7271:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB72711ECB61471F2A90EAC56F9B4E9@PH0PR04MB7271.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rNK3CerELNa+8vURwQSO0zlQDtVNUl1CCrV7hEiixOhQEi6G4Vn+oGAO3fJQ8gzkK25yBkro1LEbKhT/UDqWeN8RVftuJTzVGU4AH6IlJubf4AYkCt7/N23EEhOAnyxqjCPMsptq3YikRhqfUT7ZxD3iN1LHts6SpyFiskG66+cUwl9RpIXva/2YDiH53nwWD7MXZYYgQbIcmauxj8qLNKSoKhfkqM/L9Y1lf75xBl3d7TqkXDBcEhR2hatM0j8eVk74iuSFQRigzci1pT3iJyowfCymXlupJrpw7nr1kkI3/Ec7IxkKBnhvyCdwTrYRCbMW2UuQvtJSsGkKeA9c/WEQMuaXK+uvVI27+afg/snLSLvBJVj0BmDqx6k2JGj8wjeCeXiDg9IrxlGMelKflWHm59jz3OMgMwMbTVW9p5uR+gZOTA1oScZ1AW0CH+884K9R6SV2scTZrl6jn6ZXYfHBJQ2zgYgRY9MH9/xVnpH5BpqCTPOYxjRUGKpa8jcfaZoMYpUN8/cdLia9/bVWEIEVX+NwIwoHUYLt+pBCeMzOb/g0KB3Lqni+5XiFoKyRn5m9CLOu8IXDJ/WiWjrCbXouGSD6wK0bi4YOMyx/xjE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(76116006)(66446008)(64756008)(66946007)(66476007)(5660300002)(66556008)(478600001)(4270600006)(558084003)(71200400001)(54906003)(52536014)(316002)(110136005)(86362001)(6506007)(7696005)(19618925003)(33656002)(4326008)(55016002)(38100700002)(9686003)(8936002)(8676002)(186003)(2906002)(122000001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?A/KU+eWHGZGQY7jeaXCPyJX/KX00GhLY+3D5bFzf65+eEVfvze2ASIMX4eVk?=
 =?us-ascii?Q?rDZiJdSyqptn8FqDAtuQfG5hzEC5SY9F1h3cLdWjboawtk0MYl8fPYtG4aqe?=
 =?us-ascii?Q?/1/T7Fx6uDhqENiT2s66tz75Qthbb2Tep/IXy8sp8254+iDMQbEJiH5pw7VZ?=
 =?us-ascii?Q?ubCw+Np5VWwITyBi/rACTOJXMPnfmaMn7i+X3QztFXt+NzYR+8OAcPSBWsQd?=
 =?us-ascii?Q?iM6P6An37NRPwGZlRiNlApTWQ4Ur6VO47p3iBTewFOGsUxRnBcfcm2W4UjNc?=
 =?us-ascii?Q?/6Z1CJKQTOPOfNoHqfeCMkeD22j6K1Oe76vAd4AHXXXkYmDNfaVFWKFKkspZ?=
 =?us-ascii?Q?w2y79Vg6jv/6vxux0xcXk5/+rtovRRmjjYldZYl/1fy9b2FA5DhJJoO/FCSC?=
 =?us-ascii?Q?d5JRI9CFB8c6cj/lYPVZbmCwB/8nRVts7Bvdjey8AKdVh6LtWcu5sExiLxiw?=
 =?us-ascii?Q?HAfOpK+1TJwfTaCSdaD+mefcTwXU+uzSh0UHw3LW7QnDNOQUFJrpcD3ptVb4?=
 =?us-ascii?Q?FiAyfk4k5ovUuqIPMWRHe4Uir8ajt+RPeYSDfRdljc/4G7It25r34WhAOwil?=
 =?us-ascii?Q?hni3fqnSDwDEK5K2XHtqb06SXYftd1OffvGaUqdDR+UnBHlKiujtaicaxP5K?=
 =?us-ascii?Q?zYI2rXwc7EU0Ainn6KZ7jAooEfZ8xNqKFXTanXUVvWPdQ8b0xCVSFQQVCO0+?=
 =?us-ascii?Q?oiofvsp11B1kP68DZWohtlf6WouiG6koRk5pjZWFrQvI8wGQyo3j1UeZWUH1?=
 =?us-ascii?Q?c1+jHYw9dQPEsta56uPTDMG//zdtQyVZdVBYArdzAS6HuDggM0owkpE0YYnq?=
 =?us-ascii?Q?b0sEAQFtF4FAVRiZ5DFBd4drsi7OqpnZPdMFqJfSE2ngrdYkM079zSkbPR+z?=
 =?us-ascii?Q?VY+fo4CcZugdccrKGWbI8JxFk8xQsi0zv0HGbt8pVC4BBE3AizsJJ5ysAiZH?=
 =?us-ascii?Q?tiReROxuQB3oCfQTnxsDAkfZfGDeY1LNEEnVrkw6t0hg2sDoLfUuPDDfTYy7?=
 =?us-ascii?Q?4Vwxc+TJ7YO4tx9QAx9VtLXacShukc2u75Ln4qCaKILUM6PNCwK20Z7CvUw/?=
 =?us-ascii?Q?Hcsgqm+TvpPb/fUtstd/UrGE4F1zRWarf8ELUjtSc+zEvMqKN8x3KAZSp6K8?=
 =?us-ascii?Q?O4BG8VsUrUtO7XHpmyehYrcnRgiaZ1lW/f7gdwDRTDzkMXIQyqA96vwavdCI?=
 =?us-ascii?Q?QjMx/9SljvPhnqS32+E2uCCo5z3d4W+KUB6kcm3IbViLDjJUnW/Pzbm4GUNP?=
 =?us-ascii?Q?KGbINn4oOucp+mvsdahrCGK+4wQ3B2EdbZPAzbKsSqaoC0F7EOovikRDKai7?=
 =?us-ascii?Q?VVGbXBLllHH778g0m10WN7ok6Ah1Ct31scSRszIVIa70hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cde988-0373-4793-37f6-08d8ff2ab4c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 09:50:15.8096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UozFIzM/4zlN6NDnBrtnNQE/ze11VlI/EzCcWGMs6YMJLh7YH1XVFNwafYCRXVxwO0eOsG3oGHLTGBDeXo1v6+JUuUCTaRC9VHwW11MiCJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7271
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
