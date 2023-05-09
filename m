Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B44A6FC748
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 14:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbjEIM7o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 08:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbjEIM7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 08:59:43 -0400
Received: from out-16.mta0.migadu.com (out-16.mta0.migadu.com [91.218.175.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0F6559A
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 05:59:18 -0700 (PDT)
Message-ID: <876d2357-496e-9031-5554-ceeb579f3525@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683637156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z6PFxV/q5G5ouA2pgPzoEa0HjwZPZJA8n6oqmO1cwB8=;
        b=jcJcSd13vB0rOewhfnbakgBpFzJbC2ijdenxJp62tY5yYu5mpxeXPAV3sQPSSe5nZeNKyA
        5f1yNHZlJNWyAFcAY5sHaHQCqIcYSg3PsN5oCUJtnea0Gaeub+flwcAYGKMm3v4zSweDdP
        YbWKdVCiDXnAtYTNH9IN57w80F7N69U=
Date:   Tue, 9 May 2023 20:59:06 +0800
MIME-Version: 1.0
Subject: Re: [fuse-devel] [PATCH] fuse: add a new flag to allow shared mmap in
 FOPEN_DIRECT_IO mode
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Hao Xu <hao.xu@linux.dev>
To:     fuse-devel@lists.sourceforge.net, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        cgxu519@mykernel.net
References: <20230505081652.43008-1-hao.xu@linux.dev>
In-Reply-To: <20230505081652.43008-1-hao.xu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/5/23 16:16, Hao Xu wrote:
> From: Hao Xu <howeyxu@tencent.com>
>
> FOPEN_DIRECT_IO is usually set by fuse daemon to indicate need of strong
> coherency, e.g. network filesystems. Thus shared mmap is disabled since
> it leverages page cache and may write to it, which may cause
> inconsistence. But FOPEN_DIRECT_IO can be used not for coherency but to
> reduce memory footprint as well, e.g. reduce guest memory usage with
> virtiofs. Therefore, add a new flag FOPEN_DIRECT_IO_SHARED_MMAP to allow
> shared mmap for these cases.
>
> Signed-off-by: Hao Xu <howeyxu@tencent.com>


Hi Miklos, any comments on this one?


Thanks,

Hao

