Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A28C2A556F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 22:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388864AbgKCVSC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 16:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388825AbgKCVR7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:17:59 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46150C0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 13:17:53 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id p15so20673252ljj.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 13:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jasiak-xyz.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tstgg3vKoiDwsRipOpBFOIS+Y4+ArIdAGlRHw0sw9m8=;
        b=yERDrGyWs9LQaBc8vwTXKGtVCnBlE3wL/3bg3Dmyy7QT/M5SwRSfUaUTdKWJWntjLe
         Ro9kg3N03rypCKnbDYXnxiEfcYaQsF+tSx4fMNuwNIukZx0ukRnVS+me/VvpwUZzAyP0
         aQDKbrr7bji2ltGAkv/GpzEZAMLt4TLueRLRsFG317F8qiLMp2XYHiSgRFV9d7fIn351
         XnH+n3l3CNcyOUKizAzFS/PvmfyeacEAhaKKJymK+Us5UPAaPsloMulN4Thzoren2M29
         bhAMTyFwhEby/wO/cZFX+gwoTksjDZ+yLcCv5edSuzUwpgitb3TzbFSMspWpuzDeCBa+
         dxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tstgg3vKoiDwsRipOpBFOIS+Y4+ArIdAGlRHw0sw9m8=;
        b=nArzAX1xZPi7cs8SUgxIYxAt673kcb1DEJY5yESzcaKM4WhCXKPr352CXx4xW8k9pi
         T1xGdYDqNVzbyzSAt/mFyxQXt605Y8nmszhQr+S4hhMY7W3WV6vjRxWnwEOep2Plr0kP
         Zw9MCLwGJeooFlllRHy0LmdGH7nXCqM9fI3j19bL3Sd81BX6cPitS68i75czdAG2TwyQ
         wTYOJ3IERclSaYRtemObshJ1BRuJ3xmMAtnhljT8fRIBozmrYW6F0IbddRFJx9e0W69h
         8DAakWt94ZiTC1kazZAuYU4Qlq2vi5cnVwJXHNZXcCwjERWKIMYfUOL8wQwMmyA68hjt
         lMUQ==
X-Gm-Message-State: AOAM5331gkI4T05kgkWxw0seR3bpuJfydxHSR1FGgss/yhIm3WitLKor
        sCFbbOXbS65tuYDEmC4OamoduA==
X-Google-Smtp-Source: ABdhPJy+wuMCdOzonwK9ZUMWakHw+7Idzq8eUv964AirLZNn3GMX/fDHIgH3xkMOd07Gtao35i3YCg==
X-Received: by 2002:a2e:b0cc:: with SMTP id g12mr10210749ljl.403.1604438271390;
        Tue, 03 Nov 2020 13:17:51 -0800 (PST)
Received: from gmail.com (wireless-nat-78.ip4.greenlan.pl. [185.56.211.78])
        by smtp.gmail.com with ESMTPSA id f78sm4271820lfd.271.2020.11.03.13.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 13:17:50 -0800 (PST)
Date:   Tue, 3 Nov 2020 22:17:47 +0100
From:   =?utf-8?B?UGF3ZcWC?= Jasiak <pawel@jasiak.xyz>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: PROBLEM: fanotify_mark EFAULT on x86
Message-ID: <20201103211747.GA3688@gmail.com>
References: <20201101212738.GA16924@gmail.com>
 <20201102122638.GB23988@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201102122638.GB23988@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I have written small patch that fixes problem for me and doesn't break
x86_64.

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 3e01d8f2ab90..cf0b97309975 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1285,12 +1285,27 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	return ret;
 }
 
+#if defined(CONFIG_X86) && !defined(CONFIG_64BIT)
+SYSCALL_DEFINE6(fanotify_mark,
+			int, fanotify_fd, unsigned int, flags, __u32, mask0,
+			__u32, mask1, int, dfd, const char  __user *, pathname)
+{
+	return do_fanotify_mark(fanotify_fd, flags,
+#ifdef __BIG_ENDIAN
+				((__u64)mask0 << 32) | mask1,
+#else
+				((__u64)mask1 << 32) | mask0,
+#endif
+				 dfd, pathname);
+}
+#else
 SYSCALL_DEFINE5(fanotify_mark, int, fanotify_fd, unsigned int, flags,
 			      __u64, mask, int, dfd,
 			      const char  __user *, pathname)
 {
 	return do_fanotify_mark(fanotify_fd, flags, mask, dfd, pathname);
 }
+#endif
 
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE6(fanotify_mark,


-- 

Paweł Jasiak
