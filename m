Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB69A1E9AEE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 02:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgFAAYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 May 2020 20:24:21 -0400
Received: from ts18-13.vcr.istar.ca ([204.191.154.188]:52014 "EHLO
        ale.deltatee.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgFAAYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 May 2020 20:24:21 -0400
X-Greylist: delayed 1458 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 May 2020 20:24:20 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Z74uNfK0Ym5ZqaEdxADt4Ndt6oocQxYkHvKwmfAtpGM=; b=NKIPuOb+LvM8rpEjsEOiK041Cu
        445U05kGiuR7JUzKp+H5+FIxHgNaRyp8p/1eKU9a4KJzE4ngE45HB2I5JuZBGQgFJ6uAa9DjTDJfK
        fB6q8LSZTU9mtUBbkqn2ACUE/Hp6hhvLvg4mt0ignezSakcCUl9aRci/DR1ZpQ+3aAJ09evntX3L7
        qSLhN3dI79mbPh0v+oXwhAgwHy4FHJppNH3xUfe8bzVtskDtgmiDRlqpQ3tHtcKlgwFSfUm602maO
        CPctl8xBNxaL8k4yPXv1H+cuOkUT2EqnwHXznWdcrZU0k71tRSD3QzwkeiK6Sw6PAvbWDYEo7DPvK
        oPXHB8OQ==;
Received: from s0106602ad0811846.cg.shawcable.net ([68.147.191.165] helo=[192.168.0.12])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jfXrx-0002hO-0D; Sun, 31 May 2020 18:00:01 -0600
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
References: <20200528054043.621510-1-hch@lst.de>
 <20200528054043.621510-10-hch@lst.de>
 <CAHk-=wgpnR9sBeie_z0xA3mYzG50Oiw1jZjyHt0eLX6p45ARvQ@mail.gmail.com>
 <20200529123239.GA28608@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <02497609-e0cf-1aca-eaab-030becf57152@deltatee.com>
Date:   Sun, 31 May 2020 17:59:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529123239.GA28608@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: netfilter-devel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, raven@themaw.net, viro@zeniv.linux.org.uk, torvalds@linux-foundation.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: Re: [PATCH 09/14] fs: don't change the address limit for
 ->write_iter in __kernel_write
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020-05-29 6:32 a.m., Christoph Hellwig wrote:
> On Thu, May 28, 2020 at 11:43:13AM -0700, Linus Torvalds wrote:
>> On Wed, May 27, 2020 at 10:41 PM Christoph Hellwig <hch@lst.de> wrote:
>>>
>>> -ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
>>> +ssize_t __kernel_write(struct file *file, const void *buf, size_t count,
>>> +               loff_t *pos)
>>
>> Please don't do these kinds of pointless whitespace changes.
>>
>> If you have an actual 80x25 vt100 sitting in a corner, it's not really
>> conducive to kernel development any more.
> 
> I have real 80x25 xterms, as that allows me to comfortably fit 4 of
> them onto my latop screen.

I second this. Doing work on a compact laptop is a legitimate use case
and we can't all lug around big monitors with our laptops. I also find
more terminals on a screen to be more productive.

I'd also like to make the point that I never thought the width limit was
all that related to the hardware. It's been widely accepted for ages
that it's easier to read narrower blocks of text (try reading a book on
a landscape tablet: it's very difficult and causes eye strain). This is
why newspapers and magazines have always laid out their text in columns
and professional websites limit the width of their content. They have
the hardware to write much longer lines but chose not to for
readability. (Sadly, the *one* news source that I respect that doesn't
do this is LWN and I have to resort to reader view in Firefox to make it
readable.)

Furthermore, I find enforcing a line length limit on newer coders is one
of the easiest ways to improve the readability of their code. Without
it, I've seen developers generate lines of code that don't even fit in
the full width of a standard monitor. Putting in a little extra effort
to try to be clear in a shorter line (or adding more lines) usually pays
off in spades for readability. Or, it at least gets them to start
thinking about readability as an important concern. 90% of the time it
is better to refactor code that doesn't fit comfortably within the line
length limit than it is to violate it.

I personally set my terminal size to 80 chars because I believe it helps
the readability of the code I write. It has nothing to do with the width
of my monitor or the amount of characters I could theoretically fit
across my screen.

Logan
