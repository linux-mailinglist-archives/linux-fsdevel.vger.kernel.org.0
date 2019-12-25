Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE6C12A6C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 09:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfLYIWI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Dec 2019 03:22:08 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42842 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfLYIWH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Dec 2019 03:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1577262148; x=1608798148;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4cRH//WldnbKcvbxoebLs3oBxFfMtanfu9FnFszuFB4=;
  b=dHxFiYJbSt33a/6ab17RvamVxQFMFkNb3SJ68VHuC/3zW0pyr56gn8Zb
   eRVnPFVO0sm2MO8sdnvgnYplnASZ4c+5v4D60sxxioY7q4NtyiacsOWpe
   4c2N/kE3h95TVmfzGHNd2fM8bU6v6IJbXaIllFrMJ7K7BTxIL6DMnhtCx
   Salc1p3T82JHEz/6bUax17wnEwyar7RsGg+AW8EUNWBqu9urWOk+/mG3T
   lON6lYTi4kRzmKMU7QIEoT7ABsJJA5j+pTyiqDNZPRSSAwgDK6xJ5cQlC
   WhAqDBNLjv+x4a+9jwCqFSl6XAU3Imp1FI/VvBFQkOGZ0BgyinGc+1i2x
   w==;
IronPort-SDR: Z2V+/LbgaLAtaYSV7cQXQ/X+3Bn2F6v7uAAA1CaDk8AeWcY9OXZHP1BTodTwaNyyGnkNLal6uN
 CjPcN7rSWOEBiJYscjzVofzb/vBY81WOnGRlHWVnOO/Ho2u2TEhY8jrHv5wkABmxJC47aE54t1
 QafIKkwoutenyrNqzXYaXGvdJCtrsyyrvxV8s+Oi7MABYtykuxIndEdMO6nI7v6suAjejUzj/K
 D7E4I3DCyltT41EKvCfadbRe9BWHlgFL2oqbl7mdrZc6XAR0rglS1jAq2sYoOQ8/aH+Z/rOFpp
 hmI=
X-IronPort-AV: E=Sophos;i="5.69,353,1571673600"; 
   d="scan'208";a="227764714"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 25 Dec 2019 16:22:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzAkUD743ygwqfDbC7nIRFCxZTE91nGd2I2nRmqN0FOkjXtKse3RU5ep6XDBS4jRN0p8d9Y6sz0RDIY9EkmMCMoKPZX8Jba7ZDxBT0pk0Gatoi68IAS8ydeBzX1RJvjVzRHXDpET7KDtQMxHd7rn+tKyU1T6YFmZIRzXdgi/mQlv++AX1o5MeYe+n9CrBp1CzJaW2R/zLCYac+ea1DRV3BSbznIuzY0+4yUMIL9fzdjWNJwVwzMoaRvd2gEtTDXpqZZ/pnhapHqbp1LWG+MHGOLqk68Oq8yrjzhgUFTULY3+WOh52Xw3UvZ9xGctLsPJAf9yXKyydgYfKe4o9lFj6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPEpKTLTUyw3rpc/0oUsrs1W/DVNHi+zr8v/q4GNZSE=;
 b=RmJ9QY5IByNKtqAuFVvjom8WDiBtHapSQtVM2D2dThppYKUq5MOF1Ya0YvYe63b3S6K9VpD+epVg4l7G+8e1ZIpIDL+Wdvk3ClPqmc73Wmyth2y739M+ayIq108s/BAwphuSju0Vytml10EIXUUAOf7Pa6G3fuejuAp9D8ZRHrfA/MLpEhXsKIp/iYIC1P94xUni7oV2ZNiEiIdGklaqjMC33yMyhsHSFTpqz/O5hbIUz+ekjaQnj2lpjJTy2XBi/9hXZtH0Ds40GNGsVGp8oh6uIC0eTqFk4che8y7UQ93b7gCD2qip3+YZ5KeUQRUMqRrYJpMJGUKo/9HTrz2uLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPEpKTLTUyw3rpc/0oUsrs1W/DVNHi+zr8v/q4GNZSE=;
 b=bAOFj/9hmqP3rRF1tlRmBEPb2ddTv6qIRZ5HGG/wq5GUTNj5yxLQ65S66uolIUjGAhVL2kPWfeNzspYXlzuziUwELXgibK0PdJ1DfSDeunnnNxO4XyN7Mf5kgy88sm90I1OjmMqHn5hTQt3H6vc7tpTZudMfdF0CmnPppDsHjdY=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5557.namprd04.prod.outlook.com (20.178.232.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 25 Dec 2019 08:21:59 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2581.007; Wed, 25 Dec 2019
 08:21:59 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 1/2] fs: New zonefs file system
Thread-Topic: [PATCH v3 1/2] fs: New zonefs file system
Thread-Index: AQHVuf7BpC1bTe1k6UmgztFIqbNKpA==
Date:   Wed, 25 Dec 2019 08:21:58 +0000
Message-ID: <BYAPR04MB58160982BF645C23505BA085E7280@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191224020615.134668-1-damien.lemoal@wdc.com>
 <20191224020615.134668-2-damien.lemoal@wdc.com>
 <20191224044001.GA2982727@magnolia>
 <BYAPR04MB5816B3322FD95BD987A982C1E7280@BYAPR04MB5816.namprd04.prod.outlook.com>
 <BYAPR04MB58167AD3E7519632746CDE72E7280@BYAPR04MB5816.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f94b883e-284d-4159-8599-08d789138319
x-ms-traffictypediagnostic: BYAPR04MB5557:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB555702E66E0F04071B80FEC1E7280@BYAPR04MB5557.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:473;
x-forefront-prvs: 02622CEF0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(199004)(189003)(6916009)(7696005)(71200400001)(8936002)(81156014)(54906003)(5660300002)(316002)(81166006)(53546011)(6506007)(86362001)(478600001)(2906002)(8676002)(4326008)(66446008)(26005)(66946007)(33656002)(66476007)(66556008)(64756008)(52536014)(186003)(9686003)(76116006)(55016002)(91956017);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5557;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GIdkuPWqCmo1fQu4oRpeGZZ1i/goAQnxT6v76LW+YkITIiIbc/TXj3Z1BfPDQ73dzppNXYTj5TdQD0PjEoRaOYNVnc2LmNwTUBNY09A/J6G1uVdlBe6uDjO/EfdbeX8jKhp97szn39a4DHOMaNuS6wRiVJdnwsj84mIYwDfbLLfkMCh/70vF7PBuwHcJ2ObELKlM4O0sLeu+joqDIHMjPEATdiWHQDNmAO6rS06paVyISFn+B3KcZFZnBdwT+0uFohOA6XJ35Sv+PosIbkV2my3duWgKY12KAAh/66UVyMQpDBOeFcUNwZjEdoSM8HGRffyZ+a4iBX25fg7oQvStzwr8XlrCOWR6RHOI6ThQhR40ttWPzTFGRw8KAIH4/70x/vMA+Z+bSZ3DSIwAwcf3/8SaKvPVwRMxeBGgs/rDn7dHH9qkT4D/y6kxtqaD98cP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f94b883e-284d-4159-8599-08d789138319
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2019 08:21:59.1937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x28JaCYAM7RAaDcS+Mx5rmOWL7tV+nwTxxvrSw0lAzqLLpmFMtdSKLZN0UAEt4x/8tfWTw92XDwP3o00H0gEMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5557
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/12/25 16:20, Damien Le Moal wrote:=0A=
> On 2019/12/25 15:05, Damien Le Moal wrote:=0A=
>>>> +		inode->i_mode =3D S_IFREG;=0A=
>>>=0A=
>>> i_mode &=3D ~S_IRWXUGO; ?=0A=
>>=0A=
>> Yes, indeed that is better. checkpatch.pl does spit out a warning if one=
=0A=
>> uses the S_Ixxx macros though. See below.=0A=
> =0A=
> Please disregard this comment. checkpatch is fine. For some reasons I=0A=
> had warnings in the past but they are now gone. So using the macros=0A=
> instead of the harder to read hard-coded values.=0A=
=0A=
Retracting this... My apologies for the noise.=0A=
=0A=
Checkpatch does complain about the use of symbolic permissions:=0A=
=0A=
WARNING: Symbolic permissions 'S_IRWXUGO' are not preferred. Consider=0A=
using octal permissions '0777'.=0A=
#657: FILE: fs/zonefs/super.c:400:=0A=
+               inode->i_mode &=3D ~S_IRWXUGO;=0A=
=0A=
I do not understand why this would be a problem. I still went ahead and=0A=
used the macros as I find the code more readable using them. Please let=0A=
me know if that is not recommended (checking the code, not surprisingly,=0A=
many FS use these macros).=0A=
=0A=
> =0A=
>>=0A=
>>>=0A=
>>> Note that clearing the mode flags won't prevent programs with an=0A=
>>> existing writable fd from being able to call write().  I'd imagine that=
=0A=
>>> they'd hit EIO pretty fast though, so that might not matter.=0A=
>>>=0A=
>>>> +		zone->wp =3D zone->start;=0A=
>>>> +	} else if (zone->cond =3D=3D BLK_ZONE_COND_READONLY) {=0A=
>>>> +		inode->i_flags |=3D S_IMMUTABLE;=0A=
>>>> +		inode->i_mode &=3D ~(0222); /* S_IWUGO */=0A=
>>>=0A=
>>> Might as well just use S_IWUGO directly here?=0A=
> =0A=
> Yes, I did in v4.=0A=
> =0A=
>> Because checkpatch spits out a warning if I do. I would prefer using the=
=0A=
>> macro as I find it much easier to read. Should I just ignore checkpatch=
=0A=
>> warning ?=0A=
> =0A=
> My mistake. No warnings :)=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
