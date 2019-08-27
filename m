Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D11499EBC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 17:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfH0PBe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 11:01:34 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:35695 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfH0PBd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:01:33 -0400
Received: by mail-wr1-f54.google.com with SMTP id k2so19175867wrq.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2019 08:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rh4dW/p/0ptDZbGvTsHkhReMwL9BApKR4ATW/fhWj0U=;
        b=YA5mA/WpJ2bUfwYghy/JbMnrzaCDhfLXowtzIUUoVpWBqlEgZ2BTchvq9N8NE7QAfk
         uarCD9Re2OubHm9NhWhQUZYkQroeNN2MC+5zCwwruM5hUiLPCL/B83GKDo/nXOIyN01E
         SfnN5eSNbeeTrgC/Wx3g6OHGMddjbpF+/jwVweARfy9A7j3CJ8+zeze7fGUXiQLYjezq
         L/e4z/aEWTx2bnQ6Q9+zkfUGobxz/F1HnRdA1ZTY8l8KFwsHs/EZ0fTX6A8fK+IdE84T
         Luo6y/iJbHrPg3KUT/h26oSkYd2OY2VUt25+bxf/HPuMPAl3RTU1SmL1YuuOGqSpOmGx
         PNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rh4dW/p/0ptDZbGvTsHkhReMwL9BApKR4ATW/fhWj0U=;
        b=rHAYxzWsJcMejyko0AZPYSehS1tZ3c428tBC8vqnm9erDyRKp7fy+aXJBQebFatkuo
         s0aC4TpimOaTkO3HgG3A5z81phigAsAE/KpiiPVE4kLkUYus3rFITadjcyX+n9ou4i34
         9jTKp/eHtp7yGLan52ND5i2UV2CDqXCKpVrTVQ4zFgGz6Iqf0GU+YVTv4lMPyw0fXQXK
         A1xcNc+JvcUoVCQ0PuY3epumPoLGTurnBmhUV5Hvxkz7P/yPl/256e0SkJjzaZ3HFtQa
         t6TkjZ/tLZR91F6BPttyKCxD1h0K15ZrCLiQ0iYMjZ0y2u5wMZ+Q12CPv0RxIYYnWjaP
         d1WA==
X-Gm-Message-State: APjAAAUBJzAqejVB5RFSS5zy5z3R/HnGMFecrbUBIeT4U35s9hkOVE1P
        MiQBS1LhuX6im16WAFyvJ0RvxQ==
X-Google-Smtp-Source: APXvYqxALOqf+EnAXERTJqYNuB9QwId0e76VhksXmlnbeqSA3iEQW9rErg7i0v0A0rcSfXhaat/YHA==
X-Received: by 2002:a5d:60c1:: with SMTP id x1mr5251694wrt.75.1566918091981;
        Tue, 27 Aug 2019 08:01:31 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.211.18])
        by smtp.googlemail.com with ESMTPSA id t8sm38019169wra.73.2019.08.27.08.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2019 08:01:30 -0700 (PDT)
Subject: Re: [RFC] Re: broken userland ABI in configfs binary attributes
To:     Al Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?Q?Kai_M=c3=a4kisara_=28Kolumbus=29?= 
        <kai.makisara@kolumbus.fi>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi@vger.kernel.org
References: <20190826024838.GN1131@ZenIV.linux.org.uk>
 <20190826162949.GA9980@ZenIV.linux.org.uk>
 <B35B5EA9-939C-49F5-BF65-491D70BCA8D4@kolumbus.fi>
 <20190826193210.GP1131@ZenIV.linux.org.uk>
From:   Boaz Harrosh <boaz@plexistor.com>
Message-ID: <b362af55-4f45-bf29-9bc4-dd64e6b04688@plexistor.com>
Date:   Tue, 27 Aug 2019 18:01:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826193210.GP1131@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26/08/2019 22:32, Al Viro wrote:
<>
> D'oh...  OK, that settles it; exclusion with st_write() would've been
> painful, but playing with the next st_write() on the same struct file
> rewinding the damn thing to overwrite what st_flush() had spewed is
> an obvious no-go.
> 

So what are the kind of errors current ->release implementation is trying to return?
Is it actual access the HW errors or its more of a resource allocations errors?
If the later then maybe the allocations can be done before hand, say at ->flush but
are not redone on redundant flushes?

If the former then yes looks like troubles. That said I believe the 
->last_close_with_error() is a very common needed pattern which few use exactly
because it does not work. But which I wanted/needed many times before.

So I would break some eggs which ever is the most elegant way, and perhaps add a
new parameter to ->flush(bool last) or some other easy API.
[Which is BTW the worst name ever, while at it lets rename it to ->close() which
 is what it is. "flush" is used elsewhere to mean sync.
]

So yes please lets fix VFS API with drivers so to have an easy and safe way
to execute very last close, all the while still being able to report errors to
close(2).

My $0.017 Thanks
Boaz
