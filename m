Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA2D308EAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 21:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhA2UrD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 15:47:03 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42484 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbhA2Uqn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 15:46:43 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10TKe0jM090725;
        Fri, 29 Jan 2021 20:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=S5spKdiN/MuwY9bEijHZ8bqh0kWjvVFu4jTZquLV38Y=;
 b=ha83YFJa/PR329NzqjhL6KlkENAQs+k2iOPFa0f2Sbk6KhOsCoUrb94t5znQhgFi4c/5
 GZcU0mMV/DN4ln7sXUcZlj6BJk9sxe5SK6YhTCNab3m270mhBcfhl/kJRxpn8qOCzlNi
 TEx8++SDquc9AP/ZzsUsLRJFZCVO0rpcpNRpUjCE0l2PONrBIWWEmD8LNb5jE5dVDszH
 u0ZXtkeJz4YNWjfWOHvwHpFeZZfqmon8niGIPBmWC5wb/GjDvdtISoYFyxtNA8xV3q04
 IqiO4cZ+9G3WuAN5tYvJsW1hF4oQYfMi/tz1rtWFEupzkDotESumdED5O560kA5MbRpN iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 368b7rb7hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jan 2021 20:45:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10TKdvtr008380;
        Fri, 29 Jan 2021 20:43:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by userp3020.oracle.com with ESMTP id 36ceuh6yxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jan 2021 20:43:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joKl0ExSLR5mlhmVsZ57VA0QgpMAdbZhYN3GJgOfW/2pg7pOXRsoPDQ8g6iSFBQANoUshw2HbBUMZlzBVo7ztnODRYu5WHmaLr9+3prKOxvX0B3tKAhqmX/rS7UmY6GQguSp/rAM7EaPFDLs0wrih+swV3ad6A8neyGWwsLVUZoUhn+6DXFXJnSToyIAnGvvTw3DA4SnDOjtIoe1EcDNiGUx+0N4zUCXlevt4Iq29gzw3GQwuQ90GU4G6TODcwbdciqPb9knM9Pp/FARePRM+zSWOE1pVt4YKCZMjd+c3d9XwOQ7+WYYg5l2pf6n3pbRSAOlgdaeu0BmNdDUhPC3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5spKdiN/MuwY9bEijHZ8bqh0kWjvVFu4jTZquLV38Y=;
 b=e8Kpx7bWaVUhFCx1FKYLJNzt0rQI509GovlHbnhEa1G9oojtOY+InUz+8p0xMpKg7Betd3g4YbxDC1sd9h2VUZJfXIrm3Gjz1rEZf+r030sCxPtnQAi0ZwmDD0+ReWgaPKh+Y62EBloQKrlGwAHLOqQsGlUArKV+v8BPxy3CgYztBq510YvZjkksPjrSPajk/OqvADU6jnWvLSmE/OJxPt0WzIK050pb6ED8C0iQfrezOtmqsBQguL33jWNKgEpbO7v4B/nIwlobYokQN6UG6lZnKxdclup8399rVNWgq3+1Hre8ewEIie/RqmXEAjf8XGQIu1kMj3Tz4r62/flbOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5spKdiN/MuwY9bEijHZ8bqh0kWjvVFu4jTZquLV38Y=;
 b=A8ggiJ6TlzURkwXOGEoel881ri2DOHHiCQ3r1nkisKEHYTOxlQ7i457cL4GWnOMZoMBDuLRQgrtCBn0c1WeeCJmYvEsYkUqU/bKqFdzrUaEh0pvXSkxX2MunMkyMalAHcT3f/y/axpN0CQLqPfdKGoZKAbIpjDSoP+gxFAWUvEM=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4388.namprd10.prod.outlook.com (2603:10b6:a03:212::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Fri, 29 Jan
 2021 20:43:37 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.017; Fri, 29 Jan 2021
 20:43:37 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Subject: Re: [PATCH 1/2 v2] nfs: use change attribute for NFS re-exports
Thread-Topic: [PATCH 1/2 v2] nfs: use change attribute for NFS re-exports
Thread-Index: AQHW9nSnA3biWk5MsEeVX3kj9quDKKo/EesA
Date:   Fri, 29 Jan 2021 20:43:37 +0000
Message-ID: <E33A57FC-5B34-4621-B4FA-55FD0B5BBA28@oracle.com>
References: <1611084297-27352-1-git-send-email-bfields@redhat.com>
 <1611084297-27352-3-git-send-email-bfields@redhat.com>
 <20210120084638.GA3678536@infradead.org>
 <20210121202756.GA13298@pick.fieldses.org>
 <20210122082059.GA119852@infradead.org> <20210129192629.GC8033@fieldses.org>
In-Reply-To: <20210129192629.GC8033@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 469c7272-4e05-4363-ba4c-08d8c4968d7d
x-ms-traffictypediagnostic: BY5PR10MB4388:
x-microsoft-antispam-prvs: <BY5PR10MB4388C03F78C724F7C630154F93B99@BY5PR10MB4388.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tBlog1wXSPKjc6rZ5/hChP6LDqyRaputcKTwyDg9QVP73tNg29N7CyAEXN3ngunbkdJqoA1FvoNx/OiAqkIBO2UsgDP39Dm8VviTlZA64RMWul/naPYHkGwlpz4HwgJTm1P5LXCvUS8S2gqFGwid/6FmsJk8OCuZYooENDwW0P7yfeYTgnYlQfsWyn24Iwk6dLdpzlVYKK1kBzIzoPduap9VX/bgR50tFSq+JHhs2km7p+yObxfs3eDkFvIVQ8s8nkW4+PVoHzqQKH9qy7qpZi+8byFsDk5Jx2zgeSs1VTC4I2ZkuJRs1ej06dP1iI5Z+ZI9bCykgMGYDKorXnSdsQgwJiUw4Da6qrcgVj/cvTlq0vRk9ugQEzNDnEuxA52Fo8+5p/q+XNKtKCPyCf5gtga+ORJCKLr9O8zXXrj06+8vfrh7AghGy08nRrsi+0B2RuWHpPHTrv2Nu7HaeKQm8rylQXggh5OyaPOl1idQkcUlWuOp+gqluOfeGktm9BEAE2eURHc/Zvvdi0xbTcVNqkr+WaKqANxvoHMu/vdICiL4MWtlTrwuP5btj/hu6pXJOywrAhqb8Cv2UuAUSGt/LQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(346002)(39860400002)(376002)(86362001)(6916009)(8676002)(6506007)(66946007)(66556008)(2906002)(64756008)(91956017)(66476007)(76116006)(36756003)(5660300002)(66446008)(26005)(44832011)(4326008)(2616005)(6486002)(316002)(478600001)(6512007)(71200400001)(33656002)(8936002)(53546011)(54906003)(186003)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LgmLjPTS7BAL+O1obYvvQ3w2JortRacGEEkXAdPHAh3GmlXBxkQMMmeNtVGU?=
 =?us-ascii?Q?/djcsvvGRPwnolzGnfoLZwshXiIlCWdsp6Z7brT+hcYfwNuKG5ywTXz+DiyK?=
 =?us-ascii?Q?LjTn+3xynyOFTn9pVnXoa3Q8eEe6D/0ix6WitrHubvIIkGb2KSrQ1WYauCrA?=
 =?us-ascii?Q?txx1P4LcLmGVAUapAVznxOYI8GPjQvTo4DQfIZ77AuCfhWudyJuxCiNNfPy/?=
 =?us-ascii?Q?GpwrUD85/nUJvwDnGu+9vo71mEJkxnMisFUXWXAW041+AFg6fpX+gs0Rcd5i?=
 =?us-ascii?Q?QFl/kyTv08rXpE0PgQvMwSHqlNaGgdsInu/gtZAus3MWOHFOvLLydEBCkO5n?=
 =?us-ascii?Q?0g5z+qwvBolZHXViiQj990cgzIRdAB07rm1EmWMqJofv8uGLTNDeC6M/aAR+?=
 =?us-ascii?Q?GQMkyPvFPCWSHqA94dCO5CohJFyzp2rH5ypJ4iNLEyavgH5JooMvFIZ6tXtL?=
 =?us-ascii?Q?Ebh1iyOig9c87uOKn6/p8CouITn9B3Gql1vAf3i4SByNxo/S2YIKfYgY1Maw?=
 =?us-ascii?Q?bpTGxt8zhRwE/w0RFAfs3igFreWOTZ/AfADmEvXEoHSwRnMm47vMtAOq6S/V?=
 =?us-ascii?Q?G95Ur4E+tSJBB3PRYq9osR1ejM0X5T4w/DAMJkYRblLLzJZU5UiePdtKDTpp?=
 =?us-ascii?Q?zpx62BkHmBKx3nN1MEtYr4UFGWKYswE08q9w4CkqnF/Xw14x3R1BGhzDE9mo?=
 =?us-ascii?Q?yzqbOjndnuxs7xtaHgINaCxvzhgvy0n+S77s2VV3aQ0YAhD2bZlaZkQfAw4F?=
 =?us-ascii?Q?VwyZNx7EUWTIdqk1klnI4Zvyr272TkXxmEGcRaq5g2VN64MToob7ACF9+uL8?=
 =?us-ascii?Q?yTIHgBT6pWF8++7RvV1JjOqhNTJKSCUBZS33InF3BkOdQIV2Cr18OldtcdrV?=
 =?us-ascii?Q?vYxPewwHhgsVme1bMdUbFUXJsVVZiPq7moSrX3f1dVyq54wfFydcDEEEzBdx?=
 =?us-ascii?Q?dkzhrtXaEccRgM83deOi6bUnfeFXP4pq6jUx81jcPoQmqPJ47gV9SSUHCyat?=
 =?us-ascii?Q?cwwDRdsvDXHXW8asecBZrUFudQ9ulGZKDa9A9V/77nCLcxcltMh3eQDT7nOg?=
 =?us-ascii?Q?F8MKcMLZT2MlH9AOekGUJIPRV6Px3w=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BA265EA3C5C19D4DAFAE05574DF26755@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469c7272-4e05-4363-ba4c-08d8c4968d7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 20:43:37.0432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Ht+mFMo6gG9SDJjXudUNUODuF5KRUMPm5hNwrByEnV3umC4R+Q1LX7mtHY1olMH6KORWHkYEbEkKXzwBVZzMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4388
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9879 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101290101
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9879 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1011 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101290101
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Bruce-

> On Jan 29, 2021, at 2:26 PM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> When exporting NFS, we may as well use the real change attribute
> returned by the original server instead of faking up a change attribute
> from the ctime.
>=20
> Note we can't do that by setting I_VERSION--that would also turn on the
> logic in iversion.h which treats the lower bit specially, and that
> doesn't make sense for NFS.
>=20
> So instead we define a new export operation for filesystems like NFS
> that want to manage the change attribute themselves.
>=20
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>

These two patches have replaced the v1 patches from last week in
the for-next branch at

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

These are included provisionally while review and further testing
is ongoing.


> ---
> fs/nfs/export.c          | 18 ++++++++++++++++++
> fs/nfsd/nfsfh.h          |  5 ++++-
> include/linux/exportfs.h |  1 +
> 3 files changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> index 7412bb164fa7..f2b34cfe286c 100644
> --- a/fs/nfs/export.c
> +++ b/fs/nfs/export.c
> @@ -167,10 +167,28 @@ nfs_get_parent(struct dentry *dentry)
> 	return parent;
> }
>=20
> +static u64 nfs_fetch_iversion(struct inode *inode)
> +{
> +	struct nfs_server *server =3D NFS_SERVER(inode);
> +
> +	/* Is this the right call?: */
> +	nfs_revalidate_inode(server, inode);
> +	/*
> +	 * Also, note we're ignoring any returned error.  That seems to be
> +	 * the practice for cache consistency information elsewhere in
> +	 * the server, but I'm not sure why.
> +	 */
> +	if (server->nfs_client->rpc_ops->version >=3D 4)
> +		return inode_peek_iversion_raw(inode);
> +	else
> +		return time_to_chattr(&inode->i_ctime);
> +}
> +
> const struct export_operations nfs_export_ops =3D {
> 	.encode_fh =3D nfs_encode_fh,
> 	.fh_to_dentry =3D nfs_fh_to_dentry,
> 	.get_parent =3D nfs_get_parent,
> +	.fetch_iversion =3D nfs_fetch_iversion,
> 	.flags =3D EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|
> 		EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS|
> 		EXPORT_OP_NOATOMIC_ATTR,
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index cb20c2cd3469..f58933519f38 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -12,6 +12,7 @@
> #include <linux/sunrpc/svc.h>
> #include <uapi/linux/nfsd/nfsfh.h>
> #include <linux/iversion.h>
> +#include <linux/exportfs.h>
>=20
> static inline __u32 ino_t_to_u32(ino_t ino)
> {
> @@ -264,7 +265,9 @@ fh_clear_wcc(struct svc_fh *fhp)
> static inline u64 nfsd4_change_attribute(struct kstat *stat,
> 					 struct inode *inode)
> {
> -	if (IS_I_VERSION(inode)) {
> +	if (inode->i_sb->s_export_op->fetch_iversion)
> +		return inode->i_sb->s_export_op->fetch_iversion(inode);
> +	else if (IS_I_VERSION(inode)) {
> 		u64 chattr;
>=20
> 		chattr =3D  stat->ctime.tv_sec;
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 9f4d4bcbf251..fe848901fcc3 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -213,6 +213,7 @@ struct export_operations {
> 			  bool write, u32 *device_generation);
> 	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
> 			     int nr_iomaps, struct iattr *iattr);
> +	u64 (*fetch_iversion)(struct inode *);
> #define	EXPORT_OP_NOWCC			(0x1) /* don't collect v3 wcc data */
> #define	EXPORT_OP_NOSUBTREECHK		(0x2) /* no subtree checking */
> #define	EXPORT_OP_CLOSE_BEFORE_UNLINK	(0x4) /* close files before unlink =
*/
> --=20
> 2.29.2
>=20

--
Chuck Lever



