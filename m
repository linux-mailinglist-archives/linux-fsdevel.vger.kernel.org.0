Return-Path: <linux-fsdevel+bounces-970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCF17D4613
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 05:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FCACB20EE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 03:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8767468;
	Tue, 24 Oct 2023 03:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Yka22y6G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931471863
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 03:40:42 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A512CB7
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 20:40:40 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9de3f66e5so24324755ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 20:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1698118840; x=1698723640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oWeGYZJ7Zqr0SZ51s3Tlaj8JTzPWhfxnA67l062INq8=;
        b=Yka22y6GudilGqFN93hZ3gwUjSZ7fiAGVB18y4YS4VOx58FRysiSaOTltq7hIkbDBd
         HPXEDh59iJ3MMQ96QGEDnefC0uQijgkyObUH9MU4SVox2nSN+nx8v13NOTjz8p3rnxMY
         jD8H5GanpdTZOGT+9uo9YTlYuv2KagQsVwNsOG3qC3oci8YOhcZRYJ7jn0lz/Q/P6e27
         PLsZyIvvJ5kJ+BVqjs3Gpf3tuW9rtUzbWudkY7Z16SUUP/5epPAtS32tHEwpdoAZO2rj
         OZ5NlqtIiGQTPibS/tUMx/VVSgXuisk/853Fpn45b9rUTefWXD6Zy7yMeU/+HbSKPCG8
         H4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698118840; x=1698723640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWeGYZJ7Zqr0SZ51s3Tlaj8JTzPWhfxnA67l062INq8=;
        b=HwKl6HzujL3wYVMBuLj2cByMQO0aDFbQxTzipTZRKReDXb9ujefnaR/m/8QI9l9tiz
         PPqv17HJBdwZ7AnHl/cZ3ZgCq+5yEHJXjmulm+rZK9OTgbq1QdSpFb3NHjOqlDfZ90E5
         nE6uMrUADFpAx/e5n8m0z/Kr+GQJ7Y62SFuGKR0c+4n9HcRWmoGWS3AXQZRy61gmmksr
         7lnOJPmSK7KNauTdYQ2R9WMRsyb72tIDUtgETnm37H/MtPx8EW7OqMLsgHkX01xwOInO
         FggJzWIjZfoX69AFi2HsyVQVYW9iyZhfsAMYj0RJ2o5D5tXfVNLJrY70xZLDeb9kLBOz
         1V7Q==
X-Gm-Message-State: AOJu0Yx0LPqXAu59JxsOCyOD5t/LKvW15Ij2ieeSfn3lYT7GgH1tL2WB
	6sHgWC+SS0MQOSmtcH2b4yMhGw==
X-Google-Smtp-Source: AGHT+IHBoF+8WS2RfetzLDwdufPuai+lmlctVilCrpXxsuy5LNKEo/W+GvWNVlLVD0/hEfe7bag85w==
X-Received: by 2002:a17:903:84f:b0:1c9:d25c:17c6 with SMTP id ks15-20020a170903084f00b001c9d25c17c6mr8511411plb.1.1698118840059;
        Mon, 23 Oct 2023 20:40:40 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902d2ce00b001c739768214sm6668917plc.92.2023.10.23.20.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 20:40:39 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qv8HU-0039F0-1Z;
	Tue, 24 Oct 2023 14:40:36 +1100
Date: Tue, 24 Oct 2023 14:40:36 +1100
From: Dave Chinner <david@fromorbit.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
Message-ID: <ZTc8tClCRkfX3kD7@dread.disaster.area>
References: <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
 <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
 <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
 <ZTGncMVw19QVJzI6@dread.disaster.area>
 <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
 <ZTWfX3CqPy9yCddQ@dread.disaster.area>
 <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
 <ZTcBI2xaZz1GdMjX@dread.disaster.area>
 <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>

On Mon, Oct 23, 2023 at 02:18:12PM -1000, Linus Torvalds wrote:
> On Mon, 23 Oct 2023 at 13:26, Dave Chinner <david@fromorbit.com> wrote:
> >
> > The problem is the first read request after a modification has been
> > made. That is causing relatime to see mtime > atime and triggering
> > an atime update. XFS sees this, does an atime update, and in
> > committing that persistent inode metadata update, it calls
> > inode_maybe_inc_iversion(force = false) to check if an iversion
> > update is necessary. The VFS sees I_VERSION_QUERIED, and so it bumps
> > i_version and tells XFS to persist it.
> 
> Could we perhaps just have a mode where we don't increment i_version
> for just atime updates?
>
> Maybe we don't even need a mode, and could just decide that atime
> updates aren't i_version updates at all?

We do that already - in memory atime updates don't bump i_version at
all. The issue is the rare persistent atime update requests that
still happen - they are the ones that trigger an i_version bump on
XFS, and one of the relatime heuristics tickle this specific issue.

If we push the problematic persistent atime updates to be in-memory
updates only, then the whole problem with i_version goes away....

> Yes, yes, it's obviously technically a "inode modification", but does
> anybody actually *want* atime updates with no actual other changes to
> be version events?

Well, yes, there was. That's why we defined i_version in the on disk
format this way well over a decade ago. It was part of some deep
dark magical HSM beans that allowed the application to combine
multiple scans for different inode metadata changes into a single
pass. atime changes was one of the things it needed to know about
for tiering and space scavenging purposes....

> Or maybe i_version can update, but callers of getattr() could have two
> bits for that STATX_CHANGE_COOKIE, one for "I care about atime" and
> one for others, and we'd pass that down to inode_query_version, and
> we'd have a I_VERSION_QUERIED and a I_VERSION_QUERIED_STRICT, and the
> "I care about atime" case ould set the strict one.

This makes correct behaviour reliant on the applicaiton using the
query mechanism correctly. I have my doubts that userspace
developers will be able to understand the subtle difference between
the two options and always choose correctly....

And then there's always the issue that we might end up with both
flags set and we get conflicting bug reports about how atime is not
behaving the way the applications want it to behave.

> Then inode_maybe_inc_iversion() could - for atome updates - skip the
> version update *unless* it sees that I_VERSION_QUERIED_STRICT bit.
> 
> Does that sound sane to people?

I'd much prefer we just do the right thing transparently at the
filesystem level; all we need is for the inode to be flagged that it
should be doing in memory atime updates rather than persistent
updates.

Perhaps the nfs server should just set a new S_LAZYTIME flag on
inodes it accesses similar to how we can set S_NOATIME on inodes to
elide atime updates altogether. Once set, the inode will behave that
way until it is reclaimed from memory....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

