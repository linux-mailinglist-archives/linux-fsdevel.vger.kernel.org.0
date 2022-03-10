Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6A44D3ED6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 02:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbiCJBl3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 20:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiCJBl2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:41:28 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEF79BAE6;
        Wed,  9 Mar 2022 17:40:27 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0V6m1KrN_1646876422;
Received: from 30.225.24.63(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V6m1KrN_1646876422)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Mar 2022 09:40:23 +0800
Message-ID: <3e942459-bb15-6322-10ae-dbadb09dd72c@linux.alibaba.com>
Date:   Thu, 10 Mar 2022 09:40:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v2 01/19] fscache: export fscache_end_operation()
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
 <164678190346.1200972.7453733431978569479.stgit@warthog.procyon.org.uk>
 <9132b97b5e52fec9c2838b31739175619df3e752.camel@kernel.org>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <9132b97b5e52fec9c2838b31739175619df3e752.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/9/22 11:26 PM, Jeff Layton wrote:
> On Tue, 2022-03-08 at 23:25 +0000, David Howells wrote:
>> From: Jeffle Xu <jefflexu@linux.alibaba.com>
>>
>> Export fscache_end_operation() to avoid code duplication.
>>
>> Besides, considering the paired fscache_begin_read_operation() is
>> already exported, it shall make sense to also export
>> fscache_end_operation().
>>
> 
> Not what I think of when you say "exporting" but the patch itself looks
> fine.
> 

Yes, maybe "fscache: make fscache_end_operation() generally available"
as David said shall be better...

-- 
Thanks,
Jeffle
