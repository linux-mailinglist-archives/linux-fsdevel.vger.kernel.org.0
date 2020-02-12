Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEE3C15AAC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 15:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgBLOOM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 09:14:12 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54671 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbgBLOOM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581516880; x=1613052880;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=IK0Vo9tnaJIj1JZfjPzbJX3AjqBPB4gbG1A8N6khKdfqcxFqpzqpOLU2
   0KaqdfTX5S/PCc6EWb+bwnJbwy0WVscBiupKggKvOMkYunA+P63Ok6Yzv
   IYtfrEiwKpCABuQaDJMOI1+lJjRAQl1eWOUzjyO66WggrF4MWexM7YeZ7
   /61jzBmz3iGhawPh2pMGqn3VKCVoDTZH1lE2KNbAlfyktEwVfyuNcUYnb
   LYR1VC4iZjJ9cZ0fCOfJQ644PyAnLgMC/+JJ8Lc94lT0xoe4S0yCXT0h8
   F4o8uRWqa2iqGoKwBO297uDyEYVr24F0pzK0z6By7g5mt0L3fP+tDIHlS
   Q==;
IronPort-SDR: ceQl711gLEaulJCE01Z9z5dUd/aRZpuu7VogvAsChZj98j9NwImyjrcu7mNvdke8mOZy5E3yfx
 mXo5jtnx8GZ9kmKxHxoFb3pq0yZSWSSfQ5ULKucrSvFIs/fv/kaX2xzkV220/HRjfItTgAqtve
 yOB6KxEpZwmvbWZvkCTz3ZMxnosLveP/v+t5LyeZezWigWEKQSPUD28PRwQmXhmS5cXMD7EuEV
 o+MSHVPu3ZTH1uq5Ip5UwKCzy+C4zt9Lt9U7EBAYrTTzDdydPwQrt0Eh0C0l1Cfcp5gSH0GR7b
 R98=
X-IronPort-AV: E=Sophos;i="5.70,433,1574092800"; 
   d="scan'208";a="231472265"
Received: from mail-co1nam04lp2057.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.57])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 22:14:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaR1axLP++Kv/Pqk2iEGQQXPNBpYImqSJDua/T7NAXEvoGRSwwKbQOKkDSJMsNXQVlxhWD0JGCXQbPoBlAIO6P1BSFnym/forhcCn/QYbFICXViV/nYhKZ0shw4KeuSG8mTgxR9/TBPvauLTFNxD9opPULi12i4yvq6nzqoe+9dDJ+QAq962hsZsPqYRKTDXGbVioi3el8U870/PXKRSkHrAx9f6Q3Pu0JyRGWfXCv6JTxAkQQgY61yS4Og/2rumsFPfn+V3uYGnxL234rM+RiRDFS/InwUT+GbFkz0nUtu1FhD/cpYWAZ0t9YAezPvApzFhDJOUI0WAAufF3j8ygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=cw8VWTSCtc2mw9JY3WS8wQsR9PNgLreGDZ13EeXNUDbriG79mooOVSLQWIU4ctMKCjZm/qwBS7UZst6+J+hHS+1nqd65UuXM54hyu44DvfkemFjslw0jTy0Q4KJerQG+8JwB3FWOAHFTDOFvPdbd0wvA/s9hwWE5gqH5SfnUhg8/P/YrmO/ng1NjphcZHYnErMevFvykd4yof5M+qScqJoKUmowStQxZ+9+eKwnV+9iaxv5Kdvx8cAruYEc+qO2ZJO9jVEGKtb9cOCFN7z2pIrtTghCuGK4HCG04LMnyDvR+nsshI2MzehnUPFcOKKTDqzAiP9uEJ/ig+btpl2huDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=pfQxaOWNNfNSrrlul1X2hWxFjdwYrfmuWrG4Ok02C+HBg7Za61pL0AO1hO77ymLF7QbsF+kfKXjqAtZlWTkIXFDWZJ9p4kQKpK/AGDDraaFfzOHULVyBYHQwVMWIzhbTtUwCrNiS7uOqIFe8z2+mBfS6JLs3bRnmXCa56A3O6uY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3584.namprd04.prod.outlook.com (10.167.139.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 12 Feb 2020 14:14:10 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 14:14:10 +0000
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
Subject: Re: [PATCH v2 13/21] btrfs: move vairalbes for clustered allocation
 into find_free_extent_ctl
Thread-Topic: [PATCH v2 13/21] btrfs: move vairalbes for clustered allocation
 into find_free_extent_ctl
Thread-Index: AQHV4XUJsxgiy9BVBEa6Fgz/WTHz3w==
Date:   Wed, 12 Feb 2020 14:14:10 +0000
Message-ID: <SN4PR0401MB3598165C1C591F3858CB4EE29B1B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-14-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 678aaa6e-478f-4bfa-4729-08d7afc5d471
x-ms-traffictypediagnostic: SN4PR0401MB3584:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB358437EB6CAFD64364005E699B1B0@SN4PR0401MB3584.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(189003)(199004)(4326008)(54906003)(110136005)(5660300002)(86362001)(8936002)(8676002)(19618925003)(7696005)(81166006)(81156014)(33656002)(2906002)(66476007)(64756008)(66556008)(66446008)(91956017)(26005)(66946007)(558084003)(186003)(52536014)(9686003)(71200400001)(55016002)(316002)(6506007)(4270600006)(478600001)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3584;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L05PwaPqr5CxY5p/2mUgHqV+L73aYCjCWc53WZeUx6VyFd2khDnMDQTuEt89dq7BS8stN7xUx7X5oGoLFkKKsvnNRe6SufvmAf30xy7kqc9Qrg5tqGNFe9jiGRKVQAGLzIlxcxpeNWaIqv4YWrMtzGnwZAXrTXe8xBqwkQwMncbBZ7/5gzOPyifLbuVvwFxByGehv62GpH/hPD9bQEuOrMqeyq9rx929vkk6+4pmlF5U2N+qDlCbOUXs/yJsARsHOPMjDrEhl7JWixm6TwyvbLl/HiCxIo2sVSe2kxsFRgW+4LiNFEoKIC4fX20vUHwrp1s8HhMVYKFYHNngBVutJHtUW7P/k0zMQcRsAWRngX4HdLTDlk0Z911/VQzTJvIPjQ1j8N3kAqe45BAFUrTM7fyWvhwubne128YTyHVDeMM8FiLMrl+JNcaZ6sG0P61k
x-ms-exchange-antispam-messagedata: uf47b8920IrIAaUE39UXGpFIs0FSbMojbQ3Xqon1bRN35VChmV3ORWNj4PMo9runsCYiAiKUhqL4ZiAQ+ZNtmzfrSbpnn0RSqVThKLa2wNg7nciSr2pAeNijnAXtqf/9uiI/ePQE+RuM4/LMzI1C1Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678aaa6e-478f-4bfa-4729-08d7afc5d471
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 14:14:10.2257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nO1DpUSlRbYI54xqQ41cQuPGlWPX0BDmA2/04VHqMrE5roqt+7npCxZJtEvKphv+hlH+XiUovM3eA5cg2kQV3zt2kNTJLhNNaDNSv5qZ0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3584
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
