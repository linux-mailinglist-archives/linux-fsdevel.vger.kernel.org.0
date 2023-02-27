Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3F26A40BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 12:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjB0Lhz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 06:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjB0Lhy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:37:54 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788242D6B
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 03:37:52 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VcdF2tm_1677497869;
Received: from 30.221.131.188(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VcdF2tm_1677497869)
          by smtp.aliyun-inc.com;
          Mon, 27 Feb 2023 19:37:49 +0800
Message-ID: <b95785a0-acd7-c5a7-0344-fde3135025e5@linux.alibaba.com>
Date:   Mon, 27 Feb 2023 19:37:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
To:     Alexander Larsson <alexl@redhat.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
Content-Language: en-US
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/27/23 5:22 PM, Alexander Larsson wrote:
> Hello,
> 
> Recently Giuseppe Scrivano and I have worked on[1] and proposed[2] the
> Composefs filesystem. It is an opportunistically sharing, validating
> image-based filesystem, targeting usecases like validated ostree
> rootfs:es, validated container images that share common files, as well
> as other image based usecases.
> 
> During the discussions in the composefs proposal (as seen on LWN[3])
> is has been proposed that (with some changes to overlayfs), similar
> behaviour can be achieved by combining the overlayfs
> "overlay.redirect" xattr with an read-only filesystem such as erofs.
> 
> There are pros and cons to both these approaches, and the discussion
> about their respective value has sometimes been heated. We would like
> to have an in-person discussion at the summit, ideally also involving
> more of the filesystem development community, so that we can reach
> some consensus on what is the best apporach.
> 
> Good participants would be at least: Alexander Larsson, Giuseppe
> Scrivano, Amir Goldstein, David Chinner, Gao Xiang, Miklos Szeredi,
> Jingbo Xu.
> 
> [1] https://github.com/containers/composefs
> [2] https://lore.kernel.org/lkml/cover.1674227308.git.alexl@redhat.com/
> [3] https://lwn.net/SubscriberLink/922851/45ed93154f336f73/
> 

I'm quite interested in the topic and would be glad to attend the
discussion if possible.

Thanks.

-- 
Thanks,
Jingbo
