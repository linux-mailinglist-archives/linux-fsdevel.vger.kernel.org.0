Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198636A5ECE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 19:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjB1SeG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 13:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjB1SeF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:34:05 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E86A199C1;
        Tue, 28 Feb 2023 10:34:04 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id ky4so11457319plb.3;
        Tue, 28 Feb 2023 10:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CrmwYfMAUVdvhs87bjWG7LKioSFrWIsl0Xp9rivZyp4=;
        b=iGThZCzaTpk3pDiIyaya1uJeQHCdQLnOtj6YkPLJ3BRbTZRXIzRuGrzmT4xaCpiUzE
         mncdV8rUlYgnwwLAE2Q2MVtzZsx5EsR1PYLr3+daGM2Daf7xal0Wip0+B39RfOr2gl8C
         LIPiB8L8kEvgOfA4K9TfiUydMgiQlWrX/Em1jby3s+cfYbAs2zJX8O/E40DW2yeUTJFx
         DCZyZEYUpV9+otwDY9cT4RuEa6V3yAyOPilyFzBD8YARX/KmZEXuH6gpaI1QgC7nlemW
         0uyMH5Og38xIeerWfPK1lgh+S711D/mSYWGJvtAff2OcBOB2C49PWT4mUJKcWioqHon4
         twtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CrmwYfMAUVdvhs87bjWG7LKioSFrWIsl0Xp9rivZyp4=;
        b=tHAUs6Cr75BwCD3XoeyN3yGuyMMet9YtOAKACH5jWA2M1t9hQbwYN1t3iRosSpmdD4
         vhmkcJ2DyxeY68RopNlq9636v6EhIGmQ7Mw3DTIx0hMuBR251SGHr7VsmypWhQd9cb6u
         X/aMpbrj/T/mvhGa3Cs34qoiDs/qgv2sdKg+vT9kgas65M4pRFaLlG2QyQ+1g2rEb8u4
         5eq1upHRDVGbteleObISqV6s+lxXzrxzRGolOelg/imjpFXOEPfXarX5U/oQ3cmrpN/y
         9VM0IzVYV8ea5GGhLTot+OOjWeMb8UDKTx9ts8QMuSANMeNx5MnB5MzVGf3JHqbbhW3k
         tdmw==
X-Gm-Message-State: AO0yUKUoeuf6Jzqd5AFexmIHHr+khHIXCUn1APU96sLQV6Xs6zSrT0my
        56rRMrbW8hAl1vhbbSIfinoNAw7svX+2ZA==
X-Google-Smtp-Source: AK7set/EbVa0/9l0Qx+aKRQ12tG7sYfNpCQWSKKZFHYmgSUITT7xzbo1zI7+WI1X+HmhsrK2lFksTA==
X-Received: by 2002:a05:6a20:428b:b0:c2:fb92:3029 with SMTP id o11-20020a056a20428b00b000c2fb923029mr4751633pzj.33.1677609243570;
        Tue, 28 Feb 2023 10:34:03 -0800 (PST)
Received: from rh-tp ([2406:7400:63:469f:eb50:3ffb:dc1b:2d55])
        by smtp.gmail.com with ESMTPSA id i20-20020aa78d94000000b0058bc60dd98dsm6369872pfr.23.2023.02.28.10.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 10:34:03 -0800 (PST)
Date:   Wed, 01 Mar 2023 00:03:48 +0530
Message-Id: <877cw13aib.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFCv3 1/3] iomap: Allocate iop in ->write_begin() early
In-Reply-To: <Y/vnbc5A1InqhzWt@casper.infradead.org>
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

> On Mon, Feb 27, 2023 at 01:13:30AM +0530, Ritesh Harjani (IBM) wrote:
>> +++ b/fs/iomap/buffered-io.c
>> @@ -535,11 +535,16 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>>  	size_t from = offset_in_folio(folio, pos), to = from + len;
>>  	size_t poff, plen;
>>
>> +	if (pos <= folio_pos(folio) &&
>> +	    pos + len >= folio_pos(folio) + folio_size(folio))
>> +		return 0;
>> +
>> +	iop = iomap_page_create(iter->inode, folio, iter->flags);
>> +
>>  	if (folio_test_uptodate(folio))
>>  		return 0;
>>  	folio_clear_error(folio);
>>
>> -	iop = iomap_page_create(iter->inode, folio, iter->flags);
>>  	if ((iter->flags & IOMAP_NOWAIT) && !iop && nr_blocks > 1)
>>  		return -EAGAIN;
>
> Don't you want to move the -EAGAIN check up too?  Otherwise an
> io_uring write will dirty the entire folio rather than a block.

I am not entirely convinced whether we should move this check up
(to put it just after the iop allocation). The reason is if the folio is
uptodate then it is ok to return 0 rather than -EAGAIN, because we are
anyway not going to read the folio from disk (given it is completely
uptodate).

Thoughts? Or am I missing anything here.

>
> It occurs to me (even though I was the one who suggested the current
> check) that pos <= folio_pos etc is actually a bit tighter than
> necessary.  We could get away with:
>
> 	if (pos < folio_pos(folio) + block_size &&
> 	    pos + len > folio_pos(folio) + folio_size(folio) - block_size)
>
> since that will also cause the entire folio to be dirtied.  Not sure if
> it's worth it.

I am not sure of how much impact such a change can cause. But I agree
that the above check is much lighter in terms of restriction.

Let me spend some more time thinking it through.

Thanks for the review!
-ritesh
