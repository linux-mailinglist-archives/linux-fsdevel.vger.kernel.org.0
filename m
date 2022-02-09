Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263F24AF509
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 16:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiBIPUX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 10:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiBIPUW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:20:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39B5AC05CB82
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 07:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644420024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HWJxSwYp7jtZ92shaLhTfEcqyJ4FcqxLKxSHScXMFmA=;
        b=PyuTenbJ41dM5debF7w6Co+TKiLJfVBr8cyhYPUt4fu3dF08QvMM59PBa3YU3t17p2HsxK
        vFbAgD2o6GVPyf86BefZ69if5ZvtmMZtWxa+4YzYM7zZJ2bIKSBLAgApQUAnrwC0eJKzGU
        BY9JrygxUlbsn/uIpnzLeMZNAbu1B18=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-3cYyOJHuMyejTQH3t43s9Q-1; Wed, 09 Feb 2022 10:20:22 -0500
X-MC-Unique: 3cYyOJHuMyejTQH3t43s9Q-1
Received: by mail-wm1-f70.google.com with SMTP id p24-20020a05600c1d9800b0037be98d03a1so2228778wms.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Feb 2022 07:20:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWJxSwYp7jtZ92shaLhTfEcqyJ4FcqxLKxSHScXMFmA=;
        b=Iu/iaYpU5F/d7rNPO8zWc+3disgbTGtiFx+IF7TKexri+7vtJ6UhYVYYrZk4NcqbyO
         C86VS0033i6nzLSbdlSDeGKcgt0WAvwG7L8lTS98hakdvXmblzd+qx/uD0GMBW8KOJx1
         Jc+4FW9yuL2g62r3985NMWCKt6jAPMj4D6B63IPqglABBH9v59/PbpNkW5WOCBTbW8Ya
         QAgFN09REqlritEzQrWdNbUMw5AFHDXUAfKQy6f3VUThguZEHKjy/wYldC7MYx0SRPkE
         vMKCQKP0BZ/v3qzXd97BAot3sxXJJIEKSAC/7fT4AXrpffNFUvaG7oXRBmb7HR5nhgQo
         JpBQ==
X-Gm-Message-State: AOAM532SbuIe0JIdUUvQNVh0fD+6fOAeijh2BVA+K1IbrWVv5+OoM0jU
        7FQS5ghFA+IT4rxIbQLS0Qu+gwfhsOT5gjoJX/ffEPeS0S69bn6aTDC89nguvkMTJvPqpdGss5/
        KqK/pxLbKvuLG1kHfelvhAhJ0tYel3UZ7Ubq3TV8WAw==
X-Received: by 2002:a1c:2942:: with SMTP id p63mr2494649wmp.75.1644420021707;
        Wed, 09 Feb 2022 07:20:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBIOqCE7cDbpGvT5TmCSizl7rrPw18L3EY0Uy8onixaMONTzYS0XvUHUkxcZEdMAG886y96+4xK4BB/NuuR5w=
X-Received: by 2002:a1c:2942:: with SMTP id p63mr2494623wmp.75.1644420021540;
 Wed, 09 Feb 2022 07:20:21 -0800 (PST)
MIME-Version: 1.0
References: <20220209085243.3136536-1-lee.jones@linaro.org> <20220209150904.GA22025@lst.de>
In-Reply-To: <20220209150904.GA22025@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 9 Feb 2022 16:20:10 +0100
Message-ID: <CAHc6FU5e4GaQTfh6Z2_2vhcgxY+dbwUBOgazrXB3XW4=DRpLHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Revert "iomap: fall back to buffered writes for
 invalidation failures"
To:     Christoph Hellwig <hch@lst.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        syzbot+0ed9f769264276638893@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 9, 2022 at 4:09 PM Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Feb 09, 2022 at 08:52:43AM +0000, Lee Jones wrote:
> > This reverts commit 60263d5889e6dc5987dc51b801be4955ff2e4aa7.
> >
> > Reverting since this commit opens a potential avenue for abuse.
> >
> > The C-reproducer and more information can be found at the link below.

This reproducer seems to be working fine on gfs2, but the locking in
gfs2 differs hugely from that of other filesystems.

> > With this patch applied, I can no longer get the repro to trigger.
>
> Well, maybe you should actually debug and try to understand what is
> going on before blindly reverting random commits.

Andreas

