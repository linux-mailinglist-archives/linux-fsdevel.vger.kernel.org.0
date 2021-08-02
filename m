Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5CE3DDA64
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 16:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbhHBONq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 10:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239161AbhHBOL5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:11:57 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D257EC028BFE
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Aug 2021 06:53:43 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id c9so16554135qkc.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Aug 2021 06:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7YZ+YWuu0r8ls2F/ASXAfqcelR3faj3UC8eZqkF+Zko=;
        b=pi2O34Gbu2DJiPT2DXuDG4QdH2iMvOdf7tSszje2qigN/T8dFHQH1pZvveTmPZn6j+
         n+3K6aI91XYsSTxYK5jB8LHLswOYhOtyzb1/xWaQKFKzEy3YX52WVV2Dqhsu07r6IDBy
         /Msf3u0R5zINNltrJUS4FpJrqYDP/afbpxcJpNpJXUIUeChB3cG/u39CTUTc6tYtV8MR
         m9IixiU2rlsVICCdlryAlPFb6PkwD//xhAm4KiY3GiDBnyp1U/RkfoGK9NZkWcfIxAVy
         CpJ7xSMq8XqGrE/t7mnlmMpciZNikmfd2pCBtxlfO7JcrlZYbk6z+N+tEp+CIhBteKHm
         2tGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7YZ+YWuu0r8ls2F/ASXAfqcelR3faj3UC8eZqkF+Zko=;
        b=OAxM6IFG46/EdaPYFvNjgAOy1qY9WJY1zd0+fwL/4jEoj3Nnx9hH6yFL7JVUO5WBy5
         m0g143b+7SoLMk/L54sCnftb0UtvO2KFxRoD61tKtAzrKJHta6AQAYwYxDG98dtV96oO
         X5Kntluf+jZ7aarRGxKkjDl9VbO4Z8b3/ZjPkdxOEG942mrhPtMGIgKclHc6bV8xpqCG
         TuAj5ofEUgw4J5uq2ZdW9Q/eV2TLLGOQTM1CULZy392M/sInXv0+KuCkRMleYLNZlIcI
         JMaeLpPu2OW2/QcvJpx0obQGbf7ab1R9Cc4q6tKJyKXyLz2wXsNc7RPBMeqmePZVkgtH
         s0lw==
X-Gm-Message-State: AOAM533hnRk4vZFJXhoZZR4AZ3H+TTOh1UT2vWR0f4STOBtCDOQNfDb7
        7a1qGnsEWzINJ89j6d7wGYVTmw==
X-Google-Smtp-Source: ABdhPJydpVHsw4eOuMz3Y7rq9l4GuTxSALmGUmQoE814YRrjc3UCGWfVQPb8BvvAzRQHbeEJTDf+tA==
X-Received: by 2002:a05:620a:233:: with SMTP id u19mr15753757qkm.48.1627912422875;
        Mon, 02 Aug 2021 06:53:42 -0700 (PDT)
Received: from [192.168.1.110] (38-132-189-23.dynamic-broadband.skybest.com. [38.132.189.23])
        by smtp.gmail.com with ESMTPSA id a127sm6015928qkc.121.2021.08.02.06.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 06:53:42 -0700 (PDT)
Subject: Re: A Third perspective on BTRFS nfsd subvol dev/inode number issues.
To:     Amir Goldstein <amir73il@gmail.com>, NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162742546548.32498.10889023150565429936.stgit@noble.brown>
 <YQNG+ivSssWNmY9O@zeniv-ca.linux.org.uk>
 <162762290067.21659.4783063641244045179@noble.neil.brown.name>
 <CAJfpegsR1qvWAKNmdjLfOewUeQy-b6YBK4pcHf7JBExAqqUvvg@mail.gmail.com>
 <162762562934.21659.18227858730706293633@noble.neil.brown.name>
 <CAJfpegtu3NKW9m2jepRrXe4UTuD6_3k0Y6TcCBLSQH7SSC90BA@mail.gmail.com>
 <162763043341.21659.15645923585962859662@noble.neil.brown.name>
 <CAJfpegub4oBZCBXFQqc8J-zUiSW+KaYZLjZaeVm_cGzNVpxj+A@mail.gmail.com>
 <162787790940.32159.14588617595952736785@noble.neil.brown.name>
 <YQeB3ASDyO0wSgL4@zeniv-ca.linux.org.uk>
 <162788285645.32159.12666247391785546590@noble.neil.brown.name>
 <CAOQ4uxgnGWMUvtyJ0MMxMzHFwiyR68FHorDNmLSva0CdpVNNcQ@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2337f1ba-ffed-2369-47a0-5ffda2d8b51c@toxicpanda.com>
Date:   Mon, 2 Aug 2021 09:53:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxgnGWMUvtyJ0MMxMzHFwiyR68FHorDNmLSva0CdpVNNcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/2/21 3:54 AM, Amir Goldstein wrote:
> On Mon, Aug 2, 2021 at 8:41 AM NeilBrown <neilb@suse.de> wrote:
>>
>> On Mon, 02 Aug 2021, Al Viro wrote:
>>> On Mon, Aug 02, 2021 at 02:18:29PM +1000, NeilBrown wrote:
>>>
>>>> It think we need to bite-the-bullet and decide that 64bits is not
>>>> enough, and in fact no number of bits will ever be enough.  overlayfs
>>>> makes this clear.
>>>
>>> Sure - let's go for broke and use XML.  Oh, wait - it's 8 months too
>>> early...
>>>
>>>> So I think we need to strongly encourage user-space to start using
>>>> name_to_handle_at() whenever there is a need to test if two things are
>>>> the same.
>>>
>>> ... and forgetting the inconvenient facts, such as that two different
>>> fhandles may correspond to the same object.
>>
>> Can they?  They certainly can if the "connectable" flag is passed.
>> name_to_handle_at() cannot set that flag.
>> nfsd can, so using name_to_handle_at() on an NFS filesystem isn't quite
>> perfect.  However it is the best that can be done over NFS.
>>
>> Or is there some other situation where two different filehandles can be
>> reported for the same inode?
>>
>> Do you have a better suggestion?
>>
> 
> Neil,
> 
> I think the plan of "changing the world" is not very realistic.
> Sure, *some* tools can be changed, but all of them?
> 
> I went back to read your initial cover letter to understand the
> problem and what I mostly found there was that the view of
> /proc/x/mountinfo was hiding information that is important for
> some tools to understand what is going on with btrfs subvols.
> 
> Well I am not a UNIX history expert, but I suppose that
> /proc/PID/mountinfo was created because /proc/mounts and
> /proc/PID/mounts no longer provided tool with all the information
> about Linux mounts.
> 
> Maybe it's time for a new interface to query the more advanced
> sb/mount topology? fsinfo() maybe? With mount2 compatible API for
> traversing mounts that is not limited to reporting all entries inside
> a single page. I suppose we could go for some hierarchical view
> under /proc/PID/mounttree. I don't know - new API is hard.
> 
> In any case, instead of changing st_dev and st_ino or changing the
> world to work with file handles, why not add inode generation (and
> maybe subvol id) to statx().
> filesystem that care enough will provide this information and tools that
> care enough will use it.
> 

Can y'all wait till I'm back from vacation, goddamn ;)

This is what I'm aiming for, I spent some time looking at how many 
places we string parse /proc/<whatever>/mounts and my head hurts.

Btrfs already has a reasonable solution for this, we have UUID's for 
everything.  UUID's aren't a strictly btrfs thing either, all the file 
systems have some sort of UUID identifier, hell its built into blkid.  I 
would love if we could do a better job about letting applications query 
information about where they are.  And we could expose this with the 
relatively common UUID format.  You ask what fs you're in, you get the 
FS UUID, and then if you're on Btrfs you get the specific subvolume UUID 
you're in.  That way you could do more fancy things like know if you've 
wandered into a new file system completely or just a different subvolume.

We have to keep the st_ino/st_dev thing for backwards compatibility, but 
make it easier to get more info out of the file system.

We could in theory expose just the subvolid also, since that's a nice 
simple u64, but it limits our ability to do new fancy shit in the 
future.  It's not a bad solution, but like I said I think we need to 
take a step back and figure out what problem we're specifically trying 
to solve, and work from there.  Starting from automounts and working our 
way back is not going very well.  Thanks,

Josef
