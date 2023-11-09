Return-Path: <linux-fsdevel+bounces-2592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9345B7E6E4A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 17:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33CDDB20F1F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C257210F1;
	Thu,  9 Nov 2023 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="an4/usvb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF4920B17;
	Thu,  9 Nov 2023 16:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B540BC433BB;
	Thu,  9 Nov 2023 16:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699546114;
	bh=9jv2+syvODBbcmGY4ew2QNcGO1aZvABUK26yZSJvayg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=an4/usvbiRel89q01Pnvd+TES/B31/7WCTra21aJC2vR167RVrBTD0T4l0Np+n4v2
	 EbNHWbE4mRlTd5664QNTBac6vz4tQNjuUPAC3mzSXSGjwmxfFbC0EtztrMUvvPWYxz
	 sWh1REN/5Ta35snZBzzhuRnh6NPnaQUCGtFqSS6jbo4+qkTAM968xLrAL3uV5ktTpn
	 y3QxjKJ6GsVIlGinqAPCFIpiDBiVj/TNhytdxD8mN4Z0u36nPI2e4kHizhl+ga9hTX
	 YcrNLvLA/u2tD3L89PolcPCLJ71qSrC12ls7rhoKQqiMWBmhKAiZSNIRpl39WLT7qF
	 OYkbTreIzsQaA==
Date: Thu, 9 Nov 2023 08:08:31 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
	josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	Anton Altaparmakov <anton@tuxera.com>,
	Namjae Jeon <linkinjeon@kernel.org>, Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Iurii Zaikin <yzaikin@google.com>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
	linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@lists.linux.dev,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	codalist@telemann.coda.cs.cmu.edu
Subject: Re: [PATCH 2/4] aio: Remove the now superfluous sentinel elements
 from ctl_table array
Message-ID: <20231109160831.GA1933@sol.localdomain>
References: <20231107-jag-sysctl_remove_empty_elem_fs-v1-0-7176632fea9f@samsung.com>
 <20231107-jag-sysctl_remove_empty_elem_fs-v1-2-7176632fea9f@samsung.com>
 <CGME20231108034239eucas1p2e5dacae548e47694184df217ee168da9@eucas1p2.samsung.com>
 <20231108034231.GB2482@sol.localdomain>
 <20231109160040.bahkcsp44t5xu7qo@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109160040.bahkcsp44t5xu7qo@localhost>

On Thu, Nov 09, 2023 at 05:00:40PM +0100, Joel Granados wrote:
> > >  static void __init fsverity_init_sysctl(void)
> > >  {
> > > +#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> > >  	fsverity_sysctl_header = register_sysctl("fs/verity",
> > >  						 fsverity_sysctl_table);
> > > +#else
> > > +	fsverity_sysctl_header = register_sysctl_sz("fs/verity",
> > > +						 fsverity_sysctl_table, 0);
> > > +#endif
> > >  	if (!fsverity_sysctl_header)
> > >  		panic("fsverity sysctl registration failed");
> > 
> > This does not make sense, and it causes a build error when CONFIG_FS_VERITY=y
> > and CONFIG_FS_VERITY_BUILTIN_SIGNATURES=n.
> > 
> > I think all you need to do is delete the sentinel element, the same as
> > everywhere else.  I just tested it, and it works fine.
> I found the reason why I added the CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> here: it is related to
> https://lore.kernel.org/all/20230705212743.42180-3-ebiggers@kernel.org/
> where the directory is registered with an element only if
> CONFIG_FS_VERITY_BUILTIN_SIGNATURES is defined. I had forgotten, but I
> even asked for a clarification on the patch :).
> 
> I see that that patch made it to v6.6. So the solution is not to remove
> the CONFIG_FS_VERITY_BUILTIN_SIGNATURES, but for me to rebase on top of
> a more up to date base.
> 
> @Eric: Please get back to me if the patch in
> https://lore.kernel.org/all/20230705212743.42180-3-ebiggers@kernel.org/
> is no longer relevant.
> 
> Best.

Yes, that patch was merged in 6.6.  I don't think it really matters here though,
other than the fact that it moved the code to a different file.  I believe all
you need to do is remove the sentinel element, the same as anywhere else:

diff --git a/fs/verity/init.c b/fs/verity/init.c
index a29f062f6047b..b64a76b9ac362 100644
--- a/fs/verity/init.c
+++ b/fs/verity/init.c
@@ -24,7 +24,6 @@ static struct ctl_table fsverity_sysctl_table[] = {
 		.extra2         = SYSCTL_ONE,
 	},
 #endif
-	{ }
 };
 
 static void __init fsverity_init_sysctl(void)

