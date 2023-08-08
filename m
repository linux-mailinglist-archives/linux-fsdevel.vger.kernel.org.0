Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B2A773694
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 04:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjHHC2u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 22:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHHC2u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:28:50 -0400
Received: from out-122.mta1.migadu.com (out-122.mta1.migadu.com [IPv6:2001:41d0:203:375::7a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A449B8
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 19:28:48 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691461726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b018wDD09q8ybQHeVjJQlHvcOhDGiPGtV/Qkh1+P4Jk=;
        b=qG+f2yssWczIj/c36Dv6lyS9LMH4Qo3IpX5TeG1prf8Sjbf2TndiPspYdq8X2q9u4a0d4+
        mAWwkzbtPW05nR7/h47VG61cI5kT4JFrqpqLlXTjX8sbawq1mwyPUSZYPolnAScsj79wmk
        u8AjZlHRxpLLihMJimmgVrAhX04JcfM=
MIME-Version: 1.0
Subject: Re: [PATCH v4 19/48] rcu: dynamically allocate the rcu-kfree shrinker
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230807110936.21819-20-zhengqi.arch@bytedance.com>
Date:   Tue, 8 Aug 2023 10:28:00 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>, david@fromorbit.com,
        tkhai@ya.ru, Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, djwong@kernel.org,
        Christian Brauner <brauner@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        yujie.liu@intel.com, Greg KH <gregkh@linuxfoundation.org>,
        simon.horman@corigine.com, dlemoal@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0C2FEFBD-B866-46C4-B684-1FB9A048B899@linux.dev>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
 <20230807110936.21819-20-zhengqi.arch@bytedance.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 7, 2023, at 19:09, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> Use new APIs to dynamically allocate the rcu-kfree shrinker.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>


