Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3955A631B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 14:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiH3MRw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 08:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiH3MRu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:17:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC56B029E
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 05:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661861868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wStWHojG+mqSkx5w9odtf8yhDsAk+/Zs+ge/ktP/P14=;
        b=gUknbzr40ySmQrJTnRyYtFl6KXzqRHlIMia/kSNPkvEUmGrJz6wz/3aek16LVQmUKBSYG8
        9bMjt4ksHrjp3Hlv1nr3lgrq+zs4YIzC4B6TlcYPkokZUDRnrG3L2FAREKYNpI5HGOgu9i
        5joC+JnkEWt6mBt38dvX+R1LmeSyoLc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-507-b9vnlNxYP5W0aei5o2rZfg-1; Tue, 30 Aug 2022 08:17:47 -0400
X-MC-Unique: b9vnlNxYP5W0aei5o2rZfg-1
Received: by mail-wm1-f70.google.com with SMTP id x16-20020a1c7c10000000b003a5cefa5578so1925505wmc.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 05:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=wStWHojG+mqSkx5w9odtf8yhDsAk+/Zs+ge/ktP/P14=;
        b=TtKIKelnVN68OsnrOsV3eiGMw1qLx9G5TjpuWB77jmotFSFOyuW+lqhVXTFR6ChB2Y
         gTY0h3yFuQDQWiflB+yfKFZz86leuFFAA95owIeP6/ygYU+Wdlw6VWftdSe8xpH8yIRf
         hEYDOyc+vN16b0Q2BxXyNZHi73eRj9fV/sts/xuldSMUch5PP5EC6rufHQQvno9Kgxru
         0Fa/n1yiGW0zKGjyXx3U1Isi1ltyFnNZHXqlWrQgvT5qOuPITxCjq4n9mgeohuenERrw
         VBEOt+W57OY9nBFKm4MuKRNGvye4d7kQfVPQQ0Kqa29WQXjl9xhpoZAwj8yRMr6NGn2o
         Micg==
X-Gm-Message-State: ACgBeo0lxZx3h6Q3M07ChXJMTICI/cR0qjEwvFIfjS8CLy0P8cZLRHuk
        Q7yq/Tpu3wAGukHVUFtHgesqDW/K6MM/j3GtrTyHg552eeta+01SjbMrJHf1Goe/gor9xkm/8BZ
        X8YQPog0Hac0jWGQduYJlgohhKA==
X-Received: by 2002:adf:ed50:0:b0:225:4c37:5346 with SMTP id u16-20020adfed50000000b002254c375346mr8810773wro.207.1661861866322;
        Tue, 30 Aug 2022 05:17:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7LbEwWL4kKOvLdx0sOtNkvmwSMVrgmd2sgfE/jJVeFo0Jfzf2IRVyzOcC+QvzNNPwpyxNgIQ==
X-Received: by 2002:adf:ed50:0:b0:225:4c37:5346 with SMTP id u16-20020adfed50000000b002254c375346mr8810749wro.207.1661861865960;
        Tue, 30 Aug 2022 05:17:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:1000:ecb4:919b:e3d3:e20b? (p200300cbc70a1000ecb4919be3d3e20b.dip0.t-ipconnect.de. [2003:cb:c70a:1000:ecb4:919b:e3d3:e20b])
        by smtp.gmail.com with ESMTPSA id z20-20020a05600c0a1400b003a5e9337967sm12853676wmp.13.2022.08.30.05.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 05:17:45 -0700 (PDT)
Message-ID: <5aa08b4f-251e-a63d-c36c-324a04ba24f4@redhat.com>
Date:   Tue, 30 Aug 2022 14:17:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
 <20220827083607.2345453-2-jhubbard@nvidia.com>
 <10a9d33a-58a3-10b3-690b-53100d4e5440@redhat.com>
 <a47eef63-0f29-2185-f044-854ffaefae9c@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/6] mm/gup: introduce pin_user_page()
In-Reply-To: <a47eef63-0f29-2185-f044-854ffaefae9c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29.08.22 21:33, John Hubbard wrote:
> On 8/29/22 05:07, David Hildenbrand wrote:
>>> +/**
>>> + * pin_user_page() - apply a FOLL_PIN reference to a page
>>> + *
>>> + * @page: the page to be pinned.
>>> + *
>>> + * This is similar to get_user_pages(), except that the page's refcount is
>>> + * elevated using FOLL_PIN, instead of FOLL_GET.
> 
> Actually, my commit log has a more useful documentation of this routine,
> and given the questions below, I think I'll change to that:
> 
>  * pin_user_page() is an externally-usable version of try_grab_page(), but with
>  * semantics that match get_page(), so that it can act as a drop-in replacement
>  * for get_page().
>  *
>  * pin_user_page() elevates a page's refcount using FOLL_PIN rules. This means
>  * that the caller must release the page via unpin_user_page().

Some thoughts:

a) Can we generalize such that pages with a dedicated pincount
(multi-page folios) are also covered? Maybe avoiding the refcount
terminology would be best.

b) Should we directly work on folios?

c) Would it be valid to pass in a tail page right now?

> 
>>> + *
>>> + * IMPORTANT: The caller must release the page via unpin_user_page().
>>> + *
>>> + */
>>> +void pin_user_page(struct page *page)
>>> +{
>>> +	struct folio *folio = page_folio(page);
>>> +
>>> +	WARN_ON_ONCE(folio_ref_count(folio) <= 0);
>>> +
>>
>> We should warn if the page is anon and !exclusive.
> 
> That would be sort of OK, because pin_user_page() is being created
> specifically for file system (O_DIRECT cases) use, and so the pages
> should mostly be file-backed, rather than anon. Although I'm a little
> vague about whether all of these iov_iter cases are really always
> file-backed pages, especially for cases such as splice(2) to an
> O_DIRECT-opened file, that Al Viro mentioned [1].

If we can, we should document that this interface is not for anonymous
pages and WARN if pinning an anonymous page via this interface.

The only reasonable way to obtain a pin on an anonymous page is via the
page table. Here, FOLL_PIN should be used to do the right thing -- for
example, unshare first (break COW) instead of pinning a shared anonymous
page.

Nothing would speak against duplicating such a pin using this interface
(we'd have to sanity check that the page we're pinning may already be
pinned), but I assume the pages we pin here are *not* necessarily
obtained via GUP FOLL_PIN.

I would be curious under which scenarios we could end up here with an
anonymous page and how we obtained that reference (if not via GUP).

> 
> Can you walk me through the reasoning for why we need to keep out
> anon shared pages? 

We make sure to only pin anonymous pages that are exclusive and check
when unpinning -- see sanity_check_pinned_pages(), there is also a
comment in there -- that pinned anonymous pages are in fact still
exclusive, otherwise we might have a BUG lurking somewhere that can
result in memory corruptions or leaking information between processes.

For example, once we'd pinned an anonymous pages that are not marked
exclusive (!PageAnonExclusive), or we'd be sharing a page that is
pinned, the next write fault would replace the page in the user page
table due to breaking COW, and the GUP pin would point at a different
page than the page table.

Disallowing pinning of anon pages that may be shared in any case
(FOLL_LONGTERM or not) simplifies GUP handling and allows for such
sanity checks.

(side note: after recent VM_BUG_ON discussions we might want to convert
the VM_BUG_ON_PAGE in sanity_check_pinned_pages())

> 
>>
>> I assume the intend is to use pin_user_page() only to duplicate pins, right?
>>
> 
> Well, yes or no, depending on your use of the term "pin":
> 
> pin_user_page() is used on a page that already has a refcount >= 1 (so
> no worries about speculative pinning should apply here), but the page
> does not necessarily have any FOLL_PIN's applied to it yet (so it's not
> "pinned" in the FOLL_PIN sense).

Okay, then we should really figure out if/how anonymous pages could end
up here. I assume they can't, really. But let's see :)


-- 
Thanks,

David / dhildenb

