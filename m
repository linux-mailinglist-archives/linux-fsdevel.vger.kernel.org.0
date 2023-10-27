Return-Path: <linux-fsdevel+bounces-1373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D977D9B7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 16:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F68281A24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFD3374D3;
	Fri, 27 Oct 2023 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgmnEPOI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F70C374C9
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 14:32:47 +0000 (UTC)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939DEC0;
	Fri, 27 Oct 2023 07:32:46 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41cc56255e3so13498971cf.3;
        Fri, 27 Oct 2023 07:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698417165; x=1699021965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucqkuIBSI4Oih9/44MO7AKh+wvjUqOxO46lZskIRSyQ=;
        b=IgmnEPOIve4d3CuGRGbPjO3dl/QOuNG5PkJIW+UgZV3wVkiYneGlit4rIuJZySecid
         KOGGtLUUlcCmxL612mVvvx08TziFHJ1H5aQXMNp7uJx0cOusgIjWg8UEKFSfVBB+zQqW
         lkd+t1Rgr0e6NpeQbi+nLuYUntd1BSU2S2rPo1TCTqlUg16aZJfqJrpaomzGHavsaIgB
         FOUwVw/Fc61tz304L4rBk4QBOjGB6eu1XIKnlMyGZ2+j842dcOvTtvcFKrbHSbBHUkSz
         SEn3Jv4lhZg3auUJm6zptlKSL2arw0OdVWxJawEGP05jK4SBPiYdk/TWu9o4UTDQkLU5
         IJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698417165; x=1699021965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucqkuIBSI4Oih9/44MO7AKh+wvjUqOxO46lZskIRSyQ=;
        b=I5Y1PRScw1FLutLPNTY8ZcKOzTg3KCZ+VsI3RRmIuJ2umhF99d/mTDpVpOZg5kTONi
         1ytLtP0FvQdoBzOLHqGToepCeUYoWAn7gvyJk1rtLmjAIMp9B/iXq+Obzy87/SdKHW3X
         syZsguzCYh2yKMA78kee0NK7vjU0mirvPPAAV4Ab4o182like/E5iKW+Pl0IWYrY8vHN
         2LpRXUjBpi2hBp4cZlrAmOONtlaEL9Q2/HUP4rRHidPEJN7jLXgBBYZwgrn8l3Zvf0Wp
         nTlfxZPymwWnE52x1bKA4TXjJZTmZiYj69IH3CcQLDtKzGtDs61KefISnH7bp/c2+4Cx
         WZCA==
X-Gm-Message-State: AOJu0YwSfcAdGubSu/5dXNyGpHnGHZW4jBi2MPv2FnT3hwxH5yvZtCBy
	t/tAmysNv28FIWCxkqHg2sPu3ooLQHQm1e4V+aA=
X-Google-Smtp-Source: AGHT+IEIW0wBhfQfB/iSwPKjE5CK9mRb9XdsrYhXdctpO6oGNTwsvNp2m4juxbYBEz5yZ3qgrjWb3lNT5ro0jffJF7Q=
X-Received: by 2002:ad4:5ecd:0:b0:66d:28b3:798 with SMTP id
 jm13-20020ad45ecd000000b0066d28b30798mr2972775qvb.10.1698417165677; Fri, 27
 Oct 2023 07:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023180801.2953446-1-amir73il@gmail.com> <20231023180801.2953446-3-amir73il@gmail.com>
 <ZTtSrfBgioyrbWDH@infradead.org> <CAOQ4uxj_T9+0yTN1nFX+yzFUyLqeeO5n2mpKORf_NKf3Da8j-Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxj_T9+0yTN1nFX+yzFUyLqeeO5n2mpKORf_NKf3Da8j-Q@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Oct 2023 17:32:34 +0300
Message-ID: <CAOQ4uxgeCAi77biCVLQR6iHQT1TAWjWAhJv5_y6i=nWVbdhAWA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] exportfs: make ->encode_fh() a mandatory method
 for NFS export
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	David Sterba <dsterba@suse.com>, Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Dave Kleikamp <shaggy@kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Anton Altaparmakov <anton@tuxera.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Steve French <sfrench@samba.org>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Evgeniy Dushistov <dushistov@mail.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 10:09=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Fri, Oct 27, 2023 at 9:03=E2=80=AFAM Christoph Hellwig <hch@infradead.=
org> wrote:
> >
> > On Mon, Oct 23, 2023 at 09:07:59PM +0300, Amir Goldstein wrote:
> > > export_operations ->encode_fh() no longer has a default implementatio=
n to
> > > encode FILEID_INO32_GEN* file handles.
> >
> > This statement reads like a factual statement about the current tree.
> > I'd suggest rewording it to make clear that you are changing the
> > behavior so that the defaul goes away, and I'd also suggest to move
> > it after the next paragraph.
>
> Ok. will send v3 with those changes.
>

Actually, Christian, since you already picked up the build fix and
MAINTAINERS patch, cloud I bother you to fixup the commit
message of this patch according to Christoph's request:

    exportfs: make ->encode_fh() a mandatory method for NFS export

    Rename the default helper for encoding FILEID_INO32_GEN* file handles
    to generic_encode_ino32_fh() and convert the filesystems that used the
    default implementation to use the generic helper explicitly.

    After this change, exportfs_encode_inode_fh() no longer has a default
    implementation to encode FILEID_INO32_GEN* file handles.

    This is a step towards allowing filesystems to encode non-decodeable fi=
le
    handles for fanotify without having to implement any export_operations.


Might as well add hch RVB on patch #1 while at it.

Thanks,
Amir.

