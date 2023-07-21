Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC75C75BBFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 03:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjGUBqG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 21:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjGUBqE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 21:46:04 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499413592;
        Thu, 20 Jul 2023 18:45:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 5E2B85C01A8;
        Thu, 20 Jul 2023 21:45:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 20 Jul 2023 21:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689903939; x=1689990339; bh=iYynT4KhE74j+
        dSXMjtfN0JZs/wjEjd9JxVM4ynGFAE=; b=snXEv978O7wJ+SWzOrOYXBJpCY1Ie
        B7BnmXfkr0COvcfnfRvjPvrQ7k59wxUHAgyOV77x6Yvl3u1I+7hMa8XTUuAgbo92
        3D89fQUfzL5YfpxaBzBik3Lf2ffm2REX9mKVdIpAJaF72okvSWcjSvRk+5QzUAN2
        /B6CdJ2KB9adOss522i41brkFR5p9sBwDirIdr2HCAch4eSOP+rMvGL5SVsSetdg
        pC/hep6ZedWP9lDoNlcTt5rgyuk3i45QMLqJ2v/ely4QjXoUieSdj95u5fbNcnx5
        MrAjHSbAetlZUpbaniCZjZ64Nf202pz+6qJejPl9dWPoxuzmj1GMpaBVQ==
X-ME-Sender: <xms:QuO5ZNustU4DVeD-BCLqAYCY-bR0iC3ezijc77pRU3arSE0Kn2utmA>
    <xme:QuO5ZGd3gUjk7tZ-waGyWFWiffGLEyDyFU0sUCBGfW1s2GtmrR4x1mjS3ps5pNJyn
    sXJmiADNdioE69Av5Y>
X-ME-Received: <xmr:QuO5ZAy5uoy0BnvLS4XTVjvwSe8mIDCZJVvJlyeOOH6kZmMcG_jsZDljlm1RmsJgpQLeiUOjMZeQvl-Ihi440PwZA6g5j-qACcM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueeh
    ueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:QuO5ZEP-tPH-elvLT55nGwyw2VHEld4pe7MgHr6-BI1uAKDt6YIj2w>
    <xmx:QuO5ZN84iEL6Ez0u0iK7p1wggE-4XYwhGoz8TZ1qIaiJ5_p9lUGwyw>
    <xmx:QuO5ZEUtkwcLmMsRWrDqvIWfFSNHs4xixctKB_4wtAUGQWhfGbZX9w>
    <xmx:Q-O5ZMdeuptiP0K-a2hZRq8St-IrOfJ5fp5wNsruIjDam4qmfgMMuw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 21:45:36 -0400 (EDT)
Date:   Fri, 21 Jul 2023 11:45:39 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Matthew Wilcox <willy@infradead.org>
cc:     Dave Chinner <david@fromorbit.com>,
        Jeff Layton <jlayton@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-m68k@lists.linux-m68k.org,
        debian-ports <debian-ports@lists.debian.org>
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
In-Reply-To: <ZLnbN4Mm9L5wCzOK@casper.infradead.org>
Message-ID: <23b19f18-13a3-1744-cdce-801cfa35a807@linux-m68k.org>
References: <46F233BB-E587-4F2B-AA62-898EB46C9DCE@dubeyko.com> <Y7bw7X1Y5KtmPF5s@casper.infradead.org> <50D6A66B-D994-48F4-9EBA-360E57A37BBE@dubeyko.com> <CACT4Y+aJb4u+KPAF7629YDb2tB2geZrQm5sFR3M+r2P1rgicwQ@mail.gmail.com> <ZLlvII/jMPTT32ef@casper.infradead.org>
 <2d0bd58fb757e7771d13f82050a546ec5f7be8de.camel@physik.fu-berlin.de> <ZLl2Fq35Ya0cNbIm@casper.infradead.org> <868611d7f222a19127783cc8d5f2af2e42ee24e4.camel@kernel.org> <ZLmzSEV6Wk+oRVoL@dread.disaster.area> <60b57ae9-ff49-de1d-d40d-172c9e6d43d5@linux-m68k.org>
 <ZLnbN4Mm9L5wCzOK@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 21 Jul 2023, Matthew Wilcox wrote:

> On Fri, Jul 21, 2023 at 11:03:28AM +1000, Finn Thain wrote:
> > On Fri, 21 Jul 2023, Dave Chinner wrote:
> > 
> > > > I suspect that this is one of those catch-22 situations: distros 
> > > > are going to enable every feature under the sun. That doesn't mean 
> > > > that anyone is actually _using_ them these days.
> > 
> > I think the value of filesystem code is not just a question of how 
> > often it gets executed -- it's also about retaining access to the data 
> > collected in archives, museums, galleries etc. that is inevitably held 
> > in old formats.
> 
> That's an argument for adding support to tar, not for maintaining 
> read/write support.
> 

I rather think it's an argument for collaboration between the interested 
parties upstream (inluding tar developers). As I see it, the question is, 
what kind of "upstream" is best for that?

> > > We need to much more proactive about dropping support for 
> > > unmaintained filesystems that nobody is ever fixing despite the 
> > > constant stream of corruption- and deadlock- related bugs reported 
> > > against them.
> > 
> > IMO, a stream of bug reports is not a reason to remove code (it's a 
> > reason to revert some commits).
> > 
> > Anyway, that stream of bugs presumably flows from the unstable kernel 
> > API, which is inherently high-maintenance. It seems that a stable API 
> > could be more appropriate for any filesystem for which the on-disk 
> > format is fixed (by old media, by unmaintained FLOSS implementations 
> > or abandoned proprietary implementations).
> 
> You've misunderstood.  Google have decided to subject the entire kernel 
> (including obsolete unmaintained filesystems) to stress tests that it's 
> never had before.  IOW these bugs have been there since the code was 
> merged.  There's nothing to back out.  There's no API change to blame. 
> It's always been buggy and it's never mattered before.
> 

I see. Thanks for providing that background.

> It wouldn't be so bad if Google had also decided to fund people to fix 
> those bugs, but no, they've decided to dump them on public mailing lists 
> and berate developers into fixing them.
> 

Those bugs, if moved from kernel to userspace, would be less harmful, 
right?
