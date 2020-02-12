Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 512A615AB40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 15:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgBLOsw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 09:48:52 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17574 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgBLOsw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581518932; x=1613054932;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Mv2xBzl656rszrzKOhoQwr8HG7dOe9YXegLFVXzv+7wFyObnd0OBnLEw
   pajjLZekwZTqnLIVcHBLXtLgSIKxPDeHXb/SyiwU06rvtLTa7Nb75UOMZ
   mj2poz1uZINN5SS4oi7JttJ0qnleHUyEta+yXYB4ECiE/7Id4FBsOs3Ne
   6U26RJLS3nk2jshm0mdKVmc1yQqUN3Cc4aK+L/zqbQG4fDkJaehMzu1qv
   sGJVxrJIW8Hzjx/dr1F3W9nkqZe+8l1k45l1SnptkVIhiUdJrKCfag/kk
   /pqLCnl3Piuvth1TdA/sgiECrISle0FbOlk1ITnrLB4ISQ8cQ0r3QQmlJ
   Q==;
IronPort-SDR: VSJO9cfy3EYeswzca1IXr17bsU12oHm6Q9IKoedvGMQMVuhYCA4zzAG/Pyg9kEEfhWIdaw+M3H
 Gld66/bCfYzr/y34D0k/Wnps6lS83M96KyJK7iMS+uLCVhnWIs+FwkCXsbb+fFlQoHl5EcCAVQ
 eG4uUZS+0xnCjozi6yK9a7hjCLzjrPoCcjTMil4vjHM7/YT92Bo0JGwFhVQzs151C5IjLIuaIF
 KOKBi/nQDDiEhaHcbK/Bc0UPWNX9ox0EWhTbKZhsQkKXIwcvUzjJ+15T/84nGM9F4raNUE8SYW
 fWo=
X-IronPort-AV: E=Sophos;i="5.70,433,1574092800"; 
   d="scan'208";a="129679220"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 22:48:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFLGMLRkQDp1vRiTL/44wQokRE2O7OCp86pp9yr4qpr4vB3a7kIh0M9ZmFJ2Xu9Yy11rshECJ5ZWnkyLeesxem15HnZsr+QkZX0cpF0K5HSNFW1Ucmr9/VmknmMzyD2NzEGn+c9xkzWmiOLTX63GoTqebaMUG7yDuYlKL8HZLQFVArYo9nRbgkMpCAYmZyWUJT0Luc88j8fjJbH5ERpcY4AzEt3X9DooMU+h9hjOcxfuFcqNDiclyYZjpyK/SlbBszhXfvklP7ZAUU7plYdD+DSP5HVThOD6w2tsaCY918fTfag1dNS3naCiAr+RyNtCn2n3OzBs0qzip8K0HvgV3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=alTlrZFMozNHhNe5YxSFeqMhImyB2GXmR2p1qYqfHrE5HDaUXlNHiAmdQLXcswOp4vIaPP635XZbAxMj0LW6Pdpmxdsbiud2DrprFkwrFkNkBI+A0fVkJ40Fr9Pjg0O83/nSb+zEsYTXai5i2X4cK2vfczlC29hlgeUeCUvFviCssLpWMaY52lQC5A+0yz8Y9ThdGKGExA5syRFHMpm5ra8SsX0RHIpnyQH+3WoxlBBp4vgZNF5hS4tCNizkd8fg7UQI9X1VPizLnxy2e2IlhbS/2hjupklZ1N1oLVW7Gggn5+a+TSq9RuPDIOi1n8yZdpfookh+g2/0NP6uYrcvQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Qg2FcJrZt4psd/3LIAXd4EEA27xRmButsGNMaQxqmdsYWUYViQwqwW+LhYVVl8CWY2h8stxGxqh7T5jClTZQ5R3t7DtfjFKhGScVLdWHkMWmonEMx9HP34xmvOnbxNch90b3AbNtt5sgiOqXVe1hygiIBlq0sHN875iYepP9r+M=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3711.namprd04.prod.outlook.com (10.167.150.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Wed, 12 Feb 2020 14:48:48 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 14:48:48 +0000
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
Subject: Re: [PATCH v2 16/21] btrfs: factor out release_block_group()
Thread-Topic: [PATCH v2 16/21] btrfs: factor out release_block_group()
Thread-Index: AQHV4XUNGs19VUOuvk+krgF3MNXcKw==
Date:   Wed, 12 Feb 2020 14:48:48 +0000
Message-ID: <SN4PR0401MB3598C787B8DCBF6038ACD2E39B1B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-17-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87165258-29b3-4601-40a5-08d7afcaab23
x-ms-traffictypediagnostic: SN4PR0401MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB37112AF70CFB25E67A5C84E59B1B0@SN4PR0401MB3711.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(9686003)(52536014)(5660300002)(2906002)(4326008)(4270600006)(110136005)(186003)(316002)(26005)(7696005)(71200400001)(8936002)(478600001)(55016002)(81166006)(81156014)(8676002)(86362001)(33656002)(6506007)(558084003)(66476007)(66556008)(54906003)(64756008)(66446008)(91956017)(19618925003)(66946007)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3711;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Jm0hGEjPG5hGe8jBh9hE98ygvZSQxEibp2TZs5iScqW8rps2twdPWNVnRzs2AvwsEmkRjWMHeVtrn/f4PineQuaOKsmhAP/icvNkTFPTgwKUOwSSxByvJ2auMlGDGyy5b/NrCuN7YBh9SNBpKVhPcuHWhF2mFjnHN92f4bn6t1BX8gBOcs50PqTsK687MQS9ZJwCZWyYfLDhGEXjjvpLG39pi4Lyr+8z9p1dAonN7ye4CwIYr4SaCjVHnfBUOzLpvrTf7NwC9ZABikRIqa5WM4tB2AJF+olwFgZlAzPCpLRU5IkX9YDQMFpWwnYiJL4CLov7VhmcJ9JOaH+XZK9hV5C7ilDIsqfIRhw+82sIcGNBp7p2AILlTkaAXTCsKBn42jNGr19zBHxQDPuYAiXKg+mtcEOmrU1Lw4ogOWDreZ4I2jxZt6bc3i7pAVN19/t
x-ms-exchange-antispam-messagedata: R2o4uZE72zY8A7GRd8WqvRNKEz5Zg+EXGgcqxuN6sRnSDfAtxx51/zmSKNdz24LdqsO/jqWUDlSY3yIykCmZA9beH8tMAB4645wZXN3H73Qvps0j3Vl7uF4t2+/G785/sLCzjT79hx3HTX6yMMe94Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87165258-29b3-4601-40a5-08d7afcaab23
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 14:48:48.4653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w1NCbusYV5TMu7ugnf+pSh5+c/fa0tm/XlCS/3hDxiGcg6ub09E14lN/2vxTrknd/upN06dJmf8vuc2pfF9NQQnPaRssNFpPndxiEfYNjYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3711
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
