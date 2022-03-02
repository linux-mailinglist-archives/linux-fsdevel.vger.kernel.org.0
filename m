Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80244CB248
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 23:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiCBW04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 17:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiCBW0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:26:55 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347267807D
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 14:26:11 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id bc10so3053857qtb.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Mar 2022 14:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jrfHaieIrrnkEMFMMnMrlJtDDEUiIE870C40v9q8pok=;
        b=WuiWBeDQEirv15kTs9RA62KsWALm8MYwiaCU7QYBjf4PRzgOBrqM7hDU63CTDkZtN3
         u6ebE4e5G2xUnhEkMWJmQCSvUqC8osmDr5JCw3eCd8xt1Xiy/Y5Y2mAXVitBEJLaVFdN
         C4P3EUjvgGTs7W9o/uHiKBJUTx9hRKAIMDwHQJgr/AH0rPH80/RO9yoljHErwsfGx2Ki
         1s0sLazWI3rlq18VzaRUpqgLHFAzJFOEjDt6LoGjz05tCgjrVt8kdQa5YkQmx0gp/zp/
         PBpoeS2yNWsWBXz1SuVAnra5xg6FxZLzfxUaWGDOC2UARlxfYTPA+yHE/mznmEVbVQSr
         h9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jrfHaieIrrnkEMFMMnMrlJtDDEUiIE870C40v9q8pok=;
        b=rnaDyPuFRtqeA9INx+fqIW/b2Z+yXE3fekqllmZFrVK3qKJ8dRjY3e8vXgrXBPq1I8
         qEIdHKSXdaPG3UVTT6OTRm0b/b4Mjv6NTSsmGV9zXckPnqsNjAeGDUsN8NZrPmfN8I/R
         /z/9iie0kpz9KD3ZVxrIqvEMfXeqKJl/jZ9WFG6EtOUEkTcpjczB5wouP2HnfvfBbn6Q
         t7ABgRqPvzVE3hG3ZjCn6osatR8ChHyr1c4fcxi98UoVJGqz6ZpI6dqYstp2g37Dwc+J
         wn5Fy4JqoAUJuD19Zf/f1tOoAEIaErZmkjcrvd55TXIknWQU8DdY0YsAkp9tW2d+Kvkj
         beoQ==
X-Gm-Message-State: AOAM5308VcGF3keo5bkXOF66pWwwK2t/u5Pdj6lohXFaaS1jXEstVZpc
        L1AfDxkShndYhxOaEwZuy/cJYAM6Rtmj4+eE
X-Google-Smtp-Source: ABdhPJzUVs7Eox6/O7D6zrCLCdS/JSuS6iy9mNOaEEZnXfUlxlyy1IPok6gHOdjXLMAmua8/mhK9bg==
X-Received: by 2002:ac8:5cc9:0:b0:2de:8838:5888 with SMTP id s9-20020ac85cc9000000b002de88385888mr26116071qta.370.1646259970183;
        Wed, 02 Mar 2022 14:26:10 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n13-20020ac85b4d000000b002de6fe91d2fsm180318qtw.68.2022.03.02.14.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 14:26:09 -0800 (PST)
Date:   Wed, 2 Mar 2022 17:26:08 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: nfs generic/373 failure after "fs: allow cross-vfsmount
 reflink/dedupe"
Message-ID: <Yh/vADRGuPFGIEc+@localhost.localdomain>
References: <20220301184221.371853-1-amir73il@gmail.com>
 <20220302065952.GE3927073@dread.disaster.area>
 <CAOQ4uxgU7cYAO+KMd=Yb8Fo4AwScQ2J0eqkYn3xWjzBWKtUziQ@mail.gmail.com>
 <20220302082658.GF3927073@dread.disaster.area>
 <CAOQ4uxgiL2eqx-kad+dddXvXPREKT-w3_BnLzdoJaJqGm=H=vA@mail.gmail.com>
 <20220302211226.GG3927073@dread.disaster.area>
 <20220302220450.GD10757@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302220450.GD10757@fieldses.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 02, 2022 at 05:04:50PM -0500, J. Bruce Fields wrote:
> I started seeing generic/373 fail on recent linux-next in NFS testing.
> 
> Bisect lands it on aaf40970b1d0 "fs: allow cross-vfsmount
> reflink/dedupe".
> 
> The test fails because a clone between two mounts is expected to fail,
> and no longer does.
> 
> In my setup both mounts are nfs mounts.  They are mounts of different
> exports, and the exports are exports of different filesystems.  So it
> does make sense that the clone should fail.
> 
> I see the NFS client send a CLONE rpc to the server, and the server
> return success.  That seems wrong.
> 
> Both exported filesystems are xfs, and from the code it looks like the
> server calls vfs_clone_file_range(), which ends up calling
> xfs_file_remap_range().
> 
> Are we missing a check now in that xfs case?
> 
> I haven't looked any more closely at what's going on, so I could be
> missing something.
> 

Yeah there's a few fstests that test this functionality that need to be removed,
I have patches pending for this in our fstests staging tree (since we run
fstests nightly on our tree)

https://github.com/btrfs/fstests/tree/staging

Right now the patches just remove the tests from auto since that's what we run,
I'll remove them properly once the patch lands in linus.  Thanks,

Josef
