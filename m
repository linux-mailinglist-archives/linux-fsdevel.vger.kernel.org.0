Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D71F15AB56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 15:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgBLOvr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 09:51:47 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17844 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbgBLOvr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:51:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581519106; x=1613055106;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=OKPXrQl/oa3cW2Pz4oFE/Lt+TjcgPKXejTuldYyP8qI/TmgeOQlrsZ/H
   zVCMZBByl8/V0b+btB1J4hEAMAS9h7c04PsSYZCNkSVM4SazvP3jqV7Tu
   3tMnWShKqQFURlC2LTkzhQrIVBWDxBNb3MERw5NNkVz21/BmP+Je62Iha
   ZmeF7MDQyCmukW+fckHXzCbw77SzVIKzhV9EbY+9yh0WCU1jVd6UwoxPP
   C0BbBnouW9clMz+1gRc4p8gTMkE/UzEM0pFtZlA/aNSu2z4BL5LKfegbV
   KKJ/IHgRlFEokBjM04KacuwoEcZSWLdrcyyWTos4Ta4AtzUfd0i0bOvKT
   Q==;
IronPort-SDR: viIzr9L4jRSS8DJ8SFRDbLBc7lwfZzaX9ndDkoiX0mDsW6/jARQ01R8yMgGGQ6c/5s9SkSQxNC
 ZDHfDFEH2Mjk1UYsDlmqGoXk/OjglnTAKOKJU4EySE3/nyJVv3ac07bIappJqHylLAJaFT0nGc
 4jkNQQI88Ofk9A+87asRHr6z7kKicEKfj95HjznbqEAryg+d2aNkGVvIAMm5WKLwQfvgQETthN
 nKxO2PvVlU+Mqoa4CueMTmTweRNTQYTCShulQwtIq2kC9eXWzU7B0jJFwsL/k7jyeZ+GBnNjIS
 Mts=
X-IronPort-AV: E=Sophos;i="5.70,433,1574092800"; 
   d="scan'208";a="129679370"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 22:51:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1NhuCRoaTehypeDTSdL5ppz9UiEoSZ2ITjV86w7cU0zGMRofUEFbV71LObdu8XP0RCJ2aABvtsStCDZx7UsWVCk7BCenPSmq9EAOeIEwq07rQb+j7dxg47dSjA54C8UzMN6RrViuugFuiYqeG+jXVylLM8BDunpJP3Dlbqb53no4IXxOEDKxvqyhanPOiJ36oGqVwC6O3UNk763X1R3WmMQD40I1u2OX3Eqe4TXnAWfQG+PzR0Cmjq1GDYkxwmVy6tHm70EpODpaYrv8B8ibpJZkwvZyka43VZX74MiZ5EJn+dFnQJSH6ZU9dPMwfGrAKluyu6nCJ4HrOi90DlNtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=hScamzKfvkw8j4kN880KUc+geuOlsDqi9FXsesCH5bLEdZQ1zF5EG0t0dBCqvUAOKhyFUCq/jpOYf8lT0oIDwmyxRHlYIytO221YyvKE9Z56Scf7zgNoZncT3kPtz2cfdfMrzUFci6ALiwl3oB4GgGgvM7u46GpH0QLtLIQl7DDGt8f5X6sy5Xt3cFme8vRklLNl3nyicMyXPpSJ21V375dY7g+uVIzqNHGUOy2xk51gpJnBX5OHOez//Z/JZMQQh9ncNiJu257vcV8OOnYiUQLqGdrDO+/LusukE+lSU2zdFbgogMtQWKKUHS90Up9FHiEkmYlq+MUBBzXrVjpFng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=gZByf8uwuVspHKmJdo2THFsl7fh2nh5i525/zcXuFbwnErm2ui1x3/sldmsAbYhiKijvk2k6vBFKg5OlctJvTNxFa6DPP7fcG70joLefJDI36ZL2H76mzyCfrzdgkGd/C35L5z0RjQi0+2uSW8NOmeOitYF+SLNDOB9l0WyHGtg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3711.namprd04.prod.outlook.com (10.167.150.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Wed, 12 Feb 2020 14:51:45 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 14:51:44 +0000
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
Subject: Re: [PATCH v2 18/21] btrfs: drop unnecessary arguments from
 find_free_extent_update_loop()
Thread-Topic: [PATCH v2 18/21] btrfs: drop unnecessary arguments from
 find_free_extent_update_loop()
Thread-Index: AQHV4XUTV4AbKMI2DUWYkpDFsfK4XQ==
Date:   Wed, 12 Feb 2020 14:51:44 +0000
Message-ID: <SN4PR0401MB3598FC6A7B5F8046DDD2A2A59B1B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-19-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad76a385-8838-4362-81c2-08d7afcb144c
x-ms-traffictypediagnostic: SN4PR0401MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB37110F3FB2FAD4227F760EFF9B1B0@SN4PR0401MB3711.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(9686003)(52536014)(5660300002)(2906002)(4326008)(4270600006)(110136005)(186003)(316002)(26005)(7696005)(71200400001)(8936002)(478600001)(55016002)(81166006)(81156014)(8676002)(86362001)(33656002)(6506007)(558084003)(66476007)(66556008)(54906003)(64756008)(66446008)(91956017)(19618925003)(66946007)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3711;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a587P1/STmZEDc2leaM796VPjzx6zAn4S5c/w/HP06KWluHeKsyZb+x7v2C27g4YerTZNvfLcVJ2S3KFxt1J3FFcfiqWsLtHZzLQkhnJcjbPFzdAupEkuhTZJb8LmeXXb9RWz7G+QzvhofZbp9TMVuB3CDIEZ5AsJhtJsCrB/mV77KuLO++irqh4YBiTDhCHmaZwVu3ExjZA0ZXLfCU+BoHR4IpBWmNi97YLA5WwkeqvNlUKV88ejn7QhISzmzPJbPEPV51AXJ/L8My67DRgKg6qaecsgxkU77h+3nVTddBkH6BG17yg5ACSR0gyy8VDb2I3k7o1yL0L12FV1X4XcvqhxAI7gawrANOwUVpi4/etjfSctyf2yi8P6mI1HLZI9PYxxzzjL9Pn5mGg68XV7bxD2qyifwZp0RR86sE9nACEZpznZr2p2E9uyKL2VgZY
x-ms-exchange-antispam-messagedata: RknTA1dl0iamSDUZ6PsUnrwx/qIiksZDW4sgX0RkMKspRWvtqIKmoNxxGAmNonpHuMnCqZlSpWwkTWdx+EcQOA+ldP+v/b1Xu2XZeMNw0tVsXNUMoeMIEdllz/3B85sBSBfQ66iCkiWWE+L6x6E0TA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad76a385-8838-4362-81c2-08d7afcb144c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 14:51:44.8835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLyGh/xpnNya5WYrxa9WNnlEsp7pAndpQTm28L+Euy7QXoCC6t9w/oyhPsQnXIn57N/2V7y+YYtNzaLtA1FOTyWOg61L3rkPQa0cuA1NyPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3711
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
