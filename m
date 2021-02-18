Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8F131EA28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 14:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhBRM77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 07:59:59 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:44116 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231610AbhBRMYH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:24:07 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11IC90Wj001227;
        Thu, 18 Feb 2021 04:22:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=qV6HYeyWC8H3czOYoUAvNwwXHM/KUyEiBkalj6UvpO0=;
 b=EylsoqbuZYyYF3pabRJIEAVYV5slyCYpTgUwgrbMuQv+3pD3Fau4O1E+xwNjwl63CqYp
 2k5z5N+MgiH3zaamJPGmoqpdWf1/ongkTO3lKD4nLcr5tAHnerHAlvT4Q8Pjh+LZrdXj
 KrcZ4RMZ0Q3F8ELMNlgrOkiUGliwqKz09qs0QiauUth6CZxw4GFRS12+dcPlXLVHuYr5
 xHtgyTBvFE8vtdlGpilzXIjd8KjwN0ivjkvx3Giab0FJ9FtnNw/j43O75p5w/EXvlIE+
 M1K433cp8d8EFT/dLYITW0wbTY/Mc/Tq9UDuiZ4NDyalCqdDQj9jPLsaoPbQhokKCKFl sw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by mx0b-002c1b01.pphosted.com with ESMTP id 36peyn2vqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 04:22:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gll8vk/HHnzhGrVIr4CgapPScTSDaw+J4y4itq3BufxBPJHjcsUDMcmBm/sntOKq/ab5UvMsP2eexdIJowLDoxz7srLDsKTKd/EwZhFqMkVhNvAWVOgOdpK5LEYdwKFbbxou+bHbMOz1g9WA96ngL/ErDTxA0KG7aq+oa9cc1FSt1xliqEydMTuX3hbewOi27QX23xWC8c26nQuM84sF1gJJS3yebTA9obhCXB/eeliOI/CvYljPhPeHsfAM3+fznsptlzOUtXgMBCtmnK8NON9NYTlW6XIzkxScsbStsPK56ThFFfU4epDnoA8slsvKiNOydgwdBynOuepQIXqSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV6HYeyWC8H3czOYoUAvNwwXHM/KUyEiBkalj6UvpO0=;
 b=kXZCZXM8TgxdDutxLBt62S3WkM6nf3syP55aH5Pu9t3hMqMHWOLtgHtNMAOnZtRMXBdDuedHxGIz/civX4Zkq0Axa1ITC5gVHQn2ETmIGg3U0hav1rwUkhk29jb+XA5UkZRuNpXLCIMzShXiduWJXTlwuvAX/qUD/+K6iMKchluoFcQM5aJtet44+ty6slE2DYdq1gLHBYZNQI8/574Obr5ypx7nbtbpByskspAMZcOnM3WYZo4OjdsfQgnHL1TpKA5+3igVcF5Dn5/W2abBffBbDJvVIviWN4ylzXmc994Dvih8qZ8xHmMsLs8AkaJ+j+foo5PTTUxITTUqRo0BkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from DM6PR02MB6250.namprd02.prod.outlook.com (2603:10b6:5:1f5::26)
 by DM6PR02MB4106.namprd02.prod.outlook.com (2603:10b6:5:9f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 18 Feb
 2021 12:22:37 +0000
Received: from DM6PR02MB6250.namprd02.prod.outlook.com
 ([fe80::6059:b0b7:ce3e:cb7e]) by DM6PR02MB6250.namprd02.prod.outlook.com
 ([fe80::6059:b0b7:ce3e:cb7e%6]) with mapi id 15.20.3846.039; Thu, 18 Feb 2021
 12:22:37 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Mike Kravetz <mike.kravetz@oracle.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Felipe Franciosi <felipe@nutanix.com>,
        "shakeelb@google.com" <shakeelb@google.com>
Subject: Re: [RFC PATCH] mm, oom: introduce vm.sacrifice_hugepage_on_oom
Thread-Topic: [RFC PATCH] mm, oom: introduce vm.sacrifice_hugepage_on_oom
Thread-Index: AQHXBBDlHFjialWl9UGQ+pFSTaCvrqpabtKAgADvpICAAJ5jgIAALiuAgAAeYACAAY/1AA==
Date:   Thu, 18 Feb 2021 12:22:37 +0000
Message-ID: <99FF105C-1AAB-40F3-9C13-7BDA23AD89D9@nutanix.com>
References: <20210216030713.79101-1-eiichi.tsukata@nutanix.com>
 <YCt+cVvWPbWvt2rG@dhcp22.suse.cz>
 <bb3508e7-48d1-fa1b-f1a0-7f42be55ed9c@oracle.com>
 <YCzMVa5QSyUtlmnI@dhcp22.suse.cz>
 <D66DC6A7-C708-4888-8FCF-E4EB0F90ED48@nutanix.com>
 <YC0MiqwCGp90Oj4N@dhcp22.suse.cz>
In-Reply-To: <YC0MiqwCGp90Oj4N@dhcp22.suse.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [114.159.158.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 207337e0-3c6a-43ea-c6e9-08d8d407e10b
x-ms-traffictypediagnostic: DM6PR02MB4106:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB4106CC2A14E3F174EA1C92F380859@DM6PR02MB4106.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sRLpYy+J47fDZIgmvLkqvc2jzA7yZW++gxfOa3a1Sm5AZPhFyi4tWFU3VB0S5Y4J+OxxbtZySvzSRUKpoGvCepe5ni1CgDNA9CCfcNKs5jyjbmTwylebPjqnOWBUPb1CzSTQoFzNO4S8YaN+rLiwkJl9xjvnwptNmArmb3R/785SszxqO697Vu6ihYDtQtncrtWaNQOV29RJcDDORXpM/hGvdQzkGru13cRZfF17cFviMeVA3EIEqlNoDFtQ1YK1h+ZCvUGBLjQE89El46UwN//GoFU+dVnpb3oSF2TJH1ApBir0M75fk5IMXK7vX38c5VC7cGJVNT4O1chXqQ9BLJ2W9o5VDAXloQE6nx+nG4NiZ9NrUt9PsiM/MFKjWURJn32RG9ThWgXx8Oks2u2S3Gal3w3ieRKFODGe7YJ95XTI5L+1AdhH1/WBiYu3iKvXtl5SOwx7Sv1govRPJWiCIaHd+iNBnG0a6f9njav3KQAopztOvcR3FHKxERbgPtmLxYSa3NYy8tQRwlWyl+7zhtRpMg6mLEHStYHgfEKTQihe9nF/OmiUSdOHhZxkadcvWaAQsH20DNnXeqjWn0XN7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB6250.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(366004)(136003)(376002)(83380400001)(6486002)(66446008)(6506007)(8676002)(7416002)(64756008)(36756003)(4326008)(2906002)(478600001)(66476007)(2616005)(44832011)(26005)(54906003)(66946007)(5660300002)(66556008)(86362001)(6916009)(186003)(6512007)(76116006)(316002)(91956017)(33656002)(53546011)(8936002)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Vmfwy75FD7uVL6sF/P8uZ/gLx87fD37q+Kw5ijQDPCu7bOhCUrbtFWzum/dl?=
 =?us-ascii?Q?NETdZ5bhbpOXEeRmH5vSO/mal3EfMNldGE5FDLVxK5R2IW0iSm+KI67gwWKm?=
 =?us-ascii?Q?qw/9tS+2KywydIJyDxpO/lhi1dA7/Mo1M0MEZP3Y+DVh4k2ebSF926hc59AP?=
 =?us-ascii?Q?d9ovufoAFz/C0WMq2tqMhFmWlOquftLtCBJmbuxk9DIdX6R6iyh7X57PoFzI?=
 =?us-ascii?Q?nqvJEjiNs0l09LvdKqEvCzmzTz6y/yvL2xhgxh0WWamC7Htd4mA4P7Eabtw6?=
 =?us-ascii?Q?2sxUjqbRvPQLUyavDL3Eul7CbuPRRN1wUw1HJEf1DT3drpR+EcLFbFioirHp?=
 =?us-ascii?Q?reb59PXjWgTVqeVP1byfpnAednV0qCU5iQZMX6EJyPpJUp2QwUYuT3VdXLyw?=
 =?us-ascii?Q?2Vfbnn3Qy6I0fM0uGD5Jd443JRDODjwdCvqU7VSUNpQmesFBq7ZLIcXBGSlC?=
 =?us-ascii?Q?peb8BgPLvYiUJWeHYT0/xBzSx9wLksNQAoTiswZ1l0wHKfsorFHMND6RftAN?=
 =?us-ascii?Q?6iL8dc25FuYvkgmTixI0y0bvtdusQDGWDGrD71iZ3BkNjMAN6XVT8isnNV8Q?=
 =?us-ascii?Q?/Pg7g2KOOrFACrkh3Kv1giYB1wXKriIQlCS8f5r+8w+8tJp3Ym+mNYNt0Eh2?=
 =?us-ascii?Q?rUU1tSYAedwLjD1K+doHN8Wt+UgcyTZt2tXZrS5BxTI0MyrP6lY+mGzbE8mB?=
 =?us-ascii?Q?gQELRZy9OUkQzp+Mn+cOg23xUbB6QPiLrJwpqDN5JVCNKKHgReWsBB+dzoV3?=
 =?us-ascii?Q?ilguiOwlNznsShfX/Wll6NHK9Qw8ZBEcQFDa83ndneM5GTrEWzWvc014GuF5?=
 =?us-ascii?Q?ttz90QBdxpFG08ZEasp7CUIaBD28/fjdPz3WTgIVXZmvrNDK43wEHUnZoPUS?=
 =?us-ascii?Q?Fw0I2mOiYBsLAEqHEmA6yFvhB9tfC6FF/CbJ7xnP6MIm26mf4FYGJtqQfghA?=
 =?us-ascii?Q?U34SYROBrMQpl25zLdqk4SOqCFrWDDPp+L2bcGMADgl3w2imO46GiSXWjhtV?=
 =?us-ascii?Q?w//K3V8uijcq/u3XduNjNDgKUY3yz2piMI5C0ZlxleXUkA+knOteNWKOyOTF?=
 =?us-ascii?Q?tUhA8DEL1I/c4kGHH5Kt3bWE+gLpooizlAr/tvVSXKwUFTpuybXk+DRlkDes?=
 =?us-ascii?Q?6cs/q0STrvT/qZcRsGunClk2QZbMs2dMhtAIWcWH2q11AVvRIJp6U+MXAMfK?=
 =?us-ascii?Q?R3lEhrNhwyc7Xuqissu4lhW3yr33vphJRJl4dxADvqYhZpM1IvVSSNk5o139?=
 =?us-ascii?Q?3GoshpYq39hKyA2Q1B1xgV19KJAz9OblHOehXNae0/u2Nxss/BmjHtsO6xHr?=
 =?us-ascii?Q?rhKF27xoGQBGwuEvOiL6p6Tz?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B2B3AD51813AFE4A8E509158CEE22435@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6250.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207337e0-3c6a-43ea-c6e9-08d8d407e10b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 12:22:37.7800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y9EJdkkrLnmJ3O5D1ewWFvTQzhVEGgcmtiy/RUdiE2LkviLEWc8cCCkvqwRQ7LWjQroiSI2uTRUGGaUZPnYWNw4BTDHOR/JELI7Rc8Au1b8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4106
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_05:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Michal

> On Feb 17, 2021, at 21:31, Michal Hocko <mhocko@suse.com> wrote:
>=20
> On Wed 17-02-21 10:42:24, Eiichi Tsukata wrote:
>> Hi All,
>>=20
>> Firstly, thank you for your careful review and attention to my patch
>> (and apologies for top-posting!).  Let me first explain why our use
>> case requires hugetlb over THP and then elaborate on the difficulty we
>> have to maintain the correct number of hugepages in the pool, finally
>> concluding with why the proposed approach would help us. Hopefully you
>> can extend it to other use cases and justify the proposal.
>>=20
>> We use Linux to operate a KVM-based hypervisor. Using hugepages to
>> back VM memory significantly increases performance and density. Each
>> VM incurs a 4k regular page overhead which can vary drastically even
>> at runtime (eg. depending on network traffic). In addition, the
>> software doesn't know upfront if users will power on one large VM or
>> several small VMs.
>>=20
>> To manage the varying balance of 4k pages vs. hugepages, we originally
>> leveraged THP. However, constant fragmentation due to VM power cycles,
>> the varying overhead I mentioned above, and other operations like
>> reconfiguration of NIC RX buffers resulted in two problems:
>> 1) There were no guarantees hugepages would be used; and
>> 2) Constant memory compaction incurred a measurable overhead.
>>=20
>> Having a userspace service managing hugetlb gave us significant
>> performance advantages and much needed determinism. It chooses when to
>> try and create more hugepages as well as how many hugepages to go
>> after. Elements like how many hugepages it actually gets, combined
>> with what operations are happening on the host, allow our service to
>> make educated decisions about when to compact memory, drop caches, and
>> retry growing (or shrinking) the pool.
>=20
> OK, thanks for the clarification. Just to make sure I understand. This
> means that you are pro-activelly and optimistically pre-allocate hugetlb
> pages even when there is no immediate need for those, right?

Right, but this is not a "pre-allocation just in case". We need to
know how many hugepages are available for VM memory upfront. That
allows us to plan for disaster scenarios where a host goes down and we
need to restart VMs in other hosts. In addition, going from zero to
TBs worth of hugepages may take a long time and makes VM power on
times too slow. Of course in bloat conditions we could lose hugepages
we pre-allocated, but our placement models can react to that.


>=20
>> But that comes with a challenge: despite listening on cgroup for
>> pressure notifications (which happen from those runtime events we do
>> not control),
>=20
> We do also have global pressure (PSI) counters. Have you tried to look
> into those and try to back off even when the situation becomes critical?

Yes. PSI counters help us to some extent. But we've found that in some case=
s
OOM can happen before we observe memory pressure if memory bloat occurred
rapidly. The proposed failsafe mechanism can cover even such a situation.
Also, as I mentioned in commit message, oom notifiers doesn't work if OOM
is triggered by memory allocation for kernel.

>=20
>> the service is not guaranteed to sacrifice hugepages
>> fast enough and that causes an OOM. The killer will normally take out
>> a VM even if there are plenty of unused hugepages and that's obviously
>> disruptive for users. For us, free hugepages are almost always expendabl=
e.
>>=20
>> For the bloat cases which are predictable, a memory management service
>> can adjust the hugepage pool size ahead of time. But it can be hard to
>> anticipate all scenarios, and some can be very volatile. Having a
>> failsafe mechanism as proposed in this patch offers invaluable
>> protection when things are missed.
>>=20
>> The proposal solves this problem by sacrificing hugepages inline even
>> when the pressure comes from kernel allocations. The userspace service
>> can later readjust the pool size without being under pressure. Given
>> this is configurable, and defaults to being off, we thought it would
>> be a nice addition to the kernel and appreciated by other users that
>> may have similar requirements.
>=20
> Thanks for your usecase description. It helped me to understand what you
> are doing and how this can be really useful for your particular setup.
> This is really a very specific situation from my POV. I am not yet sure
> this is generic enough to warrant for a yet another tunable. One thing
> you can do [1] is to
> hook into oom notifiers interface (register_oom_notifier) and release
> pages from the callback. Why is that batter than a global tunable?
> For one thing you can make the implementation tailored to your specific
> usecase. As the review feedback has shown this would be more tricky to
> be done in a general case. Unlike a generic solution it would allow you
> to coordinate with your userspace if you need. Would something like that
> work for you?

Thanks for your suggestion. Implementing our own oom handler using
register_oom_notifier in out-of-tree kernel module is actually one of our
options. The intention of this RFC patch is to share the idea and know
the needs from other users who may have similar requirements.

As for the implementation, I'm considering to make the behavior of
sacrifice_hugepage() corresponds to decrementing vm.nr_hugepages param.
Of course any suggestions are always welcome.

Eiichi

>=20
> ---
> [1] and I have to say I hate myself for suggesting that because I was
> really hoping this interface would go away. But the reality disagrees so
> I gave up on that goal...
> --=20
> Michal Hocko
> SUSE Labs

