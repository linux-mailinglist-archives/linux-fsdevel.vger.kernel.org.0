Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D882165A5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 10:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgBTJmY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 04:42:24 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:10305 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgBTJmX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 04:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582191743; x=1613727743;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=M+nyCipJmvciHSc+ZIPSuyMPQeAWQ1q0jyK4A6QbyLM=;
  b=MxA8YZ6n5WJZNnpXuaFRkbklr7qBXwrG9uYdCZTVfcsUe8u6y0eVeNu4
   Oz27YpSy3dSogiOOArdVrkuSYVtLopDlJbUGSXJ6vU4tVVrAiYYiRBPQo
   a/7zmFBuBnJXuIXfGRFWkxI24k5imt1xMSh2VHYdOpBNQaFmHvpiEBayT
   6WrUDFh9Dj0C1QZPoZtGjY5DVnqPOpQFHbr7YZ4No2Sf+CA+Cl6sWzqhO
   XxpqShJw+bJgOE4ecg/IYt4jJnM9QP/cYi93fVbd70EErLCbIENyUPKCJ
   hLe9t2SJlnN/yXfTGYVuevjv8jryhIOAnLvg+3WbHkqHMtPSLHAq/7nE1
   Q==;
IronPort-SDR: rf4RZS02dfBh5eg/Ser8Jycy8iQvg+TkSSxAtv5u02Qd6aGnPcTczKHkApuFeUjmaa5Q0D4v/G
 gX0lLZZLqzaJ2N11xxrUjesOhwiN8ouTd7EFeqblUXEPle5mjwlk7fG4A/QEIkZ73HcNmKtn/Z
 gnntC3MWr6gkE+g7ayEIr8rHGlToGcK/GSOVSyztHtVHW73tASiB/Y7qk9ILAfg4C8S9iOwFb6
 aLC/LSjsd8LXVHUAaV+FI9R6RzXyPa4+NTU6ldgPGl5OqVPAubABx9lnaLhotPdOwVx1PiEt6u
 1Z8=
X-IronPort-AV: E=Sophos;i="5.70,463,1574092800"; 
   d="scan'208";a="130254905"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2020 17:42:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgSc1LVfCQE13N/I9GVLU5//QU9A9SBcOAG/111XTiYLiA0gBNQ+rJUj7oZyiIjWT0dBwnVbwwibtKbyuVGkyg7KsFeoMgKLXpC2t5BKsBO9D4EXhbhtH2yFdBCgujFBrhKc/3GA8S+fvjsA1dXuKH1jRhsIHP2EdObhEKJd6C6Z1snOL2Y8xMxjFZJmCKB9Y0nQsiMOabrt1cJYDmfCIbh8aOhN24Ce1QgjIU4S/G4zYotpMyZOOq0qrWh3V5yrxg5jNFS+8PJwZjgjqppH8TpzDpYz9fO1Sm6COxTilJGYOQUu4LLcR/XA948TT+D5SCMee+Soi2dorkiqQvEyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChgseISPiUi/nxzwkkFQ1T9mWCaGRstOibBBGyDIMoA=;
 b=iRU3W/MSmFD7bMtT+yBF3gwh8btxRMCFDcDaids8hbwnbBlGeXPTJgvM/AsSPkoAo6VuZpzpoUoA8LCiBSkcWNWaZlTjnjNil0kHAz9O3zfv2mlk5YpcIVAZC8wXnBAAN0zhvSkv1i5iWxhlKNT48zmyRqWzWZxu3vS52mxuIx9DZaRrJHv7bXn/o/ZY2oxeoS4ScX/H01nD06AV0/6nWdD+55KipWWKuOGz6jyt9c0Keu1tsKJkawlyiiJGRe6SOYv70EGLwGiLGLLMO4lZKMgpQvypOKZF2jGKYDCFg1TiVEC52w1dtODhhTKfNyG/OOrDiWifJqf24hUPm9zAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChgseISPiUi/nxzwkkFQ1T9mWCaGRstOibBBGyDIMoA=;
 b=LmPep1/SEnW8o3O23FL4cRjLFHAH3r4N0C/0nJT1EUMsvJ4UnUMx5yvajyJ096aOPjpPb99qoiaNKEpMJLyPr4f+JkSGPO/u9P3mMYTsunSVzBtnP6efqUGGAKGgoojhiwxqq5nMWjMUX+4fIZ7i5ndfD3HHtGD4JykF0OAmBeQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3712.namprd04.prod.outlook.com (10.167.140.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.34; Thu, 20 Feb 2020 09:42:19 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2729.032; Thu, 20 Feb 2020
 09:42:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Matthew Wilcox <willy@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v7 14/24] btrfs: Convert from readpages to readahead
Thread-Topic: [PATCH v7 14/24] btrfs: Convert from readpages to readahead
Thread-Index: AQHV52gHXOnz3eutsEej0YiVm6PhQQ==
Date:   Thu, 20 Feb 2020 09:42:19 +0000
Message-ID: <SN4PR0401MB35987D7B76007B93B1C5CE5E9B130@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-15-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f9f36ad-9c2b-4615-8f76-08d7b5e92dbc
x-ms-traffictypediagnostic: SN4PR0401MB3712:
x-microsoft-antispam-prvs: <SN4PR0401MB371296C64FC8338D311C5EC19B130@SN4PR0401MB3712.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(189003)(199004)(110136005)(316002)(54906003)(7696005)(71200400001)(81166006)(86362001)(81156014)(9686003)(8936002)(8676002)(55016002)(7416002)(478600001)(6506007)(5660300002)(91956017)(76116006)(52536014)(66556008)(64756008)(66446008)(66946007)(26005)(66476007)(2906002)(186003)(4744005)(53546011)(33656002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3712;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jUs4EXsOJ1h6Mc+meDzlGUyOWASlmGwVcRYbusjWjnYc2N384jN2exjY0BSvFVN0FbrY2HTenQi6UygtEostQlmrd0SQAAIc+uInuE+BWUKNacWm/BEB+H6kMR8IRlR0YJLAKFjSPP0MBUtybF9JS9TKOrSEona/RB9DL3WntLiiqekNqk6BLRFRpG5vk7nKbUDtj9umYVstira3cCP8LCyzU0Huu8qbMYhjogdOcam/WXhBUNpm8gZsCkTtd1+vBlY5iNQ9lJTde0UYlnkuzIch3fxsi/cwtdUY+xKnDy3qiyoUrTq29Pt4gY70yPdOKHv5H1aYjOe/ZaXIqLRGQ/ZdEV1eDkLOgN2VdthJ8MZEMkOt8uPyS0M7mG9uJC0+wHaffPZcYnLWM8FDhnYOwBP7RLfmNgPAtoxsxLIiKlfCzyOjJUevNmnvJudHquy8
x-ms-exchange-antispam-messagedata: vbv93IQYZbgJP1Z/hVNS1KpHjde+X2GbFSSagnVuEXilWwOZBJ/D3AfJnfwu/zHRERd0cukJswJ4JEgDtj3c7EzoUWFBzGEdzjVjFLKlPOOWx0C4WiG6CDu/hfH6ZouoA7OKc2KGtXg8hiDrQHZ73w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9f36ad-9c2b-4615-8f76-08d7b5e92dbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 09:42:19.3955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j4ODXpF6prvGYEa2v+nxNMmTpJxN8bgfI7Uj2C391EZvB7+MVwN/HINz4ExXRz1C9miRXVR5mYpe3HK7nZvA0+DRHnOHhAuot8u9Iw21FCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3712
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19/02/2020 22:03, Matthew Wilcox wrote:=0A=
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>=0A=
> =0A=
> Use the new readahead operation in btrfs.  Add a=0A=
> readahead_for_each_batch() iterator to optimise the loop in the XArray.=
=0A=
=0A=
=0A=
OK I must admit I haven't followed this series closely, but what =0A=
happened to said readahead_for_each_batch()?=0A=
=0A=
As far as I can see it's now:=0A=
=0A=
[...]=0A=
> +	while ((nr =3D readahead_page_batch(rac, pagepool))) {=0A=
=0A=
=0A=
