Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A04917830E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 20:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbgCCTXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 14:23:19 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:37434 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbgCCTXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:23:19 -0500
Received: by mail-il1-f195.google.com with SMTP id a6so3828664ilc.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2020 11:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KiZbLVn4oUdQq37v8gihe8HTdDkjhp2c0YGGCKWw9Xs=;
        b=cUtFbLLAYh6gx9tm2hX9XXTHNvQbYYtQzHRgoECvT1iNpNhnaqHdzCG/CIyEeLM4gL
         Z1ePPKxytHV6jrshCuDSCg/F/Y3EhjB789IMGMhvLY5BjMF12XYa9P1fenpGS3wnUpiq
         2ub+HBTb161Oel2xhswKj/mAZyHisH25WZK9vbaxjY6LTd9Hw0LO3CFy6e1A4xK6Rp8h
         B5RYOBiOga3ZtJu6UFkd/mh/wq7qjfsVdp483vXbAO26p9+WfSM398uJZlbzilANoMKh
         Fc8hK9CXNYQpui0/BpLv6RVXEYpV8KRigcO4x7aUkA1YZ0R/2aAWKkiiGy9dpnCH8Mco
         ACqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KiZbLVn4oUdQq37v8gihe8HTdDkjhp2c0YGGCKWw9Xs=;
        b=I0pGZV+QO2R8O/kWZuldolN+dZKIra3jv7xegyM56GJ3U13nhEUQ9h1VtUdbAHtP4p
         TEcNEG/kTF/08/lsNydhA1ETWB+73db71ElrRGJ9ZXL+s64eGRgsFaTgVu+mF9XdX294
         9G7MMHjxgNG1ON9J/M8eHuU9So1cAHu90h6vJEt2R7VEkj5JH9G2sEQbYs8BPJDuiXBv
         TsMAdeMvtf+ywcrSaljQz/vVekg/0bQm3VU8WFK79RczXYhMB4qMPu8xXECImAZsiH6v
         m8HIL525ZHNowvqAuQzWQCrRWXKss/PVhQhsF9qbjbwN4VQiaYbmjvjBcoiYZ8Zp9YmI
         kbgA==
X-Gm-Message-State: ANhLgQ18U/Lnx0zOQyjVKW9FRjwrJ/QK4fc+E6W1avuQSgrGTHCN2zE+
        o7oXmwk8jnSdPgH/w9fqRSIeWw==
X-Google-Smtp-Source: ADFU+vsGYrEKxsUpTqs5b+dGZi3gm2OTFxMN1tCOScyWlCXapZO1C3KKgpKNsVOR0wDn9xAFuJJT4A==
X-Received: by 2002:a92:9507:: with SMTP id y7mr1729545ilh.243.1583263398611;
        Tue, 03 Mar 2020 11:23:18 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f72sm8161736ilg.84.2020.03.03.11.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 11:23:18 -0800 (PST)
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
To:     Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk>
 <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303113814.rsqhljkch6tgorpu@ws.net.home>
 <20200303130347.GA2302029@kroah.com> <20200303131434.GA2373427@kroah.com>
 <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com>
 <20200303134316.GA2509660@kroah.com> <20200303141030.GA2811@kroah.com>
 <CAG48ez3Z2V8J7dpO6t8nw7O2cMJ6z8vwLZXLAoKGH3OnCb-7JQ@mail.gmail.com>
 <20200303142407.GA47158@kroah.com>
 <030888a2-db3e-919d-d8ef-79dcc10779f9@kernel.dk>
 <acb1753c78a019fb0d54ba29077cef144047f70f.camel@kernel.org>
 <7a05adc8-1ca9-c900-7b24-305f1b3a9b86@kernel.dk>
 <dbb06c63c17c23fcacdd99e8b2266804ee39ffe5.camel@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dc84aa00-e570-8833-cf9f-d1001c52dd7a@kernel.dk>
Date:   Tue, 3 Mar 2020 12:23:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <dbb06c63c17c23fcacdd99e8b2266804ee39ffe5.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/3/20 12:02 PM, Jeff Layton wrote:
> Basically, all you'd need to do is keep a pointer to struct file in the
> internal state for the chain. Then, allow userland to specify some magic
> fd value for subsequent chained operations that says to use that instead
> of consulting the fdtable. Maybe use -4096 (-MAX_ERRNO - 1)?

BTW, I think we need two magics here. One that says "result from
previous is fd for next", and one that says "fd from previous is fd for
next". The former allows inheritance from open -> read, the latter from
read -> write.

-- 
Jens Axboe

