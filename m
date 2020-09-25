Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B1C2789B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 15:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgIYNgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 09:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIYNgN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:36:13 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47258C0613CE;
        Fri, 25 Sep 2020 06:36:13 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 26so2796658ois.5;
        Fri, 25 Sep 2020 06:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=o6knc5+koUQnV7l0brxM4b6UlEIkqE3T604O/Ku4/AM=;
        b=hGe17L4CDp8qDq3MRkEI9D/90Qk9zPQeMk8DJQKz/UhtooUWSyiIszODIlxgofbfpG
         wq3H7OmJn0dQNgKRfoSaQpueloSGn7yKjIgSj1jA8upSGjTJy1hMVh9C158GRh19mNO8
         dNJUy1gGxE0pijVMG5VDUmfyEsC1iXxt3VVw06m7ATuurJh5OhT4O/vA+2HCXhpYiBwe
         pgrpy9u1fNnGvMbNw4pBbg8DBReRS+u5W691QlAiW8EUkmkNcklriSqjg4oYC0yBuhfG
         7ciFbBrPkKxkyBR3GKNjmxS/sWWVsbX/Ht4d5IjJtN1pxUZn7vYnU2Fi5I6POdGU8CkZ
         1Hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=o6knc5+koUQnV7l0brxM4b6UlEIkqE3T604O/Ku4/AM=;
        b=qmNxN+kSBdvqpjjJgLik/FmYRzIEhtlL8H4geOozkQmvShphiVwFzXPxWhVJDjoy9W
         7vEYn2f/n8mosYnnGz2LoJFl6XQG3uyRnbrMvs9Ex733Dt90pMMInT0RfBPUMrhIGze0
         w1Km3W4x8DoB8ZYwB88jicfcD6LJVgQ2YVNb7wM+jqv4drCx91mR+q1En0WK8u/V1qHc
         ySdGze7XRUI9hxIdp/kNysySrIHUIMkhn1pUzJAI7sHm1bTB+g3+jaMzVnrZYsQ5Y6dX
         8HwkocL+tT/o2M20dh40oXADQbFeEeYFioZ9OMgOzbNJGAgsyg4bpTkkMmJDSI/cJvj8
         XdEQ==
X-Gm-Message-State: AOAM530JhljdyZLEu/8z01ip58VaRH9gnak43ka/Ktk3wZC0Sj3cXD6p
        wlii7YXY216mGBJC3IopNhuw3TuMRNx1rQNjvmgsgiSf8BDfiw==
X-Google-Smtp-Source: ABdhPJy+8GzdLL8n5oOVQWsxU1jhYyDMvwVk5Qu3lx/inCbBGdjNG47AGg5Ua+QS9F5ZOGEi9AQQdOD74RYQpTE8vQQ=
X-Received: by 2002:aca:ec50:: with SMTP id k77mr260686oih.35.1601040972650;
 Fri, 25 Sep 2020 06:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200924151538.GW32101@casper.infradead.org> <CA+icZUX4bQf+pYsnOR0gHZLsX3NriL=617=RU0usDfx=idgZmA@mail.gmail.com>
 <20200924152755.GY32101@casper.infradead.org> <CA+icZUURRcCh1TYtLs=U_353bhv5_JhVFaGxVPL5Rydee0P1=Q@mail.gmail.com>
 <20200924163635.GZ32101@casper.infradead.org> <CA+icZUUgwcLP8O9oDdUMT0SzEQHjn+LkFFkPL3NsLCBhDRSyGw@mail.gmail.com>
 <f623da731d7c2e96e3a37b091d0ec99095a6386b.camel@redhat.com>
 <CA+icZUVO65ADxk5SZkZwV70ax5JCzPn8PPfZqScTTuvDRD1smQ@mail.gmail.com>
 <20200924200225.GC32101@casper.infradead.org> <CA+icZUV3aL_7MptHbradtnd8P6X9VO-=Pi2gBezWaZXgeZFMpg@mail.gmail.com>
 <20200924235756.GD32101@casper.infradead.org> <CA+icZUWcx5hBjU35tfY=7KXin7cA5AAY8AMKx-pjYnLCsQywGw@mail.gmail.com>
In-Reply-To: <CA+icZUWcx5hBjU35tfY=7KXin7cA5AAY8AMKx-pjYnLCsQywGw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 25 Sep 2020 15:36:01 +0200
Message-ID: <CA+icZUWMs5Xz5vMP370uUBCqzgjq6Aqpy+krZMNg-5JRLxaALA@mail.gmail.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Qian Cai <cai@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>
Content-Type: multipart/mixed; boundary="00000000000072434905b0236640"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000072434905b0236640
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 25, 2020 at 3:24 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Sep 25, 2020 at 1:57 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Sep 24, 2020 at 10:04:40PM +0200, Sedat Dilek wrote:
> > > On Thu, Sep 24, 2020 at 10:02 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Thu, Sep 24, 2020 at 09:54:36PM +0200, Sedat Dilek wrote:
> > > > > You are named in "mm: fix misplaced unlock_page in do_wp_page()".
> > > > > Is this here a different issue?
> > > >
> > > > Yes, completely different.  That bug is one Linus introduced in this
> > > > cycle; the bug that this patch fixes was introduced a couple of years
> > > > ago, and we only noticed now because I added an assertion to -next.
> > > > Maybe I should add the assertion for 5.9 too.
> > >
> > > Can you point me to this "assertion"?
> > > Thanks.
> >
> > Here's the version against 5.8
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 810f7dae11d9..b421e4efc4bd 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -70,11 +70,15 @@ static void
> >  iomap_page_release(struct page *page)
> >  {
> >         struct iomap_page *iop = detach_page_private(page);
> > +       unsigned int nr_blocks = PAGE_SIZE / i_blocksize(page->mapping->host);
> >
> >         if (!iop)
> >                 return;
> >         WARN_ON_ONCE(atomic_read(&iop->read_count));
> >         WARN_ON_ONCE(atomic_read(&iop->write_count));
> > +       WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
> > +                       PageUptodate(page));
> > +
> >         kfree(iop);
> >  }
> >
>
> I have applied your diff on top of Linux v5.9-rc6+ together with
> "iomap: Set all uptodate bits for an Uptodate page".
>
> Run LTP tests:
>
> #1: syscalls (all)
> #2: syscalls/preadv203
> #3: syscalls/dirtyc0w
>
> With #1 I see some failures with madvise0x tests.
>
> I have attached the excerpt of my kernel-log and my kernel-config.
>

I have run syscalls/madvise01..syscalls/madvise10, see attached
(reduced) dmesg-log.

- Sedat -

--00000000000072434905b0236640
Content-Type: text/plain; charset="US-ASCII"; 
	name="dmesg-T_5.9.0-rc6-5-amd64-clang-cfi_syscalls-madviseXX_reduced.txt"
Content-Disposition: attachment; 
	filename="dmesg-T_5.9.0-rc6-5-amd64-clang-cfi_syscalls-madviseXX_reduced.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kfiafy1a0>
X-Attachment-Id: f_kfiafy1a0

W0ZyaSBTZXAgMjUgMTU6Mjk6MzIgMjAyMF0gTFRQOiBzdGFydGluZyBtYWR2aXNlMDEKW0ZyaSBT
ZXAgMjUgMTU6Mjk6MzIgMjAyMF0gSW5qZWN0aW5nIG1lbW9yeSBmYWlsdXJlIGZvciBwZm4gMHgx
N2Q3MGEgYXQgcHJvY2VzcyB2aXJ0dWFsIGFkZHJlc3MgMHg3ZjZmMWQ1ZWQwMDAKW0ZyaSBTZXAg
MjUgMTU6Mjk6MzIgMjAyMF0gTWVtb3J5IGZhaWx1cmU6IDB4MTdkNzBhOiByZWNvdmVyeSBhY3Rp
b24gZm9yIGNsZWFuIExSVSBwYWdlOiBSZWNvdmVyZWQKW0ZyaSBTZXAgMjUgMTU6Mjk6MzIgMjAy
MF0gSW5qZWN0aW5nIG1lbW9yeSBmYWlsdXJlIGZvciBwZm4gMHgxYmYwMjEgYXQgcHJvY2VzcyB2
aXJ0dWFsIGFkZHJlc3MgMHg3ZjZmMWQ1ZWUwMDAKW0ZyaSBTZXAgMjUgMTU6Mjk6MzIgMjAyMF0g
TWVtb3J5IGZhaWx1cmU6IDB4MWJmMDIxOiByZWNvdmVyeSBhY3Rpb24gZm9yIGNsZWFuIExSVSBw
YWdlOiBSZWNvdmVyZWQKW0ZyaSBTZXAgMjUgMTU6Mjk6MzIgMjAyMF0gSW5qZWN0aW5nIG1lbW9y
eSBmYWlsdXJlIGZvciBwZm4gMHgxZjFiZmYgYXQgcHJvY2VzcyB2aXJ0dWFsIGFkZHJlc3MgMHg3
ZjZmMWQ1ZWYwMDAKW0ZyaSBTZXAgMjUgMTU6Mjk6MzIgMjAyMF0gTWVtb3J5IGZhaWx1cmU6IDB4
MWYxYmZmOiByZWNvdmVyeSBhY3Rpb24gZm9yIGNsZWFuIExSVSBwYWdlOiBSZWNvdmVyZWQKW0Zy
aSBTZXAgMjUgMTU6Mjk6MzIgMjAyMF0gSW5qZWN0aW5nIG1lbW9yeSBmYWlsdXJlIGZvciBwZm4g
MHgxZWNkNGUgYXQgcHJvY2VzcyB2aXJ0dWFsIGFkZHJlc3MgMHg3ZjZmMWQ1ZjAwMDAKW0ZyaSBT
ZXAgMjUgMTU6Mjk6MzIgMjAyMF0gTWVtb3J5IGZhaWx1cmU6IDB4MWVjZDRlOiByZWNvdmVyeSBh
Y3Rpb24gZm9yIGNsZWFuIExSVSBwYWdlOiBSZWNvdmVyZWQKW0ZyaSBTZXAgMjUgMTU6Mjk6MzIg
MjAyMF0gSW5qZWN0aW5nIG1lbW9yeSBmYWlsdXJlIGZvciBwZm4gMHgyMDkwYzIgYXQgcHJvY2Vz
cyB2aXJ0dWFsIGFkZHJlc3MgMHg3ZjZmMWQ1ZjEwMDAKW0ZyaSBTZXAgMjUgMTU6Mjk6MzIgMjAy
MF0gTWVtb3J5IGZhaWx1cmU6IDB4MjA5MGMyOiByZWNvdmVyeSBhY3Rpb24gZm9yIGNsZWFuIExS
VSBwYWdlOiBSZWNvdmVyZWQKW0ZyaSBTZXAgMjUgMTU6Mjk6MzIgMjAyMF0gSW5qZWN0aW5nIG1l
bW9yeSBmYWlsdXJlIGZvciBwZm4gMHgxMTUyNjAgYXQgcHJvY2VzcyB2aXJ0dWFsIGFkZHJlc3Mg
MHg3ZjZmMWQ1ZjIwMDAKW0ZyaSBTZXAgMjUgMTU6Mjk6MzIgMjAyMF0gTWVtb3J5IGZhaWx1cmU6
IDB4MTE1MjYwOiByZWNvdmVyeSBhY3Rpb24gZm9yIGNsZWFuIExSVSBwYWdlOiBSZWNvdmVyZWQK
W0ZyaSBTZXAgMjUgMTU6Mjk6MzIgMjAyMF0gSW5qZWN0aW5nIG1lbW9yeSBmYWlsdXJlIGZvciBw
Zm4gMHgxODI5MDIgYXQgcHJvY2VzcyB2aXJ0dWFsIGFkZHJlc3MgMHg3ZjZmMWQ1ZjMwMDAKW0Zy
aSBTZXAgMjUgMTU6Mjk6MzIgMjAyMF0gTWVtb3J5IGZhaWx1cmU6IDB4MTgyOTAyOiByZWNvdmVy
eSBhY3Rpb24gZm9yIGNsZWFuIExSVSBwYWdlOiBSZWNvdmVyZWQKW0ZyaSBTZXAgMjUgMTU6Mjk6
MzIgMjAyMF0gSW5qZWN0aW5nIG1lbW9yeSBmYWlsdXJlIGZvciBwZm4gMHgxMjVjMDUgYXQgcHJv
Y2VzcyB2aXJ0dWFsIGFkZHJlc3MgMHg3ZjZmMWQ1ZjQwMDAKW0ZyaSBTZXAgMjUgMTU6Mjk6MzIg
MjAyMF0gTWVtb3J5IGZhaWx1cmU6IDB4MTI1YzA1OiByZWNvdmVyeSBhY3Rpb24gZm9yIGNsZWFu
IExSVSBwYWdlOiBSZWNvdmVyZWQKW0ZyaSBTZXAgMjUgMTU6Mjk6MzIgMjAyMF0gSW5qZWN0aW5n
IG1lbW9yeSBmYWlsdXJlIGZvciBwZm4gMHgxMjdkOTEgYXQgcHJvY2VzcyB2aXJ0dWFsIGFkZHJl
c3MgMHg3ZjZmMWQ1ZjUwMDAKW0ZyaSBTZXAgMjUgMTU6Mjk6MzIgMjAyMF0gTWVtb3J5IGZhaWx1
cmU6IDB4MTI3ZDkxOiByZWNvdmVyeSBhY3Rpb24gZm9yIGNsZWFuIExSVSBwYWdlOiBSZWNvdmVy
ZWQKW0ZyaSBTZXAgMjUgMTU6Mjk6MzIgMjAyMF0gSW5qZWN0aW5nIG1lbW9yeSBmYWlsdXJlIGZv
ciBwZm4gMHgxODdkZjMgYXQgcHJvY2VzcyB2aXJ0dWFsIGFkZHJlc3MgMHg3ZjZmMWQ1ZjYwMDAK
W0ZyaSBTZXAgMjUgMTU6Mjk6MzIgMjAyMF0gTWVtb3J5IGZhaWx1cmU6IDB4MTg3ZGYzOiByZWNv
dmVyeSBhY3Rpb24gZm9yIGNsZWFuIExSVSBwYWdlOiBSZWNvdmVyZWQKW0ZyaSBTZXAgMjUgMTU6
Mjk6MzIgMjAyMF0gTFRQOiBzdGFydGluZyBtYWR2aXNlMDIKW0ZyaSBTZXAgMjUgMTU6Mjk6MzMg
MjAyMF0gTFRQOiBzdGFydGluZyBtYWR2aXNlMDUKW0ZyaSBTZXAgMjUgMTU6Mjk6MzMgMjAyMF0g
TFRQOiBzdGFydGluZyBtYWR2aXNlMDYKW0ZyaSBTZXAgMjUgMTU6Mjk6MzQgMjAyMF0gbWFkdmlz
ZTA2ICg1MzkyNjkpOiBkcm9wX2NhY2hlczogMwpbRnJpIFNlcCAyNSAxNToyOTo0NiAyMDIwXSBM
VFA6IHN0YXJ0aW5nIG1hZHZpc2UwNwpbRnJpIFNlcCAyNSAxNToyOTo0NiAyMDIwXSBJbmplY3Rp
bmcgbWVtb3J5IGZhaWx1cmUgZm9yIHBmbiAweDFmNzk5MyBhdCBwcm9jZXNzIHZpcnR1YWwgYWRk
cmVzcyAweDdmYmU2N2JmYjAwMApbRnJpIFNlcCAyNSAxNToyOTo0NiAyMDIwXSBNZW1vcnkgZmFp
bHVyZTogMHgxZjc5OTM6IHJlY292ZXJ5IGFjdGlvbiBmb3IgZGlydHkgTFJVIHBhZ2U6IFJlY292
ZXJlZApbRnJpIFNlcCAyNSAxNToyOTo0NiAyMDIwXSBNQ0U6IEtpbGxpbmcgbWFkdmlzZTA3OjUz
OTQwNSBkdWUgdG8gaGFyZHdhcmUgbWVtb3J5IGNvcnJ1cHRpb24gZmF1bHQgYXQgN2ZiZTY3YmZi
MDAwCltGcmkgU2VwIDI1IDE1OjI5OjQ2IDIwMjBdIExUUDogc3RhcnRpbmcgbWFkdmlzZTA4CltG
cmkgU2VwIDI1IDE1OjI5OjQ2IDIwMjBdIExUUDogc3RhcnRpbmcgbWFkdmlzZTA5CltGcmkgU2Vw
IDI1IDE1OjI5OjQ3IDIwMjBdIG1hZHZpc2UwOSBpbnZva2VkIG9vbS1raWxsZXI6IGdmcF9tYXNr
PTB4Y2MwKEdGUF9LRVJORUwpLCBvcmRlcj0wLCBvb21fc2NvcmVfYWRqPTAKW0ZyaSBTZXAgMjUg
MTU6Mjk6NDcgMjAyMF0gQ1BVOiAxIFBJRDogNTM5NjgwIENvbW06IG1hZHZpc2UwOSBUYWludGVk
OiBHICAgICAgICAgICAgRSAgICAgNS45LjAtcmM2LTUtYW1kNjQtY2xhbmctY2ZpICM1fmJ1bGxz
ZXllK2RpbGVrczEKW0ZyaSBTZXAgMjUgMTU6Mjk6NDcgMjAyMF0gSGFyZHdhcmUgbmFtZTogU0FN
U1VORyBFTEVDVFJPTklDUyBDTy4sIExURC4gNTMwVTNCSS81MzBVNEJJLzUzMFU0QkgvNTMwVTNC
SS81MzBVNEJJLzUzMFU0QkgsIEJJT1MgMTNYSyAwMy8yOC8yMDEzCltGcmkgU2VwIDI1IDE1OjI5
OjQ3IDIwMjBdIENhbGwgVHJhY2U6CltGcmkgU2VwIDI1IDE1OjI5OjQ3IDIwMjBdICBkdW1wX3N0
YWNrKzB4NjQvMHg5YgpbRnJpIFNlcCAyNSAxNToyOTo0NyAyMDIwXSAgZHVtcF9oZWFkZXIrMHg1
MC8weDIzMApbRnJpIFNlcCAyNSAxNToyOTo0NyAyMDIwXSAgb29tX2tpbGxfcHJvY2VzcysweGEx
LzB4MTcwCltGcmkgU2VwIDI1IDE1OjI5OjQ3IDIwMjBdICBvdXRfb2ZfbWVtb3J5KzB4MjY1LzB4
MzMwCltGcmkgU2VwIDI1IDE1OjI5OjQ3IDIwMjBdICBtZW1fY2dyb3VwX29vbSsweDMxMy8weDM2
MApbRnJpIFNlcCAyNSAxNToyOTo0NyAyMDIwXSAgdHJ5X2NoYXJnZSsweDUxZi8weDczMApbRnJp
IFNlcCAyNSAxNToyOTo0NyAyMDIwXSAgbWVtX2Nncm91cF9jaGFyZ2UrMHgxMDAvMHgzMDAKW0Zy
aSBTZXAgMjUgMTU6Mjk6NDcgMjAyMF0gIGRvX2Fub255bW91c19wYWdlKzB4MjI5LzB4NjkwCltG
cmkgU2VwIDI1IDE1OjI5OjQ3IDIwMjBdICA/IF9fc2NoZWR1bGUrMHg0MWEvMHg3YzAKW0ZyaSBT
ZXAgMjUgMTU6Mjk6NDcgMjAyMF0gID8gZG1hX2dldF9yZXF1aXJlZF9tYXNrLmNmaV9qdCsweDEw
LzB4MTAKW0ZyaSBTZXAgMjUgMTU6Mjk6NDcgMjAyMF0gIGhhbmRsZV9tbV9mYXVsdCsweDhiMC8w
eGNjMApbRnJpIFNlcCAyNSAxNToyOTo0NyAyMDIwXSAgZG9fdXNlcl9hZGRyX2ZhdWx0KzB4MjAx
LzB4M2EwCltGcmkgU2VwIDI1IDE1OjI5OjQ3IDIwMjBdICA/IGFzbV9leGNfcGFnZV9mYXVsdCsw
eDgvMHgzMApbRnJpIFNlcCAyNSAxNToyOTo0NyAyMDIwXSAgZXhjX3BhZ2VfZmF1bHQrMHg3YS8w
eDI3MApbRnJpIFNlcCAyNSAxNToyOTo0NyAyMDIwXSAgPyBhc21fZXhjX3BhZ2VfZmF1bHQrMHg4
LzB4MzAKW0ZyaSBTZXAgMjUgMTU6Mjk6NDcgMjAyMF0gIGFzbV9leGNfcGFnZV9mYXVsdCsweDFl
LzB4MzAKW0ZyaSBTZXAgMjUgMTU6Mjk6NDcgMjAyMF0gUklQOiAwMDMzOjB4NTViOGY2ZDY2NTVi
CltGcmkgU2VwIDI1IDE1OjI5OjQ3IDIwMjBdIENvZGU6IDQ4IGMxIGVhIDAyIDQ4IDg5IGQwIDQ4
IGY3IGU1IDQ4IDg5IGQwIDQ4IDgzIGUyIGZjIDQ4IGMxIGU4IDAyIDQ4IDAxIGMyIDQ4IDhkIDA0
IDkyIDRjIDg5IGYyIDQ5IDgzIGM2IDAxIDQ4IGMxIGUwIDAyIDQ4IDI5IGMyIDw0MT4gODggMTcg
NDkgMDEgZGYgZTggM2EgZjUgZmYgZmYgNDkgODEgZmUgZjQgMDEgMDAgMDAgNzUgYjkgNDQgOGIK
W0ZyaSBTZXAgMjUgMTU6Mjk6NDcgMjAyMF0gUlNQOiAwMDJiOjAwMDA3ZmZlZDE4ZTJiYTAgRUZM
QUdTOiAwMDAxMDIwMgpbRnJpIFNlcCAyNSAxNToyOTo0NyAyMDIwXSBSQVg6IDAwMDAwMDAwMDAw
MDAwMDAgUkJYOiAwMDAwMDAwMDAwMDAxMDAwIFJDWDogMDAwMDAwMDAwMDAwMDAwMApbRnJpIFNl
cCAyNSAxNToyOTo0NyAyMDIwXSBSRFg6IDAwMDAwMDAwMDAwMDAwMWYgUlNJOiAwMDAwMDAwMDAw
MDAwMDAwIFJESTogMDAwMDAwMDAwMDAwMDAwMQpbRnJpIFNlcCAyNSAxNToyOTo0NyAyMDIwXSBS
QlA6IDI4ZjVjMjhmNWMyOGY1YzMgUjA4OiAwMDAwMDAwMGZmZmZmZmZmIFIwOTogMDAwMDAwMDAw
MDAwMDAwMApbRnJpIFNlcCAyNSAxNToyOTo0NyAyMDIwXSBSMTA6IDAwMDAwMDAwMDAwMDAwMDAg
UjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDdmZmVkMThlMmJkMApbRnJpIFNlcCAyNSAx
NToyOTo0NyAyMDIwXSBSMTM6IDAwMDAwMDAwMDAxZjQwMDAgUjE0OiAwMDAwMDAwMDAwMDAwMDIw
IFIxNTogMDAwMDdmMmJlZDM1NTAwMApbRnJpIFNlcCAyNSAxNToyOTo0NyAyMDIwXSBtZW1vcnk6
IHVzYWdlIDgxOTJrQiwgbGltaXQgODE5MmtCLCBmYWlsY250IDQ4NQpbRnJpIFNlcCAyNSAxNToy
OTo0NyAyMDIwXSBtZW1vcnkrc3dhcDogdXNhZ2UgMTYzMTZrQiwgbGltaXQgMTYzODRrQiwgZmFp
bGNudCAxNQpbRnJpIFNlcCAyNSAxNToyOTo0NyAyMDIwXSBrbWVtOiB1c2FnZSAxMjRrQiwgbGlt
aXQgOTAwNzE5OTI1NDc0MDk4OGtCLCBmYWlsY250IDAKW0ZyaSBTZXAgMjUgMTU6Mjk6NDcgMjAy
MF0gTWVtb3J5IGNncm91cCBzdGF0cyBmb3IgL2x0cF9tYWR2aXNlMDlfNTM5Njc5OgpbRnJpIFNl
cCAyNSAxNToyOTo0NyAyMDIwXSBhbm9uIDgxMTAwODAKW0ZyaSBTZXAgMjUgMTU6Mjk6NDcgMjAy
MF0gVGFza3Mgc3RhdGUgKG1lbW9yeSB2YWx1ZXMgaW4gcGFnZXMpOgpbRnJpIFNlcCAyNSAxNToy
OTo0NyAyMDIwXSBbICBwaWQgIF0gICB1aWQgIHRnaWQgdG90YWxfdm0gICAgICByc3MgcGd0YWJs
ZXNfYnl0ZXMgc3dhcGVudHMgb29tX3Njb3JlX2FkaiBuYW1lCltGcmkgU2VwIDI1IDE1OjI5OjQ3
IDIwMjBdIFsgNTM5Njc5XSAgICAgMCA1Mzk2NzkgICAgICA3NDYgICAgICAzMTAgICAgNDUwNTYg
ICAgICAgIDggICAgICAgICAgICAgMCBtYWR2aXNlMDkKW0ZyaSBTZXAgMjUgMTU6Mjk6NDcgMjAy
MF0gWyA1Mzk2ODBdICAgICAwIDUzOTY4MCAgICAgNTI0NiAgICAgMjE2MyAgICA4MTkyMCAgICAg
MjAzOSAgICAgICAgICAgICAwIG1hZHZpc2UwOQpbRnJpIFNlcCAyNSAxNToyOTo0NyAyMDIwXSBv
b20ta2lsbDpjb25zdHJhaW50PUNPTlNUUkFJTlRfTUVNQ0csbm9kZW1hc2s9KG51bGwpLGNwdXNl
dD0vLG1lbXNfYWxsb3dlZD0wLG9vbV9tZW1jZz0vbHRwX21hZHZpc2UwOV81Mzk2NzksdGFza19t
ZW1jZz0vbHRwX21hZHZpc2UwOV81Mzk2NzksdGFzaz1tYWR2aXNlMDkscGlkPTUzOTY4MCx1aWQ9
MApbRnJpIFNlcCAyNSAxNToyOTo0NyAyMDIwXSBNZW1vcnkgY2dyb3VwIG91dCBvZiBtZW1vcnk6
IEtpbGxlZCBwcm9jZXNzIDUzOTY4MCAobWFkdmlzZTA5KSB0b3RhbC12bToyMDk4NGtCLCBhbm9u
LXJzczo4MDI0a0IsIGZpbGUtcnNzOjYyOGtCLCBzaG1lbS1yc3M6MGtCLCBVSUQ6MCBwZ3RhYmxl
czo4MGtCIG9vbV9zY29yZV9hZGo6MApbRnJpIFNlcCAyNSAxNToyOTo0NyAyMDIwXSBvb21fcmVh
cGVyOiByZWFwZWQgcHJvY2VzcyA1Mzk2ODAgKG1hZHZpc2UwOSksIG5vdyBhbm9uLXJzczowa0Is
IGZpbGUtcnNzOjBrQiwgc2htZW0tcnNzOjBrQgpbRnJpIFNlcCAyNSAxNToyOTo0NyAyMDIwXSBM
VFA6IHN0YXJ0aW5nIG1hZHZpc2UxMAo=
--00000000000072434905b0236640--
