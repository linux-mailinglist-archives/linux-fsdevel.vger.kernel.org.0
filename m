Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CAA618AF2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 23:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiKCWAA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 18:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKCV76 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:59:58 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387D6BE3;
        Thu,  3 Nov 2022 14:59:58 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so6573398pji.1;
        Thu, 03 Nov 2022 14:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BXMtoJhRlFWaQLcxjEM+qd1+6PF53F0Hz+I5xM4y+wc=;
        b=LSzE9TH+osvipk73Jg9gpor1ZQe37FTuPrWQ5VUxQIsLQ//7XAFuJQM1KyFIXYAxqx
         BE4yzuk+xifeQgNpMYonk3DPgvpHS7XYbgoNdLomm2aKEkQCHaH0Bc7mrZFzL+9j5ZSy
         b9DDF8m1+3bfZ9iV0lucJ1MqhbByVhp5MZXMvkd4dpduipcwth1ZiKn90EGRhJ8R9r+m
         EJ4boWxUG+nQ4ooKm3DZioH6mkJd/Le4V3cgspEcIdaCLQDHg98SssmSluKeW2l4jPay
         g1Az1Lvo9oZjC2k1yTkOvtryQxynTaEzmqQoj8oo4NJhMXBQYq056FnhoGgEMPlBjEct
         OTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXMtoJhRlFWaQLcxjEM+qd1+6PF53F0Hz+I5xM4y+wc=;
        b=RKrv3DUJM7CfY2BHprOVwKEPqfFmroYGAnnHdVdqOY8dWVMmcB6og8yg8k8ROql3Re
         Fqwdh5/RScMKafwbAcekhjZb6fW54CLqKd5in6I/+VCrk7Ndzgyk/4SrUwYBCJd08oHZ
         fOE2BIJHTt+jLslJ8ZBF8IxdQikGfL1b2We2IziTZqbdvDlId8/NJr0JI+zZ4lKVcXhY
         bKgh7asDtYfNDQQCmK2k7GHmqvw0nmVM2Lzvy8HfRR6dedwkH6PV2dUX7pXjfIWgTdb0
         2VwNvImMjCwLTsOBLIwsTon/MgYFRQOByNn+ZVjLcjfEN4f5TNwAnBA+HBk6nXNr2qyg
         V3Cw==
X-Gm-Message-State: ACrzQf0bap+seG7CJipX4qovZDHkwJseGjTNzfZ5m93pxErfYxt2bI8O
        kfVXF4K0FZGqWSwgNo/L4P0=
X-Google-Smtp-Source: AMsMyM7bULDdaNCNh0UvTT4e4bGiz6aC/rB81Sbmms9IVmh3til4gq09VVgLdxxc7KpN8RZNvnj8Zw==
X-Received: by 2002:a17:90b:1c10:b0:213:1bb8:feb with SMTP id oc16-20020a17090b1c1000b002131bb80febmr49947295pjb.214.1667512797631;
        Thu, 03 Nov 2022 14:59:57 -0700 (PDT)
Received: from fedora ([2601:644:8002:1c20::8080])
        by smtp.gmail.com with ESMTPSA id 123-20020a621781000000b00562784609fbsm1184991pfx.209.2022.11.03.14.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 14:59:57 -0700 (PDT)
Date:   Thu, 3 Nov 2022 14:59:54 -0700
From:   Vishal Moola <vishal.moola@gmail.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 00/23] Convert to filemap_get_folios_tag()
Message-ID: <Y2Q52uQGoqGM4o9m@fedora>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
 <20221018214544.GI2703033@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018214544.GI2703033@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 19, 2022 at 08:45:44AM +1100, Dave Chinner wrote:
> On Thu, Sep 01, 2022 at 03:01:15PM -0700, Vishal Moola (Oracle) wrote:
> > This patch series replaces find_get_pages_range_tag() with
> > filemap_get_folios_tag(). This also allows the removal of multiple
> > calls to compound_head() throughout.
> > It also makes a good chunk of the straightforward conversions to folios,
> > and takes the opportunity to introduce a function that grabs a folio
> > from the pagecache.
> > 
> > F2fs and Ceph have quite alot of work to be done regarding folios, so
> > for now those patches only have the changes necessary for the removal of
> > find_get_pages_range_tag(), and only support folios of size 1 (which is
> > all they use right now anyways).
> > 
> > I've run xfstests on btrfs, ext4, f2fs, and nilfs2, but more testing may be
> > beneficial.
> 
> Well, that answers my question about how filesystems that enable
> multi-page folios were tested: they weren't. 
> 
> I'd suggest that anyone working on further extending the
> filemap/folio infrastructure really needs to be testing XFS as a
> first priority, and then other filesystems as a secondary concern.
> 
> That's because XFS (via the fs/iomap infrastructure) is one of only
> 3 filesystems in the kernel (AFS and tmpfs are the others) that
> interact with the page cache and page cache "pages" solely via folio
> interfaces. As such they are able to support multi-page folios in
> the page cache. All of the tested filesystems still use the fixed
> PAGE_SIZE page interfaces to interact with the page cache, so they
> don't actually exercise interactions with multi-page folios at all.
> 

Thanks for the explanation! That makes perfect sense. I wholeheartedly
agree, and I'll be sure to test any future changes on XFS to try to
ensure multi-page folio functionality. 

I know David ran tests on AFS, so hopefully those hit multipage folios
well enough. But I'm not sure whether it was just for the AFS patch or
with the whole series applied. Regardless I'll run my own set of tests
on XFS and see if I run into any issues as well.
