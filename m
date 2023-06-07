Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2459725B9A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 12:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbjFGK27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 06:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbjFGK25 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:28:57 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1A219AE;
        Wed,  7 Jun 2023 03:28:56 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b29b9f5c40so1296468a34.2;
        Wed, 07 Jun 2023 03:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686133735; x=1688725735;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MXI2Gtsei1k0G6deJ67EAfkNJaS9CBOu3IprceQovzY=;
        b=a7wx2uiptoDsHzFspdGUqfWT6VIvTFL9OM9b4K/sptmB1x4B0A9ExCWBHPzDmaWCrv
         QsofcsNn0gfZEmK6zpJh0s7MtP1pOYDjBzmUgCtM47FLBLYii5NlWR8k9fm1N6C8F5cm
         tC9lvCyIdNWwBTrrsUZNtzp0Mytgc9e6gOmPgBErBv+hzODWRbEavcsoWyH8zuz9kqtU
         qcHV3egOy4Ux3qaI8GBJDS+txS81r7QLWPESAYM5t2BfLm7rCM/Kzxs8S5Gpro8/F2GC
         2xNukE53+Kygce/Jvz4WcvU9DNZUjHqkE0y6sI6zVzBCAZpofHVapxRGMyIrhUueUIPy
         M8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686133735; x=1688725735;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MXI2Gtsei1k0G6deJ67EAfkNJaS9CBOu3IprceQovzY=;
        b=UI5AOjMNIkG7sfr+qQT3NRnZK5bv5iJ1BGnhzFAJAOj80G3rSJxX0yi8Nng5iwQhhL
         X2z8If0y/6pkPe8F7rUHlUDi1aVXz/ZwxzcdoyZ8ewCN9s6vDmSh0o1s14yYaRBAL0nS
         6eW8/QxbKulCTDN05tcdtyZtDmH4lCRG06GdTmNxj3sRnxL+xLO8vY2VCNpbj6S/9R33
         koS2zllKFhERKsAqThxZY3eGrUfGtROXGspcHnxI5XxZw3P08zHfZBggtibcRw1A5v4T
         X4Gw22zjYC1ae3gO1s/JrarxK8HeaQ589JcEBFC42eCmOadjWPNglqILaQYtteYHF7nk
         xu/Q==
X-Gm-Message-State: AC+VfDxQL5ZrX6leRoH0GOSuiJ7erC1G8Gs4VZvO3PhalbTbrbockR7+
        0Ideh39D6hqw5O7qtHi7IZt6z7wWdfk=
X-Google-Smtp-Source: ACHHUZ4rwlnWnl+AIriPUB3Ymbt08F/WtrdGklACsPApeaIjJsK6QtaBYtHilXWmDZ3WEdiqvRZE4A==
X-Received: by 2002:a9d:69d9:0:b0:6b0:c531:ce3d with SMTP id v25-20020a9d69d9000000b006b0c531ce3dmr5076510oto.24.1686133735337;
        Wed, 07 Jun 2023 03:28:55 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id w14-20020aa7858e000000b0064ca1fa8442sm8442507pfn.178.2023.06.07.03.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:28:54 -0700 (PDT)
Date:   Wed, 07 Jun 2023 15:58:50 +0530
Message-Id: <87zg5bin19.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv8 1/5] iomap: Rename iomap_page to iomap_folio and others
In-Reply-To: <ZIAojzrF5sEKDYmI@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

>> -static struct iomap_page *
>> -iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
>> +static struct iomap_folio *iomap_iof_alloc(struct inode *inode,
>> +				struct folio *folio, unsigned int flags)
>
> This is really weird indenttion.  Please just use two tabs like the
> rest of the code.

Ok, sure. Will fix this indentation in the next rev.

-ritesh
