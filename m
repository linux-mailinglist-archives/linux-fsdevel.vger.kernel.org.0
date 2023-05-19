Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A79D709766
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 14:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjESMli (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 08:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjESMlh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 08:41:37 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2973A1A8;
        Fri, 19 May 2023 05:41:14 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DA9A57C0;
        Fri, 19 May 2023 12:41:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DA9A57C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684500067; bh=Mn4aex3r3tcIexmUxRNT5U8Atc2UG4Nc4lQH6evssMM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gZf7ANIZaa/7Q1rgunvrPwGwZDiRrPQJh/r7c+04LjcKROD6SaQA32cv+SfHF31sn
         1Wzq7+aPFp6z0FAhq083CUKfk3SfcVpzAE5TdWCGjz2GDzWdPU8ZAS474OAB7Kh8Sj
         EhjRG1hILuCbGyNju46jjgjQf4amw6zocsFbL3f83Nb+NE+UpF1KvjhErswaiNfpNi
         VGFQmHb4BUF4c9e6k6+nEab9l6PFf3YZIaSVEHVS6vdszIN+c9Od3Ff+kvqlllo3qe
         vPdiMiNROHj/JEUpNHZJ7og7Ayy6wtlJfa8/uYMWA6ASUwxz2btxw4d0G4wH25bzVl
         sDSS6ZHkOa7ZA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dave Chinner <david@fromorbit.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     jake@lwn.net, hch@infradead.org, djwong@kernel.org,
        dchinner@redhat.com, ritesh.list@gmail.com, rgoldwyn@suse.com,
        jack@suse.cz, linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com
Subject: Re: [PATCH v2] Documentation: add initial iomap kdoc
In-Reply-To: <ZGbVaewzcCysclPt@dread.disaster.area>
References: <20230518150105.3160445-1-mcgrof@kernel.org>
 <ZGbVaewzcCysclPt@dread.disaster.area>
Date:   Fri, 19 May 2023 06:41:06 -0600
Message-ID: <87r0rcpk7x.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave Chinner <david@fromorbit.com> writes:

One little point among all the more substantial stuff:

>> -/*
>> - * Types of block ranges for iomap mappings:
>> +/**
>> + * DOC: iomap block ranges types
>
> I seriously dislike this "DOC:" keyword appearing everywhere.
> We've already got a "this is a comment for documentation" annotation
> in the "/**" comment prefix, having to add "DOC:" is entirely
> redudant and unnecessary noise.

DOC: actually isn't redundant, it causes the kernel-doc directive to
pull that text into the rendered documentation.

This document shows both the advantages and disadvantages of that
mechanism, IMO.  It allows the documentation to be kept with the code,
where optimistic people think it is more likely to be updated.  But it
also scatters the material to the detriment of readers of the plain-text
documentation.  The rendered version of iomap.rst is rather more
complete and comprehensible than the RST file itself.

Thanks,

jon
