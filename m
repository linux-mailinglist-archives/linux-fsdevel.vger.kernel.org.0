Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A8472FB62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 12:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbjFNKmB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 06:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243184AbjFNKli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:41:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33AE31FD6;
        Wed, 14 Jun 2023 03:41:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 503AE1FB;
        Wed, 14 Jun 2023 03:42:19 -0700 (PDT)
Received: from [10.57.74.148] (unknown [10.57.74.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4D793F71E;
        Wed, 14 Jun 2023 03:41:33 -0700 (PDT)
Message-ID: <57fefe22-440e-4ce1-2e34-5494f2cce893@arm.com>
Date:   Wed, 14 Jun 2023 11:41:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v1 0/2] Report on physically contiguous memory in smaps
To:     Yu Zhao <yuzhao@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230613160950.3554675-1-ryan.roberts@arm.com>
 <ZIi5JnOOffcsoVL0@google.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZIi5JnOOffcsoVL0@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/06/2023 19:44, Yu Zhao wrote:
> On Tue, Jun 13, 2023 at 05:09:48PM +0100, Ryan Roberts wrote:
>> Hi All,
>>
>> I thought I would try my luck with this pair of patches...
> 
> Ack on the idea.
> 
> Actually I have a script to do just this, but it's based on pagemap (attaching the script at the end).

I did consider that approach, but it was much more code to write the script than
to modify smaps ;-). Longer term, I think it would be good to have it in smaps
because its more accessible. For the contpte case we would need to add a bit to
every pagemap entry to express that. I'm not sure how palletable that would be
for a arch-specific thing?

Thanks for the script anyway!


