Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251B672CC6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 19:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbjFLRZu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 13:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbjFLRZt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:25:49 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B1510B;
        Mon, 12 Jun 2023 10:25:47 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-651f2f38634so4749767b3a.0;
        Mon, 12 Jun 2023 10:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686590747; x=1689182747;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ePrLbxees+na8VQ6kKHudm713FyUFUDWHNrQSIDaz9c=;
        b=l4Z+oNYFv1tJN559du14YDbAs1c1oOmSiTgedDwnNlaIsNT2JhvRW1AeHi6SxzzSiW
         tIAB11P00+aLniXOUnlFdwShzz+PjGLOZpHCwoBeX6mWpXJiuG3HzPX7zOPcmUBj8uCo
         B7NAMYCuE63OC81tssG/rjrY5jcfDSXamOfNEqgMdBSDsd7HXEDhQbADlAaz8AAlFAkS
         qEdZpU4cAKE34sRhEFkTaM+Azz+VgnpLAeMohpjE6xXBNiMua7i0j+i8/YUjqN/h+FBo
         sMAIhRy8yp8jPCll9eBo3Eb6Ash8pg6eMGKOx55eHFXKmU25t2JdyCzX6K8f5sVhkK5m
         0zRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686590747; x=1689182747;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePrLbxees+na8VQ6kKHudm713FyUFUDWHNrQSIDaz9c=;
        b=V1lK3FZ3+Km8agDBAb1EiKLb3VvzGeqHy+lQtFxNnzClMFol8mgDbttue9tkdw76Ol
         b9UyMWUxTACXwMYfKm/3fvgvBseFVvi9L6Kd7paQ29N1jtFpS+R5jIHl8wJs9eKW07ZA
         9fEpgBqxfkFlTGXwtt7/RGV0M7TS9EH9K+MmpN/uPPA3oJHPoBUlp+4nGLY5+Vuw6T9k
         /9/yu+SRt17ByDu1b1DNg31PdsvA/f+vjXqeRCoNEz1K9F/6dyEM80Biojls3LeR0qgs
         VKHnBqUI227ZlhV1hT/jzZGK8iTAI0iCPPbSvjsYruQv+d4DLwCTu2CwJUW29kBhPdkS
         /xIQ==
X-Gm-Message-State: AC+VfDyx6/vzGLAt+q9nCLRxghDQwXKeVQjCpjcQ3tnaUirBUfJmjMAo
        +6F0JLHV3g7Rm1tWsafKFA4=
X-Google-Smtp-Source: ACHHUZ6iNC09OETGM8+0I0s8HuzXvXXjFa4PV5gXB6Ee/RcEmwNbhPc7xydbYdD2F8YUdMRQlmChRA==
X-Received: by 2002:a17:902:d48f:b0:1b2:1942:9117 with SMTP id c15-20020a170902d48f00b001b219429117mr7940856plg.45.1686590746853;
        Mon, 12 Jun 2023 10:25:46 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090332cc00b001a194df5a58sm8519820plr.167.2023.06.12.10.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:25:46 -0700 (PDT)
Date:   Mon, 12 Jun 2023 22:55:37 +0530
Message-Id: <87wn08pp7y.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv2 2/5] ext4: Remove PAGE_SIZE assumption of folio from mpage_submit_folio
In-Reply-To: <87a5x6hy8l.fsf@doe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> Please ignore the previous email.
>
> "Theodore Ts'o" <tytso@mit.edu> writes:
>
>> On Mon, May 15, 2023 at 04:10:41PM +0530, Ritesh Harjani (IBM) wrote:
>>> mpage_submit_folio() was converted to take folio. Even though
>>> folio_size() in ext4 as of now is PAGE_SIZE, but it's better to
>>> remove that assumption which I am assuming is a missed left over from
>>> patch[1].
>>>
>>> [1]: https://lore.kernel.org/linux-ext4/20230324180129.1220691-7-willy@infradead.org/
>>>
>>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>
>> I didn't notice this right away, because the failure is not 100%
>> reliable, but this commit will sometimes cause "kvm-xfstests -c
>> ext4/encrypt generic/068" to crash.  Reverting the patch fixes the
>> problem, so I plan to drop this patch from my tree.
>>
>
> Sorry about the crash. I am now able to reproduce the problem on my
> setup as well. I will debug this and will update once I have some more info.
>
> From the initial look, it looks like the problem might be occurring when
> folio_pos(folio) itself is > i_size_read(inode).
>
> If that is indeed the case, then I think even doing this with folio
> conversion (below code after folio conversion) looks incorrect for case
> when size is not PAGE_SIZE aligned.
>
> However, I will spend some more time debugging this.

I am still looking into this. I would like to make sure I go through
all the paths where i_size can be modified.
- buffered-IO
- writeback
- direct-IO
- page fault
- truncate
- fallocate (punch/collapse)
- evict (not relevant though)

It is easily recreatable if we have one thread doing buffered-io +
sync and other thread trying to truncate down inode->i_size.
Kernel panic maybe is happening only with -O encrypt mkfs option +
-o test_dummy_encryption mount option, but the size - folio_pos(folio)
is definitely wrong because inode->i_size is not protected in writeback path.

More on this later...

-ritesh
