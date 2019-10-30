Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33030E9640
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 07:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfJ3GF4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 02:05:56 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:57471 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727497AbfJ3GF4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 02:05:56 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 848B23B5;
        Wed, 30 Oct 2019 02:05:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 30 Oct 2019 02:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        ZQuKgK35UnDX/4aCTt/Hp77mmLz+dYM7wfAXi3UcjkY=; b=n64blmN0jCnDeu5f
        nSmgbErJdVCyQbeox1bB2d1rbiKuxPF5bi2v7rPP2c69c6e0yUFH3GwDUZrom7ep
        bG9BraWU15FC/Qig8dTu0idSX3yzuBal1nQhIlatQqvg4Q0NJPltNPUeIlHhso0B
        mNID0hiyrfFoKrTigcU6Y5chVjHm345bugl7V7NVcUD4IEHLof4mwZyirQxFNatz
        kt2MTlGH6g5t6VH/2eVODaYn3shfWgOUXXI9DPmFl2RIo8WPhXbmPEkhZBFcOjnF
        9wUOPWZkE35nXwi0MD5kVUdORpI5d8VkV74Lrq7+uDKsaj+HlGSasz5oGOGvJvY+
        DJd5gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=ZQuKgK35UnDX/4aCTt/Hp77mmLz+dYM7wfAXi3Ucj
        kY=; b=vRV+bc4lX+oavEE9AqLhCJ6qT++73YKW5mycqEoBlFym3w/05IUFy4mBW
        M57PXxeNzGjU2Lbu5ZICB0G4rZQvlxQESmxrNy+8y4FcXrxkeBautCP+3YgOHdwi
        10rNmW/tjkz1DGOw5ubdF4PvfDxIMUdxo3/YXj84QiyfvUVFWqdof/BWZB30NaWZ
        RdLf/xRrJUIvHaW2XO91EXU/QnXGmrYNCymEIjDyy544MYDhvgBwgBFS1+4G4cNz
        8G1BtIpNvL6t83V3jcgyxpZgYD9O+WqN/dRYiNH7mBLzOt4pEmtlIFW1dH2HZBi4
        na/I6V0DyYgC7EKONGxPm/A4ll+5w==
X-ME-Sender: <xms:QSi5XSFqoScuMnw08DUgO2pkjYQ_Oh6c5LQErMp8oTKyS1o8GurFUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedruddtvddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucfkphepuddukedrvddtke
    drudekjedrfedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgr
    fidrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:QSi5XcjfMKn07SuAO8jRePUEt1FbDJ3LYe0Yy5Vj_ULwCefoaBd4kg>
    <xmx:QSi5XWTZ6qyrim9hG7GzSnNU4opET-LBnybFgJF3iLjBRjO6O8N7wQ>
    <xmx:QSi5Xc-6ofxVkmTV2Fg3HsgtUF30F3_4iPBXkMCMv0x9tmfvKPiuYA>
    <xmx:Qii5XRTvx_1XV5X_gZSelQrkS6Emx2Of9tepKuBsUMMRuOq6La3lpg>
Received: from mickey.themaw.net (unknown [118.208.187.32])
        by mail.messagingengine.com (Postfix) with ESMTPA id AF917306005E;
        Wed, 30 Oct 2019 02:05:51 -0400 (EDT)
Message-ID: <6422274be72dd4fe99978122553f991adbb5ec0c.camel@themaw.net>
Subject: Re: [RFC] Don't propagate automount
From:   Ian Kent <raven@themaw.net>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     viro@zeniv.linux.org.uk, autofs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Wed, 30 Oct 2019 14:05:48 +0800
In-Reply-To: <a7e2d30f30f435216e9533d79928e6cf2e953256.camel@themaw.net>
References: <d163042ab8fffd975a6d460488f1539c5f619eaa.camel@themaw.net>
         <7f31f0c2bf214334a8f7e855044c88a50e006f05.camel@themaw.net>
         <b2443a28939d6fe79ec9aa9d983f516c8269448a.camel@themaw.net>
         <20190927161643.ehahioerrlgehhud@fiona>
         <f0849206eff7179c825061f4b96d56c106c4eb66.camel@themaw.net>
         <20191001190916.fxko7vjcjsgzy6a2@fiona>
         <5117fb99760cc52ca24b103b70e197f6a619bee0.camel@themaw.net>
         <20191028162835.dtyjwwv57xqxrpap@fiona>
         <2dcbe8a95153e43cb179733f03de7da80fbbc6b2.camel@themaw.net>
         <8ca2feb2622165818f27c15564ca78529f31007e.camel@themaw.net>
         <20191029160017.33chq3w2alyzscfa@fiona>
         <a7e2d30f30f435216e9533d79928e6cf2e953256.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2019-10-30 at 14:01 +0800, Ian Kent wrote:
> On Tue, 2019-10-29 at 11:00 -0500, Goldwyn Rodrigues wrote:
> > On 14:39 29/10, Ian Kent wrote:
> > > On Tue, 2019-10-29 at 07:57 +0800, Ian Kent wrote:
> > > > On Mon, 2019-10-28 at 11:28 -0500, Goldwyn Rodrigues wrote:
> > > > > Hi Ian,
> > > > > 
> > > > > On 10:14 02/10, Ian Kent wrote:
> > > > > > On Tue, 2019-10-01 at 14:09 -0500, Goldwyn Rodrigues wrote:
> > > > > <snip>
> > > > > 
> > > > > > Anyway, it does sound like it's worth putting time into
> > > > > > your suggestion of a kernel change.
> > > > > > 
> > > > > > Unfortunately I think it's going to take a while to work
> > > > > > out what's actually going on with the propagation and I'm
> > > > > > in the middle of some other pressing work right now.
> > > > > 
> > > > > Have you have made any progress on this issue?
> > > > 
> > > > Sorry I haven't.
> > > > I still want to try and understand what's going on there.
> > > > 
> > > > > As I mentioned, I am fine with a userspace solution of
> > > > > defaulting
> > > > > to slave mounts all of the time instead of this kernel patch.
> > > > 
> > > > Oh, I thought you weren't keen on that recommendation.
> > > > 
> > > > That shouldn't take long to do so I should be able to get that
> > > > done
> > > > and post a patch pretty soon.
> > > > 
> > > > I'll get back to looking at the mount propagation code when I
> > > > get
> > > > a
> > > > chance. Unfortunately I haven't been very successful when
> > > > making
> > > > changes to that area of code in the past ...
> > > 
> > > After working on this patch I'm even more inclined to let the
> > > kernel
> > > do it's propagation thing and set the autofs mounts, either
> > > silently
> > > by default or explicitly by map entry option.
> > > 
> > > Because it's the propagation setting of the parent mount that
> > > controls
> > > the propagation of its children there shouldn't be any chance of
> > > a
> > > race so this should be reliable.
> > > 
> > > Anyway, here is a patch, compile tested only, and without the
> > > changelog
> > > hunk I normally add to save you possible conflicts. But unless
> > > there
> > > are any problems found this is what I will eventually commit to
> > > the
> > > repo.
> > > 
> > > If there are any changes your not aware of I'll let you know.
> > > 
> > > Clearly this depends on the other two related patches for this
> > > issue.
> > 
> > This works good for us. Thanks.
> > However, I have some review comments for the patch.
> > 
> > > --
> > > 
> > > autofs-5.1.6 - make bind mounts propagation slave by default
> > > 
> > > From: Ian Kent <raven@themaw.net>
> > > 
> > > Make setting mount propagation on bind mounts mandatory with a
> > > default
> > > of propagation slave.
> > > 
> > > When using multi-mounts that have bind mounts the bind mount will
> > > have
> > > the same properties as its parent which is commonly propagation
> > > shared.
> > > And if the mount target is also propagation shared this can lead
> > > to
> > > a
> > > deadlock when attempting to access the offset mounts. When this
> > > happens
> > > an unwanted offset mount is propagated back to the target file
> > > system
> > > resulting in a deadlock since the automount target is itself an
> > > (unwanted) automount trigger.
> > > 
> > > This problem has been present much longer than I originally
> > > thought,
> > > perhaps since mount propagation was introduced into the kernel,
> > > so
> > > explicitly setting bind mount propagation is the sensible thing
> > > to
> > > do.
> > > 
> > > Signed-off-by: Ian Kent <raven@themaw.net>
> > > ---
> > >  include/automount.h  |    9 +++++----
> > >  lib/master_parse.y   |   11 ++++++++---
> > >  lib/master_tok.l     |    1 +
> > >  man/auto.master.5.in |   19 ++++++++++---------
> > >  modules/mount_bind.c |   40 ++++++++++++++++++++++--------------
> > > ----
> > >  5 files changed, 46 insertions(+), 34 deletions(-)
> > > 
> > > diff --git a/include/automount.h b/include/automount.h
> > > index 4fd0ba96..fe9c7fee 100644
> > > --- a/include/automount.h
> > > +++ b/include/automount.h
> > > @@ -551,14 +551,15 @@ struct kernel_mod_version {
> > >  #define MOUNT_FLAG_AMD_CACHE_ALL	0x0080
> > >  
> > >  /* Set mount propagation for bind mounts */
> > > -#define MOUNT_FLAG_SLAVE		0x0100
> > > -#define MOUNT_FLAG_PRIVATE		0x0200
> > > +#define MOUNT_FLAG_SHARED		0x0100
> > > +#define MOUNT_FLAG_SLAVE		0x0200
> > > +#define MOUNT_FLAG_PRIVATE		0x0400
> > >  
> > >  /* Use strict expire semantics if requested and kernel supports
> > > it
> > > */
> > > -#define MOUNT_FLAG_STRICTEXPIRE		0x0400
> > > +#define MOUNT_FLAG_STRICTEXPIRE		0x0800
> > >  
> > >  /* Indicator for applications to ignore the mount entry */
> > > -#define MOUNT_FLAG_IGNORE		0x0800
> > > +#define MOUNT_FLAG_IGNORE		0x1000
> > >  
> > >  struct autofs_point {
> > >  	pthread_t thid;
> > > diff --git a/lib/master_parse.y b/lib/master_parse.y
> > > index f817f739..e9589a5a 100644
> > > --- a/lib/master_parse.y
> > > +++ b/lib/master_parse.y
> > > @@ -59,6 +59,7 @@ static long timeout;
> > >  static long negative_timeout;
> > >  static unsigned symlnk;
> > >  static unsigned strictexpire;
> > > +static unsigned shared;
> > >  static unsigned slave;
> > >  static unsigned private;
> > >  static unsigned nobind;
> > > @@ -106,7 +107,7 @@ static int master_fprintf(FILE *, char *,
> > > ...);
> > >  %token MAP
> > >  %token OPT_TIMEOUT OPT_NTIMEOUT OPT_NOBIND OPT_NOGHOST OPT_GHOST
> > > OPT_VERBOSE
> > >  %token OPT_DEBUG OPT_RANDOM OPT_USE_WEIGHT OPT_SYMLINK OPT_MODE
> > > -%token OPT_STRICTEXPIRE OPT_SLAVE OPT_PRIVATE
> > > +%token OPT_STRICTEXPIRE OPT_SHARED OPT_SLAVE OPT_PRIVATE
> > >  %token COLON COMMA NL DDASH
> > >  %type <strtype> map
> > >  %type <strtype> options
> > > @@ -208,6 +209,7 @@ line:
> > >  	| PATH OPT_TIMEOUT { master_notify($1); YYABORT; }
> > >  	| PATH OPT_SYMLINK { master_notify($1); YYABORT; }
> > >  	| PATH OPT_STRICTEXPIRE { master_notify($1); YYABORT; }
> > > +	| PATH OPT_SHARED { master_notify($1); YYABORT; }
> > >  	| PATH OPT_SLAVE { master_notify($1); YYABORT; }
> > >  	| PATH OPT_PRIVATE { master_notify($1); YYABORT; }
> > >  	| PATH OPT_NOBIND { master_notify($1); YYABORT; }
> > > @@ -622,6 +624,7 @@ daemon_option: OPT_TIMEOUT NUMBER { timeout =
> > > $2; }
> > >  	| OPT_NTIMEOUT NUMBER { negative_timeout = $2; }
> > >  	| OPT_SYMLINK	{ symlnk = 1; }
> > >  	| OPT_STRICTEXPIRE { strictexpire = 1; }
> > > +	| OPT_SHARED	{ shared = 1; }
> > >  	| OPT_SLAVE	{ slave = 1; }
> > >  	| OPT_PRIVATE	{ private = 1; }
> > >  	| OPT_NOBIND	{ nobind = 1; }
> > > @@ -907,8 +910,10 @@ int master_parse_entry(const char *buffer,
> > > unsigned int default_timeout, unsigne
> > >  		entry->ap->flags |= MOUNT_FLAG_SYMLINK;
> > >  	if (strictexpire)
> > >  		entry->ap->flags |= MOUNT_FLAG_STRICTEXPIRE;
> > > -	if (slave)
> > > -		entry->ap->flags |= MOUNT_FLAG_SLAVE;
> > > +	/* Default is propagation slave */
> > > +	entry->ap->flags |= MOUNT_FLAG_SLAVE;
> > > +	if (shared)
> > > +		entry->ap->flags |= MOUNT_FLAG_SHARED;
> > >  	if (private)
> > >  		entry->ap->flags |= MOUNT_FLAG_PRIVATE;
> > 
> > If the user mention shared or private flag, you will end up
> > enabling both MOUNT_FLAG_SLAVE and MOUNT_FLAG_SHARED.
> > It would be better to put it in a if..else if..else sequence.
> > These are options are mutually exclusive.
> 
> Thanks for noticing this obvious blunder.
> I'll fix that up and send an update.

And the new variable, shared, initialization is missing too!

> 
> Ian

