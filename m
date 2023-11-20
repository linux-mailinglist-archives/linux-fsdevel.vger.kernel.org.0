Return-Path: <linux-fsdevel+bounces-3220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DCB7F1931
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 17:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EA91C20E01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 16:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9719D1EA80;
	Mon, 20 Nov 2023 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="TDqV3LV6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C84BA
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 08:56:48 -0800 (PST)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-5ca11922cedso14706137b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 08:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700499408; x=1701104208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lOguIldRpkdTawCTamAEhD2rt/fXW3S/2Xw+kQ0Kr24=;
        b=TDqV3LV6Fa4oblEi+SJ2OaklVas82mw5BKFlBTWcM0dt39yrPbVj90vpr0FgG+G1tw
         ptpTYdKQgwsUKdPbM341S/DjAs4leIEoUcCfIWv+qmSOzRs8jmaLpqxaFIkeGGhY/mpR
         65MsA9J7Fk1ORLTrC208nRlMWKGgJPLTNwE2abR6QU2fjXtu9ZPZ8c2yxpNuFlvzSsch
         wZ37/A/o0ofFzsU3Kho2HJp1gosivna15WgCe5KKt1VoZxAO2rrHZEM3RtGfeW/terqQ
         8G0NaO53XHtHMW7IkZiUWVSOBjPqu6Keh+Gz2Sy8ROMHCx+42IMtJ6VWbXR4cSZqHjCe
         A1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700499408; x=1701104208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOguIldRpkdTawCTamAEhD2rt/fXW3S/2Xw+kQ0Kr24=;
        b=Lb2jfwI1xRKadhj6PAFIr1Wn/s55pjNy0WHFNnmdFcmHptmVuxbjYI5jplz8MB3JUl
         s7FKKf+JMnQ0Frxx87oizuL5Ms0lnkwzAtS2BTULu6H9mqPVv+8JjESPjnboTCW8ANOZ
         ILmfRkyS7DdyJIQliSlMKAjuBabyRaJEFrU7Pfzte+0mErqeAIEXgq441a8AwZs2i95T
         LnQz3fi0OeKAtMTRM5s2nNwAu5GufakRIzJYk4nVN7I2bAwRYUa4WaDt++MnbIv4o3LF
         0E1I2Yj/lZfr89gkEyZf12RRXuO4rUgcBK9ZYxRnB9kcR5VYGR9QPuKvwbtqKG5XLiCS
         Y0Ag==
X-Gm-Message-State: AOJu0YzKcUybOq7d8bTiQKFEaz33gBOW7t2nLxPpszPxOyaw8f2rwoZc
	u/YjuqcBZjp//kY9S0Y6RYF5Xg==
X-Google-Smtp-Source: AGHT+IEP3sannweYPpYCyQyhD1arupb6+H2pFWukzNktYUqp3smpsBR1D35VuBCtUei32Xstw7CCqQ==
X-Received: by 2002:a0d:d3c6:0:b0:5c4:3896:7763 with SMTP id v189-20020a0dd3c6000000b005c438967763mr8093224ywd.44.1700499407984;
        Mon, 20 Nov 2023 08:56:47 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q28-20020a81431c000000b005cb5ab4093esm40608ywa.38.2023.11.20.08.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 08:56:47 -0800 (PST)
Date: Mon, 20 Nov 2023 11:56:46 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] cachefiles: move kiocb_start_write() after error
 injection
Message-ID: <20231120165646.GA1606827@perftesting>
References: <20231120101424.2201480-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120101424.2201480-1-amir73il@gmail.com>

On Mon, Nov 20, 2023 at 12:14:24PM +0200, Amir Goldstein wrote:
> We want to move kiocb_start_write() into vfs_iocb_iter_write(), but
> first we need to move it passed cachefiles_inject_write_error() and
> prevent calling kiocb_end_write() if error was injected.
> 
> We set the IOCB_WRITE flag after cachefiles_inject_write_error()
> and use it as indication that kiocb_start_write() was called in the
> cleanup/completion handler.
> 
> Link: https://lore.kernel.org/r/CAOQ4uxihfJJRxxUhAmOwtD97Lg8PL8RgXw88rH1UfEeP8AtP+w@mail.gmail.com/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Sorry Amir I meant to respond on Saturday but I got busy with other things.

I was thinking instead, for your series, you could do something like

ret = cachefiles_inject_write_error();
if (ret) {
	/* Start kiocb so the error handling is done below. */
	kiocb_start_write(&ki->iocb);
} else {
	ret = vfs_iocb_iter_write(file, &ki->iocb, iter);
}

which seems a bit cleaner than messing with the flags everywhere.  Thanks,

Josef

