Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8ADB25B007
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgIBPsW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:48:22 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32484 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgIBPsR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599061696; x=1630597696;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=GB7njFYVQhbUnkETigaRf5Dg5X4oNPNQ7Xt7Ft3YVF8TLTOZoEoN28Tk
   tXG1avbvZ6iP+iTE/5mAVkCklutyIVCjzf6BIisnFj2JhSUFMyamUD5GP
   LL3vzvQEv7NiiVQ7elKBMxx1CC+pN4g/Ij+nHPRh8fXNkxvKbB9U43SyW
   85thZ3Ys9kj1j4hrN3vMRbIl5LPUI9oOakqFzYBItbHn5jvs+fsNPop6c
   U1vKmcnu2jXIEMz/hErspmBQJO+a2xd8YLlFCOQYRC8YFmFe8xyq7kbTO
   yWMExkW5Z39+sCWmP4hRpnWWj7xKeFERlHshdxBnjEw8PT80zKLCCjo/w
   A==;
IronPort-SDR: ualaJYGBOv4tRwzWeGSiJX6soFl/pYDN1u3KkPtA5cFkJJTaprkFzBKhgRTYvycIcASoaMJn4e
 4p+Ir8Ae8IhV+REzxdoQy/RjDu1pU0l7xHNyK+KWbLKwbf2TIdRJUMfFoWR2aPjgqUFLIWXKNQ
 RwRXGkIhEAShYNOfdjcDE1ORMmaAnJBm0OWvq3bdTOBxvOeKEOKyAQfzZWgWCrjLXalF8Z1bRK
 zt2h5Tk1Fq2m+bNB7JurCzofWGX12Jb8U8o6df0zt197r9IBbpGKD3G5V6q2O8TGBdfe2hg5O5
 Qow=
X-IronPort-AV: E=Sophos;i="5.76,383,1592841600"; 
   d="scan'208";a="146348705"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 23:48:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wa20FDSCa6dhiOQVPKRs4fJcxQyrE2mUyYnjHXd+hlo5JXq09XX2laZ19LoQYiRctJSeDYLV9y/Cq7BUyl7vL0EdmKhZ28GZE012sePgtDdeyoT0IQT2AY+5bG2aHcrL9dHd9eA3NNEnCjLrd6RqaGQXoPMz+IQmNom/3v2W9A8teI10faD8PDgeZlFLrsBc2L9G7oZdYnW8Ma4Q3WpmwR77wqNw1Jg24juyA6E8ihPWe0SqIuImxnn/QXmXh1fm4PGLBQkfZPMS+Ipy+ofu9aZb73iPuXhZk4nLMtm+TLrv5gsQmrgSR522hV8GUTIMwmsZqNItHcpEAu4BT+Icxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=X+WY4vVgyzw6ve8HwGe+1oaJQmrXacUeJWGjtWoXxHNJ8O3cEEhssZVC+zPwJWDBcF5A68qpaIJdT16wr7ypN1R21Jevk6We54RwAxpFdnEfSmVGS4k7+T8IZJFVxgd+Pbxhm7tS7rZphDwh3+X1Y/166J20B2SwpsjSONtOmVRGAO2xxehwpyfvuUbmi4nwqqtoPOxzP+jniZ9q+jaFxp0akyyY5J1C/OrKeHkTl+CRU+44wUdDu1VjBhR1BJQs6qonJyOSdcWCwalBTt5Bi1HVhHwvbGGaCMIiVwz7aD4OCFYGZShqmjCvgzX/Z9dfQNa/YMQ3qrwApPM2d24Hqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=s7v/8YYRcKInqTj+x1Q+Z5Wr4rmueG7chjQRo6yU4KUMNZ2tLZ0BqbHQ8WabyK3d8XDY+hV60s4nMvZnHMlQjcLGeFGYrbRqfcrlf8DkiAWrmJwNfGapQky41qHwYVE8tC56+/Ud9Kz/7/TAID0kCWEZStoSekwe3sYN3yrw1wo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3680.namprd04.prod.outlook.com
 (2603:10b6:803:4e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Wed, 2 Sep
 2020 15:48:13 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 15:48:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Denis Efremov <efremov@linux.com>, Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 13/19] ide-cd: remove idecd_revalidate_disk
Thread-Topic: [PATCH 13/19] ide-cd: remove idecd_revalidate_disk
Thread-Index: AQHWgTNcbBeAB1I0XUykIgBKlMBQCg==
Date:   Wed, 2 Sep 2020 15:48:12 +0000
Message-ID: <SN4PR0401MB3598FB75575DB82199E8AB349B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200902141218.212614-1-hch@lst.de>
 <20200902141218.212614-14-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:1584:4722:fd5f:b30e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec3ee1b4-25e4-4b83-1aaa-08d84f5799ac
x-ms-traffictypediagnostic: SN4PR0401MB3680:
x-microsoft-antispam-prvs: <SN4PR0401MB368085EDA815F8EE107ACB249B2F0@SN4PR0401MB3680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eqcyQ/ednqBG5+Uufp+7yUHSuyMNZqS99qlXI6y4vWoDio7ZnYZmPQ64xUmkP7A9g8RiU0Av55YMWKpRpymXh5zU+QhB+Bw0aumQcrc6qiAyWct0aTooLdBG4twX0OqeezGRj8BcjJYEVr/cCShFplscLcJaFB3IYcWRJ4Twb22yxHgj5IFPlfyDzTtYgwEgy44TC8QGs6fqVol9dRmocBZvtEoAMd5/yEP7ivz3rH05lmCL+GN6jJZaJxhJ2a3dc66RwOtIf+UFWOdZSwNhHkNWG75jMVStWDillhqhGpiPSK3HXbe+WALp/Or/eC6D8JoeFdgMgfETiFCSv4bqJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(366004)(346002)(376002)(136003)(71200400001)(7696005)(66446008)(7416002)(186003)(316002)(66556008)(54906003)(110136005)(66476007)(6506007)(66946007)(91956017)(52536014)(64756008)(76116006)(4326008)(8676002)(19618925003)(9686003)(86362001)(33656002)(55016002)(558084003)(5660300002)(8936002)(478600001)(2906002)(4270600006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +dHMUKmCAefzyo683506hsGCC6SHF2kg2tAO6lUHoNHJA2ElBRcoBnK6kAzLA1l5wkrc7PZGmgpK9alVEB5Quf7JuhNluqyES7Z7IU3PIfDLUTXGrwmA/FpYsNSXMYRaHxKPXOxqmUDGK3qYE41ZOLa/Muihvc+XXYckge4LXJVH/788uQ/Hh5zMIOj2e9sQlzkTR1ut4QOJc/cSn0l+HbjHUmWM2AwmPfcCQDwLswfHaw5/Awwn1nRG0WLVxRD4l2pgJWUc01RgPmMZWxcTRZtkX76gLuzR+mqpJOMwBexlv3ZAeY7d3Y8UnF3GJ56DbI6ueZfmpmUEuBb/Pby/afYFJ6lJKCZWUdV/XWnJxaKi4AHnCqmiPXXvUugrCJ/2013AlmsN2hiS/6SJ0HReQBJCcro3xHzw+tKnXEA+uGMDLnvHdIofb1s2oBooP05/EkaETeWTOWZAuXRuRhnNTc1DT3HuDMY+1QhhDtWcxlYJ2R9VP70W9Vk3XHpqU7nALvQQd7tJdOcP/J9lVob+dTcMNxUhMsxnfPTb7bfH5tZICAzBGXSBpYkusjeg3tNXc+4TKnR0NGFVkp3LQtYnM6zpEOYawMWxRCk4gaV4yF+6SXHWUGlFJGcOxbFtzOoHpX3Ny8obbpjSDPrf4ZmqizEFMHyaQ7JP2cEFvBi7am+lKQI5Q1ksrHJtCIXiembQzlKN8nU7WTAL+BW7wZyTSw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3ee1b4-25e4-4b83-1aaa-08d84f5799ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:48:13.0018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F/7204arV3xs8aDMhyt8xksHimNMYfd36SbZiAeKfbW4BJ9BRkjIS/7P41KUs2HYHlEtueG5saxbA0OMRwMaE4u6fHEObo72D0gZkMnv2E8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3680
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
