Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90E6633503
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 07:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiKVGDy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 01:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKVGDx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 01:03:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5602E2935D;
        Mon, 21 Nov 2022 22:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8yvCcE7pXKBz2AooLEwz0rPsa/zDLlt45zH6Xpmx42A=; b=HDqU24X0iZ27w8FyXN8TvTBOsQ
        X4O0pQvojKtLEGjl+DKkkDHnUU+KpSiP5nrN7z8cMv3DGxL/pgENYOqwpiv49MRyeq39/mbBV4rMe
        B0QlYPlIf9O0BYW9U7X4iQ/B/jXrMerq+LxKSoRkUcE+WsjSuj8UkjFSxFQ275rdbWu1KlRNYRTp0
        XhUd9mLS+90pFghHeiIUD4FqA229bCx3AgnGHfH2bplyc/jR76nncoJmGcM/Wxn+xk3WeZxwIP7L7
        QbGyOXBSEUJ1LibWS1R5Pr2aMecYv8Epg8i/M+SKpED1WF0HPf5nrG5IkdE5dx5lLlspzTIwPkxTn
        ibB3rETw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxMNt-0060Ay-Lt; Tue, 22 Nov 2022 06:03:53 +0000
Date:   Tue, 22 Nov 2022 06:03:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Wei Chen <harperchen1110@gmail.com>, rpeterso@redhat.com,
        agruenba@redhat.com, cluster-devel@redhat.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 gfs2_evict_inode
Message-ID: <Y3xmSbsjoMRnRIEd@casper.infradead.org>
References: <CAO4mrfd4=HRXMrcdZQUorNaFss3AFfrRxuXWMFT3uh+Dvfwb9g@mail.gmail.com>
 <CAO4mrfdU4oGktM8PPFg66=32N0JSGx=gtG80S89-b66tS3NLVw@mail.gmail.com>
 <CAO4mrfftfwBWbt-a1H3q559jtnv93MQ92kp=DFnA+-pRrSObcw@mail.gmail.com>
 <CACT4Y+Zub=+V3Yx=wSagYYeybwhbBt66COyTc=OjFAMOibybxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Zub=+V3Yx=wSagYYeybwhbBt66COyTc=OjFAMOibybxg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 18, 2022 at 10:33:21AM +0100, Dmitry Vyukov wrote:
> On Fri, 18 Nov 2022 at 09:06, Wei Chen <harperchen1110@gmail.com> wrote:
> >
> > Dear Linux developers,
> >
> > The bug persists in upstream Linux v6.0-rc5.
> 
> If you fix this, please also add the syzbot tag:
> 
> Reported-by: syzbot+8a5fc6416c175cecea34@syzkaller.appspotmail.com
> https://lore.kernel.org/all/000000000000ab092305e268a016@google.com/

Hey Dmitri, does Wei Chen work with you?  They're not responding to
requests to understand what they're doing.  eg:

https://lore.kernel.org/all/YtVhVKPAfzGmHu95@casper.infradead.org/

https://lore.kernel.org/all/Y0SAT5grkUmUW045@casper.infradead.org/

I'm just ignoring their reports now.
