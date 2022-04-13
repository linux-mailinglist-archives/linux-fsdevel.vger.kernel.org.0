Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B0F4FED5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 05:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiDMDNJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 23:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiDMDMY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:12:24 -0400
Received: from out199-13.us.a.mail.aliyun.com (out199-13.us.a.mail.aliyun.com [47.90.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDE8DED9
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 20:10:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V9xUX8f_1649819396;
Received: from 30.225.24.103(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V9xUX8f_1649819396)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Apr 2022 11:09:57 +0800
Message-ID: <6d6ac8d4-5c25-a0ec-fc03-38546ab41f75@linux.alibaba.com>
Date:   Wed, 13 Apr 2022 11:09:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH] fuse: avoid unnecessary spinlock bump
Content-Language: en-US
To:     Vivek Goyal <vgoyal@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     miklos@szeredi.hu, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
        Dharmendra Singh <dsingh@ddn.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
 <Yk7w8L1f/yik+qrR@redhat.com>
 <b7a50fac-0259-e56c-0445-cca3fbf99888@linux.alibaba.com>
 <YlAbqF4Yts8Aju+W@redhat.com>
 <586dd7bb-4218-63da-c7db-fe8d46f43cde@linux.alibaba.com>
 <YlAlR0xVDqQzl98w@redhat.com>
 <d5c1b2bc-78d1-c6f8-0fb0-512a702b6e3b@linux.alibaba.com>
 <YlQWkGl1YQ+ioDas@redhat.com>
 <3f6a9a7a-90e3-e9fd-b985-3e067513ecea@linux.alibaba.com>
 <afc2f1ec-8aff-35fa-5fde-75852db7b4a8@fastmail.fm>
 <YlQ0cT/BOzHi8Q1b@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YlQ0cT/BOzHi8Q1b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/11/22 10:00 PM, Vivek Goyal wrote:
> On Mon, Apr 11, 2022 at 03:20:05PM +0200, Bernd Schubert wrote:
> 
> So for testing DAX, I have to rely on out of tree patches from qemu
> here if any changes in virtiofs client happen.
> 
> https://gitlab.com/virtio-fs/qemu/-/tree/virtio-fs-dev
> 
> Jeffle is probably relying on their own virtiofsd implementation for DAX
> testing.
> 

Actually I also use the C version virtiofsd in the above described
repository for testing :)

-- 
Thanks,
Jeffle
