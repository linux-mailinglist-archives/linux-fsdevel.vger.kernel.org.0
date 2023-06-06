Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3533272362B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 06:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjFFEUq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 00:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjFFEUe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 00:20:34 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C36019C;
        Mon,  5 Jun 2023 21:20:32 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-55afbc16183so695657eaf.3;
        Mon, 05 Jun 2023 21:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686025232; x=1688617232;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yBE00vNjv3KvZcwNZWdO8NFmsUxg0Kj1Osiz1CksZZ8=;
        b=i8cIbZpWYFqiwt/toSfdPHsNErFVpNGgfXeLMKG0VULr1A84oAM4M6R/HjeoKY2Gb0
         dWRy3O6MUQWNEijW1g+BWwpa9rg1G5REjJ/GFFdhGxxr1J7c3EaWc5SjGBM4iQ30uqt8
         UQhtx3u+gclwpbPCjVswipdXypxVds/FoO5FGwzChmrEasLXpYLsrBoDjiIDzLm2l3+I
         FYE2a3Nic4nqrtStNh+dqa9yhjKJRVDEy96q51pNJ2Rq6ZbyaHV56U2pFy1tG2F6L2Zc
         YW/BGeuUCXVzpRNxtSIHXDCQCCMNPTLAHZKiqTlraaKNY23scXBKWZlJ6zOgm+a610KQ
         8mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686025232; x=1688617232;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBE00vNjv3KvZcwNZWdO8NFmsUxg0Kj1Osiz1CksZZ8=;
        b=B2g9lGh1xPxJqAOV6hWbghkumIRgSh51PV2MjBoqDgMjIdJ1kaGlL6a1zYzbycyNzF
         KH12QT11RDnlDXD9bE0MsN2Nm/OFIFkZyrAi3Ob8jN9dt4FKk3EU2JFuU58wiP/5NH1D
         7hYOaPr0I9RiA+rsYaM6K09bSobN9TxFIFmUqBUIdT7o2G9okjkqH89kTzf0KqUrAd57
         JCg5o/DA47CjaD/XhgOsksZlH3MwtJDOo5P9RsQIqUzwD6Z7qMqF3fizjUbgDv8ummI0
         htGw9neQCwONZZebeo5ZNA+gZpQOx5mtoZYYBCRSon4XQBSZsEMxvTSwVxdIuSM91oou
         Ihxw==
X-Gm-Message-State: AC+VfDzRhiZAUO16Z/mESt5z8fqr5bKDeBBUW4Oh/wuK3fmotnn4cjE/
        KwelttsIvw7zlgD4uy3b8hZzky43f8Q=
X-Google-Smtp-Source: ACHHUZ791XguVFC2T8L9zeVmq0jp8ErtlwbMgdSGj8+IB8uR2CgrjX2pKEoQmA22JYWTIXT1+R8Ifw==
X-Received: by 2002:aca:1204:0:b0:38e:8e21:d044 with SMTP id 4-20020aca1204000000b0038e8e21d044mr1086649ois.6.1686025231570;
        Mon, 05 Jun 2023 21:20:31 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id bc3-20020a170902930300b001a505f04a06sm7388428plb.190.2023.06.05.21.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 21:20:31 -0700 (PDT)
Date:   Tue, 06 Jun 2023 09:50:26 +0530
Message-Id: <87edmpjk6t.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv7 1/6] iomap: Rename iomap_page_create/release() to iomap_iop_alloc/free()
In-Reply-To: <20230605223611.GE1325469@frogsfrogsfrogs>
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

> On Mon, Jun 05, 2023 at 04:25:01PM +0530, Ritesh Harjani (IBM) wrote:
>> This patch renames the iomap_page_create/release() functions to
>> iomap_iop_alloc/free() calls. Later patches adds more functions for
>> handling iop structure with iomap_iop_** naming conventions.
>> Hence iomap_iop_alloc/free() makes more sense to be consistent with all
>> APIs.
>>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  fs/iomap/buffered-io.c | 21 +++++++++++----------
>>  1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index 063133ec77f4..4567bdd4fff9 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -43,8 +43,8 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
>>
>>  static struct bio_set iomap_ioend_bioset;
>>
>> -static struct iomap_page *
>> -iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
>> +static struct iomap_page *iomap_iop_alloc(struct inode *inode,
>
> Personally I preferred iop_alloc, but as I wasn't around to make to that
> point during the v6 review I'll let this slide.  iomap_iop_* it is.
>
> (I invoke maintainer privilege and will rename the structure to
> iomap_folio and iop->iof since the objects no longer track /only/ a
> single page state.)

Darrick,
Do you want me to rename iomap_page -> iomap_folio in this patch itself
or would you rather prefer the renaming of iomap_page -> iomap_folio and
iop -> iof as a separate last patch in the series?

>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>

Thanks!
-ritesh
