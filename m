Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2256DF7F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 16:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjDLOEA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 10:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjDLOD7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:03:59 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DC319A4;
        Wed, 12 Apr 2023 07:03:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id jx2-20020a17090b46c200b002469a9ff94aso9827253pjb.3;
        Wed, 12 Apr 2023 07:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681308238; x=1683900238;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=topQsDNAh5OJ4afV28lmdimpoxO70P5sf2cG8WEdKI4=;
        b=WwJGiVe3K0IMN0tRP1AypK4QIvNxGc+X7e9jaOemfCFNhoJMvHbiMqeK9ho6cDIdy4
         T90NzAFo1IE+h/5Yx78hEbD27kW/6sBi+bSTXtKyk/yBONhvDl7Ln68VBuyGu8O8jC2m
         o8vuEVNvS18dPcWSigv4iiSWTOX1/pcMxYXWeaoy+PwR1/coTdVpvMJHQVzwWd08iu1s
         YDoN0sdbr6is0iTSI8Xboq0RZgiPOcGPOyJ/BcN8cU1M+Z3dII2c9iWpzqcl3rk9sBvM
         w1SY9QPtfJOjupgeYUec5VQCYrKcv5zCz9IySbDjNjfBcF4iGNMAMtYAmbtK6aPUtAX1
         7Uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681308238; x=1683900238;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=topQsDNAh5OJ4afV28lmdimpoxO70P5sf2cG8WEdKI4=;
        b=SQiSzJGQpdLXCcyzFoMWQSoWFqCKHgHXddnIRZmo2Vhe3Rrv5FocAx1gbQe8ftwkmr
         hcvNPVHHfJh7ZIXJ30WVQBjqbfpHCTnfXlKM60XPlYDj5vxmUo52IdR0Pe1TNXs0zmno
         cMTP4hzwru8fMEwx3HgH0oaNiaZjXfQ2EAGoevOAVFRpG+tNTq3w2ixZHoI/KCss6ini
         HebTxMHU4Oth+WegKPfkkdQ0XXvwtUEU8npDj2tZBistmVt5kCijsY6n8iKd+ULaqJOt
         22i08bXvFniJmWaooirfDGVXyPXqedt1ARPqS5SkzL7xa/c+gKyxQGulXVCHkh/64UG3
         ZGLw==
X-Gm-Message-State: AAQBX9cKcypo9Nfkz1o+EotxsYuDcfI6RIZYdbWvtB2RTWJidw3ENyUD
        rjIw2sDpOQaVP+c3SAyKg+M=
X-Google-Smtp-Source: AKy350Y8uTYZqxLUBt0TeQ2KxXo5K/VBf3ia2WY3D+9i4n1SqwhQOsckypZveGrZrR765ZPwCMwb3A==
X-Received: by 2002:a17:90b:3b4a:b0:23f:618a:6bed with SMTP id ot10-20020a17090b3b4a00b0023f618a6bedmr24389082pjb.47.1681308237783;
        Wed, 12 Apr 2023 07:03:57 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id iw22-20020a170903045600b001a1add0d616sm8933016plb.161.2023.04.12.07.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:03:57 -0700 (PDT)
Date:   Wed, 12 Apr 2023 19:33:51 +0530
Message-Id: <87r0spyz7c.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [RFCv2 5/8] ext2: Move direct-io to use iomap
In-Reply-To: <ZDaZfuq+wi5KKRfs@infradead.org>
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

> On Tue, Apr 11, 2023 at 08:51:24PM +0530, Ritesh Harjani wrote:
>> >> +	if ((flags & IOMAP_WRITE) && (offset + length > i_size_read(inode)))
>> >
>> > No need for the second set of inner braces here either.
>>
>> It's just avoids any confusion this way.
>
> Does it?  Except for some really weird places it is very unusual in
> the kernel.  To me it really does add confusion.

Ok, In that case, will change it.

Thanks for the review!
-ritesh
