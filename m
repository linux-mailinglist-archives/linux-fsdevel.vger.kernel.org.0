Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56582A1E52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 17:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfH2PFx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 11:05:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfH2PFx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:05:53 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C217D4FCCE
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2019 15:05:52 +0000 (UTC)
Received: by mail-ed1-f71.google.com with SMTP id z25so2368208edm.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2019 08:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nw2mlLM8bc9FI0d2sEqKTqg4PUH87WdFGKW7OFJalq8=;
        b=DFMFku3efEK7chRWCDvmGllqFiXSxSfXv2FOOcbwMQkQEbRGf4W6bPAaEOED+ec+RJ
         Xx3zqZiHtpuyyexeW5jJL0w/rf4MoBivRAndoVl/NRk6JhyjkM5yhMliEzf7dl5B+DUl
         WoVW3xsBWBV3I4S4uTinyxQyZfciN45UyPpBpS9QYDsk1VG8vihaad5q6OWTrP7h57Cf
         gagGazGLPgN5vMzid+FJM02e+YAFmKuOzPduKW7pWrN53BIWzkeO3L1aRnuafG+N8iwj
         hJcFN57420FpjmKWkwEd8dyZFW3aBQKW5ldP11DDsSYyfExgQfmV7G+nY2gpmZjcmJK6
         6f8w==
X-Gm-Message-State: APjAAAXywwxABjemYNC5vhMreei5EfXpSvDuSuAaFHow2ZoKQI1F1EEj
        V23aDLv/+V9naEtAHmXExnkzW3IDuqvrLvkP48GxOlNmtUKAfWH/AgAq/Bv0y8VmDBhVBPHReCV
        b1ggj0P2RvAQLIVG3l3BWjbt6ig==
X-Received: by 2002:a50:9401:: with SMTP id p1mr10178778eda.189.1567091151275;
        Thu, 29 Aug 2019 08:05:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwwXwiptjjR/7c77QDkLBx0Paf9jt5kzOASqk7HklmcyE6bPBx6klxSLaAouqnf3yHZlC3aiQ==
X-Received: by 2002:a50:9401:: with SMTP id p1mr10178759eda.189.1567091151152;
        Thu, 29 Aug 2019 08:05:51 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id g11sm486363edu.4.2019.08.29.08.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 08:05:50 -0700 (PDT)
Subject: Re: Merging virtualbox shared-folder VFS driver through
 drivers/staging?
To:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
References: <f2a9c3c0-62da-0d70-4062-47d00ab530e0@redhat.com>
 <20190811074005.GA4765@kroah.com> <20190811074348.GA13485@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c8495f31-5975-d4b1-1dd4-28d01b594a9a@redhat.com>
Date:   Thu, 29 Aug 2019 17:05:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190811074348.GA13485@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

On 11-08-19 09:43, Christoph Hellwig wrote:
> On Sun, Aug 11, 2019 at 09:40:05AM +0200, Greg Kroah-Hartman wrote:
>>> Since I do not see the lack of reviewing capacity problem get solved
>>> anytime soon, I was wondering if you are ok with putting the code
>>> in drivers/staging/vboxsf for now, until someone can review it and ack it
>>> for moving over to sf/vboxsf ?
>>
>> I have no objection to that if the vfs developers do not mind.
> 
> We had really bad experiences with fs code in staging.  I think it is
> a bad idea that should not be repeated.

So after resolving the problem with the patch not making it through
to the list because of the patch-size, v12 got reviewed (thank you
for that Christoph) and I did a v13.

Then there was some discussion about read cache-coherency vs writes
done on the host side underneath us (the guest) and in the end
Christoph agreed that what was done in v13 was as good as it would
get given the limitations of the shared folder API offered by
the VirtualBox hypervisor, but Christoph did request to add a big
comment explaining these issues in more detail.

So I posted a v14, adding the big comment and addressing 2 very minor
other issue spotted by Christoph, that was 10 days ago and things
have gotten quiet again since. I realiz that 10 days is not very
long but for previous revisions I have been waiting upto 60 days
sometimes and the exfat in staging discussion reminded me of this.

So what is the plan going forward for vboxsf now?

Regards,

Hans

