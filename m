Return-Path: <linux-fsdevel+bounces-11843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0677D857B09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 12:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382541C23BD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 11:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7302960EC4;
	Fri, 16 Feb 2024 11:04:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFC4605C1
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081446; cv=none; b=URnaK8oAb8BI/0h0e97JFQksV+J/AZ2KnvXV83zExoXElepN94FIkv5V5oqlTQ9NPwo5W28w1bOWakjlRdnBayzgajV4dPS6+JJZ8Dacl078qQZ5UtLjHPFoSEB/Vpytq5Hde07Njjo8TsHntxNTf6M2mOCqRI6gzhEFByAY23M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081446; c=relaxed/simple;
	bh=3z+cACuJgwrm2g97vXLsOwdGUgc/7jvhxzG7AHx+CCs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Cl2DXac0lS3GTtPXNmE5KI8zPX6OlApA2f3EK5cbz+wyAc39fHIocu8uITaYLKWaj4kXX+5tcpo05aQN8vgzL/w+LGuFguZbI9a+lw9aPYUHqcpjuRYRJfPgdxas1R0VCGNX3buE0+XiVSEVvrUfkN2FcMCwZEGJanj2wc+14c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363dfc1a546so16543905ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 03:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708081443; x=1708686243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypVqCIOJZ52Xu4aOA0DIn5jJ2/opLAVYWZUXa94QqUA=;
        b=jzA+g1k9H+uLC0uFxls8PFRaZ8b41rqWLNv4mS19RyPtqb6CbDvTN+sXEflMCbxasH
         eKO/s4UPAIb+/bGfH4jzc9+4iPooQR7udWpoMecaceELScRNtH+D5p4EUBmIrTjvZgvS
         YWILBiEhXYOj9m1qOgEz9KiSndlKW1c78NCiPp3NcUybeYrLWIkDHzLD7qbsyhPMH2Fq
         E3RFqVlKKIbbcBLhazcSNtgTREV9LKRIHNtK+Nte8T5GmPTLjFhp7nn720Mm+gMl0o74
         vGJDJTSOBqKMkLQ5oc/S5/5OyfHKwudOEiiGa3JWOVuuTOMWJkLA46Uh86T7+RVfn04k
         7zkg==
X-Forwarded-Encrypted: i=1; AJvYcCUUrWjLbgaIV/ygc55URGuJnTbeU3YDiUDNlZYap3awjsFEkWJ6Hl8EQcvN/0t/XDzbSpvXNGsKF50nSnuwNQgpTGnxSjQPm6tHoFP4uw==
X-Gm-Message-State: AOJu0Yx1JDMaPxfndZxJk8wP6E9xe7JWyNcfTfd07AnxFIgqzDEzi3xN
	S8eh9U4iEdux+5DGK7aYUbyDvdNu0VbpxHL8I+BK4UvsBq1TqiBhJWc619TQRYj10stveruHktD
	iGmvJd07OcuDG/NaJDwEViHtwZOcSltqoXXwx+khFTZfUULhuKM1qAGc=
X-Google-Smtp-Source: AGHT+IGJm+ewU1e2CVFn+hNGp66J+fYZUf+uAm7AOOrtD6bx6RwPNZcTEl61vzIwznH08Wu0TM96LcEHw8jgbtXgF+y72+FCdmNU
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c89:b0:363:e795:df5 with SMTP id
 w9-20020a056e021c8900b00363e7950df5mr331278ill.0.1708081443528; Fri, 16 Feb
 2024 03:04:03 -0800 (PST)
Date: Fri, 16 Feb 2024 03:04:03 -0800
In-Reply-To: <0000000000001f905c0604837659@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b06c9e06117db32b@google.com>
Subject: Re: [syzbot] [gfs2?] INFO: task hung in write_cache_pages (3)
From: syzbot <syzbot+4fcffdd85e518af6f129@syzkaller.appspotmail.com>
To: agruenba@redhat.com, akpm@linux-foundation.org, anprice@redhat.com, 
	axboe@kernel.dk, brauner@kernel.org, cluster-devel@redhat.com, 
	dvyukov@google.com, elver@google.com, gfs2@lists.linux.dev, glider@google.com, 
	jack@suse.cz, kasan-dev@googlegroups.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=151b2b78180000
start commit:   92901222f83d Merge tag 'f2fs-for-6-6-rc1' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d78b3780d210e21
dashboard link: https://syzkaller.appspot.com/bug?extid=4fcffdd85e518af6f129
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17933a00680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ef7104680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

