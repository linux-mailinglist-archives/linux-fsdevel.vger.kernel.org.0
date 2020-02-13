Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8D115BDA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 12:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgBMLc5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 06:32:57 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:52830 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729544AbgBMLc4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581593577; x=1613129577;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Rd6RE3zbmGXhz0C09ffUhhPBMFUQ6yb9zYRGajwpKPNBaVcpNmE5/2qK
   k7quYe/tSQ4MG+dtNsMwycj/b2cAk3ZOAZ4OZ5jKf9w5K6dJx6xdVC7gy
   C7Mz0w3yWRwOKhE+/AXyeN4dLBy04iv1VBRPT7uzBj76apI3uFL0Be4Dn
   q+faQ8grdqPdk5fs5sedST/PAbP5RSFgnfiBraGqVzL7sPBxIgQXWS95F
   TnOP7MHkO6bEBxSF+cnvwb17K0DYnLx10unEVGghOWs+e5u1IUqCcz4MJ
   iL1seg2+aCEh24tF/dGIgwC6NQXmZ264KJ3iT6Luj/Ol2PGG/0A/tm2oZ
   Q==;
IronPort-SDR: civMeK4Ca78gBT6OVxi4RsCwMEPBU8jPZCdZHJoCRdjaXV/qdUqZ+1zGy7BgpuZ5UnN2E3Tn2C
 8cLKvw+55MC1jLKjdmpoMRAXvE6QjauIGVDx1eTOWymvY9bF79B6O2KJi5XB8gXZk7Q+zeJu6O
 POcm4S0+M4ptCuyNiX4tOiJOLuZlqWv+UAzVUFg/0rO03Yn1gKLn05eNTYDEvBJb9sbESW5mmR
 oGkwRr3KF7XF8aCm+HeXrrR5Y2we+n+HJQXW0RGy9H+2O0IW/aT/uOFDaZIEY6wVhPWQG9e/Gn
 JLc=
X-IronPort-AV: E=Sophos;i="5.70,436,1574092800"; 
   d="scan'208";a="131214897"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2020 19:32:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbWonj9JTg/3gnuUDOLmDzBIv6Y1geJAjSOYmw/9cVnTDGJR7B9cEpIO+Nxi44yClDHIobbuFF00bZeHwgCM/g3+DQfDxHcKA1X2SC9zDFa4dCU9BR0YVcqqhTeDdWhgEPdFDYvEsDBNJ51uDYWbgeSbHMunR2VYFnPBzO90NuW5bqVL9Lkl68A0s6eEXv4TByMpH7lFSnCOA1NT/XBSTIMS8hht0zQP2eoy0etLRQE42I2Z2v3vAnBl9UMRBv80tvGE5oUyVDBMnKUkxk2T/La5ysBHxEjlyQDYqhsw5C8nhbwdkQ/MFvpwZ1YT13dVHkJf8meLTTMMWR7xy4h1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=oJRQ69IEuXdw2Lr/AKE3FLBSbcHb8VymHYxuRoIto2jztgX3dLmn6Qx5bTOW/WIMPQqAXtVtUItZnX4lGp9AUMvr4IO/88F63wk6qeQ1bDCH1kNWImHoW/IO8H8XBlZAMua5p3ndeOstE75sTKdYXBrae6a5hzzzgp2mS+njaYugRdlIE7nkbexk735qiKcFtI4143jrcDcbv7Z12TmoTIxXyv7emddBVwfqatNY4M8VMw5QylYYVsvJ+i77WJs4hnSFK1CaP5x4MXtDPw3NO/1S5yA5Q7bHMk4LI8W1RUmFYyDhRaKU2KQGYxfMQTwp1ggI8mdV/KpmT8tZGspGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=PmM2Uf5ob8CI7DtoFFijU/IVo1tOlvENsAot2MFDTuUjohALslSWR/jBl/HJx84E0yZXLFaieecnxWkpWJuWxbTWBmX22gM7GHb/6BmTMQpkQhgzGrYyFAj9iiOvUU1BeIeH8tt7dUuPWlGUCpeW15u5cyqAu9i1Y9BvFqSS2ys=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3550.namprd04.prod.outlook.com (10.167.133.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 13 Feb 2020 11:32:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 11:32:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 04/21] btrfs: refactor find_free_dev_extent_start()
Thread-Topic: [PATCH v2 04/21] btrfs: refactor find_free_dev_extent_start()
Thread-Index: AQHV4XUCS9lV+S1Pw0SExZfEWPqjZg==
Date:   Thu, 13 Feb 2020 11:32:53 +0000
Message-ID: <SN4PR0401MB3598C96EA1A54EB3534A80A79B1A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-5-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4235f13b-fe4c-48fd-fb36-08d7b0787739
x-ms-traffictypediagnostic: SN4PR0401MB3550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3550DAD230E2D15CBE8A9BE49B1A0@SN4PR0401MB3550.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(189003)(199004)(186003)(54906003)(5660300002)(316002)(110136005)(19618925003)(26005)(2906002)(8676002)(7696005)(81156014)(81166006)(33656002)(6506007)(478600001)(8936002)(55016002)(4270600006)(9686003)(86362001)(71200400001)(4326008)(52536014)(66446008)(66946007)(66476007)(66556008)(64756008)(91956017)(558084003)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3550;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kWGSqEUAtDSf0XiiMDrrXlu2al9g7Wqy14SKzS5LktMAuhQWmkJ4fZ4LUCV94U1+qmu1QNQoXxFC1tyd168oucTVqurzMWexTOcNgqR8pyjABgZ5nXglUpZriY81PCEHjnMPStz5vuhtd8f/Fey8xUcJl4UZuGtH+zpW/+Fm1f1heSEKBrqjHeeHGZci5if9HEmo4HArAQ4JV8al0RYkq1jVhB836l/fkl9dc3EZ4aatN26YOCH1Z5tnZorx0ofEadl1SeG/CnmYdc+sFQ0aLhj1EYR8sS090gBz23+cmXjI4hngE8SyldPRLqmv0G7yOfY9pYinxroFG/3ITkBd/uh0EQtMcst9GyTMooitkWOVKVQYTiw7TeoTZjR1OM1LIvu9LBg9r9lpdA4m2fuUkIQh95PRI3jQej/Zw5MDj3Dl1hYtdPdShSJw/sYQ4xWQ
x-ms-exchange-antispam-messagedata: sZrALWlOSuF/sUbUPyYhIotypCTC9WSZsRRuR8fgBHF6GMtsq7b0pfUd6I/8hvvl8fR2sq6Lo8K2h8KnjWr7JZ3UyqAkzve/R6F6uj0JMaVGgRHztEy4f0Z7eQ4Z0nRXpYjddWFuFTHDsFZyw1In0Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4235f13b-fe4c-48fd-fb36-08d7b0787739
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 11:32:53.7628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f5oZHgjHtbVGuxqdVcHftOybTVwd2KUg5btI2lF8rKuZAzbFjr0ffzOa3i2Ff/zsjmBE93cKEL6xWXXRFEj/JLWWL9MH2FW8s2Kc8ob0AW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3550
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
