Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0B67ECE7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 08:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389113AbfHBGvF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 02:51:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44798 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389079AbfHBGvD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 02:51:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id k18so71777913ljc.11;
        Thu, 01 Aug 2019 23:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=cIuTpv9Ez6/lzFnCs/Jkrrw358Qd2KUug5i+M9hiD+M=;
        b=ct7DMPCJnhIm0oACQ9uy95z8kOUnf0Hk5OYV01iLig7xoZ00hwQ1VDkSe6QpPlV00C
         IspVKMTk1Dnq68J401j2aagriSui5hPwc4/j9QfsRCL23sttynMOCWBlu+bdBaPYZh8r
         LSNUV7jb9HSdaU8BFWJnq2Xi6pbI+5Xm46168V126b+SJE05sx1syvU+Tc7bcmMtuNMF
         ahqlWw08FPXkfhaF13KWL19wg6m1UTcXQOIqivht+lXRgqigHayqs7DETCDpb+bo5GJj
         M3LOiK/xoUarWdoBqau+6jgQtdn5sWmFVjIqyYYd3LQ3F+VyEqL1dGFQX7K+TBMsMFC7
         dI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=cIuTpv9Ez6/lzFnCs/Jkrrw358Qd2KUug5i+M9hiD+M=;
        b=SSvVVbfS2kkknX1uRyZKImIdyCS8k6Wn9nkpDqeFcVdQL56P+Mq8rwGeCzu6NzRBKy
         ZHbWhboI7Meghrjil5dylCjGRZDBKqhnhQlQxg9THbRaGgT5tW67mOLRxDgs+fd3fVW4
         nU9EVdl8Be8jCY71u+q736rmHrWDNCe6TPJqj4c6cxs8IgRNUyermeQBPyNWkgnvkY/5
         YP7ohPQ4pz6zCC/I3F3so7TcU8iuu+rm/zFeQKlWqtYcfKHJoLZq/dpR54W4zW3/e+RS
         nmOvLf6gn/gcFVNdJJ5Nb5WA1o1P3KbxcSBHfZP76toxXmbqOP3pL3VSnCf1/lw68MW2
         yxYw==
X-Gm-Message-State: APjAAAVG+tM05yaJAiddLbiJyVppbgf5fekt0uj4X3Q7JlMwrrfabXJB
        gAkfZtGC+ZwywUtqhje3cvRNknPc0MFpDaJ+yRc=
X-Google-Smtp-Source: APXvYqwQrjNJ5Iy+VFB/b65JBXtpeaE+b6JVnF1AsYghevfgYHffTGTI+x5J5+Sec22KjWlA0h8Zebq3yNR7+8yHOEs=
X-Received: by 2002:a2e:5bdd:: with SMTP id m90mr67525845lje.46.1564728660911;
 Thu, 01 Aug 2019 23:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAB3wodfF=Gc3FbKedU4JBWi8hZLxcBPUtVPipsCVnaHdFXGk8Q@mail.gmail.com>
 <20190802003457.GD17372@mit.edu>
In-Reply-To: <20190802003457.GD17372@mit.edu>
From:   Phillip Lougher <phillip.lougher@gmail.com>
Date:   Fri, 2 Aug 2019 07:50:49 +0100
Message-ID: <CAB3wodc25AH=kRif7YuQ6XVonRq_jqeTZsPdfOvnMAQAmE2OaA@mail.gmail.com>
Subject: Re: Bug#921146: Program mksquashfs from squashfs-tools 1:4.3-11 does
 not make use all CPU cores
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Phillip Lougher <phillip.lougher@gmail.com>,
        921146@bugs.debian.org, hartmans@debian.org,
        debian-ctte@lists.debian.org,
        =?UTF-8?B?TMOhc3psw7MgQsO2c3rDtnJtw6lueWkgKEdDUyk=?= 
        <gcs@debian.org>, Alexander Couzens <lynxis@fe80.eu>,
        linux-fsdevel@vger.kernel.org,
        linux-embedded <linux-embedded@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 2, 2019 at 1:35 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> Phillip,
>

Hi Theodore (Ted),

Thank-you for your kind and well intentioned email.  It has
de-escalated tensions on my side.

It is very late here, and so I can only be brief, but, I want this
said as soon as possible.

> Peace.

Yes, I would very much like that to happen.

>
> You may not like the fact that David Oberhollenzer (GitHub username
> AgentD) started an effort to implement a new set of tools to generate
> squashfs images on April 30th, 2019, and called it squashfs-tools-ng.
>
> However, it's really not fair to complain that there is a "violation
> of copyright" given that all of squashfs-tools was released is under
> the GPL.  Using some text from squashfs-tools in the package
> description or documentation of squashfs-tools-ng is totally allowed
> under the GPL.  You could complain that they didn't include an
> acknowledgement that text was taken from your program.  But then give
> them time to fix up the acknowledgements.  Assuming good faith is
> always a good default.
>
> The other thing that you've complained about is that some folks have
> (inaccurately, in your view) described squashfs-tools as not being
> maintained.  I'd encourage you to take a step back, and consider how
> this might be quite understandable how they might have gotten that
> impression.
>
> First of all, let's look on the documentation in kernel source tree,
> located at Documentation/filesystems/squashfs.txt.  It states that
> squashfs-tools's web site is www.squashfs.org, and the git tree is at
> git://git.kernel.org/pub/scm/fs/squashfs/squashfs-tools.git.
>
> The web site www.squashfs.org is not currently responding, but
> according to the Internet Archive, it was redirecting to
> http://squashfs.sourceforge.net/.  This web site describes the latest
> version of squashfs-tools is 4.2, released in February 2011, It
> apparently wasn't updated when squashfs-tools 4.3 was released in May
> 2014.
>

I gave up on Sourceforge many years ago when it came unusable (in my
opinion) due to too many adverts.

If I knew how to remove Squashfs from Sourceforge to save confusion I
would have done so.

> The git.kernel.org tree is identical to the sourceforge.net's git
> tree.  That tree's most recent commit is from August 2017, e38956b9
> ("squashfs-tools: Add zstd support").  Now, the fascinating thing is
> that the github tree has a completely different commit-id for the same
> commit is 61133613 ("squashfs-tools: Add zstd support").  The git
> commit that the two trees have in common is 9c1db6d1 from September
> 2014.
>
> Reconstructing the git history, you didn't make any commits between
> September 2014 and March 2017.  At that time, you merged a number of
> github pull requests between 2014 and 2017, but then exported them as
> patches and applied them on the kernel.org/sourceforge git trees.
> Why, I'm not sure.
>

I clicked the web merge button on GitHub, and then ended up with the
patches in the GitHUb repository (which I didn't use at the time), and
synced manually with kernel.org/sourceforge.

Blame lack of knowledge of GitHub. on my behalf.  I tend to prefer
command-interfaces which can be scripted.

> In August 2017, you stopped updating the kernel.org and sourceforge
> git trees, and abandoned them.  After that for the rest of 2017, you
> merged one more pull request, and applied one commit to add the -nold
> option.  In 2018, there were only two commits, in February and June.
> And then nothing until April 2019 (about the time that squash-tools-ng
> was started/announced), there has been a flurry of activity, including
> merging github pull requests from 2017 and 2018, antd you've done a
> lot of work since then.
>

The start of development in April and the co-incidence with the
squashfs-tools-ng project is purely coincidental.   I didn't know
anything about squashfs-tools-ng until Matt Turner of Gentoo mentioned
it in an issue on GitHub
(https://github.com/plougher/squashfs-tools/issues/25) nine days ago.

I didn't know about this co-incidence until you pointed it out.  This
in fact may explain some of the mis-understanding.

I meant to do some development on Squashfs-tools over the last
Christmas vacation.  I don't want to go into private family details.
but two deaths and a stroke in the family meant I had more important
things to deal with.  April was then the first opportunity I got to do
some development.

I try to keep people up to date with my intentions and commitments,
and I mentioned all this in another issue on GitHub
(https://github.com/plougher/squashfs-tools/issues/54).

> I say this not to criticize the amount of attention you've paid to
> squashfs-tools, but to point out that when David started work on
> squashfs-tools-ng, it's not unreasonable that he might have gotten the
> impression that development had ceased --- especially if he followed
> the documentation in the kernel sources, and found an extremely
> cobwebby website, and a git tree on git.kernel.org that hadn't been
> updated since 2017, with substantive heavy development basically
> ending in 2014 (which is also when the last release of squashfs-tools
> was cut).

In 2012-2014 I was put into a difficult position.  The previous year I
had started work @ Redhat as a kernel maintainer, which was leaving me
very little free time.

But the tools (especially Mksquashfs) which I had written in my spare
time between 2002-2009, when Squashfs was purely a hobbyist
filesystem, were increasingly breaking.  There were issues with stack
size, overflows, and basically dozens of things which fuzzers and
others like to exploit to produce crashes etc.

I decided I had to do a major rewrite of Mksquashfs.  It took over two
years, working all evenings available (from work) and most weekends
and at the end of it I felt completely burnt out.  My intention was
this should give me space to concentrate on other things for a while,
having cleared up all the issues.

I went on vacation a couple of months after release, deliberately
where there was no internet (off grid).  When I came back I found a
number of highly abusive emails from people, that had gotten more
abusive as I'd not answered them for a week.  I then had what I now
recognise to be a nervous breakdown.  I destroyed all my development
files and notes, and I couldn't bear to look at a line of Squashfs
code for a couple of months.

I obviously came back after a couple of months.  But, I took the
decision to not let Squashfs become the nightmare it had been for a
couple of years.  I would step back and cease to do pro-active
development and concentrate on security issues, bug fixes and
correspondence.

I genuinely felt things were going well and I was getting a good
balance between my life, my job, and Squashfs, until now.

Perhaps that is why I have reacted "so badly" now, it is called dismay.

I can't write anymore as it is already very late.

Best Regards

Phillip



> You don't need to ascribe malice to what might just simply
> be an impression by looking in the official locations in the official
> kernel documentation!
>
> As a fellow kernel file system developer, let me make a few
> suggestions.
>
> * Don't worry about with "competing" software projects.  For a while,
>   a multi-billion dollar company attempted to maintain a BSD-licensed
>   "competition" to some of the programs in e2fsprogs.  This was
>   because Andy Rubin was highly allergic to the GPL way back when.  I
>   pointed the independent implementation was creating invalid file
>   systems, and was buggy, and in general was making that billion
>   dollar company's life harder, not easier.  They eventually gave up
>   on it, and Android uses e2fsprogs these days.
>
>   The whole point of open source is "may the best code win".  If
>   you're convinced that you, as the upstream kernel developer, can do
>   a better job maintaining the userspace tools, then instead of
>   complaining and threatening to sue, just keep your head down, and
>   keep improving your code, and in the end, the best code will win.
>
> * I'd suggest that you make sure there is a single canonical git tree.
>   It appears it's the github version of your git tree.  So... starting
>   with your github tree, do a "git merge" of the master branch from
>   git.kernel.org, and then push updates to github, git.kernel.org, and
>   git.sf.code.net.  It's fine to have multiple mirrors of your git
>   tree.  I maintain multiple copies of git e2fsprogs repo on
>   git.kernel.org, github, and sourceforge.
>
> * Please consider tagging your releases.  There are git tags for
>   squashfs 3.1 and 3.2, but none of your 4.x releases.  It's going to
>   make it much easier for other people to know which git commits
>   correspond to your official releases.  For bonus points, you could
>   use signed git tags.  If you need help getting that set up, please
>   contact me off-line.  I'd be delighted to help you with that.
>
> * Please consider updating the squashfs web site.  I acutally keep a
>   copy of the e2fsprogs.sourceforge.net web site in the e2fsprogs git
>   tree, under the "web" branch.  You can see it here:
>   https://github.com/tytso/e2fsprogs/tree/web
>
> * It can be handy to audit and apply/merge patches being carried by
>   distributions.  Before I took over the Debian maintainership of
>   e2fsprogs, I would periodically scan the debian patches (and I still
>   keep an eye to see what Ubuntu and Fedora have in their local
>   patches).  If any of those patches fix real bugs, I'll pull them
>   into the e2fsprogs git repo, and then send a note to the
>   distribution maintainer that I've done so, and let them know that in
>   the next release, I've included their patch, and so they can drop it
>   from their tree.  That way, I can find and fix bugs introduced by
>   distribution patches.
>
> In general, I've found that keeping on good terms with the
> distribution packagers is really good thing from the perspective of
> the upstream author.
>
> Best regards,
>
>                                                 - Ted
>
