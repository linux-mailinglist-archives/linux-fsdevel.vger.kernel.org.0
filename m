Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECFEBB7EF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 18:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404245AbfISQT5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 12:19:57 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23161 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403802AbfISQT5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 12:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568909995; x=1600445995;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ZQ8QXMOhtnhyXjL3N4i4ZbOk1Fl1JNzrAtsEx1V10OI=;
  b=mm+MZ+JoPXukRyOn8t9cwDSwKtyyjICqy2/Cyx9aFiIHpkuRs/bjrXth
   Cj9acsutWCvvIIBN8GdIwxIn3D9o0FtqC9sZOQWugVbljg5GeE8BMYbB2
   z2mccs7XCsVC7j6hc4ilz5bNeCgtTS15AKKSLOt+lzoHX+D9zxsDMkoqg
   WwFy1ASzwR5UxCTNmUa7OCltc9dV1de34WC8IlMPQxsfECkuIHOFrZeJ8
   DyHh0QhVo5MJpYq4d7ci9hFeTzNi84iipIa0izokAgn+sWSY3nQYZsaCp
   l1KJMQoAz/7dBzlo+XmJmLe3kvgUfZYi/hfZlt73YBQJSkvus3KxMtDzP
   A==;
IronPort-SDR: I58bHfMTQZolR0XHElSY4fgPxvef7FIeE6sg9XyCqNbvIeV1nL1rgDn2vF2DRYmwfvVL54455E
 JSzSG9L03LGL1SBHqA3vTgDP0kSEZuOWT0sw8F7NJOthvkB+3ZHmAm//gKqI2p6kG8XM4041I1
 cXpkO7xRJGyVNUYBaMbbssjjBRcYfX+8KrD5zHM+byNN0TiO+ePWRyczOOAToIwn/yzb+vyrzB
 PrsgtTB6Tt5BYTUbztQygCFub1Nk7aQgasddne2UCmBgrAtJXst3OxfZ5WNPjdp70ok6mtNCFV
 Zdw=
X-IronPort-AV: E=Sophos;i="5.64,524,1559491200"; 
   d="scan'208";a="119459390"
Received: from mail-cys01nam02lp2052.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.52])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2019 00:19:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ls17TsnnWwkMgq0w0Jg7XU/TRPPkxkd+tV5ja3omdiY7OOpqwcivJkYgnPAJEDvFl4AdKPqYXuz6+FrJXYKKzedp5a8q4QGEXQGxwpsOUiV0fjDFshFem3pDPE+e0e4t2jW0MW1qUTtV+KPkb+fLt3dc/2gotgEifkVqa97vNw4LT7jFZPwS8mAPwxreycx5cD6XvSt2p1ir+8R4dGUgO6VB5OQ1RxP1jxGSNvL+jMV+do7c122G6zpW3rorPyqBiUUkQsdsiz5kmCjy6cCMUNVBCtbEkZrfbjH/jdE7IvKQB+3sg8BeaxMXqEvMqkbmMyJTlPFJ6MvGkxvws8UKbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clIyfzoBgod6+wqxna9hEAK8NTykLKbtebSP9ZBt53o=;
 b=IoHeIc+fSaW+/PWmtnaOCCEbwtiYRrZc5TED55P9rcOJ0fjG7Avg3qVPZV2TtZ5zoCe3SIxOW1oq7NBuTeYGxY3QANO7FHtYYxbdh2JHC1Xtryk+2RBdrCX9O5ObIGWHNPU+oEU+VyZFDFkENr5/6Kx6yDeXnVP1wxW3RmXYSdMer9SxObU1/azpHNHsllvzgxiLC84IL5sI3y6MrxP7wv5J2yLMWgA6iXbi26UWBweZ7hwxWfJonn73ki/ztnAxRA6eUV5NZTHNfPpkAUwx5g1wNNIlMsBdNy+TM4e6qlIS04vETj6rk9EzpZ3Gt/aHB6c2FBRbeTJVvdkdxN+U+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clIyfzoBgod6+wqxna9hEAK8NTykLKbtebSP9ZBt53o=;
 b=lV+h4g8iX42LgkWdQihu5Se8P5y8xv78WAeOZi+0PmdY28IKy4U5EGtAtUJ1dMP1rCw5Zu4/fn34dRVO4dgGHUcYF+3khhTBRA0fW783Kx9dV+y3UX6EwGWpWFKZNIrgb0LxptoKy1KHivxIC1D43wdThLNjHdp2kOLb8YTy3S0=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.13; Thu, 19 Sep 2019 16:19:37 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::9821:67e1:9799:b117]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::9821:67e1:9799:b117%3]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 16:19:37 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [ANNOUNCE] xfs-linux: iomap-5.4-merge rebased to 1b4fdf4f30db
Thread-Topic: [ANNOUNCE] xfs-linux: iomap-5.4-merge rebased to 1b4fdf4f30db
Thread-Index: AQHVbwApqraejWyP+EqCoHaEIePvTQ==
Date:   Thu, 19 Sep 2019 16:19:37 +0000
Message-ID: <BYAPR04MB581608DF1FDE1FDC24BD94C6E7890@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190919153704.GK2229799@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [79.98.72.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7421c6e7-29da-48f2-5f6c-08d73d1d2a89
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB3782;
x-ms-traffictypediagnostic: BYAPR04MB3782:
x-microsoft-antispam-prvs: <BYAPR04MB37825ADA04F5006B9B265D7BE7890@BYAPR04MB3782.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(199004)(189003)(86362001)(3846002)(99286004)(110136005)(6506007)(54906003)(229853002)(316002)(7736002)(476003)(14454004)(102836004)(6436002)(6116002)(25786009)(76176011)(5660300002)(7696005)(52536014)(478600001)(305945005)(74316002)(53546011)(26005)(9686003)(91956017)(76116006)(4326008)(66066001)(6246003)(81156014)(81166006)(33656002)(256004)(14444005)(55016002)(486006)(71200400001)(8676002)(71190400001)(186003)(8936002)(446003)(2906002)(66476007)(66556008)(64756008)(66946007)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3782;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KlpgfsV4395qIUrbR4L78tUWIkXohy9EzXSS3x7cdueQEfzvUXR6w9mOSotOllgsqHYpwRu+w8y9gIYo6XESLkYZGRDNBjKVeLBaPHv0rO7u5yzk98u3PYBkKj2GJO2gE7FeMIA2Hcjv/yBs+R1gUGjuNR+ChX1V3SmJB9MDPUP9+DzP0u5iJZWnluxgwm64j/sME1LQk+q/d88GqGh3NacB2Cunw5uN5M/ZUw7aKtfa+NUkV0PklzGKvtgARi1uks+49Vp8CrZyo6Kx+1rGQSmZtsX0xpLqCO4WjtCjBDWnbvhsE9N67xxQdMBZ105iREBaoaOMTZNkKVfa4//ncJt4AO6FOtzSaTy77mdLn2IF8KRWKW7EJhSaACqhWq7YAElvcAFHmNzWfUzJBG8nYjTciKxctwj8bgKwaI7FeRw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7421c6e7-29da-48f2-5f6c-08d73d1d2a89
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 16:19:37.1827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8sLP/DU4v9OCH0N/tNjHpLGz+yRTWpYoTM7+rbZk076/SWwPMBaGVFHHpushKJBo+LGioTf+a8WvZbQh4L4NCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3782
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/09/19 17:37, Darrick J. Wong wrote:=0A=
> Hi folks,=0A=
> =0A=
> The iomap-5.4-merge branch of the xfs-linux repository at:=0A=
> =0A=
> 	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git=0A=
> =0A=
> has just been updated.  This is a rebase to remove the list_pop bits=0A=
> that killed the previous pull request.  I removed patches 1 and 9 from=0A=
> the branch and made the following modifications to patch #2:=0A=
> =0A=
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c=0A=
> index 051b8ec326ba..558d09bc5024 100644=0A=
> --- a/fs/iomap/buffered-io.c=0A=
> +++ b/fs/iomap/buffered-io.c=0A=
> @@ -1156,10 +1156,11 @@ void=0A=
>  iomap_finish_ioends(struct iomap_ioend *ioend, int error)=0A=
>  {=0A=
>  	struct list_head tmp;=0A=
> +	struct iomap_ioend *next;=0A=
>  =0A=
>  	list_replace_init(&ioend->io_list, &tmp);=0A=
>  	iomap_finish_ioend(ioend, error);=0A=
> -	while ((ioend =3D list_pop_entry(&tmp, struct iomap_ioend, io_list)))=
=0A=
> +	list_for_each_entry_safe(ioend, next, &tmp, io_list)=0A=
>  		iomap_finish_ioend(ioend, error);=0A=
>  }=0A=
>  EXPORT_SYMBOL_GPL(iomap_finish_ioends);=0A=
> =0A=
> I'm not thrilled to be rebasing a work branch in the middle of the merge=
=0A=
> window, but I think the changes are simple enough that we might be able=
=0A=
> to try again next week.  Damien, if you have the time can you please=0A=
> rebase zonefs atop this and make sure buffered writing to a conventional=
=0A=
> zone still works?  It should, since the _finish_ioends loop is identical=
=0A=
> between iomap and xfs.=0A=
=0A=
OK. Will do, but traveling this week so I will not be able to test until ne=
xt week.=0A=
=0A=
Thanks !=0A=
=0A=
> =0A=
> The new head of the iomap-5.4-merge branch is commit:=0A=
> =0A=
> 1b4fdf4f30db iomap: move the iomap_dio_rw ->end_io callback into a struct=
ure=0A=
> =0A=
> New Commits:=0A=
> =0A=
> Andreas Gruenbacher (1):=0A=
>       [be942954d7ad] iomap: Fix trivial typo=0A=
> =0A=
> Christoph Hellwig (7):=0A=
>       [9544e58e466f] iomap: copy the xfs writeback code to iomap.c=0A=
>       [668931192d9d] iomap: add tracing for the address space operations=
=0A=
>       [ca6de3a5b6f4] iomap: warn on inline maps in iomap_writepage_map=0A=
>       [4df389276768] xfs: set IOMAP_F_NEW more carefully=0A=
>       [5f1f62a3f64c] iomap: zero newly allocated mapped blocks=0A=
>       [0b98e70d9586] xfs: initialize iomap->flags in xfs_bmbt_to_iomap=0A=
>       [1b4fdf4f30db] iomap: move the iomap_dio_rw ->end_io callback into =
a structure=0A=
> =0A=
> Matthew Bobrowski (1):=0A=
>       [da078883a85d] iomap: split size and error for iomap_dio_rw ->end_i=
o=0A=
> =0A=
> Randy Dunlap (1):=0A=
>       [239b92845737] tracing: fix iomap.h build warnings=0A=
> =0A=
> =0A=
> Code Diffstat:=0A=
> =0A=
>  fs/iomap/buffered-io.c       | 576 +++++++++++++++++++++++++++++++++++++=
+++++-=0A=
>  fs/iomap/direct-io.c         |  24 +-=0A=
>  fs/xfs/xfs_file.c            |  14 +-=0A=
>  fs/xfs/xfs_iomap.c           |  35 ++-=0A=
>  fs/xfs/xfs_iomap.h           |   2 +-=0A=
>  fs/xfs/xfs_pnfs.c            |   2 +-=0A=
>  include/linux/iomap.h        |  53 +++-=0A=
>  include/trace/events/iomap.h |  87 +++++++=0A=
>  8 files changed, 754 insertions(+), 39 deletions(-)=0A=
>  create mode 100644 include/trace/events/iomap.h=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
