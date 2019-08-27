Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A92AB9E32A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 10:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfH0Ivx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 04:51:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33907 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfH0Ivx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:51:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id e8so1884852wme.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2019 01:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=obbphlkN6ykP/KdmqbYfsg3oTcGd3iFpETWj0g0XTsU=;
        b=jI0/TfAt2Xq/6UAPmenbMwMcjIXCUscJUW2goD5o6M9aL7c6kQiitWet/puyzYM9Av
         yjvVx0OAL7WDjNkimUQJok5WQeScPA50JgHu27GVSDVBUUoQA0C2KLQdqbZasIqmNgDS
         VEGWcmDmsprB/oayZMoQU1OrIGt14tyuoo0KY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=obbphlkN6ykP/KdmqbYfsg3oTcGd3iFpETWj0g0XTsU=;
        b=HkikvEbfW6qWv1jKwWj2XBO7N4rIV27a4OODtfkAHtsOQjTQ/HfdM6iLKtwgp+mwFB
         tbOpjU3FhjLd2FrUtWk1x/f4Hu/M/r4GmHQdmWLxDCsftITBUc4uUvakkv0Pe1H8zurH
         zSjGTQMHu6Z3MO7YQzuQ41Lik9LP6HFzZUegs4eTfnnJGMNMxiazlvkZ4bvJkQUyDccf
         9UCGVTp/dv2hmTRVOKYxgnHuc3tVFXc/Qu8VZ6QKn88mPlU+hKPVnVAclFCTBkienDr2
         6eQeTANveWw4NE0QvpBp5UwFskYhTqATSPu1BGYISg6lXK5nuD0ELTZGBHjjFbNazKvb
         OpFA==
X-Gm-Message-State: APjAAAWaChwIuvyCI3H89/yIdqc1CjrzXZ7VFtYsjuq2ZMfl3x8J3Tbw
        VQcKQF5o0eEV9wSjuxqZZ9gE0Hb7k5Y=
X-Google-Smtp-Source: APXvYqy8Vm7Qo/TnifTleebOJSlPDLszfI8xvIDmP169PfygdwfGkEtjaJzuorqY32ivhAl2jPkIpA==
X-Received: by 2002:a1c:1f4e:: with SMTP id f75mr26140245wmf.137.1566895911539;
        Tue, 27 Aug 2019 01:51:51 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 2sm2375569wmz.16.2019.08.27.01.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 01:51:50 -0700 (PDT)
Date:   Tue, 27 Aug 2019 10:51:44 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kai =?utf-8?B?TcOka2lzYXJh?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org
Subject: Re: [RFC] Re: broken userland ABI in configfs binary attributes
Message-ID: <20190827085144.GA31244@miu.piliscsaba.redhat.com>
References: <20190826024838.GN1131@ZenIV.linux.org.uk>
 <20190826162949.GA9980@ZenIV.linux.org.uk>
 <20190826182017.GE15933@bombadil.infradead.org>
 <20190826192819.GO1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826192819.GO1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 26, 2019 at 08:28:19PM +0100, Al Viro wrote:
> On Mon, Aug 26, 2019 at 11:20:17AM -0700, Matthew Wilcox wrote:
> > On Mon, Aug 26, 2019 at 05:29:49PM +0100, Al Viro wrote:
> > > On Mon, Aug 26, 2019 at 03:48:38AM +0100, Al Viro wrote:
> > > 
> > > > 	We might be able to paper over that mess by doing what /dev/st does -
> > > > checking that file_count(file) == 1 in ->flush() instance and doing commit
> > > > there in such case.  It's not entirely reliable, though, and it's definitely
> > > > not something I'd like to see spreading.
> > > 
> > > 	This "not entirely reliable" turns out to be an understatement.
> > > If you have /proc/*/fdinfo/* being read from at the time of final close(2),
> > > you'll get file_count(file) > 1 the last time ->flush() is called.  In other
> > > words, we'd get the data not committed at all.

How about something like this:

#if BITS_PER_LONG == 32
#define F_COUNT_SHORTTERM ((1UL << 24) + 1)
#else
#define F_COUNT_SHORTTERM ((1UL << 48) + 1)
#endif

static inline void get_file_shortterm(struct file *f)
{
	atomic_long_add(F_COUNT_SHORTTERM, &f->f_count);
}

static inline void put_file_shortterm(struct file *f)
{
	fput_many(f, F_COUNT_SHORTTERM);
}

static inline bool file_is_last_longterm(struct file *f)
{
	return atomic_long_read(&f->f_count) % F_COUNT_SHORTTERM == 1;
}

Thanks,
Miklos
