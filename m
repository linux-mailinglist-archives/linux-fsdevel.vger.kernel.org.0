Return-Path: <linux-fsdevel+bounces-3433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0414C7F4883
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 15:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F65281451
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 14:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96F44AF9C;
	Wed, 22 Nov 2023 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="M0WY5dUd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B49B83
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 06:06:13 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5cc66213a34so7434917b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 06:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700661972; x=1701266772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H6701hgOENSi/E2aYtnNkwDI/ushw4ZO8npZgV/o3Xc=;
        b=M0WY5dUdAPGsvAgw9tY9BlAix1P5zV99LYb6lHyXYzd73UKdNhngyOTq2YX/aaOH3M
         NDky97bkburZ5nlm+WAoi78Um5AYbJsl6BmRuHk0OSIYaVp/rsqlis7xzRLX3bDJDkPD
         SVX2pisj5JqMK4xCeCtOP2YnKfKZds87nTdk50ByjQRGQUsQoTV1HXeHAFoanQvt/RzX
         u5WQm0WUJ3xFI2x4PcuBjxiwJVu2yYTYmGk06Ahc175KEHkzVPCktX2QFuou9gkn00aS
         K+I0dfUKmhg/RVd7mP8QcpGUPvxHz+Zgg70/egiVB/9uYCCppIhPdFlmFQM8oB1+nuZe
         ZeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700661972; x=1701266772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6701hgOENSi/E2aYtnNkwDI/ushw4ZO8npZgV/o3Xc=;
        b=OGPUGbIRl08Nx2iFC1FjK57xfXaVITw4sC7gdahyLYjJzUE+b8hB2FtkX9pUhiq9/O
         /GAxK0r+5rKQf5jeZO1FFmQIFvgJ14McjGP2uX/OgP87+IDALny6bv2bMGmFslp64oge
         R3bbLwH/DSrbTWkERcY+F7q0pc+G+Q3EWsnoZmbLIGDZj0y3172IJ2cZr593CwmmTKUO
         vYthPv2sM47oAHmU9rzcfwTHq2q2dDj5N9eHZyYc326E4/FUFQJNPM3MKKPtDXo8RV4y
         p7z4LXLmJ6zAm3MDXcHeCtr6b5OG6BfstADaPMdbf32maW2sBlEt673FHrCqjNSD0AMA
         mJ3A==
X-Gm-Message-State: AOJu0YyxrP/kPnaSxR1dBw4e04pd+TK2XLbKcHLbZsheDGKgc2Xuc511
	+qafFsxJ0Qn+gnjIWUj/xB1R8A==
X-Google-Smtp-Source: AGHT+IFqnU+v004x8v9H91M2hgpcrogmC40br5dsXqN/35tcJxoTpO53h8+hh+XJozDsCDTfcsnYAg==
X-Received: by 2002:a81:8484:0:b0:5ca:e2d4:623a with SMTP id u126-20020a818484000000b005cae2d4623amr2571096ywf.12.1700661972461;
        Wed, 22 Nov 2023 06:06:12 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m2-20020a819c02000000b0057a44e20fb8sm3696793ywa.73.2023.11.22.06.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:06:11 -0800 (PST)
Date: Wed, 22 Nov 2023 09:06:11 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/16] Tidy up file permission hooks
Message-ID: <20231122140611.GB1733890@perftesting>
References: <20231122122715.2561213-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122715.2561213-1-amir73il@gmail.com>

On Wed, Nov 22, 2023 at 02:26:59PM +0200, Amir Goldstein wrote:
> Hi Christian,
> 
> During my work on fanotify "pre content" events [1], Jan and I noticed
> some inconsistencies in the call sites of security_file_permission()
> hooks inside rw_verify_area() and remap_verify_area().
> 
> The majority of call sites are before file_start_write(), which is how
> we want them to be for fanotify "pre content" events.
> 
> For splice code, there are many duplicate calls to rw_verify_area()
> for the entire range as well as for partial ranges inside iterator.
> 
> This cleanup series, mostly following Jan's suggestions, moves all
> the security_file_permission() hooks before file_start_write() and
> eliminates duplicate permission hook calls in the same call chain.
> 
> The last 3 patches are helpers that I used in fanotify patches to
> assert that permission hooks are called with expected locking scope.
> 
> Please stage this work on a stable branch in the vfs tree, so that
> I will be able to send Jan fanotify patches for "pre content" events
> based on the stable vfs branch.
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

To the rest of the patches that don't already have my reviewed-by.  Thanks,

Josef

