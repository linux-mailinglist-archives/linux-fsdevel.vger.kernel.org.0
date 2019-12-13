Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A97E411DBB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 02:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbfLMBca (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 20:32:30 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5314 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727070AbfLMBca (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 20:32:30 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBD1TNSi016789;
        Thu, 12 Dec 2019 17:32:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=2KNVzVM2kUItAfJ5cvyp8GdVfELXumXuvDr4Ww5ueQk=;
 b=DVCUBXTp8CiSDsa92dpCoyXY+szdDaNowpMjCdm6eHmKyJpywY5v6ZLKYsaLiHyxWWh/
 lBLgqIJykkePfDJOQuPN9qvK95/W10xg7AsSYj5GhXj1OCdMW/TpdKBFduxSbji1weBM
 i4NH3M8Ko681L35fiaH0aKu+2fTYjeBwf80= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wuskg2be2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Dec 2019 17:32:13 -0800
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Dec 2019 17:32:11 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Dec 2019 17:32:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcVXsLAhLoxbUGlWNNRxFBMfnxVp/gM7/uDpos0f/QvcRpjGKVGtrXHvt4T+T/n5gdZnZjyooxUKp0vdoyyyzUNypqRivGNQUQ/pyqZjaWYMjgj5fTgnptuD23anSGWFHaXAo9iaKV27+B0PqDONp3Oh14j8JmXWXIAAo5DRP40kSfeGXXMYbPh03HdkzeW4ZV5JZ9vMCQusHuLIkXhn4amqn97K4D2n8Iel9JtjsYLLwRaGf+2EivAj4RTnllvYe8YVSq+/uwDzwRIo4nWO/zm49EJpkTniQnrhjEfMII6N0+hrJWO6WxHsfq9KoEPGt3sbrZU+Jc3PG0v8puQQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KNVzVM2kUItAfJ5cvyp8GdVfELXumXuvDr4Ww5ueQk=;
 b=WkTPLQj+yI8io/IkojDerTM3bCcLJ4k9l+lHnMQYh3zhVkL62Kfg9nWgVAcZsc9H6LWNs97zVDY/oDatQO5/caJobUTKLVYiM16VwgcJE2NgliWKzHJcJiwhVh4xXYjznyCts5C8b9vV8rEmjXKLdZGXAVph8ILXMbMb14zwqkxk6McGaliR/G8rpv4eJCGvWjL89mn9KKxv511FFJFFwJfkor+oHYl3w9OosWLopTLrQ7bJg/1urN11iAGN9wSMYQ8cipRPZXc1bPBToP01TgMFMX78od82iCw1hd5zGbeKK0qpoAL1+OgRabjExoZgfXqaKmg+nexyMRbI2xq8WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KNVzVM2kUItAfJ5cvyp8GdVfELXumXuvDr4Ww5ueQk=;
 b=IEkqI5BMjDZHdbV3t2/rC+px57006LmW1GirXTUn5re2KNW+jH0IDvT4GTzaGdytnrWPq62eokF1SwIpp06ni8blZZrAYDGsn6PLPDugHIJeHlp21FAaZgLcpdFqkJLoB5eJPbhA7y8die+2R7+2taKytRhOQlS1Ei2nTNNpxCc=
Received: from SN6PR15MB2446.namprd15.prod.outlook.com (52.135.64.153) by
 SN6PR15MB2367.namprd15.prod.outlook.com (52.132.124.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Fri, 13 Dec 2019 01:32:10 +0000
Received: from SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::21bd:84c5:4e24:4695]) by SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::21bd:84c5:4e24:4695%6]) with mapi id 15.20.2538.017; Fri, 13 Dec 2019
 01:32:10 +0000
From:   Chris Mason <clm@fb.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
Thread-Topic: [PATCHSET v3 0/5] Support for RWF_UNCACHED
Thread-Index: AQHVsDfZCAhJpFV97UaB5wo39Jtv8ae1MtkAgAAFQoCAABuEAIAACAuAgAABbACAAALSAIAAOMgAgAAYaQCAAWKTAIAANieA
Date:   Fri, 13 Dec 2019 01:32:10 +0000
Message-ID: <C08B7F86-C3D6-47C6-AB17-6F234EA33687@fb.com>
References: <20191211152943.2933-1-axboe@kernel.dk>
 <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
 <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
 <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk>
 <e7fc6b37-8106-4fe2-479c-05c3f2b1c1f1@kernel.dk>
 <20191212221818.GG19213@dread.disaster.area>
In-Reply-To: <20191212221818.GG19213@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.10r5443)
x-clientproxiedby: MN2PR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:208:e8::29) To SN6PR15MB2446.namprd15.prod.outlook.com
 (2603:10b6:805:22::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::326]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcdde16c-1fcc-4284-cbea-08d77f6c45dc
x-ms-traffictypediagnostic: SN6PR15MB2367:
x-microsoft-antispam-prvs: <SN6PR15MB2367529B68DCBC7EAB26B6EAD3540@SN6PR15MB2367.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(376002)(366004)(396003)(189003)(199004)(51444003)(478600001)(2616005)(6486002)(71200400001)(81156014)(5660300002)(186003)(6916009)(53546011)(6506007)(8936002)(52116002)(8676002)(81166006)(54906003)(86362001)(2906002)(316002)(36756003)(33656002)(6512007)(66446008)(64756008)(66946007)(66476007)(66556008)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2367;H:SN6PR15MB2446.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cSxGGaXGUMcQWDYgWSWcXPGqbqsdgnYh6P9d6liy7LGctFX8/ZZkrHja381H+1kD1AxkAhVWZq0bids3BeK3w5Wa8H52zMAbS4SFwRazI3kwL5wtPjOdWRpGp4zKY7O82oNf0rpOb6VxC6Yc9g0KTpFf5sF/XFp1q4xbIUYgWzyjpEK0mPwnDogESUSv4d1ggUF9ss32aWkS8TG4Ty5++2/kzXTXUDe6SRmk/1LnOh3ejvtokx+9Zap20oaj6+mXrWvuaJjdm58wvDIDs1XCVetuH1c9WcdZdtozf5e8u9S5UgHKwqICk+0rmiP1H3bUrLWnaQkUL2ziEB+nbvMD6K68DQOC4l+b5s9P8hk8aAbc0UXBxGV/Az/76CIi4foilxNo6nCNtS7mecBrJjONSjhTGO3xDWebh87/lMCEzYrqQ58F2OG3SNwQArr+w8QEZ87NTb7adPGqmOfGdJVQulTb5fSUtpkUN9QAkk2Q77E2uPw3M67D4wucpyjQlLSp
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdde16c-1fcc-4284-cbea-08d77f6c45dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 01:32:10.4046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OJTJm9xGPEBF0evSqumb8pAubewak+JHM2Yw7/y4nUeNILC5mnB39T6WMyi2DjIE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2367
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_08:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=854
 suspectscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912130010
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12 Dec 2019, at 17:18, Dave Chinner wrote:

> On Wed, Dec 11, 2019 at 06:09:14PM -0700, Jens Axboe wrote:
>>
>> So Chris and I started talking about this, and pondered "what would
>> happen if we simply bypassed the page cache completely?". Case in=20
>> point,
>> see below incremental patch. We still do the page cache lookup, and=20
>> use
>> that page to copy from if it's there. If the page isn't there,=20
>> allocate
>> one and do IO to it, but DON'T add it to the page cache. With that,
>> we're almost at O_DIRECT levels of performance for the 4k read case,
>> without 1-2%. I think 512b would look awesome, but we're reading full
>> pages, so that won't really help us much. Compared to the previous
>> uncached method, this is 30% faster on this device. That's=20
>> substantial.
>
> Interesting idea, but this seems like it is just direct IO with
> kernel pages and a memcpy() rather than just mapping user pages, but
> has none of the advantages of direct IO in that we can run reads and
> writes concurrently because it's going through the buffered IO path.
>
> It also needs all the special DIO truncate/hole punch serialisation
> mechanisms to be propagated into the buffered IO path - the
> requirement for inode_dio_wait() serialisation is something I'm
> trying to remove from XFS, not have to add into more paths. And it
> introduces the same issues with other buffered read/mmap access to
> the same file ranges as direct IO has.
>
>> Obviously this has issues with truncate that would need to be=20
>> resolved,
>> and it's definitely dirtier. But the performance is very enticing...
>
> At which point I have to ask: why are we considering repeating the
> mistakes that were made with direct IO?  Yes, it might be faster
> than a coherent RWF_UNCACHED IO implementation, but I don't think
> making it more like O_DIRECT is worth the price.
>
> And, ultimately, RWF_UNCACHED will never be as fast as direct IO
> because it *requires* the CPU to copy the data at least once.

They just have different tradeoffs.  O_DIRECT actively blows away caches=20
and can also force writes during reads, making RWF_UNCACHED a more=20
natural fit for some applications.  There are fewer surprises, and some=20
services are willing to pay for flexibility with a memcpy.  In general,=20
they still want to do some cache management because it reduces p90+=20
latencies across the board, and gives them more control over which pages=20
stay in cache.

Most services using buffered IO here as part of their main workload are=20
pairing it with sync_file_range() and sometimes fadvise DONT_NEED. =20
We've seen kswapd saturating cores with much slower flash than the fancy=20
stuff Jens is using, and the solution is usually O_DIRECT or fadvise.

Grepping through the code shows a wonderful assortment of helpers to=20
control the cache, and RWF_UNCACHED would be both cleaner and faster=20
than what we have today.  I'm on the fence about asking for=20
RWF_FILE_RANGE_WRITE (+/- naming) to force writes to start without=20
pitching pages, but we can talk to some service owners to see how useful=20
that would be.   They can always chain a sync_file_range() in io_uring,=20
but RWF_ would be lower overhead if it were a common pattern.

With all of that said, I really agree that xfs+O_DIRECT wins on write=20
concurrency.  Jens's current patches are a great first step, but I think=20
that if he really loved us, Jens would carve up a concurrent pageless=20
write patch series before Christmas.

> Direct
> IO is zero-copy, and so it's always going to have lower overhead
> than RWF_UNCACHED, and so when CPU or memory bandwidth is the
> limiting facter, O_DIRECT will always be faster.
>
> IOWs, I think trying to make RWF_UNCACHED as fast as O_DIRECT is a
> fool's game and attempting to do so is taking a step in the wrong
> direction architecturally.  I'd much prefer a sane IO model for
> RWF_UNCACHED that provides coherency w/ mmap and other buffered IO
> than compromise these things in the chase for ultimate performance.

No matter what I wrote in my letters to Santa this year, I agree that we=20
shouldn't compromise on avoiding the warts from O_DIRECT.

-chris
