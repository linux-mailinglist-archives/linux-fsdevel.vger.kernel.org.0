Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5292F6E44B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 12:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjDQKDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 06:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjDQKDP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:03:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D6046B0;
        Mon, 17 Apr 2023 03:02:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d15so7830818pll.12;
        Mon, 17 Apr 2023 03:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681725729; x=1684317729;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=60RYb0d0Yvrv2VTb/aW0qraeJwiiH8SAqHhNyRc8kXA=;
        b=cn+729yhQfxJ/u8Op5AHVMVhF+y9hWlJ8aZF2/XW0rKWTgq3+5zPamciFhy8BZtFQY
         0thDP8wtjhW/Di2zzfwRXkr3aVJ3aiUgZYti+7QMN/S3+5jnNFIK9OuzvEyQDNux8Yku
         HJhqEK88iQ1CH7H+Pb53t5hDr/odNWBmfRvDKurVgnZu9Dz2KuxqqoZ4UzyVLdi4G5v5
         VRiL7y4Er7GVV+eKRzis2eGyr48NEe5aUQjABdVUMoX5mAvjkmxUTvL1gHBxBC4FRTae
         eVAHD5bXU9vvkbC3Z2PeMPR8layfKqjSXszVaNg/5NnPGvKQsNTsqSsx8wy4aorA3p6i
         8B6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681725729; x=1684317729;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=60RYb0d0Yvrv2VTb/aW0qraeJwiiH8SAqHhNyRc8kXA=;
        b=aJs9NwRFi9EImoIaDTCigaFyyquEySQtOihsJSNj9LIniBG+a2Xx3Vf+CIh9ymsebg
         V/q9UUD2pscu66k6NELbr+x0nYWlh9vyxBXT7hKRtPNgPpAWyDzNSqovgcnCPTcnBfmn
         sC25nO+37crkW1tA3bhKT4UjN7uDuIB+fRHz7D1EPH/uCCKGWZH2OT7emO5RssiwD8Hl
         Ic7q0QVPgyxLN9MPm1zSRYQD2jo4TWlN41YsDAqV9727s0vGGfSs9c7PS51p/lrlqrFV
         zVs7/XSDcsrWjfx74GjRHBpgdO1nc50T9aZsgzTgruPXb6x+Tp0+zO1gq0r0DRoVW0ry
         8I3w==
X-Gm-Message-State: AAQBX9e5WK2NLJNzLELjfWnYA0mow3DzoZQRIiuXOV23SgiZPes9jkO5
        qTEMBHNd2iEhnQgQOI+Xaj0=
X-Google-Smtp-Source: AKy350ZIwLLUUrZgeyEQx7AsxlVUYKnepmMbry5s7rrYXTLXOGnFzckCga6vFYntaX9DwyAZYoa1Qw==
X-Received: by 2002:a05:6a20:7351:b0:ef:c4f6:9128 with SMTP id v17-20020a056a20735100b000efc4f69128mr3817033pzc.42.1681725728911;
        Mon, 17 Apr 2023 03:02:08 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:2dd2:1827:1d70:2273:8ee0])
        by smtp.gmail.com with ESMTPSA id fe25-20020a056a002f1900b0063b64f1d6e9sm5489854pfb.33.2023.04.17.03.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 03:02:08 -0700 (PDT)
Date:   Mon, 17 Apr 2023 15:31:53 +0530
Message-Id: <87r0sij08e.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv3 02/10] libfs: Add __generic_file_fsync_nolock implementation
In-Reply-To: <20230417073255.kzauk5qwu5bjcsmh@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> On Fri 14-04-23 19:59:42, Ritesh Harjani wrote:
>> Jan Kara <jack@suse.cz> writes:
>>
>> > On Fri 14-04-23 06:12:00, Christoph Hellwig wrote:
>> >> On Fri, Apr 14, 2023 at 02:51:48PM +0200, Jan Kara wrote:
>> >> > On Thu 13-04-23 22:59:24, Christoph Hellwig wrote:
>> >> > > Still no fan of the naming and placement here.  This is specific
>> >> > > to the fs/buffer.c infrastructure.
>> >> >
>> >> > I'm fine with moving generic_file_fsync() & friends to fs/buffer.c and
>> >> > creating the new function there if it makes you happier. But I think
>> >> > function names should be consistent (hence the new function would be named
>> >> > __generic_file_fsync_nolock()). I agree the name is not ideal and would use
>> >> > cleanup (along with transitioning everybody to not take i_rwsem) but I
>> >> > don't want to complicate this series by touching 13+ callsites of
>> >> > generic_file_fsync() and __generic_file_fsync(). That's for a separate
>> >> > series.
>> >>
>> >> I would not change the existing function.  Just do the right thing for
>> >> the new helper and slowly migrate over without complicating this series.
>> >
>> > OK, I can live with that temporary naming inconsistency I guess. So
>> > the function will be __buffer_file_fsync()?
>>
>> This name was suggested before, so if that's ok I will go with this -
>> "generic_buffer_fsync()". It's definition will lie in fs/buffer.c and
>> it's declaration in include/linux/buffer_head.h
>>
>> Is that ok?
>
> Yes, that is fine by me. And I suppose this variant will also issue the
> cache flush, won't it?

No. We don't issue cache flush (REQ_PREFLUSH) in generic_buffer_fsync(),
neither __generic_file_fsync() does that.

> But then we also need __generic_buffer_fsync()
> without issuing the cache flush for ext4 (we need to sync parent before
> issuing a cache flush) and FAT.

Yes, we do take care of that by -

<simplified logic>
ret = generic_buffer_fsync()
if (!ret)
   ret = ext4_sync_parent(inode)
if (test_opt(inode->i_sb, BARRIER))
   blkdev_issue_flush()

Am I missing anything. I have sent a [v5] with all of the comments
addressed. Could you please take a look and let me know if it looks
good or is there anything required?

[v5]: https://lore.kernel.org/linux-ext4/cover.1681639164.git.ritesh.list@gmail.com/T/#t

-ritesh
