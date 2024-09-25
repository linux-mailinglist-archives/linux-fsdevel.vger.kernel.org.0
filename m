Return-Path: <linux-fsdevel+bounces-30124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF8798683F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 23:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6211C2178C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 21:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CC2157468;
	Wed, 25 Sep 2024 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="ftyCfFEq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fPJI5GWv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3E214A635;
	Wed, 25 Sep 2024 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727299229; cv=none; b=OhY4uBXwtkvwJLeekkO4bIlrA1BqhFj8d6d1eJPK0bdQwYjX5YOnGLVQUydEeKnGddn7pBHpULcwnjWHBoLgjItqh3HZA5g0ZcfTYiHlViPAtXplI6ueJSGKWkeeDXl26yppQv/6feRaDxPXgjNAOS2v2XE7EJerwQ33EqeKDao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727299229; c=relaxed/simple;
	bh=dnana6MFkrv6dKrC/vbID4wqoKEOttl8Owvqx/VCrHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8l9UQDCT+TKCn7662kdXl2kCcqI1gk1tY6u1N9/dLpY89yD19PBvmM9j7ZJZu4lOZ8S68E60eefzFfmwLPuhzmixr/iXD/9XXkSXic+cO1RzcY6NL2G0f1TgiJrata0yG4+Vqsr+WyzkmIcZYboU4bU40Of/cJKa8DqO8jt2Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=ftyCfFEq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fPJI5GWv; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 8C4651380249;
	Wed, 25 Sep 2024 17:20:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 25 Sep 2024 17:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727299226; x=1727385626; bh=knJ0ZhwDbb
	GACsQWxBY9OilKWDC1g00F6Yfm+LjMVHU=; b=ftyCfFEqY5zqgYKhpaAiNeDaJo
	RUCpm5n+muNT2xZ2iFq656bTOw8teKQD1n6QozbSVRKfa59d1Y0ItdlQVh9LE+E1
	QKexRy3XHmPwaiewpzKT6bfllow4OMs9lx8Yz/azGwxZnXCljBwPE+YK4lAZZsTy
	Ca//PA585G/92oHitDnFjzHstW1VXtYw4ToHmQgqq66fQld+mapS3fIlEMK0hc3L
	N/3PZL1904aSMh1SvDOlxFUj4RyfGPoKJlew02J3ta2+AtPbQBRa6KoAow99+KcL
	OjkDvcqxkSG9nKm3NHombOn35+a5AsTizZL6LMQgEJEQaIZYQ8OdxhFsKjkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727299226; x=1727385626; bh=knJ0ZhwDbbGACsQWxBY9OilKWDC1
	g00F6Yfm+LjMVHU=; b=fPJI5GWv1/hRU1mjDOJ3a0WFF256VuWg6vxPo6FDp/5w
	OuQZjWq1pBd2AynPOFyxhd08iT1UMVm9ICNI9lYgXyCpHpO+p7OIYwiJS8DOeIXJ
	bAaw+pwaLDTZgCSZafx4nzitsq22En8VyBJh3osUsgh3FgJtxgVB3BAWsrrnGA+x
	II710q/vNEYBX/5AzInFLOkfBjOvk4AfC9s4qjv8RECkzMxHleLT3Q15jDa1js46
	elnD14Gkn/Mngl18YqUXVAlG8Bp50WUWDV730xzftmR7aZal7I+aAz5XW4jJQuTi
	XOHwSKnAapc8XIkmwncorzYY3ewyrcw6zoxRPBEeEA==
X-ME-Sender: <xms:mX70Zv4pVeRr8jFeP6DxjUp5kHpa_lwnms3nFy9dozBXS6DDQRyG8Q>
    <xme:mX70Zk4xG_5K5YWLctlndWPBAcKJtoR3bwZlj2GL1vJBEDueMKHdO4nU5vuIQyEoS
    ycOJCyTaPziGXl6rA8>
X-ME-Received: <xmr:mX70ZmdqKK9fIy3AtahKlRm7097-uDefjQQWsQgZWNZfka_jYwHtsKqFxwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddthedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefvhigthhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhord
    hpihiiiigrqeenucggtffrrghtthgvrhhnpeeutedttefgjeefffehffffkeejueevieef
    udelgeejuddtfeffteeklefhleelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihiiiigrpdhnsggprhgt
    phhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptgihphhhrghrse
    gthihphhgrrhdrtghomhdprhgtphhtthhopegvsghivgguvghrmhesgihmihhsshhiohhn
    rdgtohhmpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukh
    dprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    rggtkhesshhushgvrdgtiidprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghh
    uhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheprghlvgigrdgrrh
    hinhhgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:mX70ZgJEpZHwVduHpogfNsxKZjZjfKgJ96Dw4JYdYN9ZpZ23LJ_mEg>
    <xmx:mX70ZjKFkyhfUCd11ZxL7uiQIDq-1MsQShZggCeQ4wGm_g-fxNeQuw>
    <xmx:mX70Zpw-eXeNuK9BGDMSuT586vLaX0t5_MHiCTwCLKn5L7iAFCwtHg>
    <xmx:mX70ZvJhTT-7T6wlxOKachLQBPL9hmxCtnSSCoCr75Pvy89Qa77vnA>
    <xmx:mn70Zljr1O_p8LI7Wm73cQ7HBgMr-lJ5x76YjlaJViyL1jvKcU3xzXp3>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Sep 2024 17:20:22 -0400 (EDT)
Date: Wed, 25 Sep 2024 15:20:19 -0600
From: Tycho Andersen <tycho@tycho.pizza>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: [RFC] exec: add a flag for "reasonable" execveat() comm
Message-ID: <ZvR+k3D1KGALOIWt@tycho.pizza>
References: <20240924141001.116584-1-tycho@tycho.pizza>
 <87msjx9ciw.fsf@email.froward.int.ebiederm.org>
 <20240925.152228-private.conflict.frozen.trios-TdUGhuI5Sb4v@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925.152228-private.conflict.frozen.trios-TdUGhuI5Sb4v@cyphar.com>

On Wed, Sep 25, 2024 at 05:50:10PM +0200, Aleksa Sarai wrote:
> On 2024-09-24, Eric W. Biederman <ebiederm@xmission.com> wrote:
> > Tycho Andersen <tycho@tycho.pizza> writes:
> > 
> > > From: Tycho Andersen <tandersen@netflix.com>
> > >
> > > Zbigniew mentioned at Linux Plumber's that systemd is interested in
> > > switching to execveat() for service execution, but can't, because the
> > > contents of /proc/pid/comm are the file descriptor which was used,
> > > instead of the path to the binary. This makes the output of tools like
> > > top and ps useless, especially in a world where most fds are opened
> > > CLOEXEC so the number is truly meaningless.
> > >
> > > This patch adds an AT_ flag to fix up /proc/pid/comm to instead be the
> > > contents of argv[0], instead of the fdno.
> > 
> > The kernel allows prctl(PR_SET_NAME, ...)  without any permission
> > checks so adding an AT_ flat to use argv[0] instead of the execed
> > filename seems reasonable.
> > 
> > Maybe the flag should be called AT_NAME_ARGV0.
> > 
> > 
> > That said I am trying to remember why we picked /dev/fd/N, as the
> > filename.
> > 
> > My memory is that we couldn't think of anything more reasonable to use.
> > Looking at commit 51f39a1f0cea ("syscalls: implement execveat() system
> > call") unfortunately doesn't clarify anything for me, except that
> > /dev/fd/N was a reasonable choice.
> > 
> > I am thinking the code could reasonably try:
> > 	get_fs_root_rcu(current->fs, &root);
> > 	path = __d_path(file->f_path, root, buf, buflen);
> > 
> > To see if a path to the file from the current root directory can be
> > found.  For files that are not reachable from the current root the code
> > still need to fallback to /dev/fd/N.
> > 
> > Do you think you can investigate that and see if that would generate
> > a reasonable task->comm?
> 
> The problem mentioned during the discussion after the talk was that
> busybox symlinks everything to the same program, so using d_path will
> give somewhat confusing results and so separate behaviour is still
> needed (though to be fair, the current results are also confusing).

I also remember that busybox used to do symlinks, but I just looked the
latest version on the docker hub (perhaps not representative...) and
it's all hard links, which works fine with the __d_path() trick.

> > It looks like a reasonable case can be made that while /dev/fd/N is
> > a good path for interpreters, it is never a good choice for comm,
> > so perhaps we could always use argv[0] if the fdpath is of the
> > form /dev/fd/N.
> > 
> > All of that said I am not a fan of the implementation below as it has
> > the side effect of replacing /dev/fd/N with a filename that is not
> > usable by #! interpreters.  So I suggest an implementation that affects
> > task->comm and not brpm->filename.
> 
> I think only affecting task->comm would be ideal.

Yep, I did this for the test above, and it worked fine:

        if (bprm->fdpath) {
                /*
                 * If fdpath was set, execveat() made up a path that will
                 * probably not be useful to admins running ps or similar.
                 * Let's fix it up to be something reasonable.
                 */
                struct path root;
                char *path, buf[1024];

                get_fs_root(current->fs, &root);
                path = __d_path(&bprm->file->f_path, &root, buf, sizeof(buf));

                __set_task_comm(me, kbasename(path), true);
        } else {
                __set_task_comm(me, kbasename(bprm->filename), true);
        }

obviously we don't want a stack allocated buffer, but triggering on
->fdpath != NULL seems like the right thing, so we won't need a flag
either.

The question is: argv[0] or __d_path()?

Tycho

