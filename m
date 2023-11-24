Return-Path: <linux-fsdevel+bounces-3651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089D57F6D3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 08:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365A51C20E38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B429E944F;
	Fri, 24 Nov 2023 07:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpwpC3HI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2974AD4E;
	Thu, 23 Nov 2023 23:55:04 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507ad511315so2230489e87.0;
        Thu, 23 Nov 2023 23:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700812502; x=1701417302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4jORUPKlG5Lg5RiyFdtM4lta/tN53OQFgxLh8ewmug=;
        b=WpwpC3HItRN00GSnFFertDy3eMD7mQpfiPGGfl87+MF1O8qw8IwlzsD2bVE8I6vw/u
         U6O68xwAA6LOWoMidEPg08UWkq2+jDV2PVjTGf+E9flmSfvbC95jxcatkososQeRysx6
         +rgGZX0gTOKqC5ccVSPVVLPDIxbhBi+VOY0ZcnntICjZ5vPixzDbcGuqyDiInvFq3JEZ
         qC8xqVCQBDwqyxP88UQJHhLNZMyV6CoQdyFnMkZXr/6ijB7WdY84AY5rHDQFnmJh1Iqy
         X7T+aHbkal8TXIhgJVo8tE6o/4znNqllTD/6GLexf1zTuN7alR8yMad67ZlzauVrc7X9
         2QYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700812502; x=1701417302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4jORUPKlG5Lg5RiyFdtM4lta/tN53OQFgxLh8ewmug=;
        b=qF3CPMRM0UAm2TtyUEwVehKpiNytZQkouDIwkP5yTIslsQIeWm7sSbXNyL22VUpGJ+
         odwKqi3elOmf7K1bejGVO8yycsIJe5onFkJv8gRyT9M7sRSGZKa0qMcb1fWWLOxEEAFz
         OI23AdbO0lsrUa59GQSCDPbn5oTYcQP5v5FjcXVhDhwbUoTToF07ZsbRC6s+CL5h19I+
         w4HSLDktoQXPdBEMptLrGDV3jigtbkNF7J0R2S8YJyCMMk9YAw6BRPTzs0RfR56FX1jz
         dU88pY+M0YH4DzSlb0QisWWOA00Y7l/5uROnyowZHE9/0p1YjB35Ir+0i1H+A+r5v2Xp
         eONQ==
X-Gm-Message-State: AOJu0YywlRVBNSWieGkuCIPA368uxw1TdPOaJxlTWjAMwb1qc3fu1wfZ
	0RmXxpk+ReO0xyet57F/R++7U0eD+LzQdmF0PIQ=
X-Google-Smtp-Source: AGHT+IFASJjXHvRnqICP3Bh8n3rkz4PXrvXjjTh8KwOhFDznlaHld1JNwaQhFcG0m+NV7YV5i6N6b0Cdfn9sKb1NY4k=
X-Received: by 2002:a19:7514:0:b0:4fb:9168:1fce with SMTP id
 y20-20020a197514000000b004fb91681fcemr1017725lfe.59.1700812502095; Thu, 23
 Nov 2023 23:55:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123092000.2665902-1-amir73il@gmail.com> <2f3bf38b-a803-43e5-a9b9-54a88f837125@kernel.dk>
In-Reply-To: <2f3bf38b-a803-43e5-a9b9-54a88f837125@kernel.dk>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 Nov 2023 09:54:49 +0200
Message-ID: <CAOQ4uxj6BBSgGKWQn=2ocsL_rd-PbjPAiK2w9rsqnxpNamxr9g@mail.gmail.com>
Subject: Re: [PATCH] scsi: target: core: add missing file_{start,end}_write()
To: Christian Brauner <brauner@kernel.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
	Josef Bacik <josef@toxicpanda.com>, David Howells <dhowells@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, stable@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 10:04=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 11/23/23 2:20 AM, Amir Goldstein wrote:
> > The callers of vfs_iter_write() are required to hold file_start_write()=
.
> > file_start_write() is a no-op for the S_ISBLK() case, but it is really
> > needed when the backing file is a regular file.
> >
> > We are going to move file_{start,end}_write() into vfs_iter_write(), bu=
t
> > we need to fix this first, so that the fix could be backported to stabl=
e
> > kernels.
>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
>

Christian,

Shall we just stash this at the bottom of vfs.rw and fixup
"move file_{start,end}_write() into vfs_iter_write()" patch?

I see no strong reason to expedite a fix for something rare
that has been broken for a long time.

If Martin decides to expedite it, we can alway rebase vfs.rw
once the fix is merged to master.

Thanks,
Amir.

