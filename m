Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80E57A61CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 13:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjISL47 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 07:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISL46 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:56:58 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7C9F3;
        Tue, 19 Sep 2023 04:56:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c364fb8a4cso52192075ad.1;
        Tue, 19 Sep 2023 04:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695124612; x=1695729412; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mNmSIzeXuu0W8Adeux1YMe2sJA/HQO2+qwmQbYj25qQ=;
        b=A8TnOedAd2liDpmj9NosFRx313DZNy9q+YIBQqxVQUr3joW8snGWFaQpKGoMu5+coI
         mD4ckE8Pff4ucy8frxRYEoM3CgIhqaBIy4LlFqWyLekfCV0svNCGJ3kRxqe1dEdf6Qye
         RTGiEeUfyU1g+DxyBrIyPofEeQJdYrLX73K5Ma/eEbb4/07voca84XoB+UpVq3V2M9Bq
         sX68odfzmx0+Qw2A7jlJ+zY/4bzDpApWNtQ01vPyRfF6tL0AwQW7qzONeV+4Z6pFn3U6
         mdYREzBCLeS+ZJnnPxW5Ue5OOhoh6prUrPcSwl5cm4KSyV3Nk5LS/yVLecvjlPrcTiPc
         oofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695124612; x=1695729412;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNmSIzeXuu0W8Adeux1YMe2sJA/HQO2+qwmQbYj25qQ=;
        b=NBy2nT/jL0GB3oJnF6UNt68QdNAdMm9OqRvR5uxbsAmbBvY4oczMB9qWyfFjkMmEoD
         HfksW7RtIOQeLhXneTIDU393Ut1ryWf6IJsVEzj4Pjlfs2hOqJgJ0exGHlZXdAsbuwEL
         wLcECsD2tCMWT4WJr9lYJfy5TAbf5zYj3gjKyu9X56oTavnB40IAjpkGSKM4ZMaTtHCv
         tw2IMoF8qamMqokWXfIzEg6ZbuZdQ4gpO/dwpGpVsYB/J8uRvsPfqwhWLPGjqoSDITel
         7Ee1UlTc45obe/MO6cq7QiewnS7UCDm47Fmrtm7edXLyMtJXgNldQH3HHafUMKE6FLdt
         bW4g==
X-Gm-Message-State: AOJu0Yy7wC7ilF6CMTNUdIoLDGIHLzr7uYLlKDsmFGkIgqg/bN+Kbj/R
        ZeS2vYVHdKD6jb4Kzu656J8=
X-Google-Smtp-Source: AGHT+IGkeb0dGVTQ5tbZ8aAKLi7LkUBg6Enozcwq82i6LIXi74JZeDiB+v3dbMvqJRrINh4lA8ivHg==
X-Received: by 2002:a17:903:2301:b0:1b8:b285:ec96 with SMTP id d1-20020a170903230100b001b8b285ec96mr14864303plh.23.1695124612041;
        Tue, 19 Sep 2023 04:56:52 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id c21-20020a170902c1d500b001bb8895848bsm3746960plc.71.2023.09.19.04.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 04:56:50 -0700 (PDT)
Date:   Tue, 19 Sep 2023 17:26:44 +0530
Message-Id: <87a5ti74w3.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Dave Chinner <david@fromorbit.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Pankaj Raghav <kernel@pankajraghav.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, gost.dev@samsung.com,
        riteshh@linux.ibm.com
Subject: Re: [RFC 00/23] Enable block size > page size in XFS
In-Reply-To: <806df723-78cf-c7eb-66a6-1442c02126b3@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pankaj Raghav <p.raghav@samsung.com> writes:

>>>>
>>>> As it is, I'd really prefer stuff that adds significant XFS
>>>> functionality that we need to test to be based on a current Linus
>>>> TOT kernel so that we can test it without being impacted by all
>>>> the random unrelated breakages that regularly happen in linux-next
>>>> kernels....
>>>
>>> That's understandable! I just rebased onto Linus' tree, this only
>>> has the bs > ps support on 4k sector size:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=v6.6-rc2-lbs-nobdev
>> 
>
> I think this tree doesn't have some of the last minute changes I did before I sent the RFC. I will
> sync with Luis offline regarding that.
>
>> 
>>> I just did a cursory build / boot / fsx with 16k block size / 4k sector size
>>> test with this tree only. I havne't ran fstests on it.
>> 
>> W/ 64k block size, generic/042 fails (maybe just a test block size
>> thing), generic/091 fails (data corruption on read after ~70 ops)
>> and then generic/095 hung with a crash in iomap_readpage_iter()
>> during readahead.
>> 
>> Looks like a null folio was passed to ifs_alloc(), which implies the
>> iomap_readpage_ctx didn't have a folio attached to it. Something
>> isn't working properly in the readahead code, which would also
>> explain the quick fsx failure...
>> 
>
> Yeah, I have noticed this as well. This is the main crash scenario I am noticing
> when I am running xfstests, and hopefully we will be able to fix it soon.
>
> In general, we have had better results with 16k block size than 64k block size. I still don't
> know why, but the ifs_alloc crash happens in generic/451 with 16k block size.
>
>
>>> Just a heads up, using 512 byte sector size will fail for now, it's a
>>> regression we have to fix. Likewise using block sizes 1k, 2k will also
>>> regress on fsx right now. These are regressions we are aware of but
>>> haven't had time yet to bisect / fix.
>> 
>> I'm betting that the recently added sub-folio dirty tracking code
>> got broken by this patchset....
>> 
>
> Hmm, this crossed my mind as well. I am assuming I can really test the sub-folio dirty
> tracking code on a system which has a page size greater than the block size? Or is there
> some tests that can already test this? CCing Ritesh as well.
>

Sorry I haven't yet looked into this series yet. I will spend sometime
reading it. Will also give a spin to run the fstests.

But to answer your question on how to test sub-folio dirty
tracking code[1] [2] with XFS. Just use blocksize < pagesize in mkfs option
and run fstests. There are a no. of tests which checks for data
correctness for various types of writes.

1. test 1k blocksize on a 4k pagsize machine (as long as bs < ps)
2. Test 4k blocksize on a 64k pagesize machine (if you have one) (as long as bs < ps)
3. Or also enable large folios support and test bs < ps
(with large folios system starts insantiating large folios > 4k on a 4k
pagesize machine. So blocksize automatically becomes lesser than folio size)

You will need CONFIG_TRANSPARENT_HUGEPAGE to be enabled along with
willy's series which enables large folios in buffered write path [3].
(This is already in linux 6.6-rc1)

<snip>
/*                                                                            
 * Large folio support currently depends on THP.  These dependencies are      
 * being worked on but are not yet fixed.                                     
 */                                                                           
static inline bool mapping_large_folio_support(struct address_space *mapping) 
{                                                                             
        return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&                     
                test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
}

<links>
[1]: https://lore.kernel.org/linux-xfs/20230725122932.144426-1-ritesh.list@gmail.com/
[2]:
https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=for-next&id=4ce02c67972211be488408c275c8fbf19faf29b3
[3]: https://lore.kernel.org/all/ZLVrEkVU2YCneoXR@casper.infradead.org/

Hope this helps!

-ritesh
