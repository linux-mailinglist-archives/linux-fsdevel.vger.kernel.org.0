Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0BFC19A579
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 08:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbgDAGif (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 02:38:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42295 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731908AbgDAGif (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 02:38:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15so29084188wrx.9;
        Tue, 31 Mar 2020 23:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u7qzTLhWhtQ+4ksRWWT0iCnZlieYp50htwnA74AfNuM=;
        b=OdpjtdE14ZEsiCtuHCsfDHAkoRhqvtvfrGsCgG++nLESkSz0pcq2UBrEBNvCDzprCW
         dmlM5gX1y8Tm6so4QYNvJmgQxl3z7RiT4ERWXhbMt46VZ0HaDP5zjTWSlThjaN3AVYJD
         DLNDK0Edvewv5ebCdiVAjZw1ss/EuqaraqE+NxMTHj1yT9MX+1Tj4ohJJka60rVTXzT+
         2LKRvDXPbAIVQXIBNLIot8sUyFkzLN/ftPkCQmqB2+BrX0gStl/vL0RHYiSa0cqybaTD
         AfcJbgvKu+q5FcuzK/5JwW49GG2okf3SrMEAtUdlqE9EdRPsKvUt9/mhLJeNRbgpHyKu
         U8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u7qzTLhWhtQ+4ksRWWT0iCnZlieYp50htwnA74AfNuM=;
        b=Y9PheYqlpUj93vrIU9jnEq68nozznGYvvMJxFQ9oJmdXl/5Ki3gbaUYBCql8uKQtfo
         /x8J1MYVsAow56tWFTiHusVkMPPIqYzSzJvsxAmAnNNganoVE98ICYDSWXrS4/945Tp7
         i0kyw39q5pvbi6feISYRQeIILZmsagC9/YLNMb38z65VJapBz/0UznxNRnzV5rq6VmBL
         0Glsy94TwWbrwfCIrqRNd+O7IvHB5Tix5GtXE5JWvkNHRLbS1uifwzlu9+CC4p2gxXm7
         gIRi2aJzuYom2BeguzvucOHiB1vNiQ3Y4Lzn9B6no7Gn3CVa4Ti5I5iCJOu/Plwzwevc
         am4w==
X-Gm-Message-State: ANhLgQ0A8tqn6p/isqLipPfRDzyx7b0/ClMfqhb5UB5dHqQxQ8RjweLq
        KcEcBHGcYLYy4LBDEAkE50DikcRd
X-Google-Smtp-Source: ADFU+vsGt7fHvFHWI6/jEJLu+44G71UgYE2sbgFQAduQzIv8MVFyAupGe9DXvtjw75oECDTe2yQIrg==
X-Received: by 2002:adf:e44a:: with SMTP id t10mr24060598wrm.322.1585723113198;
        Tue, 31 Mar 2020 23:38:33 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id b67sm1346031wmh.29.2020.03.31.23.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 23:38:32 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH man-pages v2 2/2] openat2.2: document new openat2(2)
 syscall
To:     Aleksa Sarai <cyphar@cyphar.com>
References: <20200202151907.23587-1-cyphar@cyphar.com>
 <20200202151907.23587-3-cyphar@cyphar.com>
 <1567baea-5476-6d21-4f03-142def0f62e3@gmail.com>
 <20200331143911.lokfoq3lqfri2mgy@yavin.dot.cyphar.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <cd3a6aad-b906-ee57-1b5b-5939b9602ad0@gmail.com>
Date:   Wed, 1 Apr 2020 08:38:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331143911.lokfoq3lqfri2mgy@yavin.dot.cyphar.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Aleksa,

On 3/31/20 4:39 PM, Aleksa Sarai wrote:
> On 2020-03-30, Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
>> Hello Aleksa,
>>
>> On 2/2/20 4:19 PM, Aleksa Sarai wrote:
>>> Rather than trying to merge the new syscall documentation into open.2
>>> (which would probably result in the man-page being incomprehensible),
>>> instead the new syscall gets its own dedicated page with links between
>>> open(2) and openat2(2) to avoid duplicating information such as the list
>>> of O_* flags or common errors.
>>>
>>> In addition to describing all of the key flags, information about the
>>> extensibility design is provided so that users can better understand why
>>> they need to pass sizeof(struct open_how) and how their programs will
>>> work across kernels. After some discussions with David Laight, I also
>>> included explicit instructions to zero the structure to avoid issues
>>> when recompiling with new headers.
>>>
>>> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
>>
>> Thanks. I've applied this patch, but also done quite a lot of
>> editing of the page. The current draft is below (and also pushed 
>> to Git). Could I ask you to review the page, to see if I injected
>> any error during my edits.
> 
> Looks good to me.
> 
>> In addition, I've added a number of FIXMEs in comments
>> in the page source. Can you please check these, and let me
>> know your thoughts.
> 
> Will do, see below.
> 
>> .\" FIXME I find the "previously-functional systems" in the previous
>> .\" sentence a little odd (since openat2() ia new sysycall), so I would
>> .\" like to clarify a little...
>> .\" Are you referring to the scenario where someone might take an
>> .\" existing application that uses openat() and replaces the uses
>> .\" of openat() with openat2()? In which case, is it correct to
>> .\" understand that you mean that one should not just indiscriminately
>> .\" add the RESOLVE_NO_XDEV flag to all of the openat2() calls?
>> .\" If I'm not on the right track, could you point me in the right
>> .\" direction please.
> 
> This is mostly meant as a warning to hopefully avoid applications
> because the developer didn't realise that system paths may contain
> symlinks or bind-mounts. For an application which has switched to
> openat2() and then uses RESOLVE_NO_SYMLINKS for a non-security reason,
> it's possible that on some distributions (or future versions of a
> distribution) that their application will stop working because a system
> path suddenly contains a symlink or is a bind-mount.
> 
> This was a concern which was brought up on LWN some time ago. If you can
> think of a phrasing that makes this more clear, I'd appreciate it.

Thanks. I've made the text:

                     Applications  that  employ  the RESOLVE_NO_XDEV flag
                     are encouraged to make its use configurable  (unless
                     it is used for a specific security purpose), as bind
                     mounts are widely used by end-users.   Setting  this
                     flag indiscriminately—i.e., for purposes not specif‐
                     ically related to security—for all uses of openat2()
                     may  result  in  spurious errors on previously-func‐
                     tional systems.  This may occur if, for  example,  a
                     system  pathname  that  is used by an application is
                     modified (e.g., in a new  distribution  release)  so
                     that  a  pathname  component  (now)  contains a bind
                     mount.

Okay?

>> .\" FIXME: what specific details in symlink(7) are being referred
>> .\" by the following sentence? It's not clear.
> 
> The section on magic-links, but you're right that the sentence ordering
> is a bit odd. It should probably go after the first sentence.

I must admit that I'm still confused. There's only the briefest of 
mentions of magic links in symlink(7). Perhaps that needs to be fixed?

And, while I think of it, the text just preceding that FIXME says:

    Due to the potential danger of unknowingly opening 
    these magic links, it may be preferable for users to 
    disable their resolution entirely.

This sentence reads a little strangely. Could you please give me some
concrete examples, and I will try rewording that sentence a bit.

>> .\" FIXME I found the following hard to understand (in particular, the
>> .\" meaning of "scoped" is unclear) , and reworded as below. Is it okay?
>> .\"     Absolute symbolic links and ".." path components will be scoped to
>> .\"     .IR dirfd .
> 
> Scoped does broadly mean "interpreted relative to", though the
> difference is mainly that when I said scoped it's meant to be more of an
> assertive claim ("the kernel promises to always treat this path inside
> dirfd"). But "interpreted relative to" is a clearer way of phrasing the
> semantics, so I'm okay with this change.

Okay.

>> .\" FIXME The next piece is unclear (to me). What kind of ".." escape
>> .\" attempts does chroot() not detect that RESOLVE_IN_ROOT does?
> 
> If the root is moved, you can escape from a chroot(2). But this sentence
> might not really belong in a man-page since it's describing (important)
> aspects of the implementation and not the semantics.

So, should I just remove the sentence?

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
