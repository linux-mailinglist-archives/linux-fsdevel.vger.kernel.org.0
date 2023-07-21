Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C247275BBAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 03:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjGUBDi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 21:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGUBDi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 21:03:38 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EE5E75;
        Thu, 20 Jul 2023 18:03:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E369A5C00F4;
        Thu, 20 Jul 2023 21:03:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 20 Jul 2023 21:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689901412; x=1689987812; bh=R4ZNGlYIzZjqT
        Kdh2uUCCHfXsCMNde46ZsMLHyedF/I=; b=X26iwK3gCgmCENMCp/fW1ETWcUzEN
        9rwLuq4E33Zo0dhDnC7nZvOCLnw3oA8kr5MhSLJ14LNMtTJlvQdeKciQl4R51mU5
        OjD/BSnJTKaA3e102aHkf3HKi/xD/nWE1sQP9GaWV0hJhSKdElBPI77oiLieA6/0
        oUKi90TVMJ92HpZCZ4gDOHLzl4q9Llaqfl1yiulga84go00d47fg1yFWgL8XpwSU
        uykfbLG4c3SPEQHR2Ok/FuAN8NS7ns+9n9zY3uJDEugcaSMXhmiarDaaTGrpc/zk
        6qmwkuQde+Fbb2VlewWSj5CSduAOjRvxdeh1f1dw/dXeSZewpMzlPx0ZQ==
X-ME-Sender: <xms:Y9m5ZGHNOoPPua24wf3PLjWeqBKhGbD6w-EXyXG4S4mIXfmXrDQCLA>
    <xme:Y9m5ZHW08G_fqzzf_tgovXDG75WXjrgEu0O5q7UGK87e4pdRgyUXWxVOPv9MTDT-f
    asRWFtr3_UfWk1iaj0>
X-ME-Received: <xmr:Y9m5ZAJM2rR108cHi7m_ZNBXxKOC9XnYVTYVJqiDN2Yshfklo7A1tuTHLvno_jI22YOksrWqhHaG3VzYXsHrVAHI4p5-5Zj4nAc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueeh
    ueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:Y9m5ZAGV9zNsA0Any4YXWN_FkYsDjNdxtMDTcKEak1pr8k919uB9Gw>
    <xmx:Y9m5ZMUbeQcAD8DiPfJCEmJCM5XliXdkI8-s22DZsIy8t0WU5oyMqw>
    <xmx:Y9m5ZDNtBu6POEckDdHBDiXddmUZ3bZAjb_xeDcA6x27a3lxZ1f6ig>
    <xmx:ZNm5ZBW_oA0e1oLVnvgtebv0un27mG3J3J5_-FLNFNF-i_wfWoD8Pw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 21:03:28 -0400 (EDT)
Date:   Fri, 21 Jul 2023 11:03:28 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Dave Chinner <david@fromorbit.com>
cc:     Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
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
In-Reply-To: <ZLmzSEV6Wk+oRVoL@dread.disaster.area>
Message-ID: <60b57ae9-ff49-de1d-d40d-172c9e6d43d5@linux-m68k.org>
References: <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com> <2575F983-D170-4B79-A6BA-912D4ED2CC73@dubeyko.com> <46F233BB-E587-4F2B-AA62-898EB46C9DCE@dubeyko.com> <Y7bw7X1Y5KtmPF5s@casper.infradead.org> <50D6A66B-D994-48F4-9EBA-360E57A37BBE@dubeyko.com>
 <CACT4Y+aJb4u+KPAF7629YDb2tB2geZrQm5sFR3M+r2P1rgicwQ@mail.gmail.com> <ZLlvII/jMPTT32ef@casper.infradead.org> <2d0bd58fb757e7771d13f82050a546ec5f7be8de.camel@physik.fu-berlin.de> <ZLl2Fq35Ya0cNbIm@casper.infradead.org> <868611d7f222a19127783cc8d5f2af2e42ee24e4.camel@kernel.org>
 <ZLmzSEV6Wk+oRVoL@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 21 Jul 2023, Dave Chinner wrote:

> > I suspect that this is one of those catch-22 situations: distros are 
> > going to enable every feature under the sun. That doesn't mean that 
> > anyone is actually _using_ them these days.

I think the value of filesystem code is not just a question of how often 
it gets executed -- it's also about retaining access to the data collected 
in archives, museums, galleries etc. that is inevitably held in old 
formats.

> 
> We need to much more proactive about dropping support for unmaintained 
> filesystems that nobody is ever fixing despite the constant stream of 
> corruption- and deadlock- related bugs reported against them.
> 

IMO, a stream of bug reports is not a reason to remove code (it's a reason 
to revert some commits).

Anyway, that stream of bugs presumably flows from the unstable kernel API, 
which is inherently high-maintenance. It seems that a stable API could be 
more appropriate for any filesystem for which the on-disk format is fixed 
(by old media, by unmaintained FLOSS implementations or abandoned 
proprietary implementations).

Being in userspace, I suppose FUSE could be a stable API though I imagine 
it's not ideal in the sense that migrating kernel code there would be 
difficult. Maybe userspace NFS 4 would be a better fit? (I've no idea, I'm 
out of my depth in /fs...)

Ideally, kernel-to-userspace code migration would be done with automatic 
program transformation -- otherwise it would become another stream of 
bugs.
