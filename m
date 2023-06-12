Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AC772CA31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 17:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbjFLPdS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 11:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbjFLPdJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:33:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D6610C2;
        Mon, 12 Jun 2023 08:33:08 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b3b3f67ad6so17459735ad.3;
        Mon, 12 Jun 2023 08:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686583988; x=1689175988;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nhrxGfhiU8mnI+Qui4ZsDfQuxzfLN1KbJ8U40slvmi4=;
        b=IY5/++DvYAINuv/PlmPo+XYtXjoLcD3Yf6OBHV52sziyCr/f1bljpB73JIsif+cOoa
         5Sw8AZM+tRDOwDJAJR3+GmlJAnnmN9o3wmf4Fjz3p330kqiIqY2mPioV5PehoGpyDENV
         VnIFgK6S6w47QvHc5OXNVqi/M7x8x+jxtT7eBTSgwvGv1bMazVGT1FfitmKnk078/xX7
         lo3RIa73378LnqEeQ9gpdoD1/tDElpPSqhijSy/kR7ckdb8ZkzYv2IkIPOchhRulb8WV
         uTLoCev9VB2BYFL5jPSjtnGCZehkHfwv+BskZkAjuIczRBEmRyUMphwi/YQ+IXPFnu4U
         2r8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686583988; x=1689175988;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nhrxGfhiU8mnI+Qui4ZsDfQuxzfLN1KbJ8U40slvmi4=;
        b=FYjUtMDOeV3dgVbh0PDhSrYKISCUC82piZO9ghEjUKHXOurIz+GUVm73QYg8BdvZYX
         JodaMH+8YYdtji6JDySKhlZg9XmogNILxj5lL040SSIIaW1cga01HgAOC56QK7N+BzGa
         cR0aRS4vMbb45P5/NWCy4qm+5hbSpqUhHEdzhBKnnIGe+BxpO4W3WfLIUa0Ek6Dvz1SD
         yonUIQru9vUj67jz6F2jcaKqZjCLPdL5E1tN0N4LkVpN7xnfMX4ADlGD7I6/8WsDRdkY
         0sKZ2yJszRjNW1kMLK9dChCK7AvfPh6yM/AZr0BT00hXX88Fp12z2dQEgQkqiYT6AHu8
         dRpg==
X-Gm-Message-State: AC+VfDxMxMYsFgGs5CjBQf4A14E4jxVLnFs2Apkc8mtGLn7mqf8Vgd6c
        0krShVe6apqAy3mXTKS9C8c=
X-Google-Smtp-Source: ACHHUZ7IemVkBcYi3KBXxBvUr8jSD36KFfmmTM63ExphjBf7uwFtoMfREdDgqpMfy0ej5i0Q6fAr2A==
X-Received: by 2002:a17:902:ce8a:b0:1aa:d545:462e with SMTP id f10-20020a170902ce8a00b001aad545462emr8159783plg.13.1686583987927;
        Mon, 12 Jun 2023 08:33:07 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id t20-20020a1709028c9400b001b176d96da0sm8444430plo.78.2023.06.12.08.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:33:07 -0700 (PDT)
Date:   Mon, 12 Jun 2023 21:03:03 +0530
Message-Id: <87fs6whf0w.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 3/6] iomap: Add some uptodate state handling helpers for ifs state bitmap
In-Reply-To: <ZIc4ujLJixghk6Zp@casper.infradead.org>
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

> On Mon, Jun 12, 2023 at 08:48:16PM +0530, Ritesh Harjani wrote:
>> > Since we're at the nitpicking, I don't find those names very useful,
>> > either. How about the following instead?
>> >
>> > iomap_ifs_alloc -> iomap_folio_state_alloc
>> > iomap_ifs_free -> iomap_folio_state_free
>> > iomap_ifs_calc_range -> iomap_folio_state_calc_range
>>
>> First of all I think we need to get used to the name "ifs" like how we
>> were using "iop" earlier. ifs == iomap_folio_state...
>>
>> >
>> > iomap_ifs_is_fully_uptodate -> iomap_folio_is_fully_uptodate
>> > iomap_ifs_is_block_uptodate -> iomap_block_is_uptodate
>> > iomap_ifs_is_block_dirty -> iomap_block_is_dirty
>> >
>>
>> ...if you then look above functions with _ifs_ == _iomap_folio_state_
>> naming. It will make more sense.
>
> Well, it doesn't because it's iomap_iomap_folio_state_is_fully_uptodate.

:P 

> I don't think there's any need to namespace this so fully.
> ifs_is_fully_uptodate() is just fine for a static function, IMO.

Ohh, we went that road but were shot down. That time the naming was
iop_is_fully_uptodate(). :(

-ritesh
