Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F91115A27F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgBLH6y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:58:54 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11285 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgBLH6x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581494333; x=1613030333;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=DrSYtqHkgjsUhhejKhCCECWheBpyFiBpk8XiZjI5ZGLT+CRb5eW74W2B
   pjBQJi9AefLRdvLnZHJ74+zpyZQygcDeGBxuQ/29z2NwydkTPKfewLyUE
   spJ+I4lOif7pf1etCxaHEMLizCuKiTA5mvbGFD2nGnBgajPGmLMcHkhWf
   aXdUD3U3tGUur8zsb/IvSn+XTNPFW6NvrU1sH2f6malx8Uqr9pjy0ppJs
   JE4uLr9ODV0YoZr8+XM/dNaKEn3TuMKMJKJ2YsZBGcJfdcHGDoxGKE0iA
   gT1pKxZ2FXsTqaMTCCIwUWD2cxj/xG76WB4NUCKcHmGYY4xG+enKkeN3E
   Q==;
IronPort-SDR: OjGOMl04pAhMH2k1JBpa+XYdU9OGTLkKG4Be281IDCSAo0KNjDSVJDSrfdCcVQHz5qmrlwaKCM
 2m8U7+sbpcvljqatPFcKmRw+xzikobxBK4+VguQ4BM3RnilsRUcB6B0bXgsexqIIT5fR7tRoWE
 YL/qslsYNz+niTMYFIsMQ+Ys6Nfq8trKUYnLY0UFWyzyjnronADJj43hcL10uBETqo0zf2blQ6
 5VGmaUOp7dXXdbO0VUUZ7O54d1KMGIN9f0Z8ZSZKcv+qW206toqIi4EbD9BtdBE0QcrxZm4wRG
 iuI=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="130188692"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:58:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8XsF72v4Mhyd7Lqhyvq7nyH41waG5+JklikSDLVH3spFHzTvlV1Hb69MSOmKMTbJymmnRMW0oLAzFYQkh/u4YDP2CCqFDjuVvGA35Ht2gWGitIisgSy07arU8tViTUBYDQ8VtqKJh6HV/dPeBPog8HGVSHp/u5xNIpfbNWw3nBYoFU9nZmf3I9Tde5Stz9NdiHw8JH2RYCeLBCUeb0VCHYyef9/xm52fMfcUUhTT+wZDU4MnWchqt0vtN22VN8S+2QjZ+mhdVUORaIk9wamewgBhrujIwIVpDOzrAJig2IxWEsGsMluAQ0Fok2ar3SUZ66TPKL8JPtWM0rR+ABS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=aqLzMxeqsEWZ4i2Uglqsn+/Ac7sKCoOiF7Z9vqiecjBOHd7rzXAANrm6BRd+FlyOfcVFgbUcZkFPv1kkW4NKaxapSsJQCXJeE5KrcNwfyyGHeV9p1/tTXoe8bgeE4zUJPtCzFTD6v9NILp8yOGIccpArCdZ5SoTMAsKZt9YckXBDbafOQlvRbo7HFG3FVucQA0jnmxZq48i71glT/zHHu02WFOw3k1dcbRrU8fXKt68kIc5NFn/HidyJJgxo1AQs/e6o/bALoTSzge4JY4OoEdCYPoNrtvfYKi+7d2M+k//jBOKv8Q9dAk4uu9RKl7JRxxRKzxr8o8ykGjbPK1Ip8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=A75/giuspgeIONrK6wi8DhsItkliNXBrXO3X/iu9IRP/zBIVtVU3gk+wS1afsHSwkn7al7wVFP+L1OK/W9LNuoWEz/5kMuHb1lIMQCLYBs6XK8vrUe8XqMLrFkQ0t+PRNcuz3qII0z8HBt2ZVP5P1zrSTbQEb0XdXa/BD2nKVw8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3518.namprd04.prod.outlook.com (10.167.150.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Wed, 12 Feb 2020 07:58:50 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 07:58:50 +0000
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
Subject: Re: [PATCH v2 02/21] btrfs: do not BUG_ON with invalid profile
Thread-Topic: [PATCH v2 02/21] btrfs: do not BUG_ON with invalid profile
Thread-Index: AQHV4XT9U4PcUT8G/kWYFdQx+Bg4vg==
Date:   Wed, 12 Feb 2020 07:58:50 +0000
Message-ID: <SN4PR0401MB35984B490DE9FF178CF91D539B1B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-3-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2354758f-238f-4613-cb1f-08d7af91657b
x-ms-traffictypediagnostic: SN4PR0401MB3518:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3518BC92448D8EC02E9645009B1B0@SN4PR0401MB3518.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(199004)(189003)(19618925003)(76116006)(558084003)(478600001)(2906002)(86362001)(66476007)(66556008)(4270600006)(8936002)(64756008)(66946007)(91956017)(33656002)(81156014)(110136005)(8676002)(316002)(52536014)(71200400001)(5660300002)(7696005)(186003)(54906003)(81166006)(6506007)(26005)(66446008)(55016002)(4326008)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3518;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E02OEP8GDw1SuaPQFOrIlN4sP5JDBSs29ffshYkifNNXEwkDqiqVzOe8YDruD/VpJmkgesIeKDkvuvquK6T0M5PVBvE46oRHNuD5hztrpK3QAJCgm8Bo5wX/eX7I8sxjtzmaQCNvDDtpeSIa0CM1e8c6BPpxhw09o3J/2OXwlpIStwew0veVQm26wcJ7a6+UWcwntzfmnGDGrHQYkChMK9nI1aI0v1ZLWFI0jWemnxINtTjxFLof1ZpNzEuD4w9ecXmyoUbTsCVdWO7pezvNW7HDtR7ZlTf5p+7HUHx2CRrfnsCt79FiD5YKEXg/iovxtQe5D+pouy72k84JnDMSIhuA4uwnUfYmEuAjzLu6YOITVU6y5lTqG7k12+aWokVmJPN62v991Gj3j4jClfimRk0TyXokpF/IuPO1xKqkuBJrn+JcUJs9RU2zyAMklLXB
x-ms-exchange-antispam-messagedata: v8PyyeqifVtVNevhVupuGNHgHvmK1omdG93fTiAp2m3cBg5XsNJSkEiZuNGpIrr5x2rjIn9faKXf6bgrd27kFiIzO20nc/l3WeqZZqyOgH6+fheVjHUavhdXaXUZ5espVPxpqlRYtTNugOYw/RFIEg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2354758f-238f-4613-cb1f-08d7af91657b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 07:58:50.3045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NAi3dGGkH6muPfyVEjU9WZOfTtgiUe7DT1LKEh+bOspp5TcLWNL/PDi1/dhCiDAVly34Oy7px+zW3h8Pmd/fRqv3tMwSVcOtg+p+4ENme7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3518
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
