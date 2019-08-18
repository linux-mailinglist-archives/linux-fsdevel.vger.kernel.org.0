Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 278A891614
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 12:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfHRKNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 06:13:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbfHRKNF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 06:13:05 -0400
Received: from [192.168.0.101] (unknown [180.111.132.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92D3C2146E;
        Sun, 18 Aug 2019 10:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566123184;
        bh=FEJ0D22QdNqnoKVDg6XJ8v/pgAIJ+yN/b9/Sje9fAog=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e6vO1cbRmb5/UacRY1GhawsTwpzh/wGW7wMXmpyMOmit8gY/AvqEFAZLbgm5W4iYl
         OMjAyzYabjvm1WcK8/wAYbkKpw5Gxe6qwSfd6SWh7cOAiSa0DBWY6uJehHu57cxtHj
         iCxqsdt6Ivupp269p105juxK5aaCnmSZQ1OlSu84=
Subject: Re: [PATCH] erofs: move erofs out of staging
To:     Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>,
        devel <devel@driverdev.osuosl.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Darrick <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>, tytso <tytso@mit.edu>,
        torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>, Pavel Machek <pavel@denx.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-erofs <linux-erofs@lists.ozlabs.org>
References: <20190817082313.21040-1-hsiangkao@aol.com>
 <20190817220706.GA11443@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1163995781.68824.1566084358245.JavaMail.zimbra@nod.at>
 <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1405781266.69008.1566116210649.JavaMail.zimbra@nod.at>
 <20190818084521.GA17909@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at>
 <20190818090949.GA30276@kroah.com>
 <790210571.69061.1566120073465.JavaMail.zimbra@nod.at>
From:   Chao Yu <chao@kernel.org>
Message-ID: <8319896b-22c1-0550-f464-f4419a70202e@kernel.org>
Date:   Sun, 18 Aug 2019 18:12:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <790210571.69061.1566120073465.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Richard,

On 2019-8-18 17:21, Richard Weinberger wrote:
> For normal use I see no problem at all.
> I fear distros that try to mount anything you plug into your USB.
> 
> At least SUSE already blacklists erofs:
> https://github.com/openSUSE/suse-module-tools/blob/master/suse-module-tools.spec#L24

Thanks for letting us know current status of erofs in SUSE distro.

Currently erofs cares more about the requirement of Android, in there, we are
safe on fuzzed image case as dm-verity can keep all partition data being
verified before mount.

For other scenarios, like distro, erofs should improve itself step by step as
many mainline filesystems in many aspects to fit the there-in requirement. :)

Thanks,

> 
> Thanks,
> //richard
> 
