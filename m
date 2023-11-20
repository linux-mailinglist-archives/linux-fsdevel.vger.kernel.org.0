Return-Path: <linux-fsdevel+bounces-3207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133237F1568
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 15:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E621C2182C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 14:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9801C295;
	Mon, 20 Nov 2023 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="cJPgdDl8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458921AD
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 06:13:18 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-6707401e22eso12213596d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 06:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1700489597; x=1701094397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaJIHjU9SSeB8VcTt1z8khmVq3zeeiMFdMXhhYmjcTQ=;
        b=cJPgdDl8eMMX7C/rLHTag7dgxagaQlv37uJQpI2t/TNavkbbp07WzGUL1gDRR0EAm1
         k4ktIZ9TlYdeFhKGoCtS9M9SqKoinzo1uVYAStqNKZhyerAcL1xE5jYSmmbtwdDauwqD
         DG/6RdIfOdEAB8UGvuM6Kpixm190Gp+7Rw6iMFJiaeOqVwu7zRowPkbucCtBN0zqBdPM
         wA6o6MuJgaiv4k/DfTyawn+y9DOobDP9tyXPT6xjByXV1DanB/MSVr1HpDmf4mC1wMfR
         p63C4vnz18jDqADr9pYghaEOXetLlCDvA0rTOTPLSBoNBKqtDU9ZtUlXjGHd5ZPwAmSU
         dozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700489597; x=1701094397;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KaJIHjU9SSeB8VcTt1z8khmVq3zeeiMFdMXhhYmjcTQ=;
        b=hW1pc2hFqe8QUzew+7aBA0v52Z4imx6MDy5troBgB9itWPRCUZ8JMiS4bGny187bwi
         us+HYivWTh9RP8V3W9KqyVLah4I3gSc6hfjkU9/h0+0ey+Y0COjjS9WcM5VeeAYAHLBD
         IN5E05J/i6Q8xtlRQZV3GkjWA7l/IVRGonQYPD7F2lN4vl5+UOYjTK81MNweaBUFDyTg
         k6mHCX9TB5dkFQ7IzhKWrEqvfm255O5zq/eUD/PXhS3fftj+P9aYAKyKuRgiLjva6hR5
         ri3rV3lu6oRQXFXtnzFT3eRMHA09iqeN/s3lWqi8nHSC4ohSY6jLePDpR33RxW1vuX39
         hHXg==
X-Gm-Message-State: AOJu0YwpG3GL/NNXtbsUvV1dVqVUL1nR1xULp+GpaXURsuApGvAadGel
	bgf3bdnEScWt0CGtAAmBJJEldA==
X-Google-Smtp-Source: AGHT+IEWgPSNRnnsRGsQIaT+S608gqcpptqMQ8i1PWXm/5WM9u45Z5TI7rtV5TValTqRdLVyBQBdkw==
X-Received: by 2002:a0c:e4ca:0:b0:66d:49aa:6844 with SMTP id g10-20020a0ce4ca000000b0066d49aa6844mr8445982qvm.19.1700489597101;
        Mon, 20 Nov 2023 06:13:17 -0800 (PST)
Received: from cs.cmu.edu (tunnel29655-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:582::2])
        by smtp.gmail.com with ESMTPSA id jy23-20020a0562142b5700b00679d8c2a6fasm948782qvb.64.2023.11.20.06.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 06:13:16 -0800 (PST)
Date: Mon, 20 Nov 2023 09:13:14 -0500
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] coda: change locking order in coda_file_write_iter()
Message-ID: <20231120141314.soxwn4zuh57ktuxk@cs.cmu.edu>
Mail-Followup-To: Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
References: <20231120095110.2199218-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120095110.2199218-1-amir73il@gmail.com>

On Mon, Nov 20, 2023 at 11:51:10AM +0200, Amir Goldstein wrote:
> The coda host file is a backing file for the coda inode on a different
> filesystem than the coda inode.
> 
> Change the locking order to take the coda inode lock before taking
> the backing host file freeze protection, same as in ovl_write_iter()
> and in network filesystems that use cachefiles.
> 
> Link: https://lore.kernel.org/r/CAOQ4uxjcnwuF1gMxe64WLODGA_MyAy8x-DtqkCUxqVQKk3Xbng@mail.gmail.com/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Acked-by: Jan Harkes <jaharkes@cs.cmu.edu

Looks good, it makes sense to use the same lock ordering as the other
file systems. Thanks for pushing this along.

Jan

