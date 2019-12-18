Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D767123C1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 01:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfLRA50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 19:57:26 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:27588 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfLRA5Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576630644; x=1608166644;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GZo4h8Oqx+9F0EfePin0UYLeGX/KzwgsGp8IDQrP21Y=;
  b=iuVznX/srem3F7y1RHVLmWmtaUm7Jx2MWJwxFQ9Vu6evLjhuM6YqdH9r
   S5xqd7rGVunumMyUYgMd69QvWSKK3EZ9pkG3NnWcAXhoY/QsmuRh5M2zO
   InIFwUvHMZz9nELIdLrRs4oYx8Kx3eKZewIafZr8uj5wM5j8acNnndO+Q
   oJa4luyclHvcTAkdsX3NZ5VOoVcRSscCTdyQxYONal25BAK8jqqomzoSs
   EguW2YwznGq3uHWEt7y8eeKmO0Hm+ASKggGoYmdR5AkXUYnjBD4YdF9b9
   H6ICYrSmmlL8/a2CvN/D8dIvrZWEWZg1vht8DTddzntSoisTKvxY5Anq6
   g==;
IronPort-SDR: XP5Y0NcYoUB40ZdNYS+KQTmfR/BzCSp2OSmsTZtUSkrrQVbpT2Uc4QEI85LYwCJgxWH9al8HqW
 SckJRXlqcuS3rbWISm3f8272cxb4solw0ZTy54srF9Fr9I07btq1z9sXwc4UchJhRT9H3q+Ja2
 Sef8PbvQrUr4WmY73EmExRcOBxVNMCxRMlM1qVBMkl7FjnUHtqkFdOOrk8C4Ee2WMXmP6AzMJF
 AJ7e/TETQYy5i7Uqk1a9MYzZpOw1w/yOW9JnHoON+QY9D926lLXqcTOGFYT193oy7skmHpKGF7
 lps=
X-IronPort-AV: E=Sophos;i="5.69,327,1571673600"; 
   d="scan'208";a="125583723"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2019 08:57:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cf3TjZDPJyL/T7iLV359TMz9rjgkDj9cYmycPBOTursrgVMucqgIFmkIDwNJqMU6uuQ7gj9/rZ3HdtdEst0LnrD0w2GWkZODQWTrETRFyvZ4J+zOFtHl6eFHOwvBVDMahJJNLqa/xQc7N5WwiZV7jwlRUfUzGEf0CmhQHinwmOsDNf0T21TIn9g1tE8mSuRPdweJJyiNuWsQ+Avplji9EtPvRxq6bFsrVwNxH2sMzWp/3CfeB0udgvB2t4eYj2FLBRJu9ErOaZJ/i2WrwtwLl7pDCtF2e3oB3vyT/jxi8baD++KxGZTBQdKlaEXefp408nNQi0a6AMcI6Wc4ipRpgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZo4h8Oqx+9F0EfePin0UYLeGX/KzwgsGp8IDQrP21Y=;
 b=gmfDtfJr/w0jkPNdKFUrafiE0RT7ExFGo3SDJsH9acdmFo7MsivKMjVwAOBXuC0isipfHJkKZdhdCDYS7V334GyOPb5Bu7Wq8L1/JEL8vMExDWhtbv1Uey4460iBNcHMVf4VGBQ0ddWxhtV2Ry4cwtt6D4IYI0N1yem7BOt7vHihCTkEn0phgpQfQhPtj1fddnAmyYvMbuj8KOh6k8EYxx5/pGS/R0wxFnThVxeqBMtML8oPkPec2g1MpApxFDp7DRPlSQtcnMFAcBanShVYGRsOZPVXD0RJthgCs8ip1DVqP9LGvyPmCAMj8kF875VeW2KW2SbchfK+tPXVPHwLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZo4h8Oqx+9F0EfePin0UYLeGX/KzwgsGp8IDQrP21Y=;
 b=SFofzQ24JWeGkrn2Dz9ZPvoa+lk0CaoVZq+xu1KaCNFA2Ul1CkSokNBSrBeeauBXfOjlUDqw9BFKuCI/v0AZGUJhDquZBPX2vUwbosvMBH0kxaWhcfFRusXga7Zv//2WzR7UmT1KbU0vlobl/zT8MU9zuHZ3QHkiD837JbX+tPk=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4310.namprd04.prod.outlook.com (52.135.205.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Wed, 18 Dec 2019 00:57:22 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 00:57:22 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] New zonefs file system
Thread-Topic: [PATCH 0/2] New zonefs file system
Thread-Index: AQHVsRth1IpCuMwSZ02s8MNISyP74A==
Date:   Wed, 18 Dec 2019 00:57:22 +0000
Message-ID: <BYAPR04MB5816C05227160785F7B88DA7E7530@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191212183816.102402-1-damien.lemoal@wdc.com>
 <29fb138e-e9e5-5905-5422-4454c956e685@metux.net>
 <20191216093557.2vackj7qakk2jngd@orion>
 <73615b86-6da7-0e65-0dbc-c158159647ef@metux.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d2f2f138-66fd-4f60-8bbe-08d783553dac
x-ms-traffictypediagnostic: BYAPR04MB4310:
x-microsoft-antispam-prvs: <BYAPR04MB43108B56F78F91C7F3287493E7530@BYAPR04MB4310.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(8936002)(53546011)(6506007)(81166006)(81156014)(8676002)(26005)(55016002)(71200400001)(86362001)(7696005)(186003)(66446008)(66946007)(64756008)(66556008)(76116006)(66476007)(91956017)(316002)(110136005)(2906002)(33656002)(5660300002)(52536014)(478600001)(9686003)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4310;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DjJyhHe6gxMKxASWQ947rzrqF6IOUm6Ji7+H82gdyQ5ZIS7t7+4Fmoy8/xhtFi9J3YzN8UPyVLATHxc9aykvNy25/uZVTH8j8ROd+lcpTc+fal4jbsWad/58Icf7SpsfRSCLClhz2yag/DVDEhDONIzAfo7iJEQPY54UmMmwBHt4EjzjeAJ4Dedy7vQCvI2Ej0x5qN6HJ/x15mxIe4xS4z1fVlCUsHgx26RCnEg5g4rJk7b7MXP8/0KwxhPygACP1jJWY1yNjA2reMOsJ9dRsYJBhZZ/wZgYpB8fS8upkYOgeP/2nsKzoP9VxECeuV5lc6jLd60BkJF7Ap6I9eLNbWlWCPK3e2hn7jak+uAoDb+3uBK8HeKJoVTf3wrlIqOAGn2yq4L6gsTAdawbClgf0iTR1yJrijcPP9l1EEx33udGJa7XAJbQ0uMgFYc5UdhEkuxcigZEz0HYoW4oMTwt4VRDuFw5Ax7RAFBmdUiXC3s=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f2f138-66fd-4f60-8bbe-08d783553dac
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 00:57:22.4712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3kodV0ERqhJxCp9BW1TeKgGe66CYabMyydXT/d6jJD+ZPoRaGJn8NQgc82zFPHcK5nHgDwyD67BEDtzLHQIhPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4310
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/12/17 21:34, Enrico Weigelt, metux IT consult wrote:=0A=
> On 16.12.19 10:35, Carlos Maiolino wrote:=0A=
> =0A=
> Hi,=0A=
> =0A=
>>> Just curious: what's the exact definition of "zoned" here ?=0A=
>>> Something like partitions ?=0A=
>>=0A=
>> Zones inside a SMR HDD.=0A=
> =0A=
> Oh, I wasn't aware that those things are exposed to the host at all.=0A=
> Are you dealing with host-managed SMR-HDDs ?=0A=
=0A=
Yes. The host-managed models of SMR drives have become the de-facto=0A=
standard for enterprise applications because of their more predictable=0A=
performance compared to host-aware models.=0A=
=0A=
Many USB external disks these days also use SMR, but drive-managed=0A=
models. These are regular block devices from the interface point of=0A=
view: the host does not and cannot see the "zones" of the disk. SMR=0A=
constraints are hidden by the device firmware.=0A=
=0A=
> =0A=
>> On a SMR HDD, each zone can only be written sequentially, due to physics=
=0A=
>> constraints. I won't post any link with references because I think major=
domo=0A=
>> will spam my email if I do, but do a google search of something like 'SM=
R HDD=0A=
>> zones' and you'll get a better idea=0A=
> =0A=
> Reminds me on classic CDRs or tapes. Why not dealing them similarily ?=0A=
=0A=
Because of the performance difference. Excluding any software/use=0A=
difference (i.e. GC overhead if needed), from a purely IO perspective,=0A=
SMR host-managed disks are as fast as regular disks and can handle=0A=
multiple streams simultaneously at high queue depth for better=0A=
throughput (think video surveillance applications or video streaming).=0A=
That is not the case for CDs or tapes.=0A=
=0A=
The performance difference with CDs and tapes, leading to different=0A=
possible workloads and usage patterns, is even more pronounced with=0A=
SSDs. In the end, only the write pattern looks similar with CDs and=0A=
Tapes. Everything else is the same as a regular block device.=0A=
=0A=
> =0A=
> =0A=
> --mtx=0A=
> =0A=
> ---=0A=
> Enrico Weigelt, metux IT consult=0A=
> Free software and Linux embedded engineering=0A=
> info@metux.net -- +49-151-27565287=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
