Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502802D6DF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 03:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387850AbgLKCDI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 21:03:08 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:46515 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395011AbgLKCCV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 21:02:21 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 64D6458037B;
        Thu, 10 Dec 2020 21:01:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 10 Dec 2020 21:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        HaETQcz9Q6DexvC+G2PY0gzOOLoH5VM8tm15U5oH7AM=; b=kg/sXgK01N1NWGvx
        WuWzwCx3OfqVeZSX5Pbt6AIzTIuI6hOLnjHDl5OMXl7JwtItIwAlsC4xo0QRna4x
        LkMsLOGgmPr2I30C3mnnNxcZ0kxwg2yslGBBBv/BXkv9uu6Ez3Xh7JUSY9WkvCmZ
        zVL0kzY+WEIooMb6603FR6cffm+xBIYFlSbkb24xMV/pHIBboSIsdyddB3FHMivD
        ffAzGRen+eT9DUyayl93NCUt6+d5GjzrfsasmKH53vXO3w3OPDUek0cCXpxbYM6+
        zoY4VgUjjiBgqGwGo4q00MwgmyYexu/J1F1Cs7/urBaS+VPHvw9LtlGXzeAW2uq2
        rcqiGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=HaETQcz9Q6DexvC+G2PY0gzOOLoH5VM8tm15U5oH7
        AM=; b=Nip+PdSpTONj7/wChldegt80RcetMdnzK1Dq+GS+RhMdI5fgiew+MfZOI
        tCIY7W3/8MwKKnhfrak0kVLElTpSgd99KAw2i5+AJqQh1752ZN40mElzzHEBYT3m
        f1piSqslJY8jRTivYA9h8S3vd57J2+ol0XPPL7aIy0NUN/ClEyFDApGl3hXVWSUG
        WJ18L2H1ZBk4Tg66Fh10I4xmG9JdOm3C+5ZWhIVXjFuCKWT7BoZ9eilDe8hsL219
        mxX337LUTvADdo3YCJ7VpTDDb9YRx22RGod559Nb5BLpThVh/tOPWdewfWmNmji+
        aTS89D6M5D/rGsnFvlUEYIQXeCRhQ==
X-ME-Sender: <xms:59LSX4cBSpuB8nU5Ih0D1jvnC3G52iOQcjYkpirq-Wi_3U9q6mik3w>
    <xme:59LSX6MMTF7630-742VgPSYJ_F8CXXJjqFST7PtdyyVKvgndAo7Lvr6rOw-osq5cN
    CVFJ_dcpKOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekuddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eiieefuefhgefhtefhleettdffgffgtdekgfejjeduhfegtdetieffgeevffffueenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucfkphepuddtie
    drieelrddvfeekrddukeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:59LSX5grYHF6dDkmRmhV1oVBBmjIk_Wpp2wfvRmZl0P-Y3gv3goV-Q>
    <xmx:59LSX9-LIPIld3pJHD_8Zzn95TcscTCezqphiLWkTNOTrLN56vTghQ>
    <xmx:59LSX0usXeUJDUxlz5-rczQQLflvU-ACQkLdgsLzPrXhaHswWRfoSw>
    <xmx:6dLSX58FrlVNC0sp-F6e9ED9Br0e5QpDYZicWEdfFkFhErCnrPws3w>
Received: from mickey.themaw.net (106-69-238-183.dyn.iinet.net.au [106.69.238.183])
        by mail.messagingengine.com (Postfix) with ESMTPA id A87F8108005F;
        Thu, 10 Dec 2020 21:01:07 -0500 (EST)
Message-ID: <822f02508d495ee7398450774eb13e5116ec82ac.camel@themaw.net>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     akpm@linux-foundation.org, dhowells@redhat.com,
        gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, miklos@szeredi.hu,
        ricklind@linux.vnet.ibm.com, sfr@canb.auug.org.au, tj@kernel.org,
        viro@ZenIV.linux.org.uk
Date:   Fri, 11 Dec 2020 10:01:04 +0800
In-Reply-To: <20201210164423.9084-1-foxhlchen@gmail.com>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
         <20201210164423.9084-1-foxhlchen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-12-10 at 16:44 +0000, Fox Chen wrote:
> Hi,
> 
> I found this series of patches solves exact the problem I am trying
> to solve.
> https://lore.kernel.org/lkml/20201202145837.48040-1-foxhlchen@gmail.com/

Right.

> 
> The problem is reported by Brice Goglin on thread:
> Re: [PATCH 1/4] drivers core: Introduce CPU type sysfs interface
> https://lore.kernel.org/lkml/X60dvJoT4fURcnsF@kroah.com/
> 
> I independently comfirmed that on a 96-core AWS c5.metal server.
> Do open+read+write on /sys/devices/system/cpu/cpu15/topology/core_id
> 1000 times.
> With a single thread it takes ~2.5 us for each open+read+close.
> With one thread per core, 96 threads running simultaneously takes 540
> us 
> for each of the same operation (without much variation) -- 200x
> slower than the 
> single thread one. 

Right, interesting that the it's actually a problem on such
small system configurations.

I didn't think it would be evident on hardware that doesn't
have a much larger configuration.

> 
> My Benchmark code is here:
> https://github.com/foxhlchen/sysfs_benchmark
> 
> The problem can only be observed in large machines (>=16 cores).
> The more cores you have the slower it can be.
> 
> Perf shows that CPUs spend most of the time (>80%) waiting on mutex
> locks in 
> kernfs_iop_permission and kernfs_dop_revalidate.
> 
> After applying this, performance gets huge boost -- with the fastest
> one at ~30 us 
> to the worst at ~180 us (most of on spin_locks, the delay just
> stacking up, very
> similar to the performance on ext4). 

That's the problem isn't it.

Unfortunately we don't get large improvements for nothing so I
was constantly thinking, what have I done here that isn't ok ...
and I don't have an answer for that.

The series needs review from others for that but we didn't get
that far.

> 
> I hope this problem can justifies this series of patches. A big mutex
> in kernfs
> is really not nice. Due to this BIG LOCK, concurrency in kernfs is
> almost NONE,
> even though you do operations on different files, they are
> contentious.

Well, as much as I don't like to admit it, Greg (and Tejun) do have
a point about the number of sysfs files used when there is a very
large amount of RAM. But IIUC the suggestion of altering the sysfs
representation for this devices memory would introduce all sorts
of problems, it then being different form all device memory
representations (systemd udev coldplug for example).

But I think your saying there are also visible improvements elsewhere
too, which is to be expected of course.

Let's not forget that, as the maintainer, Greg has every right to
be reluctant to take changes because he is likely to end up owning
and maintaining the changes. That can lead to considerable overhead
and frustration if the change isn't quite right and it's very hard
to be sure there aren't hidden problems with it.

Fact is that, due to Greg's rejection, there was much more focus
by the reporter to fix it at the source but I have no control over
that, I only know that it helped to get things moving.

Given the above, I was considering posting the series again and
asking for the series to be re-considered but since I annoyed
Greg so much the first time around I've been reluctant to do so.

But now is a good time I guess, Greg, please, would you re-consider
possibly accepting these patches?

I would really like some actual review of what I have done from
people like yourself and Al. Ha, after that they might well not
be ok anyway!

> 
> As we get more and more cores on normal machines and because sysfs
> provides such
> important information, this problem should be fix. So please
> reconsider accepting
> the patches.
> 
> For the patches, there is a mutex_lock in kn->attr_mutex, as Tejun
> mentioned here 
> (https://lore.kernel.org/lkml/X8fe0cmu+aq1gi7O@mtj.duckdns.org/),
> maybe a global 
> rwsem for kn->iattr will be better??

I wasn't sure about that, IIRC a spin lock could be used around the
initial check and checked again at the end which would probably have
been much faster but much less conservative and a bit more ugly so
I just went the conservative path since there was so much change
already.

Ian

