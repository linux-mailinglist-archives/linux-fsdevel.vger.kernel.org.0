Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B913C9C1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 11:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbhGOJvo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 05:51:44 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:36730 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231177AbhGOJvn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:51:43 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16F9hn4k017686;
        Thu, 15 Jul 2021 02:48:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=qR9qCxxwC5CNB3KL5+uqj1GGlBAIpS+l0KXqqdm4NqI=;
 b=MgWtQhwOvYzui2m4E1Sih00cc7UWf8JOkaoKNB+96JdOQ28UkgCEX0VoKFrd0WYvJExz
 S7eWbGaAKN93hG+9SkLC4zCS7wt+FpDRH8hjFYumkpkex1jU4bPhzOwdy6OE9FCn/T/J
 sFsw9IlnAbfFY/ybqp2Kxrf+rLL4k3Qax1ZMnT0OkFzRCUQPobh9B26b7ffwsuO2xG+g
 KueDdoyr9Gk/sUbPXJ19rv1HMXeU3uUsvvAstLtepHP1tSw5ME4qQ2RvNqI8yVdAqbO6
 6zKd/wKdA7FuzVrlw95eASYVdyaMMe6LaLawh7ISanBlYA7wDbl/sDTU1OMa6XH2B1Y4 RA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0b-002c1b01.pphosted.com with ESMTP id 39spmwu7hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 02:48:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYTqb7gdp79uBoFlXDHLda3VG8f0rgmfDXAllJX3fUcdkcqtIJDQq44ghimR4HU6DjriWG1sHrA+qbRJpQGxPnmmWylQjErUykWIW779IwXYtz05H/WgottN8GRRT2oG180JzKHs7+oTpkU0zH8qUIK6/1AwG9HEiSZKcGGWzrA9YoRu0YEysoV7c+SRzaq/5WULneyTK0IklIKtO6TXWANAA4hkZ3YUQGBXKT1uv7mKzEvSxO3ZpjHWGVhQzNayEg6slLODVoHFWl/5XMzBQXFmV2hg5nEvMidQcPcm31Igk0bR54njoMpL8aXzVbNQTT6SJ/JeZoikJr96vHZKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qR9qCxxwC5CNB3KL5+uqj1GGlBAIpS+l0KXqqdm4NqI=;
 b=JG/ALHS9lGRSiY2TKhI2T+0WBJ+D9yNEnJ99+k/lri34L57k8zDtTjgUsUysgVAnwWVMrDSe7HRzkHCqOLqkPzq8hZRKXF7GUArY8vnUAHQaAWWagZpvefzIlYcEvGTSQslb7hJ7M24DwoE55409W1lFy+xN/cUKhPdE0y2HdIgl6Gq+/EJu8nm2I4DtPqoscxNv79RFJ6/QxRGSt4ulZ7zlCiUS12DhIXgAC5WOSIHnPif87nXVC5jvDEde9W+Kxe7DNBQPykjNkYiN2n4ESZvM1I/X3N/bGr4KQMcK1YNBume8g6YtPpdbKHsOgD+9/implFXtKxWnGoaLa+7Qhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from DM6PR02MB5578.namprd02.prod.outlook.com (2603:10b6:5:79::13) by
 DM6PR02MB6379.namprd02.prod.outlook.com (2603:10b6:5:1d4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Thu, 15 Jul 2021 09:48:30 +0000
Received: from DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::159:22bc:800a:52b8]) by DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::159:22bc:800a:52b8%6]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 09:48:30 +0000
From:   Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
To:     Peter Xu <peterx@redhat.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "chinwen.chang@mediatek.com" <chinwen.chang@mediatek.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "jannh@google.com" <jannh@google.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <flosch@nutanix.com>,
        "Carl Waldspurger [C]" <carl.waldspurger@nutanix.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC PATCH 1/1] pagemap: report swap location for shared pages
Thread-Topic: [RFC PATCH 1/1] pagemap: report swap location for shared pages
Thread-Index: AQHXeMRl21VMVRbyvE6e8ETg8oYttqtCo1EAgAEoR4A=
Date:   Thu, 15 Jul 2021 09:48:30 +0000
Message-ID: <D41075C7-B9FF-4C95-8613-5ECE75E8C3EE@nutanix.com>
References: <20210714152426.216217-1-tiberiu.georgescu@nutanix.com>
 <20210714152426.216217-2-tiberiu.georgescu@nutanix.com>
 <YO8L5PTdAs+vPeIx@t490s>
In-Reply-To: <YO8L5PTdAs+vPeIx@t490s>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e58d864f-7fec-454d-19f1-08d94775b3bc
x-ms-traffictypediagnostic: DM6PR02MB6379:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB63792C304F9078EFD6C936EDE6129@DM6PR02MB6379.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iz2/I2eYT9BRZcmnqW8B1fe7DuHHvDF0L95LrbXNC4/yFHmYQamAZTLLYWD2FIJyYv+dN6Jzfqh/fc4Ynx8Agz2uQXEvL19GlXtuIpKoKXAbN3S8P6oUnj902latioF4BIeMFztlzk+d7++ddfIhYIeCwGPfdll59REaQYVlFu1MmKvyuyb0BFeXhMxb1uiUrBnfvv8MBXxN/oIyVmcWjuSWOdFGjY3PSsWFz/7svI4zHBgdAm8STrg+KxWOcHfBnG4/LgXyHNCe/hEo+F44jgmBZgD7yAMNTLcbz04JfXWMq3JIMq5ePW7n4sONdBDbsgoIyHOWuqxsH+Aehbaes2dyjYBHqaxYxhFX2j7dkIp1B+EXewC4KnYvZcbRNGbnq+6EnrSTHLYOCrUvxJeiyaRjBHQwA1YAvv3tTAJBT0gABL6iZANZQJhHtOra/XFjZbbFNPEpismBGs5OB9s1u9KQo61lKSiNiovs3vc49If45C93unLnX4NbRAECk3j6tIt5inpte/D4poRuppzzDw+DfHbcx85Q31m30VwADV6v26gSui6ZL3anH1pQyGPTTXKtNgrtJNnIlKSeqyeFIr0HiXsbLuLGc49VkiQ8ShtyI9OMfBIB8paZpHhtgrMA98LwfKOJYMmi9sRsVYZUN26bpd63jH1Bx+jDfwRANfTLddyFz3MjhdS/fjBd1c0wXbJfl2bKZPp5TMHUkxwI4IWBYwJCIXxyPp3zpUOl+4ws6rY22CbZNW1v80hThem7ubKNT4X3Mv6C4A//nwZdgjs715uyPXZImCcJQCCjRPJPh51OilozeMEeqW2oPt5/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5578.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(136003)(366004)(376002)(478600001)(36756003)(66476007)(66446008)(64756008)(66556008)(2616005)(4326008)(186003)(6506007)(53546011)(38100700002)(122000001)(86362001)(6512007)(6916009)(5660300002)(2906002)(71200400001)(91956017)(76116006)(33656002)(6486002)(7416002)(66946007)(8676002)(44832011)(8936002)(316002)(54906003)(38070700004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xGmbsM+9gSI1anXURexzSOsczEkLSgR4caA37YS+tt/C89XHrPFVvBxCllnF?=
 =?us-ascii?Q?Jk0cMEDKh/UB1bP5wx4AbKX7F7kb+YKzsK1LOQ/XLpdMnL9fyOHW25NynKQi?=
 =?us-ascii?Q?Et8utBt7fVIiWuQvFzSqBF4bpnfgi5pj2wYcTHO1gWSiSr+wken8WgZc4tpY?=
 =?us-ascii?Q?h/tKGL2L3RedmwvLWvPvTsD22gTOBRBf9w12PVqQUpIJtu7EeSDQdXtbDGsP?=
 =?us-ascii?Q?7Q8HgNPEOLFqbjXCXH6GyuxDvQ/RF/EFh34JDvzLLaXwgT8k5pkUWph2IDrc?=
 =?us-ascii?Q?Dv2AqeRZEMcvQlGa20EPhNUVPsEKxKuq3xooGCsl/BMoEkYuvcALHOLChELO?=
 =?us-ascii?Q?aszjjkLER9yTVBYh9CMe1QknG7dI0fx5V3eOKTPGpsvIP7ewik973jbB/Fkk?=
 =?us-ascii?Q?fH+XzMu5pTLUKJpVa7GH8tW5Y+vJrxN3bK98cvGtRUYrgDPz7B4Oz7YajXvz?=
 =?us-ascii?Q?2VvCVDDTouTfVqBbgKp8FAsUDdShURVoAOXnnNDhRyxejt01qrX+gN8xtwxB?=
 =?us-ascii?Q?OmiKt2v1nNQOdS20eytfq76HIMTAP7rN27pNwLqTyubU5k5fVjWJBkBxpPPH?=
 =?us-ascii?Q?bKeCDoShGgyoCyn+5IqMCrVYMraY8GjbXoulXodDp9nSfsZZW8n4JycC5nX6?=
 =?us-ascii?Q?Qmsm58+tvOw5/qGDQCkk9Q/zInM5LQXrnS+a+Hv25EDtORDyaWLyuPgv90Dc?=
 =?us-ascii?Q?90m5vSjk5y4SAJ2I9Tfvht+/EIWP2NxbB3eU7LsbeaIF9BHZW2eQHSh0ldzu?=
 =?us-ascii?Q?DLNdpgXUAPTlQwx0fTSZHRoMopeOcvFh9TRbyCfvbZ1u81yHSqvKlsYu0IXp?=
 =?us-ascii?Q?diGAMKFlFuZf7mUymdkNGiBqtzz18LBFXIRACzQ92y466NR6yLY8VGlPNA4f?=
 =?us-ascii?Q?W0RsTFvFAsqMZgNXnbTodG54QRolOdpAexSWz0OrOwkiBDn9Dq5kfmVZpMym?=
 =?us-ascii?Q?KNTeBFJ0uMD15djvgt4pBRcSTABP45lSiGmMQ76zsSzOJ+060sCikjiSGQi6?=
 =?us-ascii?Q?kcIcho0R2oOmsoLELLh5X+YoSc1A4gvmanMMTy+NGF37vEbQisrgDqI9mxGd?=
 =?us-ascii?Q?N5uEsAYL1vtcyB+lUqA9MfGuRF+vpC0nez+YyRLM9ksHYuuXAY3+idX8czu5?=
 =?us-ascii?Q?VJYMLqRRAvQBUmafrSYsxNzddni1ZspzyFJFznQbtXUC8iboMr7ef/lpcH0z?=
 =?us-ascii?Q?OXnwQ+qmz5G2eZEpCCf4IsS2pGLTNFOY5jxL419ghZN/OvfWfm1hf3e+a+cJ?=
 =?us-ascii?Q?b2XZ4k2HNa9agjDdmkMK73xIApiREE9eShAKTgCOEuXnrlG4hMkDBSDEcKah?=
 =?us-ascii?Q?gtXRwJ5G2AbuuK6WwilnmvmwgA3VyLkXYEflIWa+EnNx4T60/vBY67eSW2cV?=
 =?us-ascii?Q?G8ucyvBMQWtAiEFAUPfz8WZOPMDd?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3BF6AED871150C4CB5679C66A4A3776F@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5578.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58d864f-7fec-454d-19f1-08d94775b3bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 09:48:30.1250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9unIgEOA6lN2Sy9UUUMsIbeBfSkJ128P18cMlkSqWqO6ZkwO09IxmvEx7Fk4zVVurrIvbjl8O6ldPPSGqYPl9C77I3fUVrTA5aRERwQZMW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6379
X-Proofpoint-GUID: gZtAo8I8tiuILA0ySyo5BoJHwsBLYEni
X-Proofpoint-ORIG-GUID: gZtAo8I8tiuILA0ySyo5BoJHwsBLYEni
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-15_07:2021-07-14,2021-07-15 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On 14 Jul 2021, at 17:08, Peter Xu <peterx@redhat.com> wrote:
>=20
> On Wed, Jul 14, 2021 at 03:24:26PM +0000, Tiberiu Georgescu wrote:
>>=20
>> static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
>> 		struct vm_area_struct *vma, unsigned long addr, pte_t pte)
>> {
>> 	u64 frame =3D 0, flags =3D 0;
>> 	struct page *page =3D NULL;
>>=20
>> +	if (vma->vm_flags & VM_SOFTDIRTY)
>> +		flags |=3D PM_SOFT_DIRTY;
>> +
>> 	if (pte_present(pte)) {
>> 		if (pm->show_pfn)
>> 			frame =3D pte_pfn(pte);
>> @@ -1374,13 +1387,22 @@ static pagemap_entry_t pte_to_pagemap_entry(stru=
ct pagemapread *pm,
>> 			flags |=3D PM_SOFT_DIRTY;
>> 		if (pte_uffd_wp(pte))
>> 			flags |=3D PM_UFFD_WP;
>> -	} else if (is_swap_pte(pte)) {
>> +	} else if (is_swap_pte(pte) || shmem_file(vma->vm_file)) {
>> 		swp_entry_t entry;
>> -		if (pte_swp_soft_dirty(pte))
>> -			flags |=3D PM_SOFT_DIRTY;
>> -		if (pte_swp_uffd_wp(pte))
>> -			flags |=3D PM_UFFD_WP;
>> -		entry =3D pte_to_swp_entry(pte);
>> +		if (is_swap_pte(pte)) {
>> +			entry =3D pte_to_swp_entry(pte);
>> +			if (pte_swp_soft_dirty(pte))
>> +				flags |=3D PM_SOFT_DIRTY;
>> +			if (pte_swp_uffd_wp(pte))
>> +				flags |=3D PM_UFFD_WP;
>> +		} else {
>> +			void *xa_entry =3D get_xa_entry_at_vma_addr(vma, addr);
>> +
>> +			if (xa_is_value(xa_entry))
>> +				entry =3D radix_to_swp_entry(xa_entry);
>> +			else
>> +				goto out;
>> +		}
>> 		if (pm->show_pfn)
>> 			frame =3D swp_type(entry) |
>> 				(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
>> @@ -1393,9 +1415,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct=
 pagemapread *pm,
>> 		flags |=3D PM_FILE;
>> 	if (page && page_mapcount(page) =3D=3D 1)
>> 		flags |=3D PM_MMAP_EXCLUSIVE;
>> -	if (vma->vm_flags & VM_SOFTDIRTY)
>> -		flags |=3D PM_SOFT_DIRTY;
>=20
> IMHO moving this to the entry will only work for the initial iteration, h=
owever
> it won't really help anything, as soft-dirty should always be used in pai=
r with
> clear_refs written with value "4" first otherwise all pages will be marke=
d
> soft-dirty then the pagemap data is meaningless.
>=20
> After the "write 4" op VM_SOFTDIRTY will be cleared and I expect the test=
 case
> to see all zeros again even with the patch.

Indeed, the SOFT_DIRTY bit gets cleared and does not get set when we dirty =
the
page and swap it out again. However, the pagemap entries are not completely=
=20
zeroed out. The patch mostly deals with adding the swap frame offset on the=
=20
pagemap entries of swappable, non-syncable pages, even if they are MAP_SHAR=
ED.

Example output post-patch, after writing 4 to clear_refs and dirtying the p=
ages:
       =20
        $ dd if=3D/proc/$PID/pagemap ibs=3D8 skip=3D$(($VADDR / $PAGESIZE))=
 count=3D256 | hexdump -C
        00000000  80 13 01 00 00 00 00 40  a0 13 01 00 00 00 00 40  |......=
.@.......@|
        ...........more swapped-out entries............
        000005e0  e0 2a 01 00 00 00 00 40  00 2b 01 00 00 00 00 40  |.*....=
.@.+.....@|
        000005f0  20 2b 01 00 00 00 00 40  40 2b 01 00 00 00 00 40  | +....=
.@@+.....@|
        00000600  72 6c 1d 00 00 00 80 a1  c1 34 12 00 00 00 80 a1  |rl....=
...4......|
        ...........more in-memory entries............
        000007f0  3c 21 18 00 00 00 80 a1  69 ec 17 00 00 00 80 a1  |<!....=
..i.......|

You may find the pre-patch example output on the RFC cover letter, for refe=
rence:
https://lkml.org/lkml/2021/7/14/594

> I think one way to fix this is to do something similar to uffd-wp: we lea=
ve a
> marker in pte showing that this is soft-dirtied pte even if swapped out.
> However we don't have a mechanism for that yet in current linux, and the
> uffd-wp series is the first one trying to introduce something like that.

I am taking a look at the uffd-wp patch today. Hope it gets upstreamed soon=
, so I can
adapt one of the mechanisms in there to keep track of the SOFT_DIRTY bit on=
 the
PTE after swap.

Kind regards,
Tibi=
