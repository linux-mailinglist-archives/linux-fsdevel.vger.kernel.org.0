Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5698A26B632
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 01:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgIOX6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 19:58:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60590 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727019AbgIOOai (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:30:38 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 08FESSJC021672;
        Tue, 15 Sep 2020 07:28:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qrNjkELNcZMxhr8nxXXvYc10ez4yfdFinVtGM94hwi0=;
 b=JD2RUpoFZhaFMkm7YuuM7odt6xFmT1C5VAobpQEN0RwXIz/3UtJ9j44y6plhYgHFyaa9
 GaqgSvuvSR4QHBCmPFzMx4cl69Y1JJd8UROkCv9h1sscJM2fbA4eZvnhCv2X4MawQ9Ok
 c/eLhjvbY6hRHA04YmpWkSs7D3hVaoPdMy8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 33gt0n0d0v-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Sep 2020 07:28:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 15 Sep 2020 07:28:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWjdizuQiFN7jtQVPmTqLci6TykOEA+rMm/YSAT8jADvXV5O9TR4/5JoUBCtlY+WDxNSbHqyOcQJcrw6/B8vyTC3+ETxg4oMOygWjjUNbjNhV74oZwEQzUivfkCS+d59v7kgClKnBybEM7F15SAAdN8U0n3Ntn8+O79j6hR7B/VrjZADfooE1M+q48nxy/jVBbsFRK+QsWxXVunpPPZH41aQPNWe2xYPiPv9Tz4K9RZ74E3EOtOb+V2osfZGhfpkEpdldj5iJ4QvyYyK2+l9qRGKILWLnhPEIEUcgkQxw1NTd+1YqDopq810jFJ26g6JxKuNCJ1T5Yi+c4hQshn7Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrNjkELNcZMxhr8nxXXvYc10ez4yfdFinVtGM94hwi0=;
 b=lMhE+e3txhGjlzdriP7Uz81BZscy1rsrs4XfWjiRsXPi4VPDBqfKo8lVhgXvC1V+mdnlopTW8K/b+cDKlBiG8pJgusC9MTJV4FSdHc3FO0tMOpZpWC+Mbcc3y/FdZyvKF6tJYUy2/i4NA9zji6joNOlIzIqluErYjClPgRnCoFrQkPQETW+s6XTqTQp925sZ8hqAWgWp1AarUC9N19fThyArU1cyojhSXjOe0j1uSkGKS8FOMpaJbnLBN1FC19ynVH7/H8uXWnMLaLY6W+f6Ki4uUBqVkFsdhAqxUqy4Ebr2tmyGKCZmU7rmdqJokFRub5virRKXo8aNkkJOn55zHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrNjkELNcZMxhr8nxXXvYc10ez4yfdFinVtGM94hwi0=;
 b=BJ/aqUTieVc3MEkpHfAjTpYQi6NQC0gmZ0w6RuVlcNNQtnWvpq88weE+mAhB/s7GwnPJp1S+2vZSVtfhadm3ZqTy3peUn2NsBWvTthhDGObvPv+zvHySKRoZRuTkSFdQasNowH/ESwLvBDbAZfuy9F5dDHREqQFVzBiPM+reOOQ=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from MN2PR15MB3582.namprd15.prod.outlook.com (2603:10b6:208:1b5::23)
 by BL0PR1501MB2036.namprd15.prod.outlook.com (2603:10b6:207:1e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 14:28:53 +0000
Received: from MN2PR15MB3582.namprd15.prod.outlook.com
 ([fe80::bd7a:9d1e:2fd0:34e6]) by MN2PR15MB3582.namprd15.prod.outlook.com
 ([fe80::bd7a:9d1e:2fd0:34e6%6]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 14:28:53 +0000
From:   "Chris Mason" <clm@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Michael Larabel <Michael@michaellarabel.com>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Kernel Benchmarking
Date:   Tue, 15 Sep 2020 10:28:50 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <6FCD2FAE-6547-4FF5-9BD7-98FEBCD4CA85@fb.com>
In-Reply-To: <20200914033131.GK6583@casper.infradead.org>
References: <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
 <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <CAHk-=whjhYa3ig0U_mtpoU5Zok_2Y5zTCw8f-THkf1vHRBDNuA@mail.gmail.com>
 <20200913004057.GR12096@dread.disaster.area>
 <CAHk-=wh5Lyr9Tr8wpNDXKeNt=Ngc3jwWaOsN_WbQr+1dAuhJSQ@mail.gmail.com>
 <20200913234503.GS12096@dread.disaster.area>
 <20200914033131.GK6583@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:208:238::9) To MN2PR15MB3582.namprd15.prod.outlook.com
 (2603:10b6:208:1b5::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [100.109.176.102] (2620:10d:c091:480::1:77ef) by MN2PR22CA0004.namprd22.prod.outlook.com (2603:10b6:208:238::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Tue, 15 Sep 2020 14:28:52 +0000
X-Mailer: MailMate (1.13.2r5673)
X-Originating-IP: [2620:10d:c091:480::1:77ef]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 778fdb92-7eb9-4208-b181-08d85983abcc
X-MS-TrafficTypeDiagnostic: BL0PR1501MB2036:
X-Microsoft-Antispam-PRVS: <BL0PR1501MB20369EBE8453BF0CAFD0EAE7D3200@BL0PR1501MB2036.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMGu2aLI3SAjI9qxkw1Gp/Z4y99WZ4M0nbPpPn0t+ElNQglFMNsF5DrrBDf1RihoGf12J6cU34YzxyCEllHwvvrPJ4OstmyG9irw+Ayo8/n6dpX4mDExqvtVGY0mgIa8+zczeYjRCHk0DIO4Xn2EE7yQXlIrpAqmjQbzUbNp79lcKgdAmG8/rk9NpZyudw0XmBgebxJRgJhuKurgQZKRnlxupTS605NZFnRn4a4kB5gaqjoKHD2qEY+ZCgovhb50mprjhxURlHb3n/B9Gc8urSdLV0WDkHWb9J6OT1Pi9nsOQlpmLVdckanEe759UFEV5+m3wM6sXzM94HUtnfAmyP783HJsVLr+apWYaIROUpKfJaO2zkep4h9RzYCvRxfRiDmvch4HE/nfXXwUI/75E2WohLJWH0gqKw2BJO3o+tE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3582.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(136003)(376002)(396003)(956004)(316002)(8676002)(53546011)(36756003)(16526019)(83380400001)(4326008)(52116002)(6916009)(33656002)(8936002)(186003)(7116003)(3480700007)(6486002)(2616005)(478600001)(54906003)(86362001)(66946007)(66556008)(2906002)(5660300002)(66476007)(7416002)(78286007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: s3DXwv3xbpzsWfqenB5pW7RgeY3Ksi7oM4T5kq/o12BUjKKMXJS/KI4zSVZrBuXknwknJlVIzdxP0m1+CyUXZDjfDuwq3wosZm+39WH7N3NuDMNxk27BnL/OwrvF9t+KdLy//n+gEaMHP+gM26VCFw2I1Mrme+BXHB5+mkrj34IZpZnAXTcoxJ4D/fT/4UREQLIdmtBXrVUPBzinyYasXB7z6HVHzjMvkMehvvA/60lLCHV4fomc2K2flSJ908bIfqRQrwD+jJMGdMWAIt2ydey8GomT7Y/P8D+EHCO+k5pcQKMhlGunUDXdFQCi6K/QsPTU7T3ipz7gFvugdA15D2zTrlceNU7c/dM4jnQhuKTenkUQBlxB9+uoqCE46ysodiMwcWc7Ft7NfBo2XyzdBuMykFmS4QlRI1WweLsvXZ+MREpLnfTQ14yFvE3E2GPR7SnnW2q9myVc2hl1zkNeS9mRJDjbLDZZuZrfGfj93MOjpuPFfhQCbVIBVANldWiN4KVhT+zVIJpPoSu+7F/pcF74Eh5J28Yy0mqwCiLHtcy02cNQyDfuJhqT6l023gu8FLqVkNkWhOt6o9Ip6vbGJZy+l0lUT6yThr8rpZlNTWXaGNil3hOrZ546MY5mQyZaIPQ9kliciZ5TqpPIPVJslwaMi4hIQShdnkkirRW7Cw4=
X-MS-Exchange-CrossTenant-Network-Message-Id: 778fdb92-7eb9-4208-b181-08d85983abcc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3582.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 14:28:53.5748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kf+BtS/Jq2lppcJZYv9SO0px04QeTTuFTU1Tyf7yOgPF7wP80tNpSSNiN+mPKomQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2036
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_11:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=685 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150121
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13 Sep 2020, at 23:31, Matthew Wilcox wrote:

> On Mon, Sep 14, 2020 at 09:45:03AM +1000, Dave Chinner wrote:
>> I have my doubts that complex page cache manipulation operations
>> like ->migrate_page that rely exclusively on page and internal mm
>> serialisation are really safe against ->fallocate based invalidation
>> races.  I think they probably also need to be wrapped in the
>> MMAPLOCK, but I don't understand all the locking and constraints
>> that ->migrate_page has and there's been no evidence yet that it's a
>> problem so I've kinda left that alone. I suspect that "no evidence"
>> thing comes from "filesystem people are largely unable to induce
>> page migrations in regression testing" so it has pretty much zero
>> test coverage....
>
> Maybe we can get someone who knows the page migration code to give
> us a hack to induce pretty much constant migration?

While debugging migrate page problems, I usually run dbench and

while(true) ; do echo 1 > /proc/sys/vm/compact_memory ; done

I’ll do this with a mixture of memory pressure or drop_caches or a 
memory hog depending on what I hope to trigger.

Because of hugepage allocations, we tend to bash on migration/compaction 
fairly hard in the fleet.  We do fallocate in some of these workloads as 
well, but I’m sure it doesn’t count as complete coverage for the 
races Dave is worried about.

-chris
