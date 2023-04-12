Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAF86DF7E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 16:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjDLOCz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 10:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjDLOCx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:02:53 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C3E7ABC;
        Wed, 12 Apr 2023 07:02:46 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p8so11553138plk.9;
        Wed, 12 Apr 2023 07:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681308166; x=1683900166;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LfXiPKzEOSNYmq3ecIzWJmmSwndeoTw2yVUw7BNVDQk=;
        b=DJnhf3fs41FSBzBsQ4sNxLRnb7Ikaefu3ml2kqh9buX9ZLG+RNpovZYAjkZ2+yH5mc
         G4MrLN5O43+BymtlqHKG93wnmFRakY0r+IinxHMyltQmrhjd1woRTgtRwV1Qk+0G3cna
         yCQF6lerBcHHiBL5fD73M5Mu5b2QTDDFYTUfYWhy7e+i/ZGTKd9pRpjtiM5FOdallRoF
         6q90bgJV3gO9Gr65EBWEkKfdDM7d6SS459JHLUlU+DPJMLrMLH5zZ2tixBBYxGfNvRdM
         eGw5W9Q8BZ8VtEJhKITNgTnSpk8FKvmduTpj0zy8k4Z1bBz3Rr10vUcNA/jn9yKKEYpr
         XOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681308166; x=1683900166;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LfXiPKzEOSNYmq3ecIzWJmmSwndeoTw2yVUw7BNVDQk=;
        b=XZIFkc1esqIFMMH73k9dwFnuCF0ys8+xeekNIUQ5j8OlnXDmYGDjCTj0yyquQZc91l
         IoItoVf5pFnR83ntOvpphjJ8+WRN8/A5jFOOrhGzKRt4ZUtMuokucBlEXheDzB/eaAHB
         xoSJBiuplu7V+oOUg3MRx0TMLUqPpC0hbAIri9vX8/LnRTJIXVy/MAOSSmI1mOEWYZde
         a7lA0cr2jcPPPv91wj1Iss7MeIB/1aVnzy/BcwDe8w2PmTUSfjvdLSAI7z+BT37tfL8y
         hMConv7ugq07Nas5v7P3QQ4sB0/Im31BaZgTU3RTmdss0QIf9Pqc8KL9TiTZDWy7VDq2
         E16A==
X-Gm-Message-State: AAQBX9fgjYmY5SlwZWclAHHw00yRlsrHTcBqtfuidkgCgVeHakTMopvc
        lWL86DDwsdT0HkoTmbxweEo=
X-Google-Smtp-Source: AKy350bSp9UPumlasOzyS9Qp1iCUEvudsyXlEcrurZEpT46AQyGod/0s8YOQGN7REaieXLVAi2Ka5A==
X-Received: by 2002:a17:902:7fc5:b0:1a1:cce7:94ed with SMTP id t5-20020a1709027fc500b001a1cce794edmr17725943plb.67.1681308165007;
        Wed, 12 Apr 2023 07:02:45 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id m18-20020a170902bb9200b0019d1f42b00csm10486254pls.17.2023.04.12.07.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:02:44 -0700 (PDT)
Date:   Wed, 12 Apr 2023 19:32:26 +0530
Message-Id: <87ttxlyz9p.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [RFCv2 2/8] libfs: Add __generic_file_fsync_nolock implementation
In-Reply-To: <ZDaZR+zHcpUyNOND@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Tue, Apr 11, 2023 at 01:33:17PM +0100, Matthew Wilcox wrote:
>> On Mon, Apr 10, 2023 at 10:27:10PM -0700, Christoph Hellwig wrote:
>> > On Tue, Apr 11, 2023 at 10:51:50AM +0530, Ritesh Harjani (IBM) wrote:
>> > > +/**
>> > > + * __generic_file_fsync_nolock - generic fsync implementation for simple
>> > > + * filesystems with no inode lock
>> >
>> > No reallz need for the __ prefix in the name.
>>
>> It kind of makes sense though.
>>
>> generic_file_fsync does the flush
>> __generic_file_fsync doesn't do the flush
>> __generic_file_fsync_nolock doesn't do the flush and doesn't lock/unlock
>
> Indeed.  Part of it is that the naming is a bit horrible.
> Maybe it should move to buffer.c and be called generic_buffer_fsync,
> or generic_block_fsync which still wouldn't be perfect but match the
> buffer.c naming scheme.
>

Eventually it anyways needs some work to see if we can kill the lock
variant all together. I didn't do that in this series which is
focused on ext2 conversion of iomap.
So, if it's not that bad, I would like to keep both function
definitions at one place so that it can be worked out later.

>>
>> > > +extern int __generic_file_fsync_nolock(struct file *, loff_t, loff_t, int);
>> >
>> > No need for the extern.  And at least I personally prefer to spell out
>> > the parameter names to make the prototype much more readable.
>>
>> Agreed, although I make an exception for the 'struct file *'.  Naming that
>> parameter adds no value, but a plain int is just obscene.
>>
>> int __generic_file_fsync_nolock(struct file *, loff_t start, loff_t end,
>> 		bool datasync);
>
> While I agree that it's not needed for the file, leaving it out is a bit
> silly.
>

Sure. Will fix it.

>> (yes, the other variants don't use a bool for datasync, but they should)
>
> .. including the ->fsync prototype to make it work ..

Sure, this work should go as a seperate series.

-ritesh
