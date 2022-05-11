Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3290E522A9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 05:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbiEKD5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 23:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242034AbiEKD4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 23:56:47 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219AC5E75E
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 20:56:32 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id i17so654179pla.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 20:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=elq3ZqCelpCSxkkjk1LXdyA6w9hgB+SCHXKMgxWGx/U=;
        b=f0WEcC7jjPTFG6Q6v9mT/VTbUk6akakqKqThuRBA10OtcmKjJs4FotEBdprRTmZrZF
         Kb8j00IvxlaVvxLhVF+olvEM7z068yqNY7DUksi25Wuhc+ittQMbF3sNNuMlrjp0trft
         jPe+SBWtYADIgBt1U9crcisYDlPyJy9V3ts222QP9S+ZNj9WdGzgEwTfgBNGgl9lTyX0
         2Fv+/xdOFKMtT6Hvk7/sOzspO4aPku8B/XAFXgUu6zqe5yJcQO9LXB8JSfcNQzqAzBt6
         y50LLDXRRm0M8Qj3TiD3Vhrh3vbutMS5qxe2s2RBw/glkC+5rS+kVBVhvbLF5i3xYVL7
         tJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=elq3ZqCelpCSxkkjk1LXdyA6w9hgB+SCHXKMgxWGx/U=;
        b=htwe8OHc8UhCtRWIIp7EIYcAr+BBQL3FPIVrMTCSmHL4r9NPhBu9UtsbVuCqS6xPrY
         4qqpN8pOdflbW90jqAnY+adIXMIABQdo6ySU7VhP9Nu6KT2X289trDu1+tSQazfncz5z
         dEZJRinP5SEiHs4yeTkPbOnnpRC1PHkRpb22M7+zSModN6erj9oRl7HUVN+4GHklCVuq
         p+FKn16yiZZVu1s5VlX+/VcVqJ0mfUO/etD6QWBWM+JwddHSdl7UkVgi4P5QvWH8pf8V
         ardAhhUWQvNFKzq7Kmj9Ha0GhYaHST6LS5P9Nqbe07DdVs52OFV6WVk69NTsVCppcaOo
         M6HQ==
X-Gm-Message-State: AOAM5331UWOEhXAm2IxeCtZFsvzdDqE7vHOvISep6tGK0UcNpkUAWqnO
        mOFyfAecjgx/F8/Ls5PpZvtkD25tuCa5v0JDnUdXuA==
X-Google-Smtp-Source: ABdhPJw5n1KJcz8j1FP3c7A6fBBMc1hcuPZsn2gE31BtaT8knvxsmvrFDZQnLCp0J+6DmYbEonpCWUJBRb2zAP6Umfo=
X-Received: by 2002:a17:902:da8b:b0:15e:c0e8:d846 with SMTP id
 j11-20020a170902da8b00b0015ec0e8d846mr23539490plx.34.1652241391912; Tue, 10
 May 2022 20:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220422224508.440670-1-jane.chu@oracle.com> <20220422224508.440670-4-jane.chu@oracle.com>
 <CAPcyv4i7xi=5O=HSeBEzvoLvsmBB_GdEncbasMmYKf3vATNy0A@mail.gmail.com>
In-Reply-To: <CAPcyv4i7xi=5O=HSeBEzvoLvsmBB_GdEncbasMmYKf3vATNy0A@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 10 May 2022 20:56:21 -0700
Message-ID: <CAPcyv4id8AbTFpO7ED_DAPren=eJQHwcdY8Mjx18LhW+u4MdNQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/7] mce: fix set_mce_nospec to always unmap the whole page
To:     Jane Chu <jane.chu@oracle.com>, Borislav Petkov <bp@alien8.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, david <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>, Jue Wang <juew@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 4:25 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> [ Add Tony as the originator of the whole_page() logic and Jue who
> reported the issue that lead to 17fae1294ad9 x86/{mce,mm}: Unmap the
> entire page if the whole page is affected and poisoned ]
>
>
> On Fri, Apr 22, 2022 at 3:46 PM Jane Chu <jane.chu@oracle.com> wrote:
> >
> > The set_memory_uc() approach doesn't work well in all cases.
> > As Dan pointed out when "The VMM unmapped the bad page from
> > guest physical space and passed the machine check to the guest."
> > "The guest gets virtual #MC on an access to that page. When
> > the guest tries to do set_memory_uc() and instructs cpa_flush()
> > to do clean caches that results in taking another fault / exception
> > perhaps because the VMM unmapped the page from the guest."
> >
> > Since the driver has special knowledge to handle NP or UC,
> > mark the poisoned page with NP and let driver handle it when
> > it comes down to repair.
> >
> > Please refer to discussions here for more details.
> > https://lore.kernel.org/all/CAPcyv4hrXPb1tASBZUg-GgdVs0OOFKXMXLiHmktg_kFi7YBMyQ@mail.gmail.com/
> >
> > Now since poisoned page is marked as not-present, in order to
> > avoid writing to a not-present page and trigger kernel Oops,
> > also fix pmem_do_write().
> >
> > Fixes: 284ce4011ba6 ("x86/memory_failure: Introduce {set, clear}_mce_nospec()")
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Jane Chu <jane.chu@oracle.com>

Boris,

This is the last patch in this set that needs an x86 maintainer ack.
Since you have been involved in the history for most of this, mind
giving it an ack so I can pull it in for v5.19? Let me know if you
want a resend.
