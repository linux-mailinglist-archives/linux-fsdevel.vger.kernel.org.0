Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D04553293
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 14:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350635AbiFUMxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 08:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350629AbiFUMxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:53:48 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE5313DF1;
        Tue, 21 Jun 2022 05:53:46 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id c11so6610459vkn.5;
        Tue, 21 Jun 2022 05:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yb9vkEUpdbTV1Sj8CeuQZ8eYu7ZKL4jHVAmR222mLRA=;
        b=e/vY6Jpj/+z+4jNBXG61wwIMnsqvGO+n+pNeqKSTwqu+tDMflnMXwjBXtwgV0wSkEg
         qrNHW56HSFEHobAQiV5ckj8MymDaFvHx97dgwBxX9SBL0f4lsjYo//O5RO78rza7tTCF
         RrJBGxFYdPEkC1Q8e0q8AnSsXdDBE3HNHqKpozyDcSoJ8bp5IVilDPtNLTnSRbQRIh3k
         hGLaUqE2sOZCRXMiOUdKbOsgWvqCuhMPW2LL0Eiw7Ct1TBSJNbLzFAHoRNgzMC+VXU/W
         lH+Wfuqz91X2/iKgSR9/bMvzj+qT8Oq/iB1cbEj6HL7Q8ma4e+qRAXNiU79m7sgDN3wi
         1pcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yb9vkEUpdbTV1Sj8CeuQZ8eYu7ZKL4jHVAmR222mLRA=;
        b=QTYyt6JPiaiT5JDBeGEANt/us/cfUPYi7vsh07LurwEK0W0fm0YiH3uyWAD+NEKNAk
         aZHp4oTLrGg1qOWxFOhJ/9aCBpbOkd8Eoz5LkGLj47bcD4kIraFxMoUiZ7KPw1DxprMV
         Z0CNPw57WwbyMCU7P+Z3P8PJav1p0jlHcL1coMn+M5NxKGX27r+TGBkim8K33rTlck59
         0SVF3c00d6QtkM6y3lscZYptFUEB7Gvuz71BFdPoqw/i75JcXvXv+A3X9y2F22N8YKma
         Ea/cX8pi2UA4t9hQaYNx22+W4Nq1Oqp6HmRWNdE35VLi+cGUPvUh3hsZsEpJE/3umnGK
         GoWA==
X-Gm-Message-State: AJIora+15SwMcSQPuohWSr3PZFbuc031/S9nz9JVfUYKcp8QhJqV1Dtc
        2b+IE+zLew2aMILYwr9roRMmg+0adijGx5L1gQ0=
X-Google-Smtp-Source: AGRyM1vFzT4bTXaOSPFTRT4YwVmNjSD0GSGvkvoWAOfpVMB4xTGm94sXUrMMBEZN6PZSeEBHeHaR+QPptQqJebDVhXw=
X-Received: by 2002:a1f:73c1:0:b0:35c:cb95:832 with SMTP id
 o184-20020a1f73c1000000b0035ccb950832mr10743117vkc.15.1655816025521; Tue, 21
 Jun 2022 05:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190407232728.GF26298@dastard> <CAOQ4uxgD4ErSUtbu0xqb5dSm_tM4J92qt6=hGH8GRc5KNGqP9A@mail.gmail.com>
 <20190408141114.GC15023@quack2.suse.cz> <CAOQ4uxhxgYASST1k-UaqfbLL9ERquHaKL2jtydB2+iF9aT8SRQ@mail.gmail.com>
 <20190409082605.GA8107@quack2.suse.cz> <CAOQ4uxgu4uKJp5t+RoumMneR6bw_k0CRhGhU-SLAky4VHSg9MQ@mail.gmail.com>
 <20220617151135.yc6vytge6hjabsuz@quack3> <CAOQ4uxjvx33KRSm-HX2AjL=aB5yO=FeWokZ1usDKW7+R4Ednhg@mail.gmail.com>
 <20220620091136.4uosazpwkmt65a5d@quack3.lan> <CAOQ4uxg+uY5PdcU1=RyDWCxbP4gJB3jH1zkAj=RpfndH9czXbg@mail.gmail.com>
 <20220621085956.y5wyopfgzmqkaeiw@quack3.lan>
In-Reply-To: <20220621085956.y5wyopfgzmqkaeiw@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 21 Jun 2022 15:53:33 +0300
Message-ID: <CAOQ4uxheatf+GCHxbUDQ4s4YSQib3qeYVeXZwEicR9fURrEFBA@mail.gmail.com>
Subject: Re: [POC][PATCH] xfs: reduce ilock contention on buffered randrw workload
To:     Jan Kara <jack@suse.cz>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 21, 2022 at 11:59 AM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 21-06-22 10:49:48, Amir Goldstein wrote:
> > > How exactly do you imagine the synchronization of buffered read against
> > > buffered write would work? Lock all pages for the read range in the page
> > > cache? You'd need to be careful to not bring the machine OOM when someone
> > > asks to read a huge range...
> >
> > I imagine that the atomic r/w synchronisation will remain *exactly* as it is
> > today by taking XFS_IOLOCK_SHARED around generic_file_read_iter(),
> > when reading data into user buffer, but before that, I would like to issue
> > and wait for read of the pages in the range to reduce the probability
> > of doing the read I/O under XFS_IOLOCK_SHARED.
> >
> > The pre-warm of page cache does not need to abide to the atomic read
> > semantics and it is also tolerable if some pages are evicted in between
> > pre-warn and read to user buffer - in the worst case this will result in
> > I/O amplification, but for the common case, it will be a big win for the
> > mixed random r/w performance on xfs.
> >
> > To reduce risk of page cache thrashing we can limit this optimization
> > to a maximum number of page cache pre-warm.
> >
> > The questions are:
> > 1. Does this plan sound reasonable?
>
> Ah, I see now. So essentially the idea is to pull the readahead (which is
> currently happening from filemap_read() -> filemap_get_pages()) out from under
> the i_rwsem. It looks like a fine idea to me.

Great!
Anyone doesn't like the idea or has another suggestion?

>
> > 2. Is there a ready helper (force_page_cache_readahead?) that
> >     I can use which takes the required page/invalidate locks?
>
> page_cache_sync_readahead() should be the function you need. It does take
> care to lock invalidate_lock internally when creating & reading pages. I

Thanks, I'll try that.

> just cannot comment on whether calling this without i_rwsem does not break
> some internal XFS expectations for stuff like reflink etc.

relink is done under xfs_ilock2_io_mmap => filemap_invalidate_lock_two
so it should not be a problem.

pNFS leases I need to look into.

Thanks,
Amir.
