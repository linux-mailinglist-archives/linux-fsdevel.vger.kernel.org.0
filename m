Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0276DF809
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 16:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjDLOKP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 10:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjDLOKM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:10:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9D57AA5;
        Wed, 12 Apr 2023 07:10:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso14691510pjs.0;
        Wed, 12 Apr 2023 07:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681308608; x=1683900608;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gNBxKnmul2N/izD6qkqE+9iQuFZV/NFnxZ82gTadVIg=;
        b=QnzrajF47yModIaLXV0AbKb5VKIT3UgiYlYaGwFLLGMvjE7W7FeIswXPYFXX3wHbZZ
         76tfQXK8Iv7pTbOwZpjMbhPR/71ijo7cBdS2r3JUawFKk8K9tRJuqSeCtlOzHltQadJw
         jf+geA7jOZH5OazQG606YDU2hmm0pSKr6JfRN2owu9chuz5ToXATcgJFaG7koW/2K7En
         haWTEoBUH9Wk7xxXb8GsqSQRzAHNkBUFNEHI29fJmnGBbu8QomqXp4+Cgp6d3g1+PFTN
         G1Kx94kXH5v4vFcsQppwa1LZSOO6Cknndv/5BvsjYnsEp4Y+Vf+IoBHaEHDH698UsLqb
         odkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681308608; x=1683900608;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gNBxKnmul2N/izD6qkqE+9iQuFZV/NFnxZ82gTadVIg=;
        b=LFx5xOh+5ED1MwHvWVl3ZqwIBBK52mnbUtNE7s5zxIs/N50mcQOQocPL1Lj2t/3dFu
         ZsqLRlYma4rOpZfrMp5WB0FWZjWhs1hSjLS31gRRHuLZthB/NNqXfYOcnksEPKPs+5Bc
         aI3DeQ72nWFSKwx9ui6+TrkP2OuflUD9r0m1YCYa3ZCc7u8rg8biKDrzF6oz6Lcq4pqF
         6m/UCRPUAl3WfxN95VVU98WY7+hQ+Yze+hjTraiBM3M4mxWZv5DF0BZg3XustntPTHlr
         HRBAYfg4hNHvE+OGFt/nRiTpfwYKu8wzQiff0Osh3u4bLzYKQkek62smbpKibu83hOb8
         HIGg==
X-Gm-Message-State: AAQBX9fqMjW5GdtwFSBS3WYcKlB7xJ8IQsmOMmv4cVAH+ozrY6rdYzwD
        l5iPLaG+3bRc8NmZGmN3JmKXjs/5Lao=
X-Google-Smtp-Source: AKy350ZlXq8/9BzYo4s9clHo61FnodmrT/mwTcSLo97CPTtHTCSUBzy4rXayJ/BicXKZs9p9GvVA3Q==
X-Received: by 2002:a17:90a:2e03:b0:244:952c:9701 with SMTP id q3-20020a17090a2e0300b00244952c9701mr23559662pjd.7.1681308608347;
        Wed, 12 Apr 2023 07:10:08 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090adb4200b00246cfdb570asm1522073pjx.27.2023.04.12.07.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:10:07 -0700 (PDT)
Date:   Wed, 12 Apr 2023 19:40:02 +0530
Message-Id: <87leixyyx1.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [RFCv2 0/8] ext2: DIO to use iomap
In-Reply-To: <20230412114525.m7rjvq3pr3aad2al@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> Hi Ritesh!
>
> On Tue 11-04-23 10:51:48, Ritesh Harjani (IBM) wrote:
>> Please find the series which moves ext2 direct-io to use modern iomap interface.
>> 
>> Here are some more details -
>> 1. Patch-1: Fixes a kernel bug_on problem with ext2 dax code (found during code
>>    review and testing).
>> 2. Patch-2: Adds a __generic_file_fsync_nolock implementation as we had
>>    discussed.
>> 3. Patch-3 & Patch-4: Moves ext4 nojournal and ext2 to use _nolock method.
>> 4. Patch-5: This is the main patch which moves ext2 direct-io to use iomap.
>>    (more details can be found in the patch)
>> 5. Patch-6: Kills IOMAP_DIO_NOSYNC flag as it is not in use by any filesystem.
>> 6. Patch-7: adds IOCB_STRINGS macro for use in trace events for better trace
>>    output of iocb flags.
>> 7. Patch-8: Add ext2 trace point for DIO.
>> 
>> Testing:
>> =========
>> This passes ext2 "auto" group testing for fstests. There were no new failures
>> with this patches.
>
> I went through the patches and I have no further comments besides what has
> been already said. So feel free to update patches based on other feedback,
> I'll do the last round of review and can queue the patches to my tree.
>

Sure, thanks Jan for going over the patches.
I will send the next rev soon addressing review comments along with some
other minor changes.

-ritesh
