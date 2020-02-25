Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50A5516BDF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 10:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgBYJyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 04:54:22 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:46757 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBYJyW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582624461; x=1614160461;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=R46U4CLVEX4E1UlVxMs0DcDf9M6cKeEiIC3fRQ/2uyI=;
  b=jU4epCFlFQdyjTrrF4JSGLT35v7dqOmaVd5gkrD9lljIgB/O9hgVF7Jb
   7eRSxu5tDctdMm6iD17n/VI2mOunaZYwjp2HyhAc0XaRyBmW05hJSEEQJ
   /x9vr+6z7Jid0VtzXa6tXp54GBtbwiXYxC5kTZLkmO4Vi6HvYPNwDp+p8
   eEWe0Og9F8+FYFFhnVNkPyePTfmEKioo5qwDYV6BEQCcr2Ue4k4TFz3aY
   JADrCvU1KnTa7zhJhQ5ha1VNbFzIHhXUmDANZ/KxK8CDcTBa4HisxaP7a
   4HPK7Zld8TfwgXhzksEE9q+K3etdGvk0kLaBVOLcprRc6/SGUN4XzAjDZ
   g==;
IronPort-SDR: PU1MtYrxawYUpSGhzTTSqDl99xDiKtH+QqI0uPFBjxFcLnUxFA3rGhS1u4y2EPDcbJ53VclTix
 +DvK+Ksd6D/IYIFueu8Yq5/WG1LWhZz5sL1gMtfMSl9iCutRecFvgTXMb905NAqW5NvalUbSoV
 ty4sws+bjWRIBkQNr2B0g3TiFPYIVJQjtX2lZe/zYt1Kwyfk8zNLaq9DLgi3xm/SDbFEKEgbWV
 PRRJoHr8EnezFJW5Lm1MXz7T1keuo29Yf7iftFUKWcKA7q7c1MFbB8cTg8AzJvWQq6rY4hlf8+
 5m4=
X-IronPort-AV: E=Sophos;i="5.70,483,1574092800"; 
   d="scan'208";a="132118496"
Received: from mail-bn3nam04lp2050.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.50])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 17:54:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSTRx6RkHW/7YWA42+QDEYGwJU8i8aHV1PjEkZq/J17HkC1Qi0TMc1nRnrZSf7M2E+kF1KtCVfh049xNyaaIknh0W6wFzO5zgk8OPbBOUzIIRZSfpcKLU/GtDcju+ohcLEf59XanG9V3SeCJXk9R/pyW9SJXMFdMiyXRKcqkRRAsIhVk98Sm2DTD1UA7phG6UszELk3EbY90l/i6TAwNtocnOpu6yy6YqpA38PT/rjx1VAt3in7DYGQNv4jllKrA/sYwBY8cFvEiu2imvwrfM0+pGXG/MuCnSyemsYcsfknEVAkQPUbb+AdRIQYT9X6A7ev41R9JiurgWmKCXEg3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlJAH2h2UgQKXsrQkTs/gZWxDH4d8N7Ue4QAfXKfezM=;
 b=J7pihbVFZSzmPu/jmj2o3WAww3sfr6NKiuISHVNUDYJLcOP5phVKe51pAyOHx6dUM7WBtkpGQJ0AzeWBWvB6KXjGYNlpb2cTL/ZtWrqiySmTJRKOOqEHLR/DdRx9u7GDrVcnwZLSw6aXazuxEBRenB/RhU+m1rX7/FDKfGuYiRiDi5i0vSejx4+HdCBEYWVaFVQDYnRp4p3DbqED7x0qKL4cMTrSBGUlJ1OgJHkqrPJgUG/LeUgKHJ6/4GS9dv8qizm/o2WcqenJCo9Ek65cp9jGBMLsWxctTaqDnanIofkTM0S2mGAvDvd95OgBMJDVyTIx2uEZz3nIYkeon2434w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlJAH2h2UgQKXsrQkTs/gZWxDH4d8N7Ue4QAfXKfezM=;
 b=WHHNYqZNXca118ZskG5f8Es54U5P45r1/YUA60AKe3zyDbwnnTjjJ/hKUUHq74fQ0XE6JOw8GjL1dkMPo8Ix7O37pVgt20AR5wbF/W4/Cr+ijgdmy0lFNShXFCJGwCqhLBG6kcFAoDDfCUDhJFOeMYGek39RCBA9XqP8oF1gvg0=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (2603:10b6:a03:10e::16)
 by BYAPR04MB5254.namprd04.prod.outlook.com (2603:10b6:a03:c2::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Tue, 25 Feb
 2020 09:54:17 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2%6]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 09:54:17 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: fix IOCB_NOWAIT handling
Thread-Topic: [PATCH] zonefs: fix IOCB_NOWAIT handling
Thread-Index: AQHV6MRyTqrbolpwWU2eUaag5JD1NA==
Date:   Tue, 25 Feb 2020 09:54:17 +0000
Message-ID: <BYAPR04MB5816FAB71FC29B0B1E309319E7ED0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200221143723.482323-1-hch@lst.de>
 <BYAPR04MB58169F3C3A66DCCEAA35E332E7EC0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20200224201858.GA10880@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e904a536-24c0-4507-30dd-08d7b9d8ad9f
x-ms-traffictypediagnostic: BYAPR04MB5254:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5254B980618AED19823838B3E7ED0@BYAPR04MB5254.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(189003)(199004)(71200400001)(6916009)(26005)(9686003)(4326008)(478600001)(55016002)(33656002)(66556008)(8676002)(2906002)(66946007)(54906003)(8936002)(81156014)(186003)(53546011)(81166006)(86362001)(66446008)(52536014)(76116006)(5660300002)(64756008)(316002)(66476007)(7696005)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5254;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FC8psHHm7aqRmoloQFL+ybwPhXy1+sG+cEJBedLQr+vfeAPEQG3ZGndyKwUyouQ2QXUjAmjhv/PijuKnh+4Qd6qE8VmRFuGoYEa3tM8nt3rSDXhMDANTfr6ud69uUM8ZGAZ1xhrl3SVNP1m5hSVlCSap7kulGG48+r4omUiBzooxfeoFDi58yJf73HKgIoYLkOPjILoedjeKezqGvPTrBJ8I1UxgvMs3Os5RazFtlVf4XsCw5f1g1MNuRHEuRwQWyBR3ul+lL8UkxfNH4ZjPiSS4TcJxBFWggIg25gmoVyDBz4DVxc52cPRtXB2dAc36B9xXykYHlpzLBB88eoE46sNpYTRAJo8tLxsHbyKj6ddLfEtNiiICUaRKuXy4IF6GM5I37SjkUejGhSGIBk/lgqM8OCelRU0zUG2JALgnE8kz5chwU9Vi2zdzwvxCOogE
x-ms-exchange-antispam-messagedata: M177wkxgPFrSSIrBX7N2+HL12oW64i6osCqWywDNB2DhSwJd9QSwCMRW20+4E7QjMLpEAa9KMr7RmEjk5huqc5XhAyr0W5cieST8UoBP6AA/2C7EF5U16IqvMYmr9oz443+F8ZE+ofiBrG4F9lxk2w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e904a536-24c0-4507-30dd-08d7b9d8ad9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 09:54:17.1561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lTwvlW5DBhph21966LKqJ3HqPbpb5eHPFx5ATcrXDb67eIl2SOJ4xB9PY94H582v5SZgEDvTBtcUmXlsqrtVPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5254
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/02/25 5:19, Christoph Hellwig wrote:=0A=
> On Mon, Feb 24, 2020 at 01:48:48PM +0000, Damien Le Moal wrote:=0A=
>>=0A=
>> The main problem with allowing IOCB_NOWAIT is that for an application th=
at sends=0A=
>> multiple write AIOs with a single io_submit(), all write AIOs after one =
that is=0A=
>> failed with -EAGAIN will be failed with -EINVAL (not -EIO !) since they =
will=0A=
>> have an unaligned write offset. I am wondering if that is really a probl=
em at=0A=
>> all since the application can catch the -EAGAIN and -EINVAL, indicating =
that the=0A=
>> write stream was stopped. So maybe it is reasonable to simply allow IOCB=
_NOWAIT ?=0A=
> =0A=
> I don't think supporting IOCB_NOWAIT with current zonefs is very useful.=
=0A=
> It will be very useful once Zone Append is supported.=0A=
> =0A=
> But more importantly my patch fixes a bug in the current zonefs=0A=
> implementation.  We need to fix that before 5.6 is released.  Any=0A=
> additional functionaity can still come later if we think that it is=0A=
> useful.=0A=
> =0A=
=0A=
OK. Fair enough. I will apply your patch.=0A=
Thanks !=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
