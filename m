Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B500615A2DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 09:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgBLIHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 03:07:25 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11962 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgBLIHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581494844; x=1613030844;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=aJF7yMDqy4K7U825v2/1Yeji5nCSvyU4qbV1O2iLnwAmqaLDSivkc+fU
   IBO2DWZOa/xQTKKdmNHw/jydlA0v+jcoJ7GksvE8EXfzmN+GUg+U3KwGz
   041NZO8i0Rw0KAoiG8l9vTipqZg6HQS2sSAfJ1cElcs43M/GFOXpNWmKU
   DJ8HE9NUz1SdDcllyctUUNMtjx6AxBZVNWfdQbd0rjdljmZh2McIBYRhG
   T7LRIKNKLcMMuFVMNBQKVXpzpns3AtQqAe0VXhsMd+SBVHl7S0yK1+NmE
   G6B5KXVeFKYUEk50rtLlVyfDUNSfk6yKxgreQXfOQthUzGmp8crvBB8mC
   Q==;
IronPort-SDR: 5m9fbyX6Mm14k77Dlfmnmam3IaRzcoVWTXT06quazNnmmN2qgYuMYqJyeP2KlM2vhmxLelOOEO
 YymhTDFUwjdEr7iAWRJ1jj9id2XjiadZVibxWzs72XPu0WDdx3O11eWpr5hq9l3llee1DHAozd
 ER7XP8380NAnUrRTFOPAPmc0+Vj7N4P9RkV/yj6N/jQEMjYX6WmARJE3JvIZr7GHdHF8rZTRu4
 MdSHdeDa6Cy+gVgKG8KS52pPD9NUYM/xjG4y+97NXsfaAx0TDnZXLPhNLtspOI7jOMAYbf5Mqi
 5VE=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="130189286"
Received: from mail-sn1nam02lp2051.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.51])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 16:07:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebSB3F08trEe8U6mtZu2LpRgV7rQ2Qistv9jKQHDSftSrGNU2+jvg/Gn7cG3ikNKDzfj3H5dBUab9+fTHM0PxaBc+4vGmMNdNTzPX6fG9jXt8u0BmZKl8UnyKbvk4tk5Rdv/3X81b+yVcoxzr2TjwV3rKwHUTlS3UD7aXukJpB2gQ2H7LYFX9koS/P+b/tO3OMIH+9LpHFatRZ067kJ8n5FSRfZ4qGPI3nvqwLJPU+CW+KVDzTw8kgHFPXH0U8KJSSPRhBYQEKsy12TzdWM+qGYY9G/jC3sBPIs5Pn2XLjf8KFrmMwHrxkvQvvP2GHvWg+jkCM4nU///TxqT3JDIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=PLs5+L11rSUsdd5OCBAmaSAo0RpzH0GXx20QyVao596RFbDbY840k5g5qq87rC+oVp3PAbZV4wfF/uBqdMiVVVsm4gqhYpSGZsP81WRPfjdMpsMNk8sxOyJ85WiXyr4hA5SHPvXnGXzJQU2i/LQ/hv0xb52TEAV6K/a8X2bL0NZ/SiznG9FeLqllG8ikd6y8YT+5UIyQVly+kmZuiX1vucNgtATLrp5E9Z1Zgfboo8veCJNt4MCyCYVFB2wM2aByl6pWVuy9iechdw004zokxFdXuYjzWyibPwCKfIkakDqur38BbUXimhNPRGGGR6Rlq/Xz/AMstFv5bRVEEMitmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=HN5Eqh6n5Pp8xgVNqBXQ2MOexGIrcKflgSv7Fvl+ptqg68APx3OMCd/i7yeyTtm+k6cU435VRuJTCB0Jf4A2quJ7sBum6aZ4teTFXtWRMN2DHKvxd+dq/4IySaiGoNBkx4MB1us9MJM3Lbfjsxaa55RXl+L3vWP7KEVz55k+50Q=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3679.namprd04.prod.outlook.com (10.167.133.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Wed, 12 Feb 2020 08:07:20 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 08:07:20 +0000
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
Subject: Re: [PATCH v2 09/21] btrfs: factor out create_chunk()
Thread-Topic: [PATCH v2 09/21] btrfs: factor out create_chunk()
Thread-Index: AQHV4XUG9ThApXCUAkyiH0ujcN3VPg==
Date:   Wed, 12 Feb 2020 08:07:20 +0000
Message-ID: <SN4PR0401MB359819CFAF7C7D9E0B32A31E9B1B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-10-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c67c7b2-7124-4033-c62f-08d7af9295c4
x-ms-traffictypediagnostic: SN4PR0401MB3679:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3679E1BA309845175ED0E77A9B1B0@SN4PR0401MB3679.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(189003)(199004)(558084003)(478600001)(8676002)(71200400001)(54906003)(52536014)(81156014)(9686003)(33656002)(8936002)(7696005)(55016002)(6506007)(4326008)(81166006)(26005)(66476007)(66556008)(66446008)(2906002)(66946007)(64756008)(86362001)(19618925003)(5660300002)(91956017)(110136005)(76116006)(186003)(316002)(4270600006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3679;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZVB1z9MAVg0PYzPau+4Hbwlob6gOadAnTB7F45XqCURL0ukI7w0xU/r1lbhWu8kBj42IXHr0RyGig/cLQm3A//ZfQcvm93xMw8AFLMiSe2HSH4BD8n5dJhWk8w+7SnGDjR5rftYQ6nzPuTWuBbROjPV4scHH4oGrS1KXuIoPtval4Ntajy8rT7lPnEINHwjGriMhWRrfLXKMNvZJWosBMiuNU8p1PRUYJUhNWKa/uaB6fWcDc9HB0QeXNCUZPB+L2A6KAtu4kq1guUyAFd8k5VIoWO+Va5Xs0jdnLm984BWXAdpaEzU4OVlUPE+kvh3ttIm2Md2REVZSe+S1/CD1+mmrKVFybvVCfWU0Xl7K3xW/QRpSVmSUqiCy5PBDWjQUDuDs3dG5ziwQE91soJSesgBdVazeu2DZITxK3cX4mBcGgd/mcUpluSjeiWsVf9rl
x-ms-exchange-antispam-messagedata: Z/yYMhqBhr5EAKZqOW7hdUHUBluBVIpBCgFivIb8SV+ZAvpubF9z6kcPP8qiYH1yIMlbbfDgCcxByOwCUOOBfUBg2iPqo+C2TwFWR8qIGTdZApa4f+jN1EbhqgztTXKmPjiZb6Eq7bvyCAB6JT1+ig==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c67c7b2-7124-4033-c62f-08d7af9295c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 08:07:20.7792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IKqHOP/fOMeoHyRfH9zAELXXMK8LmXncCI6Cnl3hyK+c5F4HGpIPgaBvmhXigawfZ/egi2NRo/5QtrVdqrS24B5w2/rG6itUblD0jrv4wBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3679
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
