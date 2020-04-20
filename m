Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E3A1B025C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 09:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgDTHKV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 03:10:21 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42024 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgDTHKV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 03:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587366620; x=1618902620;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Q9AcVsG2rBQJQT2/IprFU2l3mP0TTO3nggrG4ebtl3M=;
  b=ObtC/pbkws3SjnVgUs1aHB6CE9ofDe0Ri0wzKqlYUwR+V1px04/r6FC5
   YGi/bvNr5CjUHjJwUR3IXb+atGmp9TGvhJYqr7PWZG5nr2tjhHKQe6QKc
   dCaqfG3uFvrHSoH+m6QZbk18pCUg0KV1lOAKp+obLoGTbdvwB4W/aHV95
   GWV7ZTT30w7tfrAFJcLjG/B0kmz6WiXxpFLdRT36EJ4oplfJZ2UyM0ZMk
   wk7401UDOA3e39Bv13ojQLqul7DEm8vaAEFGkATp+QGbkLV9QapkeFWFe
   suDUEjrG9SL3YxvZ7JGs74aJXKisgnu5DP64yN5wjHaobmJIJ5/TvO2NN
   A==;
IronPort-SDR: O1eQhvNu6gvsO9Y+mY3rhCpn1jky/7vV6Awq4t6BDrHuRAlmFjYkgsi86XFACaLV+sDLfBAW0E
 K4j1KYE697sSxrBaQD2nbAI9rg+uMkQzo6oYPSjthcMBbu7XOYgum3oITckeUYiCtC8wyW5zyf
 3nLP8YwtKO9Y/l+kvCko1ftQC6fZEI+CAxVT8zxofzUbWya1tGVyenTjuaRJBSVje6OuOREy2b
 5P5GBMcOPVDqQR4ufe43OUPlFOCzdv8ONsjS9X4wXHvtM0AA/vrCIpOshIl8Rp8EDfxITXVOBx
 7Ng=
X-IronPort-AV: E=Sophos;i="5.72,406,1580745600"; 
   d="scan'208";a="135998019"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 15:10:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhX0d4nKp1upzSlzlf7MZk+O+mEJNAiJ4SRLKLm2PPNiVw8775ErvSYhEPhULIp7h8MJWzWKky2m0btKDriN5mpWz0AB0oNzL91QBTISfetR4IhZLBlO7YzQ/fuaz97ffyXF6bHxfs6YlnHyqZxiJNTEbVtEwQl+MLLJJ2rGnRnrrn5CgjEQJJq5MvD2CJjIPzuPYqmRk7zU0vOz2RGxTyoeBB+UjTwvHhZbLHy+HW4ixRvOIZxyxjVt2CEiPN51S2cIupqHAqUV1ulxPoJP2LuT2FWnKbO4pN8hlIcM5zgFksZ93qP+HUlOWJ6mDO6EF4t3WDybMeF1mJ6RNiI8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9AcVsG2rBQJQT2/IprFU2l3mP0TTO3nggrG4ebtl3M=;
 b=EB81CwrrrqHff9gPxkk4OZ7ZwTPb6Qr112o9AneML9rAKLIi6siTzrIhBlNA6HgvF7m6fGKGYJ1UjfHBRsNLCt+n8lRHrKVj5L6L6/pj/yVpW2TvGJDcUK6E40NtMg3OrPlmiytgTw9SeIYZAybLqU1w8+1QUvT7dxHSEX2CdndQO0LN441NSRNXvFtzkwN/kYCWynHUq4fBLuB2LhutmMrjDEb0c5umoOamUCJVcfCIIceH4omRgWuF9Ht4lU1fw7nRIbRA9Wa1lVb7vPR+eSnikspXQWJzIILDV1S4CvIntz4ryD5xLeh2fndGPrV+1u8g7QAGYf4jQiu9pTyLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9AcVsG2rBQJQT2/IprFU2l3mP0TTO3nggrG4ebtl3M=;
 b=xY0mwHQLUuBv6NzYzY+FyjivG7HhI4hwaAhBA5/SRxGWCi1b7Mx4m1IRvrCGyDjrlgE1jDUyRP3Vzbv6KZGSWxkjYH5P0P4WrNkloZe+Cww95PBM0nHqYjz55+cNY74R7RQAnAohZ49FqSnt4b7NohrrxWboiiQ5c29dQ/UM1Ps=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3632.namprd04.prod.outlook.com
 (2603:10b6:803:46::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Mon, 20 Apr
 2020 07:10:15 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 07:10:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 01/11] scsi: free sgtables in case command setup fails
Thread-Topic: [PATCH v7 01/11] scsi: free sgtables in case command setup fails
Thread-Index: AQHWFLHyAOekOpGZiECrfGFghLCsTQ==
Date:   Mon, 20 Apr 2020 07:10:15 +0000
Message-ID: <SN4PR0401MB3598F3AD01B4CD284B0ED1ED9BD40@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
 <20200417121536.5393-2-johannes.thumshirn@wdc.com>
 <de79e1ab-0407-205e-3272-532f0484b49f@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 994e0f4b-ca67-49ae-70d8-08d7e4f9e022
x-ms-traffictypediagnostic: SN4PR0401MB3632:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3632227EAB345178D44917DE9BD40@SN4PR0401MB3632.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(5660300002)(66946007)(9686003)(55016002)(186003)(91956017)(71200400001)(53546011)(76116006)(6506007)(64756008)(66476007)(66446008)(66556008)(4744005)(26005)(110136005)(8676002)(81156014)(478600001)(316002)(54906003)(33656002)(8936002)(52536014)(4326008)(7416002)(2906002)(966005)(7696005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pN7C3KzgqYqTRtcAYmYiWB527ibrcRQq7/G7LyibDCdYG/HycgZT5VPeHwmyjmOBzmmviBmEZt/ET1lrPUBCiPv0dW4lTtrqxDy4ciPUs13WNIftAKDXerGmQ4G9bUNxnB1UrDguEYZcnCmMcIn/8z1i3FcxOkSbqAY/h+gn1l8d7UwOVLF19+aklsPCmbD2Rz/7w2k8nWjhymhdOwveMBnipNf7MbCBhZGyEsmWGoiYwUUAVAO8sRJ6IkQgNsEIRh4lLG0Z4dsGFhtR2tDWicEmr8Yo9bLIiKBYtf1yBybOVS0uGhxciIps7AOVhD4AiqI2ADUJN5zbG6wHvSmk3U1/zlbM9OBourCFoUQWkyGq05xecQLe7CzuIcY8yRlohDKiDlTxTlBRfhGG8QLtWUlAmNGUodb/YlnZzU+TxuMLDnCOaOqvadLApoQwXJDV2UxXzEqt5PDdNGICgvzdKLwof+m8RLflXGlI5C/PV5MZKFJ/grRNhWXPuZhEME1V5OGgvUMUWLwasccrgIYDKg==
x-ms-exchange-antispam-messagedata: 85LDYfcR/jRUKCbyytifJ8nENd0VrLZy9Pvsg2eyTZ0WT99NFl/pIpNFs/WyZTjhABtsIaPomNjFkMd0zH05dRqJvfEdBoTNEYyyKNrYLVu1Vk/XuM4/RhxWNHRGC7sG1mIoIGE8nfhHTuwdiv2v6g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994e0f4b-ca67-49ae-70d8-08d7e4f9e022
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 07:10:15.3135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ln4nq+nMg4FRYhBEmCIq5QigPQfeF4nNO9Pa3+PBmeHjPbA6w4fIdwlV0wgJQ0SnhmUGQFA11ID+HrdEOZeZ0Jbe9Ls6fdwzvcm4ItsJBLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3632
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18/04/2020 18:02, Bart Van Assche wrote:=0A=
> If this patch fixes the bug reported in=0A=
> https://bugzilla.kernel.org/show_bug.cgi?id=3D205595, please mention this=
.=0A=
> =0A=
> How about adding __must_check to scsi_setup_fs_cmnd()?=0A=
=0A=
Oh thanks for the Link, I didn't know there was a bug report for the =0A=
memory leak.=0A=
=0A=
I've encountered the leak in testing this series with custom error =0A=
injection via SG_IO.=0A=
=0A=
I'll add the link to the bug report if I need a re-send.=0A=
