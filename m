Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795B725720F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 05:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgHaDRH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Aug 2020 23:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgHaDRG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:17:06 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE493C061573
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2020 20:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=cV8UCsmbIvdSRKOXashjkAqyBAv+yNGcbG4WjUBcpCU=; b=kIRj6bcofLeTbiOuBbjdnQ/yd0
        sCGiFrWoa7sybC74QefgKV7g9XoQuJSd2r5A8XPy8ynj81qXfR2mN9zmPNpY8qd+YUWNkVmXIXfRQ
        Nak9qVh6FWOk6AMiqSDr8gX3tQiXkGuCCLZkFeyjXIm1QA+OhvJBxHfFGsigdZWFURQty8csQguFT
        DPYdpEscOCrN1kAcv6jcuGU5Y0FuSvx7o+2r6+PLlu4dpJCFS7orM/L5jjx6gqmmQrOKzO0uTUyeX
        2C52yMnN/LUYkOzjz+ck6lPBAtm8+cNOsvgF5Bl3ZhSIjHyX9pfcgPdgG1s2ui1ou8lq9AGPtGy6V
        VqvS3VJQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCaJX-000897-Cc; Mon, 31 Aug 2020 03:16:59 +0000
Subject: Re: [PATCH] fs/xattr.c: fix kernel-doc warnings for setxattr &
 removexattr
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        Chuck Lever <chuck.lever@oracle.com>
References: <7a3dd5a2-5787-adf3-d525-c203f9910ec4@infradead.org>
 <20200830183230.35f8904e05a8f0f1a3ab025e@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dcfda64e-8676-663b-4ad9-e75c9d7a4dcd@infradead.org>
Date:   Sun, 30 Aug 2020 20:16:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200830183230.35f8904e05a8f0f1a3ab025e@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/30/20 6:32 PM, Andrew Morton wrote:
> On Sun, 30 Aug 2020 17:30:08 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix kernel-doc warnings in fs/xattr.c:
>>
>> ../fs/xattr.c:251: warning: Function parameter or member 'dentry' not described in '__vfs_setxattr_locked'
>> ../fs/xattr.c:251: warning: Function parameter or member 'name' not described in '__vfs_setxattr_locked'
>> ../fs/xattr.c:251: warning: Function parameter or member 'value' not described in '__vfs_setxattr_locked'
>> ../fs/xattr.c:251: warning: Function parameter or member 'size' not described in '__vfs_setxattr_locked'
>> ../fs/xattr.c:251: warning: Function parameter or member 'flags' not described in '__vfs_setxattr_locked'
>> ../fs/xattr.c:251: warning: Function parameter or member 'delegated_inode' not described in '__vfs_setxattr_locked'
>> ../fs/xattr.c:458: warning: Function parameter or member 'dentry' not described in '__vfs_removexattr_locked'
>> ../fs/xattr.c:458: warning: Function parameter or member 'name' not described in '__vfs_removexattr_locked'
>> ../fs/xattr.c:458: warning: Function parameter or member 'delegated_inode' not described in '__vfs_removexattr_locked'
>>
>> Fixes: 08b5d5014a27 ("xattr: break delegations in {set,remove}xattr")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: stable@vger.kernel.org # v4.9+
> 
> hm, are kerneldoc warning fixes -stable material?
> 

I don't know.
I only added that because the commit that it fixes had that Cc: line also.

From my (just now) reading of stable-kernel-rules.rst, the answer is No.

-- 
~Randy

