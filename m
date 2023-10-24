Return-Path: <linux-fsdevel+bounces-1017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C69F7D4EA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583C22818D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 11:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2502628F;
	Tue, 24 Oct 2023 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDDs837B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3009F1FD7
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 11:16:56 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4431E109;
	Tue, 24 Oct 2023 04:16:54 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-41cd58eb037so29260531cf.1;
        Tue, 24 Oct 2023 04:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698146213; x=1698751013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pd6V6Jktu3VSf20KYTHeFxqavSYZjPV8TOLjpTyte4w=;
        b=TDDs837ButdFB1iENbbYlpMq82Oy4FUeoxJSMT+JpNabuOId3PiaGKlDjUSV5EFckO
         BeNvT8cmoUwHIu+8h6CCeYxEpUD2aEoDE9IDmCGINqJUxVTXvNxHhGnmMAqjNhBe570W
         bcOtVVkSULYMSzaoFdTmAFPMhrkroheAZXmLnNMNR6rXmrHGYTso8qYod4leGka+RhKu
         3Z2/ByASoSivEOHpsj4WwLetbpMWGKHGfyfTNz2Vag+E0NTMIOPBjEq2S5CZqCLcm02g
         /0DaDJ6X8+G5eYDkQpplXanQsntJR3l2vaRFk5/B2DvA3W4hHv0b1iEeyH7vxg7qi2eR
         zYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698146213; x=1698751013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pd6V6Jktu3VSf20KYTHeFxqavSYZjPV8TOLjpTyte4w=;
        b=G/fpXVKrqwp6X8bG+tUMzXQkK1FHWx4ltfmps8Nzt7nfEv+E1f/nTazRopTXUuuV8W
         wxNw8z9niIhaWdcG3CyO7xN75sl6LY6n4D/w0q8OA1cCkc9PeSINKY/CcGwJHQvbeeGi
         E7yZxxo6qPACQhRsY0p6A5uM8E77wPH4oIcymFkekxTOgFTfyDWTapkOmEVxTfObcAcQ
         INCFj5o6TEVnq3QBvopstrB62ePl5eHENWL4vCJoZh3U+/J9ZOMKWOqvkvP6jllreoqg
         QJjbOq+9X8IF7WRmVjVvMQHmVCFhCunHHdQLKpPOfv0lv1aF8EBHN0HNrrX24AOt3bfr
         suRg==
X-Gm-Message-State: AOJu0Yy9d5CcyCpfsC+bMgw/psr1jhAjFIsaarJ8841vP39yMqTAOKyA
	qOMhLmRzLW1o4DV1yRMjlMiikJCmwloH0OMFHFc=
X-Google-Smtp-Source: AGHT+IFgrd4HqraG2XaFg+FK4H39PNi6n3wXGwWfMIaSQ9aGrpdTdfiK9cFdtv3AFHRqRx6gRCrwV9wouG1ofS4pFLE=
X-Received: by 2002:a05:6214:2629:b0:658:708c:4d56 with SMTP id
 gv9-20020a056214262900b00658708c4d56mr18526196qvb.17.1698146213329; Tue, 24
 Oct 2023 04:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023180801.2953446-1-amir73il@gmail.com>
In-Reply-To: <20231023180801.2953446-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 24 Oct 2023 14:16:41 +0300
Message-ID: <CAOQ4uxiHi=6jvkRZj_GZ6VFSeJOsqm_+5bAjM3TL1pkZFYqJ9g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Support more filesystems with FAN_REPORT_FID
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 9:08=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> Christian,
>
> The grand plan is to be able to use fanotify with FAN_REPORT_FID as a
> drop-in replacement for inotify, but with current upstream, inotify is
> supported on all the filesystems and FAN_REPORT_FID only on a few.
>
> Making all filesystem support FAN_REPORT_FID requires that all
> filesystems will:
> 1. Support for AT_HANDLE_FID file handles
> 2. Report non-zero f_fsid
>
> This patch set takes care of the first requirement.
> Patches were reviewed by Jan and the nfsd maintainers.
>
> I have another patch in review [2] for adding non-zero f_fsid to many
> simple filesystems, but it is independent of this patch set, so no
> reason to couple them together.

Christian,

Jan has reviewed the independent f_fsid vfs patch [2], so if you
pick up this patch set, please also apply the f_fsid vfs patch.

This would allow changing "more" in the subject of this cover letter
(and possible PR subject) to "most" (i.e. all the simple filesystems
and all the filesystems that already report a non-zero f_fsid).

For the few remaining filesystems that still report zero f_fsid,
I will be sending independent patches to individual maintainers.
I had already posted f_fsid patches for gfs2 [3] and nfs [4].

Thanks,
Amir.

>
> Note that patch #2 touches many filesystems due to vfs API change,
> requiring an explicit ->encode_fh() method. I did not gets ACKs from
> all filesystem maintainers, but the change is trivial and does not
> change any logic.
>
> Thanks,
> Amir.
>
> Changes since v1 [1]:
> - Patch #1 already merged into v6.6-rc7
> - Fix build without CONFIG_EXPORTFS
> - Fix checkpatch warnings
> - Define symbolic constant for FILEID_INO64_GEN_LEN
> - Clarify documentation (units of) max_len argument
>
> [1] https://lore.kernel.org/r/20231018100000.2453965-1-amir73il@gmail.com=
/
> [2] https://lore.kernel.org/r/20231023143049.2944970-1-amir73il@gmail.com=
/

[3] https://lore.kernel.org/linux-fsdevel/20231024075535.2994553-1-amir73il=
@gmail.com/
[4] https://lore.kernel.org/linux-fsdevel/20231024110109.3007794-1-amir73il=
@gmail.com/

>
> Amir Goldstein (4):
>   exportfs: add helpers to check if filesystem can encode/decode file
>     handles
>   exportfs: make ->encode_fh() a mandatory method for NFS export
>   exportfs: define FILEID_INO64_GEN* file handle types
>   exportfs: support encoding non-decodeable file handles by default
>
>  Documentation/filesystems/nfs/exporting.rst |  7 +--
>  Documentation/filesystems/porting.rst       |  9 ++++
>  fs/affs/namei.c                             |  1 +
>  fs/befs/linuxvfs.c                          |  1 +
>  fs/efs/super.c                              |  1 +
>  fs/erofs/super.c                            |  1 +
>  fs/exportfs/expfs.c                         | 54 +++++++++++++++------
>  fs/ext2/super.c                             |  1 +
>  fs/ext4/super.c                             |  1 +
>  fs/f2fs/super.c                             |  1 +
>  fs/fat/nfs.c                                |  1 +
>  fs/fhandle.c                                |  6 +--
>  fs/fuse/inode.c                             |  7 +--
>  fs/jffs2/super.c                            |  1 +
>  fs/jfs/super.c                              |  1 +
>  fs/nfsd/export.c                            |  3 +-
>  fs/notify/fanotify/fanotify_user.c          |  4 +-
>  fs/ntfs/namei.c                             |  1 +
>  fs/ntfs3/super.c                            |  1 +
>  fs/overlayfs/util.c                         |  2 +-
>  fs/smb/client/export.c                      | 11 ++---
>  fs/squashfs/export.c                        |  1 +
>  fs/ufs/super.c                              |  1 +
>  include/linux/exportfs.h                    | 51 ++++++++++++++++++-
>  24 files changed, 128 insertions(+), 40 deletions(-)
>
> --
> 2.34.1
>

