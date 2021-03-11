Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563B8336926
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 01:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhCKArZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 19:47:25 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46584 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhCKArR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:47:17 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12B0j5a0163304;
        Thu, 11 Mar 2021 00:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=KHRoWMPV6NxBj2DpCltO7H/o+EIiwzx9cPZwodyQUWE=;
 b=ItW5cLaNUVwnSGuXfDcX6dVJ20OR+sDDe/rL7bOatBuP/bC5WHAGY3/Qn+hhnz+TKp6p
 1Wk1wGRLhKR0rF+1xt1qUF+zUV/mz8k7cdvyV3wjA9+Ogjumo+HLNTfHX3NHYHfC9j1I
 vri85vumlwuyVnBztG1qapF/NCYdEIwySzw1rUjdAFJnWc0mpqWvyVmOsaXhjEScLuKq
 b4uuAK/2WUq5jxAoso6A97Z0sngM1GLowS7q9B26O2vkZJtTiQ/inU5zn5b5j9Eln1+s
 KbnSbAzqaxU38fw6uVV2nC9DL0xYb7WzV4ORRUfau3FBrKr9QfCxZyqwXRUuw2cETmdx YQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37415rcyed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 00:46:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12B0jaYc096423;
        Thu, 11 Mar 2021 00:46:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3020.oracle.com with ESMTP id 374kn1r307-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 00:46:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBpmC9cIPnAQevClPfiTaH/3j0k0sdCSBz1KBG3Hei1dxhHcW068171AljhnohyE/75iByA7dn8nfdSBwBlWO9RAMi1O0OSUK5dqdnbC1y9zvq8NmFaKEX4MnutWDtiF2+KYDd2Ws9Sa2PS3Wd63PzvKfBl79wnCtldWElzRTVQ7Ej7S5ctU6QticPa+bg/d+WoWjabdQ7gdbpGPDi992GPJyUnd1zsrdklKjFPKp27OotAuWdYL1pC8h76qfIbkl1byYnw5AmA0yG8BlER0fdMoyQeRlaeHi3c/eUlZWarO0JnjJFybRUpHdwp9MqUdZIvyfL/AoNUK6RLt8fLpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHRoWMPV6NxBj2DpCltO7H/o+EIiwzx9cPZwodyQUWE=;
 b=N1huQOUaOlEzpeCCqIiS77LH6jEJVMBKVjNNB9LF6JeDMQghqdhUHtPnlqSl/LqOWPQETEndqhdOLsE0MRxsiDqRaVCIJPF2QwVj/iwhBGuvmeC7Nn33UPaoPpatp57jed8v9aFnMyj9YcxrOsihvDfFaLmt4i+oAYdk1cKPeJY8+VCD09DqPNry/nubgP7vdGEvCO86FXLM4GzSHfuh70zdC7vhAXjkLclgJ4q/H4om6zKbdoARo/Zi8vkQ2TvT6+sB6MywmtuFNd4vJ9uexcvaThgNzLqJoC64PGkNmgHimX7yJCbWmV3aN8r79cn1i6Z5C0DQOYPM59AHzaC9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHRoWMPV6NxBj2DpCltO7H/o+EIiwzx9cPZwodyQUWE=;
 b=LNupYFac4Js3X9UKxlmmsfWMK4QfeISCdzoIyJn0OXiwxpZFMAkiX9VI1ZuSTtSPmZHrWImCuLuqmG/IPQJj2e/mx2mGr8gutB034PRFG6I3OK83biRVUNa2TvjrQz6tGW6Fy6jfBUIBqalaiKr6uBUXjT/RhT2GdUZq+RSfKTc=
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 (2603:10b6:910:42::14) by CY4PR10MB1974.namprd10.prod.outlook.com
 (2603:10b6:903:128::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Thu, 11 Mar
 2021 00:46:39 +0000
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::2419:5987:3a8f:f376]) by CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::2419:5987:3a8f:f376%6]) with mapi id 15.20.3890.040; Thu, 11 Mar 2021
 00:46:39 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ian Campbell <ijc@hellion.org.uk>,
        Jaya Kumar <jayakumar.lkml@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] fb_defio: Remove custom address_space_operations
Thread-Topic: [PATCH v2] fb_defio: Remove custom address_space_operations
Thread-Index: AQHXFd8DUx74Y2c7WkWgGsxUUGF/VKp99D4A
Date:   Thu, 11 Mar 2021 00:46:39 +0000
Message-ID: <E1B57D89-DD18-4F03-B6C8-5244854C3596@oracle.com>
References: <20210310185530.1053320-1-willy@infradead.org>
In-Reply-To: <20210310185530.1053320-1-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [2601:285:8200:4089:f173:2ef3:7312:76c3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f16ebc2-0435-4def-d2eb-08d8e42721d4
x-ms-traffictypediagnostic: CY4PR10MB1974:
x-microsoft-antispam-prvs: <CY4PR10MB1974F4C749A4B8E84AD50B0D81909@CY4PR10MB1974.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hyadoP76VuJdMJADcFqEYtTgrBJLAl998j4p8hKFJqMO+6OmGJus1NkYU5QZYqnvu+uHKKh78+lA1INtSOkv0mclY4iKQ0DZc0CInX6iCsp86fVBnu7qQOfSTkoEaMrta2wtn+jr+geoGncwaGW9C9TVe9COH1aZe6kjtlq0IhIdIWmtNUi8hICnILqpfqVkFBn93oYVrbVAKfVbQ4wxFzUCLkVIpQAGfskP7glR+5fVvewZhUW0x372vQdhAqBRLaLwXoY68H1+GnFHTfOHY8MMVSfvLgwhYlKue5ZpPo21xZxjQw4Ueq0jkSRZd0f96VzjXwpLzP45sE3/qaZhHY8rSldyJmNpgetWBVvg00GoeLE31M+ALvccGrfRtVV8cSvgcWDNXuUir3joQLqddPjwmhLfkBqjdnMyxjsC0H2cbG9ygr3P1+FRl75Qlkti8uVME0+KV5geg2AlAetS3oA7TkzEjshJFCPiuNyzrOy/UBBgugl7NHKUWKU5ClPp/ENecJgWuYYP5SsDvhS+mZ9khDWluTZPKsRUrU6ScUF2iV3eepGlYt51F2rZuSpZ8XSIKv3k6KGYJxMeAu9Q8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2357.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(39860400002)(366004)(376002)(5660300002)(6486002)(44832011)(8936002)(33656002)(8676002)(478600001)(6916009)(53546011)(6506007)(83380400001)(186003)(54906003)(86362001)(6512007)(4326008)(66556008)(66476007)(71200400001)(66946007)(7416002)(64756008)(2906002)(316002)(36756003)(76116006)(2616005)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VhxfVCEkwfrdCr35tCWLB4A/s04NfeDiwid93DgfVrDRwGeLdenxXmx0O5hH?=
 =?us-ascii?Q?KEEt8gf7bu/qrr2CexJdUmr0nVZRk5xTmiSBSBiXwrbOdR+bF+cEr6vdG+Hn?=
 =?us-ascii?Q?2P4mAqejdCSdjmcRWG6wlKNMDPVQxbH92mwqK7pF4R+GJP8IJl3fuZWPfuL1?=
 =?us-ascii?Q?P1P+A4SgrIMKk107YEz7fAhrjp/x2Cx5A9yPZou9jpWBQHLC/fcUqaZDnNNU?=
 =?us-ascii?Q?N4NUznEGmTKk72WD6Njva8dcbcT3JcKQgYc2sZsu7dxGICvm5/Y9+XMh383E?=
 =?us-ascii?Q?HnFx4WKFWqZByuuXxjm6eVNeTwqo8oP5GjTBEGpPd6q7kv170kGfNtAC7XIR?=
 =?us-ascii?Q?z32Wkom1L0SvynL6RJZ5OczW6IRbS0JrtmROUn0FdulajRC0iS03fz1UlR1/?=
 =?us-ascii?Q?/8CgrqILc1fTN6FNu28juBH8U39ifnVvfKoY/rx1Aa2tsbHoESmcA3ZuglSg?=
 =?us-ascii?Q?at0YLsNt+vFZvdwkY33AZzY2oPoOCw/rZKeqbw3KRDLazJwpzg6N1Mdhuvu7?=
 =?us-ascii?Q?zdGj5R2tWQ7MPR3n9B2yVRsv13kh4xFLOjtbRyAZrEzyfiNG5FOjoWkK8azv?=
 =?us-ascii?Q?aY7jWUmemWrKjhd7aHHlkLn3+55Pw3Ygiq9Es5A/RHtQDvC25PZiGCX/2IVN?=
 =?us-ascii?Q?Q5S+ZWXhoncWofsbX2hLLLkg1lAT457LQnPs+DS1xkqIfQ1bKewPpHHJNQzP?=
 =?us-ascii?Q?KJwgnmAUWnMM5BEkkcvdTOU9DSXQ95QNIUhj9XsM/fmt+6Er9EtoEK3Nw41p?=
 =?us-ascii?Q?MZyV6kUvCM1FhYG6oUdXp1+YH0zG+fOJCZSBYw20H4aKkIKWj8Xk4ViYMwyA?=
 =?us-ascii?Q?FDcKD7+H/46ZxaDlzVfbk6MCImB2CIwXQBNZvlONiKLDYu/RYSvepWUAGCzp?=
 =?us-ascii?Q?UeRxSgXn7YUUDZkFUeToczALvDOn/ZnKNnz/54ejhrahpsxrwECW7DyBQmAf?=
 =?us-ascii?Q?S8oUkjqGanX6dDuF57/KWl8HPTVBxfDR7n1Bbk//uFFaV2gl7V4XVvGc1S7k?=
 =?us-ascii?Q?yEZkOPbtYaJjNRmJdKT1gCXhwOhig7p0VDnxaCoySoCOdFB1oXNSDhrJ5jh+?=
 =?us-ascii?Q?MNro91MDZZGLlu6Q5hlugiPbOhhN/i9WgL7OpS7JfsE/WwGAI+EbfszJKpNj?=
 =?us-ascii?Q?X2pNpvJYKmWPkFf12yuOMt6dzgfUF/p0TsNkG00Tfqc2gH8+YMX92mPJ3X6z?=
 =?us-ascii?Q?hAb4CtXPar1dvpPcnBwuaMfRCEQkaBAnmE4prsSzBFKlysVKpAvcnb9FN0GJ?=
 =?us-ascii?Q?FIjl2chxbFyszbkcZH91o/syipH4+4ft0tLqiuhFzb9aoNaq6oh2uFt6KWjO?=
 =?us-ascii?Q?rAeHT3mxYZ68qb2b3oGIQB46rwZ6ovLnHwe3yAIQngsrQw770bA4zvl/vxUN?=
 =?us-ascii?Q?8X7AGvif3pBd2EZBQczpFL/ge6JrqYuU+dNjN8xCIgDtc0UPLg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <063165FBF91DBD4093DAE55DEC1D0A69@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2357.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f16ebc2-0435-4def-d2eb-08d8e42721d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 00:46:39.4019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4BfXjHrAdj+ang2FhmjW5KCiLDyhCEHKurAzZlUlXQaVt5BrLjyJTDSQYU/Vm5wW6An/UB1IG8a0QLQVnxtQUXugRZr1Yh5fI1xKYUgNhb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1974
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110003
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110003
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good; my apologies for missing the leftover declaration of struct pag=
e in the same routine which you also found and removed this time around.

> On Mar 10, 2021, at 11:55 AM, Matthew Wilcox (Oracle) <willy@infradead.or=
g> wrote:
>=20
> There's no need to give the page an address_space.  Leaving the
> page->mapping as NULL will cause the VM to handle set_page_dirty()
> the same way that it's handled now, and that was the only reason to
> set the address_space in the first place.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> ---
> v2: Delete local variable definitions
> drivers/video/fbdev/core/fb_defio.c | 35 -----------------------------
> drivers/video/fbdev/core/fbmem.c    |  4 ----
> include/linux/fb.h                  |  3 ---
> 3 files changed, 42 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/co=
re/fb_defio.c
> index a591d291b231..b292887a2481 100644
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
> @@ -212,29 +194,12 @@ void fb_deferred_io_init(struct fb_info *info)
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
> -	struct page *page;
> -	int i;
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

