Return-Path: <linux-fsdevel+bounces-2927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 547587ED8CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 02:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790111C20964
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 01:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540781361;
	Thu, 16 Nov 2023 01:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="DiW1nVsA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB9B192
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 17:07:56 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7788f513872so13212585a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 17:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1700096876; x=1700701676; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ks3PBWIiV94MxOqwQB5+8Db6JJTMEhrY5Td5vGNu9Ss=;
        b=DiW1nVsADuZDF8b+NIyhmPmVYUbe4H8CvzUPknqiqIyUgiqmkD1jGa/jkdXnMChJKx
         lUjT1ZpBAqwmOmAEIiMQ8mDFI1XubjzoMqNGgOKro4qCXo4PPWkvZ/JV6HR1rFIKnITp
         huDvER0n3yQQN1oG3jBuV2vYGsC91JYqlRIU2Da9H152mWMsTueKcPNGkpu7Mfs+RW9Z
         Lgpx3Raidvn4UIr4ZHaasTlDBjL8S7i21uGIJMvbixHHjhGsPp+IY+DQFOPh2YbGt3yX
         jhNw5pTtkpKUZF7d8VH+v/NjwKq7gzGto7jfh3fh/Nmqfk9ZZMAw3uZ7OX3MYpvLlWBJ
         Hr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700096876; x=1700701676;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ks3PBWIiV94MxOqwQB5+8Db6JJTMEhrY5Td5vGNu9Ss=;
        b=pR/jrisVC9w+CgmgdRHFFfPx8bzGJcd/1CrTpFQ2O8AFMtUKi7H/mH1Yh/ROCpGbrJ
         Jwv72zRZm/s2HbFYIyLgBq//xcKWM8OQrykP5bJs0uK+Z/G8BgCpkE9l/UtJktQJ71AN
         kNuip2P6u9OMf/IKcyw6Pc6eVZ301e9GQd6IgTvEqPxs1b69b3K4IyuA317gMA4P5FYr
         lFydZoNaACXPNlqqWgbliRhWVcTq9ItswlOW0xvwvdpHWIPc1eWKL7CD3Rle2TC1Tlb3
         p5RGclcJKxPxcf+iFB6UjsTzFGTSON5B/5W2b+gdm90yAILwa0YIDjsxIEr1mP7XeDwv
         rjzg==
X-Gm-Message-State: AOJu0YwwfYw8E7vIq4JiR9Td6xYHHxusMoxwraECjwuR1xAGiTRmfe9V
	OozbCp2jpkDlQT2JVQ1QXwKO3w==
X-Google-Smtp-Source: AGHT+IHQBCuV3ZHYVIXo0mYxxtYvG/z3Rp1iF7T/0KnrIuWHrzL+jfuGD8XXyjG+QorM2yf5Z6lcFA==
X-Received: by 2002:a05:620a:40c2:b0:76c:ea3f:9010 with SMTP id g2-20020a05620a40c200b0076cea3f9010mr9406602qko.16.1700096875996;
        Wed, 15 Nov 2023 17:07:55 -0800 (PST)
Received: from cs.cmu.edu (tunnel29655-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:582::2])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a14a400b0077438383a07sm3904019qkj.80.2023.11.15.17.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 17:07:55 -0800 (PST)
Date: Wed, 15 Nov 2023 20:07:53 -0500
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-unionfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 09/15] fs: move file_start_write() into vfs_iter_write()
Message-ID: <20231116010753.f3nptj4urhfcynnt@cs.cmu.edu>
Mail-Followup-To: Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-unionfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>
References: <20231114153254.1715969-1-amir73il@gmail.com>
 <20231114153254.1715969-10-amir73il@gmail.com>
 <20231114234209.f626le55r5if4fbp@cs.cmu.edu>
 <CAOQ4uxjcnwuF1gMxe64WLODGA_MyAy8x-DtqkCUxqVQKk3Xbng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjcnwuF1gMxe64WLODGA_MyAy8x-DtqkCUxqVQKk3Xbng@mail.gmail.com>

On Wed, Nov 15, 2023 at 11:01:39AM +0200, Amir Goldstein wrote:
> On Wed, Nov 15, 2023 at 1:42 AM Jan Harkes <jaharkes@cs.cmu.edu> wrote:
> >  * Since freeze protection behaves as a lock, users have to preserve
> >  * ordering of freeze protection and other filesystem locks. Generally,
> >  * freeze protection should be the outermost lock. In particular, we
> >  * have:
> >  *
> >  * sb_start_write
> >  *   -> i_mutex                 (write path, truncate, directory ops,
> >  *   ...)
> >  *   -> s_umount                (freeze_super, thaw_super)
> >
> 
> This describes the locking order within a specific fs.
> host_file is not in the same fs as code_inode.
> 
> IIUC, host_file is a sort of backing file for the code inode.
> In cases like this, as in cachefiles and overlayfs, it is best
> to order all backing fs locks strictly after all the frontend fs locks.
> See ovl_write_iter() for example.
> 
> IOW, the new lock ordering is preferred:
> file_start_write(coda_file)
>   inode_lock(code_inode)
>     file_start_write(host_file)
>       inode_lock(host_inode)

Well, if everybody else is doing it, I guess it must be ok.

Jan

