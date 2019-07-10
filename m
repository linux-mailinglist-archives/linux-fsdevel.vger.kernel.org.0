Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA2CC64AF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 18:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfGJQtt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 12:49:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48956 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfGJQtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 12:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=a8Magxb04BgDjSI4OQWgNmwKyRSckuRhLmFaoPzvT5w=; b=RPALncVmFFKUm7YFTHnRLEd/gj
        lV+8UPCdlZC4Du5HZLEZQ1hW7NnQEPr1CCoCPtgDO0XZqHQ/+XPjwD+lpQyGDaWQEyY9ngiBB8Nxi
        vmMVXXafwIhouY4/BtEsDjwA3xSxFil/fO6JeIyBRlJfl+BAvcRCYyH33t9xCT0examCUw5OWhStb
        DOInsCH0DlNkjLNmEzVBVd+j8IrFJgSkSkHmS74CD6p3w466qAHoZT3daKgjHaEyy0oL1DeD+Z5wk
        dwqakfkclQ9A3QbSSFoNuZfjnwJBzkkoOHHzHgz+WhuGYqg/YBDjNlmUA5sYMUA86ulAH97x4P1pk
        gIHK+rgg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlFmp-0006Qo-TU; Wed, 10 Jul 2019 16:49:44 +0000
Subject: Re: [RFC PATCH] fanotify, inotify, dnotify, security: add security
 hook for fs notifications
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>, paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        amir73il@gmail.com, jmorris@namei.org, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
References: <20190710133403.855-1-acgoide@tycho.nsa.gov>
 <4fd98c88-61a6-a155-5028-db22a778d3c1@schaufler-ca.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cb754dda-fbce-8169-4cd7-eef66e8d809e@infradead.org>
Date:   Wed, 10 Jul 2019 09:49:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <4fd98c88-61a6-a155-5028-db22a778d3c1@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/10/19 9:38 AM, Casey Schaufler wrote:
> On 7/10/2019 6:34 AM, Aaron Goidel wrote:

>> @@ -3261,6 +3262,26 @@ static int selinux_inode_removexattr(struct dentry *dentry, const char *name)
>>  	return -EACCES;
>>  }
>>  
>> +static int selinux_inode_notify(struct inode *inode, u64 mask)
>> +{
>> +	u32 perm = FILE__WATCH; // basic permission, can a watch be set?
> 
> We don't use // comments in the Linux kernel.
> 

I thought that we had recently moved into the 21st century on that issue,
but I don't see it mentioned in coding-style.rst.  Maybe we need a Doc update.

checkpatch allows C99 comments by default.
Joe, do you recall about this?

thanks.
-- 
~Randy
