Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F736A79C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 04:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCBDAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 22:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCBDAm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:00:42 -0500
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320733C790;
        Wed,  1 Mar 2023 19:00:39 -0800 (PST)
X-QQ-mid: bizesmtp78t1677725772tk8jj3m4
Received: from [10.4.23.76] ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 02 Mar 2023 10:56:11 +0800 (CST)
X-QQ-SSF: 01400000000000I0Z000000A0000000
X-QQ-FEAT: I8hG9CuxGDI8RgNbmt91L6VRJG5I7OKfHsGeL4b/xn3lN3jr5ygkvWUrwfvd6
        OxHnJIhC6zQ1M3pYOuNLH63VEKZx196Ajv4/ik1JYsOkWqpEgSjxtcg8jnRLpaFmW0ghgS6
        OtoH/1Mdn0LoYajsY+6gxlZcl47yEoUI/Qo0r/COy6pIqp5aW3bNTAL3wB8/iRf6xdBXTPc
        CPhFnlIIB3iP1BMPQWTqhCoHvnzcB8koaDB/Opcgn/1jDafMjkdc6LyppB4hqRxlZKT4HDu
        vVL3a10MqlBF+GLOT5rYNWjnpcKbaP4Fw+NnYHSkdvuhv5W6ANZ+LxR0AgLK6MHGyC2wEbC
        WyY3SCgjCFnRK6qOr0FyBXJ8iO6iTcAACkEV9HMT9dzUg46O/LFz3iatrLYxe4g258vCgBb
        JBb1fmZDh40=
X-QQ-GoodBg: 1
Message-ID: <7B4C8B8B94D621CB+fbf73a3a-6a10-5fbc-e5e5-87e2f56f6878@uniontech.com>
Date:   Thu, 2 Mar 2023 10:56:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 1/2] fs/proc: optimize register ctl_tables
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Peng Zhang <zhangpeng362@huawei.com>,
        Joel Granados <j.granados@samsung.com>
Cc:     keescook@chromium.org, yzaikin@google.com, ebiederm@xmission.com,
        willy@infradead.org, kbuild-all@lists.01.org,
        nixiaoming@huawei.com, nizhen@uniontech.com,
        sujiaxun@uniontech.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220304112341.19528-1-tangmeng@uniontech.com>
 <202203081905.IbWENTfU-lkp@intel.com>
 <Y7xWUQQIJYLMk5fO@bombadil.infradead.org>
 <Y8iKjJYMFRSthxzn@bombadil.infradead.org>
 <Y//4B2Bw4O2umKgW@bombadil.infradead.org>
From:   Meng Tang <tangmeng@uniontech.com>
In-Reply-To: <Y//4B2Bw4O2umKgW@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/3/2 09:12, Luis Chamberlain wrote:

> That would solve the first part -- the fragile odd checks to bail out
> early.  But not the odd accounting we have to do at times. So it begs
> the question if we can instead deprecate register_sysctl_table() and
> then have a counter for us at all times. Also maybe an even simpler
> alternative may just be to see to have the nr_entries be inferred with
> ARRAY_SIZE() if count_subheaders() == 1? I haven't looked into that yet.
> 
>    Luis
> 
The current difficulty is to get the ARRAY_SIZE() of table->child table.

It would be great if have a better way to solve this problem.

      Meng
