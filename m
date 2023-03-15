Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1656BB6CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 15:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjCOO7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 10:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjCOO7N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:59:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41719749E;
        Wed, 15 Mar 2023 07:58:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so2301520pjz.1;
        Wed, 15 Mar 2023 07:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678892284;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dokgrxg7LsaZ2JGu50D2m9zJ1ZTRNdIVZnZRE9TyiYA=;
        b=JOC7Mx3fWiA0zvfzLyHe7LRt+2rWixnacoz+bNjQ8+ZMI8yHWZBIt1yPfC81kq39ch
         xOfgrbI84b5FYqRMGFLEZSA3/ViD+njB6PJajq/s+uq/EA2ADgk/zUcVrmbBevFkgX+8
         QYw20yj8LRrlb3xGJYC/WVaolFWkbQ9c8hRXTsVCtLxMUhfwJbQ0K4msRG2bPaStks5M
         IoSp1JfCsyXnLeeKALXNY4Rm7UzEuJFb00I3uXtw57qtPVvDq+FNdm4ros/BMM31wzJF
         UClxpKxyjcjZpHj7/kCzMf0Ly49DZ7NRtdVVzuIuLKrODSNvNQDOtQkBDOn77D1agNJA
         yOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678892284;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dokgrxg7LsaZ2JGu50D2m9zJ1ZTRNdIVZnZRE9TyiYA=;
        b=7yi0PPJtcHvOPlAq4+Qh9MzdkWjbRFWcwek2ZYQw59VnGM/Lutg3H9F3YfZQ0p8tDz
         lvnSm3V5fdSWpg5jU6gJunY/KBQT4qiCd3kaws5lXhRMCeAOYIRORs0S3KuHf13yyUgt
         5d+z3LG9Li2dc1otJUz31HIPyJzbXgJfKB9KaG4/RO2Il6oHM/jFZUVCzeztmnOnNIDl
         9dOO9VucA8b3QVfS+0e5F4lZfY+I5XhDEZs92/LinJbP9UDgBG8RcgIi9ZMLohEYpsV8
         ytfE2paXG3R8N+rSBpeZTDXG9Q8KgNm4F0QEOc2KL/EZJeIWSiCgE0oMgPRu0wtduQnr
         +4Lg==
X-Gm-Message-State: AO0yUKUnxwecqfz4aaRV/CArs6j2kElVGIPcP5RuBc58qJ553zCcnXs1
        SSQ4D03MQD3gT9xRzG5P333/p+khuaBtAQ==
X-Google-Smtp-Source: AK7set8AwaWLXTj1ENvzQEn1jH4j8u0dxhPBRYCKYfKuP0E894bHLAaP+DtFYemzWsyvHC1obYkKxA==
X-Received: by 2002:a05:6a20:7b28:b0:d5:8207:9f08 with SMTP id s40-20020a056a207b2800b000d582079f08mr54647pzh.33.1678892284282;
        Wed, 15 Mar 2023 07:58:04 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:469f:1474:7c59:3a57:aab6])
        by smtp.gmail.com with ESMTPSA id s5-20020aa78285000000b005d296facfa3sm3643422pfm.36.2023.03.15.07.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:58:03 -0700 (PDT)
Date:   Wed, 15 Mar 2023 20:27:50 +0530
Message-Id: <874jqm83kh.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 25/31] ext4: Convert ext4_block_write_begin() to take a folio
In-Reply-To: <ZBFMT6L0QqpDcWNm@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Mar 06, 2023 at 08:51:45PM +0530, Ritesh Harjani wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> 
>> > On Mon, Mar 06, 2023 at 12:21:48PM +0530, Ritesh Harjani wrote:
>> >> "Matthew Wilcox (Oracle)" <willy@infradead.org> writes:
>> >>
>> >> > All the callers now have a folio, so pass that in and operate on folios.
>> >> > Removes four calls to compound_head().
>> >>
>> >> Why do you say four? Isn't it 3 calls of PageUptodate(page) which
>> >> removes calls to compound_head()? Which one did I miss?
>> >>
>> >> > -	BUG_ON(!PageLocked(page));
>> >> > +	BUG_ON(!folio_test_locked(folio));
>> >
>> > That one ;-)
>> 
>> __PAGEFLAG(Locked, locked, PF_NO_TAIL)
>> 
>> #define __PAGEFLAG(uname, lname, policy)				\
>> 	TESTPAGEFLAG(uname, lname, policy)				\
>> 	__SETPAGEFLAG(uname, lname, policy)				\
>> 	__CLEARPAGEFLAG(uname, lname, policy)
>> 
>> #define TESTPAGEFLAG(uname, lname, policy)				\
>> static __always_inline bool folio_test_##lname(struct folio *folio)	\
>> { return test_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }	\
>> static __always_inline int Page##uname(struct page *page)		\
>> { return test_bit(PG_##lname, &policy(page, 0)->flags); }
>> 
>> How? PageLocked(page) doesn't do any compount_head() calls no?
>
> You missed one piece of the definition ...
>
> #define PF_NO_TAIL(page, enforce) ({                                    \
>                 VM_BUG_ON_PGFLAGS(enforce && PageTail(page), page);     \
>                 PF_POISONED_CHECK(compound_head(page)); })

aah yes, right. Thanks for pointing it.

-ritesh
