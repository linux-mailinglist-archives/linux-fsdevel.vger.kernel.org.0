Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8BBC7E735
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 02:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388383AbfHBAgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 20:36:09 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35417 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726825AbfHBAgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 20:36:09 -0400
Received: from callcc.thunk.org (96-72-84-49-static.hfc.comcastbusiness.net [96.72.84.49] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x720YwGJ013105
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Aug 2019 20:34:59 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0D23C4202F5; Thu,  1 Aug 2019 20:34:58 -0400 (EDT)
Date:   Thu, 1 Aug 2019 20:34:57 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Phillip Lougher <phillip.lougher@gmail.com>
Cc:     921146@bugs.debian.org, hartmans@debian.org,
        debian-ctte@lists.debian.org,
        =?iso-8859-1?B?TOFzemzzIEL2c3r2cm3pbnlpIChHQ1Mp?= <gcs@debian.org>,
        Alexander Couzens <lynxis@fe80.eu>,
        linux-fsdevel@vger.kernel.org,
        linux-embedded <linux-embedded@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bug#921146: Program mksquashfs from squashfs-tools 1:4.3-11 does
 not make use all CPU cores
Message-ID: <20190802003457.GD17372@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Phillip Lougher <phillip.lougher@gmail.com>, 921146@bugs.debian.org,
        hartmans@debian.org, debian-ctte@lists.debian.org,
        =?iso-8859-1?B?TOFzemzzIEL2c3r2cm3pbnlpIChHQ1Mp?= <gcs@debian.org>,
        Alexander Couzens <lynxis@fe80.eu>, linux-fsdevel@vger.kernel.org,
        linux-embedded <linux-embedded@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAB3wodfF=Gc3FbKedU4JBWi8hZLxcBPUtVPipsCVnaHdFXGk8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB3wodfF=Gc3FbKedU4JBWi8hZLxcBPUtVPipsCVnaHdFXGk8Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Phillip,

Peace.

You may not like the fact that David Oberhollenzer (GitHub username
AgentD) started an effort to implement a new set of tools to generate
squashfs images on April 30th, 2019, and called it squashfs-tools-ng.

However, it's really not fair to complain that there is a "violation
of copyright" given that all of squashfs-tools was released is under
the GPL.  Using some text from squashfs-tools in the package
description or documentation of squashfs-tools-ng is totally allowed
under the GPL.  You could complain that they didn't include an
acknowledgement that text was taken from your program.  But then give
them time to fix up the acknowledgements.  Assuming good faith is
always a good default.

The other thing that you've complained about is that some folks have
(inaccurately, in your view) described squashfs-tools as not being
maintained.  I'd encourage you to take a step back, and consider how
this might be quite understandable how they might have gotten that
impression.

First of all, let's look on the documentation in kernel source tree,
located at Documentation/filesystems/squashfs.txt.  It states that
squashfs-tools's web site is www.squashfs.org, and the git tree is at
git://git.kernel.org/pub/scm/fs/squashfs/squashfs-tools.git.

The web site www.squashfs.org is not currently responding, but
according to the Internet Archive, it was redirecting to
http://squashfs.sourceforge.net/.  This web site describes the latest
version of squashfs-tools is 4.2, released in February 2011, It
apparently wasn't updated when squashfs-tools 4.3 was released in May
2014.

The git.kernel.org tree is identical to the sourceforge.net's git
tree.  That tree's most recent commit is from August 2017, e38956b9
("squashfs-tools: Add zstd support").  Now, the fascinating thing is
that the github tree has a completely different commit-id for the same
commit is 61133613 ("squashfs-tools: Add zstd support").  The git
commit that the two trees have in common is 9c1db6d1 from September
2014.

Reconstructing the git history, you didn't make any commits between
September 2014 and March 2017.  At that time, you merged a number of
github pull requests between 2014 and 2017, but then exported them as
patches and applied them on the kernel.org/sourceforge git trees.
Why, I'm not sure.

In August 2017, you stopped updating the kernel.org and sourceforge
git trees, and abandoned them.  After that for the rest of 2017, you
merged one more pull request, and applied one commit to add the -nold
option.  In 2018, there were only two commits, in February and June.
And then nothing until April 2019 (about the time that squash-tools-ng
was started/announced), there has been a flurry of activity, including
merging github pull requests from 2017 and 2018, antd you've done a
lot of work since then.

I say this not to criticize the amount of attention you've paid to
squashfs-tools, but to point out that when David started work on
squashfs-tools-ng, it's not unreasonable that he might have gotten the
impression that development had ceased --- especially if he followed
the documentation in the kernel sources, and found an extremely
cobwebby website, and a git tree on git.kernel.org that hadn't been
updated since 2017, with substantive heavy development basically
ending in 2014 (which is also when the last release of squashfs-tools
was cut).  You don't need to ascribe malice to what might just simply
be an impression by looking in the official locations in the official
kernel documentation!

As a fellow kernel file system developer, let me make a few
suggestions.

* Don't worry about with "competing" software projects.  For a while,
  a multi-billion dollar company attempted to maintain a BSD-licensed
  "competition" to some of the programs in e2fsprogs.  This was
  because Andy Rubin was highly allergic to the GPL way back when.  I
  pointed the independent implementation was creating invalid file
  systems, and was buggy, and in general was making that billion
  dollar company's life harder, not easier.  They eventually gave up
  on it, and Android uses e2fsprogs these days.

  The whole point of open source is "may the best code win".  If
  you're convinced that you, as the upstream kernel developer, can do
  a better job maintaining the userspace tools, then instead of
  complaining and threatening to sue, just keep your head down, and
  keep improving your code, and in the end, the best code will win.

* I'd suggest that you make sure there is a single canonical git tree.
  It appears it's the github version of your git tree.  So... starting
  with your github tree, do a "git merge" of the master branch from
  git.kernel.org, and then push updates to github, git.kernel.org, and
  git.sf.code.net.  It's fine to have multiple mirrors of your git
  tree.  I maintain multiple copies of git e2fsprogs repo on
  git.kernel.org, github, and sourceforge.

* Please consider tagging your releases.  There are git tags for
  squashfs 3.1 and 3.2, but none of your 4.x releases.  It's going to
  make it much easier for other people to know which git commits
  correspond to your official releases.  For bonus points, you could
  use signed git tags.  If you need help getting that set up, please
  contact me off-line.  I'd be delighted to help you with that.

* Please consider updating the squashfs web site.  I acutally keep a
  copy of the e2fsprogs.sourceforge.net web site in the e2fsprogs git
  tree, under the "web" branch.  You can see it here:
  https://github.com/tytso/e2fsprogs/tree/web

* It can be handy to audit and apply/merge patches being carried by
  distributions.  Before I took over the Debian maintainership of
  e2fsprogs, I would periodically scan the debian patches (and I still
  keep an eye to see what Ubuntu and Fedora have in their local
  patches).  If any of those patches fix real bugs, I'll pull them
  into the e2fsprogs git repo, and then send a note to the
  distribution maintainer that I've done so, and let them know that in
  the next release, I've included their patch, and so they can drop it
  from their tree.  That way, I can find and fix bugs introduced by
  distribution patches.

In general, I've found that keeping on good terms with the
distribution packagers is really good thing from the perspective of
the upstream author.

Best regards,

						- Ted
						
