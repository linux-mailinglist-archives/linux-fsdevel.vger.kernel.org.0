Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3EA72437B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 15:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbjFFNBF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 09:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbjFFNBE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:01:04 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787BE10DD;
        Tue,  6 Jun 2023 06:00:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2562cc85d3dso4980736a91.1;
        Tue, 06 Jun 2023 06:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686056441; x=1688648441;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=czNO+OcWCCKFJzxIld0ieW3pT6XtSIH4Ho3/NRs2oAE=;
        b=SzY5jwUDSxKAprnTt2lOCjYOyKDFrTVRJ2iuPyCAvcUTMmt/lFl/B6NqG4AywtXAOz
         GggsI6T00bDB1i461jzlC9SFNbprlrEdnhz/NOyFO29K/CHuYJOkQZofOSLrAZPtCKrg
         8Wh4A5M88qYN3DmVsW/6OQreMBXoNNkiE/Hk60Wtjq6593X+JDWSveRCgtTW3nLlnfaG
         0O1KDTHAArFJ7RQFs6Bmvw3QSuTtkmsVusaXxpjQch02qTTz9RYl2IhkOWNE3Z7DPn8u
         fL35+mRtwdL80QUf76SlbtyEfjWdXwq8w8zmWb5OfP6ju68LhhjY6dUvOrIhaUikNXAY
         pjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686056441; x=1688648441;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=czNO+OcWCCKFJzxIld0ieW3pT6XtSIH4Ho3/NRs2oAE=;
        b=lIQOp4qQf5rkWYp5rslGfeDQk2Oz2q6HrZtf9Xu/x0p9uXUA80a2yUmcWfynj3DrDc
         0IEiSV7ExNppuYklQ25nWe5bY3zp1kgwOL02ql7+Wa8UOvKvYt8Oowlqnk+w03t+H/N3
         V92SGiaZoskvVhBbyDi1aGCdjD/LZbzM6M4e6TLBMcXca8xJPWK9FcZGqTDfg8A22dwb
         ApAAxN64GBMVgz85afdM/W9t8ph9gSpIDoJrwBuGZ1Caur/SL4D0vN41tstBw/KPV3Sr
         SHZtpp9HB8vwNROnhKSC1e7tTmAaYa54zfr+uHi7V4XDUth6H4HDO0ap3eysONFJtxZf
         PEGA==
X-Gm-Message-State: AC+VfDwN8GGGcdCa8IKMFqTa+JxPTyRHPoAnE40/I7bphLbtoP83OP2N
        Z0MFvqbF9gXZth0t3nOsE3o=
X-Google-Smtp-Source: ACHHUZ4TKpQw/5aGrZA1S7TX0SMAR4VhiYSxRaGrhTe+jgB6mL7oycX6P3lDFAeSTCcwjGYSjQ6Kqw==
X-Received: by 2002:a17:90b:4d83:b0:258:cb10:5e8c with SMTP id oj3-20020a17090b4d8300b00258cb105e8cmr1821669pjb.20.1686056440669;
        Tue, 06 Jun 2023 06:00:40 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id d65-20020a17090a6f4700b0024749e7321bsm8089980pjk.6.2023.06.06.06.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 06:00:40 -0700 (PDT)
Date:   Tue, 06 Jun 2023 18:30:35 +0530
Message-Id: <87bkhskaoc.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv8 0/5] iomap: Add support for per-block dirty state to improve write performance
In-Reply-To: <ZH8onIAH8xcrWKE+@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Tue, Jun 06, 2023 at 05:13:47PM +0530, Ritesh Harjani (IBM) wrote:
>> Hello All,
>> 
>> Please find PATCHv8 which adds per-block dirty tracking to iomap.
>> As discussed earlier this is required to improve write performance and reduce
>> write amplification for cases where either blocksize is less than pagesize (such
>> as Power platform with 64k pagesize) or when we have a large folio (such as xfs
>> which currently supports large folio).
>
> You're moving too fast.  Please, allow at least a few hours between
> getting review comments and sending a new version.
>

Sorry about that. I felt those were mainly only mechanical conversion
changes. Will keep in mind.

>> v7 -> v8
>> ==========
>> 1. Renamed iomap_page -> iomap_folio & iop -> iof in Patch-1 itself.
>
> I don't think iomap_folio is the right name.  Indeed, I did not believe
> that iomap_page was the right name.  As I said on #xfs recently ...
>
> <willy> i'm still not crazy about iomap_page as the name of that
>    data structure.  and calling the variable 'iop' just seems doomed
>    to be trouble.  how do people feel about either iomap_block_state or
>    folio_block_state ... or even just calling it block_state since it's
>    local to iomap/buffered-io.c
> <willy> we'd then call the variable either ibs or fbs, both of which
>    have some collisions in the kernel, but none in filesystems
> <dchinner> willy - sounds reasonable

Both seems equally reasonable to me. If others are equally ok with both,
then shall we go with iomap_block_state and ibs? 

I see that as "iomap_block_state" which is local to iomap buffered-io
layer to track per-block state within a folio and gets attached to
folio->private.

-ritesh
