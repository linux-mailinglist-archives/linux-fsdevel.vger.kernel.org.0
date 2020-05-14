Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63881D339C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 16:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgENOy1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 10:54:27 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20352 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgENOy1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 10:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589468067; x=1621004067;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3GLBWtH/KUDR0TFkCIDwdeO7XDGRGLBffidUheRf/jo=;
  b=N3iKzY2a0z9n8P/uNnNDc+kR2Zh6FRxHq8jsjf9/D6iJEVM1jF6hKozz
   6Jd5zwqeUk8fAppsEdUJj0f3UxvmHyFCFDeW+d1C3FsTXjMjBuQ0/xnC5
   rwHkicFyQ3fyAKaBUBBCnaTqVmg83sXUUFgPaXqowDX4uRdWsn6h4MI12
   krj08DoHVkBjDiuM8se6EPSiaO72SzJHy7AvLHdAQK2QsVC+/chEyvkG9
   Z81WXX8SlzV0qecQ6uG1fRucgxzCUTyHYnXAWWkZeSU/K1hvgLFUK+FMn
   naHVpRrRuUbn+SPHAOMaHgVAYQE5Vkxu/MiUyAQLLDHU6aFP8NIlaOt87
   Q==;
IronPort-SDR: MZ3yqk2qUdYkj33hQxXZEqmdOvnkAvviCKBP3+he7Xi42cNnXMcpnLWCrIZcgoyHS86SZIk2RU
 Mhv3nc8IWcA+v+2ZqaKFYMWTmwoNd6wQtEZF5o/K++hv01UmPH9BmMs5i8Tz47ip/k8/7mzJBR
 r/fwfxmj8JFgZ8dBxK8/5VmmagGhjjq9uJQVPOKrr6CsX+vn7O3KhkXTnc+U5UaWlO6WGcmk9P
 NFgYDrn2MgLw5hTMi5EvZF5TbNDEuDde6qTP/PabdDrwj53A8TUog1svEhKxBnx1mWySFFfE9V
 3KA=
X-IronPort-AV: E=Sophos;i="5.73,391,1583164800"; 
   d="scan'208";a="138024377"
Received: from mail-co1nam04lp2056.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.56])
  by ob1.hgst.iphmx.com with ESMTP; 14 May 2020 22:54:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/wP6GhvVxQE0qqblivwVVB+bhqWbFdgbGe+pRWFWKHF5cNXsPwFpEKB8sJ6T6GBNVPZDyg1/MT8HzI+DgplsI4h7lBQzluRh5AFAOw/czgR1ONo46m1l+bgwNyHF8YD/Y4vAWA/ykqCerP/vaRlIkNRkmk4n2ZrKAb0yLJFCCVvDUL1PplYPRE4XPUdUpYA11bF12f+KplgHu6MmN+xCIbaO9qKFORI3mEh7Qbz288OpHPombXx3SGZAB4w0UTTh4i3wqoilKYzT5HlPBGYoqQt4PPoqjsrPKSxdGoHgVjyHy92rYnCfrWPrF6r3lT1fI92fR+Rm3ycnYtuFwuGbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odFqRLu7szqZ0Q4h3ggworrTUxOl2J8vYDUxyWXRxOw=;
 b=D3kB+c0yzuDdwsqMGArxgmpy/s4kI/BaqcyEasEsE4IFzejZLxfpODC9E6PYyM30gOrkv3FX+LiftP0wPdNJic9SFsfxvYLUW4hWifB6E3QMuUwRReIoIivIdVFWmwGpCyDO6HL7ka9W4JzrfbgtvuiEU5NngJSQ8dVqPa4vXzLKmo3+2sj4EZMCroJj/Af0GUVUv3aEGO8ukLnuozlMeSImiT5G4715pkZ3xyDR9vk/GARdEJx3nE6yajGkmvSavfo2jXcSMBq8RQFHz6n90mMg3p0cJJwxO9Xu0lcyuQfAkGVTkwP+8aFQC1oUi/oepedaeF/TczgrRMRKaZ+2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odFqRLu7szqZ0Q4h3ggworrTUxOl2J8vYDUxyWXRxOw=;
 b=TIFPl20yFnwPtYrlPQYmoa2uBeyYmvK30tAJ2jiTp04lHMvb65JrSO600Zcrl0aEjBBQXigMBPtH7q5tI7m6izsWQLKVCN7j6AVs6DO1VAZdFxuEGddjjkP/7NW0kk1I4JmqYs1wPizIj6fhpxQrlD6raU7cjGszimYWhc+e1JQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3581.namprd04.prod.outlook.com
 (2603:10b6:803:46::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Thu, 14 May
 2020 14:54:12 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 14:54:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Johannes Thumshirn <jth@kernel.org>
CC:     David Sterba <dsterba@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v3 3/3] btrfs: document btrfs authentication
Thread-Topic: [PATCH v3 3/3] btrfs: document btrfs authentication
Thread-Index: AQHWKdGHpFk4qUNYxkaDbw38lHwpUg==
Date:   Thu, 14 May 2020 14:54:12 +0000
Message-ID: <SN4PR0401MB3598FFE2AC30EA4E7B85533C9BBC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200514092415.5389-1-jth@kernel.org>
 <20200514092415.5389-4-jth@kernel.org> <20200514062611.563ec1ea@lwn.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lwn.net; dkim=none (message not signed)
 header.d=none;lwn.net; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dfa7b2c0-c4c8-47f1-2d3b-08d7f816aa38
x-ms-traffictypediagnostic: SN4PR0401MB3581:
x-microsoft-antispam-prvs: <SN4PR0401MB3581F7A490E3467978E7AC7E9BBC0@SN4PR0401MB3581.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V+6dsdzNMLWO+rmDZkhQbYk33IsRWDGTA052blkJ0aCkZh7aBZRLzcSKdqRidCJ3qMA/0mawMsogiNMuOzjtKj4IOu7a+RBni0CInhnjJIVT6y3VbsCXsBEiWRRgtiK2Icd+ob9VHB2Jwlxe44wWGbgNioTf1SnSPZT5dZe9orko787lbp0ON8KSyHFAeGk4t5MMon4Kubugco4HohuVvBBiV8h1jwt5PTpyMQZO/XtNBYs9Pru+uv9Akk5W3l3NxH1pFyF3LZrgVagfKYuLXtpvhOki+8Ftbj3imsezqOw96aMpm2+ffRG+6IGcOnBvN1HQh8SyfG0dS81ffkfeDQxklEiWPx1L+aueyEJrvIfwdDB+JWyF59HVh88AGsChZ5BY6L6g8ZSuCZ6xkaSNuL8iFwXjpLSI6/hT1tS7qz87iyBI0WWRm23XyC/gNn+p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(9686003)(55016002)(4326008)(91956017)(7696005)(33656002)(8676002)(8936002)(86362001)(5660300002)(52536014)(2906002)(478600001)(53546011)(6506007)(54906003)(66476007)(64756008)(66446008)(66556008)(26005)(71200400001)(76116006)(316002)(186003)(66946007)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: hOAuWwze85woRqyncpGPs/e7ZhBkP2BgDcK+90FJToEcPVcSoxvY7j3OC0h69cS/mL9ZAQQPCSTugt7lvjbOKA5bkJWRcOkQbuCQnmXCpIGmdAquztxTEsX7rictkpGKIVkE3Wh7RN+rWdrP5u1RtiefzQHupqKG2p83pCp7ajmS8V19Pe3kwcJaFMuBL2d5lGSviDgUbk+7XNephr93YlacowljJ/3WipUQeHwnvg7xTmgSHdPUArg1WMwo1rnX6GD+JyyQxQSavg7Kqy/28Nk5XVHgivmG9Vz1Wc2LCyi4EKqQODD0UYDuxAhaAG9bN8tWjYJyWdNn/1rOjxNZ/Lr+rcWpq7KIUeRHeZucEkf9zykR+wMVOd4X0vo/L2BbAKsKmCmRzfPraruvhbagampI+XmFRYmZzXAktK9sUwp2IDjKUC7ualIH/uEkMrDTEn3kJ5VcQK/HZ0LLz/O/24PZ/QiV/qs+ZmwTQ0Vruu5Dv5nT6rCOcg7lh+yYkqkE
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa7b2c0-c4c8-47f1-2d3b-08d7f816aa38
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 14:54:12.3492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wqpcYY/mzCIx0E6DgMOWNzgcolYwBYzvPMy12RAgyE6mLyLD9Y7a6YzXNFomYcB2iIGdlWEbPjgv33fSDdTRec4g8Z69bn5KwuSkgMXQeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3581
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14/05/2020 14:26, Jonathan Corbet wrote:=0A=
> On Thu, 14 May 2020 11:24:15 +0200=0A=
> Johannes Thumshirn <jth@kernel.org> wrote:=0A=
> =0A=
> Quick question...=0A=
> =0A=
>> Document the design, guarantees and limitations of an authenticated BTRF=
S=0A=
>> file-system.=0A=
>>=0A=
>> Cc: Jonathan Corbet <corbet@lwn.net>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> ---=0A=
>>  .../filesystems/btrfs-authentication.rst      | 168 ++++++++++++++++++=
=0A=
>>  1 file changed, 168 insertions(+)=0A=
>>  create mode 100644 Documentation/filesystems/btrfs-authentication.rst=
=0A=
>>=0A=
>> diff --git a/Documentation/filesystems/btrfs-authentication.rst b/Docume=
ntation/filesystems/btrfs-authentication.rst=0A=
>> new file mode 100644=0A=
>> index 000000000000..f13cab248fc0=0A=
>> --- /dev/null=0A=
>> +++ b/Documentation/filesystems/btrfs-authentication.rst=0A=
>> @@ -0,0 +1,168 @@=0A=
>> +.. SPDX-License-Identifier: GPL-2.0=0A=
>> +=0A=
>> +:orphan:=0A=
>> +=0A=
> =0A=
> Why mark this "orphan" rather than just adding it to index.rst so it gets=
=0A=
> built with the rest of the docs?=0A=
>=0A=
I've no idea of rst and the ubifs-authentication.rst which I had open at th=
e=0A=
time did have this as well, so I blindly copied it. Thanks for spotting, wi=
ll=0A=
remove in the next iteration.=0A=
