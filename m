Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68C289F1F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 19:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfH0R7Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 13:59:24 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45678 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbfH0R7Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:59:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id x19so32442528eda.12;
        Tue, 27 Aug 2019 10:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x4o41SOUwkOtmHwCVWP6psFoMnXDd1IA5T2C9+pANCg=;
        b=UTxnv8LU5l3FxtY05kGj30TlVLb7mTQ+34ZrwDczo0VD/knJ5kaJjcIx7ICxjYcIJr
         LcJKGuLaw/lu4l5K+OGwVVY1BKyk3v65xXCX4h49NoENt0kLMr+hebSK0xT/TU3rb/I/
         V9HHZAE7nv0YesOdPoq7djS3gB5b1BV6y3PEfth6E0TC6+rzwwXPKu+4LOTnMCQb285N
         8khPmRO0zFwFtrHUCAj1MDTnvxWCtb/I4W01gBkHteZSbNOKLS+eiYsDXnY8cTLXl/l7
         0bz6TNc9P5CLzjmsjbL93ZIdh/7axLeRtAEigc37rZzopm2fU3+oB84A2QLPCFiJjTRt
         ROtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x4o41SOUwkOtmHwCVWP6psFoMnXDd1IA5T2C9+pANCg=;
        b=B/C4Zd/qQSgNHG68cGJ8rOXwvbDgNuvtEP9pDZs8vuxDoI8/8QnEsEBtNHwBhynbKC
         eD3mStbLFbo/gPyRTeQtvBF2SADwOwCM1TdvQWVAH0LLW2QEmS4cNu08r7lbY3unmTww
         21vnc52+Fimy5T10lp7mYu4NAhEMLQb6mDOsy1X+lo5PhP9FkBPpOjiJh6R9s4H0RuQj
         qlx9uuZXV4GKNm9A8gOeAHzYLuf80baUmgtVC1NXr+9i+mBWROpjO7M1fdDG9roSwr9J
         M6cZJZclMqUXGotAPYbNJx/6c2cRXenXtfDf0dCc4Xb/PXnB86sfRZaiweaMgGsNkjgO
         Y5Og==
X-Gm-Message-State: APjAAAXg3dL8HaYlosgziyO1cEPLJ+tAtV7XN/zBZv1/gRK9ISgfG/W1
        BNUJ1eiNBLCvm0a/Yb1VQNT+SdK7
X-Google-Smtp-Source: APXvYqyi0GeQmFG8oVL9cqTwEuNttX00ODANeVxL7v3aMEdpp0Jua5gWCf+LBm+wp5B0lAFgRArHtQ==
X-Received: by 2002:a17:906:7c49:: with SMTP id g9mr22316662ejp.262.1566928762389;
        Tue, 27 Aug 2019 10:59:22 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.211.18])
        by smtp.gmail.com with ESMTPSA id g3sm2065ejj.69.2019.08.27.10.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2019 10:59:21 -0700 (PDT)
Subject: Re: [RFC] Re: broken userland ABI in configfs binary attributes
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Boaz Harrosh <boaz@plexistor.com>
Cc:     =?UTF-8?Q?Kai_M=c3=a4kisara_=28Kolumbus=29?= 
        <kai.makisara@kolumbus.fi>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi@vger.kernel.org
References: <20190826024838.GN1131@ZenIV.linux.org.uk>
 <20190826162949.GA9980@ZenIV.linux.org.uk>
 <B35B5EA9-939C-49F5-BF65-491D70BCA8D4@kolumbus.fi>
 <20190826193210.GP1131@ZenIV.linux.org.uk>
 <b362af55-4f45-bf29-9bc4-dd64e6b04688@plexistor.com>
 <20190827172734.GS1131@ZenIV.linux.org.uk>
From:   Boaz Harrosh <openosd@gmail.com>
Message-ID: <58f07f20-b989-754e-9e18-e9bb464b7a2f@gmail.com>
Date:   Tue, 27 Aug 2019 20:59:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827172734.GS1131@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27/08/2019 20:27, Al Viro wrote:
<>
> If you want to express something like "data packet formed; now you can commit
> it and tell me if there'd been any errors", use something explicit.  close()
> simply isn't suitable for that.  writev() for datagram-like semantics might
> be; fsync() or fdatasync() could serve for "commit now".
> 

Yes! I change my mind you are right. close() should stay with void semantics.
I always thought the IO error reporting on close was a bad POSIX decision and
fsync should be the final resting bed, and if you do not call fsync then you
don't care about the error.

Sigh, looks like the error was for ever ignored from day one. Maybe the Kernel
guys felt the errors were important. But application users of configfs, did any
actually care and check? Is there really a regression here? maybe the current imp
needs to just be documented.
(Or the more blasphemous, change the ABI and force people to call fsync or something)

I feel the frustration too
Boaz
