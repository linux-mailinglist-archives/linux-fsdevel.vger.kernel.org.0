Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DD623AD11
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 21:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgHCTai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 15:30:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53168 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgHCTai (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 15:30:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073JRxQi183367;
        Mon, 3 Aug 2020 19:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=NA1XvUfVASuq/nbfh+DSwCBmQzdnwrjR9Pp/u/6X6sw=;
 b=GuWEG31mHQHO+APfMCxnTJfOWwMREUaRwjfjJI4BgRRbjVKW/gb985p7Agy2HrTeqOSS
 ITbr3bDdjP+rAGOpvb/4lTQI2fkVsBGKSqZ02QeaNNuCFnA0IfotSBpsJKMXsCt4CvSB
 fjF5Rvvp8pThsFYgJXqaow6RoKqdXNu6+mOHErlCdJ0NnvZwBz4hXO4Bpm6E2Ybl51eF
 Hyx+10Plnyjy58OSfCu86q0/U2SPQ72L+ukk1Ftel35Y7mAqTrmsJXFS21UUAfY71bPt
 d8y/6b+fdaweyu9bZDN+UH1b9Mhoqm3L6R9bSLcqDKL5Q3dE9+pipkNjn2BhByXZ3B+z iQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32n11n09wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 03 Aug 2020 19:29:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073JSsEp029993;
        Mon, 3 Aug 2020 19:29:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 32pdhavv2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Aug 2020 19:29:45 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 073JTUlh014737;
        Mon, 3 Aug 2020 19:29:30 GMT
Received: from [172.16.10.205] (/73.167.45.247)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Aug 2020 12:29:30 -0700
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca,
        christian@kellner.me, areber@redhat.com, cyphar@cyphar.com
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <20200730152250.GG23808@casper.infradead.org>
 <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
 <20200730171251.GI23808@casper.infradead.org>
 <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
 <20200730174956.GK23808@casper.infradead.org>
 <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
 <87y2n03brx.fsf@x220.int.ebiederm.org>
 <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
 <877dufvje9.fsf@x220.int.ebiederm.org>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <eeec47c5-232d-fe8e-c19d-70c50c49020c@oracle.com>
Date:   Mon, 3 Aug 2020 15:29:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <877dufvje9.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=2 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030134
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/3/2020 11:28 AM, ebiederm@xmission.com wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
>> On 7/30/2020 5:58 PM, ebiederm@xmission.com wrote:
>>> Here is another suggestion.
>>>
>>> Have a very simple program that does:
>>>
>>> 	for (;;) {
>>> 		handle = dlopen("/my/real/program");
>>> 		real_main = dlsym(handle, "main");
>>> 		real_main(argc, argv, envp);
>>> 		dlclose(handle);
>>> 	}
>>>
>>> With whatever obvious adjustments are needed to fit your usecase.
>>>
>>> That should give the same level of functionality, be portable to all
>>> unices, and not require you to duplicate code.  It belive it limits you
>>> to not upgrading libc, or librt but that is a comparatively small
>>> limitation.
>>>
>>>
>>> Given that in general the interesting work is done in userspace and that
>>> userspace has provided an interface for reusing that work already.
>>> I don't see the justification for adding anything to exec at this point. 
>>
>> Thanks for the suggestion.  That is clever, and would make a fun project,
>> but I would not trust it for production.  These few lines are just
>> the first of many that it would take to reset the environment to the
>> well-defined post-exec initial conditions that all executables expect,
>> and incrementally tearing down state will be prone to bugs.
> 
> Agreed.
> 
>> Getting a clean slate from a kernel exec is a much more reliable
>> design.
> 
> Except you are explicitly throwing that out the window, by preserving
> VMAs.  You very much need to have a clean bug free shutdown to pass VMAs
> reliably.

Sure.  The whole community relies on you and others to provide a bug free exec.

>> The use case is creating long-lived apps that never go down, and the
>> simplest implementation will have the fewest bugs and is the best.
>> MADV_DOEXEC is simple, and does not even require a new system call,
>> and the kernel already knows how to exec without bugs.
> 
> *ROFL*  I wish the kernel knew how to exec things without bugs.

Essentially you are saying you would argue against any enhancement to exec.
Surely that is too high a bar.  We must continue to evolve an innovate and
balance risk against reward.  This use case matters to our business a lot,
and to others as well, see below.  That is the reward.  I feel you are 
overstating the risk.  Surely there is some early point in the development
cycle of some release where this can be integrated and get enough test
time and soak time to be proven reliable.

> The bugs are hard to hit but the ones I am aware of are not straight
> forward to fix.
> 
> MADV_DOEXEC is not conceptually simple.  It completely violates the
> guarantees that exec is known to make about the contents of the memory
> of the new process.  This makes it very difficult to reason about.  

I have having trouble see the difficulty.  Perhaps I am too familar with
it, but the semantics are few and easy to explain, and it does not introduce
new concepts: the post-exec process is born with a few more mappings than
previously, and non-fixed further mmaps choose addresses in the holes.

> Nor
> will MADV_DOEXEC be tested very much as it has only one or two users.
> Which means in the fullness of time it is likely someone will change
> something that will break the implementation subtlely and the bug report
> probably won't come in for 3 years, or maybe a decade.  At which point
> it won't be clear if the bug even can be fixed as something else might
> rely on it.

That's on us; we need to provide kernel tests and be diligent about testing
new releases.  This matters to our business and we will do so. 
> What is wrong with live migration between one qemu process and another
> qemu process on the same machine not work for this use case?
> 
> Just reusing live migration would seem to be the simplest path of all,
> as the code is already implemented.  Further if something goes wrong
> with the live migration you can fallback to the existing process.  With
> exec there is no fallback if the new version does not properly support
> the handoff protocol of the old version.

This is less resource intensive than live migration.  The latter ties up two
hosts, consumes lots of memory and network bandwidth, may take a long time
to converge on a busy system, and is unfeasible for guests with a huge amount
of local storeage (which we call dense I/O shapes).  Live update takes less than
1 second total, and the guest pause time is 100 - 200 msecs.  It is a very
attractive solution that other cloud vendors have implemented as well, with
their own private modifications to exec and and fork.  We have been independently
working in this area, and we are offering our implementation to the community.

- Steve
