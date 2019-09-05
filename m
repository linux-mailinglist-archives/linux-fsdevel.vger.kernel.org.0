Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBAEAA97E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 18:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388100AbfIEQ6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 12:58:39 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39300 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbfIEQ6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:58:39 -0400
Received: by mail-yw1-f65.google.com with SMTP id n11so1028205ywn.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Sep 2019 09:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=AVUVRGDyuKNEGiNm9nCBdT2Xlc/MKKgTSAov2l6n83s=;
        b=bQiJZqqVfd7csK83h3DoiHbI4NOiOYmNFyYVqCQs+RR63WbARcw4s1vo58Fq5xtbif
         eP2kaqWNSk6tyFM2WvU3vs34ZNnBNveplwtijaqmYIgQr6etxQl8KcA77xE1nK4X3OGd
         42RaDtuutbOWkHk5E0kIx0FudHLyjNBooy7GUklwIg+jlDPl5KQJ6n6xF56piunqOgiG
         GkNJlZ0I/bceNc3DoifT//HajQD4ZJDuzB1ODI4XNUkIBuNBMJlW6NB327fOEpcA7sf7
         rTAISvDXAwm7qAY7pHrnEXZwn6Fd+tibBG5P9riNx2wAvrMYc49hhKKm9F8bo7Xs6wSJ
         YdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=AVUVRGDyuKNEGiNm9nCBdT2Xlc/MKKgTSAov2l6n83s=;
        b=Je/NCsTVFCT6OeQzDfCOQ6z3WeWMAUAqBuRIDwNvAipAsosJWbqPfU9BThThdRrg56
         TkRZNxHQRJVU1k7HzHtwhzrEeE9DqeqP4xv6+e99SuDRYMk+T0jPyc39yP+nb1iQCgnq
         KF/kcKAMrQbiLgTu1eLjZtS+oprB28j8kE8vGqrCg+FR+N/V0KRwc9hWQK+d30Ca51ii
         NWPWkhyL52h3IctCUsPwGwpaQ4Z5uK5KtKGj6Iimxy//pJcaJr8JI1R79nYpCkzpldpy
         X74sgnYLxhC7Okkr6x+LOpOt9c/yJt2Vg7MKlq0oAirT8l0CPQ+bsJpl64AGlredAWej
         yhVw==
X-Gm-Message-State: APjAAAWNmLFkvock197qFhHZY0jgJx81qFkZ7sFzSk0Tw0XyozQ0vo5U
        0kPupVbnOkVnxwRbAluRDpNKdGkzMLimoF1Z+MTfGyFURISrWw==
X-Google-Smtp-Source: APXvYqzyS+rpfDaFGyLq+z1DE1Zi8cGSGntCiCb8qnCCgzu3whYQj8qC8lOd+48RvXGCLm/69zAa7aZQ2dM7XSIOO0Y=
X-Received: by 2002:a0d:d596:: with SMTP id x144mr2925630ywd.69.1567702718228;
 Thu, 05 Sep 2019 09:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190829041132.26677-1-deepa.kernel@gmail.com>
 <CABeXuvoKD83B7iUqE33Y9E2OVtf61DKv-swZr-N=ozz-cMmGOA@mail.gmail.com>
 <CAOg9mSR25eAH7e1KhDZt_uscJSzyuSmELbCxgyh=-KWRxjZtcw@mail.gmail.com>
 <CABeXuvpe9vADLZUr4zHrH0izt=1BaLQvBMxAu=T1A2CV3AN4vA@mail.gmail.com>
 <CAK8P3a0NMUv2xOw=fCxJXo_2wbmBMG24Fst3U1LT-m7C8uxz0w@mail.gmail.com> <CABeXuvrm76iKnFrd7Wo=z4d0v7i7xT+Ta37D-mwVwy7-P3YyUg@mail.gmail.com>
In-Reply-To: <CABeXuvrm76iKnFrd7Wo=z4d0v7i7xT+Ta37D-mwVwy7-P3YyUg@mail.gmail.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Thu, 5 Sep 2019 12:58:27 -0400
Message-ID: <CAOg9mSS=V7cQqPMCj90LtudxhN7_owoEBKxkvsXjzdtu+R69hA@mail.gmail.com>
Subject: Re: [GIT PULL] vfs: Add support for timestamp limits
To:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I spoke to Walt Ligon about the versioning code, and also shared
this thread with him. He isn't a fan of the versioning code.
and we think it should go. As I read through the commit messages
from when the versioning code was added, it relates to mtime
on directories. If a directory is read, and it has enough entries,
it might take several operations to collect all the entries. During
this time the directory might change. The versioning is a way to
tell that something changed between one of the operations...

   commit: 7878027e9c2 (Oct 2004)
     - added a directory version that is passed back from the server to
       the client on each successful readdir call (happens to be the
       directory's mtime encoded as an opaque uint64_t)

We will work to see if we can figure out what we need to do to Orangefs
on both the userspace side and the kernel module side to have all 64 bit
time values.

I've also read up some on the y2038 cleanup work that Arnd and Deepa
have been doing...

Thanks to Arnd and Deepa for looking so deeply into the Orangefs
userspace code...

-Mike

On Sat, Aug 31, 2019 at 6:50 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> > I think it's unclear from the orangefs source code what the intention is,
> > as there is a mixed of signed and unsigned types used for the inode
> > stamps:
> >
> > #define encode_PVFS_time encode_int64_t
> > #define encode_int64_t(pptr,x) do { \
> >     *(int64_t*) *(pptr) = cpu_to_le64(*(x)); \
> >     *(pptr) += 8; \
> > } while (0)
> > #define decode_PVFS_time decode_int64_t
> > #define decode_int64_t(pptr,x) do { \
> >     *(x) = le64_to_cpu(*(int64_t*) *(pptr)); \
> >     *(pptr) += 8; \
> > } while (0)
> >
> > This suggests that making it unsigned may have been an accident.
> >
> > Then again,  it's clearly and consistently printed as unsigned in
> > user space:
> >
> >         gossip_debug(
> >             GOSSIP_GETATTR_DEBUG, " VERSION is %llu, mtime is %llu\n",
> >             llu(s_op->attr.mtime), llu(resp_attr->mtime));
>
> I think I had noticed these two and decided maybe the intention was to
> use unsigned types.
>
> > A related issue I noticed is this:
> >
> > PVFS_time PINT_util_mktime_version(PVFS_time time)
> > {
> >     struct timeval t = {0,0};
> >     PVFS_time version = (time << 32);
> >
> >     gettimeofday(&t, NULL);
> >     version |= (PVFS_time)t.tv_usec;
> >     return version;
> > }
> > PVFS_time PINT_util_mkversion_time(PVFS_time version)
> > {
> >     return (PVFS_time)(version >> 32);
> > }
> > static PINT_sm_action getattr_verify_attribs(
> >         struct PINT_smcb *smcb, job_status_s *js_p)
> > {
> > ...
> >     resp_attr->mtime = PINT_util_mkversion_time(s_op->attr.mtime);
> > ...
> > }
> >
> > which suggests that at least for some purposes, the mtime field
> > is only an unsigned 32-bit number (1970..2106). From my readiing,
> > this affects the on-disk format, but not the protocol implemented
> > by the kernel.
> >
> > atime and ctime are apparently 64-bit, but mtime is only 32-bit
> > seconds, plus a 32-bit 'version'. I suppose the server could be
> > fixed to allow a larger range, but probably would take it out of
> > the 'version' bits, not the upper half.
>
> I had missed this part. Thanks.
>
> > To be on the safe side, I suppose the kernel can only assume
> > an unsigned 32-bit range to be available. If the server gets
> > extended beyond that, it would have to pass a feature flag.
>
> This makes sense to me also. And, as Arnd pointed out on the IRC, if
> there are negative timestamps that are already in use, this will be a
> problem for those use cases.
> I can update tha patch to use limits 0-u32_max.
>
> -Deepa
