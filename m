Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8381B34BD4F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Mar 2021 18:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhC1QqH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Mar 2021 12:46:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59008 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229595AbhC1QqB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Mar 2021 12:46:01 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12SGjsWJ019669;
        Sun, 28 Mar 2021 09:45:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=NBWoQetJjz/VNZDHzFdIwZ6885Hy3nLUXSWp1+Ie/Fo=;
 b=Y/2C+J349PAUFbW+wAHSFbb7DDZpta8xgqNE45/P/lLna4sGV+TROj80ZPDZCT9InpfF
 ISsUdhqJ14tzpx7b6lWuWLBJKZT23WKqifE2Q4oSchLnpWztp3GAwgi6wvN5ELriDZ2G
 N6RkpL5F3jTlVy8S8Z5VQd6asaLjkpFPXhw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37jmhs9bny-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 28 Mar 2021 09:45:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 28 Mar 2021 09:45:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4o6ib34YgyiYMjirJqR7MP/uKSW4AvZIw1yOHNelCgMa+WtLbBPTsp7dTtDtzL07p0DE1gZARsSe8DwFtirnkSLiANUuzM1Px3lWfKCv+U4m8tEGfxQ8gpZ6Ptora+uZQYzlSVIa9JD/cMALTnu1awB3Xr/lZdQlvRwFvv+31hpL1ntHQRfUxwA7Mul45DvoMwZXRegFlJrSlQ+rwrxc/I0jirKFiwIsoCRUv1BQ8R1leCqCHHb5JOKVlsivQ6L2dNYB/LYw/vpYpnu5jgH5BmWlHb1J3NyCIZU0H7RFqNHcIgoH5ia1bxxtisRv8azABt+2ABpRorZP5HA4lpt/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBWoQetJjz/VNZDHzFdIwZ6885Hy3nLUXSWp1+Ie/Fo=;
 b=kZDyeE/7cN2rpI63X9cORZm/IIR7URzKifx/8ugoSbWrnE0GsYWc5R7Izbxzsy22v3yXox88048Nvw2MuSxuwq76tfvaZMwFzNCqLWUnhquZTL47oc67vo8Z03mwu4Vx4/mGYiK1si/6qin+vKZaY0ZVCwN8x6V4GUqfcblxgLWR+8Ob3RG1q/n0aieXriiCgHnK8V1eUnhx3MvHflMN4SSN7SRwldbM7RJ9fQ+Xk0Uo7+Kwh8Tsb/Jk+mYjPDLIiXxSumYbJW+hq4UbNqP2sfKq0S3F9YCYSWkPJY9binNRGH2I6HlgP2gTz5zH7uneLgG61oR1iMUtqjg4VcIlSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2997.namprd15.prod.outlook.com (2603:10b6:a03:b0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.27; Sun, 28 Mar
 2021 16:45:52 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.039; Sun, 28 Mar 2021
 16:45:52 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Collin Fijalkovich <cfijalkovich@google.com>
CC:     Song Liu <song@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
        "Hridya Valsaraju" <hridya@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        "Hugh Dickins" <hughd@google.com>,
        Tim Murray <timmurray@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm, thp: Relax the VM_DENYWRITE constraint on file-backed
 THPs
Thread-Topic: [PATCH] mm, thp: Relax the VM_DENYWRITE constraint on
 file-backed THPs
Thread-Index: AQHXH2a3EJT82fWS+UGTDxEEYLearKqQrtYAgAEh+4CAB9P/AA==
Date:   Sun, 28 Mar 2021 16:45:51 +0000
Message-ID: <2E59E29C-E04D-417C-9B2B-7F0F7D5E43EA@fb.com>
References: <20210322215823.962758-1-cfijalkovich@google.com>
 <CAPhsuW4RK9-yWrFmoUzi09bquxr_K16LqeZBYWoJXM0t=qo+Gw@mail.gmail.com>
 <CAL+PeoGfCmbMSEYgaJNPHWfLvmmXJGaEM5G6rFstKzhTeY=2yw@mail.gmail.com>
In-Reply-To: <CAL+PeoGfCmbMSEYgaJNPHWfLvmmXJGaEM5G6rFstKzhTeY=2yw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:4e3b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7eaf61c4-dc1c-4fc3-6824-08d8f208f2d4
x-ms-traffictypediagnostic: BYAPR15MB2997:
x-microsoft-antispam-prvs: <BYAPR15MB299727672733A2638828EC27B37F9@BYAPR15MB2997.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NAgMh5Zc/2PCTrVWw3t80vgY8jmK9PNM7denbFQeUKuEbgOQySrNYhf1ch0xHFivym7kWjnvlPoE7E6XBfzDg7UISAjo3gZ65CWEjWpiQsRQfbFae0gDP4gUgM2DprW28cqu66oHpbVL2dZNw/KG0v5ULzmDFOd8g4+zFw6FtKM4Bja1qSVCVf9ZLvtuYSiVHtuevFhOr+EHBT2B0weXqL4iHJdrm/Heej2K0TiXi+rKpN5VHyQf0vYafLA3FVbTYDAiQPso4C2SwjDRZ0gocBsrO1XTwbvCofR7t+dHoOjoGd6p/PaaTLui8iYr3XEWsiWaK4puR6V/dZ/yXMw8MtWfe9Bt1wRE43M/ybT2ExgyfZVx1txrtOieSNWlSIyTQlcicD1VG18zA/3R/HXLI3sRR2llZ6qGmxCqPWMyIMbEUZKDjEPgjGUgQiFJkWZtLC97dR9NZoGLUF5MbBLVfnfJiVizEoOkuLmOkaunOb8m7PyScjn1jfpCeX9UrCHuuWt1BImJIBcRUJ2apenmAW+ZtWpRqFXhDPiMOqa16rBuyWCLmZP5UpoIyRiuWrYa8HVRPJguv9ClhwlK8BZ1g4Yjp3H/CBtABY0fU6Lvsm8qyoPZu+Qd96/SscjztyffK8AAoW5JYSIBDo4H7hFPriEQkxWnNerUrRpyakACBOtIvu8HWcPJkU8Ts9TAPI/T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(366004)(136003)(346002)(2906002)(71200400001)(54906003)(33656002)(6486002)(76116006)(316002)(8676002)(91956017)(8936002)(6916009)(6512007)(4326008)(6506007)(86362001)(2616005)(186003)(36756003)(64756008)(66446008)(66476007)(66556008)(66946007)(5660300002)(53546011)(478600001)(7416002)(38100700001)(83380400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KmvC6J1dl/M/EhtU/mI7a8h0mq8Qc5mL6vlPDrlyfBX+RFx5M4wsk8eHYz8z?=
 =?us-ascii?Q?sEhUcBNZafz+rx+2IActl0hnSzolS+iOjIpr130HRjFgvXp0gPmg96f6tQPY?=
 =?us-ascii?Q?CDxVxwPdx/EpgcXj64prBzAwJu9g2GXKPYaYFEmTsQ2XNWmZNQ4PXI71dk38?=
 =?us-ascii?Q?lUlDL5RpuyGGGDbNUvLlhiV+WLrS6yDE5aWHq8ZF+uiQO81pOzSiRUPow174?=
 =?us-ascii?Q?l+gLa5vpmYBWCXHiN55xnNktXRfHfLH+imvsvhf5FBijo96LZbqmuoqY+7Vo?=
 =?us-ascii?Q?rP0eezXQ+9myFYB86qPTmru3fdaASj/3O5UjEQt3nGe01XKDI3tDEVfDuyRX?=
 =?us-ascii?Q?mjhRM5QgaQ8+day3knf4jJpbpdq1unaou0xvu7lhnDzky6N77BYVbpzGE9a/?=
 =?us-ascii?Q?019H8YN6YgALaDmBawwWEDMc+tZMvSTJWWTp9/4qeaAnlidSQ6oOD5VvpGTr?=
 =?us-ascii?Q?NmasA+b5p1oOSqZIRgn/xEi/ElfM3E9Vp1De8fJYme1XPXFaF9YXKxMGeop3?=
 =?us-ascii?Q?TraSdBsbVHuJpiJRL1t6sdKwYr8l/HqE7kJAc3trnl7j30Ul2OkMohB04Lzs?=
 =?us-ascii?Q?xsD2w6IHP8abhzX3GVJOSqMUL5l5W/fLwnKh04OO3Pkt51FhTyCT83wYaMEE?=
 =?us-ascii?Q?yGOWHn2rQu1XRngqU0f1P9bnHsK2Ue1auM1OR2AgMNeTjqlC8NIpUmsFjsf+?=
 =?us-ascii?Q?3rSPBPoMPjvrrZIW7/mMPzTypnjPTsJlRuwkCTqnY2Jewh38Mhy4d4OptAVH?=
 =?us-ascii?Q?WmFhHq+Xeta+gpmF5goQYPk6jg8CVWDZiFXcHZE3rdL8rwrrYIASbSo+0z3e?=
 =?us-ascii?Q?OVxphLQ3xnFwc7nn3tN5U6/S5mksdkn613QkXceaOvbnOA3NcsXkCLlEBB36?=
 =?us-ascii?Q?Np+TQ5PpMqJP7RHrscRwP13M86FBr5pC3JMjQtJBTyjyGp3seksWqK5gDXWJ?=
 =?us-ascii?Q?z+5x0HeeelOiA1gsYTXlk+bfD7jR1MWD7II/yb3mee9OyDPO6vBLDL5wrXct?=
 =?us-ascii?Q?FVRINwcAVA9mQc7h3JV1sPjrCRR5u3JnzIs18am1tm8AObvN9OrR8rGLzFfg?=
 =?us-ascii?Q?/VlmnnqU71Ecvr4z27evtbBXizxDid7hy3OQM+hTQ77XzfcHsjhDbdBBi4TW?=
 =?us-ascii?Q?fZQRBohcNKFt+umBGwgD4aE3RN4BGXMI7a0/KgsJr/hFOroPOkbuJGliDr0l?=
 =?us-ascii?Q?vWjnki3Og7dLfYRnIUWmshFsmKPD6ORK/DQmIlbI0qFbBbH4btoe/k2HbuQm?=
 =?us-ascii?Q?zR2DZa5nvcgqZZTvmUMPGs92H+22/y0bM6A5I+oeCUP58DA3N4d/1J/wMn89?=
 =?us-ascii?Q?sRfBOr/du6r7X0cxhvb3R+I4wS2y7o5GL0ZBlhu/EDqiq5622Ryhd7AhIdxG?=
 =?us-ascii?Q?FxxkD3I=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D5ABCEFA29D00E4B966FCF57D0E99C06@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eaf61c4-dc1c-4fc3-6824-08d8f208f2d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2021 16:45:51.8673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e2LS9gj/GM8AxoIuzCuWYk3ksWW+Y7srhfwd+SF8vZustcFdJxVAZbo64/me3qiVMXtJYAt9hPr4kR+NqLj6ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2997
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: RXkFAxigioASSnmlvVtnSf1wN7uXY-qE
X-Proofpoint-GUID: RXkFAxigioASSnmlvVtnSf1wN7uXY-qE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-28_08:2021-03-26,2021-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 clxscore=1011
 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103280128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 23, 2021, at 10:13 AM, Collin Fijalkovich <cfijalkovich@google.com=
> wrote:
>=20
> Question: when we use this on shared library, the library is still
> writable. When the
> shared library is opened for write, these pages will refault in as 4kB
> pages, right?=20
>=20
> That's correct, while a file is opened for write it will refault into 4kB=
 pages and block use of THPs. Once all writers complete (i_writecount <=3D0=
), the file can fault into THPs again and khugepaged can collapse existing =
page ranges provided that it can successfully allocate new huge pages.

Will it be a problem if a slow writer (say a slow scp) writes to the=20
shared library while the shared library is in use?=20

Thanks,
Song

>=20
> From,
> Collin=20
>=20
> On Mon, Mar 22, 2021 at 4:55 PM Song Liu <song@kernel.org> wrote:
> On Mon, Mar 22, 2021 at 3:00 PM Collin Fijalkovich
> <cfijalkovich@google.com> wrote:
> >
> > Transparent huge pages are supported for read-only non-shmem filesystem=
s,
> > but are only used for vmas with VM_DENYWRITE. This condition ensures th=
at
> > file THPs are protected from writes while an application is running
> > (ETXTBSY).  Any existing file THPs are then dropped from the page cache
> > when a file is opened for write in do_dentry_open(). Since sys_mmap
> > ignores MAP_DENYWRITE, this constrains the use of file THPs to vmas
> > produced by execve().
> >
> > Systems that make heavy use of shared libraries (e.g. Android) are unab=
le
> > to apply VM_DENYWRITE through the dynamic linker, preventing them from
> > benefiting from the resultant reduced contention on the TLB.
> >
> > This patch reduces the constraint on file THPs allowing use with any
> > executable mapping from a file not opened for write (see
> > inode_is_open_for_write()). It also introduces additional conditions to
> > ensure that files opened for write will never be backed by file THPs.
>=20
> Thanks for working on this. We could also use this in many data center
> workloads.
>=20
> Question: when we use this on shared library, the library is still
> writable. When the
> shared library is opened for write, these pages will refault in as 4kB
> pages, right?
>=20
> Thanks,
> Song

