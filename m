Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E07915AAC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 15:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgBLOL6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 09:11:58 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:53847 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbgBLOL6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:11:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581516717; x=1613052717;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=bMICyRdgWtoHFsuXi5Mc2VQhMFN7xft9X4ISYYWfBPpd08mGTB/IsiJX
   mXfI3SPXOEBtnUV5Uckc9Fdsrcvxwj23+HtMNuUprR0VvavLX3y8gD+xr
   Fee82N4J+hckUd34tXmSZLLp9L2qdLpfVzo0YSvR1Xca15sOUbs/QKT7i
   +AuL0Cje7WkuooGDulOqjNL7pmBXZWMjBe50shO9lmhbOElYzhl15lszf
   sC+XXPvlv20G8XQB6TnvF7CHCFd2GZhN7OSozRJdCuQiiF6NUAQ8Z/4pU
   5hcLNfosmRSmnsLT4S5APi/srU8PTYcf5F71hHqdydWKBgp2NJVe5JFJ3
   w==;
IronPort-SDR: Q1ZiD2KmzlNurelh54xDRR6WIDsb6GC9DBZZMudtY0k/0ij6z7T4zK1bt4+YsC+Dzz+oslRXdb
 MJ71DqdRs43eFa5LNMovblh0QGQM8cSYOdg8FSaWxd0DIlYhtZgTSfnM1tjZkkbeJtXE4DkO3A
 WcfZ/fMIe8Ro04frc+XN2d9KUh5dSRYV0nyBIAFwP+Bzk/4nK6fKORpGi7q73FeuW2V58tU2/b
 mQbQI/DaRNK5h3QqbpfyXYl+4agMK23fWigPkQtoVxNtBWm6sRRH27B0azqAhwMVsXt6HT6EQQ
 oxE=
X-IronPort-AV: E=Sophos;i="5.70,433,1574092800"; 
   d="scan'208";a="130212187"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 22:11:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0Cpfw2FwlGVEghmVGEdJXtwjXwyN8hEfxIrKNTYPzHHA7egebXZZg0ByKtXhqo7aJo4YIOGT1TV5i/b2qkOqJ8pzPrlRZZgauBf4rQQWqUZfkLoiD1ermcsenJQThhO994i01LweCz66126NGuiHjmIi/r+xAY8iY20uaW7M1a8hTmyYaTsrkxzzEfP0x5cNzhVWL2k/9nEWxLRtnnSbs+oBHlSjC3JSfSX5+qMGcIPYEL8YeD7TVNr3d+D4hN8E/PSCa/fLYFNiI+nVBSH/t3C3eIv+cuILbrYuNOgda+XM3Ind/F8ts9V6m8qpbKPOdQSGu+Uib5eEqMueWFSKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=VHQ2SxOG/JobSou4SMlEmgYIcF9tfdZ0JA/vVH0JkC5VJmxx4B7B2JT1hpd/zJzSKEns3IY78H99GDSZaa2h0KVRnMxlHA6UMKD1YoLp+bNkEcSUOweUN18N00DAD1zzfzCi/Knz1xDnuFKgDFYvAYphPe31qpWTQhFPpHFbMfnZ+rz31jGMkXJJ+Op9P4MFsn2gwJrqPe5YlmrBG81+IiUAvePh9I6uCYlw9vVD7Xq/ywayIX/GhXIlJcuOU04vVwa2zBBgeEd2uZWHHvjIBb6cGNd09/0ubbtqZSeRFN9nNNd707yLG1+RMy2qpd2N9JjMGAk1H/EbxuLmIHlyug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=QGjP1yL1hFGaj9QbnrgcbiEtpdQcwd1Z+PJMs5v5BRcdxp7TXtn+mUftlzt0FZQX0BVbEhn1DtIuB+14P46IvHvCBPYDO2vX1Nq+cVP6AMyAqJ1yeoOQtVB6F+IHL8SCw5pVX3zYtRIX1MZMJIguFp75uNDopkCWTSkWYID2Sk4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3584.namprd04.prod.outlook.com (10.167.139.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 12 Feb 2020 14:11:55 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 14:11:55 +0000
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
Subject: Re: [PATCH v2 12/21] btrfs: move hint_byte into find_free_extent_ctl
Thread-Topic: [PATCH v2 12/21] btrfs: move hint_byte into find_free_extent_ctl
Thread-Index: AQHV4XUJmksLRytey0On/SyVNZ2ehQ==
Date:   Wed, 12 Feb 2020 14:11:55 +0000
Message-ID: <SN4PR0401MB3598256309D3236B4C1CEFCD9B1B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-13-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b412ee5d-38e4-497b-6311-08d7afc58401
x-ms-traffictypediagnostic: SN4PR0401MB3584:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB358443FEACC85BC581AEC2739B1B0@SN4PR0401MB3584.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(189003)(199004)(4326008)(54906003)(110136005)(5660300002)(86362001)(8936002)(8676002)(19618925003)(7696005)(81166006)(81156014)(33656002)(2906002)(66476007)(64756008)(66556008)(66446008)(91956017)(26005)(66946007)(558084003)(186003)(52536014)(9686003)(71200400001)(55016002)(316002)(6506007)(4270600006)(478600001)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3584;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y8OgMZHy076EHF5s/XcqeeKxJ4F8F3Rb6VNMN8XhzyqAONDkKAcg8AZe9fxOlOuH3CLQggmTYkBsKlmKrtOzeoXe7An7r67YyoGl+Y5Pig4oEJupnzBii9NLDWTaA2nl96eB/q+MCBEXX8lttc2IypM8QlfS7m6ddeQCnWR4tGWhHJ5XwWe8Fx7SqdKYQfU8kF/naRoii4kbOfRatieEujrgU41v0o2zukZ2cClhjbw3B7mlE6E6tFrLo2ThG6MDNqOa2jF0J8R0opYI3Si7bpHl7LYUdIFcThSEi2Klm45wXcEB1LAUqQwxGgz/jEkeY+nBeHily6goppXrcgqaD2nJtCqG7a+aOJ3EdNo1sVrDqw2e6hZapy5UXujZtRIgW3l4bRgvfrELnb3XOulMqOpDvPH+MyNIdEz80PTa3siTcy4tLVe9rhQRiYh0+ESe
x-ms-exchange-antispam-messagedata: j3xR8WrPGokwW4t6jVfu7NvNflXQmfvg40CsinOFttdII5xcf5V++kE+6we3GycprYbh9YKzBZQxPjqYxYp963OvLONEWuq9YtSxFpWAJ3lZN/RDSJgnkj7uc9zJVMQqKLMsk1DMxJHROW7Q92DbYQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b412ee5d-38e4-497b-6311-08d7afc58401
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 14:11:55.3286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7r4bGgAJ7i5aEQ7Ka9rHoQQnN1YTep/3NdpRFVha++qLUJS1VrKLn7kfTlEpFJtqUUMzsaJwGXj1QxwVieyjkEWZFfYVABehgoeK++i9+Ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3584
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
