Return-Path: <linux-fsdevel+bounces-40548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A7DA24ECB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 16:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011F3164203
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCDD1FAC54;
	Sun,  2 Feb 2025 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaWyqbNs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD08381A3;
	Sun,  2 Feb 2025 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738509837; cv=none; b=F6B2itXLZIYlC3MgI5VKnkHLl4FjBFBZKr10IVsjRVGb6enrcwmZ3nkm3VedvxciGwVFwxVZbqzertkVOhFvSWM+aYLztkcJ9DmFLXZEAbQSTdvHNNH/ViG2EsImvH+dLFtXlnuo1uiOHJDaMl44W+ZHDKnydN19imZisNpPYX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738509837; c=relaxed/simple;
	bh=TcIXoFug1YBo9zUIh37L9F3xCpjDqyybacrm2bvp10A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/u1+xihiGh7FUlZKe8XEDUH/i3GSl3Jsd6ghjcU5vEBZkAnD2UsBz/reAwGquVD2JndQPwlvajvGV27c2zIp8+CPm3xYNS86StKuADTpIweJnPe5/HDWwVP1kZWUuZSodcJr8rPNp9uCmJIXn2nRYCyOLZXAO9J2sZWMALnRPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaWyqbNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ABAC4CED1;
	Sun,  2 Feb 2025 15:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738509835;
	bh=TcIXoFug1YBo9zUIh37L9F3xCpjDqyybacrm2bvp10A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NaWyqbNsxgDXxPLBotUxWAjCPoHdkkic2oaIKlOWwYbwlZKLdBn/U5TpAXd8oK/QA
	 Twf36a4Jsg2ww8tP95Td5n9+PvU6jSZr/c00acK8iWUVDNjxx7Ls7t56CSSNfJ+lbe
	 8dDvrT/2l+BWdVAKHW916a5gLPpOZNtSaPkS92f9A4IgxUBlkJu4lO2thTVNZiG/8X
	 m1e+k/QAIqTzaeqkDXgiovb/St3zTsKvkUQsRuwaAwlVNHeaAIk7ZXmAoOK6AgPpFj
	 2sK8OpJxmB93nJnVoKdfOB0/QpfbFe7CCml7JlPuztoThhVYk6V67ijbSYG8EIoeaO
	 ohMKEFgnk1BjQ==
Received: by pali.im (Postfix)
	id 38B5096D; Sun,  2 Feb 2025 16:23:43 +0100 (CET)
Date: Sun, 2 Feb 2025 16:23:43 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Immutable vs read-only for Windows compatibility
Message-ID: <20250202152343.ahy4hnzbfuzreirz@pali>
References: <20250114211050.iwvxh7fon7as7sty@pali>
 <0659dfe1-e160-40fd-b95a-5d319ca3504f@oracle.com>
 <20250114215350.gkc2e2kcovj43hk7@pali>
 <CAN05THSXjmVtvYdFLB67kKOwGN5jsAiihtX57G=HT7fBb62yEw@mail.gmail.com>
 <20250114235547.ncqaqcslerandjwf@pali>
 <20250114235925.GC3561231@frogsfrogsfrogs>
 <CAOQ4uxjj3XUNh6p3LLp_4YCJQ+cQHu7dj8uM3gCiU61L3CQRpA@mail.gmail.com>
 <20250117173900.GN3557553@frogsfrogsfrogs>
 <CAOQ4uxhh1LDz5zXzqFENPhJ9k851AL3E7Xc2d7pSVVYX4Fu9Jw@mail.gmail.com>
 <20250117185947.ylums2dhmo3j6hol@pali>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250117185947.ylums2dhmo3j6hol@pali>
User-Agent: NeoMutt/20180716

On Friday 17 January 2025 19:59:47 Pali Rohár wrote:
> On Friday 17 January 2025 19:46:30 Amir Goldstein wrote:
> > > > Looking at the FILE_ATTRIBUTE_* flags defined in SMB protocol
> > > >  (fs/smb/common/smb2pdu.h) I wonder how many of them will be
> > > > needed for applications beyond the obvious ones that were listed.
> > >
> > > Well they only asked for seven of them. ;)
> > >
> > > I chatted with Ted about this yesterday, and ... some of the attributes
> > > (like read only) imply that you'd want the linux server to enforce no
> > > writing to the file; some like archive seem a little superfluous since
> > > on linux you can compare cmtime from the backup against what's in the
> > > file now; and still others (like hidden/system) might just be some dorky
> > > thing that could be hidden in some xattr because a unix filesystem won't
> > > care.
> > >
> > > And then there are other attrs like "integrity stream" where someone
> > > with more experience with windows would have to tell me if fsverity
> > > provides sufficient behaviors or not.
> > >
> > > But maybe we should start by plumbing one of those bits in?  I guess the
> > > gross part is that implies an ondisk inode format change or (gross)
> > > xattr lookups in the open path.
> > >
> > 
> > I may be wrong, but I think there is a confusion in this thread.
> > I don't think that Pali was looking for filesystems to implement
> > storing those attributes. I read his email as a request to standardize
> > a user API to get/set those attributes for the filesystems that
> > already support them and possibly for vfs to enforce some of them
> > (e.g. READONLY) in generic code.
> 
> Yes, you understood it correctly. I was asking for standardizing API how
> to get/set these attributes from userspace. And Chuck wrote that would
> like to have also standardized it for kernel consumers like nfsd or
> ksmbd. Which makes sense.
> 
> > Nevertheless, I understand the confusion because I know there
> > is also demand for storing those attributes by file servers in a
> > standard way and for vfs to respect those attributes on the host.
> 
> Userspace fileserver, like Samba, would just use that standardized
> userspace API for get/set attributes. And in-kernel fileservers like
> nfsd or ksmbd would like to use that API too.
> 
> And there were some proposals how filesystems without native
> support for these attributes could store and preserve these attributes.
> So this can be a confusion in this email thread discussion.

So to recap, for set-API there are possible options:

1) extending FS_IOC_FSSETXATTR / FS_IOC_SETFLAGS for each individual bit

2) creating one new xattr in system namespace which will contain all bit
   flags in one structure

3) creating new xattr in system namespace for each individual flag

Disadvantages for option 1) is that "cp -a" or "rsync -a" does not
preserve them. If in option 2) or 3) those xattrs would be visible in
listxattr() call then this can be advantage, as all flags are properly
preserved when doing "archive" backup.

Do you have any preference which of those options should be used?


And how many bit flags are needed? I have done some investigation. Lets
start with table which describes all 32 possible bit flags which are
used by Windows system and also by filesystems FAT / exFAT / NTFS / ReFS
and also by SMB over network:

bit / attrib.exe flag / SDK constant / description

 0 - R - FILE_ATTRIBUTE_READONLY              - writing to file or deleting it is disallowed
 1 - H - FILE_ATTRIBUTE_HIDDEN                - inode is hidden
 2 - S - FILE_ATTRIBUTE_SYSTEM                - inode is part of operating system
 3 -   - FILE_ATTRIBUTE_VOLUME                - inode is the disk volume label entry
 4 -   - FILE_ATTRIBUTE_DIRECTORY             - inode is directory
 5 - A - FILE_ATTRIBUTE_ARCHIVE               - inode was not archived yet (when set)
 6 -   - FILE_ATTRIBUTE_DEVICE                - inode represents  in-memory device (e.g. C:\), flag not stored on filesystem
 7 -   - FILE_ATTRIBUTE_NORMAL                - no other flag is set (value 0 means to not change flags, bit 7 means to clear all flags)
 8 -   - FILE_ATTRIBUTE_TEMPORARY             - inode data do not have to be flushed to disk
 9 -   - FILE_ATTRIBUTE_SPARSE_FILE           - file is sparse with holes
10 -   - FILE_ATTRIBUTE_REPARSE_POINT         - inode has attached reparse point (symlink is also reparse point)
11 -   - FILE_ATTRIBUTE_COMPRESSED            - file is compressed, for directories it means that newly created inodes would have this flag set
12 - O - FILE_ATTRIBUTE_OFFLINE               - HSM - inode is used by HSM
13 - I - FILE_ATTRIBUTE_NOT_CONTENT_INDEXED   - inode will not be indexed by content indexing service
14 -   - FILE_ATTRIBUTE_ENCRYPTED             - file is encrypted, for directories it means that newly created inodes would have this flag set
15 - V - FILE_ATTRIBUTE_INTEGRITY_STREAM      - fs does checksumming of data and metadata when reading inode, read-only
16 -   - FILE_ATTRIBUTE_VIRTUAL               - inode is in %LocalAppData%\VirtualStore, flag not stored on filesystem
17 - X - FILE_ATTRIBUTE_NO_SCRUB_DATA         - do not use scrubber (proactive background data integrity scanner) on this file, for directories it means that newly created inodes would have this flag set
18 -   - FILE_ATTRIBUTE_EA                    - inode has xattrs, (not in readdir output, shares same bit with FILE_ATTRIBUTE_RECALL_ON_OPEN)
18 -   - FILE_ATTRIBUTE_RECALL_ON_OPEN        - HSM - inode is not stored locally (only in readdir output, shares same bit with FILE_ATTRIBUTE_EA)
19 - P - FILE_ATTRIBUTE_PINNED                - HSM - inode data content must be always stored on locally
20 - U - FILE_ATTRIBUTE_UNPINNED              - HSM - inode data content can be removed from local storage
21 -   -                                      - reserved
22 -   - FILE_ATTRIBUTE_RECALL_ON_DATA_ACCESS - HSM - inode data content is not stored locally
23 -   -                                      - reserved
24 -   -                                      - reserved
25 -   -                                      - reserved
26 -   -                                      - reserved
27 -   -                                      - reserved
28 -   -                                      - reserved
29 - B - FILE_ATTRIBUTE_STRICTLY_SEQUENTIAL   - SMR Blob, unknown meaning, read-only
30 -   -                                      - reserved
31 -   -                                      - reserved

(HSM means Hierarchical Storage Management software, which uses reparse
points to make some remote file/folder available on the local
filesystem, for example OneDrive or DropBox)

From above list only following bit flags are suitable for modification
over some Linux API:
- FILE_ATTRIBUTE_READONLY
- FILE_ATTRIBUTE_HIDDEN
- FILE_ATTRIBUTE_SYSTEM
- FILE_ATTRIBUTE_ARCHIVE
- FILE_ATTRIBUTE_TEMPORARY
- FILE_ATTRIBUTE_COMPRESSED
- FILE_ATTRIBUTE_OFFLINE
- FILE_ATTRIBUTE_NOT_CONTENT_INDEXED
- FILE_ATTRIBUTE_ENCRYPTED
- FILE_ATTRIBUTE_NO_SCRUB_DATA
- FILE_ATTRIBUTE_PINNED
- FILE_ATTRIBUTE_UNPINNED

And if I'm looking correctly the FILE_ATTRIBUTE_COMPRESSED can be
already mapped to Linux FS_COMPR_FL / STATX_ATTR_COMPRESSED, which has
same meaning. Also FILE_ATTRIBUTE_ENCRYPTED can be mapped to
FS_ENCRYPT_FL / STATX_ATTR_ENCRYPTED. Note that these two flags cannot
be set over WinAPI or SMB directly and it is required to use special
WinAPI or SMB ioctl.

So totally are needed 10 new bit flags. And for future there are 9
reserved bits which could be introduced by MS in future.

Additionally there are get-only attributes which can be useful for statx
purposes (for example exported by cifs.ko SMB client):
- FILE_ATTRIBUTE_REPARSE_POINT
- FILE_ATTRIBUTE_INTEGRITY_STREAM
- FILE_ATTRIBUTE_RECALL_ON_OPEN
- FILE_ATTRIBUTE_RECALL_ON_DATA_ACCESS
- FILE_ATTRIBUTE_STRICTLY_SEQUENTIAL

From the above list of flags suitable for modification, following bit
flags have no meaning for kernel and it is up to userspace how will use
them. What is needed from kernel and/or filesystem driver is to preserve
those bit flags.
- FILE_ATTRIBUTE_HIDDEN
- FILE_ATTRIBUTE_SYSTEM
- FILE_ATTRIBUTE_ARCHIVE
- FILE_ATTRIBUTE_NOT_CONTENT_INDEXED

Following are bit flags which kernel / VFS / fsdriver would have to
handle specially, to provide enforcement or correct behavior of them:
- FILE_ATTRIBUTE_READONLY - enforce that data modification or unlink is disallowed when set
- FILE_ATTRIBUTE_COMPRESSED - enforce compression on filesystem when set
- FILE_ATTRIBUTE_ENCRYPTED - enforce encryption on filesystem when set

Then there are HSM flags which for local filesystem would need some
cooperation with userspace synchronization software. For network
filesystems (SMB / NFS4) they need nothing special, just properly
propagating them over network:
- FILE_ATTRIBUTE_OFFLINE
- FILE_ATTRIBUTE_PINNED
- FILE_ATTRIBUTE_UNPINNED

About following 2 flags, I'm not sure if the kernel / VFS / fs driver
has to do something or it can just store bits to fs:
- FILE_ATTRIBUTE_TEMPORARY
- FILE_ATTRIBUTE_NO_SCRUB_DATA


=======================================================================

And there is still unresolved issue with FILE_ATTRIBUTE_READONLY.
Its meaning is similar to existing Linux FS_IMMUTABLE_FL, just
FILE_ATTRIBUTE_READONLY does not require root / CAP_LINUX_IMMUTABLE.

I think that for proper support, to enforce FILE_ATTRIBUTE_READONLY
functionality, it is needed to introduce new flag e.g.
FS_IMMUTABLE_FL_USER to allow setting / clearing it also for normal
users without CAP_LINUX_IMMUTABLE. Otherwise it would be unsuitable for
any SMB client, SMB server or any application which would like to use
it, for example wine.

Just to note that FreeBSD has two immutable flags SF_IMMUTABLE and
UF_IMMUTABLE, one settable only by superuser and second for owner.

Any opinion?

