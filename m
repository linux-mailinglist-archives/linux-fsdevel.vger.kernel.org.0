Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79DA7B43FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 23:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjI3V4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 17:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbjI3V4L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 17:56:11 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77067DD
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Sep 2023 14:56:06 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3af603da0d1so2679580b6e.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Sep 2023 14:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696110966; x=1696715766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1icVX1vipL46lW3iEjwQH9ZT3scIXW/xZq3Wbk91zeo=;
        b=JYew/IExMjJKEYDEvN9Yaa1UvLBJPPEURCiC28qWIXyo0dZ1avIUfTem2PcEyhW+Wn
         ss67Rx0IjvdnMbgnz/Ns4RUHaVbeLFcqnRwszby1qwnG4+k44CvTSga/nOl7mjn4BD7S
         Jw1RUpKtLy/ZlfralpzlKC9NZcwhDo9WHLcJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696110966; x=1696715766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1icVX1vipL46lW3iEjwQH9ZT3scIXW/xZq3Wbk91zeo=;
        b=YPhPTJijZusFsHZxDoqldDXN8Z4AoGlHGC3RT/ayNj/pVRlijpZmojTeLlUaxpXDIc
         V5ezN1Mz68l6mp/uRGVOJThMgwlj+B0rcJo4Z8L6CZvegNHDrbdn1nh379x6Ecu0TIrx
         wvcJ8q/ca10fEBru+ce5BrmmrDHjlceheH+5MA0v+4co9rgp+s83WZjamYF202N5tCHN
         /3ewOzZ4Yd33ompKx6ZDKYXRZwfS7FuTqlBkrnD9eFHB8YZSu4tf4Fz/ZA2RppUJ75a7
         KYS8TitNF3CVVEnYCZVnN74ekn3juzrDGFVJr0RQn0u4yxyNjq2/Iz//m78CQAlLTrSV
         Gk8w==
X-Gm-Message-State: AOJu0YzH2M19je1tzV5p6K6UrALxLOmqajpNr4w5PK+0IU4nDD2ha2na
        fgbH+HtUbkktcycCTrmHZJktXg==
X-Google-Smtp-Source: AGHT+IFkI3tRr+/6289gTcMVtjTAWDXeyklSe2Qt3xiCvsM7nQGjkWpzKBhDTJj9OyNhzL6HMfwCSQ==
X-Received: by 2002:a05:6808:645:b0:3ab:929e:c5e1 with SMTP id z5-20020a056808064500b003ab929ec5e1mr8085723oih.39.1696110965716;
        Sat, 30 Sep 2023 14:56:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902e54500b001b8c6890623sm19257993plf.7.2023.09.30.14.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 14:56:04 -0700 (PDT)
Date:   Sat, 30 Sep 2023 14:56:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Brian Foster <bfoster@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [linux-next:master] BUILD REGRESSION
 df964ce9ef9fea10cf131bf6bad8658fde7956f6
Message-ID: <202309301403.82201B0A@keescook>
References: <202309301308.d22sJdaF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309301308.d22sJdaF-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kent,

Andrew pointed this out to me, and it's a FORTIFY issue under a W=1 build:

On Sat, Sep 30, 2023 at 01:25:34PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> branch HEAD: df964ce9ef9fea10cf131bf6bad8658fde7956f6  Add linux-next specific files for 20230929
> 
> Error/Warning reports:
> 
> [...]
> https://lore.kernel.org/oe-kbuild-all/202309192314.VBsjiIm5-lkp@intel.com

   fs/bcachefs/extents.c: In function 'bch2_bkey_append_ptr':
   include/linux/fortify-string.h:57:33: warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
      57 | #define __underlying_memcpy     __builtin_memcpy
         |                                 ^
   include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
     648 |         __underlying_##op(p, q, __fortify_size);                        \
         |         ^~~~~~~~~~~~~
   include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
     693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^~~~~~~~~~~~~~~~~~~~
   fs/bcachefs/extents.c:235:17: note: in expansion of macro 'memcpy'
     235 |                 memcpy((void *) &k->v + bkey_val_bytes(&k->k),
         |                 ^~~~~~
   fs/bcachefs/bcachefs_format.h:287:33: note: destination object 'v' of size 0
     287 |                 struct bch_val  v;
         |                                 ^

The problem here is the struct bch_val is explicitly declared as a
zero-sized array, so the compiler becomes unhappy. :) Converting bch_val
to a flexible array will just kick the can down the road, since this is
going to run into -Wflex-array-member-not-at-end soon too since bch_val
overlaps with other structures:

struct bch_inode_v3 {
        struct bch_val          v;

        __le64                  bi_journal_seq;
...
};

As a container_of() target, this is fine -- leave it a zero-sized
array. The problem is using it as a destination for memcpy, etc, since
the compiler will believe it to be 0 sized. Instead, we need to impart
a type of some kind so that the compiler can actually unambiguously
reason about sizes. The memcpy() in the warning is targeting bch_val,
so I think the best fix is to correctly handle the different types.

So just to have everything in front of me, here's a summary of what I'm
seeing in the code:

struct bkey {
        /* Size of combined key and value, in u64s */
        __u8            u64s;
...
};

/* Empty placeholder struct, for container_of() */
struct bch_val {
        __u64           __nothing[0];
};

struct bkey_i {
        __u64                   _data[0];

        struct bkey     k;
        struct bch_val  v;
};

static inline void bch2_bkey_append_ptr(struct bkey_i *k, struct bch_extent_ptr ptr)
{
        EBUG_ON(bch2_bkey_has_device(bkey_i_to_s(k), ptr.dev));

        switch (k->k.type) {
        case KEY_TYPE_btree_ptr:
        case KEY_TYPE_btree_ptr_v2:
        case KEY_TYPE_extent:
                EBUG_ON(bkey_val_u64s(&k->k) >= BKEY_EXTENT_VAL_U64s_MAX);

                ptr.type = 1 << BCH_EXTENT_ENTRY_ptr;

                memcpy((void *) &k->v + bkey_val_bytes(&k->k),
                       &ptr,
                       sizeof(ptr));
                k->k.u64s++;
                break;
        default:
                BUG();
        }
}

So this is appending u64s into the region that start with bkey_i. Could
this gain a u64 flexible array?

struct bkey_i {
        __u64                   _data[0];

        struct bkey     k;
        struct bch_val  v;
	__u64		ptrs[];
};

Then the memcpy() could be just a direct assignment:

		k->ptrs[bkey_val_u64s(&k->k)] = (u64)ptr;
                k->k.u64s++;

Alternatively, perhaps struct bkey could be the one to grow this flexible
array, and then it could eventually be tracked with __counted_by (but
not today since it expects to count the array element count, not a whole
struct size):

struct bkey {
        /* Size of combined key and value, in u64s */
        __u8            u64s;
...
	__u64		data[] __counted_by(.u64s - BKEY_U64s);
};

And bch_val could be dropped...

Then the memcpy becomes:

                k->k.u64s++;
                k->k.data[bkey_val_u64s(&k->k)] = (u64)ptr;

It just seems like there is a lot of work happening that could really
just type casting or unions...

What do you think?

-- 
Kees Cook
