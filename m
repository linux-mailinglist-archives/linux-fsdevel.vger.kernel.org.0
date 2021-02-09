Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A84A3159B5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 23:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhBIWu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 17:50:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233724AbhBIWoP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612910565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GZ7uCNlA2uIi2Zywr96bupyWhGmv/tkzQj/R8fIDK/I=;
        b=c79CMMqXTroewiGPEZ2YdcW1087MhjRQva3KlhBnM6uCX02vN/FbCKqpjfsXBVgaajf030
        A9CAQZIEt+eyaTNCIVTvRRMQVXS/gp7gY8V1tvb7bdm+3HxXtrdrkQx7UI7FA/Ah6MozoV
        /A1TearfBSMSdd/OMD/CfOxj5WtVeCI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-fawvKlqGPnieXzz5ghEJ4g-1; Tue, 09 Feb 2021 17:42:41 -0500
X-MC-Unique: fawvKlqGPnieXzz5ghEJ4g-1
Received: by mail-ej1-f71.google.com with SMTP id by8so285036ejc.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Feb 2021 14:42:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZ7uCNlA2uIi2Zywr96bupyWhGmv/tkzQj/R8fIDK/I=;
        b=nF7K6fSYEq8PTFbrspoX//TLVAHuz8ugfo3WqzHD8YS4yEG7RNwmA1Ojfrmf2JUygm
         oiWachnmuYpcBCDwBKzY1+4ZTL0SH/8GoOo6BBfob93+c2YJ/uQuTOYWgT5PpBaschRP
         mHEQCFJr0ajh2lWLr2rvO5KevAOR59Lh1Pd5Gb6Wga7nUGcWnu5xOK2YcgRNcXd7mzQx
         Sl0VN09Z+x6TFT7VzMrhRYJHQddiDZYdbBBu4+iKdRLGVnA/aUr4LfVBzaqxHnPA934Y
         1T7EA2MXv6JnMNFzmip36ApWC0KRXlsklHNoQRaUQKqbbBMAE3zynw4BpjOOpeVpiUkB
         TEgg==
X-Gm-Message-State: AOAM530ym08D7LtexHdCNSDXf+wnEgmzReYYMcZh44pwSfXdcwvecs2X
        9plA9y2ORYmD6Q5JCo7XaXNfpHKubxS/CPV3PNsyYXStLeDuFdRasy3Bct9Jr57du0s3Jo6nMw4
        wInOfG15xzq/9j/izpfKDegbm/L3Fg3Pjo9NztbylEw==
X-Received: by 2002:a17:906:b351:: with SMTP id cd17mr24871297ejb.110.1612910560580;
        Tue, 09 Feb 2021 14:42:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWZ/SxMb2EYr3Wx/r9tLm+ytvzx5rNbM3Mu7nYLvi+QXirS/jRZBjDCWHtM3Wa2pEsJ4PdxjPocMuO52GFZ9o=
X-Received: by 2002:a17:906:b351:: with SMTP id cd17mr24871281ejb.110.1612910560352;
 Tue, 09 Feb 2021 14:42:40 -0800 (PST)
MIME-Version: 1.0
References: <591237.1612886997@warthog.procyon.org.uk> <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
In-Reply-To: <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 9 Feb 2021 17:42:04 -0500
Message-ID: <CALF+zOkMKqvidLf8WZD889PUN-KofdiRPOcbO4hxboVmUGiOgw@mail.gmail.com>
Subject: Re: [GIT PULL] fscache: I/O API modernisation and netfs helper library
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs <linux-cachefs@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 9, 2021 at 2:07 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I'm looking at this early, because I have more time now than I will
> have during the merge window, and honestly, your pull requests have
> been problematic in the past.
>
> The PG_fscache bit waiting functions are completely crazy. The comment
> about "this will wake up others" is actively wrong, and the waiting
> function looks insane, because you're mixing the two names for
> "fscache" which makes the code look totally incomprehensible. Why
> would we wait for PF_fscache, when PG_private_2 was set? Yes, I know
> why, but the code looks entirely nonsensical.
>
> So just looking at the support infrastructure changes, I get a big "Hmm".
>
> But the thing that makes me go "No, I won't pull this", is that it has
> all the same hallmark signs of trouble that I've complained about
> before: I see absolutely zero sign of "this has more developers
> involved".
>
> There's not a single ack from a VM person for the VM changes. There's
> no sign that this isn't yet another "David Howells went off alone and
> did something that absolutely nobody else cared about".
>

I care about it.

I cannot speak to your concerns about the infrastructure changes, nor
can I comment about a given maintainers involvement or lack thereof.
However, I can tell you what my involvement has been.  I got involved
with it because some of our customers use fscache with NFS and I've
supported it.  I saw dhowells rewriting it to greatly simplify the
code and make it easier to debug and wanted to support the effort.

I have been working on the NFS conversion as dhowells has been
evolving the fscache-iter API.  David first posted the series I think
in Dec 2019 and I started with NFS about mid-year 2020, and had my
first post of NFS patches in July:
https://marc.info/?l=linux-nfs&m=159482591232752&w=2

One thing that came out of the earlier iterations as a result of my
testing was the need for the network filesystem to be able to 'cap'
the IO size based on its parameters, hence the "clamp_length()"
function.  So the next iteration dhowells further evolved it into a
'netfs' API and a 'fscache' API, and my November post was based on
that:
https://marc.info/?l=linux-nfs&m=160596540022461&w=2

Each iteration has greatly simplified the interface to the network
filesystem until today where the API is pretty simple.  I have done
extensive tests with each iteration with all the main NFS versions,
specific unit tests, xfstests, etc.  However my test matrix did not
hit enough fscache + pNFS servers, and I found a problem too late to
include in his pull request.  This is mostly why my patches were not
included to convert NFS to the new fscache API, but I intend to work
out the remaining issues for the next merge window, and I'll have an
opportunity to do more testing last week of Feb with the NFS "remote
bakeathon".  My most recent post was at the end of Jan, and Anna is
taking the first 5 refactoring patches in the next merge window:
https://marc.info/?l=linux-nfs&m=161184595127618&w=2

I do not have the skills of a Trond or Anna NFS developers, but I have
worked in this in earnest and intend to see it through to completion
and support NFS and fscache work.  I have received some feedback on
the NFS patches though it's not been a lot, I do know I have some
things to address still.  With open source, no feedback is hard to
draw conclusions other than it's not "super popular" area, but we
always knew that about fscache - it's an "add on" that some customers
require but not everyone. I know Trond speaks up when I make a mistake
and/or something will cause a problem, so I consider the silence
mostly a positive sign.



> See my problem? I need to be convinced that this makes sense outside
> of your world, and it's not yet another thing that will cause problems
> down the line because nobody else really ever used it or cared about
> it until we hit a snag.
>
>                   Linus
>

