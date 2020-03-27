Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62892195088
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 06:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgC0F0M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 01:26:12 -0400
Received: from act-mtaout5.csiro.au ([150.229.7.42]:6595 "EHLO
        act-MTAout5.csiro.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgC0F0M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 01:26:12 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Mar 2020 01:26:09 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=csiro.au; i=@csiro.au; q=dns/txt; s=dkim;
  t=1585286770; x=1616822770;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZgOQdAkbe0m/WHfybthXX1IPiYH6HzKG/kfRxIv0uUI=;
  b=fECoa30iatJA6z/jXdUvm9u0YwSeQWqVYdCw0V770r5mwRZM4/hPQ1pO
   +pHdbi7zUTwrev5qRSfff23wmujgLP+oZd03I9KLU/EbMlXpztqyqt6Nd
   2ZKFf4m5pzFU81X364Oxf57nU4JJ72EPo/fT3CoOSr919fkU9gV4NqRz4
   g=;
IronPort-SDR: XmS9uNGvPbsB7JXj9e4Wme8pri2jbEKj96OGCqpb8R9u8A543I9io9AC2ILGDWaIWcgQwsS9hd
 8If3OWxxeCQA==
X-SBRS: 5.1
IronPort-PHdr: =?us-ascii?q?9a23=3AxhswuhH4ZW8X1U7U9V7AdZ1GYnJ96bzpIg4Y7I?=
 =?us-ascii?q?YmgLtSc6Oluo7vJ1Hb+e4z3A3SRYuO7fVChqKWqK3mVWEaqbe5+HEZON0pNV?=
 =?us-ascii?q?cejNkO2QkpAcqLE0r+ecDraSc3GtgEcVRk+W2qK0V9E93/fVqUq2DhpTM=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A+ERAgBgjH1elwCwBSSYiIBxAISUgiN?=
 =?us-ascii?q?mHgELHIFwC4FUUF6BCwQ1CodVA4pmgl+UJIUpgSQDVAoBAQENAS0CBAEBAoR?=
 =?us-ascii?q?CAoIwJDYHDgIDAQELAQEGAQEBAQEFBAICEAEBAQEBHgaGBgyDU34BAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAoEMPgEBAQMSFRMGAQE?=
 =?us-ascii?q?3AQ8CAQgOCgkVEA8jJQIEDgUigwSCTAMtAQECAqITAoE5iGEBAYFzM4J/AQE?=
 =?us-ascii?q?FhS8YggwJCQGBLowvgVw+g3A1PoEEAYNJhXCNdYtWlxIHAx6CHo00OokSDB2?=
 =?us-ascii?q?bYy2mYoN+AgQCBAUCDgEBBYFZAi+BWmyDQFAYDY4dGAKDWYpVdIEpjE0BMF8?=
 =?us-ascii?q?BAQ?=
X-IPAS-Result: =?us-ascii?q?A+ERAgBgjH1elwCwBSSYiIBxAISUgiNmHgELHIFwC4FUU?=
 =?us-ascii?q?F6BCwQ1CodVA4pmgl+UJIUpgSQDVAoBAQENAS0CBAEBAoRCAoIwJDYHDgIDA?=
 =?us-ascii?q?QELAQEGAQEBAQEFBAICEAEBAQEBHgaGBgyDU34BAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEFAoEMPgEBAQMSFRMGAQE3AQ8CAQgOCgkVE?=
 =?us-ascii?q?A8jJQIEDgUigwSCTAMtAQECAqITAoE5iGEBAYFzM4J/AQEFhS8YggwJCQGBL?=
 =?us-ascii?q?owvgVw+g3A1PoEEAYNJhXCNdYtWlxIHAx6CHo00OokSDB2bYy2mYoN+AgQCB?=
 =?us-ascii?q?AUCDgEBBYFZAi+BWmyDQFAYDY4dGAKDWYpVdIEpjE0BMF8BAQ?=
Received: from exch3-mel.nexus.csiro.au ([IPv6:2405:b000:302:71::85:123])
  by act-ironport-int.csiro.au with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 27 Mar 2020 16:18:58 +1100
Received: from exch3-mel.nexus.csiro.au (2405:b000:302:71::85:123) by
 exch3-mel.nexus.csiro.au (2405:b000:302:71::85:123) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 27 Mar 2020 16:18:58 +1100
Received: from exedge2.csiro.au (150.229.64.34) by exch3-mel.nexus.csiro.au
 (138.194.85.123) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Mar 2020 16:18:58 +1100
Received: from AUS01-ME1-obe.outbound.protection.outlook.com (104.47.116.56)
 by exedge2.csiro.au (150.229.64.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 27 Mar 2020 16:18:50 +1100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORXY+QFS22vLHMaqeWMxsFrOBN6M7YcOz+48Yytd0MmxN72Or+qXh1Zd7NBBG0jgNaYdH61tjdOiGA5+X2r+dlKTo1O3ZQQ4UuR2EQgc2OVEeZF97RUHR+WdS04N2FN9B9WODZ86wM9ySizdna0tz9AsQlQfTjbzQDoI5suCKZJdkiMldBeMmi66pTZJLU3+pJtXKfHuR+a3552cUKU83ugMtGZR9EFytg4Nta5e8tbeIiaRJMoRfbHoJlFbkrma5YczPY/qok+ls6oQyAnccHwH2u0KRphMWx2wkrzhfZ+GGRGj7eAFpkLiazmpocGHeK0gOFuYPcv7dmn+ERW7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SR+j0oF6vyw3qdvsX+NhgsRv+2EgpHqVBWj+hHAiy2A=;
 b=D0pCYvTlLYGDfEMk7PMTGhbdZ5TVHoEgGyPzDFmb2LU+efyOHjB9Kk1sRpaO2WJu6X3zRSc1WvFx16dc/8lzb43IAd7dkey+yJ4AC/IlZiQJdiCHETwYhNPaL77CmioQnJkXBji69grSP/3AHIlGNex89tBVpQaKWttNWS351m4Paj/6Nwb4ZipUUBSuyItNR2x1pjp5zXPiB/A+fSxatO9Oy6ghFl/dp4B+wLPQ9juLGysZkAUWNvw1S5LZSitlCnqPMvnuEqZ4LqOGGIYa94SYQN8MrpGgo4DNbwwv6cDl2R3mqTvEKwMtC7cAbs95sEABtf28Qg/I2FVFTHBXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csiro.au; dmarc=pass action=none header.from=csiro.au;
 dkim=pass header.d=csiro.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CSIROAU.onmicrosoft.com; s=selector1-CSIROAU-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SR+j0oF6vyw3qdvsX+NhgsRv+2EgpHqVBWj+hHAiy2A=;
 b=AwhpBn53rEzuzXifiKo03wBheI5ppXiRpEDacWXlos9+KThF0E98mbgO5paqZ0GqPmjfN4VDjkfKl4L8kHIYQsToFPtHS/xNDRBNRM5WgEN0SnHROniveYilqeAkEMpdyZJ++nxGOH69EHNS3M8sld21ORfNzVGbRwNtyL93yLo=
Received: from MEAPR01MB4517.ausprd01.prod.outlook.com (20.178.177.210) by
 MEAPR01MB5158.ausprd01.prod.outlook.com (10.255.149.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Fri, 27 Mar 2020 05:18:57 +0000
Received: from MEAPR01MB4517.ausprd01.prod.outlook.com
 ([fe80::c0cb:c6dc:af29:fd72]) by MEAPR01MB4517.ausprd01.prod.outlook.com
 ([fe80::c0cb:c6dc:af29:fd72%5]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 05:18:57 +0000
From:   "McIntyre, Vincent (CASS, Marsfield)" <Vincent.Mcintyre@csiro.au>
To:     Ian Kent <raven@themaw.net>
CC:     Al Viro <viro@ZenIV.linux.org.uk>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] vfs: check for autofs expiring dentry in
 follow_automount()
Thread-Topic: [PATCH 3/4] vfs: check for autofs expiring dentry in
 follow_automount()
Thread-Index: AQHWAzAsU8DtPOiVzUeB6TaUvfZGdahb6AwA
Date:   Fri, 27 Mar 2020 05:18:56 +0000
Message-ID: <20200327051855.6o6y6l6b3gamlkji@mayhem.atnf.CSIRO.AU>
References: <158520019862.5325.7856909810909592388.stgit@mickey.themaw.net>
 <158520020932.5325.1998880625163566595.stgit@mickey.themaw.net>
In-Reply-To: <158520020932.5325.1998880625163566595.stgit@mickey.themaw.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20170113 (1.7.2)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Vincent.Mcintyre@csiro.au; 
x-originating-ip: [130.155.194.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 254696e7-864c-4c3c-72d8-08d7d20e5993
x-ms-traffictypediagnostic: MEAPR01MB5158:
x-microsoft-antispam-prvs: <MEAPR01MB5158E7E1F755A00207BDEAB3F4CC0@MEAPR01MB5158.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(4326008)(6916009)(54906003)(6512007)(2906002)(186003)(26005)(316002)(66556008)(64756008)(6506007)(86362001)(71200400001)(6486002)(81166006)(1076003)(91956017)(76116006)(66476007)(8936002)(478600001)(81156014)(8676002)(66446008)(66946007)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MEAPR01MB5158;H:MEAPR01MB4517.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oIpOIzoPPVkbO/SdzcQawpuh4IdgQ/LedhGyV3EUj9qvzp8G9voWgGg/NxZPaovhUQMG5ox9K+LkyC2tCcOMvgLq+QMHWAvakmDG23v/bnBspTc/IUf9FduHdF6F/EF70ZlRjhtyk4InMv65NKLZH/xDCT3QWAlL1tFGFc+elu+SCfUnDWBmTfD2D8tfv0CbnxpJHbvXEgQfmAisnlLVnyOYx1E4r3VH1FzGP46FbP/Bu4iR7XPsmlKEDCcZiy6KRtyEwd7OaQd9WV0XIrNp9cKhx+zDAjWLB+aBaaiCk/Xr/jpzjMexRxIrSw/d2sTS/lwp7lKHpObHTlxgAdkeJax7nzkrzck/EhWCfUpDPQDxGG5Gs7Rtp7aEwSWGIEJIHdy/czewzQEaXw/bnJk8/IEs9EsoPBL0DDoRNt0Q9kAAcKLtwNKPTGCsfZYTGHsv
x-ms-exchange-antispam-messagedata: GXFWDpa0n/hgp2t545PjNet7o6xUmgyH6jvbdkTOWy2v0HfK+HrYCifB+nJIyeJWAKJeToa6b3oP6GgCqUvkpPkWsAHSzGyR+1b4AFIsHvFpxXhNlR+pXMhVv3h3w5y5BNlCvSJphiDabbCvNT0HCw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <747723B718D0C04086926CFC1F0509FF@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 254696e7-864c-4c3c-72d8-08d7d20e5993
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 05:18:56.9175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0fe05593-19ac-4f98-adbf-0375fce7f160
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yvDvFXlumB8fsE5JeLxgBGWCHBEqUEzC0k3yPAfTNVu8O40aIVK76HBrFIjHyil8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEAPR01MB5158
X-OriginatorOrg: csiro.au
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 26, 2020 at 01:23:29PM +0800, Ian Kent wrote:
>follow_automount() checks if a stat family system call path walk is
>being done on a positive dentry and and returns -EISDIR to indicate
>the dentry should be used as is without attempting an automount.
>
>But if autofs is expiring the dentry at the time it should be
>remounted following the expire.
>
>There are two cases, in the case of a "nobrowse" indirect autofs
>mount it would have been mounted on lookup anyway. In the case of
>a "browse" indirect or direct autofs mount re-mounting it will
>maintain the mount which is what user space would be expected.
>
>This will defer expiration of the mount which might lead to mounts
>unexpectedly remaining mounted under heavy stat activity but there's
>no other choice in order to maintain consistency for user space.
>
>Signed-off-by: Ian Kent <raven@themaw.net>
>---
> fs/autofs/root.c |   10 +++++++++-
> fs/namei.c       |   13 +++++++++++--
> 2 files changed, 20 insertions(+), 3 deletions(-)
>
>diff --git a/fs/autofs/root.c b/fs/autofs/root.c
>index a1c9c32e104f..308cc49aca1d 100644
>--- a/fs/autofs/root.c
>+++ b/fs/autofs/root.c
>@@ -406,9 +406,17 @@ static int autofs_d_manage(const struct path *path, b=
ool rcu_walk)
>
> 	/* Check for (possible) pending expire */
> 	if (ino->flags & AUTOFS_INF_WANT_EXPIRE) {
>+		/* dentry possibly going to be picked for expire,
>+		 * proceed to ref-walk mode.
>+		 */
> 		if (rcu_walk)
> 			return -ECHILD;
>-		return 0;
>+
>+		/* ref-walk mode, return 1 so follow_automount()
>+		 * can to wait on the expire outcome and possibly

'can to wait' ?
Do you mean: "can wait", "will wait", "knows to wait",
or something else?

>+		 * attempt a re-mount.
>+		 */
>+		return 1;
> 	}
>
> 	/*
>diff --git a/fs/namei.c b/fs/namei.c
>index db6565c99825..34a03928d32d 100644
>--- a/fs/namei.c
>+++ b/fs/namei.c
>@@ -1227,11 +1227,20 @@ static int follow_automount(struct path *path, str=
uct nameidata *nd,
> 	 * mounted directory.  Also, autofs may mark negative dentries
> 	 * as being automount points.  These will need the attentions
> 	 * of the daemon to instantiate them before they can be used.
>+	 *
>+	 * Also if ->d_manage() returns 1 the dentry transit needs
>+	 * managing, for autofs it tells us the dentry might be expired,
>+	 * so proceed to ->d_automount().

I'm wondering if this should be two sentences.
Does this version reflect reality?

+	 * Also if ->d_manage() returns 1 the dentry transit needs
+	 * to be managed. For autofs, a return of 1 tells us the
+	 * dentry might be expired, so proceed to ->d_automount().

Kind regards
Vince
> 	 */
> 	if (!(nd->flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
> 			   LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_AUTOMOUNT)) &&
>-	    path->dentry->d_inode)
>-		return -EISDIR;
>+	    path->dentry->d_inode) {
>+		if (path->dentry->d_flags & DCACHE_MANAGE_TRANSIT) {
>+			if (!path->dentry->d_op->d_manage(path, false))
>+				return -EISDIR;
>+		} else
>+			return -EISDIR;
>+	}
>
> 	nd->total_link_count++;
> 	if (nd->total_link_count >=3D 40)
>

-- =
