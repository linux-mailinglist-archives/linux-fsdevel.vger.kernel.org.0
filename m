Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3836D5FABC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 06:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJKEwo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 00:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJKEwn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 00:52:43 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09886816A6;
        Mon, 10 Oct 2022 21:52:43 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l4so12159275plb.8;
        Mon, 10 Oct 2022 21:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WNv6dmEDsfqY3IJFUZvXFDkquvz0dHXYyh64YUy9V5o=;
        b=VBbYwNlppUouuzxbxec+mNe1/UzSO/Urr6Bo76IlfIG6gwqZB+oLgdCZWhsylm7vG4
         lAik53jrAi+6YvgSUTy+5VgL7sqpuyICbX4ya2dTXb98RZAjHWti2kLTCniNHVB9cQ1P
         ZG67lpdp4IDgQKZ8toA5j4zzKl7UJL6ITwrgTiAoQZLouOwcQRo0TsB0b+BgqJvLKxxR
         shxLe1Tgds4w6jgohDtqJfi37C55mJj94/VJbtdTkhrMnTXoqab3W/nWgpvyOTlFB2cK
         biV1RLW8u/Vubr+6Xo8H+d3qZXUAl6nN9wBtJKW45ybZpWMFcIUpIJ9ofaV56a6JyrPZ
         zA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNv6dmEDsfqY3IJFUZvXFDkquvz0dHXYyh64YUy9V5o=;
        b=lLg05AGgHWiGqai1cUK0BAAifVtLAkresGgDRDMAFoLwuo2Kt6Vwd5S+/Q5g6wPhqF
         BvsErjq+eaoqWQGyrIkGhbdQddHb+DMNPTxTXPXGnb03MK8Yu9tbMLJFArjOHglkM5T0
         Zo5wPaI4G9B8Ppom4KhqP+ErWTFyA9c0inNcPxeW9gCDi9QmgZnXhB1moC0cumhpBFw+
         Ln5YdPK6ndX8CyfVRng2Ab0mTS8T74bYItrECi+I2skBZD1EJpg/FfYo3k+y6sZhXhNg
         1zWFlVNt2FxUIUWMOdjFw5MzD4/Piq0FPg944vpkfZMOlrlCCz0fEzysZh5Ph0cBJMm/
         jw4g==
X-Gm-Message-State: ACrzQf3qOjVAdarK2r5QRXWYHQczev3vQkqBYaDCQWyCJocmvSiAcfxw
        xrY3LGJy4wi5J2Aguc8RRUs=
X-Google-Smtp-Source: AMsMyM6eauOT46tQiVEPvy6v2R+dmR5OnAyhGYeE2s9LNDRJMqc5WzlXMgydOstrvymxDfsq9BNmzw==
X-Received: by 2002:a17:90b:4a84:b0:20a:f497:6f5d with SMTP id lp4-20020a17090b4a8400b0020af4976f5dmr24343049pjb.213.1665463962204;
        Mon, 10 Oct 2022 21:52:42 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a0cc300b002008d0e5cb5sm9834215pjt.47.2022.10.10.21.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 21:52:41 -0700 (PDT)
Date:   Mon, 10 Oct 2022 21:52:39 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Danylo Mocherniuk <mdanylo@google.com>
Subject: Re: [PATCH v3 0/4] Implement IOCTL to get and clear soft dirty PTE
Message-ID: <Y0T2l3HaH2MU8M9m@gmail.com>
References: <20220826064535.1941190-1-usama.anjum@collabora.com>
 <YyiDg79flhWoMDZB@gmail.com>
 <2c8b7116-56e9-3202-c47e-e42078c85793@collabora.com>
 <CANaxB-xDiTRCuWxBmrSH1u3e_ADbxCoQKmEoSsYfm4yW7k=v4A@mail.gmail.com>
 <2e1c33c8-a201-0f7f-17cf-22fec555c7ff@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <2e1c33c8-a201-0f7f-17cf-22fec555c7ff@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 03, 2022 at 04:21:22PM +0500, Muhammad Usama Anjum wrote:
> On 9/28/22 10:24 PM, Andrei Vagin wrote:
> > On Wed, Sep 21, 2022 at 11:26 AM Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >>
> >> Hi,
> >>
> >> Thank you for reviewing.
> >>
> >> On 9/19/22 7:58 PM, Andrei Vagin wrote:
> >>>> This ioctl can be used by the CRIU project and other applications which
> >>>> require soft-dirty PTE bit information. The following operations are
> >>>> supported in this ioctl:
> >>>> - Get the pages that are soft-dirty.
> >>>
> >>> I think this interface doesn't have to be limited by the soft-dirty
> >>> bits only. For example, CRIU needs to know whether file, present and swap bits
> >>> are set or not.
> >> These operations can be performed by pagemap procfs file. Definitely
> >> performing them through IOCTL will be faster. But I'm trying to add a
> >> simple IOCTL by which some specific PTE bit can be read and cleared
> >> atomically. This IOCTL can be extended to include other bits like file,
> >> present and swap bits by keeping the interface simple. The following
> >> mask advice is nice. But if we add that kind of masking, it'll start to
> >> look like a filter on top of pagemap. My intention is to not duplicate
> >> the functionality already provided by the pagemap. One may ask, then why
> >> am I adding "get the soft-dirty pages" functionality? I'm adding it to
> >> complement the get and clear operation. The "get" and "get and clear"
> >> operations with special flag (PAGEMAP_SD_NO_REUSED_REGIONS) can give
> >> results quicker by not splitting the VMAs.
> > 
> > This simple interface is good only for a limited number of use-cases.
> > The interface
> > that I suggest doesn't duplicate more code than this one, but it is much more
> > universal. It will be a big mess if you add a separate API for each
> > specific use-case.
> >
> >
> >>> I mean we should be able to specify for what pages we need to get info
> >>> for. An ioctl argument can have these four fields:
> >>> * required bits (rmask & mask == mask) - all bits from this mask have to be set.
> >>> * any of these bits (amask & mask != 0) - any of these bits is set.
> >>> * exclude masks (emask & mask == 0) = none of these bits are set.
> >>> * return mask - bits that have to be reported to user.
> The required mask (rmask) makes sense to me. At the moment, I only know
> about the practical use case for the required mask. Can you share how
> can any and exclude masks help for the CRIU?
> 

I looked at should_dump_page in the CRIU code:
https://github.com/checkpoint-restore/criu/blob/45641ab26d7bb78706a6215fdef8f9133abf8d10/criu/mem.c#L102

When CRIU dumps file private mappings, it needs to get pages that have
PME_PRESENT or PME_SWAP but don't have PME_FILE.

> >>>> - Clear the pages which are soft-dirty.
> >>>> - The optional flag to ignore the VM_SOFTDIRTY and only track per page
> >>>> soft-dirty PTE bit
> >>>>
> >>>> There are two decisions which have been taken about how to get the output
> >>>> from the syscall.
> >>>> - Return offsets of the pages from the start in the vec
> >>>
> >>> We can conside to return regions that contains pages with the same set
> >>> of bits.
> >>>
> >>> struct page_region {
> >>>       void *start;
> >>>       long size;
> >>>       u64 bitmap;
> >>> }
> >>>
> >>> And ioctl returns arrays of page_region-s. I believe it will be more
> >>> compact form for many cases.
> >> Thank you for mentioning this. I'd considered this while development.
> >> But I gave up and used the simple array to return the offsets of the
> >> pages as in the problem I'm trying to solve, the dirty pages may be
> >> present amid non-dirty pages. The range may not be useful in that case.
> > 
> > This is a good example. If we expect more than two consequent pages
> > on average, the "region" interface looks more prefered. I don't know your
> > use-case, but in the case of CRIU, this assumption looks reasonable.
> > 
> >> Also we want to return only a specific number of pages of interest. The
> >> following paragraph explains it.
> >>
> >>>
> >>>> - Stop execution when vec is filled with dirty pages
> >>>> These two arguments doesn't follow the mincore() philosophy where the
> >>>> output array corresponds to the address range in one to one fashion, hence
> >>>> the output buffer length isn't passed and only a flag is set if the page
> >>>> is present. This makes mincore() easy to use with less control. We are
> >>>> passing the size of the output array and putting return data consecutively
> >>>> which is offset of dirty pages from the start. The user can convert these
> >>>> offsets back into the dirty page addresses easily. Suppose, the user want
> >>>> to get first 10 dirty pages from a total memory of 100 pages. He'll
> >>>> allocate output buffer of size 10 and the ioctl will abort after finding the
> >>>> 10 pages. This behaviour is needed to support Windows' getWriteWatch(). The
> >>>> behaviour like mincore() can be achieved by passing output buffer of 100
> >>>> size. This interface can be used for any desired behaviour.
> > 
> > Now, it is more clear where this interface came from. It repeats the
> > interface of Windows' getWriteWatch. I think we have to look wider.
> > The interface that reports regions will be more efficient for many
> > use-cases. As for getWriteWatch, it will require a bit more code in
> > user-space, but this code is trivial.

I added Danylo to CC. I think he has a good use-case for the new
interface. Danylo, could you describe it here.

> > 
> > Thanks,
> > Andrei
> 
> -- 
> Muhammad Usama Anjum
