Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65E71A5869
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 15:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfIBNwm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 09:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730418AbfIBNwm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:52:42 -0400
Received: from [192.168.0.111] (unknown [180.111.100.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D15621897;
        Mon,  2 Sep 2019 13:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567432361;
        bh=gOroYR0C5WTKOPu/VQ5CFcFa5lQQvYa++hC+79eQH/s=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=E3s8rI8tch1TVAzcgD5OWZZEOzgqwPPkjn9lFP0l3a86miClAmSD7sW/vGDeQeo4E
         kFk1hwJddCNd0nS6dWRYlB397xGjb7rBbX3Jp4CLXwCWWKaiUYRxp3YzNQc2lL7/7L
         XpNaXqFE1v92DhuZzZgnOEy87oZHgv8QzzWvN8VU=
Subject: Re: [PATCH v8 11/24] erofs: introduce xattr & posixacl support
To:     dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <gaoxiang25@huawei.com>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Richard Weinberger <richard@nod.at>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
References: <20190815044155.88483-1-gaoxiang25@huawei.com>
 <20190815044155.88483-12-gaoxiang25@huawei.com>
 <20190902125711.GA23462@infradead.org> <20190902130644.GT2752@suse.cz>
From:   Chao Yu <chao@kernel.org>
Message-ID: <813e1b65-e6ba-631c-6506-f356738c477f@kernel.org>
Date:   Mon, 2 Sep 2019 21:51:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190902130644.GT2752@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-9-2 21:06, David Sterba wrote:
> On Mon, Sep 02, 2019 at 05:57:11AM -0700, Christoph Hellwig wrote:
>>> +config EROFS_FS_XATTR
>>> +	bool "EROFS extended attributes"
>>> +	depends on EROFS_FS
>>> +	default y
>>> +	help
>>> +	  Extended attributes are name:value pairs associated with inodes by
>>> +	  the kernel or by users (see the attr(5) manual page, or visit
>>> +	  <http://acl.bestbits.at/> for details).
>>> +
>>> +	  If unsure, say N.
>>> +
>>> +config EROFS_FS_POSIX_ACL
>>> +	bool "EROFS Access Control Lists"
>>> +	depends on EROFS_FS_XATTR
>>> +	select FS_POSIX_ACL
>>> +	default y
>>
>> Is there any good reason to make these optional these days?
> 
> I objected against adding so many config options, not to say for the
> standard features. The various cache strategies or other implementation
> details have been removed but I agree that making xattr/acl configurable
> is not necessary as well.

I can see similar *_ACL option in btrfs/ext4/xfs, should we remove them as well
due to the same reason?

Thanks,

> 
