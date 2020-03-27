Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 877B019508A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 06:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgC0F0p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 01:26:45 -0400
Received: from act-mtaout4.csiro.au ([150.229.7.41]:6650 "EHLO
        act-MTAout4.csiro.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgC0F0p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 01:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=csiro.au; i=@csiro.au; q=dns/txt; s=dkim;
  t=1585286802; x=1616822802;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5d0dJ8lX1ad1+Up0aN0MABU6OV+EtqHost7YjWaZLms=;
  b=Y2WPycZ7EGll6sRmc27q+vRbPRz7sb/LLjfjW69Ts2/Vd0yZVn/c3eka
   YKvSXQH0Q/8j3blcPSqSS4ne+gI0Bf18h9xGp9oHGW+rwm56eouXMkc+k
   kK/x1GnNBhv+4J27ODa4qfTc5AmHF52eDBJt/NSEHQYoJMXnTt9J88p8k
   U=;
IronPort-SDR: RZZ9Oh6bWiC+HV2jun3914xOlZwWzA40kY239ssBxRHJ14nIGYE24RxVIHFEXFpeCCrzDryjbZ
 +htvwlI7Uh4A==
X-SBRS: 4.0
IronPort-PHdr: =?us-ascii?q?9a23=3A6g/M8ResBAmQ+/GzX0BR6YqzlGMj4e+mNxMJ6p?=
 =?us-ascii?q?chl7NFe7ii+JKnJkHE+PFxlwGZD57D5adCjOzb++D7VGoM7IzJkUhKcYcEFn?=
 =?us-ascii?q?pnwd4TgxRmBceEDUPhK/u/US08F8lESBlA9HC9LVlPFe71fFzIpTu78G1aFw?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A+FaAgBgjH1ejACwBSSwhIATAJKcgDR?=
 =?us-ascii?q?gBoJBgVRQXoELBDUKh1UDimaCX5QkhSkUgRADVAoBAQENAS0CBAEBAoRCAoI?=
 =?us-ascii?q?wJDQJDgIDAQELAQEGAQEBAQEFBAICEAEBASaGBgyDU34BAQEBAQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAoEMPgEBAQMSFRMGAQE3AQ8CAQg?=
 =?us-ascii?q?OCgkVEA8jJQIEDgUigwSCTAMtAQECAqITAoE5iGEBAYFzM4J/AQEFhS8Yggw?=
 =?us-ascii?q?JCQGBLowvgVw+hCU+hDQKEIVwjXWLVpcSBwMegh6XAAwdm2MtpmKDfgIEAgQ?=
 =?us-ascii?q?FAg4BAQWBUjiBWmyDQFAYDY43g1mKVXSBKYxNATBfAQE?=
X-IPAS-Result: =?us-ascii?q?A+FaAgBgjH1ejACwBSSwhIATAJKcgDRgBoJBgVRQXoELB?=
 =?us-ascii?q?DUKh1UDimaCX5QkhSkUgRADVAoBAQENAS0CBAEBAoRCAoIwJDQJDgIDAQELA?=
 =?us-ascii?q?QEGAQEBAQEFBAICEAEBASaGBgyDU34BAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEFAoEMPgEBAQMSFRMGAQE3AQ8CAQgOCgkVEA8jJQIED?=
 =?us-ascii?q?gUigwSCTAMtAQECAqITAoE5iGEBAYFzM4J/AQEFhS8YggwJCQGBLowvgVw+h?=
 =?us-ascii?q?CU+hDQKEIVwjXWLVpcSBwMegh6XAAwdm2MtpmKDfgIEAgQFAg4BAQWBUjiBW?=
 =?us-ascii?q?myDQFAYDY43g1mKVXSBKYxNATBfAQE?=
Received: from exch4-cdc.nexus.csiro.au ([IPv6:2405:b000:601:13::247:34])
  by act-ironport-int.csiro.au with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 27 Mar 2020 16:19:31 +1100
Received: from exch2-cdc.nexus.csiro.au (2405:b000:601:13::247:32) by
 exch4-cdc.nexus.csiro.au (2405:b000:601:13::247:34) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 27 Mar 2020 16:19:31 +1100
Received: from ExEdge1.csiro.au (150.229.7.34) by exch2-cdc.nexus.csiro.au
 (152.83.247.32) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Mar 2020 16:19:31 +1100
Received: from AUS01-ME1-obe.outbound.protection.outlook.com (104.47.116.54)
 by ExEdge1.csiro.au (150.229.7.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 27 Mar 2020 16:19:23 +1100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbqHhzK9Y7IMgb+aHvOsgSiFP0Ws8vZjJ/3BXf55GpSpeO5pRnTbXPz68zuQnY4L59SiM9q9xDgthq1mJVOT7170xUQsV/BWvgALX4d9XZFJk6Yo86VR2JEjg4XvnYoPLC8iwju6/pWiC1baUj92zzqrSkZ48y+jKNALGYWOiVrogRcvxKFK3Pi2b83IM9VC3K4bJUMXcrU9DXzOLP2vfPHSiCIAS1PdySEoDXn/Al81j5k2y6/HxgaiHg+2Jy8gsN3bScHgipC/G3Mg15X5oxCj4k+6SR83CFMc7uiOghUDKsu4rdSGX0IaVG0IvLCjq8tvVJ7KUmBHOHA9fpxyfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6UV0GnIfqpdyF7zX2wNlixfb5YVqA2sYgZR8riKpgQ=;
 b=YqSc9l1iH2hByWMapG2VdoN0V0dxYQr3PD8psZO/DFeLSOF3Vj2Rp9VlV1zJXfWTUfBWU3Cy/8gimJBXLYvdVyBvwIxMrmhpu1ZnvpZDdBR+7iYTFP2b+ly114rYA3u2VqLG3fOPPMz1Ccc06MkbxIpJ0e28GBVN5TZD3pXdCQOneO1T7OxyGNJMoSZUk096BiR9TXErKLQM1uCPOprtj6H3/K7sY+GmkwMYSs/dNDOGLDwGe+Wvi/kNVP88JoSoMZYm7KAmYnbNY/Zb9iQZF5yGS/GUYGOGhR8AOQ1r0ocauGQBtBLXkr3GiD2S4xeOmlAG8c6FQAOrHCHMpPgcDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csiro.au; dmarc=pass action=none header.from=csiro.au;
 dkim=pass header.d=csiro.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CSIROAU.onmicrosoft.com; s=selector1-CSIROAU-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6UV0GnIfqpdyF7zX2wNlixfb5YVqA2sYgZR8riKpgQ=;
 b=Hft0EdPfMfPD6utQzj+KSsUgYareDIt5PY74sYzci/w/hyG0aSxVfjxHbnBrq/THDKXiHK2a2mZ8xrI9HC8aR469+96n3/gyp85xaRWRlxvjY4J7lZOqV5FbYMv1eDNnt4RH9zp06WqDvcM/Qly6OwTVS9VKCVEcGl4EVdE6QVg=
Received: from MEAPR01MB4517.ausprd01.prod.outlook.com (20.178.177.210) by
 MEAPR01MB5158.ausprd01.prod.outlook.com (10.255.149.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Fri, 27 Mar 2020 05:19:30 +0000
Received: from MEAPR01MB4517.ausprd01.prod.outlook.com
 ([fe80::c0cb:c6dc:af29:fd72]) by MEAPR01MB4517.ausprd01.prod.outlook.com
 ([fe80::c0cb:c6dc:af29:fd72%5]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 05:19:30 +0000
From:   "McIntyre, Vincent (CASS, Marsfield)" <Vincent.Mcintyre@csiro.au>
To:     Ian Kent <raven@themaw.net>
CC:     Al Viro <viro@ZenIV.linux.org.uk>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] autofs: add comment about autofs_mountpoint_changed()
Thread-Topic: [PATCH 4/4] autofs: add comment about
 autofs_mountpoint_changed()
Thread-Index: AQHWAzAfwr4unU8mYkSVvBsMs0rAdqhb6DSA
Date:   Fri, 27 Mar 2020 05:19:29 +0000
Message-ID: <20200327051928.i5xtvskvktbugifa@mayhem.atnf.CSIRO.AU>
References: <158520019862.5325.7856909810909592388.stgit@mickey.themaw.net>
 <158520021604.5325.4342529050022426912.stgit@mickey.themaw.net>
In-Reply-To: <158520021604.5325.4342529050022426912.stgit@mickey.themaw.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20170113 (1.7.2)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Vincent.Mcintyre@csiro.au; 
x-originating-ip: [130.155.194.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18e49940-bdb3-4d61-86ee-08d7d20e6d3e
x-ms-traffictypediagnostic: MEAPR01MB5158:
x-microsoft-antispam-prvs: <MEAPR01MB5158EFA3A2DE66DE199BD05DF4CC0@MEAPR01MB5158.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(4326008)(6916009)(54906003)(6512007)(2906002)(186003)(26005)(316002)(66556008)(64756008)(6506007)(86362001)(71200400001)(6486002)(81166006)(1076003)(91956017)(76116006)(66476007)(8936002)(478600001)(81156014)(8676002)(66446008)(66946007)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MEAPR01MB5158;H:MEAPR01MB4517.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PBvS0ekJhRn0wnsiX0JLXWXHoYLTmwEVyT9VdYIjIF2/OqzzRhJXhVaC0xVIEfbYiktCXEwFcdpYwqn9+R6dQYGzpP1EErqbQWb8xpxhtGln2TAlYy85murI6EkFZV7krGauINMmAdgvn42basx5Xstc2yese3zy3dpCdKkHRRfMzrXD2YNQ7SFUXtOqYBPzyCuKmQjuKGTcNRglXTdoMwxasi0sUHOzuZgm0CMLJChwPpYv2P9ui8497HmNvuHPutDZ/kW9z6FLeZwnHLMUYC2C22UCY4Y0un6hyBWr16ddgKcYdJuiZujlbG1kszWEcHX81mQQ4JLn7c1orWC3iLtt/2GQWP7GJWKGcLgReuDnW6TFhQnfXo4TzCPVQJoK1vz2HfOXbs60wTqB9U+QdcgUoSo3o1bPROgJJp/QruvmgP5CWPwyYcUxj/d3zbdc
x-ms-exchange-antispam-messagedata: X2R288u2jY+UoxDAnxjdDKfNCBq6YI/Ke5otMpG8JItF3lVhgZ6TTAF1m3wcNC+kxrRIREwjSCbmqyV9IeZn3ZwXv+9HP4d1MwY7lRwGTvp7uhe4zOd3coV6pS/HyGcukWO6zvX5WjfHIrkB0kANEg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3AB93E4465266A459CD3E8CE3385BC2B@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e49940-bdb3-4d61-86ee-08d7d20e6d3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 05:19:29.9534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0fe05593-19ac-4f98-adbf-0375fce7f160
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7TNrVnIcNDVE+pnJGeoHF+TicnxsMtyteaWFhW3WvbMN6sHb41y+vbgCJgPKalo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEAPR01MB5158
X-OriginatorOrg: csiro.au
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

One nit, below.
Vince

On Thu, Mar 26, 2020 at 01:23:36PM +0800, Ian Kent wrote:
>The function autofs_mountpoint_changed() is unusual, add a comment
>about two cases for which it is used.
>
>Signed-off-by: Ian Kent <raven@themaw.net>
>---
> fs/autofs/root.c |   21 ++++++++++++++++++---
> 1 file changed, 18 insertions(+), 3 deletions(-)
>
>diff --git a/fs/autofs/root.c b/fs/autofs/root.c
>index 308cc49aca1d..a972bbaecb46 100644
>--- a/fs/autofs/root.c
>+++ b/fs/autofs/root.c
>@@ -280,9 +280,24 @@ static struct dentry *autofs_mountpoint_changed(struc=
t path *path)
> 	struct dentry *dentry =3D path->dentry;
> 	struct autofs_sb_info *sbi =3D autofs_sbi(dentry->d_sb);
>
>-	/*
>-	 * If this is an indirect mount the dentry could have gone away
>-	 * as a result of an expire and a new one created.
>+	/* If this is an indirect mount the dentry could have gone away
>+	 * and a new one created.
>+	 *
>+	 * This is unusual and I can't remember the case for which it
>+	 * was originally added now. But a example of how this can

'an' example

>+	 * happen is an autofs indirect mount that has the "browse"
>+	 * option set and also has the "symlink" option in the autofs
>+	 * map entry. In this case the daemon will remove the browse
>+	 * directory and create a symlink as the mount (pointing to a
>+	 * local path) leaving the struct path stale.
>+	 *
>+	 * Another not so obvious case is when a mount in an autofs
>+	 * indirect mount that uses the "nobrowse" option is being
>+	 * expired and the mount has been umounted but the mount point
>+	 * directory remains when a stat family system call is made.
>+	 * In this case the mount point is removed (by the daemon) and
>+	 * a new mount triggered leading to a stale dentry in the struct
>+	 * path of the waiting process.
> 	 */
> 	if (autofs_type_indirect(sbi->type) && d_unhashed(dentry)) {
> 		struct dentry *parent =3D dentry->d_parent;
>

-- =
