Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B603346ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 19:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhCJSjD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 13:39:03 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41004 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhCJSih (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:38:37 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12AIFfjY152118;
        Wed, 10 Mar 2021 18:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=a9nPg0HfV8oTEWBfBECj2Xa9RNlb1IqRQL2i/ZTgib0=;
 b=JZuWFnLfqevxOFvnA8zjCDZqUZ0eTSbHVwCjdqsm/BxF3bXcb7TM1hrUNUz0bz3D2gok
 apPwj08QJwF/bJN0Lusyq7M73w/AZ1soL/FgROkipA9HWflcfP4U7LkxrWP6ZEgxadH7
 ZQRBGCbeD2ktZJ56MGeHMTWIl6EKLOleF4KJVCWPl1vy5jl1NCNdYasa9KqMpTO4U/DY
 UiI4tUAptbo81hFamkUOO+kxfB8TCht3zV5V0uHPkh+eAZ3jER6a1Cp9Mk6jbIyeaS4h
 68fbmkUePtbxSoGOBzra/va9s4Rv+lschBJLx/oz7S3Den/cRsbh5I3AbMW0Dl0kZaCX QA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 3742cnc04c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 18:38:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12AIZT0K115279;
        Wed, 10 Mar 2021 18:38:09 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by aserp3030.oracle.com with ESMTP id 374kaqm6yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 18:38:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLrgLJ2TkAuGIh5ycImYBen2ji+9cBgvgleAFqYCNHrB45E40aPTa6dk14bqujFcDHaDbkwTJuNw7U1KEeYa156i+CcBu32dFVbfIaUxfkzbTYZaGnWkoTgjdZcPNHFv3Mke6pCCwJveZL1opxal9pHDAoXYT8+x1dO16nuEJCyvZEgoleRAt7hvcGCLl62KEFxt5uC5TlCNYolOobLn7a0asSfoyanI05QV7FELdq93dK+OzDJXO8EgcDJAiEN35Pk/9ZS7kkNfbukh3SqRxjlSeo9om9l82K44c3Pmkqx4be9q8vwaaZTnMMfaEY5B04EFIjaYKE2zOaNlfvpYBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9nPg0HfV8oTEWBfBECj2Xa9RNlb1IqRQL2i/ZTgib0=;
 b=Lm8WAfu0MFxuwnKb8vp4As86emp6phokegR0Ajn+Gh5ymRaQ81yl6FCA1uiturnfRk2zzXOyyp+rcbuGMrgmmUVDcyUzvBydC3KAgfVTpgms75ECsgJOZyw6XaW1DRX4gG3utoTw1NvvqMsQ9VtP2aiAE75TpKu3vHZWjHQ0ehXmkjWOEsztDeNtTN2QeJhS03bs3h/7ANWNgV1g5NhFfNTgOWVSp6Ox0Fur3AZBX9EPcY1qiacIt1HWJO6UFH+CGGOn4vIeklv1y4S+8kSmz8BoFbeB6Lb+DnwCzVpOo0vNXchC0Yorz0mr8qPn/+17qIKhhZ1SL9InuKJKh0w8YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9nPg0HfV8oTEWBfBECj2Xa9RNlb1IqRQL2i/ZTgib0=;
 b=VDbOBzWFWfovFfOVVbkHInymrq7InnTmgzQMe5j1E9x8Vz+6qoj6ZSd/PhPysYdWZAIVOA6VzmnRV5TAsL9d6QsmaLZ7IqwKWBYnOaJYbSmxiz61/xUTq0B5200YndVDyUvZ0x0e5R+v2Yuc3li/R8T9yQ1shhCsqEWX5Q5jJ48=
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 (2603:10b6:910:42::14) by CY4PR10MB1367.namprd10.prod.outlook.com
 (2603:10b6:903:2d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.30; Wed, 10 Mar
 2021 18:38:07 +0000
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::2419:5987:3a8f:f376]) by CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::2419:5987:3a8f:f376%6]) with mapi id 15.20.3890.040; Wed, 10 Mar 2021
 18:38:07 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ian Campbell <ijc@hellion.org.uk>,
        Jaya Kumar <jayakumar.lkml@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fb_defio: Remove custom address_space_operations
Thread-Topic: [PATCH] fb_defio: Remove custom address_space_operations
Thread-Index: AQHXFbSTLJVxpQqXLEyrPHFc/L2Mrap9jZwA
Date:   Wed, 10 Mar 2021 18:38:07 +0000
Message-ID: <B2F0192D-2C63-4BD0-8B5C-461361C7F0DD@oracle.com>
References: <20210310135128.846868-1-willy@infradead.org>
In-Reply-To: <20210310135128.846868-1-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [2601:285:8200:4089:486a:88fe:ca01:b371]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c8b5a49-ad6e-4e8b-54fd-08d8e3f3a616
x-ms-traffictypediagnostic: CY4PR10MB1367:
x-microsoft-antispam-prvs: <CY4PR10MB1367E81FDB351C02146F3EDE81919@CY4PR10MB1367.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 59LMikbBkMgIKvJiY8pN+viHayEeziN8wxqE9qDEiFju6zr5E2jAKGGxfy+I7Akkroik/TF2EgbQelagJTUupuoJKRFcxBKPOwvKmL/hpAd+H1RNkh5retRQoTf4dqkvifcJ1CRwbkB7HorGsbv3EHBfa53tXDkUZXjzPe5L3SAwt0m0y5FpFzoMuM1O/yv7K0SinU4UdqpSvqVT/aDz+lvLZ1nxFwZ+NPCNr36tOXL08+JWGG8scYcO5bNpFRXSU0UyyFEQRUOdzGJhRQmGgewIKESJZ1TtTEZrIseuBqchify/f9E7+E0gx1+u25ujZgK7HXSVPJwPU5B0y8m2+ObD2uPoP8IIH0JQhA+XURYdJf2AzibuTM477gKg6tK/V0Fk5yMYARb1BaIt66Ri21rpGQY2aGqJiy7F3Mlo1hblO4pLCSiovIWbJ6+3vq09YqkuMIsI2Fu7ya5LED6/iw0MLEsmq8mh3K2pXzDYNkkuFT2AagKxHidAQw/Y0+OWC62MSMO2k0/MyUVOL25QVZlSkr5u/6N4nkax9bAia8YtkdHujAbg6BbmIJMZ9ij3Nm8ssW6+r9dzOrhIkgd+2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2357.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(39860400002)(376002)(53546011)(8936002)(71200400001)(44832011)(36756003)(64756008)(66446008)(66556008)(6506007)(76116006)(54906003)(83380400001)(2616005)(6486002)(6512007)(66946007)(5660300002)(66476007)(316002)(2906002)(478600001)(7416002)(86362001)(186003)(6916009)(8676002)(4326008)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kR+Aju5bQbraTPYgZTPhEh4i8taPmhFDWRYW+tqcc8UxI+uDdp2r/WAAObEF?=
 =?us-ascii?Q?6625/k6J3pTO8nHU0NlEnwniwXS8/AbiKwQAUqrEvJ2gSTGTsfn+PzE2zFVA?=
 =?us-ascii?Q?S1HyUNc/30b1XHbiDWIqwY+vN/91YSpGcvWazRFEN2Gi4YN/I+jJPwpO74rj?=
 =?us-ascii?Q?U+YZcXhozob24XKraHhtAiws5Bfk+/QldmCNyjaCn6/zxEm87Wm8HkFtlEYL?=
 =?us-ascii?Q?6iGDl0zOSqeSFm1c9z4VPv4Tq+98HCC8uAqrCb/iPzjO2VSesOWoLY6zk/d+?=
 =?us-ascii?Q?mv7XNrieV27VF5MRtueAxMjPKVa8auqDsly4gq4Dn+hPKn8A7h0g/A//Fs8N?=
 =?us-ascii?Q?1Diy032jOt/s3td9GPds3N2SVd4JkW3zhHhPwhJbGbaMW2UQHwxwYxCmG1U7?=
 =?us-ascii?Q?5VqUYe2NFj0OckKE8as8Cg45izmorssuP6qfcB7R3m+DiJ4ZqczKC4qkFVre?=
 =?us-ascii?Q?s/xf5RQ6MTpAv+aJJ4uTeo4qfYN7vE1yAAf7krx0BwJk5yDxrWhBu3g3NrdR?=
 =?us-ascii?Q?6Y5PrxQlFa0DeRNszIpVtI2ubkuEDLmxyT15qTnb2xePQIZaDxT3G3hzYqVn?=
 =?us-ascii?Q?ZzZh+HQ0vz+HfJ7YgFE4goG5cfBElGj1iobCf+0M38hp3VXhqSIJinq4A+31?=
 =?us-ascii?Q?uZ2IeXIYJugj0FxdxZCjvTX0jGiYoVuw22/lyCawmQ6ZahtrPF7epTCbmDcF?=
 =?us-ascii?Q?JItK3epPw7Ywgr0wWjs6jV7Mtr1nUDbws/yXYPBaW4RTBSDCXJ1iAWzqQDMa?=
 =?us-ascii?Q?HIL6TgPp9Tp7OCgHQBNr8ZYb+tgyk6h8QOO3n4S8mv/B7G17CNF/zMQn8X0S?=
 =?us-ascii?Q?czQ2SlTSvmOUJUnjR/aZ/d86swsOTwa7i8sUDF60v57ItY5MyantF+PB9Gr/?=
 =?us-ascii?Q?lw3qgLdgnhKBnwUYsfRLhftaK4IVv/UlCCbvqA50P73kGxoIZD6HLTqszGHP?=
 =?us-ascii?Q?hzJGeUAfqy+HHUekW3mKwIP1CK1DaL52c0y6JII9HUEsXybTIYB4uWBLyw+O?=
 =?us-ascii?Q?ATii3HHa5cjPgx7P/muKaEFxZD5+FB6tv9fAzqPsJr/KpnTutwHbI9dvGmDT?=
 =?us-ascii?Q?J6jIW9PIeMIo4gtlgMGF+yibG5FPc+ikNfieIZFMTEQDr+kfKrOn/THEILF4?=
 =?us-ascii?Q?gZeGox63BJCRPCFcAYdqj4yZJcFZPVBMStQg3vqaneop9C+AqpwJAAI8ybRc?=
 =?us-ascii?Q?7xVghCdCu4jJmIaKE7ur4vnv5AbH7qsSNjCQRf3o6OJCyVnlhnbgEUO3QcCq?=
 =?us-ascii?Q?x2Tn3zFXGiCXklUjcoh20xvuoyqJMw4Rb2D2APKU49m0OoVTdoD0jI4nFAXz?=
 =?us-ascii?Q?Ltgocyi/vReTCpp70aXQyJOX4+PDNmp863SHfj2vxxCeQmVBPBuhhuMY9tkm?=
 =?us-ascii?Q?maNWDF0aTOTvnkjQk91CMqBNjwBDrUuFGfeLFCgBp4ftjP/bQg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E28E0865EB87F64FAEF61061B639F5B6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2357.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8b5a49-ad6e-4e8b-54fd-08d8e3f3a616
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 18:38:07.5315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPtiglbIcnaVHgd/gn9ITQE0wzevHs4Xq8CCzw4++YqnbIH3bxFWIE59z3T7REL9XlQi5d2F+r/cd649B7fgQsQ5Qr5AWZ3grdFjsYQgsKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1367
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100089
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1011 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103100088
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good, just one super minor nit inline.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

> On Mar 10, 2021, at 6:51 AM, Matthew Wilcox (Oracle) <willy@infradead.org=
> wrote:
>=20
> There's no need to give the page an address_space.  Leaving the
> page->mapping as NULL will cause the VM to handle set_page_dirty()
> the same way that it's set now, and that was the only reason to
> set the address_space in the first place.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> drivers/video/fbdev/core/fb_defio.c | 33 -----------------------------
> drivers/video/fbdev/core/fbmem.c    |  4 ----
> include/linux/fb.h                  |  3 ---
> 3 files changed, 40 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/co=
re/fb_defio.c
> index a591d291b231..1bb208b3c4bb 100644
> --- a/drivers/video/fbdev/core/fb_defio.c
> +++ b/drivers/video/fbdev/core/fb_defio.c
> @@ -52,13 +52,6 @@ static vm_fault_t fb_deferred_io_fault(struct vm_fault=
 *vmf)
> 		return VM_FAULT_SIGBUS;
>=20
> 	get_page(page);
> -
> -	if (vmf->vma->vm_file)
> -		page->mapping =3D vmf->vma->vm_file->f_mapping;
> -	else
> -		printk(KERN_ERR "no mapping available\n");
> -
> -	BUG_ON(!page->mapping);
> 	page->index =3D vmf->pgoff;
>=20
> 	vmf->page =3D page;
> @@ -151,17 +144,6 @@ static const struct vm_operations_struct fb_deferred=
_io_vm_ops =3D {
> 	.page_mkwrite	=3D fb_deferred_io_mkwrite,
> };
>=20
> -static int fb_deferred_io_set_page_dirty(struct page *page)
> -{
> -	if (!PageDirty(page))
> -		SetPageDirty(page);
> -	return 0;
> -}
> -
> -static const struct address_space_operations fb_deferred_io_aops =3D {
> -	.set_page_dirty =3D fb_deferred_io_set_page_dirty,
> -};
> -
> int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma)
> {
> 	vma->vm_ops =3D &fb_deferred_io_vm_ops;
> @@ -212,14 +194,6 @@ void fb_deferred_io_init(struct fb_info *info)
> }
> EXPORT_SYMBOL_GPL(fb_deferred_io_init);
>=20
> -void fb_deferred_io_open(struct fb_info *info,
> -			 struct inode *inode,
> -			 struct file *file)
> -{
> -	file->f_mapping->a_ops =3D &fb_deferred_io_aops;
> -}
> -EXPORT_SYMBOL_GPL(fb_deferred_io_open);
> -
> void fb_deferred_io_cleanup(struct fb_info *info)
> {
> 	struct fb_deferred_io *fbdefio =3D info->fbdefio;
> @@ -228,13 +202,6 @@ void fb_deferred_io_cleanup(struct fb_info *info)
>=20
> 	BUG_ON(!fbdefio);
> 	cancel_delayed_work_sync(&info->deferred_work);
> -
> -	/* clear out the mapping that we setup */
> -	for (i =3D 0 ; i < info->fix.smem_len; i +=3D PAGE_SIZE) {
> -		page =3D fb_deferred_io_page(info, i);
> -		page->mapping =3D NULL;
> -	}
> -
> 	mutex_destroy(&fbdefio->lock);
> }

We no longer need the definition of "int i" right before the BUG_ON().

> EXPORT_SYMBOL_GPL(fb_deferred_io_cleanup);
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/=
fbmem.c
> index 06f5805de2de..372b52a2befa 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1415,10 +1415,6 @@ __releases(&info->lock)
> 		if (res)
> 			module_put(info->fbops->owner);
> 	}
> -#ifdef CONFIG_FB_DEFERRED_IO
> -	if (info->fbdefio)
> -		fb_deferred_io_open(info, inode, file);
> -#endif
> out:
> 	unlock_fb_info(info);
> 	if (res)
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index ecfbcc0553a5..a8dccd23c249 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -659,9 +659,6 @@ static inline void __fb_pad_aligned_buffer(u8 *dst, u=
32 d_pitch,
> /* drivers/video/fb_defio.c */
> int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma)=
;
> extern void fb_deferred_io_init(struct fb_info *info);
> -extern void fb_deferred_io_open(struct fb_info *info,
> -				struct inode *inode,
> -				struct file *file);
> extern void fb_deferred_io_cleanup(struct fb_info *info);
> extern int fb_deferred_io_fsync(struct file *file, loff_t start,
> 				loff_t end, int datasync);
> --=20
> 2.30.0
>=20
>=20

