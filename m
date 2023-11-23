Return-Path: <linux-fsdevel+bounces-3518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD177F5D9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 12:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D60B1C209E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7904522F07;
	Thu, 23 Nov 2023 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYixm94i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE30719D
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 03:20:24 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-586beb5e6a7so408920eaf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 03:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700738424; x=1701343224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rULr9IU0pwjBoWw067yVttY4k+APUsqWmx0KwQCKrE=;
        b=gYixm94iOG3NSkdxpqKeUSjPNOqg5rNbCFVyfsoBTtMABxPYZt86aOVCOHRjX0Va7J
         2wx4XWYJRPRePBS8Cs46O/8QaulrJiTo/iPU4427jHDhK5E7mp9POhDaI06u4F0F/IZi
         xz85mkv4ndfhEEEZsZqW1Qavx8/6auI32VMHCAwHHFE5r7BOMfvpf+qmqVRzrS7gXIvv
         dqIUBZ5IyxF5Tn5iXIL7rPXLmreK63zoCqTT7Yu90YzXPitrzwwMh0aFFQd5ZXAPRYNo
         jgb8ueV5rXRYmxALBD8kqIoHgcsv60hOYU8/shEm2uK6vl2ls4SFnD4Q6xnykEN2t7SK
         +pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700738424; x=1701343224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rULr9IU0pwjBoWw067yVttY4k+APUsqWmx0KwQCKrE=;
        b=i8EHELA9yBBbYou8G5+JvX90x/g/WnAGBfi/yWQtiO/jJ3BKWoIhJyK/GVfJ6h3Tlh
         S9hnt/IzlLrwXYIs5GUUST/fpPZXT7/a1pzaWN5U5qXiZOHYrqcYzgILgXYOMacrCkx2
         Zuxy9akshLPOOEzjPC9733vDRnrQqZx4XP2f6B7TeQtnXvr1hVwdfUb6dpQz8FCyDQcU
         q4toUy4y32rN61cwbABofH7RJ4zetEYhciIv26dqNdQuHLOOxIDDQHT0QUKU3rQ2reIj
         2+SnIrD0cvuulZx+xyMSlwS4qqvAyS43IguZ7LakF8cGvgwFsboocT4IRl8Dxkq15C/p
         jEmQ==
X-Gm-Message-State: AOJu0YxQ74vu7reTX7Xg3NapFfQVjJUgVL4H1eQHzp2ppsmg9EVJF0fk
	evXlJ9mKn7m999du3yuyrK6OIQrO6WodscMo0veajGjtECU=
X-Google-Smtp-Source: AGHT+IEWZkOpqfyHjsiMB9K4jBOO7nES74M0YTkyqxSmbDSARxQVJ5/x3flnWZY6WxQM8fKk5cj/+xqOu+YqrBpIgsQ=
X-Received: by 2002:a05:6358:11cd:b0:16d:fedb:850b with SMTP id
 i13-20020a05635811cd00b0016dfedb850bmr5936623rwl.32.1700738423931; Thu, 23
 Nov 2023 03:20:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122122715.2561213-1-amir73il@gmail.com> <20231122122715.2561213-6-amir73il@gmail.com>
 <ZV8Dk7UOLejEhzQN@infradead.org>
In-Reply-To: <ZV8Dk7UOLejEhzQN@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 23 Nov 2023 13:20:13 +0200
Message-ID: <CAOQ4uxhxG_G6pjVTikakuUpru1XfaJoKWs4+HwNxCE5PxGTq_Q@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] splice: remove permission hook from iter_file_splice_write()
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 9:47=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> > +ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from,
> > +                         loff_t *pos);
> > +ssize_t do_iter_writev(struct file *file, struct iov_iter *iter, loff_=
t *ppos,
> > +                    rwf_t flags);
>
> So I first stumbled on the name because I kinda hate do_* functions,
> especially if they are not static, and then went down a little rathole:
>
>
>  - first obviously the name, based on the other functions it probably
>    should be in the __kernel_* namespace unless I'm missing something.

Not sure about the best name.
I just derived the name from do_iter_readv_writev(), which would be the
name of this helper if we split up do_iter_readv_writev() as you suggested.

>  - second can you add a little comment when it is to be used?  Our
>    maze of read and write helpers is becoming a little too confusing
>    even for someone who thought he knew the code (and wrote some if it).

I could try, but I can't say that I know how to document the maze.
I was trying to make small changes that make the maze a bit
more consistent - after my series, in most cases we have:
 vfs_XXX()
    rw_verify_area()
    file_start_write()
    do_XXX()

But obviously, there is still a wide variety of do_* helpers
with different conventions.

>  - can we just split do_iter_readv_writev instead of adding a wrapper
>    Yes, that'll duplicate a little boiler plate code, but it'll make
>    things much easier to follow.
> (- same probably for do_loop_readv_writev, although not directly
>    relevant to this series)
>

We can do that, it's easy, but I also got opposite comments from
Christian about opportunities to factor out more common code, so
I will do it if there is consensus.

Thanks,
Amir.

