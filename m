Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FC71ED63C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 20:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgFCShR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 14:37:17 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:19195 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCShQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591209435; x=1622745435;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cLJ/qa747wF9Fe+WFhnXCutuePuobeRnZG8cjfIbMUA=;
  b=Gj7ra8p5sj4wsWEXjf9KDbgXZDcqDB8NI7aEbDB1IPb+vh7NUqg7Rgst
   byzgXWMEtZ/R6dOJFwh3Cx10JMkoQ3FZmjgQF/vcYOu7UfVeFU5qHm52r
   3u5YXX1dIOHUAphMXYxt+c9L27qJA4gx9/GYn+2Bkq8QG++gbmbjGSPZr
   zjqQneFy5GijNQu84sn1A5XoXASf4JfmriW8zXYlQahqe/elfYR4PDExq
   CrFxem1tyTCeEpTGTccgSz/AncYea45by+wBsQLoPr2ZQeZu8E4ASFA/M
   S757otWzCKTgxX+MqoT6WPxGXguiM1HwAfrJKJ8YaGJUzPj9gdRI899YW
   w==;
IronPort-SDR: G85FKuQVx2QTtvyyGTuNh0tINKIFhlMHc2Qhr7TiEA2DIsIDxU/1CQ8PfBvbb7rqUMS+E5Qwzh
 ZpxZlNOee8KugjsAAMWuztoVl+u6da0v95O4/8VitBu2gzFg2RKEOtcEyowzNfV/3pMb6i1K4L
 TFUNjWy36QPpXeCDus5THww4aHrMoFTwYqOEQZYcph2Kc+aZD7Ud0WoMK+DRNMHG+BtFvvGicP
 BrkiIyfXo+FwOjQhJTVGtkaCqxN4NuY2iX/SblQdJiNzT4fv3jeabzy/4SLjXYFsiTSGOAsHH0
 MB0=
X-IronPort-AV: E=Sophos;i="5.73,468,1583218800"; 
   d="scan'208";a="77251033"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jun 2020 11:37:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 3 Jun 2020 11:37:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 3 Jun 2020 11:37:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSYgl3DLUHydPs3wLvywMpsW7Tg7ORd1pBXupQ8U570iDYq82JZfR9erepwSO7CVFAPycqO3pRQYgq8OeS4CYYa/4R//9x6lpwJOd7A/v6YMCEim5gv1VpB9bwDn5a3faPjoMsvle2Z9JF94rETo+2gazeqTqRcghOFn/UnZrcdRIYicgjcp5y0P3xLbsSbmxt36khCTqhjO0K/WNeO2wykqTL7jwGS0O6ByG5OP/TbpRLayBLjBVzEzlDaOMdFcbwJeERFXXzI+ogYjal6vhr4ocoxpxNcEgizpYP5u0AIREs2D9GaNfcQnV6T5KmutQ55l893/jVV19rJg82Kovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egULetR9boTFQ9ntxzxj8MXMMDSBJ+0kUGP2729lzX4=;
 b=fEgrn2DtWA3KpYk5t4msDT9AKbUWLqB2GFIlzhzbumjeS8+Ajh6jbMqHB93jAXCv9eF0j2bTRFSmFVpnwkLG+BZYPOtn+lNEtKojFMWRvo1DGvgUR1uMfCdcSzwkUtImtEDHTU7n77upUN/rRq53ZLxyHXC4mVDIkDACbGyOIi5CjNDneb7giR9iXXzioYaVy1ehhbEVKzyB/7EWgGI34l9wbbwgmO6BC6CPTxU5eK9Pj5rmt2E/RdE8SYlHHIcdjmli648SFzhTHZnfvkVQOaB7XnzGpI7qidsGU3oQvLoZXiiteYx3441cdJbzLNb+sFtLDvuRrz9JrMhwldv1xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egULetR9boTFQ9ntxzxj8MXMMDSBJ+0kUGP2729lzX4=;
 b=RdCecKU2I5pNB+/wr65X6dI6nKp0oJxGAqUlcyCgg+KvG2MPIDE5oQylh3vXQBTLaWxFckOPpqDUfEYmID/ZKT87tU1Uo3dl6SUV50ZzMyB3pOfAD3pbD9804fqFpgpKG6yUtV7JEe43bkxQlX+qMkOuESPIJJ9pz6VFZqWxImk=
Received: from SN6PR11MB2848.namprd11.prod.outlook.com (2603:10b6:805:5d::20)
 by SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Wed, 3 Jun
 2020 18:37:12 +0000
Received: from SN6PR11MB2848.namprd11.prod.outlook.com
 ([fe80::5907:a4c5:ee9b:8cde]) by SN6PR11MB2848.namprd11.prod.outlook.com
 ([fe80::5907:a4c5:ee9b:8cde%7]) with mapi id 15.20.3045.022; Wed, 3 Jun 2020
 18:37:12 +0000
From:   <Don.Brace@microchip.com>
To:     <viro@zeniv.linux.org.uk>, <torvalds@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <don.brace@microsemi.com>, <linux-scsi@vger.kernel.org>
Subject: RE: [PATCHES] uaccess hpsa
Thread-Topic: [PATCHES] uaccess hpsa
Thread-Index: AQHWNhJ3VNoomsaOeEeeBRTBzDDm+ajHJEVw
Date:   Wed, 3 Jun 2020 18:37:11 +0000
Message-ID: <SN6PR11MB2848F6299FBA22C75DF05218E1880@SN6PR11MB2848.namprd11.prod.outlook.com>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200529233923.GL23230@ZenIV.linux.org.uk>
In-Reply-To: <20200529233923.GL23230@ZenIV.linux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [76.30.211.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2957550a-f560-4234-1de6-08d807ed2158
x-ms-traffictypediagnostic: SN6PR11MB3230:
x-microsoft-antispam-prvs: <SN6PR11MB32305184366C82ED8EA99700E1880@SN6PR11MB3230.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:88;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x3dpf+j1eIfxCKUjlSqZMGOakKJXXZv94DCtjymLyzCxhtT6TmNX4EiA1fDiVkMAATmGc29toYLrdI1W4LHVxQTHI4o3yHRctBsyS6E9Jbu3lQEYcCRfk7R2jwEzgrPxHewA1QkET5wKFli16PehUqzjULd/iYwl/1mDd5fgISmesbPSmROqoMgF9evWfk2btKe9uQN/X4+cSrVc03rNpmDWu3DETUZk9/JT99jMFdDPhejrL55fB1ekj3M9svUQhggMVroFhptdpGueZWkIfr0UHC8/Sli695ZVePZL1ZyCWANoHgKIidjITasWoYE0mLwBYtYZcR5MOfdItCC2SQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2848.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(396003)(346002)(136003)(39860400002)(66476007)(33656002)(7696005)(66556008)(6506007)(64756008)(53546011)(76116006)(2906002)(26005)(66446008)(52536014)(186003)(478600001)(83380400001)(8936002)(4326008)(86362001)(9686003)(66946007)(71200400001)(4744005)(5660300002)(316002)(55016002)(54906003)(8676002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ZDTQaP3QQxZdKZ2kUQutdmXoImLzF+LIGc2fGr7RHMIHG/XYfWMSA+gKOxFNk2QZPWfWihLw35AyfU7+306oP+l8rTkOIHrsOfo3M2nosOj1ECXORtof41z99c4+VuRm6LRppmnH9rGJhLIj/Xmj5TpuTURs7yWExjooaXKnYhokF0tOZGIkH0mshjbcfP0KiLPzu9M0nMIKBDn8XudMCVS9N+zwiUsQH+ZtBCvWCGvYAAmfDQDtSEJ8Qr9pBRmRB17oXrCiaaBjG+KQLl644Efu31pEq4flsZbt2b3C8HQMdqR7cyH3j8j1cwN4XqCyE5zWptvZPQc73ilQI6+tSgUSADwWay0c6D6Urq1UnNmq6m1BYt4SOYpw1u0RbxAq0YXaC8NFYcz4RjxjhCkwIGmmtgcHHQ0fyjyaBJT1gYSS1G2H3VW0ofFUYAVeiWmg+7VTT0e0YOuMuXrbv1V+Eihrb5aZ9yC7X0QJjVntwEo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2957550a-f560-4234-1de6-08d807ed2158
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 18:37:11.9762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RAgePfZkoEPXVjtNUIs8y3465Tq+clayFcUGnYZ9p8Z0Vc0PYdF60C6oDR6gOcqK9z99WQIKQMe+M6Zojd6b8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3230
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

-----Original Message-----
From: linux-scsi-owner@vger.kernel.org [mailto:linux-scsi-owner@vger.kernel=
.org] On Behalf Of Al Viro
Sent: Friday, May 29, 2020 6:39 PM
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; Don Brace =
<don.brace@microsemi.com>; linux-scsi@vger.kernel.org
Subject: [PATCHES] uaccess hpsa

        hpsa compat ioctl done (hopefully) saner.  I really want to kill co=
mpat_alloc_user_space() off - it's always trouble and for a driver-private =
ioctls it's absolutely pointless.

        The series is in vfs.git #uaccess.hpsa, based at v5.7-rc1

Al Viro (4):
      hpsa passthrough: lift {BIG_,}IOCTL_Command_struct copy{in,out} into =
hpsa_ioctl()
      hpsa: don't bother with vmalloc for BIG_IOCTL_Command_struct
      hpsa: get rid of compat_alloc_user_space()
      hpsa_ioctl(): tidy up a bit

Acked-by: Don Brace <don.brace@microsemi.com>
Tested-by: Don Brace <don.brace@microsemi.com>


 drivers/scsi/hpsa.c | 199 ++++++++++++++++++++++++------------------------=
----
 1 file changed, 90 insertions(+), 109 deletions(-)

