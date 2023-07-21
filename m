Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2683375C105
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 10:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjGUIOT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 04:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjGUIOQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:14:16 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07D52710;
        Fri, 21 Jul 2023 01:14:10 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id AA0ED3200FA5;
        Fri, 21 Jul 2023 04:14:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 21 Jul 2023 04:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689927244; x=1690013644; bh=FUNFJj6urWuhz
        j/ULPd7dgB790ZiEm9pAM63aZfvl0o=; b=K+rMc5OSCr1Fh3xdtUlGdyEGp1ONI
        51AJM7rHQtcPDLtX+kJ6dtJJb+OZ5//ie4+jgpfhPd2tNJruDPl3+eEPHvmFD1ye
        4Jb/J120LU917i5czkrEOBtvJtmoP6YWY5AggOG930AFqj2FrrXcZ/QWbx/zbGhb
        PZY7UmtLp9n1vsTgl/DpXwt4ICVD+veAS/haXKLYa0q5n4/a1ZfwwnxQ8xOgKm30
        Z6urvnxBg9uTdpQ0kpWJHWUotlTyCmMxFR5rkEXm7b8y+XCwHVtHzIZvPHLLTYor
        S+KRdPKxBmDyGziWoDh0avzv1jkwzeT49W/KC6xVFmpQE7uOHeLVNM+MA==
X-ME-Sender: <xms:Sj66ZI4F8NgCrze5lhIwlHzi5NMbZbeIZqw_KSRu13s5Nn5hqNhJXw>
    <xme:Sj66ZJ4NDo5Q0y3xQ3AuRoG4ogzkOiD8WaAtZHPy_2-RSWBMlDP6W5GyHRUPjDrM6
    HILsYFMDDzF1H_J4N0>
X-ME-Received: <xmr:Sj66ZHcYQKXwb_YyFY0VD3xU2FuJeSvcQPaXd1SjdCmJIDc4V_YsFNU8tHVpAaCQS1twWam2aqYIKtQscAtEVSZYHAXhlX-iRvc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:Sj66ZNLA3PZvnZRISS7E-fLyDcxI_6eAde9TLWcINqoNSp_6jQZ8OA>
    <xmx:Sj66ZMKJFovsSlFYj5Nru_Vl1m0g_K6AnNPnk4Z4S1pajlaTwYfqJg>
    <xmx:Sj66ZOyPGzQXVDqieXB6gCz0R50dxZa--GnH7pbdOITulJ6lYcXQig>
    <xmx:TD66ZJ6YMrryZtwMv3xMiDBUj0eFoeqVL_FjWu87hcrOvPjcbNy_yw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 04:14:01 -0400 (EDT)
Date:   Fri, 21 Jul 2023 18:14:04 +1000 (AEST)
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
Message-ID: <3eca2dab-df70-9d91-52a1-af779e3c2e04@linux-m68k.org>
References: <46F233BB-E587-4F2B-AA62-898EB46C9DCE@dubeyko.com> <Y7bw7X1Y5KtmPF5s@casper.infradead.org> <50D6A66B-D994-48F4-9EBA-360E57A37BBE@dubeyko.com> <CACT4Y+aJb4u+KPAF7629YDb2tB2geZrQm5sFR3M+r2P1rgicwQ@mail.gmail.com> <ZLlvII/jMPTT32ef@casper.infradead.org>
 <2d0bd58fb757e7771d13f82050a546ec5f7be8de.camel@physik.fu-berlin.de> <ZLl2Fq35Ya0cNbIm@casper.infradead.org> <868611d7f222a19127783cc8d5f2af2e42ee24e4.camel@kernel.org> <ZLmzSEV6Wk+oRVoL@dread.disaster.area> <60b57ae9-ff49-de1d-d40d-172c9e6d43d5@linux-m68k.org>
 <ZLnbN4Mm9L5wCzOK@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 21 Jul 2023, Matthew Wilcox wrote:

> 
> You've misunderstood.  Google have decided to subject the entire kernel 
> (including obsolete unmaintained filesystems) to stress tests that it's 
> never had before.  IOW these bugs have been there since the code was 
> merged.  There's nothing to back out.  There's no API change to blame. 
> It's always been buggy and it's never mattered before.
> 

I'm not blaming the unstable API for the bugs, I'm blaming it for the 
workload. A stable API (like a userspace API) decreases the likelihood 
that overloaded maintainers have to orphan a filesystem implementation. 
