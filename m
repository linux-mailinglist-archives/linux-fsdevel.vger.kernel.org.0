Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF771F603E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 05:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgFKDCm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 23:02:42 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:60979 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726279AbgFKDCl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 23:02:41 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id DC5905801A7;
        Wed, 10 Jun 2020 23:02:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 10 Jun 2020 23:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        7/BAeetQPYmzk01Iv9MN6j1tODm19PWDi3yWsUSYw0Q=; b=1fVGQEAoT9+6G+dh
        S0GkW8Ts6d7KVvLa5BuyhZM6BcMH5F1CsKTjcNyJq54mGo9txQKdo/sIM1KUzS7v
        wvqLpMv9jK+ghTKFx0H//M1BMvNbdWQFO2mvSR6/wnnCEt0Wk+/2uaoygcjQvl7z
        BxRvKqSm97zxYb+/ngOF9Swr88rg6LImTAN2wZACey1WedEjIezHqIdDKGBwW6DB
        yjNAGiyuIAEq/Wa+adLxJJQ0j+5DdHB25ytpBNbTLR3X9y1didPm562td4oyNw4P
        85iUY/QIfypS7i32/HO5kqO6qsHB7QZ2jR0H4/e5z67w2Nr+7sBPg3TyQleF9Enw
        WRvx7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=7/BAeetQPYmzk01Iv9MN6j1tODm19PWDi3yWsUSYw
        0Q=; b=OMRvzkVXwowAJFgjIwgXD7I1sGDKbDw+HkoDiwzr4wPCMRvEYzid0N4Jb
        OMhrFB7IOonsR9aMm8adEhGhrrkMi8A/eOa2kaTTRv1neo7+vM8k8PGpWi2LJ2vB
        71BsN9Md2WLmhV3LFtXaJ2L5EEoTY4PbJqR5+xbQ2w8CRs+bgPH5R7URG5zxXULr
        zaL3uWAdjSKu3xv2JC5ckOmJuQnTF+18sBnTj3RJuJMeJ+2Jvex30F6N1UV9F6Uo
        wSmaqQj/XWvnDyDdITNxj9n+Xi2BD9cr2Jeb2+mBmpociu5olddLY69N67Dg3xTP
        nzmPo8Szi1wKHlbsdU5MVWBjcY9kA==
X-ME-Sender: <xms:zp7hXtjPZxr9rZR8Q07fTVVnBnrXTJ9vqSpcC2bBW1hl8yApaAl--A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehjedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    ekkeejieeiieegvedvvdejjeegfeffleekudekgedvudeggeevgfekvdfhvdelfeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeehkedrjedrvddvtddrgeejnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhes
    thhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:zp7hXiCrBbaLeZnXGndqTkKjDIUt73v3wfJrt60zqcdL9rzuI2Y9dg>
    <xmx:zp7hXtH0CBGYB5cD5buGpqYFf3UIqgqINbeobrXLClm5PLjhf-yZmQ>
    <xmx:zp7hXiRvU4A7ls9spP4HEPyLx4wP7iMhHS-quiYjgvIXgrGG2sVH4g>
    <xmx:z57hXlw9sL9dpsONfq4eHzAISjxqQe8T4e9_JfxwJ20vLQQOT_6x8w>
Received: from mickey.themaw.net (58-7-220-47.dyn.iinet.net.au [58.7.220.47])
        by mail.messagingengine.com (Postfix) with ESMTPA id 534853060FE7;
        Wed, 10 Jun 2020 23:02:34 -0400 (EDT)
Message-ID: <41e9ea55fad97df81393df544343a20c466c7917.camel@themaw.net>
Subject: Re: [kernfs] ea7c5fc39a: stress-ng.stream.ops_per_sec 11827.2%
 improvement
From:   Ian Kent <raven@themaw.net>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org
Date:   Thu, 11 Jun 2020 11:02:30 +0800
In-Reply-To: <20200611020657.GI12456@shao2-debian>
References: <159038562460.276051.5267555021380171295.stgit@mickey.themaw.net>
         <20200606155216.GU12456@shao2-debian> <20200606181802.GA15638@kroah.com>
         <5df6bec6f1b332c993474782c08fe8db30bffddc.camel@themaw.net>
         <20200611020657.GI12456@shao2-debian>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-06-11 at 10:06 +0800, kernel test robot wrote:
> On Sun, Jun 07, 2020 at 09:13:08AM +0800, Ian Kent wrote:
> > On Sat, 2020-06-06 at 20:18 +0200, Greg Kroah-Hartman wrote:
> > > On Sat, Jun 06, 2020 at 11:52:16PM +0800, kernel test robot
> > > wrote:
> > > > Greeting,
> > > > 
> > > > FYI, we noticed a 11827.2% improvement of stress-
> > > > ng.stream.ops_per_sec due to commit:
> > > > 
> > > > 
> > > > commit: ea7c5fc39ab005b501e0c7666c29db36321e4f74 ("[PATCH 1/4]
> > > > kernfs: switch kernfs to use an rwsem")
> > > > url: 
> > > > https://github.com/0day-ci/linux/commits/Ian-Kent/kernfs-proposed-locking-and-concurrency-improvement/20200525-134849
> > > > 
> > > 
> > > Seriously?  That's a huge performance increase, and one that
> > > feels
> > > really odd.  Why would a stress-ng test be touching sysfs?
> > 
> > That is unusually high even if there's a lot of sysfs or kernfs
> > activity and that patch shouldn't improve VFS path walk contention
> > very much even if it is present.
> > 
> > Maybe I've missed something, and the information provided doesn't
> > seem to be quite enough to even make a start on it.
> > 
> > That's going to need some analysis which, for my part, will need to
> > wait probably until around rc1 time frame to allow me to get
> > through
> > the push down stack (reactive, postponed due to other priorities)
> > of
> > jobs I have in order to get back to the fifo queue (longer term
> > tasks,
> > of which this is one) list of jobs I need to do as well, ;)
> > 
> > Please, kernel test robot, more information about this test and
> > what
> > it's doing.
> > 
> 
> Hi Ian,
> 
> We increased the timeout of stress-ng from 1s to 32s, and there's
> only
> 3% improvement of stress-ng.stream.ops_per_sec:
> 
> fefcfc968723caf9  ea7c5fc39ab005b501e0c7666c  testcase/testparams/tes
> tbox
> ----------------  --------------------------  -----------------------
> ----
>          %stddev      change         %stddev
>              \          |                \  
>      10686               3%      11037        stress-ng/cpu-cache-
> performance-1HDD-100%-32s-ucode=0x500002c/lkp-csl-2sp5
>      10686               3%      11037        GEO-MEAN stress-
> ng.stream.ops_per_sec
> 
> It seems the result of stress-ng is inaccurate if test time too
> short, we'll increase the test time to avoid unreasonable results,
> sorry for the inconvenience.

Haha, I was worried there wasn't anything that could be done to
work out what was wrong.

I had tried to reproduce it, and failed since the job file specifies
a host config that I simply don't have, and I don't get how to alter
the job to suit, or how to specify a host definition file.

I also couldn't work out what parameters where used in running the
test so I was about to ask on the lkp list after working through
this in a VM.

So your timing on looking into this is fortunate, for sure.
Thank you very much for that.

Now, Greg, there's that locking I changed around kernfs_refresh_inode()
that I need to fix which I re-considered as a result of this, so that's
a plus for the testing because it's certainly wrong.

I'll have another look at that and boot test it on a couple of systems
then post a v2 for you to consider. What I've done might offend your
sensibilities as it does mine, or perhaps not so much.

Ian

