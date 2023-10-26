Return-Path: <linux-fsdevel+bounces-1217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723C37D7AD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 04:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29615281E3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 02:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26A68F70;
	Thu, 26 Oct 2023 02:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="rJt/PWOp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB512F44
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 02:21:05 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0996133
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 19:21:03 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ca816f868fso2633805ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 19:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1698286863; x=1698891663; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xrnay9mlxBDi5+JAm8W67O95cADbTIj+Nxe1S7DfUFg=;
        b=rJt/PWOpcuUnXefRCM9NvIiNYqc1vUs1mkmKkAO7o0Zn+isCfMyxPLXgMU/wvUfZ0B
         yOwtoFe4kMMYfDdCk+4H2zxMRdygbCLAyuMDIJ8pQpuNJ0FT7dEb5RGwqd7uicbLE/r9
         XECnymaC1EMFTqK0wIZaWtV2vDq6AKoTBgW0c67oe1QWC5pIArTUa6hHXj1udXsV6pka
         wn0JzVtExosVk4yPsOUGgDK5wk+A1u7TptXILWuzTkVcJe34+Hg0ExJL+26b8Dvr+2Yc
         /LtxUXFJs7BeFOF1fnoP+DwuJylu8Vde8tFFGWEY/hDdG78P40Dzc4wS0Hz4+bMF4sqp
         JX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698286863; x=1698891663;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xrnay9mlxBDi5+JAm8W67O95cADbTIj+Nxe1S7DfUFg=;
        b=AqEDVRU0j45BRWBWFbCjt836K8jwQMGh9zwHwpAJw89INPCkzMq7GcHQOLdVFSVRfQ
         PfO0/2KwCokrAoVuhWghiuik0d1QJMyzfOvKa2NnXQNl2h2LvgH2c3BBWCp2W4WTjxOl
         6IrUwp11snGTPcLr+ZZ1pGagBiastsyJfPEK5L8FnQy6d9ep/mI3KVFITfyKMIX8LViq
         h/BYu7RM377DvG3yq1M7JjjanChuF9zAxkc4uG3GTHGp84KA7/B5Q4872/K/AsmCiSjU
         4R84tOZaQRmiUcPU7iEa5VHb97L3gQwD1CkNBmwnIv1Ix0d2bEK+PVSxoDVathlBq4o1
         fjdQ==
X-Gm-Message-State: AOJu0Yx2twk57p3OdZxy7iAKZR0UwCVNolKxNjk3kZw9CpX+0YKVA4sE
	zpRJJfcAEIcqmM8nHOkiRuyENw==
X-Google-Smtp-Source: AGHT+IE06BTmUGMs8YvxNH17BGVD0kMYPaJ3MGauK+ZjbnsW4Q6x7ClR+WERiO8EnBH/bQwSXsioEg==
X-Received: by 2002:a17:903:26c6:b0:1ca:79b7:2fd2 with SMTP id jg6-20020a17090326c600b001ca79b72fd2mr14728336plb.19.1698286862973;
        Wed, 25 Oct 2023 19:21:02 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id jh10-20020a170903328a00b001c736370245sm9853319plb.54.2023.10.25.19.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 19:21:02 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qvpzX-003ziY-2M;
	Thu, 26 Oct 2023 13:20:59 +1100
Date: Thu, 26 Oct 2023 13:20:59 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
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
	Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
Message-ID: <ZTnNCytHLGoJY9ds@dread.disaster.area>
References: <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
 <ZTWfX3CqPy9yCddQ@dread.disaster.area>
 <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
 <ZTcBI2xaZz1GdMjX@dread.disaster.area>
 <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
 <ZTc8tClCRkfX3kD7@dread.disaster.area>
 <CAOQ4uxhJGkZrUdUJ72vjRuLec0g8VqgRXRH=x7W9ogMU6rBxcQ@mail.gmail.com>
 <d539804a2a73ad70265c5fa599ecd663cd235843.camel@kernel.org>
 <ZTjMRRqmlJ+fTys2@dread.disaster.area>
 <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>

On Wed, Oct 25, 2023 at 08:25:35AM -0400, Jeff Layton wrote:
> On Wed, 2023-10-25 at 19:05 +1100, Dave Chinner wrote:
> > On Tue, Oct 24, 2023 at 02:40:06PM -0400, Jeff Layton wrote:
> > > On Tue, 2023-10-24 at 10:08 +0300, Amir Goldstein wrote:
> > > > On Tue, Oct 24, 2023 at 6:40 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > > 
> > > > > On Mon, Oct 23, 2023 at 02:18:12PM -1000, Linus Torvalds wrote:
> > > > > > On Mon, 23 Oct 2023 at 13:26, Dave Chinner <david@fromorbit.com> wrote:
> > > > Does xfs_repair guarantee that changes of atime, or any inode changes
> > > > for that matter, update i_version? No, it does not.
> > > > So IMO, "atime does not update i_version" is not an "on-disk format change",
> > > > it is a runtime behavior change, just like lazytime is.
> > > 
> > > This would certainly be my preference. I don't want to break any
> > > existing users though.
> > 
> > That's why I'm trying to get some kind of consensus on what
> > rules and/or atime configurations people are happy for me to break
> > to make it look to users like there's a viable working change
> > attribute being supplied by XFS without needing to change the on
> > disk format.
> > 
> 
> I agree that the only bone of contention is whether to count atime
> updates against the change attribute. I think we have consensus that all
> in-kernel users do _not_ want atime updates counted against the change
> attribute. The only real question is these "legacy" users of
> di_changecount.

Please stop refering to "legacy users" of di_changecount. Whether
there are users or not is irrelevant - it is defined by the current
on-disk format specification, and as such there may be applications
we do not know about making use of the current behaviour.

It's like a linux syscall - we can't remove them because there may
be some user we don't know about still using that old syscall. We
simply don't make changes that can potentially break user
applications like that.

The on disk format is the same - there is software out that we don't
know about that expects a certain behaviour based on the
specification. We don't break the on disk format by making silent
behavioural changes - we require a feature flag to indicate
behaviour has changed so that applications can take appropriate
actions with stuff they don't understand.

The example for this is the BIGTIME timestamp format change. The on
disk inode structure is physically unchanged, but the contents of
the timestamp fields are encoded very differently. Sure, the older
kernels can read the timestamp data without any sort of problem
occurring, except for the fact the timestamps now appear to be
completely corrupted.

Changing the meaning of ithe contents of di_changecount is no
different. It might look OK and nothing crashes, but nothing can be
inferred from the value in the field because we don't know how it
has been modified.

Hence we can't just change the meaning, encoding or behaviour of an
on disk field that would result in existing kernels and applications
doing the wrong thing with that field (either read or write) without
adding a feature flag to indicate what behaviour that field should
have.

> > > Perhaps this ought to be a mkfs option? Existing XFS filesystems could
> > > still behave with the legacy behavior, but we could make mkfs.xfs build
> > > filesystems by default that work like NFS requires.
> > 
> > If we require mkfs to set a flag to change behaviour, then we're
> > talking about making an explicit on-disk format change to select the
> > optional behaviour. That's precisely what I want to avoid.
> > 
> 
> Right. The on-disk di_changecount would have a (subtly) different
> meaning at that point.
> 
> It's not a change that requires drastic retooling though. If we were to
> do this, we wouldn't need to grow the on-disk inode. Booting to an older
> kernel would cause the behavior to revert. That's sub-optimal, but not
> fatal.

See above: redefining the contents, behaviour or encoding of an on
disk field is a change of the on-disk format specification.

The rules for on disk format changes that we work to were set in
place long before I started working on XFS.  They are sane, well
thought out rules that have stood the test of time and massive new
feature introductions (CRCs, reflink, rmap, etc). And they only work
because we don't allow anyone to bend them for convenience, short
cuts or expediting their pet project.

> What I don't quite understand is how these tools are accessing
> di_changecount?

As I keep saying: this is largely irrelevant to the problem at hand.

> XFS only accesses the di_changecount to propagate the value to and from
> the i_version,

Yes.  XFS has a strong separation between on-disk structures and
in-memory values, and i_version is simply the in-memory field we use
to store the current di_changecount value.  We force bump i_version
every time we modify the inode core regardless of whether anyone has
queried i_version because that's what di_changecount requires. i.e.
the filesystem controls the contents of i_version, not the VFS.

Now that NFS is using a proper abstraction (i.e. vfs_statx()) to get
the change cookie, we really don't need to expose di_changecount in
i_version at all - we could simply copy an internal di_changecount
value into the statx cookie field in xfs_vn_getattr() and there
would be almost no change of behaviour from the perspective of NFS
and IMA at all.

> and there is nothing besides NFSD and IMA that queries
> the i_version value in-kernel. So, this must be done via some sort of
> userland tool that is directly accessing the block device (or some 3rd
> party kernel module).

Yup, both of those sort of applications exist. e.g. the DMAPI kernel
module allows direct access to inode metadata through a custom
bulkstat formatter implementation - it returns different information
comapred to the standard XFS one in the upstream kernel.

> In earlier discussions you alluded to some repair and/or analysis tools
> that depended on this counter.

Yes, and one of those "tools" is *me*.

I frequently look at the di_changecount when doing forensic and/or
failure analysis on filesystem corpses.  SOE analysis, relative
modification activity, etc all give insight into what happened to
the filesystem to get it into the state it is currently in, and
di_changecount provides information no other metadata in the inode
contains.

> I took a quick look in xfsprogs, but I
> didn't see anything there. Is there a library or something that these
> tools use to get at this value?

xfs_db is the tool I use for this, such as:

$ sudo xfs_db -c "sb 0" -c "a rootino" -c "p v3.change_count" /dev/mapper/fast
v3.change_count = 35
$

The root inode in this filesystem has a change count of 35. The root
inode has 32 dirents in it, which means that no entries have ever
been removed or renamed. This sort of insight into the past history
of inode metadata is largely impossible to get any other way, and
it's been the difference between understanding failure and having no
clue more than once.

Most block device parsing applications simply write their own
decoder that walks the on-disk format. That's pretty trivial to do,
developers can get all the information needed to do this from the
on-disk format specification documentation we keep on kernel.org...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

