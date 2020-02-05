Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1470A15272E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 08:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgBEHqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 02:46:10 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:1526 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgBEHqK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 02:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580888769; x=1612424769;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=p/ClQnwFPwIp+T8T7HU4ovsqIaqoYOktEulDnkWQsQE=;
  b=SRP8TdlM5+bsLy/PSgrNrZGm4HJQYSGb2vW/GYTj7ChiZKSqil1hPu2K
   GsK0RxVVtPf1vv+T2ZYDRK/AJvP+v2Lv3QrR2XcvBHg8G7yyo0GobHjvr
   eD5PF2N072hLtXspRcjX+3uE8kUz49syMrTsSxCzcvzAzPa/RCPGrHHea
   klZVQQ2zuWEaVNF3C/dWKMlHV3zxJJDL9roqFW+P03JgUGyr9T8+32ihW
   2ugBD6Q57GCjYz/eHBP+X7D1WrdJHpRLs7ko6rJ8SQPRJ04nKC8i45jTm
   95dPp1K0xfmkSF2oEJC84mpq5eesToI09MPG6dyRkaQAu7J3yfqlHWfS3
   g==;
IronPort-SDR: hMHDa0sdaXV946BFq9fxX7wDTBq4GrdJXaUGrLCRux+ImhwnuNMsDyDUJgNGJRSpHNA8tqw/ME
 zTdFgZPX+C3NUoMtpaJ5oS32/95Okrm4IanyehJrBbYwMJq466+FQeIGNtebLK/lWAsASo01E0
 kS0xGy/hNu2My/+dSTldsmW1BgW0MDbR1KxypFKJj+13B/QvVi+FdpJDq6cfo4H6X2nf5xNDqB
 soFc02NeYRJjQ6rYI8dBSO3coC/oJOPA6fdDvuZUMNVAAztIlNYGPpHeT15OywGGM6eIgDoj6n
 0Xw=
X-IronPort-AV: E=Sophos;i="5.70,404,1574092800"; 
   d="scan'208";a="237097059"
Received: from mail-sn1nam02lp2057.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.57])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 15:46:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frI8m8przWOJEcO2hYtfqGKo1/iB7LGXSrl/ZYeh5+QwJhcN0FE09ZDJHG9ThDjr5QrEk5RLuml1+HgszqvwU1E1fWIBETbREBOptuKeRBEAVteuQ5j9V0io+8clawe4TVFs00rNMwiVo6ISihp9VmJ3QNMnQZag7jbBvNQjLyfBukU+3urAeW37qjr/QiqFXIzrZPjWHK82V/h1HCcIeuqnSyOnpiWpzXDOvhcu9e+2E+zm90Ssvn0TgxYGV5rHRduC7F99bK116dvHtR5iY2+eK9F3rcxH3DR+nhJfyKiEolvOpFOqQ2Sb/bNBntsg2jt8mByPlhw0qhLstcIJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/ClQnwFPwIp+T8T7HU4ovsqIaqoYOktEulDnkWQsQE=;
 b=BVcR+PIUZDjETRE5dsJ70zzXZ47NaMkjmaiyQ6e5h53OUKBLXIjxfoDbeT6+gaZFFpgHjFXEet+Rh9VHWRKT6lyrqfRLltdTY/OfxyKHpyjHX39CA+vpLgL669hlobeG57XLamRe+LochW/ylOr5RlsVAmEukUW1PzYKwqiVcJjrhF3WvaGR3EaWDBY28OYRJUvb9LNZwEylKd9JGOw5CbR4sHa0DDYYk0DlW7nDqX2eVaqkxusmgv91WckCd+8bbZPY9GoZSOTz5AOsAkW1+RyCREjlJwlz+c0x0HaOtZ7qqgp18URpgy2BjlZn+z2vty0jIS4lOQblfWAhTD6VrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/ClQnwFPwIp+T8T7HU4ovsqIaqoYOktEulDnkWQsQE=;
 b=OFg0OWWNgARA7guV2fd0xqKVPHMJUBSNpWspMYtZ8g7i/XaSSWBirAD0pYphGFIuUodazLhCphbJYOed0Eq4MJC3VLYfWs8l6FbXnOGzLNCyKQH/dlUkHoTfIRM7EhJAmbkfeVJFQHVfj9fi2hS8k+vi10ypMzG5KTU80i9o57o=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4374.namprd04.prod.outlook.com (20.176.251.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Wed, 5 Feb 2020 07:46:07 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2707.020; Wed, 5 Feb 2020
 07:46:07 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jth@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [v10 1/2] fs: New zonefs file system
Thread-Topic: [v10 1/2] fs: New zonefs file system
Thread-Index: AQHV2/RFr2J5n95mjEGmHUAr5fmH0A==
Date:   Wed, 5 Feb 2020 07:46:07 +0000
Message-ID: <BYAPR04MB5816A4CD15C760D0E5768285E7020@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <68ef8614-87f8-1b6e-7f55-f9d53a0f1e1c@web.de>
 <cfb36fa5dcf97113198848874c0ca9ba215e26fa.camel@wdc.com>
 <b1336be5-16f1-cb46-3469-46974406de14@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5a7a924-5c2d-4db1-ebe2-08d7aa0f7610
x-ms-traffictypediagnostic: BYAPR04MB4374:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB437480C39547485D006D9F8BE7020@BYAPR04MB4374.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(199004)(189003)(86362001)(81166006)(6506007)(4326008)(81156014)(8936002)(5660300002)(8676002)(53546011)(110136005)(316002)(4744005)(33656002)(54906003)(7696005)(26005)(2906002)(71200400001)(186003)(64756008)(66556008)(66476007)(478600001)(55016002)(76116006)(66946007)(91956017)(9686003)(66446008)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4374;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y4eG/J5Fj7zhZS++HsirRsesMs8SrW5E5Vc0hv/7g6hQAiZWshQNCVrcoRo9fCuwKilaVlwfNsewdygwHrtDyWpMMxktMTepi9H9iECLhtU+vu9+MKzVp+EI/0/6Wm34uqFSRpFC1mV1w26whgMxcyxFhnbp6GwmBD8BKO2IPA/tJzr7BYcQyfA65w+W/lUPYh73bun3WptT4vbau7ZIhXbVVrd3WVvUZeztwwUuINli61Lwc3snpWfznUoFNW9SfsYUjymw12CEhhZjn9+iO1xlm711LSCEr4ATqgihY1ASU9K5PE8qctmkJQUJGt7WoHv0YsDx8VnVrj+XuOGFimxAvBKcZS2gBri77ewwMnvYs/WZKd/DhvKQ8O+SkVe4VaiDjpBSuzd4IBsFiFEkYw/72gYcxcO1uGAgp9SnGG6pJhjeg+mkdFIPnF66jWob
x-ms-exchange-antispam-messagedata: ueBDVAkJDevAlExAwfa6WkTt4qs/M+5MBSSGCIcDnNdb+sWKf0T4lyEUnYJrgdLzXAxYW2U/zIPe4bGxPLJhzcuAJA4GpLOk/OpvhE98TbBQccbqlc6AVlRJD2Gv3zKiDW0IzIQTvtMGbAL93k4Scg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a7a924-5c2d-4db1-ebe2-08d7aa0f7610
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 07:46:07.7416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iYCTp/ERaeFVzsabZFxyZv4FqTzSfHRlbDEI1wmCe0tjsgsqz+bS9yLHCQpsmxXLKKaPnw42taOdrN4l250LTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4374
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/02/05 16:17, Markus Elfring wrote:=0A=
>> Declaring it as=0A=
>>=0A=
>> static const char * const zgroups_name[] =3D { "cnv", "seq" };=0A=
>>=0A=
>> is probably what you are suggesting,=0A=
> =0A=
> Yes.=0A=
> =0A=
> =0A=
>> but since the string literals are already constants by default,=0A=
>> I do not think there is any difference.=0A=
> =0A=
> I propose to define this array also as a completely immutable data struct=
ure.=0A=
=0A=
I understood that and pointed out that the added "const" does not change a=
=0A=
thing. I think that as is, it already is immutable. But sure, I can add=0A=
that const, no problem.=0A=
=0A=
> =0A=
> Regards,=0A=
> Markus=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
