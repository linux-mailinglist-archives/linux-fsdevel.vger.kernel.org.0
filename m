Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC4F11D9AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 23:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbfLLWuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 17:50:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34926 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730707AbfLLWuD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z35C5KvkFaXtsq++gd9LaBNy9EzUqvGOEvfQ9q1Iyc4=; b=Rb/kVlm9RYoH32rjzoL52rvrg
        M2Twe3ZUJ3oXF/D0iJVdUsuck4FS55+heBLF1NVhwdy0tHkXqxZDXDNjdqlxHZq94RkbDpJi9zROy
        wJoCmdFcutxOiUIwj0LO1YbFadXXVxA2GDKhc7ryl2C/dcbnUj8KBLWTlP+m5tUdugfv/M/MooSC5
        QWW5oxFK7b0+nXYfm9cYtpWhIzB8tLRuDPd22eZ3KevnVqpKV8zguHgf0L3K7iSvi3N4ZyADDcKKq
        LVzdawisvEftVlNLbZNQWPjq+HzIKtHtHkNHmJZJTQszrq3xZnjnP5/gVtUduxrhQI5P1gCmHC+N6
        D0lOzzmHQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifXHW-0006uZ-He; Thu, 12 Dec 2019 22:50:02 +0000
Subject: Re: [PATCHv2] vfs: Handle file systems without ->parse_params better
To:     Laura Abbott <labbott@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-kernel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
References: <20191212224139.15970-1-labbott@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fae0b08a-17ac-385b-5f2f-b63ceeeae89a@infradead.org>
Date:   Thu, 12 Dec 2019 14:50:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191212224139.15970-1-labbott@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

typo:

On 12/12/19 2:41 PM, Laura Abbott wrote:
> +/**
> + * ignore_unknowns_parse_param - ->parse_param function for a file system that

      ignore_unknown_parse_param

> + * takes no arguments
> + * @fc: The filesystem context
> + * @param: The parameter.
> + */
> +static int ignore_unknown_parse_param(struct fs_context *fc, struct fs_parameter *param)

thanks.
-- 
~Randy
