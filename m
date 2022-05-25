Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19505335AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 05:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243771AbiEYDTg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 23:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240132AbiEYDTf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 23:19:35 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B65377F7;
        Tue, 24 May 2022 20:19:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VEKw0JS_1653448767;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VEKw0JS_1653448767)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 May 2022 11:19:29 +0800
Date:   Wed, 25 May 2022 11:19:25 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Ted Ts'o <tytso@mit.edu>,
        Gao Xiang <xiang@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Page cache changes for 5.19
Message-ID: <Yo2gPUN/6u0cZ80A@B-P7TQMD6M-0146.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Ted Ts'o <tytso@mit.edu>,
        Gao Xiang <xiang@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Yo0zVZ7giRMWe+w5@casper.infradead.org>
 <CAHk-=wj2kKMnxUu65zbJ28t0azRv3-EHpKaaecYTcLiNtw_eMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj2kKMnxUu65zbJ28t0azRv3-EHpKaaecYTcLiNtw_eMQ@mail.gmail.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

On Tue, May 24, 2022 at 08:06:32PM -0700, Linus Torvalds wrote:
> On Tue, May 24, 2022 at 12:34 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > These are the page cache changes for 5.19.  There are a few conflicts
> > with other peoples work:
> 
> Hmm. Also the ext4 symlink change (which made your changes there go
> away) and the erofs fscache code.

Thanks for noticing! At a quick look, I think erofs/fscache.c part is fine,
but will test on our side again!

(Actually, Matthew's PR mentioned a version formed by Stephen...
 erofs:
https://lore.kernel.org/linux-next/20220502180425.7305c335@canb.auug.org.au/

 but your version also looks good to me, thanks! )

Thanks,
Gao Xiang

> 
> I think I sorted it all out correctly and it looked very
> straightforward, but it would probably be a good idea for people to
> double-check despite that.
> 
>                 Linus
