Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446B86F6A11
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 13:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjEDLe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 07:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjEDLe5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 07:34:57 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813AA44B5
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 May 2023 04:34:52 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 344BYeiL072889;
        Thu, 4 May 2023 20:34:40 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Thu, 04 May 2023 20:34:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 344BYRPE072861
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 May 2023 20:34:39 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <50928469-d4fe-881d-1c38-fed869620f37@I-love.SAKURA.ne.jp>
Date:   Thu, 4 May 2023 20:34:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [bug report] fs: hfsplus: remove WARN_ON() from
 hfsplus_cat_{read,write}_inode()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org
References: <6caecd65-bd3c-45d4-8bfa-f73ddc072e94@kili.mountain>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <6caecd65-bd3c-45d4-8bfa-f73ddc072e94@kili.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/05/04 20:14, Dan Carpenter wrote:
> Hello Tetsuo Handa,
> 
> The patch 81b21c0f0138: "fs: hfsplus: remove WARN_ON() from
> hfsplus_cat_{read,write}_inode()" from Apr 11, 2023, leads to the
> following Smatch static checker warning:
> 
> 	fs/hfsplus/inode.c:596 hfsplus_cat_write_inode()
> 	warn: missing error code here? 'hfsplus_find_cat()' failed. 'res' = '0'

It has been returning 0 since commit 1da177e4c3f4 ("Linux-2.6.12-rc2").
I guess that the author of this filesystem was wondering what to do in that case.
Since this filesystem is orphaned, I don't know whom to ask.
If you think returning an error is better, please submit as a patch.

