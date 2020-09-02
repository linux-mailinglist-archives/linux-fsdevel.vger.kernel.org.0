Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C2225B017
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgIBPun (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:50:43 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26868 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgIBPuk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599061839; x=1630597839;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G7FnAaeCQVz1lg9agcRSwLtZU+QOM37C5Rky0CPIiCw=;
  b=jb2GWYTczXO12ZXVvRw9SwP6kObR0euLIe6SNFst0LxtdgSMD8/U7GP6
   jLRxS/UsOLvqIZAH3ApHqV9wCLGBH1v1/uGYCUsQCzti6IGdMwomQtRVE
   Hxw17/DlSn26dKz0Ixy2KOF/VuKQYH23anpCUFlGcZ3Ugs9I+gJ8Q2Lid
   ZLsnmtzyZ9U3uMPp9XnU3ETCEfx+9CDugc2VWRgvm1DOGlVKYgcZ041IU
   hDjDxTr2gSmLkmMq441DiurpkmDty5VkdKIyis9i14ghT2MmMVgLLss4y
   JpLtlUvli4QIgCFkxi1fQUleKPqiKTiRdDmGcleXnNBf91HsqmEYe8dt3
   Q==;
IronPort-SDR: RDpCMZWNgCGcqiIs+lByLNegwTptUgkDXw0Af+7ZAZ4SOIfoG0vGiZZWA43GmShRIEUUPjFF04
 +7CG3BzpRvYKwWSkIgp2qJTl0HHos5q9dhDqOrWjtA5P0xZWWSJTYoScvrRW8tF3fHZsQwxx7c
 DYzUwuj6TlktwmDj+M+7MVx2JpqWik6UwsoteHCQyGuBtjMRoHqdsYlre8r1QEkNbGbGIdX3dw
 5066XdtnGPipF6GnfzPcm7m/AijKRQUrd5hjhiOiUK+pJHS7oqRy2LZj+YeW/xut+hNhlOpT95
 gvY=
X-IronPort-AV: E=Sophos;i="5.76,383,1592841600"; 
   d="scan'208";a="255953793"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 23:50:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUd6ifeajH3CqvmnVzh8+osWdYHkIz/LfVkY6RmRYVeHIJycpE3myTPr7wYjKvXHHchhrmk9FulFSZNVySESPiZZlTqDMVbthiHFPcOovWbfb6WUtKTR/+3FnZtl3c+aTyuuSN9sbubQDFchZ82waoKFr1GeeAnSmsSDwPxm9re+P3BPQPnppoBxKW29/mdWWfkLvbRcIPMspwM6cIrDxm4dC5QUgCeW5GDeVB0vd2i5Q5p503+uR5XFbkEVKRdKpyKeKzVzvYx2SuWo8o3I/CRZoN1wmxhkewukbRUJfKMIPhRYPXIlfCuJychpCU3miVdM0NvuDQRCnRkZhPBSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxTCnHKAlsG57GwcVqyOhhRf04t1PU+FB0q8//OAfCo=;
 b=azp+HB/gUdE8/CLPo8/q026n9OKHotnfOUtSLoScgzn+DKykxNYwHYmTD2anHMxOKUFLEH0OUfi34AjPadI9Fmbjk89RZwOZ8zgS22J2qAc8v7AuLVyGSuRif0NjjuS9OCoAgX7tH24+CSNhJyKm9sNREuMZaACexXBFfSm90FzT9BKTDqsKvVC4n77EMfCYPEHjGC8NwAaquukAFhKSRFojN12QZAt29FU58SYStKYdeW7FX6jrKzlvYl4E6CsLzuP07/TzujFENVXLncdj7nj4wfA2gJdQDCq7fcpF3G3kanBTBcyccc/JQf054DHZZXFpklyVkzrbGDKgJfa61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxTCnHKAlsG57GwcVqyOhhRf04t1PU+FB0q8//OAfCo=;
 b=IjQVYtQGYIoc2eA3WOwSSRezAIrPUMHpk8a/4qqoq02vsy4E5w1bn0qNhQuceS4yQ/2APx51nvZAskv+SHjpPTDlJAHuYRs4EkZ+DrfmS0S1TvsbSZ9gj0xCo0LDN/5+0LpGEz1aZJM81DHaUcxZ7xBuww7Zm7hoKIYI77KgHa8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3680.namprd04.prod.outlook.com
 (2603:10b6:803:4e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Wed, 2 Sep
 2020 15:50:37 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 15:50:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Denis Efremov <efremov@linux.com>, Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 15/19] md: use bdev_check_media_change
Thread-Topic: [PATCH 15/19] md: use bdev_check_media_change
Thread-Index: AQHWgTOwoIis0HtRJ0e9zodZpaIyaw==
Date:   Wed, 2 Sep 2020 15:50:36 +0000
Message-ID: <SN4PR0401MB3598E01FAFE1FC30C39C4FB09B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200902141218.212614-1-hch@lst.de>
 <20200902141218.212614-16-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:1584:4722:fd5f:b30e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3a3d111-2cd7-4188-c6b2-08d84f57ef6d
x-ms-traffictypediagnostic: SN4PR0401MB3680:
x-microsoft-antispam-prvs: <SN4PR0401MB3680AF124717581FBACA406F9B2F0@SN4PR0401MB3680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TdZHxvT4DexMmdxMbxJRWKOjh0JpOaR8TUFlm84euYs4QInecvCeVYYx+jX0wwkaynCmJ93z69PRlK+cr7tqOWrC2ZdZ8/9HJ35qz0Az7IbSlE0Jr3B6g5rpPWFgojJwhrNJaxB0CsFQTWVPgGRXg5mVboVbjVfcTgKaUp5mA0M/VNh0i3IkDSFhS0GKpVG2dKjeOp2t7tuyEllwqa8SB57NpmOsHIUjg3U+TO5oQiOn5lh+2Ipx2N6wfHyBoDvM35k4njHzFhsvysE7Vizzy3t7p6lsEx5B9kWs7GlPuCBJiZKJV9ZhtLVLx5oZQIDZopNW8RtGN69t8qG7jIXF8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(366004)(346002)(376002)(136003)(71200400001)(83380400001)(7696005)(66446008)(7416002)(186003)(316002)(66556008)(54906003)(110136005)(66476007)(6506007)(66946007)(91956017)(52536014)(64756008)(76116006)(4326008)(53546011)(8676002)(9686003)(86362001)(33656002)(55016002)(558084003)(5660300002)(8936002)(478600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lZVkIJeOktV/6wR0UJVIDVwKBJzzxeSlztVXSUK6N3SA15E9vIIkf0WdGRNOGXWtr2QJASGCm5Uz67POhK/n0cZkK1zmsyCyYD7KpDKKjhE/x83X1gStlMptjUJlidYcMNy33nijHwnjebp0KehAHp4D7IANvJqovOyVO0mRib/3IFOlz5rbih6o0vUBNBbXAFQK5aJCcxPip09fyBeADBJfQb5mzg+CnZD0tUhZxQWRDIYn7EaMtXyyszhi2mlZAjXDuLCpQwVNb5FhdmczpaMQO2+bKRaWOJ1Y0uWR+bez2NKwAAJuU3HDixtOTosyJTN4KoF9CH9Cnm1cVnROYsQLv1CkJ3RvDE2TYhPZ0bmJqix+8a73aDX3lso+/3XKXG3Eml1zu+wQ6yxxNI37N2/nft3Glh6bWg1SUavOiCPkAztJkHH+f0p/3KCKA4yYeqQiUK7/b6tLzwkw4qSoZZUFTa017iO3nDwonBTz7/EaQleo1lH8kWxcA8Ij70xiCIqjxRwZI6yRptZ+6My+q0/OpWR+JmbpMR1Kt03x1dRsYQC/XCu7uiMQC+sf0jgOL5x6YdHv/a9aW0CWOn3It32QFTzFwbeh0N970u7pOKNEnkfyj2f0HhwDxqcq5CBv9+mLSuYn0GfAsxsV5BsFxQVtRUpnTT4Jw+iftZMBSgSI0D30LxSPY76TDrzrRAPbTMNwwANI5IIkY9XMY2u5qw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a3d111-2cd7-4188-c6b2-08d84f57ef6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:50:36.9273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: imVxx6Csmc6JHVsYEfdx8LFfjeX7p3hmRdX9azQ0D5UBKKNfYI9S+t6ktlwd2265AGYQ2STOTULYhVQo8Wyxb48Ph7/cUcABykAtHhGV4aQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3680
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02/09/2020 16:16, Christoph Hellwig wrote:=0A=
> The pcd driver does not have a ->revalidate_disk method, so it can just=
=0A=
   md ~^=0A=
=0A=
Otherwise looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
