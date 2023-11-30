Return-Path: <linux-fsdevel+bounces-4422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5BB7FF656
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 17:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F97FB20A88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB51B54BE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnMyeLUt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C541A3
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 07:29:14 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d7eca548ccso594820a34.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 07:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701358154; x=1701962954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r26KwxGxjCzTtz0BfXFAKaRwCiL4PU2PKobfslkRRNQ=;
        b=lnMyeLUtpdMPSHyA1DVWmGhQ4Qs1gAOPbw8aOkudpYhUWMgRDmVYBOpKqlljtjM4yu
         7gVTu2e42UUB3/XEWAkpGWA0U1ApCwAYPeu+0jlcEcDSz4Fw0TL6CmYYhN8jZDbAl8P3
         eP8NwEabfOVXMZGPi8G33RJTMC5817uV7tzNd+39fXznI4r4H4vRgbauxpyYnqQVkLiZ
         Jlhw5rw2KSALTos+XR18+GryYWoLhXV+fF77D2rW9l52++EMfVz4gnnQ60MArS/ruOQf
         B12I7gKzxNV8nFEjCANpLM/N9BelGtRkUuZkLdDicf1lHWhW1S5j3i7GlxcgDVQHx2kM
         EgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701358154; x=1701962954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r26KwxGxjCzTtz0BfXFAKaRwCiL4PU2PKobfslkRRNQ=;
        b=MWEzdnphQ75NJLcsbJFn8sf1b4JwXi3GwiSJjwbpCBkI3CpilN2w2PUkEttV+A0muw
         sSYfk3TquWCaXtePHtA5dUc4NZhLhWPHM/AY9Ki89pgyYYMiKbzGIBW8vf8Ajtyhwz1T
         6+YgQ7NcYll99xwBdartJ0OA5/hQY+BqGwyLivTadI0KbL390Xh1/H66l1R0M2izvciq
         yQS8GRskiJcc8Rct3xfQiO6If0obr84j4xmBrtKKLb4ZtSV1aa61WmoyQf1kUgmFi6a0
         DN6AJWRsvWillUU0J5NUX4OcRODWHtdL3OfD2iTnXaAO1YGs9F0OgTUfTBBxU2IWg94j
         j76w==
X-Gm-Message-State: AOJu0YyXlY1vNDYMDv2kxPRY02Xs6h/MvS3K5LdFl5rJrseWA2pOqqgw
	JZFQR73EAfl65UUbmPgeDzhqpS94yK35S5j8eBY=
X-Google-Smtp-Source: AGHT+IGRzULRdicVhx+AUiLhF5oSWEXwmAKZYGc+SrunHljKis1dl6C2ZepcEE+K7+WhnyRGHG9LwfczFIUFEK3cSOs=
X-Received: by 2002:a05:6830:618c:b0:6d8:5421:1e10 with SMTP id
 cb12-20020a056830618c00b006d854211e10mr5812783otb.33.1701358153906; Thu, 30
 Nov 2023 07:29:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118183018.2069899-1-amir73il@gmail.com> <20231118183018.2069899-2-amir73il@gmail.com>
 <20231130142539.g4hhcsk4hk2oimdv@quack3>
In-Reply-To: <20231130142539.g4hhcsk4hk2oimdv@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Nov 2023 17:29:02 +0200
Message-ID: <CAOQ4uxhOc0JBQ6JcHfHxOfi57OzHWdK=i-onP8++pX2PuAdw3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] fanotify: store fsid in mark instead of in connector
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 4:25=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 18-11-23 20:30:17, Amir Goldstein wrote:
> > Some filesystems like fuse and nfs have zero or non-unique fsid.
> > We would like to avoid reporting ambiguous fsid in events, so we need
> > to avoid marking objects with same fsid and different sb.
> >
> > To make this easier to enforce, store the fsid in the marks of the grou=
p
> > instead of in the shared conenctor.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Very nice! I like the result. Just a few nits below.
>
> > +static inline __kernel_fsid_t *fanotify_mark_fsid(struct fsnotify_mark=
 *mark)
> > +{
> > +     return &FANOTIFY_MARK(mark)->fsid;
> > +}
>
> I guess, there's no big win in using this helper compared to using
> FANOTIFY_MARK(mark)->fsid so I'd just drop this helper.

ok.

>
> > @@ -530,6 +528,7 @@ struct fsnotify_mark {
> >  #define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY       0x0100
> >  #define FSNOTIFY_MARK_FLAG_NO_IREF           0x0200
> >  #define FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS  0x0400
> > +#define FSNOTIFY_MARK_FLAG_HAS_FSID          0x0800
> >       unsigned int flags;             /* flags [mark->lock] */
> >  };
>
> So this flag is in fact private to fanotify notification framework. Eithe=
r
> we could just drop this flag and use
>
>   FANOTIFY_MARK(mark)->fsid[0] !=3D 0 || FANOTIFY_MARK(mark)->fsid[1] !=
=3D 0

Cannot.
Zero fsid is now a valid fsid in an inode mark (e.g. fuse).
The next patch also adds the flag FSNOTIFY_MARK_FLAG_WEAK_FSID

>
> instead or we could at least add a comment that this flags is in fact
> private to fanotify?

There is already a comment, because all the flags above are fanotify flags:

        /* fanotify mark flags */
#define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY  0x0100
#define FSNOTIFY_MARK_FLAG_NO_IREF              0x0200
#define FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS     0x0400

Thanks,
Amir.

