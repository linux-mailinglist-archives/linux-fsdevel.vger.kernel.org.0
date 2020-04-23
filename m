Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB271B5FBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 17:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgDWPnf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 11:43:35 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36654 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbgDWPnf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587656614; x=1619192614;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=U0HiMyEkrTeuUF1ZXhW+KYmDQdKSHl5m/JDIvhQdQcE=;
  b=rMN9zd4j750grM5RpCyoQpgw1+EodB7mS6w/9iXmqImObiheWGec9FY7
   JcuJUkS+E5PPKxcASTWwzyuRyoS6TUinQLXzJSu7/EOwJDyuvts/4yX9H
   Gs9L6+qaX7G4WTxTfrSfJCYpKprHNVliebNbVPzuu4cquydsCG2YhdQ2t
   HFtWxF4QvezMDFOIdzw3VO8fUtSUxDj/js2WAdxuYFjoznqiQTqD2lBKy
   meg93EPFutMI1Gd1RxaS9kZ8a7zZm/ULc5fauDRZ9zqOqsNDtaiO2w1k4
   PwBBgauvQwQ0NaEQKeXEzAuY/r5Ls6WeA9prXeNuHLmwY67fwz4/PjyAu
   g==;
IronPort-SDR: qKSXNhoLksJFTl6XIl/r/VPI9dxPsQziT3L3EH3ihkC7rGOrfRa4DJVCcLlPyxCgZETI/lKIvD
 s/3wOxn4A9dLJB9U7BilahM76HNyoCQvCL14EDp7VhdFsi3zyYhOomHri0CMoQm/lNRIcAR6hB
 W+FPYmWwFfg6/4/AoecbQ2YQsw/W+hWMqpcXGR33vmdCR1pCz5FIl/VpTVrdUUvg9vELm7NzC2
 g1LmWAhGF2lQVdpHw++N0707hevI5959xZTaFPo55QMqzSxf3LVEB66G+jT3X1+pjbTFGa8eMX
 kOI=
X-IronPort-AV: E=Sophos;i="5.73,307,1583164800"; 
   d="scan'208";a="135992361"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2020 23:43:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdZcUZXO9dTZg5AmuTNqbIaBUQmsy0MafWZ0dWKiXCWdl058NTB0yb+aKM7Y9YVpx6HNj+o5hnyhj4o3M6cC2PqvSZl+Z1gkchAN8fu4YaXaQt/IsrQUxcNUobw/snwL6QUnFxfSP2QE+vBl007S6AhXywuNIn1SEbInqa4sGGZkmwDw2oxUApYiQmqpmDzjqlqDOoy/C1NTTZgOmyHa/wxNtfzWQwYE7ulnEQ+Fsn537ysw1hqXPwmY4nKykcJ/UtYehYc6SBnoPN9v8ZCtVtaAvlF7igvIm0d5wQTX7t/Ii+fAaf1U/g9E0ikaYqmdfVpttN61ChQ/Kxt6EDc25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0HiMyEkrTeuUF1ZXhW+KYmDQdKSHl5m/JDIvhQdQcE=;
 b=MY+iuZyfSgbtKUvx7TPo0WLqkW4d8HjAKF0UZ09r4Xtt4zT4jMUyjK0l/7/6qE/eSj0RgFBcmv/I4W850yG9uylTb9dGujMvJ8cfiOPmyekdZHif6i6ptops6RxVNXwimIs13CCdGvsgqb1KoDy4uCFdjXTBY8SNXgV71HSYofKNQxOSv+wvS4waTcX3e5MKMCOwCll1ktQuaT72oGaB85gavDMSLO5n3OLZTnJJVMqk1tbFVdKzF/HjwO8tHTvnAZQb7JFzYz8KbB/b2eVuu4GNKdJ2X8FNCLdLB0RLrNHKp6vmR5U7OutRV9Hqsvkc6792bc3DSZzVJAns59CaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0HiMyEkrTeuUF1ZXhW+KYmDQdKSHl5m/JDIvhQdQcE=;
 b=QpzpcAso414mphIZK94RaiEKBc7KbFph5PwgS1oLNyiJ/CfEg+03qtS/ROHGWQWvDkYZ6duK9YbmNIpmqZAnv8k7zhUosrOH4x1SPRAFP1mseXs/peq9beNa1bOWgEbaKu2etus574JC7z38248R+1k0SZuZRNgMHLoWFZKXonM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5653.namprd04.prod.outlook.com (2603:10b6:a03:10e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 15:43:32 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::28be:e964:37e5:44b6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::28be:e964:37e5:44b6%6]) with mapi id 15.20.2921.030; Thu, 23 Apr 2020
 15:43:32 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH v1] zonefs: Replace uuid_copy() with import_uuid()
Thread-Topic: [PATCH v1] zonefs: Replace uuid_copy() with import_uuid()
Thread-Index: AQHWGYRieSvWHYIWGEGLBePuWnSsrg==
Date:   Thu, 23 Apr 2020 15:43:32 +0000
Message-ID: <BYAPR04MB49654BB8430FA45980CB64D186D30@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200423153211.17223-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 07b3a428-f99e-4fb4-fec6-08d7e79d13d1
x-ms-traffictypediagnostic: BYAPR04MB5653:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB56536298E2233A6FADA6AFA586D30@BYAPR04MB5653.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(396003)(376002)(39850400004)(136003)(346002)(55016002)(9686003)(52536014)(81156014)(26005)(76116006)(71200400001)(66946007)(66476007)(66556008)(64756008)(66446008)(4744005)(5660300002)(110136005)(6506007)(53546011)(86362001)(33656002)(8676002)(7696005)(316002)(8936002)(186003)(478600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bXjrmB95dix4J2MU1RL2jQB7gDK3V5zgz3DihjTuU159OxUAsxt0RdH5epzs1mZ7a04TlqbqQMUaj6YqitSGL4nMUBtY6qzXyjXPemCZZoxV7AorArItd7UpbA7jgjb8F0V4tAKrhFl0698vYE+ocm53x+WwKZlU58aGevyJeHLYOv0RiKruXldsr6rIIquF9l0yA+4d8MDj2WSovN2HxRXExSveotIy/337nUOeL31V5259Dy5CfsjQtSmYeBISXXZRFez1kPnS5387daZjxrYirDeSkoQtKheZ84Gyun2HIExZtjWeaoLcYRoMq4Oa2pwI3xcFEr1TpCcFCdLG+RmCpkYoPicwcVld3I3lCb6KtlymC6eFNLzNHF2kAoeMRfNMuXmBao+Qqi1zF/afNMA19WlT+YHNe83iU52kiImONzpHyqyfZl/NTHNQ45Pm
x-ms-exchange-antispam-messagedata: LR7aMPemb4bAQQfrdTCZBHso28xvx/BSp/L8HhXFR1NxpKeEUfcdLYAljuFZ01caFDymX0iABIUEhbdbRDEL6mqwJyVy3iXoHjg2mdwGueu3AxEVQ3XoH290jS0D9AVGsrTHJm+u5W9My5UdpCF3vw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b3a428-f99e-4fb4-fec6-08d7e79d13d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 15:43:32.2506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1aMoaTfWZQJnUZxP109b8qx4caIrFSSRc9IKawa4PsGh+x6L+9GqVD1ZtTpF+1UCoJQ3uOoFo557Bww0Lcgp+AO8kFiAoJN2VyVIuQV6a9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5653
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/23/2020 08:32 AM, Andy Shevchenko wrote:=0A=
> There is a specific API to treat raw data as UUID, i.e. import_uuid().=0A=
> Use it instead of uuid_copy() with explicit casting.=0A=
>=0A=
> Signed-off-by: Andy Shevchenko<andriy.shevchenko@linux.intel.com>=0A=
=0A=
At the end it does the same thing, I think we can avoid cast though.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
