Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6BCCE9B4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 13:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfJ3MFv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 08:05:51 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58685 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbfJ3MFv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 08:05:51 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 4D68921C7D;
        Wed, 30 Oct 2019 08:05:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 30 Oct 2019 08:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        0bKe4I34bkVZVlNJGLX1N6UGnDOElP8R/QJ2eIUb/30=; b=nRbBo4aYSC/++6Yc
        y+ipa2xgbakrOu5M2hhB+6MBXr0cU8blWbLNFXrzi3JwKN4Injbhto86Nrf+ZgQ1
        8BPJeKZS1EaSms93tR2fpsRYnqksnHtv6dU4GNCTjoehnR4cN2hASRJj5mC/Xjis
        hI5vmMrHq5yImJTWXxT3UY6lL7ORgUB3G6Z73T515jegvfeYKdIKP++bNxVrrOf1
        A1b0AUmcJF2zZURpnzARkGqqNHYoCYjceEaEmQkbJp3r1cAyTQhm8fDjZJ88Wk2z
        fH8DhOxYvhYAemCnYV1HAfzjLCYtkgqYmOI4FSV+7c2RLtJdE35DlylXFj6uMiN5
        XgorUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=0bKe4I34bkVZVlNJGLX1N6UGnDOElP8R/QJ2eIUb/
        30=; b=eb0zJuK2reRmQw1blvzDsMDOHF0Cm/dtRY7lwUaX1GOE2RwGmfCM0o1Oo
        DTBzGmRJG7phKNsY1RNo03p7aNgR7LQxHpkfDnZSIYY/1ISYbTIm3ZqPBteDda6d
        rhJYTRjtc0BaobaBPvqWVWuYY8AncStqwhIAB+vRJ3CRfkLJoySa10piW93hQ0pB
        q/NlGkKkeSu5yN3YcgEfWzyDSBRGkdRxNIcri4p38G4jhoUCz0HjIDqg5IPc4D25
        f1JYGkxm9ihw60wzlpfeXVGnBY9cwLruTGajLR+7KZFGzIo1NIPOcluiD0LxM+Fg
        8nfPzEsOFQGBc2OK4YUKzsv6o8OfA==
X-ME-Sender: <xms:nXy5XQ7GH9AbEjxBwAYc2nPSE3LQCgaBdgmEhZPLPFuYGcP63MIBrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedruddtfedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucffohhmrghinhepthhokh
    drlhgsnecukfhppeduudekrddvtdekrddukeejrdefvdenucfrrghrrghmpehmrghilhhf
    rhhomheprhgrvhgvnhesthhhvghmrgifrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:nXy5Xfv1f7syNXkp7h0BmfgYv5vKdVuC_tWu2rvL5KFa4jZNNWLmcw>
    <xmx:nXy5XZ5zIOeWBssYxK4rXtRqyY9fMuPsDN9fyuQ66_fy10xVOEOeiw>
    <xmx:nXy5XSV873jlTyvBtNC4Jd59tTHsDkanv1BMdmmqfTTnpRQvixRHLA>
    <xmx:nny5XcKaknNv_FAhAL6Y_IwaZjJO3GT66WRNb3nQOGUVX0brAeQdag>
Received: from mickey.themaw.net (unknown [118.208.187.32])
        by mail.messagingengine.com (Postfix) with ESMTPA id B727F80059;
        Wed, 30 Oct 2019 08:05:47 -0400 (EDT)
Message-ID: <4a477088af70c1897918af6ff2712d643ed2273b.camel@themaw.net>
Subject: Re: [RFC] Don't propagate automount
From:   Ian Kent <raven@themaw.net>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     viro@zeniv.linux.org.uk, autofs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Wed, 30 Oct 2019 20:05:44 +0800
In-Reply-To: <20191029160017.33chq3w2alyzscfa@fiona>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-10-29 at 11:00 -0500, Goldwyn Rodrigues wrote:
> On 14:39 29/10, Ian Kent wrote:
> > On Tue, 2019-10-29 at 07:57 +0800, Ian Kent wrote:
> > > On Mon, 2019-10-28 at 11:28 -0500, Goldwyn Rodrigues wrote:
> > > > Hi Ian,
> > > > 
> > > > On 10:14 02/10, Ian Kent wrote:
> > > > > On Tue, 2019-10-01 at 14:09 -0500, Goldwyn Rodrigues wrote:
> > > > <snip>
> > > > 
> > > > > Anyway, it does sound like it's worth putting time into
> > > > > your suggestion of a kernel change.
> > > > > 
> > > > > Unfortunately I think it's going to take a while to work
> > > > > out what's actually going on with the propagation and I'm
> > > > > in the middle of some other pressing work right now.
> > > > 
> > > > Have you have made any progress on this issue?
> > > 
> > > Sorry I haven't.
> > > I still want to try and understand what's going on there.
> > > 
> > > > As I mentioned, I am fine with a userspace solution of
> > > > defaulting
> > > > to slave mounts all of the time instead of this kernel patch.
> > > 
> > > Oh, I thought you weren't keen on that recommendation.
> > > 
> > > That shouldn't take long to do so I should be able to get that
> > > done
> > > and post a patch pretty soon.
> > > 
> > > I'll get back to looking at the mount propagation code when I get
> > > a
> > > chance. Unfortunately I haven't been very successful when making
> > > changes to that area of code in the past ...
> > 
> > After working on this patch I'm even more inclined to let the
> > kernel
> > do it's propagation thing and set the autofs mounts, either
> > silently
> > by default or explicitly by map entry option.
> > 
> > Because it's the propagation setting of the parent mount that
> > controls
> > the propagation of its children there shouldn't be any chance of a
> > race so this should be reliable.
> > 
> > Anyway, here is a patch, compile tested only, and without the
> > changelog
> > hunk I normally add to save you possible conflicts. But unless
> > there
> > are any problems found this is what I will eventually commit to the
> > repo.
> > 
> > If there are any changes your not aware of I'll let you know.
> > 
> > Clearly this depends on the other two related patches for this
> > issue.
> 
> This works good for us. Thanks.
> However, I have some review comments for the patch.

I think this one should do the trick.

autofs-5.1.6 - make bind mounts propagation slave by default

From: Ian Kent <raven@themaw.net>

Make setting mount propagation on bind mounts mandatory with a default
of propagation slave.

When using multi-mounts that have bind mounts the bind mount will have
the same properties as its parent which is commonly propagation shared.
And if the mount target is also propagation shared this can lead to a
deadlock when attempting to access the offset mounts. When this happens
an unwanted offset mount is propagated back to the target file system
resulting in a deadlock since the automount target is itself an
(unwanted) automount trigger.

This problem has been present much longer than I originally thought,
perhaps since mount propagation was introduced into the kernel, so
explicitly setting bind mount propagation is the sensible thing to do.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 include/automount.h  |    9 +++++----
 lib/master_parse.y   |   24 +++++++++++++-----------
 lib/master_tok.l     |    1 +
 man/auto.master.5.in |   19 ++++++++++---------
 modules/mount_bind.c |   40 ++++++++++++++++++++++------------------
 5 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/include/automount.h b/include/automount.h
index 4fd0ba96..fe9c7fee 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -551,14 +551,15 @@ struct kernel_mod_version {
 #define MOUNT_FLAG_AMD_CACHE_ALL	0x0080
 
 /* Set mount propagation for bind mounts */
-#define MOUNT_FLAG_SLAVE		0x0100
-#define MOUNT_FLAG_PRIVATE		0x0200
+#define MOUNT_FLAG_SHARED		0x0100
+#define MOUNT_FLAG_SLAVE		0x0200
+#define MOUNT_FLAG_PRIVATE		0x0400
 
 /* Use strict expire semantics if requested and kernel supports it */
-#define MOUNT_FLAG_STRICTEXPIRE		0x0400
+#define MOUNT_FLAG_STRICTEXPIRE		0x0800
 
 /* Indicator for applications to ignore the mount entry */
-#define MOUNT_FLAG_IGNORE		0x0800
+#define MOUNT_FLAG_IGNORE		0x1000
 
 struct autofs_point {
 	pthread_t thid;
diff --git a/lib/master_parse.y b/lib/master_parse.y
index f817f739..3f36b0aa 100644
--- a/lib/master_parse.y
+++ b/lib/master_parse.y
@@ -59,8 +59,6 @@ static long timeout;
 static long negative_timeout;
 static unsigned symlnk;
 static unsigned strictexpire;
-static unsigned slave;
-static unsigned private;
 static unsigned nobind;
 static unsigned ghost;
 extern unsigned global_selection_options;
@@ -72,6 +70,11 @@ static int tmp_argc;
 static char **local_argv;
 static int local_argc;
 
+#define PROPAGATION_SHARED	MOUNT_FLAG_SHARED
+#define PROPAGATION_SLAVE	MOUNT_FLAG_SLAVE
+#define PROPAGATION_PRIVATE	MOUNT_FLAG_PRIVATE
+static unsigned int propagation;
+
 static char errstr[MAX_ERR_LEN];
 
 static unsigned int verbose;
@@ -106,7 +109,7 @@ static int master_fprintf(FILE *, char *, ...);
 %token MAP
 %token OPT_TIMEOUT OPT_NTIMEOUT OPT_NOBIND OPT_NOGHOST OPT_GHOST OPT_VERBOSE
 %token OPT_DEBUG OPT_RANDOM OPT_USE_WEIGHT OPT_SYMLINK OPT_MODE
-%token OPT_STRICTEXPIRE OPT_SLAVE OPT_PRIVATE
+%token OPT_STRICTEXPIRE OPT_SHARED OPT_SLAVE OPT_PRIVATE
 %token COLON COMMA NL DDASH
 %type <strtype> map
 %type <strtype> options
@@ -208,6 +211,7 @@ line:
 	| PATH OPT_TIMEOUT { master_notify($1); YYABORT; }
 	| PATH OPT_SYMLINK { master_notify($1); YYABORT; }
 	| PATH OPT_STRICTEXPIRE { master_notify($1); YYABORT; }
+	| PATH OPT_SHARED { master_notify($1); YYABORT; }
 	| PATH OPT_SLAVE { master_notify($1); YYABORT; }
 	| PATH OPT_PRIVATE { master_notify($1); YYABORT; }
 	| PATH OPT_NOBIND { master_notify($1); YYABORT; }
@@ -622,8 +626,9 @@ daemon_option: OPT_TIMEOUT NUMBER { timeout = $2; }
 	| OPT_NTIMEOUT NUMBER { negative_timeout = $2; }
 	| OPT_SYMLINK	{ symlnk = 1; }
 	| OPT_STRICTEXPIRE { strictexpire = 1; }
-	| OPT_SLAVE	{ slave = 1; }
-	| OPT_PRIVATE	{ private = 1; }
+	| OPT_SHARED	{ propagation = PROPAGATION_SHARED; }
+	| OPT_SLAVE	{ propagation = PROPAGATION_SLAVE; }
+	| OPT_PRIVATE	{ propagation = PROPAGATION_PRIVATE; }
 	| OPT_NOBIND	{ nobind = 1; }
 	| OPT_NOGHOST	{ ghost = 0; }
 	| OPT_GHOST	{ ghost = 1; }
@@ -697,8 +702,7 @@ static void local_init_vars(void)
 	negative_timeout = 0;
 	symlnk = 0;
 	strictexpire = 0;
-	slave = 0;
-	private = 0;
+	propagation = PROPAGATION_SLAVE;
 	nobind = 0;
 	ghost = defaults_get_browse_mode();
 	random_selection = global_selection_options & MOUNT_FLAG_RANDOM_SELECT;
@@ -899,6 +903,8 @@ int master_parse_entry(const char *buffer, unsigned int default_timeout, unsigne
 			return 0;
 		}
 	}
+	entry->ap->flags = propagation;
+
 	if (random_selection)
 		entry->ap->flags |= MOUNT_FLAG_RANDOM_SELECT;
 	if (use_weight)
@@ -907,10 +913,6 @@ int master_parse_entry(const char *buffer, unsigned int default_timeout, unsigne
 		entry->ap->flags |= MOUNT_FLAG_SYMLINK;
 	if (strictexpire)
 		entry->ap->flags |= MOUNT_FLAG_STRICTEXPIRE;
-	if (slave)
-		entry->ap->flags |= MOUNT_FLAG_SLAVE;
-	if (private)
-		entry->ap->flags |= MOUNT_FLAG_PRIVATE;
 	if (negative_timeout)
 		entry->ap->negative_timeout = negative_timeout;
 	if (mode && mode < LONG_MAX)
diff --git a/lib/master_tok.l b/lib/master_tok.l
index 7486710b..87a6b958 100644
--- a/lib/master_tok.l
+++ b/lib/master_tok.l
@@ -389,6 +389,7 @@ MODE		(--mode{OPTWS}|--mode{OPTWS}={OPTWS})
 	-?symlink		{ return(OPT_SYMLINK); }
 	-?nobind		{ return(OPT_NOBIND); }
 	-?nobrowse		{ return(OPT_NOGHOST); }
+	-?shared		{ return(OPT_SHARED); }
 	-?slave			{ return(OPT_SLAVE); }
 	-?private		{ return(OPT_PRIVATE); }
 	-?strictexpire		{ return(OPT_STRICTEXPIRE); }
diff --git a/man/auto.master.5.in b/man/auto.master.5.in
index 6e510a59..2a0b672a 100644
--- a/man/auto.master.5.in
+++ b/man/auto.master.5.in
@@ -208,17 +208,18 @@ applications scanning the mount tree. Note that this doesn't completely
 resolve the problem of expired automounts being immediately re-mounted
 due to application accesses triggered by the expire itself.
 .TP
-.I slave \fPor\fI private
+.I slave\fP, \fIprivate\fP or \fIshared\fP
 This option allows mount propagation of bind mounts to be set to
-either \fIslave\fP or \fIprivate\fP. This option may be needed when using
-multi-mounts that have bind mounts that bind to a file system that is
-propagation shared. This is because the bind mount will have the same
-properties as its target which causes problems for offset mounts. When
-this happens an unwanted offset mount is propagated back to the target
-file system resulting in a deadlock when attempting to access the offset.
+\fIslave\fP, \fIprivate\fP or \fIshared\fP. This option defaults to
+\fIslave\fP if no option is given. When using multi-mounts that have
+bind mounts the bind mount will have the same properties as its parent
+which is commonly propagation \fIshared\fP. And if the mount target is
+also propagation \fIshared\fP this can lead to a deadlock when attempting
+to access the offset mounts. When this happens an unwanted offset mount
+is propagated back to the target file system resulting in a deadlock
+since the automount target is itself an (unwanted) automount trigger.
 This option is an autofs pseudo mount option that can be used in the
-master map only. By default, bind mounts will inherit the mount propagation
-of the target file system.
+master map only.
 .TP
 .I "\-r, \-\-random-multimount-selection"
 Enables the use of random selection when choosing a host from a
diff --git a/modules/mount_bind.c b/modules/mount_bind.c
index 9cba0d7a..5253501c 100644
--- a/modules/mount_bind.c
+++ b/modules/mount_bind.c
@@ -153,6 +153,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 
 	if (!symlnk && bind_works) {
 		int status, existed = 1;
+		int flags;
 
 		debug(ap->logopt, MODPREFIX "calling mkdir_path %s", fullpath);
 
@@ -190,24 +191,27 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 			      what, fstype, fullpath);
 		}
 
-		if (ap->flags & (MOUNT_FLAG_SLAVE | MOUNT_FLAG_PRIVATE)) {
-			int flags = MS_SLAVE;
-
-			if (ap->flags & MOUNT_FLAG_PRIVATE)
-				flags = MS_PRIVATE;
-
-			/* The bind mount has succeeded but if the target
-			 * mount is propagation shared propagation of child
-			 * mounts (autofs offset mounts for example) back to
-			 * the target of the bind mount must be avoided or
-			 * autofs trigger mounts will deadlock.
-			 */
-			err = mount(NULL, fullpath, NULL, flags, NULL);
-			if (err) {
-				warn(ap->logopt,
-				     "failed to set propagation for %s",
-				     fullpath, root);
-			}
+		/* The bind mount has succeeded, now set the mount propagation.
+		 *
+		 * The default is propagation shared, change it if the master
+		 * map entry has a different option specified.
+		 */
+		flags = MS_SLAVE;
+		if (ap->flags & MOUNT_FLAG_PRIVATE)
+			flags = MS_PRIVATE;
+		else if (ap->flags & MOUNT_FLAG_SHARED)
+			flags = MS_SHARED;
+
+		/* Note: If the parent mount is propagation shared propagation
+		 *  of child mounts (autofs offset mounts for example) back to
+		 *  the target of the bind mount can happen in some cases and
+		 *  must be avoided or autofs trigger mounts will deadlock.
+		 */
+		err = mount(NULL, fullpath, NULL, flags, NULL);
+		if (err) {
+			warn(ap->logopt,
+			     "failed to set propagation for %s",
+			     fullpath, root);
 		}
 
 		return 0;


