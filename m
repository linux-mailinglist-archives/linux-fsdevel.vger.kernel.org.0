Return-Path: <linux-fsdevel+bounces-3516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8177F59BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 09:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394582814D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 08:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B4718E0B;
	Thu, 23 Nov 2023 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRA19sqb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537D6DD
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 00:04:28 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-421ae930545so3271661cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 00:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700726667; x=1701331467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3/BYo7dEv4hiyWRyVC4X5rhvIlJIpapIM13sv7UPRI=;
        b=fRA19sqbook0xFKJ/znucROphbc4+m97qgqu4wbwR/uzxOZUXba1sSz3J5VD893ULi
         VnM1D99/KmQbq1W2T/PINQYZjgGZJdX3eieI6MBtw9KlNPRN2CVnWxUxOk4qPILRkpI7
         suq0pjRaBLuRcfyNOnq5vFzDyUNz7uefFeKqbKwxkl8XTWUoVwoYF8L42Ig0OAVAxj8K
         ASqVxFQFM0WyhaGhnAyY40rjbgbvkm/9oEr19nwKUnSsbvxZhGNYBu1PFgubMinJdkVD
         RSsYAaXE4y2ptzoXYWAp1uVV4NOb/dKSb+CUEbBuV6qXBL123lVkflncHrx7+dPWFKXO
         sPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700726667; x=1701331467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3/BYo7dEv4hiyWRyVC4X5rhvIlJIpapIM13sv7UPRI=;
        b=NPal/30frgfjaTSccN++Oq036tphrf5lQ3+vx0o/UFUYzLSF/lYgsTdagoYQNP663L
         lU++/nN/NK9R3FklP2ZsTwbV4MFiMTjNYVck/8b0ib5TW3RrSQFyJcAnGajWG3S5Rqpf
         rT0pPYr42H3tgFugcTX7ZN9S9Qu2hDc3CytpJ4Io5zEYoa0dL+hEQRgeKnr0OuZYVwbu
         52vPlpCJsLeafPuDxnxHuJdMVHaj/foUuKaKjI6rfqg5srGK+jvgxlTshiiWMBiM62l4
         3Spb2RhW6zpFB5IGWHCuS9v4D7tQqdeelv4ryHXBXpaSM5455IOu+XR8iPRp86OqtwMa
         M5rQ==
X-Gm-Message-State: AOJu0YwSdohNXlzRUPfXC0pgf6vjMCzyQ3NoSzXa7nzhNwDz4HWdlUEe
	jk/3lJNntBpOVrJ6P8NZGWrPZY1xUYuRcrN/En/qdtY6
X-Google-Smtp-Source: AGHT+IERvwIugbKtH5d1HtfREm+HSBdtW6Fe+M/L+8I1NQ325YLnKhFwzlgyV7I8vnkT43nzhqAzw7bx/NEntpnUW5E=
X-Received: by 2002:ac8:4e89:0:b0:41e:2c5b:c795 with SMTP id
 9-20020ac84e89000000b0041e2c5bc795mr6545696qtp.58.1700726667449; Thu, 23 Nov
 2023 00:04:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122122715.2561213-1-amir73il@gmail.com> <20231122122715.2561213-11-amir73il@gmail.com>
 <ZV8ETIpM+wZa33B5@infradead.org>
In-Reply-To: <ZV8ETIpM+wZa33B5@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 23 Nov 2023 10:04:15 +0200
Message-ID: <CAOQ4uxiz8KbZRwqtiBpjrmiQDx+PKOL+ZiUPUxWPC3-7cYn2LQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] fs: move file_start_write() into vfs_iter_write()
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 9:50=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Nov 22, 2023 at 02:27:09PM +0200, Amir Goldstein wrote:
> > All the callers of vfs_iter_write() call file_start_write() just before
> > calling vfs_iter_write() except for target_core_file's fd_do_rw().
>
> Can you add a patch to first add it to fd_do_rw?  While this crates a
> bit of churn, it has two benefits:
>
>  - it gives us an easily backportable fix
>  - it makes this patch a transformation that doesn't change behavior.
>
> Please also cc the scsi and target lists.  It probably makes sense to
> even expedite it and send it for 6.7-rc inclusion separately.
> be a 6.7 candidate

Good idea. will do!

Thanks for the review!
Amir.

