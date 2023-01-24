Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8BE678C8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 01:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjAXAIX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 19:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjAXAIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:08:17 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1408E045;
        Mon, 23 Jan 2023 16:08:15 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Va6AQFk_1674518890;
Received: from 30.32.80.196(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Va6AQFk_1674518890)
          by smtp.aliyun-inc.com;
          Tue, 24 Jan 2023 08:08:11 +0800
Message-ID: <339d2a18-1c5b-998b-29f5-830d8904bcb3@linux.alibaba.com>
Date:   Tue, 24 Jan 2023 08:08:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Giuseppe Scrivano <gscrivan@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <cover.1674227308.git.alexl@redhat.com>
 <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <87ilh0g88n.fsf@redhat.com>
 <321dfdb1-3771-b16d-604f-224ce8aa22cf@linux.alibaba.com>
 <878rhvg8ru.fsf@redhat.com>
 <3ae1205a-b666-3211-e649-ad402c69e724@linux.alibaba.com>
 <87sfg3ecv5.fsf@redhat.com>
 <31fc4be5-0e53-b1fb-9a2c-f34d598c0fe7@linux.alibaba.com>
 <87cz77djte.fsf@redhat.com> <878rhuewy0.fsf@redhat.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <878rhuewy0.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/1/22 17:32, Giuseppe Scrivano wrote:
> Giuseppe Scrivano <gscrivan@redhat.com> writes:
> 

...

>>
>> How does validation work in EROFS for files served from fscache and that
>> are on a remote file system?
> 
> nevermind my last question, I guess it would still go through the block
> device in EROFS.
> This is clearly a point in favor of a block device approach that a
> stacking file system like overlay or composefs cannot achieve without
> support from the underlying file system.

nevermind my last answer,

I was thinking with Amir's advice, you could just use FUSE+overlayfs option
for this. I wonder if such option can meet all your requirements (including
unprivileged mounts) without increasing on-disk formats in kernel to do
unprivileged mounts.

If there are still missing features, you could enhance FUSE or overlayfs.

Thanks,
Gao Xiang
