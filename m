Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10551E54B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 21:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfJYTzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 15:55:13 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38839 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfJYTzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 15:55:12 -0400
Received: by mail-yb1-f196.google.com with SMTP id r68so1378402ybf.5;
        Fri, 25 Oct 2019 12:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R7xQnPlRmqoV+Q4bzwFq02kF8UPmNBcuNKiMYN5jTCg=;
        b=o3AygBoz/QARI+PyJq3f/bMOwEkkPODLHs/noosFWLUfFX0PDZeaKtsP+IP43bs5YJ
         2eR0T0f5xxZIWwjvhTbyr4VgnSD0/E6HEeiG3xZji+mdcTKiBwA1fQGDcmg6QSde7lQ4
         SST+k1IiHBolDLix7MT08iXWRnGw8WC1fhBHgJkuXfOHUyi895sditIQnyaPn6/Qzy5I
         D+gor3tQVd4JFFvwMMyt90nn4RCxmu4eYlPQIqUw8N01jB2HjxPjx+kKdfeCrrh/aMfO
         EoBteF4Xj+tcPmhrxBc7B0jCy0fUBDB4LcQpEdunLU86Qd4BlFsp9AV9qYUBIQL12Byr
         11gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R7xQnPlRmqoV+Q4bzwFq02kF8UPmNBcuNKiMYN5jTCg=;
        b=CKktkTCbiPID/njWed00O5alJhl2vPX0j+FCFNswVROD9M8tN2vuufx7CYasHjL+ji
         pN/ZgTkSny+N27O0CNKE3IspJcigi2tuAM4h23hAcmUpSWoMCyye1ukauNQLC/1whxao
         QbOw4ndPkr9+TNTSELSYWaJgkgZ5Ry6QEaXBHO3MMVcRxILbi6bcGgu/4zuTDtN0SkTF
         vqOtj+Tgo7ESDslJGHK7v5fZhtG9Y8U10GmYd6xu56wxwVREoGMib2fq4ntbAU0efmJQ
         hc3FhDjv+m3X3Flrl43QZuxRSiefsb2t6vZVQXa88qW4j+iE7ESnsHfYwpFXF5Q3pKRP
         Vq6Q==
X-Gm-Message-State: APjAAAW4T0izpRGTZnq245GOAYmm4L1Hd332DIFgUWKOWQLl9qhfqrjY
        ZR9MWYHCaBRWcbcYyIICLdo=
X-Google-Smtp-Source: APXvYqzJMBInIeLkaAKgWs/672jdUEO8St6xsH7nNfYBVKe4yuxr+AzNLMmh4vNip/tGZLsvQr3dtg==
X-Received: by 2002:a25:bc84:: with SMTP id e4mr4929001ybk.41.1572033311301;
        Fri, 25 Oct 2019 12:55:11 -0700 (PDT)
Received: from anon-dhcp-153.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v204sm782781ywb.23.2019.10.25.12.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 12:55:10 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH 00/35] user xattr support (RFC8276)
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <20191024231547.GA16466@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Date:   Fri, 25 Oct 2019 15:55:09 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <18D2845F-27FF-4EDF-AB8A-E6051FA03DF0@gmail.com>
References: <cover.1568309119.git.fllinden@amazon.com>
 <9CAEB69A-A92C-47D8-9871-BA6EA83E1881@gmail.com>
 <20191024231547.GA16466@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Frank-


> On Oct 24, 2019, at 7:15 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> Hi Chuck,
>=20
> Thanks for your comments.
>=20
> On Thu, Oct 24, 2019 at 04:16:33PM -0400, Chuck Lever wrote:
>> - IMO you can post future updates just to linux-nfs. Note that the
>> kernel NFS client and server are maintained separately, so when it
>> comes time to submit final patches, you will send the client work
>> to Trond and Anna, and the server work to Bruce (and maybe me).
>=20
> Sure, I'll do that.
>=20
>>=20
>> - We like patches that are as small as possible but no smaller.
>> Some of these might be too small. For example, you don't need to add
>> the XDR encoders, decoders, and reply size macros in separate =
patches.
>=20
> True, I might have gone overboard there :-) If you can send further
> suggestions offline, that'd be great!
>=20
>> - Please run scripts/checkpatch.pl on each patch before you post
>> again. This will help identify coding convention issues that should
>> be addressed before merge. sparse is also a good idea too.
>> clang-format is also nice but is entirely optional.
>=20
> No problem. I think there shouldn't be many issues, but I'm sure
> I mixed up some of the coding styles I've had to adhere to over
> the decades..
>=20
>>=20
>> - I was not able to get 34/35 to apply. The series might be missing
>> a patch that adds nfsd_getxattr and friends.
>=20
> Hm, odd. I'll check on that - I might have messed up there.
>=20
>>=20
>> - Do you have man page updates for the new mount and export options?
>=20
> I don't, but I can easily write them. They go in nfs-utils, right?

Yes. utils/mount/nfs.man for the mount option.


>> - I'm not clear why new CONFIG options are necessary. These days we
>> try to avoid adding new CONFIG options if possible. I can't think of
>> a reason someone would need to compile user xattr support out if
>> NFSv4.2 is enabled.
>>=20
>> - Can you explain why an NFS server administrator might want to
>> disable user xattr support on a share?
>=20
> I think both of these are cases of being careful. E.g. don't enable
> something by default and allow it to be disabled at runtime in
> case something goes terribly wrong.
>=20
> I didn't have any other reasons, really. I'm happy do to away with
> the CONFIG options if that's the consensus, as well as the
> nouser_xattr export option.

I have similar patches adding support for access to a couple of
security xattrs. I initially wrapped the new code with CONFIG
but after some discussion it was decided there was really no
need to be so cautious.

The user_xattr export option is a separate matter, but again,
if we don't know of a use case for it, I would leave it out for
the moment.


>> - Probably you are correct that the design choices you made regarding
>> multi-message LISTXATTR are the best that can be done. Hopefully that
>> is not a frequent operation, but for something like "tar" it might =
be.
>> Do you have any feeling for how to assess performance?
>=20
> So far, my performance testing has been based on synthetic workloads,
> which I'm also using to test some boundary conditions. E.g. create
> as many xattrs as the Linux limit allows, list them all, now do
> this for many files, etc. I'll definitely add testing with code
> that uses xattrs. tar is on the list, but I'm happy to test anything
> that exercises the code.
>=20
> I don't think a multi-message LISTXATTR will happen a lot in practice,
> if at all.
>=20
>>=20
>> - Regarding client caching... the RFC is notably vague about what
>> is needed there. You might be able to get away with no caching, just
>> as a start. Do you (and others) think that this series would be
>> acceptable and mergeable without any client caching support?
>=20
> The performance is, obviously, not great without client side caching.
> But then again, that's on my synthetic workloads. In cases like GNU
> tar, it won't matter a whole lot because of the way that code is
> structured.
>=20
> I would prefer to have client side caching enabled from the start.
> I have an implementation that works, but, like I mentioned, I
> have some misgivings about it. But I should just include it when
> I re-post - I might simply be worrying too much.

After the patches are cleaner (checkpatch and squashing) I think
you will get more direct review of the caching heuristics.

I'll send some suggestions via private e-mail.


>> - Do you have access to an RDMA-capable platform? RPC/RDMA needs to
>> be able to predict how large each reply will be, in order to reserve
>> appropriate memory resources to land the whole RPC reply on the =
client.
>> I'm wondering if you've found any particular areas where that might =
be
>> a challenge.
>=20
> Hm. I might be able to set something up. If not, I'd be relying
> on someone you might know to test it for me :-)
>=20
> I am not too familiar with the RDMA RPC code. =46rom what I posted, is=20=

> there any specific part of how the RPC layer is used that would
> be of concern with RDMA?
>=20
> I don't do anything other parts of the code don't do. The only special
> case is using on-demand page allocation on receive, which the ACL code
> also does (XDRBUF_SPARSE_PAGES - used for LISTXATTR and GETXATTR).

That's exactly what's of concern. RDMA has similar logic as TCP
here to allocate pages on demand for this case. The problem
arises when the server needs to return a bigger reply than will
fit in this buffer. Rare.


>> Testing:
>>=20
>> - Does fstests already have user xattr functional tests? If not, how
>> do you envision testing this new code?
>=20
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/ has some xattr
> tests. I've, so far, been using my own set of tests that I'm happy
> to contribute to any testsuite.

fstests would be the one.


>> - How should we test the logic that deals with delegation recall?
>=20
> I believe pyNFS has some logic do test this. What I have been doing
> is manual testing, either using 2 clients, or, simpler, setting
> xattrs on a file on the server itself, and verifying that client
> delegations were recalled.
>=20
>>=20
>> - Do you have plans to submit patches to pyNFS?
>=20
> It wasn't in my plans, but I certainly could. One issue I've noticed,
> with pyNFS and some other tests, is that they go no further than 4.1.
> They'll need some more work to do 4.2 - although that shouldn't be
> a lot of work, as most (or was it all?) features in 4.2 are optional.

OK, if v4.2 is not supported in the test suite, then there is
a pre-requisite discussion to be had.


> I've not had much time to work on this in the past few weeks, but
> next week is looking much better. Here's my plan:
>=20
> * address any issues flagged by checkpatch
> * merge some patches, with your input
> * clean up my nfs-ganesha patches and test some more against that
> * test against Rick's FreeBSD prototype
> * repost the series, split in to client and server
>=20
> In general, what do people do with code changes that affect both
> client and server (e.g. generic defines)?

For generic defines, include the same patches in both the client
and server series. When git merges the two separate branches, it
should recognize that the incoming files are identical and do
nothing.


--
Chuck Lever
chucklever@gmail.com



