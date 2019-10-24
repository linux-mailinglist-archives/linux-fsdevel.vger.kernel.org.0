Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB302E405B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 01:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbfJXX3K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 19:29:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33079 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731101AbfJXX3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 19:29:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id c4so391587edl.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 16:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=imd8LYeUoBm8DTeA8qPBj6oTMtTRlNJlWrB8UNsRURg=;
        b=fq94FQCVljJL8n1QnCTPl/iL6H5w3bnf/+l73zNSFs6OakFnAWfM/UwnbraJrYTHkU
         RQJxiVE6Pg1pfH3tAT2Ec+5vYbBGRvUfyMvoNi/mVJKbXl7dfS6Y+SPfbGz6XPTzfl+f
         HIvKAuJaS0SEbGEg2Pd+yy8ModIRF7utPp6COh9wiLgA6uP/xMfcf4vh7SZ5Nki0Jg5j
         ZPJiJKF7easac64tVp6DJrdgf6iAfGXoOYXUJEqwWtWbXTU3ZA0JqTTTNefzB4PTQkCh
         Dinc4V36iNos5fK3zMAAqGXi2E+yX/ukF13w5iCb5GbleOn3I/vQddbJaieLDpV5EXwr
         lxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=imd8LYeUoBm8DTeA8qPBj6oTMtTRlNJlWrB8UNsRURg=;
        b=SXZIXYISkrHBOsWirAODqluIc2EYb9HHzkBPDchQUB6l0ayH0VJrjoOFpVOmjjlOU0
         EIQCICSAvD/7cZ/jBZjCXwAdORfzFTAhqgRDnSeI/vw/eSMtz4oFgy1jKjJs4of708UL
         MFlgXxshOX5kiMlcmj+oD0BXercSQwL9CvgVs4+wVeHw0K09Haz832gXoy1D0mfXWhj7
         gZMO2I1UyyAm2OJRB8oBXjZ1iDAxcOEFIXY3TtbCYOPHj7KgNO1BYwF/49QmZyUbcKpF
         LuxqWrwTL8dzxQ43kngvLNlURafelRb+Zx6iAgyUpkesbJimnqptkWiApdsFiT7tsKPg
         36/w==
X-Gm-Message-State: APjAAAWAr8UkwOHD4KBZDSlKD4DxaQ127aLWkukl8C/BuZnhkhBIlg0U
        1wscRsXL1NgfOjSKA6W9/NyUy01B0l0=
X-Google-Smtp-Source: APXvYqw3KtG7+DSk8VtpXuw54AjSUY96h6dk6WFFfObVLeErXJlPS27jxyXyV6GZmNS8RM7R6Qen9g==
X-Received: by 2002:a50:da0f:: with SMTP id z15mr769859edj.137.1571959747939;
        Thu, 24 Oct 2019 16:29:07 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id oq18sm1653ejb.22.2019.10.24.16.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 16:29:07 -0700 (PDT)
Subject: Re: [PATCH 0/5] Enable per-file/directory DAX operations
To:     Dave Chinner <david@fromorbit.com>,
        Boaz Harrosh <boaz@plexistor.com>
Cc:     ira.weiny@intel.com, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20191020155935.12297-1-ira.weiny@intel.com>
 <b7849297-e4a4-aaec-9a64-2b481663588b@plexistor.com>
 <b883142c-ecfe-3c5b-bcd9-ebe4ff28d852@plexistor.com>
 <20191023221332.GE2044@dread.disaster.area>
 <efffc9e7-8948-a117-dc7f-e394e50606ab@plexistor.com>
 <20191024073446.GA4614@dread.disaster.area>
 <fb4f8be7-bca6-733a-7f16-ced6557f7108@plexistor.com>
 <20191024213508.GB4614@dread.disaster.area>
From:   Boaz Harrosh <boaz@plexistor.com>
Message-ID: <ab101f90-6ec1-7527-1859-5f6309640cfa@plexistor.com>
Date:   Fri, 25 Oct 2019 02:29:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191024213508.GB4614@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 25/10/2019 00:35, Dave Chinner wrote:
> On Thu, Oct 24, 2019 at 05:05:45PM +0300, Boaz Harrosh wrote:
<>
>> Yes I said that as well.
> 
> You said "it must be set between creation and first write",
> stating the requirement for an on-disk flag to work.

Sorry for not being clear. Its not new, I do not explain myself
very well.

The above quote is if you set/clear the flag directly.

> I'm describing how that requirement is actually implemented. i.e. what
> you are stating is something we actually implemented years ago...
> 

What you are talking about is when the flag is inherited from parent.
And I did mention that option as well.

[Which is my concern because my main point is that I want creation+write
 to be none-DAX. Then after writer is done. Switch to DAX-on so READs can
 be fast and not take any memory.
 And you talked about another case when I start DAX-on and then for
 say, use for RDMA turn it off later.
]

This flag is Unique because current RFC has an i_size == 0 check
that other flags do not have

>>> I also seem
>>> to recall that there was a need to take some vm level lock to really
>>> prevent page fault races, and that we can't safely take that in a
>>> safe combination with all the filesystem locks we need.
>>>
>>
>> We do not really care with page fault races in the Kernel as long
> 
> Oh yes we do. A write fault is a 2-part operation - a read fault to
> populate the pte and mapping, then a write fault (->page_mkwrite) to 
> do all the filesystem work needed to dirty the page and pte.
> 
> The read fault sets up the state for the write fault, and if we
> change the aops between these two operations, then the
> ->page_mkwrite implementation goes kaboom.
> 
> This isn't a theoretical problem - this is exactly the race
> condition that lead us to disabling the flag in the first place.
> There is no serialisation between the read and write parts of the
> page fault iand the filesystem changing the DAX flag and ops vector,
> and so fixing this problem requires hold yet more locks in the
> filesystem path to completely lock out page fault processing on the
> inode's mapping.
> 

Again sorry that I do not explain very good.

Already on the read fault we populate the xarray,
My point was that if I want to set the DAX mode I must enforce that
there are no other parallel users on my inode. The check that the
xarray is empty is my convoluted way to check that there are no other
users except me. If xarray is not empty I bail out with EBUISY

I agree this is stupid.

Which is the same stupid as i_size==0 check. Both have the same
intention, to make sure that nothing is going on in parallel to
me.

>> as I protect the xarray access and these are protected well if we
>> take truncate locking. But we have a bigger problem that you pointed
>> out with the change of the operations vector pointer.
>>
>> I was thinking about this last night. One way to do this is with
>> file-exclusive-lock. Correct me if I'm wrong:
>> file-exclusive-readwrite-lock means any other openers will fail and
>> if there are openers already the lock will fail. Which is what we want
>> no?
> 
> The filesystem ioctls and page faults have no visibility of file
> locks.  They don't know and can't find out in a sane manner that an
> inode has a single -user- reference.
> 

This is not true. The FS has full control. It is not too hard a work
to take a file-excl-lock from within the IOCTL implementation. then
unlock. that is option 1. Option 2 of the App taking the lock then
for the check we might need a new export from the lock-subsystem.

> And it introduces a new problem for any application using the
> fssetxattr() ioctl - accidentally not setting the S_DAX flag to be
> unmodified will now fail, and that means such a change breaks
> existing applications. Sure, you can say they are "buggy
> applications", but the fact is this user API change breaks them.
> 

I am not sure I completely understood. let me try ...

The app wants to set some foo flag. It can set the ignore mask to all
1(s) except the flag it wants to set/clear.
And/or get_current_flags(); modify foo_flag; set_flags().

Off course in both the ignore case or when the DAX bit does not change
we do not go on a locking rampage.

So I'm not sure I see the problem

> Hence I don't think we can change the user API for setting/clearing
> this flag like this.
> 

Yes we must not modify behavior of Apps that are modifing other flags.

> Cheers,
> Dave.
> 

Perhaps we always go by the directory. And then do an mv dir_DAX/foo dir_NODAX/foo
to have an effective change. In hard links the first one at iget time before populating
the inode cache takes affect. (And never change the flag on the fly)
(Just brain storming here)

Or perhaps another API?

Thanks Dave
Boaz
