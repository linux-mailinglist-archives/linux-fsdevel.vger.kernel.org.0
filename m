Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE372291EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 09:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbgGVHRs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 03:17:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59788 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730351AbgGVHRs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595402267; x=1626938267;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=CU4Mh6G0qUMYXHrfuwNltXjKo7cJNsxwkf+iqpzg+5PPeO6A8PySc4xX
   WizRF2JFyk864Xe+AEpuTntvHluJB1Tpx/1m3MLyFlXQ5eia5ePzHuNN2
   Gwb1rrVZ5p0xxZifvyL6slJC5h/t32kGvbvUXPhiwkYpXAmx4lrhi1JtF
   3t1jg/yGvwXMgjwg+oD+L8eNVPVOPpdYXXg9FPE5PihPUUTfvhHfAH+2m
   XnTqpx9/XcjjiHV7QytNYJB4HgMkAOG+HhpX049E9m9CHduKnyINKgt0a
   K7biFOejHZs7Piia9VGHSl/Mw3KIF90DrUrkf0W9OKkv5uLd9NHVNmj7/
   Q==;
IronPort-SDR: r+spQdpHZjlIxDZ8U9Wf1dctLRhOvtaQYyVYB3HezoU03BzC/ipDr+uBwnr4X4C5wW5Fl5MJK6
 mzUiMuyiN0CCUqpJskCKQJQ9B/jlvtbAgz0lSAs2eoWGKhpE25Sajq5Vi3GQCmK/da1JzL+lYU
 4K3voJmLxIQs7I2589FdTrLT7FHML+b2irPolSkL5qSEFadfTR50HFL1J0T0qEUx4xTHUUzGTl
 hEcPxqsCGMx/2/HiVxO/ZtzlPX72VL7cNbPewIxvPXc6KDPpQB7F2jVUWKAFSIPYAKUURcnl2W
 4kg=
X-IronPort-AV: E=Sophos;i="5.75,381,1589212800"; 
   d="scan'208";a="143088885"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2020 15:17:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPXZgwJSctWnTX3MsNJLub/kkMqJoCCX0C9qNy3UwBDK0ay2Yo6/Li81IjTwwE9U3uHOogrsDZq5jBrHl+Ifvfbjj2lt4eHxel+3ZRz+daN6PL12oq/oR6fXlInGUtVIYOwG87JnF+1qzaffssSiCllcb4NkEGnmabRWguKXOsclZP+/UmtwZTFQJfvba2AJu9sZAaKO/gcI98RZQQr5YoZR6OHmKUHGDJAGp1P38pSQYRVJ03nsoCii84XC0XSdppHLtLpaWl2W81mauhdzXKahf1haj/IRLI1o7LdL+57um6CeBw2I3/aT24nQqhewb2C1s4wC0fNI69+yB/3SsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=OmahPdOcr0lrZ2qouXluexD5u2on/nmIPXJcMAX+12Bm5bugvxZhFHA1V5rN3BmpC4RdPHuvetOiwKXr26hnjvXUE2g1gZFU2sq4zR0evGl46ljeR17CFF/2V/m+0RvgIlrS4yPrxxBTSitPYndlk1w0DG0NMwz9onUFfCHPJE3rElWTCDkzCgGo0bZi7hkqqEMVvOq8p//R+gr8Lnw7Gv66SsoB6kxIqpS9PlU8MyogKTTSHlk9RczZFJastUKdNez3dLBNRhC8/N6th/912aWd+Dm3JoGecGpXO5TNqzSZlXTDxbRwj4Mua3j/HBtMQw2AkqFDIlhBBpLFOYpe/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=K5/9gm/AkZ9wwFW9t5Ed7sD7PdXzwP1H7ZzL2I4V/HOo3cgqQ/SxzN/U/n4FfHAh6LmzQudUR2e84h0IKd4GV8roPape/8a1Zj2HABfmXQYaw5uC2GRuTrLSNXKWnAtyIpYPl4BiB69Pc12rqbC/Hb3aGUeSf+BXjyFBqH+fa6Y=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5328.namprd04.prod.outlook.com
 (2603:10b6:805:fe::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Wed, 22 Jul
 2020 07:17:44 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 07:17:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH 07/14] block: make QUEUE_SYSFS_BIT_FNS a little more
 useful
Thread-Topic: [PATCH 07/14] block: make QUEUE_SYSFS_BIT_FNS a little more
 useful
Thread-Index: AQHWX/E5KfXs6UEsXEikiHovTsngZQ==
Date:   Wed, 22 Jul 2020 07:17:44 +0000
Message-ID: <SN4PR0401MB35982D3B04730EA1CA45A25B9B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200722062552.212200-1-hch@lst.de>
 <20200722062552.212200-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6c28330-b300-4d97-74a0-08d82e0f5414
x-ms-traffictypediagnostic: SN6PR04MB5328:
x-microsoft-antispam-prvs: <SN6PR04MB5328ED88F250165B44F8D2609B790@SN6PR04MB5328.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9qPfrj9Ni7hTp+Xvz6jHeqAVstr4S40cO2EXB7BE2nKetV+lLKGv8745CfFdYq12liiKSHnrqLP5tAD/w2inw631y7NKffxYB3/mAXBXxNg9gEv3YI/tTUx/2yqjJun7AcDyPc4kVpqDXc+dtK030/bIUcAm3J1iK1u8BDk98IfQmLcXRnmnl8WNoBGPmQaJMddPdfui1tCn/3TeQr0tEZQ/gYb6yWZw42y4YJQCv+9jJOb5lgr60rz0Q569T7I3X8PDI0I2O3Z63suo4P5bcjfAYr+Mpngnzqi4e8xJ+FjUD3UoGE+VixC4EFpfRtiDZf6USdOjLqviq3vKPswACA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(186003)(9686003)(26005)(55016002)(558084003)(4326008)(5660300002)(110136005)(71200400001)(8936002)(54906003)(316002)(8676002)(52536014)(86362001)(91956017)(66946007)(76116006)(66476007)(66556008)(66446008)(7416002)(478600001)(64756008)(4270600006)(7696005)(6506007)(33656002)(2906002)(19618925003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2kOFksMtZKUvYhnCchFFm30PVPcj2uqyfSZhKn60dABqCekxHeKicU2p6P16QnHgMr+jHXHs8owLUr0WSdUNjIh878AkWqSPLM4AcDAGcRi6kF+QHVCazgMB2zaLPtIzQ2Kh+VBRCbxp6T+75n6uC/BR1rJOFCT4lsnxqcLtk+LOd0c9uBa5ICNAY/eTsE1/X2Dua5wdoe1C57oJX/1MlpBvlOzGw3MvOQ7qD3bGLzwK1qG2kkuLqRJ6EoveSOtXdJagbdXznWreCo+N/cbe6Z840kgkoBpv4+ckO6korTvmsk501YT0uui1bANy5L27yCxXwwF3SuDleHMyJsza1Rxt2ZywiYf4e5ehFfY6XSj7imSX2zchzHib9r9PurrnvO1HzgKOpYQPCn7Bq4NXgVpinoS1Aj7deDBQ8aPAspBjkR2knBxu96Fr5nic6IarfuAdVAo5TPWbF0nCAfGycAXYdx3O586nJSxQ7WQNVMwgr/9gP1+bqdQ6NPS2Oy/n
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c28330-b300-4d97-74a0-08d82e0f5414
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 07:17:44.1539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ol82KIFb84O8gb2aJmplUrduhFSHelta6MaiYYu1kKK2v7q+eZH3USlAd5OmbFUeBVhTYPCwa+QbF6btvyuHRiZjppxJcbMExG+nIN4nJ9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5328
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
