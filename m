Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EAB6E978D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 16:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjDTOs0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 10:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjDTOsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:48:25 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792EB49E5;
        Thu, 20 Apr 2023 07:48:24 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a52667955dso13154135ad.1;
        Thu, 20 Apr 2023 07:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682002104; x=1684594104;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I+xtqkXSybN9uyBvYoyBXVWxoM9Vx/exjZFks1doCj4=;
        b=X8c4h1+7m84l6C+cEW7A9LGiosHnoaoJXVoieQGq9u3XYWJdNBY+3eJC2pHNtDoHvY
         jYdOMfQOzDflc3zSJ04hSEIDzIoTFLkIEUWiWtYMgZ7h/0aMk0oFsQX9IYWKAlg8MiK4
         A3+E9emAgZmVVXTfIhwaeRFj2S16be6nEgtLhiIUaxPNRTX8aYTYWVz+4u2Eg79RYZ+t
         9Zc8qdr4Prrs9EkwUm9D8dEQq//2MSdm2/hsEWqddtbkeIYd4hs0S32sqL3iBtZ+yKv2
         aS/gfIkLYOqw9RpoqhOTmKR7Fw2i1kjcdwxdjRsR+LEyjTadvVWXsFcgNJTJlK8cV9ov
         0DIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682002104; x=1684594104;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+xtqkXSybN9uyBvYoyBXVWxoM9Vx/exjZFks1doCj4=;
        b=AQpCiz6KsO0w5VDrliLF8QSy32gt7IijUqjH7CIU1RRfNJbmLTGc7IXl1Pi6fmX2c2
         jlSTjHxfe/awr4zEeQOQlpm9Q2vmMe8TGx2CJ0m3l2AWee3jL+PAxsX6SpcL7bfBFJvL
         ORbuypt3hRFhCESrkG2f/XzDCrj9e1GwP9TTjJtHrtoJbSRdY5Gxcu550mA4ZWbkg6Gc
         iOmJdytaYIVMsON8VQOMugBgPbUqdqDbnolt5eYbOh7W5JRJRmABDYWhBgpi499YqNAb
         gOS9EpYwQJnUpxMAUC+PPIt/Pzo4hl0cKcdKkVe3edkD/Y51ArRutfPVqa4HS/XV3epL
         k1TA==
X-Gm-Message-State: AAQBX9cE9SXKG3fEfHqH/2+OSx33iC0SV/iTAd0lvj1iohzLgXNQC3z9
        12jOoQoPM1pvdRqtP3IIfD8=
X-Google-Smtp-Source: AKy350aJEqRmtMVL3iDwpgKhHKa6yVMNDocylssZk6NOlz+tGRAu0fPhlKYYAlKEwPpq/nhGEMuwOg==
X-Received: by 2002:a17:902:ebcb:b0:1a5:3319:12f7 with SMTP id p11-20020a170902ebcb00b001a5331912f7mr1997913plg.50.1682002103919;
        Thu, 20 Apr 2023 07:48:23 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:2dd2:8818:e6e1:3a73:368c])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902ff0100b001a5059861adsm1254408plj.224.2023.04.20.07.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 07:48:23 -0700 (PDT)
Date:   Thu, 20 Apr 2023 20:18:17 +0530
Message-Id: <87h6taip8u.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv5 5/9] ext2: Move direct-io to use iomap
In-Reply-To: <20230417112006.3bzzitsxy67jpviq@quack3>
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

> On Sun 16-04-23 15:38:40, Ritesh Harjani (IBM) wrote:
>> This patch converts ext2 direct-io path to iomap interface.
>> - This also takes care of DIO_SKIP_HOLES part in which we return -ENOTBLK
>>   from ext2_iomap_begin(), in case if the write is done on a hole.
>> - This fallbacks to buffered-io in case of DIO_SKIP_HOLES or in case of
>>   a partial write or if any error is detected in ext2_iomap_end().
>>   We try to return -ENOTBLK in such cases.
>> - For any unaligned or extending DIO writes, we pass
>>   IOMAP_DIO_FORCE_WAIT flag to ensure synchronous writes.
>> - For extending writes we set IOMAP_F_DIRTY in ext2_iomap_begin because
>>   otherwise with dsync writes on devices that support FUA, generic_write_sync
>>   won't be called and we might miss inode metadata updates.
>> - Since ext2 already now uses _nolock vartiant of sync write. Hence
>>   there is no inode lock problem with iomap in this patch.
>> - ext2_iomap_ops are now being shared by DIO, DAX & fiemap path
>>
>> Tested-by: Disha Goel <disgoel@linux.ibm.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
> One comment below:
>
>> @@ -844,6 +868,13 @@ static int
>>  ext2_iomap_end(struct inode *inode, loff_t offset, loff_t length,
>>  		ssize_t written, unsigned flags, struct iomap *iomap)
>>  {
>> +	/*
>> +	 * Switch to buffered-io in case of any error.
>> +	 * Blocks allocated can be used by the buffered-io path.
>> +	 */
>> +	if ((flags & IOMAP_DIRECT) && (flags & IOMAP_WRITE) && written == 0)
>> +		return -ENOTBLK;
>> +
>>  	if (iomap->type == IOMAP_MAPPED &&
>>  	    written < length &&
>>  	    (flags & IOMAP_WRITE))
>
> Is this really needed? What for?
>

Sorry Jan, I got caught into something else so couldn't respond on this
earlier. Thanks a lot for review.

I don't think this will be called for IOMAP_DIRECT for write case.
I mostly see this code was already present for IOMAP_DAX path.
It is to truncate the blocks in case if the iomap dax write failed to
write but the blocks might have been allocated in ->iomap_begin
function.

Is there a specific query that you would like me to check and verify?
I can check more by probing this path to see what happens when this gets
called. But my understanding was it is used for truncating blocks as I
mentioned above.

Thanks
-ritesh
