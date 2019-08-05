Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9925A824E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 20:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbfHESc6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 14:32:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8612 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728885AbfHESc6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:32:58 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x75IRJNu002185;
        Mon, 5 Aug 2019 11:32:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=9qbfXk1Lco1cPfrw8/mqGA0q+VdFy7WDWzD1hMZHuus=;
 b=ma3t1IX8PYl5s8rvpVzdCj2aybWxwfNsKD8PV6TgPHRzJ3pkeQFlCWil0ksLYxjOLaoW
 mrPCGwfSjzJ6+7T+kh/uZ9E8mEYaCdVjPLbM/z3tl6lg3Msyx78QmrQpju1f3r5GS9YL
 L8fTYD+tdm9BU0JUXXExqMIZMxo0vBwvZpw= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2u55xdy6bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 05 Aug 2019 11:32:54 -0700
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 5 Aug 2019 11:32:53 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 5 Aug 2019 11:32:53 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 5 Aug 2019 11:32:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ma3wNNmc+pFEYsEZL8jwATk9SILxX24OX+nehT9FqRmLsNQvwXXBl5SvjgSxXGS7pk6f7gOq8iIATRVEC51tsbljMLAQY9JgplaQhuptstvtBLQ1NmWWhiUHdI3XCsC0/HhKA1HK0y+FWf26L+QutwHojR2LtoWUwyT+03UQyCTTdKdRy6H2KcDSrQJYbxSTC6tz4tuF6DG4qbVbiRQNVIM/hxMkVubAYts+CqVJUGaY1nroftaxHj8XbgoM90NHO8mLVHPN2sDHB+I7QBAQYxSHlu6idiqHzeydncJMKmrxDD3v4ucTvP2z13CXLhXx9RClraUlbai8ul9HBU4ylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qbfXk1Lco1cPfrw8/mqGA0q+VdFy7WDWzD1hMZHuus=;
 b=ANQHyPgsbfxQCzpIJ8WvuSBDmipph0Oc66VJ1tJ+ny0HsE4ZIUe+bv5TA4Zv+NPvYCUEc2RUPsgpvZ/t73CvcjXLEjC2TlhCDvhJuBXx/zTUSX3e0UODsLKqm+eYOJARS/qEcoWD1O3X1N7bi2ZBx2+DrOl5RZ2EePCZ21ZeFfxnp45iG1jK6y/5FpDcRO4IRUAPtwkHVqt2sYMnaz4QmBDqMA82dlIQ2F618/Uc8LKFYUdMP+5r32ki3kHsM+PWhxn8Bwi2IalUPLyJyEVU/ocIvgcp6x4yYeiy+ZkjBWYcPusg2898xC+O3fqe/IdT/9Ucr88ZzKLNxT5bhWfs6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qbfXk1Lco1cPfrw8/mqGA0q+VdFy7WDWzD1hMZHuus=;
 b=O58nXwccK3qE9Yckg0LLNFtU3y8k8xKmi4WOOlUX+mCrmDJAx102EzM6h0KvCQsI49GmHMMW250FVoM9V8snPxpr2NERXcUSoPuqCBo2DGa4qN6CYtDHjZRgNCaF4FanE4YLpbJ9XY+ridJth2Ns4DPx4trGYdiUMqzAF5K6mq8=
Received: from DM5PR15MB1290.namprd15.prod.outlook.com (10.173.212.17) by
 DM5PR15MB1227.namprd15.prod.outlook.com (10.173.209.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 18:32:51 +0000
Received: from DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::4d32:13fc:cf5b:4746]) by DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::4d32:13fc:cf5b:4746%7]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 18:32:51 +0000
From:   Chris Mason <clm@fb.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 09/24] xfs: don't allow log IO to be throttled
Thread-Topic: [PATCH 09/24] xfs: don't allow log IO to be throttled
Thread-Index: AQHVSA9fnWuPStnf6EeOPJMMPtRTUqbmCewAgADwFYCAAO5UAIAAm3UAgARkcwA=
Date:   Mon, 5 Aug 2019 18:32:51 +0000
Message-ID: <C823BAA1-18D5-4C25-9506-59A740817E8C@fb.com>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-10-david@fromorbit.com>
 <F1E7CC65-D2CB-4078-9AA3-9D172ECDE17B@fb.com>
 <20190801235849.GO7777@dread.disaster.area>
 <7093F5C3-53D2-4C49-9C0D-64B20C565D18@fb.com>
 <20190802232814.GP7777@dread.disaster.area>
In-Reply-To: <20190802232814.GP7777@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.12.5r5635)
x-clientproxiedby: MN2PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:208:134::34) To DM5PR15MB1290.namprd15.prod.outlook.com
 (2603:10b6:3:b8::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::1e29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c6ed047-c29b-4882-47b2-08d719d35285
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR15MB1227;
x-ms-traffictypediagnostic: DM5PR15MB1227:
x-microsoft-antispam-prvs: <DM5PR15MB1227DB1CFB86A63FD3D4FA0FD3DA0@DM5PR15MB1227.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(136003)(396003)(39860400002)(51444003)(189003)(199004)(66946007)(76176011)(68736007)(25786009)(46003)(6916009)(81156014)(71190400001)(6512007)(33656002)(81166006)(2906002)(6486002)(229853002)(6116002)(6436002)(53936002)(54906003)(6506007)(386003)(4326008)(50226002)(36756003)(446003)(52116002)(11346002)(2616005)(486006)(476003)(186003)(6246003)(99286004)(7736002)(71200400001)(305945005)(86362001)(14454004)(8676002)(5660300002)(8936002)(66476007)(256004)(66556008)(316002)(53546011)(102836004)(66446008)(64756008)(478600001)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1227;H:DM5PR15MB1290.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pv1nSFJBqcrMtZIVyFkO/DliXWIxTLCi5wqnNfVwf9527AbfyPNInwq9NfdhrKBPALdwnp1D7z89KC5GqbFFtEBiS54d9A1nB3u6soTQB8+rM1hz4p8f7fvB59dzvSz8UDsVYKw9ctfcudj0Zadi5Cm+XMkV7QTTVyEfH677YhzLCHnsAlGWnQikHp8W0k3260PrfbozOATxfF9f/dHvwp8vFVksX8qRRqGeAiZKshcN4S9yKz4gLEAlYQeyYrqlvkc+5GnPMs1flZ1Ac0eFXVxceOsmxjF5synBvIrzktCGdNsdIcHApcHs8m/NcmK3kf86cKctPgusHOajvwPnrREOM2LHdat/HtcsSy8qOWZDyz6gmAkPjpraqNaPl3Hcibpjg8JREf5Nj6Kxul6Nx0E+sYNMDmKy5Qs1U6CMQmI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6ed047-c29b-4882-47b2-08d719d35285
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 18:32:51.3723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clm@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1227
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908050189
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2 Aug 2019, at 19:28, Dave Chinner wrote:

> On Fri, Aug 02, 2019 at 02:11:53PM +0000, Chris Mason wrote:
>> On 1 Aug 2019, at 19:58, Dave Chinner wrote:
>> I can't really see bio->b_ioprio working without the rest of the IO
>> controller logic creating a sensible system,
>
> That's exactly the problem we need to solve. The current situation
> is ... untenable. Regardless of whether the io.latency controller
> works well, the fact is that the wbt subsystem is active on -all-
> configurations and the way it "prioritises" is completely broken.

Completely broken is probably a little strong.   Before wbt, it was=20
impossible to do buffered IO without periodically saturating the drive=20
in unexpected ways.  We've got a lot of data showing it helping, and=20
it's pretty easy to setup a new A/B experiment to demonstrate it's=20
usefulness in current kernels.  But that doesn't mean it's perfect.

>
>> framework to define weights etc.  My question is if it's worth trying
>> inside of the wbt code, or if we should just let the metadata go
>> through.
>
> As I said, that doesn't  solve the problem. We /want/ critical
> journal IO to have higher priority that background metadata
> writeback. Just ignoring REQ_META doesn't help us there - it just
> moves the priority inversion to blocking on request queue tags.

Does XFS background metadata IO ever get waited on by critical journal=20
threads?  My understanding is that all of the filesystems do this from=20
time to time.  Without a way to bump the priority of throttled=20
background metadata IO, I can't see how to avoid prio inversions without=20
running background metadata at the same prio as all of the critical=20
journal IO.

>
>> Tejun reminded me that in a lot of ways, swap is user IO and it's
>> actually fine to have it prioritized at the same level as user IO. =20
>> We
>
> I think that's wrong. Swap *in* could have user priority but swap
> *out* is global as there is no guarantee that the page being swapped
> belongs to the user context that is reclaiming memory.
>
> Lots of other user and kernel reclaim contexts may be waiting on
> that swap to complete, so it's important that swap out is not
> arbitrarily delayed or susceptible to priority inversions. i.e. swap
> out must take priority over swap-in and other user IO because that
> IO may require allocation to make progress via swapping to free
> "user" file data cached in memory....
>
>> don't want to let a low prio app thrash the drive swapping things in=20
>> and
>> out all the time,
>
> Low priority apps will be throttled on *swap in* IO - i.e. by their
> incoming memory demand. High priority apps should be swapping out
> low priority app memory if there are shortages - that's what priority
> defines....
>
>> other higher priority processes aren't waiting for the memory.  This
>> depends on the cgroup config, so wrt your current patches it probably
>> sounds crazy, but we have a lot of data around this from the fleet.
>
> I'm not using cgroups.
>
> Core infrastructure needs to work without cgroups being configured
> to confine everything in userspace to "safe" bounds, and right now
> just running things in the root cgroup doesn't appear to work very
> well at all.

I'm not disagreeing with this part, my real point is there isn't a=20
single answer.  It's possible for swap to be critical to the running of=20
the box in some workloads, and totally unimportant in others.

-chris
