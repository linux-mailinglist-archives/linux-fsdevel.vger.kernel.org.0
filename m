Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E801198749
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 00:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgC3WUQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 18:20:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37143 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbgC3WUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:20:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id j19so547717wmi.2;
        Mon, 30 Mar 2020 15:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zxTDf8+MnFHubZYH4xBNOl2XtpGfjXLmP1euby1NHHI=;
        b=XelqlNCBNrqAvwAR/h7n/I+jsAusk4uQ3gc4RmSAdCSE1MeAtafoM+J0UO6ALvWAzx
         JU4wtAVr8yQQ6VFVag0SgNR75GoxuKhUbtgMadsd/pC+AubNJOf3fbqp1evcbKIJJv24
         9VwvrazqeLn/qiHPpBPWvCUSfpp4J32kXw02xYPTNhWgct4wyzosiBarbdp5iootZX5g
         jm0SblnIqO1zrrfJp0mRsWqA+Fm3DcZcZsZmx1JX7ehD8Z5/sDiMJu7ajNIdHAoOKKBP
         rL0rrv6BQ4jc1tBY1PgFjc7NECsMVVOqFxUwkdR/12KKiKgE7pOwtb7hyThatEzQZfF1
         k0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zxTDf8+MnFHubZYH4xBNOl2XtpGfjXLmP1euby1NHHI=;
        b=hJ5WDCvJz2o3N9av/M2COargggFLCIxk6Z1kBvEGW1WQhIuiIw2geQHU2ymCbltQdP
         POyR9BJN2TK755Ly/ovfd7a5+ritqwI8RbfsmnGAS4vVN5n5aPb5l2urz9hbiXQsYQM8
         XhUDbrwNthtcxmQGfjIo7oFfoYxQqZ6IkMldpZj6844D4FAq9P2DVQsCtIlH1S/V4z4G
         JSHVoB63AiD25ctsQh2p7TL4YjEqmTleylYxqwlVpfKPs/l4abG1pRkDcKwQHnTsqq5L
         i3hhCLz2kchzzw8oTKejYHy+px5gHgR7R/TGmGV+oX1mE1wUlsBjn6opUtydO1sE/jFt
         QGIw==
X-Gm-Message-State: ANhLgQ0QjpsiCxZGCqnxbrddzh8tkwUbAehM4F3Igky6U8gl81VR/kLF
        jNEYmespjv6LpMZXemSV4gM=
X-Google-Smtp-Source: ADFU+vvQIj+MUR+EYO8VdoIOGwvNsipNI0VJFCtEu0BqPBf0GZUmNJ8l9EP7fyP1NI8U+TEOwovI5Q==
X-Received: by 2002:a7b:c24a:: with SMTP id b10mr227358wmj.61.1585606814046;
        Mon, 30 Mar 2020 15:20:14 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a10sm15432401wrm.87.2020.03.30.15.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 15:20:13 -0700 (PDT)
Date:   Mon, 30 Mar 2020 22:20:13 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] XArray: internal node is a xa_node when it is bigger
 than XA_ZERO_ENTRY
Message-ID: <20200330222013.34nkqen2agujhd6j@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-7-richard.weiyang@gmail.com>
 <20200330125006.GZ22483@bombadil.infradead.org>
 <20200330134519.ykdtqwqxjazqy3jm@master>
 <20200330134903.GB22483@bombadil.infradead.org>
 <20200330141350.ey77odenrbvixotb@master>
 <20200330142708.GC22483@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330142708.GC22483@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 30, 2020 at 07:27:08AM -0700, Matthew Wilcox wrote:
>On Mon, Mar 30, 2020 at 02:13:50PM +0000, Wei Yang wrote:
>> On Mon, Mar 30, 2020 at 06:49:03AM -0700, Matthew Wilcox wrote:
>> >On Mon, Mar 30, 2020 at 01:45:19PM +0000, Wei Yang wrote:
>> >> On Mon, Mar 30, 2020 at 05:50:06AM -0700, Matthew Wilcox wrote:
>> >> >On Mon, Mar 30, 2020 at 12:36:40PM +0000, Wei Yang wrote:
>> >> >> As the comment mentioned, we reserved several ranges of internal node
>> >> >> for tree maintenance, 0-62, 256, 257. This means a node bigger than
>> >> >> XA_ZERO_ENTRY is a normal node.
>> >> >> 
>> >> >> The checked on XA_ZERO_ENTRY seems to be more meaningful.
>> >> >
>> >> >257-1023 are also reserved, they just aren't used yet.  XA_ZERO_ENTRY
>> >> >is not guaranteed to be the largest reserved entry.
>> >> 
>> >> Then why we choose 4096?
>> >
>> >Because 4096 is the smallest page size supported by Linux, so we're
>> >guaranteed that anything less than 4096 is not a valid pointer.
>> 

So you want to say, the 4096 makes sure XArray will not store an address in
first page? If this is the case, I have two suggestions:

  * use PAGE_SIZE would be more verbose?
  * a node is an internal entry, do we need to compare with xa_mk_internal()
    instead?

And also suggest to add a comment on this, otherwise it seems a little magic.

>> I found this in xarray.rst:
>> 
>>   Normal pointers may be stored in the XArray directly.  They must be 4-byte
>>   aligned, which is true for any pointer returned from kmalloc() and
>>   alloc_page().  It isn't true for arbitrary user-space pointers,
>>   nor for function pointers.  You can store pointers to statically allocated
>>   objects, as long as those objects have an alignment of at least 4.
>> 
>> So the document here is not correct?
>
>Why do you say that?
>
>(it is slightly out of date; the XArray actually supports storing unaligned
>pointers now, but that's not relevant to this discussion)

Ok, maybe this document need to update.

-- 
Wei Yang
Help you, Help me
