Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8F35A5074
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 17:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiH2PrD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 11:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiH2PrB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:47:01 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC90876A7
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 08:46:59 -0700 (PDT)
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TENqk2004171;
        Mon, 29 Aug 2022 15:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=KWq3RUryUDfUWkaO48R+XgTCoOYNWjfQeiLfwea+PG8=;
 b=FoG42Kgzk57Q0kRzVqn6uUZ0fTSa79Y/kJZWaFCOL2wCuWLsoTpqSZYyrlSEyEaCVC0b
 NytYbkNpGC2u7KDUTC6W31vEyIlBHIcJzFl6tA2H6oMeqAYDYZNKRtCCABR6RpIJSYpJ
 wXGex+D4pDlBkNYcHylHm9DIQazUqsoPBwMDNTRCRxRsjsjvwraF919eXdZsmq+3tGue
 PlkTJCnLmmCJpRt0j1PGaMgIX2Sy10Ep/wS3h7YMbqheVHCZWaSLTW76HTlIffVCQvfR
 Vbgh+V/mnPJ9mdNOX9RpW0B1VCRr3hFaCDmh2+5WE+8G9ppyr8N/px5Dx0q18TjoS0WC Zg== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3j79fh1xsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 15:46:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fc1ZC33t+K2omiM+//gxw1GL1zC7Tn3XzjuBBDBj4K4fxJsxWT1+YD0Cg0q9+pnn47ec9F8urFXS0SxosqcJIOAYHz+VKfNYWBeTACZIZZcxlIU5NsjanhCz9G3DuTqJCanqcayLHWAejyR51AoF8Q0qqPKMnVyD/xs1JGhVjrzcszLpQPr73xA4bp0tqSwGg7EVcRnOp6SfQ4WRam4oXVNpWUESw3a69z8RjODaSpLRZ/k5gHTcdaL0CX6sgr0iP64M3cOB2/8P4kU20MhdPfyg4MU4cw23EzpjcyQBjWdJhK0yNd1ONmnEJ1L2v8j3ElpgCmbXe4wa2pmi7FYtRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWq3RUryUDfUWkaO48R+XgTCoOYNWjfQeiLfwea+PG8=;
 b=MWoWKlLS1OZwjHjUV2X3kcHp6sut4D3D8oHmtz+DTnu+VHBuTw7JG5sNiXieutqSG2VPnhXeK2wz7RUbFvWFKu8wUTpsBuseatzZY8GlN6vDppe/MPZoN1Xe2cdvtUA23CU3FjD7FHwcGF9ox65R/b6AowofjzW6pUGr3VCeX5e8BRFx34nGp5GfgcAZ5qQyogbkvW+2tID5RC5TKkZ+eeVTyjMthDsIL8i2UWSJjVZZri4VQQbYSbqCutxNq+fesZYnytx4UGFKxUMR9uUVGf2M8BcuWddY63OxJiBxKaDYDx243uUMQ5SMCHidTEMi3gK9Av5kUhg1WC5D6Z35hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by CY4PR13MB1527.namprd13.prod.outlook.com (2603:10b6:903:12f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 29 Aug
 2022 15:46:37 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::84ef:e0b7:d15e:8095]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::84ef:e0b7:d15e:8095%5]) with mapi id 15.20.5588.010; Mon, 29 Aug 2022
 15:46:37 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Petr Vorel <pvorel@suse.cz>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>
CC:     Cyril Hrubis <chrubis@suse.cz>, Li Wang <liwang@redhat.com>,
        Martin Doucha <mdoucha@suse.cz>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>,
        "automated-testing@lists.yoctoproject.org" 
        <automated-testing@lists.yoctoproject.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH 1/6] tst_fs_type: Add nsfs, vfat, squashfs to
 tst_fs_type_name()
Thread-Topic: [PATCH 1/6] tst_fs_type: Add nsfs, vfat, squashfs to
 tst_fs_type_name()
Thread-Index: AQHYuavtLluMU2mGO0CYvkTjQ0mLnK3GCX0A
Date:   Mon, 29 Aug 2022 15:46:37 +0000
Message-ID: <BYAPR13MB2503569ECEDEAC432FBC577BFD769@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <20220827002815.19116-1-pvorel@suse.cz>
 <20220827002815.19116-2-pvorel@suse.cz>
In-Reply-To: <20220827002815.19116-2-pvorel@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1449c0dc-b519-4ae3-0b05-08da89d5a8be
x-ms-traffictypediagnostic: CY4PR13MB1527:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aEbOwfsxScuD/zzXA5oBV2QpshTzdsp3ieXeUZ7u4jKimCWay0yZbvlxWWjFYz1CbCOghBGLVdyRJXfdHx38blNfAEmQHI0Xe3ljGguBiIzBQejf6A5I0VGkAhkhPLPqsiOV08ulpSkWGMXYKjLYuisx93/xmu/XZ3x/tpxXP9/roxKpajW1qUIxnyr8D+Ho4Ic7HBxcZBAzFeXBdoXM87HKkmmAqHLpQWKINADoOnn61US2pnUZNedBfO4pBe3bsOO8RFq1ni+9kq6Etv/O+WBxGtgd31lVCypxvtXVPC0Bhc/Zsb1n28Z6H1vrnL9prQssN3d3i2RPqEe14udTyBjLU6GqEIY1wqPcCvuz4l+G1MZCZ7NEg5qWcA+oxqJgsGMrElJgqhZ85CyRcUAnf1apkDPxdhrDLkjkPmVEUV0NSOM3Tr52cNqeW9R4OLMPWdmeTv6xtcyhgn8iPN667TYPsS/lqNwTIeJndnQRZcH0Oic4qxPUrA1CjwQOKcJrMfE6RgiFECYukCI4o33u0lNdYrrD/cWtBv4L7J2Bki0eVj1fv9AhwE8XZU+Wt6H+gS5dmngkNbfPReenLSK3DfFnwLO0GredT6NmlTnEJinGZx4nMLORKqyXWwebqjSOt10lMsYQiBRzqBe5qh/bdYC68R0ZxXnMS2PRVUCJ+v7Mf5SiS5i0nOuaGatl2F0hM4fcfdL09uMAy/Cf8gW1HOHcIVu7SMF8DpaZBwou+OQO73TpKtxRhxZqI13vZUwVnb8Y99fQRW7RY5VhxL7X+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(6506007)(7696005)(122000001)(38100700002)(2906002)(83380400001)(55016003)(33656002)(186003)(26005)(9686003)(86362001)(8676002)(4326008)(66946007)(64756008)(66476007)(66556008)(76116006)(66446008)(316002)(71200400001)(54906003)(110136005)(38070700005)(52536014)(82960400001)(41300700001)(8936002)(478600001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CGSGYIdIbVY4YWXJAgeja3q4+5xr/UbJ3z2gAU3rLplp07Ro72p1PPFPQo/l?=
 =?us-ascii?Q?se7kPEsivaAoQYZMkpSRWE+v15Zaakx4aOow3GZ0EpDvqmtWmZeHanp0SPgX?=
 =?us-ascii?Q?qTZi1xJSZUUWO43zMBAvRwVzSlyoKhG/DB6Bu8Ngx8FcPDlEjKqUa0A+n4S1?=
 =?us-ascii?Q?8Z3g1f25akYG7kWFMZIncFcC0mg9W0T+z/mKsHRsApOmZGuvFhGWDnVKvtoA?=
 =?us-ascii?Q?Nrj7ZjkwR04T4BkDpY2nwFVNu5zkNqQS0I2R6oRuWTDIeXSW78ir1QXyVMBZ?=
 =?us-ascii?Q?T9ermyBLrhvbwzN1XZ2Nuzixptb6qddnMRC/ZNuIdpjgDHy3Su7YetKykg8e?=
 =?us-ascii?Q?HLS6zy7oHqT7ik3gTwL0gY8kgSyZLbOMA4pnrKhe15Uf8qQLwBIfFk8oXclw?=
 =?us-ascii?Q?RzZh/Rsik5MvmIlQGb6p0x9HM6W1N+oursKG8D9xv4ddXWFqB5jOEnS7UVHo?=
 =?us-ascii?Q?U940iGMXlVmU2fWLOYGFLTUpPJkpd8hjHDaNfhq4JjQ9YBePaupm0rmBhAfa?=
 =?us-ascii?Q?tc1iy0+PpO0z8owaSQClvVtCGe08JOHNGPQnPYstD7CPj6GFOFLRtkqfvtjk?=
 =?us-ascii?Q?ud/DlaVrq+23v3ycr/23PRPnU+eoXUACGknwvo0Shrw+Ip3/7OJSkywRMRcL?=
 =?us-ascii?Q?1rrnmLWEajiaKBcrDMwV6HjPP58qhqdQB6JAItBGfF2wSSzltxBT+uouMSo5?=
 =?us-ascii?Q?/cbG2NgIBm2f1G1yJXCrfmcSgOn3eMlSavlvFf6mWLS4sms/hLoVnFGN3FvJ?=
 =?us-ascii?Q?GVBLRkLoaRo9CKDG9cN7HoY/OLxi5QjjiZCNYtpvVKXPldMMugYrmIRetCZ9?=
 =?us-ascii?Q?gGXSkAtBAd5uvRuEe5GJdUub/NXvly4c9ejcimsYVzDh+xLK7Mw/+dPeH5og?=
 =?us-ascii?Q?MPMvfKOVhSpsMFIxEKWoiH4j4nbkjX6d65tAAX+5qk0qaTGRTupgC7ksbtz0?=
 =?us-ascii?Q?rq+mR0Ba8xvGdGYwiUBOLVFlFeiUW9MXgVgAqsFRKlwT//DgbHoMBlVljcoa?=
 =?us-ascii?Q?Odk3CxRzX+FLh66PhlK8NxrJQyefNE1M7EhBdoG0FeTa3z9uEMzkb2JM1b3d?=
 =?us-ascii?Q?bn3HQlkTbIETHuuY0Tu0dMmUVKJy4IXwpOZld7K028eNICujYu+b4DHIeN8K?=
 =?us-ascii?Q?uz6o4iFM3ws7Bce4q1bZbJuZVBZdZ8FAilbX5ArvYUggQDcprGuhbLSfxUzw?=
 =?us-ascii?Q?7ThhsdsrEUGWHCs/U/5KCP+hEO/1WuIW7yRkccei/7z8WXTM9rRF9HC1knCP?=
 =?us-ascii?Q?HZl/EnWKvChib4aH1qh1wBkLlhpDsKn5ES864/yS214/kHbbENM1zdNVpTOH?=
 =?us-ascii?Q?Rws/g+YTO9GSyZLYcWY6eUgbvud4QQ+srZwovRkrfw2HhYKXp4S+DJ3Mz+Y1?=
 =?us-ascii?Q?X3oPkQdQsz/cbzEfFuTCKiq0XQSO6h3xjOnwRJ3sEa5NbPYsIMK6qXZP84Zr?=
 =?us-ascii?Q?f9oGrqB5Pzw1bZLvFFBKx+IO5julmD6wbaYD6FBHlgKZ30vkEGYX9TVTfpz3?=
 =?us-ascii?Q?TQw0SS9ygjWQlUViiY6vAMNWbdWLS2JyYVLYVUlNrQZB/avqTgMugeBh4Pox?=
 =?us-ascii?Q?8VgRup0FDnEsyrvMOWnQ2+H6gpEsTK62B129HeF/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1449c0dc-b519-4ae3-0b05-08da89d5a8be
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 15:46:37.8256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KE4zmYLzna2Ee1dLCRjALIsdbHIrPW0meDH7IcxZYlYCiz5H820jocSZyA0PLTTyh3e9WgwNd40sIdcVC64mTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1527
X-Proofpoint-ORIG-GUID: fBD5KNeGde7RtkfLOcPT779wo0tG-JWK
X-Proofpoint-GUID: fBD5KNeGde7RtkfLOcPT779wo0tG-JWK
X-Sony-Outbound-GUID: fBD5KNeGde7RtkfLOcPT779wo0tG-JWK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_07,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Minor nit, but the subject line has nsfs when I think it means ntfs.
 -- Tim

> -----Original Message-----
> From: Petr Vorel <pvorel@suse.cz>
>=20
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  include/tst_fs.h  | 5 ++++-
>  lib/tst_fs_type.c | 6 ++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/tst_fs.h b/include/tst_fs.h
> index 8159b99eb..a6f934b0f 100644
> --- a/include/tst_fs.h
> +++ b/include/tst_fs.h
> @@ -5,7 +5,7 @@
>  #ifndef TST_FS_H__
>  #define TST_FS_H__
>=20
> -/* man 2 statfs or kernel-source/include/linux/magic.h */
> +/* man 2 statfs or kernel-source/include/uapi/linux/magic.h */
>  #define TST_BTRFS_MAGIC    0x9123683E
>  #define TST_NFS_MAGIC      0x6969
>  #define TST_RAMFS_MAGIC    0x858458f6
> @@ -32,6 +32,9 @@
>  #define TST_FUSE_MAGIC     0x65735546
>  #define TST_VFAT_MAGIC     0x4d44 /* AKA MSDOS */
>  #define TST_EXFAT_MAGIC    0x2011BAB0UL
> +#define TST_SQUASHFS_MAGIC 0x73717368
> +/* kernel-source/fs/ntfs/ntfs.h */
> +#define TST_NTFS_MAGIC     0x5346544e
>=20
>  enum {
>  	TST_BYTES =3D 1,
> diff --git a/lib/tst_fs_type.c b/lib/tst_fs_type.c
> index 9de80224b..de4facef5 100644
> --- a/lib/tst_fs_type.c
> +++ b/lib/tst_fs_type.c
> @@ -88,6 +88,12 @@ const char *tst_fs_type_name(long f_type)
>  		return "fuse";
>  	case TST_EXFAT_MAGIC:
>  		return "exfat";
> +	case TST_NTFS_MAGIC:
> +		return "ntfs";
> +	case TST_SQUASHFS_MAGIC:
> +		return "squashfs";
> +	case TST_VFAT_MAGIC:
> +		return "vfat";
>  	default:
>  		return "unknown";
>  	}
> --
> 2.37.2

