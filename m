Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25809731FDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 20:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbjFOSO5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 14:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbjFOSOq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:14:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341C110FE;
        Thu, 15 Jun 2023 11:14:44 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGJmTm028531;
        Thu, 15 Jun 2023 18:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=uu75wV5FOwkO+LhihfUZHBrUCH1Pmh5mXigMtVkC2LU=;
 b=SlXW4viyFml1QIwpUrRzkeolHJYj+q9cEWZQHeZ6ta6+pZr8SwG60pzWsxT151zjMkAb
 Lt9VXXgh19ogX3ivohM6CodqnpzE6O8XrjaQIQbjO5vI3iBgIXDS/amVIpOKQqnXi+kO
 8kOI2kC2qtV/uEMGLlJlimij4vUr/EbYcPrqd4NTvPRRbChy4Np/Y7eKCVQIkmePuE6E
 SURIA0Bmo6/zKz4Q8yYyKR9Yi5VR/X6MVpm90R+hTRshkQLMFNi+P9Kdu2wWnnFdm33g
 5aOqIvRtv2htAQsIfYTeUIiEEw/0AOXLSVIOWmiNaITLBZQAk9wgsLFz6NlnZQ96CQmu qw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3btsvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 18:14:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGUupm009578;
        Thu, 15 Jun 2023 18:14:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm7jq12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 18:14:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfgTM9MiHeCWPhZQ6gD6I/Vm0ocCM1vbxJxgM3tA1t2D0n/cSIW39E7yOnxkwGYLi0rrXxSZbbg2Ya5V9B9CfFoVvEOm/CuUFqyacDiAyttjgIzoEY2LJEj2ICNvggISu9Cn4Lwpj2nocsMuYcDIrQ8yv4pymnx+hrng5XMlo6nhFKQvjJ0wKFbHXUVdB0G9q5aTiXm4XzYzlyXWyFURni1n5P3msuWHZ055AoZ2qZZgnf2I3O/J5Ek7BXca5yWBWYUFN6Ak7PZS7IS+Tor3VbZFeCiyFUJuM1qeyMz3F/VxxnRCpnneabrn1XlpdtrJwsHfDqFNNm7Is8PNyLqc5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uu75wV5FOwkO+LhihfUZHBrUCH1Pmh5mXigMtVkC2LU=;
 b=W+iRohFBVzwWi0tMYt0ZhWWHcBjb7vLo6x/WfuivzkDKyH4FNHDqn2wNCHjgUDJ03SdFRAa7b5m7u8/z79KPue5TEjyids9Ruqza32pMYbphcRKB+hKTYzO9z0WtHW7RJqXFkWucz6NJHFMY4se+U9NrG5EyC84tblTk42WOwphnqFPgI6DJGA3AV9g5zgMTdYEQJ+8QjMkYSg8IpK0jldZlUGfUprPDaMGLtOanPJpKCpr6Nvw5LDjPWVy/WLiPT9GUcwwu8qcIvmholmSCY7Fou5Iyg9GkeIJRl2O5p8uyVJ1DcmjGuN7wCYgnUv9JkH/VIyU+Vo2wviWGg0V+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uu75wV5FOwkO+LhihfUZHBrUCH1Pmh5mXigMtVkC2LU=;
 b=vdOx6X/n6bhfP+xiiJZ3VOMqg7uZnBsmLVI673ZXwnCpFML0X8QZQu/cD6pY6eEGPo1rrCtakDg4/lTZm51ENBWJ8nDjp2D6nqH2+5CG3wFuqJIHaHkTz+u+l3g8EWh2fOK1Efpn8T3hKpuwOHF1ddxJifbff2iz3VaWAcp2RCo=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by PH0PR10MB4519.namprd10.prod.outlook.com (2603:10b6:510:37::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 18:14:32 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd%3]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 18:14:32 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Song Liu <song@kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 05/11] md-bitmap: rename read_page to read_file_page
Thread-Topic: [PATCH 05/11] md-bitmap: rename read_page to read_file_page
Thread-Index: AQHZn1W0G/Np+nDPEkezyH8JNPndm6+MK76A
Date:   Thu, 15 Jun 2023 18:14:32 +0000
Message-ID: <781231B9-24DD-4EA3-8213-DE90170E15C8@oracle.com>
References: <20230615064840.629492-1-hch@lst.de>
 <20230615064840.629492-6-hch@lst.de>
In-Reply-To: <20230615064840.629492-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB2943:EE_|PH0PR10MB4519:EE_
x-ms-office365-filtering-correlation-id: c8d741db-4922-464d-d77a-08db6dcc5e1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 45w0LHX2etKGVxT/ZLrpsJhuck8F7yQ6vhMhjS7wsHn1iqXG3eZ09PiQ3jvucRkpbdGlb/JdzTParkfREDXDLk4BDyLXnZYq793yKl+AXm751/dWynpTdzwLby43wd077VUlhAre9zCODpO5DvF7B9mXHgs91TsKk7FXAOcGzHlLUwoIYrrbxplAvHPVtuTQn3SeBx19X+vm87cVzHXqOtMQ8Ov1websAEgPcVoGDQ/3JWJuuxlQmMzapCmJD+x7kpnwtom8D7f+6zCV4XyVQ7wJo7Qo8vVIwnBWerZVTB5vY438YxBvSnqVjJUNSkXnQzueCGdpJ74k1Cl/dAuh0vDencypLa1SJpYWnlK/o3ePvAlA3c4uSEbdHzYpvKbS4627/xfu4SnXxEfkQwV3mKIrcvcEJLy/0ecDZizYtBcdcnovpxsIU5NArp68w6qixipuiqUz3SszYt5b8nvB0aUBNDxx00LSZh/p5iF9y0+ZJnoVfhoF27XmLVIkVUV3Iy1yy8WuoBs1nErPoRBUWPW4C601s9pBDBncTa4EBXSQvWhqMWkM88W72z/ElmyaV/PoKnEz5XHDZEOBmUoMakgqdO+NLd1dNKwUj5nGtXtJ9+9OCLC/KGuwdgDv8YVpAZo7lp0dJyiIOz8nAL88sA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199021)(4326008)(6916009)(66946007)(66556008)(64756008)(66476007)(66446008)(76116006)(316002)(36756003)(54906003)(186003)(86362001)(53546011)(26005)(6512007)(38070700005)(6506007)(33656002)(6486002)(71200400001)(478600001)(38100700002)(2616005)(122000001)(83380400001)(44832011)(8936002)(2906002)(5660300002)(8676002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OwuRhEavjXKZ+XEAaWXhcHNUAHUMS25Y8+43yHVasW+OhYwRcWC6BXKu0AxN?=
 =?us-ascii?Q?OAuBwRMmaxkQe1Dpilhv9usb3pfMY4+s68g6s1JBBTGLVRGF0naf7Sun0N/B?=
 =?us-ascii?Q?KWLNeN61PhS+49sZM6eEHOBevJsVs4Ko6mITHeQpgW7RZDNjq9W70UcQD077?=
 =?us-ascii?Q?23CwvHwSh3DNjNnFLbJ9NUpk0t2E1gqREIp21ckkn2Zg4eO3C90RgLiPLHxV?=
 =?us-ascii?Q?aeCTfKtMkEsWeLn2JwSqAUy0MRHUNAAKl2hBDj+P5EWzuZ8yy/can71OmEVN?=
 =?us-ascii?Q?oI3MciGIza+5DO3Ndob0mmoNRY72n1X78YjzB8hg7cIiBlnXG0+B7pGnDOSG?=
 =?us-ascii?Q?oVxI2ChDwniV5wB9jT7nhVv2XDUi861UOa0YUdQ6CX0nzGilb4mh+g1N0xEE?=
 =?us-ascii?Q?C2W9m/ndtNLA1gAp+L5kt695/zbxRARvcEB9+8bnZgnZ+m6JaP3Qa7TExr0n?=
 =?us-ascii?Q?rOTJxlMlQyyOyer5SMlyX0MtLiK8LSWZ99UVeliAeF2WeE1GrgY4FDM08FcU?=
 =?us-ascii?Q?T2Nh5kG8Yi6gbBvJ0yD3nMa4ROYzhk5sD/C/1tkEGJbug56sneLRs3S3n119?=
 =?us-ascii?Q?RcZfmwiVM3MBO0oruTzNIBbeGgvAP9t3CDYJmgPk+75CtdQkNmFJVGeOXnx1?=
 =?us-ascii?Q?tJ3ZjO39YLQL+QmbMK2HEppSNOMia2ADZCOfxWWlOXE8q7bHCLv9RBjoytR6?=
 =?us-ascii?Q?HqyFWjKe1piT8OkRkN2RvTIz6rWJWZk7o5WbZ8xfL/OtW8cwjT9o8P7q2QXL?=
 =?us-ascii?Q?QlAnBUjYK2tuiMhx1DlvFr650y7uRg1dUnnYW6WsFessMpI0tzQsr95JLGPe?=
 =?us-ascii?Q?T24kwkl0RJbD5xrV5I3NudExW3hBk2fHUIv50MpkWPJLzEoYnX5CHG5fmywg?=
 =?us-ascii?Q?m6PxIT7OiZopQ9Z9Sx7A6kdENRcgppshwwOXI+EUW2X0ZCril435AMkfPkq2?=
 =?us-ascii?Q?yAH+gZqwSanmpVTrhred7ZZBWRYmpkXyJfKR/j9VOwEbUFj1WFxGHEZYbe6T?=
 =?us-ascii?Q?Yuq67aErcJNZRoET+R5bJsoqe7thYXNemVKWRX575E/qW2O2QEP7SdIDTCaa?=
 =?us-ascii?Q?sgDqMfYbnb7XX3PqY9ldIcvCbAKS7D215oediAMUpYMk9XLt29/65RiZ8CES?=
 =?us-ascii?Q?n35HbebDhqOjN11bpTO72PVcYL+xC/p7OFxRWguidPOXa7jHuq/aAO8d+8ho?=
 =?us-ascii?Q?lF6Prbmtc53y+Qey6LE3Vy8Inp4Rmd31FJgsFUZLmNsrdDtSw81AJSSWmqo4?=
 =?us-ascii?Q?u0AZjKjMxMNoIY56Y0Y30zhvpPCleqMdSCvy7CpGF351hH58KnAEw9JHxWMH?=
 =?us-ascii?Q?ARRRKYTHfg1OIII1c4pJpTwWY22aZBadFJedPUEyxGtXvCbK0snNxKm5E8Gi?=
 =?us-ascii?Q?y7vtthkT9PN58fwD6uBtQu5Omvi1pSXjDpSrUAGWJsXQZX2rGU++a0wzSfUu?=
 =?us-ascii?Q?42LndlAT11Yz8MVA8ce5/W4UF88n0od11ptGWChjG1jbmpyOL7ArmPVDDX7S?=
 =?us-ascii?Q?UzcMoercgBNW0oknyRGIdIWg0vEDiMzCMn+mtoBgPlcasJdWBVmeSlHv/Wlm?=
 =?us-ascii?Q?T42s8K3VBwsNluQ6J4vQvncUpvuD+Rx804Pt51X73Y8yRLOB9WMtmVbkfZ4k?=
 =?us-ascii?Q?0w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D122AB176611C3419099DE39689E3D79@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Qr03YRkQbIN0leVZf/HG2SS6m4TLfsrNv+QtxopPD1TWrftSFjJmvf8dntJWxYwKDsj7IwvHmjAro+leImm/jgxATX7jCaZbRR/2H5NtYkgksJPZdsNcw9vcc1r3JJD/TA0kKHw8M6yV1BZ4QyYUm/VfgpsJCGxXbPvYuLDZLBMhl8zPqOMOYePWd/IMXEKxYoWxjXCrlcJ011o4IOUNQwnx9zabNp9WkaBAjUQoBstGqISDw5ewMyVoJzHQBEg0cruiiijTtUQ/WMpYmRVz3V+7WVDtE8SraIpPEGpeFogfQthhfltJhjTBEYVHnnxUDmrF2n0bhfNBfK0Ch1BX4gkzE8Pj27RsUALR+DeaQ3nw7HMpbBBevZysJzC3y2XNpC/J9HKIkSVArXHylry87alXCLuowoPx9/vdZtxwd7ny66miLuWFocyQ+JoAD1RYUomPnaGhsI1aKczi/tWWkS9djxLFxTR17c7NAKBJqlxmJ6HlJYHMILOYu1QeIE6IC9xWDWSbJMiflbw8wAoyEHvTbF2mFsdM8q+xNWHV6VKQ4zo8Gj5dWFA6v5eaqZhmHa487V4gHDHfPpuygmGMNgTYPkf0hSqDwTfSE5iNuhcJoewIixs2TqPIxe+do0h2jiZ5sQha78iuQSSfsQ78b4Wh+s8FjWsR8fhSXAdIfFoPVanXZVGjxguGoT+jYjO4ofnLCb0GaUNooXJkDXma4CDzRicAt/Eq9BC1HCDfMqiF7FZPgnR57MKg0C3VyS1FbmldZoBWq0EpLqhpSWzspvzWWBRqZSf6pnmGcpR6sCH3HCdmqi8XdOBBZE86or+w
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d741db-4922-464d-d77a-08db6dcc5e1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 18:14:32.2562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BuQHrj4HXYO0lGreBWRWbdX0IEgvEx053W7rEiF3WSM6nZcinoWfVvDeFmFFIH+X3sTV26i3U3MapFWuKVfZ27USMhQAQMEGGO7Si8Xaqec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4519
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_14,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150157
X-Proofpoint-ORIG-GUID: WG9fi5dyJ5IEKchdU_UA_KUZw2LChFl9
X-Proofpoint-GUID: WG9fi5dyJ5IEKchdU_UA_KUZw2LChFl9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 14, 2023, at 11:48 PM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> Make the difference to read_sb_page clear.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> drivers/md/md-bitmap.c | 10 ++++------
> 1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index 46fbcfc9d1fcac..fa0f6ca7b61b0b 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -348,10 +348,8 @@ static void free_buffers(struct page *page)
>  * This usage is similar to how swap files are handled, and allows us
>  * to write to a file with no concerns of memory allocation failing.
>  */
> -static int read_page(struct file *file, unsigned long index,
> -     struct bitmap *bitmap,
> -     unsigned long count,
> -     struct page *page)
> +static int read_file_page(struct file *file, unsigned long index,
> + struct bitmap *bitmap, unsigned long count, struct page *page)
> {
> int ret =3D 0;
> struct inode *inode =3D file_inode(file);
> @@ -632,7 +630,7 @@ static int md_bitmap_read_sb(struct bitmap *bitmap)
> loff_t isize =3D i_size_read(bitmap->storage.file->f_mapping->host);
> int bytes =3D isize > PAGE_SIZE ? PAGE_SIZE : isize;
>=20
> - err =3D read_page(bitmap->storage.file, 0,
> + err =3D read_file_page(bitmap->storage.file, 0,
> bitmap, bytes, sb_page);
> } else {
> err =3D read_sb_page(bitmap->mddev,
> @@ -1141,7 +1139,7 @@ static int md_bitmap_init_from_disk(struct bitmap *=
bitmap, sector_t start)
> count =3D PAGE_SIZE;
> page =3D store->filemap[index];
> if (file)
> - ret =3D read_page(file, index, bitmap,
> + ret =3D read_file_page(file, index, bitmap,
> count, page);
> else
> ret =3D read_sb_page(
> --=20
> 2.39.2
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--=20
Himanshu Madhani Oracle Linux Engineering

