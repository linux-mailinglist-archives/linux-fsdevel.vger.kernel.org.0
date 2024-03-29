Return-Path: <linux-fsdevel+bounces-15667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075D0891665
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 10:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA361C22A2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 09:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E83524DE;
	Fri, 29 Mar 2024 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="K+5GaPC5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD60751C4C;
	Fri, 29 Mar 2024 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711706348; cv=fail; b=qgsoHeaHjnUu0zXuhxkBpp/uC/NsbBXEBEXHgOhTt8+8T9QUNQKIxKftD6hxb4TW+WRCUwEC5FFPT081TKnJGUlkftpmEUPX8148nVmkX3Pa0ktvmZoWjjmqGOLPHURAUsn+uuvIfmNC8EY1Q6Mad7rRrwPoMKrInbjQYIZCSO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711706348; c=relaxed/simple;
	bh=uFeS/mJIXe4RjkQ/g4YstaSAoLb9JH9qeCiwuATBAn8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=honcoK2AMioJor5RceCvmvaLjKhawzvNP/p6tLLeTJG6bRchvB9pJScjTGKUgzWu6IpyZ+LaApbOH+Zko08FndmNuJXDgopgkAsiZ6HCyzO6RpBXi2Wh/HUYycJ3zeGJZQz05kN9bc6EMTobewbB6YQShFIlM5/p+UyDz0625u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=K+5GaPC5; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T0QgVJ006367;
	Fri, 29 Mar 2024 02:58:31 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x5gm3hxbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 02:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5PXrjpJmoSQqQhIFJhUvjdjVUS9Qfi2vHAgJT4FjLNMSCFK9C1OkALiea3Toj3f1SVRWI9bmvG/bUdhNXr7M07hadEzZAxUMjU+qAkjD8X1vU8G0qrsO+MOpX+ie+frZLToQDao7CrC3/nwl6IWomoBP3pEc/1/EQzzfxpSKyJBYGgNIM5MOcq3l/R8ZBC8BOVVBwjR4qIJD/4GVjdi+D4FG1pg7QbIePYAwyVYuPuhwvDpUwcTyzEFD6eciuBlZxnFMtvvgsawn42gF2EgGZmjWW8fJBU/3n8Mo/prNM4MKZxPxuhRrVUPQCqapw6vmWMWDaO53sVDuAcA7JJIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JhUqML4zjS2Q2eHYvoKkfAMPHpawo6RXrDJhvddxNs=;
 b=dcC49zfR/cbde0EWWkT39Ulb/VCgRXn4SOmH6Rq4Ms6b/njVjd+7PYzX0/mECcW0CbSDPu/d4OsQ8w9b4068AEgdtoDsbmRVICbvAm1QENQt2Oty/Oj8HA2gxk/oR+tW/KqRHl4zS57fbF6MrEFkki0Lt+8GsZkG/s8SfaRAgkh6tekTc2zI8p8ui/DUjTJKz6wu/6XRc9VJumD86gIn5qTYznEG49RHc1/HFrh8Tv1b3avDxMLEM41ri5+TJeIXlgTQzgiIAeypFysM/XZM4xctK3cEADDykQGZ1PjT2A9E2diMe/RW1kzyZfzoNHQf9cx9RSh/dum5upE2FiDBWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JhUqML4zjS2Q2eHYvoKkfAMPHpawo6RXrDJhvddxNs=;
 b=K+5GaPC5u+aRA5LaVfUFrhzQ3lHbe4HOESma9mdtkaI7oTLe63oCqOu0Q3P7y0bMRYgW2EZBWfgFP+EI1Z1t1v91L2NnP5Uihm+XLg5TzhmKRlLrDrSalF+3Yg8cAq1USx0t6ILMuEdXqLJlF3MNfSCzReBiaB/JuRDOWXeMCbM=
Received: from SJ2PR18MB5635.namprd18.prod.outlook.com (2603:10b6:a03:55a::21)
 by BY1PR18MB5350.namprd18.prod.outlook.com (2603:10b6:a03:524::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 09:58:29 +0000
Received: from SJ2PR18MB5635.namprd18.prod.outlook.com
 ([fe80::317:8d8c:2585:2f58]) by SJ2PR18MB5635.namprd18.prod.outlook.com
 ([fe80::317:8d8c:2585:2f58%3]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 09:58:29 +0000
From: Naveen Mamindlapalli <naveenm@marvell.com>
To: David Howells <dhowells@redhat.com>, Steve French <smfrench@gmail.com>
CC: Jeff Layton <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
        Christian Brauner <christian@brauner.io>,
        "netfs@lists.linux.dev" <netfs@lists.linux.dev>,
        "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steve French
	<sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith
 Surabattula <rohiths.msft@gmail.com>
Subject: RE: [PATCH v6 11/15] cifs: When caching, try to open O_WRONLY file
 rdwr on server
Thread-Topic: [PATCH v6 11/15] cifs: When caching, try to open O_WRONLY file
 rdwr on server
Thread-Index: AQHagb+muX0JMo5O+UG0te/3gFUHIQ==
Date: Fri, 29 Mar 2024 09:58:28 +0000
Message-ID: 
 <SJ2PR18MB5635CA3F5A382FC12D6CE58FA23A2@SJ2PR18MB5635.namprd18.prod.outlook.com>
References: <20240328165845.2782259-1-dhowells@redhat.com>
 <20240328165845.2782259-12-dhowells@redhat.com>
In-Reply-To: <20240328165845.2782259-12-dhowells@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR18MB5635:EE_|BY1PR18MB5350:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 t82/4/zxg+/xKf/hvL3P7VxYR19CuJCqe6Mr2E2odSu3LqV7TUsGVcqihxd6BB0KjltlMUITUc5IJK3K/q+D2b9n1Y0xC3agqwilBIaTz9C5M3Mk53UVz+ea+4/fyfR/Zfww9ny4Yz78Vqb9EKkqrK7yHRHqJg0RXU5AaZP8OrEbtJqx6ROBEDeuEIJdMYGYWNi+56K3OSNXqQSu7WH+VITcrGpkPoNFp4fLtojz6+Z7Te4dMH3z2jqWMIqAfmXYmYSM1IBH74LhkEfjWQtdMBeAaHBC4jjudYcx9s9bN8vsGyuIEqQ8fhHMuf7GAAXFejD6n5RrMquoHKfVjPEk/NVyqHiOnBmesi+8vZhxmxIPhKnvvjSZSLRlTvHUi8FQIgvvwpDa8a7rCdQ/MCMKZuAPUYkP86aZbNqAc9i6MjzIUPuC+ijfJzQCn0WDbcO5P5p6D2ZHF6HXAzreuqezfVo9alZq+cfV33ij84zt/CdlkVQUuP/HwWo0APJ1dyZVkLn6t13uUuv69LruwHcTIqcnm1gCkMD0pgeUIkLXxQzsxY8nTb5ysW3GBzsagtAc6PeIYDb5R03KfJeSQMNMZDp7fjolF1BlqtrPoonvqxeF3ljFb9oLp2Y6BQBZ8CS+8zb1nmt8/LOIZA915Alk1pZ074BZSVnBOFAP5P/Hk+w=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR18MB5635.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?vbhtN7JR14V+hdJyscv9SrrZkYawzfLNKFoMKbBXn5sILSc/MmpUnZvkiJEr?=
 =?us-ascii?Q?uLYfLbZwwXpLHApKPQMrvcABnKv4YR9bpz6myNiPWvBd54DaRsgj1WrZ59wz?=
 =?us-ascii?Q?upbbTfDS+3JjVF6NX9PPCPp4NdmnL3+T7vRjCFe0Hq3R0RhwGGMkZ1zOqXrV?=
 =?us-ascii?Q?4UqMordjxUMRp4vc08VOsekxn3LCPqYkBy53s71PncT0RXUAxpaDEJzY54c6?=
 =?us-ascii?Q?rBrgQuduMUpBoy1XNGC/7sD56gBRUQEEhvleIKbzN8AlA/lBm6H1ukBBQTLB?=
 =?us-ascii?Q?fkV3fw1i21LzKX3WOuJSflxycdDC7z4HfOYtYcTAyzWWWnXyqKu5jt8AgDxk?=
 =?us-ascii?Q?ejOw0b9eK1JIbEZT/klunNAA1Km+zbe5ZN6v3RtjKGfdS6BJ+Mdw+sZpwJcs?=
 =?us-ascii?Q?ryBQ1kwX8uUqFyLSoDBvN0yrAA8rTb4cF/gcbyiiFrfh6MdlDSRf2v1F2EVJ?=
 =?us-ascii?Q?j8BYoKbTG/3WrvJfTQCp3UlhSL8I/iz4EQXVEYx6NI6Jg7xFPAUyc468CCX7?=
 =?us-ascii?Q?vrHrFh9fPHbdbUivhUwgDhYb6hmF/pN6dGKCcTZ+lITsqqqrpTbvFAMvN08k?=
 =?us-ascii?Q?bWFuTStL4HAMq0DIvXuU4sz7jjSjyyHf3eyUSJBNMK5hO1pCstr6Vvq6MZGV?=
 =?us-ascii?Q?qmPRU1SpYTSzJWXuJwaEr0smXjZk968hYPFpSEmdSaEqUZ+fBGRWovU6xYDJ?=
 =?us-ascii?Q?5/t9ZU6fF0OPolE0BG8LtEsynFPOa7EwV2iSYN+F8WwX19/hmw/z1kG3qoCT?=
 =?us-ascii?Q?22fKL7GgqyGYfEtB1wpRZk2v/H6khrJELk1CJcci7f4vkoiHNdvajoeeIkhF?=
 =?us-ascii?Q?EcSHJIMOdmJ4OqP5D+LyuWJ4QlWcfOUMZS0gyNZtWVM7XPFtsZrpmFRT5iAQ?=
 =?us-ascii?Q?45sRr4OeFBjRwAA1m2MXfrDDXsi1mmUNHhJWFeL3QN+V3r+bAQ2KZcXmiL2e?=
 =?us-ascii?Q?ncZt5XwIFOC2NJK11U8gRnDF9YGHx01CM2ngihFaxJU42gaesC7u4HAJIu3X?=
 =?us-ascii?Q?zeVFOebPBLVLLWuNkR77H/jcw06Eiv2cpNOpcIOCs3bd6J1V+5VHg/q84FAL?=
 =?us-ascii?Q?XSZLNFVpHP9yICgGVvFWakN2OjCMUgiXPLgpeqnDMpxWPDXy+VA84BSp67oU?=
 =?us-ascii?Q?3EU84jKiOnU237uuQvhngs3bCQsO3gYucod0ZYPsvIAKs98Wk9Y0PtkLKy5d?=
 =?us-ascii?Q?0JB057Zn3IjG1Xpr9ar1SuvrJWAizf0prcPzN7KgksJS53J/5JD2lMxyANkI?=
 =?us-ascii?Q?PlHZW2P4tXwjWDotX9y4zm9S+i2hNQJ7x27XgFjwKZL0fCiXsXBJATVb9o/s?=
 =?us-ascii?Q?yfDcD7vGhsqTflTbMuP+QUi4iYCPMdl3lxK1137gCK/xIC4nWl8acWZHDDGP?=
 =?us-ascii?Q?0jk4RSjYQSiylTwZPkxKnziUF/U+zm0zZ80LgEiQ6lSK4dxjEDaygFWKnNw8?=
 =?us-ascii?Q?KQ1kbkC+vVTAfHPYzKa/hvEVfYT4SNEIITipIj3JqF5XGXl4zsqryUTtgctR?=
 =?us-ascii?Q?Nv/BKVc1/x/UmI+bj+wel/7uDEOaiNWAVP5HRzV2CuZeebvSoGpSHnXcHTHi?=
 =?us-ascii?Q?Af8Qa5KDzx/jKGA+Ijw6F9A3qR//lBGnq3ozNU5U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR18MB5635.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd9aa64-52e0-4f33-b94e-08dc4fd6c8cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 09:58:28.9945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g2DWz+KC0UmvoIX0LpuUhwNX6toyBuowDDYKsxAGx/zTiHvfxOT+f0WjQc9VntxzcXLh6HoXpXwlaxJHyga3JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB5350
X-Proofpoint-GUID: lH4i3t_xW62ZspnC561E08_TcugXwosJ
X-Proofpoint-ORIG-GUID: lH4i3t_xW62ZspnC561E08_TcugXwosJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_09,2024-03-28_01,2023-05-22_02


> -----Original Message-----
> From: David Howells <dhowells@redhat.com>
> Sent: Thursday, March 28, 2024 10:28 PM
> To: Steve French <smfrench@gmail.com>
> Cc: David Howells <dhowells@redhat.com>; Jeff Layton <jlayton@kernel.org>=
;
> Matthew Wilcox <willy@infradead.org>; Paulo Alcantara <pc@manguebit.com>;
> Shyam Prasad N <sprasad@microsoft.com>; Tom Talpey <tom@talpey.com>;
> Christian Brauner <christian@brauner.io>; netfs@lists.linux.dev; linux-
> cifs@vger.kernel.org; linux-fsdevel@vger.kernel.org; linux-mm@kvack.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Steve French
> <sfrench@samba.org>; Shyam Prasad N <nspmangalore@gmail.com>; Rohith
> Surabattula <rohiths.msft@gmail.com>
> Subject: [PATCH v6 11/15] cifs: When caching, try to open
> O_WRONLY file rdwr on server
>=20
> When we're engaged in local caching of a cifs filesystem, we cannot perfo=
rm
> caching of a partially written cache granule unless we can read the rest =
of the
> granule.  To deal with this, if a file is opened O_WRONLY locally, but th=
e mount
> was given the "-o fsc" flag, try first opening the remote file with
> GENERIC_READ|GENERIC_WRITE and if that returns -EACCES, try dropping
> the GENERIC_READ and doing the open again.  If that last succeeds, invali=
date
> the cache for that file as for O_DIRECT.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/smb/client/dir.c     | 15 ++++++++++++
>  fs/smb/client/file.c    | 51 +++++++++++++++++++++++++++++++++--------
>  fs/smb/client/fscache.h |  6 +++++
>  3 files changed, 62 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c index
> 89333d9bce36..37897b919dd5 100644
> --- a/fs/smb/client/dir.c
> +++ b/fs/smb/client/dir.c
> @@ -189,6 +189,7 @@ static int cifs_do_create(struct inode *inode, struct=
 dentry
> *direntry, unsigned
>  	int disposition;
>  	struct TCP_Server_Info *server =3D tcon->ses->server;
>  	struct cifs_open_parms oparms;
> +	int rdwr_for_fscache =3D 0;
>=20
>  	*oplock =3D 0;
>  	if (tcon->ses->server->oplocks)
> @@ -200,6 +201,10 @@ static int cifs_do_create(struct inode *inode, struc=
t
> dentry *direntry, unsigned
>  		return PTR_ERR(full_path);
>  	}
>=20
> +	/* If we're caching, we need to be able to fill in around partial write=
s. */
> +	if (cifs_fscache_enabled(inode) && (oflags & O_ACCMODE) =3D=3D
> O_WRONLY)
> +		rdwr_for_fscache =3D 1;
> +
>  #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
>  	if (tcon->unix_ext && cap_unix(tcon->ses) && !tcon->broken_posix_open
> &&
>  	    (CIFS_UNIX_POSIX_PATH_OPS_CAP &
> @@ -276,6 +281,8 @@ static int cifs_do_create(struct inode *inode, struct=
 dentry
> *direntry, unsigned
>  		desired_access |=3D GENERIC_READ; /* is this too little? */
>  	if (OPEN_FMODE(oflags) & FMODE_WRITE)
>  		desired_access |=3D GENERIC_WRITE;
> +	if (rdwr_for_fscache =3D=3D 1)
> +		desired_access |=3D GENERIC_READ;
>=20
>  	disposition =3D FILE_OVERWRITE_IF;
>  	if ((oflags & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL)) @@ -
> 304,6 +311,7 @@ static int cifs_do_create(struct inode *inode, struct den=
try
> *direntry, unsigned
>  	if (!tcon->unix_ext && (mode & S_IWUGO) =3D=3D 0)
>  		create_options |=3D CREATE_OPTION_READONLY;
>=20
> +retry_open:
>  	oparms =3D (struct cifs_open_parms) {
>  		.tcon =3D tcon,
>  		.cifs_sb =3D cifs_sb,
> @@ -317,8 +325,15 @@ static int cifs_do_create(struct inode *inode, struc=
t
> dentry *direntry, unsigned
>  	rc =3D server->ops->open(xid, &oparms, oplock, buf);
>  	if (rc) {
>  		cifs_dbg(FYI, "cifs_create returned 0x%x\n", rc);
> +		if (rc =3D=3D -EACCES && rdwr_for_fscache =3D=3D 1) {
> +			desired_access &=3D ~GENERIC_READ;
> +			rdwr_for_fscache =3D 2;
> +			goto retry_open;
> +		}
>  		goto out;
>  	}
> +	if (rdwr_for_fscache =3D=3D 2)
> +		cifs_invalidate_cache(inode, FSCACHE_INVAL_DIO_WRITE);
>=20
>  #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
>  	/*
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c index
> 73573dadf90e..761a80963f76 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -521,12 +521,12 @@ cifs_mark_open_files_invalid(struct cifs_tcon *tcon=
)
>  	 */
>  }
>=20
> -static inline int cifs_convert_flags(unsigned int flags)
> +static inline int cifs_convert_flags(unsigned int flags, int
> +rdwr_for_fscache)
>  {
>  	if ((flags & O_ACCMODE) =3D=3D O_RDONLY)
>  		return GENERIC_READ;
>  	else if ((flags & O_ACCMODE) =3D=3D O_WRONLY)
> -		return GENERIC_WRITE;
> +		return rdwr_for_fscache =3D=3D 1 ? (GENERIC_READ |
> GENERIC_WRITE) :
> +GENERIC_WRITE;
>  	else if ((flags & O_ACCMODE) =3D=3D O_RDWR) {
>  		/* GENERIC_ALL is too much permission to request
>  		   can cause unnecessary access denied on create */ @@ -
> 663,11 +663,16 @@ static int cifs_nt_open(const char *full_path, struct i=
node
> *inode, struct cifs_
>  	int create_options =3D CREATE_NOT_DIR;
>  	struct TCP_Server_Info *server =3D tcon->ses->server;
>  	struct cifs_open_parms oparms;
> +	int rdwr_for_fscache =3D 0;
>=20
>  	if (!server->ops->open)
>  		return -ENOSYS;
>=20
> -	desired_access =3D cifs_convert_flags(f_flags);
> +	/* If we're caching, we need to be able to fill in around partial write=
s. */
> +	if (cifs_fscache_enabled(inode) && (f_flags & O_ACCMODE) =3D=3D
> O_WRONLY)
> +		rdwr_for_fscache =3D 1;
> +
> +	desired_access =3D cifs_convert_flags(f_flags, rdwr_for_fscache);
>=20
>  /*********************************************************************
>   *  open flag mapping table:
> @@ -704,6 +709,7 @@ static int cifs_nt_open(const char *full_path, struct=
 inode
> *inode, struct cifs_
>  	if (f_flags & O_DIRECT)
>  		create_options |=3D CREATE_NO_BUFFER;
>=20
> +retry_open:
>  	oparms =3D (struct cifs_open_parms) {
>  		.tcon =3D tcon,
>  		.cifs_sb =3D cifs_sb,
> @@ -715,8 +721,16 @@ static int cifs_nt_open(const char *full_path, struc=
t inode
> *inode, struct cifs_
>  	};
>=20
>  	rc =3D server->ops->open(xid, &oparms, oplock, buf);
> -	if (rc)
> +	if (rc) {
> +		if (rc =3D=3D -EACCES && rdwr_for_fscache =3D=3D 1) {
> +			desired_access =3D cifs_convert_flags(f_flags, 0);
> +			rdwr_for_fscache =3D 2;
> +			goto retry_open;
> +		}
>  		return rc;
> +	}
> +	if (rdwr_for_fscache =3D=3D 2)
> +		cifs_invalidate_cache(inode, FSCACHE_INVAL_DIO_WRITE);
>=20
>  	/* TODO: Add support for calling posix query info but with passing in f=
id */
>  	if (tcon->unix_ext)
> @@ -1149,11 +1163,14 @@ int cifs_open(struct inode *inode, struct file *f=
ile)
>  use_cache:
>  	fscache_use_cookie(cifs_inode_cookie(file_inode(file)),
>  			   file->f_mode & FMODE_WRITE);
> -	if (file->f_flags & O_DIRECT &&
> -	    (!((file->f_flags & O_ACCMODE) !=3D O_RDONLY) ||
> -	     file->f_flags & O_APPEND))
> -		cifs_invalidate_cache(file_inode(file),
> -				      FSCACHE_INVAL_DIO_WRITE);
> +	//if ((file->f_flags & O_ACCMODE) =3D=3D O_WRONLY)
> +	//	goto inval;

Why to keep unused code?

Thanks,
Naveen

> +	if (!(file->f_flags & O_DIRECT))
> +		goto out;
> +	if ((file->f_flags & (O_ACCMODE | O_APPEND)) =3D=3D O_RDONLY)
> +		goto out;
> +//inval:
> +	cifs_invalidate_cache(file_inode(file), FSCACHE_INVAL_DIO_WRITE);
>=20
>  out:
>  	free_dentry_path(page);
> @@ -1218,6 +1235,7 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool
> can_flush)
>  	int disposition =3D FILE_OPEN;
>  	int create_options =3D CREATE_NOT_DIR;
>  	struct cifs_open_parms oparms;
> +	int rdwr_for_fscache =3D 0;
>=20
>  	xid =3D get_xid();
>  	mutex_lock(&cfile->fh_mutex);
> @@ -1281,7 +1299,11 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool
> can_flush)
>  	}
>  #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
>=20
> -	desired_access =3D cifs_convert_flags(cfile->f_flags);
> +	/* If we're caching, we need to be able to fill in around partial write=
s. */
> +	if (cifs_fscache_enabled(inode) && (cfile->f_flags & O_ACCMODE) =3D=3D
> O_WRONLY)
> +		rdwr_for_fscache =3D 1;
> +
> +	desired_access =3D cifs_convert_flags(cfile->f_flags, rdwr_for_fscache)=
;
>=20
>  	/* O_SYNC also has bit for O_DSYNC so following check picks up either
> */
>  	if (cfile->f_flags & O_SYNC)
> @@ -1293,6 +1315,7 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool
> can_flush)
>  	if (server->ops->get_lease_key)
>  		server->ops->get_lease_key(inode, &cfile->fid);
>=20
> +retry_open:
>  	oparms =3D (struct cifs_open_parms) {
>  		.tcon =3D tcon,
>  		.cifs_sb =3D cifs_sb,
> @@ -1318,6 +1341,11 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool
> can_flush)
>  		/* indicate that we need to relock the file */
>  		oparms.reconnect =3D true;
>  	}
> +	if (rc =3D=3D -EACCES && rdwr_for_fscache =3D=3D 1) {
> +		desired_access =3D cifs_convert_flags(cfile->f_flags, 0);
> +		rdwr_for_fscache =3D 2;
> +		goto retry_open;
> +	}
>=20
>  	if (rc) {
>  		mutex_unlock(&cfile->fh_mutex);
> @@ -1326,6 +1354,9 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool
> can_flush)
>  		goto reopen_error_exit;
>  	}
>=20
> +	if (rdwr_for_fscache =3D=3D 2)
> +		cifs_invalidate_cache(inode, FSCACHE_INVAL_DIO_WRITE);
> +
>  #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
>  reopen_success:
>  #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */ diff --git
> a/fs/smb/client/fscache.h b/fs/smb/client/fscache.h index
> a3d73720914f..1f2ea9f5cc9a 100644
> --- a/fs/smb/client/fscache.h
> +++ b/fs/smb/client/fscache.h
> @@ -109,6 +109,11 @@ static inline void cifs_readahead_to_fscache(struct
> inode *inode,
>  		__cifs_readahead_to_fscache(inode, pos, len);  }
>=20
> +static inline bool cifs_fscache_enabled(struct inode *inode) {
> +	return fscache_cookie_enabled(cifs_inode_cookie(inode));
> +}
> +
>  #else /* CONFIG_CIFS_FSCACHE */
>  static inline
>  void cifs_fscache_fill_coherency(struct inode *inode, @@ -124,6 +129,7 @=
@
> static inline void cifs_fscache_release_inode_cookie(struct inode *inode)=
 {}  static
> inline void cifs_fscache_unuse_inode_cookie(struct inode *inode, bool upd=
ate) {}
> static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inod=
e) { return
> NULL; }  static inline void cifs_invalidate_cache(struct inode *inode, un=
signed int
> flags) {}
> +static inline bool cifs_fscache_enabled(struct inode *inode) { return
> +false; }
>=20
>  static inline int cifs_fscache_query_occupancy(struct inode *inode,
>  					       pgoff_t first, unsigned int nr_pages,
>=20


