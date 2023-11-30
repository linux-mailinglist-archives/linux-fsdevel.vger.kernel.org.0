Return-Path: <linux-fsdevel+bounces-4313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD297FE714
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 03:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F4528220A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0E9F9E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTkuFrHq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5B6D5C;
	Wed, 29 Nov 2023 18:27:49 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50bc811d12fso667503e87.1;
        Wed, 29 Nov 2023 18:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701311267; x=1701916067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fs2Qbf7gFiyubdVRtAJXZWd4e/yXPtXupOcM8TnNWjQ=;
        b=VTkuFrHqLi4p8c6Fb6N7JT4HeyiOaEdsqliOrwGYM8qqypFjH66Ik76JRvRotlRstT
         cJ9le19N21rPmjZMLI1IjA6lFLxTZ5KpIPCXQ7X/Zb6I9fyvkO6wZYEiaxLAI0PEX0+n
         jspYtyPMmNhQMl6XU4C75gYAj1OgDyygY4V6Yyq49g/+xQihwKCJuR1upIqnJ3VxWFBX
         ZE47NqT2IT6SVZlbFg/KLqWK8ac9VCVgUZyQvRDDAReCUMvmIe6sktTdwsB7S0drTA2H
         lEicF+VMxX4OFCdR0krfgoLKXvD9lYj4qDOiTWcpEsb/Tzhx07cHe/GQCgJCBw1aZrDM
         LA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701311267; x=1701916067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fs2Qbf7gFiyubdVRtAJXZWd4e/yXPtXupOcM8TnNWjQ=;
        b=j6hzGj5oeYiiqXjl74rjcBBzym2yIjHhnLW7gWV5Or5oj0O8wxV1cyDMYN+aeZQU9T
         wti6TnPDRYzQ9oWaJbnNBxAYBX624qdwInrxD6okwzUKLnyN0zJe74kHx6Gpbe29PLdc
         yKjyVtcbl+w3tXI7gQMhLKIx5UGBbT56H+UuB+uBPdvD2j1SDc4GZ/Yi0lhpaZVeMqVy
         WKQPVmvWBZpU0xCD4GzglctbptaiL39uT0Rv2l4WjLxqRo/OZabHNz5VJnq6jFMLc32P
         Q4niXuZTVvcQcZEkoH0CHiEyBcx8GlDANGCUWAl2S0APxYzDs4eX3LKo+pRskcC8/UA6
         F6lg==
X-Gm-Message-State: AOJu0Yxlsf+MVPEVKA8oioGmIEvr6RlI5uRsFKocow8wF6W6HNWwvbs3
	fhyYQZMAqLwuStII+H2XOyJyo8vBHhf/fYDurVg=
X-Google-Smtp-Source: AGHT+IECATlAJ9Xw7a71zSU7LDRNoRULn3qkGW6SO3ISO7FTCzP+J8weaGa2npL+0/hjQRprHqCQm+wQ0xUycMNXMaQ=
X-Received: by 2002:ac2:4ec7:0:b0:50b:bf07:5a84 with SMTP id
 p7-20020ac24ec7000000b0050bbf075a84mr3681468lfr.56.1701311267349; Wed, 29 Nov
 2023 18:27:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129165619.2339490-1-dhowells@redhat.com> <20231129165619.2339490-4-dhowells@redhat.com>
 <9704ab96ba04eb3591a62ef5e6a97af6@manguebit.com>
In-Reply-To: <9704ab96ba04eb3591a62ef5e6a97af6@manguebit.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 29 Nov 2023 20:27:36 -0600
Message-ID: <CAH2r5mvwzU1N5osqUPcuyHtXapuaJt-o9orHFr42MRGoCzy+2Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] cifs: Fix flushing, invalidation and file size with copy_file_range()
To: Paulo Alcantara <pc@manguebit.com>
Cc: David Howells <dhowells@redhat.com>, linux-cifs@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

updated all three patches with the acked-by and put in cifs-2.6.git for-nex=
t


On Wed, Nov 29, 2023 at 4:28=E2=80=AFPM Paulo Alcantara <pc@manguebit.com> =
wrote:
>
> David Howells <dhowells@redhat.com> writes:
>
> > Fix a number of issues in the cifs filesystem implementation of the
> > copy_file_range() syscall in cifs_file_copychunk_range().
> >
> > Firstly, the invalidation of the destination range is handled incorrect=
ly:
> > We shouldn't just invalidate the whole file as dirty data in the file m=
ay
> > get lost and we can't just call truncate_inode_pages_range() to invalid=
ate
> > the destination range as that will erase parts of a partial folio at ea=
ch
> > end whilst invalidating and discarding all the folios in the middle.  W=
e
> > need to force all the folios covering the range to be reloaded, but we
> > mustn't lose dirty data in them that's not in the destination range.
> >
> > Further, we shouldn't simply round out the range to PAGE_SIZE at each e=
nd
> > as cifs should move to support multipage folios.
> >
> > Secondly, there's an issue whereby a write may have extended the file
> > locally, but not have been written back yet.  This can leaves the local
> > idea of the EOF at a later point than the server's EOF.  If a copy requ=
est
> > is issued, this will fail on the server with STATUS_INVALID_VIEW_SIZE
> > (which gets translated to -EIO locally) if the copy source extends past=
 the
> > server's EOF.
> >
> > Fix this by:
> >
> >  (0) Flush the source region (already done).  The flush does nothing an=
d
> >      the EOF isn't moved if the source region has no dirty data.
> >
> >  (1) Move the EOF to the end of the source region if it isn't already a=
t
> >      least at this point.
> >
> >      [!] Rather than moving the EOF, it might be better to split the co=
py
> >      range into a part to be copied and a part to be cleared with
> >      FSCTL_SET_ZERO_DATA.
> >
> >  (2) Find the folio (if present) at each end of the range, flushing it =
and
> >      increasing the region-to-be-invalidated to cover those in their
> >      entirety.
> >
> >  (3) Fully discard all the folios covering the range as we want them to=
 be
> >      reloaded.
> >
> >  (4) Then perform the copy.
> >
> > Thirdly, set i_size after doing the copychunk_range operation as this v=
alue
> > may be used by various things internally.  stat() hides the issue becau=
se
> > setting ->time to 0 causes cifs_getatr() to revalidate the attributes.
> >
> > These were causing the generic/075 xfstest to fail.
> >
> > Fixes: 620d8745b35d ("Introduce cifs_copy_file_range()")
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Steve French <sfrench@samba.org>
> > cc: Paulo Alcantara <pc@manguebit.com>
> > cc: Shyam Prasad N <nspmangalore@gmail.com>
> > cc: Rohith Surabattula <rohiths.msft@gmail.com>
> > cc: Matthew Wilcox <willy@infradead.org>
> > cc: Jeff Layton <jlayton@kernel.org>
> > cc: linux-cifs@vger.kernel.org
> > cc: linux-mm@kvack.org
> > ---
> >  fs/smb/client/cifsfs.c | 80 ++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 77 insertions(+), 3 deletions(-)
>
> Looks good,
>
> Acked-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
>


--=20
Thanks,

Steve

