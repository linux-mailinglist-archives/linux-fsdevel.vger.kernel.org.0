Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7586B3680
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 07:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCJGVD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 01:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCJGVC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 01:21:02 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EE3F16AA;
        Thu,  9 Mar 2023 22:21:00 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VdWCdER_1678429253;
Received: from 30.97.48.46(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdWCdER_1678429253)
          by smtp.aliyun-inc.com;
          Fri, 10 Mar 2023 14:20:55 +0800
Message-ID: <bbd8c221-d4d2-8bbf-944f-2f33ed80f02f@linux.alibaba.com>
Date:   Fri, 10 Mar 2023 14:20:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 2/5] erofs: convert to use i_blockmask()
To:     Yangtao Li <frank.li@vivo.com>, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org
References: <e8054874-88d8-e539-8fd4-6123821aa3a8@linux.alibaba.com>
 <20230310061549.11254-1-frank.li@vivo.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230310061549.11254-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/3/10 14:15, Yangtao Li wrote:
> Hi Gao Xiang,
> 
>> Please help drop this one since we'd like to use it until i_blockmask() lands to upstream.
> 
> I'm OK. Not sure if I need to resend v5?

Thanks, your patch looks fine to me.  The main reasons are that
  1) active cross tree development on cleanup stuffs;
  2) we'd like to add subpage block support for the next cycle,
     and they seem somewhat convolved...

So I will apply your patch when i_blockmask() is landed upstream
then.

Thanks,
Gao Xiang

> 
> Thx,
> Yangtao
