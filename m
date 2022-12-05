Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F2C6435BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Dec 2022 21:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiLEUer (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Dec 2022 15:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiLEUer (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:34:47 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0584714084;
        Mon,  5 Dec 2022 12:34:46 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3b56782b3f6so130549427b3.13;
        Mon, 05 Dec 2022 12:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GeLGTXERGukeSNOQDu2YmR7uT9/qpiRMDyykHkleQ2o=;
        b=pV6KI/HZBQddAaryd4yKdtAZIjXHM+fQOQl8vls8oCF/Y0syljnC36hzxgQFzf3t1W
         ZEfFPue68nbSQYyN45g3vyc1tKTsDhhDmdhY4NZzbyws1OLLs/EBYBCLeHMjUZ7AqQkG
         bPHpYPqJ1AEZL4uauJNarKOb8Kjs0EiXHDayRbW+LvH0eVfIfd+Kt4GAhbisw/fJv8H5
         ye4ctWjmmYNQlCsceyNtIQIp7VQQPqFfnpnwbiE6A67xPTrxsvIZPcz5N+C3swPGuMEV
         zdL6BSwaRQTncT/q4vMGhtHQUJU0KVbms8kPcPSjUkErq0sjFtA3tGrr1dDn23Y/Q2aR
         UEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GeLGTXERGukeSNOQDu2YmR7uT9/qpiRMDyykHkleQ2o=;
        b=7Xvmzz+819vhpwQqnUVItJFWwv95vzbsCNcb8bWbsISlJEMOFqTBBU8gHBlO8KfYld
         QBfhl6l5ncv3fbdZXc2VSZHQ0fuqTplXQZ5bE4w0SPo74ga+23SGGbjBcolWdL6mTxrP
         usqs+tsA/f9NjVwV3OBRlpQ5hhS0qQG9my2YY2lHLDMiT2zOx21LwVt47Fueq3qtTn6c
         8e1BEbV6KaMa/CINCWNYqZtmZFybHztyM4uLfVtDoQYF4IBKHtRs9QNH8rpHOhftELML
         KYt18bq30JA80z4EsQZhKsFySgTFSB5RIIOBJhhIxNbPtQZREoGr07hsqUSMri9Vk1WU
         9hMg==
X-Gm-Message-State: ANoB5pmvPbTPorojTAjsaDb7WA+CggN+6JXeBBDYx3MUgp2Zrk3AhP94
        7BU4WWPaMGi7am0TdrrPSnfbsNP0a0qDYOYq7Yc=
X-Google-Smtp-Source: AA0mqf6gVcUjGEuTNRozrYnWxY5uXjxRLCGPLpX8tEkUr/ot069nsH0uaNB29RtGgsmUEgc5iySKcYLMmK606QxvYxY=
X-Received: by 2002:a81:4905:0:b0:3a8:fad9:13c0 with SMTP id
 w5-20020a814905000000b003a8fad913c0mr60110141ywa.23.1670272485151; Mon, 05
 Dec 2022 12:34:45 -0800 (PST)
MIME-Version: 1.0
References: <20221017202451.4951-1-vishal.moola@gmail.com> <20221017202451.4951-15-vishal.moola@gmail.com>
 <9c01bb74-97b3-d1c0-6a5f-dc8b11113e1a@kernel.org> <CAOzc2pweRFtsUj65=U-N-+ASf3cQybwMuABoVB+ciHzD1gKWhQ@mail.gmail.com>
 <CAOzc2pzoG1CN3Bpx5oe37GwRv71TpTQmFH6m58kTqOmeW7KLOw@mail.gmail.com>
In-Reply-To: <CAOzc2pzoG1CN3Bpx5oe37GwRv71TpTQmFH6m58kTqOmeW7KLOw@mail.gmail.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Mon, 5 Dec 2022 12:34:33 -0800
Message-ID: <CAOzc2pzp0JEanJTgzSrRt3ziRCrR6rGCjpwJvAD8uCqsHqXnHg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3 14/23] f2fs: Convert f2fs_write_cache_pages()
 to use filemap_get_folios_tag()
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        fengnan chang <fengnanchang@gmail.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 22, 2022 at 6:26 PM Vishal Moola <vishal.moola@gmail.com> wrote:
>
> On Mon, Nov 14, 2022 at 1:38 PM Vishal Moola <vishal.moola@gmail.com> wrote:
> >
> > On Sun, Nov 13, 2022 at 11:02 PM Chao Yu <chao@kernel.org> wrote:
> > >
> > > On 2022/10/18 4:24, Vishal Moola (Oracle) wrote:
> > > > Converted the function to use a folio_batch instead of pagevec. This is in
> > > > preparation for the removal of find_get_pages_range_tag().
> > > >
> > > > Also modified f2fs_all_cluster_page_ready to take in a folio_batch instead
> > > > of pagevec. This does NOT support large folios. The function currently
> > >
> > > Vishal,
> > >
> > > It looks this patch tries to revert Fengnan's change:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=01fc4b9a6ed8eacb64e5609bab7ac963e1c7e486
> > >
> > > How about doing some tests to evaluate its performance effect?
> >
> > Yeah I'll play around with it to see how much of a difference it makes.
>
> I did some testing. Looks like reverting Fengnan's change allows for
> occasional, but significant, spikes in write latency. I'll work on a variation
> of the patch that maintains the use of F2FS_ONSTACK_PAGES and send
> that in the next version of the patch series. Thanks for pointing that out!

Following Matthew's comment, I'm thinking we should go with this patch
as is. The numbers between both variations did not have substantial
differences with regard to latency.

While the new variant would maintain the use of F2FS_ONSTACK_PAGES,
the code becomes messier and would end up limiting the number of
folios written back once large folio support is added. This means it would
have to be converted down to this version later anyways.

Does leaving this patch as is sound good to you?

For reference, here's what the version continuing to use a page
array of size F2FS_ONSTACK_PAGES would change:

+               nr_pages = 0;
+again:
+               nr_folios = filemap_get_folios_tag(mapping, &index, end,
+                               tag, &fbatch);
+               if (nr_folios == 0) {
+                       if (nr_pages)
+                               goto write;
+                               goto write;
                        break;
+               }

+               for (i = 0; i < nr_folios; i++) {
+                       struct folio* folio = fbatch.folios[i];
+
+                       idx = 0;
+                       p = folio_nr_pages(folio);
+add_more:
+                       pages[nr_pages] = folio_page(folio,idx);
+                       folio_ref_inc(folio);
+                       if (++nr_pages == F2FS_ONSTACK_PAGES) {
+                               index = folio->index + idx + 1;
+                               folio_batch_release(&fbatch);
+                               goto write;
+                       }
+                       if (++idx < p)
+                               goto add_more;
+               }
+               folio_batch_release(&fbatch);
+               goto again;
+write:

> How do the remaining f2fs patches in the series look to you?
> Patch 16/23 f2fs_sync_meta_pages() in particular seems like it may
> be prone to problems. If there are any changes that need to be made to
> it I can include those in the next version as well.

Thanks for reviewing the patches so far. I wanted to follow up on asking
for review of the last couple of patches.
