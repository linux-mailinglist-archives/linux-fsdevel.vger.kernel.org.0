Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF721FA4F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 02:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgFPANe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 20:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgFPANc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 20:13:32 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC08C061A0E;
        Mon, 15 Jun 2020 17:13:30 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id ec10so8682257qvb.5;
        Mon, 15 Jun 2020 17:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZTUGRzffZE3wE+LOtM+s3kWQsBeq2NfQEIgXbaFHXAY=;
        b=O3CyqlsE3J+h0Ik0qb2HO93WOSLCqfo4FBLcIyF0odLPVW7/b6TxQ1Tr5v6+FGC8VP
         BIVhQAmQr3Ib9+KAEdz0sqQsdmwQgDLhTMQmrr3lwOt8K7pN1JmTlYW7rRv9FabCpV42
         bo/FdQdBJiOT65YqB7N4SgzDv8t9HeVZD60O5U9zFD3r8F6RAglHjwimbhSb0Yk9HQtU
         MmicrEsNUu/7wN8f+yNT6VR8BBfG6G4TJOIXvCQclRiXeQ0qZQ2lTlzq6hNJi7oHiSgJ
         acGfVNnfg8aX+N5v94HU2vKoNzQSM7BdvVOagtXCdVrChTzLKtZZsc91v3q//NxCTNOm
         t88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZTUGRzffZE3wE+LOtM+s3kWQsBeq2NfQEIgXbaFHXAY=;
        b=haJpphSO44LlZ30Wbf9bBHQ1d1fvOWqR9nNEwn7qvc/8OborckCAU7UPsxZ0+rNTYP
         qDFiGdfs5WoL2tcj0gHJdvyVZIB+5il8t2agpwQl1cfrBimKUwaFvwJkKW475X1gez1i
         7wKTTkfmvmKVE90g4xF2is0S9rpVEnBEL4MhkCaDR3EJ5a3tCbFXVQgm+W8c09tvyTcF
         dDfykOocDotn7ZGDiKq5I9D+8XMlmerRHgJOS/wwqjGyvXBdYr/0KHORTYhck7ZTSSeS
         Lwu0W9UKAROgw+j98ZQ2sYdNyR9Tll0qda9xa7xPKHeh0EpCHBzYwpSRJL1RF0kMs/lY
         Ut5w==
X-Gm-Message-State: AOAM530Wd2U8L9g9AstiMOqGrlgmUuscFxqkaKGgPIe1jGbMq/NgF4KH
        h3AN8rra1jTvrMA4345X7wE=
X-Google-Smtp-Source: ABdhPJws/I2Q5ujVxOnkzlV51br2jbRnVWoJ+cz5q6oXV7lombMlNYbBLDGKpGBmmADodCAYmFZ/2Q==
X-Received: by 2002:a05:6214:5a4:: with SMTP id by4mr344508qvb.40.1592266409772;
        Mon, 15 Jun 2020 17:13:29 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id c4sm12487620qko.118.2020.06.15.17.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 17:13:28 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id E0CCD27C0054;
        Mon, 15 Jun 2020 20:13:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 15 Jun 2020 20:13:26 -0400
X-ME-Sender: <xms:ow7oXrBDP5ADUF1gFMuvjWXOupBMBC3uL5Afyyq4cw_UOCMKUnCHNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeiledgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepheefudejueffjeelkedtgeelleelgfffhffhvdehtdekveehjeeivdejgedu
    udegnecukfhppedutddurdekiedrgeejrddujedvnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:ow7oXhgO9o8klL1wvrWkyEuk9yEoECAkpLdrAxlgehgfYNEwnwQECA>
    <xmx:ow7oXmno7SE6Vzn_3V3qcaYpTStr5e0R3ftk28rTWO_Tv4bKAxHpBw>
    <xmx:ow7oXty2ycSZsSBxEEEcR_o8SG_YzNEHPBIqdmpDNq2ve093E397gQ>
    <xmx:pg7oXsyFwFdrm68sCYcOeHqJev-eD0gwbNrbGx1WpBwVsxT7BRVJgE98Q8o>
Received: from localhost (unknown [101.86.47.172])
        by mail.messagingengine.com (Postfix) with ESMTPA id 873CD30614FA;
        Mon, 15 Jun 2020 20:13:22 -0400 (EDT)
Date:   Tue, 16 Jun 2020 08:13:19 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+a9fb1457d720a55d6dc5@syzkaller.appspotmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, allison@lohutok.net,
        areber@redhat.com, aubrey.li@linux.intel.com,
        Andrei Vagin <avagin@gmail.com>,
        Bruce Fields <bfields@fieldses.org>,
        Christian Brauner <christian@brauner.io>, cyphar@cyphar.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, guro@fb.com,
        Jeff Layton <jlayton@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>, linmiaohe@huawei.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, sargun@sargun.me,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: possible deadlock in send_sigio
Message-ID: <20200616001319.GA925161@tardis>
References: <69818a6c-7025-8950-da4b-7fdc065d90d6@redhat.com>
 <CACT4Y+brpePBoR7EUwPiSvGAgo6bhvpKvLTiCaCfRSadzn6yRw@mail.gmail.com>
 <88c172af-46df-116e-6f22-b77f98803dcb@redhat.com>
 <20200611142214.GI2531@hirez.programming.kicks-ass.net>
 <b405aca6-a3b2-cf11-a482-2b4af1e548bd@redhat.com>
 <20200611235526.GC94665@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200612070101.GA879624@tardis>
 <20200615164902.GV8681@bombadil.infradead.org>
 <0c854a69-9b89-9e45-f2c1-e60e2a9d3f1c@redhat.com>
 <20200615204046.GW8681@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20200615204046.GW8681@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Mon, Jun 15, 2020 at 01:40:46PM -0700, Matthew Wilcox wrote:
> On Mon, Jun 15, 2020 at 01:13:51PM -0400, Waiman Long wrote:
> > On 6/15/20 12:49 PM, Matthew Wilcox wrote:
> > > On Fri, Jun 12, 2020 at 03:01:01PM +0800, Boqun Feng wrote:
> > > > On the archs using QUEUED_RWLOCKS, read_lock() is not always a recu=
rsive
> > > > read lock, actually it's only recursive if in_interrupt() is true. =
So
> > > > change the annotation accordingly to catch more deadlocks.
> > > [...]
> > >=20
> > > > +#ifdef CONFIG_LOCKDEP
> > > > +/*
> > > > + * read_lock() is recursive if:
> > > > + * 1. We force lockdep think this way in selftests or
> > > > + * 2. The implementation is not queued read/write lock or
> > > > + * 3. The locker is at an in_interrupt() context.
> > > > + */
> > > > +static inline bool read_lock_is_recursive(void)
> > > > +{
> > > > +	return force_read_lock_recursive ||
> > > > +	       !IS_ENABLED(CONFIG_QUEUED_RWLOCKS) ||
> > > > +	       in_interrupt();
> > > > +}
> > > I'm a bit uncomfortable with having the _lockdep_ definition of wheth=
er
> > > a read lock is recursive depend on what the _implementation_ is.
> > > The locking semantics should be the same, no matter which architecture
> > > you're running on.  If we rely on read locks being recursive in common
> > > code then we have a locking bug on architectures which don't use queu=
ed
> > > rwlocks.
> > >=20
> > > I don't know whether we should just tell the people who aren't using
> > > queued rwlocks that they have a new requirement or whether we should
> > > say that read locks are never recursive, but having this inconsistency
> > > is not a good idea!
> >=20
> > Actually, qrwlock is more restrictive. It is possible that systems with
> > qrwlock may hit deadlock which doesn't happens in other systems that use
> > recursive rwlock. However, the current lockdep code doesn't detect those
> > cases.
>=20
> Oops.  I misread.  Still, my point stands; we should have the same
> definition of how you're allowed to use locks from the lockdep point of
> view, even if the underlying implementation won't deadlock on a particular
> usage model.
>=20

I understand your point, but such a change will require us to notify
almost every developer using rwlocks and help them to get their code
right, and that requires time and work, while currently I want to focus
on the correctness of the detection, and without that being merged, we
don't have a way to detect those problems. So I think it's better that
we have the detection reviewed and tested for a while (given that x86
uses qrwlock, so it will get a lot chances for testing), after that we
we have the confidence (and the tool) to educate people the "new"
semantics of rwlock. So I'd like to keep this patch as it is for now.

>=20
> So I'd be happy with:
>=20
> +	return lockdep_pretend_in_interrupt || in_interrupt();
>=20
> to allow the test-suite to test that it works as expected, without
> actually disabling interrupts while the testsuite runs.

I've used 'force_read_lock_recursive' for this purpose in this patch.

Regards,
Boqun

>=20

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl7oDpwACgkQSXnow7UH
+ribmAf8CKbWou8H1eJ1D2OqhUl5Ni34wEsbB5ZWbbRZlSPQ5f1ZXE6Z4vdNzBCN
0EJOhNHJUJ5SFNPEDRaxOFSd8ydTme1P3zT07Pw5cg5ZHmHIYsZ7k+hVUeA6JI5m
s/O7Myv/3iJdnNWxNX7GkwGYfK9uTb1xSnimAbfswkl+VGAwgJeHCg7cz1gL3AAO
VW/6H07EvKMH6Sq5ElVyjh/kApaXHX5LzX/3NjXI3lPsmpgMQMVhBtqp6+XKDIkL
nsCI1AWtlriCp/B7CKNIfw9LPOCENnHqX0zvn/OoXF7/OeJgtt4ErBJisQkS2rQd
LsMpoIEfqhsV1jabnT5NsELNKl3MIg==
=gTso
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
