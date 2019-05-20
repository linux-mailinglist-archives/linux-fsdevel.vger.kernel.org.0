Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE85123190
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 12:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbfETKqE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 06:46:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32957 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731727AbfETKqE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 06:46:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id c66so13981145wme.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2019 03:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=FNQffb8QL8IgGta8QHGMIkJOjNxQ6yOoFcpL2RGNOxo=;
        b=Yx3Oh9sdjhtxkjy2qUZOvGLEh/omRfY9Mkk8SZgdDDixIStb27nmcn3B7LNLkywYKf
         JSJs2y09yTFai60dfvSU6bs3U2Y+HZSEgZwWN6UlzEZ1wASRtjIcHxGBtD4y6tsAuqVS
         3ujdLIe/3srn1f0SjS94N6OmFmNXyQjA8jYYAeTVbdE87jeskYdVzPBwTuGiV5VXMofg
         Qcc4TKaT9Wtzyo5PNWXoXjNZN8OY3QNXt/d/SPjmZQCZVqxth/sR5PvwpcgaROR92mOk
         Z6Us/2nTa0Du6iMydUy7SM5zXTl+W32h+hkN9oHJisAKE0vA0TrVU7YYUAkZEQA//CVY
         df6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=FNQffb8QL8IgGta8QHGMIkJOjNxQ6yOoFcpL2RGNOxo=;
        b=CKUEUI/CgxTL8vx76CKynGOd0y4MQFi9gsV9oEk2qpmfMtRNw0pvdw6Df1/Y2ymH/o
         5VONSef1mxp30LSp3AnpZrHu4cNUaYi5o4ju0MQ+LCyLazghrSvCxXrGoqIBzxfusiL4
         TxuKEOqB0Q1a2z63nsZXyrDHVnsXFhBX4Ggw0balGNxaD2me45XylYwN4dYCtiRUCagS
         V+xuVNZXsmoj55OeJIyneVZldMkA4nJK31zBV0VPS0BI36WCRHat90+70D9l/i5nRR75
         ubVBcpDfAVrf2QLR1SgHAh/xjKsaAeS4TyPg092C7aQ5t6cGyb5JdV78H0j/wir3ev07
         OloQ==
X-Gm-Message-State: APjAAAUsNetlQ0GvisnpJaseTl6eEslyM2h5pjXJxT5q9Fb9QtWizW7B
        QdL48skLP1ZgAKwrNR1NhDn/wA==
X-Google-Smtp-Source: APXvYqwf9Bs8lTKBrSvqq/FNc2Kp0ccnjoaTSSxl7jXQW63EXQ+RaXppUqT7Z5tC+EpLaW9/edIhpA==
X-Received: by 2002:a1c:385:: with SMTP id 127mr11200126wmd.109.1558349161708;
        Mon, 20 May 2019 03:46:01 -0700 (PDT)
Received: from [192.168.0.100] ([88.147.73.106])
        by smtp.gmail.com with ESMTPSA id x187sm18555952wmb.33.2019.05.20.03.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 03:46:00 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <1C0A2FC8-620C-4AFE-A921-35EDAC377BD4@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_695B9A4F-9A68-4C92-B622-6C792D193B9F";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Date:   Mon, 20 May 2019 12:45:58 +0200
In-Reply-To: <20190520091558.GC2172@quack2.suse.cz>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        linux-fsdevel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, jmoyer@redhat.com,
        amakhalov@vmware.com, anishs@vmware.com, srivatsab@vmware.com
To:     Jan Kara <jack@suse.cz>
References: <8d72fcf7-bbb4-2965-1a06-e9fc177a8938@csail.mit.edu>
 <1812E450-14EF-4D5A-8F31-668499E13652@linaro.org>
 <20190518192847.GB14277@mit.edu> <20190520091558.GC2172@quack2.suse.cz>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_695B9A4F-9A68-4C92-B622-6C792D193B9F
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 20 mag 2019, alle ore 11:15, Jan Kara <jack@suse.cz> ha scritto:
> 
> On Sat 18-05-19 15:28:47, Theodore Ts'o wrote:
>> On Sat, May 18, 2019 at 08:39:54PM +0200, Paolo Valente wrote:
>>> I've addressed these issues in my last batch of improvements for
>>> BFQ, which landed in the upcoming 5.2. If you give it a try, and
>>> still see the problem, then I'll be glad to reproduce it, and
>>> hopefully fix it for you.
>> 
>> Hi Paolo, I'm curious if you could give a quick summary about what you
>> changed in BFQ?
>> 
>> I was considering adding support so that if userspace calls fsync(2)
>> or fdatasync(2), to attach the process's CSS to the transaction, and
>> then charge all of the journal metadata writes the process's CSS.  If
>> there are multiple fsync's batched into the transaction, the first
>> process which forced the early transaction commit would get charged
>> the entire journal write.  OTOH, journal writes are sequential I/O, so
>> the amount of disk time for writing the journal is going to be
>> relatively small, and especially, the fact that work from other
>> cgroups is going to be minimal, especially if hadn't issued an
>> fsync().
> 
> But this makes priority-inversion problems with ext4 journal worse, doesn't
> it? If we submit journal commit in blkio cgroup of some random process, it
> may get throttled which then effectively blocks the whole filesystem. Or do
> you want to implement a more complex back-pressure mechanism where you'd
> just account to different blkio cgroup during journal commit and then
> throttle as different point where you are not blocking other tasks from
> progress?
> 
>> In the case where you have three cgroups all issuing fsync(2) and they
>> all landed in the same jbd2 transaction thanks to commit batching, in
>> the ideal world we would split up the disk time usage equally across
>> those three cgroups.  But it's probably not worth doing that...
>> 
>> That being said, we probably do need some BFQ support, since in the
>> case where we have multiple processes doing buffered writes w/o fsync,
>> we do charnge the data=ordered writeback to each block cgroup. Worse,
>> the commit can't complete until the all of the data integrity
>> writebacks have completed.  And if there are N cgroups with dirty
>> inodes, and slice_idle set to 8ms, there is going to be 8*N ms worth
>> of idle time tacked onto the commit time.
> 
> Yeah. At least in some cases, we know there won't be any more IO from a
> particular cgroup in the near future (e.g. transaction commit completing,
> or when the layers above IO scheduler already know which IO they are going
> to submit next) and in that case idling is just a waste of time.

Yep.  Issues like this are targeted exactly by the improvement I
mentioned in my previous reply.

> But so far
> I haven't decided how should look a reasonably clean interface for this
> that isn't specific to a particular IO scheduler implementation.
> 

That's an interesting point.  So far, I've assumed that nobody would
have told anything to BFQ.  But if you guys think that such a
communication may be acceptable at some degree, then I'd be glad to
try to come up with some solution.  For instance: some hook that any
I/O scheduler may export if meaningful.

Thanks,
Paolo

> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


--Apple-Mail=_695B9A4F-9A68-4C92-B622-6C792D193B9F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlzihWYACgkQOAkCLQGo
9oPXOA//SHPnVMxI3rHezSW0oYnbHoHp+FGr9dlhy3tQXGYXlhkAVnAO5z8rFFiF
l3i0Rm84B/BLL/v/a2NMj50boLqfrjMA7YhUscj+uoGyQgmA8LZGfMv9RmSQt2mf
6KZfuJL4UdDkbjagKpWOaRjuOnvrP1L2psg0rbngdSil8ZS/D60FbWL6f8NmDSmz
tb/s/ZS8YM4b58Qp6rtoMLwQVfj6vT+4QJib4C/YNbo9wY8+JULuuJRllRYqATsL
cxOJFGwfL5fvcvQ/agaqp4lorVBLrMMMNEi9NpH6AFcQ8ALAZ2jEzKANOmrP8f43
cQpuLhsOVBAZuWQpmAYwX5au9VUaGTZsrhqYPEeMWY23Q0LHmJt8k4FoEF4wZRnt
F7pVokpmMlwjcgw0+OzFm+OngQHdXFxbFwY8boWtmSXdSiZiZ61nbTfAnYNlp+/W
Of0RlXgzZTMH5gqRLaFjZamQUIE5oWTtIvCPC9cF4CE2+tyQVHbla7Azgo/JvFRw
LEbg21BDrSUxUfJukpaYrjtZ+LIyuFG3R+Wn3HN1qVAmUW+T3imrTN9U+xXft3c1
mkp8LwHND/8tnCGOsxYZXpEK4SmPykGOPpJS8Zjc+XWcr70HYXw8xMcajb0Fsl9p
y9BLh0rZNMYmI58YAucv5thw+MbdtdoKCWh2R+Oebh7Il2+0kLM=
=xSol
-----END PGP SIGNATURE-----

--Apple-Mail=_695B9A4F-9A68-4C92-B622-6C792D193B9F--
