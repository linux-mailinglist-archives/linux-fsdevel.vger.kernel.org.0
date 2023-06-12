Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C460372CD45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 19:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbjFLRyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 13:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbjFLRyb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:54:31 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49528170D;
        Mon, 12 Jun 2023 10:54:16 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-655fce0f354so3659443b3a.0;
        Mon, 12 Jun 2023 10:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686592455; x=1689184455;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:cc:to
         :from:message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fUCbhsb5CR/FtNyz3J2CCaXXoHOr7CgE9xhgg3YZN0s=;
        b=EjPNzN1Znjs2obaq9tn3NIsEvezGuyJlvjf2Q0qp8rZXb01eSCsg1hVdBa5C4pZNrT
         xoQ3F2nCxJ7tsbM/24cfCAMZMtmZ/6cWEslDAU+UsxuXh/uQ7viVCg9cThRusGW8lhWA
         9GnP4vc53mqHPtgBb+xAdRr8yozMNrJARuHWnDZKL1pwUK/a1zMP1IXUJhOYRCBebwMx
         orHZVgpobvRUcJeW4VX/2Ade6xlxhRGZjw6SOdaryUU7W3jTDXut+b7ucugLzrcuurhj
         8Cr4UItfcLARzex7Qga+xnkDfWdzBU6sss+8Ram7UWm3nahzj2fqqTpTohI7JGcIPJ47
         EeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686592455; x=1689184455;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:cc:to
         :from:message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUCbhsb5CR/FtNyz3J2CCaXXoHOr7CgE9xhgg3YZN0s=;
        b=Z8h/9t+19wMINPw8TxJAYddsbrTGh5sGf9kK/xpeboLfPYXyWhOX1WFRepOG+OEhPh
         y2PM0VPGkYfuzV0gzUA9QGC0JR3LOsOHDCt4ukjpQb1FAQ2+KwWTIBwLl0KE2T2UJ4RS
         Id+46qYTEwD8lM9oyphxTNi/0bARCC8tA4PNlQ+Ey1yMePauu8K8dLqAaN9iYztKyMLB
         rukX3J3jCGsJlTWNHgMAfzof0/1yyn7dQgO63fDG+ZNqhGpfPdFCqtG0qHjUlDcMxmLQ
         2Mr65KqKK5mZuiQhBS6QFlN1Yjsr8wkCkee3JQTNAkMU+iCmQ3QMl76MkUue4DvE24P7
         HE4w==
X-Gm-Message-State: AC+VfDz9zXHsTo0nZ3jMpMUC8VnGdF3GecoZ5puAy7dAbmOzsV4KcuM7
        e/RpH/z3P3d0K2Bt1B+zwMk=
X-Google-Smtp-Source: ACHHUZ5v18nHw0+9/DoR4S+WIApjtg10NtI+23KV26AFljR60BmV/WcYjf26e+FCgvGoWA1fvfppsA==
X-Received: by 2002:a05:6a00:cca:b0:663:6986:8aad with SMTP id b10-20020a056a000cca00b0066369868aadmr11751388pfv.13.1686592455607;
        Mon, 12 Jun 2023 10:54:15 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id s18-20020aa78d52000000b00653dc27acadsm7080961pfe.205.2023.06.12.10.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:54:15 -0700 (PDT)
Date:   Mon, 12 Jun 2023 23:24:10 +0530
Message-Id: <87r0qgpnwd.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 3/6] iomap: Add some uptodate state handling helpers for ifs state bitmap
In-Reply-To: <20230612161034.GD11441@frogsfrogsfrogs>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Mon, Jun 12, 2023 at 05:57:48PM +0200, Andreas Gruenbacher wrote:
>> On Mon, Jun 12, 2023 at 5:24 PM Matthew Wilcox <willy@infradead.org> wrote:
>> > On Mon, Jun 12, 2023 at 08:48:16PM +0530, Ritesh Harjani wrote:
>> > > > Since we're at the nitpicking, I don't find those names very useful,
>> > > > either. How about the following instead?
>> > > >
>> > > > iomap_ifs_alloc -> iomap_folio_state_alloc
>> > > > iomap_ifs_free -> iomap_folio_state_free
>> > > > iomap_ifs_calc_range -> iomap_folio_state_calc_range
>> > >
>> > > First of all I think we need to get used to the name "ifs" like how we
>> > > were using "iop" earlier. ifs == iomap_folio_state...
>> > >
>> > > >
>> > > > iomap_ifs_is_fully_uptodate -> iomap_folio_is_fully_uptodate
>> > > > iomap_ifs_is_block_uptodate -> iomap_block_is_uptodate
>> > > > iomap_ifs_is_block_dirty -> iomap_block_is_dirty
>> > > >
>> > >
>> > > ...if you then look above functions with _ifs_ == _iomap_folio_state_
>> > > naming. It will make more sense.
>> >
>> > Well, it doesn't because it's iomap_iomap_folio_state_is_fully_uptodate.
>> 
>> Exactly.
>> 
>> > I don't think there's any need to namespace this so fully.
>> > ifs_is_fully_uptodate() is just fine for a static function, IMO.
>> 
>> I'd be perfectly happy with that kind of naming scheme as well.
>
> Ugh, /another/ round of renaming.
>
> to_folio_state (or just folio->private)
>
> ifs_alloc
> ifs_free
> ifs_calc_range
>
> ifs_set_range_uptodate
> ifs_is_fully_uptodate
> ifs_block_is_uptodate
>
> ifs_block_is_dirty
> ifs_clear_range_dirty
> ifs_set_range_dirty
>

Oops you have put me into a tough spot here. 
We came back from iop_** functions naming to iomap_iop_** to
iomap_ifs_**.

Christoph? Is it ok if we go back to ifs_** functions here then? 

Or do others prefer 
iomap_folio_state_** namings. instead of ifs_**  or iomap_ifs_**? 


> No more renaming suggestions.  I've reached the point where my eyes and
> brain have both glazed over from repeated re-reads of this series such
> that I don't see the *bugs* anymore.
>
> Anyone else wanting new naming gets to *send in their own patch*.
> Please focus only on finding code defects or friction between iomap and
> some other subsystem.

Yes, it would be helpful if we uncover any bugs/ or even suggstions for
how can we better test this (adding/improving any given test in xfstests).

I have been using xfstests mainly on x86 with 1k and Power with 4k "-g auto".
I will make sure I run some more configs before sending the next
revision. 

>
> Flame away about my aggressive tone,

Thanks Darrick. No issues at all. 

>
> ~Your burned out and pissed off maintainer~
>
>> Thanks,
>> Andreas
>> 

-ritesh
