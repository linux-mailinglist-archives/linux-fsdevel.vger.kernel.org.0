Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E58B3DD590
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 14:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhHBMV4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 08:21:56 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:25008 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233557AbhHBMV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 08:21:56 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 172CDXhp005402;
        Mon, 2 Aug 2021 05:20:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=UYgl1V6wsYPRx9DDTlSB5c4x6jrcAbJULet4UyrqJuk=;
 b=thgvSznRsruYPQSPReo4khoI16wsFQMZMe0tF6lDIZNRKcKAPsOHB+GbgDKy49nPLCNb
 EaLdSskaimQ/YowTQ9ouKLjrVplYtKwempOMJSNCIbX4NG9AVuX6rfdJtuIj/lmDfVuW
 zF9Niyl9QoKLitEu7V/LFazC1hqI7eHbs3JyOhrwqzq53nifA4CRyC4D2rutUqEvHOu3
 6RQdUEcXj8IvTYHUT3nW7o1CR/uQ4YZnQ6A7NZWrj8KhBS8+q3RFd5RKt7SHfbw+09da
 nu0WpR9UrAwNck1OtO+/9ddB0FG+/zJRFE6u76q3U7acPuw4GPIi9yHs+TP++zOQMvqP 8A== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-002c1b01.pphosted.com with ESMTP id 3a6ajkgp9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Aug 2021 05:20:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSh67aTCOsWtf9HsG2lGIbXHrhB2FIm3bevs0TEubcWw+r68RTeVYS3MJwQWqpbyHotAmr7EtPgjMeLkQja006mSzRYAgNa/y1wyVoBe2SSSG7addB/udRL5sN5a8YWRHJVJ4KLaAUal7JwZXmh94OC86GBqs0BA7ouXBu2CyIBgQfzjj8Bmev8gjeAUanAk0xwpcgHuGc1cl6kCQjnfURVMQggki3GQAj7FpeIhFVAbd72saB46bMxcwyXWLvZgvA7h7YuuVE0h8kbkE9w9gt6XZn5W85g6yaxmKfmjnCyV0EXCDZUnh4tI5KZlYOhyt75vaWNFiaEL2HWS5zl7Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYgl1V6wsYPRx9DDTlSB5c4x6jrcAbJULet4UyrqJuk=;
 b=XPWUxqqf+tnmkU7kbVZVidsSR4w1flWOjcNR1mK5v0gVO7FnYgNS5hLdFgZ0GIqpG7TLdrLF17GOzCWuA6eKkfuFeXy0d+MXbUxfj/JBH6bDUYjWFL3/I2TfGjRFPAjOnlUIp1ISgitzPX5xZdp9UpAPb2k/yE3Cg7svYwoK0+d28vQh4poz/OQ+WWG999Hx+gB+Aei3zI01pY1HGbDJn7xIxJ6ZHVRwMW9HYo8SMWqqXolx3+hQeoceUYIeVPGxRphgHyPlA8lVmElfukn8ygTo/fAIXQ2ryf0hY2nly0o1VpOcx4z1IuhahG5T9Tbdz3eBFeCZ1REO4UZHCYba1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from DM6PR02MB5578.namprd02.prod.outlook.com (2603:10b6:5:79::13) by
 DM8PR02MB7895.namprd02.prod.outlook.com (2603:10b6:8:10::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Mon, 2 Aug 2021 12:20:18 +0000
Received: from DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::159:22bc:800a:52b8]) by DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::159:22bc:800a:52b8%6]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 12:20:18 +0000
From:   Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "chinwen.chang@mediatek.com" <chinwen.chang@mediatek.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "jannh@google.com" <jannh@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <flosch@nutanix.com>,
        "Carl Waldspurger [C]" <carl.waldspurger@nutanix.com>,
        Jonathan Davies <jond@nutanix.com>
Subject: Re: [PATCH 0/1] pagemap: swap location for shared pages
Thread-Topic: [PATCH 0/1] pagemap: swap location for shared pages
Thread-Index: AQHXhV03Yn0KGuSOXk+WDmcI0wFSWqtbxgnmgARgvoA=
Date:   Mon, 2 Aug 2021 12:20:17 +0000
Message-ID: <6EEF4945-0574-4F24-A950-1DB292F698BC@nutanix.com>
References: <20210730160826.63785-1-tiberiu.georgescu@nutanix.com>
 <87y29nbtji.fsf@disp2133>
In-Reply-To: <87y29nbtji.fsf@disp2133>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: xmission.com; dkim=none (message not signed)
 header.d=none;xmission.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc66a51b-804c-49fe-4d52-08d955afe3e1
x-ms-traffictypediagnostic: DM8PR02MB7895:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR02MB789525DE28D33235860BB1D8E6EF9@DM8PR02MB7895.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1jl1YmNRPQfiHtFJ+R87slMHmzVfXwHTTSLpWhblNoCK2PNn+plyImOqgyLgaQETXYgm1OUKZUxajqN28HGJv0uNoGeKJDNVCZfOZqUFHwWJjraFXdnvH39M/8aLYrgmpHbYSltfJv2vtJ6yxgQEj6/tN6AFsKagYCMgNhmmuSqbAVI5LsKNx+0RFqnV2yBN11Xly/4/cD/+fI9gjilmnk1AHCYl0PJB7WaXWtR8n0Q3Gi46mFUdPcUz+P8ueaGQ3t40nlpRk3Lcx4PKJIZJhsFVLhSl7G2MDlHEAdsEi10T/B6o0C3NktR0gjww8USR5NBAQJ8stpYry94+NC2q0LhQNBZJIxUOoavHxXQfxM0+diSXyH8T0mTHSMoi0HAY0qV3GkSPqGnpC2cWW5OQdelwDe5ta7a6wxYD0FaqgOsajWutjPGQkF8so27cioEacw/MRpCW8HIjN+ZnkgxPeyb8gLbWFh6pxoGESOMk2NWbb6zfCRgP77lBMf06hMrlBanwjLcmXahMcNDiZxUVQRSQ80AkfSvw69lhgOO3U5khIPEQa0g17JflrWvS2ykHs3ZSygVOiHCfkwQ8tEkpsxAyPITO1ovjPzVVXrzdqTPzXWIlYU+PKUkj65soVfkO9ZVSDMRBzSu2XqyvgyxEFV38BtYE8KvtDfTg3rzyOOd0wYJASojrhk6rGmPzBbBh3BXzGOiyXj9G2MWWZqaIe2MZQoWZmcsj951xZs0/2d9BdTa24WMD5AYEDj3dHX+mqw84i3Bd5YEVp0x8zshoYsyXblydHqsyTdn+PR9WGDqiPzCCDqyR6NdP8v85dU49
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5578.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(396003)(136003)(366004)(6916009)(186003)(36756003)(122000001)(54906003)(5660300002)(38100700002)(45080400002)(8676002)(33656002)(478600001)(6486002)(83380400001)(4326008)(71200400001)(107886003)(66476007)(66946007)(2616005)(64756008)(966005)(316002)(7416002)(6512007)(91956017)(44832011)(76116006)(53546011)(2906002)(66556008)(38070700005)(8936002)(6506007)(66446008)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?56mJMW/Yw7GMK2x09VyTcNuGOY+GuX3JL6iOmiVzs3Aac77pdw750D3o4pbB?=
 =?us-ascii?Q?k2w03PH0DDrX1twDWisWkSqk2O0g6UomD+0ehZso538glm3w3QvJOtFtDO54?=
 =?us-ascii?Q?AS2jWiujzFqmWl8p2/NT6gnT07j5mn8l5+2KQO4+hPzoRFknlbDgeNPmVmRJ?=
 =?us-ascii?Q?Wdd0o9VQHAvZ353v9aYYRflevsPVb3M7o0uN28V9CO/ATXa/F7XnAZ0pVnde?=
 =?us-ascii?Q?bPe3rBfbVbYr6UNglbClflr9+VNXA2PScEYlm67RtVsly1301CUt9791Y0DD?=
 =?us-ascii?Q?nAw5Uz/TOcN3gX5xNUfa4Nxd+uU7LjhZeuNKllkNJOoNMhKJR6tK6Lf47hwJ?=
 =?us-ascii?Q?ENQBbqMtTymBqcWoH47cYELhoKP+87SmdeSjyOfr+aTMGRKY7gtotXTj4V5T?=
 =?us-ascii?Q?YPfu5AT1u8qbqr5E9WME3uH9KdRS+8scD/qV/H3Z+TAKAptetasXy4XJGzpM?=
 =?us-ascii?Q?fvNv+E88WBjupauIBdwuEOvYk0JicoAYs183z/xpi7JDYgLbEBLHKbI8mslv?=
 =?us-ascii?Q?IVjj0TTwf+HBocgal4Z0hASJe97+3m1RjU2jfL5nifRm41qubcHn1ZsB5Zfq?=
 =?us-ascii?Q?K9KXcxuIX97trNLtevDc5lkfE2qmdQ1mivJphH/eN/aSNFL83Q4zwOgX33Z2?=
 =?us-ascii?Q?gZeIItt+MqlQV/nm54Q/eq7nHL1wZCJFuLkq4tDFmXxXRU/wgEHA7ixawed6?=
 =?us-ascii?Q?OH6VxirkPaeQqYOfGaE14z+cOhbkEBgtWaQrNd76ptR7ep3PNSarGDnUVgDo?=
 =?us-ascii?Q?NSoWUMiKaOmlqXlBget1ZJKTzbLvfhRoYqasoVwaOYeUji2aJgQcPVhBiQNN?=
 =?us-ascii?Q?CwYV3r3KmlpK08mItMk7jmHilW3iYw+6uM0DBqKYyyTKm/DyM9c43x4/xj3E?=
 =?us-ascii?Q?1GXrGjSDmfHCeIda6656QH2UqDuKneR+A38oEBVeiiysvNcMqmnYgwFEELbB?=
 =?us-ascii?Q?nerTssR2fEymHi5oay10jpPO0l7fColjwSE6aeXgWYnI1x83hiRXvh2DvndD?=
 =?us-ascii?Q?O243lpiYnFK7X+KyzLFomOAyAzgxHIyO7arFUZF9ZaPX2/IkvBeLWQoPg6zx?=
 =?us-ascii?Q?RN7/IJsZSc8ucLWFP8Q0Bvy94TKenKsZwva8iiwWsHvTHN7oTKkLIC+y3rrE?=
 =?us-ascii?Q?OuITHm+1kWs++VWk8cSazdU05dmPW3+JWYwfviM4wYFBLEFkXJH1+476RReA?=
 =?us-ascii?Q?toFAdMS5ksdARWmhQG/s8L2V1QoCBuVfNb5VQicdwgsruW9UqFpeQrbQD+Yk?=
 =?us-ascii?Q?N28xIqjTN3aA5h1xSDCbc8zKqKVswKlfPVrzSOUtY+nb7oG/tJb9pUUxVM9W?=
 =?us-ascii?Q?51bOi+NOcUvTdh1wmchd08CW0WkwEHf+d+F6OrL40Lr/OgAIkK3Cc3nKElI7?=
 =?us-ascii?Q?0WKh0K4vpQ8Qcvd5/wm0VT3D94GJ?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EC982FA3852EC245BAA3EDCCCE7F7866@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5578.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc66a51b-804c-49fe-4d52-08d955afe3e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2021 12:20:17.8568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DGgJP1i6A2M2U3GtWeFpnvcFCrvZgE7MY/tc7rVy+74dn5WJ3jR0/e25ldOnqlRxlVuDa4gA0Z017W/3K79QxZ/BzYHNry4uRDnJanvWJCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7895
X-Proofpoint-ORIG-GUID: 0Oxqt4L1lx01Nm8NkOKXK9DwWHwLb7NK
X-Proofpoint-GUID: 0Oxqt4L1lx01Nm8NkOKXK9DwWHwLb7NK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-02_05:2021-08-02,2021-08-02 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On 30 Jul 2021, at 18:28, Eric W. Biederman <ebiederm@xmission.com> wrote=
:
>=20
> Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com> writes:
>=20
>> This patch follows up on a previous RFC:
>> 20210714152426.216217-1-tiberiu.georgescu@nutanix.com
>>=20
>> When a page allocated using the MAP_SHARED flag is swapped out, its page=
map
>> entry is cleared. In many cases, there is no difference between swapped-=
out
>> shared pages and newly allocated, non-dirty pages in the pagemap
>> interface.
>=20
> What is the point?

The reason why this patch is important has been discussed in my RFC
patch and on this thread:
https://lore.kernel.org/lkml/20210715201651.212134-1-peterx@redhat.com/.
The most relevant reply should be Ivan's:
https://lore.kernel.org/lkml/CY4PR0201MB3460E372956C0E1B8D33F904E9E39@CY4PR=
0201MB3460.namprd02.prod.outlook.com/

In short, this swap information helps us enhance live migration in some cas=
es.
>=20
> You say a shared swapped out page is the same as a clean shared page
> and you are exactly correct.  What is the point in knowing a shared
> page was swapped out?  What does is the gain?
>=20
What I meant was that shared swapped out pages and clean shared pages
have their ptes identical pre-patch. I understand they are somewhat similar
concepts when it comes to file shared pages, where swapping is done
directly on the disk.

Our case focuses on anonymous pages and shared pages with identical=20
underlying behaviour (like pages allocated using memfd). These pages get=20
cleared once the runtime is over, and the difference between allocated,
but uninitialised pages, and dirty pages that have been swapped out is=20
significant, as the former could still contain usable data.

The post-patch pagemap entry now contains the swap type and offset for
swapped out pages, regardless of whether the page is private or shared.
This, by definition of the pagemap, should be the correct behaviour.

> I tried to understand the point by looking at your numbers below
> and everything I could see looked worse post patch.

Indeed, the numbers are mostly bigger post-patch. It is a tradeoff between
correctness and performance. However, the tradeoff is not inconvenient on s=
parse=20
single accesses, and it can be made significantly faster by leveraging batc=
hing.
In future work, the performance can be improved by leveraging a mechanism=20
proposed by Peter Xu: Special PTEs:
https://lore.kernel.org/lkml/20210715201422.211004-1-peterx@redhat.com/

The main concern of the RFC was that the xarray check would slow down
checking empty pages significantly. Thankfully, we can only see a small=20
overhead when no allocated shared page is dirtied.

>=20
> Eric
>=20
Hope I was able to clarifiy a few things. Now, having laid out the context,
please have another look at my proposed patch.

Thank you,
Tibi=
