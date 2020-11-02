Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDEB2A30A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 17:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgKBQ6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 11:58:25 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20619 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbgKBQ6Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604336304; x=1635872304;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2qxp5xJLdFaoTsWyDmrlnfjwAYaO3qU4hKT1Ah1l6FI=;
  b=L2xknSAwrUkFPpXWZ35ZXbL+SrZ6d6nEzDJA9WumSb1KvOuryBSWgACe
   CFyUEM4UD6gGWsQUM+p7jOjiozDWLQ4l0oqOctuQhZC3dVRffUw3N/u0B
   sGQme3Fo/tJNdk53igOhNOSwv+5P/pkyWGEU0L6ohe3uHG7Y78iAPP9FV
   NX0q68VmgPGlO8mR3/mFbqbuz6Bzrq9y3/7zxPPVmhYWuA59Th2iHYK6D
   XQHJfSjhH2z6qMk34nV+55MK4LG8iUVGzHM/MHZvCjkfrnFoeE0fFU3ZR
   r8iYZMn2ODWTqt9s4T1zytXatNQBN7ATHe3Tsd2y031vRLwdS7DVX7p+1
   w==;
IronPort-SDR: cdVkd3+a99UtDdLF4xCUjzx/G38vtl136grF/yjmn9RVPcXYFgsOSBQs9f49ZZfmWjWt1fcpTc
 hUZ9OSNN1wWd/fBnHaf01lxkpQcXHjOo1owleA1qvI/CCOWjsvWmfjN3Nr1Oi965EDvv4ZOk99
 xe9+VplD3iFFLs3c7k7gVAZanIE1lQxXrJ1DKL8d1jnxwpHCig0v0/bxaxQ70sxQ1Gy+uJ9LCT
 df/6bqoE5DTGQHrSBePvNUXxtA20Pnlh9A89hx6ZFgSu+j6uayVNwsSSt8bY88O0toG/uncdrN
 ziA=
X-IronPort-AV: E=Sophos;i="5.77,445,1596470400"; 
   d="scan'208";a="151465692"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 00:58:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwCJuEbqOx2T/wnfXz/q3mZOPIvx4v1EDPUV0qD1SurqhvT1K8eoTz83UDw7dSqnQLHYPqNYitSKVE23CDckBWg9IidJRAXedIJjBZ9/jvIT2u2P/4h1ZwpfzCZnVOENR+Hd4WWT5E+51Jfk/MRPj9++L4fKL6vl9H9p2XGf2DSG6btQnGbSp6pfVnGfcvNInRxKxOUoxEvqXmZDpjw3XGpoFha96ynQJ1j4EIhkNe2pci0Nmhn9EQA9bx1REKc+XJUioHflbrfXdcVrCtga8MxsszsQYx7XrUBrWV8fXko2fxI9/ESW5gtXimlQrzMI0e5+ZIy1Bx3OeniALymyfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qxp5xJLdFaoTsWyDmrlnfjwAYaO3qU4hKT1Ah1l6FI=;
 b=Xll/gC4R6bDJCAdlmvZ/KqJD7cEb/9Bu12XfsXeIBn9OWBxQsdQoiPEuphON9eCv+wrKjgMbNognZidIw9k6e1AoeWhb91hKaMSpxR4Yy+gNvZozdu0hLcmGpcI1XREBGvPoD4R0hZgylov451BbLgiuDwP7Rl5IsoUoowWPi91k4wEnLblYYdzUlEjhuG9FTP/BOOXE8cAr9SsaRo9lXtle+ls+ujXSQ7FowjtVqhsb31jcSjsPk9M7vN9MXSlXU6UTX7lv46hexEkbIYWXnmBNRVwxOPcMyANege+/ReXaCAVKCIk7tHvdoEiNRCTbC1S5u1pi99UGBIMlX/qjlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qxp5xJLdFaoTsWyDmrlnfjwAYaO3qU4hKT1Ah1l6FI=;
 b=Aq0KRLcFzbHl9D7BSj3GxExspfrW/+ypXbNpHd/5ie4rkOWXqkp2FU1TGrtvrPa91QFEPtPnbq+EIM3qDbIE38HfnSdjCVCegBtwAlw4dDDAMaKhkqSVpR8ce+fDn/tIqJaEz7mOzwxPsOCl7J9azSNM9ps/hwH0664sLo5p00k=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3680.namprd04.prod.outlook.com
 (2603:10b6:803:4e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Mon, 2 Nov
 2020 16:58:22 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 16:58:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v9 04/41] btrfs: Get zone information of zoned block
 devices
Thread-Topic: [PATCH v9 04/41] btrfs: Get zone information of zoned block
 devices
Thread-Index: AQHWrsPtHpT2iv2lSEWTF1mkCt9n3Q==
Date:   Mon, 2 Nov 2020 16:58:22 +0000
Message-ID: <SN4PR0401MB3598C631614C56BF25DEE2E29B100@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <feca5ea7b6dc1a62eddbc00e01452b92523c8f36.1604065694.git.naohiro.aota@wdc.com>
 <69081702-5b34-1362-6e76-6769083a912c@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 57b916b9-fca9-48b0-5eef-08d87f50819d
x-ms-traffictypediagnostic: SN4PR0401MB3680:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3680981BB19A6D549122AE8D9B100@SN4PR0401MB3680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u12u8IozYQUSsl9ZQQYvuKZoLT3LWK6PXJUz2kXyjt0eRB4k+RUIuxNH4lIcyNfrswrqm/sB5h/3W4MUWJpnmhbtP6rO15YM8ELLyJB6QmypnT+fjISUPpvH01ZgNgziI0OI0tWP14N4R9WLO231Krg6v4cmxwSU2WlQup5vxOqyczlKK61B14plJf34u4eSgvg3Wvo4IBGqDv7F1389nhO092R+IgMzuN067sf+xNKie3YIS+qgxo4upgj1ZPIgxaLVLxuIeeg8Oe0aMAW1Ftfu4NXaW6Lq6lBDxaMuuyo2O1dHPNH1uGMaZ58QpTLTJDFRo1jqMi9SRlcLHiWh+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(86362001)(5660300002)(8936002)(71200400001)(186003)(2906002)(8676002)(26005)(54906003)(4326008)(478600001)(558084003)(7696005)(52536014)(316002)(66446008)(64756008)(66556008)(53546011)(76116006)(91956017)(55016002)(66946007)(66476007)(33656002)(110136005)(9686003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MUQLXWd5/9P2S4++SKTfcyeR6/fAmoFHtrENLw1fQMjc8BtaR+qt4dPoQ1CXrYSBwhSk5aK2qmprjPO/Wicp55K6HJwhfA2Q+TqnJeANMOms8Iwk7yJrVlzqMgF6esdu7SJTLS2g2/iNa8debbXj3Zfvbyn8FGdu+3vWhKA5gCLQvJbLH2n9FFMOPvqGjaogs5r8SsT7OknhFoTLfWBWCOdISmmI0HCk+m9syr5Sd5nr1JxybO48bGpHBFbWWGwaRstd+AkfDfw1ssKbMGNQSoMVVVtPYHme4gFcjZjWqBa1PqGLIz+41fT8klvd/qHT4HdeGU64yD1jXm1EMbskMRHGuSAiH7os1K6NC3ZWAPL4lFs5uP1VDy5Sk/WrTFiJHAB8oMmntPBmTRdeCPBsxdCVyeyQoxpdfO7Rnz3E5c/Zzn4Umxt5nuAylsJbjC3voq6IIh7xV71qx6JjnHdOtxnflMQJzTimmwlRdlWZZg3nXZat2owbF7q6TTN1Y9cQfIIHtJq+ieY0Ifnw1DT3O2Js7MEXtHB0QdxKTSuw6AXq4tB3Z6td3x4KMIMNY/6GbqEeZwy6LpeVytPQ85HWfJY3bKhl+fAbtc2zfoO7STyW/nnva+6ndM1EeiM0eASY1cVV1ugTfVwa62Ur5Dmesw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b916b9-fca9-48b0-5eef-08d87f50819d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 16:58:22.0682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FueZ4pwB7dcAgGImHWxlGFn6axD4vcoBlqgkNfKecS+0z91pQuTuFvVqd53SEtDXbhHH1zLksq5ONvF6Fi8w2dWyEpQVsfRjcwaEXeIHLjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3680
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02/11/2020 17:53, Josef Bacik wrote:=0A=
> Why isn't this btrfs_info() ?=0A=
=0A=
Plain oversight...=0A=
