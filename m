Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C5E72CD1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 19:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjFLRnx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 13:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbjFLRnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:43:50 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC4910FE;
        Mon, 12 Jun 2023 10:43:47 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b3c578c602so10806935ad.2;
        Mon, 12 Jun 2023 10:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686591827; x=1689183827;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LtrdrpfKJlf+W5tyykoHujkKdZZz5s4zFVUAHOuCieU=;
        b=bwCI/OBad2bIoUVBkCkKrluGueanx6AKqXSsJjM4Q+da3xxpoWcxH2/7lqIE9inQgE
         BUCRGOC0j1a1BLrMHlPSqZf6k1jhwvI+qR75KVPaHRKOmkiisue11QSa625oDo7BnlPU
         G75UP/1V9WY9dSYEvRc6dCEIVbvhFlur80wKbT5uPAkaJUDTzObzCg9KcdTorX03Sj/p
         T6E5KjpXk7fx83y/dgnbz9zfC0qfvKYEdcfgTir6DYvICd/xDxVLnDfWEtI4dURtQnxm
         llkunC+PnaOKg3uQrRLmLKqfi7qhwZT/DuCg+6Dc9EzTiQtm9cOEHZUKceEoWFsX2b7Y
         1FzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686591827; x=1689183827;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LtrdrpfKJlf+W5tyykoHujkKdZZz5s4zFVUAHOuCieU=;
        b=SItxMEoX7Ec2bDOrsN+6iHc1BJNWivSd9KwuxL5mv2NMrJCYpIihm6jyM2DyOtOkMq
         TVqf7c3q2A6teFieDYbBOFvCrgA8/2LrhLN9aXEkN4mQssEyAKfdAUDWMWseCcLiXS4w
         QXBdkFTXhAHECnYKsCoI7okm4CpEemKB0WG4uaRKPsZeuzV3LONNCoyAF8HCAIO3lLCJ
         2yopnZYjWhRJuy1KbzaGUzr0EdXTFtCJ9PLKkPCrVlQxmm8cW/1zJneZCVGRvC1q9lmP
         x/lropyUVnmEwlOfF0jo/MvUq3YMIB1oKFEc7JzsB0Lwcxvz7V4a53JVXXOjmp1EJGX5
         +Vag==
X-Gm-Message-State: AC+VfDys2jW+jDNx+lliI2NWxxNv4qBhCOFWd59yeSvmCkP4Oai+KiZD
        WFTsxOY318aedqVsINv/UeQ=
X-Google-Smtp-Source: ACHHUZ6anrflqohDVFfxJSBLquGnLFVF8uqQt+zIxImHFzZ/XBQm7x/nqulg4oFYRlPFN2RrSPQ3lg==
X-Received: by 2002:a17:902:e74e:b0:1b3:8865:aaae with SMTP id p14-20020a170902e74e00b001b38865aaaemr8743895plf.53.1686591827139;
        Mon, 12 Jun 2023 10:43:47 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b001b0305757c3sm8505810plh.51.2023.06.12.10.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:43:46 -0700 (PDT)
Date:   Mon, 12 Jun 2023 23:13:42 +0530
Message-Id: <87ttvcpodt.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 1/6] iomap: Rename iomap_page to iomap_folio_state and others
In-Reply-To: <20230612155911.GC11441@frogsfrogsfrogs>
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

> On Mon, Jun 12, 2023 at 04:08:51PM +0100, Matthew Wilcox wrote:
>> On Mon, Jun 12, 2023 at 08:05:20AM -0700, Darrick J. Wong wrote:
>> > static inline struct iomap_folio_state *
>> > to_folio_state(struct folio *folio)
>> > {
>> > 	return folio->private;
>> > }
>> 
>> I'd reformat it to not-XFS-style:
>> 
>> static inline struct iomap_folio_state *to_folio_state(struct folio *folio)
>> {
>> 	return folio->private;
>> }
>> 
>> But other than that, I approve.  Unless you just want to do without it
>> entirely and do
>> 
>> 	struct iomap_folio_state *state = folio->private;
>> 
>> instead of
>> 
>> 	struct iomap_folio_state *state = to_folio_state(folio);
>> 
>> I'm having a hard time caring between the two.
>
> Either's fine with me too.  I'm getting tired of reading this series
> over and over again.
>
> Ritesh: Please pick whichever variant you like, and that's it, no more
> discussion.

static inline struct iomap_folio_state *to_folio_state(struct folio *folio)
{
    return folio->private;
}

Sure this looks fine to me. So, I am hoping that there is no need to check
folio_test_private(folio) PG_private flag here before returning
folio->private (which was the case in original code to_iomap_page())

I did take a cursory look and didn't find any reason to test for doing
folio_test_private(folio) here. It should always remain set between
iomap_ifs_alloc() and iomap_ifs_free().

- IIUC, it is mostly for MM subsystem to see whether there is a
private FS data attached to a folio for which they think we might have
to call FS callback. for e.g. .is_dirty_writeback callback.
- Or like FS can use it within it's own subsystem to say whether a
folio is being associated with an in-progress read or write request. (e.g. NFS?)


-ritesh
