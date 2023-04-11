Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E7F6DDF4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjDKPOT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 11:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjDKPNm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:13:42 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B49526C;
        Tue, 11 Apr 2023 08:12:36 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id v9so13623453pjk.0;
        Tue, 11 Apr 2023 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681225954; x=1683817954;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9o0AHkisQOv5tXi4eDVw+mqq4mAfpkhDRa5S3sXV+aI=;
        b=C5n7WD7Tx+rIWnaesEt2bqaEUma73ExoLTIxbxrTjJQ63PMsQF26lv1ghrOl4kB3NU
         SKmnroRrgJT8PLMeIiZURZp9zXzLuZNsNtn8K+gW7pen6QTbQT+5UJ6fIocEcuhuIaRx
         02fKZonpTwpTp1CeFewx4AKaCw+cuM5kgVecYT/78Ug9N0hmqkh+Z3qM4i8L/d8mMLmm
         lhUUvsauzPtBhlBDF9uAbky6gUEvmPUBVVlfzBZ1IcVRDgxLrEuIZ8paJCVXQ0zW1Ssr
         JnMrewbgocXQpCeLrvNEoR/aIwqXXvgPKnFubepSi4ndDUwrXSM/D26GIIEf3okekO+g
         svtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681225954; x=1683817954;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9o0AHkisQOv5tXi4eDVw+mqq4mAfpkhDRa5S3sXV+aI=;
        b=qnVaW9n6fwuv0zFPkfqxBPbEjI8Q7JyuwYapmBq3y5vz/DZ3xO1tss7mzseLtvAr4S
         m6coYRuRxeIknYCz5G/2NVWzUfogMwc9TXEyN7WfXagxrjJK5PdXNev6aD1fyqgc7/ol
         rC9QMM4hOBbMHrlHjXqSS7P70Zy7sQkxWtEWwSA5lCzFuvVGxH3oh1LPB31GE4g+imjQ
         /vNF3Z2Ka6W40Fysbz89JpUQKHYdYRiDqNpk31iQH1MQocpRRj7b4rOIf6Fc/7SpS9+6
         nVrODru/VJorYZDOtiQWiAqvDBm+K9/70FvC/G3bEAxtIrzK4fevaKYgfOsnzN92b/N0
         Fc5w==
X-Gm-Message-State: AAQBX9ci2z+SXUxKevCqvVQUcyMFClPALnnvEf4UJGq465DleCxe+ddq
        uv68E7rU0IM2RHqxwG0a868=
X-Google-Smtp-Source: AKy350ZtODJN7e2H1oAUGzqGpa7+itB86r01WTnKUlsUTVsBRTPasEBrJqIolyQktsV41eO9T+7TmA==
X-Received: by 2002:a17:902:fa8e:b0:1a6:4e86:6ca1 with SMTP id lc14-20020a170902fa8e00b001a64e866ca1mr2848132plb.9.1681225954165;
        Tue, 11 Apr 2023 08:12:34 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001a651326089sm2109049pld.309.2023.04.11.08.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 08:12:33 -0700 (PDT)
Date:   Tue, 11 Apr 2023 20:42:28 +0530
Message-Id: <87zg7ezc4j.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [RFCv2 2/8] libfs: Add __generic_file_fsync_nolock implementation
In-Reply-To: <ZDVTjX/ZtJZWkHyD@casper.infradead.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Apr 10, 2023 at 10:27:10PM -0700, Christoph Hellwig wrote:
>> On Tue, Apr 11, 2023 at 10:51:50AM +0530, Ritesh Harjani (IBM) wrote:
>> > +/**
>> > + * __generic_file_fsync_nolock - generic fsync implementation for simple
>> > + * filesystems with no inode lock
>>
>> No reallz need for the __ prefix in the name.
>
> It kind of makes sense though.
>
> generic_file_fsync does the flush
> __generic_file_fsync doesn't do the flush
> __generic_file_fsync_nolock doesn't do the flush and doesn't lock/unlock

Yes.

>
>> > +extern int __generic_file_fsync_nolock(struct file *, loff_t, loff_t, int);
>>
>> No need for the extern.  And at least I personally prefer to spell out
>> the parameter names to make the prototype much more readable.
>
> Agreed, although I make an exception for the 'struct file *'.  Naming that
> parameter adds no value, but a plain int is just obscene.
>
> int __generic_file_fsync_nolock(struct file *, loff_t start, loff_t end,
> 		bool datasync);
>
> (yes, the other variants don't use a bool for datasync, but they should)

Sure. Will make the change.

-ritesh
