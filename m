Return-Path: <linux-fsdevel+bounces-5502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF7380CF48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 16:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738E71F2175A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862954AF69;
	Mon, 11 Dec 2023 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoQtHufk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF55D8
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 07:17:15 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-67ad5b37147so30738156d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 07:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702307835; x=1702912635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyGoYoAXkulZ8DdhCJgxESExZoXM7zCYZ75ftIHgXpE=;
        b=CoQtHufkDOdh1oKx0HKv/fpYEVl0Hz8ETVwC1PZJY0at7njyv0LJVBwT+AnnE7rfA2
         C+UcO3cQ0mRnNogL8qIb5vah7mj/AyTrILWZ0a7bwrhyr7gIq5xywRdmV1cVg+KtMS+R
         cAUID7OKkiKuZprN33RybY++beEXiUx7kyBr4SbYRkGCxW9XSEPxcZ2ybCOZ9b3whzD2
         IpR++EG4VEUdvX/pcthzlqXoDnYqJWwYCtNGHGpKmOHzPHL2Vg1c2kAVv78XYPrknYNH
         3feQ4LhMgWRNaSoMj69XF1qWKsK8X9eNHAiNZZXXH8xD/x35tzn+JYDU3MVju5AS17Da
         CbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702307835; x=1702912635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyGoYoAXkulZ8DdhCJgxESExZoXM7zCYZ75ftIHgXpE=;
        b=LdWSsC2JyHN/1bt3sGbmZkE+TczudcTZdsJHRHRPwj0ZtFi+HwDrktOG9YNzSIaE/j
         qbMlJXc72bcYkMiymuN1B2hdrFOH96Lhh61RL05wXpy8OAQDrgF2tS7aWCVlHg+6S9i6
         PRhh2dZnlh2V2VEdKGxAQkD3mROoQDNJHzY9/JlzxSKTl0Dtl0r+mnR5uIP9SrxjXWnc
         z0bqYdG8HDVn7Idnkam9raQ0jwUAi0bf/jRv1IXnirC9/mj/QFxhlIMLzFHdlw0MQmd0
         RV9ElhrQGdoPLOjPr5fv2NaaIqnm1yBYglKQgdiYVRT871nChNq2ZkdlIlABSN4P1nwm
         7HHQ==
X-Gm-Message-State: AOJu0YxrDttGidx/DmtHpUpcMSkqibe99JmUkKX/pU+oeS/locnCyqL3
	/5zuYsdIGcjzgjNN8mElUwVI/SXDR5j42O4sEuk=
X-Google-Smtp-Source: AGHT+IH8bLXLcuxmfiMw6tiTi+uQwkS5jALuDjw4Z3Y/647PNyVszxXjz9QnokyJMwgop1yuKBiRNVZ6AK74efyXKlQ=
X-Received: by 2002:ad4:5101:0:b0:67e:aa84:b095 with SMTP id
 g1-20020ad45101000000b0067eaa84b095mr6202235qvp.15.1702307834747; Mon, 11 Dec
 2023 07:17:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231210141901.47092-1-amir73il@gmail.com> <20231210141901.47092-2-amir73il@gmail.com>
 <20231211143923.fviipywixaqm2es4@quack3>
In-Reply-To: <20231211143923.fviipywixaqm2es4@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 11 Dec 2023 17:17:03 +0200
Message-ID: <CAOQ4uxgxqjju=FAtKBJhX9cK1sOSkMOwZjVYutTmWs9Kjzd5pQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] splice: return type ssize_t from all helpers
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, David Howells <dhowells@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 4:39=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 10-12-23 16:18:57, Amir Goldstein wrote:
> > Not sure why some splice helpers return long, maybe historic reasons.
> > Change them all to return ssize_t to conform to the splice methods and
> > to the rest of the helpers.
> >
> > Suggested-by: Christian Brauner <brauner@kernel.org>
> > Link: https://lore.kernel.org/r/20231208-horchen-helium-d3ec1535ede5@br=
auner/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> > @@ -955,9 +955,9 @@ static void do_splice_eof(struct splice_desc *sd)
> >   * Callers already called rw_verify_area() on the entire range.
> >   * No need to call it for sub ranges.
> >   */
> > -static long do_splice_read(struct file *in, loff_t *ppos,
> > -                        struct pipe_inode_info *pipe, size_t len,
> > -                        unsigned int flags)
> > +static size_t do_splice_read(struct file *in, loff_t *ppos,
>           ^^^ ssize_t here?
>
> > +                          struct pipe_inode_info *pipe, size_t len,
> > +                          unsigned int flags)
> >  {
> >       unsigned int p_space;
> >
> > @@ -1030,7 +1030,7 @@ ssize_t splice_direct_to_actor(struct file *in, s=
truct splice_desc *sd,
> >                              splice_direct_actor *actor)
> >  {
> >       struct pipe_inode_info *pipe;
> > -     long ret, bytes;
> > +     size_t ret, bytes;
>         ^^^^ ssize_t here?
>

Yap, I had more than one miss...

> >       size_t len;
> >       int i, flags, more;
> >
> ...
> > @@ -1962,7 +1962,7 @@ static int link_pipe(struct pipe_inode_info *ipip=
e,
> >   * The 'flags' used are the SPLICE_F_* variants, currently the only
> >   * applicable one is SPLICE_F_NONBLOCK.
> >   */
>
> Actually link_pipe() should also return ssize_t instead of int, shouldn't
> it?

Wouldn't hurt.
I also see that I missed the vmsplice_ helpers.

I see v3 in my future...

Thanks,
Amir.

