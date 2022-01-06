Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EE9486E01
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 00:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245650AbiAFXqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 18:46:15 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:40423 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245538AbiAFXqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:46:15 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D98803200583;
        Thu,  6 Jan 2022 18:46:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 06 Jan 2022 18:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        mS5zbJ214wOhNLtYIH8U+6E/Un0NpGJAgFEhf31fkYY=; b=as+4blKqTzjBTnJB
        6Qnx1gLBHrT6Yx6yU+oyhzmyX68RokDNnpHdiQHJ2vsGbmV/QQ0N6s+jVSrATfZ0
        A4vm+cBkiwUi6KKlC1dKCMpH3t7KSCUPyeMZ4g/jssTO7FnEAlDJzvnyPIrpL/0K
        ArFMVLvHVBvygG42iN4RFBJkFKi/mg3vb1Drt+j+M6owGZROgpWprUOsje1zNKcb
        njzYq2xpyIkN/gWEpUViw7gubPE9ueBwzJoCnTzffNjwFiOX8bnJ8PeOPzcAd4Up
        whvIlrgeMmviVWIPMJI8vwrDUkUJFfHKlGFnP9PEESB0HEatTbvshE+askMkUXAz
        /WX3Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=mS5zbJ214wOhNLtYIH8U+6E/Un0NpGJAgFEhf31fk
        YY=; b=Dfno8f2rhiXfdIIFccLaHqj5PsCYmA8CPuGS/pdH0Vy/gM0HMLMaFvzf3
        QCjdzQ1oCoMjXZ1EKzEIki7R/6zvN6iCwgfRFSg+caWekiwNHIC/Z/LsOvNZ8Ats
        XVYaZK7OYEkbGj+MO0G3utLef8cO3SJTt7IGoLmfTsZDdyoSsgSclSFGFg8QIya3
        iOcR4xhpjoEECraw/1ySUf4g3tmjWMtKBkTXw59tnW9oQhoUCCE1qqErC67NL9MZ
        WMROvJS3mOa4XLIsK+JYjMl6k6OVE64BB+w/iFY8/Qn2JMzNOy+8kljCFNOqw4g6
        oGdHfVqenyE14gzs2o8BdVumKd+bw==
X-ME-Sender: <xms:Rn_XYXbnf3wHyMSqwAvsY8C74GO3eLX42VRdfpmPxwGTZci-CMJYiw>
    <xme:Rn_XYWatJ-kpg415SATGCC-Qw0fSeQOqkX71_LOxxncdLLJRBTcQnSPNdALmUJCuW
    5Ekpid6yz_8>
X-ME-Received: <xmr:Rn_XYZ_QFjGItvxrmNcCdneRtqoD_VwWCiu1H6hS7VouzeY3cD2sl6jbHDce3C3IC6nWIgpzUfMLCksUXp-rbUo8yfMROSIv-M--51H8XUZgZnbObmpK_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegtddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:Rn_XYdoZnd994H38voZsNenFC1TdHgQB1J_7Fk56kezz3uVjK7w3vg>
    <xmx:Rn_XYSqiWXjQhCmprVMjNz8KzopPgDf-5HGG8P83JzpxRNwUNhOKyg>
    <xmx:Rn_XYTRkejHyGoEql-6C8VOqoM_-ucFkmtXJwb08mnRMJNscY3NibQ>
    <xmx:Rn_XYQHnUYxHtId39CcLvbkA88l43xOpnE4L5pSq95ze99AXQQK93A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jan 2022 18:46:12 -0500 (EST)
Message-ID: <4a13a560520e1ef522fcbb9f7dfd5e8c88d5b238.camel@themaw.net>
Subject: Re: [PATCH] namei: clear nd->root.mnt before O_CREAT unlazy
From:   Ian Kent <raven@themaw.net>
To:     Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org
Date:   Fri, 07 Jan 2022 07:46:10 +0800
In-Reply-To: <20220105180259.115760-1-bfoster@redhat.com>
References: <20220105180259.115760-1-bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-01-05 at 13:02 -0500, Brian Foster wrote:
> The unlazy sequence of an rcuwalk lookup occurs a bit earlier than
> normal for O_CREAT lookups (i.e. in open_last_lookups()). The create
> logic here historically invoked complete_walk(), which clears the
> nd->root.mnt pointer when appropriate before the unlazy.  This
> changed in commit 72287417abd1 ("open_last_lookups(): don't abuse
> complete_walk() when all we want is unlazy"), which refactored the
> create path to invoke unlazy_walk() and not consider nd->root.mnt.
> 
> This tweak negatively impacts performance on a concurrent
> open(O_CREAT) workload to multiple independent mounts beneath the
> root directory. This attributes to increased spinlock contention on
> the root dentry via legitimize_root(), to the point where the
> spinlock becomes the primary bottleneck over the directory inode
> rwsem of the individual submounts. For example, the completion rate
> of a 32k thread aim7 create/close benchmark that repeatedly passes
> O_CREAT to open preexisting files drops from over 700k "jobs per
> minute" to 30, increasing the overall test time from a few minutes
> to over an hour.
> 
> A similar, more simplified test to create a set of opener tasks
> across a set of submounts can demonstrate the problem more quickly.
> For example, consider sets of 100 open/close tasks each running
> against 64 independent filesystem mounts (i.e. 6400 tasks total),
> with each task completing 10k iterations before it exits. On an
> 80xcpu box running v5.16.0-rc2, this test completes in 50-55s. With
> this patch applied, the same test completes in 10-15s.
> 
> This is not the most realistic workload in the world as it factors
> out inode allocation in the filesystem. The contention can also be
> avoided by more selective use of O_CREAT or via use of relative
> pathnames. That said, this regression appears to be an unintentional
> side effect of code cleanup and might be unexpected for users.
> Restore original behavior prior to commit 72287417abd1 by factoring
> the rcu logic from complete_walk() into a new helper and invoke that
> from both places.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/namei.c | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 1f9d2187c765..b32fcbc99929 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -856,6 +856,22 @@ static inline int d_revalidate(struct dentry
> *dentry, unsigned int flags)
>                 return 1;
>  }
>  
> +static inline bool complete_walk_rcu(struct nameidata *nd)
> +{
> +       if (nd->flags & LOOKUP_RCU) {
> +               /*
> +                * We don't want to zero nd->root for scoped-lookups
> or
> +                * externally-managed nd->root.
> +                */
> +               if (!(nd->state & ND_ROOT_PRESET))
> +                       if (!(nd->flags & LOOKUP_IS_SCOPED))
> +                               nd->root.mnt = NULL;
> +               nd->flags &= ~LOOKUP_CACHED;
> +               return try_to_unlazy(nd);
> +       }
> +       return true;
> +}
> +
>  /**
>   * complete_walk - successful completion of path walk
>   * @nd:  pointer nameidata
> @@ -871,18 +887,8 @@ static int complete_walk(struct nameidata *nd)
>         struct dentry *dentry = nd->path.dentry;
>         int status;
>  
> -       if (nd->flags & LOOKUP_RCU) {
> -               /*
> -                * We don't want to zero nd->root for scoped-lookups
> or
> -                * externally-managed nd->root.
> -                */
> -               if (!(nd->state & ND_ROOT_PRESET))
> -                       if (!(nd->flags & LOOKUP_IS_SCOPED))
> -                               nd->root.mnt = NULL;
> -               nd->flags &= ~LOOKUP_CACHED;
> -               if (!try_to_unlazy(nd))
> -                       return -ECHILD;
> -       }
> +       if (!complete_walk_rcu(nd))
> +               return -ECHILD;
>  
>         if (unlikely(nd->flags & LOOKUP_IS_SCOPED)) {
>                 /*
> @@ -3325,10 +3331,9 @@ static const char *open_last_lookups(struct
> nameidata *nd,
>                 BUG_ON(nd->flags & LOOKUP_RCU);
>         } else {
>                 /* create side of things */
> -               if (nd->flags & LOOKUP_RCU) {
> -                       if (!try_to_unlazy(nd))
> -                               return ERR_PTR(-ECHILD);
> -               }
> +               if (!complete_walk_rcu(nd))
> +                       return ERR_PTR(-ECHILD);
> +
>                 audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
>                 /* trailing slashes? */
>                 if (unlikely(nd->last.name[nd->last.len]))

Looks good, assuming Al is ok with the re-factoring.
Reviewed-by: Ian Kent <raven@themaw.net>

Ian

