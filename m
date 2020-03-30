Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C079B198843
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 01:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgC3X1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 19:27:52 -0400
Received: from act-mtaout4.csiro.au ([150.229.7.41]:33159 "EHLO
        act-MTAout4.csiro.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbgC3X1w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:27:52 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Mar 2020 19:27:50 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=csiro.au; i=@csiro.au; q=dns/txt; s=dkim;
  t=1585610871; x=1617146871;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HjQeJM3In1u/kI3GKZJDhbcAwcHi1MytLhtx6vlSoDI=;
  b=M/s/ZonZnroaqKCoWvzoh9RYRGbUUAzz0nm3+JbZC8HEYNtqL9MqDuoe
   xDi104xHT5CULBEd3lknK0hmOAxO8PSsBVWTKEm9KZHP9ksV3XMNcwGQv
   XCal3ujMHAc1M4P3mevbHzPABxZRogTaDu7lJEJVAUY2nzC+Ihujr0wzX
   U=;
IronPort-SDR: 3dP0kmQLVZzTnWAopodIrq9BjNwyVxf0IV9WgwQGubkAusL2ct0JptZJpaOls+RSsck3EM7RFY
 XsDlSKzR72wg==
X-SBRS: 4.0
IronPort-PHdr: =?us-ascii?q?9a23=3AAcx9ERCF/YG7CS21fNxjUyQJPHJ1sqjoPgMT9p?=
 =?us-ascii?q?ssgq5PdaLm5Zn5IUjD/qs93kTRU9Dd7PRJw6rNvqbsVHZIwK7JsWtKMfkuHw?=
 =?us-ascii?q?QAld1QmgUhBMCfDkiuEv/sZCE8AIJnX15j42ChPGBeA8fkYBvbvy764A=3D?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A+EeAABAfoJejACwBSSYiIBxAISUgiJ?=
 =?us-ascii?q?mHAEBAQEBBwEBEQEEBAEBgWcHAQELAYFTUF6BCwQ1CodVA4RahhCCX5QkhSm?=
 =?us-ascii?q?BJANUCgEBAQ0BLQIEAQEChEICgjMkNAkOAgMBAQsBAQYBAQEBAQUEAgIQAQE?=
 =?us-ascii?q?BJoYGDINTfgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQU?=
 =?us-ascii?q?CgQw+AQEBAxIVEwYBATcBDwIBCA4KCRUQDyMlAgQOBSKDBIJMAy0BAQICon4?=
 =?us-ascii?q?CgTmIYQEBgXMzgn8BAQWFFRiCDAkJAYEuAYwwgVw+g3A1PoEEAYNJhXCNd4t?=
 =?us-ascii?q?XlxsHAx6CHo07iU4MHZtsLaZxg34CBAIEBQIOAQEFgVI4gVpsg0BQGA2OHRg?=
 =?us-ascii?q?Cg1mKVXSBKY0OATBfAQE?=
X-IPAS-Result: =?us-ascii?q?A+EeAABAfoJejACwBSSYiIBxAISUgiJmHAEBAQEBBwEBE?=
 =?us-ascii?q?QEEBAEBgWcHAQELAYFTUF6BCwQ1CodVA4RahhCCX5QkhSmBJANUCgEBAQ0BL?=
 =?us-ascii?q?QIEAQEChEICgjMkNAkOAgMBAQsBAQYBAQEBAQUEAgIQAQEBJoYGDINTfgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCgQw+AQEBAxIVE?=
 =?us-ascii?q?wYBATcBDwIBCA4KCRUQDyMlAgQOBSKDBIJMAy0BAQICon4CgTmIYQEBgXMzg?=
 =?us-ascii?q?n8BAQWFFRiCDAkJAYEuAYwwgVw+g3A1PoEEAYNJhXCNd4tXlxsHAx6CHo07i?=
 =?us-ascii?q?U4MHZtsLaZxg34CBAIEBQIOAQEFgVI4gVpsg0BQGA2OHRgCg1mKVXSBKY0OA?=
 =?us-ascii?q?TBfAQE?=
Received: from exch2-mel.nexus.csiro.au ([IPv6:2405:b000:302:71::85:122])
  by act-ironport-int.csiro.au with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 31 Mar 2020 10:20:35 +1100
Received: from exch1-mel.nexus.csiro.au (2405:b000:302:71::85:121) by
 exch2-mel.nexus.csiro.au (2405:b000:302:71::85:122) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 31 Mar 2020 10:20:35 +1100
Received: from exedge2.csiro.au (150.229.64.34) by exch1-mel.nexus.csiro.au
 (138.194.85.121) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Tue, 31 Mar 2020 10:20:35 +1100
Received: from AUS01-SY3-obe.outbound.protection.outlook.com (104.47.117.55)
 by exedge2.csiro.au (150.229.64.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 31 Mar 2020 10:21:32 +1100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaChy73r2QuoKRV559DS3Qmq/UOZKVZ8pXorUr6a839vTtLiqEYf5bfroXYGmFt5jdq6qlQzyCTU8j/pcwftqPmNC86fbo/YYCDBw/aOIw6q5ulA7nSPB0F4Mwy7JxzMocQV4IMVRXWBWSqYE4e/qwyb3ZYs2hzODNBIusdEYfR7Rve+XaZqNj7Gq8BRAQx4odex9BXeMTRV7z62kzLlVbyB7rlScXJzz4kP606aNvlk4rwi9oqTS1tap6enrVax5euXG6NoO00wjTQGbDRPW5f+1WRS0O0l0on4YabMUiEKt/59XsSQxbIZJGokoYX/f7MArSLPSkTSNTL0nP0qAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qih3NYdOuzsvqCc0txHTaehRyRn3UfrJH7hj7a4Sniw=;
 b=KOck++KSA76GdSI/dBaYLoiJaY9CmpPUER9aOs3uk5GPOuIqjKBrlRZJiTG/hIfe2QHxovoIGsny0QkWrNoZMiGvepYaeUuw1j+WZd+U2gg9zGqPEbfd15HK3E8o3c/faSAD/bPgOISZQvBkb6YmTrjbbrLiUIPIS2GjCMWFgIr1CacJTxljEjDEKWcD+hFvSd6yZ6/A2guS5Qn5AqHUZJDBLFhLwDOD7WZpER7IRIS/QYbNmgI5lE/+pjt8UtAVn1kXx4JgSLA6bjD2lbVJ0SUHQgUAILeCld8/+Z/i+zqwhGgthcWMth5VnyqLB/5QvjkIENO314jda5cl2tgQpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csiro.au; dmarc=pass action=none header.from=csiro.au;
 dkim=pass header.d=csiro.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CSIROAU.onmicrosoft.com; s=selector1-CSIROAU-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qih3NYdOuzsvqCc0txHTaehRyRn3UfrJH7hj7a4Sniw=;
 b=IMETsLvnW+Z2J6h6eS5G/VohFdPZGGJQQod9hnlW91AG3bLa6ub0xloNdaqu3xDP8KFNM6fclAkl6r3OpRjXMqDSme8KBXf5hMjvC59cw67avx87QdJwy1aaXgCFNRkNzJkZ0NaPKXrg0oYKefrITBIF3b4txsptA+hgqaI0TOo=
Received: from MEAPR01MB4517.ausprd01.prod.outlook.com (20.178.177.210) by
 MEAPR01MB5063.ausprd01.prod.outlook.com (20.178.179.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Mon, 30 Mar 2020 23:20:33 +0000
Received: from MEAPR01MB4517.ausprd01.prod.outlook.com
 ([fe80::c0cb:c6dc:af29:fd72]) by MEAPR01MB4517.ausprd01.prod.outlook.com
 ([fe80::c0cb:c6dc:af29:fd72%5]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 23:20:33 +0000
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
Thread-Index: AQHWBugindBjDiueJEiqG8X5HjAIi6hhxc6A
Date:   Mon, 30 Mar 2020 23:20:33 +0000
Message-ID: <20200330232032.vmlt3glzqdkgijhy@mayhem.atnf.CSIRO.AU>
References: <158560961146.14841.14430383874338917674.stgit@mickey.themaw.net>
 <158560962258.14841.1166162348928695084.stgit@mickey.themaw.net>
In-Reply-To: <158560962258.14841.1166162348928695084.stgit@mickey.themaw.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20170113 (1.7.2)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Vincent.Mcintyre@csiro.au; 
x-originating-ip: [130.155.194.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9102112-b8a5-4294-461a-08d7d500f244
x-ms-traffictypediagnostic: MEAPR01MB5063:
x-microsoft-antispam-prvs: <MEAPR01MB5063912300A6EB5DF60108CBF4CB0@MEAPR01MB5063.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MEAPR01MB4517.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(2906002)(6512007)(1076003)(4326008)(71200400001)(54906003)(6506007)(81156014)(86362001)(81166006)(8676002)(6916009)(66946007)(66446008)(8936002)(478600001)(66476007)(5660300002)(66556008)(64756008)(26005)(316002)(6486002)(91956017)(186003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SxA8rHfOZSgXPn5gVSOKxf5+h6Y2gX9CWPw1L5IDGc3/y1ECn3Q4mE/S+QtvL7DOJa5mUdPQEV0lF+LGu9j56X+2gfIeXRXtU8r4ps+Oco4Bx5k259TfXJx0Uzabi7SI6aRwu+BFUmuwdfcrCtOkPOlxKrDVLS4kXaO3mYXlNM+3gaED6li476A3oKRHTg6TC1foohvoV+N2YyZDTH+D6o+LxLhbuMzKdvXJDVUJ/qqT1soEAIymXw/0vokeW3HQCxXwtaXGIz745TnqS589x4LlTdVFFTtc2cmU3BlZwydDF3O7IudN8H8MSunZ46R4A7YKjxqJ32TqZcAtz9aqfjq3MBhIaEx2iF6BNOy7jrKf6RrZ9pNIWZsS9ISgusJ5TeH72w+wHnpOvGWErKf/f38n+q2WZSfXyufepTn40ulY/oLrZPyY2eLjTSOnczB4
x-ms-exchange-antispam-messagedata: PiE+FhKt0HrJ2s2CsqCc7/HQc9y/34lcaerkCtKx5P5QAe7PYvvhYY5t29ICuQrgUPnZ4LTjT/D9IjYPs7sBRXgHXFYy1cCoQD6hN6Mg/IA+yJu6RKCsDtcTJe9hQQ92P4eQn/eRJyG04oxiI4opuw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CDC3BA921DD37444B97C17F4AC9B2590@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e9102112-b8a5-4294-461a-08d7d500f244
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 23:20:33.6342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0fe05593-19ac-4f98-adbf-0375fce7f160
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHNJV6vQhcBhSQdZ9/x0GxL7163Owrf43qWeHLm4hTz97dlxSaO04P8OwoDHE+mM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEAPR01MB5063
X-OriginatorOrg: csiro.au
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 31, 2020 at 07:07:02AM +0800, Ian Kent wrote:
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
>index a1c9c32e104f..b3f748e4df08 100644
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
>+		 * can wait on the expire outcome and possibly
>+		 * attempt a re-mount.
>+		 */
>+		return 1;
> 	}
>
> 	/*
>diff --git a/fs/namei.c b/fs/namei.c
>index db6565c99825..869e0d4bb4d9 100644
>--- a/fs/namei.c
>+++ b/fs/namei.c
>@@ -1227,11 +1227,20 @@ static int follow_automount(struct path *path, str=
uct nameidata *nd,
> 	 * mounted directory.  Also, autofs may mark negative dentries
> 	 * as being automount points.  These will need the attentions
> 	 * of the daemon to instantiate them before they can be used.
>+	 *
>+	 * Also if ->d_manage() returns 1 the dentry transit needs
>+	 * to be managing. For autofs, a return of 1 it tells us the

Unclear. Do you mean "to be managed." ? Or "managing." ?

Cheers
Vince

>+	 * dentry might be expired, so proceed to ->d_automount().
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
