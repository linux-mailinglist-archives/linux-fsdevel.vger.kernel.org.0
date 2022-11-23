Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00E3635197
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 08:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbiKWHy4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 02:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbiKWHyg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:54:36 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99FE1025FB;
        Tue, 22 Nov 2022 23:52:16 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 205so19996116ybe.7;
        Tue, 22 Nov 2022 23:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P19tg7f0hwXERpV/M7ELvgDfUdF9U5SKIaEHruEwVZ8=;
        b=I95petThg7UhoVdm4lGriYYMJnxYtrjHaIKc1ojn69HShPmb7N9LE53ranGPKehWXD
         Ai7zjiizdZ5fTOLoFalxm72zrYF0BWSX6/g9h4YwnEPMtfXAHNNOGxe2Rr9tQHPPv4HT
         OmTbe1DlwFoX6z67skQJ+vP08jCgR4Y+hk6ui+6u1V3x67bNsFc82XsVMiHvB9gcFW0v
         NLoWDWwPcd8/yfCWCgp3udpc/bEFUjZjVuLYZLdBas4KrJqZjIPSW72Ac2PgQ4w7qvt+
         kyBz/SXl0PZDEeFEnI34l4ov9q4NPNDW/n+y81wrZrHINxDHDaMUZzsQf5jGAA6II0Cu
         7oxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P19tg7f0hwXERpV/M7ELvgDfUdF9U5SKIaEHruEwVZ8=;
        b=p3l9LLh49Zt02wHBkZ6hQ4ykqxrhAI4a5U7RspasQnkeS8BUFpe+P8SqeUEELDDIX1
         v6QEHZ4B+kbXZLIet1lxt+8PkpbDVSUFZ1c1PTrlaWn80ZRSWm65MXj7Hhj4qMYmqb+h
         Mm9K8rt0X0a47AlY/RP5n2Hc0KnBDC9bMZp5DoQqiFAJKOc8aVYuHh053lfSAKS+GXAZ
         qyJUWEXme+lA+IUQOdj29AMlT5CAKXrLEH5mtDPMNxgKqGPf7TQHBMw5P0S390gbDL5y
         REpyqO2uHO27u5VCi4Vh616YREi3RX+HSBjil6ei4dk1Ze79KXevzm5N65YFWCsFeEcH
         J1Yw==
X-Gm-Message-State: ANoB5plDsLxpn+kTAy4BzjiWdvIyczIUQzcki0jvAxkxDqa3GRorDAHy
        i65DYofiWebOnWb/LWuCx9QPeWdHEQVl/Yl89igKYmNmJlk=
X-Google-Smtp-Source: AA0mqf7fGDDGExKSXNOos7vNzx8TqR3lvacFwRNqRaQ3jTxl7oWgkKtDUzNZIqGW1zW9LTV0JvEoeN3bc7y2t0XFyhQ=
X-Received: by 2002:a25:ae04:0:b0:6eb:1172:34ca with SMTP id
 a4-20020a25ae04000000b006eb117234camr9524097ybj.219.1669189930096; Tue, 22
 Nov 2022 23:52:10 -0800 (PST)
MIME-Version: 1.0
References: <20221017202451.4951-1-vishal.moola@gmail.com> <20221017202451.4951-15-vishal.moola@gmail.com>
 <9c01bb74-97b3-d1c0-6a5f-dc8b11113e1a@kernel.org> <CAOzc2pweRFtsUj65=U-N-+ASf3cQybwMuABoVB+ciHzD1gKWhQ@mail.gmail.com>
 <CAOzc2pzoG1CN3Bpx5oe37GwRv71TpTQmFH6m58kTqOmeW7KLOw@mail.gmail.com>
In-Reply-To: <CAOzc2pzoG1CN3Bpx5oe37GwRv71TpTQmFH6m58kTqOmeW7KLOw@mail.gmail.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Tue, 22 Nov 2022 23:51:59 -0800
Message-ID: <CAOzc2pw_AvE_BabounZvVMmQMpt70Dj8qLFPV8CXwJowzBL+BQ@mail.gmail.com>
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

Here are some numbers for reference to performance. I'm thinking we may
want to go with the new version, but I'll let you be the judge of that.
I ran some fio random write tests with block size 64k on a system with 8 cpus.

1 job with 1 io-depth:
Baseline:
  slat (usec): min=8, max=849, avg=16.47, stdev=12.33
  clat (nsec): min=253, max=751838, avg=346.51, stdev=2452.10
  lat (usec): min=9, max=854, avg=17.00, stdev=12.74
  lat (nsec)   : 500=97.09%, 750=1.73%, 1000=0.57%
  lat (usec)   : 2=0.41%, 4=0.09%, 10=0.06%, 20=0.04%, 50=0.01%
  lat (usec)   : 100=0.01%, 1000=0.01%

This patch:
  slat (usec): min=9, max=3690, avg=16.61, stdev=17.36
  clat (nsec): min=28, max=380434, avg=336.59, stdev=1571.23
  lat (usec): min=10, max=3699, avg=17.13, stdev=17.51
  lat (nsec)   : 50=0.01%, 500=97.95%, 750=1.42%, 1000=0.33%
  lat (usec)   : 2=0.19%, 4=0.05%, 10=0.03%, 20=0.03%, 50=0.01%
  lat (usec)   : 100=0.01%, 250=0.01%, 500=0.01%

Folios w/ F2FS_ONSTACK_PAGES (next version):
  slat (usec): min=12, max=13623, avg=19.48, stdev=48.94
  clat (nsec): min=265, max=386917, avg=380.97, stdev=1679.85
  lat (usec): min=12, max=13635, avg=20.06, stdev=49.27
  lat (nsec)   : 500=93.55%, 750=4.62%, 1000=0.92%
  lat (usec)   : 2=0.65%, 4=0.09%, 10=0.10%, 20=0.06%, 50=0.01%
  lat (usec)   : 100=0.01%, 250=0.01%, 500=0.01%

1 job with 16 io-depth:
Baseline:
  slat (usec): min=8, max=3907, avg=16.89, stdev=23.39
  clat (usec): min=12, max=15160k, avg=11115.61, stdev=265051.86
  lat (usec): min=137, max=15160k, avg=11132.68, stdev=265051.75
  lat (usec)   : 20=0.01%, 250=57.66%, 500=39.56%, 750=1.96%, 1000=0.22%
  lat (msec)   : 2=0.16%, 4=0.06%, 10=0.01%, 2000=0.29%, >=2000=0.08%

This patch:
  slat (usec): min=9, max=1230, avg=17.15, stdev=12.95
  clat (usec): min=4, max=39471k, avg=14825.22, stdev=588237.30
  lat (usec): min=80, max=39471k, avg=14842.55, stdev=588237.27
  lat (usec)   : 10=0.01%, 250=38.78%, 500=59.53%, 750=1.12%, 1000=0.16%
  lat (msec)   : 2=0.04%, 2000=0.34%, >=2000=0.02%

Folios w/ F2FS_ONSTACK_PAGES (next version):
  slat (usec): min=9, max=1188, avg=18.74, stdev=14.12
  clat (usec): min=5, max=15278k, avg=8936.75, stdev=214230.09
  lat (usec): min=90, max=15278k, avg=8955.67, stdev=214230.10
  lat (usec)   : 10=0.01%, 250=9.68%, 500=86.49%, 750=2.74%, 1000=0.54%
  lat (msec)   : 2=0.18%, 2000=0.32%, >=2000=0.04%


> How do the remaining f2fs patches in the series look to you?
> Patch 16/23 f2fs_sync_meta_pages() in particular seems like it may
> be prone to problems. If there are any changes that need to be made to
> it I can include those in the next version as well.
