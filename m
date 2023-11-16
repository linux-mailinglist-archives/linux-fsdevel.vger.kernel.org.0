Return-Path: <linux-fsdevel+bounces-2926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1187ED8B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 01:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E4E1F22BFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 00:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A5610E2;
	Thu, 16 Nov 2023 00:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZWZUX9E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47A8AF
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 16:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700096014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znt6kEL0rTUQG3De++r9zy5xy/7x4dgf5LbcuRAX3hc=;
	b=UZWZUX9EvANAqk+M61s1rrx/Ma4rZgh2sikc5mvtAmOKJ+cUrD1JUalgcJCCrfeL0A0NDT
	N1Wh/83T56601L9tYZhTCEIje6bkiPymztVdQM5t4tVeNbZh0ciRO/+XUIb5iY05sS684g
	sOch9QiMtDNsbVMA/RLGzvX0fcKrlZQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-ZhWNqwg-OQeEYP8nJZrnXg-1; Wed, 15 Nov 2023 19:53:33 -0500
X-MC-Unique: ZhWNqwg-OQeEYP8nJZrnXg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-66fd88c39f6so694006d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 16:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700096013; x=1700700813;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=znt6kEL0rTUQG3De++r9zy5xy/7x4dgf5LbcuRAX3hc=;
        b=L1TqKcOx/+KkWfy3c6CT0t+T+lq+7/RAkVgE0gTU+9L9Wt/qGSohFggbxyRVTm8CeX
         NBLpvkTaq8mxXEtKcW4ooIvLi8O5FtnfVj28hYL60ZylFT77sDnh4xE1DmxMv/jnfSy8
         EaJnk+uA9RXOQPD+rXnY5eLlTg5/0TXbU+Q5j0v5BmkN6C92eVBI4F2bHLMmkeREjhAo
         QvobDb2i6iwHqIi9ugl7Po8rvfz1hJz5MrdFw9+Y1f0nFNyyMNVLEqnwty8cCAyqRvz8
         aSOFOqbtusTMFp9SLIRcGsAjrRTvyklcKy4b4D1NAIlsQB0ek8wugmqe0cHRMF94AJgg
         gmlw==
X-Gm-Message-State: AOJu0YyrbMR/GpxUriE+jyrHXA07V5k6E50emZTJ9UKuGmR9EXjXKRC6
	cCHU1iFwoeiI4nuaPu6vkBH6N+yfSc2IqYa50MzXQCCR839SHKv1UDfbjjZnZqY4i/qJvIk+FNu
	WJqT4U5RBQuDNT7SKa5VgcPzv1Q==
X-Received: by 2002:a05:620a:1aa2:b0:77b:c622:e7fc with SMTP id bl34-20020a05620a1aa200b0077bc622e7fcmr7642451qkb.2.1700096012834;
        Wed, 15 Nov 2023 16:53:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2NYf9tfqb13m+SGN+0ipXdZK7klLe3TXnh3/9Hu+vqbKl87Ld8Jjamc9hsVTCcRocOMnLcA==
X-Received: by 2002:a05:620a:1aa2:b0:77b:c622:e7fc with SMTP id bl34-20020a05620a1aa200b0077bc622e7fcmr7642438qkb.2.1700096012542;
        Wed, 15 Nov 2023 16:53:32 -0800 (PST)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id h7-20020a05620a400700b00767e2668536sm3882456qko.17.2023.11.15.16.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 16:53:31 -0800 (PST)
Date: Wed, 15 Nov 2023 19:53:29 -0500
From: Peter Xu <peterx@redhat.com>
To: Andrei Vagin <avagin@gmail.com>
Cc: syzbot <syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com>,
	Muhammad Usama Anjum <musamaanjum@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING in pagemap_scan_pmd_entry
Message-ID: <ZVVoCT_gNvbZg93f@x1n>
References: <000000000000773fa7060a31e2cc@google.com>
 <CANaxB-yrvmv134dwTcMD9q5chXvm3YU1pDFhqvaRA8M1Gn7Guw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANaxB-yrvmv134dwTcMD9q5chXvm3YU1pDFhqvaRA8M1Gn7Guw@mail.gmail.com>

Hi, Andrei, Muhammad,

I had a look (as it triggered the guard I added before..), and I think I
know what happened.  So far I think it's a question to the new ioctl()
interface, which I'd like to double check with you all.  See below.

On Wed, Nov 15, 2023 at 01:07:18PM -0800, Andrei Vagin wrote:
> Cc: Peter and Muhammad
> 
> On Wed, Nov 15, 2023 at 6:41 AM syzbot
> <syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    c42d9eeef8e5 Merge tag 'hardening-v6.7-rc2' of git://git.k..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=13626650e80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=84217b7fc4acdc59
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e94c5aaf7890901ebf9b
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d73be0e80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13670da8e80000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/a595d90eb9af/disk-c42d9eee.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/c1e726fedb94/vmlinux-c42d9eee.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/cb43ae262d09/bzImage-c42d9eee.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 5071 at arch/x86/include/asm/pgtable.h:403 pte_uffd_wp arch/x86/include/asm/pgtable.h:403 [inline]

This is the guard I added to detect writable bit set even if uffd-wp bit is
not yet cleared.  It means something obviously wrong happened.

Here afaict the wrong thing is ioctl(PAGEMAP_SCAN) allows applying uffd-wp
bit to VMA that is not even registered with userfault.  Then what happened
is when the page is written, do_wp_page() will try to reuse the anonymous
page with the uffd-wp bit set, set W bit on top of it.

Below change works for me:

===8<===
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ef2eb12906da..8a2500fa4580 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1987,6 +1987,12 @@ static int pagemap_scan_test_walk(unsigned long start, unsigned long end,
                vma_category |= PAGE_IS_WPALLOWED;
        else if (p->arg.flags & PM_SCAN_CHECK_WPASYNC)
                return -EPERM;
+       else
+               /*
+                * Neither has the VMA enabled WP tracking, nor does the
+                * user want to explicit fail the walk.  Skip the vma.
+                */
+               return 1;

        if (vma->vm_flags & VM_PFNMAP)
                return 1;
===8<===

This is based on my reading of the pagemap scan flags:

- Write-protect the pages. The ``PM_SCAN_WP_MATCHING`` is used to write-protect
  the pages of interest. The ``PM_SCAN_CHECK_WPASYNC`` aborts the operation if
  non-Async Write Protected pages are found. The ``PM_SCAN_WP_MATCHING`` can be
  used with or without ``PM_SCAN_CHECK_WPASYNC``.

If PM_SCAN_CHECK_WPASYNC is used to enforce the check, we need to skip the
vma that is not registered properly.  Does it look reasonable to you?

Thanks,

-- 
Peter Xu


