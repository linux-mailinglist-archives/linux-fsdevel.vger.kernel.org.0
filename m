Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672D539D990
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 12:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhFGK0c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 06:26:32 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:36281 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230127AbhFGK0c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:26:32 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 1D504198D;
        Mon,  7 Jun 2021 06:24:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 07 Jun 2021 06:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        OSn94CjzeuvPMg2r0s2Tb/GFbfMF6fdW/7F0MJPuRwY=; b=mM6jW8a5wjzVtFF8
        XWvIAs2SXHygeTUvjv5N+YMecBxdqdPDV/ycfaHgbhvk9O/o5pkOWtiFU8gBJCu7
        uz4+x4BbNk3hhRQY/jxdLuTJ7Bi9H0KHeYgCAMLdFoV7l2MFVdmN/jh/cBiHkobn
        trJ6UB28B+MGfNd5QwtCf+dbalpIgnOCrRMryDZq90sAb53xrHLZTocV/yDeMPrk
        kcgABVm6Ehs1DLdvlkHKJeAFMdY3O4qDoBrvKkECeIztNvc173VE4Gvzc/Xbo+4A
        5rKGcBoX/JhPvcH9cvh2N3eYBdYJmQUBy0FASp8+PELQ+x61ZX5qhFsUHvgvHsf0
        E3jQOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=OSn94CjzeuvPMg2r0s2Tb/GFbfMF6fdW/7F0MJPuR
        wY=; b=FazCv15AgkSqZkESX91dJh6rTOEO6SWTO8jZNCuDMojtek7xZHqRiFnZU
        cU3+/BBVifuYxbaf7kRG4wNCj9ojAbm5v96cj3jrpiW2/fFz2EpcUlpJ5/IexARZ
        j++uKy04jzsInxV5WT8oOD40DzeRsKdu2ew8xlTNtrzAliU5ZOs7ZkkK1nLDHcD+
        5VRKT3Hh2nHYsaV8wxGVUIOBiflY0SJfjSKvxktQCSbYb5piGqE5ZyJ8cBOUVbuj
        dXmPJNaKiroNUQt9WoRTnqa58OLwDPmBjCsHsyawZmCPZusicwwNmtW5WmKZidxH
        2pOmqEpw4Uq8bTGpNNmUeqH2f0JlA==
X-ME-Sender: <xms:5vO9YGXTMesx8zzeqYbNCW8rtGdjdb2yn3cxkZl6JJsZofxIzhGNig>
    <xme:5vO9YCncNafn-hSklG9olsO6km0iCta4bv96oJQD4r_tZ9ms96ltiU1iD1iV7ekna
    JaYYlQDGZ_a>
X-ME-Received: <xmr:5vO9YKbr5xBG1UAH2CzrK4oATwOTkatr22_L2RTvKGM_hm6T9T5P0-R-1iATo8BAOGGsMsitotrNqrOwpJSsoxsBJwqBGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtjedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:5vO9YNXlYQZ4K07RS-yugCz4y3zrtoa6pNIOeZw58RfQ0hyhDjkTIQ>
    <xmx:5vO9YAn-y37igSNNZZCXtafx_JIargkzj2UE8oFSvLMjFQ0cGLfqlg>
    <xmx:5vO9YCfcScIKEnw7UJikwhEW-qug9F7DlYO16AXEAKE_UqbKjANFMw>
    <xmx:5_O9YKdGu4ihWNVQwRkhIjXSv-gI-zh44a2GdQghWkUj6pbjFGFDTd-Ooug>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jun 2021 06:24:33 -0400 (EDT)
Message-ID: <e6bfd51bf4dc178f7ebc6abe42284d21dbf73880.camel@themaw.net>
Subject: Re: [PATCH v5 0/6] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Eric Sandeen <sandeen@sandeen.net>, Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 07 Jun 2021 18:24:29 +0800
In-Reply-To: <162306058093.69474.2367505736322611930.stgit@web.messagingengine.com>
References: <162306058093.69474.2367505736322611930.stgit@web.messagingengine.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-06-07 at 18:11 +0800, Ian Kent wrote:
> There have been a few instances of contention on the kernfs_mutex
> during
> path walks, a case on very large IBM systems seen by myself, a report
> by
> Brice Goglin and followed up by Fox Chen, and I've since seen a couple
> of other reports by CoreOS users.

The contention problems that I've seen show large numbers of processes
blocking in the functions ->d_revalidate() and ->permission() when a
lot of path walks are being done concurrently.

I've also seen contention on d_alloc_parallel() when there are a lot of
path walks for a file path that doesn't exist. For this later case I
saw a much smaller propotion of processes blocking but enough to get
my attention.

I used Fox Chen's benchmark repo. (slightly modified) to perform tests
to demonstrate the contention. The program basically runs a number of
pthreads threads (equal to the number of cpus) and each thread opens,
reads and then closes a file or files (depending on test case) in a
loop, here, 10000 times

I performed two tests, one with distinct file paths for half the number
of cpus, ie. 8 files for a 16 cpu machine, and another using the same
non-existent file path to simulate many lookups for a path that doesn't
exist.

The former test compares general path lookup behaviour between the
kernfs mutex and the rwsem while the later compares lookup behaviour
when VFS negative dentry caching is used.

I looked at the case of having only the negative dentry patches
applied but it was uninteresting as the contention moved from
d_alloc_parallel() to ->d_realidate() and ->permission(). So the
rwsem patches are needed for the netgative dentry patches to be
useful.

I captured perf call graphs for each of the test runs that show where
contention is occuring. For the missing file case d_alloc_parallel()
dominates the call graph and for the files case ->d_revalidate() and
->permission() dominate the call graph.

1) Run with 8 distinct sysfs file paths on 16 cpu machine, perf graphs
in base-files-cpu-16-perf.txt and patched-files-cpu-16-perf.txt.

Base (5.8.18-100.fc31, unpatched)
---------------------------------
single: total 37.802725ms per 3.780272us
concur: total 888.934870ms per 88.893487us  CPU 5
concur: total 893.396079ms per 89.339608us  CPU 3
concur: total 897.952652ms per 89.795265us  CPU 8
concur: total 908.120647ms per 90.812065us  CPU 13
concur: total 909.288507ms per 90.928851us  CPU 2
concur: total 936.016942ms per 93.601694us  CPU 10
concur: total 937.143611ms per 93.714361us  CPU 15
concur: total 946.569582ms per 94.656958us  CPU 6
concur: total 946.859803ms per 94.685980us  CPU 11
concur: total 951.888699ms per 95.188870us  CPU 12
concur: total 952.930595ms per 95.293059us  CPU 14
concur: total 953.105172ms per 95.310517us  CPU 9
concur: total 953.983792ms per 95.398379us  CPU 1
concur: total 954.019331ms per 95.401933us  CPU 7
concur: total 954.314661ms per 95.431466us  CPU 4
concur: total 953.315950ms per 95.331595us  CPU 0
times: 10000 threads: 16 cpus: 16

patched (5.12.2)
----------------
single: total 44.351311ms per 4.435131us
concur: total 205.454229ms per 20.545423us  CPU 10
concur: total 206.481337ms per 20.648134us  CPU 2
concur: total 209.061697ms per 20.906170us  CPU 9
concur: total 209.081926ms per 20.908193us  CPU 7
concur: total 209.813371ms per 20.981337us  CPU 15
concur: total 210.762667ms per 21.076267us  CPU 8
concur: total 211.073960ms per 21.107396us  CPU 5
concur: total 211.788792ms per 21.178879us  CPU 3
concur: total 212.029698ms per 21.202970us  CPU 14
concur: total 212.951390ms per 21.295139us  CPU 6
concur: total 212.994193ms per 21.299419us  CPU 0
concur: total 205.059406ms per 20.505941us  CPU 1
concur: total 214.761330ms per 21.476133us  CPU 4
concur: total 210.278140ms per 21.027814us  CPU 13
concur: total 215.120326ms per 21.512033us  CPU 12
concur: total 215.308288ms per 21.530829us  CPU 11
times: 10000 threads: 16 cpus: 16

2) Run with a single sysfs file path on 16 cpu machine, perf graphs in
base-missing-cpu-16-perf.txt and patched-missing-cpu-16-perf.txt.

Base (5.8.18-100.fc31, unpatched)
---------------------------------
single: total 23.870708ms per 2.387071us
concur: total 796.504874ms per 79.650487us  CPU 3
concur: total 806.306131ms per 80.630613us  CPU 11
concur: total 808.494954ms per 80.849495us  CPU 6
concur: total 813.103969ms per 81.310397us  CPU 1
concur: total 813.407996ms per 81.340800us  CPU 8
concur: total 813.427143ms per 81.342714us  CPU 9
concur: total 815.892622ms per 81.589262us  CPU 2
concur: total 816.133378ms per 81.613338us  CPU 4
concur: total 817.189601ms per 81.718960us  CPU 14
concur: total 818.323855ms per 81.832386us  CPU 13
concur: total 820.115479ms per 82.011548us  CPU 15
concur: total 821.024798ms per 82.102480us  CPU 7
concur: total 826.135994ms per 82.613599us  CPU 12
concur: total 826.315963ms per 82.631596us  CPU 0
concur: total 829.141106ms per 82.914111us  CPU 10
concur: total 830.058310ms per 83.005831us  CPU 5
times: 10000 threads: 16 cpus: 16

patched (5.12.2)
----------------
single: total 21.414203ms per 2.141420us
concur: total 231.474574ms per 23.147457us  CPU 15
concur: total 233.030232ms per 23.303023us  CPU 11
concur: total 235.226442ms per 23.522644us  CPU 5
concur: total 236.084628ms per 23.608463us  CPU 9
concur: total 236.635558ms per 23.663556us  CPU 10
concur: total 237.156850ms per 23.715685us  CPU 2
concur: total 237.260609ms per 23.726061us  CPU 3
concur: total 237.577515ms per 23.757752us  CPU 12
concur: total 237.605650ms per 23.760565us  CPU 1
concur: total 237.746644ms per 23.774664us  CPU 8
concur: total 238.417997ms per 23.841800us  CPU 0
concur: total 238.725191ms per 23.872519us  CPU 4
concur: total 240.301641ms per 24.030164us  CPU 14
concur: total 240.570763ms per 24.057076us  CPU 13
concur: total 240.758979ms per 24.075898us  CPU 6
concur: total 241.211006ms per 24.121101us  CPU 7
times: 10000 threads: 16 cpus: 16

3) Run with 24 distinct sysfs file paths on 48 cpu machine, perf graphs
in base-files-cpu-48-perf.txt and patched-files-cpu-48-perf.txt.

Base (5.12.2, unpatched)
------------------------
single: total 122.827400ms per 12.282740us
concur: total 5306.902134ms per 530.690213us  CPU 35
concur: total 5630.720717ms per 563.072072us  CPU 46
concur: total 5638.448405ms per 563.844841us  CPU 42
concur: total 5642.860083ms per 564.286008us  CPU 34
concur: total 5651.030648ms per 565.103065us  CPU 20
concur: total 5657.526181ms per 565.752618us  CPU 31
concur: total 5658.140447ms per 565.814045us  CPU 23
concur: total 5659.691758ms per 565.969176us  CPU 19
concur: total 5668.248013ms per 566.824801us  CPU 21
concur: total 5669.774274ms per 566.977427us  CPU 22
concur: total 5685.258360ms per 568.525836us  CPU 30
concur: total 5685.799738ms per 568.579974us  CPU 32
concur: total 5689.631849ms per 568.963185us  CPU 18
concur: total 5696.818593ms per 569.681859us  CPU 44
concur: total 5698.618608ms per 569.861861us  CPU 33
concur: total 5698.794859ms per 569.879486us  CPU 45
concur: total 5770.686184ms per 577.068618us  CPU 28
concur: total 5778.892695ms per 577.889270us  CPU 27
concur: total 5784.709119ms per 578.470912us  CPU 29
concur: total 5788.893840ms per 578.889384us  CPU 24
concur: total 5789.576181ms per 578.957618us  CPU 25
concur: total 5798.722220ms per 579.872222us  CPU 26
concur: total 5822.426684ms per 582.242668us  CPU 36
concur: total 5826.460510ms per 582.646051us  CPU 38
concur: total 5831.715090ms per 583.171509us  CPU 14
concur: total 5831.966863ms per 583.196686us  CPU 41
concur: total 5833.488179ms per 583.348818us  CPU 37
concur: total 5835.039815ms per 583.503982us  CPU 40
concur: total 5837.073842ms per 583.707384us  CPU 39
concur: total 5838.603686ms per 583.860369us  CPU 16
concur: total 5841.427760ms per 584.142776us  CPU 13
concur: total 5844.173463ms per 584.417346us  CPU 17
concur: total 5844.526500ms per 584.452650us  CPU 12
concur: total 5844.543912ms per 584.454391us  CPU 15
concur: total 5856.646296ms per 585.664630us  CPU 43
concur: total 5882.959009ms per 588.295901us  CPU 4
concur: total 5885.522053ms per 588.552205us  CPU 47
concur: total 5886.485513ms per 588.648551us  CPU 9
concur: total 5889.596333ms per 588.959633us  CPU 7
concur: total 5891.098216ms per 589.109822us  CPU 8
concur: total 5893.823953ms per 589.382395us  CPU 6
concur: total 5894.175035ms per 589.417504us  CPU 10
concur: total 5894.333983ms per 589.433398us  CPU 5
concur: total 5894.339733ms per 589.433973us  CPU 11
concur: total 5894.780552ms per 589.478055us  CPU 2
concur: total 5894.902495ms per 589.490250us  CPU 3
concur: total 5895.138875ms per 589.513888us  CPU 1
concur: total 5895.751332ms per 589.575133us  CPU 0
times: 10000 threads: 48 cpus: 48

patched (5.12.2)
----------------
single: total 113.291645ms per 11.329165us
concur: total 1593.959049ms per 159.395905us  CPU 13
concur: total 1597.518495ms per 159.751850us  CPU 3
concur: total 1597.658208ms per 159.765821us  CPU 6
concur: total 1600.019094ms per 160.001909us  CPU 25
concur: total 1601.089351ms per 160.108935us  CPU 23
concur: total 1601.469009ms per 160.146901us  CPU 26
concur: total 1602.896466ms per 160.289647us  CPU 30
concur: total 1603.235130ms per 160.323513us  CPU 1
concur: total 1603.366164ms per 160.336616us  CPU 28
concur: total 1604.441214ms per 160.444121us  CPU 2
concur: total 1604.688351ms per 160.468835us  CPU 36
concur: total 1605.739458ms per 160.573946us  CPU 8
concur: total 1606.069951ms per 160.606995us  CPU 31
concur: total 1606.332397ms per 160.633240us  CPU 22
concur: total 1608.634998ms per 160.863500us  CPU 11
concur: total 1608.698868ms per 160.869887us  CPU 5
concur: total 1609.072888ms per 160.907289us  CPU 43
concur: total 1609.780952ms per 160.978095us  CPU 41
concur: total 1610.214802ms per 161.021480us  CPU 12
concur: total 1610.618660ms per 161.061866us  CPU 16
concur: total 1610.885785ms per 161.088578us  CPU 27
concur: total 1611.576231ms per 161.157623us  CPU 10
concur: total 1612.083975ms per 161.208398us  CPU 38
concur: total 1612.677333ms per 161.267733us  CPU 45
concur: total 1612.698645ms per 161.269865us  CPU 44
concur: total 1612.887981ms per 161.288798us  CPU 18
concur: total 1612.808693ms per 161.280869us  CPU 4
concur: total 1612.844263ms per 161.284426us  CPU 35
concur: total 1612.760745ms per 161.276075us  CPU 40
concur: total 1613.220738ms per 161.322074us  CPU 17
concur: total 1613.249031ms per 161.324903us  CPU 29
concur: total 1613.270812ms per 161.327081us  CPU 20
concur: total 1613.325711ms per 161.332571us  CPU 24
concur: total 1613.499246ms per 161.349925us  CPU 21
concur: total 1613.347917ms per 161.334792us  CPU 42
concur: total 1613.416651ms per 161.341665us  CPU 15
concur: total 1613.742291ms per 161.374229us  CPU 46
concur: total 1613.809087ms per 161.380909us  CPU 32
concur: total 1613.329478ms per 161.332948us  CPU 19
concur: total 1613.783009ms per 161.378301us  CPU 9
concur: total 1613.626390ms per 161.362639us  CPU 39
concur: total 1614.077897ms per 161.407790us  CPU 34
concur: total 1614.094290ms per 161.409429us  CPU 7
concur: total 1614.754743ms per 161.475474us  CPU 14
concur: total 1614.958943ms per 161.495894us  CPU 0
concur: total 1616.025304ms per 161.602530us  CPU 37
concur: total 1617.808550ms per 161.780855us  CPU 47
concur: total 1630.682246ms per 163.068225us  CPU 33
times: 10000 threads: 48 cpus: 48

4) Run with a single sysfs file path on 48 cpu machine, perf graphs in
base-missing-cpu-48-perf.txt and patched-missing-cpu-48-perf.txt.

Base (5.12.2, unpatched)
------------------------
single: total 87.107970ms per 8.710797us
concur: total 15072.702249ms per 1507.270225us  CPU 24
concur: total 15184.463418ms per 1518.446342us  CPU 26
concur: total 15263.917735ms per 1526.391773us  CPU 28
concur: total 15617.042833ms per 1561.704283us  CPU 25
concur: total 15660.599769ms per 1566.059977us  CPU 27
concur: total 16134.873816ms per 1613.487382us  CPU 29
concur: total 16195.713672ms per 1619.571367us  CPU 11
concur: total 17182.571407ms per 1718.257141us  CPU 10
concur: total 17462.398666ms per 1746.239867us  CPU 9
concur: total 17813.014094ms per 1781.301409us  CPU 8
concur: total 18436.488514ms per 1843.648851us  CPU 6
concur: total 18996.550399ms per 1899.655040us  CPU 7
concur: total 21721.021674ms per 2172.102167us  CPU 41
concur: total 21986.614285ms per 2198.661429us  CPU 17
concur: total 22216.364478ms per 2221.636448us  CPU 23
concur: total 22369.110429ms per 2236.911043us  CPU 5
concur: total 22526.643861ms per 2252.664386us  CPU 35
concur: total 22540.326825ms per 2254.032682us  CPU 40
concur: total 22560.761109ms per 2256.076111us  CPU 30
concur: total 22774.376673ms per 2277.437667us  CPU 33
concur: total 22779.411375ms per 2277.941137us  CPU 31
concur: total 22844.223722ms per 2284.422372us  CPU 16
concur: total 22868.684174ms per 2286.868417us  CPU 34
concur: total 22926.039600ms per 2292.603960us  CPU 32
concur: total 22956.189714ms per 2295.618971us  CPU 38
concur: total 23002.988812ms per 2300.298881us  CPU 22
concur: total 23010.128228ms per 2301.012823us  CPU 36
concur: total 23013.737650ms per 2301.373765us  CPU 4
concur: total 23023.545614ms per 2302.354561us  CPU 39
concur: total 23120.483176ms per 2312.048318us  CPU 15
concur: total 23150.576516ms per 2315.057652us  CPU 37
concur: total 23240.196530ms per 2324.019653us  CPU 14
concur: total 23255.002167ms per 2325.500217us  CPU 21
concur: total 23255.595018ms per 2325.559502us  CPU 0
concur: total 23258.182221ms per 2325.818222us  CPU 3
concur: total 23264.494553ms per 2326.449455us  CPU 12
concur: total 23281.848036ms per 2328.184804us  CPU 13
concur: total 23307.939070ms per 2330.793907us  CPU 47
concur: total 23315.311150ms per 2331.531115us  CPU 46
concur: total 23328.394731ms per 2332.839473us  CPU 2
concur: total 23329.879007ms per 2332.987901us  CPU 20
concur: total 23351.592451ms per 2335.159245us  CPU 19
concur: total 23350.752868ms per 2335.075287us  CPU 1
concur: total 23356.438116ms per 2335.643812us  CPU 45
concur: total 23356.853217ms per 2335.685322us  CPU 42
concur: total 23357.738390ms per 2335.773839us  CPU 44
concur: total 23360.540952ms per 2336.054095us  CPU 43
concur: total 23360.577828ms per 2336.057783us  CPU 18
times: 10000 threads: 48 cpus: 48

patched (5.12.2)
----------------

single: total 115.004971ms per 11.500497us
concur: total 1534.106287ms per 153.410629us  CPU 15
concur: total 1584.741497ms per 158.474150us  CPU 34
concur: total 1588.227774ms per 158.822777us  CPU 3
concur: total 1590.944855ms per 159.094485us  CPU 27
concur: total 1593.252406ms per 159.325241us  CPU 21
concur: total 1594.347841ms per 159.434784us  CPU 44
concur: total 1594.519690ms per 159.451969us  CPU 43
concur: total 1594.651516ms per 159.465152us  CPU 11
concur: total 1595.516558ms per 159.551656us  CPU 12
concur: total 1596.826634ms per 159.682663us  CPU 22
concur: total 1598.825527ms per 159.882553us  CPU 6
concur: total 1598.914890ms per 159.891489us  CPU 33
concur: total 1599.541434ms per 159.954143us  CPU 28
concur: total 1600.537643ms per 160.053764us  CPU 38
concur: total 1602.424304ms per 160.242430us  CPU 47
concur: total 1602.725873ms per 160.272587us  CPU 30
concur: total 1602.759128ms per 160.275913us  CPU 14
concur: total 1603.849343ms per 160.384934us  CPU 29
concur: total 1605.117369ms per 160.511737us  CPU 35
concur: total 1605.473411ms per 160.547341us  CPU 19
concur: total 1606.013413ms per 160.601341us  CPU 13
concur: total 1606.068654ms per 160.606865us  CPU 4
concur: total 1606.209860ms per 160.620986us  CPU 23
concur: total 1606.923183ms per 160.692318us  CPU 1
concur: total 1607.064867ms per 160.706487us  CPU 40
concur: total 1607.121558ms per 160.712156us  CPU 20
concur: total 1610.107603ms per 161.010760us  CPU 10
concur: total 1610.140915ms per 161.014092us  CPU 5
concur: total 1610.636352ms per 161.063635us  CPU 24
concur: total 1612.699753ms per 161.269975us  CPU 46
concur: total 1612.879734ms per 161.287973us  CPU 42
concur: total 1613.176326ms per 161.317633us  CPU 2
concur: total 1613.415669ms per 161.341567us  CPU 8
concur: total 1613.811312ms per 161.381131us  CPU 25
concur: total 1613.923411ms per 161.392341us  CPU 41
concur: total 1613.966209ms per 161.396621us  CPU 31
concur: total 1614.947228ms per 161.494723us  CPU 17
concur: total 1615.337781ms per 161.533778us  CPU 37
concur: total 1615.835025ms per 161.583502us  CPU 32
concur: total 1615.982666ms per 161.598267us  CPU 39
concur: total 1616.335216ms per 161.633522us  CPU 45
concur: total 1616.340457ms per 161.634046us  CPU 36
concur: total 1616.387235ms per 161.638723us  CPU 16
concur: total 1617.248832ms per 161.724883us  CPU 9
concur: total 1617.354503ms per 161.735450us  CPU 0
concur: total 1617.455505ms per 161.745550us  CPU 18
concur: total 1618.290721ms per 161.829072us  CPU 26
concur: total 1630.338637ms per 163.033864us  CPU 7
times: 10000 threads: 48 cpus: 48

